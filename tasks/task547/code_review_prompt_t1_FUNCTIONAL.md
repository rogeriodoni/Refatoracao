# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [BINDEVENT-PARAMS] Handler 'ValidarUfEstado' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarUfEstado(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarMunicipioEstado' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarMunicipioEstado(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Valor, Peso Mínimo, Peso Máximo, Município. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Razão Social' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Valor, Peso Mínimo, Peso Máximo, Município. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cidade' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Valor, Peso Mínimo, Peso Máximo, Município. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'CGC' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Valor, Peso Mínimo, Peso Máximo, Município. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'excluir' (parent: SIGCDTRA.Pagina.Dados): Top original=545 vs migrado 'cmd_4c_ExcluirEstado' Top=633 (diff=88px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formtra.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2414 linhas total):

*-- Linhas 28 a 149:
28:     *===========================================================================
29:     * Init - Inicializa o formulario
30:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
31:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
32:     *===========================================================================
33:     PROCEDURE Init()
34:         RETURN DODEFAULT()
35:     ENDPROC
36: 
37:     *===========================================================================
38:     * InicializarForm - Configura estrutura completa
39:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
40:     *===========================================================================
41:     PROTECTED PROCEDURE InicializarForm()
42:         LOCAL loc_lSucesso
43:         loc_lSucesso = .F.
44: 
45:         TRY
46:             THIS.this_oBusinessObject = CREATEOBJECT("traBO")
47: 
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MostrarErro("Erro ao criar traBO" + CHR(13) + ;
50:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
51:                     "Formtra.InicializarForm")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
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
64: 
65:         CATCH TO loException
66:             MostrarErro("Erro ao inicializar Formtra:" + CHR(13) + ;
67:                 loException.Message + CHR(13) + ;
68:                 "Linha: " + TRANSFORM(loException.LineNo), ;
69:                 "Formtra.InicializarForm")
70:         ENDTRY
71: 
72:         RETURN loc_lSucesso
73:     ENDPROC
74: 
75:     *===========================================================================
76:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
77:     * Top=-29 para esconder abas; controles compensam +29 no Top
78:     *===========================================================================
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81: 
82:         WITH THIS.pgf_4c_Paginas
83:             .PageCount = 2
84:             .Top       = -29
85:             .Left      = 0
86:             .Width     = THIS.Width
87:             .Height    = THIS.Height + 29
88:             .Tabs      = .F.
89:             .Visible   = .T.
90: 
91:             .Page1.Caption   = "Lista"
92:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:             .Page1.BackColor = RGB(255, 255, 255)
94: 
95:             .Page2.Caption   = "Dados"
96:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page2.BackColor = RGB(255, 255, 255)
98:         ENDWITH
99: 
100:         THIS.ConfigurarPaginaLista()
101:         THIS.ConfigurarPaginaDados()
102:     ENDPROC
103: 
104:     *===========================================================================
105:     * ConfigurarPaginaLista - Page1 (Lista de Transportadoras)
106:     * Grid: cursor_4c_Dados (itras, razaos, cidas, estas, cgcs) - traBO.Buscar()
107:     * Botoes CRUD: Incluir, Visualizar, Alterar, Excluir, Buscar, Encerrar
108:     *===========================================================================
109:     PROTECTED PROCEDURE ConfigurarPaginaLista()
110:         LOCAL loc_oPagina
111:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
112: 
113:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114: 
115:         *-- Cabecalho (faixa cinza) - PRIMEIRO AddObject da pagina (CLAUDE.md regra #11)
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
149:             .Height    = 46

*-- Linhas 191 a 409:
191:             .AutoSize        = .F.
192:             .Visible         = .T.
193:         ENDWITH
194:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
195: 
196:         *-- Botao Visualizar (Left=80)
197:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
198:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
199:             .Caption         = "Visualizar"
200:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
201:             .PicturePosition = 13
202:             .Top             = 5
203:             .Left            = 80
204:             .Width           = 75
205:             .Height          = 75
206:             .FontName        = "Tahoma"
207:             .FontBold        = .T.
208:             .FontItalic      = .T.
209:             .FontSize        = 8
210:             .ForeColor       = RGB(90, 90, 90)
211:             .BackColor       = RGB(255, 255, 255)
212:             .Themes          = .F.
213:             .SpecialEffect   = 0
214:             .MousePointer    = 15
215:             .WordWrap        = .T.
216:             .AutoSize        = .F.
217:             .Visible         = .T.
218:         ENDWITH
219:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
220: 
221:         *-- Botao Alterar (Left=155)
222:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
223:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
224:             .Caption         = "Alterar"
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:             .PicturePosition = 13
227:             .Top             = 5
228:             .Left            = 155
229:             .Width           = 75
230:             .Height          = 75
231:             .FontName        = "Tahoma"
232:             .FontBold        = .T.
233:             .FontItalic      = .T.
234:             .FontSize        = 8
235:             .ForeColor       = RGB(90, 90, 90)
236:             .BackColor       = RGB(255, 255, 255)
237:             .Themes          = .F.
238:             .SpecialEffect   = 0
239:             .MousePointer    = 15
240:             .WordWrap        = .T.
241:             .AutoSize        = .F.
242:             .Visible         = .T.
243:         ENDWITH
244:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
245: 
246:         *-- Botao Excluir (Left=230)
247:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
248:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
249:             .Caption         = "Excluir"
250:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
251:             .PicturePosition = 13
252:             .Top             = 5
253:             .Left            = 230
254:             .Width           = 75
255:             .Height          = 75
256:             .FontName        = "Tahoma"
257:             .FontBold        = .T.
258:             .FontItalic      = .T.
259:             .FontSize        = 8
260:             .ForeColor       = RGB(90, 90, 90)
261:             .BackColor       = RGB(255, 255, 255)
262:             .Themes          = .F.
263:             .SpecialEffect   = 0
264:             .MousePointer    = 15
265:             .WordWrap        = .T.
266:             .AutoSize        = .F.
267:             .Visible         = .T.
268:         ENDWITH
269:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
270: 
271:         *-- Botao Buscar (Left=305)
272:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
273:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
274:             .Caption         = "Buscar"
275:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
276:             .PicturePosition = 13
277:             .Top             = 5
278:             .Left            = 305
279:             .Width           = 75
280:             .Height          = 75
281:             .FontName        = "Tahoma"
282:             .FontBold        = .T.
283:             .FontItalic      = .T.
284:             .FontSize        = 8
285:             .ForeColor       = RGB(90, 90, 90)
286:             .BackColor       = RGB(255, 255, 255)
287:             .Themes          = .F.
288:             .SpecialEffect   = 0
289:             .MousePointer    = 15
290:             .WordWrap        = .T.
291:             .AutoSize        = .F.
292:             .Visible         = .T.
293:         ENDWITH
294:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
295: 
296:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, CLAUDE.md regra #10)
297:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
298:         WITH loc_oPagina.cnt_4c_Saida
299:             .Top         = 29
300:             .Left        = 917
301:             .Width       = 90
302:             .Height      = 85
303:             .BackStyle   = 0
304:             .BorderWidth = 0
305:             .Visible     = .T.
306:         ENDWITH
307: 
308:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
309:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
310:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
311:             .Caption         = "Encerrar"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
313:             .PicturePosition = 13
314:             .Top             = 5
315:             .Left            = 5
316:             .Width           = 75
317:             .Height          = 75
318:             .FontName        = "Tahoma"
319:             .FontBold        = .T.
320:             .FontItalic      = .T.
321:             .FontSize        = 8
322:             .ForeColor       = RGB(90, 90, 90)
323:             .BackColor       = RGB(255, 255, 255)
324:             .Themes          = .F.
325:             .SpecialEffect   = 0
326:             .MousePointer    = 15
327:             .WordWrap        = .T.
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
332: 
333:         *-- Grid de listagem de transportadoras
334:         *-- Colunas: itras (Codigo), razaos (Razao Social), cidas (Cidade), estas (UF), cgcs (CGC)
335:         *-- Width=880: nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
336:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
337:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
338:         loc_oPagina.grd_4c_Lista.ColumnCount = 5
339:         WITH loc_oPagina.grd_4c_Lista
340:             .Top                = 117
341:             .Left               = 26
342:             .Width              = 880
343:             .Height             = 498
344:             .FontName           = "Verdana"
345:             .FontSize           = 8
346:             .ForeColor          = RGB(90, 90, 90)
347:             .BackColor          = RGB(255, 255, 255)
348:             .GridLineColor      = RGB(238, 238, 238)
349:             .HighlightBackColor = RGB(255, 255, 255)
350:             .HighlightForeColor = RGB(15, 41, 104)
351:             .HighlightStyle     = 2
352:             .DeleteMark         = .F.
353:             .RecordMark         = .F.
354:             .RowHeight          = 16
355:             .ScrollBars         = 2
356:             .GridLines          = 3
357:             .Visible            = .T.
358:         ENDWITH
359:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
360: 
361:         THIS.TornarControlesVisiveis(loc_oPagina)
362:     ENDPROC
363: 
364:     *===========================================================================
365:     * CarregarLista - Carrega dados no grid da Page1
366:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
367:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
368:     *===========================================================================
369:     PROCEDURE CarregarLista()
370:         LOCAL loc_lResultado, loc_oGrid
371:         loc_lResultado = .F.
372: 
373:         TRY
374:             IF !THIS.this_oBusinessObject.Buscar("")
375:                 loc_lResultado = .F.
376:             ELSE
377:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
378: 
379:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
380:                 loc_oGrid.ColumnCount  = 5
381:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
382: 
383:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
384:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.itras"
385:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.razaos"
386:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cidas"
387:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.estas"
388:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cgcs"
389: 
390:                 loc_oGrid.Column1.Width = 90
391:                 loc_oGrid.Column2.Width = 330
392:                 loc_oGrid.Column3.Width = 200
393:                 loc_oGrid.Column4.Width = 50
394:                 loc_oGrid.Column5.Width = 150
395: 
396:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
397:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
398:                 loc_oGrid.Column2.Header1.Caption = "Raz" + CHR(227) + "o Social"
399:                 loc_oGrid.Column3.Header1.Caption = "Cidade"
400:                 loc_oGrid.Column4.Header1.Caption = "UF"
401:                 loc_oGrid.Column5.Header1.Caption = "CGC"
402: 
403:                 THIS.FormatarGridLista(loc_oGrid)
404:                 loc_lResultado = .T.
405:             ENDIF
406: 
407:         CATCH TO loException
408:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
409:                 "Linha: " + TRANSFORM(loException.LineNo), ;

*-- Linhas 417 a 503:
417:     *===========================================================================
418:     * FormatarGridLista - Formata visual do grid da lista
419:     *===========================================================================
420:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
421:         WITH par_oGrid
422:             .FontName = "Tahoma"
423:             .FontSize = 8
424:         ENDWITH
425:     ENDPROC
426: 
427:     *===========================================================================
428:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
429:     * Ao voltar para Page1, recarrega a lista
430:     *===========================================================================
431:     PROCEDURE AlternarPagina(par_nPagina)
432:         LOCAL loc_lResultado
433:         loc_lResultado = .F.
434: 
435:         TRY
436:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
437:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
438:             ELSE
439:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
440: 
441:                 IF par_nPagina = 1
442:                     THIS.this_cModoAtual = "LISTA"
443:                     THIS.CarregarLista()
444:                 ENDIF
445: 
446:                 loc_lResultado = .T.
447:             ENDIF
448: 
449:         CATCH TO loException
450:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
451:                 "Formtra.AlternarPagina")
452:         ENDTRY
453: 
454:         RETURN loc_lResultado
455:     ENDPROC
456: 
457:     *===========================================================================
458:     * ConfigurarPaginaDados - Page2 (Dados da Transportadora + Grade de Fretes)
459:     * NESTA FASE: apenas estrutura base (cabecalho + container de acao vazio).
460:     * Campos, grid de fretes (GradEstado) e lookups sao implementados
461:     * nas Fases 5/6.
462:     *===========================================================================
463:     PROTECTED PROCEDURE ConfigurarPaginaDados()
464:         LOCAL loc_oPagina
465:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
466: 
467:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
468: 
469:         *-- Cabecalho (faixa cinza) tambem na pagina Dados - CLAUDE.md regra #11
470:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
471:         WITH loc_oPagina.cnt_4c_Cabecalho
472:             .Top         = 29
473:             .Left        = 0
474:             .Width       = THIS.Width
475:             .Height      = 80
476:             .BackColor   = RGB(100, 100, 100)
477:             .BorderWidth = 0
478:             .Visible     = .T.
479:         ENDWITH
480: 
481:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
482:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
483:             .Caption   = THIS.Caption
484:             .Top       = 15
485:             .Left      = 10
486:             .Width     = 769
487:             .Height    = 40
488:             .FontName  = "Tahoma"
489:             .FontSize  = 16
490:             .FontBold  = .T.
491:             .ForeColor = RGB(0, 0, 0)
492:             .BackStyle = 0
493:             .AutoSize  = .F.
494:             .Visible   = .T.
495:         ENDWITH
496: 
497:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
498:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
499:             .Caption   = THIS.Caption
500:             .Top       = 18
501:             .Left      = 10
502:             .Width     = 769
503:             .Height    = 46

*-- Linhas 1243 a 1303:
1243:             .Visible       = .T.
1244:         ENDWITH
1245: 
1246:         *-- Modelo (Say27) / OptionGroup Tipo de Transporte (Optiongroup1)
1247:         loc_oPagina.AddObject("lbl_4c_Label27", "Label")
1248:         WITH loc_oPagina.lbl_4c_Label27
1249:             .Caption   = "Modelo :"
1250:             .Top       = 561
1251:             .Left      = 347
1252:             .Width     = 43
1253:             .Height    = 15
1254:             .AutoSize  = .F.
1255:             .Alignment = 0
1256:             .FontName  = "Tahoma"
1257:             .FontSize  = 8
1258:             .ForeColor = RGB(90, 90, 90)
1259:             .BackStyle = 0
1260:             .Visible   = .T.
1261:         ENDWITH
1262: 
1263:         loc_oPagina.AddObject("opt_4c_TipoTransporte", "OptionGroup")
1264:         WITH loc_oPagina.opt_4c_TipoTransporte
1265:             .Top         = 558
1266:             .Left        = 390
1267:             .Width       = 137
1268:             .Height      = 53
1269:             .ButtonCount = 4
1270:             .BackStyle   = 0
1271:             .BorderStyle = 0
1272:             .Value       = 1
1273:             .Visible     = .T.
1274:         ENDWITH
1275: 
1276:         WITH loc_oPagina.opt_4c_TipoTransporte.Buttons(1)
1277:             .Caption   = "Comum"
1278:             .Left      = 5
1279:             .Top       = 5
1280:             .Width     = 61
1281:             .Height    = 17
1282:             .AutoSize  = .F.
1283:             .FontName  = "Tahoma"
1284:             .FontSize  = 8
1285:             .BackStyle = 0
1286:             .ForeColor = RGB(90, 90, 90)
1287:             .Themes    = .F.
1288:         ENDWITH
1289: 
1290:         WITH loc_oPagina.opt_4c_TipoTransporte.Buttons(2)
1291:             .Caption   = "Sedex"
1292:             .Left      = 63
1293:             .Top       = 5
1294:             .Width     = 61
1295:             .Height    = 17
1296:             .AutoSize  = .F.
1297:             .FontName  = "Tahoma"
1298:             .FontSize  = 8
1299:             .BackStyle = 0
1300:             .ForeColor = RGB(90, 90, 90)
1301:             .Themes    = .F.
1302:         ENDWITH
1303: 

*-- Linhas 1519 a 1693:
1519:         ENDWITH
1520:         loc_oPagina.grd_4c_Estados.Column1.CurrentControl = "txt_4c_ColUf"
1521:         loc_oPagina.grd_4c_Estados.Column1.Sparse         = .F.
1522:         BINDEVENT(loc_oPagina.grd_4c_Estados.Column1.txt_4c_ColUf, "KeyPress", THIS, "ValidarUfEstado")
1523: 
1524:         *-- Coluna Municipio (Column5) - controle customizado com lookup no LostFocus
1525:         loc_oPagina.grd_4c_Estados.Column5.AddObject("txt_4c_ColMunicipio", "TextBox")
1526:         WITH loc_oPagina.grd_4c_Estados.Column5.txt_4c_ColMunicipio
1527:             .FontName    = "Arial"
1528:             .FontSize    = 8
1529:             .Alignment   = 0
1530:             .BorderStyle = 0
1531:             .Margin      = 0
1532:             .Visible     = .T.
1533:         ENDWITH
1534:         loc_oPagina.grd_4c_Estados.Column5.CurrentControl = "txt_4c_ColMunicipio"
1535:         loc_oPagina.grd_4c_Estados.Column5.Sparse         = .F.
1536:         BINDEVENT(loc_oPagina.grd_4c_Estados.Column5.txt_4c_ColMunicipio, "KeyPress", THIS, "ValidarMunicipioEstado")
1537: 
1538:         *-- Grid.ReadOnly ANTES de Column.ReadOnly (regra #18 - senao o Grid sobrescreve)
1539:         loc_oPagina.grd_4c_Estados.ReadOnly  = .F.
1540:         loc_oPagina.grd_4c_Estados.Column1.ReadOnly = .F.
1541:         loc_oPagina.grd_4c_Estados.Column2.ReadOnly = .F.
1542:         loc_oPagina.grd_4c_Estados.Column3.ReadOnly = .F.
1543:         loc_oPagina.grd_4c_Estados.Column4.ReadOnly = .F.
1544:         loc_oPagina.grd_4c_Estados.Column5.ReadOnly = .F.
1545: 
1546:         *-- Botao Incluir linha de estado (inserir no legado)
1547:         loc_oPagina.AddObject("cmd_4c_IncluirEstado", "CommandButton")
1548:         WITH loc_oPagina.cmd_4c_IncluirEstado
1549:             .Top           = 633
1550:             .Left          = 502
1551:             .Width         = 45
1552:             .Height        = 45
1553:             .Caption       = ""
1554:             .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1555:             .ToolTipText   = "Inserir"
1556:             .FontBold      = .T.
1557:             .FontName      = "Verdana"
1558:             .FontSize      = 8
1559:             .ForeColor     = RGB(36, 84, 155)
1560:             .BackColor     = RGB(255, 255, 255)
1561:             .Themes        = .F.
1562:             .SpecialEffect = 0
1563:             .Visible       = .T.
1564:         ENDWITH
1565:         BINDEVENT(loc_oPagina.cmd_4c_IncluirEstado, "Click", THIS, "BtnIncluirEstadoClick")
1566: 
1567:         *-- Botao Excluir linha de estado (excluir no legado)
1568:         loc_oPagina.AddObject("cmd_4c_ExcluirEstado", "CommandButton")
1569:         WITH loc_oPagina.cmd_4c_ExcluirEstado
1570:             .Top           = 633
1571:             .Left          = 548
1572:             .Width         = 45
1573:             .Height        = 45
1574:             .Caption       = ""
1575:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1576:             .ToolTipText   = "Excluir"
1577:             .FontBold      = .T.
1578:             .FontName      = "Verdana"
1579:             .FontSize      = 8
1580:             .ForeColor     = RGB(36, 84, 155)
1581:             .BackColor     = RGB(255, 255, 255)
1582:             .Themes        = .F.
1583:             .SpecialEffect = 0
1584:             .Visible       = .T.
1585:         ENDWITH
1586:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirEstado, "Click", THIS, "BtnExcluirEstadoClick")
1587: 
1588:         *-- Inicializa a estrutura do cursor da grade (RecordSource/Headers definidos aqui)
1589:         THIS.CarregarGradeEstados("")
1590: 
1591:         *======================================================================
1592:         * Botoes de acao da Pagina Dados (Grupo_Salva no legado)
1593:         *======================================================================
1594:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
1595:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
1596:             .Caption         = "Confirmar"
1597:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1598:             .PicturePosition = 13
1599:             .Top             = 5
1600:             .Left            = 5
1601:             .Width           = 75
1602:             .Height          = 75
1603:             .FontName        = "Tahoma"
1604:             .FontBold        = .T.
1605:             .FontItalic      = .T.
1606:             .FontSize        = 8
1607:             .ForeColor       = RGB(90, 90, 90)
1608:             .BackColor       = RGB(255, 255, 255)
1609:             .Themes          = .F.
1610:             .SpecialEffect   = 0
1611:             .MousePointer    = 15
1612:             .WordWrap        = .T.
1613:             .AutoSize        = .F.
1614:             .Visible         = .T.
1615:         ENDWITH
1616:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1617: 
1618:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
1619:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
1620:             .Caption         = "Encerrar"
1621:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1622:             .PicturePosition = 13
1623:             .Top             = 5
1624:             .Left            = 80
1625:             .Width           = 75
1626:             .Height          = 75
1627:             .FontName        = "Tahoma"
1628:             .FontBold        = .T.
1629:             .FontItalic      = .T.
1630:             .FontSize        = 8
1631:             .ForeColor       = RGB(90, 90, 90)
1632:             .BackColor       = RGB(255, 255, 255)
1633:             .Themes          = .F.
1634:             .SpecialEffect   = 0
1635:             .MousePointer    = 15
1636:             .WordWrap        = .T.
1637:             .AutoSize        = .F.
1638:             .Visible         = .T.
1639:         ENDWITH
1640:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
1641: 
1642:         THIS.TornarControlesVisiveis(loc_oPagina)
1643:     ENDPROC
1644: 
1645:     *===========================================================================
1646:     * CarregarGradeEstados - Carrega/atualiza a grade de fretes por estado
1647:     * (GradEstado/crSigPrTrv no legado). SigPrTrv NAO tem colunas "uf"/"munici" -
1648:     * sao alias de JOIN com SigCdUfs/SigCdMun (ver docs/schema.sql).
1649:     * REGRA: RecordSource/ControlSource/Headers configurados so na 1a chamada
1650:     * (Problema 48); recargas seguintes usam cursor temporario + ZAP + APPEND
1651:     * (Problema 34/35) para nao destruir as colunas do Grid.
1652:     *===========================================================================
1653:     PROCEDURE CarregarGradeEstados(par_cCodigo)
1654:         LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_oGrid, loc_lPrimeiraVez
1655:         loc_lResultado = .F.
1656: 
1657:         TRY
1658:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Estados
1659:             loc_lPrimeiraVez = EMPTY(loc_oGrid.RecordSource)
1660: 
1661:             IF !USED("cursor_4c_Estados")
1662:                 SET NULL ON
1663:                 CREATE CURSOR cursor_4c_Estados (cidchaves C(20), codibges C(7), ;
1664:                     pesomaxs N(8,2), pesomins N(8,2), ufibges N(5,0), valfretes N(9,2), ;
1665:                     uf C(2), munici C(40))
1666:                 SET NULL OFF
1667:             ELSE
1668:                 SELECT cursor_4c_Estados
1669:                 ZAP
1670:             ENDIF
1671: 
1672:             IF VARTYPE(par_cCodigo) = "C" AND !EMPTY(par_cCodigo) ;
1673:                     AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1674: 
1675:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
1676:                     SELECT a.cidchaves, a.codibges, a.pesomaxs, a.pesomins, a.ufibges,
1677:                         a.valfretes, d.estados AS uf, c.descs AS munici
1678:                     FROM SigPrTrv a
1679:                     INNER JOIN SigCdUfs d ON d.ufibges = a.ufibges
1680:                     LEFT JOIN SigCdMun c ON c.codigos = a.codibges
1681:                     WHERE a.itras = <<EscaparSQL(par_cCodigo)>>
1682:                     ORDER BY d.estados
1683:                 ENDTEXT
1684: 
1685:                 IF USED("cursor_4c_EstadosTemp")
1686:                     USE IN cursor_4c_EstadosTemp
1687:                 ENDIF
1688:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstadosTemp")
1689: 
1690:                 IF loc_nResultado >= 0 AND USED("cursor_4c_EstadosTemp")
1691:                     SELECT cursor_4c_Estados
1692:                     APPEND FROM DBF("cursor_4c_EstadosTemp")
1693:                     USE IN cursor_4c_EstadosTemp

*-- Linhas 1747 a 1790:
1747:     * e seguro que diff linha-a-linha; equivalente ao msv_inserir/msv_alterar
1748:     * do legado que tambem regravam o cursor inteiro via poDataMgr.Update).
1749:     *===========================================================================
1750:     PROCEDURE SalvarGradeEstados(par_cCodigo)
1751:         LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCidChaves
1752:         loc_lResultado = .T.
1753: 
1754:         TRY
1755:             loc_cSQL = "DELETE FROM SigPrTrv WHERE itras = " + EscaparSQL(par_cCodigo)
1756:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
1757: 
1758:             IF loc_nResultado < 0
1759:                 MostrarErro("Erro ao atualizar fretes por estado:" + CHR(13) + CapturarErroSQL(), ;
1760:                     "Formtra.SalvarGradeEstados")
1761:                 loc_lResultado = .F.
1762:             ELSE
1763:                 IF USED("cursor_4c_Estados")
1764:                     SELECT cursor_4c_Estados
1765:                     SCAN FOR !DELETED() AND !EMPTY(ALLTRIM(uf))
1766:                         loc_cCidChaves = ALLTRIM(cursor_4c_Estados.cidchaves)
1767:                         IF EMPTY(loc_cCidChaves)
1768:                             loc_cCidChaves = fUniqueIds("")
1769:                         ENDIF
1770: 
1771:                         TEXT TO loc_cSQL TEXTMERGE NOSHOW
1772:                             INSERT INTO SigPrTrv (cidchaves, codibges, itras, pesomaxs, pesomins, ufibges, valfretes)
1773:                             VALUES (
1774:                                 <<EscaparSQL(loc_cCidChaves)>>,
1775:                                 <<EscaparSQL(cursor_4c_Estados.codibges)>>,
1776:                                 <<EscaparSQL(par_cCodigo)>>,
1777:                                 <<FormatarNumeroSQL(cursor_4c_Estados.pesomaxs, 2)>>,
1778:                                 <<FormatarNumeroSQL(cursor_4c_Estados.pesomins, 2)>>,
1779:                                 <<FormatarNumeroSQL(cursor_4c_Estados.ufibges, 0)>>,
1780:                                 <<FormatarNumeroSQL(cursor_4c_Estados.valfretes, 2)>>
1781:                             )
1782:                         ENDTEXT
1783: 
1784:                         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
1785:                         IF loc_nResultado < 0
1786:                             MostrarErro("Erro ao gravar frete do estado " + ALLTRIM(cursor_4c_Estados.uf) + ":" + ;
1787:                                 CHR(13) + CapturarErroSQL(), "Formtra.SalvarGradeEstados")
1788:                             loc_lResultado = .F.
1789:                             EXIT
1790:                         ENDIF

*-- Linhas 1805 a 2414:
1805:     * BtnIncluirEstadoClick - Adiciona linha em branco na grade de estados
1806:     * (inserir.Click no legado)
1807:     *===========================================================================
1808:     PROCEDURE BtnIncluirEstadoClick()
1809:         IF !USED("cursor_4c_Estados")
1810:             RETURN
1811:         ENDIF
1812: 
1813:         SELECT cursor_4c_Estados
1814:         APPEND BLANK
1815:         REPLACE cidchaves WITH fUniqueIds(""), uf WITH "", ufibges WITH 0, ;
1816:             munici WITH "", codibges WITH "", valfretes WITH 0, ;
1817:             pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
1818: 
1819:         WITH THIS.pgf_4c_Paginas.Page2.grd_4c_Estados
1820:             .Refresh()
1821:             .SetFocus()
1822:             .Column1.SetFocus()
1823:         ENDWITH
1824:     ENDPROC
1825: 
1826:     *===========================================================================
1827:     * BtnExcluirEstadoClick - Remove a linha atual da grade de estados
1828:     * (excluir.Click no legado)
1829:     *===========================================================================
1830:     PROCEDURE BtnExcluirEstadoClick()
1831:         IF !USED("cursor_4c_Estados")
1832:             RETURN
1833:         ENDIF
1834: 
1835:         SELECT cursor_4c_Estados
1836:         IF EOF() OR BOF()
1837:             RETURN
1838:         ENDIF
1839: 
1840:         DELETE IN cursor_4c_Estados
1841:         GO TOP IN cursor_4c_Estados
1842: 
1843:         THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
1844:     ENDPROC
1845: 
1846:     *===========================================================================
1847:     * ValidarUfEstado - Lookup do campo UF da grade de estados (Column1)
1848:     * Legado: Column1.Text1.Valid - CreateObject('fwbuscaext', ..., 'SigCdUfs', ...)
1849:     *===========================================================================
1850:     PROCEDURE ValidarUfEstado(par_nKeyCode, par_nShiftAltCtrl)
1851:         LOCAL loc_oBusca, loc_cUf
1852: 
1853:         IF !USED("cursor_4c_Estados")
1854:             RETURN
1855:         ENDIF
1856: 
1857:         SELECT cursor_4c_Estados
1858:         loc_cUf = UPPER(ALLTRIM(cursor_4c_Estados.uf))
1859: 
1860:         IF EMPTY(loc_cUf)
1861:             REPLACE uf WITH "", ufibges WITH 0, munici WITH "", codibges WITH "", ;
1862:                 valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
1863:             THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
1864:             RETURN
1865:         ENDIF
1866: 
1867:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUfs", ;
1868:             "cursor_4c_BuscaUf", "Estados", PADR(loc_cUf, 2), "Selecionar Estado")
1869: 
1870:         IF VARTYPE(loc_oBusca) = "O"
1871:             IF !loc_oBusca.this_lAchouRegistro
1872:                 loc_oBusca.mAddColuna("Estados", "", "UF")
1873:                 loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1874:                 loc_oBusca.mAddColuna("UFIBGEs", "", "IBGE")
1875:                 loc_oBusca.Show()
1876:             ENDIF
1877: 
1878:             SELECT cursor_4c_Estados
1879:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
1880:                 REPLACE uf WITH ALLTRIM(cursor_4c_BuscaUf.Estados), ;
1881:                     ufibges WITH cursor_4c_BuscaUf.UFIBGEs, ;
1882:                     munici WITH "", codibges WITH "", ;
1883:                     valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 ;
1884:                     IN cursor_4c_Estados
1885:             ELSE
1886:                 REPLACE uf WITH "", ufibges WITH 0, munici WITH "", codibges WITH "", ;
1887:                     valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
1888:             ENDIF
1889: 
1890:             IF USED("cursor_4c_BuscaUf")
1891:                 USE IN cursor_4c_BuscaUf
1892:             ENDIF
1893:             loc_oBusca.Release()
1894:         ENDIF
1895: 
1896:         THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
1897:     ENDPROC
1898: 
1899:     *===========================================================================
1900:     * ValidarMunicipioEstado - Lookup do Municipio da grade de estados (Column5)
1901:     * Legado: Column5.Text1.Valid - join SigCdMun+SigCdUfs filtrado pela UF da
1902:     * linha atual, seek exato ou fwbuscaint (grid) se nao achar
1903:     *===========================================================================
1904:     PROCEDURE ValidarMunicipioEstado(par_nKeyCode, par_nShiftAltCtrl)
1905:         LOCAL loc_cUf, loc_cMunicipio, loc_cSQL, loc_nResultado, loc_oBusca
1906: 
1907:         IF !USED("cursor_4c_Estados")
1908:             RETURN
1909:         ENDIF
1910: 
1911:         SELECT cursor_4c_Estados
1912:         loc_cUf        = UPPER(ALLTRIM(cursor_4c_Estados.uf))
1913:         loc_cMunicipio = ALLTRIM(cursor_4c_Estados.munici)
1914: 
1915:         IF EMPTY(loc_cUf) OR EMPTY(loc_cMunicipio)
1916:             RETURN
1917:         ENDIF
1918: 
1919:         IF USED("cursor_4c_BuscaMunicipio")
1920:             USE IN cursor_4c_BuscaMunicipio
1921:         ENDIF
1922: 
1923:         TEXT TO loc_cSQL TEXTMERGE NOSHOW
1924:             SELECT b.estados AS uf, a.descs AS munici, a.codigos AS codibges
1925:             FROM SigCdMun a
1926:             INNER JOIN SigCdUfs b ON a.ufibges = b.ufibges
1927:             WHERE b.estados = <<EscaparSQL(loc_cUf)>>
1928:             ORDER BY a.descs
1929:         ENDTEXT
1930: 
1931:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMunicipio")
1932: 
1933:         IF loc_nResultado < 0 OR !USED("cursor_4c_BuscaMunicipio")
1934:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1935:                 "Falha na Conex" + CHR(227) + "o")
1936:             RETURN
1937:         ENDIF
1938: 
1939:         SELECT cursor_4c_BuscaMunicipio
1940:         LOCATE FOR UPPER(ALLTRIM(munici)) == UPPER(loc_cMunicipio)
1941: 
1942:         IF FOUND()
1943:             SELECT cursor_4c_Estados
1944:             REPLACE munici WITH ALLTRIM(cursor_4c_BuscaMunicipio.munici), ;
1945:                 codibges WITH ALLTRIM(cursor_4c_BuscaMunicipio.codibges) IN cursor_4c_Estados
1946:         ELSE
1947:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1948:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMunicipio"
1949:             loc_oBusca.this_cTitulo        = "Selecionar Munic" + CHR(237) + "pio"
1950:             loc_oBusca.mAddColuna("munici", "", "Munic" + CHR(237) + "pio")
1951:             loc_oBusca.mAddColuna("uf", "", "UF")
1952:             loc_oBusca.Show()
1953: 
1954:             SELECT cursor_4c_Estados
1955:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMunicipio")
1956:                 REPLACE munici WITH ALLTRIM(cursor_4c_BuscaMunicipio.munici), ;
1957:                     codibges WITH ALLTRIM(cursor_4c_BuscaMunicipio.codibges) IN cursor_4c_Estados
1958:             ELSE
1959:                 REPLACE munici WITH "", codibges WITH "" IN cursor_4c_Estados
1960:             ENDIF
1961:             loc_oBusca.Release()
1962:         ENDIF
1963: 
1964:         REPLACE valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
1965: 
1966:         IF USED("cursor_4c_BuscaMunicipio")
1967:             USE IN cursor_4c_BuscaMunicipio
1968:         ENDIF
1969: 
1970:         THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
1971:     ENDPROC
1972: 
1973:     *===========================================================================
1974:     * FormParaBO - Transfere valores dos campos do Form para o Business Object
1975:     *===========================================================================
1976:     PROCEDURE FormParaBO()
1977:         LOCAL loc_oPg, loc_oBo
1978:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1979:         loc_oBo = THIS.this_oBusinessObject
1980: 
1981:         loc_oBo.this_cCodigo             = ALLTRIM(loc_oPg.txt_4c_Itra.Value)
1982:         loc_oBo.this_cIdTransportadora   = ALLTRIM(loc_oPg.txt_4c_Idtransp.Value)
1983:         loc_oBo.this_cRazaoSocial        = ALLTRIM(loc_oPg.txt_4c_Razao.Value)
1984:         loc_oBo.this_cEndereco           = ALLTRIM(loc_oPg.txt_4c_Endereco.Value)
1985:         loc_oBo.this_cBairro             = ALLTRIM(loc_oPg.txt_4c_Bairro.Value)
1986:         loc_oBo.this_cCep                = ALLTRIM(loc_oPg.txt_4c_Cep.Value)
1987:         loc_oBo.this_cCidade             = ALLTRIM(loc_oPg.txt_4c_Cidade.Value)
1988:         loc_oBo.this_cUf                 = ALLTRIM(loc_oPg.txt_4c_Uf.Value)
1989:         loc_oBo.this_cTelefone1          = ALLTRIM(loc_oPg.txt_4c_Tel1.Value)
1990:         loc_oBo.this_cTelefone2          = ALLTRIM(loc_oPg.txt_4c_Tel2.Value)
1991:         loc_oBo.this_cCgc                = ALLTRIM(loc_oPg.txt_4c_Cgc.Value)
1992:         loc_oBo.this_cInscricaoEstadual  = ALLTRIM(loc_oPg.txt_4c_Ies.Value)
1993:         loc_oBo.this_cFax                = ALLTRIM(loc_oPg.txt_4c_Fax.Value)
1994:         loc_oBo.this_cTipoConexao        = ALLTRIM(loc_oPg.txt_4c_TpConexao.Value)
1995:         loc_oBo.this_cFtpEndereco        = ALLTRIM(loc_oPg.txt_4c_FtpEndereco.Value)
1996:         loc_oBo.this_cFtpUsuario         = ALLTRIM(loc_oPg.txt_4c_FtpUsuario.Value)
1997:         loc_oBo.this_cFtpSenha           = ALLTRIM(loc_oPg.txt_4c_FtpSenha.Value)
1998:         loc_oBo.this_cDirFtpEnvio        = ALLTRIM(loc_oPg.txt_4c_DirFtpEnvio.Value)
1999:         loc_oBo.this_cDirFtpRecepcao     = ALLTRIM(loc_oPg.txt_4c_DirFtpRecepcao.Value)
2000:         loc_oBo.this_cDriveGeracao       = ALLTRIM(loc_oPg.txt_4c_DriveGeracao.Value)
2001:         loc_oBo.this_cDriveLeitura       = ALLTRIM(loc_oPg.txt_4c_DriveLeitura.Value)
2002:         loc_oBo.this_lLimpaDiretorioFtp   = (loc_oPg.chk_4c_LimpaDiretorioFtp.Value = 1)
2003:         loc_oBo.this_lLimpaDiretorioLocal = (loc_oPg.chk_4c_LimpaDiretorioLocal.Value = 1)
2004:         loc_oBo.this_cUrlTransp          = ALLTRIM(loc_oPg.txt_4c_UrlTransp.Value)
2005:         loc_oBo.this_nTipoTransporte     = loc_oPg.opt_4c_TipoTransporte.Value
2006:     ENDPROC
2007: 
2008:     *===========================================================================
2009:     * BOParaForm - Transfere valores do Business Object para os campos do Form
2010:     *===========================================================================
2011:     PROCEDURE BOParaForm()
2012:         LOCAL loc_oPg, loc_oBo
2013:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2014:         loc_oBo = THIS.this_oBusinessObject
2015: 
2016:         loc_oPg.txt_4c_Itra.Value                = loc_oBo.this_cCodigo
2017:         loc_oPg.txt_4c_Idtransp.Value            = loc_oBo.this_cIdTransportadora
2018:         loc_oPg.txt_4c_Razao.Value                = loc_oBo.this_cRazaoSocial
2019:         loc_oPg.txt_4c_Endereco.Value             = loc_oBo.this_cEndereco
2020:         loc_oPg.txt_4c_Bairro.Value                = loc_oBo.this_cBairro
2021:         loc_oPg.txt_4c_Cep.Value                   = loc_oBo.this_cCep
2022:         loc_oPg.txt_4c_Cidade.Value                = loc_oBo.this_cCidade
2023:         loc_oPg.txt_4c_Uf.Value                    = loc_oBo.this_cUf
2024:         loc_oPg.txt_4c_Tel1.Value                  = loc_oBo.this_cTelefone1
2025:         loc_oPg.txt_4c_Tel2.Value                  = loc_oBo.this_cTelefone2
2026:         loc_oPg.txt_4c_Cgc.Value                   = loc_oBo.this_cCgc
2027:         loc_oPg.txt_4c_Ies.Value                   = loc_oBo.this_cInscricaoEstadual
2028:         loc_oPg.txt_4c_Fax.Value                   = loc_oBo.this_cFax
2029:         loc_oPg.txt_4c_TpConexao.Value             = loc_oBo.this_cTipoConexao
2030:         loc_oPg.txt_4c_FtpEndereco.Value           = loc_oBo.this_cFtpEndereco
2031:         loc_oPg.txt_4c_FtpUsuario.Value            = loc_oBo.this_cFtpUsuario
2032:         loc_oPg.txt_4c_FtpSenha.Value              = loc_oBo.this_cFtpSenha
2033:         loc_oPg.txt_4c_DirFtpEnvio.Value           = loc_oBo.this_cDirFtpEnvio
2034:         loc_oPg.txt_4c_DirFtpRecepcao.Value        = loc_oBo.this_cDirFtpRecepcao
2035:         loc_oPg.txt_4c_DriveGeracao.Value          = loc_oBo.this_cDriveGeracao
2036:         loc_oPg.txt_4c_DriveLeitura.Value          = loc_oBo.this_cDriveLeitura
2037:         loc_oPg.chk_4c_LimpaDiretorioFtp.Value     = loc_oBo.this_lLimpaDiretorioFtp
2038:         loc_oPg.chk_4c_LimpaDiretorioLocal.Value   = loc_oBo.this_lLimpaDiretorioLocal
2039:         loc_oPg.txt_4c_UrlTransp.Value             = loc_oBo.this_cUrlTransp
2040:         loc_oPg.opt_4c_TipoTransporte.Value        = IIF(loc_oBo.this_nTipoTransporte >= 1 ;
2041:             AND loc_oBo.this_nTipoTransporte <= 4, loc_oBo.this_nTipoTransporte, 1)
2042:         loc_oPg.txt_4c_Senha2.Value                 = ""
2043: 
2044:         THIS.CarregarGradeEstados(loc_oBo.this_cCodigo)
2045:     ENDPROC
2046: 
2047:     *===========================================================================
2048:     * BtnSalvarClick - Grava cabecalho + fretes por estado
2049:     * (Grupo_Salva.Salva.Click no legado)
2050:     *===========================================================================
2051:     PROCEDURE BtnSalvarClick()
2052:         LOCAL loc_lFreteInvalido
2053: 
2054:         THIS.FormParaBO()
2055: 
2056:         *-- Legado: frete/peso nao pode ficar totalmente zerado (regra de negocio)
2057:         loc_lFreteInvalido = .F.
2058:         IF USED("cursor_4c_Estados")
2059:             SELECT cursor_4c_Estados
2060:             LOCATE FOR !DELETED() AND !EMPTY(ALLTRIM(uf)) AND ;
2061:                 (valfretes = 0 OR (pesomins = 0 AND pesomaxs = 0))
2062:             loc_lFreteInvalido = FOUND()
2063:         ENDIF
2064: 
2065:         IF loc_lFreteInvalido
2066:             MsgAviso("Valor do frete, peso m" + CHR(237) + "nimo ou peso m" + CHR(225) + ;
2067:                 "ximo n" + CHR(227) + "o podem ficar zerados.")
2068:             RETURN
2069:         ENDIF
2070: 
2071:         IF THIS.this_oBusinessObject.Salvar()
2072:             IF THIS.SalvarGradeEstados(THIS.this_oBusinessObject.this_cCodigo)
2073:                 MsgInfo("Registro salvo com sucesso!", "Confirmar")
2074:                 THIS.AlternarPagina(1)
2075:             ELSE
2076:                 MsgErro("Transportadora salva, mas houve falha ao gravar os fretes por estado.", "Confirmar")
2077:             ENDIF
2078:         ELSE
2079:             IF !THIS.this_oBusinessObject.this_lErroExibido
2080:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
2081:             ENDIF
2082:         ENDIF
2083:     ENDPROC
2084: 
2085:     *===========================================================================
2086:     * BtnCancelarClick - Descarta alteracoes e volta para a lista
2087:     * (Grupo_Salva.Cancelar.Click no legado)
2088:     *===========================================================================
2089:     PROCEDURE BtnCancelarClick()
2090:         THIS.AlternarPagina(1)
2091:     ENDPROC
2092: 
2093:     *===========================================================================
2094:     * BtnIncluirClick - Prepara BO e Form para inclusao de novo registro
2095:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
2096:     * Codigo (itras) e gerado automaticamente pelo BO (fGerUniqueKey no legado,
2097:     * InicializarValoresPadrao() aqui) - permanece SEMPRE readonly na tela.
2098:     *===========================================================================
2099:     PROCEDURE BtnIncluirClick()
2100:         THIS.LimparCampos()
2101:         THIS.this_oBusinessObject.NovoRegistro()
2102:         THIS.this_cModoAtual = "INCLUIR"
2103:         THIS.pgf_4c_Paginas.Page2.txt_4c_Itra.Value = THIS.this_oBusinessObject.this_cCodigo
2104:         THIS.HabilitarCampos(.T.)
2105:         THIS.AjustarBotoesPorModo()
2106:         THIS.AlternarPagina(2)
2107:     ENDPROC
2108: 
2109:     *===========================================================================
2110:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
2111:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
2112:     *===========================================================================
2113:     PROCEDURE BtnVisualizarClick()
2114:         LOCAL loc_cCodigo
2115:         loc_cCodigo = ""
2116: 
2117:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2118:             SELECT cursor_4c_Dados
2119:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.itras)
2120:         ENDIF
2121: 
2122:         IF EMPTY(loc_cCodigo)
2123:             MsgAviso("Selecione um registro para visualizar.")
2124:         ELSE
2125:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2126:                 THIS.this_cModoAtual = "VISUALIZAR"
2127:                 THIS.BOParaForm()
2128:                 THIS.HabilitarCampos(.F.)
2129:                 THIS.AjustarBotoesPorModo()
2130:                 THIS.AlternarPagina(2)
2131:             ENDIF
2132:         ENDIF
2133:     ENDPROC
2134: 
2135:     *===========================================================================
2136:     * BtnAlterarClick - Abre Page2 para alterar registro selecionado
2137:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
2138:     *===========================================================================
2139:     PROCEDURE BtnAlterarClick()
2140:         LOCAL loc_cCodigo
2141:         loc_cCodigo = ""
2142: 
2143:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2144:             SELECT cursor_4c_Dados
2145:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.itras)
2146:         ENDIF
2147: 
2148:         IF EMPTY(loc_cCodigo)
2149:             MsgAviso("Selecione um registro para alterar.")
2150:         ELSE
2151:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2152:                 THIS.this_oBusinessObject.EditarRegistro()
2153:                 THIS.this_cModoAtual = "ALTERAR"
2154:                 THIS.BOParaForm()
2155:                 THIS.HabilitarCampos(.T.)
2156:                 THIS.AjustarBotoesPorModo()
2157:                 THIS.AlternarPagina(2)
2158:             ENDIF
2159:         ENDIF
2160:     ENDPROC
2161: 
2162:     *===========================================================================
2163:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
2164:     * (BusinessBase.Excluir() chama traBO.ExecutarExclusao() internamente,
2165:     * que ja remove os fretes por estado associados em SigPrTrv - regra #57)
2166:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
2167:     *===========================================================================
2168:     PROCEDURE BtnExcluirClick()
2169:         LOCAL loc_cCodigo
2170:         loc_cCodigo = ""
2171: 
2172:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2173:             SELECT cursor_4c_Dados
2174:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.itras)
2175:         ENDIF
2176: 
2177:         IF EMPTY(loc_cCodigo)
2178:             MsgAviso("Selecione um registro para excluir.")
2179:         ELSE
2180:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2181:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da transportadora [" + loc_cCodigo + "]?", ;
2182:                     "Confirmar Exclus" + CHR(227) + "o")
2183:                     IF THIS.this_oBusinessObject.Excluir()
2184:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
2185:                         THIS.CarregarLista()
2186:                     ENDIF
2187:                 ENDIF
2188:             ENDIF
2189:         ENDIF
2190:     ENDPROC
2191: 
2192:     *===========================================================================
2193:     * BtnBuscarClick - Abre picker para localizar registro na lista
2194:     * Apos selecao, posiciona o cursor no registro encontrado
2195:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
2196:     *===========================================================================
2197:     PROCEDURE BtnBuscarClick()
2198:         LOCAL loc_oBusca, loc_cCodigo
2199:         loc_cCodigo = ""
2200: 
2201:         TRY
2202:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2203:                 "SigPrTrp", "cursor_4c_BuscaTra", "itras", "", ;
2204:                 "Buscar Transportadora")
2205: 
2206:             IF VARTYPE(loc_oBusca) = "O"
2207:                 loc_oBusca.mAddColuna("itras",  "", "C" + CHR(243) + "digo")
2208:                 loc_oBusca.mAddColuna("razaos", "", "Raz" + CHR(227) + "o Social")
2209:                 loc_oBusca.Show()
2210: 
2211:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTra")
2212:                     SELECT cursor_4c_BuscaTra
2213:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaTra.itras)
2214:                 ENDIF
2215: 
2216:                 loc_oBusca.Release()
2217:             ENDIF
2218: 
2219:             IF USED("cursor_4c_BuscaTra")
2220:                 USE IN cursor_4c_BuscaTra
2221:             ENDIF
2222: 
2223:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
2224:                 SELECT cursor_4c_Dados
2225:                 LOCATE FOR ALLTRIM(itras) == loc_cCodigo
2226:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2227:             ENDIF
2228: 
2229:         CATCH TO loException
2230:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "Formtra.BtnBuscarClick")
2231:             IF USED("cursor_4c_BuscaTra")
2232:                 USE IN cursor_4c_BuscaTra
2233:             ENDIF
2234:         ENDTRY
2235:     ENDPROC
2236: 
2237:     *===========================================================================
2238:     * BtnEncerrarClick - Fecha o formulario
2239:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
2240:     *===========================================================================
2241:     PROCEDURE BtnEncerrarClick()
2242:         THIS.Release()
2243:     ENDPROC
2244: 
2245:     *===========================================================================
2246:     * HabilitarCampos - Habilita/desabilita os campos da Page2 conforme o modo
2247:     * txt_4c_Itra permanece SEMPRE desabilitado (codigo gerado automaticamente
2248:     * pelo BO - equivalente ao When() do legado que so libera em modo PROCURAR,
2249:     * inexistente na nova arquitetura List+Buscar)
2250:     *===========================================================================
2251:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2252:         LOCAL loc_oPg
2253:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2254: 
2255:         loc_oPg.txt_4c_Itra.Enabled                = .F.
2256:         loc_oPg.txt_4c_Idtransp.Enabled            = par_lHabilitar
2257:         loc_oPg.txt_4c_Razao.Enabled               = par_lHabilitar
2258:         loc_oPg.txt_4c_Endereco.Enabled            = par_lHabilitar
2259:         loc_oPg.txt_4c_Bairro.Enabled              = par_lHabilitar
2260:         loc_oPg.txt_4c_Cep.Enabled                 = par_lHabilitar
2261:         loc_oPg.txt_4c_Cidade.Enabled              = par_lHabilitar
2262:         loc_oPg.txt_4c_Uf.Enabled                  = par_lHabilitar
2263:         loc_oPg.txt_4c_Tel1.Enabled                = par_lHabilitar
2264:         loc_oPg.txt_4c_Tel2.Enabled                = par_lHabilitar
2265:         loc_oPg.txt_4c_Cgc.Enabled                 = par_lHabilitar
2266:         loc_oPg.txt_4c_Ies.Enabled                 = par_lHabilitar
2267:         loc_oPg.txt_4c_Fax.Enabled                 = par_lHabilitar
2268:         loc_oPg.txt_4c_TpConexao.Enabled           = par_lHabilitar
2269:         loc_oPg.txt_4c_FtpEndereco.Enabled         = par_lHabilitar
2270:         loc_oPg.txt_4c_FtpUsuario.Enabled          = par_lHabilitar
2271:         loc_oPg.txt_4c_FtpSenha.Enabled            = par_lHabilitar
2272:         loc_oPg.txt_4c_DirFtpEnvio.Enabled         = par_lHabilitar
2273:         loc_oPg.txt_4c_DirFtpRecepcao.Enabled      = par_lHabilitar
2274:         loc_oPg.txt_4c_DriveGeracao.Enabled        = par_lHabilitar
2275:         loc_oPg.txt_4c_DriveLeitura.Enabled        = par_lHabilitar
2276:         loc_oPg.chk_4c_LimpaDiretorioFtp.Enabled   = par_lHabilitar
2277:         loc_oPg.chk_4c_LimpaDiretorioLocal.Enabled = par_lHabilitar
2278:         loc_oPg.txt_4c_UrlTransp.Enabled           = par_lHabilitar
2279:         loc_oPg.opt_4c_TipoTransporte.Enabled      = par_lHabilitar
2280:         loc_oPg.txt_4c_Senha2.Enabled              = par_lHabilitar
2281: 
2282:         *-- Grid.ReadOnly ANTES de Column.ReadOnly (regra #18 - senao o Grid sobrescreve)
2283:         loc_oPg.grd_4c_Estados.ReadOnly            = !par_lHabilitar
2284:         loc_oPg.grd_4c_Estados.Column1.ReadOnly    = !par_lHabilitar
2285:         loc_oPg.grd_4c_Estados.Column2.ReadOnly    = !par_lHabilitar
2286:         loc_oPg.grd_4c_Estados.Column3.ReadOnly    = !par_lHabilitar
2287:         loc_oPg.grd_4c_Estados.Column4.ReadOnly    = !par_lHabilitar
2288:         loc_oPg.grd_4c_Estados.Column5.ReadOnly    = !par_lHabilitar
2289:     ENDPROC
2290: 
2291:     *===========================================================================
2292:     * LimparCampos - Limpa todos os campos da Page2 e a grade de fretes,
2293:     * preparando o formulario para inclusao de novo registro
2294:     *===========================================================================
2295:     PROTECTED PROCEDURE LimparCampos()
2296:         LOCAL loc_oPg
2297:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2298: 
2299:         loc_oPg.txt_4c_Itra.Value                = ""
2300:         loc_oPg.txt_4c_Idtransp.Value            = ""
2301:         loc_oPg.txt_4c_Razao.Value                = ""
2302:         loc_oPg.txt_4c_Endereco.Value             = ""
2303:         loc_oPg.txt_4c_Bairro.Value                = ""
2304:         loc_oPg.txt_4c_Cep.Value                   = ""
2305:         loc_oPg.txt_4c_Cidade.Value                = ""
2306:         loc_oPg.txt_4c_Uf.Value                    = ""
2307:         loc_oPg.txt_4c_Tel1.Value                  = ""
2308:         loc_oPg.txt_4c_Tel2.Value                  = ""
2309:         loc_oPg.txt_4c_Cgc.Value                   = ""
2310:         loc_oPg.txt_4c_Ies.Value                   = ""
2311:         loc_oPg.txt_4c_Fax.Value                   = ""
2312:         loc_oPg.txt_4c_TpConexao.Value             = ""
2313:         loc_oPg.txt_4c_FtpEndereco.Value           = ""
2314:         loc_oPg.txt_4c_FtpUsuario.Value            = ""
2315:         loc_oPg.txt_4c_FtpSenha.Value              = ""
2316:         loc_oPg.txt_4c_DirFtpEnvio.Value           = ""
2317:         loc_oPg.txt_4c_DirFtpRecepcao.Value        = ""
2318:         loc_oPg.txt_4c_DriveGeracao.Value          = ""
2319:         loc_oPg.txt_4c_DriveLeitura.Value          = ""
2320:         loc_oPg.chk_4c_LimpaDiretorioFtp.Value     = 0
2321:         loc_oPg.chk_4c_LimpaDiretorioLocal.Value   = 0
2322:         loc_oPg.txt_4c_UrlTransp.Value             = ""
2323:         loc_oPg.opt_4c_TipoTransporte.Value        = 1
2324:         loc_oPg.txt_4c_Senha2.Value                 = ""
2325: 
2326:         IF USED("cursor_4c_Estados")
2327:             SELECT cursor_4c_Estados
2328:             ZAP
2329:         ENDIF
2330:         loc_oPg.grd_4c_Estados.Refresh()
2331:     ENDPROC
2332: 
2333:     *===========================================================================
2334:     * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
2335:     * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
2336:     * PUBLIC: harness TesteAutomatico.prg chama direto de fora da classe (regra #3)
2337:     *===========================================================================
2338:     PROCEDURE AjustarBotoesPorModo()
2339:         LOCAL loc_oPagina, loc_lEditando
2340:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
2341:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2342: 
2343:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
2344:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2345:     ENDPROC
2346: 
2347:     *===========================================================================
2348:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2349:     * REGRA: Deve iterar Pages E Controls para PageFrames aninhados
2350:     *===========================================================================
2351:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2352:         LOCAL loc_nI, loc_oObjeto, loc_nP
2353: 
2354:         IF VARTYPE(par_oContainer) != "O"
2355:             RETURN
2356:         ENDIF
2357: 
2358:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2359:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2360: 
2361:             IF VARTYPE(loc_oObjeto) = "O"
2362:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2363:                     loc_oObjeto.Visible = .T.
2364:                 ENDIF
2365: 
2366:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2367:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2368:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2369:                     ENDFOR
2370:                 ENDIF
2371: 
2372:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2373:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2374:                 ENDIF
2375:             ENDIF
2376:         ENDFOR
2377:     ENDPROC
2378: 
2379:     *===========================================================================
2380:     * Destroy - Libera recursos ao fechar o formulario
2381:     *===========================================================================
2382:     PROCEDURE Destroy()
2383:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2384:             THIS.this_oBusinessObject = .NULL.
2385:         ENDIF
2386: 
2387:         IF USED("cursor_4c_Dados")
2388:             USE IN cursor_4c_Dados
2389:         ENDIF
2390: 
2391:         IF USED("cursor_4c_Estados")
2392:             USE IN cursor_4c_Estados
2393:         ENDIF
2394: 
2395:         IF USED("cursor_4c_EstadosTemp")
2396:             USE IN cursor_4c_EstadosTemp
2397:         ENDIF
2398: 
2399:         IF USED("cursor_4c_BuscaUf")
2400:             USE IN cursor_4c_BuscaUf
2401:         ENDIF
2402: 
2403:         IF USED("cursor_4c_BuscaMunicipio")
2404:             USE IN cursor_4c_BuscaMunicipio
2405:         ENDIF
2406: 
2407:         IF USED("cursor_4c_BuscaTra")
2408:             USE IN cursor_4c_BuscaTra
2409:         ENDIF
2410: 
2411:         DODEFAULT()
2412:     ENDPROC
2413: 
2414: ENDDEFINE


### BO (C:\4c\projeto\app\classes\traBO.prg):
*====================================================================
* traBO.prg
*
* Business Object para Cadastro de Transportadoras
* Tabela: SigPrTrp (cabecalho) / SigPrTrv (fretes por estado - detalhe)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS traBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTrp)
    this_cCodigo             = ""    && itras char(10) - PK
    this_nCodigoSequencial   = 0     && codigos numeric(6,0) - sequencial usado para gerar o itras
    this_cRazaoSocial        = ""    && razaos char(40)
    this_cEndereco           = ""    && endes char(40)
    this_cBairro             = ""    && bairs char(20)
    this_cCidade             = ""    && cidas char(30)
    this_cCep                = ""    && ceps char(9)
    this_cUf                 = ""    && estas char(2)
    this_cTelefone1          = ""    && tel1s char(20)
    this_cTelefone2          = ""    && tel2s char(20)
    this_cFax                = ""    && faxs char(20)
    this_cCgc                = ""    && cgcs char(20)
    this_cInscricaoEstadual  = ""    && inscs char(20)
    this_cApelido            = ""    && apelidos char(30) NULL
    this_cIdTransportadora   = ""    && idtransp char(50) - rotulado "ID E-Commerce" no legado
    this_cTipoConexao        = ""    && tpconexao char(1) - D/B (Dial-Up / Banda Larga)
    this_cFtpEndereco        = ""    && ftpend char(50)
    this_cFtpUsuario         = ""    && ftpusuario char(50)
    this_cFtpSenha           = ""    && ftpsenha char(20)
    this_cDirFtpEnvio        = ""    && dirftpts char(60) - "Pasta p/ Envio"
    this_cDirFtpRecepcao     = ""    && dirftpls char(60) - "Pasta p/ Recepcao"
    this_cDriveGeracao       = ""    && drivets char(60) - "Geracao"
    this_cDriveLeitura       = ""    && drivels char(60) - "Leitura"
    this_lLimpaDiretorioFtp  = .F.   && ftpdel bit NULL
    this_lLimpaDiretorioLocal = .F.  && locdel bit NULL
    this_cUrlTransp          = ""    && urltransp char(200)
    this_nTipoTransporte     = 0     && tipotrans numeric(1,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTrp"
            THIS.this_cCampoChave = "itras"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "traBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo             = TratarNulo(itras,      "C")
                THIS.this_cRazaoSocial        = TratarNulo(razaos,     "C")
                THIS.this_nCodigoSequencial   = TratarNulo(codigos,    "N")
                THIS.this_cEndereco           = TratarNulo(endes,      "C")
                THIS.this_cBairro             = TratarNulo(bairs,      "C")
                THIS.this_cCidade             = TratarNulo(cidas,      "C")
                THIS.this_cCep                = TratarNulo(ceps,       "C")
                THIS.this_cUf                 = TratarNulo(estas,      "C")
                THIS.this_cTelefone1          = TratarNulo(tel1s,      "C")
                THIS.this_cTelefone2          = TratarNulo(tel2s,      "C")
                THIS.this_cFax                = TratarNulo(faxs,       "C")
                THIS.this_cCgc                = TratarNulo(cgcs,       "C")
                THIS.this_cInscricaoEstadual  = TratarNulo(inscs,      "C")
                THIS.this_cApelido            = TratarNulo(apelidos,   "C")
                THIS.this_cIdTransportadora   = TratarNulo(idtransp,   "C")
                THIS.this_cTipoConexao        = TratarNulo(tpconexao,  "C")
                THIS.this_cFtpEndereco        = TratarNulo(ftpend,     "C")
                THIS.this_cFtpUsuario         = TratarNulo(ftpusuario, "C")
                THIS.this_cFtpSenha           = TratarNulo(ftpsenha,   "C")
                THIS.this_cDirFtpEnvio        = TratarNulo(dirftpts,   "C")
                THIS.this_cDirFtpRecepcao     = TratarNulo(dirftpls,   "C")
                THIS.this_cDriveGeracao       = TratarNulo(drivets,    "C")
                THIS.this_cDriveLeitura       = TratarNulo(drivels,    "C")
                THIS.this_lLimpaDiretorioFtp  = ConverterParaLogico(ftpdel)
                THIS.this_lLimpaDiretorioLocal = ConverterParaLogico(locdel)
                THIS.this_cUrlTransp          = TratarNulo(urltransp,  "C")
                THIS.this_nTipoTransporte     = TratarNulo(tipotrans,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "traBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Gera codigo (itras) para novo registro
    * Legado: m.Codigos = fGerUniqueKey('SigPrTrp' + _Empr)
    *         m.Itras   = 'T' + _Empr + Padl(m.codigos, 6, '0')
    * Aqui o sequencial vem do MAX(codigos) da propria tabela (seguro entre
    * sessoes), e _Empr (legado) -> go_4c_Sistema.cCodEmpresa
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        LOCAL loc_cSQL, loc_nResultado, loc_nSeq, loc_cEmpresa
        loc_nSeq = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(codigos),0) AS maxval FROM SigPrTrp"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SeqTra")
            IF loc_nResultado >= 0 AND USED("cursor_4c_SeqTra")
                SELECT cursor_4c_SeqTra
                loc_nSeq = NVL(cursor_4c_SeqTra.maxval, 0) + 1
                USE IN cursor_4c_SeqTra
            ENDIF
        CATCH TO loException
            loc_nSeq = 1
        ENDTRY

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
            ALLTRIM(go_4c_Sistema.cCodEmpresa), "")

        THIS.this_nCodigoSequencial = loc_nSeq
        THIS.this_cCodigo           = "T" + loc_cEmpresa + PADL(TRANSFORM(loc_nSeq), 6, "0")
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo Inv" + CHR(225) + "lido."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado."
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cRazaoSocial))
            THIS.this_cMensagemErro = "Raz" + CHR(227) + "o Social " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se itras ja existe no banco
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigPrTrp" + ;
                " WHERE itras = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTra")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkTra")
                SELECT cursor_4c_ChkTra
                loc_lExiste = (cursor_4c_ChkTra.qtd > 0)
                USE IN cursor_4c_ChkTra
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "traBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrTrp
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTrp (itras, razaos, codigos, endes, bairs, cidas, ceps, estas,
                    tel1s, tel2s, faxs, cgcs, inscs, apelidos, idtransp, dirftpls, dirftpts,
                    drivels, drivets, ftpdel, ftpend, ftpsenha, ftpusuario, locdel, tpconexao,
                    urltransp, tipotrans)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cRazaoSocial)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodigoSequencial, 0)>>,
                    <<EscaparSQL(THIS.this_cEndereco)>>,
                    <<EscaparSQL(THIS.this_cBairro)>>,
                    <<EscaparSQL(THIS.this_cCidade)>>,
                    <<EscaparSQL(THIS.this_cCep)>>,
                    <<EscaparSQL(THIS.this_cUf)>>,
                    <<EscaparSQL(THIS.this_cTelefone1)>>,
                    <<EscaparSQL(THIS.this_cTelefone2)>>,
                    <<EscaparSQL(THIS.this_cFax)>>,
                    <<EscaparSQL(THIS.this_cCgc)>>,
                    <<EscaparSQL(THIS.this_cInscricaoEstadual)>>,
                    <<EscaparSQL(THIS.this_cApelido)>>,
                    <<EscaparSQL(THIS.this_cIdTransportadora)>>,
                    <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    <<EscaparSQL(THIS.this_cDriveLeitura)>>,
                    <<EscaparSQL(THIS.this_cDriveGeracao)>>,
                    <<IIF(THIS.this_lLimpaDiretorioFtp, 1, 0)>>,
                    <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    <<IIF(THIS.this_lLimpaDiretorioLocal, 1, 0)>>,
                    <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    <<EscaparSQL(THIS.this_cUrlTransp)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipoTransporte, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "traBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrTrp
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTrp
                SET razaos      = <<EscaparSQL(THIS.this_cRazaoSocial)>>,
                    endes       = <<EscaparSQL(THIS.this_cEndereco)>>,
                    bairs       = <<EscaparSQL(THIS.this_cBairro)>>,
                    cidas       = <<EscaparSQL(THIS.this_cCidade)>>,
                    ceps        = <<EscaparSQL(THIS.this_cCep)>>,
                    estas       = <<EscaparSQL(THIS.this_cUf)>>,
                    tel1s       = <<EscaparSQL(THIS.this_cTelefone1)>>,
                    tel2s       = <<EscaparSQL(THIS.this_cTelefone2)>>,
                    faxs        = <<EscaparSQL(THIS.this_cFax)>>,
                    cgcs        = <<EscaparSQL(THIS.this_cCgc)>>,
                    inscs       = <<EscaparSQL(THIS.this_cInscricaoEstadual)>>,
                    apelidos    = <<EscaparSQL(THIS.this_cApelido)>>,
                    idtransp    = <<EscaparSQL(THIS.this_cIdTransportadora)>>,
                    dirftpls    = <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    dirftpts    = <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    drivels     = <<EscaparSQL(THIS.this_cDriveLeitura)>>,
                    drivets     = <<EscaparSQL(THIS.this_cDriveGeracao)>>,
                    ftpdel      = <<IIF(THIS.this_lLimpaDiretorioFtp, 1, 0)>>,
                    ftpend      = <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    ftpsenha    = <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    ftpusuario  = <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    locdel      = <<IIF(THIS.this_lLimpaDiretorioLocal, 1, 0)>>,
                    tpconexao   = <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    urltransp   = <<EscaparSQL(THIS.this_cUrlTransp)>>,
                    tipotrans   = <<FormatarNumeroSQL(THIS.this_nTipoTransporte, 0)>>
                WHERE itras = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "traBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrTrp e os fretes
    * por estado associados (SigPrTrv), espelhando o legado
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTrv WHERE itras = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir fretes da transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPrTrp WHERE itras = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "traBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com itras, razaos, cidas, estas, cgcs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (itras C(10), razaos C(40), cidas C(30), estas C(2), cgcs C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT itras, razaos, cidas, estas, cgcs FROM SigPrTrp"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY razaos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar transportadoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "traBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (itras)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT itras, razaos, codigos, endes, bairs, cidas, ceps, estas,
                    tel1s, tel2s, faxs, cgcs, inscs, apelidos, idtransp, dirftpls,
                    dirftpts, drivels, drivets, ftpdel, ftpend, ftpsenha, ftpusuario,
                    locdel, tpconexao, urltransp, tipotrans
                FROM SigPrTrp
                WHERE itras = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    THIS.this_cMensagemErro = "Transportadora n" + CHR(227) + "o encontrada!"
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "traBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

