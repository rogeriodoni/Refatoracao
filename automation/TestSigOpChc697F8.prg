*==============================================================================
* TestSigOpChc697F8.prg - Probe final (Fase 8) do FormSigOpChc (task697).
* Exercita o que as fases 1-7 ja deixaram pronto e que a Fase 8 teria de
* "consolidar": instanciar, grid+taxa (ja provados na Fase 6), Encerrar
* (BtnOKClick) e Baixa Cheque (BtnBaixaChequeClick) com gnConnHandle=-1
* (sem conexao - prova que o CATCH protege e nao estoura cru), e Destroy.
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
gc_4c_ArquivoErroTeste  = "C:\4c\automation\teste_sigopchc_dialogs_f8.txt"

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

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_lOK
loc_cOut = "=== PROBE Fase 8 (final) - FormSigOpChc (task697) ===" + CHR(13) + CHR(10)

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
    loc_cOut = loc_cOut + "[X] 1. INSTANCIA: FALHOU" + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, "C:\4c\automation\teste_sigopchc_f8.txt")
    QUIT
ENDIF
loc_cOut = loc_cOut + "[OK] 1. INSTANCIA" + CHR(13) + CHR(10)

*-- 2) BtnBaixaChequeClick SEM conexao (gnConnHandle=-1): nao pode estourar
*--    cru - tem de cair no CATCH/guard e devolver o form intacto
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 2. BtnBaixaChequeClick (sem conexao) ---" + CHR(13) + CHR(10)
TRY
    loc_oForm.BtnBaixaChequeClick()
    loc_cOut = loc_cOut + "[OK] nao estourou cru (guard/CATCH protegeu)" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[X] estourou: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

*-- 3) CarregarLista PUBLIC chamavel de fora (regra TesteAutomatico) -------
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 3. CarregarLista() direto (fora de BINDEVENT) ---" + CHR(13) + CHR(10)
TRY
    loc_lOK = loc_oForm.CarregarLista()
    loc_cOut = loc_cOut + "[OK] retorno=" + TRANSFORM(loc_lOK) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[X] estourou: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

*-- 4) BtnOKClick (Encerrar) - equivalente a ThisForm.Release -------------
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 4. BtnOKClick (Encerrar) ---" + CHR(13) + CHR(10)
TRY
    loc_oForm.BtnOKClick()
    loc_cOut = loc_cOut + "[OK] BtnOKClick nao estourou (Release chamado)" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[X] estourou: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- DIALOGOS CAPTURADOS ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cOut, "C:\4c\automation\teste_sigopchc_f8.txt")
QUIT
