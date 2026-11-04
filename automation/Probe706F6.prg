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
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_706_f6_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"

ERASE C:\4c\automation\probe_706_f6_dialogs.txt

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\SigOpCopBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\operacionais\FormSigOpCop.prg ADDITIVE

LOCAL lcOut, loF, loPai, loErr, lnI, lnJ
LOCAL ARRAY laEv[1,5]
lcOut = ""

*===========================================================================
* CENARIO A - tela aberta SEM chamador (origem digitavel)
*===========================================================================
lcOut = lcOut + "=== CENARIO A: sem chamador (origem digitavel) ===" + CHR(13) + CHR(10)
loF = .NULL.
TRY
    loF = CREATEOBJECT("FormSigOpCop")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

lcOut = lcOut + "VARTYPE(form) = " + VARTYPE(loF) + CHR(13) + CHR(10)

IF VARTYPE(loF) = "O"
    lcOut = lcOut + "--- lbl_4c_Label2 (esperado 169,136 109x15 FC 90,90,90) ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  existe   = " + IIF(PEMSTATUS(loF, "lbl_4c_Label2", 5), "SIM", "NAO") + CHR(13) + CHR(10)
    WITH loF.lbl_4c_Label2
        lcOut = lcOut + "  Left/Top = " + TRANSFORM(.Left) + "," + TRANSFORM(.Top) + CHR(13) + CHR(10)
        lcOut = lcOut + "  W x H    = " + TRANSFORM(.Width) + "x" + TRANSFORM(.Height) + CHR(13) + CHR(10)
        lcOut = lcOut + "  AutoSize = " + TRANSFORM(.AutoSize) + "  Alignment = " + TRANSFORM(.Alignment) + CHR(13) + CHR(10)
        lcOut = lcOut + "  ForeColor= " + TRANSFORM(.ForeColor) + " (RGB 90,90,90 = " + TRANSFORM(RGB(90,90,90)) + ")" + CHR(13) + CHR(10)
        lcOut = lcOut + "  BackStyle= " + TRANSFORM(.BackStyle) + "  TabIndex = " + TRANSFORM(.TabIndex) + CHR(13) + CHR(10)
        lcOut = lcOut + "  Caption  = [" + .Caption + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "  Visible  = " + TRANSFORM(.Visible) + CHR(13) + CHR(10)
    ENDWITH

    lcOut = lcOut + "--- txt_4c_Destino (esperado 280,134 150x23 Format ! MaxLength 20) ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  existe   = " + IIF(PEMSTATUS(loF, "txt_4c_Destino", 5), "SIM", "NAO") + CHR(13) + CHR(10)
    WITH loF.txt_4c_Destino
        lcOut = lcOut + "  Left/Top = " + TRANSFORM(.Left) + "," + TRANSFORM(.Top) + CHR(13) + CHR(10)
        lcOut = lcOut + "  W x H    = " + TRANSFORM(.Width) + "x" + TRANSFORM(.Height) + CHR(13) + CHR(10)
        lcOut = lcOut + "  Format   = [" + .Format + "]  MaxLength = " + TRANSFORM(.MaxLength) + CHR(13) + CHR(10)
        lcOut = lcOut + "  TabIndex = " + TRANSFORM(.TabIndex) + "  ReadOnly = " + TRANSFORM(.ReadOnly) + CHR(13) + CHR(10)
        lcOut = lcOut + "  Value    = [" + TRANSFORM(.Value) + "] tipo " + VARTYPE(.Value) + CHR(13) + CHR(10)
        lcOut = lcOut + "  Visible  = " + TRANSFORM(.Visible) + CHR(13) + CHR(10)
    ENDWITH

    lcOut = lcOut + "--- txt_4c_Origem (sem chamador: digitavel) ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  ReadOnly = " + TRANSFORM(loF.txt_4c_Origem.ReadOnly) + ;
            "  TabStop = " + TRANSFORM(loF.txt_4c_Origem.TabStop) + CHR(13) + CHR(10)

    lcOut = lcOut + "--- BINDEVENT via AEVENTS(a, objeto) ---" + CHR(13) + CHR(10)
    lnI = AEVENTS(laEv, loF.txt_4c_Origem)
    lcOut = lcOut + "  txt_4c_Origem  = " + TRANSFORM(lnI) + CHR(13) + CHR(10)
    IF lnI > 0
        FOR lnJ = 1 TO lnI
            lcOut = lcOut + "     [" + laEv[lnJ,3] + " -> " + laEv[lnJ,4] + "]" + CHR(13) + CHR(10)
        ENDFOR
    ENDIF
    lnI = AEVENTS(laEv, loF.txt_4c_Destino)
    lcOut = lcOut + "  txt_4c_Destino = " + TRANSFORM(lnI) + CHR(13) + CHR(10)
    IF lnI > 0
        FOR lnJ = 1 TO lnI
            lcOut = lcOut + "     [" + laEv[lnJ,3] + " -> " + laEv[lnJ,4] + "]" + CHR(13) + CHR(10)
        ENDFOR
    ENDIF

    lcOut = lcOut + "--- escopo dos handlers (PEMSTATUS ...,2 = Protected; .F. = PUBLIC) ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  ValidarOrigem     prot=" + TRANSFORM(PEMSTATUS(loF, "ValidarOrigem", 2)) + CHR(13) + CHR(10)
    lcOut = lcOut + "  ValidarDestino    prot=" + TRANSFORM(PEMSTATUS(loF, "ValidarDestino", 2)) + CHR(13) + CHR(10)
    lcOut = lcOut + "  AbrirBuscaOrigem  prot=" + TRANSFORM(PEMSTATUS(loF, "AbrirBuscaOrigem", 2)) + CHR(13) + CHR(10)
    lcOut = lcOut + "  TxtOrigemKeyPress prot=" + TRANSFORM(PEMSTATUS(loF, "TxtOrigemKeyPress", 2)) + CHR(13) + CHR(10)
    lcOut = lcOut + "  TxtOrigemDblClick prot=" + TRANSFORM(PEMSTATUS(loF, "TxtOrigemDblClick", 2)) + CHR(13) + CHR(10)
    lcOut = lcOut + "  OrigemWhen        prot=" + TRANSFORM(PEMSTATUS(loF, "OrigemWhen", 2)) + CHR(13) + CHR(10)

    lcOut = lcOut + "--- ValidarOrigem com campo VAZIO (deve avisar e nao travar a flag) ---" + CHR(13) + CHR(10)
    loF.txt_4c_Origem.Value = ""
    loF.ValidarOrigem()
    lcOut = lcOut + "  flag lookup apos = " + TRANSFORM(loF.this_lEmLookupOrigem) + " (esperado .F.)" + CHR(13) + CHR(10)

    lcOut = lcOut + "--- TxtOrigemKeyPress com tecla NAO-lookup (A=65): nao abre nada ---" + CHR(13) + CHR(10)
    loF.TxtOrigemKeyPress(65, 0)
    lcOut = lcOut + "  flag lookup apos = " + TRANSFORM(loF.this_lEmLookupOrigem) + " (esperado .F.)" + CHR(13) + CHR(10)

    lcOut = lcOut + "--- ValidarDestino sem conexao (gnConnHandle=-1): pula SQL, nao estoura ---" + CHR(13) + CHR(10)
    loF.txt_4c_Destino.Value = "TESTE DESTINO"
    loF.ValidarDestino()
    lcOut = lcOut + "  flag destino apos = " + TRANSFORM(loF.this_lEmValidaDestino) + " (esperado .F.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  Value preservado  = [" + loF.txt_4c_Destino.Value + "] (nunca apagado - regra 50)" + CHR(13) + CHR(10)

    lcOut = lcOut + "--- guarda de reentrancia: flag ligada faz o handler sair na hora ---" + CHR(13) + CHR(10)
    loF.this_lEmLookupOrigem = .T.
    loF.txt_4c_Origem.Value  = "QUALQUER"
    loF.ValidarOrigem()
    lcOut = lcOut + "  flag preservada   = " + TRANSFORM(loF.this_lEmLookupOrigem) + " (esperado .T.)" + CHR(13) + CHR(10)
    loF.this_lEmLookupOrigem = .F.

    lcOut = lcOut + "--- lookup com campo ReadOnly nao altera o valor ---" + CHR(13) + CHR(10)
    loF.txt_4c_Origem.ReadOnly = .T.
    loF.txt_4c_Origem.Value    = "NAO MEXER"
    loF.AbrirBuscaOrigem()
    lcOut = lcOut + "  Value   = [" + loF.txt_4c_Origem.Value + "] (esperado NAO MEXER)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  flag    = " + TRANSFORM(loF.this_lEmLookupOrigem) + " (esperado .F. - restaurada)" + CHR(13) + CHR(10)

    loF.Release()
    loF = .NULL.
ENDIF

*===========================================================================
* CENARIO B - tela aberta COM chamador (origem somente-exibicao)
*===========================================================================
lcOut = lcOut + CHR(13) + CHR(10) + "=== CENARIO B: com chamador (origem somente-exibicao) ===" + CHR(13) + CHR(10)
loPai = CREATEOBJECT("Form")
loF   = .NULL.
TRY
    loF = CREATEOBJECT("FormSigOpCop", loPai, "ENTRADA NF")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY
lcOut = lcOut + "VARTYPE(form) = " + VARTYPE(loF) + CHR(13) + CHR(10)
IF VARTYPE(loF) = "O"
    lcOut = lcOut + "  txt_4c_Origem.Value    = [" + loF.txt_4c_Origem.Value + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "  txt_4c_Origem.ReadOnly = " + TRANSFORM(loF.txt_4c_Origem.ReadOnly) + " (esperado .T.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  txt_4c_Destino.Value   = [" + loF.txt_4c_Destino.Value + "] (esperado vazio)" + CHR(13) + CHR(10)
    lnI = AEVENTS(laEv, loF.txt_4c_Origem)
    lcOut = lcOut + "  eventos na origem      = " + TRANSFORM(lnI) + CHR(13) + CHR(10)
    IF lnI > 0
        FOR lnJ = 1 TO lnI
            lcOut = lcOut + "     [" + laEv[lnJ,3] + " -> " + laEv[lnJ,4] + "]" + CHR(13) + CHR(10)
        ENDFOR
    ENDIF
    loF.Release()
    loF = .NULL.
ENDIF

lcOut = lcOut + CHR(13) + CHR(10) + "=== DIALOGOS CAPTURADOS ===" + CHR(13) + CHR(10)
IF FILE("C:\4c\automation\probe_706_f6_dialogs.txt")
    lcOut = lcOut + FILETOSTR("C:\4c\automation\probe_706_f6_dialogs.txt")
ELSE
    lcOut = lcOut + "(nenhum arquivo de dialogo)" + CHR(13) + CHR(10)
ENDIF

= STRTOFILE(lcOut, "C:\4c\automation\probe_706_f6.txt")
QUIT
