# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdAco.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1170 linhas total):

*-- Linhas 6 a 153:
6: *   CRUD-equivalents: BtnIncluirClick, BtnAlterarClick, BtnVisualizarClick,
7: *                     BtnExcluirClick (delegacao para operacoes do relatorio)
8: *   Operacionais: BtnProcessarClick, BtnCmdRpviewClick, BtnCmdRpPrintClick,
9: *                 BtnCmdGprocessaClick, ArquivosInteractiveChange, Activate
10: *   Auxiliares: BtnBuscarClick, BtnEncerrarClick, BtnSalvarClick,
11: *               BtnCancelarClick, CarregarLista, AjustarBotoesPorModo,
12: *               HabilitarCampos, LimparCampos, FormParaBO, BOParaForm
13: *============================================================================
14: 
15: DEFINE CLASS FormSigPdAco AS FormBase
16: 
17:     *-- Layout pixel-perfect do legado SIGPDACO
18:     Width            = 800
19:     Height           = 600
20:     AutoCenter       = .T.
21:     BorderStyle      = 2
22:     TitleBar         = 0
23:     ControlBox       = .F.
24:     Closable         = .F.
25:     MaxButton        = .F.
26:     MinButton        = .F.
27:     Movable          = .F.
28:     WindowType       = 1
29:     ShowWindow       = 1
30:     DataSession      = 2
31:     Themes           = .F.
32:     KeyPreview       = .T.
33:     ClipControls     = .F.
34:     ZoomBox          = .F.
35:     ContinuousScroll = .F.
36:     Caption          = "Acompanhamento de Material por Grupo"
37: 
38:     *-- Estado do form
39:     this_oBusinessObject = .NULL.
40:     this_lProcessamento  = .F.
41: 
42:     *==========================================================================
43:     * Init
44:     *==========================================================================
45:     PROCEDURE Init()
46:         RETURN DODEFAULT()
47:     ENDPROC
48: 
49:     *==========================================================================
50:     * InicializarForm - Constroi o form: BO + cursores base + containers
51:     *==========================================================================
52:     PROTECTED PROCEDURE InicializarForm()
53:         LOCAL loc_lSucesso, loc_oErro
54:         loc_lSucesso = .F.
55: 
56:         TRY
57:             THIS.this_oBusinessObject = CREATEOBJECT("SigPdAcoBO")
58:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
59:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
60: 
61:                 *-- Configura aparencia base do form (OPERACIONAL sem PageFrame)
62:                 THIS.ConfigurarPageFrame()
63: 
64:                 *-- Cria cursores locais csRel + csCab (sem SQL, sempre executar)
65:                 THIS.this_oBusinessObject.CriarCursorRelatorio()
66: 
67:                 *-- Carrega parametros operacionais de SigCdPam (requer SQL)
68:                 IF TYPE("gb_4c_ValidandoUI") != "L" .OR. !gb_4c_ValidandoUI
69:                     THIS.this_oBusinessObject.CarregarParametros()
70:                 ENDIF
71: 
72:                 THIS.ConfigurarCabecalho()
73:                 THIS.ConfigurarPaginaLista()
74:                 THIS.ConfigurarPaginaDados()
75:                 THIS.ConfigurarAguarde()
76: 
77:                 THIS.TornarControlesVisiveis(THIS)
78: 
79:                 loc_lSucesso = .T.
80:             ELSE
81:                 MsgErro("Erro ao criar SigPdAcoBO.", "Erro")
82:             ENDIF
83:         CATCH TO loc_oErro
84:             MsgErro(loc_oErro.Message, "Erro")
85:         ENDTRY
86: 
87:         RETURN loc_lSucesso
88:     ENDPROC
89: 
90:     *==========================================================================
91:     * ConfigurarPageFrame - Aparencia base do form (OPERACIONAL sem PageFrame)
92:     * Forms OPERACIONAIS nao tem PageFrame Page1/Page2 como CRUD.
93:     * Este metodo apenas define propriedades visuais globais do form.
94:     *==========================================================================
95:     PROTECTED PROCEDURE ConfigurarPageFrame()
96:         THIS.BackColor  = RGB(212, 208, 200)
97:         THIS.ScrollBars = 0
98:         THIS.ShowTips   = .T.
99:         THIS.SetAll("FontName", "Tahoma")
100:         THIS.SetAll("FontSize", 8)
101:     ENDPROC
102: 
103:     *==========================================================================
104:     * AlternarPagina - Form OPERACIONAL plano: sem alternancia de paginas
105:     *==========================================================================
106:     PROCEDURE AlternarPagina(par_nPagina)
107:         RETURN
108:     ENDPROC
109: 
110:     *==========================================================================
111:     * ConfigurarCabecalho - Container escuro com titulo (equivale a cntSombra)
112:     *==========================================================================
113:     PROTECTED PROCEDURE ConfigurarCabecalho()
114:         LOCAL loc_oCnt
115:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
116:         loc_oCnt = THIS.cnt_4c_Cabecalho
117:         WITH loc_oCnt
118:             .Top         = 0
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackStyle   = 1
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127: 
128:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
129:         WITH loc_oCnt.lbl_4c_LblSombra
130:             .Top       = 18
131:             .Left      = 10
132:             .Width     = 769
133:             .Height    = 40
134:             .FontBold  = .T.
135:             .FontName  = "Tahoma"
136:             .FontSize  = 18
137:             .WordWrap  = .T.
138:             .Alignment = 0
139:             .BackStyle = 0
140:             .Caption   = "Acompanhamento de Material por Grupo"
141:             .ForeColor = RGB(0, 0, 0)
142:             .Visible   = .T.
143:         ENDWITH
144: 
145:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
146:         WITH loc_oCnt.lbl_4c_LblTitulo
147:             .Top       = 17
148:             .Left      = 10
149:             .Width     = 769
150:             .Height    = 46
151:             .FontBold  = .T.
152:             .FontName  = "Tahoma"
153:             .FontSize  = 18

*-- Linhas 163 a 426:
163:     *==========================================================================
164:     * ConfigurarAguarde - Container de espera (Visible=.F., toggled por Processar)
165:     *==========================================================================
166:     PROTECTED PROCEDURE ConfigurarAguarde()
167:         LOCAL loc_oCnt
168:         THIS.AddObject("cnt_4c_Aguarde", "Container")
169:         loc_oCnt = THIS.cnt_4c_Aguarde
170:         WITH loc_oCnt
171:             .Top           = 287
172:             .Left          = 117
173:             .Width         = 516
174:             .Height        = 139
175:             .SpecialEffect = 0
176:             .Visible       = .F.
177:         ENDWITH
178: 
179:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
180:         WITH loc_oCnt.lbl_4c_Label1
181:             .Top       = 28
182:             .Left      = 206
183:             .Width     = 105
184:             .Height    = 29
185:             .FontBold  = .T.
186:             .FontSize  = 14
187:             .Caption   = "Aguarde..."
188:             .ForeColor = RGB(255, 0, 0)
189:         ENDWITH
190: 
191:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
192:         WITH loc_oCnt.lbl_4c_Label2
193:             .Top       = 79
194:             .Left      = 135
195:             .Width     = 242
196:             .Height    = 27
197:             .FontBold  = .T.
198:             .FontSize  = 14
199:             .Caption   = "Processando Dados ......"
200:             .ForeColor = RGB(0, 0, 160)
201:         ENDWITH
202:     ENDPROC
203: 
204:     *==========================================================================
205:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
206:     *   EXCETO containers/controles com Visible=.F. intencional
207:     *==========================================================================
208:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
209:         LOCAL loc_i, loc_oControl
210: 
211:         FOR loc_i = 1 TO par_oContainer.ControlCount
212:             loc_oControl = par_oContainer.Controls(loc_i)
213: 
214:             IF VARTYPE(loc_oControl) = "O"
215:                 *-- Controles que devem permanecer ocultos ate acao do usuario
216:                 IF INLIST(UPPER(loc_oControl.Name), ;
217:                           "CNT_4C_AGUARDE",    ;
218:                           "CNT_4C_CABECALHO",  ;
219:                           "SHP_4C_SHPRP",      ;
220:                           "CMD_4C_CMDRPVIEW",  ;
221:                           "CMD_4C_CMDRPPRINT")
222:                     LOOP
223:                 ENDIF
224: 
225:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
226:                     loc_oControl.Visible = .T.
227:                 ENDIF
228: 
229:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) .AND. ;
230:                    loc_oControl.ControlCount > 0
231:                     THIS.TornarControlesVisiveis(loc_oControl)
232:                 ENDIF
233:             ENDIF
234:         ENDFOR
235:     ENDPROC
236: 
237:     *==========================================================================
238:     * Activate - Processa dados na primeira ativacao do form
239:     *==========================================================================
240:     PROCEDURE Activate()
241:         DODEFAULT()
242:         IF !THIS.this_lProcessamento
243:             THIS.BtnProcessarClick()
244:         ENDIF
245:     ENDPROC
246: 
247:     *==========================================================================
248:     * ConfigurarPaginaLista - Configura layout operacional: grid + botoes + filtros
249:     *==========================================================================
250:     PROTECTED PROCEDURE ConfigurarPaginaLista()
251:         LOCAL loc_oGrd
252: 
253:         *-- Shape de fundo para area de botoes de relatorio (oculto ate processar)
254:         THIS.AddObject("shp_4c_ShpRp", "Shape")
255:         WITH THIS.shp_4c_ShpRp
256:             .Top         = 7
257:             .Left        = 552
258:             .Width       = 229
259:             .Height      = 110
260:             .BackStyle   = 0
261:             .BorderColor = RGB(136, 189, 188)
262:             .Visible     = .F.
263:         ENDWITH
264: 
265:         *-- Botao Processar (sempre visivel apos TornarControlesVisiveis)
266:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
267:         WITH THIS.cmd_4c_Processar
268:             .Top             = 3
269:             .Left            = 500
270:             .Width           = 75
271:             .Height          = 75
272:             .Caption         = "Processar"
273:             .FontName        = "Tahoma"
274:             .FontBold        = .T.
275:             .FontItalic      = .T.
276:             .FontSize        = 8
277:             .ForeColor       = RGB(90, 90, 90)
278:             .BackColor       = RGB(255, 255, 255)
279:             .Themes          = .F.
280:             .SpecialEffect   = 0
281:             .PicturePosition = 13
282:             .MousePointer    = 15
283:             .WordWrap        = .T.
284:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
285:         ENDWITH
286:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
287: 
288:         *-- Botao Visualizar relatorio em tela (oculto ate processar)
289:         THIS.AddObject("cmd_4c_CmdRpview", "CommandButton")
290:         WITH THIS.cmd_4c_CmdRpview
291:             .Top             = 3
292:             .Left            = 650
293:             .Width           = 75
294:             .Height          = 75
295:             .Caption         = "V" + CHR(237) + "deo"
296:             .FontName        = "Tahoma"
297:             .FontBold        = .T.
298:             .FontItalic      = .T.
299:             .FontSize        = 8
300:             .ForeColor       = RGB(90, 90, 90)
301:             .BackColor       = RGB(255, 255, 255)
302:             .Themes          = .F.
303:             .SpecialEffect   = 0
304:             .PicturePosition = 13
305:             .MousePointer    = 15
306:             .WordWrap        = .T.
307:             .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
308:             .Visible         = .F.
309:         ENDWITH
310:         BINDEVENT(THIS.cmd_4c_CmdRpview, "Click", THIS, "BtnCmdRpviewClick")
311: 
312:         *-- Botao Imprimir relatorio (oculto ate processar)
313:         THIS.AddObject("cmd_4c_CmdRpPrint", "CommandButton")
314:         WITH THIS.cmd_4c_CmdRpPrint
315:             .Top             = 3
316:             .Left            = 575
317:             .Width           = 75
318:             .Height          = 75
319:             .Caption         = "Impressora"
320:             .FontName        = "Tahoma"
321:             .FontBold        = .T.
322:             .FontItalic      = .T.
323:             .FontSize        = 8
324:             .ForeColor       = RGB(90, 90, 90)
325:             .BackColor       = RGB(255, 255, 255)
326:             .Themes          = .F.
327:             .SpecialEffect   = 0
328:             .PicturePosition = 13
329:             .MousePointer    = 15
330:             .WordWrap        = .T.
331:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
332:             .Visible         = .F.
333:         ENDWITH
334:         BINDEVENT(THIS.cmd_4c_CmdRpPrint, "Click", THIS, "BtnCmdRpPrintClick")
335: 
336:         *-- CommandGroup de saida equivalente a Encerrar (posicao top-right no form 800px)
337:         THIS.AddObject("obj_4c_CmdGprocessa", "CommandGroup")
338:         WITH THIS.obj_4c_CmdGprocessa
339:             .Top           = -2
340:             .Left          = 720
341:             .Width         = 85
342:             .Height        = 85
343:             .ButtonCount   = 1
344:             .BackStyle     = 0
345:             .BorderStyle   = 0
346:             .Themes        = .F.
347:             .AutoSize      = .T.
348:             .SpecialEffect = 1
349:             .BorderColor   = RGB(136, 189, 188)
350:         ENDWITH
351:         WITH THIS.obj_4c_CmdGprocessa.Buttons(1)
352:             .Left            = 5
353:             .Top             = 5
354:             .Width           = 75
355:             .Height          = 75
356:             .Caption         = "Encerrar"
357:             .FontName        = "Tahoma"
358:             .FontBold        = .T.
359:             .FontItalic      = .T.
360:             .FontSize        = 8
361:             .ForeColor       = RGB(90, 90, 90)
362:             .BackColor       = RGB(255, 255, 255)
363:             .Themes          = .F.
364:             .SpecialEffect   = 0
365:             .PicturePosition = 13
366:             .MousePointer    = 15
367:             .WordWrap        = .T.
368:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
369:         ENDWITH
370:         BINDEVENT(THIS.obj_4c_CmdGprocessa, "ButtonClick", THIS, "BtnCmdGprocessaClick")
371: 
372:         *-- Listbox de grupos para filtro (Arquivos no legado)
373:         THIS.AddObject("obj_4c_Arquivos", "ListBox")
374:         WITH THIS.obj_4c_Arquivos
375:             .Top           = 122
376:             .Left          = 84
377:             .Width         = 169
378:             .Height        = 79
379:             .FontName      = "Tahoma"
380:             .FontSize      = 8
381:             .ForeColor     = RGB(90, 90, 90)
382:             .BackColor     = RGB(255, 255, 255)
383:             .RowSourceType = 1
384:             .Sorted        = .T.
385:         ENDWITH
386:         BINDEVENT(THIS.obj_4c_Arquivos, "InteractiveChange", THIS, "ArquivosInteractiveChange")
387: 
388:         *-- Label "Grupos :" (Label7 no legado)
389:         THIS.AddObject("lbl_4c_Label7", "Label")
390:         WITH THIS.lbl_4c_Label7
391:             .Top       = 124
392:             .Left      = 34
393:             .Width     = 48
394:             .Height    = 15
395:             .Caption   = "Grupos :"
396:             .FontName  = "Tahoma"
397:             .FontSize  = 8
398:             .ForeColor = RGB(90, 90, 90)
399:             .BackStyle = 0
400:         ENDWITH
401: 
402:         *-- Grid principal (GrdF no legado) - 10 colunas mapeadas para csRel
403:         THIS.AddObject("grd_4c_Dados", "Grid")
404:         loc_oGrd = THIS.grd_4c_Dados
405:         WITH loc_oGrd
406:             .Top                = 205
407:             .Left               = 34
408:             .Width              = 732
409:             .Height             = 272
410:             .ColumnCount        = 10
411:             .FontName           = "Verdana"
412:             .FontSize           = 8
413:             .ForeColor          = RGB(90, 90, 90)
414:             .BackColor          = RGB(255, 255, 255)
415:             .GridLineColor      = RGB(238, 238, 238)
416:             .HighlightBackColor = RGB(255, 255, 255)
417:             .HighlightForeColor = RGB(15, 41, 104)
418:             .HighlightStyle     = 2
419:             .DeleteMark         = .F.
420:             .RecordMark         = .F.
421:             .RowHeight          = 16
422:             .ScrollBars         = 2
423:             .RecordSource       = "csRel"
424:             .RecordSourceType   = 1
425:         ENDWITH
426: 

*-- Linhas 486 a 764:
486:     *   Form OPERACIONAL nao tem Page2/Dados como CRUD. Este metodo agrupa
487:     *   os labels explicativos do calculo de Pos.Final exibidos abaixo do grid.
488:     *==========================================================================
489:     PROTECTED PROCEDURE ConfigurarPaginaDados()
490:         *-- Label3: formula de Pos.Final (rodape pixel-perfect do legado)
491:         THIS.AddObject("lbl_4c_Label3", "Label")
492:         WITH THIS.lbl_4c_Label3
493:             .Top       = 487
494:             .Left      = 117
495:             .Width     = 585
496:             .Height    = 15
497:             .Caption   = "( * ) Pos.Final = Saldo Atual + Requisi" + CHR(231) + CHR(227) + "o + " + ;
498:                          "Ped.Compra + Compra - Empenho - Qt.M" + CHR(237) + "nima"
499:             .FontName  = "Tahoma"
500:             .FontBold  = .T.
501:             .FontSize  = 8
502:             .ForeColor = RGB(90, 90, 90)
503:             .BackStyle = 0
504:         ENDWITH
505: 
506:         *-- Label4: nota sobre marcadores [*] (peso medio)
507:         THIS.AddObject("lbl_4c_Label4", "Label")
508:         WITH THIS.lbl_4c_Label4
509:             .Top       = 507
510:             .Left      = 118
511:             .Width     = 372
512:             .Height    = 15
513:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o = [ * ]   Calculado pelo Peso M" + CHR(233) + "dio do Material"
514:             .FontName  = "Tahoma"
515:             .FontBold  = .T.
516:             .FontSize  = 8
517:             .ForeColor = RGB(90, 90, 90)
518:             .BackStyle = 0
519:         ENDWITH
520:     ENDPROC
521: 
522:     *==========================================================================
523:     * BtnIncluirClick - Inicia novo processamento (gera relatorio do zero)
524:     *   Form OPERACIONAL: "Incluir" equivale a iniciar nova geracao de relatorio
525:     *   resetando o estado anterior e executando processamento completo.
526:     *==========================================================================
527:     PROCEDURE BtnIncluirClick()
528:         THIS.this_lProcessamento = .F.
529:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
530:             THIS.this_oBusinessObject.this_lProcessamento = .F.
531:         ENDIF
532:         THIS.shp_4c_ShpRp.Visible      = .F.
533:         THIS.cmd_4c_CmdRpview.Visible  = .F.
534:         THIS.cmd_4c_CmdRpPrint.Visible = .F.
535:         THIS.BtnProcessarClick()
536:     ENDPROC
537: 
538:     *==========================================================================
539:     * BtnAlterarClick - Atualiza dados do relatorio (re-processamento)
540:     *   Form OPERACIONAL: "Alterar" equivale a atualizar/re-processar os dados
541:     *   mantendo o estado de processamento ja realizado.
542:     *==========================================================================
543:     PROCEDURE BtnAlterarClick()
544:         IF !THIS.this_lProcessamento
545:             THIS.BtnProcessarClick()
546:         ELSE
547:             LOCAL loc_lSucesso, loc_oErro
548:             loc_lSucesso = .F.
549: 
550:             THIS.cnt_4c_Aguarde.Visible = .T.
551:             THIS.cnt_4c_Aguarde.ZOrder(0)
552:             THIS.Refresh
553: 
554:             TRY
555:                 loc_lSucesso = THIS.this_oBusinessObject.Atualizar(THIS.obj_4c_Arquivos)
556:             CATCH TO loc_oErro
557:                 MsgErro(loc_oErro.Message, "Erro")
558:             ENDTRY
559: 
560:             THIS.cnt_4c_Aguarde.Visible = .F.
561: 
562:             IF loc_lSucesso
563:                 IF THIS.obj_4c_Arquivos.ListCount > 0 .AND. ;
564:                    !EMPTY(THIS.obj_4c_Arquivos.Value)
565:                     THIS.ArquivosInteractiveChange()
566:                 ENDIF
567:                 THIS.grd_4c_Dados.Refresh
568:             ENDIF
569:         ENDIF
570:     ENDPROC
571: 
572:     *==========================================================================
573:     * BtnVisualizarClick - Visualiza o relatorio em tela
574:     *   Form OPERACIONAL: "Visualizar" equivale ao preview do relatorio gerado.
575:     *   Exige que o processamento ja tenha sido executado.
576:     *==========================================================================
577:     PROCEDURE BtnVisualizarClick()
578:         IF !THIS.this_lProcessamento .OR. !USED("csRel") .OR. RECCOUNT("csRel") = 0
579:             MsgAviso("Execute o processamento antes de visualizar o relat" + CHR(243) + "rio.", "Aviso")
580:             RETURN
581:         ENDIF
582:         THIS.BtnCmdRpviewClick()
583:     ENDPROC
584: 
585:     *==========================================================================
586:     * BtnExcluirClick - Limpa dados do relatorio (reset)
587:     *   Form OPERACIONAL: "Excluir" equivale a limpar o cursor csRel e resetar
588:     *   o estado de processamento, ocultando botoes de visualizacao/impressao.
589:     *==========================================================================
590:     PROCEDURE BtnExcluirClick()
591:         IF !MsgConfirma("Deseja realmente limpar os dados do relat" + CHR(243) + "rio?", "Confirma" + CHR(231) + CHR(227) + "o")
592:             RETURN
593:         ENDIF
594: 
595:         IF USED("csRel")
596:             SELECT csRel
597:             ZAP
598:         ENDIF
599: 
600:         THIS.this_lProcessamento = .F.
601:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
602:             THIS.this_oBusinessObject.this_lProcessamento = .F.
603:         ENDIF
604: 
605:         THIS.shp_4c_ShpRp.Visible      = .F.
606:         THIS.cmd_4c_CmdRpview.Visible  = .F.
607:         THIS.cmd_4c_CmdRpPrint.Visible = .F.
608:         THIS.grd_4c_Dados.Refresh
609:     ENDPROC
610: 
611:     *==========================================================================
612:     * BtnProcessarClick - Processa dados e popula grid
613:     *==========================================================================
614:     PROCEDURE BtnProcessarClick()
615:         LOCAL loc_lSucesso, loc_oErro
616:         loc_lSucesso = .F.
617: 
618:         THIS.cnt_4c_Aguarde.Visible = .T.
619:         THIS.cnt_4c_Aguarde.ZOrder(0)
620:         THIS.Refresh
621: 
622:         TRY
623:             IF THIS.this_lProcessamento
624:                 loc_lSucesso = THIS.this_oBusinessObject.Atualizar(THIS.obj_4c_Arquivos)
625:             ELSE
626:                 loc_lSucesso = THIS.this_oBusinessObject.Inserir(THIS.obj_4c_Arquivos)
627:             ENDIF
628:         CATCH TO loc_oErro
629:             MsgErro(loc_oErro.Message, "Erro")
630:         ENDTRY
631: 
632:         THIS.cnt_4c_Aguarde.Visible = .F.
633: 
634:         IF loc_lSucesso
635:             THIS.this_lProcessamento = .T.
636: 
637:             IF USED("csRel") .AND. RECCOUNT("csRel") > 0
638:                 *-- Seleciona primeiro grupo da lista e filtra o grid (padrao original)
639:                 IF THIS.obj_4c_Arquivos.ListCount > 0
640:                     THIS.obj_4c_Arquivos.ListIndex = 1
641:                     THIS.ArquivosInteractiveChange()
642:                 ENDIF
643:                 THIS.grd_4c_Dados.Refresh
644:                 THIS.shp_4c_ShpRp.Visible     = .T.
645:                 THIS.cmd_4c_CmdRpview.Visible  = .T.
646:                 THIS.cmd_4c_CmdRpPrint.Visible = .T.
647:                 THIS.obj_4c_Arquivos.SetFocus
648:             ELSE
649:                 MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + "o!!!", "Aviso")
650:             ENDIF
651:         ENDIF
652:     ENDPROC
653: 
654:     *==========================================================================
655:     * BtnCmdRpviewClick - Exibe relatorio em tela (Preview)
656:     *==========================================================================
657:     PROCEDURE BtnCmdRpviewClick()
658:         LOCAL loc_cSub, loc_cRelatorio
659:         loc_cSub       = ""
660:         loc_cRelatorio = gc_4c_CaminhoReports + "RelSigPdAco.frx"
661: 
662:         IF !EMPTY(THIS.obj_4c_Arquivos.Value)
663:             loc_cSub = ALLTRIM(THIS.obj_4c_Arquivos.Value)
664:         ENDIF
665: 
666:         THIS.this_oBusinessObject.AtualizarCabecalhoRelatorio(loc_cSub)
667: 
668:         IF FILE(loc_cRelatorio)
669:             REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
670:         ELSE
671:             MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cRelatorio, ;
672:                      "Relat" + CHR(243) + "rio")
673:         ENDIF
674:     ENDPROC
675: 
676:     *==========================================================================
677:     * BtnCmdRpPrintClick - Imprime relatorio na impressora
678:     *==========================================================================
679:     PROCEDURE BtnCmdRpPrintClick()
680:         LOCAL loc_cSub, loc_cRelatorio
681:         loc_cSub       = ""
682:         loc_cRelatorio = gc_4c_CaminhoReports + "RelSigPdAco.frx"
683: 
684:         IF !EMPTY(THIS.obj_4c_Arquivos.Value)
685:             loc_cSub = ALLTRIM(THIS.obj_4c_Arquivos.Value)
686:         ENDIF
687: 
688:         THIS.this_oBusinessObject.AtualizarCabecalhoRelatorio(loc_cSub)
689: 
690:         IF FILE(loc_cRelatorio)
691:             REPORT FORM (loc_cRelatorio) TO PRINTER PROMPT NOCONSOLE
692:         ELSE
693:             MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cRelatorio, ;
694:                      "Relat" + CHR(243) + "rio")
695:         ENDIF
696:     ENDPROC
697: 
698:     *==========================================================================
699:     * BtnCmdGprocessaClick - Encerra o formulario
700:     *   par_nButton: indice do botao clicado no CommandGroup (sempre 1)
701:     *==========================================================================
702:     PROCEDURE BtnCmdGprocessaClick(par_nButton)
703:         THIS.Release()
704:     ENDPROC
705: 
706:     *==========================================================================
707:     * ArquivosInteractiveChange - Filtra grid pelo grupo selecionado no listbox
708:     *==========================================================================
709:     PROCEDURE ArquivosInteractiveChange()
710:         LOCAL loc_cGrupo
711: 
712:         IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
713:            !EMPTY(THIS.obj_4c_Arquivos.Value)
714:             loc_cGrupo = ALLTRIM(LEFT(THIS.obj_4c_Arquivos.Value, 3))
715:             THIS.this_oBusinessObject.FiltrarPorGrupo(loc_cGrupo)
716:             THIS.grd_4c_Dados.Refresh
717:         ENDIF
718:     ENDPROC
719: 
720:     *==========================================================================
721:     * ConfigurarGrdDados - Propriedades visuais pixel-perfect das colunas do grid
722:     *   BackColor por coluna, ReadOnly/Movable/Resizable, Text1 props, DynamicForeColor
723:     *==========================================================================
724:     PROTECTED PROCEDURE ConfigurarGrdDados(par_oGrd)
725:         LOCAL loc_oGrd
726:         loc_oGrd = par_oGrd
727: 
728:         *-- Coluna 1: Material (laranja - destaque)
729:         WITH loc_oGrd.Column1
730:             .BackColor  = RGB(255, 197, 138)
731:             .ReadOnly   = .T.
732:             .Movable    = .F.
733:             .Resizable  = .F.
734:             .FontName   = "Tahoma"
735:             .FontSize   = 8
736:             .Header1.Alignment = 2
737:             .Header1.FontName  = "Tahoma"
738:             .Header1.FontSize  = 8
739:             .Header1.ForeColor = RGB(0, 0, 0)
740:             .Text1.BackColor   = RGB(255, 197, 138)
741:             .Text1.ForeColor   = RGB(0, 0, 0)
742:             .Text1.BorderStyle = 0
743:             .Text1.Margin      = 0
744:             .Text1.ReadOnly    = .T.
745:             .Text1.FontName    = "Tahoma"
746:             .Text1.FontSize    = 8
747:         ENDWITH
748: 
749:         *-- Coluna 2: Descricao (branco)
750:         WITH loc_oGrd.Column2
751:             .BackColor  = RGB(255, 255, 255)
752:             .ReadOnly   = .T.
753:             .Movable    = .F.
754:             .Resizable  = .F.
755:             .FontName   = "Tahoma"
756:             .FontSize   = 8
757:             .Header1.Alignment = 2
758:             .Header1.FontName  = "Tahoma"
759:             .Header1.FontSize  = 8
760:             .Header1.ForeColor = RGB(0, 0, 0)
761:             .Text1.BackColor   = RGB(255, 255, 255)
762:             .Text1.ForeColor   = RGB(0, 0, 0)
763:             .Text1.BorderStyle = 0
764:             .Text1.Margin      = 0

*-- Linhas 942 a 1170:
942:     *==========================================================================
943:     * Destroy - Libera BO e cursores do form
944:     *==========================================================================
945:     PROCEDURE Destroy()
946:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
947:             THIS.this_oBusinessObject = .NULL.
948:         ENDIF
949: 
950:         LOCAL loc_aCursores(3), loc_i
951:         loc_aCursores(1) = "csRel"
952:         loc_aCursores(2) = "csCab"
953:         loc_aCursores(3) = "dbCabecalho"
954: 
955:         FOR loc_i = 1 TO 3
956:             IF USED(loc_aCursores(loc_i))
957:                 USE IN (loc_aCursores(loc_i))
958:             ENDIF
959:         ENDFOR
960: 
961:         DODEFAULT()
962:     ENDPROC
963: 
964:     *==========================================================================
965:     * BtnBuscarClick - Aciona processamento ou re-filtro do grid
966:     *   Form OPERACIONAL: se ainda nao processado, executa BtnProcessarClick.
967:     *   Se ja processado, re-aplica o filtro do grupo selecionado no listbox.
968:     *==========================================================================
969:     PROCEDURE BtnBuscarClick()
970:         IF !THIS.this_lProcessamento
971:             THIS.BtnProcessarClick()
972:         ELSE
973:             THIS.ArquivosInteractiveChange()
974:             THIS.grd_4c_Dados.Refresh
975:         ENDIF
976:     ENDPROC
977: 
978:     *==========================================================================
979:     * BtnEncerrarClick - Encerra o formulario
980:     *==========================================================================
981:     PROCEDURE BtnEncerrarClick()
982:         THIS.Release()
983:     ENDPROC
984: 
985:     *==========================================================================
986:     * BtnSalvarClick - Atualiza cabecalho do relatorio com grupo selecionado
987:     *   Form OPERACIONAL: nao ha registros editaveis para persistir no banco.
988:     *   Transfere o grupo ativo como subtitulo para o cursor csCab do relatorio.
989:     *==========================================================================
990:     PROCEDURE BtnSalvarClick()
991:         LOCAL loc_cSub
992:         loc_cSub = ""
993: 
994:         IF THIS.this_lProcessamento .AND. VARTYPE(THIS.this_oBusinessObject) = "O"
995:             IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
996:                !EMPTY(THIS.obj_4c_Arquivos.Value)
997:                 loc_cSub = ALLTRIM(THIS.obj_4c_Arquivos.Value)
998:             ENDIF
999:             THIS.this_oBusinessObject.AtualizarCabecalhoRelatorio(loc_cSub)
1000:         ENDIF
1001:     ENDPROC
1002: 
1003:     *==========================================================================
1004:     * BtnCancelarClick - Cancela processamento atual e reseta o form
1005:     *   Form OPERACIONAL: limpa o cursor csRel, o listbox de grupos e reseta
1006:     *   o flag de processamento para permitir novo ciclo.
1007:     *==========================================================================
1008:     PROCEDURE BtnCancelarClick()
1009:         IF THIS.this_lProcessamento
1010:             IF !MsgConfirma("Deseja cancelar o processamento atual?", ;
1011:                             "Confirma" + CHR(231) + CHR(227) + "o")
1012:                 RETURN
1013:             ENDIF
1014:         ENDIF
1015: 
1016:         THIS.LimparCampos()
1017:     ENDPROC
1018: 
1019:     *==========================================================================
1020:     * CarregarLista - Atualiza exibicao do grid com dados do cursor csRel
1021:     *   Form OPERACIONAL: nao executa SQL. Aplica filtro de grupo ativo se
1022:     *   houver um selecionado no listbox; caso contrario, remove filtro.
1023:     *==========================================================================
1024:     PROCEDURE CarregarLista()
1025:         IF !USED("csRel")
1026:             RETURN
1027:         ENDIF
1028: 
1029:         IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
1030:            !EMPTY(THIS.obj_4c_Arquivos.Value)
1031:             THIS.ArquivosInteractiveChange()
1032:         ELSE
1033:             SELECT csRel
1034:             SET ORDER TO TAG GruMat
1035:             SET KEY TO
1036:             GO TOP
1037:         ENDIF
1038: 
1039:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1040:             THIS.grd_4c_Dados.Refresh
1041:         ENDIF
1042:     ENDPROC
1043: 
1044:     *==========================================================================
1045:     * AjustarBotoesPorModo - Gerencia visibilidade de botoes conforme estado
1046:     *   Form OPERACIONAL: mostra/oculta os botoes de relatorio (Video,
1047:     *   Impressora, ShpRp) de acordo com o estado de processamento atual.
1048:     *==========================================================================
1049:     PROCEDURE AjustarBotoesPorModo()
1050:         LOCAL loc_lProcessado
1051:         loc_lProcessado = THIS.this_lProcessamento .AND. ;
1052:                           USED("csRel") .AND. RECCOUNT("csRel") > 0
1053: 
1054:         IF VARTYPE(THIS.shp_4c_ShpRp) = "O"
1055:             THIS.shp_4c_ShpRp.Visible = loc_lProcessado
1056:         ENDIF
1057:         IF VARTYPE(THIS.cmd_4c_CmdRpview) = "O"
1058:             THIS.cmd_4c_CmdRpview.Visible = loc_lProcessado
1059:         ENDIF
1060:         IF VARTYPE(THIS.cmd_4c_CmdRpPrint) = "O"
1061:             THIS.cmd_4c_CmdRpPrint.Visible = loc_lProcessado
1062:         ENDIF
1063:     ENDPROC
1064: 
1065:     *==========================================================================
1066:     * HabilitarCampos - Habilita/desabilita controles conforme estado
1067:     *   Form OPERACIONAL: controla o listbox de grupos (apenas quando ha
1068:     *   dados processados). Botao Processar permanece sempre habilitado.
1069:     *==========================================================================
1070:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1071:         IF VARTYPE(THIS.obj_4c_Arquivos) = "O"
1072:             THIS.obj_4c_Arquivos.Enabled = par_lHabilitar
1073:         ENDIF
1074:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
1075:             THIS.cmd_4c_Processar.Enabled = .T.
1076:         ENDIF
1077:     ENDPROC
1078: 
1079:     *==========================================================================
1080:     * LimparCampos - Limpa dados processados e reseta estado do form
1081:     *   Form OPERACIONAL: zera cursor csRel, limpa listbox, oculta botoes de
1082:     *   relatorio e reseta flags de processamento no form e no BO.
1083:     *==========================================================================
1084:     PROTECTED PROCEDURE LimparCampos()
1085:         IF USED("csRel")
1086:             SELECT csRel
1087:             SET KEY TO
1088:             ZAP
1089:         ENDIF
1090: 
1091:         IF USED("csCab")
1092:             SELECT csCab
1093:             ZAP
1094:             APPEND BLANK
1095:         ENDIF
1096: 
1097:         IF VARTYPE(THIS.obj_4c_Arquivos) = "O"
1098:             THIS.obj_4c_Arquivos.Clear()
1099:         ENDIF
1100: 
1101:         THIS.this_lProcessamento = .F.
1102: 
1103:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1104:             THIS.this_oBusinessObject.this_lProcessamento = .F.
1105:             THIS.this_oBusinessObject.this_cGrupoAtual    = ""
1106:         ENDIF
1107: 
1108:         THIS.AjustarBotoesPorModo()
1109: 
1110:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1111:             THIS.grd_4c_Dados.Refresh
1112:         ENDIF
1113:     ENDPROC
1114: 
1115:     *==========================================================================
1116:     * FormParaBO - Transfere estado do form para o Business Object
1117:     *   Form OPERACIONAL: transfere o grupo selecionado no listbox e o
1118:     *   subtitulo derivado para as propriedades correspondentes do BO.
1119:     *==========================================================================
1120:     PROTECTED PROCEDURE FormParaBO()
1121:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1122:             RETURN
1123:         ENDIF
1124: 
1125:         *-- Grupo selecionado no listbox -> BO
1126:         IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
1127:            !EMPTY(THIS.obj_4c_Arquivos.Value)
1128:             THIS.this_oBusinessObject.this_cGrupoAtual = ;
1129:                 ALLTRIM(LEFT(THIS.obj_4c_Arquivos.Value, 3))
1130:         ELSE
1131:             THIS.this_oBusinessObject.this_cGrupoAtual = ""
1132:         ENDIF
1133: 
1134:         *-- Subtitulo do relatorio = grupo ativo
1135:         THIS.this_oBusinessObject.this_cSubTitulo = ;
1136:             THIS.this_oBusinessObject.this_cGrupoAtual
1137:     ENDPROC
1138: 
1139:     *==========================================================================
1140:     * BOParaForm - Transfere estado do Business Object para o form
1141:     *   Form OPERACIONAL: sincroniza selecao do listbox de grupos com o
1142:     *   filtro ativo no BO e reaplica o filtro no cursor csRel.
1143:     *==========================================================================
1144:     PROTECTED PROCEDURE BOParaForm()
1145:         LOCAL loc_cGrupo, loc_i
1146: 
1147:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1148:             RETURN
1149:         ENDIF
1150: 
1151:         *-- Sincroniza selecao do listbox com grupo ativo no BO
1152:         IF !EMPTY(THIS.this_oBusinessObject.this_cGrupoAtual) .AND. ;
1153:            VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
1154:            THIS.obj_4c_Arquivos.ListCount > 0
1155:             loc_cGrupo = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoAtual)
1156:             FOR loc_i = 1 TO THIS.obj_4c_Arquivos.ListCount
1157:                 IF UPPER(LEFT(ALLTRIM(THIS.obj_4c_Arquivos.List(loc_i)), 3)) = UPPER(loc_cGrupo)
1158:                     THIS.obj_4c_Arquivos.ListIndex = loc_i
1159:                     EXIT
1160:                 ENDIF
1161:             ENDFOR
1162:         ENDIF
1163: 
1164:         *-- Reaplica filtro de grupo no cursor csRel
1165:         IF !EMPTY(THIS.this_oBusinessObject.this_cGrupoAtual)
1166:             THIS.this_oBusinessObject.FiltrarPorGrupo(THIS.this_oBusinessObject.this_cGrupoAtual)
1167:         ENDIF
1168:     ENDPROC
1169: 
1170: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdAcoBO.prg):
*==============================================================================
* SigPdAcoBO.prg - Business Object: Acompanhamento de Material por Grupo
* Form Operacional - sem tabela principal unica (multi-tabelas)
* Tabelas: SigMvEst, SigCdPro, SigMvCab, SigMvItn, SigCdGrp, SigCdPam, SigCdEmp
*==============================================================================

DEFINE CLASS SigPdAcoBO AS BusinessBase

    *-- Controle de estado do processamento
    this_lProcessamento  = .F.

    *-- Parametros de operacoes carregados de SigCdPam
    this_cDopEmphs   = ""
    this_cDopReqcs   = ""
    this_cDopPedcs   = ""
    this_cDopComps   = ""
    this_cDopTrfCps  = ""

    *-- Cabecalho do relatorio
    this_cTituloRel   = ""
    this_cSubTitulo   = ""
    this_cNomeEmpresa = ""

    *-- Filtro corrente
    this_cGrupoAtual  = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO (form operacional sem tabela CRUD unica)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor de parametros para this_*
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDopEmphs  = TratarNulo(DopEmphs,  "C")
            THIS.this_cDopReqcs  = TratarNulo(DopReqcs,  "C")
            THIS.this_cDopPedcs  = TratarNulo(DopPedcs,  "C")
            THIS.this_cDopComps  = TratarNulo(DopComps,  "C")
            THIS.this_cDopTrfCps = TratarNulo(DopTrfCps, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem chave unica
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Executa primeira geracao do relatorio
    *   Form operacional de relatorio: a operacao "Inserir" equivale a executar
    *   o processamento inicial que monta o cursor csRel com saldos atuais,
    *   parametros e empresa. Retorna .T. se o processamento foi bem sucedido
    *   e o cursor csRel ficou disponivel para o Grid.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_oListbox)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Garante parametros e cursores prontos
            IF EMPTY(THIS.this_cDopEmphs) .AND. EMPTY(THIS.this_cDopReqcs) .AND. ;
               EMPTY(THIS.this_cDopPedcs) .AND. EMPTY(THIS.this_cDopComps) .AND. ;
               EMPTY(THIS.this_cDopTrfCps)
                THIS.CarregarParametros()
            ENDIF

            IF !USED("csRel") .OR. !USED("csCab")
                THIS.CriarCursorRelatorio()
            ENDIF

            *-- Executa processamento real (popula csRel + listbox de grupos)
            loc_lSucesso = THIS.Processar(par_oListbox)

            IF loc_lSucesso
                THIS.this_lProcessamento = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Re-executa processamento do relatorio
    *   Form operacional de relatorio: a operacao "Atualizar" equivale a
    *   recalcular saldos atuais. Zera csRel, reprocessa do zero e mantem
    *   o filtro de grupo corrente. Usado quando o usuario clica "Processar"
    *   apos primeira execucao para refletir mudancas em estoque.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_oListbox)
        LOCAL loc_lSucesso, loc_cGrupoAnterior
        loc_lSucesso = .F.
        loc_cGrupoAnterior = THIS.this_cGrupoAtual

        TRY
            *-- Limpa filtro previo para nao interferir no SCAN do Processar
            IF USED("csRel")
                SELECT csRel
                SET KEY TO
                ZAP
            ENDIF

            *-- Reprocessa carregando saldos atuais
            loc_lSucesso = THIS.Processar(par_oListbox)

            IF loc_lSucesso
                THIS.this_lProcessamento = .T.

                *-- Restaura filtro de grupo se havia um ativo
                IF !EMPTY(loc_cGrupoAnterior) .AND. USED("csRel")
                    THIS.FiltrarPorGrupo(loc_cGrupoAnterior)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de operacao de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DopEmphs, DopReqcs, DopPedcs, DopComps, DopTrfCps " + ;
                       "FROM SigCdPam"

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF !EOF("cursor_4c_Pam")
                    THIS.CarregarDoCursor("cursor_4c_Pam")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - Carrega nome da empresa logada para this_cNomeEmpresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresa()
        LOCAL loc_cSQL, loc_cCodEmp
        loc_cCodEmp = go_4c_Sistema.cCodEmpresa

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp"

            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                SELECT cursor_4c_Emp
                LOCATE FOR ALLTRIM(Cemps) = ALLTRIM(loc_cCodEmp)
                IF FOUND()
                    THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp) + " - " + ALLTRIM(TratarNulo(Razas, "C"))
                ELSE
                    THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp)
                ENDIF
            ELSE
                THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorRelatorio - Cria cursores csRel e csCab para o relatorio
    *                        Estrutura IDENTICA a do Load original
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorRelatorio()
        IF USED("csCab")
            USE IN csCab
        ENDIF
        IF USED("csRel")
            USE IN csRel
        ENDIF

        CREATE CURSOR csCab (cbemp C(60), cbtit C(100), cbsubtit C(100))
        APPEND BLANK

        SET NULL ON
        CREATE CURSOR csRel ( ;
            Cgrus    C(3)    NULL, ;
            Mats     C(10)   NULL, ;
            Dcompos  C(30)   NULL, ;
            Qtds     N(10,3) NULL, ;
            QtdMins  N(10,3) NULL, ;
            CUnis    C(3)    NULL, ;
            QtdReqs  N(10,3) NULL, ;
            QtdPedcs N(10,3) NULL, ;
            QtdComps N(10,3) NULL, ;
            QtdEmphs N(10,3) NULL, ;
            QtdPfins N(10,3) NULL, ;
            QtdPfMs  N(12,3) NULL, ;
            Flags    L       NULL, ;
            Mat2s    C(10)   NULL, ;
            Dcompo2s C(30)   NULL, ;
            Seqs     C(1)    NULL, ;
            PesoMs   N(12,3) NULL  ;
        )
        SET NULL OFF

        INDEX ON Cgrus + Mats + Seqs TAG GruMat
        INDEX ON Mats + CUnis TAG Mats
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Processa saldos e movimentacoes por grupo de material
    *             Popula cursor csRel. par_oListbox recebe grupos encontrados.
    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_oListbox)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCodEmp, loc_cEmpGE
        LOCAL loc_nX, loc_cOperBusca, loc_cCampo, loc_cEdI, loc_cEdF, loc_qtMin
        LOCAL loc_cCPros_s, loc_cDPros_s, loc_cCUnis_s, loc_cCGrus_s, loc_cCUniPs_s
        LOCAL loc_nQMins_s, loc_nPesoMs_s, loc_nSqtds_s, loc_nSPesos_s
        LOCAL loc_cCPros_o, loc_cCUnis_o, loc_cCUniPs_o, loc_cCGrus_o, loc_cDPros_o
        LOCAL loc_nQMins_o, loc_nPesoMs_o, loc_nQtdDiff_o

        loc_lSucesso = .F.
        loc_cCodEmp  = go_4c_Sistema.cCodEmpresa

        TRY
            *-- Prepara titulo e cabecalho do relatorio
            THIS.this_cTituloRel = "Relat" + CHR(243) + "rio de Acompanhamento de Material por Grupo"
            THIS.this_cSubTitulo = " "
            THIS.CarregarEmpresa()

            IF USED("csCab")
                SELECT csCab
                REPLACE cbemp    WITH THIS.this_cNomeEmpresa, ;
                        cbtit    WITH THIS.this_cTituloRel,   ;
                        cbsubtit WITH THIS.this_cSubTitulo
            ENDIF

            *-- Zera ou (re)cria csRel
            IF USED("csRel")
                SELECT csRel
                ZAP
            ELSE
                THIS.CriarCursorRelatorio()
            ENDIF

            *-- Carrega grupos validos (crGrupo com index por Cgrus)
            loc_cSQL = "SELECT Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE NOT GruEstPs = '" + SPACE(10) + "' AND " + ;
                             "NOT ConEstPs = '" + SPACE(10) + "'"

            IF USED("crGrupo")
                USE IN crGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crGrupo") < 1
                MsgAviso("Falha na conex" + CHR(227) + "o (crGrupo)", "Aviso")
                loc_lSucesso = loc_lSucesso
            ENDIF
            SELECT crGrupo
            INDEX ON Cgrus TAG Cgrus

            *-- Carrega combinacoes Grupos/Estos para busca no estoque
            loc_cSQL = "SELECT DISTINCT GruEstPs AS Grupos, ConEstps AS Estos " + ;
                       "FROM SigCdGrp " + ;
                       "WHERE NOT GruEstPs = '" + SPACE(10) + "' AND " + ;
                             "NOT ConEstPs = '" + SPACE(10) + "'"

            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrp") < 1
                MsgAviso("Falha na conex" + CHR(227) + "o (crSigCdGrp)", "Aviso")
                loc_lSucesso = loc_lSucesso
            ENDIF

            *-- Cria cursor acumulador de estoque (writable) com campos necessarios
            IF USED("pEstoque")
                USE IN pEstoque
            ENDIF
            SET NULL ON
            CREATE CURSOR pEstoque (CPros C(10) NULL, Sqtds N(10,3) NULL, sPesos N(12,3) NULL)
            SET NULL OFF

            IF RECCOUNT("crSigCdGrp") = 1
                *-- Grupo unico: busca estoque diretamente
                SELECT crSigCdGrp
                GO TOP
                loc_cEmpGE = loc_cCodEmp + crSigCdGrp.Grupos + crSigCdGrp.Estos

                loc_cSQL = "SELECT CPros, Sqtds, sPesos FROM SigMvEst " + ;
                           "WHERE EmpGruEsts = " + EscaparSQL(loc_cEmpGE) + " AND NOT Sqtds = 0"

                IF USED("cursor_4c_EstTemp")
                    USE IN cursor_4c_EstTemp
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstTemp") < 1
                    MsgAviso("Falha na conex" + CHR(227) + "o (pEstoque)", "Aviso")
                    loc_lSucesso = loc_lSucesso
                ENDIF

                SELECT cursor_4c_EstTemp
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO pEstoque FROM MEMVAR
                ENDSCAN
            ELSE
                *-- Multiplos grupos: acumula em pEstoque
                SELECT crSigCdGrp
                SCAN
                    loc_cEmpGE = loc_cCodEmp + crSigCdGrp.Grupos + crSigCdGrp.Estos

                    loc_cSQL = "SELECT CPros, Sqtds, sPesos FROM SigMvEst " + ;
                               "WHERE EmpGruEsts = " + EscaparSQL(loc_cEmpGE) + " AND NOT Sqtds = 0"

                    IF USED("cursor_4c_TmpEst")
                        USE IN cursor_4c_TmpEst
                    ENDIF

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEst") < 1
                        LOOP
                    ENDIF

                    SELECT cursor_4c_TmpEst
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO pEstoque FROM MEMVAR
                    ENDSCAN
                ENDSCAN
            ENDIF

            *-- Preenche listbox de grupos (Cgrus-Dgrus)
            IF TYPE("par_oListbox") = "O" .AND. !ISNULL(par_oListbox)
                par_oListbox.Clear()
                SELECT crGrupo
                GO TOP
                SCAN
                    par_oListbox.AddItem(ALLTRIM(crGrupo.Cgrus) + "-" + ALLTRIM(crGrupo.Dgrus))
                ENDSCAN
            ENDIF

            *-- Popula csRel com saldo atual de estoque por produto/unidade
            SELECT pEstoque
            GO TOP
            SCAN
                loc_cCPros_s = pEstoque.CPros

                loc_cSQL = "SELECT DPros, CUnis, CGrus, QMins, cUniPs, PesoMs " + ;
                           "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(loc_cCPros_s))

                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPro") <= 0 .OR. EOF("crSigCdPro")
                    LOOP
                ENDIF

                SELECT crSigCdPro
                loc_cDPros_s  = TratarNulo(DPros,  "C")
                loc_cCUnis_s  = TratarNulo(CUnis,  "C")
                loc_cCGrus_s  = TratarNulo(CGrus,  "C")
                loc_cCUniPs_s = TratarNulo(cUniPs, "C")
                loc_nQMins_s  = TratarNulo(QMins,  "N")
                loc_nPesoMs_s = TratarNulo(PesoMs, "N")

                *-- Produto deve pertencer a um grupo valido
                IF !SEEK(crSigCdPro.CGrus, "crGrupo", "Cgrus")
                    LOOP
                ENDIF

                SELECT pEstoque
                loc_nSqtds_s  = TratarNulo(Sqtds,  "N")
                loc_nSPesos_s = TratarNulo(sPesos,  "N")

                *-- Linha unidade primaria (Seqs='1')
                SELECT csRel
                IF !SEEK(loc_cCPros_s + loc_cCUnis_s, "csRel", "Mats")
                    APPEND BLANK
                ENDIF

                REPLACE Qtds     WITH Qtds + loc_nSqtds_s, ;
                        QtdMins  WITH loc_nQMins_s, ;
                        Mats     WITH loc_cCPros_s, ;
                        Mat2s    WITH loc_cCPros_s, ;
                        Dcompos  WITH loc_cDPros_s, ;
                        Dcompo2s WITH loc_cDPros_s, ;
                        CUnis    WITH loc_cCUnis_s, ;
                        CGrus    WITH loc_cCGrus_s, ;
                        Seqs     WITH "1"

                *-- Linha unidade alternativa por peso (Seqs='2')
                IF !EMPTY(loc_cCUniPs_s) .AND. loc_nPesoMs_s <> 0
                    loc_qtMin = ROUND(loc_nQMins_s / loc_nPesoMs_s, 0)

                    SELECT csRel
                    IF !SEEK(loc_cCPros_s + loc_cCUniPs_s, "csRel", "Mats")
                        APPEND BLANK
                    ENDIF

                    REPLACE Qtds     WITH Qtds + loc_nSPesos_s, ;
                            QtdMins  WITH loc_qtMin, ;
                            Mats     WITH loc_cCPros_s, ;
                            Dcompos  WITH loc_cDPros_s, ;
                            CUnis    WITH loc_cCUniPs_s, ;
                            CGrus    WITH loc_cCGrus_s, ;
                            PesoMs   WITH loc_nPesoMs_s, ;
                            Seqs     WITH "2"
                ENDIF
            ENDSCAN

            *-- Processa 5 tipos de operacao: Empenho(1), Requisicao(2),
            *   PedidoCompra(3), Compra(4), TransferenciaCompra(5->QtdComps)
            FOR loc_nX = 1 TO 5
                DO CASE
                    CASE loc_nX = 1
                        loc_cOperBusca = THIS.this_cDopEmphs
                        loc_cCampo     = "QtdEmphs"
                    CASE loc_nX = 2
                        loc_cOperBusca = THIS.this_cDopReqcs
                        loc_cCampo     = "QtdReqs"
                    CASE loc_nX = 3
                        loc_cOperBusca = THIS.this_cDopPedcs
                        loc_cCampo     = "QtdPedcs"
                    CASE loc_nX = 4
                        loc_cOperBusca = THIS.this_cDopComps
                        loc_cCampo     = "QtdComps"
                    CASE loc_nX = 5
                        loc_cOperBusca = THIS.this_cDopTrfCps
                        loc_cCampo     = "QtdComps"
                ENDCASE

                IF EMPTY(loc_cOperBusca)
                    LOOP
                ENDIF

                loc_cEdI = loc_cCodEmp + loc_cOperBusca + STR(0,      6)
                loc_cEdF = loc_cCodEmp + loc_cOperBusca + STR(999999, 6)

                loc_cSQL = "SELECT b.EmpDopNums, b.CPros, b.Qtds, b.QtBaixas, " + ;
                           "c.Cgrus, c.QMins, c.Dpros, c.CUnis, c.cUnips, c.PesoMs " + ;
                           "FROM SigMvCab a, SigMvItn b, SigCdPro c " + ;
                           "WHERE a.EmpDopNums BETWEEN " + EscaparSQL(loc_cEdI) + " AND " + EscaparSQL(loc_cEdF) + " AND " + ;
                                 "a.EmpDopNums = b.EmpDopNums AND " + ;
                                 "NOT ((b.Qtds - b.QtBaixas) = 0) AND " + ;
                                 "b.CPros = c.CPros " + ;
                           "ORDER BY b.EmpDopNums, b.CPros, b.Qtds, b.QtBaixas, " + ;
                                    "c.Cgrus, c.QMins, c.Dpros, c.CUnis"

                IF USED("crOperacao")
                    USE IN crOperacao
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "crOperacao") < 1
                    LOOP
                ENDIF

                SELECT crOperacao
                SCAN
                    IF !SEEK(crOperacao.Cgrus, "crGrupo", "Cgrus")
                        LOOP
                    ENDIF

                    loc_cCPros_o   = crOperacao.CPros
                    loc_cCUnis_o   = crOperacao.CUnis
                    loc_cCUniPs_o  = TratarNulo(crOperacao.cUnips, "C")
                    loc_cCGrus_o   = crOperacao.Cgrus
                    loc_cDPros_o   = TratarNulo(crOperacao.Dpros,  "C")
                    loc_nQMins_o   = TratarNulo(crOperacao.QMins,  "N")
                    loc_nPesoMs_o  = TratarNulo(crOperacao.PesoMs, "N")
                    loc_nQtdDiff_o = TratarNulo(crOperacao.Qtds, "N") - TratarNulo(crOperacao.QtBaixas, "N")

                    *-- Linha unidade primaria
                    SELECT csRel
                    IF !SEEK(loc_cCPros_o + loc_cCUnis_o, "csRel", "Mats")
                        APPEND BLANK
                        REPLACE QtdMins  WITH loc_nQMins_o, ;
                                Mats     WITH loc_cCPros_o, ;
                                Dcompos  WITH loc_cDPros_o, ;
                                Mat2s    WITH loc_cCPros_o, ;
                                Dcompo2s WITH loc_cDPros_o, ;
                                CUnis    WITH loc_cCUnis_o, ;
                                CGrus    WITH loc_cCGrus_o, ;
                                PesoMs   WITH loc_nPesoMs_o, ;
                                Seqs     WITH "1"
                    ENDIF

                    DO CASE
                        CASE loc_cCampo = "QtdEmphs"
                            REPLACE QtdEmphs WITH QtdEmphs + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdReqs"
                            REPLACE QtdReqs  WITH QtdReqs  + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdPedcs"
                            REPLACE QtdPedcs WITH QtdPedcs + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdComps"
                            REPLACE QtdComps WITH QtdComps + loc_nQtdDiff_o
                    ENDCASE

                    *-- Linha unidade alternativa por peso
                    IF !EMPTY(loc_cCUniPs_o) .AND. loc_nPesoMs_o <> 0
                        loc_qtMin = ROUND(loc_nQMins_o / loc_nPesoMs_o, 0)

                        SELECT csRel
                        IF !SEEK(loc_cCPros_o + loc_cCUniPs_o, "csRel", "Mats")
                            APPEND BLANK
                            REPLACE QtdMins  WITH loc_qtMin, ;
                                    Mats     WITH loc_cCPros_o, ;
                                    Dcompos  WITH loc_cDPros_o, ;
                                    CUnis    WITH loc_cCUniPs_o, ;
                                    CGrus    WITH loc_cCGrus_o, ;
                                    PesoMs   WITH loc_nPesoMs_o, ;
                                    Seqs     WITH "2"
                        ENDIF

                        DO CASE
                            CASE loc_cCampo = "QtdEmphs"
                                REPLACE QtdEmphs WITH QtdEmphs + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdReqs"
                                REPLACE QtdReqs  WITH QtdReqs  + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdPedcs"
                                REPLACE QtdPedcs WITH QtdPedcs + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdComps"
                                REPLACE QtdComps WITH QtdComps + loc_nQtdDiff_o
                        ENDCASE
                    ENDIF
                ENDSCAN
            ENDFOR

            *-- Calcula posicao final e flag de alerta (linhas Seqs='2' em peso)
            SELECT csRel
            SCAN
                IF Seqs = "2"
                    REPLACE QtdReqs  WITH ROUND(QtdReqs  / PesoMs, 0), ;
                            QtdPedcs WITH ROUND(QtdPedcs / PesoMs, 0), ;
                            QtdComps WITH ROUND(QtdComps / PesoMs, 0), ;
                            QtdEmphs WITH ROUND(QtdEmphs / PesoMs, 0), ;
                            Dcompo2s WITH PADC("*", 35)
                ENDIF
                REPLACE QtdPfins WITH (Qtds - QtdMins + QtdReqs + QtdPedcs + QtdComps - QtdEmphs)
                REPLACE Flags    WITH IIF(QtdReqs > 0 .AND. QtdPfins > 0, .T., .F.)
            ENDSCAN

            THIS.this_lProcessamento = .T.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarPorGrupo - Aplica filtro SET KEY no cursor csRel pelo grupo
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarPorGrupo(par_cGrupo)
        THIS.this_cGrupoAtual = ALLTRIM(LEFT(par_cGrupo, 3))

        IF USED("csRel")
            SELECT csRel
            SET ORDER TO TAG GruMat
            SET KEY TO THIS.this_cGrupoAtual
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCabecalhoRelatorio - Atualiza subtitulo no cursor csCab
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarCabecalhoRelatorio(par_cSubTitulo)
        THIS.this_cSubTitulo = par_cSubTitulo
        IF USED("csCab")
            SELECT csCab
            REPLACE cbsubtit WITH par_cSubTitulo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores auxiliares criados pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(9), loc_i
        loc_aCursores(1) = "cursor_4c_Pam"
        loc_aCursores(2) = "cursor_4c_Emp"
        loc_aCursores(3) = "crGrupo"
        loc_aCursores(4) = "crSigCdGrp"
        loc_aCursores(5) = "pEstoque"
        loc_aCursores(6) = "crOperacao"
        loc_aCursores(7) = "crSigCdPro"
        loc_aCursores(8) = "cursor_4c_EstTemp"
        loc_aCursores(9) = "cursor_4c_TmpEst"

        FOR loc_i = 1 TO 9
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

