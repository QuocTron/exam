namespace ExamManagement.APIs.ViewModels
{
    public class MatrixDetailViewModel
    {
        public long Id { get; set; }
        public int MatrixId { get; set; }
        public int ChapterId { get; set; }
        public int Quantity { get; set; }
        public string Excluded { get; set; }
        public int Factor { get; set; }
        
    }
}