// app.js

var express = require("express");
var session = require("express-session");
var path = require("path");
var favicon = require("serve-favicon");
var logger = require("morgan");
var cookieParser = require("cookie-parser");
var bodyParser = require("body-parser");
var cors = require("cors");
var passport = require("passport");

// setup the router
var question = require("./routes/question.route");
var questionSheet = require("./routes/questionSheet.route");
var auth = require("./routes/auth.route");
var shifts = require("./routes/shift.route");

var app = express();

// view engine setup
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "pug");

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
// app.use(logger('dev'));
// parse application/json
app.use(bodyParser.json());
// parse application/x-www-form-urlencoded
// for easier testing with Postman or plain HTML forms
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "../client")));
app.use(cors());

// Initialize passport for use
app.use(passport.initialize());

//routes
app.use("/ObjectiveTest", express.static("ObjectiveTest"));
app.use("/api/questions", question);
app.use("/api/questionsheets", questionSheet);
app.use("/api/auth", auth);
app.use("/api/shifts", shifts);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error("Not Found");
    err.status = 404;
    next(err);
});

// error handler
app.use(function(err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get("env") === "development" ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render("error");
});

module.exports = app;