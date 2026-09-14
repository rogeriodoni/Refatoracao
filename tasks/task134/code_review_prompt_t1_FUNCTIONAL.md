# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Qt.Mínima' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Material, Descrição, Unid, Qt.Minima, Saldo Atual, Requisição, Ped.Compra, Compra, Empenho, Pos.Final *. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdAco.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1166 linhas total):

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
125:         ENDWITH
126: 
127:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
128:         WITH loc_oCnt.lbl_4c_LblSombra
129:             .Top       = 18
130:             .Left      = 10
131:             .Width     = 769
132:             .Height    = 40
133:             .FontBold  = .T.
134:             .FontName  = "Tahoma"
135:             .FontSize  = 18
136:             .WordWrap  = .T.
137:             .Alignment = 0
138:             .BackStyle = 0
139:             .Caption   = "Acompanhamento de Material por Grupo"
140:             .ForeColor = RGB(0, 0, 0)
141:         ENDWITH
142: 
143:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
144:         WITH loc_oCnt.lbl_4c_LblTitulo
145:             .Top       = 17
146:             .Left      = 10
147:             .Width     = 769
148:             .Height    = 46
149:             .FontBold  = .T.
150:             .FontName  = "Tahoma"
151:             .FontSize  = 18
152:             .WordWrap  = .T.
153:             .Alignment = 0

*-- Linhas 160 a 422:
160:     *==========================================================================
161:     * ConfigurarAguarde - Container de espera (Visible=.F., toggled por Processar)
162:     *==========================================================================
163:     PROTECTED PROCEDURE ConfigurarAguarde()
164:         LOCAL loc_oCnt
165:         THIS.AddObject("cnt_4c_Aguarde", "Container")
166:         loc_oCnt = THIS.cnt_4c_Aguarde
167:         WITH loc_oCnt
168:             .Top           = 287
169:             .Left          = 117
170:             .Width         = 516
171:             .Height        = 139
172:             .SpecialEffect = 0
173:             .Visible       = .F.
174:         ENDWITH
175: 
176:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
177:         WITH loc_oCnt.lbl_4c_Label1
178:             .Top       = 28
179:             .Left      = 206
180:             .Width     = 105
181:             .Height    = 29
182:             .FontBold  = .T.
183:             .FontSize  = 14
184:             .Caption   = "Aguarde..."
185:             .ForeColor = RGB(255, 0, 0)
186:         ENDWITH
187: 
188:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
189:         WITH loc_oCnt.lbl_4c_Label2
190:             .Top       = 79
191:             .Left      = 135
192:             .Width     = 242
193:             .Height    = 27
194:             .FontBold  = .T.
195:             .FontSize  = 14
196:             .Caption   = "Processando Dados ......"
197:             .ForeColor = RGB(0, 0, 160)
198:         ENDWITH
199:     ENDPROC
200: 
201:     *==========================================================================
202:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
203:     *   EXCETO containers/controles com Visible=.F. intencional
204:     *==========================================================================
205:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
206:         LOCAL loc_i, loc_oControl
207: 
208:         FOR loc_i = 1 TO par_oContainer.ControlCount
209:             loc_oControl = par_oContainer.Controls(loc_i)
210: 
211:             IF VARTYPE(loc_oControl) = "O"
212:                 *-- Controles que devem permanecer ocultos ate acao do usuario
213:                 IF INLIST(UPPER(loc_oControl.Name), ;
214:                           "CNT_4C_AGUARDE",    ;
215:                           "SHP_4C_SHPRP",      ;
216:                           "CMD_4C_CMDRPVIEW",  ;
217:                           "CMD_4C_CMDRPPRINT")
218:                     LOOP
219:                 ENDIF
220: 
221:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
222:                     loc_oControl.Visible = .T.
223:                 ENDIF
224: 
225:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) .AND. ;
226:                    loc_oControl.ControlCount > 0
227:                     THIS.TornarControlesVisiveis(loc_oControl)
228:                 ENDIF
229:             ENDIF
230:         ENDFOR
231:     ENDPROC
232: 
233:     *==========================================================================
234:     * Activate - Processa dados na primeira ativacao do form
235:     *==========================================================================
236:     PROCEDURE Activate()
237:         DODEFAULT()
238:         IF !THIS.this_lProcessamento
239:             THIS.BtnProcessarClick()
240:         ENDIF
241:     ENDPROC
242: 
243:     *==========================================================================
244:     * ConfigurarPaginaLista - Configura layout operacional: grid + botoes + filtros
245:     *==========================================================================
246:     PROTECTED PROCEDURE ConfigurarPaginaLista()
247:         LOCAL loc_oGrd
248: 
249:         *-- Shape de fundo para area de botoes de relatorio (oculto ate processar)
250:         THIS.AddObject("shp_4c_ShpRp", "Shape")
251:         WITH THIS.shp_4c_ShpRp
252:             .Top         = 7
253:             .Left        = 552
254:             .Width       = 229
255:             .Height      = 110
256:             .BackStyle   = 0
257:             .BorderColor = RGB(136, 189, 188)
258:             .Visible     = .F.
259:         ENDWITH
260: 
261:         *-- Botao Processar (sempre visivel apos TornarControlesVisiveis)
262:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
263:         WITH THIS.cmd_4c_Processar
264:             .Top             = 3
265:             .Left            = 500
266:             .Width           = 75
267:             .Height          = 75
268:             .Caption         = "Processar"
269:             .FontName        = "Comic Sans MS"
270:             .FontBold        = .T.
271:             .FontItalic      = .T.
272:             .FontSize        = 8
273:             .ForeColor       = RGB(90, 90, 90)
274:             .BackColor       = RGB(255, 255, 255)
275:             .Themes          = .F.
276:             .SpecialEffect   = 0
277:             .PicturePosition = 13
278:             .MousePointer    = 15
279:             .WordWrap        = .T.
280:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
281:         ENDWITH
282:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
283: 
284:         *-- Botao Visualizar relatorio em tela (oculto ate processar)
285:         THIS.AddObject("cmd_4c_CmdRpview", "CommandButton")
286:         WITH THIS.cmd_4c_CmdRpview
287:             .Top             = 3
288:             .Left            = 650
289:             .Width           = 75
290:             .Height          = 75
291:             .Caption         = "V" + CHR(237) + "deo"
292:             .FontName        = "Comic Sans MS"
293:             .FontBold        = .T.
294:             .FontItalic      = .T.
295:             .FontSize        = 8
296:             .ForeColor       = RGB(90, 90, 90)
297:             .BackColor       = RGB(255, 255, 255)
298:             .Themes          = .F.
299:             .SpecialEffect   = 0
300:             .PicturePosition = 13
301:             .MousePointer    = 15
302:             .WordWrap        = .T.
303:             .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
304:             .Visible         = .F.
305:         ENDWITH
306:         BINDEVENT(THIS.cmd_4c_CmdRpview, "Click", THIS, "BtnCmdRpviewClick")
307: 
308:         *-- Botao Imprimir relatorio (oculto ate processar)
309:         THIS.AddObject("cmd_4c_CmdRpPrint", "CommandButton")
310:         WITH THIS.cmd_4c_CmdRpPrint
311:             .Top             = 3
312:             .Left            = 575
313:             .Width           = 75
314:             .Height          = 75
315:             .Caption         = "Impressora"
316:             .FontName        = "Comic Sans MS"
317:             .FontBold        = .T.
318:             .FontItalic      = .T.
319:             .FontSize        = 8
320:             .ForeColor       = RGB(90, 90, 90)
321:             .BackColor       = RGB(255, 255, 255)
322:             .Themes          = .F.
323:             .SpecialEffect   = 0
324:             .PicturePosition = 13
325:             .MousePointer    = 15
326:             .WordWrap        = .T.
327:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
328:             .Visible         = .F.
329:         ENDWITH
330:         BINDEVENT(THIS.cmd_4c_CmdRpPrint, "Click", THIS, "BtnCmdRpPrintClick")
331: 
332:         *-- CommandGroup de saida equivalente a Encerrar (posicao top-right no form 800px)
333:         THIS.AddObject("obj_4c_CmdGprocessa", "CommandGroup")
334:         WITH THIS.obj_4c_CmdGprocessa
335:             .Top           = -2
336:             .Left          = 720
337:             .Width         = 85
338:             .Height        = 85
339:             .ButtonCount   = 1
340:             .BackStyle     = 0
341:             .BorderStyle   = 0
342:             .Themes        = .F.
343:             .AutoSize      = .T.
344:             .SpecialEffect = 1
345:             .BorderColor   = RGB(136, 189, 188)
346:         ENDWITH
347:         WITH THIS.obj_4c_CmdGprocessa.Buttons(1)
348:             .Left            = 5
349:             .Top             = 5
350:             .Width           = 75
351:             .Height          = 75
352:             .Caption         = "Encerrar"
353:             .FontName        = "Comic Sans MS"
354:             .FontBold        = .T.
355:             .FontItalic      = .T.
356:             .FontSize        = 8
357:             .ForeColor       = RGB(90, 90, 90)
358:             .BackColor       = RGB(255, 255, 255)
359:             .Themes          = .F.
360:             .SpecialEffect   = 0
361:             .PicturePosition = 13
362:             .MousePointer    = 15
363:             .WordWrap        = .T.
364:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
365:         ENDWITH
366:         BINDEVENT(THIS.obj_4c_CmdGprocessa, "ButtonClick", THIS, "BtnCmdGprocessaClick")
367: 
368:         *-- Listbox de grupos para filtro (Arquivos no legado)
369:         THIS.AddObject("obj_4c_Arquivos", "ListBox")
370:         WITH THIS.obj_4c_Arquivos
371:             .Top           = 122
372:             .Left          = 84
373:             .Width         = 169
374:             .Height        = 79
375:             .FontName      = "Tahoma"
376:             .FontSize      = 8
377:             .ForeColor     = RGB(90, 90, 90)
378:             .BackColor     = RGB(255, 255, 255)
379:             .RowSourceType = 1
380:             .Sorted        = .T.
381:         ENDWITH
382:         BINDEVENT(THIS.obj_4c_Arquivos, "InteractiveChange", THIS, "ArquivosInteractiveChange")
383: 
384:         *-- Label "Grupos :" (Label7 no legado)
385:         THIS.AddObject("lbl_4c_Label7", "Label")
386:         WITH THIS.lbl_4c_Label7
387:             .Top       = 124
388:             .Left      = 34
389:             .Width     = 48
390:             .Height    = 15
391:             .Caption   = "Grupos :"
392:             .FontName  = "Tahoma"
393:             .FontSize  = 8
394:             .ForeColor = RGB(90, 90, 90)
395:             .BackStyle = 0
396:         ENDWITH
397: 
398:         *-- Grid principal (GrdF no legado) - 10 colunas mapeadas para csRel
399:         THIS.AddObject("grd_4c_Dados", "Grid")
400:         loc_oGrd = THIS.grd_4c_Dados
401:         WITH loc_oGrd
402:             .Top                = 205
403:             .Left               = 34
404:             .Width              = 732
405:             .Height             = 272
406:             .ColumnCount        = 10
407:             .FontName           = "Verdana"
408:             .FontSize           = 8
409:             .ForeColor          = RGB(90, 90, 90)
410:             .BackColor          = RGB(255, 255, 255)
411:             .GridLineColor      = RGB(238, 238, 238)
412:             .HighlightBackColor = RGB(255, 255, 255)
413:             .HighlightForeColor = RGB(15, 41, 104)
414:             .HighlightStyle     = 2
415:             .DeleteMark         = .F.
416:             .RecordMark         = .F.
417:             .RowHeight          = 16
418:             .ScrollBars         = 2
419:             .RecordSource       = "csRel"
420:             .RecordSourceType   = 1
421:         ENDWITH
422: 

*-- Linhas 482 a 760:
482:     *   Form OPERACIONAL nao tem Page2/Dados como CRUD. Este metodo agrupa
483:     *   os labels explicativos do calculo de Pos.Final exibidos abaixo do grid.
484:     *==========================================================================
485:     PROTECTED PROCEDURE ConfigurarPaginaDados()
486:         *-- Label3: formula de Pos.Final (rodape pixel-perfect do legado)
487:         THIS.AddObject("lbl_4c_Label3", "Label")
488:         WITH THIS.lbl_4c_Label3
489:             .Top       = 487
490:             .Left      = 117
491:             .Width     = 585
492:             .Height    = 15
493:             .Caption   = "( * ) Pos.Final = Saldo Atual + Requisi" + CHR(231) + CHR(227) + "o + " + ;
494:                          "Ped.Compra + Compra - Empenho - Qt.M" + CHR(237) + "nima"
495:             .FontName  = "Tahoma"
496:             .FontBold  = .T.
497:             .FontSize  = 8
498:             .ForeColor = RGB(90, 90, 90)
499:             .BackStyle = 0
500:         ENDWITH
501: 
502:         *-- Label4: nota sobre marcadores [*] (peso medio)
503:         THIS.AddObject("lbl_4c_Label4", "Label")
504:         WITH THIS.lbl_4c_Label4
505:             .Top       = 507
506:             .Left      = 118
507:             .Width     = 372
508:             .Height    = 15
509:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o = [ * ]   Calculado pelo Peso M" + CHR(233) + "dio do Material"
510:             .FontName  = "Tahoma"
511:             .FontBold  = .T.
512:             .FontSize  = 8
513:             .ForeColor = RGB(90, 90, 90)
514:             .BackStyle = 0
515:         ENDWITH
516:     ENDPROC
517: 
518:     *==========================================================================
519:     * BtnIncluirClick - Inicia novo processamento (gera relatorio do zero)
520:     *   Form OPERACIONAL: "Incluir" equivale a iniciar nova geracao de relatorio
521:     *   resetando o estado anterior e executando processamento completo.
522:     *==========================================================================
523:     PROCEDURE BtnIncluirClick()
524:         THIS.this_lProcessamento = .F.
525:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
526:             THIS.this_oBusinessObject.this_lProcessamento = .F.
527:         ENDIF
528:         THIS.shp_4c_ShpRp.Visible      = .F.
529:         THIS.cmd_4c_CmdRpview.Visible  = .F.
530:         THIS.cmd_4c_CmdRpPrint.Visible = .F.
531:         THIS.BtnProcessarClick()
532:     ENDPROC
533: 
534:     *==========================================================================
535:     * BtnAlterarClick - Atualiza dados do relatorio (re-processamento)
536:     *   Form OPERACIONAL: "Alterar" equivale a atualizar/re-processar os dados
537:     *   mantendo o estado de processamento ja realizado.
538:     *==========================================================================
539:     PROCEDURE BtnAlterarClick()
540:         IF !THIS.this_lProcessamento
541:             THIS.BtnProcessarClick()
542:         ELSE
543:             LOCAL loc_lSucesso, loc_oErro
544:             loc_lSucesso = .F.
545: 
546:             THIS.cnt_4c_Aguarde.Visible = .T.
547:             THIS.cnt_4c_Aguarde.ZOrder(0)
548:             THIS.Refresh
549: 
550:             TRY
551:                 loc_lSucesso = THIS.this_oBusinessObject.Atualizar(THIS.obj_4c_Arquivos)
552:             CATCH TO loc_oErro
553:                 MsgErro(loc_oErro.Message, "Erro")
554:             ENDTRY
555: 
556:             THIS.cnt_4c_Aguarde.Visible = .F.
557: 
558:             IF loc_lSucesso
559:                 IF THIS.obj_4c_Arquivos.ListCount > 0 .AND. ;
560:                    !EMPTY(THIS.obj_4c_Arquivos.Value)
561:                     THIS.ArquivosInteractiveChange()
562:                 ENDIF
563:                 THIS.grd_4c_Dados.Refresh
564:             ENDIF
565:         ENDIF
566:     ENDPROC
567: 
568:     *==========================================================================
569:     * BtnVisualizarClick - Visualiza o relatorio em tela
570:     *   Form OPERACIONAL: "Visualizar" equivale ao preview do relatorio gerado.
571:     *   Exige que o processamento ja tenha sido executado.
572:     *==========================================================================
573:     PROCEDURE BtnVisualizarClick()
574:         IF !THIS.this_lProcessamento .OR. !USED("csRel") .OR. RECCOUNT("csRel") = 0
575:             MsgAviso("Execute o processamento antes de visualizar o relat" + CHR(243) + "rio.", "Aviso")
576:             RETURN
577:         ENDIF
578:         THIS.BtnCmdRpviewClick()
579:     ENDPROC
580: 
581:     *==========================================================================
582:     * BtnExcluirClick - Limpa dados do relatorio (reset)
583:     *   Form OPERACIONAL: "Excluir" equivale a limpar o cursor csRel e resetar
584:     *   o estado de processamento, ocultando botoes de visualizacao/impressao.
585:     *==========================================================================
586:     PROCEDURE BtnExcluirClick()
587:         IF !MsgConfirma("Deseja realmente limpar os dados do relat" + CHR(243) + "rio?", "Confirma" + CHR(231) + CHR(227) + "o")
588:             RETURN
589:         ENDIF
590: 
591:         IF USED("csRel")
592:             SELECT csRel
593:             ZAP
594:         ENDIF
595: 
596:         THIS.this_lProcessamento = .F.
597:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
598:             THIS.this_oBusinessObject.this_lProcessamento = .F.
599:         ENDIF
600: 
601:         THIS.shp_4c_ShpRp.Visible      = .F.
602:         THIS.cmd_4c_CmdRpview.Visible  = .F.
603:         THIS.cmd_4c_CmdRpPrint.Visible = .F.
604:         THIS.grd_4c_Dados.Refresh
605:     ENDPROC
606: 
607:     *==========================================================================
608:     * BtnProcessarClick - Processa dados e popula grid
609:     *==========================================================================
610:     PROCEDURE BtnProcessarClick()
611:         LOCAL loc_lSucesso, loc_oErro
612:         loc_lSucesso = .F.
613: 
614:         THIS.cnt_4c_Aguarde.Visible = .T.
615:         THIS.cnt_4c_Aguarde.ZOrder(0)
616:         THIS.Refresh
617: 
618:         TRY
619:             IF THIS.this_lProcessamento
620:                 loc_lSucesso = THIS.this_oBusinessObject.Atualizar(THIS.obj_4c_Arquivos)
621:             ELSE
622:                 loc_lSucesso = THIS.this_oBusinessObject.Inserir(THIS.obj_4c_Arquivos)
623:             ENDIF
624:         CATCH TO loc_oErro
625:             MsgErro(loc_oErro.Message, "Erro")
626:         ENDTRY
627: 
628:         THIS.cnt_4c_Aguarde.Visible = .F.
629: 
630:         IF loc_lSucesso
631:             THIS.this_lProcessamento = .T.
632: 
633:             IF USED("csRel") .AND. RECCOUNT("csRel") > 0
634:                 *-- Seleciona primeiro grupo da lista e filtra o grid (padrao original)
635:                 IF THIS.obj_4c_Arquivos.ListCount > 0
636:                     THIS.obj_4c_Arquivos.ListIndex = 1
637:                     THIS.ArquivosInteractiveChange()
638:                 ENDIF
639:                 THIS.grd_4c_Dados.Refresh
640:                 THIS.shp_4c_ShpRp.Visible     = .T.
641:                 THIS.cmd_4c_CmdRpview.Visible  = .T.
642:                 THIS.cmd_4c_CmdRpPrint.Visible = .T.
643:                 THIS.obj_4c_Arquivos.SetFocus
644:             ELSE
645:                 MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + "o!!!", "Aviso")
646:             ENDIF
647:         ENDIF
648:     ENDPROC
649: 
650:     *==========================================================================
651:     * BtnCmdRpviewClick - Exibe relatorio em tela (Preview)
652:     *==========================================================================
653:     PROCEDURE BtnCmdRpviewClick()
654:         LOCAL loc_cSub, loc_cRelatorio
655:         loc_cSub       = ""
656:         loc_cRelatorio = gc_4c_CaminhoReports + "RelSigPdAco.frx"
657: 
658:         IF !EMPTY(THIS.obj_4c_Arquivos.Value)
659:             loc_cSub = ALLTRIM(THIS.obj_4c_Arquivos.Value)
660:         ENDIF
661: 
662:         THIS.this_oBusinessObject.AtualizarCabecalhoRelatorio(loc_cSub)
663: 
664:         IF FILE(loc_cRelatorio)
665:             REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
666:         ELSE
667:             MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cRelatorio, ;
668:                      "Relat" + CHR(243) + "rio")
669:         ENDIF
670:     ENDPROC
671: 
672:     *==========================================================================
673:     * BtnCmdRpPrintClick - Imprime relatorio na impressora
674:     *==========================================================================
675:     PROCEDURE BtnCmdRpPrintClick()
676:         LOCAL loc_cSub, loc_cRelatorio
677:         loc_cSub       = ""
678:         loc_cRelatorio = gc_4c_CaminhoReports + "RelSigPdAco.frx"
679: 
680:         IF !EMPTY(THIS.obj_4c_Arquivos.Value)
681:             loc_cSub = ALLTRIM(THIS.obj_4c_Arquivos.Value)
682:         ENDIF
683: 
684:         THIS.this_oBusinessObject.AtualizarCabecalhoRelatorio(loc_cSub)
685: 
686:         IF FILE(loc_cRelatorio)
687:             REPORT FORM (loc_cRelatorio) TO PRINTER PROMPT NOCONSOLE
688:         ELSE
689:             MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cRelatorio, ;
690:                      "Relat" + CHR(243) + "rio")
691:         ENDIF
692:     ENDPROC
693: 
694:     *==========================================================================
695:     * BtnCmdGprocessaClick - Encerra o formulario
696:     *   par_nButton: indice do botao clicado no CommandGroup (sempre 1)
697:     *==========================================================================
698:     PROCEDURE BtnCmdGprocessaClick(par_nButton)
699:         THIS.Release()
700:     ENDPROC
701: 
702:     *==========================================================================
703:     * ArquivosInteractiveChange - Filtra grid pelo grupo selecionado no listbox
704:     *==========================================================================
705:     PROCEDURE ArquivosInteractiveChange()
706:         LOCAL loc_cGrupo
707: 
708:         IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
709:            !EMPTY(THIS.obj_4c_Arquivos.Value)
710:             loc_cGrupo = ALLTRIM(LEFT(THIS.obj_4c_Arquivos.Value, 3))
711:             THIS.this_oBusinessObject.FiltrarPorGrupo(loc_cGrupo)
712:             THIS.grd_4c_Dados.Refresh
713:         ENDIF
714:     ENDPROC
715: 
716:     *==========================================================================
717:     * ConfigurarGrdDados - Propriedades visuais pixel-perfect das colunas do grid
718:     *   BackColor por coluna, ReadOnly/Movable/Resizable, Text1 props, DynamicForeColor
719:     *==========================================================================
720:     PROTECTED PROCEDURE ConfigurarGrdDados(par_oGrd)
721:         LOCAL loc_oGrd
722:         loc_oGrd = par_oGrd
723: 
724:         *-- Coluna 1: Material (laranja - destaque)
725:         WITH loc_oGrd.Column1
726:             .BackColor  = RGB(255, 197, 138)
727:             .ReadOnly   = .T.
728:             .Movable    = .F.
729:             .Resizable  = .F.
730:             .FontName   = "Tahoma"
731:             .FontSize   = 8
732:             .Header1.Alignment = 2
733:             .Header1.FontName  = "Tahoma"
734:             .Header1.FontSize  = 8
735:             .Header1.ForeColor = RGB(0, 0, 0)
736:             .Text1.BackColor   = RGB(255, 197, 138)
737:             .Text1.ForeColor   = RGB(0, 0, 0)
738:             .Text1.BorderStyle = 0
739:             .Text1.Margin      = 0
740:             .Text1.ReadOnly    = .T.
741:             .Text1.FontName    = "Tahoma"
742:             .Text1.FontSize    = 8
743:         ENDWITH
744: 
745:         *-- Coluna 2: Descricao (branco)
746:         WITH loc_oGrd.Column2
747:             .BackColor  = RGB(255, 255, 255)
748:             .ReadOnly   = .T.
749:             .Movable    = .F.
750:             .Resizable  = .F.
751:             .FontName   = "Tahoma"
752:             .FontSize   = 8
753:             .Header1.Alignment = 2
754:             .Header1.FontName  = "Tahoma"
755:             .Header1.FontSize  = 8
756:             .Header1.ForeColor = RGB(0, 0, 0)
757:             .Text1.BackColor   = RGB(255, 255, 255)
758:             .Text1.ForeColor   = RGB(0, 0, 0)
759:             .Text1.BorderStyle = 0
760:             .Text1.Margin      = 0

*-- Linhas 938 a 1166:
938:     *==========================================================================
939:     * Destroy - Libera BO e cursores do form
940:     *==========================================================================
941:     PROCEDURE Destroy()
942:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
943:             THIS.this_oBusinessObject = .NULL.
944:         ENDIF
945: 
946:         LOCAL loc_aCursores(3), loc_i
947:         loc_aCursores(1) = "csRel"
948:         loc_aCursores(2) = "csCab"
949:         loc_aCursores(3) = "dbCabecalho"
950: 
951:         FOR loc_i = 1 TO 3
952:             IF USED(loc_aCursores(loc_i))
953:                 USE IN (loc_aCursores(loc_i))
954:             ENDIF
955:         ENDFOR
956: 
957:         DODEFAULT()
958:     ENDPROC
959: 
960:     *==========================================================================
961:     * BtnBuscarClick - Aciona processamento ou re-filtro do grid
962:     *   Form OPERACIONAL: se ainda nao processado, executa BtnProcessarClick.
963:     *   Se ja processado, re-aplica o filtro do grupo selecionado no listbox.
964:     *==========================================================================
965:     PROCEDURE BtnBuscarClick()
966:         IF !THIS.this_lProcessamento
967:             THIS.BtnProcessarClick()
968:         ELSE
969:             THIS.ArquivosInteractiveChange()
970:             THIS.grd_4c_Dados.Refresh
971:         ENDIF
972:     ENDPROC
973: 
974:     *==========================================================================
975:     * BtnEncerrarClick - Encerra o formulario
976:     *==========================================================================
977:     PROCEDURE BtnEncerrarClick()
978:         THIS.Release()
979:     ENDPROC
980: 
981:     *==========================================================================
982:     * BtnSalvarClick - Atualiza cabecalho do relatorio com grupo selecionado
983:     *   Form OPERACIONAL: nao ha registros editaveis para persistir no banco.
984:     *   Transfere o grupo ativo como subtitulo para o cursor csCab do relatorio.
985:     *==========================================================================
986:     PROCEDURE BtnSalvarClick()
987:         LOCAL loc_cSub
988:         loc_cSub = ""
989: 
990:         IF THIS.this_lProcessamento .AND. VARTYPE(THIS.this_oBusinessObject) = "O"
991:             IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
992:                !EMPTY(THIS.obj_4c_Arquivos.Value)
993:                 loc_cSub = ALLTRIM(THIS.obj_4c_Arquivos.Value)
994:             ENDIF
995:             THIS.this_oBusinessObject.AtualizarCabecalhoRelatorio(loc_cSub)
996:         ENDIF
997:     ENDPROC
998: 
999:     *==========================================================================
1000:     * BtnCancelarClick - Cancela processamento atual e reseta o form
1001:     *   Form OPERACIONAL: limpa o cursor csRel, o listbox de grupos e reseta
1002:     *   o flag de processamento para permitir novo ciclo.
1003:     *==========================================================================
1004:     PROCEDURE BtnCancelarClick()
1005:         IF THIS.this_lProcessamento
1006:             IF !MsgConfirma("Deseja cancelar o processamento atual?", ;
1007:                             "Confirma" + CHR(231) + CHR(227) + "o")
1008:                 RETURN
1009:             ENDIF
1010:         ENDIF
1011: 
1012:         THIS.LimparCampos()
1013:     ENDPROC
1014: 
1015:     *==========================================================================
1016:     * CarregarLista - Atualiza exibicao do grid com dados do cursor csRel
1017:     *   Form OPERACIONAL: nao executa SQL. Aplica filtro de grupo ativo se
1018:     *   houver um selecionado no listbox; caso contrario, remove filtro.
1019:     *==========================================================================
1020:     PROCEDURE CarregarLista()
1021:         IF !USED("csRel")
1022:             RETURN
1023:         ENDIF
1024: 
1025:         IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
1026:            !EMPTY(THIS.obj_4c_Arquivos.Value)
1027:             THIS.ArquivosInteractiveChange()
1028:         ELSE
1029:             SELECT csRel
1030:             SET ORDER TO TAG GruMat
1031:             SET KEY TO
1032:             GO TOP
1033:         ENDIF
1034: 
1035:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1036:             THIS.grd_4c_Dados.Refresh
1037:         ENDIF
1038:     ENDPROC
1039: 
1040:     *==========================================================================
1041:     * AjustarBotoesPorModo - Gerencia visibilidade de botoes conforme estado
1042:     *   Form OPERACIONAL: mostra/oculta os botoes de relatorio (Video,
1043:     *   Impressora, ShpRp) de acordo com o estado de processamento atual.
1044:     *==========================================================================
1045:     PROCEDURE AjustarBotoesPorModo()
1046:         LOCAL loc_lProcessado
1047:         loc_lProcessado = THIS.this_lProcessamento .AND. ;
1048:                           USED("csRel") .AND. RECCOUNT("csRel") > 0
1049: 
1050:         IF VARTYPE(THIS.shp_4c_ShpRp) = "O"
1051:             THIS.shp_4c_ShpRp.Visible = loc_lProcessado
1052:         ENDIF
1053:         IF VARTYPE(THIS.cmd_4c_CmdRpview) = "O"
1054:             THIS.cmd_4c_CmdRpview.Visible = loc_lProcessado
1055:         ENDIF
1056:         IF VARTYPE(THIS.cmd_4c_CmdRpPrint) = "O"
1057:             THIS.cmd_4c_CmdRpPrint.Visible = loc_lProcessado
1058:         ENDIF
1059:     ENDPROC
1060: 
1061:     *==========================================================================
1062:     * HabilitarCampos - Habilita/desabilita controles conforme estado
1063:     *   Form OPERACIONAL: controla o listbox de grupos (apenas quando ha
1064:     *   dados processados). Botao Processar permanece sempre habilitado.
1065:     *==========================================================================
1066:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1067:         IF VARTYPE(THIS.obj_4c_Arquivos) = "O"
1068:             THIS.obj_4c_Arquivos.Enabled = par_lHabilitar
1069:         ENDIF
1070:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
1071:             THIS.cmd_4c_Processar.Enabled = .T.
1072:         ENDIF
1073:     ENDPROC
1074: 
1075:     *==========================================================================
1076:     * LimparCampos - Limpa dados processados e reseta estado do form
1077:     *   Form OPERACIONAL: zera cursor csRel, limpa listbox, oculta botoes de
1078:     *   relatorio e reseta flags de processamento no form e no BO.
1079:     *==========================================================================
1080:     PROTECTED PROCEDURE LimparCampos()
1081:         IF USED("csRel")
1082:             SELECT csRel
1083:             SET KEY TO
1084:             ZAP
1085:         ENDIF
1086: 
1087:         IF USED("csCab")
1088:             SELECT csCab
1089:             ZAP
1090:             APPEND BLANK
1091:         ENDIF
1092: 
1093:         IF VARTYPE(THIS.obj_4c_Arquivos) = "O"
1094:             THIS.obj_4c_Arquivos.Clear()
1095:         ENDIF
1096: 
1097:         THIS.this_lProcessamento = .F.
1098: 
1099:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1100:             THIS.this_oBusinessObject.this_lProcessamento = .F.
1101:             THIS.this_oBusinessObject.this_cGrupoAtual    = ""
1102:         ENDIF
1103: 
1104:         THIS.AjustarBotoesPorModo()
1105: 
1106:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1107:             THIS.grd_4c_Dados.Refresh
1108:         ENDIF
1109:     ENDPROC
1110: 
1111:     *==========================================================================
1112:     * FormParaBO - Transfere estado do form para o Business Object
1113:     *   Form OPERACIONAL: transfere o grupo selecionado no listbox e o
1114:     *   subtitulo derivado para as propriedades correspondentes do BO.
1115:     *==========================================================================
1116:     PROTECTED PROCEDURE FormParaBO()
1117:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1118:             RETURN
1119:         ENDIF
1120: 
1121:         *-- Grupo selecionado no listbox -> BO
1122:         IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
1123:            !EMPTY(THIS.obj_4c_Arquivos.Value)
1124:             THIS.this_oBusinessObject.this_cGrupoAtual = ;
1125:                 ALLTRIM(LEFT(THIS.obj_4c_Arquivos.Value, 3))
1126:         ELSE
1127:             THIS.this_oBusinessObject.this_cGrupoAtual = ""
1128:         ENDIF
1129: 
1130:         *-- Subtitulo do relatorio = grupo ativo
1131:         THIS.this_oBusinessObject.this_cSubTitulo = ;
1132:             THIS.this_oBusinessObject.this_cGrupoAtual
1133:     ENDPROC
1134: 
1135:     *==========================================================================
1136:     * BOParaForm - Transfere estado do Business Object para o form
1137:     *   Form OPERACIONAL: sincroniza selecao do listbox de grupos com o
1138:     *   filtro ativo no BO e reaplica o filtro no cursor csRel.
1139:     *==========================================================================
1140:     PROTECTED PROCEDURE BOParaForm()
1141:         LOCAL loc_cGrupo, loc_i
1142: 
1143:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1144:             RETURN
1145:         ENDIF
1146: 
1147:         *-- Sincroniza selecao do listbox com grupo ativo no BO
1148:         IF !EMPTY(THIS.this_oBusinessObject.this_cGrupoAtual) .AND. ;
1149:            VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
1150:            THIS.obj_4c_Arquivos.ListCount > 0
1151:             loc_cGrupo = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoAtual)
1152:             FOR loc_i = 1 TO THIS.obj_4c_Arquivos.ListCount
1153:                 IF UPPER(LEFT(ALLTRIM(THIS.obj_4c_Arquivos.List(loc_i)), 3)) = UPPER(loc_cGrupo)
1154:                     THIS.obj_4c_Arquivos.ListIndex = loc_i
1155:                     EXIT
1156:                 ENDIF
1157:             ENDFOR
1158:         ENDIF
1159: 
1160:         *-- Reaplica filtro de grupo no cursor csRel
1161:         IF !EMPTY(THIS.this_oBusinessObject.this_cGrupoAtual)
1162:             THIS.this_oBusinessObject.FiltrarPorGrupo(THIS.this_oBusinessObject.this_cGrupoAtual)
1163:         ENDIF
1164:     ENDPROC
1165: 
1166: ENDDEFINE


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

