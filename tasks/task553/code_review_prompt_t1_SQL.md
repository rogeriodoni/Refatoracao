# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, UNIPRDTS, GERBALS, VALUE

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
  ControlSource = "crSigCdUpd.Codigos"
  ControlSource = "crSigCdUpd.ordems"
  ControlSource = "crSigCdUpd.Descrs"
  ControlSource = "crSigCdUpd.UniPrdts"
  ControlSource = "crSigCdUpd.Qtdes"
  ControlSource = "crSigCdUpd.hordds"
  ControlSource = "crSigCdUpd.ddsems"
Select crSigCdUpd
lcQryUprdt = [Select a.*, b.Descrs From SigCdUpd a Inner Join SigCdGcr b on a.Codigos = b.Codigos]
Select crSigCdUpd
		lcQryUprdt = [Select * From SigCdUpd Where Codigos = ']+Thisform.Pagina.Dados.getCodigos.Value+[' And ]+;
		ThisForm.poDatamgr.SqlExecute(lcQryUprdt,'csSigCdUpd')
		Select csSigCdUpd
Select crSigCdUpd
	lcUpdate = [Update SigCdUpd Set Ordems = ]+Str(lnOrdem,2)+[ Where Codigos = ']+lcFase+[']
	Thisform.Podatamgr.Sqlexecute(lcUpdate,'')
	ThisForm.poDatamgr.SqlExecute([Select Codigos, Descrs From SigCdGcr Where GerBals = 1],'crSigCdGcr')
	ThisForm.poDatamgr.SqlExecute([Select Codigos, Descrs From SigCdGcr Where GerBals = 1],'crSigCdGcr')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormUpd.prg) - TRECHOS RELEVANTES PARA PASS SQL (1460 linhas total):

*-- Linhas 356 a 411:
356:             .HighlightBackColor = RGB(255, 255, 255)
357:             .HighlightForeColor = RGB(15, 41, 104)
358:             .HighlightStyle     = 2
359:             .DeleteMark         = .F.
360:             .RecordMark         = .F.
361:             .RowHeight          = 16
362:             .ScrollBars         = 2
363:             .GridLines          = 3
364:             .Visible            = .T.
365:         ENDWITH
366:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
367: 
368:         THIS.TornarControlesVisiveis(loc_oPagina)
369:     ENDPROC
370: 
371:     *===========================================================================
372:     * CarregarLista - Carrega dados no grid da Page1
373:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
374:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
375:     * Colunas transcritas de SIGCDUPD.Init(): Codigos="Fase", UniPrdts=
376:     * "Unid. Produtiva", Descrs="Descricao", Ordems="Ordem"
377:     *===========================================================================
378:     PROCEDURE CarregarLista()
379:         LOCAL loc_lResultado, loc_oGrid
380:         loc_lResultado = .F.
381: 
382:         TRY
383:             IF !THIS.this_oBusinessObject.Buscar("")
384:                 loc_lResultado = .F.
385:             ELSE
386:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
387: 
388:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
389:                 loc_oGrid.ColumnCount = 4
390:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
391: 
392:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
393:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
394:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.uniprdts"
395:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
396:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.ordems"
397: 
398:                 loc_oGrid.Column1.Width = 80
399:                 loc_oGrid.Column2.Width = 150
400:                 loc_oGrid.Column3.Width = 590
401:                 loc_oGrid.Column4.Width = 60
402: 
403:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
404:                 loc_oGrid.Column1.Header1.Caption = "Fase"
405:                 loc_oGrid.Column2.Header1.Caption = "Unid. Produtiva"
406:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
407:                 loc_oGrid.Column4.Header1.Caption = "Ordem"
408: 
409:                 THIS.FormatarGridLista(loc_oGrid)
410:                 loc_lResultado = .T.
411:             ENDIF

*-- Linhas 487 a 505:
487:         loc_cIdChaves = ""
488: 
489:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
490:             SELECT cursor_4c_Dados
491:             loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
492:         ENDIF
493: 
494:         IF EMPTY(loc_cIdChaves)
495:             MsgAviso("Selecione um registro para visualizar.")
496:         ELSE
497:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
498:                 THIS.BOParaForm()
499:                 THIS.this_cModoAtual = "VISUALIZAR"
500:                 THIS.HabilitarCampos(.F.)
501:                 THIS.AlternarPagina(2)
502:                 THIS.AjustarBotoesPorModo()
503:             ENDIF
504:         ENDIF
505:     ENDPROC

*-- Linhas 513 a 531:
513:         loc_cIdChaves = ""
514: 
515:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
516:             SELECT cursor_4c_Dados
517:             loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
518:         ENDIF
519: 
520:         IF EMPTY(loc_cIdChaves)
521:             MsgAviso("Selecione um registro para alterar.")
522:         ELSE
523:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
524:                 THIS.this_oBusinessObject.EditarRegistro()
525:                 THIS.BOParaForm()
526:                 THIS.this_cModoAtual = "ALTERAR"
527:                 THIS.HabilitarCampos(.T.)
528:                 THIS.AlternarPagina(2)
529:                 THIS.AjustarBotoesPorModo()
530:             ENDIF
531:         ENDIF

*-- Linhas 541 a 559:
541:         loc_cFase     = ""
542: 
543:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
544:             SELECT cursor_4c_Dados
545:             loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
546:             loc_cFase     = ALLTRIM(cursor_4c_Dados.codigos) + "/" + ALLTRIM(cursor_4c_Dados.uniprdts)
547:         ENDIF
548: 
549:         IF EMPTY(loc_cIdChaves)
550:             MsgAviso("Selecione um registro para excluir.")
551:         ELSE
552:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
553:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da unidade produtiva [" + loc_cFase + "]?", ;
554:                     "Confirmar Exclus" + CHR(227) + "o")
555:                     IF THIS.this_oBusinessObject.Excluir()
556:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
557:                         THIS.CarregarLista()
558:                     ENDIF
559:                 ENDIF

*-- Linhas 581 a 611:
581:                 loc_oBusca.Show()
582: 
583:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd")
584:                     SELECT cursor_4c_BuscaUpd
585:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaUpd.Codigos)
586:                 ENDIF
587: 
588:                 loc_oBusca.Release()
589:             ENDIF
590: 
591:             IF USED("cursor_4c_BuscaUpd")
592:                 USE IN cursor_4c_BuscaUpd
593:             ENDIF
594: 
595:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
596:                 SELECT cursor_4c_Dados
597:                 LOCATE FOR ALLTRIM(codigos) == loc_cCodigo
598:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
599:             ENDIF
600: 
601:         CATCH TO loException
602:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormUpd.BtnBuscarClick")
603:             IF USED("cursor_4c_BuscaUpd")
604:                 USE IN cursor_4c_BuscaUpd
605:             ENDIF
606:         ENDTRY
607:     ENDPROC
608: 
609:     *===========================================================================
610:     * BtnEncerrarClick - Fecha o formulario
611:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)

*-- Linhas 1080 a 1098:
1080: 
1081:     *===========================================================================
1082:     * BOParaForm - Transfere valores do Business Object para o Form (Page2)
1083:     * this_cDescricaoFase vem do JOIN com SigCdGcr (BO.CarregarDoCursor)
1084:     * PUBLIC: chamado por BtnVisualizarClick/BtnAlterarClick
1085:     *===========================================================================
1086:     PROCEDURE BOParaForm()
1087:         LOCAL loc_oPagina
1088:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1089: 
1090:         WITH THIS.this_oBusinessObject
1091:             loc_oPagina.txt_4c_Codigo.Value           = .this_cCodigo
1092:             loc_oPagina.txt_4c_Descricao.Value        = .this_cDescricaoFase
1093:             loc_oPagina.txt_4c_UnidadeProdutiva.Value = .this_cUnidadeProdutiva
1094:             loc_oPagina.txt_4c_Quantidade.Value       = .this_nQuantidade
1095:             loc_oPagina.txt_4c_HorasPorDia.Value      = .this_nHorasDia
1096:             loc_oPagina.txt_4c_DiasPorSemana.Value    = .this_nDiasSemana
1097:             loc_oPagina.txt_4c_Ordem.Value             = .this_nOrdem
1098:         ENDWITH

*-- Linhas 1222 a 1240:
1222:                 ENDIF
1223: 
1224:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFase")
1225:                     SELECT cursor_4c_BuscaFase
1226:                     loc_oPagina.txt_4c_Codigo.Value    = ALLTRIM(cursor_4c_BuscaFase.Codigos)
1227:                     loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(cursor_4c_BuscaFase.Descrs)
1228:                     THIS.this_cUltimoCodigoFaseValidado = ALLTRIM(cursor_4c_BuscaFase.Codigos)
1229:                 ELSE
1230:                     loc_oPagina.txt_4c_Codigo.Value     = ""
1231:                     loc_oPagina.txt_4c_Descricao.Value  = ""
1232:                     THIS.this_cUltimoCodigoFaseValidado = ""
1233:                 ENDIF
1234: 
1235:                 loc_oBusca.Release()
1236:             ENDIF
1237: 
1238:             IF USED("cursor_4c_BuscaFase")
1239:                 USE IN cursor_4c_BuscaFase
1240:             ENDIF

*-- Linhas 1316 a 1334:
1316:                 ENDIF
1317: 
1318:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFaseDesc")
1319:                     SELECT cursor_4c_BuscaFaseDesc
1320:                     loc_oPagina.txt_4c_Descricao.Value     = ALLTRIM(cursor_4c_BuscaFaseDesc.Descrs)
1321:                     loc_oPagina.txt_4c_Codigo.Value         = ALLTRIM(cursor_4c_BuscaFaseDesc.Codigos)
1322:                     THIS.this_cUltimaDescricaoFaseValidada = ALLTRIM(cursor_4c_BuscaFaseDesc.Descrs)
1323:                     THIS.this_cUltimoCodigoFaseValidado    = ALLTRIM(cursor_4c_BuscaFaseDesc.Codigos)
1324:                 ELSE
1325:                     loc_oPagina.txt_4c_Descricao.Value     = ""
1326:                     THIS.this_cUltimaDescricaoFaseValidada = ""
1327:                 ENDIF
1328: 
1329:                 loc_oBusca.Release()
1330:             ENDIF
1331: 
1332:             IF USED("cursor_4c_BuscaFaseDesc")
1333:                 USE IN cursor_4c_BuscaFaseDesc
1334:             ENDIF


### BO (C:\4c\projeto\app\classes\UpdBO.prg):
*====================================================================
* UpdBO.prg
*
* Business Object para Upd (Cadastro de Unidade Produtiva)
* Tabela: SigCdUpd (PK: cidchaves - Fortyus)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS UpdBO AS BusinessBase

	*-- Propriedades da entidade (colunas de SigCdUpd - docs/schema.sql)
	this_cIdChaves          = ""   && cidchaves char(20) - PK (Fortyus)
	this_cCodigo             = ""   && codigos   char(10) - Fase (FK SigCdGcr.Codigos)
	this_nDiasSemana         = 0    && ddsems    numeric(1,0) - Dias por Semana (0-7)
	this_nHorasDia           = 0    && hordds    numeric(4,2) - Horas Por Dia
	this_cUnidadeProdutiva   = ""   && uniprdts  char(10) - Unidade Produtiva
	this_nOrdem              = 0    && ordems    numeric(2,0) - Ordem no Mapa
	this_nQuantidade         = 0    && qtdes     numeric(2,0) - Quantidade

	*-- Propriedade de exibicao (NAO existe em SigCdUpd - vem do JOIN com
	*-- SigCdGcr.Descrs em Buscar()/CarregarPorCodigo(); NUNCA gravar esta
	*-- coluna em Inserir/Atualizar, pois SigCdUpd nao tem campo descrs)
	this_cDescricaoFase      = ""   && SigCdGcr.descrs (JOIN, somente leitura)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdUpd"
			THIS.this_cCampoChave = "cidchaves"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "UpdBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cIdChaves)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	* this_cDescricaoFase vem do JOIN com SigCdGcr.Descrs (somente leitura)
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cIdChaves         = TratarNulo(cidchaves, "C")
				THIS.this_cCodigo           = TratarNulo(codigos,   "C")
				THIS.this_nDiasSemana       = TratarNulo(ddsems,    "N")
				THIS.this_nHorasDia         = TratarNulo(hordds,    "N")
				THIS.this_cUnidadeProdutiva = TratarNulo(uniprdts,  "C")
				THIS.this_nOrdem            = TratarNulo(ordems,    "N")
				THIS.this_nQuantidade       = TratarNulo(qtdes,     "N")
				THIS.this_cDescricaoFase    = TratarNulo(descrs,    "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "UpdBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Transcrito do legado (Pagina.Dados.Grupo_Salva.Salva.Click):
	* - Codigo (Fase) obrigatorio
	* - Duplicidade Codigos+UniPrdts bloqueada SOMENTE na INCLUSAO
	* Transcrito do legado (get_ddf.Valid): Dias por Semana entre 0 e 7
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(ALLTRIM(THIS.this_cCodigo))
			THIS.this_cMensagemErro = "C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!"
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND (THIS.this_nDiasSemana < 0 OR THIS.this_nDiasSemana > 7)
			THIS.this_cMensagemErro = "A Semana s" + CHR(243) + " pode ter no m" + CHR(225) + "ximo 7 dias..."
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarUnidadeExistente(THIS.this_cCodigo, THIS.this_cUnidadeProdutiva)
				THIS.this_cMensagemErro = "Unidade J" + CHR(225) + " Cadastrada!!!"
				loc_lValido = .F.
			ENDIF
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarUnidadeExistente - Verifica se ja existe registro com o
	* mesmo par Codigos+UniPrdts (transcrito de Salva.Click, ramo INSERIR)
	*====================================================================
	PROCEDURE VerificarUnidadeExistente(par_cCodigo, par_cUnidade)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdUpd" + ;
				" WHERE codigos = " + EscaparSQL(par_cCodigo) + ;
				" AND uniprdts = " + EscaparSQL(par_cUnidade)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkUpd")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkUpd")
				SELECT cursor_4c_ChkUpd
				loc_lExiste = (cursor_4c_ChkUpd.qtd > 0)
				USE IN cursor_4c_ChkUpd
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar unidade:" + CHR(13) + loException.Message, "UpdBO.VerificarUnidadeExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdUpd
	* cidchaves (PK Fortyus) gerado via fUniqueIds() se nao vier preenchido
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(THIS.this_cIdChaves)
				THIS.this_cIdChaves = fUniqueIds()
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdUpd (cidchaves, codigos, ddsems, hordds, uniprdts, ordems, qtdes)
				VALUES (
					<<EscaparSQL(THIS.this_cIdChaves)>>,
					<<EscaparSQL(THIS.this_cCodigo)>>,
					<<FormatarNumeroSQL(THIS.this_nDiasSemana, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nHorasDia, 2)>>,
					<<EscaparSQL(THIS.this_cUnidadeProdutiva)>>,
					<<FormatarNumeroSQL(THIS.this_nOrdem, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nQuantidade, 0)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir unidade produtiva:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "UpdBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdUpd
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdUpd
				SET codigos  = <<EscaparSQL(THIS.this_cCodigo)>>,
					ddsems   = <<FormatarNumeroSQL(THIS.this_nDiasSemana, 0)>>,
					hordds   = <<FormatarNumeroSQL(THIS.this_nHorasDia, 2)>>,
					uniprdts = <<EscaparSQL(THIS.this_cUnidadeProdutiva)>>,
					ordems   = <<FormatarNumeroSQL(THIS.this_nOrdem, 0)>>,
					qtdes    = <<FormatarNumeroSQL(THIS.this_nQuantidade, 0)>>
				WHERE cidchaves = <<EscaparSQL(THIS.this_cIdChaves)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar unidade produtiva:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "UpdBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* DepoisDeGravar - Transcrito de Salva.Click (apos DoDefault()):
	* o legado sincroniza Ordems em TODAS as unidades produtivas da MESMA
	* Fase (Codigos), nao so no registro corrente - Ordem eh atributo da
	* Fase, exibido/editado em cada unidade mas compartilhado entre elas.
	*====================================================================
	PROTECTED PROCEDURE DepoisDeGravar()
		LOCAL loc_cSQL
		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdUpd SET ordems = <<FormatarNumeroSQL(THIS.this_nOrdem, 0)>>
				WHERE codigos = <<EscaparSQL(THIS.this_cCodigo)>>
			ENDTEXT
			SQLEXEC(gnConnHandle, loc_cSQL)
		CATCH TO loException
			MostrarErro("Erro ao sincronizar ordem:" + CHR(13) + loException.Message, "UpdBO.DepoisDeGravar")
		ENDTRY
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdUpd
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdUpd WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir unidade produtiva:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "UpdBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Transcrito de PROCEDURE Init:
	*   Select a.*, b.Descrs From SigCdUpd a Inner Join SigCdGcr b
	*     on a.Codigos = b.Codigos
	* Retorna cursor_4c_Dados com as colunas da grade do legado
	* (Codigos="Fase", UniPrdts="Unid. Produtiva", Descrs="Descricao",
	*  Ordems="Ordem")
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (cidchaves C(20), codigos C(10), uniprdts C(10), descrs C(40), ordems N(2,0), ddsems N(1,0), hordds N(4,2), qtdes N(2,0))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT a.cidchaves, a.codigos, a.uniprdts, b.descrs," + ;
					" a.ordems, a.ddsems, a.hordds, a.qtdes" + ;
					" FROM SigCdUpd a INNER JOIN SigCdGcr b ON a.codigos = b.codigos"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY a.codigos, a.uniprdts"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar unidades produtivas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "UpdBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT a.cidchaves, a.codigos, a.uniprdts, b.descrs,
					a.ordems, a.ddsems, a.hordds, a.qtdes
				FROM SigCdUpd a INNER JOIN SigCdGcr b ON a.codigos = b.codigos
				WHERE a.cidchaves = <<EscaparSQL(par_cCodigo)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Unidade produtiva n" + CHR(227) + "o encontrada!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar unidade produtiva:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "UpdBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

