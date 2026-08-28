# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BINDEVENT-PARAMS] Handler 'DescricaoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE DescricaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Grupo, Conta, Grupo de Venda, Qtde. Min., Prior., Grupo de Produto, Zerar, Ordem. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Grupo, Conta, Grupo de Venda, Qtde. Min., Prior., Grupo de Produto, Zerar, Ordem. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Valor Mín.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Grupo, Conta, Grupo de Venda, Qtde. Min., Prior., Grupo de Produto, Zerar, Ordem. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Inativa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Grupo, Conta, Grupo de Venda, Qtde. Min., Prior., Grupo de Produto, Zerar, Ordem. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formrgr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1831 linhas total):

*-- Linhas 26 a 148:
26: 
27:     *===========================================================================
28:     * Init - REGRA CRITICA: apenas RETURN DODEFAULT()
29:     * FormBase.Init() ja chama InicializarForm() via DODEFAULT - NAO duplicar!
30:     *===========================================================================
31:     PROCEDURE Init()
32:         RETURN DODEFAULT()
33:     ENDPROC
34: 
35:     *===========================================================================
36:     * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
37:     *===========================================================================
38:     PROTECTED PROCEDURE InicializarForm()
39:         LOCAL loc_lSucesso
40:         loc_lSucesso = .F.
41: 
42:         TRY
43:             THIS.this_oBusinessObject = CREATEOBJECT("rgrBO")
44: 
45:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
46:                 MostrarErro("Erro ao criar rgrBO" + CHR(13) + ;
47:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
48:                     "Formrgr.InicializarForm")
49:             ELSE
50:                 SET DELETED ON
51:                 THIS.ConfigurarPageFrame()
52: 
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Visible  = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1
57:                 THIS.this_cModoAtual = "LISTA"
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
60:                     THIS.CarregarLista()
61:                 ENDIF
62: 
63:                 loc_lSucesso = .T.
64:             ENDIF
65: 
66:         CATCH TO loException
67:             MostrarErro("Erro ao inicializar Formrgr:" + CHR(13) + ;
68:                 loException.Message + CHR(13) + ;
69:                 "Linha: " + TRANSFORM(loException.LineNo), ;
70:                 "Formrgr.InicializarForm")
71:         ENDTRY
72: 
73:         RETURN loc_lSucesso
74:     ENDPROC
75: 
76:     *===========================================================================
77:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
78:     * Pagina.Top = -27 no original; compensacao +27 em controles das Pages
79:     *===========================================================================
80:     PROTECTED PROCEDURE ConfigurarPageFrame()
81:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
82: 
83:         WITH THIS.pgf_4c_Paginas
84:             .PageCount = 2
85:             .Top       = -27
86:             .Left      = 0
87:             .Width     = THIS.Width
88:             .Height    = THIS.Height + 27
89:             .Tabs      = .F.
90:             .Visible   = .T.
91: 
92:             .Page1.Caption   = "Lista"
93:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page1.BackColor = RGB(255, 255, 255)
95: 
96:             .Page2.Caption   = "Dados"
97:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page2.BackColor = RGB(255, 255, 255)
99:         ENDWITH
100: 
101:         THIS.ConfigurarPaginaLista()
102:         THIS.ConfigurarPaginaDados()
103:     ENDPROC
104: 
105:     *===========================================================================
106:     * ConfigurarPaginaLista - Page1: cabecalho, 5 botoes CRUD e grid SigCdRGR
107:     *===========================================================================
108:     PROTECTED PROCEDURE ConfigurarPaginaLista()
109:         LOCAL loc_oPagina, loc_oBotoes
110:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
111: 
112:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
113:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114: 
115:         *-- Container Cabecalho (cntSombra no legado: Top=2; +27 compensacao = 29)
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 29
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Caption   = THIS.Caption
130:             .Top       = 15
131:             .Left      = 10
132:             .Width     = 769
133:             .Height    = 40
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .AutoSize  = .F.
140:             .Visible   = .T.
141:         ENDWITH
142: 
143:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
145:             .Caption   = THIS.Caption
146:             .Top       = 18
147:             .Left      = 10
148:             .Width     = 769

*-- Linhas 193 a 486:
193:             .AutoSize        = .F.
194:             .Visible         = .T.
195:         ENDWITH
196:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
197: 
198:         *-- Botao Visualizar (Left=80)
199:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200:         WITH loc_oBotoes.cmd_4c_Visualizar
201:             .Caption         = "Visualizar"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:             .PicturePosition = 13
204:             .Top             = 5
205:             .Left            = 80
206:             .Width           = 75
207:             .Height          = 75
208:             .FontName        = "Comic Sans MS"
209:             .FontSize        = 8
210:             .FontBold        = .T.
211:             .FontItalic      = .T.
212:             .ForeColor       = RGB(90, 90, 90)
213:             .BackColor       = RGB(255, 255, 255)
214:             .Themes          = .F.
215:             .SpecialEffect   = 0
216:             .MousePointer    = 15
217:             .WordWrap        = .T.
218:             .AutoSize        = .F.
219:             .Visible         = .T.
220:         ENDWITH
221:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
222: 
223:         *-- Botao Alterar (Left=155)
224:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
225:         WITH loc_oBotoes.cmd_4c_Alterar
226:             .Caption         = "Alterar"
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
228:             .PicturePosition = 13
229:             .Top             = 5
230:             .Left            = 155
231:             .Width           = 75
232:             .Height          = 75
233:             .FontName        = "Comic Sans MS"
234:             .FontSize        = 8
235:             .FontBold        = .T.
236:             .FontItalic      = .T.
237:             .ForeColor       = RGB(90, 90, 90)
238:             .BackColor       = RGB(255, 255, 255)
239:             .Themes          = .F.
240:             .SpecialEffect   = 0
241:             .MousePointer    = 15
242:             .WordWrap        = .T.
243:             .AutoSize        = .F.
244:             .Visible         = .T.
245:         ENDWITH
246:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
247: 
248:         *-- Botao Excluir (Left=230)
249:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
250:         WITH loc_oBotoes.cmd_4c_Excluir
251:             .Caption         = "Excluir"
252:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
253:             .PicturePosition = 13
254:             .Top             = 5
255:             .Left            = 230
256:             .Width           = 75
257:             .Height          = 75
258:             .FontName        = "Comic Sans MS"
259:             .FontSize        = 8
260:             .FontBold        = .T.
261:             .FontItalic      = .T.
262:             .ForeColor       = RGB(90, 90, 90)
263:             .BackColor       = RGB(255, 255, 255)
264:             .Themes          = .F.
265:             .SpecialEffect   = 0
266:             .MousePointer    = 15
267:             .WordWrap        = .T.
268:             .AutoSize        = .F.
269:             .Visible         = .T.
270:         ENDWITH
271:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
272: 
273:         *-- Botao Buscar (Left=305)
274:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
275:         WITH loc_oBotoes.cmd_4c_Buscar
276:             .Caption         = "Buscar"
277:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
278:             .PicturePosition = 13
279:             .Top             = 5
280:             .Left            = 305
281:             .Width           = 75
282:             .Height          = 75
283:             .FontName        = "Comic Sans MS"
284:             .FontSize        = 8
285:             .FontBold        = .T.
286:             .FontItalic      = .T.
287:             .ForeColor       = RGB(90, 90, 90)
288:             .BackColor       = RGB(255, 255, 255)
289:             .Themes          = .F.
290:             .SpecialEffect   = 0
291:             .MousePointer    = 15
292:             .WordWrap        = .T.
293:             .AutoSize        = .F.
294:             .Visible         = .T.
295:         ENDWITH
296:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
297: 
298:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md #10)
299:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
300:         WITH loc_oPagina.cnt_4c_Saida
301:             .Top         = 27
302:             .Left        = 917
303:             .Width       = 90
304:             .Height      = 85
305:             .BackStyle   = 0
306:             .BorderWidth = 0
307:             .Visible     = .T.
308:         ENDWITH
309: 
310:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
311:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
312:             .Caption         = "Encerrar"
313:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
314:             .PicturePosition = 13
315:             .Top             = 5
316:             .Left            = 5
317:             .Width           = 75
318:             .Height          = 75
319:             .FontName        = "Comic Sans MS"
320:             .FontSize        = 8
321:             .FontBold        = .T.
322:             .FontItalic      = .T.
323:             .ForeColor       = RGB(90, 90, 90)
324:             .BackColor       = RGB(255, 255, 255)
325:             .Themes          = .F.
326:             .SpecialEffect   = 0
327:             .MousePointer    = 15
328:             .WordWrap        = .T.
329:             .AutoSize        = .F.
330:             .Visible         = .T.
331:         ENDWITH
332:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
333: 
334:         *-- Grid de lista SigCdRGR (Top=115 = 88+27 compensacao PageFrame)
335:         *-- Width=880 para nao sobrepor cnt_4c_Saida (Left=917)
336:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
337:         WITH loc_oPagina.grd_4c_Lista
338:             .Top                = 115
339:             .Left               = 26
340:             .Width              = 880
341:             .Height             = 478
342:             .ColumnCount        = 4
343:             .FontName           = "Verdana"
344:             .FontSize           = 8
345:             .ForeColor          = RGB(90, 90, 90)
346:             .BackColor          = RGB(255, 255, 255)
347:             .GridLineColor      = RGB(238, 238, 238)
348:             .HighlightBackColor = RGB(255, 255, 255)
349:             .HighlightForeColor = RGB(15, 41, 104)
350:             .HighlightStyle     = 2
351:             .DeleteMark         = .F.
352:             .RecordMark         = .F.
353:             .RowHeight          = 16
354:             .ScrollBars         = 2
355:             .GridLines          = 3
356:             .ReadOnly           = .T.
357:             .Visible            = .T.
358:         ENDWITH
359: 
360:         WITH loc_oPagina.grd_4c_Lista
361:             .Column1.Width     = 80
362:             .Column1.Alignment = 0
363:             .Column2.Width     = 380
364:             .Column2.Alignment = 0
365:             .Column3.Width     = 120
366:             .Column3.Alignment = 1
367:             .Column4.Width     = 80
368:             .Column4.Alignment = 2
369:         ENDWITH
370: 
371:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
372: 
373:         THIS.TornarControlesVisiveis(loc_oPagina)
374:     ENDPROC
375: 
376:     *===========================================================================
377:     * ConfigurarPaginaDados - Page2: campos do cabecalho SigCdRGR + grid SigCdRga
378:     * Compensacao PageFrame: pgf_4c_Paginas.Top=-27 -> todos os Tops +27
379:     *===========================================================================
380:     PROTECTED PROCEDURE ConfigurarPaginaDados()
381:         LOCAL loc_oPagina, loc_oGrd, loc_oCmdGrp1, loc_oCmdGrp2
382:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
383: 
384:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
385:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
386: 
387:         *-- Container Salvar/Cancelar (Grupo_Salva: Left=638, Top=8+27=35)
388:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
389:         WITH loc_oPagina.cnt_4c_Salva
390:             .Top         = 35
391:             .Left        = 638
392:             .Width       = 160
393:             .Height      = 85
394:             .BackStyle = 1
395:             .BackColor = RGB(255, 255, 255)
396:             .BorderWidth = 0
397:             .Visible     = .T.
398:         ENDWITH
399: 
400:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
401:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
402:             .Caption         = "Salvar"
403:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
404:             .PicturePosition = 13
405:             .Top             = 5
406:             .Left            = 5
407:             .Width           = 75
408:             .Height          = 75
409:             .FontName        = "Comic Sans MS"
410:             .FontSize        = 8
411:             .FontBold        = .T.
412:             .FontItalic      = .T.
413:             .ForeColor       = RGB(90, 90, 90)
414:             .BackColor       = RGB(255, 255, 255)
415:             .Themes          = .F.
416:             .SpecialEffect   = 0
417:             .MousePointer    = 15
418:             .WordWrap        = .T.
419:             .AutoSize        = .F.
420:             .Visible         = .T.
421:         ENDWITH
422:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
423: 
424:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
425:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
426:             .Caption         = "Encerrar"
427:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
428:             .PicturePosition = 13
429:             .Top             = 5
430:             .Left            = 80
431:             .Width           = 75
432:             .Height          = 75
433:             .FontName        = "Comic Sans MS"
434:             .FontSize        = 8
435:             .FontBold        = .T.
436:             .FontItalic      = .T.
437:             .ForeColor       = RGB(90, 90, 90)
438:             .BackColor       = RGB(255, 255, 255)
439:             .Themes          = .F.
440:             .SpecialEffect   = 0
441:             .MousePointer    = 15
442:             .WordWrap        = .T.
443:             .AutoSize        = .F.
444:             .Visible         = .T.
445:         ENDWITH
446:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
447: 
448:         *-- Label + TextBox Codigo (getCodigo: Top=54+27=81, Left=227, Width=82)
449:         loc_oPagina.AddObject("lbl_4c_LblGrupo", "Label")
450:         WITH loc_oPagina.lbl_4c_LblGrupo
451:             .Caption   = "C" + CHR(243) + "digo :"
452:             .Top       = 85
453:             .Left      = 181
454:             .Width     = 42
455:             .Height    = 17
456:             .FontName  = "Tahoma"
457:             .FontSize  = 8
458:             .AutoSize  = .F.
459:             .BackStyle = 0
460:             .Visible   = .T.
461:         ENDWITH
462: 
463:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
464:         WITH loc_oPagina.txt_4c_Codigo
465:             .Value     = ""
466:             .Top       = 81
467:             .Left      = 227
468:             .Width     = 82
469:             .Height    = 23
470:             .FontName  = "Tahoma"
471:             .FontSize  = 8
472:             .MaxLength = 10
473:             .ReadOnly  = .F.
474:             .Visible   = .T.
475:         ENDWITH
476: 
477:         *-- CheckBox Inativa (Check1: Top=58+27=85, Left=320)
478:         loc_oPagina.AddObject("chk_4c_Check1", "CheckBox")
479:         WITH loc_oPagina.chk_4c_Check1
480:             .Caption   = "Inativa"
481:             .Value     = 0
482:             .Top       = 85
483:             .Left      = 320
484:             .Width     = 52
485:             .Height    = 15
486:             .FontName  = "Tahoma"

*-- Linhas 517 a 560:
517:             .Visible   = .T.
518:         ENDWITH
519:         *-- LostFocus: se descricao preenchida e modo edicao, insere linha vazia na grade
520:         BINDEVENT(loc_oPagina.txt_4c_Descricao, "KeyPress", THIS, "DescricaoLostFocus")
521: 
522:         *-- Label + TextBox Valor (getValor: Top=104+27=131, Left=227, Width=105)
523:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
524:         WITH loc_oPagina.lbl_4c_Label2
525:             .Caption   = "Valor acima de :"
526:             .Top       = 136
527:             .Left      = 145
528:             .Width     = 78
529:             .Height    = 17
530:             .FontName  = "Tahoma"
531:             .FontSize  = 8
532:             .AutoSize  = .F.
533:             .BackStyle = 0
534:             .Visible   = .T.
535:         ENDWITH
536: 
537:         loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
538:         WITH loc_oPagina.txt_4c_Valor
539:             .Value     = 0
540:             .Top       = 131
541:             .Left      = 227
542:             .Width     = 105
543:             .Height    = 21
544:             .FontName  = "Tahoma"
545:             .FontSize  = 8
546:             .Format    = "N"
547:             .InputMask = "999,999,999.99"
548:             .ReadOnly  = .F.
549:             .Visible   = .T.
550:         ENDWITH
551: 
552:         *-- Grid SigCdRga (grdRegra: Top=129+27=156, Left=11, Width=739, Height=371)
553:         *-- Cursor placeholder criado aqui; ZAP preserva estrutura em CarregarGradeRegra (Problem 34)
554:         IF !USED("csSigCdRga")
555:             CREATE CURSOR csSigCdRga ( ;
556:                 cIdChaves  C(20), ;
557:                 Codigo     C(10), ;
558:                 Empresa    C(3),  ;
559:                 Grupo      C(10), ;
560:                 Conta      C(10), ;

*-- Linhas 644 a 761:
644:             .Column9.Header1.Caption = "Ordem"
645:         ENDWITH
646: 
647:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeRegraAfterRowColChange")
648: 
649:         *-- CommandGroup Mover linhas (Commandgroup1: Top=200+27=227, Left=748, W=50, H=90)
650:         loc_oPagina.AddObject("obj_4c_Commandgroup1", "CommandGroup")
651:         WITH loc_oPagina.obj_4c_Commandgroup1
652:             .Top         = 227
653:             .Left        = 748
654:             .Width       = 50
655:             .Height      = 90
656:             .BackStyle   = 0
657:             .BorderWidth = 0
658:             .ButtonCount = 2
659:             .Visible     = .T.
660:         ENDWITH
661: 
662:         loc_oCmdGrp1 = loc_oPagina.obj_4c_Commandgroup1
663:         WITH loc_oCmdGrp1.Buttons(1)
664:             .Caption  = "^"
665:             .Top      = 0
666:             .Left     = 0
667:             .Width    = 50
668:             .Height   = 45
669:             .FontName = "Tahoma"
670:             .FontSize = 14
671:             .FontBold = .T.
672:         ENDWITH
673:         WITH loc_oCmdGrp1.Buttons(2)
674:             .Caption  = "v"
675:             .Top      = 45
676:             .Left     = 0
677:             .Width    = 50
678:             .Height   = 45
679:             .FontName = "Tahoma"
680:             .FontSize = 14
681:             .FontBold = .T.
682:         ENDWITH
683:         BINDEVENT(loc_oCmdGrp1.Buttons(1), "Click", THIS, "CmdMoveUpClick")
684:         BINDEVENT(loc_oCmdGrp1.Buttons(2), "Click", THIS, "CmdMoveDownClick")
685: 
686:         *-- CommandGroup Inserir/Deletar linhas (cmdInsFtc: Top=287+27=314, Left=748, W=50, H=90)
687:         loc_oPagina.AddObject("obj_4c_CmdInsFtc", "CommandGroup")
688:         WITH loc_oPagina.obj_4c_CmdInsFtc
689:             .Top         = 314
690:             .Left        = 748
691:             .Width       = 50
692:             .Height      = 90
693:             .BackStyle   = 0
694:             .BorderWidth = 0
695:             .ButtonCount = 2
696:             .Visible     = .T.
697:         ENDWITH
698: 
699:         loc_oCmdGrp2 = loc_oPagina.obj_4c_CmdInsFtc
700:         WITH loc_oCmdGrp2.Buttons(1)
701:             .Caption  = "+"
702:             .Top      = 0
703:             .Left     = 0
704:             .Width    = 50
705:             .Height   = 45
706:             .FontName = "Tahoma"
707:             .FontSize = 14
708:             .FontBold = .T.
709:         ENDWITH
710:         WITH loc_oCmdGrp2.Buttons(2)
711:             .Caption  = "-"
712:             .Top      = 45
713:             .Left     = 0
714:             .Width    = 50
715:             .Height   = 45
716:             .FontName = "Tahoma"
717:             .FontSize = 14
718:             .FontBold = .T.
719:         ENDWITH
720:         BINDEVENT(loc_oCmdGrp2.Buttons(1), "Click", THIS, "CmdInsRowClick")
721:         BINDEVENT(loc_oCmdGrp2.Buttons(2), "Click", THIS, "CmdDelRowClick")
722: 
723:         *-- Shape1 - separador horizontal acima da area de observacao (Top=503+27=530)
724:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
725:         WITH loc_oPagina.shp_4c_Shape1
726:             .Top           = 530
727:             .Left          = 7
728:             .Width         = 780
729:             .Height        = 2
730:             .BackStyle     = 0
731:             .BorderWidth   = 2
732:             .SpecialEffect = 0
733:             .Visible       = .T.
734:         ENDWITH
735: 
736:         *-- Label Observacao (Say1: Top=519+27=546, Left=88)
737:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
738:         WITH loc_oPagina.lbl_4c_Label1
739:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
740:             .Top       = 546
741:             .Left      = 88
742:             .Width     = 65
743:             .Height    = 17
744:             .FontName  = "Tahoma"
745:             .FontSize  = 8
746:             .AutoSize  = .T.
747:             .BackStyle = 0
748:             .ForeColor = RGB(90, 90, 90)
749:             .Visible   = .T.
750:         ENDWITH
751: 
752:         *-- EditBox Observacao (edtObservacao: Top=514+27=541, Left=157, Width=465, Height=80)
753:         loc_oPagina.AddObject("edt_4c_Observacao", "EditBox")
754:         WITH loc_oPagina.edt_4c_Observacao
755:             .Value         = ""
756:             .Top           = 541
757:             .Left          = 157
758:             .Width         = 465
759:             .Height        = 80
760:             .FontName      = "Verdana"
761:             .FontSize      = 8

*-- Linhas 898 a 947:
898:             .Visible       = .T.
899:         ENDWITH
900: 
901:         THIS.TornarControlesVisiveis(loc_oPagina)
902:     ENDPROC
903: 
904:     *===========================================================================
905:     * CarregarLista - Busca SigCdRGR e vincula ao grd_4c_Lista da Page1
906:     *===========================================================================
907:     PROCEDURE CarregarLista()
908:         LOCAL loc_lResultado, loc_oGrd
909:         loc_lResultado = .F.
910: 
911:         TRY
912:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
913:                 loc_lResultado = .T.
914:             ELSE
915:                 IF THIS.this_oBusinessObject.Buscar("")
916:                 loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
917: 
918:                 *-- RecordSource + ColumnCount FORA do WITH (Problem 36/48)
919:                 loc_oGrd.ColumnCount = 3
920:                 loc_oGrd.RecordSource = "cursor_4c_Dados"
921:                 loc_oGrd.ColumnCount  = 4
922: 
923:                 *-- ControlSource APOS RecordSource; Headers OBRIGATORIOS (Problem 2/32)
924:                 WITH loc_oGrd
925:                     .Column1.ControlSource  = "cursor_4c_Dados.codigo"
926:                     .Column2.ControlSource  = "cursor_4c_Dados.descricao"
927:                     .Column3.ControlSource  = "cursor_4c_Dados.valor"
928:                     .Column4.ControlSource  = "cursor_4c_Dados.inativas"
929: 
930:                     .Column1.Header1.Caption = "C" + CHR(243) + "digo"
931:                     .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
932:                     .Column3.Header1.Caption = "Valor M" + CHR(237) + "n."
933:                     .Column4.Header1.Caption = "Inativa"
934: 
935:                     .Column1.Width     = 80
936:                     .Column2.Width     = 380
937:                     .Column3.Width     = 120
938:                     .Column4.Width     = 80
939:                     .Column1.Alignment = 0
940:                     .Column2.Alignment = 0
941:                     .Column3.Alignment = 1
942:                     .Column4.Alignment = 2
943:                 ENDWITH
944: 
945:                 THIS.FormatarGridLista(loc_oGrd)
946:                 loc_lResultado = .T.
947:             ELSE

*-- Linhas 959 a 1358:
959:     *===========================================================================
960:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
961:     *===========================================================================
962:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
963:         LOCAL loc_lResultado
964:         loc_lResultado = .F.
965: 
966:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
967:             RETURN .F.
968:         ENDIF
969: 
970:         TRY
971:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
972: 
973:             IF par_nPagina = 1
974:                 THIS.this_cModoAtual = "LISTA"
975:                 THIS.CarregarLista()
976:             ENDIF
977: 
978:             loc_lResultado = .T.
979:         CATCH TO loException
980:             MsgErro("Erro ao alternar pagina:" + CHR(13) + loException.Message, "Erro")
981:             loc_lResultado = .F.
982:         ENDTRY
983: 
984:         RETURN loc_lResultado
985:     ENDPROC
986: 
987:     *===========================================================================
988:     * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
989:     *===========================================================================
990:     PROCEDURE BtnIncluirClick()
991:         LOCAL loc_lResultado
992:         loc_lResultado = .F.
993: 
994:         TRY
995:             THIS.this_oBusinessObject.NovoRegistro()
996:             THIS.this_cModoAtual = "INCLUIR"
997:             THIS.LimparCampos()
998:             THIS.HabilitarCampos(.T.)
999:             THIS.AjustarBotoesPorModo()
1000: 
1001:             IF USED("csSigCdRga")
1002:                 ZAP IN csSigCdRga
1003:             ENDIF
1004: 
1005:             loc_lResultado = THIS.AlternarPagina(2)
1006:         CATCH TO loException
1007:             MsgErro("Erro ao preparar inclus" + CHR(227) + "o:" + CHR(13) + ;
1008:                     loException.Message + CHR(13) + ;
1009:                     "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1010:         ENDTRY
1011: 
1012:         RETURN loc_lResultado
1013:     ENDPROC
1014: 
1015:     *===========================================================================
1016:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
1017:     *===========================================================================
1018:     PROCEDURE BtnVisualizarClick()
1019:         LOCAL loc_lResultado, loc_cCodigo
1020:         loc_lResultado = .F.
1021: 
1022:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1023:             MsgAviso("Selecione um registro para visualizar.", ;
1024:                      "Aten" + CHR(231) + CHR(227) + "o")
1025:             RETURN .F.
1026:         ENDIF
1027: 
1028:         TRY
1029:             SELECT cursor_4c_Dados
1030:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
1031: 
1032:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1033:                 THIS.BOParaForm()
1034:                 THIS.CarregarGradeRegra(loc_cCodigo)
1035:                 THIS.this_cModoAtual = "VISUALIZAR"
1036:                 THIS.HabilitarCampos(.F.)
1037:                 THIS.AjustarBotoesPorModo()
1038:                 loc_lResultado = THIS.AlternarPagina(2)
1039:             ENDIF
1040:         CATCH TO loException
1041:             MsgErro("Erro ao carregar registro:" + CHR(13) + ;
1042:                     loException.Message + CHR(13) + ;
1043:                     "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1044:         ENDTRY
1045: 
1046:         RETURN loc_lResultado
1047:     ENDPROC
1048: 
1049:     *===========================================================================
1050:     * BtnAlterarClick - Carrega registro selecionado para edicao
1051:     *===========================================================================
1052:     PROCEDURE BtnAlterarClick()
1053:         LOCAL loc_lResultado, loc_cCodigo
1054:         loc_lResultado = .F.
1055: 
1056:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1057:             MsgAviso("Selecione um registro para alterar.", ;
1058:                      "Aten" + CHR(231) + CHR(227) + "o")
1059:             RETURN .F.
1060:         ENDIF
1061: 
1062:         TRY
1063:             SELECT cursor_4c_Dados
1064:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
1065: 
1066:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1067:                 THIS.this_oBusinessObject.EditarRegistro()
1068:                 THIS.BOParaForm()
1069:                 THIS.CarregarGradeRegra(loc_cCodigo)
1070:                 THIS.this_cModoAtual = "ALTERAR"
1071:                 THIS.HabilitarCampos(.T.)
1072:                 THIS.AjustarBotoesPorModo()
1073:                 loc_lResultado = THIS.AlternarPagina(2)
1074:             ENDIF
1075:         CATCH TO loException
1076:             MsgErro("Erro ao carregar registro:" + CHR(13) + ;
1077:                     loException.Message + CHR(13) + ;
1078:                     "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1079:         ENDTRY
1080: 
1081:         RETURN loc_lResultado
1082:     ENDPROC
1083: 
1084:     *===========================================================================
1085:     * BtnExcluirClick - Confirma e exclui o registro selecionado
1086:     *===========================================================================
1087:     PROCEDURE BtnExcluirClick()
1088:         LOCAL loc_lResultado, loc_cCodigo, loc_cDescricao
1089:         loc_lResultado = .F.
1090: 
1091:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1092:             MsgAviso("Selecione um registro para excluir.", ;
1093:                      "Aten" + CHR(231) + CHR(227) + "o")
1094:             RETURN .F.
1095:         ENDIF
1096: 
1097:         SELECT cursor_4c_Dados
1098:         loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigo)
1099:         loc_cDescricao = ALLTRIM(cursor_4c_Dados.descricao)
1100: 
1101:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da regra:" + CHR(13) + ;
1102:                         loc_cCodigo + " - " + loc_cDescricao + "?", ;
1103:                         "Confirmar Exclus" + CHR(227) + "o")
1104:             RETURN .F.
1105:         ENDIF
1106: 
1107:         TRY
1108:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1109:                 IF THIS.this_oBusinessObject.Excluir()
1110:                     MsgInfo("Regra exclu" + CHR(237) + "da com sucesso!")
1111:                     THIS.CarregarLista()
1112:                     loc_lResultado = .T.
1113:                 ENDIF
1114:             ENDIF
1115:         CATCH TO loException
1116:             MsgErro("Erro ao excluir registro:" + CHR(13) + ;
1117:                     loException.Message + CHR(13) + ;
1118:                     "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1119:         ENDTRY
1120: 
1121:         RETURN loc_lResultado
1122:     ENDPROC
1123: 
1124:     *===========================================================================
1125:     * BtnBuscarClick - Recarrega lista e posiciona no primeiro registro que
1126:     * contenha o texto digitado no codigo ou descricao
1127:     *===========================================================================
1128:     PROCEDURE BtnBuscarClick()
1129:         LOCAL loc_cBuscar, loc_oGrd
1130:         loc_cBuscar = ALLTRIM(INPUTBOX("C" + CHR(243) + "digo ou descri" + CHR(231) + ;
1131:                                        CHR(227) + "o:", "Buscar Regra", ""))
1132: 
1133:         IF THIS.CarregarLista()
1134:             IF !EMPTY(loc_cBuscar) AND USED("cursor_4c_Dados")
1135:                 SELECT cursor_4c_Dados
1136:                 LOCATE FOR UPPER(loc_cBuscar) $ UPPER(ALLTRIM(codigo)) OR ;
1137:                            UPPER(loc_cBuscar) $ UPPER(ALLTRIM(descricao))
1138:                 IF EOF("cursor_4c_Dados")
1139:                     GO TOP IN cursor_4c_Dados
1140:                     MsgAviso("Nenhum registro encontrado para: " + loc_cBuscar, "Buscar")
1141:                 ENDIF
1142:             ENDIF
1143:             loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1144:             IF VARTYPE(loc_oGrd) = "O"
1145:                 loc_oGrd.Refresh()
1146:             ENDIF
1147:         ENDIF
1148:     ENDPROC
1149: 
1150:     *===========================================================================
1151:     * BtnEncerrarClick - Fecha o formulario
1152:     *===========================================================================
1153:     PROCEDURE BtnEncerrarClick()
1154:         THIS.Release()
1155:     ENDPROC
1156: 
1157:     *===========================================================================
1158:     * FormatarGridLista - Formata visual do grid de lista (Page1)
1159:     *===========================================================================
1160:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1161:         WITH par_oGrid
1162:             .FontName = "Tahoma"
1163:             .FontSize = 8
1164:         ENDWITH
1165:     ENDPROC
1166: 
1167:     *===========================================================================
1168:     * TornarControlesVisiveis - Torna visiveis todos os controles do container
1169:     * REGRA: Sempre chamar COM parametro: THIS.TornarControlesVisiveis(loc_oPagina)
1170:     *===========================================================================
1171:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1172:         LOCAL loc_nI, loc_oObjeto
1173: 
1174:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1175:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1176: 
1177:             IF VARTYPE(loc_oObjeto) = "O"
1178:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1179:                     loc_oObjeto.Visible = .T.
1180:                 ENDIF
1181: 
1182:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1183:                     LOCAL loc_nP
1184:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1185:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1186:                     ENDFOR
1187:                 ENDIF
1188: 
1189:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1190:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1191:                 ENDIF
1192:             ENDIF
1193:         ENDFOR
1194:     ENDPROC
1195: 
1196:     *===========================================================================
1197:     * BtnSalvarClick - Coleta dados do form, chama Inserir ou Atualizar no BO
1198:     *===========================================================================
1199:     PROCEDURE BtnSalvarClick()
1200:         LOCAL loc_lResultado, loc_oPg2
1201:         loc_lResultado = .F.
1202:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
1203: 
1204:         IF THIS.this_cModoAtual = "INCLUIR" AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
1205:             MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio.", "Aviso")
1206:             loc_oPg2.txt_4c_Codigo.SetFocus()
1207:             RETURN .F.
1208:         ENDIF
1209: 
1210:         TRY
1211:             THIS.FormParaBO()
1212: 
1213:             loc_lResultado = THIS.this_oBusinessObject.Salvar()
1214: 
1215:             IF loc_lResultado
1216:                 MsgInfo("Registro salvo com sucesso!")
1217:                 THIS.AlternarPagina(1)
1218:             ENDIF
1219:         CATCH TO loException
1220:             MsgErro("Erro ao salvar registro:" + CHR(13) + ;
1221:                     loException.Message + CHR(13) + ;
1222:                     "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1223:         ENDTRY
1224: 
1225:         RETURN loc_lResultado
1226:     ENDPROC
1227: 
1228:     *===========================================================================
1229:     * BtnCancelarClick - Retorna para Page1 sem salvar
1230:     *===========================================================================
1231:     PROCEDURE BtnCancelarClick()
1232:         THIS.AlternarPagina(1)
1233:     ENDPROC
1234: 
1235:     *===========================================================================
1236:     * FormParaBO - Transfere valores dos controles da Page2 para o BO
1237:     *===========================================================================
1238:     PROTECTED PROCEDURE FormParaBO()
1239:         LOCAL loc_oPg2
1240:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1241: 
1242:         THIS.this_oBusinessObject.this_cCodigo      = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1243:         THIS.this_oBusinessObject.this_cDescricao   = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1244:         THIS.this_oBusinessObject.this_nValor        = loc_oPg2.txt_4c_Valor.Value
1245:         THIS.this_oBusinessObject.this_nInativas     = IIF(loc_oPg2.chk_4c_Check1.Value = 1, 1, 0)
1246:         THIS.this_oBusinessObject.this_cObservacao   = ALLTRIM(loc_oPg2.edt_4c_Observacao.Value)
1247:     ENDPROC
1248: 
1249:     *===========================================================================
1250:     * BOParaForm - Transfere valores do BO para os controles da Page2
1251:     *===========================================================================
1252:     PROTECTED PROCEDURE BOParaForm()
1253:         LOCAL loc_oPg2
1254:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1255: 
1256:         loc_oPg2.txt_4c_Codigo.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1257:         loc_oPg2.txt_4c_Descricao.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
1258:         loc_oPg2.txt_4c_Valor.Value       = THIS.this_oBusinessObject.this_nValor
1259:         loc_oPg2.chk_4c_Check1.Value      = THIS.this_oBusinessObject.this_nInativas
1260:         loc_oPg2.edt_4c_Observacao.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cObservacao)
1261:         loc_oPg2.txt_4c_DtIncs.Value      = TTOD(THIS.this_oBusinessObject.this_dDatas)
1262:         loc_oPg2.txt_4c_Usuario.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cUsuIncs)
1263:         loc_oPg2.txt_4c_DataAlts.Value    = TTOD(THIS.this_oBusinessObject.this_dDtaAlts)
1264:         loc_oPg2.txt_4c_UsuaAlts.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cUsaAlts)
1265:     ENDPROC
1266: 
1267:     *===========================================================================
1268:     * LimparCampos - Zera todos os controles da Page2 (modo INCLUIR)
1269:     *===========================================================================
1270:     PROTECTED PROCEDURE LimparCampos()
1271:         LOCAL loc_oPg2
1272:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1273: 
1274:         loc_oPg2.txt_4c_Codigo.Value     = ""
1275:         loc_oPg2.txt_4c_Descricao.Value  = ""
1276:         loc_oPg2.txt_4c_Valor.Value      = 0
1277:         loc_oPg2.chk_4c_Check1.Value    = 0
1278:         loc_oPg2.edt_4c_Observacao.Value = ""
1279:         loc_oPg2.txt_4c_DtIncs.Value    = {}
1280:         loc_oPg2.txt_4c_Usuario.Value   = ""
1281:         loc_oPg2.txt_4c_DataAlts.Value  = {}
1282:         loc_oPg2.txt_4c_UsuaAlts.Value  = ""
1283:     ENDPROC
1284: 
1285:     *===========================================================================
1286:     * HabilitarCampos - Habilita ou desabilita campos conforme modo atual
1287:     *===========================================================================
1288:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1289:         LOCAL loc_oPg2
1290:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1291: 
1292:         loc_oPg2.txt_4c_Codigo.ReadOnly         = !par_lHabilitar
1293:         loc_oPg2.txt_4c_Descricao.ReadOnly      = !par_lHabilitar
1294:         loc_oPg2.txt_4c_Valor.ReadOnly          = !par_lHabilitar
1295:         loc_oPg2.chk_4c_Check1.Enabled         = par_lHabilitar
1296:         loc_oPg2.edt_4c_Observacao.ReadOnly     = !par_lHabilitar
1297:         loc_oPg2.grd_4c_Dados.ReadOnly          = !par_lHabilitar
1298:         loc_oPg2.obj_4c_CmdInsFtc.Enabled       = par_lHabilitar
1299:         loc_oPg2.obj_4c_Commandgroup1.Enabled   = par_lHabilitar
1300:     ENDPROC
1301: 
1302:     *===========================================================================
1303:     * AjustarBotoesPorModo - Ativa/desativa Salvar conforme modo
1304:     *===========================================================================
1305:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1306:         LOCAL loc_lEdicao, loc_oPg2
1307:         loc_lEdicao = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
1308:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1309: 
1310:         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
1311:         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1312:     ENDPROC
1313: 
1314:     *===========================================================================
1315:     * CarregarGradeRegra - ZAP + SQLEXEC + APPEND para preservar colunas do grid
1316:     * NAO chama rgrBO.CarregarLinhasRegra() pois ela recriar o cursor (Problem 34)
1317:     *===========================================================================
1318:     PROTECTED PROCEDURE CarregarGradeRegra(par_cCodigo)
1319:         LOCAL loc_lResultado, loc_nSQL, loc_cSQL
1320:         loc_lResultado = .F.
1321: 
1322:         TRY
1323:             IF USED("csSigCdRga")
1324:                 ZAP IN csSigCdRga
1325:             ENDIF
1326: 
1327:             loc_cSQL = "SELECT cidchaves, codigo, empresa, grupo, conta, colecao, " + ;
1328:                        "       quantidade, prioridade, grupopr, zerar, ordem "       + ;
1329:                        "  FROM SigCdRga "                                             + ;
1330:                        " WHERE codigo = " + EscaparSQL(par_cCodigo)                  + ;
1331:                        " ORDER BY prioridade"
1332: 
1333:             loc_nSQL = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RgaTmp")
1334: 
1335:             IF loc_nSQL > 0
1336:                 SELECT cursor_4c_RgaTmp
1337:                 SCAN
1338:                     SELECT csSigCdRga
1339:                     APPEND BLANK
1340:                     REPLACE cIdChaves  WITH cursor_4c_RgaTmp.cidchaves,  ;
1341:                             Codigo     WITH cursor_4c_RgaTmp.codigo,     ;
1342:                             Empresa    WITH cursor_4c_RgaTmp.empresa,    ;
1343:                             Grupo      WITH cursor_4c_RgaTmp.grupo,      ;
1344:                             Conta      WITH cursor_4c_RgaTmp.conta,      ;
1345:                             Colecao    WITH cursor_4c_RgaTmp.colecao,    ;
1346:                             Quantidade WITH cursor_4c_RgaTmp.quantidade, ;
1347:                             Prioridade WITH cursor_4c_RgaTmp.prioridade, ;
1348:                             GrupoPr    WITH cursor_4c_RgaTmp.grupopr,    ;
1349:                             Zerar      WITH cursor_4c_RgaTmp.zerar,      ;
1350:                             Ordem      WITH cursor_4c_RgaTmp.ordem
1351:                     SELECT cursor_4c_RgaTmp
1352:                 ENDSCAN
1353: 
1354:                 IF USED("cursor_4c_RgaTmp")
1355:                     USE IN cursor_4c_RgaTmp
1356:                 ENDIF
1357: 
1358:                 SELECT csSigCdRga

*-- Linhas 1383 a 1831:
1383: 
1384:     *===========================================================================
1385:     * GradeRegraAfterRowColChange - Validacoes ao sair de colunas do grid
1386:     * Deve ser PUBLIC - handler BINDEVENT (CLAUDE.md regra #3)
1387:     *===========================================================================
1388:     PROCEDURE GradeRegraAfterRowColChange(par_nColIndex)
1389:         IF !USED("csSigCdRga") OR EOF("csSigCdRga") OR DELETED("csSigCdRga")
1390:             RETURN
1391:         ENDIF
1392:         IF THIS.this_cModoAtual = "VISUALIZAR"
1393:             RETURN
1394:         ENDIF
1395: 
1396:         DO CASE
1397:         CASE par_nColIndex = 1
1398:             THIS.ValidarEmpresaGrid()
1399:         CASE par_nColIndex = 2
1400:             THIS.ValidarGrupoContabilGrid()
1401:         CASE par_nColIndex = 3
1402:             THIS.ValidarContaGrid()
1403:         CASE par_nColIndex = 4
1404:             THIS.ValidarColecaoGrid()
1405:         CASE par_nColIndex = 7
1406:             THIS.ValidarGrupoProdutoGrid()
1407:         CASE par_nColIndex = 8
1408:             THIS.ValidarZerarGrid()
1409:         CASE par_nColIndex = 9
1410:             THIS.ValidarOrdemGrid()
1411:         ENDCASE
1412:     ENDPROC
1413: 
1414:     *===========================================================================
1415:     * ValidarEmpresaGrid - Valida col Empresa via fAcessoEmpresa (sigacess.PRG)
1416:     *===========================================================================
1417:     PROTECTED PROCEDURE ValidarEmpresaGrid()
1418:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1419:             RETURN
1420:         ENDIF
1421: 
1422:         LOCAL loc_cEmp
1423:         SELECT csSigCdRga
1424:         loc_cEmp = ALLTRIM(csSigCdRga.Empresa)
1425: 
1426:         IF EMPTY(loc_cEmp)
1427:             RETURN
1428:         ENDIF
1429: 
1430:         TRY
1431:             *!! CORRETOR #110: fAcessoEmpresa() NAO existe na nova arquitetura. Substituir por bloco FormBuscaAuxiliar apontando SigCdEmp (chave Cemps modo C, Razas modo D). Ver Formsigatcrp.prg:2278-2378.
1432:             IF !fAcessoEmpresa(Usuar, 'C', loc_cEmp, .NULL., '')
1433:                 SELECT csSigCdRga
1434:                 REPLACE Empresa WITH ""
1435:             ENDIF
1436:         CATCH TO loException
1437:             MsgErro("Erro ao validar empresa:" + CHR(13) + loException.Message, "Erro")
1438:         ENDTRY
1439:     ENDPROC
1440: 
1441:     *===========================================================================
1442:     * ValidarGrupoContabilGrid - Valida col Grupo via fAcessoContab (sigacess.PRG)
1443:     *===========================================================================
1444:     PROTECTED PROCEDURE ValidarGrupoContabilGrid()
1445:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1446:             RETURN
1447:         ENDIF
1448: 
1449:         LOCAL loc_cGrp
1450:         SELECT csSigCdRga
1451:         loc_cGrp = ALLTRIM(csSigCdRga.Grupo)
1452: 
1453:         IF EMPTY(loc_cGrp)
1454:             RETURN
1455:         ENDIF
1456: 
1457:         TRY
1458:             IF !fAcessoContab(Usuar, 'C', loc_cGrp, .NULL., '')
1459:                 MsgAviso("Acesso Negado !!!", "Grupo Cont" + CHR(225) + "bil")
1460:                 SELECT csSigCdRga
1461:                 REPLACE Grupo WITH ""
1462:             ENDIF
1463:         CATCH TO loException
1464:             MsgErro("Erro ao validar grupo contabil:" + CHR(13) + loException.Message, "Erro")
1465:         ENDTRY
1466:     ENDPROC
1467: 
1468:     *===========================================================================
1469:     * ValidarContaGrid - Valida col Conta via fAcessoContas (sigacess.PRG)
1470:     * Depende do Grupo da mesma linha para contexto de acesso
1471:     *===========================================================================
1472:     PROTECTED PROCEDURE ValidarContaGrid()
1473:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1474:             RETURN
1475:         ENDIF
1476: 
1477:         LOCAL loc_cConta, loc_cGrp, loc_lRet
1478:         SELECT csSigCdRga
1479:         loc_cConta = ALLTRIM(csSigCdRga.Conta)
1480:         loc_cGrp   = ALLTRIM(csSigCdRga.Grupo)
1481: 
1482:         IF EMPTY(loc_cConta)
1483:             RETURN
1484:         ENDIF
1485: 
1486:         TRY
1487:             loc_lRet = fAcessoContas(Usuar, loc_cGrp, 'C', loc_cConta, .NULL., '')
1488:             IF !loc_lRet
1489:                 MsgAviso("Acesso Negado !!!", "Conta")
1490:                 SELECT csSigCdRga
1491:                 REPLACE Conta WITH ""
1492:             ENDIF
1493:         CATCH TO loException
1494:             MsgErro("Erro ao validar conta:" + CHR(13) + loException.Message, "Erro")
1495:         ENDTRY
1496:     ENDPROC
1497: 
1498:     *===========================================================================
1499:     * ValidarColecaoGrid - Valida col Colecao; abre lookup se nao encontrado
1500:     *===========================================================================
1501:     PROTECTED PROCEDURE ValidarColecaoGrid()
1502:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1503:             RETURN
1504:         ENDIF
1505: 
1506:         LOCAL loc_cCol, loc_nSQL
1507:         SELECT csSigCdRga
1508:         loc_cCol = ALLTRIM(csSigCdRga.Colecao)
1509: 
1510:         IF EMPTY(loc_cCol)
1511:             RETURN
1512:         ENDIF
1513: 
1514:         loc_nSQL = SQLEXEC(gnConnHandle, ;
1515:             "SELECT COUNT(*) AS qtd FROM SigCdCol WHERE Colecao = " + EscaparSQL(loc_cCol), ;
1516:             "cursor_4c_ValCol")
1517: 
1518:         IF loc_nSQL > 0 AND USED("cursor_4c_ValCol")
1519:             IF cursor_4c_ValCol.qtd = 0
1520:                 USE IN cursor_4c_ValCol
1521:                 THIS.AbrirLookupColecao()
1522:             ELSE
1523:                 USE IN cursor_4c_ValCol
1524:             ENDIF
1525:         ENDIF
1526:     ENDPROC
1527: 
1528:     *===========================================================================
1529:     * ValidarGrupoProdutoGrid - Valida col GrupoPr; abre lookup se nao encontrado
1530:     *===========================================================================
1531:     PROTECTED PROCEDURE ValidarGrupoProdutoGrid()
1532:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1533:             RETURN
1534:         ENDIF
1535: 
1536:         LOCAL loc_cGrp, loc_nSQL
1537:         SELECT csSigCdRga
1538:         loc_cGrp = ALLTRIM(csSigCdRga.GrupoPr)
1539: 
1540:         IF EMPTY(loc_cGrp)
1541:             RETURN
1542:         ENDIF
1543: 
1544:         loc_nSQL = SQLEXEC(gnConnHandle, ;
1545:             "SELECT COUNT(*) AS qtd FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cGrp), ;
1546:             "cursor_4c_ValGrp")
1547: 
1548:         IF loc_nSQL > 0 AND USED("cursor_4c_ValGrp")
1549:             IF cursor_4c_ValGrp.qtd = 0
1550:                 USE IN cursor_4c_ValGrp
1551:                 THIS.AbrirLookupGrupoProduto()
1552:             ELSE
1553:                 USE IN cursor_4c_ValGrp
1554:             ENDIF
1555:         ENDIF
1556:     ENDPROC
1557: 
1558:     *===========================================================================
1559:     * ValidarZerarGrid - Valida col Zerar: aceita somente S ou N
1560:     *===========================================================================
1561:     PROTECTED PROCEDURE ValidarZerarGrid()
1562:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1563:             RETURN
1564:         ENDIF
1565: 
1566:         LOCAL loc_cZerar
1567:         SELECT csSigCdRga
1568:         loc_cZerar = UPPER(ALLTRIM(csSigCdRga.Zerar))
1569: 
1570:         IF !EMPTY(loc_cZerar) AND loc_cZerar != "S" AND loc_cZerar != "N"
1571:             MsgAviso("Zerar deve ser S ou N.", "Zerar")
1572:             REPLACE Zerar WITH "S"
1573:         ENDIF
1574:     ENDPROC
1575: 
1576:     *===========================================================================
1577:     * ValidarOrdemGrid - Valida col Ordem: aceita somente P ou D
1578:     *===========================================================================
1579:     PROTECTED PROCEDURE ValidarOrdemGrid()
1580:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1581:             RETURN
1582:         ENDIF
1583: 
1584:         LOCAL loc_cOrdem
1585:         SELECT csSigCdRga
1586:         loc_cOrdem = UPPER(ALLTRIM(csSigCdRga.Ordem))
1587: 
1588:         IF !EMPTY(loc_cOrdem) AND loc_cOrdem != "P" AND loc_cOrdem != "D"
1589:             MsgAviso("Ordem deve ser P ou D.", "Ordem")
1590:             REPLACE Ordem WITH "P"
1591:         ENDIF
1592:     ENDPROC
1593: 
1594:     *===========================================================================
1595:     * CmdInsRowClick - Insere nova linha em branco no grid de regras
1596:     *===========================================================================
1597:     PROCEDURE CmdInsRowClick()
1598:         IF !USED("csSigCdRga") OR THIS.this_cModoAtual = "VISUALIZAR"
1599:             RETURN
1600:         ENDIF
1601: 
1602:         LOCAL loc_nProx, loc_cIdChav, loc_cCodigo
1603:         SELECT csSigCdRga
1604:         CALCULATE MAX(Prioridade) TO loc_nProx
1605:         loc_nProx   = loc_nProx + 1
1606:         loc_cIdChav = ALLTRIM(THIS.this_oBusinessObject.this_cCidChaves)
1607:         loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1608: 
1609:         APPEND BLANK IN csSigCdRga
1610:         SELECT csSigCdRga
1611:         GO BOTTOM
1612:         REPLACE cIdChaves  WITH loc_cIdChav, ;
1613:                 Codigo     WITH loc_cCodigo, ;
1614:                 Prioridade WITH loc_nProx
1615: 
1616:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1617:     ENDPROC
1618: 
1619:     *===========================================================================
1620:     * CmdDelRowClick - Marca linha atual do grid como excluida (DELETE)
1621:     *===========================================================================
1622:     PROCEDURE CmdDelRowClick()
1623:         IF !USED("csSigCdRga") OR RECCOUNT("csSigCdRga") = 0 OR EOF("csSigCdRga")
1624:             RETURN
1625:         ENDIF
1626:         IF THIS.this_cModoAtual = "VISUALIZAR" OR DELETED("csSigCdRga")
1627:             RETURN
1628:         ENDIF
1629: 
1630:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta linha?", ;
1631:                        "Excluir Linha")
1632:             SELECT csSigCdRga
1633:             DELETE
1634:             SET DELETED ON
1635:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1636:         ENDIF
1637:     ENDPROC
1638: 
1639:     *===========================================================================
1640:     * CmdMoveUpClick - Move a linha atual para cima (troca Prioridade com anterior)
1641:     *===========================================================================
1642:     PROCEDURE CmdMoveUpClick()
1643:         IF !USED("csSigCdRga") OR RECCOUNT("csSigCdRga") = 0 OR EOF("csSigCdRga")
1644:             RETURN
1645:         ENDIF
1646:         IF THIS.this_cModoAtual = "VISUALIZAR" OR DELETED("csSigCdRga")
1647:             RETURN
1648:         ENDIF
1649: 
1650:         LOCAL loc_nAtual, loc_nAnterior
1651:         SELECT csSigCdRga
1652:         loc_nAtual    = csSigCdRga.Prioridade
1653:         loc_nAnterior = loc_nAtual - 1
1654: 
1655:         IF loc_nAtual <= 1
1656:             RETURN
1657:         ENDIF
1658: 
1659:         UPDATE csSigCdRga SET Prioridade = 0           WHERE Prioridade = loc_nAtual
1660:         UPDATE csSigCdRga SET Prioridade = loc_nAtual  WHERE Prioridade = loc_nAnterior
1661:         UPDATE csSigCdRga SET Prioridade = loc_nAnterior WHERE Prioridade = 0
1662: 
1663:         SELECT csSigCdRga
1664:         INDEX ON Prioridade TAG PriIdx
1665:         SET ORDER TO TAG PriIdx
1666:         LOCATE FOR Prioridade = loc_nAnterior
1667: 
1668:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1669:     ENDPROC
1670: 
1671:     *===========================================================================
1672:     * CmdMoveDownClick - Move a linha atual para baixo (troca Prioridade com proxima)
1673:     *===========================================================================
1674:     PROCEDURE CmdMoveDownClick()
1675:         IF !USED("csSigCdRga") OR RECCOUNT("csSigCdRga") = 0 OR EOF("csSigCdRga")
1676:             RETURN
1677:         ENDIF
1678:         IF THIS.this_cModoAtual = "VISUALIZAR" OR DELETED("csSigCdRga")
1679:             RETURN
1680:         ENDIF
1681: 
1682:         LOCAL loc_nAtual, loc_nProximo, loc_nMax
1683:         SELECT csSigCdRga
1684:         loc_nAtual  = csSigCdRga.Prioridade
1685:         CALCULATE MAX(Prioridade) TO loc_nMax
1686:         loc_nProximo = loc_nAtual + 1
1687: 
1688:         IF loc_nAtual >= loc_nMax
1689:             RETURN
1690:         ENDIF
1691: 
1692:         UPDATE csSigCdRga SET Prioridade = 0           WHERE Prioridade = loc_nAtual
1693:         UPDATE csSigCdRga SET Prioridade = loc_nAtual  WHERE Prioridade = loc_nProximo
1694:         UPDATE csSigCdRga SET Prioridade = loc_nProximo WHERE Prioridade = 0
1695: 
1696:         SELECT csSigCdRga
1697:         INDEX ON Prioridade TAG PriIdx
1698:         SET ORDER TO TAG PriIdx
1699:         LOCATE FOR Prioridade = loc_nProximo
1700: 
1701:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1702:     ENDPROC
1703: 
1704:     *===========================================================================
1705:     * AbrirLookupColecao - FormBuscaAuxiliar para SigCdCol (Pattern A canonico)
1706:     *===========================================================================
1707:     PROCEDURE AbrirLookupColecao()
1708:         LOCAL loc_oBusca, loc_nSQL, loc_cValAtual, loc_cSQL
1709:         loc_cValAtual = ""
1710: 
1711:         IF USED("csSigCdRga") AND !EOF("csSigCdRga") AND !DELETED("csSigCdRga")
1712:             SELECT csSigCdRga
1713:             loc_cValAtual = ALLTRIM(csSigCdRga.Colecao)
1714:         ENDIF
1715: 
1716:         IF EMPTY(loc_cValAtual)
1717:             loc_cSQL = "SELECT Colecao, Descs FROM SigCdCol ORDER BY Colecao"
1718:         ELSE
1719:             loc_cSQL = "SELECT Colecao, Descs FROM SigCdCol " + ;
1720:                        " WHERE Colecao LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
1721:                        " ORDER BY Colecao"
1722:         ENDIF
1723: 
1724:         loc_nSQL = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCol")
1725: 
1726:         IF loc_nSQL > 0 AND USED("cursor_4c_BuscaCol")
1727:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1728:             IF VARTYPE(loc_oBusca) = "O"
1729:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaCol", "Colecao", "Descs", ;
1730:                     "Cole" + CHR(231) + CHR(227) + "o")
1731:                 IF loc_oBusca.Mostrar()
1732:                     IF USED("csSigCdRga") AND !EOF("csSigCdRga")
1733:                         SELECT csSigCdRga
1734:                         REPLACE Colecao WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
1735:                     ENDIF
1736:                 ENDIF
1737:                 loc_oBusca.Release()
1738:             ENDIF
1739:             IF USED("cursor_4c_BuscaCol")
1740:                 USE IN cursor_4c_BuscaCol
1741:             ENDIF
1742:         ENDIF
1743: 
1744:         IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
1745:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1746:         ENDIF
1747:     ENDPROC
1748: 
1749:     *===========================================================================
1750:     * AbrirLookupGrupoProduto - FormBuscaAuxiliar para SigCdGrp (Pattern A canonico)
1751:     *===========================================================================
1752:     PROCEDURE AbrirLookupGrupoProduto()
1753:         LOCAL loc_oBusca, loc_nSQL, loc_cValAtual, loc_cSQL
1754:         loc_cValAtual = ""
1755: 
1756:         IF USED("csSigCdRga") AND !EOF("csSigCdRga") AND !DELETED("csSigCdRga")
1757:             SELECT csSigCdRga
1758:             loc_cValAtual = ALLTRIM(csSigCdRga.GrupoPr)
1759:         ENDIF
1760: 
1761:         IF EMPTY(loc_cValAtual)
1762:             loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp ORDER BY CGrus"
1763:         ELSE
1764:             loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp " + ;
1765:                        " WHERE CGrus LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
1766:                        " ORDER BY CGrus"
1767:         ENDIF
1768: 
1769:         loc_nSQL = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrp")
1770: 
1771:         IF loc_nSQL > 0 AND USED("cursor_4c_BuscaGrp")
1772:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1773:             IF VARTYPE(loc_oBusca) = "O"
1774:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaGrp", "CGrus", "DGrus", ;
1775:                     "Grupo de Produto")
1776:                 IF loc_oBusca.Mostrar()
1777:                     IF USED("csSigCdRga") AND !EOF("csSigCdRga")
1778:                         SELECT csSigCdRga
1779:                         REPLACE GrupoPr WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
1780:                     ENDIF
1781:                 ENDIF
1782:                 loc_oBusca.Release()
1783:             ENDIF
1784:             IF USED("cursor_4c_BuscaGrp")
1785:                 USE IN cursor_4c_BuscaGrp
1786:             ENDIF
1787:         ENDIF
1788: 
1789:         IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
1790:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1791:         ENDIF
1792:     ENDPROC
1793: 
1794:     *===========================================================================
1795:     * DescricaoLostFocus - Insere linha vazia no grid ao sair do campo Descricao
1796:     * Deve ser PUBLIC - handler BINDEVENT (CLAUDE.md regra #3)
1797:     * Espelha: GetDescricao.LostFocus no legado (SIGCDRGR.SCX:1560-1564)
1798:     *===========================================================================
1799:     PROCEDURE DescricaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1800:         LOCAL loc_oPg2
1801:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1802: 
1803:         IF !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)) AND ;
1804:            INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1805:             THIS.CmdInsRowClick()
1806:             IF VARTYPE(loc_oPg2.grd_4c_Dados) = "O"
1807:                 loc_oPg2.grd_4c_Dados.SetFocus()
1808:             ENDIF
1809:         ENDIF
1810:     ENDPROC
1811: 
1812:     *===========================================================================
1813:     * Destroy - Libera recursos ao fechar o formulario
1814:     *===========================================================================
1815:     PROCEDURE Destroy()
1816:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1817:             THIS.this_oBusinessObject = .NULL.
1818:         ENDIF
1819: 
1820:         IF USED("cursor_4c_Dados")
1821:             USE IN cursor_4c_Dados
1822:         ENDIF
1823: 
1824:         IF USED("csSigCdRga")
1825:             USE IN csSigCdRga
1826:         ENDIF
1827: 
1828:         DODEFAULT()
1829:     ENDPROC
1830: 
1831: ENDDEFINE


### BO (C:\4c\projeto\app\classes\rgrBO.prg):
*==============================================================================
* rgrBO.prg - Business Object para Regras de E-Commerce
* Tabela principal : SigCdRGR
* Tabela detalhe   : SigCdRga (gerenciada via cursor csSigCdRga)
* Form relacionado : Formrgr.prg
*==============================================================================

DEFINE CLASS rgrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - SigCdRGR (cabecalho da regra)
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""   && cidchaves  char(20) - chave interna (fUniqueIds)
    this_cCodigo     = ""   && codigo     char(10) - codigo da regra (chave visivel)
    this_cDescricao  = ""   && descricao  char(40) - descricao
    this_dDatas      = {}   && datas      datetime - data de inclusao
    this_dDtaAlts    = {}   && dtaalts    datetime - data de alteracao
    this_cObservacao = ""   && observacao text     - observacao
    this_cUsaAlts    = ""   && usualts    char(10) - usuario que alterou
    this_cUsuIncs    = ""   && usuincs    char(10) - usuario que incluiu
    this_nInativas   = 0    && inativas   numeric(1,0) - 0=ativo / 1=inativo
    this_nValor      = 0    && valor      numeric(12,2)- valor minimo do pedido

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdRGR"
        THIS.this_cCampoChave = "Codigo"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave interna para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de regras para o Grid da Page1
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.codigo, a.descricao," + ;
                       " a.inativas, a.valor" + ;
                       " FROM SigCdRGR a" + ;
                       " ORDER BY a.codigo"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar regras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar regras:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro RGR pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.codigo, a.descricao, a.datas," + ;
                       " a.dtaalts, a.observacao, a.usualts, a.usuincs," + ;
                       " a.inativas, a.valor" + ;
                       " FROM SigCdRGR a" + ;
                       " WHERE a.codigo = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCodigo     = TratarNulo(codigo,     "C")
            THIS.this_cDescricao  = TratarNulo(descricao,  "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_dDtaAlts    = TratarNulo(dtaalts,    "D")
            THIS.this_cObservacao = TratarNulo(observacao,  "")
            THIS.this_cUsaAlts    = TratarNulo(usualts,    "C")
            THIS.this_cUsuIncs    = TratarNulo(usuincs,    "C")
            THIS.this_nInativas   = TratarNulo(inativas,   "N")
            THIS.this_nValor      = TratarNulo(valor,      "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLinhasRegra - Popula cursor csSigCdRga com linhas do servidor
    *--------------------------------------------------------------------------
    FUNCTION CarregarLinhasRegra(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("csSigCdRga")
                USE IN csSigCdRga
            ENDIF

            SET NULL ON
            CREATE CURSOR csSigCdRga ( ;
                cIdChaves  C(20), ;
                Codigo     C(10), ;
                Empresa    C(3),  ;
                Grupo      C(10), ;
                Conta      C(10), ;
                Colecao    C(20), ;
                Quantidade N(3,0),;
                Prioridade N(3,0),;
                GrupoPr    C(3),  ;
                Zerar      C(1),  ;
                Ordem      C(1)   ;
            )
            SET NULL OFF

            IF NOT EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT a.cidchaves, a.codigo, a.empresa, a.grupo," + ;
                           " a.conta, a.colecao, a.quantidade, a.prioridade," + ;
                           " a.grupopr, a.zerar, a.ordem" + ;
                           " FROM SigCdRga a" + ;
                           " WHERE a.codigo = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                           " ORDER BY a.prioridade"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_LinhasRgr")
                    TABLEREVERT(.T., "cursor_4c_LinhasRgr")
                    USE IN cursor_4c_LinhasRgr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhasRgr")
                IF loc_nResultado >= 0
                    IF RECCOUNT("cursor_4c_LinhasRgr") > 0
                        SELECT cursor_4c_LinhasRgr
                        GO TOP
                        SCAN
                            SELECT csSigCdRga
                            APPEND BLANK
                            REPLACE cIdChaves  WITH ALLTRIM(cursor_4c_LinhasRgr.cidchaves)
                            REPLACE Codigo     WITH ALLTRIM(cursor_4c_LinhasRgr.codigo)
                            REPLACE Empresa    WITH ALLTRIM(cursor_4c_LinhasRgr.empresa)
                            REPLACE Grupo      WITH ALLTRIM(cursor_4c_LinhasRgr.grupo)
                            REPLACE Conta      WITH ALLTRIM(cursor_4c_LinhasRgr.conta)
                            REPLACE Colecao    WITH ALLTRIM(cursor_4c_LinhasRgr.colecao)
                            REPLACE Quantidade WITH cursor_4c_LinhasRgr.quantidade
                            REPLACE Prioridade WITH cursor_4c_LinhasRgr.prioridade
                            REPLACE GrupoPr    WITH ALLTRIM(cursor_4c_LinhasRgr.grupopr)
                            REPLACE Zerar      WITH ALLTRIM(cursor_4c_LinhasRgr.zerar)
                            REPLACE Ordem      WITH ALLTRIM(cursor_4c_LinhasRgr.ordem)
                            SELECT cursor_4c_LinhasRgr
                        ENDSCAN
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar linhas de regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_LinhasRgr")
                    USE IN cursor_4c_LinhasRgr
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

            SELECT csSigCdRga
            GO TOP
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar linhas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinhasRegra - Insere linhas validas do csSigCdRga no SigCdRga
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION InserirLinhasRegra()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChaveRga
        loc_lSucesso = .T.

        IF NOT USED("csSigCdRga")
            RETURN .T.
        ENDIF

        TRY
            SELECT csSigCdRga
            GO TOP
            SCAN
                IF EMPTY(ALLTRIM(csSigCdRga.Empresa))    AND ;
                   EMPTY(ALLTRIM(csSigCdRga.Grupo))      AND ;
                   EMPTY(ALLTRIM(csSigCdRga.Conta))      AND ;
                   EMPTY(ALLTRIM(csSigCdRga.Colecao))    AND ;
                   EMPTY(ALLTRIM(csSigCdRga.GrupoPr))    AND ;
                   csSigCdRga.Quantidade = 0
                    LOOP
                ENDIF

                IF EMPTY(ALLTRIM(csSigCdRga.cIdChaves))
                    loc_cChaveRga = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
                ELSE
                    loc_cChaveRga = ALLTRIM(csSigCdRga.cIdChaves)
                ENDIF

                loc_cSQL = "INSERT INTO SigCdRga" + ;
                           " (cidchaves, codigo, empresa, grupo, conta, colecao," + ;
                           "  quantidade, prioridade, grupopr, zerar, ordem)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cChaveRga) + "," + ;
                           EscaparSQL(THIS.this_cCodigo) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Empresa)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Grupo)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Conta)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Colecao)) + "," + ;
                           FormatarNumeroSQL(csSigCdRga.Quantidade) + "," + ;
                           FormatarNumeroSQL(csSigCdRga.Prioridade) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.GrupoPr)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Zerar)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Ordem)) + ")"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_InsRga")
                    TABLEREVERT(.T., "cursor_4c_InsRga")
                    USE IN cursor_4c_InsRga
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRga")
                IF USED("cursor_4c_InsRga")
                    USE IN cursor_4c_InsRga
                ENDIF

                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir linha de regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir linhas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdRGR + SigCdRga (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)

            loc_cSQL = "INSERT INTO SigCdRGR" + ;
                       " (cidchaves, codigo, descricao, datas," + ;
                       "  observacao, usuincs, usualts, inativas, valor, dtaalts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(THIS.this_cObservacao) + "," + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       EscaparSQL("") + "," + ;
                       FormatarNumeroSQL(THIS.this_nInativas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                       "NULL)"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_InsRgr")
                TABLEREVERT(.T., "cursor_4c_InsRgr")
                USE IN cursor_4c_InsRgr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRgr")
            IF USED("cursor_4c_InsRgr")
                USE IN cursor_4c_InsRgr
            ENDIF

            IF loc_nResultado >= 0
                loc_lSucesso = THIS.InserirLinhasRegra()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdRGR + DELETE/INSERT SigCdRga (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdRGR SET" + ;
                       " descricao = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " observacao = " + EscaparSQL(THIS.this_cObservacao) + "," + ;
                       " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       " inativas = " + FormatarNumeroSQL(THIS.this_nInativas) + "," + ;
                       " valor = " + FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                       " dtaalts = GETDATE()" + ;
                       " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_UpdRgr")
                TABLEREVERT(.T., "cursor_4c_UpdRgr")
                USE IN cursor_4c_UpdRgr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdRgr")
            IF USED("cursor_4c_UpdRgr")
                USE IN cursor_4c_UpdRgr
            ENDIF

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigCdRga WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_DelRga")
                    TABLEREVERT(.T., "cursor_4c_DelRga")
                    USE IN cursor_4c_DelRga
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRga")
                IF USED("cursor_4c_DelRga")
                    USE IN cursor_4c_DelRga
                ENDIF

                IF loc_nResultado >= 0
                    loc_lSucesso = THIS.InserirLinhasRegra()
                    IF loc_lSucesso
                        loc_cSQL = "UPDATE SigPrdWb SET qtds = 0 WHERE codregra = " + ;
                                   EscaparSQL(THIS.this_cCodigo)
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_UpdWb")
                            TABLEREVERT(.T., "cursor_4c_UpdWb")
                            USE IN cursor_4c_UpdWb
                        ENDIF

                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdWb")
                        IF USED("cursor_4c_UpdWb")
                            USE IN cursor_4c_UpdWb
                        ENDIF
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir linhas antigas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigCdRga + SigCdRGR (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRga WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelRga")
                TABLEREVERT(.T., "cursor_4c_DelRga")
                USE IN cursor_4c_DelRga
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRga")
            IF USED("cursor_4c_DelRga")
                USE IN cursor_4c_DelRga
            ENDIF

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigCdRGR WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_DelRgr")
                    TABLEREVERT(.T., "cursor_4c_DelRgr")
                    USE IN cursor_4c_DelRgr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgr")
                IF USED("cursor_4c_DelRgr")
                    USE IN cursor_4c_DelRgr
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir linhas de regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de cursores ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("csSigCdRga")
            USE IN csSigCdRga
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

