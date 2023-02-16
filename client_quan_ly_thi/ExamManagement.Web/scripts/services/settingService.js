define(["app"], function (app) {
    app.factory("settingService", ["$http", "utility", function ($http, utility) {
        var serviceurl = utility.baseAddress + "api/setting/";
        return {
            getMarkRoundings: function () {
                var url = serviceurl + "getMarkRoundings";
                return $http.get(url);
            },
            setMarkRoundings: function () {
                var url = serviceurl + "setMarkRoundings";
                return $http.post(url);
            }
        };
    }]);
});