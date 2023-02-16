const Sequelize = require("sequelize");
const dbConfig = require("../config/main");

// config sequelize
const sequelize = new Sequelize(
    dbConfig.database,
    dbConfig.username,
    dbConfig.password, {
        host: dbConfig.host,
        dialect: dbConfig.dialect,
        logging: false, // hide logging in console
        freezeTableName: true,
        operatorsAliases: false,
        dialectOptions: {
            options: {
                encrypt: true,
                enableArithAbort: true,
                trustServerCertificate: false,
            },
        },
    }
);

// test database connection
sequelize
    .authenticate()
    .then(() => {
        console.log("Database connection has been established successfully.");
    })
    .catch((err) => {
        console.error("Unable to connect to the database:", err);
    });

module.exports = sequelize;