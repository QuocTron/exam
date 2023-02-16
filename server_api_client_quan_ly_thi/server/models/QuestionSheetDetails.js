/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('QuestionSheetDetails', {
		QuestionSheetId: {
			type: DataTypes.BIGINT,
			allowNull: false,
			primaryKey: true,
			references: {
				model: 'QuestionSheets',
				key: 'Id'
			}
		},
		QuestionId: {
			type: DataTypes.BIGINT,
			allowNull: false,
			primaryKey: true,
			references: {
				model: 'Questions',
				key: 'Id'
			}
		},
		Order: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		AnswerId: {
			type: DataTypes.BIGINT,
			allowNull: true
		},
		Correct: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		CreateDate: {
			type: DataTypes.DATE,
			allowNull: true
		},
		UpdateDate: {
			type: DataTypes.DATE,
			allowNull: true
		},
		ListenTimes: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		Desktop: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		Deleted: {
			type: DataTypes.BOOLEAN,
			allowNull: false,
		}
	}, {
		timestamps: false,
		tableName: 'QuestionSheetDetails'
	});
};
