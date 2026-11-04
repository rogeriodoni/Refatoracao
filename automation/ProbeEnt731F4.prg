SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcOut, lcCr, loForm, loForm2, llOk, lcCur, lnDs
lcOut = "C:\4c\automation\probe_ent731_f4.txt"
lcCr  = CHR(13) + CHR(10)

STRTOFILE("CK01 inicio" + lcCr, lcOut)

CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE("CK02 config.prg ok" + lcCr, lcOut, 1)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
PUBLIC gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_ent731_dialogs.txt"
gb_4c_ValidandoUI      = .F.
gnConnHandle           = -1
gc_4c_UsuarioLogado    = "TESTE"

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpEntBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpEnt.prg") ADDITIVE
STRTOFILE("CK03 dependencias carregadas" + lcCr, lcOut, 1)

*-- Instancia com os 9 parametros, na ordem do Lparameters legado
loForm = CREATEOBJECT("FormSigOpEnt", "001", "MALOTE", 3, DATE(), .NULL., ;
                      5, DATE() - 10, .F., 30)
STRTOFILE("CK04 CREATEOBJECT VARTYPE=" + VARTYPE(loForm) + lcCr, lcOut, 1)

IF VARTYPE(loForm) <> "O"
    STRTOFILE("FALHA: form nao instanciou" + lcCr, lcOut, 1)
    QUIT
ENDIF

STRTOFILE("CK05 DataSessionId=" + TRANSFORM(loForm.DataSessionId) + lcCr, lcOut, 1)

*-- GRADE
STRTOFILE("GRADE existe=" + TRANSFORM(PEMSTATUS(loForm, "grd_4c_Dados", 5)) + lcCr, lcOut, 1)
WITH loForm.grd_4c_Dados
    STRTOFILE("GRADE Top=" + TRANSFORM(.Top) + " Left=" + TRANSFORM(.Left) + ;
        " Width=" + TRANSFORM(.Width) + " Height=" + TRANSFORM(.Height) + lcCr, lcOut, 1)
    STRTOFILE("GRADE ColumnCount=" + TRANSFORM(.ColumnCount) + ;
        " RecordSource=[" + .RecordSource + "]" + ;
        " ReadOnly=" + TRANSFORM(.ReadOnly) + ;
        " RecordMark=" + TRANSFORM(.RecordMark) + ;
        " DeleteMark=" + TRANSFORM(.DeleteMark) + ;
        " Visible=" + TRANSFORM(.Visible) + lcCr, lcOut, 1)
    STRTOFILE("COL1 CS=[" + .Column1.ControlSource + "] W=" + TRANSFORM(.Column1.Width) + ;
        " Cap=[" + .Column1.Header1.Caption + "]" + ;
        " Align=" + TRANSFORM(.Column1.Header1.Alignment) + ;
        " RO=" + TRANSFORM(.Column1.ReadOnly) + lcCr, lcOut, 1)
    STRTOFILE("COL2 CS=[" + .Column2.ControlSource + "] W=" + TRANSFORM(.Column2.Width) + ;
        " Cap=[" + .Column2.Header1.Caption + "]" + ;
        " Align=" + TRANSFORM(.Column2.Header1.Alignment) + ;
        " RO=" + TRANSFORM(.Column2.ReadOnly) + lcCr, lcOut, 1)
ENDWITH

*-- BOTOES
WITH loForm.cmd_4c_Confirmar
    STRTOFILE("CONFIRMAR Top=" + TRANSFORM(.Top) + " Left=" + TRANSFORM(.Left) + ;
        " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
        " Cap=[" + .Caption + "] Enabled=" + TRANSFORM(.Enabled) + ;
        " Themes=" + TRANSFORM(.Themes) + ;
        " PicOk=" + TRANSFORM(FILE(.Picture)) + lcCr, lcOut, 1)
ENDWITH
WITH loForm.cmd_4c_Cancelar
    STRTOFILE("CANCELAR  Top=" + TRANSFORM(.Top) + " Left=" + TRANSFORM(.Left) + ;
        " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
        " Cap=[" + .Caption + "] Cancel=" + TRANSFORM(.Cancel) + ;
        " PicOk=" + TRANSFORM(FILE(.Picture)) + lcCr, lcOut, 1)
    STRTOFILE("CANCELAR direita=" + TRANSFORM(.Left + .Width) + ;
        " / Form.Width=" + TRANSFORM(loForm.Width) + lcCr, lcOut, 1)
ENDWITH

*-- CARREGARLISTA (exercita o ZAP dentro da datasession privada)
STRTOFILE("CK06 antes de CarregarLista" + lcCr, lcOut, 1)
llOk = loForm.CarregarLista()
STRTOFILE("CK07 CarregarLista=" + TRANSFORM(llOk) + lcCr, lcOut, 1)

*-- Cursor tem de ser lido DENTRO da datasession do form
lcCur = loForm.this_oBusinessObject.this_cCursorHistorico
lnDs  = SET("DATASESSION")
SET DATASESSION TO loForm.DataSessionId
STRTOFILE("CURSOR [" + lcCur + "] USED=" + TRANSFORM(USED(lcCur)) + ;
    " RECCOUNT=" + TRANSFORM(IIF(USED(lcCur), RECCOUNT(lcCur), -1)) + ;
    " FCOUNT=" + TRANSFORM(IIF(USED(lcCur), FCOUNT(lcCur), -1)) + lcCr, lcOut, 1)
IF USED(lcCur)
    SELECT (lcCur)
    STRTOFILE("CURSOR campos=[" + ;
        FIELD(1) + "," + FIELD(2) + "," + FIELD(3) + "," + FIELD(4) + "," + ;
        FIELD(5) + "," + FIELD(6) + "," + FIELD(7) + "," + FIELD(8) + "]" + lcCr, lcOut, 1)
    STRTOFILE("CURSOR tipos=[" + TYPE(FIELD(6)) + TYPE(FIELD(7)) + "]" + ;
        " SAFETY=" + SET("SAFETY") + lcCr, lcOut, 1)
ENDIF
SET DATASESSION TO (lnDs)

*-- Segunda instancia com pBlqAlt = .T.: Confirmar tem de nascer desabilitado
loForm2 = CREATEOBJECT("FormSigOpEnt", "001", "MALOTE", 3, DATE(), .NULL., ;
                       5, DATE() - 10, .T., 30)
IF VARTYPE(loForm2) = "O"
    STRTOFILE("BLOQUEADO Confirmar.Enabled=" + ;
        TRANSFORM(loForm2.cmd_4c_Confirmar.Enabled) + lcCr, lcOut, 1)
    loForm2 = .NULL.
ELSE
    STRTOFILE("BLOQUEADO falhou ao instanciar" + lcCr, lcOut, 1)
ENDIF

loForm = .NULL.
STRTOFILE("CK99 FIM" + lcCr, lcOut, 1)
QUIT
