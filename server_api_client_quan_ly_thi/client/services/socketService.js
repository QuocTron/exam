(function() {
    "use strict";

    angular.module("ExaminationSystem").factory("socketService", socketService);

    socketService.$inject = ["$rootScope", "$localStorage", "$q", "examService"];

    function socketService($rootScope, $localStorage, $q, examService) {
        var socket = io.connect();
        socket.on("connect", function() {
            // console.log("connected from the client side");
            if ($localStorage.makeOffline) {
                var questionSheet = $rootScope.info.QuestionSheetId;
                var questions = $localStorage.makeOffline.questions;
                for (var key in questions) {
                    if (questions.hasOwnProperty(key)) {
                        var questionId = key;
                        var answerId = questions[key];
                        examService.updateAnswer(
                            questionSheet,
                            questionId,
                            answerId,
                            function(status) {
                                if (status == false) {
                                    swal({
                                        title: "Hiện tại kết nối đang gặp trục trặc vui lòng liên hệ với quản lý !!!",
                                        icon: "error",
                                        button: "Ok",
                                        dangerMode: true,
                                    });
                                    return;
                                }
                            }
                        );
                    }
                }
                $q.all(questions).then(function() {
                    // console.log('finish send questions');
                    delete $localStorage.makeOffline;
                });
            }
        });
        socket.on("disconnect", function() {
            swal({
                title: "Hiện tại kết nối đang gặp trục trặc vui lòng liên hệ với quản lý !!!",
                icon: "error",
                button: "Ok",
                dangerMode: true,
            });
            console.log("client disconnected from server");
            $localStorage.makeOffline = {
                code: $rootScope.info.StudentCode,
                questions: {},
            };
        });
        var service = {
            on: onFn,
            emit: emitFn,
        };

        return service;

        ////////////////
        function onFn(eventName, callback) {
            socket.on(eventName, function() {
                var args = arguments;
                $rootScope.$apply(function() {
                    callback.apply(socket, args);
                });
            });
        }

        function emitFn(eventName, data, callback) {
            socket.emit(eventName, data, function() {
                var args = arguments;
                $rootScope.$apply(function() {
                    if (callback) {
                        callback.apply(socket, args);
                    }
                });
            });
        }
    }
})();