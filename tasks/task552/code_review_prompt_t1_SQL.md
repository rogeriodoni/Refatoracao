# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUN' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: QUANTIDADE, CUNIS, CUNIPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DUN' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: QUANTIDADE, CUNIS, CUNIPS

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
  ControlSource = "crSigCdUni.etiqs"
  ControlSource = "crSigCdUni.cunis"
  ControlSource = "crSigCdUni.DUnis"
  ControlSource = "crSigCdUni.pqtds"
  ControlSource = "crSigCdUni.Distribs"
  ControlSource = "crSigCdUni.ppesos"
  ControlSource = "crSigCdUni.desmembs"
  ControlSource = "crSigCdUni.cestos"
  ControlSource = "crSigCdUni.fators"
  ControlSource = "crSigCdUni.fatdivs"
  ControlSource = "crSigCdUni.pcustvens"
  ControlSource = "crSigCdUni.qtequalps"
  ControlSource = "crSigCdUni.medtmps"
  ControlSource = "crSigCdUni.EtiqDups"
  ControlSource = "crSigCdUni.recQtd"
  ControlSource = "crSigCdUni.BlqQtdFrac"
  ControlSource = "crSigCdUni.EtiqCdPro"
		lcQuery = [Select CfgGerGprs ] + ;
				    [From SigCdGrp]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formuni.prg) - TRECHOS RELEVANTES PARA PASS SQL (1706 linhas total):

*-- Linhas 400 a 418:
400:             .HighlightBackColor = RGB(255, 255, 255)
401:             .HighlightForeColor = RGB(15, 41, 104)
402:             .HighlightStyle     = 2
403:             .DeleteMark         = .F.
404:             .RecordMark         = .F.
405:             .RowHeight          = 16
406:             .ScrollBars         = 2
407:             .GridLines          = 3
408:             .Visible            = .T.
409:         ENDWITH
410:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
411: 
412:         THIS.TornarControlesVisiveis(loc_oPagina)
413:     ENDPROC
414: 
415:     *===========================================================================
416:     * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
417:     * Fase 3: apenas cabecalho + container de botoes de acao VAZIO.
418:     * Campos (TextBox/Labels/Lookups) entram nas Fases 5-6.

*-- Linhas 1235 a 1272:
1235: 
1236:     *===========================================================================
1237:     * CarregarLista - Carrega dados no grid da Page1
1238:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
1239:     * OBRIGATORIO: RecordSource/ColumnCount FORA do WITH (Problema 36)
1240:     *===========================================================================
1241:     PROCEDURE CarregarLista()
1242:         LOCAL loc_lResultado, loc_oGrid
1243:         loc_lResultado = .F.
1244: 
1245:         TRY
1246:             IF !THIS.this_oBusinessObject.Buscar("")
1247:                 loc_lResultado = .F.
1248:             ELSE
1249:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1250: 
1251:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource
1252:                 loc_oGrid.ColumnCount = 2
1253:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1254: 
1255:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
1256:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cunis"
1257:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dunis"
1258: 
1259:                 loc_oGrid.Column1.Width = 80
1260:                 loc_oGrid.Column2.Width = 337
1261: 
1262:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO)
1263:                 loc_oGrid.Column1.Header1.Caption = "Unidade"
1264:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1265: 
1266:                 THIS.FormatarGridLista(loc_oGrid)
1267: 
1268:                 GO TOP IN cursor_4c_Dados
1269:                 loc_oGrid.Refresh()
1270: 
1271:                 loc_lResultado = .T.
1272:             ENDIF

*-- Linhas 1500 a 1518:
1500:             RETURN
1501:         ENDIF
1502: 
1503:         SELECT cursor_4c_Dados
1504:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cunis)
1505: 
1506:         IF EMPTY(loc_cCodigo)
1507:             MsgAviso("Selecione uma Unidade na lista.", "Visualizar")
1508:             RETURN
1509:         ENDIF
1510: 
1511:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1512:             RETURN
1513:         ENDIF
1514: 
1515:         THIS.BOParaForm()
1516:         THIS.this_cModoAtual = "VISUALIZAR"
1517:         THIS.HabilitarCampos(.F.)
1518:         THIS.AlternarPagina(2)

*-- Linhas 1531 a 1549:
1531:             RETURN
1532:         ENDIF
1533: 
1534:         SELECT cursor_4c_Dados
1535:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cunis)
1536: 
1537:         IF EMPTY(loc_cCodigo)
1538:             MsgAviso("Selecione uma Unidade na lista.", "Alterar")
1539:             RETURN
1540:         ENDIF
1541: 
1542:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1543:             RETURN
1544:         ENDIF
1545: 
1546:         THIS.this_oBusinessObject.EditarRegistro()
1547:         THIS.BOParaForm()
1548:         THIS.this_cModoAtual = "ALTERAR"
1549:         THIS.HabilitarCampos(.T.)

*-- Linhas 1565 a 1583:
1565:             RETURN
1566:         ENDIF
1567: 
1568:         SELECT cursor_4c_Dados
1569:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cunis)
1570: 
1571:         IF EMPTY(loc_cCodigo)
1572:             MsgAviso("Selecione uma Unidade na lista.", "Excluir")
1573:             RETURN
1574:         ENDIF
1575: 
1576:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da Unidade '" + loc_cCodigo + "'?", "Excluir")
1577:             RETURN
1578:         ENDIF
1579: 
1580:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1581:             RETURN
1582:         ENDIF
1583: 

*-- Linhas 1607 a 1625:
1607:             RETURN loc_lAchou
1608:         ENDIF
1609: 
1610:         SELECT cursor_4c_Dados
1611:         LOCATE FOR ALLTRIM(cunis) = ALLTRIM(UPPER(loc_cBusca))
1612: 
1613:         IF !FOUND()
1614:             LOCATE FOR UPPER(ALLTRIM(dunis)) = UPPER(ALLTRIM(loc_cBusca))
1615:         ENDIF
1616: 
1617:         IF FOUND()
1618:             loc_lAchou = .T.
1619:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1620:         ELSE
1621:             MsgAviso("Unidade n" + CHR(227) + "o encontrada!", "Buscar")
1622:         ENDIF
1623: 
1624:         RETURN loc_lAchou
1625:     ENDPROC

*-- Linhas 1633 a 1651:
1633:     ENDPROC
1634: 
1635:     *===========================================================================
1636:     * BtnSalvarClick - Grava a Unidade (INSERT ou UPDATE conforme this_lNovoRegistro)
1637:     * BusinessBase.Salvar() ja chama ValidarDados() e exibe erro se falhar - o
1638:     * form NAO precisa de ELSE incondicional (CLAUDE.md regra #20)
1639:     * PUBLIC: BINDEVENT exige metodo publico
1640:     *===========================================================================
1641:     PROCEDURE BtnSalvarClick()
1642:         THIS.FormParaBO()
1643: 
1644:         IF THIS.this_oBusinessObject.Salvar()
1645:             MsgInfo("Unidade salva com sucesso!", "Confirmar")
1646:             THIS.AlternarPagina(1)
1647:         ELSE
1648:             IF !THIS.this_oBusinessObject.this_lErroExibido
1649:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
1650:             ENDIF
1651:         ENDIF


### BO (C:\4c\projeto\app\classes\uniBO.prg):
*====================================================================
* uniBO.prg
*
* Business Object para Cadastro de Unidades
* Tabela: SigCdUni
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS uniBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdUni)
    this_cCodigo                      = ""    && cunis char(3) - PK
    this_cDescricao                   = ""    && dunis char(20)
    this_cEtiquetaIndividual          = ""    && etiqs char(1) - S/N
    this_cPerguntaQtdEtiq             = ""    && pqtds char(1) - S/N
    this_nDistribuicao                = 0     && distribs numeric(1,0) - 1=Movimentacao 2=Preco Atual
    this_cPreenchePeso                = ""    && ppesos char(1) - S/N
    this_cQtdDesmembrada              = ""    && desmembs char(1) - S/N
    this_cControleEstoque             = ""    && cestos char(1) - 1/2/3
    this_nFatorConversaoGR            = 0     && fators numeric(7,4)
    this_nFatorDivisorCT              = 0     && fatdivs numeric(5,2)
    this_nPercCustoVendaQtde          = 0     && pcustvens numeric(5,2)
    this_cPesoIgualQtde               = ""    && qtequalps char(1) - S/N
    this_cMedicaoTempo                = ""    && medtmps char(1) - S/N
    this_nEtiquetaDuplicada           = 0     && etiqdups numeric(1,0) - checkbox
    this_nNaoRecalculaQtde            = 0     && recqtd numeric(1,0) - checkbox
    this_cBloqueiaQtdFracionada       = ""    && blqqtdfrac char(1) - S/N
    this_nNaoImprimeEtiquetaCadProduto = 0    && etiqcdpro numeric(1,0) - checkbox

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdUni"
            THIS.this_cCampoChave = "cunis"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "uniBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDPROC

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
                THIS.this_cCodigo                      = TratarNulo(cunis,      "C")
                THIS.this_cDescricao                   = TratarNulo(dunis,      "C")
                THIS.this_cEtiquetaIndividual           = TratarNulo(etiqs,     "C")
                THIS.this_cPerguntaQtdEtiq              = TratarNulo(pqtds,     "C")
                THIS.this_nDistribuicao                 = TratarNulo(distribs,  "N")
                THIS.this_cPreenchePeso                 = TratarNulo(ppesos,    "C")
                THIS.this_cQtdDesmembrada                = TratarNulo(desmembs, "C")
                THIS.this_cControleEstoque              = TratarNulo(cestos,    "C")
                THIS.this_nFatorConversaoGR             = TratarNulo(fators,    "N")
                THIS.this_nFatorDivisorCT               = TratarNulo(fatdivs,   "N")
                THIS.this_nPercCustoVendaQtde           = TratarNulo(pcustvens, "N")
                THIS.this_cPesoIgualQtde                = TratarNulo(qtequalps, "C")
                THIS.this_cMedicaoTempo                 = TratarNulo(medtmps,   "C")
                THIS.this_nEtiquetaDuplicada            = TratarNulo(etiqdups,  "N")
                THIS.this_nNaoRecalculaQtde             = TratarNulo(recqtd,    "N")
                THIS.this_cBloqueiaQtdFracionada        = TratarNulo(blqqtdfrac, "C")
                THIS.this_nNaoImprimeEtiquetaCadProduto = TratarNulo(etiqcdpro, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "uniBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Transcrito do legado (Grupo_Salva.Salva.Click, ramos INSERIR/ALTERAR):
    * Unidade e Descricao obrigatorios; Unidade duplicada so bloqueia na INCLUSAO
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            THIS.this_cMensagemErro = "Unidade n" + CHR(227) + "o pode ficar em branco!"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                THIS.this_cMensagemErro = "Unidade j" + CHR(225) + " Cadastrada!"
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            THIS.this_cMensagemErro = "Descri" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o pode ficar em branco."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se a unidade ja existe no banco
    * Transcrito do legado: ChkRegister('SigCdUni','cunis', valor)
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdUni" + ;
                " WHERE cunis = " + EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar Unidade:" + CHR(13) + loException.Message, "uniBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdUni
    * NOTA: acimas, abaixos, ftconvuns, descuni, etiqref, impdesc sao
    * colunas NOT NULL sem controle correspondente no form legado
    * (nao referenciadas em nenhum lugar do codigo fonte original) -
    * gravadas com 0 (CLAUDE.md regra #22)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdUni (
                    cunis, dunis, etiqs, pqtds, distribs, ppesos, desmembs,
                    cestos, fators, fatdivs, pcustvens, qtequalps, medtmps,
                    etiqdups, recqtd, blqqtdfrac, etiqcdpro,
                    acimas, abaixos, ftconvuns, descuni, etiqref, impdesc
                )
                VALUES (
                    <<EscaparSQL(ALLTRIM(THIS.this_cCodigo))>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(THIS.this_cEtiquetaIndividual)>>,
                    <<EscaparSQL(THIS.this_cPerguntaQtdEtiq)>>,
                    <<FormatarNumeroSQL(THIS.this_nDistribuicao, 0)>>,
                    <<EscaparSQL(THIS.this_cPreenchePeso)>>,
                    <<EscaparSQL(THIS.this_cQtdDesmembrada)>>,
                    <<EscaparSQL(THIS.this_cControleEstoque)>>,
                    <<FormatarNumeroSQL(THIS.this_nFatorConversaoGR, 4)>>,
                    <<FormatarNumeroSQL(THIS.this_nFatorDivisorCT, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nPercCustoVendaQtde, 2)>>,
                    <<EscaparSQL(THIS.this_cPesoIgualQtde)>>,
                    <<EscaparSQL(THIS.this_cMedicaoTempo)>>,
                    <<FormatarNumeroSQL(THIS.this_nEtiquetaDuplicada, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNaoRecalculaQtde, 0)>>,
                    <<EscaparSQL(THIS.this_cBloqueiaQtdFracionada)>>,
                    <<FormatarNumeroSQL(THIS.this_nNaoImprimeEtiquetaCadProduto, 0)>>,
                    <<FormatarNumeroSQL(0, 3)>>,
                    <<FormatarNumeroSQL(0, 3)>>,
                    <<FormatarNumeroSQL(0, 2)>>,
                    <<FormatarNumeroSQL(0, 0)>>,
                    <<FormatarNumeroSQL(0, 0)>>,
                    <<FormatarNumeroSQL(0, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir unidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "uniBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdUni
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdUni
                SET dunis      = <<EscaparSQL(THIS.this_cDescricao)>>,
                    etiqs      = <<EscaparSQL(THIS.this_cEtiquetaIndividual)>>,
                    pqtds      = <<EscaparSQL(THIS.this_cPerguntaQtdEtiq)>>,
                    distribs   = <<FormatarNumeroSQL(THIS.this_nDistribuicao, 0)>>,
                    ppesos     = <<EscaparSQL(THIS.this_cPreenchePeso)>>,
                    desmembs   = <<EscaparSQL(THIS.this_cQtdDesmembrada)>>,
                    cestos     = <<EscaparSQL(THIS.this_cControleEstoque)>>,
                    fators     = <<FormatarNumeroSQL(THIS.this_nFatorConversaoGR, 4)>>,
                    fatdivs    = <<FormatarNumeroSQL(THIS.this_nFatorDivisorCT, 2)>>,
                    pcustvens  = <<FormatarNumeroSQL(THIS.this_nPercCustoVendaQtde, 2)>>,
                    qtequalps  = <<EscaparSQL(THIS.this_cPesoIgualQtde)>>,
                    medtmps    = <<EscaparSQL(THIS.this_cMedicaoTempo)>>,
                    etiqdups   = <<FormatarNumeroSQL(THIS.this_nEtiquetaDuplicada, 0)>>,
                    recqtd     = <<FormatarNumeroSQL(THIS.this_nNaoRecalculaQtde, 0)>>,
                    blqqtdfrac = <<EscaparSQL(THIS.this_cBloqueiaQtdFracionada)>>,
                    etiqcdpro  = <<FormatarNumeroSQL(THIS.this_nNaoImprimeEtiquetaCadProduto, 0)>>
                WHERE cunis = <<EscaparSQL(ALLTRIM(THIS.this_cCodigo))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar unidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "uniBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdUni
    * Transcrito do legado (Salva.Click, ramo EXCLUIR): bloqueia exclusao
    * se a Unidade estiver em uso em SigCdPro.cunis, SigCdGrp.cunips
    * ou referenciada na posicao 11-13 de SigCdGrp.cfggergprs
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUsoProduto, loc_nUsoGrupo
        loc_lSucesso    = .F.
        loc_nUsoProduto = 0
        loc_nUsoGrupo   = 0

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nUso FROM SigCdPro" + ;
                " WHERE cunis = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")

            IF loc_nResultado < 0
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkPro")
                    SELECT cursor_4c_ChkPro
                    loc_nUsoProduto = NVL(cursor_4c_ChkPro.nUso, 0)
                    USE IN cursor_4c_ChkPro
                ENDIF

                IF loc_nUsoProduto > 0
                    THIS.this_cMensagemErro = "Existe Produto Cadastrado com essa Unidade!"
                ELSE
                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        SELECT COUNT(*) AS nUso FROM SigCdGrp
                        WHERE cunips = <<EscaparSQL(ALLTRIM(THIS.this_cCodigo))>>
                           OR SUBSTRING(cfggergprs, 11, 3) = <<EscaparSQL(ALLTRIM(THIS.this_cCodigo))>>
                    ENDTEXT
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkGrp")

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_ChkGrp")
                            SELECT cursor_4c_ChkGrp
                            loc_nUsoGrupo = NVL(cursor_4c_ChkGrp.nUso, 0)
                            USE IN cursor_4c_ChkGrp
                        ENDIF

                        IF loc_nUsoGrupo > 0
                            THIS.this_cMensagemErro = "Existe Um Grupo de Produto Cadastrado com essa Unidade!"
                        ELSE
                            loc_cSQL = "DELETE FROM SigCdUni WHERE cunis = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado >= 0
                                THIS.RegistrarAuditoria("DELETE")
                                loc_lSucesso = .T.
                            ELSE
                                MostrarErro("Erro ao excluir unidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "uniBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com as colunas da grade do legado
    * (cunis "Unidade", dunis "Descricao" - PROCEDURE Init/AddCursor)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cunis C(3), dunis C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cunis, dunis FROM SigCdUni"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY cunis"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar unidades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "uniBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cunis)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cunis, dunis, etiqs, pqtds, distribs, ppesos, desmembs,
                    cestos, fators, fatdivs, pcustvens, qtequalps, medtmps,
                    etiqdups, recqtd, blqqtdfrac, etiqcdpro
                FROM SigCdUni
                WHERE cunis = <<EscaparSQL(ALLTRIM(par_cCodigo))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Unidade n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar unidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "uniBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

