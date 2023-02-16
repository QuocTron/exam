// question.service.js
const DataTypes = require('sequelize');
var sequelize = require('../models/db');
var Questions = require('../models/Questions')(sequelize, DataTypes);
var Answers = require('../models/Answers')(sequelize, DataTypes);
var QuestionSheets = require('../models/QuestionSheets')(sequelize, DataTypes);
var QuestionSheetDetails = require('../models/QuestionSheetDetails')(sequelize, DataTypes);
var ShiftSubjects = require("../models/ShiftSubjects")(sequelize, DataTypes);
/**
 * Get question content
 */
exports.getQuestionContent = (questionId) => {
    return Questions.findOne({
        where: {
            Id: questionId
        },
        attributes: ['Id', 'Content', 'ChapterId', 'ParentId', 'Audio', 'SubjectId',]
    });
}

/**
 * Get question detail from QuestionSheetDetail
 */
exports.getQuestionFromQuestionSheetDetail = (questionSheetId, questionId) => {
    return QuestionSheetDetails.findOne({
        where: {
            QuestionSheetId: questionSheetId,
            QuestionId: questionId
        },
        attributes: ['QuestionSheetId', 'QuestionId', 'ListenTimes']
    });
}

/**
 * Get answer content by question id
 */
exports.getAnswerByQuestionId = (questionId) => {
    return Answers.findAll({
        where: {
            QuestionId: questionId
        },
        attributes: ['Id', 'QuestionId', 'Content', 'Order']
    });
}

exports.checkState = (shiftSubjectId) => {
    return ShiftSubjects.findOne({
        where: {
            Id: shiftSubjectId
        }, 
        attributes: ['StateActivate']
    });
}

/**
 * update answer
 */
exports.UpdateAnswer = (questionSheetId, questionId, answerId) => {
    return QuestionSheetDetails.update({
        AnswerId: answerId
    }, {
            where: {
                QuestionSheetId: questionSheetId,
                QuestionId: questionId
            }
        });
}

/**
 * update listen time if question is audio
 */
exports.UpdateListenTimes = (questionSheetId, questionId, times) => {
    return QuestionSheetDetails.update({
        ListenTimes: (times + 1)
    }, {
            where: {
                QuestionSheetId: questionSheetId,
                QuestionId: questionId
            }
        });
}