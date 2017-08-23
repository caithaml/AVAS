namespace GUI_AVAS
{
    partial class ukaz_vstupni_ini
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
            this.txtbox_ukazinisoubor = new System.Windows.Forms.TextBox();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // txtbox_ukazinisoubor
            // 
            this.txtbox_ukazinisoubor.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.txtbox_ukazinisoubor.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbox_ukazinisoubor.Location = new System.Drawing.Point(13, 65);
            this.txtbox_ukazinisoubor.Multiline = true;
            this.txtbox_ukazinisoubor.Name = "txtbox_ukazinisoubor";
            this.txtbox_ukazinisoubor.ReadOnly = true;
            this.txtbox_ukazinisoubor.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.txtbox_ukazinisoubor.Size = new System.Drawing.Size(921, 365);
            this.txtbox_ukazinisoubor.TabIndex = 0;
            this.txtbox_ukazinisoubor.TextChanged += new System.EventHandler(this.textBox1_TextChanged);
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "openFileDialog1";
            this.openFileDialog1.FileOk += new System.ComponentModel.CancelEventHandler(this.openFileDialog1_FileOk);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(13, 13);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(132, 46);
            this.button1.TabIndex = 1;
            this.button1.Text = "Načíst .ini soubor";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // ukaz_vstupni_ini
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(946, 442);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.txtbox_ukazinisoubor);
            this.Name = "ukaz_vstupni_ini";
            this.Text = "Ukaž vstupní .ini";
            this.Load += new System.EventHandler(this.ukaz_vstupni_ini_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtbox_ukazinisoubor;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.Button button1;
    }
}