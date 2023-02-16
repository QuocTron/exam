define(["app"], function (app) {
    app.factory("shiftService", ["$http", "utility", function ($http, utility) {
        var serviceurl = utility.baseAddress + "api/shift/";
        return {
            getShift: function (id) {
                var url = serviceurl + "getShift/" + id;
                return $http.get(url);
            },
            getShiftResult: function (id) {
                var url = serviceurl + "getShiftResult/" + id;
                return $http.get(url);
            },
            getShiftListByExamId: function (examId) {
                var url = serviceurl + "getShiftListByExamId/" + examId;
                return $http.get(url);
            },
            addExtraTime: function (extraTimeVM) {
                var url = serviceurl + "addExtraTime";
                return $http.post(url, extraTimeVM);
            },
            createShift: function (shift) {
                var url = serviceurl + "createShift";
                return $http.post(url, shift);
            },
            updateShift: function (shift) {
                var url = serviceurl + "updateShift";
                return $http.put(url, shift);
            },
            deleteShift: function (id) {
                var url = serviceurl + "deleteShift/" + id;
                return $http.delete(url);
            },
            generateQuestionSheet: function (id) {
                var url = serviceurl + "generateQuestionSheet/" + id;
                return $http.post(url);
            },
            getRemainTime: function (id) {
                var url = serviceurl + "getRemainTime/" + id;
                return $http.post(url);
            },
            activateShift: function (id) {
                var url = serviceurl + "activateShift/" + id;
                return $http.post(url);
            },
            terminateShift: function (id) {
                var url = serviceurl + "terminateShift/" + id;
                return $http.post(url);
            },
            searchStudent: function (searchViewModel) {
                var url = serviceurl + "searchStudent";
                return $http.post(url, searchViewModel);
            }
        };
    }]);
});