*-- probe739f4.prg - Fase 4/8 da task739 (SIGOPGCO -> FormSigOpGco)
*-- Prova em RUNTIME: (a) o form instancia; (b) os DOIS CommandButton do SCX
*-- existem com geometria/caption/Picture do legado; (c) os handlers de Click
*-- existem e sao PUBLIC (BINDEVENT falha em silencio com PROTECTED - #3);
*-- (d) clicar Imprimir sem grafico gerado avisa e NAO imprime, sem excecao.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET ESCAPE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe739f4_dialogs.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

LOCAL lcLog, loF
lcLog = "C:\4c\automation\probe739f4.txt"
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
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpGcoBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpGco.prg") ADDITIVE
STRTOFILE("CK01 SET PROCEDURE OK" + CHR(13)+CHR(10), lcLog, 1)

loF = CREATEOBJECT("FormSigOpGco")
STRTOFILE("CK02 CREATEOBJECT VARTYPE=" + VARTYPE(loF) + CHR(13)+CHR(10), lcLog, 1)
IF VARTYPE(loF) != "O"
    STRTOFILE("FALHOU - form nao instanciou" + CHR(13)+CHR(10), lcLog, 1)
    QUIT
ENDIF

STRTOFILE("== 1) form ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  BaseClass=[" + loF.BaseClass + "] Caption=[" + loF.Caption + "]" + ;
    " W=" + TRANSFORM(loF.Width) + " H=" + TRANSFORM(loF.Height) + ;
    " ControlCount=" + TRANSFORM(loF.ControlCount) + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== 2) os DOIS botoes do SCX ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  cmd_4c_Imprimir existe=" + TRANSFORM(PEMSTATUS(loF,"cmd_4c_Imprimir",5)) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  cmd_4c_Sair     existe=" + TRANSFORM(PEMSTATUS(loF,"cmd_4c_Sair",5)) + CHR(13)+CHR(10), lcLog, 1)
WITH loF.cmd_4c_Imprimir
    STRTOFILE("  Imprimir Top=" + TRANSFORM(.Top) + " Left=" + TRANSFORM(.Left) + ;
        " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
        " Cap=[" + .Caption + "] Vis=" + TRANSFORM(.Visible) + ;
        " PicOK=" + IIF(FILE(.Picture),"SIM","NAO") + CHR(13)+CHR(10), lcLog, 1)
ENDWITH
WITH loF.cmd_4c_Sair
    STRTOFILE("  Sair     Top=" + TRANSFORM(.Top) + " Left=" + TRANSFORM(.Left) + ;
        " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
        " Cap=[" + .Caption + "] Vis=" + TRANSFORM(.Visible) + ;
        " PicOK=" + IIF(FILE(.Picture),"SIM","NAO") + CHR(13)+CHR(10), lcLog, 1)
ENDWITH
STRTOFILE("  dentro do form? Imprimir dir=" + TRANSFORM(loF.cmd_4c_Imprimir.Left + loF.cmd_4c_Imprimir.Width) + ;
    "  Sair dir=" + TRANSFORM(loF.cmd_4c_Sair.Left + loF.cmd_4c_Sair.Width) + ;
    "  Form.Width=" + TRANSFORM(loF.Width) + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== 3) cabecalho (faixa) ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  cnt_4c_Sombra existe=" + TRANSFORM(PEMSTATUS(loF,"cnt_4c_Sombra",5)) + CHR(13)+CHR(10), lcLog, 1)
IF PEMSTATUS(loF,"cnt_4c_Sombra",5)
    STRTOFILE("  faixa Top=" + TRANSFORM(loF.cnt_4c_Sombra.Top) + " H=" + TRANSFORM(loF.cnt_4c_Sombra.Height) + ;
        " BackColor=" + TRANSFORM(loF.cnt_4c_Sombra.BackColor) + ;
        " TituloCap=[" + loF.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]" + ;
        " TituloFore=" + TRANSFORM(loF.cnt_4c_Sombra.lbl_4c_LblTitulo.ForeColor) + CHR(13)+CHR(10), lcLog, 1)
ENDIF

STRTOFILE("== 4) handlers: existem E sao PUBLIC (atributo 2 = Protected) ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  CmdImprimirClick    existe=" + TRANSFORM(PEMSTATUS(loF,"CmdImprimirClick",5)) + ;
    " prot=" + TRANSFORM(PEMSTATUS(loF,"CmdImprimirClick",2)) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  CmdSairClick        existe=" + TRANSFORM(PEMSTATUS(loF,"CmdSairClick",5)) + ;
    " prot=" + TRANSFORM(PEMSTATUS(loF,"CmdSairClick",2)) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  ExecutarReportForm  existe=" + TRANSFORM(PEMSTATUS(loF,"ExecutarReportForm",5)) + ;
    " prot=" + TRANSFORM(PEMSTATUS(loF,"ExecutarReportForm",2)) + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== 5) CmdImprimirClick sem grafico gerado (nao deve imprimir nem estourar) ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  cursor grafico existe antes? " + TRANSFORM(USED("cursor_4c_Grafico")) + CHR(13)+CHR(10), lcLog, 1)
loF.CmdImprimirClick()
STRTOFILE("  CmdImprimirClick RETORNOU sem excecao" + CHR(13)+CHR(10), lcLog, 1)

loF.Release()
loF = .NULL.
STRTOFILE("CK99 FIM OK" + CHR(13)+CHR(10), lcLog, 1)
QUIT
