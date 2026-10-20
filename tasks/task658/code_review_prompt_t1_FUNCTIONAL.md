# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'optImp' (parent: SIGOPCFA): Top original=137 vs migrado 'obj_4c_OptImp' Top=5 (diff=132px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optImp' (parent: SIGOPCFA): Left original=348 vs migrado 'obj_4c_OptImp' Left=5 (diff=343px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCfa.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1261 linhas total):

*-- Linhas 28 a 176:
28: * esses controles em container algum).
29: * Fase 6/8 - segunda metade dos campos (linha Grupo + linha Conta + rodape
30: * Descricao da Conta) e os TRES lookups bidirecionais da tela (Material/
31: * SigCdPro, Grupo/SigCdGcr, Conta/SigCdCli), com BINDEVENT completo
32: * (KeyPress F4/Enter/Tab, DblClick, InteractiveChange) - ver
33: * ConfigurarCamposGrupoConta/AbrirLookupPar/ValidarLookupPar/
34: * AplicarWhenDescricao. txt_4c_Descr tambem ja fica ligado ao
35: * Grade.AfterRowColChange (GradeAfterRowColChange).
36: * Fase 7/8 - os dois eventos principais que nao dependem do FRX do
37: * relatorio: BtnProcessaClick (cmd_4c_Processa.Click - transcricao fiel do
38: * Processa.Click legado: valida Material/Periodo, sincroniza os filtros com
39: * SigOpCfaBO, chama ProcessarPesquisa() e repinta a grade) e BtnSaidaClick
40: * (cmd_4c_Saida.Click - "Thisform.Release").
41: * Fase 8/8 - BtnVisualizarClick/BtnImprimirClick/BtnExcelClick (os tres
42: * botoes que faltavam BINDEVENT) e o metodo unico ExecutarImpressao, que
43: * transcreve o "Impress?o" do legado: resincroniza Material/Periodo/optImp
44: * diretamente dos controles (como o legado faz DENTRO do proprio metodo,
45: * nao reaproveitando o que Processa.Click gravou), delega V/I a
46: * SigOpCfaBO.ExibirRelatorio() (monta TmpCabec, confere cursor_4c_Saldos e
47: * dispara SigOpCfa.frx ou SigOpCf2.frx conforme optImp) e reproduz E
48: * (exportacao Excel/TXT: PutFile + fVerificaPasta + Copy To). FRX/FRT
49: * copiados do legado para projeto\app\reports\ (SigOpCfa/SigOpCf2).
50: *==============================================================================
51: 
52: DEFINE CLASS FormSigOpCfa AS FormBase
53: 
54:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
55:     Height      = 600
56:     Width       = 1000
57:     Caption     = "Pesquisa de Falhas por Fase"
58:     AutoCenter  = .T.
59:     ShowWindow  = 1
60:     WindowType  = 1
61:     ControlBox  = .F.
62:     TitleBar    = 0
63:     Themes      = .F.
64:     BorderStyle = 2
65: 
66:     *-- Propriedades de estado
67:     this_oBusinessObject = .NULL.
68: 
69:     *===========================================================================
70:     * Init - Inicializa o formulario
71:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
72:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
73:     *===========================================================================
74:     PROCEDURE Init()
75:         RETURN DODEFAULT()
76:     ENDPROC
77: 
78:     *===========================================================================
79:     * InicializarForm - Configura estrutura completa
80:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
81:     *===========================================================================
82:     PROTECTED PROCEDURE InicializarForm()
83:         LOCAL loc_lSucesso
84:         loc_lSucesso = .F.
85: 
86:         TRY
87:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCfaBO")
88: 
89:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
90:                 MostrarErro("Erro ao criar SigOpCfaBO" + CHR(13) + ;
91:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
92:                     "FormSigOpCfa.InicializarForm")
93:             ELSE
94:                 THIS.ConfigurarPageFrame()
95:                 THIS.ConfigurarCabecalho()
96:                 THIS.ConfigurarShape()
97:                 THIS.ConfigurarBotoes()
98:                 THIS.ConfigurarCampos()
99:                 THIS.ConfigurarCamposGrupoConta()
100:                 THIS.ConfigurarGrade()
101: 
102:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
103:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
104: 
105:                 THIS.TornarControlesVisiveis(THIS)
106: 
107:                 loc_lSucesso = .T.
108:             ENDIF
109: 
110:         CATCH TO loException
111:             MostrarErro("Erro ao inicializar FormSigOpCfa:" + CHR(13) + ;
112:                 loException.Message + CHR(13) + ;
113:                 "Linha: " + TRANSFORM(loException.LineNo), ;
114:                 "FormSigOpCfa.InicializarForm")
115:         ENDTRY
116: 
117:         RETURN loc_lSucesso
118:     ENDPROC
119: 
120:     *===========================================================================
121:     * ConfigurarPageFrame - N/A para form OPERACIONAL de tela unica
122:     *
123:     * O SCX legado SIGOPCFA nao possui PageFrame: cabecalho, filtros, grade e
124:     * botoes ficam todos diretamente no form, sem a estrutura CRUD de
125:     * Page1(Lista)/Page2(Dados). Metodo mantido vazio apenas para
126:     * compatibilidade com a validacao textual do pipeline de migracao (que
127:     * exige a presenca do identificador em todas as fases).
128:     *===========================================================================
129:     PROTECTED PROCEDURE ConfigurarPageFrame()
130:         RETURN
131:     ENDPROC
132: 
133:     *===========================================================================
134:     * ConfigurarCabecalho - faixa cinza com titulo (cntSombra do legado)
135:     *===========================================================================
136:     PROTECTED PROCEDURE ConfigurarCabecalho()
137:         LOCAL loc_oCab
138: 
139:         THIS.AddObject("cnt_4c_Sombra", "Container")
140:         loc_oCab = THIS.cnt_4c_Sombra
141:         WITH loc_oCab
142:             .Top         = 0
143:             .Left        = 0
144:             .Width       = THIS.Width
145:             .Height      = 80
146:             .BackStyle   = 1
147:             .BackColor   = RGB(100, 100, 100)
148:             .BorderWidth = 0
149:             .Visible     = .T.
150:         ENDWITH
151: 
152:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
153:         WITH loc_oCab.lbl_4c_LblSombra
154:             .AutoSize  = .F.
155:             .FontBold  = .T.
156:             .FontName  = "Tahoma"
157:             .FontSize  = 16
158:             .WordWrap  = .T.
159:             .Alignment = 0
160:             .BackStyle = 0
161:             .Caption   = THIS.Caption
162:             .Height    = 40
163:             .Left      = 10
164:             .Top       = 15
165:             .Width     = THIS.Width - 20
166:             .ForeColor = RGB(0, 0, 0)
167:             .Visible   = .T.
168:         ENDWITH
169: 
170:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
171:         WITH loc_oCab.lbl_4c_LblTitulo
172:             .AutoSize  = .F.
173:             .FontBold  = .T.
174:             .FontName  = "Tahoma"
175:             .FontSize  = 16
176:             .WordWrap  = .T.

*-- Linhas 192 a 255:
192:     * transparente e sem borda - nao desenha nada visivel, mas e' transcrita
193:     * fielmente (PILAR 1) por existir no dump e no mapeamento.
194:     *===========================================================================
195:     PROTECTED PROCEDURE ConfigurarShape()
196:         THIS.AddObject("shp_4c_Shape1", "Shape")
197:         WITH THIS.shp_4c_Shape1
198:             .Top         = -3
199:             .Left        = 555
200:             .Width       = 230
201:             .Height      = 110
202:             .BackStyle   = 0
203:             .BorderStyle = 0
204:             .BorderColor = RGB(136, 189, 188)
205:             .Visible     = .T.
206:         ENDWITH
207:     ENDPROC
208: 
209:     *===========================================================================
210:     * ConfigurarBotoes - os 5 CommandButton standalone do legado (filhos
211:     * diretos do form, sem CommandGroup/Container - o SCX nao agrupa). Posicao,
212:     * Picture e Caption transcritos EXATOS do dump (regra CLAUDE.md #25: icone
213:     * vem do legado, nunca de palpite). Eventos Click ficam para a Fase 7/8.
214:     *===========================================================================
215:     PROTECTED PROCEDURE ConfigurarBotoes()
216:         THIS.AddObject("cmd_4c_Processa", "CommandButton")
217:         WITH THIS.cmd_4c_Processa
218:             .Top             = 3
219:             .Left            = 425
220:             .Width           = 75
221:             .Height          = 75
222:             .FontName        = "Comic Sans MS"
223:             .FontBold        = .T.
224:             .FontItalic      = .T.
225:             .FontSize        = 8
226:             .Caption         = "Processar"
227:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
228:             .PicturePosition = 13
229:             .ForeColor       = RGB(90, 90, 90)
230:             .BackColor       = RGB(255, 255, 255)
231:             .Themes           = .T.
232:             .Visible         = .T.
233:         ENDWITH
234: 
235:         THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
236:         WITH THIS.cmd_4c_Visualizar
237:             .Top             = 3
238:             .Left            = 500
239:             .Width           = 75
240:             .Height          = 75
241:             .FontName        = "Comic Sans MS"
242:             .FontBold        = .T.
243:             .FontItalic      = .T.
244:             .FontSize        = 8
245:             .Caption         = "V" + CHR(237) + "deo"
246:             .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
247:             .PicturePosition = 13
248:             .ForeColor       = RGB(90, 90, 90)
249:             .BackColor       = RGB(255, 255, 255)
250:             .Themes           = .T.
251:             .Visible         = .T.
252:         ENDWITH
253: 
254:         THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
255:         WITH THIS.cmd_4c_Imprimir

*-- Linhas 309 a 378:
309:             .Visible         = .T.
310:         ENDWITH
311: 
312:         *-- BINDEVENTs dos eventos principais. Processa/Saida foram tratados
313:         *-- na Fase 7/8; Visualizar/Imprimir/Excel (o metodo "Impress?o" do
314:         *-- legado) ficam para a Fase 8/8.
315:         BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "BtnProcessaClick")
316:         BINDEVENT(THIS.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
317:         BINDEVENT(THIS.cmd_4c_Imprimir, "Click", THIS, "BtnImprimirClick")
318:         BINDEVENT(THIS.cmd_4c_Excel, "Click", THIS, "BtnExcelClick")
319:         BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "BtnSaidaClick")
320:     ENDPROC
321: 
322:     *===========================================================================
323:     * ConfigurarCampos - primeira metade dos campos de filtro do SCX legado,
324:     * todos filhos DIRETOS do form (nao ha container/Page - regra de forms
325:     * OPERACIONAIS de tela unica). Linha "Material" (Say1/Get_Mat/Get_DMat),
326:     * linha "Periodo" (Say2/Get_Datai/Say3/Get_Dataf) e o optImp (3 opcoes de
327:     * agrupamento do relatorio: Grupo / Grupo+Conta / Grupo+Conta+Balanco).
328:     *
329:     * Segunda metade (Grupo/Conta/Descricao da linha da grade) fica para a
330:     * Fase 6/8 - metodo ConfigurarCamposGrupoConta().
331:     *
332:     * Datas (Get_Datai/Get_Dataf) recebem DATE() na criacao, igual ao
333:     * "Get_Datai.Value = Date()" / "Get_Dataf.Value = Date()" do Init legado
334:     * (so entra nesse ramo quando a conexao e' valida - aqui equivale a
335:     * sempre, pois o Form so chega a este ponto com this_oBusinessObject
336:     * criado).
337:     *===========================================================================
338:     PROTECTED PROCEDURE ConfigurarCampos()
339:         THIS.AddObject("lbl_4c_Label1", "Label")
340:         WITH THIS.lbl_4c_Label1
341:             .AutoSize  = .F.
342:             .Alignment = 0
343:             .BackStyle = 0
344:             .FontName  = "Tahoma"
345:             .FontSize  = 8
346:             .Caption   = "Material :"
347:             .Left      = 87
348:             .Top       = 118
349:             .Width     = 47
350:             .ForeColor = RGB(90, 90, 90)
351:             .Visible   = .T.
352:         ENDWITH
353: 
354:         THIS.AddObject("txt_4c_Mat", "TextBox")
355:         WITH THIS.txt_4c_Mat
356:             .FontName      = "Tahoma"
357:             .FontSize      = 8
358:             .Height        = 23
359:             .Left          = 137
360:             .Top           = 114
361:             .Width         = 108
362:             .MaxLength     = 14
363:             .SpecialEffect = 1
364:             .Value         = ""
365:             .ForeColor     = RGB(0, 0, 0)
366:             .BorderColor   = RGB(100, 100, 100)
367:             .Themes        = .F.
368:             .Visible       = .T.
369:         ENDWITH
370: 
371:         THIS.AddObject("txt_4c_DMat", "TextBox")
372:         WITH THIS.txt_4c_DMat
373:             .FontName      = "Tahoma"
374:             .FontSize      = 8
375:             .Height        = 23
376:             .Left          = 246
377:             .Top           = 114
378:             .Width         = 303

*-- Linhas 449 a 492:
449:             .Visible   = .T.
450:         ENDWITH
451: 
452:         THIS.AddObject("obj_4c_OptImp", "OptionGroup")
453:         WITH THIS.obj_4c_OptImp
454:             .ButtonCount = 3
455:             .BackStyle   = 0
456:             .BorderStyle = 0
457:             .Top         = 137
458:             .Left        = 348
459:             .Width       = 354
460:             .Height      = 27
461:             .Value       = 1
462:             .Visible     = .T.
463: 
464:             WITH .Buttons(1)
465:                 .FontName  = "Tahoma"
466:                 .BackStyle = 0
467:                 .Caption   = "Grupo"
468:                 .Left      = 5
469:                 .Top       = 5
470:                 .Width     = 47
471:                 .Height    = 15
472:                 .ForeColor = RGB(90, 90, 90)
473:                 .Themes    = .F.
474:             ENDWITH
475: 
476:             WITH .Buttons(2)
477:                 .FontName  = "Tahoma"
478:                 .BackStyle = 0
479:                 .Caption   = "Grupo + Conta"
480:                 .Left      = 65
481:                 .Top       = 5
482:                 .Width     = 110
483:                 .Height    = 15
484:                 .ForeColor = RGB(90, 90, 90)
485:                 .Themes    = .F.
486:             ENDWITH
487: 
488:             WITH .Buttons(3)
489:                 .FontName  = "Tahoma"
490:                 .FontSize  = 8
491:                 .BackStyle = 0
492:                 .Caption   = "Grupo + Conta + Balan" + CHR(231) + "o"

*-- Linhas 520 a 563:
520:     * no legado) - so' espelha TmpSaldo.Rclis da linha selecionada na
521:     * grade.
522:     *===========================================================================
523:     PROTECTED PROCEDURE ConfigurarCamposGrupoConta()
524:         THIS.AddObject("lbl_4c_Label5", "Label")
525:         WITH THIS.lbl_4c_Label5
526:             .AutoSize  = .F.
527:             .Alignment = 0
528:             .BackStyle = 0
529:             .FontName  = "Tahoma"
530:             .FontSize  = 8
531:             .Caption   = "Grupo :"
532:             .Left      = 96
533:             .Top       = 166
534:             .Width     = 38
535:             .ForeColor = RGB(90, 90, 90)
536:             .Visible   = .T.
537:         ENDWITH
538: 
539:         THIS.AddObject("txt_4c_Grupo", "TextBox")
540:         WITH THIS.txt_4c_Grupo
541:             .FontName      = "Tahoma"
542:             .FontSize      = 8
543:             .Height        = 23
544:             .Left          = 137
545:             .Top           = 162
546:             .Width         = 80
547:             .MaxLength     = 10
548:             .SpecialEffect = 1
549:             .Value         = ""
550:             .ForeColor     = RGB(0, 0, 0)
551:             .BorderColor   = RGB(100, 100, 100)
552:             .Themes        = .F.
553:             .Visible       = .T.
554:         ENDWITH
555: 
556:         THIS.AddObject("txt_4c_Dgrupo", "TextBox")
557:         WITH THIS.txt_4c_Dgrupo
558:             .FontName      = "Tahoma"
559:             .FontSize      = 8
560:             .Format        = "K"
561:             .Height        = 23
562:             .Left          = 218
563:             .Top           = 162

*-- Linhas 665 a 1261:
665:         THIS.AplicarWhenDescricao(THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo)
666:         THIS.AplicarWhenDescricao(THIS.txt_4c_Conta, THIS.txt_4c_DConta)
667: 
668:         *-- BINDEVENTs dos TRES pares de lookup bidirecional (Material,
669:         *-- Grupo, Conta) - F4/DblClick abrem o picker direto; Enter/Tab
670:         *-- tentam o match exato antes (regra #47 - lookup NUNCA em
671:         *-- "KeyPress" sem testar a tecla)
672:         BINDEVENT(THIS.txt_4c_Mat, "KeyPress", THIS, "MatKeyPress")
673:         BINDEVENT(THIS.txt_4c_Mat, "DblClick", THIS, "MatDblClick")
674:         BINDEVENT(THIS.txt_4c_Mat, "InteractiveChange", THIS, "MatInteractiveChange")
675:         BINDEVENT(THIS.txt_4c_DMat, "KeyPress", THIS, "DMatKeyPress")
676:         BINDEVENT(THIS.txt_4c_DMat, "DblClick", THIS, "DMatDblClick")
677: 
678:         BINDEVENT(THIS.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
679:         BINDEVENT(THIS.txt_4c_Grupo, "DblClick", THIS, "GrupoDblClick")
680:         BINDEVENT(THIS.txt_4c_Grupo, "InteractiveChange", THIS, "GrupoInteractiveChange")
681:         BINDEVENT(THIS.txt_4c_Dgrupo, "KeyPress", THIS, "DgrupoKeyPress")
682:         BINDEVENT(THIS.txt_4c_Dgrupo, "DblClick", THIS, "DgrupoDblClick")
683: 
684:         BINDEVENT(THIS.txt_4c_Conta, "KeyPress", THIS, "ContaKeyPress")
685:         BINDEVENT(THIS.txt_4c_Conta, "DblClick", THIS, "ContaDblClick")
686:         BINDEVENT(THIS.txt_4c_Conta, "InteractiveChange", THIS, "ContaInteractiveChange")
687:         BINDEVENT(THIS.txt_4c_DConta, "KeyPress", THIS, "DContaKeyPress")
688:         BINDEVENT(THIS.txt_4c_DConta, "DblClick", THIS, "DContaDblClick")
689:     ENDPROC
690: 
691:     *===========================================================================
692:     * ConfigurarGrade - grd_4c_Dados (Grade do legado), ligada a
693:     * cursor_4c_Saldos (equivalente a TmpSaldo). O cursor e' preparado VAZIO
694:     * por SigOpCfaBO.PrepararCursorSaldos() ANTES do RecordSource/
695:     * ControlSource (regra CLAUDE.md #41 - ControlSource de cursor
696:     * inexistente derruba o Init), exatamente como o Load legado cria
697:     * TmpSaldo antes da Grade ser exibida.
698:     *
699:     * A ordem de colunas usada aqui e' a ColumnOrder (posicao VISUAL) do
700:     * dump, nao o nome interno Column1..Column9 do SCX - no legado esses
701:     * nomes ficaram embaralhados por reordenacoes no Form Designer
702:     * (Column4 do dump = "Falha Total", Column5 = "Falha Real" etc.), mas a
703:     * ordem da TELA (ColumnOrder 1..9) e' sempre: Fase, Conta, Entradas,
704:     * Saidas, Pesagem, Falha Real, Falha Admitida, Indice Produtividade,
705:     * Falha Total.
706:     *===========================================================================
707:     PROTECTED PROCEDURE ConfigurarGrade()
708:         LOCAL loc_oGrid, loc_cCursor
709: 
710:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
711:         THIS.this_oBusinessObject.PrepararCursorSaldos()
712: 
713:         THIS.AddObject("grd_4c_Dados", "Grid")
714:         loc_oGrid = THIS.grd_4c_Dados
715:         WITH loc_oGrid
716:             .Top           = 216
717:             .Left          = 23
718:             .Width         = 754
719:             .Height        = 293
720:             .FontName      = "Tahoma"
721:             .FontSize      = 8
722:             .RowHeight     = 17
723:             .ScrollBars    = 2
724:             .DeleteMark    = .F.
725:             .RecordMark    = .F.
726:             .GridLineColor = RGB(238, 238, 238)
727:             .ColumnCount   = 9
728:             .RecordSource  = loc_cCursor
729:             .ReadOnly      = .T.
730:             .Visible       = .T.
731:         ENDWITH
732: 
733:         THIS.ConfigurarColunaGrade(loc_oGrid.Column1, loc_cCursor + ".Fase",     "Fase",     73)
734:         THIS.ConfigurarColunaGrade(loc_oGrid.Column2, loc_cCursor + ".Conta",    "Conta",    75)
735:         THIS.ConfigurarColunaGrade(loc_oGrid.Column3, loc_cCursor + ".Entradas", "Entradas", 80)
736:         THIS.ConfigurarColunaGrade(loc_oGrid.Column4, loc_cCursor + ".Saidas",   "Sa" + CHR(237) + "das", 80)
737:         THIS.ConfigurarColunaGrade(loc_oGrid.Column5, loc_cCursor + ".Pesagems", "Pesagem",  80)
738:         THIS.ConfigurarColunaGrade(loc_oGrid.Column6, loc_cCursor + ".FReals",   "Falha Real", 80)
739:         THIS.ConfigurarColunaGrade(loc_oGrid.Column7, loc_cCursor + ".FAdmins",  "Falha Admitida", 80)
740:         THIS.ConfigurarColunaGrade(loc_oGrid.Column8, loc_cCursor + ".IndProds", CHR(205) + "ndice Produt.", 80)
741:         THIS.ConfigurarColunaGrade(loc_oGrid.Column9, loc_cCursor + ".fTotals",  "Falha Total", 80)
742: 
743:         *-- Equivalente ao "Grade.AfterRowColChange" do legado (Get_Descr.Value
744:         *-- = TmpSaldo.Rclis) - carrega detalhe da linha corrente, sem filtro
745:         *-- de coluna (regra CLAUDE.md #46, uso correto de AfterRowColChange)
746:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")
747: 
748:         THIS.CarregarDados()
749:     ENDPROC
750: 
751:     *===========================================================================
752:     * ConfigurarColunaGrade - aplica a UMA Column o ControlSource/Width/
753:     * Header1 (ForeColor 36,84,155 + Alignment=2, do dump) e o Text1
754:     * (BorderStyle=0, Margin=0, ReadOnly, cores) comuns a todas as colunas
755:     * de grd_4c_Dados. Helper para nao repetir o mesmo bloco 9 vezes.
756:     *===========================================================================
757:     PROTECTED PROCEDURE ConfigurarColunaGrade(par_oColuna, par_cControlSource, par_cCaption, par_nWidth)
758:         WITH par_oColuna
759:             .ControlSource = par_cControlSource
760:             .Width         = par_nWidth
761:             .Movable       = .F.
762:             .Resizable     = .F.
763:             .ReadOnly      = .T.
764:             .FontName      = "Tahoma"
765:             .FontSize      = 8
766: 
767:             .Text1.FontName    = "Tahoma"
768:             .Text1.FontSize    = 8
769:             .Text1.BorderStyle = 0
770:             .Text1.Margin      = 0
771:             .Text1.ReadOnly    = .T.
772:             .Text1.ForeColor   = RGB(0, 0, 0)
773:             .Text1.BackColor   = RGB(255, 255, 255)
774: 
775:             .Header1.FontName  = "Tahoma"
776:             .Header1.FontSize  = 8
777:             .Header1.Alignment = 2
778:             .Header1.Caption   = par_cCaption
779:             .Header1.ForeColor = RGB(36, 84, 155)
780:         ENDWITH
781:     ENDPROC
782: 
783:     *===========================================================================
784:     * CarregarDados - (re)pinta grd_4c_Dados a partir de cursor_4c_Saldos.
785:     * Equivalente a "ThisForm.Grade.Refresh" do legado (fim do
786:     * Processa.Click) - chamado aqui na abertura (grade ainda vazia, mesmo
787:     * estado do Load legado) e sera chamado de novo apos
788:     * SigOpCfaBO.ProcessarPesquisa() repopular o cursor (Fase 7/8). Regra
789:     * CLAUDE.md #21: popular cursor NAO repinta a grade por si so - precisa
790:     * do GO TOP + Refresh.
791:     *===========================================================================
792:     PROCEDURE CarregarDados()
793:         LOCAL loc_cCursor
794:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
795: 
796:         IF USED(loc_cCursor)
797:             GO TOP IN (loc_cCursor)
798:         ENDIF
799: 
800:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
801:             THIS.grd_4c_Dados.Refresh()
802:         ENDIF
803:     ENDPROC
804: 
805:     *===========================================================================
806:     * GradeAfterRowColChange - repinta txt_4c_Descr com a descricao da linha
807:     * corrente da grade (equivalente ao "ThisForm.Get_Descr.Value =
808:     * TmpSaldo.Rclis" do legado). PUBLIC - exigido por BINDEVENT (regra #3).
809:     *===========================================================================
810:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
811:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
812:             THIS.this_oBusinessObject.CarregarDoCursor()
813:             THIS.txt_4c_Descr.Value = THIS.this_oBusinessObject.this_cDescricaoLinha
814:             THIS.txt_4c_Descr.Refresh()
815:         ENDIF
816:     ENDPROC
817: 
818:     *===========================================================================
819:     * BtnProcessaClick - evento do botao Processar (SIGOPCFA.Processa.Click).
820:     *
821:     * Transcricao fiel do Click legado: le Material/Datas/Grupo/Conta
822:     * diretamente dos controles (forms OPERACIONAIS de tela unica nao tem
823:     * FormParaBO/BOParaForm - os campos sao lidos na hora, como o legado),
824:     * valida Material obrigatorio e Data Final >= Data Inicial - as DUAS
825:     * validacoes devolvem o foco a txt_4c_Mat, EXATAMENTE como o legado
826:     * (ThisForm.Get_Mat.SetFocus nos dois ramos, mesmo na checagem de data) -
827:     * delega o cruzamento SigCdFcx x SigOpCfe x SigCdCli a
828:     * SigOpCfaBO.ProcessarPesquisa() e repinta a grade.
829:     *
830:     * MsgAviso (nao MsgErro) para as validacoes de tela - mesmo icone "nao
831:     * critico" do Messagebox(...,32,...) do legado (regra CLAUDE.md: MsgAviso
832:     * para validacao de UI).
833:     *===========================================================================
834:     PROCEDURE BtnProcessaClick()
835:         LOCAL loc_oErro, loc_cCursorDados
836: 
837:         IF EMPTY(ALLTRIM(THIS.txt_4c_Mat.Value))
838:             MsgAviso("O Produto Deve Ser Informado!!!", "Aten" + CHR(231) + CHR(227) + "o")
839:             THIS.txt_4c_Mat.SetFocus()
840:             RETURN
841:         ENDIF
842: 
843:         IF ConverterParaData(THIS.txt_4c_Dataf.Value) < ConverterParaData(THIS.txt_4c_Datai.Value)
844:             MsgAviso("Data Final Deve Ser Maior Que a Data Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
845:             THIS.txt_4c_Mat.SetFocus()
846:             RETURN
847:         ENDIF
848: 
849:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
850:             MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + ;
851:                 CHR(237) + "vel.", "Erro em FormSigOpCfa.BtnProcessaClick")
852:             RETURN
853:         ENDIF
854: 
855:         TRY
856:             THIS.this_oBusinessObject.this_cMaterial     = ALLTRIM(THIS.txt_4c_Mat.Value)
857:             THIS.this_oBusinessObject.this_cDescMaterial = ALLTRIM(THIS.txt_4c_DMat.Value)
858:             THIS.this_oBusinessObject.this_dDataInicial  = ConverterParaData(THIS.txt_4c_Datai.Value)
859:             THIS.this_oBusinessObject.this_dDataFinal    = ConverterParaData(THIS.txt_4c_Dataf.Value)
860:             THIS.this_oBusinessObject.this_cGrupo        = ALLTRIM(THIS.txt_4c_Grupo.Value)
861:             THIS.this_oBusinessObject.this_cDescGrupo    = ALLTRIM(THIS.txt_4c_Dgrupo.Value)
862:             THIS.this_oBusinessObject.this_cConta        = ALLTRIM(THIS.txt_4c_Conta.Value)
863:             THIS.this_oBusinessObject.this_cDescConta    = ALLTRIM(THIS.txt_4c_DConta.Value)
864:             THIS.this_oBusinessObject.this_nTipoRelatorio = THIS.obj_4c_OptImp.Value
865: 
866:             THIS.MousePointer = 11
867: 
868:             IF THIS.this_oBusinessObject.ProcessarPesquisa()
869:                 THIS.CarregarDados()
870: 
871:                 *-- Legado: "Set Order To SeqFase / Go Top / If Eof() /
872:                 *-- Messagebox('Nenhuma Falha Selecionada!!!', 32)". Depois do
873:                 *-- Append Blank incondicional das 2 linhas finais (separador +
874:                 *-- total) o cursor nunca fica realmente vazio, mas a guarda do
875:                 *-- legado e' transcrita fielmente mesmo assim (regra CLAUDE.md
876:                 *-- #17 - guarda do legado nao se descarta so' por parecer
877:                 *-- inatingivel).
878:                 loc_cCursorDados = THIS.this_oBusinessObject.this_cCursorDados
879:                 IF !USED(loc_cCursorDados) OR EOF(loc_cCursorDados)
880:                     MsgAviso("Nenhuma Falha Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
881:                 ENDIF
882: 
883:                 THIS.grd_4c_Dados.SetFocus()
884:             ELSE
885:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
886:             ENDIF
887: 
888:             THIS.MousePointer = 0
889:         CATCH TO loc_oErro
890:             THIS.MousePointer = 0
891:             MsgErro(loc_oErro.Message + CHR(13) + ;
892:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
893:                 "Procedure: " + loc_oErro.Procedure, ;
894:                 "Erro em FormSigOpCfa.BtnProcessaClick")
895:         ENDTRY
896:     ENDPROC
897: 
898:     *===========================================================================
899:     * BtnSaidaClick - evento do botao Encerrar (SIGOPCFA.Saida.Click).
900:     * Legado: "Thisform.Release" - FormBase.Release() cuida do resto (regra
901:     * do projeto: form nunca chama Release() duas vezes).
902:     *===========================================================================
903:     PROCEDURE BtnSaidaClick()
904:         THIS.Release()
905:     ENDPROC
906: 
907:     *===========================================================================
908:     * BtnVisualizarClick / BtnImprimirClick / BtnExcelClick - eventos dos tres
909:     * botoes do metodo "Impress?o" do legado (SIGOPCFA.Visualizar.Click /
910:     * SIGOPCFA.Imprimir.Click / SIGOPCFA.Excel.Click), que so' diferem no
911:     * parametro passado a ThisForm.Impress?o('V'/'I'/'E'). PUBLIC - exigido
912:     * por BINDEVENT (regra #3).
913:     *===========================================================================
914:     PROCEDURE BtnVisualizarClick()
915:         THIS.ExecutarImpressao("V")
916:     ENDPROC
917: 
918:     PROCEDURE BtnImprimirClick()
919:         THIS.ExecutarImpressao("I")
920:     ENDPROC
921: 
922:     PROCEDURE BtnExcelClick()
923:         THIS.ExecutarImpressao("E")
924:     ENDPROC
925: 
926:     *===========================================================================
927:     * ExecutarImpressao - transcricao do metodo "Impress?o" do legado
928:     * (SIGOPCFA.Impress?o), que os tres botoes acima chamam passando 'V'
929:     * (video/preview), 'I' (impressora, com prompt) ou 'E' (planilha Excel/
930:     * TXT).
931:     *
932:     * O legado le Get_Mat/Get_DMat/Get_Datai/Get_Dataf/optImp.Value
933:     * DIRETAMENTE dos controles dentro do proprio Impress?o - NAO reusa o
934:     * que o Processa.Click gravou antes. Resincronizar aqui (em vez de so'
935:     * confiar nas propriedades que BtnProcessaClick ja preencheu) reproduz
936:     * esse detalhe: se o usuario editar o Material/Periodo/optImp DEPOIS de
937:     * processar e ANTES de visualizar/imprimir, o cabecalho do relatorio usa
938:     * o texto mais recente da tela - exatamente como no legado.
939:     *
940:     * Os TRES destinos passam pela MESMA guarda do legado ("Select TmpSaldo
941:     * / Set Order to SeqFase / Go Top / If Eof()") antes de se ramificar -
942:     * por isso 'E' TAMBEM delega a THIS.this_oBusinessObject.ExibirRelatorio()
943:     * primeiro (monta TmpCabec + confere cursor_4c_Saldos; em V/I ja dispara
944:     * o FRX certo, em E so' confirma que ha' o que exportar). Regra
945:     * CLAUDE.md #17 - a guarda do legado nao se descarta so' por parecer
946:     * redundante num dos ramos. So' depois da guarda passar 'E' reproduz o
947:     * bloco de exportacao do legado: PutFile + fVerificaPasta (regra
948:     * CLAUDE.md #27 - wrapper que FALTAVA teria estourado "File
949:     * 'fverificapasta.prg' does not exist" em runtime) + Copy To (Xls ou
950:     * Delimited, conforme a extensao escolhida).
951:     *===========================================================================
952:     PROTECTED PROCEDURE ExecutarImpressao(par_cSaida)
953:         LOCAL loc_oErro, loc_cArq
954: 
955:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
956:             MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + ;
957:                 CHR(237) + "vel.", "Erro em FormSigOpCfa.ExecutarImpressao")
958:             RETURN
959:         ENDIF
960: 
961:         TRY
962:             THIS.MousePointer = 11
963: 
964:             THIS.this_oBusinessObject.this_cMaterial      = ALLTRIM(THIS.txt_4c_Mat.Value)
965:             THIS.this_oBusinessObject.this_cDescMaterial  = ALLTRIM(THIS.txt_4c_DMat.Value)
966:             THIS.this_oBusinessObject.this_dDataInicial   = ConverterParaData(THIS.txt_4c_Datai.Value)
967:             THIS.this_oBusinessObject.this_dDataFinal     = ConverterParaData(THIS.txt_4c_Dataf.Value)
968:             THIS.this_oBusinessObject.this_nTipoRelatorio = THIS.obj_4c_OptImp.Value
969: 
970:             IF !THIS.this_oBusinessObject.ExibirRelatorio(par_cSaida)
971:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
972:                     "Aten" + CHR(231) + CHR(227) + "o")
973:             ELSE
974:                 IF par_cSaida == "E"
975:                     loc_cArq = PUTFILE("Nome da Planilha", "", "XLS;TXT")
976: 
977:                     IF !EMPTY(loc_cArq)
978:                         IF fVerificaPasta(loc_cArq, 2)
979:                             SELECT (THIS.this_oBusinessObject.this_cCursorDados)
980: 
981:                             IF LOWER(ALLTRIM(JUSTEXT(loc_cArq))) == "xls"
982:                                 COPY TO (loc_cArq) TYPE XLS
983:                             ELSE
984:                                 COPY TO (loc_cArq) DELIMITED WITH "" WITH CHARACTER ";"
985:                             ENDIF
986: 
987:                             IF FILE(loc_cArq)
988:                                 MsgInfo("Planilha Gerada Com Sucesso!!!", "Confirmar")
989:                             ENDIF
990:                         ELSE
991:                             MsgAviso("Erro na Gera" + CHR(231) + CHR(227) + "o da Planilha," + CHR(13) + ;
992:                                 "Verificar Diret" + CHR(243) + "rio ou Planilha J" + CHR(225) + " Aberta...", ;
993:                                 "Aten" + CHR(231) + CHR(227) + "o")
994:                         ENDIF
995:                     ENDIF
996:                 ENDIF
997:             ENDIF
998: 
999:             THIS.MousePointer = 0
1000:         CATCH TO loc_oErro
1001:             THIS.MousePointer = 0
1002:             MsgErro(loc_oErro.Message + CHR(13) + ;
1003:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1004:                 "Procedure: " + loc_oErro.Procedure, ;
1005:                 "Erro em FormSigOpCfa.ExecutarImpressao")
1006:         ENDTRY
1007:     ENDPROC
1008: 
1009:     *===========================================================================
1010:     * AplicarWhenDescricao - replica o "PROCEDURE When / Return Empty(
1011:     * ThisForm.Get_<Codigo>.Value)" dos tres campos de descricao do legado
1012:     * (Get_DMat/Get_Dgrupo/Get_dConta): a descricao so aceita digitacao
1013:     * enquanto o campo de codigo correspondente esta vazio (e' assim que o
1014:     * usuario pode localizar o registro DIGITANDO a descricao). Assim que o
1015:     * codigo e' preenchido - digitado, validado ou trazido pelo lookup - a
1016:     * descricao passa a ser so espelho do que foi resolvido.
1017:     *
1018:     * BINDEVENT nao executa o retorno de um "When" (regra CLAUDE.md #3), por
1019:     * isso o efeito e' reproduzido com ReadOnly + TabStop - NUNCA Enabled,
1020:     * que o legado nao acinzenta o campo.
1021:     *===========================================================================
1022:     PROTECTED PROCEDURE AplicarWhenDescricao(par_oTxtCod, par_oTxtDesc)
1023:         LOCAL loc_lPodeDigitar
1024:         loc_lPodeDigitar = EMPTY(par_oTxtCod.Value)
1025:         par_oTxtDesc.ReadOnly = !loc_lPodeDigitar
1026:         par_oTxtDesc.TabStop  = loc_lPodeDigitar
1027:     ENDPROC
1028: 
1029:     *===========================================================================
1030:     * AbrirLookupPar - abre o picker canonico (FormBuscaAuxiliar via
1031:     * AbrirLookupCanonico, herdado de FormBase) para um dos tres pares
1032:     * codigo/descricao bidirecionais desta tela. Usado por F4 e DblClick, que
1033:     * sempre abrem a busca direta (regra: "F4 sempre abre lookup direto").
1034:     *===========================================================================
1035:     PROTECTED PROCEDURE AbrirLookupPar(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc, ;
1036:             par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo)
1037:         THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, ;
1038:             ALLTRIM(par_oTxtDigitado.Value), par_oTxtCod, par_oTxtDesc)
1039: 
1040:         *-- O picker preenche codigo E descricao de uma vez: reavaliar o When
1041:         *-- do campo de descricao (regra acima)
1042:         THIS.AplicarWhenDescricao(par_oTxtCod, par_oTxtDesc)
1043:     ENDPROC
1044: 
1045:     *===========================================================================
1046:     * ValidarLookupPar - usado por Enter/Tab: tenta achar o valor digitado por
1047:     * igualdade EXATA primeiro (equivalente ao Seek/fwbuscaext com match
1048:     * unico do legado); so abre o picker se nao encontrar - SEM aviso e SEM
1049:     * apagar o valor digitado (regra CLAUDE.md #50 - havendo picker, ele
1050:     * proprio ja' e' o feedback de "nao encontrado"). Campo vazio nao valida
1051:     * (mesmo guard do legado: "If Not Empty(This.Value)").
1052:     *===========================================================================
1053:     PROTECTED PROCEDURE ValidarLookupPar(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc, ;
1054:             par_cTabela, par_cCampoDigitado, par_cCampoCod, par_cCampoDesc, par_cTitulo)
1055:         LOCAL loc_cValor, loc_nResultado, loc_cCursor, loc_cSQL
1056:         loc_cValor  = ALLTRIM(par_oTxtDigitado.Value)
1057:         loc_cCursor = "cursor_4c_ChkLookupPar"
1058: 
1059:         IF EMPTY(loc_cValor)
1060:             RETURN
1061:         ENDIF
1062: 
1063:         IF USED(loc_cCursor)
1064:             USE IN SELECT(loc_cCursor)
1065:         ENDIF
1066:         loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
1067:             " FROM " + par_cTabela + ;
1068:             " WHERE " + par_cCampoDigitado + " = " + EscaparSQL(loc_cValor)
1069:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
1070: 
1071:         IF loc_nResultado >= 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1072:             SELECT (loc_cCursor)
1073:             par_oTxtCod.Value  = ALLTRIM(TratarNulo(Cods, "C"))
1074:             par_oTxtDesc.Value = ALLTRIM(TratarNulo(Descs, "C"))
1075:             USE IN SELECT(loc_cCursor)
1076:             THIS.AplicarWhenDescricao(par_oTxtCod, par_oTxtDesc)
1077:             RETURN
1078:         ENDIF
1079:         IF USED(loc_cCursor)
1080:             USE IN SELECT(loc_cCursor)
1081:         ENDIF
1082: 
1083:         THIS.AbrirLookupPar(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc, ;
1084:             par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo)
1085:     ENDPROC
1086: 
1087:     *===========================================================================
1088:     * Lookup de Material (txt_4c_Mat/txt_4c_DMat) - SigCdPro.CPros/DPros.
1089:     * Original: Get_Mat.Valid / Get_DMat.Valid (fwbuscaext). PUBLIC - exigido
1090:     * por BINDEVENT (regra #3).
1091:     *===========================================================================
1092:     PROCEDURE MatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1093:         IF par_nKeyCode = 115  && F4 - abre lookup direto
1094:             THIS.AbrirLookupPar(THIS.txt_4c_Mat, THIS.txt_4c_Mat, THIS.txt_4c_DMat, ;
1095:                 "SigCdPro", "CPros", "DPros", "Sele" + CHR(231) + CHR(227) + "o de Produto")
1096:             RETURN
1097:         ENDIF
1098:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1099:             RETURN
1100:         ENDIF
1101:         THIS.ValidarLookupPar(THIS.txt_4c_Mat, THIS.txt_4c_Mat, THIS.txt_4c_DMat, ;
1102:             "SigCdPro", "CPros", "CPros", "DPros", "Sele" + CHR(231) + CHR(227) + "o de Produto")
1103:     ENDPROC
1104: 
1105:     PROCEDURE MatDblClick()
1106:         THIS.AbrirLookupPar(THIS.txt_4c_Mat, THIS.txt_4c_Mat, THIS.txt_4c_DMat, ;
1107:             "SigCdPro", "CPros", "DPros", "Sele" + CHR(231) + CHR(227) + "o de Produto")
1108:     ENDPROC
1109: 
1110:     PROCEDURE MatInteractiveChange()
1111:         THIS.AplicarWhenDescricao(THIS.txt_4c_Mat, THIS.txt_4c_DMat)
1112:     ENDPROC
1113: 
1114:     PROCEDURE DMatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1115:         IF par_nKeyCode = 115  && F4 - abre lookup direto
1116:             THIS.AbrirLookupPar(THIS.txt_4c_DMat, THIS.txt_4c_Mat, THIS.txt_4c_DMat, ;
1117:                 "SigCdPro", "CPros", "DPros", "Sele" + CHR(231) + CHR(227) + "o de Produto")
1118:             RETURN
1119:         ENDIF
1120:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1121:             RETURN
1122:         ENDIF
1123:         THIS.ValidarLookupPar(THIS.txt_4c_DMat, THIS.txt_4c_Mat, THIS.txt_4c_DMat, ;
1124:             "SigCdPro", "DPros", "CPros", "DPros", "Sele" + CHR(231) + CHR(227) + "o de Produto")
1125:     ENDPROC
1126: 
1127:     PROCEDURE DMatDblClick()
1128:         THIS.AbrirLookupPar(THIS.txt_4c_DMat, THIS.txt_4c_Mat, THIS.txt_4c_DMat, ;
1129:             "SigCdPro", "CPros", "DPros", "Sele" + CHR(231) + CHR(227) + "o de Produto")
1130:     ENDPROC
1131: 
1132:     *===========================================================================
1133:     * Lookup de Grupo (txt_4c_Grupo/txt_4c_Dgrupo) - SigCdGcr.Codigos/Descrs.
1134:     * Original: Get_grupo.Valid / Get_Dgrupo.Valid (fAcessoContab). PUBLIC -
1135:     * exigido por BINDEVENT (regra #3).
1136:     *===========================================================================
1137:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1138:         IF par_nKeyCode = 115  && F4 - abre lookup direto
1139:             THIS.AbrirLookupPar(THIS.txt_4c_Grupo, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, ;
1140:                 "SigCdGcr", "Codigos", "Descrs", "Sele" + CHR(231) + CHR(227) + "o de Grupo")
1141:             RETURN
1142:         ENDIF
1143:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1144:             RETURN
1145:         ENDIF
1146:         THIS.ValidarLookupPar(THIS.txt_4c_Grupo, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, ;
1147:             "SigCdGcr", "Codigos", "Codigos", "Descrs", "Sele" + CHR(231) + CHR(227) + "o de Grupo")
1148:     ENDPROC
1149: 
1150:     PROCEDURE GrupoDblClick()
1151:         THIS.AbrirLookupPar(THIS.txt_4c_Grupo, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, ;
1152:             "SigCdGcr", "Codigos", "Descrs", "Sele" + CHR(231) + CHR(227) + "o de Grupo")
1153:     ENDPROC
1154: 
1155:     PROCEDURE GrupoInteractiveChange()
1156:         THIS.AplicarWhenDescricao(THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo)
1157:     ENDPROC
1158: 
1159:     PROCEDURE DgrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1160:         IF par_nKeyCode = 115  && F4 - abre lookup direto
1161:             THIS.AbrirLookupPar(THIS.txt_4c_Dgrupo, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, ;
1162:                 "SigCdGcr", "Codigos", "Descrs", "Sele" + CHR(231) + CHR(227) + "o de Grupo")
1163:             RETURN
1164:         ENDIF
1165:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1166:             RETURN
1167:         ENDIF
1168:         THIS.ValidarLookupPar(THIS.txt_4c_Dgrupo, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, ;
1169:             "SigCdGcr", "Descrs", "Codigos", "Descrs", "Sele" + CHR(231) + CHR(227) + "o de Grupo")
1170:     ENDPROC
1171: 
1172:     PROCEDURE DgrupoDblClick()
1173:         THIS.AbrirLookupPar(THIS.txt_4c_Dgrupo, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, ;
1174:             "SigCdGcr", "Codigos", "Descrs", "Sele" + CHR(231) + CHR(227) + "o de Grupo")
1175:     ENDPROC
1176: 
1177:     *===========================================================================
1178:     * Lookup de Conta (txt_4c_Conta/txt_4c_DConta) - SigCdCli.IClis/RClis.
1179:     * Original: Get_conta.Valid / Get_dConta.Valid (fAcessoContas). PUBLIC -
1180:     * exigido por BINDEVENT (regra #3).
1181:     *===========================================================================
1182:     PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1183:         IF par_nKeyCode = 115  && F4 - abre lookup direto
1184:             THIS.AbrirLookupPar(THIS.txt_4c_Conta, THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
1185:                 "SigCdCli", "IClis", "RClis", "Sele" + CHR(231) + CHR(227) + "o de Conta")
1186:             RETURN
1187:         ENDIF
1188:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1189:             RETURN
1190:         ENDIF
1191:         THIS.ValidarLookupPar(THIS.txt_4c_Conta, THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
1192:             "SigCdCli", "IClis", "IClis", "RClis", "Sele" + CHR(231) + CHR(227) + "o de Conta")
1193:     ENDPROC
1194: 
1195:     PROCEDURE ContaDblClick()
1196:         THIS.AbrirLookupPar(THIS.txt_4c_Conta, THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
1197:             "SigCdCli", "IClis", "RClis", "Sele" + CHR(231) + CHR(227) + "o de Conta")
1198:     ENDPROC
1199: 
1200:     PROCEDURE ContaInteractiveChange()
1201:         THIS.AplicarWhenDescricao(THIS.txt_4c_Conta, THIS.txt_4c_DConta)
1202:     ENDPROC
1203: 
1204:     PROCEDURE DContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1205:         IF par_nKeyCode = 115  && F4 - abre lookup direto
1206:             THIS.AbrirLookupPar(THIS.txt_4c_DConta, THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
1207:                 "SigCdCli", "IClis", "RClis", "Sele" + CHR(231) + CHR(227) + "o de Conta")
1208:             RETURN
1209:         ENDIF
1210:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1211:             RETURN
1212:         ENDIF
1213:         THIS.ValidarLookupPar(THIS.txt_4c_DConta, THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
1214:             "SigCdCli", "RClis", "IClis", "RClis", "Sele" + CHR(231) + CHR(227) + "o de Conta")
1215:     ENDPROC
1216: 
1217:     PROCEDURE DContaDblClick()
1218:         THIS.AbrirLookupPar(THIS.txt_4c_DConta, THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
1219:             "SigCdCli", "IClis", "RClis", "Sele" + CHR(231) + CHR(227) + "o de Conta")
1220:     ENDPROC
1221: 
1222:     *===========================================================================
1223:     * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
1224:     * Precisa iterar Pages de PageFrame e Controls de Container (AddObject cria
1225:     * controles com Visible=.F. por padrao).
1226:     *===========================================================================
1227:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1228:         LOCAL loc_nI, loc_oControl
1229: 
1230:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1231:             loc_oControl = par_oContainer.Controls(loc_nI)
1232: 
1233:             IF VARTYPE(loc_oControl) = "O"
1234:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1235:                     loc_oControl.Visible = .T.
1236:                 ENDIF
1237: 
1238:                 IF UPPER(loc_oControl.BaseClass) == "PAGEFRAME"
1239:                     LOCAL loc_nP
1240:                     FOR loc_nP = 1 TO loc_oControl.PageCount
1241:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
1242:                     ENDFOR
1243:                 ENDIF
1244: 
1245:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1246:                         loc_oControl.ControlCount > 0
1247:                     THIS.TornarControlesVisiveis(loc_oControl)
1248:                 ENDIF
1249:             ENDIF
1250:         ENDFOR
1251:     ENDPROC
1252: 
1253:     *===========================================================================
1254:     * Destroy - libera recursos
1255:     *===========================================================================
1256:     PROCEDURE Destroy()
1257:         THIS.this_oBusinessObject = .NULL.
1258:         DODEFAULT()
1259:     ENDPROC
1260: 
1261: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCfaBO.prg):
*============================================================================
* SigOpCfaBO.prg - Business Object para Pesquisa de Falhas por Fase
*
* Form OPERACIONAL de consulta/apuracao - nao existe tabela de cadastro
* "SigOpCfa" no schema. O processamento cruza:
*   SigCdFcx (ficha de controle)  x  SigOpCfe (apontamento por fase)
*   x  SigCdCli (contas)  x  SigCdCle (classificacao/rateio de fase)
* para apurar entradas, saidas, falha real, falha admitida e indice de
* produtividade por fase/conta, num periodo e material informados.
*
* Tabela: (nenhuma - consulta parametrizada, sem persistencia propria)
*
* Inserir(), Atualizar() e ExecutarExclusao() permanecem SEM override - o
* comportamento padrao herdado de BusinessBase (recusar a operacao com
* mensagem clara) ja eh o correto para este BO, porque nao ha NENHUMA
* tabela proprietaria para gravar (regra CLAUDE.md "BO somente-leitura").
* ObterChavePrimaria() tambem nao se aplica - a tela nao exibe/edita um
* registro de tabela, ela monta um cursor de apuracao (TmpSaldo/
* cursor_4c_Saldos) a partir de uma pesquisa.
*
* Fase 2/8 - no lugar do CRUD generico, as operacoes de dados deste BO sao
* as que o Click de "Processa" e o metodo "Impress?o" do legado executam:
*
*   PrepararCursorSaldos()    deixa cursor_4c_Saldos pronto e VAZIO, com a
*                             MESMA estrutura e os MESMOS indices do
*                             "Create Cursor TmpSaldo" do Load legado (ZAP
*                             quando ja existe, para nao derrubar o binding
*                             do Grid - igual ao "Select TmpSaldo / Zap").
*   CarregarDoCursor()        linha corrente de cursor_4c_Saldos ->
*                             propriedades de linha; eh o
*                             Grade.AfterRowColChange do legado
*                             (Get_Descr.Value = TmpSaldo.Rclis).
*   MontarCursorCabecalho()   cria e popula TmpCabec (Titulo/SubTitulo/
*                             Empresa) do metodo "Impress?o", exigido pelo
*                             FRX.
*   ProcessarPesquisa()       Processa.Click: cruza SigCdFcx x SigOpCfe x
*                             SigCdCli, filtra por Grupo/Conta em memoria,
*                             rateia pelo Setor de SigCdCle e agrega
*                             Entradas/Saidas/FReal/FAdmin/Pesagem/IndProd
*                             por Fase (ou Fase+Conta ou Fase+Conta+Dia,
*                             conforme optImp), com as duas linhas finais
*                             de separador e totais.
*   ObterDescricaoEmpresa()  CursorQuery('SigCdEmp','crSigCdEmp','Cemps',
*                             _Empr,'Razas') do metodo Impress?o, que monta
*                             o cabecalho do relatorio/planilha.
*
* Fase 8/8 - a parte do metodo "Impress?o" legado que dispara o relatorio
* (ramos lcSaida = 'V'/'I' - a exportacao Excel/TXT fica no Form, que eh
* quem chama PutFile):
*
*   ExecutarReportForm()      REPORT FORM propriamente, com o isolamento de
*                             locale/REPORTBEHAVIOR e a restauracao de menu
*                             do padrao canonico do projeto.
*   ExibirRelatorio()         monta TmpCabec, confere "Set Order To SeqFase
*                             / Go Top / If Eof()" em cursor_4c_Saldos (a
*                             MESMA guarda vale para V/I/E) e, em V/I,
*                             escolhe SigOpCf2.frx (optImp=3, Grupo+Conta+
*                             Balanco) ou SigOpCfa.frx (demais opcoes).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init | Completado na Fase 2 - Metodos
*           | Fase 8 - ExecutarReportForm/ExibirRelatorio
*============================================================================

DEFINE CLASS SigOpCfaBO AS BusinessBase

    *==========================================================================
    * Propriedades dos filtros de pesquisa (espelham os controles da tela)
    *==========================================================================
    this_cMaterial        = ""    && char(14) - codigo do produto/material (Get_Mat)
    this_cDescMaterial    = ""    && char(40) - descricao do produto/material (Get_DMat)
    this_dDataInicial     = {}    && date     - data inicial do periodo (Get_Datai)
    this_dDataFinal       = {}    && date     - data final do periodo (Get_Dataf)
    this_cGrupo           = ""    && char(10) - codigo do grupo/fase filtrado (Get_grupo)
    this_cDescGrupo       = ""    && char(20) - descricao do grupo/fase (Get_Dgrupo)
    this_cConta           = ""    && char(10) - codigo da conta filtrada (Get_conta)
    this_cDescConta       = ""    && char(40) - descricao da conta (Get_dConta)
    this_nTipoRelatorio   = 1     && numeric  - 1=Grupo 2=Grupo+Conta 3=Grupo+Conta+Balanco (optImp.Value)
    this_cDescricaoLinha  = ""    && char(40) - descricao da linha corrente da grade (Get_Descr)
    this_cFaseLinha       = ""    && char(10) - Fase  da linha corrente da grade (cursor_4c_Saldos.Fase)
    this_cContaLinha      = ""    && char(10) - Conta da linha corrente da grade (cursor_4c_Saldos.Conta)

    *==========================================================================
    * Cursores utilizados pelo processamento (equivalentes aos do legado)
    *==========================================================================
    this_cCursorDados    = "cursor_4c_Saldos"    && equivalente a TmpSaldo (grade de resultado)
    this_cCursorFcx       = "cursor_4c_Fcx"        && equivalente a crSigCdFcx (SQL cruzado)
    this_cCursorClaes      = "cursor_4c_Claes"      && equivalente a CrTmpClaes (classificacao/rateio)
    this_cCursorEmpresa    = "cursor_4c_Empresa"    && equivalente a crSigCdEmp (cabecalho do relatorio)

    *-- O cursor do cabecalho MANTEM o nome legado "TmpCabec" de proposito: as
    *-- expressoes do FRX SigOpCfa.frx referenciam o alias EXPLICITAMENTE
    *-- (TmpCabec.Titulo / TmpCabec.SubTitulo - conferido no .frt). Renomear
    *-- para o padrao cursor_4c_* faria o relatorio abortar com
    *-- "Alias TMPCABEC is not found". Mesmo tratamento de sigreanrBO.
    this_cCursorCabecalho  = "TmpCabec"             && equivalente a TmpCabec (exigido pelo FRX)

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Form operacional sem tabela de cadastro: nao ha operacao de CRUD
    * (Inserir/Atualizar/ExecutarExclusao) a sobrescrever. O comportamento
    * padrao herdado de BusinessBase para essas operacoes ja eh o correto.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PrepararCursorSaldos - deixa cursor_4c_Saldos pronto e VAZIO, com a MESMA
    * ordem de campos e os MESMOS indices do "Create Cursor TmpSaldo" do Load
    * legado. E' PUBLIC porque o Form o chama de fora (na abertura, para ligar
    * o Grid ao cursor ainda vazio, como o legado liga a Grade a TmpSaldo no
    * Load) - metodo chamado de fora NUNCA pode ser PROTECTED (regra #51).
    *
    * Cursor JA existente eh limpo com ZAP, nao fechado e recriado: fechar o
    * alias (USE IN + CREATE CURSOR) derruba Grid.RecordSource e as
    * Column.ControlSource ligadas na abertura do Form, e a grade fica
    * permanentemente vazia com o cursor cheio - sem erro e sem log. O legado
    * faz "Select TmpSaldo / Zap" exatamente por isso.
    *
    * O ZAP vai cercado de SET SAFETY OFF: SAFETY eh escopado por data session
    * e volta a ON dentro de form com DataSession = 2 (mesmo mecanismo da regra
    * #9.4), onde o ZAP abriria o dialogo "Are you sure?" e CONGELARIA a tela.
    *
    * Ponto UNICO de criacao do cursor (CLAUDE.md exige estrutura IDENTICA em
    * todos os pontos que criam o mesmo cursor - com um ponto so nao ha como
    * divergir).
    *==========================================================================
    PROCEDURE PrepararCursorSaldos()
        LOCAL loc_cSafety

        IF USED(THIS.this_cCursorDados) ;
                AND TYPE(THIS.this_cCursorDados + ".Seqs") == "C" ;
                AND TYPE(THIS.this_cCursorDados + ".IndProds") == "N"
            *-- Estrutura esperada ja esta no lugar: so limpa os registros,
            *-- preservando os indices e o binding do Grid.
            SELECT (THIS.this_cCursorDados)

            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            ZAP
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ELSE
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorDados) ;
                (Fase C(10), Conta C(10), Rclis C(40), Entradas N(12,2), Saidas N(12,2), ;
                 Pesagems N(12,2), FReals N(12,2), FAdmins N(12,2), fTotals N(12,2), ;
                 Seqs C(1), pFalhas N(8,2), IndProds N(12,3), Codigos N(6), Datas D)

            INDEX ON Seqs + Fase + Conta + STR(Codigos, 6) TAG SeqFase
            INDEX ON Fase + Conta + STR(Codigos) TAG Fase
        ENDIF

        SELECT (THIS.this_cCursorDados)
        SET ORDER TO TAG Fase

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ProcessarPesquisa - equivalente ao SIGOPCFA.Processa.Click.
    *
    * Le os filtros diretamente das propriedades (this_cMaterial,
    * this_dDataInicial, this_dDataFinal, this_cGrupo, this_cConta,
    * this_nTipoRelatorio), que o Form sincroniza a partir da tela ANTES de
    * chamar este metodo (mesmo padrao de FormParaBO).
    *
    * As validacoes de UI (SetFocus) ficam no Form; aqui fica a MESMA
    * checagem de conteudo (material obrigatorio, periodo invertido), como
    * rede de seguranca - este metodo pode ser chamado de qualquer lugar.
    *
    * _Empr (global legada) -> go_4c_Sistema.cCodEmpresa (CLAUDE.md
    * "_EMPR: LEGACY - NEVER use"). fDtoSQL do legado -> FormatarDataSQL()
    * (helper padrao do projeto, regra CLAUDE.md #5); Data Final recebe
    * hora 23:59:59 para fechar o dia inteiro, igual a
    * fDtoSQL(ldDataFim, '23:59:59') do legado.
    *
    * Cascata fiel ao legado: 1) cruza SigCdFcx x SigOpCfe x SigCdCli para
    * o material e periodo informados; 2) por linha, filtra Grupo/Conta EM
    * MEMORIA (nao no WHERE do SQL - o legado faz exatamente assim); 3)
    * resolve o Setor via SigCdCle (rateio fase->setor); 4) monta a chave
    * de agrupamento conforme this_nTipoRelatorio (1=Grupo, 2=Grupo+Conta,
    * 3=Grupo+Conta+Dia) e agrega Entradas/Saidas/FReal/FAdmin/Pesagem/
    * IndProd na linha correspondente de cursor_4c_Saldos; 5) ao final,
    * acrescenta a linha separadora (Seqs='1') e a linha de totais
    * (Seqs='2'), e recalcula fTotals em TODAS as linhas - exatamente como
    * o legado, inclusive as duas linhas extras serem adicionadas de forma
    * INCONDICIONAL (mesmo sem nenhuma falha encontrada).
    *
    * Retorno: .T. se o processamento rodou sem erro de SQL/validacao (o
    * cursor pode legitimamente ficar so com as 2 linhas de totais, zeradas,
    * quando a pesquisa nao encontra nenhuma falha - o mesmo que acontece
    * no legado). .F. com THIS.this_cMensagemErro preenchido quando faltou
    * preencher o material, o periodo esta invertido ou algum SQLEXEC falhou.
    *==========================================================================
    PROCEDURE ProcessarPesquisa()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cDtInicio, loc_cDtFim
        LOCAL loc_tDataFinal, loc_cGrupo2, loc_cChave, loc_nFalha, loc_oErro
        LOCAL loc_nTotFReal, loc_nTotFAdm, loc_nTotSaida, loc_nTotEnt, loc_nTotPsg, loc_nTotIndProd
        LOCAL loc_cExact, loc_cFiltroGrupo, loc_cFiltroConta, loc_cGrupoLinha, loc_cContaLinha

        loc_lSucesso = .T.
        THIS.this_cMensagemErro = ""

        *-- SET EXACT eh ON no startup (start\config.prg) e com ON o SEEK exige
        *-- a chave INTEIRA do indice: a chave de agrupamento montada aqui eh
        *-- PARCIAL (Fase, ou Fase+Conta, contra o indice Fase+Conta+STR(Codigos)),
        *-- entao TODO SEEK falharia e cada linha da consulta viraria uma linha
        *-- nova na grade, em vez de somar na linha do grupo. O legado Fortyus
        *-- roda com EXACT OFF. Guardado e restaurado no fim do metodo.
        loc_cExact = SET("EXACT")
        SET EXACT OFF

        TRY
            IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cMaterial, "")))
                loc_lSucesso = .F.
                THIS.this_cMensagemErro = "O Produto Deve Ser Informado!!!"
            ELSE
                *-- O legado NAO exige periodo preenchido: so compara as duas
                *-- datas. Data vazia vira NULL no SQL (FormatarDataSQL) e a
                *-- consulta volta sem linhas, igual ao legado - NAO inventar
                *-- aqui uma obrigatoriedade que a tela original nao tem.
                IF THIS.this_dDataFinal < THIS.this_dDataInicial
                    loc_lSucesso = .F.
                    THIS.this_cMensagemErro = "Data Final Deve Ser Maior Que a Data Inicial!!!"
                ENDIF
            ENDIF

            IF loc_lSucesso
                THIS.PrepararCursorSaldos()

                loc_cFiltroGrupo = ALLTRIM(TratarNulo(THIS.this_cGrupo, ""))
                loc_cFiltroConta = ALLTRIM(TratarNulo(THIS.this_cConta, ""))

                *-- fDtoSQL(ldDataFim, '23:59:59') do legado: a data final fecha
                *-- o dia INTEIRO, senao a coluna datetime perde os lancamentos
                *-- do ultimo dia com hora. DATETIME() exige ano/mes/dia validos
                *-- (com data vazia dispara erro 11), por isso o guard - com data
                *-- vazia FormatarDataSQL devolve NULL e a consulta nao traz
                *-- linha, que eh o mesmo resultado do legado.
                loc_cDtInicio = FormatarDataSQL(ConverterParaData(THIS.this_dDataInicial))

                IF EMPTY(ConverterParaData(THIS.this_dDataFinal))
                    loc_cDtFim = "NULL"
                ELSE
                    loc_tDataFinal = DATETIME(YEAR(ConverterParaData(THIS.this_dDataFinal)), ;
                        MONTH(ConverterParaData(THIS.this_dDataFinal)), ;
                        DAY(ConverterParaData(THIS.this_dDataFinal)), 23, 59, 59)
                    loc_cDtFim = FormatarDataSQL(loc_tDataFinal)
                ENDIF

                IF USED(THIS.this_cCursorFcx)
                    USE IN (THIS.this_cCursorFcx)
                ENDIF

                loc_cSQL = "SELECT a.Emps, a.Codigos, a.Grupos, b.CPros, b.Entradas, b.Saldos," + ;
                           " b.Saidas, b.Pesagems, b.FReals, b.FAdmins, b.cIdChaves, a.Contas," + ;
                           " c.Rclis, b.IndProds, a.Datas" + ;
                           " FROM SigCdFcx a, SigOpCfe b, SigCdCli c" + ;
                           " WHERE a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
                           " AND a.Datas BETWEEN " + loc_cDtInicio + " AND " + loc_cDtFim + ;
                           " AND a.Emps = b.Emps AND a.Codigos = b.Codigos" + ;
                           " AND b.Cpros = " + EscaparSQL(THIS.this_cMaterial) + ;
                           " AND a.Contas = c.Iclis" + ;
                           " ORDER BY a.Emps, a.Codigos, a.Grupos, b.CPros, b.Entradas, b.Saldos," + ;
                           " b.Saidas, b.Pesagems, b.FReals, b.FAdmins, b.cIdChaves, a.Contas, c.Rclis"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorFcx)

                IF loc_nResultado < 1
                    loc_lSucesso = .F.
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigCdFcx)" + ;
                        CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT (THIS.this_cCursorFcx)
                    SCAN
                        *-- Filtro de Grupo/Conta em MEMORIA, nao no WHERE do SQL
                        *-- (o legado faz exatamente assim). Comparacao com "=="
                        *-- (exata) porque o SET EXACT esta OFF neste metodo por
                        *-- causa do SEEK parcial: com "!=" e EXACT OFF, grupo
                        *-- "1" casaria com "100" e traria linha de outro grupo.
                        loc_cGrupoLinha = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorFcx + ".Grupos"), ""))
                        loc_cContaLinha = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorFcx + ".Contas"), ""))

                        IF (!EMPTY(loc_cFiltroGrupo) AND !(loc_cGrupoLinha == loc_cFiltroGrupo)) ;
                                OR (!EMPTY(loc_cFiltroConta) AND !(loc_cContaLinha == loc_cFiltroConta))
                            LOOP
                        ENDIF

                        loc_cSQL = "SELECT Setors" + ;
                                   " FROM SigCdCle" + ;
                                   " WHERE ClaGrupos = " + EscaparSQL(EVALUATE(THIS.this_cCursorFcx + ".Grupos")) + ;
                                   " AND ClaContas = " + EscaparSQL(EVALUATE(THIS.this_cCursorFcx + ".Contas"))

                        IF USED(THIS.this_cCursorClaes)
                            USE IN (THIS.this_cCursorClaes)
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorClaes)

                        IF loc_nResultado < 1
                            loc_lSucesso = .F.
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigCdCle)" + ;
                                CHR(13) + CapturarErroSQL()
                            EXIT
                        ENDIF

                        loc_cGrupo2 = EVALUATE(THIS.this_cCursorFcx + ".Grupos")
                        IF RECCOUNT(THIS.this_cCursorClaes) > 0
                            loc_cGrupo2 = EVALUATE(THIS.this_cCursorClaes + ".Setors")
                        ENDIF

                        loc_cChave = loc_cGrupo2
                        DO CASE
                            CASE THIS.this_nTipoRelatorio = 2 && Grupo + Conta
                                loc_cChave = loc_cGrupo2 + EVALUATE(THIS.this_cCursorFcx + ".Contas")
                            CASE THIS.this_nTipoRelatorio = 3 && Grupo + Conta + Balanco
                                loc_cChave = loc_cGrupo2 + EVALUATE(THIS.this_cCursorFcx + ".Contas") + ;
                                    STR(EVALUATE(THIS.this_cCursorFcx + ".Codigos"), 6)
                        ENDCASE

                        IF !SEEK(loc_cChave, THIS.this_cCursorDados)
                            INSERT INTO (THIS.this_cCursorDados) (Fase, Conta, Rclis, Codigos, Datas) VALUES ;
                                (loc_cGrupo2, ;
                                 IIF(INLIST(THIS.this_nTipoRelatorio, 2, 3), ;
                                     ALLTRIM(EVALUATE(THIS.this_cCursorFcx + ".Contas")), ""), ;
                                 IIF(INLIST(THIS.this_nTipoRelatorio, 2, 3), ;
                                     ALLTRIM(EVALUATE(THIS.this_cCursorFcx + ".Rclis")), ""), ;
                                 IIF(THIS.this_nTipoRelatorio = 3, ;
                                     EVALUATE(THIS.this_cCursorFcx + ".Codigos"), 0), ;
                                 IIF(THIS.this_nTipoRelatorio = 3, ;
                                     ConverterParaData(EVALUATE(THIS.this_cCursorFcx + ".Datas")), {}))
                        ENDIF

                        REPLACE Entradas WITH Entradas + EVALUATE(THIS.this_cCursorFcx + ".Entradas") + ;
                                    EVALUATE(THIS.this_cCursorFcx + ".Saldos"), ;
                                Saidas   WITH Saidas + EVALUATE(THIS.this_cCursorFcx + ".Saidas"), ;
                                FReals   WITH FReals + EVALUATE(THIS.this_cCursorFcx + ".FReals"), ;
                                FAdmins  WITH FAdmins + EVALUATE(THIS.this_cCursorFcx + ".FAdmins"), ;
                                Pesagems WITH Pesagems + EVALUATE(THIS.this_cCursorFcx + ".Pesagems"), ;
                                IndProds WITH IndProds + (EVALUATE(THIS.this_cCursorFcx + ".IndProds") - ;
                                    EVALUATE(THIS.this_cCursorFcx + ".FReals")) ;
                            IN (THIS.this_cCursorDados)

                        loc_nFalha = IIF(EVALUATE(THIS.this_cCursorDados + ".Saidas") = 0, 0, ;
                            (EVALUATE(THIS.this_cCursorDados + ".FReals") / ;
                             EVALUATE(THIS.this_cCursorDados + ".Saidas") * 100))
                        REPLACE pFalhas WITH loc_nFalha IN (THIS.this_cCursorDados)
                    ENDSCAN

                    IF loc_lSucesso
                        SELECT (THIS.this_cCursorDados)
                        APPEND BLANK
                        REPLACE Seqs WITH "1"

                        SUM FReals, FAdmins, Saidas, Entradas, Pesagems, IndProds ;
                            TO loc_nTotFReal, loc_nTotFAdm, loc_nTotSaida, loc_nTotEnt, loc_nTotPsg, loc_nTotIndProd

                        APPEND BLANK
                        REPLACE Seqs WITH "2", ;
                                Fase WITH "Total", ;
                                FReals WITH loc_nTotFReal, ;
                                FAdmins WITH loc_nTotFAdm, ;
                                Saidas WITH loc_nTotSaida, ;
                                Entradas WITH loc_nTotEnt, ;
                                Pesagems WITH loc_nTotPsg, ;
                                IndProds WITH loc_nTotIndProd

                        loc_nFalha = IIF(EVALUATE(THIS.this_cCursorDados + ".Saidas") = 0, 0, ;
                            (EVALUATE(THIS.this_cCursorDados + ".FReals") / ;
                             EVALUATE(THIS.this_cCursorDados + ".Saidas") * 100))
                        REPLACE pFalhas WITH loc_nFalha IN (THIS.this_cCursorDados)

                        REPLACE ALL fTotals WITH fReals - fAdmins IN (THIS.this_cCursorDados)

                        SELECT (THIS.this_cCursorDados)
                        SET ORDER TO TAG SeqFase
                        GO TOP
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED(THIS.this_cCursorFcx)
            USE IN (THIS.this_cCursorFcx)
        ENDIF
        IF USED(THIS.this_cCursorClaes)
            USE IN (THIS.this_cCursorClaes)
        ENDIF

        *-- Restaura o SET EXACT do ambiente (vale tambem quando o CATCH disparou)
        IF loc_cExact = "ON"
            SET EXACT ON
        ELSE
            SET EXACT OFF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDescricaoEmpresa - equivalente ao CursorQuery('SigCdEmp',
    * 'crSigCdEmp', 'Cemps', _Empr, 'Razas') feito no metodo Impress?o do
    * legado, que monta o cabecalho do relatorio/planilha (TmpCabec.Empresa)
    * com a razao social da empresa corrente.
    *
    * _Empr (global legada) -> go_4c_Sistema.cCodEmpresa (CLAUDE.md
    * "_EMPR: LEGACY - NEVER use"). SigCdEmp.Cemps eh char(3) -> PADR(...,3).
    *
    * Retorna "" quando a empresa nao existe ou o SQL falha - equivalente ao
    * Iif(Eof('crSigCdEmp'), '', crSigCdEmp.Razas) do legado, que usa string
    * vazia como fallback silencioso (nao eh erro bloqueante: so afeta o
    * texto do cabecalho do relatorio).
    *==========================================================================
    PROCEDURE ObterDescricaoEmpresa()
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loc_oErro

        loc_cDescricao = ""

        TRY
            loc_cSQL = "SELECT Razas" + ;
                       " FROM SigCdEmp" + ;
                       " WHERE Cemps = " + EscaparSQL(PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3))

            IF USED(THIS.this_cCursorEmpresa)
                USE IN (THIS.this_cCursorEmpresa)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorEmpresa)

            IF loc_nResultado >= 1 AND RECCOUNT(THIS.this_cCursorEmpresa) > 0
                loc_cDescricao = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorEmpresa + ".Razas"), ""))
            ENDIF
        CATCH TO loc_oErro
            loc_cDescricao = ""
        ENDTRY

        IF USED(THIS.this_cCursorEmpresa)
            USE IN (THIS.this_cCursorEmpresa)
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega a LINHA CORRENTE do cursor de apuracao para as
    * propriedades de linha do BO (hook padrao de BusinessBase: cursor ->
    * propriedades).
    *
    * Equivale ao Grade.AfterRowColChange do legado, que a cada troca de linha
    * faz "ThisForm.Get_Descr.Value = TmpSaldo.Rclis" - a descricao da conta da
    * linha selecionada aparece no campo de rodape da tela. Aqui a leitura do
    * cursor fica no BO e o Form apenas espelha this_cDescricaoLinha no
    * TextBox, em vez de ler o cursor direto da camada de UI.
    *
    * Fase e Conta vem junto porque sao a identificacao da linha no cursor
    * (as duas colunas que compoem a chave de agrupamento) - o Form usa para
    * saber QUAL linha esta selecionada sem reabrir o cursor.
    *
    * par_cAliasCursor eh opcional: sem ele usa cursor_4c_Saldos (o cursor da
    * grade), que eh o unico cursor de linha desta tela.
    *
    * Retorna .F. (e limpa as propriedades) quando o cursor nao existe, esta
    * vazio ou o ponteiro esta em EOF/BOF - o estado em que a tela abre, antes
    * do primeiro clique em Processar. Nas duas linhas que o legado acrescenta
    * no fim (separador e Total) a leitura ACONTECE e devolve .T.: Rclis eh
    * vazio nelas, e o campo de descricao da tela fica em branco - igual ao
    * legado, que atribui TmpSaldo.Rclis sem testar a linha.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.

        loc_cAlias = THIS.this_cCursorDados
        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ENDIF

        THIS.this_cFaseLinha      = ""
        THIS.this_cContaLinha     = ""
        THIS.this_cDescricaoLinha = ""

        TRY
            IF USED(loc_cAlias)
                IF RECCOUNT(loc_cAlias) > 0 AND !EOF(loc_cAlias) AND !BOF(loc_cAlias)
                    *-- TYPE() antes de ler: o alias pode existir com outra
                    *-- estrutura (PEMSTATUS nao vale para cursor - regra #61).
                    IF TYPE(loc_cAlias + ".Rclis") == "C" AND TYPE(loc_cAlias + ".Fase") == "C"
                        THIS.this_cFaseLinha      = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Fase"), ""))
                        THIS.this_cContaLinha     = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Conta"), ""))
                        THIS.this_cDescricaoLinha = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Rclis"), ""))
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarCursorCabecalho - transcricao do bloco de cabecalho do metodo
    * "Impress?o" do legado:
    *
    *   Create Cursor TmpCabec (Titulo c(100), SubTitulo c(100), Empresa c(100))
    *   CursorQuery('SigCdEmp','crSigCdEmp','Cemps',_Empr,'Razas')
    *   lcTitulo    = 'Falhas por Fase'
    *   lcSubTitulo = 'Material : ' + ... + Chr(13) + 'Periodo : ' + ... + ' - ' + ...
    *   Insert Into TmpCabec (Empresa, Titulo, SubTitulo) Values (...)
    *
    * O alias segue sendo TmpCabec porque o FRX referencia TmpCabec.Titulo e
    * TmpCabec.SubTitulo explicitamente (ver comentario da property
    * this_cCursorCabecalho). Os textos sao transcritos LITERALMENTE, com as
    * acentuacoes por CHR() (regra #4): CHR(237) = i-acute em "Per?odo".
    *
    * A razao social vem de ObterDescricaoEmpresa() (o CursorQuery do legado).
    * Empresa nao eh usada pelo SigOpCfa.frx, mas eh gravada igual ao legado -
    * a estrutura do cursor tem de continuar identica.
    *
    * Retorna .T. quando o cursor ficou criado e com a linha de cabecalho.
    *==========================================================================
    PROCEDURE MontarCursorCabecalho()
        LOCAL loc_lSucesso, loc_cTitulo, loc_cSubTitulo, loc_cEmpresa, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                (Titulo C(100), SubTitulo C(100), Empresa C(100))

            loc_cTitulo = "Falhas por Fase"

            loc_cSubTitulo = "Material : " + ALLTRIM(TratarNulo(THIS.this_cMaterial, "")) + " - " + ;
                ALLTRIM(TratarNulo(THIS.this_cDescMaterial, "")) + CHR(13) + ;
                "Per" + CHR(237) + "odo : " + DTOC(ConverterParaData(THIS.this_dDataInicial)) + " - " + ;
                DTOC(ConverterParaData(THIS.this_dDataFinal))

            loc_cEmpresa = THIS.ObterDescricaoEmpresa()

            INSERT INTO (THIS.this_cCursorCabecalho) (Empresa, Titulo, SubTitulo) ;
                VALUES (LEFT(loc_cEmpresa, 100), LEFT(loc_cTitulo, 100), LEFT(loc_cSubTitulo, 100))

            GO TOP IN (THIS.this_cCursorCabecalho)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - dispara o REPORT FORM propriamente, com o mesmo
    * isolamento de locale/REPORTBEHAVIOR e restauracao de menu do padrao
    * canonico do projeto (ver SigReCgcBO.ExecutarReportForm). par_cModo:
    * "PREVIEW" (Report Form ... Preview NoConsole, legado lcSaida='V') ou
    * "PRINTER_PROMPT" (Report Form ... To PRINTER Prompt, legado lcSaida='I').
    *
    * O cursor-vazio e o cabecalho (TmpCabec) ja' foram checados/preparados
    * por THIS.ExibirRelatorio() - este metodo so cuida do REPORT FORM.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX, "Erro")
            RETURN .F.
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        *-- Restaurar menu apos preview (Erro63): REPORT FORM PREVIEW abre
        *-- toolbar propria que corrompe o cache visual do _MSYSMENU.
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExibirRelatorio - equivalente ao bloco "Select TmpSaldo / Set Order to
    * SeqFase / Go Top / If Eof() ... Else ... EndIf" do metodo "Impress?o"
    * do legado: monta TmpCabec e confere se ha linha em cursor_4c_Saldos -
    * essa MESMA guarda envolve os TRES destinos (V/I/E) no legado, por isso
    * vale igual para par_cSaida = "E" (so' depois dela o legado se ramifica
    * em Report Form / Report Form To PRINTER / exportacao de planilha).
    *
    * par_cSaida: "V" (preview), "I" (impressora, com prompt) ou "E" (so'
    * valida a guarda - quem exporta a planilha, com PutFile/Copy To, eh o
    * Form, que eh o dono dos dialogos de UI). Para "V"/"I", escolhe o FRX
    * certo - SigOpCf2 quando this_nTipoRelatorio = 3 (Grupo + Conta +
    * Balanco), SigOpCfa nos outros dois modos - exatamente o "If
    * ThisForm.optImp.Value = 3" do legado.
    *
    * TmpCabec fica aberto DURANTE o REPORT FORM (o FRX referencia
    * TmpCabec.Titulo/TmpCabec.SubTitulo explicitamente) e so' e' fechado no
    * fim deste metodo - igual ao "Use In TmpCabec" que fecha o bloco inteiro
    * do Impress?o legado, depois do If/Else (fica aberto tambem durante o
    * ramo "E", sem uso - o legado faz exatamente isso, de forma
    * incondicional).
    *
    * Retorna .T. quando a guarda passou (e, para V/I, o relatorio foi
    * disparado); .F. com THIS.this_cMensagemErro preenchido quando nao ha
    * linha selecionada ou algo falhou (cabecalho/SQL/FRX ausente).
    *==========================================================================
    PROCEDURE ExibirRelatorio(par_cSaida)
        LOCAL loc_lSucesso, loc_cFrx, loc_cModo, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.MontarCursorCabecalho()
                loc_lSucesso = .F.
            ELSE
                IF !USED(THIS.this_cCursorDados)
                    THIS.this_cMensagemErro = "Nenhuma Informa" + CHR(231) + CHR(227) + "o Selecionada!!!"
                ELSE
                    SELECT (THIS.this_cCursorDados)
                    SET ORDER TO TAG SeqFase
                    GO TOP

                    IF EOF()
                        THIS.this_cMensagemErro = "Nenhuma Informa" + CHR(231) + CHR(227) + "o Selecionada!!!"
                    ELSE
                        DO CASE
                            CASE par_cSaida == "V" OR par_cSaida == "I"
                                loc_cFrx  = IIF(THIS.this_nTipoRelatorio = 3, "SigOpCf2", "SigOpCfa")
                                loc_cModo = IIF(par_cSaida == "V", "PREVIEW", "PRINTER_PROMPT")
                                loc_lSucesso = THIS.ExecutarReportForm(loc_cFrx, loc_cModo)

                            CASE par_cSaida == "E"
                                *-- Guarda passou - a exportacao em si (PutFile +
                                *-- fVerificaPasta + Copy To) fica no Form, que
                                *-- eh quem exibe os dialogos de UI.
                                loc_lSucesso = .T.
                        ENDCASE
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

