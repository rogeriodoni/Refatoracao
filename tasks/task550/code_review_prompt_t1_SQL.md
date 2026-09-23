# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FKCHAVE, ESTADOS, VALUE, CODCLASFISCAL, CODCFOP

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
  ControlSource = "crSigCdUfd.codigos"
  ControlSource = "crSigCdUfd.aliqpimps"
  ControlSource = "crSigCdUfd.aliqredb"
  ControlSource = "crSigCdUfd.aliqsbs"
  ControlSource = "crSigCdUfd.aliqs"
  ControlSource = "crSigCdUfd.aliqfcp"
  ControlSource = "crSigCdUfd.destinos"
  ControlSource = "crSigCdUfd.aliqsb2s"
  ControlSource = "crSigCdUfd.cfos"
  ControlSource = "crSigCdUfd.iest"
  DeleteMark = .F.
  Column1.ControlSource = ""
  ControlSource = "crSigCdUfd.NbaseRes"
  DeleteMark = .F.
  Column1.ControlSource = ""
SELECT * from crSigcdAlo where fkchave = lcCod order by CodClasFiscal into cursor crAlo readwrite
SELECT crAlo
	.column1.ControlSource = 'crAlo.CodClasFiscal'
	.column2.ControlSource = 'crAlo.AliqLocal'
	.column3.ControlSource = 'crAlo.Aliqfcp'
	.column4.ControlSource = 'crAlo.AliqIcms'
	.column5.ControlSource = 'crAlo.sitribs'
	.column6.ControlSource = 'crAlo.cbenef'
SELECT * from crSigcdAlc where fkchave = lcCod order by codcfop into cursor crAlocfop readwrite
SELECT crAlocfop
	.column1.ControlSource = 'crAlocfop.Codcfop'
	.column3.ControlSource = 'crAlocfop.Aliqfcp'
Select crAlo
Select crAlocfop
lcSql = [Select * From SigCdAlo Where fkchave = '] + lcCod + [' order by codClasFiscal]
=ThisForm.PodataMgr.SqlExecute(lcSql,'TmpAlo')
Select TmpAlo
	Select crAlo
Select crAlo
lcSql = [Select * From SigCdAlc Where fkchave = '] + lcCod + [' order by codcfop]
=ThisForm.PodataMgr.SqlExecute(lcSql,'TmpAlocfop')
Select TmpAlocfop
	Select crAlocfop
Select crAlocfop
If Thisform.PoDatamgr.SQLExecute([Select Descrs from SigCdUfs where Estados = '] + CrSigCdUfd.codigos + [' ],'CrSigCdUfs') < 0
lcqueryok = Thisform.PoDatamgr.SQLExecute([Select Descrs from SigCdUfs where Estados = '] + CrSigCdUfd.Destinos + [' ],'CrSigCdUfs') 
		Select CrSigCdUfd
	SET delete off
		Select CrSigCdAlo
		Select crAlo
				Select CrSigCdAlo
				IF DELETED('crAlo')
					DELETE 
			SELECT crAlo
	SET delete on
	SET delete off
		Select CrSigCdAlc
		Select crAlocfop
				Select CrSigCdAlc
				IF DELETED('crAlocfop')
					DELETE 
			SELECT crAlo
	SET delete on
If Not ThisForm.poDataMgr.Update('crSigCdAlo')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdAlo)')
If Not ThisForm.poDataMgr.Update('crSigCdAlc')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdAlc)')
Select CrSigCdUfd
Select CrSigCdUfd
Select CrSigCdUfd
Select CrSigCdUfd
Select CrSigCdUfd
Select crAlo
Select crAlo
SELECT crAlo
Delete
Select codclasfiscal from crAlo into cursor Duplica group by codclasfiscal  having count(1) > 1 
Select Duplica
	Select crAlo
Select crAlo
Select crAlocfop
Select crAlocfop
SELECT crAlocfop
Delete
Select codcfop from crAlocfop into cursor Duplica group by codcfop  having count(1) > 1 
Select Duplica
	Select crAlocfop
Select crAlocfop

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormUfd.prg) - TRECHOS RELEVANTES PARA PASS SQL (1781 linhas total):

*-- Linhas 360 a 420:
360:             .HighlightBackColor = RGB(255, 255, 255)
361:             .HighlightForeColor = RGB(15, 41, 104)
362:             .HighlightStyle     = 2
363:             .DeleteMark         = .F.
364:             .RecordMark         = .F.
365:             .RowHeight          = 16
366:             .ScrollBars         = 2
367:             .GridLines          = 3
368:             .Visible            = .T.
369:         ENDWITH
370:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
371: 
372:         THIS.TornarControlesVisiveis(loc_oPagina)
373:     ENDPROC
374: 
375:     *===========================================================================
376:     * CarregarLista - Carrega dados no grid da Page1
377:     * par_cFiltro (opcional) - clausula WHERE adicional (usado por BtnBuscarClick)
378:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
379:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
380:     * Colunas conforme pColuna do legado (comportamento.json / SIGCDUFD.Init)
381:     *===========================================================================
382:     PROCEDURE CarregarLista(par_cFiltro)
383:         LOCAL loc_lResultado, loc_oGrid, loc_cFiltro
384:         loc_lResultado = .F.
385:         loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", par_cFiltro, "")
386: 
387:         TRY
388:             IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
389:                 loc_lResultado = .F.
390:             ELSE
391:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
392: 
393:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
394:                 loc_oGrid.ColumnCount = 8
395:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
396: 
397:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
398:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
399:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.destinos"
400:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aliqs"
401:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.aliqsbs"
402:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.aliqpimps"
403:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.aliqfcp"
404:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.aliqredb"
405:                 loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.iest"
406: 
407:                 loc_oGrid.Column1.Width = 80
408:                 loc_oGrid.Column2.Width = 80
409:                 loc_oGrid.Column3.Width = 80
410:                 loc_oGrid.Column4.Width = 80
411:                 loc_oGrid.Column5.Width = 80
412:                 loc_oGrid.Column6.Width = 80
413:                 loc_oGrid.Column7.Width = 80
414:                 loc_oGrid.Column8.Width = 100
415: 
416:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
417:                 loc_oGrid.Column1.Header1.Caption = "UF Origem"
418:                 loc_oGrid.Column2.Header1.Caption = "UF Destino"
419:                 loc_oGrid.Column3.Header1.Caption = "Aliq. ICMS"
420:                 loc_oGrid.Column4.Header1.Caption = "Aliq.Sub.Trib"

*-- Linhas 1127 a 1145:
1127:                 ENDIF
1128: 
1129:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
1130:                     SELECT cursor_4c_BuscaUf
1131:                     THIS.this_cUfLookupCodigo    = ALLTRIM(Estados)
1132:                     THIS.this_cUfLookupDescricao = ALLTRIM(Descrs)
1133:                     loc_lResultado = .T.
1134:                 ENDIF
1135: 
1136:                 loc_oBusca.Release()
1137:             ENDIF
1138: 
1139:         CATCH TO loException
1140:             MostrarErro("Erro ao buscar UF:" + CHR(13) + loException.Message, "FormUfd.ExecutarBuscaUf")
1141:         ENDTRY
1142: 
1143:         IF USED("cursor_4c_BuscaUf")
1144:             USE IN cursor_4c_BuscaUf
1145:         ENDIF

*-- Linhas 1373 a 1391:
1373:                 ENDIF
1374: 
1375:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfo")
1376:                     SELECT cursor_4c_BuscaCfo
1377:                     loc_oPg2.txt_4c_CFO.Value = ALLTRIM(Codigos)
1378:                 ELSE
1379:                     loc_oPg2.txt_4c_CFO.Value = ""
1380:                 ENDIF
1381: 
1382:                 loc_oBusca.Release()
1383:             ENDIF
1384: 
1385:         CATCH TO loException
1386:             MostrarErro("Erro ao buscar CFO:" + CHR(13) + loException.Message, "FormUfd.AbrirLookupCfo")
1387:         ENDTRY
1388: 
1389:         IF USED("cursor_4c_BuscaCfo")
1390:             USE IN cursor_4c_BuscaCfo
1391:         ENDIF

*-- Linhas 1562 a 1580:
1562:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1563:                 MsgAviso("Selecione um registro para alterar!")
1564:             ELSE
1565:                 SELECT cursor_4c_Dados
1566:                 loc_cChave = ALLTRIM(cidchaves)
1567: 
1568:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1569:                     THIS.this_oBusinessObject.EditarRegistro()
1570:                     THIS.BOParaForm()
1571:                     THIS.this_cModoAtual = "ALTERAR"
1572:                     THIS.HabilitarCampos(.T.)
1573:                     THIS.AjustarBotoesPorModo()
1574:                     THIS.AlternarPagina(2)
1575:                     THIS.pgf_4c_Paginas.Page2.txt_4c_OCodigo.SetFocus()
1576:                 ENDIF
1577:             ENDIF
1578: 
1579:         CATCH TO loException
1580:             MostrarErro("Erro ao alterar registro:" + CHR(13) + loException.Message, ;

*-- Linhas 1592 a 1610:
1592:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1593:                 MsgAviso("Selecione um registro para visualizar!")
1594:             ELSE
1595:                 SELECT cursor_4c_Dados
1596:                 loc_cChave = ALLTRIM(cidchaves)
1597: 
1598:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1599:                     THIS.BOParaForm()
1600:                     THIS.this_cModoAtual = "VISUALIZAR"
1601:                     THIS.HabilitarCampos(.F.)
1602:                     THIS.AjustarBotoesPorModo()
1603:                     THIS.AlternarPagina(2)
1604:                 ENDIF
1605:             ENDIF
1606: 
1607:         CATCH TO loException
1608:             MostrarErro("Erro ao visualizar registro:" + CHR(13) + loException.Message, ;
1609:                 "FormUfd.BtnVisualizarClick")
1610:         ENDTRY

*-- Linhas 1621 a 1639:
1621:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1622:                 MsgAviso("Selecione um registro para excluir!")
1623:             ELSE
1624:                 SELECT cursor_4c_Dados
1625:                 loc_cChave = ALLTRIM(cidchaves)
1626:                 loc_cUfO   = ALLTRIM(codigos)
1627:                 loc_cUfD   = ALLTRIM(destinos)
1628: 
1629:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do ICMS Interestadual " + ;
1630:                         loc_cUfO + " -> " + loc_cUfD + "?", "Confirmar Exclus" + CHR(227) + "o")
1631: 
1632:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1633:                         IF THIS.this_oBusinessObject.Excluir()
1634:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
1635:                             THIS.CarregarLista()
1636:                         ELSE
1637:                             IF !THIS.this_oBusinessObject.this_lErroExibido
1638:                                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Erro")
1639:                             ENDIF

*-- Linhas 1667 a 1687:
1667:                 ENDIF
1668: 
1669:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUfLista")
1670:                     SELECT cursor_4c_BuscaUfLista
1671:                     loc_cCodigo = ALLTRIM(Estados)
1672:                     THIS.CarregarLista("codigos = " + EscaparSQL(loc_cCodigo))
1673:                 ENDIF
1674: 
1675:                 loc_oBusca.Release()
1676:             ENDIF
1677: 
1678:         CATCH TO loException
1679:             MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FormUfd.BtnBuscarClick")
1680:         ENDTRY
1681: 
1682:         IF USED("cursor_4c_BuscaUfLista")
1683:             USE IN cursor_4c_BuscaUfLista
1684:         ENDIF
1685:     ENDPROC
1686: 
1687:     *===========================================================================


### BO (C:\4c\projeto\app\classes\UfdBO.prg):
*====================================================================
* UfdBO.prg
*
* Business Object para Cadastro de ICMS Interestadual (UF x UF)
* Tabela: SigCdUfd
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS UfdBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdUfd)
    this_cChave              = ""    && cidchaves char(20) - PK
    this_cUfOrigem           = ""    && codigos char(2)
    this_cUfDestino          = ""    && destinos char(2)
    this_nAliqIcms           = 0     && aliqs numeric(5,2)
    this_cCfop               = ""    && cfos char(10)
    this_nAliqSubTrib        = 0     && aliqsbs numeric(9,2)
    this_nAliqInterestadual  = 0     && aliqsb2s numeric(9,2)
    this_nAliqIcmsPImp       = 0     && aliqpimps numeric(4,2)
    this_nAliqFcp            = 0     && aliqfcp numeric(5,3)
    this_nAliqRedBase        = 0     && aliqredb numeric(6,3)
    this_cIeSubstituto       = ""    && iest char(20)
    this_nBaseReduzida       = 0     && nbaseres numeric(1,0)
    this_nChkIcms            = 0     && chkicms numeric(1,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdUfd"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "UfdBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChave)
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
                THIS.this_cChave             = TratarNulo(cidchaves, "C")
                THIS.this_cUfOrigem          = TratarNulo(codigos,   "C")
                THIS.this_cUfDestino         = TratarNulo(destinos,  "C")
                THIS.this_nAliqIcms          = TratarNulo(aliqs,     "N")
                THIS.this_cCfop              = TratarNulo(cfos,      "C")
                THIS.this_nAliqSubTrib       = TratarNulo(aliqsbs,   "N")
                THIS.this_nAliqInterestadual = TratarNulo(aliqsb2s,  "N")
                THIS.this_nAliqIcmsPImp      = TratarNulo(aliqpimps, "N")
                THIS.this_nAliqFcp           = TratarNulo(aliqfcp,   "N")
                THIS.this_nAliqRedBase       = TratarNulo(aliqredb,  "N")
                THIS.this_cIeSubstituto      = TratarNulo(iest,      "C")
                THIS.this_nBaseReduzida      = TratarNulo(nbaseres,  "N")
                THIS.this_nChkIcms           = TratarNulo(chkicms,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "UfdBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdUfd
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cChave)
                THIS.this_cChave = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdUfd (cidchaves, codigos, destinos, aliqs, cfos,
                    aliqsbs, aliqsb2s, aliqpimps, aliqfcp, aliqredb,
                    iest, nbaseres, chkicms)
                VALUES (
                    <<EscaparSQL(THIS.this_cChave)>>,
                    <<EscaparSQL(THIS.this_cUfOrigem)>>,
                    <<EscaparSQL(THIS.this_cUfDestino)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqIcms, 2)>>,
                    <<EscaparSQL(THIS.this_cCfop)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqSubTrib, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqInterestadual, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqIcmsPImp, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqFcp, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqRedBase, 3)>>,
                    <<EscaparSQL(THIS.this_cIeSubstituto)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseReduzida, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nChkIcms, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir ICMS Interestadual:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "UfdBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdUfd
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdUfd
                SET codigos   = <<EscaparSQL(THIS.this_cUfOrigem)>>,
                    destinos  = <<EscaparSQL(THIS.this_cUfDestino)>>,
                    aliqs     = <<FormatarNumeroSQL(THIS.this_nAliqIcms, 2)>>,
                    cfos      = <<EscaparSQL(THIS.this_cCfop)>>,
                    aliqsbs   = <<FormatarNumeroSQL(THIS.this_nAliqSubTrib, 2)>>,
                    aliqsb2s  = <<FormatarNumeroSQL(THIS.this_nAliqInterestadual, 2)>>,
                    aliqpimps = <<FormatarNumeroSQL(THIS.this_nAliqIcmsPImp, 2)>>,
                    aliqfcp   = <<FormatarNumeroSQL(THIS.this_nAliqFcp, 3)>>,
                    aliqredb  = <<FormatarNumeroSQL(THIS.this_nAliqRedBase, 3)>>,
                    iest      = <<EscaparSQL(THIS.this_cIeSubstituto)>>,
                    nbaseres  = <<FormatarNumeroSQL(THIS.this_nBaseReduzida, 0)>>,
                    chkicms   = <<FormatarNumeroSQL(THIS.this_nChkIcms, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar ICMS Interestadual:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "UfdBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cidchaves (chave oculta p/ Alterar/Excluir)
    * + as 8 colunas exibidas na grade da lista (pColuna do legado)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cidchaves C(20), codigos C(2), destinos C(2), ;
                        aliqs N(5,2), aliqsbs N(9,2), aliqpimps N(4,2), aliqfcp N(5,3), ;
                        aliqredb N(6,3), iest C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cidchaves, codigos, destinos, aliqs, aliqsbs," + ;
                    " aliqpimps, aliqfcp, aliqredb, iest FROM SigCdUfd"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos, destinos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar ICMS Interestadual:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "UfdBO.Buscar")
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
                SELECT cidchaves, codigos, destinos, aliqs, cfos,
                    aliqsbs, aliqsb2s, aliqpimps, aliqfcp, aliqredb,
                    iest, nbaseres, chkicms
                FROM SigCdUfd WHERE cidchaves = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro de ICMS Interestadual n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar ICMS Interestadual:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "UfdBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdUfd
    * Chamado internamente por BusinessBase.Excluir() (PROTECTED - regra CLAUDE.md)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdUfd WHERE cidchaves = <<EscaparSQL(THIS.this_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir ICMS Interestadual:" + CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao excluir:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "UfdBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

