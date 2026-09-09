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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTbO.prg) - TRECHOS RELEVANTES PARA PASS SQL (1271 linhas total):

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
376:             *-- Coluna 1 (Operacao/dopes) nao existe na grade legado SIGCDTBV.GradeSubN
377:             *-- (ColumnCount=2: Tab.Desconto+Descricao) porque la a grade ja vinha
378:             *-- filtrada por uma unica Operacao injetada pelo form pai. Aqui a Page1

*-- Linhas 409 a 429:
409:                     loc_oGrid.RecordSource = ""
410:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
411: 
412:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dopes"
413:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.tabds"
414:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
415: 
416:                     *-- RecordSource reseta Width/Header/ReadOnly - reconfigurar SEMPRE
417:                     loc_oGrid.Column1.Width           = 150
418:                     loc_oGrid.Column2.Width           = 150
419:                     loc_oGrid.Column3.Width           = 588
420:                     loc_oGrid.Column1.ReadOnly        = .T.
421:                     loc_oGrid.Column2.ReadOnly        = .T.
422:                     loc_oGrid.Column3.ReadOnly        = .T.
423:                     *-- Coluna 1 (Operacao/dopes) sem equivalente na grade legado - ver
424:                     *-- justificativa em ConfigurarPaginaLista/grd_4c_Dados acima.
425:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
426:                     loc_oGrid.Column2.Header1.Caption = "Tab.Desconto"
427:                     loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
428: 
429:                     THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 475 a 493:
475:     * ConfigurarPaginaDados - Configura Page2 (Dados)
476:     * Campos completos: txt_4c_Dopes (Operacao, read-only), txt_4c_Tabds
477:     * (Tabela de Desconto, editavel, com lookup F4/DblClick completo em
478:     * SigOpTdz) e txt_4c_Descrs (Descricao, read-only, derivado do JOIN).
479:     * Container cnt_4c_BotoesAcao com botoes Confirmar/Cancelar (BINDEVENT para
480:     * BtnSalvarClick/BtnCancelarClick, cuja logica e implementada na fase de
481:     * Eventos - mesmo padrao usado nos botoes CRUD de ConfigurarPaginaLista).
482:     *--------------------------------------------------------------------------
483:     PROTECTED PROCEDURE ConfigurarPaginaDados()
484:         LOCAL loc_oPagina
485:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
486: 
487:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
488:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
489: 
490:         *-- Cabecalho cinza (identico ao da pagina Lista)
491:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
492:         WITH loc_oPagina.cnt_4c_Cabecalho
493:             .Top           = 29

*-- Linhas 687 a 705:
687: 
688:         *----------------------------------------------------------------------
689:         * CAMPO 3: Descricao (descrs) - FASE 6/8
690:         * Campo derivado do JOIN com SigOpTdz (somente exibicao). E preenchido
691:         * automaticamente ao validar/selecionar a Tabela de Desconto (txt_4c_Tabds)
692:         * e NAO e persistido diretamente em SigOpTdo (equivalente ao
693:         * "Replace Descrs With CrListaRemota.Descrs in LocalTabdO" do legado, que
694:         * so atualizava a coluna auxiliar de exibicao da grade).
695:         *----------------------------------------------------------------------
696:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
697:         WITH loc_oPagina.lbl_4c_Descricao
698:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
699:             .Top       = 222
700:             .Left      = 40
701:             .Width     = 90
702:             .Height    = 17
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8
705:             .FontBold  = .F.

*-- Linhas 734 a 752:
734:     *--------------------------------------------------------------------------
735:     * FormParaBO - Transfere dados do Form para o BO antes de salvar
736:     * this_cDescrs e mantido em sincronia apenas para exibicao/consistencia -
737:     * NAO e persistido em SigOpTdo (coluna pertence a SigOpTdz, via JOIN).
738:     *--------------------------------------------------------------------------
739:     PROTECTED PROCEDURE FormParaBO()
740:         LOCAL loc_oPagina
741:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
742: 
743:         THIS.this_oBusinessObject.this_cDopes  = ALLTRIM(loc_oPagina.txt_4c_Dopes.Value)
744:         THIS.this_oBusinessObject.this_cTabds  = ALLTRIM(loc_oPagina.txt_4c_Tabds.Value)
745:         THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
746:     ENDPROC
747: 
748:     *--------------------------------------------------------------------------
749:     * BOParaForm - Transfere dados do BO para o Form apos carregar registro
750:     *--------------------------------------------------------------------------
751:     PROTECTED PROCEDURE BOParaForm()
752:         LOCAL loc_oPagina

*-- Linhas 882 a 900:
882:     *--------------------------------------------------------------------------
883:     * BtnIncluirClick - Prepara form para inclusao de novo vinculo
884:     * Operacao x Tabela de Desconto (equivalente ao cmdInserir do legado, que
885:     * fazia "Insert Into LocalTabdO (Dopes, CidChaves) Values (crSigCdOpe.Dopes,
886:     * fUniqueIds())" e focava a celula da grade). Aqui a Operacao (dopes) e
887:     * digitada pelo usuario (nao ha mais form pai informando-a via parametro).
888:     * (PUBLIC - chamado via BINDEVENT)
889:     *--------------------------------------------------------------------------
890:     PROCEDURE BtnIncluirClick()
891:         LOCAL loc_lResultado
892:         loc_lResultado = .F.
893: 
894:         TRY
895:             THIS.this_oBusinessObject.NovoRegistro()
896:             THIS.LimparCampos()
897:             THIS.this_cModoAtual = "INCLUIR"
898:             THIS.HabilitarCampos(.T.)
899:             THIS.AjustarBotoesPorModo()
900:             THIS.AlternarPagina(2)

*-- Linhas 923 a 941:
923:             RETURN .F.
924:         ENDIF
925: 
926:         SELECT cursor_4c_Dados
927:         loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
928: 
929:         TRY
930:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
931:                 THIS.BOParaForm()
932:                 THIS.this_cModoAtual = "VISUALIZAR"
933:                 THIS.HabilitarCampos(.F.)
934:                 THIS.AjustarBotoesPorModo()
935:                 THIS.AlternarPagina(2)
936:                 loc_lResultado = .T.
937:             ENDIF
938:         CATCH TO loException
939:             MostrarErro("Erro ao visualizar v" + CHR(237) + "nculo:" + CHR(13) + loException.Message, "Erro")
940:             loc_lResultado = .F.
941:         ENDTRY

*-- Linhas 959 a 977:
959:             RETURN .F.
960:         ENDIF
961: 
962:         SELECT cursor_4c_Dados
963:         loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
964: 
965:         TRY
966:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
967:                 THIS.this_oBusinessObject.EditarRegistro()
968:                 THIS.BOParaForm()
969:                 THIS.this_cModoAtual = "ALTERAR"
970:                 THIS.HabilitarCampos(.T.)
971:                 THIS.AjustarBotoesPorModo()
972:                 THIS.AlternarPagina(2)
973:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Tabds.SetFocus()
974:                 loc_lResultado = .T.
975:             ENDIF
976:         CATCH TO loException
977:             MostrarErro("Erro ao alterar v" + CHR(237) + "nculo:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 983 a 1014:
983: 
984:     *--------------------------------------------------------------------------
985:     * BtnExcluirClick - Exclui o vinculo selecionado apos confirmacao
986:     * (equivalente ao cmdExcluir do legado: "Delete" na LocalTabdO + Skip).
987:     * MsgConfirma() retorna LOGICAL (.T./.F.) - CLAUDE.md regra #7.
988:     * (PUBLIC - chamado via BINDEVENT)
989:     *--------------------------------------------------------------------------
990:     PROCEDURE BtnExcluirClick()
991:         LOCAL loc_cCidChaves, loc_cDopes, loc_cTabds, loc_lResultado
992:         loc_lResultado = .F.
993: 
994:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
995:             MsgAviso("Nenhum registro selecionado.", "Excluir")
996:             RETURN .F.
997:         ENDIF
998: 
999:         SELECT cursor_4c_Dados
1000:         loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1001:         loc_cDopes     = ALLTRIM(cursor_4c_Dados.dopes)
1002:         loc_cTabds     = ALLTRIM(cursor_4c_Dados.tabds)
1003: 
1004:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1005:             RETURN .F.
1006:         ENDIF
1007: 
1008:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do v" + CHR(237) + "nculo " + ;
1009:                 loc_cDopes + " / " + loc_cTabds + "?", "Excluir")
1010:             RETURN .F.
1011:         ENDIF
1012: 
1013:         TRY
1014:             IF THIS.this_oBusinessObject.Excluir()

*-- Linhas 1176 a 1209:
1176:     * HabilitarCampos - Habilita/desabilita campos da Page2 conforme o modo
1177:     * Dopes (Operacao): editavel SOMENTE em INCLUIR (nao faz sentido reatribuir
1178:     * a operacao de um vinculo ja gravado). Tabds (Tabela de Desconto): editavel
1179:     * em INCLUIR e ALTERAR. Descrs: sempre somente-leitura (derivado do JOIN).
1180:     *--------------------------------------------------------------------------
1181:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1182:         LOCAL loc_oPg2, loc_lDopesHabilitar
1183:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1184: 
1185:         TRY
1186:             loc_lDopesHabilitar = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
1187: 
1188:             loc_oPg2.txt_4c_Dopes.ReadOnly = !loc_lDopesHabilitar
1189:             loc_oPg2.txt_4c_Dopes.BackColor = IIF(loc_lDopesHabilitar, RGB(255, 255, 255), RGB(212, 208, 200))
1190: 
1191:             loc_oPg2.txt_4c_Tabds.ReadOnly = !par_lHabilitar
1192:             loc_oPg2.txt_4c_Tabds.BackColor = IIF(par_lHabilitar, RGB(255, 255, 255), RGB(212, 208, 200))
1193: 
1194:             *-- Descrs permanece sempre somente-leitura (derivado do JOIN)
1195:             loc_oPg2.txt_4c_Descrs.ReadOnly  = .T.
1196:             loc_oPg2.txt_4c_Descrs.BackColor = RGB(212, 208, 200)
1197:         CATCH TO loException
1198:             MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, "Erro")
1199:         ENDTRY
1200:     ENDPROC
1201: 
1202:     *--------------------------------------------------------------------------
1203:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme o modo
1204:     * (PUBLIC - segue mesmo padrao dos demais Btn*Click chamados via BINDEVENT)
1205:     *--------------------------------------------------------------------------
1206:     PROCEDURE AjustarBotoesPorModo()
1207:         LOCAL loc_oBotoesAcao
1208:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1209: 


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

