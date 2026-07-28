# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'ValidarEmpresaCec' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarEmpresaCec(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarTipoSerasa' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarTipoSerasa(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCec.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1381 linhas total):

*-- Linhas 23 a 133:
23:     this_cModoAtual      = "LISTA"
24: 
25:     *--------------------------------------------------------------------------
26:     PROCEDURE Init()
27:         LOCAL loc_lSucesso
28:         loc_lSucesso = .F.
29:         TRY
30:             loc_lSucesso = DODEFAULT()
31:         CATCH TO loc_oErro
32:             MsgErro("Erro ao inicializar FormCec:" + CHR(13) + loc_oErro.Message, "Erro")
33:         ENDTRY
34:         RETURN loc_lSucesso
35:     ENDPROC
36: 
37:     *--------------------------------------------------------------------------
38:     PROTECTED PROCEDURE InicializarForm()
39:         LOCAL loc_lSucesso
40:         loc_lSucesso = .F.
41: 
42:         TRY
43:             THIS.Caption = "Cadastro de Acesso a Consulta Gen" + CHR(233) + ;
44:                            "rica de Situa" + CHR(231) + CHR(227) + "o"
45: 
46:             THIS.this_oBusinessObject = CREATEOBJECT("CecBO")
47:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
48:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio CecBO", "Erro")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.ConfigurarPaginaLista()
52:                 THIS.ConfigurarPaginaDados()
53: 
54:                 THIS.pgf_4c_Paginas.Visible = .T.
55:                 THIS.pgf_4c_Paginas.ActivePage = 1
56:                 THIS.this_cModoAtual = "LISTA"
57: 
58:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
59:                     THIS.CarregarLista()
60:                 ENDIF
61: 
62:                 loc_lSucesso = .T.
63:             ENDIF
64:         CATCH TO loc_oErro
65:             MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message, "Erro")
66:         ENDTRY
67: 
68:         RETURN loc_lSucesso
69:     ENDPROC
70: 
71:     *--------------------------------------------------------------------------
72:     PROTECTED PROCEDURE ConfigurarPageFrame()
73:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
74:         WITH THIS.pgf_4c_Paginas
75:             .Top        = -29
76:             .Left       = 0
77:             .Width      = THIS.Width
78:             .Height     = THIS.Height + 29
79:             .PageCount  = 2
80:             .Tabs       = .F.
81:             .TabStretch = 1
82:             .Page1.Caption   = "Lista"
83:             .Page1.BackColor = RGB(255, 255, 255)
84:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
85:             .Page2.Caption   = "Dados"
86:             .Page2.BackColor = RGB(255, 255, 255)
87:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
88:             .Visible = .T.
89:         ENDWITH
90:     ENDPROC
91: 
92:     *--------------------------------------------------------------------------
93:     PROTECTED PROCEDURE ConfigurarPaginaLista()
94:         LOCAL loc_oPagina, loc_oCab, loc_oCnt, loc_oGrid
95:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
96: 
97:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
98:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99: 
100:         *-- Cabecalho cinza (cntSombra no legado) - Top compensado +29 pelo PageFrame.Top=-29
101:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
102:         loc_oCab = loc_oPagina.cnt_4c_Cabecalho
103:         WITH loc_oCab
104:             .Top         = 31
105:             .Left        = 0
106:             .Width       = THIS.Width
107:             .Height      = 80
108:             .BackColor   = RGB(100, 100, 100)
109:             .BorderWidth = 0
110:             .Visible     = .T.
111:         ENDWITH
112: 
113:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
114:         WITH loc_oCab.lbl_4c_Sombra
115:             .Caption   = THIS.Caption
116:             .Top       = 15
117:             .Left      = 10
118:             .Width     = THIS.Width
119:             .Height    = 40
120:             .FontName  = "Tahoma"
121:             .FontSize  = 16
122:             .FontBold  = .T.
123:             .ForeColor = RGB(0, 0, 0)
124:             .BackStyle = 0
125:             .AutoSize  = .F.
126:             .Visible   = .T.
127:         ENDWITH
128: 
129:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
130:         WITH loc_oCab.lbl_4c_Titulo
131:             .Caption   = THIS.Caption
132:             .Top       = 18
133:             .Left      = 10

*-- Linhas 178 a 532:
178:             .AutoSize        = .F.
179:             .Visible         = .T.
180:         ENDWITH
181:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
182: 
183:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
184:         WITH loc_oCnt.cmd_4c_Visualizar
185:             .Caption         = "Visualizar"
186:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
187:             .PicturePosition = 13
188:             .Top             = 5
189:             .Left            = 80
190:             .Width           = 75
191:             .Height          = 75
192:             .FontName        = "Comic Sans MS"
193:             .FontSize        = 8
194:             .FontBold        = .T.
195:             .FontItalic      = .T.
196:             .ForeColor       = RGB(90, 90, 90)
197:             .BackColor       = RGB(255, 255, 255)
198:             .Themes          = .F.
199:             .SpecialEffect   = 0
200:             .MousePointer    = 15
201:             .WordWrap        = .T.
202:             .AutoSize        = .F.
203:             .Visible         = .T.
204:         ENDWITH
205:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
206: 
207:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
208:         WITH loc_oCnt.cmd_4c_Alterar
209:             .Caption         = "Alterar"
210:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
211:             .PicturePosition = 13
212:             .Top             = 5
213:             .Left            = 155
214:             .Width           = 75
215:             .Height          = 75
216:             .FontName        = "Comic Sans MS"
217:             .FontSize        = 8
218:             .FontBold        = .T.
219:             .FontItalic      = .T.
220:             .ForeColor       = RGB(90, 90, 90)
221:             .BackColor       = RGB(255, 255, 255)
222:             .Themes          = .F.
223:             .SpecialEffect   = 0
224:             .MousePointer    = 15
225:             .WordWrap        = .T.
226:             .AutoSize        = .F.
227:             .Visible         = .T.
228:         ENDWITH
229:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
230: 
231:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
232:         WITH loc_oCnt.cmd_4c_Excluir
233:             .Caption         = "Excluir"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
235:             .PicturePosition = 13
236:             .Top             = 5
237:             .Left            = 230
238:             .Width           = 75
239:             .Height          = 75
240:             .FontName        = "Comic Sans MS"
241:             .FontSize        = 8
242:             .FontBold        = .T.
243:             .FontItalic      = .T.
244:             .ForeColor       = RGB(90, 90, 90)
245:             .BackColor       = RGB(255, 255, 255)
246:             .Themes          = .F.
247:             .SpecialEffect   = 0
248:             .MousePointer    = 15
249:             .WordWrap        = .T.
250:             .AutoSize        = .F.
251:             .Visible         = .T.
252:         ENDWITH
253:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
254: 
255:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
256:         WITH loc_oCnt.cmd_4c_Buscar
257:             .Caption         = "Buscar"
258:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
259:             .PicturePosition = 13
260:             .Top             = 5
261:             .Left            = 305
262:             .Width           = 75
263:             .Height          = 75
264:             .FontName        = "Comic Sans MS"
265:             .FontSize        = 8
266:             .FontBold        = .T.
267:             .FontItalic      = .T.
268:             .ForeColor       = RGB(90, 90, 90)
269:             .BackColor       = RGB(255, 255, 255)
270:             .Themes          = .F.
271:             .SpecialEffect   = 0
272:             .MousePointer    = 15
273:             .WordWrap        = .T.
274:             .AutoSize        = .F.
275:             .Visible         = .T.
276:         ENDWITH
277:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
278: 
279:         *-- Container saida - padrao canonico: Left=917, Width=90
280:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
281:         WITH loc_oPagina.cnt_4c_Saida
282:             .Top         = 29
283:             .Left        = 917
284:             .Width       = 90
285:             .Height      = 85
286:             .BackStyle   = 0
287:             .BorderWidth = 0
288:             .Visible     = .T.
289:         ENDWITH
290: 
291:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
292:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
293:             .Caption         = "Encerrar"
294:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
295:             .PicturePosition = 13
296:             .Top             = 5
297:             .Left            = 5
298:             .Width           = 75
299:             .Height          = 75
300:             .FontName        = "Comic Sans MS"
301:             .FontSize        = 8
302:             .FontBold        = .T.
303:             .FontItalic      = .T.
304:             .ForeColor       = RGB(90, 90, 90)
305:             .BackColor       = RGB(255, 255, 255)
306:             .Themes          = .F.
307:             .SpecialEffect   = 0
308:             .MousePointer    = 15
309:             .WordWrap        = .T.
310:             .AutoSize        = .F.
311:             .Visible         = .T.
312:         ENDWITH
313:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
314: 
315:         *-- Grid da lista - colunas: Emps (Emp.), Razas (Razao Social), Tipos (Rede)
316:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
317:         loc_oGrid = loc_oPagina.grd_4c_Lista
318:         loc_oGrid.Top         = 117
319:         loc_oGrid.Left        = 12
320:         loc_oGrid.Width       = 890
321:         loc_oGrid.Height      = 450
322:         loc_oGrid.ColumnCount = 3
323:         WITH loc_oGrid
324:             .FontName           = "Verdana"
325:             .FontSize           = 8
326:             .ForeColor          = RGB(90, 90, 90)
327:             .BackColor          = RGB(255, 255, 255)
328:             .GridLineColor      = RGB(238, 238, 238)
329:             .HighlightBackColor = RGB(255, 255, 255)
330:             .HighlightForeColor = RGB(15, 41, 104)
331:             .HighlightStyle     = 2
332:             .DeleteMark         = .F.
333:             .RecordMark         = .F.
334:             .RowHeight          = 16
335:             .ScrollBars         = 2
336:             .GridLines          = 3
337:             .ReadOnly           = .T.
338:             .Visible            = .T.
339:         ENDWITH
340: 
341:         THIS.TornarControlesVisiveis(loc_oPagina)
342:     ENDPROC
343: 
344:     *--------------------------------------------------------------------------
345:     PROTECTED PROCEDURE ConfigurarPaginaDados()
346:         LOCAL loc_oPagina, loc_oCnt
347:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
348: 
349:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
350:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
351: 
352:         *-- Container botoes salvar/cancelar (grupo_salva no legado)
353:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
354:         WITH loc_oPagina.cnt_4c_Salva
355:             .Top         = 33
356:             .Left        = 842
357:             .Width       = 160
358:             .Height      = 85
359:             .BackStyle   = 0
360:             .Visible     = .T.
361:         ENDWITH
362: 
363:         loc_oCnt = loc_oPagina.cnt_4c_Salva
364: 
365:         loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
366:         WITH loc_oCnt.cmd_4c_Confirmar
367:             .Caption         = "Confirmar"
368:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
369:             .PicturePosition = 13
370:             .Top             = 5
371:             .Left            = 5
372:             .Width           = 75
373:             .Height          = 75
374:             .FontName        = "Comic Sans MS"
375:             .FontSize        = 8
376:             .FontBold        = .T.
377:             .FontItalic      = .T.
378:             .ForeColor       = RGB(90, 90, 90)
379:             .BackColor       = RGB(255, 255, 255)
380:             .Themes          = .F.
381:             .SpecialEffect   = 0
382:             .MousePointer    = 15
383:             .WordWrap        = .T.
384:             .AutoSize        = .F.
385:             .Visible         = .T.
386:         ENDWITH
387:         BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
388: 
389:         loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
390:         WITH loc_oCnt.cmd_4c_Cancelar
391:             .Caption         = "Encerrar"
392:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
393:             .PicturePosition = 13
394:             .Top             = 5
395:             .Left            = 80
396:             .Width           = 75
397:             .Height          = 75
398:             .FontName        = "Comic Sans MS"
399:             .FontSize        = 8
400:             .FontBold        = .T.
401:             .FontItalic      = .T.
402:             .ForeColor       = RGB(90, 90, 90)
403:             .BackColor       = RGB(255, 255, 255)
404:             .Themes          = .F.
405:             .SpecialEffect   = 0
406:             .MousePointer    = 15
407:             .WordWrap        = .T.
408:             .AutoSize        = .F.
409:             .Visible         = .T.
410:         ENDWITH
411:         BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
412: 
413:         *----------------------------------------------------------------------
414:         *-- EMPRESA (Labelocup2 + getEmpresa + getDesEmpresa)
415:         *-- getEmpresa.When: somente INSERIR/PROCURAR; getDesEmpresa.When: quando getEmpresa vazio
416:         *----------------------------------------------------------------------
417:         loc_oPagina.AddObject("lbl_4c_Ocup2", "Label")
418:         WITH loc_oPagina.lbl_4c_Ocup2
419:             .Caption   = "Empresa :"
420:             .Top       = 86
421:             .Left      = 188
422:             .Width     = 90
423:             .Height    = 17
424:             .FontName  = "Tahoma"
425:             .FontSize  = 8
426:             .ForeColor = RGB(90, 90, 90)
427:             .BackStyle = 0
428:             .AutoSize  = .F.
429:             .Visible   = .T.
430:         ENDWITH
431: 
432:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
433:         WITH loc_oPagina.txt_4c_Empresa
434:             .Value     = ""
435:             .Top       = 84
436:             .Left      = 240
437:             .Width     = 31
438:             .Height    = 23
439:             .FontName  = "Tahoma"
440:             .FontSize  = 8
441:             .MaxLength = 3
442:             .Visible   = .T.
443:         ENDWITH
444:         BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "ValidarEmpresaCec")
445: 
446:         loc_oPagina.AddObject("txt_4c_DesEmpresa", "TextBox")
447:         WITH loc_oPagina.txt_4c_DesEmpresa
448:             .Value     = ""
449:             .Top       = 84
450:             .Left      = 273
451:             .Width     = 290
452:             .Height    = 23
453:             .FontName  = "Tahoma"
454:             .FontSize  = 8
455:             .ReadOnly  = .T.
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         *----------------------------------------------------------------------
460:         *-- TIPO (Labelocup1 + cmbTCons)
461:         *-- cmbTCons.When: somente INSERIR/PROCURAR
462:         *----------------------------------------------------------------------
463:         loc_oPagina.AddObject("lbl_4c_Ocup1", "Label")
464:         WITH loc_oPagina.lbl_4c_Ocup1
465:             .Caption   = "Tipo :"
466:             .Top       = 111
467:             .Left      = 209
468:             .Width     = 50
469:             .Height    = 17
470:             .FontName  = "Tahoma"
471:             .FontSize  = 8
472:             .ForeColor = RGB(90, 90, 90)
473:             .BackStyle = 0
474:             .AutoSize  = .F.
475:             .Visible   = .T.
476:         ENDWITH
477: 
478:         loc_oPagina.AddObject("cbo_4c_CmbTCons", "ComboBox")
479:         WITH loc_oPagina.cbo_4c_CmbTCons
480:             .Value         = ""
481:             .Top           = 108
482:             .Left          = 240
483:             .Width         = 115
484:             .Height        = 24
485:             .FontName      = "Tahoma"
486:             .FontSize      = 8
487:             .RowSourceType = 1
488:             .RowSource     = "CHEQUE PRE,SERASA,ACSP"
489:             .Style         = 2
490:             .Visible       = .T.
491:         ENDWITH
492:         BINDEVENT(loc_oPagina.cbo_4c_CmbTCons, "InteractiveChange", THIS, "TipoConsultaChanged")
493: 
494:         *----------------------------------------------------------------------
495:         *-- CONTRATO (Labelocup3 + GetContrato)
496:         *-- GetContrato.When: somente quando Tipos = "CHEQUE PRE" E INSERIR/ALTERAR
497:         *----------------------------------------------------------------------
498:         loc_oPagina.AddObject("lbl_4c_Ocup3", "Label")
499:         WITH loc_oPagina.lbl_4c_Ocup3
500:             .Caption   = "Contrato :"
501:             .Top       = 135
502:             .Left      = 186
503:             .Width     = 70
504:             .Height    = 17
505:             .FontName  = "Tahoma"
506:             .FontSize  = 8
507:             .ForeColor = RGB(90, 90, 90)
508:             .BackStyle = 0
509:             .AutoSize  = .F.
510:             .Visible   = .T.
511:         ENDWITH
512: 
513:         loc_oPagina.AddObject("txt_4c_Contrato", "TextBox")
514:         WITH loc_oPagina.txt_4c_Contrato
515:             .Value     = ""
516:             .Top       = 133
517:             .Left      = 239
518:             .Width     = 365
519:             .Height    = 23
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .MaxLength = 100
523:             .Visible   = .T.
524:         ENDWITH
525: 
526:         *----------------------------------------------------------------------
527:         *-- CODIGO DA REDE (Labelocup5 + GetRede)
528:         *-- GetRede.When: somente quando Tipos = "CHEQUE PRE" E INSERIR/ALTERAR
529:         *----------------------------------------------------------------------
530:         loc_oPagina.AddObject("lbl_4c_Ocup5", "Label")
531:         WITH loc_oPagina.lbl_4c_Ocup5
532:             .Caption   = "Codigo da Rede :"

*-- Linhas 684 a 727:
684:             .MaxLength = 2
685:             .Visible   = .T.
686:         ENDWITH
687:         BINDEVENT(loc_oPagina.txt_4c_Fwget1, "KeyPress", THIS, "ValidarTipoSerasa")
688: 
689:         *----------------------------------------------------------------------
690:         *-- VALOR MINIMO (Labelocup9 + GetValMin)
691:         *----------------------------------------------------------------------
692:         loc_oPagina.AddObject("lbl_4c_Ocup9", "Label")
693:         WITH loc_oPagina.lbl_4c_Ocup9
694:             .Caption   = "Valor Minimo :"
695:             .Top       = 281
696:             .Left      = 170
697:             .Width     = 95
698:             .Height    = 17
699:             .FontName  = "Tahoma"
700:             .FontSize  = 8
701:             .ForeColor = RGB(90, 90, 90)
702:             .BackStyle = 0
703:             .AutoSize  = .F.
704:             .Visible   = .T.
705:         ENDWITH
706: 
707:         loc_oPagina.AddObject("txt_4c_ValMin", "TextBox")
708:         WITH loc_oPagina.txt_4c_ValMin
709:             .Value     = 0
710:             .Top       = 279
711:             .Left      = 240
712:             .Width     = 130
713:             .Height    = 23
714:             .FontName  = "Tahoma"
715:             .FontSize  = 8
716:             .Format    = "N"
717:             .InputMask = "999999999.99"
718:             .Visible   = .T.
719:         ENDWITH
720: 
721:         *----------------------------------------------------------------------
722:         *-- VALOR FIXO (Labelocup10 + GetValFix)
723:         *----------------------------------------------------------------------
724:         loc_oPagina.AddObject("lbl_4c_Ocup10", "Label")
725:         WITH loc_oPagina.lbl_4c_Ocup10
726:             .Caption   = "Valor Fixo :"
727:             .Top       = 305

*-- Linhas 876 a 1381:
876:             .Visible      = .T.
877:         ENDWITH
878: 
879:         THIS.TornarControlesVisiveis(loc_oPagina)
880:     ENDPROC
881: 
882:     *--------------------------------------------------------------------------
883:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
884:         LOCAL loc_nI, loc_oObjeto, loc_nP
885: 
886:         FOR loc_nI = 1 TO par_oContainer.ControlCount
887:             loc_oObjeto = par_oContainer.Controls(loc_nI)
888:             IF VARTYPE(loc_oObjeto) = "O"
889:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
890:                     loc_oObjeto.Visible = .T.
891:                 ENDIF
892:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
893:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
894:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
895:                     ENDFOR
896:                 ENDIF
897:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
898:                     THIS.TornarControlesVisiveis(loc_oObjeto)
899:                 ENDIF
900:             ENDIF
901:         ENDFOR
902:     ENDPROC
903: 
904:     *--------------------------------------------------------------------------
905:     PROCEDURE CarregarLista()
906:         LOCAL loc_lResultado, loc_oGrid
907:         loc_lResultado = .F.
908: 
909:         TRY
910:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
911:                 loc_lResultado = .T.
912:             ELSE
913:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
914: 
915:                 IF THIS.this_oBusinessObject.Buscar("")
916:                     loc_oGrid.ColumnCount = 3
917:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
918:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Emps"
919:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Razas"
920:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Tipos"
921:                     loc_oGrid.Column1.Width          = 50
922:                     loc_oGrid.Column2.Width          = 300
923:                     loc_oGrid.Column3.Width          = 150
924:                     loc_oGrid.Column1.Header1.Caption = "Emp."
925:                     loc_oGrid.Column2.Header1.Caption = "Razao Social"
926:                     loc_oGrid.Column3.Header1.Caption = "Rede"
927:                     THIS.FormatarGridLista(loc_oGrid)
928:                     loc_lResultado = .T.
929:                 ENDIF
930:             ENDIF
931:         CATCH TO loc_oErro
932:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
933:         ENDTRY
934: 
935:         RETURN loc_lResultado
936:     ENDPROC
937: 
938:     *--------------------------------------------------------------------------
939:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
940:         WITH par_oGrid
941:             .FontName = "Tahoma"
942:             .FontSize = 8
943:         ENDWITH
944:     ENDPROC
945: 
946:     *--------------------------------------------------------------------------
947:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
948:         LOCAL loc_lResultado
949:         loc_lResultado = .F.
950: 
951:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
952:             RETURN .F.
953:         ENDIF
954: 
955:         TRY
956:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
957:             IF par_nPagina = 1
958:                 THIS.CarregarLista()
959:             ENDIF
960:             loc_lResultado = .T.
961:         CATCH TO loc_oErro
962:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
963:         ENDTRY
964: 
965:         RETURN loc_lResultado
966:     ENDPROC
967: 
968:     *--------------------------------------------------------------------------
969:     PROCEDURE BtnIncluirClick()
970:         THIS.this_oBusinessObject.NovoRegistro()
971:         THIS.LimparCampos()
972:         THIS.this_cModoAtual = "INCLUIR"
973:         THIS.HabilitarCampos(.T.)
974:         THIS.AjustarBotoesPorModo()
975:         THIS.AlternarPagina(2)
976:     ENDPROC
977: 
978:     *--------------------------------------------------------------------------
979:     PROCEDURE BtnVisualizarClick()
980:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
981:             MsgAviso("Selecione um registro na lista.", "Aviso")
982:             RETURN
983:         ENDIF
984: 
985:         SELECT cursor_4c_Dados
986:         IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cIdChaves))
987:             THIS.BOParaForm()
988:             THIS.this_cModoAtual = "VISUALIZAR"
989:             THIS.HabilitarCampos(.F.)
990:             THIS.AjustarBotoesPorModo()
991:             THIS.AlternarPagina(2)
992:         ELSE
993:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
994:         ENDIF
995:     ENDPROC
996: 
997:     *--------------------------------------------------------------------------
998:     PROCEDURE BtnAlterarClick()
999:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1000:             MsgAviso("Selecione um registro na lista.", "Aviso")
1001:             RETURN
1002:         ENDIF
1003: 
1004:         SELECT cursor_4c_Dados
1005:         IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cIdChaves))
1006:             THIS.this_oBusinessObject.EditarRegistro()
1007:             THIS.BOParaForm()
1008:             THIS.this_cModoAtual = "ALTERAR"
1009:             THIS.HabilitarCampos(.T.)
1010:             THIS.AjustarBotoesPorModo()
1011:             THIS.AlternarPagina(2)
1012:         ELSE
1013:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
1014:         ENDIF
1015:     ENDPROC
1016: 
1017:     *--------------------------------------------------------------------------
1018:     PROCEDURE BtnExcluirClick()
1019:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1020:             MsgAviso("Selecione um registro na lista.", "Aviso")
1021:             RETURN
1022:         ENDIF
1023: 
1024:         SELECT cursor_4c_Dados
1025:         IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cIdChaves))
1026:             THIS.BOParaForm()
1027:             THIS.this_cModoAtual = "EXCLUIR"
1028:             THIS.HabilitarCampos(.F.)
1029:             THIS.AjustarBotoesPorModo()
1030:             THIS.AlternarPagina(2)
1031:         ELSE
1032:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
1033:         ENDIF
1034:     ENDPROC
1035: 
1036:     *--------------------------------------------------------------------------
1037:     PROCEDURE BtnBuscarClick()
1038:         THIS.LimparCampos()
1039:         THIS.this_cModoAtual = "BUSCAR"
1040:         THIS.HabilitarCampos(.T.)
1041:         THIS.AlternarPagina(2)
1042:     ENDPROC
1043: 
1044:     *--------------------------------------------------------------------------
1045:     PROCEDURE BtnEncerrarClick()
1046:         THIS.Release()
1047:     ENDPROC
1048: 
1049:     *--------------------------------------------------------------------------
1050:     PROCEDURE BtnSalvarClick()
1051:         LOCAL loc_oPagina, loc_cTipo, loc_lSucesso
1052:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1053: 
1054:         *-- Modo EXCLUIR: confirma e exclui sem validar campos
1055:         IF THIS.this_cModoAtual = "EXCLUIR"
1056:             IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", "Confirmar")
1057:                 loc_lSucesso = .F.
1058:                 TRY
1059:                     IF THIS.this_oBusinessObject.Excluir()
1060:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1061:                         THIS.this_cModoAtual = "LISTA"
1062:                         THIS.AlternarPagina(1)
1063:                         THIS.CarregarLista()
1064:                         loc_lSucesso = .T.
1065:                     ENDIF
1066:                 CATCH TO loc_oErro
1067:                     MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "Erro")
1068:                 ENDTRY
1069:             ENDIF
1070:             RETURN
1071:         ENDIF
1072: 
1073:         *-- Modo VISUALIZAR: apenas volta para lista
1074:         IF THIS.this_cModoAtual = "VISUALIZAR"
1075:             THIS.this_cModoAtual = "LISTA"
1076:             THIS.AlternarPagina(1)
1077:             RETURN
1078:         ENDIF
1079: 
1080:         *-- Modos INCLUIR / ALTERAR / PROCURAR / BUSCAR: validar e salvar
1081:         loc_cTipo = ALLTRIM(loc_oPagina.cbo_4c_CmbTCons.Value)
1082: 
1083:         IF EMPTY(loc_cTipo)
1084:             MsgAviso("Tipo da Consulta " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aviso")
1085:             loc_oPagina.cbo_4c_CmbTCons.SetFocus()
1086:             RETURN
1087:         ENDIF
1088: 
1089:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Empresa.Value))
1090:             MsgAviso("Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Aviso")
1091:             loc_oPagina.txt_4c_Empresa.SetFocus()
1092:             RETURN
1093:         ENDIF
1094: 
1095:         IF loc_cTipo == "CHEQUE PRE"
1096:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Contrato.Value))
1097:                 MsgAviso("Contrato " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aviso")
1098:                 loc_oPagina.txt_4c_Contrato.SetFocus()
1099:                 RETURN
1100:             ENDIF
1101:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Rede.Value))
1102:                 MsgAviso("C" + CHR(243) + "digo de Rede " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aviso")
1103:                 loc_oPagina.txt_4c_Rede.SetFocus()
1104:                 RETURN
1105:             ENDIF
1106:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Loja.Value))
1107:                 MsgAviso("C" + CHR(243) + "digo da Loja " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aviso")
1108:                 loc_oPagina.txt_4c_Loja.SetFocus()
1109:                 RETURN
1110:             ENDIF
1111:         ELSE
1112:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Logon.Value))
1113:                 MsgAviso("Logon " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aviso")
1114:                 loc_oPagina.txt_4c_Logon.SetFocus()
1115:                 RETURN
1116:             ENDIF
1117:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Senha.Value))
1118:                 MsgAviso("Senha " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Aviso")
1119:                 loc_oPagina.txt_4c_Senha.SetFocus()
1120:                 RETURN
1121:             ENDIF
1122:             IF loc_cTipo == "SERASA"
1123:                 LOCAL loc_cTpSer
1124:                 loc_cTpSer = ALLTRIM(loc_oPagina.txt_4c_Fwget1.Value)
1125:                 IF !EMPTY(loc_cTpSer) AND !INLIST(loc_cTpSer, "CP", "CH")
1126:                     MsgAviso("Tipo de Consulta Inv" + CHR(225) + "lida, Informar CP ou CH !!!", "Aviso")
1127:                     loc_oPagina.txt_4c_Fwget1.SetFocus()
1128:                     RETURN
1129:                 ENDIF
1130:             ENDIF
1131:         ENDIF
1132: 
1133:         THIS.FormParaBO()
1134: 
1135:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR")
1136:             IF THIS.this_oBusinessObject.VerificarDuplicidade()
1137:                 MsgAviso("J" + CHR(225) + " existe um registro para esta Empresa e Tipo de Consulta.", "Aviso")
1138:                 RETURN
1139:             ENDIF
1140:         ENDIF
1141: 
1142:         loc_lSucesso = .F.
1143:         TRY
1144:             IF THIS.this_oBusinessObject.Salvar()
1145:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
1146:                 THIS.this_cModoAtual = "LISTA"
1147:                 THIS.AlternarPagina(1)
1148:                 THIS.CarregarLista()
1149:                 loc_lSucesso = .T.
1150:             ENDIF
1151:         CATCH TO loc_oErro
1152:             MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
1153:         ENDTRY
1154:     ENDPROC
1155: 
1156:     *--------------------------------------------------------------------------
1157:     PROCEDURE BtnCancelarClick()
1158:         THIS.this_cModoAtual = "LISTA"
1159:         THIS.AlternarPagina(1)
1160:         THIS.CarregarLista()
1161:     ENDPROC
1162: 
1163:     *--------------------------------------------------------------------------
1164:     PROCEDURE ValidarEmpresaCec(par_nKeyCode, par_nShiftAltCtrl)
1165:         LOCAL loc_oPagina, loc_cEmpresa, loc_cSQL, loc_nRes, loc_oBusca
1166:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
1167:         loc_cEmpresa = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
1168: 
1169:         loc_oPagina.txt_4c_DesEmpresa.Value = ""
1170: 
1171:         IF EMPTY(loc_cEmpresa)
1172:             RETURN
1173:         ENDIF
1174: 
1175:         TRY
1176:             loc_cSQL = "SELECT cEmps, Razas FROM SigCdEmp WHERE cEmps = " + EscaparSQL(loc_cEmpresa)
1177:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
1178: 
1179:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Emp") > 0
1180:                 SELECT cursor_4c_Emp
1181:                 loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_Emp.Razas)
1182:             ELSE
1183:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1184:                     "cursor_4c_EmpBusca", "cEmps", loc_cEmpresa, "Empresa")
1185:                 IF VARTYPE(loc_oBusca) = "O"
1186:                     loc_oBusca.mAddColuna("cEmps", "", "C" + CHR(243) + "digo")
1187:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1188:                     loc_oBusca.Show()
1189:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_EmpBusca")
1190:                         SELECT cursor_4c_EmpBusca
1191:                         loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_EmpBusca.cEmps)
1192:                         loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_EmpBusca.Razas)
1193:                     ELSE
1194:                         loc_oPagina.txt_4c_Empresa.Value = ""
1195:                     ENDIF
1196:                     loc_oBusca.Release()
1197:                     IF USED("cursor_4c_EmpBusca")
1198:                         USE IN cursor_4c_EmpBusca
1199:                     ENDIF
1200:                 ENDIF
1201:             ENDIF
1202: 
1203:             IF USED("cursor_4c_Emp")
1204:                 USE IN cursor_4c_Emp
1205:             ENDIF
1206:         CATCH TO loc_oErro
1207:             MsgErro("Erro ao validar empresa:" + CHR(13) + loc_oErro.Message, "Erro")
1208:             IF USED("cursor_4c_Emp")
1209:                 USE IN cursor_4c_Emp
1210:             ENDIF
1211:             IF USED("cursor_4c_EmpBusca")
1212:                 USE IN cursor_4c_EmpBusca
1213:             ENDIF
1214:         ENDTRY
1215:     ENDPROC
1216: 
1217:     *--------------------------------------------------------------------------
1218:     PROCEDURE TipoConsultaChanged()
1219:         LOCAL loc_oPagina, loc_cTipo, loc_lChequePre
1220:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
1221:         loc_cTipo      = ALLTRIM(loc_oPagina.cbo_4c_CmbTCons.Value)
1222:         loc_lChequePre = (loc_cTipo == "CHEQUE PRE")
1223: 
1224:         *-- Campos somente CHEQUE PRE
1225:         loc_oPagina.txt_4c_Contrato.Visible = loc_lChequePre
1226:         loc_oPagina.lbl_4c_Ocup3.Visible    = loc_lChequePre
1227:         loc_oPagina.txt_4c_Rede.Visible     = loc_lChequePre
1228:         loc_oPagina.lbl_4c_Ocup5.Visible    = loc_lChequePre
1229:         loc_oPagina.txt_4c_Loja.Visible     = loc_lChequePre
1230:         loc_oPagina.lbl_4c_Ocup6.Visible    = loc_lChequePre
1231: 
1232:         *-- Campos somente nao CHEQUE PRE
1233:         loc_oPagina.txt_4c_Logon.Visible   = !loc_lChequePre
1234:         loc_oPagina.lbl_4c_Ocup4.Visible   = !loc_lChequePre
1235:         loc_oPagina.txt_4c_Senha.Visible   = !loc_lChequePre
1236:         loc_oPagina.lbl_4c_Ocup7.Visible   = !loc_lChequePre
1237: 
1238:         *-- Campo somente SERASA
1239:         loc_oPagina.txt_4c_Fwget1.Visible  = (loc_cTipo == "SERASA")
1240:         loc_oPagina.lbl_4c_Ocup12.Visible  = (loc_cTipo == "SERASA")
1241:     ENDPROC
1242: 
1243:     *--------------------------------------------------------------------------
1244:     PROTECTED PROCEDURE AtualizarVisibilidadeCampos()
1245:         THIS.TipoConsultaChanged()
1246:     ENDPROC
1247: 
1248:     *--------------------------------------------------------------------------
1249:     PROTECTED PROCEDURE FormParaBO()
1250:         LOCAL loc_oPagina
1251:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1252: 
1253:         THIS.this_oBusinessObject.this_cEmps   = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
1254:         THIS.this_oBusinessObject.this_cRazas  = ALLTRIM(loc_oPagina.txt_4c_DesEmpresa.Value)
1255:         THIS.this_oBusinessObject.this_cTipos  = ALLTRIM(loc_oPagina.cbo_4c_CmbTCons.Value)
1256:         THIS.this_oBusinessObject.this_cCtr       = ALLTRIM(loc_oPagina.txt_4c_Contrato.Value)
1257:         THIS.this_oBusinessObject.this_cRde       = ALLTRIM(loc_oPagina.txt_4c_Rede.Value)
1258:         THIS.this_oBusinessObject.this_cRdeLja    = ALLTRIM(loc_oPagina.txt_4c_Loja.Value)
1259:         THIS.this_oBusinessObject.this_cLogon     = ALLTRIM(loc_oPagina.txt_4c_Logon.Value)
1260:         THIS.this_oBusinessObject.this_cSenha     = ALLTRIM(loc_oPagina.txt_4c_Senha.Value)
1261:         THIS.this_oBusinessObject.this_cCTipos    = ALLTRIM(loc_oPagina.txt_4c_Fwget1.Value)
1262:         THIS.this_oBusinessObject.this_nVlrMin    = loc_oPagina.txt_4c_ValMin.Value
1263:         THIS.this_oBusinessObject.this_nVlrFixo   = loc_oPagina.txt_4c_ValFix.Value
1264:         THIS.this_oBusinessObject.this_cCipchps   = ALLTRIM(loc_oPagina.txt_4c_Ip.Value)
1265:         THIS.this_oBusinessObject.this_nPortachps = loc_oPagina.txt_4c_Porta.Value
1266:         THIS.this_oBusinessObject.this_cUsuProxys = ALLTRIM(loc_oPagina.txt_4c_UsuProxy.Value)
1267:         THIS.this_oBusinessObject.this_cSenProxys = ALLTRIM(loc_oPagina.txt_4c_SenProxy.Value)
1268:     ENDPROC
1269: 
1270:     *--------------------------------------------------------------------------
1271:     PROTECTED PROCEDURE BOParaForm()
1272:         LOCAL loc_oPagina
1273:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1274: 
1275:         loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
1276:         loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(THIS.this_oBusinessObject.this_cRazas)
1277:         loc_oPagina.cbo_4c_CmbTCons.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
1278:         loc_oPagina.txt_4c_Contrato.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cCtr)
1279:         loc_oPagina.txt_4c_Rede.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cRde)
1280:         loc_oPagina.txt_4c_Loja.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cRdeLja)
1281:         loc_oPagina.txt_4c_Logon.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cLogon)
1282:         loc_oPagina.txt_4c_Senha.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cSenha)
1283:         loc_oPagina.txt_4c_Fwget1.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cCTipos)
1284:         loc_oPagina.txt_4c_ValMin.Value     = THIS.this_oBusinessObject.this_nVlrMin
1285:         loc_oPagina.txt_4c_ValFix.Value     = THIS.this_oBusinessObject.this_nVlrFixo
1286:         loc_oPagina.txt_4c_Ip.Value         = ALLTRIM(THIS.this_oBusinessObject.this_cCipchps)
1287:         loc_oPagina.txt_4c_Porta.Value      = THIS.this_oBusinessObject.this_nPortachps
1288:         loc_oPagina.txt_4c_UsuProxy.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cUsuProxys)
1289:         loc_oPagina.txt_4c_SenProxy.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cSenProxys)
1290:         THIS.AtualizarVisibilidadeCampos()
1291:     ENDPROC
1292: 
1293:     *--------------------------------------------------------------------------
1294:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1295:         LOCAL loc_oPagina
1296:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1297: 
1298:         *-- Empresa: editavel somente em INCLUIR/PROCURAR/BUSCAR
1299:         loc_oPagina.txt_4c_Empresa.ReadOnly    = !INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR", "BUSCAR")
1300:         loc_oPagina.txt_4c_DesEmpresa.ReadOnly = .T.
1301:         loc_oPagina.cbo_4c_CmbTCons.Enabled    = INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR", "BUSCAR") AND par_lHabilitar
1302:         loc_oPagina.txt_4c_Contrato.ReadOnly   = !par_lHabilitar
1303:         loc_oPagina.txt_4c_Rede.ReadOnly       = !par_lHabilitar
1304:         loc_oPagina.txt_4c_Loja.ReadOnly       = !par_lHabilitar
1305:         loc_oPagina.txt_4c_Logon.ReadOnly      = !par_lHabilitar
1306:         loc_oPagina.txt_4c_Senha.ReadOnly      = !par_lHabilitar
1307:         loc_oPagina.txt_4c_Fwget1.ReadOnly    = !par_lHabilitar
1308:         loc_oPagina.txt_4c_ValMin.ReadOnly    = !par_lHabilitar
1309:         loc_oPagina.txt_4c_ValFix.ReadOnly    = !par_lHabilitar
1310:         loc_oPagina.txt_4c_Ip.ReadOnly        = !par_lHabilitar
1311:         loc_oPagina.txt_4c_Porta.ReadOnly     = !par_lHabilitar
1312:         loc_oPagina.txt_4c_UsuProxy.ReadOnly  = !par_lHabilitar
1313:         loc_oPagina.txt_4c_SenProxy.ReadOnly  = !par_lHabilitar
1314:     ENDPROC
1315: 
1316:     *--------------------------------------------------------------------------
1317:     PROTECTED PROCEDURE LimparCampos()
1318:         LOCAL loc_oPagina
1319:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1320: 
1321:         loc_oPagina.txt_4c_Empresa.Value    = ""
1322:         loc_oPagina.txt_4c_DesEmpresa.Value = ""
1323:         loc_oPagina.cbo_4c_CmbTCons.Value   = ""
1324:         loc_oPagina.txt_4c_Contrato.Value   = ""
1325:         loc_oPagina.txt_4c_Rede.Value       = ""
1326:         loc_oPagina.txt_4c_Loja.Value       = ""
1327:         loc_oPagina.txt_4c_Logon.Value      = ""
1328:         loc_oPagina.txt_4c_Senha.Value      = ""
1329:         loc_oPagina.txt_4c_Fwget1.Value    = ""
1330:         loc_oPagina.txt_4c_ValMin.Value    = 0
1331:         loc_oPagina.txt_4c_ValFix.Value    = 0
1332:         loc_oPagina.txt_4c_Ip.Value        = ""
1333:         loc_oPagina.txt_4c_Porta.Value     = 0
1334:         loc_oPagina.txt_4c_UsuProxy.Value  = ""
1335:         loc_oPagina.txt_4c_SenProxy.Value  = ""
1336:     ENDPROC
1337: 
1338:     *--------------------------------------------------------------------------
1339:     PROCEDURE ValidarTipoSerasa(par_nKeyCode, par_nShiftAltCtrl)
1340:         LOCAL loc_oPagina, loc_cValor
1341:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1342:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Fwget1.Value)
1343: 
1344:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1345:             RETURN
1346:         ENDIF
1347:         IF EMPTY(loc_cValor)
1348:             RETURN
1349:         ENDIF
1350:         IF !INLIST(loc_cValor, "CP", "CH")
1351:             MsgAviso("Tipo de Consulta Inv" + CHR(225) + "lida, Informar CP ou CH !!!", "Aviso")
1352:             loc_oPagina.txt_4c_Fwget1.SetFocus()
1353:         ENDIF
1354:     ENDPROC
1355: 
1356:     *--------------------------------------------------------------------------
1357:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1358:         LOCAL loc_oCnt, loc_cCaption
1359:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
1360: 
1361:         DO CASE
1362:         CASE THIS.this_cModoAtual = "EXCLUIR"
1363:             loc_cCaption = "Excluir"
1364:         CASE THIS.this_cModoAtual = "VISUALIZAR"
1365:             loc_cCaption = "Fechar"
1366:         OTHERWISE
1367:             loc_cCaption = "Confirmar"
1368:         ENDCASE
1369: 
1370:         loc_oCnt.cmd_4c_Confirmar.Caption = loc_cCaption
1371:     ENDPROC
1372: 
1373:     *--------------------------------------------------------------------------
1374:     PROCEDURE Destroy()
1375:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1376:             THIS.this_oBusinessObject = .NULL.
1377:         ENDIF
1378:         DODEFAULT()
1379:     ENDPROC
1380: 
1381: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CecBO.prg):
*==============================================================================
* CecBO.prg - Business Object para Cadastro de Acesso a Consulta Generica
* Tabela: SigFiChc
* PK: cIdChaves (char 20, gerado por fUniqueIds)
*==============================================================================

DEFINE CLASS CecBO AS BusinessBase

    *-- Chave primaria
    this_cIdChaves    = ""   && char(20) PK

    *-- Campos de identificacao / chave composta funcional
    this_cEmps        = ""   && char(3)  Empresa (FK SigCdEmp.cEmps)
    this_cTipos       = ""   && char(20) Tipo de Consulta (CHEQUE PRE / SERASA / ACSP)

    *-- Campos de acesso CHEQUE PRE
    this_cCtr         = ""   && char(100) Contrato
    this_cRde         = ""   && char(100) Codigo da Rede
    this_cRdeLja      = ""   && char(100) Codigo da Loja

    *-- Campos de acesso nao-CHEQUE PRE
    this_cLogon       = ""   && char(8)  Logon
    this_cNSenha      = ""   && char(8)  nSenha (campo interno, armazenado no banco)
    this_cSenha       = ""   && char(8)  Senha de acesso

    *-- Valores de referencia
    this_nVlrMin      = 0    && numeric(11,2) Valor Minimo
    this_nVlrFixo     = 0    && numeric(11,2) Valor Fixo

    *-- Configuracao de conexao
    this_cCipchps     = ""   && char(32) URL / IP Proxy
    this_nPortachps   = 0    && int      Porta
    this_cVersao      = ""   && char(10) Versao

    *-- Consulta Serasa
    this_cCTipos      = ""   && char(2)  Tipo Consulta Serasa (CP / CH)

    *-- Proxy
    this_cUsuProxys   = ""   && char(64) Usuario Proxy
    this_cSenProxys   = ""   && char(20) Senha Proxy

    *-- Campo de exibicao (JOIN com SigCdEmp)
    this_cRazas       = ""   && char(40) Razao Social (SigCdEmp.Razas, somente leitura)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiChc"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros com JOIN para exibir Razao Social
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cIdChaves, a.Emps, a.Tipos, a.Ctr, a.Rde, a.RdeLja," + ;
                       " a.Logon, a.Senha, a.VlrMin, a.VlrFixo, a.cipchps, a.nPortachps," + ;
                       " a.cTipos, a.cUsuProxys, a.cSenProxys, b.Razas" + ;
                       " FROM SigFiChc a" + ;
                       " INNER JOIN SigCdEmp b ON a.Cemps = b.cEmps"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE a.Emps = " + EscaparSQL(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Tipos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pela PK (cIdChaves)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cIdChaves, a.Emps, a.Tipos, a.Ctr, a.Rde, a.RdeLja," + ;
                       " a.Logon, a.Senha, a.VlrMin, a.VlrFixo, a.cipchps, a.nPortachps," + ;
                       " a.cTipos, a.cUsuProxys, a.cSenProxys, b.Razas" + ;
                       " FROM SigFiChc a" + ;
                       " INNER JOIN SigCdEmp b ON a.Cemps = b.cEmps" + ;
                       " WHERE a.cIdChaves = " + EscaparSQL(par_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se ja existe registro com Emps+Tipos
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves FROM SigFiChc" + ;
                       " WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " AND Tipos = " + EscaparSQL(THIS.this_cTipos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dupl")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dupl") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves   = TratarNulo(cIdChaves,   "C")
            THIS.this_cEmps       = TratarNulo(Emps,        "C")
            THIS.this_cTipos      = TratarNulo(Tipos,       "C")
            THIS.this_cCtr        = TratarNulo(Ctr,         "C")
            THIS.this_cRde        = TratarNulo(Rde,         "C")
            THIS.this_cRdeLja     = TratarNulo(RdeLja,      "C")
            THIS.this_cLogon      = TratarNulo(Logon,       "C")
            THIS.this_cSenha      = TratarNulo(Senha,       "C")
            THIS.this_nVlrMin     = TratarNulo(VlrMin,      "N")
            THIS.this_nVlrFixo    = TratarNulo(VlrFixo,     "N")
            THIS.this_cCipchps    = TratarNulo(cipchps,     "C")
            THIS.this_nPortachps  = TratarNulo(nPortachps,  "N")
            THIS.this_cCTipos     = TratarNulo(cTipos,      "C")
            THIS.this_cUsuProxys  = TratarNulo(cUsuProxys,  "C")
            THIS.this_cSenProxys  = TratarNulo(cSenProxys,  "C")
            THIS.this_cRazas      = TratarNulo(Razas,       "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigFiChc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIdChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigFiChc" + ;
                       " (cIdChaves, Emps, Tipos, Ctr, Rde, RdeLja," + ;
                       " Logon, Senha, VlrMin, VlrFixo, cipchps, nPortachps," + ;
                       " cTipos, cUsuProxys, cSenProxys)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       EscaparSQL(THIS.this_cCtr) + "," + ;
                       EscaparSQL(THIS.this_cRde) + "," + ;
                       EscaparSQL(THIS.this_cRdeLja) + "," + ;
                       EscaparSQL(THIS.this_cLogon) + "," + ;
                       EscaparSQL(THIS.this_cSenha) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVlrMin) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVlrFixo) + "," + ;
                       EscaparSQL(THIS.this_cCipchps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPortachps) + "," + ;
                       EscaparSQL(THIS.this_cCTipos) + "," + ;
                       EscaparSQL(THIS.this_cUsuProxys) + "," + ;
                       EscaparSQL(THIS.this_cSenProxys) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigFiChc (Emps e Tipos sao chave, nao alterar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigFiChc SET" + ;
                       " Ctr = " + EscaparSQL(THIS.this_cCtr) + "," + ;
                       " Rde = " + EscaparSQL(THIS.this_cRde) + "," + ;
                       " RdeLja = " + EscaparSQL(THIS.this_cRdeLja) + "," + ;
                       " Logon = " + EscaparSQL(THIS.this_cLogon) + "," + ;
                       " Senha = " + EscaparSQL(THIS.this_cSenha) + "," + ;
                       " VlrMin = " + FormatarNumeroSQL(THIS.this_nVlrMin) + "," + ;
                       " VlrFixo = " + FormatarNumeroSQL(THIS.this_nVlrFixo) + "," + ;
                       " cipchps = " + EscaparSQL(THIS.this_cCipchps) + "," + ;
                       " nPortachps = " + FormatarNumeroSQL(THIS.this_nPortachps) + "," + ;
                       " cTipos = " + EscaparSQL(THIS.this_cCTipos) + "," + ;
                       " cUsuProxys = " + EscaparSQL(THIS.this_cUsuProxys) + "," + ;
                       " cSenProxys = " + EscaparSQL(THIS.this_cSenProxys) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE da tabela SigFiChc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiChc WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

