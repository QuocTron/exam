(function() {
    "use strict";

    angular.module("ExaminationSystem").factory("examService", examService);

    examService.$inject = [
        "$state",
        "$http",
        "authService",
        "notifyService",
        "blockUI",
    ];

    function examService($state, $http, authService, notifyService, blockUI) {
        var service = {
            getQuestionSheet: getQuestionSheetFn,
            getReviewQuestion: getReviewQuestionFn,
            updateAnswer: updateAnswerFn,
            getRemainingTime: getRemainingTimeFn,
            updateListenTimes: updateListenTimesFn,
            getOne_ThirdTimes: getOne_ThirdTimesFn,
        };

        return service;

        ////////////////
        function getQuestionSheetFn(questionSheetId, callback) {
            return $http.get(`/api/questionsheets/details/${questionSheetId}`).then(
                function(response) {
                    callback(true, response.data);
                },
                function(response) {
                    notifyService.error(response.data, "Thông báo");
                    callback(false, null);
                }
            );
        }

        function updateAnswerFn(
            shiftSubjectId,
            questionSheetId,
            questionId,
            answerId,
            callback
        ) {
            return $http
                .post("/api/questions/updateanswer", {
                    questionSheetId: questionSheetId,
                    questionId: questionId,
                    answerId: answerId,
                    shiftSubjectId: shiftSubjectId,
                })
                .then(
                    function(response) {
                        var status = response.data.status;
                        if (status == false) {
                            notifyService.error(response.data.message, "Thông báo");
                            callback(false);
                        } else {
                            callback(true);
                        }
                    },
                    function(response) {
                        notifyService.error(response.data, "Thông báo");
                        callback(false);
                    }
                );
        }

        function getRemainingTimeFn(questionSheetId, shiftSubjectId, callback) {
            return $http
                .get("/api/questionsheets/detail/remainningtime", {
                    params: {
                        questionSheetId: questionSheetId,
                        shiftSubjectId: shiftSubjectId,
                    },
                })
                .then(
                    function(response) {
                        callback(true, response.data);
                    },
                    function(response) {
                        notifyService.error(response.data, "Thông báo");
                        callback(false, null);
                    }
                );
        }

        function updateListenTimesFn(questionSheetId, questionId, callback) {
            return $http
                .get(
                    `/api/questions/answer/listentimes?questionSheetId=${questionSheetId}&questionId=${questionId}`
                )
                .then(
                    function(response) {
                        if (response.data.status == true) {
                            callback(true);
                        } else {
                            notifyService.info("Câu hỏi này đã nghe đủ 5 lần", "Thông báo");
                            callback(false);
                        }
                    },
                    function(response) {
                        notifyService.info("Câu hỏi này đã nghe đủ 5 lần", "Thông báo");
                        callback(false);
                    }
                );
        }

        function getReviewQuestionFn(questionSheetId, callback) {
            return $http.get(`/api/questionsheets/review/${questionSheetId}`).then(
                function(response) {
                    callback(true, response.data);
                },
                function(response) {
                    notifyService.error(response.data, "Thông báo");
                    callback(false, null);
                }
            );
        }

        function getOne_ThirdTimesFn(shiftSubjectId, callback) {
            return $http
                .get(`/api/shifts/getonethirdtime?shiftSubjectId=${shiftSubjectId}`)
                .then(
                    function(response) {
                        callback(true, response.data.one_thirdTimes);
                    },
                    function(response) {
                        callback(false, null);
                    }
                );
        }
    }
})();