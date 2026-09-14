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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf2.prg) - TRECHOS RELEVANTES PARA PASS SQL (1101 linhas total):

*-- Linhas 477 a 495:
477:                     SET SEPARATOR TO ","
478:                     SET REPORTBEHAVIOR 80
479: 
480:                     SELECT crGrafico1
481:                     REPORT FORM (FULLPATH(gc_4c_CaminhoReports + "SigPrGf1")) ;
482:                         NEXT 1 TO PRINTER PROMPT NOCONSOLE
483: 
484:                     SET POINT TO (loc_cPoint)
485:                     SET SEPARATOR TO (loc_cSep)
486:                     SET REPORTBEHAVIOR 90
487: 
488:                     IF BETWEEN(loc_nRecno, 1, RECCOUNT("crGrafico1"))
489:                         GOTO loc_nRecno IN crGrafico1
490:                     ENDIF
491: 
492:                     THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
493:                 ELSE
494:                     MsgAviso("Nenhum gr" + CHR(225) + "fico dispon" + CHR(237) + ;
495:                              "vel para impress" + CHR(227) + "o.", ;

*-- Linhas 519 a 537:
519: 
520:             IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
521:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
522:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
523:             ENDIF
524: 
525:             IF USED("crGrafico1")
526:                 USE IN crGrafico1
527:             ENDIF
528: 
529:             THIS.Release()
530: 
531:         CATCH TO loc_oErro
532:             THIS.LockScreen = .F.
533:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
534:                     "Erro BtnEncerrarClick")
535:         ENDTRY
536:     ENDPROC
537: 

*-- Linhas 604 a 637:
604: 
605:                 *-- Verificar cache ANTES de chamar BO (para saber se precisa configurar OLE)
606:                 IF USED("crGrafico1")
607:                     SELECT crGrafico1
608:                     LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave1, 100)
609:                     loc_lCacheMiss = EOF("crGrafico1")
610:                 ELSE
611:                     loc_lCacheMiss = .T.
612:                 ENDIF
613: 
614:                 *-- BO: cache miss -> INSERT + APPEND GENERAL; cache hit -> apenas posiciona
615:                 IF THIS.this_oBusinessObject.CarregarDadosGrafico(1, @loc_aChaves)
616:                     loc_oOle = THIS.cnt_4c_Grf1.obj_4c_OleGrafico1
617: 
618:                     IF loc_lCacheMiss
619:                         *-- Cache miss: configurar propriedades do grafico OLE
620:                         TRY
621:                             WITH loc_oOle
622:                                 .ControlSource   = "crGrafico1.gGrafico1s"
623:                                 .AutoActivate    = 0
624:                                 .AutoSize        = .T.
625:                                 .Sizable         = .T.
626:                                 .Stretch         = 2
627:                                 .HasLegend       = .T.
628:                                 .HasTitle        = .T.
629:                                 .DisplayBlanksAs = 1
630:                                 .HasAxis(2)      = .T.
631:                                 .Type            = -4100
632:                                 .SubType         = 1
633: 
634:                                 WITH .ChartArea
635:                                     .Font.Name        = "Arial"
636:                                     .Font.Size        = 8
637:                                     .Font.Bold        = .T.

*-- Linhas 746 a 766:
746:                             *-- Erros OLE nao sao fatais; grafico pode exibir parcialmente
747:                         ENDTRY
748:                     ELSE
749:                         *-- Cache hit: cursor ja posicionado, reforcar ControlSource e refresh
750:                         TRY
751:                             loc_oOle.ControlSource = "crGrafico1.gGrafico1s"
752:                             loc_oOle.Refresh()
753:                         CATCH TO loc_oErro
754:                             *-- Erros OLE nao sao fatais
755:                         ENDTRY
756:                     ENDIF
757: 
758:                     loc_lSucesso = .T.
759:                 ENDIF
760:             ENDIF
761: 
762:         CATCH TO loc_oErro
763:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
764:                     "Erro GerarGrafico")
765:         ENDTRY
766: 

*-- Linhas 776 a 794:
776:     *--------------------------------------------------------------------------
777:     * BtnIncluirClick - Reseta a selecao do combo para o primeiro item e
778:     * regenera o grafico. Em SigPrGf2 (form OPERACIONAL de visualizacao de
779:     * grafico MSGraph) nao ha INSERT persistente ??? "Incluir" corresponde a
780:     * "nova consulta/processamento" do grafico com a chave inicial.
781:     * Existe para atender ao contrato da pipeline.
782:     *--------------------------------------------------------------------------
783:     PROCEDURE BtnIncluirClick()
784:         LOCAL loc_oErro
785: 
786:         TRY
787:             THIS.cnt_4c_Aguarde.Visible = .T.
788:             THIS.Refresh()
789:             THIS.Draw()
790:             THIS.LockScreen = .T.
791:             THIS.SetAll("Enabled", .F., "OLEBoundControl")
792: 
793:             *-- Regenera o grafico a partir do primeiro item do combo
794:             THIS.GerarGrafico(1)

*-- Linhas 813 a 831:
813:     *--------------------------------------------------------------------------
814:     * BtnAlterarClick - Habilita edicao interativa da chave: garante que o
815:     * ComboBox esteja habilitado e devolve foco ao combo para permitir troca
816:     * do grupo/vendedor. Nao ha UPDATE persistente em SigPrGf2 (form
817:     * OPERACIONAL sem entidade CRUD). Existe para atender ao contrato da
818:     * pipeline e como atalho equivalente a "editar selecao".
819:     *--------------------------------------------------------------------------
820:     PROCEDURE BtnAlterarClick()
821:         LOCAL loc_oErro
822: 
823:         TRY
824:             IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
825:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
826:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled  = .T.
827:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ReadOnly = .F.
828: 
829:                 IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
830:                     THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
831:                 ENDIF

*-- Linhas 853 a 886:
853: 
854:     *--------------------------------------------------------------------------
855:     * BtnExcluirClick - Limpa o cache do grafico e reseta o OLE Bound Control:
856:     * apaga registros do cursor crGrafico1, desvincula a ControlSource do OLE
857:     * e sinaliza o container de espera. Nao existe DELETE em SigPrGf2 (form
858:     * OPERACIONAL sem entidade persistida) ??? este evento existe para atender
859:     * ao contrato da pipeline e como atalho equivalente a "limpar consulta".
860:     *--------------------------------------------------------------------------
861:     PROCEDURE BtnExcluirClick()
862:         LOCAL loc_oErro
863: 
864:         TRY
865:             THIS.LockScreen = .T.
866: 
867:             *-- Desvincula o OLE Bound Control (para o grafico deixar de refletir cache)
868:             IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
869:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
870:                 TRY
871:                     THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
872:                 CATCH TO loc_oErro
873:                     *-- Erros OLE nao sao fatais aqui
874:                 ENDTRY
875:             ENDIF
876: 
877:             *-- Limpa cache do BO (ZAP em crGrafico1)
878:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
879:                 THIS.this_oBusinessObject.LimparCursorGrafico()
880:                 THIS.this_oBusinessObject.InicializarCursorGrafico()
881:             ENDIF
882: 
883:             *-- Estado de espera: grafico oculto, combo mantido para reselecao
884:             THIS.cnt_4c_Grf1.Visible    = .F.
885:             THIS.cnt_4c_Aguarde.Visible = .T.
886: 

*-- Linhas 990 a 1008:
990:             IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
991:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
992:                 TRY
993:                     THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
994:                 CATCH
995:                 ENDTRY
996:             ENDIF
997: 
998:             *-- Limpa e recria cursor de cache via BO
999:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1000:                 THIS.this_oBusinessObject.LimparCursorGrafico()
1001:                 THIS.this_oBusinessObject.InicializarCursorGrafico()
1002:             ENDIF
1003: 
1004:             *-- Resetar combo
1005:             IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
1006:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
1007:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
1008:             ENDIF


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

