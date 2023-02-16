define(["app", "examService", "shiftService", "storageService", "uiService"], function (app) {
    app.controller("matrixCtrl", ["$scope", "$stateParams", "examService", "shiftService", "storageService", "toastr", "uiService", function ($scope, $stateParams, examService, shiftService, storageService, toastr, uiService) {
        $scope.title = "Matrix";
    }]);
});