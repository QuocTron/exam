/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('Chapters', {
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
		Content: {
			type: DataTypes.STRING,
			allowNull: true
		},
		Order: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		ParentId: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		SubjectId: {
			type: DataTypes.INTEGER,
			allowNull: true,
			references: {
				model: 'Subjects',
				key: 'Id'
			}
		},
		ManagementOrder: {
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
		tableName: 'Chapters'
	});
};
