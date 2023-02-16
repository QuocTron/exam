module.exports = {
    secret: "longobnoxiouspassphrase",
    currentStringPath: /E:\\\\ObjectiveTest\\/g,
    /*/D:\\GoogleDrive\\Projects\\ExaminationSystem\\client\\resources\\ObjectiveTest\\/g,*/
    newStringPath: "http://localhost:60160/ObjectiveTest/", //'..\\..\\ObjectiveTest\\',
    resourcePath: "http://localhost:2022/ObjectiveTest/Files/",
    username: "sa", // username of mssql
    password: "1111", // password of mssql
    host: "localhost",
    database: "QuanLyTracNghiem",
    options: {
        encrypt: true,
        enableArithAbort: true,
        trustServerCertificate: true,
    }, // database of mssql
    dialect: "mssql",
    port: "1433",
    timezone: "+07:00",
};