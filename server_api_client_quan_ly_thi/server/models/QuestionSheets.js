/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('QuestionSheets', {
		Id: {
			type: DataTypes.BIGINT,
			allowNull: false,
			primaryKey: true,
			autoIncrement: true
		},
		Name: {
			type: DataTypes.STRING,
			allowNull: true
		},
		CreateDate: {
			type: DataTypes.DATE,
			allowNull: true
		},
		Approved: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		Started: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		Completed: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		ExtraTime: {
			type: DataTypes.INTEGER,
			allowNull: false
		},
		ExtraTimeReason: {
			type: DataTypes.STRING,
			allowNull: true
		},
		Mark: {
			type: DataTypes.DECIMAL,
			allowNull: true
		},
		NumberOfCorrect: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		Total: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		Difficulty: {
			type: DataTypes.DECIMAL,
			allowNull: true
		},
		UserId: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		StudentId: {
			type: DataTypes.INTEGER,
			allowNull: false,
			defaultValue: '((0))'
		},
		ShiftId: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		ShiftSubjectId: {
			type: DataTypes.BIGINT,
			allowNull: false,
			defaultValue: '((0))'
		}
	}, {
		timestamps: false,
		tableName: 'QuestionSheets'
	});
};
