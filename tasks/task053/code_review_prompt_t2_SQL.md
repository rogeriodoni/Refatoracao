# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'POFORM1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLINHACMB1, LNCONTA1, LLERROR, ORDEM, CCHAVE1S, LNCONTA2, LNCONTA3
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLINHACMB1, LNCONTA1, LLERROR, ORDEM, CCHAVE1S, LNCONTA2, LNCONTA3
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PNNUMGRF' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLINHACMB1, LNCONTA1, LLERROR, ORDEM, CCHAVE1S, LNCONTA2, LNCONTA3

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
		Select Distinct Ordem, Crclis ;
		  From TmpResult ;
		Select TmpResult
			Select CrGrafico1
				Select CrGrafico1
				Insert Into CrGrafico1 (cChave1s,cTitulo1s,cTitulo2s,cTitulo3s,cTitulo4s,cEmpresas) ;
					.ControlSource   = 'CrGrafico1.gGrafico1s'
		Select CrGrafico1
	Select CrGrafico1
	Select CrGrafico1
			Select CrGrafico1
			Select CrGrafico1
		Select CrGrafico1
	Select CrGrafico1
	.cntGrf1.oleGrafico1.ControlSource = ''

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReCmg.prg) - TRECHOS RELEVANTES PARA PASS SQL (1533 linhas total):

*-- Linhas 580 a 599:
580:             *-- Popula combo se ainda nao foi populado
581:             IF EMPTY(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount)
582:                 IF USED("TmpResult")
583:                     SELECT DISTINCT Ordem, Crclis ;
584:                       FROM TmpResult ;
585:                      ORDER BY Ordem ;
586:                       INTO ARRAY loc_aClientes
587: 
588:                     loc_nTotal  = ALEN(loc_aClientes, 1)
589:                     loc_nTmStr1 = LEN(ALLTRIM(loc_aClientes(1,2))) + 6
590: 
591:                     WITH THIS.cnt_4c_Grf2.cbo_4c_CmbChave1
592:                         .Clear
593:                         .Alignment         = 0
594:                         .ColumnCount       = 0
595:                         .ColumnLines       = .F.
596:                         .IncrementalSearch = .T.
597:                         .FontName          = "Courier New"
598:                         .FontSize          = 9
599:                         .RowSource         = ""

*-- Linhas 650 a 668:
650:                 loc_cChave2 = THIS.this_oBusinessObject.ObterChaveGrafico(;
651:                     loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)
652: 
653:                 SELECT CrGrafico1
654:                 LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)
655: 
656:                 *-- Configura e exibe OLE
657:                 THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
658: 
659:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
660: 
661:                 ON ERROR &loc_cOnError.
662:             ENDIF
663: 
664:             *-- Atualiza estado dos botoes de navegacao
665:             THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (THIS.pnNumGrf > 1)
666:             THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (THIS.pnNumGrf < 3)
667: 
668:             SET POINT TO loc_cOldPoint

*-- Linhas 693 a 711:
693:             loc_nNlegenda1 = 7
694: 
695:             WITH loc_oOle
696:                 .ControlSource   = "CrGrafico1.gGrafico1s"
697:                 .AutoActivate    = 0
698:                 .AutoSize        = .T.
699:                 .Sizable         = .T.
700:                 .Stretch         = 2
701:                 .HasLegend       = .T.
702:                 .HasTitle        = .F.
703:                 .DisplayBlanksAs = 1
704:                 .HasAxis(2)      = .T.
705:                 .Type            = -4100
706:                 .SubType         = 1
707: 
708:                 WITH .ChartArea
709:                     .Font.Name        = "Arial"
710:                     .Font.Size        = 8
711:                     .Font.Bold        = .T.

*-- Linhas 785 a 813:
785:                                                 (THIS.pnNumGrf * 8 - 7), 8))
786:                                             IF loc_nConta2 = 1
787:                                                 IF USED("TmpResult")
788:                                                     SELECT TmpResult
789:                                                     loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValComp)
790:                                                 ELSE
791:                                                     loc_nVlGrf1 = 0
792:                                                 ENDIF
793:                                             ELSE
794:                                                 loc_cCampValAno = ALLTRIM(SUBSTR("ncompra ordem   " + ;
795:                                                     IIF(par_nQtVal = 1, "nvalano ", "nqtdano "), ;
796:                                                     (THIS.pnNumGrf * 8 - 7), 8))
797:                                                 IF USED("TmpResult")
798:                                                     SELECT TmpResult
799:                                                     loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValAno + ;
800:                                                         ALLTRIM(STR(loc_nConta2 - 1, 20, 0)))
801:                                                 ELSE
802:                                                     loc_nVlGrf1 = 0
803:                                                 ENDIF
804:                                             ENDIF
805:                                             .Top          = .Top - IIF(loc_nVlGrf1 < 0, -10, 10)
806:                                             .Caption      = ALLTRIM(STR(loc_nVlGrf1, 20, 2))
807:                                             .NumberFormat = "###,###,###,##0.00"
808:                                             .Font.Name    = "Arial"
809:                                             .Font.Size    = 8
810:                                             .Font.Bold    = .T.
811:                                             .Font.Shadow  = .F.
812:                                         ENDWITH
813:                                     ENDIF

*-- Linhas 877 a 895:
877:             loc_cChave2    = THIS.this_oBusinessObject.ObterChaveGrafico(;
878:                              loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)
879: 
880:             SELECT CrGrafico1
881:             LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)
882: 
883:             *-- Atualiza exibicao do grafico OLE com a nova posicao
884:             THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
885:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
886: 
887:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
888:             THIS.Refresh()
889:             THIS.LockScreen = .F.
890: 
891:         CATCH TO loc_oErro
892:             THIS.LockScreen = .F.
893:             MsgErro(loc_oErro.Message, "Erro")
894:         ENDTRY
895:     ENDPROC

*-- Linhas 924 a 942:
924:             loc_cChave2    = THIS.this_oBusinessObject.ObterChaveGrafico(;
925:                              loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)
926: 
927:             SELECT CrGrafico1
928:             LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)
929: 
930:             *-- Atualiza exibicao do grafico OLE com a nova posicao
931:             THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
932:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
933: 
934:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
935:             THIS.Refresh()
936:             THIS.LockScreen = .F.
937: 
938:         CATCH TO loc_oErro
939:             THIS.LockScreen = .F.
940:             MsgErro(loc_oErro.Message, "Erro")
941:         ENDTRY
942:     ENDPROC

*-- Linhas 967 a 1021:
967:                 SET PRINTER ON
968: 
969:                 FOR loc_nConta1 = loc_nGrafico TO THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount
970:                     SELECT CrGrafico1
971:                     ZAP
972:                     THIS.GerarGrafico(loc_nConta1)
973:                     THIS.cnt_4c_Aguarde.Visible = .F.
974:                     THIS.LockScreen = .F.
975:                     THIS.cnt_4c_Aguarde.Refresh()
976:                     THIS.LockScreen = .T.
977: 
978:                     SELECT CrGrafico1
979:                     SET ORDER TO ""
980:                     SET ORDER TO pkchave1
981:                     LOCATE
982:                     REPORT FORM SigReCmg TO PRINTER
983:                 ENDFOR
984: 
985:                 SET PRINTER TO DEFAULT
986:             ELSE
987:                 *-- Imprimir apenas o grafico atual com dialogo de impressora
988:                 THIS.cnt_4c_Aguarde.Visible = .F.
989:                 THIS.LockScreen = .F.
990:                 THIS.cnt_4c_Aguarde.Refresh()
991:                 THIS.LockScreen = .T.
992: 
993:                 SELECT CrGrafico1
994:                 SET ORDER TO ""
995:                 SET ORDER TO pkchave1
996: 
997:                 IF THIS.chk_4c_ChkGraficos.Value = 0
998:                     SET KEY TO loc_cChave1
999:                 ENDIF
1000:                 LOCATE
1001: 
1002:                 REPORT FORM SigReCmg TO PRINTER PROMPT NOCONSOLE
1003:             ENDIF
1004: 
1005:             *-- Restaura posicao e exibe grafico da posicao original
1006:             SELECT CrGrafico1
1007:             SET ORDER TO ""
1008:             IF BETWEEN(loc_nRecno1, 1, RECCOUNT("CrGrafico1"))
1009:                 GOTO loc_nRecno1
1010:             ENDIF
1011: 
1012:             THIS.GerarGrafico(loc_nPosic)
1013:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
1014:             THIS.Refresh()
1015:             THIS.LockScreen = .F.
1016: 
1017:         CATCH TO loc_oErro
1018:             THIS.LockScreen = .F.
1019:             THIS.cnt_4c_Aguarde.Visible = .F.
1020:             MsgErro(loc_oErro.Message, "Erro")
1021:         ENDTRY

*-- Linhas 1028 a 1046:
1028:         LOCAL loc_oErro
1029:         TRY
1030:             THIS.LockScreen = .T.
1031:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
1032:             THIS.this_oBusinessObject.FecharCursores()
1033:             THIS.LockScreen = .F.
1034: 
1035:             IF VARTYPE(THIS.poForm1) = "O" AND THIS.poForm1 != THIS
1036:                 THIS.poForm1.LockScreen = .T.
1037:                 THIS.poForm1.Enabled    = .T.
1038:                 THIS.poForm1.LockScreen = .F.
1039:             ENDIF
1040: 
1041:             THIS.Release()
1042: 
1043:         CATCH TO loc_oErro
1044:             THIS.LockScreen = .F.
1045:             MsgErro(loc_oErro.Message, "Erro")
1046:         ENDTRY

*-- Linhas 1090 a 1118:
1090:             USE IN cursor_4c_Dados
1091:         ENDIF
1092:         SET NULL ON
1093:         CREATE CURSOR cursor_4c_Dados (cChave1s C(100), gGrafico1s G, cTitulo1s C(64))
1094:         SET NULL OFF
1095: 
1096:         *-- Voltar para sessao original e criar la tambem
1097:         SET DATASESSION TO (loc_nSessaoAtual)
1098:         IF loc_nSessaoAtual != 1
1099:             IF USED("cursor_4c_Dados")
1100:                 USE IN cursor_4c_Dados
1101:             ENDIF
1102:             SET NULL ON
1103:             CREATE CURSOR cursor_4c_Dados (cChave1s C(100), gGrafico1s G, cTitulo1s C(64))
1104:             SET NULL OFF
1105:         ENDIF
1106: 
1107:         RETURN .T.
1108:     ENDPROC
1109: 
1110:     *==========================================================================
1111:     * FormParaBO - Transfere estado dos controles do form para o BO
1112:     * Sincroniza posicao do grafico, flag de todos os graficos, grafico inicial
1113:     * e chave selecionada no combo. Chamado antes de operacoes do BO.
1114:     *==========================================================================
1115:     PROTECTED PROCEDURE FormParaBO()
1116:         LOCAL loc_nIndex
1117: 
1118:         IF VARTYPE(THIS.this_oBusinessObject) != "O"

*-- Linhas 1244 a 1268:
1244: 
1245:     *==========================================================================
1246:     * LimparCampos - Reseta controles do form para estado inicial
1247:     * Limpa o ControlSource do grafico OLE, reseta combo e checkbox.
1248:     * Chamado ao fechar ou reabrir o form com novos dados.
1249:     *==========================================================================
1250:     PROTECTED PROCEDURE LimparCampos()
1251:         IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
1252:            PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
1253:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
1254:         ENDIF
1255: 
1256:         IF PEMSTATUS(THIS, "cnt_4c_Grf2", 5) AND ;
1257:            PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
1258:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 0
1259:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
1260:         ENDIF
1261: 
1262:         IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5)
1263:             THIS.chk_4c_ChkGraficos.Value = 0
1264:         ENDIF
1265: 
1266:         IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
1267:             THIS.txt_4c_NumGraficos.Value = 1
1268:         ENDIF

*-- Linhas 1425 a 1443:
1425:         TRY
1426:             IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
1427:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
1428:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
1429:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
1430:             ENDIF
1431:         CATCH TO loc_oErro
1432:             MsgErro(loc_oErro.Message, "Erro BtnExcluir")
1433:         ENDTRY
1434:     ENDPROC
1435: 
1436:     *==========================================================================
1437:     * AtualizarEstadoControles - Sincroniza estado dos controles com posicao
1438:     * atual do grafico. Chamado apos navegacao (Anterior/Proximo/Alternar).
1439:     *==========================================================================
1440:     PROCEDURE AtualizarEstadoControles()
1441:         THIS.AjustarBotoesPorModo()
1442:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1443:             THIS.this_oBusinessObject.this_nNumGrafico = THIS.pnNumGrf

*-- Linhas 1495 a 1513:
1495:                              loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)
1496: 
1497:             IF USED("CrGrafico1")
1498:                 SELECT CrGrafico1
1499:                 LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)
1500:             ENDIF
1501: 
1502:             *-- Atualiza exibicao do grafico OLE na nova posicao
1503:             THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
1504:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
1505: 
1506:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
1507:             THIS.Refresh()
1508:             THIS.LockScreen = .F.
1509: 
1510:         CATCH TO loc_oErro
1511:             THIS.LockScreen = .F.
1512:             MsgErro(loc_oErro.Message, "Erro AlternarPagina")
1513:         ENDTRY


### BO (C:\4c\projeto\app\classes\SigReCmgBO.prg):
*==============================================================================
* SigReCmgBO.prg
* Business Object: Grafico Clientes que Mais Compram (SIGRECMG)
* Herda de: BusinessBase
* Tipo: OPERACIONAL - subformulario de exibicao de grafico
* Sem tabela direta (dados vem de TmpResult do formulario pai)
*==============================================================================

DEFINE CLASS SigReCmgBO AS BusinessBase

    *-- Identificacao
    this_cTabela          = ""
    this_cCampoChave      = ""

    *-- Estado do grafico
    this_nNumGrafico      = 0      && Posicao atual do grafico exibido (1-3)
    this_lTodosGraficos   = .F.    && Imprimir todos os graficos em sequencia
    this_nInicioGrafico   = 1      && Grafico inicial para impressao em lote
    this_cChaveAtual      = ""     && Chave selecionada no combo (ordem + nome cliente)

    *-- Titulos do grafico (lidos de TmpResult ao gerar cada grafico)
    this_cTitulo1         = ""
    this_cTitulo2         = ""
    this_cTitulo3         = ""
    this_cTitulo4         = ""
    this_cEmpresaGrafico  = ""

    *==========================================================================
    * Init - Inicializa o BO sem tabela direta (form operacional)
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Obrigatorio para sistema de auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cChaveAtual
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Atualizar - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * InicializarCursorGrafico - Cria cursor CrGrafico1 se nao existe
    * Estrutura IDENTICA ao original (BeforeOpenTables/mGeraGrafico)
    *==========================================================================
    PROCEDURE InicializarCursorGrafico()
        IF !USED("CrGrafico1")
            SET NULL ON
            CREATE CURSOR CrGrafico1 (;
                gGrafico1s G(4),;
                cChave1s   C(100),;
                cEmpresas  C(128),;
                cTitulo1s  C(64),;
                cTitulo2s  C(64),;
                cTitulo3s  C(64),;
                cTitulo4s  C(64))
            SET NULL OFF
            INDEX ON cChave1s TAG pkchave1
        ENDIF
    ENDPROC

    *==========================================================================
    * ZerarCursorGrafico - Limpa CrGrafico1 para regerar graficos
    *==========================================================================
    PROCEDURE ZerarCursorGrafico()
        IF USED("CrGrafico1")
            SELECT CrGrafico1
            ZAP
        ENDIF
    ENDPROC

    *==========================================================================
    * FecharCursores - Fecha cursores locais do grafico
    *==========================================================================
    PROCEDURE FecharCursores()
        IF USED("CrGrafico1")
            USE IN CrGrafico1
        ENDIF
    ENDPROC

    *==========================================================================
    * BuscarClientesTmpResult - Busca clientes distintos de TmpResult
    * Popula par_aClientes com [Ordem, Crclis] ordenado por Ordem
    * Retorna numero de clientes encontrados (0 se TmpResult nao existe)
    *==========================================================================
    PROCEDURE BuscarClientesTmpResult(par_aClientes)
        LOCAL loc_nTotal, loc_oErro
        loc_nTotal = 0

        TRY
            IF USED("TmpResult")
                SELECT DISTINCT Ordem, Crclis ;
                  FROM TmpResult ;
                 ORDER BY Ordem ;
                  INTO ARRAY par_aClientes

                loc_nTotal = ALEN(par_aClientes, 1)
                THIS.this_cChaveAtual = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * ObterTitulosGrafico - Le titulos e empresa de TmpResult pela chave
    * par_cChave1 = item do combo (5 chars ordem + separador + nome cliente)
    * Popula this_cTitulo1..4 e this_cEmpresaGrafico
    *==========================================================================
    PROCEDURE ObterTitulosGrafico(par_cChave1)
        LOCAL loc_nOrdem, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_nOrdem = VAL(LEFT(par_cChave1, 5))

            IF USED("TmpResult")
                SELECT TmpResult
                SET ORDER TO ""
                LOCATE FOR TmpResult.ordem = loc_nOrdem

                IF !EOF()
                    THIS.this_cTitulo1        = ALLTRIM(TmpResult.cTitulo1s)
                    THIS.this_cTitulo2        = ALLTRIM(TmpResult.cTitulo2s)
                    THIS.this_cTitulo3        = ALLTRIM(TmpResult.cTitulo3s)
                    THIS.this_cTitulo4        = ALLTRIM(TmpResult.cTitulo4s)
                    THIS.this_cEmpresaGrafico = ALLTRIM(TmpResult.cEmpresas)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PrepararDadosGrafico - Prepara e insere dados no CrGrafico1
    * par_cChave2     = chave composta (chave1 + nome do eixo para o grafico N)
    * par_nContaGrafico = 1, 2 ou 3
    * par_nQtVal      = 1=Valor, 2=Quantidade (do OptionGroup Opt_SelRel do pai)
    * par_cStrgeixoY  = string do eixo Y com 3 nomes de 10 chars cada
    * Retorna .T. se CrGrafico1 preparado (novo ou ja existente)
    *==========================================================================
    PROCEDURE PrepararDadosGrafico(par_cChave2, par_nContaGrafico, par_nQtVal, par_cStrgeixoY)
        LOCAL loc_lResultado, loc_cStrg1, loc_cStrg2, loc_nVlGrf1
        LOCAL loc_cStrgeixoX, loc_nNlegenda1, loc_nConta2, loc_oErro
        LOCAL loc_cCampValComp, loc_cCampValAno
        loc_lResultado = .F.

        TRY
            THIS.InicializarCursorGrafico()

            *-- Verifica se o grafico ja foi gerado para esta chave
            SELECT CrGrafico1
            LOCATE FOR CrGrafico1.cChave1s = PADR(par_cChave2, 100)

            IF !EOF()
                loc_lResultado = .T.
            ELSE
                IF USED("TmpResult")
                    *-- Titulo do eixo X (nome do tipo de grafico)
                    loc_cStrg1 = CHR(9) + PROPER(ALLTRIM(SUBSTR(par_cStrgeixoY, (par_nContaGrafico * 10 - 9), 10)))

                    *-- Campos conforme tipo Valor/Quantidade
                    loc_cCampValComp = ALLTRIM(SUBSTR("ncomprasordem   " + IIF(par_nQtVal = 1, "nvalcomp", "nqtde   "), (par_nContaGrafico * 8 - 7), 8))
                    loc_cCampValAno  = ALLTRIM(SUBSTR("ncompra ordem   " + IIF(par_nQtVal = 1, "nvalano ", "nqtdano "), (par_nContaGrafico * 8 - 7), 8))

                    *-- Linha geral (total do ranking)
                    loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValComp)
                    loc_cStrg2  = "Geral" + CHR(9) + ;
                                  ALLTRIM(TRANSFORM(IIF(par_nContaGrafico = 2, TmpResult.MaxOrdem - loc_nVlGrf1 + 1, loc_nVlGrf1), "999,999,999,999")) + ;
                                  CHR(13) + CHR(10)

                    *-- Linhas por ano (ate 7 anos)
                    loc_cStrgeixoX = TmpResult.cStrAno1s
                    loc_nNlegenda1 = 7

                    FOR loc_nConta2 = 1 TO loc_nNlegenda1
                        IF !EMPTY(SUBSTR(loc_cStrgeixoX, (loc_nConta2 * 4 - 3), 4))
                            loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValAno + ALLTRIM(STR(loc_nConta2, 20, 0)))
                            loc_cStrg2  = loc_cStrg2 + ;
                                          PROPER(ALLTRIM(SUBSTR(loc_cStrgeixoX, (loc_nConta2 * 4 - 3), 4))) + ;
                                          CHR(9) + ;
                                          ALLTRIM(TRANSFORM(IIF(par_nContaGrafico = 2, TmpResult.MaxOrdem - loc_nVlGrf1 + 1, loc_nVlGrf1), "999,999,999,999")) + ;
                                          CHR(13) + CHR(10)
                        ENDIF
                    ENDFOR

                    *-- Insere estrutura no CrGrafico1 com titulos e dados OLE
                    SELECT CrGrafico1
                    INSERT INTO CrGrafico1 (cChave1s, cTitulo1s, cTitulo2s, cTitulo3s, cTitulo4s, cEmpresas) ;
                        VALUES (par_cChave2, THIS.this_cTitulo1, THIS.this_cTitulo2, ;
                                THIS.this_cTitulo3, THIS.this_cTitulo4, THIS.this_cEmpresaGrafico)
                    APPEND GENERAL gGrafico1s CLASS "MSGraph.Chart" DATA (loc_cStrg1 + CHR(13) + CHR(10) + loc_cStrg2)

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * NavGraficoAnterior - Decrementa posicao do grafico (minimo 1)
    * Retorna o numero atual apos decremento
    *==========================================================================
    PROCEDURE NavGraficoAnterior()
        THIS.this_nNumGrafico = MAX(1, THIS.this_nNumGrafico - 1)
        RETURN THIS.this_nNumGrafico
    ENDPROC

    *==========================================================================
    * NavGraficoProximo - Incrementa posicao do grafico (maximo 3)
    * Retorna o numero atual apos incremento
    *==========================================================================
    PROCEDURE NavGraficoProximo()
        THIS.this_nNumGrafico = MIN(3, THIS.this_nNumGrafico + 1)
        RETURN THIS.this_nNumGrafico
    ENDPROC

    *==========================================================================
    * ObterChaveGrafico - Monta chave composta para lookup em CrGrafico1
    * par_cChave1 = item do combo (ordem + separador + cliente)
    * par_nContaGrafico = 1, 2 ou 3
    * par_cStrgeixoY = string do eixo Y (30 chars = 3 nomes de 10)
    *==========================================================================
    PROCEDURE ObterChaveGrafico(par_cChave1, par_nContaGrafico, par_cStrgeixoY)
        RETURN par_cChave1 + SUBSTR(par_cStrgeixoY, (par_nContaGrafico * 10 - 9), 10)
    ENDPROC

ENDDEFINE

