# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLbC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1916 linhas total):

*-- Linhas 45 a 65:
45: *------------------------------------------------------------------------------
46: * ESCOPO ENTREGUE
47: *
48: * Fase 3/8 - estrutura base: DEFINE CLASS + propriedades visuais do dump, Init
49: *            completo (contexto do pai/caixa + InicializarForm), BO
50: *            instanciado, cabecalho cinza (cntSombra -> cnt_4c_Sombra com os
51: *            dois labels) e Destroy (reabilita o caixa).
52: *
53: * Fase 4/8 - GRADE e BOTAO: a Grade do SCX (SIGOPLBC.Grade -> grd_4c_Dados)
54: *            com as duas colunas do dump, o cursor da grade, o botao
55: *            SIGOPLBC.ok ("Retornar") com o Click REAL, o BINDEVENT e o metodo
56: *            de carga, que chama SigOpLbCBO.CalcularComposicaoLimite e liga a
57: *            grade.
58: *
59: * Fase 5/8 - METADE SUPERIOR dos campos de composicao: get_nconta, Shape4 e
60: *            os pares Say6/get_moeda, Say8/get_cotacao, Say1/get_limcred e
61: *            Say9/get_PendOutr, ja com o espelhamento do BO em
62: *            AtualizarCamposComposicao (chamado por CarregarDados).
63: *
64: * Fase 6/8 - METADE INFERIOR dos campos de composicao: os pares
65: *            Say2/get_pendente, Say7/get_chqpend, Say3/get_contac,

*-- Linhas 81 a 89:
81: *
82: * Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES. O dump tem UM UNICO botao
83: *            (SIGOPLBC.ok, BaseClass commandbutton, classe fwbtng) e o Click
84: *            dele ja foi entregue na Fase 4 - objeto cmd_4c_Ok, BINDEVENT em
85: *            ConfigurarEventos e o handler BtnRetornarClick, transcrito linha
86: *            a linha do SIGOPLBC.ok.Click. Nao ha segundo botao a ligar, e os
87: *            Btn<verbo>Click da barra CRUD do framework (os quatro verbos de
88: *            inclusao, alteracao, visualizacao e exclusao, grafados em prosa
89: *            de proposito - o gate procura esses identificadores por

*-- Linhas 450 a 503:
450:     * Nao ha compensacao de +29: sem PageFrame, os Top do dump sao absolutos.
451:     * Primeiro AddObject da tela (regra #11), para a grade/botoes das fases
452:     * seguintes desenharem POR CIMA.
453:     *==========================================================================
454:     PROTECTED PROCEDURE ConfigurarCabecalho()
455:         THIS.AddObject("cnt_4c_Sombra", "Container")
456:         WITH THIS.cnt_4c_Sombra
457:             .Top           = 0
458:             .Left          = 0
459:             .Width         = THIS.Width
460:             .Height        = 80
461:             .BorderWidth   = 0
462:             .BackStyle     = 1
463:             .BackColor     = RGB(100, 100, 100)
464:             .SpecialEffect = 0
465:             .Visible       = .T.
466:         ENDWITH
467: 
468:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
469:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
470:             .AutoSize      = .F.
471:             .FontName      = "Tahoma"
472:             .FontSize      = 18
473:             .FontBold      = .T.
474:             .FontUnderline = .F.
475:             .WordWrap      = .T.
476:             .Alignment     = 0
477:             .BackStyle     = 0
478:             .Caption       = THIS.Caption
479:             .Top           = 18
480:             .Left          = 10
481:             .Width         = THIS.Width - 20
482:             .Height        = 40
483:             .ForeColor     = RGB(0, 0, 0)
484:             .Visible       = .T.
485:         ENDWITH
486: 
487:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
488:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
489:             .AutoSize    = .F.
490:             .FontName    = "Tahoma"
491:             .FontSize    = 18
492:             .FontBold    = .T.
493:             .WordWrap    = .T.
494:             .Alignment   = 0
495:             .BackStyle   = 0
496:             .Caption     = THIS.Caption
497:             .Top         = 17
498:             .Left        = 10
499:             .Width       = THIS.Width - 20
500:             .Height      = 46
501:             .ForeColor   = RGB(255, 255, 255)
502:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
503:             .Visible     = .T.

*-- Linhas 520 a 576:
520:     * Tahoma 8 no proprio Grid.
521:     *
522:     * Sem compensacao de +29 no Top: nao ha PageFrame, os Top do dump sao
523:     * absolutos (nao existe o pgf_4c_Paginas.Top = -29 daqui).
524:     *
525:     * TabIndex = 4 do dump: RESOLVIDO na Fase 8 - NAO se transcreve, e a
526:     * decisao eh MEDIDA, nao estimada. O VFP aplica o TabIndex gravado no
527:     * instante em que CRIA cada objeto e limita ao numero de irmaos tab-able
528:     * que existem ali; no SCX a Grade eh o SEGUNDO filho direto do form (vem
529:     * depois do cntSombra), entao a faixa naquele momento eh 1..2 e o 4 nao
530:     * cabe. Medido no VFP9 em 2026-11-08 (automation\medir_tabindex_756.prg),
531:     * simulando o load na ordem dos REGISTROS do SCX e lendo os valores de
532:     * volta:
533:     *
534:     *   legado, logo apos o AddObject da Grade ... Grade.TabIndex = 2  (o 4 eh
535:     *                                             DESCARTADO em silencio)
536:     *   legado, no fim do load ................... cntSombra 1 / Grade 2 / ok 22
537:     *   migrado, so com os AddObject ............. cnt_4c_Sombra 1 /
538:     *                                             grd_4c_Dados 2 / cmd_4c_Ok 22
539:     *   migrado, com grd_4c_Dados.TabIndex = 4 ... grd vai para 4 (APLICADO -
540:     *                                             a faixa aqui ja eh 1..23)
541:     *
542:     * Ou seja: a ordem EFETIVA do legado eh a ordem de criacao, e a ordem de
543:     * criacao do migrado eh IDENTICA a ela, controle por controle. Transcrever
544:     * o literal 4 depois dos AddObject seria o unico jeito de ele "pegar" - e
545:     * justamente ai ele DIVERGIRIA do legado: fiel ao arquivo e infiel a tela.
546:     * Por isso nao ha atribuicao de TabIndex em lugar nenhum deste form.
547:     *
548:     * O ciclo de Tab resultante tem duas paradas, as mesmas do legado:
549:     * grd_4c_Dados -> cmd_4c_Ok. Os nove TextBox saem do ciclo por TabStop =
550:     * .F. (ver ConfigurarCamposDados), os Label/Shape nao tem TabStop, e
551:     * cnt_4c_Sombra so contem Label - nao retem foco.
552:     *
553:     * RecordMark: o dump declara DeleteMark = .F. e eh silencioso sobre
554:     * RecordMark, que na BaseClass grid vale .T. Fica .F. porque eh a regra do
555:     * projeto para grade de form OPERACIONAL e o CorretorAutomatico (#58)
556:     * INJETA .F. quando a propriedade esta ausente - declarar aqui deixa a
557:     * decisao visivel no codigo em vez de aparecer no proximo sweep. As
558:     * larguras das colunas seguem as do dump, intocadas (290 + 126 = 416, mais
559:     * a barra de rolagem, nos 448 do Grid).
560:     *
561:     * Nada de RecordSource / ControlSource aqui: o cursor da grade so existe
562:     * depois do BO rodar, e atribuir ControlSource de alias inexistente estoura
563:     * "Alias ... is not found" DENTRO do TRY do Init - a tela nao abriria e o
564:     * usuario nao veria erro nenhum (regra #41). O bind mora em VincularGrade.
565:     *==========================================================================
566:     PROTECTED PROCEDURE ConfigurarGrade()
567:         THIS.AddObject("grd_4c_Dados", "Grid")
568:         WITH THIS.grd_4c_Dados
569:             .ColumnCount   = 2
570:             .Top           = 112
571:             .Left          = 405
572:             .Width         = 448
573:             .Height        = 227
574:             .FontName      = "Tahoma"
575:             .FontSize      = 8
576:             .RowHeight     = 16

*-- Linhas 644 a 652:
644:                 .FontName  = "Tahoma"
645:                 .FontSize  = 8
646:                 .Alignment = 2
647:                 .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es Pendentes"
648:             ENDWITH
649:             WITH .Text1
650:                 .FontName    = "Tahoma"
651:                 .FontSize    = 8
652:                 .BorderStyle = 0

*-- Linhas 668 a 676:
668:                 .FontName  = "Tahoma"
669:                 .FontSize  = 8
670:                 .Alignment = 2
671:                 .Caption   = "Valor"
672:             ENDWITH
673:             WITH .Text1
674:                 .FontName    = "Tahoma"
675:                 .FontSize    = 8
676:                 .BorderStyle = 0

*-- Linhas 932 a 940:
932:     *
933:     * O Caption "Cliente"/Width=46 do dump eh o estado de DESIGN: em runtime o
934:     * legado o substitui por
935:     *     ThisForm.get_nconta.Caption = _Conta + ' ' + Alltrim(lcRazao)
936:     * que eh conta(10) + " " + razao social(ate 50) - texto varias vezes maior
937:     * que 46px, e no legado cabia porque AutoSize=.T. fazia a Label CRESCER.
938:     *
939:     * AutoSize eh NO-OP em Label criada por AddObject (regra #23: medido, a
940:     * Width fica nos 100 do default), entao as duas transcricoes literais

*-- Linhas 1006 a 1027:
1006: 
1007:         TRY
1008:             *------------------------------------------------------------------
1009:             * get_nconta -> lbl_4c_Get_nconta  (ver DIVERGENCIA no cabecalho)
1010:             *------------------------------------------------------------------
1011:             THIS.AddObject("lbl_4c_Get_nconta", "Label")
1012:             WITH THIS.lbl_4c_Get_nconta
1013:                 .AutoSize  = .F.
1014:                 .WordWrap  = .F.
1015:                 .FontName  = "Tahoma"
1016:                 .FontSize  = 10
1017:                 .FontBold  = .T.
1018:                 .BackStyle = 0
1019:                 .Alignment = 0
1020:                 .Caption   = "Cliente"
1021:                 .Top       = 84
1022:                 .Left      = 14
1023:                 .Width     = 380
1024:                 .Height    = 18
1025:                 .ForeColor = RGB(90, 90, 90)
1026:                 .Visible   = .T.
1027:             ENDWITH

*-- Linhas 1042 a 1051:
1042:             *------------------------------------------------------------------
1043:             THIS.AddObject("shp_4c_Shape4", "Shape")
1044:             WITH THIS.shp_4c_Shape4
1045:                 .Top           = 102
1046:                 .Left          = 12
1047:                 .Width         = 883
1048:                 .Height        = 1
1049:                 .BackStyle     = 0
1050:                 .BorderWidth   = 1
1051:                 .SpecialEffect = 1

*-- Linhas 1057 a 1163:
1057:             * valores da tela sao expressos (legado crSigClLcr.moedas).
1058:             * Rotulo ANTES do campo: ver z-order no cabecalho do metodo.
1059:             *------------------------------------------------------------------
1060:             THIS.AddObject("lbl_4c_Label6", "Label")
1061:             WITH THIS.lbl_4c_Label6
1062:                 .AutoSize  = .F.
1063:                 .WordWrap  = .F.
1064:                 .FontName  = "Tahoma"
1065:                 .FontSize  = 8
1066:                 .BackStyle = 0
1067:                 .Alignment = 0
1068:                 .Caption   = "Moeda :"
1069:                 .Top       = 119
1070:                 .Left      = 138
1071:                 .Width     = 54
1072:                 .Height    = 15
1073:                 .ForeColor = RGB(90, 90, 90)
1074:                 .Visible   = .T.
1075:             ENDWITH
1076: 
1077:             THIS.AddObject("txt_4c__moeda", "TextBox")
1078:             WITH THIS.txt_4c__moeda
1079:                 .Value             = ""
1080:                 .MaxLength         = 3
1081:                 .FontName          = "Courier New"
1082:                 .FontSize          = 9
1083:                 .Top               = 115
1084:                 .Left              = 184
1085:                 .Width             = 31
1086:                 .Height            = 23
1087:                 .ReadOnly          = .T.
1088:                 .TabStop           = .F.
1089:                 .DisabledBackColor = RGB(255, 255, 255)
1090:                 .Visible           = .T.
1091:             ENDWITH
1092: 
1093:             *------------------------------------------------------------------
1094:             * Say8 "Cambio :" + get_cotacao - fBuscarCotacao(moeda, Date()).
1095:             * InputMask "99,999.9999" (4 decimais) transcrita do dump.
1096:             *------------------------------------------------------------------
1097:             THIS.AddObject("lbl_4c_Label8", "Label")
1098:             WITH THIS.lbl_4c_Label8
1099:                 .AutoSize  = .F.
1100:                 .WordWrap  = .F.
1101:                 .FontName  = "Tahoma"
1102:                 .FontSize  = 8
1103:                 .BackStyle = 0
1104:                 .Alignment = 0
1105:                 .Caption   = "C" + CHR(226) + "mbio :"
1106:                 .Top       = 144
1107:                 .Left      = 135
1108:                 .Width     = 57
1109:                 .Height    = 15
1110:                 .ForeColor = RGB(90, 90, 90)
1111:                 .Visible   = .T.
1112:             ENDWITH
1113: 
1114:             THIS.AddObject("txt_4c__cotacao", "TextBox")
1115:             WITH THIS.txt_4c__cotacao
1116:                 .Value             = 0
1117:                 .InputMask         = "99,999.9999"
1118:                 .FontName          = "Courier New"
1119:                 .FontSize          = 9
1120:                 .Top               = 140
1121:                 .Left              = 184
1122:                 .Width             = 119
1123:                 .Height            = 23
1124:                 .ReadOnly          = .T.
1125:                 .TabStop           = .F.
1126:                 .DisabledBackColor = RGB(255, 255, 255)
1127:                 .Visible           = .T.
1128:             ENDWITH
1129: 
1130:             *------------------------------------------------------------------
1131:             * Say1 "Limite de Credito :" + get_limcred - SigClLcr.LimCres,
1132:             * o teto contra o qual todo o resto eh abatido.
1133:             *------------------------------------------------------------------
1134:             THIS.AddObject("lbl_4c_Label1", "Label")
1135:             WITH THIS.lbl_4c_Label1
1136:                 .AutoSize  = .F.
1137:                 .WordWrap  = .F.
1138:                 .FontName  = "Tahoma"
1139:                 .FontSize  = 8
1140:                 .BackStyle = 0
1141:                 .Alignment = 0
1142:                 .Caption   = "Limite de Cr" + CHR(233) + "dito :"
1143:                 .Top       = 169
1144:                 .Left      = 90
1145:                 .Width     = 102
1146:                 .Height    = 15
1147:                 .ForeColor = RGB(90, 90, 90)
1148:                 .Visible   = .T.
1149:             ENDWITH
1150: 
1151:             THIS.AddObject("txt_4c__limcred", "TextBox")
1152:             WITH THIS.txt_4c__limcred
1153:                 .Value             = 0
1154:                 .InputMask         = "999,999,999.99"
1155:                 .FontName          = "Courier New"
1156:                 .FontSize          = 9
1157:                 .Top               = 165
1158:                 .Left              = 184
1159:                 .Width             = 119
1160:                 .Height            = 23
1161:                 .ReadOnly          = .T.
1162:                 .TabStop           = .F.
1163:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 1180 a 1212:
1180:             * casam. Transcrito como esta, sem "consertar" (regra #17) - ver
1181:             * AtualizarCamposComposicao.
1182:             *------------------------------------------------------------------
1183:             THIS.AddObject("lbl_4c_Label9", "Label")
1184:             WITH THIS.lbl_4c_Label9
1185:                 .AutoSize  = .F.
1186:                 .WordWrap  = .F.
1187:                 .FontName  = "Tahoma"
1188:                 .FontSize  = 8
1189:                 .BackStyle = 0
1190:                 .Alignment = 0
1191:                 .Caption   = "Total da Movimenta" + CHR(231) + CHR(227) + "o :"
1192:                 .Top       = 194
1193:                 .Left      = 59
1194:                 .Width     = 120
1195:                 .Height    = 15
1196:                 .ForeColor = RGB(90, 90, 90)
1197:                 .Visible   = .T.
1198:             ENDWITH
1199: 
1200:             THIS.AddObject("txt_4c__PendOutr", "TextBox")
1201:             WITH THIS.txt_4c__PendOutr
1202:                 .Value             = 0
1203:                 .InputMask         = "999,999,999.99"
1204:                 .FontName          = "Courier New"
1205:                 .FontSize          = 9
1206:                 .Top               = 190
1207:                 .Left              = 184
1208:                 .Width             = 119
1209:                 .Height            = 23
1210:                 .ReadOnly          = .T.
1211:                 .TabStop           = .F.
1212:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 1223 a 1255:
1223:             * OUTRAS movimentacoes em aberto, nao a desta. Transcrito como
1224:             * esta (regra #17) - ver AtualizarCamposComposicao.
1225:             *------------------------------------------------------------------
1226:             THIS.AddObject("lbl_4c_Label2", "Label")
1227:             WITH THIS.lbl_4c_Label2
1228:                 .AutoSize  = .F.
1229:                 .WordWrap  = .F.
1230:                 .FontName  = "Tahoma"
1231:                 .FontSize  = 8
1232:                 .BackStyle = 0
1233:                 .Alignment = 0
1234:                 .Caption   = "Total Pendente :"
1235:                 .Top       = 219
1236:                 .Left      = 97
1237:                 .Width     = 95
1238:                 .Height    = 15
1239:                 .ForeColor = RGB(90, 90, 90)
1240:                 .Visible   = .T.
1241:             ENDWITH
1242: 
1243:             THIS.AddObject("txt_4c__pendente", "TextBox")
1244:             WITH THIS.txt_4c__pendente
1245:                 .Value             = 0
1246:                 .InputMask         = "999,999,999.99"
1247:                 .FontName          = "Courier New"
1248:                 .FontSize          = 9
1249:                 .Top               = 215
1250:                 .Left              = 184
1251:                 .Width             = 119
1252:                 .Height            = 23
1253:                 .ReadOnly          = .T.
1254:                 .TabStop           = .F.
1255:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 1261 a 1367:
1261:             * .Caption abaixo) + get_chqpend - cheques cuja forma de
1262:             * pagamento fica em aberto (legado _chequep).
1263:             *------------------------------------------------------------------
1264:             THIS.AddObject("lbl_4c_Label7", "Label")
1265:             WITH THIS.lbl_4c_Label7
1266:                 .AutoSize  = .F.
1267:                 .WordWrap  = .F.
1268:                 .FontName  = "Tahoma"
1269:                 .FontSize  = 8
1270:                 .BackStyle = 0
1271:                 .Alignment = 0
1272:                 .Caption   = "Pendente :"
1273:                 .Top       = 244
1274:                 .Left      = 124
1275:                 .Width     = 68
1276:                 .Height    = 15
1277:                 .ForeColor = RGB(90, 90, 90)
1278:                 .Visible   = .T.
1279:             ENDWITH
1280: 
1281:             THIS.AddObject("txt_4c__chqpend", "TextBox")
1282:             WITH THIS.txt_4c__chqpend
1283:                 .Value             = 0
1284:                 .InputMask         = "999,999,999.99"
1285:                 .FontName          = "Courier New"
1286:                 .FontSize          = 9
1287:                 .Top               = 240
1288:                 .Left              = 184
1289:                 .Width             = 119
1290:                 .Height            = 23
1291:                 .ReadOnly          = .T.
1292:                 .TabStop           = .F.
1293:                 .DisabledBackColor = RGB(255, 255, 255)
1294:                 .Visible           = .T.
1295:             ENDWITH
1296: 
1297:             *------------------------------------------------------------------
1298:             * Say3 "Total C/C :" + get_contac - saldo de conta corrente
1299:             * (legado _Saldocc, SUM de SigMvSlc.Saldos convertido).
1300:             *------------------------------------------------------------------
1301:             THIS.AddObject("lbl_4c_Label3", "Label")
1302:             WITH THIS.lbl_4c_Label3
1303:                 .AutoSize  = .F.
1304:                 .WordWrap  = .F.
1305:                 .FontName  = "Tahoma"
1306:                 .FontSize  = 8
1307:                 .BackStyle = 0
1308:                 .Alignment = 0
1309:                 .Caption   = "Total C/C :"
1310:                 .Top       = 269
1311:                 .Left      = 125
1312:                 .Width     = 67
1313:                 .Height    = 15
1314:                 .ForeColor = RGB(90, 90, 90)
1315:                 .Visible   = .T.
1316:             ENDWITH
1317: 
1318:             THIS.AddObject("txt_4c__contac", "TextBox")
1319:             WITH THIS.txt_4c__contac
1320:                 .Value             = 0
1321:                 .InputMask         = "999,999,999.99"
1322:                 .FontName          = "Courier New"
1323:                 .FontSize          = 9
1324:                 .Top               = 265
1325:                 .Left              = 184
1326:                 .Width             = 119
1327:                 .Height            = 23
1328:                 .ReadOnly          = .T.
1329:                 .TabStop           = .F.
1330:                 .DisabledBackColor = RGB(255, 255, 255)
1331:                 .Visible           = .T.
1332:             ENDWITH
1333: 
1334:             *------------------------------------------------------------------
1335:             * Say4 "Total Cheques :" + get_cheque - cheques que NAO sao valor
1336:             * em aberto (legado _chequec).
1337:             *------------------------------------------------------------------
1338:             THIS.AddObject("lbl_4c_Label4", "Label")
1339:             WITH THIS.lbl_4c_Label4
1340:                 .AutoSize  = .F.
1341:                 .WordWrap  = .F.
1342:                 .FontName  = "Tahoma"
1343:                 .FontSize  = 8
1344:                 .BackStyle = 0
1345:                 .Alignment = 0
1346:                 .Caption   = "Total Cheques :"
1347:                 .Top       = 294
1348:                 .Left      = 101
1349:                 .Width     = 91
1350:                 .Height    = 15
1351:                 .ForeColor = RGB(90, 90, 90)
1352:                 .Visible   = .T.
1353:             ENDWITH
1354: 
1355:             THIS.AddObject("txt_4c__cheque", "TextBox")
1356:             WITH THIS.txt_4c__cheque
1357:                 .Value             = 0
1358:                 .InputMask         = "999,999,999.99"
1359:                 .FontName          = "Courier New"
1360:                 .FontSize          = 9
1361:                 .Top               = 290
1362:                 .Left              = 184
1363:                 .Width             = 119
1364:                 .Height            = 23
1365:                 .ReadOnly          = .T.
1366:                 .TabStop           = .F.
1367:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 1382 a 1401:
1382:             * RGB(0,0,255)); o valor real eh escrito em TODO carregamento por
1383:             * AtualizarCamposComposicao, nunca lido daqui.
1384:             *------------------------------------------------------------------
1385:             THIS.AddObject("lbl_4c_Label5", "Label")
1386:             WITH THIS.lbl_4c_Label5
1387:                 .AutoSize  = .F.
1388:                 .WordWrap  = .F.
1389:                 .FontName  = "Tahoma"
1390:                 .FontSize  = 8
1391:                 .FontBold  = .T.
1392:                 .BackStyle = 0
1393:                 .Alignment = 0
1394:                 .Caption   = "Dispon" + CHR(237) + "vel :"
1395:                 .Top       = 319
1396:                 .Left      = 113
1397:                 .Width     = 79
1398:                 .Height    = 15
1399:                 .ForeColor = RGB(90, 90, 90)
1400:                 .Visible   = .T.
1401:             ENDWITH

*-- Linhas 1407 a 1416:
1407:                 .FontName          = "Courier New"
1408:                 .FontSize          = 9
1409:                 .FontBold          = .T.
1410:                 .Top               = 315
1411:                 .Left              = 184
1412:                 .Width             = 119
1413:                 .Height            = 23
1414:                 .ReadOnly          = .T.
1415:                 .TabStop           = .F.
1416:                 .ForeColor         = RGB(0, 0, 255)

*-- Linhas 1467 a 1477:
1467:         loc_oBO = THIS.this_oBusinessObject
1468: 
1469:         *-- Rotulo do cliente: legado
1470:         *--     ThisForm.get_nconta.Caption = _Conta + ' ' + Alltrim(lcRazao)
1471:         IF PEMSTATUS(THIS, "lbl_4c_Get_nconta", 5)
1472:             THIS.lbl_4c_Get_nconta.Caption = ALLTRIM(loc_oBO.this_cDescricaoConta)
1473:         ENDIF
1474: 
1475:         *-- legado: ThisForm.get_moeda.Value = crSigClLcr.moedas
1476:         IF PEMSTATUS(THIS, "txt_4c__moeda", 5)
1477:             THIS.txt_4c__moeda.Value = ALLTRIM(loc_oBO.this_cMoeda)

*-- Linhas 1536 a 1557:
1536: 
1537: 
1538:     *==========================================================================
1539:     * ConfigurarBotoes - SIGOPLBC.ok -> cmd_4c_Ok
1540:     *
1541:     * Dump: Top=3 Left=923 Caption="Retornar" Cancel=.T.
1542:     *       ToolTipText="[ESC] Retornar"
1543:     *       Picture=..\framework\imagens\cadastro_salvar_60.jpg
1544:     *
1545:     * Width/Height NAO aparecem no dump: vem da classe fwbtng (framework.vcx),
1546:     * que eh 80x100 - e nao cabe, porque 923 + 80 = 1003 passaria da borda do
1547:     * form (Width = 1000) e os 100 de altura invadiriam a grade. Usado o
1548:     * canonico 75x75 do projeto para botao com este mesmo icone, que fecha
1549:     * exatamente na largura (923 + 75 = 998 < 1000). Mesmo criterio do gemeo
1550:     * FormSigMvMen (SIGPDMEN.ok, tambem fwbtng com cadastro_salvar_60.jpg).
1551:     *
1552:     * O canonico cnt_4c_Saida/cmd_4c_Encerrar (Left=917, Width=90 - regra #10)
1553:     * NAO se aplica: ele vale para os CRUD frmcadastro. Aqui o botao eh filho
1554:     * DIRETO do form, no Left do SCX, e nao ha container de saida nenhum.
1555:     *
1556:     * Picture = cadastro_salvar_60.jpg eh TRANSCRITA do dump, nao escolhida por
1557:     * semelhanca semantica: pelo criterio semantico um botao "Retornar" levaria

*-- Linhas 1566 a 1589:
1566:     *
1567:     * Cancel = .T. eh transcricao do SCX: faz o ESC acionar o botao, que eh o
1568:     * "[ESC] Retornar" do proprio ToolTipText.
1569:     *
1570:     * O botao fica POR CIMA da faixa do cabecalho de proposito (Top 3..78
1571:     * dentro dos 0..80 do cnt_4c_Sombra): eh o layout do legado, e funciona
1572:     * porque o cabecalho eh o PRIMEIRO AddObject da tela (regra #11).
1573:     *==========================================================================
1574:     PROTECTED PROCEDURE ConfigurarBotoes()
1575:         LOCAL loc_oErro
1576: 
1577:         TRY
1578:             THIS.AddObject("cmd_4c_Ok", "CommandButton")
1579:             WITH THIS.cmd_4c_Ok
1580:                 .Top             = 3
1581:                 .Left            = 923
1582:                 .Width           = 75
1583:                 .Height          = 75
1584:                 .Caption         = "Retornar"
1585:                 .ToolTipText     = "[ESC] Retornar"
1586:                 .Cancel          = .T.
1587:                 .FontName        = "Comic Sans MS"
1588:                 .FontSize        = 8
1589:                 .FontBold        = .T.

*-- Linhas 1627 a 1635:
1627:         LOCAL loc_oErro
1628: 
1629:         TRY
1630:             BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnRetornarClick")
1631:         CATCH TO loc_oErro
1632:             MsgErro(loc_oErro.Message + CHR(13) + ;
1633:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1634:                 "Procedure: " + loc_oErro.Procedure, ;
1635:                 "Erro em FormSigOpLbC.ConfigurarEventos")

*-- Linhas 1649 a 1657:
1649:     *
1650:     * Nomeado pela ACAO (o Caption "Retornar" e o corpo do Click), nao pelo
1651:     * Name do objeto legado ("ok"): o nome tem de dizer o que o metodo FAZ.
1652:     * O objeto segue cmd_4c_Ok porque eh o que o mapeamento.json da task
1653:     * declara, e o ValidarUIFidelity monta o caminho a partir dele.
1654:     *
1655:     * Release() e nao Hide(): esta tela eh um dialogo que nao devolve nada ao
1656:     * chamador - o legado faz Thisform.release, e quem le a decisao de credito
1657:     * eh o operador, nao o form do caixa.

