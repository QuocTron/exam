/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('Shifts', {
		Id: {
			type: DataTypes.INTEGER,
			allowNull: false,
			primaryKey: true,
			autoIncrement: true
		},
		Name: {
			type: DataTypes.STRING,
			allowNull: true
		},
		ExamId: {
			type: DataTypes.INTEGER,
			allowNull: true,
			references: {
				model: 'Exams',
				key: 'Id'
			}
		},
		QuestionSheetCreated: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		Desktop: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		Deleted: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		}
	}, {
		timestamps: false,
		tableName: 'Shifts'
	});
};
