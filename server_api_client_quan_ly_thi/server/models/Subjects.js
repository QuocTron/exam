/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('Subjects', {
		Id: {
			type: DataTypes.INTEGER,
			allowNull: false,
			primaryKey: true,
			autoIncrement: true
		},
		Code: {
			type: DataTypes.STRING,
			allowNull: true
		},
		Name: {
			type: DataTypes.STRING,
			allowNull: true
		},
		FacultyId: {
			type: DataTypes.INTEGER,
			allowNull: true,
			references: {
				model: 'Faculties',
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
		tableName: 'Subjects'
	});
};
