define(["app"], function (app) {
    app.factory("authService", ["$http", "$q", "utility", "localStorageService", function ($http, $q, utility, localStorageService) {
        var serviceBase = utility.baseAddress;
        var authServiceFactory = {};

        var authentication = {
            isAuth: false,
            userName: ""
        };

        var logOut = function () {
            localStorageService.remove("authorizationData");
            authentication.isAuth = false;
            authentication.userName = "";
        };

        var login = function (loginData) {
            logOut();

            var data = "grant_type=password&username=" + loginData.userName + "&password=" + loginData.password;
            var deferred = $q.defer();
            console.log(data);

            $http.post(serviceBase + "token", data, { headers: { 'Content-Type': "application/x-www-form-urlencoded" } })
                .success(function (response) {
                    localStorageService.set("authorizationData", { token: response.access_token, userName: loginData.userName });
                    authentication.isAuth = true;
                    authentication.userName = loginData.userName;
                    deferred.resolve(response);
                })
                .error(function (err) {
                    logOut();
                    deferred.reject(err);
                });

            return deferred.promise;
        };

        var fillAuthData = function () {
            var authData = localStorageService.get("authorizationData");

            if (authData) {
                authentication.isAuth = true;
                authentication.userName = authData.userName;
            }
        }

        authServiceFactory.login = login;
        authServiceFactory.logOut = logOut;
        authServiceFactory.fillAuthData = fillAuthData;
        authServiceFactory.authentication = authentication;

        return authServiceFactory;
    }]);
});
