/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('Users', {
		Id: {
			type: DataTypes.INTEGER,
			allowNull: false,
			primaryKey: true,
			autoIncrement: true
		},
		Username: {
			type: DataTypes.STRING,
			allowNull: true
		},
		Password: {
			type: DataTypes.STRING,
			allowNull: true
		},
		Salt: {
			type: DataTypes.STRING,
			allowNull: true
		},
		Name: {
			type: DataTypes.STRING,
			allowNull: true
		},
		CreateDate: {
			type: DataTypes.DATE,
			allowNull: true
		},
		LogOut: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		LastActivity: {
			type: DataTypes.DATE,
			allowNull: true
		},
		LastLogIn: {
			type: DataTypes.DATE,
			allowNull: true
		},
		LastPasswordChanged: {
			type: DataTypes.DATE,
			allowNull: true
		},
		LastLogOut: {
			type: DataTypes.DATE,
			allowNull: true
		},
		Comment: {
			type: DataTypes.STRING,
			allowNull: true
		},
		BuildInUser: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		Deleted: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		FacultyId: {
			type: DataTypes.STRING,
			allowNull: true
		},
		SubjectId: {
			type: DataTypes.STRING,
			allowNull: true
		}
	}, {
		timestamps: false,
		tableName: 'Users'
	});
};
