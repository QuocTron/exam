define(["app"], function (app) {
    app.factory("studentService", ["$http", "utility", function ($http, utility) {
        var serviceurl = utility.baseAddress + "api/student/";
        return {
            getStudentListByShiftSubject: function (shiftId, subjectId) {
                var url = serviceurl + "getStudentListByShiftSubject/" + shiftId + "/" + subjectId;
                return $http.get(url);
            },
            getExtraTime: function (extraTimeModel) {
                var url = serviceurl + "getExtraTime"; 
                return $http.post(url, extraTimeModel);
            },
            addExtraTime: function (extraTimeModel) {
                var url = serviceurl + "addExtraTime";
                return $http.post(url, extraTimeModel);
            },
            resetLogin: function (resetStudentModel) {
                var url = serviceurl + "resetLogin";
                return $http.post(url, resetStudentModel);
            },
            createStudent: function (studentVM) {
                var url = serviceurl + "createStudent";
                return $http.post(url, studentVM);
            },
            addcheckStudentTime: function (time) {
                var url = serviceurl + 'addExtraTimeStudents';
                return $http.post(url, time);
            },
            searchStudent: function (searchViewModel) {
                var url = serviceurl + "searchStudent";
                return $http.post(url, searchViewModel);
            }
        };
    }]);
});