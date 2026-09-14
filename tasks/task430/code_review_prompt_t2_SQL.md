# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODFINP

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = "crSigCdFip.Cods"
  ControlSource = "crSigCdFip.Descs"
	lcQuery = [Select CPros, DPros ] + ;
			    [From SigCdPro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpr.prg) - TRECHOS RELEVANTES PARA PASS SQL (890 linhas total):

*-- Linhas 354 a 388:
354: 			.HighlightBackColor = RGB(255, 255, 255)
355: 			.HighlightForeColor = RGB(15, 41, 104)
356: 			.HighlightStyle     = 2
357: 			.DeleteMark         = .F.
358: 			.RecordMark         = .F.
359: 			.RowHeight          = 16
360: 			.ScrollBars         = 2
361: 			.GridLines          = 3
362: 			.Visible            = .T.
363: 		ENDWITH
364: 
365: 		*-- ControlSource e Headers APOS RecordSource (VFP reseta headers ao mudar RecordSource)
366: 		WITH loc_oGrid.Column1
367: 			.ControlSource   = "cursor_4c_Dados.Cods"
368: 			.Width           = 60
369: 			.Header1.Caption = "C" + CHR(243) + "digos"
370: 		ENDWITH
371: 
372: 		WITH loc_oGrid.Column2
373: 			.ControlSource   = "cursor_4c_Dados.Descs"
374: 			.Width           = 150
375: 			.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
376: 		ENDWITH
377: 
378: 		THIS.TornarControlesVisiveis(loc_oPagina)
379: 	ENDPROC
380: 
381: 	*====================================================================
382: 	* ConfigurarPaginaDados - Page2 (Dados)
383: 	* Grupo_Salva: Left=819,Top=10 -> Top=10+29=39
384: 	* Say1 (C" + CHR(243) + "digo): Top=157+29=186, Left=374
385: 	* getCods (txt_4c_Codigo): Top=153+29=182, Left=422, Width=31
386: 	*====================================================================
387: 	PROTECTED PROCEDURE ConfigurarPaginaDados()
388: 		LOCAL loc_oPagina

*-- Linhas 546 a 565:
546: 				ELSE
547: 					loc_oGrid.ColumnCount = 2
548: 					loc_oGrid.RecordSource = "cursor_4c_Dados"
549: 					loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Cods"
550: 					loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descs"
551: 					loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
552: 					loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
553: 					loc_oGrid.Column1.Width           = 60
554: 					loc_oGrid.Column2.Width           = 150
555: 					THIS.FormatarGridLista(loc_oGrid)
556: 					loc_lResultado = .T.
557: 				ENDIF
558: 
559: 			CATCH TO loException
560: 				MostrarErro(loException, "FormFpr.CarregarLista")
561: 				loc_lResultado = .F.
562: 			ENDTRY
563: 		ENDIF
564: 
565: 		RETURN loc_lResultado

*-- Linhas 707 a 725:
707: 		loc_cCodigo = ""
708: 
709: 		IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
710: 			SELECT cursor_4c_Dados
711: 			loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
712: 		ENDIF
713: 
714: 		IF EMPTY(loc_cCodigo)
715: 			MsgAviso("Selecione um registro na lista!")
716: 			RETURN
717: 		ENDIF
718: 
719: 		IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
720: 			THIS.BOParaForm()
721: 			THIS.this_cModoAtual = "VISUALIZAR"
722: 			THIS.HabilitarCampos(.F.)
723: 			THIS.AjustarBotoesPorModo()
724: 			THIS.AlternarPagina(2)
725: 			THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus

*-- Linhas 734 a 752:
734: 		loc_cCodigo = ""
735: 
736: 		IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
737: 			SELECT cursor_4c_Dados
738: 			loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
739: 		ENDIF
740: 
741: 		IF EMPTY(loc_cCodigo)
742: 			MsgAviso("Selecione um registro na lista!")
743: 			RETURN
744: 		ENDIF
745: 
746: 		IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
747: 			THIS.this_oBusinessObject.EditarRegistro()
748: 			THIS.BOParaForm()
749: 			THIS.this_cModoAtual = "ALTERAR"
750: 			THIS.HabilitarCampos(.T.)
751: 			THIS.AjustarBotoesPorModo()
752: 			THIS.AlternarPagina(2)

*-- Linhas 762 a 780:
762: 		loc_cCodigo = ""
763: 
764: 		IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
765: 			SELECT cursor_4c_Dados
766: 			loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
767: 		ENDIF
768: 
769: 		IF EMPTY(loc_cCodigo)
770: 			MsgAviso("Selecione um registro na lista!")
771: 			RETURN
772: 		ENDIF
773: 
774: 		IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
775: 			THIS.BOParaForm()
776: 			THIS.this_cModoAtual = "EXCLUIR"
777: 			THIS.HabilitarCampos(.F.)
778: 			THIS.AjustarBotoesPorModo()
779: 			THIS.AlternarPagina(2)
780: 			THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus

*-- Linhas 824 a 849:
824: 				loc_cFiltro    = ""
825: 
826: 				IF !EMPTY(loc_cCodigo)
827: 					loc_cFiltro = "Cods LIKE " + EscaparSQL(loc_cCodigo + "%")
828: 				ENDIF
829: 
830: 				IF !EMPTY(loc_cDescricao)
831: 					IF !EMPTY(loc_cFiltro)
832: 						loc_cFiltro = loc_cFiltro + " AND "
833: 					ENDIF
834: 					loc_cFiltro = loc_cFiltro + "Descs LIKE " + EscaparSQL("%" + loc_cDescricao + "%")
835: 				ENDIF
836: 
837: 				THIS.this_oBusinessObject.Buscar(loc_cFiltro)
838: 				IF USED("cursor_4c_Dados")
839: 					GO TOP IN cursor_4c_Dados
840: 				ENDIF
841: 				THIS.this_cModoAtual = "LISTA"
842: 				THIS.pgf_4c_Paginas.ActivePage = 1
843: 				loc_lSucesso = .T.
844: 
845: 			CASE THIS.this_cModoAtual = "EXCLUIR"
846: 				TRY
847: 					loc_lSucesso = THIS.this_oBusinessObject.Excluir()
848: 					IF loc_lSucesso
849: 						MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")


### BO (C:\4c\projeto\app\classes\FprBO.prg):
*====================================================================
* FprBO.prg
*
* Business Object para Modelos de Produtos
* Tabela: SigCdFip
* Campos: Cods (PK), Descs
*====================================================================

DEFINE CLASS FprBO AS BusinessBase

	*-- Propriedades da entidade
	this_cCods  = ""
	this_cDescs = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdFip"
			THIS.this_cCampoChave = "Cods"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "FprBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCods)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCods  = TratarNulo(Cods,  "C")
				THIS.this_cDescs = TratarNulo(Descs, "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "FprBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Regras do original: Cods e Descs nao podem ser vazios nem ter aspas
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(THIS.this_cCods) OR (AT("'", THIS.this_cCods) + AT('"', THIS.this_cCods) > 0)
			MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarCodigoExistente(THIS.this_cCods)
				MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!")
				loc_lValido = .F.
			ENDIF
		ENDIF

		IF loc_lValido AND (EMPTY(THIS.this_cDescs) OR (AT("'", THIS.this_cDescs) + AT('"', THIS.this_cDescs) > 0))
			MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!")
			loc_lValido = .F.
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarCodigoExistente - Verifica se Cods ja existe em SigCdFip
	*====================================================================
	PROCEDURE VerificarCodigoExistente(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdFip" + ;
				" WHERE Cods = " + EscaparSQL(par_cCodigo)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFpr")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkFpr")
				SELECT cursor_4c_ChkFpr
				loc_lExiste = (cursor_4c_ChkFpr.qtd > 0)
				USE IN cursor_4c_ChkFpr
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "FprBO.VerificarCodigoExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdFip
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdFip (Cods, Descs)" + ;
				" VALUES (" + EscaparSQL(THIS.this_cCods) + ", " + EscaparSQL(THIS.this_cDescs) + ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "FprBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdFip
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdFip" + ;
				" SET Descs = " + EscaparSQL(THIS.this_cDescs) + ;
				" WHERE Cods = " + EscaparSQL(THIS.this_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "FprBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro de SigCdFip
	* Verifica se produtos usam este modelo (SigCdPro.CodFinP) antes de excluir
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso, loc_cMsg
		loc_lSucesso = .F.
		loc_nUso     = 0
		loc_cMsg     = ""

		TRY
			loc_cSQL = "SELECT CPros, DPros FROM SigCdPro" + ;
				" WHERE CodFinP = " + EscaparSQL(THIS.this_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")

			IF loc_nResultado < 0
				MostrarErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
			ELSE
				IF USED("cursor_4c_ChkPro")
					SELECT cursor_4c_ChkPro
					GO TOP IN cursor_4c_ChkPro
					loc_nUso = IIF(!EOF("cursor_4c_ChkPro"), RECCOUNT("cursor_4c_ChkPro"), 0)

					IF loc_nUso > 1
						loc_cMsg = "Existem " + ALLTRIM(STR(loc_nUso)) + " Produtos Utilizando Esse Modelo!!!" + ;
							" Para Excluir o" + CHR(13) + ;
							"Modelo " + CHR(233) + " Necess" + CHR(225) + "rio Alterar o Cadastro de Produtos Primeiro!!!"
						MsgAviso(loc_cMsg)
					ELSE
						IF loc_nUso = 1
							loc_cMsg = "O Produto " + ALLTRIM(cursor_4c_ChkPro.CPros) + " - " + ;
								ALLTRIM(cursor_4c_ChkPro.DPros) + " Est" + CHR(225) + ;
								" Utilizando Esse Modelo!!!" + CHR(13) + ;
								"Para Excluir o Modelo " + CHR(233) + " Necess" + CHR(225) + ;
								"rio Alterar o Cadastro do Produto Primeiro!!!"
							MsgAviso(loc_cMsg)
						ELSE
							USE IN cursor_4c_ChkPro

							loc_cSQL = "DELETE FROM SigCdFip WHERE Cods = " + EscaparSQL(THIS.this_cCods)
							loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
							IF loc_nResultado >= 0
								THIS.RegistrarAuditoria("DELETE")
								loc_lSucesso = .T.
							ELSE
								MostrarErro("Erro ao excluir modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							ENDIF
						ENDIF
					ENDIF

					IF USED("cursor_4c_ChkPro")
						USE IN cursor_4c_ChkPro
					ENDIF
				ELSE
					loc_cSQL = "DELETE FROM SigCdFip WHERE Cods = " + EscaparSQL(THIS.this_cCods)
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao excluir modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "FprBO.ExecutarExclusao")
			IF USED("cursor_4c_ChkPro")
				USE IN cursor_4c_ChkPro
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com Cods, Descs
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (Cods C(5), Descs C(50))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT Cods, Descs FROM SigCdFip"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY Cods"

				IF USED("cursor_4c_Dados")
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
					IF loc_nResultado >= 0
						SELECT cursor_4c_Dados
						ZAP
						SET NULL ON
						APPEND FROM DBF("cursor_4c_DadosTmp")
						SET NULL OFF
						IF USED("cursor_4c_DadosTmp")
							USE IN cursor_4c_DadosTmp
						ENDIF
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar modelos de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ELSE
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
					IF loc_nResultado >= 0
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar modelos de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FprBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (Cods)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT Cods, Descs FROM SigCdFip" + ;
				" WHERE Cods = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Modelo de Produto n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "FprBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

