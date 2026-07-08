*=================================================================================
* TESTE FORMPRODUTO - Script de teste r?pido
*=================================================================================

CLEAR
CLOSE DATABASES ALL
CLOSE TABLES ALL

*-- Configurar ambiente
CD C:\4c\projeto\app\start
DO main.prg

*-- Testar abertura do formul?rio
LOCAL loc_oForm

TRY
	? "Criando FormProduto..."
	loc_oForm = CREATEOBJECT("FormProduto")

	? "FormProduto criado com sucesso!"
	? "Exibindo formul?rio..."

	loc_oForm.Show()

	? "Formul" + CHR(225) + "rio exibido. Pressione qualquer tecla para fechar..."
	WAIT "" TIMEOUT 30

	loc_oForm.Release()
	? "FormProduto liberado."

CATCH TO loc_oErro
	? "ERRO ao criar/exibir FormProduto:"
	? loc_oErro.Message
	? "Linha:", loc_oErro.LineNo
	? "Procedure:", loc_oErro.Procedure
ENDTRY

? ""
? "Teste conclu" + CHR(237) + "do."
WAIT "Pressione qualquer tecla para sair..."

*-- Fechar conex?o
IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
	SQLDISCONNECT(gnConnHandle)
ENDIF

QUIT
