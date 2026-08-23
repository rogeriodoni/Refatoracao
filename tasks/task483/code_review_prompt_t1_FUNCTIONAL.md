# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [CARGA-DADOS] OptionGroup 'opt_4c_Blqdt' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Tipo' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_TipoNF' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Vende' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Dados' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_DadosTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Descrição, Origem dos Valores a Serem Lançados na Movimentação Financeira. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Descrição, Origem dos Valores a Serem Lançados na Movimentação Financeira. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Situação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Descrição, Origem dos Valores a Serem Lançados na Movimentação Financeira. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'CCUSTO' (parent: SIGCDOPE.Pagina.Dados.PagDados.PgComissao): Top original=54 vs migrado 'cmd_4c_Ccusto' Top=603 (diff=549px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'CCUSTO' (parent: SIGCDOPE.Pagina.Dados.PagDados.PgComissao): Left original=463 vs migrado 'cmd_4c_Ccusto' Left=810 (diff=347px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOPE.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2481 linhas total):

*-- Linhas 29 a 156:
29: 
30:     *==========================================================================
31:     * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
32:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
33:     *==========================================================================
34:     PROCEDURE Init()
35:         RETURN DODEFAULT()
36:     ENDPROC
37: 
38:     *==========================================================================
39:     * InicializarForm - Configura estrutura completa
40:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
41:     *==========================================================================
42:     PROTECTED PROCEDURE InicializarForm()
43:         LOCAL loc_lSucesso
44:         loc_lSucesso = .F.
45: 
46:         TRY
47:             THIS.this_oBusinessObject = CREATEOBJECT("OPEBO")
48: 
49:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
50:                 MostrarErro("Erro ao criar OPEBO" + CHR(13) + ;
51:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
52:                     "FormOPE.InicializarForm")
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55: 
56:                 WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
57:                     .lbl_4c_Sombra.Caption = THIS.Caption
58:                     .lbl_4c_Titulo.Caption = THIS.Caption
59:                     .Visible = .T.
60:                 ENDWITH
61: 
62:                 THIS.pgf_4c_Paginas.Visible   = .T.
63:                 THIS.pgf_4c_Paginas.ActivePage = 1
64:                 THIS.this_cModoAtual = "LISTA"
65: 
66:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
67:                     THIS.CarregarLista()
68:                 ENDIF
69: 
70:                 loc_lSucesso = .T.
71:             ENDIF
72: 
73:         CATCH TO loc_oErro
74:             MostrarErro("Erro ao inicializar FormOPE:" + CHR(13) + ;
75:                 loc_oErro.Message + CHR(13) + ;
76:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
77:                 "FormOPE.InicializarForm")
78:         ENDTRY
79: 
80:         RETURN loc_lSucesso
81:     ENDPROC
82: 
83:     *==========================================================================
84:     * ConfigurarPageFrame - Cria PageFrame externo com 2 paginas
85:     * Top=-29 para esconder abas; controles compensam +29 no Top
86:     *==========================================================================
87:     PROTECTED PROCEDURE ConfigurarPageFrame()
88:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
89: 
90:         WITH THIS.pgf_4c_Paginas
91:             .PageCount = 2
92:             .Top       = -29
93:             .Left      = 0
94:             .Width     = THIS.Width
95:             .Height    = THIS.Height + 29
96:             .Tabs      = .F.
97:             .Visible   = .T.
98: 
99:             .Page1.Caption  = "Lista"
100:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page1.BackColor = RGB(255, 255, 255)
102: 
103:             .Page2.Caption  = "Dados"
104:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105:             .Page2.BackColor = RGB(255, 255, 255)
106:         ENDWITH
107: 
108:         THIS.ConfigurarPaginaLista()
109:         THIS.ConfigurarPaginaDados()
110:     ENDPROC
111: 
112:     *==========================================================================
113:     * ConfigurarPaginaLista - Configura Page1: cabecalho, filtro, botoes CRUD,
114:     *   grid cursor_4c_Dados, botoes de acao auxiliares
115:     *==========================================================================
116:     PROTECTED PROCEDURE ConfigurarPaginaLista()
117:         LOCAL loc_oPagina
118:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
119: 
120:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
121: 
122:         *-- Container Cabecalho (compensacao +29: Top=30)
123:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
124:         WITH loc_oPagina.cnt_4c_Cabecalho
125:             .Top       = 30
126:             .Left      = 0
127:             .Width     = THIS.Width
128:             .Height    = 80
129:             .BackColor = RGB(100, 100, 100)
130:             .BorderWidth = 0
131:             .Visible   = .T.
132:         ENDWITH
133: 
134:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
135:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
136:             .Caption   = THIS.Caption
137:             .Top       = 15
138:             .Left      = 10
139:             .Width     = THIS.Width - 20
140:             .Height    = 40
141:             .FontName  = "Tahoma"
142:             .FontSize  = 16
143:             .FontBold  = .T.
144:             .ForeColor = RGB(0, 0, 0)
145:             .BackStyle = 0
146:             .AutoSize  = .F.
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
151:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
152:             .Caption   = THIS.Caption
153:             .Top       = 18
154:             .Left      = 10
155:             .Width     = THIS.Width - 20
156:             .Height    = 46

*-- Linhas 198 a 897:
198:             .AutoSize        = .F.
199:             .Visible         = .T.
200:         ENDWITH
201:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
202: 
203:         *-- Botao Alterar
204:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
205:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
206:             .Caption         = "Alterar"
207:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
208:             .PicturePosition = 13
209:             .Top             = 5
210:             .Left            = 80
211:             .Width           = 75
212:             .Height          = 75
213:             .FontName        = "Tahoma"
214:             .FontBold        = .T.
215:             .FontItalic      = .T.
216:             .FontSize        = 8
217:             .ForeColor       = RGB(90, 90, 90)
218:             .BackColor       = RGB(255, 255, 255)
219:             .Themes          = .F.
220:             .SpecialEffect   = 0
221:             .MousePointer    = 15
222:             .WordWrap        = .T.
223:             .AutoSize        = .F.
224:             .Visible         = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
227: 
228:         *-- Botao Visualizar
229:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
230:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
231:             .Caption         = "Visualizar"
232:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
233:             .PicturePosition = 13
234:             .Top             = 5
235:             .Left            = 155
236:             .Width           = 75
237:             .Height          = 75
238:             .FontName        = "Tahoma"
239:             .FontBold        = .T.
240:             .FontItalic      = .T.
241:             .FontSize        = 8
242:             .ForeColor       = RGB(90, 90, 90)
243:             .BackColor       = RGB(255, 255, 255)
244:             .Themes          = .F.
245:             .SpecialEffect   = 0
246:             .MousePointer    = 15
247:             .WordWrap        = .T.
248:             .AutoSize        = .F.
249:             .Visible         = .T.
250:         ENDWITH
251:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
252: 
253:         *-- Botao Excluir
254:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
255:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
256:             .Caption         = "Excluir"
257:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
258:             .PicturePosition = 13
259:             .Top             = 5
260:             .Left            = 230
261:             .Width           = 75
262:             .Height          = 75
263:             .FontName        = "Tahoma"
264:             .FontBold        = .T.
265:             .FontItalic      = .T.
266:             .FontSize        = 8
267:             .ForeColor       = RGB(90, 90, 90)
268:             .BackColor       = RGB(255, 255, 255)
269:             .Themes          = .F.
270:             .SpecialEffect   = 0
271:             .MousePointer    = 15
272:             .WordWrap        = .T.
273:             .AutoSize        = .F.
274:             .Visible         = .T.
275:         ENDWITH
276:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
277: 
278:         *-- Botao Buscar
279:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
280:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
281:             .Caption         = "Buscar"
282:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
283:             .PicturePosition = 13
284:             .Top             = 5
285:             .Left            = 305
286:             .Width           = 75
287:             .Height          = 75
288:             .FontName        = "Tahoma"
289:             .FontBold        = .T.
290:             .FontItalic      = .T.
291:             .FontSize        = 8
292:             .ForeColor       = RGB(90, 90, 90)
293:             .BackColor       = RGB(255, 255, 255)
294:             .Themes          = .F.
295:             .SpecialEffect   = 0
296:             .MousePointer    = 15
297:             .WordWrap        = .T.
298:             .AutoSize        = .F.
299:             .Visible         = .T.
300:         ENDWITH
301:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
302: 
303:         *-- Container Saida (Encerrar) - PADRAO CANONICO (CLAUDE.md regra #10)
304:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
305:         WITH loc_oPagina.cnt_4c_Saida
306:             .Left      = 917
307:             .Top       = 29
308:             .Width     = 90
309:             .Height    = 85
310:             .BackStyle = 0
311:             .BorderWidth = 0
312:             .Visible   = .T.
313:         ENDWITH
314: 
315:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
316:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
317:             .Caption         = "Encerrar"
318:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
319:             .PicturePosition = 13
320:             .Top             = 5
321:             .Left            = 5
322:             .Width           = 75
323:             .Height          = 75
324:             .FontName        = "Tahoma"
325:             .FontBold        = .T.
326:             .FontItalic      = .T.
327:             .FontSize        = 8
328:             .ForeColor       = RGB(90, 90, 90)
329:             .BackColor       = RGB(255, 255, 255)
330:             .Themes          = .F.
331:             .SpecialEffect   = 0
332:             .MousePointer    = 15
333:             .WordWrap        = .T.
334:             .AutoSize        = .F.
335:             .Visible         = .T.
336:         ENDWITH
337:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
338: 
339:         *-- Filtro optFilSituas (legado: optFilSituas Top=93, Left=11, Width=181, Height=25)
340:         *-- Compensacao +29: Top=122
341:         loc_oPagina.AddObject("opt_4c_FilSituas", "OptionGroup")
342:         WITH loc_oPagina.opt_4c_FilSituas
343:             .Top         = 122
344:             .Left        = 11
345:             .Width       = 181
346:             .Height      = 25
347:             .ButtonCount = 3
348:             .BackStyle   = 0
349:             .BorderStyle = 0
350:             .SpecialEffect = 1
351:             .Themes      = .F.
352:             .Value       = 1
353:             .Visible     = .T.
354:         ENDWITH
355:         WITH loc_oPagina.opt_4c_FilSituas
356:             .Buttons(1).Caption = "Todos"
357:             .Buttons(1).Left    = 0
358:             .Buttons(1).Top     = 0
359:             .Buttons(1).Width   = 60
360:             .Buttons(1).Height  = 25
361:             .Buttons(1).Themes  = .F.
362:             .Buttons(2).Caption = "Ativos"
363:             .Buttons(2).Left    = 60
364:             .Buttons(2).Top     = 0
365:             .Buttons(2).Width   = 60
366:             .Buttons(2).Height  = 25
367:             .Buttons(2).Themes  = .F.
368:             .Buttons(3).Caption = "Inativos"
369:             .Buttons(3).Left    = 120
370:             .Buttons(3).Top     = 0
371:             .Buttons(3).Width   = 61
372:             .Buttons(3).Height  = 25
373:             .Buttons(3).Themes  = .F.
374:         ENDWITH
375:         BINDEVENT(loc_oPagina.opt_4c_FilSituas, "InteractiveChange", THIS, "FiltroSituaClick")
376: 
377:         *-- Grid principal cursor_4c_Dados
378:         *-- Legado: Grade Top=127 (compensado +29 = 156), Left=5, Width=997, Height=441
379:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
380:         WITH loc_oPagina.grd_4c_Dados
381:             .Top         = 156
382:             .Left        = 5
383:             .Width       = 992
384:             .Height      = 410
385:             .ColumnCount = 4
386:             .DeleteMark  = .F.
387:             .RecordMark  = .F.
388:             .ReadOnly    = .T.
389:             .FontName    = "Courier New"
390:             .FontSize    = 9
391:             .Visible     = .T.
392:             .Column1.Width     = 100
393:             .Column1.Movable   = .F.
394:             .Column1.Resizable = .F.
395:             .Column2.Width     = 400
396:             .Column2.Movable   = .F.
397:             .Column2.Resizable = .F.
398:             .Column3.Width     = 80
399:             .Column3.Movable   = .F.
400:             .Column3.Resizable = .F.
401:             .Column4.Width     = 80
402:             .Column4.Movable   = .F.
403:             .Column4.Resizable = .F.
404:         ENDWITH
405:         BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GridAfterRowColChange")
406: 
407:         *-- Botoes de acao no topo (legado top=82, compensado +29 = 111)
408:         *-- btnExpXML (Exportar): left=519
409:         loc_oPagina.AddObject("cmd_4c_BtnExpXML", "CommandButton")
410:         WITH loc_oPagina.cmd_4c_BtnExpXML
411:             .Caption         = "Exportar"
412:             .Top             = 111
413:             .Left            = 519
414:             .Width           = 120
415:             .Height          = 40
416:             .FontName        = "Tahoma"
417:             .FontSize        = 8
418:             .FontBold        = .T.
419:             .ForeColor       = RGB(90, 90, 90)
420:             .BackColor       = RGB(255, 255, 255)
421:             .Themes          = .F.
422:             .SpecialEffect   = 0
423:             .Visible         = .T.
424:         ENDWITH
425:         BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML, "Click", THIS, "BtnExpXMLClick")
426: 
427:         *-- btnImpXML (Importar): left=639
428:         loc_oPagina.AddObject("cmd_4c_BtnImpXML", "CommandButton")
429:         WITH loc_oPagina.cmd_4c_BtnImpXML
430:             .Caption         = "Importar"
431:             .Top             = 111
432:             .Left            = 639
433:             .Width           = 120
434:             .Height          = 40
435:             .FontName        = "Tahoma"
436:             .FontSize        = 8
437:             .FontBold        = .T.
438:             .ForeColor       = RGB(90, 90, 90)
439:             .BackColor       = RGB(255, 255, 255)
440:             .Themes          = .F.
441:             .SpecialEffect   = 0
442:             .Visible         = .T.
443:         ENDWITH
444:         BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML, "Click", THIS, "BtnImpXMLClick")
445: 
446:         *-- CmdCopia (Copiar): left=759
447:         loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
448:         WITH loc_oPagina.cmd_4c_Copia
449:             .Caption         = "Copiar"
450:             .Top             = 111
451:             .Left            = 759
452:             .Width           = 120
453:             .Height          = 40
454:             .FontName        = "Tahoma"
455:             .FontSize        = 8
456:             .FontBold        = .T.
457:             .ForeColor       = RGB(90, 90, 90)
458:             .BackColor       = RGB(255, 255, 255)
459:             .Themes          = .F.
460:             .SpecialEffect   = 0
461:             .Visible         = .T.
462:         ENDWITH
463:         BINDEVENT(loc_oPagina.cmd_4c_Copia, "Click", THIS, "BtnCopiaClick")
464: 
465:         *-- btnMapa (Mapa): left=879
466:         loc_oPagina.AddObject("cmd_4c_Mapa", "CommandButton")
467:         WITH loc_oPagina.cmd_4c_Mapa
468:             .Caption         = "Mapa"
469:             .Top             = 111
470:             .Left            = 879
471:             .Width           = 120
472:             .Height          = 40
473:             .FontName        = "Tahoma"
474:             .FontSize        = 8
475:             .FontBold        = .T.
476:             .ForeColor       = RGB(90, 90, 90)
477:             .BackColor       = RGB(255, 255, 255)
478:             .Themes          = .F.
479:             .SpecialEffect   = 0
480:             .Visible         = .T.
481:         ENDWITH
482:         BINDEVENT(loc_oPagina.cmd_4c_Mapa, "Click", THIS, "BtnMapaClick")
483: 
484:         *-- Botoes de acao inferiores (legado top=574, compensado +29 = 603)
485:         *-- Credito (Ger. Creditos): left=4
486:         loc_oPagina.AddObject("cmd_4c_Credito", "CommandButton")
487:         WITH loc_oPagina.cmd_4c_Credito
488:             .Caption     = "Ger. Cr" + CHR(233) + "ditos"
489:             .Top         = 603
490:             .Left        = 4
491:             .Width       = 62
492:             .Height      = 59
493:             .FontName    = "Tahoma"
494:             .FontSize    = 7
495:             .FontBold    = .T.
496:             .ForeColor   = RGB(90, 90, 90)
497:             .BackColor   = RGB(255, 255, 255)
498:             .Themes      = .F.
499:             .WordWrap    = .T.
500:             .SpecialEffect = 0
501:             .Visible     = .T.
502:         ENDWITH
503:         BINDEVENT(loc_oPagina.cmd_4c_Credito, "Click", THIS, "BtnCreditoClick")
504: 
505:         *-- Deprecia (Depreciacao): left=66
506:         loc_oPagina.AddObject("cmd_4c_Deprecia", "CommandButton")
507:         WITH loc_oPagina.cmd_4c_Deprecia
508:             .Caption     = "Deprecia" + CHR(231) + CHR(227) + "o"
509:             .Top         = 603
510:             .Left        = 66
511:             .Width       = 62
512:             .Height      = 59
513:             .FontName    = "Tahoma"
514:             .FontSize    = 7
515:             .FontBold    = .T.
516:             .ForeColor   = RGB(90, 90, 90)
517:             .BackColor   = RGB(255, 255, 255)
518:             .Themes      = .F.
519:             .WordWrap    = .T.
520:             .SpecialEffect = 0
521:             .Visible     = .T.
522:         ENDWITH
523:         BINDEVENT(loc_oPagina.cmd_4c_Deprecia, "Click", THIS, "BtnDepreciaClick")
524: 
525:         *-- cmdEtiquetas (Etiquetas): left=128
526:         loc_oPagina.AddObject("cmd_4c_Etiquetas", "CommandButton")
527:         WITH loc_oPagina.cmd_4c_Etiquetas
528:             .Caption     = "Etiquetas"
529:             .Top         = 603
530:             .Left        = 128
531:             .Width       = 62
532:             .Height      = 59
533:             .FontName    = "Tahoma"
534:             .FontSize    = 7
535:             .FontBold    = .T.
536:             .ForeColor   = RGB(90, 90, 90)
537:             .BackColor   = RGB(255, 255, 255)
538:             .Themes      = .F.
539:             .WordWrap    = .T.
540:             .SpecialEffect = 0
541:             .Visible     = .T.
542:         ENDWITH
543:         BINDEVENT(loc_oPagina.cmd_4c_Etiquetas, "Click", THIS, "BtnEtiquetasClick")
544: 
545:         *-- Transporte (Transportes): left=190
546:         loc_oPagina.AddObject("cmd_4c_Transporte", "CommandButton")
547:         WITH loc_oPagina.cmd_4c_Transporte
548:             .Caption     = "Transportes"
549:             .Top         = 603
550:             .Left        = 190
551:             .Width       = 62
552:             .Height      = 59
553:             .FontName    = "Tahoma"
554:             .FontSize    = 7
555:             .FontBold    = .T.
556:             .ForeColor   = RGB(90, 90, 90)
557:             .BackColor   = RGB(255, 255, 255)
558:             .Themes      = .F.
559:             .WordWrap    = .T.
560:             .SpecialEffect = 0
561:             .Visible     = .T.
562:         ENDWITH
563:         BINDEVENT(loc_oPagina.cmd_4c_Transporte, "Click", THIS, "BtnTransporteClick")
564: 
565:         *-- Frete (Fretes): left=252
566:         loc_oPagina.AddObject("cmd_4c_Frete", "CommandButton")
567:         WITH loc_oPagina.cmd_4c_Frete
568:             .Caption     = "Fretes"
569:             .Top         = 603
570:             .Left        = 252
571:             .Width       = 62
572:             .Height      = 59
573:             .FontName    = "Tahoma"
574:             .FontSize    = 7
575:             .FontBold    = .T.
576:             .ForeColor   = RGB(90, 90, 90)
577:             .BackColor   = RGB(255, 255, 255)
578:             .Themes      = .F.
579:             .WordWrap    = .T.
580:             .SpecialEffect = 0
581:             .Visible     = .T.
582:         ENDWITH
583:         BINDEVENT(loc_oPagina.cmd_4c_Frete, "Click", THIS, "BtnFreteClick")
584: 
585:         *-- Caixa (Sequencia Cx): left=314
586:         loc_oPagina.AddObject("cmd_4c_Caixa", "CommandButton")
587:         WITH loc_oPagina.cmd_4c_Caixa
588:             .Caption     = "Sequ" + CHR(234) + "ncia Cx"
589:             .Top         = 603
590:             .Left        = 314
591:             .Width       = 62
592:             .Height      = 59
593:             .FontName    = "Tahoma"
594:             .FontSize    = 7
595:             .FontBold    = .T.
596:             .ForeColor   = RGB(90, 90, 90)
597:             .BackColor   = RGB(255, 255, 255)
598:             .Themes      = .F.
599:             .WordWrap    = .T.
600:             .SpecialEffect = 0
601:             .Visible     = .T.
602:         ENDWITH
603:         BINDEVENT(loc_oPagina.cmd_4c_Caixa, "Click", THIS, "BtnCaixaClick")
604: 
605:         *-- TabDesconto (Tabelas): left=438
606:         loc_oPagina.AddObject("cmd_4c_TabDesconto", "CommandButton")
607:         WITH loc_oPagina.cmd_4c_TabDesconto
608:             .Caption     = "Tabelas"
609:             .Top         = 603
610:             .Left        = 438
611:             .Width       = 62
612:             .Height      = 59
613:             .FontName    = "Tahoma"
614:             .FontSize    = 7
615:             .FontBold    = .T.
616:             .ForeColor   = RGB(90, 90, 90)
617:             .BackColor   = RGB(255, 255, 255)
618:             .Themes      = .F.
619:             .WordWrap    = .T.
620:             .SpecialEffect = 0
621:             .Visible     = .T.
622:         ENDWITH
623:         BINDEVENT(loc_oPagina.cmd_4c_TabDesconto, "Click", THIS, "BtnTabDescontoClick")
624: 
625:         *-- MontaLista (Monta Grade): left=500
626:         loc_oPagina.AddObject("cmd_4c_MontaLista", "CommandButton")
627:         WITH loc_oPagina.cmd_4c_MontaLista
628:             .Caption     = "Monta Grade"
629:             .Top         = 603
630:             .Left        = 500
631:             .Width       = 62
632:             .Height      = 59
633:             .FontName    = "Tahoma"
634:             .FontSize    = 7
635:             .FontBold    = .T.
636:             .ForeColor   = RGB(90, 90, 90)
637:             .BackColor   = RGB(255, 255, 255)
638:             .Themes      = .F.
639:             .WordWrap    = .T.
640:             .SpecialEffect = 0
641:             .Visible     = .T.
642:         ENDWITH
643:         BINDEVENT(loc_oPagina.cmd_4c_MontaLista, "Click", THIS, "BtnMontaListaClick")
644: 
645:         *-- CmdTrf (Automaticas): left=562
646:         loc_oPagina.AddObject("cmd_4c_Trf", "CommandButton")
647:         WITH loc_oPagina.cmd_4c_Trf
648:             .Caption     = "Autom" + CHR(225) + "ticas"
649:             .Top         = 603
650:             .Left        = 562
651:             .Width       = 62
652:             .Height      = 59
653:             .FontName    = "Tahoma"
654:             .FontSize    = 7
655:             .FontBold    = .T.
656:             .ForeColor   = RGB(90, 90, 90)
657:             .BackColor   = RGB(255, 255, 255)
658:             .Themes      = .F.
659:             .WordWrap    = .T.
660:             .SpecialEffect = 0
661:             .Visible     = .T.
662:         ENDWITH
663:         BINDEVENT(loc_oPagina.cmd_4c_Trf, "Click", THIS, "BtnTrfClick")
664: 
665:         *-- cmdMultiSubN (Multiplos): left=624
666:         loc_oPagina.AddObject("cmd_4c_MultiSubN", "CommandButton")
667:         WITH loc_oPagina.cmd_4c_MultiSubN
668:             .Caption     = "M" + CHR(250) + "ltiplos"
669:             .Top         = 603
670:             .Left        = 624
671:             .Width       = 62
672:             .Height      = 59
673:             .FontName    = "Tahoma"
674:             .FontSize    = 7
675:             .FontBold    = .T.
676:             .ForeColor   = RGB(90, 90, 90)
677:             .BackColor   = RGB(255, 255, 255)
678:             .Themes      = .F.
679:             .WordWrap    = .T.
680:             .SpecialEffect = 0
681:             .Visible     = .T.
682:         ENDWITH
683:         BINDEVENT(loc_oPagina.cmd_4c_MultiSubN, "Click", THIS, "BtnMultiSubNClick")
684: 
685:         *-- SubNivel2 (Subnivel +): left=686
686:         loc_oPagina.AddObject("cmd_4c_SubNivel2", "CommandButton")
687:         WITH loc_oPagina.cmd_4c_SubNivel2
688:             .Caption     = "Subn" + CHR(237) + "vel (+)"
689:             .Top         = 603
690:             .Left        = 686
691:             .Width       = 62
692:             .Height      = 59
693:             .FontName    = "Tahoma"
694:             .FontSize    = 7
695:             .FontBold    = .T.
696:             .ForeColor   = RGB(90, 90, 90)
697:             .BackColor   = RGB(255, 255, 255)
698:             .Themes      = .F.
699:             .WordWrap    = .T.
700:             .SpecialEffect = 0
701:             .Visible     = .T.
702:         ENDWITH
703:         BINDEVENT(loc_oPagina.cmd_4c_SubNivel2, "Click", THIS, "BtnSubNivel2Click")
704: 
705:         *-- Multiplas (Subnivel -): left=748
706:         loc_oPagina.AddObject("cmd_4c_Multiplas", "CommandButton")
707:         WITH loc_oPagina.cmd_4c_Multiplas
708:             .Caption     = "Subn" + CHR(237) + "vel (-)"
709:             .Top         = 603
710:             .Left        = 748
711:             .Width       = 62
712:             .Height      = 59
713:             .FontName    = "Tahoma"
714:             .FontSize    = 7
715:             .FontBold    = .T.
716:             .ForeColor   = RGB(90, 90, 90)
717:             .BackColor   = RGB(255, 255, 255)
718:             .Themes      = .F.
719:             .WordWrap    = .T.
720:             .SpecialEffect = 0
721:             .Visible     = .T.
722:         ENDWITH
723:         BINDEVENT(loc_oPagina.cmd_4c_Multiplas, "Click", THIS, "BtnMultiplasClick")
724: 
725:         *-- Ccusto (C.C.): left=810
726:         loc_oPagina.AddObject("cmd_4c_Ccusto", "CommandButton")
727:         WITH loc_oPagina.cmd_4c_Ccusto
728:             .Caption     = "C.C."
729:             .Top         = 603
730:             .Left        = 810
731:             .Width       = 62
732:             .Height      = 59
733:             .FontName    = "Tahoma"
734:             .FontSize    = 7
735:             .FontBold    = .T.
736:             .ForeColor   = RGB(90, 90, 90)
737:             .BackColor   = RGB(255, 255, 255)
738:             .Themes      = .F.
739:             .WordWrap    = .T.
740:             .SpecialEffect = 0
741:             .Visible     = .T.
742:         ENDWITH
743:         BINDEVENT(loc_oPagina.cmd_4c_Ccusto, "Click", THIS, "BtnCcustoClick")
744: 
745:         *-- GrupoConta (Grupo/Conta): left=872
746:         loc_oPagina.AddObject("cmd_4c_GrupoConta", "CommandButton")
747:         WITH loc_oPagina.cmd_4c_GrupoConta
748:             .Caption     = "Grupo/Conta"
749:             .Top         = 603
750:             .Left        = 872
751:             .Width       = 62
752:             .Height      = 59
753:             .FontName    = "Tahoma"
754:             .FontSize    = 7
755:             .FontBold    = .T.
756:             .ForeColor   = RGB(90, 90, 90)
757:             .BackColor   = RGB(255, 255, 255)
758:             .Themes      = .F.
759:             .WordWrap    = .T.
760:             .SpecialEffect = 0
761:             .Visible     = .T.
762:         ENDWITH
763:         BINDEVENT(loc_oPagina.cmd_4c_GrupoConta, "Click", THIS, "BtnGrupoContaClick")
764: 
765:         *-- Status: left=934
766:         loc_oPagina.AddObject("cmd_4c_Status", "CommandButton")
767:         WITH loc_oPagina.cmd_4c_Status
768:             .Caption     = "Status"
769:             .Top         = 603
770:             .Left        = 934
771:             .Width       = 62
772:             .Height      = 59
773:             .FontName    = "Tahoma"
774:             .FontSize    = 7
775:             .FontBold    = .T.
776:             .ForeColor   = RGB(90, 90, 90)
777:             .BackColor   = RGB(255, 255, 255)
778:             .Themes      = .F.
779:             .WordWrap    = .T.
780:             .SpecialEffect = 0
781:             .Visible     = .T.
782:         ENDWITH
783:         BINDEVENT(loc_oPagina.cmd_4c_Status, "Click", THIS, "BtnStatusClick")
784: 
785:         THIS.TornarControlesVisiveis(loc_oPagina)
786:     ENDPROC
787: 
788:     *==========================================================================
789:     * ConfigurarPaginaDados - Configura Page2: cabecalho de identificacao,
790:     *   botoes Salvar/Cancelar, PageFrame interno PagDados com 18 abas stub
791:     *==========================================================================
792:     PROTECTED PROCEDURE ConfigurarPaginaDados()
793:         LOCAL loc_oPagina
794:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
795: 
796:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
797: 
798:         *-- Container Salvar/Cancelar (legado: Grupo_Salva Top=-2, Left=840; canonico Top=27)
799:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
800:         WITH loc_oPagina.cnt_4c_Salva
801:             .Top       = 27
802:             .Left      = 840
803:             .Width     = 160
804:             .Height    = 85
805:             .BackStyle = 1
806:             .BackColor = RGB(255, 255, 255)
807:             .BorderWidth = 0
808:             .Visible   = .T.
809:         ENDWITH
810: 
811:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
812:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
813:             .Caption         = "Confirmar"
814:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
815:             .PicturePosition = 13
816:             .Top             = 5
817:             .Left            = 5
818:             .Width           = 75
819:             .Height          = 75
820:             .FontName        = "Tahoma"
821:             .FontBold        = .T.
822:             .FontItalic      = .T.
823:             .FontSize        = 8
824:             .ForeColor       = RGB(90, 90, 90)
825:             .BackColor       = RGB(255, 255, 255)
826:             .Themes          = .F.
827:             .SpecialEffect   = 0
828:             .MousePointer    = 15
829:             .WordWrap        = .T.
830:             .AutoSize        = .F.
831:             .Visible         = .T.
832:         ENDWITH
833:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
834: 
835:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
836:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
837:             .Caption         = "Encerrar"
838:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
839:             .PicturePosition = 13
840:             .Top             = 5
841:             .Left            = 80
842:             .Width           = 75
843:             .Height          = 75
844:             .FontName        = "Tahoma"
845:             .FontBold        = .T.
846:             .FontItalic      = .T.
847:             .FontSize        = 8
848:             .ForeColor       = RGB(90, 90, 90)
849:             .BackColor       = RGB(255, 255, 255)
850:             .Themes          = .F.
851:             .SpecialEffect   = 0
852:             .MousePointer    = 15
853:             .WordWrap        = .T.
854:             .AutoSize        = .F.
855:             .Visible         = .T.
856:         ENDWITH
857:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
858: 
859:         *-- Cabecalho de identificacao da operacao (acima do PagDados)
860:         *-- Legado: campos no topo da Page2 (top < 130) sem container explicito
861:         *-- Compensacao +29: tops originais + 29
862: 
863:         *-- Label "Codigo :" (Say1 legado: top=7)
864:         loc_oPagina.AddObject("lbl_4c_LCodigo", "Label")
865:         WITH loc_oPagina.lbl_4c_LCodigo
866:             .Caption   = "C" + CHR(243) + "digo :"
867:             .Top       = 36
868:             .Left      = 30
869:             .Width     = 50
870:             .Height    = 15
871:             .FontName  = "Tahoma"
872:             .FontSize  = 8
873:             .FontBold  = .T.
874:             .ForeColor = RGB(90, 90, 90)
875:             .BackStyle = 0
876:             .AutoSize  = .F.
877:             .Visible   = .T.
878:         ENDWITH
879: 
880:         *-- TextBox Codigo (Get_desc legado: top=3, left=73, width=179, height=23)
881:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
882:         WITH loc_oPagina.txt_4c_Codigo
883:             .Value         = ""
884:             .Top           = 32
885:             .Left          = 73
886:             .Width         = 179
887:             .Height        = 23
888:             .FontName      = "Tahoma"
889:             .FontSize      = 8
890:             .MaxLength     = 20
891:             .BackColor     = RGB(255, 255, 255)
892:             .ForeColor     = RGB(0, 0, 0)
893:             .BorderStyle   = 1
894:             .SpecialEffect = 0
895:             .Visible       = .T.
896:         ENDWITH
897: 

*-- Linhas 1047 a 1444:
1047:         *-- Z-ORDER: Trazer botoes Salvar/Cancelar para frente do PageFrame interno
1048:         loc_oPagina.cnt_4c_Salva.ZOrder(0)
1049: 
1050:         THIS.TornarControlesVisiveis(loc_oPagina)
1051:     ENDPROC
1052: 
1053:     *==========================================================================
1054:     * CarregarLista - Carrega cursor_4c_Dados com tipos de operacao
1055:     *==========================================================================
1056:     PROCEDURE CarregarLista()
1057:         LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nFiltroSit
1058:         loc_lResultado = .F.
1059:         loc_nFiltroSit = 1
1060: 
1061:         *-- Modo de validacao de UI: criar cursor vazio para testes sem banco
1062:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1063:             IF !USED("cursor_4c_Dados")
1064:                 SET NULL ON
1065:                 CREATE CURSOR cursor_4c_Dados (dopes C(4), titopes C(30), tipoops N(2,0), situas N(1,0), opers N(1,0))
1066:             ENDIF
1067:             RETURN .T.
1068:         ENDIF
1069: 
1070:         TRY
1071:             *-- Ler filtro de situacao se disponivel
1072:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "opt_4c_FilSituas", 5)
1073:                 loc_nFiltroSit = THIS.pgf_4c_Paginas.Page1.opt_4c_FilSituas.Value
1074:             ENDIF
1075: 
1076:             IF USED("cursor_4c_Dados")
1077:                 USE IN SELECT("cursor_4c_Dados")
1078:             ENDIF
1079: 
1080:             *-- SigCdOpe nao tem coluna emps - tabela global de configuracao
1081:             *-- Descricao em SigCdOpe: titopes char(30)
1082:             DO CASE
1083:             CASE loc_nFiltroSit = 2
1084:                 *-- Ativos: situas = 0
1085:                 loc_cSQL = "SELECT a.dopes, a.titopes, a.tipoops, a.situas, a.opers " + ;
1086:                            "FROM SigCdOpe a " + ;
1087:                            "WHERE a.situas = 0 " + ;
1088:                            "ORDER BY a.dopes"
1089:             CASE loc_nFiltroSit = 3
1090:                 *-- Inativos: situas <> 0
1091:                 loc_cSQL = "SELECT a.dopes, a.titopes, a.tipoops, a.situas, a.opers " + ;
1092:                            "FROM SigCdOpe a " + ;
1093:                            "WHERE a.situas <> 0 " + ;
1094:                            "ORDER BY a.dopes"
1095:             OTHERWISE
1096:                 *-- Todos
1097:                 loc_cSQL = "SELECT a.dopes, a.titopes, a.tipoops, a.situas, a.opers " + ;
1098:                            "FROM SigCdOpe a " + ;
1099:                            "ORDER BY a.dopes"
1100:             ENDCASE
1101: 
1102:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
1103:             IF loc_nResult < 0
1104:                 MsgErro("Erro ao carregar tipos de opera" + CHR(231) + CHR(227) + "o.", ;
1105:                     "Erro em CarregarLista")
1106:             ELSE
1107:                 IF USED("cursor_4c_Dados")
1108:                     *-- Configurar grid
1109:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1110:                         LOCAL loc_oGrid
1111:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1112:                         loc_oGrid.ColumnCount = 4
1113:                         loc_oGrid.RecordSource          = "cursor_4c_Dados"
1114:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dopes"
1115:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.titopes"
1116:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tipoops"
1117:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.situas"
1118:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1119:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1120:                         loc_oGrid.Column3.Header1.Caption = "Tipo"
1121:                         loc_oGrid.Column4.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
1122:                         THIS.FormatarGridLista(loc_oGrid)
1123:                     ENDIF
1124:                     SELECT cursor_4c_Dados
1125:                     GO TOP
1126:                 ENDIF
1127:                 loc_lResultado = .T.
1128:             ENDIF
1129: 
1130:         CATCH TO loc_oErro
1131:             MsgErro(loc_oErro.Message + CHR(13) + ;
1132:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1133:                 "Erro em CarregarLista")
1134:         ENDTRY
1135: 
1136:         RETURN loc_lResultado
1137:     ENDPROC
1138: 
1139:     *==========================================================================
1140:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1141:     *==========================================================================
1142:     PROCEDURE AlternarPagina(par_cPagina)
1143:         LOCAL loc_lResultado
1144:         loc_lResultado = .F.
1145:         TRY
1146:             *-- Suporta tanto string ("LISTA"/"DADOS") quanto numero (1/2)
1147:             IF (VARTYPE(par_cPagina) = "N" AND par_cPagina = 1) OR ;
1148:                (VARTYPE(par_cPagina) = "C" AND UPPER(ALLTRIM(par_cPagina)) = "LISTA")
1149:                 THIS.pgf_4c_Paginas.ActivePage = 1
1150:                 THIS.this_cModoAtual = "LISTA"
1151:             ELSE
1152:                 THIS.pgf_4c_Paginas.ActivePage = 2
1153:             ENDIF
1154:             loc_lResultado = .T.
1155:         CATCH TO loc_oErro
1156:             MsgErro(loc_oErro.Message + CHR(13) + ;
1157:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1158:                 "Erro em AlternarPagina")
1159:         ENDTRY
1160:         RETURN loc_lResultado
1161:     ENDPROC
1162: 
1163:     *==========================================================================
1164:     * CRUD - Handlers de clique dos botoes principais
1165:     *==========================================================================
1166:     PROCEDURE BtnIncluirClick()
1167:         LOCAL loc_lResultado
1168:         loc_lResultado = .F.
1169:         TRY
1170:             THIS.this_oBusinessObject.NovoRegistro()
1171:             THIS.this_cModoAtual = "INCLUSAO"
1172:             THIS.LimparCampos()
1173:             THIS.HabilitarCampos(.T.)
1174:             THIS.AlternarPagina("DADOS")
1175:             loc_lResultado = .T.
1176:         CATCH TO loc_oErro
1177:             MsgErro(loc_oErro.Message + CHR(13) + ;
1178:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1179:                 "Erro em BtnIncluirClick")
1180:         ENDTRY
1181:         RETURN loc_lResultado
1182:     ENDPROC
1183: 
1184:     PROCEDURE BtnAlterarClick()
1185:         *-- Fase B: implementar ValidarPreAcao + logica de alteracao
1186:         LOCAL loc_lResultado
1187:         loc_lResultado = .F.
1188:         TRY
1189:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1190:                 MsgAviso("Selecione um registro para alterar.", "Alterar")
1191:             ELSE
1192:                 THIS.this_cModoAtual = "ALTERACAO"
1193:                 THIS.BOParaForm()
1194:                 THIS.HabilitarCampos(.T.)
1195:                 THIS.AlternarPagina("DADOS")
1196:                 loc_lResultado = .T.
1197:             ENDIF
1198:         CATCH TO loc_oErro
1199:             MsgErro(loc_oErro.Message + CHR(13) + ;
1200:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1201:                 "Erro em BtnAlterarClick")
1202:         ENDTRY
1203:         RETURN loc_lResultado
1204:     ENDPROC
1205: 
1206:     PROCEDURE BtnVisualizarClick()
1207:         *-- Fase B: implementar ValidarPreAcao + logica de visualizacao
1208:         LOCAL loc_lResultado
1209:         loc_lResultado = .F.
1210:         TRY
1211:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1212:                 MsgAviso("Selecione um registro para visualizar.", "Visualizar")
1213:             ELSE
1214:                 THIS.this_cModoAtual = "VISUALIZACAO"
1215:                 THIS.BOParaForm()
1216:                 THIS.HabilitarCampos(.F.)
1217:                 THIS.AlternarPagina("DADOS")
1218:                 loc_lResultado = .T.
1219:             ENDIF
1220:         CATCH TO loc_oErro
1221:             MsgErro(loc_oErro.Message + CHR(13) + ;
1222:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1223:                 "Erro em BtnVisualizarClick")
1224:         ENDTRY
1225:         RETURN loc_lResultado
1226:     ENDPROC
1227: 
1228:     PROCEDURE BtnExcluirClick()
1229:         *-- Fase B: implementar ValidarPreAcao + logica de exclusao
1230:         LOCAL loc_lResultado, loc_lConfirma
1231:         loc_lResultado = .F.
1232:         TRY
1233:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1234:                 MsgAviso("Selecione um registro para excluir.", "Excluir")
1235:             ELSE
1236:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", "Excluir")
1237:                 IF loc_lConfirma
1238:                     IF THIS.this_oBusinessObject.Excluir()
1239:                         THIS.CarregarLista()
1240:                         loc_lResultado = .T.
1241:                     ENDIF
1242:                 ENDIF
1243:             ENDIF
1244:         CATCH TO loc_oErro
1245:             MsgErro(loc_oErro.Message + CHR(13) + ;
1246:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1247:                 "Erro em BtnExcluirClick")
1248:         ENDTRY
1249:         RETURN loc_lResultado
1250:     ENDPROC
1251: 
1252:     PROCEDURE BtnBuscarClick()
1253:         *-- Fase B: implementar busca
1254:         THIS.CarregarLista()
1255:     ENDPROC
1256: 
1257:     PROCEDURE BtnSalvarClick()
1258:         *-- Fase B: implementar FormParaBO + Inserir/Atualizar
1259:         LOCAL loc_lResultado
1260:         loc_lResultado = .F.
1261:         TRY
1262:             THIS.FormParaBO()
1263:             DO CASE
1264:             CASE THIS.this_cModoAtual = "INCLUSAO"
1265:                 loc_lResultado = THIS.this_oBusinessObject.Inserir()
1266:             CASE THIS.this_cModoAtual = "ALTERACAO"
1267:                 loc_lResultado = THIS.this_oBusinessObject.Atualizar()
1268:             ENDCASE
1269:             IF loc_lResultado
1270:                 THIS.CarregarLista()
1271:                 THIS.AlternarPagina("LISTA")
1272:             ENDIF
1273:         CATCH TO loc_oErro
1274:             MsgErro(loc_oErro.Message + CHR(13) + ;
1275:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1276:                 "Erro em BtnSalvarClick")
1277:         ENDTRY
1278:         RETURN loc_lResultado
1279:     ENDPROC
1280: 
1281:     PROCEDURE BtnCancelarClick()
1282:         *-- Fase B: implementar cancelamento
1283:         THIS.AlternarPagina("LISTA")
1284:     ENDPROC
1285: 
1286:     PROCEDURE BtnEncerrarClick()
1287:         THIS.Release()
1288:     ENDPROC
1289: 
1290:     *==========================================================================
1291:     * Handlers de eventos de grid e filtro
1292:     *==========================================================================
1293:     PROCEDURE GridAfterRowColChange(par_nColIndex)
1294:         IF THIS.this_cModoAtual = "LISTA" AND USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1295:             SELECT cursor_4c_Dados
1296:         ENDIF
1297:     ENDPROC
1298: 
1299:     PROCEDURE FiltroSituaClick()
1300:         THIS.CarregarLista()
1301:     ENDPROC
1302: 
1303:     *==========================================================================
1304:     * Botoes de acao auxiliares (stubs - Fase B)
1305:     *==========================================================================
1306:     PROCEDURE BtnExpXMLClick()
1307:         *-- Fase B: implementar exportar XML
1308:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Exportar XML (Fase B)", "Em desenvolvimento")
1309:     ENDPROC
1310: 
1311:     PROCEDURE BtnImpXMLClick()
1312:         *-- Fase B: implementar importar XML
1313:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Importar XML (Fase B)", "Em desenvolvimento")
1314:     ENDPROC
1315: 
1316:     PROCEDURE BtnCopiaClick()
1317:         *-- Fase B: implementar copiar operacao
1318:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Copiar (Fase B)", "Em desenvolvimento")
1319:     ENDPROC
1320: 
1321:     PROCEDURE BtnMapaClick()
1322:         *-- Fase B: implementar mapa
1323:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Mapa (Fase B)", "Em desenvolvimento")
1324:     ENDPROC
1325: 
1326:     PROCEDURE BtnCreditoClick()
1327:         *-- Fase B: implementar gerar creditos
1328:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Ger. Cr" + CHR(233) + "ditos (Fase B)", "Em desenvolvimento")
1329:     ENDPROC
1330: 
1331:     PROCEDURE BtnDepreciaClick()
1332:         *-- Fase B: implementar depreciacao
1333:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Deprecia" + CHR(231) + CHR(227) + "o (Fase B)", "Em desenvolvimento")
1334:     ENDPROC
1335: 
1336:     PROCEDURE BtnEtiquetasClick()
1337:         *-- Fase B: implementar etiquetas
1338:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Etiquetas (Fase B)", "Em desenvolvimento")
1339:     ENDPROC
1340: 
1341:     PROCEDURE BtnTransporteClick()
1342:         *-- Fase B: implementar transportes
1343:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Transportes (Fase B)", "Em desenvolvimento")
1344:     ENDPROC
1345: 
1346:     PROCEDURE BtnFreteClick()
1347:         *-- Fase B: implementar fretes
1348:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Fretes (Fase B)", "Em desenvolvimento")
1349:     ENDPROC
1350: 
1351:     PROCEDURE BtnCaixaClick()
1352:         *-- Fase B: implementar sequencia caixa
1353:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Sequ" + CHR(234) + "ncia Cx (Fase B)", "Em desenvolvimento")
1354:     ENDPROC
1355: 
1356:     PROCEDURE BtnTabDescontoClick()
1357:         *-- Fase B: implementar tabelas de desconto
1358:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Tabelas (Fase B)", "Em desenvolvimento")
1359:     ENDPROC
1360: 
1361:     PROCEDURE BtnMontaListaClick()
1362:         *-- Fase B: implementar monta grade
1363:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Monta Grade (Fase B)", "Em desenvolvimento")
1364:     ENDPROC
1365: 
1366:     PROCEDURE BtnTrfClick()
1367:         *-- Fase B: implementar automaticas
1368:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Autom" + CHR(225) + "ticas (Fase B)", "Em desenvolvimento")
1369:     ENDPROC
1370: 
1371:     PROCEDURE BtnMultiSubNClick()
1372:         *-- Fase B: implementar multiplos
1373:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: M" + CHR(250) + "ltiplos (Fase B)", "Em desenvolvimento")
1374:     ENDPROC
1375: 
1376:     PROCEDURE BtnSubNivel2Click()
1377:         *-- Fase B: implementar subnivel +
1378:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Subn" + CHR(237) + "vel (+) (Fase B)", "Em desenvolvimento")
1379:     ENDPROC
1380: 
1381:     PROCEDURE BtnMultiplasClick()
1382:         *-- Fase B: implementar subnivel -
1383:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Subn" + CHR(237) + "vel (-) (Fase B)", "Em desenvolvimento")
1384:     ENDPROC
1385: 
1386:     PROCEDURE BtnCcustoClick()
1387:         *-- Fase B: implementar centro de custo
1388:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: C.C. (Fase B)", "Em desenvolvimento")
1389:     ENDPROC
1390: 
1391:     PROCEDURE BtnGrupoContaClick()
1392:         *-- Fase B: implementar grupo/conta
1393:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Grupo/Conta (Fase B)", "Em desenvolvimento")
1394:     ENDPROC
1395: 
1396:     PROCEDURE BtnStatusClick()
1397:         *-- Fase B: implementar status
1398:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Status (Fase B)", "Em desenvolvimento")
1399:     ENDPROC
1400: 
1401:     *==========================================================================
1402:     * FormParaBO - Transfere dados dos campos visuais para o BO
1403:     *==========================================================================
1404:     PROTECTED PROCEDURE FormParaBO()
1405:         LOCAL loc_oPagDados, loc_oPg1, loc_oPg2, loc_oPg3, loc_oPg4, loc_oPg5, loc_oPg6, loc_oPg7, loc_oPg8, loc_oPg17
1406:         loc_oPagDados = THIS.pgf_4c_Paginas.Page2
1407:         TRY
1408:             *-- Cabecalho (Pagina Dados)
1409:             THIS.this_oBusinessObject.this_cDopes   = UPPER(ALLTRIM(loc_oPagDados.txt_4c_Codigo.Value))
1410:             THIS.this_oBusinessObject.this_cTitopes = ALLTRIM(loc_oPagDados.txt_4c_Descricao.Value)
1411:             THIS.this_oBusinessObject.this_nTipoops = ALLTRIM(loc_oPagDados.txt_4c_Tipo.Value)
1412:             IF PEMSTATUS(loc_oPagDados, "cbo_4c_Menu", 5)
1413:                 THIS.this_oBusinessObject.this_cMenus = ALLTRIM(loc_oPagDados.cbo_4c_Menu.Value)
1414:             ENDIF
1415: 
1416:             *-- Referencias das paginas internas
1417:             loc_oPg1  = loc_oPagDados.pgf_4c_PagDados.Page1
1418:             loc_oPg2  = loc_oPagDados.pgf_4c_PagDados.Page2
1419:             loc_oPg3  = loc_oPagDados.pgf_4c_PagDados.Page3
1420:             loc_oPg4  = loc_oPagDados.pgf_4c_PagDados.Page4
1421:             loc_oPg5  = loc_oPagDados.pgf_4c_PagDados.Page5
1422:             loc_oPg6  = loc_oPagDados.pgf_4c_PagDados.Page6
1423:             loc_oPg7  = loc_oPagDados.pgf_4c_PagDados.Page7
1424:             loc_oPg8  = loc_oPagDados.pgf_4c_PagDados.Page8
1425:             loc_oPg17 = loc_oPagDados.pgf_4c_PagDados.Page17
1426: 
1427:             *-- Pagina 1: Operacao
1428:             IF PEMSTATUS(loc_oPg1, "opt_4c_Blqdt", 5)
1429:                 THIS.this_oBusinessObject.this_nBlqdatas = loc_oPg1.opt_4c_Blqdt.Value
1430:             ENDIF
1431:             IF PEMSTATUS(loc_oPg1, "opt_4c_Conf", 5)
1432:                 THIS.this_oBusinessObject.this_nConfes = loc_oPg1.opt_4c_Conf.Value
1433:             ENDIF
1434:             IF PEMSTATUS(loc_oPg1, "opt_4c_Bloqueio", 5)
1435:                 THIS.this_oBusinessObject.this_nAciosens = loc_oPg1.opt_4c_Bloqueio.Value
1436:             ENDIF
1437:             IF PEMSTATUS(loc_oPg1, "txt_4c_DopeSTrfs", 5)
1438:                 THIS.this_oBusinessObject.this_cDopestrfs = ALLTRIM(loc_oPg1.txt_4c_DopeSTrfs.Value)
1439:             ENDIF
1440:             IF PEMSTATUS(loc_oPg1, "txt_4c_DopeETrfs", 5)
1441:                 THIS.this_oBusinessObject.this_cDopeetrfs = ALLTRIM(loc_oPg1.txt_4c_DopeETrfs.Value)
1442:             ENDIF
1443:             IF PEMSTATUS(loc_oPg1, "txt_4c_Central", 5)
1444:                 THIS.this_oBusinessObject.this_cCcentrals = ALLTRIM(loc_oPg1.txt_4c_Central.Value)

*-- Linhas 1450 a 1471:
1450:                 THIS.this_oBusinessObject.this_nMestoqs = IIF(loc_oPg1.chk_4c_VincEstM.Value = 1, 1, 0)
1451:             ENDIF
1452:             IF PEMSTATUS(loc_oPg1, "txt_4c_EmpPad", 5)
1453:                 THIS.this_oBusinessObject.this_cEmppads = ALLTRIM(loc_oPg1.txt_4c_EmpPad.Value)
1454:             ENDIF
1455:             IF PEMSTATUS(loc_oPg1, "opt_4c_Tipo", 5)
1456:                 THIS.this_oBusinessObject.this_nOpers = loc_oPg1.opt_4c_Tipo.Value
1457:             ENDIF
1458:             IF PEMSTATUS(loc_oPg1, "opt_4c_Cai", 5)
1459:                 THIS.this_oBusinessObject.this_nCaixas = loc_oPg1.opt_4c_Cai.Value
1460:             ENDIF
1461:             IF PEMSTATUS(loc_oPg1, "mem_4c_ObsOpe", 5)
1462:                 THIS.this_oBusinessObject.this_mObsopes = ALLTRIM(loc_oPg1.mem_4c_ObsOpe.Value)
1463:             ENDIF
1464: 
1465:             *-- Pagina 2: Itens
1466:             IF PEMSTATUS(loc_oPg2, "opt_4c_Cbar", 5)
1467:                 THIS.this_oBusinessObject.this_nCodbars = loc_oPg2.opt_4c_Cbar.Value
1468:             ENDIF
1469:             IF PEMSTATUS(loc_oPg2, "opt_4c_Imagem", 5)
1470:                 THIS.this_oBusinessObject.this_nImagems = loc_oPg2.opt_4c_Imagem.Value
1471:             ENDIF

*-- Linhas 1516 a 1537:
1516:                 THIS.this_oBusinessObject.this_cSeries = ALLTRIM(loc_oPg4.txt_4c_Series.Value)
1517:             ENDIF
1518:             IF PEMSTATUS(loc_oPg4, "txt_4c_CfoPad", 5)
1519:                 THIS.this_oBusinessObject.this_cCfos = ALLTRIM(loc_oPg4.txt_4c_CfoPad.Value)
1520:             ENDIF
1521:             IF PEMSTATUS(loc_oPg4, "opt_4c_TipoNF", 5)
1522:                 THIS.this_oBusinessObject.this_nTiponfs = loc_oPg4.opt_4c_TipoNF.Value
1523:             ENDIF
1524: 
1525:             *-- Pagina 5: Documento
1526:             IF PEMSTATUS(loc_oPg5, "opt_4c_DigDoc", 5)
1527:                 THIS.this_oBusinessObject.this_nDigdoc = loc_oPg5.opt_4c_DigDoc.Value
1528:             ENDIF
1529:             IF PEMSTATUS(loc_oPg5, "opt_4c_EditDocs", 5)
1530:                 THIS.this_oBusinessObject.this_nEditdocs = loc_oPg5.opt_4c_EditDocs.Value
1531:             ENDIF
1532: 
1533:             *-- Pagina 6: Preco
1534:             IF PEMSTATUS(loc_oPg6, "opt_4c_AltPreco", 5)
1535:                 THIS.this_oBusinessObject.this_nEprecos = loc_oPg6.opt_4c_AltPreco.Value
1536:             ENDIF
1537:             IF PEMSTATUS(loc_oPg6, "opt_4c_AltPeso", 5)

*-- Linhas 1562 a 1631:
1562:                 THIS.this_oBusinessObject.this_cGrvends = ALLTRIM(loc_oPg17.txt_4c_Grupov.Value)
1563:             ENDIF
1564:             IF PEMSTATUS(loc_oPg17, "txt_4c_MascVen", 5)
1565:                 THIS.this_oBusinessObject.this_cMascvens = ALLTRIM(loc_oPg17.txt_4c_MascVen.Value)
1566:             ENDIF
1567:             IF PEMSTATUS(loc_oPg17, "opt_4c_Vende", 5)
1568:                 THIS.this_oBusinessObject.this_nVendes = loc_oPg17.opt_4c_Vende.Value
1569:             ENDIF
1570:             IF PEMSTATUS(loc_oPg17, "opt_4c_CadCli", 5)
1571:                 THIS.this_oBusinessObject.this_nCadclis = loc_oPg17.opt_4c_CadCli.Value
1572:             ENDIF
1573: 
1574:         CATCH TO loc_oErro
1575:             MsgErro(loc_oErro.Message + CHR(13) + ;
1576:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1577:                 "Erro em FormParaBO")
1578:         ENDTRY
1579:     ENDPROC
1580: 
1581:     *==========================================================================
1582:     * BOParaForm - Transfere dados do BO para os campos visuais
1583:     *==========================================================================
1584:     PROTECTED PROCEDURE BOParaForm()
1585:         LOCAL loc_lResultado, loc_oPagDados, loc_cDopes
1586:         LOCAL loc_oPg1, loc_oPg2, loc_oPg3, loc_oPg4, loc_oPg5, loc_oPg6, loc_oPg7, loc_oPg8, loc_oPg17
1587:         LOCAL loc_oBO
1588:         loc_lResultado = .F.
1589:         loc_oPagDados = THIS.pgf_4c_Paginas.Page2
1590:         TRY
1591:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1592:                 loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)
1593:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
1594:                     loc_oBO = THIS.this_oBusinessObject
1595: 
1596:                     *-- Cabecalho
1597:                     loc_oPagDados.txt_4c_Codigo.Value    = ALLTRIM(loc_oBO.this_cDopes)
1598:                     loc_oPagDados.txt_4c_Descricao.Value = ALLTRIM(loc_oBO.this_cTitopes)
1599:                     loc_oPagDados.txt_4c_Tipo.Value      = TRANSFORM(loc_oBO.this_nTipoops)
1600:                     IF PEMSTATUS(loc_oPagDados, "cbo_4c_Menu", 5)
1601:                         loc_oPagDados.cbo_4c_Menu.Value  = ALLTRIM(loc_oBO.this_cMenus)
1602:                     ENDIF
1603: 
1604:                     loc_oPg1  = loc_oPagDados.pgf_4c_PagDados.Page1
1605:                     loc_oPg2  = loc_oPagDados.pgf_4c_PagDados.Page2
1606:                     loc_oPg3  = loc_oPagDados.pgf_4c_PagDados.Page3
1607:                     loc_oPg4  = loc_oPagDados.pgf_4c_PagDados.Page4
1608:                     loc_oPg5  = loc_oPagDados.pgf_4c_PagDados.Page5
1609:                     loc_oPg6  = loc_oPagDados.pgf_4c_PagDados.Page6
1610:                     loc_oPg7  = loc_oPagDados.pgf_4c_PagDados.Page7
1611:                     loc_oPg8  = loc_oPagDados.pgf_4c_PagDados.Page8
1612:                     loc_oPg17 = loc_oPagDados.pgf_4c_PagDados.Page17
1613: 
1614:                     *-- Pagina 1: Operacao
1615:                     IF PEMSTATUS(loc_oPg1, "opt_4c_Blqdt", 5)
1616:                         loc_oPg1.opt_4c_Blqdt.Value = IIF(loc_oBO.this_nBlqdatas > 0, loc_oBO.this_nBlqdatas, 1)
1617:                     ENDIF
1618:                     IF PEMSTATUS(loc_oPg1, "opt_4c_Conf", 5)
1619:                         loc_oPg1.opt_4c_Conf.Value = loc_oBO.this_nConfes
1620:                     ENDIF
1621:                     IF PEMSTATUS(loc_oPg1, "opt_4c_Bloqueio", 5)
1622:                         loc_oPg1.opt_4c_Bloqueio.Value = loc_oBO.this_nAciosens
1623:                     ENDIF
1624:                     IF PEMSTATUS(loc_oPg1, "txt_4c_DopeSTrfs", 5)
1625:                         loc_oPg1.txt_4c_DopeSTrfs.Value = ALLTRIM(loc_oBO.this_cDopestrfs)
1626:                     ENDIF
1627:                     IF PEMSTATUS(loc_oPg1, "txt_4c_DopeETrfs", 5)
1628:                         loc_oPg1.txt_4c_DopeETrfs.Value = ALLTRIM(loc_oBO.this_cDopeetrfs)
1629:                     ENDIF
1630:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Central", 5)
1631:                         loc_oPg1.txt_4c_Central.Value = ALLTRIM(loc_oBO.this_cCcentrals)

*-- Linhas 1637 a 1658:
1637:                         loc_oPg1.chk_4c_VincEstM.Value = IIF(loc_oBO.this_nMestoqs = 1, 1, 0)
1638:                     ENDIF
1639:                     IF PEMSTATUS(loc_oPg1, "txt_4c_EmpPad", 5)
1640:                         loc_oPg1.txt_4c_EmpPad.Value = ALLTRIM(loc_oBO.this_cEmppads)
1641:                     ENDIF
1642:                     IF PEMSTATUS(loc_oPg1, "opt_4c_Tipo", 5)
1643:                         loc_oPg1.opt_4c_Tipo.Value = IIF(loc_oBO.this_nOpers > 0, loc_oBO.this_nOpers, 1)
1644:                     ENDIF
1645:                     IF PEMSTATUS(loc_oPg1, "opt_4c_Cai", 5)
1646:                         loc_oPg1.opt_4c_Cai.Value = IIF(loc_oBO.this_nCaixas > 0, loc_oBO.this_nCaixas, 1)
1647:                     ENDIF
1648:                     IF PEMSTATUS(loc_oPg1, "mem_4c_ObsOpe", 5)
1649:                         loc_oPg1.mem_4c_ObsOpe.Value = ALLTRIM(loc_oBO.this_mObsopes)
1650:                     ENDIF
1651: 
1652:                     *-- Pagina 2: Itens
1653:                     IF PEMSTATUS(loc_oPg2, "opt_4c_Cbar", 5)
1654:                         loc_oPg2.opt_4c_Cbar.Value = IIF(loc_oBO.this_nCodbars > 0, loc_oBO.this_nCodbars, 1)
1655:                     ENDIF
1656:                     IF PEMSTATUS(loc_oPg2, "opt_4c_Imagem", 5)
1657:                         loc_oPg2.opt_4c_Imagem.Value = IIF(loc_oBO.this_nImagems > 0, loc_oBO.this_nImagems, 1)
1658:                     ENDIF

*-- Linhas 1703 a 1724:
1703:                         loc_oPg4.txt_4c_Series.Value = ALLTRIM(loc_oBO.this_cSeries)
1704:                     ENDIF
1705:                     IF PEMSTATUS(loc_oPg4, "txt_4c_CfoPad", 5)
1706:                         loc_oPg4.txt_4c_CfoPad.Value = ALLTRIM(loc_oBO.this_cCfos)
1707:                     ENDIF
1708:                     IF PEMSTATUS(loc_oPg4, "opt_4c_TipoNF", 5)
1709:                         loc_oPg4.opt_4c_TipoNF.Value = IIF(loc_oBO.this_nTiponfs > 0, loc_oBO.this_nTiponfs, 1)
1710:                     ENDIF
1711: 
1712:                     *-- Pagina 5: Documento
1713:                     IF PEMSTATUS(loc_oPg5, "opt_4c_DigDoc", 5)
1714:                         loc_oPg5.opt_4c_DigDoc.Value = IIF(loc_oBO.this_nDigdoc > 0, loc_oBO.this_nDigdoc, 1)
1715:                     ENDIF
1716:                     IF PEMSTATUS(loc_oPg5, "opt_4c_EditDocs", 5)
1717:                         loc_oPg5.opt_4c_EditDocs.Value = IIF(loc_oBO.this_nEditdocs > 0, loc_oBO.this_nEditdocs, 1)
1718:                     ENDIF
1719: 
1720:                     *-- Pagina 6: Preco
1721:                     IF PEMSTATUS(loc_oPg6, "opt_4c_AltPreco", 5)
1722:                         loc_oPg6.opt_4c_AltPreco.Value = IIF(loc_oBO.this_nEprecos > 0, loc_oBO.this_nEprecos, 1)
1723:                     ENDIF
1724:                     IF PEMSTATUS(loc_oPg6, "opt_4c_AltPeso", 5)

*-- Linhas 1749 a 2114:
1749:                         loc_oPg17.txt_4c_Grupov.Value = ALLTRIM(loc_oBO.this_cGrvends)
1750:                     ENDIF
1751:                     IF PEMSTATUS(loc_oPg17, "txt_4c_MascVen", 5)
1752:                         loc_oPg17.txt_4c_MascVen.Value = ALLTRIM(loc_oBO.this_cMascvens)
1753:                     ENDIF
1754:                     IF PEMSTATUS(loc_oPg17, "opt_4c_Vende", 5)
1755:                         loc_oPg17.opt_4c_Vende.Value = IIF(loc_oBO.this_nVendes > 0, loc_oBO.this_nVendes, 1)
1756:                     ENDIF
1757:                     IF PEMSTATUS(loc_oPg17, "opt_4c_CadCli", 5)
1758:                         loc_oPg17.opt_4c_CadCli.Value = IIF(loc_oBO.this_nCadclis > 0, loc_oBO.this_nCadclis, 1)
1759:                     ENDIF
1760: 
1761:                     loc_lResultado = .T.
1762:                 ENDIF
1763:             ENDIF
1764:         CATCH TO loc_oErro
1765:             MsgErro(loc_oErro.Message + CHR(13) + ;
1766:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1767:                 "Erro em BOParaForm")
1768:         ENDTRY
1769:         RETURN loc_lResultado
1770:     ENDPROC
1771: 
1772:     *==========================================================================
1773:     * HabilitarCampos - Habilita/desabilita edicao dos campos
1774:     *==========================================================================
1775:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1776:         LOCAL loc_oPagDados
1777:         loc_oPagDados = THIS.pgf_4c_Paginas.Page2
1778:         TRY
1779:             loc_oPagDados.txt_4c_Codigo.ReadOnly    = !par_lHabilitar
1780:             loc_oPagDados.txt_4c_Descricao.ReadOnly = !par_lHabilitar
1781:             loc_oPagDados.txt_4c_Tipo.ReadOnly       = !par_lHabilitar
1782:             IF PEMSTATUS(loc_oPagDados, "cbo_4c_Menu", 5)
1783:                 loc_oPagDados.cbo_4c_Menu.Enabled = par_lHabilitar
1784:             ENDIF
1785:             *-- Habilitar recursivamente todos os controles das paginas internas
1786:             IF PEMSTATUS(loc_oPagDados, "pgf_4c_PagDados", 5)
1787:                 THIS.HabilitarControlesRecursivo(loc_oPagDados.pgf_4c_PagDados, par_lHabilitar)
1788:             ENDIF
1789:         CATCH TO loc_oErro
1790:             MsgErro(loc_oErro.Message + CHR(13) + ;
1791:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1792:                 "Erro em HabilitarCampos")
1793:         ENDTRY
1794:     ENDPROC
1795: 
1796:     *==========================================================================
1797:     * HabilitarControlesRecursivo - Percorre recursivamente e ajusta ReadOnly/Enabled
1798:     *==========================================================================
1799:     PROTECTED PROCEDURE HabilitarControlesRecursivo(par_oContainer, par_lHabilitar)
1800:         LOCAL loc_nI, loc_oObj, loc_nP, loc_cCls
1801:         *-- PageFrame usa Pages(N)/PageCount, nao Controls(N)/ControlCount
1802:         IF UPPER(par_oContainer.BaseClass) = "PAGEFRAME"
1803:             FOR loc_nP = 1 TO par_oContainer.PageCount
1804:                 THIS.HabilitarControlesRecursivo(par_oContainer.Pages(loc_nP), par_lHabilitar)
1805:             ENDFOR
1806:             RETURN
1807:         ENDIF
1808:         IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
1809:             RETURN
1810:         ENDIF
1811:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1812:             loc_oObj = par_oContainer.Controls(loc_nI)
1813:             IF VARTYPE(loc_oObj) = "O"
1814:                 loc_cCls = UPPER(loc_oObj.BaseClass)
1815:                 DO CASE
1816:                 CASE loc_cCls = "TEXTBOX" OR loc_cCls = "EDITBOX"
1817:                     IF PEMSTATUS(loc_oObj, "ReadOnly", 5)
1818:                         loc_oObj.ReadOnly = !par_lHabilitar
1819:                     ENDIF
1820:                 CASE loc_cCls = "CHECKBOX" OR loc_cCls = "OPTIONGROUP" OR loc_cCls = "COMBOBOX" OR loc_cCls = "SPINNER"
1821:                     IF PEMSTATUS(loc_oObj, "Enabled", 5)
1822:                         loc_oObj.Enabled = par_lHabilitar
1823:                     ENDIF
1824:                 CASE loc_cCls = "PAGEFRAME"
1825:                     FOR loc_nP = 1 TO loc_oObj.PageCount
1826:                         THIS.HabilitarControlesRecursivo(loc_oObj.Pages(loc_nP), par_lHabilitar)
1827:                     ENDFOR
1828:                 CASE loc_cCls = "CONTAINER"
1829:                     THIS.HabilitarControlesRecursivo(loc_oObj, par_lHabilitar)
1830:                 ENDCASE
1831:             ENDIF
1832:         ENDFOR
1833:     ENDPROC
1834: 
1835:     *==========================================================================
1836:     * LimparCampos - Limpa todos os campos de edicao
1837:     *==========================================================================
1838:     PROTECTED PROCEDURE LimparCampos()
1839:         LOCAL loc_oPagDados
1840:         loc_oPagDados = THIS.pgf_4c_Paginas.Page2
1841:         TRY
1842:             loc_oPagDados.txt_4c_Codigo.Value    = ""
1843:             loc_oPagDados.txt_4c_Descricao.Value = ""
1844:             loc_oPagDados.txt_4c_Tipo.Value      = "0"
1845:             IF PEMSTATUS(loc_oPagDados, "cbo_4c_Menu", 5)
1846:                 loc_oPagDados.cbo_4c_Menu.Value = ""
1847:             ENDIF
1848:             *-- Limpar todos os controles das paginas internas
1849:             IF PEMSTATUS(loc_oPagDados, "pgf_4c_PagDados", 5)
1850:                 THIS.LimparControlesRecursivo(loc_oPagDados.pgf_4c_PagDados)
1851:             ENDIF
1852:         CATCH TO loc_oErro
1853:             MsgErro(loc_oErro.Message + CHR(13) + ;
1854:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1855:                 "Erro em LimparCampos")
1856:         ENDTRY
1857:     ENDPROC
1858: 
1859:     *==========================================================================
1860:     * LimparControlesRecursivo - Reset de todos controles a defaults
1861:     *==========================================================================
1862:     PROTECTED PROCEDURE LimparControlesRecursivo(par_oContainer)
1863:         LOCAL loc_nI, loc_oObj, loc_nP, loc_cCls
1864:         *-- PageFrame usa Pages(N)/PageCount, nao Controls(N)/ControlCount
1865:         IF UPPER(par_oContainer.BaseClass) = "PAGEFRAME"
1866:             FOR loc_nP = 1 TO par_oContainer.PageCount
1867:                 THIS.LimparControlesRecursivo(par_oContainer.Pages(loc_nP))
1868:             ENDFOR
1869:             RETURN
1870:         ENDIF
1871:         IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
1872:             RETURN
1873:         ENDIF
1874:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1875:             loc_oObj = par_oContainer.Controls(loc_nI)
1876:             IF VARTYPE(loc_oObj) = "O"
1877:                 loc_cCls = UPPER(loc_oObj.BaseClass)
1878:                 DO CASE
1879:                 CASE loc_cCls = "TEXTBOX" OR loc_cCls = "EDITBOX"
1880:                     IF PEMSTATUS(loc_oObj, "Value", 5)
1881:                         IF VARTYPE(loc_oObj.Value) = "N"
1882:                             loc_oObj.Value = 0
1883:                         ELSE
1884:                             loc_oObj.Value = ""
1885:                         ENDIF
1886:                     ENDIF
1887:                 CASE loc_cCls = "CHECKBOX"
1888:                     loc_oObj.Value = 0
1889:                 CASE loc_cCls = "OPTIONGROUP"
1890:                     loc_oObj.Value = 1
1891:                 CASE loc_cCls = "COMBOBOX"
1892:                     loc_oObj.Value = ""
1893:                 CASE loc_cCls = "SPINNER"
1894:                     loc_oObj.Value = 0
1895:                 CASE loc_cCls = "PAGEFRAME"
1896:                     FOR loc_nP = 1 TO loc_oObj.PageCount
1897:                         THIS.LimparControlesRecursivo(loc_oObj.Pages(loc_nP))
1898:                     ENDFOR
1899:                 CASE loc_cCls = "CONTAINER"
1900:                     THIS.LimparControlesRecursivo(loc_oObj)
1901:                 ENDCASE
1902:             ENDIF
1903:         ENDFOR
1904:     ENDPROC
1905: 
1906:     *==========================================================================
1907:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1908:     *==========================================================================
1909:     PROCEDURE AjustarBotoesPorModo(par_cModo)
1910:         LOCAL loc_lHabilitar, loc_lModoEdicao
1911:         loc_lHabilitar = .T.
1912:         loc_lModoEdicao = (THIS.this_cModoAtual = "INCLUSAO" OR THIS.this_cModoAtual = "ALTERACAO")
1913:         IF VARTYPE(par_cModo) = "C" AND !EMPTY(par_cModo)
1914:             loc_lModoEdicao = (par_cModo = "INCLUSAO" OR par_cModo = "ALTERACAO")
1915:         ENDIF
1916:         *-- Habilitar/desabilitar campos conforme modo
1917:         THIS.HabilitarCampos(loc_lModoEdicao)
1918:     ENDPROC
1919: 
1920:     *==========================================================================
1921:     * Destroy - Liberacao de recursos
1922:     *==========================================================================
1923:     PROCEDURE Destroy()
1924:         IF USED("cursor_4c_Dados")
1925:             USE IN SELECT("cursor_4c_Dados")
1926:         ENDIF
1927:         DODEFAULT()
1928:     ENDPROC
1929: 
1930: 
1931:     *--------------------------------------------------------------------------
1932:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1933:     *--------------------------------------------------------------------------
1934:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1935:         LOCAL loc_nI, loc_oObjeto, loc_nP
1936: 
1937:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1938:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1939: 
1940:             IF VARTYPE(loc_oObjeto) = "O"
1941:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1942:                     loc_oObjeto.Visible = .T.
1943:                 ENDIF
1944: 
1945:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1946:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1947:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1948:                     ENDFOR
1949:                 ENDIF
1950: 
1951:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1952:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1953:                 ENDIF
1954:             ENDIF
1955:         ENDFOR
1956:     ENDPROC
1957: 
1958:     *--------------------------------------------------------------------------
1959:     * FormatarGridLista - Formata visual do grid da lista
1960:     *--------------------------------------------------------------------------
1961:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1962:         WITH par_oGrid
1963:             IF .ColumnCount > 0
1964:                 .FontName = "Tahoma"
1965:                 .FontSize = 8
1966:             ENDIF
1967:         ENDWITH
1968:     ENDPROC
1969: 
1970:     *==========================================================================
1971:     * Helpers de criacao rapida (reduzem verbosidade)
1972:     *==========================================================================
1973:     PROTECTED PROCEDURE AddLabel(par_oPag, par_cName, par_cCaption, par_nTop, par_nLeft, par_nWidth)
1974:         par_oPag.AddObject(par_cName, "Label")
1975:         WITH EVALUATE("par_oPag." + par_cName)
1976:             .Caption   = par_cCaption
1977:             .Top       = par_nTop
1978:             .Left      = par_nLeft
1979:             .Width     = par_nWidth
1980:             .Height    = 15
1981:             .FontName  = "Tahoma"
1982:             .FontSize  = 8
1983:             .BackStyle = 0
1984:             .ForeColor = RGB(90, 90, 90)
1985:             .AutoSize  = .F.
1986:             .Visible   = .T.
1987:         ENDWITH
1988:     ENDPROC
1989: 
1990:     PROTECTED PROCEDURE AddTextBox(par_oPag, par_cName, par_nTop, par_nLeft, par_nWidth, par_nMaxLen)
1991:         par_oPag.AddObject(par_cName, "TextBox")
1992:         WITH EVALUATE("par_oPag." + par_cName)
1993:             .Value         = ""
1994:             .Top           = par_nTop
1995:             .Left          = par_nLeft
1996:             .Width         = par_nWidth
1997:             .Height        = 20
1998:             .FontName      = "Tahoma"
1999:             .FontSize      = 8
2000:             .MaxLength     = par_nMaxLen
2001:             .BackColor     = RGB(255, 255, 255)
2002:             .ForeColor     = RGB(0, 0, 0)
2003:             .BorderStyle   = 1
2004:             .SpecialEffect = 1
2005:             .Visible       = .T.
2006:         ENDWITH
2007:     ENDPROC
2008: 
2009:     PROTECTED PROCEDURE AddCheckBox(par_oPag, par_cName, par_cCaption, par_nTop, par_nLeft, par_nWidth)
2010:         par_oPag.AddObject(par_cName, "CheckBox")
2011:         WITH EVALUATE("par_oPag." + par_cName)
2012:             .Caption   = par_cCaption
2013:             .Top       = par_nTop
2014:             .Left      = par_nLeft
2015:             .Width     = par_nWidth
2016:             .Height    = 17
2017:             .FontName  = "Tahoma"
2018:             .FontSize  = 8
2019:             .BackStyle = 0
2020:             .ForeColor = RGB(90, 90, 90)
2021:             .AutoSize  = .F.
2022:             .Value     = 0
2023:             .Visible   = .T.
2024:         ENDWITH
2025:     ENDPROC
2026: 
2027:     PROTECTED PROCEDURE AddOptGroupSN(par_oPag, par_cName, par_nTop, par_nLeft, par_nWidth)
2028:         *-- Cria OptionGroup padrao "Sim / Nao" (2 botoes horizontais)
2029:         par_oPag.AddObject(par_cName, "OptionGroup")
2030:         WITH EVALUATE("par_oPag." + par_cName)
2031:             .ButtonCount   = 2
2032:             .BackStyle     = 0
2033:             .BorderStyle   = 1
2034:             .SpecialEffect = 1
2035:             .Top           = par_nTop
2036:             .Left          = par_nLeft
2037:             .Width         = par_nWidth
2038:             .Height        = 22
2039:             .Value         = 1
2040:             .Themes        = .F.
2041:             .Buttons(1).Caption   = "Sim"
2042:             .Buttons(1).FontName  = "Tahoma"
2043:             .Buttons(1).FontSize  = 8
2044:             .Buttons(1).BackStyle = 0
2045:             .Buttons(1).Top       = 3
2046:             .Buttons(1).Left      = 5
2047:             .Buttons(1).Width     = 45
2048:             .Buttons(1).Height    = 17
2049:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2050:             .Buttons(1).AutoSize  = .F.
2051:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2052:             .Buttons(2).FontName  = "Tahoma"
2053:             .Buttons(2).FontSize  = 8
2054:             .Buttons(2).BackStyle = 0
2055:             .Buttons(2).Top       = 3
2056:             .Buttons(2).Left      = 60
2057:             .Buttons(2).Width     = 45
2058:             .Buttons(2).Height    = 17
2059:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2060:             .Buttons(2).AutoSize  = .F.
2061:             .Visible = .T.
2062:         ENDWITH
2063:     ENDPROC
2064: 
2065:     *==========================================================================
2066:     * ConfigurarPagOperacao - Popula Page1 (Operacao) do PageFrame interno
2067:     *==========================================================================
2068:     PROTECTED PROCEDURE ConfigurarPagOperacao(par_oPagina)
2069:         TRY
2070:             *-- Numeracao label
2071:             THIS.AddLabel(par_oPagina, "lbl_4c_Numeracao", "Numera" + CHR(231) + CHR(227) + "o :", 11, 78, 63)
2072:             *-- Bloqueio de alterar data (OptionGroup 4 botoes)
2073:             THIS.AddLabel(par_oPagina, "lbl_4c_BlqDt", "Bloq. Alterar Data :", 45, 46, 95)
2074:             par_oPagina.AddObject("opt_4c_Blqdt", "OptionGroup")
2075:             WITH par_oPagina.opt_4c_Blqdt
2076:                 .ButtonCount   = 4
2077:                 .BackStyle     = 0
2078:                 .BorderStyle   = 1
2079:                 .SpecialEffect = 1
2080:                 .Top           = 43
2081:                 .Left          = 145
2082:                 .Width         = 248
2083:                 .Height        = 32
2084:                 .Value         = 1
2085:                 .Themes        = .F.
2086:                 .Buttons(1).Caption = "Sim"
2087:                 .Buttons(1).Value   = 1
2088:                 .Buttons(1).Top     = 2
2089:                 .Buttons(1).Left    = 5
2090:                 .Buttons(1).Width   = 40
2091:                 .Buttons(1).Height  = 17
2092:                 .Buttons(1).BackStyle = 0
2093:                 .Buttons(1).FontName  = "Tahoma"
2094:                 .Buttons(1).FontSize  = 8
2095:                 .Buttons(1).ForeColor = RGB(90, 90, 90)
2096:                 .Buttons(1).AutoSize  = .F.
2097:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
2098:                 .Buttons(2).Top     = 15
2099:                 .Buttons(2).Left    = 5
2100:                 .Buttons(2).Width   = 40
2101:                 .Buttons(2).Height  = 17
2102:                 .Buttons(2).BackStyle = 0
2103:                 .Buttons(2).FontName  = "Tahoma"
2104:                 .Buttons(2).FontSize  = 8
2105:                 .Buttons(2).ForeColor = RGB(90, 90, 90)
2106:                 .Buttons(2).AutoSize  = .F.
2107:                 .Buttons(3).Caption = "Subn" + CHR(237) + "vel Sim"
2108:                 .Buttons(3).Top     = 2
2109:                 .Buttons(3).Left    = 110
2110:                 .Buttons(3).Width   = 100
2111:                 .Buttons(3).Height  = 15
2112:                 .Buttons(3).BackStyle = 0
2113:                 .Buttons(3).FontName  = "Tahoma"
2114:                 .Buttons(3).FontSize  = 8

*-- Linhas 2155 a 2200:
2155:             THIS.AddCheckBox(par_oPagina, "chk_4c_CarESubN", "Carregar E-Subn" + CHR(237) + "vel", 415, 145, 180)
2156:             THIS.AddCheckBox(par_oPagina, "chk_4c_VincEstM", "Vincular Est. Mestre", 435, 145, 180)
2157: 
2158:             *-- Tipo (Opers)
2159:             THIS.AddLabel(par_oPagina, "lbl_4c_Tipo1", "Tipo :", 460, 100, 45)
2160:             par_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
2161:             WITH par_oPagina.opt_4c_Tipo
2162:                 .ButtonCount   = 3
2163:                 .BackStyle     = 0
2164:                 .BorderStyle   = 1
2165:                 .SpecialEffect = 1
2166:                 .Top           = 458
2167:                 .Left          = 145
2168:                 .Width         = 250
2169:                 .Height        = 22
2170:                 .Value         = 1
2171:                 .Themes        = .F.
2172:                 .Buttons(1).Caption = "Sa" + CHR(237) + "da"
2173:                 .Buttons(1).Value   = 1
2174:                 .Buttons(1).Top     = 3
2175:                 .Buttons(1).Left    = 5
2176:                 .Buttons(1).Width   = 60
2177:                 .Buttons(1).BackStyle = 0
2178:                 .Buttons(1).FontName  = "Tahoma"
2179:                 .Buttons(1).FontSize  = 8
2180:                 .Buttons(1).ForeColor = RGB(90, 90, 90)
2181:                 .Buttons(2).Caption = "Entrada"
2182:                 .Buttons(2).Top     = 3
2183:                 .Buttons(2).Left    = 70
2184:                 .Buttons(2).Width   = 60
2185:                 .Buttons(2).BackStyle = 0
2186:                 .Buttons(2).FontName  = "Tahoma"
2187:                 .Buttons(2).FontSize  = 8
2188:                 .Buttons(2).ForeColor = RGB(90, 90, 90)
2189:                 .Buttons(3).Caption = "Nenhum"
2190:                 .Buttons(3).Top     = 3
2191:                 .Buttons(3).Left    = 140
2192:                 .Buttons(3).Width   = 60
2193:                 .Buttons(3).BackStyle = 0
2194:                 .Buttons(3).FontName  = "Tahoma"
2195:                 .Buttons(3).FontSize  = 8
2196:                 .Buttons(3).ForeColor = RGB(90, 90, 90)
2197:                 .Visible = .T.
2198:             ENDWITH
2199: 
2200:             *-- Caixa

*-- Linhas 2229 a 2475:
2229:     *==========================================================================
2230:     * ConfigurarPagItens - Popula Page2 (Itens)
2231:     *==========================================================================
2232:     PROTECTED PROCEDURE ConfigurarPagItens(par_oPagina)
2233:         TRY
2234:             THIS.AddLabel(par_oPagina, "lbl_4c_CBar", "C" + CHR(243) + "d. Barras :", 20, 30, 80)
2235:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Cbar", 18, 120, 120)
2236: 
2237:             THIS.AddLabel(par_oPagina, "lbl_4c_Imagem", "Imagem :", 50, 30, 80)
2238:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Imagem", 48, 120, 120)
2239: 
2240:             THIS.AddLabel(par_oPagina, "lbl_4c_ObsItems", "Obs. Itens :", 80, 30, 80)
2241:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_ObsItems", 78, 120, 120)
2242: 
2243:             THIS.AddLabel(par_oPagina, "lbl_4c_Desmemb", "Desmembra :", 110, 30, 80)
2244:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Desmemb", 108, 120, 120)
2245: 
2246:             THIS.AddLabel(par_oPagina, "lbl_4c_ChkQtds", "Check Qtd :", 140, 30, 80)
2247:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_ChkQtds", 138, 120, 120)
2248: 
2249:             THIS.AddLabel(par_oPagina, "lbl_4c_QtdIte", "Qtde. Itens :", 175, 30, 80)
2250:             THIS.AddTextBox(par_oPagina, "txt_4c_QtdIte", 172, 120, 60, 4)
2251: 
2252:         CATCH TO loc_oErro
2253:             MsgErro(loc_oErro.Message + CHR(13) + ;
2254:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2255:                 "Erro em ConfigurarPagItens")
2256:         ENDTRY
2257:     ENDPROC
2258: 
2259:     *==========================================================================
2260:     * ConfigurarPagFinanceiro - Popula Page3 (Financeiro)
2261:     *==========================================================================
2262:     PROTECTED PROCEDURE ConfigurarPagFinanceiro(par_oPagina)
2263:         TRY
2264:             THIS.AddLabel(par_oPagina, "lbl_4c_Che", "Cheque :", 20, 30, 80)
2265:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Che", 18, 120, 120)
2266: 
2267:             THIS.AddLabel(par_oPagina, "lbl_4c_Contas", "Contas :", 50, 30, 80)
2268:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Contas", 48, 120, 120)
2269: 
2270:             THIS.AddLabel(par_oPagina, "lbl_4c_LimCre", "Lim. Cr" + CHR(233) + "dito :", 80, 30, 80)
2271:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_LimCre", 78, 120, 120)
2272: 
2273:             THIS.AddLabel(par_oPagina, "lbl_4c_Troco", "Troco Auto :", 110, 30, 80)
2274:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Troco", 108, 120, 120)
2275: 
2276:             THIS.AddLabel(par_oPagina, "lbl_4c_OpChqEnt", "Op. Cheq. Entr. :", 145, 30, 100)
2277:             THIS.AddTextBox(par_oPagina, "txt_4c_OpChqEnt", 142, 145, 150, 15)
2278: 
2279:             THIS.AddLabel(par_oPagina, "lbl_4c_OpChqSai", "Op. Cheq. Sa" + CHR(237) + "da :", 175, 30, 100)
2280:             THIS.AddTextBox(par_oPagina, "txt_4c_OpChqSai", 172, 145, 150, 15)
2281: 
2282:             THIS.AddLabel(par_oPagina, "lbl_4c_Conta", "Conta :", 205, 30, 60)
2283:             THIS.AddTextBox(par_oPagina, "txt_4c_Conta", 202, 145, 100, 10)
2284: 
2285:             THIS.AddLabel(par_oPagina, "lbl_4c_Grupo", "Grupo :", 235, 30, 60)
2286:             THIS.AddTextBox(par_oPagina, "txt_4c_Grupo", 232, 145, 100, 10)
2287: 
2288:         CATCH TO loc_oErro
2289:             MsgErro(loc_oErro.Message + CHR(13) + ;
2290:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2291:                 "Erro em ConfigurarPagFinanceiro")
2292:         ENDTRY
2293:     ENDPROC
2294: 
2295:     *==========================================================================
2296:     * ConfigurarPagFiscal - Popula Page4 (Fiscal)
2297:     *==========================================================================
2298:     PROTECTED PROCEDURE ConfigurarPagFiscal(par_oPagina)
2299:         TRY
2300:             THIS.AddLabel(par_oPagina, "lbl_4c_Especies", "Esp" + CHR(233) + "cie :", 20, 30, 60)
2301:             THIS.AddTextBox(par_oPagina, "txt_4c_Especies", 17, 120, 80, 6)
2302: 
2303:             THIS.AddLabel(par_oPagina, "lbl_4c_Series", "S" + CHR(233) + "rie :", 50, 30, 60)
2304:             THIS.AddTextBox(par_oPagina, "txt_4c_Series", 47, 120, 80, 3)
2305: 
2306:             THIS.AddLabel(par_oPagina, "lbl_4c_CfoPad", "CFO Padr" + CHR(227) + "o :", 80, 30, 80)
2307:             THIS.AddTextBox(par_oPagina, "txt_4c_CfoPad", 77, 120, 100, 10)
2308: 
2309:             THIS.AddLabel(par_oPagina, "lbl_4c_TipoNF", "Tipo NF :", 110, 30, 60)
2310:             par_oPagina.AddObject("opt_4c_TipoNF", "OptionGroup")
2311:             WITH par_oPagina.opt_4c_TipoNF
2312:                 .ButtonCount   = 3
2313:                 .BackStyle     = 0
2314:                 .BorderStyle   = 1
2315:                 .SpecialEffect = 1
2316:                 .Top           = 108
2317:                 .Left          = 120
2318:                 .Width         = 260
2319:                 .Height        = 22
2320:                 .Value         = 1
2321:                 .Themes        = .F.
2322:                 .Buttons(1).Caption = "Entrada"
2323:                 .Buttons(1).Top     = 3
2324:                 .Buttons(1).Left    = 5
2325:                 .Buttons(1).Width   = 70
2326:                 .Buttons(1).BackStyle = 0
2327:                 .Buttons(1).FontName  = "Tahoma"
2328:                 .Buttons(1).FontSize  = 8
2329:                 .Buttons(2).Caption = "Sa" + CHR(237) + "da"
2330:                 .Buttons(2).Top     = 3
2331:                 .Buttons(2).Left    = 80
2332:                 .Buttons(2).Width   = 70
2333:                 .Buttons(2).BackStyle = 0
2334:                 .Buttons(2).FontName  = "Tahoma"
2335:                 .Buttons(2).FontSize  = 8
2336:                 .Buttons(3).Caption = "Nenhum"
2337:                 .Buttons(3).Top     = 3
2338:                 .Buttons(3).Left    = 155
2339:                 .Buttons(3).Width   = 70
2340:                 .Buttons(3).BackStyle = 0
2341:                 .Buttons(3).FontName  = "Tahoma"
2342:                 .Buttons(3).FontSize  = 8
2343:                 .Visible = .T.
2344:             ENDWITH
2345: 
2346:         CATCH TO loc_oErro
2347:             MsgErro(loc_oErro.Message + CHR(13) + ;
2348:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2349:                 "Erro em ConfigurarPagFiscal")
2350:         ENDTRY
2351:     ENDPROC
2352: 
2353:     *==========================================================================
2354:     * ConfigurarPagDocumento - Popula Page5 (Documento)
2355:     *==========================================================================
2356:     PROTECTED PROCEDURE ConfigurarPagDocumento(par_oPagina)
2357:         TRY
2358:             THIS.AddLabel(par_oPagina, "lbl_4c_DigDoc", "Digita Doc :", 20, 30, 80)
2359:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_DigDoc", 18, 120, 120)
2360: 
2361:             THIS.AddLabel(par_oPagina, "lbl_4c_EditDocs", "Editar Docs :", 50, 30, 80)
2362:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_EditDocs", 48, 120, 120)
2363: 
2364:         CATCH TO loc_oErro
2365:             MsgErro(loc_oErro.Message + CHR(13) + ;
2366:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2367:                 "Erro em ConfigurarPagDocumento")
2368:         ENDTRY
2369:     ENDPROC
2370: 
2371:     *==========================================================================
2372:     * ConfigurarPagPreco - Popula Page6 (Preco)
2373:     *==========================================================================
2374:     PROTECTED PROCEDURE ConfigurarPagPreco(par_oPagina)
2375:         TRY
2376:             THIS.AddLabel(par_oPagina, "lbl_4c_AltPreco", "Altera Pre" + CHR(231) + "o :", 20, 30, 100)
2377:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_AltPreco", 18, 140, 120)
2378: 
2379:             THIS.AddLabel(par_oPagina, "lbl_4c_AltPeso", "Altera Peso :", 50, 30, 100)
2380:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_AltPeso", 48, 140, 120)
2381: 
2382:             THIS.AddLabel(par_oPagina, "lbl_4c_LPrecoPad", "Lista Pre" + CHR(231) + "o Padr" + CHR(227) + "o :", 80, 30, 120)
2383:             THIS.AddTextBox(par_oPagina, "txt_4c_LPrecoPad", 77, 155, 200, 30)
2384: 
2385:         CATCH TO loc_oErro
2386:             MsgErro(loc_oErro.Message + CHR(13) + ;
2387:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2388:                 "Erro em ConfigurarPagPreco")
2389:         ENDTRY
2390:     ENDPROC
2391: 
2392:     *==========================================================================
2393:     * ConfigurarPagDiv - Popula Page7 (Div)
2394:     *==========================================================================
2395:     PROTECTED PROCEDURE ConfigurarPagDiv(par_oPagina)
2396:         TRY
2397:             THIS.AddLabel(par_oPagina, "lbl_4c_DivVar", "Var. Div. :", 20, 30, 80)
2398:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_DivVar", 18, 120, 120)
2399: 
2400:         CATCH TO loc_oErro
2401:             MsgErro(loc_oErro.Message + CHR(13) + ;
2402:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2403:                 "Erro em ConfigurarPagDiv")
2404:         ENDTRY
2405:     ENDPROC
2406: 
2407:     *==========================================================================
2408:     * ConfigurarPagDiversos - Popula Page8 (Diversos)
2409:     *==========================================================================
2410:     PROTECTED PROCEDURE ConfigurarPagDiversos(par_oPagina)
2411:         TRY
2412:             THIS.AddCheckBox(par_oPagina, "chk_4c_Digenves", "Digitar Envelope", 20, 30, 200)
2413:             THIS.AddCheckBox(par_oPagina, "chk_4c_Digrecs", "Digitar Recebimento", 45, 30, 200)
2414: 
2415:         CATCH TO loc_oErro
2416:             MsgErro(loc_oErro.Message + CHR(13) + ;
2417:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2418:                 "Erro em ConfigurarPagDiversos")
2419:         ENDTRY
2420:     ENDPROC
2421: 
2422:     *==========================================================================
2423:     * ConfigurarPagComissao - Popula Page17 (Comissao)
2424:     *==========================================================================
2425:     PROTECTED PROCEDURE ConfigurarPagComissao(par_oPagina)
2426:         TRY
2427:             THIS.AddCheckBox(par_oPagina, "chk_4c_Grupov", "Fixar Grupo Vend.", 20, 30, 180)
2428:             THIS.AddLabel(par_oPagina, "lbl_4c_Grupov", "Grupo Vend. :", 45, 30, 90)
2429:             THIS.AddTextBox(par_oPagina, "txt_4c_Grupov", 42, 130, 120, 20)
2430: 
2431:             THIS.AddLabel(par_oPagina, "lbl_4c_MascVen", "M" + CHR(225) + "scara Vend. :", 75, 30, 90)
2432:             THIS.AddTextBox(par_oPagina, "txt_4c_MascVen", 72, 130, 120, 20)
2433: 
2434:             THIS.AddLabel(par_oPagina, "lbl_4c_Vende", "Vendedor :", 105, 30, 80)
2435:             par_oPagina.AddObject("opt_4c_Vende", "OptionGroup")
2436:             WITH par_oPagina.opt_4c_Vende
2437:                 .ButtonCount   = 3
2438:                 .BackStyle     = 0
2439:                 .BorderStyle   = 1
2440:                 .SpecialEffect = 1
2441:                 .Top           = 103
2442:                 .Left          = 130
2443:                 .Width         = 260
2444:                 .Height        = 22
2445:                 .Value         = 1
2446:                 .Themes        = .F.
2447:                 .Buttons(1).Caption = "Obrigat" + CHR(243) + "rio"
2448:                 .Buttons(1).Top     = 3
2449:                 .Buttons(1).Left    = 5
2450:                 .Buttons(1).Width   = 80
2451:                 .Buttons(1).BackStyle = 0
2452:                 .Buttons(1).FontName  = "Tahoma"
2453:                 .Buttons(1).FontSize  = 8
2454:                 .Buttons(2).Caption = "Opcional"
2455:                 .Buttons(2).Top     = 3
2456:                 .Buttons(2).Left    = 90
2457:                 .Buttons(2).Width   = 70
2458:                 .Buttons(2).BackStyle = 0
2459:                 .Buttons(2).FontName  = "Tahoma"
2460:                 .Buttons(2).FontSize  = 8
2461:                 .Buttons(3).Caption = "N" + CHR(227) + "o"
2462:                 .Buttons(3).Top     = 3
2463:                 .Buttons(3).Left    = 165
2464:                 .Buttons(3).Width   = 50
2465:                 .Buttons(3).BackStyle = 0
2466:                 .Buttons(3).FontName  = "Tahoma"
2467:                 .Buttons(3).FontSize  = 8
2468:                 .Visible = .T.
2469:             ENDWITH
2470: 
2471:             THIS.AddLabel(par_oPagina, "lbl_4c_CadCli", "Cad. Cliente :", 140, 30, 90)
2472:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_CadCli", 138, 130, 120)
2473: 
2474:         CATCH TO loc_oErro
2475:             MsgErro(loc_oErro.Message + CHR(13) + ;

