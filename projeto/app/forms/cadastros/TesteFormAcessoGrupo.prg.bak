*==============================================================================
* TesteFormAcessoGrupo.prg
* Teste para identificar exatamente onde ocorre o erro
*==============================================================================
CLEAR
SET TALK OFF

PUBLIC gb_4c_ValidandoUI
gb_4c_ValidandoUI = .T.

? "=== Teste FormAcessoGrupo ==="
? ""

TRY
    ? "1. Carregando config.prg..."
    CD C:\4c\projeto\app\start
    DO config.prg
    ? "   OK"

    ? "2. Testando CREATEOBJECT..."
    LOCAL loc_oForm
    loc_oForm = CREATEOBJECT("FormAcessoGrupo")
    ? "   OK - Form criado!"

    ? ""
    ? "=== TESTE PASSOU ==="

    IF VARTYPE(loc_oForm) = "O"
        loc_oForm.Release()
    ENDIF

CATCH TO loEx
    ? ""
    ? "=== ERRO ==="
    ? "Linha: " + TRANSFORM(loEx.LineNo)
    ? "Procedure: " + loEx.Procedure
    ? "Message: " + loEx.Message
    ? "ErrorNo: " + TRANSFORM(loEx.ErrorNo)
ENDTRY

RELEASE gb_4c_ValidandoUI

? ""
? "Pressione qualquer tecla..."
WAIT ""
