define(["app"], function (app) {
    app.controller("menuCtrl", ["$scope", "$state", "authService", function ($scope, $state, authService) {
        
        $scope.authentication = authService.authentication;

        $scope.showConfirm = function () {
            $("#confirmLogOut").modal("show");
        };

        $scope.logOut = function () {
            $("#confirmLogOut").modal("hide");
            authService.logOut();
            $state.go("login");
        };

    }]);
});
