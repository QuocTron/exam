/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('Semesters', {
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
		Comment: {
			type: DataTypes.STRING,
			allowNull: true
		},
		Deleted: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		}
	}, {
		timestamps: false,
		tableName: 'Semesters'
	});
};
