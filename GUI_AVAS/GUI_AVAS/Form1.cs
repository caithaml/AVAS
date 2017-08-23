using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GUI_AVAS
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            AVAS_GUI form = new AVAS_GUI();
            form.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            WS_cert_GUI form = new WS_cert_GUI();
            form.Show();
        }
    }
}
