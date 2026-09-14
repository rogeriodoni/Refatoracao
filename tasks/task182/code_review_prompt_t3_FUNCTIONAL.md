# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_DETALHE, CNT_4C_DETALHE2, CNT_4C_DETALHE3, CNT_4C_DETALHE4, CNT_4C_DETALHE5, CNT_4C_RESUMO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).
- [LAYOUT-POSITION] Controle 'Detalhe' (parent: SIGPRFEM.Resultado): Left original=336 vs migrado 'cnt_4c_Detalhe' Left=9 (diff=327px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Resumo' (parent: SIGPRFEM.Resultado): Top original=184 vs migrado 'cnt_4c_Resumo' Top=4 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Resumo' (parent: SIGPRFEM.Resultado): Left original=659 vs migrado 'cnt_4c_Resumo' Left=7 (diff=652px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'detalhe3' (parent: SIGPRFEM.Resultado): Top original=184 vs migrado 'cnt_4c_Detalhe3' Top=4 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'detalhe4' (parent: SIGPRFEM.Resultado): Top original=184 vs migrado 'cnt_4c_Detalhe4' Top=4 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'detalhe4' (parent: SIGPRFEM.Resultado): Left original=336 vs migrado 'cnt_4c_Detalhe4' Left=9 (diff=327px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'detalhe5' (parent: SIGPRFEM.Resultado): Left original=659 vs migrado 'cnt_4c_Detalhe5' Left=9 (diff=650px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1811 linhas total):

*-- Linhas 1 a 21:
1: *==============================================================================
2: * FormSigPrFem.prg - An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o
3: * Herda de: FormBase
4: * Tipo: OPERACIONAL (sem CRUD principal)
5: * Original: SIGPRFEM.SCX (Width=1000, Height=600, TitleBar=0)
6: * Layout: cnt_4c_Cabecalho + campos (DataI/DataF/Demonstrativo) + 4 botoes
7: *          + cnt_4c_Resultado (5 grades de detalhe + Resumo de totalizadores)
8: *==============================================================================
9: 
10: DEFINE CLASS FormSigPrFem AS FormBase
11: 
12:     *-- Dimensoes exatas do original
13:     Width        = 1000
14:     Height       = 600
15:     AutoCenter   = .T.
16:     TitleBar     = 0
17:     ShowWindow = 1
18:     WindowType = 1
19:     ControlBox   = .F.
20:     Closable     = .F.
21:     MaxButton    = .F.

*-- Linhas 30 a 154:
30:     this_oBusinessObject = .NULL.
31: 
32:     *==========================================================================
33:     * Init - Chama FormBase.Init que invoca InicializarForm
34:     *==========================================================================
35:     PROCEDURE Init()
36:         RETURN DODEFAULT()
37:     ENDPROC
38: 
39:     *==========================================================================
40:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
41:     *==========================================================================
42:     PROTECTED PROCEDURE InicializarForm()
43:         LOCAL loc_lSucesso, loc_oErro
44:         loc_lSucesso = .F.
45: 
46:         TRY
47:             SET DATE TO BRITISH
48:             SET CENTURY ON
49: 
50:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
51: 
52:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrFemBO")
53: 
54:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
55: 
56:                 THIS.ConfigurarPageFrame()
57: 
58:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
59:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
60: 
61:                 THIS.TornarControlesVisiveis(THIS)
62: 
63:                 THIS.cnt_4c_Resultado.Visible                 = .F.
64:                 THIS.cnt_4c_Resultado.cnt_4c_Detalhe.Visible  = .F.
65:                 THIS.cnt_4c_Resultado.cnt_4c_Detalhe2.Visible = .F.
66:                 THIS.cnt_4c_Resultado.cnt_4c_Detalhe3.Visible = .F.
67:                 THIS.cnt_4c_Resultado.cnt_4c_Detalhe4.Visible = .F.
68:                 THIS.cnt_4c_Resultado.cnt_4c_Detalhe5.Visible = .F.
69: 
70:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
71:                     THIS.this_oBusinessObject.CarregarCursoresReferencia()
72:                     THIS.this_oBusinessObject.CriarCursoresTrabalho()
73:                 ENDIF
74: 
75:                 BINDEVENT(THIS.txt_4c_Demonstrativo, "KeyPress", THIS, "DemonstrativoKeyPress")
76:                 BINDEVENT(THIS.txt_4c_Demonstrativo, "DblClick", THIS, "AbrirLookupDemonstrativo")
77:                 BINDEVENT(THIS.cmd_4c_Processar,     "Click",    THIS, "CmdProcessarClick")
78:                 BINDEVENT(THIS.cmd_4c_Visualizar,    "Click",    THIS, "CmdVisualizarClick")
79:                 BINDEVENT(THIS.cmd_4c_Imprimir,      "Click",    THIS, "CmdImprimirClick")
80:                 BINDEVENT(THIS.cmd_4c_Encerrar,      "Click",    THIS, "CmdEncerrarClick")
81: 
82:                 loc_lSucesso = .T.
83:             ELSE
84:                 MsgErro("Erro ao criar SigPrFemBO.", ;
85:                     "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
86:             ENDIF
87: 
88:         CATCH TO loc_oErro
89:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + ;
90:                 "] [PROC=" + loc_oErro.Procedure + "]", ;
91:                 "Erro em InicializarForm")
92:         ENDTRY
93: 
94:         RETURN loc_lSucesso
95:     ENDPROC
96: 
97:     *==========================================================================
98:     * ConfigurarPageFrame - Orquestrador do layout
99:     *==========================================================================
100:     PROTECTED PROCEDURE ConfigurarPageFrame()
101:         THIS.ConfigurarCabecalho()
102:         THIS.ConfigurarPaginaLista()
103:         THIS.ConfigurarPaginaDados()
104:     ENDPROC
105: 
106:     *-- Compatibilidade com contrato FormBase (OPERACIONAL nao usa PageFrame real)
107:     PROCEDURE AlternarPagina(par_nPagina)
108:         RETURN
109:     ENDPROC
110: 
111:     *==========================================================================
112:     * ConfigurarCabecalho - Equivalente ao cntSombra do legado
113:     *==========================================================================
114:     PROTECTED PROCEDURE ConfigurarCabecalho()
115:         LOCAL loc_cCaption
116:         loc_cCaption = "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o"
117: 
118:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH THIS.cnt_4c_Cabecalho
120:             .Top         = 0
121:             .Left        = 0
122:             .Width       = THIS.Width
123:             .Height      = 80
124:             .BackStyle   = 1
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127: 
128:             .AddObject("lbl_4c_Sombra", "Label")
129:             WITH .lbl_4c_Sombra
130:                 .AutoSize  = .F.
131:                 .Top       = 18
132:                 .Left      = 10
133:                 .Width     = THIS.Width
134:                 .Height    = 40
135:                 .BackStyle = 0
136:                 .FontBold  = .T.
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 18
139:                 .ForeColor = RGB(0, 0, 0)
140:                 .WordWrap  = .T.
141:                 .Alignment = 0
142:                 .Caption   = loc_cCaption
143:             ENDWITH
144: 
145:             .AddObject("lbl_4c_Titulo", "Label")
146:             WITH .lbl_4c_Titulo
147:                 .AutoSize  = .F.
148:                 .Top       = 17
149:                 .Left      = 10
150:                 .Width     = THIS.Width
151:                 .Height    = 46
152:                 .BackStyle = 0
153:                 .FontBold  = .T.
154:                 .FontName  = "Tahoma"

*-- Linhas 164 a 207:
164:     *==========================================================================
165:     * ConfigurarPaginaLista - Campos de entrada e botoes de acao
166:     *==========================================================================
167:     PROTECTED PROCEDURE ConfigurarPaginaLista()
168:         LOCAL loc_cIcones
169:         loc_cIcones = gc_4c_CaminhoIcones
170: 
171:         *-- Shape2: delimitador visual da area de video/impressao
172:         THIS.AddObject("shp_4c_Shape2", "Shape")
173:         WITH THIS.shp_4c_Shape2
174:             .Top           = 7
175:             .Left          = 667
176:             .Height        = 75
177:             .Width         = 146
178:             .BackStyle     = 0
179:             .BorderStyle   = 0
180:             .SpecialEffect = 1
181:             .BorderColor   = RGB(136, 189, 188)
182:         ENDWITH
183: 
184:         *-- Shape1: delimitador visual da area de processar/encerrar
185:         THIS.AddObject("shp_4c_Shape1", "Shape")
186:         WITH THIS.shp_4c_Shape1
187:             .Top         = 8
188:             .Left        = 816
189:             .Height      = 110
190:             .Width       = 173
191:             .BackStyle   = 0
192:             .BorderStyle = 0
193:             .BorderColor = RGB(136, 189, 188)
194:         ENDWITH
195: 
196:         *-- Label "Periodo :"
197:         THIS.AddObject("lbl_4c_Periodo", "Label")
198:         WITH THIS.lbl_4c_Periodo
199:             .AutoSize  = .T.
200:             .FontName  = "Tahoma"
201:             .FontSize  = 8
202:             .BackStyle = 0
203:             .Caption   = "Per" + CHR(237) + "odo :"
204:             .Left      = 398
205:             .Top       = 90
206:             .Height    = 15
207:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 375 a 418:
375:     *==========================================================================
376:     * ConfigurarPaginaDados - Container de resultados com grades e totalizadores
377:     *==========================================================================
378:     PROTECTED PROCEDURE ConfigurarPaginaDados()
379:         LOCAL loc_oRes
380: 
381:         THIS.AddObject("cnt_4c_Resultado", "Container")
382:         WITH THIS.cnt_4c_Resultado
383:             .Top         = 144
384:             .Left        = 9
385:             .Width       = 981
386:             .Height      = 453
387:             .BackStyle   = 0
388:             .BorderColor = RGB(90, 90, 90)
389:             .Visible     = .F.
390:         ENDWITH
391: 
392:         loc_oRes = THIS.cnt_4c_Resultado
393: 
394:         *----------------------------------------------------------------------
395:         * cnt_4c_Detalhe - Saldo com funcionarios antes do periodo (center top)
396:         *----------------------------------------------------------------------
397:         loc_oRes.AddObject("cnt_4c_Detalhe", "Container")
398:         WITH loc_oRes.cnt_4c_Detalhe
399:             .Top         = 5
400:             .Left        = 336
401:             .Width       = 294
402:             .Height      = 172
403:             .BackStyle   = 0
404:             .BorderColor = RGB(90, 90, 90)
405:             .Visible     = .F.
406: 
407:             .AddObject("lbl_4c_Titulo", "Label")
408:             WITH .lbl_4c_Titulo
409:                 .AutoSize  = .F.
410:                 .FontBold  = .T.
411:                 .FontName  = "Tahoma"
412:                 .FontSize  = 8
413:                 .BackStyle = 0
414:                 .Caption   = "Saldo com funcion" + CHR(225) + "rios antes do per" + CHR(237) + "odo"
415:                 .Left      = 9
416:                 .Top       = 4
417:                 .Height    = 15
418:                 .Width     = 275

*-- Linhas 458 a 481:
458:                 .Column3.Header1.Caption = "Emp"
459:             ENDWITH
460:         ENDWITH
461: 
462:         *----------------------------------------------------------------------
463:         * cnt_4c_Detalhe2 - Entradas no periodo (left top)
464:         *----------------------------------------------------------------------
465:         loc_oRes.AddObject("cnt_4c_Detalhe2", "Container")
466:         WITH loc_oRes.cnt_4c_Detalhe2
467:             .Top         = 4
468:             .Left        = 15
469:             .Width       = 294
470:             .Height      = 172
471:             .BackStyle   = 0
472:             .BorderColor = RGB(90, 90, 90)
473:             .Visible     = .F.
474: 
475:             .AddObject("lbl_4c_Titulo", "Label")
476:             WITH .lbl_4c_Titulo
477:                 .AutoSize  = .F.
478:                 .FontBold  = .T.
479:                 .FontName  = "Tahoma"
480:                 .FontSize  = 8
481:                 .BackStyle = 0

*-- Linhas 526 a 549:
526:                 .Column3.Header1.Caption = "Emp"
527:             ENDWITH
528:         ENDWITH
529: 
530:         *----------------------------------------------------------------------
531:         * cnt_4c_Detalhe3 - Saidas no periodo (left bottom)
532:         *----------------------------------------------------------------------
533:         loc_oRes.AddObject("cnt_4c_Detalhe3", "Container")
534:         WITH loc_oRes.cnt_4c_Detalhe3
535:             .Top         = 184
536:             .Left        = 15
537:             .Width       = 294
538:             .Height      = 172
539:             .BackStyle   = 0
540:             .BorderColor = RGB(90, 90, 90)
541:             .Visible     = .F.
542: 
543:             .AddObject("lbl_4c_Titulo", "Label")
544:             WITH .lbl_4c_Titulo
545:                 .AutoSize  = .F.
546:                 .FontBold  = .T.
547:                 .FontName  = "Tahoma"
548:                 .FontSize  = 8
549:                 .BackStyle = 0

*-- Linhas 594 a 617:
594:                 .Column3.Header1.Caption = "Emp"
595:             ENDWITH
596:         ENDWITH
597: 
598:         *----------------------------------------------------------------------
599:         * cnt_4c_Detalhe4 - Saldo final com funcionarios (center bottom)
600:         *----------------------------------------------------------------------
601:         loc_oRes.AddObject("cnt_4c_Detalhe4", "Container")
602:         WITH loc_oRes.cnt_4c_Detalhe4
603:             .Top         = 184
604:             .Left        = 336
605:             .Width       = 294
606:             .Height      = 172
607:             .BackStyle   = 0
608:             .BorderColor = RGB(90, 90, 90)
609:             .Visible     = .F.
610: 
611:             .AddObject("lbl_4c_Titulo", "Label")
612:             WITH .lbl_4c_Titulo
613:                 .AutoSize  = .F.
614:                 .FontBold  = .T.
615:                 .FontName  = "Tahoma"
616:                 .FontSize  = 8
617:                 .BackStyle = 0

*-- Linhas 662 a 685:
662:                 .Column3.Header1.Caption = "Emp"
663:             ENDWITH
664:         ENDWITH
665: 
666:         *----------------------------------------------------------------------
667:         * cnt_4c_Detalhe5 - Falhas dos funcionarios (right top)
668:         *----------------------------------------------------------------------
669:         loc_oRes.AddObject("cnt_4c_Detalhe5", "Container")
670:         WITH loc_oRes.cnt_4c_Detalhe5
671:             .Top         = 5
672:             .Left        = 659
673:             .Width       = 294
674:             .Height      = 172
675:             .BackStyle   = 0
676:             .BorderColor = RGB(90, 90, 90)
677:             .Visible     = .F.
678: 
679:             .AddObject("lbl_4c_Titulo", "Label")
680:             WITH .lbl_4c_Titulo
681:                 .AutoSize  = .F.
682:                 .FontBold  = .T.
683:                 .FontName  = "Tahoma"
684:                 .FontSize  = 8
685:                 .BackStyle = 0

*-- Linhas 730 a 753:
730:                 .Column3.Header1.Caption = "Emp"
731:             ENDWITH
732:         ENDWITH
733: 
734:         *----------------------------------------------------------------------
735:         * cnt_4c_Resumo - Totalizadores (right bottom)
736:         *----------------------------------------------------------------------
737:         loc_oRes.AddObject("cnt_4c_Resumo", "Container")
738:         WITH loc_oRes.cnt_4c_Resumo
739:             .Top         = 184
740:             .Left        = 659
741:             .Width       = 294
742:             .Height      = 264
743:             .BackStyle   = 0
744:             .BorderColor = RGB(90, 90, 90)
745: 
746:             .AddObject("lbl_4c_Totalizadores", "Label")
747:             WITH .lbl_4c_Totalizadores
748:                 .AutoSize  = .F.
749:                 .FontBold  = .T.
750:                 .FontName  = "Tahoma"
751:                 .FontSize  = 8
752:                 .BackStyle = 0
753:                 .Caption   = "Totalizadores"

*-- Linhas 1075 a 1508:
1075:     ENDPROC
1076: 
1077:     *==========================================================================
1078:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1079:     * cnt_4c_Resultado fica oculto (ativado apos Processar)
1080:     *==========================================================================
1081:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1082:         LOCAL loc_nI, loc_oControl
1083:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1084:             loc_oControl = par_oContainer.Controls(loc_nI)
1085:             IF VARTYPE(loc_oControl) != "O"
1086:                 LOOP
1087:             ENDIF
1088:             IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_RESULTADO", "CNT_4C_DETALHE", ;
1089:                     "CNT_4C_DETALHE2", "CNT_4C_DETALHE3", "CNT_4C_DETALHE4", ;
1090:                     "CNT_4C_DETALHE5", "CNT_4C_RESUMO")
1091:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1092:                     THIS.TornarControlesVisiveis(loc_oControl)
1093:                 ENDIF
1094:                 LOOP
1095:             ENDIF
1096:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1097:                 loc_oControl.Visible = .T.
1098:             ENDIF
1099:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1100:                 THIS.TornarControlesVisiveis(loc_oControl)
1101:             ENDIF
1102:         ENDFOR
1103:     ENDPROC
1104: 
1105:     *==========================================================================
1106:     * CmdProcessarClick - Equivalente a Processar.Click do legado
1107:     *==========================================================================
1108:     PROCEDURE CmdProcessarClick()
1109:         LOCAL loc_oBO, loc_oErro, loc_lSucesso
1110:         loc_lSucesso = .F.
1111: 
1112:         TRY
1113:             loc_oBO = THIS.this_oBusinessObject
1114: 
1115:             loc_oBO.this_dDatai         = THIS.txt_4c_DataI.Value
1116:             loc_oBO.this_dDataf         = THIS.txt_4c_DataF.Value
1117:             loc_oBO.this_cDemonstrativo = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1118: 
1119:             THIS.cnt_4c_Resultado.Visible = .F.
1120:             THIS.Refresh
1121: 
1122:             IF loc_oBO.ProcessarAnalise()
1123:                 THIS.AtualizarGrades()
1124:                 THIS.AtualizarTotalizadores()
1125:                 THIS.cnt_4c_Resultado.Visible = .T.
1126:                 THIS.Refresh
1127:                 loc_lSucesso = .T.
1128:             ENDIF
1129: 
1130:         CATCH TO loc_oErro
1131:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1132:                 "Erro ao Processar")
1133:         ENDTRY
1134: 
1135:         RETURN loc_lSucesso
1136:     ENDPROC
1137: 
1138:     *==========================================================================
1139:     * AtualizarGrades - Vincula RecordSource/ControlSource em cada grade
1140:     *==========================================================================
1141:     PROTECTED PROCEDURE AtualizarGrades()
1142:         LOCAL loc_oRes
1143:         loc_oRes = THIS.cnt_4c_Resultado
1144: 
1145:         IF USED("SaldoAnt")
1146:             SELECT SaldoAnt
1147:             GO TOP
1148:         ENDIF
1149:         loc_oRes.cnt_4c_Detalhe.Visible = .T.
1150:         loc_oRes.cnt_4c_Detalhe.grd_4c_Dados.ColumnCount  = 3
1151:         loc_oRes.cnt_4c_Detalhe.grd_4c_Dados.RecordSource = "SaldoAnt"
1152:         WITH loc_oRes.cnt_4c_Detalhe.grd_4c_Dados
1153:             .Column1.ControlSource   = "SaldoAnt.Grupos"
1154:             .Column1.Header1.Caption = "Header1"
1155:             .Column2.ControlSource   = "SaldoAnt.Qtde"
1156:             .Column2.Header1.Caption = "Header1"
1157:             .Column3.ControlSource   = "SaldoAnt.Emps"
1158:             .Column3.Header1.Caption = "Emp"
1159:             .Refresh
1160:         ENDWITH
1161: 
1162:         IF USED("Entradas")
1163:             SELECT Entradas
1164:             GO TOP
1165:         ENDIF
1166:         loc_oRes.cnt_4c_Detalhe2.Visible = .T.
1167:         loc_oRes.cnt_4c_Detalhe2.grd_4c_Dados.ColumnCount  = 3
1168:         loc_oRes.cnt_4c_Detalhe2.grd_4c_Dados.RecordSource = "Entradas"
1169:         WITH loc_oRes.cnt_4c_Detalhe2.grd_4c_Dados
1170:             .Column1.ControlSource   = "Entradas.TpOps"
1171:             .Column1.Header1.Caption = "Header1"
1172:             .Column2.ControlSource   = "Entradas.Qtde"
1173:             .Column2.Header1.Caption = "Header1"
1174:             .Column3.ControlSource   = "Entradas.Emps"
1175:             .Column3.Header1.Caption = "Emp"
1176:             .Refresh
1177:         ENDWITH
1178: 
1179:         IF USED("Saidas")
1180:             SELECT Saidas
1181:             GO TOP
1182:         ENDIF
1183:         loc_oRes.cnt_4c_Detalhe3.Visible = .T.
1184:         loc_oRes.cnt_4c_Detalhe3.grd_4c_Dados.ColumnCount  = 3
1185:         loc_oRes.cnt_4c_Detalhe3.grd_4c_Dados.RecordSource = "Saidas"
1186:         WITH loc_oRes.cnt_4c_Detalhe3.grd_4c_Dados
1187:             .Column1.ControlSource   = "Saidas.TpOps"
1188:             .Column1.Header1.Caption = "Header1"
1189:             .Column2.ControlSource   = "Saidas.Qtde"
1190:             .Column2.Header1.Caption = "Header1"
1191:             .Column3.ControlSource   = "Saidas.Emps"
1192:             .Column3.Header1.Caption = "Emp"
1193:             .Refresh
1194:         ENDWITH
1195: 
1196:         IF USED("Saldos")
1197:             SELECT Saldos
1198:             GO TOP
1199:         ENDIF
1200:         loc_oRes.cnt_4c_Detalhe4.Visible = .T.
1201:         loc_oRes.cnt_4c_Detalhe4.grd_4c_Dados.ColumnCount  = 3
1202:         loc_oRes.cnt_4c_Detalhe4.grd_4c_Dados.RecordSource = "Saldos"
1203:         WITH loc_oRes.cnt_4c_Detalhe4.grd_4c_Dados
1204:             .Column1.ControlSource   = "Saldos.Grupos"
1205:             .Column1.Header1.Caption = "Header1"
1206:             .Column2.ControlSource   = "Saldos.Qtde"
1207:             .Column2.Header1.Caption = "Header1"
1208:             .Column3.ControlSource   = "Saldos.Emps"
1209:             .Column3.Header1.Caption = "Emp"
1210:             .Refresh
1211:         ENDWITH
1212: 
1213:         IF USED("Falhas")
1214:             SELECT Falhas
1215:             GO TOP
1216:         ENDIF
1217:         loc_oRes.cnt_4c_Detalhe5.Visible = .T.
1218:         loc_oRes.cnt_4c_Detalhe5.grd_4c_Dados.ColumnCount  = 3
1219:         loc_oRes.cnt_4c_Detalhe5.grd_4c_Dados.RecordSource = "Falhas"
1220:         WITH loc_oRes.cnt_4c_Detalhe5.grd_4c_Dados
1221:             .Column1.ControlSource   = "Falhas.Grupos"
1222:             .Column1.Header1.Caption = "Header1"
1223:             .Column2.ControlSource   = "Falhas.Qtde"
1224:             .Column2.Header1.Caption = "Header1"
1225:             .Column3.ControlSource   = "Falhas.Emps"
1226:             .Column3.Header1.Caption = "Emp"
1227:             .Refresh
1228:         ENDWITH
1229:     ENDPROC
1230: 
1231:     *==========================================================================
1232:     * AtualizarTotalizadores - Preenche TextBoxes do Resumo com valores do BO
1233:     *==========================================================================
1234:     PROTECTED PROCEDURE AtualizarTotalizadores()
1235:         LOCAL loc_oBO, loc_oResumo
1236:         loc_oBO     = THIS.this_oBusinessObject
1237:         loc_oResumo = THIS.cnt_4c_Resultado.cnt_4c_Resumo
1238: 
1239:         WITH loc_oResumo
1240:             .txt_4c_SaldoIni.Value      = loc_oBO.this_nSaldoIni
1241:             .txt_4c_SaldoAntP.Value     = loc_oBO.this_nSaldoaFun
1242:             .txt_4c_Entradas.Value      = loc_oBO.this_nTotalEntra
1243:             .txt_4c_TotalEntradas.Value = loc_oBO.this_nSaldoIni + loc_oBO.this_nTotalEntra + loc_oBO.this_nSaldoaFun
1244:             .txt_4c_Saidas.Value        = loc_oBO.this_nTotalSaida
1245:             .txt_4c_Saldo.Value         = loc_oBO.this_nSaldoIni + loc_oBO.this_nTotalEntra - loc_oBO.this_nTotalSaida + loc_oBO.this_nSaldoaFun
1246:             .txt_4c_SaldoFunc.Value     = loc_oBO.this_nSaldoFunc
1247:             .txt_4c_Pesagem.Value       = loc_oBO.this_nPesagem
1248:             .txt_4c_Total.Value         = loc_oBO.this_nPesagem + loc_oBO.this_nSaldoFunc
1249:             .txt_4c_FalhaFunc.Value     = loc_oBO.this_nFalhaFunc
1250:         ENDWITH
1251:     ENDPROC
1252: 
1253:     *==========================================================================
1254:     * CmdVisualizarClick - Exibe relatorio em tela (Preview)
1255:     *==========================================================================
1256:     PROCEDURE CmdVisualizarClick()
1257:         LOCAL loc_cRelatorio
1258:         IF THIS.cnt_4c_Resultado.Visible
1259:             IF USED("TmpImp")
1260:                 SELECT TmpImp
1261:                 GO TOP
1262:                 IF !EOF()
1263:                     loc_cRelatorio = gc_4c_CaminhoBase + "reports\RelSigPrFem.frx"
1264:                     IF FILE(loc_cRelatorio)
1265:                         REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
1266:                     ELSE
1267:                         MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado." + CHR(13) + loc_cRelatorio)
1268:                     ENDIF
1269:                 ENDIF
1270:             ENDIF
1271:         ENDIF
1272:     ENDPROC
1273: 
1274:     *==========================================================================
1275:     * CmdImprimirClick - Envia relatorio para impressora
1276:     *==========================================================================
1277:     PROCEDURE CmdImprimirClick()
1278:         LOCAL loc_cRelatorio
1279:         IF THIS.cnt_4c_Resultado.Visible
1280:             IF USED("TmpImp")
1281:                 SELECT TmpImp
1282:                 GO TOP
1283:                 IF !EOF()
1284:                     loc_cRelatorio = gc_4c_CaminhoBase + "reports\RelSigPrFem.frx"
1285:                     IF FILE(loc_cRelatorio)
1286:                         REPORT FORM (loc_cRelatorio) TO PRINT PROMPT NOCONSOLE
1287:                     ELSE
1288:                         MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado." + CHR(13) + loc_cRelatorio)
1289:                     ENDIF
1290:                 ENDIF
1291:             ENDIF
1292:         ENDIF
1293:     ENDPROC
1294: 
1295:     *==========================================================================
1296:     * CmdEncerrarClick - Fecha o formulario
1297:     *==========================================================================
1298:     PROCEDURE CmdEncerrarClick()
1299:         THIS.Release()
1300:     ENDPROC
1301: 
1302:     *==========================================================================
1303:     * DemonstrativoKeyPress - F4/Enter/Tab disparam validacao ou picker
1304:     * LPARAMETERS obrigatorio como primeira linha (BINDEVENT KeyPress)
1305:     *==========================================================================
1306:     PROCEDURE DemonstrativoKeyPress
1307:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1308:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1309:             THIS.AbrirLookupDemonstrativo()
1310:             RETURN
1311:         ENDIF
1312:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1313:             THIS.ValidarDemonstrativo()
1314:         ENDIF
1315:     ENDPROC
1316: 
1317:     *==========================================================================
1318:     * ValidarDemonstrativo - Valida valor digitado contra SigPrDmo
1319:     * Chamado por DemonstrativoKeyPress em Enter/Tab (NAO por LostFocus)
1320:     *==========================================================================
1321:     PROTECTED PROCEDURE ValidarDemonstrativo()
1322:         LOCAL loc_cValor, loc_nRet
1323:         loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1324:         IF EMPTY(loc_cValor)
1325:             RETURN
1326:         ENDIF
1327:         IF USED("cursor_4c_DmoValida")
1328:             USE IN cursor_4c_DmoValida
1329:         ENDIF
1330:         loc_nRet = SQLEXEC(gnConnHandle, ;
1331:             "SELECT TOP 1 Nome FROM SigPrDmo WHERE Nome = " + EscaparSQL(loc_cValor), ;
1332:             "cursor_4c_DmoValida")
1333:         IF loc_nRet > 0 AND NOT EOF("cursor_4c_DmoValida")
1334:             SELECT cursor_4c_DmoValida
1335:             THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
1336:         ELSE
1337:             THIS.AbrirLookupDemonstrativo()
1338:         ENDIF
1339:         IF USED("cursor_4c_DmoValida")
1340:             USE IN cursor_4c_DmoValida
1341:         ENDIF
1342:         THIS.txt_4c_Demonstrativo.Refresh
1343:     ENDPROC
1344: 
1345:     *==========================================================================
1346:     * AbrirLookupDemonstrativo - Abre FormBuscaAuxiliar para SigPrDmo
1347:     * Equivalente ao fwBuscaExt do legado (Get_Demonstrativo.Valid)
1348:     *==========================================================================
1349:     PROCEDURE AbrirLookupDemonstrativo()
1350:         LOCAL loc_oForm, loc_cValor
1351:         loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1352: 
1353:         IF USED("cursor_4c_DmoLista")
1354:             USE IN cursor_4c_DmoLista
1355:         ENDIF
1356: 
1357:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1358:             "SigPrDmo", "cursor_4c_DmoLista", "Nome", loc_cValor, ;
1359:             "Sele" + CHR(231) + CHR(227) + "o")
1360: 
1361:         IF VARTYPE(loc_oForm) != "O"
1362:             RETURN
1363:         ENDIF
1364: 
1365:         IF loc_oForm.this_lAchouRegistro
1366:             IF USED("cursor_4c_DmoLista")
1367:                 SELECT cursor_4c_DmoLista
1368:                 THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
1369:             ENDIF
1370:         ELSE
1371:             loc_oForm.mAddColuna("Nome", "", "Nome")
1372:             loc_oForm.Show()
1373:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_DmoLista")
1374:                 SELECT cursor_4c_DmoLista
1375:                 THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
1376:             ENDIF
1377:         ENDIF
1378: 
1379:         IF USED("cursor_4c_DmoLista")
1380:             USE IN cursor_4c_DmoLista
1381:         ENDIF
1382: 
1383:         THIS.txt_4c_Demonstrativo.Refresh
1384:     ENDPROC
1385: 
1386:     *==========================================================================
1387:     * BtnIncluirClick - Nova analise: limpa filtros/resultados e foca DataI
1388:     *==========================================================================
1389:     PROCEDURE BtnIncluirClick()
1390:         LOCAL loc_oErro
1391:         TRY
1392:             THIS.cnt_4c_Resultado.Visible = .F.
1393: 
1394:             THIS.txt_4c_DataI.Value         = {}
1395:             THIS.txt_4c_DataF.Value         = DATE()
1396:             THIS.txt_4c_Demonstrativo.Value = ""
1397: 
1398:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1399:                 THIS.this_oBusinessObject.this_dDatai         = {}
1400:                 THIS.this_oBusinessObject.this_dDataf         = DATE()
1401:                 THIS.this_oBusinessObject.this_cDemonstrativo = ""
1402:                 THIS.this_oBusinessObject.this_nSaldoIni      = 0
1403:                 THIS.this_oBusinessObject.this_nSaldoaFun     = 0
1404:                 THIS.this_oBusinessObject.this_nTotalEntra    = 0
1405:                 THIS.this_oBusinessObject.this_nTotalSaida    = 0
1406:                 THIS.this_oBusinessObject.this_nSaldoFunc     = 0
1407:                 THIS.this_oBusinessObject.this_nPesagem       = 0
1408:                 THIS.this_oBusinessObject.this_nFalhaFunc     = 0
1409:             ENDIF
1410: 
1411:             THIS.Refresh
1412:             THIS.txt_4c_DataI.SetFocus
1413:         CATCH TO loc_oErro
1414:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1415:                 "Erro ao Iniciar Nova An" + CHR(225) + "lise")
1416:         ENDTRY
1417:     ENDPROC
1418: 
1419:     *==========================================================================
1420:     * BtnAlterarClick - Reprocessa a analise com os parametros atuais
1421:     *==========================================================================
1422:     PROCEDURE BtnAlterarClick()
1423:         LOCAL loc_oErro
1424:         TRY
1425:             IF EMPTY(THIS.txt_4c_DataF.Value)
1426:                 MsgAviso("A Data Final deve ser informada.", ;
1427:                     "Reprocessamento")
1428:                 THIS.txt_4c_DataF.SetFocus
1429:                 RETURN
1430:             ENDIF
1431: 
1432:             IF EMPTY(THIS.txt_4c_Demonstrativo.Value)
1433:                 MsgAviso("A Configura" + CHR(231) + CHR(227) + ;
1434:                     "o do Demonstrativo deve ser informada.", ;
1435:                     "Reprocessamento")
1436:                 THIS.txt_4c_Demonstrativo.SetFocus
1437:                 RETURN
1438:             ENDIF
1439: 
1440:             THIS.CmdProcessarClick()
1441:         CATCH TO loc_oErro
1442:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1443:                 "Erro ao Reprocessar")
1444:         ENDTRY
1445:     ENDPROC
1446: 
1447:     *==========================================================================
1448:     * BtnVisualizarClick - Visualiza relatorio (delega para CmdVisualizarClick)
1449:     *==========================================================================
1450:     PROCEDURE BtnVisualizarClick()
1451:         LOCAL loc_oErro
1452:         TRY
1453:             IF !THIS.cnt_4c_Resultado.Visible
1454:                 MsgAviso("Processe a an" + CHR(225) + "lise antes de visualizar o relat" + ;
1455:                     CHR(243) + "rio.", "Visualizar")
1456:                 RETURN
1457:             ENDIF
1458:             THIS.CmdVisualizarClick()
1459:         CATCH TO loc_oErro
1460:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1461:                 "Erro ao Visualizar")
1462:         ENDTRY
1463:     ENDPROC
1464: 
1465:     *==========================================================================
1466:     * BtnExcluirClick - Limpa cursores de resultado e oculta painel
1467:     *==========================================================================
1468:     PROCEDURE BtnExcluirClick()
1469:         LOCAL loc_oErro, loc_lConfirma
1470:         TRY
1471:             IF !THIS.cnt_4c_Resultado.Visible
1472:                 RETURN
1473:             ENDIF
1474: 
1475:             loc_lConfirma = MsgConfirma("Deseja limpar os resultados da an" + ;
1476:                 CHR(225) + "lise atual?", "Limpar Resultados")
1477: 
1478:             IF !loc_lConfirma
1479:                 RETURN
1480:             ENDIF
1481: 
1482:             IF USED("Entradas")
1483:                 SELECT Entradas
1484:                 ZAP
1485:             ENDIF
1486:             IF USED("Saidas")
1487:                 SELECT Saidas
1488:                 ZAP
1489:             ENDIF
1490:             IF USED("Saldos")
1491:                 SELECT Saldos
1492:                 ZAP
1493:             ENDIF
1494:             IF USED("SaldoAnt")
1495:                 SELECT SaldoAnt
1496:                 ZAP
1497:             ENDIF
1498:             IF USED("Falhas")
1499:                 SELECT Falhas
1500:                 ZAP
1501:             ENDIF
1502:             IF USED("TmpResumo")
1503:                 SELECT TmpResumo
1504:                 ZAP
1505:             ENDIF
1506:             IF USED("TmpImp")
1507:                 SELECT TmpImp
1508:                 ZAP

*-- Linhas 1529 a 1572:
1529:     *==========================================================================
1530:     * Destroy - Limpeza de recursos (cursores de referencia e trabalho)
1531:     *==========================================================================
1532:     PROCEDURE Destroy()
1533:         IF USED("crSigCdPam")
1534:             USE IN crSigCdPam
1535:         ENDIF
1536:         IF USED("crSigCdPac")
1537:             USE IN crSigCdPac
1538:         ENDIF
1539:         IF USED("crSigCdOpe")
1540:             USE IN crSigCdOpe
1541:         ENDIF
1542:         IF USED("crSigCdOpd")
1543:             USE IN crSigCdOpd
1544:         ENDIF
1545:         IF USED("crSigCdGcr")
1546:             USE IN crSigCdGcr
1547:         ENDIF
1548:         IF USED("crSigCdUni")
1549:             USE IN crSigCdUni
1550:         ENDIF
1551:         IF USED("LocalGru")
1552:             USE IN LocalGru
1553:         ENDIF
1554:         IF USED("LocalGgrp")
1555:             USE IN LocalGgrp
1556:         ENDIF
1557:         IF USED("Entradas")
1558:             USE IN Entradas
1559:         ENDIF
1560:         IF USED("Saidas")
1561:             USE IN Saidas
1562:         ENDIF
1563:         IF USED("Saldos")
1564:             USE IN Saldos
1565:         ENDIF
1566:         IF USED("SaldoAnt")
1567:             USE IN SaldoAnt
1568:         ENDIF
1569:         IF USED("Falhas")
1570:             USE IN Falhas
1571:         ENDIF
1572:         IF USED("TmpResumo")

*-- Linhas 1584 a 1811:
1584:     *==========================================================================
1585:     * BtnBuscarClick - Abre lookup do Demonstrativo (F5/Buscar do padrao CRUD)
1586:     *==========================================================================
1587:     PROCEDURE BtnBuscarClick()
1588:         LOCAL loc_oErro
1589:         TRY
1590:             THIS.AbrirLookupDemonstrativo()
1591:         CATCH TO loc_oErro
1592:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1593:                 "Erro ao Buscar")
1594:         ENDTRY
1595:     ENDPROC
1596: 
1597:     *==========================================================================
1598:     * BtnEncerrarClick - Delega para CmdEncerrarClick (fecha o form)
1599:     *==========================================================================
1600:     PROCEDURE BtnEncerrarClick()
1601:         LOCAL loc_oErro
1602:         TRY
1603:             THIS.CmdEncerrarClick()
1604:         CATCH TO loc_oErro
1605:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1606:                 "Erro ao Encerrar")
1607:         ENDTRY
1608:     ENDPROC
1609: 
1610:     *==========================================================================
1611:     * BtnSalvarClick - Confirma parametros e dispara processamento
1612:     * (Form OPERACIONAL nao persiste dados; equivalente a "Processar")
1613:     *==========================================================================
1614:     PROCEDURE BtnSalvarClick()
1615:         LOCAL loc_oErro
1616:         TRY
1617:             IF !THIS.FormParaBO()
1618:                 loc_lResultado = .F.
1619:             ENDIF
1620:             THIS.CmdProcessarClick()
1621:             loc_lResultado = .T.
1622:         CATCH TO loc_oErro
1623:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1624:                 "Erro ao Processar")
1625:             loc_lResultado = .F.
1626:         ENDTRY
1627:     ENDPROC
1628: 
1629:     *==========================================================================
1630:     * BtnCancelarClick - Cancela / limpa resultados sem confirmacao
1631:     *==========================================================================
1632:     PROCEDURE BtnCancelarClick()
1633:         LOCAL loc_oErro
1634:         TRY
1635:             THIS.LimparCampos()
1636:             THIS.cnt_4c_Resultado.Visible = .F.
1637:             THIS.Refresh
1638:             IF PEMSTATUS(THIS, "txt_4c_DataI", 5)
1639:                 THIS.txt_4c_DataI.SetFocus
1640:             ENDIF
1641:         CATCH TO loc_oErro
1642:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1643:                 "Erro ao Cancelar")
1644:         ENDTRY
1645:     ENDPROC
1646: 
1647:     *==========================================================================
1648:     * FormParaBO - Sincroniza filtros do form -> BO (Datai, Dataf, Demonstrativo)
1649:     * Retorna .T. se todos os campos obrigatorios estao preenchidos.
1650:     *==========================================================================
1651:     PROCEDURE FormParaBO()
1652:         LOCAL loc_lOK
1653:         loc_lOK = .F.
1654: 
1655:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1656:             MsgErro("Business Object nao inicializado.", "Erro")
1657:             RETURN .F.
1658:         ENDIF
1659: 
1660:         IF EMPTY(THIS.txt_4c_DataF.Value)
1661:             MsgAviso("A Data Final deve ser informada.", ;
1662:                 "Valida" + CHR(231) + CHR(227) + "o")
1663:             THIS.txt_4c_DataF.SetFocus
1664:             RETURN .F.
1665:         ENDIF
1666: 
1667:         IF !EMPTY(THIS.txt_4c_DataI.Value) AND ;
1668:            THIS.txt_4c_DataI.Value > THIS.txt_4c_DataF.Value
1669:             MsgAviso("A Data Final deve ser maior que a Data Inicial.", ;
1670:                 "Valida" + CHR(231) + CHR(227) + "o")
1671:             THIS.txt_4c_DataI.SetFocus
1672:             RETURN .F.
1673:         ENDIF
1674: 
1675:         IF EMPTY(ALLTRIM(THIS.txt_4c_Demonstrativo.Value))
1676:             MsgAviso("A Configura" + CHR(231) + CHR(227) + ;
1677:                 "o do Demonstrativo deve ser informada.", ;
1678:                 "Valida" + CHR(231) + CHR(227) + "o")
1679:             THIS.txt_4c_Demonstrativo.SetFocus
1680:             RETURN .F.
1681:         ENDIF
1682: 
1683:         THIS.this_oBusinessObject.this_dDatai         = THIS.txt_4c_DataI.Value
1684:         THIS.this_oBusinessObject.this_dDataf         = THIS.txt_4c_DataF.Value
1685:         THIS.this_oBusinessObject.this_cDemonstrativo = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1686: 
1687:         loc_lOK = .T.
1688:         RETURN loc_lOK
1689:     ENDPROC
1690: 
1691:     *==========================================================================
1692:     * BOParaForm - Sincroniza BO -> form (filtros + totalizadores do resumo)
1693:     *==========================================================================
1694:     PROCEDURE BOParaForm()
1695:         LOCAL loc_oBO
1696:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1697:             RETURN .F.
1698:         ENDIF
1699:         loc_oBO = THIS.this_oBusinessObject
1700: 
1701:         THIS.txt_4c_DataI.Value         = loc_oBO.this_dDatai
1702:         THIS.txt_4c_DataF.Value         = loc_oBO.this_dDataf
1703:         THIS.txt_4c_Demonstrativo.Value = loc_oBO.this_cDemonstrativo
1704: 
1705:         WITH THIS.cnt_4c_Resultado.cnt_4c_Resumo
1706:             .txt_4c_Saldoi.Value    = loc_oBO.this_nSaldoIni
1707:             .txt_4c_SaldoAnt.Value  = loc_oBO.this_nSaldoaFun
1708:             .txt_4c_Entradas.Value  = loc_oBO.this_nTotalEntra
1709:             .txt_4c_TEntradas.Value = loc_oBO.this_nSaldoIni + loc_oBO.this_nSaldoaFun + loc_oBO.this_nTotalEntra
1710:             .txt_4c_Saidas.Value    = loc_oBO.this_nTotalSaida
1711:             .txt_4c_Saldo.Value     = (loc_oBO.this_nSaldoIni + loc_oBO.this_nSaldoaFun + loc_oBO.this_nTotalEntra) - loc_oBO.this_nTotalSaida
1712:             .txt_4c_SaldoFunc.Value = loc_oBO.this_nSaldoFunc
1713:             .txt_4c_Pesagem.Value   = loc_oBO.this_nPesagem
1714:             .txt_4c_SaldoT.Value    = loc_oBO.this_nSaldoFunc + loc_oBO.this_nPesagem
1715:             .txt_4c_FalhaFunc.Value = loc_oBO.this_nFalhaFunc
1716:             .Visible     = .T.
1717:         ENDWITH
1718: 
1719:         THIS.Refresh
1720:         RETURN .T.
1721:     ENDPROC
1722: 
1723:     *==========================================================================
1724:     * HabilitarCampos - Habilita/desabilita filtros conforme par_lHabilitar
1725:     * (Form OPERACIONAL: filtros sempre editaveis; durante processamento
1726:     *  podem ser desabilitados temporariamente)
1727:     *==========================================================================
1728:     PROCEDURE HabilitarCampos(par_lHabilitar)
1729:         LOCAL loc_lHab
1730:         loc_lHab = IIF(PCOUNT() = 0, .T., par_lHabilitar)
1731: 
1732:         THIS.txt_4c_DataI.Enabled         = loc_lHab
1733:         THIS.txt_4c_DataF.Enabled         = loc_lHab
1734:         THIS.txt_4c_Demonstrativo.Enabled = loc_lHab
1735:         THIS.cmd_4c_Processar.Enabled     = loc_lHab
1736:         THIS.cmd_4c_Visualizar.Enabled    = loc_lHab AND THIS.cnt_4c_Resultado.Visible
1737:         THIS.cmd_4c_Imprimir.Enabled      = loc_lHab AND THIS.cnt_4c_Resultado.Visible
1738:         THIS.cmd_4c_Encerrar.Enabled      = .T.
1739:     ENDPROC
1740: 
1741:     *==========================================================================
1742:     * LimparCampos - Reseta filtros e propriedades do BO
1743:     *==========================================================================
1744:     PROCEDURE LimparCampos()
1745:         THIS.txt_4c_DataI.Value         = {}
1746:         THIS.txt_4c_DataF.Value         = DATE()
1747:         THIS.txt_4c_Demonstrativo.Value = ""
1748: 
1749:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1750:             THIS.this_oBusinessObject.this_dDatai         = {}
1751:             THIS.this_oBusinessObject.this_dDataf         = DATE()
1752:             THIS.this_oBusinessObject.this_cDemonstrativo = ""
1753:             THIS.this_oBusinessObject.this_nSaldoIni      = 0
1754:             THIS.this_oBusinessObject.this_nSaldoaFun     = 0
1755:             THIS.this_oBusinessObject.this_nTotalEntra    = 0
1756:             THIS.this_oBusinessObject.this_nTotalSaida    = 0
1757:             THIS.this_oBusinessObject.this_nSaldoFunc     = 0
1758:             THIS.this_oBusinessObject.this_nPesagem       = 0
1759:             THIS.this_oBusinessObject.this_nFalhaFunc     = 0
1760:         ENDIF
1761: 
1762:         WITH THIS.cnt_4c_Resultado.cnt_4c_Resumo
1763:             .txt_4c_Saldoi.Value    = 0
1764:             .txt_4c_SaldoAnt.Value  = 0
1765:             .txt_4c_Entradas.Value  = 0
1766:             .txt_4c_TEntradas.Value = 0
1767:             .txt_4c_Saidas.Value    = 0
1768:             .txt_4c_Saldo.Value     = 0
1769:             .txt_4c_SaldoFunc.Value = 0
1770:             .txt_4c_Pesagem.Value   = 0
1771:             .txt_4c_SaldoT.Value    = 0
1772:             .txt_4c_FalhaFunc.Value = 0
1773:             .Visible     = .T.
1774:         ENDWITH
1775:     ENDPROC
1776: 
1777:     *==========================================================================
1778:     * CarregarLista - Recarrega grades de resultado (delega para AtualizarGrades)
1779:     * (Nome preservado por contrato com FormBase / padrao dos forms migrados)
1780:     *==========================================================================
1781:     PROCEDURE CarregarLista()
1782:         LOCAL loc_oErro
1783:         TRY
1784:             IF !THIS.cnt_4c_Resultado.Visible
1785:                 loc_lResultado = .F.
1786:             ENDIF
1787:             THIS.AtualizarGrades()
1788:             THIS.AtualizarTotalizadores()
1789:             loc_lResultado = .T.
1790:         CATCH TO loc_oErro
1791:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1792:                 "Erro em CarregarLista")
1793:             loc_lResultado = .F.
1794:         ENDTRY
1795:     ENDPROC
1796: 
1797:     *==========================================================================
1798:     * AjustarBotoesPorModo - Contrato do FormBase; OPERACIONAL nao tem modos CRUD
1799:     * Ajusta apenas Visualizar/Imprimir conforme resultados exibidos.
1800:     *==========================================================================
1801:     PROCEDURE AjustarBotoesPorModo()
1802:         LOCAL loc_lTemResultado
1803:         loc_lTemResultado = THIS.cnt_4c_Resultado.Visible
1804: 
1805:         THIS.cmd_4c_Processar.Enabled  = .T.
1806:         THIS.cmd_4c_Visualizar.Enabled = loc_lTemResultado
1807:         THIS.cmd_4c_Imprimir.Enabled   = loc_lTemResultado
1808:         THIS.cmd_4c_Encerrar.Enabled   = .T.
1809:     ENDPROC
1810: 
1811: ENDDEFINE

