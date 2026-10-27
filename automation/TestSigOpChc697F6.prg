*==============================================================================
* TestSigOpChc697F6.prg - Probe da Fase 6 do FormSigOpChc (task697).
* Prova o que o gate NAO prova:
*   1. o form INSTANCIA (o Init nao estoura em cadeia)
*   2. txt_4c_Taxa nasceu com Format/InputMask do dump e Value NUMERICO
*   3. o BINDEVENT de LostFocus ficou LIGADO (AEVENTS no objeto de ORIGEM)
*   4. ValidarTaxa() espelha tela -> this_nTaxa -> BO (inclusive Value char)
*   5. a grade esta vinculada com as 7 colunas/captions do Init legado
*   6. BO.CarregarDoCursor() NAO estoura sobre o cursor REAL da grade
* Script auxiliar: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_UsuarioLogado, gc_4c_CaminhoReports, go_4c_Sistema

gb_4c_ModoTeste         = .T.
gb_4c_ValidandoUI       = .F.
gnConnHandle            = -1
gc_4c_CaminhoIcones     = "C:\4c\vbmp\"
gc_4c_CaminhoFramework  = "C:\4c\Framework\"
gc_4c_CaminhoReports    = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado     = "TESTE"
gc_4c_ArquivoErroTeste  = "C:\4c\automation\teste_sigopchc_dialogs.txt"

STRTOFILE("", gc_4c_ArquivoErroTeste)

SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg"    ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\validators.prg"  ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg"     ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\gridbase.prg"     ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpChcBO.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigOpChc.prg" ADDITIVE

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_nI, loc_nQtd, loc_lOK
loc_cOut = "=== PROBE Fase 6 - FormSigOpChc (task697) ===" + CHR(13) + CHR(10)

*-- 1) INSTANCIAR -----------------------------------------------------------
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSigOpChc", .NULL., "00001234")
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[X] CREATEOBJECT estourou: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + ;
        CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loc_oForm) != "O"
    loc_cOut = loc_cOut + "[X] 1. INSTANCIA: FALHOU (VARTYPE = " + ;
        VARTYPE(loc_oForm) + ")" + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, "C:\4c\automation\teste_sigopchc_f6.txt")
    QUIT
ENDIF

loc_cOut = loc_cOut + "[OK] 1. INSTANCIA: BaseClass=" + loc_oForm.BaseClass + ;
    " Caption=[" + loc_oForm.Caption + "]" + ;
    " WxH=" + TRANSFORM(loc_oForm.Width) + "x" + TRANSFORM(loc_oForm.Height) + ;
    CHR(13) + CHR(10)

*-- 2) CAMPO DE ENTRADA: Format/InputMask do dump ---------------------------
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 2. txt_4c_Taxa (unico campo de entrada) ---" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  Value         = [" + TRANSFORM(loc_oForm.txt_4c_Taxa.Value) + ;
    "] tipo=" + VARTYPE(loc_oForm.txt_4c_Taxa.Value) + " (legado lnTaxa=0.00 -> N)" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  Format        = [" + loc_oForm.txt_4c_Taxa.Format + "] (dump: R)" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  InputMask     = [" + loc_oForm.txt_4c_Taxa.InputMask + "] (dump: 999.99)" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  SpecialEffect = " + TRANSFORM(loc_oForm.txt_4c_Taxa.SpecialEffect) + " (dump: 1)" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  TabIndex      = " + TRANSFORM(loc_oForm.txt_4c_Taxa.TabIndex) + " (dump: 2)" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  Label1.Caption= [" + loc_oForm.lbl_4c_Label1.Caption + "]" + CHR(13) + CHR(10)

*-- 3) BINDEVENT LIGADO -----------------------------------------------------
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 3. BINDEVENT (AEVENTS no objeto de ORIGEM) ---" + CHR(13) + CHR(10)
LOCAL ARRAY loc_aEv[1, 5]
loc_nQtd = AEVENTS(loc_aEv, loc_oForm.txt_4c_Taxa)
loc_cOut = loc_cOut + "  txt_4c_Taxa     = " + TRANSFORM(loc_nQtd)
FOR loc_nI = 1 TO loc_nQtd
    loc_cOut = loc_cOut + " [" + UPPER(loc_aEv[loc_nI, 3]) + " -> " + UPPER(loc_aEv[loc_nI, 4]) + "]"
ENDFOR
loc_cOut = loc_cOut + CHR(13) + CHR(10)

loc_nQtd = AEVENTS(loc_aEv, loc_oForm.cmd_4c_Fwbtng1)
loc_cOut = loc_cOut + "  cmd_4c_Fwbtng1  = " + TRANSFORM(loc_nQtd)
FOR loc_nI = 1 TO loc_nQtd
    loc_cOut = loc_cOut + " [" + UPPER(loc_aEv[loc_nI, 3]) + " -> " + UPPER(loc_aEv[loc_nI, 4]) + "]"
ENDFOR
loc_cOut = loc_cOut + CHR(13) + CHR(10)

loc_nQtd = AEVENTS(loc_aEv, loc_oForm.cmd_4c_BtnOK)
loc_cOut = loc_cOut + "  cmd_4c_BtnOK    = " + TRANSFORM(loc_nQtd)
FOR loc_nI = 1 TO loc_nQtd
    loc_cOut = loc_cOut + " [" + UPPER(loc_aEv[loc_nI, 3]) + " -> " + UPPER(loc_aEv[loc_nI, 4]) + "]"
ENDFOR
loc_cOut = loc_cOut + CHR(13) + CHR(10)

*-- 4) ValidarTaxa() espelha tela -> this_nTaxa -> BO -----------------------
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 4. ValidarTaxa() (equivale ao ControlSource=lnTaxa) ---" + CHR(13) + CHR(10)
loc_oForm.txt_4c_Taxa.Value = 2.50
loc_oForm.ValidarTaxa()
loc_cOut = loc_cOut + "  4a tela=2.50 -> this_nTaxa=" + TRANSFORM(loc_oForm.this_nTaxa) + ;
    "  BO.this_nTaxa=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTaxa) + ;
    " (esperado 2.50/2.50)" + CHR(13) + CHR(10)

*-- LostFocus NATIVO prova que o delegate roda de fato
loc_oForm.txt_4c_Taxa.Value = 12.75
loc_oForm.txt_4c_Taxa.LostFocus()
loc_cOut = loc_cOut + "  4b LostFocus nativo tela=12.75 -> this_nTaxa=" + ;
    TRANSFORM(loc_oForm.this_nTaxa) + "  BO=" + ;
    TRANSFORM(loc_oForm.this_oBusinessObject.this_nTaxa) + " (esperado 12.75/12.75)" + CHR(13) + CHR(10)

*-- Value CARACTERE (campo esvaziado): normaliza para numerico, sem msg
loc_oForm.txt_4c_Taxa.Value = SPACE(0)
loc_oForm.ValidarTaxa()
loc_cOut = loc_cOut + "  4c tela=vazio -> this_nTaxa=" + TRANSFORM(loc_oForm.this_nTaxa) + ;
    "  Value tipo=" + VARTYPE(loc_oForm.txt_4c_Taxa.Value) + " (esperado 0 / N)" + CHR(13) + CHR(10)

*-- 5) GRADE ----------------------------------------------------------------
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 5. grd_4c_Dados ---" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + ;
    "  RecordSource=[" + loc_oForm.grd_4c_Dados.RecordSource + "]" + ;
    "  ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.ReadOnly) + CHR(13) + CHR(10)
FOR loc_nI = 1 TO loc_oForm.grd_4c_Dados.ColumnCount
    loc_cOut = loc_cOut + "   Col" + TRANSFORM(loc_nI) + ;
        " W=" + PADR(TRANSFORM(loc_oForm.grd_4c_Dados.Columns(loc_nI).Width), 4) + ;
        " [" + PADR(loc_oForm.grd_4c_Dados.Columns(loc_nI).Header1.Caption, 14) + "] " + ;
        loc_oForm.grd_4c_Dados.Columns(loc_nI).ControlSource + CHR(13) + CHR(10)
ENDFOR

*-- 6) BO.CarregarDoCursor sobre o cursor REAL da grade ---------------------
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 6. BO.CarregarDoCursor (cursor real da grade) ---" + CHR(13) + CHR(10)
IF USED("cursor_4c_Historico")
    loc_cOut = loc_cOut + "  campos do cursor: "
    SELECT cursor_4c_Historico
    FOR loc_nI = 1 TO FCOUNT()
        loc_cOut = loc_cOut + FIELD(loc_nI) + " "
    ENDFOR
    loc_cOut = loc_cOut + CHR(13) + CHR(10)
    APPEND BLANK
    REPLACE Codigos WITH "DEV-TESTE", Grupos WITH "G1", Contas WITH "C1"
    GO TOP
    TRY
        loc_lOK = loc_oForm.this_oBusinessObject.CarregarDoCursor("cursor_4c_Historico")
        loc_cOut = loc_cOut + "  retorno=" + TRANSFORM(loc_lOK) + ;
            "  BO.this_cOperacaoCodigo=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cOperacaoCodigo) + "]" + ;
            "  BO.this_cNums=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cNums) + "]" + ;
            " (Nums preservado do Init: 00001234)" + CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cOut = loc_cOut + "  [X] estourou: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
    ENDTRY
ELSE
    loc_cOut = loc_cOut + "  (cursor_4c_Historico NAO existe)" + CHR(13) + CHR(10)
ENDIF

loc_oForm.Release()

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- DIALOGOS CAPTURADOS ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cOut, "C:\4c\automation\teste_sigopchc_f6.txt")
QUIT
