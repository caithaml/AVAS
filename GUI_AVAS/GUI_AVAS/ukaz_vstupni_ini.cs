using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GUI_AVAS
{
    public partial class ukaz_vstupni_ini : Form
    {
        public ukaz_vstupni_ini()
        {
            InitializeComponent();
        }

        private void ukaz_vstupni_ini_Load(object sender, EventArgs e)
        {
            
        }

        private void openFileDialog1_FileOk(object sender, CancelEventArgs e)
        {
            
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
           txtbox_ukazinisoubor.Text= File.ReadAllText(openFileDialog1.FileName);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Stream myStream = null;
            OpenFileDialog openFileDialog1 = new OpenFileDialog();
            openFileDialog1.InitialDirectory = "c:\\";
            openFileDialog1.Filter = "ini files (*.ini)|*.ini|All files (*.*)|*.*";
            openFileDialog1.FilterIndex = 2;
            openFileDialog1.RestoreDirectory = true;
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    if ((myStream = openFileDialog1.OpenFile()) != null)
                    {
                        using (myStream)
                        {
                            txtbox_ukazinisoubor.Text = File.ReadAllText(openFileDialog1.FileName);
                        }
                    }
                }
               catch (Exception ex)
                {
                  //prostor pro případné zobrazení chyby nebo hlášky o úspěšném načtení
                }
            }
        }
    }
}
