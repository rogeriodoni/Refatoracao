*==============================================================================
* test_formcargo.prg - Teste do FormCargo
*==============================================================================

CLEAR
SET TALK OFF
SET CONSOLE OFF

CD C:\4c\projeto\app\start

*-- Carrega configuracoes
DO config.prg

*-- Conecta ao banco
PUBLIC gnConnHandle
gnConnHandle = -1

lcStringConexao = ObterStringConexao()
gnConnHandle = SQLSTRINGCONNECT(lcStringConexao)

IF gnConnHandle < 0
    =MESSAGEBOX("Erro ao conectar ao banco de dados!", 16, "Erro")
    RETURN
ENDIF

? "Conexao OK: Handle = " + TRANSFORM(gnConnHandle)

*-- Testa criacao do FormCargo
LOCAL loForm
TRY
    ? "Criando FormCargo..."
    loForm = CREATEOBJECT("FormCargo")

    IF VARTYPE(loForm) = "O"
        ? "FormCargo criado com sucesso!"
        ? "Exibindo formulario..."
        loForm.Show()

        ? ""
        ? "Formulario exibido. Pressione qualquer tecla para encerrar..."
        WAIT "" TIMEOUT 60

        loForm.Release()
        ? "FormCargo liberado."
    ELSE
        ? "ERRO: FormCargo nao foi criado (VARTYPE = " + VARTYPE(loForm) + ")"
    ENDIF

CATCH TO loException
    ? "ERRO ao criar FormCargo:"
    ? "  Mensagem: " + loException.Message
    ? "  Linha: " + TRANSFORM(loException.LineNo)
    ? "  Procedure: " + loException.Procedure
ENDTRY

*-- Desconecta
IF gnConnHandle > 0
    =SQLDISCONNECT(gnConnHandle)
    ? "Desconectado do banco."
ENDIF

? ""
? "Teste concluido. Pressione qualquer tecla..."
WAIT ""
