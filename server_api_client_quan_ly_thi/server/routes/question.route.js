// question.route.js
var express = require("express");
var router = express.Router();
var _ = require("lodash");
var questionService = require("../services/question.service");
var questionSheetService = require("../services/questionSheet.service");

router.get("/:questionId", (req, res, next) => {
    var questionId = req.params.questionId;
    // Invoke service to rechieve data
    questionService
        .getQuestionContent(questionId)
        .then((data) => {
            res.status(200).json(data);
        })
        .catch((err) => {
            res.status(404).send(false);
        });
});

router.get("/:questionId/answer", (req, res, next) => {
    var questionId = req.params.questionId;
    // Invoke service to rechieve data
    questionService
        .getAnswerByQuestionId(questionId)
        .then((data) => {
            res.status(200).json(data);
        })
        .catch((err) => {
            res.status(404).send(false);
        });
});

router.post("/updateanswer", (req, res, next) => {
    var questionSheetId = req.body.questionSheetId;
    var questionId = req.body.questionId;
    var answerId = req.body.answerId;

    // check QuestionSheet is completed
    questionSheetService
        .CompletedQuestionSheet(questionSheetId)
        .then((data) => {
            var completed = data.Completed;
            var state = 0;
            var shiftSubjectId = req.body.shiftSubjectId;

            questionService.checkState(shiftSubjectId).then((data) => {
                state = data.StateActivate;
                console.log("state: " + state);
                if (state == 2) {
                    if (completed == false) {
                        // if questionsheet false - Do
                        questionService
                            .UpdateAnswer(questionSheetId, questionId, answerId)
                            .then((data) => {
                                res
                                    .status(200)
                                    .json({ status: true, massage: "Câu trả lời đã cập nhật" });
                            })
                            .catch((err) => {
                                res.status(404).send(false);
                            });
                    } else {
                        res
                            .status(404)
                            .json({ status: false, massage: "Ca thi đã hoàn thành" });
                    }
                } else {
                    res
                        .status(200)
                        .json({
                            status: false,
                            message: "Ca thi đang được tạm dừng hoặc đã kết thúc",
                        });
                }
            });
        })
        .catch((err) => {
            res.status(404).send(false);
        });
});

router.get("/answer/listentimes", (req, res, next) => {
    // Invoke service to rechieve data
    var questionSheetId = req.query.questionSheetId;
    var questionId = req.query.questionId;
    // check QuestionSheet is completed
    questionSheetService
        .CompletedQuestionSheet(questionSheetId)
        .then((data) => {
            if (data.Completed == false) {
                // if questionsheet false - Do
                questionService
                    .getQuestionFromQuestionSheetDetail(questionSheetId, questionId)
                    .then((data) => {
                        if (data.ListenTimes < 5) {
                            questionService
                                .UpdateListenTimes(
                                    questionSheetId,
                                    questionId,
                                    data.ListenTimes
                                )
                                .then((data) => {
                                    res
                                        .status(200)
                                        .json({
                                            status: true,
                                            message: "Đã cập nhật số lần nghe của câu hỏi",
                                        });
                                })
                                .catch((err) => {
                                    console.log(err);
                                    res.status(404).send(false);
                                });
                        } else {
                            res
                                .status(404)
                                .json({
                                    status: false,
                                    message: "Câu hỏi này đã nghe đủ 5 lần",
                                });
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                        res.status(404).send(false);
                    });
            } else {
                res
                    .status(404)
                    .json({ status: false, message: "Ca thi đã hoàn thành" });
            }
        })
        .catch((err) => {
            console.log(err);
            res.status(404).send(false);
        });
});

module.exports = router;