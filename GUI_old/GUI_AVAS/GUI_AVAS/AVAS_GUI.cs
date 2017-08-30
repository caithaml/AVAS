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
    public partial class AVAS_GUI : Form
    {
        public AVAS_GUI()
        {
            InitializeComponent();
        }

        private void tableLayoutPanel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {
            Napoveda form = new Napoveda();
            form.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            ukaz_vstupni_ini form = new ukaz_vstupni_ini();
            form.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Neshody_GP form = new Neshody_GP();
            form.Show();
        }
    }
}
