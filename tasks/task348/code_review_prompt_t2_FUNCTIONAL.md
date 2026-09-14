# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (22)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_SAIDA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [LAYOUT-POSITION] Controle 'Estoque' (parent: SIGCDBAL.Pagina.Lista): Top original=124 vs migrado 'txt_4c_Estoque' Top=457 (diff=333px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Estoque' (parent: SIGCDBAL.Pagina.Lista): Left original=227 vs migrado 'txt_4c_Estoque' Left=112 (diff=115px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Local' (parent: SIGCDBAL.Pagina.Lista): Top original=124 vs migrado 'cmd_4c_TotalLocal' Top=41 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Local' (parent: SIGCDBAL.Pagina.Lista): Left original=369 vs migrado 'cmd_4c_TotalLocal' Left=303 (diff=66px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Grupo' (parent: SIGCDBAL.Pagina.Lista): Top original=124 vs migrado 'txt_4c_GGrupoFinal' Top=279 (diff=155px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Grupo' (parent: SIGCDBAL.Pagina.Lista): Left original=531 vs migrado 'txt_4c_GGrupoFinal' Left=443 (diff=88px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GGrupo' (parent: SIGCDBAL.Pagina.Lista): Top original=124 vs migrado 'txt_4c_GGrupoFinal' Top=279 (diff=155px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GGrupo' (parent: SIGCDBAL.Pagina.Lista): Left original=599 vs migrado 'txt_4c_GGrupoFinal' Left=443 (diff=156px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Command1' (parent: SIGCDBAL.Pagina.Lista): Top original=83 vs migrado 'cmd_4c_Command1' Top=378 (diff=295px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Command1' (parent: SIGCDBAL.Pagina.Lista): Left original=371 vs migrado 'cmd_4c_Command1' Left=924 (diff=553px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_grupos' (parent: SIGCDBAL.Pagina.Dados): Top original=98 vs migrado 'lbl_4c_Lbl_grupos' Top=187 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_grupos' (parent: SIGCDBAL.Pagina.Dados): Left original=293 vs migrado 'lbl_4c_Lbl_grupos' Left=23 (diff=270px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Agrupa' (parent: SIGCDBAL.Pagina.Dados): Top original=453 vs migrado 'obj_4c_Opt_Agrupa' Top=0 (diff=453px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Agrupa' (parent: SIGCDBAL.Pagina.Dados): Left original=330 vs migrado 'obj_4c_Opt_Agrupa' Left=0 (diff=330px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optFilBarra' (parent: SIGCDBAL.Pagina.Dados): Top original=469 vs migrado 'obj_4c_OptFilBarra' Top=0 (diff=469px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optFilBarra' (parent: SIGCDBAL.Pagina.Dados): Left original=330 vs migrado 'obj_4c_OptFilBarra' Left=0 (diff=330px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDBAL.Pagina.Dados): Top original=313 vs migrado 'lbl_4c_Label19' Top=205 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDBAL.Pagina.Dados): Left original=683 vs migrado 'lbl_4c_Label19' Left=284 (diff=399px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'TipoLeitura' (parent: SIGCDBAL.Pagina.Leitura): Top original=251 vs migrado 'obj_4c_TipoLeitura' Top=0 (diff=251px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGCDBAL.Pagina.Leitura): Left original=903 vs migrado 'cmd_4c_Cancela' Left=743 (diff=160px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBAL.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4878 linhas total):

*-- Linhas 29 a 160:
29:     this_cCidchavesSel   = ""
30: 
31:     *--------------------------------------------------------------------------
32:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
33:     *--------------------------------------------------------------------------
34:     PROCEDURE Init()
35:         LOCAL loc_lResultado
36:         loc_lResultado = .F.
37: 
38:         TRY
39:             loc_lResultado = DODEFAULT()
40:         CATCH TO loc_oErro
41:             MsgErro(loc_oErro.Message, "FormBAL.Init")
42:         ENDTRY
43: 
44:         RETURN loc_lResultado
45:     ENDPROC
46: 
47:     *--------------------------------------------------------------------------
48:     * InicializarForm - Configura estrutura completa
49:     *--------------------------------------------------------------------------
50:     PROTECTED PROCEDURE InicializarForm()
51:         LOCAL loc_lResultado
52:         loc_lResultado = .F.
53: 
54:         TRY
55:             SET DATE TO BRITISH
56:             SET CENTURY ON
57: 
58:             THIS.this_oBusinessObject = CREATEOBJECT("BALBO")
59: 
60:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
61:                 MsgErro("Falha ao criar BALBO", "Erro")
62:             ELSE
63:                 THIS.ConfigurarPageFrame()
64: 
65:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
66:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
67: 
68:                 THIS.pgf_4c_Paginas.Visible    = .T.
69:                 THIS.pgf_4c_Paginas.ActivePage = 1
70:                 THIS.this_cModoAtual = "LISTA"
71: 
72:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
73:                     THIS.CarregarLista()
74:                 ENDIF
75: 
76:                 loc_lResultado = .T.
77:             ENDIF
78:         CATCH TO loc_oErro
79:             MsgErro(loc_oErro.Message, "FormBAL.InicializarForm")
80:         ENDTRY
81: 
82:         RETURN loc_lResultado
83:     ENDPROC
84: 
85:     *--------------------------------------------------------------------------
86:     * ConfigurarPageFrame - Cria PageFrame com 3 Pages
87:     *--------------------------------------------------------------------------
88:     PROTECTED PROCEDURE ConfigurarPageFrame()
89:         LOCAL loc_oPgf
90:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
91:         loc_oPgf = THIS.pgf_4c_Paginas
92: 
93:         WITH loc_oPgf
94:             .PageCount = 3
95:             .Top       = -29
96:             .Left      = 0
97:             .Width     = THIS.Width
98:             .Height    = THIS.Height + 29
99:             .Tabs      = .F.
100:             .Visible   = .T.
101:             .Page1.Caption   = "Lista"
102:             .Page1.BackColor = RGB(100, 100, 100)
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.Caption   = "Dados"
105:             .Page2.BackColor = RGB(100, 100, 100)
106:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Page3.Caption   = "Leitura"
108:             .Page3.BackColor = RGB(100, 100, 100)
109:             .Page3.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110:         ENDWITH
111: 
112:         THIS.ConfigurarPaginaLista()
113:         THIS.ConfigurarPaginaDados()
114:         THIS.ConfigurarPaginaLeitura()
115:     ENDPROC
116: 
117:     *--------------------------------------------------------------------------
118:     * ConfigurarPaginaLista - Cria Page1: lista de inventarios + botoes
119:     *--------------------------------------------------------------------------
120:     PROTECTED PROCEDURE ConfigurarPaginaLista()
121:         LOCAL loc_oPg1, loc_oCab, loc_oSaida
122: 
123:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
124: 
125:         *-- Container cabecalho (Top=2+29=31)
126:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
127:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
128:         WITH loc_oCab
129:             .Top         = 31
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136:         ENDWITH
137: 
138:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oCab.lbl_4c_Sombra
140:             .AutoSize  = .F.
141:             .Caption   = THIS.Caption
142:             .Top       = 15
143:             .Left      = 10
144:             .Width     = THIS.Width
145:             .Height    = 40
146:             .FontName  = "Tahoma"
147:             .FontSize  = 16
148:             .FontBold  = .T.
149:             .ForeColor = RGB(0, 0, 0)
150:             .BackStyle = 0
151:             .Visible   = .T.
152:         ENDWITH
153: 
154:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oCab.lbl_4c_Titulo
156:             .AutoSize  = .F.
157:             .Caption   = THIS.Caption
158:             .Top       = 18
159:             .Left      = 10
160:             .Width     = THIS.Width

*-- Linhas 203 a 492:
203:             .Visible         = .T.
204:         ENDWITH
205: 
206:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
207: 
208:         *-- Linha 1 de botoes de acao (Top=83+29=112, Height=40)
209:         *-- Leitura (Left=11, Width=120)
210:         loc_oPg1.AddObject("cmd_4c_Leitura", "CommandButton")
211:         WITH loc_oPg1.cmd_4c_Leitura
212:             .Caption         = "Leitura"
213:             .Picture         = gc_4c_CaminhoIcones + "operacional_leitura_26.jpg"
214:             .PicturePosition = 13
215:             .Top             = 112
216:             .Left            = 11
217:             .Width           = 120
218:             .Height          = 40
219:             .BackColor       = RGB(255, 255, 255)
220:             .ForeColor       = RGB(90, 90, 90)
221:             .FontName        = "Tahoma"
222:             .FontSize        = 8
223:             .FontBold        = .T.
224:             .Themes          = .F.
225:             .SpecialEffect   = 0
226:             .MousePointer    = 15
227:             .WordWrap        = .T.
228:             .AutoSize        = .F.
229:             .Visible         = .T.
230:         ENDWITH
231: 
232:         BINDEVENT(loc_oPg1.cmd_4c_Leitura, "Click", THIS, "BtnLeituraClick")
233: 
234:         *-- Fecha (Left=131, Width=120)
235:         loc_oPg1.AddObject("cmd_4c_Fecha", "CommandButton")
236:         WITH loc_oPg1.cmd_4c_Fecha
237:             .Caption         = "Fecha"
238:             .Picture         = gc_4c_CaminhoIcones + "operacional_fechar_26.jpg"
239:             .PicturePosition = 13
240:             .Top             = 112
241:             .Left            = 131
242:             .Width           = 120
243:             .Height          = 40
244:             .BackColor       = RGB(255, 255, 255)
245:             .ForeColor       = RGB(90, 90, 90)
246:             .FontName        = "Tahoma"
247:             .FontSize        = 8
248:             .FontBold        = .T.
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .MousePointer    = 15
252:             .WordWrap        = .T.
253:             .AutoSize        = .F.
254:             .Visible         = .T.
255:         ENDWITH
256: 
257:         BINDEVENT(loc_oPg1.cmd_4c_Fecha, "Click", THIS, "BtnFechaClick")
258: 
259:         *-- Consulta (Left=251, Width=120)
260:         loc_oPg1.AddObject("cmd_4c_Consulta", "CommandButton")
261:         WITH loc_oPg1.cmd_4c_Consulta
262:             .Caption         = "Consulta"
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
264:             .PicturePosition = 13
265:             .Top             = 112
266:             .Left            = 251
267:             .Width           = 120
268:             .Height          = 40
269:             .BackColor       = RGB(255, 255, 255)
270:             .ForeColor       = RGB(90, 90, 90)
271:             .FontName        = "Tahoma"
272:             .FontSize        = 8
273:             .FontBold        = .T.
274:             .Themes          = .F.
275:             .SpecialEffect   = 0
276:             .MousePointer    = 15
277:             .WordWrap        = .T.
278:             .AutoSize        = .F.
279:             .Visible         = .T.
280:         ENDWITH
281: 
282:         BINDEVENT(loc_oPg1.cmd_4c_Consulta, "Click", THIS, "BtnConsultaClick")
283: 
284:         *-- Exporta (Left=371, Width=120)
285:         loc_oPg1.AddObject("cmd_4c_Command1", "CommandButton")
286:         WITH loc_oPg1.cmd_4c_Command1
287:             .Caption         = "E" + CHR(120) + "porta"
288:             .Picture         = gc_4c_CaminhoIcones + "geral_excel_26.jpg"
289:             .PicturePosition = 13
290:             .Top             = 112
291:             .Left            = 371
292:             .Width           = 120
293:             .Height          = 40
294:             .BackColor       = RGB(255, 255, 255)
295:             .ForeColor       = RGB(90, 90, 90)
296:             .FontName        = "Tahoma"
297:             .FontSize        = 8
298:             .FontBold        = .T.
299:             .Themes          = .F.
300:             .SpecialEffect   = 0
301:             .MousePointer    = 15
302:             .WordWrap        = .T.
303:             .AutoSize        = .F.
304:             .Visible         = .T.
305:         ENDWITH
306: 
307:         BINDEVENT(loc_oPg1.cmd_4c_Command1, "Click", THIS, "BtnExportaClick")
308: 
309:         *-- Inventario/Etiqueta (Left=490, Width=120)
310:         loc_oPg1.AddObject("cmd_4c_Inventario", "CommandButton")
311:         WITH loc_oPg1.cmd_4c_Inventario
312:             .Caption         = "Etiqueta"
313:             .Picture         = gc_4c_CaminhoIcones + "operacional_etiqueta_26.jpg"
314:             .PicturePosition = 13
315:             .Top             = 112
316:             .Left            = 490
317:             .Width           = 120
318:             .Height          = 40
319:             .BackColor       = RGB(255, 255, 255)
320:             .ForeColor       = RGB(90, 90, 90)
321:             .FontName        = "Tahoma"
322:             .FontSize        = 8
323:             .FontBold        = .T.
324:             .Themes          = .F.
325:             .SpecialEffect   = 0
326:             .MousePointer    = 15
327:             .WordWrap        = .T.
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331: 
332:         BINDEVENT(loc_oPg1.cmd_4c_Inventario, "Click", THIS, "BtnInventarioClick")
333: 
334:         *-- Linha 2: botoes filtro/acao (Top=124+29=153, Height=20)
335:         *-- Processo (Left=11, Width=63)
336:         loc_oPg1.AddObject("cmd_4c_Processo", "CommandButton")
337:         WITH loc_oPg1.cmd_4c_Processo
338:             .Caption       = "Processo"
339:             .Top           = 153
340:             .Left          = 11
341:             .Width         = 63
342:             .Height        = 20
343:             .FontName      = "Tahoma"
344:             .FontSize      = 8
345:             .Themes        = .F.
346:             .SpecialEffect = 0
347:             .Visible       = .T.
348:         ENDWITH
349: 
350:         BINDEVENT(loc_oPg1.cmd_4c_Processo, "Click", THIS, "BtnProcessoClick")
351: 
352:         *-- Periodo (Left=74, Width=153)
353:         loc_oPg1.AddObject("cmd_4c_Periodo", "CommandButton")
354:         WITH loc_oPg1.cmd_4c_Periodo
355:             .Caption       = "Per" + CHR(237) + "odo"
356:             .Top           = 153
357:             .Left          = 74
358:             .Width         = 153
359:             .Height        = 20
360:             .FontName      = "Tahoma"
361:             .FontSize      = 8
362:             .Themes        = .F.
363:             .SpecialEffect = 0
364:             .Visible       = .T.
365:         ENDWITH
366: 
367:         BINDEVENT(loc_oPg1.cmd_4c_Periodo, "Click", THIS, "BtnOrdenarPeriodoClick")
368: 
369:         *-- Estoque (Left=227, Width=142)
370:         loc_oPg1.AddObject("cmd_4c_Estoque", "CommandButton")
371:         WITH loc_oPg1.cmd_4c_Estoque
372:             .Caption       = "Estoque"
373:             .Top           = 153
374:             .Left          = 227
375:             .Width         = 142
376:             .Height        = 20
377:             .FontName      = "Tahoma"
378:             .FontSize      = 8
379:             .Themes        = .F.
380:             .SpecialEffect = 0
381:             .Visible       = .T.
382:         ENDWITH
383: 
384:         BINDEVENT(loc_oPg1.cmd_4c_Estoque, "Click", THIS, "BtnOrdenarEstoqueClick")
385: 
386:         *-- Local (Left=369, Width=162)
387:         loc_oPg1.AddObject("cmd_4c_Local", "CommandButton")
388:         WITH loc_oPg1.cmd_4c_Local
389:             .Caption       = "Local"
390:             .Top           = 153
391:             .Left          = 369
392:             .Width         = 162
393:             .Height        = 20
394:             .FontName      = "Tahoma"
395:             .FontSize      = 8
396:             .Themes        = .F.
397:             .SpecialEffect = 0
398:             .Visible       = .T.
399:         ENDWITH
400: 
401:         BINDEVENT(loc_oPg1.cmd_4c_Local, "Click", THIS, "BtnOrdenarLocalClick")
402: 
403:         *-- Grupo (Left=531, Width=68)
404:         loc_oPg1.AddObject("cmd_4c_Grupo", "CommandButton")
405:         WITH loc_oPg1.cmd_4c_Grupo
406:             .Caption       = "Grupo"
407:             .Top           = 153
408:             .Left          = 531
409:             .Width         = 68
410:             .Height        = 20
411:             .FontName      = "Tahoma"
412:             .FontSize      = 8
413:             .Themes        = .F.
414:             .SpecialEffect = 0
415:             .Visible       = .T.
416:         ENDWITH
417: 
418:         BINDEVENT(loc_oPg1.cmd_4c_Grupo, "Click", THIS, "BtnOrdenarGrupoClick")
419: 
420:         *-- GGrupo (Left=599, Width=68)
421:         loc_oPg1.AddObject("cmd_4c_GGrupo", "CommandButton")
422:         WITH loc_oPg1.cmd_4c_GGrupo
423:             .Caption       = "Gde.Grupo"
424:             .Top           = 153
425:             .Left          = 599
426:             .Width         = 68
427:             .Height        = 20
428:             .FontName      = "Tahoma"
429:             .FontSize      = 8
430:             .Themes        = .F.
431:             .SpecialEffect = 0
432:             .Visible       = .T.
433:         ENDWITH
434: 
435:         BINDEVENT(loc_oPg1.cmd_4c_GGrupo, "Click", THIS, "BtnOrdenarGGrupoClick")
436: 
437:         *-- Usuario (Left=667, Width=80)
438:         loc_oPg1.AddObject("cmd_4c_Usuario", "CommandButton")
439:         WITH loc_oPg1.cmd_4c_Usuario
440:             .Caption       = "Usu" + CHR(225) + "rio"
441:             .Top           = 153
442:             .Left          = 667
443:             .Width         = 80
444:             .Height        = 20
445:             .FontName      = "Tahoma"
446:             .FontSize      = 8
447:             .Themes        = .F.
448:             .SpecialEffect = 0
449:             .Visible       = .T.
450:         ENDWITH
451: 
452:         BINDEVENT(loc_oPg1.cmd_4c_Usuario, "Click", THIS, "BtnOrdenarUsuarioClick")
453: 
454:         *-- Grid listagem (Top=175, Left=12, Width=905, Height=390)
455:         *-- RecordSource e ColumnCount FORA do WITH (VFP9: colunas criadas em Columns())
456:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
457:         loc_oPg1.grd_4c_Lista.RecordSource = ""
458:         loc_oPg1.grd_4c_Lista.ColumnCount  = 8
459: 
460:         WITH loc_oPg1.grd_4c_Lista
461:             .Top                = 175
462:             .Left               = 12
463:             .Width              = 905
464:             .Height             = 390
465:             .FontName           = "Verdana"
466:             .FontSize           = 8
467:             .ForeColor          = RGB(90, 90, 90)
468:             .BackColor          = RGB(255, 255, 255)
469:             .GridLineColor      = RGB(238, 238, 238)
470:             .HighlightBackColor = RGB(255, 255, 255)
471:             .HighlightForeColor = RGB(15, 41, 104)
472:             .HighlightStyle     = 2
473:             .DeleteMark         = .F.
474:             .RecordMark         = .F.
475:             .RowHeight          = 16
476:             .ScrollBars         = 3
477:             .GridLines          = 3
478:             .ReadOnly           = .T.
479:             .Visible            = .T.
480:             .Column1.Width      = 55
481:             .Column2.Width      = 85
482:             .Column3.Width      = 85
483:             .Column4.Width      = 85
484:             .Column5.Width      = 70
485:             .Column6.Width      = 100
486:             .Column7.Width      = 100
487:             .Column8.Width      = 90
488:             .Column1.ReadOnly   = .T.
489:             .Column2.ReadOnly   = .T.
490:             .Column3.ReadOnly   = .T.
491:             .Column4.ReadOnly   = .T.
492:             .Column5.ReadOnly   = .T.

*-- Linhas 503 a 616:
503:             .Column8.Header1.Caption = ""
504:         ENDWITH
505: 
506:         THIS.TornarControlesVisiveis(loc_oPg1)
507:     ENDPROC
508: 
509:     *--------------------------------------------------------------------------
510:     * ConfigurarPaginaDados - Cria Page2: parametros de filtro do inventario
511:     *--------------------------------------------------------------------------
512:     PROTECTED PROCEDURE ConfigurarPaginaDados()
513:         LOCAL loc_oPg2, loc_oGrdGGrupo, loc_oGrdGrupo
514: 
515:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
516: 
517:         *-- Container botoes Confirmar/Cancelar (Top=29, Left=842)
518:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
519:         WITH loc_oPg2.cnt_4c_BotoesAcao
520:             .Top         = 29
521:             .Left        = 842
522:             .Width       = 160
523:             .Height      = 85
524:             .BackStyle   = 0
525:             .BorderWidth = 0
526:             .Visible     = .T.
527:         ENDWITH
528: 
529:         loc_oPg2.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
530:         WITH loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar
531:             .Caption         = "Confirmar"
532:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
533:             .PicturePosition = 13
534:             .Top             = 5
535:             .Left            = 5
536:             .Width           = 75
537:             .Height          = 75
538:             .BackColor       = RGB(255, 255, 255)
539:             .ForeColor       = RGB(90, 90, 90)
540:             .FontName        = "Tahoma"
541:             .FontSize        = 8
542:             .FontBold        = .T.
543:             .FontItalic      = .T.
544:             .Themes          = .F.
545:             .SpecialEffect   = 0
546:             .MousePointer    = 15
547:             .WordWrap        = .T.
548:             .AutoSize        = .F.
549:             .Visible         = .T.
550:         ENDWITH
551: 
552:         loc_oPg2.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
553:         WITH loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar
554:             .Caption         = "Encerrar"
555:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
556:             .PicturePosition = 13
557:             .Top             = 5
558:             .Left            = 80
559:             .Width           = 75
560:             .Height          = 75
561:             .BackColor       = RGB(255, 255, 255)
562:             .ForeColor       = RGB(90, 90, 90)
563:             .FontName        = "Tahoma"
564:             .FontSize        = 8
565:             .FontBold        = .T.
566:             .FontItalic      = .T.
567:             .Themes          = .F.
568:             .SpecialEffect   = 0
569:             .MousePointer    = 15
570:             .WordWrap        = .T.
571:             .AutoSize        = .F.
572:             .Visible         = .T.
573:         ENDWITH
574: 
575:         BINDEVENT(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
576:         BINDEVENT(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
577: 
578:         *-- LINHA 1: Codigo (Left=336, Top=68+29=97) + Data Base (Left=572, Top=97)
579:         *-- Say3: "Codigo :" (Top=101, Left=289, Width=42)
580:         loc_oPg2.AddObject("lbl_4c_Label3", "Label")
581:         WITH loc_oPg2.lbl_4c_Label3
582:             .Caption   = "C" + CHR(243) + "digo :"
583:             .Top       = 101
584:             .Left      = 289
585:             .Width     = 42
586:             .AutoSize  = .F.
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .ForeColor = RGB(255, 255, 255)
590:             .BackStyle = 0
591:             .Alignment = 1
592:             .Visible   = .T.
593:         ENDWITH
594: 
595:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
596:         WITH loc_oPg2.txt_4c_Codigo
597:             .Value         = 0
598:             .Top           = 97
599:             .Left          = 336
600:             .Width         = 82
601:             .Height        = 23
602:             .FontName      = "Tahoma"
603:             .FontSize      = 8
604:             .ForeColor     = RGB(90, 90, 90)
605:             .BackColor     = RGB(255, 255, 255)
606:             .BorderStyle   = 1
607:             .SpecialEffect = 0
608:             .ReadOnly      = .T.
609:             .Visible       = .T.
610:         ENDWITH
611: 
612:         *-- Say15: "Data Base :" (Top=101, Left=500, Width=58)
613:         loc_oPg2.AddObject("lbl_4c_Label15", "Label")
614:         WITH loc_oPg2.lbl_4c_Label15
615:             .Caption   = "Data Base :"
616:             .Top       = 101

*-- Linhas 676 a 719:
676:             .Visible       = .T.
677:         ENDWITH
678: 
679:         BINDEVENT(loc_oPg2.txt_4c_Grupo, "KeyPress", THIS, "KeyPressGrupo")
680: 
681:         *-- Get_DGrupo: descricao do grupo (Top=123, Left=421, Width=232)
682:         loc_oPg2.AddObject("txt_4c_DGrupo", "TextBox")
683:         WITH loc_oPg2.txt_4c_DGrupo
684:             .Value         = ""
685:             .Top           = 123
686:             .Left          = 421
687:             .Width         = 232
688:             .Height        = 23
689:             .FontName      = "Tahoma"
690:             .FontSize      = 8
691:             .ForeColor     = RGB(90, 90, 90)
692:             .BackColor     = RGB(240, 240, 240)
693:             .BorderStyle   = 1
694:             .SpecialEffect = 0
695:             .ReadOnly      = .T.
696:             .Visible       = .T.
697:         ENDWITH
698: 
699:         *-- LINHA 3: Conta/Estoque (Left=336, Top=120+29=149)
700:         *-- Say12: "Estoque :" (Top=153, Left=283, Width=48)
701:         loc_oPg2.AddObject("lbl_4c_Label12", "Label")
702:         WITH loc_oPg2.lbl_4c_Label12
703:             .Caption   = "Estoque :"
704:             .Top       = 153
705:             .Left      = 283
706:             .Width     = 48
707:             .AutoSize  = .F.
708:             .FontName  = "Tahoma"
709:             .FontSize  = 8
710:             .ForeColor = RGB(255, 255, 255)
711:             .BackStyle = 0
712:             .Alignment = 1
713:             .Visible   = .T.
714:         ENDWITH
715: 
716:         loc_oPg2.AddObject("txt_4c_Conta", "TextBox")
717:         WITH loc_oPg2.txt_4c_Conta
718:             .Value         = ""
719:             .Top           = 149

*-- Linhas 730 a 773:
730:             .Visible       = .T.
731:         ENDWITH
732: 
733:         BINDEVENT(loc_oPg2.txt_4c_Conta, "KeyPress", THIS, "KeyPressConta")
734: 
735:         *-- Get_DConta: descricao conta (Top=149, Left=421, Width=232)
736:         loc_oPg2.AddObject("txt_4c_DConta", "TextBox")
737:         WITH loc_oPg2.txt_4c_DConta
738:             .Value         = ""
739:             .Top           = 149
740:             .Left          = 421
741:             .Width         = 232
742:             .Height        = 23
743:             .FontName      = "Tahoma"
744:             .FontSize      = 8
745:             .ForeColor     = RGB(90, 90, 90)
746:             .BackColor     = RGB(240, 240, 240)
747:             .BorderStyle   = 1
748:             .SpecialEffect = 0
749:             .ReadOnly      = .T.
750:             .Visible       = .T.
751:         ENDWITH
752: 
753:         *-- LINHA 4: Data (Top=146+29=175) - Get_DataFinal + Get_DataInicial
754:         *-- Say1: "Data :" (Top=180, Left=299, Width=32)
755:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
756:         WITH loc_oPg2.lbl_4c_Label1
757:             .Caption   = "Data :"
758:             .Top       = 180
759:             .Left      = 299
760:             .Width     = 32
761:             .AutoSize  = .F.
762:             .FontName  = "Tahoma"
763:             .FontSize  = 8
764:             .ForeColor = RGB(255, 255, 255)
765:             .BackStyle = 0
766:             .Alignment = 1
767:             .Visible   = .T.
768:         ENDWITH
769: 
770:         loc_oPg2.AddObject("txt_4c_DataFinal", "TextBox")
771:         WITH loc_oPg2.txt_4c_DataFinal
772:             .Value         = {}
773:             .Top           = 175

*-- Linhas 835 a 981:
835:             .Visible       = .T.
836:         ENDWITH
837: 
838:         BINDEVENT(loc_oPg2.txt_4c_CProsI, "KeyPress", THIS, "KeyPressCProsI")
839: 
840:         *-- Say20: "a" separator (Top=205, Left=446, Width=14)
841:         loc_oPg2.AddObject("lbl_4c_Label20", "Label")
842:         WITH loc_oPg2.lbl_4c_Label20
843:             .Caption   = CHR(224)
844:             .Top       = 205
845:             .Left      = 446
846:             .Width     = 14
847:             .AutoSize  = .F.
848:             .FontName  = "Tahoma"
849:             .FontSize  = 8
850:             .ForeColor = RGB(255, 255, 255)
851:             .BackStyle = 0
852:             .Visible   = .T.
853:         ENDWITH
854: 
855:         loc_oPg2.AddObject("txt_4c_CProsF", "TextBox")
856:         WITH loc_oPg2.txt_4c_CProsF
857:             .Value         = ""
858:             .Top           = 201
859:             .Left          = 464
860:             .Width         = 108
861:             .Height        = 23
862:             .FontName      = "Tahoma"
863:             .FontSize      = 8
864:             .ForeColor     = RGB(90, 90, 90)
865:             .BackColor     = RGB(255, 255, 255)
866:             .BorderStyle   = 1
867:             .SpecialEffect = 0
868:             .MaxLength     = 14
869:             .Visible       = .T.
870:         ENDWITH
871: 
872:         BINDEVENT(loc_oPg2.txt_4c_CProsF, "KeyPress", THIS, "KeyPressCProsF")
873: 
874:         *-- LINHA 6: Local (Top=198+29=227)
875:         *-- Say2: "Local :" (Top=231, Left=298, Width=33)
876:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
877:         WITH loc_oPg2.lbl_4c_Label2
878:             .Caption   = "Local :"
879:             .Top       = 231
880:             .Left      = 298
881:             .Width     = 33
882:             .AutoSize  = .F.
883:             .FontName  = "Tahoma"
884:             .FontSize  = 8
885:             .ForeColor = RGB(255, 255, 255)
886:             .BackStyle = 0
887:             .Alignment = 1
888:             .Visible   = .T.
889:         ENDWITH
890: 
891:         loc_oPg2.AddObject("txt_4c_LocalInicial", "TextBox")
892:         WITH loc_oPg2.txt_4c_LocalInicial
893:             .Value         = ""
894:             .Top           = 227
895:             .Left          = 336
896:             .Width         = 82
897:             .Height        = 23
898:             .FontName      = "Tahoma"
899:             .FontSize      = 8
900:             .ForeColor     = RGB(90, 90, 90)
901:             .BackColor     = RGB(255, 255, 255)
902:             .BorderStyle   = 1
903:             .SpecialEffect = 0
904:             .MaxLength     = 10
905:             .Visible       = .T.
906:         ENDWITH
907: 
908:         BINDEVENT(loc_oPg2.txt_4c_LocalInicial, "KeyPress", THIS, "KeyPressLocalInicial")
909: 
910:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
911:         WITH loc_oPg2.lbl_4c_Label5
912:             .Caption   = CHR(224)
913:             .Top       = 231
914:             .Left      = 423
915:             .Width     = 14
916:             .AutoSize  = .F.
917:             .FontName  = "Tahoma"
918:             .FontSize  = 8
919:             .ForeColor = RGB(255, 255, 255)
920:             .BackStyle = 0
921:             .Visible   = .T.
922:         ENDWITH
923: 
924:         loc_oPg2.AddObject("txt_4c_LocalFinal", "TextBox")
925:         WITH loc_oPg2.txt_4c_LocalFinal
926:             .Value         = ""
927:             .Top           = 227
928:             .Left          = 443
929:             .Width         = 82
930:             .Height        = 23
931:             .FontName      = "Tahoma"
932:             .FontSize      = 8
933:             .ForeColor     = RGB(90, 90, 90)
934:             .BackColor     = RGB(255, 255, 255)
935:             .BorderStyle   = 1
936:             .SpecialEffect = 0
937:             .MaxLength     = 10
938:             .Visible       = .T.
939:         ENDWITH
940: 
941:         BINDEVENT(loc_oPg2.txt_4c_LocalFinal, "KeyPress", THIS, "KeyPressLocalFinal")
942: 
943:         *-- LINHA 7: Fornecedor (Top=224+29=253)
944:         *-- Say6: "Fornecedor :" (Top=257, Left=267, Width=64)
945:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
946:         WITH loc_oPg2.lbl_4c_Label6
947:             .Caption   = "Fornecedor :"
948:             .Top       = 257
949:             .Left      = 267
950:             .Width     = 64
951:             .Height    = 15
952:             .AutoSize  = .F.
953:             .FontName  = "Tahoma"
954:             .FontSize  = 8
955:             .ForeColor = RGB(255, 255, 255)
956:             .BackStyle = 0
957:             .Alignment = 1
958:             .Visible   = .T.
959:         ENDWITH
960: 
961:         loc_oPg2.AddObject("txt_4c_FornecInicial", "TextBox")
962:         WITH loc_oPg2.txt_4c_FornecInicial
963:             .Value         = ""
964:             .Top           = 253
965:             .Left          = 336
966:             .Width         = 82
967:             .Height        = 23
968:             .FontName      = "Tahoma"
969:             .FontSize      = 8
970:             .ForeColor     = RGB(90, 90, 90)
971:             .BackColor     = RGB(255, 255, 255)
972:             .BorderStyle   = 1
973:             .SpecialEffect = 0
974:             .MaxLength     = 10
975:             .Visible       = .T.
976:         ENDWITH
977: 
978:         loc_oPg2.AddObject("lbl_4c_Label7", "Label")
979:         WITH loc_oPg2.lbl_4c_Label7
980:             .Caption   = CHR(224)
981:             .Top       = 257

*-- Linhas 1006 a 1188:
1006:             .Visible       = .T.
1007:         ENDWITH
1008: 
1009:         BINDEVENT(loc_oPg2.txt_4c_FornecInicial, "KeyPress", THIS, "KeyPressFornecInicial")
1010:         BINDEVENT(loc_oPg2.txt_4c_FornecFinal,   "KeyPress", THIS, "KeyPressFornecFinal")
1011: 
1012:         *-- LINHA 8: Grande Grupo (Top=250+29=279)
1013:         *-- Say13: "Grande Grupo :" (Top=283, Left=255, Width=76)
1014:         loc_oPg2.AddObject("lbl_4c_Label13", "Label")
1015:         WITH loc_oPg2.lbl_4c_Label13
1016:             .Caption   = "Grande Grupo :"
1017:             .Top       = 283
1018:             .Left      = 255
1019:             .Width     = 76
1020:             .AutoSize  = .F.
1021:             .FontName  = "Tahoma"
1022:             .FontSize  = 8
1023:             .ForeColor = RGB(255, 255, 255)
1024:             .BackStyle = 0
1025:             .Alignment = 1
1026:             .Visible   = .T.
1027:         ENDWITH
1028: 
1029:         loc_oPg2.AddObject("txt_4c_GGrupoInicial", "TextBox")
1030:         WITH loc_oPg2.txt_4c_GGrupoInicial
1031:             .Value         = ""
1032:             .Top           = 279
1033:             .Left          = 336
1034:             .Width         = 34
1035:             .Height        = 23
1036:             .FontName      = "Tahoma"
1037:             .FontSize      = 8
1038:             .ForeColor     = RGB(90, 90, 90)
1039:             .BackColor     = RGB(255, 255, 255)
1040:             .BorderStyle   = 1
1041:             .SpecialEffect = 0
1042:             .MaxLength     = 3
1043:             .Visible       = .T.
1044:         ENDWITH
1045: 
1046:         BINDEVENT(loc_oPg2.txt_4c_GGrupoInicial, "KeyPress", THIS, "KeyPressGGrupoInicial")
1047: 
1048:         loc_oPg2.AddObject("lbl_4c_Label14", "Label")
1049:         WITH loc_oPg2.lbl_4c_Label14
1050:             .Caption   = CHR(224)
1051:             .Top       = 283
1052:             .Left      = 423
1053:             .Width     = 14
1054:             .AutoSize  = .F.
1055:             .FontName  = "Tahoma"
1056:             .FontSize  = 8
1057:             .ForeColor = RGB(255, 255, 255)
1058:             .BackStyle = 0
1059:             .Visible   = .T.
1060:         ENDWITH
1061: 
1062:         loc_oPg2.AddObject("txt_4c_GGrupoFinal", "TextBox")
1063:         WITH loc_oPg2.txt_4c_GGrupoFinal
1064:             .Value         = ""
1065:             .Top           = 279
1066:             .Left          = 443
1067:             .Width         = 34
1068:             .Height        = 23
1069:             .FontName      = "Tahoma"
1070:             .FontSize      = 8
1071:             .ForeColor     = RGB(90, 90, 90)
1072:             .BackColor     = RGB(255, 255, 255)
1073:             .BorderStyle   = 1
1074:             .SpecialEffect = 0
1075:             .MaxLength     = 3
1076:             .Visible       = .T.
1077:         ENDWITH
1078: 
1079:         BINDEVENT(loc_oPg2.txt_4c_GGrupoFinal, "KeyPress", THIS, "KeyPressGGrupoFinal")
1080: 
1081:         *-- LINHA 9: Grupo Produto (Top=276+29=305)
1082:         *-- Say8: "Grupo :" (Top=309, Left=293, Width=38)
1083:         loc_oPg2.AddObject("lbl_4c_Label8", "Label")
1084:         WITH loc_oPg2.lbl_4c_Label8
1085:             .Caption   = "Grupo :"
1086:             .Top       = 309
1087:             .Left      = 293
1088:             .Width     = 38
1089:             .AutoSize  = .F.
1090:             .FontName  = "Tahoma"
1091:             .FontSize  = 8
1092:             .ForeColor = RGB(255, 255, 255)
1093:             .BackStyle = 0
1094:             .Alignment = 1
1095:             .Visible   = .T.
1096:         ENDWITH
1097: 
1098:         loc_oPg2.AddObject("txt_4c_GrupoInicial", "TextBox")
1099:         WITH loc_oPg2.txt_4c_GrupoInicial
1100:             .Value         = ""
1101:             .Top           = 305
1102:             .Left          = 336
1103:             .Width         = 34
1104:             .Height        = 23
1105:             .FontName      = "Tahoma"
1106:             .FontSize      = 8
1107:             .ForeColor     = RGB(90, 90, 90)
1108:             .BackColor     = RGB(255, 255, 255)
1109:             .BorderStyle   = 1
1110:             .SpecialEffect = 0
1111:             .MaxLength     = 3
1112:             .Visible       = .T.
1113:         ENDWITH
1114: 
1115:         BINDEVENT(loc_oPg2.txt_4c_GrupoInicial, "KeyPress", THIS, "KeyPressGrupoInicial")
1116: 
1117:         loc_oPg2.AddObject("lbl_4c_Label9", "Label")
1118:         WITH loc_oPg2.lbl_4c_Label9
1119:             .Caption   = CHR(224)
1120:             .Top       = 309
1121:             .Left      = 423
1122:             .Width     = 14
1123:             .AutoSize  = .F.
1124:             .FontName  = "Tahoma"
1125:             .FontSize  = 8
1126:             .ForeColor = RGB(255, 255, 255)
1127:             .BackStyle = 0
1128:             .Visible   = .T.
1129:         ENDWITH
1130: 
1131:         loc_oPg2.AddObject("txt_4c_GrupoFinal", "TextBox")
1132:         WITH loc_oPg2.txt_4c_GrupoFinal
1133:             .Value         = ""
1134:             .Top           = 305
1135:             .Left          = 443
1136:             .Width         = 34
1137:             .Height        = 23
1138:             .FontName      = "Tahoma"
1139:             .FontSize      = 8
1140:             .ForeColor     = RGB(90, 90, 90)
1141:             .BackColor     = RGB(255, 255, 255)
1142:             .BorderStyle   = 1
1143:             .SpecialEffect = 0
1144:             .MaxLength     = 3
1145:             .Visible       = .T.
1146:         ENDWITH
1147: 
1148:         BINDEVENT(loc_oPg2.txt_4c_GrupoFinal, "KeyPress", THIS, "KeyPressGrupoFinal")
1149: 
1150:         *-- LINHA 10: Subgrupo (Top=301+29=330)
1151:         *-- Say23: "Subgrupo :" (Top=334, Left=276, Width=55)
1152:         loc_oPg2.AddObject("lbl_4c_Label23", "Label")
1153:         WITH loc_oPg2.lbl_4c_Label23
1154:             .Caption   = "Subgrupo :"
1155:             .Top       = 334
1156:             .Left      = 276
1157:             .Width     = 55
1158:             .AutoSize  = .F.
1159:             .FontName  = "Tahoma"
1160:             .FontSize  = 8
1161:             .ForeColor = RGB(255, 255, 255)
1162:             .BackStyle = 0
1163:             .Alignment = 1
1164:             .Visible   = .T.
1165:         ENDWITH
1166: 
1167:         loc_oPg2.AddObject("txt_4c_SGrusI", "TextBox")
1168:         WITH loc_oPg2.txt_4c_SGrusI
1169:             .Value         = ""
1170:             .Top           = 330
1171:             .Left          = 336
1172:             .Width         = 52
1173:             .Height        = 23
1174:             .FontName      = "Tahoma"
1175:             .FontSize      = 8
1176:             .ForeColor     = RGB(90, 90, 90)
1177:             .BackColor     = RGB(255, 255, 255)
1178:             .BorderStyle   = 1
1179:             .SpecialEffect = 0
1180:             .MaxLength     = 6
1181:             .Visible       = .T.
1182:         ENDWITH
1183: 
1184:         loc_oPg2.AddObject("lbl_4c_Label24", "Label")
1185:         WITH loc_oPg2.lbl_4c_Label24
1186:             .Caption   = CHR(224)
1187:             .Top       = 334
1188:             .Left      = 423

*-- Linhas 1212 a 1256:
1212:             .Visible       = .T.
1213:         ENDWITH
1214: 
1215:         BINDEVENT(loc_oPg2.txt_4c_SGrusI, "KeyPress", THIS, "KeyPressSGrusI")
1216:         BINDEVENT(loc_oPg2.txt_4c_SGrusF, "KeyPress", THIS, "KeyPressSGrusF")
1217: 
1218:         *-- LINHA 11: Preco (Top=326+29=355)
1219:         *-- Say10: "Preco :" (Top=359, Left=295, Width=36)
1220:         loc_oPg2.AddObject("lbl_4c_Label10", "Label")
1221:         WITH loc_oPg2.lbl_4c_Label10
1222:             .Caption   = "Pre" + CHR(231) + "o :"
1223:             .Top       = 359
1224:             .Left      = 295
1225:             .Width     = 36
1226:             .Height    = 15
1227:             .AutoSize  = .F.
1228:             .FontName  = "Tahoma"
1229:             .FontSize  = 8
1230:             .ForeColor = RGB(255, 255, 255)
1231:             .BackStyle = 0
1232:             .Alignment = 1
1233:             .Visible   = .T.
1234:         ENDWITH
1235: 
1236:         loc_oPg2.AddObject("txt_4c_PrecoInicial", "TextBox")
1237:         WITH loc_oPg2.txt_4c_PrecoInicial
1238:             .Value         = 0
1239:             .Top           = 355
1240:             .Left          = 336
1241:             .Width         = 82
1242:             .Height        = 23
1243:             .FontName      = "Tahoma"
1244:             .FontSize      = 8
1245:             .ForeColor     = RGB(90, 90, 90)
1246:             .BackColor     = RGB(255, 255, 255)
1247:             .BorderStyle   = 1
1248:             .SpecialEffect = 0
1249:             .Format        = "K"
1250:             .Visible       = .T.
1251:         ENDWITH
1252: 
1253:         loc_oPg2.AddObject("lbl_4c_Label11", "Label")
1254:         WITH loc_oPg2.lbl_4c_Label11
1255:             .Caption   = CHR(224)
1256:             .Top       = 359

*-- Linhas 1315 a 1391:
1315:             .Visible       = .T.
1316:         ENDWITH
1317: 
1318:         BINDEVENT(loc_oPg2.txt_4c_Lin, "KeyPress", THIS, "KeyPressLin")
1319: 
1320:         loc_oPg2.AddObject("lbl_4c_Label18", "Label")
1321:         WITH loc_oPg2.lbl_4c_Label18
1322:             .Caption   = CHR(224)
1323:             .Top       = 384
1324:             .Left      = 423
1325:             .Width     = 14
1326:             .AutoSize  = .F.
1327:             .FontName  = "Tahoma"
1328:             .FontSize  = 8
1329:             .ForeColor = RGB(255, 255, 255)
1330:             .BackStyle = 0
1331:             .Visible   = .T.
1332:         ENDWITH
1333: 
1334:         loc_oPg2.AddObject("txt_4c_Lin2", "TextBox")
1335:         WITH loc_oPg2.txt_4c_Lin2
1336:             .Value         = ""
1337:             .Top           = 380
1338:             .Left          = 443
1339:             .Width         = 82
1340:             .Height        = 23
1341:             .FontName      = "Tahoma"
1342:             .FontSize      = 8
1343:             .ForeColor     = RGB(90, 90, 90)
1344:             .BackColor     = RGB(255, 255, 255)
1345:             .BorderStyle   = 1
1346:             .SpecialEffect = 0
1347:             .MaxLength     = 10
1348:             .Visible       = .T.
1349:         ENDWITH
1350: 
1351:         BINDEVENT(loc_oPg2.txt_4c_Lin2, "KeyPress", THIS, "KeyPressLin2")
1352: 
1353:         *-- LINHA 13: Grupo de Venda/Colecao (Top=376+29=405)
1354:         *-- Say22: "Grupo de Venda :" (Top=409, Left=245, Width=86)
1355:         loc_oPg2.AddObject("lbl_4c_Label22", "Label")
1356:         WITH loc_oPg2.lbl_4c_Label22
1357:             .Caption   = "Grupo de Venda :"
1358:             .Top       = 409
1359:             .Left      = 245
1360:             .Width     = 86
1361:             .Height    = 15
1362:             .AutoSize  = .F.
1363:             .FontName  = "Tahoma"
1364:             .FontSize  = 8
1365:             .ForeColor = RGB(255, 255, 255)
1366:             .BackStyle = 0
1367:             .Visible   = .T.
1368:         ENDWITH
1369: 
1370:         loc_oPg2.AddObject("txt_4c_ColecoesI", "TextBox")
1371:         WITH loc_oPg2.txt_4c_ColecoesI
1372:             .Value         = ""
1373:             .Top           = 405
1374:             .Left          = 336
1375:             .Width         = 82
1376:             .Height        = 23
1377:             .FontName      = "Tahoma"
1378:             .FontSize      = 8
1379:             .ForeColor     = RGB(90, 90, 90)
1380:             .BackColor     = RGB(255, 255, 255)
1381:             .BorderStyle   = 1
1382:             .SpecialEffect = 0
1383:             .MaxLength     = 10
1384:             .Visible       = .T.
1385:         ENDWITH
1386: 
1387:         loc_oPg2.AddObject("lbl_4c_Label21", "Label")
1388:         WITH loc_oPg2.lbl_4c_Label21
1389:             .Caption   = CHR(224)
1390:             .Top       = 409
1391:             .Left      = 423

*-- Linhas 1415 a 1636:
1415:             .Visible       = .T.
1416:         ENDWITH
1417: 
1418:         BINDEVENT(loc_oPg2.txt_4c_ColecoesI, "KeyPress", THIS, "KeyPressColecoesI")
1419:         BINDEVENT(loc_oPg2.txt_4c_ColecoesF, "KeyPress", THIS, "KeyPressColecoesF")
1420: 
1421:         *-- LINHA 14: Unidade (Top=402+29=431)
1422:         *-- Say26: "Unidade :" (Top=435, Left=283, Width=48)
1423:         loc_oPg2.AddObject("lbl_4c_Label26", "Label")
1424:         WITH loc_oPg2.lbl_4c_Label26
1425:             .Caption   = "Unidade :"
1426:             .Top       = 435
1427:             .Left      = 283
1428:             .Width     = 48
1429:             .Height    = 15
1430:             .AutoSize  = .F.
1431:             .FontName  = "Tahoma"
1432:             .FontSize  = 8
1433:             .ForeColor = RGB(255, 255, 255)
1434:             .BackStyle = 0
1435:             .Visible   = .T.
1436:         ENDWITH
1437: 
1438:         loc_oPg2.AddObject("txt_4c__UniIni", "TextBox")
1439:         WITH loc_oPg2.txt_4c__UniIni
1440:             .Value         = ""
1441:             .Top           = 431
1442:             .Left          = 336
1443:             .Width         = 40
1444:             .Height        = 23
1445:             .FontName      = "Tahoma"
1446:             .FontSize      = 8
1447:             .ForeColor     = RGB(90, 90, 90)
1448:             .BackColor     = RGB(255, 255, 255)
1449:             .BorderStyle   = 1
1450:             .SpecialEffect = 0
1451:             .MaxLength     = 3
1452:             .Visible       = .T.
1453:         ENDWITH
1454: 
1455:         BINDEVENT(loc_oPg2.txt_4c__UniIni, "KeyPress", THIS, "KeyPressUniIni")
1456: 
1457:         loc_oPg2.AddObject("lbl_4c_Label4", "Label")
1458:         WITH loc_oPg2.lbl_4c_Label4
1459:             .Caption   = CHR(224)
1460:             .Top       = 435
1461:             .Left      = 423
1462:             .Width     = 14
1463:             .AutoSize  = .F.
1464:             .FontName  = "Tahoma"
1465:             .FontSize  = 8
1466:             .ForeColor = RGB(255, 255, 255)
1467:             .BackStyle = 0
1468:             .Visible   = .T.
1469:         ENDWITH
1470: 
1471:         loc_oPg2.AddObject("txt_4c__UniFim", "TextBox")
1472:         WITH loc_oPg2.txt_4c__UniFim
1473:             .Value         = ""
1474:             .Top           = 431
1475:             .Left          = 443
1476:             .Width         = 40
1477:             .Height        = 23
1478:             .FontName      = "Tahoma"
1479:             .FontSize      = 8
1480:             .ForeColor     = RGB(90, 90, 90)
1481:             .BackColor     = RGB(255, 255, 255)
1482:             .BorderStyle   = 1
1483:             .SpecialEffect = 0
1484:             .MaxLength     = 3
1485:             .Visible       = .T.
1486:         ENDWITH
1487: 
1488:         BINDEVENT(loc_oPg2.txt_4c__UniFim, "KeyPress", THIS, "KeyPressUniFim")
1489: 
1490:         *-- LINHA 15: Observacao 1 / Obs por peso (Top=427+29=456)
1491:         *-- Say25: "Observacao 1:" (Top=460, Left=258, Width=73)
1492:         loc_oPg2.AddObject("lbl_4c_Label25", "Label")
1493:         WITH loc_oPg2.lbl_4c_Label25
1494:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o 1:"
1495:             .Top       = 460
1496:             .Left      = 258
1497:             .Width     = 73
1498:             .Height    = 15
1499:             .AutoSize  = .F.
1500:             .FontName  = "Tahoma"
1501:             .FontSize  = 8
1502:             .ForeColor = RGB(255, 255, 255)
1503:             .BackStyle = 0
1504:             .Visible   = .T.
1505:         ENDWITH
1506: 
1507:         loc_oPg2.AddObject("txt_4c_ObsPes", "TextBox")
1508:         WITH loc_oPg2.txt_4c_ObsPes
1509:             .Value         = ""
1510:             .Top           = 456
1511:             .Left          = 336
1512:             .Width         = 220
1513:             .Height        = 23
1514:             .FontName      = "Tahoma"
1515:             .FontSize      = 8
1516:             .ForeColor     = RGB(90, 90, 90)
1517:             .BackColor     = RGB(255, 255, 255)
1518:             .BorderStyle   = 1
1519:             .SpecialEffect = 0
1520:             .Visible       = .T.
1521:         ENDWITH
1522: 
1523:         *-- LINHA 16: Agrupa (OptionGroup, Top=453+29=482)
1524:         *-- Say16: "Agrupa :" (Top=481, Left=287, Width=44)
1525:         loc_oPg2.AddObject("lbl_4c_Label16", "Label")
1526:         WITH loc_oPg2.lbl_4c_Label16
1527:             .Caption   = "Agrupa :"
1528:             .Top       = 481
1529:             .Left      = 287
1530:             .Width     = 44
1531:             .Height    = 15
1532:             .AutoSize  = .F.
1533:             .FontName  = "Tahoma"
1534:             .FontSize  = 8
1535:             .ForeColor = RGB(255, 255, 255)
1536:             .BackStyle = 0
1537:             .Alignment = 1
1538:             .Visible   = .T.
1539:         ENDWITH
1540: 
1541:         *-- Opt_Agrupa: 2 botoes (Top=482, Left=330, Width=263, Height=16)
1542:         loc_oPg2.AddObject("obj_4c_Opt_Agrupa", "OptionGroup")
1543:         WITH loc_oPg2.obj_4c_Opt_Agrupa
1544:             .Value       = 1
1545:             .ButtonCount = 2
1546:             .Top         = 482
1547:             .Left        = 330
1548:             .Width       = 263
1549:             .Height      = 16
1550:             .BackStyle   = 0
1551:             .BorderStyle = 0
1552:             .Visible     = .T.
1553:             WITH .Buttons(1)
1554:                 .Caption   = "Sim"
1555:                 .Left      = 0
1556:                 .Top       = 0
1557:                 .Width     = 130
1558:                 .Height    = 16
1559:                 .AutoSize  = .F.
1560:                 .BackStyle = 0
1561:                 .ForeColor = RGB(255, 255, 255)
1562:                 .Themes    = .F.
1563:             ENDWITH
1564:             WITH .Buttons(2)
1565:                 .Caption   = "N" + CHR(227) + "o"
1566:                 .Left      = 132
1567:                 .Top       = 0
1568:                 .Width     = 131
1569:                 .Height    = 16
1570:                 .AutoSize  = .F.
1571:                 .BackStyle = 0
1572:                 .ForeColor = RGB(255, 255, 255)
1573:                 .Themes    = .F.
1574:             ENDWITH
1575:         ENDWITH
1576: 
1577:         *-- LINHA 17: Cod Barras (OptionGroup, Top=469+29=498)
1578:         *-- Say28: "Cod. Barras :" (Top=499, Left=265, Width=66)
1579:         loc_oPg2.AddObject("lbl_4c_Label28", "Label")
1580:         WITH loc_oPg2.lbl_4c_Label28
1581:             .Caption   = "C" + CHR(243) + "d. Barras :"
1582:             .Top       = 499
1583:             .Left      = 265
1584:             .Width     = 66
1585:             .Height    = 15
1586:             .AutoSize  = .F.
1587:             .FontName  = "Tahoma"
1588:             .FontSize  = 8
1589:             .ForeColor = RGB(255, 255, 255)
1590:             .BackStyle = 0
1591:             .Alignment = 1
1592:             .Visible   = .T.
1593:         ENDWITH
1594: 
1595:         *-- optFilBarra: 3 botoes (Top=498, Left=330, Width=209, Height=14)
1596:         loc_oPg2.AddObject("obj_4c_OptFilBarra", "OptionGroup")
1597:         WITH loc_oPg2.obj_4c_OptFilBarra
1598:             .Value       = 1
1599:             .ButtonCount = 3
1600:             .Top         = 498
1601:             .Left        = 330
1602:             .Width       = 209
1603:             .Height      = 14
1604:             .BackStyle   = 0
1605:             .BorderStyle = 0
1606:             .Visible     = .T.
1607:             WITH .Buttons(1)
1608:                 .Caption   = "Padr" + CHR(227) + "o"
1609:                 .Left      = 0
1610:                 .Top       = 0
1611:                 .Width     = 68
1612:                 .Height    = 14
1613:                 .AutoSize  = .F.
1614:                 .BackStyle = 0
1615:                 .ForeColor = RGB(255, 255, 255)
1616:                 .Themes    = .F.
1617:             ENDWITH
1618:             WITH .Buttons(2)
1619:                 .Caption   = "EAN13"
1620:                 .Left      = 70
1621:                 .Top       = 0
1622:                 .Width     = 68
1623:                 .Height    = 14
1624:                 .AutoSize  = .F.
1625:                 .BackStyle = 0
1626:                 .ForeColor = RGB(255, 255, 255)
1627:                 .Themes    = .F.
1628:             ENDWITH
1629:             WITH .Buttons(3)
1630:                 .Caption   = "2 de 5"
1631:                 .Left      = 140
1632:                 .Top       = 0
1633:                 .Width     = 69
1634:                 .Height    = 14
1635:                 .AutoSize  = .F.
1636:                 .BackStyle = 0

*-- Linhas 1805 a 1865:
1805:             .Visible         = .T.
1806:         ENDWITH
1807: 
1808:         BINDEVENT(loc_oPg2.cmd_4c_Command3, "Click", THIS, "BtnSelecionarTodosGGrupoClick")
1809: 
1810:         loc_oPg2.AddObject("cmd_4c_Command4", "CommandButton")
1811:         WITH loc_oPg2.cmd_4c_Command4
1812:             .Caption         = ""
1813:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1814:             .PicturePosition = 13
1815:             .Top             = 257
1816:             .Left            = 924
1817:             .Width           = 45
1818:             .Height          = 45
1819:             .ToolTipText     = "Desmarcar Todos"
1820:             .Themes          = .T.
1821:             .SpecialEffect   = 0
1822:             .Visible         = .T.
1823:         ENDWITH
1824: 
1825:         BINDEVENT(loc_oPg2.cmd_4c_Command4, "Click", THIS, "BtnDesmarcarTodosGGrupoClick")
1826: 
1827:         *-- COLUNA DIREITA: Grade Grupo Produto (Top=330+29=359, Left=683)
1828:         *-- Label1: "Grupo Produto" (Top=342, Left=683, Width=84)
1829:         loc_oPg2.AddObject("lbl_4c_label110", "Label")
1830:         WITH loc_oPg2.lbl_4c_label110
1831:             .Caption   = "Grupo Produto"
1832:             .Top       = 342
1833:             .Left      = 683
1834:             .Width     = 84
1835:             .Height    = 15
1836:             .AutoSize  = .F.
1837:             .FontName  = "Tahoma"
1838:             .FontSize  = 8
1839:             .FontBold  = .T.
1840:             .ForeColor = RGB(255, 255, 255)
1841:             .BackStyle = 0
1842:             .Visible   = .T.
1843:         ENDWITH
1844: 
1845:         *-- grdgrupo (Top=359, Left=683, Width=238, Height=147)
1846:         loc_oPg2.AddObject("grd_4c_Grupos", "Grid")
1847:         loc_oPg2.grd_4c_Grupos.RecordSource = ""
1848:         loc_oPg2.grd_4c_Grupos.ColumnCount  = 3
1849: 
1850:         loc_oGrdGrupo = loc_oPg2.grd_4c_Grupos
1851:         WITH loc_oGrdGrupo
1852:             .Top                = 359
1853:             .Left               = 683
1854:             .Width              = 238
1855:             .Height             = 147
1856:             .FontName           = "Tahoma"
1857:             .FontSize           = 8
1858:             .ForeColor          = RGB(90, 90, 90)
1859:             .BackColor          = RGB(255, 255, 255)
1860:             .GridLineColor      = RGB(200, 200, 200)
1861:             .HighlightStyle     = 2
1862:             .DeleteMark         = .F.
1863:             .RecordMark         = .F.
1864:             .RowHeight          = 17
1865:             .ScrollBars         = 3

*-- Linhas 1891 a 2165:
1891:         ENDWITH
1892: 
1893:         loc_oGrdGrupo.Column1.CurrentControl = "chk_4c_check12"
1894: 
1895:         *-- Botoes Selecionar/Desmarcar Grupos (Top=378, Left=924, Width=45, Height=45)
1896:         loc_oPg2.AddObject("cmd_4c_Command1", "CommandButton")
1897:         WITH loc_oPg2.cmd_4c_Command1
1898:             .Caption         = ""
1899:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1900:             .PicturePosition = 13
1901:             .Top             = 378
1902:             .Left            = 924
1903:             .Width           = 45
1904:             .Height          = 45
1905:             .ToolTipText     = "Selecionar Todos"
1906:             .Themes          = .T.
1907:             .SpecialEffect   = 0
1908:             .Visible         = .T.
1909:         ENDWITH
1910: 
1911:         BINDEVENT(loc_oPg2.cmd_4c_Command1, "Click", THIS, "BtnSelecionarTodosGrupoClick")
1912: 
1913:         loc_oPg2.AddObject("cmd_4c_Command2", "CommandButton")
1914:         WITH loc_oPg2.cmd_4c_Command2
1915:             .Caption         = ""
1916:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1917:             .PicturePosition = 13
1918:             .Top             = 424
1919:             .Left            = 924
1920:             .Width           = 45
1921:             .Height          = 45
1922:             .ToolTipText     = "Desmarcar Todos"
1923:             .Themes          = .T.
1924:             .SpecialEffect   = 0
1925:             .Visible         = .T.
1926:         ENDWITH
1927: 
1928:         BINDEVENT(loc_oPg2.cmd_4c_Command2, "Click", THIS, "BtnDesmarcarTodosGrupoClick")
1929: 
1930:         THIS.TornarControlesVisiveis(loc_oPg2)
1931:     ENDPROC
1932: 
1933:     *--------------------------------------------------------------------------
1934:     * ConfigurarPaginaLeitura - Cria Page3: interface de leitura/escaneamento
1935:     *--------------------------------------------------------------------------
1936:     PROTECTED PROCEDURE ConfigurarPaginaLeitura()
1937:         LOCAL loc_oPg3, loc_oGrd
1938: 
1939:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
1940: 
1941:         *-- Container Encerrar (canonico: Top=29, Left=917)
1942:         loc_oPg3.AddObject("cnt_4c_Saida", "Container")
1943:         WITH loc_oPg3.cnt_4c_Saida
1944:             .Top         = 29
1945:             .Left        = 917
1946:             .Width       = 90
1947:             .Height      = 85
1948:             .BackStyle   = 0
1949:             .BorderWidth = 0
1950:             .Visible     = .T.
1951:         ENDWITH
1952: 
1953:         loc_oPg3.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
1954:         WITH loc_oPg3.cnt_4c_Saida.cmd_4c_Encerrar
1955:             .Caption         = "Encerrar"
1956:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1957:             .PicturePosition = 13
1958:             .Top             = 5
1959:             .Left            = 5
1960:             .Width           = 75
1961:             .Height          = 75
1962:             .BackColor       = RGB(255, 255, 255)
1963:             .ForeColor       = RGB(90, 90, 90)
1964:             .FontName        = "Tahoma"
1965:             .FontSize        = 8
1966:             .FontBold        = .T.
1967:             .FontItalic      = .T.
1968:             .Themes          = .F.
1969:             .SpecialEffect   = 0
1970:             .MousePointer    = 15
1971:             .WordWrap        = .T.
1972:             .AutoSize        = .F.
1973:             .Visible         = .T.
1974:         ENDWITH
1975: 
1976:         BINDEVENT(loc_oPg3.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
1977: 
1978:         *-- Botoes de acao leitura (Top=12+29=41): Gravar, Cancelar, TotalLocal, Ocorrencia, Imagem, LocalGravado
1979:         *-- Gravar (Left=828)
1980:         loc_oPg3.AddObject("cmd_4c_Confirmar", "CommandButton")
1981:         WITH loc_oPg3.cmd_4c_Confirmar
1982:             .Caption         = "Gravar"
1983:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1984:             .PicturePosition = 13
1985:             .Top             = 41
1986:             .Left            = 828
1987:             .Width           = 75
1988:             .Height          = 40
1989:             .BackColor       = RGB(255, 255, 255)
1990:             .ForeColor       = RGB(90, 90, 90)
1991:             .FontName        = "Tahoma"
1992:             .FontSize        = 8
1993:             .FontBold        = .T.
1994:             .Themes          = .F.
1995:             .SpecialEffect   = 0
1996:             .MousePointer    = 15
1997:             .Visible         = .T.
1998:         ENDWITH
1999: 
2000:         BINDEVENT(loc_oPg3.cmd_4c_Confirmar, "Click", THIS, "BtnGravarClick")
2001: 
2002:         *-- Cancelar (Left=903)
2003:         loc_oPg3.AddObject("cmd_4c_Cancela", "CommandButton")
2004:         WITH loc_oPg3.cmd_4c_Cancela
2005:             .Caption         = "Cancelar"
2006:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
2007:             .PicturePosition = 13
2008:             .Top             = 41
2009:             .Left            = 743
2010:             .Width           = 75
2011:             .Height          = 40
2012:             .BackColor       = RGB(255, 255, 255)
2013:             .ForeColor       = RGB(90, 90, 90)
2014:             .FontName        = "Tahoma"
2015:             .FontSize        = 8
2016:             .FontBold        = .T.
2017:             .Themes          = .F.
2018:             .SpecialEffect   = 0
2019:             .MousePointer    = 15
2020:             .Visible         = .T.
2021:         ENDWITH
2022: 
2023:         BINDEVENT(loc_oPg3.cmd_4c_Cancela, "Click", THIS, "BtnCancelaClick")
2024: 
2025:         *-- TotalLocal (Left=303)
2026:         loc_oPg3.AddObject("cmd_4c_TotalLocal", "CommandButton")
2027:         WITH loc_oPg3.cmd_4c_TotalLocal
2028:             .Caption       = "Total Local"
2029:             .Top           = 41
2030:             .Left          = 303
2031:             .Width         = 70
2032:             .Height        = 40
2033:             .FontName      = "Tahoma"
2034:             .FontSize      = 8
2035:             .Themes        = .F.
2036:             .SpecialEffect = 0
2037:             .Visible       = .T.
2038:         ENDWITH
2039: 
2040:         BINDEVENT(loc_oPg3.cmd_4c_TotalLocal, "Click", THIS, "BtnTotalLocalClick")
2041: 
2042:         *-- Ocorrencia (Left=378)
2043:         loc_oPg3.AddObject("cmd_4c_Ocorrencia", "CommandButton")
2044:         WITH loc_oPg3.cmd_4c_Ocorrencia
2045:             .Caption       = "Ocorr" + CHR(234) + "ncia"
2046:             .Top           = 41
2047:             .Left          = 378
2048:             .Width         = 70
2049:             .Height        = 40
2050:             .FontName      = "Tahoma"
2051:             .FontSize      = 8
2052:             .Themes        = .F.
2053:             .SpecialEffect = 0
2054:             .Visible       = .T.
2055:         ENDWITH
2056: 
2057:         BINDEVENT(loc_oPg3.cmd_4c_Ocorrencia, "Click", THIS, "BtnOcorrenciaClick")
2058: 
2059:         *-- Excluir item leitura (Left=453, visible=F inicialmente)
2060:         loc_oPg3.AddObject("cmd_4c_Excluir", "CommandButton")
2061:         WITH loc_oPg3.cmd_4c_Excluir
2062:             .Caption       = "Excluir"
2063:             .Top           = 41
2064:             .Left          = 453
2065:             .Width         = 70
2066:             .Height        = 40
2067:             .FontName      = "Tahoma"
2068:             .FontSize      = 8
2069:             .Themes        = .F.
2070:             .SpecialEffect = 0
2071:             .Visible       = .F.
2072:         ENDWITH
2073: 
2074:         BINDEVENT(loc_oPg3.cmd_4c_Excluir, "Click", THIS, "BtnExcluirLeituraClick")
2075: 
2076:         *-- Imagem (Left=528)
2077:         loc_oPg3.AddObject("cmd_4c_Imagem", "CommandButton")
2078:         WITH loc_oPg3.cmd_4c_Imagem
2079:             .Caption       = "Imagem"
2080:             .Top           = 41
2081:             .Left          = 528
2082:             .Width         = 70
2083:             .Height        = 40
2084:             .FontName      = "Tahoma"
2085:             .FontSize      = 8
2086:             .Themes        = .F.
2087:             .SpecialEffect = 0
2088:             .Visible       = .T.
2089:         ENDWITH
2090: 
2091:         BINDEVENT(loc_oPg3.cmd_4c_Imagem, "Click", THIS, "BtnImagemClick")
2092: 
2093:         *-- LocalGravado (Left=603)
2094:         loc_oPg3.AddObject("cmd_4c_LocalGravado", "CommandButton")
2095:         WITH loc_oPg3.cmd_4c_LocalGravado
2096:             .Caption       = "Local Gravado"
2097:             .Top           = 41
2098:             .Left          = 603
2099:             .Width         = 70
2100:             .Height        = 40
2101:             .FontName      = "Tahoma"
2102:             .FontSize      = 8
2103:             .Themes        = .F.
2104:             .SpecialEffect = 0
2105:             .Visible       = .T.
2106:         ENDWITH
2107: 
2108:         BINDEVENT(loc_oPg3.cmd_4c_LocalGravado, "Click", THIS, "BtnLocalGravadoClick")
2109: 
2110:         *-- BtnExcluir (Left=754, excluir registro selecionado na grade)
2111:         loc_oPg3.AddObject("cmd_4c_BtnExcluir", "CommandButton")
2112:         WITH loc_oPg3.cmd_4c_BtnExcluir
2113:             .Caption       = "Excluir"
2114:             .Top           = 41
2115:             .Left          = 754
2116:             .Width         = 60
2117:             .Height        = 40
2118:             .FontName      = "Tahoma"
2119:             .FontSize      = 8
2120:             .Themes        = .F.
2121:             .SpecialEffect = 0
2122:             .Visible       = .T.
2123:         ENDWITH
2124: 
2125:         BINDEVENT(loc_oPg3.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirLeituraClick")
2126: 
2127:         *-- PAINEL ESQUERDO: caixas de contexto (Codigo, Grupo, Estoque)
2128:         *-- Shape4 (fundo caixa Codigo): Top=137, Left=1, Width=92, Height=47
2129:         loc_oPg3.AddObject("shp_4c_Shape4", "Shape")
2130:         WITH loc_oPg3.shp_4c_Shape4
2131:             .Top         = 137
2132:             .Left        = 1
2133:             .Width       = 92
2134:             .Height      = 47
2135:             .BorderColor = RGB(0, 0, 0)
2136:             .BorderStyle = 1
2137:             .FillColor   = RGB(230, 230, 230)
2138:             .Visible     = .T.
2139:         ENDWITH
2140: 
2141:         *-- Say9: " Codigo " (Top=141, Left=20, Width=46)
2142:         loc_oPg3.AddObject("lbl_4c_Label9", "Label")
2143:         WITH loc_oPg3.lbl_4c_Label9
2144:             .Caption   = " C" + CHR(243) + "digo "
2145:             .Top       = 141
2146:             .Left      = 20
2147:             .Width     = 46
2148:             .AutoSize  = .F.
2149:             .FontName  = "Tahoma"
2150:             .FontSize  = 8
2151:             .ForeColor = RGB(0, 0, 0)
2152:             .BackStyle = 0
2153:             .Alignment = 2
2154:             .Visible   = .T.
2155:         ENDWITH
2156: 
2157:         *-- Get_Codigo leitura (Top=158, Left=6, Width=82, Height=20)
2158:         loc_oPg3.AddObject("txt_4c_Codigo", "TextBox")
2159:         WITH loc_oPg3.txt_4c_Codigo
2160:             .Value         = 0
2161:             .Top           = 158
2162:             .Left          = 6
2163:             .Width         = 82
2164:             .Height        = 20
2165:             .FontName      = "Tahoma"

*-- Linhas 2276 a 2320:
2276:             .Visible     = .T.
2277:         ENDWITH
2278: 
2279:         *-- TipoLeitura OptionGroup (Top=280, Left=-1, Width=80, ButtonCount=2)
2280:         loc_oPg3.AddObject("obj_4c_TipoLeitura", "OptionGroup")
2281:         WITH loc_oPg3.obj_4c_TipoLeitura
2282:             .Value       = 1
2283:             .ButtonCount = 2
2284:             .Top         = 280
2285:             .Left        = 0
2286:             .Width       = 80
2287:             .Height      = 42
2288:             .BackStyle   = 0
2289:             .BorderStyle = 0
2290:             .Visible     = .T.
2291:             WITH .Buttons(1)
2292:                 .Caption   = "Qtd"
2293:                 .Left      = 0
2294:                 .Top       = 0
2295:                 .Width     = 80
2296:                 .Height    = 21
2297:                 .AutoSize  = .F.
2298:                 .BackStyle = 0
2299:                 .ForeColor = RGB(0, 0, 0)
2300:                 .Themes    = .F.
2301:             ENDWITH
2302:             WITH .Buttons(2)
2303:                 .Caption   = "Cod.Barra"
2304:                 .Left      = 0
2305:                 .Top       = 21
2306:                 .Width     = 80
2307:                 .Height    = 21
2308:                 .AutoSize  = .F.
2309:                 .BackStyle = 0
2310:                 .ForeColor = RGB(0, 0, 0)
2311:                 .Themes    = .F.
2312:             ENDWITH
2313:         ENDWITH
2314: 
2315:         *-- GradeLeitura (Top=136, Left=98, Width=641, Height=293)
2316:         loc_oPg3.AddObject("grd_4c_Dados", "Grid")
2317:         loc_oPg3.grd_4c_Dados.RecordSource = ""
2318:         loc_oPg3.grd_4c_Dados.ColumnCount  = 8
2319: 
2320:         loc_oGrd = loc_oPg3.grd_4c_Dados

*-- Linhas 2478 a 2499:
2478:             .ForeColor = RGB(255, 255, 255)
2479:             .BackStyle = 0
2480:             .Visible   = .T.
2481:         ENDWITH
2482: 
2483:         loc_oPg3.AddObject("txt_4c_Estoque", "TextBox")
2484:         WITH loc_oPg3.txt_4c_Estoque
2485:             .Value     = ""
2486:             .Top       = 457
2487:             .Left      = 112
2488:             .Width     = 95
2489:             .Height    = 23
2490:             .FontName  = "Tahoma"
2491:             .FontSize  = 8
2492:             .BackColor = RGB(240, 240, 240)
2493:             .ReadOnly  = .T.
2494:             .Visible   = .T.
2495:         ENDWITH
2496: 
2497:         *-- Say1: "Local :" (Top=461, Left=253, Width=33)
2498:         loc_oPg3.AddObject("lbl_4c_Label1", "Label")
2499:         WITH loc_oPg3.lbl_4c_Label1

*-- Linhas 2977 a 3119:
2977:             .Visible       = .T.
2978:         ENDWITH
2979: 
2980:         THIS.TornarControlesVisiveis(loc_oPg3)
2981:     ENDPROC
2982: 
2983:     *--------------------------------------------------------------------------
2984:     * CarregarLista - Carrega inventarios da empresa no grid da Page1
2985:     *--------------------------------------------------------------------------
2986:     PROCEDURE CarregarLista()
2987:         LOCAL loc_lResultado, loc_oGrid
2988:         loc_lResultado = .F.
2989: 
2990:         TRY
2991:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2992:                 loc_lResultado = .T.
2993:             ENDIF
2994: 
2995:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2996: 
2997:             IF !THIS.this_oBusinessObject.Buscar("")
2998:                 loc_lResultado = .F.
2999:             ELSE
3000:                 loc_oGrid.ColumnCount = 8
3001:                 loc_oGrid.RecordSource              = "cursor_4c_Dados"
3002:                 loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.codigos"
3003:                 loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.dtbases"
3004:                 loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.datainis"
3005:                 loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.datafims"
3006:                 loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.encerras"
3007:                 loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.grupos"
3008:                 loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.contas"
3009:                 loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.usuars"
3010:                 loc_oGrid.Refresh()
3011:                 loc_lResultado = .T.
3012:             ENDIF
3013:         CATCH TO loc_oErro
3014:             MsgErro(loc_oErro.Message, "FormBAL.CarregarLista")
3015:         ENDTRY
3016: 
3017:         RETURN loc_lResultado
3018:     ENDPROC
3019: 
3020:     *--------------------------------------------------------------------------
3021:     * AlternarPagina - Alterna entre as paginas (1=Lista, 2=Dados, 3=Leitura)
3022:     *--------------------------------------------------------------------------
3023:     PROCEDURE AlternarPagina(par_nPagina)
3024:         TRY
3025:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
3026:         CATCH TO loc_oErro
3027:             MsgErro(loc_oErro.Message, "FormBAL.AlternarPagina")
3028:         ENDTRY
3029:     ENDPROC
3030: 
3031:     *--------------------------------------------------------------------------
3032:     * FormParaBO - Transfere campos da Page2 (Dados) para o BO
3033:     *--------------------------------------------------------------------------
3034:     PROCEDURE FormParaBO()
3035:         LOCAL loc_oPg2, loc_oBO
3036:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3037:         loc_oBO  = THIS.this_oBusinessObject
3038: 
3039:         TRY
3040:             WITH loc_oBO
3041:                 .this_dDtbases    = loc_oPg2.txt_4c_DBase.Value
3042:                 .this_cGrupos     = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
3043:                 .this_cContas     = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
3044:                 .this_dDatafims   = loc_oPg2.txt_4c_DataFinal.Value
3045:                 .this_dDatainis   = loc_oPg2.txt_4c_DataInicial.Value
3046:                 .this_cCprosi     = ALLTRIM(loc_oPg2.txt_4c_CProsI.Value)
3047:                 .this_cCprosf     = ALLTRIM(loc_oPg2.txt_4c_CProsF.Value)
3048:                 .this_cLocalis    = ALLTRIM(loc_oPg2.txt_4c_LocalInicial.Value)
3049:                 .this_cLocalfs    = ALLTRIM(loc_oPg2.txt_4c_LocalFinal.Value)
3050:                 .this_cIforis     = ALLTRIM(loc_oPg2.txt_4c_FornecInicial.Value)
3051:                 .this_cIforfs     = ALLTRIM(loc_oPg2.txt_4c_FornecFinal.Value)
3052:                 .this_cCggruis    = ALLTRIM(loc_oPg2.txt_4c_GGrupoInicial.Value)
3053:                 .this_cCggrufs    = ALLTRIM(loc_oPg2.txt_4c_GGrupoFinal.Value)
3054:                 .this_cCgruis     = ALLTRIM(loc_oPg2.txt_4c_GrupoInicial.Value)
3055:                 .this_cCgrufs     = ALLTRIM(loc_oPg2.txt_4c_GrupoFinal.Value)
3056:                 .this_cSgrusi     = ALLTRIM(loc_oPg2.txt_4c_SGrusI.Value)
3057:                 .this_cSgrusf     = ALLTRIM(loc_oPg2.txt_4c_SGrusF.Value)
3058:                 .this_nPrecois    = loc_oPg2.txt_4c_PrecoInicial.Value
3059:                 .this_nPrecofs    = loc_oPg2.txt_4c_PrecoFinal.Value
3060:                 .this_cColecoesi  = ALLTRIM(loc_oPg2.txt_4c_ColecoesI.Value)
3061:                 .this_cColecoesf  = ALLTRIM(loc_oPg2.txt_4c_ColecoesF.Value)
3062:                 .this_cCfinpsi    = ALLTRIM(loc_oPg2.txt_4c__UniIni.Value)
3063:                 .this_cCfinpsf    = ALLTRIM(loc_oPg2.txt_4c__UniFim.Value)
3064:                 .this_cObs        = ALLTRIM(loc_oPg2.obj_4c_GetObs.Value)
3065:                 .this_lTratas     = (loc_oPg2.chk_4c_Fwcheckbox2.Value = 1)
3066:                 .this_nSepestqs   = IIF(loc_oPg2.chk_4c_Fwcheckbox1.Value = 1, 1, 0)
3067:                 .this_nLeitgructa = IIF(loc_oPg2.chk_4c_Fwcheckbox3.Value = 1, 1, 0)
3068:                 .this_nAgrupas    = loc_oPg2.obj_4c_Opt_Agrupa.Value
3069:                 .this_nFilbarras  = loc_oPg2.obj_4c_OptFilBarra.Value - 1
3070:             ENDWITH
3071:         CATCH TO loc_oErro
3072:             MsgErro(loc_oErro.Message, "FormBAL.FormParaBO")
3073:         ENDTRY
3074:     ENDPROC
3075: 
3076:     *--------------------------------------------------------------------------
3077:     * BOParaForm - Transfere dados do BO para os campos da Page2 (Dados)
3078:     *--------------------------------------------------------------------------
3079:     PROCEDURE BOParaForm()
3080:         LOCAL loc_oPg2, loc_oBO
3081:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3082:         loc_oBO  = THIS.this_oBusinessObject
3083: 
3084:         TRY
3085:             WITH loc_oBO
3086:                 loc_oPg2.txt_4c_Codigo.Value          = .this_nCodigos
3087:                 loc_oPg2.txt_4c_DBase.Value           = .this_dDtbases
3088:                 loc_oPg2.txt_4c_Grupo.Value           = ALLTRIM(.this_cGrupos)
3089:                 loc_oPg2.txt_4c_Conta.Value           = ALLTRIM(.this_cContas)
3090:                 loc_oPg2.txt_4c_DataFinal.Value       = .this_dDatafims
3091:                 loc_oPg2.txt_4c_DataInicial.Value     = .this_dDatainis
3092:                 loc_oPg2.txt_4c_CProsI.Value          = ALLTRIM(.this_cCprosi)
3093:                 loc_oPg2.txt_4c_CProsF.Value          = ALLTRIM(.this_cCprosf)
3094:                 loc_oPg2.txt_4c_LocalInicial.Value    = ALLTRIM(.this_cLocalis)
3095:                 loc_oPg2.txt_4c_LocalFinal.Value      = ALLTRIM(.this_cLocalfs)
3096:                 loc_oPg2.txt_4c_FornecInicial.Value   = ALLTRIM(.this_cIforis)
3097:                 loc_oPg2.txt_4c_FornecFinal.Value     = ALLTRIM(.this_cIforfs)
3098:                 loc_oPg2.txt_4c_GGrupoInicial.Value   = ALLTRIM(.this_cCggruis)
3099:                 loc_oPg2.txt_4c_GGrupoFinal.Value     = ALLTRIM(.this_cCggrufs)
3100:                 loc_oPg2.txt_4c_GrupoInicial.Value    = ALLTRIM(.this_cCgruis)
3101:                 loc_oPg2.txt_4c_GrupoFinal.Value      = ALLTRIM(.this_cCgrufs)
3102:                 loc_oPg2.txt_4c_SGrusI.Value          = ALLTRIM(.this_cSgrusi)
3103:                 loc_oPg2.txt_4c_SGrusF.Value          = ALLTRIM(.this_cSgrusf)
3104:                 loc_oPg2.txt_4c_PrecoInicial.Value    = .this_nPrecois
3105:                 loc_oPg2.txt_4c_PrecoFinal.Value      = .this_nPrecofs
3106:                 loc_oPg2.txt_4c_Lin.Value             = ""
3107:                 loc_oPg2.txt_4c_Lin2.Value            = ""
3108:                 loc_oPg2.txt_4c__UniIni.Value         = ALLTRIM(.this_cCfinpsi)
3109:                 loc_oPg2.txt_4c__UniFim.Value         = ALLTRIM(.this_cCfinpsf)
3110:                 loc_oPg2.txt_4c_ColecoesI.Value       = ALLTRIM(.this_cColecoesi)
3111:                 loc_oPg2.txt_4c_ColecoesF.Value       = ALLTRIM(.this_cColecoesf)
3112:                 loc_oPg2.obj_4c_GetObs.Value          = ALLTRIM(.this_cObs)
3113:                 loc_oPg2.chk_4c_Fwcheckbox2.Value    = .this_lTratas
3114:                 loc_oPg2.chk_4c_Fwcheckbox1.Value    = IIF(.this_nSepestqs = 1, 1, 0)
3115:                 loc_oPg2.chk_4c_Fwcheckbox3.Value    = IIF(.this_nLeitgructa = 1, 1, 0)
3116:                 loc_oPg2.obj_4c_Opt_Agrupa.Value      = IIF(.this_nAgrupas > 0, .this_nAgrupas, 1)
3117:                 loc_oPg2.obj_4c_OptFilBarra.Value     = IIF(.this_nFilbarras >= 0, .this_nFilbarras + 1, 1)
3118:             ENDWITH
3119: 

*-- Linhas 3128 a 3225:
3128:     *--------------------------------------------------------------------------
3129:     * CarregarDescricaoGrupo - Preenche txt_4c_DGrupo com descricao do grupo
3130:     *--------------------------------------------------------------------------
3131:     PROTECTED PROCEDURE CarregarDescricaoGrupo()
3132:         LOCAL loc_cGrupo, loc_cSQL, loc_nRes, loc_cDesc
3133:         loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
3134:         loc_cDesc  = ""
3135: 
3136:         TRY
3137:             IF !EMPTY(loc_cGrupo)
3138:                 loc_cSQL = "SELECT TOP 1 descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
3139:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGrp")
3140:                 IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescGrp") > 0
3141:                     SELECT cursor_4c_DescGrp
3142:                     loc_cDesc = ALLTRIM(cursor_4c_DescGrp.descrs)
3143:                 ENDIF
3144:                 IF USED("cursor_4c_DescGrp")
3145:                     USE IN cursor_4c_DescGrp
3146:                 ENDIF
3147:             ENDIF
3148:         CATCH TO loc_oErro
3149:             MsgErro(loc_oErro.Message, "FormBAL.CarregarDescricaoGrupo")
3150:         ENDTRY
3151: 
3152:         THIS.pgf_4c_Paginas.Page2.txt_4c_DGrupo.Value = loc_cDesc
3153:     ENDPROC
3154: 
3155:     *--------------------------------------------------------------------------
3156:     * CarregarDescricaoConta - Preenche txt_4c_DConta com descricao da conta
3157:     *--------------------------------------------------------------------------
3158:     PROTECTED PROCEDURE CarregarDescricaoConta()
3159:         LOCAL loc_cConta, loc_cSQL, loc_nRes, loc_cDesc
3160:         loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value)
3161:         loc_cDesc  = ""
3162: 
3163:         TRY
3164:             IF !EMPTY(loc_cConta)
3165:                 loc_cSQL = "SELECT TOP 1 DNoms FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
3166:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCta")
3167:                 IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescCta") > 0
3168:                     SELECT cursor_4c_DescCta
3169:                     loc_cDesc = ALLTRIM(cursor_4c_DescCta.DNoms)
3170:                 ENDIF
3171:                 IF USED("cursor_4c_DescCta")
3172:                     USE IN cursor_4c_DescCta
3173:                 ENDIF
3174:             ENDIF
3175:         CATCH TO loc_oErro
3176:             MsgErro(loc_oErro.Message, "FormBAL.CarregarDescricaoConta")
3177:         ENDTRY
3178: 
3179:         THIS.pgf_4c_Paginas.Page2.txt_4c_DConta.Value = loc_cDesc
3180:     ENDPROC
3181: 
3182:     *--------------------------------------------------------------------------
3183:     * CarregarGrades - Carrega grdGGrupo (Grandes Grupos) e grd_4c_Grupos
3184:     *--------------------------------------------------------------------------
3185:     PROCEDURE CarregarGrades()
3186:         LOCAL loc_cSQL, loc_nRes, loc_cMfilggrp, loc_cMfilgrupo
3187:         loc_cMfilggrp  = ALLTRIM(THIS.this_oBusinessObject.this_cMfilggrp)
3188:         loc_cMfilgrupo = ALLTRIM(THIS.this_oBusinessObject.this_cMfilgrupo)
3189: 
3190:         TRY
3191:             *-- Carregar Grandes Grupos (SigCdGpr)
3192:             IF USED("cursor_4c_GGruposTemp")
3193:                 USE IN cursor_4c_GGruposTemp
3194:             ENDIF
3195: 
3196:             loc_cSQL = "SELECT 0 AS nMarcas, codigos AS GGrupos, descs AS Descricaos" + ;
3197:                        " FROM SigCdGpr ORDER BY codigos"
3198:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GGruposTemp")
3199: 
3200:             IF loc_nRes >= 0
3201:                 *-- Restaurar marcacoes salvas (formato: "cod1,cod2,cod3")
3202:                 IF !EMPTY(loc_cMfilggrp)
3203:                     SELECT cursor_4c_GGruposTemp
3204:                     SCAN
3205:                         IF "," + ALLTRIM(cursor_4c_GGruposTemp.GGrupos) + "," $ "," + loc_cMfilggrp + ","
3206:                             REPLACE nMarcas WITH 1 IN cursor_4c_GGruposTemp
3207:                         ENDIF
3208:                         SELECT cursor_4c_GGruposTemp
3209:                     ENDSCAN
3210:                 ENDIF
3211: 
3212:                 IF USED("cursor_4c_GGrupos")
3213:                     SELECT cursor_4c_GGrupos
3214:                     ZAP
3215:                     APPEND FROM DBF("cursor_4c_GGruposTemp")
3216:                     GO TOP
3217:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3218:                 ELSE
3219:                     SELECT * FROM cursor_4c_GGruposTemp INTO CURSOR cursor_4c_GGrupos READWRITE
3220:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.ColumnCount = 3
3221:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.RecordSource              = "cursor_4c_GGrupos"
3222:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column1.ControlSource     = "cursor_4c_GGrupos.nMarcas"
3223:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column2.ControlSource     = "cursor_4c_GGrupos.GGrupos"
3224:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column3.ControlSource     = "cursor_4c_GGrupos.Descricaos"
3225:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column1.Header1.Caption   = ""

*-- Linhas 3285 a 3376:
3285:     *--------------------------------------------------------------------------
3286:     * ObterMfilGGrupo - Gera string CSV de grandes grupos marcados
3287:     *--------------------------------------------------------------------------
3288:     PROTECTED PROCEDURE ObterMfilGGrupo()
3289:         LOCAL loc_cLista
3290:         loc_cLista = ""
3291: 
3292:         TRY
3293:             IF USED("cursor_4c_GGrupos")
3294:                 SELECT cursor_4c_GGrupos
3295:                 SCAN
3296:                     IF cursor_4c_GGrupos.nMarcas = 1
3297:                         loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ALLTRIM(cursor_4c_GGrupos.GGrupos)
3298:                     ENDIF
3299:                     SELECT cursor_4c_GGrupos
3300:                 ENDSCAN
3301:             ENDIF
3302:         CATCH TO loc_oErro
3303:             MsgErro(loc_oErro.Message, "FormBAL.ObterMfilGGrupo")
3304:         ENDTRY
3305: 
3306:         RETURN loc_cLista
3307:     ENDPROC
3308: 
3309:     *--------------------------------------------------------------------------
3310:     * ObterMfilGrupo - Gera string CSV de grupos produto marcados
3311:     *--------------------------------------------------------------------------
3312:     PROTECTED PROCEDURE ObterMfilGrupo()
3313:         LOCAL loc_cLista
3314:         loc_cLista = ""
3315: 
3316:         TRY
3317:             IF USED("cursor_4c_GruposProd")
3318:                 SELECT cursor_4c_GruposProd
3319:                 SCAN
3320:                     IF cursor_4c_GruposProd.nMarcas = 1
3321:                         loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ALLTRIM(cursor_4c_GruposProd.Codigos)
3322:                     ENDIF
3323:                     SELECT cursor_4c_GruposProd
3324:                 ENDSCAN
3325:             ENDIF
3326:         CATCH TO loc_oErro
3327:             MsgErro(loc_oErro.Message, "FormBAL.ObterMfilGrupo")
3328:         ENDTRY
3329: 
3330:         RETURN loc_cLista
3331:     ENDPROC
3332: 
3333:     *--------------------------------------------------------------------------
3334:     * CarregarGradeLeitura - Carrega historico de leituras do inventario
3335:     *--------------------------------------------------------------------------
3336:     PROCEDURE CarregarGradeLeitura()
3337:         LOCAL loc_cSQL, loc_nRes, loc_nCodigos, loc_cEmps, loc_oGrd
3338:         loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
3339:         loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
3340:         loc_oGrd     = THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3341: 
3342:         TRY
3343:             IF USED("cursor_4c_HistoricoTemp")
3344:                 USE IN cursor_4c_HistoricoTemp
3345:             ENDIF
3346: 
3347:             loc_cSQL = "SELECT a.cbars, a.cpros, a.lidos AS Qtds, a.localis, a.codcors," + ;
3348:                        " a.codtams, a.lidos2 AS Qtds2, ISNULL(b.cbars_old, 0) AS BarsOld" + ;
3349:                        " FROM SigIvTrH a" + ;
3350:                        " LEFT JOIN SigOpEta b ON a.cbars = b.cbars_new" + ;
3351:                        " WHERE a.emps = " + EscaparSQL(loc_cEmps) + ;
3352:                        " AND a.codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
3353:                        " ORDER BY a.cidchaves"
3354: 
3355:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
3356: 
3357:             IF loc_nRes >= 0
3358:                 IF USED("cursor_4c_Historico")
3359:                     SELECT cursor_4c_Historico
3360:                     ZAP
3361:                     APPEND FROM DBF("cursor_4c_HistoricoTemp")
3362:                     GO TOP
3363:                     loc_oGrd.Refresh()
3364:                 ELSE
3365:                     SELECT * FROM cursor_4c_HistoricoTemp INTO CURSOR cursor_4c_Historico READWRITE
3366:                     loc_oGrd.ColumnCount = 8
3367:                     loc_oGrd.RecordSource          = "cursor_4c_Historico"
3368:                     loc_oGrd.Column1.ControlSource = "cursor_4c_Historico.cbars"
3369:                     loc_oGrd.Column2.ControlSource = "cursor_4c_Historico.cpros"
3370:                     loc_oGrd.Column3.ControlSource = "cursor_4c_Historico.Qtds"
3371:                     loc_oGrd.Column4.ControlSource = "cursor_4c_Historico.localis"
3372:                     loc_oGrd.Column5.ControlSource = "cursor_4c_Historico.codcors"
3373:                     loc_oGrd.Column6.ControlSource = "cursor_4c_Historico.codtams"
3374:                     loc_oGrd.Column7.ControlSource = "cursor_4c_Historico.Qtds2"
3375:                     loc_oGrd.Column8.ControlSource = "cursor_4c_Historico.BarsOld"
3376:                     loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"

*-- Linhas 3400 a 3580:
3400:     *--------------------------------------------------------------------------
3401:     * AtualizarTotalLeitura - Atualiza contadores de lidos e quantidade
3402:     *--------------------------------------------------------------------------
3403:     PROCEDURE AtualizarTotalLeitura()
3404:         LOCAL loc_nLidos, loc_nQtde, loc_cSQL, loc_nRes
3405: 
3406:         TRY
3407:             IF USED("cursor_4c_Historico")
3408:                 SELECT COUNT(*) AS Lidos, SUM(Qtds) AS Qtde FROM cursor_4c_Historico ;
3409:                     INTO CURSOR cursor_4c_Totais READWRITE
3410: 
3411:                 IF USED("cursor_4c_Totais")
3412:                     SELECT cursor_4c_Totais
3413:                     loc_nLidos = IIF(ISNULL(cursor_4c_Totais.Lidos), 0, cursor_4c_Totais.Lidos)
3414:                     loc_nQtde  = IIF(ISNULL(cursor_4c_Totais.Qtde),  0, cursor_4c_Totais.Qtde)
3415:                     USE IN cursor_4c_Totais
3416:                 ENDIF
3417: 
3418:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Lidos.Value = loc_nLidos
3419:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Qtde.Value  = loc_nQtde
3420:             ENDIF
3421:         CATCH TO loc_oErro
3422:             MsgErro(loc_oErro.Message, "FormBAL.AtualizarTotalLeitura")
3423:         ENDTRY
3424:     ENDPROC
3425: 
3426:     *--------------------------------------------------------------------------
3427:     * InicializarLeitura - Configura Page3 para o inventario selecionado
3428:     *--------------------------------------------------------------------------
3429:     PROTECTED PROCEDURE InicializarLeitura()
3430:         LOCAL loc_oPg3, loc_oBO
3431:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
3432:         loc_oBO  = THIS.this_oBusinessObject
3433: 
3434:         TRY
3435:             loc_oPg3.txt_4c_Codigo.Value = loc_oBO.this_nCodigos
3436:             loc_oPg3.txt_4c_Grupo.Value  = ALLTRIM(loc_oBO.this_cGrupos)
3437:             loc_oPg3.txt_4c_Conta.Value  = ALLTRIM(loc_oBO.this_cContas)
3438: 
3439:             THIS.LimparCamposLeitura()
3440:             THIS.CarregarGradeLeitura()
3441:         CATCH TO loc_oErro
3442:             MsgErro(loc_oErro.Message, "FormBAL.InicializarLeitura")
3443:         ENDTRY
3444:     ENDPROC
3445: 
3446:     *--------------------------------------------------------------------------
3447:     * LimparCamposLeitura - Limpa campos de entrada da leitura
3448:     *--------------------------------------------------------------------------
3449:     PROTECTED PROCEDURE LimparCamposLeitura()
3450:         LOCAL loc_oPg3
3451:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
3452: 
3453:         TRY
3454:             loc_oPg3.txt_4c_Prod.Value   = ""
3455:             loc_oPg3.txt_4c_Descr.Value  = ""
3456:             loc_oPg3.txt_4c_Cor.Value    = ""
3457:             loc_oPg3.txt_4c_Tam.Value    = ""
3458:             loc_oPg3.txt_4c_Qtd.Value    = 0
3459:             loc_oPg3.txt_4c_Qtd2.Value   = 0
3460:             loc_oPg3.txt_4c_Local.Value  = ""
3461:             loc_oPg3.txt_4c_Total.Value  = 0
3462:             loc_oPg3.txt_4c_Ocorr.Value  = ""
3463:             loc_oPg3.txt_4c_PReal.Value  = 0
3464:             loc_oPg3.txt_4c_Linha.Value  = ""
3465:             loc_oPg3.txt_4c_Reffs.Value  = ""
3466:             loc_oPg3.txt_4c_CodCor.Value = ""
3467:             loc_oPg3.txt_4c_Ultima.Value = ""
3468:             IF !loc_oPg3.chk_4c_Chk_RepeteObs.Value
3469:                 loc_oPg3.obj_4c_Get_Obs.Value = ""
3470:             ENDIF
3471:         CATCH TO loc_oErro
3472:             MsgErro(loc_oErro.Message, "FormBAL.LimparCamposLeitura")
3473:         ENDTRY
3474:     ENDPROC
3475: 
3476:     *--------------------------------------------------------------------------
3477:     * ObterCidchavesSelecionado - Retorna cidchaves do registro selecionado no grid
3478:     *--------------------------------------------------------------------------
3479:     PROTECTED PROCEDURE ObterCidchavesSelecionado()
3480:         LOCAL loc_cCidchaves
3481:         loc_cCidchaves = ""
3482: 
3483:         TRY
3484:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
3485:                 SELECT cursor_4c_Dados
3486:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
3487:             ENDIF
3488:         CATCH TO loc_oErro
3489:             MsgErro(loc_oErro.Message, "FormBAL.ObterCidchavesSelecionado")
3490:         ENDTRY
3491: 
3492:         RETURN loc_cCidchaves
3493:     ENDPROC
3494: 
3495:     *--------------------------------------------------------------------------
3496:     * HabilitarCamposDados - Habilita/desabilita campos da Page2
3497:     *--------------------------------------------------------------------------
3498:     PROTECTED PROCEDURE HabilitarCamposDados(par_lHabilitar)
3499:         LOCAL loc_oPg2
3500:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3501: 
3502:         TRY
3503:             loc_oPg2.txt_4c_DBase.ReadOnly         = !par_lHabilitar
3504:             loc_oPg2.txt_4c_Grupo.ReadOnly          = !par_lHabilitar
3505:             loc_oPg2.txt_4c_Conta.ReadOnly          = !par_lHabilitar
3506:             loc_oPg2.txt_4c_DataFinal.ReadOnly      = !par_lHabilitar
3507:             loc_oPg2.txt_4c_DataInicial.ReadOnly    = !par_lHabilitar
3508:             loc_oPg2.txt_4c_CProsI.ReadOnly         = !par_lHabilitar
3509:             loc_oPg2.txt_4c_CProsF.ReadOnly         = !par_lHabilitar
3510:             loc_oPg2.txt_4c_LocalInicial.ReadOnly   = !par_lHabilitar
3511:             loc_oPg2.txt_4c_LocalFinal.ReadOnly     = !par_lHabilitar
3512:             loc_oPg2.txt_4c_FornecInicial.ReadOnly  = !par_lHabilitar
3513:             loc_oPg2.txt_4c_FornecFinal.ReadOnly    = !par_lHabilitar
3514:             loc_oPg2.txt_4c_GGrupoInicial.ReadOnly  = !par_lHabilitar
3515:             loc_oPg2.txt_4c_GGrupoFinal.ReadOnly    = !par_lHabilitar
3516:             loc_oPg2.txt_4c_GrupoInicial.ReadOnly   = !par_lHabilitar
3517:             loc_oPg2.txt_4c_GrupoFinal.ReadOnly     = !par_lHabilitar
3518:             loc_oPg2.txt_4c_SGrusI.ReadOnly         = !par_lHabilitar
3519:             loc_oPg2.txt_4c_SGrusF.ReadOnly         = !par_lHabilitar
3520:             loc_oPg2.txt_4c_PrecoInicial.ReadOnly   = !par_lHabilitar
3521:             loc_oPg2.txt_4c_PrecoFinal.ReadOnly     = !par_lHabilitar
3522:             loc_oPg2.txt_4c_Lin.ReadOnly            = !par_lHabilitar
3523:             loc_oPg2.txt_4c_Lin2.ReadOnly           = !par_lHabilitar
3524:             loc_oPg2.txt_4c_ColecoesI.ReadOnly      = !par_lHabilitar
3525:             loc_oPg2.txt_4c_ColecoesF.ReadOnly      = !par_lHabilitar
3526:             loc_oPg2.txt_4c__UniIni.ReadOnly        = !par_lHabilitar
3527:             loc_oPg2.txt_4c__UniFim.ReadOnly        = !par_lHabilitar
3528:             loc_oPg2.txt_4c_ObsPes.ReadOnly         = !par_lHabilitar
3529:             loc_oPg2.obj_4c_GetObs.ReadOnly         = !par_lHabilitar
3530:             loc_oPg2.grd_4c_GGrupo.ReadOnly         = !par_lHabilitar
3531:             loc_oPg2.grd_4c_Grupos.ReadOnly         = !par_lHabilitar
3532:         CATCH TO loc_oErro
3533:             MsgErro(loc_oErro.Message, "FormBAL.HabilitarCamposDados")
3534:         ENDTRY
3535:     ENDPROC
3536: 
3537:     *--------------------------------------------------------------------------
3538:     * LimparCamposDados - Limpa campos da Page2
3539:     *--------------------------------------------------------------------------
3540:     PROCEDURE LimparCamposDados()
3541:         LOCAL loc_oPg2
3542:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3543: 
3544:         TRY
3545:             loc_oPg2.txt_4c_Codigo.Value          = 0
3546:             loc_oPg2.txt_4c_DBase.Value           = {}
3547:             loc_oPg2.txt_4c_Grupo.Value           = ""
3548:             loc_oPg2.txt_4c_DGrupo.Value          = ""
3549:             loc_oPg2.txt_4c_Conta.Value           = ""
3550:             loc_oPg2.txt_4c_DConta.Value          = ""
3551:             loc_oPg2.txt_4c_DataFinal.Value       = {}
3552:             loc_oPg2.txt_4c_DataInicial.Value     = {}
3553:             loc_oPg2.txt_4c_CProsI.Value          = ""
3554:             loc_oPg2.txt_4c_CProsF.Value          = ""
3555:             loc_oPg2.txt_4c_LocalInicial.Value    = ""
3556:             loc_oPg2.txt_4c_LocalFinal.Value      = ""
3557:             loc_oPg2.txt_4c_FornecInicial.Value   = ""
3558:             loc_oPg2.txt_4c_FornecFinal.Value     = ""
3559:             loc_oPg2.txt_4c_GGrupoInicial.Value   = ""
3560:             loc_oPg2.txt_4c_GGrupoFinal.Value     = ""
3561:             loc_oPg2.txt_4c_GrupoInicial.Value    = ""
3562:             loc_oPg2.txt_4c_GrupoFinal.Value      = ""
3563:             loc_oPg2.txt_4c_SGrusI.Value          = ""
3564:             loc_oPg2.txt_4c_SGrusF.Value          = ""
3565:             loc_oPg2.txt_4c_PrecoInicial.Value    = 0
3566:             loc_oPg2.txt_4c_PrecoFinal.Value      = 0
3567:             loc_oPg2.txt_4c_Lin.Value             = ""
3568:             loc_oPg2.txt_4c_Lin2.Value            = ""
3569:             loc_oPg2.txt_4c_ColecoesI.Value       = ""
3570:             loc_oPg2.txt_4c_ColecoesF.Value       = ""
3571:             loc_oPg2.txt_4c__UniIni.Value         = ""
3572:             loc_oPg2.txt_4c__UniFim.Value         = ""
3573:             loc_oPg2.txt_4c_ObsPes.Value          = ""
3574:             loc_oPg2.obj_4c_GetObs.Value          = ""
3575:             loc_oPg2.chk_4c_Fwcheckbox1.Value    = 0
3576:             loc_oPg2.chk_4c_Fwcheckbox2.Value    = 0
3577:             loc_oPg2.chk_4c_Fwcheckbox3.Value    = 0
3578:             loc_oPg2.obj_4c_Opt_Agrupa.Value      = 1
3579:             loc_oPg2.obj_4c_OptFilBarra.Value     = 1
3580:         CATCH TO loc_oErro

*-- Linhas 3589 a 3995:
3589:     *--------------------------------------------------------------------------
3590:     * BtnProcessoClick - Cria novo inventario (Incluir)
3591:     *--------------------------------------------------------------------------
3592:     PROCEDURE BtnProcessoClick()
3593:         TRY
3594:             THIS.this_oBusinessObject.this_lNovoRegistro = .T.
3595:             THIS.LimparCamposDados()
3596:             THIS.HabilitarCamposDados(.T.)
3597:             THIS.CarregarGrades()
3598:             THIS.this_cModoAtual = "INCLUIR"
3599:             THIS.AlternarPagina(2)
3600:             THIS.pgf_4c_Paginas.Page2.txt_4c_DBase.SetFocus()
3601:         CATCH TO loc_oErro
3602:             MsgErro(loc_oErro.Message, "FormBAL.BtnProcessoClick")
3603:         ENDTRY
3604:     ENDPROC
3605: 
3606:     *--------------------------------------------------------------------------
3607:     * BtnFechaClick - Encerra inventario selecionado
3608:     *--------------------------------------------------------------------------
3609:     PROCEDURE BtnFechaClick()
3610:         LOCAL loc_cCidchaves, loc_lConfirma
3611: 
3612:         TRY
3613:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
3614:             IF EMPTY(loc_cCidchaves)
3615:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para encerrar.", "Aten" + CHR(231) + CHR(227) + "o")
3616:                 RETURN
3617:             ENDIF
3618: 
3619:             IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
3620:                 MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
3621:                 RETURN
3622:             ENDIF
3623: 
3624:             IF THIS.this_oBusinessObject.this_lEncerras
3625:                 MsgAviso("Invent" + CHR(225) + "rio j" + CHR(225) + " est" + CHR(225) + " encerrado.", "Aten" + CHR(231) + CHR(227) + "o")
3626:                 RETURN
3627:             ENDIF
3628: 
3629:             loc_lConfirma = MsgConfirma("Deseja encerrar o Invent" + CHR(225) + "rio " + ;
3630:                             TRANSFORM(THIS.this_oBusinessObject.this_nCodigos) + "?", ;
3631:                             "Confirmar Encerramento")
3632: 
3633:             IF loc_lConfirma
3634:                 IF THIS.this_oBusinessObject.AtualizarEncerramento(.T., DATE())
3635:                     MsgInfo("Invent" + CHR(225) + "rio encerrado com sucesso!", "Sucesso")
3636:                     THIS.CarregarLista()
3637:                 ENDIF
3638:             ENDIF
3639:         CATCH TO loc_oErro
3640:             MsgErro(loc_oErro.Message, "FormBAL.BtnFechaClick")
3641:         ENDTRY
3642:     ENDPROC
3643: 
3644:     *--------------------------------------------------------------------------
3645:     * BtnLeituraClick - Abre pagina de leitura para inventario selecionado
3646:     *--------------------------------------------------------------------------
3647:     PROCEDURE BtnLeituraClick()
3648:         LOCAL loc_cCidchaves
3649: 
3650:         TRY
3651:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
3652:             IF EMPTY(loc_cCidchaves)
3653:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para iniciar a leitura.", "Aten" + CHR(231) + CHR(227) + "o")
3654:                 RETURN
3655:             ENDIF
3656: 
3657:             IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
3658:                 MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
3659:                 RETURN
3660:             ENDIF
3661: 
3662:             IF THIS.this_oBusinessObject.this_lEncerras
3663:                 MsgAviso("Invent" + CHR(225) + "rio encerrado. N" + CHR(227) + "o " + ;
3664:                          CHR(233) + " poss" + CHR(237) + "vel realizar leituras.", "Aten" + CHR(231) + CHR(227) + "o")
3665:                 RETURN
3666:             ENDIF
3667: 
3668:             THIS.this_cModoAtual = "LEITURA"
3669:             THIS.InicializarLeitura()
3670:             THIS.AlternarPagina(3)
3671:         CATCH TO loc_oErro
3672:             MsgErro(loc_oErro.Message, "FormBAL.BtnLeituraClick")
3673:         ENDTRY
3674:     ENDPROC
3675: 
3676:     *--------------------------------------------------------------------------
3677:     * BtnConsultaClick - Recarrega lista / aplica filtro
3678:     *--------------------------------------------------------------------------
3679:     PROCEDURE BtnConsultaClick()
3680:         TRY
3681:             THIS.CarregarLista()
3682:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
3683:         CATCH TO loc_oErro
3684:             MsgErro(loc_oErro.Message, "FormBAL.BtnConsultaClick")
3685:         ENDTRY
3686:     ENDPROC
3687: 
3688:     *--------------------------------------------------------------------------
3689:     * BtnExportaClick - Exporta dados do inventario para Excel
3690:     *--------------------------------------------------------------------------
3691:     PROCEDURE BtnExportaClick()
3692:         LOCAL loc_cCidchaves, loc_cArquivo
3693: 
3694:         TRY
3695:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
3696:             IF EMPTY(loc_cCidchaves)
3697:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para exportar.", "Aten" + CHR(231) + CHR(227) + "o")
3698:                 RETURN
3699:             ENDIF
3700: 
3701:             IF !USED("cursor_4c_Dados")
3702:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para exportar.", "Aten" + CHR(231) + CHR(227) + "o")
3703:                 RETURN
3704:             ENDIF
3705: 
3706:             loc_cArquivo = GETFILE("XLS", "Exportar Invent" + CHR(225) + "rio", "Salvar", 0, "Exportar")
3707:             IF !EMPTY(loc_cArquivo)
3708:                 COPY TO (loc_cArquivo) TYPE XL5
3709:                 MsgInfo("Arquivo exportado com sucesso!", "Exportar")
3710:             ENDIF
3711:         CATCH TO loc_oErro
3712:             MsgErro(loc_oErro.Message, "FormBAL.BtnExportaClick")
3713:         ENDTRY
3714:     ENDPROC
3715: 
3716:     *--------------------------------------------------------------------------
3717:     * BtnInventarioClick - Imprime etiquetas do inventario selecionado
3718:     *--------------------------------------------------------------------------
3719:     PROCEDURE BtnInventarioClick()
3720:         LOCAL loc_cCidchaves
3721: 
3722:         TRY
3723:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
3724:             IF EMPTY(loc_cCidchaves)
3725:                 MsgAviso("Selecione um invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
3726:                 RETURN
3727:             ENDIF
3728: 
3729:             MsgInfo("Fun" + CHR(231) + CHR(227) + "o de etiquetas em desenvolvimento.", "Informa" + CHR(231) + CHR(227) + "o")
3730:         CATCH TO loc_oErro
3731:             MsgErro(loc_oErro.Message, "FormBAL.BtnInventarioClick")
3732:         ENDTRY
3733:     ENDPROC
3734: 
3735:     *--------------------------------------------------------------------------
3736:     * BtnEncerrarClick - Fecha o formulario
3737:     *--------------------------------------------------------------------------
3738:     PROCEDURE BtnEncerrarClick()
3739:         TRY
3740:             THIS.Release()
3741:         CATCH TO loc_oErro
3742:             MsgErro(loc_oErro.Message, "FormBAL.BtnEncerrarClick")
3743:         ENDTRY
3744:     ENDPROC
3745: 
3746:     *-- Handlers de ordenacao na lista
3747:     PROCEDURE BtnOrdenarPeriodoClick()
3748:         TRY
3749:             IF USED("cursor_4c_Dados")
3750:                 SELECT cursor_4c_Dados
3751:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
3752:             ENDIF
3753:         CATCH TO loc_oErro
3754:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarPeriodoClick")
3755:         ENDTRY
3756:     ENDPROC
3757: 
3758:     PROCEDURE BtnOrdenarEstoqueClick()
3759:         TRY
3760:             THIS.CarregarLista()
3761:         CATCH TO loc_oErro
3762:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarEstoqueClick")
3763:         ENDTRY
3764:     ENDPROC
3765: 
3766:     PROCEDURE BtnOrdenarLocalClick()
3767:         TRY
3768:             THIS.CarregarLista()
3769:         CATCH TO loc_oErro
3770:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarLocalClick")
3771:         ENDTRY
3772:     ENDPROC
3773: 
3774:     PROCEDURE BtnOrdenarGrupoClick()
3775:         TRY
3776:             THIS.CarregarLista()
3777:         CATCH TO loc_oErro
3778:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarGrupoClick")
3779:         ENDTRY
3780:     ENDPROC
3781: 
3782:     PROCEDURE BtnOrdenarGGrupoClick()
3783:         TRY
3784:             THIS.CarregarLista()
3785:         CATCH TO loc_oErro
3786:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarGGrupoClick")
3787:         ENDTRY
3788:     ENDPROC
3789: 
3790:     PROCEDURE BtnOrdenarUsuarioClick()
3791:         TRY
3792:             THIS.CarregarLista()
3793:         CATCH TO loc_oErro
3794:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarUsuarioClick")
3795:         ENDTRY
3796:     ENDPROC
3797: 
3798:     *==========================================================================
3799:     * HANDLERS - Page2 (Dados)
3800:     *==========================================================================
3801: 
3802:     *--------------------------------------------------------------------------
3803:     * BtnConfirmarClick - Salva parametros do inventario
3804:     *--------------------------------------------------------------------------
3805:     PROCEDURE BtnConfirmarClick()
3806:         LOCAL loc_lResultado, loc_cGrupos, loc_cContas
3807: 
3808:         TRY
3809:             loc_cGrupos = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
3810: 
3811:             *-- Validar grupo de estoque (obrigatorio)
3812:             IF EMPTY(loc_cGrupos)
3813:                 MsgAviso("Grupo de Estoque obrigat" + CHR(243) + "rio.", "Valida" + CHR(231) + CHR(227) + "o")
3814:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
3815:                 RETURN
3816:             ENDIF
3817: 
3818:             IF !THIS.this_oBusinessObject.ValidarGrupoEstoque(loc_cGrupos)
3819:                 MsgAviso("Grupo de Estoque Inv" + CHR(225) + "lido!!!", "Valida" + CHR(231) + CHR(227) + "o")
3820:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
3821:                 RETURN
3822:             ENDIF
3823: 
3824:             *-- Validar conta (opcional mas se preenchida deve ser valida)
3825:             loc_cContas = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value)
3826:             IF !EMPTY(loc_cContas) AND !THIS.this_oBusinessObject.ValidarConta(loc_cContas)
3827:                 MsgAviso("Conta de Estoque Inv" + CHR(225) + "lida!!!", "Valida" + CHR(231) + CHR(227) + "o")
3828:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.SetFocus()
3829:                 RETURN
3830:             ENDIF
3831: 
3832:             *-- Transferir campos para BO
3833:             THIS.FormParaBO()
3834: 
3835:             *-- Salvar XML das grades de grupos
3836:             THIS.this_oBusinessObject.this_cMfilggrp  = THIS.ObterMfilGGrupo()
3837:             THIS.this_oBusinessObject.this_cMfilgrupo = THIS.ObterMfilGrupo()
3838: 
3839:             *-- Salvar registro
3840:             loc_lResultado = THIS.this_oBusinessObject.Salvar()
3841: 
3842:             IF loc_lResultado
3843:                 MsgInfo("Invent" + CHR(225) + "rio salvo com sucesso!", "Sucesso")
3844:                 THIS.this_cModoAtual = "LISTA"
3845:                 THIS.CarregarLista()
3846:                 THIS.AlternarPagina(1)
3847:             ENDIF
3848:         CATCH TO loc_oErro
3849:             MsgErro(loc_oErro.Message, "FormBAL.BtnConfirmarClick")
3850:         ENDTRY
3851:     ENDPROC
3852: 
3853:     *--------------------------------------------------------------------------
3854:     * BtnCancelarClick - Cancela edicao e volta para lista
3855:     *--------------------------------------------------------------------------
3856:     PROCEDURE BtnCancelarClick()
3857:         TRY
3858:             THIS.this_cModoAtual = "LISTA"
3859:             THIS.AlternarPagina(1)
3860:         CATCH TO loc_oErro
3861:             MsgErro(loc_oErro.Message, "FormBAL.BtnCancelarClick")
3862:         ENDTRY
3863:     ENDPROC
3864: 
3865:     *--------------------------------------------------------------------------
3866:     * BtnSelecionarTodosGGrupoClick - Marca todos os grandes grupos
3867:     *--------------------------------------------------------------------------
3868:     PROCEDURE BtnSelecionarTodosGGrupoClick()
3869:         TRY
3870:             IF USED("cursor_4c_GGrupos")
3871:                 SELECT cursor_4c_GGrupos
3872:                 REPLACE ALL nMarcas WITH 1
3873:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3874:             ENDIF
3875:         CATCH TO loc_oErro
3876:             MsgErro(loc_oErro.Message, "FormBAL.BtnSelecionarTodosGGrupoClick")
3877:         ENDTRY
3878:     ENDPROC
3879: 
3880:     *--------------------------------------------------------------------------
3881:     * BtnDesmarcarTodosGGrupoClick - Desmarca todos os grandes grupos
3882:     *--------------------------------------------------------------------------
3883:     PROCEDURE BtnDesmarcarTodosGGrupoClick()
3884:         TRY
3885:             IF USED("cursor_4c_GGrupos")
3886:                 SELECT cursor_4c_GGrupos
3887:                 REPLACE ALL nMarcas WITH 0
3888:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3889:             ENDIF
3890:         CATCH TO loc_oErro
3891:             MsgErro(loc_oErro.Message, "FormBAL.BtnDesmarcarTodosGGrupoClick")
3892:         ENDTRY
3893:     ENDPROC
3894: 
3895:     *--------------------------------------------------------------------------
3896:     * BtnSelecionarTodosGrupoClick - Marca todos os grupos de produto
3897:     *--------------------------------------------------------------------------
3898:     PROCEDURE BtnSelecionarTodosGrupoClick()
3899:         TRY
3900:             IF USED("cursor_4c_GruposProd")
3901:                 SELECT cursor_4c_GruposProd
3902:                 REPLACE ALL nMarcas WITH 1
3903:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3904:             ENDIF
3905:         CATCH TO loc_oErro
3906:             MsgErro(loc_oErro.Message, "FormBAL.BtnSelecionarTodosGrupoClick")
3907:         ENDTRY
3908:     ENDPROC
3909: 
3910:     *--------------------------------------------------------------------------
3911:     * BtnDesmarcarTodosGrupoClick - Desmarca todos os grupos de produto
3912:     *--------------------------------------------------------------------------
3913:     PROCEDURE BtnDesmarcarTodosGrupoClick()
3914:         TRY
3915:             IF USED("cursor_4c_GruposProd")
3916:                 SELECT cursor_4c_GruposProd
3917:                 REPLACE ALL nMarcas WITH 0
3918:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3919:             ENDIF
3920:         CATCH TO loc_oErro
3921:             MsgErro(loc_oErro.Message, "FormBAL.BtnDesmarcarTodosGrupoClick")
3922:         ENDTRY
3923:     ENDPROC
3924: 
3925:     *==========================================================================
3926:     * HANDLERS - Page3 (Leitura)
3927:     *==========================================================================
3928: 
3929:     *--------------------------------------------------------------------------
3930:     * BtnGravarClick - Salva item de leitura em SigIvTrH
3931:     *--------------------------------------------------------------------------
3932:     PROCEDURE BtnGravarClick()
3933:         LOCAL loc_cSQL, loc_nRes, loc_lSucesso
3934:         LOCAL loc_cProd, loc_cCodCor, loc_cCodTam, loc_nQtd, loc_nQtd2
3935:         LOCAL loc_cLocal, loc_cObs, loc_nLidos, loc_cEmps, loc_nCodigos
3936:         loc_lSucesso = .F.
3937: 
3938:         TRY
3939:             loc_cProd    = ALLTRIM(THIS.pgf_4c_Paginas.Page3.txt_4c_Prod.Value)
3940:             loc_cCodCor  = ALLTRIM(THIS.pgf_4c_Paginas.Page3.txt_4c_Cor.Value)
3941:             loc_cCodTam  = ALLTRIM(THIS.pgf_4c_Paginas.Page3.txt_4c_Tam.Value)
3942:             loc_nQtd     = THIS.pgf_4c_Paginas.Page3.txt_4c_Qtd.Value
3943:             loc_nQtd2    = THIS.pgf_4c_Paginas.Page3.txt_4c_Qtd2.Value
3944:             loc_cLocal   = ALLTRIM(THIS.pgf_4c_Paginas.Page3.txt_4c_Local.Value)
3945:             loc_cObs     = ALLTRIM(THIS.pgf_4c_Paginas.Page3.obj_4c_Get_Obs.Value)
3946:             loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
3947:             loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
3948: 
3949:             IF EMPTY(loc_cProd)
3950:                 MsgAviso("Produto n" + CHR(227) + "o informado.", "Aten" + CHR(231) + CHR(227) + "o")
3951:                 RETURN
3952:             ENDIF
3953: 
3954:             IF loc_nQtd <= 0
3955:                 MsgAviso("Quantidade deve ser maior que zero.", "Aten" + CHR(231) + CHR(227) + "o")
3956:                 RETURN
3957:             ENDIF
3958: 
3959:             *-- Gerar UUID para cidchaves da leitura
3960:             LOCAL loc_cCidchaves, loc_nResUuid
3961:             loc_cCidchaves = ""
3962:             loc_nResUuid = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_UuidH")
3963:             IF loc_nResUuid >= 0 AND RECCOUNT("cursor_4c_UuidH") > 0
3964:                 SELECT cursor_4c_UuidH
3965:                 loc_cCidchaves = ALLTRIM(cursor_4c_UuidH.novo_uuid)
3966:             ENDIF
3967:             IF USED("cursor_4c_UuidH")
3968:                 USE IN cursor_4c_UuidH
3969:             ENDIF
3970: 
3971:             IF EMPTY(loc_cCidchaves)
3972:                 MsgErro("Erro ao gerar chave " + CHR(250) + "nica para leitura.", "Erro")
3973:                 RETURN
3974:             ENDIF
3975: 
3976:             *-- Obter cbars do produto (codigo de barras)
3977:             LOCAL loc_cCbars, loc_nResCb
3978:             loc_cCbars = ""
3979:             loc_nResCb = SQLEXEC(gnConnHandle, "SELECT TOP 1 cbars FROM SigCdPro WHERE cpros = " + ;
3980:                          EscaparSQL(loc_cProd), "cursor_4c_CBars")
3981:             IF loc_nResCb >= 0 AND RECCOUNT("cursor_4c_CBars") > 0
3982:                 SELECT cursor_4c_CBars
3983:                 loc_cCbars = ALLTRIM(cursor_4c_CBars.cbars)
3984:             ENDIF
3985:             IF USED("cursor_4c_CBars")
3986:                 USE IN cursor_4c_CBars
3987:             ENDIF
3988: 
3989:             loc_cSQL = "INSERT INTO SigIvTrH (cidchaves, emps, codigos, cbars, cpros," + ;
3990:                        " codcors, codtams, lidos, lidos2, localis, obs)" + ;
3991:                        " VALUES (" + ;
3992:                        EscaparSQL(loc_cCidchaves) + "," + ;
3993:                        EscaparSQL(loc_cEmps) + "," + ;
3994:                        FormatarNumeroSQL(loc_nCodigos) + "," + ;
3995:                        EscaparSQL(loc_cCbars) + "," + ;

*-- Linhas 4018 a 4878:
4018:     *--------------------------------------------------------------------------
4019:     * BtnCancelaClick - Cancela leitura e volta para lista
4020:     *--------------------------------------------------------------------------
4021:     PROCEDURE BtnCancelaClick()
4022:         TRY
4023:             THIS.this_cModoAtual = "LISTA"
4024:             THIS.CarregarLista()
4025:             THIS.AlternarPagina(1)
4026:         CATCH TO loc_oErro
4027:             MsgErro(loc_oErro.Message, "FormBAL.BtnCancelaClick")
4028:         ENDTRY
4029:     ENDPROC
4030: 
4031:     *--------------------------------------------------------------------------
4032:     * BtnTotalLocalClick - Mostra totais por local de armazenamento
4033:     *--------------------------------------------------------------------------
4034:     PROCEDURE BtnTotalLocalClick()
4035:         LOCAL loc_cSQL, loc_nRes, loc_nCodigos, loc_cEmps
4036: 
4037:         TRY
4038:             loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
4039:             loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
4040: 
4041:             IF USED("cursor_4c_TotalLocal")
4042:                 USE IN cursor_4c_TotalLocal
4043:             ENDIF
4044: 
4045:             loc_cSQL = "SELECT localis AS Local, COUNT(*) AS Qtde_Itens, SUM(lidos) AS Total_Qtd" + ;
4046:                        " FROM SigIvTrH" + ;
4047:                        " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
4048:                        " AND codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
4049:                        " GROUP BY localis ORDER BY localis"
4050: 
4051:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TotalLocal")
4052:             IF loc_nRes >= 0
4053:                 MsgInfo("Consulta de totais por local conclu" + CHR(237) + "da.", "Total Local")
4054:             ELSE
4055:                 MsgErro("Erro ao calcular totais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4056:             ENDIF
4057:         CATCH TO loc_oErro
4058:             MsgErro(loc_oErro.Message, "FormBAL.BtnTotalLocalClick")
4059:         ENDTRY
4060:     ENDPROC
4061: 
4062:     *--------------------------------------------------------------------------
4063:     * BtnOcorrenciaClick - Registra ocorrencia
4064:     *--------------------------------------------------------------------------
4065:     PROCEDURE BtnOcorrenciaClick()
4066:         TRY
4067:             MsgInfo("Fun" + CHR(231) + CHR(227) + "o de Ocorr" + CHR(234) + "ncia em desenvolvimento.", "Informa" + CHR(231) + CHR(227) + "o")
4068:         CATCH TO loc_oErro
4069:             MsgErro(loc_oErro.Message, "FormBAL.BtnOcorrenciaClick")
4070:         ENDTRY
4071:     ENDPROC
4072: 
4073:     *--------------------------------------------------------------------------
4074:     * BtnImagemClick - Exibe imagem do produto selecionado
4075:     *--------------------------------------------------------------------------
4076:     PROCEDURE BtnImagemClick()
4077:         LOCAL loc_cProd, loc_cSQL, loc_nRes, loc_cImagem, loc_oPg3
4078:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
4079: 
4080:         TRY
4081:             loc_cProd = ALLTRIM(loc_oPg3.txt_4c_Prod.Value)
4082:             IF EMPTY(loc_cProd)
4083:                 RETURN
4084:             ENDIF
4085: 
4086:             loc_cSQL = "SELECT TOP 1 imagem FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cProd)
4087:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImgProd")
4088:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ImgProd") > 0
4089:                 SELECT cursor_4c_ImgProd
4090:                 loc_cImagem = ALLTRIM(cursor_4c_ImgProd.imagem)
4091:                 IF !EMPTY(loc_cImagem) AND FILE(loc_cImagem)
4092:                     loc_oPg3.img_4c_ImgJpg.Picture = loc_cImagem
4093:                     loc_oPg3.img_4c_ImgJpg.Visible = .T.
4094:                 ELSE
4095:                     loc_oPg3.img_4c_ImgJpg.Visible = .F.
4096:                 ENDIF
4097:             ENDIF
4098:             IF USED("cursor_4c_ImgProd")
4099:                 USE IN cursor_4c_ImgProd
4100:             ENDIF
4101:         CATCH TO loc_oErro
4102:             MsgErro(loc_oErro.Message, "FormBAL.BtnImagemClick")
4103:         ENDTRY
4104:     ENDPROC
4105: 
4106:     *--------------------------------------------------------------------------
4107:     * BtnLocalGravadoClick - Exibe ultimo local gravado
4108:     *--------------------------------------------------------------------------
4109:     PROCEDURE BtnLocalGravadoClick()
4110:         LOCAL loc_cSQL, loc_nRes, loc_cEmps, loc_nCodigos
4111: 
4112:         TRY
4113:             loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
4114:             loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
4115: 
4116:             loc_cSQL = "SELECT TOP 1 localis FROM SigIvTrH" + ;
4117:                        " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
4118:                        " AND codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
4119:                        " ORDER BY cidchaves DESC"
4120: 
4121:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltLocal")
4122:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_UltLocal") > 0
4123:                 SELECT cursor_4c_UltLocal
4124:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Local.Value = ALLTRIM(cursor_4c_UltLocal.localis)
4125:             ENDIF
4126:             IF USED("cursor_4c_UltLocal")
4127:                 USE IN cursor_4c_UltLocal
4128:             ENDIF
4129:         CATCH TO loc_oErro
4130:             MsgErro(loc_oErro.Message, "FormBAL.BtnLocalGravadoClick")
4131:         ENDTRY
4132:     ENDPROC
4133: 
4134:     *--------------------------------------------------------------------------
4135:     * BtnExcluirLeituraClick - Exclui registro de leitura selecionado na grade
4136:     *--------------------------------------------------------------------------
4137:     PROCEDURE BtnExcluirLeituraClick()
4138:         LOCAL loc_cCidchaves, loc_cSQL, loc_nRes, loc_lConfirma
4139: 
4140:         TRY
4141:             IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
4142:                 MsgAviso("Selecione uma leitura para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
4143:                 RETURN
4144:             ENDIF
4145: 
4146:             SELECT cursor_4c_Historico
4147:             loc_cCidchaves = ALLTRIM(cursor_4c_Historico.cbars)
4148: 
4149:             loc_lConfirma = MsgConfirma("Deseja excluir esta leitura?", "Confirmar Exclus" + CHR(227) + "o")
4150: 
4151:             IF loc_lConfirma
4152:                 loc_cSQL = "DELETE FROM SigIvTrH WHERE cbars = " + EscaparSQL(loc_cCidchaves) + ;
4153:                            " AND emps = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cEmps)) + ;
4154:                            " AND codigos = " + FormatarNumeroSQL(THIS.this_oBusinessObject.this_nCodigos)
4155: 
4156:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
4157:                 IF loc_nRes >= 0
4158:                     THIS.CarregarGradeLeitura()
4159:                 ELSE
4160:                     MsgErro("Erro ao excluir leitura:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4161:                 ENDIF
4162:             ENDIF
4163:         CATCH TO loc_oErro
4164:             MsgErro(loc_oErro.Message, "FormBAL.BtnExcluirLeituraClick")
4165:         ENDTRY
4166:     ENDPROC
4167: 
4168:     *==========================================================================
4169:     * HANDLERS DE LOOKUP (KeyPress F4)
4170:     *==========================================================================
4171: 
4172:     PROCEDURE KeyPressGrupo(par_nKeyCode, par_nShiftAltCtrl)
4173:         LOCAL loc_oForm, loc_cValor
4174: 
4175:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4176:             TRY
4177:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4178:                     "SigCdGcr", "Codigos", "descrs", "Grupo de Estoque", ;
4179:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
4180:                 IF VARTYPE(loc_oForm) = "O"
4181:                     loc_oForm.Show()
4182:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4183:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4184:                         THIS.CarregarDescricaoGrupo()
4185:                     ENDIF
4186:                 ENDIF
4187:             CATCH TO loc_oErro
4188:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressGrupo")
4189:             ENDTRY
4190:             par_nKeyCode = 0
4191:         ENDIF
4192: 
4193:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4194:             KEYBOARD CHR(9)
4195:         ENDIF
4196:     ENDPROC
4197: 
4198:     PROCEDURE KeyPressConta(par_nKeyCode, par_nShiftAltCtrl)
4199:         LOCAL loc_oForm
4200: 
4201:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4202:             TRY
4203:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4204:                     "SigCdCli", "IClis", "DNoms", "Conta de Estoque", ;
4205:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value)
4206:                 IF VARTYPE(loc_oForm) = "O"
4207:                     loc_oForm.Show()
4208:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4209:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4210:                         THIS.CarregarDescricaoConta()
4211:                     ENDIF
4212:                 ENDIF
4213:             CATCH TO loc_oErro
4214:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressConta")
4215:             ENDTRY
4216:             par_nKeyCode = 0
4217:         ENDIF
4218: 
4219:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4220:             KEYBOARD CHR(9)
4221:         ENDIF
4222:     ENDPROC
4223: 
4224:     PROCEDURE KeyPressCProsI(par_nKeyCode, par_nShiftAltCtrl)
4225:         LOCAL loc_oForm
4226: 
4227:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4228:             TRY
4229:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4230:                     "SigCdPro", "cpros", "dpros", "Produto Inicial", ;
4231:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_CProsI.Value)
4232:                 IF VARTYPE(loc_oForm) = "O"
4233:                     loc_oForm.Show()
4234:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4235:                         THIS.pgf_4c_Paginas.Page2.txt_4c_CProsI.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4236:                     ENDIF
4237:                 ENDIF
4238:             CATCH TO loc_oErro
4239:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressCProsI")
4240:             ENDTRY
4241:             par_nKeyCode = 0
4242:         ENDIF
4243: 
4244:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4245:             KEYBOARD CHR(9)
4246:         ENDIF
4247:     ENDPROC
4248: 
4249:     PROCEDURE KeyPressCProsF(par_nKeyCode, par_nShiftAltCtrl)
4250:         LOCAL loc_oForm
4251: 
4252:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4253:             TRY
4254:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4255:                     "SigCdPro", "cpros", "dpros", "Produto Final", ;
4256:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_CProsF.Value)
4257:                 IF VARTYPE(loc_oForm) = "O"
4258:                     loc_oForm.Show()
4259:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4260:                         THIS.pgf_4c_Paginas.Page2.txt_4c_CProsF.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4261:                     ENDIF
4262:                 ENDIF
4263:             CATCH TO loc_oErro
4264:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressCProsF")
4265:             ENDTRY
4266:             par_nKeyCode = 0
4267:         ENDIF
4268: 
4269:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4270:             KEYBOARD CHR(9)
4271:         ENDIF
4272:     ENDPROC
4273: 
4274:     PROCEDURE KeyPressLocalInicial(par_nKeyCode, par_nShiftAltCtrl)
4275:         LOCAL loc_oForm
4276: 
4277:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4278:             TRY
4279:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4280:                     "SigPrLcl", "codigos", "descs", "Local Inicial", ;
4281:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_LocalInicial.Value)
4282:                 IF VARTYPE(loc_oForm) = "O"
4283:                     loc_oForm.Show()
4284:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4285:                         THIS.pgf_4c_Paginas.Page2.txt_4c_LocalInicial.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4286:                     ENDIF
4287:                 ENDIF
4288:             CATCH TO loc_oErro
4289:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressLocalInicial")
4290:             ENDTRY
4291:             par_nKeyCode = 0
4292:         ENDIF
4293: 
4294:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4295:             KEYBOARD CHR(9)
4296:         ENDIF
4297:     ENDPROC
4298: 
4299:     PROCEDURE KeyPressLocalFinal(par_nKeyCode, par_nShiftAltCtrl)
4300:         LOCAL loc_oForm
4301: 
4302:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4303:             TRY
4304:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4305:                     "SigPrLcl", "codigos", "descs", "Local Final", ;
4306:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_LocalFinal.Value)
4307:                 IF VARTYPE(loc_oForm) = "O"
4308:                     loc_oForm.Show()
4309:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4310:                         THIS.pgf_4c_Paginas.Page2.txt_4c_LocalFinal.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4311:                     ENDIF
4312:                 ENDIF
4313:             CATCH TO loc_oErro
4314:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressLocalFinal")
4315:             ENDTRY
4316:             par_nKeyCode = 0
4317:         ENDIF
4318: 
4319:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4320:             KEYBOARD CHR(9)
4321:         ENDIF
4322:     ENDPROC
4323: 
4324:     PROCEDURE KeyPressGGrupoInicial(par_nKeyCode, par_nShiftAltCtrl)
4325:         LOCAL loc_oForm
4326: 
4327:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4328:             TRY
4329:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4330:                     "SigCdGpr", "codigos", "descs", "Grande Grupo Inicial", ;
4331:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_GGrupoInicial.Value)
4332:                 IF VARTYPE(loc_oForm) = "O"
4333:                     loc_oForm.Show()
4334:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4335:                         THIS.pgf_4c_Paginas.Page2.txt_4c_GGrupoInicial.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4336:                     ENDIF
4337:                 ENDIF
4338:             CATCH TO loc_oErro
4339:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressGGrupoInicial")
4340:             ENDTRY
4341:             par_nKeyCode = 0
4342:         ENDIF
4343: 
4344:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4345:             KEYBOARD CHR(9)
4346:         ENDIF
4347:     ENDPROC
4348: 
4349:     PROCEDURE KeyPressGGrupoFinal(par_nKeyCode, par_nShiftAltCtrl)
4350:         LOCAL loc_oForm
4351: 
4352:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4353:             TRY
4354:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4355:                     "SigCdGpr", "codigos", "descs", "Grande Grupo Final", ;
4356:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_GGrupoFinal.Value)
4357:                 IF VARTYPE(loc_oForm) = "O"
4358:                     loc_oForm.Show()
4359:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4360:                         THIS.pgf_4c_Paginas.Page2.txt_4c_GGrupoFinal.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4361:                     ENDIF
4362:                 ENDIF
4363:             CATCH TO loc_oErro
4364:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressGGrupoFinal")
4365:             ENDTRY
4366:             par_nKeyCode = 0
4367:         ENDIF
4368: 
4369:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4370:             KEYBOARD CHR(9)
4371:         ENDIF
4372:     ENDPROC
4373: 
4374:     PROCEDURE KeyPressGrupoInicial(par_nKeyCode, par_nShiftAltCtrl)
4375:         LOCAL loc_oForm
4376: 
4377:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4378:             TRY
4379:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4380:                     "SigCdGrp", "cgrus", "descs", "Grupo Inicial", ;
4381:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoInicial.Value)
4382:                 IF VARTYPE(loc_oForm) = "O"
4383:                     loc_oForm.Show()
4384:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4385:                         THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoInicial.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4386:                     ENDIF
4387:                 ENDIF
4388:             CATCH TO loc_oErro
4389:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressGrupoInicial")
4390:             ENDTRY
4391:             par_nKeyCode = 0
4392:         ENDIF
4393: 
4394:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4395:             KEYBOARD CHR(9)
4396:         ENDIF
4397:     ENDPROC
4398: 
4399:     PROCEDURE KeyPressGrupoFinal(par_nKeyCode, par_nShiftAltCtrl)
4400:         LOCAL loc_oForm
4401: 
4402:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4403:             TRY
4404:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4405:                     "SigCdGrp", "cgrus", "descs", "Grupo Final", ;
4406:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoFinal.Value)
4407:                 IF VARTYPE(loc_oForm) = "O"
4408:                     loc_oForm.Show()
4409:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4410:                         THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoFinal.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4411:                     ENDIF
4412:                 ENDIF
4413:             CATCH TO loc_oErro
4414:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressGrupoFinal")
4415:             ENDTRY
4416:             par_nKeyCode = 0
4417:         ENDIF
4418: 
4419:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4420:             KEYBOARD CHR(9)
4421:         ENDIF
4422:     ENDPROC
4423: 
4424:     PROCEDURE KeyPressLin(par_nKeyCode, par_nShiftAltCtrl)
4425:         LOCAL loc_oForm
4426: 
4427:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4428:             TRY
4429:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4430:                     "SigCdLin", "Linhas", "descs", "Linha Inicial", ;
4431:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_Lin.Value)
4432:                 IF VARTYPE(loc_oForm) = "O"
4433:                     loc_oForm.Show()
4434:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4435:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Lin.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4436:                     ENDIF
4437:                 ENDIF
4438:             CATCH TO loc_oErro
4439:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressLin")
4440:             ENDTRY
4441:             par_nKeyCode = 0
4442:         ENDIF
4443: 
4444:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4445:             KEYBOARD CHR(9)
4446:         ENDIF
4447:     ENDPROC
4448: 
4449:     PROCEDURE KeyPressLin2(par_nKeyCode, par_nShiftAltCtrl)
4450:         LOCAL loc_oForm
4451: 
4452:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4453:             TRY
4454:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4455:                     "SigCdLin", "Linhas", "descs", "Linha Final", ;
4456:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_Lin2.Value)
4457:                 IF VARTYPE(loc_oForm) = "O"
4458:                     loc_oForm.Show()
4459:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4460:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Lin2.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4461:                     ENDIF
4462:                 ENDIF
4463:             CATCH TO loc_oErro
4464:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressLin2")
4465:             ENDTRY
4466:             par_nKeyCode = 0
4467:         ENDIF
4468: 
4469:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4470:             KEYBOARD CHR(9)
4471:         ENDIF
4472:     ENDPROC
4473: 
4474:     PROCEDURE KeyPressUniIni(par_nKeyCode, par_nShiftAltCtrl)
4475:         LOCAL loc_oForm
4476: 
4477:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4478:             TRY
4479:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4480:                     "SigCdUni", "Cunis", "descs", "Unidade Inicial", ;
4481:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c__UniIni.Value)
4482:                 IF VARTYPE(loc_oForm) = "O"
4483:                     loc_oForm.Show()
4484:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4485:                         THIS.pgf_4c_Paginas.Page2.txt_4c__UniIni.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4486:                     ENDIF
4487:                 ENDIF
4488:             CATCH TO loc_oErro
4489:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressUniIni")
4490:             ENDTRY
4491:             par_nKeyCode = 0
4492:         ENDIF
4493: 
4494:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4495:             KEYBOARD CHR(9)
4496:         ENDIF
4497:     ENDPROC
4498: 
4499:     PROCEDURE KeyPressUniFim(par_nKeyCode, par_nShiftAltCtrl)
4500:         LOCAL loc_oForm
4501: 
4502:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4503:             TRY
4504:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4505:                     "SigCdUni", "Cunis", "descs", "Unidade Final", ;
4506:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c__UniFim.Value)
4507:                 IF VARTYPE(loc_oForm) = "O"
4508:                     loc_oForm.Show()
4509:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4510:                         THIS.pgf_4c_Paginas.Page2.txt_4c__UniFim.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4511:                     ENDIF
4512:                 ENDIF
4513:             CATCH TO loc_oErro
4514:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressUniFim")
4515:             ENDTRY
4516:             par_nKeyCode = 0
4517:         ENDIF
4518: 
4519:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4520:             KEYBOARD CHR(9)
4521:         ENDIF
4522:     ENDPROC
4523: 
4524:     PROCEDURE KeyPressFornecInicial(par_nKeyCode, par_nShiftAltCtrl)
4525:         LOCAL loc_oForm
4526: 
4527:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4528:             TRY
4529:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4530:                     "SigCdCli", "Iclis", "Rclis", "Fornecedor Inicial", ;
4531:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_FornecInicial.Value)
4532:                 IF VARTYPE(loc_oForm) = "O"
4533:                     loc_oForm.Show()
4534:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4535:                         THIS.pgf_4c_Paginas.Page2.txt_4c_FornecInicial.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4536:                     ENDIF
4537:                 ENDIF
4538:             CATCH TO loc_oErro
4539:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressFornecInicial")
4540:             ENDTRY
4541:             par_nKeyCode = 0
4542:         ENDIF
4543: 
4544:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4545:             KEYBOARD CHR(9)
4546:         ENDIF
4547:     ENDPROC
4548: 
4549:     PROCEDURE KeyPressFornecFinal(par_nKeyCode, par_nShiftAltCtrl)
4550:         LOCAL loc_oForm
4551: 
4552:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4553:             TRY
4554:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4555:                     "SigCdCli", "Iclis", "Rclis", "Fornecedor Final", ;
4556:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_FornecFinal.Value)
4557:                 IF VARTYPE(loc_oForm) = "O"
4558:                     loc_oForm.Show()
4559:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4560:                         THIS.pgf_4c_Paginas.Page2.txt_4c_FornecFinal.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4561:                     ENDIF
4562:                 ENDIF
4563:             CATCH TO loc_oErro
4564:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressFornecFinal")
4565:             ENDTRY
4566:             par_nKeyCode = 0
4567:         ENDIF
4568: 
4569:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4570:             KEYBOARD CHR(9)
4571:         ENDIF
4572:     ENDPROC
4573: 
4574:     PROCEDURE KeyPressSGrusI(par_nKeyCode, par_nShiftAltCtrl)
4575:         LOCAL loc_oForm
4576: 
4577:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4578:             TRY
4579:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4580:                     "SigCdPsg", "Codigos", "Descricaos", "Sub-Grupo Inicial", ;
4581:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_SGrusI.Value)
4582:                 IF VARTYPE(loc_oForm) = "O"
4583:                     loc_oForm.Show()
4584:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4585:                         THIS.pgf_4c_Paginas.Page2.txt_4c_SGrusI.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4586:                     ENDIF
4587:                 ENDIF
4588:             CATCH TO loc_oErro
4589:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressSGrusI")
4590:             ENDTRY
4591:             par_nKeyCode = 0
4592:         ENDIF
4593: 
4594:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4595:             KEYBOARD CHR(9)
4596:         ENDIF
4597:     ENDPROC
4598: 
4599:     PROCEDURE KeyPressSGrusF(par_nKeyCode, par_nShiftAltCtrl)
4600:         LOCAL loc_oForm
4601: 
4602:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4603:             TRY
4604:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4605:                     "SigCdPsg", "Codigos", "Descricaos", "Sub-Grupo Final", ;
4606:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_SGrusF.Value)
4607:                 IF VARTYPE(loc_oForm) = "O"
4608:                     loc_oForm.Show()
4609:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4610:                         THIS.pgf_4c_Paginas.Page2.txt_4c_SGrusF.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4611:                     ENDIF
4612:                 ENDIF
4613:             CATCH TO loc_oErro
4614:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressSGrusF")
4615:             ENDTRY
4616:             par_nKeyCode = 0
4617:         ENDIF
4618: 
4619:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4620:             KEYBOARD CHR(9)
4621:         ENDIF
4622:     ENDPROC
4623: 
4624:     PROCEDURE KeyPressColecoesI(par_nKeyCode, par_nShiftAltCtrl)
4625:         LOCAL loc_oForm
4626: 
4627:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4628:             TRY
4629:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4630:                     "SigCdCol", "Colecoes", "Descs", "Cole" + CHR(231) + CHR(227) + "o Inicial", ;
4631:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_ColecoesI.Value)
4632:                 IF VARTYPE(loc_oForm) = "O"
4633:                     loc_oForm.Show()
4634:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4635:                         THIS.pgf_4c_Paginas.Page2.txt_4c_ColecoesI.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4636:                     ENDIF
4637:                 ENDIF
4638:             CATCH TO loc_oErro
4639:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressColecoesI")
4640:             ENDTRY
4641:             par_nKeyCode = 0
4642:         ENDIF
4643: 
4644:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4645:             KEYBOARD CHR(9)
4646:         ENDIF
4647:     ENDPROC
4648: 
4649:     PROCEDURE KeyPressColecoesF(par_nKeyCode, par_nShiftAltCtrl)
4650:         LOCAL loc_oForm
4651: 
4652:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4653:             TRY
4654:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4655:                     "SigCdCol", "Colecoes", "Descs", "Cole" + CHR(231) + CHR(227) + "o Final", ;
4656:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_ColecoesF.Value)
4657:                 IF VARTYPE(loc_oForm) = "O"
4658:                     loc_oForm.Show()
4659:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4660:                         THIS.pgf_4c_Paginas.Page2.txt_4c_ColecoesF.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4661:                     ENDIF
4662:                 ENDIF
4663:             CATCH TO loc_oErro
4664:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressColecoesF")
4665:             ENDTRY
4666:             par_nKeyCode = 0
4667:         ENDIF
4668: 
4669:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4670:             KEYBOARD CHR(9)
4671:         ENDIF
4672:     ENDPROC
4673: 
4674:     *--------------------------------------------------------------------------
4675:     * BtnIncluirClick - Cria novo inventario
4676:     *--------------------------------------------------------------------------
4677:     PROCEDURE BtnIncluirClick()
4678:         TRY
4679:             THIS.this_oBusinessObject.this_lNovoRegistro = .T.
4680:             THIS.LimparCamposDados()
4681:             THIS.HabilitarCamposDados(.T.)
4682:             THIS.CarregarGrades()
4683:             THIS.this_cModoAtual = "INCLUIR"
4684:             THIS.AlternarPagina(2)
4685:             THIS.pgf_4c_Paginas.Page2.txt_4c_DBase.SetFocus()
4686:         CATCH TO loc_oErro
4687:             MsgErro(loc_oErro.Message, "FormBAL.BtnIncluirClick")
4688:         ENDTRY
4689:     ENDPROC
4690: 
4691:     *--------------------------------------------------------------------------
4692:     * BtnAlterarClick - Abre inventario selecionado para edicao
4693:     *--------------------------------------------------------------------------
4694:     PROCEDURE BtnAlterarClick()
4695:         LOCAL loc_cCidchaves
4696:         TRY
4697:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
4698:             IF EMPTY(loc_cCidchaves)
4699:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
4700:             ELSE
4701:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
4702:                     MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
4703:                 ELSE
4704:                     THIS.this_oBusinessObject.this_lNovoRegistro = .F.
4705:                     THIS.BOParaForm()
4706:                     THIS.CarregarGrades()
4707:                     THIS.HabilitarCamposDados(.T.)
4708:                     THIS.this_cModoAtual = "ALTERAR"
4709:                     THIS.AlternarPagina(2)
4710:                 ENDIF
4711:             ENDIF
4712:         CATCH TO loc_oErro
4713:             MsgErro(loc_oErro.Message, "FormBAL.BtnAlterarClick")
4714:         ENDTRY
4715:     ENDPROC
4716: 
4717:     *--------------------------------------------------------------------------
4718:     * BtnVisualizarClick - Abre inventario selecionado em modo leitura
4719:     *--------------------------------------------------------------------------
4720:     PROCEDURE BtnVisualizarClick()
4721:         LOCAL loc_cCidchaves
4722:         TRY
4723:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
4724:             IF EMPTY(loc_cCidchaves)
4725:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
4726:             ELSE
4727:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
4728:                     MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
4729:                 ELSE
4730:                     THIS.BOParaForm()
4731:                     THIS.CarregarGrades()
4732:                     THIS.HabilitarCamposDados(.F.)
4733:                     THIS.this_cModoAtual = "VISUALIZAR"
4734:                     THIS.AlternarPagina(2)
4735:                 ENDIF
4736:             ENDIF
4737:         CATCH TO loc_oErro
4738:             MsgErro(loc_oErro.Message, "FormBAL.BtnVisualizarClick")
4739:         ENDTRY
4740:     ENDPROC
4741: 
4742:     *--------------------------------------------------------------------------
4743:     * BtnExcluirClick - Exclui inventario selecionado
4744:     *--------------------------------------------------------------------------
4745:     PROCEDURE BtnExcluirClick()
4746:         LOCAL loc_cCidchaves, loc_lConfirma
4747:         TRY
4748:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
4749:             IF EMPTY(loc_cCidchaves)
4750:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
4751:             ELSE
4752:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
4753:                     MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
4754:                 ELSE
4755:                     loc_lConfirma = MsgConfirma("Deseja excluir o Invent" + CHR(225) + "rio " + ;
4756:                                     TRANSFORM(THIS.this_oBusinessObject.this_nCodigos) + "?", ;
4757:                                     "Confirmar Exclus" + CHR(227) + "o")
4758:                     IF loc_lConfirma
4759:                         IF THIS.this_oBusinessObject.Excluir()
4760:                             MsgInfo("Invent" + CHR(225) + "rio exclu" + CHR(237) + "do com sucesso!", "Sucesso")
4761:                             THIS.CarregarLista()
4762:                         ENDIF
4763:                     ENDIF
4764:                 ENDIF
4765:             ENDIF
4766:         CATCH TO loc_oErro
4767:             MsgErro(loc_oErro.Message, "FormBAL.BtnExcluirClick")
4768:         ENDTRY
4769:     ENDPROC
4770: 
4771:     *--------------------------------------------------------------------------
4772:     * TornarControlesVisiveis - Torna controles do container visiveis
4773:     *--------------------------------------------------------------------------
4774:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4775:         LOCAL i, loc_oControl
4776: 
4777:         IF VARTYPE(par_oContainer) != "O"
4778:             RETURN
4779:         ENDIF
4780: 
4781:         FOR i = 1 TO par_oContainer.ControlCount
4782:             loc_oControl = par_oContainer.Controls(i)
4783:             IF !INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO", "CNT_4C_SAIDA")
4784:                 loc_oControl.Visible = .T.
4785:             ENDIF
4786:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
4787:                 THIS.TornarControlesVisiveis(loc_oControl)
4788:             ENDIF
4789:         ENDFOR
4790:     ENDPROC
4791: 
4792:     *--------------------------------------------------------------------------
4793:     * Destroy - Libera recursos
4794:     *--------------------------------------------------------------------------
4795:     PROCEDURE Destroy()
4796:         TRY
4797:             IF USED("cursor_4c_Dados")
4798:                 USE IN cursor_4c_Dados
4799:             ENDIF
4800:             IF USED("cursor_4c_GGrupos")
4801:                 USE IN cursor_4c_GGrupos
4802:             ENDIF
4803:             IF USED("cursor_4c_GGruposTemp")
4804:                 USE IN cursor_4c_GGruposTemp
4805:             ENDIF
4806:             IF USED("cursor_4c_GruposProd")
4807:                 USE IN cursor_4c_GruposProd
4808:             ENDIF
4809:             IF USED("cursor_4c_GruposProdTemp")
4810:                 USE IN cursor_4c_GruposProdTemp
4811:             ENDIF
4812:             IF USED("cursor_4c_Historico")
4813:                 USE IN cursor_4c_Historico
4814:             ENDIF
4815:             IF USED("cursor_4c_HistoricoTemp")
4816:                 USE IN cursor_4c_HistoricoTemp
4817:             ENDIF
4818:         CATCH TO loc_oErro
4819:             MsgErro(loc_oErro.Message, "FormBAL.Destroy")
4820:         ENDTRY
4821: 
4822:         DODEFAULT()
4823:     ENDPROC
4824: 
4825:     *--------------------------------------------------------------------------
4826:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
4827:     *--------------------------------------------------------------------------
4828:     PROCEDURE AjustarBotoesPorModo()
4829:         LOCAL loc_lModoEdicao, loc_oPage1
4830:         TRY
4831:             loc_lModoEdicao = (THIS.this_cModoAtual = "NOVO" OR THIS.this_cModoAtual = "EDICAO")
4832:             loc_oPage1 = THIS.pgf_4c_Paginas.Page1
4833:             IF VARTYPE(loc_oPage1.cmd_4c_Incluir) = "O"
4834:                 loc_oPage1.cmd_4c_Incluir.Enabled = !loc_lModoEdicao
4835:             ENDIF
4836:             IF VARTYPE(loc_oPage1.cmd_4c_Alterar) = "O"
4837:                 loc_oPage1.cmd_4c_Alterar.Enabled = !loc_lModoEdicao
4838:             ENDIF
4839:             IF VARTYPE(loc_oPage1.cmd_4c_Excluir) = "O"
4840:                 loc_oPage1.cmd_4c_Excluir.Enabled = !loc_lModoEdicao
4841:             ENDIF
4842:             IF VARTYPE(loc_oPage1.cmd_4c_Visualizar) = "O"
4843:                 loc_oPage1.cmd_4c_Visualizar.Enabled = !loc_lModoEdicao
4844:             ENDIF
4845:         CATCH TO loc_oErro
4846:             MsgErro(loc_oErro.Message, "FormBAL.AjustarBotoesPorModo")
4847:         ENDTRY
4848:     ENDPROC
4849: 
4850:     *--------------------------------------------------------------------------
4851:     * HabilitarCampos - Delega a HabilitarCamposDados
4852:     *--------------------------------------------------------------------------
4853:     PROCEDURE HabilitarCampos(par_lHabilitar)
4854:         THIS.HabilitarCamposDados(par_lHabilitar)
4855:     ENDPROC
4856: 
4857:     *--------------------------------------------------------------------------
4858:     * LimparCampos - Delega a LimparCamposDados
4859:     *--------------------------------------------------------------------------
4860:     PROCEDURE LimparCampos()
4861:         THIS.LimparCamposDados()
4862:     ENDPROC
4863: 
4864:     *--------------------------------------------------------------------------
4865:     * BtnSalvarClick - Alias para BtnConfirmarClick
4866:     *--------------------------------------------------------------------------
4867:     PROCEDURE BtnSalvarClick()
4868:         THIS.BtnConfirmarClick()
4869:     ENDPROC
4870: 
4871:     *--------------------------------------------------------------------------
4872:     * BtnBuscarClick - Recarrega lista (form operacional sem busca dedicada)
4873:     *--------------------------------------------------------------------------
4874:     PROCEDURE BtnBuscarClick()
4875:         THIS.CarregarLista()
4876:     ENDPROC
4877: 
4878: ENDDEFINE


### BO (C:\4c\projeto\app\classes\BALBO.prg):
*====================================================================
* BALBO.prg
*
* Business Object para Balanco de Inventario
* Tabela: SIGCDBAL
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS BALBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDBAL)
	*-- PK
	this_cCidchaves  = ""   && cidchaves char(20) - PK (chave unica UUID)
	*-- Identificacao
	this_nCodigos    = 0    && codigos numeric(4,0) - codigo do balanco
	this_cEmps       = ""   && emps char(3) - empresa
	this_cUsuars     = ""   && usuars char(10) - usuario
	this_nNtrans     = 0    && ntrans numeric(6,0) - numero da transacao
	*-- Grupos de Estoque (conta + grupo)
	this_cGrupos     = ""   && grupos char(10) - grupo de estoque (SigCdGcr)
	this_cContas     = ""   && contas char(10) - conta de estoque (SigCdCli)
	*-- Datas
	this_dDtbases    = {}   && dtbases datetime - data base
	this_dDatainis   = {}   && datainis datetime - data inicial leitura
	this_dDatafims   = {}   && datafims datetime - data final leitura
	this_dDatatrans  = {}   && datatrans datetime - data transporte
	*-- Flags de controle
	this_lEncerras   = .F.  && encerras bit - balanco encerrado
	this_lTratas     = .F.  && tratas bit - tratamento especial
	this_nSepestqs   = 0    && sepestqs numeric(1,0) - separar por estoque
	this_nTrtporpeso = 0    && trtporpeso numeric(1,0) - tratar por peso
	this_nAgrupas    = 0    && agrupas numeric(1,0) - forma de agrupamento
	this_nLeitgructa = 0    && leitgructa numeric(1,0) - leitura somente grupo+conta
	this_nFilbarras  = 0    && filbarras numeric(1,0) - filtro tipo codigo de barras
	*-- Locais (filtros)
	this_cLocals     = ""   && locals char(10) - local (usado na leitura)
	this_cLocalis    = ""   && localis char(10) - local inicial (filtro)
	this_cLocalfs    = ""   && localfs char(10) - local final (filtro)
	*-- Fornecedores (filtros)
	this_cIforis     = ""   && iforis char(10) - fornecedor inicial
	this_cIforfs     = ""   && iforfs char(10) - fornecedor final
	*-- Preco (filtros)
	this_nPrecois    = 0    && precois numeric(8,2) - preco inicial
	this_nPrecofs    = 0    && precofs numeric(8,2) - preco final
	*-- Grupos de Produto (filtros)
	this_cCgruis     = ""   && cgruis char(3) - grupo produto inicial (SigCdGrp.cgrus)
	this_cCgrufs     = ""   && cgrufs char(3) - grupo produto final (SigCdGrp.cgrus)
	*-- Grandes Grupos (filtros)
	this_cCggruis    = ""   && cggruis char(3) - grande grupo inicial (SigCdGpr.codigos)
	this_cCggrufs    = ""   && cggrufs char(3) - grande grupo final (SigCdGpr.codigos)
	*-- Colecoes (filtros)
	this_cColecoesi  = ""   && colecoesi char(10) - colecao inicial (SigCdCol.colecoes)
	this_cColecoesf  = ""   && colecoesf char(10) - colecao final (SigCdCol.colecoes)
	*-- Produtos (filtros)
	this_cCprosi     = ""   && cprosi char(14) - produto inicial (SigCdPro.cpros)
	this_cCprosf     = ""   && cprosf char(14) - produto final (SigCdPro.cpros)
	*-- Subgrupos (filtros)
	this_cSgrusi     = ""   && sgrusi char(6) - subgrupo inicial (SigCdPsg.codigos)
	this_cSgrusf     = ""   && sgrusf char(6) - subgrupo final (SigCdPsg.codigos)
	*-- Unidades (filtros)
	this_cCfinpsi    = ""   && cfinpsi char(3) - unidade inicial (SigCdUni.cunis)
	this_cCfinpsf    = ""   && cfinpsf char(3) - unidade final (SigCdUni.cunis)
	*-- Memo/XML (filtros em grade)
	this_cMfilggrp   = ""   && mfilggrp text - XML marcacoes grandes grupos
	this_cMfilgrupo  = ""   && mfilgrupo text - XML marcacoes grupos produto
	this_cObs        = ""   && obs text - observacao geral

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDBAL"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Lista balancos de inventario da empresa atual
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cEmp
		loc_lSucesso = .F.
		loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
				           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
				           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
				           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
				           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
				           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
				           " FROM SIGCDBAL" + ;
				           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
				           " ORDER BY codigos, cidchaves"
			ELSE
				loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
				           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
				           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
				           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
				           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
				           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
				           " FROM SIGCDBAL" + ;
				           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
				           " AND codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
				           " ORDER BY codigos, cidchaves"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um balanco pelo cidchaves (PK UUID)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
			           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
			           " mfilggrp, mfilgrupo, obs" + ;
			           " FROM SIGCDBAL" + ;
			           " WHERE cidchaves = " + EscaparSQL(par_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorNumero - Carrega balanco pelo numero (codigos + emps)
	*====================================================================
	PROCEDURE CarregarPorNumero(par_nCodigos, par_cEmps)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
			           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
			           " mfilggrp, mfilgrupo, obs" + ;
			           " FROM SIGCDBAL" + ;
			           " WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
			           " AND emps = " + EscaparSQL(par_cEmps)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves    = TratarNulo(cidchaves,    "C")
			THIS.this_nCodigos      = TratarNulo(codigos,      "N")
			THIS.this_cEmps         = TratarNulo(emps,         "C")
			THIS.this_cGrupos       = TratarNulo(grupos,       "C")
			THIS.this_cContas       = TratarNulo(contas,       "C")
			THIS.this_dDtbases      = TratarNulo(dtbases,      "D")
			THIS.this_dDatainis     = TratarNulo(datainis,     "D")
			THIS.this_dDatafims     = TratarNulo(datafims,     "D")
			THIS.this_dDatatrans    = TratarNulo(datatrans,    "D")
			THIS.this_lEncerras     = (TratarNulo(encerras,    "N") = 1)
			THIS.this_lTratas       = (TratarNulo(tratas,      "N") = 1)
			THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
			THIS.this_nSepestqs     = TratarNulo(sepestqs,     "N")
			THIS.this_nTrtporpeso   = TratarNulo(trtporpeso,   "N")
			THIS.this_nLeitgructa   = TratarNulo(leitgructa,   "N")
			THIS.this_nFilbarras    = TratarNulo(filbarras,     "N")
			THIS.this_cLocalis      = TratarNulo(localis,      "C")
			THIS.this_cLocalfs      = TratarNulo(localfs,      "C")
			THIS.this_cIforis       = TratarNulo(iforis,       "C")
			THIS.this_cIforfs       = TratarNulo(iforfs,       "C")
			THIS.this_cCgruis       = TratarNulo(cgruis,       "C")
			THIS.this_cCgrufs       = TratarNulo(cgrufs,       "C")
			THIS.this_cCggruis      = TratarNulo(cggruis,      "C")
			THIS.this_cCggrufs      = TratarNulo(cggrufs,      "C")
			THIS.this_cColecoesi    = TratarNulo(colecoesi,    "C")
			THIS.this_cColecoesf    = TratarNulo(colecoesf,    "C")
			THIS.this_cCprosi       = TratarNulo(cprosi,       "C")
			THIS.this_cCprosf       = TratarNulo(cprosf,       "C")
			THIS.this_cSgrusi       = TratarNulo(sgrusi,       "C")
			THIS.this_cSgrusf       = TratarNulo(sgrusf,       "C")
			THIS.this_cCfinpsi      = TratarNulo(cfinpsi,      "C")
			THIS.this_cCfinpsf      = TratarNulo(cfinpsf,      "C")
			THIS.this_nPrecois      = TratarNulo(precois,      "N")
			THIS.this_nPrecofs      = TratarNulo(precofs,      "N")
			THIS.this_nNtrans       = TratarNulo(ntrans,       "N")
			THIS.this_cLocals       = TratarNulo(locals,       "C")
			THIS.this_cUsuars       = TratarNulo(usuars,       "C")
			*-- Campos TEXT/memo (podem nao estar no cursor de listagem)
			IF PEMSTATUS(EVAL(par_cAliasCursor), "mfilggrp", 5) OR ;
			   !EMPTY(FIELD("mfilggrp", par_cAliasCursor))
				THIS.this_cMfilggrp  = TratarNulo(mfilggrp,   "C")
				THIS.this_cMfilgrupo = TratarNulo(mfilgrupo,  "C")
				THIS.this_cObs       = TratarNulo(obs,        "C")
			ENDIF
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerarProximoCodigo - Obtem proximo codigo disponivel para a empresa
	*====================================================================
	PROTECTED PROCEDURE GerarProximoCodigo(par_cEmps)
		LOCAL loc_cSQL, loc_nResultado, loc_nCodigo
		loc_nCodigo = 0

		TRY
			loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox_cod" + ;
			           " FROM SIGCDBAL WHERE emps = " + EscaparSQL(par_cEmps)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
				SELECT cursor_4c_ProxCod
				loc_nCodigo = cursor_4c_ProxCod.prox_cod
			ENDIF

			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF
		ENDTRY

		RETURN loc_nCodigo
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDBAL
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigo, loc_cEmp
		loc_lSucesso = .F.
		loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

		TRY
			*-- Gerar chave UUID e proximo codigo sequencial
			THIS.this_cCidchaves = ""
			loc_cSQL = "SELECT LEFT(NEWID(), 20) AS novo_uuid"
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Uuid")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
				SELECT cursor_4c_Uuid
				THIS.this_cCidchaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
			ENDIF
			IF USED("cursor_4c_Uuid")
				USE IN cursor_4c_Uuid
			ENDIF

			IF EMPTY(THIS.this_cCidchaves)
				MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
				loc_lSucesso = .F.
			ENDIF

			loc_nCodigo = THIS.GerarProximoCodigo(loc_cEmp)
			IF loc_nCodigo = 0
				MsgErro("Erro ao gerar c" + CHR(243) + "digo do invent" + CHR(225) + "rio.", "Erro")
				loc_lSucesso = .F.
			ENDIF
			THIS.this_nCodigos = loc_nCodigo
			THIS.this_cEmps    = loc_cEmp
			THIS.this_cUsuars  = ALLTRIM(gc_4c_UsuarioLogado)

			loc_cSQL = "INSERT INTO SIGCDBAL (" + ;
			           " cidchaves, codigos, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, encerras, tratas, agrupas, sepestqs," + ;
			           " trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
			           ") VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
			           EscaparSQL(THIS.this_cEmps) + "," + ;
			           EscaparSQL(THIS.this_cGrupos) + "," + ;
			           EscaparSQL(THIS.this_cContas) + "," + ;
			           FormatarDataSQL(THIS.this_dDtbases) + "," + ;
			           FormatarDataSQL(THIS.this_dDatainis) + "," + ;
			           FormatarDataSQL(THIS.this_dDatafims) + "," + ;
			           IIF(THIS.this_lEncerras, "1", "0") + "," + ;
			           IIF(THIS.this_lTratas, "1", "0") + "," + ;
			           FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
			           FormatarNumeroSQL(THIS.this_nSepestqs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTrtporpeso) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLeitgructa) + "," + ;
			           FormatarNumeroSQL(THIS.this_nFilbarras) + "," + ;
			           EscaparSQL(THIS.this_cLocalis) + "," + ;
			           EscaparSQL(THIS.this_cLocalfs) + "," + ;
			           EscaparSQL(THIS.this_cIforis) + "," + ;
			           EscaparSQL(THIS.this_cIforfs) + "," + ;
			           EscaparSQL(THIS.this_cCgruis) + "," + ;
			           EscaparSQL(THIS.this_cCgrufs) + "," + ;
			           EscaparSQL(THIS.this_cCggruis) + "," + ;
			           EscaparSQL(THIS.this_cCggrufs) + "," + ;
			           EscaparSQL(THIS.this_cColecoesi) + "," + ;
			           EscaparSQL(THIS.this_cColecoesf) + "," + ;
			           EscaparSQL(THIS.this_cCprosi) + "," + ;
			           EscaparSQL(THIS.this_cCprosf) + "," + ;
			           EscaparSQL(THIS.this_cSgrusi) + "," + ;
			           EscaparSQL(THIS.this_cSgrusf) + "," + ;
			           EscaparSQL(THIS.this_cCfinpsi) + "," + ;
			           EscaparSQL(THIS.this_cCfinpsf) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
			           EscaparSQL(THIS.this_cLocals) + "," + ;
			           EscaparSQL(THIS.this_cUsuars) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDBAL
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
			           " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
			           " dtbases = " + FormatarDataSQL(THIS.this_dDtbases) + "," + ;
			           " datainis = " + FormatarDataSQL(THIS.this_dDatainis) + "," + ;
			           " datafims = " + FormatarDataSQL(THIS.this_dDatafims) + "," + ;
			           " encerras = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
			           " tratas = " + IIF(THIS.this_lTratas, "1", "0") + "," + ;
			           " agrupas = " + FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
			           " sepestqs = " + FormatarNumeroSQL(THIS.this_nSepestqs) + "," + ;
			           " trtporpeso = " + FormatarNumeroSQL(THIS.this_nTrtporpeso) + "," + ;
			           " leitgructa = " + FormatarNumeroSQL(THIS.this_nLeitgructa) + "," + ;
			           " filbarras = " + FormatarNumeroSQL(THIS.this_nFilbarras) + "," + ;
			           " localis = " + EscaparSQL(THIS.this_cLocalis) + "," + ;
			           " localfs = " + EscaparSQL(THIS.this_cLocalfs) + "," + ;
			           " iforis = " + EscaparSQL(THIS.this_cIforis) + "," + ;
			           " iforfs = " + EscaparSQL(THIS.this_cIforfs) + "," + ;
			           " cgruis = " + EscaparSQL(THIS.this_cCgruis) + "," + ;
			           " cgrufs = " + EscaparSQL(THIS.this_cCgrufs) + "," + ;
			           " cggruis = " + EscaparSQL(THIS.this_cCggruis) + "," + ;
			           " cggrufs = " + EscaparSQL(THIS.this_cCggrufs) + "," + ;
			           " colecoesi = " + EscaparSQL(THIS.this_cColecoesi) + "," + ;
			           " colecoesf = " + EscaparSQL(THIS.this_cColecoesf) + "," + ;
			           " cprosi = " + EscaparSQL(THIS.this_cCprosi) + "," + ;
			           " cprosf = " + EscaparSQL(THIS.this_cCprosf) + "," + ;
			           " sgrusi = " + EscaparSQL(THIS.this_cSgrusi) + "," + ;
			           " sgrusf = " + EscaparSQL(THIS.this_cSgrusf) + "," + ;
			           " cfinpsi = " + EscaparSQL(THIS.this_cCfinpsi) + "," + ;
			           " cfinpsf = " + EscaparSQL(THIS.this_cCfinpsf) + "," + ;
			           " precois = " + FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
			           " precofs = " + FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
			           " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
			           " usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE do balanco e registros filhos
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigos, loc_cEmps
		loc_lSucesso = .F.
		loc_nCodigos = THIS.this_nCodigos
		loc_cEmps    = ALLTRIM(THIS.this_cEmps)

		TRY
			*-- Remover registros filhos: SigIvTrB (balancos itens)
			loc_cSQL = "DELETE FROM SigIvTrB" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover registros filhos: SigIvTrH (historico de leitura)
			loc_cSQL = "DELETE FROM SigIvTrH" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover registros filhos: SigIvTrE (etiquetas)
			loc_cSQL = "DELETE FROM SigIvTrE" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover o balanco principal
			loc_cSQL = "DELETE FROM SIGCDBAL" + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarEncerramento - Marca/desmarca balanco como encerrado
	*====================================================================
	PROCEDURE AtualizarEncerramento(par_lEncerrar, par_dDatafim)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " encerras = " + IIF(par_lEncerrar, "1", "0") + "," + ;
			           " datafims = " + FormatarDataSQL(par_dDatafim) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_lEncerras  = par_lEncerrar
				THIS.this_dDatafims  = par_dDatafim
				THIS.RegistrarAuditoria("ENCERRAR")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarTransporte - Marca balanco como transportado
	*====================================================================
	PROCEDURE AtualizarTransporte(par_dDataTrans)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " datatrans = " + FormatarDataSQL(par_dDataTrans) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_dDatatrans = par_dDataTrans
				THIS.RegistrarAuditoria("TRANSPORTE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao registrar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao registrar transporte:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarFiltrosXML - Salva filtros de grade (mfilggrp, mfilgrupo)
	*====================================================================
	PROCEDURE AtualizarFiltrosXML(par_cMfilggrp, par_cMfilgrupo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " mfilggrp = " + EscaparSQL(par_cMfilggrp) + "," + ;
			           " mfilgrupo = " + EscaparSQL(par_cMfilgrupo) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_cMfilggrp  = par_cMfilggrp
				THIS.this_cMfilgrupo = par_cMfilgrupo
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao salvar filtros XML:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao salvar filtros XML:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarGrupoEstoque - Verifica se grupo de estoque eh valido
	*====================================================================
	PROCEDURE ValidarGrupoEstoque(par_cGrupos)
		LOCAL loc_cSQL, loc_nResultado, loc_lValido
		loc_lValido = .F.

		TRY
			IF EMPTY(ALLTRIM(par_cGrupos))
				loc_lValido = .F.
			ENDIF

			loc_cSQL = "SELECT TOP 1 Codigos FROM SigCdGcr" + ;
			           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cGrupos))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGru")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValGru") > 0
				loc_lValido = .T.
			ENDIF

			IF USED("cursor_4c_ValGru")
				USE IN cursor_4c_ValGru
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ValGru")
				USE IN cursor_4c_ValGru
			ENDIF
		ENDTRY

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* ValidarConta - Verifica se conta de estoque eh valida
	*====================================================================
	PROCEDURE ValidarConta(par_cContas)
		LOCAL loc_cSQL, loc_nResultado, loc_lValido
		loc_lValido = .F.

		TRY
			IF EMPTY(ALLTRIM(par_cContas))
				loc_lValido = .T.
			ENDIF

			loc_cSQL = "SELECT TOP 1 IClis FROM SigCdCli" + ;
			           " WHERE IClis = " + EscaparSQL(ALLTRIM(par_cContas))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCta")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValCta") > 0
				loc_lValido = .T.
			ENDIF

			IF USED("cursor_4c_ValCta")
				USE IN cursor_4c_ValCta
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao validar conta:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ValCta")
				USE IN cursor_4c_ValCta
			ENDIF
		ENDTRY

		RETURN loc_lValido
	ENDPROC

ENDDEFINE

