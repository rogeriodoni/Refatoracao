SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET ESCAPE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f7probe738_dialogs.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

LOCAL lcLog, loF, lnI
LOCAL ARRAY laEv[1,5]
lcLog = "C:\4c\automation\_f7probe738.txt"
STRTOFILE("CK00 inicio" + CHR(13)+CHR(10), lcLog)

CD "C:\4c\projeto\app\start"
DO config.prg
gnConnHandle = -1

SET PROCEDURE TO (gc_4c_CaminhoUtils + "functions.prg")  ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils + "messages.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils + "validators.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigopgarBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigopgar.prg") ADDITIVE

loF = CREATEOBJECT("Formsigopgar")
STRTOFILE("CK01 CREATEOBJECT VARTYPE=" + VARTYPE(loF) + CHR(13)+CHR(10), lcLog, 1)
IF VARTYPE(loF) != "O"
    STRTOFILE("FALHOU - form nao instanciou" + CHR(13)+CHR(10), lcLog, 1)
    QUIT
ENDIF

*-- (A) BINDEVENT realmente vinculou? Handler sem binding eh codigo morto.
STRTOFILE("== A) BINDEVENT vivo (AEVENTS) ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cmd_4c_Processa  Click -> " + TRANSFORM(AEVENTS(laEv, loF.cmd_4c_Processa)) + " binding(s)" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cmd_4c_Cancela   Click -> " + TRANSFORM(AEVENTS(laEv, loF.cmd_4c_Cancela)) + " binding(s)" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cmd_4c_BtnGetArqO      -> " + TRANSFORM(AEVENTS(laEv, loF.cnt_4c_TXT.cmd_4c_BtnGetArqO)) + " binding(s)" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cmd_4c_BtnDirs         -> " + TRANSFORM(AEVENTS(laEv, loF.cnt_4c_Xml.cmd_4c_BtnDirs)) + " binding(s)" + CHR(13)+CHR(10), lcLog, 1)
IF AEVENTS(laEv, loF.chk_4c_ChkXml) > 0
    STRTOFILE("chk_4c_ChkXml -> evento=[" + TRANSFORM(laEv[1,2]) + "] delegate=[" + TRANSFORM(laEv[1,4]) + "]" + CHR(13)+CHR(10), lcLog, 1)
ENDIF

*-- (B) ChkXmlClick: alterna painel e LIMPA os 3 campos (legado chkXml.Valid)
STRTOFILE("== B) ChkXmlClick ==" + CHR(13)+CHR(10), lcLog, 1)
loF.cnt_4c_TXT.txt_4c_ArqTXT.Value = "C:\lixo\x.txt"
loF.cnt_4c_Xml.txt_4c_Dirs.Value   = "C:\lixo\y.xml"
loF.chk_4c_ChkXml.Value = 1
loF.ChkXmlClick()
STRTOFILE("  Value=1 -> cntXml.Visible=" + TRANSFORM(loF.cnt_4c_Xml.Visible) + ;
    " cntTXT.Visible=" + TRANSFORM(loF.cnt_4c_TXT.Visible) + ;
    " ArqTXT=[" + ALLTRIM(loF.cnt_4c_TXT.txt_4c_ArqTXT.Value) + "]" + ;
    " Dirs=[" + ALLTRIM(loF.cnt_4c_Xml.txt_4c_Dirs.Value) + "]" + CHR(13)+CHR(10), lcLog, 1)
loF.chk_4c_ChkXml.Value = 0
loF.ChkXmlClick()
STRTOFILE("  Value=0 -> cntXml.Visible=" + TRANSFORM(loF.cnt_4c_Xml.Visible) + ;
    " cntTXT.Visible=" + TRANSFORM(loF.cnt_4c_TXT.Visible) + CHR(13)+CHR(10), lcLog, 1)

*-- (C) AtualizarProgresso (chamado pelo BO, de fora da classe)
STRTOFILE("== C) AtualizarProgresso ==" + CHR(13)+CHR(10), lcLog, 1)
loF.AtualizarProgresso("Processando 3 Grupos / Produtos Gerados : 7")
STRTOFILE("  lblResults.Caption=[" + ALLTRIM(loF.cnt_4c_TXT.lbl_4c_LblResults.Caption) + "]" + ;
    "  this_cUltimoProgresso=[" + ALLTRIM(loF.this_cUltimoProgresso) + "]" + CHR(13)+CHR(10), lcLog, 1)

*-- (D) BtnProcessarClick com MsgConfirma=.F. (ModoTeste): o legado faz
*--     "Return(.F.)" e NAO fecha. Prova tambem que a flag de reentrancia
*--     eh liberada apesar do RETURN antecipado (regra #47) - se travasse,
*--     a 2a chamada seria no-op para sempre.
STRTOFILE("== D) BtnProcessarClick (usuario DESISTE) ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  antes : this_lProcessando=" + TRANSFORM(loF.this_lProcessando) + CHR(13)+CHR(10), lcLog, 1)
loF.BtnProcessarClick()
STRTOFILE("  depois: this_lProcessando=" + TRANSFORM(loF.this_lProcessando) + ;
    "  form ainda vivo? " + VARTYPE(loF) + CHR(13)+CHR(10), lcLog, 1)
loF.BtnProcessarClick()
STRTOFILE("  2a chamada OK (flag nao travou), this_lProcessando=" + TRANSFORM(loF.this_lProcessando) + CHR(13)+CHR(10), lcLog, 1)

*-- (E) BtnEncerrarClick por ULTIMO (destroi o objeto)
STRTOFILE("== E) BtnEncerrarClick ==" + CHR(13)+CHR(10), lcLog, 1)
loF.BtnEncerrarClick()
STRTOFILE("  pos-Release VARTYPE(loF)=" + VARTYPE(loF) + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("CK99 FIM OK" + CHR(13)+CHR(10), lcLog, 1)
QUIT
