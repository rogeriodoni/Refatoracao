# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Top original=32 vs migrado 'lbl_4c_Label18' Top=481 (diff=449px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Left original=72 vs migrado 'lbl_4c_Label18' Left=301 (diff=229px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=171 vs migrado 'cnt_4c_Botoes' Top=29 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=959 vs migrado 'cnt_4c_Botoes' Left=0 (diff=959px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblGrupo' (parent: SIGCDPRO.Pagina.Lista.cntFiltros): Top original=18 vs migrado 'lbl_4c_LblGrupo' Top=265 (diff=247px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblGrupo' (parent: SIGCDPRO.Pagina.Lista.cntFiltros): Left original=21 vs migrado 'lbl_4c_LblGrupo' Left=73 (diff=52px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4095 linhas total):

*-- Linhas 53 a 61:
53:                 THIS.ConfigurarPageFrame()
54:                 THIS.ConfigurarPaginaLista()
55:                 THIS.ConfigurarPaginaDados()
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57: 
58:                 *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
59:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
60:                     IF !THIS.CarregarLista()
61:                         *-- Se falhar ao carregar, nao impede abertura

*-- Linhas 78 a 106:
78: 
79:     *--------------------------------------------------------------------------
80:     * ConfigurarPageFrame - Configura o PageFrame principal
81:     * Legado: Pagina Width=1003, PageFrame.Top=-29 (oculta abas)
82:     *--------------------------------------------------------------------------
83:     PROTECTED PROCEDURE ConfigurarPageFrame()
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85: 
86:         WITH THIS.pgf_4c_Paginas
87:             .Top       = -29
88:             .Left      = 0
89:             .Width     = 1003
90:             .Height    = 600
91:             .PageCount = 2
92:             .Tabs      = .F.
93:             .Visible   = .T.
94: 
95:             *-- Page1 - Lista
96:             .Page1.Caption   = "Lista"
97:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page1.BackColor = RGB(255, 255, 255)
99: 
100:             *-- Page2 - Dados
101:             .Page2.Caption   = "Dados"
102:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:             .Page2.BackColor = RGB(255, 255, 255)
104:         ENDWITH
105:     ENDPROC
106: 

*-- Linhas 116 a 453:
116:         *-- Container de cabecalho escuro (Top=2 na tela -> Top=31 na Page)
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = 1003
122:             .Height      = 80
123:             .BackStyle   = 1
124:             .BackColor   = RGB(53, 53, 53)
125:             .BorderWidth = 0
126:             .Visible     = .T.
127:         ENDWITH
128: 
129:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
130:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
131:             .Caption   = "Cadastro de Produtos"
132:             .Top       = 20
133:             .Left      = 20
134:             .Width     = 400
135:             .Height    = 30
136:             .FontName  = "Tahoma"
137:             .FontSize  = 14
138:             .FontBold  = .T.
139:             .BackStyle = 0
140:             .ForeColor = RGB(255, 255, 255)
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         *-- Container de botoes CRUD (sobrepoem o cabecalho escuro)
145:         *-- Top=0 no legado -> Top=29 (compensa PageFrame.Top=-29)
146:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
147:         WITH loc_oPagina.cnt_4c_Botoes
148:             .Top         = 29
149:             .Left        = 0
150:             .Width       = 540
151:             .Height      = 85
152:             .BackStyle   = 0
153:             .BorderWidth = 0
154:             .Visible     = .T.
155:         ENDWITH
156: 
157:         *-- Botao Incluir
158:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
159:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
160:             .Caption         = "Incluir"
161:             .Width           = 75
162:             .Height          = 75
163:             .Left            = 5
164:             .Top             = 5
165:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
166:             .PicturePosition = 13
167:             .FontName        = "Tahoma"
168:             .FontSize        = 8
169:             .Themes          = .F.
170:             .SpecialEffect   = 0
171:             .BackColor       = RGB(255, 255, 255)
172:             .ForeColor       = RGB(90, 90, 90)
173:             .Visible         = .T.
174:         ENDWITH
175:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
176: 
177:         *-- Botao Visualizar
178:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
179:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
180:             .Caption         = "Visualizar"
181:             .Width           = 75
182:             .Height          = 75
183:             .Left            = 80
184:             .Top             = 5
185:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
186:             .PicturePosition = 13
187:             .FontName        = "Tahoma"
188:             .FontSize        = 8
189:             .Themes          = .F.
190:             .SpecialEffect   = 0
191:             .BackColor       = RGB(255, 255, 255)
192:             .ForeColor       = RGB(90, 90, 90)
193:             .Visible         = .T.
194:         ENDWITH
195:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
196: 
197:         *-- Botao Alterar
198:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
199:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
200:             .Caption         = "Alterar"
201:             .Width           = 75
202:             .Height          = 75
203:             .Left            = 155
204:             .Top             = 5
205:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
206:             .PicturePosition = 13
207:             .FontName        = "Tahoma"
208:             .FontSize        = 8
209:             .Themes          = .F.
210:             .SpecialEffect   = 0
211:             .BackColor       = RGB(255, 255, 255)
212:             .ForeColor       = RGB(90, 90, 90)
213:             .Visible         = .T.
214:         ENDWITH
215:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
216: 
217:         *-- Botao Excluir
218:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
219:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
220:             .Caption         = "Excluir"
221:             .Width           = 75
222:             .Height          = 75
223:             .Left            = 230
224:             .Top             = 5
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
226:             .PicturePosition = 13
227:             .FontName        = "Tahoma"
228:             .FontSize        = 8
229:             .Themes          = .F.
230:             .SpecialEffect   = 0
231:             .BackColor       = RGB(255, 255, 255)
232:             .ForeColor       = RGB(90, 90, 90)
233:             .Visible         = .T.
234:         ENDWITH
235:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
236: 
237:         *-- Botao Buscar (aplica filtro da cnt_4c_Filtros)
238:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
239:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
240:             .Caption         = "Buscar"
241:             .Width           = 75
242:             .Height          = 75
243:             .Left            = 305
244:             .Top             = 5
245:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
246:             .PicturePosition = 13
247:             .FontName        = "Tahoma"
248:             .FontSize        = 8
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .BackColor       = RGB(255, 255, 255)
252:             .ForeColor       = RGB(90, 90, 90)
253:             .Visible         = .T.
254:         ENDWITH
255:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
256: 
257:         *-- Container de saida (Encerrar, alinhado a direita)
258:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
259:         WITH loc_oPagina.cnt_4c_Saida
260:             .Top         = 29
261:             .Left        = 917
262:             .Width       = 90
263:             .Height      = 85
264:             .BackStyle   = 0
265:             .BorderWidth = 0
266:             .Visible     = .T.
267:         ENDWITH
268: 
269:         *-- Botao Encerrar
270:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
271:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
272:             .Caption         = "Encerrar"
273:             .Width           = 75
274:             .Height          = 75
275:             .Left            = 5
276:             .Top             = 5
277:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
278:             .PicturePosition = 13
279:             .FontName        = "Tahoma"
280:             .FontSize        = 8
281:             .Themes          = .F.
282:             .SpecialEffect   = 0
283:             .BackColor       = RGB(255, 255, 255)
284:             .ForeColor       = RGB(90, 90, 90)
285:             .Visible         = .T.
286:         ENDWITH
287:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
288: 
289:         *-- Container de filtros (Grupo, Data ultima alteracao, Situacao)
290:         *-- Legado: cntFiltros
291:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
292:         loc_oFiltros = loc_oPagina.cnt_4c_Filtros
293:         WITH loc_oFiltros
294:             .Top         = 114
295:             .Left        = 0
296:             .Width       = 1003
297:             .Height      = 70
298:             .BackStyle   = 1
299:             .BackColor   = RGB(240, 240, 240)
300:             .BorderWidth = 0
301:             .Visible     = .T.
302:         ENDWITH
303: 
304:         *-- Linha 1: Grupo de Produto
305:         loc_oFiltros.AddObject("lbl_4c_Grupo", "Label")
306:         WITH loc_oFiltros.lbl_4c_Grupo
307:             .Caption   = "Grupo de Produto :"
308:             .Top       = 18
309:             .Left      = 21
310:             .Width     = 94
311:             .Height    = 15
312:             .FontName  = "Tahoma"
313:             .FontSize  = 8
314:             .BackStyle = 0
315:             .ForeColor = RGB(0, 0, 0)
316:             .Visible   = .T.
317:         ENDWITH
318: 
319:         loc_oFiltros.AddObject("txt_4c_Cgru", "TextBox")
320:         WITH loc_oFiltros.txt_4c_Cgru
321:             .Value     = ""
322:             .Top       = 14
323:             .Left      = 116
324:             .Width     = 31
325:             .Height    = 23
326:             .FontName  = "Tahoma"
327:             .FontSize  = 8
328:             .Visible   = .T.
329:         ENDWITH
330: 
331:         loc_oFiltros.AddObject("txt_4c_Dgru", "TextBox")
332:         WITH loc_oFiltros.txt_4c_Dgru
333:             .Value     = ""
334:             .Top       = 14
335:             .Left      = 149
336:             .Width     = 156
337:             .Height    = 23
338:             .FontName  = "Tahoma"
339:             .FontSize  = 8
340:             .ReadOnly  = .T.
341:             .BackColor = RGB(240, 240, 240)
342:             .Visible   = .T.
343:         ENDWITH
344: 
345:         *-- Situacao: Todos / Ativos / Inativos
346:         loc_oFiltros.AddObject("opt_4c_Situas", "OptionGroup")
347:         WITH loc_oFiltros.opt_4c_Situas
348:             .Top         = 10
349:             .Left        = 315
350:             .Width       = 156
351:             .Height      = 22
352:             .ButtonCount = 3
353:             .Value       = 1
354:             .Themes      = .F.
355:             .Visible     = .T.
356:             .Buttons(1).Caption   = "Todos"
357:             .Buttons(1).Left      = 0
358:             .Buttons(1).Top       = 0
359:             .Buttons(1).Width     = 50
360:             .Buttons(1).Height    = 22
361:             .Buttons(1).AutoSize  = .F.
362:             .Buttons(1).ForeColor = RGB(0, 0, 0)
363:             .Buttons(1).Themes    = .F.
364:             .Buttons(2).Caption   = "Ativos"
365:             .Buttons(2).Left      = 52
366:             .Buttons(2).Top       = 0
367:             .Buttons(2).Width     = 50
368:             .Buttons(2).Height    = 22
369:             .Buttons(2).AutoSize  = .F.
370:             .Buttons(2).ForeColor = RGB(0, 0, 0)
371:             .Buttons(2).Themes    = .F.
372:             .Buttons(3).Caption   = "Inativos"
373:             .Buttons(3).Left      = 104
374:             .Buttons(3).Top       = 0
375:             .Buttons(3).Width     = 52
376:             .Buttons(3).Height    = 22
377:             .Buttons(3).AutoSize  = .F.
378:             .Buttons(3).ForeColor = RGB(0, 0, 0)
379:             .Buttons(3).Themes    = .F.
380:         ENDWITH
381:         BINDEVENT(loc_oFiltros.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")
382: 
383:         *-- Linha 2: Data ultima alteracao
384:         loc_oFiltros.AddObject("lbl_4c_DtAlt", "Label")
385:         WITH loc_oFiltros.lbl_4c_DtAlt
386:             .Caption   = CHR(218) + "ltima Altera" + CHR(231) + CHR(227) + "o :"
387:             .Top       = 43
388:             .Left      = 28
389:             .Width     = 87
390:             .Height    = 15
391:             .FontName  = "Tahoma"
392:             .FontSize  = 8
393:             .BackStyle = 0
394:             .ForeColor = RGB(0, 0, 0)
395:             .Visible   = .T.
396:         ENDWITH
397: 
398:         loc_oFiltros.AddObject("txt_4c_DtIni", "TextBox")
399:         WITH loc_oFiltros.txt_4c_DtIni
400:             .Value     = {}
401:             .Top       = 39
402:             .Left      = 116
403:             .Width     = 84
404:             .Height    = 23
405:             .FontName  = "Tahoma"
406:             .FontSize  = 8
407:             .Visible   = .T.
408:         ENDWITH
409: 
410:         loc_oFiltros.AddObject("lbl_4c_Ate", "Label")
411:         WITH loc_oFiltros.lbl_4c_Ate
412:             .Caption   = "at" + CHR(233)
413:             .Top       = 43
414:             .Left      = 202
415:             .Width     = 18
416:             .Height    = 15
417:             .FontName  = "Tahoma"
418:             .FontSize  = 8
419:             .BackStyle = 0
420:             .ForeColor = RGB(0, 0, 0)
421:             .Visible   = .T.
422:         ENDWITH
423: 
424:         loc_oFiltros.AddObject("txt_4c_DtFim", "TextBox")
425:         WITH loc_oFiltros.txt_4c_DtFim
426:             .Value     = {}
427:             .Top       = 39
428:             .Left      = 225
429:             .Width     = 84
430:             .Height    = 23
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .Visible   = .T.
434:         ENDWITH
435: 
436:         *-- Cursor placeholder ANTES do grid (campo L evita "Data type mismatch" no CheckBox)
437:         SET NULL ON
438:         IF USED("cursor_4c_Dados")
439:             USE IN cursor_4c_Dados
440:         ENDIF
441:         CREATE CURSOR cursor_4c_Dados (cpros C(14), dpros C(65), dpro2s C(45), cgrus C(3), sgrus C(6), reffs C(40), chkInstalas L, dtalts T, usuaalts C(20), situas N(1))
442:         SET NULL OFF
443: 
444:         *-- Grid principal da lista (7 colunas, fiel ao legado)
445:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
446:         WITH loc_oPagina.grd_4c_Dados
447:             .Top               = 192
448:             .Left              = 0
449:             .Width             = 1003
450:             .Height            = 380
451:             .ColumnCount       = 7
452:             .RecordSourceType  = 1
453:             .ReadOnly          = .T.

*-- Linhas 471 a 481:
471:         loc_oPagina.grd_4c_Dados.Column6.Width = 100
472:         loc_oPagina.grd_4c_Dados.Column7.Width = 40
473: 
474:         *-- Column7: CheckBox para chkInstalas (coluna I = Instalavel)
475:         loc_oPagina.grd_4c_Dados.Column7.ColumnCount = 1
476:         loc_oPagina.grd_4c_Dados.Column7.AddObject("Check1", "CheckBox")
477:         loc_oPagina.grd_4c_Dados.Column7.CurrentControl = "Check1"
478:         loc_oPagina.grd_4c_Dados.Column7.Sparse = .F.
479: 
480:         *-- Tornar controles visiveis
481:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 490 a 620:
490:         LOCAL loc_oPagina
491:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
492: 
493:         *-- Container de botoes de acao (Salvar, Cancelar)
494:         *-- Legado: Grupo_Salva.Top=9 na tela -> Top=38 na Page2
495:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
496:         WITH loc_oPagina.cnt_4c_BotoesAcao
497:             .Top         = 38
498:             .Left        = 819
499:             .Width       = 165
500:             .Height      = 85
501:             .BackStyle   = 0
502:             .BorderWidth = 0
503:             .Visible     = .T.
504:         ENDWITH
505: 
506:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
507:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
508:             .Caption         = "Salvar"
509:             .Width           = 75
510:             .Height          = 75
511:             .Left            = 5
512:             .Top             = 5
513:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
514:             .PicturePosition = 13
515:             .FontName        = "Tahoma"
516:             .FontSize        = 8
517:             .Themes          = .F.
518:             .SpecialEffect   = 0
519:             .BackColor       = RGB(255, 255, 255)
520:             .ForeColor       = RGB(90, 90, 90)
521:         ENDWITH
522:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
523: 
524:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
525:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
526:             .Caption         = "Cancelar"
527:             .Width           = 75
528:             .Height          = 75
529:             .Left            = 80
530:             .Top             = 5
531:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
532:             .PicturePosition = 13
533:             .FontName        = "Tahoma"
534:             .FontSize        = 8
535:             .Themes          = .F.
536:             .SpecialEffect   = 0
537:             .BackColor       = RGB(255, 255, 255)
538:             .ForeColor       = RGB(90, 90, 90)
539:         ENDWITH
540:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
541: 
542:         *-- OptionGroup navegacao de abas (7 abas, simula tabs do pgframeDados oculto)
543:         *-- Legado: Optiongroup1.Top=5 na tela -> Top=34 na Page2, Width=535, Height=85
544:         loc_oPagina.AddObject("opt_4c_Abas", "OptionGroup")
545:         WITH loc_oPagina.opt_4c_Abas
546:             .Top         = 34
547:             .Left        = 5
548:             .Width       = 535
549:             .Height      = 85
550:             .ButtonCount = 7
551:             .Value       = 1
552:             .Themes      = .F.
553:             .Buttons(1).Caption   = "Dados"
554:             .Buttons(1).Left      = 0
555:             .Buttons(1).Top       = 0
556:             .Buttons(1).Width     = 75
557:             .Buttons(1).Height    = 85
558:             .Buttons(1).AutoSize  = .F.
559:             .Buttons(1).FontName  = "Tahoma"
560:             .Buttons(1).FontSize  = 8
561:             .Buttons(1).ForeColor = RGB(0, 0, 0)
562:             .Buttons(1).Themes    = .F.
563:             .Buttons(2).Caption   = "Composi" + CHR(231) + CHR(227) + "o"
564:             .Buttons(2).Left      = 76
565:             .Buttons(2).Top       = 0
566:             .Buttons(2).Width     = 75
567:             .Buttons(2).Height    = 85
568:             .Buttons(2).AutoSize  = .F.
569:             .Buttons(2).FontName  = "Tahoma"
570:             .Buttons(2).FontSize  = 8
571:             .Buttons(2).ForeColor = RGB(0, 0, 0)
572:             .Buttons(2).Themes    = .F.
573:             .Buttons(3).Caption   = "Fiscal"
574:             .Buttons(3).Left      = 152
575:             .Buttons(3).Top       = 0
576:             .Buttons(3).Width     = 75
577:             .Buttons(3).Height    = 85
578:             .Buttons(3).AutoSize  = .F.
579:             .Buttons(3).FontName  = "Tahoma"
580:             .Buttons(3).FontSize  = 8
581:             .Buttons(3).ForeColor = RGB(0, 0, 0)
582:             .Buttons(3).Themes    = .F.
583:             .Buttons(4).Caption   = "Fases P."
584:             .Buttons(4).Left      = 228
585:             .Buttons(4).Top       = 0
586:             .Buttons(4).Width     = 75
587:             .Buttons(4).Height    = 85
588:             .Buttons(4).AutoSize  = .F.
589:             .Buttons(4).FontName  = "Tahoma"
590:             .Buttons(4).FontSize  = 8
591:             .Buttons(4).ForeColor = RGB(0, 0, 0)
592:             .Buttons(4).Themes    = .F.
593:             .Buttons(5).Caption   = "Cons. P."
594:             .Buttons(5).Left      = 304
595:             .Buttons(5).Top       = 0
596:             .Buttons(5).Width     = 75
597:             .Buttons(5).Height    = 85
598:             .Buttons(5).AutoSize  = .F.
599:             .Buttons(5).FontName  = "Tahoma"
600:             .Buttons(5).FontSize  = 8
601:             .Buttons(5).ForeColor = RGB(0, 0, 0)
602:             .Buttons(5).Themes    = .F.
603:             .Buttons(6).Caption   = "Custo"
604:             .Buttons(6).Left      = 380
605:             .Buttons(6).Top       = 0
606:             .Buttons(6).Width     = 75
607:             .Buttons(6).Height    = 85
608:             .Buttons(6).AutoSize  = .F.
609:             .Buttons(6).FontName  = "Tahoma"
610:             .Buttons(6).FontSize  = 8
611:             .Buttons(6).ForeColor = RGB(0, 0, 0)
612:             .Buttons(6).Themes    = .F.
613:             .Buttons(7).Caption   = "Designer"
614:             .Buttons(7).Left      = 456
615:             .Buttons(7).Top       = 0
616:             .Buttons(7).Width     = 79
617:             .Buttons(7).Height    = 85
618:             .Buttons(7).AutoSize  = .F.
619:             .Buttons(7).FontName  = "Tahoma"
620:             .Buttons(7).FontSize  = 8

*-- Linhas 626 a 646:
626:         *-- Inner PageFrame (pgframeDados: Top=-54, Left=-1 na Page2, 7 paginas sem abas)
627:         loc_oPagina.AddObject("pgf_4c_DadosPrd", "PageFrame")
628:         WITH loc_oPagina.pgf_4c_DadosPrd
629:             .Top       = -54
630:             .Left      = -1
631:             .Width     = 1003
632:             .Height    = 656
633:             .PageCount = 7
634:             .Tabs      = .F.
635:             .Page1.Caption = "Dados"
636:             .Page2.Caption = "Composi" + CHR(231) + CHR(227) + "o"
637:             .Page3.Caption = "Fiscal"
638:             .Page4.Caption = "Fases P."
639:             .Page5.Caption = "Cons. P."
640:             .Page6.Caption = "Custo"
641:             .Page7.Caption = "Designer"
642:         ENDWITH
643: 
644:         *-- Configurar controles da aba Dados (pgDados = Page1 do pgf_4c_DadosPrd)
645:         THIS.ConfigurarPgDados()
646: 

*-- Linhas 663 a 1823:
663:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
664: 
665:         *-- Botoes de imagem do produto (form-abs Top=33 -> 116)
666:         loc_oPgDados.AddObject("cmd_4c_Produto", "CommandButton")
667:         WITH loc_oPgDados.cmd_4c_Produto
668:             .Caption       = "Foto"
669:             .Top           = 116
670:             .Left          = 623
671:             .Width         = 85
672:             .Height        = 85
673:             .FontName      = "Tahoma"
674:             .FontSize      = 8
675:             .Themes        = .F.
676:             .SpecialEffect = 0
677:             .BackColor     = RGB(240, 240, 240)
678:             .ForeColor     = RGB(90, 90, 90)
679:         ENDWITH
680: 
681:         loc_oPgDados.AddObject("cmd_4c_Arquivos", "CommandButton")
682:         WITH loc_oPgDados.cmd_4c_Arquivos
683:             .Caption       = "Arquivos"
684:             .Top           = 116
685:             .Left          = 698
686:             .Width         = 85
687:             .Height        = 85
688:             .FontName      = "Tahoma"
689:             .FontSize      = 8
690:             .Themes        = .F.
691:             .SpecialEffect = 0
692:             .BackColor     = RGB(240, 240, 240)
693:             .ForeColor     = RGB(90, 90, 90)
694:         ENDWITH
695: 
696:         *-- === Codigo / Descricao / Situacao (form-abs Top=130 -> 213) ===
697:         loc_oPgDados.AddObject("lbl_4c_Label2", "Label")
698:         WITH loc_oPgDados.lbl_4c_Label2
699:             .Caption   = "Produto :"
700:             .Top       = 134
701:             .Left      = 58
702:             .Width     = 53
703:             .Height    = 15
704:             .FontName  = "Tahoma"
705:             .FontSize  = 8
706:             .BackStyle = 0
707:             .ForeColor = RGB(0, 0, 0)
708:         ENDWITH
709: 
710:         loc_oPgDados.AddObject("txt_4c_Cpro", "TextBox")
711:         WITH loc_oPgDados.txt_4c_Cpro
712:             .Top      = 213
713:             .Left     = 113
714:             .Width    = 108
715:             .Height   = 23
716:             .FontName = "Tahoma"
717:             .FontSize = 8
718:             .Value    = ""
719:         ENDWITH
720: 
721:         loc_oPgDados.AddObject("txt_4c_Dpro", "TextBox")
722:         WITH loc_oPgDados.txt_4c_Dpro
723:             .Top      = 213
724:             .Left     = 222
725:             .Width    = 290
726:             .Height   = 23
727:             .FontName = "Tahoma"
728:             .FontSize = 8
729:             .Value    = ""
730:         ENDWITH
731: 
732:         loc_oPgDados.AddObject("opt_4c_Situacao", "OptionGroup")
733:         WITH loc_oPgDados.opt_4c_Situacao
734:             .Top         = 213
735:             .Left        = 735
736:             .Width       = 142
737:             .Height      = 25
738:             .ButtonCount = 2
739:             .Value       = 1
740:             .Themes      = .F.
741:             .Buttons(1).Caption   = "Ativo"
742:             .Buttons(1).Left      = 0
743:             .Buttons(1).Top       = 0
744:             .Buttons(1).Width     = 70
745:             .Buttons(1).Height    = 25
746:             .Buttons(1).AutoSize  = .F.
747:             .Buttons(1).ForeColor = RGB(0, 0, 0)
748:             .Buttons(1).Themes    = .F.
749:             .Buttons(2).Caption   = "Inativo"
750:             .Buttons(2).Left      = 71
751:             .Buttons(2).Top       = 0
752:             .Buttons(2).Width     = 71
753:             .Buttons(2).Height    = 25
754:             .Buttons(2).AutoSize  = .F.
755:             .Buttons(2).ForeColor = RGB(0, 0, 0)
756:             .Buttons(2).Themes    = .F.
757:         ENDWITH
758:         BINDEVENT(loc_oPgDados.opt_4c_Situacao, "InteractiveChange", THIS, "OptSituacaoChange")
759: 
760:         loc_oPgDados.AddObject("txt_4c_DtSituas", "TextBox")
761:         WITH loc_oPgDados.txt_4c_DtSituas
762:             .Top       = 215
763:             .Left      = 878
764:             .Width     = 80
765:             .Height    = 21
766:             .FontName  = "Tahoma"
767:             .FontSize  = 8
768:             .Value     = {}
769:             .ReadOnly  = .T.
770:             .BackColor = RGB(240, 240, 240)
771:         ENDWITH
772: 
773:         *-- Equivalente (form-abs Top=133/137 -> 216/220)
774:         loc_oPgDados.AddObject("lbl_4c_LblEquiv", "Label")
775:         WITH loc_oPgDados.lbl_4c_LblEquiv
776:             .Caption   = "Equivalente :"
777:             .Top       = 220
778:             .Left      = 560
779:             .Width     = 65
780:             .Height    = 15
781:             .FontName  = "Tahoma"
782:             .FontSize  = 8
783:             .BackStyle = 0
784:             .ForeColor = RGB(0, 0, 0)
785:         ENDWITH
786: 
787:         loc_oPgDados.AddObject("txt_4c_CProEq", "TextBox")
788:         WITH loc_oPgDados.txt_4c_CProEq
789:             .Top      = 216
790:             .Left     = 626
791:             .Width    = 108
792:             .Height   = 21
793:             .FontName = "Tahoma"
794:             .FontSize = 8
795:             .Value    = ""
796:         ENDWITH
797:         BINDEVENT(loc_oPgDados.txt_4c_CProEq, "KeyPress", THIS, "KeyPressEquivalente")
798: 
799:         *-- === Descritivo / Lote Minimo / Barra (form-abs Top=154-155 -> 237-238) ===
800:         loc_oPgDados.AddObject("lbl_4c_LblDesc2", "Label")
801:         WITH loc_oPgDados.lbl_4c_LblDesc2
802:             .Caption   = "Descritivo :"
803:             .Top       = 240
804:             .Left      = 55
805:             .Width     = 56
806:             .Height    = 15
807:             .FontName  = "Tahoma"
808:             .FontSize  = 8
809:             .BackStyle = 0
810:             .ForeColor = RGB(0, 0, 0)
811:         ENDWITH
812: 
813:         loc_oPgDados.AddObject("txt_4c_DPro2s", "TextBox")
814:         WITH loc_oPgDados.txt_4c_DPro2s
815:             .Top      = 237
816:             .Left     = 113
817:             .Width    = 399
818:             .Height   = 23
819:             .FontName = "Tahoma"
820:             .FontSize = 8
821:             .Value    = ""
822:         ENDWITH
823: 
824:         loc_oPgDados.AddObject("lbl_4c_LblLtMins", "Label")
825:         WITH loc_oPgDados.lbl_4c_LblLtMins
826:             .Caption   = "Lote M" + CHR(237) + "nimo :"
827:             .Top       = 240
828:             .Left      = 812
829:             .Width     = 65
830:             .Height    = 15
831:             .FontName  = "Tahoma"
832:             .FontSize  = 8
833:             .BackStyle = 0
834:             .ForeColor = RGB(0, 0, 0)
835:         ENDWITH
836: 
837:         loc_oPgDados.AddObject("txt_4c_LtMinsV", "TextBox")
838:         WITH loc_oPgDados.txt_4c_LtMinsV
839:             .Top      = 237
840:             .Left     = 878
841:             .Width    = 80
842:             .Height   = 21
843:             .FontName = "Tahoma"
844:             .FontSize = 8
845:             .Value    = 0
846:         ENDWITH
847: 
848:         loc_oPgDados.AddObject("lbl_4c_LblBarra", "Label")
849:         WITH loc_oPgDados.lbl_4c_LblBarra
850:             .Caption   = "Barra :"
851:             .Top       = 240
852:             .Left      = 590
853:             .Width     = 35
854:             .Height    = 15
855:             .FontName  = "Tahoma"
856:             .FontSize  = 8
857:             .BackStyle = 0
858:             .ForeColor = RGB(0, 0, 0)
859:         ENDWITH
860: 
861:         loc_oPgDados.AddObject("txt_4c_Cbar", "TextBox")
862:         WITH loc_oPgDados.txt_4c_Cbar
863:             .Top      = 238
864:             .Left     = 626
865:             .Width    = 108
866:             .Height   = 21
867:             .FontName = "Tahoma"
868:             .FontSize = 8
869:             .Value    = ""
870:         ENDWITH
871: 
872:         *-- Produto Web OptionGroup (form-abs Top=172/176 -> 255/259, 4 botoes)
873:         loc_oPgDados.AddObject("lbl_4c_LblProdWeb", "Label")
874:         WITH loc_oPgDados.lbl_4c_LblProdWeb
875:             .Caption   = "Produto Web :"
876:             .Top       = 259
877:             .Left      = 805
878:             .Width     = 72
879:             .Height    = 15
880:             .FontName  = "Tahoma"
881:             .FontSize  = 8
882:             .BackStyle = 0
883:             .ForeColor = RGB(0, 0, 0)
884:         ENDWITH
885: 
886:         loc_oPgDados.AddObject("opt_4c_ProdutoWeb", "OptionGroup")
887:         WITH loc_oPgDados.opt_4c_ProdutoWeb
888:             .Top         = 255
889:             .Left        = 879
890:             .Width       = 117
891:             .Height      = 42
892:             .ButtonCount = 4
893:             .Value       = 1
894:             .Themes      = .F.
895:             .Buttons(1).Caption   = "N"
896:             .Buttons(1).Left      = 0
897:             .Buttons(1).Top       = 0
898:             .Buttons(1).Width     = 29
899:             .Buttons(1).Height    = 42
900:             .Buttons(1).AutoSize  = .F.
901:             .Buttons(1).ForeColor = RGB(0, 0, 0)
902:             .Buttons(1).Themes    = .F.
903:             .Buttons(2).Caption   = "S"
904:             .Buttons(2).Left      = 30
905:             .Buttons(2).Top       = 0
906:             .Buttons(2).Width     = 29
907:             .Buttons(2).Height    = 42
908:             .Buttons(2).AutoSize  = .F.
909:             .Buttons(2).ForeColor = RGB(0, 0, 0)
910:             .Buttons(2).Themes    = .F.
911:             .Buttons(3).Caption   = "D"
912:             .Buttons(3).Left      = 60
913:             .Buttons(3).Top       = 0
914:             .Buttons(3).Width     = 29
915:             .Buttons(3).Height    = 42
916:             .Buttons(3).AutoSize  = .F.
917:             .Buttons(3).ForeColor = RGB(0, 0, 0)
918:             .Buttons(3).Themes    = .F.
919:             .Buttons(4).Caption   = "I"
920:             .Buttons(4).Left      = 90
921:             .Buttons(4).Top       = 0
922:             .Buttons(4).Width     = 27
923:             .Buttons(4).Height    = 42
924:             .Buttons(4).AutoSize  = .F.
925:             .Buttons(4).ForeColor = RGB(0, 0, 0)
926:             .Buttons(4).Themes    = .F.
927:         ENDWITH
928:         BINDEVENT(loc_oPgDados.opt_4c_ProdutoWeb, "InteractiveChange", THIS, "OptProdutoWebChange")
929: 
930:         *-- === EAN13 / Grupo / Mercadoria / Identificador (form-abs Top=177-182 -> 260-265) ===
931:         loc_oPgDados.AddObject("lbl_4c_LblEAN", "Label")
932:         WITH loc_oPgDados.lbl_4c_LblEAN
933:             .Caption   = "EAN/GTIN :"
934:             .Top       = 264
935:             .Left      = 568
936:             .Width     = 57
937:             .Height    = 15
938:             .FontName  = "Tahoma"
939:             .FontSize  = 8
940:             .BackStyle = 0
941:             .ForeColor = RGB(0, 0, 0)
942:         ENDWITH
943: 
944:         loc_oPgDados.AddObject("txt_4c_EAN13", "TextBox")
945:         WITH loc_oPgDados.txt_4c_EAN13
946:             .Top      = 260
947:             .Left     = 626
948:             .Width    = 108
949:             .Height   = 21
950:             .FontName = "Tahoma"
951:             .FontSize = 8
952:             .Value    = ""
953:         ENDWITH
954: 
955:         loc_oPgDados.AddObject("lbl_4c_LblGrupo", "Label")
956:         WITH loc_oPgDados.lbl_4c_LblGrupo
957:             .Caption   = "Grupo :"
958:             .Top       = 265
959:             .Left      = 73
960:             .Width     = 38
961:             .Height    = 15
962:             .FontName  = "Tahoma"
963:             .FontSize  = 8
964:             .BackStyle = 0
965:             .ForeColor = RGB(0, 0, 0)
966:         ENDWITH
967: 
968:         loc_oPgDados.AddObject("txt_4c_Cgru", "TextBox")
969:         WITH loc_oPgDados.txt_4c_Cgru
970:             .Top      = 261
971:             .Left     = 113
972:             .Width    = 31
973:             .Height   = 23
974:             .FontName = "Tahoma"
975:             .FontSize = 8
976:             .Value    = ""
977:         ENDWITH
978:         BINDEVENT(loc_oPgDados.txt_4c_Cgru, "KeyPress", THIS, "KeyPressCgru")
979: 
980:         loc_oPgDados.AddObject("txt_4c_Dgru", "TextBox")
981:         WITH loc_oPgDados.txt_4c_Dgru
982:             .Top       = 261
983:             .Left      = 145
984:             .Width     = 171
985:             .Height    = 23
986:             .FontName  = "Tahoma"
987:             .FontSize  = 8
988:             .ReadOnly  = .T.
989:             .BackColor = RGB(240, 240, 240)
990:             .Value     = ""
991:         ENDWITH
992: 
993:         loc_oPgDados.AddObject("txt_4c_Merc", "TextBox")
994:         WITH loc_oPgDados.txt_4c_Merc
995:             .Top      = 261
996:             .Left     = 318
997:             .Width    = 31
998:             .Height   = 23
999:             .FontName = "Tahoma"
1000:             .FontSize = 8
1001:             .Value    = ""
1002:         ENDWITH
1003: 
1004:         loc_oPgDados.AddObject("lbl_4c_LblIdent", "Label")
1005:         WITH loc_oPgDados.lbl_4c_LblIdent
1006:             .Caption   = "Identificador :"
1007:             .Top       = 265
1008:             .Left      = 408
1009:             .Width     = 70
1010:             .Height    = 15
1011:             .FontName  = "Tahoma"
1012:             .FontSize  = 8
1013:             .BackStyle = 0
1014:             .ForeColor = RGB(0, 0, 0)
1015:         ENDWITH
1016: 
1017:         loc_oPgDados.AddObject("txt_4c_IdeCPros", "TextBox")
1018:         WITH loc_oPgDados.txt_4c_IdeCPros
1019:             .Top      = 261
1020:             .Left     = 481
1021:             .Width    = 31
1022:             .Height   = 23
1023:             .FontName = "Tahoma"
1024:             .FontSize = 8
1025:             .Value    = ""
1026:         ENDWITH
1027: 
1028:         *-- === Qtde Minima / Subgrupo / Conjunto / Variacao (form-abs 199-207 -> 282-290) ===
1029:         loc_oPgDados.AddObject("lbl_4c_LblQtmin", "Label")
1030:         WITH loc_oPgDados.lbl_4c_LblQtmin
1031:             .Caption   = "Qtde. M" + CHR(237) + "nima :"
1032:             .Top       = 289
1033:             .Left      = 553
1034:             .Width     = 72
1035:             .Height    = 15
1036:             .FontName  = "Tahoma"
1037:             .FontSize  = 8
1038:             .BackStyle = 0
1039:             .ForeColor = RGB(0, 0, 0)
1040:         ENDWITH
1041: 
1042:         loc_oPgDados.AddObject("txt_4c_Qmin", "TextBox")
1043:         WITH loc_oPgDados.txt_4c_Qmin
1044:             .Top      = 282
1045:             .Left     = 626
1046:             .Width    = 80
1047:             .Height   = 21
1048:             .FontName = "Tahoma"
1049:             .FontSize = 8
1050:             .Value    = 0
1051:         ENDWITH
1052: 
1053:         loc_oPgDados.AddObject("cmd_4c_CmdQtMin", "CommandButton")
1054:         WITH loc_oPgDados.cmd_4c_CmdQtMin
1055:             .Caption       = ". . ."
1056:             .Top           = 199
1057:             .Left          = 709
1058:             .Width         = 25
1059:             .Height        = 23
1060:             .FontName      = "Tahoma"
1061:             .FontSize      = 8
1062:             .Themes        = .F.
1063:             .SpecialEffect = 0
1064:         ENDWITH
1065:         BINDEVENT(loc_oPgDados.cmd_4c_CmdQtMin, "Click", THIS, "BtnQtMinClick")
1066: 
1067:         loc_oPgDados.AddObject("lbl_4c_LblSubgrp", "Label")
1068:         WITH loc_oPgDados.lbl_4c_LblSubgrp
1069:             .Caption   = "Subgrupo :"
1070:             .Top       = 286
1071:             .Left      = 56
1072:             .Width     = 55
1073:             .Height    = 15
1074:             .FontName  = "Tahoma"
1075:             .FontSize  = 8
1076:             .BackStyle = 0
1077:             .ForeColor = RGB(0, 0, 0)
1078:         ENDWITH
1079: 
1080:         loc_oPgDados.AddObject("txt_4c_CSGru", "TextBox")
1081:         WITH loc_oPgDados.txt_4c_CSGru
1082:             .Top      = 285
1083:             .Left     = 113
1084:             .Width    = 52
1085:             .Height   = 23
1086:             .FontName = "Tahoma"
1087:             .FontSize = 8
1088:             .Value    = ""
1089:         ENDWITH
1090:         BINDEVENT(loc_oPgDados.txt_4c_CSGru, "KeyPress", THIS, "KeyPressCSGru")
1091: 
1092:         loc_oPgDados.AddObject("txt_4c_DsGru", "TextBox")
1093:         WITH loc_oPgDados.txt_4c_DsGru
1094:             .Top       = 285
1095:             .Left      = 166
1096:             .Width     = 150
1097:             .Height    = 23
1098:             .FontName  = "Tahoma"
1099:             .FontSize  = 8
1100:             .ReadOnly  = .T.
1101:             .BackColor = RGB(240, 240, 240)
1102:             .Value     = ""
1103:         ENDWITH
1104: 
1105:         loc_oPgDados.AddObject("lbl_4c_LblConj", "Label")
1106:         WITH loc_oPgDados.lbl_4c_LblConj
1107:             .Caption   = "Conjunto :"
1108:             .Top       = 289
1109:             .Left      = 408
1110:             .Width     = 53
1111:             .Height    = 15
1112:             .FontName  = "Tahoma"
1113:             .FontSize  = 8
1114:             .BackStyle = 0
1115:             .ForeColor = RGB(0, 0, 0)
1116:         ENDWITH
1117: 
1118:         loc_oPgDados.AddObject("txt_4c_Conjunto", "TextBox")
1119:         WITH loc_oPgDados.txt_4c_Conjunto
1120:             .Top      = 285
1121:             .Left     = 460
1122:             .Width    = 52
1123:             .Height   = 23
1124:             .FontName = "Tahoma"
1125:             .FontSize = 8
1126:             .Value    = ""
1127:         ENDWITH
1128:         BINDEVENT(loc_oPgDados.txt_4c_Conjunto, "KeyPress", THIS, "KeyPressConjunto")
1129: 
1130:         loc_oPgDados.AddObject("lbl_4c_LblVariacao", "Label")
1131:         WITH loc_oPgDados.lbl_4c_LblVariacao
1132:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o :"
1133:             .Top       = 290
1134:             .Left      = 827
1135:             .Width     = 50
1136:             .Height    = 15
1137:             .FontName  = "Tahoma"
1138:             .FontSize  = 8
1139:             .BackStyle = 0
1140:             .ForeColor = RGB(0, 0, 0)
1141:         ENDWITH
1142: 
1143:         loc_oPgDados.AddObject("opt_4c_Variacao", "OptionGroup")
1144:         WITH loc_oPgDados.opt_4c_Variacao
1145:             .Top         = 286
1146:             .Left        = 874
1147:             .Width       = 107
1148:             .Height      = 22
1149:             .ButtonCount = 2
1150:             .Value       = 1
1151:             .Themes      = .F.
1152:             .Buttons(1).Caption   = "Normal"
1153:             .Buttons(1).Left      = 0
1154:             .Buttons(1).Top       = 0
1155:             .Buttons(1).Width     = 53
1156:             .Buttons(1).Height    = 22
1157:             .Buttons(1).AutoSize  = .F.
1158:             .Buttons(1).ForeColor = RGB(0, 0, 0)
1159:             .Buttons(1).Themes    = .F.
1160:             .Buttons(2).Caption   = "Varia" + CHR(231) + CHR(227) + "o"
1161:             .Buttons(2).Left      = 54
1162:             .Buttons(2).Top       = 0
1163:             .Buttons(2).Width     = 53
1164:             .Buttons(2).Height    = 22
1165:             .Buttons(2).AutoSize  = .F.
1166:             .Buttons(2).ForeColor = RGB(0, 0, 0)
1167:             .Buttons(2).Themes    = .F.
1168:         ENDWITH
1169:         BINDEVENT(loc_oPgDados.opt_4c_Variacao, "InteractiveChange", THIS, "OptVariacaoChange")
1170: 
1171:         *-- === Qtde Pedido / Linha / Garantia (form-abs 221-230 -> 304-313) ===
1172:         loc_oPgDados.AddObject("lbl_4c_LblQtPed", "Label")
1173:         WITH loc_oPgDados.lbl_4c_LblQtPed
1174:             .Caption   = "Qtde. Pedido :"
1175:             .Top       = 308
1176:             .Left      = 553
1177:             .Width     = 72
1178:             .Height    = 15
1179:             .FontName  = "Tahoma"
1180:             .FontSize  = 8
1181:             .BackStyle = 0
1182:             .ForeColor = RGB(0, 0, 0)
1183:         ENDWITH
1184: 
1185:         loc_oPgDados.AddObject("txt_4c_QtPed", "TextBox")
1186:         WITH loc_oPgDados.txt_4c_QtPed
1187:             .Top      = 304
1188:             .Left     = 626
1189:             .Width    = 80
1190:             .Height   = 21
1191:             .FontName = "Tahoma"
1192:             .FontSize = 8
1193:             .Value    = 0
1194:         ENDWITH
1195: 
1196:         loc_oPgDados.AddObject("lbl_4c_LblGarantia", "Label")
1197:         WITH loc_oPgDados.lbl_4c_LblGarantia
1198:             .Caption   = "Garantia :"
1199:             .Top       = 311
1200:             .Left      = 827
1201:             .Width     = 50
1202:             .Height    = 15
1203:             .FontName  = "Tahoma"
1204:             .FontSize  = 8
1205:             .BackStyle = 0
1206:             .ForeColor = RGB(0, 0, 0)
1207:         ENDWITH
1208: 
1209:         loc_oPgDados.AddObject("txt_4c_DiasGar", "TextBox")
1210:         WITH loc_oPgDados.txt_4c_DiasGar
1211:             .Top      = 307
1212:             .Left     = 880
1213:             .Width    = 34
1214:             .Height   = 21
1215:             .FontName = "Tahoma"
1216:             .FontSize = 8
1217:             .Value    = 0
1218:         ENDWITH
1219: 
1220:         loc_oPgDados.AddObject("lbl_4c_LblDias", "Label")
1221:         WITH loc_oPgDados.lbl_4c_LblDias
1222:             .Caption   = "Dias"
1223:             .Top       = 311
1224:             .Left      = 918
1225:             .Width     = 22
1226:             .Height    = 15
1227:             .FontName  = "Tahoma"
1228:             .FontSize  = 8
1229:             .BackStyle = 0
1230:             .ForeColor = RGB(0, 0, 0)
1231:         ENDWITH
1232: 
1233:         loc_oPgDados.AddObject("chk_4c_ChkGarVit", "CheckBox")
1234:         WITH loc_oPgDados.chk_4c_ChkGarVit
1235:             .Caption   = "Vital" + CHR(237) + "cia"
1236:             .Top       = 228
1237:             .Left      = 943
1238:             .Width     = 55
1239:             .Height    = 15
1240:             .FontName  = "Tahoma"
1241:             .FontSize  = 8
1242:             .Value     = 0
1243:             .BackStyle = 0
1244:             .ForeColor = RGB(0, 0, 0)
1245:             .Themes    = .F.
1246:         ENDWITH
1247: 
1248:         loc_oPgDados.AddObject("lbl_4c_LblLinha", "Label")
1249:         WITH loc_oPgDados.lbl_4c_LblLinha
1250:             .Caption   = "Linha :"
1251:             .Top       = 313
1252:             .Left      = 77
1253:             .Width     = 34
1254:             .Height    = 15
1255:             .FontName  = "Tahoma"
1256:             .FontSize  = 8
1257:             .BackStyle = 0
1258:             .ForeColor = RGB(0, 0, 0)
1259:         ENDWITH
1260: 
1261:         loc_oPgDados.AddObject("txt_4c_Lin", "TextBox")
1262:         WITH loc_oPgDados.txt_4c_Lin
1263:             .Top      = 309
1264:             .Left     = 113
1265:             .Width    = 80
1266:             .Height   = 23
1267:             .FontName = "Tahoma"
1268:             .FontSize = 8
1269:             .Value    = ""
1270:         ENDWITH
1271:         BINDEVENT(loc_oPgDados.txt_4c_Lin, "KeyPress", THIS, "KeyPressLin")
1272: 
1273:         loc_oPgDados.AddObject("txt_4c_DLin", "TextBox")
1274:         WITH loc_oPgDados.txt_4c_DLin
1275:             .Top       = 309
1276:             .Left      = 194
1277:             .Width     = 318
1278:             .Height    = 23
1279:             .FontName  = "Tahoma"
1280:             .FontSize  = 8
1281:             .ReadOnly  = .T.
1282:             .BackColor = RGB(240, 240, 240)
1283:             .Value     = ""
1284:         ENDWITH
1285: 
1286:         *-- === Obs.Comp / Altura / Col.Venda (form-abs 243-253 -> 326-336) ===
1287:         loc_oPgDados.AddObject("lbl_4c_LblObsComp", "Label")
1288:         WITH loc_oPgDados.lbl_4c_LblObsComp
1289:             .Caption   = "Obs. Comp. :"
1290:             .Top       = 330
1291:             .Left      = 529
1292:             .Width     = 72
1293:             .Height    = 15
1294:             .FontName  = "Tahoma"
1295:             .FontSize  = 8
1296:             .BackStyle = 0
1297:             .ForeColor = RGB(0, 0, 0)
1298:         ENDWITH
1299: 
1300:         loc_oPgDados.AddObject("txt_4c_Obs3", "TextBox")
1301:         WITH loc_oPgDados.txt_4c_Obs3
1302:             .Top      = 326
1303:             .Left     = 626
1304:             .Width    = 80
1305:             .Height   = 21
1306:             .FontName = "Tahoma"
1307:             .FontSize = 8
1308:             .Value    = ""
1309:         ENDWITH
1310: 
1311:         loc_oPgDados.AddObject("lbl_4c_LblAltMM", "Label")
1312:         WITH loc_oPgDados.lbl_4c_LblAltMM
1313:             .Caption   = "Altura :"
1314:             .Top       = 334
1315:             .Left      = 881
1316:             .Width     = 38
1317:             .Height    = 15
1318:             .FontName  = "Tahoma"
1319:             .FontSize  = 8
1320:             .BackStyle = 0
1321:             .ForeColor = RGB(0, 0, 0)
1322:         ENDWITH
1323: 
1324:         loc_oPgDados.AddObject("txt_4c_Altura", "TextBox")
1325:         WITH loc_oPgDados.txt_4c_Altura
1326:             .Top      = 330
1327:             .Left     = 923
1328:             .Width    = 48
1329:             .Height   = 21
1330:             .FontName = "Tahoma"
1331:             .FontSize = 8
1332:             .Value    = 0
1333:         ENDWITH
1334: 
1335:         loc_oPgDados.AddObject("lbl_4c_LblMM1", "Label")
1336:         WITH loc_oPgDados.lbl_4c_LblMM1
1337:             .Caption   = "MM"
1338:             .Top       = 334
1339:             .Left      = 976
1340:             .Width     = 18
1341:             .Height    = 15
1342:             .FontName  = "Tahoma"
1343:             .FontSize  = 8
1344:             .BackStyle = 0
1345:             .ForeColor = RGB(0, 0, 0)
1346:         ENDWITH
1347: 
1348:         loc_oPgDados.AddObject("lbl_4c_LblColVenda", "Label")
1349:         WITH loc_oPgDados.lbl_4c_LblColVenda
1350:             .Caption   = "Grupo de Venda :"
1351:             .Top       = 336
1352:             .Left      = 25
1353:             .Width     = 86
1354:             .Height    = 15
1355:             .FontName  = "Tahoma"
1356:             .FontSize  = 8
1357:             .BackStyle = 0
1358:             .ForeColor = RGB(0, 0, 0)
1359:         ENDWITH
1360: 
1361:         loc_oPgDados.AddObject("txt_4c_Col", "TextBox")
1362:         WITH loc_oPgDados.txt_4c_Col
1363:             .Top      = 333
1364:             .Left     = 113
1365:             .Width    = 80
1366:             .Height   = 23
1367:             .FontName = "Tahoma"
1368:             .FontSize = 8
1369:             .Value    = ""
1370:         ENDWITH
1371:         BINDEVENT(loc_oPgDados.txt_4c_Col, "KeyPress", THIS, "KeyPressCol")
1372: 
1373:         loc_oPgDados.AddObject("txt_4c_DCol", "TextBox")
1374:         WITH loc_oPgDados.txt_4c_DCol
1375:             .Top       = 333
1376:             .Left      = 194
1377:             .Width     = 318
1378:             .Height    = 23
1379:             .FontName  = "Tahoma"
1380:             .FontSize  = 8
1381:             .ReadOnly  = .T.
1382:             .BackColor = RGB(240, 240, 240)
1383:             .Value     = ""
1384:         ENDWITH
1385: 
1386:         *-- === Obs1 / Largura (form-abs 265-269 -> 348-352) ===
1387:         loc_oPgDados.AddObject("lbl_4c_LblObs1", "Label")
1388:         WITH loc_oPgDados.lbl_4c_LblObs1
1389:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1390:             .Top       = 352
1391:             .Left      = 558
1392:             .Width     = 67
1393:             .Height    = 15
1394:             .FontName  = "Tahoma"
1395:             .FontSize  = 8
1396:             .BackStyle = 0
1397:             .ForeColor = RGB(0, 0, 0)
1398:         ENDWITH
1399: 
1400:         loc_oPgDados.AddObject("txt_4c_Obs1", "TextBox")
1401:         WITH loc_oPgDados.txt_4c_Obs1
1402:             .Top      = 348
1403:             .Left     = 626
1404:             .Width    = 220
1405:             .Height   = 21
1406:             .FontName = "Tahoma"
1407:             .FontSize = 8
1408:             .Value    = ""
1409:         ENDWITH
1410: 
1411:         loc_oPgDados.AddObject("lbl_4c_LblLargMM", "Label")
1412:         WITH loc_oPgDados.lbl_4c_LblLargMM
1413:             .Caption   = "Largura :"
1414:             .Top       = 355
1415:             .Left      = 873
1416:             .Width     = 46
1417:             .Height    = 15
1418:             .FontName  = "Tahoma"
1419:             .FontSize  = 8
1420:             .BackStyle = 0
1421:             .ForeColor = RGB(0, 0, 0)
1422:         ENDWITH
1423: 
1424:         loc_oPgDados.AddObject("txt_4c_Largura", "TextBox")
1425:         WITH loc_oPgDados.txt_4c_Largura
1426:             .Top      = 352
1427:             .Left     = 923
1428:             .Width    = 48
1429:             .Height   = 21
1430:             .FontName = "Tahoma"
1431:             .FontSize = 8
1432:             .Value    = 0
1433:         ENDWITH
1434: 
1435:         loc_oPgDados.AddObject("lbl_4c_LblMM2", "Label")
1436:         WITH loc_oPgDados.lbl_4c_LblMM2
1437:             .Caption   = "MM"
1438:             .Top       = 355
1439:             .Left      = 976
1440:             .Width     = 18
1441:             .Height    = 15
1442:             .FontName  = "Tahoma"
1443:             .FontSize  = 8
1444:             .BackStyle = 0
1445:             .ForeColor = RGB(0, 0, 0)
1446:         ENDWITH
1447: 
1448:         *-- === Fornecedor / Obs2 / Diametro (form-abs 274-293 -> 357-376) ===
1449:         loc_oPgDados.AddObject("lbl_4c_LblForn", "Label")
1450:         WITH loc_oPgDados.lbl_4c_LblForn
1451:             .Caption   = "Fornecedor :"
1452:             .Top       = 361
1453:             .Left      = 47
1454:             .Width     = 64
1455:             .Height    = 15
1456:             .FontName  = "Tahoma"
1457:             .FontSize  = 8
1458:             .BackStyle = 0
1459:             .ForeColor = RGB(0, 0, 0)
1460:         ENDWITH
1461: 
1462:         loc_oPgDados.AddObject("txt_4c_Ifor", "TextBox")
1463:         WITH loc_oPgDados.txt_4c_Ifor
1464:             .Top      = 357
1465:             .Left     = 113
1466:             .Width    = 80
1467:             .Height   = 23
1468:             .FontName = "Tahoma"
1469:             .FontSize = 8
1470:             .Value    = 0
1471:         ENDWITH
1472:         BINDEVENT(loc_oPgDados.txt_4c_Ifor, "KeyPress", THIS, "KeyPressFornecedor")
1473: 
1474:         loc_oPgDados.AddObject("txt_4c_Dfor", "TextBox")
1475:         WITH loc_oPgDados.txt_4c_Dfor
1476:             .Top       = 357
1477:             .Left      = 194
1478:             .Width     = 318
1479:             .Height    = 23
1480:             .FontName  = "Tahoma"
1481:             .FontSize  = 8
1482:             .ReadOnly  = .T.
1483:             .BackColor = RGB(240, 240, 240)
1484:             .Value     = ""
1485:         ENDWITH
1486: 
1487:         loc_oPgDados.AddObject("cmd_4c_BotFornecedor", "CommandButton")
1488:         WITH loc_oPgDados.cmd_4c_BotFornecedor
1489:             .Caption       = "..."
1490:             .Top           = 382
1491:             .Left          = 266
1492:             .Width         = 32
1493:             .Height        = 22
1494:             .FontName      = "Tahoma"
1495:             .FontSize      = 8
1496:             .Themes        = .F.
1497:             .SpecialEffect = 0
1498:         ENDWITH
1499:         BINDEVENT(loc_oPgDados.cmd_4c_BotFornecedor, "Click", THIS, "BtnFornecedorClick")
1500: 
1501:         loc_oPgDados.AddObject("lbl_4c_LblObs2", "Label")
1502:         WITH loc_oPgDados.lbl_4c_LblObs2
1503:             .Caption   = "Complemento :"
1504:             .Top       = 373
1505:             .Left      = 551
1506:             .Width     = 74
1507:             .Height    = 15
1508:             .FontName  = "Tahoma"
1509:             .FontSize  = 8
1510:             .BackStyle = 0
1511:             .ForeColor = RGB(0, 0, 0)
1512:         ENDWITH
1513: 
1514:         loc_oPgDados.AddObject("txt_4c_Obs2", "TextBox")
1515:         WITH loc_oPgDados.txt_4c_Obs2
1516:             .Top      = 370
1517:             .Left     = 626
1518:             .Width    = 220
1519:             .Height   = 21
1520:             .FontName = "Tahoma"
1521:             .FontSize = 8
1522:             .Value    = ""
1523:         ENDWITH
1524: 
1525:         loc_oPgDados.AddObject("lbl_4c_LblDiam", "Label")
1526:         WITH loc_oPgDados.lbl_4c_LblDiam
1527:             .Caption   = "Di" + CHR(226) + "metro :"
1528:             .Top       = 376
1529:             .Left      = 867
1530:             .Width     = 52
1531:             .Height    = 15
1532:             .FontName  = "Tahoma"
1533:             .FontSize  = 8
1534:             .BackStyle = 0
1535:             .ForeColor = RGB(0, 0, 0)
1536:         ENDWITH
1537: 
1538:         loc_oPgDados.AddObject("txt_4c_Diametro", "TextBox")
1539:         WITH loc_oPgDados.txt_4c_Diametro
1540:             .Top      = 374
1541:             .Left     = 923
1542:             .Width    = 48
1543:             .Height   = 21
1544:             .FontName = "Tahoma"
1545:             .FontSize = 8
1546:             .Value    = 0
1547:         ENDWITH
1548: 
1549:         loc_oPgDados.AddObject("lbl_4c_LblMM3", "Label")
1550:         WITH loc_oPgDados.lbl_4c_LblMM3
1551:             .Caption   = "MM"
1552:             .Top       = 376
1553:             .Left      = 976
1554:             .Width     = 18
1555:             .Height    = 15
1556:             .FontName  = "Tahoma"
1557:             .FontSize  = 8
1558:             .BackStyle = 0
1559:             .ForeColor = RGB(0, 0, 0)
1560:         ENDWITH
1561: 
1562:         *-- === Ref.Forn / Cor / Tam / Ultimo-Compra (form-abs 298-316 -> 381-399) ===
1563:         loc_oPgDados.AddObject("lbl_4c_LblRefForn", "Label")
1564:         WITH loc_oPgDados.lbl_4c_LblRefForn
1565:             .Caption   = "Ref. Fornecedor :"
1566:             .Top       = 384
1567:             .Left      = 23
1568:             .Width     = 88
1569:             .Height    = 15
1570:             .FontName  = "Tahoma"
1571:             .FontSize  = 8
1572:             .BackStyle = 0
1573:             .ForeColor = RGB(0, 0, 0)
1574:         ENDWITH
1575: 
1576:         loc_oPgDados.AddObject("txt_4c_Refs", "TextBox")
1577:         WITH loc_oPgDados.txt_4c_Refs
1578:             .Top      = 381
1579:             .Left     = 113
1580:             .Width    = 152
1581:             .Height   = 23
1582:             .FontName = "Tahoma"
1583:             .FontSize = 8
1584:             .Value    = ""
1585:         ENDWITH
1586: 
1587:         loc_oPgDados.AddObject("lbl_4c_LblCor", "Label")
1588:         WITH loc_oPgDados.lbl_4c_LblCor
1589:             .Caption   = "Padr" + CHR(227) + "o > Cor :"
1590:             .Top       = 385
1591:             .Left      = 323
1592:             .Width     = 70
1593:             .Height    = 15
1594:             .FontName  = "Tahoma"
1595:             .FontSize  = 8
1596:             .BackStyle = 0
1597:             .ForeColor = RGB(0, 0, 0)
1598:         ENDWITH
1599: 
1600:         loc_oPgDados.AddObject("txt_4c_Cor", "TextBox")
1601:         WITH loc_oPgDados.txt_4c_Cor
1602:             .Top      = 381
1603:             .Left     = 401
1604:             .Width    = 38
1605:             .Height   = 23
1606:             .FontName = "Tahoma"
1607:             .FontSize = 8
1608:             .Value    = ""
1609:         ENDWITH
1610:         BINDEVENT(loc_oPgDados.txt_4c_Cor, "KeyPress", THIS, "KeyPressCor")
1611: 
1612:         loc_oPgDados.AddObject("lbl_4c_LblTam", "Label")
1613:         WITH loc_oPgDados.lbl_4c_LblTam
1614:             .Caption   = "Tam:"
1615:             .Top       = 385
1616:             .Left      = 442
1617:             .Width     = 26
1618:             .Height    = 15
1619:             .FontName  = "Tahoma"
1620:             .FontSize  = 8
1621:             .BackStyle = 0
1622:             .ForeColor = RGB(0, 0, 0)
1623:         ENDWITH
1624: 
1625:         loc_oPgDados.AddObject("txt_4c_Tam", "TextBox")
1626:         WITH loc_oPgDados.txt_4c_Tam
1627:             .Top      = 381
1628:             .Left     = 474
1629:             .Width    = 38
1630:             .Height   = 23
1631:             .FontName = "Tahoma"
1632:             .FontSize = 8
1633:             .Value    = ""
1634:         ENDWITH
1635: 
1636:         loc_oPgDados.AddObject("cmd_4c_CmdTamanho", "CommandButton")
1637:         WITH loc_oPgDados.cmd_4c_CmdTamanho
1638:             .Caption       = "..."
1639:             .Top           = 377
1640:             .Left          = 513
1641:             .Width         = 32
1642:             .Height        = 29
1643:             .FontName      = "Tahoma"
1644:             .FontSize      = 8
1645:             .Themes        = .F.
1646:             .SpecialEffect = 0
1647:         ENDWITH
1648:         BINDEVENT(loc_oPgDados.cmd_4c_CmdTamanho, "Click", THIS, "BtnTamanhoClick")
1649: 
1650:         loc_oPgDados.AddObject("lbl_4c_LblUltCmp", "Label")
1651:         WITH loc_oPgDados.lbl_4c_LblUltCmp
1652:             .Caption   = CHR(218) + "lt.Compra :"
1653:             .Top       = 396
1654:             .Left      = 562
1655:             .Width     = 63
1656:             .Height    = 15
1657:             .FontName  = "Tahoma"
1658:             .FontSize  = 8
1659:             .BackStyle = 0
1660:             .ForeColor = RGB(0, 0, 0)
1661:         ENDWITH
1662: 
1663:         loc_oPgDados.AddObject("txt_4c__Dtucp", "TextBox")
1664:         WITH loc_oPgDados.txt_4c__Dtucp
1665:             .Top       = 392
1666:             .Left      = 626
1667:             .Width     = 79
1668:             .Height    = 21
1669:             .FontName  = "Tahoma"
1670:             .FontSize  = 8
1671:             .ReadOnly  = .T.
1672:             .BackColor = RGB(240, 240, 240)
1673:             .Value     = {}
1674:         ENDWITH
1675: 
1676:         loc_oPgDados.AddObject("txt_4c_Vucp", "TextBox")
1677:         WITH loc_oPgDados.txt_4c_Vucp
1678:             .Top       = 392
1679:             .Left      = 706
1680:             .Width     = 106
1681:             .Height    = 21
1682:             .FontName  = "Tahoma"
1683:             .FontSize  = 8
1684:             .ReadOnly  = .T.
1685:             .BackColor = RGB(240, 240, 240)
1686:             .Value     = 0
1687:         ENDWITH
1688: 
1689:         loc_oPgDados.AddObject("txt_4c_Mucp", "TextBox")
1690:         WITH loc_oPgDados.txt_4c_Mucp
1691:             .Top       = 392
1692:             .Left      = 813
1693:             .Width     = 33
1694:             .Height    = 21
1695:             .FontName  = "Tahoma"
1696:             .FontSize  = 8
1697:             .ReadOnly  = .T.
1698:             .BackColor = RGB(240, 240, 240)
1699:             .Value     = ""
1700:         ENDWITH
1701: 
1702:         loc_oPgDados.AddObject("txt_4c_Espessura", "TextBox")
1703:         WITH loc_oPgDados.txt_4c_Espessura
1704:             .Top      = 396
1705:             .Left     = 923
1706:             .Width    = 48
1707:             .Height   = 21
1708:             .FontName = "Tahoma"
1709:             .FontSize = 8
1710:             .Value    = 0
1711:         ENDWITH
1712: 
1713:         loc_oPgDados.AddObject("lbl_4c_LblEspesMM", "Label")
1714:         WITH loc_oPgDados.lbl_4c_LblEspesMM
1715:             .Caption   = "Espessura :"
1716:             .Top       = 399
1717:             .Left      = 861
1718:             .Width     = 58
1719:             .Height    = 15
1720:             .FontName  = "Tahoma"
1721:             .FontSize  = 8
1722:             .BackStyle = 0
1723:             .ForeColor = RGB(0, 0, 0)
1724:         ENDWITH
1725: 
1726:         loc_oPgDados.AddObject("lbl_4c_LblMM4", "Label")
1727:         WITH loc_oPgDados.lbl_4c_LblMM4
1728:             .Caption   = "MM"
1729:             .Top       = 399
1730:             .Left      = 976
1731:             .Width     = 18
1732:             .Height    = 15
1733:             .FontName  = "Tahoma"
1734:             .FontSize  = 8
1735:             .BackStyle = 0
1736:             .ForeColor = RGB(0, 0, 0)
1737:         ENDWITH
1738: 
1739:         *-- === Modelo / Peso Bruto / Qtde Ult.Compra (form-abs 322-331 -> 405-414) ===
1740:         loc_oPgDados.AddObject("lbl_4c_LblModelo", "Label")
1741:         WITH loc_oPgDados.lbl_4c_LblModelo
1742:             .Caption   = "Modelo :"
1743:             .Top       = 326
1744:             .Left      = 7
1745:             .Width     = 104
1746:             .Height    = 15
1747:             .FontName  = "Tahoma"
1748:             .FontSize  = 8
1749:             .BackStyle = 0
1750:             .ForeColor = RGB(0, 0, 0)
1751:         ENDWITH
1752: 
1753:         loc_oPgDados.AddObject("txt_4c_CodFinP", "TextBox")
1754:         WITH loc_oPgDados.txt_4c_CodFinP
1755:             .Top      = 405
1756:             .Left     = 113
1757:             .Width    = 31
1758:             .Height   = 23
1759:             .FontName = "Tahoma"
1760:             .FontSize = 8
1761:             .Value    = ""
1762:         ENDWITH
1763:         BINDEVENT(loc_oPgDados.txt_4c_CodFinP, "KeyPress", THIS, "KeyPressModelo")
1764: 
1765:         loc_oPgDados.AddObject("txt_4c_DesFinP", "TextBox")
1766:         WITH loc_oPgDados.txt_4c_DesFinP
1767:             .Top       = 405
1768:             .Left      = 145
1769:             .Width     = 150
1770:             .Height    = 23
1771:             .FontName  = "Tahoma"
1772:             .FontSize  = 8
1773:             .ReadOnly  = .T.
1774:             .BackColor = RGB(240, 240, 240)
1775:             .Value     = ""
1776:         ENDWITH
1777: 
1778:         loc_oPgDados.AddObject("lbl_4c_LblPesoBruto", "Label")
1779:         WITH loc_oPgDados.lbl_4c_LblPesoBruto
1780:             .Caption   = "Peso Bruto :"
1781:             .Top       = 409
1782:             .Left      = 336
1783:             .Width     = 61
1784:             .Height    = 15
1785:             .FontName  = "Tahoma"
1786:             .FontSize  = 8
1787:             .BackStyle = 0
1788:             .ForeColor = RGB(0, 0, 0)
1789:         ENDWITH
1790: 
1791:         loc_oPgDados.AddObject("txt_4c_Peso", "TextBox")
1792:         WITH loc_oPgDados.txt_4c_Peso
1793:             .Top      = 405
1794:             .Left     = 401
1795:             .Width    = 111
1796:             .Height   = 23
1797:             .FontName = "Tahoma"
1798:             .FontSize = 8
1799:             .Value    = 0
1800:         ENDWITH
1801: 
1802:         loc_oPgDados.AddObject("lbl_4c_LblQtdUltCmp", "Label")
1803:         WITH loc_oPgDados.lbl_4c_LblQtdUltCmp
1804:             .Caption   = "Qtde " + CHR(218) + "lt.Compra :"
1805:             .Top       = 414
1806:             .Left      = 535
1807:             .Width     = 90
1808:             .Height    = 15
1809:             .FontName  = "Tahoma"
1810:             .FontSize  = 8
1811:             .BackStyle = 0
1812:             .ForeColor = RGB(0, 0, 0)
1813:         ENDWITH
1814: 
1815:         loc_oPgDados.AddObject("txt_4c_Qtdultcomp", "TextBox")
1816:         WITH loc_oPgDados.txt_4c_Qtdultcomp
1817:             .Top       = 414
1818:             .Left      = 626
1819:             .Width     = 79
1820:             .Height    = 21
1821:             .FontName  = "Tahoma"
1822:             .FontSize  = 8
1823:             .ReadOnly  = .T.

*-- Linhas 1830 a 2778:
1830:         *-- === Comprimento (form-abs Top=335-340 -> 418-423) ===
1831:         loc_oPgDados.AddObject("txt_4c_Compriment", "TextBox")
1832:         WITH loc_oPgDados.txt_4c_Compriment
1833:             .Top      = 418
1834:             .Left     = 923
1835:             .Width    = 48
1836:             .Height   = 21
1837:             .FontName = "Tahoma"
1838:             .FontSize = 8
1839:             .Value    = 0
1840:         ENDWITH
1841: 
1842:         loc_oPgDados.AddObject("lbl_4c_Label51", "Label")
1843:         WITH loc_oPgDados.lbl_4c_Label51
1844:             .Caption   = "Comprimento :"
1845:             .Top       = 422
1846:             .Left      = 847
1847:             .Width     = 72
1848:             .Height    = 15
1849:             .FontName  = "Tahoma"
1850:             .FontSize  = 8
1851:             .BackStyle = 0
1852:             .ForeColor = RGB(0, 0, 0)
1853:         ENDWITH
1854: 
1855:         loc_oPgDados.AddObject("lbl_4c_Label56", "Label")
1856:         WITH loc_oPgDados.lbl_4c_Label56
1857:             .Caption   = "CM"
1858:             .Top       = 423
1859:             .Left      = 976
1860:             .Width     = 17
1861:             .Height    = 15
1862:             .FontName  = "Tahoma"
1863:             .FontSize  = 8
1864:             .BackStyle = 0
1865:             .ForeColor = RGB(0, 0, 0)
1866:         ENDWITH
1867: 
1868:         *-- === Acabamento / Peso Liquido / Estoque (form-abs Top=346-357 -> 429-440) ===
1869:         loc_oPgDados.AddObject("lbl_4c_LblAcabamento", "Label")
1870:         WITH loc_oPgDados.lbl_4c_LblAcabamento
1871:             .Caption   = "Acabamento :"
1872:             .Top       = 350
1873:             .Left      = 7
1874:             .Width     = 104
1875:             .Height    = 15
1876:             .FontName  = "Tahoma"
1877:             .FontSize  = 8
1878:             .BackStyle = 0
1879:             .ForeColor = RGB(0, 0, 0)
1880:         ENDWITH
1881: 
1882:         loc_oPgDados.AddObject("txt_4c__codacb", "TextBox")
1883:         WITH loc_oPgDados.txt_4c__codacb
1884:             .Top      = 429
1885:             .Left     = 113
1886:             .Width    = 31
1887:             .Height   = 23
1888:             .FontName = "Tahoma"
1889:             .FontSize = 8
1890:             .Value    = ""
1891:         ENDWITH
1892:         BINDEVENT(loc_oPgDados.txt_4c__codacb, "KeyPress", THIS, "KeyPressAcabamento")
1893: 
1894:         loc_oPgDados.AddObject("txt_4c__Dacb", "TextBox")
1895:         WITH loc_oPgDados.txt_4c__Dacb
1896:             .Top       = 429
1897:             .Left      = 145
1898:             .Width     = 150
1899:             .Height    = 23
1900:             .FontName  = "Tahoma"
1901:             .FontSize  = 8
1902:             .ReadOnly  = .T.
1903:             .BackColor = RGB(240, 240, 240)
1904:             .Value     = ""
1905:         ENDWITH
1906: 
1907:         loc_oPgDados.AddObject("lbl_4c_Label34", "Label")
1908:         WITH loc_oPgDados.lbl_4c_Label34
1909:             .Caption   = "Peso L" + CHR(237) + "quido :"
1910:             .Top       = 433
1911:             .Left      = 329
1912:             .Width     = 68
1913:             .Height    = 15
1914:             .FontName  = "Tahoma"
1915:             .FontSize  = 8
1916:             .BackStyle = 0
1917:             .ForeColor = RGB(0, 0, 0)
1918:         ENDWITH
1919: 
1920:         loc_oPgDados.AddObject("txt_4c_Pmedio", "TextBox")
1921:         WITH loc_oPgDados.txt_4c_Pmedio
1922:             .Top      = 429
1923:             .Left     = 401
1924:             .Width    = 111
1925:             .Height   = 23
1926:             .FontName = "Tahoma"
1927:             .FontSize = 8
1928:             .Value    = 0
1929:         ENDWITH
1930: 
1931:         loc_oPgDados.AddObject("lbl_4c_Label28", "Label")
1932:         WITH loc_oPgDados.lbl_4c_Label28
1933:             .Caption   = "Estoque :"
1934:             .Top       = 440
1935:             .Left      = 577
1936:             .Width     = 48
1937:             .Height    = 15
1938:             .FontName  = "Tahoma"
1939:             .FontSize  = 8
1940:             .BackStyle = 0
1941:             .ForeColor = RGB(0, 0, 0)
1942:         ENDWITH
1943: 
1944:         loc_oPgDados.AddObject("txt_4c_Estoques", "TextBox")
1945:         WITH loc_oPgDados.txt_4c_Estoques
1946:             .Top       = 436
1947:             .Left      = 626
1948:             .Width     = 79
1949:             .Height    = 21
1950:             .FontName  = "Tahoma"
1951:             .FontSize  = 8
1952:             .ReadOnly  = .T.
1953:             .BackColor = RGB(240, 240, 240)
1954:             .Value     = 0
1955:         ENDWITH
1956: 
1957:         loc_oPgDados.AddObject("txt_4c_QtdEsts", "TextBox")
1958:         WITH loc_oPgDados.txt_4c_QtdEsts
1959:             .Top       = 436
1960:             .Left      = 706
1961:             .Width     = 79
1962:             .Height    = 21
1963:             .FontName  = "Tahoma"
1964:             .FontSize  = 8
1965:             .ReadOnly  = .T.
1966:             .BackColor = RGB(240, 240, 240)
1967:             .Value     = 0
1968:         ENDWITH
1969: 
1970:         loc_oPgDados.AddObject("cmd_4c_CmdEstoque", "CommandButton")
1971:         WITH loc_oPgDados.cmd_4c_CmdEstoque
1972:             .Caption       = "Est."
1973:             .Top           = 436
1974:             .Left          = 788
1975:             .Width         = 42
1976:             .Height        = 42
1977:             .FontName      = "Tahoma"
1978:             .FontSize      = 8
1979:             .Themes        = .F.
1980:             .SpecialEffect = 0
1981:         ENDWITH
1982: 
1983:         *-- === Data/Usuario header (form-abs Top=365 -> 448) ===
1984:         loc_oPgDados.AddObject("lbl_4c_Label20", "Label")
1985:         WITH loc_oPgDados.lbl_4c_Label20
1986:             .Caption   = "Data / Usu" + CHR(225) + "rio"
1987:             .Top       = 448
1988:             .Left      = 833
1989:             .Width     = 84
1990:             .Height    = 15
1991:             .FontName  = "Tahoma"
1992:             .FontSize  = 8
1993:             .BackStyle = 0
1994:             .ForeColor = RGB(0, 0, 0)
1995:         ENDWITH
1996: 
1997:         *-- === Classificacao / Local / Custo (form-abs Top=370-384 -> 453-467) ===
1998:         loc_oPgDados.AddObject("lbl_4c_LblClassificacao", "Label")
1999:         WITH loc_oPgDados.lbl_4c_LblClassificacao
2000:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
2001:             .Top       = 374
2002:             .Left      = 7
2003:             .Width     = 104
2004:             .Height    = 15
2005:             .FontName  = "Tahoma"
2006:             .FontSize  = 8
2007:             .BackStyle = 0
2008:             .ForeColor = RGB(0, 0, 0)
2009:         ENDWITH
2010: 
2011:         loc_oPgDados.AddObject("txt_4c_Class", "TextBox")
2012:         WITH loc_oPgDados.txt_4c_Class
2013:             .Top      = 453
2014:             .Left     = 113
2015:             .Width    = 31
2016:             .Height   = 23
2017:             .FontName = "Tahoma"
2018:             .FontSize = 8
2019:             .Value    = ""
2020:         ENDWITH
2021:         BINDEVENT(loc_oPgDados.txt_4c_Class, "KeyPress", THIS, "KeyPressClassificacao")
2022: 
2023:         loc_oPgDados.AddObject("txt_4c_DClass", "TextBox")
2024:         WITH loc_oPgDados.txt_4c_DClass
2025:             .Top       = 453
2026:             .Left      = 145
2027:             .Width     = 150
2028:             .Height    = 23
2029:             .FontName  = "Tahoma"
2030:             .FontSize  = 8
2031:             .ReadOnly  = .T.
2032:             .BackColor = RGB(240, 240, 240)
2033:             .Value     = ""
2034:         ENDWITH
2035: 
2036:         loc_oPgDados.AddObject("lbl_4c_Label5", "Label")
2037:         WITH loc_oPgDados.lbl_4c_Label5
2038:             .Caption   = "Local :"
2039:             .Top       = 457
2040:             .Left      = 364
2041:             .Width     = 33
2042:             .Height    = 15
2043:             .FontName  = "Tahoma"
2044:             .FontSize  = 8
2045:             .BackStyle = 0
2046:             .ForeColor = RGB(0, 0, 0)
2047:         ENDWITH
2048: 
2049:         loc_oPgDados.AddObject("txt_4c_Local", "TextBox")
2050:         WITH loc_oPgDados.txt_4c_Local
2051:             .Top      = 453
2052:             .Left     = 401
2053:             .Width    = 111
2054:             .Height   = 23
2055:             .FontName = "Tahoma"
2056:             .FontSize = 8
2057:             .Value    = ""
2058:         ENDWITH
2059:         BINDEVENT(loc_oPgDados.txt_4c_Local, "KeyPress", THIS, "KeyPressLocal")
2060: 
2061:         loc_oPgDados.AddObject("lbl_4c_Label3", "Label")
2062:         WITH loc_oPgDados.lbl_4c_Label3
2063:             .Caption   = "Valor de Custo :"
2064:             .Top       = 462
2065:             .Left      = 546
2066:             .Width     = 79
2067:             .Height    = 15
2068:             .FontName  = "Tahoma"
2069:             .FontSize  = 8
2070:             .BackStyle = 0
2071:             .ForeColor = RGB(0, 0, 0)
2072:         ENDWITH
2073: 
2074:         loc_oPgDados.AddObject("txt_4c_Ctotal", "TextBox")
2075:         WITH loc_oPgDados.txt_4c_Ctotal
2076:             .Top       = 458
2077:             .Left      = 626
2078:             .Width     = 127
2079:             .Height    = 21
2080:             .FontName  = "Tahoma"
2081:             .FontSize  = 8
2082:             .ReadOnly  = .T.
2083:             .BackColor = RGB(240, 240, 240)
2084:             .Value     = 0
2085:         ENDWITH
2086: 
2087:         loc_oPgDados.AddObject("txt_4c_Mctotal", "TextBox")
2088:         WITH loc_oPgDados.txt_4c_Mctotal
2089:             .Top       = 458
2090:             .Left      = 754
2091:             .Width     = 31
2092:             .Height    = 21
2093:             .FontName  = "Tahoma"
2094:             .FontSize  = 8
2095:             .ReadOnly  = .T.
2096:             .BackColor = RGB(240, 240, 240)
2097:             .Value     = ""
2098:         ENDWITH
2099: 
2100:         *-- Inclusao/Alteracao header (form-abs 380-384 -> 463-467)
2101:         loc_oPgDados.AddObject("shp_4c_Shape3", "Shape")
2102:         WITH loc_oPgDados.shp_4c_Shape3
2103:             .Top    = 463
2104:             .Left   = 833
2105:             .Width  = 161
2106:             .Height = 2
2107:         ENDWITH
2108: 
2109:         loc_oPgDados.AddObject("lbl_4c_Label24", "Label")
2110:         WITH loc_oPgDados.lbl_4c_Label24
2111:             .Caption   = "Inclus" + CHR(227) + "o"
2112:             .Top       = 467
2113:             .Left      = 833
2114:             .Width     = 42
2115:             .Height    = 15
2116:             .FontName  = "Tahoma"
2117:             .FontSize  = 8
2118:             .BackStyle = 0
2119:             .ForeColor = RGB(0, 0, 0)
2120:         ENDWITH
2121: 
2122:         loc_oPgDados.AddObject("lbl_4c_Label25", "Label")
2123:         WITH loc_oPgDados.lbl_4c_Label25
2124:             .Caption   = "Altera" + CHR(231) + CHR(227) + "o"
2125:             .Top       = 467
2126:             .Left      = 914
2127:             .Width     = 48
2128:             .Height    = 15
2129:             .FontName  = "Tahoma"
2130:             .FontSize  = 8
2131:             .BackStyle = 0
2132:             .ForeColor = RGB(0, 0, 0)
2133:         ENDWITH
2134: 
2135:         *-- === Unidades / Datas / Valor Venda (form-abs Top=394-400 -> 477-483) ===
2136:         loc_oPgDados.AddObject("lbl_4c_Label14", "Label")
2137:         WITH loc_oPgDados.lbl_4c_Label14
2138:             .Caption   = "Unidades (1) :"
2139:             .Top       = 481
2140:             .Left      = 41
2141:             .Width     = 70
2142:             .Height    = 15
2143:             .FontName  = "Tahoma"
2144:             .FontSize  = 8
2145:             .BackStyle = 0
2146:             .ForeColor = RGB(0, 0, 0)
2147:         ENDWITH
2148: 
2149:         loc_oPgDados.AddObject("txt_4c_Cuni", "TextBox")
2150:         WITH loc_oPgDados.txt_4c_Cuni
2151:             .Top      = 477
2152:             .Left     = 113
2153:             .Width    = 31
2154:             .Height   = 23
2155:             .FontName = "Tahoma"
2156:             .FontSize = 8
2157:             .Value    = ""
2158:         ENDWITH
2159:         BINDEVENT(loc_oPgDados.txt_4c_Cuni, "KeyPress", THIS, "KeyPressUnidade")
2160: 
2161:         loc_oPgDados.AddObject("txt_4c_Duni", "TextBox")
2162:         WITH loc_oPgDados.txt_4c_Duni
2163:             .Top       = 477
2164:             .Left      = 145
2165:             .Width     = 150
2166:             .Height    = 23
2167:             .FontName  = "Tahoma"
2168:             .FontSize  = 8
2169:             .ReadOnly  = .T.
2170:             .BackColor = RGB(240, 240, 240)
2171:             .Value     = ""
2172:         ENDWITH
2173: 
2174:         loc_oPgDados.AddObject("lbl_4c_Label18", "Label")
2175:         WITH loc_oPgDados.lbl_4c_Label18
2176:             .Caption   = "(2) :"
2177:             .Top       = 481
2178:             .Left      = 301
2179:             .Width     = 23
2180:             .Height    = 15
2181:             .FontName  = "Tahoma"
2182:             .FontSize  = 8
2183:             .BackStyle = 0
2184:             .ForeColor = RGB(0, 0, 0)
2185:         ENDWITH
2186: 
2187:         loc_oPgDados.AddObject("txt_4c_Cunip", "TextBox")
2188:         WITH loc_oPgDados.txt_4c_Cunip
2189:             .Top      = 477
2190:             .Left     = 330
2191:             .Width    = 31
2192:             .Height   = 23
2193:             .FontName = "Tahoma"
2194:             .FontSize = 8
2195:             .Value    = ""
2196:         ENDWITH
2197:         BINDEVENT(loc_oPgDados.txt_4c_Cunip, "KeyPress", THIS, "KeyPressUnidade2")
2198: 
2199:         loc_oPgDados.AddObject("txt_4c__dunip", "TextBox")
2200:         WITH loc_oPgDados.txt_4c__dunip
2201:             .Top       = 477
2202:             .Left      = 362
2203:             .Width     = 150
2204:             .Height    = 23
2205:             .FontName  = "Tahoma"
2206:             .FontSize  = 8
2207:             .ReadOnly  = .T.
2208:             .BackColor = RGB(240, 240, 240)
2209:             .Value     = ""
2210:         ENDWITH
2211: 
2212:         loc_oPgDados.AddObject("txt_4c_DtIncs", "TextBox")
2213:         WITH loc_oPgDados.txt_4c_DtIncs
2214:             .Top       = 480
2215:             .Left      = 833
2216:             .Width     = 79
2217:             .Height    = 21
2218:             .FontName  = "Tahoma"
2219:             .FontSize  = 8
2220:             .ReadOnly  = .T.
2221:             .BackColor = RGB(240, 240, 240)
2222:             .Value     = {}
2223:         ENDWITH
2224: 
2225:         loc_oPgDados.AddObject("txt_4c_DataAlts", "TextBox")
2226:         WITH loc_oPgDados.txt_4c_DataAlts
2227:             .Top       = 480
2228:             .Left      = 914
2229:             .Width     = 79
2230:             .Height    = 21
2231:             .FontName  = "Tahoma"
2232:             .FontSize  = 8
2233:             .ReadOnly  = .T.
2234:             .BackColor = RGB(240, 240, 240)
2235:             .Value     = {}
2236:         ENDWITH
2237: 
2238:         loc_oPgDados.AddObject("txt_4c_Pvenda", "TextBox")
2239:         WITH loc_oPgDados.txt_4c_Pvenda
2240:             .Top       = 480
2241:             .Left      = 626
2242:             .Width     = 127
2243:             .Height    = 21
2244:             .FontName  = "Tahoma"
2245:             .FontSize  = 8
2246:             .ReadOnly  = .T.
2247:             .BackColor = RGB(240, 240, 240)
2248:             .Value     = 0
2249:         ENDWITH
2250: 
2251:         loc_oPgDados.AddObject("txt_4c_Mpvenda", "TextBox")
2252:         WITH loc_oPgDados.txt_4c_Mpvenda
2253:             .Top       = 480
2254:             .Left      = 754
2255:             .Width     = 31
2256:             .Height    = 21
2257:             .FontName  = "Tahoma"
2258:             .FontSize  = 8
2259:             .ReadOnly  = .T.
2260:             .BackColor = RGB(240, 240, 240)
2261:             .Value     = ""
2262:         ENDWITH
2263: 
2264:         loc_oPgDados.AddObject("lbl_4c_Label4", "Label")
2265:         WITH loc_oPgDados.lbl_4c_Label4
2266:             .Caption   = "Valor de Venda :"
2267:             .Top       = 483
2268:             .Left      = 505
2269:             .Width     = 120
2270:             .Height    = 15
2271:             .FontName  = "Tahoma"
2272:             .FontSize  = 8
2273:             .BackStyle = 0
2274:             .ForeColor = RGB(0, 0, 0)
2275:         ENDWITH
2276: 
2277:         *-- === Cod.Identidade / Fator Venda / Usuarios (form-abs 418-422 -> 501-505) ===
2278:         loc_oPgDados.AddObject("txt_4c_CodIdent", "TextBox")
2279:         WITH loc_oPgDados.txt_4c_CodIdent
2280:             .Top      = 501
2281:             .Left     = 113
2282:             .Width    = 182
2283:             .Height   = 23
2284:             .FontName = "Tahoma"
2285:             .FontSize = 8
2286:             .Value    = ""
2287:         ENDWITH
2288: 
2289:         loc_oPgDados.AddObject("txt_4c_Fvenda", "TextBox")
2290:         WITH loc_oPgDados.txt_4c_Fvenda
2291:             .Top       = 502
2292:             .Left      = 626
2293:             .Width     = 127
2294:             .Height    = 21
2295:             .FontName  = "Tahoma"
2296:             .FontSize  = 8
2297:             .ReadOnly  = .T.
2298:             .BackColor = RGB(240, 240, 240)
2299:             .Value     = 0
2300:         ENDWITH
2301: 
2302:         loc_oPgDados.AddObject("txt_4c_Mfvenda", "TextBox")
2303:         WITH loc_oPgDados.txt_4c_Mfvenda
2304:             .Top       = 502
2305:             .Left      = 754
2306:             .Width     = 31
2307:             .Height    = 21
2308:             .FontName  = "Tahoma"
2309:             .FontSize  = 8
2310:             .ReadOnly  = .T.
2311:             .BackColor = RGB(240, 240, 240)
2312:             .Value     = ""
2313:         ENDWITH
2314: 
2315:         loc_oPgDados.AddObject("txt_4c_Usuario", "TextBox")
2316:         WITH loc_oPgDados.txt_4c_Usuario
2317:             .Top       = 502
2318:             .Left      = 833
2319:             .Width     = 79
2320:             .Height    = 21
2321:             .FontName  = "Tahoma"
2322:             .FontSize  = 8
2323:             .ReadOnly  = .T.
2324:             .BackColor = RGB(240, 240, 240)
2325:             .Value     = ""
2326:         ENDWITH
2327: 
2328:         loc_oPgDados.AddObject("txt_4c_UsuaAlts", "TextBox")
2329:         WITH loc_oPgDados.txt_4c_UsuaAlts
2330:             .Top       = 502
2331:             .Left      = 914
2332:             .Width     = 79
2333:             .Height    = 21
2334:             .FontName  = "Tahoma"
2335:             .FontSize  = 8
2336:             .ReadOnly  = .T.
2337:             .BackColor = RGB(240, 240, 240)
2338:             .Value     = ""
2339:         ENDWITH
2340: 
2341:         loc_oPgDados.AddObject("lbl_4c_Label38", "Label")
2342:         WITH loc_oPgDados.lbl_4c_Label38
2343:             .Caption   = "Cod. Identidade :"
2344:             .Top       = 505
2345:             .Left      = 24
2346:             .Width     = 87
2347:             .Height    = 15
2348:             .FontName  = "Tahoma"
2349:             .FontSize  = 8
2350:             .BackStyle = 0
2351:             .ForeColor = RGB(0, 0, 0)
2352:         ENDWITH
2353: 
2354:         loc_oPgDados.AddObject("lbl_4c_Label6", "Label")
2355:         WITH loc_oPgDados.lbl_4c_Label6
2356:             .Caption   = "Fator de Venda :"
2357:             .Top       = 505
2358:             .Left      = 539
2359:             .Width     = 86
2360:             .Height    = 15
2361:             .FontName  = "Tahoma"
2362:             .FontSize  = 8
2363:             .BackStyle = 0
2364:             .ForeColor = RGB(0, 0, 0)
2365:         ENDWITH
2366: 
2367:         *-- === Separator line (form-abs 444 -> 527) ===
2368:         loc_oPgDados.AddObject("shp_4c_Shape1", "Shape")
2369:         WITH loc_oPgDados.shp_4c_Shape1
2370:             .Top    = 527
2371:             .Left   = 4
2372:             .Width  = 991
2373:             .Height = 2
2374:         ENDWITH
2375: 
2376:         *-- === Desc.Compra / Entrega / Checkboxes (form-abs 447-470 -> 530-553) ===
2377:         loc_oPgDados.AddObject("txt_4c_TEnts", "TextBox")
2378:         WITH loc_oPgDados.txt_4c_TEnts
2379:             .Top      = 530
2380:             .Left     = 934
2381:             .Width    = 31
2382:             .Height   = 22
2383:             .FontName = "Tahoma"
2384:             .FontSize = 8
2385:             .Value    = 0
2386:         ENDWITH
2387: 
2388:         loc_oPgDados.AddObject("lbl_4c_Label31", "Label")
2389:         WITH loc_oPgDados.lbl_4c_Label31
2390:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :" + CHR(13) + "Compra ."
2391:             .Top       = 531
2392:             .Left      = 23
2393:             .Width     = 88
2394:             .Height    = 28
2395:             .FontName  = "Tahoma"
2396:             .FontSize  = 8
2397:             .BackStyle = 0
2398:             .ForeColor = RGB(0, 0, 0)
2399:             .WordWrap  = .T.
2400:         ENDWITH
2401: 
2402:         loc_oPgDados.AddObject("edt_4c_DscCompras", "EditBox")
2403:         WITH loc_oPgDados.edt_4c_DscCompras
2404:             .Top      = 531
2405:             .Left     = 113
2406:             .Width    = 400
2407:             .Height   = 58
2408:             .FontName = "Tahoma"
2409:             .FontSize = 8
2410:             .Value    = ""
2411:         ENDWITH
2412: 
2413:         loc_oPgDados.AddObject("lbl_4c_Label39", "Label")
2414:         WITH loc_oPgDados.lbl_4c_Label39
2415:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
2416:             .Top       = 534
2417:             .Left      = 548
2418:             .Width     = 50
2419:             .Height    = 15
2420:             .FontName  = "Tahoma"
2421:             .FontSize  = 8
2422:             .BackStyle = 0
2423:             .ForeColor = RGB(0, 0, 0)
2424:         ENDWITH
2425: 
2426:         loc_oPgDados.AddObject("chk_4c_Get_Consig", "CheckBox")
2427:         WITH loc_oPgDados.chk_4c_Get_Consig
2428:             .Caption   = "Consigna"
2429:             .Top       = 451
2430:             .Left      = 601
2431:             .Width     = 72
2432:             .Height    = 15
2433:             .FontName  = "Tahoma"
2434:             .FontSize  = 8
2435:             .Value     = 0
2436:             .BackStyle = 0
2437:             .ForeColor = RGB(0, 0, 0)
2438:             .Themes    = .F.
2439:         ENDWITH
2440: 
2441:         loc_oPgDados.AddObject("chk_4c_ChkFabrProprs", "CheckBox")
2442:         WITH loc_oPgDados.chk_4c_ChkFabrProprs
2443:             .Caption   = "Fabr. Pr" + CHR(243) + "pria"
2444:             .Top       = 451
2445:             .Left      = 681
2446:             .Width     = 85
2447:             .Height    = 15
2448:             .FontName  = "Tahoma"
2449:             .FontSize  = 8
2450:             .Value     = 0
2451:             .BackStyle = 0
2452:             .ForeColor = RGB(0, 0, 0)
2453:             .Themes    = .F.
2454:         ENDWITH
2455: 
2456:         loc_oPgDados.AddObject("chk_4c_ChkEncoms", "CheckBox")
2457:         WITH loc_oPgDados.chk_4c_ChkEncoms
2458:             .Caption   = "Encomenda"
2459:             .Top       = 451
2460:             .Left      = 781
2461:             .Width     = 75
2462:             .Height    = 15
2463:             .FontName  = "Tahoma"
2464:             .FontSize  = 8
2465:             .Value     = 0
2466:             .BackStyle = 0
2467:             .ForeColor = RGB(0, 0, 0)
2468:             .Themes    = .F.
2469:         ENDWITH
2470: 
2471:         loc_oPgDados.AddObject("lbl_4c_Label9", "Label")
2472:         WITH loc_oPgDados.lbl_4c_Label9
2473:             .Caption   = "Entrega :"
2474:             .Top       = 451
2475:             .Left      = 884
2476:             .Width     = 47
2477:             .Height    = 15
2478:             .FontName  = "Tahoma"
2479:             .FontSize  = 8
2480:             .BackStyle = 0
2481:             .ForeColor = RGB(0, 0, 0)
2482:         ENDWITH
2483: 
2484:         loc_oPgDados.AddObject("lbl_4c_Label10", "Label")
2485:         WITH loc_oPgDados.lbl_4c_Label10
2486:             .Caption   = "Dias"
2487:             .Top       = 451
2488:             .Left      = 967
2489:             .Width     = 22
2490:             .Height    = 15
2491:             .FontName  = "Tahoma"
2492:             .FontSize  = 8
2493:             .BackStyle = 0
2494:             .ForeColor = RGB(0, 0, 0)
2495:         ENDWITH
2496: 
2497:         *-- === Dimensoes / Volumes (form-abs 470-474 -> 553-557) ===
2498:         loc_oPgDados.AddObject("txt_4c_Fwget6", "TextBox")
2499:         WITH loc_oPgDados.txt_4c_Fwget6
2500:             .Top      = 470
2501:             .Left     = 601
2502:             .Width    = 58
2503:             .Height   = 23
2504:             .FontName = "Tahoma"
2505:             .FontSize = 8
2506:             .Value    = 0
2507:         ENDWITH
2508: 
2509:         loc_oPgDados.AddObject("txt_4c_Fwget5", "TextBox")
2510:         WITH loc_oPgDados.txt_4c_Fwget5
2511:             .Top      = 470
2512:             .Left     = 688
2513:             .Width    = 58
2514:             .Height   = 23
2515:             .FontName = "Tahoma"
2516:             .FontSize = 8
2517:             .Value    = 0
2518:         ENDWITH
2519: 
2520:         loc_oPgDados.AddObject("txt_4c_Fwget4", "TextBox")
2521:         WITH loc_oPgDados.txt_4c_Fwget4
2522:             .Top      = 470
2523:             .Left     = 776
2524:             .Width    = 58
2525:             .Height   = 23
2526:             .FontName = "Tahoma"
2527:             .FontSize = 8
2528:             .Value    = 0
2529:         ENDWITH
2530: 
2531:         loc_oPgDados.AddObject("txt_4c_Fwget3", "TextBox")
2532:         WITH loc_oPgDados.txt_4c_Fwget3
2533:             .Top      = 470
2534:             .Left     = 934
2535:             .Width    = 31
2536:             .Height   = 23
2537:             .FontName = "Tahoma"
2538:             .FontSize = 8
2539:             .Value    = 0
2540:         ENDWITH
2541: 
2542:         loc_oPgDados.AddObject("lbl_4c_Label27", "Label")
2543:         WITH loc_oPgDados.lbl_4c_Label27
2544:             .Caption   = "Dimens" + CHR(227) + "o :"
2545:             .Top       = 557
2546:             .Left      = 543
2547:             .Width     = 55
2548:             .Height    = 15
2549:             .FontName  = "Tahoma"
2550:             .FontSize  = 8
2551:             .BackStyle = 0
2552:             .ForeColor = RGB(0, 0, 0)
2553:         ENDWITH
2554: 
2555:         loc_oPgDados.AddObject("lbl_4c_LblProfundidade", "Label")
2556:         WITH loc_oPgDados.lbl_4c_LblProfundidade
2557:             .Caption   = "ppp"
2558:             .Top       = 474
2559:             .Left      = 661
2560:             .Width     = 20
2561:             .Height    = 15
2562:             .FontName  = "Tahoma"
2563:             .FontSize  = 8
2564:             .BackStyle = 0
2565:             .ForeColor = RGB(0, 0, 0)
2566:         ENDWITH
2567: 
2568:         loc_oPgDados.AddObject("lbl_4c_LblAltura", "Label")
2569:         WITH loc_oPgDados.lbl_4c_LblAltura
2570:             .Caption   = "aaa"
2571:             .Top       = 474
2572:             .Left      = 749
2573:             .Width     = 20
2574:             .Height    = 15
2575:             .FontName  = "Tahoma"
2576:             .FontSize  = 8
2577:             .BackStyle = 0
2578:             .ForeColor = RGB(0, 0, 0)
2579:         ENDWITH
2580: 
2581:         loc_oPgDados.AddObject("lbl_4c_LblComprimento", "Label")
2582:         WITH loc_oPgDados.lbl_4c_LblComprimento
2583:             .Caption   = "ccc"
2584:             .Top       = 474
2585:             .Left      = 836
2586:             .Width     = 17
2587:             .Height    = 15
2588:             .FontName  = "Tahoma"
2589:             .FontSize  = 8
2590:             .BackStyle = 0
2591:             .ForeColor = RGB(0, 0, 0)
2592:         ENDWITH
2593: 
2594:         loc_oPgDados.AddObject("lbl_4c_Label26", "Label")
2595:         WITH loc_oPgDados.lbl_4c_Label26
2596:             .Caption   = "Volumes :"
2597:             .Top       = 557
2598:             .Left      = 883
2599:             .Width     = 48
2600:             .Height    = 15
2601:             .FontName  = "Tahoma"
2602:             .FontSize  = 8
2603:             .BackStyle = 0
2604:             .ForeColor = RGB(0, 0, 0)
2605:         ENDWITH
2606: 
2607:         *-- === Imagens / Desc.Completa (form-abs 496-521 -> 579-604) ===
2608:         loc_oPgDados.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
2609:         WITH loc_oPgDados.cmd_4c_CmdgFigCam
2610:             .Caption       = "Cam"
2611:             .Top           = 579
2612:             .Left          = 717
2613:             .Width         = 50
2614:             .Height        = 50
2615:             .FontName      = "Tahoma"
2616:             .FontSize      = 8
2617:             .Themes        = .F.
2618:             .SpecialEffect = 0
2619:         ENDWITH
2620: 
2621:         loc_oPgDados.AddObject("lbl_4c_Label40", "Label")
2622:         WITH loc_oPgDados.lbl_4c_Label40
2623:             .Caption   = "Imagem Principal"
2624:             .Top       = 585
2625:             .Left      = 543
2626:             .Width     = 101
2627:             .Height    = 15
2628:             .FontName  = "Tahoma"
2629:             .FontSize  = 8
2630:             .BackStyle = 0
2631:             .ForeColor = RGB(0, 0, 0)
2632:         ENDWITH
2633: 
2634:         loc_oPgDados.AddObject("lbl_4c_Label41", "Label")
2635:         WITH loc_oPgDados.lbl_4c_Label41
2636:             .Caption   = "Imagem T" + CHR(233) + "cnica"
2637:             .Top       = 585
2638:             .Left      = 775
2639:             .Width     = 96
2640:             .Height    = 15
2641:             .FontName  = "Tahoma"
2642:             .FontSize  = 8
2643:             .BackStyle = 0
2644:             .ForeColor = RGB(0, 0, 0)
2645:         ENDWITH
2646: 
2647:         loc_oPgDados.AddObject("lbl_4c_Label33", "Label")
2648:         WITH loc_oPgDados.lbl_4c_Label33
2649:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :" + CHR(13) + "Completa ."
2650:             .Top       = 590
2651:             .Left      = 23
2652:             .Width     = 88
2653:             .Height    = 28
2654:             .FontName  = "Tahoma"
2655:             .FontSize  = 8
2656:             .BackStyle = 0
2657:             .ForeColor = RGB(0, 0, 0)
2658:             .WordWrap  = .T.
2659:         ENDWITH
2660: 
2661:         loc_oPgDados.AddObject("edt_4c_DPro3s", "EditBox")
2662:         WITH loc_oPgDados.edt_4c_DPro3s
2663:             .Top      = 590
2664:             .Left     = 113
2665:             .Width    = 400
2666:             .Height   = 58
2667:             .FontName = "Tahoma"
2668:             .FontSize = 8
2669:             .Value    = ""
2670:         ENDWITH
2671: 
2672:         loc_oPgDados.AddObject("shp_4c_ShpFig", "Shape")
2673:         WITH loc_oPgDados.shp_4c_ShpFig
2674:             .Top    = 603
2675:             .Left   = 543
2676:             .Width  = 174
2677:             .Height = 103
2678:         ENDWITH
2679: 
2680:         loc_oPgDados.AddObject("shp_4c_Shape2", "Shape")
2681:         WITH loc_oPgDados.shp_4c_Shape2
2682:             .Top    = 602
2683:             .Left   = 775
2684:             .Width  = 174
2685:             .Height = 103
2686:         ENDWITH
2687: 
2688:         loc_oPgDados.AddObject("img_4c_ImgFigJpg", "Image")
2689:         WITH loc_oPgDados.img_4c_ImgFigJpg
2690:             .Top    = 604
2691:             .Left   = 544
2692:             .Width  = 172
2693:             .Height = 101
2694:         ENDWITH
2695: 
2696:         loc_oPgDados.AddObject("img_4c_ImgFigTec", "Image")
2697:         WITH loc_oPgDados.img_4c_ImgFigTec
2698:             .Top    = 603
2699:             .Left   = 776
2700:             .Width  = 172
2701:             .Height = 101
2702:         ENDWITH
2703: 
2704:         *-- === Zoom / Obs.Compra / Comandos finais (form-abs 537-578 -> 620-661) ===
2705:         loc_oPgDados.AddObject("cmd_4c_CmdZoom", "CommandButton")
2706:         WITH loc_oPgDados.cmd_4c_CmdZoom
2707:             .Caption       = "Zoom"
2708:             .Top           = 620
2709:             .Left          = 717
2710:             .Width         = 50
2711:             .Height        = 50
2712:             .FontName      = "Tahoma"
2713:             .FontSize      = 8
2714:             .Themes        = .F.
2715:             .SpecialEffect = 0
2716:         ENDWITH
2717: 
2718:         loc_oPgDados.AddObject("cmd_4c_Commandgroup2", "CommandButton")
2719:         WITH loc_oPgDados.cmd_4c_Commandgroup2
2720:             .Caption       = "..."
2721:             .Top           = 620
2722:             .Left          = 948
2723:             .Width         = 50
2724:             .Height        = 50
2725:             .FontName      = "Tahoma"
2726:             .FontSize      = 8
2727:             .Themes        = .F.
2728:             .SpecialEffect = 0
2729:         ENDWITH
2730: 
2731:         loc_oPgDados.AddObject("lbl_4c_Label32", "Label")
2732:         WITH loc_oPgDados.lbl_4c_Label32
2733:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :" + CHR(13) + "da  Compra ."
2734:             .Top       = 649
2735:             .Left      = 23
2736:             .Width     = 88
2737:             .Height    = 28
2738:             .FontName  = "Tahoma"
2739:             .FontSize  = 8
2740:             .BackStyle = 0
2741:             .ForeColor = RGB(0, 0, 0)
2742:             .WordWrap  = .T.
2743:         ENDWITH
2744: 
2745:         loc_oPgDados.AddObject("edt_4c_ObsCompras", "EditBox")
2746:         WITH loc_oPgDados.edt_4c_ObsCompras
2747:             .Top      = 649
2748:             .Left     = 113
2749:             .Width    = 400
2750:             .Height   = 58
2751:             .FontName = "Tahoma"
2752:             .FontSize = 8
2753:             .Value    = ""
2754:         ENDWITH
2755: 
2756:         loc_oPgDados.AddObject("cmd_4c_CmdgFigura", "CommandButton")
2757:         WITH loc_oPgDados.cmd_4c_CmdgFigura
2758:             .Caption       = "Fig."
2759:             .Top           = 661
2760:             .Left          = 717
2761:             .Width         = 50
2762:             .Height        = 50
2763:             .FontName      = "Tahoma"
2764:             .FontSize      = 8
2765:             .Themes        = .F.
2766:             .SpecialEffect = 0
2767:         ENDWITH
2768: 
2769:         loc_oPgDados.AddObject("cmd_4c_Commandgroup1", "CommandButton")
2770:         WITH loc_oPgDados.cmd_4c_Commandgroup1
2771:             .Caption       = "..."
2772:             .Top           = 661
2773:             .Left          = 948
2774:             .Width         = 50
2775:             .Height        = 50
2776:             .FontName      = "Tahoma"
2777:             .FontSize      = 8
2778:             .Themes        = .F.

*-- Linhas 2847 a 2861:
2847:                 loc_oGrid.Column5.Width = 180
2848:                 loc_oGrid.Column6.Width = 100
2849:                 loc_oGrid.Column7.Width = 40
2850:                 loc_oGrid.Column1.Header1.Caption = "Produto"
2851:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2852:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
2853:                 loc_oGrid.Column4.Header1.Caption = "Subgrp."
2854:                 loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
2855:                 loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
2856:                 loc_oGrid.Column7.Header1.Caption = "I"
2857: 
2858:                 THIS.FormatarGridLista(loc_oGrid)
2859:                 loc_lSucesso = .T.
2860:             ENDIF
2861: 

*-- Linhas 3333 a 3343:
3333:             loc_oPgDados.txt_4c_Diametro.Enabled  = par_lHabilitar
3334:             loc_oPgDados.txt_4c_Espessura.Enabled = par_lHabilitar
3335:             loc_oPgDados.opt_4c_Situacao.Enabled  = par_lHabilitar
3336:             loc_oPgDados.cmd_4c_BotFornecedor.Enabled = par_lHabilitar
3337:             loc_oPgDados.cmd_4c_CmdQtMin.Enabled  = par_lHabilitar
3338:             loc_oPgDados.cmd_4c_CmdTamanho.Enabled = par_lHabilitar
3339:             *-- Fase 6
3340:             loc_oPgDados.txt_4c_Compriment.Enabled   = par_lHabilitar
3341:             loc_oPgDados.txt_4c__codacb.Enabled       = par_lHabilitar
3342:             loc_oPgDados.txt_4c_Pmedio.Enabled        = par_lHabilitar
3343:             loc_oPgDados.txt_4c_Class.Enabled         = par_lHabilitar

*-- Linhas 4058 a 4080:
4058:     * conforme modo atual (INCLUIR/ALTERAR/VISUALIZAR)
4059:     *--------------------------------------------------------------------------
4060:     PROCEDURE AjustarBotoesPorModo()
4061:         LOCAL loc_oBotoes, loc_cModo
4062:         loc_cModo   = THIS.this_cModoAtual
4063:         loc_oBotoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
4064: 
4065:         TRY
4066:             DO CASE
4067:             CASE loc_cModo = "VISUALIZAR"
4068:                 loc_oBotoes.cmd_4c_Salvar.Enabled    = .F.
4069:                 loc_oBotoes.cmd_4c_Cancelar.Enabled  = .T.
4070:                 loc_oBotoes.cmd_4c_Cancelar.Caption  = "Voltar"
4071: 
4072:             CASE loc_cModo = "INCLUIR" OR loc_cModo = "ALTERAR"
4073:                 loc_oBotoes.cmd_4c_Salvar.Enabled    = .T.
4074:                 loc_oBotoes.cmd_4c_Cancelar.Enabled  = .T.
4075:                 loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"
4076:             ENDCASE
4077:         CATCH TO loc_oErro
4078:             MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
4079:         ENDTRY
4080:     ENDPROC

