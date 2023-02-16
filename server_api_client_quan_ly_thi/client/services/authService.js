(function() {
    "use strict";

    angular.module("ExaminationSystem").factory("authService", authService);

    authService.$inject = [
        "$rootScope",
        "$http",
        "$state",
        "$localStorage",
        "notifyService",
        "jwtHelper",
    ];

    function authService(
        $rootScope,
        $http,
        $state,
        $localStorage,
        notifyService,
        jwtHelper
    ) {
        var service = {
            login: loginFn,
            loggedIn: loggedInFn,
            logout: logoutFn,
            signOut: signOutFn,
            regClient: regClientFn,
        };

        return service;

        ////////////////
        function loginFn(username, password, callback) {
            $http
                .post("/api/auth/login", { studentCode: username, password: password })
                .then(
                    function(response) {
                        if (response.data.token) {
                            // store username and token in local storage to keep user logged in between page refreshes
                            // $localStorage.currentUser = { username: username, token: response.data.token };
                            $localStorage.currentUser = { token: response.data.token };

                            // add jwt token to auth header for all requests made by the $http service
                            // $http.defaults.headers.common.Authorization = 'Bearer ' + response.token;
                            $http.defaults.headers.common.Authorization = response.data.token;

                            // execute callback with true to indicate successful login
                            callback(true);
                        } else {
                            notifyService.error("", "Lỗi hệ thống");
                            // execute callback with false to indicate failed login
                            callback(false);
                        }
                    },
                    function(response) {
                        if (response.status == 401) {
                            notifyService.error(response.data, "Thông báo");
                            // execute callback with false to indicate failed login
                            callback(false);
                        }
                        if (response.status == 404) {
                            notifyService.error(response.data, "Thông báo");
                            // execute callback with false to indicate failed login
                            callback(false);
                        }
                    }
                );
        }

        function loggedInFn(callback) {
            if (
                jwtHelper.isTokenExpired($localStorage.currentUser.token) ||
                !$localStorage.currentUser ||
                $localStorage.currentUser == null
            ) {
                logoutFn();
            } else {
                $http
                    .get("/api/auth/loggedin")
                    .then(function(response) {
                        if (response.status == 500) {
                            logoutFn();
                        } else {
                            if (response.data) {
                                $rootScope.info = response.data;
                                callback(true);
                            } else {
                                callback(false);
                            }
                        }
                    })
                    .catch((err) => {
                        if (err.status == 500) {
                            notifyService.error("", "Hệ thống đang gặp trục trặc");
                            logoutFn();
                        }
                    });
            }
        }

        function logoutFn() {
            $http.defaults.headers.common.Authorization = "";
            // remove user from local storage and clear http auth header
            delete $localStorage.currentUser;
            $state.go("login");
        }

        function signOutFn(shiftSubjectId, questionSheetId, studentId, callback) {
            return $http
                .post("/api/auth/logout", {
                    shiftSubjectId: shiftSubjectId,
                    questionSheetId: questionSheetId,
                    studentId: studentId,
                })
                .then(function(response) {
                    if (response.data == true) {
                        callback(true);
                        notifyService.success("Đăng xuất thành công", "Thông báo");
                    } else {
                        callback(false);
                    }
                });
        }

        function regClientFn(code) {
            return ($localStorage.regClient = { code: code });
        }
    }
})();