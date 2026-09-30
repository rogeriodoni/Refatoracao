# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1147: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg) - TRECHOS RELEVANTES PARA PASS GRID (2187 linhas total):

*-- Linhas 35 a 53:
35: * FASE 7/8: Eventos principais dos botoes ja construidos - Processar
36: * (THIS.ProcessarTitulos(), transcrito de PROCEDURE processamento do
37: * legado), Encerrar, Marcar/Desmarcar Tudo (Page1), e o "round-trip" da
38: * Page2: grade de titulos (grd_4c_Titulos, 8 colunas + DynamicForeColor
39: * para EndErro), Marcar/Desmarcar Tudo dos titulos, checkbox individual
40: * (guard EndErro=1, equivalente ao Column1.Check1.When do legado) e Voltar
41: * (cmd_4c_Encerrar de Page2, que reaproveita o Caption/Picture "Encerrar"
42: * do legado mas volta para o filtro, nao fecha o form). O aviso de
43: * endereco longo (Say2/Botao1) foi reposicionado para LOGO ABAIXO do grupo
44: * "Protestar apos" (regra #11/#39 - a faixa do cabecalho ocupa o lugar que
45: * ele tinha no legado).
46: *
47: * FASE 8/8: obj_4c_Comandos (Commandgroup1 no legado - Gerar CNAB/
48: * Relatorio/Boleto) adicionado em cnt_4c_BotoesAcao da Page2, com os 3
49: * Click handlers (BtnGerarCnabClick/BtnRelatorioCnabClick/BtnBoletoClick)
50: * e ExecutarReportForm (Pattern #117). A geracao do arquivo CNAB (dispatch
51: * por banco do convenio - Brasil/Itau/Bradesco/Santander240 - layouts
52: * Brasil6/Itau240/Santander eram DEAD CODE no legado, nunca chamados por
53: * nenhum botao nem pelo dispatcher, e por isso nao foram portados) e o

*-- Linhas 586 a 659:
586:         IF USED("cursor_4c_Operacoes")
587:             USE IN cursor_4c_Operacoes
588:         ENDIF
589:         SET NULL ON
590:         CREATE CURSOR cursor_4c_Operacoes (Dopes C(20) NULL, Marca L NULL)
591:         SET NULL OFF
592: 
593:         *-- Grade de selecao de operacoes (grdope no legado, Pagina Filtro)
594:         loc_oPag.AddObject("grd_4c_Operacoes", "Grid")
595:         loc_oGrid = loc_oPag.grd_4c_Operacoes
596:         WITH loc_oGrid
597:             .Top               = 261
598:             .Left              = 350
599:             .Width             = 202
600:             .Height            = 344
601:             .FontName          = "Tahoma"
602:             .AllowHeaderSizing = .F.
603:             .AllowRowSizing    = .F.
604:             .DeleteMark        = .F.
605:             .RecordMark        = .F.
606:             .GridLines         = 3
607:             .GridLineColor     = RGB(238,238,238)
608:             .ScrollBars        = 2
609:             .Themes            = .F.
610:             .ColumnCount       = 2
611:             .RecordSource      = "cursor_4c_Operacoes"
612: 
613:             *-- Limpa o ControlSource auto-atribuido pelo Grid (por default ele
614:             *-- liga Column1 ao 1o campo do cursor - Dopes, Character) ANTES de
615:             *-- adicionar o CheckBox, senao o VFP tenta sincronizar o .Value do
616:             *-- controle novo com um campo Character e estoura "Data type
617:             *-- mismatch" (regra #18: AddObject/CurrentControl SEMPRE antes do
618:             *-- ControlSource definitivo).
619:             .Column1.ControlSource = ""
620:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
621:             .Column1.CurrentControl = "chk_4c_Marca"
622:             WITH .Column1.chk_4c_Marca
623:                 .Caption   = ""
624:                 .BackColor = RGB(255,255,255)
625:             ENDWITH
626: 
627:             .Column1.ControlSource  = "cursor_4c_Operacoes.Marca"
628:             .Column2.ControlSource  = "cursor_4c_Operacoes.Dopes"
629: 
630:             *-- Largura/legenda reaplicadas DEPOIS do RecordSource/ControlSource
631:             *-- (ambos resetam Column.Width e Header1.Caption - Problema 48)
632:             .Column1.Width          = 18
633:             .Column1.Movable        = .F.
634:             .Column1.Resizable      = .F.
635:             .Column1.Sparse         = .F.
636:             .Column1.ReadOnly       = .F.
637:             .Column1.Header1.Caption = ""
638: 
639:             .Column2.Width          = 150
640:             .Column2.Movable        = .F.
641:             .Column2.Resizable      = .F.
642:             .Column2.ReadOnly       = .T.
643:             .Column2.Header1.Alignment = 2
644:             .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
645:         ENDWITH
646:     ENDPROC
647: 
648:     *==========================================================================
649:     * ConfigurarPaginaDados - Estrutura base da Page2 (Dados)
650:     * Fase 5/8: faixa do cabecalho (regra #11 - nas DUAS paginas, PRIMEIRO
651:     * AddObject da pagina) + primeiros 50% dos campos "principais" de
652:     * pgdados (Say12/spndias/Say1 - "Protestar apos <N> dias", que ja tem
653:     * property no BO: this_nDiasProtesto). O aviso de endereco longo
654:     * (Say2/Botao1), a grade de titulos (grdope, 8 colunas) e os botoes de
655:     * acao (cmdTestaPos/Commandgroup1/Commandgroup2) ficam para a Fase 6.
656:     *==========================================================================
657:     PROTECTED PROCEDURE ConfigurarPaginaDados()
658:         LOCAL loc_oPag, loc_oCab, loc_oGridTit
659: 

*-- Linhas 918 a 966:
918:         IF USED("cursor_4c_Titulos")
919:             USE IN cursor_4c_Titulos
920:         ENDIF
921:         SET NULL ON
922:         CREATE CURSOR cursor_4c_Titulos (Marca L NULL, Titulos C(10) NULL, Dopes C(20) NULL, ;
923:             Numes N(6,0) NULL, RClis C(50) NULL, Vencs T NULL, Fpags C(12) NULL, Valos N(11,2) NULL, ;
924:             Datas T NULL, Vpags N(11,2) NULL, IClis C(10) NULL, Endes C(60) NULL, Cidas C(30) NULL, ;
925:             Estas C(2) NULL, Nums C(10) NULL, Compls C(50) NULL, Bairs C(40) NULL, Ceps C(9) NULL, ;
926:             Cpfs C(20) NULL, Emps C(3) NULL, EmpDopNums C(29) NULL, Nopers N(7,0) NULL, Razaos C(50) NULL, ;
927:             EndCobs C(80) NULL, CepCobs C(9) NULL, EstCobs C(2) NULL, BaiCobs C(20) NULL, CidCobs C(20) NULL, ;
928:             EndErro N(1,0) NULL)
929:         SET NULL OFF
930: 
931:         *-- Grade de titulos em aberto (grdope no legado, Pagina Dados) - 8
932:         *-- colunas. ColumnOrder visual segue o legado (Column8 "Titulo"
933:         *-- aparece logo apos o checkbox - regra #35b: a grade espelha a
934:         *-- estrutura do legado, nao a ordem de criacao das colunas).
935:         loc_oPag.AddObject("grd_4c_Titulos", "Grid")
936:         loc_oGridTit = loc_oPag.grd_4c_Titulos
937:         WITH loc_oGridTit
938:             .Top               = 180
939:             .Left              = 7
940:             .Width             = 981
941:             .Height            = 382
942:             .FontName          = "Tahoma"
943:             .AllowHeaderSizing = .F.
944:             .AllowRowSizing    = .F.
945:             .DeleteMark        = .F.
946:             .RecordMark        = .F.
947:             .GridLineColor     = RGB(238,238,238)
948:             .ScrollBars        = 2
949:             .Themes            = .F.
950:             .ColumnCount       = 8
951:             .RecordSource      = "cursor_4c_Titulos"
952: 
953:             *-- Limpa o ControlSource auto-atribuido pelo Grid ANTES de
954:             *-- adicionar o CheckBox (regra #18).
955:             .Column1.ControlSource = ""
956:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
957:             .Column1.CurrentControl = "chk_4c_Marca"
958:             WITH .Column1.chk_4c_Marca
959:                 .Caption   = ""
960:                 .BackColor = RGB(255,255,255)
961:             ENDWITH
962: 
963:             .Column1.ControlSource = "cursor_4c_Titulos.Marca"
964:             .Column2.ControlSource = "cursor_4c_Titulos.Dopes"
965:             .Column3.ControlSource = "cursor_4c_Titulos.Numes"
966:             .Column4.ControlSource = "cursor_4c_Titulos.RClis"

*-- Linhas 974 a 997:
974:             .Column1.Resizable       = .F.
975:             .Column1.Sparse         = .F.
976:             .Column1.ReadOnly        = .F.
977:             .Column1.Header1.Caption = ""
978:         ENDWITH
979: 
980:         *-- Largura/legenda/ordem reaplicadas DEPOIS do RecordSource/
981:         *-- ControlSource (Problema 48 - ambos resetam Column.Width e
982:         *-- Header1.Caption).
983:         THIS.FormatarGridTitulos(loc_oGridTit)
984: 
985:         *-- Container Marcar/Desmarcar Tudo dos titulos (Commandgroup2 no
986:         *-- legado, pgdados) - mesmo padrao visual do cnt_4c_Marca da
987:         *-- Pagina Filtro.
988:         loc_oPag.AddObject("cnt_4c_Marca", "Container")
989:         WITH loc_oPag.cnt_4c_Marca
990:             .Top         = 570
991:             .Left        = 7
992:             .Width       = 92
993:             .Height      = 50
994:             .BackStyle   = 0
995:             .BorderWidth = 0
996: 
997:             .AddObject("cmd_4c_MarcarTudo", "CommandButton")

*-- Linhas 1030 a 1115:
1030:     *==========================================================================
1031:     * FormatarGridTitulos - Reaplica largura/legenda/ordem/cor dinamica das
1032:     * colunas da grade de titulos. Chamado apos QUALQUER atribuicao de
1033:     * RecordSource/ControlSource (Problema 48 - ambos resetam Column.Width e
1034:     * Header1.Caption): uma vez na estrutura inicial (ConfigurarPaginaDados)
1035:     * e de novo apos o SQLEXEC real (THIS.ProcessarTitulos).
1036:     *==========================================================================
1037:     PROTECTED PROCEDURE FormatarGridTitulos(par_oGrid)
1038:         WITH par_oGrid
1039:             .Column1.Width           = 16
1040:             .Column1.Movable         = .F.
1041:             .Column1.Resizable       = .F.
1042:             .Column1.Sparse          = .F.
1043:             .Column1.ReadOnly        = .F.
1044:             .Column1.ColumnOrder     = 1
1045:             .Column1.Header1.Caption = ""
1046: 
1047:             .Column2.Width             = 150
1048:             .Column2.Movable           = .F.
1049:             .Column2.Resizable         = .F.
1050:             .Column2.ReadOnly          = .T.
1051:             .Column2.ColumnOrder       = 3
1052:             .Column2.Header1.Alignment = 2
1053:             .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1054: 
1055:             .Column3.Width             = 52
1056:             .Column3.Movable           = .F.
1057:             .Column3.Resizable         = .F.
1058:             .Column3.ReadOnly          = .T.
1059:             .Column3.ColumnOrder       = 4
1060:             .Column3.Header1.Alignment = 2
1061:             .Column3.Header1.Caption   = "C" + CHR(243) + "digo"
1062: 
1063:             .Column4.Width             = 400
1064:             .Column4.Movable           = .F.
1065:             .Column4.Resizable         = .F.
1066:             .Column4.ReadOnly          = .T.
1067:             .Column4.ColumnOrder       = 5
1068:             .Column4.Header1.Alignment = 2
1069:             .Column4.Header1.Caption   = "Cliente"
1070: 
1071:             .Column5.Width             = 72
1072:             .Column5.Movable           = .F.
1073:             .Column5.Resizable         = .F.
1074:             .Column5.ReadOnly          = .T.
1075:             .Column5.ColumnOrder       = 6
1076:             .Column5.Header1.Alignment = 2
1077:             .Column5.Header1.Caption   = "Vencimento"
1078: 
1079:             .Column6.Width             = 87
1080:             .Column6.Movable           = .F.
1081:             .Column6.Resizable         = .F.
1082:             .Column6.ReadOnly          = .T.
1083:             .Column6.ColumnOrder       = 7
1084:             .Column6.Header1.Alignment = 2
1085:             .Column6.Header1.Caption   = "Forma Pagto"
1086: 
1087:             .Column7.Width             = 100
1088:             .Column7.Movable           = .F.
1089:             .Column7.Resizable         = .F.
1090:             .Column7.ReadOnly          = .T.
1091:             .Column7.ColumnOrder       = 8
1092:             .Column7.Header1.Alignment = 2
1093:             .Column7.Header1.Caption   = "Valor"
1094: 
1095:             .Column8.Movable           = .F.
1096:             .Column8.Resizable         = .F.
1097:             .Column8.ReadOnly          = .T.
1098:             .Column8.ColumnOrder       = 2
1099:             .Column8.Header1.Alignment = 2
1100:             .Column8.Header1.Caption   = "T" + CHR(237) + "tulo"
1101: 
1102:             .SetAll("DynamicForeColor", "IIF(cursor_4c_Titulos.EndErro = 1, RGB(255,0,0), RGB(0,0,0))", "Column")
1103:         ENDWITH
1104:     ENDPROC
1105: 
1106:     *==========================================================================
1107:     * CarregarOperacoes - Popula cursor_4c_Operacoes com as operacoes (SigCdOpe)
1108:     * elegiveis para o processo de CNAB (Parcontas=1 e ValPends=1), igual ao
1109:     * legado (Init: "select dopes, ?lltru as marca from SigCdOpe where
1110:     * Parcontas = 1 And ValPends = 1 order by dopes", com lltru=.F.).
1111:     * Cursor eh READWRITE porque a Coluna1 do grid eh um CheckBox editavel
1112:     * (marca/desmarca operacao) - SQLEXEC devolve cursor somente-leitura.
1113:     *==========================================================================
1114:     PROTECTED PROCEDURE CarregarOperacoes()
1115:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

*-- Linhas 1133 a 1163:
1133:                 ENDIF
1134: 
1135:                 SELECT * FROM cursor_4c_OperacoesTmp INTO CURSOR cursor_4c_Operacoes READWRITE
1136: 
1137:                 IF USED("cursor_4c_OperacoesTmp")
1138:                     USE IN cursor_4c_OperacoesTmp
1139:                 ENDIF
1140: 
1141:                 IF RECCOUNT("cursor_4c_Operacoes") > 0
1142:                     SELECT cursor_4c_Operacoes
1143:                     GO TOP
1144:                 ENDIF
1145: 
1146:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.ColumnCount = 3
1147:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.RecordSource = "cursor_4c_Operacoes"
1148:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1149: 
1150:                 loc_lSucesso = .T.
1151:             ELSE
1152:                 MostrarErro("Erro ao carregar as opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1153:                             CapturarErroSQL(), "Erro SQL")
1154:             ENDIF
1155:         CATCH TO loc_oErro
1156:             MostrarErro(loc_oErro.Message + CHR(13) + ;
1157:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1158:                         "Procedure: " + loc_oErro.Procedure, "Erro CarregarOperacoes")
1159:         ENDTRY
1160: 
1161:         RETURN loc_lSucesso
1162:     ENDPROC
1163: 

*-- Linhas 1203 a 1221:
1203:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Encerrar,   "Click", THIS, "BtnVoltarClick")
1204:         BINDEVENT(loc_oPag2.cnt_4c_Marca.cmd_4c_MarcarTudo,      "Click", THIS, "BtnMarcarTudoTitulosClick")
1205:         BINDEVENT(loc_oPag2.cnt_4c_Marca.cmd_4c_DesmarcarTudo,   "Click", THIS, "BtnDesmarcarTudoTitulosClick")
1206:         BINDEVENT(loc_oPag2.grd_4c_Titulos.Column1.chk_4c_Marca, "Click", THIS, "ChkTituloMarcaClick")
1207: 
1208:         *-- obj_4c_Comandos (Commandgroup1 no legado: btncnab/btnrelatorio/btnBoleto)
1209:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(1), "Click", THIS, "BtnGerarCnabClick")
1210:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(2), "Click", THIS, "BtnRelatorioCnabClick")
1211:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3), "Click", THIS, "BtnBoletoClick")
1212:     ENDPROC
1213: 
1214:     *==========================================================================
1215:     * BtnProcessarClick - cmdTestaPos.btnProcessar.Click no legado. Valida
1216:     * Empresa/Periodo/Conta obrigatorios e exige ao menos 1 operacao marcada
1217:     * antes de consultar os titulos em aberto.
1218:     *==========================================================================
1219:     PROCEDURE BtnProcessarClick()
1220:         LOCAL loc_oPag, loc_nCont
1221: 

*-- Linhas 1271 a 1299:
1271:             LOCATE
1272:             GO TOP
1273:         ENDIF
1274:         THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1275:     ENDPROC
1276: 
1277:     PROCEDURE BtnDesmarcarTudoClick()
1278:         IF USED("cursor_4c_Operacoes")
1279:             SELECT cursor_4c_Operacoes
1280:             REPLACE ALL Marca WITH .F.
1281:             LOCATE
1282:             GO TOP
1283:         ENDIF
1284:         THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1285:     ENDPROC
1286: 
1287:     *==========================================================================
1288:     * ProcessarTitulos - PROCEDURE processamento no legado. Monta a lista de
1289:     * operacoes marcadas + consulta os titulos em aberto (SigMvPar/SigOpFp/
1290:     * SigMvCab/SigCdCli/SigMvCcr), populando cursor_4c_Titulos (READWRITE -
1291:     * a coluna Marca eh CheckBox editavel no grid). Formula/filtros
1292:     * TRANSCRITOS literalmente do legado (regra CLAUDE.md #17) - inclusive a
1293:     * ausencia de filtro pela conta/carteira na consulta (o legado le
1294:     * get_cd_car_conta so para validar preenchimento, e aplica a conta
1295:     * apenas na geracao do CNAB, fase 8).
1296:     *==========================================================================
1297:     PROTECTED PROCEDURE ProcessarTitulos()
1298:         LOCAL loc_oPag, loc_cListaOperacoes, loc_cEmpresa, loc_dIni, loc_dFim, loc_nPeriodo, ;
1299:               loc_lNaoProcessados, loc_cCampoData, loc_cNotIn, loc_cSQL, loc_nResultado, ;

*-- Linhas 1374 a 1394:
1374:                     REPLACE ALL Marca WITH .F. FOR EndErro = 1
1375:                     GO TOP
1376: 
1377:                     loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos
1378:                     loc_oGrid.ColumnCount = 8
1379:                     loc_oGrid.RecordSource         = "cursor_4c_Titulos"
1380:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Titulos.Marca"
1381:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Titulos.Dopes"
1382:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Titulos.Numes"
1383:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Titulos.RClis"
1384:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Titulos.Vencs"
1385:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Titulos.Fpags"
1386:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Titulos.Valos"
1387:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Titulos.Titulos"
1388:                     THIS.FormatarGridTitulos(loc_oGrid)
1389:                     loc_oGrid.Refresh()
1390: 
1391:                     THIS.pgf_4c_Paginas.Page1.Enabled = .F.
1392:                     THIS.pgf_4c_Paginas.Page2.Enabled = .T.
1393: 
1394:                     *-- cmdTestaPos.btnBoleto.Enabled = !llNPr no legado (linha

*-- Linhas 1415 a 1484:
1415: 
1416:     *==========================================================================
1417:     * BtnVoltarClick - cmdTestaPos.btnsair.Click (Pagina Dados) no legado:
1418:     * limpa o RecordSource do grid, reabilita o filtro e volta para a Lista.
1419:     *==========================================================================
1420:     PROCEDURE BtnVoltarClick()
1421:         LOCAL loc_oGrid
1422:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos
1423:         loc_oGrid.RecordSource = ""
1424:         loc_oGrid.Refresh()
1425: 
1426:         THIS.pgf_4c_Paginas.Page1.Enabled = .T.
1427:         THIS.pgf_4c_Paginas.Page2.Enabled = .F.
1428:         THIS.AlternarPagina(1)
1429:     ENDPROC
1430: 
1431:     *==========================================================================
1432:     * BtnMarcarTudoTitulosClick/BtnDesmarcarTudoTitulosClick - Commandgroup2.
1433:     * btnmarca/btndesmarca.Click (Pagina Dados) no legado - marca/desmarca
1434:     * TODOS os titulos, sem excecao pelo EndErro (igual ao legado - o
1435:     * "Marcar Tudo" bypassa o guard do checkbox individual).
1436:     *==========================================================================
1437:     PROCEDURE BtnMarcarTudoTitulosClick()
1438:         IF USED("cursor_4c_Titulos")
1439:             SELECT cursor_4c_Titulos
1440:             REPLACE ALL Marca WITH .T.
1441:             LOCATE
1442:             GO TOP
1443:         ENDIF
1444:         THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1445:     ENDPROC
1446: 
1447:     PROCEDURE BtnDesmarcarTudoTitulosClick()
1448:         IF USED("cursor_4c_Titulos")
1449:             SELECT cursor_4c_Titulos
1450:             REPLACE ALL Marca WITH .F.
1451:             LOCATE
1452:             GO TOP
1453:         ENDIF
1454:         THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1455:     ENDPROC
1456: 
1457:     *==========================================================================
1458:     * ChkTituloMarcaClick - Column1.Check1.When no legado (Return
1459:     * crFiltro.EndErro = 0): titulo com endereco muito longo nao pode ser
1460:     * selecionado. O nativo do CheckBox ja alterna Marca no clique; aqui so
1461:     * revertemos quando a linha estiver marcada como EndErro=1.
1462:     *==========================================================================
1463:     PROCEDURE ChkTituloMarcaClick()
1464:         IF USED("cursor_4c_Titulos") AND !EOF("cursor_4c_Titulos")
1465:             IF cursor_4c_Titulos.EndErro = 1 AND cursor_4c_Titulos.Marca
1466:                 REPLACE cursor_4c_Titulos.Marca WITH .F.
1467:                 MsgAviso("Este t" + CHR(237) + "tulo tem endere" + CHR(231) + "o com mais de 40 caracteres e n" + CHR(227) + "o pode ser selecionado.", ;
1468:                          "Aten" + CHR(231) + CHR(227) + "o")
1469:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1470:             ENDIF
1471:         ENDIF
1472:     ENDPROC
1473: 
1474:     *==========================================================================
1475:     * ExecutarReportForm (Pattern #117) - executa REPORT FORM com guard
1476:     * IF FILE() + isolamento de locale (SET POINT/SEPARATOR) + REPORTBEHAVIOR
1477:     * 80 durante o REPORT FORM. par_cModo: "PREVIEW" | "PRINTER_PROMPT".
1478:     * par_cCursorDados: opcional - se informado e cursor estiver vazio/
1479:     * inexistente, mostra MsgAviso e retorna .F. sem abrir preview vazio.
1480:     *==========================================================================
1481:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
1482:         LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
1483: 
1484:         loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

*-- Linhas 1778 a 1797:
1778:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1779:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1780:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1781:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1782:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1783:                     loc_oBusca.Show()
1784:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
1785:                         SELECT cursor_4c_BuscaEmpresa
1786:                         loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1787:                         loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
1788:                     ENDIF
1789:                     loc_oBusca.Release()
1790:                 ENDIF
1791:             ENDIF
1792:         CATCH TO loc_oErro
1793:             MsgErro(loc_oErro.Message, "Erro")
1794:         ENDTRY
1795: 
1796:         IF USED("cursor_4c_BuscaEmpresa")
1797:             USE IN cursor_4c_BuscaEmpresa

*-- Linhas 1975 a 1994:
1975:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1976:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1977:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1978:                     loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1979:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1980:                     loc_oBusca.Show()
1981:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1982:                         SELECT cursor_4c_BuscaConta
1983:                         loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1984:                         loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1985:                     ENDIF
1986:                     loc_oBusca.Release()
1987:                 ENDIF
1988:             ENDIF
1989:         CATCH TO loc_oErro
1990:             MsgErro(loc_oErro.Message, "Erro")
1991:         ENDTRY
1992: 
1993:         IF USED("cursor_4c_BuscaConta")
1994:             USE IN cursor_4c_BuscaConta

*-- Linhas 2095 a 2113:
2095:                     loc_oBusca.this_cTitulo        = loc_cTitulo
2096:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
2097:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
2098:                     loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
2099:                     loc_oBusca.Show()
2100:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTituloBanco")
2101:                         SELECT cursor_4c_BuscaTituloBanco
2102:                         loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_BuscaTituloBanco.Fpags)
2103:                     ENDIF
2104:                     loc_oBusca.Release()
2105:                 ENDIF
2106:             ENDIF
2107:         CATCH TO loc_oErro
2108:             MsgErro(loc_oErro.Message, "Erro")
2109:         ENDTRY
2110: 
2111:         IF USED("cursor_4c_BuscaTituloBanco")
2112:             USE IN cursor_4c_BuscaTituloBanco
2113:         ENDIF

*-- Linhas 2157 a 2187:
2157:         loc_oP1.lbl_4c_TituloBanco.Visible                     = .T.
2158:         loc_oP1.txt_4c_TituloBanco.Visible                     = .T.
2159:         loc_oP1.lbl_4c_Operacao.Visible                        = .T.
2160:         loc_oP1.grd_4c_Operacoes.Visible                       = .T.
2161: 
2162:         loc_oP2 = THIS.pgf_4c_Paginas.Page2
2163:         loc_oP2.cnt_4c_Cabecalho.Visible                       = .T.
2164:         loc_oP2.cnt_4c_Cabecalho.lbl_4c_Sombra.Visible         = .T.
2165:         loc_oP2.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible         = .T.
2166:         loc_oP2.cnt_4c_BotoesAcao.Visible                      = .T.
2167:         loc_oP2.cnt_4c_BotoesAcao.cmd_4c_Encerrar.Visible      = .T.
2168:         loc_oP2.cnt_4c_BotoesAcao.obj_4c_Comandos.Visible      = .T.
2169:         loc_oP2.lbl_4c_Label12.Visible                         = .T.
2170:         loc_oP2.spn_4c_DiasProtesto.Visible                    = .T.
2171:         loc_oP2.lbl_4c_Label1.Visible                          = .T.
2172:         loc_oP2.lbl_4c_AvisoEndereco.Visible                   = .T.
2173:         loc_oP2.txt_4c_AvisoCor.Visible                        = .T.
2174:         loc_oP2.grd_4c_Titulos.Visible                         = .T.
2175:         loc_oP2.cnt_4c_Marca.Visible                           = .T.
2176:         loc_oP2.cnt_4c_Marca.cmd_4c_MarcarTudo.Visible         = .T.
2177:         loc_oP2.cnt_4c_Marca.cmd_4c_DesmarcarTudo.Visible      = .T.
2178:     ENDPROC
2179: 
2180:     *==========================================================================
2181:     * DESTROY - delega para FormBase.Destroy (restaura menu apos fechamento)
2182:     *==========================================================================
2183:     PROCEDURE Destroy()
2184:         RETURN DODEFAULT()
2185:     ENDPROC
2186: 
2187: ENDDEFINE

