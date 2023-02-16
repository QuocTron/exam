(function() {
    'use strict';

    angular
        .module('ExaminationSystem')
        .filter('character', character);

    function character() {
        return charFilter;

        ////////////////

        function charFilter(input) {
            return String.fromCharCode(64 + parseInt(input, 10));
        }
    }
})();