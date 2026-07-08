*==============================================================================
* TesteFormsigregli.prg - Teste de Compila" + CHR(231) + CHR(227) + "o do Formsigregli
*==============================================================================

* Carregar configuracoes
CD C:\4c\projeto\app\start
DO config.prg
DO ConfigurarAmbiente

* Tentar criar instancia do form
TRY
    LOCAL loForm
    loForm = CREATEOBJECT("Formsigregli")

    IF VARTYPE(loForm) = "O"
        ? "? Formsigregli compilou com sucesso!"
        ? "  - Height: " + TRANSFORM(loForm.Height)
        ? "  - Width: " + TRANSFORM(loForm.Width)
        ? "  - Caption: " + loForm.Caption

        * Mostrar form
        loForm.Show()
    ELSE
        ? "? Erro: Formsigregli n" + CHR(227) + "o foi criado"
    ENDIF

CATCH TO loErro
    ? "? ERRO ao compilar/executar Formsigregli:"
    ? "  Mensagem: " + loErro.Message
    ? "  Linha: " + TRANSFORM(loErro.LineNo)
    ? "  Procedure: " + loErro.Procedure
ENDTRY

RETURN
