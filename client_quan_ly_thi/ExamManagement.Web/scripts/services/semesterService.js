define(["app"], function (app) {
    app.factory("semesterService", ["$http", "utility", function ($http, utility) {
        var serviceurl = utility.baseAddress + "api/semester/";
        return {
            getSemesters: function () {
                var url = serviceurl + "getSemesters";
                return $http.get(url);
            },
            createSemester: function (semesterName) {
                var url = serviceurl + "createSemester";
                return $http.post(url, { Name: semesterName });
            },
            updateSemester: function (data) {
                var url = serviceurl + "updateSemester";
                return $http.put(url, data);
            },
            deleteSemester: function (data) {
                var url = serviceurl + "deleteSemester/" + data;
                return $http.delete(url);
            }
        };
    }]);
});