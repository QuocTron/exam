(function () {
    'use strict';

    angular
        .module('ExaminationSystem')
        .factory('infoService', infoService);

    infoService.$inject = ['$state', '$http', 'authService', 'notifyService', 'blockUI'];
    function infoService($state, $http, authService, notifyService, blockUI) {
        var service = {
            startExam: startExamFn,
            checkStarted: checkStartedFn
        };

        return service;

        ////////////////
        function startExamFn(id, callback) {
            return $http.post('/api/questionsheets/start', {
                questionSheetId: id
            }).then(function (response) {
                callback(true);
            }, function (response) {
                notifyService.error(response.data, 'Thông báo');
                callback(false);
            })
        }
        function checkStartedFn(questionSheetId, callback) {
            return $http.get(`/api/questionsheets/${questionSheetId}/checkstart`, {
                params: {
                    questionSheetId: questionSheetId,
                }
            }).then(function (response) {
                if (response.data.status == true) {
                    callback(true);
                } else {
                    callback(false);
                }
            });
        }
    }
})();