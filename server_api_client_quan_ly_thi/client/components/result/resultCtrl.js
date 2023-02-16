(function() {
    "use strict";

    angular.module("ExaminationSystem").controller("resultCtrl", resultCtrl);

    resultCtrl.$inject = [
        "$rootScope",
        "$scope",
        "$state",
        "blockUI",
        "authService",
        "notifyService",
        "resultService",
    ];

    function resultCtrl(
        $rootScope,
        $scope,
        $state,
        blockUI,
        authService,
        notifyService,
        resultService
    ) {
        initController();

        $scope.signOut = signOut;

        ////////////////

        function initController() {
            authService.loggedIn(function(result) {
                if (result == true) {
                    // invoke function
                    $scope.reviewInfo = $rootScope.info;
                    $rootScope.showHeader = false;
                    var questionSheetId = $rootScope.info.QuestionSheetId;
                    getMark(questionSheetId);
                    getQuestionDifficulty(questionSheetId);
                } else {
                    authService.logout();
                }
            });
        }

        function getMark(questionSheetId) {
            resultService.getMark(questionSheetId, function(status, data) {
                if (status) {
                    $scope.resultQuestionSheet = data;
                    // convert to float with two decimal places, for ex: 1.5 or 1.0
                    var mark = parseFloat($scope.resultQuestionSheet.Mark).toFixed(2);
                    var c = document.getElementById("resultMarkCanvas");
                    var ctx = c.getContext("2d");
                    ctx.fillStyle = "red";
                    ctx.textBaseline = "top";
                    // ctx.font = "80px bold Roboto Tahoma,sans-serif";
                    ctx.font = "85px bold";
                    ctx.fillText(mark, 0, 0);
                    $scope.resultNumberCorrect =
                        $scope.resultQuestionSheet.NumberOfCorrect +
                        "/" +
                        $scope.resultQuestionSheet.Total;
                    // invoke function
                    getResult(questionSheetId);
                } else {
                    return;
                }
            });
        }

        function getQuestionDifficulty(questionSheetId) {
            resultService.updateQuestionDifficulty(questionSheetId);
        }

        function getResult(questionSheetId) {
            resultService.getResult(questionSheetId, function(status, data) {
                if (status) {
                    $scope.resultAnswerList = data;
                    //console.log($scope.resultAnswerList)
                    // invoke function
                } else {
                    return;
                }
            });
        }

        function signOut(shiftSubjectId, questionSheetId, studentId) {
            authService.signOut(
                shiftSubjectId,
                questionSheetId,
                studentId,
                function(status) {
                    if (status) {
                        authService.logout();
                    } else {
                        return;
                    }
                }
            );
        }
    }
})();