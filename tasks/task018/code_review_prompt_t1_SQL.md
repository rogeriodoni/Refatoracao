# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESTADOS, ESTAS

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
  ControlSource = "crSigCdUfs.UFIBGES"
  ControlSource = "crSigCdUfs.estados"
  ControlSource = "crSigCdUfs.descrs"
  ControlSource = "crSigCdUfs.aliqsbs"
  ControlSource = "crSigCdUfs.aicms"
  ControlSource = "crSigCdUfs.areduzidas"
  ControlSource = "crSigCdUfs.bicms"
  ControlSource = "crSigCdUfs.layoutnf"
  ControlSource = "crSigCdUfs.ger60D"
  ControlSource = "crSigCdUfs.ger60I"
  ControlSource = "crSigCdUfs.ger60R"
  ControlSource = "crSigCdUfs.ger74"
  ControlSource = "crSigCdUfs.ger75"
  ControlSource = "crSigCdUfs.ger77"
  ControlSource = "crSigCdUfs.gerSefaz"
  ControlSource = "crSigCdUfs.ger60"
  ControlSource = "crSigCdUfs.ger50"
  ControlSource = "crSigCdUfs.ger51"
  ControlSource = "crSigCdUfs.ger54"
  ControlSource = "crSigCdUfs.ger70"
  ControlSource = "crSigCdUfs.ger61"
  ControlSource = "crSigCdUfs.ger88"
  ControlSource = "crSigCdUfs.ger53"
  ControlSource = "crSigCdUfs.ngersufr1s"
  ControlSource = "crSigCdUfs.gerncm"
  ControlSource = "crSigCdUfs.ger60P"
  ControlSource = "crSigCdUfs.nCotepe52s"
  ControlSource = "crSigCdUfs.codidents"
  ControlSource = "crSigCdUfs.ger88ms"
Select CrSigCdUfs
    select CrSigCdUfs

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormUfs.prg) - TRECHOS RELEVANTES PARA PASS SQL (1941 linhas total):

*-- Linhas 418 a 436:
418:             .HighlightBackColor = RGB(255, 255, 255)
419:             .HighlightForeColor = RGB(15, 41, 104)
420:             .HighlightStyle     = 2
421:             .DeleteMark         = .F.
422:             .RecordMark         = .F.
423:             .RowHeight          = 16
424:             .ScrollBars         = 2
425:             .GridLines          = 3
426:             .Visible            = .T.
427:         ENDWITH
428: 
429:         THIS.TornarControlesVisiveis(loc_oPagina)
430:     ENDPROC
431: 
432:     *==========================================================================
433:     * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
434:     *==========================================================================
435:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
436:         LOCAL loc_lResultado

*-- Linhas 476 a 499:
476:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
477:                     loc_oGrid.ColumnCount  = 5
478: 
479:                     *-- ControlSource APOS RecordSource (Problema 48)
480:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.estados"
481:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
482:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aicms"
483:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.bicms"
484:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.areduzidas"
485: 
486:                     *-- Larguras das colunas (originais: 40, 250, 80, 80, 80)
487:                     loc_oGrid.Column1.Width = 60
488:                     loc_oGrid.Column2.Width = 350
489:                     loc_oGrid.Column3.Width = 90
490:                     loc_oGrid.Column4.Width = 100
491:                     loc_oGrid.Column5.Width = 110
492: 
493:                     *-- Headers APOS RecordSource (Problema 6 / Problema 32)
494:                     loc_oGrid.Column1.Header1.Caption = "UF"
495:                     loc_oGrid.Column2.Header1.Caption = "Nome"
496:                     loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "q. ICMS"
497:                     loc_oGrid.Column4.Header1.Caption = "B.ICMS Redu"
498:                     loc_oGrid.Column5.Header1.Caption = "Al" + CHR(237) + "q. Reduzida"
499: 

*-- Linhas 593 a 611:
593:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
594:                 MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
595:             ELSE
596:                 SELECT cursor_4c_Dados
597:                 loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
598: 
599:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
600:                     THIS.this_cModoAtual = "VISUALIZAR"
601:                     THIS.BOParaForm()
602:                     THIS.HabilitarCampos(.F.)
603:                     THIS.AjustarChkboxesPorBoConteudo()
604:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
605:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
606:                     THIS.pgf_4c_Paginas.ActivePage = 2
607:                 ENDIF
608:             ENDIF
609:         CATCH TO loc_oErro
610:             MostrarErro(loc_oErro, "FormUfs.BtnVisualizarClick")
611:         ENDTRY

*-- Linhas 622 a 640:
622:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
623:                 MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
624:             ELSE
625:                 SELECT cursor_4c_Dados
626:                 loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
627: 
628:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
629:                     THIS.this_oBusinessObject.EditarRegistro()
630:                     THIS.this_cModoAtual = "ALTERAR"
631:                     THIS.BOParaForm()
632:                     THIS.HabilitarCampos(.T.)
633:                     THIS.AjustarChkboxesPorBoConteudo()
634:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
635:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
636:                     THIS.pgf_4c_Paginas.ActivePage = 2
637:                 ENDIF
638:             ENDIF
639:         CATCH TO loc_oErro
640:             MostrarErro(loc_oErro, "FormUfs.BtnAlterarClick")

*-- Linhas 656 a 683:
656:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
657:                 MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
658:             ELSE
659:                 SELECT cursor_4c_Dados
660:                 loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
661:                 loc_cDescr  = ALLTRIM(cursor_4c_Dados.descrs)
662: 
663:                 *-- Verificar dependencia em SigCdCli (clientes cadastrados neste estado)
664:                 SQLEXEC(gnConnHandle, ;
665:                     "SELECT COUNT(*) AS qtd FROM SigCdCli WHERE Ests = " + EscaparSQL(loc_cEstado), ;
666:                     "cursor_4c_DepCli")
667:                 IF USED("cursor_4c_DepCli")
668:                     SELECT cursor_4c_DepCli
669:                     loc_nDep = NVL(cursor_4c_DepCli.qtd, 0)
670:                     USE IN cursor_4c_DepCli
671:                 ENDIF
672: 
673:                 IF loc_nDep > 0
674:                     MsgAviso("UF '" + loc_cEstado + "' n" + CHR(227) + "o pode ser exclu" + ;
675:                         CHR(237) + "do." + CHR(13) + ;
676:                         "Existem " + TRANSFORM(loc_nDep) + " cliente(s) cadastrado(s) neste estado.", ;
677:                         "Depend" + CHR(234) + "ncia")
678:                 ELSE
679:                     loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do estado:" + ;
680:                         CHR(13) + loc_cEstado + " - " + loc_cDescr, ;
681:                         "Confirmar Exclus" + CHR(227) + "o")
682: 
683:                     IF loc_lConfirmado

*-- Linhas 713 a 757:
713:                 loc_oBusca.Show()
714: 
715:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstados")
716:                     SELECT cursor_4c_BuscaEstados
717:                     loc_cFiltro = ALLTRIM(cursor_4c_BuscaEstados.estados)
718:                 ENDIF
719: 
720:                 loc_oBusca.Release()
721:             ENDIF
722: 
723:             IF USED("cursor_4c_BuscaEstados")
724:                 USE IN cursor_4c_BuscaEstados
725:             ENDIF
726: 
727:             *-- Recarrega lista com filtro (ou sem filtro se vazio)
728:             IF EMPTY(loc_cFiltro)
729:                 THIS.CarregarLista()
730:             ELSE
731:                 LOCAL loc_oGrid
732:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
733: 
734:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
735:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
736:                     loc_oGrid.ColumnCount  = 5
737: 
738:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.estados"
739:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
740:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aicms"
741:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.bicms"
742:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.areduzidas"
743: 
744:                     loc_oGrid.Column1.Header1.Caption = "UF"
745:                     loc_oGrid.Column2.Header1.Caption = "Nome"
746:                     loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "q. ICMS"
747:                     loc_oGrid.Column4.Header1.Caption = "B.ICMS Redu"
748:                     loc_oGrid.Column5.Header1.Caption = "Al" + CHR(237) + "q. Reduzida"
749: 
750:                     THIS.FormatarGridLista(loc_oGrid)
751:                 ENDIF
752:             ENDIF
753:         CATCH TO loc_oErro
754:             MostrarErro(loc_oErro, "FormUfs.BtnBuscarClick")
755:             IF USED("cursor_4c_BuscaEstados")
756:                 USE IN cursor_4c_BuscaEstados
757:             ENDIF


### BO (C:\4c\projeto\app\classes\UfsBO.prg):
*==============================================================================
* UfsBO.prg - Business Object para Cadastro de Estados (UFs)
* Tabela: SigCdUfs
* Chave: estados (char 2)
* Migrado de: SigCdUfs.SCX (SIGCDUFD)
*==============================================================================

DEFINE CLASS UfsBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - campos da tabela SigCdUfs
    *--------------------------------------------------------------------------

    *-- Identificacao (PK)
    this_cEstados                  = ""   && estados CHAR(2) - PK
    this_cDescrs                   = ""   && descrs CHAR(40)

    *-- Aliquotas ICMS
    this_nAicms                    = 0    && aicms NUMERIC(9,2) - Aliquota ICMS
    this_nBicms                    = 0    && bicms NUMERIC(9,2) - Base ICMS Reduzida
    this_nAreduzidas               = 0    && areduzidas NUMERIC(9,2) - Aliquota Reduzida
    this_nAliqsbs                  = 0    && aliqsbs NUMERIC(9,2) - Aliquota Local Substituicao Tributaria

    *-- IPI / Codigo IBGE / Layout NFCe
    this_cIpis                     = ""   && ipis CHAR(1) - T=Tributado I=Isento O=Outros
    this_nUFIBGEs                  = 0    && UFIBGEs NUMERIC(2,0) - Codigo IBGE
    this_cLayoutnf                 = ""   && layoutnf CHAR(20) - Layout NFCe
    this_nChkgnre                  = 0    && chkgnre NUMERIC(1,0)
    this_nNcotepe52s               = 0    && ncotepe52s INT - CAT 52

    *-- Chaves NF-e
    this_cChaveConsultaHomologacao = ""   && ChaveConsultaHomologacao CHAR(80)
    this_cChaveConsultaProducao    = ""   && ChaveConsultaProducao CHAR(80)
    this_cHomologacao              = ""   && Homologacao CHAR(80)
    this_cProducao                 = ""   && Producao CHAR(80)

    *-- Sintegra - flags NUMERIC(1,0)
    this_nGer50                    = 0    && ger50  - Tipo 50 Nota Fiscal (Modelos 1,1A,4,6,21,22)
    this_nGer51                    = 0    && ger51  - Tipo 51 Nota Fiscal de IPI (Modelo 1 e 1A)
    this_nGer53                    = 0    && ger53  - Tipo 53 Registro de Substituicao Tributaria
    this_nGer54                    = 0    && ger54  - Tipo 54 Registro de Produtos das Notas Fiscais
    this_nGer60                    = 0    && ger60  - Tipo 60 Notas Emitidas Por EFC/PDV
    this_nGer60D                   = 0    && ger60d - Tipo 60 (D) Resumo Diario dos Cupons
    this_nGer60I                   = 0    && ger60i - Tipo 60 (I) Itens dos Cupons
    this_nGer60R                   = 0    && ger60r - Tipo 60 (R) Resumo Mensal dos Cupons
    this_nGer60P                   = 0    && ger60p - Tipo 60 (P) Condicoes de Pagamento
    this_nGer61                    = 0    && ger61  - Tipo 61 Nota Fiscal (Modelos 14,15,16,13,2,4)
    this_nGer70                    = 0    && ger70  - Tipo 70 Notas e Conhecimentos de Transportes
    this_nGer74                    = 0    && ger74  - Tipo 74 Inventario
    this_nGer75                    = 0    && ger75  - Tipo 75 Produtos
    this_nGer77                    = 0    && ger77  - Tipo 77 Objetos Para Transportadora
    this_nGer88                    = 0    && ger88  - Tipo 88 Apuracao de ICMS - GIM para PB
    this_nGer88ms                  = 0    && ger88ms - Tipo 88 MS
    this_nGerSefaz                 = 0    && gersefaz - Tipos (16,17,18,19) Selos Para Sefaz
    this_nGerncm                   = 0    && gerncm - Usar barrar no NCM
    this_nCodidents                = 0    && codidents - Usar Codigo de Identidade dos Produtos
    this_nNgersufr1s               = 0    && ngersufr1s INT - sem uso

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdUfs"
            THIS.this_cCampoChave = "estados"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *==========================================================================
    PUBLIC FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEstados
    ENDFUNC

    *==========================================================================
    * Buscar - Seleciona registros com filtro opcional (PUBLIC)
    *==========================================================================
    PUBLIC FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE UPPER(estados) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    ") OR UPPER(descrs) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")"
            ENDIF

            loc_cSQL = "SELECT estados, descrs, aicms, bicms, areduzidas," + ;
                " aliqsbs, ipis, UFIBGEs, layoutnf," + ;
                " ger50, ger51, ger53, ger54, ger60, ger60d, ger60i, ger60r, ger60p," + ;
                " ger61, ger70, ger74, ger75, ger77, ger88, ger88ms, gersefaz," + ;
                " gerncm, codidents, ngersufr1s, ncotepe52s" + ;
                " FROM SigCdUfs" + loc_cWhere + ;
                " ORDER BY estados"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar estados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo (estado) (PUBLIC)
    *==========================================================================
    PUBLIC FUNCTION CarregarPorCodigo(par_cEstados)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT estados, descrs, aicms, bicms, areduzidas," + ;
                " aliqsbs, ipis, UFIBGEs, layoutnf," + ;
                " ger50, ger51, ger53, ger54, ger60, ger60d, ger60i, ger60r, ger60p," + ;
                " ger61, ger70, ger74, ger75, ger77, ger88, ger88ms, gersefaz," + ;
                " gerncm, codidents, ngersufr1s, ncotepe52s," + ;
                " chkgnre, ChaveConsultaHomologacao, ChaveConsultaProducao," + ;
                " Homologacao, Producao" + ;
                " FROM SigCdUfs" + ;
                " WHERE estados = " + EscaparSQL(par_cEstados)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades do BO a partir de cursor (PUBLIC)
    *==========================================================================
    PUBLIC FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEstados                  = TratarNulo(estados,                   "C")
                THIS.this_cDescrs                   = TratarNulo(descrs,                    "C")
                THIS.this_nAicms                    = TratarNulo(aicms,                     "N")
                THIS.this_nBicms                    = TratarNulo(bicms,                     "N")
                THIS.this_nAreduzidas               = TratarNulo(areduzidas,                "N")
                THIS.this_nAliqsbs                  = TratarNulo(aliqsbs,                   "N")
                THIS.this_cIpis                     = TratarNulo(ipis,                      "C")
                THIS.this_nUFIBGEs                  = TratarNulo(UFIBGEs,                   "N")
                THIS.this_cLayoutnf                 = TratarNulo(layoutnf,                  "C")
                THIS.this_nGer50                    = TratarNulo(ger50,                     "N")
                THIS.this_nGer51                    = TratarNulo(ger51,                     "N")
                THIS.this_nGer53                    = TratarNulo(ger53,                     "N")
                THIS.this_nGer54                    = TratarNulo(ger54,                     "N")
                THIS.this_nGer60                    = TratarNulo(ger60,                     "N")
                THIS.this_nGer60D                   = TratarNulo(ger60d,                    "N")
                THIS.this_nGer60I                   = TratarNulo(ger60i,                    "N")
                THIS.this_nGer60R                   = TratarNulo(ger60r,                    "N")
                THIS.this_nGer60P                   = TratarNulo(ger60p,                    "N")
                THIS.this_nGer61                    = TratarNulo(ger61,                     "N")
                THIS.this_nGer70                    = TratarNulo(ger70,                     "N")
                THIS.this_nGer74                    = TratarNulo(ger74,                     "N")
                THIS.this_nGer75                    = TratarNulo(ger75,                     "N")
                THIS.this_nGer77                    = TratarNulo(ger77,                     "N")
                THIS.this_nGer88                    = TratarNulo(ger88,                     "N")
                THIS.this_nGer88ms                  = TratarNulo(ger88ms,                   "N")
                THIS.this_nGerSefaz                 = TratarNulo(gersefaz,                  "N")
                THIS.this_nGerncm                   = TratarNulo(gerncm,                    "N")
                THIS.this_nCodidents                = TratarNulo(codidents,                 "N")
                THIS.this_nNgersufr1s               = TratarNulo(ngersufr1s,                "N")
                THIS.this_nNcotepe52s               = TratarNulo(ncotepe52s,                "N")

                *-- Campos opcionais (apenas no CarregarPorCodigo completo)
                IF PEMSTATUS(ALIAS(), "chkgnre", 5)
                    THIS.this_nChkgnre              = TratarNulo(chkgnre,                   "N")
                ENDIF
                IF PEMSTATUS(ALIAS(), "ChaveConsultaHomologacao", 5)
                    THIS.this_cChaveConsultaHomologacao = TratarNulo(ChaveConsultaHomologacao, "C")
                ENDIF
                IF PEMSTATUS(ALIAS(), "ChaveConsultaProducao", 5)
                    THIS.this_cChaveConsultaProducao    = TratarNulo(ChaveConsultaProducao,    "C")
                ENDIF
                IF PEMSTATUS(ALIAS(), "Homologacao", 5)
                    THIS.this_cHomologacao              = TratarNulo(Homologacao,              "C")
                ENDIF
                IF PEMSTATUS(ALIAS(), "Producao", 5)
                    THIS.this_cProducao                 = TratarNulo(Producao,                 "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - Insere novo registro na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdUfs (" + ;
                "estados, descrs, aicms, bicms, areduzidas, aliqsbs, ipis," + ;
                " UFIBGEs, layoutnf, chkgnre," + ;
                " ger50, ger51, ger53, ger54, ger60, ger60d, ger60i, ger60r, ger60p," + ;
                " ger61, ger70, ger74, ger75, ger77, ger88, ger88ms, gersefaz," + ;
                " gerncm, codidents, ngersufr1s, ncotepe52s," + ;
                " ChaveConsultaHomologacao, ChaveConsultaProducao, Homologacao, Producao" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cEstados) + ", " + ;
                EscaparSQL(THIS.this_cDescrs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAicms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBicms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAreduzidas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqsbs) + ", " + ;
                EscaparSQL(THIS.this_cIpis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUFIBGEs) + ", " + ;
                EscaparSQL(THIS.this_cLayoutnf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkgnre) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer50) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer51) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer53) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer54) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60D) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60I) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60R) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60P) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer61) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer70) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer74) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer75) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer77) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer88) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer88ms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGerSefaz) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGerncm) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCodidents) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNgersufr1s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcotepe52s) + ", " + ;
                EscaparSQL(THIS.this_cChaveConsultaHomologacao) + ", " + ;
                EscaparSQL(THIS.this_cChaveConsultaProducao) + ", " + ;
                EscaparSQL(THIS.this_cHomologacao) + ", " + ;
                EscaparSQL(THIS.this_cProducao) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdUfs SET" + ;
                " descrs = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                " aicms = " + FormatarNumeroSQL(THIS.this_nAicms) + "," + ;
                " bicms = " + FormatarNumeroSQL(THIS.this_nBicms) + "," + ;
                " areduzidas = " + FormatarNumeroSQL(THIS.this_nAreduzidas) + "," + ;
                " aliqsbs = " + FormatarNumeroSQL(THIS.this_nAliqsbs) + "," + ;
                " ipis = " + EscaparSQL(THIS.this_cIpis) + "," + ;
                " UFIBGEs = " + FormatarNumeroSQL(THIS.this_nUFIBGEs) + "," + ;
                " layoutnf = " + EscaparSQL(THIS.this_cLayoutnf) + "," + ;
                " chkgnre = " + FormatarNumeroSQL(THIS.this_nChkgnre) + "," + ;
                " ger50 = " + FormatarNumeroSQL(THIS.this_nGer50) + "," + ;
                " ger51 = " + FormatarNumeroSQL(THIS.this_nGer51) + "," + ;
                " ger53 = " + FormatarNumeroSQL(THIS.this_nGer53) + "," + ;
                " ger54 = " + FormatarNumeroSQL(THIS.this_nGer54) + "," + ;
                " ger60 = " + FormatarNumeroSQL(THIS.this_nGer60) + "," + ;
                " ger60d = " + FormatarNumeroSQL(THIS.this_nGer60D) + "," + ;
                " ger60i = " + FormatarNumeroSQL(THIS.this_nGer60I) + "," + ;
                " ger60r = " + FormatarNumeroSQL(THIS.this_nGer60R) + "," + ;
                " ger60p = " + FormatarNumeroSQL(THIS.this_nGer60P) + "," + ;
                " ger61 = " + FormatarNumeroSQL(THIS.this_nGer61) + "," + ;
                " ger70 = " + FormatarNumeroSQL(THIS.this_nGer70) + "," + ;
                " ger74 = " + FormatarNumeroSQL(THIS.this_nGer74) + "," + ;
                " ger75 = " + FormatarNumeroSQL(THIS.this_nGer75) + "," + ;
                " ger77 = " + FormatarNumeroSQL(THIS.this_nGer77) + "," + ;
                " ger88 = " + FormatarNumeroSQL(THIS.this_nGer88) + "," + ;
                " ger88ms = " + FormatarNumeroSQL(THIS.this_nGer88ms) + "," + ;
                " gersefaz = " + FormatarNumeroSQL(THIS.this_nGerSefaz) + "," + ;
                " gerncm = " + FormatarNumeroSQL(THIS.this_nGerncm) + "," + ;
                " codidents = " + FormatarNumeroSQL(THIS.this_nCodidents) + "," + ;
                " ngersufr1s = " + FormatarNumeroSQL(THIS.this_nNgersufr1s) + "," + ;
                " ncotepe52s = " + FormatarNumeroSQL(THIS.this_nNcotepe52s) + "," + ;
                " ChaveConsultaHomologacao = " + EscaparSQL(THIS.this_cChaveConsultaHomologacao) + "," + ;
                " ChaveConsultaProducao = " + EscaparSQL(THIS.this_cChaveConsultaProducao) + "," + ;
                " Homologacao = " + EscaparSQL(THIS.this_cHomologacao) + "," + ;
                " Producao = " + EscaparSQL(THIS.this_cProducao) + ;
                " WHERE estados = " + EscaparSQL(THIS.this_cEstados)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdUfs WHERE estados = " + ;
                EscaparSQL(THIS.this_cEstados)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

