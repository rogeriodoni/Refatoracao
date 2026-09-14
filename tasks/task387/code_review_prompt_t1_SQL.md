# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRICAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CMOES, CONST1T2S, CONST2T1S, CONST2T2S, CONST3T1S, CONST3T2S, CODIGOS

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
  ControlSource = "crSigCdCnt.Codigos"
  ControlSource = "crSigCdCnt.Descricaos"
  ControlSource = "crSigCdCnt.Consts"
  ControlSource = "crSigCdCnt.Moedas"
Thisform.podatamgr.sqlexecute("Select a.dmoes from SigCdMoe a where a.cmoes = '"+CrSigCdCnt.moedas+"'","SigCdMoe") 
	lcQuery = [Select Codigos ] + ;
				[From SigOpTdt ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCst.prg) - TRECHOS RELEVANTES PARA PASS SQL (1126 linhas total):

*-- Linhas 332 a 350:
332:                 .HighlightBackColor = RGB(255, 255, 255)
333:                 .HighlightForeColor = RGB(15, 41, 104)
334:                 .HighlightStyle     = 2
335:                 .DeleteMark         = .F.
336:                 .RecordMark         = .F.
337:                 .RowHeight          = 16
338:                 .ScrollBars         = 2
339:                 .Visible            = .T.
340:             ENDWITH
341: 
342:             *-- BINDEVENT para botoes CRUD (metodos PUBLIC obrigatorios)
343:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
344:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
345:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
346:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
347:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
348:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
349: 
350:             THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 610 a 645:
610:                     *-- RecordSource FORA do WITH (regra critica #36/#48)
611:                     loc_oGrid.RecordSource = "crSigCdCnt"
612: 
613:                     *-- ControlSource e Headers APOS RecordSource (regra #32)
614:                     WITH loc_oGrid
615:                         .Column1.ControlSource   = "crSigCdCnt.codigos"
616:                         .Column1.Width           = 60
617:                         .Column1.Header1.Caption = "C" + CHR(243) + "digo"
618:                         .Column1.Alignment       = 0
619: 
620:                         .Column2.ControlSource   = "crSigCdCnt.descricaos"
621:                         .Column2.Width           = 267
622:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
623:                         .Column2.Alignment       = 0
624: 
625:                         .Column3.ControlSource   = "crSigCdCnt.consts"
626:                         .Column3.Width           = 177
627:                         .Column3.Header1.Caption = "Valor"
628:                         .Column3.Alignment       = 1
629: 
630:                         .Column4.ControlSource   = "crSigCdCnt.moedas"
631:                         .Column4.Width           = 42
632:                         .Column4.Header1.Caption = "Moeda"
633:                         .Column4.Alignment       = 0
634:                     ENDWITH
635: 
636:                     THIS.FormatarGridLista(loc_oGrid)
637:                     loc_oGrid.Refresh()
638:                     loc_lResultado = .T.
639:                 ENDIF
640:             ENDIF
641:         CATCH TO loc_oErro
642:             MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
643:                 loc_oErro.Message + CHR(13) + ;
644:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
645:                 "FormCst.CarregarLista")

*-- Linhas 779 a 797:
779: 
780:     *===========================================================================
781:     * HabilitarCampos - Habilita/desabilita campos conforme modo atual
782:     * Codigo: habilitado SOMENTE no INCLUIR (PK nao editavel em UPDATE)
783:     * DescMoeda: habilitada apenas quando CodMoeda esta vazio (busca por descricao)
784:     *===========================================================================
785:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
786:         LOCAL loc_oPagina, loc_lCodEnabled
787:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
788: 
789:         loc_lCodEnabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
790: 
791:         loc_oPagina.txt_4c_Codigo.Enabled    = loc_lCodEnabled
792:         loc_oPagina.txt_4c_Descricao.Enabled = par_lHabilitar
793:         loc_oPagina.txt_4c_Constante.Enabled = par_lHabilitar
794:         loc_oPagina.txt_4c_CodMoeda.Enabled  = par_lHabilitar
795:         loc_oPagina.txt_4c_DescMoeda.Enabled = par_lHabilitar AND ;
796:             EMPTY(ALLTRIM(loc_oPagina.txt_4c_CodMoeda.Value))
797:     ENDPROC

*-- Linhas 837 a 855:
837:             RETURN
838:         ENDIF
839: 
840:         SELECT crSigCdCnt
841:         loc_cCodigo = ALLTRIM(crSigCdCnt.codigos)
842: 
843:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
844:             THIS.this_cModoAtual = "VISUALIZAR"
845:             THIS.BOParaForm()
846:             THIS.HabilitarCampos(.F.)
847:             THIS.AjustarBotoesPorModo()
848:             THIS.AlternarPagina(2)
849:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
850:         ENDIF
851:     ENDPROC
852: 
853:     *===========================================================================
854:     * BtnAlterarClick - Abre registro selecionado para edicao
855:     *===========================================================================

*-- Linhas 861 a 879:
861:             RETURN
862:         ENDIF
863: 
864:         SELECT crSigCdCnt
865:         loc_cCodigo = ALLTRIM(crSigCdCnt.codigos)
866: 
867:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
868:             THIS.this_oBusinessObject.EditarRegistro()
869:             THIS.this_cModoAtual = "ALTERAR"
870:             THIS.BOParaForm()
871:             THIS.HabilitarCampos(.T.)
872:             THIS.AjustarBotoesPorModo()
873:             THIS.AlternarPagina(2)
874:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
875:         ENDIF
876:     ENDPROC
877: 
878:     *===========================================================================
879:     * BtnExcluirClick - Exclui o registro selecionado apos confirmacao

*-- Linhas 886 a 904:
886:             RETURN
887:         ENDIF
888: 
889:         SELECT crSigCdCnt
890:         loc_cCodigo = ALLTRIM(crSigCdCnt.codigos)
891: 
892:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
893:             RETURN
894:         ENDIF
895: 
896:         loc_lConfirma = MsgConfirma("Deseja excluir a constante [" + loc_cCodigo + ;
897:             "] - " + ALLTRIM(THIS.this_oBusinessObject.this_cDescricao) + "?", ;
898:             "Confirmar Exclus" + CHR(227) + "o")
899: 
900:         IF loc_lConfirma
901:             loc_lExcluido = THIS.this_oBusinessObject.Excluir()
902:             IF loc_lExcluido
903:                 THIS.CarregarLista()
904:             ENDIF

*-- Linhas 920 a 955:
920:         IF EMPTY(loc_cBusca)
921:             loc_lResultado = THIS.this_oBusinessObject.Buscar("")
922:         ELSE
923:             loc_cFiltro = "(a.codigos LIKE " + EscaparSQL("%" + loc_cBusca + "%") + ;
924:                 " OR a.descricaos LIKE " + EscaparSQL("%" + loc_cBusca + "%") + ")"
925:             loc_lResultado = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
926:         ENDIF
927: 
928:         IF loc_lResultado
929:             loc_oGrid.RecordSource = "crSigCdCnt"
930:             WITH loc_oGrid
931:                 .Column1.ControlSource   = "crSigCdCnt.codigos"
932:                 .Column1.Width           = 60
933:                 .Column1.Header1.Caption = "C" + CHR(243) + "digo"
934:                 .Column2.ControlSource   = "crSigCdCnt.descricaos"
935:                 .Column2.Width           = 267
936:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
937:                 .Column3.ControlSource   = "crSigCdCnt.consts"
938:                 .Column3.Width           = 177
939:                 .Column3.Header1.Caption = "Valor"
940:                 .Column4.ControlSource   = "crSigCdCnt.moedas"
941:                 .Column4.Width           = 42
942:                 .Column4.Header1.Caption = "Moeda"
943:             ENDWITH
944:             THIS.FormatarGridLista(loc_oGrid)
945:             loc_oGrid.Refresh()
946:         ENDIF
947:     ENDPROC
948: 
949:     *===========================================================================
950:     * BtnEncerrarClick - Fecha o formulario
951:     *===========================================================================
952:     PROCEDURE BtnEncerrarClick()
953:         THIS.Release()
954:     ENDPROC
955: 

*-- Linhas 1049 a 1067:
1049:                 ENDIF
1050: 
1051:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1052:                     SELECT cursor_4c_BuscaMoe
1053:                     loc_oPagina.txt_4c_CodMoeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
1054:                     loc_oPagina.txt_4c_DescMoeda.Value   = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
1055:                     loc_oPagina.txt_4c_DescMoeda.Enabled = .F.
1056:                     loc_lResultado = .T.
1057:                 ELSE
1058:                     loc_oPagina.txt_4c_CodMoeda.Value    = ""
1059:                     loc_oPagina.txt_4c_DescMoeda.Value   = ""
1060:                     loc_oPagina.txt_4c_DescMoeda.Enabled = .T.
1061:                 ENDIF
1062: 
1063:                 loc_oBusca.Release()
1064:             ENDIF
1065:         CATCH TO loc_oErro
1066:             MostrarErro("Erro ao buscar moeda:" + CHR(13) + ;
1067:                 loc_oErro.Message, "FormCst.AbrirLookupMoedaCodigo")

*-- Linhas 1099 a 1117:
1099:                 ENDIF
1100: 
1101:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeDesc")
1102:                     SELECT cursor_4c_BuscaMoeDesc
1103:                     loc_oPagina.txt_4c_CodMoeda.Value    = ALLTRIM(cursor_4c_BuscaMoeDesc.cmoes)
1104:                     loc_oPagina.txt_4c_DescMoeda.Value   = ALLTRIM(cursor_4c_BuscaMoeDesc.dmoes)
1105:                     loc_oPagina.txt_4c_DescMoeda.Enabled = .F.
1106:                     loc_lResultado = .T.
1107:                 ELSE
1108:                     loc_oPagina.txt_4c_CodMoeda.Value  = ""
1109:                     loc_oPagina.txt_4c_DescMoeda.Value = ""
1110:                 ENDIF
1111: 
1112:                 loc_oBusca.Release()
1113:             ENDIF
1114:         CATCH TO loc_oErro
1115:             MostrarErro("Erro ao buscar moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1116:                 loc_oErro.Message, "FormCst.AbrirLookupMoedaDescricao")
1117:         ENDTRY


### BO (C:\4c\projeto\app\classes\CstBO.prg):
*==============================================================================
* CstBO.prg - Business Object para Constantes
* Tabela: SigCdCnt
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS CstBO AS BusinessBase

    *-- Propriedades da tabela SigCdCnt
    this_cCodigo    = ""    && Codigos     C(3)  - PK
    this_cDescricao = ""    && Descricaos  C(40)
    this_nConstante = 0     && Consts      N(13,6) - Valor da Constante
    this_cMoeda     = ""    && Moedas      C(3)  - FK SigCdMoe.Cmoes

    *-- Propriedade auxiliar de exibicao (nao persistida em SigCdCnt)
    this_cDescMoeda = ""    && SigCdMoe.Dmoes C(15) - Descricao da Moeda

    *--------------------------------------------------------------------------
    * Init - Inicializa BO configurando tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCnt"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "CstBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = TratarNulo(codigos,    "C")
                THIS.this_cDescricao = TratarNulo(descricaos, "C")
                THIS.this_nConstante = TratarNulo(consts,     "N")
                THIS.this_cMoeda     = TratarNulo(moedas,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CstBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo da Constante j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cMoeda)
            MsgAviso("Moeda n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se codigos ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nTotal FROM SigCdCnt" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (NVL(cursor_4c_ChkCod.nTotal, 0) > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CstBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCnt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCnt (codigos, descricaos, consts, moedas)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<FormatarNumeroSQL(THIS.this_nConstante, 6)>>,
                    <<EscaparSQL(THIS.this_cMoeda)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CstBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCnt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCnt
                SET descricaos = <<EscaparSQL(THIS.this_cDescricao)>>,
                    consts     = <<FormatarNumeroSQL(THIS.this_nConstante, 6)>>,
                    moedas     = <<EscaparSQL(THIS.this_cMoeda)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CstBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCnt
    * Valida uso em SigOpTdt (6 campos de constante) antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar se constante esta sendo usada em operacoes (SigOpTdt)
            loc_cSQL = "SELECT COUNT(*) AS nTotal FROM SigOpTdt" + ;
                " WHERE (const1t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const1t2s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const2t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const2t2s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const3t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const3t2s = " + EscaparSQL(THIS.this_cCodigo) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCnt")

            IF loc_nResultado < 0
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkCnt")
                    SELECT cursor_4c_ChkCnt
                    loc_nUso = NVL(cursor_4c_ChkCnt.nTotal, 0)
                    USE IN cursor_4c_ChkCnt
                ENDIF

                IF loc_nUso > 0
                    MsgAviso("Constante sendo utilizada em Opera" + CHR(231) + CHR(245) + "es!")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdCnt WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CstBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor crSigCdCnt com codigos, descricaos, consts, moedas
    * (cursor nomeado igual ao legado para compatibilidade com grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("crSigCdCnt")
                    SET NULL ON
                    CREATE CURSOR crSigCdCnt (codigos C(3), descricaos C(40), consts N(13,6), moedas C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descricaos, a.consts, a.moedas" + ;
                    " FROM SigCdCnt a"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

                IF USED("crSigCdCnt")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT crSigCdCnt
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar constantes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCnt")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar constantes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CstBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    * Tambem carrega descricao da moeda via JOIN com SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descricaos, a.consts, a.moedas," + ;
                " b.dmoes AS descmoes" + ;
                " FROM SigCdCnt a" + ;
                " LEFT JOIN SigCdMoe b ON b.cmoes = a.moedas" + ;
                " WHERE a.codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    SELECT cursor_4c_Carrega
                    THIS.this_cCodigo    = TratarNulo(codigos,    "C")
                    THIS.this_cDescricao = TratarNulo(descricaos, "C")
                    THIS.this_nConstante = TratarNulo(consts,     "N")
                    THIS.this_cMoeda     = TratarNulo(moedas,     "C")
                    THIS.this_cDescMoeda = TratarNulo(descmoes,   "C")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Constante n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CstBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescMoeda - Carrega descricao da moeda pelo codigo
    * Usado apos lookup de moeda para atualizar campo de exibicao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescMoeda(par_cCodigoMoeda)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cCodigoMoeda)
                THIS.this_cDescMoeda = ""
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.dmoes FROM SigCdMoe a" + ;
                    " WHERE a.cmoes = " + EscaparSQL(par_cCodigoMoeda)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moe")

                IF loc_nResultado >= 0
                    IF RECCOUNT("cursor_4c_Moe") > 0
                        SELECT cursor_4c_Moe
                        THIS.this_cDescMoeda = TratarNulo(dmoes, "C")
                    ELSE
                        THIS.this_cDescMoeda = ""
                    ENDIF

                    IF USED("cursor_4c_Moe")
                        USE IN cursor_4c_Moe
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao carregar moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o da moeda:" + CHR(13) + loException.Message, "CstBO.CarregarDescMoeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

