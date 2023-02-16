// questionSheet.route.js
var express = require("express");
var router = express.Router();
var _ = require("lodash");
var questionSheetService = require("../services/questionSheet.service");
var pathConfig = require("../config/main");
var htmlToText = require("html-to-text");

// Update question difficulty
router.post("/questiondiffculty/update", (req, res, next) => {
    var questionSheetId = req.body.questionSheetId;
    questionSheetService
        .GetResultOfTheQuestionList(questionSheetId)
        .then((questionList) => {
            for (var i = 0; i < questionList.length; i++) {
                questionSheetService.UpdateTheCorrectNumberOfTimesOfTheQuestion(
                    questionList[i].QuestionId,
                    questionList[i].Correct
                );
                questionSheetService.UpdateTheCorrectNumberOfTimesSelectedByTheAnswer(
                    questionList[i].AnswerId
                );
            }
            res.send(true);
        })
        .catch((err) => {
            res.send(false);
        });
});

// Call recursive functions overlapping
function getChildNode(arr, parent) {
    var out = [];
    for (var i in arr) {
        if (arr[i].ParentId == parent) {
            var children = getChildNode(arr, arr[i].Id);
            if (children.length) {
                arr[i].children = [Object.assign({}, arr[i])];
                arr[i].children.push(...children);
            }
            out.push(arr[i]);
        }
    }
    return out;
}

// get question sheet detail by student code
router.get("/:studentCode", (req, res, next) => {
    // Invoke service to rechieve data
    // var studentCode = req.params.studentCode
    // questionSheetService.getQuestionSheetByStudentCode(studentCode)
    //     .then((data) => {
    //         if (_.isEmpty(data)) {
    //             res.status(404).send('Dữ liệu đề thi rỗng');
    //         }
    //         var questions = _(data).groupBy('QuestionId').map(function (v, i) {
    //             // define values
    //             let Content = _.get(_.find(v, 'QuestionContent'), 'QuestionContent');
    //             let _removeAudioTag = _.get(_.find(v, 'QuestionContent'), 'QuestionContent').match("<audio>(.*?)</audio>");
    //             // conver object to array
    //             _removeAudioTag = _.map(_removeAudioTag, (v, i) => {
    //                 return v
    //             });
    //             let AudioUrl = _.get(_.find(v, 'QuestionContent'), 'QuestionContent').match("<audio>(.*?)</audio>");
    //             // conver object to array
    //             AudioUrl = _.map(AudioUrl, (v, i) => {
    //                 return v
    //             });
    //             Content = Content.replace(_removeAudioTag[1], ``);
    //             Content = Content.replace(`<audio></audio>`, ``);
    //             Content = Content.replace(pathConfig.currentStringPath, pathConfig.newStringPath);
    //             // If bind html to text use this as below
    //             // let Content = htmlToText.fromString(_.get(_.find(v, 'QuestionContent'), 'QuestionContent'));
    //             return {
    //                 Id: i,
    //                 Content: Content,
    //                 ParentId: _.get(_.find(v, 'ParentId'), 'ParentId'),
    //                 ChapterName: _.get(_.find(v, 'ChapterName'), 'ChapterName'),
    //                 Audio: _.get(_.find(v, 'Audio'), 'Audio'),
    //                 AudioUrl: _.replace(AudioUrl[1], pathConfig.currentStringPath, pathConfig.newStringPath),
    //                 ListenTimes: _.get(_.find(v, 'ListenTimes'), 'ListenTimes'),
    //                 OrderQuestion: _.get(_.find(v, 'OrderQuestion'), 'OrderQuestion'),
    //                 AnswerCurrentChoose: _.get(_.find(v, 'AnswerCurrentChoose'), 'AnswerCurrentChoose'),
    //                 Answers: _.map(v, function (v, i) {
    //                     return {
    //                         Id: v.AnswerId,
    //                         Content: v.AnswerContent.replace(pathConfig.currentStringPath, pathConfig.newStringPath),
    //                         Order: v.AnswerOrder
    //                     }
    //                 })
    //             }
    //         }).value();
    //         var results = getNestedChildren(questions, 0);
    //         // results = _(results).groupBy('ChapterName').map(function (v, i) {
    //         //     return {
    //         //         ChapterName: i,
    //         //         Questions: v
    //         //     }
    //         // }).value();
    //         results = _.orderBy(results, 'OrderQuestion', 'asc');
    //         res.status(200).json({ details: results });
    //     })
    //     .catch((err) => {
    //         res.status(404).send(false);
    //     });
});

// get review question by questionSheetId
router.get("/review/:questionSheetId", (req, res, next) => {
    // Invoke service to rechieve data
    var questionSheetId = req.params.questionSheetId;
    questionSheetService
        .GetReviewQuestion(questionSheetId)
        .then((data) => {
            if (_.isEmpty(data)) {
                res.status(404).send("không tìm thấy dữ liệu");
            }
            var reviewQuestions = _(data)
                .groupBy("QuestionId")
                .map(function(v, i) {
                    return {
                        Id: i,
                        // OrderQuestion: _.get(_.find(v, 'QuestionOrder'), 'QuestionOrder'),
                        ChapterName: _.get(_.find(v, "ChapterName"), "ChapterName"),
                        AnswerCurrentChoose: _.get(
                            _.find(v, "AnswerCurrentChoose"),
                            "AnswerCurrentChoose"
                        ),
                        ParentId: _.get(_.find(v, "ParentId"), "ParentId"),
                        QuestionOrder: _.get(_.find(v, "QuestionOrder"), "QuestionOrder"),
                        Answers: _.map(v, function(v, i) {
                            return {
                                Id: v.AnswerId,
                                CurrentId: v.AnswerId == v.AnswerCurrentChoose ?
                                    v.AnswerCurrentChoose : 0,
                                Order: v.AnswerOrder,
                            };
                        }),
                    };
                })
                .value();

            // reviewQuestions = reviewQuestions.map((v, i) => {
            //     if (v.Id == v.ParentId) {
            //         v.ParentId = 0
            //     }
            //     return v
            // });

            // var results = getChildNode(reviewQuestions, 0);

            // results = results.map((v, i) => {
            //     if (v.ParentId == 0) {
            //         return v
            //     }
            // });

            // reviewQuestions = _.orderBy(reviewQuestions, 'OrderQuestion', 'asc');

            res.status(200).json(reviewQuestions);
        })
        .catch((err) => {
            res.status(404).send(false);
        });
});

// get result of question sheet by questionSheetId
router.get("/result/:questionSheetId", (req, res, next) => {
    // Invoke service to rechieve data
    var questionSheetId = req.params.questionSheetId;
    questionSheetService
        .getResult(questionSheetId)
        .then((data) => {
            res.status(200).json(data);
        })
        .catch((err) => {
            res.status(404).send(false);
        });
});

// get mark
router.get("/result/mark/:questionSheetId", (req, res, next) => {
    // Invoke service to rechieve data
    var questionSheetId = req.params.questionSheetId;
    questionSheetService
        .getMarkByQuestionId(questionSheetId)
        .then((data) => {
            if (data.length == 0) {
                res.send(404);
            }
            res.status(200).json(data[1]);
        })
        .catch((err) => {
            res.status(404).send(false);
        });
});

// check is question sheet is completed
router.get("/completed/:questionSheetId", (req, res, next) => {
    // Invoke service to rechieve data
    var questionSheetId = req.params.questionSheetId;
    questionSheetService
        .CompletedQuestionSheet(questionSheetId)
        .then((data) => {
            res.status(200).json(data);
        })
        .catch((err) => {
            res.status(404).send(false);
        });
});

// get remaining time of questionsheet
router.get("/detail/remainningtime", (req, res, next) => {
    // Invoke service to rechieve data
    var questionSheetId = req.query.questionSheetId;
    var shiftSubjectId = req.query.shiftSubjectId;

    questionSheetService
        .GetRemainingTimeByQuestionSheetId(questionSheetId, shiftSubjectId)
        .then((data) => {
            if (data.length === 0) {
                res.send(404);
            }
            if (data[0].time < 0) {
                res.json(0);
            }
            console.log(data);
            console.log(data[0].Duration);
            res.status(200).json(data[0].Duration);
            // res.status(200).json(15);
        })
        .catch((err) => {
            res.status(404).send("Không lấy được thời gian làm bài");
        });
});

// start question sheet
router.post("/start", (req, res, next) => {
    var questionSheetId = req.body.questionSheetId;
    questionSheetService
        .StartQuestionSheet(questionSheetId)
        .then((data) => {
            res.status(200).json({ status: true, message: "Đã bắt đầu ca thi" });
        })
        .catch((err) => {
            res.status(404).send(false);
        });
});

// start question sheet
router.get("/:questionSheetId/checkstart", (req, res, next) => {
    var questionSheetId = req.params.questionSheetId;
    questionSheetService
        .CheckQuestionSheetIsStart(questionSheetId)
        .then((data) => {
            if (data.Started == true) {
                res.status(200).json({ status: true, message: "Ca thi đã bắt đầu" });
            } else {
                res.status(200).json({ status: false, message: "Ca thi chưa bắt đầu" });
            }
        })
        .catch((err) => {
            res.status(404).send(false);
        });
});

router.get("/details/:questionSheetId", (req, res, next) => {
    var questionSheetId = req.params.questionSheetId;
    questionSheetService
        .GetQuestionSheet(questionSheetId)
        .then((data) => {
            console.log("data", data);
            var questions = _(data)
                .groupBy("QuestionId")
                .map((v, i) => {
                    // define value todo
                    let Content = _.get(_.find(v, "QuestionContent"), "QuestionContent");

                    //TRANSFER AUDIOS PATH
                    let audioRegEx = /\[<audio\b[^>]*>]([\s\S]*?)\[<\/audio>]/g;
                    let audioRegEx_Once = /\[<audio>](.*)\[<\/audio>]/;
                    let AudioUrl = _.get(
                        _.find(v, "QuestionContent"),
                        "QuestionContent"
                    ).match(audioRegEx);
                    if (AudioUrl != null) {
                        //convert object to array
                        AudioUrl = _.map(AudioUrl, (v, i) => {
                            Content = Content.replace(v, "");
                            return pathConfig.resourcePath + v.match(audioRegEx_Once)[1];
                        });
                    }

                    //TRANSFER IMAGES PATH
                    let imgRegEx = /\[<img\b[^>]*>]([\s\S]*?)\[<\/img>]/g;
                    let imgRegEx_Once = /\[<img>](.*)\[<\/img>]/;
                    let imgMatches = _.get(
                        _.find(v, "QuestionContent"),
                        "QuestionContent"
                    ).match(imgRegEx);
                    if (imgMatches != null) {
                        //convert object to array
                        _.forEach(imgMatches, (v, i) => {
                            let imgUrl = v.match(imgRegEx_Once)[1];
                            let imgSrc =
                                "<img src='" + pathConfig.resourcePath + imgUrl + "'/>";
                            Content = Content.replace(v, imgSrc);
                        });
                    }

                    // If bind html to text use this as below
                    // let Content = htmlToText.fromString(_.get(_.find(v, 'QuestionContent'), 'QuestionContent'));

                    return {
                        Id: i,
                        // Content: _.get(_.find(v, 'QuestionContent'), 'QuestionContent'),
                        Content: Content,
                        ParentId: _.get(_.find(v, "QuestionParentId"), "QuestionParentId"),
                        SubjectName: _.get(_.find(v, "SubjectName"), "SubjectName"),
                        ChapterName: _.get(_.find(v, "ChapterName"), "ChapterName"),
                        Audio: _.get(_.find(v, "QuestionAudio"), "QuestionAudio"),
                        AudioUrl: AudioUrl,
                        ListenTimes: _.get(_.find(v, "ListenTimes"), "ListenTimes"),
                        OrderQuestion: _.get(_.find(v, "QuestionOrder"), "QuestionOrder"),
                        AnswerCurrentChoose: _.get(
                            _.find(v, "AnswerCurrentChoose"),
                            "AnswerCurrentChoose"
                        ),
                        Answers: _.map(v, function(v, i) {
                            return {
                                Id: v.AnswersId,
                                Content: v.AnswersContent == null || v.AnswersContent == "" ?
                                    v.AnswersContent : v.AnswersContent.replace(
                                        pathConfig.currentStringPath,
                                        pathConfig.newStringPath
                                    ),
                                Order: v.AnswersOrder,
                            };
                        }),
                    };
                })
                .value();

            questions = questions.map((v, i) => {
                if (v.Id == v.ParentId) {
                    v.ParentId = 0;
                }
                return v;
            });

            var results = getChildNode(questions, 0);

            results = results.map((v, i) => {
                if (v.ParentId == 0) {
                    return v;
                }
            });

            // res.json(data);
            res.status(200).json(results);
        })
        .catch((err) => {
            res.status(404).send(false);
        });
});

module.exports = router;