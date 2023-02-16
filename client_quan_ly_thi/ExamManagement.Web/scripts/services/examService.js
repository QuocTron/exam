define(["app"], function (app) {
    //defining service using factory method
    app.factory("examService", ["$http", "utility", function ($http, utility) {
        var serviceUrl = utility.baseAddress + "api/exam/";
        return {
            getExam: function (id) {
                var url = serviceUrl + "getExam/" + id;
                return $http.get(url);
            },
            getExamList: function () {
                var url = serviceUrl + "getExamList";
                return $http.get(url);
            },
            createExam: function (exam) {
                var url = serviceUrl + "createExam";
                return $http.post(url, exam);
            },
            updateExam: function (exam) {
                var url = serviceUrl + "updateExam";
                return $http.put(url, exam);
            },
            deleteExam: function (id) {
                var url = serviceUrl + "deleteExam/" + id;
                return $http.delete(url);
            },
            importData: function (fileData, id) {
                var url = serviceUrl + "importData/" + id;
                return $http.post(url, fileData, {
                    transformRequest: angular.identity,
                    headers: { 'Content-Type': undefined }
                });
            },
            importMatrixData: function (filesData, id) {
                var url = serviceUrl + "importMatrixData/" + id;
                return $http.post(url, filesData, {
                    transformRequest: angular.identity,
                    headers: { 'Content-Type': undefined }
                });
            },
			createQuestionSheets: function(form) {
                var url = serviceUrl + "generateQuestSheets";
				return $http.post(url,form);
            },
            addExtraTime: function (extraTimeVM) {
                var url = serviceUrl + "addExtraTime/";
                return $http.post(url, extraTimeVM);
            },
            searchStudent: function (searchViewModel) {
                var url = serviceUrl + "searchStudent";
                return $http.post(url, searchViewModel);
            }
        };
    }]);
});