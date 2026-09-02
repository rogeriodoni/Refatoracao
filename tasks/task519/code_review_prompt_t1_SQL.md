# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS

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
  ControlSource = "crSigCdSct.codigos"
  ControlSource = "crSigCdSct.descs"
  ControlSource = "crSigCdSct.impops"
select CrSigCdSct

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSEG.prg) - TRECHOS RELEVANTES PARA PASS SQL (986 linhas total):

*-- Linhas 347 a 365:
347:             .HighlightBackColor = RGB(255, 255, 255)
348:             .HighlightForeColor = RGB(15, 41, 104)
349:             .HighlightStyle     = 2
350:             .DeleteMark         = .F.
351:             .RecordMark         = .F.
352:             .RowHeight          = 16
353:             .ScrollBars         = 2
354:             .GridLines          = 3
355:             .ReadOnly           = .T.
356:             .Visible            = .T.
357:         ENDWITH
358: 
359:         THIS.TornarControlesVisiveis(loc_oPagina)
360:     ENDPROC
361: 
362:     *===========================================================================
363:     * ConfigurarPaginaDados - Configura Page2 com botoes e campos (Fase 5)
364:     * Campos: codigos (PK), descs, impops (OptionGroup Sim/Nao)
365:     * Posicoes: original + 29 (compensacao PageFrame.Top=-29)

*-- Linhas 623 a 642:
623: 
624:                     loc_oGrid.ColumnCount = 2
625:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
626:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
627:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
628: 
629:                     loc_oGrid.Column1.Width = 80
630:                     loc_oGrid.Column2.Width = 160
631: 
632:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
633:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
634: 
635:                     THIS.FormatarGridLista(loc_oGrid)
636:                     loc_lSucesso = .T.
637:                 ENDIF
638:             ENDIF
639:         CATCH TO loException
640:             MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
641:             loc_lSucesso = .F.
642:         ENDTRY

*-- Linhas 772 a 790:
772:             RETURN
773:         ENDIF
774: 
775:         SELECT cursor_4c_Dados
776:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
777: 
778:         TRY
779:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
780:                 THIS.this_oBusinessObject.EditarRegistro()
781:                 THIS.this_cModoAtual = "ALTERAR"
782:                 THIS.BOParaForm()
783:                 THIS.HabilitarCampos(.T.)
784:                 THIS.AlternarPagina(2)
785:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
786:                 loc_lSucesso = .T.
787:             ELSE
788:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro.", "Alterar")
789:             ENDIF
790:         CATCH TO loException

*-- Linhas 803 a 821:
803:             RETURN
804:         ENDIF
805: 
806:         SELECT cursor_4c_Dados
807:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
808: 
809:         TRY
810:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
811:                 THIS.this_cModoAtual = "VISUALIZAR"
812:                 THIS.BOParaForm()
813:                 THIS.HabilitarCampos(.F.)
814:                 THIS.AlternarPagina(2)
815:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
816:             ELSE
817:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro.", "Visualizar")
818:             ENDIF
819:         CATCH TO loException
820:             MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Erro")
821:         ENDTRY

*-- Linhas 832 a 850:
832:             RETURN
833:         ENDIF
834: 
835:         SELECT cursor_4c_Dados
836:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
837: 
838:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do segmento '" + loc_cCodigo + "'?", "Excluir")
839:             RETURN
840:         ENDIF
841: 
842:         TRY
843:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
844:                 THIS.this_cModoAtual = "EXCLUIR"
845:                 THIS.BOParaForm()
846:                 THIS.HabilitarCampos(.F.)
847:                 THIS.AlternarPagina(2)
848:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
849:             ELSE
850:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro.", "Excluir")

*-- Linhas 867 a 921:
867:         ENDIF
868: 
869:         TRY
870:             loc_cSQL = "SELECT codigos, descs, impops" + ;
871:                        " FROM SigCdSct" + ;
872:                        " WHERE codigos LIKE " + EscaparSQL(ALLTRIM(loc_cFiltro) + "%") + ;
873:                        "    OR descs   LIKE " + EscaparSQL("%" + ALLTRIM(loc_cFiltro) + "%") + ;
874:                        " ORDER BY codigos"
875: 
876:             IF USED("cursor_4c_Dados")
877:                 USE IN cursor_4c_Dados
878:             ENDIF
879: 
880:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
881: 
882:             IF loc_nResultado >= 0
883:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
884: 
885:                 loc_oGrid.ColumnCount = 2
886:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
887:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
888:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
889: 
890:                 loc_oGrid.Column1.Width = 80
891:                 loc_oGrid.Column2.Width = 160
892: 
893:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
894:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
895: 
896:                 THIS.FormatarGridLista(loc_oGrid)
897:             ELSE
898:                 MsgErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
899:             ENDIF
900:         CATCH TO loException
901:             MsgErro("Erro ao buscar:" + CHR(13) + loException.Message, "Erro")
902:         ENDTRY
903:     ENDPROC
904: 
905:     *===========================================================================
906:     * BtnSalvarClick - Salva (INSERT/UPDATE/DELETE) conforme modo atual
907:     * Validacoes do original:
908:     *   INSERIR: codigo nao pode ficar em branco
909:     *   INSERIR: codigo nao pode ja estar cadastrado
910:     *===========================================================================
911:     PROCEDURE BtnSalvarClick()
912:         LOCAL loc_lSucesso, loc_oPagina, loc_cCodigo
913:         loc_lSucesso = .F.
914:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
915: 
916:         IF THIS.this_cModoAtual = "VISUALIZAR"
917:             THIS.AlternarPagina(1)
918:             RETURN
919:         ENDIF
920: 
921:         IF THIS.this_cModoAtual = "EXCLUIR"

*-- Linhas 943 a 965:
943: 
944:         IF THIS.this_cModoAtual = "INCLUIR"
945:             LOCAL loc_cSQLChk, loc_nChk
946:             loc_cSQLChk = "SELECT COUNT(*) AS qtd FROM SigCdSct" + ;
947:                           " WHERE codigos = " + EscaparSQL(loc_cCodigo)
948:             loc_nChk = SQLEXEC(gnConnHandle, loc_cSQLChk, "cursor_4c_Chk")
949:             IF loc_nChk >= 0 AND RECCOUNT("cursor_4c_Chk") > 0
950:                 SELECT cursor_4c_Chk
951:                 IF cursor_4c_Chk.qtd > 0
952:                     USE IN cursor_4c_Chk
953:                     MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!", "")
954:                     loc_oPagina.txt_4c_Codigo.SetFocus
955:                     RETURN
956:                 ENDIF
957:             ENDIF
958:             IF USED("cursor_4c_Chk")
959:                 USE IN cursor_4c_Chk
960:             ENDIF
961:         ENDIF
962: 
963:         TRY
964:             THIS.FormParaBO()
965:             IF THIS.this_oBusinessObject.Salvar()


### BO (C:\4c\projeto\app\classes\SEGBO.prg):
*******************************************************************************
* SEGBO.prg - Business Object para Segmentos de Contas
* Tabela   : SigCdSct
* PK       : codigos
* Herda de : BusinessBase
*******************************************************************************

DEFINE CLASS SEGBO AS BusinessBase

    *-- Propriedades da entidade (mapeadas para SigCdSct)
    this_cCodigo    = ""    && codigos    char(10)    PK
    this_cDescricao = ""    && descs      char(30)
    this_nImpops    = 0     && impops     numeric(1,0) - 1=Sim / 2=Nao

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave do BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdSct"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(codigos, "C")
            THIS.this_cDescricao = TratarNulo(descs,   "C")
            THIS.this_nImpops    = TratarNulo(impops,  "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista para o grid (cursor_4c_Dados)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, impops" + ;
                       " FROM SigCdSct" + ;
                       " ORDER BY codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar segmentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo PK
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, impops" + ;
                       " FROM SigCdSct" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdSct (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdSct (codigos, descs, impops)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImpops) + ;
                       ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir segmento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdSct (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdSct SET" + ;
                       " descs = "   + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + "," + ;
                       " impops = "  + FormatarNumeroSQL(THIS.this_nImpops) + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar segmento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdSct (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdSct" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir segmento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

