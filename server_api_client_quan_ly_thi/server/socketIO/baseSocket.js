var _ = require("lodash");
let students = [];
const addStudent = (studentCode, socketId) => {
    if (studentCode != undefined) {
        studentCode != undefined &&
            !students.some((student) => student.studentCode === studentCode) &&
            students.push({
                studentCode,
                socketId,
            });
    }
};
const removeStudent = (socketId) => {
    students = students.filter((student) => student.socketId !== socketId);
};

const getStudent = (studentCode) => {
    return students.find((student) => student.studentCode === studentCode);
};

module.exports = (io) => {
    console.log("Connect");
    io.on("connection", (socket) => {
        // when connect
        console.log("a student connected.", socket.id);

        //take userId and socketId from user
        socket.on("addStudent", (studentCode) => {
            console.log("studentCode", studentCode);
            addStudent(studentCode, socket.id);
            console.log(students);

            io.emit("getStudents", students);
        });

        // send reset login
        socket.on("resetLogin", (studentCode) => {
            const student = getStudent(studentCode);
            console.log(student);
            if (student) {
                console.log(student, "đã gửi");
                io.to(student.socketId).emit("requireResetLogin", studentCode);
                removeStudent(socket.id);
                io.emit("getStudents", students);
            }
        });

        // when disconnect
        socket.on("disconnect", () => {
            console.log("student disconnected.");
            removeStudent(socket.id);
            io.emit("getStudents", students);
        });
    });
};