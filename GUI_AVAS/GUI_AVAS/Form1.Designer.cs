namespace GUI_AVAS
{
    partial class Form1
    {
        /// <summary>
        /// Vyžaduje se proměnná návrháře.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Uvolněte všechny používané prostředky.
        /// </summary>
        /// <param name="disposing">hodnota true, když by se měl spravovaný prostředek odstranit; jinak false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Kód generovaný Návrhářem Windows Form

        /// <summary>
        /// Metoda vyžadovaná pro podporu Návrháře - neupravovat
        /// obsah této metody v editoru kódu.
        /// </summary>
        private void InitializeComponent()
        {
            this.btn_avas_gui = new System.Windows.Forms.Button();
            this.btn_ws_cert = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btn_avas_gui
            // 
            this.btn_avas_gui.Location = new System.Drawing.Point(13, 88);
            this.btn_avas_gui.Name = "btn_avas_gui";
            this.btn_avas_gui.Size = new System.Drawing.Size(75, 23);
            this.btn_avas_gui.TabIndex = 0;
            this.btn_avas_gui.Text = "AVAS_GUI";
            this.btn_avas_gui.UseVisualStyleBackColor = true;
            this.btn_avas_gui.Click += new System.EventHandler(this.button1_Click);
            // 
            // btn_ws_cert
            // 
            this.btn_ws_cert.Location = new System.Drawing.Point(141, 88);
            this.btn_ws_cert.Name = "btn_ws_cert";
            this.btn_ws_cert.Size = new System.Drawing.Size(111, 23);
            this.btn_ws_cert.TabIndex = 1;
            this.btn_ws_cert.Text = "WS_CERT_GUI";
            this.btn_ws_cert.UseVisualStyleBackColor = true;
            this.btn_ws_cert.Click += new System.EventHandler(this.button2_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(12, 195);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(128, 34);
            this.button1.TabIndex = 2;
            this.button1.Text = "Test powershell skript";
            this.button1.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(284, 261);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.btn_ws_cert);
            this.Controls.Add(this.btn_avas_gui);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Test_Gui_START";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btn_avas_gui;
        private System.Windows.Forms.Button btn_ws_cert;
        private System.Windows.Forms.Button button1;
    }
}

