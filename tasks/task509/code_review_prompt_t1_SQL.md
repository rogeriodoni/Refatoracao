# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS

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
  ControlSource = "crSigCdRec.Descrs"
  ControlSource = "crSigCdRec.Grupos"
select CrSigCdRec
select CrSigCdRec

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormRec.prg) - TRECHOS RELEVANTES PARA PASS SQL (986 linhas total):

*-- Linhas 344 a 362:
344:             .HighlightBackColor = RGB(255, 255, 255)
345:             .HighlightForeColor = RGB(15, 41, 104)
346:             .HighlightStyle     = 2
347:             .DeleteMark         = .F.
348:             .RecordMark         = .F.
349:             .RowHeight          = 16
350:             .ScrollBars         = 2
351:             .Visible            = .T.
352:         ENDWITH
353: 
354:         THIS.TornarControlesVisiveis(loc_oPagina)
355:     ENDPROC
356: 
357:     *==========================================================================
358:     * ConfigurarPaginaDados - Page2: Botoes Confirmar/Cancelar + campos do form
359:     * Campos: txt_4c_CdGrupo (codigos char(10)) + txt_4c_DsGrupo (descrs char(40))
360:     * Legado: get_cd_grupo (top=193, left=253) e get_ds_grupo (top=193, left=335)
361:     * Compensacao PageFrame +29: todos os tops recebem +29
362:     *==========================================================================

*-- Linhas 520 a 542:
520:                     loc_oGrid.ColumnCount  = 2
521: 
522:                     WITH loc_oGrid
523:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
524:                         .Column1.Width           = 100
525:                         .Column1.Header1.Caption = "Grupo"
526: 
527:                         .Column2.ControlSource   = "cursor_4c_Dados.descrs"
528:                         .Column2.Width           = 780
529:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
530:                     ENDWITH
531: 
532:                     THIS.FormatarGridLista(loc_oGrid)
533:                     loc_lResultado = .T.
534:                 ELSE
535:                     loc_lResultado = .F.
536:                 ENDIF
537:             ENDIF
538:         CATCH TO loException
539:             MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
540:         ENDTRY
541: 
542:         RETURN loc_lResultado

*-- Linhas 601 a 661:
601:             MsgAviso("Nenhum registro selecionado!", "Visualizar")
602:             RETURN
603:         ENDIF
604:         SELECT cursor_4c_Dados
605:         loc_cGrupo = ALLTRIM(cursor_4c_Dados.grupos)
606:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
607:             THIS.BOParaForm()
608:             THIS.this_cModoAtual = "VISUALIZAR"
609:             THIS.HabilitarCampos(.F.)
610:             THIS.AjustarBotoesPorModo()
611:             THIS.AlternarPagina(2)
612:         ENDIF
613:     ENDPROC
614: 
615:     *==========================================================================
616:     * BtnAlterarClick - Edita registro selecionado (PUBLIC para BINDEVENT)
617:     * Legado: em ALTERAR, campos ficam somente leitura (legado nao habilitava edicao)
618:     *==========================================================================
619:     PROCEDURE BtnAlterarClick()
620:         LOCAL loc_cGrupo
621:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
622:             MsgAviso("Nenhum registro selecionado!", "Alterar")
623:             RETURN
624:         ENDIF
625:         SELECT cursor_4c_Dados
626:         loc_cGrupo = ALLTRIM(cursor_4c_Dados.grupos)
627:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
628:             THIS.this_oBusinessObject.EditarRegistro()
629:             THIS.BOParaForm()
630:             THIS.this_cModoAtual = "ALTERAR"
631:             THIS.HabilitarCampos(.F.)
632:             THIS.AjustarBotoesPorModo()
633:             THIS.AlternarPagina(2)
634:         ENDIF
635:     ENDPROC
636: 
637:     *==========================================================================
638:     * BtnExcluirClick - Exclui registro selecionado (PUBLIC para BINDEVENT)
639:     *==========================================================================
640:     PROCEDURE BtnExcluirClick()
641:         LOCAL loc_cGrupo, loc_lConfirma
642:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
643:             MsgAviso("Nenhum registro selecionado!", "Excluir")
644:             RETURN
645:         ENDIF
646:         SELECT cursor_4c_Dados
647:         loc_cGrupo = ALLTRIM(cursor_4c_Dados.grupos)
648:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo '" + ;
649:             loc_cGrupo + "'?", "Excluir Recebimento")
650:         IF loc_lConfirma
651:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
652:                 IF THIS.this_oBusinessObject.Excluir()
653:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
654:                     THIS.CarregarLista()
655:                 ENDIF
656:             ENDIF
657:         ENDIF
658:     ENDPROC
659: 
660:     *==========================================================================
661:     * BtnBuscarClick - Localiza registro via FormBuscaAuxiliar (PUBLIC para BINDEVENT)

*-- Linhas 676 a 710:
676:                 loc_oBusca.Show()
677: 
678:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRec")
679:                     SELECT cursor_4c_BuscaRec
680:                     loc_cGrupo      = ALLTRIM(cursor_4c_BuscaRec.grupos)
681:                     loc_lSelecionou = .T.
682:                 ENDIF
683: 
684:                 loc_oBusca.Release()
685:             ENDIF
686:         CATCH TO loException
687:             MsgErro("Erro na busca:" + CHR(13) + loException.Message, "Erro")
688:         ENDTRY
689: 
690:         IF USED("cursor_4c_BuscaRec")
691:             USE IN cursor_4c_BuscaRec
692:         ENDIF
693: 
694:         IF loc_lSelecionou AND USED("cursor_4c_Dados")
695:             SELECT cursor_4c_Dados
696:             LOCATE FOR ALLTRIM(grupos) = loc_cGrupo
697:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
698:         ENDIF
699:     ENDPROC
700: 
701:     *==========================================================================
702:     * BtnSalvarClick - Salva o registro (PUBLIC para BINDEVENT, chamado de Page2)
703:     *==========================================================================
704:     PROCEDURE BtnSalvarClick()
705:         LOCAL loc_lSucesso
706:         loc_lSucesso = .F.
707: 
708:         *-- Validacao ANTES do TRY (CLAUDE.md regra critica)
709:         IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.Value))
710:             MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", ;

*-- Linhas 870 a 888:
870: 
871:         IF THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cCodigo, "C")
872:             IF USED("cursor_4c_BuscaGcr") AND RECCOUNT("cursor_4c_BuscaGcr") > 0
873:                 SELECT cursor_4c_BuscaGcr
874:                 IF ALLTRIM(UPPER(cursor_4c_BuscaGcr.codigos)) = UPPER(loc_cCodigo)
875:                     loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
876:                 ELSE
877:                     THIS.AbrirBuscaGrupo(loc_cCodigo)
878:                 ENDIF
879:             ELSE
880:                 THIS.AbrirBuscaGrupo(loc_cCodigo)
881:             ENDIF
882:         ENDIF
883:     ENDPROC
884: 
885:     *==========================================================================
886:     * ValidarDescricao - LostFocus de txt_4c_DsGrupo: busca codigo em SigCdGcr
887:     * Equivale a get_ds_grupo.Valid (fAcessoContab 'D') do legado
888:     * PUBLIC obrigatorio: BINDEVENT requer metodo PUBLIC (CLAUDE.md regra #3)

*-- Linhas 899 a 917:
899: 
900:         IF THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cDesc, "D")
901:             IF USED("cursor_4c_BuscaGcr") AND RECCOUNT("cursor_4c_BuscaGcr") > 0
902:                 SELECT cursor_4c_BuscaGcr
903:                 IF RECCOUNT("cursor_4c_BuscaGcr") = 1
904:                     loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
905:                     loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
906:                 ELSE
907:                     THIS.AbrirBuscaGrupo(loc_cDesc)
908:                 ENDIF
909:             ELSE
910:                 THIS.AbrirBuscaGrupo(loc_cDesc)
911:             ENDIF
912:         ENDIF
913:     ENDPROC
914: 
915:     *==========================================================================
916:     * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para selecao em SigCdGcr
917:     *==========================================================================

*-- Linhas 930 a 948:
930:                 loc_oBusca.Show()
931: 
932:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
933:                     SELECT cursor_4c_BuscaGcr
934:                     loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
935:                     loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
936:                 ELSE
937:                     loc_oPagina.txt_4c_CdGrupo.Value = ""
938:                     loc_oPagina.txt_4c_DsGrupo.Value = ""
939:                 ENDIF
940: 
941:                 loc_oBusca.Release()
942:             ENDIF
943:         CATCH TO loException
944:             MsgErro("Erro ao abrir busca de grupo:" + CHR(13) + loException.Message, "Erro")
945:         ENDTRY
946:     ENDPROC
947: 
948:     *==========================================================================


### BO (C:\4c\projeto\app\classes\RecBO.prg):
*====================================================================
* RecBO.prg
*
* Business Object para Cadastro Financeiro de Recebimentos
* Tabela: SIGCDREC
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS RecBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SIGCDREC)
    this_cGrupos    = ""    && grupos char(10) - PK (FK -> SigCdGcr.codigos)
    this_cDescrs    = ""    && descrs char(20)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SIGCDREC"
            THIS.this_cCampoChave = "grupos"
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro ao inicializar RecBO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna PK atual para auditoria (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cGrupos
    ENDFUNC

    *====================================================================
    * Buscar - SELECT todos os registros (PUBLIC)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT grupos, descrs" + ;
                       " FROM SIGCDREC" + ;
                       " ORDER BY grupos"

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar recebimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar recebimentos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pelo PK (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cGrupos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT grupos, descrs" + ;
                       " FROM SIGCDREC" + ;
                       " WHERE grupos = " + EscaparSQL(par_cGrupos)

            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos = TratarNulo(grupos, "C")
            THIS.this_cDescrs = TratarNulo(descrs, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Inserir - INSERT na tabela SIGCDREC (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SIGCDREC (grupos, descrs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cGrupos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE na tabela SIGCDREC (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDREC SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + ;
                       " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE na tabela SIGCDREC (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDREC" + ;
                       " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ValidarDados - Valida regras de negocio antes de salvar (PUBLIC)
    *====================================================================
    FUNCTION ValidarDados()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cGrupos))
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * VerificarCodigoExiste - Verifica se grupo ja cadastrado em SIGCDREC (PUBLIC)
    * Equivalente ao ChkRegister('SigCdRec','grupos',...) do legado
    *====================================================================
    FUNCTION VerificarCodigoExiste(par_cGrupos)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT grupos FROM SIGCDREC" + ;
                       " WHERE grupos = " + EscaparSQL(par_cGrupos)

            IF USED("cursor_4c_ChkCod")
                TABLEREVERT(.T., "cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkCod") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *====================================================================
    * BuscarGrupoGcr - Busca grupo em SigCdGcr por codigo ou descricao (PUBLIC)
    * Equivalente ao fAcessoContab() do legado
    * par_cTipo = 'C' busca por codigo, 'D' busca por descricao
    *====================================================================
    FUNCTION BuscarGrupoGcr(par_cValor, par_cTipo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF par_cTipo = "C"
                loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
                           " WHERE codigos = " + EscaparSQL(par_cValor) + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
                           " WHERE descrs LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + ;
                           " ORDER BY descrs"
            ENDIF

            IF USED("cursor_4c_BuscaGcr")
                TABLEREVERT(.T., "cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Destroy - Libera cursores
    *====================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_ChkCod")
            USE IN cursor_4c_ChkCod
        ENDIF
        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

