# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [GRID-SQL] Campo 'grupoos' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'grupods' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS

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
  ControlSource = "crSigCdRps.Grupods"
  ControlSource = "crSigCdRps.grupoos"
	If Thisform.PoDatamgr.SQLExecute([Select Descrs from SigCdGcr where Codigos = '] + CrSigCdRps.Grupoos + [' ],'CrSigCdGcr') < 0
	If Thisform.PoDatamgr.SQLExecute([Select Descrs from SigCdGcr where Codigos = '] + CrSigCdRps.Grupods + [' ],'CrSigCdGcr') < 0
	Select CrSigCdRps

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormRss.prg) - TRECHOS RELEVANTES PARA PASS SQL (1115 linhas total):

*-- Linhas 333 a 351:
333:             .HighlightBackColor = RGB(255, 255, 255)
334:             .HighlightForeColor = RGB(15, 41, 104)
335:             .HighlightStyle     = 2
336:             .DeleteMark         = .F.
337:             .RecordMark         = .F.
338:             .RowHeight          = 16
339:             .ScrollBars         = 2
340:             .GridLines          = 3
341:             .ReadOnly           = .T.
342:             .Visible            = .T.
343:             .Column1.Width      = 100
344:             .Column2.Width      = 786
345:         ENDWITH
346: 
347:         *-- BINDEVENT para todos os botoes (metodos devem ser PUBLIC)
348:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
349:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
350:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
351:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")

*-- Linhas 536 a 572:
536:         THIS.TornarControlesVisiveis(loc_oPagina)
537:     ENDPROC
538: 
539:     *--------------------------------------------------------------------------
540:     * CarregarLista - Busca dados e associa ao grid
541:     * Colunas cursor_4c_Dados: grupoos, grupods, cidchaves
542:     *--------------------------------------------------------------------------
543:     PROCEDURE CarregarLista()
544:         LOCAL loc_lResultado, loc_oGrid
545:         loc_lResultado = .F.
546: 
547:         TRY
548:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
549:                 loc_lResultado = .T.
550:             ELSE
551:                 IF THIS.this_oBusinessObject.Buscar("")
552:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
553: 
554:                     loc_oGrid.ColumnCount = 2
555:                     loc_oGrid.RecordSource             = "cursor_4c_Dados"
556:                     loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.grupoos"
557:                     loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.grupods"
558: 
559:                     *-- OBRIGATORIO: Redefinir cabecalhos apos RecordSource (VFP9 reseta)
560:                     loc_oGrid.Column1.Header1.Caption  = "Grupo Origem"
561:                     loc_oGrid.Column2.Header1.Caption  = "Grupo Destino"
562: 
563:                     THIS.FormatarGridLista(loc_oGrid)
564:                     loc_lResultado = .T.
565:                 ENDIF
566:             ENDIF
567:         CATCH TO loc_oErro
568:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormRss.CarregarLista")
569:         ENDTRY
570: 
571:         RETURN loc_lResultado
572:     ENDPROC

*-- Linhas 725 a 812:
725:     *--------------------------------------------------------------------------
726:     PROCEDURE BtnVisualizarClick()
727:         LOCAL loc_cChave
728:         loc_cChave = ""
729: 
730:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
731:             MsgAviso("Selecione um registro na lista.")
732:             RETURN
733:         ENDIF
734: 
735:         SELECT cursor_4c_Dados
736:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
737: 
738:         IF EMPTY(loc_cChave)
739:             MsgAviso("Selecione um registro na lista.")
740:             RETURN
741:         ENDIF
742: 
743:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
744:             THIS.this_cModoAtual = "VISUALIZAR"
745:             THIS.BOParaForm()
746:             THIS.HabilitarCampos(.F.)
747:             THIS.AjustarBotoesPorModo()
748:             THIS.AlternarPagina(2)
749:         ENDIF
750:     ENDPROC
751: 
752:     *--------------------------------------------------------------------------
753:     * BtnAlterarClick - Carrega registro selecionado para edicao
754:     * Grupo Origem nao pode ser alterado (faz parte da chave de negocio)
755:     *--------------------------------------------------------------------------
756:     PROCEDURE BtnAlterarClick()
757:         LOCAL loc_cChave
758:         loc_cChave = ""
759: 
760:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
761:             MsgAviso("Selecione um registro na lista.")
762:             RETURN
763:         ENDIF
764: 
765:         SELECT cursor_4c_Dados
766:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
767: 
768:         IF EMPTY(loc_cChave)
769:             MsgAviso("Selecione um registro na lista.")
770:             RETURN
771:         ENDIF
772: 
773:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
774:             THIS.this_oBusinessObject.EditarRegistro()
775:             THIS.this_cModoAtual = "ALTERAR"
776:             THIS.BOParaForm()
777:             THIS.HabilitarCampos(.T.)
778:             THIS.AjustarBotoesPorModo()
779:             THIS.AlternarPagina(2)
780:         ENDIF
781:     ENDPROC
782: 
783:     *--------------------------------------------------------------------------
784:     * BtnExcluirClick - Confirma e exclui registro selecionado
785:     *--------------------------------------------------------------------------
786:     PROCEDURE BtnExcluirClick()
787:         LOCAL loc_cChave, loc_lConfirma
788:         loc_cChave   = ""
789:         loc_lConfirma = .F.
790: 
791:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
792:             MsgAviso("Selecione um registro na lista.")
793:             RETURN
794:         ENDIF
795: 
796:         SELECT cursor_4c_Dados
797:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
798: 
799:         IF EMPTY(loc_cChave)
800:             MsgAviso("Selecione um registro na lista.")
801:             RETURN
802:         ENDIF
803: 
804:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
805:             "Confirmar Exclus" + CHR(227) + "o")
806: 
807:         IF loc_lConfirma
808:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
809:                 IF THIS.this_oBusinessObject.Excluir()
810:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
811:                     THIS.this_cModoAtual = "LISTA"
812:                     THIS.CarregarLista()

*-- Linhas 970 a 988:
970:                 ENDIF
971: 
972:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrigem")
973:                     SELECT cursor_4c_BuscaOrigem
974:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaOrigem.Codigos)
975:                 ENDIF
976: 
977:                 loc_oBusca.Release()
978:             ENDIF
979:         CATCH TO loc_oErro
980:             MsgErro("Erro ao buscar Grupo Origem:" + CHR(13) + loc_oErro.Message, ;
981:                 "FormRss.AbrirBuscaOrigem")
982:         ENDTRY
983: 
984:         IF USED("cursor_4c_BuscaOrigem")
985:             USE IN cursor_4c_BuscaOrigem
986:         ENDIF
987: 
988:         IF !EMPTY(loc_cCodigo)

*-- Linhas 1073 a 1091:
1073:                 ENDIF
1074: 
1075:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDestino")
1076:                     SELECT cursor_4c_BuscaDestino
1077:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaDestino.Codigos)
1078:                 ENDIF
1079: 
1080:                 loc_oBusca.Release()
1081:             ENDIF
1082:         CATCH TO loc_oErro
1083:             MsgErro("Erro ao buscar Grupo Destino:" + CHR(13) + loc_oErro.Message, ;
1084:                 "FormRss.AbrirBuscaDestino")
1085:         ENDTRY
1086: 
1087:         IF USED("cursor_4c_BuscaDestino")
1088:             USE IN cursor_4c_BuscaDestino
1089:         ENDIF
1090: 
1091:         IF !EMPTY(loc_cCodigo)


### BO (C:\4c\projeto\app\classes\RssBO.prg):
*==============================================================================
* RssBO.prg - Business Object para Restricao de Setores (SigCdRps)
* Tabela principal: SigCdRps
* Chave primaria : cidchaves (char 20, gerada por fUniqueIds())
*==============================================================================

DEFINE CLASS RssBO AS BusinessBase

    *-- Propriedades mapeadas para colunas de SigCdRps
    this_cCidChaves = ""        && cidchaves char(20) - PK
    this_cGrupoos   = ""        && grupoos   char(10) - Grupo Origem (FK SigCdGcr.codigos)
    this_cGrupods   = ""        && grupods   char(10) - Grupo Destino (FK SigCdGcr.codigos)
    this_cUsuars    = ""        && usuars    char(10) - usuario
    this_dDatars    = {}        && datars    datetime - data/hora do registro

    *-- Propriedades auxiliares para exibicao (lookup SigCdGcr.descrs)
    this_cDescOrigem  = ""      && descricao do Grupo Origem
    this_cDescDestino = ""      && descricao do Grupo Destino

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRps"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * LimparDados - Limpa todas as propriedades da entidade
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves    = ""
        THIS.this_cGrupoos      = ""
        THIS.this_cGrupods      = ""
        THIS.this_cUsuars       = ""
        THIS.this_dDatars       = {}
        THIS.this_cDescOrigem   = ""
        THIS.this_cDescDestino  = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves   = TratarNulo(cidchaves, "C")
                THIS.this_cGrupoos     = TratarNulo(grupoos,   "C")
                THIS.this_cGrupods     = TratarNulo(grupods,   "C")
                THIS.this_cUsuars      = TratarNulo(usuars,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RssBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cGrupoos))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo Origem.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cGrupods))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo Destino.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDuplicidade()
                MsgAviso("Grupo Origem , Grupo Destino j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se par (grupoos + grupods) ja existe
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdRps" + ;
                " WHERE grupoos = " + EscaparSQL(THIS.this_cGrupoos) + ;
                " AND   grupods = " + EscaparSQL(THIS.this_cGrupods)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                SELECT cursor_4c_ChkDup
                loc_lDuplicado = !EOF("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "RssBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult
        loc_cChave = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CAST(NEWID() AS varchar(36)) AS nova_chave", ;
                "cursor_4c_NovaChave")
            IF loc_nResult >= 0 AND USED("cursor_4c_NovaChave")
                SELECT cursor_4c_NovaChave
                loc_cChave = LEFT(ALLTRIM(cursor_4c_NovaChave.nova_chave), 20)
                USE IN cursor_4c_NovaChave
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "RssBO.GerarChaveUnica")
        ENDTRY

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdRps
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarChaveUnica()
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar chave para o registro.", "RssBO.Inserir")
            ELSE
                loc_cSQL = "INSERT INTO SigCdRps" + ;
                    " (cidchaves, grupoos, grupods, datars, usuars)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                    EscaparSQL(THIS.this_cGrupoos)   + ", " + ;
                    EscaparSQL(THIS.this_cGrupods)   + ", " + ;
                    "GETDATE(), " + ;
                    EscaparSQL(gc_4c_UsuarioLogado)  + ;
                    ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir restri" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "RssBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdRps
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdRps SET" + ;
                " grupoos = " + EscaparSQL(THIS.this_cGrupoos)   + ", " + ;
                " grupods = " + EscaparSQL(THIS.this_cGrupods)   + ", " + ;
                " datars  = GETDATE(), " + ;
                " usuars  = " + EscaparSQL(gc_4c_UsuarioLogado)  + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "RssBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdRps
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRps WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "RssBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca todos os registros para o grid da lista
    * Colunas do grid: grupoos (Grupo Origem), grupods (Grupo Destino)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        grupoos   C(10), ;
                        grupods   C(10), ;
                        cidchaves C(20)  ;
                    )
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupoos, grupods, cidchaves" + ;
                    " FROM SigCdRps"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY grupoos, grupods"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar restri" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "RssBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, grupoos, grupods, usuars, datars" + ;
                " FROM SigCdRps WHERE cidchaves = " + EscaparSQL(par_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                SELECT cursor_4c_Carrega
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar por chave:" + CHR(13) + loc_oErro.Message, "RssBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarDescricaoGrupo - Busca descricao de um grupo em SigCdGcr
    * Retorna a descricao ou string vazia se nao encontrado
    *==========================================================================
    PROCEDURE BuscarDescricaoGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescrs
        loc_cDescrs = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                    EscaparSQL(par_cCodigo)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr")
                IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    IF !EOF("cursor_4c_BuscaGcr")
                        loc_cDescrs = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
                    ENDIF
                    USE IN cursor_4c_BuscaGcr
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do grupo:" + ;
                CHR(13) + loc_oErro.Message, "RssBO.BuscarDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescrs
    ENDPROC

ENDDEFINE

