/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('ShiftSubjects', {
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
			allowNull: true,
			references: {
				model: 'Subjects',
				key: 'Id'
			}
		},
		MatrixId: {
			type: DataTypes.INTEGER,
			allowNull: true,
			references: {
				model: 'Matrices',
				key: 'Id'
			}
		},
		SubjectCode: {
			type: DataTypes.STRING,
			allowNull: true
		},
		SubjectName: {
			type: DataTypes.STRING,
			allowNull: true
		},
		GroupCode: {
			type: DataTypes.STRING,
			allowNull: true
		},
		SubGroupCode: {
			type: DataTypes.STRING,
			allowNull: true
		},
		StartTime: {
			type: DataTypes.DATE,
			allowNull: true
		},
		EndTime: {
			type: DataTypes.DATE,
			allowNull: true
		},
		Ended: {
			type: DataTypes.BOOLEAN,
			allowNull: true
		},
		EndDate: {
			type: DataTypes.DATE,
			allowNull: true
		},
		ActivateTime: {
			type: DataTypes.DATE,
			allowNull: true
		},
		Duration: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		CreatedQuestionSheet: {
			type: DataTypes.BOOLEAN,
			allowNull: false,
			defaultValue: '0'
		},
		StateActivate: {
			type: DataTypes.INTEGER,
			allowNull: true
		}
	}, {
		timestamps: false,
		tableName: 'ShiftSubjects'
	});
};
