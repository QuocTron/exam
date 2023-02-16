// passport.js
const DataTypes = require("sequelize");
var sequelize = require("../models/db");
var _ = require("lodash");
var JwtStrategy = require("passport-jwt").Strategy;
var ExtractJwt = require("passport-jwt").ExtractJwt;
var config = require("./main");

/**
 * load question sheet info of student
 * @param {int} studentCode
 */
var checkLoginByStudentCode = (studentCode) => {
    return sequelize.query(
        "exec CheckLoginByStudentCode @studentCode='" + studentCode + "'", { type: sequelize.QueryTypes.SELECT }
    );
};

// Setup work and export for the JWT passport strategy
module.exports = function(passport) {
    var opts = {
        jwtFromRequest: ExtractJwt.fromAuthHeader(),
        secretOrKey: config.secret,
    };
    passport.use(
        new JwtStrategy(opts, function(jwt_payload, done) {
            var studentCode = jwt_payload.code;
            var iat = parseInt(jwt_payload.iat);
            var exp = parseInt(jwt_payload.exp);
            if (!(exp - iat) > 0) {
                console.log("token was expired");
            } else {
                checkLoginByStudentCode(studentCode)
                    .then((data) => {
                        if (_.isEmpty(data[0])) {
                            return done(null, false, "Không tìm thấy thông tin ca thi");
                        } else {
                            return done(null, data[0]);
                        }
                    })
                    .catch((err) => {
                        return done(err, false, "Không tồn tại sinh viên trong ca thi");
                    });
            }
        })
    );
};