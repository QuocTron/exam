(function () {
    'use strict';

    angular
        .module('ExaminationSystem')
        .controller('infoCtrl', infoCtrl);

    infoCtrl.$inject = ['authService', 'notifyService', 'infoService', '$rootScope', '$scope', '$state', 'blockUI', 'jwtHelper'];
    function infoCtrl(authService, notifyService, infoService, $rootScope, $scope, $state, blockUI, jwtHelper) {

        initController();

        $scope.startExam = startExam;

        ////////////////

        function initController() {
            authService.loggedIn(function (result) {
                if (result == true) {
                    var studentName = $rootScope.info.StudentName;
                    var questionSheetId = $rootScope.info.QuestionSheetId;
                    infoService.checkStarted(questionSheetId, function (status) {
                        if (status) {
                            $state.go('exam');
                            $rootScope.showHeader = true;
                        } else {
                            notifyService.info('', `Chào ${studentName}`);
                            $scope.questionSheetInfo = $rootScope.info;
                            $rootScope.showHeader = false;
                        }
                    });
                } else {
                    authService.logout();
                }
            });
        }
        function startExam() {
            var questionSheetId = $rootScope.info.QuestionSheetId;
            if (confirm('Chúc bạn làm bài thành công!')) {
                infoService.startExam(questionSheetId, function (status) {
                    if (status) {
                        $state.go('exam');
                        notifyService.info('Bắt đầu làm bài', 'Thông báo');
                        $rootScope.showHeader = true;
                    } else {
                        $rootScope.showHeader = false;
                        return;
                    }
                });
            }

        }
    }
})();