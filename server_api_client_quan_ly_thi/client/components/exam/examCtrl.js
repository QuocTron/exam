(function() {
    "use strict";

    angular
        .module("ExaminationSystem")
        .controller("examCtrl", examCtrl)
        .filter("headerFilter", function() {
            return function(array, index) {
                if (!index) index = "isHeader";
                for (var i = 0; i < array.length; ++i) {
                    array[i][index] =
                        array[i].ChapterName !=
                        (i - 1 < 0 ? "NONE" : array[i - 1].ChapterName);
                }
                return array;
            };
        });

    examCtrl.$inject = [
        "$uibModal",
        "$rootScope",
        "$scope",
        "$state",
        "$localStorage",
        "authService",
        "notifyService",
        "examService",
        "infoService",
        "resultService",
        "socketService",
        "ngAudio",
        "ngAudioGlobals",
        "$sce",
        "blockUI",
    ];

    function examCtrl(
        $uibModal,
        $rootScope,
        $scope,
        $state,
        $localStorage,
        authService,
        notifyService,
        examService,
        infoService,
        resultService,
        socketService,
        ngAudio,
        ngAudioGlobals,
        $sce,
        blockUI
    ) {
        // fix audio when click outside button
        ngAudioGlobals.unlock = false;

        // One third of the time status
        $scope.one_thirdTimes_Status = false;

        $scope.examDetails = [];

        // Convert to UTC date
        var toUTCDate = function(date) {
            var _utc = new Date(
                date.getUTCFullYear(),
                date.getUTCMonth(),
                date.getUTCDate(),
                date.getUTCHours(),
                date.getUTCMinutes(),
                date.getUTCSeconds()
            );
            return _utc;
        };

        // Variable save id question playing audio
        $scope.playingAudio = null;
        $scope.playingAudioId = null;
        $scope.playingQuestion = null;

        initController();

        // scope function
        $scope.updateCurrentAnswer = updateCurrentAnswer;
        $scope.finishedExam = finishedExam;
        $scope.handleAudio = handleAudio;
        $scope.openQuestionReviewModal = openQuestionReviewModal;
        $scope.submitExam = submitExam;
        $scope.goToTop = goToTop;
        $scope.isShowChapterName = isShowChapterName;
        $scope.clickStopAudio = clickStopAudio;

        ////////////////

        function initController() {
            authService.loggedIn(function(result) {
                if (result == true) {
                    // invoke function
                    $rootScope.showHeader = true;
                    var questionSheetId = $rootScope.info.QuestionSheetId;
                    infoService.checkStarted(questionSheetId, function(status) {
                        if (!status) {
                            $state.go("info");
                        }
                    });
                    resultService.isCompleted(questionSheetId, function(status) {
                        if (status) {
                            $state.go("result");
                        } else {
                            return;
                        }
                    });
                    getQuestionSheet();
                    //get duration
                    getDuration();
                    // get one-third times from shift
                    examService.getOne_ThirdTimes(
                        $rootScope.info.ShiftId,
                        function(status, data) {
                            if (status) {
                                let one_thirdTimes = new Date(data);
                                one_thirdTimes = toUTCDate(one_thirdTimes);
                                let currentTimes = new Date();
                                let timer = one_thirdTimes - currentTimes;
                                console.log(timer);
                                setTimeout(function() {
                                    notifyService.warning(
                                        "Chỉ còn 1/3 thời gian làm bài",
                                        "Thông Báo"
                                    );
                                    $scope.one_thirdTimes_Status = true;
                                    // Jump to the sentences have not done in order from the top down
                                    // Todo
                                }, timer);
                            }
                        }
                    );
                } else {
                    authService.logout();
                }
            });
        }

        function getQuestionSheet() {
            var questionSheetId = $rootScope.info.QuestionSheetId;
            examService.getQuestionSheet(questionSheetId, function(status, data) {
                if (status) {
                    data.forEach((itemQuestion, indexParejt, data) => {
                        itemQuestion["maxLength"] = 0;
                        itemQuestion.Answers.forEach((itemAnswers, index, arr) => {
                            if (itemAnswers.Content == null) {
                                //console.log(itemAnswers.id);
                                // data.splice(indexParejt, 1);
                            } else if (
                                itemAnswers.Content.length > itemQuestion["maxLength"]
                            ) {
                                itemQuestion["maxLength"] = itemAnswers.Content.length;
                            }
                        });
                    });
                    $scope.examDetails = data;
                    console.log($scope.examDetails);
                } else {
                    return;
                }
            });
        }

        function isShowChapterName(question, preQuestionOrder) {
            //console.log($scope.examDetails);
            return (
                question.ChapterName ==
                $scope.examDetails.filter(function(item) {
                    return item.OrderQuestion === preQuestionOrder;
                })[0].ChapterName
            );
        }

        function updateCurrentAnswer(question, answer) {
            var questionSheet = $rootScope.info.QuestionSheetId;
            var shiftSubjectId = $rootScope.info.ShiftSubjectId;
            if ($localStorage.makeOffline) {
                var _questions = $localStorage.makeOffline.questions;
                _questions[question.Id] = answer.Id;
            } else {
                examService.updateAnswer(
                    shiftSubjectId,
                    questionSheet,
                    question.Id,
                    answer.Id,
                    function(status) {
                        if (status == false) {
                            question.AnswerCurrentChoose = null;
                            return;
                        }
                    }
                );
            }
        }

        function getDuration() {
            var questionSheetId = $rootScope.info.QuestionSheetId;
            var shiftSubjectId = $rootScope.info.ShiftSubjectId;
            examService.getRemainingTime(
                questionSheetId,
                shiftSubjectId,
                function(status, data) {
                    if (status) {
                        if (data <= 0) {
                            $state.go("result");
                            notifyService.info("Đã hết thời gian làm bài", "Thông báo");
                        }
                        $scope.duration = data;
                    } else {
                        return;
                    }
                }
            );
        }

        function finishedExam() {
            $rootScope.showHeader = false;
            notifyService.info("Đã hết thời gian làm bài", "Thông báo");
            $state.go("result");
        }

        function handleAudio(question) {
            // var countAudioTemp = ($('#countAudio_' + question.Id).text() == '' || $('#countAudio_' + question.Id).text() == null) ? 0 : $('#countAudio_' + question.Id).text();
            var questionSheetId = $rootScope.info.QuestionSheetId;
            var audio = ngAudio.load(question.AudioUrl[0]); //first audio

            var loopCount = 0;
            var checkLoaded = setInterval(() => {
                if (isNaN(audio.duration)) {
                    loopCount++;
                    if (loopCount > 10) {
                        //wait in 1 second
                        $("#btnAudio_" + question.Id).html(
                            '<span class="glyphicon glyphicon-headphones"></span> Failed to load audio file, try again later!'
                        );
                        clearInterval(checkLoaded);
                    }
                } else {
                    examService.updateListenTimes(
                        questionSheetId,
                        question.Id,
                        function(status) {
                            if (status) {
                                if ($scope.playingAudio != null) {
                                    stopAudio(false);
                                    $scope.playingAudio = audio;
                                    $scope.playingQuestion = question;
                                } else {
                                    // execute in first time
                                    $scope.playingAudio = audio;
                                    $scope.playingQuestion = question;
                                }
                                audio.volume = 1;
                                $("#btnAudio_" + question.Id).prop("disabled", true);
                                $scope.playingAudioId = question.Id;

                                audio.play().complete(function() {
                                    audio.stop();
                                    $("#btnAudio_" + question.Id).prop("disabled", false);
                                    $scope.playingAudioId = null;
                                    $scope.playingQuestion = null;
                                    question.ListenTimes = question.ListenTimes ?
                                        question.ListenTimes + 1 :
                                        1;
                                });
                            }
                        }
                    );
                    clearInterval(checkLoaded);
                }
            }, 100);
        } //reset so lan nghe chay lai di tuyen

        $scope.audioProgressControl = {
            get value() {
                if ($scope.playingAudio == null) return;
                return parseFloat($scope.playingAudio.progress);
            },
            set value(value) {
                if ($scope.playingAudio == null) return;
                if (Math.abs(value - parseFloat($scope.playingAudio.progress)) < 0.001)
                    return; // bugfix. this will prevent your player to get in a audio loop
                $scope.playingAudio.progress = value;
            },
        };

        function clickStopAudio(isGroup) {
            $scope.playingAudio.stop();
            $("#btnAudio_" + $scope.playingQuestion.Id).prop("disabled", false);
            $scope.playingQuestion.ListenTimes = $scope.playingQuestion.ListenTimes ?
                $scope.playingQuestion.ListenTimes + 1 :
                1;
            $scope.playingAudioId = null;
            $scope.playingQuestion = null;
        }
        // Stop audio
        function stopAudio(isGroup) {
            if ($scope.playingQuestion) {
                $scope.playingQuestion.ListenTimes = $scope.playingQuestion.ListenTimes ?
                    $scope.playingQuestion.ListenTimes + 1 :
                    1;
            }
            $scope.playingAudio.stop();
            $("#btnAudio_" + $scope.playingAudioId).prop("disabled", false);
        }

        function openQuestionReviewModal() {
            var modalInstance = $uibModal.open({
                animation: true,
                // backdrop: false,
                // keyboard: false,
                size: "lg",
                templateUrl: "../../components/exam/modal/questionReview.html",
                controller: "questionReviewModalCtrl",

                // resolve: {
                //     reviewQuestions: function () {
                //         return $scope.reviewQuestions
                //     }
                // }
            });
            modalInstance.result.then(
                function() {
                    // Success - when excuted event inside
                    // Update questions content
                    getQuestionSheet();
                },
                function() {
                    // Cancel - when click modal but do nothing
                    // Update questions content
                    getQuestionSheet();
                }
            );
        }

        function submitExam() {
            swal({
                title: "Bạn có chắc chắn nộp bài?",
                icon: "warning",
                buttons: ["Hủy", "Đồng ý"],
                successMode: true,
            }).then((willDelete) => {
                if (willDelete) {
                    $rootScope.showHeader = false;
                    $state.go("result");
                }
            });
        }

        function goToTop() {
            $("body,html").animate({
                    scrollTop: 0,
                },
                300
            );
        }

        function getTags(text) {
            let index = 0;
            let textTags = [];
            while (index < text.length) {
                if (text.charAt(index) === "<") {
                    let tagName = "";
                    let textTag = "";
                    let j = 1;
                    while (text.charAt(j + index) !== " " && j + index < text.length) {
                        tagName += text.charAt(j + index);
                        j++;
                    }
                    if (tagName === "img" || tagName === "audio" || tagName === "video") {
                        j = 0;
                        while (text.charAt(j + index) !== ">") {
                            textTag += text.charAt(j + index);
                            j++;
                        }
                        textTag += ">";
                        textTags.push(textTag);
                        index += textTag.length;
                    }
                }
                index++;
            }
            return textTags;
        }
    }
})();