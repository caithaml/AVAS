namespace GUI_AVAS
{
    partial class AVAS_GUI
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(AVAS_GUI));
            this.btn_aktivuj = new System.Windows.Forms.Button();
            this.btn_archivuj = new System.Windows.Forms.Button();
            this.btn_ukazvstupniini = new System.Windows.Forms.Button();
            this.btn_neshodygp = new System.Windows.Forms.Button();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.txtbox_integritadatovehosouboru = new System.Windows.Forms.TextBox();
            this.txtbox_prostredi = new System.Windows.Forms.TextBox();
            this.txtbox_stavantiviru = new System.Windows.Forms.TextBox();
            this.txtbox_scripty = new System.Windows.Forms.TextBox();
            this.txtbox_ntsyslog = new System.Windows.Forms.TextBox();
            this.txtbox_operacnisystem = new System.Windows.Forms.TextBox();
            this.txtbox_protect = new System.Windows.Forms.TextBox();
            this.txtbox_logy = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.txtbox_zaplnenidisku = new System.Windows.Forms.TextBox();
            this.txtbox_aplikacegp = new System.Windows.Forms.TextBox();
            this.eventLog1 = new System.Diagnostics.EventLog();
            this.label11 = new System.Windows.Forms.Label();
            this.label12 = new System.Windows.Forms.Label();
            this.label13 = new System.Windows.Forms.Label();
            this.label14 = new System.Windows.Forms.Label();
            this.label15 = new System.Windows.Forms.Label();
            this.label16 = new System.Windows.Forms.Label();
            this.label17 = new System.Windows.Forms.Label();
            this.label18 = new System.Windows.Forms.Label();
            this.button5 = new System.Windows.Forms.Button();
            this.label19 = new System.Windows.Forms.Label();
            this.txtbox_jmenostanice = new System.Windows.Forms.TextBox();
            this.txtbox_akceprovedenadne = new System.Windows.Forms.TextBox();
            this.txtbox_tester = new System.Windows.Forms.TextBox();
            this.txtbox_jmenosite = new System.Windows.Forms.TextBox();
            this.txtbox_jmenouzivatele = new System.Windows.Forms.TextBox();
            this.txtbox_kancelar = new System.Windows.Forms.TextBox();
            this.txtbox_cislozasuvky = new System.Windows.Forms.TextBox();
            this.txtbox_seriovecislo = new System.Windows.Forms.TextBox();
            this.tableLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.eventLog1)).BeginInit();
            this.SuspendLayout();
            // 
            // btn_aktivuj
            // 
            resources.ApplyResources(this.btn_aktivuj, "btn_aktivuj");
            this.btn_aktivuj.Name = "btn_aktivuj";
            this.btn_aktivuj.UseVisualStyleBackColor = true;
            // 
            // btn_archivuj
            // 
            resources.ApplyResources(this.btn_archivuj, "btn_archivuj");
            this.btn_archivuj.Name = "btn_archivuj";
            this.btn_archivuj.UseVisualStyleBackColor = true;
            // 
            // btn_ukazvstupniini
            // 
            resources.ApplyResources(this.btn_ukazvstupniini, "btn_ukazvstupniini");
            this.btn_ukazvstupniini.Name = "btn_ukazvstupniini";
            this.btn_ukazvstupniini.UseVisualStyleBackColor = true;
            this.btn_ukazvstupniini.Click += new System.EventHandler(this.button3_Click);
            // 
            // btn_neshodygp
            // 
            resources.ApplyResources(this.btn_neshodygp, "btn_neshodygp");
            this.btn_neshodygp.Name = "btn_neshodygp";
            this.btn_neshodygp.UseVisualStyleBackColor = true;
            this.btn_neshodygp.Click += new System.EventHandler(this.button4_Click);
            // 
            // textBox1
            // 
            this.textBox1.BackColor = System.Drawing.SystemColors.ControlLightLight;
            resources.ApplyResources(this.textBox1, "textBox1");
            this.textBox1.Name = "textBox1";
            this.textBox1.ReadOnly = true;
            // 
            // tableLayoutPanel1
            // 
            resources.ApplyResources(this.tableLayoutPanel1, "tableLayoutPanel1");
            this.tableLayoutPanel1.Controls.Add(this.label1, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.label2, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.label3, 0, 2);
            this.tableLayoutPanel1.Controls.Add(this.label4, 0, 3);
            this.tableLayoutPanel1.Controls.Add(this.label5, 0, 4);
            this.tableLayoutPanel1.Controls.Add(this.label6, 0, 5);
            this.tableLayoutPanel1.Controls.Add(this.label7, 0, 6);
            this.tableLayoutPanel1.Controls.Add(this.label8, 0, 7);
            this.tableLayoutPanel1.Controls.Add(this.txtbox_integritadatovehosouboru, 1, 0);
            this.tableLayoutPanel1.Controls.Add(this.txtbox_prostredi, 1, 1);
            this.tableLayoutPanel1.Controls.Add(this.txtbox_stavantiviru, 1, 2);
            this.tableLayoutPanel1.Controls.Add(this.txtbox_scripty, 1, 3);
            this.tableLayoutPanel1.Controls.Add(this.txtbox_ntsyslog, 1, 4);
            this.tableLayoutPanel1.Controls.Add(this.txtbox_operacnisystem, 1, 5);
            this.tableLayoutPanel1.Controls.Add(this.txtbox_protect, 1, 6);
            this.tableLayoutPanel1.Controls.Add(this.txtbox_logy, 1, 7);
            this.tableLayoutPanel1.Controls.Add(this.label9, 0, 8);
            this.tableLayoutPanel1.Controls.Add(this.label10, 0, 9);
            this.tableLayoutPanel1.Controls.Add(this.txtbox_zaplnenidisku, 1, 8);
            this.tableLayoutPanel1.Controls.Add(this.txtbox_aplikacegp, 1, 9);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.Paint += new System.Windows.Forms.PaintEventHandler(this.tableLayoutPanel1_Paint);
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.Name = "label2";
            // 
            // label3
            // 
            resources.ApplyResources(this.label3, "label3");
            this.label3.Name = "label3";
            // 
            // label4
            // 
            resources.ApplyResources(this.label4, "label4");
            this.label4.Name = "label4";
            // 
            // label5
            // 
            resources.ApplyResources(this.label5, "label5");
            this.label5.Name = "label5";
            // 
            // label6
            // 
            resources.ApplyResources(this.label6, "label6");
            this.label6.Name = "label6";
            // 
            // label7
            // 
            resources.ApplyResources(this.label7, "label7");
            this.label7.Name = "label7";
            // 
            // label8
            // 
            resources.ApplyResources(this.label8, "label8");
            this.label8.Name = "label8";
            // 
            // txtbox_integritadatovehosouboru
            // 
            resources.ApplyResources(this.txtbox_integritadatovehosouboru, "txtbox_integritadatovehosouboru");
            this.txtbox_integritadatovehosouboru.Name = "txtbox_integritadatovehosouboru";
            this.txtbox_integritadatovehosouboru.ReadOnly = true;
            // 
            // txtbox_prostredi
            // 
            resources.ApplyResources(this.txtbox_prostredi, "txtbox_prostredi");
            this.txtbox_prostredi.Name = "txtbox_prostredi";
            this.txtbox_prostredi.ReadOnly = true;
            this.txtbox_prostredi.TabStop = false;
            // 
            // txtbox_stavantiviru
            // 
            resources.ApplyResources(this.txtbox_stavantiviru, "txtbox_stavantiviru");
            this.txtbox_stavantiviru.Name = "txtbox_stavantiviru";
            this.txtbox_stavantiviru.ReadOnly = true;
            // 
            // txtbox_scripty
            // 
            resources.ApplyResources(this.txtbox_scripty, "txtbox_scripty");
            this.txtbox_scripty.Name = "txtbox_scripty";
            this.txtbox_scripty.ReadOnly = true;
            // 
            // txtbox_ntsyslog
            // 
            resources.ApplyResources(this.txtbox_ntsyslog, "txtbox_ntsyslog");
            this.txtbox_ntsyslog.Name = "txtbox_ntsyslog";
            this.txtbox_ntsyslog.ReadOnly = true;
            // 
            // txtbox_operacnisystem
            // 
            resources.ApplyResources(this.txtbox_operacnisystem, "txtbox_operacnisystem");
            this.txtbox_operacnisystem.Name = "txtbox_operacnisystem";
            this.txtbox_operacnisystem.ReadOnly = true;
            // 
            // txtbox_protect
            // 
            resources.ApplyResources(this.txtbox_protect, "txtbox_protect");
            this.txtbox_protect.Name = "txtbox_protect";
            this.txtbox_protect.ReadOnly = true;
            // 
            // txtbox_logy
            // 
            resources.ApplyResources(this.txtbox_logy, "txtbox_logy");
            this.txtbox_logy.Name = "txtbox_logy";
            this.txtbox_logy.ReadOnly = true;
            // 
            // label9
            // 
            resources.ApplyResources(this.label9, "label9");
            this.label9.Name = "label9";
            // 
            // label10
            // 
            resources.ApplyResources(this.label10, "label10");
            this.label10.Name = "label10";
            // 
            // txtbox_zaplnenidisku
            // 
            resources.ApplyResources(this.txtbox_zaplnenidisku, "txtbox_zaplnenidisku");
            this.txtbox_zaplnenidisku.Name = "txtbox_zaplnenidisku";
            this.txtbox_zaplnenidisku.ReadOnly = true;
            // 
            // txtbox_aplikacegp
            // 
            resources.ApplyResources(this.txtbox_aplikacegp, "txtbox_aplikacegp");
            this.txtbox_aplikacegp.Name = "txtbox_aplikacegp";
            this.txtbox_aplikacegp.ReadOnly = true;
            // 
            // eventLog1
            // 
            this.eventLog1.SynchronizingObject = this;
            // 
            // label11
            // 
            resources.ApplyResources(this.label11, "label11");
            this.label11.Name = "label11";
            // 
            // label12
            // 
            resources.ApplyResources(this.label12, "label12");
            this.label12.Name = "label12";
            // 
            // label13
            // 
            resources.ApplyResources(this.label13, "label13");
            this.label13.Name = "label13";
            // 
            // label14
            // 
            resources.ApplyResources(this.label14, "label14");
            this.label14.Name = "label14";
            // 
            // label15
            // 
            resources.ApplyResources(this.label15, "label15");
            this.label15.Name = "label15";
            // 
            // label16
            // 
            resources.ApplyResources(this.label16, "label16");
            this.label16.Name = "label16";
            // 
            // label17
            // 
            resources.ApplyResources(this.label17, "label17");
            this.label17.Name = "label17";
            // 
            // label18
            // 
            resources.ApplyResources(this.label18, "label18");
            this.label18.Name = "label18";
            // 
            // button5
            // 
            resources.ApplyResources(this.button5, "button5");
            this.button5.Name = "button5";
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // label19
            // 
            this.label19.BackColor = System.Drawing.Color.Red;
            resources.ApplyResources(this.label19, "label19");
            this.label19.Name = "label19";
            // 
            // txtbox_jmenostanice
            // 
            resources.ApplyResources(this.txtbox_jmenostanice, "txtbox_jmenostanice");
            this.txtbox_jmenostanice.Name = "txtbox_jmenostanice";
            this.txtbox_jmenostanice.ReadOnly = true;
            // 
            // txtbox_akceprovedenadne
            // 
            resources.ApplyResources(this.txtbox_akceprovedenadne, "txtbox_akceprovedenadne");
            this.txtbox_akceprovedenadne.Name = "txtbox_akceprovedenadne";
            this.txtbox_akceprovedenadne.ReadOnly = true;
            // 
            // txtbox_tester
            // 
            resources.ApplyResources(this.txtbox_tester, "txtbox_tester");
            this.txtbox_tester.Name = "txtbox_tester";
            // 
            // txtbox_jmenosite
            // 
            resources.ApplyResources(this.txtbox_jmenosite, "txtbox_jmenosite");
            this.txtbox_jmenosite.Name = "txtbox_jmenosite";
            // 
            // txtbox_jmenouzivatele
            // 
            resources.ApplyResources(this.txtbox_jmenouzivatele, "txtbox_jmenouzivatele");
            this.txtbox_jmenouzivatele.Name = "txtbox_jmenouzivatele";
            // 
            // txtbox_kancelar
            // 
            resources.ApplyResources(this.txtbox_kancelar, "txtbox_kancelar");
            this.txtbox_kancelar.Name = "txtbox_kancelar";
            // 
            // txtbox_cislozasuvky
            // 
            resources.ApplyResources(this.txtbox_cislozasuvky, "txtbox_cislozasuvky");
            this.txtbox_cislozasuvky.Name = "txtbox_cislozasuvky";
            // 
            // txtbox_seriovecislo
            // 
            resources.ApplyResources(this.txtbox_seriovecislo, "txtbox_seriovecislo");
            this.txtbox_seriovecislo.Name = "txtbox_seriovecislo";
            // 
            // AVAS_GUI
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.txtbox_seriovecislo);
            this.Controls.Add(this.txtbox_cislozasuvky);
            this.Controls.Add(this.txtbox_kancelar);
            this.Controls.Add(this.txtbox_jmenouzivatele);
            this.Controls.Add(this.txtbox_jmenosite);
            this.Controls.Add(this.txtbox_tester);
            this.Controls.Add(this.txtbox_akceprovedenadne);
            this.Controls.Add(this.txtbox_jmenostanice);
            this.Controls.Add(this.label19);
            this.Controls.Add(this.button5);
            this.Controls.Add(this.label18);
            this.Controls.Add(this.label17);
            this.Controls.Add(this.label16);
            this.Controls.Add(this.label15);
            this.Controls.Add(this.label14);
            this.Controls.Add(this.label13);
            this.Controls.Add(this.label12);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.btn_neshodygp);
            this.Controls.Add(this.btn_ukazvstupniini);
            this.Controls.Add(this.btn_archivuj);
            this.Controls.Add(this.btn_aktivuj);
            this.Name = "AVAS_GUI";
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.eventLog1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btn_aktivuj;
        private System.Windows.Forms.Button btn_archivuj;
        private System.Windows.Forms.Button btn_ukazvstupniini;
        private System.Windows.Forms.Button btn_neshodygp;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Diagnostics.EventLog eventLog1;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox txtbox_integritadatovehosouboru;
        private System.Windows.Forms.TextBox txtbox_prostredi;
        private System.Windows.Forms.TextBox txtbox_stavantiviru;
        private System.Windows.Forms.TextBox txtbox_scripty;
        private System.Windows.Forms.TextBox txtbox_ntsyslog;
        private System.Windows.Forms.TextBox txtbox_operacnisystem;
        private System.Windows.Forms.TextBox txtbox_protect;
        private System.Windows.Forms.TextBox txtbox_logy;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox txtbox_zaplnenidisku;
        private System.Windows.Forms.TextBox txtbox_aplikacegp;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.Label label13;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.Label label15;
        private System.Windows.Forms.Label label16;
        private System.Windows.Forms.Label label17;
        private System.Windows.Forms.Label label18;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.Label label19;
        private System.Windows.Forms.TextBox txtbox_jmenostanice;
        private System.Windows.Forms.TextBox txtbox_akceprovedenadne;
        private System.Windows.Forms.TextBox txtbox_tester;
        private System.Windows.Forms.TextBox txtbox_jmenosite;
        private System.Windows.Forms.TextBox txtbox_seriovecislo;
        private System.Windows.Forms.TextBox txtbox_cislozasuvky;
        private System.Windows.Forms.TextBox txtbox_kancelar;
        private System.Windows.Forms.TextBox txtbox_jmenouzivatele;
    }
}