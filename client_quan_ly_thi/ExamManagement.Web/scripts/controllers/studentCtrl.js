define(["app", "examService", "shiftService", "subjectService", "studentService", "storageService", "commonService", "uiService"], function (app) {
    app.controller("studentCtrl", ["$scope", "$stateParams", "toastr", "examService", "shiftService", "subjectService", "studentService", "storageService", "commonService", "uiService",
        function ($scope, $stateParams, toastr, examService, shiftService, subjectService, studentService, storageService, commonService, uiService) {
            $scope.exam = storageService.getExam();
            $scope.shift = storageService.getShift();
            $scope.shiftSubjectId = $stateParams.shiftSubjectId;
            $scope.subjectId = $stateParams.subjectId;
            $scope.subject = null;
            $scope.student = null;
            $scope.students = [];
            $scope.extraTimeLogs = [];
            $scope.resetStudentModel = null;
            $scope.resetSubjectStudentModel = null;
            $scope.extraTimeModel = {};
            $scope.extraSubjectTimeModel = null;
            $scope.time = { StudentIds: [] };
            $scope.newStudent = {};
            $scope.studentSearch = [];
            $scope.questionSheet = {};
            $scope.correctNum = 0;
            $scope.studentMap = {};

            (function () {
                $scope.processQuantity = 2;
                uiService.block();
                subjectService.getSubject($scope.subjectId)
                    .success(function (data) {
                        $scope.subject = data;
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                    }).error(function (error) {
                        toastr.error("Có lỗi khi lấy thông tin môn học.");
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                    });

                studentService.getStudentListByShiftSubject($scope.shift.id, $scope.shiftSubjectId)
                    .success(function (data) {
                        $scope.students = data;
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                    }).error(function (error) {
                        toastr.error("Có lỗi khi lấy danh sách sinh viên.");
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                    });
            }());

            //BEGIN add student time

            $scope.checkAll = function() {
                $scope.students.forEach(student => student.isChecked = $scope.isCheckedAll);
            };

            $scope.showAddTimeAtSearch = function () {
                $scope.student = this.student;
                $scope.studentMap = $scope.students.find(student => student.id === this.student.id);
                uiService.block();

                $scope.extraTimeModel.studentId = $scope.student.id;
                $scope.extraTimeModel.shiftId = $scope.shift.id;
                studentService.getExtraTime($scope.extraTimeModel)
                    .success(function (data) {
                        uiService.unblock();
                        $scope.extraTimeModel.extraTime = data.extraTime;
                        $scope.extraTimeLogs = data.extraTimeLogs;
                    }).error(function (data) {
                        uiService.unblock();
                        toastr.error('Tải nhật ký cộng giờ thất bại.');
                    });

                $("#addTimeModal").modal("show");
            };

            $scope.showAddTime = function () {
                $scope.student = this.student;
                uiService.block();

                $scope.extraTimeModel.studentId = $scope.student.id;
                $scope.extraTimeModel.shiftId = $scope.shift.id;
                studentService.getExtraTime($scope.extraTimeModel)
                    .success(function (data) {
                        uiService.unblock();
                        $scope.extraTimeModel.extraTime = data.extraTime;
                        $scope.extraTimeLogs = data.extraTimeLogs;
                    }).error(function (data) {
                        uiService.unblock();
                        toastr.error('Tải nhật ký cộng giờ thất bại.');
                    });

                $("#addTimeModal").modal("show");
            };
        
            $scope.addTime = function () {
                uiService.block();
                $scope.extraTimeModel.studentId = $scope.student.id;
                $scope.extraTimeModel.shiftId = $scope.shift.id;
                $scope.extraTimeModel.Reason = this.extraTimeModel.reason;
                studentService.addExtraTime($scope.extraTimeModel)
                    .success(function ({ result }) {
                        if (result === 'Ok') {
                            $scope.extraTimeModel.extraTime += $scope.extraTimeModel.time;
                            if ($scope.student.bonusTime) {
                                $scope.student.bonusTime += $scope.extraTimeModel.time;
                            }
                            if ($scope.student.extraTime) {
                                $scope.student.extraTime += $scope.extraTimeModel.time;
                            }
                            if ($scope.studentMap) {
                                $scope.studentMap.bonusTime += $scope.extraTimeModel.time;
                                $scope.studentMap = null;
                            }
                            $scope.extraTimeLogs.push({
                                extraTime: $scope.extraTimeModel.time,
                                reason: $scope.extraTimeModel.reason,
                            });
                            toastr.success(`Đã cộng thêm ${$scope.extraTimeModel.extraTime} phút.`);
                        } else if (result === 'Fail') {
                            toastr.success(`Sinh viên ${$scope.student.code} - ${$scope.student.lastName} ${$scope.student.firstName} đã hoàn thành bài thi.`);
                        }
                        uiService.unblock();
                        $scope.extraTimeModel.reason = '';
                        $scope.extraTimeModel.time = 0;
                    }).error(function (data) {
                        uiService.unblock();
                        $scope.studentMap = null;
                        toastr.error(data.Message);
                    });
            };

            $scope.cancel = function () {
                $("#addTimeModal").modal("hide");
                $scope.studentMap = null;
            };
            //END add student time

            //BEGIN reset student login
            $scope.showReset = function () {
                $scope.student = this.student;
                $scope.resetStudentModel = {};
                $("#resetModal").modal("show");
            };

            $scope.cancelReset = () => {
                $("#resetModal").modal("hide");
                $scope.studentMap = null;
            };

            $scope.resetLogin = function () {
                uiService.block();
                $scope.resetStudentModel.shiftSubjectId = $scope.shiftSubjectId;
                $scope.resetStudentModel.studentId = $scope.student.id;
                studentService.resetLogin($scope.resetStudentModel)
                    .success(function (data) {
                        uiService.block();
                        $scope.student.stateExam = 1;
                        if ($scope.studentMap) {
                            $scope.studentMap.stateExam = 1;
                            $scope.studentMap = null;
                        }
                        uiService.unblock();
                        toastr.success(`Đã reset đăng nhập cho ${$scope.student.code} - ${$scope.student.lastName} ${$scope.student.firstName}.`);
                    }).error(function (data) {
                        uiService.block();
                        $scope.studentMap = null;
                        toastr.error("Đăng nhập lại thất bại.");
                    });
                $("#resetModal").modal("hide");
            };
            //END reset student login

            //BEGIN reset student login at search popup
            $scope.showResetAtSearch = function () {
                $scope.student = this.student;
                $scope.studentMap = $scope.students.find(student => student.id === this.student.id);
                $scope.resetStudentModel = {};
                $("#resetModal").modal("show");
            };
            //END reset student login at search popup

            //BEGIN reset subject login
            $scope.showSubjectReset = function () {
                $scope.resetSubjectStudentModel = {};
                $("#resetSubjectModal").modal("show");
            };
            $scope.resetSubjectLogin = function () {
                uiService.block();
                $scope.resetSubjectStudentModel.shiftSubjectId = $scope.shiftSubjectId;

                subjectService.resetLogin($scope.resetSubjectStudentModel)
                    .success(function (data) {
                        toastr.success("Đã reset đăng nhập cho môn " + $scope.subject.name);
                        uiService.unblock();
                    }).error(function (data) {
                        toastr.error(data.Message);
                        uiService.unblock();
                    });
                $("#resetSubjectModal").modal("hide");
            };
            //END reset student login

        
            //BEGIN add student
            $scope.showAddStudent = function () {
                $("#addStudentModal").modal("show");
            };

            $scope.cancelAddStudentModal = function () {
                $("#addStudentModal").modal("hide");
            };

            $scope.addStudent = function () {
                $scope.newStudent.shiftSubjectId = $scope.shiftSubjectId;
                uiService.block();
                studentService.createStudent($scope.newStudent)
                    .success(function (data) {
                        // toastr.success("Thêm sinh viên " + $scope.newStudent.lastName + " " + $scope.newStudent.firstName + " thành công!");
                            // var isContainStudent = false;
                            // $scope.students.forEach(student => {
                            //     if(student.code == $scope.newStudent.code) {
                            //         isContainStudent = true;
                            //     }
                            // })
                        if(data.isAdded) {
                            toastr.success(`Thêm sinh viên ${data.student.lastName} ${data.student.firstName} thành công.`);
                            $scope.students.push(data.student);
                        }  else {
                            toastr.success(`Sinh viên đã có sẵn.`);
                        }

                        // studentService.getStudentListByShiftSubject($scope.shift.id, $scope.shiftSubjectId)
                        //     .success(function (data) {
                        //         $scope.students = data;
                        //     }).error(function (error) {
                        //         console.log(error);
                        //         toastr.error("Có lỗi khi lấy danh sách sinh viên.");
                        //     });
                        $("#addStudentModal").modal("hide");
                        uiService.unblock();
                    }).error(function (data) {
                        toastr.error(data.Message);
                        uiService.unblock();
                    });
                $scope.newStudent = {};
                //$("#addStudentModal").modal("show");
            };
            //BEGIN add student

            $scope.addcheckStudentTime = function () {
                uiService.block();
                $scope.time.SubjectId = $scope.subjectId;
                $scope.time.ShiftId = $scope.shift.id;

                $scope.students.forEach(st => {
                    if (st.isChecked) {
                        $scope.time.StudentIds.push(st.id);
                    }
                });

                studentService.addcheckStudentTime($scope.time)
                .success(function (data) {
                    //$scope.extraTimeModel2.extraTime2 = data;
                    toastr.success("Đã cập nhật giờ bù: " + data + " phút.");
                    $scope.time.StudentIds = [];
                    $scope.students.forEach(st => {
                        if (st.isChecked) {
                            st.bonusTime += data;
                        }
                    });
                    uiService.unblock();
                }).error(function (data) {
                    toastr.error(data.Message);
                    uiService.unblock();
                });
                $('#addTimeModal2').modal('hide');
            };

            $scope.showForm = function () {
                $('#addTimeModal2').modal('show');
            };

            $scope.cancels = function () {
                $('#addTimeModal2').modal('hide');
            };

            //show popup search student
            $scope.hideSearch = function () {
                $("#searchModel").modal("hide");
            };

            // search result
            $scope.searchResult = function () {
                uiService.block();
                searchModel = {};
                searchModel.StudentCode = this.StudentCode;
                searchModel.ShiftSubjectId = $scope.shiftSubjectId;
                studentService.searchStudent(searchModel)
                    .success(function (data) {
                        $scope.studentSearch = data;
                        $("#searchModel").modal("show");
                        uiService.unblock();
                    });
            };
            //review question sheet modal
            //BEGIN
            $scope.closeReviewQuestionSheetModal = () => {
                $("#review-questionsheet").modal('hide');
            };

            $scope.reviewQuestionSheet = (id) => {
                uiService.block();
                commonService.reviewQuestionSheet(id)
                    .success(questionSheet => {
                        var canvas = $('#canvas-score').get(0);
                        var ctx = canvas.getContext('2d');
                        ctx.clearRect(0, 0, canvas.width, canvas.height);
                        ctx.fillStyle = 'red';
                        ctx.font = '85px bold';
                        $scope.correctNum = 0;
                        $scope.questionSheet = questionSheet;
                        ctx.fillText(questionSheet.score.toFixed(2), 0, 100);
                        questionSheet.questions.forEach(question => { if (question.correct) $scope.correctNum++; });
                        $("#review-questionsheet").modal('show');
                        uiService.unblock();
                    }).error(error => {
                        toastr.error("Không thể xem lại bài thi");
                        uiService.unblock();
                    });
            };
            //END
    }]);
});