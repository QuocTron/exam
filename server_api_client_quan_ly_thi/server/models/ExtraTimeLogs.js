/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('ExtraTimeLogs', {
		Id: {
			type: DataTypes.INTEGER,
			allowNull: false,
			primaryKey: true,
			autoIncrement: true
		},
		Reason: {
			type: DataTypes.STRING,
			allowNull: true
		},
		ExtraTime: {
			type: DataTypes.INTEGER,
			allowNull: false
		},
		QuestionSheetId: {
			type: DataTypes.BIGINT,
			allowNull: true,
			references: {
				model: 'QuestionSheets',
				key: 'Id'
			}
		}
	}, {
		timestamps: false,
		tableName: 'ExtraTimeLogs'
	});
};
