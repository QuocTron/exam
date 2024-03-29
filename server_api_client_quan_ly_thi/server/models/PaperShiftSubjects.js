/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('PaperShiftSubjects', {
		Id: {
			type: DataTypes.BIGINT,
			allowNull: false,
			primaryKey: true,
			autoIncrement: true
		},
		ShiftId: {
			type: DataTypes.INTEGER,
			allowNull: true,
			references: {
				model: 'Shifts',
				key: 'Id'
			}
		},
		SubjectId: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		MatrixId: {
			type: DataTypes.INTEGER,
			allowNull: true,
			references: {
				model: 'Matrices',
				key: 'Id'
			}
		},
		Deleted: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		}
	}, {
		timestamps: false,
		tableName: 'PaperShiftSubjects'
	});
};
