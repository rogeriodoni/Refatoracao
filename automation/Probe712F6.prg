SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_UsuarioLogado

gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_712_f6_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"

ERASE C:\4c\automation\probe_712_f6_dialogs.txt

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\SigOpCprBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\operacionais\FormSigOpCpr.prg ADDITIVE

LOCAL lcOut, loF, loPai, loErr, lnI, lnN
LOCAL ARRAY laEv[1,5]
lcOut = ""

lcOut = lcOut + "=== CENARIO A: modo PROCESSO, com chamador ===" + CHR(13) + CHR(10)
loPai = CREATEOBJECT("Form")
loF   = .NULL.
TRY
    loF = CREATEOBJECT("FormSigOpCpr", loPai, "PROC ORIGEM 1", .F.)
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY
lcOut = lcOut + "VARTYPE(form) = " + VARTYPE(loF) + CHR(13) + CHR(10)

IF VARTYPE(loF) = "O"
    lcOut = lcOut + "--- lbl_4c_Label2 (dump: 124,123 90x15 FC 90,90,90 TabIndex 2) ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  existe    = " + IIF(PEMSTATUS(loF, "lbl_4c_Label2", 5), "SIM", "NAO") + CHR(13) + CHR(10)
    WITH loF.lbl_4c_Label2
        lcOut = lcOut + "  Left/Top  = " + TRANSFORM(.Left) + "," + TRANSFORM(.Top) + CHR(13) + CHR(10)
        lcOut = lcOut + "  W x H     = " + TRANSFORM(.Width) + "x" + TRANSFORM(.Height) + CHR(13) + CHR(10)
        lcOut = lcOut + "  AutoSize  = " + TRANSFORM(.AutoSize) + "  Alignment = " + TRANSFORM(.Alignment) + CHR(13) + CHR(10)
        lcOut = lcOut + "  ForeColor = " + TRANSFORM(.ForeColor) + " (90,90,90 = " + TRANSFORM(RGB(90,90,90)) + ")" + CHR(13) + CHR(10)
        lcOut = lcOut + "  BackStyle = " + TRANSFORM(.BackStyle) + "  TabIndex = " + TRANSFORM(.TabIndex) + CHR(13) + CHR(10)
        lcOut = lcOut + "  FontName  = [" + .FontName + "] " + TRANSFORM(.FontSize) + " bold=" + TRANSFORM(.FontBold) + CHR(13) + CHR(10)
        lcOut = lcOut + "  Caption   = [" + .Caption + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "  Visible   = " + TRANSFORM(.Visible) + CHR(13) + CHR(10)
    ENDWITH

    lcOut = lcOut + "--- txt_4c_Destino (Init legado: W 150 / MaxLength 20) ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  existe    = " + IIF(PEMSTATUS(loF, "txt_4c_Destino", 5), "SIM", "NAO") + CHR(13) + CHR(10)
    WITH loF.txt_4c_Destino
        lcOut = lcOut + "  Left/Top  = " + TRANSFORM(.Left) + "," + TRANSFORM(.Top) + CHR(13) + CHR(10)
        lcOut = lcOut + "  W x H     = " + TRANSFORM(.Width) + "x" + TRANSFORM(.Height) + CHR(13) + CHR(10)
        lcOut = lcOut + "  MaxLength = " + TRANSFORM(.MaxLength) + CHR(13) + CHR(10)
        lcOut = lcOut + "  Format    = [" + .Format + "]  InputMask = [" + .InputMask + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "  FontName  = [" + .FontName + "]  FontSize = " + TRANSFORM(.FontSize) + CHR(13) + CHR(10)
        lcOut = lcOut + "  TabIndex  = " + TRANSFORM(.TabIndex) + "  TabStop = " + TRANSFORM(.TabStop) + CHR(13) + CHR(10)
        lcOut = lcOut + "  ReadOnly  = " + TRANSFORM(.ReadOnly) + " (esperado .F. - digitavel)" + CHR(13) + CHR(10)
        lcOut = lcOut + "  VARTYPE(Value) = " + VARTYPE(.Value) + " (esperado C)" + CHR(13) + CHR(10)
        lcOut = lcOut + "  Value     = [" + .Value + "] (esperado vazio)" + CHR(13) + CHR(10)
        lcOut = lcOut + "  Visible   = " + TRANSFORM(.Visible) + CHR(13) + CHR(10)
    ENDWITH

    lcOut = lcOut + "--- regressao Fase 5 ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  Origem.Value    = [" + loF.txt_4c_Origem.Value + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "  Origem.ReadOnly = " + TRANSFORM(loF.txt_4c_Origem.ReadOnly) + " (esperado .T.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  Origem.W/MaxLen = " + TRANSFORM(loF.txt_4c_Origem.Width) + " / " + TRANSFORM(loF.txt_4c_Origem.MaxLength) + CHR(13) + CHR(10)
    lcOut = lcOut + "  Label1.Caption  = [" + loF.lbl_4c_Label1.Caption + "]" + CHR(13) + CHR(10)

    lcOut = lcOut + "--- BINDEVENT de txt_4c_Destino (AEVENTS 2 args, col3=evt col4=metodo) ---" + CHR(13) + CHR(10)
    lnN = AEVENTS(laEv, loF.txt_4c_Destino)
    lcOut = lcOut + "  binds = " + TRANSFORM(lnN) + CHR(13) + CHR(10)
    IF lnN > 0
        FOR lnI = 1 TO ALEN(laEv, 1)
            lcOut = lcOut + "   [" + TRANSFORM(laEv[lnI,3]) + " -> " + TRANSFORM(laEv[lnI,4]) + "]" + CHR(13) + CHR(10)
        ENDFOR
    ENDIF

    lcOut = lcOut + "--- escopo (PEMSTATUS attr 2 = PROTECTED) ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  ValidarDestino existe    = " + IIF(PEMSTATUS(loF, "ValidarDestino", 5), "SIM", "NAO") + CHR(13) + CHR(10)
    lcOut = lcOut + "  ValidarDestino PROTECTED = " + TRANSFORM(PEMSTATUS(loF, "ValidarDestino", 2)) + " (esperado .F.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  guarda inicial           = " + TRANSFORM(loF.this_lEmValidaDestino) + " (esperado .F.)" + CHR(13) + CHR(10)

    lcOut = lcOut + "--- ValidarDestino sem conexao viva (gnConnHandle = -1) ---" + CHR(13) + CHR(10)
    loF.txt_4c_Destino.Value = "PROC NOVO 9"
    TRY
        loF.ValidarDestino()
        lcOut = lcOut + "  rodou SEM excecao (conferencia pulada - nota 31)" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "  EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY
    lcOut = lcOut + "  Value preservado = [" + loF.txt_4c_Destino.Value + "] (regra #50)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  guarda liberada  = " + TRANSFORM(loF.this_lEmValidaDestino) + " (esperado .F.)" + CHR(13) + CHR(10)

    lcOut = lcOut + "--- evento NATIVO LostFocus ---" + CHR(13) + CHR(10)
    TRY
        loF.txt_4c_Destino.LostFocus()
        lcOut = lcOut + "  LostFocus nativo rodou SEM excecao" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "  EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY
    lcOut = lcOut + "  guarda apos LostFocus = " + TRANSFORM(loF.this_lEmValidaDestino) + CHR(13) + CHR(10)

    loF.Release()
ENDIF
loF   = .NULL.
loPai = .NULL.

lcOut = lcOut + CHR(13) + CHR(10) + "=== CENARIO B: modo COMISSAO ===" + CHR(13) + CHR(10)
loPai = CREATEOBJECT("Form")
loF   = .NULL.
TRY
    loF = CREATEOBJECT("FormSigOpCpr", loPai, "COMISSAO ORIGEM", .T.)
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY
lcOut = lcOut + "VARTYPE(form) = " + VARTYPE(loF) + CHR(13) + CHR(10)
IF VARTYPE(loF) = "O"
    lcOut = lcOut + "  Destino W/MaxLen = " + TRANSFORM(loF.txt_4c_Destino.Width) + " / " + ;
            TRANSFORM(loF.txt_4c_Destino.MaxLength) + " (esperado 290 / 40)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  Origem  W/MaxLen = " + TRANSFORM(loF.txt_4c_Origem.Width) + " / " + ;
            TRANSFORM(loF.txt_4c_Origem.MaxLength) + " (esperado 290 / 40)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  BO.this_lComissao = " + TRANSFORM(loF.this_oBusinessObject.this_lComissao) + CHR(13) + CHR(10)
    loF.Release()
ENDIF
loF   = .NULL.
loPai = .NULL.

lcOut = lcOut + CHR(13) + CHR(10) + "=== CENARIO C: sem chamador (menu) ===" + CHR(13) + CHR(10)
loF = .NULL.
TRY
    loF = CREATEOBJECT("FormSigOpCpr")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY
lcOut = lcOut + "VARTYPE(form) = " + VARTYPE(loF) + CHR(13) + CHR(10)
IF VARTYPE(loF) = "O"
    lcOut = lcOut + "  Origem.ReadOnly  = " + TRANSFORM(loF.txt_4c_Origem.ReadOnly) + " (esperado .F.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  Destino.ReadOnly = " + TRANSFORM(loF.txt_4c_Destino.ReadOnly) + " (esperado .F.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  Caption = [" + loF.Caption + "]" + CHR(13) + CHR(10)
    loF.Release()
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\probe_712_f6_out.txt")
QUIT
