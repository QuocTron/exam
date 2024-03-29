﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Entities
{
    public class MarkRounding
    {
        public int Id { get; set; }
        [StringLength(50)]
        public string Code { get; set; }
        [StringLength(50)]
        public string Name { get; set; }
        [DefaultValue(false)]
        public bool Using { get; set; }
    }
}
