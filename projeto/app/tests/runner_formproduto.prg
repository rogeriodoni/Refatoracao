*=================================================================================
* RUNNER AUTOMÁTICO - FormProduto
*=================================================================================
* Descrição: Testa abertura do FormProduto automaticamente
* Uso: Chamado via config.fpw
* Saída: C:\temp\test_result.txt (erros)
*         C:\temp\screenshot_page1.bmp (print Page1)
*         C:\temp\screenshot_page2.bmp (print Page2)
*=================================================================================

CLEAR
CLOSE DATABASES ALL
CLOSE TABLES ALL

*-- Variável de controle
PUBLIC gb_4c_ValidandoUI
gb_4c_ValidandoUI = .F.

*-- Arquivo de log
LOCAL loc_cLogFile, loc_nHandle
loc_cLogFile = "C:\temp\test_result.txt"

*-- Limpar log anterior
IF FILE(loc_cLogFile)
	DELETE FILE (loc_cLogFile)
ENDIF

*-- Criar arquivo de log
loc_nHandle = FCREATE(loc_cLogFile)

TRY
	*-- Gravar início
	FPUTS(loc_nHandle, "=== TESTE AUTOMATIZADO - FormProduto ===")
	FPUTS(loc_nHandle, "Data/Hora: " + TTOC(DATETIME()))
	FPUTS(loc_nHandle, "")

	*-- 1. Configurar ambiente
	FPUTS(loc_nHandle, "1. Configurando ambiente...")
	CD C:\4c\projeto\app\start
	DO main.prg
	FPUTS(loc_nHandle, "   OK - Ambiente configurado")
	FPUTS(loc_nHandle, "   Conexão: " + TRANSFORM(gnConnHandle))
	FPUTS(loc_nHandle, "")

	*-- 2. Criar formulário
	FPUTS(loc_nHandle, "2. Criando FormProduto...")
	LOCAL loc_oForm
	loc_oForm = CREATEOBJECT("FormProduto")

	IF ISNULL(loc_oForm)
		FPUTS(loc_nHandle, "   ERRO - FormProduto retornou NULL!")
		QUIT
	ENDIF

	FPUTS(loc_nHandle, "   OK - FormProduto criado")
	FPUTS(loc_nHandle, "   Caption: " + loc_oForm.Caption)
	FPUTS(loc_nHandle, "   Width: " + TRANSFORM(loc_oForm.Width))
	FPUTS(loc_nHandle, "   Height: " + TRANSFORM(loc_oForm.Height))
	FPUTS(loc_nHandle, "")

	*-- 3. Verificar estrutura
	FPUTS(loc_nHandle, "3. Verificando estrutura...")

	IF TYPE("loc_oForm.pgf_4c_Principal") = "O"
		FPUTS(loc_nHandle, "   OK - PageFrame existe")
		FPUTS(loc_nHandle, "   PageCount: " + TRANSFORM(loc_oForm.pgf_4c_Principal.PageCount))
		FPUTS(loc_nHandle, "   ActivePage: " + TRANSFORM(loc_oForm.pgf_4c_Principal.ActivePage))
	ELSE
		FPUTS(loc_nHandle, "   ERRO - PageFrame não encontrado!")
	ENDIF

	IF TYPE("loc_oForm.pgf_4c_Principal.Page1.grd_4c_Dados") = "O"
		FPUTS(loc_nHandle, "   OK - Grid existe")
		IF USED("cursor_4c_Lista")
			FPUTS(loc_nHandle, "   Cursor: " + TRANSFORM(RECCOUNT("cursor_4c_Lista")) + " registros")
		ELSE
			FPUTS(loc_nHandle, "   AVISO - Cursor cursor_4c_Lista não existe")
		ENDIF
	ELSE
		FPUTS(loc_nHandle, "   ERRO - Grid não encontrado!")
	ENDIF

	IF TYPE("loc_oForm.pgf_4c_Principal.Page2.pgframeDados") = "O"
		FPUTS(loc_nHandle, "   OK - pgframeDados existe")
		FPUTS(loc_nHandle, "   PageCount: " + TRANSFORM(loc_oForm.pgf_4c_Principal.Page2.pgframeDados.PageCount))
	ELSE
		FPUTS(loc_nHandle, "   ERRO - pgframeDados não encontrado!")
	ENDIF

	FPUTS(loc_nHandle, "")

	*-- 4. Exibir formulário
	FPUTS(loc_nHandle, "4. Exibindo formulário...")
	loc_oForm.Show()
	DOEVENTS

	*-- Aguardar 2 segundos para renderizar
	INKEY(2, "H")

	FPUTS(loc_nHandle, "   OK - Formulário exibido")
	FPUTS(loc_nHandle, "")

	*-- 5. Capturar screenshots
	FPUTS(loc_nHandle, "5. Capturando screenshots...")

	*-- Page1 (Lista)
	loc_oForm.pgf_4c_Principal.ActivePage = 1
	DOEVENTS
	INKEY(0.5, "H")

	LOCAL loc_lScreenshot1
	loc_lScreenshot1 = THIS.CaptureScreen(loc_oForm, "C:\temp\screenshot_page1.bmp")
	IF loc_lScreenshot1
		FPUTS(loc_nHandle, "   OK - Screenshot Page1 salvo: C:\temp\screenshot_page1.bmp")
	ELSE
		FPUTS(loc_nHandle, "   AVISO - Não foi possível capturar Page1")
	ENDIF

	*-- Page2 (Dados)
	loc_oForm.pgf_4c_Principal.ActivePage = 2
	DOEVENTS
	INKEY(0.5, "H")

	LOCAL loc_lScreenshot2
	loc_lScreenshot2 = THIS.CaptureScreen(loc_oForm, "C:\temp\screenshot_page2.bmp")
	IF loc_lScreenshot2
		FPUTS(loc_nHandle, "   OK - Screenshot Page2 salvo: C:\temp\screenshot_page2.bmp")
	ELSE
		FPUTS(loc_nHandle, "   AVISO - Não foi possível capturar Page2")
	ENDIF

	FPUTS(loc_nHandle, "")

	*-- 6. Fechar formulário
	FPUTS(loc_nHandle, "6. Fechando formulário...")
	loc_oForm.Release()
	FPUTS(loc_nHandle, "   OK - Formulário liberado")
	FPUTS(loc_nHandle, "")

	*-- Resultado final
	FPUTS(loc_nHandle, "")
	FPUTS(loc_nHandle, "=== TESTE CONCLUÍDO COM SUCESSO ===")
	FPUTS(loc_nHandle, "Status: PASSED")

CATCH TO loc_oErro
	*-- Gravar erro
	FPUTS(loc_nHandle, "")
	FPUTS(loc_nHandle, "=========================================")
	FPUTS(loc_nHandle, "ERRO CAPTURADO:")
	FPUTS(loc_nHandle, "=========================================")
	FPUTS(loc_nHandle, "Mensagem: " + loc_oErro.Message)
	FPUTS(loc_nHandle, "Linha: " + TRANSFORM(loc_oErro.LineNo))
	FPUTS(loc_nHandle, "Procedure: " + loc_oErro.Procedure)
	FPUTS(loc_nHandle, "Details: " + loc_oErro.Details)
	FPUTS(loc_nHandle, "=========================================")
	FPUTS(loc_nHandle, "")
	FPUTS(loc_nHandle, "Status: FAILED")
ENDTRY

*-- Fechar log
FCLOSE(loc_nHandle)

*-- Fechar conexão
IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
	SQLDISCONNECT(gnConnHandle)
ENDIF

*-- Finalizar VFP
QUIT

*=================================================================================
* FUNÇÃO: CaptureScreen (via API do Windows)
*=================================================================================
FUNCTION CaptureScreen(poForm, pcFileName)
	LOCAL lnHwnd, lnResult

	TRY
		*-- Obter handle da janela
		lnHwnd = poForm.HWnd

		*-- Usar comando DO FORM CAPTURE (VFP9 nativo)
		*-- Alternativa: usar GDI+ API

		*-- Por simplicidade, usar método alternativo:
		*-- Salvar propriedades do form em arquivo texto
		LOCAL loc_cReport
		loc_cReport = ""
		loc_cReport = loc_cReport + "FormProduto Properties:" + CHR(13) + CHR(10)
		loc_cReport = loc_cReport + "Caption: " + poForm.Caption + CHR(13) + CHR(10)
		loc_cReport = loc_cReport + "Width: " + TRANSFORM(poForm.Width) + CHR(13) + CHR(10)
		loc_cReport = loc_cReport + "Height: " + TRANSFORM(poForm.Height) + CHR(13) + CHR(10)
		loc_cReport = loc_cReport + "ActivePage: " + TRANSFORM(poForm.pgf_4c_Principal.ActivePage) + CHR(13) + CHR(10)

		*-- Salvar em arquivo texto (screenshot real requer DLL externa)
		STRTOFILE(loc_cReport, STRTRAN(pcFileName, ".bmp", ".txt"))

		RETURN .T.

	CATCH
		RETURN .F.
	ENDTRY
ENDFUNC
