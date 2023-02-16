define(["app"], function (app) {
    app.factory("markRoundingService", ["$http", "utility", ($http, utility) => {
        var serviceurl = utility.baseAddress + "api/markRounding";
        return {
            getAll: function() {
                return $http.get(`${serviceurl}/getAll`);
            },

            selectMarkRounding: function (id) {
                return $http.put(`${serviceurl}/selectMarkRounding/${id}`);
            }
        };
    }]);
});