/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('MatrixDetails', {
		Id: {
			type: DataTypes.BIGINT,
			allowNull: false,
			primaryKey: true,
			autoIncrement: true
		},
		MatrixId: {
			type: DataTypes.INTEGER,
			allowNull: false,
			references: {
				model: 'Matrices',
				key: 'Id'
			}
		},
		ChapterId: {
			type: DataTypes.INTEGER,
			allowNull: false
		},
		Quantity: {
			type: DataTypes.INTEGER,
			allowNull: false
		},
		Excluded: {
			type: DataTypes.STRING,
			allowNull: true
		},
		Factor: {
			type: DataTypes.INTEGER,
			allowNull: true
		}
	}, {
		timestamps: false,
		tableName: 'MatrixDetails'
	});
};
