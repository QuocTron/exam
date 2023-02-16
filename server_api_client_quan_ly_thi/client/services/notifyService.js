(function () {
    'use strict';

    angular
        .module('ExaminationSystem')
        .factory('notifyService', notifyService);

    notifyService.$inject = ['toastr'];
    function notifyService(toastr) {
        var service = {
            success: successFn,
            info: infoFn,
            warning: warningFn,
            error: errorFn,
        };

        return service;

        ////////////////
        function successFn(content, title) {
            return toastr.success(content, title);
        }
        function infoFn(content, title) {
            return toastr.info(content, title);
        }
        function warningFn(content, title) {
            return toastr.warning(content, title);
        }
        function errorFn(content, title) {
            return toastr.error(content, title);
        }
    }
})();