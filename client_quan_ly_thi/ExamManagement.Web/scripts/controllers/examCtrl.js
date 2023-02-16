define(["app", "examService", "shiftService", "matrixService", "storageService", "uiService"], function (app) {
    app.controller("examCtrl", ["$scope", "$stateParams", "examService", "shiftService", "matrixService", "studentService", "storageService", "toastr", "uiService", "commonService",
        function ($scope, $stateParams, examService, shiftService, matrixService, studentService, storageService, toastr, uiService, commonService) {
            $scope.examId = $stateParams.examId;
            $scope.exam = null;
            $scope.shifts = [];
            $scope.matrices = [];
            $scope.students = [];
            $scope.days = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"];
            $scope.months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
            $scope.hours = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"];
            $scope.minutes = ["00", "15", "30"];
            $scope.previousYear = 0;
            $scope.extraTimeLogs = [];
            $scope.checkedShiftNames = [];
            $scope.extraTimeStudent = 0;
            $scope.shift = {
                shiftDay: "",
                shiftMonth: "",
                shiftYear: "",
                shiftHour: "",
                shiftMinute: ""
            };
            $scope.questionSheet = {};
            $scope.correctNum = 0;
            $scope.student = {
                id: 0,
                code: '',
                lastName: '',
                firstName: ''
            };
            $scope.extraTimeModel = {
                time: 0,
                reason: ''
            };


            (function () {
                uiService.block();
                $scope.processQuantity = 3;
                examService.getExam($scope.examId)
                    .success(function (data) {
                        $scope.exam = data;
                        storageService.setExam(data);
                        $scope.previousYear = parseInt($scope.exam.name.split("NH ")[1].split("_")[0]);
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                    }).error(function () {
                        toastr.error("Có lỗi khi lấy thông tin đợt thi.");
                    });

                shiftService.getShiftListByExamId($scope.examId)
                    .success(function (data) {
                        $scope.shifts = data;
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                    }).error(function () {
                        toastr.error("Có lỗi khi lấy danh sách ca thi.");
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                    });

                matrixService.getMatrices($scope.examId)
                    .success(function (data) {
                        $scope.matrices = data;
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                    }).error(function () {
                        toastr.error("Có lỗi khi lấy danh sách ma trận.");
                        $scope.processQuantity--;
                        if ($scope.processQuantity === 0) {
                            uiService.unblock();
                        }
                    });
            })();


            // Open add shift modal popup.
            $scope.showAdd = function () {
                $("#shiftModal").modal("show");
            };
            // Cancel add shift modal popup.
            $scope.cancelAdd = function () {
                $("#shiftModal").modal("hide");
            };

            // Create shift.
            $scope.create = function () {
                try {

                    var newShift = {};
                    var shiftDate = $scope.shift.shiftDay + "/" + $scope.shift.shiftMonth + "/" + $scope.shift.shiftYear;
                    var shiftTime = $scope.shift.time.getHours() + ":" + `${$scope.shift.time.getMinutes().toString().length === 1 ? '0' + $scope.shift.time.getMinutes() : $scope.shift.time.getMinutes()
                        }` + " - " + $scope.shift.duration;
                    newShift.examId = $scope.exam.id;
                    newShift.name = shiftDate + " - " + shiftTime;
                    newShift.endTime = $scope.shift.shiftYear + "-" + $scope.shift.shiftMonth + "-" + $scope.shift.shiftDay /*+ " " + ("0" + shiftEndHour).slice(-2) + ":" + ("0" + shiftEndMinute).slice(-2)*/;
                    
                    uiService.block();
                    shiftService.createShift(newShift)
                        .success(function (data) {
                            $scope.shifts.push(data);
                            $("#shiftModal").modal("hide");
                            uiService.unblock();
                        })
                        .error(function (data) {
                            toastr.error('Có lỗi đã xảy ra.');
                            uiService.unblock();
                        });
                } catch (ex) {
                    toastr.error('Có lỗi đã xảy ra.');
                    uiService.unblock();
                }
            };

            // Open delete exam confirmation.
            $scope.showConfirm = function () {
                $scope.shift = this.shift;
                $("#confirmModal").modal("show");
            };
            // Delete shift.
            $scope.delete = function () {
                uiService.block();
                var deleteShift = $scope.shift;
                shiftService.deleteShift(deleteShift.id)
                    .success(function (data) {
                        $("#confirmModal").modal("hide");

                        if (data.result === 'Ok') {
                            $scope.shifts.splice($scope.shifts.indexOf(deleteShift), 1);
                            toastr.success("Xóa ca thi thành công.");
                        } else {
                            toastr.error("Xóa ca thi thất bại.");
                        }
                        uiService.unblock();
                    })
                    .error(function (e) {
                        $("#confirmModal").modal("hide");
                        toastr.error("Có lỗi khi xóa ca thi.");
                        uiService.unblock();
                    });
            };

            // Generate question sheet.
            $scope.generateQuestionSheet = function () {
                uiService.block();
                var currentShift = this.shift;

                shiftService.generateQuestionSheet(currentShift.id)
                    .success(function (data) {
                        console.log(data);//<================================================ BUG
                        currentShift.questionSheetCreated = true;
                        toastr.success("TẠO ĐỀ THI THÀNH CÔNG!");
                        uiService.unblock();
                    }).error(function (data) {
                        toastr.error("TẠO ĐỀ THI KHÔNG THÀNH CÔNG!! <br/>" + data.exceptionMessage, { allowHtml: true });
                        uiService.unblock();
                    });
            };

            // Show import file modal popup.
            $scope.showImport = function () {
                $scope.files = [];
                $("#fileExcel").val("");
                $("#uploadModal").modal("show");
            };

            // Close import file modal popup.
            $scope.cancel = function () {
                $("#uploadModal").modal("hide");
            };

            // Upload file to server to import shifts data.
            $scope.import = function () {
                if ($scope.files.length === 0) {
                    toastr.error("Vui lòng chọn file!");
                }
                else {
                    uiService.block();
                    $("#uploadModal").modal("hide");

                    var fileData = new FormData();
                    fileData.append("fileExcel", $scope.files[0]);

                    examService.importData(fileData, $scope.examId)
                        .success(function (data) {
                            $scope.shifts = data;
                            toastr.success("Import excel thành công!");
                            uiService.unblock();
                        })
                        .error(function (data) {
                            var errorMessage = data.exceptionMessage;
                            if (data.innerException) {
                                errorMessage += "\n" + data.innerException.exceptionMessage;
                            }
                            toastr.error(errorMessage);
                            uiService.unblock();
                        });
                }
            };

            //show pop-up addTime
            $scope.showaddTime = function () {
                $scope.checkedShiftNames = [];
                $scope.extraTimeModel = {};
                var checked = false;
                $scope.shifts.forEach(s => {
                    if (s.checkboxModel) {
                        checked = true;
                        $scope.checkedShiftNames.push(s.name);
                    }
                });
                if (checked) {
                    $("#addTimeModal").modal("show");
                } else {
                    toastr.warning("Vui lòng chọn môn thi!");
                }

            };

            // add Time
            $scope.addTime = function () {
                uiService.block();
                addExtraTimeForm = {};
                addExtraTimeForm.Time = parseInt(this.extraTimeModel.time);
                addExtraTimeForm.Reason = this.extraTimeModel.reason;
                addExtraTimeForm.ShiftIds = [];

                $scope.shifts.forEach(s => {
                    if (s.checkboxModel) {
                        addExtraTimeForm.ShiftIds.push(s.id);
                    }
                });

                examService.addExtraTime(addExtraTimeForm)
                    .success(function (data) {
                        toastr.success("Đã cập nhật giờ bù thêm: " + data + " phút.");
                        $("#addTimeModal").modal("hide");
                        uiService.unblock();
                    }).error(function (data) {
                        toastr.error(data.Message);
                        $("#addTimeModal").modal("hide");
                        uiService.unblock();
                    });


            };

            //cancel add time popup
            $scope.cancel = function () {
                $("#addTimeModal").modal("hide");
            };


            $scope.getFileDetails = function (e) {
                $scope.files = [];
                $scope.$apply(function () {
                    for (var i = 0; i < e.files.length; i++) {
                        $scope.files.push(e.files[i]);
                    }
                });
            };

            //BEGIN IMPORT MATRIX SECTION

            // Show import file modal popup.
            $scope.showImportMatrix = function () {
                $scope.files = [];
                $("#fileMatrixExcel").val("");
                $("#uploadMatrixModal").modal("show");
            };

            // Close import file matrix modal popup.
            $scope.cancelMatrixModal = function () {
                $("#uploadMatrixModal").modal("hide");
            };

            // Upload file to server to import matrix data.
            $scope.importMatrix = function () {
                if ($scope.files.length === 0) {
                    toastr.error("Vui lòng chọn file!");
                } else {
                    uiService.block();

                    var filesData = new FormData();
                    for (var i = 0; i < $scope.files.length; i++) {
                        filesData.append("fileMatrixExcel[]", $scope.files[i]);
                    }

                    examService.importMatrixData(filesData, $scope.examId)
                        .success(function (data) {
                            $scope.matrices = data;
                            toastr.success("Nhập ma trận đề thành công!");
                            uiService.unblock();
                        })
                        .error(function (data) {
                            toastr.error(data.exceptionMessage + "\n" + typeof data.innerException !== "undefined" ? "" : data.innerException.exceptionMessage);
                            uiService.unblock();
                        });
                }
            };

            //END IMPORT MATRIX SECTION

            $scope.checkedAll = function () {
                $scope.shifts.forEach(shift => shift.checkboxModel = $scope.isCheckedAll);
            };

            $scope.showCreateQuestionSheetsConfirm = function () {
                $scope.checkedShiftNames = [];
                var checked = false;
                $scope.shifts.forEach(shift => {
                    if (shift.checkboxModel) {
                        checked = true;
                        $scope.checkedShiftNames.push(shift.name);
                    }
                });
                if (checked) {
                    $('#confirmCreateQuestionSheets').show();
                } else {
                    toastr.warning("Vui lòng chọn ca thi!");
                }
            };

            $scope.hideCreateQuestionSheetsConfirm = function () {
                $('#confirmCreateQuestionSheets').hide();
            };

            $scope.createQuestionSheets = function () {
                uiService.block();
                var form = { ExamId: $scope.examId };
                form.ShiftIds = [];
                $scope.shifts.forEach(shift => {
                    if (shift.checkboxModel) {
                        form.ShiftIds.push(shift.id);
                    }
                });
                if (form.ShiftIds.length > 0) {
                    examService.createQuestionSheets(form)
                        .success(function (data) {
                            if (data.shiftsCreated.length === form.ShiftIds.length) {
                                toastr.success("TẠO ĐỀ THI THÀNH CÔNG!<br/>Số lượng: " + data.shiftsCreated.length + "/" + form.ShiftIds.length, { allowHtml: true });
                                $scope.shifts.forEach(shift => {
                                    for (var i = 0; i < data.shiftsCreated.length; i++) {
                                        if (data.shiftsCreated[i] === shift.id) {
                                            shift.questionSheetCreated = true;
                                            shift.checkboxModel = false;
                                            break;
                                        }
                                    }
                                });
                            } else if (data.shiftsCreated.length === 0){
                                toastr.error("TẠO ĐỀ THI KHÔNG THÀNH CÔNG!<br/>Số lượng: " + data.shiftsCreated.length + "/" + form.ShiftIds.length, { allowHtml: true });
                            }else {
                                toastr.warning("TẠO ĐỀ THI THÀNH CÔNG!<br/>Số lượng: " + data.shiftsCreated.length + "/" + form.ShiftIds.length, { allowHtml: true });
                                $scope.shifts.forEach(shift => {
                                    for (var i = 0; i < data.shiftsCreated.length; i++) {
                                        if (data.shiftsCreated[i] === shift.id) {
                                            shift.questionSheetCreated = true;
                                            shift.checkboxModel = false;
                                            break;
                                        }
                                    }
                                });
                            }
                            if (data.state === 'Warning') {
                                toastr.error("TẠO ĐỀ THI KHÔNG THÀNH CÔNG!<br/>" + data.message, { allowHtml: true });
                            }
                            $scope.hideCreateQuestionSheetsConfirm();
                            uiService.unblock();
                        })
                        .error(function (data) {
                            toastr.error("TẠO ĐỀ THI KHÔNG THÀNH CÔNG!<br/>" + data.exceptionMessage, { allowHtml: true });
                            $scope.hideCreateQuestionSheetsConfirm();
                            uiService.unblock();
                        });
                } else {
                    toastr.warning("Vui lòng chọn ca thi!");
                    $scope.hideCreateQuestionSheetsConfirm();
                    uiService.unblock();
                }
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
                searchModel.ExamId = $scope.exam.id;
                examService.searchStudent(searchModel)
                    .success(function (data) {
                        uiService.unblock();
                        $scope.students = data;
                        $("#searchModel").modal("show");
                    }).error(() => {
                        uiService.unblock();
                        toastr.error('Có lỗi đã xảy ra.');
                    });
            };

            // review question sheet modal
            //BEGIN
            $scope.closeReviewQuestionSheetModal = () => {
                $("#review-questionsheet").modal('show');
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
                        uiService.unblock();
                        toastr.error("Không thể xem lại bài thi");
                    });
            };
            //END

            $scope.showModalAdTimeStudent = (student) => {
                $scope.student = student;
                $('#addTimeStudentModal').modal('show');
                uiService.block();
                studentService.getExtraTime({
                    StudentId: student.id,
                    ShiftId: student.shiftId
                }).success((data) => {
                    $scope.extraTimeLogs = data.extraTimeLogs;
                    $scope.extraTimeStudent = data.extraTime;
                    uiService.unblock();
                });
            }

            $scope.addTimeStudent = () => {
                var student = $scope.student;
                var extraTimeModel = $scope.extraTimeModel;
                uiService.block();
                studentService.addExtraTime({
                    StudentId: student.id,
                    ShiftId: student.shiftId,
                    ExtraTime: extraTimeModel.time,
                    Reason: extraTimeModel.reason,
                }).success(({ result }) => {
                    if (result === 'Ok') {
                        $scope.extraTimeLogs.push({
                            extraTime: extraTimeModel.time,
                            reason: extraTimeModel.reason,
                        });
                        $scope.extraTimeStudent += $scope.extraTimeModel.time;
                        toastr.success(`Đã cộng thêm ${extraTimeModel.time} phút.`);
                    } else if (result === 'Fail') {
                        toastr.success(`Sinh viên ${$scope.student.code} - ${$scope.student.lastName} ${$scope.student.firstName} đã hoàn thành bài thi.`);
                    }
                    uiService.unblock();
                    $scope.extraTimeModel.time = 0;
                    $scope.extraTimeModel.reason = '';
                })
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

        }]);
});