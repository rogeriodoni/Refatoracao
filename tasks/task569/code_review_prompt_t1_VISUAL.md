# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (17)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 210: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 235: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 260: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 285: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 312: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 352: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1147: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1172: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 7015: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 7038: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 7061: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 7084: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 7107: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 7130: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 7153: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 7176: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (8398 linhas total):

*-- Linhas 8 a 16:
8: *   opt_4c_Navegacao (OptionGroup de 8 botoes graficos) e quem troca de aba
9: *
10: * O legado esconde as abas do PageFrame interno empurrando-o para cima
11: * (pgframeDados.Top = -58, altura da barra de 2 linhas de abas = 58). Aqui a
12: * barra e desligada (Tabs = .F.) e o Top compensa os mesmos 58 pixels, de forma
13: * que os controles das abas usam as coordenadas do layout.json SEM deslocamento.
14: *==============================================================================
15: 
16: DEFINE CLASS FormProduto AS FormBase

*-- Linhas 92 a 120:
92: 
93:     *===========================================================================
94:     * ConfigurarPageFrame - PageFrame externo: Page1 (Lista) e Page2 (Dados)
95:     * Legado: Pagina.Top = -24 / Height = 635 / Width = 1013 (abas escondidas)
96:     * Canonico do projeto: Top = -29 e Tabs = .F.; controles das Pages compensam
97:     * +29 no Top (o resultado absoluto e identico ao do legado).
98:     *===========================================================================
99:     PROTECTED PROCEDURE ConfigurarPageFrame()
100:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
101: 
102:         WITH THIS.pgf_4c_Paginas
103:             .PageCount = 2
104:             .Top       = -29
105:             .Left      = 0
106:             .Width     = THIS.Width
107:             .Height    = THIS.Height + 29
108:             .Tabs      = .F.
109:             .Visible   = .T.
110: 
111:             .Page1.Caption   = "Lista"
112:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113:             .Page1.BackColor = RGB(255, 255, 255)
114: 
115:             .Page2.Caption   = "Dados"
116:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117:             .Page2.BackColor = RGB(255, 255, 255)
118:         ENDWITH
119: 
120:         THIS.ConfigurarPaginaLista()

*-- Linhas 139 a 176:
139:         *-- Faixa cinza do cabecalho: PRIMEIRO AddObject da pagina (CLAUDE.md #11)
140:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
141:         WITH loc_oPagina.cnt_4c_Cabecalho
142:             .Top           = 30
143:             .Left          = 0
144:             .Width         = THIS.Width
145:             .Height        = 80
146:             .BackColor     = RGB(100, 100, 100)
147:             .BorderWidth   = 0
148:             .SpecialEffect = 0
149:             .Visible       = .T.
150: 
151:             .AddObject("lbl_4c_Sombra", "Label")
152:             WITH .lbl_4c_Sombra
153:                 .Caption   = THIS.Caption
154:                 .Top       = 15
155:                 .Left      = 10
156:                 .Width     = THIS.Width
157:                 .Height    = 40
158:                 .FontName  = "Tahoma"
159:                 .FontSize  = 16
160:                 .FontBold  = .T.
161:                 .ForeColor = RGB(0, 0, 0)
162:                 .BackStyle = 0
163:                 .AutoSize  = .F.
164:                 .Visible   = .T.
165:             ENDWITH
166: 
167:             .AddObject("lbl_4c_Titulo", "Label")
168:             WITH .lbl_4c_Titulo
169:                 .Caption   = THIS.Caption
170:                 .Top       = 18
171:                 .Left      = 10
172:                 .Width     = THIS.Width
173:                 .Height    = 46
174:                 .FontName  = "Tahoma"
175:                 .FontSize  = 16
176:                 .FontBold  = .T.

*-- Linhas 186 a 515:
186:         *-- onde comeca o botao Encerrar do cnt_4c_Saida (917 + 5).
187:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
188:         WITH loc_oPagina.cnt_4c_Botoes
189:             .Top           = 29
190:             .Left          = 542
191:             .Width         = 390
192:             .Height        = 85
193:             .BackStyle = 1
194:             .BackColor = RGB(255, 255, 255)
195:             .BorderWidth   = 0
196:             .SpecialEffect = 0
197:             .Visible       = .T.
198:         ENDWITH
199: 
200:         *-- Botao Incluir (Left=5)
201:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
202:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
203:             .Caption         = "Incluir"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
205:             .PicturePosition = 13
206:             .Top             = 5
207:             .Left            = 5
208:             .Width           = 75
209:             .Height          = 75
210:             .FontName        = "Comic Sans MS"
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .FontSize        = 8
214:             .ForeColor       = RGB(90, 90, 90)
215:             .BackColor       = RGB(255, 255, 255)
216:             .Themes          = .F.
217:             .SpecialEffect   = 0
218:             .MousePointer    = 15
219:             .WordWrap        = .T.
220:             .AutoSize        = .F.
221:             .Visible         = .T.
222:         ENDWITH
223:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
224: 
225:         *-- Botao Visualizar (Left=80)
226:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
227:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
228:             .Caption         = "Visualizar"
229:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
230:             .PicturePosition = 13
231:             .Top             = 5
232:             .Left            = 80
233:             .Width           = 75
234:             .Height          = 75
235:             .FontName        = "Comic Sans MS"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .FontSize        = 8
239:             .ForeColor       = RGB(90, 90, 90)
240:             .BackColor       = RGB(255, 255, 255)
241:             .Themes          = .F.
242:             .SpecialEffect   = 0
243:             .MousePointer    = 15
244:             .WordWrap        = .T.
245:             .AutoSize        = .F.
246:             .Visible         = .T.
247:         ENDWITH
248:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
249: 
250:         *-- Botao Alterar (Left=155)
251:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
252:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
253:             .Caption         = "Alterar"
254:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
255:             .PicturePosition = 13
256:             .Top             = 5
257:             .Left            = 155
258:             .Width           = 75
259:             .Height          = 75
260:             .FontName        = "Comic Sans MS"
261:             .FontBold        = .T.
262:             .FontItalic      = .T.
263:             .FontSize        = 8
264:             .ForeColor       = RGB(90, 90, 90)
265:             .BackColor       = RGB(255, 255, 255)
266:             .Themes          = .F.
267:             .SpecialEffect   = 0
268:             .MousePointer    = 15
269:             .WordWrap        = .T.
270:             .AutoSize        = .F.
271:             .Visible         = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
274: 
275:         *-- Botao Excluir (Left=230)
276:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
277:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
278:             .Caption         = "Excluir"
279:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
280:             .PicturePosition = 13
281:             .Top             = 5
282:             .Left            = 230
283:             .Width           = 75
284:             .Height          = 75
285:             .FontName        = "Comic Sans MS"
286:             .FontBold        = .T.
287:             .FontItalic      = .T.
288:             .FontSize        = 8
289:             .ForeColor       = RGB(90, 90, 90)
290:             .BackColor       = RGB(255, 255, 255)
291:             .Themes          = .F.
292:             .SpecialEffect   = 0
293:             .MousePointer    = 15
294:             .WordWrap        = .T.
295:             .AutoSize        = .F.
296:             .Visible         = .T.
297:         ENDWITH
298:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
299: 
300:         *-- Botao Buscar (Left=305). NAO abre picker (Erro167/Erro177): o legado
301:         *-- (PROCEDURE msv_procurar) faz busca POR EXEMPLO na propria pagina de
302:         *-- Dados, com os campos plProcurar editaveis - ver ADENDO de Erro178.
303:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
304:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
305:             .Caption         = "Buscar"
306:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
307:             .PicturePosition = 13
308:             .Top             = 5
309:             .Left            = 305
310:             .Width           = 75
311:             .Height          = 75
312:             .FontName        = "Comic Sans MS"
313:             .FontBold        = .T.
314:             .FontItalic      = .T.
315:             .FontSize        = 8
316:             .ForeColor       = RGB(90, 90, 90)
317:             .BackColor       = RGB(255, 255, 255)
318:             .Themes          = .F.
319:             .SpecialEffect   = 0
320:             .MousePointer    = 15
321:             .WordWrap        = .T.
322:             .AutoSize        = .F.
323:             .Visible         = .T.
324:         ENDWITH
325:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
326: 
327:         *-- Container de saida - padrao canonico (CLAUDE.md #10) prevalece
328:         *-- sobre o SCX legado (Grupo_Saida.Left = 927).
329:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
330:         WITH loc_oPagina.cnt_4c_Saida
331:             .Top           = 29
332:             .Left          = 917
333:             .Width         = 90
334:             .Height        = 85
335:             .BackStyle = 1
336:             .BackColor = RGB(255, 255, 255)
337:             .BorderWidth   = 0
338:             .SpecialEffect = 0
339:             .Visible       = .T.
340:         ENDWITH
341: 
342:         *-- Botao Encerrar - padrao canonico (Caption="Encerrar", 75x75)
343:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
344:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
345:             .Caption         = "Encerrar"
346:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
347:             .PicturePosition = 13
348:             .Top             = 5
349:             .Left            = 5
350:             .Width           = 75
351:             .Height          = 75
352:             .FontName        = "Comic Sans MS"
353:             .FontBold        = .T.
354:             .FontItalic      = .T.
355:             .FontSize        = 8
356:             .ForeColor       = RGB(90, 90, 90)
357:             .BackColor       = RGB(255, 255, 255)
358:             .Themes          = .F.
359:             .SpecialEffect   = 0
360:             .MousePointer    = 15
361:             .WordWrap        = .T.
362:             .AutoSize        = .F.
363:             .Visible         = .T.
364:         ENDWITH
365:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
366: 
367:         *-- Container dos filtros da lista (cntFiltros legado: grupo de produto,
368:         *-- faixa de datas de ultima alteracao e situacao Geral/Ativos/Inativos).
369:         *-- Regra #35 do CLAUDE.md: o filtro eh aplicado SEMPRE - com o grupo
370:         *-- vazio a lista abre vazia de proposito, esperando o usuario escolher.
371:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
372:         WITH loc_oPagina.cnt_4c_Filtros
373:             .Top           = 122
374:             .Left          = 31
375:             .Width         = 388
376:             .Height        = 63
377:             .BackStyle     = 0
378:             .BorderWidth   = 0
379:             .SpecialEffect = 0
380:             .Visible       = .T.
381: 
382:             .AddObject("lbl_4c_Grupo", "Label")
383:             WITH .lbl_4c_Grupo
384:                 .Caption   = "Grupo de Produto :"
385:                 .Top       = 10
386:                 .Left      = 19
387:                 .Width     = 94
388:                 .Height    = 15
389:                 .BackStyle = 0
390:                 .ForeColor = RGB(90, 90, 90)
391:                 .FontName  = "Tahoma"
392:                 .FontSize  = 8
393:                 .Visible   = .T.
394:             ENDWITH
395: 
396:             .AddObject("txt_4c_Cgru", "TextBox")
397:             WITH .txt_4c_Cgru
398:                 .Top       = 6
399:                 .Left      = 116
400:                 .Width     = 31
401:                 .Height    = 23
402:                 .MaxLength = 3
403:                 .FontName  = "Tahoma"
404:                 .FontSize  = 8
405:                 .Visible   = .T.
406:             ENDWITH
407:             BINDEVENT(.txt_4c_Cgru, "KeyPress", THIS, "ValidarGrupoFiltro")
408: 
409:             .AddObject("txt_4c_Dgru", "TextBox")
410:             WITH .txt_4c_Dgru
411:                 .Top       = 6
412:                 .Left      = 149
413:                 .Width     = 156
414:                 .Height    = 23
415:                 .MaxLength = 20
416:                 .FontName  = "Tahoma"
417:                 .FontSize  = 8
418:                 .Visible   = .T.
419:             ENDWITH
420:             BINDEVENT(.txt_4c_Dgru, "KeyPress", THIS, "ValidarGrupoPorDescricao")
421: 
422:             .AddObject("lbl_4c_UltimaAlteracao", "Label")
423:             WITH .lbl_4c_UltimaAlteracao
424:                 .Caption   = "" + CHR(218) + "ltima Altera" + CHR(231) + CHR(227) + "o :"
425:                 .Top       = 35
426:                 .Left      = 26
427:                 .Width     = 87
428:                 .Height    = 15
429:                 .BackStyle = 0
430:                 .ForeColor = RGB(90, 90, 90)
431:                 .FontName  = "Tahoma"
432:                 .FontSize  = 8
433:                 .Visible   = .T.
434:             ENDWITH
435: 
436:             .AddObject("txt_4c_DtIni", "TextBox")
437:             WITH .txt_4c_DtIni
438:                 .Top      = 31
439:                 .Left     = 116
440:                 .Width    = 78
441:                 .Height   = 23
442:                 .FontName = "Tahoma"
443:                 .FontSize = 8
444:                 .Value    = {^1900-01-01}
445:                 .Visible  = .T.
446:             ENDWITH
447:             BINDEVENT(.txt_4c_DtIni, "LostFocus", THIS, "RecarregarListaFiltrada")
448: 
449:             .AddObject("lbl_4c_Ate", "Label")
450:             WITH .lbl_4c_Ate
451:                 .Caption   = "at" + CHR(233)
452:                 .Top       = 35
453:                 .Left      = 202
454:                 .Width     = 18
455:                 .Height    = 15
456:                 .BackStyle = 0
457:                 .ForeColor = RGB(90, 90, 90)
458:                 .FontName  = "Tahoma"
459:                 .FontSize  = 8
460:                 .Visible   = .T.
461:             ENDWITH
462: 
463:             .AddObject("txt_4c_DtFim", "TextBox")
464:             WITH .txt_4c_DtFim
465:                 .Top      = 31
466:                 .Left     = 225
467:                 .Width    = 78
468:                 .Height   = 23
469:                 .FontName = "Tahoma"
470:                 .FontSize = 8
471:                 .Value    = {^2900-12-31}
472:                 .Visible  = .T.
473:             ENDWITH
474:             BINDEVENT(.txt_4c_DtFim, "LostFocus", THIS, "RecarregarListaFiltrada")
475: 
476:             .AddObject("opt_4c_FilSituas", "OptionGroup")
477:             WITH .opt_4c_FilSituas
478:                 .ButtonCount = 3
479:                 .Top         = 6
480:                 .Left        = 308
481:                 .Width       = 78
482:                 .Height      = 46
483:                 .BackStyle   = 0
484:                 .Value       = 1
485:                 .Visible     = .T.
486:             ENDWITH
487:             WITH .opt_4c_FilSituas.Buttons(1)
488:                 .Caption   = "Geral"
489:                 .Top       = 2
490:                 .Left      = 2
491:                 .Width     = 70
492:                 .AutoSize  = .T.
493:                 .ForeColor = RGB(90, 90, 90)
494:                 .FontName  = "Tahoma"
495:                 .FontSize  = 8
496:             ENDWITH
497:             WITH .opt_4c_FilSituas.Buttons(2)
498:                 .Caption   = "Ativos"
499:                 .Top       = 17
500:                 .Left      = 2
501:                 .Width     = 70
502:                 .AutoSize  = .T.
503:                 .ForeColor = RGB(90, 90, 90)
504:                 .FontName  = "Tahoma"
505:                 .FontSize  = 8
506:             ENDWITH
507:             WITH .opt_4c_FilSituas.Buttons(3)
508:                 .Caption   = "Inativos"
509:                 .Top       = 32
510:                 .Left      = 2
511:                 .Width     = 70
512:                 .AutoSize  = .T.
513:                 .ForeColor = RGB(90, 90, 90)
514:                 .FontName  = "Tahoma"
515:                 .FontSize  = 8

*-- Linhas 524 a 533:
524:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas)
525:         loc_oPagina.grd_4c_Dados.ColumnCount = 7
526:         WITH loc_oPagina.grd_4c_Dados
527:             .Top                = 195
528:             .Left               = 26
529:             .Width              = 860
530:             .Height             = 400
531:             .FontName           = "Verdana"
532:             .FontSize           = 8
533:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 547 a 573:
547:             .Visible            = .T.
548:         ENDWITH
549: 
550:         *-- Coluna 7 (checkbox "I" = Inativo): AddObject + CurrentControl
551:         *-- obrigatorios para o controle aparecer (regra #18 do CLAUDE.md).
552:         loc_oPagina.grd_4c_Dados.Column7.AddObject("chk_4c_Inativo", "CheckBox")
553:         WITH loc_oPagina.grd_4c_Dados.Column7
554:             .CurrentControl = "chk_4c_Inativo"
555:             .Sparse         = .F.
556:             .ReadOnly       = .T.
557:             .chk_4c_Inativo.Enabled = .F.
558:         ENDWITH
559: 
560:         BINDEVENT(loc_oPagina.grd_4c_Dados, "DblClick", THIS, "BtnVisualizarClick")
561:         BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GridDadosAfterRowColChange")
562: 
563:         *-- Rodape: contador de produtos selecionados/listados (lblProdutos legado)
564:         loc_oPagina.AddObject("lbl_4c_Produtos", "Label")
565:         WITH loc_oPagina.lbl_4c_Produtos
566:             .Caption   = "Produtos Selecionados : 0"
567:             .Top       = 600
568:             .Left      = 35
569:             .Width     = 250
570:             .Height    = 15
571:             .BackStyle = 0
572:             .ForeColor = RGB(90, 90, 90)
573:             .FontName  = "Tahoma"

*-- Linhas 635 a 643:
635:             loc_nTotal = RECCOUNT("cursor_4c_Dados")
636:         ENDIF
637: 
638:         THIS.pgf_4c_Paginas.Page1.lbl_4c_Produtos.Caption = ;
639:             "Produtos Selecionados : " + TRANSFORM(loc_nTotal)
640:     ENDPROC
641: 
642:     *===========================================================================
643:     * GridDadosAfterRowColChange - Handler de BINDEVENT (regra #38 - precisa

*-- Linhas 961 a 998:
961:         *-- Faixa cinza do cabecalho (CLAUDE.md #11 - nas DUAS paginas)
962:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
963:         WITH loc_oPagina.cnt_4c_Cabecalho
964:             .Top           = 29
965:             .Left          = 0
966:             .Width         = THIS.Width
967:             .Height        = 80
968:             .BackColor     = RGB(100, 100, 100)
969:             .BorderWidth   = 0
970:             .SpecialEffect = 0
971:             .Visible       = .T.
972: 
973:             .AddObject("lbl_4c_Sombra", "Label")
974:             WITH .lbl_4c_Sombra
975:                 .Caption   = THIS.Caption
976:                 .Top       = 15
977:                 .Left      = 10
978:                 .Width     = THIS.Width
979:                 .Height    = 40
980:                 .FontName  = "Tahoma"
981:                 .FontSize  = 16
982:                 .FontBold  = .T.
983:                 .ForeColor = RGB(0, 0, 0)
984:                 .BackStyle = 0
985:                 .AutoSize  = .F.
986:                 .Visible   = .T.
987:             ENDWITH
988: 
989:             .AddObject("lbl_4c_Titulo", "Label")
990:             WITH .lbl_4c_Titulo
991:                 .Caption   = THIS.Caption
992:                 .Top       = 18
993:                 .Left      = 10
994:                 .Width     = THIS.Width
995:                 .Height    = 46
996:                 .FontName  = "Tahoma"
997:                 .FontSize  = 16
998:                 .FontBold  = .T.

*-- Linhas 1012 a 1082:
1012:         loc_oPagina.AddObject("pgf_4c_Divisoes", "PageFrame")
1013:         WITH loc_oPagina.pgf_4c_Divisoes
1014:             .PageCount = 8
1015:             .Top       = 29
1016:             .Left      = 3
1017:             .Width     = 1009
1018:             .Height    = 598
1019:             .Tabs      = .F.
1020:             .Visible   = .T.
1021:         ENDWITH
1022: 
1023:         WITH loc_oPagina.pgf_4c_Divisoes
1024:             *-- Captions transcritos do SCX (PageOrder 1..8 = ordem declarada).
1025:             *-- Com Tabs = .F. eles nao aparecem; ficam fieis ao legado.
1026:             .Page1.Caption   = "Dados Principais"      && pgDados
1027:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
1028:             .Page1.BackColor = RGB(255, 255, 255)
1029:             .Page1.ForeColor = RGB(36, 84, 155)
1030:             .Page1.FontBold  = .T.
1031: 
1032:             .Page2.Caption   = "Custos"                && pgComposicao
1033:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
1034:             .Page2.BackColor = RGB(240, 240, 240)
1035:             .Page2.ForeColor = RGB(36, 84, 155)
1036:             .Page2.FontName  = "Verdana"
1037:             .Page2.FontSize  = 8
1038:             .Page2.FontBold  = .T.
1039: 
1040:             .Page3.Caption   = "Dados Fiscais"         && pgDadosFiscais
1041:             .Page3.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
1042:             .Page3.BackColor = RGB(255, 255, 255)
1043:             .Page3.ForeColor = RGB(36, 84, 155)
1044:             .Page3.FontName  = "Verdana"
1045:             .Page3.FontSize  = 8
1046:             .Page3.FontBold  = .T.
1047: 
1048:             .Page4.Caption   = "Processos"             && PgDadosFaseP
1049:             .Page4.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
1050:             .Page4.BackColor = RGB(255, 255, 255)
1051:             .Page4.ForeColor = RGB(36, 84, 155)
1052:             .Page4.FontName  = "Verdana"
1053:             .Page4.FontSize  = 8
1054:             .Page4.FontBold  = .T.
1055: 
1056:             .Page5.Caption   = "Consumo"               && PgDadosConsP
1057:             .Page5.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
1058:             .Page5.BackColor = RGB(255, 255, 255)
1059:             .Page5.ForeColor = RGB(36, 84, 155)
1060:             .Page5.FontName  = "Verdana"
1061:             .Page5.FontSize  = 8
1062:             .Page5.FontBold  = .T.
1063: 
1064:             .Page6.Caption   = "Composi" + CHR(231) + CHR(227) + "o"   && pgCusto
1065:             .Page6.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
1066:             .Page6.BackColor = RGB(255, 255, 255)
1067:             .Page6.ForeColor = RGB(36, 84, 155)
1068:             .Page6.FontName  = "Verdana"
1069:             .Page6.FontSize  = 8
1070:             .Page6.FontBold  = .T.
1071: 
1072:             *-- Caption "Page1" e o texto original do SCX nesta aba (Designer)
1073:             .Page7.Caption   = "Page1"                 && pgDesigner
1074:             .Page7.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
1075:             .Page7.BackColor = RGB(255, 255, 255)
1076: 
1077:             .Page8.Caption   = "Servi" + CHR(231) + "os"               && pgServico
1078:             .Page8.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
1079:             .Page8.BackColor = RGB(255, 255, 255)
1080: 
1081:             .ActivePage = 1
1082:         ENDWITH

*-- Linhas 1114 a 1190:
1114:         THIS.ConfigurarPgpgDesigner()
1115: 
1116:         *-- Campos da aba "Servicos" (pgServico legado - grade de servicos
1117:         *-- vinculados ao produto com checkbox de marcacao - FASE 15)
1118:         THIS.ConfigurarPgpgServico()
1119: 
1120:         THIS.ConfigurarNavegacaoDivisoes(loc_oPagina)
1121: 
1122:         *-- Container Confirmar / Cancelar (Grupo_Salva legado: Top=2, Left=848,
1123:         *-- Height=85, com Salva em Left=5 e Cancelar em Left=80)
1124:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
1125:         WITH loc_oPagina.cnt_4c_BotoesAcao
1126:             .Top           = 31
1127:             .Left          = 848
1128:             .Width         = 160
1129:             .Height        = 85
1130:             .BackStyle = 1
1131:             .BackColor = RGB(255, 255, 255)
1132:             .BorderWidth   = 0
1133:             .SpecialEffect = 0
1134:             .Visible       = .T.
1135:         ENDWITH
1136: 
1137:         *-- Botao Confirmar (Salva legado: Left=5 dentro do Grupo_Salva)
1138:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
1139:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
1140:             .Caption         = "Confirmar"
1141:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1142:             .PicturePosition = 13
1143:             .Top             = 5
1144:             .Left            = 5
1145:             .Width           = 75
1146:             .Height          = 75
1147:             .FontName        = "Comic Sans MS"
1148:             .FontBold        = .T.
1149:             .FontItalic      = .T.
1150:             .FontSize        = 8
1151:             .ForeColor       = RGB(90, 90, 90)
1152:             .BackColor       = RGB(255, 255, 255)
1153:             .Themes          = .F.
1154:             .SpecialEffect   = 0
1155:             .MousePointer    = 15
1156:             .WordWrap        = .T.
1157:             .AutoSize        = .F.
1158:             .Visible         = .T.
1159:         ENDWITH
1160:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1161: 
1162:         *-- Botao Cancelar (Cancelar legado: Left=80 dentro do Grupo_Salva)
1163:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
1164:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
1165:             .Caption         = "Encerrar"
1166:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1167:             .PicturePosition = 13
1168:             .Top             = 5
1169:             .Left            = 80
1170:             .Width           = 75
1171:             .Height          = 75
1172:             .FontName        = "Comic Sans MS"
1173:             .FontBold        = .T.
1174:             .FontItalic      = .T.
1175:             .FontSize        = 8
1176:             .ForeColor       = RGB(90, 90, 90)
1177:             .BackColor       = RGB(255, 255, 255)
1178:             .Themes          = .F.
1179:             .SpecialEffect   = 0
1180:             .MousePointer    = 15
1181:             .WordWrap        = .T.
1182:             .AutoSize        = .F.
1183:             .Visible         = .T.
1184:         ENDWITH
1185:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
1186: 
1187:         *-- Z-ORDER: navegacao e botoes de acao sempre na frente do PageFrame
1188:         loc_oPagina.opt_4c_Navegacao.ZOrder(0)
1189:         loc_oPagina.cnt_4c_BotoesAcao.ZOrder(0)
1190: 

*-- Linhas 1205 a 1832:
1205:         *-- Imagem principal do produto (shpFig / ImgFigJpg)
1206:         par_oPagina.AddObject("shp_4c_ShpFig", "Shape")
1207:         WITH par_oPagina.shp_4c_ShpFig
1208:             .Top     = 505
1209:             .Left    = 600
1210:             .Width   = 174
1211:             .Height  = 114
1212:             .Visible = .T.
1213:         ENDWITH
1214: 
1215:         par_oPagina.AddObject("img_4c_ImgFigJpg", "Image")
1216:         WITH par_oPagina.img_4c_ImgFigJpg
1217:             .Top      = 506
1218:             .Left     = 601
1219:             .Width    = 172
1220:             .Height   = 112
1221:             .Stretch  = 2
1222:             .Visible  = .T.
1223:         ENDWITH
1224: 
1225:         *-- Produto :  (Label2 - colide com Say2 "Equivalente :" no mapeamento
1226:         *-- original; renomeado para lbl_4c_LblProduto - fix no mapeamento.json)
1227:         par_oPagina.AddObject("lbl_4c_LblProduto", "Label")
1228:         WITH par_oPagina.lbl_4c_LblProduto
1229:             .Caption   = "Produto :"
1230:             .Top       = 121
1231:             .Left      = 47
1232:             .Width     = 53
1233:             .Height    = 15
1234:             .BackStyle = 0
1235:             .ForeColor = RGB(90, 90, 90)
1236:             .FontName  = "Tahoma"
1237:             .FontSize  = 8
1238:             .Visible   = .T.
1239:         ENDWITH
1240: 
1241:         par_oPagina.AddObject("txt_4c_Cpro", "TextBox")
1242:         WITH par_oPagina.txt_4c_Cpro
1243:             .Top       = 117
1244:             .Left      = 102
1245:             .Width     = 108
1246:             .Height    = 22
1247:             .MaxLength = 14
1248:             .FontName  = "Tahoma"
1249:             .FontSize  = 8
1250:             .Visible   = .T.
1251:         ENDWITH
1252:         BINDEVENT(par_oPagina.txt_4c_Cpro, "KeyPress", THIS, "ValidarCodigoProdutoDados")
1253: 
1254:         par_oPagina.AddObject("txt_4c_Dpro", "TextBox")
1255:         WITH par_oPagina.txt_4c_Dpro
1256:             .Top       = 117
1257:             .Left      = 211
1258:             .Width     = 290
1259:             .Height    = 22
1260:             .MaxLength = 65
1261:             .FontName  = "Tahoma"
1262:             .FontSize  = 8
1263:             .Visible   = .T.
1264:         ENDWITH
1265: 
1266:         *-- Descritivo :  (getDPro2s)
1267:         par_oPagina.AddObject("lbl_4c_Label10", "Label")
1268:         WITH par_oPagina.lbl_4c_Label10
1269:             .Caption   = "Descritivo :"
1270:             .Top       = 144
1271:             .Left      = 44
1272:             .Width     = 56
1273:             .Height    = 15
1274:             .BackStyle = 0
1275:             .ForeColor = RGB(90, 90, 90)
1276:             .FontName  = "Tahoma"
1277:             .FontSize  = 8
1278:             .Visible   = .T.
1279:         ENDWITH
1280: 
1281:         par_oPagina.AddObject("txt_4c_DPro2s", "TextBox")
1282:         WITH par_oPagina.txt_4c_DPro2s
1283:             .Top       = 140
1284:             .Left      = 102
1285:             .Width     = 399
1286:             .Height    = 22
1287:             .MaxLength = 45
1288:             .FontName  = "Tahoma"
1289:             .FontSize  = 8
1290:             .Visible   = .T.
1291:         ENDWITH
1292: 
1293:         *-- Barra :  (getCbar) + EAN13 (getEAN13) + Equivalente (Get_CProEq)
1294:         par_oPagina.AddObject("lbl_4c_Label15", "Label")
1295:         WITH par_oPagina.lbl_4c_Label15
1296:             .Caption   = "Barra :"
1297:             .Top       = 143
1298:             .Left      = 595
1299:             .Width     = 35
1300:             .Height    = 15
1301:             .BackStyle = 0
1302:             .ForeColor = RGB(90, 90, 90)
1303:             .FontName  = "Tahoma"
1304:             .FontSize  = 8
1305:             .Visible   = .T.
1306:         ENDWITH
1307: 
1308:         par_oPagina.AddObject("txt_4c_Cbar", "TextBox")
1309:         WITH par_oPagina.txt_4c_Cbar
1310:             .Top       = 139
1311:             .Left      = 633
1312:             .Width     = 108
1313:             .Height    = 23
1314:             .InputMask = "99999999999999"
1315:             .FontName  = "Tahoma"
1316:             .FontSize  = 8
1317:             .Visible   = .T.
1318:         ENDWITH
1319: 
1320:         par_oPagina.AddObject("lbl_4c_Label1", "Label")
1321:         WITH par_oPagina.lbl_4c_Label1
1322:             .Caption   = "EAN13 :"
1323:             .Top       = 167
1324:             .Left      = 589
1325:             .Width     = 41
1326:             .Height    = 15
1327:             .BackStyle = 0
1328:             .ForeColor = RGB(90, 90, 90)
1329:             .FontName  = "Tahoma"
1330:             .FontSize  = 8
1331:             .Visible   = .T.
1332:         ENDWITH
1333: 
1334:         par_oPagina.AddObject("txt_4c_EAN13", "TextBox")
1335:         WITH par_oPagina.txt_4c_EAN13
1336:             .Top       = 163
1337:             .Left      = 633
1338:             .Width     = 108
1339:             .Height    = 23
1340:             .InputMask = "9999999999999"
1341:             .FontName  = "Tahoma"
1342:             .FontSize  = 8
1343:             .Visible   = .T.
1344:         ENDWITH
1345: 
1346:         par_oPagina.AddObject("lbl_4c_Label2", "Label")
1347:         WITH par_oPagina.lbl_4c_Label2
1348:             .Caption   = "Equivalente :"
1349:             .Top       = 120
1350:             .Left      = 565
1351:             .Width     = 65
1352:             .Height    = 15
1353:             .BackStyle = 0
1354:             .ForeColor = RGB(90, 90, 90)
1355:             .FontName  = "Tahoma"
1356:             .FontSize  = 8
1357:             .Visible   = .T.
1358:         ENDWITH
1359: 
1360:         par_oPagina.AddObject("txt_4c_CProEq", "TextBox")
1361:         WITH par_oPagina.txt_4c_CProEq
1362:             .Top       = 115
1363:             .Left      = 633
1364:             .Width     = 108
1365:             .Height    = 23
1366:             .MaxLength = 14
1367:             .FontName  = "Tahoma"
1368:             .FontSize  = 8
1369:             .Visible   = .T.
1370:         ENDWITH
1371:         BINDEVENT(par_oPagina.txt_4c_CProEq, "KeyPress", THIS, "ValidarProdutoEquivalente")
1372: 
1373:         *-- Grupo / Subgrupo / Linha / Colecao / Grupo de Venda (Mercs)
1374:         par_oPagina.AddObject("lbl_4c_Label8", "Label")
1375:         WITH par_oPagina.lbl_4c_Label8
1376:             .Caption   = "Grupo :"
1377:             .Top       = 190
1378:             .Left      = 62
1379:             .Width     = 38
1380:             .Height    = 15
1381:             .BackStyle = 0
1382:             .ForeColor = RGB(90, 90, 90)
1383:             .FontName  = "Tahoma"
1384:             .FontSize  = 8
1385:             .Visible   = .T.
1386:         ENDWITH
1387: 
1388:         par_oPagina.AddObject("txt_4c_Cgru", "TextBox")
1389:         WITH par_oPagina.txt_4c_Cgru
1390:             .Top       = 186
1391:             .Left      = 102
1392:             .Width     = 31
1393:             .Height    = 22
1394:             .MaxLength = 3
1395:             .FontName  = "Tahoma"
1396:             .FontSize  = 8
1397:             .Visible   = .T.
1398:         ENDWITH
1399:         BINDEVENT(par_oPagina.txt_4c_Cgru, "KeyPress", THIS, "ValidarGrupoDadosPorCodigo")
1400: 
1401:         par_oPagina.AddObject("txt_4c_Dgru", "TextBox")
1402:         WITH par_oPagina.txt_4c_Dgru
1403:             .Top       = 186
1404:             .Left      = 134
1405:             .Width     = 171
1406:             .Height    = 22
1407:             .MaxLength = 30
1408:             .FontName  = "Tahoma"
1409:             .FontSize  = 8
1410:             .Visible   = .T.
1411:         ENDWITH
1412:         BINDEVENT(par_oPagina.txt_4c_Dgru, "KeyPress", THIS, "ValidarGrupoDadosPorDescricao")
1413: 
1414:         par_oPagina.AddObject("lbl_4c_Label9", "Label")
1415:         WITH par_oPagina.lbl_4c_Label9
1416:             .Caption   = "Subgrupo :"
1417:             .Top       = 213
1418:             .Left      = 45
1419:             .Width     = 55
1420:             .Height    = 15
1421:             .BackStyle = 0
1422:             .ForeColor = RGB(90, 90, 90)
1423:             .FontName  = "Tahoma"
1424:             .FontSize  = 8
1425:             .Visible   = .T.
1426:         ENDWITH
1427: 
1428:         par_oPagina.AddObject("txt_4c_CSGru", "TextBox")
1429:         WITH par_oPagina.txt_4c_CSGru
1430:             .Top       = 209
1431:             .Left      = 102
1432:             .Width     = 52
1433:             .Height    = 22
1434:             .MaxLength = 6
1435:             .FontName  = "Tahoma"
1436:             .FontSize  = 8
1437:             .Visible   = .T.
1438:         ENDWITH
1439:         BINDEVENT(par_oPagina.txt_4c_CSGru, "KeyPress", THIS, "ValidarSubgrupoDadosPorCodigo")
1440: 
1441:         par_oPagina.AddObject("txt_4c_DsGru", "TextBox")
1442:         WITH par_oPagina.txt_4c_DsGru
1443:             .Top       = 209
1444:             .Left      = 155
1445:             .Width     = 150
1446:             .Height    = 22
1447:             .MaxLength = 30
1448:             .FontName  = "Tahoma"
1449:             .FontSize  = 8
1450:             .Visible   = .T.
1451:         ENDWITH
1452:         BINDEVENT(par_oPagina.txt_4c_DsGru, "KeyPress", THIS, "ValidarSubgrupoDadosPorDescricao")
1453: 
1454:         par_oPagina.AddObject("lbl_4c_Label16", "Label")
1455:         WITH par_oPagina.lbl_4c_Label16
1456:             .Caption   = "Linha :"
1457:             .Top       = 236
1458:             .Left      = 66
1459:             .Width     = 34
1460:             .Height    = 15
1461:             .BackStyle = 0
1462:             .ForeColor = RGB(90, 90, 90)
1463:             .FontName  = "Tahoma"
1464:             .FontSize  = 8
1465:             .Visible   = .T.
1466:         ENDWITH
1467: 
1468:         par_oPagina.AddObject("txt_4c_Lin", "TextBox")
1469:         WITH par_oPagina.txt_4c_Lin
1470:             .Top       = 232
1471:             .Left      = 102
1472:             .Width     = 80
1473:             .Height    = 22
1474:             .MaxLength = 10
1475:             .FontName  = "Tahoma"
1476:             .FontSize  = 8
1477:             .Visible   = .T.
1478:         ENDWITH
1479:         BINDEVENT(par_oPagina.txt_4c_Lin, "KeyPress", THIS, "ValidarLinhaDadosPorCodigo")
1480: 
1481:         par_oPagina.AddObject("txt_4c_DLin", "TextBox")
1482:         WITH par_oPagina.txt_4c_DLin
1483:             .Top       = 232
1484:             .Left      = 183
1485:             .Width     = 196
1486:             .Height    = 22
1487:             .MaxLength = 30
1488:             .FontName  = "Tahoma"
1489:             .FontSize  = 8
1490:             .Visible   = .T.
1491:         ENDWITH
1492:         BINDEVENT(par_oPagina.txt_4c_DLin, "KeyPress", THIS, "ValidarLinhaDadosPorDescricao")
1493: 
1494:         par_oPagina.AddObject("lbl_4c_Label17", "Label")
1495:         WITH par_oPagina.lbl_4c_Label17
1496:             .Caption   = "Grupo de Venda :"
1497:             .Top       = 258
1498:             .Left      = 14
1499:             .Width     = 86
1500:             .Height    = 15
1501:             .BackStyle = 0
1502:             .ForeColor = RGB(90, 90, 90)
1503:             .FontName  = "Tahoma"
1504:             .FontSize  = 8
1505:             .Visible   = .T.
1506:         ENDWITH
1507: 
1508:         par_oPagina.AddObject("txt_4c_Col", "TextBox")
1509:         WITH par_oPagina.txt_4c_Col
1510:             .Top       = 255
1511:             .Left      = 102
1512:             .Width     = 80
1513:             .Height    = 22
1514:             .MaxLength = 10
1515:             .FontName  = "Tahoma"
1516:             .FontSize  = 8
1517:             .Visible   = .T.
1518:         ENDWITH
1519:         BINDEVENT(par_oPagina.txt_4c_Col, "KeyPress", THIS, "ValidarColecaoDadosPorCodigo")
1520: 
1521:         par_oPagina.AddObject("txt_4c_DCol", "TextBox")
1522:         WITH par_oPagina.txt_4c_DCol
1523:             .Top       = 255
1524:             .Left      = 183
1525:             .Width     = 318
1526:             .Height    = 22
1527:             .MaxLength = 30
1528:             .FontName  = "Tahoma"
1529:             .FontSize  = 8
1530:             .Visible   = .T.
1531:         ENDWITH
1532:         BINDEVENT(par_oPagina.txt_4c_DCol, "KeyPress", THIS, "ValidarColecaoDadosPorDescricao")
1533: 
1534:         *-- Grande Grupo (Mercs) - preenchido automaticamente pelo grupo
1535:         par_oPagina.AddObject("txt_4c_Merc", "TextBox")
1536:         WITH par_oPagina.txt_4c_Merc
1537:             .Top       = 186
1538:             .Left      = 307
1539:             .Width     = 31
1540:             .Height    = 23
1541:             .MaxLength = 3
1542:             .ReadOnly  = .T.
1543:             .FontName  = "Tahoma"
1544:             .FontSize  = 8
1545:             .Visible   = .T.
1546:         ENDWITH
1547: 
1548:         *-- Classificacao (Get_Class) + Identificador (getIdeCPros)
1549:         par_oPagina.AddObject("lbl_4c_LblClassificacao", "Label")
1550:         WITH par_oPagina.lbl_4c_LblClassificacao
1551:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
1552:             .Top       = 397
1553:             .Left      = -4
1554:             .Width     = 104
1555:             .Height    = 15
1556:             .BackStyle = 0
1557:             .ForeColor = RGB(90, 90, 90)
1558:             .FontName  = "Tahoma"
1559:             .FontSize  = 8
1560:             .Visible   = .T.
1561:         ENDWITH
1562: 
1563:         par_oPagina.AddObject("txt_4c_Class", "TextBox")
1564:         WITH par_oPagina.txt_4c_Class
1565:             .Top       = 393
1566:             .Left      = 102
1567:             .Width     = 31
1568:             .Height    = 22
1569:             .MaxLength = 3
1570:             .FontName  = "Tahoma"
1571:             .FontSize  = 8
1572:             .Visible   = .T.
1573:         ENDWITH
1574:         BINDEVENT(par_oPagina.txt_4c_Class, "KeyPress", THIS, "ValidarClassificacaoDados")
1575: 
1576:         par_oPagina.AddObject("lbl_4c_Label23", "Label")
1577:         WITH par_oPagina.lbl_4c_Label23
1578:             .Caption   = "Identificador :"
1579:             .Top       = 213
1580:             .Left      = 397
1581:             .Width     = 70
1582:             .Height    = 15
1583:             .BackStyle = 0
1584:             .ForeColor = RGB(90, 90, 90)
1585:             .FontName  = "Tahoma"
1586:             .FontSize  = 8
1587:             .Visible   = .T.
1588:         ENDWITH
1589: 
1590:         par_oPagina.AddObject("txt_4c_IdeCPros", "TextBox")
1591:         WITH par_oPagina.txt_4c_IdeCPros
1592:             .Top       = 209
1593:             .Left      = 470
1594:             .Width     = 31
1595:             .Height    = 22
1596:             .MaxLength = 3
1597:             .FontName  = "Tahoma"
1598:             .FontSize  = 8
1599:             .Visible   = .T.
1600:         ENDWITH
1601: 
1602:         *-- Fornecedor / Ref. Fornecedor
1603:         par_oPagina.AddObject("lbl_4c_Label11", "Label")
1604:         WITH par_oPagina.lbl_4c_Label11
1605:             .Caption   = "Fornecedor :"
1606:             .Top       = 305
1607:             .Left      = 36
1608:             .Width     = 64
1609:             .Height    = 15
1610:             .BackStyle = 0
1611:             .ForeColor = RGB(90, 90, 90)
1612:             .FontName  = "Tahoma"
1613:             .FontSize  = 8
1614:             .Visible   = .T.
1615:         ENDWITH
1616: 
1617:         par_oPagina.AddObject("txt_4c_Ifor", "TextBox")
1618:         WITH par_oPagina.txt_4c_Ifor
1619:             .Top       = 301
1620:             .Left      = 102
1621:             .Width     = 80
1622:             .Height    = 22
1623:             .MaxLength = 10
1624:             .FontName  = "Tahoma"
1625:             .FontSize  = 8
1626:             .Visible   = .T.
1627:         ENDWITH
1628:         BINDEVENT(par_oPagina.txt_4c_Ifor, "KeyPress", THIS, "ValidarFornecedorDadosPorCodigo")
1629: 
1630:         par_oPagina.AddObject("txt_4c_Dfor", "TextBox")
1631:         WITH par_oPagina.txt_4c_Dfor
1632:             .Top       = 301
1633:             .Left      = 183
1634:             .Width     = 318
1635:             .Height    = 22
1636:             .MaxLength = 40
1637:             .FontName  = "Tahoma"
1638:             .FontSize  = 8
1639:             .Visible   = .T.
1640:         ENDWITH
1641:         BINDEVENT(par_oPagina.txt_4c_Dfor, "KeyPress", THIS, "ValidarFornecedorDadosPorDescricao")
1642: 
1643:         par_oPagina.AddObject("lbl_4c_Label12", "Label")
1644:         WITH par_oPagina.lbl_4c_Label12
1645:             .Caption   = "Ref. Fornecedor :"
1646:             .Top       = 327
1647:             .Left      = 12
1648:             .Width     = 88
1649:             .Height    = 15
1650:             .BackStyle = 0
1651:             .ForeColor = RGB(90, 90, 90)
1652:             .FontName  = "Tahoma"
1653:             .FontSize  = 8
1654:             .Visible   = .T.
1655:         ENDWITH
1656: 
1657:         par_oPagina.AddObject("txt_4c_Refs", "TextBox")
1658:         WITH par_oPagina.txt_4c_Refs
1659:             .Top       = 324
1660:             .Left      = 102
1661:             .Width     = 221
1662:             .Height    = 22
1663:             .MaxLength = 40
1664:             .FontName  = "Tahoma"
1665:             .FontSize  = 8
1666:             .Visible   = .T.
1667:         ENDWITH
1668: 
1669:         par_oPagina.AddObject("obj_4c_Bot_Fornecedor", "CommandGroup")
1670:         WITH par_oPagina.obj_4c_Bot_Fornecedor
1671:             .ButtonCount = 1
1672:             .Top         = 323
1673:             .Left        = 323
1674:             .Width       = 27
1675:             .Height      = 24
1676:             .BackStyle   = 0
1677:             .Visible     = .T.
1678:         ENDWITH
1679:         WITH par_oPagina.obj_4c_Bot_Fornecedor.Buttons(1)
1680:             .Caption = "..."
1681:             .Top     = 0
1682:             .Left    = 0
1683:             .Width   = 27
1684:             .Height  = 24
1685:         ENDWITH
1686: 
1687:         *-- Modelo (getCodFinP / getDesFinP)
1688:         par_oPagina.AddObject("lbl_4c_LblModelo", "Label")
1689:         WITH par_oPagina.lbl_4c_LblModelo
1690:             .Caption   = "Modelo :"
1691:             .Top       = 351
1692:             .Left      = -4
1693:             .Width     = 104
1694:             .Height    = 15
1695:             .BackStyle = 0
1696:             .ForeColor = RGB(90, 90, 90)
1697:             .FontName  = "Tahoma"
1698:             .FontSize  = 8
1699:             .Visible   = .T.
1700:         ENDWITH
1701: 
1702:         par_oPagina.AddObject("txt_4c_CodFinP", "TextBox")
1703:         WITH par_oPagina.txt_4c_CodFinP
1704:             .Top       = 347
1705:             .Left      = 102
1706:             .Width     = 31
1707:             .Height    = 22
1708:             .MaxLength = 3
1709:             .FontName  = "Tahoma"
1710:             .FontSize  = 8
1711:             .Visible   = .T.
1712:         ENDWITH
1713:         BINDEVENT(par_oPagina.txt_4c_CodFinP, "KeyPress", THIS, "ValidarModeloDadosPorCodigo")
1714: 
1715:         par_oPagina.AddObject("txt_4c_DesFinP", "TextBox")
1716:         WITH par_oPagina.txt_4c_DesFinP
1717:             .Top       = 347
1718:             .Left      = 134
1719:             .Width     = 150
1720:             .Height    = 22
1721:             .MaxLength = 30
1722:             .FontName  = "Tahoma"
1723:             .FontSize  = 8
1724:             .Visible   = .T.
1725:         ENDWITH
1726:         BINDEVENT(par_oPagina.txt_4c_DesFinP, "KeyPress", THIS, "ValidarModeloDadosPorDescricao")
1727: 
1728:         *-- Unidade (1) / Unidade (2) - Get_Cuni/Get_Duni e Get_cunip/get_dunip
1729:         par_oPagina.AddObject("lbl_4c_Label14", "Label")
1730:         WITH par_oPagina.lbl_4c_Label14
1731:             .Caption   = "Unidades (1) :"
1732:             .Top       = 420
1733:             .Left      = 30
1734:             .Width     = 70
1735:             .Height    = 15
1736:             .BackStyle = 0
1737:             .ForeColor = RGB(90, 90, 90)
1738:             .FontName  = "Tahoma"
1739:             .FontSize  = 8
1740:             .Visible   = .T.
1741:         ENDWITH
1742: 
1743:         par_oPagina.AddObject("txt_4c_Cuni", "TextBox")
1744:         WITH par_oPagina.txt_4c_Cuni
1745:             .Top       = 416
1746:             .Left      = 102
1747:             .Width     = 31
1748:             .Height    = 22
1749:             .MaxLength = 3
1750:             .FontName  = "Tahoma"
1751:             .FontSize  = 8
1752:             .Visible   = .T.
1753:         ENDWITH
1754:         BINDEVENT(par_oPagina.txt_4c_Cuni, "KeyPress", THIS, "ValidarUnidadeDadosPorCodigo")
1755: 
1756:         par_oPagina.AddObject("txt_4c_Duni", "TextBox")
1757:         WITH par_oPagina.txt_4c_Duni
1758:             .Top       = 416
1759:             .Left      = 134
1760:             .Width     = 150
1761:             .Height    = 22
1762:             .MaxLength = 30
1763:             .FontName  = "Tahoma"
1764:             .FontSize  = 8
1765:             .Visible   = .T.
1766:         ENDWITH
1767:         BINDEVENT(par_oPagina.txt_4c_Duni, "KeyPress", THIS, "ValidarUnidadeDadosPorDescricao")
1768: 
1769:         par_oPagina.AddObject("lbl_4c_Label18", "Label")
1770:         WITH par_oPagina.lbl_4c_Label18
1771:             .Caption   = "(2) :"
1772:             .Top       = 420
1773:             .Left      = 290
1774:             .Width     = 23
1775:             .Height    = 15
1776:             .BackStyle = 0
1777:             .ForeColor = RGB(90, 90, 90)
1778:             .FontName  = "Tahoma"
1779:             .FontSize  = 8
1780:             .Visible   = .T.
1781:         ENDWITH
1782: 
1783:         par_oPagina.AddObject("txt_4c_Cunip", "TextBox")
1784:         WITH par_oPagina.txt_4c_Cunip
1785:             .Top       = 416
1786:             .Left      = 319
1787:             .Width     = 31
1788:             .Height    = 22
1789:             .MaxLength = 3
1790:             .FontName  = "Tahoma"
1791:             .FontSize  = 8
1792:             .Visible   = .T.
1793:         ENDWITH
1794:         BINDEVENT(par_oPagina.txt_4c_Cunip, "KeyPress", THIS, "ValidarUnidadePedidoDadosPorCodigo")
1795: 
1796:         par_oPagina.AddObject("txt_4c__dunip", "TextBox")
1797:         WITH par_oPagina.txt_4c__dunip
1798:             .Top       = 416
1799:             .Left      = 351
1800:             .Width     = 150
1801:             .Height    = 22
1802:             .MaxLength = 30
1803:             .FontName  = "Tahoma"
1804:             .FontSize  = 8
1805:             .Visible   = .T.
1806:         ENDWITH
1807:         BINDEVENT(par_oPagina.txt_4c__dunip, "KeyPress", THIS, "ValidarUnidadePedidoDadosPorDescricao")
1808: 
1809:         *-- Local (Get_Local)
1810:         par_oPagina.AddObject("lbl_4c_Label5", "Label")
1811:         WITH par_oPagina.lbl_4c_Label5
1812:             .Caption   = "Local :"
1813:             .Top       = 397
1814:             .Left      = 354
1815:             .Width     = 33
1816:             .Height    = 15
1817:             .BackStyle = 0
1818:             .ForeColor = RGB(90, 90, 90)
1819:             .FontName  = "Tahoma"
1820:             .FontSize  = 8
1821:             .Visible   = .T.
1822:         ENDWITH
1823: 
1824:         par_oPagina.AddObject("txt_4c_Local", "TextBox")
1825:         WITH par_oPagina.txt_4c_Local
1826:             .Top       = 393
1827:             .Left      = 390
1828:             .Width     = 111
1829:             .Height    = 22
1830:             .MaxLength = 10
1831:             .FontName  = "Tahoma"
1832:             .FontSize  = 8

*-- Linhas 1838 a 2207:
1838:         par_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
1839:         WITH par_oPagina.obj_4c_Opc_situacao
1840:             .ButtonCount = 2
1841:             .Top         = 114
1842:             .Left        = 758
1843:             .Width       = 160
1844:             .Height      = 25
1845:             .BackStyle   = 0
1846:             .Value       = 1
1847:             .Visible     = .T.
1848:         ENDWITH
1849:         WITH par_oPagina.obj_4c_Opc_situacao.Buttons(1)
1850:             .Caption   = "Ativo"
1851:             .BackStyle = 0
1852:             .Top       = 3
1853:             .Left      = 2
1854:             .Width     = 70
1855:             .AutoSize  = .T.
1856:             .ForeColor = RGB(90, 90, 90)
1857:             .FontName  = "Tahoma"
1858:             .FontSize  = 8
1859:         ENDWITH
1860:         WITH par_oPagina.obj_4c_Opc_situacao.Buttons(2)
1861:             .Caption   = "Inativo"
1862:             .BackStyle = 0
1863:             .Top       = 3
1864:             .Left      = 80
1865:             .Width     = 70
1866:             .AutoSize  = .T.
1867:             .ForeColor = RGB(90, 90, 90)
1868:             .FontName  = "Tahoma"
1869:             .FontSize  = 8
1870:         ENDWITH
1871: 
1872:         *-- Observacoes livres (getObs1/getObs2/GetObs3)
1873:         par_oPagina.AddObject("txt_4c_Obs1", "TextBox")
1874:         WITH par_oPagina.txt_4c_Obs1
1875:             .Top       = 235
1876:             .Left      = 633
1877:             .Width     = 159
1878:             .Height    = 23
1879:             .MaxLength = 40
1880:             .FontName  = "Tahoma"
1881:             .FontSize  = 8
1882:             .Visible   = .T.
1883:         ENDWITH
1884: 
1885:         par_oPagina.AddObject("txt_4c_Obs2", "TextBox")
1886:         WITH par_oPagina.txt_4c_Obs2
1887:             .Top       = 259
1888:             .Left      = 633
1889:             .Width     = 159
1890:             .Height    = 23
1891:             .MaxLength = 40
1892:             .FontName  = "Tahoma"
1893:             .FontSize  = 8
1894:             .Visible   = .T.
1895:         ENDWITH
1896: 
1897:         par_oPagina.AddObject("txt_4c_Obs3", "TextBox")
1898:         WITH par_oPagina.txt_4c_Obs3
1899:             .Top       = 211
1900:             .Left      = 633
1901:             .Width     = 80
1902:             .Height    = 23
1903:             .MaxLength = 40
1904:             .FontName  = "Tahoma"
1905:             .FontSize  = 8
1906:             .Visible   = .T.
1907:         ENDWITH
1908: 
1909:         *-- Valores/moedas de custo total, venda e fator de venda (calculados -
1910:         *-- comportamento.json: When Return .f. em getCtotal/getPvenda/getFvenda)
1911:         par_oPagina.AddObject("lbl_4c_Label3", "Label")
1912:         WITH par_oPagina.lbl_4c_Label3
1913:             .Caption   = "Valor de Custo :"
1914:             .Top       = 311
1915:             .Left      = 551
1916:             .Width     = 79
1917:             .Height    = 15
1918:             .BackStyle = 0
1919:             .ForeColor = RGB(90, 90, 90)
1920:             .FontName  = "Tahoma"
1921:             .FontSize  = 8
1922:             .Visible   = .T.
1923:         ENDWITH
1924: 
1925:         par_oPagina.AddObject("txt_4c_Ctotal", "TextBox")
1926:         WITH par_oPagina.txt_4c_Ctotal
1927:             .Top       = 307
1928:             .Left      = 633
1929:             .Width     = 127
1930:             .Height    = 23
1931:             .ReadOnly  = .T.
1932:             .FontName  = "Tahoma"
1933:             .FontSize  = 8
1934:             .Visible   = .T.
1935:         ENDWITH
1936: 
1937:         par_oPagina.AddObject("txt_4c_Mctotal", "TextBox")
1938:         WITH par_oPagina.txt_4c_Mctotal
1939:             .Top       = 307
1940:             .Left      = 761
1941:             .Width     = 31
1942:             .Height    = 23
1943:             .MaxLength = 3
1944:             .FontName  = "Tahoma"
1945:             .FontSize  = 8
1946:             .Visible   = .T.
1947:         ENDWITH
1948:         BINDEVENT(par_oPagina.txt_4c_Mctotal, "KeyPress", THIS, "ValidarMoedaCustoTotalDados")
1949: 
1950:         par_oPagina.AddObject("lbl_4c_Label4", "Label")
1951:         WITH par_oPagina.lbl_4c_Label4
1952:             .Caption   = "Valor de Venda :"
1953:             .Top       = 335
1954:             .Left      = 510
1955:             .Width     = 120
1956:             .Height    = 15
1957:             .BackStyle = 0
1958:             .ForeColor = RGB(90, 90, 90)
1959:             .FontName  = "Tahoma"
1960:             .FontSize  = 8
1961:             .Visible   = .T.
1962:         ENDWITH
1963: 
1964:         par_oPagina.AddObject("txt_4c_Pvenda", "TextBox")
1965:         WITH par_oPagina.txt_4c_Pvenda
1966:             .Top       = 331
1967:             .Left      = 633
1968:             .Width     = 127
1969:             .Height    = 23
1970:             .ReadOnly  = .T.
1971:             .FontName  = "Tahoma"
1972:             .FontSize  = 8
1973:             .Visible   = .T.
1974:         ENDWITH
1975: 
1976:         par_oPagina.AddObject("txt_4c_Mpvenda", "TextBox")
1977:         WITH par_oPagina.txt_4c_Mpvenda
1978:             .Top       = 331
1979:             .Left      = 761
1980:             .Width     = 31
1981:             .Height    = 23
1982:             .MaxLength = 3
1983:             .FontName  = "Tahoma"
1984:             .FontSize  = 8
1985:             .Visible   = .T.
1986:         ENDWITH
1987:         BINDEVENT(par_oPagina.txt_4c_Mpvenda, "KeyPress", THIS, "ValidarMoedaValorVendaDados")
1988: 
1989:         par_oPagina.AddObject("lbl_4c_Label6", "Label")
1990:         WITH par_oPagina.lbl_4c_Label6
1991:             .Caption   = "Fator  de Venda :"
1992:             .Top       = 359
1993:             .Left      = 544
1994:             .Width     = 86
1995:             .Height    = 15
1996:             .BackStyle = 0
1997:             .ForeColor = RGB(90, 90, 90)
1998:             .FontName  = "Tahoma"
1999:             .FontSize  = 8
2000:             .Visible   = .T.
2001:         ENDWITH
2002: 
2003:         par_oPagina.AddObject("txt_4c_Fvenda", "TextBox")
2004:         WITH par_oPagina.txt_4c_Fvenda
2005:             .Top       = 355
2006:             .Left      = 633
2007:             .Width     = 127
2008:             .Height    = 23
2009:             .ReadOnly  = .T.
2010:             .FontName  = "Tahoma"
2011:             .FontSize  = 8
2012:             .Visible   = .T.
2013:         ENDWITH
2014: 
2015:         par_oPagina.AddObject("txt_4c_Mfvenda", "TextBox")
2016:         WITH par_oPagina.txt_4c_Mfvenda
2017:             .Top       = 355
2018:             .Left      = 761
2019:             .Width     = 31
2020:             .Height    = 23
2021:             .MaxLength = 3
2022:             .FontName  = "Tahoma"
2023:             .FontSize  = 8
2024:             .Visible   = .T.
2025:         ENDWITH
2026:         BINDEVENT(par_oPagina.txt_4c_Mfvenda, "KeyPress", THIS, "ValidarMoedaFatorVendaDados")
2027: 
2028:         *-- Estoque (calculado - somente leitura)
2029:         par_oPagina.AddObject("lbl_4c_Label28", "Label")
2030:         WITH par_oPagina.lbl_4c_Label28
2031:             .Caption   = "Estoque :"
2032:             .Top       = 287
2033:             .Left      = 582
2034:             .Width     = 48
2035:             .Height    = 15
2036:             .BackStyle = 0
2037:             .ForeColor = RGB(90, 90, 90)
2038:             .FontName  = "Tahoma"
2039:             .FontSize  = 8
2040:             .Visible   = .T.
2041:         ENDWITH
2042: 
2043:         par_oPagina.AddObject("txt_4c_Estoques", "TextBox")
2044:         WITH par_oPagina.txt_4c_Estoques
2045:             .Top       = 283
2046:             .Left      = 633
2047:             .Width     = 79
2048:             .Height    = 23
2049:             .ReadOnly  = .T.
2050:             .FontName  = "Tahoma"
2051:             .FontSize  = 8
2052:             .Visible   = .T.
2053:         ENDWITH
2054: 
2055:         par_oPagina.AddObject("txt_4c_QtdEsts", "TextBox")
2056:         WITH par_oPagina.txt_4c_QtdEsts
2057:             .Top       = 283
2058:             .Left      = 713
2059:             .Width     = 79
2060:             .Height    = 23
2061:             .ReadOnly  = .T.
2062:             .FontName  = "Tahoma"
2063:             .FontSize  = 8
2064:             .Visible   = .T.
2065:         ENDWITH
2066: 
2067:         *-- Origem :  (Say19 - label sem width no legado, "classe say" pura)
2068:         par_oPagina.AddObject("lbl_4c_Label19", "Label")
2069:         WITH par_oPagina.lbl_4c_Label19
2070:             .Caption   = "Origem :"
2071:             .Top       = 287
2072:             .Left      = 798
2073:             .Width     = 60
2074:             .Height    = 15
2075:             .BackStyle = 0
2076:             .ForeColor = RGB(90, 90, 90)
2077:             .FontName  = "Tahoma"
2078:             .FontSize  = 8
2079:             .Alignment = 0
2080:             .Visible   = .T.
2081:         ENDWITH
2082: 
2083:         *-- Auditoria de Inclusao / Alteracao (somente leitura)
2084:         par_oPagina.AddObject("lbl_4c_Label20", "Label")
2085:         WITH par_oPagina.lbl_4c_Label20
2086:             .Caption   = "Data / Usu" + CHR(225) + "rio"
2087:             .Top       = 535
2088:             .Left      = 827
2089:             .Width     = 84
2090:             .Height    = 15
2091:             .BackStyle = 0
2092:             .ForeColor = RGB(90, 90, 90)
2093:             .FontName  = "Tahoma"
2094:             .FontSize  = 8
2095:             .Visible   = .T.
2096:         ENDWITH
2097: 
2098:         par_oPagina.AddObject("shp_4c_Shape3", "Shape")
2099:         WITH par_oPagina.shp_4c_Shape3
2100:             .Top     = 550
2101:             .Left    = 827
2102:             .Width   = 161
2103:             .Height  = 2
2104:             .Visible = .T.
2105:         ENDWITH
2106: 
2107:         par_oPagina.AddObject("lbl_4c_Label24", "Label")
2108:         WITH par_oPagina.lbl_4c_Label24
2109:             .Caption   = "Inclus" + CHR(227) + "o"
2110:             .Top       = 554
2111:             .Left      = 827
2112:             .Width     = 42
2113:             .Height    = 15
2114:             .BackStyle = 0
2115:             .ForeColor = RGB(90, 90, 90)
2116:             .FontName  = "Tahoma"
2117:             .FontSize  = 8
2118:             .Visible   = .T.
2119:         ENDWITH
2120: 
2121:         par_oPagina.AddObject("txt_4c_DtIncs", "TextBox")
2122:         WITH par_oPagina.txt_4c_DtIncs
2123:             .Top      = 569
2124:             .Left     = 827
2125:             .Width    = 79
2126:             .Height   = 23
2127:             .ReadOnly = .T.
2128:             .FontName = "Tahoma"
2129:             .FontSize = 8
2130:             .Visible  = .T.
2131:         ENDWITH
2132: 
2133:         par_oPagina.AddObject("txt_4c_Usuario", "TextBox")
2134:         WITH par_oPagina.txt_4c_Usuario
2135:             .Top      = 594
2136:             .Left     = 827
2137:             .Width    = 79
2138:             .Height   = 23
2139:             .ReadOnly = .T.
2140:             .FontName = "Tahoma"
2141:             .FontSize = 8
2142:             .Visible  = .T.
2143:         ENDWITH
2144: 
2145:         par_oPagina.AddObject("lbl_4c_Label25", "Label")
2146:         WITH par_oPagina.lbl_4c_Label25
2147:             .Caption   = "Altera" + CHR(231) + CHR(227) + "o"
2148:             .Top       = 554
2149:             .Left      = 907
2150:             .Width     = 48
2151:             .Height    = 15
2152:             .BackStyle = 0
2153:             .ForeColor = RGB(90, 90, 90)
2154:             .FontName  = "Tahoma"
2155:             .FontSize  = 8
2156:             .Visible   = .T.
2157:         ENDWITH
2158: 
2159:         par_oPagina.AddObject("txt_4c_DataAlts", "TextBox")
2160:         WITH par_oPagina.txt_4c_DataAlts
2161:             .Top      = 569
2162:             .Left     = 907
2163:             .Width    = 79
2164:             .Height   = 23
2165:             .ReadOnly = .T.
2166:             .FontName = "Tahoma"
2167:             .FontSize = 8
2168:             .Visible  = .T.
2169:         ENDWITH
2170: 
2171:         par_oPagina.AddObject("txt_4c_UsuaAlts", "TextBox")
2172:         WITH par_oPagina.txt_4c_UsuaAlts
2173:             .Top      = 594
2174:             .Left     = 907
2175:             .Width    = 79
2176:             .Height   = 23
2177:             .ReadOnly = .T.
2178:             .FontName = "Tahoma"
2179:             .FontSize = 8
2180:             .Visible  = .T.
2181:         ENDWITH
2182: 
2183:         *-- Complemento :  (Say30 - label do bloco de memos, continua na Fase 6)
2184:         par_oPagina.AddObject("lbl_4c_Label7", "Label")
2185:         WITH par_oPagina.lbl_4c_Label7
2186:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
2187:             .Top       = 239
2188:             .Left      = 563
2189:             .Width     = 67
2190:             .Height    = 15
2191:             .BackStyle = 0
2192:             .ForeColor = RGB(90, 90, 90)
2193:             .FontName  = "Tahoma"
2194:             .FontSize  = 8
2195:             .Visible   = .T.
2196:         ENDWITH
2197: 
2198:         par_oPagina.AddObject("lbl_4c_Label30", "Label")
2199:         WITH par_oPagina.lbl_4c_Label30
2200:             .Caption   = "Complemento :"
2201:             .Top       = 263
2202:             .Left      = 556
2203:             .Width     = 74
2204:             .Height    = 15
2205:             .BackStyle = 0
2206:             .ForeColor = RGB(90, 90, 90)
2207:             .FontName  = "Tahoma"

*-- Linhas 2215 a 2313:
2215:         par_oPagina.AddObject("obj_4c_CmdgFigura", "CommandGroup")
2216:         WITH par_oPagina.obj_4c_CmdgFigura
2217:             .ButtonCount = 1
2218:             .Top         = 580
2219:             .Left        = 775
2220:             .Width       = 42
2221:             .Height      = 41
2222:             .BackStyle   = 0
2223:             .Visible     = .T.
2224:         ENDWITH
2225:         WITH par_oPagina.obj_4c_CmdgFigura.Buttons(1)
2226:             .Picture = gc_4c_CaminhoIcones + "geral_arquivo_26.jpg"
2227:             .Top     = 0
2228:             .Left    = 0
2229:             .Width   = 42
2230:             .Height  = 41
2231:         ENDWITH
2232: 
2233:         par_oPagina.AddObject("obj_4c_CmdEtiquetas", "CommandGroup")
2234:         WITH par_oPagina.obj_4c_CmdEtiquetas
2235:             .ButtonCount = 1
2236:             .Top         = 146
2237:             .Left        = 744
2238:             .Width       = 40
2239:             .Height      = 40
2240:             .BackStyle   = 0
2241:             .Visible     = .T.
2242:         ENDWITH
2243:         WITH par_oPagina.obj_4c_CmdEtiquetas.Buttons(1)
2244:             .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2245:             .Top     = 0
2246:             .Left    = 0
2247:             .Width   = 40
2248:             .Height  = 40
2249:         ENDWITH
2250: 
2251:         par_oPagina.AddObject("obj_4c_CmdZoom", "CommandGroup")
2252:         WITH par_oPagina.obj_4c_CmdZoom
2253:             .ButtonCount = 1
2254:             .Top         = 543
2255:             .Left        = 774
2256:             .Width       = 42
2257:             .Height      = 41
2258:             .BackStyle   = 0
2259:             .Visible     = .T.
2260:         ENDWITH
2261:         WITH par_oPagina.obj_4c_CmdZoom.Buttons(1)
2262:             .Picture = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
2263:             .Top     = 0
2264:             .Left    = 0
2265:             .Width   = 42
2266:             .Height  = 41
2267:         ENDWITH
2268: 
2269:         par_oPagina.AddObject("obj_4c_CmdProduto", "CommandGroup")
2270:         WITH par_oPagina.obj_4c_CmdProduto
2271:             .ButtonCount = 1
2272:             .Top         = 38
2273:             .Left        = 604
2274:             .Width       = 80
2275:             .Height      = 76
2276:             .BackStyle   = 0
2277:             .Visible     = .T.
2278:         ENDWITH
2279:         WITH par_oPagina.obj_4c_CmdProduto.Buttons(1)
2280:             .Caption = "Consulta"
2281:             .Top     = 0
2282:             .Left    = 0
2283:             .Width   = 80
2284:             .Height  = 76
2285:         ENDWITH
2286: 
2287:         *-- Cod. Pai / Conjunto (Say37 + getConjunto + cmdConjunto + cmdLocConj)
2288:         *-- getConjunto eh o SETIMO campo plProcurar do legado e entra no
2289:         *-- Do Case de msv_procurar (ver ExecutarBuscaPorExemplo).
2290:         par_oPagina.AddObject("lbl_4c_Label37", "Label")
2291:         WITH par_oPagina.lbl_4c_Label37
2292:             .Caption   = "Cod. Pai :"
2293:             .Top       = 190
2294:             .Left      = 398
2295:             .Width     = 49
2296:             .Height    = 15
2297:             .BackStyle = 0
2298:             .Alignment = 0
2299:             .ForeColor = RGB(90, 90, 90)
2300:             .FontName  = "Tahoma"
2301:             .FontSize  = 8
2302:             .Visible   = .T.
2303:         ENDWITH
2304: 
2305:         par_oPagina.AddObject("txt_4c_Conjunto", "TextBox")
2306:         WITH par_oPagina.txt_4c_Conjunto
2307:             .Top           = 186
2308:             .Left          = 449
2309:             .Width         = 52
2310:             .Height        = 22
2311:             .MaxLength     = 6
2312:             .SpecialEffect = 1
2313:             .FontName      = "Tahoma"

*-- Linhas 2320 a 2343:
2320:         par_oPagina.AddObject("obj_4c_CmdConjunto", "CommandGroup")
2321:         WITH par_oPagina.obj_4c_CmdConjunto
2322:             .ButtonCount = 1
2323:             .Top         = 186
2324:             .Left        = 502
2325:             .Width       = 27
2326:             .Height      = 24
2327:             .BackStyle   = 0
2328:             .BorderStyle = 0
2329:             .BackColor   = RGB(255, 255, 255)
2330:             .AutoSize    = .F.
2331:             .Visible     = .T.
2332:         ENDWITH
2333:         WITH par_oPagina.obj_4c_CmdConjunto.Buttons(1)
2334:             .Caption       = ""
2335:             .Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
2336:             .ToolTipText   = "Gerar Cod. Pai"
2337:             .Top           = -1
2338:             .Left          = -1
2339:             .Width         = 29
2340:             .Height        = 26
2341:             .FontName      = "Small Fonts"
2342:             .FontSize      = 7
2343:             .SpecialEffect = 0

*-- Linhas 2349 a 2372:
2349:         par_oPagina.AddObject("obj_4c_CmdLocConj", "CommandGroup")
2350:         WITH par_oPagina.obj_4c_CmdLocConj
2351:             .ButtonCount = 1
2352:             .Top         = 186
2353:             .Left        = 529
2354:             .Width       = 27
2355:             .Height      = 24
2356:             .BackStyle   = 0
2357:             .BorderStyle = 0
2358:             .BackColor   = RGB(255, 255, 255)
2359:             .AutoSize    = .F.
2360:             .Visible     = .T.
2361:         ENDWITH
2362:         WITH par_oPagina.obj_4c_CmdLocConj.Buttons(1)
2363:             .Caption       = ""
2364:             .Picture       = gc_4c_CaminhoIcones + "geral_lupa_16.jpg"
2365:             .ToolTipText   = "Localizar Cod. Pai."
2366:             .Top           = -1
2367:             .Left          = -1
2368:             .Width         = 29
2369:             .Height        = 26
2370:             .FontName      = "Small Fonts"
2371:             .FontSize      = 7
2372:             .SpecialEffect = 0

*-- Linhas 2405 a 2414:
2405:         par_oPagina.AddObject("grd_4c_Compo", "Grid")
2406:         par_oPagina.grd_4c_Compo.ColumnCount = 14
2407:         WITH par_oPagina.grd_4c_Compo
2408:             .Top                = 117
2409:             .Left               = 6
2410:             .Width              = 943
2411:             .Height             = 147
2412:             .FontName           = "Verdana"
2413:             .FontSize           = 8
2414:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 2426 a 3471:
2426:             .Visible            = .T.
2427: 
2428:             .Column1.Width  = 85
2429:             .Column1.Header1.Caption = "Material"
2430:             .Column2.Width  = 224
2431:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2432:             .Column3.Width  = 30
2433:             .Column3.Header1.Caption = "Un"
2434:             .Column4.Width  = 65
2435:             .Column4.Header1.Caption = "Valor"
2436:             .Column5.Width  = 55
2437:             .Column5.Header1.Caption = "Qtde."
2438:             .Column6.Width  = 65
2439:             .Column6.Header1.Caption = "Total"
2440:             .Column7.Width  = 32
2441:             .Column7.Header1.Caption = "Moe"
2442:             .Column8.Width  = 120
2443:             .Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
2444:             .Column9.Width  = 24
2445:             .Column9.Header1.Caption = "E"
2446:             .Column10.Width = 55
2447:             .Column10.Header1.Caption = "Consumo"
2448:             .Column11.Width = 45
2449:             .Column11.Header1.Caption = "Qtde."
2450:             .Column12.Width = 30
2451:             .Column12.Header1.Caption = "Un"
2452:             .Column13.Width = 28
2453:             .Column13.Header1.Caption = "Ord"
2454:             .Column14.Width = 85
2455:             .Column14.Header1.Caption = "Material"
2456:         ENDWITH
2457: 
2458:         *-- Coluna 9 ("E" = Etiq/Instalas): AddObject + CurrentControl
2459:         *-- obrigatorios para o checkbox aparecer (regra #18 do CLAUDE.md).
2460:         par_oPagina.grd_4c_Compo.Column9.AddObject("chk_4c_Etiqueta", "CheckBox")
2461:         WITH par_oPagina.grd_4c_Compo.Column9
2462:             .CurrentControl = "chk_4c_Etiqueta"
2463:             .Sparse         = .F.
2464:         ENDWITH
2465: 
2466:         *-- CommandGroup lateral do grdCompo (Inserir/Excluir/Atualizar/
2467:         *-- Recalcular/Pesos - 5 handlers de Click distintos no legado)
2468:         par_oPagina.AddObject("obj_4c_CmdgCompo", "CommandGroup")
2469:         WITH par_oPagina.obj_4c_CmdgCompo
2470:             .ButtonCount = 5
2471:             .Top         = 114
2472:             .Left        = 947
2473:             .Width       = 50
2474:             .Height      = 210
2475:             .BackStyle   = 0
2476:             .BorderStyle = 0
2477:             .Visible     = .T.
2478:         ENDWITH
2479:         WITH par_oPagina.obj_4c_CmdgCompo.Buttons(1)
2480:             .Caption = "Inserir"
2481:             .Top     = 1
2482:             .Left    = 1
2483:             .Width   = 46
2484:             .Height  = 40
2485:             .FontName = "Tahoma"
2486:             .FontSize = 7
2487:         ENDWITH
2488:         WITH par_oPagina.obj_4c_CmdgCompo.Buttons(2)
2489:             .Caption = "Excluir"
2490:             .Top     = 43
2491:             .Left    = 1
2492:             .Width   = 46
2493:             .Height  = 40
2494:             .FontName = "Tahoma"
2495:             .FontSize = 7
2496:         ENDWITH
2497:         WITH par_oPagina.obj_4c_CmdgCompo.Buttons(3)
2498:             .Caption = "Atualizar"
2499:             .Top     = 85
2500:             .Left    = 1
2501:             .Width   = 46
2502:             .Height  = 40
2503:             .FontName = "Tahoma"
2504:             .FontSize = 7
2505:         ENDWITH
2506:         WITH par_oPagina.obj_4c_CmdgCompo.Buttons(4)
2507:             .Caption = "Recalcular"
2508:             .Top     = 127
2509:             .Left    = 1
2510:             .Width   = 46
2511:             .Height  = 40
2512:             .FontName = "Tahoma"
2513:             .FontSize = 7
2514:         ENDWITH
2515:         WITH par_oPagina.obj_4c_CmdgCompo.Buttons(5)
2516:             .Caption = "Pesos"
2517:             .Top     = 169
2518:             .Left    = 1
2519:             .Width   = 46
2520:             .Height  = 40
2521:             .FontName = "Tahoma"
2522:             .FontSize = 7
2523:         ENDWITH
2524: 
2525:         *-- MKP Aplicado (getMarkupA)
2526:         par_oPagina.AddObject("txt_4c_MarkupA", "TextBox")
2527:         WITH par_oPagina.txt_4c_MarkupA
2528:             .Top      = 568
2529:             .Left     = 383
2530:             .Width    = 62
2531:             .Height   = 23
2532:             .FontName = "Tahoma"
2533:             .FontSize = 8
2534:             .Visible  = .T.
2535:         ENDWITH
2536: 
2537:         *-- Container "Materia Prima" (cntMtPrima - config de montagem/casas)
2538:         par_oPagina.AddObject("cnt_4c_MtPrima", "Container")
2539:         WITH par_oPagina.cnt_4c_MtPrima
2540:             .Top           = 471
2541:             .Left          = 785
2542:             .Width         = 211
2543:             .Height        = 124
2544:             .BackStyle     = 0
2545:             .BorderWidth   = 0
2546:             .SpecialEffect = 0
2547:             .Visible       = .T.
2548: 
2549:             .AddObject("lbl_4c_LblCompos", "Label")
2550:             WITH .lbl_4c_LblCompos
2551:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
2552:                 .Top       = 6
2553:                 .Left      = 6
2554:                 .Width     = 66
2555:                 .Height    = 15
2556:                 .BackStyle = 0
2557:                 .ForeColor = RGB(90, 90, 90)
2558:                 .FontName  = "Tahoma"
2559:                 .FontSize  = 8
2560:                 .Visible   = .T.
2561:             ENDWITH
2562: 
2563:             .AddObject("txt_4c_Compos", "TextBox")
2564:             WITH .txt_4c_Compos
2565:                 .Top       = 20
2566:                 .Left      = 6
2567:                 .Width     = 202
2568:                 .Height    = 23
2569:                 .MaxLength = 14
2570:                 .FontName  = "Tahoma"
2571:                 .FontSize  = 8
2572:                 .Visible   = .T.
2573:             ENDWITH
2574: 
2575:             .AddObject("lbl_4c_LblMontaDescs", "Label")
2576:             WITH .lbl_4c_LblMontaDescs
2577:                 .Caption   = "Montagem :"
2578:                 .Top       = 43
2579:                 .Left      = 6
2580:                 .Width     = 59
2581:                 .Height    = 15
2582:                 .BackStyle = 0
2583:                 .ForeColor = RGB(90, 90, 90)
2584:                 .FontName  = "Tahoma"
2585:                 .FontSize  = 8
2586:                 .Visible   = .T.
2587:             ENDWITH
2588: 
2589:             .AddObject("cbo_4c_CmbMontaDescs", "ComboBox")
2590:             WITH .cbo_4c_CmbMontaDescs
2591:                 .Top      = 57
2592:                 .Left     = 6
2593:                 .Width    = 202
2594:                 .Height   = 23
2595:                 .FontName = "Tahoma"
2596:                 .FontSize = 8
2597:                 .Visible  = .T.
2598:             ENDWITH
2599: 
2600:             .AddObject("lbl_4c_LblDigiMaxs", "Label")
2601:             WITH .lbl_4c_LblDigiMaxs
2602:                 .Caption   = "Digitos :"
2603:                 .Top       = 80
2604:                 .Left      = 6
2605:                 .Width     = 41
2606:                 .Height    = 15
2607:                 .BackStyle = 0
2608:                 .ForeColor = RGB(90, 90, 90)
2609:                 .FontName  = "Tahoma"
2610:                 .FontSize  = 8
2611:                 .Visible   = .T.
2612:             ENDWITH
2613: 
2614:             .AddObject("txt_4c_DigiMaxs", "TextBox")
2615:             WITH .txt_4c_DigiMaxs
2616:                 .Top      = 95
2617:                 .Left     = 6
2618:                 .Width    = 25
2619:                 .Height   = 23
2620:                 .FontName = "Tahoma"
2621:                 .FontSize = 8
2622:                 .Visible  = .T.
2623:             ENDWITH
2624: 
2625:             .AddObject("lbl_4c_LblOrdCompos", "Label")
2626:             WITH .lbl_4c_LblOrdCompos
2627:                 .Caption   = "Ordem :"
2628:                 .Top       = 80
2629:                 .Left      = 85
2630:                 .Width     = 41
2631:                 .Height    = 15
2632:                 .BackStyle = 0
2633:                 .ForeColor = RGB(90, 90, 90)
2634:                 .FontName  = "Tahoma"
2635:                 .FontSize  = 8
2636:                 .Visible   = .T.
2637:             ENDWITH
2638: 
2639:             .AddObject("txt_4c_OrdCompos", "TextBox")
2640:             WITH .txt_4c_OrdCompos
2641:                 .Top      = 95
2642:                 .Left     = 85
2643:                 .Width    = 25
2644:                 .Height   = 23
2645:                 .FontName = "Tahoma"
2646:                 .FontSize = 8
2647:                 .Visible  = .T.
2648:             ENDWITH
2649: 
2650:             .AddObject("lbl_4c_LblCasas", "Label")
2651:             WITH .lbl_4c_LblCasas
2652:                 .Caption   = "Casas :"
2653:                 .Top       = 80
2654:                 .Left      = 165
2655:                 .Width     = 38
2656:                 .Height    = 15
2657:                 .BackStyle = 0
2658:                 .ForeColor = RGB(90, 90, 90)
2659:                 .FontName  = "Tahoma"
2660:                 .FontSize  = 8
2661:                 .Visible   = .T.
2662:             ENDWITH
2663: 
2664:             .AddObject("txt_4c_Casas", "TextBox")
2665:             WITH .txt_4c_Casas
2666:                 .Top      = 95
2667:                 .Left     = 165
2668:                 .Width    = 25
2669:                 .Height   = 23
2670:                 .FontName = "Tahoma"
2671:                 .FontSize = 8
2672:                 .Visible  = .T.
2673:             ENDWITH
2674:         ENDWITH
2675: 
2676:         *-- Bloco "Custo" (esquerda) - Preco de Custo / Fator de Custo
2677:         par_oPagina.AddObject("lbl_4c_Label1", "Label")
2678:         WITH par_oPagina.lbl_4c_Label1
2679:             .Caption   = " Custo "
2680:             .Top       = 442
2681:             .Left      = 45
2682:             .Width     = 46
2683:             .Height    = 16
2684:             .BackStyle = 0
2685:             .ForeColor = RGB(90, 90, 90)
2686:             .FontName  = "Tahoma"
2687:             .FontSize  = 8
2688:             .Visible   = .T.
2689:         ENDWITH
2690: 
2691:         par_oPagina.AddObject("chk_4c_ChkLiberaCusto", "CheckBox")
2692:         WITH par_oPagina.chk_4c_ChkLiberaCusto
2693:             .Caption = ""
2694:             .Top     = 431
2695:             .Left    = 7
2696:             .Width   = 35
2697:             .Height  = 35
2698:             .Value   = 0
2699:             .Visible = .T.
2700:         ENDWITH
2701: 
2702:         par_oPagina.AddObject("lbl_4c_LblCompra", "Label")
2703:         WITH par_oPagina.lbl_4c_LblCompra
2704:             .Caption   = "Pre" + CHR(231) + "o de Custo (Moeda 1)"
2705:             .Top       = 474
2706:             .Left      = 7
2707:             .Width     = 127
2708:             .Height    = 15
2709:             .BackStyle = 0
2710:             .ForeColor = RGB(90, 90, 90)
2711:             .FontName  = "Tahoma"
2712:             .FontSize  = 8
2713:             .Visible   = .T.
2714:         ENDWITH
2715: 
2716:         par_oPagina.AddObject("txt_4c_Pcus", "TextBox")
2717:         WITH par_oPagina.txt_4c_Pcus
2718:             .Top      = 489
2719:             .Left     = 7
2720:             .Width    = 115
2721:             .Height   = 23
2722:             .FontName = "Tahoma"
2723:             .FontSize = 8
2724:             .Visible  = .T.
2725:         ENDWITH
2726: 
2727:         par_oPagina.AddObject("txt_4c_Moec", "TextBox")
2728:         WITH par_oPagina.txt_4c_Moec
2729:             .Top       = 489
2730:             .Left      = 125
2731:             .Width     = 31
2732:             .Height    = 23
2733:             .MaxLength = 3
2734:             .FontName  = "Tahoma"
2735:             .FontSize  = 8
2736:             .Visible   = .T.
2737:         ENDWITH
2738:         BINDEVENT(par_oPagina.txt_4c_Moec, "KeyPress", THIS, "ValidarMoedaCustoComposicao")
2739: 
2740:         par_oPagina.AddObject("lbl_4c_Label22", "Label")
2741:         WITH par_oPagina.lbl_4c_Label22
2742:             .Caption   = "MKP"
2743:             .Top       = 514
2744:             .Left      = 7
2745:             .Width     = 22
2746:             .Height    = 15
2747:             .BackStyle = 0
2748:             .ForeColor = RGB(90, 90, 90)
2749:             .FontName  = "Tahoma"
2750:             .FontSize  = 8
2751:             .Visible   = .T.
2752:         ENDWITH
2753: 
2754:         par_oPagina.AddObject("txt_4c_Cmkpc", "TextBox")
2755:         WITH par_oPagina.txt_4c_Cmkpc
2756:             .Top       = 529
2757:             .Left      = 7
2758:             .Width     = 24
2759:             .Height    = 23
2760:             .MaxLength = 2
2761:             .FontName  = "Tahoma"
2762:             .FontSize  = 8
2763:             .Visible   = .T.
2764:         ENDWITH
2765:         BINDEVENT(par_oPagina.txt_4c_Cmkpc, "KeyPress", THIS, "ValidarFeitioCustoComposicao")
2766: 
2767:         par_oPagina.AddObject("lbl_4c_LblValAdics", "Label")
2768:         WITH par_oPagina.lbl_4c_LblValAdics
2769:             .Caption   = "Valor Adicional"
2770:             .Top       = 514
2771:             .Left      = 62
2772:             .Width     = 71
2773:             .Height    = 15
2774:             .BackStyle = 0
2775:             .ForeColor = RGB(90, 90, 90)
2776:             .FontName  = "Tahoma"
2777:             .FontSize  = 8
2778:             .Visible   = .T.
2779:         ENDWITH
2780: 
2781:         par_oPagina.AddObject("txt_4c__pftioc", "TextBox")
2782:         WITH par_oPagina.txt_4c__pftioc
2783:             .Top      = 529
2784:             .Left     = 62
2785:             .Width    = 94
2786:             .Height   = 23
2787:             .FontName = "Tahoma"
2788:             .FontSize = 8
2789:             .Visible  = .T.
2790:         ENDWITH
2791: 
2792:         par_oPagina.AddObject("chk_4c_ChkPlanCus", "CheckBox")
2793:         WITH par_oPagina.chk_4c_ChkPlanCus
2794:             .Caption = ""
2795:             .Top     = 528
2796:             .Left    = 34
2797:             .Width   = 25
2798:             .Height  = 25
2799:             .Value   = 0
2800:             .Visible = .T.
2801:         ENDWITH
2802: 
2803:         par_oPagina.AddObject("lbl_4c_Label6", "Label")
2804:         WITH par_oPagina.lbl_4c_Label6
2805:             .Caption   = "Peso M" + CHR(233) + "dio"
2806:             .Top       = 553
2807:             .Left      = 8
2808:             .Width     = 56
2809:             .Height    = 15
2810:             .BackStyle = 0
2811:             .ForeColor = RGB(90, 90, 90)
2812:             .FontName  = "Tahoma"
2813:             .FontSize  = 8
2814:             .Visible   = .T.
2815:         ENDWITH
2816: 
2817:         par_oPagina.AddObject("txt_4c_Peso", "TextBox")
2818:         WITH par_oPagina.txt_4c_Peso
2819:             .Top      = 568
2820:             .Left     = 8
2821:             .Width    = 79
2822:             .Height   = 23
2823:             .FontName = "Tahoma"
2824:             .FontSize = 8
2825:             .Visible  = .T.
2826:         ENDWITH
2827: 
2828:         par_oPagina.AddObject("lbl_4c_Label10", "Label")
2829:         WITH par_oPagina.lbl_4c_Label10
2830:             .Caption   = "Var. Peso %"
2831:             .Top       = 553
2832:             .Left      = 88
2833:             .Width     = 62
2834:             .Height    = 15
2835:             .BackStyle = 0
2836:             .ForeColor = RGB(90, 90, 90)
2837:             .FontName  = "Tahoma"
2838:             .FontSize  = 8
2839:             .Visible   = .T.
2840:         ENDWITH
2841: 
2842:         par_oPagina.AddObject("txt_4c_VarPesoMs", "TextBox")
2843:         WITH par_oPagina.txt_4c_VarPesoMs
2844:             .Top      = 568
2845:             .Left     = 92
2846:             .Width    = 52
2847:             .Height   = 23
2848:             .FontName = "Tahoma"
2849:             .FontSize = 8
2850:             .Visible  = .T.
2851:         ENDWITH
2852: 
2853:         par_oPagina.AddObject("lbl_4c_LblCuVda", "Label")
2854:         WITH par_oPagina.lbl_4c_LblCuVda
2855:             .Caption   = "Fator de Custo (Moeda 2)"
2856:             .Top       = 474
2857:             .Left      = 158
2858:             .Width     = 126
2859:             .Height    = 15
2860:             .BackStyle = 0
2861:             .ForeColor = RGB(90, 90, 90)
2862:             .FontName  = "Tahoma"
2863:             .FontSize  = 8
2864:             .Visible   = .T.
2865:         ENDWITH
2866: 
2867:         par_oPagina.AddObject("txt_4c_Fcusto", "TextBox")
2868:         WITH par_oPagina.txt_4c_Fcusto
2869:             .Top      = 489
2870:             .Left     = 159
2871:             .Width    = 109
2872:             .Height   = 23
2873:             .FontName = "Tahoma"
2874:             .FontSize = 8
2875:             .Visible  = .T.
2876:         ENDWITH
2877: 
2878:         par_oPagina.AddObject("lbl_4c_Label8", "Label")
2879:         WITH par_oPagina.lbl_4c_Label8
2880:             .Caption   = "Total "
2881:             .Top       = 514
2882:             .Left      = 158
2883:             .Width     = 29
2884:             .Height    = 15
2885:             .BackStyle = 0
2886:             .ForeColor = RGB(90, 90, 90)
2887:             .FontName  = "Tahoma"
2888:             .FontSize  = 8
2889:             .Visible   = .T.
2890:         ENDWITH
2891: 
2892:         par_oPagina.AddObject("txt_4c_Custof", "TextBox")
2893:         WITH par_oPagina.txt_4c_Custof
2894:             .Top      = 529
2895:             .Left     = 159
2896:             .Width    = 109
2897:             .Height   = 23
2898:             .FontName = "Tahoma"
2899:             .FontSize = 8
2900:             .Visible  = .T.
2901:         ENDWITH
2902: 
2903:         par_oPagina.AddObject("txt_4c_Moepc", "TextBox")
2904:         WITH par_oPagina.txt_4c_Moepc
2905:             .Top       = 489
2906:             .Left      = 270
2907:             .Width     = 31
2908:             .Height    = 23
2909:             .MaxLength = 3
2910:             .FontName  = "Tahoma"
2911:             .FontSize  = 8
2912:             .Visible   = .T.
2913:         ENDWITH
2914:         BINDEVENT(par_oPagina.txt_4c_Moepc, "KeyPress", THIS, "ValidarMoedaCustoPComposicao")
2915: 
2916:         par_oPagina.AddObject("txt_4c_Moecusf", "TextBox")
2917:         WITH par_oPagina.txt_4c_Moecusf
2918:             .Top       = 529
2919:             .Left      = 270
2920:             .Width     = 31
2921:             .Height    = 23
2922:             .MaxLength = 3
2923:             .FontName  = "Tahoma"
2924:             .FontSize  = 8
2925:             .Visible   = .T.
2926:         ENDWITH
2927:         BINDEVENT(par_oPagina.txt_4c_Moecusf, "KeyPress", THIS, "ValidarMoedaCustoFComposicao")
2928: 
2929:         par_oPagina.AddObject("shp_4c_Shape6", "Shape")
2930:         WITH par_oPagina.shp_4c_Shape6
2931:             .Top     = 468
2932:             .Left    = 7
2933:             .Width   = 369
2934:             .Height  = 2
2935:             .Visible = .T.
2936:         ENDWITH
2937: 
2938:         *-- Bloco "Venda" (direita) - Preco Ideal / Preco Atual
2939:         par_oPagina.AddObject("lbl_4c_Label2", "Label")
2940:         WITH par_oPagina.lbl_4c_Label2
2941:             .Caption   = " Venda "
2942:             .Top       = 442
2943:             .Left      = 421
2944:             .Width     = 48
2945:             .Height    = 16
2946:             .BackStyle = 0
2947:             .ForeColor = RGB(90, 90, 90)
2948:             .FontName  = "Tahoma"
2949:             .FontSize  = 8
2950:             .Visible   = .T.
2951:         ENDWITH
2952: 
2953:         par_oPagina.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
2954:         WITH par_oPagina.chk_4c_ChkLiberaVenda
2955:             .Caption = ""
2956:             .Top     = 431
2957:             .Left    = 383
2958:             .Width   = 35
2959:             .Height  = 35
2960:             .Value   = 0
2961:             .Visible = .T.
2962:         ENDWITH
2963: 
2964:         par_oPagina.AddObject("txt_4c_Margem", "TextBox")
2965:         WITH par_oPagina.txt_4c_Margem
2966:             .Top      = 489
2967:             .Left     = 383
2968:             .Width    = 89
2969:             .Height   = 23
2970:             .FontName = "Tahoma"
2971:             .FontSize = 8
2972:             .Visible  = .T.
2973:         ENDWITH
2974: 
2975:         par_oPagina.AddObject("lbl_4c_LblMkpVenda", "Label")
2976:         WITH par_oPagina.lbl_4c_LblMkpVenda
2977:             .Caption   = "MKP Ideal"
2978:             .Top       = 476
2979:             .Left      = 384
2980:             .Width     = 49
2981:             .Height    = 15
2982:             .BackStyle = 0
2983:             .ForeColor = RGB(90, 90, 90)
2984:             .FontName  = "Tahoma"
2985:             .FontSize  = 8
2986:             .Visible   = .T.
2987:         ENDWITH
2988: 
2989:         par_oPagina.AddObject("lbl_4c_Label24", "Label")
2990:         WITH par_oPagina.lbl_4c_Label24
2991:             .Caption   = "Sts"
2992:             .Top       = 514
2993:             .Left      = 384
2994:             .Width     = 17
2995:             .Height    = 15
2996:             .BackStyle = 0
2997:             .ForeColor = RGB(90, 90, 90)
2998:             .FontName  = "Tahoma"
2999:             .FontSize  = 8
3000:             .Visible   = .T.
3001:         ENDWITH
3002: 
3003:         par_oPagina.AddObject("txt_4c_Status", "TextBox")
3004:         WITH par_oPagina.txt_4c_Status
3005:             .Top       = 529
3006:             .Left      = 384
3007:             .Width     = 31
3008:             .Height    = 23
3009:             .MaxLength = 3
3010:             .FontName  = "Tahoma"
3011:             .FontSize  = 8
3012:             .Visible   = .T.
3013:         ENDWITH
3014:         BINDEVENT(par_oPagina.txt_4c_Status, "KeyPress", THIS, "ValidarStatusComposicao")
3015: 
3016:         par_oPagina.AddObject("lbl_4c_LblMkpApl", "Label")
3017:         WITH par_oPagina.lbl_4c_LblMkpApl
3018:             .Caption   = "MKP Aplic."
3019:             .Top       = 553
3020:             .Left      = 384
3021:             .Width     = 51
3022:             .Height    = 15
3023:             .BackStyle = 0
3024:             .ForeColor = RGB(90, 90, 90)
3025:             .FontName  = "Tahoma"
3026:             .FontSize  = 8
3027:             .Visible   = .T.
3028:         ENDWITH
3029: 
3030:         par_oPagina.AddObject("chk_4c_ChkPlanVen", "CheckBox")
3031:         WITH par_oPagina.chk_4c_ChkPlanVen
3032:             .Caption = ""
3033:             .Top     = 528
3034:             .Left    = 447
3035:             .Width   = 25
3036:             .Height  = 25
3037:             .Value   = 0
3038:             .Visible = .T.
3039:         ENDWITH
3040: 
3041:         par_oPagina.AddObject("shp_4c_Shape4", "Shape")
3042:         WITH par_oPagina.shp_4c_Shape4
3043:             .Top     = 468
3044:             .Left    = 383
3045:             .Width   = 350
3046:             .Height  = 2
3047:             .Visible = .T.
3048:         ENDWITH
3049: 
3050:         par_oPagina.AddObject("chk_4c_Chk_Pvenda", "CheckBox")
3051:         WITH par_oPagina.chk_4c_Chk_Pvenda
3052:             .Caption = ""
3053:             .Top     = 567
3054:             .Left    = 447
3055:             .Width   = 25
3056:             .Height  = 25
3057:             .Visible = .T.
3058:         ENDWITH
3059: 
3060:         par_oPagina.AddObject("txt_4c_Pven", "TextBox")
3061:         WITH par_oPagina.txt_4c_Pven
3062:             .Top      = 568
3063:             .Left     = 476
3064:             .Width    = 105
3065:             .Height   = 23
3066:             .FontName = "Tahoma"
3067:             .FontSize = 8
3068:             .Visible  = .T.
3069:         ENDWITH
3070: 
3071:         par_oPagina.AddObject("lbl_4c_LblVenda", "Label")
3072:         WITH par_oPagina.lbl_4c_LblVenda
3073:             .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
3074:             .Top       = 553
3075:             .Left      = 476
3076:             .Width     = 115
3077:             .Height    = 15
3078:             .BackStyle = 0
3079:             .ForeColor = RGB(90, 90, 90)
3080:             .FontName  = "Tahoma"
3081:             .FontSize  = 8
3082:             .Visible   = .T.
3083:         ENDWITH
3084: 
3085:         par_oPagina.AddObject("txt_4c_Pvideal", "TextBox")
3086:         WITH par_oPagina.txt_4c_Pvideal
3087:             .Top      = 489
3088:             .Left     = 476
3089:             .Width    = 105
3090:             .Height   = 23
3091:             .FontName = "Tahoma"
3092:             .FontSize = 8
3093:             .Visible  = .T.
3094:         ENDWITH
3095: 
3096:         par_oPagina.AddObject("lbl_4c_LblIdeal", "Label")
3097:         WITH par_oPagina.lbl_4c_LblIdeal
3098:             .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
3099:             .Top       = 475
3100:             .Left      = 476
3101:             .Width     = 111
3102:             .Height    = 15
3103:             .BackStyle = 0
3104:             .ForeColor = RGB(90, 90, 90)
3105:             .FontName  = "Tahoma"
3106:             .FontSize  = 8
3107:             .Visible   = .T.
3108:         ENDWITH
3109: 
3110:         par_oPagina.AddObject("lbl_4c_Label13", "Label")
3111:         WITH par_oPagina.lbl_4c_Label13
3112:             .Caption   = "Valor Adicional"
3113:             .Top       = 514
3114:             .Left      = 476
3115:             .Width     = 71
3116:             .Height    = 15
3117:             .BackStyle = 0
3118:             .ForeColor = RGB(90, 90, 90)
3119:             .FontName  = "Tahoma"
3120:             .FontSize  = 8
3121:             .Visible   = .T.
3122:         ENDWITH
3123: 
3124:         par_oPagina.AddObject("txt_4c_Pftio", "TextBox")
3125:         WITH par_oPagina.txt_4c_Pftio
3126:             .Top      = 529
3127:             .Left     = 476
3128:             .Width    = 105
3129:             .Height   = 23
3130:             .ReadOnly = .T.
3131:             .FontName = "Tahoma"
3132:             .FontSize = 8
3133:             .Visible  = .T.
3134:         ENDWITH
3135: 
3136:         par_oPagina.AddObject("lbl_4c_Label7", "Label")
3137:         WITH par_oPagina.lbl_4c_Label7
3138:             .Caption   = "Pre" + CHR(231) + "o De"
3139:             .Top       = 555
3140:             .Left      = 272
3141:             .Width     = 45
3142:             .Height    = 15
3143:             .BackStyle = 0
3144:             .ForeColor = RGB(90, 90, 90)
3145:             .FontName  = "Tahoma"
3146:             .FontSize  = 8
3147:             .Visible   = .T.
3148:         ENDWITH
3149: 
3150:         par_oPagina.AddObject("txt_4c_PrecoDe", "TextBox")
3151:         WITH par_oPagina.txt_4c_PrecoDe
3152:             .Top      = 568
3153:             .Left     = 272
3154:             .Width    = 105
3155:             .Height   = 23
3156:             .FontName = "Tahoma"
3157:             .FontSize = 8
3158:             .Visible  = .T.
3159:         ENDWITH
3160: 
3161:         par_oPagina.AddObject("lbl_4c_Label9", "Label")
3162:         WITH par_oPagina.lbl_4c_Label9
3163:             .Caption   = "Custo MP Propria"
3164:             .Top       = 555
3165:             .Left      = 158
3166:             .Width     = 98
3167:             .Height    = 15
3168:             .BackStyle = 0
3169:             .ForeColor = RGB(90, 90, 90)
3170:             .FontName  = "Tahoma"
3171:             .FontSize  = 8
3172:             .Visible   = .T.
3173:         ENDWITH
3174: 
3175:         par_oPagina.AddObject("txt_4c_CustoCp", "TextBox")
3176:         WITH par_oPagina.txt_4c_CustoCp
3177:             .Top      = 568
3178:             .Left     = 158
3179:             .Width    = 105
3180:             .Height   = 23
3181:             .FontName = "Tahoma"
3182:             .FontSize = 8
3183:             .Visible  = .T.
3184:         ENDWITH
3185: 
3186:         par_oPagina.AddObject("lbl_4c_Label12", "Label")
3187:         WITH par_oPagina.lbl_4c_Label12
3188:             .Caption   = "Fator"
3189:             .Top       = 514
3190:             .Left      = 618
3191:             .Width     = 28
3192:             .Height    = 15
3193:             .BackStyle = 0
3194:             .ForeColor = RGB(90, 90, 90)
3195:             .FontName  = "Tahoma"
3196:             .FontSize  = 8
3197:             .Visible   = .T.
3198:         ENDWITH
3199: 
3200:         par_oPagina.AddObject("txt_4c_FIdeals", "TextBox")
3201:         WITH par_oPagina.txt_4c_FIdeals
3202:             .Top      = 489
3203:             .Left     = 618
3204:             .Width    = 105
3205:             .Height   = 23
3206:             .FontName = "Tahoma"
3207:             .FontSize = 8
3208:             .Visible  = .T.
3209:         ENDWITH
3210: 
3211:         par_oPagina.AddObject("lbl_4c_LblFIdeals", "Label")
3212:         WITH par_oPagina.lbl_4c_LblFIdeals
3213:             .Caption   = "Fator Ideal"
3214:             .Top       = 475
3215:             .Left      = 618
3216:             .Width     = 55
3217:             .Height    = 15
3218:             .BackStyle = 0
3219:             .ForeColor = RGB(90, 90, 90)
3220:             .FontName  = "Tahoma"
3221:             .FontSize  = 8
3222:             .Visible   = .T.
3223:         ENDWITH
3224: 
3225:         par_oPagina.AddObject("txt_4c_Fvenda", "TextBox")
3226:         WITH par_oPagina.txt_4c_Fvenda
3227:             .Top      = 529
3228:             .Left     = 618
3229:             .Width    = 105
3230:             .Height   = 23
3231:             .FontName = "Tahoma"
3232:             .FontSize = 8
3233:             .Visible  = .T.
3234:         ENDWITH
3235: 
3236:         par_oPagina.AddObject("txt_4c_FAtuals", "TextBox")
3237:         WITH par_oPagina.txt_4c_FAtuals
3238:             .Top      = 568
3239:             .Left     = 618
3240:             .Width    = 105
3241:             .Height   = 23
3242:             .FontName = "Tahoma"
3243:             .FontSize = 8
3244:             .Visible  = .T.
3245:         ENDWITH
3246: 
3247:         par_oPagina.AddObject("lbl_4c_LblFAtuals", "Label")
3248:         WITH par_oPagina.lbl_4c_LblFAtuals
3249:             .Caption   = "Fator Atual"
3250:             .Top       = 553
3251:             .Left      = 618
3252:             .Width     = 56
3253:             .Height    = 15
3254:             .BackStyle = 0
3255:             .ForeColor = RGB(90, 90, 90)
3256:             .FontName  = "Tahoma"
3257:             .FontSize  = 8
3258:             .Visible   = .T.
3259:         ENDWITH
3260: 
3261:         par_oPagina.AddObject("lbl_4c_Label14", "Label")
3262:         WITH par_oPagina.lbl_4c_Label14
3263:             .Caption   = "MKP"
3264:             .Top       = 514
3265:             .Left      = 420
3266:             .Width     = 22
3267:             .Height    = 15
3268:             .BackStyle = 0
3269:             .ForeColor = RGB(90, 90, 90)
3270:             .FontName  = "Tahoma"
3271:             .FontSize  = 8
3272:             .Visible   = .T.
3273:         ENDWITH
3274: 
3275:         par_oPagina.AddObject("txt_4c_Ftio", "TextBox")
3276:         WITH par_oPagina.txt_4c_Ftio
3277:             .Top       = 529
3278:             .Left      = 420
3279:             .Width     = 24
3280:             .Height    = 23
3281:             .MaxLength = 2
3282:             .FontName  = "Tahoma"
3283:             .FontSize  = 8
3284:             .Visible   = .T.
3285:         ENDWITH
3286:         BINDEVENT(par_oPagina.txt_4c_Ftio, "KeyPress", THIS, "ValidarFeitioVendaComposicao")
3287: 
3288:         par_oPagina.AddObject("txt_4c_Mftio", "TextBox")
3289:         WITH par_oPagina.txt_4c_Mftio
3290:             .Top       = 529
3291:             .Left      = 584
3292:             .Width     = 31
3293:             .Height    = 23
3294:             .ReadOnly  = .T.
3295:             .FontName  = "Tahoma"
3296:             .FontSize  = 8
3297:             .Visible   = .T.
3298:         ENDWITH
3299: 
3300:         par_oPagina.AddObject("txt_4c_Moeda", "TextBox")
3301:         WITH par_oPagina.txt_4c_Moeda
3302:             .Top       = 489
3303:             .Left      = 584
3304:             .Width     = 31
3305:             .Height    = 23
3306:             .MaxLength = 3
3307:             .FontName  = "Tahoma"
3308:             .FontSize  = 8
3309:             .Visible   = .T.
3310:         ENDWITH
3311:         BINDEVENT(par_oPagina.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoedaVendaComposicao")
3312: 
3313:         par_oPagina.AddObject("txt_4c_Moev", "TextBox")
3314:         WITH par_oPagina.txt_4c_Moev
3315:             .Top       = 568
3316:             .Left      = 584
3317:             .Width     = 31
3318:             .Height    = 23
3319:             .MaxLength = 3
3320:             .FontName  = "Tahoma"
3321:             .FontSize  = 8
3322:             .Visible   = .T.
3323:         ENDWITH
3324:         BINDEVENT(par_oPagina.txt_4c_Moev, "KeyPress", THIS, "ValidarMoedaVendaVComposicao")
3325: 
3326:         par_oPagina.AddObject("txt_4c_Moepv", "TextBox")
3327:         WITH par_oPagina.txt_4c_Moepv
3328:             .Top       = 529
3329:             .Left      = 726
3330:             .Width     = 31
3331:             .Height    = 23
3332:             .MaxLength = 3
3333:             .FontName  = "Tahoma"
3334:             .FontSize  = 8
3335:             .Visible   = .T.
3336:         ENDWITH
3337:         BINDEVENT(par_oPagina.txt_4c_Moepv, "KeyPress", THIS, "ValidarMoedaVendaPVComposicao")
3338: 
3339:         par_oPagina.AddObject("lbl_4c_Label25", "Label")
3340:         WITH par_oPagina.lbl_4c_Label25
3341:             .Caption   = "Financeiro"
3342:             .Top       = 553
3343:             .Left      = 727
3344:             .Width     = 51
3345:             .Height    = 15
3346:             .BackStyle = 0
3347:             .ForeColor = RGB(90, 90, 90)
3348:             .FontName  = "Tahoma"
3349:             .FontSize  = 8
3350:             .Visible   = .T.
3351:         ENDWITH
3352: 
3353:         par_oPagina.AddObject("txt_4c_Encarg", "TextBox")
3354:         WITH par_oPagina.txt_4c_Encarg
3355:             .Top      = 567
3356:             .Left     = 727
3357:             .Width    = 62
3358:             .Height   = 23
3359:             .FontName = "Tahoma"
3360:             .FontSize = 8
3361:             .Visible  = .T.
3362:         ENDWITH
3363: 
3364:         *-- Botao "Calcular" (cmdCalcVals legado - icone-only sem evidencia
3365:         *-- de Picture no dump; regra #25 do CLAUDE.md - usar texto em vez
3366:         *-- de inventar icone)
3367:         par_oPagina.AddObject("cmd_4c_CalcVals", "CommandButton")
3368:         WITH par_oPagina.cmd_4c_CalcVals
3369:             .Caption  = "Calc"
3370:             .Top      = 479
3371:             .Left     = 727
3372:             .Width    = 40
3373:             .Height   = 40
3374:             .FontName = "Tahoma"
3375:             .FontSize = 7
3376:             .Visible  = .T.
3377:         ENDWITH
3378: 
3379:         *-- Material Principal / Descricao (Get_MatP / Get_Desc)
3380:         par_oPagina.AddObject("lbl_4c_Label16", "Label")
3381:         WITH par_oPagina.lbl_4c_Label16
3382:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3383:             .Top       = 293
3384:             .Left      = 40
3385:             .Width     = 55
3386:             .Height    = 15
3387:             .BackStyle = 0
3388:             .ForeColor = RGB(90, 90, 90)
3389:             .FontName  = "Tahoma"
3390:             .FontSize  = 8
3391:             .Visible   = .T.
3392:         ENDWITH
3393: 
3394:         par_oPagina.AddObject("txt_4c_Desc", "TextBox")
3395:         WITH par_oPagina.txt_4c_Desc
3396:             .Top       = 290
3397:             .Left      = 99
3398:             .Width     = 298
3399:             .Height    = 21
3400:             .MaxLength = 40
3401:             .ReadOnly  = .T.
3402:             .FontName  = "Tahoma"
3403:             .FontSize  = 8
3404:             .Visible   = .T.
3405:         ENDWITH
3406: 
3407:         par_oPagina.AddObject("lbl_4c_Label15", "Label")
3408:         WITH par_oPagina.lbl_4c_Label15
3409:             .Caption   = "Material Principal :"
3410:             .Top       = 293
3411:             .Left      = 418
3412:             .Width     = 89
3413:             .Height    = 15
3414:             .BackStyle = 0
3415:             .ForeColor = RGB(90, 90, 90)
3416:             .FontName  = "Tahoma"
3417:             .FontSize  = 8
3418:             .Visible   = .T.
3419:         ENDWITH
3420: 
3421:         par_oPagina.AddObject("txt_4c_MatP", "TextBox")
3422:         WITH par_oPagina.txt_4c_MatP
3423:             .Top       = 290
3424:             .Left      = 517
3425:             .Width     = 108
3426:             .Height    = 21
3427:             .MaxLength = 14
3428:             .FontName  = "Tahoma"
3429:             .FontSize  = 8
3430:             .Visible   = .T.
3431:         ENDWITH
3432:         BINDEVENT(par_oPagina.txt_4c_MatP, "KeyPress", THIS, "ValidarMaterialPrincipalComposicao")
3433: 
3434:         *-- Observacao da OF (getObsOFs - obsofs char(120))
3435:         par_oPagina.AddObject("lbl_4c_Label4", "Label")
3436:         WITH par_oPagina.lbl_4c_Label4
3437:             .Caption   = "Obs. da OF :"
3438:             .Top       = 269
3439:             .Left      = 33
3440:             .Width     = 64
3441:             .Height    = 15
3442:             .BackStyle = 0
3443:             .ForeColor = RGB(90, 90, 90)
3444:             .FontName  = "Tahoma"
3445:             .FontSize  = 8
3446:             .Visible   = .T.
3447:         ENDWITH
3448: 
3449:         par_oPagina.AddObject("txt_4c_ObsOFs", "TextBox")
3450:         WITH par_oPagina.txt_4c_ObsOFs
3451:             .Top       = 266
3452:             .Left      = 99
3453:             .Width     = 850
3454:             .Height    = 21
3455:             .MaxLength = 120
3456:             .FontName  = "Tahoma"
3457:             .FontSize  = 8
3458:             .Visible   = .T.
3459:         ENDWITH
3460: 
3461:         *-- Resumo por grupo (GradeGRUPO legado - 3 colunas, so leitura)
3462:         par_oPagina.AddObject("grd_4c_GradeGrupo", "Grid")
3463:         par_oPagina.grd_4c_GradeGrupo.ColumnCount = 3
3464:         WITH par_oPagina.grd_4c_GradeGrupo
3465:             .Top                = 41
3466:             .Left               = 619
3467:             .Width              = 215
3468:             .Height             = 68
3469:             .FontName           = "Verdana"
3470:             .FontSize           = 8
3471:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 3483 a 3503:
3483:             .Visible            = .T.
3484: 
3485:             .Column1.Width = 60
3486:             .Column1.Header1.Caption = "Grupo"
3487:             .Column2.Width = 95
3488:             .Column2.Header1.Caption = "Total "
3489:             .Column3.Width = 60
3490:             .Column3.Header1.Caption = "Moeda"
3491:         ENDWITH
3492: 
3493:         *-- Grade de subcomponentes (grdsubcp legado, 15 colunas)
3494:         par_oPagina.AddObject("grd_4c_SubCp", "Grid")
3495:         par_oPagina.grd_4c_SubCp.ColumnCount = 15
3496:         WITH par_oPagina.grd_4c_SubCp
3497:             .Top                = 317
3498:             .Left               = 6
3499:             .Width              = 943
3500:             .Height             = 83
3501:             .FontName           = "Verdana"
3502:             .FontSize           = 8
3503:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 3515 a 3635:
3515:             .Visible            = .T.
3516: 
3517:             .Column1.Width  = 78
3518:             .Column1.Header1.Caption = "Material"
3519:             .Column2.Width  = 248
3520:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3521:             .Column3.Width  = 28
3522:             .Column3.Header1.Caption = "Un"
3523:             .Column4.Width  = 60
3524:             .Column4.Header1.Caption = "Valor"
3525:             .Column5.Width  = 50
3526:             .Column5.Header1.Caption = "Qtde."
3527:             .Column6.Width  = 60
3528:             .Column6.Header1.Caption = "Total"
3529:             .Column7.Width  = 30
3530:             .Column7.Header1.Caption = "Moe"
3531:             .Column8.Width  = 105
3532:             .Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
3533:             .Column9.Width  = 22
3534:             .Column9.Header1.Caption = "E"
3535:             .Column10.Width = 50
3536:             .Column10.Header1.Caption = "Consumo"
3537:             .Column11.Width = 40
3538:             .Column11.Header1.Caption = "Qtde."
3539:             .Column12.Width = 28
3540:             .Column12.Header1.Caption = "Un"
3541:             .Column13.Width = 26
3542:             .Column13.Header1.Caption = "Ord"
3543:             .Column14.Width = 78
3544:             .Column14.Header1.Caption = "Material"
3545:             .Column15.Width = 40
3546:             .Column15.Header1.Caption = "Tam"
3547:         ENDWITH
3548: 
3549:         par_oPagina.grd_4c_SubCp.Column9.AddObject("chk_4c_EtiquetaSubCp", "CheckBox")
3550:         WITH par_oPagina.grd_4c_SubCp.Column9
3551:             .CurrentControl = "chk_4c_EtiquetaSubCp"
3552:             .Sparse         = .F.
3553:         ENDWITH
3554: 
3555:         *-- CommandGroup lateral do grdsubcp (Inserir/Excluir)
3556:         par_oPagina.AddObject("obj_4c_CmdgSubCp", "CommandGroup")
3557:         WITH par_oPagina.obj_4c_CmdgSubCp
3558:             .ButtonCount = 2
3559:             .Top         = 314
3560:             .Left        = 947
3561:             .Width       = 50
3562:             .Height      = 90
3563:             .BackStyle   = 0
3564:             .BorderStyle = 0
3565:             .Visible     = .T.
3566:         ENDWITH
3567:         WITH par_oPagina.obj_4c_CmdgSubCp.Buttons(1)
3568:             .Caption  = "Inserir"
3569:             .Top      = 1
3570:             .Left     = 1
3571:             .Width    = 46
3572:             .Height   = 42
3573:             .FontName = "Tahoma"
3574:             .FontSize = 7
3575:         ENDWITH
3576:         WITH par_oPagina.obj_4c_CmdgSubCp.Buttons(2)
3577:             .Caption  = "Excluir"
3578:             .Top      = 45
3579:             .Left     = 1
3580:             .Width    = 46
3581:             .Height   = 42
3582:             .FontName = "Tahoma"
3583:             .FontSize = 7
3584:         ENDWITH
3585: 
3586:         par_oPagina.AddObject("lbl_4c_Label3", "Label")
3587:         WITH par_oPagina.lbl_4c_Label3
3588:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3589:             .Top       = 404
3590:             .Left      = 40
3591:             .Width     = 55
3592:             .Height    = 15
3593:             .BackStyle = 0
3594:             .ForeColor = RGB(90, 90, 90)
3595:             .FontName  = "Tahoma"
3596:             .FontSize  = 8
3597:             .Visible   = .T.
3598:         ENDWITH
3599: 
3600:         par_oPagina.AddObject("txt_4c__desccp", "TextBox")
3601:         WITH par_oPagina.txt_4c__desccp
3602:             .Top       = 401
3603:             .Left      = 99
3604:             .Width     = 298
3605:             .Height    = 21
3606:             .MaxLength = 40
3607:             .ReadOnly  = .T.
3608:             .FontName  = "Tahoma"
3609:             .FontSize  = 8
3610:             .Visible   = .T.
3611:         ENDWITH
3612: 
3613:         par_oPagina.AddObject("lbl_4c_Label5", "Label")
3614:         WITH par_oPagina.lbl_4c_Label5
3615:             .Caption   = "Substitui :"
3616:             .Top       = 404
3617:             .Left      = 466
3618:             .Width     = 50
3619:             .Height    = 15
3620:             .BackStyle = 0
3621:             .ForeColor = RGB(90, 90, 90)
3622:             .FontName  = "Tahoma"
3623:             .FontSize  = 8
3624:             .Visible   = .T.
3625:         ENDWITH
3626: 
3627:         par_oPagina.AddObject("txt_4c__matsub", "TextBox")
3628:         WITH par_oPagina.txt_4c__matsub
3629:             .Top       = 401
3630:             .Left      = 517
3631:             .Width     = 108
3632:             .Height    = 21
3633:             .MaxLength = 14
3634:             .FontName  = "Tahoma"
3635:             .FontSize  = 8

*-- Linhas 3644 a 3653:
3644:         par_oPagina.AddObject("grd_4c_Relogios", "Grid")
3645:         par_oPagina.grd_4c_Relogios.ColumnCount = 4
3646:         WITH par_oPagina.grd_4c_Relogios
3647:             .Top                = 117
3648:             .Left               = 6
3649:             .Width              = 943
3650:             .Height             = 307
3651:             .FontName           = "Verdana"
3652:             .FontSize           = 8
3653:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 3665 a 3679:
3665:             .Visible            = .F.
3666: 
3667:             .Column1.Width = 60
3668:             .Column1.Header1.Caption = "Grp"
3669:             .Column2.Width = 350
3670:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3671:             .Column3.Width = 150
3672:             .Column3.Header1.Caption = "Produto"
3673:             .Column4.Width = 383
3674:             .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3675:         ENDWITH
3676: 
3677:         THIS.TornarControlesVisiveis(par_oPagina)
3678:     ENDPROC
3679: 

*-- Linhas 3696 a 3704:
3696:     *
3697:     * Coluna 9 ("Etiq"): mesma cursor/tabela (crSigPrCpo) e mesma posicao
3698:     * relativa da coluna "E" (chk_4c_Etiqueta) ja criada em
3699:     * ConfigurarPgpgComposicao - reproduzida aqui como checkbox pela regra
3700:     * #18 (AddObject + CurrentControl + Sparse = .F.).
3701:     *
3702:     * grd_4c_Compo/grd_4c_GradeGrupo2 (DESVIO DE NOME, mapeamento.json): o
3703:     * gerador colidiu "grd_4c_Dados" nas DUAS grades desta pagina (ambas
3704:     * filhas diretas de pgCusto) - renomeado para grd_4c_Compo/GradeGrupo2,

*-- Linhas 3712 a 3721:
3712:         par_oPagina.AddObject("grd_4c_Compo", "Grid")
3713:         par_oPagina.grd_4c_Compo.ColumnCount = 12
3714:         WITH par_oPagina.grd_4c_Compo
3715:             .Top                = 178
3716:             .Left               = 34
3717:             .Width              = 813
3718:             .Height             = 230
3719:             .FontName           = "Verdana"
3720:             .FontSize           = 8
3721:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 3733 a 3918:
3733:             .Visible            = .T.
3734: 
3735:             .Column1.Width  = 45
3736:             .Column1.Header1.Caption = "Item"
3737:             .Column2.Width  = 215
3738:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3739:             .Column3.Width  = 32
3740:             .Column3.Header1.Caption = "Un"
3741:             .Column4.Width  = 68
3742:             .Column4.Header1.Caption = "Valor"
3743:             .Column5.Width  = 50
3744:             .Column5.Header1.Caption = "Qtd"
3745:             .Column6.Width  = 68
3746:             .Column6.Header1.Caption = "Total"
3747:             .Column7.Width  = 35
3748:             .Column7.Header1.Caption = "Moe"
3749:             .Column8.Width  = 145
3750:             .Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
3751:             .Column9.Width  = 40
3752:             .Column9.Header1.Caption = "Etiq"
3753:             .Column10.Width = 55
3754:             .Column10.Header1.Caption = "Consumo"
3755:             .Column11.Width = 45
3756:             .Column11.Header1.Caption = "Qtd"
3757:             .Column12.Width = 32
3758:             .Column12.Header1.Caption = "Un"
3759:         ENDWITH
3760: 
3761:         *-- Coluna 9 ("Etiq"): AddObject + CurrentControl obrigatorios para o
3762:         *-- checkbox aparecer (regra #18 do CLAUDE.md).
3763:         par_oPagina.grd_4c_Compo.Column9.AddObject("chk_4c_Etiqueta", "CheckBox")
3764:         WITH par_oPagina.grd_4c_Compo.Column9
3765:             .CurrentControl = "chk_4c_Etiqueta"
3766:             .Sparse         = .F.
3767:         ENDWITH
3768: 
3769:         *-- CommandGroup lateral do grdCompo (Inserir/Excluir - 2 handlers de
3770:         *-- Click distintos no legado)
3771:         par_oPagina.AddObject("obj_4c_CmdgCompo", "CommandGroup")
3772:         WITH par_oPagina.obj_4c_CmdgCompo
3773:             .ButtonCount = 2
3774:             .Top         = 240
3775:             .Left        = 851
3776:             .Width       = 50
3777:             .Height      = 90
3778:             .BackStyle   = 0
3779:             .BorderStyle = 0
3780:             .Visible     = .T.
3781:         ENDWITH
3782:         WITH par_oPagina.obj_4c_CmdgCompo.Buttons(1)
3783:             .Caption  = "Inserir"
3784:             .Top      = 1
3785:             .Left     = 1
3786:             .Width    = 46
3787:             .Height   = 42
3788:             .FontName = "Tahoma"
3789:             .FontSize = 7
3790:         ENDWITH
3791:         WITH par_oPagina.obj_4c_CmdgCompo.Buttons(2)
3792:             .Caption  = "Excluir"
3793:             .Top      = 45
3794:             .Left     = 1
3795:             .Width    = 46
3796:             .Height   = 42
3797:             .FontName = "Tahoma"
3798:             .FontSize = 7
3799:         ENDWITH
3800: 
3801:         *-- Tipo (cmbTipos legado - RowSource de tipos de composicao)
3802:         par_oPagina.AddObject("lbl_4c_Label1", "Label")
3803:         WITH par_oPagina.lbl_4c_Label1
3804:             .Caption   = "Tipo :"
3805:             .Top       = 159
3806:             .Left      = 107
3807:             .Width     = 29
3808:             .Height    = 15
3809:             .BackStyle = 0
3810:             .ForeColor = RGB(90, 90, 90)
3811:             .FontName  = "Tahoma"
3812:             .FontSize  = 8
3813:             .Visible   = .T.
3814:         ENDWITH
3815: 
3816:         par_oPagina.AddObject("cbo_4c_CmbTipos", "ComboBox")
3817:         WITH par_oPagina.cbo_4c_CmbTipos
3818:             .Top      = 154
3819:             .Left     = 143
3820:             .Width    = 187
3821:             .Height   = 23
3822:             .FontName = "Tahoma"
3823:             .FontSize = 8
3824:             .Visible  = .T.
3825:         ENDWITH
3826: 
3827:         *-- Descricao do produto (Get_Desc legado - so leitura, espelha
3828:         *-- crSigCdPro.Dpros, MaxLength 40 = SigCdPro.dpros no schema)
3829:         par_oPagina.AddObject("lbl_4c_Label16", "Label")
3830:         WITH par_oPagina.lbl_4c_Label16
3831:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3832:             .Top       = 415
3833:             .Left      = 53
3834:             .Width     = 55
3835:             .Height    = 15
3836:             .BackStyle = 0
3837:             .ForeColor = RGB(90, 90, 90)
3838:             .FontName  = "Tahoma"
3839:             .FontSize  = 8
3840:             .Visible   = .T.
3841:         ENDWITH
3842: 
3843:         par_oPagina.AddObject("txt_4c_Desc", "TextBox")
3844:         WITH par_oPagina.txt_4c_Desc
3845:             .Top       = 412
3846:             .Left      = 116
3847:             .Width     = 304
3848:             .Height    = 21
3849:             .MaxLength = 40
3850:             .ReadOnly  = .T.
3851:             .FontName  = "Tahoma"
3852:             .FontSize  = 8
3853:             .Visible   = .T.
3854:         ENDWITH
3855: 
3856:         *-- Grupo do componente selecionado (getDGruCompos legado - so
3857:         *-- leitura, espelha SigCdGrp.dgrus, MaxLength 30 conforme schema)
3858:         par_oPagina.AddObject("lbl_4c_Label2", "Label")
3859:         WITH par_oPagina.lbl_4c_Label2
3860:             .Caption   = "Grupo :"
3861:             .Top       = 415
3862:             .Left      = 480
3863:             .Width     = 38
3864:             .Height    = 15
3865:             .BackStyle = 0
3866:             .ForeColor = RGB(90, 90, 90)
3867:             .FontName  = "Tahoma"
3868:             .FontSize  = 8
3869:             .Visible   = .T.
3870:         ENDWITH
3871: 
3872:         par_oPagina.AddObject("txt_4c_DGruCompos", "TextBox")
3873:         WITH par_oPagina.txt_4c_DGruCompos
3874:             .Top       = 412
3875:             .Left      = 522
3876:             .Width     = 304
3877:             .Height    = 21
3878:             .MaxLength = 30
3879:             .ReadOnly  = .T.
3880:             .FontName  = "Tahoma"
3881:             .FontSize  = 8
3882:             .Visible   = .T.
3883:         ENDWITH
3884: 
3885:         *-- Resumo por grupo (GradeGRUPO2 legado - 3 colunas, so leitura)
3886:         par_oPagina.AddObject("lbl_4c_Label3", "Label")
3887:         WITH par_oPagina.lbl_4c_Label3
3888:             .Caption   = "Resumo por Grupo"
3889:             .Top       = 445
3890:             .Left      = 35
3891:             .Width     = 107
3892:             .Height    = 15
3893:             .BackStyle = 0
3894:             .ForeColor = RGB(90, 90, 90)
3895:             .FontName  = "Tahoma"
3896:             .FontSize  = 8
3897:             .Visible   = .T.
3898:         ENDWITH
3899: 
3900:         par_oPagina.AddObject("shp_4c_Shape2", "Shape")
3901:         WITH par_oPagina.shp_4c_Shape2
3902:             .Top     = 460
3903:             .Left    = 35
3904:             .Width   = 158
3905:             .Height  = 2
3906:             .Visible = .T.
3907:         ENDWITH
3908: 
3909:         par_oPagina.AddObject("grd_4c_GradeGrupo2", "Grid")
3910:         par_oPagina.grd_4c_GradeGrupo2.ColumnCount = 3
3911:         WITH par_oPagina.grd_4c_GradeGrupo2
3912:             .Top                = 468
3913:             .Left               = 35
3914:             .Width              = 195
3915:             .Height             = 141
3916:             .FontName           = "Verdana"
3917:             .FontSize           = 8
3918:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 3930 a 3942:
3930:             .Visible            = .T.
3931: 
3932:             .Column1.Width = 55
3933:             .Column1.Header1.Caption = "Grp"
3934:             .Column2.Width = 100
3935:             .Column2.Header1.Caption = "Total "
3936:             .Column3.Width = 38
3937:             .Column3.Header1.Caption = "Moe"
3938:         ENDWITH
3939: 
3940:         THIS.TornarControlesVisiveis(par_oPagina)
3941:     ENDPROC
3942: 

*-- Linhas 3966 a 4619:
3966:         *-- Imagem do processo/fase (shpFig / ImgFigJpg - espelha crSigCdPrf.FigProcs)
3967:         par_oPagina.AddObject("shp_4c_ShpFig", "Shape")
3968:         WITH par_oPagina.shp_4c_ShpFig
3969:             .Top     = 129
3970:             .Left    = 231
3971:             .Width   = 244
3972:             .Height  = 148
3973:             .Visible = .T.
3974:         ENDWITH
3975: 
3976:         par_oPagina.AddObject("img_4c_ImgFigJpg", "Image")
3977:         WITH par_oPagina.img_4c_ImgFigJpg
3978:             .Top     = 130
3979:             .Left    = 232
3980:             .Width   = 241
3981:             .Height  = 146
3982:             .Stretch = 2
3983:             .Visible = .T.
3984:         ENDWITH
3985: 
3986:         *-- Botoes de captura de imagem (arquivo / webcam) - estruturais nesta
3987:         *-- fase (Picture + posicao); Click entra quando o subsistema de
3988:         *-- imagem for migrado (mesmo padrao de ConfigurarAbaDadosPrincipais).
3989:         par_oPagina.AddObject("obj_4c_CmdgFigura", "CommandGroup")
3990:         WITH par_oPagina.obj_4c_CmdgFigura
3991:             .ButtonCount = 1
3992:             .Top         = 169
3993:             .Left        = 482
3994:             .Width       = 40
3995:             .Height      = 40
3996:             .BackStyle   = 0
3997:             .Visible     = .T.
3998:         ENDWITH
3999:         WITH par_oPagina.obj_4c_CmdgFigura.Buttons(1)
4000:             .Picture     = gc_4c_CaminhoIcones + "geral_picture_26.jpg"
4001:             .ToolTipText = "Capturar Imagem do Produto"
4002:             .Top         = 0
4003:             .Left        = 0
4004:             .Width       = 40
4005:             .Height      = 40
4006:         ENDWITH
4007: 
4008:         par_oPagina.AddObject("obj_4c_CmdgFigCam", "CommandGroup")
4009:         WITH par_oPagina.obj_4c_CmdgFigCam
4010:             .ButtonCount = 1
4011:             .Top         = 209
4012:             .Left        = 482
4013:             .Width       = 40
4014:             .Height      = 40
4015:             .BackStyle   = 0
4016:             .Visible     = .T.
4017:         ENDWITH
4018:         WITH par_oPagina.obj_4c_CmdgFigCam.Buttons(1)
4019:             .Picture     = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
4020:             .ToolTipText = "Capturar Imagem do Produto - WebCam"
4021:             .Top         = 0
4022:             .Left        = 0
4023:             .Width       = 40
4024:             .Height      = 40
4025:         ENDWITH
4026: 
4027:         *-- Ficha Tecnica (CmdFicha legado) - standalone, Click (relatorio)
4028:         *-- entra quando o subsistema de impressao de ficha for migrado.
4029:         par_oPagina.AddObject("cmd_4c_CmdFicha", "CommandButton")
4030:         WITH par_oPagina.cmd_4c_CmdFicha
4031:             .Top             = 129
4032:             .Left            = 482
4033:             .Width           = 40
4034:             .Height          = 40
4035:             .Caption         = ""
4036:             .Picture         = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
4037:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
4038:             .ToolTipText     = "Ficha " + CHR(84) + CHR(233) + "cnica"
4039:             .Themes          = .T.
4040:             .Enabled         = .T.
4041:             .Visible         = .T.
4042:         ENDWITH
4043: 
4044:         *-- Qtd. Minima de Producao (getQmin legado)
4045:         par_oPagina.AddObject("lbl_4c_Label13", "Label")
4046:         WITH par_oPagina.lbl_4c_Label13
4047:             .Caption   = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
4048:             .Top       = 133
4049:             .Left      = 32
4050:             .Width     = 102
4051:             .Height    = 15
4052:             .BackStyle = 0
4053:             .ForeColor = RGB(90, 90, 90)
4054:             .FontName  = "Tahoma"
4055:             .FontSize  = 8
4056:             .Visible   = .T.
4057:         ENDWITH
4058: 
4059:         par_oPagina.AddObject("txt_4c_Qmin", "TextBox")
4060:         WITH par_oPagina.txt_4c_Qmin
4061:             .Top       = 129
4062:             .Left      = 137
4063:             .Width     = 80
4064:             .Height    = 23
4065:             .MaxLength = 10
4066:             .InputMask = "999,999.99"
4067:             .FontName  = "Tahoma"
4068:             .FontSize  = 8
4069:             .Visible   = .T.
4070:         ENDWITH
4071: 
4072:         *-- Garra (getCodGarras legado - char sem lookup no legado)
4073:         par_oPagina.AddObject("lbl_4c_Label5", "Label")
4074:         WITH par_oPagina.lbl_4c_Label5
4075:             .Caption   = "Garra :"
4076:             .Top       = 158
4077:             .Left      = 98
4078:             .Width     = 36
4079:             .Height    = 15
4080:             .BackStyle = 0
4081:             .ForeColor = RGB(90, 90, 90)
4082:             .FontName  = "Tahoma"
4083:             .FontSize  = 8
4084:             .Visible   = .T.
4085:         ENDWITH
4086: 
4087:         par_oPagina.AddObject("txt_4c_CodGarras", "TextBox")
4088:         WITH par_oPagina.txt_4c_CodGarras
4089:             .Top       = 154
4090:             .Left      = 137
4091:             .Width     = 80
4092:             .Height    = 23
4093:             .MaxLength = 10
4094:             .FontName  = "Tahoma"
4095:             .FontSize  = 8
4096:             .Visible   = .T.
4097:         ENDWITH
4098: 
4099:         *-- Conquilha (getConquilha legado - lookup SigCdCnq)
4100:         par_oPagina.AddObject("lbl_4c_Label4", "Label")
4101:         WITH par_oPagina.lbl_4c_Label4
4102:             .Caption   = "Conquilha :"
4103:             .Top       = 183
4104:             .Left      = 78
4105:             .Width     = 59
4106:             .Height    = 15
4107:             .BackStyle = 0
4108:             .ForeColor = RGB(90, 90, 90)
4109:             .FontName  = "Tahoma"
4110:             .FontSize  = 8
4111:             .Visible   = .T.
4112:         ENDWITH
4113: 
4114:         par_oPagina.AddObject("txt_4c_Conquilha", "TextBox")
4115:         WITH par_oPagina.txt_4c_Conquilha
4116:             .Top       = 179
4117:             .Left      = 137
4118:             .Width     = 80
4119:             .Height    = 23
4120:             .MaxLength = 10
4121:             .Alignment = 3
4122:             .FontName  = "Tahoma"
4123:             .FontSize  = 8
4124:             .Visible   = .T.
4125:         ENDWITH
4126:         BINDEVENT(par_oPagina.txt_4c_Conquilha, "KeyPress", THIS, "ValidarConquilhaDados")
4127: 
4128:         *-- Peso Brilhante / Peso Metal / Peso Pedra (getPesoBris/getPesoMetal/getPesoPdrs)
4129:         par_oPagina.AddObject("lbl_4c_Label9", "Label")
4130:         WITH par_oPagina.lbl_4c_Label9
4131:             .Caption   = "Peso Brilhante :"
4132:             .Top       = 208
4133:             .Left      = 57
4134:             .Width     = 77
4135:             .Height    = 15
4136:             .BackStyle = 0
4137:             .ForeColor = RGB(90, 90, 90)
4138:             .FontName  = "Tahoma"
4139:             .FontSize  = 8
4140:             .Visible   = .T.
4141:         ENDWITH
4142: 
4143:         par_oPagina.AddObject("txt_4c_PesoBris", "TextBox")
4144:         WITH par_oPagina.txt_4c_PesoBris
4145:             .Top       = 204
4146:             .Left      = 137
4147:             .Width     = 80
4148:             .Height    = 23
4149:             .MaxLength = 10
4150:             .InputMask = "99,999.999"
4151:             .FontName  = "Tahoma"
4152:             .FontSize  = 8
4153:             .Visible   = .T.
4154:         ENDWITH
4155: 
4156:         par_oPagina.AddObject("lbl_4c_Label10", "Label")
4157:         WITH par_oPagina.lbl_4c_Label10
4158:             .Caption   = "Peso Metal :"
4159:             .Top       = 233
4160:             .Left      = 73
4161:             .Width     = 61
4162:             .Height    = 15
4163:             .BackStyle = 0
4164:             .ForeColor = RGB(90, 90, 90)
4165:             .FontName  = "Tahoma"
4166:             .FontSize  = 8
4167:             .Visible   = .T.
4168:         ENDWITH
4169: 
4170:         par_oPagina.AddObject("txt_4c_PesoMetal", "TextBox")
4171:         WITH par_oPagina.txt_4c_PesoMetal
4172:             .Top       = 229
4173:             .Left      = 137
4174:             .Width     = 80
4175:             .Height    = 23
4176:             .MaxLength = 10
4177:             .InputMask = "99,999.999"
4178:             .FontName  = "Tahoma"
4179:             .FontSize  = 8
4180:             .Visible   = .T.
4181:         ENDWITH
4182: 
4183:         par_oPagina.AddObject("lbl_4c_Label8", "Label")
4184:         WITH par_oPagina.lbl_4c_Label8
4185:             .Caption   = "Peso Pedra :"
4186:             .Top       = 258
4187:             .Left      = 71
4188:             .Width     = 63
4189:             .Height    = 15
4190:             .BackStyle = 0
4191:             .ForeColor = RGB(90, 90, 90)
4192:             .FontName  = "Tahoma"
4193:             .FontSize  = 8
4194:             .Visible   = .T.
4195:         ENDWITH
4196: 
4197:         par_oPagina.AddObject("txt_4c_PesoPdrs", "TextBox")
4198:         WITH par_oPagina.txt_4c_PesoPdrs
4199:             .Top       = 254
4200:             .Left      = 137
4201:             .Width     = 80
4202:             .Height    = 23
4203:             .MaxLength = 10
4204:             .InputMask = "99,999.999"
4205:             .FontName  = "Tahoma"
4206:             .FontSize  = 8
4207:             .Visible   = .T.
4208:         ENDWITH
4209: 
4210:         *-- Cor Padrao / Tamanho Padrao (getCor/getTam - lookup SigCdCor/SigCdTam)
4211:         par_oPagina.AddObject("lbl_4c_Label7", "Label")
4212:         WITH par_oPagina.lbl_4c_Label7
4213:             .Caption   = "Cor Padr" + CHR(227) + "o :"
4214:             .Top       = 283
4215:             .Left      = 71
4216:             .Width     = 63
4217:             .Height    = 15
4218:             .BackStyle = 0
4219:             .ForeColor = RGB(90, 90, 90)
4220:             .FontName  = "Tahoma"
4221:             .FontSize  = 8
4222:             .Visible   = .T.
4223:         ENDWITH
4224: 
4225:         par_oPagina.AddObject("txt_4c_Cor", "TextBox")
4226:         WITH par_oPagina.txt_4c_Cor
4227:             .Top       = 279
4228:             .Left      = 137
4229:             .Width     = 38
4230:             .Height    = 23
4231:             .MaxLength = 4
4232:             .FontName  = "Tahoma"
4233:             .FontSize  = 8
4234:             .Visible   = .T.
4235:         ENDWITH
4236:         BINDEVENT(par_oPagina.txt_4c_Cor, "KeyPress", THIS, "ValidarCorPadraoDados")
4237: 
4238:         *-- Peso Variavel (fwoption1 legado - checkbox, ControlSource Varias)
4239:         par_oPagina.AddObject("chk_4c_Fwoption1", "CheckBox")
4240:         WITH par_oPagina.chk_4c_Fwoption1
4241:             .Caption   = "Peso Vari" + CHR(225) + "vel"
4242:             .Top       = 308
4243:             .Left      = 180
4244:             .Width     = 90
4245:             .Height    = 15
4246:             .Value     = 0
4247:             .Alignment = 0
4248:             .BackStyle = 0
4249:             .ForeColor = RGB(90, 90, 90)
4250:             .FontName  = "Tahoma"
4251:             .FontSize  = 8
4252:             .Visible   = .T.
4253:         ENDWITH
4254: 
4255:         par_oPagina.AddObject("lbl_4c_Label2", "Label")
4256:         WITH par_oPagina.lbl_4c_Label2
4257:             .Caption   = "Tamanho Padr" + CHR(227) + "o :"
4258:             .Top       = 308
4259:             .Left      = 44
4260:             .Width     = 90
4261:             .Height    = 15
4262:             .BackStyle = 0
4263:             .ForeColor = RGB(90, 90, 90)
4264:             .FontName  = "Tahoma"
4265:             .FontSize  = 8
4266:             .Visible   = .T.
4267:         ENDWITH
4268: 
4269:         par_oPagina.AddObject("txt_4c_Tam", "TextBox")
4270:         WITH par_oPagina.txt_4c_Tam
4271:             .Top       = 304
4272:             .Left      = 137
4273:             .Width     = 38
4274:             .Height    = 23
4275:             .MaxLength = 4
4276:             .FontName  = "Tahoma"
4277:             .FontSize  = 8
4278:             .Visible   = .T.
4279:         ENDWITH
4280:         BINDEVENT(par_oPagina.txt_4c_Tam, "KeyPress", THIS, "ValidarTamanhoPadraoDados")
4281: 
4282:         *-- Acabamento (get_codacb/get_Dacb - lookup SigCdAca)
4283:         par_oPagina.AddObject("lbl_4c_LblAcabamento", "Label")
4284:         WITH par_oPagina.lbl_4c_LblAcabamento
4285:             .Caption   = "Acabamento :"
4286:             .Top       = 333
4287:             .Left      = 15
4288:             .Width     = 119
4289:             .Height    = 15
4290:             .Alignment = 1
4291:             .BackStyle = 0
4292:             .ForeColor = RGB(90, 90, 90)
4293:             .FontName  = "Tahoma"
4294:             .FontSize  = 8
4295:             .Visible   = .T.
4296:         ENDWITH
4297: 
4298:         par_oPagina.AddObject("txt_4c_CodAcb", "TextBox")
4299:         WITH par_oPagina.txt_4c_CodAcb
4300:             .Top       = 329
4301:             .Left      = 137
4302:             .Width     = 38
4303:             .Height    = 23
4304:             .MaxLength = 3
4305:             .FontName  = "Tahoma"
4306:             .FontSize  = 8
4307:             .Visible   = .T.
4308:         ENDWITH
4309:         BINDEVENT(par_oPagina.txt_4c_CodAcb, "KeyPress", THIS, "ValidarAcabamentoDadosPorCodigo")
4310: 
4311:         par_oPagina.AddObject("txt_4c_DescAcb", "TextBox")
4312:         WITH par_oPagina.txt_4c_DescAcb
4313:             .Top       = 329
4314:             .Left      = 177
4315:             .Width     = 207
4316:             .Height    = 23
4317:             .FontName  = "Tahoma"
4318:             .FontSize  = 8
4319:             .Visible   = .T.
4320:         ENDWITH
4321:         BINDEVENT(par_oPagina.txt_4c_DescAcb, "KeyPress", THIS, "ValidarAcabamentoDadosPorDescricao")
4322: 
4323:         *-- Cravacao em Cera (opc_CravCera legado - checkbox, ControlSource CravCers)
4324:         par_oPagina.AddObject("chk_4c_OpcCravCera", "CheckBox")
4325:         WITH par_oPagina.chk_4c_OpcCravCera
4326:             .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera"
4327:             .Top       = 283
4328:             .Left      = 180
4329:             .Width     = 100
4330:             .Height    = 15
4331:             .Value     = 0
4332:             .Alignment = 0
4333:             .BackStyle = 0
4334:             .ForeColor = RGB(90, 90, 90)
4335:             .FontName  = "Tahoma"
4336:             .FontSize  = 8
4337:             .Visible   = .T.
4338:         ENDWITH
4339: 
4340:         *-- Garantia + Dias (Say46/Say47/getDiasGar)
4341:         par_oPagina.AddObject("lbl_4c_Label46", "Label")
4342:         WITH par_oPagina.lbl_4c_Label46
4343:             .Caption   = "Garantia :"
4344:             .Top       = 384
4345:             .Left      = 84
4346:             .Width     = 50
4347:             .Height    = 15
4348:             .BackStyle = 0
4349:             .ForeColor = RGB(90, 90, 90)
4350:             .FontName  = "Tahoma"
4351:             .FontSize  = 8
4352:             .Visible   = .T.
4353:         ENDWITH
4354: 
4355:         par_oPagina.AddObject("txt_4c_DiasGar", "TextBox")
4356:         WITH par_oPagina.txt_4c_DiasGar
4357:             .Top       = 380
4358:             .Left      = 137
4359:             .Width     = 31
4360:             .Height    = 23
4361:             .MaxLength = 3
4362:             .InputMask = "999"
4363:             .FontName  = "Tahoma"
4364:             .FontSize  = 8
4365:             .Visible   = .T.
4366:         ENDWITH
4367: 
4368:         par_oPagina.AddObject("lbl_4c_Label47", "Label")
4369:         WITH par_oPagina.lbl_4c_Label47
4370:             .Caption   = "Dias"
4371:             .Top       = 384
4372:             .Left      = 170
4373:             .Width     = 22
4374:             .Height    = 15
4375:             .BackStyle = 0
4376:             .ForeColor = RGB(90, 90, 90)
4377:             .FontName  = "Tahoma"
4378:             .FontSize  = 8
4379:             .Visible   = .T.
4380:         ENDWITH
4381: 
4382:         *-- Entrega + Dias (Label9/Label10/getTEnts)
4383:         par_oPagina.AddObject("lbl_4c_LblEntrega", "Label")
4384:         WITH par_oPagina.lbl_4c_LblEntrega
4385:             .Caption   = "Entrega :"
4386:             .Top       = 359
4387:             .Left      = 87
4388:             .Width     = 47
4389:             .Height    = 15
4390:             .BackStyle = 0
4391:             .ForeColor = RGB(90, 90, 90)
4392:             .FontName  = "Tahoma"
4393:             .FontSize  = 8
4394:             .Visible   = .T.
4395:         ENDWITH
4396: 
4397:         par_oPagina.AddObject("txt_4c_TEnts", "TextBox")
4398:         WITH par_oPagina.txt_4c_TEnts
4399:             .Top       = 355
4400:             .Left      = 137
4401:             .Width     = 31
4402:             .Height    = 23
4403:             .MaxLength = 10
4404:             .InputMask = "999"
4405:             .FontName  = "Tahoma"
4406:             .FontSize  = 8
4407:             .Visible   = .T.
4408:         ENDWITH
4409: 
4410:         par_oPagina.AddObject("lbl_4c_Label10b", "Label")
4411:         WITH par_oPagina.lbl_4c_Label10b
4412:             .Caption   = "Dias"
4413:             .Top       = 359
4414:             .Left      = 170
4415:             .Width     = 22
4416:             .Height    = 15
4417:             .BackStyle = 0
4418:             .ForeColor = RGB(90, 90, 90)
4419:             .FontName  = "Tahoma"
4420:             .FontSize  = 8
4421:             .Visible   = .T.
4422:         ENDWITH
4423: 
4424:         *-- Volumes (Say26/fwget3)
4425:         par_oPagina.AddObject("lbl_4c_Label26", "Label")
4426:         WITH par_oPagina.lbl_4c_Label26
4427:             .Caption   = "Volumes :"
4428:             .Top       = 409
4429:             .Left      = 86
4430:             .Width     = 48
4431:             .Height    = 15
4432:             .BackStyle = 0
4433:             .ForeColor = RGB(90, 90, 90)
4434:             .FontName  = "Tahoma"
4435:             .FontSize  = 8
4436:             .Visible   = .T.
4437:         ENDWITH
4438: 
4439:         par_oPagina.AddObject("txt_4c_Volumes", "TextBox")
4440:         WITH par_oPagina.txt_4c_Volumes
4441:             .Top       = 405
4442:             .Left      = 137
4443:             .Width     = 31
4444:             .Height    = 23
4445:             .MaxLength = 3
4446:             .FontName  = "Tahoma"
4447:             .FontSize  = 8
4448:             .Visible   = .T.
4449:         ENDWITH
4450: 
4451:         *-- Lote Minimo (Say21/getLtMinsV)
4452:         par_oPagina.AddObject("lbl_4c_Label21", "Label")
4453:         WITH par_oPagina.lbl_4c_Label21
4454:             .Caption   = "Lote M" + CHR(237) + "nimo :"
4455:             .Top       = 434
4456:             .Left      = 69
4457:             .Width     = 65
4458:             .Height    = 15
4459:             .BackStyle = 0
4460:             .ForeColor = RGB(90, 90, 90)
4461:             .FontName  = "Tahoma"
4462:             .FontSize  = 8
4463:             .Visible   = .T.
4464:         ENDWITH
4465: 
4466:         par_oPagina.AddObject("txt_4c_LtMinsV", "TextBox")
4467:         WITH par_oPagina.txt_4c_LtMinsV
4468:             .Top       = 430
4469:             .Left      = 137
4470:             .Width     = 80
4471:             .Height    = 23
4472:             .MaxLength = 10
4473:             .InputMask = "999,999.99"
4474:             .FontName  = "Tahoma"
4475:             .FontSize  = 8
4476:             .Visible   = .T.
4477:         ENDWITH
4478: 
4479:         *-- Ult. Compra (get_Dtucp/Get_vucp/Get_mucp - somente leitura, auto-
4480:         *-- calculado pelo subsistema de compras)
4481:         par_oPagina.AddObject("lbl_4c_Label19", "Label")
4482:         WITH par_oPagina.lbl_4c_Label19
4483:             .Caption   = CHR(218) + "lt.Compra :"
4484:             .Top       = 459
4485:             .Left      = 71
4486:             .Width     = 63
4487:             .Height    = 15
4488:             .BackStyle = 0
4489:             .ForeColor = RGB(90, 90, 90)
4490:             .FontName  = "Tahoma"
4491:             .FontSize  = 8
4492:             .Visible   = .T.
4493:         ENDWITH
4494: 
4495:         par_oPagina.AddObject("txt_4c_DtUcp", "TextBox")
4496:         WITH par_oPagina.txt_4c_DtUcp
4497:             .Top       = 455
4498:             .Left      = 137
4499:             .Width     = 79
4500:             .Height    = 23
4501:             .ReadOnly  = .T.
4502:             .FontName  = "Tahoma"
4503:             .FontSize  = 8
4504:             .Visible   = .T.
4505:         ENDWITH
4506: 
4507:         par_oPagina.AddObject("txt_4c_Vucp", "TextBox")
4508:         WITH par_oPagina.txt_4c_Vucp
4509:             .Top       = 455
4510:             .Left      = 217
4511:             .Width     = 97
4512:             .Height    = 23
4513:             .InputMask = "99,999.99999"
4514:             .ReadOnly  = .T.
4515:             .FontName  = "Tahoma"
4516:             .FontSize  = 8
4517:             .Visible   = .T.
4518:         ENDWITH
4519: 
4520:         par_oPagina.AddObject("txt_4c_Mucp", "TextBox")
4521:         WITH par_oPagina.txt_4c_Mucp
4522:             .Top       = 455
4523:             .Left      = 315
4524:             .Width     = 31
4525:             .Height    = 23
4526:             .MaxLength = 3
4527:             .ReadOnly  = .T.
4528:             .FontName  = "Tahoma"
4529:             .FontSize  = 8
4530:             .Visible   = .T.
4531:         ENDWITH
4532: 
4533:         *-- Variacao (Say36/Fwoption2 - OptionGroup Sim/Nao, ControlSource prodvars)
4534:         par_oPagina.AddObject("lbl_4c_Label36", "Label")
4535:         WITH par_oPagina.lbl_4c_Label36
4536:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o :"
4537:             .Top       = 481
4538:             .Left      = 84
4539:             .Width     = 50
4540:             .Height    = 15
4541:             .BackStyle = 0
4542:             .ForeColor = RGB(90, 90, 90)
4543:             .FontName  = "Tahoma"
4544:             .FontSize  = 8
4545:             .Visible   = .T.
4546:         ENDWITH
4547: 
4548:         par_oPagina.AddObject("obj_4c_Fwoption2", "OptionGroup")
4549:         WITH par_oPagina.obj_4c_Fwoption2
4550:             .ButtonCount = 2
4551:             .Top         = 482
4552:             .Left        = 132
4553:             .Width       = 93
4554:             .Height      = 15
4555:             .BackStyle   = 0
4556:             .Value       = 1
4557:             .ToolTipText = "Setar se exporta varia" + CHR(231) + CHR(227) + "o para e-commerce"
4558:             .Visible     = .T.
4559:         ENDWITH
4560:         WITH par_oPagina.obj_4c_Fwoption2.Buttons(1)
4561:             .Caption   = "Sim"
4562:             .BackStyle = 0
4563:             .Top       = 0
4564:             .Left      = 5
4565:             .Height    = 15
4566:             .ForeColor = RGB(90, 90, 90)
4567:             .FontName  = "Tahoma"
4568:             .FontSize  = 8
4569:         ENDWITH
4570:         WITH par_oPagina.obj_4c_Fwoption2.Buttons(2)
4571:             .Caption   = "N" + CHR(227) + "o"
4572:             .BackStyle = 0
4573:             .Top       = 0
4574:             .Left      = 47
4575:             .Height    = 15
4576:             .ForeColor = RGB(90, 90, 90)
4577:             .FontName  = "Tahoma"
4578:             .FontSize  = 8
4579:         ENDWITH
4580: 
4581:         *-- Descricao do grupo/fase selecionada (Get_Desc - espelha
4582:         *-- crSigCdGcr.descrs; sem ControlSource nesta fase - regra #41)
4583:         par_oPagina.AddObject("lbl_4c_Label1", "Label")
4584:         WITH par_oPagina.lbl_4c_Label1
4585:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4586:             .Top       = 508
4587:             .Left      = 527
4588:             .Width     = 67
4589:             .Height    = 17
4590:             .BackStyle = 0
4591:             .ForeColor = RGB(90, 90, 90)
4592:             .FontName  = "Tahoma"
4593:             .FontSize  = 8
4594:             .Visible   = .T.
4595:         ENDWITH
4596: 
4597:         par_oPagina.AddObject("txt_4c_Desc", "TextBox")
4598:         WITH par_oPagina.txt_4c_Desc
4599:             .Top       = 505
4600:             .Left      = 595
4601:             .Width     = 395
4602:             .Height    = 23
4603:             .FontName  = "Tahoma"
4604:             .FontSize  = 8
4605:             .Visible   = .T.
4606:         ENDWITH
4607: 
4608:         *-- Grade de Fases do Processo (GradFase legado, 5 colunas) - espelha
4609:         *-- crSigCdPrf; SEM RecordSource/ControlSource nesta fase (regra #41)
4610:         par_oPagina.AddObject("grd_4c_Dados", "Grid")
4611:         par_oPagina.grd_4c_Dados.ColumnCount = 5
4612:         WITH par_oPagina.grd_4c_Dados
4613:             .Top                = 129
4614:             .Left               = 527
4615:             .Width              = 420
4616:             .Height             = 168
4617:             .FontName           = "Verdana"
4618:             .FontSize           = 8
4619:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 4631 a 4707:
4631:             .Visible            = .T.
4632: 
4633:             .Column1.Width           = 45
4634:             .Column1.Header1.Caption = "Ordem"
4635:             .Column2.Width           = 80
4636:             .Column2.Header1.Caption = "Fase"
4637:             .Column3.Width           = 70
4638:             .Column3.Movable         = .F.
4639:             .Column3.Resizable       = .F.
4640:             .Column3.InputMask       = "99,999.9"
4641:             .Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
4642:             .Column4.Width           = 84
4643:             .Column4.Movable         = .F.
4644:             .Column4.Resizable       = .F.
4645:             .Column4.Header1.Caption = "Uni. Produtiva"
4646:             .Column5.Width           = 115
4647:             .Column5.Header1.Caption = "Material"
4648:         ENDWITH
4649: 
4650:         *-- Botoes de CRUD da grade de Fases (inserir/excluir/Alternativa
4651:         *-- legados) - standalone, Click entra quando crSigCdPrf for migrado
4652:         par_oPagina.AddObject("cmd_4c_Incluir", "CommandButton")
4653:         WITH par_oPagina.cmd_4c_Incluir
4654:             .Top             = 129
4655:             .Left = 5
4656:             .Width           = 39
4657:             .Height          = 40
4658:             .Caption         = ""
4659:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
4660:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
4661:             .ToolTipText     = "Incluir"
4662:             .Themes          = .T.
4663:             .Enabled         = .T.
4664:             .Visible         = .T.
4665:         ENDWITH
4666: 
4667:         par_oPagina.AddObject("cmd_4c_Excluir", "CommandButton")
4668:         WITH par_oPagina.cmd_4c_Excluir
4669:             .Top             = 169
4670:             .Left = 230
4671:             .Width           = 39
4672:             .Height          = 40
4673:             .Caption         = ""
4674:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4675:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4676:             .ToolTipText     = "Excluir"
4677:             .Themes          = .T.
4678:             .Enabled         = .T.
4679:             .Visible         = .T.
4680:         ENDWITH
4681: 
4682:         par_oPagina.AddObject("cmd_4c_Alternativa", "CommandButton")
4683:         WITH par_oPagina.cmd_4c_Alternativa
4684:             .Top             = 209
4685:             .Left            = 950
4686:             .Width           = 39
4687:             .Height          = 40
4688:             .Caption         = ""
4689:             .Picture         = gc_4c_CaminhoIcones + "geral_pn_cfg_26.jpg"
4690:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pn_cfg_26.jpg"
4691:             .ToolTipText     = "Alternativa"
4692:             .Themes          = .T.
4693:             .Enabled         = .T.
4694:             .Visible         = .T.
4695:         ENDWITH
4696: 
4697:         *-- Observacao da Fase (Get_Obs - espelha crSigCdPrf.Obs; sem
4698:         *-- ControlSource nesta fase - regra #41)
4699:         par_oPagina.AddObject("obj_4c_GetObs", "EditBox")
4700:         WITH par_oPagina.obj_4c_GetObs
4701:             .Top     = 531
4702:             .Left    = 527
4703:             .Width   = 463
4704:             .Height  = 92
4705:             .FontName = "Tahoma"
4706:             .FontSize = 8
4707:             .Visible = .T.

*-- Linhas 4713 a 4722:
4713:         par_oPagina.AddObject("grd_4c_Matrizes", "Grid")
4714:         par_oPagina.grd_4c_Matrizes.ColumnCount = 3
4715:         WITH par_oPagina.grd_4c_Matrizes
4716:             .Top                = 305
4717:             .Left               = 527
4718:             .Width              = 245
4719:             .Height             = 192
4720:             .FontName           = "Verdana"
4721:             .FontSize           = 8
4722:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 4734 a 4801:
4734:             .Visible            = .T.
4735: 
4736:             .Column1.Width           = 108
4737:             .Column1.Header1.Caption = "Matriz"
4738:             .Column2.Width           = 80
4739:             .Column2.ColumnOrder     = 3
4740:             .Column2.Movable         = .F.
4741:             .Column2.Resizable       = .F.
4742:             .Column2.Header1.Caption = "Local"
4743:             .Column3.Width           = 34
4744:             .Column3.ColumnOrder     = 2
4745:             .Column3.InputMask       = "9999"
4746:             .Column3.Header1.Caption = "Qtde"
4747:         ENDWITH
4748: 
4749:         *-- Botoes de CRUD da grade de Matrizes (btnInsereMtx/btnExcluiMtz
4750:         *-- legados) - standalone, Click entra quando crSigPrMtz for migrado
4751:         par_oPagina.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
4752:         WITH par_oPagina.cmd_4c_BtnInsereMtx
4753:             .Top             = 302
4754:             .Left            = 778
4755:             .Width           = 39
4756:             .Height          = 40
4757:             .Caption         = ""
4758:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
4759:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
4760:             .Themes          = .T.
4761:             .Enabled         = .T.
4762:             .Visible         = .T.
4763:         ENDWITH
4764: 
4765:         par_oPagina.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
4766:         WITH par_oPagina.cmd_4c_BtnExcluiMtz
4767:             .Top             = 342
4768:             .Left            = 778
4769:             .Width           = 39
4770:             .Height          = 40
4771:             .Caption         = ""
4772:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4773:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4774:             .ToolTipText     = "Excluir"
4775:             .Themes          = .T.
4776:             .Enabled         = .T.
4777:             .Visible         = .T.
4778:         ENDWITH
4779: 
4780:         *-- Imagem da Matriz/Borracha selecionada (shpBorracha/ImgBorracha)
4781:         par_oPagina.AddObject("shp_4c_ShpBorracha", "Shape")
4782:         WITH par_oPagina.shp_4c_ShpBorracha
4783:             .Top           = 387
4784:             .Left          = 779
4785:             .Width         = 210
4786:             .Height        = 112
4787:             .BackStyle     = 0
4788:             .BorderWidth   = 2
4789:             .SpecialEffect = 0
4790:             .Visible       = .T.
4791:         ENDWITH
4792: 
4793:         par_oPagina.AddObject("img_4c_ImgBorracha", "Image")
4794:         WITH par_oPagina.img_4c_ImgBorracha
4795:             .Top     = 388
4796:             .Left    = 780
4797:             .Width   = 208
4798:             .Height  = 110
4799:             .Stretch = 1
4800:             .Enabled = .F.
4801:             .Visible = .T.

*-- Linhas 4825 a 4867:
4825:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
4826: 
4827:         *-- Qtde. Componentes (Getqtcpnt legado - espelha crSigCdPro.qtdcpnts)
4828:         par_oPagina.AddObject("lbl_4c_Label7", "Label")
4829:         WITH par_oPagina.lbl_4c_Label7
4830:             .Caption   = "Qtde Componentes : "
4831:             .Top       = 505
4832:             .Left      = 23
4833:             .Width     = 105
4834:             .Height    = 15
4835:             .BackStyle = 0
4836:             .ForeColor = RGB(90, 90, 90)
4837:             .FontName  = "Tahoma"
4838:             .FontSize  = 8
4839:             .Visible   = .T.
4840:         ENDWITH
4841: 
4842:         par_oPagina.AddObject("txt_4c_Qtcpnt", "TextBox")
4843:         WITH par_oPagina.txt_4c_Qtcpnt
4844:             .Top       = 500
4845:             .Left      = 132
4846:             .Width     = 31
4847:             .Height    = 23
4848:             .MaxLength = 3
4849:             .InputMask = "999"
4850:             .FontName  = "Tahoma"
4851:             .FontSize  = 8
4852:             .ForeColor = RGB(90, 90, 90)
4853:             .Visible   = .T.
4854:         ENDWITH
4855: 
4856:         *-- Nao Checar Cadastro de Fundicao (chkFund legado - espelha
4857:         *-- crSigCdPro.chkFunds)
4858:         par_oPagina.AddObject("chk_4c_ChkFund", "CheckBox")
4859:         WITH par_oPagina.chk_4c_ChkFund
4860:             .Caption   = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
4861:             .Top       = 525
4862:             .Left      = 11
4863:             .Width     = 182
4864:             .Height    = 15
4865:             .Value     = 0
4866:             .Alignment = 0
4867:             .BackStyle = 0

*-- Linhas 4875 a 4884:
4875:         par_oPagina.AddObject("grd_4c_Dados", "Grid")
4876:         par_oPagina.grd_4c_Dados.ColumnCount = 9
4877:         WITH par_oPagina.grd_4c_Dados
4878:             .Top                = 149
4879:             .Left               = 6
4880:             .Width              = 987
4881:             .Height             = 347
4882:             .FontName           = "Verdana"
4883:             .FontSize           = 8
4884:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 4900 a 4968:
4900:             .Column1.ColumnOrder     = 1
4901:             .Column1.Width           = 108
4902:             .Column1.ReadOnly        = .T.
4903:             .Column1.Header1.Caption = "Componente"
4904: 
4905:             .Column9.ColumnOrder     = 2
4906:             .Column9.Width           = 223
4907:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4908: 
4909:             .Column2.ColumnOrder     = 3
4910:             .Column2.Width           = 60
4911:             .Column2.ReadOnly        = .T.
4912:             .Column2.Header1.Caption = "Qtde."
4913: 
4914:             .Column3.ColumnOrder     = 4
4915:             .Column3.Width           = 25
4916:             .Column3.ReadOnly        = .T.
4917:             .Column3.Header1.Caption = "Uni"
4918: 
4919:             .Column4.ColumnOrder     = 5
4920:             .Column4.Width           = 105
4921:             .Column4.Movable         = .F.
4922:             .Column4.Resizable       = .F.
4923:             .Column4.Sparse          = .F.
4924:             .Column4.Header1.Caption = "Fase"
4925: 
4926:             .Column5.ColumnOrder     = 6
4927:             .Column5.Width           = 290
4928:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4929: 
4930:             .Column6.ColumnOrder     = 7
4931:             .Column6.Width           = 35
4932:             .Column6.ReadOnly        = .T.
4933:             .Column6.Header1.Caption = "Ord."
4934: 
4935:             .Column7.ColumnOrder     = 8
4936:             .Column7.Width           = 60
4937:             .Column7.Header1.Caption = "Consumo"
4938: 
4939:             .Column8.ColumnOrder     = 9
4940:             .Column8.Width           = 52
4941:             .Column8.Header1.Caption = "Cat."
4942:         ENDWITH
4943: 
4944:         *-- Tempo de Producao por Agrupamento (grDTEMP legado, 2 colunas)
4945:         par_oPagina.AddObject("lbl_4c_Label1", "Label")
4946:         WITH par_oPagina.lbl_4c_Label1
4947:             .Caption   = "Tempo Produ" + CHR(231) + CHR(227) + "o por Agrupamento :"
4948:             .Top       = 501
4949:             .Left      = 643
4950:             .Width     = 176
4951:             .Height    = 15
4952:             .BackStyle = 0
4953:             .ForeColor = RGB(90, 90, 90)
4954:             .FontName  = "Tahoma"
4955:             .FontSize  = 8
4956:             .Visible   = .T.
4957:         ENDWITH
4958: 
4959:         par_oPagina.AddObject("grd_4c_Tempos", "Grid")
4960:         par_oPagina.grd_4c_Tempos.ColumnCount = 2
4961:         WITH par_oPagina.grd_4c_Tempos
4962:             .Top                = 500
4963:             .Left               = 821
4964:             .Width              = 172
4965:             .Height             = 107
4966:             .FontName           = "Verdana"
4967:             .FontSize           = 8
4968:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 4980 a 5131:
4980:             .Visible            = .T.
4981: 
4982:             .Column1.Width = 80
4983:             .Column1.Header1.Caption = "Agrupamento"
4984:             .Column2.Width = 60
4985:             .Column2.Header1.Caption = "Tempo %"
4986:         ENDWITH
4987: 
4988:         THIS.TornarControlesVisiveis(par_oPagina)
4989:     ENDPROC
4990: 
4991:     *===========================================================================
4992:     * ConfigurarPgpgDadosFiscais - Campos da aba "Dados Fiscais" (pgDadosFiscais
4993:     * legado - classificacao fiscal, ICMS/IPI, conta contabil e grade de CMV -
4994:     * FASE 13). Alvo real eh pgf_4c_Divisoes.Page3 (Page3.Caption = "Dados
4995:     * Fiscais" em ConfigurarPaginaDados / PageOrder 3 em AlternarDivisao); o
4996:     * "Page6" citado no prompt generico desta fase pertence a pgCusto
4997:     * (ConfigurarPgpgCusto), que ja ocupa esse slot.
4998:     *===========================================================================
4999:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais()
5000:         LOCAL par_oPagina
5001:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3
5002: 
5003:         *-- Configuracao (Fwoption1 legado - sem Valid/Click no dump, so
5004:         *-- estrutura visual: ButtonCount=2, sem captions capturadas)
5005:         par_oPagina.AddObject("lbl_4c_Label29", "Label")
5006:         WITH par_oPagina.lbl_4c_Label29
5007:             .Caption   = "Configura" + CHR(231) + CHR(227) + "o :"
5008:             .Top       = 128
5009:             .Left      = 129
5010:             .Width     = 73
5011:             .Height    = 15
5012:             .BackStyle = 0
5013:             .ForeColor = RGB(90, 90, 90)
5014:             .FontName  = "Tahoma"
5015:             .FontSize  = 8
5016:             .Visible   = .T.
5017:         ENDWITH
5018: 
5019:         par_oPagina.AddObject("obj_4c_Fwoption1", "OptionGroup")
5020:         WITH par_oPagina.obj_4c_Fwoption1
5021:             .ButtonCount = 2
5022:             .Top         = 123
5023:             .Left        = 204
5024:             .Width       = 151
5025:             .Height      = 24
5026:             .Visible     = .T.
5027:         ENDWITH
5028: 
5029:         *-- Codigo Importado / Codigo Nacional / Codigo DCR (get_CodImpPro,
5030:         *-- get_codnacpro, get_coddcr legado - sem Valid/Click no dump e sem
5031:         *-- coluna correspondente em SigCdPro/docs/schema.sql; mantidos como
5032:         *-- campo simples, sem persistencia (regra #17 - nao inventar coluna)
5033:         par_oPagina.AddObject("lbl_4c_Label14", "Label")
5034:         WITH par_oPagina.lbl_4c_Label14
5035:             .Caption   = "C" + CHR(243) + "digo Importado :"
5036:             .Top       = 154
5037:             .Left      = 107
5038:             .Width     = 95
5039:             .Height    = 15
5040:             .BackStyle = 0
5041:             .ForeColor = RGB(90, 90, 90)
5042:             .FontName  = "Tahoma"
5043:             .FontSize  = 8
5044:             .Visible   = .T.
5045:         ENDWITH
5046: 
5047:         par_oPagina.AddObject("txt_4c__CodImpPro", "TextBox")
5048:         WITH par_oPagina.txt_4c__CodImpPro
5049:             .Top       = 150
5050:             .Left      = 206
5051:             .Width     = 80
5052:             .Height    = 23
5053:             .MaxLength = 20
5054:             .FontName  = "Tahoma"
5055:             .FontSize  = 8
5056:             .Visible   = .T.
5057:         ENDWITH
5058: 
5059:         par_oPagina.AddObject("txt_4c__DCodImpPro", "TextBox")
5060:         WITH par_oPagina.txt_4c__DCodImpPro
5061:             .Top       = 150
5062:             .Left      = 288
5063:             .Width     = 318
5064:             .Height    = 23
5065:             .MaxLength = 40
5066:             .FontName  = "Tahoma"
5067:             .FontSize  = 8
5068:             .Visible   = .T.
5069:         ENDWITH
5070: 
5071:         par_oPagina.AddObject("lbl_4c_Label19", "Label")
5072:         WITH par_oPagina.lbl_4c_Label19
5073:             .Caption   = "C" + CHR(243) + "digo Nacional :"
5074:             .Top       = 178
5075:             .Left      = 117
5076:             .Width     = 85
5077:             .Height    = 15
5078:             .BackStyle = 0
5079:             .ForeColor = RGB(90, 90, 90)
5080:             .FontName  = "Tahoma"
5081:             .FontSize  = 8
5082:             .Visible   = .T.
5083:         ENDWITH
5084: 
5085:         par_oPagina.AddObject("txt_4c__codnacpro", "TextBox")
5086:         WITH par_oPagina.txt_4c__codnacpro
5087:             .Top       = 175
5088:             .Left      = 206
5089:             .Width     = 80
5090:             .Height    = 23
5091:             .MaxLength = 20
5092:             .FontName  = "Tahoma"
5093:             .FontSize  = 8
5094:             .Visible   = .T.
5095:         ENDWITH
5096: 
5097:         par_oPagina.AddObject("txt_4c__dcodnacpro", "TextBox")
5098:         WITH par_oPagina.txt_4c__dcodnacpro
5099:             .Top       = 175
5100:             .Left      = 288
5101:             .Width     = 318
5102:             .Height    = 23
5103:             .MaxLength = 40
5104:             .FontName  = "Tahoma"
5105:             .FontSize  = 8
5106:             .Visible   = .T.
5107:         ENDWITH
5108: 
5109:         par_oPagina.AddObject("lbl_4c_Label20", "Label")
5110:         WITH par_oPagina.lbl_4c_Label20
5111:             .Caption   = "C" + CHR(243) + "digo DCR :"
5112:             .Top       = 203
5113:             .Left      = 136
5114:             .Width     = 66
5115:             .Height    = 15
5116:             .BackStyle = 0
5117:             .ForeColor = RGB(90, 90, 90)
5118:             .FontName  = "Tahoma"
5119:             .FontSize  = 8
5120:             .Visible   = .T.
5121:         ENDWITH
5122: 
5123:         par_oPagina.AddObject("txt_4c__coddcr", "TextBox")
5124:         WITH par_oPagina.txt_4c__coddcr
5125:             .Top       = 200
5126:             .Left      = 206
5127:             .Width     = 80
5128:             .Height    = 23
5129:             .MaxLength = 20
5130:             .FontName  = "Tahoma"
5131:             .FontSize  = 8

*-- Linhas 5138 a 5294:
5138:         *-- feedback_facessocontas_lookup_ux.md); sem a tabela de referencia
5139:         *-- exata confirmada no schema atual, os campos ficam como entrada
5140:         *-- simples, sem picker (regra #17 - nao inventar tabela/consulta)
5141:         par_oPagina.AddObject("lbl_4c_Label16", "Label")
5142:         WITH par_oPagina.lbl_4c_Label16
5143:             .Caption   = "Grupo C.C. :"
5144:             .Top       = 229
5145:             .Left      = 139
5146:             .Width     = 63
5147:             .Height    = 15
5148:             .BackStyle = 0
5149:             .ForeColor = RGB(90, 90, 90)
5150:             .FontName  = "Tahoma"
5151:             .FontSize  = 8
5152:             .Visible   = .T.
5153:         ENDWITH
5154: 
5155:         par_oPagina.AddObject("txt_4c__gruccus", "TextBox")
5156:         WITH par_oPagina.txt_4c__gruccus
5157:             .Top       = 225
5158:             .Left      = 206
5159:             .Width     = 80
5160:             .Height    = 23
5161:             .MaxLength = 10
5162:             .FontName  = "Tahoma"
5163:             .FontSize  = 8
5164:             .Visible   = .T.
5165:         ENDWITH
5166: 
5167:         par_oPagina.AddObject("txt_4c__dgruccus", "TextBox")
5168:         WITH par_oPagina.txt_4c__dgruccus
5169:             .Top       = 225
5170:             .Left      = 288
5171:             .Width     = 318
5172:             .Height    = 23
5173:             .ReadOnly  = .T.
5174:             .FontName  = "Tahoma"
5175:             .FontSize  = 8
5176:             .Visible   = .T.
5177:         ENDWITH
5178: 
5179:         par_oPagina.AddObject("lbl_4c_Label17", "Label")
5180:         WITH par_oPagina.lbl_4c_Label17
5181:             .Caption   = "Conta C.C. :"
5182:             .Top       = 253
5183:             .Left      = 139
5184:             .Width     = 63
5185:             .Height    = 15
5186:             .BackStyle = 0
5187:             .ForeColor = RGB(90, 90, 90)
5188:             .FontName  = "Tahoma"
5189:             .FontSize  = 8
5190:             .Visible   = .T.
5191:         ENDWITH
5192: 
5193:         par_oPagina.AddObject("txt_4c__contaccus", "TextBox")
5194:         WITH par_oPagina.txt_4c__contaccus
5195:             .Top       = 250
5196:             .Left      = 206
5197:             .Width     = 80
5198:             .Height    = 23
5199:             .MaxLength = 10
5200:             .FontName  = "Tahoma"
5201:             .FontSize  = 8
5202:             .Visible   = .T.
5203:         ENDWITH
5204: 
5205:         par_oPagina.AddObject("txt_4c__dcontaccus", "TextBox")
5206:         WITH par_oPagina.txt_4c__dcontaccus
5207:             .Top       = 250
5208:             .Left      = 288
5209:             .Width     = 318
5210:             .Height    = 23
5211:             .ReadOnly  = .T.
5212:             .FontName  = "Tahoma"
5213:             .FontSize  = 8
5214:             .Visible   = .T.
5215:         ENDWITH
5216: 
5217:         *-- Classificacao Fiscal (getClfiscal/getDclfiscal legado - SigCdClf)
5218:         par_oPagina.AddObject("lbl_4c_Label1", "Label")
5219:         WITH par_oPagina.lbl_4c_Label1
5220:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
5221:             .Top       = 280
5222:             .Left      = 103
5223:             .Width     = 99
5224:             .Height    = 15
5225:             .BackStyle = 0
5226:             .ForeColor = RGB(90, 90, 90)
5227:             .FontName  = "Tahoma"
5228:             .FontSize  = 8
5229:             .Visible   = .T.
5230:         ENDWITH
5231: 
5232:         par_oPagina.AddObject("txt_4c_Clfiscal", "TextBox")
5233:         WITH par_oPagina.txt_4c_Clfiscal
5234:             .Top       = 275
5235:             .Left      = 206
5236:             .Width     = 94
5237:             .Height    = 23
5238:             .MaxLength = 10
5239:             .FontName  = "Tahoma"
5240:             .FontSize  = 8
5241:             .Visible   = .T.
5242:         ENDWITH
5243:         BINDEVENT(par_oPagina.txt_4c_Clfiscal, "KeyPress", THIS, "ValidarClassificacaoFiscalPorCodigo")
5244: 
5245:         par_oPagina.AddObject("txt_4c_Dclfiscal", "TextBox")
5246:         WITH par_oPagina.txt_4c_Dclfiscal
5247:             .Top       = 275
5248:             .Left      = 303
5249:             .Width     = 303
5250:             .Height    = 23
5251:             .MaxLength = 40
5252:             .FontName  = "Tahoma"
5253:             .FontSize  = 8
5254:             .Visible   = .T.
5255:         ENDWITH
5256:         BINDEVENT(par_oPagina.txt_4c_Dclfiscal, "KeyPress", THIS, "ValidarClassificacaoFiscalPorDescricao")
5257: 
5258:         *-- Origem da Mercadoria (getOrigmerc/getDorigmerc legado - SigCdOrg)
5259:         par_oPagina.AddObject("lbl_4c_Label2", "Label")
5260:         WITH par_oPagina.lbl_4c_Label2
5261:             .Caption   = "Origem da Mercadoria :"
5262:             .Top       = 305
5263:             .Left      = 88
5264:             .Width     = 114
5265:             .Height    = 15
5266:             .BackStyle = 0
5267:             .ForeColor = RGB(90, 90, 90)
5268:             .FontName  = "Tahoma"
5269:             .FontSize  = 8
5270:             .Visible   = .T.
5271:         ENDWITH
5272: 
5273:         par_oPagina.AddObject("txt_4c_Origmerc", "TextBox")
5274:         WITH par_oPagina.txt_4c_Origmerc
5275:             .Top       = 300
5276:             .Left      = 206
5277:             .Width     = 17
5278:             .Height    = 23
5279:             .MaxLength = 1
5280:             .FontName  = "Tahoma"
5281:             .FontSize  = 8
5282:             .Visible   = .T.
5283:         ENDWITH
5284:         BINDEVENT(par_oPagina.txt_4c_Origmerc, "KeyPress", THIS, "ValidarOrigemMercadoriaPorCodigo")
5285: 
5286:         par_oPagina.AddObject("txt_4c_Dorigmerc", "TextBox")
5287:         WITH par_oPagina.txt_4c_Dorigmerc
5288:             .Top       = 300
5289:             .Left      = 226
5290:             .Width     = 380
5291:             .Height    = 23
5292:             .MaxLength = 40
5293:             .FontName  = "Tahoma"
5294:             .FontSize  = 8

*-- Linhas 5300 a 5521:
5300:         *-- legado - SigCdIcm; Get_CodServs eh o codigo de servico que
5301:         *-- resolve a mesma situacao tributaria e grava o resultado em
5302:         *-- getSittricm/getDsittricm, exatamente como no Valid original)
5303:         par_oPagina.AddObject("lbl_4c_Label3", "Label")
5304:         WITH par_oPagina.lbl_4c_Label3
5305:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
5306:             .Top       = 330
5307:             .Left      = 75
5308:             .Width     = 127
5309:             .Height    = 15
5310:             .BackStyle = 0
5311:             .ForeColor = RGB(90, 90, 90)
5312:             .FontName  = "Tahoma"
5313:             .FontSize  = 8
5314:             .Visible   = .T.
5315:         ENDWITH
5316: 
5317:         par_oPagina.AddObject("txt_4c_Sittricm", "TextBox")
5318:         WITH par_oPagina.txt_4c_Sittricm
5319:             .Top       = 325
5320:             .Left      = 206
5321:             .Width     = 31
5322:             .Height    = 23
5323:             .MaxLength = 3
5324:             .FontName  = "Tahoma"
5325:             .FontSize  = 8
5326:             .Visible   = .T.
5327:         ENDWITH
5328:         BINDEVENT(par_oPagina.txt_4c_Sittricm, "KeyPress", THIS, "ValidarSituacaoTributariaPorCodigo")
5329: 
5330:         par_oPagina.AddObject("txt_4c_Dsittricm", "TextBox")
5331:         WITH par_oPagina.txt_4c_Dsittricm
5332:             .Top       = 325
5333:             .Left      = 240
5334:             .Width     = 366
5335:             .Height    = 23
5336:             .MaxLength = 40
5337:             .FontName  = "Tahoma"
5338:             .FontSize  = 8
5339:             .Visible   = .T.
5340:         ENDWITH
5341:         BINDEVENT(par_oPagina.txt_4c_Dsittricm, "KeyPress", THIS, "ValidarSituacaoTributariaPorDescricao")
5342: 
5343:         *-- Codigo de Servicos para ICMS (Get_CodServs legado)
5344:         par_oPagina.AddObject("lbl_4c_Label6", "Label")
5345:         WITH par_oPagina.lbl_4c_Label6
5346:             .Caption   = "C" + CHR(243) + "digo de Servi" + CHR(231) + "os para ICMS :"
5347:             .Top       = 355
5348:             .Left      = 49
5349:             .Width     = 153
5350:             .Height    = 15
5351:             .BackStyle = 0
5352:             .ForeColor = RGB(90, 90, 90)
5353:             .FontName  = "Tahoma"
5354:             .FontSize  = 8
5355:             .Visible   = .T.
5356:         ENDWITH
5357: 
5358:         par_oPagina.AddObject("txt_4c_Codigo", "TextBox")
5359:         WITH par_oPagina.txt_4c_Codigo
5360:             .Top       = 350
5361:             .Left      = 206
5362:             .Width     = 38
5363:             .Height    = 23
5364:             .MaxLength = 4
5365:             .FontName  = "Tahoma"
5366:             .FontSize  = 8
5367:             .Visible   = .T.
5368:         ENDWITH
5369:         BINDEVENT(par_oPagina.txt_4c_Codigo, "KeyPress", THIS, "ValidarCodigoServicoIcmsDadosFiscais")
5370: 
5371:         *-- Aliquota ICMS (getIcms legado - icms numeric(5,2))
5372:         par_oPagina.AddObject("lbl_4c_Label8", "Label")
5373:         WITH par_oPagina.lbl_4c_Label8
5374:             .Caption   = "Al" + CHR(237) + "quota ICMS :"
5375:             .Top       = 355
5376:             .Left      = 263
5377:             .Width     = 76
5378:             .Height    = 15
5379:             .BackStyle = 0
5380:             .ForeColor = RGB(90, 90, 90)
5381:             .FontName  = "Tahoma"
5382:             .FontSize  = 8
5383:             .Visible   = .T.
5384:         ENDWITH
5385: 
5386:         par_oPagina.AddObject("txt_4c_Icms", "TextBox")
5387:         WITH par_oPagina.txt_4c_Icms
5388:             .Top       = 350
5389:             .Left      = 342
5390:             .Width     = 45
5391:             .Height    = 23
5392:             .InputMask = "999.99"
5393:             .FontName  = "Tahoma"
5394:             .FontSize  = 8
5395:             .Visible   = .T.
5396:         ENDWITH
5397: 
5398:         *-- Tipo de Tributacao (Get_TpTrib legado - SigPrTri)
5399:         par_oPagina.AddObject("lbl_4c_Label4", "Label")
5400:         WITH par_oPagina.lbl_4c_Label4
5401:             .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
5402:             .Top       = 355
5403:             .Left      = 411
5404:             .Width     = 98
5405:             .Height    = 15
5406:             .BackStyle = 0
5407:             .ForeColor = RGB(90, 90, 90)
5408:             .FontName  = "Tahoma"
5409:             .FontSize  = 8
5410:             .Visible   = .T.
5411:         ENDWITH
5412: 
5413:         par_oPagina.AddObject("txt_4c_TpTrib", "TextBox")
5414:         WITH par_oPagina.txt_4c_TpTrib
5415:             .Top       = 350
5416:             .Left      = 513
5417:             .Width     = 38
5418:             .Height    = 23
5419:             .MaxLength = 4
5420:             .FontName  = "Tahoma"
5421:             .FontSize  = 8
5422:             .Visible   = .T.
5423:         ENDWITH
5424:         BINDEVENT(par_oPagina.txt_4c_TpTrib, "KeyPress", THIS, "ValidarTipoTributacaoDadosFiscais")
5425: 
5426:         *-- IAT - Indicador de Arredondamento/Truncamento (getiat legado -
5427:         *-- aceita so A, T ou espaco)
5428:         par_oPagina.AddObject("lbl_4c_Label41", "Label")
5429:         WITH par_oPagina.lbl_4c_Label41
5430:             .Caption   = "IAT :"
5431:             .Top       = 354
5432:             .Left      = 558
5433:             .Width     = 26
5434:             .Height    = 15
5435:             .BackStyle = 0
5436:             .ForeColor = RGB(90, 90, 90)
5437:             .FontName  = "Tahoma"
5438:             .FontSize  = 8
5439:             .Visible   = .T.
5440:         ENDWITH
5441: 
5442:         par_oPagina.AddObject("txt_4c_Iat", "TextBox")
5443:         WITH par_oPagina.txt_4c_Iat
5444:             .Top       = 350
5445:             .Left      = 589
5446:             .Width     = 17
5447:             .Height    = 23
5448:             .MaxLength = 1
5449:             .Format    = "!"
5450:             .FontName  = "Tahoma"
5451:             .FontSize  = 8
5452:             .Visible   = .T.
5453:         ENDWITH
5454:         BINDEVENT(par_oPagina.txt_4c_Iat, "KeyPress", THIS, "ValidarIatDadosFiscais")
5455: 
5456:         par_oPagina.AddObject("lbl_4c_Label42", "Label")
5457:         WITH par_oPagina.lbl_4c_Label42
5458:             .Caption   = "[A]rredondamento [T]runcamento"
5459:             .Top       = 354
5460:             .Left      = 609
5461:             .Width     = 165
5462:             .Height    = 15
5463:             .BackStyle = 0
5464:             .ForeColor = RGB(90, 90, 90)
5465:             .FontName  = "Tahoma"
5466:             .FontSize  = 8
5467:             .Visible   = .T.
5468:         ENDWITH
5469: 
5470:         *-- Situacao Tributaria IPI - Combo (cmbIpi legado - ipis char(1))
5471:         par_oPagina.AddObject("lbl_4c_Label5", "Label")
5472:         WITH par_oPagina.lbl_4c_Label5
5473:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria IPI :"
5474:             .Top       = 380
5475:             .Left      = 86
5476:             .Width     = 116
5477:             .Height    = 15
5478:             .BackStyle = 0
5479:             .ForeColor = RGB(90, 90, 90)
5480:             .FontName  = "Tahoma"
5481:             .FontSize  = 8
5482:             .Visible   = .T.
5483:         ENDWITH
5484: 
5485:         par_oPagina.AddObject("cbo_4c_CmbIpi", "ComboBox")
5486:         WITH par_oPagina.cbo_4c_CmbIpi
5487:             .Top       = 375
5488:             .Left      = 206
5489:             .Width     = 108
5490:             .Height    = 25
5491:             .FontName  = "Tahoma"
5492:             .FontSize  = 8
5493:             .Visible   = .T.
5494:         ENDWITH
5495: 
5496:         *-- Aliquota de IPI (Get_AliqIPI legado - aliqipis numeric(5,2);
5497:         *-- Valid compara com a aliquota da Classificacao Fiscal e avisa
5498:         *-- quando ficam identicas - transcrito do dump)
5499:         par_oPagina.AddObject("lbl_4c__AliqIPI", "Label")
5500:         WITH par_oPagina.lbl_4c__AliqIPI
5501:             .Caption   = "Al" + CHR(237) + "quota de IPI :"
5502:             .Top       = 380
5503:             .Left      = 340
5504:             .Width     = 80
5505:             .Height    = 15
5506:             .BackStyle = 0
5507:             .ForeColor = RGB(90, 90, 90)
5508:             .FontName  = "Tahoma"
5509:             .FontSize  = 8
5510:             .Visible   = .T.
5511:         ENDWITH
5512: 
5513:         par_oPagina.AddObject("txt_4c_AliqIPI", "TextBox")
5514:         WITH par_oPagina.txt_4c_AliqIPI
5515:             .Top       = 375
5516:             .Left      = 425
5517:             .Width     = 45
5518:             .Height    = 25
5519:             .InputMask = "999.99"
5520:             .FontName  = "Tahoma"
5521:             .FontSize  = 8

*-- Linhas 5527 a 5581:
5527:         *-- habilita o campo so quando SigCdClf.IpiProds = 'S' (When
5528:         *-- dinamico); nao reproduzido aqui por depender de refresh a cada
5529:         *-- foco - o campo fica sempre habilitado, regra #17)
5530:         par_oPagina.AddObject("lbl_4c_Label13", "Label")
5531:         WITH par_oPagina.lbl_4c_Label13
5532:             .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
5533:             .Top       = 380
5534:             .Left      = 511
5535:             .Width     = 87
5536:             .Height    = 15
5537:             .BackStyle = 0
5538:             .ForeColor = RGB(90, 90, 90)
5539:             .FontName  = "Tahoma"
5540:             .FontSize  = 8
5541:             .Visible   = .T.
5542:         ENDWITH
5543: 
5544:         par_oPagina.AddObject("txt_4c_Extipi", "TextBox")
5545:         WITH par_oPagina.txt_4c_Extipi
5546:             .Top       = 375
5547:             .Left      = 601
5548:             .Width     = 35
5549:             .Height    = 25
5550:             .MaxLength = 3
5551:             .FontName  = "Tahoma"
5552:             .FontSize  = 8
5553:             .Visible   = .T.
5554:         ENDWITH
5555: 
5556:         *-- Valor do Grama Produzido - grade de CMV por periodo (grdCmv
5557:         *-- legado, 3 colunas)
5558:         par_oPagina.AddObject("lbl_4c_Label9", "Label")
5559:         WITH par_oPagina.lbl_4c_Label9
5560:             .Caption   = "Valor do Grama Produzido"
5561:             .Top       = 384
5562:             .Left      = 756
5563:             .Width     = 125
5564:             .Height    = 15
5565:             .BackStyle = 0
5566:             .ForeColor = RGB(90, 90, 90)
5567:             .FontName  = "Tahoma"
5568:             .FontSize  = 8
5569:             .Visible   = .T.
5570:         ENDWITH
5571: 
5572:         par_oPagina.AddObject("grd_4c_Dados", "Grid")
5573:         par_oPagina.grd_4c_Dados.ColumnCount = 3
5574:         WITH par_oPagina.grd_4c_Dados
5575:             .Top                = 402
5576:             .Left               = 754
5577:             .Width              = 223
5578:             .Height             = 141
5579:             .FontName           = "Verdana"
5580:             .FontSize           = 8
5581:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 5593 a 5642:
5593:             .Visible            = .T.
5594: 
5595:             .Column1.Width = 70
5596:             .Column1.Header1.Caption = "Per" + CHR(237) + "odo"
5597:             .Column2.Width = 90
5598:             .Column2.Header1.Caption = "Valor Custo GR"
5599:             .Column3.Width = 40
5600:             .Column3.Header1.Caption = "Moe"
5601:         ENDWITH
5602: 
5603:         *-- Descricao Fiscal (mgetdescfi legado - descfis memo) e botao de
5604:         *-- geracao automatica (btnDescFis - fGerDescFis, funcao global do
5605:         *-- legado sem porte ainda; botao fica estrutural, sem Click)
5606:         par_oPagina.AddObject("lbl_4c_Label18", "Label")
5607:         WITH par_oPagina.lbl_4c_Label18
5608:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
5609:             .Top       = 405
5610:             .Left      = 118
5611:             .Width     = 84
5612:             .Height    = 15
5613:             .BackStyle = 0
5614:             .ForeColor = RGB(90, 90, 90)
5615:             .FontName  = "Tahoma"
5616:             .FontSize  = 8
5617:             .Visible   = .T.
5618:         ENDWITH
5619: 
5620:         par_oPagina.AddObject("obj_4c_Mgetdescfi", "EditBox")
5621:         WITH par_oPagina.obj_4c_Mgetdescfi
5622:             .Top       = 402
5623:             .Left      = 206
5624:             .Width     = 509
5625:             .Height    = 89
5626:             .FontName  = "Tahoma"
5627:             .FontSize  = 8
5628:             .Visible   = .T.
5629:         ENDWITH
5630: 
5631:         par_oPagina.AddObject("cmd_4c_BtnDescFis", "CommandButton")
5632:         WITH par_oPagina.cmd_4c_BtnDescFis
5633:             .Top             = 423
5634:             .Left            = 162
5635:             .Width           = 40
5636:             .Height          = 40
5637:             .Caption         = ""
5638:             .Picture         = gc_4c_CaminhoIcones + "geral_documento_26.jpg"
5639:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_documento_26.jpg"
5640:             .ToolTipText     = "Gerar Descri" + CHR(231) + CHR(227) + "o Fiscal"
5641:             .Themes          = .T.
5642:             .Enabled         = .T.

*-- Linhas 5648 a 5753:
5648:         *-- c(2), Descs c(20)) e populados por rotina fora do dump capturado;
5649:         *-- sem a fonte dos dados, os campos ficam como entrada simples, sem
5650:         *-- picker (regra #17 - nao inventar conteudo do cursor local)
5651:         par_oPagina.AddObject("lbl_4c_Label11", "Label")
5652:         WITH par_oPagina.lbl_4c_Label11
5653:             .Caption   = "Metal :"
5654:             .Top       = 497
5655:             .Left      = 498
5656:             .Width     = 35
5657:             .Height    = 15
5658:             .BackStyle = 0
5659:             .ForeColor = RGB(90, 90, 90)
5660:             .FontName  = "Tahoma"
5661:             .FontSize  = 8
5662:             .Visible   = .T.
5663:         ENDWITH
5664: 
5665:         par_oPagina.AddObject("txt_4c_Metal", "TextBox")
5666:         WITH par_oPagina.txt_4c_Metal
5667:             .Top       = 493
5668:             .Left      = 537
5669:             .Width     = 24
5670:             .Height    = 23
5671:             .MaxLength = 2
5672:             .FontName  = "Tahoma"
5673:             .FontSize  = 8
5674:             .Visible   = .T.
5675:         ENDWITH
5676: 
5677:         par_oPagina.AddObject("txt_4c_DesMetal", "TextBox")
5678:         WITH par_oPagina.txt_4c_DesMetal
5679:             .Top       = 493
5680:             .Left      = 564
5681:             .Width     = 150
5682:             .Height    = 23
5683:             .MaxLength = 20
5684:             .ReadOnly  = .T.
5685:             .FontName  = "Tahoma"
5686:             .FontSize  = 8
5687:             .Visible   = .T.
5688:         ENDWITH
5689: 
5690:         *-- Descricao ECF (getDescEcfs legado - descecfs char(29))
5691:         par_oPagina.AddObject("lbl_4c_Label12", "Label")
5692:         WITH par_oPagina.lbl_4c_Label12
5693:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
5694:             .Top       = 497
5695:             .Left      = 125
5696:             .Width     = 77
5697:             .Height    = 15
5698:             .BackStyle = 0
5699:             .ForeColor = RGB(90, 90, 90)
5700:             .FontName  = "Tahoma"
5701:             .FontSize  = 8
5702:             .Visible   = .T.
5703:         ENDWITH
5704: 
5705:         par_oPagina.AddObject("txt_4c_DescEcfs", "TextBox")
5706:         WITH par_oPagina.txt_4c_DescEcfs
5707:             .Top       = 493
5708:             .Left      = 206
5709:             .Width     = 213
5710:             .Height    = 23
5711:             .MaxLength = 29
5712:             .FontName  = "Tahoma"
5713:             .FontSize  = 8
5714:             .Visible   = .T.
5715:         ENDWITH
5716: 
5717:         *-- Teor (Get_teor/Get_DesTeor legado - mesmo cursor local sem fonte
5718:         *-- capturada, ver comentario acima do bloco Metal)
5719:         par_oPagina.AddObject("lbl_4c_Label15", "Label")
5720:         WITH par_oPagina.lbl_4c_Label15
5721:             .Caption   = "Teor :"
5722:             .Top       = 522
5723:             .Left      = 502
5724:             .Width     = 31
5725:             .Height    = 15
5726:             .BackStyle = 0
5727:             .ForeColor = RGB(90, 90, 90)
5728:             .FontName  = "Tahoma"
5729:             .FontSize  = 8
5730:             .Visible   = .T.
5731:         ENDWITH
5732: 
5733:         par_oPagina.AddObject("txt_4c_Teor", "TextBox")
5734:         WITH par_oPagina.txt_4c_Teor
5735:             .Top       = 518
5736:             .Left      = 537
5737:             .Width     = 24
5738:             .Height    = 23
5739:             .MaxLength = 2
5740:             .FontName  = "Tahoma"
5741:             .FontSize  = 8
5742:             .Visible   = .T.
5743:         ENDWITH
5744: 
5745:         par_oPagina.AddObject("txt_4c_DesTeor", "TextBox")
5746:         WITH par_oPagina.txt_4c_DesTeor
5747:             .Top       = 518
5748:             .Left      = 564
5749:             .Width     = 150
5750:             .Height    = 23
5751:             .MaxLength = 20
5752:             .ReadOnly  = .T.
5753:             .FontName  = "Tahoma"

*-- Linhas 5760 a 5827:
5760:         *-- lookup de moeda real (SigCdMoe) e tambem dispara
5761:         *-- ThisForm.TotalGrupo() no legado - efeito nao reproduzido aqui por
5762:         *-- pertencer a aba Componente, fora do escopo desta pagina)
5763:         par_oPagina.AddObject("lbl_4c_Label7", "Label")
5764:         WITH par_oPagina.lbl_4c_Label7
5765:             .Caption   = "Valor Estimado :"
5766:             .Top       = 522
5767:             .Left      = 123
5768:             .Width     = 79
5769:             .Height    = 15
5770:             .BackStyle = 0
5771:             .ForeColor = RGB(90, 90, 90)
5772:             .FontName  = "Tahoma"
5773:             .FontSize  = 8
5774:             .Visible   = .T.
5775:         ENDWITH
5776: 
5777:         par_oPagina.AddObject("txt_4c_Valor", "TextBox")
5778:         WITH par_oPagina.txt_4c_Valor
5779:             .Top       = 518
5780:             .Left      = 206
5781:             .Width     = 108
5782:             .Height    = 23
5783:             .InputMask = "999,999.99"
5784:             .FontName  = "Tahoma"
5785:             .FontSize  = 8
5786:             .Visible   = .T.
5787:         ENDWITH
5788: 
5789:         par_oPagina.AddObject("txt_4c_Mvalor", "TextBox")
5790:         WITH par_oPagina.txt_4c_Mvalor
5791:             .Top       = 518
5792:             .Left      = 317
5793:             .Width     = 31
5794:             .Height    = 23
5795:             .MaxLength = 3
5796:             .FontName  = "Tahoma"
5797:             .FontSize  = 8
5798:             .Visible   = .T.
5799:         ENDWITH
5800:         BINDEVENT(par_oPagina.txt_4c_Mvalor, "KeyPress", THIS, "ValidarMoedaValorEstimadoDadosFiscais")
5801: 
5802:         *-- IPPT/CST (getIPPTCST legado - When retorna .F. sempre, ou seja o
5803:         *-- campo nunca recebe foco no legado; sem coluna correspondente em
5804:         *-- SigCdPro. Mantido desabilitado, fiel ao comportamento original)
5805:         par_oPagina.AddObject("lbl_4c_Label10", "Label")
5806:         WITH par_oPagina.lbl_4c_Label10
5807:             .Caption   = "IPPT/CST :"
5808:             .Top       = 547
5809:             .Left      = 148
5810:             .Width     = 54
5811:             .Height    = 15
5812:             .BackStyle = 0
5813:             .ForeColor = RGB(90, 90, 90)
5814:             .FontName  = "Tahoma"
5815:             .FontSize  = 8
5816:             .Visible   = .T.
5817:         ENDWITH
5818: 
5819:         par_oPagina.AddObject("txt_4c_IPPTCST", "TextBox")
5820:         WITH par_oPagina.txt_4c_IPPTCST
5821:             .Top       = 543
5822:             .Left      = 206
5823:             .Width     = 108
5824:             .Height    = 23
5825:             .Enabled   = .F.
5826:             .FontName  = "Tahoma"
5827:             .FontSize  = 8

*-- Linhas 5870 a 5879:
5870:         *-- Moldura decorativa ao redor do bloco Inspiracao/Observacao (Shape1)
5871:         par_oPagina.AddObject("shp_4c_Shape1", "Shape")
5872:         WITH par_oPagina.shp_4c_Shape1
5873:             .Top           = 400
5874:             .Left          = 584
5875:             .Width         = 407
5876:             .Height        = 202
5877:             .BackStyle     = 0
5878:             .BorderWidth   = 1
5879:             .BorderColor   = RGB(231, 254, 253)

*-- Linhas 5887 a 5896:
5887:         par_oPagina.AddObject("grd_4c_Dados", "Grid")
5888:         par_oPagina.grd_4c_Dados.ColumnCount = 4
5889:         WITH par_oPagina.grd_4c_Dados
5890:             .Top                = 145
5891:             .Left               = 10
5892:             .Width              = 495
5893:             .Height             = 180
5894:             .FontName           = "Tahoma"
5895:             .FontSize           = 8
5896:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 5912 a 5946:
5912:             .Column1.Movable         = .F.
5913:             .Column1.Resizable       = .F.
5914:             .Column1.ReadOnly        = .T.
5915:             .Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
5916: 
5917:             .Column2.Width           = 140
5918:             .Column2.Movable         = .F.
5919:             .Column2.Resizable       = .F.
5920:             .Column2.ReadOnly        = .T.
5921:             .Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
5922: 
5923:             .Column3.Width           = 90
5924:             .Column3.Movable         = .F.
5925:             .Column3.Resizable       = .F.
5926:             .Column3.ReadOnly        = .T.
5927:             .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
5928: 
5929:             .Column4.Width           = 90
5930:             .Column4.Movable         = .F.
5931:             .Column4.Resizable       = .F.
5932:             .Column4.ReadOnly        = .F.
5933:             .Column4.Header1.Caption = "Tarefa"
5934:         ENDWITH
5935: 
5936:         *-- Observacao da Tarefa (Say31 + getObsTarefas legados)
5937:         par_oPagina.AddObject("lbl_4c_Label31", "Label")
5938:         WITH par_oPagina.lbl_4c_Label31
5939:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
5940:             .Top       = 129
5941:             .Left      = 583
5942:             .Width     = 126
5943:             .Height    = 15
5944:             .Alignment = 1
5945:             .BackStyle = 0
5946:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 5952 a 5994:
5952: 
5953:         par_oPagina.AddObject("obj_4c_GetObsTarefas", "EditBox")
5954:         WITH par_oPagina.obj_4c_GetObsTarefas
5955:             .Top           = 145
5956:             .Left          = 584
5957:             .Width         = 407
5958:             .Height        = 113
5959:             .Format        = "K!"
5960:             .SpecialEffect = 1
5961:             .FontName      = "Tahoma"
5962:             .FontSize      = 8
5963:             .Visible       = .T.
5964:         ENDWITH
5965: 
5966:         *-- Botoes Iniciar / Encerrar Tarefa (btnIniTarefa/btnFimTarefa
5967:         *-- legados) - Click depende de crSigPrTar (regra #41)
5968:         par_oPagina.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
5969:         WITH par_oPagina.cmd_4c_BtnIniTarefa
5970:             .Top             = 146
5971:             .Left            = 509
5972:             .Width           = 42
5973:             .Height          = 42
5974:             .Caption         = ""
5975:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
5976:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
5977:             .ToolTipText     = "Iniciar Nova Tarefa"
5978:             .Themes          = .T.
5979:             .Enabled         = .T.
5980:             .Visible         = .T.
5981:         ENDWITH
5982: 
5983:         par_oPagina.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
5984:         WITH par_oPagina.cmd_4c_BtnFimTarefa
5985:             .Top             = 188
5986:             .Left            = 509
5987:             .Width           = 42
5988:             .Height          = 42
5989:             .Caption         = ""
5990:             .Picture         = gc_4c_CaminhoIcones + "geral_datas_26.jpg"
5991:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_26.jpg"
5992:             .ToolTipText     = "Encerrar Tarefa"
5993:             .Themes          = .T.
5994:             .Enabled         = .T.

*-- Linhas 6001 a 6010:
6001:         par_oPagina.AddObject("grd_4c_Arquivos", "Grid")
6002:         par_oPagina.grd_4c_Arquivos.ColumnCount = 1
6003:         WITH par_oPagina.grd_4c_Arquivos
6004:             .Top                = 334
6005:             .Left               = 10
6006:             .Width              = 495
6007:             .Height             = 164
6008:             .FontName           = "Tahoma"
6009:             .FontSize           = 8
6010:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 6026 a 6075:
6026:             .Column1.Movable         = .F.
6027:             .Column1.Resizable       = .F.
6028:             .Column1.ReadOnly        = .T.
6029:             .Column1.Header1.Caption = "Arquivos Para Designer"
6030:         ENDWITH
6031: 
6032:         *-- Botoes Inserir / Abrir / Excluir Arquivo (btnInsArqs/btnOpnArqs/
6033:         *-- btnExcArqs legados) - Click depende de crSigPrArq (regra #41)
6034:         par_oPagina.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
6035:         WITH par_oPagina.cmd_4c_BtnInsArqs
6036:             .Top             = 335
6037:             .Left            = 509
6038:             .Width           = 42
6039:             .Height          = 42
6040:             .Caption         = ""
6041:             .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_26.jpg"
6042:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_arquivo_26.jpg"
6043:             .ToolTipText     = "Inserir Arquivo"
6044:             .Themes          = .T.
6045:             .Enabled         = .T.
6046:             .Visible         = .T.
6047:         ENDWITH
6048: 
6049:         par_oPagina.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
6050:         WITH par_oPagina.cmd_4c_BtnOpnArqs
6051:             .Top             = 419
6052:             .Left            = 509
6053:             .Width           = 42
6054:             .Height          = 42
6055:             .Caption         = ""
6056:             .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
6057:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
6058:             .ToolTipText     = "Abrir Arquivo"
6059:             .Themes          = .T.
6060:             .Enabled         = .T.
6061:             .Visible         = .T.
6062:         ENDWITH
6063: 
6064:         par_oPagina.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
6065:         WITH par_oPagina.cmd_4c_BtnExcArqs
6066:             .Top             = 377
6067:             .Left            = 509
6068:             .Width           = 42
6069:             .Height          = 42
6070:             .Caption         = ""
6071:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
6072:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
6073:             .ToolTipText     = "Excluir Arquivo"
6074:             .Themes          = .T.
6075:             .Enabled         = .T.

*-- Linhas 6081 a 6103:
6081:         *-- (Do Form SigOpZom) depende de crSigPrArq
6082:         par_oPagina.AddObject("img_4c_ImgArqJpg", "Image")
6083:         WITH par_oPagina.img_4c_ImgArqJpg
6084:             .Top         = 402
6085:             .Left        = 586
6086:             .Width       = 403
6087:             .Height      = 198
6088:             .Stretch     = 1
6089:             .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
6090:             .Visible     = .F.
6091:         ENDWITH
6092: 
6093:         *-- Inspiracao (Say1 + getObsInsp legados - crSigCdPro.ObsInsp)
6094:         par_oPagina.AddObject("lbl_4c_Label1", "Label")
6095:         WITH par_oPagina.lbl_4c_Label1
6096:             .Caption   = "Inspira" + CHR(231) + CHR(227) + "o"
6097:             .Top       = 265
6098:             .Left      = 583
6099:             .Width     = 62
6100:             .Height    = 15
6101:             .Alignment = 1
6102:             .BackStyle = 0
6103:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 6109 a 6133:
6109: 
6110:         par_oPagina.AddObject("obj_4c_GetObsInsp", "EditBox")
6111:         WITH par_oPagina.obj_4c_GetObsInsp
6112:             .Top           = 281
6113:             .Left          = 584
6114:             .Width         = 407
6115:             .Height        = 113
6116:             .Format        = "K!"
6117:             .SpecialEffect = 1
6118:             .FontName      = "Tahoma"
6119:             .FontSize      = 8
6120:             .Visible       = .T.
6121:         ENDWITH
6122: 
6123:         *-- Bloco "Dados do Lancamento" (Say19 + Line1 legados)
6124:         par_oPagina.AddObject("lbl_4c_Label19", "Label")
6125:         WITH par_oPagina.lbl_4c_Label19
6126:             .Caption   = "Dados do Lan" + CHR(231) + "amento"
6127:             .Top       = 504
6128:             .Left      = 18
6129:             .Width     = 127
6130:             .Height    = 15
6131:             .Alignment = 1
6132:             .BackStyle = 0
6133:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 6139 a 6231:
6139: 
6140:         par_oPagina.AddObject("lin_4c_Line1", "Line")
6141:         WITH par_oPagina.lin_4c_Line1
6142:             .Top     = 518
6143:             .Left    = 14
6144:             .Width   = 317
6145:             .Height  = 0
6146:             .Visible = .T.
6147:         ENDWITH
6148: 
6149:         *-- Data Apr. Amostra (Say6 + Get_DtAprAmo legados -
6150:         *-- crSigCdPro.DtAprAmo)
6151:         par_oPagina.AddObject("lbl_4c_Label6", "Label")
6152:         WITH par_oPagina.lbl_4c_Label6
6153:             .Caption   = "Data Apr. Amostra :"
6154:             .Top       = 531
6155:             .Left      = 16
6156:             .Width     = 99
6157:             .Height    = 15
6158:             .BackStyle = 0
6159:             .ForeColor = RGB(90, 90, 90)
6160:             .FontName  = "Tahoma"
6161:             .FontSize  = 8
6162:             .Visible   = .T.
6163:         ENDWITH
6164: 
6165:         par_oPagina.AddObject("txt_4c_DtAprAmo", "TextBox")
6166:         WITH par_oPagina.txt_4c_DtAprAmo
6167:             .Top           = 527
6168:             .Left          = 118
6169:             .Width         = 80
6170:             .Height        = 23
6171:             .Value         = {^1900-01-01}
6172:             .SpecialEffect = 1
6173:             .FontName      = "Tahoma"
6174:             .FontSize      = 8
6175:             .Visible       = .T.
6176:         ENDWITH
6177: 
6178:         *-- Desenvolvido por / Criado por (Say4/GetDesLacto e Say5/GetCriaLacto
6179:         *-- legados - lookup SigCdUsu filtrado por Deptos.UtiLacto)
6180:         par_oPagina.AddObject("lbl_4c_Label4", "Label")
6181:         WITH par_oPagina.lbl_4c_Label4
6182:             .Caption   = "Desenvolvido por :"
6183:             .Top       = 556
6184:             .Left      = 23
6185:             .Width     = 92
6186:             .Height    = 15
6187:             .BackStyle = 0
6188:             .ForeColor = RGB(90, 90, 90)
6189:             .FontName  = "Tahoma"
6190:             .FontSize  = 8
6191:             .Visible   = .T.
6192:         ENDWITH
6193: 
6194:         par_oPagina.AddObject("txt_4c_DesLacto", "TextBox")
6195:         WITH par_oPagina.txt_4c_DesLacto
6196:             .Top           = 552
6197:             .Left          = 118
6198:             .Width         = 91
6199:             .Height        = 22
6200:             .MaxLength     = 30
6201:             .Format        = "K!"
6202:             .SpecialEffect = 1
6203:             .FontName      = "Tahoma"
6204:             .FontSize      = 8
6205:             .Visible       = .T.
6206:         ENDWITH
6207:         BINDEVENT(par_oPagina.txt_4c_DesLacto, "KeyPress", THIS, "ValidarDesenvolvidoPorLacto")
6208: 
6209:         par_oPagina.AddObject("lbl_4c_Label5", "Label")
6210:         WITH par_oPagina.lbl_4c_Label5
6211:             .Caption   = "Criado por :"
6212:             .Top       = 580
6213:             .Left      = 56
6214:             .Width     = 59
6215:             .Height    = 15
6216:             .BackStyle = 0
6217:             .ForeColor = RGB(90, 90, 90)
6218:             .FontName  = "Tahoma"
6219:             .FontSize  = 8
6220:             .Visible   = .T.
6221:         ENDWITH
6222: 
6223:         par_oPagina.AddObject("txt_4c_CriaLacto", "TextBox")
6224:         WITH par_oPagina.txt_4c_CriaLacto
6225:             .Top           = 576
6226:             .Left          = 118
6227:             .Width         = 91
6228:             .Height        = 22
6229:             .MaxLength     = 30
6230:             .Format        = "K!"
6231:             .SpecialEffect = 1

*-- Linhas 6241 a 6262:
6241:     *===========================================================================
6242:     * ConfigurarPgpgServico - Sub-pagina "Servicos" (pgServico legado - Page8):
6243:     * grade de servicos vinculados ao produto (crSigPrSer legado), com colunas
6244:     * Servicos/Codigo e checkbox de marcacao na Coluna3 - FASE 15. SEM
6245:     * RecordSource/ControlSource nesta fase (regra #41 CLAUDE.md - cursor
6246:     * ainda nao populado, mesmo estagio dos demais grids desta pagina).
6247:     *===========================================================================
6248:     PROTECTED PROCEDURE ConfigurarPgpgServico()
6249:         LOCAL par_oPagina
6250:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8
6251: 
6252:         *-- Grade de servicos (grdServico legado, 3 colunas)
6253:         par_oPagina.AddObject("grd_4c_Dados", "Grid")
6254:         par_oPagina.grd_4c_Dados.ColumnCount = 3
6255:         WITH par_oPagina.grd_4c_Dados
6256:             .Top                = 171
6257:             .Left               = 339
6258:             .Width              = 320
6259:             .Height             = 387
6260:             .FontName           = "Verdana"
6261:             .FontSize           = 8
6262:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 6274 a 6294:
6274:             .Visible            = .T.
6275: 
6276:             .Column1.Width           = 180
6277:             .Column1.Header1.Caption = "Servi" + CHR(231) + "os"
6278: 
6279:             .Column2.Width           = 90
6280:             .Column2.Header1.Caption = "C" + CHR(243) + "digo"
6281: 
6282:             .Column3.Width           = 50
6283:             .Column3.Header1.Caption = ""
6284:         ENDWITH
6285: 
6286:         *-- Coluna 3 (checkbox de marcacao, sem legenda no legado): AddObject +
6287:         *-- CurrentControl obrigatorios para o checkbox aparecer (regra #18
6288:         *-- CLAUDE.md)
6289:         par_oPagina.grd_4c_Dados.Column3.AddObject("chk_4c_Marcado", "CheckBox")
6290:         WITH par_oPagina.grd_4c_Dados.Column3
6291:             .CurrentControl = "chk_4c_Marcado"
6292:             .Sparse         = .F.
6293:         ENDWITH
6294: 

*-- Linhas 6990 a 7021:
6990:         *-- = .T., que resulta nestes mesmos 610 x 85 - aqui fica deterministico)
6991:         WITH par_oPagina.opt_4c_Navegacao
6992:             .ButtonCount   = 8
6993:             .Top           = 32
6994:             .Left          = 8
6995:             .Width         = 615
6996:             .Height        = 85
6997:             .BackStyle     = 0
6998:             .BorderStyle   = 0
6999:             .SpecialEffect = 1
7000:             .AutoSize      = .F.
7001:             .Value         = 1
7002:             .Visible       = .T.
7003:         ENDWITH
7004: 
7005:         *-- Botao 1: Principal -> aba pgDados
7006:         WITH par_oPagina.opt_4c_Navegacao.Buttons(1)
7007:             .Caption       = "\<Principal"
7008:             .BackStyle = 0
7009:             .Picture       = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
7010:             .Top           = 5
7011:             .Left          = 5
7012:             .Width         = 75
7013:             .Height        = 75
7014:             .Style         = 1
7015:             .FontName      = "Comic Sans MS"
7016:             .FontSize      = 8
7017:             .FontBold      = .T.
7018:             .FontItalic    = .T.
7019:             .ForeColor     = RGB(90, 90, 90)
7020:             .BackColor     = RGB(255, 255, 255)
7021:             .Themes        = .F.

*-- Linhas 7027 a 7044:
7027: 
7028:         *-- Botao 2: Componente -> aba pgComposicao
7029:         WITH par_oPagina.opt_4c_Navegacao.Buttons(2)
7030:             .Caption       = "Componen\<te"
7031:             .BackStyle = 0
7032:             .Picture       = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
7033:             .Top           = 5
7034:             .Left          = 80
7035:             .Width         = 75
7036:             .Height        = 75
7037:             .Style         = 1
7038:             .FontName      = "Comic Sans MS"
7039:             .FontSize      = 8
7040:             .FontBold      = .T.
7041:             .FontItalic    = .T.
7042:             .ForeColor     = RGB(90, 90, 90)
7043:             .BackColor     = RGB(255, 255, 255)
7044:             .Themes        = .F.

*-- Linhas 7050 a 7067:
7050: 
7051:         *-- Botao 3: Custo -> aba pgCusto (6a aba; o legado desenha em Left=380)
7052:         WITH par_oPagina.opt_4c_Navegacao.Buttons(3)
7053:             .Caption       = "C\<usto"
7054:             .BackStyle = 0
7055:             .Picture       = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
7056:             .Top           = 5
7057:             .Left          = 380
7058:             .Width         = 75
7059:             .Height        = 75
7060:             .Style         = 1
7061:             .FontName      = "Comic Sans MS"
7062:             .FontSize      = 8
7063:             .FontBold      = .T.
7064:             .FontItalic    = .T.
7065:             .ForeColor     = RGB(90, 90, 90)
7066:             .BackColor     = RGB(255, 255, 255)
7067:             .Themes        = .F.

*-- Linhas 7073 a 7090:
7073: 
7074:         *-- Botao 4: Fiscal -> aba pgDadosFiscais
7075:         WITH par_oPagina.opt_4c_Navegacao.Buttons(4)
7076:             .Caption       = "\<Fiscal"
7077:             .BackStyle = 0
7078:             .Picture       = gc_4c_CaminhoIcones + "geral_nota_60.jpg"
7079:             .Top           = 5
7080:             .Left          = 155
7081:             .Width         = 75
7082:             .Height        = 75
7083:             .Style         = 1
7084:             .FontName      = "Comic Sans MS"
7085:             .FontSize      = 8
7086:             .FontBold      = .T.
7087:             .FontItalic    = .T.
7088:             .ForeColor     = RGB(90, 90, 90)
7089:             .BackColor     = RGB(255, 255, 255)
7090:             .Themes        = .F.

*-- Linhas 7096 a 7113:
7096: 
7097:         *-- Botao 5: Processo -> aba PgDadosFaseP
7098:         WITH par_oPagina.opt_4c_Navegacao.Buttons(5)
7099:             .Caption       = "P\<rocesso"
7100:             .BackStyle = 0
7101:             .Picture       = gc_4c_CaminhoIcones + "geral_cronometro_60.jpg"
7102:             .Top           = 5
7103:             .Left          = 230
7104:             .Width         = 75
7105:             .Height        = 75
7106:             .Style         = 1
7107:             .FontName      = "Comic Sans MS"
7108:             .FontSize      = 8
7109:             .FontBold      = .T.
7110:             .FontItalic    = .T.
7111:             .ForeColor     = RGB(90, 90, 90)
7112:             .BackColor     = RGB(255, 255, 255)
7113:             .Themes        = .F.

*-- Linhas 7119 a 7136:
7119: 
7120:         *-- Botao 6: Consumo -> aba PgDadosConsP
7121:         WITH par_oPagina.opt_4c_Navegacao.Buttons(6)
7122:             .Caption       = "Co\<nsumo"
7123:             .BackStyle = 0
7124:             .Picture       = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
7125:             .Top           = 5
7126:             .Left          = 305
7127:             .Width         = 75
7128:             .Height        = 75
7129:             .Style         = 1
7130:             .FontName      = "Comic Sans MS"
7131:             .FontSize      = 8
7132:             .FontBold      = .T.
7133:             .FontItalic    = .T.
7134:             .ForeColor     = RGB(90, 90, 90)
7135:             .BackColor     = RGB(255, 255, 255)
7136:             .Themes        = .F.

*-- Linhas 7142 a 7159:
7142: 
7143:         *-- Botao 7: Designer -> aba pgDesigner
7144:         WITH par_oPagina.opt_4c_Navegacao.Buttons(7)
7145:             .Caption       = "\<Designer"
7146:             .BackStyle = 0
7147:             .Picture       = gc_4c_CaminhoIcones + "geral_cores_60.jpg"
7148:             .Top           = 5
7149:             .Left          = 455
7150:             .Width         = 75
7151:             .Height        = 75
7152:             .Style         = 1
7153:             .FontName      = "Comic Sans MS"
7154:             .FontSize      = 8
7155:             .FontBold      = .T.
7156:             .FontItalic    = .T.
7157:             .ForeColor     = RGB(90, 90, 90)
7158:             .BackColor     = RGB(255, 255, 255)
7159:             .Themes        = .F.

*-- Linhas 7165 a 7182:
7165: 
7166:         *-- Botao 8: Servico -> aba pgServico
7167:         WITH par_oPagina.opt_4c_Navegacao.Buttons(8)
7168:             .Caption       = "\<Servi" + CHR(231) + "o"
7169:             .BackStyle = 0
7170:             .Picture       = gc_4c_CaminhoIcones + "geral_lapis_60.jpg"
7171:             .Top           = 5
7172:             .Left          = 530
7173:             .Width         = 75
7174:             .Height        = 75
7175:             .Style         = 1
7176:             .FontName      = "Comic Sans MS"
7177:             .FontSize      = 8
7178:             .FontBold      = .T.
7179:             .FontItalic    = .T.
7180:             .ForeColor     = RGB(90, 90, 90)
7181:             .BackColor     = RGB(255, 255, 255)
7182:             .Themes        = .F.

*-- Linhas 7768 a 7788:
7768:             loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
7769: 
7770:             *-- Botoes CRUD da pagina Lista
7771:             loc_oBotoes.cmd_4c_Incluir.Enabled    = loc_lLista
7772:             loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lLista
7773:             loc_oBotoes.cmd_4c_Alterar.Enabled    = loc_lLista
7774:             loc_oBotoes.cmd_4c_Excluir.Enabled    = loc_lLista
7775:             loc_oBotoes.cmd_4c_Buscar.Enabled     = loc_lLista
7776: 
7777:             *-- Confirmar so quando ha algo a confirmar; Cancelar sempre ativo
7778:             loc_oAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
7779:             loc_oAcao.cmd_4c_Cancelar.Enabled  = .T.
7780: 
7781:             *-- Confirmar muda de rotulo quando esta procurando (o legado troca
7782:             *-- a acao do mesmo botao em msv_procurar)
7783:             loc_oAcao.cmd_4c_Confirmar.Caption = ;
7784:                 IIF(THIS.this_cModoAtual == "BUSCAR", "Procurar", "Confirmar")
7785: 
7786:         CATCH TO loException
7787:             MostrarErro("Erro ao ajustar os bot" + CHR(245) + "es:" + CHR(13) + ;
7788:                 loException.Message, "FormProduto.AjustarBotoesPorModo")

*-- Linhas 8177 a 8191:
8177:             loc_oGrid.Column6.Width = 100
8178:             loc_oGrid.Column7.Width = 30
8179: 
8180:             loc_oGrid.Column1.Header1.Caption = "Produto"
8181:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
8182:             loc_oGrid.Column3.Header1.Caption = "Grupo"
8183:             loc_oGrid.Column4.Header1.Caption = "Subgrp."
8184:             loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
8185:             loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
8186:             loc_oGrid.Column7.Header1.Caption = "I"
8187: 
8188:             THIS.FormatarGridLista(loc_oGrid)
8189:             THIS.AtualizarContadorProdutos()
8190: 
8191:             loc_oGrid.Refresh()

