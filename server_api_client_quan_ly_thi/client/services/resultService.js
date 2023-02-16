(function () {
    'use strict';

    angular
        .module('ExaminationSystem')
        .factory('resultService', resultService);

    resultService.$inject = ['$http', 'notifyService'];
    function resultService($http, notifyService) {
        var service = {
            getMark: getMarkFn,
            getResult: getResultFn,
            isCompleted: isCompletedFn,
            updateQuestionDifficulty: updateQuestionDifficultyFn
        };

        return service;

        ////////////////
        function getMarkFn(questionSheetId, callback) {
            return $http.get(`/api/questionsheets/result/mark/${questionSheetId}`)
                .then(function (response) {
                    callback(true, response.data);
                }, function (response) {
                    callback(false, null);
                    notifyService.error(response.data, 'Thông báo');
                });
        }
        function getResultFn(questionSheetId, callback) {
            return $http.get(`/api/questionsheets/result/${questionSheetId}`)
                .then(function (response) {
                    callback(true, response.data);
                }, function (response) {
                    callback(false, null);
                    notifyService.error('Không có kết quả', 'Thông báo');
                });
        }
        function isCompletedFn(questionSheetId, callback) {
            return $http.get(`/api/questionsheets/completed/${questionSheetId}`)
                .then(function (response) {
                    if (response.data.Completed) {
                        callback(true);
                        notifyService.success('Bạn đã hoàn thành bài thi', 'Thông báo');
                    } else {
                        callback(false);
                    }
                });
        }
        function updateQuestionDifficultyFn(questionSheetId) {
            return $http.post('/api/questionsheets/questiondiffculty/update', {
                questionSheetId: questionSheetId
            }).then(function (response) {
            });
        }
    }
})();