*==============================================================================
* ProbeCpr712F5.prg - Instancia o FormSigOpCpr (Fase 5, task712) e dumpa as
* propriedades REAIS do rotulo e do campo de ORIGEM nos tres caminhos de
* abertura. Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF
* obrigatorios (regra #6 - execucao unattended).
*==============================================================================
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
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_712_f5_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"

ERASE C:\4c\automation\probe_712_f5_dialogs.txt

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\SigOpCprBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\operacionais\FormSigOpCpr.prg ADDITIVE

LOCAL lcOut, loF, loPai, loErr, lnI, lnJ, lcNL
LOCAL ARRAY laEv[1,5]
lcNL  = CHR(13) + CHR(10)
lcOut = ""

*===========================================================================
* CENARIO A - aberta pelo MENU (sem chamador): origem em branco e digitavel
*===========================================================================
lcOut = lcOut + "=== CENARIO A: sem chamador (modo processo) ===" + lcNL
loF = .NULL.
TRY
    loF = CREATEOBJECT("FormSigOpCpr")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + lcNL
ENDTRY
lcOut = lcOut + "VARTYPE(form) = " + VARTYPE(loF) + lcNL

IF VARTYPE(loF) = "O"
    lcOut = lcOut + "--- cabecalho NAO duplicado ---" + lcNL
    lcOut = lcOut + "  cnt_4c_Sombra    existe = " + IIF(PEMSTATUS(loF, "cnt_4c_Sombra", 5), "SIM", "NAO") + lcNL
    lcOut = lcOut + "  cnt_4c_Cabecalho existe = " + IIF(PEMSTATUS(loF, "cnt_4c_Cabecalho", 5), "SIM (ERRO!)", "NAO (ok)") + lcNL
    lnI = 0
    FOR lnJ = 1 TO loF.ControlCount
        IF UPPER(loF.Controls(lnJ).BaseClass) = "CONTAINER"
            IF loF.Controls(lnJ).BackColor = RGB(100, 100, 100) AND loF.Controls(lnJ).Height >= 60
                lnI = lnI + 1
            ENDIF
        ENDIF
    ENDFOR
    lcOut = lcOut + "  faixas RGB(100,100,100) H>=60 = " + TRANSFORM(lnI) + " (esperado 1)" + lcNL

    lcOut = lcOut + "--- lbl_4c_Label1 (esperado 122,97 92x15 FC 90,90,90 bold TabIndex 1) ---" + lcNL
    lcOut = lcOut + "  existe   = " + IIF(PEMSTATUS(loF, "lbl_4c_Label1", 5), "SIM", "NAO") + lcNL
    WITH loF.lbl_4c_Label1
        lcOut = lcOut + "  Left/Top = " + TRANSFORM(.Left) + "," + TRANSFORM(.Top) + lcNL
        lcOut = lcOut + "  W x H    = " + TRANSFORM(.Width) + "x" + TRANSFORM(.Height) + lcNL
        lcOut = lcOut + "  AutoSize = " + TRANSFORM(.AutoSize) + "  Alignment = " + TRANSFORM(.Alignment) + lcNL
        lcOut = lcOut + "  ForeColor= " + TRANSFORM(.ForeColor) + " (RGB 90,90,90 = " + TRANSFORM(RGB(90, 90, 90)) + ")" + lcNL
        lcOut = lcOut + "  Font     = " + .FontName + " " + TRANSFORM(.FontSize) + " bold=" + TRANSFORM(.FontBold) + lcNL
        lcOut = lcOut + "  BackStyle= " + TRANSFORM(.BackStyle) + "  TabIndex = " + TRANSFORM(.TabIndex) + lcNL
        lcOut = lcOut + "  Caption  = [" + .Caption + "]" + lcNL
        lcOut = lcOut + "  Visible  = " + TRANSFORM(.Visible) + lcNL
        lcOut = lcOut + "  Left+W   = " + TRANSFORM(.Left + .Width) + " (campo comeca em 216)" + lcNL
    ENDWITH

    lcOut = lcOut + "--- txt_4c_Origem (esperado 216,94 150x23 Format ! MaxLength 20 TabIndex 3) ---" + lcNL
    lcOut = lcOut + "  existe   = " + IIF(PEMSTATUS(loF, "txt_4c_Origem", 5), "SIM", "NAO") + lcNL
    WITH loF.txt_4c_Origem
        lcOut = lcOut + "  Left/Top = " + TRANSFORM(.Left) + "," + TRANSFORM(.Top) + lcNL
        lcOut = lcOut + "  W x H    = " + TRANSFORM(.Width) + "x" + TRANSFORM(.Height) + lcNL
        lcOut = lcOut + "  Format   = [" + .Format + "]  InputMask = [" + .InputMask + "]" + lcNL
        lcOut = lcOut + "  MaxLength= " + TRANSFORM(.MaxLength) + "  TabIndex = " + TRANSFORM(.TabIndex) + lcNL
        lcOut = lcOut + "  Font     = " + .FontName + " " + TRANSFORM(.FontSize) + lcNL
        lcOut = lcOut + "  Alignment= " + TRANSFORM(.Alignment) + " (default de TextBox = 3)" + lcNL
        lcOut = lcOut + "  Value    = [" + TRANSFORM(.Value) + "] tipo " + VARTYPE(.Value) + lcNL
        lcOut = lcOut + "  ReadOnly = " + TRANSFORM(.ReadOnly) + "  TabStop = " + TRANSFORM(.TabStop) + " (esperado .F. / .T.)" + lcNL
        lcOut = lcOut + "  Visible  = " + TRANSFORM(.Visible) + lcNL
    ENDWITH

    lcOut = lcOut + "--- BINDEVENT na origem (sem chamador: NENHUM When) ---" + lcNL
    lnI = AEVENTS(laEv, loF.txt_4c_Origem)
    lcOut = lcOut + "  eventos = " + TRANSFORM(lnI) + " (esperado 0)" + lcNL
    FOR lnJ = 1 TO lnI
        lcOut = lcOut + "     [" + laEv[lnJ, 3] + " -> " + laEv[lnJ, 4] + "]" + lcNL
    ENDFOR

    lcOut = lcOut + "--- escopo dos handlers (PEMSTATUS ...,2 = Protected) ---" + lcNL
    lcOut = lcOut + "  OrigemWhen     prot=" + TRANSFORM(PEMSTATUS(loF, "OrigemWhen", 2)) + " (esperado .F.)" + lcNL
    lcOut = lcOut + "  OrigemParaTela prot=" + TRANSFORM(PEMSTATUS(loF, "OrigemParaTela", 2)) + " (esperado .F.)" + lcNL
    lcOut = lcOut + "  OrigemWhen()   retorna " + TRANSFORM(loF.OrigemWhen()) + " (esperado .F.)" + lcNL

    lcOut = lcOut + "--- OrigemParaTela le do BO (fonte unica) ---" + lcNL
    loF.this_oBusinessObject.this_cOrigem = "PROC-DO-BO"
    loF.OrigemParaTela()
    lcOut = lcOut + "  Value apos = [" + loF.txt_4c_Origem.Value + "] (esperado PROC-DO-BO)" + lcNL

    loF.Release()
    loF = .NULL.
ENDIF

*===========================================================================
* CENARIO B - COM chamador, modo PROCESSO: origem semeada, somente-exibicao
*===========================================================================
lcOut = lcOut + lcNL + "=== CENARIO B: com chamador, modo PROCESSO ===" + lcNL
loPai = CREATEOBJECT("Form")
loF   = .NULL.
TRY
    loF = CREATEOBJECT("FormSigOpCpr", loPai, "PROCESSO 001", .F.)
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + lcNL
ENDTRY
lcOut = lcOut + "VARTYPE(form) = " + VARTYPE(loF) + lcNL
IF VARTYPE(loF) = "O"
    lcOut = lcOut + "  Origem.Value    = [" + loF.txt_4c_Origem.Value + "] (esperado PROCESSO 001)" + lcNL
    lcOut = lcOut + "  Origem W/MaxLen = " + TRANSFORM(loF.txt_4c_Origem.Width) + " / " + ;
            TRANSFORM(loF.txt_4c_Origem.MaxLength) + " (esperado 150 / 20)" + lcNL
    lcOut = lcOut + "  Origem ReadOnly = " + TRANSFORM(loF.txt_4c_Origem.ReadOnly) + ;
            "  TabStop = " + TRANSFORM(loF.txt_4c_Origem.TabStop) + " (esperado .T. / .F.)" + lcNL
    lnI = AEVENTS(laEv, loF.txt_4c_Origem)
    lcOut = lcOut + "  eventos = " + TRANSFORM(lnI) + " (esperado 1 = When)" + lcNL
    FOR lnJ = 1 TO lnI
        lcOut = lcOut + "     [" + laEv[lnJ, 3] + " -> " + laEv[lnJ, 4] + "]" + lcNL
    ENDFOR
    lcOut = lcOut + "  BO tabela/campo = " + loF.this_oBusinessObject.this_cTabela + " / " + ;
            loF.this_oBusinessObject.ObterCampoChave() + lcNL
    loF.Release()
    loF = .NULL.
ENDIF

*===========================================================================
* CENARIO C - COM chamador, modo COMISSAO: Width 290 / MaxLength 40
*===========================================================================
lcOut = lcOut + lcNL + "=== CENARIO C: com chamador, modo COMISSAO ===" + lcNL
loF = .NULL.
TRY
    loF = CREATEOBJECT("FormSigOpCpr", loPai, "COMISSAO ABCDEFGHIJ", .T.)
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + lcNL
ENDTRY
lcOut = lcOut + "VARTYPE(form) = " + VARTYPE(loF) + lcNL
IF VARTYPE(loF) = "O"
    lcOut = lcOut + "  Caption         = [" + loF.Caption + "] (NAO muda com a modalidade)" + lcNL
    lcOut = lcOut + "  Origem.Value    = [" + loF.txt_4c_Origem.Value + "]" + lcNL
    lcOut = lcOut + "  Origem W/MaxLen = " + TRANSFORM(loF.txt_4c_Origem.Width) + " / " + ;
            TRANSFORM(loF.txt_4c_Origem.MaxLength) + " (esperado 290 / 40)" + lcNL
    lcOut = lcOut + "  Origem Left+W   = " + TRANSFORM(loF.txt_4c_Origem.Left + loF.txt_4c_Origem.Width) + ;
            " (form Width = " + TRANSFORM(loF.Width) + ")" + lcNL
    lcOut = lcOut + "  BO tabela/campo = " + loF.this_oBusinessObject.this_cTabela + " / " + ;
            loF.this_oBusinessObject.ObterCampoChave() + lcNL
    loF.Release()
    loF = .NULL.
ENDIF

lcOut = lcOut + lcNL + "=== DIALOGOS CAPTURADOS ===" + lcNL
IF FILE("C:\4c\automation\probe_712_f5_dialogs.txt")
    lcOut = lcOut + FILETOSTR("C:\4c\automation\probe_712_f5_dialogs.txt")
ELSE
    lcOut = lcOut + "(nenhum dialogo - ok)" + lcNL
ENDIF

= STRTOFILE(lcOut, "C:\4c\automation\probe_712_f5.txt")
QUIT
