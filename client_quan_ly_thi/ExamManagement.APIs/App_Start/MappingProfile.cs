using AutoMapper;
using ExamManagement.APIs.ViewModels;
using ExamManagement.Entities;
using System.Linq;

namespace ExamManagement.APIs
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            // Domain to ViewModel
            CreateMap<Exam, ExamViewModel>();
            CreateMap<Shift, ShiftViewModel>();
            CreateMap<Question, QuestionViewModel>();
            CreateMap<Student, StudentViewModel>();
            CreateMap<Subject, SubjectViewModel>();
            CreateMap<Semester, SemesterViewModel>();
            CreateMap<MatrixDetail, MatrixDetailViewModel>();
            CreateMap<Matrix, MatrixViewModel>();
            CreateMap<ShiftSubject, ShiftSubjectViewModel>();
            CreateMap<ExtraTimeLog, ExtraTimeLogViewModel>();

            // ViewModel to Domain
            CreateMap<ExamViewModel, Exam>();
            CreateMap<ShiftViewModel, Shift>();
            CreateMap<QuestionViewModel, Question>();
            CreateMap<StudentViewModel, Student>();
            CreateMap<SubjectViewModel, Subject>();
            CreateMap<ShiftSubjectViewModel, ShiftSubject>();
            CreateMap<ExtraTimeLogViewModel, ExtraTimeLog>();
        }
    }
}