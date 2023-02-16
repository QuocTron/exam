/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('Students', {
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
		LastName: {
			type: DataTypes.STRING,
			allowNull: true
		},
		FirstName: {
			type: DataTypes.STRING,
			allowNull: true
		},
		ClassName: {
			type: DataTypes.STRING,
			allowNull: true
		},
		Name: {
			type: DataTypes.STRING,
			allowNull: true
		}
	}, {
		timestamps: false,
		tableName: 'Students'
	});
};
