define(["app", "semesterService", "markRoundingService"], function (app) {
    app.controller("settingCtrl", ["$scope", "$filter", "toastr", "semesterService", "markRoundingService", "uiService", function ($scope, $filter, toastr, semesterService, markRoundingService, uiService) {

        $scope.semesters = [];
        $scope.markRoundings = [];
        $scope.selectedMR = {};

        //Initial data
        (function () {
            $scope.processQuantity = 2;
            uiService.block();
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

            markRoundingService.getAll()
                .success(data => {
                    $scope.markRoundings = data;
                    $scope.selectedMR = $scope.markRoundings.find(c => c.using);
                    $scope.processQuantity--;
                    if ($scope.processQuantity === 0) {
                        uiService.unblock();
                    }
                }).error(() => {
                    toastr.error("Có lỗi khi lấy danh sách làm tròn điểm");
                    $scope.processQuantity--;
                    if ($scope.processQuantity === 0) {
                        uiService.unblock();
                    }
                });

        }());
        //BEGIN SEMESTER MANAGE
        // Open modal
        $scope.showSemesterManageModal = function () {
            $("#semesterManageModal").modal("show");
        };

        // Close modal
        $scope.closeSemesterManageModal = function () {
            $("#semesterManageModal").modal("hide");
        };

        // Open add modal
        $scope.showAddSemesterModal = function () {
            $("#addSemesterModal").modal("show");
        };

        // Close add modal
        $scope.closeAddSemesterModal = function () {
            $("#addSemesterModal").modal("hide");
        };
        // Add semester
        $scope.addSemester = function () {
            uiService.block();
            semesterService.createSemester(this.semester.name)
                .success(function (data) {
                    toastr.success("Thêm học kỳ thành công.");

                    //reload
                    semesterService.getSemesters()
                        .success(function (data) {
                            $scope.semesters = data;
                            $scope.closeAddSemesterModal();
                            uiService.unblock();
                        })
                        .error(function () {
                            toastr.error("Có lỗi khi lấy học kỳ.");
                        });
                })
                .error(function () {
                    toastr.error("Có lỗi khi thêm học kỳ.");
                    uiService.unblock();
                });
        };

        $scope.showUpdateSemester = function () {
            $scope.semesterTemp = {};
            $scope.semesterTemp.id = this.semester.id;
            $scope.semesterTemp.name = this.semester.name;
            $scope.semester = this.semester;
            $("#updateSemesterModal").modal("show");
        };

        $scope.closeUpdateSemester = function () {
            $scope.semesterTemp = null;
            $scope.semester = null;
            $("#updateSemesterModal").modal("hide");
        };

        $scope.updateSemester = function () {
            uiService.block();
            semesterService.updateSemester($scope.semesterTemp)
                .success(function () {
                    uiService.unblock();
                    $scope.semester.name = $scope.semesterTemp.name;
                    $scope.semester = null;
                    $scope.semesterTemp = null;
                    toastr.success("Cập nhật học kỳ thành công");
                    $scope.closeUpdateSemester();

                    
                })
                .error(function () {
                    uiService.unblock();
                    toastr.error("Cập nhật thất bại");
                });
        };

        $scope.showDeleteSemester = function () {
            $scope.semester = this.semester;
            $("#deleteSemesterModal").modal("show");
        };

        $scope.closeDeleteSemester = function () {
            $scope.semester = null;
            $("#deleteSemesterModal").modal("hide");
        };

        $scope.deleteSemester = function () {
            uiService.block();
            semesterService.deleteSemester($scope.semester.id)
                .success(function () {
                    toastr.success("Xóa học kỳ thành công");

                    //reload
                    semesterService.getSemesters()
                        .success(function (data) {
                            $scope.semesters = data;
                            $scope.closeDeleteSemester();
                            uiService.unblock();
                        })
                        .error(function () {
                            toastr.error("Có lỗi khi lấy học kỳ.");
                        });

                })
                .error(function () {
                    uiService.unblock();
                    toastr.error("Xóa học kỳ thất bại");
                });
        };

        //END SEMESTER MANAGE

        //BEGIN MARK ROUNDING
        // Open modal
        $scope.showMarkRoundModal = function () {
            uiService.block();
            markRoundingService.getAll().success(function (data) {
                $scope.markRoundings = data;
                $scope.selectedMR = $scope.markRoundings.find(c => c.using);
                uiService.unblock();
                $("#markRoundModal").modal("show");
            }).error(function () {
                toastr.error('Lấy danh sách làm tròn thất bại');
                uiService.unblock();
            });

        };

        //show cofirm modal
        $scope.showConfirmMarkroundingModal = function () {
            $('#markRoundConfirmModal').modal('show');
        };
        // Close confirm modal
        $scope.closeConfirmMarkroundingModal = function () {
            $('#markRoundConfirmModal').modal('hide');
        };

        // Close modal
        $scope.closeMarkRoundModal = function () {
            $("#markRoundModal").modal("hide");
        };

        $scope.selectMarkRounding = function () {
            uiService.block();
            markRoundingService.selectMarkRounding($scope.selectedMR.id).
                success(function () {
                    $scope.closeMarkRoundModal();
                    $scope.closeConfirmMarkroundingModal();
                    toastr.success("Đã thay đổi làm tròn điểm thành: "+$scope.selectedMR.name);
                    uiService.unblock();
                }).error(err => {
                    toastr.error("Thay đổi làm tròn điểm thất bại");
                    uiService.unblock();
                });
        };
        //END MARK ROUNDING
    }]);
});
