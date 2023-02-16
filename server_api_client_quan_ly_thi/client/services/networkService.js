(function () {
    'use strict';

    angular
        .module('ExaminationSystem')
        .factory('networkService', networkService);

    networkService.$inject = ['$http'];
    function networkService($http) {
        var service = {
            checkNetwork: checkNetworkFn
        };

        return service;

        ////////////////
        function checkNetworkFn(callback) {
            if (navigator.onLine) {
                // alert('You are Online');
                callback(true, {status: 'online'});
            }
            else {
                // alert('You are Offline')
                callback(false, {status: 'offline'});
            }
        }
    }
})();