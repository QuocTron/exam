var express = require("express");
var router = express.Router();
var _ = require("lodash");
const ShiftSubjectsService = require("../services/shiftSubject.service");
var shiftSubjectService = new ShiftSubjectsService();

// router.get('/test', (req, res, next) => {

// });

router.get("/getonethirdtime", (req, res, next) => {
    var shiftId = req.query.shiftId;
    console.log("shiftId", shiftId);
    shiftSubjectService
        .TakeOneThirdOfTheTimeRemainning(shiftId)
        .then((data) => {
            //console.log("RETURN DATA OF TakeOneThirdOfTheTimeRemainning: " + data);
            let startTime = new Date(data.StartTime);
            let endTime = new Date(data.EndTime);
            let remainningTimes = (endTime - startTime) / (1000 * 60); // miliseconds to minutes
            console.log(remainningTimes);
            let one_thirdTimes = Math.round(remainningTimes / 3);
            endTime.setMinutes(endTime.getMinutes() - one_thirdTimes);
            res.status(200).json({ one_thirdTimes: endTime });
        })
        .catch((err) => {
            res.status(500).send(false);
        });
});

module.exports = router;