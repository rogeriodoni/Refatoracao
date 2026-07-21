# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'optTabela' (parent: SIGCDALE): Top original=93 vs migrado 'obj_4c_OptTabela' Top=5 (diff=88px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optTabela' (parent: SIGCDALE): Left original=128 vs migrado 'obj_4c_OptTabela' Left=5 (diff=123px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formale.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (963 linhas total):

*-- Linhas 9 a 162:
9: *   par_cLcAcesso - Nivel de acesso (recebido, nao usado na logica atual)
10: *
11: * Uso canonico (a partir do form pai):
12: *   loForm = CREATEOBJECT("Formale", THISFORM, cContas, cGrupos, cAcesso)
13: *   IF VARTYPE(loForm) = "O"
14: *       loForm.Show()
15: *   ENDIF
16: *==============================================================================
17: 
18: DEFINE CLASS Formale AS FormBase
19: 
20:     *-- Propriedades visuais (PILAR 1: identico ao legado SIGCDALE)
21:     Width        = 1000
22:     Height       = 600
23:     AutoCenter   = .T.
24:     BorderStyle  = 2
25:     Caption      = "Alerta"
26:     ShowWindow = 1
27:     ControlBox   = .F.
28:     Closable     = .F.
29:     MaxButton    = .F.
30:     MinButton    = .F.
31:     TitleBar     = 0
32:     WindowType   = 1
33: 
34:     *-- Codigo da conta configurada (IClis recebido via par_cLpiclis)
35:     this_cContas       = ""
36: 
37:     *-- Modo do form pai: "INSERIR" ou "ALTERAR" (lido de parentform.pcescolha)
38:     this_cPcEscolha    = ""
39: 
40:     *-- Referencia ao form pai (para BtnConfirmarClick ler pcescolha em runtime)
41:     this_oParentForm   = .NULL.
42: 
43:     *--------------------------------------------------------------------------
44:     * Init - Recebe os 4 parametros do legado (pform, lpiclis, lpgrupos, lcacesso)
45:     * Armazena this_cContas e this_oParentForm ANTES de DODEFAULT
46:     * (DODEFAULT chama FormBase.Init -> InicializarForm, que ja usa esses valores)
47:     *--------------------------------------------------------------------------
48:     PROCEDURE Init(par_pForm, par_cLpiclis, par_cLpGrupos, par_cLcAcesso)
49:         LOCAL loc_lSucesso
50: 
51:         IF TYPE("par_pForm") = "O"
52:             THIS.this_oParentForm = par_pForm
53:             IF PEMSTATUS(par_pForm, "pcescolha", 5)
54:                 THIS.this_cPcEscolha = UPPER(ALLTRIM(NVL(par_pForm.pcescolha, "")))
55:             ENDIF
56:         ENDIF
57: 
58:         IF TYPE("par_cLpiclis") = "C"
59:             THIS.this_cContas = ALLTRIM(NVL(par_cLpiclis, ""))
60:         ENDIF
61: 
62:         loc_lSucesso = DODEFAULT()
63: 
64:         RETURN loc_lSucesso
65:     ENDPROC
66: 
67:     *--------------------------------------------------------------------------
68:     * ConfigurarPageFrame - Configura aparencia base do form OPERACIONAL
69:     * (sem PageFrame: layout plano com fundo new_background.jpg identico ao legado)
70:     *--------------------------------------------------------------------------
71:     PROTECTED PROCEDURE ConfigurarPageFrame()
72:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
73:         THIS.ScrollBars = 0
74:         THIS.ShowTips   = .T.
75:         THIS.SetAll("FontName", "Tahoma")
76:         THIS.SetAll("FontSize", 8)
77:     ENDPROC
78: 
79:     *--------------------------------------------------------------------------
80:     * InicializarForm - Cria BO, configura layout completo e carrega dados
81:     *--------------------------------------------------------------------------
82:     PROTECTED PROCEDURE InicializarForm()
83:         LOCAL loc_lSucesso, loc_oErro
84:         loc_lSucesso = .F.
85: 
86:         TRY
87:             THIS.this_oBusinessObject = CREATEOBJECT("aleBO")
88: 
89:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
90:                 THIS.LockScreen = .T.
91:                 THIS.ConfigurarPageFrame()
92:                 THIS.ConfigurarCabecalho()
93:                 THIS.ConfigurarPaginaLista()
94:                 THIS.ConfigurarPaginaDados()
95:                 THIS.TornarControlesVisiveis()
96:                 THIS.CarregarAlertas()
97:                 THIS.grd_4c_Dados.Refresh()
98:                 THIS.LockScreen = .F.
99:                 loc_lSucesso = .T.
100:             ELSE
101:                 MsgErro("Erro ao criar Business Object de Alertas." + CHR(13) + ;
102:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
103:             ENDIF
104:         CATCH TO loc_oErro
105:             THIS.LockScreen = .F.
106:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
107:                     " PROC=" + loc_oErro.Procedure, ;
108:                     "Erro ao inicializar Form de Alertas")
109:         ENDTRY
110: 
111:         RETURN loc_lSucesso
112:     ENDPROC
113: 
114:     *--------------------------------------------------------------------------
115:     * ConfigurarCabecalho - Container header cinza (cntSombra do legado)
116:     * Equivalente: SIGCDALE.cntSombra + lblSombra + lblTitulo + Shape1
117:     * cnt_4c_Sombra: Top=0, Left=0, Width=1000, Height=80, BackColor=RGB(100,100,100)
118:     * lbl_4c_Sombra: sombra preta (ForeColor preto) deslocada 1px
119:     * lbl_4c_Titulo: titulo branco (ForeColor branco) sobre a sombra
120:     * shp_4c_Shape1: separador decorativo direita (BackStyle=0, BorderStyle=0)
121:     *--------------------------------------------------------------------------
122:     PROTECTED PROCEDURE ConfigurarCabecalho()
123:         THIS.AddObject("cnt_4c_Sombra", "Container")
124:         WITH THIS.cnt_4c_Sombra
125:             .Top         = 0
126:             .Left        = 0
127:             .Width       = THIS.Width
128:             .Height      = 80
129:             .BorderWidth = 0
130:             .BackStyle   = 1
131:             .BackColor   = RGB(100, 100, 100)
132:             .Visible     = .T.
133:         ENDWITH
134: 
135:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
136:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
137:             .AutoSize      = .F.
138:             .FontBold      = .T.
139:             .FontName      = "Tahoma"
140:             .FontSize      = 18
141:             .FontUnderline = .F.
142:             .WordWrap      = .T.
143:             .Alignment     = 0
144:             .BackStyle     = 0
145:             .Caption       = THIS.Caption
146:             .Height        = 40
147:             .Left          = 10
148:             .Top           = 18
149:             .Width         = 769
150:             .ForeColor     = RGB(0, 0, 0)
151:             .Visible       = .T.
152:         ENDWITH
153: 
154:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
155:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
156:             .AutoSize      = .F.
157:             .FontBold      = .T.
158:             .FontName      = "Tahoma"
159:             .FontSize      = 18
160:             .WordWrap      = .T.
161:             .Alignment     = 0
162:             .BackStyle     = 0

*-- Linhas 188 a 270:
188:     *--------------------------------------------------------------------------
189:     * ConfigurarPaginaLista - Agrupa setup da area de listagem (form OPERACIONAL)
190:     * SIGCDALE nao tem PageFrame Lista/Dados (nao eh CRUD): a "lista" eh a grade
191:     * unica de alertas, filtrada pelo OptionGroup obj_4c_OptTabela. Este metodo
192:     * agrega ConfigurarFiltros + ConfigurarGrade para manter contrato do pipeline
193:     * (validacao mecanica esperava Form CRUD com Page1/Page2).
194:     *--------------------------------------------------------------------------
195:     PROTECTED PROCEDURE ConfigurarPaginaLista()
196:         THIS.ConfigurarFiltros()
197:         THIS.ConfigurarGrade()
198:     ENDPROC
199: 
200:     *--------------------------------------------------------------------------
201:     * AlternarPagina - Troca "pagina logica" via OptionGroup (form OPERACIONAL)
202:     * Em SIGCDALE nao ha PageFrame; a nocao de pagina mapeia para a tabela de
203:     * referencia selecionada no obj_4c_OptTabela (1..5): SIGCDOPE, SIGCDGCR,
204:     * SIGCDOPD, SIGCDPRO, SIGOPOPE. Ajusta Value e dispara filtragem do BO.
205:     *--------------------------------------------------------------------------
206:     PROCEDURE AlternarPagina(par_nOpcao)
207:         LOCAL loc_oErro
208: 
209:         IF VARTYPE(par_nOpcao) != "N" OR par_nOpcao < 1 OR par_nOpcao > 5
210:             RETURN
211:         ENDIF
212: 
213:         TRY
214:             IF PEMSTATUS(THIS, "obj_4c_OptTabela", 5)
215:                 THIS.obj_4c_OptTabela.Value = par_nOpcao
216:                 THIS.this_oBusinessObject.FiltrarPorTabela(par_nOpcao)
217:                 THIS.grd_4c_Dados.Refresh()
218:             ENDIF
219:         CATCH TO loc_oErro
220:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
221:                     " PROC=" + loc_oErro.Procedure, "Erro ao alternar tabela")
222:         ENDTRY
223:     ENDPROC
224: 
225:     *--------------------------------------------------------------------------
226:     * ConfigurarFiltros - Cria OptionGroup para selecao da tabela de referencia
227:     * Legado: optTabela (Top=93, Left=128, Width=744, Height=25, ButtonCount=5)
228:     *--------------------------------------------------------------------------
229:     PROTECTED PROCEDURE ConfigurarFiltros()
230:         THIS.AddObject("obj_4c_OptTabela", "OptionGroup")
231:         WITH THIS.obj_4c_OptTabela
232:             .AutoSize    = .T.
233:             .ButtonCount = 5
234:             .Height      = 25
235:             .Left        = 128
236:             .Top         = 93
237:             .Width       = 744
238:             .Value       = 1
239:             .BackStyle   = 0
240:             .BorderStyle = 0
241: 
242:             WITH .Buttons(1)
243:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o Estoque"
244:                 .BackStyle = 0
245:                 .Left      = 5
246:                 .Top       = 5
247:                 .AutoSize  = .T.
248:                 .ForeColor = RGB(90, 90, 90)
249:             ENDWITH
250: 
251:             WITH .Buttons(2)
252:                 .Caption   = "Grupo de Contas"
253:                 .FontName  = "Tahoma"
254:                 .FontSize  = 8
255:                 .BackStyle = 0
256:                 .Left      = 164
257:                 .Top       = 5
258:                 .AutoSize  = .T.
259:                 .ForeColor = RGB(90, 90, 90)
260:             ENDWITH
261: 
262:             WITH .Buttons(3)
263:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o"
264:                 .FontName  = "Tahoma"
265:                 .FontSize  = 8
266:                 .BackStyle = 0
267:                 .Left      = 289
268:                 .Top       = 5
269:                 .AutoSize  = .T.
270:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 296 a 350:
296:             ENDWITH
297:         ENDWITH
298: 
299:         BINDEVENT(THIS.obj_4c_OptTabela, "InteractiveChange", THIS, "OptTabelaInteractiveChange")
300:     ENDPROC
301: 
302:     *--------------------------------------------------------------------------
303:     * ConfigurarGrade - Cria o grid com 7 colunas
304:     * Legado: grade_ale (Top=126, Left=18, Width=963, Height=460, ColumnCount=7)
305:     * Col1: TextBox Descricao (ReadOnly)
306:     * Col2-5: CheckBox flags (I/A/E/B) com Sparse=.F.
307:     * Col6: ComboBox Prioridade
308:     * Col7: EditBox Mensagem
309:     *--------------------------------------------------------------------------
310:     PROTECTED PROCEDURE ConfigurarGrade()
311:         LOCAL loc_oGrid
312: 
313:         THIS.AddObject("grd_4c_Dados", "Grid")
314:         loc_oGrid = THIS.grd_4c_Dados
315:         WITH loc_oGrid
316:             .Top                = 126
317:             .Left               = 18
318:             .Width              = 963
319:             .Height             = 460
320:             .ColumnCount        = 7
321:             .RowHeight          = 22
322:             .RecordMark         = .F.
323:             .DeleteMark         = .F.
324:             .AllowAutoColumnFit = 2
325:             .ReadOnly           = .F.
326:             .FontName           = "Tahoma"
327:             .FontSize           = 8
328:         ENDWITH
329: 
330:         *-- Coluna 1: Descricao (TextBox ReadOnly)
331:         WITH loc_oGrid.Column1
332:             .Width    = 220
333:             .Movable  = .F.
334:             .Resizable = .F.
335:             .ReadOnly = .T.
336:             .AddObject("Text1", "TextBox")
337:             WITH .Text1
338:                 .BorderStyle = 0
339:                 .Margin      = 0
340:                 .ReadOnly    = .T.
341:                 .ForeColor   = RGB(0, 0, 0)
342:                 .BackColor   = RGB(255, 255, 255)
343:             ENDWITH
344:             .CurrentControl      = "Text1"
345:             .Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o"
346:             .Header1.Alignment   = 2
347:         ENDWITH
348: 
349:         *-- Coluna 2: CheckBox Inserir (I) - Sparse=.F. para mostrar em todas as linhas
350:         WITH loc_oGrid.Column2

*-- Linhas 460 a 963:
460:             .Header1.Alignment = 2
461:         ENDWITH
462: 
463:         BINDEVENT(loc_oGrid.Column6.Combo1, "InteractiveChange", THIS, "CboGradeComboChange")
464:     ENDPROC
465: 
466:     *--------------------------------------------------------------------------
467:     * ConfigurarPaginaDados - Area de acoes/dados do form OPERACIONAL
468:     * SIGCDALE nao tem Page2/Dados de cadastro CRUD; a "area de dados" desta
469:     * tela mapeia para o bloco de acoes sobre o registro em edicao:
470:     *   - Botoes cmd_4c_Confirmar / cmd_4c_Cancelar (delega a ConfigurarBotoes)
471:     *   - Ajuste do titulo do cabecalho conforme modo do form pai (INSERIR|ALTERAR)
472:     * Chamado apos ConfigurarPaginaLista para garantir que grid e OptionGroup ja
473:     * estao instanciados quando os botoes de acao forem bindados.
474:     *--------------------------------------------------------------------------
475:     PROTECTED PROCEDURE ConfigurarPaginaDados()
476:         LOCAL loc_cSufixo
477: 
478:         *-- Setup dos botoes de acao (Confirmar/Cancelar) - area de dados/acoes
479:         THIS.ConfigurarBotoes()
480: 
481:         *-- Refletir modo do form pai no titulo (INSERIR mostra "Novo", ALTERAR mostra "Edicao")
482:         DO CASE
483:             CASE THIS.this_cPcEscolha == "INSERIR"
484:                 loc_cSufixo = " - Novo"
485:             CASE THIS.this_cPcEscolha == "ALTERAR"
486:                 loc_cSufixo = " - Edi" + CHR(231) + CHR(227) + "o"
487:             OTHERWISE
488:                 loc_cSufixo = ""
489:         ENDCASE
490: 
491:         IF !EMPTY(loc_cSufixo) AND PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
492:             IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_Titulo", 5)
493:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption + loc_cSufixo
494:             ENDIF
495:             IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_Sombra", 5)
496:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption + loc_cSufixo
497:             ENDIF
498:         ENDIF
499: 
500:         *-- Habilitar/desabilitar Confirmar conforme codigo da conta recebido
501:         IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
502:             THIS.cmd_4c_Confirmar.Enabled = !EMPTY(THIS.this_cContas)
503:         ENDIF
504:     ENDPROC
505: 
506:     *--------------------------------------------------------------------------
507:     * ConfigurarBotoes - Cria botoes Confirmar e Cancelar
508:     * Legado: btnconfirma (Top=3, Left=850) e btnsair (Top=3, Left=925)
509:     *--------------------------------------------------------------------------
510:     PROTECTED PROCEDURE ConfigurarBotoes()
511:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
512:         WITH THIS.cmd_4c_Confirmar
513:             .Top             = 3
514:             .Left            = 850
515:             .Width           = 75
516:             .Height          = 75
517:             .Caption         = "Confirmar"
518:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
519:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
520:             .FontName        = "Tahoma"
521:             .FontBold        = .T.
522:             .FontItalic      = .T.
523:             .FontSize        = 8
524:             .ForeColor       = RGB(90, 90, 90)
525:             .BackColor       = RGB(255, 255, 255)
526:             .Themes          = .T.
527:             .SpecialEffect   = 0
528:             .PicturePosition = 13
529:             .MousePointer    = 15
530:             .WordWrap        = .T.
531:         ENDWITH
532: 
533:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
534:         WITH THIS.cmd_4c_Cancelar
535:             .Top             = 3
536:             .Left            = 925
537:             .Width           = 75
538:             .Height          = 75
539:             .Caption         = "Encerrar"
540:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
541:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
542:             .FontName        = "Tahoma"
543:             .FontBold        = .T.
544:             .FontItalic      = .T.
545:             .FontSize        = 8
546:             .ForeColor       = RGB(90, 90, 90)
547:             .BackColor       = RGB(255, 255, 255)
548:             .Themes          = .T.
549:             .SpecialEffect   = 0
550:             .PicturePosition = 13
551:             .MousePointer    = 15
552:             .WordWrap        = .T.
553:         ENDWITH
554: 
555:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
556:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
557:     ENDPROC
558: 
559:     *--------------------------------------------------------------------------
560:     * CarregarAlertas - Chama BO para popular crSigCdAle e vincula ao grid
561:     * Apos RecordSource, reconfigura headers (VFP9 reseta headers ao mudar RecordSource)
562:     *--------------------------------------------------------------------------
563:     PROTECTED PROCEDURE CarregarAlertas()
564:         LOCAL loc_oErro
565: 
566:         TRY
567:             IF THIS.this_oBusinessObject.CarregarAlertas(THIS.this_cContas)
568:                 *-- ColumnCount ANTES de RecordSource para evitar auto-expansao
569:                 THIS.grd_4c_Dados.ColumnCount = 7
570:                 THIS.grd_4c_Dados.RecordSource = "crSigCdAle"
571: 
572:                 *-- ControlSource: checkbox cols apos CurrentControl ja definido em ConfigurarGrade
573:                 THIS.grd_4c_Dados.Column1.ControlSource = "crSigCdAle.Descrs"
574:                 THIS.grd_4c_Dados.Column2.ControlSource = "crSigCdAle.inserirs"
575:                 THIS.grd_4c_Dados.Column3.ControlSource = "crSigCdAle.alterars"
576:                 THIS.grd_4c_Dados.Column4.ControlSource = "crSigCdAle.excluirs"
577:                 THIS.grd_4c_Dados.Column5.ControlSource = "crSigCdAle.baixas"
578:                 THIS.grd_4c_Dados.Column6.ControlSource = "crSigCdAle.prioridade"
579:                 THIS.grd_4c_Dados.Column7.ControlSource = "crSigCdAle.mensagems"
580: 
581:                 *-- Reconfigurar headers apos RecordSource (VFP9 reseta captions)
582:                 THIS.grd_4c_Dados.Column1.Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
583:                 THIS.grd_4c_Dados.Column2.Header1.Caption    = "I"
584:                 THIS.grd_4c_Dados.Column3.Header1.Caption    = "A"
585:                 THIS.grd_4c_Dados.Column4.Header1.Caption    = "E"
586:                 THIS.grd_4c_Dados.Column5.Header1.Caption    = "B"
587:                 THIS.grd_4c_Dados.Column6.Header1.Caption    = "Prioridade"
588:                 THIS.grd_4c_Dados.Column7.Header1.Caption    = "Mensagem"
589:                 THIS.grd_4c_Dados.Column2.Header1.Alignment  = 2
590:                 THIS.grd_4c_Dados.Column3.Header1.Alignment  = 2
591:                 THIS.grd_4c_Dados.Column4.Header1.Alignment  = 2
592:                 THIS.grd_4c_Dados.Column5.Header1.Alignment  = 2
593:                 THIS.grd_4c_Dados.Column6.Header1.Alignment  = 2
594:                 THIS.grd_4c_Dados.Column7.Header1.Alignment  = 2
595:             ENDIF
596:         CATCH TO loc_oErro
597:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
598:                     " PROC=" + loc_oErro.Procedure, "Erro ao carregar alertas")
599:         ENDTRY
600:     ENDPROC
601: 
602:     *--------------------------------------------------------------------------
603:     * TornarControlesVisiveis - Torna visiveis todos os controles do form e filhos
604:     * (AddObject cria controles com Visible=.F. por padrao)
605:     *--------------------------------------------------------------------------
606:     PROTECTED PROCEDURE TornarControlesVisiveis()
607:         LOCAL loc_i, loc_j, loc_oControl, loc_oSub
608: 
609:         FOR loc_i = 1 TO THIS.ControlCount
610:             loc_oControl = THIS.Controls(loc_i)
611:             IF VARTYPE(loc_oControl) = "O"
612:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
613:                     loc_oControl.Visible = .T.
614:                 ENDIF
615:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
616:                     FOR loc_j = 1 TO loc_oControl.ControlCount
617:                         loc_oSub = loc_oControl.Controls(loc_j)
618:                         IF VARTYPE(loc_oSub) = "O" AND PEMSTATUS(loc_oSub, "Visible", 5)
619:                             loc_oSub.Visible = .T.
620:                         ENDIF
621:                     ENDFOR
622:                 ENDIF
623:             ENDIF
624:         ENDFOR
625:     ENDPROC
626: 
627:     *--------------------------------------------------------------------------
628:     * BtnConfirmarClick - Salva configuracao de alertas e fecha o form
629:     * Legado: btnconfirma.Click
630:     * Remove filtro do optTabela, delega save ao BO e fecha
631:     *--------------------------------------------------------------------------
632:     PROCEDURE BtnConfirmarClick()
633:         LOCAL loc_oErro
634: 
635:         TRY
636:             *-- Remover filtro para que SalvarAlertas processe todos os registros
637:             IF USED("crSigCdAle")
638:                 SELECT crSigCdAle
639:                 SET ORDER TO TAG Tabelas
640:                 SET KEY TO
641:             ENDIF
642: 
643:             IF THIS.this_oBusinessObject.SalvarAlertas(THIS.this_cPcEscolha)
644:                 THIS.Release()
645:             ENDIF
646:         CATCH TO loc_oErro
647:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
648:                     " PROC=" + loc_oErro.Procedure, "Erro ao confirmar")
649:         ENDTRY
650:     ENDPROC
651: 
652:     *--------------------------------------------------------------------------
653:     * BtnCancelarClick - Fecha o form sem salvar
654:     * Legado: btnsair.Click
655:     *--------------------------------------------------------------------------
656:     PROCEDURE BtnCancelarClick()
657:         THIS.Release()
658:     ENDPROC
659: 
660:     *--------------------------------------------------------------------------
661:     * BtnSalvarClick - Alias canonico do pipeline para o botao de confirmacao
662:     * O legado SIGCDALE usa btnconfirma (cmd_4c_Confirmar), sem botao "Salvar"
663:     * distinto. Este wrapper existe para compatibilidade com o contrato do
664:     * pipeline (validacao mecanica) e apenas delega para BtnConfirmarClick.
665:     *--------------------------------------------------------------------------
666:     PROCEDURE BtnSalvarClick()
667:         THIS.BtnConfirmarClick()
668:     ENDPROC
669: 
670:     *--------------------------------------------------------------------------
671:     * OptTabelaInteractiveChange - Filtra grid conforme tabela selecionada
672:     * Legado: optTabela.InteractiveChange
673:     * Opcoes: 1=SIGCDOPE, 2=SIGCDGCR, 3=SIGCDOPD, 4=SIGCDPRO, 5=SIGOPOPE
674:     *--------------------------------------------------------------------------
675:     PROCEDURE OptTabelaInteractiveChange()
676:         LOCAL loc_nOpcao, loc_oErro
677: 
678:         TRY
679:             loc_nOpcao = THIS.obj_4c_OptTabela.Value
680:             THIS.this_oBusinessObject.FiltrarPorTabela(loc_nOpcao)
681:             THIS.grd_4c_Dados.Refresh()
682:         CATCH TO loc_oErro
683:             MsgErro(loc_oErro.Message, "Erro")
684:         ENDTRY
685:     ENDPROC
686: 
687:     *--------------------------------------------------------------------------
688:     * CboGradeComboChange - Atualiza campo priors (numerico) ao trocar prioridade
689:     * Legado: grade_ale.Column6.fwcombo1.InteractiveChange
690:     * ListItemId: 1=URGENTE, 2=IMPORTANTE, 3=NORMAL
691:     *--------------------------------------------------------------------------
692:     PROCEDURE CboGradeComboChange()
693:         LOCAL loc_nListItemId, loc_oErro
694: 
695:         TRY
696:             IF USED("crSigCdAle")
697:                 loc_nListItemId = THIS.grd_4c_Dados.Column6.Combo1.ListItemId
698:                 REPLACE priors WITH loc_nListItemId IN crSigCdAle
699:             ENDIF
700:         CATCH TO loc_oErro
701:             MsgErro(loc_oErro.Message, "Erro")
702:         ENDTRY
703:     ENDPROC
704: 
705:     *--------------------------------------------------------------------------
706:     * BtnIncluirClick - Ativa TODOS os flags (I/A/E/B) do registro corrente
707:     * Semantica operacional adaptada: "Incluir" = ativar todas as notificacoes
708:     * deste evento (o grid ja lista os eventos disponiveis; nao existe "novo"
709:     * porque a lista eh derivada das tabelas de referencia SIGCDOPE/GCR/OPD/PRO/OPOPE)
710:     *--------------------------------------------------------------------------
711:     PROCEDURE BtnIncluirClick()
712:         LOCAL loc_oErro
713: 
714:         TRY
715:             IF !USED("crSigCdAle") OR RECCOUNT("crSigCdAle") = 0
716:                 MsgAviso("Nenhum registro dispon" + CHR(237) + "vel para ativar alertas.", "Aviso")
717:                 RETURN
718:             ENDIF
719: 
720:             SELECT crSigCdAle
721:             REPLACE inserirs WITH 1, alterars WITH 1, excluirs WITH 1, baixas WITH 1 ;
722:                 IN crSigCdAle
723:             THIS.grd_4c_Dados.Refresh()
724:         CATCH TO loc_oErro
725:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
726:                     " PROC=" + loc_oErro.Procedure, "Erro ao ativar alertas")
727:         ENDTRY
728:     ENDPROC
729: 
730:     *--------------------------------------------------------------------------
731:     * BtnAlterarClick - Recarrega alertas do banco descartando edicoes em memoria
732:     * Semantica operacional: reverte alteracoes nao confirmadas + reforca foco
733:     * no grid para permitir edicao dos checkboxes/combobox/editbox
734:     *--------------------------------------------------------------------------
735:     PROCEDURE BtnAlterarClick()
736:         LOCAL loc_oErro
737: 
738:         TRY
739:             IF EMPTY(THIS.this_cContas)
740:                 MsgAviso("Conta n" + CHR(227) + "o informada. N" + CHR(227) + ;
741:                         "o eh poss" + CHR(237) + "vel recarregar alertas.", "Aviso")
742:                 RETURN
743:             ENDIF
744: 
745:             THIS.CarregarAlertas()
746:             THIS.grd_4c_Dados.Refresh()
747:             THIS.grd_4c_Dados.SetFocus()
748:         CATCH TO loc_oErro
749:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
750:                     " PROC=" + loc_oErro.Procedure, "Erro ao recarregar alertas")
751:         ENDTRY
752:     ENDPROC
753: 
754:     *--------------------------------------------------------------------------
755:     * BtnVisualizarClick - Exibe resumo do alerta corrente em dialog informativo
756:     * Semantica operacional: leitura consolidada do registro selecionado no grid
757:     * (descricao do evento, flags I/A/E/B, prioridade e mensagem)
758:     *--------------------------------------------------------------------------
759:     PROCEDURE BtnVisualizarClick()
760:         LOCAL loc_cResumo, loc_cDesc, loc_cMsg, loc_nPri, loc_cPri, loc_oErro
761: 
762:         TRY
763:             IF !USED("crSigCdAle") OR RECCOUNT("crSigCdAle") = 0
764:                 MsgAviso("Nenhum registro selecionado para visualiza" + CHR(231) + CHR(227) + "o.", "Aviso")
765:                 RETURN
766:             ENDIF
767: 
768:             SELECT crSigCdAle
769:             loc_cDesc = ALLTRIM(NVL(crSigCdAle.Descrs, ""))
770:             loc_cMsg  = ALLTRIM(NVL(crSigCdAle.Mensagems, ""))
771:             loc_nPri  = NVL(crSigCdAle.priors, 0)
772: 
773:             DO CASE
774:                 CASE loc_nPri = 1
775:                     loc_cPri = "URGENTE"
776:                 CASE loc_nPri = 2
777:                     loc_cPri = "IMPORTANTE"
778:                 CASE loc_nPri = 3
779:                     loc_cPri = "NORMAL"
780:                 OTHERWISE
781:                     loc_cPri = "N/D"
782:             ENDCASE
783: 
784:             loc_cResumo = "Evento    : " + loc_cDesc + CHR(13) + ;
785:                           "Inserir   : " + IIF(crSigCdAle.inserirs = 1, "Sim", "N" + CHR(227) + "o") + CHR(13) + ;
786:                           "Alterar   : " + IIF(crSigCdAle.alterars = 1, "Sim", "N" + CHR(227) + "o") + CHR(13) + ;
787:                           "Excluir   : " + IIF(crSigCdAle.excluirs = 1, "Sim", "N" + CHR(227) + "o") + CHR(13) + ;
788:                           "Baixar    : " + IIF(crSigCdAle.baixas   = 1, "Sim", "N" + CHR(227) + "o") + CHR(13) + ;
789:                           "Prioridade: " + loc_cPri + CHR(13) + ;
790:                           "Mensagem  : " + loc_cMsg
791: 
792:             MsgInfo(loc_cResumo, "Detalhes do Alerta")
793:         CATCH TO loc_oErro
794:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
795:                     " PROC=" + loc_oErro.Procedure, "Erro ao visualizar alerta")
796:         ENDTRY
797:     ENDPROC
798: 
799:     *--------------------------------------------------------------------------
800:     * BtnExcluirClick - Desativa TODOS os flags do registro corrente
801:     * Semantica operacional: "Excluir" = zerar flags I/A/E/B do evento
802:     * (nao remove a linha do grid porque ela representa um evento fixo da tabela
803:     * de referencia; apenas desativa as notificacoes associadas)
804:     *--------------------------------------------------------------------------
805:     PROCEDURE BtnExcluirClick()
806:         LOCAL loc_oErro
807: 
808:         TRY
809:             IF !USED("crSigCdAle") OR RECCOUNT("crSigCdAle") = 0
810:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
811:                 RETURN
812:             ENDIF
813: 
814:             IF !MsgConfirma("Desativar todos os alertas do registro corrente?", "Confirmar")
815:                 RETURN
816:             ENDIF
817: 
818:             SELECT crSigCdAle
819:             REPLACE inserirs WITH 0, alterars WITH 0, excluirs WITH 0, baixas WITH 0 ;
820:                 IN crSigCdAle
821:             THIS.grd_4c_Dados.Refresh()
822:         CATCH TO loc_oErro
823:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
824:                     " PROC=" + loc_oErro.Procedure, "Erro ao desativar alertas")
825:         ENDTRY
826:     ENDPROC
827: 
828:     *--------------------------------------------------------------------------
829:     * CarregarLista - Recarrega dados do grid (wrapper para CarregarAlertas)
830:     *--------------------------------------------------------------------------
831:     PROCEDURE CarregarLista()
832:         LOCAL loc_lResultado, loc_oErro
833:         loc_lResultado = .F.
834: 
835:         TRY
836:             loc_lResultado = THIS.CarregarAlertas(THIS.this_cContas)
837:             IF loc_lResultado
838:                 THIS.grd_4c_Dados.Refresh()
839:             ENDIF
840:         CATCH TO loc_oErro
841:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
842:                     " PROC=" + loc_oErro.Procedure, "Erro ao carregar lista")
843:         ENDTRY
844: 
845:         RETURN loc_lResultado
846:     ENDPROC
847: 
848:     *--------------------------------------------------------------------------
849:     * FormParaBO - Carrega propriedades do BO com dados do registro corrente
850:     * Form OPERACIONAL: le linha corrente do cursor crSigCdAle
851:     *--------------------------------------------------------------------------
852:     PROTECTED PROCEDURE FormParaBO()
853:         LOCAL loc_oErro
854: 
855:         TRY
856:             IF USED("crSigCdAle") AND RECCOUNT("crSigCdAle") > 0
857:                 THIS.this_oBusinessObject.CarregarDoCursor("crSigCdAle")
858:             ENDIF
859:         CATCH TO loc_oErro
860:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
861:                     " PROC=" + loc_oErro.Procedure, "Erro em FormParaBO")
862:         ENDTRY
863:     ENDPROC
864: 
865:     *--------------------------------------------------------------------------
866:     * BOParaForm - Atualiza exibicao do grid com estado atual
867:     * Form OPERACIONAL: o grid eh a interface primaria de edicao
868:     *--------------------------------------------------------------------------
869:     PROTECTED PROCEDURE BOParaForm()
870:         LOCAL loc_oErro
871: 
872:         TRY
873:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
874:                 THIS.grd_4c_Dados.Refresh()
875:             ENDIF
876:         CATCH TO loc_oErro
877:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
878:         ENDTRY
879:     ENDPROC
880: 
881:     *--------------------------------------------------------------------------
882:     * HabilitarCampos - Habilita/desabilita controles interativos do form
883:     * par_lHabilitar: .T. = habilitar, .F. = desabilitar
884:     *--------------------------------------------------------------------------
885:     PROCEDURE HabilitarCampos(par_lHabilitar)
886:         LOCAL loc_lHab
887:         loc_lHab = .T.
888:         IF TYPE("par_lHabilitar") = "L"
889:             loc_lHab = par_lHabilitar
890:         ENDIF
891: 
892:         IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
893:             THIS.cmd_4c_Confirmar.Enabled = loc_lHab AND !EMPTY(THIS.this_cContas)
894:         ENDIF
895:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
896:             THIS.grd_4c_Dados.ReadOnly = !loc_lHab
897:         ENDIF
898:         IF PEMSTATUS(THIS, "obj_4c_OptTabela", 5)
899:             THIS.obj_4c_OptTabela.Enabled = loc_lHab
900:         ENDIF
901:     ENDPROC
902: 
903:     *--------------------------------------------------------------------------
904:     * LimparCampos - Zera cursor de alertas e propriedades do BO
905:     *--------------------------------------------------------------------------
906:     PROTECTED PROCEDURE LimparCampos()
907:         LOCAL loc_oErro
908: 
909:         TRY
910:             IF USED("crSigCdAle")
911:                 SELECT crSigCdAle
912:                 ZAP
913:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
914:                     THIS.grd_4c_Dados.Refresh()
915:                 ENDIF
916:             ENDIF
917:             THIS.this_oBusinessObject.LimparDados()
918:         CATCH TO loc_oErro
919:             MsgErro(loc_oErro.Message, "Erro ao limpar")
920:         ENDTRY
921:     ENDPROC
922: 
923:     *--------------------------------------------------------------------------
924:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme disponibilidade
925:     * Form OPERACIONAL: sem modos CRUD; Confirmar depende da conta informada
926:     *--------------------------------------------------------------------------
927:     PROCEDURE AjustarBotoesPorModo()
928:         LOCAL loc_lTemConta, loc_lTemDados
929: 
930:         loc_lTemConta = !EMPTY(THIS.this_cContas)
931:         loc_lTemDados = USED("crSigCdAle") AND RECCOUNT("crSigCdAle") > 0
932: 
933:         IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
934:             THIS.cmd_4c_Confirmar.Enabled = loc_lTemConta
935:         ENDIF
936:         IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
937:             THIS.cmd_4c_Cancelar.Enabled = .T.
938:         ENDIF
939:         IF PEMSTATUS(THIS, "obj_4c_OptTabela", 5)
940:             THIS.obj_4c_OptTabela.Enabled = loc_lTemDados
941:         ENDIF
942:     ENDPROC
943: 
944:     *--------------------------------------------------------------------------
945:     * BtnEncerrarClick - Alias canonico para fechar o form sem salvar
946:     *--------------------------------------------------------------------------
947:     PROCEDURE BtnEncerrarClick()
948:         THIS.Release()
949:     ENDPROC
950: 
951:     *--------------------------------------------------------------------------
952:     * Destroy - Libera cursor principal e referencia ao form pai
953:     *--------------------------------------------------------------------------
954:     PROCEDURE Destroy()
955:         IF USED("crSigCdAle")
956:             TABLEREVERT(.T., "crSigCdAle")
957:             USE IN crSigCdAle
958:         ENDIF
959:         THIS.this_oParentForm = .NULL.
960:         DODEFAULT()
961:     ENDPROC
962: 
963: ENDDEFINE


### BO (C:\4c\projeto\app\classes\aleBO.prg):
*==============================================================================
* ALEBO.PRG
* Business Object para Configuracao de Alertas por Conta (SigCdAle)
*
* Tabela Principal : SigCdAle - Alertas configurados por conta/operacao
*                    (pkchaves C(20) PK, dopes C, Tabelas C, inserirs N, alterars N,
*                     excluirs N, baixas N, priors N, mensagems text, datas T, dtalts T,
*                     contas C, grupos C, usuarios C)
*
* Logica: Form OPERACIONAL que configura quais alertas uma conta recebe
*         para cada tabela de referencia (SIGCDOPE/SIGCDGCR/SIGCDPRO/SIGCDOPD/SIGOPOPE).
*         Confirmar = DELETE todos os alertas da conta + re-INSERT apenas registros com
*         pelo menos um flag ativo (inserirs<>0 OR alterars<>0 OR excluirs<>0 OR baixas<>0).
*         O grid exibe uniao das 5 tabelas de referencia com LEFT JOIN em SigCdAle.
*==============================================================================

DEFINE CLASS aleBO AS BusinessBase

    *-- Identificacao da conta (parametro recebido pelo form)
    this_cContas              = ""    && IClis da conta selecionada (FK SigCdCli)

    *-- Campos da SigCdAle (registro atual)
    this_cDopes               = ""    && Codigo da operacao/grupo/produto (FK variavel)
    this_cTabelas             = ""    && Tabela de referencia (SIGCDOPE/SIGCDGCR/SIGCDPRO/SIGCDOPD/SIGOPOPE)
    this_nInserirs            = 0     && Flag permissao Inserir (0=nao, 1=sim)
    this_nAlterars            = 0     && Flag permissao Alterar (0=nao, 1=sim)
    this_nExcluirs            = 0     && Flag permissao Excluir (0=nao, 1=sim)
    this_nBaixas              = 0     && Flag permissao Baixar  (0=nao, 1=sim)
    this_nPriors              = 0     && Prioridade numerica (0=NORMAL, 1=URGENTE, 2=IMPORTANTE)
    this_cMensagems           = ""    && Mensagem de alerta (varchar/text)
    this_dDatas               = {}    && Data/hora de criacao
    this_dDtalts              = {}    && Data/hora de ultima alteracao
    this_cGrupos              = ""    && Grupo associado
    this_cPkChaves            = ""    && Chave primaria unica gerada por fUniqueIds()
    this_cUsuarios            = ""    && Usuario que realizou a configuracao

    *-- Descricao para exibicao (coluna Descrs do cursor, nao persiste em SigCdAle)
    this_cDescrs              = ""    && Descricao derivada da tabela de referencia

    *-- Modo de operacao herdado do form pai (INSERIR/ALTERAR)
    this_cPcEscolha           = ""    && Modo vindo de parentform.pcescolha

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdAle"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados de uma linha do cursor crSigCdAle
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes      = TratarNulo(Dopes,     "C")
                THIS.this_cDescrs     = TratarNulo(Descrs,    "C")
                THIS.this_cTabelas    = TratarNulo(Tabelas,   "C")
                THIS.this_nInserirs   = NVL(inserirs,  0)
                THIS.this_nAlterars   = NVL(alterars,  0)
                THIS.this_nExcluirs   = NVL(excluirs,  0)
                THIS.this_nBaixas     = NVL(baixas,    0)
                THIS.this_nPriors     = NVL(priors,    0)
                THIS.this_cMensagems  = TratarNulo(mensagems, "C")
                THIS.this_cGrupos     = TratarNulo(grupos,    "C")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,  "C")
                THIS.this_cContas     = TratarNulo(contas,    "C")
                THIS.this_cUsuarios   = TratarNulo(usuarios,  "C")

                IF VARTYPE(datas) = "T" OR VARTYPE(datas) = "D"
                    THIS.this_dDatas  = NVL(datas,  {})
                ELSE
                    THIS.this_dDatas  = {}
                ENDIF

                IF VARTYPE(dtalts) = "T" OR VARTYPE(dtalts) = "D"
                    THIS.this_dDtalts = NVL(dtalts, {})
                ELSE
                    THIS.this_dDtalts = {}
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta propriedades para estado vazio
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cDopes      = ""
        THIS.this_cDescrs     = ""
        THIS.this_cTabelas    = ""
        THIS.this_nInserirs   = 0
        THIS.this_nAlterars   = 0
        THIS.this_nExcluirs   = 0
        THIS.this_nBaixas     = 0
        THIS.this_nPriors     = 0
        THIS.this_cMensagems  = ""
        THIS.this_cGrupos     = ""
        THIS.this_cPkChaves   = ""
        THIS.this_cUsuarios   = ""
        THIS.this_dDatas      = {}
        THIS.this_dDtalts     = {}
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAlertas - Popula os 5 cursores de referencia com LEFT JOIN SigCdAle
    * e une em crSigCdAle com INDEX ON Tabelas TAG Tabelas
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAlertas(par_cContas)
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_cContasEsc
        loc_lResultado = .F.
        THIS.this_cContas = ALLTRIM(NVL(par_cContas, ""))

        TRY
            loc_cContasEsc = EscaparSQL(THIS.this_cContas)

            *-- Movimentacao de Estoque (SigCdOpe)
            loc_cSQL = "SELECT OPE.dopes, OPE.Dopes AS Descrs, 'SIGCDOPE' AS Tabelas, " + ;
                "CASE WHEN ALE.inserirs IS NULL THEN 0 ELSE ALE.inserirs END inserirs, " + ;
                "CASE WHEN ALE.alterars IS NULL THEN 0 ELSE ALE.alterars END alterars, " + ;
                "CASE WHEN ALE.excluirs IS NULL THEN 0 ELSE ALE.excluirs END excluirs, " + ;
                "CASE WHEN ALE.baixas IS NULL THEN 0 ELSE ALE.baixas END baixas, " + ;
                "CASE WHEN ALE.priors = 1 THEN 'URGENTE' WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN ALE.mensagems IS NULL THEN '' ELSE ALE.mensagems END mensagems, " + ;
                "ALE.datas, ALE.dtalts, ALE.contas, " + ;
                "CASE WHEN ALE.grupos IS NULL THEN '' ELSE ALE.grupos END grupos, " + ;
                "CASE WHEN ALE.pkchaves IS NULL THEN '' ELSE ALE.pkchaves END pkchaves, " + ;
                "CASE WHEN ALE.priors IS NULL THEN 0 ELSE ALE.priors END priors, " + ;
                "CASE WHEN ALE.usuarios IS NULL THEN '' ELSE ALE.usuarios END usuarios " + ;
                "FROM SigCdOpe OPE " + ;
                "INNER JOIN SigOpCdc CDC ON CDC.Dopes = OPE.Dopes AND CDC.OpeInatvs = 0 " + ;
                "LEFT OUTER JOIN SigCdAle ALE ON OPE.Dopes = ALE.dopes " + ;
                "AND ALE.Tabelas = 'SIGCDOPE' AND ALE.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleOpe")

            *-- Grupo de Contas (SigCdGcr)
            loc_cSQL = "SELECT a.Codigos AS Dopes, a.Descrs, 'SIGCDGCR' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigCdGcr a " + ;
                "LEFT OUTER JOIN SigCdAle b ON SUBSTRING(b.Dopes, 1, 10) = a.Codigos " + ;
                "AND b.Tabelas = 'SIGCDGCR' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleGcr")

            *-- Grupo de Produtos (SigCdGrp -> SIGCDPRO)
            loc_cSQL = "SELECT a.Cgrus AS Dopes, a.Dgrus AS Descrs, 'SIGCDPRO' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigCdGrp a " + ;
                "LEFT OUTER JOIN SigCdAle b ON SUBSTRING(b.Dopes, 1, 3) = a.Cgrus " + ;
                "AND b.Tabelas = 'SIGCDPRO' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AlePro")

            *-- Movimentacao de Producao (SigCdOpd -> SIGCDOPD)
            loc_cSQL = "SELECT a.Dopps AS Dopes, a.Dopps AS Descrs, 'SIGCDOPD' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigCdOpd a " + ;
                "LEFT OUTER JOIN SigCdAle b ON b.Dopes = a.Dopps " + ;
                "AND b.Tabelas = 'SIGCDOPD' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleOpd")

            *-- Movimentacao Financeira (SigOpOpe -> SIGOPOPE)
            loc_cSQL = "SELECT a.Dopes AS Dopes, a.Dopes AS Descrs, 'SIGOPOPE' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigOpOpe a " + ;
                "LEFT OUTER JOIN SigCdAle b ON b.Dopes = a.Dopes " + ;
                "AND b.Tabelas = 'SIGOPOPE' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleOpOpe")

            *-- Unir os 5 cursores em crSigCdAle com estrutura identica
            IF USED("crSigCdAle")
                TABLEREVERT(.T., "crSigCdAle")
                USE IN crSigCdAle
            ENDIF

            SET NULL ON
            SELECT ;
                Dopes, PADR(Descrs, 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleOpe ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(RTRIM(Dopes) + " - " + RTRIM(Descrs), 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleGcr ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(RTRIM(Dopes) + " - " + RTRIM(Descrs), 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AlePro ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(Descrs, 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleOpd ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(Descrs, 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleOpOpe ;
            INTO CURSOR crSigCdAle READWRITE ORDER BY Tabelas, Dopes
            SET NULL OFF

            SELECT crSigCdAle
            INDEX ON Tabelas TAG Tabelas
            SET ORDER TO TAG Tabelas
            SET KEY TO "SIGCDOPE"
            GO TOP

            *-- Fechar cursores intermediarios
            IF USED("cursor_4c_AleOpe")
                USE IN cursor_4c_AleOpe
            ENDIF
            IF USED("cursor_4c_AleGcr")
                USE IN cursor_4c_AleGcr
            ENDIF
            IF USED("cursor_4c_AlePro")
                USE IN cursor_4c_AlePro
            ENDIF
            IF USED("cursor_4c_AleOpd")
                USE IN cursor_4c_AleOpd
            ENDIF
            IF USED("cursor_4c_AleOpOpe")
                USE IN cursor_4c_AleOpOpe
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao carregar alertas")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlertas - Salva configuracao de alertas da conta:
    *   1. Filtra crSigCdAle para registros com ao menos 1 flag ativo
    *   2. DELETE todos os alertas da conta no SQL Server
    *   3. Re-INSERT cada registro filtrado (INSERT direto via SQLEXEC)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAlertas(par_cPcEscolha)
        LOCAL loc_lResultado, loc_oErro, loc_cSQL
        LOCAL loc_cDopes, loc_cTabelas, loc_nInserirs, loc_nAlterars
        LOCAL loc_nExcluirs, loc_nBaixas, loc_nPriors, loc_cMensagems
        LOCAL loc_cGrupos, loc_cPkChaves, loc_cUsuarios
        LOCAL loc_dDatas, loc_cContasEsc, loc_cPcEscolha
        loc_lResultado = .F.
        loc_cPcEscolha = UPPER(ALLTRIM(NVL(par_cPcEscolha, "")))

        TRY
            IF !USED("crSigCdAle")
                THIS.this_cMensagemErro = "Cursor de alertas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                MsgAviso(THIS.this_cMensagemErro, "Aviso")
            ELSE
                loc_cContasEsc = EscaparSQL(THIS.this_cContas)

                *-- Seleciona apenas registros com pelo menos um flag ativo
                SELECT Dopes, Tabelas, inserirs, alterars, excluirs, baixas, ;
                       prioridade, CAST(Mensagems AS CHAR(200)) AS Mensagems, ;
                       datas, dtalts, grupos, pkchaves, priors, usuarios ;
                    FROM crSigCdAle ;
                    WHERE inserirs <> 0 OR alterars <> 0 OR excluirs <> 0 OR baixas <> 0 ;
                    INTO CURSOR cursor_4c_AleSave READWRITE

                SELECT cursor_4c_AleSave
                GO TOP

                *-- DELETE todos os alertas existentes desta conta
                loc_cSQL = "DELETE FROM SigCdAle WHERE Contas = " + loc_cContasEsc
                SQLEXEC(gnConnHandle, loc_cSQL)

                *-- Re-INSERT cada registro ativo
                LOCAL loc_lErroInsert
                loc_lErroInsert = .F.
                SCAN
                    loc_cDopes     = ALLTRIM(NVL(Dopes,    ""))
                    loc_cTabelas   = ALLTRIM(NVL(Tabelas,  ""))
                    loc_nInserirs  = NVL(inserirs, 0)
                    loc_nAlterars  = NVL(alterars, 0)
                    loc_nExcluirs  = NVL(excluirs, 0)
                    loc_nBaixas    = NVL(baixas,   0)
                    loc_nPriors    = NVL(priors,   0)
                    loc_cMensagems = ALLTRIM(NVL(Mensagems, ""))
                    loc_cGrupos    = ALLTRIM(NVL(grupos,   ""))
                    loc_cUsuarios  = gc_4c_UsuarioLogado
                    loc_cPkChaves  = fUniqueIds()

                    IF loc_cPcEscolha = "INSERIR"
                        loc_dDatas    = GETDATE()
                        loc_cSQL = "INSERT INTO SigCdAle " + ;
                            "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                            "priors, mensagems, datas, contas, grupos, pkchaves, usuarios) " + ;
                            "VALUES (" + ;
                            EscaparSQL(loc_cDopes)     + ", " + ;
                            EscaparSQL(loc_cTabelas)   + ", " + ;
                            FormatarNumeroSQL(loc_nInserirs, 0) + ", " + ;
                            FormatarNumeroSQL(loc_nAlterars, 0) + ", " + ;
                            FormatarNumeroSQL(loc_nExcluirs, 0) + ", " + ;
                            FormatarNumeroSQL(loc_nBaixas,   0) + ", " + ;
                            FormatarNumeroSQL(loc_nPriors,   0) + ", " + ;
                            EscaparSQL(loc_cMensagems) + ", " + ;
                            "GETDATE(), "               + ;
                            EscaparSQL(THIS.this_cContas) + ", " + ;
                            EscaparSQL(loc_cGrupos)    + ", " + ;
                            EscaparSQL(loc_cPkChaves)  + ", " + ;
                            EscaparSQL(loc_cUsuarios)  + ")"
                    ELSE
                        *-- ALTERAR: preserva datas original se existir, gera dtalts
                        IF VARTYPE(datas) = "T" AND !EMPTY(datas)
                            loc_cSQL = "INSERT INTO SigCdAle " + ;
                                "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                                "priors, mensagems, datas, dtalts, contas, grupos, pkchaves, usuarios) " + ;
                                "VALUES (" + ;
                                EscaparSQL(loc_cDopes)     + ", " + ;
                                EscaparSQL(loc_cTabelas)   + ", " + ;
                                FormatarNumeroSQL(loc_nInserirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nAlterars, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nExcluirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nBaixas,   0) + ", " + ;
                                FormatarNumeroSQL(loc_nPriors,   0) + ", " + ;
                                EscaparSQL(loc_cMensagems) + ", " + ;
                                FormatarDataSQL(datas)     + ", " + ;
                                "GETDATE(), "               + ;
                                EscaparSQL(THIS.this_cContas) + ", " + ;
                                EscaparSQL(loc_cGrupos)    + ", " + ;
                                EscaparSQL(loc_cPkChaves)  + ", " + ;
                                EscaparSQL(loc_cUsuarios)  + ")"
                        ELSE
                            loc_cSQL = "INSERT INTO SigCdAle " + ;
                                "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                                "priors, mensagems, datas, dtalts, contas, grupos, pkchaves, usuarios) " + ;
                                "VALUES (" + ;
                                EscaparSQL(loc_cDopes)     + ", " + ;
                                EscaparSQL(loc_cTabelas)   + ", " + ;
                                FormatarNumeroSQL(loc_nInserirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nAlterars, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nExcluirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nBaixas,   0) + ", " + ;
                                FormatarNumeroSQL(loc_nPriors,   0) + ", " + ;
                                EscaparSQL(loc_cMensagems) + ", " + ;
                                "GETDATE(), "               + ;
                                "GETDATE(), "               + ;
                                EscaparSQL(THIS.this_cContas) + ", " + ;
                                EscaparSQL(loc_cGrupos)    + ", " + ;
                                EscaparSQL(loc_cPkChaves)  + ", " + ;
                                EscaparSQL(loc_cUsuarios)  + ")"
                        ENDIF
                    ENDIF

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        THIS.this_cMensagemErro = "Erro ao inserir alerta para " + loc_cDopes
                        MsgErro(THIS.this_cMensagemErro, "Erro ao salvar")
                        loc_lErroInsert = .T.
                        EXIT
                    ELSE
                        *-- Registra auditoria de cada linha inserida no batch
                        THIS.this_cPkChaves = loc_cPkChaves
                        THIS.RegistrarAuditoria(IIF(loc_cPcEscolha = "INSERIR", "INSERT", "UPDATE"))
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_AleSave")
                    USE IN cursor_4c_AleSave
                ENDIF

                IF !loc_lErroInsert
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao salvar alertas")
            IF USED("cursor_4c_AleSave")
                USE IN cursor_4c_AleSave
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro em SigCdAle
    * Usa as propriedades this_* previamente populadas (via FormParaBO ou setter)
    * Gera pkchaves via fUniqueIds(), datas via GETDATE()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cContas)
                THIS.this_cMensagemErro = "Conta n" + CHR(227) + "o informada"
            ELSE
                IF EMPTY(THIS.this_cDopes)
                    THIS.this_cMensagemErro = "C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informado"
                ELSE
                    IF EMPTY(THIS.this_cTabelas)
                        THIS.this_cMensagemErro = "Tabela de refer" + CHR(234) + "ncia n" + CHR(227) + "o informada"
                    ELSE
                        THIS.this_cPkChaves = fUniqueIds()
                        THIS.this_cUsuarios = gc_4c_UsuarioLogado

                        loc_cSQL = "INSERT INTO SigCdAle " + ;
                            "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                            "priors, mensagems, datas, contas, grupos, pkchaves, usuarios) " + ;
                            "VALUES (" + ;
                            EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cTabelas))   + ", " + ;
                            FormatarNumeroSQL(THIS.this_nInserirs, 0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nAlterars, 0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nExcluirs, 0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nBaixas,   0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nPriors,   0) + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cMensagems)) + ", " + ;
                            "GETDATE(), " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cContas))    + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cGrupos))    + ", " + ;
                            EscaparSQL(THIS.this_cPkChaves)           + ", " + ;
                            EscaparSQL(THIS.this_cUsuarios)           + ")"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                        IF loc_nRet < 0
                            THIS.this_cMensagemErro = "Falha ao inserir alerta no SQL Server"
                        ELSE
                            THIS.RegistrarAuditoria("INSERT")
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarPorTabela - Aplica SET KEY TO na tabela de referencia selecionada
    * par_nOpcao: 1=SIGCDOPE, 2=SIGCDGCR, 3=SIGCDOPD, 4=SIGCDPRO, 5=SIGOPOPE
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarPorTabela(par_nOpcao)
        LOCAL loc_cChave, loc_oErro
        DO CASE
            CASE par_nOpcao = 1
                loc_cChave = "SIGCDOPE"
            CASE par_nOpcao = 2
                loc_cChave = "SIGCDGCR"
            CASE par_nOpcao = 3
                loc_cChave = "SIGCDOPD"
            CASE par_nOpcao = 4
                loc_cChave = "SIGCDPRO"
            OTHERWISE
                loc_cChave = "SIGOPOPE"
        ENDCASE

        TRY
            IF USED("crSigCdAle")
                SELECT crSigCdAle
                SET ORDER TO TAG Tabelas
                SET KEY TO loc_cChave
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

