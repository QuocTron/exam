(function () {
    'use strict';

    angular
        .module('ExaminationSystem')
        .controller('headerCtrl', headerCtrl);

    headerCtrl.$inject = ['$rootScope', '$scope', '$state', '$localStorage', 'authService', 'infoService', 'resultService', 'networkService', 'notifyService'];
    function headerCtrl($rootScope, $scope, $state, $localStorage, authService, infoService, resultService, networkService, notifyService) {

        initController();

        ////////////////

        function initController() {
            // check login status
            if ($localStorage.currentUser) {
                authService.loggedIn(function (result) {
                    if (result == true) {
                        var questionSheetId = $rootScope.info.QuestionSheetId;
                        infoService.checkStarted(questionSheetId, function (status) {
                            if (status) {
                                resultService.isCompleted($rootScope.info.QuestionSheetId, function (status) {
                                    if (status) {
                                        $rootScope.showHeader = false;
                                    } else {
                                        $rootScope.showHeader = true;
                                    }
                                })
                            } else {
                                $rootScope.showHeader = false;
                            }
                        });
                    } else {
                        // reset login status
                        authService.logout();
                    }
                });
            } else {
                // reset login status
                authService.logout();
            }
        }
        function checkNetwork() {
            networkService.checkNetwork(function (status, data) {
                if (status) {
                    // notifyService.warning('Bạn đang trong trạng thái ONLLINE', 'Thông báo');
                } else {
                    notifyService.warning('Bạn đang trong trạng thái OFFLINE', 'Thông báo');
                }
            })
        }
        setInterval(function () {
            checkNetwork();
        }, 3000);
    }
})();