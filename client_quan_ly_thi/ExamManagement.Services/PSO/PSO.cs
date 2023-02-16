using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ExamManagement.Entities;

namespace ExamManagement.Services.PSO
{
    public class PSO
    {
        private readonly Dictionary<long, Dictionary<long, CauHoi>> Database;
        private readonly decimal DoKho;
        private MaTranDe maTranDe;
        private readonly int SoDe;
        public List<Dan> Dans;

        public PSO(MaTranDe maTranDe, Dictionary<long, Dictionary<long, CauHoi>> database, int soDe, decimal doKho)
        {
            this.maTranDe = maTranDe;
            this.Database = database;
            this.SoDe = soDe;
            this.DoKho = doKho;
        }

        public void Start()
        {
            var dans = Enumerable.Range(0, SoDe)
            .AsParallel()
            .Select((dan, vitri) => new Dan(vitri, Enumerable.Range(0, 10)
                .Select(caThe => new CaThe(DoKho, maTranDe, maTranDe
                    .Phans
                    .SelectMany(p =>
                    {
                        int soCauHienTai = 0;
                        var cauHois = Database[p.MaPhan]
                            .Values
                            .GroupBy(c => c.MaNhom != 0 ? c.MaNhom : c.MaCauHoi)//<==== ParentId checking
                            .OrderBy(c => Guid.NewGuid())
                            .Where(c =>
                            {
                                int soCauHoiTrongNhom = c.Count();


                                int count = soCauHienTai + soCauHoiTrongNhom;
                                if (count <= p.SoCauPhan)
                                {
                                    soCauHienTai = count;
                                    return true;
                                }
                                else
                                {
                                    return false;
                                }
                            })
                            .SelectMany(c => c);
                        return cauHois;
                    })
                    )
                    )));
            Dans = new List<Dan>(dans);
            Dans.AsParallel().ForAll(c => c.TimKiem(ref Dans, Database));
        }
    }
    public class PhanMaTran
    {
        public int MaPhan { get; private set; }
        public int SoCauPhan { get; private set; }
        public List<int> CacCauLoaiBo { get; private set; }

        public PhanMaTran(int maPhan_Form, int soCauPhan_Form, List<int> cacCauBo_Form)
        {
            MaPhan = maPhan_Form;
            SoCauPhan = soCauPhan_Form;
            CacCauLoaiBo = new List<int>(cacCauBo_Form);
        }
    }

    public class MaTranDe
    {
        public List<PhanMaTran> Phans { get; private set; }

        public MaTranDe(DataTable table)
        {
            if (table.Columns.Count != 3)
            {
                return;
            }
            Phans = new List<PhanMaTran>();
            for (int viTriPhan = 0; viTriPhan < table.Rows.Count; viTriPhan++)
            {
                List<int> listCauBo = new List<int>();
                if (table.Rows[viTriPhan][2].ToString() != "")
                {
                    listCauBo.AddRange(table.Rows[viTriPhan][2].ToString().Split(',').Select(Int32.Parse).ToList());
                }
                Phans.Add(new PhanMaTran(int.Parse(table.Rows[viTriPhan][0].ToString()), int.Parse(table.Rows[viTriPhan][1].ToString()), listCauBo));
            }
        }
        public MaTranDe(IEnumerable<MatrixDetail> matrixDetails)
        {
            Phans = new List<PhanMaTran>();

            foreach(var detail in matrixDetails)
            {
                List<int> listCauBo = new List<int>();
                listCauBo.AddRange(detail.Excluded.ToString().Split(',').Select(Int32.Parse).ToList());
                Phans.Add(new PhanMaTran(detail.ChapterId, detail.Quantity, listCauBo));
            }
        }
    }
    public class CauHoi
    {
        public long MaCauHoi { get; set; }
        public long MaNhom { get; set; }
        public decimal DoKho { get; set; }
        public int MaPhan { get; set; }
        public bool HoanVi { get; set; }
        public int ThuTu { get; set; }

        public CauHoi()
        {

        }
        public CauHoi(long maCau, int maPhanCau, decimal doKhoCau, long maCauCha, bool hoanVi, int thuTu)
        {
            MaCauHoi = maCau;
            MaPhan = maPhanCau;
            DoKho = doKhoCau;
            MaNhom = maCauCha;
            HoanVi = hoanVi;
            ThuTu = thuTu;
        }
    }

    public class CaThe
    {
        public List<CauHoi> CauHois { get; private set; }
        public MaTranDe MaTran { get; private set; }
        public decimal DoThichNghi { get; private set; }
        private readonly decimal DoKhoYeuCau;

        public CaThe()
        {

        }

        public CaThe(decimal doKhoNhap, MaTranDe maTranDe, IEnumerable<CauHoi> cauHois)
        {
            this.CauHois = new List<CauHoi>(cauHois);
            DoKhoYeuCau = doKhoNhap;
            this.MaTran = maTranDe;
            TinhDoThichNghi();
        }

        private void TinhDoThichNghi()
        {
            var soCauYeuCau = MaTran.Phans.Sum(c => c.SoCauPhan);
            var rangBuocSoLuongPhan = Math.Abs(CauHois.Count - soCauYeuCau);
            var rangBuocDoKho = Math.Abs(((decimal)CauHois.Sum(c => c.DoKho) / (decimal)CauHois.Count) - DoKhoYeuCau);
            DoThichNghi = rangBuocDoKho + rangBuocSoLuongPhan;
        }

        public void NhanThongTin(CaThe caTheTotNhat)
        {
            var giongNhau = caTheTotNhat.CauHois.Intersect(this.CauHois);
            var cacCauLay = caTheTotNhat.CauHois
                                .Except(giongNhau)
                                .GroupBy(c => c.MaNhom != 0 ? c.MaNhom : c.MaCauHoi)
                                .OrderBy(c => Guid.NewGuid())
                                .Take(this.CauHois.Count / 20 == 0 ? 1 : this.CauHois.Count / 20).ToList();//1 - 5%

            var cauHoiMois = new List<CauHoi>(this.CauHois);

            foreach (var cau in cacCauLay)
            {
                var cauDistinct = cau.Distinct().ToList();
                if (cauDistinct.Count() > 1)//Group question
                {
                    int maPhan = cauDistinct.First().MaPhan;
                    var cauLay = cauHoiMois
                                .Where(c => c.MaPhan == maPhan)
                                .Except(giongNhau)
                                .GroupBy(c => c.MaNhom != 0 ? c.MaNhom : c.MaCauHoi)
                                .OrderBy(c => Guid.NewGuid())
                                .GetContiguousBySum(cauDistinct.Count());


                    if (cauLay.Count > 1)
                    {
                        int indexCau = cauHoiMois.FindIndex(c => c == cauLay.First());
                        if((indexCau + cauLay.Count)> cauHoiMois.Count)
                        {

                            for (int i = indexCau; i < indexCau + cauLay.Count; i++)
                            {
                                cauHoiMois[i] = cauDistinct[i - indexCau];
                            }
                        }
                        else
                        {

                        }
                    }
                }
                else//single question
                {
                    var cauDon = cauDistinct.First();
                    var cauThayDoi = cauHoiMois.Where(s => s.MaPhan == cauDon.MaPhan).Except(giongNhau).OrderBy(s => Guid.NewGuid()).FirstOrDefault();
                    if (cauThayDoi != null)
                    {
                        cauHoiMois[cauHoiMois.FindIndex(c => c == cauThayDoi)] = cauDon;
                    }
                }
            }

            var soCauYeuCau = MaTran.Phans.Sum(c => c.SoCauPhan);
            var rangBuocSoLuongPhan = Math.Abs(CauHois.Count - soCauYeuCau);
            var rangBuocDoKho = Math.Abs(((decimal)CauHois.Sum(c => c.DoKho) / (decimal)CauHois.Count) - DoKhoYeuCau);
            decimal doThichNghiTam = rangBuocDoKho + rangBuocSoLuongPhan;


            if (doThichNghiTam < DoThichNghi)
            {
                this.CauHois = cauHoiMois;
                TinhDoThichNghi();
            }
            else
            {
            }
        }

        public void TienVeDich(Dictionary<long, Dictionary<long, CauHoi>> database)
        {
            var cacCauLay = this.CauHois.GroupBy(c => c.MaNhom != 0 ? c.MaNhom : c.MaCauHoi).OrderBy(c => Guid.NewGuid()).Take(CauHois.Count / 20 == 0 ? 1 : CauHois.Count / 20).ToList();
            var cauHoiMois = new List<CauHoi>(this.CauHois);
            foreach (var cau in cacCauLay)
            {
                var cauDistinct = cau.Distinct();
                if (cauDistinct.Count() > 1)//Group question
                {
                    int indexCau = cauHoiMois.FindIndex(c => c == cauDistinct.First());
                    int soCau = cauDistinct.Count();
                    var cauLay = database[cauHoiMois[indexCau].MaPhan]
                                .Values
                                .Where(c => c.MaNhom != 0)
                                .Except(cauHoiMois)
                                .GroupBy(c => c.MaNhom != 0 ? c.MaNhom : c.MaCauHoi)
                                .OrderBy(c => Guid.NewGuid())
                                .GetBySum(soCau);

                    if (cauLay.Count > 1)
                    {
                        for (int i = indexCau; i < indexCau + soCau; i++)
                        {
                            cauHoiMois[i] = cauLay[i - indexCau];
                        }
                    }
                }
                else
                {
                    int indexCau = cauHoiMois.FindIndex(c => c.MaCauHoi == cauDistinct.First().MaCauHoi);
                    if (indexCau == 0) { continue; }
                    var cauLay = database[cauDistinct.First().MaPhan].Values.Except(cauHoiMois).Where(c => c.MaNhom == 0);
                    if (cauLay.Count() > 0)
                    {
                        cauHoiMois[indexCau] = cauLay.OrderBy(c => Guid.NewGuid()).First();
                    }
                }
            }

            var soCauYeuCau = MaTran.Phans.Sum(c => c.SoCauPhan);
            var rangBuocSoLuongPhan = Math.Abs(CauHois.Count - soCauYeuCau);
            var rangBuocDoKho = Math.Abs(((decimal)CauHois.Sum(c => c.DoKho) / (decimal)CauHois.Count) - DoKhoYeuCau);
            decimal doThichNghiTam = rangBuocDoKho + rangBuocSoLuongPhan;

            if (doThichNghiTam < DoThichNghi)
            {
                this.CauHois = cauHoiMois;
                TinhDoThichNghi();
            }
            else
            {
            }
        }
    }

    public class Dan
    {
        public List<CaThe> CaThes { get; private set; }
        public int ViTriCaTheTotNhat { get; private set; }

        public int ViTriDan { get; private set; }
        public int SoLuongCaTheBanDau { get; private set; }
        public decimal DoThichNghiTotNhat { get; private set; }

        public bool IsDangTraoDoi { get; private set; }

        public int TheHe { get; private set; }
        public Dan(int viTri, IEnumerable<CaThe> caThes)
        {
            CaThes = new List<CaThe>(caThes);
            ViTriDan = viTri;
            SoLuongCaTheBanDau = CaThes.Count;
            IsDangTraoDoi = false;
            TheHe = 0;
            ChonCaTheTotNhat();
        }

        public Dan()
        {
            // TODO: Complete member initialization
        }

        public void TimKiem(ref List<Dan> dans, Dictionary<long, Dictionary<long, CauHoi>> database)
        {
            while (true)
            {
                if (CaThes[ViTriCaTheTotNhat].DoThichNghi < 0.001M || TheHe > 100)
                {
                    return;
                }
                TheHe++;

                decimal doThichNghiTruocDiChuyen = DoThichNghiTotNhat;

                lock (this)
                {
                    for (int viTri = 0; viTri < CaThes.Count; viTri++)
                    {
                        if (viTri == ViTriCaTheTotNhat)
                        {
                            CaThes[viTri].TienVeDich(database);
                        }
                        else
                        {
                            CaThes[viTri].NhanThongTin(CaThes[ViTriCaTheTotNhat]);
                        }
                    }
                }
                ChonCaTheTotNhat();

                if (doThichNghiTruocDiChuyen > DoThichNghiTotNhat && new Random().Next(0, 20) == 0)
                {
                    DiCu(dans);
                }
                ChonCaTheTotNhat();
            }
        }

        private void DiCu(List<Dan> dans)
        {
            lock (this)
            {
                var coTheDiCus = this.CaThes.Where((c, i) => i != ViTriCaTheTotNhat);
                var caTheManhs = coTheDiCus.OrderBy(c => c.DoThichNghi).Take(SoLuongCaTheBanDau / 10).ToList();
                if (caTheManhs.Count() > 0)
                {
                    Dan danYeuHon;
                    lock (dans)
                    {
                        danYeuHon = dans.OrderByDescending(c => c.DoThichNghiTotNhat).FirstOrDefault(c => c.IsDangTraoDoi == false && c.DoThichNghiTotNhat > caTheManhs[0].DoThichNghi);
                    }
                    if (danYeuHon != null)
                    {
                        lock (danYeuHon)
                        {
                            danYeuHon.ThayDoiTrangThai(danYeuHon.IsDangTraoDoi);

                            danYeuHon.NhapCu(caTheManhs);
                            this.CaThes.RemoveAll(c => caTheManhs.Contains(c));
                            var caTheYeus = danYeuHon.CaThes.OrderByDescending(c => c.DoThichNghi).Take(SoLuongCaTheBanDau / 10).ToList();
                            this.CaThes.AddRange(caTheYeus);
                            danYeuHon.XuatCanh(caTheYeus);

                            danYeuHon.ThayDoiTrangThai(danYeuHon.IsDangTraoDoi);
                        }
                    }
                }
            }

        }

        private void ThayDoiTrangThai(bool trangThai)
        {
            IsDangTraoDoi = !trangThai;
        }

        private void XuatCanh(List<CaThe> caTheXuatCanhs)
        {
            lock (this)
            {
                this.CaThes.RemoveAll(c => caTheXuatCanhs.Contains(c));
                this.ChonCaTheTotNhat();
            }
        }
        private void NhapCu(List<CaThe> caTheNhapCu)
        {
            lock (this)
            {
                this.CaThes.AddRange(caTheNhapCu);
                this.ChonCaTheTotNhat();
            }
        }

        private void ChonCaTheTotNhat()
        {
            lock (this)
            {
                ViTriCaTheTotNhat = this.CaThes.FindIndex(c => c.DoThichNghi == this.CaThes.Min(m => m.DoThichNghi));
                DoThichNghiTotNhat = CaThes[ViTriCaTheTotNhat].DoThichNghi;
            }
        }

        public CaThe GetCaTheTotNhat()
        {
            return CaThes[ViTriCaTheTotNhat];
        }
    }
}
