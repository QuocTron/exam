(function () {
    'use strict';

    angular
        .module('ExaminationSystem')
        .controller('questionReviewModalCtrl', questionReviewModalCtrl);

    questionReviewModalCtrl.$inject = ['$uibModalInstance', '$rootScope', '$scope', '$state', '$location', 'examService'];
    function questionReviewModalCtrl($uibModalInstance, $rootScope, $scope, $state, $location, examService) {

        // Declare variable

        // $scope.quickReply = [];

        initController();

        $scope.cancel = cancel;
        $scope.goToQuestion = goToQuestion;
        $scope.getReviewQuestion = getReviewQuestion;
        $scope.onChangeAnswerReview = onChangeAnswerReview;

        ////////////////

        function initController() {
            getReviewQuestion();
        }

        function cancel() {
            $uibModalInstance.dismiss('cancel');
        }
        function goToQuestion(questionId) {
            $location.hash('questionForm_' + questionId);
            $uibModalInstance.close();
        }
        function getReviewQuestion() {
            var questionSheetId = $rootScope.info.QuestionSheetId;
            examService.getReviewQuestion(questionSheetId, function (status, data) {
                if (status) {
                    $scope.reviewQuestions = data;
                } else {
                    return;
                }
            });
        }
        function onChangeAnswerReview(questionId, answerId) {
            var questionSheet = $rootScope.info.QuestionSheetId;
            var shiftSubjectId = $rootScope.info.ShiftSubjectId;
            examService.updateAnswer(shiftSubjectId, questionSheet, questionId, answerId, function (status) {
                if (status == false) {
                    return;
                }
            });
        }

    }
})();