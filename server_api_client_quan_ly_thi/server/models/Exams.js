/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('Exams', {
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
		CreateDate: {
			type: DataTypes.DATE,
			allowNull: true
		},
		Desktop: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		Deleted: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		UserId: {
			type: DataTypes.INTEGER,
			allowNull: true
		}
	}, {
		timestamps: false,
		tableName: 'Exams'
	});
};
