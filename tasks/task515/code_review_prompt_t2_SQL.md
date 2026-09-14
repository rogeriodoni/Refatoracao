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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRss.prg) - TRECHOS RELEVANTES PARA PASS SQL (1118 linhas total):

*-- Linhas 336 a 354:
336:             .HighlightBackColor = RGB(255, 255, 255)
337:             .HighlightForeColor = RGB(15, 41, 104)
338:             .HighlightStyle     = 2
339:             .DeleteMark         = .F.
340:             .RecordMark         = .F.
341:             .RowHeight          = 16
342:             .ScrollBars         = 2
343:             .GridLines          = 3
344:             .ReadOnly           = .T.
345:             .Visible            = .T.
346:             .Column1.Width      = 100
347:             .Column2.Width      = 786
348:         ENDWITH
349: 
350:         *-- BINDEVENT para todos os botoes (metodos devem ser PUBLIC)
351:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
352:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
353:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
354:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")

*-- Linhas 539 a 575:
539:         THIS.TornarControlesVisiveis(loc_oPagina)
540:     ENDPROC
541: 
542:     *--------------------------------------------------------------------------
543:     * CarregarLista - Busca dados e associa ao grid
544:     * Colunas cursor_4c_Dados: grupoos, grupods, cidchaves
545:     *--------------------------------------------------------------------------
546:     PROCEDURE CarregarLista()
547:         LOCAL loc_lResultado, loc_oGrid
548:         loc_lResultado = .F.
549: 
550:         TRY
551:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
552:                 loc_lResultado = .T.
553:             ELSE
554:                 IF THIS.this_oBusinessObject.Buscar("")
555:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
556: 
557:                     loc_oGrid.ColumnCount = 2
558:                     loc_oGrid.RecordSource             = "cursor_4c_Dados"
559:                     loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.grupoos"
560:                     loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.grupods"
561: 
562:                     *-- OBRIGATORIO: Redefinir cabecalhos apos RecordSource (VFP9 reseta)
563:                     loc_oGrid.Column1.Header1.Caption  = "Grupo Origem"
564:                     loc_oGrid.Column2.Header1.Caption  = "Grupo Destino"
565: 
566:                     THIS.FormatarGridLista(loc_oGrid)
567:                     loc_lResultado = .T.
568:                 ENDIF
569:             ENDIF
570:         CATCH TO loc_oErro
571:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormRss.CarregarLista")
572:         ENDTRY
573: 
574:         RETURN loc_lResultado
575:     ENDPROC

*-- Linhas 728 a 815:
728:     *--------------------------------------------------------------------------
729:     PROCEDURE BtnVisualizarClick()
730:         LOCAL loc_cChave
731:         loc_cChave = ""
732: 
733:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
734:             MsgAviso("Selecione um registro na lista.")
735:             RETURN
736:         ENDIF
737: 
738:         SELECT cursor_4c_Dados
739:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
740: 
741:         IF EMPTY(loc_cChave)
742:             MsgAviso("Selecione um registro na lista.")
743:             RETURN
744:         ENDIF
745: 
746:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
747:             THIS.this_cModoAtual = "VISUALIZAR"
748:             THIS.BOParaForm()
749:             THIS.HabilitarCampos(.F.)
750:             THIS.AjustarBotoesPorModo()
751:             THIS.AlternarPagina(2)
752:         ENDIF
753:     ENDPROC
754: 
755:     *--------------------------------------------------------------------------
756:     * BtnAlterarClick - Carrega registro selecionado para edicao
757:     * Grupo Origem nao pode ser alterado (faz parte da chave de negocio)
758:     *--------------------------------------------------------------------------
759:     PROCEDURE BtnAlterarClick()
760:         LOCAL loc_cChave
761:         loc_cChave = ""
762: 
763:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
764:             MsgAviso("Selecione um registro na lista.")
765:             RETURN
766:         ENDIF
767: 
768:         SELECT cursor_4c_Dados
769:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
770: 
771:         IF EMPTY(loc_cChave)
772:             MsgAviso("Selecione um registro na lista.")
773:             RETURN
774:         ENDIF
775: 
776:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
777:             THIS.this_oBusinessObject.EditarRegistro()
778:             THIS.this_cModoAtual = "ALTERAR"
779:             THIS.BOParaForm()
780:             THIS.HabilitarCampos(.T.)
781:             THIS.AjustarBotoesPorModo()
782:             THIS.AlternarPagina(2)
783:         ENDIF
784:     ENDPROC
785: 
786:     *--------------------------------------------------------------------------
787:     * BtnExcluirClick - Confirma e exclui registro selecionado
788:     *--------------------------------------------------------------------------
789:     PROCEDURE BtnExcluirClick()
790:         LOCAL loc_cChave, loc_lConfirma
791:         loc_cChave   = ""
792:         loc_lConfirma = .F.
793: 
794:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
795:             MsgAviso("Selecione um registro na lista.")
796:             RETURN
797:         ENDIF
798: 
799:         SELECT cursor_4c_Dados
800:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
801: 
802:         IF EMPTY(loc_cChave)
803:             MsgAviso("Selecione um registro na lista.")
804:             RETURN
805:         ENDIF
806: 
807:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
808:             "Confirmar Exclus" + CHR(227) + "o")
809: 
810:         IF loc_lConfirma
811:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
812:                 IF THIS.this_oBusinessObject.Excluir()
813:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
814:                     THIS.this_cModoAtual = "LISTA"
815:                     THIS.CarregarLista()

*-- Linhas 973 a 991:
973:                 ENDIF
974: 
975:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrigem")
976:                     SELECT cursor_4c_BuscaOrigem
977:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaOrigem.Codigos)
978:                 ENDIF
979: 
980:                 loc_oBusca.Release()
981:             ENDIF
982:         CATCH TO loc_oErro
983:             MsgErro("Erro ao buscar Grupo Origem:" + CHR(13) + loc_oErro.Message, ;
984:                 "FormRss.AbrirBuscaOrigem")
985:         ENDTRY
986: 
987:         IF USED("cursor_4c_BuscaOrigem")
988:             USE IN cursor_4c_BuscaOrigem
989:         ENDIF
990: 
991:         IF !EMPTY(loc_cCodigo)

*-- Linhas 1076 a 1094:
1076:                 ENDIF
1077: 
1078:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDestino")
1079:                     SELECT cursor_4c_BuscaDestino
1080:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaDestino.Codigos)
1081:                 ENDIF
1082: 
1083:                 loc_oBusca.Release()
1084:             ENDIF
1085:         CATCH TO loc_oErro
1086:             MsgErro("Erro ao buscar Grupo Destino:" + CHR(13) + loc_oErro.Message, ;
1087:                 "FormRss.AbrirBuscaDestino")
1088:         ENDTRY
1089: 
1090:         IF USED("cursor_4c_BuscaDestino")
1091:             USE IN cursor_4c_BuscaDestino
1092:         ENDIF
1093: 
1094:         IF !EMPTY(loc_cCodigo)


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

