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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReCmg.prg) - TRECHOS RELEVANTES PARA PASS SQL (1541 linhas total):

*-- Linhas 581 a 600:
581:             *-- Popula combo se ainda nao foi populado
582:             IF EMPTY(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount)
583:                 IF USED("TmpResult")
584:                     SELECT DISTINCT Ordem, Crclis ;
585:                       FROM TmpResult ;
586:                      ORDER BY Ordem ;
587:                       INTO ARRAY loc_aClientes
588: 
589:                     loc_nTotal  = ALEN(loc_aClientes, 1)
590:                     loc_nTmStr1 = LEN(ALLTRIM(loc_aClientes(1,2))) + 6
591: 
592:                     WITH THIS.cnt_4c_Grf2.cbo_4c_CmbChave1
593:                         .Clear
594:                         .Alignment         = 0
595:                         .ColumnCount       = 0
596:                         .ColumnLines       = .F.
597:                         .IncrementalSearch = .T.
598:                         .FontName          = "Courier New"
599:                         .FontSize          = 9
600:                         .RowSource         = ""

*-- Linhas 651 a 669:
651:                 loc_cChave2 = THIS.this_oBusinessObject.ObterChaveGrafico(;
652:                     loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)
653: 
654:                 SELECT CrGrafico1
655:                 LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)
656: 
657:                 *-- Configura e exibe OLE
658:                 THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
659: 
660:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
661: 
662:                 ON ERROR &loc_cOnError.
663:             ENDIF
664: 
665:             *-- Atualiza estado dos botoes de navegacao
666:             THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (THIS.pnNumGrf > 1)
667:             THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (THIS.pnNumGrf < 3)
668: 
669:             SET POINT TO loc_cOldPoint

*-- Linhas 694 a 712:
694:             loc_nNlegenda1 = 7
695: 
696:             WITH loc_oOle
697:                 .ControlSource   = "CrGrafico1.gGrafico1s"
698:                 .AutoActivate    = 0
699:                 .AutoSize        = .T.
700:                 .Sizable         = .T.
701:                 .Stretch         = 2
702:                 .HasLegend       = .T.
703:                 .HasTitle        = .F.
704:                 .DisplayBlanksAs = 1
705:                 .HasAxis(2)      = .T.
706:                 .Type            = -4100
707:                 .SubType         = 1
708: 
709:                 WITH .ChartArea
710:                     .Font.Name        = "Arial"
711:                     .Font.Size        = 8
712:                     .Font.Bold        = .T.

*-- Linhas 786 a 814:
786:                                                 (THIS.pnNumGrf * 8 - 7), 8))
787:                                             IF loc_nConta2 = 1
788:                                                 IF USED("TmpResult")
789:                                                     SELECT TmpResult
790:                                                     loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValComp)
791:                                                 ELSE
792:                                                     loc_nVlGrf1 = 0
793:                                                 ENDIF
794:                                             ELSE
795:                                                 loc_cCampValAno = ALLTRIM(SUBSTR("ncompra ordem   " + ;
796:                                                     IIF(par_nQtVal = 1, "nvalano ", "nqtdano "), ;
797:                                                     (THIS.pnNumGrf * 8 - 7), 8))
798:                                                 IF USED("TmpResult")
799:                                                     SELECT TmpResult
800:                                                     loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValAno + ;
801:                                                         ALLTRIM(STR(loc_nConta2 - 1, 20, 0)))
802:                                                 ELSE
803:                                                     loc_nVlGrf1 = 0
804:                                                 ENDIF
805:                                             ENDIF
806:                                             .Top          = .Top - IIF(loc_nVlGrf1 < 0, -10, 10)
807:                                             .Caption      = ALLTRIM(STR(loc_nVlGrf1, 20, 2))
808:                                             .NumberFormat = "###,###,###,##0.00"
809:                                             .Font.Name    = "Arial"
810:                                             .Font.Size    = 8
811:                                             .Font.Bold    = .T.
812:                                             .Font.Shadow  = .F.
813:                                         ENDWITH
814:                                     ENDIF

*-- Linhas 880 a 898:
880:             loc_cChave2    = THIS.this_oBusinessObject.ObterChaveGrafico(;
881:                              loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)
882: 
883:             SELECT CrGrafico1
884:             LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)
885: 
886:             *-- Atualiza exibicao do grafico OLE com a nova posicao
887:             THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
888:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
889: 
890:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
891:             THIS.Draw()
892:             THIS.Refresh()
893:             THIS.LockScreen = .F.
894: 
895:         CATCH TO loc_oErro
896:             THIS.LockScreen = .F.
897:             MsgErro(loc_oErro.Message, "Erro")
898:         ENDTRY

*-- Linhas 928 a 946:
928:             loc_cChave2    = THIS.this_oBusinessObject.ObterChaveGrafico(;
929:                              loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)
930: 
931:             SELECT CrGrafico1
932:             LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)
933: 
934:             *-- Atualiza exibicao do grafico OLE com a nova posicao
935:             THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
936:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
937: 
938:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
939:             THIS.Draw()
940:             THIS.Refresh()
941:             THIS.LockScreen = .F.
942: 
943:         CATCH TO loc_oErro
944:             THIS.LockScreen = .F.
945:             MsgErro(loc_oErro.Message, "Erro")
946:         ENDTRY

*-- Linhas 973 a 1029:
973:                 SET PRINTER ON
974: 
975:                 FOR loc_nConta1 = loc_nGrafico TO THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount
976:                     SELECT CrGrafico1
977:                     ZAP
978:                     THIS.GerarGrafico(loc_nConta1)
979:                     THIS.cnt_4c_Aguarde.Visible = .F.
980:                     THIS.Draw()
981:                     THIS.LockScreen = .F.
982:                     THIS.cnt_4c_Aguarde.Refresh()
983:                     THIS.LockScreen = .T.
984: 
985:                     SELECT CrGrafico1
986:                     SET ORDER TO ""
987:                     SET ORDER TO pkchave1
988:                     LOCATE
989:                     REPORT FORM SigReCmg TO PRINTER
990:                 ENDFOR
991: 
992:                 SET PRINTER TO DEFAULT
993:             ELSE
994:                 *-- Imprimir apenas o grafico atual com dialogo de impressora
995:                 THIS.cnt_4c_Aguarde.Visible = .F.
996:                 THIS.Draw()
997:                 THIS.LockScreen = .F.
998:                 THIS.cnt_4c_Aguarde.Refresh()
999:                 THIS.LockScreen = .T.
1000: 
1001:                 SELECT CrGrafico1
1002:                 SET ORDER TO ""
1003:                 SET ORDER TO pkchave1
1004: 
1005:                 IF THIS.chk_4c_ChkGraficos.Value = 0
1006:                     SET KEY TO loc_cChave1
1007:                 ENDIF
1008:                 LOCATE
1009: 
1010:                 REPORT FORM SigReCmg TO PRINTER PROMPT NOCONSOLE
1011:             ENDIF
1012: 
1013:             *-- Restaura posicao e exibe grafico da posicao original
1014:             SELECT CrGrafico1
1015:             SET ORDER TO ""
1016:             IF BETWEEN(loc_nRecno1, 1, RECCOUNT("CrGrafico1"))
1017:                 GOTO loc_nRecno1
1018:             ENDIF
1019: 
1020:             THIS.GerarGrafico(loc_nPosic)
1021:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
1022:             THIS.Refresh()
1023:             THIS.Draw()
1024:             THIS.LockScreen = .F.
1025: 
1026:         CATCH TO loc_oErro
1027:             THIS.LockScreen = .F.
1028:             THIS.cnt_4c_Aguarde.Visible = .F.
1029:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1037 a 1055:
1037:         LOCAL loc_oErro
1038:         TRY
1039:             THIS.LockScreen = .T.
1040:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
1041:             THIS.this_oBusinessObject.FecharCursores()
1042:             THIS.LockScreen = .F.
1043: 
1044:             IF VARTYPE(THIS.poForm1) = "O" AND THIS.poForm1 != THIS
1045:                 THIS.poForm1.LockScreen = .T.
1046:                 THIS.poForm1.Enabled    = .T.
1047:                 THIS.poForm1.LockScreen = .F.
1048:             ENDIF
1049: 
1050:             THIS.Release()
1051: 
1052:         CATCH TO loc_oErro
1053:             THIS.LockScreen = .F.
1054:             MsgErro(loc_oErro.Message, "Erro")
1055:         ENDTRY

*-- Linhas 1098 a 1124:
1098:         IF USED("cursor_4c_Dados")
1099:             USE IN cursor_4c_Dados
1100:         ENDIF
1101:         CREATE CURSOR cursor_4c_Dados (cChave1s C(100), gGrafico1s G, cTitulo1s C(64))
1102: 
1103:         *-- Voltar para sessao original e criar la tambem
1104:         SET DATASESSION TO (loc_nSessaoAtual)
1105:         IF loc_nSessaoAtual != 1
1106:             IF USED("cursor_4c_Dados")
1107:                 USE IN cursor_4c_Dados
1108:             ENDIF
1109:             CREATE CURSOR cursor_4c_Dados (cChave1s C(100), gGrafico1s G, cTitulo1s C(64))
1110:         ENDIF
1111: 
1112:         RETURN .T.
1113:     ENDPROC
1114: 
1115:     *==========================================================================
1116:     * FormParaBO - Transfere estado dos controles do form para o BO
1117:     * Sincroniza posicao do grafico, flag de todos os graficos, grafico inicial
1118:     * e chave selecionada no combo. Chamado antes de operacoes do BO.
1119:     *==========================================================================
1120:     PROTECTED PROCEDURE FormParaBO()
1121:         LOCAL loc_nIndex
1122: 
1123:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1124:             RETURN

*-- Linhas 1249 a 1273:
1249: 
1250:     *==========================================================================
1251:     * LimparCampos - Reseta controles do form para estado inicial
1252:     * Limpa o ControlSource do grafico OLE, reseta combo e checkbox.
1253:     * Chamado ao fechar ou reabrir o form com novos dados.
1254:     *==========================================================================
1255:     PROTECTED PROCEDURE LimparCampos()
1256:         IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
1257:            PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
1258:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
1259:         ENDIF
1260: 
1261:         IF PEMSTATUS(THIS, "cnt_4c_Grf2", 5) AND ;
1262:            PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
1263:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 0
1264:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
1265:         ENDIF
1266: 
1267:         IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5)
1268:             THIS.chk_4c_ChkGraficos.Value = 0
1269:         ENDIF
1270: 
1271:         IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
1272:             THIS.txt_4c_NumGraficos.Value = 1
1273:         ENDIF

*-- Linhas 1432 a 1450:
1432:         TRY
1433:             IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
1434:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
1435:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
1436:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
1437:             ENDIF
1438:         CATCH TO loc_oErro
1439:             MsgErro(loc_oErro.Message, "Erro BtnExcluir")
1440:         ENDTRY
1441:     ENDPROC
1442: 
1443:     *==========================================================================
1444:     * AtualizarEstadoControles - Sincroniza estado dos controles com posicao
1445:     * atual do grafico. Chamado apos navegacao (Anterior/Proximo/Alternar).
1446:     *==========================================================================
1447:     PROCEDURE AtualizarEstadoControles()
1448:         THIS.AjustarBotoesPorModo()
1449:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1450:             THIS.this_oBusinessObject.this_nNumGrafico = THIS.pnNumGrf

*-- Linhas 1502 a 1520:
1502:                              loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)
1503: 
1504:             IF USED("CrGrafico1")
1505:                 SELECT CrGrafico1
1506:                 LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)
1507:             ENDIF
1508: 
1509:             *-- Atualiza exibicao do grafico OLE na nova posicao
1510:             THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
1511:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
1512: 
1513:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
1514:             THIS.Draw()
1515:             THIS.Refresh()
1516:             THIS.LockScreen = .F.
1517: 
1518:         CATCH TO loc_oErro
1519:             THIS.LockScreen = .F.
1520:             MsgErro(loc_oErro.Message, "Erro AlternarPagina")


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

