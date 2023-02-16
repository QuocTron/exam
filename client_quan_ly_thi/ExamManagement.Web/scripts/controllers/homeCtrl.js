define(["app", "examService", "semesterService", "uiService"], function (app) {
    app.controller("homeCtrl", ["$scope", "$filter", "toastr", "examService", "semesterService", "uiService", function ($scope, $filter, toastr, examService, semesterService, uiService) {
        $scope.exams = [];
        $scope.semesters = [];
        $scope.exam = null;
        $scope.editMode = false;

        $scope.year = "";
        $scope.semester = "";
        $scope.term = "";
        $scope.termOptions = ["Cuối kỳ", "Giữa kỳ"];

        $scope.previousYear = new Date().getFullYear() - 1;

        $scope.yearOptions = [
            ($scope.previousYear - 2) + "_" + ($scope.previousYear - 1),
            ($scope.previousYear - 1) + "_" + ($scope.previousYear),
            ($scope.previousYear) + "_" + ($scope.previousYear + 1),
            ($scope.previousYear + 1) + "_" + ($scope.previousYear + 2),
            ($scope.previousYear + 2) + "_" + ($scope.previousYear + 3)
        ];
        // Generate exam name.
        $scope.getExamName = function () {
            return "HK" + $scope.semester.name + " - " + $scope.term + " - NH " + $scope.year;
        };

        // Initialize exams data.
        (function () {
            uiService.block();
            $scope.processQuantity = 2;
            examService.getExamList()
                .success(function (data) {
                    $scope.exams = data;
                    $scope.processQuantity--;
                    if ($scope.processQuantity === 0) {
                        uiService.unblock();
                    }
                })
                .error(function () {
                    toastr.error("Có lỗi khi lấy danh sách đợt thi!");
                    $scope.processQuantity--;
                    if ($scope.processQuantity === 0) {
                        uiService.unblock();
                    }
                });

            semesterService.getSemesters()
                .success(function (data) {
                    $scope.semesters = data;
                    $scope.processQuantity--;
                    if ($scope.processQuantity === 0) {
                        uiService.unblock();
                    }
                })
                .error(function () {
                    toastr.error("Có lỗi khi lấy học kỳ.");
                    $scope.processQuantity--;
                    if ($scope.processQuantity === 0) {
                        uiService.unblock();
                    }
                });

        }());

        // Open add exam modal popup.
        $scope.showAdd = function () {
            $scope.exam = null;
            $scope.semester = "";
            //$scope.termOptions = [{ name: "Cuối kỳ" }, { name: "Giữa kỳ" }];
            $scope.term = "Cuối kỳ";
            $scope.year = ($scope.previousYear - 2) + "_" + ($scope.previousYear - 1);
            $scope.editMode = false;

            $("#examModal").modal("show");
        };

        // Create exam.
        $scope.create = function () {
            uiService.block();
            var currentExam = {};
            currentExam.name = $scope.getExamName();
            currentExam.userId = "1";

            examService.createExam(currentExam)
                .success(function (data) {
                    $scope.exams.unshift(data);
                    $scope.exam = null;
                    $("#examModal").modal("hide");
                    toastr.success("Tạo đợt thi thành công.");
                    uiService.unblock();
                })
                .error(function () {
                    toastr.error("Có lỗi khi tạo đợt thi.");
                    uiService.unblock();
                });
        };

        // Open edit exam modal popup.
        $scope.showEdit = function () {
            $scope.exam = this.exam;

            var examName = $scope.exam.name;

            var split = examName.match("HK(.*) - (.*) - ");

            var yearStr = examName.match("NH (.*)")[1];
            $scope.year = $scope.yearOptions.find(x => x === yearStr);
            if ($scope.year === undefined) {
                $scope.yearOptions.push(yearStr);
                $scope.year = yearStr;
            }

            $scope.semester = $scope.semesters.find(x => x.name === split[1]);
            if ($scope.semester === undefined) {
                var newSemester = { id: 0, name: split[1] };
                $scope.semesters.push(newSemester);
                $scope.semester = newSemester;
            }

            $scope.term = $scope.termOptions.find(x => x === split[2]);
            if ($scope.term === undefined) {
                $scope.termOptions.push(split[2]);
                $scope.term = split[2];
            }

            $scope.editMode = true;
            $("#examModal").modal("show");
        };

        // Update exam.
        $scope.update = function () {
            uiService.block();
            var currentExam = this.exam;
            currentExam.name = $scope.getExamName();

            examService.updateExam(currentExam)
                .success(function () {
                    currentExam.editMode = false;
                    $("#examModal").modal("hide");
                    toastr.success("Sửa thông tin đợt thi thành công.");
                    uiService.unblock();
                })
                .error(function () {
                    toastr.error("Có lỗi khi sửa thông tin đợt thi.");
                    uiService.unblock();
                });
        };

        // Open delete exam confirmation.
        $scope.showConfirm = function () {
            $scope.exam = this.exam;
            $("#confirmModal").modal("show");
        };

        // Delete exam.
        $scope.delete = function () {
            uiService.block();
            var currentExam = $scope.exam;

            examService.deleteExam(currentExam.id)
                .success(function () {
                    $scope.exams.splice($scope.exams.indexOf(currentExam), 1);
                    $("#confirmModal").modal("hide");
                    toastr.success("Xóa đợt thi thành công.");
                    uiService.unblock();
                })
                .error(function () {
                    $("#confirmModal").modal("hide");
                    toastr.error("Có lỗi khi xóa đợt thi.");
                    uiService.unblock();
                });
        };

        // Close modal popup.
        $scope.cancel = function () {
            $scope.exam = null;
            $("#examModal").modal("hide");
        };
    }]);
});
