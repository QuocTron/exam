define(["app"], function (app) {
    app.factory("matrixService", ["$http", "utility", function ($http, utility) {
        var serviceurl = utility.baseAddress + "api/matrix/";
        return {
            getDetails: function (shiftsubjectId) {
                var url = serviceurl + "getDetails/" + shiftsubjectId;
                return $http.get(url);
            },
            getMatrices: function (examId) {
                var url = serviceurl + "getMatrices/" + examId;
                return $http.get(url);
            }
        };
    }]);
});