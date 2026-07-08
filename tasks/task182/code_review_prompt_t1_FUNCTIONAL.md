# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (23)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_DETALHE, CNT_4C_DETALHE2, CNT_4C_DETALHE3, CNT_4C_DETALHE4, CNT_4C_DETALHE5, CNT_4C_RESUMO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).
- [GRID-WITH] Bloco WITH loc_oRes.cnt_4c_Detalhe2 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oRes.cnt_4c_Detalhe2.RecordSource).
- [GRID-WITH] Bloco WITH loc_oRes.cnt_4c_Detalhe3 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oRes.cnt_4c_Detalhe3.RecordSource).
- [GRID-WITH] Bloco WITH loc_oRes.cnt_4c_Detalhe4 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oRes.cnt_4c_Detalhe4.RecordSource).
- [GRID-WITH] Bloco WITH loc_oRes.cnt_4c_Detalhe5 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oRes.cnt_4c_Detalhe5.RecordSource).
- [GRID-HEADER] Header Caption 'Fase' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Qtde' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Qtde' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Qtde' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Fase' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Qtde' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Fase' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Falha' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1819 linhas total):

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

*-- Linhas 1075 a 1516:
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
1088:             IF UPPER(loc_oControl.Name) = "CNT_4C_RESULTADO"
1089:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1090:                     THIS.TornarControlesVisiveis(loc_oControl)
1091:                 ENDIF
1092:                 LOOP
1093:             ENDIF
1094:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1095:                 loc_oControl.Visible = .T.
1096:             ENDIF
1097:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1098:                 THIS.TornarControlesVisiveis(loc_oControl)
1099:             ENDIF
1100:         ENDFOR
1101:     ENDPROC
1102: 
1103:     *==========================================================================
1104:     * CmdProcessarClick - Equivalente a Processar.Click do legado
1105:     *==========================================================================
1106:     PROCEDURE CmdProcessarClick()
1107:         LOCAL loc_oBO, loc_oErro, loc_lSucesso
1108:         loc_lSucesso = .F.
1109: 
1110:         TRY
1111:             loc_oBO = THIS.this_oBusinessObject
1112: 
1113:             loc_oBO.this_dDatai         = THIS.txt_4c_DataI.Value
1114:             loc_oBO.this_dDataf         = THIS.txt_4c_DataF.Value
1115:             loc_oBO.this_cDemonstrativo = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1116: 
1117:             THIS.cnt_4c_Resultado.Visible = .F.
1118:             THIS.Refresh
1119: 
1120:             IF loc_oBO.ProcessarAnalise()
1121:                 THIS.AtualizarGrades()
1122:                 THIS.AtualizarTotalizadores()
1123:                 THIS.cnt_4c_Resultado.Visible = .T.
1124:                 THIS.Refresh
1125:                 loc_lSucesso = .T.
1126:             ENDIF
1127: 
1128:         CATCH TO loc_oErro
1129:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1130:                 "Erro ao Processar")
1131:         ENDTRY
1132: 
1133:         RETURN loc_lSucesso
1134:     ENDPROC
1135: 
1136:     *==========================================================================
1137:     * AtualizarGrades - Vincula RecordSource/ControlSource em cada grade
1138:     *==========================================================================
1139:     PROTECTED PROCEDURE AtualizarGrades()
1140:         LOCAL loc_oRes
1141:         loc_oRes = THIS.cnt_4c_Resultado
1142: 
1143:         IF USED("SaldoAnt")
1144:             SELECT SaldoAnt
1145:             GO TOP
1146:         ENDIF
1147:         WITH loc_oRes.cnt_4c_Detalhe
1148:             .Visible = .T.
1149:             WITH .grd_4c_Dados
1150:                 .ColumnCount             = 3
1151:                 .RecordSource            = "SaldoAnt"
1152:                 .Column1.ControlSource   = "SaldoAnt.Grupos"
1153:                 .Column1.Header1.Caption = "Fase"
1154:                 .Column2.ControlSource   = "SaldoAnt.Qtde"
1155:                 .Column2.Header1.Caption = "Qtde"
1156:                 .Column3.ControlSource   = "SaldoAnt.Emps"
1157:                 .Column3.Header1.Caption = "Emp"
1158:                 .Refresh
1159:             ENDWITH
1160:         ENDWITH
1161: 
1162:         IF USED("Entradas")
1163:             SELECT Entradas
1164:             GO TOP
1165:         ENDIF
1166:         WITH loc_oRes.cnt_4c_Detalhe2
1167:             .Visible = .T.
1168:             WITH .grd_4c_Dados
1169:                 .ColumnCount             = 3
1170:                 .RecordSource            = "Entradas"
1171:                 .Column1.ControlSource   = "Entradas.TpOps"
1172:                 .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1173:                 .Column2.ControlSource   = "Entradas.Qtde"
1174:                 .Column2.Header1.Caption = "Qtde"
1175:                 .Column3.ControlSource   = "Entradas.Emps"
1176:                 .Column3.Header1.Caption = "Emp"
1177:                 .Refresh
1178:             ENDWITH
1179:         ENDWITH
1180: 
1181:         IF USED("Saidas")
1182:             SELECT Saidas
1183:             GO TOP
1184:         ENDIF
1185:         WITH loc_oRes.cnt_4c_Detalhe3
1186:             .Visible = .T.
1187:             WITH .grd_4c_Dados
1188:                 .ColumnCount             = 3
1189:                 .RecordSource            = "Saidas"
1190:                 .Column1.ControlSource   = "Saidas.TpOps"
1191:                 .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1192:                 .Column2.ControlSource   = "Saidas.Qtde"
1193:                 .Column2.Header1.Caption = "Qtde"
1194:                 .Column3.ControlSource   = "Saidas.Emps"
1195:                 .Column3.Header1.Caption = "Emp"
1196:                 .Refresh
1197:             ENDWITH
1198:         ENDWITH
1199: 
1200:         IF USED("Saldos")
1201:             SELECT Saldos
1202:             GO TOP
1203:         ENDIF
1204:         WITH loc_oRes.cnt_4c_Detalhe4
1205:             .Visible = .T.
1206:             WITH .grd_4c_Dados
1207:                 .ColumnCount             = 3
1208:                 .RecordSource            = "Saldos"
1209:                 .Column1.ControlSource   = "Saldos.Grupos"
1210:                 .Column1.Header1.Caption = "Fase"
1211:                 .Column2.ControlSource   = "Saldos.Qtde"
1212:                 .Column2.Header1.Caption = "Qtde"
1213:                 .Column3.ControlSource   = "Saldos.Emps"
1214:                 .Column3.Header1.Caption = "Emp"
1215:                 .Refresh
1216:             ENDWITH
1217:         ENDWITH
1218: 
1219:         IF USED("Falhas")
1220:             SELECT Falhas
1221:             GO TOP
1222:         ENDIF
1223:         WITH loc_oRes.cnt_4c_Detalhe5
1224:             .Visible = .T.
1225:             WITH .grd_4c_Dados
1226:                 .ColumnCount             = 3
1227:                 .RecordSource            = "Falhas"
1228:                 .Column1.ControlSource   = "Falhas.Grupos"
1229:                 .Column1.Header1.Caption = "Fase"
1230:                 .Column2.ControlSource   = "Falhas.Qtde"
1231:                 .Column2.Header1.Caption = "Falha"
1232:                 .Column3.ControlSource   = "Falhas.Emps"
1233:                 .Column3.Header1.Caption = "Emp"
1234:                 .Refresh
1235:             ENDWITH
1236:         ENDWITH
1237:     ENDPROC
1238: 
1239:     *==========================================================================
1240:     * AtualizarTotalizadores - Preenche TextBoxes do Resumo com valores do BO
1241:     *==========================================================================
1242:     PROTECTED PROCEDURE AtualizarTotalizadores()
1243:         LOCAL loc_oBO, loc_oResumo
1244:         loc_oBO     = THIS.this_oBusinessObject
1245:         loc_oResumo = THIS.cnt_4c_Resultado.cnt_4c_Resumo
1246: 
1247:         WITH loc_oResumo
1248:             .txt_4c_SaldoIni.Value      = loc_oBO.this_nSaldoIni
1249:             .txt_4c_SaldoAntP.Value     = loc_oBO.this_nSaldoaFun
1250:             .txt_4c_Entradas.Value      = loc_oBO.this_nTotalEntra
1251:             .txt_4c_TotalEntradas.Value = loc_oBO.this_nSaldoIni + loc_oBO.this_nTotalEntra + loc_oBO.this_nSaldoaFun
1252:             .txt_4c_Saidas.Value        = loc_oBO.this_nTotalSaida
1253:             .txt_4c_Saldo.Value         = loc_oBO.this_nSaldoIni + loc_oBO.this_nTotalEntra - loc_oBO.this_nTotalSaida + loc_oBO.this_nSaldoaFun
1254:             .txt_4c_SaldoFunc.Value     = loc_oBO.this_nSaldoFunc
1255:             .txt_4c_Pesagem.Value       = loc_oBO.this_nPesagem
1256:             .txt_4c_Total.Value         = loc_oBO.this_nPesagem + loc_oBO.this_nSaldoFunc
1257:             .txt_4c_FalhaFunc.Value     = loc_oBO.this_nFalhaFunc
1258:         ENDWITH
1259:     ENDPROC
1260: 
1261:     *==========================================================================
1262:     * CmdVisualizarClick - Exibe relatorio em tela (Preview)
1263:     *==========================================================================
1264:     PROCEDURE CmdVisualizarClick()
1265:         LOCAL loc_cRelatorio
1266:         IF THIS.cnt_4c_Resultado.Visible
1267:             IF USED("TmpImp")
1268:                 SELECT TmpImp
1269:                 GO TOP
1270:                 IF !EOF()
1271:                     loc_cRelatorio = gc_4c_CaminhoBase + "reports\RelSigPrFem.frx"
1272:                     IF FILE(loc_cRelatorio)
1273:                         REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
1274:                     ELSE
1275:                         MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado." + CHR(13) + loc_cRelatorio)
1276:                     ENDIF
1277:                 ENDIF
1278:             ENDIF
1279:         ENDIF
1280:     ENDPROC
1281: 
1282:     *==========================================================================
1283:     * CmdImprimirClick - Envia relatorio para impressora
1284:     *==========================================================================
1285:     PROCEDURE CmdImprimirClick()
1286:         LOCAL loc_cRelatorio
1287:         IF THIS.cnt_4c_Resultado.Visible
1288:             IF USED("TmpImp")
1289:                 SELECT TmpImp
1290:                 GO TOP
1291:                 IF !EOF()
1292:                     loc_cRelatorio = gc_4c_CaminhoBase + "reports\RelSigPrFem.frx"
1293:                     IF FILE(loc_cRelatorio)
1294:                         REPORT FORM (loc_cRelatorio) TO PRINT PROMPT NOCONSOLE
1295:                     ELSE
1296:                         MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado." + CHR(13) + loc_cRelatorio)
1297:                     ENDIF
1298:                 ENDIF
1299:             ENDIF
1300:         ENDIF
1301:     ENDPROC
1302: 
1303:     *==========================================================================
1304:     * CmdEncerrarClick - Fecha o formulario
1305:     *==========================================================================
1306:     PROCEDURE CmdEncerrarClick()
1307:         THIS.Release()
1308:     ENDPROC
1309: 
1310:     *==========================================================================
1311:     * DemonstrativoKeyPress - F4/Enter/Tab disparam validacao ou picker
1312:     * LPARAMETERS obrigatorio como primeira linha (BINDEVENT KeyPress)
1313:     *==========================================================================
1314:     PROCEDURE DemonstrativoKeyPress
1315:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1316:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1317:             THIS.AbrirLookupDemonstrativo()
1318:             RETURN
1319:         ENDIF
1320:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1321:             THIS.ValidarDemonstrativo()
1322:         ENDIF
1323:     ENDPROC
1324: 
1325:     *==========================================================================
1326:     * ValidarDemonstrativo - Valida valor digitado contra SigPrDmo
1327:     * Chamado por DemonstrativoKeyPress em Enter/Tab (NAO por LostFocus)
1328:     *==========================================================================
1329:     PROTECTED PROCEDURE ValidarDemonstrativo()
1330:         LOCAL loc_cValor, loc_nRet
1331:         loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1332:         IF EMPTY(loc_cValor)
1333:             RETURN
1334:         ENDIF
1335:         IF USED("cursor_4c_DmoValida")
1336:             USE IN cursor_4c_DmoValida
1337:         ENDIF
1338:         loc_nRet = SQLEXEC(gnConnHandle, ;
1339:             "SELECT TOP 1 Nome FROM SigPrDmo WHERE Nome = " + EscaparSQL(loc_cValor), ;
1340:             "cursor_4c_DmoValida")
1341:         IF loc_nRet > 0 AND NOT EOF("cursor_4c_DmoValida")
1342:             SELECT cursor_4c_DmoValida
1343:             THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
1344:         ELSE
1345:             THIS.AbrirLookupDemonstrativo()
1346:         ENDIF
1347:         IF USED("cursor_4c_DmoValida")
1348:             USE IN cursor_4c_DmoValida
1349:         ENDIF
1350:         THIS.txt_4c_Demonstrativo.Refresh
1351:     ENDPROC
1352: 
1353:     *==========================================================================
1354:     * AbrirLookupDemonstrativo - Abre FormBuscaAuxiliar para SigPrDmo
1355:     * Equivalente ao fwBuscaExt do legado (Get_Demonstrativo.Valid)
1356:     *==========================================================================
1357:     PROCEDURE AbrirLookupDemonstrativo()
1358:         LOCAL loc_oForm, loc_cValor
1359:         loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1360: 
1361:         IF USED("cursor_4c_DmoLista")
1362:             USE IN cursor_4c_DmoLista
1363:         ENDIF
1364: 
1365:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1366:             "SigPrDmo", "cursor_4c_DmoLista", "Nome", loc_cValor, ;
1367:             "Sele" + CHR(231) + CHR(227) + "o")
1368: 
1369:         IF VARTYPE(loc_oForm) != "O"
1370:             RETURN
1371:         ENDIF
1372: 
1373:         IF loc_oForm.this_lAchouRegistro
1374:             IF USED("cursor_4c_DmoLista")
1375:                 SELECT cursor_4c_DmoLista
1376:                 THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
1377:             ENDIF
1378:         ELSE
1379:             loc_oForm.mAddColuna("Nome", "", "Nome")
1380:             loc_oForm.Show()
1381:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_DmoLista")
1382:                 SELECT cursor_4c_DmoLista
1383:                 THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
1384:             ENDIF
1385:         ENDIF
1386: 
1387:         IF USED("cursor_4c_DmoLista")
1388:             USE IN cursor_4c_DmoLista
1389:         ENDIF
1390: 
1391:         THIS.txt_4c_Demonstrativo.Refresh
1392:     ENDPROC
1393: 
1394:     *==========================================================================
1395:     * BtnIncluirClick - Nova analise: limpa filtros/resultados e foca DataI
1396:     *==========================================================================
1397:     PROCEDURE BtnIncluirClick()
1398:         LOCAL loc_oErro
1399:         TRY
1400:             THIS.cnt_4c_Resultado.Visible = .F.
1401: 
1402:             THIS.txt_4c_DataI.Value         = {}
1403:             THIS.txt_4c_DataF.Value         = DATE()
1404:             THIS.txt_4c_Demonstrativo.Value = ""
1405: 
1406:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1407:                 THIS.this_oBusinessObject.this_dDatai         = {}
1408:                 THIS.this_oBusinessObject.this_dDataf         = DATE()
1409:                 THIS.this_oBusinessObject.this_cDemonstrativo = ""
1410:                 THIS.this_oBusinessObject.this_nSaldoIni      = 0
1411:                 THIS.this_oBusinessObject.this_nSaldoaFun     = 0
1412:                 THIS.this_oBusinessObject.this_nTotalEntra    = 0
1413:                 THIS.this_oBusinessObject.this_nTotalSaida    = 0
1414:                 THIS.this_oBusinessObject.this_nSaldoFunc     = 0
1415:                 THIS.this_oBusinessObject.this_nPesagem       = 0
1416:                 THIS.this_oBusinessObject.this_nFalhaFunc     = 0
1417:             ENDIF
1418: 
1419:             THIS.Refresh
1420:             THIS.txt_4c_DataI.SetFocus
1421:         CATCH TO loc_oErro
1422:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1423:                 "Erro ao Iniciar Nova An" + CHR(225) + "lise")
1424:         ENDTRY
1425:     ENDPROC
1426: 
1427:     *==========================================================================
1428:     * BtnAlterarClick - Reprocessa a analise com os parametros atuais
1429:     *==========================================================================
1430:     PROCEDURE BtnAlterarClick()
1431:         LOCAL loc_oErro
1432:         TRY
1433:             IF EMPTY(THIS.txt_4c_DataF.Value)
1434:                 MsgAviso("A Data Final deve ser informada.", ;
1435:                     "Reprocessamento")
1436:                 THIS.txt_4c_DataF.SetFocus
1437:                 RETURN
1438:             ENDIF
1439: 
1440:             IF EMPTY(THIS.txt_4c_Demonstrativo.Value)
1441:                 MsgAviso("A Configura" + CHR(231) + CHR(227) + ;
1442:                     "o do Demonstrativo deve ser informada.", ;
1443:                     "Reprocessamento")
1444:                 THIS.txt_4c_Demonstrativo.SetFocus
1445:                 RETURN
1446:             ENDIF
1447: 
1448:             THIS.CmdProcessarClick()
1449:         CATCH TO loc_oErro
1450:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1451:                 "Erro ao Reprocessar")
1452:         ENDTRY
1453:     ENDPROC
1454: 
1455:     *==========================================================================
1456:     * BtnVisualizarClick - Visualiza relatorio (delega para CmdVisualizarClick)
1457:     *==========================================================================
1458:     PROCEDURE BtnVisualizarClick()
1459:         LOCAL loc_oErro
1460:         TRY
1461:             IF !THIS.cnt_4c_Resultado.Visible
1462:                 MsgAviso("Processe a an" + CHR(225) + "lise antes de visualizar o relat" + ;
1463:                     CHR(243) + "rio.", "Visualizar")
1464:                 RETURN
1465:             ENDIF
1466:             THIS.CmdVisualizarClick()
1467:         CATCH TO loc_oErro
1468:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1469:                 "Erro ao Visualizar")
1470:         ENDTRY
1471:     ENDPROC
1472: 
1473:     *==========================================================================
1474:     * BtnExcluirClick - Limpa cursores de resultado e oculta painel
1475:     *==========================================================================
1476:     PROCEDURE BtnExcluirClick()
1477:         LOCAL loc_oErro, loc_lConfirma
1478:         TRY
1479:             IF !THIS.cnt_4c_Resultado.Visible
1480:                 RETURN
1481:             ENDIF
1482: 
1483:             loc_lConfirma = MsgConfirma("Deseja limpar os resultados da an" + ;
1484:                 CHR(225) + "lise atual?", "Limpar Resultados")
1485: 
1486:             IF !loc_lConfirma
1487:                 RETURN
1488:             ENDIF
1489: 
1490:             IF USED("Entradas")
1491:                 SELECT Entradas
1492:                 ZAP
1493:             ENDIF
1494:             IF USED("Saidas")
1495:                 SELECT Saidas
1496:                 ZAP
1497:             ENDIF
1498:             IF USED("Saldos")
1499:                 SELECT Saldos
1500:                 ZAP
1501:             ENDIF
1502:             IF USED("SaldoAnt")
1503:                 SELECT SaldoAnt
1504:                 ZAP
1505:             ENDIF
1506:             IF USED("Falhas")
1507:                 SELECT Falhas
1508:                 ZAP
1509:             ENDIF
1510:             IF USED("TmpResumo")
1511:                 SELECT TmpResumo
1512:                 ZAP
1513:             ENDIF
1514:             IF USED("TmpImp")
1515:                 SELECT TmpImp
1516:                 ZAP

*-- Linhas 1537 a 1580:
1537:     *==========================================================================
1538:     * Destroy - Limpeza de recursos (cursores de referencia e trabalho)
1539:     *==========================================================================
1540:     PROCEDURE Destroy()
1541:         IF USED("crSigCdPam")
1542:             USE IN crSigCdPam
1543:         ENDIF
1544:         IF USED("crSigCdPac")
1545:             USE IN crSigCdPac
1546:         ENDIF
1547:         IF USED("crSigCdOpe")
1548:             USE IN crSigCdOpe
1549:         ENDIF
1550:         IF USED("crSigCdOpd")
1551:             USE IN crSigCdOpd
1552:         ENDIF
1553:         IF USED("crSigCdGcr")
1554:             USE IN crSigCdGcr
1555:         ENDIF
1556:         IF USED("crSigCdUni")
1557:             USE IN crSigCdUni
1558:         ENDIF
1559:         IF USED("LocalGru")
1560:             USE IN LocalGru
1561:         ENDIF
1562:         IF USED("LocalGgrp")
1563:             USE IN LocalGgrp
1564:         ENDIF
1565:         IF USED("Entradas")
1566:             USE IN Entradas
1567:         ENDIF
1568:         IF USED("Saidas")
1569:             USE IN Saidas
1570:         ENDIF
1571:         IF USED("Saldos")
1572:             USE IN Saldos
1573:         ENDIF
1574:         IF USED("SaldoAnt")
1575:             USE IN SaldoAnt
1576:         ENDIF
1577:         IF USED("Falhas")
1578:             USE IN Falhas
1579:         ENDIF
1580:         IF USED("TmpResumo")

*-- Linhas 1592 a 1819:
1592:     *==========================================================================
1593:     * BtnBuscarClick - Abre lookup do Demonstrativo (F5/Buscar do padrao CRUD)
1594:     *==========================================================================
1595:     PROCEDURE BtnBuscarClick()
1596:         LOCAL loc_oErro
1597:         TRY
1598:             THIS.AbrirLookupDemonstrativo()
1599:         CATCH TO loc_oErro
1600:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1601:                 "Erro ao Buscar")
1602:         ENDTRY
1603:     ENDPROC
1604: 
1605:     *==========================================================================
1606:     * BtnEncerrarClick - Delega para CmdEncerrarClick (fecha o form)
1607:     *==========================================================================
1608:     PROCEDURE BtnEncerrarClick()
1609:         LOCAL loc_oErro
1610:         TRY
1611:             THIS.CmdEncerrarClick()
1612:         CATCH TO loc_oErro
1613:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1614:                 "Erro ao Encerrar")
1615:         ENDTRY
1616:     ENDPROC
1617: 
1618:     *==========================================================================
1619:     * BtnSalvarClick - Confirma parametros e dispara processamento
1620:     * (Form OPERACIONAL nao persiste dados; equivalente a "Processar")
1621:     *==========================================================================
1622:     PROCEDURE BtnSalvarClick()
1623:         LOCAL loc_oErro
1624:         TRY
1625:             IF !THIS.FormParaBO()
1626:                 loc_lResultado = .F.
1627:             ENDIF
1628:             THIS.CmdProcessarClick()
1629:             loc_lResultado = .T.
1630:         CATCH TO loc_oErro
1631:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1632:                 "Erro ao Processar")
1633:             loc_lResultado = .F.
1634:         ENDTRY
1635:     ENDPROC
1636: 
1637:     *==========================================================================
1638:     * BtnCancelarClick - Cancela / limpa resultados sem confirmacao
1639:     *==========================================================================
1640:     PROCEDURE BtnCancelarClick()
1641:         LOCAL loc_oErro
1642:         TRY
1643:             THIS.LimparCampos()
1644:             THIS.cnt_4c_Resultado.Visible = .F.
1645:             THIS.Refresh
1646:             IF PEMSTATUS(THIS, "txt_4c_DataI", 5)
1647:                 THIS.txt_4c_DataI.SetFocus
1648:             ENDIF
1649:         CATCH TO loc_oErro
1650:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1651:                 "Erro ao Cancelar")
1652:         ENDTRY
1653:     ENDPROC
1654: 
1655:     *==========================================================================
1656:     * FormParaBO - Sincroniza filtros do form -> BO (Datai, Dataf, Demonstrativo)
1657:     * Retorna .T. se todos os campos obrigatorios estao preenchidos.
1658:     *==========================================================================
1659:     PROCEDURE FormParaBO()
1660:         LOCAL loc_lOK
1661:         loc_lOK = .F.
1662: 
1663:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1664:             MsgErro("Business Object nao inicializado.", "Erro")
1665:             RETURN .F.
1666:         ENDIF
1667: 
1668:         IF EMPTY(THIS.txt_4c_DataF.Value)
1669:             MsgAviso("A Data Final deve ser informada.", ;
1670:                 "Valida" + CHR(231) + CHR(227) + "o")
1671:             THIS.txt_4c_DataF.SetFocus
1672:             RETURN .F.
1673:         ENDIF
1674: 
1675:         IF !EMPTY(THIS.txt_4c_DataI.Value) AND ;
1676:            THIS.txt_4c_DataI.Value > THIS.txt_4c_DataF.Value
1677:             MsgAviso("A Data Final deve ser maior que a Data Inicial.", ;
1678:                 "Valida" + CHR(231) + CHR(227) + "o")
1679:             THIS.txt_4c_DataI.SetFocus
1680:             RETURN .F.
1681:         ENDIF
1682: 
1683:         IF EMPTY(ALLTRIM(THIS.txt_4c_Demonstrativo.Value))
1684:             MsgAviso("A Configura" + CHR(231) + CHR(227) + ;
1685:                 "o do Demonstrativo deve ser informada.", ;
1686:                 "Valida" + CHR(231) + CHR(227) + "o")
1687:             THIS.txt_4c_Demonstrativo.SetFocus
1688:             RETURN .F.
1689:         ENDIF
1690: 
1691:         THIS.this_oBusinessObject.this_dDatai         = THIS.txt_4c_DataI.Value
1692:         THIS.this_oBusinessObject.this_dDataf         = THIS.txt_4c_DataF.Value
1693:         THIS.this_oBusinessObject.this_cDemonstrativo = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1694: 
1695:         loc_lOK = .T.
1696:         RETURN loc_lOK
1697:     ENDPROC
1698: 
1699:     *==========================================================================
1700:     * BOParaForm - Sincroniza BO -> form (filtros + totalizadores do resumo)
1701:     *==========================================================================
1702:     PROCEDURE BOParaForm()
1703:         LOCAL loc_oBO
1704:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1705:             RETURN .F.
1706:         ENDIF
1707:         loc_oBO = THIS.this_oBusinessObject
1708: 
1709:         THIS.txt_4c_DataI.Value         = loc_oBO.this_dDatai
1710:         THIS.txt_4c_DataF.Value         = loc_oBO.this_dDataf
1711:         THIS.txt_4c_Demonstrativo.Value = loc_oBO.this_cDemonstrativo
1712: 
1713:         WITH THIS.cnt_4c_Resultado.cnt_4c_Resumo
1714:             .txt_4c_Saldoi.Value    = loc_oBO.this_nSaldoIni
1715:             .txt_4c_SaldoAnt.Value  = loc_oBO.this_nSaldoaFun
1716:             .txt_4c_Entradas.Value  = loc_oBO.this_nTotalEntra
1717:             .txt_4c_TEntradas.Value = loc_oBO.this_nSaldoIni + loc_oBO.this_nSaldoaFun + loc_oBO.this_nTotalEntra
1718:             .txt_4c_Saidas.Value    = loc_oBO.this_nTotalSaida
1719:             .txt_4c_Saldo.Value     = (loc_oBO.this_nSaldoIni + loc_oBO.this_nSaldoaFun + loc_oBO.this_nTotalEntra) - loc_oBO.this_nTotalSaida
1720:             .txt_4c_SaldoFunc.Value = loc_oBO.this_nSaldoFunc
1721:             .txt_4c_Pesagem.Value   = loc_oBO.this_nPesagem
1722:             .txt_4c_SaldoT.Value    = loc_oBO.this_nSaldoFunc + loc_oBO.this_nPesagem
1723:             .txt_4c_FalhaFunc.Value = loc_oBO.this_nFalhaFunc
1724:             .Visible     = .T.
1725:         ENDWITH
1726: 
1727:         THIS.Refresh
1728:         RETURN .T.
1729:     ENDPROC
1730: 
1731:     *==========================================================================
1732:     * HabilitarCampos - Habilita/desabilita filtros conforme par_lHabilitar
1733:     * (Form OPERACIONAL: filtros sempre editaveis; durante processamento
1734:     *  podem ser desabilitados temporariamente)
1735:     *==========================================================================
1736:     PROCEDURE HabilitarCampos(par_lHabilitar)
1737:         LOCAL loc_lHab
1738:         loc_lHab = IIF(PCOUNT() = 0, .T., par_lHabilitar)
1739: 
1740:         THIS.txt_4c_DataI.Enabled         = loc_lHab
1741:         THIS.txt_4c_DataF.Enabled         = loc_lHab
1742:         THIS.txt_4c_Demonstrativo.Enabled = loc_lHab
1743:         THIS.cmd_4c_Processar.Enabled     = loc_lHab
1744:         THIS.cmd_4c_Visualizar.Enabled    = loc_lHab AND THIS.cnt_4c_Resultado.Visible
1745:         THIS.cmd_4c_Imprimir.Enabled      = loc_lHab AND THIS.cnt_4c_Resultado.Visible
1746:         THIS.cmd_4c_Encerrar.Enabled      = .T.
1747:     ENDPROC
1748: 
1749:     *==========================================================================
1750:     * LimparCampos - Reseta filtros e propriedades do BO
1751:     *==========================================================================
1752:     PROCEDURE LimparCampos()
1753:         THIS.txt_4c_DataI.Value         = {}
1754:         THIS.txt_4c_DataF.Value         = DATE()
1755:         THIS.txt_4c_Demonstrativo.Value = ""
1756: 
1757:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1758:             THIS.this_oBusinessObject.this_dDatai         = {}
1759:             THIS.this_oBusinessObject.this_dDataf         = DATE()
1760:             THIS.this_oBusinessObject.this_cDemonstrativo = ""
1761:             THIS.this_oBusinessObject.this_nSaldoIni      = 0
1762:             THIS.this_oBusinessObject.this_nSaldoaFun     = 0
1763:             THIS.this_oBusinessObject.this_nTotalEntra    = 0
1764:             THIS.this_oBusinessObject.this_nTotalSaida    = 0
1765:             THIS.this_oBusinessObject.this_nSaldoFunc     = 0
1766:             THIS.this_oBusinessObject.this_nPesagem       = 0
1767:             THIS.this_oBusinessObject.this_nFalhaFunc     = 0
1768:         ENDIF
1769: 
1770:         WITH THIS.cnt_4c_Resultado.cnt_4c_Resumo
1771:             .txt_4c_Saldoi.Value    = 0
1772:             .txt_4c_SaldoAnt.Value  = 0
1773:             .txt_4c_Entradas.Value  = 0
1774:             .txt_4c_TEntradas.Value = 0
1775:             .txt_4c_Saidas.Value    = 0
1776:             .txt_4c_Saldo.Value     = 0
1777:             .txt_4c_SaldoFunc.Value = 0
1778:             .txt_4c_Pesagem.Value   = 0
1779:             .txt_4c_SaldoT.Value    = 0
1780:             .txt_4c_FalhaFunc.Value = 0
1781:             .Visible     = .T.
1782:         ENDWITH
1783:     ENDPROC
1784: 
1785:     *==========================================================================
1786:     * CarregarLista - Recarrega grades de resultado (delega para AtualizarGrades)
1787:     * (Nome preservado por contrato com FormBase / padrao dos forms migrados)
1788:     *==========================================================================
1789:     PROCEDURE CarregarLista()
1790:         LOCAL loc_oErro
1791:         TRY
1792:             IF !THIS.cnt_4c_Resultado.Visible
1793:                 loc_lResultado = .F.
1794:             ENDIF
1795:             THIS.AtualizarGrades()
1796:             THIS.AtualizarTotalizadores()
1797:             loc_lResultado = .T.
1798:         CATCH TO loc_oErro
1799:             MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
1800:                 "Erro em CarregarLista")
1801:             loc_lResultado = .F.
1802:         ENDTRY
1803:     ENDPROC
1804: 
1805:     *==========================================================================
1806:     * AjustarBotoesPorModo - Contrato do FormBase; OPERACIONAL nao tem modos CRUD
1807:     * Ajusta apenas Visualizar/Imprimir conforme resultados exibidos.
1808:     *==========================================================================
1809:     PROCEDURE AjustarBotoesPorModo()
1810:         LOCAL loc_lTemResultado
1811:         loc_lTemResultado = THIS.cnt_4c_Resultado.Visible
1812: 
1813:         THIS.cmd_4c_Processar.Enabled  = .T.
1814:         THIS.cmd_4c_Visualizar.Enabled = loc_lTemResultado
1815:         THIS.cmd_4c_Imprimir.Enabled   = loc_lTemResultado
1816:         THIS.cmd_4c_Encerrar.Enabled   = .T.
1817:     ENDPROC
1818: 
1819: ENDDEFINE

