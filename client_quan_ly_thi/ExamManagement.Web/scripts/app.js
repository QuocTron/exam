define(["ui-router", "ngStorage", "ngCookies"], function () {

    //defining angularjs module
    var app = angular.module("app", ["ui.router", "ngCookies", "ngStorage", "toastr", "angular-loading-bar", "LocalStorageModule", "timer"]);

    //global service
    app.constant("utility",
        {
            baseAddress: "http://localhost:60160/"
        });

    //manual bootstrap
    app.init = function () {
        angular.bootstrap(document, ["app"]);
    };

    //defining routes
    app.config(function ($stateProvider, $urlRouterProvider) {

        $urlRouterProvider.otherwise("/");

        $stateProvider
            .state("login", {
                url: "/",
                templateUrl: "views/shared/login.html",
                controller: "loginCtrl"
            })
            .state("home", {
                url: "/trang-chu",
                templateUrl: "views/examManagement/home.html",
                controller: "homeCtrl"
            })
            .state("exam", {
                url: "/quan-ly-dot-thi-:examId",
                templateUrl: "views/examManagement/exam.html",
                controller: "examCtrl"
            })
            .state("shift", {
                url: "/quan-ly-ca-thi-:shiftId",
                templateUrl: "views/examManagement/shift.html",
                controller: "shiftCtrl"
            })
            .state("matrix", {
                url: "/quan-ly-ma-tran",
                templateUrl: "views/examManagement/matrix.html",
                controller: "matrixCtrl"
            })
            .state("student", {
                url: "/quan-ly-sinh-vien-:subjectId-:shiftSubjectId",
                templateUrl: "views/examManagement/student.html",
                controller: "studentCtrl"
            })
            .state("setting", {
                url: "/thiet-lap",
                templateUrl: "views/settingManagement/setting.html",
                controller: "settingCtrl"
            });
    });

    // Add token header into every request.
    app.config(function ($httpProvider) {
        $httpProvider.interceptors.push("authInterceptorService");
    });

    // Fill authentication data when run.
    app.run(["authService", function (authService) {
        authService.fillAuthData();
    }]);

    return app;
});