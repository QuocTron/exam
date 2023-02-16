define(["app"], function (app) {
    app.factory("subjectService", ["$http", "utility", function ($http, utility) {
        var serviceurl = utility.baseAddress + "api/subject/";
        return {
            createSubject: function (subject) {
                var url = serviceurl + "createSubject";
                return $http.post(url, subject);
            },
            getAllSubjects: function () {
                var url = serviceurl + "getAllSubjects";
                return $http.get(url);
            },
            getSubject: function (id) {
                var url = serviceurl + "getSubject/" + id;
                return $http.get(url);
            },
            getSubjectListByShiftId: function (shiftId) {
                var url = serviceurl + "getSubjectListByShiftId/" + shiftId;
                return $http.get(url);
            },
            addExtraTime: function (extraSubjectTimeModel) {
                var url = serviceurl + "addExtraTime";
                return $http.post(url, extraSubjectTimeModel);
            },
            resetLogin: function (resetSubjectStudentModel) {
                var url = serviceurl + "resetLogin";
                return $http.post(url, resetSubjectStudentModel);
            },
            pauseShiftSubject: function (data) {
                var url = serviceurl + "pauseSubject";
                return $http.post(url, data);
            },
            activateShiftSubject: function (data) {
                var url = serviceurl + "activeSubject";
                return $http.post(url, data);
            },
            terminateShiftSubject: function (data) {
                var url = serviceurl + "terminateSubject";
                return $http.post(url, data);
            }
        };
    }]);
});