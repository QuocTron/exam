/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('RoleUsers', {
		Role_Id: {
			type: DataTypes.INTEGER,
			allowNull: false,
			primaryKey: true,
			references: {
				model: 'Roles',
				key: 'Id'
			}
		},
		User_Id: {
			type: DataTypes.INTEGER,
			allowNull: false,
			primaryKey: true,
			references: {
				model: 'Users',
				key: 'Id'
			}
		}
	}, {
		timestamps: false,
		tableName: 'RoleUsers'
	});
};
