# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, DOPES, TABDS, TOTA

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
  DeleteMark = .F.
  Column1.ControlSource = ""
lcSql = [Select a.*,b.Descrs From SigOpTdo a, SigOpTdz b Where a.Dopes = ']+CrSigCdOpe.Dopes+[' And a.Tabds = b.Codigos ]
ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalTabdO')
Select LocalTabdO
	.Column1.ControlSource = 'LocalTabdO.Tabds'
	.Column2.ControlSource = 'LocalTabdO.Descrs'
Select LocalTabdO
Select LocalTabdO
	Insert Into LocalTabdO (Dopes, CidChaves) Values (crSigCdOpe.Dopes,fUniqueIds())
Select LocalTabdO
		Select LocalTabdO
		Select Tabds,sum(1) as TT From LocalTabdO GROUP by 1 Into cursor Totais
		Select Totais
		Select CrSigOpTdo
		Select LocalTabdO
			Insert Into CrSigOpTdo (Dopes,Tabds,CidChaves) Values ;
				lcDelete = [Delete From SigOpTdo Where Dopes = ']+CrSigCdOpe.Dopes+[']
				m.lnErro1 = Iif(.poDataMgr.SqlExecute(lcDelete,'')>0,1,-1)
				m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpTdo'),1,-1)
Select LocalTabdO
	Delete

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormTbO.prg) - TRECHOS RELEVANTES PARA PASS SQL (1262 linhas total):

*-- Linhas 360 a 378:
360:             .HighlightBackColor      = RGB(255, 255, 255)
361:             .HighlightForeColor      = RGB(15, 41, 104)
362:             .HighlightStyle          = 2
363:             .DeleteMark              = .F.
364:             .RecordMark              = .F.
365:             .RowHeight               = 16
366:             .ScrollBars              = 2
367:             .GridLines               = 3
368:             .ReadOnly                = .T.
369:             .Visible                 = .T.
370:             .Column1.Width           = 150
371:             .Column2.Width           = 150
372:             .Column3.Width           = 588
373:             .Column1.ReadOnly        = .T.
374:             .Column2.ReadOnly        = .T.
375:             .Column3.ReadOnly        = .T.
376:             .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
377:             .Column2.Header1.Caption = "Tab.Desconto"
378:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

*-- Linhas 402 a 422:
402:                     loc_oGrid.RecordSource = ""
403:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
404: 
405:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dopes"
406:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.tabds"
407:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
408: 
409:                     *-- RecordSource reseta Width/Header/ReadOnly - reconfigurar SEMPRE
410:                     loc_oGrid.Column1.Width           = 150
411:                     loc_oGrid.Column2.Width           = 150
412:                     loc_oGrid.Column3.Width           = 588
413:                     loc_oGrid.Column1.ReadOnly        = .T.
414:                     loc_oGrid.Column2.ReadOnly        = .T.
415:                     loc_oGrid.Column3.ReadOnly        = .T.
416:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
417:                     loc_oGrid.Column2.Header1.Caption = "Tab.Desconto"
418:                     loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
419: 
420:                     THIS.FormatarGridLista(loc_oGrid)
421: 
422:                     loc_oGrid.Refresh()

*-- Linhas 466 a 484:
466:     * ConfigurarPaginaDados - Configura Page2 (Dados)
467:     * Campos completos: txt_4c_Dopes (Operacao, read-only), txt_4c_Tabds
468:     * (Tabela de Desconto, editavel, com lookup F4/DblClick completo em
469:     * SigOpTdz) e txt_4c_Descrs (Descricao, read-only, derivado do JOIN).
470:     * Container cnt_4c_BotoesAcao com botoes Confirmar/Cancelar (BINDEVENT para
471:     * BtnSalvarClick/BtnCancelarClick, cuja logica e implementada na fase de
472:     * Eventos - mesmo padrao usado nos botoes CRUD de ConfigurarPaginaLista).
473:     *--------------------------------------------------------------------------
474:     PROTECTED PROCEDURE ConfigurarPaginaDados()
475:         LOCAL loc_oPagina
476:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
477: 
478:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
479:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
480: 
481:         *-- Cabecalho cinza (identico ao da pagina Lista)
482:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
483:         WITH loc_oPagina.cnt_4c_Cabecalho
484:             .Top           = 29

*-- Linhas 678 a 696:
678: 
679:         *----------------------------------------------------------------------
680:         * CAMPO 3: Descricao (descrs) - FASE 6/8
681:         * Campo derivado do JOIN com SigOpTdz (somente exibicao). E preenchido
682:         * automaticamente ao validar/selecionar a Tabela de Desconto (txt_4c_Tabds)
683:         * e NAO e persistido diretamente em SigOpTdo (equivalente ao
684:         * "Replace Descrs With CrListaRemota.Descrs in LocalTabdO" do legado, que
685:         * so atualizava a coluna auxiliar de exibicao da grade).
686:         *----------------------------------------------------------------------
687:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
688:         WITH loc_oPagina.lbl_4c_Descricao
689:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
690:             .Top       = 222
691:             .Left      = 40
692:             .Width     = 90
693:             .Height    = 17
694:             .FontName  = "Tahoma"
695:             .FontSize  = 8
696:             .FontBold  = .F.

*-- Linhas 725 a 743:
725:     *--------------------------------------------------------------------------
726:     * FormParaBO - Transfere dados do Form para o BO antes de salvar
727:     * this_cDescrs e mantido em sincronia apenas para exibicao/consistencia -
728:     * NAO e persistido em SigOpTdo (coluna pertence a SigOpTdz, via JOIN).
729:     *--------------------------------------------------------------------------
730:     PROTECTED PROCEDURE FormParaBO()
731:         LOCAL loc_oPagina
732:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
733: 
734:         THIS.this_oBusinessObject.this_cDopes  = ALLTRIM(loc_oPagina.txt_4c_Dopes.Value)
735:         THIS.this_oBusinessObject.this_cTabds  = ALLTRIM(loc_oPagina.txt_4c_Tabds.Value)
736:         THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
737:     ENDPROC
738: 
739:     *--------------------------------------------------------------------------
740:     * BOParaForm - Transfere dados do BO para o Form apos carregar registro
741:     *--------------------------------------------------------------------------
742:     PROTECTED PROCEDURE BOParaForm()
743:         LOCAL loc_oPagina

*-- Linhas 873 a 891:
873:     *--------------------------------------------------------------------------
874:     * BtnIncluirClick - Prepara form para inclusao de novo vinculo
875:     * Operacao x Tabela de Desconto (equivalente ao cmdInserir do legado, que
876:     * fazia "Insert Into LocalTabdO (Dopes, CidChaves) Values (crSigCdOpe.Dopes,
877:     * fUniqueIds())" e focava a celula da grade). Aqui a Operacao (dopes) e
878:     * digitada pelo usuario (nao ha mais form pai informando-a via parametro).
879:     * (PUBLIC - chamado via BINDEVENT)
880:     *--------------------------------------------------------------------------
881:     PROCEDURE BtnIncluirClick()
882:         LOCAL loc_lResultado
883:         loc_lResultado = .F.
884: 
885:         TRY
886:             THIS.this_oBusinessObject.NovoRegistro()
887:             THIS.LimparCampos()
888:             THIS.this_cModoAtual = "INCLUIR"
889:             THIS.HabilitarCampos(.T.)
890:             THIS.AjustarBotoesPorModo()
891:             THIS.AlternarPagina(2)

*-- Linhas 914 a 932:
914:             RETURN .F.
915:         ENDIF
916: 
917:         SELECT cursor_4c_Dados
918:         loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
919: 
920:         TRY
921:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
922:                 THIS.BOParaForm()
923:                 THIS.this_cModoAtual = "VISUALIZAR"
924:                 THIS.HabilitarCampos(.F.)
925:                 THIS.AjustarBotoesPorModo()
926:                 THIS.AlternarPagina(2)
927:                 loc_lResultado = .T.
928:             ENDIF
929:         CATCH TO loException
930:             MostrarErro("Erro ao visualizar v" + CHR(237) + "nculo:" + CHR(13) + loException.Message, "Erro")
931:             loc_lResultado = .F.
932:         ENDTRY

*-- Linhas 950 a 968:
950:             RETURN .F.
951:         ENDIF
952: 
953:         SELECT cursor_4c_Dados
954:         loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
955: 
956:         TRY
957:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
958:                 THIS.this_oBusinessObject.EditarRegistro()
959:                 THIS.BOParaForm()
960:                 THIS.this_cModoAtual = "ALTERAR"
961:                 THIS.HabilitarCampos(.T.)
962:                 THIS.AjustarBotoesPorModo()
963:                 THIS.AlternarPagina(2)
964:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Tabds.SetFocus()
965:                 loc_lResultado = .T.
966:             ENDIF
967:         CATCH TO loException
968:             MostrarErro("Erro ao alterar v" + CHR(237) + "nculo:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 974 a 1005:
974: 
975:     *--------------------------------------------------------------------------
976:     * BtnExcluirClick - Exclui o vinculo selecionado apos confirmacao
977:     * (equivalente ao cmdExcluir do legado: "Delete" na LocalTabdO + Skip).
978:     * MsgConfirma() retorna LOGICAL (.T./.F.) - CLAUDE.md regra #7.
979:     * (PUBLIC - chamado via BINDEVENT)
980:     *--------------------------------------------------------------------------
981:     PROCEDURE BtnExcluirClick()
982:         LOCAL loc_cCidChaves, loc_cDopes, loc_cTabds, loc_lResultado
983:         loc_lResultado = .F.
984: 
985:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
986:             MsgAviso("Nenhum registro selecionado.", "Excluir")
987:             RETURN .F.
988:         ENDIF
989: 
990:         SELECT cursor_4c_Dados
991:         loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
992:         loc_cDopes     = ALLTRIM(cursor_4c_Dados.dopes)
993:         loc_cTabds     = ALLTRIM(cursor_4c_Dados.tabds)
994: 
995:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
996:             RETURN .F.
997:         ENDIF
998: 
999:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do v" + CHR(237) + "nculo " + ;
1000:                 loc_cDopes + " / " + loc_cTabds + "?", "Excluir")
1001:             RETURN .F.
1002:         ENDIF
1003: 
1004:         TRY
1005:             IF THIS.this_oBusinessObject.Excluir()

*-- Linhas 1167 a 1200:
1167:     * HabilitarCampos - Habilita/desabilita campos da Page2 conforme o modo
1168:     * Dopes (Operacao): editavel SOMENTE em INCLUIR (nao faz sentido reatribuir
1169:     * a operacao de um vinculo ja gravado). Tabds (Tabela de Desconto): editavel
1170:     * em INCLUIR e ALTERAR. Descrs: sempre somente-leitura (derivado do JOIN).
1171:     *--------------------------------------------------------------------------
1172:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1173:         LOCAL loc_oPg2, loc_lDopesHabilitar
1174:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1175: 
1176:         TRY
1177:             loc_lDopesHabilitar = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
1178: 
1179:             loc_oPg2.txt_4c_Dopes.ReadOnly = !loc_lDopesHabilitar
1180:             loc_oPg2.txt_4c_Dopes.BackColor = IIF(loc_lDopesHabilitar, RGB(255, 255, 255), RGB(212, 208, 200))
1181: 
1182:             loc_oPg2.txt_4c_Tabds.ReadOnly = !par_lHabilitar
1183:             loc_oPg2.txt_4c_Tabds.BackColor = IIF(par_lHabilitar, RGB(255, 255, 255), RGB(212, 208, 200))
1184: 
1185:             *-- Descrs permanece sempre somente-leitura (derivado do JOIN)
1186:             loc_oPg2.txt_4c_Descrs.ReadOnly  = .T.
1187:             loc_oPg2.txt_4c_Descrs.BackColor = RGB(212, 208, 200)
1188:         CATCH TO loException
1189:             MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, "Erro")
1190:         ENDTRY
1191:     ENDPROC
1192: 
1193:     *--------------------------------------------------------------------------
1194:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme o modo
1195:     * (PUBLIC - segue mesmo padrao dos demais Btn*Click chamados via BINDEVENT)
1196:     *--------------------------------------------------------------------------
1197:     PROCEDURE AjustarBotoesPorModo()
1198:         LOCAL loc_oBotoesAcao
1199:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1200: 


### BO (C:\4c\projeto\app\classes\TbOBO.prg):
*============================================================================
* TbOBO.prg - Business Object: Tabelas de Desconto por Operacao
* Migrado de: SIGCDTBV.SCX (SigCdTbO)
* Tabela principal   : SigOpTdo   (chave: cidchaves)
* Tabela relacionada : SigOpTdz   (tabelas de desconto - lookup/join, chave: codigos)
* Tabela pai         : SigCdOpe   (operacao, chave: dopes) - informada pelo form chamador
*============================================================================
DEFINE CLASS TbOBO AS BusinessBase

    *-- Propriedades: SigOpTdo
    this_cCidChaves = ""   && cidchaves   C(20) - Chave Primaria
    this_cDopes     = ""   && dopes       C(20) - FK SigCdOpe.Dopes (operacao pai)
    this_cTabds     = ""   && tabds       C(10) - FK SigOpTdz.Codigos (tabela de desconto)

    *-- Propriedade auxiliar: SigOpTdz (somente exibicao via JOIN, nao persistida em SigOpTdo)
    this_cDescrs    = ""   && descrs      C(30) - Descricao da tabela de desconto (JOIN SigOpTdz)

    *-- Nome do cursor local de detalhe (grid editavel de tabelas de desconto da operacao)
    this_cCursorDetalhe = "cursor_4c_TbODetalhe"

    *-- Flags de controle de alteracao (equivalentes a lHouveIns/lHouveExcl do legado)
    this_lHouveInsercao = .F.
    this_lHouveExclusao = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpTdo"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta propriedades para um novo registro (chamado por
    * BusinessBase.NovoRegistro()). CRITICO: sem isso, this_cCidChaves de um
    * registro anteriormente carregado (Visualizar/Alterar/Excluir) permanece
    * preenchido e Inserir() reaproveitaria essa PK antiga em vez de gerar uma
    * nova via fUniqueIds().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves = ""
        THIS.this_cDopes     = ""
        THIS.this_cTabds     = ""
        THIS.this_cDescrs    = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT das tabelas de desconto vinculadas a operacao (JOIN SigOpTdz)
    * par_cDopes: codigo da operacao (SigCdOpe.Dopes). Se vazio, retorna TODOS os
    *             vinculos de todas as operacoes (equivalente a listagem geral).
    * Espelha exatamente a query original:
    *   Select a.*,b.Descrs From SigOpTdo a, SigOpTdz b
    *     Where a.Dopes = '<dopes>' And a.Tabds = b.Codigos
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.dopes, a.tabds, b.descrs" + ;
                       " FROM SigOpTdo a" + ;
                       " INNER JOIN SigOpTdz b ON a.tabds = b.codigos"

            IF VARTYPE(par_cDopes) = "C" AND !EMPTY(par_cDopes)
                loc_cSQL = loc_cSQL + ;
                    " WHERE a.dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.tabds"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT registro por chave primaria (cidchaves) + JOIN descrs
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.dopes, a.tabds, b.descrs" + ;
                       " FROM SigOpTdo a" + ;
                       " INNER JOIN SigOpTdz b ON a.tabds = b.codigos" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = ALLTRIM(TratarNulo(cidchaves, "C"))
                THIS.this_cDopes     = ALLTRIM(TratarNulo(dopes, "C"))
                THIS.this_cTabds     = ALLTRIM(TratarNulo(tabds, "C"))
                *-- descrs so existe quando o SELECT fez JOIN com SigOpTdz (Buscar/CarregarPorCodigo)
                IF TYPE("descrs") = "C"
                    THIS.this_cDescrs = ALLTRIM(TratarNulo(descrs, "C"))
                ELSE
                    THIS.this_cDescrs = ""
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigOpTdo (todas colunas NOT NULL preenchidas)
    * Gera cidchaves automaticamente (equivalente a fUniqueIds() do legado) se
    * ainda nao tiver sido atribuido.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpTdo" + ;
                       " (cidchaves, dopes, tabds)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       EscaparSQL(THIS.this_cTabds) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                THIS.this_lHouveInsercao = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigOpTdo (dopes/tabds) WHERE cidchaves = chave
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpTdo SET" + ;
                       " dopes = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " tabds = " + EscaparSQL(THIS.this_cTabds) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigOpTdo WHERE cidchaves = chave
    * (Chamado PUBLICAMENTE via THIS.Excluir(), nunca direto - CLAUDE.md regra BO)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpTdo WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                THIS.this_lHouveExclusao = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteVinculoDuplicado - Verifica se a Tabela de Desconto ja esta
    * vinculada a esta Operacao em OUTRO registro. Equivale a validacao de
    * duplicidade de Tabds por Dopes do cmdSair.Click do legado (que escaneava
    * toda a LocalTabdO em memoria antes de gravar em lote); aqui e aplicada no
    * momento do Salvar de cada vinculo individual (par_cCidChavesAtual exclui
    * o proprio registro em edicao, para nao se autoacusar de duplicidade).
    *--------------------------------------------------------------------------
    FUNCTION ExisteVinculoDuplicado(par_cDopes, par_cTabds, par_cCidChavesAtual)
        LOCAL loc_lExiste, loc_cSQL, loc_nResultado
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigOpTdo" + ;
                       " WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
                       " AND tabds = " + EscaparSQL(ALLTRIM(par_cTabds))

            IF VARTYPE(par_cCidChavesAtual) = "C" AND !EMPTY(par_cCidChavesAtual)
                loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(ALLTRIM(par_cCidChavesAtual))
            ENDIF

            IF USED("cursor_4c_DupVinc")
                USE IN cursor_4c_DupVinc
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupVinc")
            IF loc_nResultado >= 0
                loc_lExiste = (RECCOUNT("cursor_4c_DupVinc") > 0)
            ELSE
                MsgErro("Erro ao verificar duplicidade do v" + CHR(237) + "nculo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DupVinc")
                USE IN cursor_4c_DupVinc
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.ExisteVinculoDuplicado:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarTabelaDescontoDuplicada - Verifica se ha Tabds repetido para a mesma
    * operacao (equivalente ao "Select Tabds,sum(1) as TT ... GROUP by 1 ... TT>1"
    * do cmdSair.Click do legado)
    *--------------------------------------------------------------------------
    FUNCTION ValidarTabelaDescontoDuplicada(par_cDopes)
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResultado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT tabds, COUNT(*) AS Total FROM SigOpTdo" + ;
                       " WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
                       " GROUP BY tabds HAVING COUNT(*) > 1"

            IF USED("cursor_4c_DupChk")
                TABLEREVERT(.T., "cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_DupChk") > 0
                    loc_lDuplicado = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao verificar duplicidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.ValidarTabelaDescontoDuplicada:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

ENDDEFINE

