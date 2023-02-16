// shift.service.js
const DataTypes = require('sequelize');
var sequelize = require('../models/db');
var ShiftSubjects = require('../models/ShiftSubjects')(sequelize, DataTypes);

class ShiftSubjectsService {
    /**
     * Take one-third of the time remaining
     * @param {*int} shiftId 
     */
    TakeOneThirdOfTheTimeRemainning(shiftId){
		console.log("Ids: " + shiftId);
        return ShiftSubjects.findOne({
            where:{
                Id: shiftId
            },
            attributes: ['Id', 'StartTime', 'EndTime']
        });
    }
}

module.exports = ShiftSubjectsService;