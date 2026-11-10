*==============================================================================
* probar_form_fase5.prg - Fase 5: prova que FormSIGOPNOP INSTANCIA e que a
* auditoria propriedade-a-propriedade contra o dump ficou de fato aplicada
* (Width/Height dos labels, fonte/cor dos fwbtng e ordem de tabulacao).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, loForm, loErro, lcArqSaida, loCnt
lcArqSaida = "C:\4c\tasks\task772\probar_form_fase5_resultado.txt"
lcSaida    = "M1 inicio" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task772\probar_form_fase5_erros.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
GarantirClasse("FormSIGOPNOP")

lcSaida = lcSaida + "M2 ambiente ok" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGOPNOP")
    lcSaida = lcSaida + "CREATEOBJECT VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
CATCH TO loErro
    lcSaida = lcSaida + "EXCECAO: " + loErro.Message + ;
              " | Linha: " + TRANSFORM(loErro.LineNo) + ;
              " | Procedure: " + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(lcSaida, lcArqSaida)

IF VARTYPE(loForm) = "O"
    lcSaida = lcSaida + "--- FORM ---" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "Closable=" + TRANSFORM(loForm.Closable) + " (esperado .T. - nao declarado no dump)" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "ControlBox=" + TRANSFORM(loForm.ControlBox) + " MaxButton=" + TRANSFORM(loForm.MaxButton) + ;
              " MinButton=" + TRANSFORM(loForm.MinButton) + CHR(13) + CHR(10)

    lcSaida = lcSaida + "--- LABELS (AutoSize/Width/Height) ---" + CHR(13) + CHR(10)
    loCnt = loForm.cnt_4c_Container1
    lcSaida = lcSaida + "C1.lbl_4c_Label3 AutoSize=" + TRANSFORM(loCnt.lbl_4c_Label3.AutoSize) + ;
              " W=" + TRANSFORM(loCnt.lbl_4c_Label3.Width) + " H=" + TRANSFORM(loCnt.lbl_4c_Label3.Height) + ;
              " (dump 35x15)" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "C1.lbl_4c_Label1 AutoSize=" + TRANSFORM(loCnt.lbl_4c_Label1.AutoSize) + ;
              " W=" + TRANSFORM(loCnt.lbl_4c_Label1.Width) + " H=" + TRANSFORM(loCnt.lbl_4c_Label1.Height) + ;
              " (dump 63x15)" + CHR(13) + CHR(10)
    loCnt = loForm.cnt_4c_Container2
    lcSaida = lcSaida + "C2.lbl_4c_Label1 AutoSize=" + TRANSFORM(loCnt.lbl_4c_Label1.AutoSize) + ;
              " W=" + TRANSFORM(loCnt.lbl_4c_Label1.Width) + " H=" + TRANSFORM(loCnt.lbl_4c_Label1.Height) + ;
              " (dump 114x25)" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "C2.lbl_4c_Label2 AutoSize=" + TRANSFORM(loCnt.lbl_4c_Label2.AutoSize) + ;
              " W=" + TRANSFORM(loCnt.lbl_4c_Label2.Width) + " H=" + TRANSFORM(loCnt.lbl_4c_Label2.Height) + ;
              " (dump 279x20)" + CHR(13) + CHR(10)

    lcSaida = lcSaida + "--- SOBREPOSICAO label x campo (mesmo pai) ---" + CHR(13) + CHR(10)
    loCnt = loForm.cnt_4c_Container1
    lcSaida = lcSaida + "Label3 fim=" + TRANSFORM(loCnt.lbl_4c_Label3.Left + loCnt.lbl_4c_Label3.Width) + ;
              " txt_4c_OP ini=" + TRANSFORM(loCnt.txt_4c_OP.Left) + CHR(13) + CHR(10)
    lcSaida = lcSaida + "Label1 fim=" + TRANSFORM(loCnt.lbl_4c_Label1.Left + loCnt.lbl_4c_Label1.Width) + ;
              " txt_4c_Envelope ini=" + TRANSFORM(loCnt.txt_4c_Envelope.Left) + CHR(13) + CHR(10)

    lcSaida = lcSaida + "--- FWBTNG (heranca da classe fwbtng) ---" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "Fwbtng1 Font=[" + loForm.cmd_4c_Fwbtng1.FontName + "] Bold=" + TRANSFORM(loForm.cmd_4c_Fwbtng1.FontBold) + ;
              " Italic=" + TRANSFORM(loForm.cmd_4c_Fwbtng1.FontItalic) + " WordWrap=" + TRANSFORM(loForm.cmd_4c_Fwbtng1.WordWrap) + ;
              " MousePointer=" + TRANSFORM(loForm.cmd_4c_Fwbtng1.MousePointer) + ;
              " ForeColor=" + TRANSFORM(loForm.cmd_4c_Fwbtng1.ForeColor) + ;
              " WxH=" + TRANSFORM(loForm.cmd_4c_Fwbtng1.Width) + "x" + TRANSFORM(loForm.cmd_4c_Fwbtng1.Height) + CHR(13) + CHR(10)
    lcSaida = lcSaida + "Fwbtng2 Font=[" + loForm.cmd_4c_Fwbtng2.FontName + "] ForeColor=" + TRANSFORM(loForm.cmd_4c_Fwbtng2.ForeColor) + CHR(13) + CHR(10)
    lcSaida = lcSaida + "RGB(90,90,90)=" + TRANSFORM(RGB(90,90,90)) + CHR(13) + CHR(10)
    lcSaida = lcSaida + "Picture Fwbtng1 existe=" + IIF(FILE(loForm.cmd_4c_Fwbtng1.Picture), "SIM", "NAO") + ;
              " Fwbtng2 existe=" + IIF(FILE(loForm.cmd_4c_Fwbtng2.Picture), "SIM", "NAO") + ;
              " Encerrar existe=" + IIF(FILE(loForm.cmg_4c_Commandgroup1.Buttons(1).Picture), "SIM", "NAO") + CHR(13) + CHR(10)

    lcSaida = lcSaida + "--- TABINDEX (nivel Form) ---" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "cnt_4c_Container1=" + TRANSFORM(loForm.cnt_4c_Container1.TabIndex) + ;
              " cmg_4c_Commandgroup1=" + TRANSFORM(loForm.cmg_4c_Commandgroup1.TabIndex) + ;
              " cnt_4c_Container2=" + TRANSFORM(loForm.cnt_4c_Container2.TabIndex) + ;
              " Fwbtng1=" + TRANSFORM(loForm.cmd_4c_Fwbtng1.TabIndex) + ;
              " Fwbtng2=" + TRANSFORM(loForm.cmd_4c_Fwbtng2.TabIndex) + CHR(13) + CHR(10)
    lcSaida = lcSaida + "--- TABINDEX (dentro de Container1) ---" + CHR(13) + CHR(10)
    loCnt = loForm.cnt_4c_Container1
    lcSaida = lcSaida + "txt_4c_OP=" + TRANSFORM(loCnt.txt_4c_OP.TabIndex) + ;
              " txt_4c_Envelope=" + TRANSFORM(loCnt.txt_4c_Envelope.TabIndex) + ;
              " TreeView presente=" + TRANSFORM(PEMSTATUS(loCnt, "obj_4c_TreeView", 5)) + CHR(13) + CHR(10)

    lcSaida = lcSaida + "--- CAMPOS (Format/InputMask/MaxLength) ---" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "txt_4c_OP Format=[" + loCnt.txt_4c_OP.Format + "] InputMask=[" + loCnt.txt_4c_OP.InputMask + ;
              "] MaxLength=" + TRANSFORM(loCnt.txt_4c_OP.MaxLength) + " VARTYPE(Value)=" + VARTYPE(loCnt.txt_4c_OP.Value) + CHR(13) + CHR(10)
    lcSaida = lcSaida + "txt_4c_Envelope Format=[" + loCnt.txt_4c_Envelope.Format + "] InputMask=[" + loCnt.txt_4c_Envelope.InputMask + ;
              "] MaxLength=" + TRANSFORM(loCnt.txt_4c_Envelope.MaxLength) + " VARTYPE(Value)=" + VARTYPE(loCnt.txt_4c_Envelope.Value) + CHR(13) + CHR(10)

    lcSaida = lcSaida + "Container2.Visible=" + TRANSFORM(loForm.cnt_4c_Container2.Visible) + " (esperado .F.)" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "img_4c_Imagem.Visible=" + TRANSFORM(loForm.img_4c_Imagem.Visible) + " (esperado .F.)" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "RESULTADO=INSTANCIOU" + CHR(13) + CHR(10)
    loForm.Release()
ELSE
    lcSaida = lcSaida + "RESULTADO=NAO INSTANCIOU" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcSaida, lcArqSaida)
QUIT
