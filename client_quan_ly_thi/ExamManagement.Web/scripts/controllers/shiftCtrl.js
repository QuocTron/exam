define(["app", "examService", "shiftService", "subjectService", "storageService", "matrixService", "uiService", "commonService"], function (app) {
    app.controller("shiftCtrl", ["$scope", "$stateParams", "$state", "examService", "shiftService", "subjectService", "studentService", "storageService", "matrixService", "toastr", "uiService", "commonService",
        function ($scope, $stateParams, $state, examService, shiftService, subjectService, studentService, storageService, matrixService, toastr, uiService, commonService) {
            $scope.exam = storageService.getExam();
            $scope.shiftId = $stateParams.shiftId;
            $scope.shift = null;
            $scope.subjects = null;
            $scope.matrices = null;
            $scope.shiftSubjects = [];
            $scope.checkedShiftSubjects = [];
            $scope.matrixDetails = [];
            $scope.remainTime = null;
            $scope.newShiftSubject = {};
            $scope.students = [];
            $scope.questionSheet = {};
            $scope.correctNum = 0;
            $scope.extraTimeStudent = 0;
            $scope.extraTimeModel = {
                time: 0,
                reason: ''
            };
            $scope.student = {
                lastName: '',
                firstName: '',
                code: ''
            };
            $scope.extraTimeLogs = [];

            (function () {
                uiService.block();
                $scope.processQuantity = 2;
                shiftService.getShift($scope.shiftId)
                    .success(function (data) {
                        $scope.shift = data;
                        storageService.setShift(data);
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                    }).error(function (error) {
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                        toastr.error("Có lỗi khi lấy thông tin ca thi.");
                    });

                subjectService.getSubjectListByShiftId($scope.shiftId)
                    .success(function (data) {
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                        $scope.shiftSubjects = data;
                    }).error(function (error) {
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                        toastr.error("Có lỗi khi lấy danh sách môn học.");
                    });
            }());


            $scope.showAddTime = function () {
                $scope.checkedShiftSubjects = [];
                var checked = false;
                $scope.shiftSubjects.forEach(ss => {
                    if (ss.checked) {
                        checked = true;
                        $scope.checkedShiftSubjects.push(ss.subjectName);
                    }
                });
                if (checked) {
                    $("#addTimeModal").modal("show");
                } else {
                    toastr.warning("Vui lòng chọn môn thi!");
                }
            };

            $scope.addTime = function () {
                uiService.block();
                addExtraTimeForm = {};
                addExtraTimeForm.Time = parseInt(this.extraTimeModel.time);
                addExtraTimeForm.Reason = this.extraTimeModel.reason;
                addExtraTimeForm.ShiftSubjectIds = [];

                $scope.shiftSubjects.forEach(ss => {
                    if (ss.checked) {
                        addExtraTimeForm.ShiftSubjectIds.push(ss.id);
                    }
                });

                if (addExtraTimeForm.ShiftSubjectIds.length > 0) {
                    shiftService.addExtraTime(addExtraTimeForm)
                        .success(function (data) {
                            $scope.shiftSubjects.forEach(ss => {
                                if (ss.checked) {
                                    ss.checked = false;
                                }
                            });
                            $scope.isCheckedAll = false;
                            uiService.unblock();
                            toastr.success("Đã cập nhật giờ bù thêm: " + data + " phút.");
                            $("#addTimeModal").modal("hide");
                            $scope.extraTimeModel = {};
                        }).error(function (data) {
                            uiService.unblock();
                            toastr.error("Cộng giờ thất bại: " + data.Message);
                            $("#addTimeModal").modal("hide");
                            $scope.extraTimeModel = {};
                        });
                } else {
                    toastr.warning("Vui lòng chọn môn thi!");
                    uiService.unblock();
                    $("#addTimeModal").modal("hide");
                    $scope.extraTimeModel = {};
                }
            };

            $scope.cancel = function () {
                $("#addTimeModal").modal("hide");
            };

            // Open add shiftSubject popup.
            $scope.showAdd = function () {
                subjectService.getAllSubjects()
                    .success(function (data) {
                        $scope.subjects = data;
                    }).error(function (error) {
                        toastr.error("Có lỗi khi lấy danh sách môn học.");
                    });
                matrixService.getMatrices($scope.exam.id)
                    .success(function (data) {
                        $scope.matrices = data;
                    }).error(function (error) {
                        toastr.error("Có lỗi khi lấy danh sách môn học.");
                    });
                $("#addShiftSubjectModal").modal("show");

            };
            // Create shiftSubject.
            $scope.create = function () {
                $scope.newShiftSubject.subjectId = $scope.newShiftSubject.subject.id;
                $scope.newShiftSubject.subjectName = $scope.newShiftSubject.subject.name;
                $scope.newShiftSubject.matrixId = $scope.newShiftSubject.matrix.id;
                $scope.newShiftSubject.id = 0;
                $scope.newShiftSubject.shiftId = $scope.shift.id;

                // Fix check model create shift subject                
                $scope.newShiftSubject.shiftSubjectTime = $scope.newShiftSubject.shiftSubjectTime.getHours() + ":" + `${$scope.newShiftSubject.shiftSubjectTime.getMinutes().toString().length === 1 ? '0' + $scope.newShiftSubject.shiftSubjectTime.getMinutes() : $scope.newShiftSubject.shiftSubjectTime.getMinutes()}`;
                var splitTime = $scope.newShiftSubject.shiftSubjectTime.toString().split(":");
                var shiftSubjectEndMinutes = parseInt(splitTime[0]) * 60 + parseInt(splitTime[1]) + parseInt($scope.newShiftSubject.shiftSubjectDuration);
                var shiftSubjectEndHour = ~~(shiftSubjectEndMinutes / 60);
                $scope.newShiftSubject.duration = $scope.newShiftSubject.shiftSubjectDuration;
                if (parseInt(shiftSubjectEndHour) >= 24 || parseInt(shiftSubjectEndHour) < 0) {
                    toastr.warning("Format giờ thi và thời lượng không đúng.");
                    return;
                }


                //------------------------------------------------------------
                uiService.block();
                subjectService.createSubject($scope.newShiftSubject)
                    .success(function (data) {
                        data.stateActivate = 1;
                        $scope.shiftSubjects.push(data);
                        uiService.unblock();
                    }).error(function (error) {
                        toastr.error("Có lỗi khi tạo môn thi.<br/>" + error.exceptionType + "<br/>" + error.exceptionMessage, { allowHtml: true });
                        uiService.unblock();
                    });
                $("#addShiftSubjectModal").modal("hide");
                //Reset model
                $scope.newShiftSubject = {};
                $scope.newShiftSubject = {};

            };
            // Close  shiftSubject popup.
            $scope.cancelAdd = function () {
                $("#addShiftSubjectModal").modal("hide");
            };


            // Open matrix popup.
            $scope.showMatrix = function (shiftsubjectId) {
                matrixService.getDetails(shiftsubjectId)
                    .success(function (data) {
                        console.log(data);
                        $scope.matrixDetails = data;
                        $("#matrixModal").modal("show");
                    }).error(function (error) {
                        toastr.error("Có lỗi khi lấy nội dung ma trận.");
                    });

            };

            // Close import file matrix modal popup.
            $scope.cancelMatrixModal = function () {
                $("#matrixModal").modal("hide");
            };

            $scope.selectAllShiftSubject = function () {
                $scope.shiftSubjects.forEach(shiftSubject => shiftSubject.checked = $scope.isCheckedAll)
            };

            $scope.showActivateModal = function () {
                $("#activateModal").modal("show");
            };
            $scope.cancelActivateModal = function () {
                $("#activateModal").modal("hide");
            };
            $scope.activateShift = function () {
                uiService.block();
                var ssIds = {};
                ssIds.shiftSubjectIds = [];

                $scope.shiftSubjects.forEach(shiftSubject => {
                    if (shiftSubject.checked === true) {
                        ssIds.shiftSubjectIds.push(shiftSubject.id);
                    }
                });

                if (ssIds.shiftSubjectIds.length > 0) {
                    subjectService.activateShiftSubject(ssIds)
                        .success(function () {
                            var countActivateNotYet = 0;
                            var countPause = 0;

                            $scope.shiftSubjects.forEach(shiftSubject => {
                                if (shiftSubject.checked === true) {
                                    shiftSubject.checked = false;
                                    if (shiftSubject.stateActivate === 1 || shiftSubject.stateActivate === 3) {
                                        if (shiftSubject.stateActivate === 1) {
                                            countActivateNotYet++;
                                        } else {
                                            countPause++;
                                        }
                                        shiftSubject.stateActivate = 2;
                                    }
                                }
                            });
                            $scope.isCheckedAll = false;
                            $scope.shift.quantityPaused -= countPause;
                            $scope.shift.quantityActivedNotYet -= countActivateNotYet;
                            $scope.shift.quantityActived += (countPause + countActivateNotYet);
                            uiService.unblock();
                            $scope.cancelActivateModal();
                            toastr.success("Kích hoạt thành công");
                        })
                        .error(function () {
                            uiService.unblock();
                            $scope.cancelActivateModal();
                            toastr.error("Kích hoạt thất bại");
                        });
                } else {
                    toastr.warning("Vui lòng chọn môn thi!");
                    $scope.cancelActivateModal();
                    uiService.unblock();
                }
            };

            $scope.showTerminateModal = function () {
                $("#terminateModal").modal("show");
            };
            $scope.cancelTerminateModal = function () {
                $("#terminateModal").modal("hide");
            };
            $scope.terminateShift = function () {
                uiService.block();
                var ssIds = {};
                ssIds.shiftSubjectIds = [];
                $scope.shiftSubjects.forEach(shiftSubject => {
                    if (shiftSubject.checked === true) {
                        ssIds.shiftSubjectIds.push(shiftSubject.id);
                    }
                });
                subjectService.terminateShiftSubject(ssIds)
                    .success(function () {
                        var countActivate = 0;
                        var countPause = 0;
                        $scope.shiftSubjects.forEach(shiftSubject => {
                            if (shiftSubject.checked === true) {
                                shiftSubject.checked = false;
                                if (shiftSubject.stateActivate === 2 || shiftSubject.stateActivate === 3) {
                                    if (shiftSubject.stateActivate === 2) {
                                        countActivate++;
                                    } else {
                                        countPause++;
                                    }
                                    shiftSubject.stateActivate = 4;
                                }
                            }
                        });
                        $scope.isCheckedAll = false;
                        $scope.shift.quantityPaused -= countPause;
                        $scope.shift.quantityActived -= countActivate;
                        $scope.shift.quantityEnded += (countPause + countActivate);
                        uiService.unblock();
                        $scope.cancelTerminateModal();
                        toastr.success("Kết thúc thành công");
                    })
                    .error(function () {
                        uiService.unblock();
                        $scope.cancelTerminateModal();
                        toastr.error("Kết thúc thất bại");
                    });
            };

            // Generate question sheet.
            $scope.generateQuestionSheet = function () {
                uiService.block();
                shiftService.generateQuestionSheet($scope.shift.id)
                    .success(function () {
                        $scope.shift.questionSheetCreated = true;
                        toastr.success("TẠO ĐỀ THI THÀNH CÔNG!");
                        uiService.unblock();
                    }).error(function (data) {
                        toastr.error("TẠO ĐỀ THI KHÔNG THÀNH CÔNG! <br/>" + data.exceptionMessage, { allowHtml: true });
                        uiService.unblock();
                    });
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
                searchModel.ShiftId = $scope.shift.id;
                shiftService.searchStudent(searchModel)
                    .success(function (data) {
                        $scope.students = data;
                        $("#searchModel").modal("show");
                        uiService.unblock();
                    }).error(() => {
                        toastr.error('Có lỗi đã xảy ra.');
                        uiService.unblock();
                    });
            };

            $scope.showPauseShift = function () {
                $('#pauseModal').modal('show');
            };

            $scope.cancelPauseShift = function () {
                $('#pauseModal').modal('hide');
            };

            $scope.pauseShift = function () {
                uiService.block();
                var ssIds = {};
                ssIds.shiftSubjectIds = [];

                $scope.shiftSubjects.forEach(shiftSubject => {
                    if (shiftSubject.checked === true) {
                        ssIds.shiftSubjectIds.push(shiftSubject.id);
                    }
                });

                subjectService.pauseShiftSubject(ssIds)
                    .success(function () {
                        var count = 0;
                        $scope.shiftSubjects.forEach(shiftSubject => {
                            if (shiftSubject.checked === true) {
                                shiftSubject.checked = false;
                                if (shiftSubject.stateActivate === 2) {
                                    shiftSubject.stateActivate = 3;
                                    count++;
                                }
                            }
                        });

                        $scope.isCheckedAll = false;

                        $scope.shift.quantityPaused += count;
                        $scope.shift.quantityActived -= count;
                        uiService.unblock();
                        $scope.cancelPauseShift();
                        toastr.success("Tạm dừng thành công");
                    })
                    .error(function () {
                        uiService.unblock();
                        $scope.cancelPauseShift();
                        toastr.error("Tạm dừng thất bại");
                    });
            };

            //review question sheet modal
            //BEGIN
            $scope.closeReviewQuestionSheetModal = () => {
                $("#review-questionsheet").modal('hide');
            };

            $scope.reviewQuestionSheet = (id) => {
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
                    }).error(error => toastr.error("Không thể xem lại bài thi"));
            };
            //END

            $scope.showAddTimeStudentModal = (student) => {
                $('#addTimeStudentModal').modal('show');
                $scope.student = student;
                uiService.block();
                studentService.getExtraTime({
                    ShiftId: $scope.shift.id,
                    StudentId: student.id
                }).success((data) => {
                    $scope.extraTimeStudent = data.extraTime;
                    $scope.extraTimeLogs = data.extraTimeLogs;
                    uiService.unblock();
                }).error(() => {
                    uiService.unblock();
                    toastr.error('Tải nhật ký cộng giờ thất bại.');
                });
            };

            $scope.addTimeStudent = () => {
                uiService.block();
                studentService.addExtraTime({
                    ShiftId: $scope.shift.id,
                    StudentId: $scope.student.id,
                    ExtraTime: $scope.extraTimeModel.time,
                    Reason: $scope.extraTimeModel.reason
                }).success(({ result }) => {
                    if (result === 'Ok') {
                        $scope.student.extraTime += $scope.extraTimeModel.time;
                        $scope.extraTimeStudent += $scope.extraTimeModel.time;
                        $scope.extraTimeLogs.push({
                            extraTime: $scope.extraTimeModel.time,
                            reason: $scope.extraTimeModel.reason
                        });
                        toastr.success(`Đã cộng thêm ${$scope.extraTimeModel.time} phút.`);
                    } else if (result === 'Fail') {
                        toastr.success(`Sinh viên ${$scope.student.code} - ${$scope.student.lastName} ${$scope.student.firstName} đã hoàn thành bài thi.`);
                    }
                    uiService.unblock();
                    $scope.extraTimeModel.time = 0;
                    $scope.extraTimeModel.reason = '';
                }).error(() => {
                    uiService.unblock();
                    toastr.error('Cộng giờ thi thất bại.');
                });
            };

            $scope.showReset = function () {
                $scope.student = this.student;
                $scope.resetStudentModel = {};
                $("#resetModal").modal("show");
            };

            $scope.cancelReset = () => {
                $("#resetModal").modal("hide");
            };

            $scope.resetLogin = function () {
                uiService.block();
                $scope.resetStudentModel.shiftSubjectId = $scope.student.shiftSubjectId;
                $scope.resetStudentModel.studentId = $scope.student.id;
                studentService.resetLogin($scope.resetStudentModel)
                    .success(function (data) {
                        uiService.unblock();
                        $scope.student.stateExam = 1;
                        toastr.success(`Đã reset đăng nhập cho ${$scope.student.code} ${$scope.student.lastName} ${$scope.student.firstName}.`);
                    }).error(function (data) {
                        uiService.unblock();
                        toastr.error("Đăng nhập lại thất bại.");
                    });
                $("#resetModal").modal("hide");
            };

            $scope.getResult = function () {
                shiftService.getShiftResult($scope.shiftId)
                    .success(function (data) {
                        var jsonData = JSON.parse(data);
                        var ws = XLSX.utils.json_to_sheet(jsonData);
                        var wb = XLSX.utils.book_new();
                        var shiftName = $scope.shift.name;
                        var sheetName = replaceSpecialChars(shiftName);
                        XLSX.utils.book_append_sheet(wb, ws, sheetName);
                        XLSX.writeFile(wb, "KQ_" + sheetName + ".xlsx");

                    }).error(function (data) {
                        toastr.error("Xuất kết quả thất bại.");
                    });
            };
            function replaceSpecialChars(str) {
                return str.replace(/-/g, '_').replace(/ /g, '').replace(/\:/g, '-').replace(/\\/g, '_').replace(/\//g, '-').replace(/\?/g, '_').replace(/\*/g, '_').replace(/\[/g, '_').replace(/\]/g, '_');
            }
        }]);
});