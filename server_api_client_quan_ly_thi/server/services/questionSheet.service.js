// questionSheet.service.js
const DataTypes = require("sequelize");
var sequelize = require("../models/db");
var Students = require("../models/Students")(sequelize, DataTypes);
var ShiftSubjects = require("../models/ShiftSubjects")(sequelize, DataTypes);
var Shifts = require("../models/Shifts")(sequelize, DataTypes);
var Subjects = require("../models/Subjects")(sequelize, DataTypes);
var Chapters = require("../models/Chapters")(sequelize, DataTypes);
var Questions = require("../models/Questions")(sequelize, DataTypes);
var Answers = require("../models/Answers")(sequelize, DataTypes);
var QuestionSheets = require("../models/QuestionSheets")(sequelize, DataTypes);
var QuestionSheetDetails = require("../models/QuestionSheetDetails")(
    sequelize,
    DataTypes
);

// Eager loading
// =============================================
// Questions - Answers
Answers.belongsTo(Questions);
Questions.hasMany(Answers);

// Questions - Subjects
Questions.belongsTo(Subjects); // Will add SubjectId to Questions

// Questions - Chapters
Questions.belongsTo(Chapters); // Will add ChapterId to Questions

// QuestionSheets - QuestionSheetDetails
QuestionSheetDetails.belongsTo(QuestionSheets);
QuestionSheets.hasMany(QuestionSheetDetails);

// QuestionSheetDetails
QuestionSheetDetails.belongsTo(Questions); // Will add QuestionId to QuestionSheetDetails

/**
 * get question sheet info
 */
exports.getQuestionSheetByStudentCode = (studentCode) => {
    return sequelize.query(
        "exec GetQuestionSheetByStudentCode @studentCode='" + studentCode + "'", {
            type: sequelize.QueryTypes.SELECT,
        }
    );
};

/**
 * get question sheet result
 */
exports.getResult = (questionSheetId) => {
    return sequelize.query(
        "exec GetResult @questionSheetId='" + questionSheetId + "'", {
            type: sequelize.QueryTypes.SELECT,
        }
    );
};

/**
 * get mark of question sheet
 */
exports.getMarkByQuestionId = (questionSheetId) => {
    return sequelize.query(
        "exec CaculateMark @questionSheetId='" +
        questionSheetId +
        "';exec GetMark @questionSheetId='" +
        questionSheetId +
        "'", {
            type: sequelize.QueryTypes.SELECT,
        }
    );
};

/**
 * check question sheet complete
 */
exports.CompletedQuestionSheet = (questionSheetId) => {
    // check if question is completed
    return QuestionSheets.findOne({
        where: {
            id: questionSheetId,
        },
        attributes: ["Id", "Name", "Completed"],
    });
};

/**
 * get question sheet time
 */
exports.GetRemainingTimeByQuestionSheetId = (
    questionSheetId,
    shiftSubjectId
) => {
    return sequelize.query(
        `EXEC GetRemainingTimeByQuestionSheetId @questionSheetId='${questionSheetId}', @shiftSubjectId='${shiftSubjectId}'`, {
            type: sequelize.QueryTypes.SELECT,
        }
    );
};

/**
 * get review question
 */
exports.GetReviewQuestion = (questionSheetId) => {
    return sequelize.query(
        "exec GetReviewQuestion @questionSheetId='" + questionSheetId + "'", {
            type: sequelize.QueryTypes.SELECT,
        }
    );
};

/**
 * start QuestionSheet
 */
exports.StartQuestionSheet = (questionSheetId) => {
    return QuestionSheets.update({
        Started: true,
    }, {
        where: {
            Id: questionSheetId,
        },
    });
};

/**
 * check QuestionSheet is started
 */
exports.CheckQuestionSheetIsStart = (questionSheetId) => {
    console.log(questionSheetId);
    return QuestionSheets.findOne({
        where: {
            Id: 152,
        },
        attributes: ["Id", "Started"],
    });
};

/**
 * Get QuestionSheet by questionSheetId
 * param {id} : questionSheetId
 */
exports.GetQuestionSheet = (id) => {
    return sequelize.query(`EXEC GetQuestionSheet @questionsheetid = ${id}`, {
        type: sequelize.QueryTypes.SELECT,
    });
    // return QuestionSheetDetails.findAll({
    //     where: {
    //         QuestionSheetId: id
    //     },
    //     attributes: ['QuestionSheetId', 'QuestionId', ['Order', 'QuestionOrder'], ['AnswerId', 'AnswerCurrentChoose'], 'Correct', 'ListenTimes'],
    //     include: [
    //         {
    //             model: Questions, attributes: ['Id', ['Content', 'QuestionContent'], 'ParentId', 'Audio'],
    //             include: [
    //                 { model: Subjects, attributes: ['Id', 'Code', 'Name'] },
    //                 { model: Chapters, attributes: ['Id', 'Name', ['Content', 'ChapterContent'], 'SubjectId', ['ParentId', 'ChapterParentId']] },
    //                 { model: Answers, attributes: ['Id', ['Content', 'AnswerContent'], ['Order', 'AnswerOrder']] },
    //             ]
    //         }
    //     ]
    // });
};

/**
 * Get the results of the question list according questionSheetId
 */
exports.GetResultOfTheQuestionList = (id) => {
    return QuestionSheetDetails.findAll({
        where: {
            QuestionSheetId: id,
        },
        attributes: ["QuestionId", "AnswerId", "Correct"],
    });
};

/**
 * Update the correct number of times of the question
 * param {id} : questionId
 * param {correct} : default false
 */
exports.UpdateTheCorrectNumberOfTimesOfTheQuestion = (id, correct) => {
    return Questions.findById(id).then((question) => {
        if (correct == true) {
            return question.increment(["SelectedTimes", "CorrectTimes"], { by: 1 });
        } else {
            return question.increment("SelectedTimes", { by: 1 });
        }
    });
};

/**
 * Update the correct number of times selected by the answer
 * param {id} : answerId
 */
exports.UpdateTheCorrectNumberOfTimesSelectedByTheAnswer = (id) => {
    return Answers.findById(id).then((answer) => {
        if (answer != null) {
            return answer.increment("SelectedTimes", { by: 1 });
        }
    });
};