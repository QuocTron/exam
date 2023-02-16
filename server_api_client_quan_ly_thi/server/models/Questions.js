/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('Questions', {
		Id: {
			type: DataTypes.BIGINT,
			allowNull: false,
			primaryKey: true,
			autoIncrement: true
		},
		Content: {
			type: DataTypes.STRING,
			allowNull: true
		},
		Interchange: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		SubjectiveDifficulty: {
			type: DataTypes.DECIMAL,
			allowNull: true
		},
		ObjectiveDifficulty: {
			type: DataTypes.DECIMAL,
			allowNull: false
		},
		SelectedTimes: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		CorrectTimes: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		ChapterId: {
			type: DataTypes.INTEGER,
			allowNull: false,
			references: {
				model: 'Chapters',
				key: 'Id'
			}
		},
		CreateDate: {
			type: DataTypes.DATE,
			allowNull: true
		},
		UpdateDate: {
			type: DataTypes.DATE,
			allowNull: true
		},
		Mark: {
			type: DataTypes.DECIMAL,
			allowNull: true
		},
		Duration: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		ParentId: {
			type: DataTypes.BIGINT,
			allowNull: false
		},
		Audio: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		Discrimination: {
			type: DataTypes.DECIMAL,
			allowNull: true
		},
		ManagementOrder: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		SubjectId: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		ListenedTimes: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		Validated: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		Deleted: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		}
	}, {
		timestamps: false,
		tableName: 'Questions'
	});
};
