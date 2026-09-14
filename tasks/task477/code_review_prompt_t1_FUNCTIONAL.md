# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [BINDEVENT-PARAMS] Handler 'ValidarTipos' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarTipos(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarApura' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarApura(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarLanca' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarLanca(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarOper' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarOper(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrContabil' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrContabil(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarAutos' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarAutos(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'AutosLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE AutosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarOperac' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarOperac(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOcb.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1523 linhas total):

*-- Linhas 25 a 146:
25:     *===========================================================================
26:     * Init - Inicializa o formulario
27:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
28:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
29:     *===========================================================================
30:     PROCEDURE Init()
31:         RETURN DODEFAULT()
32:     ENDPROC
33: 
34:     *===========================================================================
35:     * InicializarForm - Configura estrutura completa
36:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
37:     *===========================================================================
38:     PROTECTED PROCEDURE InicializarForm()
39:         LOCAL loc_lSucesso
40:         loc_lSucesso = .F.
41: 
42:         TRY
43:             THIS.this_oBusinessObject = CREATEOBJECT("OcbBO")
44: 
45:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
46:                 MostrarErro("Erro ao criar OcbBO" + CHR(13) + ;
47:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
48:                     "FormOcb.InicializarForm")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Visible = .T.
54:                 THIS.pgf_4c_Paginas.ActivePage = 1
55:                 THIS.this_cModoAtual = "LISTA"
56: 
57:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
58:                     THIS.CarregarLista()
59:                 ENDIF
60: 
61:                 loc_lSucesso = .T.
62:             ENDIF
63: 
64:         CATCH TO loException
65:             MostrarErro("Erro ao inicializar FormOcb:" + CHR(13) + ;
66:                 loException.Message + CHR(13) + ;
67:                 "Linha: " + TRANSFORM(loException.LineNo), ;
68:                 "FormOcb.InicializarForm")
69:         ENDTRY
70: 
71:         RETURN loc_lSucesso
72:     ENDPROC
73: 
74:     *===========================================================================
75:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
76:     * Top=-29 para esconder abas; controles compensam +29 no Top
77:     *===========================================================================
78:     PROTECTED PROCEDURE ConfigurarPageFrame()
79:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
80: 
81:         WITH THIS.pgf_4c_Paginas
82:             .PageCount = 2
83:             .Top       = -29
84:             .Left      = 0
85:             .Width     = THIS.Width
86:             .Height    = THIS.Height + 29
87:             .Tabs      = .F.
88:             .Visible   = .T.
89: 
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93: 
94:             .Page2.Caption   = "Dados"
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.BackColor = RGB(255, 255, 255)
97:         ENDWITH
98: 
99:         THIS.ConfigurarPaginaLista()
100:         THIS.ConfigurarPaginaDados()
101:     ENDPROC
102: 
103:     *===========================================================================
104:     * ConfigurarPaginaLista - Configura Page1 com cabecalho, botoes CRUD e grid
105:     *===========================================================================
106:     PROTECTED PROCEDURE ConfigurarPaginaLista()
107:         LOCAL loc_oPagina
108:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
109: 
110:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
111:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112: 
113:         *-- Container Cabecalho (cntSombra no legado: Top=2+29=31)
114:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
115:         WITH loc_oPagina.cnt_4c_Cabecalho
116:             .Top         = 31
117:             .Left        = 0
118:             .Width       = THIS.Width
119:             .Height      = 80
120:             .BackColor   = RGB(100, 100, 100)
121:             .BorderWidth = 0
122:             .Visible     = .T.
123:         ENDWITH
124: 
125:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
126:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
127:             .Caption   = THIS.Caption
128:             .Top       = 15
129:             .Left      = 10
130:             .Width     = 769
131:             .Height    = 40
132:             .FontName  = "Tahoma"
133:             .FontSize  = 16
134:             .FontBold  = .T.
135:             .ForeColor = RGB(0, 0, 0)
136:             .BackStyle = 0
137:             .AutoSize  = .F.
138:             .Visible   = .T.
139:         ENDWITH
140: 
141:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
142:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
143:             .Caption   = THIS.Caption
144:             .Top       = 18
145:             .Left      = 10
146:             .Width     = 769

*-- Linhas 190 a 483:
190:             .AutoSize        = .F.
191:             .Visible         = .T.
192:         ENDWITH
193:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
194: 
195:         *-- Botao Visualizar
196:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
197:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
198:             .Caption         = "Visualizar"
199:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
200:             .PicturePosition = 13
201:             .Top             = 5
202:             .Left            = 80
203:             .Width           = 75
204:             .Height          = 75
205:             .FontName        = "Comic Sans MS"
206:             .FontSize        = 8
207:             .FontBold        = .T.
208:             .FontItalic      = .T.
209:             .ForeColor       = RGB(90, 90, 90)
210:             .BackColor       = RGB(255, 255, 255)
211:             .Themes          = .F.
212:             .SpecialEffect   = 0
213:             .MousePointer    = 15
214:             .WordWrap        = .T.
215:             .AutoSize        = .F.
216:             .Visible         = .T.
217:         ENDWITH
218:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
219: 
220:         *-- Botao Alterar
221:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
222:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
223:             .Caption         = "Alterar"
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
225:             .PicturePosition = 13
226:             .Top             = 5
227:             .Left            = 155
228:             .Width           = 75
229:             .Height          = 75
230:             .FontName        = "Comic Sans MS"
231:             .FontSize        = 8
232:             .FontBold        = .T.
233:             .FontItalic      = .T.
234:             .ForeColor       = RGB(90, 90, 90)
235:             .BackColor       = RGB(255, 255, 255)
236:             .Themes          = .F.
237:             .SpecialEffect   = 0
238:             .MousePointer    = 15
239:             .WordWrap        = .T.
240:             .AutoSize        = .F.
241:             .Visible         = .T.
242:         ENDWITH
243:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
244: 
245:         *-- Botao Excluir
246:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
247:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
248:             .Caption         = "Excluir"
249:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
250:             .PicturePosition = 13
251:             .Top             = 5
252:             .Left            = 230
253:             .Width           = 75
254:             .Height          = 75
255:             .FontName        = "Comic Sans MS"
256:             .FontSize        = 8
257:             .FontBold        = .T.
258:             .FontItalic      = .T.
259:             .ForeColor       = RGB(90, 90, 90)
260:             .BackColor       = RGB(255, 255, 255)
261:             .Themes          = .F.
262:             .SpecialEffect   = 0
263:             .MousePointer    = 15
264:             .WordWrap        = .T.
265:             .AutoSize        = .F.
266:             .Visible         = .T.
267:         ENDWITH
268:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
269: 
270:         *-- Botao Buscar
271:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
272:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
273:             .Caption         = "Buscar"
274:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
275:             .PicturePosition = 13
276:             .Top             = 5
277:             .Left            = 305
278:             .Width           = 75
279:             .Height          = 75
280:             .FontName        = "Comic Sans MS"
281:             .FontSize        = 8
282:             .FontBold        = .T.
283:             .FontItalic      = .T.
284:             .ForeColor       = RGB(90, 90, 90)
285:             .BackColor       = RGB(255, 255, 255)
286:             .Themes          = .F.
287:             .SpecialEffect   = 0
288:             .MousePointer    = 15
289:             .WordWrap        = .T.
290:             .AutoSize        = .F.
291:             .Visible         = .T.
292:         ENDWITH
293:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
294: 
295:         *-- Container Saida/Encerrar (canonico: Left=917, Top=28, Width=90, Height=85)
296:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
297:         WITH loc_oPagina.cnt_4c_Saida
298:             .Top         = 28
299:             .Left        = 917
300:             .Width       = 90
301:             .Height      = 85
302:             .BackStyle   = 0
303:             .BorderWidth = 0
304:             .Visible     = .T.
305:         ENDWITH
306: 
307:         *-- Botao Encerrar
308:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
309:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
310:             .Caption         = "Encerrar"
311:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
312:             .PicturePosition = 13
313:             .Top             = 5
314:             .Left            = 5
315:             .Width           = 75
316:             .Height          = 75
317:             .FontName        = "Comic Sans MS"
318:             .FontSize        = 8
319:             .FontBold        = .T.
320:             .FontItalic      = .T.
321:             .ForeColor       = RGB(90, 90, 90)
322:             .BackColor       = RGB(255, 255, 255)
323:             .Themes          = .F.
324:             .SpecialEffect   = 0
325:             .MousePointer    = 15
326:             .WordWrap        = .T.
327:             .AutoSize        = .F.
328:             .Visible         = .T.
329:         ENDWITH
330:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
331: 
332:         *-- Grid de lista (framework: Top=88+29=117, Left=26, Width=890)
333:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
334:         loc_oPagina.grd_4c_Lista.ColumnCount = 9
335: 
336:         WITH loc_oPagina.grd_4c_Lista
337:             .Top                = 117
338:             .Left               = 26
339:             .Width              = 890
340:             .Height             = 455
341:             .FontName           = "Verdana"
342:             .FontSize           = 8
343:             .ForeColor          = RGB(90, 90, 90)
344:             .BackColor          = RGB(255, 255, 255)
345:             .GridLineColor      = RGB(238, 238, 238)
346:             .HighlightBackColor = RGB(255, 255, 255)
347:             .HighlightForeColor = RGB(15, 41, 104)
348:             .HighlightStyle     = 2
349:             .DeleteMark         = .F.
350:             .RecordMark         = .F.
351:             .RowHeight          = 16
352:             .ScrollBars         = 2
353:             .GridLines          = 3
354:             .Visible            = .T.
355: 
356:             .Column1.Width  = 35
357:             .Column2.Width  = 80
358:             .Column3.Width  = 285
359:             .Column4.Width  = 65
360:             .Column5.Width  = 65
361:             .Column6.Width  = 65
362:             .Column7.Width  = 65
363:             .Column8.Width  = 45
364:             .Column9.Width  = 90
365:         ENDWITH
366: 
367:         THIS.TornarControlesVisiveis(loc_oPagina)
368:     ENDPROC
369: 
370:     *===========================================================================
371:     * ConfigurarPaginaDados - Configura Page2: botoes + primeira metade dos campos
372:     * Tops = valores originais (layout.json) + 29 (compensacao PageFrame.Top=-29)
373:     *===========================================================================
374:     PROTECTED PROCEDURE ConfigurarPaginaDados()
375:         LOCAL loc_oPagina
376:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
377: 
378:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
379:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
380: 
381:         *-- Container BotoesAcao - Salvar/Cancelar (Grupo_Salva no legado)
382:         *-- Canonico: Top=33 (4+29), Left=842, Width=160, Height=85
383:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
384:         WITH loc_oPagina.cnt_4c_BotoesAcao
385:             .Top         = 33
386:             .Left        = 842
387:             .Width       = 160
388:             .Height      = 85
389:             .BackStyle = 1
390:             .BackColor = RGB(255, 255, 255)
391:             .BorderWidth = 0
392:             .Visible     = .T.
393:         ENDWITH
394: 
395:         *-- Botao Salvar (Confirmar)
396:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
397:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
398:             .Caption         = "Confirmar"
399:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
400:             .PicturePosition = 13
401:             .Top             = 5
402:             .Left            = 5
403:             .Width           = 75
404:             .Height          = 75
405:             .FontName        = "Comic Sans MS"
406:             .FontSize        = 8
407:             .FontBold        = .T.
408:             .FontItalic      = .T.
409:             .ForeColor       = RGB(90, 90, 90)
410:             .BackColor       = RGB(255, 255, 255)
411:             .Themes          = .F.
412:             .SpecialEffect   = 0
413:             .MousePointer    = 15
414:             .WordWrap        = .T.
415:             .AutoSize        = .F.
416:             .Visible         = .T.
417:         ENDWITH
418:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
419: 
420:         *-- Botao Cancelar
421:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
422:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
423:             .Caption         = "Encerrar"
424:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
425:             .PicturePosition = 13
426:             .Top             = 5
427:             .Left            = 80
428:             .Width           = 75
429:             .Height          = 75
430:             .FontName        = "Comic Sans MS"
431:             .FontSize        = 8
432:             .FontBold        = .T.
433:             .FontItalic      = .T.
434:             .ForeColor       = RGB(90, 90, 90)
435:             .BackColor       = RGB(255, 255, 255)
436:             .Themes          = .F.
437:             .SpecialEffect   = 0
438:             .MousePointer    = 15
439:             .WordWrap        = .T.
440:             .AutoSize        = .F.
441:             .Visible         = .T.
442:         ENDWITH
443:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
444: 
445:         *-- =====================================================================
446:         *-- CAMPOS - Primeira Metade (50%)
447:         *-- =====================================================================
448: 
449:         *-- Grupo 1: GetTipos (tipos char 1: O/J) - original Top=187 -> 187+29=216
450:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
451:         WITH loc_oPagina.lbl_4c_Label3
452:             .Caption   = "Tipos (O/J) :"
453:             .Top       = 219
454:             .Left      = 222
455:             .Width     = 62
456:             .Height    = 17
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:             .FontBold  = .F.
460:             .ForeColor = RGB(90, 90, 90)
461:             .BackStyle = 0
462:             .AutoSize  = .F.
463:             .Visible   = .T.
464:         ENDWITH
465: 
466:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
467:         WITH loc_oPagina.lbl_4c_Label4
468:             .Caption   = "< O >corr" + CHR(234) + "ncia  < J >ustificativa"
469:             .Top       = 219
470:             .Left      = 316
471:             .Width     = 161
472:             .Height    = 17
473:             .FontName  = "Tahoma"
474:             .FontSize  = 8
475:             .FontBold  = .F.
476:             .ForeColor = RGB(90, 90, 90)
477:             .BackStyle = 0
478:             .AutoSize  = .F.
479:             .Visible   = .T.
480:         ENDWITH
481: 
482:         loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
483:         WITH loc_oPagina.txt_4c_Tipos

*-- Linhas 491 a 534:
491:             .FontSize  = 8
492:             .Visible   = .T.
493:         ENDWITH
494:         BINDEVENT(loc_oPagina.txt_4c_Tipos, "KeyPress", THIS, "ValidarTipos")
495: 
496:         *-- Grupo 2: getCodigos (codigos char 10) - original Top=213 -> 213+29=242
497:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
498:         WITH loc_oPagina.lbl_4c_Label1
499:             .Caption   = "C" + CHR(243) + "digo :"
500:             .Top       = 245
501:             .Left      = 242
502:             .Width     = 42
503:             .Height    = 17
504:             .FontName  = "Tahoma"
505:             .FontSize  = 8
506:             .FontBold  = .F.
507:             .ForeColor = RGB(90, 90, 90)
508:             .BackStyle = 0
509:             .AutoSize  = .F.
510:             .Visible   = .T.
511:         ENDWITH
512: 
513:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
514:         WITH loc_oPagina.txt_4c_Codigos
515:             .Value     = ""
516:             .Top       = 242
517:             .Left      = 288
518:             .Width     = 80
519:             .Height    = 23
520:             .MaxLength = 10
521:             .FontName  = "Tahoma"
522:             .FontSize  = 8
523:             .Visible   = .T.
524:         ENDWITH
525: 
526:         *-- Grupo 3: getDescrs (descrs char 40) - original Top=239 -> 239+29=268
527:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
528:         WITH loc_oPagina.lbl_4c_Label2
529:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
530:             .Top       = 271
531:             .Left      = 229
532:             .Width     = 55
533:             .Height    = 17
534:             .FontName  = "Tahoma"

*-- Linhas 598 a 641:
598:             .FontSize  = 8
599:             .Visible   = .T.
600:         ENDWITH
601:         BINDEVENT(loc_oPagina.txt_4c_Apura, "KeyPress", THIS, "ValidarApura")
602: 
603:         *-- =====================================================================
604:         *-- CAMPOS - Segunda Metade (50%) - Fase 6
605:         *-- =====================================================================
606: 
607:         *-- Grupo 5: Get_Lanca (lancas char 1: S/N) - original Top=291 -> 291+29=320
608:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
609:         WITH loc_oPagina.lbl_4c_Label5
610:             .Caption   = "Lan" + CHR(231) + "a C/C :"
611:             .Top       = 323
612:             .Left      = 226
613:             .Width     = 58
614:             .Height    = 17
615:             .FontName  = "Tahoma"
616:             .FontSize  = 8
617:             .FontBold  = .F.
618:             .ForeColor = RGB(90, 90, 90)
619:             .BackStyle = 0
620:             .AutoSize  = .F.
621:             .Visible   = .T.
622:         ENDWITH
623: 
624:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
625:         WITH loc_oPagina.lbl_4c_Label8
626:             .Caption   = "<S>im  <N>" + CHR(227) + "o"
627:             .Top       = 324
628:             .Left      = 316
629:             .Width     = 75
630:             .Height    = 17
631:             .FontName  = "Tahoma"
632:             .FontSize  = 8
633:             .FontBold  = .F.
634:             .ForeColor = RGB(90, 90, 90)
635:             .BackStyle = 0
636:             .AutoSize  = .F.
637:             .Visible   = .T.
638:         ENDWITH
639: 
640:         loc_oPagina.AddObject("txt_4c_Lanca", "TextBox")
641:         WITH loc_oPagina.txt_4c_Lanca

*-- Linhas 649 a 821:
649:             .FontSize  = 8
650:             .Visible   = .T.
651:         ENDWITH
652:         BINDEVENT(loc_oPagina.txt_4c_Lanca, "KeyPress", THIS, "ValidarLanca")
653: 
654:         *-- Grupo 6: GetOper (opers char 2: DB/CR/DF/NL) - original Top=317 -> 317+29=346
655:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
656:         WITH loc_oPagina.lbl_4c_Label6
657:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
658:             .Top       = 349
659:             .Left      = 228
660:             .Width     = 56
661:             .Height    = 17
662:             .FontName  = "Tahoma"
663:             .FontSize  = 8
664:             .FontBold  = .F.
665:             .ForeColor = RGB(90, 90, 90)
666:             .BackStyle = 0
667:             .AutoSize  = .F.
668:             .Visible   = .T.
669:         ENDWITH
670: 
671:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
672:         WITH loc_oPagina.lbl_4c_Label7
673:             .Caption   = "<DB>D" + CHR(233) + "bito <CR>cr" + CHR(233) + ;
674:                          "dito <DF>Diferen" + CHR(231) + "a <NL>Nulo"
675:             .Top       = 349
676:             .Left      = 316
677:             .Width     = 258
678:             .Height    = 17
679:             .FontName  = "Tahoma"
680:             .FontSize  = 8
681:             .FontBold  = .F.
682:             .ForeColor = RGB(90, 90, 90)
683:             .BackStyle = 0
684:             .AutoSize  = .F.
685:             .Visible   = .T.
686:         ENDWITH
687: 
688:         loc_oPagina.AddObject("txt_4c_Oper", "TextBox")
689:         WITH loc_oPagina.txt_4c_Oper
690:             .Value     = ""
691:             .Top       = 346
692:             .Left      = 288
693:             .Width     = 27
694:             .Height    = 23
695:             .MaxLength = 2
696:             .FontName  = "Tahoma"
697:             .FontSize  = 8
698:             .Visible   = .T.
699:         ENDWITH
700:         BINDEVENT(loc_oPagina.txt_4c_Oper, "KeyPress", THIS, "ValidarOper")
701: 
702:         *-- Grupo 7: GetGrContabil (grupos char 10) - original Top=343 -> 343+29=372 - LOOKUP SigCdGcr
703:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
704:         WITH loc_oPagina.lbl_4c_Label9
705:             .Caption   = "Gr.Cont" + CHR(225) + "bil :"
706:             .Top       = 376
707:             .Left      = 221
708:             .Width     = 63
709:             .Height    = 17
710:             .FontName  = "Tahoma"
711:             .FontSize  = 8
712:             .FontBold  = .F.
713:             .ForeColor = RGB(90, 90, 90)
714:             .BackStyle = 0
715:             .AutoSize  = .F.
716:             .Visible   = .T.
717:         ENDWITH
718: 
719:         loc_oPagina.AddObject("txt_4c_GrContabil", "TextBox")
720:         WITH loc_oPagina.txt_4c_GrContabil
721:             .Value     = ""
722:             .Top       = 372
723:             .Left      = 288
724:             .Width     = 80
725:             .Height    = 23
726:             .MaxLength = 10
727:             .FontName  = "Tahoma"
728:             .FontSize  = 8
729:             .Visible   = .T.
730:         ENDWITH
731:         BINDEVENT(loc_oPagina.txt_4c_GrContabil, "KeyPress", THIS, "GrContabilLookupKeyPress")
732:         BINDEVENT(loc_oPagina.txt_4c_GrContabil, "DblClick", THIS, "GrContabilLookupDblClick")
733:         BINDEVENT(loc_oPagina.txt_4c_GrContabil, "KeyPress",    THIS, "ValidarGrContabil")
734: 
735:         *-- Grupo 8: GetAutos (autos char 1: S/N) - original Top=369 -> 369+29=398
736:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
737:         WITH loc_oPagina.lbl_4c_Label10
738:             .Caption   = "Autom" + CHR(225) + "tico :"
739:             .Top       = 401
740:             .Left      = 221
741:             .Width     = 63
742:             .Height    = 17
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .FontBold  = .F.
746:             .ForeColor = RGB(90, 90, 90)
747:             .BackStyle = 0
748:             .AutoSize  = .F.
749:             .Visible   = .T.
750:         ENDWITH
751: 
752:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
753:         WITH loc_oPagina.lbl_4c_Label11
754:             .Caption   = "<S>im  <N>" + CHR(227) + "o"
755:             .Top       = 402
756:             .Left      = 316
757:             .Width     = 75
758:             .Height    = 17
759:             .FontName  = "Tahoma"
760:             .FontSize  = 8
761:             .FontBold  = .F.
762:             .ForeColor = RGB(90, 90, 90)
763:             .BackStyle = 0
764:             .AutoSize  = .F.
765:             .Visible   = .T.
766:         ENDWITH
767: 
768:         loc_oPagina.AddObject("txt_4c_Autos", "TextBox")
769:         WITH loc_oPagina.txt_4c_Autos
770:             .Value     = ""
771:             .Top       = 398
772:             .Left      = 288
773:             .Width     = 17
774:             .Height    = 23
775:             .MaxLength = 1
776:             .FontName  = "Tahoma"
777:             .FontSize  = 8
778:             .Visible   = .T.
779:         ENDWITH
780:         BINDEVENT(loc_oPagina.txt_4c_Autos, "KeyPress", THIS, "ValidarAutos")
781:         BINDEVENT(loc_oPagina.txt_4c_Autos, "KeyPress", THIS, "AutosLostFocus")
782: 
783:         *-- Grupo 9: GetOperac (operacaos char 1: E/S) - original Top=395 -> 395+29=424
784:         *-- When: habilitado apenas quando Autos = "S"
785:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
786:         WITH loc_oPagina.lbl_4c_Label12
787:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
788:             .Top       = 427
789:             .Left      = 228
790:             .Width     = 56
791:             .Height    = 17
792:             .FontName  = "Tahoma"
793:             .FontSize  = 8
794:             .FontBold  = .F.
795:             .ForeColor = RGB(90, 90, 90)
796:             .BackStyle = 0
797:             .AutoSize  = .F.
798:             .Visible   = .T.
799:         ENDWITH
800: 
801:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
802:         WITH loc_oPagina.lbl_4c_Label13
803:             .Caption   = "<E>ntrada  <S>a" + CHR(237) + "da"
804:             .Top       = 428
805:             .Left      = 316
806:             .Width     = 104
807:             .Height    = 17
808:             .FontName  = "Tahoma"
809:             .FontSize  = 8
810:             .FontBold  = .F.
811:             .ForeColor = RGB(90, 90, 90)
812:             .BackStyle = 0
813:             .AutoSize  = .F.
814:             .Visible   = .T.
815:         ENDWITH
816: 
817:         loc_oPagina.AddObject("txt_4c_Operac", "TextBox")
818:         WITH loc_oPagina.txt_4c_Operac
819:             .Value     = ""
820:             .Top       = 424
821:             .Left      = 288

*-- Linhas 827 a 872:
827:             .Enabled   = .F.
828:             .Visible   = .T.
829:         ENDWITH
830:         BINDEVENT(loc_oPagina.txt_4c_Operac, "KeyPress", THIS, "ValidarOperac")
831: 
832:         THIS.TornarControlesVisiveis(loc_oPagina)
833:     ENDPROC
834: 
835:     *===========================================================================
836:     * CarregarLista - Carrega dados no Grid da Page1
837:     *===========================================================================
838:     PROTECTED FUNCTION CarregarLista()
839:         LOCAL loc_lSucesso, loc_oGrid
840:         loc_lSucesso = .F.
841: 
842:         TRY
843:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
844:                 loc_lSucesso = .T.
845:             ELSE
846:                 IF THIS.this_oBusinessObject.Buscar("")
847:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
848: 
849:                     loc_oGrid.ColumnCount = 9
850:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
851: 
852:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
853:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.codigos"
854:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
855:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.apuras"
856:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.lancas"
857:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.opers"
858:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.autos"
859:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.operacaos"
860:                     loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.grupos"
861: 
862:                     loc_oGrid.Column1.Header1.Caption = "Tipo"
863:                     loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
864:                     loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
865:                     loc_oGrid.Column4.Header1.Caption = "Apura" + CHR(231) + CHR(227) + "o"
866:                     loc_oGrid.Column5.Header1.Caption = "Lan" + CHR(231) + "a C/C"
867:                     loc_oGrid.Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
868:                     loc_oGrid.Column7.Header1.Caption = "Autom" + CHR(225) + "tico"
869:                     loc_oGrid.Column8.Header1.Caption = "Op."
870:                     loc_oGrid.Column9.Header1.Caption = "Gr.Cont" + CHR(225) + "bil"
871: 
872:                     THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 882 a 1523:
882:     ENDFUNC
883: 
884:     *===========================================================================
885:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
886:     *===========================================================================
887:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
888:         LOCAL loc_nI, loc_oObjeto
889: 
890:         FOR loc_nI = 1 TO par_oContainer.ControlCount
891:             loc_oObjeto = par_oContainer.Controls(loc_nI)
892: 
893:             IF VARTYPE(loc_oObjeto) = "O"
894:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
895:                     loc_oObjeto.Visible = .T.
896:                 ENDIF
897: 
898:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
899:                     LOCAL loc_nP
900:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
901:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
902:                     ENDFOR
903:                 ENDIF
904: 
905:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
906:                     THIS.TornarControlesVisiveis(loc_oObjeto)
907:                 ENDIF
908:             ENDIF
909:         ENDFOR
910:     ENDPROC
911: 
912:     *===========================================================================
913:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
914:     *===========================================================================
915:     PROCEDURE AlternarPagina(par_nPagina)
916:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
917:             RETURN .F.
918:         ENDIF
919: 
920:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
921: 
922:         IF par_nPagina = 1
923:             THIS.CarregarLista()
924:         ENDIF
925: 
926:         RETURN .T.
927:     ENDPROC
928: 
929:     *===========================================================================
930:     * FormatarGridLista - Aplica formatacao visual ao grid
931:     *===========================================================================
932:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
933:         WITH par_oGrid
934:             .FontName = "Verdana"
935:             .FontSize = 8
936:         ENDWITH
937:     ENDPROC
938: 
939:     *===========================================================================
940:     * BtnEncerrarClick - Fecha o formulario
941:     *===========================================================================
942:     PROCEDURE BtnEncerrarClick()
943:         THIS.Release()
944:     ENDPROC
945: 
946:     *===========================================================================
947:     * BtnBuscarClick - Abre lookup para localizar registro na lista
948:     *===========================================================================
949:     PROCEDURE BtnBuscarClick()
950:         LOCAL loc_oBusca
951:         loc_oBusca = .NULL.
952: 
953:         TRY
954:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
955:                 "SigBaOco", "cursor_4c_Busca", "tipos", "", ;
956:                 "Ocorr" + CHR(234) + "ncias do Balan" + CHR(231) + "o")
957: 
958:             IF VARTYPE(loc_oBusca) = "O"
959:                 loc_oBusca.mAddColuna("tipos",   "", "Tipo")
960:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
961:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
962:                 loc_oBusca.Show()
963: 
964:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca") AND USED("cursor_4c_Dados")
965:                     SELECT cursor_4c_Dados
966:                     LOCATE FOR ALLTRIM(codigos) = ALLTRIM(cursor_4c_Busca.codigos)
967:                     IF FOUND()
968:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus
969:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh
970:                     ENDIF
971:                 ENDIF
972: 
973:                 loc_oBusca.Release()
974:             ENDIF
975:         CATCH TO loException
976:             MsgErro("Erro ao buscar:" + CHR(13) + loException.Message + CHR(13) + ;
977:                 "Linha: " + TRANSFORM(loException.LineNo), "FormOcb.BtnBuscarClick")
978:         ENDTRY
979: 
980:         IF USED("cursor_4c_Busca")
981:             USE IN cursor_4c_Busca
982:         ENDIF
983:         IF VARTYPE(loc_oBusca) = "O"
984:             loc_oBusca = .NULL.
985:         ENDIF
986:     ENDPROC
987: 
988:     *===========================================================================
989:     * BtnIncluirClick - Prepara inclusao de novo registro
990:     *===========================================================================
991:     PROCEDURE BtnIncluirClick()
992:         THIS.this_oBusinessObject.NovoRegistro()
993:         THIS.this_cModoAtual = "INCLUIR"
994:         THIS.LimparCampos()
995:         THIS.HabilitarCampos(.T.)
996:         THIS.AlternarPagina(2)
997:         THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.SetFocus()
998:     ENDPROC
999: 
1000:     *===========================================================================
1001:     * BtnVisualizarClick - Carrega registro selecionado para visualizacao
1002:     *===========================================================================
1003:     PROCEDURE BtnVisualizarClick()
1004:         LOCAL loc_cCodigo
1005:         loc_cCodigo = ""
1006: 
1007:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1008:             MsgAviso("Selecione um registro para visualizar.", "")
1009:             RETURN
1010:         ENDIF
1011: 
1012:         SELECT cursor_4c_Dados
1013:         loc_cCodigo = ALLTRIM(codigos)
1014: 
1015:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1016:             THIS.this_cModoAtual = "VISUALIZAR"
1017:             THIS.BOParaForm()
1018:             THIS.HabilitarCampos(.F.)
1019:             THIS.AlternarPagina(2)
1020:             THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.SetFocus()
1021:         ENDIF
1022:     ENDPROC
1023: 
1024:     *===========================================================================
1025:     * BtnAlterarClick - Carrega registro selecionado para edicao
1026:     *===========================================================================
1027:     PROCEDURE BtnAlterarClick()
1028:         LOCAL loc_cCodigo
1029:         loc_cCodigo = ""
1030: 
1031:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1032:             MsgAviso("Selecione um registro para alterar.", "")
1033:             RETURN
1034:         ENDIF
1035: 
1036:         SELECT cursor_4c_Dados
1037:         loc_cCodigo = ALLTRIM(codigos)
1038: 
1039:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1040:             THIS.this_oBusinessObject.EditarRegistro()
1041:             THIS.this_cModoAtual = "ALTERAR"
1042:             THIS.BOParaForm()
1043:             THIS.HabilitarCampos(.T.)
1044:             THIS.AlternarPagina(2)
1045:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus()
1046:         ENDIF
1047:     ENDPROC
1048: 
1049:     *===========================================================================
1050:     * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
1051:     *===========================================================================
1052:     PROCEDURE BtnExcluirClick()
1053:         LOCAL loc_cCodigo
1054:         loc_cCodigo = ""
1055: 
1056:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1057:             MsgAviso("Selecione um registro para excluir.", "")
1058:             RETURN
1059:         ENDIF
1060: 
1061:         SELECT cursor_4c_Dados
1062:         loc_cCodigo = ALLTRIM(codigos)
1063: 
1064:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + ;
1065:                 loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
1066:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1067:                 IF THIS.this_oBusinessObject.Excluir()
1068:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1069:                     THIS.CarregarLista()
1070:                 ENDIF
1071:             ENDIF
1072:         ENDIF
1073:     ENDPROC
1074: 
1075:     *===========================================================================
1076:     * BtnSalvarClick - Valida, transfere form->BO e salva
1077:     *===========================================================================
1078:     PROCEDURE BtnSalvarClick()
1079:         IF !THIS.FormParaBO()
1080:             RETURN
1081:         ENDIF
1082: 
1083:         TRY
1084:             IF THIS.this_oBusinessObject.Salvar()
1085:                 MsgInfo("Registro salvo com sucesso!", "")
1086:                 THIS.this_cModoAtual = "LISTA"
1087:                 THIS.AlternarPagina(1)
1088:             ENDIF
1089:         CATCH TO loException
1090:             MsgErro("Erro ao salvar:" + CHR(13) + loException.Message + CHR(13) + ;
1091:                 "Linha: " + TRANSFORM(loException.LineNo), "FormOcb.BtnSalvarClick")
1092:         ENDTRY
1093:     ENDPROC
1094: 
1095:     *===========================================================================
1096:     * BtnCancelarClick - Cancela edicao e retorna para lista
1097:     *===========================================================================
1098:     PROCEDURE BtnCancelarClick()
1099:         THIS.this_cModoAtual = "LISTA"
1100:         THIS.AlternarPagina(1)
1101:     ENDPROC
1102: 
1103:     *===========================================================================
1104:     * FormParaBO - Transfere valores dos campos do form para o BO (50% fase 5)
1105:     * Segunda metade adicionada na Fase 6
1106:     *===========================================================================
1107:     PROTECTED FUNCTION FormParaBO()
1108:         LOCAL loc_oPagina, loc_cCodigos, loc_cTipos, loc_cApuras
1109:         LOCAL loc_cLancas, loc_cOpers, loc_cAutos, loc_cOperacaos
1110:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
1111: 
1112:         loc_cCodigos   = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
1113:         loc_cTipos     = UPPER(ALLTRIM(loc_oPagina.txt_4c_Tipos.Value))
1114:         loc_cApuras    = UPPER(ALLTRIM(loc_oPagina.txt_4c_Apura.Value))
1115:         loc_cLancas    = UPPER(ALLTRIM(loc_oPagina.txt_4c_Lanca.Value))
1116:         loc_cOpers     = UPPER(ALLTRIM(loc_oPagina.txt_4c_Oper.Value))
1117:         loc_cAutos     = UPPER(ALLTRIM(loc_oPagina.txt_4c_Autos.Value))
1118:         loc_cOperacaos = UPPER(ALLTRIM(loc_oPagina.txt_4c_Operac.Value))
1119: 
1120:         IF EMPTY(loc_cCodigos)
1121:             MsgAviso("Obrigat" + CHR(243) + "rio informar o C" + CHR(243) + "digo!", "")
1122:             loc_oPagina.txt_4c_Codigos.SetFocus()
1123:             RETURN .F.
1124:         ENDIF
1125: 
1126:         IF !INLIST(loc_cTipos, "O", "J")
1127:             MsgAviso("Tipo inv" + CHR(225) + "lido." + CHR(13) + ;
1128:                 "Use O (Ocorr" + CHR(234) + "ncia) ou J (Justificativa).", "")
1129:             loc_oPagina.txt_4c_Tipos.SetFocus()
1130:             RETURN .F.
1131:         ENDIF
1132: 
1133:         IF !EMPTY(loc_cApuras) AND !INLIST(loc_cApuras, "S", "N")
1134:             MsgAviso("Apura" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida." + CHR(13) + ;
1135:                 "Use S (Sim) ou N (N" + CHR(227) + "o).", "")
1136:             loc_oPagina.txt_4c_Apura.SetFocus()
1137:             RETURN .F.
1138:         ENDIF
1139: 
1140:         IF !EMPTY(loc_cLancas) AND !INLIST(loc_cLancas, "S", "N")
1141:             MsgAviso("Lan" + CHR(231) + "a C/C inv" + CHR(225) + "lido." + CHR(13) + ;
1142:                 "Use S (Sim) ou N (N" + CHR(227) + "o).", "")
1143:             loc_oPagina.txt_4c_Lanca.SetFocus()
1144:             RETURN .F.
1145:         ENDIF
1146: 
1147:         IF !EMPTY(loc_cOpers) AND !INLIST(loc_cOpers, "DB", "CR", "DF", "NL")
1148:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida." + CHR(13) + ;
1149:                 "Use DB/CR/DF/NL.", "")
1150:             loc_oPagina.txt_4c_Oper.SetFocus()
1151:             RETURN .F.
1152:         ENDIF
1153: 
1154:         IF !EMPTY(loc_cAutos) AND !INLIST(loc_cAutos, "S", "N")
1155:             MsgAviso("Autom" + CHR(225) + "tico inv" + CHR(225) + "lido." + CHR(13) + ;
1156:                 "Use S (Sim) ou N (N" + CHR(227) + "o).", "")
1157:             loc_oPagina.txt_4c_Autos.SetFocus()
1158:             RETURN .F.
1159:         ENDIF
1160: 
1161:         IF loc_cAutos = "S" AND !EMPTY(loc_cOperacaos) AND !INLIST(loc_cOperacaos, "E", "S")
1162:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida." + CHR(13) + ;
1163:                 "Use E (Entrada) ou S (Sa" + CHR(237) + "da).", "")
1164:             loc_oPagina.txt_4c_Operac.SetFocus()
1165:             RETURN .F.
1166:         ENDIF
1167: 
1168:         THIS.this_oBusinessObject.this_cCodigos   = loc_cCodigos
1169:         THIS.this_oBusinessObject.this_cTipos     = loc_cTipos
1170:         THIS.this_oBusinessObject.this_cDescrs    = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
1171:         THIS.this_oBusinessObject.this_cApuras    = loc_cApuras
1172:         THIS.this_oBusinessObject.this_cLancas    = loc_cLancas
1173:         THIS.this_oBusinessObject.this_cOpers     = loc_cOpers
1174:         THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPagina.txt_4c_GrContabil.Value)
1175:         THIS.this_oBusinessObject.this_cAutos     = loc_cAutos
1176:         THIS.this_oBusinessObject.this_cOperacaos = IIF(loc_cAutos = "S", loc_cOperacaos, "")
1177: 
1178:         RETURN .T.
1179:     ENDFUNC
1180: 
1181:     *===========================================================================
1182:     * BOParaForm - Transfere valores do BO para os campos do form (50% fase 5)
1183:     * Segunda metade adicionada na Fase 6
1184:     *===========================================================================
1185:     PROTECTED PROCEDURE BOParaForm()
1186:         LOCAL loc_oPagina, loc_cAutos
1187:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1188:         loc_cAutos  = ALLTRIM(THIS.this_oBusinessObject.this_cAutos)
1189: 
1190:         loc_oPagina.txt_4c_Codigos.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
1191:         loc_oPagina.txt_4c_Tipos.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
1192:         loc_oPagina.txt_4c_Descrs.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
1193:         loc_oPagina.txt_4c_Apura.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cApuras)
1194:         loc_oPagina.txt_4c_Lanca.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cLancas)
1195:         loc_oPagina.txt_4c_Oper.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cOpers)
1196:         loc_oPagina.txt_4c_GrContabil.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
1197:         loc_oPagina.txt_4c_Autos.Value      = loc_cAutos
1198:         loc_oPagina.txt_4c_Operac.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cOperacaos)
1199: 
1200:         *-- GetOperac.When: habilitado apenas quando Autos = "S"
1201:         loc_oPagina.txt_4c_Operac.Enabled = (loc_cAutos = "S")
1202:     ENDPROC
1203: 
1204:     *===========================================================================
1205:     * LimparCampos - Limpa os campos do form (50% fase 5)
1206:     * Segunda metade adicionada na Fase 6
1207:     *===========================================================================
1208:     PROTECTED PROCEDURE LimparCampos()
1209:         LOCAL loc_oPagina
1210:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1211: 
1212:         loc_oPagina.txt_4c_Tipos.Value      = ""
1213:         loc_oPagina.txt_4c_Codigos.Value    = ""
1214:         loc_oPagina.txt_4c_Descrs.Value     = ""
1215:         loc_oPagina.txt_4c_Apura.Value      = ""
1216:         loc_oPagina.txt_4c_Lanca.Value      = ""
1217:         loc_oPagina.txt_4c_Oper.Value       = ""
1218:         loc_oPagina.txt_4c_GrContabil.Value = ""
1219:         loc_oPagina.txt_4c_Autos.Value      = ""
1220:         loc_oPagina.txt_4c_Operac.Value     = ""
1221:         loc_oPagina.txt_4c_Operac.Enabled   = .F.
1222:     ENDPROC
1223: 
1224:     *===========================================================================
1225:     * HabilitarCampos - Habilita/desabilita campos conforme modo (50% fase 5)
1226:     * Segunda metade adicionada na Fase 6
1227:     *===========================================================================
1228:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1229:         LOCAL loc_oPagina, loc_lReadOnly, loc_cAutos
1230:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1231:         loc_lReadOnly = !par_lHabilitar
1232:         loc_cAutos    = UPPER(ALLTRIM(loc_oPagina.txt_4c_Autos.Value))
1233: 
1234:         *-- Codigo: editavel apenas em INCLUIR (When do original)
1235:         loc_oPagina.txt_4c_Codigos.ReadOnly    = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1236:         loc_oPagina.txt_4c_Tipos.ReadOnly      = loc_lReadOnly
1237:         loc_oPagina.txt_4c_Descrs.ReadOnly     = loc_lReadOnly
1238:         loc_oPagina.txt_4c_Apura.ReadOnly      = loc_lReadOnly
1239:         loc_oPagina.txt_4c_Lanca.ReadOnly      = loc_lReadOnly
1240:         loc_oPagina.txt_4c_Oper.ReadOnly       = loc_lReadOnly
1241:         loc_oPagina.txt_4c_GrContabil.ReadOnly = loc_lReadOnly
1242:         loc_oPagina.txt_4c_Autos.ReadOnly      = loc_lReadOnly
1243: 
1244:         *-- GetOperac.When: habilitado/desabilitado por Autos e por modo de edicao
1245:         loc_oPagina.txt_4c_Operac.Enabled  = par_lHabilitar AND (loc_cAutos = "S")
1246:         loc_oPagina.txt_4c_Operac.ReadOnly = loc_lReadOnly
1247: 
1248:         *-- Salvar desabilitado em VISUALIZAR
1249:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled   = ;
1250:             par_lHabilitar AND THIS.this_cModoAtual != "VISUALIZAR"
1251:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1252:     ENDPROC
1253: 
1254:     *===========================================================================
1255:     * ValidarTipos - Handler Valid do txt_4c_Tipos (O=Ocorrencia J=Justificativa)
1256:     *===========================================================================
1257:     PROCEDURE ValidarTipos(par_nKeyCode, par_nShiftAltCtrl)
1258:         LOCAL loc_oPagina, loc_cValor
1259:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1260:         loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Tipos.Value))
1261: 
1262:         IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "O", "J")
1263:             MsgAviso("Tipo inv" + CHR(225) + "lido." + CHR(13) + ;
1264:                 "Use O (Ocorr" + CHR(234) + "ncia) ou J (Justificativa).", "")
1265:             RETURN .F.
1266:         ENDIF
1267: 
1268:         IF !EMPTY(loc_cValor)
1269:             loc_oPagina.txt_4c_Tipos.Value = loc_cValor
1270:         ENDIF
1271: 
1272:         RETURN .T.
1273:     ENDPROC
1274: 
1275:     *===========================================================================
1276:     * ValidarApura - Handler Valid do txt_4c_Apura (S=Sim N=Nao)
1277:     *===========================================================================
1278:     PROCEDURE ValidarApura(par_nKeyCode, par_nShiftAltCtrl)
1279:         LOCAL loc_oPagina, loc_cValor
1280:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1281:         loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Apura.Value))
1282: 
1283:         IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
1284:             MsgAviso("Apura" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida." + CHR(13) + ;
1285:                 "Use S (Sim) ou N (N" + CHR(227) + "o).", "")
1286:             RETURN .F.
1287:         ENDIF
1288: 
1289:         IF !EMPTY(loc_cValor)
1290:             loc_oPagina.txt_4c_Apura.Value = loc_cValor
1291:         ENDIF
1292: 
1293:         RETURN .T.
1294:     ENDPROC
1295: 
1296:     *===========================================================================
1297:     * ValidarLanca - Handler Valid do txt_4c_Lanca (S=Sim N=Nao)
1298:     *===========================================================================
1299:     PROCEDURE ValidarLanca(par_nKeyCode, par_nShiftAltCtrl)
1300:         LOCAL loc_oPagina, loc_cValor
1301:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1302:         loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Lanca.Value))
1303: 
1304:         IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
1305:             MsgAviso("Lan" + CHR(231) + "a C/C inv" + CHR(225) + "lido." + CHR(13) + ;
1306:                 "Use S (Sim) ou N (N" + CHR(227) + "o).", "")
1307:             RETURN .F.
1308:         ENDIF
1309: 
1310:         IF !EMPTY(loc_cValor)
1311:             loc_oPagina.txt_4c_Lanca.Value = loc_cValor
1312:         ENDIF
1313: 
1314:         RETURN .T.
1315:     ENDPROC
1316: 
1317:     *===========================================================================
1318:     * ValidarOper - Handler Valid do txt_4c_Oper (DB/CR/DF/NL)
1319:     *===========================================================================
1320:     PROCEDURE ValidarOper(par_nKeyCode, par_nShiftAltCtrl)
1321:         LOCAL loc_oPagina, loc_cValor
1322:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1323:         loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Oper.Value))
1324: 
1325:         IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "DB", "CR", "DF", "NL")
1326:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida." + CHR(13) + ;
1327:                 "Use DB (D" + CHR(233) + "bito), CR (Cr" + CHR(233) + "dito), " + ;
1328:                 "DF (Diferen" + CHR(231) + "a) ou NL (Nulo).", "")
1329:             RETURN .F.
1330:         ENDIF
1331: 
1332:         IF !EMPTY(loc_cValor)
1333:             loc_oPagina.txt_4c_Oper.Value = loc_cValor
1334:         ENDIF
1335: 
1336:         RETURN .T.
1337:     ENDPROC
1338: 
1339:     *===========================================================================
1340:     * ValidarAutos - Handler Valid do txt_4c_Autos (S=Sim N=Nao)
1341:     *===========================================================================
1342:     PROCEDURE ValidarAutos(par_nKeyCode, par_nShiftAltCtrl)
1343:         LOCAL loc_oPagina, loc_cValor
1344:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1345:         loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Autos.Value))
1346: 
1347:         IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
1348:             MsgAviso("Autom" + CHR(225) + "tico inv" + CHR(225) + "lido." + CHR(13) + ;
1349:                 "Use S (Sim) ou N (N" + CHR(227) + "o).", "")
1350:             RETURN .F.
1351:         ENDIF
1352: 
1353:         IF !EMPTY(loc_cValor)
1354:             loc_oPagina.txt_4c_Autos.Value = loc_cValor
1355:         ENDIF
1356: 
1357:         RETURN .T.
1358:     ENDPROC
1359: 
1360:     *===========================================================================
1361:     * AutosLostFocus - Handler LostFocus do txt_4c_Autos
1362:     * Atualiza habilitacao de txt_4c_Operac conforme Autos = "S"
1363:     * Replica o When do legado: GetOperac.When = (GetAutos.Value = "S")
1364:     *===========================================================================
1365:     PROCEDURE AutosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1366:         LOCAL loc_oPagina, loc_cAutos, loc_lHabilitar
1367:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
1368:         loc_cAutos   = UPPER(ALLTRIM(loc_oPagina.txt_4c_Autos.Value))
1369:         loc_lHabilitar = (loc_cAutos = "S") AND THIS.this_cModoAtual != "VISUALIZAR" AND ;
1370:                          THIS.this_cModoAtual != "LISTA"
1371: 
1372:         loc_oPagina.txt_4c_Operac.Enabled = loc_lHabilitar
1373: 
1374:         IF !loc_lHabilitar
1375:             loc_oPagina.txt_4c_Operac.Value = ""
1376:         ENDIF
1377:     ENDPROC
1378: 
1379:     *===========================================================================
1380:     * ValidarOperac - Handler Valid do txt_4c_Operac (E=Entrada S=Saida)
1381:     *===========================================================================
1382:     PROCEDURE ValidarOperac(par_nKeyCode, par_nShiftAltCtrl)
1383:         LOCAL loc_oPagina, loc_cValor
1384:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1385:         loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Operac.Value))
1386: 
1387:         IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "E", "S")
1388:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida." + CHR(13) + ;
1389:                 "Use E (Entrada) ou S (Sa" + CHR(237) + "da).", "")
1390:             RETURN .F.
1391:         ENDIF
1392: 
1393:         IF !EMPTY(loc_cValor)
1394:             loc_oPagina.txt_4c_Operac.Value = loc_cValor
1395:         ENDIF
1396: 
1397:         RETURN .T.
1398:     ENDPROC
1399: 
1400:     *===========================================================================
1401:     * ValidarGrContabil - Handler Valid do txt_4c_GrContabil
1402:     * Valida o grupo contabil digitado contra SigCdGcr
1403:     *===========================================================================
1404:     PROCEDURE ValidarGrContabil(par_nKeyCode, par_nShiftAltCtrl)
1405:         LOCAL loc_oPagina, loc_cValor, loc_nResult
1406:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1407:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_GrContabil.Value)
1408: 
1409:         IF EMPTY(loc_cValor)
1410:             RETURN .T.
1411:         ENDIF
1412: 
1413:         loc_nResult = SQLEXEC(gnConnHandle, ;
1414:             "SELECT Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
1415:             "cursor_4c_ValGcr")
1416: 
1417:         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValGcr") > 0
1418:             IF USED("cursor_4c_ValGcr")
1419:                 USE IN cursor_4c_ValGcr
1420:             ENDIF
1421:             RETURN .T.
1422:         ENDIF
1423: 
1424:         IF USED("cursor_4c_ValGcr")
1425:             USE IN cursor_4c_ValGcr
1426:         ENDIF
1427: 
1428:         THIS.AbrirLookupGrContabil()
1429:         RETURN .T.
1430:     ENDPROC
1431: 
1432:     *===========================================================================
1433:     * GrContabilLookupKeyPress - Handler KeyPress F4 no txt_4c_GrContabil
1434:     *===========================================================================
1435:     PROCEDURE GrContabilLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1436:         IF par_nKeyCode = 28
1437:             THIS.AbrirLookupGrContabil()
1438:         ENDIF
1439:     ENDPROC
1440: 
1441:     *===========================================================================
1442:     * GrContabilLookupDblClick - Handler DblClick no txt_4c_GrContabil
1443:     *===========================================================================
1444:     PROCEDURE GrContabilLookupDblClick()
1445:         THIS.AbrirLookupGrContabil()
1446:     ENDPROC
1447: 
1448:     *===========================================================================
1449:     * AbrirLookupGrContabil - Abre FormBuscaAuxiliar para SigCdGcr
1450:     * Original: fwBuscaExt para SigCdGcr / Codigos / Descrs
1451:     *===========================================================================
1452:     PROCEDURE AbrirLookupGrContabil()
1453:         LOCAL loc_oPagina, loc_oBusca, loc_cCodigo, loc_cValorAtual
1454:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1455: 
1456:         IF !loc_oPagina.txt_4c_GrContabil.Enabled
1457:             RETURN
1458:         ENDIF
1459: 
1460:         loc_cValorAtual = ALLTRIM(loc_oPagina.txt_4c_GrContabil.Value)
1461: 
1462:         TRY
1463:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1464:                 "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cValorAtual, ;
1465:                 "Grupo Cont" + CHR(225) + "bil")
1466: 
1467:             IF VARTYPE(loc_oBusca) = "O"
1468:                 IF !loc_oBusca.this_lAchouRegistro
1469:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1470:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1471:                     loc_oBusca.Show()
1472:                 ENDIF
1473: 
1474:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1475:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
1476:                     loc_oPagina.txt_4c_GrContabil.Value = loc_cCodigo
1477:                 ENDIF
1478: 
1479:                 loc_oBusca.Release()
1480:             ENDIF
1481:         CATCH TO loException
1482:             MsgErro("Erro ao buscar grupo cont" + CHR(225) + "bil:" + CHR(13) + ;
1483:                 loException.Message + CHR(13) + ;
1484:                 "Linha: " + TRANSFORM(loException.LineNo), "FormOcb.AbrirLookupGrContabil")
1485:         ENDTRY
1486: 
1487:         IF USED("cursor_4c_BuscaGcr")
1488:             USE IN cursor_4c_BuscaGcr
1489:         ENDIF
1490:     ENDPROC
1491: 
1492:     *===========================================================================
1493:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme contexto
1494:     * Chamado apos carregar lista para refletir estado de disponibilidade
1495:     *===========================================================================
1496:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1497:         LOCAL loc_oPagina, loc_lTemRegistro
1498:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1499:         loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
1500:                            RECCOUNT("cursor_4c_Dados") > 0 AND ;
1501:                            !EOF("cursor_4c_Dados")
1502: 
1503:         WITH loc_oPagina.cnt_4c_Botoes
1504:             .cmd_4c_Incluir.Enabled    = .T.
1505:             .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1506:             .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1507:             .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1508:             .cmd_4c_Buscar.Enabled     = loc_lTemRegistro
1509:             .Visible     = .T.
1510:         ENDWITH
1511:     ENDPROC
1512: 
1513:     *===========================================================================
1514:     * Destroy - Libera recursos
1515:     *===========================================================================
1516:     PROCEDURE Destroy()
1517:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1518:             THIS.this_oBusinessObject = .NULL.
1519:         ENDIF
1520:         DODEFAULT()
1521:     ENDPROC
1522: 
1523: ENDDEFINE


### BO (C:\4c\projeto\app\classes\OcbBO.prg):
*==============================================================================
* OcbBO.prg - Business Object para Ocorrencias do Balanco
* Tabela: SigBaOco
*==============================================================================

DEFINE CLASS OcbBO AS BusinessBase

    *-- Propriedades da entidade (mapeadas de SigBaOco)
    this_cCodigos   = ""    && codigos   char(10) - PK
    this_cDescrs    = ""    && descrs    char(40)
    this_cTipos     = ""    && tipos     char(1) - "O" ou "J"
    this_cApuras    = ""    && apuras    char(1) - "S" ou "N"
    this_cLancas    = ""    && lancas    char(1) - "S" ou "N"
    this_cOpers     = ""    && opers     char(2) - "DB","CR","DF","NL"
    this_cAutos     = ""    && autos     char(1) - "S" ou "N"
    this_cOperacaos = ""    && operacaos char(1) - "E" ou "S"
    this_cGrupos    = ""    && grupos    char(10) - FK SigCdGcr

    *==========================================================================
    * Init - Inicializa o Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigBaOco"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *==========================================================================
    * Buscar - SELECT com filtro opcional (cursor_4c_Dados)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, apuras, lancas," + ;
                       " opers, autos, operacaos, grupos" + ;
                       " FROM SigBaOco"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar ocorr" + CHR(234) + "ncias:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo PK
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, apuras, lancas," + ;
                       " opers, autos, operacaos, grupos" + ;
                       " FROM SigBaOco" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = TratarNulo(codigos,    "C")
            THIS.this_cDescrs     = TratarNulo(descrs,     "C")
            THIS.this_cTipos      = TratarNulo(tipos,      "C")
            THIS.this_cApuras     = TratarNulo(apuras,     "C")
            THIS.this_cLancas     = TratarNulo(lancas,     "C")
            THIS.this_cOpers      = TratarNulo(opers,      "C")
            THIS.this_cAutos      = TratarNulo(autos,      "C")
            THIS.this_cOperacaos  = TratarNulo(operacaos,  "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT INTO SigBaOco (PROTECTED - chamado por Salvar)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigBaOco" + ;
                       " (codigos, descrs, tipos, apuras, lancas," + ;
                       "  opers, autos, operacaos, grupos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)   + ", " + ;
                       EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       EscaparSQL(THIS.this_cApuras)    + ", " + ;
                       EscaparSQL(THIS.this_cLancas)    + ", " + ;
                       EscaparSQL(THIS.this_cOpers)     + ", " + ;
                       EscaparSQL(THIS.this_cAutos)     + ", " + ;
                       EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)    + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE SigBaOco (PROTECTED - chamado por Salvar)
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigBaOco SET" + ;
                       " descrs    = " + EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       " tipos     = " + EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       " apuras    = " + EscaparSQL(THIS.this_cApuras)    + ", " + ;
                       " lancas    = " + EscaparSQL(THIS.this_cLancas)    + ", " + ;
                       " opers     = " + EscaparSQL(THIS.this_cOpers)     + ", " + ;
                       " autos     = " + EscaparSQL(THIS.this_cAutos)     + ", " + ;
                       " operacaos = " + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                       " grupos    = " + EscaparSQL(THIS.this_cGrupos)    + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE FROM SigBaOco (PROTECTED - chamado por Excluir)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigBaOco" + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

