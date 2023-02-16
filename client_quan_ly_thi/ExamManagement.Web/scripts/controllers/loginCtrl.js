define(["app"], function (app) {
    app.controller("loginCtrl", ["$scope", "$state", "authService", "toastr", function ($scope, $state, authService, toastr) {

        $scope.loginData = {
            userName: "",
            password: ""
        };

        $scope.message = "";

        (function () {
            authService.logOut();
        }());

        $scope.login = function () {

            authService.login($scope.loginData).then(function (response) {
                $state.go("home");
            },
            function (err) {
                toastr.error("Đăng nhập thất bại!");
                console.log(err);
            });
        };

    }]);
});