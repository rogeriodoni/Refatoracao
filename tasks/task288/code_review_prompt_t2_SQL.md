# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CCHAVE1S' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNTMSTR1, LNCONTA1, LLERROR, LNCONTA2
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNTMSTR1, LNCONTA1, LLERROR, LNCONTA2
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'POFORM1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNTMSTR1, LNCONTA1, LLERROR, LNCONTA2

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
		Select Distinct a.cEmps;
		  From ('crRel1') a;
		Select ('crGrafico1')
			Select ('crRel1')
			Select ('crGrafico1')
			Insert Into crGrafico1 (cchave1s,ctitulo1s,cempresas) Values (m.lcChave1,m.lcTitulo1,m.lcEmpresa)
				.ControlSource = 'crGrafico1.gGrafico1s'
	Select ('crGrafico1')
	.cntGrf1.oleGrafico1.ControlSource = ''

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf2.prg) - TRECHOS RELEVANTES PARA PASS SQL (1097 linhas total):

*-- Linhas 473 a 491:
473:                     SET SEPARATOR TO ","
474:                     SET REPORTBEHAVIOR 80
475: 
476:                     SELECT crGrafico1
477:                     REPORT FORM (FULLPATH(gc_4c_CaminhoReports + "SigPrGf1")) ;
478:                         NEXT 1 TO PRINTER PROMPT NOCONSOLE
479: 
480:                     SET POINT TO (loc_cPoint)
481:                     SET SEPARATOR TO (loc_cSep)
482:                     SET REPORTBEHAVIOR 90
483: 
484:                     IF BETWEEN(loc_nRecno, 1, RECCOUNT("crGrafico1"))
485:                         GOTO loc_nRecno IN crGrafico1
486:                     ENDIF
487: 
488:                     THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
489:                 ELSE
490:                     MsgAviso("Nenhum gr" + CHR(225) + "fico dispon" + CHR(237) + ;
491:                              "vel para impress" + CHR(227) + "o.", ;

*-- Linhas 514 a 532:
514: 
515:             IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
516:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
517:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
518:             ENDIF
519: 
520:             IF USED("crGrafico1")
521:                 USE IN crGrafico1
522:             ENDIF
523: 
524:             THIS.Release()
525: 
526:         CATCH TO loc_oErro
527:             THIS.LockScreen = .F.
528:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
529:                     "Erro BtnEncerrarClick")
530:         ENDTRY
531:     ENDPROC
532: 

*-- Linhas 599 a 632:
599: 
600:                 *-- Verificar cache ANTES de chamar BO (para saber se precisa configurar OLE)
601:                 IF USED("crGrafico1")
602:                     SELECT crGrafico1
603:                     LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave1, 100)
604:                     loc_lCacheMiss = EOF("crGrafico1")
605:                 ELSE
606:                     loc_lCacheMiss = .T.
607:                 ENDIF
608: 
609:                 *-- BO: cache miss -> INSERT + APPEND GENERAL; cache hit -> apenas posiciona
610:                 IF THIS.this_oBusinessObject.CarregarDadosGrafico(1, @loc_aChaves)
611:                     loc_oOle = THIS.cnt_4c_Grf1.obj_4c_OleGrafico1
612: 
613:                     IF loc_lCacheMiss
614:                         *-- Cache miss: configurar propriedades do grafico OLE
615:                         TRY
616:                             WITH loc_oOle
617:                                 .ControlSource   = "crGrafico1.gGrafico1s"
618:                                 .AutoActivate    = 0
619:                                 .AutoSize        = .T.
620:                                 .Sizable         = .T.
621:                                 .Stretch         = 2
622:                                 .HasLegend       = .T.
623:                                 .HasTitle        = .T.
624:                                 .DisplayBlanksAs = 1
625:                                 .HasAxis(2)      = .T.
626:                                 .Type            = -4100
627:                                 .SubType         = 1
628: 
629:                                 WITH .ChartArea
630:                                     .Font.Name        = "Arial"
631:                                     .Font.Size        = 8
632:                                     .Font.Bold        = .T.

*-- Linhas 741 a 761:
741:                             *-- Erros OLE nao sao fatais; grafico pode exibir parcialmente
742:                         ENDTRY
743:                     ELSE
744:                         *-- Cache hit: cursor ja posicionado, reforcar ControlSource e refresh
745:                         TRY
746:                             loc_oOle.ControlSource = "crGrafico1.gGrafico1s"
747:                             loc_oOle.Refresh()
748:                         CATCH TO loc_oErro
749:                             *-- Erros OLE nao sao fatais
750:                         ENDTRY
751:                     ENDIF
752: 
753:                     loc_lSucesso = .T.
754:                 ENDIF
755:             ENDIF
756: 
757:         CATCH TO loc_oErro
758:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
759:                     "Erro GerarGrafico")
760:         ENDTRY
761: 

*-- Linhas 770 a 788:
770:     *--------------------------------------------------------------------------
771:     * BtnIncluirClick - Reseta a selecao do combo para o primeiro item e
772:     * regenera o grafico. Em SigPrGf2 (form OPERACIONAL de visualizacao de
773:     * grafico MSGraph) nao ha INSERT persistente ??? "Incluir" corresponde a
774:     * "nova consulta/processamento" do grafico com a chave inicial.
775:     * Existe para atender ao contrato da pipeline.
776:     *--------------------------------------------------------------------------
777:     PROCEDURE BtnIncluirClick()
778:         LOCAL loc_oErro
779: 
780:         TRY
781:             THIS.cnt_4c_Aguarde.Visible = .T.
782:             THIS.Refresh()
783:             THIS.LockScreen = .T.
784:             THIS.SetAll("Enabled", .F., "OLEBoundControl")
785: 
786:             *-- Regenera o grafico a partir do primeiro item do combo
787:             THIS.GerarGrafico(1)
788: 

*-- Linhas 805 a 823:
805:     *--------------------------------------------------------------------------
806:     * BtnAlterarClick - Habilita edicao interativa da chave: garante que o
807:     * ComboBox esteja habilitado e devolve foco ao combo para permitir troca
808:     * do grupo/vendedor. Nao ha UPDATE persistente em SigPrGf2 (form
809:     * OPERACIONAL sem entidade CRUD). Existe para atender ao contrato da
810:     * pipeline e como atalho equivalente a "editar selecao".
811:     *--------------------------------------------------------------------------
812:     PROCEDURE BtnAlterarClick()
813:         LOCAL loc_oErro
814: 
815:         TRY
816:             IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
817:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
818:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled  = .T.
819:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ReadOnly = .F.
820: 
821:                 IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
822:                     THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
823:                 ENDIF

*-- Linhas 845 a 878:
845: 
846:     *--------------------------------------------------------------------------
847:     * BtnExcluirClick - Limpa o cache do grafico e reseta o OLE Bound Control:
848:     * apaga registros do cursor crGrafico1, desvincula a ControlSource do OLE
849:     * e sinaliza o container de espera. Nao existe DELETE em SigPrGf2 (form
850:     * OPERACIONAL sem entidade persistida) ??? este evento existe para atender
851:     * ao contrato da pipeline e como atalho equivalente a "limpar consulta".
852:     *--------------------------------------------------------------------------
853:     PROCEDURE BtnExcluirClick()
854:         LOCAL loc_oErro
855: 
856:         TRY
857:             THIS.LockScreen = .T.
858: 
859:             *-- Desvincula o OLE Bound Control (para o grafico deixar de refletir cache)
860:             IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
861:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
862:                 TRY
863:                     THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
864:                 CATCH TO loc_oErro
865:                     *-- Erros OLE nao sao fatais aqui
866:                 ENDTRY
867:             ENDIF
868: 
869:             *-- Limpa cache do BO (ZAP em crGrafico1)
870:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
871:                 THIS.this_oBusinessObject.LimparCursorGrafico()
872:                 THIS.this_oBusinessObject.InicializarCursorGrafico()
873:             ENDIF
874: 
875:             *-- Estado de espera: grafico oculto, combo mantido para reselecao
876:             THIS.cnt_4c_Grf1.Visible    = .F.
877:             THIS.cnt_4c_Aguarde.Visible = .T.
878: 

*-- Linhas 981 a 999:
981:             IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
982:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
983:                 TRY
984:                     THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
985:                 CATCH
986:                 ENDTRY
987:             ENDIF
988: 
989:             *-- Limpa e recria cursor de cache via BO
990:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
991:                 THIS.this_oBusinessObject.LimparCursorGrafico()
992:                 THIS.this_oBusinessObject.InicializarCursorGrafico()
993:             ENDIF
994: 
995:             *-- Resetar combo
996:             IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
997:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
998:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
999:             ENDIF


### BO (C:\4c\projeto\app\classes\SigPrGf2BO.prg):
*==============================================================================
* SigPrGf2BO.prg - Business Object: Grafico de Falha X Recuperacao Mensal
* Herda de: BusinessBase
* Tipo: OPERACIONAL - Visualizacao de grafico OLE (MSGraph)
* Sem tabela de banco - dados vem do cursor crRel1 do form pai
*==============================================================================
DEFINE CLASS SigPrGf2BO AS BusinessBase

    *-- Identificacao da entidade (sem tabela CRUD)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Cursores utilizados
    this_cCursorOrigem  = "crRel1"      && Cursor com dados do form pai
    this_cCursorGrafico = "crGrafico1"  && Cursor de cache do grafico OLE

    *-- Configuracao do grafico
    this_nNumGrafico = 0    && Numero do grafico (pnnumgrf)
    this_cCaption    = ""   && Titulo exibido no cabecalho e no grafico

    *-- Chave de selecao atual (cmbChave1 - Grupo/Vendedor)
    this_cChave1 = ""       && Valor selecionado no ComboBox (cEmps)

    *-- Dados de titulo extraidos de crRel1
    this_cTitulo1   = ""    && Titulo linha 1 (crRel1.cTitulo1s)
    this_cTitulo2   = ""    && Titulo linha 2 (crRel1.cTitulo2s)
    this_cEmpresa   = ""    && Nome da empresa (crRel1.cEmpresas)

    *-- Series de dados (strings TAB-delimitadas para MSGraph)
    this_cStranomes  = ""   && Nomes dos meses (crRel1.cStranomes, TAB-sep)
    this_cStrFalhas  = ""   && Contagem de falhas (crRel1.nFalhas, TAB-sep)
    this_cStrPesoccb = ""   && Contagem de recuperacoes (crRel1.nPesoccbs, TAB-sep)

    *-- Dimensoes das series
    this_nNmeses  = 0       && Numero de periodos/meses encontrados
    this_nNgrupos = 2       && Numero de series no grafico (Falha + Recuperacao)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            this_cTabela     = ""
            this_cCampoChave = ""
            this_cCaption    = "Gr" + CHR(225) + "fico de Falha X Recupera" + CHR(231) + CHR(227) + "o Mensal"
            this_nNgrupos    = 2

            loc_lResultado = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave do grafico (cEmps do vendedor/grupo)
    * Sem tabela SQL persistente: chave logica eh o valor selecionado no ComboBox
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChave1)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *   par_cAliasCursor - Nome do alias (crRel1 ou crGrafico1)
    *   Se omitido, usa this_cCursorOrigem (crRel1)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias
        loc_lResultado = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         par_cAliasCursor, THIS.this_cCursorOrigem)

        TRY
            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
            ELSE
                SELECT (loc_cAlias)

                DO CASE
                CASE UPPER(loc_cAlias) == UPPER(THIS.this_cCursorOrigem)
                    *-- Mapeia crRel1 (cursor do form pai)
                    IF TYPE(loc_cAlias + ".cEmps") != "U"
                        THIS.this_cChave1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cEmps"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cTitulo1s") != "U"
                        THIS.this_cTitulo1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cTitulo1s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cTitulo2s") != "U"
                        THIS.this_cTitulo2 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cTitulo2s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cEmpresas") != "U"
                        THIS.this_cEmpresa = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cEmpresas"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cStranomes") != "U"
                        THIS.this_cStranomes = NVL(EVALUATE(loc_cAlias + ".cStranomes"), "")
                    ENDIF
                    loc_lResultado = .T.
                CASE UPPER(loc_cAlias) == UPPER(THIS.this_cCursorGrafico)
                    *-- Mapeia crGrafico1 (cursor de cache do grafico OLE)
                    IF TYPE(loc_cAlias + ".cChave1s") != "U"
                        THIS.this_cChave1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cChave1s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".ctitulo1s") != "U"
                        THIS.this_cTitulo1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ctitulo1s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cempresas") != "U"
                        THIS.this_cEmpresa = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cempresas"), ""))
                    ENDIF
                    loc_lResultado = .T.
                OTHERWISE
                    THIS.this_cMensagemErro = "Alias n" + CHR(227) + "o suportado: " + loc_cAlias
                ENDCASE
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar cursor: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere registro de cache no cursor crGrafico1
    * Nao ha tabela persistente em SQL Server: cache eh mantido em memoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave = ALLTRIM(THIS.this_cChave1)

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave do gr" + CHR(225) + "fico n" + CHR(227) + "o informada"
            ELSE
                THIS.InicializarCursorGrafico()

                SELECT crGrafico1
                LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave, 100)

                IF !EOF("crGrafico1")
                    THIS.this_cMensagemErro = "Cache do gr" + CHR(225) + "fico j" + CHR(225) + " existe: " + loc_cChave
                ELSE
                    INSERT INTO crGrafico1 (cChave1s, ctitulo1s, cempresas) ;
                        VALUES (PADR(loc_cChave, 100), ;
                                PADR(THIS.this_cTitulo1, 128), ;
                                PADR(THIS.this_cEmpresa, 254))

                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir cache do gr" + CHR(225) + "fico: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro de cache do grafico
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave = ALLTRIM(THIS.this_cChave1)

            DO CASE
            CASE EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave do gr" + CHR(225) + "fico n" + CHR(227) + "o informada"
            CASE !USED("crGrafico1")
                THIS.this_cMensagemErro = "Cursor crGrafico1 n" + CHR(227) + "o est" + CHR(225) + " aberto"
            OTHERWISE
                SELECT crGrafico1
                LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave, 100)

                IF EOF("crGrafico1")
                    THIS.this_cMensagemErro = "Cache do gr" + CHR(225) + "fico n" + CHR(227) + "o encontrado: " + loc_cChave
                ELSE
                    REPLACE crGrafico1.ctitulo1s WITH PADR(THIS.this_cTitulo1, 128), ;
                            crGrafico1.cempresas  WITH PADR(THIS.this_cEmpresa, 254)

                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar cache do gr" + CHR(225) + "fico: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra visualizacao do grafico em LogAuditoria
    *   par_cOperacao - "INSERT", "UPDATE" ou "VIEW"
    * Grafico OLE nao possui tabela persistente; auditoria usa "SigPrGf2" como
    *   tabela virtual e a chave selecionada como ChaveRegistro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()

            DO CASE
            CASE EMPTY(loc_cChave)
                *-- Sem chave: nao ha o que auditar
            CASE TYPE("gnConnHandle") != "N" OR gnConnHandle < 0
                *-- Sem conexao ativa: pula auditoria silenciosamente
            OTHERWISE
                loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

                loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                           "VALUES (" + EscaparSQL("SigPrGf2") + ", " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL(loc_cChave) + ", " + ;
                           EscaparSQL(loc_cUsuario) + ", GETDATE())"

                SQLEXEC(gnConnHandle, loc_cSQL)
                loc_lResultado = .T.
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao registrar auditoria: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursorGrafico - Cria cursor crGrafico1 se nao existir
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursorGrafico()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !USED("crGrafico1")
                SET NULL ON
                CREATE CURSOR crGrafico1 ;
                    (gGrafico1s G(4), cChave1s C(100), cempresas C(254), ctitulo1s C(128))
                SET NULL OFF
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavesGrafico - Retorna array de valores distintos de cEmps no crRel1
    *   par_aChaves - array BYREF que recebera as chaves
    *   Retorna: numero de chaves encontradas (0 se falhar)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavesGrafico(par_aChaves)
        LOCAL loc_nCount
        loc_nCount = 0

        TRY
            IF !USED(THIS.this_cCursorOrigem)
                loc_lResultado = 0
            ENDIF

            DIMENSION par_aChaves(1)
            par_aChaves = .F.

            SELECT DISTINCT cEmps ;
                FROM (THIS.this_cCursorOrigem) ;
                ORDER BY 1 ;
                INTO ARRAY par_aChaves

            loc_nCount = ALEN(par_aChaves, 1)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_nCount = 0
        ENDTRY

        RETURN loc_nCount
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosGrafico - Prepara crGrafico1 para a chave selecionada
    *   par_nLinha    - Indice (1-based) da chave no array de chaves
    *   par_aChaves   - Array com os valores de cEmps disponiveis
    *   Retorna .T. se os dados foram preparados com sucesso
    *   Efeito colateral: popula this_cChave1, this_cTitulo1, this_cEmpresa,
    *     this_cStranomes, this_cStrFalhas, this_cStrPesoccb, this_nNmeses
    *     e insere/garante registro em crGrafico1 (APPEND GENERAL gGrafico1s)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosGrafico(par_nLinha, par_aChaves)
        LOCAL loc_lResultado, loc_nLinha, loc_cChave1
        LOCAL loc_cTitulo1, loc_cEmpresa
        LOCAL loc_cStrg1, loc_cStrg2, loc_cStrg3, loc_nNmeses
        LOCAL loc_cTAB, loc_cCRLF

        loc_lResultado = .F.
        loc_cTAB  = CHR(9)
        loc_cCRLF = CHR(13) + CHR(10)

        TRY
            IF !USED(THIS.this_cCursorOrigem)
                loc_lResultado = .F.
            ENDIF

            loc_nLinha = IIF(VARTYPE(par_nLinha) = "N" .AND. par_nLinha > 0, par_nLinha, 1)

            IF VARTYPE(par_aChaves) != "A" OR ALEN(par_aChaves, 1) < loc_nLinha
                loc_lResultado = .F.
            ENDIF

            loc_cChave1 = ALLTRIM(par_aChaves(loc_nLinha))

            THIS.InicializarCursorGrafico()

            *-- Verificar cache
            SELECT crGrafico1
            LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave1, 100)

            IF EOF("crGrafico1")
                *-- Preparar series de dados a partir do cursor de origem
                loc_nNmeses = 0
                loc_cStrg2  = "Falha"
                loc_cStrg3  = "Recupera" + CHR(231) + CHR(227) + "o"
                loc_cStrg1  = ""
                loc_cTitulo1 = ""
                loc_cEmpresa = ""

                SELECT crRel1
                SET ORDER TO ("") IN crRel1
                LOCATE FOR crRel1.cEmps == loc_cChave1

                IF !EOF("crRel1")
                    loc_cTitulo1 = ALLTRIM(crRel1.cTitulo1s) + CHR(13) + ALLTRIM(crRel1.cTitulo2s)
                    loc_cEmpresa = crRel1.cEmpresas

                    SCAN WHILE crRel1.cEmps == loc_cChave1
                        loc_nNmeses = loc_nNmeses + 1
                        loc_cStrg1  = loc_cStrg1 + loc_cTAB + ALLTRIM(crRel1.cStranomes)
                        loc_cStrg2  = loc_cStrg2 + loc_cTAB + ;
                            ALLTRIM(TRANSFORM(crRel1.nFalhas, "999,999,999.99"))
                        loc_cStrg3  = loc_cStrg3 + loc_cTAB + ;
                            ALLTRIM(TRANSFORM(crRel1.nPesoccbs, "999,999,999.99"))
                    ENDSCAN
                ENDIF

                *-- Inserir no cache e gravar objeto OLE do grafico
                SELECT crGrafico1
                INSERT INTO crGrafico1 (cChave1s, ctitulo1s, cempresas) ;
                    VALUES (loc_cChave1, loc_cTitulo1, loc_cEmpresa)
                APPEND GENERAL gGrafico1s CLASS "MSGraph.Chart" ;
                    DATA (loc_cStrg1 + loc_cCRLF + loc_cStrg2 + loc_cCRLF + loc_cStrg3)

                *-- Atualizar propriedades do BO
                THIS.this_cChave1     = loc_cChave1
                THIS.this_cEmpresa    = loc_cEmpresa
                THIS.this_cTitulo1    = loc_cTitulo1
                THIS.this_cStranomes  = loc_cStrg1
                THIS.this_cStrFalhas  = loc_cStrg2
                THIS.this_cStrPesoccb = loc_cStrg3
                THIS.this_nNmeses     = loc_nNmeses
            ELSE
                *-- Recuperar titulo/empresa do cache
                THIS.this_cChave1  = ALLTRIM(crGrafico1.cChave1s)
                THIS.this_cTitulo1 = ALLTRIM(crGrafico1.ctitulo1s)
                THIS.this_cEmpresa = ALLTRIM(crGrafico1.cempresas)
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursorGrafico - Fecha cursor de cache do grafico
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursorGrafico()
        IF USED("crGrafico1")
            USE IN crGrafico1
        ENDIF
    ENDPROC

ENDDEFINE

