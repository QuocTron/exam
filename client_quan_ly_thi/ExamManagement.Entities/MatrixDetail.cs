namespace ExamManagement.Entities
{
    public class MatrixDetail
    {
        public long Id { get; set; }
        public int MatrixId { get; set; }
        public int ChapterId { get; set; }
        public int Quantity { get; set; }
        public string Excluded { get; set; }
        public int? Factor { get; set; }

        public Matrix Matrix { get; set; }
    }
}