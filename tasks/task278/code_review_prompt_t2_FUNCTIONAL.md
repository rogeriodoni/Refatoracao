# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEml.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (789 linhas total):

*-- Linhas 2 a 246:
2: * FormSigPrEml.prg - ALERTA - Email
3: * Tipo: OPERACIONAL (flat layout, sem PageFrame)
4: * Migrado de: SIGPREML.SCX
5: * Chamado com: CREATEOBJECT("FormSigPrEml", cEmpDopNums, cEscolha, @laOpeBaixa)
6: *              loFrm.Show()
7: * Parametros Init:
8: *   par_cEmpDopNums : Emp(3)+Dopes(20)+Numes(6) = 29 chars
9: *   par_cEscolha    : "INSERIR" | "ALTERAR" | "EXCLUIR"
10: *   par_laOpeBaixa  : array de EmpDopNums de baixas (opcional)
11: *==============================================================================
12: 
13: DEFINE CLASS FormSigPrEml AS FormBase
14: 
15:     *-- Dimensoes identicas ao legado
16:     Width        = 1000
17:     Height       = 600
18:     Caption      = "ALERTA - Email"
19:     AutoCenter   = .T.
20:     BorderStyle  = 2
21:     TitleBar     = 0
22:     ShowWindow   = 1
23:     WindowType   = 1
24:     ControlBox   = .F.
25:     Closable     = .F.
26:     MaxButton    = .F.
27:     MinButton    = .F.
28:     ShowTips     = .T.
29:     KeyPreview   = .T.
30: 
31:     *-- Estado do formulario
32:     this_oBusinessObject = .NULL.
33:     this_cMensagemErro   = ""
34:     this_cEmpDopNums     = ""
35:     this_cEscolha        = ""
36: 
37:     *==========================================================================
38:     * Init - Recebe parametros e transfere para DODEFAULT/InicializarForm
39:     *==========================================================================
40:     PROCEDURE Init(par_cEmpDopNums, par_cEscolha, par_laOpeBaixa)
41:         LOCAL loc_x, loc_nLen
42: 
43:         THIS.this_cEmpDopNums = IIF(TYPE("par_cEmpDopNums") = "C", par_cEmpDopNums, "")
44:         THIS.this_cEscolha    = IIF(TYPE("par_cEscolha")    = "C", par_cEscolha,    "")
45: 
46:         *-- Converter array de baixas em propriedade de array do objeto
47:         IF TYPE("par_laOpeBaixa") = "A"
48:             loc_nLen = ALEN(par_laOpeBaixa)
49:             IF loc_nLen > 0
50:                 DIMENSION THIS.this_laOpeBaixa[loc_nLen]
51:                 FOR loc_x = 1 TO loc_nLen
52:                     THIS.this_laOpeBaixa[loc_x] = par_laOpeBaixa[loc_x]
53:                 ENDFOR
54:             ELSE
55:                 DIMENSION THIS.this_laOpeBaixa[1]
56:                 THIS.this_laOpeBaixa[1] = ""
57:             ENDIF
58:         ELSE
59:             DIMENSION THIS.this_laOpeBaixa[1]
60:             THIS.this_laOpeBaixa[1] = ""
61:         ENDIF
62: 
63:         RETURN DODEFAULT()
64:     ENDPROC
65: 
66:     *==========================================================================
67:     PROTECTED PROCEDURE InicializarForm
68:     *==========================================================================
69:         LOCAL loc_lSucesso, loc_oErro
70: 
71:         loc_lSucesso = .F.
72: 
73:         TRY
74:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrEmlBO")
75: 
76:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
77:                 MsgErro("Erro ao criar objeto SigPrEmlBO.", "Erro")
78:             ELSE
79:                 IF !THIS.this_oBusinessObject.InicializarConexaoAlerta()
80:                     *-- Erro ja exibido em InicializarConexaoAlerta
81:                 ELSE
82:                     THIS.this_oBusinessObject.CarregarDados( ;
83:                         THIS.this_cEmpDopNums, ;
84:                         THIS.this_cEscolha, ;
85:                         @THIS.this_laOpeBaixa)
86: 
87:                     THIS.ConfigurarPageFrame()
88:                     THIS.ConfigurarPaginaLista()
89:                     THIS.ConfigurarPaginaDados()
90:                     THIS.TornarControlesVisiveis()
91:                     THIS.ConfigurarBINDEVENTs()
92: 
93:                     *-- Propagar Caption para labels do cabecalho
94:                     THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
95:                     THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
96: 
97:                     THIS.grd_4c_Dados.Refresh()
98:                     loc_lSucesso = .T.
99:                 ENDIF
100:             ENDIF
101:         CATCH TO loc_oErro
102:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
103:                     "Erro FormSigPrEml.InicializarForm")
104:         ENDTRY
105: 
106:         RETURN loc_lSucesso
107:     ENDPROC
108: 
109:     *==========================================================================
110:     PROTECTED PROCEDURE ConfigurarPageFrame
111:     *==========================================================================
112:         THIS.Picture      = gc_4c_CaminhoIcones + "new_background.jpg"
113:         THIS.ClipControls = .F.
114:         THIS.ScrollBars   = 0
115:         THIS.ShowTips     = .T.
116:     ENDPROC
117: 
118:     *==========================================================================
119:     * ConfigurarPaginaLista - Bloco fixo do topo do form OPERACIONAL
120:     *--------------------------------------------------------------------------
121:     * Equivale a "Page1 (Lista)" dos forms CRUD. Neste form plano monta o
122:     * cabecalho escuro (cnt_4c_Sombra), o shape decorativo, o botao Enviar
123:     * Email flutuante (cmd_4c_BtnEmail) e o container de saida (cnt_4c_Saida
124:     * com cmd_4c_Encerrar) que sao persistentes na visualizacao.
125:     *==========================================================================
126:     PROTECTED PROCEDURE ConfigurarPaginaLista()
127:         THIS.ConfigurarCabecalho()
128:         THIS.ConfigurarBotoes()
129:     ENDPROC
130: 
131:     *==========================================================================
132:     * ConfigurarPaginaDados - Area de trabalho (grid + botoes de selecao)
133:     *--------------------------------------------------------------------------
134:     * Equivale a "Page2 (Dados)" dos forms CRUD. Neste form plano monta a
135:     * grade principal (grd_4c_Dados exibindo cursor_4c_Total) e os botoes
136:     * auxiliares cmd_4c_SelTudo/cmd_4c_Apaga que operam sobre o cursor de
137:     * destinatarios.
138:     *==========================================================================
139:     PROTECTED PROCEDURE ConfigurarPaginaDados()
140:         THIS.ConfigurarGrade()
141:         THIS.ConfigurarSelecaoBotoes()
142:     ENDPROC
143: 
144:     *==========================================================================
145:     * AlternarPagina - Form OPERACIONAL plano: sem alternancia de paginas
146:     *--------------------------------------------------------------------------
147:     * Metodo mantido para atender contrato arquitetural do pipeline (Fase 4).
148:     * Forms OPERACIONAIS como SIGPREML nao possuem PageFrame Lista/Dados:
149:     * o layout completo eh persistente (cabecalho + grid + botoes de acao) e a
150:     * interacao acontece via botoes flutuantes sobre o grid. O parametro eh
151:     * ignorado e o metodo retorna sem efeito.
152:     *==========================================================================
153:     PROCEDURE AlternarPagina(par_nPagina)
154:         RETURN
155:     ENDPROC
156: 
157:     *==========================================================================
158:     PROTECTED PROCEDURE ConfigurarCabecalho
159:     *==========================================================================
160:         THIS.AddObject("cnt_4c_Sombra", "Container")
161:         WITH THIS.cnt_4c_Sombra
162:             .Visible     = .T.
163:             .Top         = 0
164:             .Left        = 0
165:             .Width       = THIS.Width
166:             .Height      = 80
167:             .BorderWidth = 0
168:             .BackColor   = RGB(100, 100, 100)
169:             .AddObject("lbl_4c_Sombra", "Label")
170:             WITH .lbl_4c_Sombra
171:                 .FontBold      = .T.
172:                 .FontName      = "Tahoma"
173:                 .FontSize      = 18
174:                 .FontUnderline = .F.
175:                 .WordWrap      = .T.
176:                 .Alignment     = 0
177:                 .AutoSize      = .F.
178:                 .BackStyle     = 0
179:                 .Caption       = THIS.Caption
180:                 .Height        = 40
181:                 .Left          = 10
182:                 .Top           = 18
183:                 .Width         = THIS.Width
184:                 .ForeColor     = RGB(0, 0, 0)
185:             ENDWITH
186:             .AddObject("lbl_4c_Titulo", "Label")
187:             WITH .lbl_4c_Titulo
188:                 .FontBold   = .T.
189:                 .FontName   = "Tahoma"
190:                 .FontSize   = 18
191:                 .WordWrap   = .T.
192:                 .Alignment  = 0
193:                 .AutoSize   = .F.
194:                 .BackStyle  = 0
195:                 .Caption    = THIS.Caption
196:                 .Height     = 46
197:                 .Left       = 10
198:                 .Top        = 17
199:                 .Width      = THIS.Width
200:                 .ForeColor  = RGB(255, 255, 255)
201:             ENDWITH
202:         ENDWITH
203:     ENDPROC
204: 
205:     *==========================================================================
206:     PROTECTED PROCEDURE ConfigurarBotoes
207:     *==========================================================================
208:         *-- Shape decorativo (Shape1 do legado)
209:         THIS.AddObject("shp_4c_Shape1", "Shape")
210:         WITH THIS.shp_4c_Shape1
211:             .Top           = -2
212:             .Left          = 819
213:             .Height        = 84
214:             .Width         = 84
215:             .BackStyle     = 0
216:             .BorderStyle   = 0
217:             .SpecialEffect = 1
218:         ENDWITH
219: 
220:         *-- Botao Enviar Email (btnEmail do legado) - standalone com icone 60px
221:         THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
222:         WITH THIS.cmd_4c_BtnEmail
223:             .Top         = 5
224:             .Left        = 848
225:             .Height      = 75
226:             .Width       = 75
227:             .FontBold    = .T.
228:             .FontItalic  = .T.
229:             .FontName    = "Tahoma"
230:             .FontSize    = 8
231:             .Picture     = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
232:             .Caption     = "Enviar Email"
233:             .ToolTipText = "Enviar Email"
234:             .ForeColor   = RGB(90, 90, 90)
235:             .BackColor   = RGB(255, 255, 255)
236:             .Themes      = .T.
237:         ENDWITH
238: 
239:         *-- Container canonico Encerrar (padrao novo sistema, Left=917)
240:         THIS.AddObject("cnt_4c_Saida", "Container")
241:         WITH THIS.cnt_4c_Saida
242:             .Top         = -2
243:             .Left        = 917
244:             .Width       = 90
245:             .Height      = 85
246:             .BorderWidth = 0

*-- Linhas 266 a 353:
266:     ENDPROC
267: 
268:     *==========================================================================
269:     PROTECTED PROCEDURE ConfigurarSelecaoBotoes
270:     *==========================================================================
271:         *-- Botao Marcar Todos (SelTudo do legado)
272:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
273:         WITH THIS.cmd_4c_SelTudo
274:             .Top         = 90
275:             .Left        = 4
276:             .Height      = 40
277:             .Width       = 40
278:             .FontName    = "Verdana"
279:             .FontSize    = 8
280:             .WordWrap    = .T.
281:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
282:             .Caption     = ""
283:             .TabStop     = .F.
284:             .ToolTipText = "Marcar Todos"
285:             .ForeColor   = RGB(36, 84, 155)
286:             .BackColor   = RGB(255, 255, 255)
287:             .Themes      = .T.
288:         ENDWITH
289: 
290:         *-- Botao Desmarcar Todos (apaga do legado)
291:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
292:         WITH THIS.cmd_4c_Apaga
293:             .Top         = 90
294:             .Left        = 43
295:             .Height      = 40
296:             .Width       = 40
297:             .FontBold    = .F.
298:             .FontItalic  = .F.
299:             .FontName    = "Verdana"
300:             .FontSize    = 8
301:             .WordWrap    = .T.
302:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
303:             .Caption     = ""
304:             .TabStop     = .F.
305:             .ToolTipText = "Desmarcar Todos"
306:             .ForeColor   = RGB(36, 84, 155)
307:             .BackColor   = RGB(255, 255, 255)
308:             .Themes      = .T.
309:         ENDWITH
310:     ENDPROC
311: 
312:     *==========================================================================
313:     PROTECTED PROCEDURE ConfigurarGrade
314:     *==========================================================================
315:         THIS.AddObject("grd_4c_Dados", "Grid")
316:         WITH THIS.grd_4c_Dados
317:             .Top                  = 132
318:             .Left                 = 3
319:             .Width                = 993
320:             .Height               = 435
321:             .RecordMark           = .F.
322:             .DeleteMark           = .F.
323:             .RowHeight            = 18
324:             .FontName             = "Verdana"
325:             .FontSize             = 8
326:             .ForeColor            = RGB(90, 90, 90)
327:             .BackColor            = RGB(255, 255, 255)
328:             .GridLineColor        = RGB(238, 238, 238)
329:             .HighlightStyle       = 2
330:             .HighlightBackColor   = RGB(255, 255, 255)
331:             .HighlightForeColor   = RGB(15, 41, 104)
332:             .AllowAutoColumnFit   = 2
333:             .GridLines            = 2
334:             .ColumnCount          = 5
335: 
336:             *-- Column1: Checkbox Checks (ColumnOrder=1 exibido a esquerda)
337:             *-- Ordem obrigatoria: AddObject -> CurrentControl -> Sparse -> ControlSource (Erro 1767)
338:             WITH .Column1
339:                 .ColumnOrder   = 1
340:                 .Width         = 17
341:                 .ReadOnly      = .F.
342:                 WITH .Header1
343:                     .Caption  = ""
344:                     .FontName = "Verdana"
345:                     .FontSize = 8
346:                 ENDWITH
347:                 .AddObject("ctlCheckbox", "CheckBox")
348:                 WITH .ctlCheckbox
349:                     .Caption   = ""
350:                     .Alignment = 0
351:                     .FontName  = "Verdana"
352:                     .FontSize  = 8
353:                     .Value     = 0

*-- Linhas 472 a 789:
472:     ENDPROC
473: 
474:     *==========================================================================
475:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
476:     *==========================================================================
477:         *-- Botoes de acao
478:         BINDEVENT(THIS.cmd_4c_BtnEmail,               "Click", THIS, "BtnEmailClick")
479:         BINDEVENT(THIS.cmd_4c_SelTudo,                "Click", THIS, "SelTudoClick")
480:         BINDEVENT(THIS.cmd_4c_Apaga,                  "Click", THIS, "ApagaClick")
481:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "EncerrarClick")
482: 
483:         *-- Cliques nos cabecalhos para ordenacao (Conta, Nome, Email)
484:         BINDEVENT(THIS.grd_4c_Dados.Column2.Header1, "Click", THIS, "Col2HeaderClick")
485:         BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "Col3HeaderClick")
486:         BINDEVENT(THIS.grd_4c_Dados.Column4.Header1, "Click", THIS, "Col4HeaderClick")
487: 
488:         *-- Checkbox individual para marcar/desmarcar linha
489:         BINDEVENT(THIS.grd_4c_Dados.Column1.ctlCheckbox, "InteractiveChange", ;
490:                   THIS, "GrdChkInteractiveChange")
491:     ENDPROC
492: 
493:     *==========================================================================
494:     * TornarControlesVisiveis - Form plano (sem PageFrame); nao ha containers
495:     * que devam permanecer ocultos, entao todos os controles ficam visiveis.
496:     *==========================================================================
497:     PROTECTED PROCEDURE TornarControlesVisiveis()
498:         LOCAL loc_i, loc_oControl
499:         FOR loc_i = 1 TO THIS.ControlCount
500:             loc_oControl = THIS.Controls(loc_i)
501:             IF VARTYPE(loc_oControl) = "O"
502:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
503:                     loc_oControl.Visible = .T.
504:                 ENDIF
505:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
506:                     THIS.RecursarControlesVisiveis(loc_oControl)
507:                 ENDIF
508:             ENDIF
509:         ENDFOR
510:     ENDPROC
511: 
512:     PROTECTED PROCEDURE RecursarControlesVisiveis(par_oContainer)
513:         LOCAL loc_i, loc_oControl
514:         FOR loc_i = 1 TO par_oContainer.ControlCount
515:             loc_oControl = par_oContainer.Controls(loc_i)
516:             IF VARTYPE(loc_oControl) = "O"
517:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
518:                     loc_oControl.Visible = .T.
519:                 ENDIF
520:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
521:                     THIS.RecursarControlesVisiveis(loc_oControl)
522:                 ENDIF
523:             ENDIF
524:         ENDFOR
525:     ENDPROC
526: 
527:     *==========================================================================
528:     * Handlers de eventos - PUBLIC (obrigatorio para BINDEVENT)
529:     *==========================================================================
530: 
531:     PROCEDURE BtnEmailClick()
532:         LOCAL loc_lOk
533:         loc_lOk = .F.
534: 
535:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
536:             loc_lOk = THIS.this_oBusinessObject.EnviarEmails()
537:         ENDIF
538: 
539:         IF loc_lOk
540:             THIS.Release()
541:         ENDIF
542:     ENDPROC
543: 
544:     PROCEDURE SelTudoClick()
545:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
546:             THIS.this_oBusinessObject.MarcarTodos()
547:         ENDIF
548:         THIS.grd_4c_Dados.Refresh()
549:     ENDPROC
550: 
551:     PROCEDURE ApagaClick()
552:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
553:             THIS.this_oBusinessObject.DesmarcarTodos()
554:         ENDIF
555:         THIS.grd_4c_Dados.Refresh()
556:     ENDPROC
557: 
558:     PROCEDURE EncerrarClick()
559:         THIS.Release()
560:     ENDPROC
561: 
562:     PROCEDURE Col2HeaderClick()
563:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
564:             THIS.this_oBusinessObject.OrdenarPorColuna("Contas")
565:         ENDIF
566:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
567:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
568:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
569:         THIS.grd_4c_Dados.Refresh()
570:     ENDPROC
571: 
572:     PROCEDURE Col3HeaderClick()
573:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
574:             THIS.this_oBusinessObject.OrdenarPorColuna("Rclis")
575:         ENDIF
576:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
577:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
578:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
579:         THIS.grd_4c_Dados.Refresh()
580:     ENDPROC
581: 
582:     PROCEDURE Col4HeaderClick()
583:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
584:             THIS.this_oBusinessObject.OrdenarPorColuna("Emails")
585:         ENDIF
586:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
587:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
588:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
589:         THIS.grd_4c_Dados.Refresh()
590:     ENDPROC
591: 
592:     PROCEDURE GrdChkInteractiveChange()
593:         LOCAL loc_nValue
594:         IF USED("cursor_4c_Total")
595:             loc_nValue = THIS.grd_4c_Dados.Column1.ctlCheckbox.Value
596:             REPLACE Checks WITH loc_nValue IN cursor_4c_Total
597:         ENDIF
598:         THIS.grd_4c_Dados.Refresh()
599:     ENDPROC
600: 
601:     *==========================================================================
602:     * Eventos CRUD - Contrato arquitetural do pipeline (Fase 7)
603:     *--------------------------------------------------------------------------
604:     * SIGPREML eh form OPERACIONAL de envio de alertas por email; nao ha
605:     * botoes CRUD (Incluir/Alterar/Excluir/Visualizar) na tela original. Os
606:     * handlers abaixo existem para atender o contrato de validacao do
607:     * pipeline e delegam para as acoes operacionais reais deste form. O
608:     * parametro cEscolha ("INSERIR"/"ALTERAR"/"EXCLUIR") recebido no Init
609:     * descreve o contexto que originou o alerta, nao gera botoes locais.
610:     *==========================================================================
611: 
612:     *--------------------------------------------------------------------------
613:     * BtnIncluirClick - Contexto INSERIR do alerta -> disparar envio de email
614:     *--------------------------------------------------------------------------
615:     PROCEDURE BtnIncluirClick()
616:         THIS.this_cEscolha = "INSERIR"
617:         THIS.BtnEmailClick()
618:     ENDPROC
619: 
620:     *--------------------------------------------------------------------------
621:     * BtnAlterarClick - Contexto ALTERAR do alerta -> disparar envio de email
622:     *--------------------------------------------------------------------------
623:     PROCEDURE BtnAlterarClick()
624:         THIS.this_cEscolha = "ALTERAR"
625:         THIS.BtnEmailClick()
626:     ENDPROC
627: 
628:     *--------------------------------------------------------------------------
629:     * BtnVisualizarClick - Reforca visualizacao da lista de destinatarios
630:     * carregada pelo BO (grid de emails/Rclis/Contas) sem enviar nada.
631:     *--------------------------------------------------------------------------
632:     PROCEDURE BtnVisualizarClick()
633:         IF USED("cursor_4c_Total")
634:             SELECT cursor_4c_Total
635:             GO TOP
636:         ENDIF
637:         THIS.grd_4c_Dados.SetFocus()
638:         THIS.grd_4c_Dados.Refresh()
639:     ENDPROC
640: 
641:     *--------------------------------------------------------------------------
642:     * BtnExcluirClick - Contexto EXCLUIR do alerta: no fluxo operacional
643:     * equivale a limpar selecao (desmarcar destinatarios) via BO.
644:     *--------------------------------------------------------------------------
645:     PROCEDURE BtnExcluirClick()
646:         THIS.this_cEscolha = "EXCLUIR"
647:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
648:             THIS.this_oBusinessObject.DesmarcarTodos()
649:         ENDIF
650:         THIS.grd_4c_Dados.Refresh()
651:     ENDPROC
652: 
653:     *==========================================================================
654:     * BtnBuscarClick - Form OPERACIONAL: sem busca interativa
655:     *--------------------------------------------------------------------------
656:     * SIGPREML carrega destinatarios no Init via parametros recebidos.
657:     * "Buscar" equivale a reposicionar o grid no primeiro registro.
658:     *==========================================================================
659:     PROCEDURE BtnBuscarClick()
660:         IF USED("cursor_4c_Total")
661:             SELECT cursor_4c_Total
662:             GO TOP
663:         ENDIF
664:         THIS.grd_4c_Dados.Refresh()
665:     ENDPROC
666: 
667:     *==========================================================================
668:     * BtnEncerrarClick - Alias de EncerrarClick (contrato arquitetural pipeline)
669:     *==========================================================================
670:     PROCEDURE BtnEncerrarClick()
671:         THIS.EncerrarClick()
672:     ENDPROC
673: 
674:     *==========================================================================
675:     * BtnSalvarClick - Form OPERACIONAL: "salvar" = enviar email
676:     *--------------------------------------------------------------------------
677:     * Nao ha operacao de salvar no sentido CRUD. O equivalente operacional
678:     * e o envio dos emails (BtnEmailClick), que registra o alerta em SigAlert
679:     * e fecha o form.
680:     *==========================================================================
681:     PROCEDURE BtnSalvarClick()
682:         THIS.BtnEmailClick()
683:     ENDPROC
684: 
685:     *==========================================================================
686:     * BtnCancelarClick - Cancela sem enviar email e fecha o form
687:     *==========================================================================
688:     PROCEDURE BtnCancelarClick()
689:         THIS.EncerrarClick()
690:     ENDPROC
691: 
692:     *==========================================================================
693:     * FormParaBO - Form OPERACIONAL: sem campos de edicao a mapear
694:     *--------------------------------------------------------------------------
695:     * Os parametros de operacao (EmpDopNums, Escolha) foram passados no Init
696:     * e estao em propriedades do form e do BO. Retorna .T. sem efeito.
697:     *==========================================================================
698:     PROCEDURE FormParaBO()
699:         RETURN .T.
700:     ENDPROC
701: 
702:     *==========================================================================
703:     * BOParaForm - Form OPERACIONAL: sem campos de formulario a preencher
704:     *--------------------------------------------------------------------------
705:     * Os dados de exibicao estao no cursor_4c_Total que alimenta o grid.
706:     * Nao ha TextBoxes/Labels a preencher a partir das propriedades do BO.
707:     *==========================================================================
708:     PROCEDURE BOParaForm()
709:         RETURN .T.
710:     ENDPROC
711: 
712:     *==========================================================================
713:     * HabilitarCampos - Habilita/desabilita controles conforme contexto
714:     *--------------------------------------------------------------------------
715:     * Form OPERACIONAL: habilita o botao de envio de email apenas se ha
716:     * ao menos um destinatario carregado no grid.
717:     *==========================================================================
718:     PROCEDURE HabilitarCampos(par_lHabilitar)
719:         LOCAL loc_lTemDados
720: 
721:         loc_lTemDados = USED("cursor_4c_Total") AND RECCOUNT("cursor_4c_Total") > 0
722: 
723:         IF PEMSTATUS(THIS, "cmd_4c_BtnEmail", 5)
724:             THIS.cmd_4c_BtnEmail.Enabled = loc_lTemDados
725:         ENDIF
726:     ENDPROC
727: 
728:     *==========================================================================
729:     * LimparCampos - Form OPERACIONAL: desmarca todos os destinatarios
730:     *--------------------------------------------------------------------------
731:     * Equivale ao botao "Desmarcar Todos". Mantem semantica de "limpar
732:     * selecao atual" sem fechar o form.
733:     *==========================================================================
734:     PROCEDURE LimparCampos()
735:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
736:             THIS.this_oBusinessObject.DesmarcarTodos()
737:         ENDIF
738:         THIS.grd_4c_Dados.Refresh()
739:     ENDPROC
740: 
741:     *==========================================================================
742:     * CarregarLista - Reposiciona e atualiza exibicao do grid de destinatarios
743:     *--------------------------------------------------------------------------
744:     * Form OPERACIONAL: o cursor_4c_Total ja esta populado pelo CarregarDados
745:     * do BO chamado no InicializarForm. CarregarLista reposiciona o ponteiro
746:     * e atualiza o grid sem re-executar SQL.
747:     *==========================================================================
748:     PROCEDURE CarregarLista()
749:         LOCAL loc_lSucesso, loc_oErro
750: 
751:         loc_lSucesso = .F.
752: 
753:         TRY
754:             IF USED("cursor_4c_Total")
755:                 SELECT cursor_4c_Total
756:                 GO TOP
757:                 THIS.grd_4c_Dados.Refresh()
758:                 loc_lSucesso = .T.
759:             ENDIF
760:         CATCH TO loc_oErro
761:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
762:                     "Erro FormSigPrEml.CarregarLista")
763:         ENDTRY
764: 
765:         RETURN loc_lSucesso
766:     ENDPROC
767: 
768:     *==========================================================================
769:     * AjustarBotoesPorModo - Form OPERACIONAL: sem modos CRUD a ajustar
770:     *--------------------------------------------------------------------------
771:     * SIGPREML tem um unico modo de operacao: exibir destinatarios e enviar
772:     * email. Nao ha alternancia de modos (LISTA/DADOS/INCLUIR/ALTERAR/
773:     * VISUALIZAR). Metodo mantido para contrato arquitetural do pipeline.
774:     *==========================================================================
775:     PROCEDURE AjustarBotoesPorModo()
776:         RETURN
777:     ENDPROC
778: 
779:     *==========================================================================
780:     PROCEDURE Destroy
781:     *==========================================================================
782:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
783:             THIS.this_oBusinessObject.EncerrarConexaoAlerta()
784:             THIS.this_oBusinessObject = .NULL.
785:         ENDIF
786:         DODEFAULT()
787:     ENDPROC
788: 
789: ENDDEFINE

