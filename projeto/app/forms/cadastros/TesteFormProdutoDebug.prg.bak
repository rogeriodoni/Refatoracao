*=================================================================================
* TESTE FORMPRODUTO - Debug detalhado
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
	? "=== TESTE FORMPRODUTO - DEBUG ==="
	? ""
	? "1. Verificando conex?o SQL..."
	IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
		? "ERRO: Conex?o SQL n?o estabelecida!"
		WAIT "Pressione qualquer tecla..."
		QUIT
	ENDIF
	? "   OK - Conex?o: " + TRANSFORM(gnConnHandle)
	? ""

	? "2. Verificando se ProdutoBO pode ser criado..."
	LOCAL loc_oBO
	loc_oBO = CREATEOBJECT("ProdutoBO")
	? "   OK - ProdutoBO criado"
	loc_oBO = .NULL.
	? ""

	? "3. Criando FormProduto..."
	loc_oForm = CREATEOBJECT("FormProduto")

	IF ISNULL(loc_oForm)
		? "ERRO: FormProduto retornou NULL!"
		WAIT "Pressione qualquer tecla..."
		QUIT
	ENDIF

	? "   OK - FormProduto criado com sucesso!"
	? ""

	? "4. Propriedades do Form:"
	? "   Caption: " + loc_oForm.Caption
	? "   Width: " + TRANSFORM(loc_oForm.Width)
	? "   Height: " + TRANSFORM(loc_oForm.Height)
	? "   this_cModoAtual: " + loc_oForm.this_cModoAtual
	? ""

	? "5. Verificando PageFrame..."
	IF TYPE("loc_oForm.pgf_4c_Principal") = "O"
		? "   OK - PageFrame existe"
		? "   PageCount: " + TRANSFORM(loc_oForm.pgf_4c_Principal.PageCount)
		? "   ActivePage: " + TRANSFORM(loc_oForm.pgf_4c_Principal.ActivePage)
	ELSE
		? "   ERRO - PageFrame n?o encontrado!"
	ENDIF
	? ""

	? "6. Verificando Grid..."
	IF TYPE("loc_oForm.pgf_4c_Principal.Page1.grd_4c_Dados") = "O"
		? "   OK - Grid existe"
		? "   RecordSource: " + loc_oForm.pgf_4c_Principal.Page1.grd_4c_Dados.RecordSource
		IF USED("cursor_4c_Lista")
			? "   Cursor cursor_4c_Lista: " + TRANSFORM(RECCOUNT("cursor_4c_Lista")) + " registros"
		ELSE
			? "   AVISO - Cursor cursor_4c_Lista n?o existe"
		ENDIF
	ELSE
		? "   ERRO - Grid n?o encontrado!"
	ENDIF
	? ""

	? "7. Exibindo formul?rio..."
	loc_oForm.Show()

	? ""
	? "Formul?rio exibido. Pressione qualquer tecla para fechar..."
	WAIT "" TIMEOUT 60

	loc_oForm.Release()
	? "FormProduto liberado."

CATCH TO loc_oErro
	? ""
	? "========================================="
	? "ERRO CAPTURADO:"
	? "========================================="
	? "Mensagem: " + loc_oErro.Message
	? "Linha: " + TRANSFORM(loc_oErro.LineNo)
	? "Procedure: " + loc_oErro.Procedure
	? "Details: " + loc_oErro.Details
	? "========================================="
ENDTRY

? ""
? "Teste conclu?do."
WAIT "Pressione qualquer tecla para sair..."

*-- Fechar conex?o
IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
	SQLDISCONNECT(gnConnHandle)
ENDIF

QUIT
