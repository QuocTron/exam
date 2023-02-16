// auth.service.js
const DataTypes = require("sequelize");
var sequelize = require("../models/db");
var passport = require("passport");
var ShiftSubjectStudents = require("../models/ShiftSubjectStudents")(
    sequelize,
    DataTypes
);

/**
 * check student exist
 * @param {int} studentCode
 */
exports.checkStudentCode = (studentCode) => {
    return sequelize.query(
        `EXEC dbo.CheckStudentCode @studentCode = ${studentCode}`, { type: sequelize.QueryTypes.SELECT }
    );
};

/**
 * update login if student login success
 * @param {int} shiftSubjectId
 * @param {int} questionSheetId
 * @param {int} studentId
 */
exports.loginSuccess = (shiftSubjectId, questionSheetId, studentId) => {
    return sequelize.query(
        "exec LoginSuccess @shiftSubjectId='" +
        shiftSubjectId +
        "', @questionSheetId='" +
        questionSheetId +
        "', @studentId='" +
        studentId +
        "'", { type: sequelize.QueryTypes.SELECT }
    );
};

/**
 * check student has login into test system
 * @param {int} studentCode
 */
exports.checkStudentHasLogin = (studentCode) => {
    return sequelize.query(
        `exec CheckStudentHasLogin @studentCode= ${studentCode}`, { type: sequelize.QueryTypes.SELECT }
    );
};

/**
 * update login if student logout
 * @param {int} shiftSubjectId
 * @param {int} questionSheetId
 * @param {int} studentId
 */
exports.logout = (shiftSubjectId, questionSheetId, studentId) => {
    // return sequelize.query('exec LogOut @shiftSubjectId=\'' + shiftSubjectId + '\', @questionSheetId=\'' + questionSheetId + '\', @studentId=\'' + studentId + '\'', { type: sequelize.QueryTypes.SELECT })
    return ShiftSubjectStudents.update({
        LogIn: false,
    }, {
        where: {
            ShiftSubjectId: shiftSubjectId,
            QuestionSheetId: questionSheetId,
            StudentId: studentId,
        },
    });
};

/**
 * authorize route
 */
exports.requireAuth = () => {
    console.log(passport.authenticate("jwt", { session: false }));
    return passport.authenticate("jwt", { session: false });
};