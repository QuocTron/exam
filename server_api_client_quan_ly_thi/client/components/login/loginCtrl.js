(function () {
    'use strict';

    angular
        .module('ExaminationSystem')
        .controller('loginCtrl', loginCtrl);

    loginCtrl.$inject = ['$scope', '$localStorage', 'authService', 'notifyService', '$state', 'blockUI'];
    function loginCtrl($scope, $localStorage, authService, notifyService, $state, blockUI) {

        $scope.login = login;

        initController();

        ////////////////

        function initController() {
            // check login status
            if ($localStorage.currentUser) {
                $state.go('info');
            } else {
                // reset login status
                authService.logout();
            }
        }
        function login() {
            authService.login($scope.code, $scope.password, function (result) {
                if (result === true) {
                    $state.go('info');
                }
            });         
        };

    }
})();