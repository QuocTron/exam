/* jshint indent: 1 */

module.exports = function(sequelize, DataTypes) {
	return sequelize.define('Answers', {
		Id: {
			type: DataTypes.BIGINT,
			allowNull: false,
			primaryKey: true,
			autoIncrement: true
		},
		QuestionId: {
			type: DataTypes.BIGINT,
			allowNull: true,
			references: {
				model: 'Questions',
				key: 'Id'
			}
		},
		Content: {
			type: DataTypes.STRING,
			allowNull: true
		},
		Order: {
			type: DataTypes.INTEGER,
			allowNull: true
		},
		Correct: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		Interchange: {
			type: DataTypes.BOOLEAN,
			allowNull: false
		},
		SelectedTimes: {
			type: DataTypes.INTEGER,
			allowNull: true
		}
	}, {
    	timestamps: false,
    	tableName: 'Answers'
	});
};
