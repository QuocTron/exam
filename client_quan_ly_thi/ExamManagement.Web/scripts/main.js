require.config({
    baseurl: "/scripts/",
    paths: {
        'angular': "libs/angular",
        'ngStorage': "libs/ngStorage",
        'ngCookies': "libs/angular-cookies",
        'toastr': "libs/angular-toastr.tpls",
        'loading-bar': "libs/loading-bar",
        'moment': "libs/moment-with-locales.min",
        'humanize-duration': "libs/humanize-duration",
        'angular-timer': "libs/angular-timer.min",
        'LocalStorageModule': "libs/angular-local-storage",
        'ui-router': "libs/angular-ui-router",
        'jquery': "libs/jquery-3.4.1",
        'bootstrap': "libs/bootstrap",
       
        // Services.
        'authInterceptorService': "services/authInterceptorService",
        'authService': "services/authService",
        'shiftService': "services/shiftService",
        'examService': "services/examService",
        'semesterService': "services/semesterService",
        'matrixService': "services/matrixService",
        'subjectService': "services/subjectService",
        'studentService': "services/studentService",
        'storageService': "services/storageService",
        'uiService': "services/uiService",
        'markRoundingService': "services/markRoundingService",
        'commonService': "services/commonService",

        // Controllers.
        'menuCtrl': "controllers/menuCtrl",
        'loginCtrl': "controllers/loginCtrl",
        'homeCtrl': "controllers/homeCtrl",
        'examCtrl': "controllers/examCtrl",
        'shiftCtrl': "controllers/shiftCtrl",
        'studentCtrl': "controllers/studentCtrl",
        'matrixCtrl': "controllers/matrixCtrl",
        'settingCtrl': "controllers/settingCtrl",
        'filter': "filters/filter",

        // Html
        'reviewResult': "/views/shared/ReviewQuestionSheet.html"
    },
    shim: {
        ngStorage: {
            deps: ["angular"],
            exports: "angular"
        },
        ngCookies: {
            deps: ["angular"],
            exports: "angular"
        },
        toastr: {
            deps: ["angular"],
            exports: "angular"
        },
        'loading-bar': {
            deps: ["angular"],
            exports: "angular"
        },
        'angular-timer': {
            deps: ["angular", "moment", "humanize-duration"],
            exports: "angular"
        },
        LocalStorageModule: {
            deps: ["angular"],
            exports: "angular"
        },    
        'ui-router': {
            deps: ["angular"],
            exports: "angular"
        },
        angular: {
            exports: "angular"
        },
        bootstrap: {
            deps: ["jquery"]
        }
    },
    deps: ["app"]
});

require([
    "app",
    "filter",
    "bootstrap",
    "toastr",
    "loading-bar",
    "angular-timer",
    "LocalStorageModule",
    "authService",
    "authInterceptorService",
    "menuCtrl",
    "loginCtrl",
    "homeCtrl",
    "examCtrl",
    "shiftCtrl",
    "studentCtrl",
    "matrixCtrl",
    "settingCtrl"
],

    // Boostrapping app.
    function (app) {
        app.init();
    }
);