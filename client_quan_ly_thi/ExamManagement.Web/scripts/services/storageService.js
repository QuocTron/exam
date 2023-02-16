define(["app"], function (app) {
    app.factory("storageService", ["localStorageService", function (localStorageService) {
        function setItem(key, value) {
            localStorageService.set(key, value);
        }

        function getItem(key) {
            return localStorageService.get(key);
        }

        return {
            setExam: function (exam) {
                setItem("exam", exam);
            },
            getExam: function () {
                return getItem("exam");
            },
            setShift: function (shift) {
                setItem("shift", shift);
            },
            getShift: function () {
                return getItem("shift");
            },
        };
    }]);
});