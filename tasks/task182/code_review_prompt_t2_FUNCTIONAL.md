# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_DETALHE, CNT_4C_DETALHE2, CNT_4C_DETALHE3, CNT_4C_DETALHE4, CNT_4C_DETALHE5, CNT_4C_RESUMO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).
- [GRID-WITH] Bloco WITH loc_oRes.cnt_4c_Detalhe2 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oRes.cnt_4c_Detalhe2.RecordSource).
- [GRID-WITH] Bloco WITH loc_oRes.cnt_4c_Detalhe3 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oRes.cnt_4c_Detalhe3.RecordSource).
- [GRID-WITH] Bloco WITH loc_oRes.cnt_4c_Detalhe4 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oRes.cnt_4c_Detalhe4.RecordSource).
- [GRID-WITH] Bloco WITH loc_oRes.cnt_4c_Detalhe5 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oRes.cnt_4c_Detalhe5.RecordSource).
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1821 linhas total):

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

*-- Linhas 1075 a 1518:
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
1149:         WITH loc_oRes.cnt_4c_Detalhe
1150:             .Visible = .T.
1151:             .grd_4c_Dados.ColumnCount  = 3
1152:             .grd_4c_Dados.RecordSource = "SaldoAnt"
1153:             WITH .grd_4c_Dados
1154:                 .Column1.ControlSource   = "SaldoAnt.Grupos"
1155:                 .Column1.Header1.Caption = "Header1"
1156:                 .Column2.ControlSource   = "SaldoAnt.Qtde"
1157:                 .Column2.Header1.Caption = "Header1"
1158:                 .Column3.ControlSource   = "SaldoAnt.Emps"
1159:                 .Column3.Header1.Caption = "Emp"
1160:                 .Refresh
1161:             ENDWITH
1162:         ENDWITH
1163: 
1164:         IF USED("Entradas")
1165:             SELECT Entradas
1166:             GO TOP
1167:         ENDIF
1168:         WITH loc_oRes.cnt_4c_Detalhe2
1169:             .Visible = .T.
1170:             .grd_4c_Dados.ColumnCount  = 3
1171:             .grd_4c_Dados.RecordSource = "Entradas"
1172:             WITH .grd_4c_Dados
1173:                 .Column1.ControlSource   = "Entradas.TpOps"
1174:                 .Column1.Header1.Caption = "Header1"
1175:                 .Column2.ControlSource   = "Entradas.Qtde"
1176:                 .Column2.Header1.Caption = "Header1"
1177:                 .Column3.ControlSource   = "Entradas.Emps"
1178:                 .Column3.Header1.Caption = "Emp"
1179:                 .Refresh
1180:             ENDWITH
1181:         ENDWITH
1182: 
1183:         IF USED("Saidas")
1184:             SELECT Saidas
1185:             GO TOP
1186:         ENDIF
1187:         WITH loc_oRes.cnt_4c_Detalhe3
1188:             .Visible = .T.
1189:             .grd_4c_Dados.ColumnCount  = 3
1190:             .grd_4c_Dados.RecordSource = "Saidas"
1191:             WITH .grd_4c_Dados
1192:                 .Column1.ControlSource   = "Saidas.TpOps"
1193:                 .Column1.Header1.Caption = "Header1"
1194:                 .Column2.ControlSource   = "Saidas.Qtde"
1195:                 .Column2.Header1.Caption = "Header1"
1196:                 .Column3.ControlSource   = "Saidas.Emps"
1197:                 .Column3.Header1.Caption = "Emp"
1198:                 .Refresh
1199:             ENDWITH
1200:         ENDWITH
1201: 
1202:         IF USED("Saldos")
1203:             SELECT Saldos
1204:             GO TOP
1205:         ENDIF
1206:         WITH loc_oRes.cnt_4c_Detalhe4
1207:             .Visible = .T.
1208:             .grd_4c_Dados.ColumnCount  = 3
1209:             .grd_4c_Dados.RecordSource = "Saldos"
1210:             WITH .grd_4c_Dados
1211:                 .Column1.ControlSource   = "Saldos.Grupos"
1212:                 .Column1.Header1.Caption = "Header1"
1213:                 .Column2.ControlSource   = "Saldos.Qtde"
1214:                 .Column2.Header1.Caption = "Header1"
1215:                 .Column3.ControlSource   = "Saldos.Emps"
1216:                 .Column3.Header1.Caption = "Emp"
1217:                 .Refresh
1218:             ENDWITH
1219:         ENDWITH
1220: 
1221:         IF USED("Falhas")
1222:             SELECT Falhas
1223:             GO TOP
1224:         ENDIF
1225:         WITH loc_oRes.cnt_4c_Detalhe5
1226:             .Visible = .T.
1227:             .grd_4c_Dados.ColumnCount  = 3
1228:             .grd_4c_Dados.RecordSource = "Falhas"
1229:             WITH .grd_4c_Dados
1230:                 .Column1.ControlSource   = "Falhas.Grupos"
1231:                 .Column1.Header1.Caption = "Header1"
1232:                 .Column2.ControlSource   = "Falhas.Qtde"
1233:                 .Column2.Header1.Caption = "Header1"
1234:                 .Column3.ControlSource   = "Falhas.Emps"
1235:                 .Column3.Header1.Caption = "Emp"
1236:                 .Refresh
1237:             ENDWITH
1238:         ENDWITH
1239:     ENDPROC
1240: 
1241:     *==========================================================================
1242:     * AtualizarTotalizadores - Preenche TextBoxes do Resumo com valores do BO
1243:     *==========================================================================
1244:     PROTECTED PROCEDURE AtualizarTotalizadores()
1245:         LOCAL loc_oBO, loc_oResumo
1246:         loc_oBO     = THIS.this_oBusinessObject
1247:         loc_oResumo = THIS.cnt_4c_Resultado.cnt_4c_Resumo
1248: 
1249:         WITH loc_oResumo
1250:             .txt_4c_SaldoIni.Value      = loc_oBO.this_nSaldoIni
1251:             .txt_4c_SaldoAntP.Value     = loc_oBO.this_nSaldoaFun
1252:             .txt_4c_Entradas.Value      = loc_oBO.this_nTotalEntra
1253:             .txt_4c_TotalEntradas.Value = loc_oBO.this_nSaldoIni + loc_oBO.this_nTotalEntra + loc_oBO.this_nSaldoaFun
1254:             .txt_4c_Saidas.Value        = loc_oBO.this_nTotalSaida
1255:             .txt_4c_Saldo.Value         = loc_oBO.this_nSaldoIni + loc_oBO.this_nTotalEntra - loc_oBO.this_nTotalSaida + loc_oBO.this_nSaldoaFun
1256:             .txt_4c_SaldoFunc.Value     = loc_oBO.this_nSaldoFunc
1257:             .txt_4c_Pesagem.Value       = loc_oBO.this_nPesagem
1258:             .txt_4c_Total.Value         = loc_oBO.this_nPesagem + loc_oBO.this_nSaldoFunc
1259:             .txt_4c_FalhaFunc.Value     = loc_oBO.this_nFalhaFunc
1260:         ENDWITH
1261:     ENDPROC
1262: 
1263:     *==========================================================================
1264:     * CmdVisualizarClick - Exibe relatorio em tela (Preview)
1265:     *==========================================================================
1266:     PROCEDURE CmdVisualizarClick()
1267:         LOCAL loc_cRelatorio
1268:         IF THIS.cnt_4c_Resultado.Visible
1269:             IF USED("TmpImp")
1270:                 SELECT TmpImp
1271:                 GO TOP
1272:                 IF !EOF()
1273:                     loc_cRelatorio = gc_4c_CaminhoBase + "reports\RelSigPrFem.frx"
1274:                     IF FILE(loc_cRelatorio)
1275:                         REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
1276:                     ELSE
1277:                         MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado." + CHR(13) + loc_cRelatorio)
1278:                     ENDIF
1279:                 ENDIF
1280:             ENDIF
1281:         ENDIF
1282:     ENDPROC
1283: 
1284:     *==========================================================================
1285:     * CmdImprimirClick - Envia relatorio para impressora
1286:     *==========================================================================
1287:     PROCEDURE CmdImprimirClick()
1288:         LOCAL loc_cRelatorio
1289:         IF THIS.cnt_4c_Resultado.Visible
1290:             IF USED("TmpImp")
1291:                 SELECT TmpImp
1292:                 GO TOP
1293:                 IF !EOF()
1294:                     loc_cRelatorio = gc_4c_CaminhoBase + "reports\RelSigPrFem.frx"
1295:                     IF FILE(loc_cRelatorio)
1296:                         REPORT FORM (loc_cRelatorio) TO PRINT PROMPT NOCONSOLE
1297:                     ELSE
1298:                         MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado." + CHR(13) + loc_cRelatorio)
1299:                     ENDIF
1300:                 ENDIF
1301:             ENDIF
1302:         ENDIF
1303:     ENDPROC
1304: 
1305:     *==========================================================================
1306:     * CmdEncerrarClick - Fecha o formulario
1307:     *==========================================================================
1308:     PROCEDURE CmdEncerrarClick()
1309:         THIS.Release()
1310:     ENDPROC
1311: 
1312:     *==========================================================================
1313:     * DemonstrativoKeyPress - F4/Enter/Tab disparam validacao ou picker
1314:     * LPARAMETERS obrigatorio como primeira linha (BINDEVENT KeyPress)
1315:     *==========================================================================
1316:     PROCEDURE DemonstrativoKeyPress
1317:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1318:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1319:             THIS.AbrirLookupDemonstrativo()
1320:             RETURN
1321:         ENDIF
1322:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1323:             THIS.ValidarDemonstrativo()
1324:         ENDIF
1325:     ENDPROC
1326: 
1327:     *==========================================================================
1328:     * ValidarDemonstrativo - Valida valor digitado contra SigPrDmo
1329:     * Chamado por DemonstrativoKeyPress em Enter/Tab (NAO por LostFocus)
1330:     *==========================================================================
1331:     PROTECTED PROCEDURE ValidarDemonstrativo()
1332:         LOCAL loc_cValor, loc_nRet
1333:         loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1334:         IF EMPTY(loc_cValor)
1335:             RETURN
1336:         ENDIF
1337:         IF USED("cursor_4c_DmoValida")
1338:             USE IN cursor_4c_DmoValida
1339:         ENDIF
1340:         loc_nRet = SQLEXEC(gnConnHandle, ;
1341:             "SELECT TOP 1 Nome FROM SigPrDmo WHERE Nome = " + EscaparSQL(loc_cValor), ;
1342:             "cursor_4c_DmoValida")
1343:         IF loc_nRet > 0 AND NOT EOF("cursor_4c_DmoValida")
1344:             SELECT cursor_4c_DmoValida
1345:             THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
1346:         ELSE
1347:             THIS.AbrirLookupDemonstrativo()
1348:         ENDIF
1349:         IF USED("cursor_4c_DmoValida")
1350:             USE IN cursor_4c_DmoValida
1351:         ENDIF
1352:         THIS.txt_4c_Demonstrativo.Refresh
1353:     ENDPROC
1354: 
1355:     *==========================================================================
1356:     * AbrirLookupDemonstrativo - Abre FormBuscaAuxiliar para SigPrDmo
1357:     * Equivalente ao fwBuscaExt do legado (Get_Demonstrativo.Valid)
1358:     *==========================================================================
1359:     PROCEDURE AbrirLookupDemonstrativo()
1360:         LOCAL loc_oForm, loc_cValor
1361:         loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1362: 
1363:         IF USED("cursor_4c_DmoLista")
1364:             USE IN cursor_4c_DmoLista
1365:         ENDIF
1366: 
1367:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1368:             "SigPrDmo", "cursor_4c_DmoLista", "Nome", loc_cValor, ;
1369:             "Sele" + CHR(231) + CHR(227) + "o")
1370: 
1371:         IF VARTYPE(loc_oForm) != "O"
1372:             RETURN
1373:         ENDIF
1374: 
1375:         IF loc_oForm.this_lAchouRegistro
1376:             IF USED("cursor_4c_DmoLista")
1377:                 SELECT cursor_4c_DmoLista
1378:                 THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
1379:             ENDIF
1380:         ELSE
1381:             loc_oForm.mAddColuna("Nome", "", "Nome")
1382:             loc_oForm.Show()
1383:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_DmoLista")
1384:                 SELECT cursor_4c_DmoLista
1385:                 THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
1386:             ENDIF
1387:         ENDIF
1388: 
1389:         IF USED("cursor_4c_DmoLista")
1390:             USE IN cursor_4c_DmoLista
1391:         ENDIF
1392: 
1393:         THIS.txt_4c_Demonstrativo.Refresh
1394:     ENDPROC
1395: 
1396:     *==========================================================================
1397:     * BtnIncluirClick - Nova analise: limpa filtros/resultados e foca DataI
1398:     *==========================================================================
1399:     PROCEDURE BtnIncluirClick()
1400:         LOCAL loc_oErro
1401:         TRY
1402:             THIS.cnt_4c_Resultado.Visible = .F.
1403: 
1404:             THIS.txt_4c_DataI.Value         = {}
1405:             THIS.txt_4c_DataF.Value         = DATE()
1406:             THIS.txt_4c_Demonstrativo.Value = ""
1407: 
1408:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1409:                 THIS.this_oBusinessObject.this_dDatai         = {}
1410:                 THIS.this_oBusinessObject.this_dDataf         = DATE()
1411:                 THIS.this_oBusinessObject.this_cDemonstrativo = ""
1412:                 THIS.this_oBusinessObject.this_nSaldoIni      = 0
1413:                 THIS.this_oBusinessObject.this_nSaldoaFun     = 0
1414:                 THIS.this_oBusinessObject.this_nTotalEntra    = 0
1415:                 THIS.this_oBusinessObject.this_nTotalSaida    = 0
1416:                 THIS.this_oBusinessObject.this_nSaldoFunc     = 0
1417:                 THIS.this_oBusinessObject.this_nPesagem       = 0
1418:                 THIS.this_oBusinessObject.this_nFalhaFunc     = 0
1419:             ENDIF
1420: 
1421:             THIS.Refresh
1422:             THIS.txt_4c_DataI.SetFocus
1423:         CATCH TO loc_oErro
1424:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1425:                 "Erro ao Iniciar Nova An" + CHR(225) + "lise")
1426:         ENDTRY
1427:     ENDPROC
1428: 
1429:     *==========================================================================
1430:     * BtnAlterarClick - Reprocessa a analise com os parametros atuais
1431:     *==========================================================================
1432:     PROCEDURE BtnAlterarClick()
1433:         LOCAL loc_oErro
1434:         TRY
1435:             IF EMPTY(THIS.txt_4c_DataF.Value)
1436:                 MsgAviso("A Data Final deve ser informada.", ;
1437:                     "Reprocessamento")
1438:                 THIS.txt_4c_DataF.SetFocus
1439:                 RETURN
1440:             ENDIF
1441: 
1442:             IF EMPTY(THIS.txt_4c_Demonstrativo.Value)
1443:                 MsgAviso("A Configura" + CHR(231) + CHR(227) + ;
1444:                     "o do Demonstrativo deve ser informada.", ;
1445:                     "Reprocessamento")
1446:                 THIS.txt_4c_Demonstrativo.SetFocus
1447:                 RETURN
1448:             ENDIF
1449: 
1450:             THIS.CmdProcessarClick()
1451:         CATCH TO loc_oErro
1452:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1453:                 "Erro ao Reprocessar")
1454:         ENDTRY
1455:     ENDPROC
1456: 
1457:     *==========================================================================
1458:     * BtnVisualizarClick - Visualiza relatorio (delega para CmdVisualizarClick)
1459:     *==========================================================================
1460:     PROCEDURE BtnVisualizarClick()
1461:         LOCAL loc_oErro
1462:         TRY
1463:             IF !THIS.cnt_4c_Resultado.Visible
1464:                 MsgAviso("Processe a an" + CHR(225) + "lise antes de visualizar o relat" + ;
1465:                     CHR(243) + "rio.", "Visualizar")
1466:                 RETURN
1467:             ENDIF
1468:             THIS.CmdVisualizarClick()
1469:         CATCH TO loc_oErro
1470:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1471:                 "Erro ao Visualizar")
1472:         ENDTRY
1473:     ENDPROC
1474: 
1475:     *==========================================================================
1476:     * BtnExcluirClick - Limpa cursores de resultado e oculta painel
1477:     *==========================================================================
1478:     PROCEDURE BtnExcluirClick()
1479:         LOCAL loc_oErro, loc_lConfirma
1480:         TRY
1481:             IF !THIS.cnt_4c_Resultado.Visible
1482:                 RETURN
1483:             ENDIF
1484: 
1485:             loc_lConfirma = MsgConfirma("Deseja limpar os resultados da an" + ;
1486:                 CHR(225) + "lise atual?", "Limpar Resultados")
1487: 
1488:             IF !loc_lConfirma
1489:                 RETURN
1490:             ENDIF
1491: 
1492:             IF USED("Entradas")
1493:                 SELECT Entradas
1494:                 ZAP
1495:             ENDIF
1496:             IF USED("Saidas")
1497:                 SELECT Saidas
1498:                 ZAP
1499:             ENDIF
1500:             IF USED("Saldos")
1501:                 SELECT Saldos
1502:                 ZAP
1503:             ENDIF
1504:             IF USED("SaldoAnt")
1505:                 SELECT SaldoAnt
1506:                 ZAP
1507:             ENDIF
1508:             IF USED("Falhas")
1509:                 SELECT Falhas
1510:                 ZAP
1511:             ENDIF
1512:             IF USED("TmpResumo")
1513:                 SELECT TmpResumo
1514:                 ZAP
1515:             ENDIF
1516:             IF USED("TmpImp")
1517:                 SELECT TmpImp
1518:                 ZAP

*-- Linhas 1539 a 1582:
1539:     *==========================================================================
1540:     * Destroy - Limpeza de recursos (cursores de referencia e trabalho)
1541:     *==========================================================================
1542:     PROCEDURE Destroy()
1543:         IF USED("crSigCdPam")
1544:             USE IN crSigCdPam
1545:         ENDIF
1546:         IF USED("crSigCdPac")
1547:             USE IN crSigCdPac
1548:         ENDIF
1549:         IF USED("crSigCdOpe")
1550:             USE IN crSigCdOpe
1551:         ENDIF
1552:         IF USED("crSigCdOpd")
1553:             USE IN crSigCdOpd
1554:         ENDIF
1555:         IF USED("crSigCdGcr")
1556:             USE IN crSigCdGcr
1557:         ENDIF
1558:         IF USED("crSigCdUni")
1559:             USE IN crSigCdUni
1560:         ENDIF
1561:         IF USED("LocalGru")
1562:             USE IN LocalGru
1563:         ENDIF
1564:         IF USED("LocalGgrp")
1565:             USE IN LocalGgrp
1566:         ENDIF
1567:         IF USED("Entradas")
1568:             USE IN Entradas
1569:         ENDIF
1570:         IF USED("Saidas")
1571:             USE IN Saidas
1572:         ENDIF
1573:         IF USED("Saldos")
1574:             USE IN Saldos
1575:         ENDIF
1576:         IF USED("SaldoAnt")
1577:             USE IN SaldoAnt
1578:         ENDIF
1579:         IF USED("Falhas")
1580:             USE IN Falhas
1581:         ENDIF
1582:         IF USED("TmpResumo")

*-- Linhas 1594 a 1821:
1594:     *==========================================================================
1595:     * BtnBuscarClick - Abre lookup do Demonstrativo (F5/Buscar do padrao CRUD)
1596:     *==========================================================================
1597:     PROCEDURE BtnBuscarClick()
1598:         LOCAL loc_oErro
1599:         TRY
1600:             THIS.AbrirLookupDemonstrativo()
1601:         CATCH TO loc_oErro
1602:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1603:                 "Erro ao Buscar")
1604:         ENDTRY
1605:     ENDPROC
1606: 
1607:     *==========================================================================
1608:     * BtnEncerrarClick - Delega para CmdEncerrarClick (fecha o form)
1609:     *==========================================================================
1610:     PROCEDURE BtnEncerrarClick()
1611:         LOCAL loc_oErro
1612:         TRY
1613:             THIS.CmdEncerrarClick()
1614:         CATCH TO loc_oErro
1615:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1616:                 "Erro ao Encerrar")
1617:         ENDTRY
1618:     ENDPROC
1619: 
1620:     *==========================================================================
1621:     * BtnSalvarClick - Confirma parametros e dispara processamento
1622:     * (Form OPERACIONAL nao persiste dados; equivalente a "Processar")
1623:     *==========================================================================
1624:     PROCEDURE BtnSalvarClick()
1625:         LOCAL loc_oErro
1626:         TRY
1627:             IF !THIS.FormParaBO()
1628:                 loc_lResultado = .F.
1629:             ENDIF
1630:             THIS.CmdProcessarClick()
1631:             loc_lResultado = .T.
1632:         CATCH TO loc_oErro
1633:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1634:                 "Erro ao Processar")
1635:             loc_lResultado = .F.
1636:         ENDTRY
1637:     ENDPROC
1638: 
1639:     *==========================================================================
1640:     * BtnCancelarClick - Cancela / limpa resultados sem confirmacao
1641:     *==========================================================================
1642:     PROCEDURE BtnCancelarClick()
1643:         LOCAL loc_oErro
1644:         TRY
1645:             THIS.LimparCampos()
1646:             THIS.cnt_4c_Resultado.Visible = .F.
1647:             THIS.Refresh
1648:             IF PEMSTATUS(THIS, "txt_4c_DataI", 5)
1649:                 THIS.txt_4c_DataI.SetFocus
1650:             ENDIF
1651:         CATCH TO loc_oErro
1652:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1653:                 "Erro ao Cancelar")
1654:         ENDTRY
1655:     ENDPROC
1656: 
1657:     *==========================================================================
1658:     * FormParaBO - Sincroniza filtros do form -> BO (Datai, Dataf, Demonstrativo)
1659:     * Retorna .T. se todos os campos obrigatorios estao preenchidos.
1660:     *==========================================================================
1661:     PROCEDURE FormParaBO()
1662:         LOCAL loc_lOK
1663:         loc_lOK = .F.
1664: 
1665:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1666:             MsgErro("Business Object nao inicializado.", "Erro")
1667:             RETURN .F.
1668:         ENDIF
1669: 
1670:         IF EMPTY(THIS.txt_4c_DataF.Value)
1671:             MsgAviso("A Data Final deve ser informada.", ;
1672:                 "Valida" + CHR(231) + CHR(227) + "o")
1673:             THIS.txt_4c_DataF.SetFocus
1674:             RETURN .F.
1675:         ENDIF
1676: 
1677:         IF !EMPTY(THIS.txt_4c_DataI.Value) AND ;
1678:            THIS.txt_4c_DataI.Value > THIS.txt_4c_DataF.Value
1679:             MsgAviso("A Data Final deve ser maior que a Data Inicial.", ;
1680:                 "Valida" + CHR(231) + CHR(227) + "o")
1681:             THIS.txt_4c_DataI.SetFocus
1682:             RETURN .F.
1683:         ENDIF
1684: 
1685:         IF EMPTY(ALLTRIM(THIS.txt_4c_Demonstrativo.Value))
1686:             MsgAviso("A Configura" + CHR(231) + CHR(227) + ;
1687:                 "o do Demonstrativo deve ser informada.", ;
1688:                 "Valida" + CHR(231) + CHR(227) + "o")
1689:             THIS.txt_4c_Demonstrativo.SetFocus
1690:             RETURN .F.
1691:         ENDIF
1692: 
1693:         THIS.this_oBusinessObject.this_dDatai         = THIS.txt_4c_DataI.Value
1694:         THIS.this_oBusinessObject.this_dDataf         = THIS.txt_4c_DataF.Value
1695:         THIS.this_oBusinessObject.this_cDemonstrativo = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1696: 
1697:         loc_lOK = .T.
1698:         RETURN loc_lOK
1699:     ENDPROC
1700: 
1701:     *==========================================================================
1702:     * BOParaForm - Sincroniza BO -> form (filtros + totalizadores do resumo)
1703:     *==========================================================================
1704:     PROCEDURE BOParaForm()
1705:         LOCAL loc_oBO
1706:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1707:             RETURN .F.
1708:         ENDIF
1709:         loc_oBO = THIS.this_oBusinessObject
1710: 
1711:         THIS.txt_4c_DataI.Value         = loc_oBO.this_dDatai
1712:         THIS.txt_4c_DataF.Value         = loc_oBO.this_dDataf
1713:         THIS.txt_4c_Demonstrativo.Value = loc_oBO.this_cDemonstrativo
1714: 
1715:         WITH THIS.cnt_4c_Resultado.cnt_4c_Resumo
1716:             .txt_4c_Saldoi.Value    = loc_oBO.this_nSaldoIni
1717:             .txt_4c_SaldoAnt.Value  = loc_oBO.this_nSaldoaFun
1718:             .txt_4c_Entradas.Value  = loc_oBO.this_nTotalEntra
1719:             .txt_4c_TEntradas.Value = loc_oBO.this_nSaldoIni + loc_oBO.this_nSaldoaFun + loc_oBO.this_nTotalEntra
1720:             .txt_4c_Saidas.Value    = loc_oBO.this_nTotalSaida
1721:             .txt_4c_Saldo.Value     = (loc_oBO.this_nSaldoIni + loc_oBO.this_nSaldoaFun + loc_oBO.this_nTotalEntra) - loc_oBO.this_nTotalSaida
1722:             .txt_4c_SaldoFunc.Value = loc_oBO.this_nSaldoFunc
1723:             .txt_4c_Pesagem.Value   = loc_oBO.this_nPesagem
1724:             .txt_4c_SaldoT.Value    = loc_oBO.this_nSaldoFunc + loc_oBO.this_nPesagem
1725:             .txt_4c_FalhaFunc.Value = loc_oBO.this_nFalhaFunc
1726:             .Visible     = .T.
1727:         ENDWITH
1728: 
1729:         THIS.Refresh
1730:         RETURN .T.
1731:     ENDPROC
1732: 
1733:     *==========================================================================
1734:     * HabilitarCampos - Habilita/desabilita filtros conforme par_lHabilitar
1735:     * (Form OPERACIONAL: filtros sempre editaveis; durante processamento
1736:     *  podem ser desabilitados temporariamente)
1737:     *==========================================================================
1738:     PROCEDURE HabilitarCampos(par_lHabilitar)
1739:         LOCAL loc_lHab
1740:         loc_lHab = IIF(PCOUNT() = 0, .T., par_lHabilitar)
1741: 
1742:         THIS.txt_4c_DataI.Enabled         = loc_lHab
1743:         THIS.txt_4c_DataF.Enabled         = loc_lHab
1744:         THIS.txt_4c_Demonstrativo.Enabled = loc_lHab
1745:         THIS.cmd_4c_Processar.Enabled     = loc_lHab
1746:         THIS.cmd_4c_Visualizar.Enabled    = loc_lHab AND THIS.cnt_4c_Resultado.Visible
1747:         THIS.cmd_4c_Imprimir.Enabled      = loc_lHab AND THIS.cnt_4c_Resultado.Visible
1748:         THIS.cmd_4c_Encerrar.Enabled      = .T.
1749:     ENDPROC
1750: 
1751:     *==========================================================================
1752:     * LimparCampos - Reseta filtros e propriedades do BO
1753:     *==========================================================================
1754:     PROCEDURE LimparCampos()
1755:         THIS.txt_4c_DataI.Value         = {}
1756:         THIS.txt_4c_DataF.Value         = DATE()
1757:         THIS.txt_4c_Demonstrativo.Value = ""
1758: 
1759:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1760:             THIS.this_oBusinessObject.this_dDatai         = {}
1761:             THIS.this_oBusinessObject.this_dDataf         = DATE()
1762:             THIS.this_oBusinessObject.this_cDemonstrativo = ""
1763:             THIS.this_oBusinessObject.this_nSaldoIni      = 0
1764:             THIS.this_oBusinessObject.this_nSaldoaFun     = 0
1765:             THIS.this_oBusinessObject.this_nTotalEntra    = 0
1766:             THIS.this_oBusinessObject.this_nTotalSaida    = 0
1767:             THIS.this_oBusinessObject.this_nSaldoFunc     = 0
1768:             THIS.this_oBusinessObject.this_nPesagem       = 0
1769:             THIS.this_oBusinessObject.this_nFalhaFunc     = 0
1770:         ENDIF
1771: 
1772:         WITH THIS.cnt_4c_Resultado.cnt_4c_Resumo
1773:             .txt_4c_Saldoi.Value    = 0
1774:             .txt_4c_SaldoAnt.Value  = 0
1775:             .txt_4c_Entradas.Value  = 0
1776:             .txt_4c_TEntradas.Value = 0
1777:             .txt_4c_Saidas.Value    = 0
1778:             .txt_4c_Saldo.Value     = 0
1779:             .txt_4c_SaldoFunc.Value = 0
1780:             .txt_4c_Pesagem.Value   = 0
1781:             .txt_4c_SaldoT.Value    = 0
1782:             .txt_4c_FalhaFunc.Value = 0
1783:             .Visible     = .T.
1784:         ENDWITH
1785:     ENDPROC
1786: 
1787:     *==========================================================================
1788:     * CarregarLista - Recarrega grades de resultado (delega para AtualizarGrades)
1789:     * (Nome preservado por contrato com FormBase / padrao dos forms migrados)
1790:     *==========================================================================
1791:     PROCEDURE CarregarLista()
1792:         LOCAL loc_oErro
1793:         TRY
1794:             IF !THIS.cnt_4c_Resultado.Visible
1795:                 loc_lResultado = .F.
1796:             ENDIF
1797:             THIS.AtualizarGrades()
1798:             THIS.AtualizarTotalizadores()
1799:             loc_lResultado = .T.
1800:         CATCH TO loc_oErro
1801:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1802:                 "Erro em CarregarLista")
1803:             loc_lResultado = .F.
1804:         ENDTRY
1805:     ENDPROC
1806: 
1807:     *==========================================================================
1808:     * AjustarBotoesPorModo - Contrato do FormBase; OPERACIONAL nao tem modos CRUD
1809:     * Ajusta apenas Visualizar/Imprimir conforme resultados exibidos.
1810:     *==========================================================================
1811:     PROCEDURE AjustarBotoesPorModo()
1812:         LOCAL loc_lTemResultado
1813:         loc_lTemResultado = THIS.cnt_4c_Resultado.Visible
1814: 
1815:         THIS.cmd_4c_Processar.Enabled  = .T.
1816:         THIS.cmd_4c_Visualizar.Enabled = loc_lTemResultado
1817:         THIS.cmd_4c_Imprimir.Enabled   = loc_lTemResultado
1818:         THIS.cmd_4c_Encerrar.Enabled   = .T.
1819:     ENDPROC
1820: 
1821: ENDDEFINE

