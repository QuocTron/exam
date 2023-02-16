/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('MarkRoundings', {
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
		Using: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		Code: {
			type: DataTypes.STRING,
			allowNull: true
		}
	}, {
		timestamps: false,
		tableName: 'MarkRoundings'
	});
};
