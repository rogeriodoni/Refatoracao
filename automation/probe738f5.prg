SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET ESCAPE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe738f5_dialogs.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

LOCAL lcLog
lcLog = "C:\4c\automation\probe738f5.txt"
STRTOFILE("CK00 inicio" + CHR(13) + CHR(10), lcLog)

CD "C:\4c\projeto\app\start"
DO config.prg
STRTOFILE("CK01 config.prg OK (SEM ConfigurarAmbiente)" + CHR(13) + CHR(10), lcLog, 1)

gnConnHandle = -1

SET PROCEDURE TO (gc_4c_CaminhoUtils + "functions.prg")  ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils + "messages.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils + "validators.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigopgarBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigopgar.prg") ADDITIVE
STRTOFILE("CK02 SET PROCEDURE OK" + CHR(13) + CHR(10), lcLog, 1)

LOCAL loF
loF = CREATEOBJECT("Formsigopgar")
STRTOFILE("CK03 CREATEOBJECT VARTYPE=" + VARTYPE(loF) + CHR(13) + CHR(10), lcLog, 1)

IF VARTYPE(loF) != "O"
    STRTOFILE("FALHOU: CREATEOBJECT nao devolveu objeto" + CHR(13) + CHR(10), lcLog, 1)
    QUIT
ENDIF

STRTOFILE("Caption=[" + loF.Caption + "] W=" + TRANSFORM(loF.Width) + ;
          " H=" + TRANSFORM(loF.Height) + CHR(13) + CHR(10), lcLog, 1)

*-- TabIndex lido de VOLTA (atribuir e nao reler nao prova nada)
STRTOFILE("== FORM ==" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("cnt_4c_Sombra   = " + TRANSFORM(loF.cnt_4c_Sombra.TabIndex)   + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cnt_4c_TXT      = " + TRANSFORM(loF.cnt_4c_TXT.TabIndex)      + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cmd_4c_Cancela  = " + TRANSFORM(loF.cmd_4c_Cancela.TabIndex)  + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cmd_4c_Processa = " + TRANSFORM(loF.cmd_4c_Processa.TabIndex) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("chk_4c_ChkXml   = " + TRANSFORM(loF.chk_4c_ChkXml.TabIndex)   + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cnt_4c_Xml      = " + TRANSFORM(loF.cnt_4c_Xml.TabIndex)      + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== cnt_4c_TXT ==" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("lbl_4c_LblResults = " + TRANSFORM(loF.cnt_4c_TXT.lbl_4c_LblResults.TabIndex) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("lbl_4c_Label1     = " + TRANSFORM(loF.cnt_4c_TXT.lbl_4c_Label1.TabIndex)     + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("txt_4c_ArqTXT     = " + TRANSFORM(loF.cnt_4c_TXT.txt_4c_ArqTXT.TabIndex)     + ;
          "  TabStop=" + TRANSFORM(loF.cnt_4c_TXT.txt_4c_ArqTXT.TabStop) + ;
          "  ReadOnly=" + TRANSFORM(loF.cnt_4c_TXT.txt_4c_ArqTXT.ReadOnly) + ;
          "  Tip=[" + loF.cnt_4c_TXT.txt_4c_ArqTXT.ToolTipText + "]" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cmd_4c_BtnGetArqO = " + TRANSFORM(loF.cnt_4c_TXT.cmd_4c_BtnGetArqO.TabIndex) + ;
          "  Pic=[" + JUSTFNAME(loF.cnt_4c_TXT.cmd_4c_BtnGetArqO.Picture) + "]" + ;
          "  PicPos=" + TRANSFORM(loF.cnt_4c_TXT.cmd_4c_BtnGetArqO.PicturePosition) + ;
          "  Tip=[" + loF.cnt_4c_TXT.cmd_4c_BtnGetArqO.ToolTipText + "]" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("chk_4c_ChkImagens = " + TRANSFORM(loF.cnt_4c_TXT.chk_4c_ChkImagens.TabIndex) + ;
          "  W=" + TRANSFORM(loF.cnt_4c_TXT.chk_4c_ChkImagens.Width) + ;
          "  H=" + TRANSFORM(loF.cnt_4c_TXT.chk_4c_ChkImagens.Height) + ;
          "  Bold=" + TRANSFORM(loF.cnt_4c_TXT.chk_4c_ChkImagens.FontBold) + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== cnt_4c_Xml ==" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("txt_4c_Arquivo      = " + TRANSFORM(loF.cnt_4c_Xml.txt_4c_Arquivo.TabIndex) + ;
          "  H=" + TRANSFORM(loF.cnt_4c_Xml.txt_4c_Arquivo.Height) + ;
          "  Fmt=[" + loF.cnt_4c_Xml.txt_4c_Arquivo.Format + "]" + ;
          "  MaxLen=" + TRANSFORM(loF.cnt_4c_Xml.txt_4c_Arquivo.MaxLength) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cmd_4c_BtnDirs      = " + TRANSFORM(loF.cnt_4c_Xml.cmd_4c_BtnDirs.TabIndex) + ;
          "  Pic=[" + JUSTFNAME(loF.cnt_4c_Xml.cmd_4c_BtnDirs.Picture) + "]" + ;
          "  PicPos=" + TRANSFORM(loF.cnt_4c_Xml.cmd_4c_BtnDirs.PicturePosition) + ;
          "  Font=[" + loF.cnt_4c_Xml.cmd_4c_BtnDirs.FontName + "]" + ;
          "  FG=" + TRANSFORM(loF.cnt_4c_Xml.cmd_4c_BtnDirs.ForeColor) + ;
          "  Tip=[" + loF.cnt_4c_Xml.cmd_4c_BtnDirs.ToolTipText + "]" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("txt_4c_Dirs         = " + TRANSFORM(loF.cnt_4c_Xml.txt_4c_Dirs.TabIndex) + ;
          "  TabStop=" + TRANSFORM(loF.cnt_4c_Xml.txt_4c_Dirs.TabStop) + ;
          "  Tip=[" + loF.cnt_4c_Xml.txt_4c_Dirs.ToolTipText + "]" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("lbl_4c_LabelArquivo = " + TRANSFORM(loF.cnt_4c_Xml.lbl_4c_LabelArquivo.TabIndex) + ;
          "  Bold=" + TRANSFORM(loF.cnt_4c_Xml.lbl_4c_LabelArquivo.FontBold) + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== visibilidade dos paineis (TXT visivel, XML oculto) ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cnt_4c_TXT.Visible = " + TRANSFORM(loF.cnt_4c_TXT.Visible) + ;
          "   cnt_4c_Xml.Visible = " + TRANSFORM(loF.cnt_4c_Xml.Visible) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("filhos do XML visiveis? txt_4c_Arquivo=" + TRANSFORM(loF.cnt_4c_Xml.txt_4c_Arquivo.Visible) + ;
          " cmd_4c_BtnDirs=" + TRANSFORM(loF.cnt_4c_Xml.cmd_4c_BtnDirs.Visible) + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== metodo PUBLIC? (0=sim) ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("ConfigurarOrdemTabulacao protected = " + ;
          TRANSFORM(PEMSTATUS(loF, "ConfigurarOrdemTabulacao", 2)) + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("CK99 FIM OK" + CHR(13) + CHR(10), lcLog, 1)
loF.Release()
QUIT
