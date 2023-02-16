// auth.route.js
var express = require("express");
var router = express.Router();
var _ = require("lodash");
var jwt = require("jsonwebtoken");
var config = require("../config/main");
var authService = require("../services/auth.service");
var passport = require("passport");

// Set up middleware
var requireAuth = authService.requireAuth();

// Bring in defined Passport Strategy
require("../config/passport")(passport);
router.get("/loggedin", requireAuth, (req, res, next) => {
    // console.log(
    //     "Route auth: " +
    //     req.user.ShiftSubjectId +
    //     req.user.QuestionSheetId +
    //     " StudentId: " +
    //     req.user.StudentId
    // );
    authService
        .loginSuccess(
            req.user.ShiftSubjectId,
            req.user.QuestionSheetId,
            req.user.StudentId
        )
        .then((data) => {
            res.status(200).send(req.user);
        })
        .catch((err) => {
            res.sendStatus(404);
        });
    // req.on('error', function(e){
    //     console.log('client closed unexpectedly');
    // })
    // req.on('end', function(){
    //     console.log('client ended normally');
    // })
});

router.post("/login", (req, res, next) => {
    var studentCode = req.body.studentCode;
    var password = req.body.password;
    console.log(studentCode, password);
    if (_.isEqual(studentCode, password)) {
        authService.checkStudentCode(studentCode).then((data) => {
            if (_.isEmpty(data[0])) {
                res.status(404).send("Sinh viên không có trong danh sách ca thi");
            } else {
                authService.checkStudentHasLogin(studentCode).then((data) => {
                    if (_.isEmpty(data[0])) {
                        res
                            .status(404)
                            .send(
                                "Sinh viên hiện đang trong ca thi hoặc ca thi chưa được kích hoạt"
                            );
                    } else {
                        const token = jwt.sign({ code: data[0].Code }, config.secret, {
                            expiresIn: 86400, // 24h in seconds,
                        });
                        res
                            .status(200)
                            .json({ success: true, token: "JWT " + token, student: data[0] });
                    }
                });
            }
        });
    } else {
        res.status(401).send(401, "Mã sinh viên hoặc mật khẩu không trùng khớp");
    }
});

router.post("/logout", requireAuth, (req, res, next) => {
    var shiftSubjectId = req.user.ShiftSubjectId;
    var questionSheetId = req.user.QuestionSheetId;
    var studentId = req.user.StudentId;
    //console.log(studentId);
    authService
        .logout(shiftSubjectId, questionSheetId, studentId)
        .then(function(response) {
            req.logOut();
            res.status(200).send(true);
            localStorage.removeItem("ngStorage-currentUser");
        })
        .catch((err) => {
            res.status(404).send(false);
        });
});

module.exports = router;