*==============================================================================
* TestSigOpC44F6.prg - Probe da Fase 6 do FormSigOpC44 (task650).
* Prova 4 coisas que o gate NAO prova:
*   1. o form INSTANCIA (o Init nao estoura em cadeia)
*   2. os 4 campos existem e nasceram com os defaults do Init legado
*   3. os BINDEVENT ficaram LIGADOS (AEVENTS no objeto de ORIGEM)
*   4. ValidarParametros() devolve o veredito certo nos 4 cenarios do legado
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
gc_4c_ArquivoErroTeste  = "C:\4c\automation\teste_sigopc44_dialogs.txt"

STRTOFILE("", gc_4c_ArquivoErroTeste)

SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg"    ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\validators.prg"  ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg"     ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\gridbase.prg"     ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpC44BO.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigOpC44.prg" ADDITIVE

LOCAL loc_cOut, loc_oForm, loc_nI, loc_lOK
loc_cOut = "=== PROBE Fase 6 - FormSigOpC44 (task650) ===" + CHR(13) + CHR(10)

*-- 1) INSTANCIAR -----------------------------------------------------------
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSigOpC44")
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[X] CREATEOBJECT estourou: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + ;
        CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loc_oForm) != "O"
    loc_cOut = loc_cOut + "[X] 1. INSTANCIA: FALHOU (VARTYPE = " + ;
        VARTYPE(loc_oForm) + ")" + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, "C:\4c\automation\teste_sigopc44_f6.txt")
    QUIT
ENDIF

loc_cOut = loc_cOut + "[OK] 1. INSTANCIA: BaseClass=" + loc_oForm.BaseClass + ;
    " Caption=[" + loc_oForm.Caption + "]" + ;
    " WxH=" + TRANSFORM(loc_oForm.Width) + "x" + TRANSFORM(loc_oForm.Height) + ;
    CHR(13) + CHR(10)

*-- 2) CAMPOS + DEFAULTS DO INIT LEGADO -------------------------------------
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 2. CAMPOS E DEFAULTS ---" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  txt_4c_Txtdest.Value   = [" + ;
    TRANSFORM(loc_oForm.txt_4c_Txtdest.Value) + "] (legado: C:\)" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  txt_4c_DtEst.Value     = [" + ;
    TRANSFORM(loc_oForm.txt_4c_DtEst.Value) + "] tipo=" + ;
    VARTYPE(loc_oForm.txt_4c_DtEst.Value) + " (legado: Date())" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  txt_4c_NumParc.Value   = [" + ;
    TRANSFORM(loc_oForm.txt_4c_NumParc.Value) + "] tipo=" + ;
    VARTYPE(loc_oForm.txt_4c_NumParc.Value) + " (legado: 1)" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  cbo_4c_GetFinal.ListIndex = " + ;
    TRANSFORM(loc_oForm.cbo_4c_GetFinal.ListIndex) + ;
    " ListCount=" + TRANSFORM(loc_oForm.cbo_4c_GetFinal.ListCount) + ;
    " (legado NAO seleciona: 0)" + CHR(13) + CHR(10)

*-- Espelho tela -> BO feito pelo AplicarValoresPadrao
loc_cOut = loc_cOut + "  BO.this_cDestino       = [" + ;
    TRANSFORM(loc_oForm.this_oBusinessObject.this_cDestino) + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  BO.this_dDataEstoque   = [" + ;
    TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataEstoque) + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  BO.this_nNumParcelas   = " + ;
    TRANSFORM(loc_oForm.this_oBusinessObject.this_nNumParcelas) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  BO.this_nFinalidade    = " + ;
    TRANSFORM(loc_oForm.this_oBusinessObject.this_nFinalidade) + CHR(13) + CHR(10)

*-- 3) BINDEVENT LIGADOS ----------------------------------------------------
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 3. BINDEVENT (AEVENTS no objeto de ORIGEM) ---" + CHR(13) + CHR(10)
LOCAL ARRAY loc_aEv[1, 5]

STORE 0 TO loc_nQtd
loc_nQtd = AEVENTS(loc_aEv, loc_oForm.txt_4c_DtEst)
loc_cOut = loc_cOut + "  txt_4c_DtEst      = " + TRANSFORM(loc_nQtd)
FOR loc_nI = 1 TO loc_nQtd
    loc_cOut = loc_cOut + " [" + UPPER(loc_aEv[loc_nI, 3]) + " -> " + ;
        UPPER(loc_aEv[loc_nI, 4]) + "]"
ENDFOR
loc_cOut = loc_cOut + CHR(13) + CHR(10)

loc_nQtd = AEVENTS(loc_aEv, loc_oForm.txt_4c_NumParc)
loc_cOut = loc_cOut + "  txt_4c_NumParc    = " + TRANSFORM(loc_nQtd)
FOR loc_nI = 1 TO loc_nQtd
    loc_cOut = loc_cOut + " [" + UPPER(loc_aEv[loc_nI, 3]) + " -> " + ;
        UPPER(loc_aEv[loc_nI, 4]) + "]"
ENDFOR
loc_cOut = loc_cOut + CHR(13) + CHR(10)

loc_nQtd = AEVENTS(loc_aEv, loc_oForm.cbo_4c_GetFinal)
loc_cOut = loc_cOut + "  cbo_4c_GetFinal   = " + TRANSFORM(loc_nQtd)
FOR loc_nI = 1 TO loc_nQtd
    loc_cOut = loc_cOut + " [" + UPPER(loc_aEv[loc_nI, 3]) + " -> " + ;
        UPPER(loc_aEv[loc_nI, 4]) + "]"
ENDFOR
loc_cOut = loc_cOut + CHR(13) + CHR(10)

loc_nQtd = AEVENTS(loc_aEv, loc_oForm.txt_4c_Txtdest)
loc_cOut = loc_cOut + "  txt_4c_Txtdest    = " + TRANSFORM(loc_nQtd) + ;
    " (ReadOnly no legado: esperado 0)" + CHR(13) + CHR(10)

*-- 4) ValidarParametros() nos 4 cenarios do legado -------------------------
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 4. ValidarParametros() ---" + CHR(13) + CHR(10)

*-- 4a) default (destino C:\ + data hoje + finalidade NAO escolhida) -> .F. (guard 3)
loc_lOK = loc_oForm.ValidarParametros()
loc_cOut = loc_cOut + "  4a finalidade nao escolhida  -> " + TRANSFORM(loc_lOK) + ;
    " (esperado .F.)" + CHR(13) + CHR(10)

*-- 4b) destino vazio -> .F. (guard 1)
loc_oForm.cbo_4c_GetFinal.ListIndex = 1
loc_oForm.txt_4c_Txtdest.Value = ""
loc_lOK = loc_oForm.ValidarParametros()
loc_cOut = loc_cOut + "  4b destino vazio             -> " + TRANSFORM(loc_lOK) + ;
    " (esperado .F.)" + CHR(13) + CHR(10)

*-- 4c) data vazia -> .F. (guard 2)
loc_oForm.txt_4c_Txtdest.Value = "C:\"
loc_oForm.txt_4c_DtEst.Value   = {}
loc_lOK = loc_oForm.ValidarParametros()
loc_cOut = loc_cOut + "  4c data do estoque vazia     -> " + TRANSFORM(loc_lOK) + ;
    " (esperado .F.)" + CHR(13) + CHR(10)

*-- 4d) tudo preenchido -> .T.
loc_oForm.txt_4c_DtEst.Value = DATE()
loc_lOK = loc_oForm.ValidarParametros()
loc_cOut = loc_cOut + "  4d tudo preenchido           -> " + TRANSFORM(loc_lOK) + ;
    " (esperado .T.)" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "     BO.this_nFinalidade apos 4d = " + ;
    TRANSFORM(loc_oForm.this_oBusinessObject.this_nFinalidade) + ;
    " (espelho do ListIndex)" + CHR(13) + CHR(10)

*-- 5) KeyPress NATIVO prova que o delegate roda (espelho tela -> BO) -------
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 5. KeyPress NATIVO (ENTER) espelha tela -> BO ---" + CHR(13) + CHR(10)
loc_oForm.txt_4c_NumParc.Value = 7
loc_oForm.txt_4c_NumParc.KeyPress(13, 0)
loc_cOut = loc_cOut + "  tela=7  ->  BO.this_nNumParcelas = " + ;
    TRANSFORM(loc_oForm.this_oBusinessObject.this_nNumParcelas) + ;
    " (esperado 7)" + CHR(13) + CHR(10)

loc_oForm.Release()

*-- Dialogos capturados em modo teste
IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- DIALOGOS CAPTURADOS ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cOut, "C:\4c\automation\teste_sigopc44_f6.txt")
QUIT
