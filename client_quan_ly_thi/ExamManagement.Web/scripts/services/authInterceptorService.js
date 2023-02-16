define(["app"], function (app) {
    app.factory("authInterceptorService", ["$q", "$injector", "uiService", "localStorageService", function ($q, $injector, uiService, localStorageService) {

        var authInterceptorServiceFactory = {};

        var request = function (config) {

            config.headers = config.headers || {};

            var authData = localStorageService.get("authorizationData");

            if (authData) {
                config.headers.Authorization = "Bearer " + authData.token;
            }

            return config;
        };

        var responseError = function (rejection) {
            if (rejection.status === 401) {
                var $state = $injector.get("$state");
                uiService.unblock();
                $state.transitionTo("login");
            }
            return $q.reject(rejection);
        };

        authInterceptorServiceFactory.request = request;
        authInterceptorServiceFactory.responseError = responseError;

        return authInterceptorServiceFactory;
    }]);
});