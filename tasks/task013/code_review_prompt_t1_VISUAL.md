# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [ALINHAMENTO] Botao 'cmd_4c_IniTarefa' tem Top=161 mas grupo usa Top=168 (diferenca de 7px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (12589 linhas total):

*-- Linhas 54 a 62:
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.ConfigurarPaginaLista()
56:                 THIS.ConfigurarPaginaDados()
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58: 
59:                 *-- Guards LostFocus: evita reabrir lookup se valor nao mudou
60:                 THIS.this_cUltimoTxtTamLostFocusValidado       = ""
61:                 THIS.this_cUltimoTxtCorLostFocusValidado       = ""
62:                 THIS.this_cUltimoTxtConquilhaLostFocusValidado = ""

*-- Linhas 92 a 120:
92: 
93:     *--------------------------------------------------------------------------
94:     * ConfigurarPageFrame - Configura o PageFrame principal
95:     * Legado: Pagina Width=1003, PageFrame.Top=-29 (oculta abas)
96:     *--------------------------------------------------------------------------
97:     PROTECTED PROCEDURE ConfigurarPageFrame()
98:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
99: 
100:         WITH THIS.pgf_4c_Paginas
101:             .Top       = -29
102:             .Left      = 0
103:             .Width     = 1003
104:             .Height    = 600
105:             .PageCount = 2
106:             .Tabs      = .F.
107:             .Visible   = .T.
108: 
109:             *-- Page1 - Lista
110:             .Page1.Caption   = "Lista"
111:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:             .Page1.BackColor = RGB(255, 255, 255)
113: 
114:             *-- Page2 - Dados
115:             .Page2.Caption   = "Dados"
116:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117:             .Page2.BackColor = RGB(255, 255, 255)
118:         ENDWITH
119:     ENDPROC
120: 

*-- Linhas 130 a 169:
130:         *-- Container de cabecalho (cntSombra: Top=2 -> 31)
131:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
132:         WITH loc_oPagina.cnt_4c_Cabecalho
133:             .Top         = 31
134:             .Left        = 0
135:             .Width       = 1020
136:             .Height      = 80
137:             .BackStyle   = 1
138:             .BackColor   = RGB(53, 53, 53)
139:             .BorderWidth = 0
140:             .Visible     = .T.
141:         ENDWITH
142: 
143:         *-- Sombra do titulo (lbl_4c_Sombra: Top=15, Left=10)
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
146:             .Caption   = "Cadastro de Produtos"
147:             .Top       = 17
148:             .Left      = 12
149:             .Width     = 769
150:             .Height    = 40
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .BackStyle = 0
155:             .ForeColor = RGB(0, 0, 0)
156:             .Visible   = .T.
157:         ENDWITH
158: 
159:         *-- Titulo do cabecalho (lbl_4c_Titulo: Top=18, Left=10)
160:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
161:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
162:             .Caption   = "Cadastro de Produtos"
163:             .Top       = 15
164:             .Left      = 10
165:             .Width     = 769
166:             .Height    = 46
167:             .FontName  = "Tahoma"
168:             .FontSize  = 16
169:             .FontBold  = .T.

*-- Linhas 175 a 357:
175:         *-- Container de botoes CRUD (Grupo_op: Left=542, Top=0 -> 29)
176:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
177:         WITH loc_oPagina.cnt_4c_Botoes
178:             .Top         = 29
179:             .Left        = 542
180:             .Width       = 390
181:             .Height      = 85
182:             .BackStyle = 1
183:             .BackColor = RGB(53, 53, 53)
184:             .BorderWidth = 0
185:             .Visible     = .T.
186:         ENDWITH
187: 
188:         *-- Botao Incluir (Left=5)
189:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
190:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
191:             .Caption         = "Incluir"
192:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
193:             .PicturePosition = 13
194:             .Width           = 75
195:             .Height          = 75
196:             .Left            = 5
197:             .Top             = 5
198:             .FontName        = "Tahoma"
199:             .FontSize        = 8
200:             .Themes          = .F.
201:             .SpecialEffect   = 0
202:             .BackColor       = RGB(255, 255, 255)
203:             .ForeColor       = RGB(90, 90, 90)
204:             .Visible         = .T.
205:         ENDWITH
206:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
207: 
208:         *-- Botao Visualizar (Left=80)
209:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
210:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
211:             .Caption         = "Visualizar"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
213:             .PicturePosition = 13
214:             .Width           = 75
215:             .Height          = 75
216:             .Left            = 80
217:             .Top             = 5
218:             .FontName        = "Tahoma"
219:             .FontSize        = 8
220:             .Themes          = .F.
221:             .SpecialEffect   = 0
222:             .BackColor       = RGB(255, 255, 255)
223:             .ForeColor       = RGB(90, 90, 90)
224:             .Visible         = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
227: 
228:         *-- Botao Alterar (Left=155)
229:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
230:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
231:             .Caption         = "Alterar"
232:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
233:             .PicturePosition = 13
234:             .Width           = 75
235:             .Height          = 75
236:             .Left            = 155
237:             .Top             = 5
238:             .FontName        = "Tahoma"
239:             .FontSize        = 8
240:             .Themes          = .F.
241:             .SpecialEffect   = 0
242:             .BackColor       = RGB(255, 255, 255)
243:             .ForeColor       = RGB(90, 90, 90)
244:             .Visible         = .T.
245:         ENDWITH
246:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
247: 
248:         *-- Botao Excluir (Left=230)
249:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
250:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
251:             .Caption         = "Excluir"
252:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
253:             .PicturePosition = 13
254:             .Width           = 75
255:             .Height          = 75
256:             .Left            = 230
257:             .Top             = 5
258:             .FontName        = "Tahoma"
259:             .FontSize        = 8
260:             .Themes          = .F.
261:             .SpecialEffect   = 0
262:             .BackColor       = RGB(255, 255, 255)
263:             .ForeColor       = RGB(90, 90, 90)
264:             .Visible         = .T.
265:         ENDWITH
266:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
267: 
268:         *-- Botao Buscar (Left=305)
269:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
270:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
271:             .Caption         = "Buscar"
272:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
273:             .PicturePosition = 13
274:             .Width           = 75
275:             .Height          = 75
276:             .Left            = 305
277:             .Top             = 5
278:             .FontName        = "Tahoma"
279:             .FontSize        = 8
280:             .Themes          = .F.
281:             .SpecialEffect   = 0
282:             .BackColor       = RGB(255, 255, 255)
283:             .ForeColor       = RGB(90, 90, 90)
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
287: 
288:         *-- Container de saida (Grupo_Saida: Left=935, Top=0 -> 29)
289:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
290:         WITH loc_oPagina.cnt_4c_Saida
291:             .Top         = 29
292:             .Left        = 935
293:             .Width       = 60
294:             .Height      = 85
295:             .BackStyle = 1
296:             .BackColor = RGB(53, 53, 53)
297:             .BorderWidth = 0
298:             .Visible     = .T.
299:         ENDWITH
300: 
301:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
302:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
303:             .Caption         = "X"
304:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
305:             .PicturePosition = 13
306:             .Width           = 50
307:             .Height          = 75
308:             .Left            = 5
309:             .Top             = 5
310:             .FontName        = "Tahoma"
311:             .FontSize        = 8
312:             .Themes          = .F.
313:             .SpecialEffect   = 0
314:             .BackColor       = RGB(255, 255, 255)
315:             .ForeColor       = RGB(90, 90, 90)
316:             .Visible         = .T.
317:         ENDWITH
318:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
319: 
320:         *-- Container de filtros (cntFiltros: Top=116, Left=5, com +29 de compensacao)
321:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
322:         WITH loc_oPagina.cnt_4c_Filtros
323:             .Top         = 116
324:             .Left        = 5
325:             .Width       = 535
326:             .Height      = 65
327:             .BackStyle   = 1
328:             .BackColor   = RGB(245, 245, 245)
329:             .BorderWidth = 1
330:             .Visible     = .T.
331:         ENDWITH
332: 
333:         *-- Label "Grupo de Produto:"
334:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
335:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
336:             .Caption   = "Grupo de Produto:"
337:             .Top       = 18
338:             .Left      = 5
339:             .Width     = 110
340:             .Height    = 15
341:             .FontName  = "Tahoma"
342:             .FontSize  = 8
343:             .BackStyle = 0
344:             .ForeColor = RGB(60, 60, 60)
345:             .Visible   = .T.
346:         ENDWITH
347: 
348:         *-- getCgru -> txt_4c_Cgru (codigo do grupo, F4 abre lookup)
349:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Cgru", "TextBox")
350:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru
351:             .Top      = 14
352:             .Left     = 116
353:             .Width    = 31
354:             .Height   = 23
355:             .FontName = "Tahoma"
356:             .FontSize = 8
357:             .Value    = ""

*-- Linhas 363 a 478:
363:         *-- getDgru -> txt_4c_Dgru (descricao do grupo, somente leitura)
364:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Dgru", "TextBox")
365:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru
366:             .Top      = 14
367:             .Left     = 149
368:             .Width    = 154
369:             .Height   = 23
370:             .FontName = "Tahoma"
371:             .FontSize = 8
372:             .Value    = ""
373:             .ReadOnly = .T.
374:             .Visible  = .T.
375:         ENDWITH
376: 
377:         *-- Label "Ultima Alteracao:"
378:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData1", "Label")
379:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData1
380:             .Caption   = CHR(218) + "lt. Altera" + CHR(231) + CHR(227) + "o:"
381:             .Top       = 43
382:             .Left      = 5
383:             .Width     = 110
384:             .Height    = 15
385:             .FontName  = "Tahoma"
386:             .FontSize  = 8
387:             .BackStyle = 0
388:             .ForeColor = RGB(60, 60, 60)
389:             .Visible   = .T.
390:         ENDWITH
391: 
392:         *-- getDtIni -> txt_4c_DtIni (data inicial do filtro de alteracao)
393:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtIni", "TextBox")
394:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni
395:             .Top      = 39
396:             .Left     = 116
397:             .Width    = 85
398:             .Height   = 23
399:             .FontName = "Tahoma"
400:             .FontSize = 8
401:             .Value    = ""
402:             .Visible  = .T.
403:         ENDWITH
404: 
405:         *-- Label "a"
406:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData2", "Label")
407:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData2
408:             .Caption   = "a"
409:             .Top       = 43
410:             .Left      = 203
411:             .Width     = 15
412:             .Height    = 15
413:             .FontName  = "Tahoma"
414:             .FontSize  = 8
415:             .BackStyle = 0
416:             .ForeColor = RGB(60, 60, 60)
417:             .Visible   = .T.
418:         ENDWITH
419: 
420:         *-- getDtFim -> txt_4c_DtFim (data final do filtro de alteracao)
421:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtFim", "TextBox")
422:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtFim
423:             .Top      = 39
424:             .Left     = 220
425:             .Width    = 85
426:             .Height   = 23
427:             .FontName = "Tahoma"
428:             .FontSize = 8
429:             .Value    = ""
430:             .Visible  = .T.
431:         ENDWITH
432: 
433:         *-- optFilSituas -> opt_4c_Situas (1=Todos, 2=Ativos, 3=Inativos)
434:         loc_oPagina.cnt_4c_Filtros.AddObject("opt_4c_Situas", "OptionGroup")
435:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_Situas
436:             .Top         = 15
437:             .Left        = 348
438:             .Width       = 182
439:             .Height      = 20
440:             .ButtonCount = 3
441:             .Value       = 1
442:             .BorderStyle = 0
443:             .Visible     = .T.
444:         ENDWITH
445: 
446:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_Situas
447:             .Buttons(1).Caption   = "Todos"
448:             .Buttons(1).Left      = 0
449:             .Buttons(1).Top       = 0
450:             .Buttons(1).Width     = 55
451:             .Buttons(1).Height    = 18
452:             .Buttons(1).FontName  = "Tahoma"
453:             .Buttons(1).FontSize  = 8
454:             .Buttons(1).ForeColor = RGB(60, 60, 60)
455:             .Buttons(1).BackStyle = 0
456:             .Buttons(1).Themes    = .F.
457:             .Buttons(1).AutoSize  = .F.
458: 
459:             .Buttons(2).Caption   = "Ativos"
460:             .Buttons(2).Left      = 60
461:             .Buttons(2).Top       = 0
462:             .Buttons(2).Width     = 55
463:             .Buttons(2).Height    = 18
464:             .Buttons(2).FontName  = "Tahoma"
465:             .Buttons(2).FontSize  = 8
466:             .Buttons(2).ForeColor = RGB(60, 60, 60)
467:             .Buttons(2).BackStyle = 0
468:             .Buttons(2).Themes    = .F.
469:             .Buttons(2).AutoSize  = .F.
470: 
471:             .Buttons(3).Caption   = "Inativos"
472:             .Buttons(3).Left      = 120
473:             .Buttons(3).Top       = 0
474:             .Buttons(3).Width     = 62
475:             .Buttons(3).Height    = 18
476:             .Buttons(3).FontName  = "Tahoma"
477:             .Buttons(3).FontSize  = 8
478:             .Buttons(3).ForeColor = RGB(60, 60, 60)

*-- Linhas 501 a 510:
501:         *----------------------------------------------------------------------
502:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
503:         WITH loc_oPagina.grd_4c_Lista
504:             .Top         = 183
505:             .Left        = 5
506:             .Width       = 950
507:             .Height      = 389
508:             .ColumnCount = 7
509:             .Visible     = .T.
510:             .RecordMark   = .F.

*-- Linhas 518 a 566:
518:         loc_oPagina.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.cpros"
519:         loc_oPagina.grd_4c_Lista.Column1.Width            = 70
520:         loc_oPagina.grd_4c_Lista.Column1.ReadOnly         = .T.
521:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption  = "Produto"
522: 
523:         loc_oPagina.grd_4c_Lista.Column2.ControlSource   = "cursor_4c_Dados.dpros"
524:         loc_oPagina.grd_4c_Lista.Column2.Width            = 315
525:         loc_oPagina.grd_4c_Lista.Column2.ReadOnly         = .T.
526:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
527: 
528:         loc_oPagina.grd_4c_Lista.Column3.ControlSource   = "cursor_4c_Dados.cgrus"
529:         loc_oPagina.grd_4c_Lista.Column3.Width            = 55
530:         loc_oPagina.grd_4c_Lista.Column3.ReadOnly         = .T.
531:         loc_oPagina.grd_4c_Lista.Column3.Header1.Caption  = "Grupo"
532: 
533:         loc_oPagina.grd_4c_Lista.Column4.ControlSource   = "cursor_4c_Dados.sgrus"
534:         loc_oPagina.grd_4c_Lista.Column4.Width            = 70
535:         loc_oPagina.grd_4c_Lista.Column4.ReadOnly         = .T.
536:         loc_oPagina.grd_4c_Lista.Column4.Header1.Caption  = "Subgrp."
537: 
538:         loc_oPagina.grd_4c_Lista.Column5.ControlSource   = "cursor_4c_Dados.reffs"
539:         loc_oPagina.grd_4c_Lista.Column5.Width            = 225
540:         loc_oPagina.grd_4c_Lista.Column5.ReadOnly         = .T.
541:         loc_oPagina.grd_4c_Lista.Column5.Header1.Caption  = "Ref. Fornecedor"
542: 
543:         loc_oPagina.grd_4c_Lista.Column6.ControlSource   = "cursor_4c_Dados.usuaalts"
544:         loc_oPagina.grd_4c_Lista.Column6.Width            = 150
545:         loc_oPagina.grd_4c_Lista.Column6.ReadOnly         = .T.
546:         loc_oPagina.grd_4c_Lista.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"
547: 
548:         loc_oPagina.grd_4c_Lista.Column7.ControlSource   = "cursor_4c_Dados.situas"
549:         loc_oPagina.grd_4c_Lista.Column7.Width            = 30
550:         loc_oPagina.grd_4c_Lista.Column7.ReadOnly         = .T.
551:         loc_oPagina.grd_4c_Lista.Column7.Header1.Caption  = "I"
552: 
553:         *-- Formatacao padrao (Verdana 8, gridlines, RowHeight=16)
554:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
555: 
556:         *-- Label de contagem de produtos (lblProdutos: Top=584 + 29 = 613 -> 575)
557:         loc_oPagina.AddObject("lbl_4c_Contagem", "Label")
558:         WITH loc_oPagina.lbl_4c_Contagem
559:             .Caption   = "Produtos Selecionados : 0"
560:             .Top       = 575
561:             .Left      = 38
562:             .Width     = 200
563:             .Height    = 15
564:             .FontName  = "Tahoma"
565:             .FontSize  = 8
566:             .BackStyle = 0

*-- Linhas 584 a 700:
584:         *-- Container de botoes de acao (Grupo_Salva: Top=4 -> 33, Left=842)
585:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
586:         WITH loc_oPagina.cnt_4c_BotoesAcao
587:             .Top         = 33
588:             .Left        = 842
589:             .Width       = 160
590:             .Height      = 85
591:             .BackStyle = 1
592:             .BackColor = RGB(53, 53, 53)
593:             .BorderWidth = 0
594:             .Visible     = .T.
595:         ENDWITH
596: 
597:         *-- Botao Salvar (Left=5)
598:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
599:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
600:             .Caption         = "Salvar"
601:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
602:             .PicturePosition = 13
603:             .Width           = 75
604:             .Height          = 75
605:             .Left            = 5
606:             .Top             = 5
607:             .FontName        = "Tahoma"
608:             .FontSize        = 8
609:             .Themes          = .F.
610:             .SpecialEffect   = 0
611:             .BackColor       = RGB(255, 255, 255)
612:             .ForeColor       = RGB(90, 90, 90)
613:             .Visible         = .T.
614:         ENDWITH
615:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
616: 
617:         *-- Botao Cancelar (Left=80)
618:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
619:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
620:             .Caption         = "Cancelar"
621:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
622:             .PicturePosition = 13
623:             .Width           = 75
624:             .Height          = 75
625:             .Left            = 80
626:             .Top             = 5
627:             .FontName        = "Tahoma"
628:             .FontSize        = 8
629:             .Themes          = .F.
630:             .SpecialEffect   = 0
631:             .BackColor       = RGB(255, 255, 255)
632:             .ForeColor       = RGB(90, 90, 90)
633:             .Visible         = .T.
634:         ENDWITH
635:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
636: 
637:         *----------------------------------------------------------------------
638:         *-- PageFrame interno com 7 abas de dados
639:         *-- Legado: pgframeDados Top=-54, Left=-1, Width=1003, Height=656
640:         *-- Compensacao outer PF (-29) + inner PF (-54) = total -83 para controles internos
641:         *-- Top relativo a Page2: -54 + 29 = -25
642:         *----------------------------------------------------------------------
643:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
644:         loc_oPgfDados = loc_oPagina.pgf_4c_Dados
645: 
646:         WITH loc_oPgfDados
647:             .Top       = -25
648:             .Left      = -1
649:             .Width     = 1003
650:             .Height    = 656
651:             .PageCount = 7
652:             .Tabs      = .T.
653:             .Visible   = .T.
654:             .TabStyle  = 0
655:         ENDWITH
656: 
657:         *-- Aba 1: Dados Gerais (pgDados)
658:         WITH loc_oPgfDados.Page1
659:             .Caption   = "Dados"
660:             .BackColor = RGB(255, 255, 255)
661:         ENDWITH
662: 
663:         *-- Aba 2: Composicao (pgComposicao)
664:         WITH loc_oPgfDados.Page2
665:             .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
666:             .BackColor = RGB(255, 255, 255)
667:         ENDWITH
668: 
669:         *-- Aba 3: Dados Fiscais (pgDadosFiscais)
670:         WITH loc_oPgfDados.Page3
671:             .Caption   = "Dados Fiscais"
672:             .BackColor = RGB(255, 255, 255)
673:         ENDWITH
674: 
675:         *-- Aba 4: Fases de Producao (PgDadosFaseP)
676:         WITH loc_oPgfDados.Page4
677:             .Caption   = "Fases Prod."
678:             .BackColor = RGB(255, 255, 255)
679:         ENDWITH
680: 
681:         *-- Aba 5: Consulta de Componentes (PgDadosConsP)
682:         WITH loc_oPgfDados.Page5
683:             .Caption   = "Consulta Comp."
684:             .BackColor = RGB(255, 255, 255)
685:         ENDWITH
686: 
687:         *-- Aba 6: Custo (pgCusto)
688:         WITH loc_oPgfDados.Page6
689:             .Caption   = "Custo"
690:             .BackColor = RGB(255, 255, 255)
691:         ENDWITH
692: 
693:         *-- Aba 7: Designer (pgDesigner)
694:         WITH loc_oPgfDados.Page7
695:             .Caption   = "Designer"
696:             .BackColor = RGB(255, 255, 255)
697:         ENDWITH
698: 
699:         *-- Configurar campos da aba Dados (Fase 5: primeiros 50%)
700:         THIS.ConfigurarPgDados()

*-- Linhas 780 a 805:
780:         *-- Say4: "Obs. da OF :" (T:300 L:36 W:64)
781:         *-- getObsOFs: (T:297 L:99 W:850 H:21)
782:         *----------------------------------------------------------------------
783:         loc_oPg.AddObject("lbl_4c_ObsOF", "Label")
784:         WITH loc_oPg.lbl_4c_ObsOF
785:             .Caption   = "Obs. da OF :"
786:             .Top       = 300
787:             .Left      = 36
788:             .Width     = 64
789:             .Height    = 15
790:             .FontName  = "Tahoma"
791:             .FontSize  = 8
792:             .BackStyle = 0
793:             .ForeColor = RGB(90, 90, 90)
794:             .Visible   = .T.
795:         ENDWITH
796: 
797:         loc_oPg.AddObject("txt_4c_ObsOFs", "TextBox")
798:         WITH loc_oPg.txt_4c_ObsOFs
799:             .Top           = 297
800:             .Left          = 99
801:             .Width         = 850
802:             .Height        = 21
803:             .FontName      = "Tahoma"
804:             .FontSize      = 8
805:             .MaxLength     = 254

*-- Linhas 815 a 869:
815:         *-- Say15: "Material Principal :" (T:324 L:421 W:89)
816:         *-- Get_MatP: (T:321 L:517 W:108 H:21) - com lookup
817:         *----------------------------------------------------------------------
818:         loc_oPg.AddObject("lbl_4c_LblDesc", "Label")
819:         WITH loc_oPg.lbl_4c_LblDesc
820:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
821:             .Top       = 324
822:             .Left      = 45
823:             .Width     = 55
824:             .Height    = 15
825:             .FontName  = "Tahoma"
826:             .FontSize  = 8
827:             .BackStyle = 0
828:             .ForeColor = RGB(90, 90, 90)
829:             .Visible   = .T.
830:         ENDWITH
831: 
832:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
833:         WITH loc_oPg.txt_4c_Desc
834:             .Top           = 321
835:             .Left          = 99
836:             .Width         = 298
837:             .Height        = 21
838:             .FontName      = "Tahoma"
839:             .FontSize      = 8
840:             .MaxLength     = 65
841:             .Value         = ""
842:             .SpecialEffect = 1
843:             .Enabled       = .F.
844:             .Visible       = .T.
845:         ENDWITH
846: 
847:         loc_oPg.AddObject("lbl_4c_LblMatP", "Label")
848:         WITH loc_oPg.lbl_4c_LblMatP
849:             .Caption   = "Material Principal :"
850:             .Top       = 324
851:             .Left      = 421
852:             .Width     = 89
853:             .Height    = 15
854:             .FontName  = "Tahoma"
855:             .FontSize  = 8
856:             .BackStyle = 0
857:             .ForeColor = RGB(90, 90, 90)
858:             .Visible   = .T.
859:         ENDWITH
860: 
861:         loc_oPg.AddObject("txt_4c_MatP", "TextBox")
862:         WITH loc_oPg.txt_4c_MatP
863:             .Top           = 321
864:             .Left          = 517
865:             .Width         = 108
866:             .Height        = 21
867:             .FontName      = "Tahoma"
868:             .FontSize      = 8
869:             .MaxLength     = 14

*-- Linhas 881 a 890:
881:         *----------------------------------------------------------------------
882:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
883:         WITH loc_oPg.grd_4c_Compo
884:             .Top         = 148
885:             .Left        = 6
886:             .Width       = 943
887:             .Height      = 147
888:             .ColumnCount = 14
889:             .FontName    = "Verdana"
890:             .FontSize    = 8

*-- Linhas 911 a 1117:
911:         *-- Configurar colunas do grd_4c_Compo APOS RecordSource
912:         WITH loc_oPg.grd_4c_Compo
913:             *-- Col1: Material (C14) W:80
914:             .Column1.Header1.Caption       = "Material"
915:             .Column1.Width                 = 80
916:             .Column1.ControlSource         = "cursor_4c_Compo.mats"
917:             .Column1.Alignment             = 0
918: 
919:             *-- Col2: Descricao (C65) W:200
920:             .Column2.Header1.Caption       = "Descri" + CHR(231) + CHR(227) + "o"
921:             .Column2.Width                 = 200
922:             .Column2.ControlSource         = "cursor_4c_Compo.dcomps"
923:             .Column2.Alignment             = 0
924: 
925:             *-- Col3: Un (C5) W:35 - readonly
926:             .Column3.Header1.Caption       = "Un"
927:             .Column3.Width                 = 35
928:             .Column3.ControlSource         = "cursor_4c_Compo.unicompos"
929:             .Column3.ReadOnly              = .T.
930: 
931:             *-- Col4: Valor (N) W:65
932:             .Column4.Header1.Caption       = "Valor"
933:             .Column4.Width                 = 65
934:             .Column4.ControlSource         = "cursor_4c_Compo.pcompos"
935:             .Column4.Alignment             = 1
936: 
937:             *-- Col5: Qtde (N) W:60
938:             .Column5.Header1.Caption       = "Qtde."
939:             .Column5.Width                 = 60
940:             .Column5.ControlSource         = "cursor_4c_Compo.qtds"
941:             .Column5.Alignment             = 1
942: 
943:             *-- Col6: Total (N) W:65 - readonly (calculado)
944:             .Column6.Header1.Caption       = "Total"
945:             .Column6.Width                 = 65
946:             .Column6.ControlSource         = "cursor_4c_Compo.totals"
947:             .Column6.Alignment             = 1
948:             .Column6.ReadOnly              = .T.
949: 
950:             *-- Col7: Moe (C5) W:35
951:             .Column7.Header1.Caption       = "Moe"
952:             .Column7.Width                 = 35
953:             .Column7.ControlSource         = "cursor_4c_Compo.bloqueio"
954: 
955:             *-- Col8: Observacao (C40) W:100
956:             .Column8.Header1.Caption       = "Observa" + CHR(231) + CHR(227) + "o"
957:             .Column8.Width                 = 100
958:             .Column8.ControlSource         = "cursor_4c_Compo.obscompos"
959:             .Column8.Alignment             = 0
960: 
961:             *-- Col9: E (C1) W:25
962:             .Column9.Header1.Caption       = "E"
963:             .Column9.Width                 = 25
964:             .Column9.ControlSource         = "cursor_4c_Compo.etiq"
965: 
966:             *-- Col10: Consumo (N) W:65
967:             .Column10.Header1.Caption      = "Consumo"
968:             .Column10.Width                = 65
969:             .Column10.ControlSource        = "cursor_4c_Compo.consumo"
970:             .Column10.Alignment            = 1
971: 
972:             *-- Col11: Qtde cons (N) W:60
973:             .Column11.Header1.Caption      = "Qtde."
974:             .Column11.Width                = 60
975:             .Column11.ControlSource        = "cursor_4c_Compo.qtd2"
976:             .Column11.Alignment            = 1
977: 
978:             *-- Col12: Un cons (C5) W:35 - readonly
979:             .Column12.Header1.Caption      = "Un"
980:             .Column12.Width                = 35
981:             .Column12.ControlSource        = "cursor_4c_Compo.uni2"
982:             .Column12.ReadOnly             = .T.
983: 
984:             *-- Col13: Ord (N) W:35
985:             .Column13.Header1.Caption      = "Ord"
986:             .Column13.Width                = 35
987:             .Column13.ControlSource        = "cursor_4c_Compo.ord"
988:             .Column13.Alignment            = 1
989: 
990:             *-- Col14: Material alt (C14) W:83
991:             .Column14.Header1.Caption      = "Material"
992:             .Column14.Width                = 83
993:             .Column14.ControlSource        = "cursor_4c_Compo.matrizes"
994:         ENDWITH
995:         BINDEVENT(loc_oPg.grd_4c_Compo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
996: 
997:         *----------------------------------------------------------------------
998:         *-- Botoes do grdCompo (cmdgCompo: 5 botoes, Right of grid)
999:         *-- Container em T:145 L:947 W:50 H:210 (cada botao 50x42)
1000:         *----------------------------------------------------------------------
1001:         loc_oPg.AddObject("cnt_4c_BotoesCompo", "Container")
1002:         WITH loc_oPg.cnt_4c_BotoesCompo
1003:             .Top         = 145
1004:             .Left        = 947
1005:             .Width       = 50
1006:             .Height      = 210
1007:             .BackStyle = 1
1008:             .BackColor = RGB(53, 53, 53)
1009:             .BorderWidth = 0
1010:             .Visible     = .T.
1011:         ENDWITH
1012: 
1013:         *-- Botao 1: Inserir componente
1014:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_InserirCompo", "CommandButton")
1015:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_InserirCompo
1016:             .Caption     = "+"
1017:             .Top         = 0
1018:             .Left        = 0
1019:             .Width       = 50
1020:             .Height      = 42
1021:             .FontName    = "Tahoma"
1022:             .FontSize    = 10
1023:             .FontBold    = .T.
1024:             .Themes      = .F.
1025:             .SpecialEffect = 0
1026:             .BackColor   = RGB(255, 255, 255)
1027:             .ForeColor   = RGB(0, 128, 0)
1028:             .Visible     = .T.
1029:         ENDWITH
1030:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_InserirCompo, "Click", THIS, "CmdInserirCompoClick")
1031: 
1032:         *-- Botao 2: Excluir componente
1033:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_ExcluirCompo", "CommandButton")
1034:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_ExcluirCompo
1035:             .Caption     = "-"
1036:             .Top         = 42
1037:             .Left        = 0
1038:             .Width       = 50
1039:             .Height      = 42
1040:             .FontName    = "Tahoma"
1041:             .FontSize    = 10
1042:             .FontBold    = .T.
1043:             .Themes      = .F.
1044:             .SpecialEffect = 0
1045:             .BackColor   = RGB(255, 255, 255)
1046:             .ForeColor   = RGB(192, 0, 0)
1047:             .Visible     = .T.
1048:         ENDWITH
1049:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_ExcluirCompo, "Click", THIS, "CmdExcluirCompoClick")
1050: 
1051:         *-- Botao 3: Calcular preco (fornecedor)
1052:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_CalcFornec", "CommandButton")
1053:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_CalcFornec
1054:             .Caption     = "F"
1055:             .Top         = 84
1056:             .Left        = 0
1057:             .Width       = 50
1058:             .Height      = 42
1059:             .FontName    = "Tahoma"
1060:             .FontSize    = 9
1061:             .Themes      = .F.
1062:             .SpecialEffect = 0
1063:             .BackColor   = RGB(255, 255, 255)
1064:             .ForeColor   = RGB(90, 90, 90)
1065:             .Visible     = .T.
1066:         ENDWITH
1067:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_CalcFornec, "Click", THIS, "CmdCalcFornecClick")
1068: 
1069:         *-- Botao 4: Atualizar composicao
1070:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_AtualizarCompo", "CommandButton")
1071:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarCompo
1072:             .Caption     = "A"
1073:             .Top         = 126
1074:             .Left        = 0
1075:             .Width       = 50
1076:             .Height      = 42
1077:             .FontName    = "Tahoma"
1078:             .FontSize    = 9
1079:             .Themes      = .F.
1080:             .SpecialEffect = 0
1081:             .BackColor   = RGB(255, 255, 255)
1082:             .ForeColor   = RGB(90, 90, 90)
1083:             .Visible     = .T.
1084:         ENDWITH
1085:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarCompo, "Click", THIS, "CmdAtualizarCompoClick")
1086: 
1087:         *-- Botao 5: Atualizar pesos
1088:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_AtualizarPesos", "CommandButton")
1089:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarPesos
1090:             .Caption     = "P"
1091:             .Top         = 168
1092:             .Left        = 0
1093:             .Width       = 50
1094:             .Height      = 42
1095:             .FontName    = "Tahoma"
1096:             .FontSize    = 9
1097:             .Themes      = .F.
1098:             .SpecialEffect = 0
1099:             .BackColor   = RGB(255, 255, 255)
1100:             .ForeColor   = RGB(90, 90, 90)
1101:             .Visible     = .T.
1102:         ENDWITH
1103:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarPesos, "Click", THIS, "CmdAtualizarPesosClick")
1104: 
1105:         *----------------------------------------------------------------------
1106:         *-- Grid grdsubcp (15 colunas) - Sub-componentes
1107:         *-- Top:348 Left:6 Width:943 Height:83
1108:         *----------------------------------------------------------------------
1109:         loc_oPg.AddObject("grd_4c_SubCp", "Grid")
1110:         WITH loc_oPg.grd_4c_SubCp
1111:             .Top         = 348
1112:             .Left        = 6
1113:             .Width       = 943
1114:             .Height      = 83
1115:             .ColumnCount = 15
1116:             .FontName    = "Verdana"
1117:             .FontSize    = 8

*-- Linhas 1137 a 1326:
1137: 
1138:         *-- Configurar colunas do grd_4c_SubCp APOS RecordSource
1139:         WITH loc_oPg.grd_4c_SubCp
1140:             .Column1.Header1.Caption       = "Material"
1141:             .Column1.Width                 = 75
1142:             .Column1.ControlSource         = "cursor_4c_SubCp.mats"
1143: 
1144:             .Column2.Header1.Caption       = "Descri" + CHR(231) + CHR(227) + "o"
1145:             .Column2.Width                 = 175
1146:             .Column2.ControlSource         = "cursor_4c_SubCp.dcomps"
1147:             .Column2.Alignment             = 0
1148: 
1149:             .Column3.Header1.Caption       = "Un"
1150:             .Column3.Width                 = 30
1151:             .Column3.ControlSource         = "cursor_4c_SubCp.unicompos"
1152:             .Column3.ReadOnly              = .T.
1153: 
1154:             .Column4.Header1.Caption       = "Valor"
1155:             .Column4.Width                 = 60
1156:             .Column4.ControlSource         = "cursor_4c_SubCp.pcompos"
1157:             .Column4.Alignment             = 1
1158: 
1159:             .Column5.Header1.Caption       = "Qtde."
1160:             .Column5.Width                 = 55
1161:             .Column5.ControlSource         = "cursor_4c_SubCp.qtds"
1162:             .Column5.Alignment             = 1
1163: 
1164:             .Column6.Header1.Caption       = "Total"
1165:             .Column6.Width                 = 60
1166:             .Column6.ControlSource         = "cursor_4c_SubCp.totals"
1167:             .Column6.Alignment             = 1
1168:             .Column6.ReadOnly              = .T.
1169: 
1170:             .Column7.Header1.Caption       = "Moe"
1171:             .Column7.Width                 = 30
1172:             .Column7.ControlSource         = "cursor_4c_SubCp.bloqueio"
1173: 
1174:             .Column8.Header1.Caption       = "Observa" + CHR(231) + CHR(227) + "o"
1175:             .Column8.Width                 = 90
1176:             .Column8.ControlSource         = "cursor_4c_SubCp.obscompos"
1177:             .Column8.Alignment             = 0
1178: 
1179:             .Column9.Header1.Caption       = "E"
1180:             .Column9.Width                 = 25
1181:             .Column9.ControlSource         = "cursor_4c_SubCp.etiq"
1182: 
1183:             .Column10.Header1.Caption      = "Consumo"
1184:             .Column10.Width                = 60
1185:             .Column10.ControlSource        = "cursor_4c_SubCp.consumo"
1186:             .Column10.Alignment            = 1
1187: 
1188:             .Column11.Header1.Caption      = "Qtde."
1189:             .Column11.Width                = 55
1190:             .Column11.ControlSource        = "cursor_4c_SubCp.qtd2"
1191:             .Column11.Alignment            = 1
1192: 
1193:             .Column12.Header1.Caption      = "Un"
1194:             .Column12.Width                = 30
1195:             .Column12.ControlSource        = "cursor_4c_SubCp.uni2"
1196:             .Column12.ReadOnly             = .T.
1197: 
1198:             .Column13.Header1.Caption      = "Ord"
1199:             .Column13.Width                = 30
1200:             .Column13.ControlSource        = "cursor_4c_SubCp.ord"
1201:             .Column13.Alignment            = 1
1202: 
1203:             .Column14.Header1.Caption      = "Material"
1204:             .Column14.Width                = 80
1205:             .Column14.ControlSource        = "cursor_4c_SubCp.matrizes"
1206: 
1207:             .Column15.Header1.Caption      = "Tam"
1208:             .Column15.Width                = 88
1209:             .Column15.ControlSource        = "cursor_4c_SubCp.tamanhos"
1210:             .Column15.Alignment            = 0
1211:         ENDWITH
1212:         BINDEVENT(loc_oPg.grd_4c_SubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
1213: 
1214:         *----------------------------------------------------------------------
1215:         *-- Botoes do grdsubcp (cmdgSubCp: 2 botoes, Right of grid)
1216:         *-- Container em T:345 L:947 W:50 H:90 (cada botao 50x45)
1217:         *----------------------------------------------------------------------
1218:         loc_oPg.AddObject("cnt_4c_BotoesSubCp", "Container")
1219:         WITH loc_oPg.cnt_4c_BotoesSubCp
1220:             .Top         = 345
1221:             .Left        = 947
1222:             .Width       = 50
1223:             .Height      = 90
1224:             .BackStyle = 1
1225:             .BackColor = RGB(53, 53, 53)
1226:             .BorderWidth = 0
1227:             .Visible     = .T.
1228:         ENDWITH
1229: 
1230:         *-- Botao 1: Inserir sub-componente
1231:         loc_oPg.cnt_4c_BotoesSubCp.AddObject("cmd_4c_InserirSubCp", "CommandButton")
1232:         WITH loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_InserirSubCp
1233:             .Caption     = "+"
1234:             .Top         = 0
1235:             .Left        = 0
1236:             .Width       = 50
1237:             .Height      = 45
1238:             .FontName    = "Tahoma"
1239:             .FontSize    = 10
1240:             .FontBold    = .T.
1241:             .Themes      = .F.
1242:             .SpecialEffect = 0
1243:             .BackColor   = RGB(255, 255, 255)
1244:             .ForeColor   = RGB(0, 128, 0)
1245:             .Visible     = .T.
1246:         ENDWITH
1247:         BINDEVENT(loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_InserirSubCp, "Click", THIS, "CmdInserirSubCpClick")
1248: 
1249:         *-- Botao 2: Excluir sub-componente
1250:         loc_oPg.cnt_4c_BotoesSubCp.AddObject("cmd_4c_ExcluirSubCp", "CommandButton")
1251:         WITH loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_ExcluirSubCp
1252:             .Caption     = "-"
1253:             .Top         = 45
1254:             .Left        = 0
1255:             .Width       = 50
1256:             .Height      = 45
1257:             .FontName    = "Tahoma"
1258:             .FontSize    = 10
1259:             .FontBold    = .T.
1260:             .Themes      = .F.
1261:             .SpecialEffect = 0
1262:             .BackColor   = RGB(255, 255, 255)
1263:             .ForeColor   = RGB(192, 0, 0)
1264:             .Visible     = .T.
1265:         ENDWITH
1266:         BINDEVENT(loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_ExcluirSubCp, "Click", THIS, "CmdExcluirSubCpClick")
1267: 
1268:         *----------------------------------------------------------------------
1269:         *-- Descricao / Substitui (abaixo grdsubcp)
1270:         *-- Say3: "Descricao :" (T:435 L:39 W:55)
1271:         *-- get_desccp: (T:432 L:99 W:298 H:21) - readonly
1272:         *-- Say5: "Substitui :" (T:435 L:465 W:50)
1273:         *-- get_matsub: (T:432 L:517 W:108 H:21) - readonly
1274:         *----------------------------------------------------------------------
1275:         loc_oPg.AddObject("lbl_4c_DescCp", "Label")
1276:         WITH loc_oPg.lbl_4c_DescCp
1277:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
1278:             .Top       = 435
1279:             .Left      = 39
1280:             .Width     = 55
1281:             .Height    = 15
1282:             .FontName  = "Tahoma"
1283:             .FontSize  = 8
1284:             .BackStyle = 0
1285:             .ForeColor = RGB(90, 90, 90)
1286:             .Visible   = .T.
1287:         ENDWITH
1288: 
1289:         loc_oPg.AddObject("txt_4c_DescCp", "TextBox")
1290:         WITH loc_oPg.txt_4c_DescCp
1291:             .Top           = 432
1292:             .Left          = 99
1293:             .Width         = 298
1294:             .Height        = 21
1295:             .FontName      = "Tahoma"
1296:             .FontSize      = 8
1297:             .MaxLength     = 65
1298:             .Value         = ""
1299:             .SpecialEffect = 1
1300:             .Enabled       = .F.
1301:             .Visible       = .T.
1302:         ENDWITH
1303: 
1304:         loc_oPg.AddObject("lbl_4c_Substitui", "Label")
1305:         WITH loc_oPg.lbl_4c_Substitui
1306:             .Caption   = "Substitui :"
1307:             .Top       = 435
1308:             .Left      = 465
1309:             .Width     = 50
1310:             .Height    = 15
1311:             .FontName  = "Tahoma"
1312:             .FontSize  = 8
1313:             .BackStyle = 0
1314:             .ForeColor = RGB(90, 90, 90)
1315:             .Visible   = .T.
1316:         ENDWITH
1317: 
1318:         loc_oPg.AddObject("txt_4c_MatSub", "TextBox")
1319:         WITH loc_oPg.txt_4c_MatSub
1320:             .Top           = 432
1321:             .Left          = 517
1322:             .Width         = 108
1323:             .Height        = 21
1324:             .FontName      = "Tahoma"
1325:             .FontSize      = 8
1326:             .MaxLength     = 14

*-- Linhas 1336 a 1345:
1336:         *----------------------------------------------------------------------
1337:         loc_oPg.AddObject("grd_4c_Grupo", "Grid")
1338:         WITH loc_oPg.grd_4c_Grupo
1339:             .Top         = 34
1340:             .Left        = 582
1341:             .Width       = 229
1342:             .Height      = 107
1343:             .ColumnCount = 3
1344:             .FontName    = "Verdana"
1345:             .FontSize    = 8

*-- Linhas 1365 a 1449:
1365: 
1366:         *-- Colunas do GradeGRUPO APOS RecordSource
1367:         WITH loc_oPg.grd_4c_Grupo
1368:             .Column1.Header1.Caption = "Grupo"
1369:             .Column1.Width           = 50
1370:             .Column1.ControlSource   = "cursor_4c_Grupo.cgrus"
1371: 
1372:             .Column2.Header1.Caption = "Total"
1373:             .Column2.Width           = 100
1374:             .Column2.ControlSource   = "cursor_4c_Grupo.valgr"
1375:             .Column2.Alignment       = 1
1376: 
1377:             .Column3.Header1.Caption = "Moeda"
1378:             .Column3.Width           = 79
1379:             .Column3.ControlSource   = "cursor_4c_Grupo.moeds"
1380:         ENDWITH
1381: 
1382:         *----------------------------------------------------------------------
1383:         *-- Labels de secao Custo / Venda
1384:         *-- Say1: " Custo " (T:473 L:47 W:46 - secao de custo)
1385:         *-- Say2: " Venda " (T:474 L:361 W:48 - secao de venda)
1386:         *----------------------------------------------------------------------
1387:         loc_oPg.AddObject("lbl_4c_SecCusto", "Label")
1388:         WITH loc_oPg.lbl_4c_SecCusto
1389:             .Caption   = " Custo "
1390:             .Top       = 473
1391:             .Left      = 47
1392:             .Width     = 46
1393:             .Height    = 16
1394:             .FontName  = "Tahoma"
1395:             .FontSize  = 8
1396:             .FontBold  = .T.
1397:             .BackStyle = 1
1398:             .BackColor = RGB(192, 192, 192)
1399:             .ForeColor = RGB(0, 0, 0)
1400:             .Visible   = .T.
1401:         ENDWITH
1402: 
1403:         loc_oPg.AddObject("lbl_4c_SecVenda", "Label")
1404:         WITH loc_oPg.lbl_4c_SecVenda
1405:             .Caption   = " Venda "
1406:             .Top       = 474
1407:             .Left      = 361
1408:             .Width     = 48
1409:             .Height    = 16
1410:             .FontName  = "Tahoma"
1411:             .FontSize  = 8
1412:             .FontBold  = .T.
1413:             .BackStyle = 1
1414:             .BackColor = RGB(192, 192, 192)
1415:             .ForeColor = RGB(0, 0, 0)
1416:             .Visible   = .T.
1417:         ENDWITH
1418: 
1419:         *----------------------------------------------------------------------
1420:         *-- CheckBoxes de liberacao: chkLiberaCusto + chkLiberaVenda
1421:         *-- chkLiberaCusto: T:458 L:9 W:39 H:38
1422:         *-- chkLiberaVenda: T:459 L:323 W:39 H:38
1423:         *----------------------------------------------------------------------
1424:         loc_oPg.AddObject("chk_4c_LiberaCusto", "CheckBox")
1425:         WITH loc_oPg.chk_4c_LiberaCusto
1426:             .Caption   = ""
1427:             .Top       = 458
1428:             .Left      = 9
1429:             .Width     = 39
1430:             .Height    = 38
1431:             .FontName  = "Tahoma"
1432:             .FontSize  = 8
1433:             .Value     = 0
1434:             .BackStyle = 0
1435:             .Themes    = .F.
1436:             .Visible   = .T.
1437:         ENDWITH
1438:         BINDEVENT(loc_oPg.chk_4c_LiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
1439: 
1440:         loc_oPg.AddObject("chk_4c_LiberaVenda", "CheckBox")
1441:         WITH loc_oPg.chk_4c_LiberaVenda
1442:             .Caption   = ""
1443:             .Top       = 459
1444:             .Left      = 323
1445:             .Width     = 39
1446:             .Height    = 38
1447:             .FontName  = "Tahoma"
1448:             .FontSize  = 8
1449:             .Value     = 0

*-- Linhas 1459 a 1481:
1459:         *----------------------------------------------------------------------
1460:         loc_oPg.AddObject("shp_4c_Shape6", "Shape")
1461:         WITH loc_oPg.shp_4c_Shape6
1462:             .Top         = 497
1463:             .Left        = 9
1464:             .Width       = 158
1465:             .Height      = 2
1466:             .FillStyle   = 0
1467:             .BackStyle   = 1
1468:             .FillColor   = RGB(128, 128, 128)
1469:             .BorderStyle = 1
1470:             .Visible     = .T.
1471:         ENDWITH
1472: 
1473:         loc_oPg.AddObject("shp_4c_Shape4", "Shape")
1474:         WITH loc_oPg.shp_4c_Shape4
1475:             .Top         = 498
1476:             .Left        = 323
1477:             .Width       = 158
1478:             .Height      = 2
1479:             .FillStyle   = 0
1480:             .BackStyle   = 1
1481:             .FillColor   = RGB(128, 128, 128)

*-- Linhas 1505 a 1530:
1505:         *-- Say7: "Cotacao" T:581 L:161 W:42
1506:         *-- GetCotaCalcP: T:596 L:161 W:115 H:23
1507:         *----------------------------------------------------------------------
1508:         loc_oPg.AddObject("lbl_4c_LblCompra", "Label")
1509:         WITH loc_oPg.lbl_4c_LblCompra
1510:             .Caption   = "Pre" + CHR(231) + "o de Custo (Moeda 1)"
1511:             .Top       = 502
1512:             .Left      = 9
1513:             .Width     = 127
1514:             .Height    = 15
1515:             .FontName  = "Tahoma"
1516:             .FontSize  = 8
1517:             .BackStyle = 0
1518:             .ForeColor = RGB(90, 90, 90)
1519:             .Visible   = .T.
1520:         ENDWITH
1521: 
1522:         loc_oPg.AddObject("txt_4c_Pcus", "TextBox")
1523:         WITH loc_oPg.txt_4c_Pcus
1524:             .Top           = 517
1525:             .Left          = 9
1526:             .Width         = 115
1527:             .Height        = 23
1528:             .FontName      = "Tahoma"
1529:             .FontSize      = 8
1530:             .Value         = 0.0

*-- Linhas 1537 a 1546:
1537: 
1538:         loc_oPg.AddObject("txt_4c_Moec", "TextBox")
1539:         WITH loc_oPg.txt_4c_Moec
1540:             .Top           = 517
1541:             .Left          = 127
1542:             .Width         = 31
1543:             .Height        = 23
1544:             .FontName      = "Tahoma"
1545:             .FontSize      = 8
1546:             .MaxLength     = 5

*-- Linhas 1553 a 1578:
1553:         BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress",  THIS, "TxtMoecKeyPress")
1554:         BINDEVENT(loc_oPg.txt_4c_Moec, "LostFocus", THIS, "TxtMoecLostFocus")
1555: 
1556:         loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
1557:         WITH loc_oPg.lbl_4c_LblCuVda
1558:             .Caption   = "Fator de Custo (Moeda 2)"
1559:             .Top       = 502
1560:             .Left      = 161
1561:             .Width     = 126
1562:             .Height    = 15
1563:             .FontName  = "Tahoma"
1564:             .FontSize  = 8
1565:             .BackStyle = 0
1566:             .ForeColor = RGB(90, 90, 90)
1567:             .Visible   = .T.
1568:         ENDWITH
1569: 
1570:         loc_oPg.AddObject("txt_4c_Fcusto", "TextBox")
1571:         WITH loc_oPg.txt_4c_Fcusto
1572:             .Top           = 517
1573:             .Left          = 161
1574:             .Width         = 115
1575:             .Height        = 23
1576:             .FontName      = "Tahoma"
1577:             .FontSize      = 8
1578:             .Value         = 0.0

*-- Linhas 1585 a 1594:
1585: 
1586:         loc_oPg.AddObject("txt_4c_Moepc", "TextBox")
1587:         WITH loc_oPg.txt_4c_Moepc
1588:             .Top           = 517
1589:             .Left          = 279
1590:             .Width         = 31
1591:             .Height        = 23
1592:             .FontName      = "Tahoma"
1593:             .FontSize      = 8
1594:             .MaxLength     = 5

*-- Linhas 1601 a 1626:
1601:         BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress",  THIS, "TxtMoepcKeyPress")
1602:         BINDEVENT(loc_oPg.txt_4c_Moepc, "LostFocus", THIS, "TxtMoepcLostFocus")
1603: 
1604:         loc_oPg.AddObject("lbl_4c_LblTotalCusto", "Label")
1605:         WITH loc_oPg.lbl_4c_LblTotalCusto
1606:             .Caption   = "Total "
1607:             .Top       = 542
1608:             .Left      = 161
1609:             .Width     = 29
1610:             .Height    = 15
1611:             .FontName  = "Tahoma"
1612:             .FontSize  = 8
1613:             .BackStyle = 0
1614:             .ForeColor = RGB(90, 90, 90)
1615:             .Visible   = .T.
1616:         ENDWITH
1617: 
1618:         loc_oPg.AddObject("txt_4c_Custof", "TextBox")
1619:         WITH loc_oPg.txt_4c_Custof
1620:             .Top           = 557
1621:             .Left          = 161
1622:             .Width         = 115
1623:             .Height        = 23
1624:             .FontName      = "Tahoma"
1625:             .FontSize      = 8
1626:             .Value         = 0.0

*-- Linhas 1633 a 1642:
1633: 
1634:         loc_oPg.AddObject("txt_4c_Moecusf", "TextBox")
1635:         WITH loc_oPg.txt_4c_Moecusf
1636:             .Top           = 557
1637:             .Left          = 279
1638:             .Width         = 31
1639:             .Height        = 23
1640:             .FontName      = "Tahoma"
1641:             .FontSize      = 8
1642:             .MaxLength     = 5

*-- Linhas 1649 a 1674:
1649:         BINDEVENT(loc_oPg.txt_4c_Moecusf, "KeyPress",  THIS, "TxtMoecusfKeyPress")
1650:         BINDEVENT(loc_oPg.txt_4c_Moecusf, "LostFocus", THIS, "TxtMoecusfLostFocus")
1651: 
1652:         loc_oPg.AddObject("lbl_4c_LblMkp", "Label")
1653:         WITH loc_oPg.lbl_4c_LblMkp
1654:             .Caption   = "MKP"
1655:             .Top       = 542
1656:             .Left      = 9
1657:             .Width     = 22
1658:             .Height    = 15
1659:             .FontName  = "Tahoma"
1660:             .FontSize  = 8
1661:             .BackStyle = 0
1662:             .ForeColor = RGB(90, 90, 90)
1663:             .Visible   = .T.
1664:         ENDWITH
1665: 
1666:         loc_oPg.AddObject("txt_4c_GetCmkpc", "TextBox")
1667:         WITH loc_oPg.txt_4c_GetCmkpc
1668:             .Top           = 557
1669:             .Left          = 9
1670:             .Width         = 24
1671:             .Height        = 23
1672:             .FontName      = "Tahoma"
1673:             .FontSize      = 8
1674:             .MaxLength     = 5

*-- Linhas 1681 a 1706:
1681:         BINDEVENT(loc_oPg.txt_4c_GetCmkpc, "KeyPress",  THIS, "TxtGetCmkpcKeyPress")
1682:         BINDEVENT(loc_oPg.txt_4c_GetCmkpc, "LostFocus", THIS, "TxtGetCmkpcLostFocus")
1683: 
1684:         loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
1685:         WITH loc_oPg.lbl_4c_LblValAdics
1686:             .Caption   = "Valor Adicional"
1687:             .Top       = 542
1688:             .Left      = 64
1689:             .Width     = 71
1690:             .Height    = 15
1691:             .FontName  = "Tahoma"
1692:             .FontSize  = 8
1693:             .BackStyle = 0
1694:             .ForeColor = RGB(90, 90, 90)
1695:             .Visible   = .T.
1696:         ENDWITH
1697: 
1698:         loc_oPg.AddObject("txt_4c_GetPftioc", "TextBox")
1699:         WITH loc_oPg.txt_4c_GetPftioc
1700:             .Top           = 557
1701:             .Left          = 64
1702:             .Width         = 94
1703:             .Height        = 23
1704:             .FontName      = "Tahoma"
1705:             .FontSize      = 8
1706:             .MaxLength     = 5

*-- Linhas 1714 a 1754:
1714:         BINDEVENT(loc_oPg.txt_4c_GetPftioc, "LostFocus", THIS, "TxtGetPftiocLostFocus")
1715: 
1716:         *-- chkPlanCus (T:556 L:36 W:25 H:25) - plano custo
1717:         loc_oPg.AddObject("chk_4c_PlanCus", "CheckBox")
1718:         WITH loc_oPg.chk_4c_PlanCus
1719:             .Caption   = ""
1720:             .Top       = 556
1721:             .Left      = 36
1722:             .Width     = 25
1723:             .Height    = 25
1724:             .Value     = 0
1725:             .BackStyle = 0
1726:             .Themes    = .F.
1727:             .Enabled   = .F.
1728:             .Visible   = .T.
1729:         ENDWITH
1730:         BINDEVENT(loc_oPg.chk_4c_PlanCus, "Click", THIS, "ChkPlanCusClick")
1731: 
1732:         loc_oPg.AddObject("lbl_4c_PesoMedio", "Label")
1733:         WITH loc_oPg.lbl_4c_PesoMedio
1734:             .Caption   = "Peso M" + CHR(233) + "dio"
1735:             .Top       = 581
1736:             .Left      = 10
1737:             .Width     = 56
1738:             .Height    = 15
1739:             .FontName  = "Tahoma"
1740:             .FontSize  = 8
1741:             .BackStyle = 0
1742:             .ForeColor = RGB(90, 90, 90)
1743:             .Visible   = .T.
1744:         ENDWITH
1745: 
1746:         loc_oPg.AddObject("txt_4c_Pesom", "TextBox")
1747:         WITH loc_oPg.txt_4c_Pesom
1748:             .Top           = 596
1749:             .Left          = 10
1750:             .Width         = 79
1751:             .Height        = 23
1752:             .FontName      = "Tahoma"
1753:             .FontSize      = 8
1754:             .Value         = 0.0

*-- Linhas 1760 a 1803:
1760:         BINDEVENT(loc_oPg.txt_4c_Pesom, "LostFocus", THIS, "TxtPesomLostFocus")
1761: 
1762:         *-- cmdPesoM: "..." T:597 L:92 W:26 H:23
1763:         loc_oPg.AddObject("cmd_4c_PesoM", "CommandButton")
1764:         WITH loc_oPg.cmd_4c_PesoM
1765:             .Caption     = "..."
1766:             .Top         = 597
1767:             .Left        = 92
1768:             .Width       = 26
1769:             .Height      = 23
1770:             .FontName    = "Tahoma"
1771:             .FontSize    = 8
1772:             .Themes      = .F.
1773:             .SpecialEffect = 0
1774:             .BackColor   = RGB(255, 255, 255)
1775:             .ForeColor   = RGB(90, 90, 90)
1776:             .Enabled     = .F.
1777:             .Visible     = .T.
1778:         ENDWITH
1779:         BINDEVENT(loc_oPg.cmd_4c_PesoM, "Click", THIS, "CmdPesoMClick")
1780: 
1781:         loc_oPg.AddObject("lbl_4c_LblCotacao", "Label")
1782:         WITH loc_oPg.lbl_4c_LblCotacao
1783:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
1784:             .Top       = 581
1785:             .Left      = 161
1786:             .Width     = 42
1787:             .Height    = 15
1788:             .FontName  = "Tahoma"
1789:             .FontSize  = 8
1790:             .BackStyle = 0
1791:             .ForeColor = RGB(90, 90, 90)
1792:             .Visible   = .T.
1793:         ENDWITH
1794: 
1795:         loc_oPg.AddObject("txt_4c_CotaCalcP", "TextBox")
1796:         WITH loc_oPg.txt_4c_CotaCalcP
1797:             .Top           = 596
1798:             .Left          = 161
1799:             .Width         = 115
1800:             .Height        = 23
1801:             .FontName      = "Tahoma"
1802:             .FontSize      = 8
1803:             .Value         = 0.0

*-- Linhas 1841 a 1896:
1841:         *-- cmdCalcVals: T:507 L:678 W:40 H:40
1842:         *----------------------------------------------------------------------
1843: 
1844:         loc_oPg.AddObject("lbl_4c_LblMkpVenda", "Label")
1845:         WITH loc_oPg.lbl_4c_LblMkpVenda
1846:             .Caption   = "MKP Ideal"
1847:             .Top       = 504
1848:             .Left      = 324
1849:             .Width     = 49
1850:             .Height    = 15
1851:             .FontName  = "Tahoma"
1852:             .FontSize  = 8
1853:             .BackStyle = 0
1854:             .ForeColor = RGB(90, 90, 90)
1855:             .Visible   = .T.
1856:         ENDWITH
1857: 
1858:         loc_oPg.AddObject("txt_4c_Margem", "TextBox")
1859:         WITH loc_oPg.txt_4c_Margem
1860:             .Top           = 517
1861:             .Left          = 323
1862:             .Width         = 89
1863:             .Height        = 23
1864:             .FontName      = "Tahoma"
1865:             .FontSize      = 8
1866:             .Value         = 0.0
1867:             .SpecialEffect = 1
1868:             .ForeColor     = RGB(36, 84, 155)
1869:             .Enabled       = .F.
1870:             .Visible       = .T.
1871:         ENDWITH
1872:         BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TxtMargemLostFocus")
1873: 
1874:         loc_oPg.AddObject("lbl_4c_LblSts", "Label")
1875:         WITH loc_oPg.lbl_4c_LblSts
1876:             .Caption   = "Sts"
1877:             .Top       = 542
1878:             .Left      = 324
1879:             .Width     = 17
1880:             .Height    = 15
1881:             .FontName  = "Tahoma"
1882:             .FontSize  = 8
1883:             .BackStyle = 0
1884:             .ForeColor = RGB(90, 90, 90)
1885:             .Visible   = .T.
1886:         ENDWITH
1887: 
1888:         loc_oPg.AddObject("txt_4c_GetStatus", "TextBox")
1889:         WITH loc_oPg.txt_4c_GetStatus
1890:             .Top           = 557
1891:             .Left          = 324
1892:             .Width         = 31
1893:             .Height        = 23
1894:             .FontName      = "Tahoma"
1895:             .FontSize      = 8
1896:             .MaxLength     = 5

*-- Linhas 1903 a 1928:
1903:         BINDEVENT(loc_oPg.txt_4c_GetStatus, "KeyPress",  THIS, "TxtGetStatusKeyPress")
1904:         BINDEVENT(loc_oPg.txt_4c_GetStatus, "LostFocus", THIS, "TxtGetStatusLostFocus")
1905: 
1906:         loc_oPg.AddObject("lbl_4c_LblMkpApl", "Label")
1907:         WITH loc_oPg.lbl_4c_LblMkpApl
1908:             .Caption   = "MKP Aplic."
1909:             .Top       = 581
1910:             .Left      = 324
1911:             .Width     = 51
1912:             .Height    = 15
1913:             .FontName  = "Tahoma"
1914:             .FontSize  = 8
1915:             .BackStyle = 0
1916:             .ForeColor = RGB(90, 90, 90)
1917:             .Visible   = .T.
1918:         ENDWITH
1919: 
1920:         loc_oPg.AddObject("txt_4c_MarkupA", "TextBox")
1921:         WITH loc_oPg.txt_4c_MarkupA
1922:             .Top           = 596
1923:             .Left          = 323
1924:             .Width         = 62
1925:             .Height        = 23
1926:             .FontName      = "Tahoma"
1927:             .FontSize      = 8
1928:             .Value         = 0.0

*-- Linhas 1934 a 1990:
1934:         BINDEVENT(loc_oPg.txt_4c_MarkupA, "LostFocus", THIS, "TxtMarkupALostFocus")
1935: 
1936:         *-- Chk_Pvenda (T:595 L:387 W:25 H:25) - usa preco de venda atual
1937:         loc_oPg.AddObject("chk_4c_PVenda", "CheckBox")
1938:         WITH loc_oPg.chk_4c_PVenda
1939:             .Caption   = ""
1940:             .Top       = 595
1941:             .Left      = 387
1942:             .Width     = 25
1943:             .Height    = 25
1944:             .Value     = 0
1945:             .BackStyle = 0
1946:             .Themes    = .F.
1947:             .Enabled   = .F.
1948:             .Visible   = .T.
1949:         ENDWITH
1950:         BINDEVENT(loc_oPg.chk_4c_PVenda, "Click", THIS, "ChkPVendaClick")
1951: 
1952:         *-- chkPlanVen (T:556 L:387 W:25 H:25) - plano venda
1953:         loc_oPg.AddObject("chk_4c_PlanVen", "CheckBox")
1954:         WITH loc_oPg.chk_4c_PlanVen
1955:             .Caption   = ""
1956:             .Top       = 556
1957:             .Left      = 387
1958:             .Width     = 25
1959:             .Height    = 25
1960:             .Value     = 0
1961:             .BackStyle = 0
1962:             .Themes    = .F.
1963:             .Enabled   = .F.
1964:             .Visible   = .T.
1965:         ENDWITH
1966:         BINDEVENT(loc_oPg.chk_4c_PlanVen, "Click", THIS, "ChkPlanVenClick")
1967: 
1968:         loc_oPg.AddObject("lbl_4c_LblMkpFat", "Label")
1969:         WITH loc_oPg.lbl_4c_LblMkpFat
1970:             .Caption   = "MKP"
1971:             .Top       = 542
1972:             .Left      = 360
1973:             .Width     = 22
1974:             .Height    = 15
1975:             .FontName  = "Tahoma"
1976:             .FontSize  = 8
1977:             .BackStyle = 0
1978:             .ForeColor = RGB(90, 90, 90)
1979:             .Visible   = .T.
1980:         ENDWITH
1981: 
1982:         loc_oPg.AddObject("txt_4c_Getftio", "TextBox")
1983:         WITH loc_oPg.txt_4c_Getftio
1984:             .Top           = 557
1985:             .Left          = 360
1986:             .Width         = 24
1987:             .Height        = 23
1988:             .FontName      = "Tahoma"
1989:             .FontSize      = 8
1990:             .MaxLength     = 5

*-- Linhas 1997 a 2052:
1997:         BINDEVENT(loc_oPg.txt_4c_Getftio, "KeyPress",  THIS, "TxtGetftioKeyPress")
1998:         BINDEVENT(loc_oPg.txt_4c_Getftio, "LostFocus", THIS, "TxtGetftioLostFocus")
1999: 
2000:         loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
2001:         WITH loc_oPg.lbl_4c_LblIdeal
2002:             .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
2003:             .Top       = 503
2004:             .Left      = 416
2005:             .Width     = 111
2006:             .Height    = 15
2007:             .FontName  = "Tahoma"
2008:             .FontSize  = 8
2009:             .BackStyle = 0
2010:             .ForeColor = RGB(90, 90, 90)
2011:             .Visible   = .T.
2012:         ENDWITH
2013: 
2014:         loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
2015:         WITH loc_oPg.txt_4c_Pvideal
2016:             .Top           = 517
2017:             .Left          = 416
2018:             .Width         = 110
2019:             .Height        = 23
2020:             .FontName      = "Tahoma"
2021:             .FontSize      = 8
2022:             .Value         = 0.0
2023:             .SpecialEffect = 1
2024:             .ForeColor     = RGB(36, 84, 155)
2025:             .Enabled       = .F.
2026:             .Visible       = .T.
2027:         ENDWITH
2028:         BINDEVENT(loc_oPg.txt_4c_Pvideal, "LostFocus", THIS, "TxtPvidealLostFocus")
2029: 
2030:         loc_oPg.AddObject("lbl_4c_LblValAdicV", "Label")
2031:         WITH loc_oPg.lbl_4c_LblValAdicV
2032:             .Caption   = "Valor Adicional"
2033:             .Top       = 542
2034:             .Left      = 416
2035:             .Width     = 71
2036:             .Height    = 15
2037:             .FontName  = "Tahoma"
2038:             .FontSize  = 8
2039:             .BackStyle = 0
2040:             .ForeColor = RGB(90, 90, 90)
2041:             .Visible   = .T.
2042:         ENDWITH
2043: 
2044:         loc_oPg.AddObject("txt_4c_GetPftio", "TextBox")
2045:         WITH loc_oPg.txt_4c_GetPftio
2046:             .Top           = 557
2047:             .Left          = 416
2048:             .Width         = 110
2049:             .Height        = 23
2050:             .FontName      = "Tahoma"
2051:             .FontSize      = 8
2052:             .MaxLength     = 5

*-- Linhas 2059 a 2068:
2059: 
2060:         loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
2061:         WITH loc_oPg.txt_4c_Moeda
2062:             .Top           = 517
2063:             .Left          = 529
2064:             .Width         = 31
2065:             .Height        = 23
2066:             .FontName      = "Tahoma"
2067:             .FontSize      = 8
2068:             .MaxLength     = 5

*-- Linhas 2075 a 2100:
2075:         BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress",  THIS, "TxtMoedaKeyPress")
2076:         BINDEVENT(loc_oPg.txt_4c_Moeda, "LostFocus", THIS, "TxtMoedaLostFocus")
2077: 
2078:         loc_oPg.AddObject("lbl_4c_LblFatorI", "Label")
2079:         WITH loc_oPg.lbl_4c_LblFatorI
2080:             .Caption   = "Fator"
2081:             .Top       = 542
2082:             .Left      = 563
2083:             .Width     = 28
2084:             .Height    = 15
2085:             .FontName  = "Tahoma"
2086:             .FontSize  = 8
2087:             .BackStyle = 0
2088:             .ForeColor = RGB(90, 90, 90)
2089:             .Visible   = .T.
2090:         ENDWITH
2091: 
2092:         loc_oPg.AddObject("txt_4c_GetMftio", "TextBox")
2093:         WITH loc_oPg.txt_4c_GetMftio
2094:             .Top           = 557
2095:             .Left          = 529
2096:             .Width         = 31
2097:             .Height        = 23
2098:             .FontName      = "Tahoma"
2099:             .FontSize      = 8
2100:             .MaxLength     = 5

*-- Linhas 2106 a 2160:
2106:         ENDWITH
2107:         BINDEVENT(loc_oPg.txt_4c_GetMftio, "LostFocus", THIS, "TxtGetMftioLostFocus")
2108: 
2109:         loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
2110:         WITH loc_oPg.lbl_4c_LblFIdeals
2111:             .Caption   = "Fator Ideal"
2112:             .Top       = 503
2113:             .Left      = 563
2114:             .Width     = 55
2115:             .Height    = 15
2116:             .FontName  = "Tahoma"
2117:             .FontSize  = 8
2118:             .BackStyle = 0
2119:             .ForeColor = RGB(90, 90, 90)
2120:             .Visible   = .T.
2121:         ENDWITH
2122: 
2123:         loc_oPg.AddObject("txt_4c_FIdeals", "TextBox")
2124:         WITH loc_oPg.txt_4c_FIdeals
2125:             .Top           = 517
2126:             .Left          = 563
2127:             .Width         = 110
2128:             .Height        = 23
2129:             .FontName      = "Tahoma"
2130:             .FontSize      = 8
2131:             .Value         = 0.0
2132:             .SpecialEffect = 1
2133:             .ForeColor     = RGB(36, 84, 155)
2134:             .Enabled       = .F.
2135:             .Visible       = .T.
2136:         ENDWITH
2137: 
2138:         loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
2139:         WITH loc_oPg.lbl_4c_LblVenda
2140:             .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
2141:             .Top       = 581
2142:             .Left      = 416
2143:             .Width     = 115
2144:             .Height    = 15
2145:             .FontName  = "Tahoma"
2146:             .FontSize  = 8
2147:             .BackStyle = 0
2148:             .ForeColor = RGB(90, 90, 90)
2149:             .Visible   = .T.
2150:         ENDWITH
2151: 
2152:         loc_oPg.AddObject("txt_4c_Moepv", "TextBox")
2153:         WITH loc_oPg.txt_4c_Moepv
2154:             .Top           = 557
2155:             .Left          = 677
2156:             .Width         = 31
2157:             .Height        = 23
2158:             .FontName      = "Tahoma"
2159:             .FontSize      = 8
2160:             .MaxLength     = 5

*-- Linhas 2169 a 2178:
2169: 
2170:         loc_oPg.AddObject("txt_4c_Moev", "TextBox")
2171:         WITH loc_oPg.txt_4c_Moev
2172:             .Top           = 596
2173:             .Left          = 529
2174:             .Width         = 31
2175:             .Height        = 23
2176:             .FontName      = "Tahoma"
2177:             .FontSize      = 8
2178:             .MaxLength     = 5

*-- Linhas 2187 a 2196:
2187: 
2188:         loc_oPg.AddObject("txt_4c_Fvenda", "TextBox")
2189:         WITH loc_oPg.txt_4c_Fvenda
2190:             .Top           = 557
2191:             .Left          = 563
2192:             .Width         = 110
2193:             .Height        = 23
2194:             .FontName      = "Tahoma"
2195:             .FontSize      = 8
2196:             .Value         = 0.0

*-- Linhas 2203 a 2271:
2203: 
2204:         loc_oPg.AddObject("txt_4c_Pven", "TextBox")
2205:         WITH loc_oPg.txt_4c_Pven
2206:             .Top           = 596
2207:             .Left          = 416
2208:             .Width         = 110
2209:             .Height        = 23
2210:             .FontName      = "Tahoma"
2211:             .FontSize      = 8
2212:             .Value         = 0.0
2213:             .SpecialEffect = 1
2214:             .ForeColor     = RGB(36, 84, 155)
2215:             .Enabled       = .F.
2216:             .Visible       = .T.
2217:         ENDWITH
2218:         BINDEVENT(loc_oPg.txt_4c_Pven, "LostFocus", THIS, "TxtPvenLostFocus")
2219: 
2220:         loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
2221:         WITH loc_oPg.lbl_4c_LblFAtuals
2222:             .Caption   = "Fator Atual"
2223:             .Top       = 581
2224:             .Left      = 563
2225:             .Width     = 56
2226:             .Height    = 15
2227:             .FontName  = "Tahoma"
2228:             .FontSize  = 8
2229:             .BackStyle = 0
2230:             .ForeColor = RGB(90, 90, 90)
2231:             .Visible   = .T.
2232:         ENDWITH
2233: 
2234:         loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
2235:         WITH loc_oPg.txt_4c_FAtuals
2236:             .Top           = 596
2237:             .Left          = 563
2238:             .Width         = 110
2239:             .Height        = 23
2240:             .FontName      = "Tahoma"
2241:             .FontSize      = 8
2242:             .Value         = 0.0
2243:             .SpecialEffect = 1
2244:             .ForeColor     = RGB(36, 84, 155)
2245:             .Enabled       = .F.
2246:             .Visible       = .T.
2247:         ENDWITH
2248: 
2249:         loc_oPg.AddObject("lbl_4c_LblFinanc", "Label")
2250:         WITH loc_oPg.lbl_4c_LblFinanc
2251:             .Caption   = "Financeiro"
2252:             .Top       = 581
2253:             .Left      = 678
2254:             .Width     = 51
2255:             .Height    = 15
2256:             .FontName  = "Tahoma"
2257:             .FontSize  = 8
2258:             .BackStyle = 0
2259:             .ForeColor = RGB(90, 90, 90)
2260:             .Visible   = .T.
2261:         ENDWITH
2262: 
2263:         loc_oPg.AddObject("txt_4c_GetEncarg", "TextBox")
2264:         WITH loc_oPg.txt_4c_GetEncarg
2265:             .Top           = 595
2266:             .Left          = 678
2267:             .Width         = 62
2268:             .Height        = 23
2269:             .FontName      = "Tahoma"
2270:             .FontSize      = 8
2271:             .Value         = 0.0

*-- Linhas 2277 a 2460:
2277:         BINDEVENT(loc_oPg.txt_4c_GetEncarg, "LostFocus", THIS, "TxtGetEncargLostFocus")
2278: 
2279:         *-- cmdCalcVals (T:507 L:678 W:40 H:40) - calcular valores
2280:         loc_oPg.AddObject("cmd_4c_CalcVals", "CommandButton")
2281:         WITH loc_oPg.cmd_4c_CalcVals
2282:             .Caption     = "Calc."
2283:             .Top         = 507
2284:             .Left        = 678
2285:             .Width       = 40
2286:             .Height      = 40
2287:             .FontName    = "Tahoma"
2288:             .FontSize    = 7
2289:             .Themes      = .F.
2290:             .SpecialEffect = 0
2291:             .BackColor   = RGB(255, 255, 255)
2292:             .ForeColor   = RGB(90, 90, 90)
2293:             .Enabled     = .F.
2294:             .Visible     = .T.
2295:         ENDWITH
2296:         BINDEVENT(loc_oPg.cmd_4c_CalcVals, "Click", THIS, "CmdCalcValsClick")
2297: 
2298:         *----------------------------------------------------------------------
2299:         *-- Container cntMtPrima (T:511 L:752 W:242 H:108)
2300:         *-- Controles internos: Composicao, Montagem, Digitos, Ordem, Casas
2301:         *----------------------------------------------------------------------
2302:         loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
2303:         WITH loc_oPg.cnt_4c_MtPrima
2304:             .Top         = 511
2305:             .Left        = 752
2306:             .Width       = 242
2307:             .Height      = 108
2308:             .BackStyle   = 1
2309:             .BackColor   = RGB(240, 240, 240)
2310:             .BorderWidth = 1
2311:             .Visible     = .T.
2312:         ENDWITH
2313: 
2314:         *-- lblCompos: "Composicao :" T:1 L:6 W:66
2315:         loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_LblCompos", "Label")
2316:         WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_LblCompos
2317:             .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
2318:             .Top       = 1
2319:             .Left      = 6
2320:             .Width     = 66
2321:             .Height    = 15
2322:             .FontName  = "Tahoma"
2323:             .FontSize  = 8
2324:             .BackStyle = 0
2325:             .ForeColor = RGB(90, 90, 90)
2326:             .Visible   = .T.
2327:         ENDWITH
2328: 
2329:         *-- getCompos: T:18 L:6 W:233
2330:         loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_Compos", "TextBox")
2331:         WITH loc_oPg.cnt_4c_MtPrima.txt_4c_Compos
2332:             .Top           = 18
2333:             .Left          = 6
2334:             .Width         = 233
2335:             .Height        = 21
2336:             .FontName      = "Tahoma"
2337:             .FontSize      = 8
2338:             .MaxLength     = 40
2339:             .Value         = ""
2340:             .SpecialEffect = 1
2341:             .Enabled       = .F.
2342:             .Visible       = .T.
2343:         ENDWITH
2344: 
2345:         *-- lblMontaDescs: "Montagem :" T:42 L:6 W:59
2346:         loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_LblMontagem", "Label")
2347:         WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_LblMontagem
2348:             .Caption   = "Montagem :"
2349:             .Top       = 42
2350:             .Left      = 6
2351:             .Width     = 59
2352:             .Height    = 15
2353:             .FontName  = "Tahoma"
2354:             .FontSize  = 8
2355:             .BackStyle = 0
2356:             .ForeColor = RGB(90, 90, 90)
2357:             .Visible   = .T.
2358:         ENDWITH
2359: 
2360:         *-- cmbMontaDescs: T:59 L:6 W:233 (ComboBox)
2361:         loc_oPg.cnt_4c_MtPrima.AddObject("cmb_4c_MontaDescs", "ComboBox")
2362:         WITH loc_oPg.cnt_4c_MtPrima.cmb_4c_MontaDescs
2363:             .Top       = 59
2364:             .Left      = 6
2365:             .Width     = 233
2366:             .Height    = 21
2367:             .FontName  = "Tahoma"
2368:             .FontSize  = 8
2369:             .Style     = 2
2370:             .Enabled   = .F.
2371:             .Visible   = .T.
2372:         ENDWITH
2373: 
2374:         *-- lblDigiMaxs: "Digitos :" T:88 L:4 W:41
2375:         loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_LblDigiMaxs", "Label")
2376:         WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_LblDigiMaxs
2377:             .Caption   = "D" + CHR(237) + "gitos :"
2378:             .Top       = 88
2379:             .Left      = 4
2380:             .Width     = 41
2381:             .Height    = 15
2382:             .FontName  = "Tahoma"
2383:             .FontSize  = 8
2384:             .BackStyle = 0
2385:             .ForeColor = RGB(90, 90, 90)
2386:             .Visible   = .T.
2387:         ENDWITH
2388: 
2389:         *-- getDigiMaxs: T:84 L:54 W:25
2390:         loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_DigiMaxs", "TextBox")
2391:         WITH loc_oPg.cnt_4c_MtPrima.txt_4c_DigiMaxs
2392:             .Top           = 84
2393:             .Left          = 54
2394:             .Width         = 25
2395:             .Height        = 21
2396:             .FontName      = "Tahoma"
2397:             .FontSize      = 8
2398:             .MaxLength     = 3
2399:             .Value         = 0
2400:             .SpecialEffect = 1
2401:             .Enabled       = .F.
2402:             .Visible       = .T.
2403:         ENDWITH
2404: 
2405:         *-- lblOrdCompos: "Ordem :" T:88 L:85 W:41
2406:         loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_LblOrdCompos", "Label")
2407:         WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_LblOrdCompos
2408:             .Caption   = "Ordem :"
2409:             .Top       = 88
2410:             .Left      = 85
2411:             .Width     = 41
2412:             .Height    = 15
2413:             .FontName  = "Tahoma"
2414:             .FontSize  = 8
2415:             .BackStyle = 0
2416:             .ForeColor = RGB(90, 90, 90)
2417:             .Visible   = .T.
2418:         ENDWITH
2419: 
2420:         *-- getOrdCompos: T:84 L:136 W:25
2421:         loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_OrdCompos", "TextBox")
2422:         WITH loc_oPg.cnt_4c_MtPrima.txt_4c_OrdCompos
2423:             .Top           = 84
2424:             .Left          = 136
2425:             .Width         = 25
2426:             .Height        = 21
2427:             .FontName      = "Tahoma"
2428:             .FontSize      = 8
2429:             .MaxLength     = 3
2430:             .Value         = 0
2431:             .SpecialEffect = 1
2432:             .Enabled       = .F.
2433:             .Visible       = .T.
2434:         ENDWITH
2435: 
2436:         *-- lblCasas: "Casas :" T:88 L:165 W:38
2437:         loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_LblCasas", "Label")
2438:         WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_LblCasas
2439:             .Caption   = "Casas :"
2440:             .Top       = 88
2441:             .Left      = 165
2442:             .Width     = 38
2443:             .Height    = 15
2444:             .FontName  = "Tahoma"
2445:             .FontSize  = 8
2446:             .BackStyle = 0
2447:             .ForeColor = RGB(90, 90, 90)
2448:             .Visible   = .T.
2449:         ENDWITH
2450: 
2451:         *-- getCasas: T:84 L:213 W:25
2452:         loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_Casas", "TextBox")
2453:         WITH loc_oPg.cnt_4c_MtPrima.txt_4c_Casas
2454:             .Top           = 84
2455:             .Left          = 213
2456:             .Width         = 25
2457:             .Height        = 21
2458:             .FontName      = "Tahoma"
2459:             .FontSize      = 8
2460:             .MaxLength     = 3

*-- Linhas 2522 a 2530:
2522:             loc_oPg.txt_4c_GetPftioc.Enabled   = loc_lLivre
2523:             loc_oPg.chk_4c_PlanCus.Enabled     = loc_lLivre
2524:             loc_oPg.txt_4c_Pesom.Enabled        = loc_lLivre
2525:             loc_oPg.cmd_4c_PesoM.Enabled        = loc_lLivre
2526:             loc_oPg.txt_4c_CotaCalcP.Enabled   = loc_lLivre
2527:         CATCH TO loc_oErro
2528:             MsgErro(loc_oErro.Message, "Erro ao alterar libera" + CHR(231) + CHR(227) + "o custo")
2529:         ENDTRY
2530:     ENDPROC

*-- Linhas 3289 a 3309:
3289:                 *-- Redefinir headers APOS cada Buscar() (VFP9 pode resetar)
3290:                 IF VARTYPE(loc_oPagina.grd_4c_Lista) = "O"
3291:                     loc_oGrid = loc_oPagina.grd_4c_Lista
3292:                     loc_oGrid.Column1.Header1.Caption = "Produto"
3293:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3294:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
3295:                     loc_oGrid.Column4.Header1.Caption = "Subgrp."
3296:                     loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
3297:                     loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
3298:                     loc_oGrid.Column7.Header1.Caption = "I"
3299:                     loc_oGrid.Refresh()
3300:                 ENDIF
3301: 
3302:                 *-- Atualizar contagem
3303:                 IF VARTYPE(loc_oPagina.lbl_4c_Contagem) = "O"
3304:                     loc_oPagina.lbl_4c_Contagem.Caption = "Produtos Selecionados : " + ;
3305:                         TRANSFORM(RECCOUNT("cursor_4c_Dados"))
3306:                 ENDIF
3307: 
3308:                 loc_lResultado = .T.
3309:             ENDIF

*-- Linhas 3860 a 3870:
3860:             loc_oPg.txt_4c_Tamls.Value     = IIF(.this_nTamls = 0, "", LTRIM(STR(.this_nTamls, 6, 2)))
3861:             loc_oPg.txt_4c_Volumes.Value   = IIF(.this_nVolumes = 0, "", LTRIM(STR(.this_nVolumes, 3, 0)))
3862:             *-- Memos
3863:             loc_oPg.edt_4c_DscCompras.Value = .this_cDsccompras
3864:             loc_oPg.edt_4c_DPro3s.Value    = .this_cDpro3s
3865:             loc_oPg.edt_4c_ObsCompras.Value = .this_cObscompras
3866:             *-- Dimensoes fisicas
3867:             loc_oPg.txt_4c_Altura.Value    = IIF(.this_nAltura = 0, "", LTRIM(STR(.this_nAltura, 8, 4)))
3868:             loc_oPg.txt_4c_Largura.Value   = IIF(.this_nLargura = 0, "", LTRIM(STR(.this_nLargura, 8, 4)))
3869:             loc_oPg.txt_4c_Diametro.Value  = IIF(.this_nDiametro = 0, "", LTRIM(STR(.this_nDiametro, 8, 4)))
3870:             loc_oPg.txt_4c_Espessura.Value = IIF(.this_nEspessura = 0, "", LTRIM(STR(.this_nEspessura, 8, 4)))

*-- Linhas 4057 a 4069:
4057: 
4058:         *-- Linha 1 (T:130-134): Produto / Descricao / Situacao
4059:         *-- Label2: "Produto :" (T:134 L:58 W:53 FontBold)
4060:         loc_oPg.AddObject("lbl_4c_LblProduto", "Label")
4061:         WITH loc_oPg.lbl_4c_LblProduto
4062:             .Caption   = "Produto :"
4063:             .Top       = 134
4064:             .Left      = 58
4065:             .Width     = 53
4066:             .Height    = 15
4067:             .FontName  = "Tahoma"
4068:             .FontSize  = 8
4069:             .FontBold  = .T.

*-- Linhas 4075 a 4084:
4075:         *-- getCpro -> txt_4c_Cpro (T:130 L:113 W:108 H:23) - PK do produto
4076:         loc_oPg.AddObject("txt_4c_Cpro", "TextBox")
4077:         WITH loc_oPg.txt_4c_Cpro
4078:             .Top           = 130
4079:             .Left          = 113
4080:             .Width         = 108
4081:             .Height        = 23
4082:             .FontName      = "Tahoma"
4083:             .FontSize      = 8
4084:             .MaxLength     = 14

*-- Linhas 4090 a 4099:
4090:         *-- getDpro -> txt_4c_Dpro (T:130 L:222 W:290 H:23) - descricao
4091:         loc_oPg.AddObject("txt_4c_Dpro", "TextBox")
4092:         WITH loc_oPg.txt_4c_Dpro
4093:             .Top           = 130
4094:             .Left          = 222
4095:             .Width         = 290
4096:             .Height        = 23
4097:             .FontName      = "Tahoma"
4098:             .FontSize      = 8
4099:             .MaxLength     = 65

*-- Linhas 4106 a 4167:
4106:         *-- Value=1 Ativo, Value=2 Inativo (situas numeric no banco)
4107:         loc_oPg.AddObject("obj_4c_Opc_situacao", "OptionGroup")
4108:         WITH loc_oPg.obj_4c_Opc_situacao
4109:             .Top         = 130
4110:             .Left        = 735
4111:             .Width       = 142
4112:             .Height      = 25
4113:             .ButtonCount = 2
4114:             .Value       = 1
4115:             .BorderStyle = 0
4116:             .Visible     = .T.
4117:         ENDWITH
4118:         WITH loc_oPg.obj_4c_Opc_situacao
4119:             .Buttons(1).Caption   = "Ativo"
4120:             .Buttons(1).Left      = 5
4121:             .Buttons(1).Top       = 5
4122:             .Buttons(1).Height    = 15
4123:             .Buttons(1).FontName  = "Tahoma"
4124:             .Buttons(1).FontSize  = 8
4125:             .Buttons(1).ForeColor = RGB(90, 90, 90)
4126:             .Buttons(1).BackStyle = 0
4127:             .Buttons(1).AutoSize  = .T.
4128:             .Buttons(1).Themes    = .F.
4129: 
4130:             .Buttons(2).Caption   = "Inativo - Ap" + CHR(243) + "s :"
4131:             .Buttons(2).Left      = 50
4132:             .Buttons(2).Top       = 5
4133:             .Buttons(2).Height    = 15
4134:             .Buttons(2).FontName  = "Tahoma"
4135:             .Buttons(2).FontSize  = 8
4136:             .Buttons(2).ForeColor = RGB(90, 90, 90)
4137:             .Buttons(2).BackStyle = 0
4138:             .Buttons(2).AutoSize  = .T.
4139:             .Buttons(2).Themes    = .F.
4140:         ENDWITH
4141: 
4142:         *-- Linha 2 (T:133-158): Equivalente / Descritivo / Barra
4143:         *-- Say2: "Equivalente :" (T:137 L:560 W:65)
4144:         loc_oPg.AddObject("lbl_4c_LblEquivalente", "Label")
4145:         WITH loc_oPg.lbl_4c_LblEquivalente
4146:             .Caption   = "Equivalente :"
4147:             .Top       = 137
4148:             .Left      = 560
4149:             .Width     = 65
4150:             .Height    = 15
4151:             .FontName  = "Tahoma"
4152:             .FontSize  = 8
4153:             .BackStyle = 0
4154:             .ForeColor = RGB(90, 90, 90)
4155:             .Visible   = .T.
4156:         ENDWITH
4157: 
4158:         *-- Get_CProEq -> txt_4c_CProEq (T:133 L:626 W:108 H:21)
4159:         loc_oPg.AddObject("txt_4c_CProEq", "TextBox")
4160:         WITH loc_oPg.txt_4c_CProEq
4161:             .Top           = 133
4162:             .Left          = 626
4163:             .Width         = 108
4164:             .Height        = 21
4165:             .FontName      = "Tahoma"
4166:             .FontSize      = 8
4167:             .MaxLength     = 14

*-- Linhas 4174 a 4230:
4174:         BINDEVENT(loc_oPg.txt_4c_CProEq, "LostFocus", THIS, "TxtCProEqLostFocus")
4175: 
4176:         *-- Say10: "Descritivo :" (T:158 L:55 W:56)
4177:         loc_oPg.AddObject("lbl_4c_LblDPro2", "Label")
4178:         WITH loc_oPg.lbl_4c_LblDPro2
4179:             .Caption   = "Descritivo :"
4180:             .Top       = 158
4181:             .Left      = 55
4182:             .Width     = 56
4183:             .Height    = 15
4184:             .FontName  = "Tahoma"
4185:             .FontSize  = 8
4186:             .BackStyle = 0
4187:             .ForeColor = RGB(90, 90, 90)
4188:             .Visible   = .T.
4189:         ENDWITH
4190: 
4191:         *-- getDPro2s -> txt_4c_DPro2s (T:154 L:113 W:399 H:23) - 2a descricao
4192:         loc_oPg.AddObject("txt_4c_DPro2s", "TextBox")
4193:         WITH loc_oPg.txt_4c_DPro2s
4194:             .Top           = 154
4195:             .Left          = 113
4196:             .Width         = 399
4197:             .Height        = 23
4198:             .FontName      = "Tahoma"
4199:             .FontSize      = 8
4200:             .MaxLength     = 45
4201:             .Value         = ""
4202:             .SpecialEffect = 1
4203:             .Visible       = .T.
4204:         ENDWITH
4205: 
4206:         *-- Say15: "Barra :" (T:157 L:590 W:35)
4207:         loc_oPg.AddObject("lbl_4c_LblBarra", "Label")
4208:         WITH loc_oPg.lbl_4c_LblBarra
4209:             .Caption   = "Barra :"
4210:             .Top       = 157
4211:             .Left      = 590
4212:             .Width     = 35
4213:             .Height    = 15
4214:             .FontName  = "Tahoma"
4215:             .FontSize  = 8
4216:             .BackStyle = 0
4217:             .ForeColor = RGB(90, 90, 90)
4218:             .Visible   = .T.
4219:         ENDWITH
4220: 
4221:         *-- getCbar -> txt_4c_Cbar (T:155 L:626 W:108 H:21) - cbars numeric(14,0)
4222:         loc_oPg.AddObject("txt_4c_Cbar", "TextBox")
4223:         WITH loc_oPg.txt_4c_Cbar
4224:             .Top           = 155
4225:             .Left          = 626
4226:             .Width         = 108
4227:             .Height        = 21
4228:             .FontName      = "Tahoma"
4229:             .FontSize      = 8
4230:             .MaxLength     = 14

*-- Linhas 4237 a 4263:
4237: 
4238:         *-- Linha 3 (T:177-182): Grupo / Mercadoria / Identificador / EAN13
4239:         *-- Say8: "Grupo :" (T:182 L:73 W:38)
4240:         loc_oPg.AddObject("lbl_4c_LblGrupoP", "Label")
4241:         WITH loc_oPg.lbl_4c_LblGrupoP
4242:             .Caption   = "Grupo :"
4243:             .Top       = 18
4244:             .Left      = 21
4245:             .Width     = 38
4246:             .Height    = 15
4247:             .FontName  = "Tahoma"
4248:             .FontSize  = 8
4249:             .BackStyle = 0
4250:             .ForeColor = RGB(90, 90, 90)
4251:             .Visible   = .T.
4252:         ENDWITH
4253: 
4254:         *-- getCgru -> txt_4c_CgruP (T:178 L:113 W:31 H:23) - codigo do grupo
4255:         loc_oPg.AddObject("txt_4c_CgruP", "TextBox")
4256:         WITH loc_oPg.txt_4c_CgruP
4257:             .Top           = 178
4258:             .Left          = 113
4259:             .Width         = 31
4260:             .Height        = 23
4261:             .FontName      = "Tahoma"
4262:             .FontSize      = 8
4263:             .MaxLength     = 3

*-- Linhas 4271 a 4280:
4271:         *-- getDgru -> txt_4c_DgruP (T:178 L:145 W:171 H:23) - desc grupo (readonly)
4272:         loc_oPg.AddObject("txt_4c_DgruP", "TextBox")
4273:         WITH loc_oPg.txt_4c_DgruP
4274:             .Top           = 178
4275:             .Left          = 145
4276:             .Width         = 171
4277:             .Height        = 23
4278:             .FontName      = "Tahoma"
4279:             .FontSize      = 8
4280:             .ReadOnly      = .T.

*-- Linhas 4286 a 4356:
4286:         *-- getMerc -> txt_4c_Merc (T:178 L:318 W:31 H:23) - mercadoria
4287:         loc_oPg.AddObject("txt_4c_Merc", "TextBox")
4288:         WITH loc_oPg.txt_4c_Merc
4289:             .Top           = 178
4290:             .Left          = 318
4291:             .Width         = 31
4292:             .Height        = 23
4293:             .FontName      = "Tahoma"
4294:             .FontSize      = 8
4295:             .MaxLength     = 3
4296:             .Value         = ""
4297:             .SpecialEffect = 1
4298:             .BackColor     = RGB(231, 242, 254)
4299:             .Visible       = .T.
4300:         ENDWITH
4301: 
4302:         *-- Say23: "Identificador :" (T:182 L:408 W:70)
4303:         loc_oPg.AddObject("lbl_4c_LblIdeCPros", "Label")
4304:         WITH loc_oPg.lbl_4c_LblIdeCPros
4305:             .Caption   = "Identificador :"
4306:             .Top       = 182
4307:             .Left      = 408
4308:             .Width     = 70
4309:             .Height    = 15
4310:             .FontName  = "Tahoma"
4311:             .FontSize  = 8
4312:             .BackStyle = 0
4313:             .ForeColor = RGB(90, 90, 90)
4314:             .Visible   = .T.
4315:         ENDWITH
4316: 
4317:         *-- getIdeCPros -> txt_4c_IdeCPros (T:178 L:481 W:31 H:23)
4318:         loc_oPg.AddObject("txt_4c_IdeCPros", "TextBox")
4319:         WITH loc_oPg.txt_4c_IdeCPros
4320:             .Top           = 178
4321:             .Left          = 481
4322:             .Width         = 31
4323:             .Height        = 23
4324:             .FontName      = "Tahoma"
4325:             .FontSize      = 8
4326:             .MaxLength     = 3
4327:             .Value         = ""
4328:             .SpecialEffect = 1
4329:             .Visible       = .T.
4330:         ENDWITH
4331: 
4332:         *-- Say1: "EAN/GTIN :" (T:181 L:568 W:57)
4333:         loc_oPg.AddObject("lbl_4c_LblEAN13", "Label")
4334:         WITH loc_oPg.lbl_4c_LblEAN13
4335:             .Caption   = "EAN/GTIN :"
4336:             .Top       = 181
4337:             .Left      = 568
4338:             .Width     = 57
4339:             .Height    = 15
4340:             .FontName  = "Tahoma"
4341:             .FontSize  = 8
4342:             .BackStyle = 0
4343:             .ForeColor = RGB(90, 90, 90)
4344:             .Visible   = .T.
4345:         ENDWITH
4346: 
4347:         *-- getEAN13 -> txt_4c_EAN13 (T:177 L:626 W:108 H:21) - ean13 numeric(13,0)
4348:         loc_oPg.AddObject("txt_4c_EAN13", "TextBox")
4349:         WITH loc_oPg.txt_4c_EAN13
4350:             .Top           = 177
4351:             .Left          = 626
4352:             .Width         = 108
4353:             .Height        = 21
4354:             .FontName      = "Tahoma"
4355:             .FontSize      = 8
4356:             .MaxLength     = 13

*-- Linhas 4363 a 4389:
4363: 
4364:         *-- Linha 4 (T:202-206): SubGrupo / Conjunto
4365:         *-- Say9: "Subgrupo :" (T:206 L:56 W:55)
4366:         loc_oPg.AddObject("lbl_4c_LblSubGrupo", "Label")
4367:         WITH loc_oPg.lbl_4c_LblSubGrupo
4368:             .Caption   = "Subgrupo :"
4369:             .Top       = 206
4370:             .Left      = 56
4371:             .Width     = 55
4372:             .Height    = 15
4373:             .FontName  = "Tahoma"
4374:             .FontSize  = 8
4375:             .BackStyle = 0
4376:             .ForeColor = RGB(90, 90, 90)
4377:             .Visible   = .T.
4378:         ENDWITH
4379: 
4380:         *-- GetCSGru -> txt_4c_CSGru (T:202 L:113 W:52 H:23) - codigo subgrupo
4381:         loc_oPg.AddObject("txt_4c_CSGru", "TextBox")
4382:         WITH loc_oPg.txt_4c_CSGru
4383:             .Top           = 202
4384:             .Left          = 113
4385:             .Width         = 52
4386:             .Height        = 23
4387:             .FontName      = "Tahoma"
4388:             .FontSize      = 8
4389:             .MaxLength     = 6

*-- Linhas 4397 a 4467:
4397:         *-- GetDsGru -> txt_4c_DsGru (T:202 L:166 W:150 H:23) - desc subgrupo (readonly)
4398:         loc_oPg.AddObject("txt_4c_DsGru", "TextBox")
4399:         WITH loc_oPg.txt_4c_DsGru
4400:             .Top           = 202
4401:             .Left          = 166
4402:             .Width         = 150
4403:             .Height        = 23
4404:             .FontName      = "Tahoma"
4405:             .FontSize      = 8
4406:             .ReadOnly      = .T.
4407:             .Value         = ""
4408:             .SpecialEffect = 1
4409:             .Visible       = .T.
4410:         ENDWITH
4411: 
4412:         *-- Say37: "Conjunto :" (T:206 L:408 W:53)
4413:         loc_oPg.AddObject("lbl_4c_LblConjunto", "Label")
4414:         WITH loc_oPg.lbl_4c_LblConjunto
4415:             .Caption   = "Conjunto :"
4416:             .Top       = 206
4417:             .Left      = 408
4418:             .Width     = 53
4419:             .Height    = 15
4420:             .FontName  = "Tahoma"
4421:             .FontSize  = 8
4422:             .BackStyle = 0
4423:             .ForeColor = RGB(90, 90, 90)
4424:             .Visible   = .T.
4425:         ENDWITH
4426: 
4427:         *-- getConjunto -> txt_4c_Conjunto (T:202 L:460 W:52 H:23)
4428:         loc_oPg.AddObject("txt_4c_Conjunto", "TextBox")
4429:         WITH loc_oPg.txt_4c_Conjunto
4430:             .Top           = 202
4431:             .Left          = 460
4432:             .Width         = 52
4433:             .Height        = 23
4434:             .FontName      = "Tahoma"
4435:             .FontSize      = 8
4436:             .Value         = ""
4437:             .SpecialEffect = 1
4438:             .Visible       = .T.
4439:         ENDWITH
4440:         BINDEVENT(loc_oPg.txt_4c_Conjunto, "KeyPress",  THIS, "TxtConjuntoKeyPress")
4441: 
4442:         *-- Linha 5 (T:226-230): Linha
4443:         *-- Say16: "Linha :" (T:230 L:77 W:34)
4444:         loc_oPg.AddObject("lbl_4c_LblLinha", "Label")
4445:         WITH loc_oPg.lbl_4c_LblLinha
4446:             .Caption   = "Linha :"
4447:             .Top       = 230
4448:             .Left      = 77
4449:             .Width     = 34
4450:             .Height    = 15
4451:             .FontName  = "Tahoma"
4452:             .FontSize  = 8
4453:             .BackStyle = 0
4454:             .ForeColor = RGB(90, 90, 90)
4455:             .Visible   = .T.
4456:         ENDWITH
4457: 
4458:         *-- GetLin -> txt_4c_Lin (T:226 L:113 W:80 H:23) - codigo de linha
4459:         loc_oPg.AddObject("txt_4c_Lin", "TextBox")
4460:         WITH loc_oPg.txt_4c_Lin
4461:             .Top           = 226
4462:             .Left          = 113
4463:             .Width         = 80
4464:             .Height        = 23
4465:             .FontName      = "Tahoma"
4466:             .FontSize      = 8
4467:             .Value         = ""

*-- Linhas 4474 a 4514:
4474:         *-- GetDLin -> txt_4c_DLin (T:226 L:194 W:318 H:23) - desc linha (readonly)
4475:         loc_oPg.AddObject("txt_4c_DLin", "TextBox")
4476:         WITH loc_oPg.txt_4c_DLin
4477:             .Top           = 226
4478:             .Left          = 194
4479:             .Width         = 318
4480:             .Height        = 23
4481:             .FontName      = "Tahoma"
4482:             .FontSize      = 8
4483:             .ReadOnly      = .T.
4484:             .Value         = ""
4485:             .SpecialEffect = 1
4486:             .Visible       = .T.
4487:         ENDWITH
4488: 
4489:         *-- Linha 6 (T:250-253): Grupo de Venda (Colecoes)
4490:         *-- Say17: "Grupo de Venda :" (T:253 L:25 W:86)
4491:         loc_oPg.AddObject("lbl_4c_LblGVenda", "Label")
4492:         WITH loc_oPg.lbl_4c_LblGVenda
4493:             .Caption   = "Grupo de Venda :"
4494:             .Top       = 253
4495:             .Left      = 25
4496:             .Width     = 86
4497:             .Height    = 15
4498:             .FontName  = "Tahoma"
4499:             .FontSize  = 8
4500:             .BackStyle = 0
4501:             .ForeColor = RGB(90, 90, 90)
4502:             .Visible   = .T.
4503:         ENDWITH
4504: 
4505:         *-- GetCol -> txt_4c_Col (T:250 L:113 W:80 H:23) - colecoes (grupo venda)
4506:         loc_oPg.AddObject("txt_4c_Col", "TextBox")
4507:         WITH loc_oPg.txt_4c_Col
4508:             .Top           = 250
4509:             .Left          = 113
4510:             .Width         = 80
4511:             .Height        = 23
4512:             .FontName      = "Tahoma"
4513:             .FontSize      = 8
4514:             .Value         = ""

*-- Linhas 4521 a 4561:
4521:         *-- GetDCol -> txt_4c_DCol (T:250 L:194 W:318 H:23) - desc grupo venda (readonly)
4522:         loc_oPg.AddObject("txt_4c_DCol", "TextBox")
4523:         WITH loc_oPg.txt_4c_DCol
4524:             .Top           = 250
4525:             .Left          = 194
4526:             .Width         = 318
4527:             .Height        = 23
4528:             .FontName      = "Tahoma"
4529:             .FontSize      = 8
4530:             .ReadOnly      = .T.
4531:             .Value         = ""
4532:             .SpecialEffect = 1
4533:             .Visible       = .T.
4534:         ENDWITH
4535: 
4536:         *-- Linha 7 (T:274-278): Fornecedor
4537:         *-- Say11: "Fornecedor :" (T:278 L:47 W:64)
4538:         loc_oPg.AddObject("lbl_4c_LblFornecedor", "Label")
4539:         WITH loc_oPg.lbl_4c_LblFornecedor
4540:             .Caption   = "Fornecedor :"
4541:             .Top       = 278
4542:             .Left      = 47
4543:             .Width     = 64
4544:             .Height    = 15
4545:             .FontName  = "Tahoma"
4546:             .FontSize  = 8
4547:             .BackStyle = 0
4548:             .ForeColor = RGB(90, 90, 90)
4549:             .Visible   = .T.
4550:         ENDWITH
4551: 
4552:         *-- getIfor -> txt_4c_Ifor (T:274 L:113 W:80 H:23) - codigo fornecedor
4553:         loc_oPg.AddObject("txt_4c_Ifor", "TextBox")
4554:         WITH loc_oPg.txt_4c_Ifor
4555:             .Top           = 274
4556:             .Left          = 113
4557:             .Width         = 80
4558:             .Height        = 23
4559:             .FontName      = "Tahoma"
4560:             .FontSize      = 8
4561:             .MaxLength     = 10

*-- Linhas 4569 a 4609:
4569:         *-- getDfor -> txt_4c_Dfor (T:274 L:194 W:318 H:23) - desc fornecedor (readonly)
4570:         loc_oPg.AddObject("txt_4c_Dfor", "TextBox")
4571:         WITH loc_oPg.txt_4c_Dfor
4572:             .Top           = 274
4573:             .Left          = 194
4574:             .Width         = 318
4575:             .Height        = 23
4576:             .FontName      = "Tahoma"
4577:             .FontSize      = 8
4578:             .ReadOnly      = .T.
4579:             .Value         = ""
4580:             .SpecialEffect = 1
4581:             .Visible       = .T.
4582:         ENDWITH
4583: 
4584:         *-- Linha 8 (T:298-301): Ref. Fornecedor
4585:         *-- Say12: "Ref. Fornecedor :" (T:301 L:23 W:88)
4586:         loc_oPg.AddObject("lbl_4c_LblRefs", "Label")
4587:         WITH loc_oPg.lbl_4c_LblRefs
4588:             .Caption   = "Ref. Fornecedor :"
4589:             .Top       = 301
4590:             .Left      = 23
4591:             .Width     = 88
4592:             .Height    = 15
4593:             .FontName  = "Tahoma"
4594:             .FontSize  = 8
4595:             .BackStyle = 0
4596:             .ForeColor = RGB(90, 90, 90)
4597:             .Visible   = .T.
4598:         ENDWITH
4599: 
4600:         *-- getRefs -> txt_4c_Refs (T:298 L:113 W:152 H:23) - referencia fornecedor
4601:         loc_oPg.AddObject("txt_4c_Refs", "TextBox")
4602:         WITH loc_oPg.txt_4c_Refs
4603:             .Top           = 298
4604:             .Left          = 113
4605:             .Width         = 152
4606:             .Height        = 23
4607:             .FontName      = "Tahoma"
4608:             .FontSize      = 8
4609:             .MaxLength     = 40

*-- Linhas 5230 a 5556:
5230:     * ConfigurarPgDadosP2 - Configura campos restantes da aba Dados
5231:     * Cobre: Qt.Pedido, Garantia, Dimensoes fisicas, Ultima Compra,
5232:     *        Modelo, Acabamento, Classif., Local, Custos, Unidades,
5233:     *        Auditoria, CodIdent, Checkboxes, Memos, Dimensoes embalagem
5234:     *--------------------------------------------------------------------------
5235:     PROTECTED PROCEDURE ConfigurarPgDadosP2()
5236:         LOCAL loc_oPg
5237:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5238: 
5239:         *----------------------------------------------------------------------
5240:         *-- Qt. Pedido (T:221 L:626) + Garantia (T:224 L:880)
5241:         *----------------------------------------------------------------------
5242:         loc_oPg.AddObject("lbl_4c_LblQtPed", "Label")
5243:         WITH loc_oPg.lbl_4c_LblQtPed
5244:             .Caption   = "Qt. Pedido :"
5245:             .Top       = 224
5246:             .Left      = 541
5247:             .Width     = 80
5248:             .Height    = 15
5249:             .FontName  = "Tahoma"
5250:             .FontSize  = 8
5251:             .BackStyle = 0
5252:             .ForeColor = RGB(90, 90, 90)
5253:             .Visible   = .T.
5254:         ENDWITH
5255: 
5256:         loc_oPg.AddObject("txt_4c_QtPed", "TextBox")
5257:         WITH loc_oPg.txt_4c_QtPed
5258:             .Top           = 221
5259:             .Left          = 626
5260:             .Width         = 80
5261:             .Height        = 21
5262:             .FontName      = "Tahoma"
5263:             .FontSize      = 8
5264:             .MaxLength     = 10
5265:             .Value         = ""
5266:             .SpecialEffect = 1
5267:             .Visible       = .T.
5268:         ENDWITH
5269: 
5270:         loc_oPg.AddObject("lbl_4c_LblGarantia", "Label")
5271:         WITH loc_oPg.lbl_4c_LblGarantia
5272:             .Caption   = "Gar.(dias):"
5273:             .Top       = 227
5274:             .Left      = 820
5275:             .Width     = 57
5276:             .Height    = 15
5277:             .FontName  = "Tahoma"
5278:             .FontSize  = 8
5279:             .BackStyle = 0
5280:             .ForeColor = RGB(90, 90, 90)
5281:             .Visible   = .T.
5282:         ENDWITH
5283: 
5284:         loc_oPg.AddObject("txt_4c_DiasGar", "TextBox")
5285:         WITH loc_oPg.txt_4c_DiasGar
5286:             .Top           = 224
5287:             .Left          = 880
5288:             .Width         = 34
5289:             .Height        = 21
5290:             .FontName      = "Tahoma"
5291:             .FontSize      = 8
5292:             .MaxLength     = 4
5293:             .Value         = ""
5294:             .SpecialEffect = 1
5295:             .Visible       = .T.
5296:         ENDWITH
5297: 
5298:         loc_oPg.AddObject("chk_4c_GarVit", "CheckBox")
5299:         WITH loc_oPg.chk_4c_GarVit
5300:             .Top       = 228
5301:             .Left      = 943
5302:             .Width     = 60
5303:             .Height    = 17
5304:             .Caption   = "Vital" + CHR(237) + "cia"
5305:             .FontName  = "Tahoma"
5306:             .FontSize  = 8
5307:             .BackStyle = 0
5308:             .ForeColor = RGB(90, 90, 90)
5309:             .Themes    = .F.
5310:             .Value     = 0
5311:             .Visible   = .T.
5312:         ENDWITH
5313: 
5314:         *----------------------------------------------------------------------
5315:         *-- Dimensoes fisicas (L:923): Altura/Largura/Diametro/Espessura/Comprimento
5316:         *----------------------------------------------------------------------
5317:         loc_oPg.AddObject("lbl_4c_LblAltura", "Label")
5318:         WITH loc_oPg.lbl_4c_LblAltura
5319:             .Caption   = "Altura :"
5320:             .Top       = 474
5321:             .Left      = 749
5322:             .Width     = 60
5323:             .Height    = 15
5324:             .FontName  = "Tahoma"
5325:             .FontSize  = 8
5326:             .BackStyle = 0
5327:             .ForeColor = RGB(90, 90, 90)
5328:             .Visible   = .T.
5329:         ENDWITH
5330: 
5331:         loc_oPg.AddObject("txt_4c_Altura", "TextBox")
5332:         WITH loc_oPg.txt_4c_Altura
5333:             .Top           = 247
5334:             .Left          = 923
5335:             .Width         = 48
5336:             .Height        = 21
5337:             .FontName      = "Tahoma"
5338:             .FontSize      = 8
5339:             .MaxLength     = 6
5340:             .Value         = ""
5341:             .SpecialEffect = 1
5342:             .Visible       = .T.
5343:         ENDWITH
5344: 
5345:         loc_oPg.AddObject("lbl_4c_MMAltura", "Label")
5346:         WITH loc_oPg.lbl_4c_MMAltura
5347:             .Caption   = "MM"
5348:             .Top       = 250
5349:             .Left      = 976
5350:             .Width     = 18
5351:             .Height    = 15
5352:             .FontName  = "Tahoma"
5353:             .FontSize  = 8
5354:             .BackStyle = 0
5355:             .ForeColor = RGB(90, 90, 90)
5356:             .Visible   = .T.
5357:         ENDWITH
5358: 
5359:         loc_oPg.AddObject("lbl_4c_LblLargura", "Label")
5360:         WITH loc_oPg.lbl_4c_LblLargura
5361:             .Caption   = "Largura :"
5362:             .Top       = 272
5363:             .Left      = 857
5364:             .Width     = 63
5365:             .Height    = 15
5366:             .FontName  = "Tahoma"
5367:             .FontSize  = 8
5368:             .BackStyle = 0
5369:             .ForeColor = RGB(90, 90, 90)
5370:             .Visible   = .T.
5371:         ENDWITH
5372: 
5373:         loc_oPg.AddObject("txt_4c_Largura", "TextBox")
5374:         WITH loc_oPg.txt_4c_Largura
5375:             .Top           = 269
5376:             .Left          = 923
5377:             .Width         = 48
5378:             .Height        = 21
5379:             .FontName      = "Tahoma"
5380:             .FontSize      = 8
5381:             .MaxLength     = 6
5382:             .Value         = ""
5383:             .SpecialEffect = 1
5384:             .Visible       = .T.
5385:         ENDWITH
5386: 
5387:         loc_oPg.AddObject("lbl_4c_MMLargura", "Label")
5388:         WITH loc_oPg.lbl_4c_MMLargura
5389:             .Caption   = "MM"
5390:             .Top       = 272
5391:             .Left      = 976
5392:             .Width     = 18
5393:             .Height    = 15
5394:             .FontName  = "Tahoma"
5395:             .FontSize  = 8
5396:             .BackStyle = 0
5397:             .ForeColor = RGB(90, 90, 90)
5398:             .Visible   = .T.
5399:         ENDWITH
5400: 
5401:         *-- Say49: "Diametro :" (T:293 L:867 W:52)
5402:         loc_oPg.AddObject("lbl_4c_LblDiametro", "Label")
5403:         WITH loc_oPg.lbl_4c_LblDiametro
5404:             .Caption   = "Di" + CHR(226) + "metro :"
5405:             .Top       = 293
5406:             .Left      = 867
5407:             .Width     = 52
5408:             .Height    = 15
5409:             .FontName  = "Tahoma"
5410:             .FontSize  = 8
5411:             .BackStyle = 0
5412:             .ForeColor = RGB(90, 90, 90)
5413:             .Visible   = .T.
5414:         ENDWITH
5415: 
5416:         loc_oPg.AddObject("txt_4c_Diametro", "TextBox")
5417:         WITH loc_oPg.txt_4c_Diametro
5418:             .Top           = 291
5419:             .Left          = 923
5420:             .Width         = 48
5421:             .Height        = 21
5422:             .FontName      = "Tahoma"
5423:             .FontSize      = 8
5424:             .MaxLength     = 6
5425:             .Value         = ""
5426:             .SpecialEffect = 1
5427:             .Visible       = .T.
5428:         ENDWITH
5429: 
5430:         loc_oPg.AddObject("lbl_4c_MMDiametro", "Label")
5431:         WITH loc_oPg.lbl_4c_MMDiametro
5432:             .Caption   = "MM"
5433:             .Top       = 294
5434:             .Left      = 976
5435:             .Width     = 18
5436:             .Height    = 15
5437:             .FontName  = "Tahoma"
5438:             .FontSize  = 8
5439:             .BackStyle = 0
5440:             .ForeColor = RGB(90, 90, 90)
5441:             .Visible   = .T.
5442:         ENDWITH
5443: 
5444:         *-- Say50: "Espessura :" (T:316 L:861 W:58)
5445:         loc_oPg.AddObject("lbl_4c_LblEspessura", "Label")
5446:         WITH loc_oPg.lbl_4c_LblEspessura
5447:             .Caption   = "Espessura :"
5448:             .Top       = 316
5449:             .Left      = 861
5450:             .Width     = 58
5451:             .Height    = 15
5452:             .FontName  = "Tahoma"
5453:             .FontSize  = 8
5454:             .BackStyle = 0
5455:             .ForeColor = RGB(90, 90, 90)
5456:             .Visible   = .T.
5457:         ENDWITH
5458: 
5459:         loc_oPg.AddObject("txt_4c_Espessura", "TextBox")
5460:         WITH loc_oPg.txt_4c_Espessura
5461:             .Top           = 313
5462:             .Left          = 923
5463:             .Width         = 48
5464:             .Height        = 21
5465:             .FontName      = "Tahoma"
5466:             .FontSize      = 8
5467:             .MaxLength     = 6
5468:             .Value         = ""
5469:             .SpecialEffect = 1
5470:             .Visible       = .T.
5471:         ENDWITH
5472: 
5473:         loc_oPg.AddObject("lbl_4c_MMEspessura", "Label")
5474:         WITH loc_oPg.lbl_4c_MMEspessura
5475:             .Caption   = "MM"
5476:             .Top       = 317
5477:             .Left      = 976
5478:             .Width     = 18
5479:             .Height    = 15
5480:             .FontName  = "Tahoma"
5481:             .FontSize  = 8
5482:             .BackStyle = 0
5483:             .ForeColor = RGB(90, 90, 90)
5484:             .Visible   = .T.
5485:         ENDWITH
5486: 
5487:         *-- Say51: "Comprimento :" (T:339 L:847 W:72)
5488:         loc_oPg.AddObject("lbl_4c_LblCompriment", "Label")
5489:         WITH loc_oPg.lbl_4c_LblCompriment
5490:             .Caption   = "Comprimento :"
5491:             .Top       = 339
5492:             .Left      = 847
5493:             .Width     = 72
5494:             .Height    = 15
5495:             .FontName  = "Tahoma"
5496:             .FontSize  = 8
5497:             .BackStyle = 0
5498:             .ForeColor = RGB(90, 90, 90)
5499:             .Visible   = .T.
5500:         ENDWITH
5501: 
5502:         loc_oPg.AddObject("txt_4c_Compriment", "TextBox")
5503:         WITH loc_oPg.txt_4c_Compriment
5504:             .Top           = 335
5505:             .Left          = 923
5506:             .Width         = 48
5507:             .Height        = 21
5508:             .FontName      = "Tahoma"
5509:             .FontSize      = 8
5510:             .MaxLength     = 6
5511:             .Value         = ""
5512:             .SpecialEffect = 1
5513:             .Visible       = .T.
5514:         ENDWITH
5515: 
5516:         loc_oPg.AddObject("lbl_4c_CMCompriment", "Label")
5517:         WITH loc_oPg.lbl_4c_CMCompriment
5518:             .Caption   = "CM"
5519:             .Top       = 340
5520:             .Left      = 976
5521:             .Width     = 17
5522:             .Height    = 15
5523:             .FontName  = "Tahoma"
5524:             .FontSize  = 8
5525:             .BackStyle = 0
5526:             .ForeColor = RGB(90, 90, 90)
5527:             .Visible   = .T.
5528:         ENDWITH
5529: 
5530:         *----------------------------------------------------------------------
5531:         *-- Ultima Compra (T:309-331) - Say19: "Ult.Compra :" (T:313 L:562)
5532:         *----------------------------------------------------------------------
5533:         loc_oPg.AddObject("lbl_4c_LblUltCompra", "Label")
5534:         WITH loc_oPg.lbl_4c_LblUltCompra
5535:             .Caption   = CHR(218) + "lt.Compra :"
5536:             .Top       = 313
5537:             .Left      = 562
5538:             .Width     = 63
5539:             .Height    = 15
5540:             .FontName  = "Tahoma"
5541:             .FontSize  = 8
5542:             .BackStyle = 0
5543:             .ForeColor = RGB(90, 90, 90)
5544:             .Visible   = .T.
5545:         ENDWITH
5546: 
5547:         *-- get_Dtucp -> txt_4c_Dtucp (T:309 L:626 W:79 H:21) - readonly
5548:         loc_oPg.AddObject("txt_4c_Dtucp", "TextBox")
5549:         WITH loc_oPg.txt_4c_Dtucp
5550:             .Top           = 309
5551:             .Left          = 626
5552:             .Width         = 79
5553:             .Height        = 21
5554:             .FontName      = "Tahoma"
5555:             .FontSize      = 8
5556:             .ReadOnly      = .T.

*-- Linhas 5564 a 5573:
5564:         *-- Get_vucp -> txt_4c_Vucp (T:309 L:706 W:106 H:21) - readonly
5565:         loc_oPg.AddObject("txt_4c_Vucp", "TextBox")
5566:         WITH loc_oPg.txt_4c_Vucp
5567:             .Top           = 309
5568:             .Left          = 706
5569:             .Width         = 106
5570:             .Height        = 21
5571:             .FontName      = "Tahoma"
5572:             .FontSize      = 8
5573:             .ReadOnly      = .T.

*-- Linhas 5581 a 5590:
5581:         *-- Get_mucp -> txt_4c_Mucp (T:309 L:813 W:33 H:21) - readonly
5582:         loc_oPg.AddObject("txt_4c_Mucp", "TextBox")
5583:         WITH loc_oPg.txt_4c_Mucp
5584:             .Top           = 309
5585:             .Left          = 813
5586:             .Width         = 33
5587:             .Height        = 21
5588:             .FontName      = "Tahoma"
5589:             .FontSize      = 8
5590:             .ReadOnly      = .T.

*-- Linhas 5596 a 5622:
5596:         ENDWITH
5597: 
5598:         *-- Say45: "Qtde Ult.Compra :" (T:335 L:535 W:90)
5599:         loc_oPg.AddObject("lbl_4c_LblQtdUltC", "Label")
5600:         WITH loc_oPg.lbl_4c_LblQtdUltC
5601:             .Caption   = "Qtde " + CHR(218) + "lt.Compra :"
5602:             .Top       = 335
5603:             .Left      = 535
5604:             .Width     = 90
5605:             .Height    = 15
5606:             .FontName  = "Tahoma"
5607:             .FontSize  = 8
5608:             .BackStyle = 0
5609:             .ForeColor = RGB(90, 90, 90)
5610:             .Visible   = .T.
5611:         ENDWITH
5612: 
5613:         *-- Get_qtdultcomp -> txt_4c_QtdUltComp (T:331 L:626 W:79 H:21) - readonly
5614:         loc_oPg.AddObject("txt_4c_QtdUltComp", "TextBox")
5615:         WITH loc_oPg.txt_4c_QtdUltComp
5616:             .Top           = 331
5617:             .Left          = 626
5618:             .Width         = 79
5619:             .Height        = 21
5620:             .FontName      = "Tahoma"
5621:             .FontSize      = 8
5622:             .ReadOnly      = .T.

*-- Linhas 5630 a 5656:
5630:         *----------------------------------------------------------------------
5631:         *-- Modelo (T:322) - lblModelo: "Modelo :" (T:326 L:7 W:104)
5632:         *----------------------------------------------------------------------
5633:         loc_oPg.AddObject("lbl_4c_LblModelo", "Label")
5634:         WITH loc_oPg.lbl_4c_LblModelo
5635:             .Caption   = "Modelo :"
5636:             .Top       = 326
5637:             .Left      = 7
5638:             .Width     = 104
5639:             .Height    = 15
5640:             .FontName  = "Tahoma"
5641:             .FontSize  = 8
5642:             .BackStyle = 0
5643:             .ForeColor = RGB(90, 90, 90)
5644:             .Visible   = .T.
5645:         ENDWITH
5646: 
5647:         *-- getCodFinP -> txt_4c_CodFinP (T:322 L:113 W:31 H:23) - codfinp char(3)
5648:         loc_oPg.AddObject("txt_4c_CodFinP", "TextBox")
5649:         WITH loc_oPg.txt_4c_CodFinP
5650:             .Top           = 322
5651:             .Left          = 113
5652:             .Width         = 31
5653:             .Height        = 23
5654:             .FontName      = "Tahoma"
5655:             .FontSize      = 8
5656:             .MaxLength     = 3

*-- Linhas 5662 a 5671:
5662:         *-- getDesFinP -> txt_4c_DFinP (T:322 L:145 W:150 H:23) - desc modelo (readonly)
5663:         loc_oPg.AddObject("txt_4c_DFinP", "TextBox")
5664:         WITH loc_oPg.txt_4c_DFinP
5665:             .Top           = 322
5666:             .Left          = 145
5667:             .Width         = 150
5668:             .Height        = 23
5669:             .FontName      = "Tahoma"
5670:             .FontSize      = 8
5671:             .ReadOnly      = .T.

*-- Linhas 5677 a 5703:
5677:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "LostFocus", THIS, "TxtCodFinPLostFocus")
5678: 
5679:         *-- Say35: "Peso Bruto :" (T:326 L:336 W:61)
5680:         loc_oPg.AddObject("lbl_4c_LblPesoBs", "Label")
5681:         WITH loc_oPg.lbl_4c_LblPesoBs
5682:             .Caption   = "Peso Bruto :"
5683:             .Top       = 326
5684:             .Left      = 336
5685:             .Width     = 61
5686:             .Height    = 15
5687:             .FontName  = "Tahoma"
5688:             .FontSize  = 8
5689:             .BackStyle = 0
5690:             .ForeColor = RGB(90, 90, 90)
5691:             .Visible   = .T.
5692:         ENDWITH
5693: 
5694:         *-- getPesoBs -> txt_4c_PesoBs (T:322 L:401 W:111 H:23) - pesobs numeric(7,3)
5695:         loc_oPg.AddObject("txt_4c_PesoBs", "TextBox")
5696:         WITH loc_oPg.txt_4c_PesoBs
5697:             .Top           = 322
5698:             .Left          = 401
5699:             .Width         = 111
5700:             .Height        = 23
5701:             .FontName      = "Tahoma"
5702:             .FontSize      = 8
5703:             .MaxLength     = 10

*-- Linhas 5709 a 5735:
5709:         *----------------------------------------------------------------------
5710:         *-- Acabamento (T:346) - lblAcabamento: "Acabamento :" (T:350 L:7)
5711:         *----------------------------------------------------------------------
5712:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
5713:         WITH loc_oPg.lbl_4c_LblAcabamento
5714:             .Caption   = "Acabamento :"
5715:             .Top       = 350
5716:             .Left      = 7
5717:             .Width     = 104
5718:             .Height    = 15
5719:             .FontName  = "Tahoma"
5720:             .FontSize  = 8
5721:             .BackStyle = 0
5722:             .ForeColor = RGB(90, 90, 90)
5723:             .Visible   = .T.
5724:         ENDWITH
5725: 
5726:         *-- get_codacb -> txt_4c_CodAcb (T:346 L:113 W:31 H:23) - codacbs char(3)
5727:         loc_oPg.AddObject("txt_4c_CodAcb", "TextBox")
5728:         WITH loc_oPg.txt_4c_CodAcb
5729:             .Top           = 346
5730:             .Left          = 113
5731:             .Width         = 31
5732:             .Height        = 23
5733:             .FontName      = "Tahoma"
5734:             .FontSize      = 8
5735:             .MaxLength     = 3

*-- Linhas 5741 a 5750:
5741:         *-- get_Dacb -> txt_4c_DAcb (T:346 L:145 W:150 H:23) - desc acabamento (readonly)
5742:         loc_oPg.AddObject("txt_4c_DAcb", "TextBox")
5743:         WITH loc_oPg.txt_4c_DAcb
5744:             .Top           = 346
5745:             .Left          = 145
5746:             .Width         = 150
5747:             .Height        = 23
5748:             .FontName      = "Tahoma"
5749:             .FontSize      = 8
5750:             .ReadOnly      = .T.

*-- Linhas 5756 a 5782:
5756:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "LostFocus", THIS, "TxtCodAcbLostFocus")
5757: 
5758:         *-- Say34: "Peso Liquido :" (T:350 L:329 W:68)
5759:         loc_oPg.AddObject("lbl_4c_LblPmedio", "Label")
5760:         WITH loc_oPg.lbl_4c_LblPmedio
5761:             .Caption   = "Peso L" + CHR(237) + "quido :"
5762:             .Top       = 350
5763:             .Left      = 329
5764:             .Width     = 68
5765:             .Height    = 15
5766:             .FontName  = "Tahoma"
5767:             .FontSize  = 8
5768:             .BackStyle = 0
5769:             .ForeColor = RGB(90, 90, 90)
5770:             .Visible   = .T.
5771:         ENDWITH
5772: 
5773:         *-- getPmedio -> txt_4c_Pmedio (T:346 L:401 W:111 H:23) - pesoms numeric(8,3)
5774:         loc_oPg.AddObject("txt_4c_Pmedio", "TextBox")
5775:         WITH loc_oPg.txt_4c_Pmedio
5776:             .Top           = 346
5777:             .Left          = 401
5778:             .Width         = 111
5779:             .Height        = 23
5780:             .FontName      = "Tahoma"
5781:             .FontSize      = 8
5782:             .MaxLength     = 10

*-- Linhas 5788 a 5814:
5788:         *----------------------------------------------------------------------
5789:         *-- Estoque (T:353) - Say28: "Estoque :" (T:357 L:577 W:48)
5790:         *----------------------------------------------------------------------
5791:         loc_oPg.AddObject("lbl_4c_LblEstoque", "Label")
5792:         WITH loc_oPg.lbl_4c_LblEstoque
5793:             .Caption   = "Estoque :"
5794:             .Top       = 357
5795:             .Left      = 577
5796:             .Width     = 48
5797:             .Height    = 15
5798:             .FontName  = "Tahoma"
5799:             .FontSize  = 8
5800:             .BackStyle = 0
5801:             .ForeColor = RGB(90, 90, 90)
5802:             .Visible   = .T.
5803:         ENDWITH
5804: 
5805:         *-- getEstoques -> txt_4c_Estoques (T:353 L:626 W:79 H:21) - display only
5806:         loc_oPg.AddObject("txt_4c_Estoques", "TextBox")
5807:         WITH loc_oPg.txt_4c_Estoques
5808:             .Top           = 353
5809:             .Left          = 626
5810:             .Width         = 79
5811:             .Height        = 21
5812:             .FontName      = "Tahoma"
5813:             .FontSize      = 8
5814:             .ReadOnly      = .T.

*-- Linhas 5822 a 5831:
5822:         *-- getQtdEsts -> txt_4c_QtdEsts (T:353 L:706 W:79 H:21) - display only
5823:         loc_oPg.AddObject("txt_4c_QtdEsts", "TextBox")
5824:         WITH loc_oPg.txt_4c_QtdEsts
5825:             .Top           = 353
5826:             .Left          = 706
5827:             .Width         = 79
5828:             .Height        = 21
5829:             .FontName      = "Tahoma"
5830:             .FontSize      = 8
5831:             .ReadOnly      = .T.

*-- Linhas 5839 a 5865:
5839:         *----------------------------------------------------------------------
5840:         *-- Classificacao e Local (T:370) - lblClassificacao (T:374 L:7)
5841:         *----------------------------------------------------------------------
5842:         loc_oPg.AddObject("lbl_4c_LblClass", "Label")
5843:         WITH loc_oPg.lbl_4c_LblClass
5844:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
5845:             .Top       = 374
5846:             .Left      = 7
5847:             .Width     = 104
5848:             .Height    = 15
5849:             .FontName  = "Tahoma"
5850:             .FontSize  = 8
5851:             .BackStyle = 0
5852:             .ForeColor = RGB(90, 90, 90)
5853:             .Visible   = .T.
5854:         ENDWITH
5855: 
5856:         *-- Get_Class -> txt_4c_Class (T:370 L:113 W:31 H:23) - cclass char(3)
5857:         loc_oPg.AddObject("txt_4c_Class", "TextBox")
5858:         WITH loc_oPg.txt_4c_Class
5859:             .Top           = 370
5860:             .Left          = 113
5861:             .Width         = 31
5862:             .Height        = 23
5863:             .FontName      = "Tahoma"
5864:             .FontSize      = 8
5865:             .MaxLength     = 3

*-- Linhas 5871 a 5880:
5871:         *-- Get_DClass -> txt_4c_DClass (T:370 L:145 W:150 H:23) - desc class (readonly)
5872:         loc_oPg.AddObject("txt_4c_DClass", "TextBox")
5873:         WITH loc_oPg.txt_4c_DClass
5874:             .Top           = 370
5875:             .Left          = 145
5876:             .Width         = 150
5877:             .Height        = 23
5878:             .FontName      = "Tahoma"
5879:             .FontSize      = 8
5880:             .ReadOnly      = .T.

*-- Linhas 5886 a 5912:
5886:         BINDEVENT(loc_oPg.txt_4c_Class, "LostFocus", THIS, "TxtClassLostFocus")
5887: 
5888:         *-- Say5: "Local :" (T:374 L:364 W:33)
5889:         loc_oPg.AddObject("lbl_4c_LblLocal", "Label")
5890:         WITH loc_oPg.lbl_4c_LblLocal
5891:             .Caption   = "Local :"
5892:             .Top       = 374
5893:             .Left      = 364
5894:             .Width     = 33
5895:             .Height    = 15
5896:             .FontName  = "Tahoma"
5897:             .FontSize  = 8
5898:             .BackStyle = 0
5899:             .ForeColor = RGB(90, 90, 90)
5900:             .Visible   = .T.
5901:         ENDWITH
5902: 
5903:         *-- Get_Local -> txt_4c_Local (T:370 L:401 W:111 H:23) - locals char(10)
5904:         loc_oPg.AddObject("txt_4c_Local", "TextBox")
5905:         WITH loc_oPg.txt_4c_Local
5906:             .Top           = 370
5907:             .Left          = 401
5908:             .Width         = 111
5909:             .Height        = 23
5910:             .FontName      = "Tahoma"
5911:             .FontSize      = 8
5912:             .MaxLength     = 10

*-- Linhas 5920 a 5946:
5920:         *----------------------------------------------------------------------
5921:         *-- Custo (T:375) - Say3: "Valor de Custo :" (T:379 L:546 W:79)
5922:         *----------------------------------------------------------------------
5923:         loc_oPg.AddObject("lbl_4c_LblCusto", "Label")
5924:         WITH loc_oPg.lbl_4c_LblCusto
5925:             .Caption   = "Valor de Custo :"
5926:             .Top       = 379
5927:             .Left      = 546
5928:             .Width     = 79
5929:             .Height    = 15
5930:             .FontName  = "Tahoma"
5931:             .FontSize  = 8
5932:             .BackStyle = 0
5933:             .ForeColor = RGB(90, 90, 90)
5934:             .Visible   = .T.
5935:         ENDWITH
5936: 
5937:         *-- getCtotal -> txt_4c_Ctotal (T:375 L:626 W:127 H:21) - custofs (display)
5938:         loc_oPg.AddObject("txt_4c_Ctotal", "TextBox")
5939:         WITH loc_oPg.txt_4c_Ctotal
5940:             .Top           = 375
5941:             .Left          = 626
5942:             .Width         = 127
5943:             .Height        = 21
5944:             .FontName      = "Tahoma"
5945:             .FontSize      = 8
5946:             .ReadOnly      = .T.

*-- Linhas 5955 a 5964:
5955:         *-- getMctotal -> txt_4c_Mctotal (T:375 L:754 W:31 H:21) - moecusfs (display)
5956:         loc_oPg.AddObject("txt_4c_Mctotal", "TextBox")
5957:         WITH loc_oPg.txt_4c_Mctotal
5958:             .Top           = 375
5959:             .Left          = 754
5960:             .Width         = 31
5961:             .Height        = 21
5962:             .FontName      = "Tahoma"
5963:             .FontSize      = 8
5964:             .ReadOnly      = .T.

*-- Linhas 5975 a 6047:
5975:         *-- Say20: "Data / Usuario" (T:365 L:833) header
5976:         *-- Say24: "Inclusao" (T:384 L:833) / Say25: "Alteracao" (T:384 L:914)
5977:         *----------------------------------------------------------------------
5978:         loc_oPg.AddObject("lbl_4c_LblAuditoria", "Label")
5979:         WITH loc_oPg.lbl_4c_LblAuditoria
5980:             .Caption   = "Data / Usu" + CHR(225) + "rio"
5981:             .Top       = 365
5982:             .Left      = 833
5983:             .Width     = 84
5984:             .Height    = 15
5985:             .FontName  = "Tahoma"
5986:             .FontSize  = 8
5987:             .FontBold  = .T.
5988:             .BackStyle = 0
5989:             .ForeColor = RGB(90, 90, 90)
5990:             .Visible   = .T.
5991:         ENDWITH
5992: 
5993:         loc_oPg.AddObject("lbl_4c_LblInclusao", "Label")
5994:         WITH loc_oPg.lbl_4c_LblInclusao
5995:             .Caption   = "Inclus" + CHR(227) + "o"
5996:             .Top       = 384
5997:             .Left      = 833
5998:             .Width     = 42
5999:             .Height    = 15
6000:             .FontName  = "Tahoma"
6001:             .FontSize  = 8
6002:             .BackStyle = 0
6003:             .ForeColor = RGB(90, 90, 90)
6004:             .Visible   = .T.
6005:         ENDWITH
6006: 
6007:         loc_oPg.AddObject("lbl_4c_LblAlteracao", "Label")
6008:         WITH loc_oPg.lbl_4c_LblAlteracao
6009:             .Caption   = "Altera" + CHR(231) + CHR(227) + "o"
6010:             .Top       = 384
6011:             .Left      = 914
6012:             .Width     = 48
6013:             .Height    = 15
6014:             .FontName  = "Tahoma"
6015:             .FontSize  = 8
6016:             .BackStyle = 0
6017:             .ForeColor = RGB(90, 90, 90)
6018:             .Visible   = .T.
6019:         ENDWITH
6020: 
6021:         *----------------------------------------------------------------------
6022:         *-- Unidades (T:394) - Say14: "Unidades (1) :" (T:398 L:41 W:70)
6023:         *----------------------------------------------------------------------
6024:         loc_oPg.AddObject("lbl_4c_LblUnidades", "Label")
6025:         WITH loc_oPg.lbl_4c_LblUnidades
6026:             .Caption   = "Unidades (1) :"
6027:             .Top       = 398
6028:             .Left      = 41
6029:             .Width     = 70
6030:             .Height    = 15
6031:             .FontName  = "Tahoma"
6032:             .FontSize  = 8
6033:             .BackStyle = 0
6034:             .ForeColor = RGB(90, 90, 90)
6035:             .Visible   = .T.
6036:         ENDWITH
6037: 
6038:         *-- Get_Cuni -> txt_4c_Cuni (T:394 L:113 W:31 H:23) - cunis char(3)
6039:         loc_oPg.AddObject("txt_4c_Cuni", "TextBox")
6040:         WITH loc_oPg.txt_4c_Cuni
6041:             .Top           = 394
6042:             .Left          = 113
6043:             .Width         = 31
6044:             .Height        = 23
6045:             .FontName      = "Tahoma"
6046:             .FontSize      = 8
6047:             .MaxLength     = 3

*-- Linhas 6055 a 6094:
6055:         *-- Get_Duni -> txt_4c_DUni (T:394 L:145 W:150 H:23) - desc unid1 (readonly)
6056:         loc_oPg.AddObject("txt_4c_DUni", "TextBox")
6057:         WITH loc_oPg.txt_4c_DUni
6058:             .Top           = 394
6059:             .Left          = 145
6060:             .Width         = 150
6061:             .Height        = 23
6062:             .FontName      = "Tahoma"
6063:             .FontSize      = 8
6064:             .ReadOnly      = .T.
6065:             .Value         = ""
6066:             .SpecialEffect = 1
6067:             .Visible       = .T.
6068:         ENDWITH
6069: 
6070:         *-- Say18: "(2) :" (T:398 L:301 W:23)
6071:         loc_oPg.AddObject("lbl_4c_LblUnid2", "Label")
6072:         WITH loc_oPg.lbl_4c_LblUnid2
6073:             .Caption   = "(2) :"
6074:             .Top       = 398
6075:             .Left      = 301
6076:             .Width     = 23
6077:             .Height    = 15
6078:             .FontName  = "Tahoma"
6079:             .FontSize  = 8
6080:             .BackStyle = 0
6081:             .ForeColor = RGB(90, 90, 90)
6082:             .Visible   = .T.
6083:         ENDWITH
6084: 
6085:         *-- Get_cunip -> txt_4c_Cunip (T:394 L:330 W:31 H:23) - cunips char(3)
6086:         loc_oPg.AddObject("txt_4c_Cunip", "TextBox")
6087:         WITH loc_oPg.txt_4c_Cunip
6088:             .Top           = 394
6089:             .Left          = 330
6090:             .Width         = 31
6091:             .Height        = 23
6092:             .FontName      = "Tahoma"
6093:             .FontSize      = 8
6094:             .MaxLength     = 3

*-- Linhas 6102 a 6111:
6102:         *-- get_dunip -> txt_4c_DUnip (T:394 L:362 W:150 H:23) - desc unid2 (readonly)
6103:         loc_oPg.AddObject("txt_4c_DUnip", "TextBox")
6104:         WITH loc_oPg.txt_4c_DUnip
6105:             .Top           = 394
6106:             .Left          = 362
6107:             .Width         = 150
6108:             .Height        = 23
6109:             .FontName      = "Tahoma"
6110:             .FontSize      = 8
6111:             .ReadOnly      = .T.

*-- Linhas 6118 a 6144:
6118:         *-- Preco Venda + Auditoria linha 1 (T:397)
6119:         *-- Say4: "Valor de Venda :" (T:400 L:505 W:120)
6120:         *----------------------------------------------------------------------
6121:         loc_oPg.AddObject("lbl_4c_LblPvenda", "Label")
6122:         WITH loc_oPg.lbl_4c_LblPvenda
6123:             .Caption   = "Valor de Venda :"
6124:             .Top       = 400
6125:             .Left      = 505
6126:             .Width     = 120
6127:             .Height    = 15
6128:             .FontName  = "Tahoma"
6129:             .FontSize  = 8
6130:             .BackStyle = 0
6131:             .ForeColor = RGB(90, 90, 90)
6132:             .Visible   = .T.
6133:         ENDWITH
6134: 
6135:         *-- getPvenda -> txt_4c_Pvenda (T:397 L:626 W:127 H:21) - pvens (display)
6136:         loc_oPg.AddObject("txt_4c_Pvenda", "TextBox")
6137:         WITH loc_oPg.txt_4c_Pvenda
6138:             .Top           = 397
6139:             .Left          = 626
6140:             .Width         = 127
6141:             .Height        = 21
6142:             .FontName      = "Tahoma"
6143:             .FontSize      = 8
6144:             .ReadOnly      = .T.

*-- Linhas 6153 a 6162:
6153:         *-- getMpvenda -> txt_4c_Mpvenda (T:397 L:754 W:31 H:21) - moevs (display)
6154:         loc_oPg.AddObject("txt_4c_Mpvenda", "TextBox")
6155:         WITH loc_oPg.txt_4c_Mpvenda
6156:             .Top           = 397
6157:             .Left          = 754
6158:             .Width         = 31
6159:             .Height        = 21
6160:             .FontName      = "Tahoma"
6161:             .FontSize      = 8
6162:             .ReadOnly      = .T.

*-- Linhas 6171 a 6180:
6171:         *-- Get_DtIncs -> txt_4c_DtIncs (T:397 L:833 W:79 H:21) - dtincs (display)
6172:         loc_oPg.AddObject("txt_4c_DtIncs", "TextBox")
6173:         WITH loc_oPg.txt_4c_DtIncs
6174:             .Top           = 397
6175:             .Left          = 833
6176:             .Width         = 79
6177:             .Height        = 21
6178:             .FontName      = "Tahoma"
6179:             .FontSize      = 8
6180:             .ReadOnly      = .T.

*-- Linhas 6188 a 6197:
6188:         *-- getDataAlts -> txt_4c_DataAlts (T:397 L:914 W:79 H:21) - dtalts (display)
6189:         loc_oPg.AddObject("txt_4c_DataAlts", "TextBox")
6190:         WITH loc_oPg.txt_4c_DataAlts
6191:             .Top           = 397
6192:             .Left          = 914
6193:             .Width         = 79
6194:             .Height        = 21
6195:             .FontName      = "Tahoma"
6196:             .FontSize      = 8
6197:             .ReadOnly      = .T.

*-- Linhas 6206 a 6262:
6206:         *-- CodIdent + Fator Venda + Auditoria linha 2 (T:418-419)
6207:         *-- Say38: "Cod. Identidade :" (T:422 L:24 W:87)
6208:         *----------------------------------------------------------------------
6209:         loc_oPg.AddObject("lbl_4c_LblCodIdent", "Label")
6210:         WITH loc_oPg.lbl_4c_LblCodIdent
6211:             .Caption   = "Cod. Identidade :"
6212:             .Top       = 422
6213:             .Left      = 24
6214:             .Width     = 87
6215:             .Height    = 15
6216:             .FontName  = "Tahoma"
6217:             .FontSize  = 8
6218:             .BackStyle = 0
6219:             .ForeColor = RGB(90, 90, 90)
6220:             .Visible   = .T.
6221:         ENDWITH
6222: 
6223:         *-- GetCodIdent -> txt_4c_CodIdent (T:418 L:113 W:182 H:23) - codident char(20)
6224:         loc_oPg.AddObject("txt_4c_CodIdent", "TextBox")
6225:         WITH loc_oPg.txt_4c_CodIdent
6226:             .Top           = 418
6227:             .Left          = 113
6228:             .Width         = 182
6229:             .Height        = 23
6230:             .FontName      = "Tahoma"
6231:             .FontSize      = 8
6232:             .MaxLength     = 20
6233:             .Value         = ""
6234:             .SpecialEffect = 1
6235:             .Visible       = .T.
6236:         ENDWITH
6237: 
6238:         *-- Say6: "Fator de Venda :" (T:422 L:539 W:86)
6239:         loc_oPg.AddObject("lbl_4c_LblFvenda", "Label")
6240:         WITH loc_oPg.lbl_4c_LblFvenda
6241:             .Caption   = "Fator de Venda :"
6242:             .Top       = 422
6243:             .Left      = 539
6244:             .Width     = 86
6245:             .Height    = 15
6246:             .FontName  = "Tahoma"
6247:             .FontSize  = 8
6248:             .BackStyle = 0
6249:             .ForeColor = RGB(90, 90, 90)
6250:             .Visible   = .T.
6251:         ENDWITH
6252: 
6253:         *-- getFvenda -> txt_4c_Fvenda (T:419 L:626 W:127 H:21) - fvendas (display)
6254:         loc_oPg.AddObject("txt_4c_Fvenda", "TextBox")
6255:         WITH loc_oPg.txt_4c_Fvenda
6256:             .Top           = 419
6257:             .Left          = 626
6258:             .Width         = 127
6259:             .Height        = 21
6260:             .FontName      = "Tahoma"
6261:             .FontSize      = 8
6262:             .ReadOnly      = .T.

*-- Linhas 6271 a 6280:
6271:         *-- getMfvenda -> txt_4c_Mfvenda (T:419 L:754 W:31 H:21) - moepvs (display)
6272:         loc_oPg.AddObject("txt_4c_Mfvenda", "TextBox")
6273:         WITH loc_oPg.txt_4c_Mfvenda
6274:             .Top           = 419
6275:             .Left          = 754
6276:             .Width         = 31
6277:             .Height        = 21
6278:             .FontName      = "Tahoma"
6279:             .FontSize      = 8
6280:             .ReadOnly      = .T.

*-- Linhas 6289 a 6298:
6289:         *-- Get_Usuario -> txt_4c_Usuario (T:419 L:833 W:79 H:21) - usuincs (display)
6290:         loc_oPg.AddObject("txt_4c_Usuario", "TextBox")
6291:         WITH loc_oPg.txt_4c_Usuario
6292:             .Top           = 419
6293:             .Left          = 833
6294:             .Width         = 79
6295:             .Height        = 21
6296:             .FontName      = "Tahoma"
6297:             .FontSize      = 8
6298:             .ReadOnly      = .T.

*-- Linhas 6306 a 6315:
6306:         *-- getUsuaAlts -> txt_4c_UsuaAlts (T:419 L:914 W:79 H:21) - usuaalts (display)
6307:         loc_oPg.AddObject("txt_4c_UsuaAlts", "TextBox")
6308:         WITH loc_oPg.txt_4c_UsuaAlts
6309:             .Top           = 419
6310:             .Left          = 914
6311:             .Width         = 79
6312:             .Height        = 21
6313:             .FontName      = "Tahoma"
6314:             .FontSize      = 8
6315:             .ReadOnly      = .T.

*-- Linhas 6321 a 6431:
6321:         ENDWITH
6322: 
6323:         *----------------------------------------------------------------------
6324:         *-- Entrega + Situacao/Checkboxes (T:447-451)
6325:         *-- Label9: "Entrega :" (T:451 L:884) / Label10: "Dias" (T:451 L:967)
6326:         *-- Say39: "Situacao :" (T:451 L:548 W:50)
6327:         *----------------------------------------------------------------------
6328:         loc_oPg.AddObject("lbl_4c_LblSituacao", "Label")
6329:         WITH loc_oPg.lbl_4c_LblSituacao
6330:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
6331:             .Top       = 451
6332:             .Left      = 548
6333:             .Width     = 50
6334:             .Height    = 15
6335:             .FontName  = "Tahoma"
6336:             .FontSize  = 8
6337:             .BackStyle = 0
6338:             .ForeColor = RGB(90, 90, 90)
6339:             .Visible   = .T.
6340:         ENDWITH
6341: 
6342:         loc_oPg.AddObject("lbl_4c_LblEntrega", "Label")
6343:         WITH loc_oPg.lbl_4c_LblEntrega
6344:             .Caption   = "Entrega :"
6345:             .Top       = 451
6346:             .Left      = 884
6347:             .Width     = 47
6348:             .Height    = 15
6349:             .FontName  = "Tahoma"
6350:             .FontSize  = 8
6351:             .BackStyle = 0
6352:             .ForeColor = RGB(90, 90, 90)
6353:             .Visible   = .T.
6354:         ENDWITH
6355: 
6356:         *-- getTEnts -> txt_4c_TEnts (T:447 L:934 W:31 H:22) - tents numeric(3,0)
6357:         loc_oPg.AddObject("txt_4c_TEnts", "TextBox")
6358:         WITH loc_oPg.txt_4c_TEnts
6359:             .Top           = 447
6360:             .Left          = 934
6361:             .Width         = 31
6362:             .Height        = 22
6363:             .FontName      = "Tahoma"
6364:             .FontSize      = 8
6365:             .MaxLength     = 3
6366:             .Value         = ""
6367:             .SpecialEffect = 1
6368:             .Visible       = .T.
6369:         ENDWITH
6370: 
6371:         loc_oPg.AddObject("lbl_4c_LblDiasEntr", "Label")
6372:         WITH loc_oPg.lbl_4c_LblDiasEntr
6373:             .Caption   = "Dias"
6374:             .Top       = 451
6375:             .Left      = 967
6376:             .Width     = 22
6377:             .Height    = 15
6378:             .FontName  = "Tahoma"
6379:             .FontSize  = 8
6380:             .BackStyle = 0
6381:             .ForeColor = RGB(90, 90, 90)
6382:             .Visible   = .T.
6383:         ENDWITH
6384: 
6385:         *-- get_Consig -> chk_4c_Consig (T:451 L:601) - consigs numeric(1,0)
6386:         loc_oPg.AddObject("chk_4c_Consig", "CheckBox")
6387:         WITH loc_oPg.chk_4c_Consig
6388:             .Top       = 451
6389:             .Left      = 601
6390:             .Width     = 75
6391:             .Height    = 17
6392:             .Caption   = "Consigna"
6393:             .FontName  = "Tahoma"
6394:             .FontSize  = 8
6395:             .BackStyle = 0
6396:             .ForeColor = RGB(90, 90, 90)
6397:             .Themes    = .F.
6398:             .Value     = 0
6399:             .Visible   = .T.
6400:         ENDWITH
6401: 
6402:         *-- chkFabrProprs -> chk_4c_FabrProprs (T:451 L:681) - fabrproprs numeric(1,0)
6403:         loc_oPg.AddObject("chk_4c_FabrProprs", "CheckBox")
6404:         WITH loc_oPg.chk_4c_FabrProprs
6405:             .Top       = 451
6406:             .Left      = 681
6407:             .Width     = 90
6408:             .Height    = 17
6409:             .Caption   = "Fabr. Pr" + CHR(243) + "pria"
6410:             .FontName  = "Tahoma"
6411:             .FontSize  = 8
6412:             .BackStyle = 0
6413:             .ForeColor = RGB(90, 90, 90)
6414:             .Themes    = .F.
6415:             .Value     = 0
6416:             .Visible   = .T.
6417:         ENDWITH
6418: 
6419:         *-- chkEncoms -> chk_4c_Encoms (T:451 L:781) - encoms numeric(1,0)
6420:         loc_oPg.AddObject("chk_4c_Encoms", "CheckBox")
6421:         WITH loc_oPg.chk_4c_Encoms
6422:             .Top       = 451
6423:             .Left      = 781
6424:             .Width     = 80
6425:             .Height    = 17
6426:             .Caption   = "Encomenda"
6427:             .FontName  = "Tahoma"
6428:             .FontSize  = 8
6429:             .BackStyle = 0
6430:             .ForeColor = RGB(90, 90, 90)
6431:             .Themes    = .F.

*-- Linhas 6437 a 6596:
6437:         *-- Memo: Descricao de Compra (T:448)
6438:         *-- Say31: "Descricao de : Compra ." (T:448 L:23 H:28)
6439:         *----------------------------------------------------------------------
6440:         loc_oPg.AddObject("lbl_4c_LblDscCompra", "Label")
6441:         WITH loc_oPg.lbl_4c_LblDscCompra
6442:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o de : Compra ."
6443:             .Top       = 448
6444:             .Left      = 23
6445:             .Width     = 88
6446:             .Height    = 28
6447:             .FontName  = "Tahoma"
6448:             .FontSize  = 8
6449:             .BackStyle = 0
6450:             .ForeColor = RGB(90, 90, 90)
6451:             .Visible   = .T.
6452:         ENDWITH
6453: 
6454:         *-- getdsccompras -> edt_4c_DscCompras (T:448 L:113 W:400 H:58)
6455:         loc_oPg.AddObject("edt_4c_DscCompras", "EditBox")
6456:         WITH loc_oPg.edt_4c_DscCompras
6457:             .Top           = 448
6458:             .Left          = 113
6459:             .Width         = 400
6460:             .Height        = 58
6461:             .FontName      = "Tahoma"
6462:             .FontSize      = 8
6463:             .Value         = ""
6464:             .SpecialEffect = 1
6465:             .Visible       = .T.
6466:         ENDWITH
6467: 
6468:         *----------------------------------------------------------------------
6469:         *-- Dimensoes embalagem (T:470) - Say27: "Dimensao :" (T:474 L:543)
6470:         *----------------------------------------------------------------------
6471:         loc_oPg.AddObject("lbl_4c_LblDimensao", "Label")
6472:         WITH loc_oPg.lbl_4c_LblDimensao
6473:             .Caption   = "Dimens" + CHR(227) + "o :"
6474:             .Top       = 474
6475:             .Left      = 543
6476:             .Width     = 55
6477:             .Height    = 15
6478:             .FontName  = "Tahoma"
6479:             .FontSize  = 8
6480:             .BackStyle = 0
6481:             .ForeColor = RGB(90, 90, 90)
6482:             .Visible   = .T.
6483:         ENDWITH
6484: 
6485:         *-- fwget6 -> txt_4c_Tamps (T:470 L:601 W:58 H:23) - tamps (Profundidade)
6486:         loc_oPg.AddObject("lbl_4c_LblTamps", "Label")
6487:         WITH loc_oPg.lbl_4c_LblTamps
6488:             .Caption   = "P"
6489:             .Top       = 474
6490:             .Left      = 661
6491:             .Width     = 20
6492:             .Height    = 15
6493:             .FontName  = "Tahoma"
6494:             .FontSize  = 8
6495:             .BackStyle = 0
6496:             .ForeColor = RGB(90, 90, 90)
6497:             .Visible   = .T.
6498:         ENDWITH
6499: 
6500:         loc_oPg.AddObject("txt_4c_Tamps", "TextBox")
6501:         WITH loc_oPg.txt_4c_Tamps
6502:             .Top           = 470
6503:             .Left          = 601
6504:             .Width         = 58
6505:             .Height        = 23
6506:             .FontName      = "Tahoma"
6507:             .FontSize      = 8
6508:             .MaxLength     = 6
6509:             .Value         = ""
6510:             .SpecialEffect = 1
6511:             .Visible       = .T.
6512:         ENDWITH
6513: 
6514:         *-- fwget5 -> txt_4c_Tamhs (T:470 L:688 W:58 H:23) - tamhs (Altura emb)
6515:         loc_oPg.AddObject("lbl_4c_LblTamhs", "Label")
6516:         WITH loc_oPg.lbl_4c_LblTamhs
6517:             .Caption   = "A"
6518:             .Top       = 474
6519:             .Left      = 749
6520:             .Width     = 20
6521:             .Height    = 15
6522:             .FontName  = "Tahoma"
6523:             .FontSize  = 8
6524:             .BackStyle = 0
6525:             .ForeColor = RGB(90, 90, 90)
6526:             .Visible   = .T.
6527:         ENDWITH
6528: 
6529:         loc_oPg.AddObject("txt_4c_Tamhs", "TextBox")
6530:         WITH loc_oPg.txt_4c_Tamhs
6531:             .Top           = 470
6532:             .Left          = 688
6533:             .Width         = 58
6534:             .Height        = 23
6535:             .FontName      = "Tahoma"
6536:             .FontSize      = 8
6537:             .MaxLength     = 6
6538:             .Value         = ""
6539:             .SpecialEffect = 1
6540:             .Visible       = .T.
6541:         ENDWITH
6542: 
6543:         *-- fwget4 -> txt_4c_Tamls (T:470 L:776 W:58 H:23) - tamls (Comprimento emb)
6544:         loc_oPg.AddObject("lbl_4c_LblTamls", "Label")
6545:         WITH loc_oPg.lbl_4c_LblTamls
6546:             .Caption   = "C"
6547:             .Top       = 474
6548:             .Left      = 836
6549:             .Width     = 17
6550:             .Height    = 15
6551:             .FontName  = "Tahoma"
6552:             .FontSize  = 8
6553:             .BackStyle = 0
6554:             .ForeColor = RGB(90, 90, 90)
6555:             .Visible   = .T.
6556:         ENDWITH
6557: 
6558:         loc_oPg.AddObject("txt_4c_Tamls", "TextBox")
6559:         WITH loc_oPg.txt_4c_Tamls
6560:             .Top           = 470
6561:             .Left          = 776
6562:             .Width         = 58
6563:             .Height        = 23
6564:             .FontName      = "Tahoma"
6565:             .FontSize      = 8
6566:             .MaxLength     = 6
6567:             .Value         = ""
6568:             .SpecialEffect = 1
6569:             .Visible       = .T.
6570:         ENDWITH
6571: 
6572:         *-- Say26: "Volumes :" (T:474 L:883 W:48)
6573:         loc_oPg.AddObject("lbl_4c_LblVolumes", "Label")
6574:         WITH loc_oPg.lbl_4c_LblVolumes
6575:             .Caption   = "Volumes :"
6576:             .Top       = 474
6577:             .Left      = 883
6578:             .Width     = 48
6579:             .Height    = 15
6580:             .FontName  = "Tahoma"
6581:             .FontSize  = 8
6582:             .BackStyle = 0
6583:             .ForeColor = RGB(90, 90, 90)
6584:             .Visible   = .T.
6585:         ENDWITH
6586: 
6587:         *-- fwget3 -> txt_4c_Volumes (T:470 L:934 W:31 H:23) - volumes numeric(3,0)
6588:         loc_oPg.AddObject("txt_4c_Volumes", "TextBox")
6589:         WITH loc_oPg.txt_4c_Volumes
6590:             .Top           = 470
6591:             .Left          = 934
6592:             .Width         = 31
6593:             .Height        = 23
6594:             .FontName      = "Tahoma"
6595:             .FontSize      = 8
6596:             .MaxLength     = 3

*-- Linhas 6603 a 6629:
6603:         *-- Memo: Descricao Completa (T:507)
6604:         *-- Say33: "Descricao : Completa ." (T:507 L:23 H:28)
6605:         *----------------------------------------------------------------------
6606:         loc_oPg.AddObject("lbl_4c_LblDPro3s", "Label")
6607:         WITH loc_oPg.lbl_4c_LblDPro3s
6608:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : Completa ."
6609:             .Top       = 507
6610:             .Left      = 23
6611:             .Width     = 88
6612:             .Height    = 28
6613:             .FontName  = "Tahoma"
6614:             .FontSize  = 8
6615:             .BackStyle = 0
6616:             .ForeColor = RGB(90, 90, 90)
6617:             .Visible   = .T.
6618:         ENDWITH
6619: 
6620:         *-- getDPro3s -> edt_4c_DPro3s (T:507 L:113 W:400 H:58)
6621:         loc_oPg.AddObject("edt_4c_DPro3s", "EditBox")
6622:         WITH loc_oPg.edt_4c_DPro3s
6623:             .Top           = 507
6624:             .Left          = 113
6625:             .Width         = 400
6626:             .Height        = 58
6627:             .FontName      = "Tahoma"
6628:             .FontSize      = 8
6629:             .Value         = ""

*-- Linhas 6635 a 6661:
6635:         *-- Memo: Observacao da Compra (T:566)
6636:         *-- Say32: "Observacao : da Compra ." (T:566 L:23 H:28)
6637:         *----------------------------------------------------------------------
6638:         loc_oPg.AddObject("lbl_4c_LblObsCompra", "Label")
6639:         WITH loc_oPg.lbl_4c_LblObsCompra
6640:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o : da Compra ."
6641:             .Top       = 566
6642:             .Left      = 23
6643:             .Width     = 88
6644:             .Height    = 28
6645:             .FontName  = "Tahoma"
6646:             .FontSize  = 8
6647:             .BackStyle = 0
6648:             .ForeColor = RGB(90, 90, 90)
6649:             .Visible   = .T.
6650:         ENDWITH
6651: 
6652:         *-- getObsCompras -> edt_4c_ObsCompras (T:566 L:113 W:400 H:58)
6653:         loc_oPg.AddObject("edt_4c_ObsCompras", "EditBox")
6654:         WITH loc_oPg.edt_4c_ObsCompras
6655:             .Top           = 566
6656:             .Left          = 113
6657:             .Width         = 400
6658:             .Height        = 58
6659:             .FontName      = "Tahoma"
6660:             .FontSize      = 8
6661:             .Value         = ""

*-- Linhas 7290 a 7299:
7290:         loc_oGrd = loc_oPg.grd_4c_GrdCons
7291: 
7292:         WITH loc_oGrd
7293:             .Top              = 155
7294:             .Left             = 6
7295:             .Width            = 987
7296:             .Height           = 362
7297:             .FontName         = "Tahoma"
7298:             .FontSize         = 8
7299:             .ColumnCount      = 9

*-- Linhas 7321 a 7385:
7321:         *-- Configurar colunas APOS RecordSource
7322:         WITH loc_oPg.grd_4c_GrdCons
7323:             *-- Col1: Componente (mats C14) W:140 - readonly
7324:             .Column1.Header1.Caption = "Componente"
7325:             .Column1.Width           = 140
7326:             .Column1.ControlSource   = "cursor_4c_GrdCons.mats"
7327:             .Column1.Alignment       = 0
7328:             .Column1.ReadOnly        = .T.
7329: 
7330:             *-- Col2: Qtde. (qtds N) W:70 - readonly
7331:             .Column2.Header1.Caption = "Qtde."
7332:             .Column2.Width           = 70
7333:             .Column2.ControlSource   = "cursor_4c_GrdCons.qtds"
7334:             .Column2.Alignment       = 1
7335:             .Column2.ReadOnly        = .T.
7336: 
7337:             *-- Col3: Uni (unicompos C5) W:40 - readonly
7338:             .Column3.Header1.Caption = "Uni"
7339:             .Column3.Width           = 40
7340:             .Column3.ControlSource   = "cursor_4c_GrdCons.unicompos"
7341:             .Column3.Alignment       = 0
7342:             .Column3.ReadOnly        = .T.
7343: 
7344:             *-- Col4: Fase (Grupos C3) W:45 - editable, F4 abre lookup SigCdPrf
7345:             .Column4.Header1.Caption = "Fase"
7346:             .Column4.Width           = 45
7347:             .Column4.ControlSource   = "cursor_4c_GrdCons.Grupos"
7348:             .Column4.Alignment       = 0
7349:             .Column4.ReadOnly        = .F.
7350: 
7351:             *-- Col5: Descricao de fase (Descrs C65) W:250 - editable quando Col4 vazia
7352:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7353:             .Column5.Width           = 250
7354:             .Column5.ControlSource   = "cursor_4c_GrdCons.Descrs"
7355:             .Column5.Alignment       = 0
7356:             .Column5.ReadOnly        = .F.
7357: 
7358:             *-- Col6: Ord. (Ordems N) W:40 - readonly
7359:             .Column6.Header1.Caption = "Ord."
7360:             .Column6.Width           = 40
7361:             .Column6.ControlSource   = "cursor_4c_GrdCons.Ordems"
7362:             .Column6.Alignment       = 1
7363:             .Column6.ReadOnly        = .T.
7364: 
7365:             *-- Col7: Consumo (consumo N) W:80 - editable em INCLUIR/ALTERAR
7366:             .Column7.Header1.Caption = "Consumo"
7367:             .Column7.Width           = 80
7368:             .Column7.ControlSource   = "cursor_4c_GrdCons.consumo"
7369:             .Column7.Alignment       = 1
7370:             .Column7.ReadOnly        = .F.
7371: 
7372:             *-- Col8: Cat. (Cods C5) W:45 - editable, F4 abre lookup SigCdCat
7373:             .Column8.Header1.Caption = "Cat."
7374:             .Column8.Width           = 45
7375:             .Column8.ControlSource   = "cursor_4c_GrdCons.Cods"
7376:             .Column8.Alignment       = 0
7377:             .Column8.ReadOnly        = .F.
7378: 
7379:             *-- Col9: Descricao de categoria (dcats C65) W:277 - editable
7380:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7381:             .Column9.Width           = 277
7382:             .Column9.ControlSource   = "cursor_4c_GrdCons.dcats"
7383:             .Column9.Alignment       = 0
7384:             .Column9.ReadOnly        = .F.
7385:         ENDWITH

*-- Linhas 7393 a 7405:
7393:         *----------------------------------------------------------------------
7394:         *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
7395:         *----------------------------------------------------------------------
7396:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
7397:         WITH loc_oPg.lbl_4c_Label7
7398:             .Caption   = "Qtde Componentes : "
7399:             .Top       = 523
7400:             .Left      = 25
7401:             .Width     = 105
7402:             .Height    = 15
7403:             .FontName  = "Tahoma"
7404:             .FontSize  = 8
7405:             .BackStyle = 0

*-- Linhas 7414 a 7444:
7414:         *----------------------------------------------------------------------
7415:         loc_oPg.AddObject("txt_4c_Qtcpnt", "TextBox")
7416:         WITH loc_oPg.txt_4c_Qtcpnt
7417:             .Top           = 519
7418:             .Left          = 131
7419:             .Width         = 31
7420:             .Height        = 23
7421:             .FontName      = "Tahoma"
7422:             .FontSize      = 8
7423:             .Value         = 0
7424:             .SpecialEffect = 1
7425:             .ForeColor     = RGB(36, 84, 155)
7426:             .Enabled       = .F.
7427:             .Visible       = .T.
7428:         ENDWITH
7429: 
7430:         *----------------------------------------------------------------------
7431:         *-- CheckBox chkFund (T:544 L:10 W:182 H:15)
7432:         *-- Caption: "Nao Checar Cadastro de Fundicao"
7433:         *-- Habilitado somente em modo edicao
7434:         *----------------------------------------------------------------------
7435:         loc_oPg.AddObject("chk_4c_ChkFund", "CheckBox")
7436:         WITH loc_oPg.chk_4c_ChkFund
7437:             .Caption   = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
7438:             .Top       = 544
7439:             .Left      = 10
7440:             .Width     = 182
7441:             .Height    = 15
7442:             .FontName  = "Tahoma"
7443:             .FontSize  = 8
7444:             .Value     = 0

*-- Linhas 7451 a 7463:
7451:         *----------------------------------------------------------------------
7452:         *-- Label "Tempo Producao por Agrupamento :" (Say1: T:521 L:642 W:176 H:15)
7453:         *----------------------------------------------------------------------
7454:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
7455:         WITH loc_oPg.lbl_4c_Label1
7456:             .Caption   = "Tempo Produ" + CHR(231) + CHR(227) + "o por Agrupamento :"
7457:             .Top       = 521
7458:             .Left      = 642
7459:             .Width     = 176
7460:             .Height    = 15
7461:             .FontName  = "Tahoma"
7462:             .FontSize  = 8
7463:             .BackStyle = 0

*-- Linhas 7473 a 7482:
7473:         loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
7474: 
7475:         WITH loc_oPg.grd_4c_GrDTEMP
7476:             .Top              = 519
7477:             .Left             = 821
7478:             .Width            = 172
7479:             .Height           = 107
7480:             .FontName         = "Tahoma"
7481:             .FontSize         = 8
7482:             .ColumnCount      = 2

*-- Linhas 7504 a 7519:
7504:         *-- Configurar colunas do grDTEMP APOS RecordSource
7505:         WITH loc_oPg.grd_4c_GrDTEMP
7506:             *-- Col1: Agrupamento (agrup C30) W:100 - readonly
7507:             .Column1.Header1.Caption = "Agrupamento"
7508:             .Column1.Width           = 100
7509:             .Column1.ControlSource   = "cursor_4c_GrDTEMP.agrup"
7510:             .Column1.Alignment       = 0
7511:             .Column1.ReadOnly        = .T.
7512: 
7513:             *-- Col2: Tempo % (tempo N) W:72 - readonly
7514:             .Column2.Header1.Caption = "Tempo %"
7515:             .Column2.Width           = 72
7516:             .Column2.ControlSource   = "cursor_4c_GrDTEMP.tempo"
7517:             .Column2.Alignment       = 1
7518:             .Column2.ReadOnly        = .T.
7519:         ENDWITH

*-- Linhas 7710 a 7739:
7710:         *----------------------------------------------------------------------
7711: 
7712:         *----------------------------------------------------------------------
7713:         *-- Tipo: lbl_4c_Label1 + cbo_4c_CmbTipos
7714:         *-- Say1: "Tipo :" T:159 L:112 W:29
7715:         *-- cmbTipos: T:154 L:143 W:187 H:23
7716:         *----------------------------------------------------------------------
7717:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
7718:         WITH loc_oPg.lbl_4c_Label1
7719:             .Caption   = "Tipo :"
7720:             .Top       = 159
7721:             .Left      = 112
7722:             .Width     = 29
7723:             .Height    = 15
7724:             .FontName  = "Tahoma"
7725:             .FontSize  = 8
7726:             .BackStyle = 0
7727:             .ForeColor = RGB(90, 90, 90)
7728:             .Visible   = .T.
7729:         ENDWITH
7730: 
7731:         loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
7732:         WITH loc_oPg.cbo_4c_CmbTipos
7733:             .Top           = 154
7734:             .Left          = 143
7735:             .Width         = 187
7736:             .Height        = 23
7737:             .FontName      = "Tahoma"
7738:             .FontSize      = 8
7739:             .RowSourceType = 0

*-- Linhas 7751 a 7760:
7751:         *----------------------------------------------------------------------
7752:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
7753:         WITH loc_oPg.grd_4c_CustoCompo
7754:             .Top               = 178
7755:             .Left              = 34
7756:             .Width             = 813
7757:             .Height            = 230
7758:             .ColumnCount       = 12
7759:             .FontName          = "Verdana"
7760:             .FontSize          = 8

*-- Linhas 7781 a 7968:
7781:         *-- Configurar colunas APOS RecordSource
7782:         WITH loc_oPg.grd_4c_CustoCompo
7783:             *-- Col1: Item/Material (C14) W:80
7784:             .Column1.Header1.Caption   = "Item"
7785:             .Column1.Width             = 80
7786:             .Column1.ControlSource     = "cursor_4c_Compo.mats"
7787:             .Column1.Alignment         = 0
7788: 
7789:             *-- Col2: Descricao (C65) W:185
7790:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
7791:             .Column2.Width             = 185
7792:             .Column2.ControlSource     = "cursor_4c_Compo.dcomps"
7793:             .Column2.Alignment         = 0
7794: 
7795:             *-- Col3: Un (C5) W:35 - readonly (When=.F.)
7796:             .Column3.Header1.Caption   = "Un"
7797:             .Column3.Width             = 35
7798:             .Column3.ControlSource     = "cursor_4c_Compo.unicompos"
7799:             .Column3.ReadOnly          = .T.
7800: 
7801:             *-- Col4: Valor (N12,4) W:65
7802:             .Column4.Header1.Caption   = "Valor"
7803:             .Column4.Width             = 65
7804:             .Column4.ControlSource     = "cursor_4c_Compo.pcompos"
7805:             .Column4.Alignment         = 1
7806: 
7807:             *-- Col5: Qtd (N12,4) W:55
7808:             .Column5.Header1.Caption   = "Qtd"
7809:             .Column5.Width             = 55
7810:             .Column5.ControlSource     = "cursor_4c_Compo.qtds"
7811:             .Column5.Alignment         = 1
7812: 
7813:             *-- Col6: Total (N12,4) W:65 - readonly (calculado, When=.F.)
7814:             .Column6.Header1.Caption   = "Total"
7815:             .Column6.Width             = 65
7816:             .Column6.ControlSource     = "cursor_4c_Compo.totals"
7817:             .Column6.Alignment         = 1
7818:             .Column6.ReadOnly          = .T.
7819: 
7820:             *-- Col7: Moe/Moeda (C5) W:35
7821:             .Column7.Header1.Caption   = "Moe"
7822:             .Column7.Width             = 35
7823:             .Column7.ControlSource     = "cursor_4c_Compo.bloqueio"
7824: 
7825:             *-- Col8: Observacao (C40) W:95
7826:             .Column8.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
7827:             .Column8.Width             = 95
7828:             .Column8.ControlSource     = "cursor_4c_Compo.obscompos"
7829:             .Column8.Alignment         = 0
7830: 
7831:             *-- Col9: Etiq (C1) W:30
7832:             .Column9.Header1.Caption   = "Etiq"
7833:             .Column9.Width             = 30
7834:             .Column9.ControlSource     = "cursor_4c_Compo.etiq"
7835: 
7836:             *-- Col10: Consumo (N12,4) W:65
7837:             .Column10.Header1.Caption  = "Consumo"
7838:             .Column10.Width            = 65
7839:             .Column10.ControlSource    = "cursor_4c_Compo.consumo"
7840:             .Column10.Alignment        = 1
7841: 
7842:             *-- Col11: Qtd cons (N12,4) W:55
7843:             .Column11.Header1.Caption  = "Qtd"
7844:             .Column11.Width            = 55
7845:             .Column11.ControlSource    = "cursor_4c_Compo.qtd2"
7846:             .Column11.Alignment        = 1
7847: 
7848:             *-- Col12: Un cons (C5) W:30 - readonly (When=.F.)
7849:             .Column12.Header1.Caption  = "Un"
7850:             .Column12.Width            = 30
7851:             .Column12.ControlSource    = "cursor_4c_Compo.uni2"
7852:             .Column12.ReadOnly         = .T.
7853:         ENDWITH
7854:         BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
7855: 
7856:         *----------------------------------------------------------------------
7857:         *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
7858:         *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
7859:         *----------------------------------------------------------------------
7860:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
7861:         WITH loc_oPg.cnt_4c_BotoesCusto
7862:             .Top         = 240
7863:             .Left        = 851
7864:             .Width       = 50
7865:             .Height      = 90
7866:             .BackStyle = 1
7867:             .BackColor = RGB(53, 53, 53)
7868:             .BorderWidth = 0
7869:             .Visible     = .T.
7870:         ENDWITH
7871: 
7872:         *-- Botao 1: Inserir componente de custo
7873:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_InserirCusto", "CommandButton")
7874:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto
7875:             .Caption       = "+"
7876:             .Top           = 0
7877:             .Left          = 0
7878:             .Width         = 50
7879:             .Height        = 45
7880:             .FontName      = "Tahoma"
7881:             .FontSize      = 10
7882:             .FontBold      = .T.
7883:             .Themes        = .F.
7884:             .SpecialEffect = 0
7885:             .BackColor     = RGB(255, 255, 255)
7886:             .ForeColor     = RGB(0, 128, 0)
7887:             .Visible       = .T.
7888:         ENDWITH
7889:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto, "Click", THIS, "CmdInserirCustoClick")
7890: 
7891:         *-- Botao 2: Excluir componente de custo
7892:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_ExcluirCusto", "CommandButton")
7893:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_ExcluirCusto
7894:             .Caption       = "-"
7895:             .Top           = 45
7896:             .Left          = 0
7897:             .Width         = 50
7898:             .Height        = 45
7899:             .FontName      = "Tahoma"
7900:             .FontSize      = 10
7901:             .FontBold      = .T.
7902:             .Themes        = .F.
7903:             .SpecialEffect = 0
7904:             .BackColor     = RGB(255, 255, 255)
7905:             .ForeColor     = RGB(192, 0, 0)
7906:             .Visible       = .T.
7907:         ENDWITH
7908:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_ExcluirCusto, "Click", THIS, "CmdExcluirCustoClick")
7909: 
7910:         *----------------------------------------------------------------------
7911:         *-- Linha Descricao / Grupo (abaixo do grid e botoes)
7912:         *-- Say16: "Descricao :" T:415 L:52 W:55
7913:         *-- Get_Desc: T:412 L:116 W:304 H:21 - readonly (When=.F.)
7914:         *-- Say2: "Grupo :" T:415 L:479 W:38
7915:         *-- getDGruCompos: T:412 L:522 W:304 H:21 - readonly (When=.F.)
7916:         *----------------------------------------------------------------------
7917:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
7918:         WITH loc_oPg.lbl_4c_Label16
7919:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
7920:             .Top       = 415
7921:             .Left      = 52
7922:             .Width     = 55
7923:             .Height    = 15
7924:             .FontName  = "Tahoma"
7925:             .FontSize  = 8
7926:             .BackStyle = 0
7927:             .ForeColor = RGB(90, 90, 90)
7928:             .Visible   = .T.
7929:         ENDWITH
7930: 
7931:         loc_oPg.AddObject("txt_4c_CustoDesc", "TextBox")
7932:         WITH loc_oPg.txt_4c_CustoDesc
7933:             .Top           = 412
7934:             .Left          = 116
7935:             .Width         = 304
7936:             .Height        = 21
7937:             .FontName      = "Tahoma"
7938:             .FontSize      = 8
7939:             .MaxLength     = 65
7940:             .Value         = ""
7941:             .SpecialEffect = 1
7942:             .Enabled       = .F.
7943:             .Visible       = .T.
7944:         ENDWITH
7945: 
7946:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
7947:         WITH loc_oPg.lbl_4c_Label2
7948:             .Caption   = "Grupo :"
7949:             .Top       = 134
7950:             .Left      = 58
7951:             .Width     = 38
7952:             .Height    = 15
7953:             .FontName  = "Tahoma"
7954:             .FontSize  = 8
7955:             .BackStyle = 0
7956:             .ForeColor = RGB(90, 90, 90)
7957:             .Visible   = .T.
7958:         ENDWITH
7959: 
7960:         loc_oPg.AddObject("txt_4c_DGruCompos", "TextBox")
7961:         WITH loc_oPg.txt_4c_DGruCompos
7962:             .Top           = 412
7963:             .Left          = 522
7964:             .Width         = 304
7965:             .Height        = 21
7966:             .FontName      = "Tahoma"
7967:             .FontSize      = 8
7968:             .MaxLength     = 65

*-- Linhas 7978 a 8017:
7978:         *-- Shape2: T:460 L:35 W:158 H:2
7979:         *-- GradeGRUPO2: T:468 L:35 W:195 H:141 - 3 colunas (Grp, Total, Moe)
7980:         *----------------------------------------------------------------------
7981:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
7982:         WITH loc_oPg.lbl_4c_Label3
7983:             .Caption   = "Resumo por Grupo"
7984:             .Top       = 445
7985:             .Left      = 35
7986:             .Width     = 107
7987:             .Height    = 15
7988:             .FontName  = "Tahoma"
7989:             .FontSize  = 8
7990:             .BackStyle = 0
7991:             .ForeColor = RGB(90, 90, 90)
7992:             .Visible   = .T.
7993:         ENDWITH
7994: 
7995:         loc_oPg.AddObject("shp_4c_Shape2", "Shape")
7996:         WITH loc_oPg.shp_4c_Shape2
7997:             .Top         = 460
7998:             .Left        = 35
7999:             .Width       = 158
8000:             .Height      = 2
8001:             .FillStyle   = 0
8002:             .BackStyle   = 1
8003:             .FillColor   = RGB(128, 128, 128)
8004:             .BorderStyle = 1
8005:             .Visible     = .T.
8006:         ENDWITH
8007: 
8008:         *-- GradeGRUPO2: grd_4c_GrupoCusto (3 cols) - usa cursor_4c_Grupo (compartilhado)
8009:         loc_oPg.AddObject("grd_4c_GrupoCusto", "Grid")
8010:         WITH loc_oPg.grd_4c_GrupoCusto
8011:             .Top               = 468
8012:             .Left              = 35
8013:             .Width             = 195
8014:             .Height            = 141
8015:             .ColumnCount       = 3
8016:             .FontName          = "Verdana"
8017:             .FontSize          = 8

*-- Linhas 8038 a 8059:
8038:         *-- Configurar colunas APOS RecordSource
8039:         WITH loc_oPg.grd_4c_GrupoCusto
8040:             *-- Col1: Grupo (C3) W:40 - readonly
8041:             .Column1.Header1.Caption   = "Grp"
8042:             .Column1.Width             = 40
8043:             .Column1.ControlSource     = "cursor_4c_Grupo.cgrus"
8044:             .Column1.ReadOnly          = .T.
8045: 
8046:             *-- Col2: Total (N12,4) W:100 - readonly
8047:             .Column2.Header1.Caption   = "Total"
8048:             .Column2.Width             = 100
8049:             .Column2.ControlSource     = "cursor_4c_Grupo.valgr"
8050:             .Column2.Alignment         = 1
8051:             .Column2.ReadOnly          = .T.
8052: 
8053:             *-- Col3: Moeda (C5) W:50 - readonly
8054:             .Column3.Header1.Caption   = "Moe"
8055:             .Column3.Width             = 50
8056:             .Column3.ControlSource     = "cursor_4c_Grupo.moeds"
8057:             .Column3.ReadOnly          = .T.
8058:         ENDWITH
8059:     ENDPROC

*-- Linhas 8180 a 8199:
8180:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
8181: 
8182:         IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
8183:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar) = "O"
8184:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEditando
8185:             ENDIF
8186:         ENDIF
8187:     ENDPROC
8188: 
8189:     *==========================================================================
8190:     * FASE 12 - Aba Fases de Producao (PgDadosFaseP - Page4 do pgf_4c_Dados)
8191:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP
8192:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8193:     * Controles: 2 grids (GradFase 5col + grdMatrizes 3col), 8 textboxes,
8194:     *            2 checkboxes, 1 editbox, labels, shapes, images, 8 commandbuttons
8195:     *==========================================================================
8196:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP()
8197:         LOCAL loc_oPg, loc_oGrd
8198:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8199: 

*-- Linhas 8232 a 8241:
8232:         *----------------------------------------------------------------------
8233:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
8234:         WITH loc_oPg.shp_4c_ShpFig
8235:             .Top         = 152
8236:             .Left        = 231
8237:             .Width       = 244
8238:             .Height      = 148
8239:             .BackStyle   = 1
8240:             .BackColor   = RGB(255, 255, 255)
8241:             .BorderColor = RGB(192, 192, 192)

*-- Linhas 8249 a 8258:
8249:         *----------------------------------------------------------------------
8250:         loc_oPg.AddObject("img_4c_ImgFigJpg", "Image")
8251:         WITH loc_oPg.img_4c_ImgFigJpg
8252:             .Top     = 153
8253:             .Left    = 232
8254:             .Width   = 241
8255:             .Height  = 146
8256:             .Picture = ""
8257:             .Stretch = 2
8258:             .Visible = .F.

*-- Linhas 8268 a 8277:
8268:         loc_oGrd = loc_oPg.grd_4c_GradFase
8269: 
8270:         WITH loc_oGrd
8271:             .Top                = 152
8272:             .Left               = 527
8273:             .Width              = 420
8274:             .Height             = 312
8275:             .FontName           = "Tahoma"
8276:             .FontSize           = 8
8277:             .ColumnCount        = 5

*-- Linhas 8299 a 8335:
8299:         *-- Configurar colunas APOS RecordSource
8300:         WITH loc_oPg.grd_4c_GradFase
8301:             *-- Col1: Ordem (Ordems N5) W:50 - readonly (When=.F. no legado)
8302:             .Column1.Header1.Caption = "Ordem"
8303:             .Column1.Width           = 50
8304:             .Column1.ControlSource   = "cursor_4c_GradFase.Ordems"
8305:             .Column1.Alignment       = 1
8306:             .Column1.ReadOnly        = .T.
8307: 
8308:             *-- Col2: Fase (Grupos C10) W:80 - editable, F4 lookup SigCdGcr
8309:             .Column2.Header1.Caption = "Fase"
8310:             .Column2.Width           = 80
8311:             .Column2.ControlSource   = "cursor_4c_GradFase.Grupos"
8312:             .Column2.Alignment       = 0
8313:             .Column2.ReadOnly        = .F.
8314: 
8315:             *-- Col3: Utilizacao (Descrs C65) W:130 - readonly
8316:             .Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8317:             .Column3.Width           = 130
8318:             .Column3.ControlSource   = "cursor_4c_GradFase.Descrs"
8319:             .Column3.Alignment       = 0
8320:             .Column3.ReadOnly        = .T.
8321: 
8322:             *-- Col4: Uni. Produtiva (UniPrdts C10) W:80 - editable, F4 lookup SigCdUpd
8323:             .Column4.Header1.Caption = "Uni. Produtiva"
8324:             .Column4.Width           = 80
8325:             .Column4.ControlSource   = "cursor_4c_GradFase.UniPrdts"
8326:             .Column4.Alignment       = 0
8327:             .Column4.ReadOnly        = .F.
8328: 
8329:             *-- Col5: Material (MatPrdts C15) W:80 - editable, F4 lookup SigOpOpt
8330:             .Column5.Header1.Caption = "Material"
8331:             .Column5.Width           = 80
8332:             .Column5.ControlSource   = "cursor_4c_GradFase.MatPrdts"
8333:             .Column5.Alignment       = 0
8334:             .Column5.ReadOnly        = .F.
8335:         ENDWITH

*-- Linhas 8346 a 8485:
8346:         *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
8347:         *-- Legado: inserir.Click - insere nova linha com resequenciamento
8348:         *----------------------------------------------------------------------
8349:         loc_oPg.AddObject("cmd_4c_IncluirFase", "CommandButton")
8350:         WITH loc_oPg.cmd_4c_IncluirFase
8351:             .Caption       = "+"
8352:             .Top           = 152
8353:             .Left          = 950
8354:             .Width         = 38
8355:             .Height        = 38
8356:             .FontName      = "Tahoma"
8357:             .FontSize      = 10
8358:             .FontBold      = .T.
8359:             .Themes        = .F.
8360:             .SpecialEffect = 0
8361:             .BackColor     = RGB(255, 255, 255)
8362:             .ForeColor     = RGB(0, 128, 0)
8363:             .Visible       = .T.
8364:         ENDWITH
8365:         BINDEVENT(loc_oPg.cmd_4c_IncluirFase, "Click", THIS, "CmdIncluirFaseClick")
8366: 
8367:         *----------------------------------------------------------------------
8368:         *-- Botao Excluir Fase (excluir: T:192 L:950 W:38 H:38)
8369:         *-- Legado: excluir.Click - exclui linha corrente e resequencia
8370:         *----------------------------------------------------------------------
8371:         loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
8372:         WITH loc_oPg.cmd_4c_ExcluirFase
8373:             .Caption       = "-"
8374:             .Top           = 192
8375:             .Left          = 950
8376:             .Width         = 38
8377:             .Height        = 38
8378:             .FontName      = "Tahoma"
8379:             .FontSize      = 10
8380:             .FontBold      = .T.
8381:             .Themes        = .F.
8382:             .SpecialEffect = 0
8383:             .BackColor     = RGB(255, 255, 255)
8384:             .ForeColor     = RGB(192, 0, 0)
8385:             .Visible       = .T.
8386:         ENDWITH
8387:         BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "CmdExcluirFaseClick")
8388: 
8389:         *----------------------------------------------------------------------
8390:         *-- Botao Alternativa (Alternativa: T:232 L:950 W:38 H:38)
8391:         *-- Legado: Alternativa.Click - copia linha corrente como alternativa
8392:         *----------------------------------------------------------------------
8393:         loc_oPg.AddObject("cmd_4c_AlternativaFase", "CommandButton")
8394:         WITH loc_oPg.cmd_4c_AlternativaFase
8395:             .Caption       = "A"
8396:             .Top           = 232
8397:             .Left          = 950
8398:             .Width         = 38
8399:             .Height        = 38
8400:             .FontName      = "Tahoma"
8401:             .FontSize      = 9
8402:             .Themes        = .F.
8403:             .SpecialEffect = 0
8404:             .BackColor     = RGB(255, 255, 255)
8405:             .ForeColor     = RGB(90, 90, 90)
8406:             .Visible       = .T.
8407:         ENDWITH
8408:         BINDEVENT(loc_oPg.cmd_4c_AlternativaFase, "Click", THIS, "CmdAlternativaFaseClick")
8409: 
8410:         *----------------------------------------------------------------------
8411:         *-- Botao Ficha Tecnica (CmdFicha: T:152 L:482 W:38 H:38)
8412:         *-- Legado: CmdFicha.Click - gera ficha tecnica com REPORT FORM
8413:         *----------------------------------------------------------------------
8414:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
8415:         WITH loc_oPg.cmd_4c_CmdFicha
8416:             .Caption       = "F"
8417:             .Top           = 152
8418:             .Left          = 482
8419:             .Width         = 38
8420:             .Height        = 38
8421:             .FontName      = "Tahoma"
8422:             .FontSize      = 9
8423:             .Themes        = .F.
8424:             .SpecialEffect = 0
8425:             .BackColor     = RGB(255, 255, 255)
8426:             .ForeColor     = RGB(90, 90, 90)
8427:             .Visible       = .T.
8428:         ENDWITH
8429:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
8430: 
8431:         *----------------------------------------------------------------------
8432:         *-- Botao Selecionar Imagem (cmdgFigura: T:192 L:482 W:40 H:40)
8433:         *-- Legado: cmdgFigura.Click - abre seletor GetPict JPG/BMP
8434:         *----------------------------------------------------------------------
8435:         loc_oPg.AddObject("cmd_4c_CmdgFigura", "CommandButton")
8436:         WITH loc_oPg.cmd_4c_CmdgFigura
8437:             .Caption       = "I"
8438:             .Top           = 192
8439:             .Left          = 482
8440:             .Width         = 40
8441:             .Height        = 40
8442:             .FontName      = "Tahoma"
8443:             .FontSize      = 9
8444:             .Themes        = .F.
8445:             .SpecialEffect = 0
8446:             .BackColor     = RGB(255, 255, 255)
8447:             .ForeColor     = RGB(90, 90, 90)
8448:             .Visible       = .T.
8449:         ENDWITH
8450:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
8451: 
8452:         *----------------------------------------------------------------------
8453:         *-- Botao Capturar Webcam (cmdgFigCam: T:232 L:482 W:40 H:40)
8454:         *-- Legado: cmdgFigCam.Click - captura imagem via SigImage form
8455:         *----------------------------------------------------------------------
8456:         loc_oPg.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
8457:         WITH loc_oPg.cmd_4c_CmdgFigCam
8458:             .Caption       = "C"
8459:             .Top           = 232
8460:             .Left          = 482
8461:             .Width         = 40
8462:             .Height        = 40
8463:             .FontName      = "Tahoma"
8464:             .FontSize      = 9
8465:             .Themes        = .F.
8466:             .SpecialEffect = 0
8467:             .BackColor     = RGB(255, 255, 255)
8468:             .ForeColor     = RGB(90, 90, 90)
8469:             .Visible       = .T.
8470:         ENDWITH
8471:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
8472: 
8473:         *----------------------------------------------------------------------
8474:         *-- Label Say1: "Descricao :" (T:474 L:527 W:67 H:17)
8475:         *----------------------------------------------------------------------
8476:         loc_oPg.AddObject("lbl_4c_Label1FP", "Label")
8477:         WITH loc_oPg.lbl_4c_Label1FP
8478:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
8479:             .Top       = 474
8480:             .Left      = 527
8481:             .Width     = 67
8482:             .Height    = 17
8483:             .FontName  = "Tahoma"
8484:             .FontSize  = 8
8485:             .BackStyle = 0

*-- Linhas 8493 a 8502:
8493:         *----------------------------------------------------------------------
8494:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
8495:         WITH loc_oPg.txt_4c_Desc
8496:             .Top           = 471
8497:             .Left          = 595
8498:             .Width         = 395
8499:             .Height        = 23
8500:             .Value         = ""
8501:             .FontName      = "Tahoma"
8502:             .FontSize      = 8

*-- Linhas 8513 a 8522:
8513:         *----------------------------------------------------------------------
8514:         loc_oPg.AddObject("obj_4c_Get_Obs", "EditBox")
8515:         WITH loc_oPg.obj_4c_Get_Obs
8516:             .Top           = 497
8517:             .Left          = 527
8518:             .Width         = 463
8519:             .Height        = 122
8520:             .Value         = ""
8521:             .FontName      = "Tahoma"
8522:             .FontSize      = 8

*-- Linhas 8533 a 8545:
8533:         *----------------------------------------------------------------------
8534: 
8535:         *-- Label Say13: "Qtd. Min. Producao :" (T:156 L:33 W:102 H:15)
8536:         loc_oPg.AddObject("lbl_4c_Label13FP", "Label")
8537:         WITH loc_oPg.lbl_4c_Label13FP
8538:             .Caption   = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
8539:             .Top       = 32
8540:             .Left      = 72
8541:             .Width     = 102
8542:             .Height    = 15
8543:             .FontName  = "Tahoma"
8544:             .FontSize  = 8
8545:             .BackStyle = 0

*-- Linhas 8551 a 8577:
8551:         *-- Legado: qmins de SigCdPro
8552:         loc_oPg.AddObject("txt_4c_Qmin", "TextBox")
8553:         WITH loc_oPg.txt_4c_Qmin
8554:             .Top           = 152
8555:             .Left          = 137
8556:             .Width         = 80
8557:             .Height        = 23
8558:             .Value         = 0
8559:             .FontName      = "Tahoma"
8560:             .FontSize      = 8
8561:             .SpecialEffect = 1
8562:             .ForeColor     = RGB(36, 84, 155)
8563:             .Enabled       = .F.
8564:             .Visible       = .T.
8565:         ENDWITH
8566: 
8567:         *-- Label Say5: "Garra :" (T:181 L:99 W:36 H:15)
8568:         loc_oPg.AddObject("lbl_4c_Label5FP", "Label")
8569:         WITH loc_oPg.lbl_4c_Label5FP
8570:             .Caption   = "Garra :"
8571:             .Top       = 181
8572:             .Left      = 99
8573:             .Width     = 36
8574:             .Height    = 15
8575:             .FontName  = "Tahoma"
8576:             .FontSize  = 8
8577:             .BackStyle = 0

*-- Linhas 8583 a 8592:
8583:         *-- Legado: codgarras de SigCdPro (readonly - somente exibicao)
8584:         loc_oPg.AddObject("txt_4c_CodGarras", "TextBox")
8585:         WITH loc_oPg.txt_4c_CodGarras
8586:             .Top           = 177
8587:             .Left          = 137
8588:             .Width         = 80
8589:             .Height        = 23
8590:             .Value         = ""
8591:             .FontName      = "Tahoma"
8592:             .FontSize      = 8

*-- Linhas 8599 a 8611:
8599:         ENDWITH
8600: 
8601:         *-- Label Say4: "Conquilha :" (T:206 L:79 W:56 H:15)
8602:         loc_oPg.AddObject("lbl_4c_Label4FP", "Label")
8603:         WITH loc_oPg.lbl_4c_Label4FP
8604:             .Caption   = "Conquilha :"
8605:             .Top       = 206
8606:             .Left      = 79
8607:             .Width     = 56
8608:             .Height    = 15
8609:             .FontName  = "Tahoma"
8610:             .FontSize  = 8
8611:             .BackStyle = 0

*-- Linhas 8617 a 8626:
8617:         *-- Legado: conquilhas de SigCdPro - LostFocus lookup SigCdCnq
8618:         loc_oPg.AddObject("txt_4c_Conquilha", "TextBox")
8619:         WITH loc_oPg.txt_4c_Conquilha
8620:             .Top           = 202
8621:             .Left          = 137
8622:             .Width         = 80
8623:             .Height        = 23
8624:             .Value         = ""
8625:             .FontName      = "Tahoma"
8626:             .FontSize      = 8

*-- Linhas 8632 a 8644:
8632:         BINDEVENT(loc_oPg.txt_4c_Conquilha, "LostFocus", THIS, "TxtConquilhaLostFocus")
8633: 
8634:         *-- Label Say9: "Peso Brilhante :" (T:231 L:58 W:77 H:15)
8635:         loc_oPg.AddObject("lbl_4c_Label9FP", "Label")
8636:         WITH loc_oPg.lbl_4c_Label9FP
8637:             .Caption   = "Peso Brilhante :"
8638:             .Top       = 451
8639:             .Left      = 884
8640:             .Width     = 77
8641:             .Height    = 15
8642:             .FontName  = "Tahoma"
8643:             .FontSize  = 8
8644:             .BackStyle = 0

*-- Linhas 8650 a 8676:
8650:         *-- Legado: pesobris de SigCdPro
8651:         loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
8652:         WITH loc_oPg.txt_4c_PesoBris
8653:             .Top           = 227
8654:             .Left          = 137
8655:             .Width         = 80
8656:             .Height        = 23
8657:             .Value         = 0
8658:             .FontName      = "Tahoma"
8659:             .FontSize      = 8
8660:             .SpecialEffect = 1
8661:             .ForeColor     = RGB(36, 84, 155)
8662:             .Enabled       = .F.
8663:             .Visible       = .T.
8664:         ENDWITH
8665: 
8666:         *-- Label Say10: "Peso Metal :" (T:256 L:74 W:61 H:15)
8667:         loc_oPg.AddObject("lbl_4c_Label10FP", "Label")
8668:         WITH loc_oPg.lbl_4c_Label10FP
8669:             .Caption   = "Peso Metal :"
8670:             .Top       = 451
8671:             .Left      = 967
8672:             .Width     = 61
8673:             .Height    = 15
8674:             .FontName  = "Tahoma"
8675:             .FontSize  = 8
8676:             .BackStyle = 0

*-- Linhas 8682 a 8708:
8682:         *-- Legado: pesometal de SigCdPro
8683:         loc_oPg.AddObject("txt_4c_PesoMetal", "TextBox")
8684:         WITH loc_oPg.txt_4c_PesoMetal
8685:             .Top           = 252
8686:             .Left          = 137
8687:             .Width         = 80
8688:             .Height        = 23
8689:             .Value         = 0
8690:             .FontName      = "Tahoma"
8691:             .FontSize      = 8
8692:             .SpecialEffect = 1
8693:             .ForeColor     = RGB(36, 84, 155)
8694:             .Enabled       = .F.
8695:             .Visible       = .T.
8696:         ENDWITH
8697: 
8698:         *-- Label Say8: "Peso Pedra :" (T:281 L:72 W:63 H:15)
8699:         loc_oPg.AddObject("lbl_4c_Label8FP", "Label")
8700:         WITH loc_oPg.lbl_4c_Label8FP
8701:             .Caption   = "Peso Pedra :"
8702:             .Top       = 5
8703:             .Left      = 8
8704:             .Width     = 63
8705:             .Height    = 15
8706:             .FontName  = "Tahoma"
8707:             .FontSize  = 8
8708:             .BackStyle = 0

*-- Linhas 8714 a 8740:
8714:         *-- Legado: pesopdrs de SigCdPro
8715:         loc_oPg.AddObject("txt_4c_PesoPdrs", "TextBox")
8716:         WITH loc_oPg.txt_4c_PesoPdrs
8717:             .Top           = 277
8718:             .Left          = 137
8719:             .Width         = 80
8720:             .Height        = 23
8721:             .Value         = 0
8722:             .FontName      = "Tahoma"
8723:             .FontSize      = 8
8724:             .SpecialEffect = 1
8725:             .ForeColor     = RGB(36, 84, 155)
8726:             .Enabled       = .F.
8727:             .Visible       = .T.
8728:         ENDWITH
8729: 
8730:         *-- Label Say7: "Cor Padrao :" (T:306 L:72 W:63 H:15)
8731:         loc_oPg.AddObject("lbl_4c_Label7FP", "Label")
8732:         WITH loc_oPg.lbl_4c_Label7FP
8733:             .Caption   = "Cor Padr" + CHR(227) + "o :"
8734:             .Top       = 306
8735:             .Left      = 72
8736:             .Width     = 63
8737:             .Height    = 15
8738:             .FontName  = "Tahoma"
8739:             .FontSize  = 8
8740:             .BackStyle = 0

*-- Linhas 8746 a 8791:
8746:         *-- Legado: codcors de SigCdPro - LostFocus lookup SigCdCor
8747:         loc_oPg.AddObject("txt_4c_Cor", "TextBox")
8748:         WITH loc_oPg.txt_4c_Cor
8749:             .Top           = 302
8750:             .Left          = 137
8751:             .Width         = 38
8752:             .Height        = 23
8753:             .Value         = ""
8754:             .FontName      = "Tahoma"
8755:             .FontSize      = 8
8756:             .SpecialEffect = 1
8757:             .ForeColor     = RGB(36, 84, 155)
8758:             .Enabled       = .F.
8759:             .Visible       = .T.
8760:         ENDWITH
8761:         BINDEVENT(loc_oPg.txt_4c_Cor, "LostFocus", THIS, "TxtCorLostFocus")
8762: 
8763:         *-- CheckBox opc_CravCera: "Cravacao em Cera" (T:306 L:180 W:120 H:15)
8764:         *-- Legado: cravcers de SigCdPro (numeric 1,0 com semantica booleana)
8765:         loc_oPg.AddObject("chk_4c_Opc_CravCera", "CheckBox")
8766:         WITH loc_oPg.chk_4c_Opc_CravCera
8767:             .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera"
8768:             .Top       = 306
8769:             .Left      = 180
8770:             .Width     = 120
8771:             .Height    = 15
8772:             .Value     = 0
8773:             .FontName  = "Tahoma"
8774:             .FontSize  = 8
8775:             .BackStyle = 0
8776:             .Themes    = .F.
8777:             .Enabled   = .F.
8778:             .Visible   = .T.
8779:         ENDWITH
8780: 
8781:         *-- Label Say2: "Tamanho Padrao :" (T:331 L:45 W:90 H:15)
8782:         loc_oPg.AddObject("lbl_4c_Label2FP", "Label")
8783:         WITH loc_oPg.lbl_4c_Label2FP
8784:             .Caption   = "Tamanho Padr" + CHR(227) + "o :"
8785:             .Top       = 331
8786:             .Left      = 45
8787:             .Width     = 90
8788:             .Height    = 15
8789:             .FontName  = "Tahoma"
8790:             .FontSize  = 8
8791:             .BackStyle = 0

*-- Linhas 8797 a 8842:
8797:         *-- Legado: codtams de SigCdPro - LostFocus lookup SigCdTam
8798:         loc_oPg.AddObject("txt_4c_Tam", "TextBox")
8799:         WITH loc_oPg.txt_4c_Tam
8800:             .Top           = 327
8801:             .Left          = 137
8802:             .Width         = 38
8803:             .Height        = 23
8804:             .Value         = ""
8805:             .FontName      = "Tahoma"
8806:             .FontSize      = 8
8807:             .SpecialEffect = 1
8808:             .ForeColor     = RGB(36, 84, 155)
8809:             .Enabled       = .F.
8810:             .Visible       = .T.
8811:         ENDWITH
8812:         BINDEVENT(loc_oPg.txt_4c_Tam, "LostFocus", THIS, "TxtTamLostFocus")
8813: 
8814:         *-- CheckBox fwoption1: "Peso Variavel" (T:331 L:180 W:90 H:15)
8815:         *-- Legado: prodvars de SigCdPro (numeric 1,0 com semantica booleana)
8816:         loc_oPg.AddObject("chk_4c_Fwoption1", "CheckBox")
8817:         WITH loc_oPg.chk_4c_Fwoption1
8818:             .Caption   = "Peso Vari" + CHR(225) + "vel"
8819:             .Top       = 172
8820:             .Left      = 879
8821:             .Width     = 90
8822:             .Height    = 15
8823:             .Value     = 0
8824:             .FontName  = "Tahoma"
8825:             .FontSize  = 8
8826:             .BackStyle = 0
8827:             .Themes    = .F.
8828:             .Enabled   = .F.
8829:             .Visible   = .T.
8830:         ENDWITH
8831: 
8832:         *-- Label lblAcabamento: "Acabamento :" (T:356 L:16 W:119 H:15)
8833:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
8834:         WITH loc_oPg.lbl_4c_LblAcabamento
8835:             .Caption   = "Acabamento :"
8836:             .Top       = 356
8837:             .Left      = 16
8838:             .Width     = 119
8839:             .Height    = 15
8840:             .FontName  = "Tahoma"
8841:             .FontSize  = 8
8842:             .BackStyle = 0

*-- Linhas 8848 a 8857:
8848:         *-- Legado: codacbs de SigCdPro - LostFocus lookup SigCdAca
8849:         loc_oPg.AddObject("txt_4c__codacb", "TextBox")
8850:         WITH loc_oPg.txt_4c__codacb
8851:             .Top           = 352
8852:             .Left          = 137
8853:             .Width         = 38
8854:             .Height        = 23
8855:             .Value         = ""
8856:             .FontName      = "Tahoma"
8857:             .FontSize      = 8

*-- Linhas 8866 a 8875:
8866:         *-- Legado: When=.F. (readonly sempre) - preenchido pelo lookup de get_codacb
8867:         loc_oPg.AddObject("txt_4c__Dacb", "TextBox")
8868:         WITH loc_oPg.txt_4c__Dacb
8869:             .Top           = 352
8870:             .Left          = 177
8871:             .Width         = 207
8872:             .Height        = 23
8873:             .Value         = ""
8874:             .FontName      = "Tahoma"
8875:             .FontSize      = 8

*-- Linhas 8891 a 8900:
8891:         loc_oGrd = loc_oPg.grd_4c_Matrizes
8892: 
8893:         WITH loc_oGrd
8894:             .Top                = 380
8895:             .Left               = 7
8896:             .Width              = 246
8897:             .Height             = 240
8898:             .FontName           = "Tahoma"
8899:             .FontSize           = 8
8900:             .ColumnCount        = 3

*-- Linhas 8922 a 8944:
8922:         *-- Configurar colunas APOS RecordSource
8923:         WITH loc_oPg.grd_4c_Matrizes
8924:             *-- Col1: Matriz (CMats C14) W:70 - editable, F4 lookup crMatrizes
8925:             .Column1.Header1.Caption = "Matriz"
8926:             .Column1.Width           = 70
8927:             .Column1.ControlSource   = "cursor_4c_SigPrMtz.CMats"
8928:             .Column1.Alignment       = 0
8929:             .Column1.ReadOnly        = .F.
8930: 
8931:             *-- Col2: Local (DLocs C40) W:120 - readonly (preenchido pelo lookup)
8932:             .Column2.Header1.Caption = "Local"
8933:             .Column2.Width           = 120
8934:             .Column2.ControlSource   = "cursor_4c_SigPrMtz.DLocs"
8935:             .Column2.Alignment       = 0
8936:             .Column2.ReadOnly        = .T.
8937: 
8938:             *-- Col3: Qtde (Qtds N3) W:56 - editable em modo edicao
8939:             .Column3.Header1.Caption = "Qtde"
8940:             .Column3.Width           = 56
8941:             .Column3.ControlSource   = "cursor_4c_SigPrMtz.Qtds"
8942:             .Column3.Alignment       = 1
8943:             .Column3.ReadOnly        = .F.
8944:         ENDWITH

*-- Linhas 8951 a 9005:
8951:         *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
8952:         *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
8953:         *----------------------------------------------------------------------
8954:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
8955:         WITH loc_oPg.cmd_4c_BtnInsereMtx
8956:             .Caption       = "+"
8957:             .Top           = 380
8958:             .Left          = 258
8959:             .Width         = 38
8960:             .Height        = 38
8961:             .FontName      = "Tahoma"
8962:             .FontSize      = 10
8963:             .FontBold      = .T.
8964:             .Themes        = .F.
8965:             .SpecialEffect = 0
8966:             .BackColor     = RGB(255, 255, 255)
8967:             .ForeColor     = RGB(0, 128, 0)
8968:             .Visible       = .T.
8969:         ENDWITH
8970:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInsereMtxClick")
8971: 
8972:         *----------------------------------------------------------------------
8973:         *-- Botao Excluir Matriz (btnExcluiMtz: T:420 L:258 W:38 H:38)
8974:         *-- Legado: btnExcluiMtz.Click - exclui linha de crSigPrMtz
8975:         *----------------------------------------------------------------------
8976:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
8977:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
8978:             .Caption       = "-"
8979:             .Top           = 420
8980:             .Left          = 258
8981:             .Width         = 38
8982:             .Height        = 38
8983:             .FontName      = "Tahoma"
8984:             .FontSize      = 10
8985:             .FontBold      = .T.
8986:             .Themes        = .F.
8987:             .SpecialEffect = 0
8988:             .BackColor     = RGB(255, 255, 255)
8989:             .ForeColor     = RGB(192, 0, 0)
8990:             .Visible       = .T.
8991:         ENDWITH
8992:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluiMtzClick")
8993: 
8994:         *----------------------------------------------------------------------
8995:         *-- Shape: shpBorracha (T:464 L:258 W:236 H:156) - borda imagem borracha
8996:         *----------------------------------------------------------------------
8997:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
8998:         WITH loc_oPg.shp_4c_ShpBorracha
8999:             .Top         = 464
9000:             .Left        = 258
9001:             .Width       = 236
9002:             .Height      = 156
9003:             .BackStyle   = 1
9004:             .BackColor   = RGB(255, 255, 255)
9005:             .BorderColor = RGB(192, 192, 192)

*-- Linhas 9013 a 9022:
9013:         *----------------------------------------------------------------------
9014:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
9015:         WITH loc_oPg.img_4c_ImgBorracha
9016:             .Top     = 465
9017:             .Left    = 260
9018:             .Width   = 232
9019:             .Height  = 154
9020:             .Picture = ""
9021:             .Stretch = 2
9022:             .Visible = .F.

*-- Linhas 9048 a 9062:
9048:                     loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(.this_cConquilhas)
9049:                 ENDIF
9050:                 IF VARTYPE(loc_oPg.txt_4c_PesoBris) = "O"
9051:                     loc_oPg.txt_4c_PesoBris.Value = .this_nPesobris
9052:                 ENDIF
9053:                 IF VARTYPE(loc_oPg.txt_4c_PesoMetal) = "O"
9054:                     loc_oPg.txt_4c_PesoMetal.Value = .this_nPesometal
9055:                 ENDIF
9056:                 IF VARTYPE(loc_oPg.txt_4c_PesoPdrs) = "O"
9057:                     loc_oPg.txt_4c_PesoPdrs.Value = .this_nPesopdrs
9058:                 ENDIF
9059:                 IF VARTYPE(loc_oPg.txt_4c_Cor) = "O"
9060:                     loc_oPg.txt_4c_Cor.Value = ALLTRIM(.this_cCodcors)
9061:                 ENDIF
9062:                 IF VARTYPE(loc_oPg.txt_4c_Tam) = "O"

*-- Linhas 10128 a 10424:
10128:         *----------------------------------------------------------------------
10129:         *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
10130:         *----------------------------------------------------------------------
10131:         loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
10132:         WITH loc_oPg.lbl_4c_LblGruCus
10133:             .Caption   = "Grupo C.C. :"
10134:             .Top       = 165
10135:             .Left      = 138
10136:             .Width     = 63
10137:             .Height    = 15
10138:             .FontName  = "Tahoma"
10139:             .FontSize  = 8
10140:             .BackStyle = 0
10141:             .ForeColor = RGB(90, 90, 90)
10142:             .Visible   = .T.
10143:         ENDWITH
10144: 
10145:         loc_oPg.AddObject("lbl_4c_LblContaCus", "Label")
10146:         WITH loc_oPg.lbl_4c_LblContaCus
10147:             .Caption   = "Conta C.C. :"
10148:             .Top       = 189
10149:             .Left      = 138
10150:             .Width     = 63
10151:             .Height    = 15
10152:             .FontName  = "Tahoma"
10153:             .FontSize  = 8
10154:             .BackStyle = 0
10155:             .ForeColor = RGB(90, 90, 90)
10156:             .Visible   = .T.
10157:         ENDWITH
10158: 
10159:         *-- Say1: "Classificacao Fiscal :" (T:216 L:102 W:99)
10160:         loc_oPg.AddObject("lbl_4c_LblClfiscal", "Label")
10161:         WITH loc_oPg.lbl_4c_LblClfiscal
10162:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
10163:             .Top       = 216
10164:             .Left      = 102
10165:             .Width     = 99
10166:             .Height    = 15
10167:             .FontName  = "Tahoma"
10168:             .FontSize  = 8
10169:             .BackStyle = 0
10170:             .ForeColor = RGB(90, 90, 90)
10171:             .Visible   = .T.
10172:         ENDWITH
10173: 
10174:         *-- Say2: "Origem da Mercadoria :" (T:241 L:87 W:114)
10175:         loc_oPg.AddObject("lbl_4c_LblOrigmerc", "Label")
10176:         WITH loc_oPg.lbl_4c_LblOrigmerc
10177:             .Caption   = "Origem da Mercadoria :"
10178:             .Top       = 241
10179:             .Left      = 87
10180:             .Width     = 114
10181:             .Height    = 15
10182:             .FontName  = "Tahoma"
10183:             .FontSize  = 8
10184:             .BackStyle = 0
10185:             .ForeColor = RGB(90, 90, 90)
10186:             .Visible   = .T.
10187:         ENDWITH
10188: 
10189:         *-- Say3: "Situacao Tributaria ICMS :" (T:266 L:74 W:127)
10190:         loc_oPg.AddObject("lbl_4c_LblSittricm", "Label")
10191:         WITH loc_oPg.lbl_4c_LblSittricm
10192:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
10193:             .Top       = 266
10194:             .Left      = 74
10195:             .Width     = 127
10196:             .Height    = 15
10197:             .FontName  = "Tahoma"
10198:             .FontSize  = 8
10199:             .BackStyle = 0
10200:             .ForeColor = RGB(90, 90, 90)
10201:             .Visible   = .T.
10202:         ENDWITH
10203: 
10204:         *-- Say6: "Codigo de Servicos para ICMS :" (T:291 L:48 W:153)
10205:         loc_oPg.AddObject("lbl_4c_LblCodServs", "Label")
10206:         WITH loc_oPg.lbl_4c_LblCodServs
10207:             .Caption   = "C" + CHR(243) + "digo de Servi" + CHR(231) + "os para ICMS :"
10208:             .Top       = 291
10209:             .Left      = 48
10210:             .Width     = 153
10211:             .Height    = 15
10212:             .FontName  = "Tahoma"
10213:             .FontSize  = 8
10214:             .BackStyle = 0
10215:             .ForeColor = RGB(90, 90, 90)
10216:             .Visible   = .T.
10217:         ENDWITH
10218: 
10219:         *-- Say8: "Aliquota ICMS :" (T:291 L:250 W:76)
10220:         loc_oPg.AddObject("lbl_4c_LblIcms", "Label")
10221:         WITH loc_oPg.lbl_4c_LblIcms
10222:             .Caption   = "Al" + CHR(237) + "quota ICMS :"
10223:             .Top       = 291
10224:             .Left      = 250
10225:             .Width     = 76
10226:             .Height    = 15
10227:             .FontName  = "Tahoma"
10228:             .FontSize  = 8
10229:             .BackStyle = 0
10230:             .ForeColor = RGB(90, 90, 90)
10231:             .Visible   = .T.
10232:         ENDWITH
10233: 
10234:         *-- Say4: "Tipo de Tributacao :" (T:291 L:395 W:98)
10235:         loc_oPg.AddObject("lbl_4c_LblTpTrib", "Label")
10236:         WITH loc_oPg.lbl_4c_LblTpTrib
10237:             .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
10238:             .Top       = 291
10239:             .Left      = 395
10240:             .Width     = 98
10241:             .Height    = 15
10242:             .FontName  = "Tahoma"
10243:             .FontSize  = 8
10244:             .BackStyle = 0
10245:             .ForeColor = RGB(90, 90, 90)
10246:             .Visible   = .T.
10247:         ENDWITH
10248: 
10249:         *-- Say41: "IAT :" (T:290 L:558 W:26)
10250:         loc_oPg.AddObject("lbl_4c_LblIat", "Label")
10251:         WITH loc_oPg.lbl_4c_LblIat
10252:             .Caption   = "IAT :"
10253:             .Top       = 290
10254:             .Left      = 558
10255:             .Width     = 26
10256:             .Height    = 15
10257:             .FontName  = "Tahoma"
10258:             .FontSize  = 8
10259:             .BackStyle = 0
10260:             .ForeColor = RGB(90, 90, 90)
10261:             .Visible   = .T.
10262:         ENDWITH
10263: 
10264:         *-- Say42: "[A]rredondamento [T]runcamento" (T:290 L:609 W:165)
10265:         loc_oPg.AddObject("lbl_4c_LblIatDesc", "Label")
10266:         WITH loc_oPg.lbl_4c_LblIatDesc
10267:             .Caption   = "[A]rredondamento [T]runcamento"
10268:             .Top       = 290
10269:             .Left      = 609
10270:             .Width     = 165
10271:             .Height    = 15
10272:             .FontName  = "Tahoma"
10273:             .FontSize  = 8
10274:             .BackStyle = 0
10275:             .ForeColor = RGB(90, 90, 90)
10276:             .Visible   = .T.
10277:         ENDWITH
10278: 
10279:         *-- Say5: "Situacao Tributaria IPI :" (T:316 L:85 W:116)
10280:         loc_oPg.AddObject("lbl_4c_LblIpi", "Label")
10281:         WITH loc_oPg.lbl_4c_LblIpi
10282:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria IPI :"
10283:             .Top       = 316
10284:             .Left      = 85
10285:             .Width     = 116
10286:             .Height    = 15
10287:             .FontName  = "Tahoma"
10288:             .FontSize  = 8
10289:             .BackStyle = 0
10290:             .ForeColor = RGB(90, 90, 90)
10291:             .Visible   = .T.
10292:         ENDWITH
10293: 
10294:         *-- Say_AliqIPI: "Aliquota de IPI :" (T:316 L:327 W:80)
10295:         loc_oPg.AddObject("lbl_4c_LblAliqIPI", "Label")
10296:         WITH loc_oPg.lbl_4c_LblAliqIPI
10297:             .Caption   = "Al" + CHR(237) + "quota de IPI :"
10298:             .Top       = 316
10299:             .Left      = 327
10300:             .Width     = 80
10301:             .Height    = 15
10302:             .FontName  = "Tahoma"
10303:             .FontSize  = 8
10304:             .BackStyle = 0
10305:             .ForeColor = RGB(90, 90, 90)
10306:             .Visible   = .T.
10307:         ENDWITH
10308: 
10309:         *-- Say13: "Excecao da TIPI :" (T:316 L:495 W:87)
10310:         loc_oPg.AddObject("lbl_4c_LblExtipi", "Label")
10311:         WITH loc_oPg.lbl_4c_LblExtipi
10312:             .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
10313:             .Top       = 316
10314:             .Left      = 495
10315:             .Width     = 87
10316:             .Height    = 15
10317:             .FontName  = "Tahoma"
10318:             .FontSize  = 8
10319:             .BackStyle = 0
10320:             .ForeColor = RGB(90, 90, 90)
10321:             .Visible   = .T.
10322:         ENDWITH
10323: 
10324:         *-- Say18: "Descricao Fiscal :" (T:341 L:117 W:84)
10325:         loc_oPg.AddObject("lbl_4c_LblDescfis", "Label")
10326:         WITH loc_oPg.lbl_4c_LblDescfis
10327:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
10328:             .Top       = 341
10329:             .Left      = 117
10330:             .Width     = 84
10331:             .Height    = 15
10332:             .FontName  = "Tahoma"
10333:             .FontSize  = 8
10334:             .BackStyle = 0
10335:             .ForeColor = RGB(90, 90, 90)
10336:             .Visible   = .T.
10337:         ENDWITH
10338: 
10339:         *-- Say12: "Descricao ECF :" (T:433 L:124 W:77)
10340:         loc_oPg.AddObject("lbl_4c_LblDescEcf", "Label")
10341:         WITH loc_oPg.lbl_4c_LblDescEcf
10342:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
10343:             .Top       = 433
10344:             .Left      = 124
10345:             .Width     = 77
10346:             .Height    = 15
10347:             .FontName  = "Tahoma"
10348:             .FontSize  = 8
10349:             .BackStyle = 0
10350:             .ForeColor = RGB(90, 90, 90)
10351:             .Visible   = .T.
10352:         ENDWITH
10353: 
10354:         *-- Say11: "Metal :" (T:433 L:494 W:35)
10355:         loc_oPg.AddObject("lbl_4c_LblMetal", "Label")
10356:         WITH loc_oPg.lbl_4c_LblMetal
10357:             .Caption   = "Metal :"
10358:             .Top       = 433
10359:             .Left      = 494
10360:             .Width     = 35
10361:             .Height    = 15
10362:             .FontName  = "Tahoma"
10363:             .FontSize  = 8
10364:             .BackStyle = 0
10365:             .ForeColor = RGB(90, 90, 90)
10366:             .Visible   = .T.
10367:         ENDWITH
10368: 
10369:         *-- Say7: "Valor Estimado :" (T:458 L:122 W:79)
10370:         loc_oPg.AddObject("lbl_4c_LblValor", "Label")
10371:         WITH loc_oPg.lbl_4c_LblValor
10372:             .Caption   = "Valor Estimado :"
10373:             .Top       = 458
10374:             .Left      = 122
10375:             .Width     = 79
10376:             .Height    = 15
10377:             .FontName  = "Tahoma"
10378:             .FontSize  = 8
10379:             .BackStyle = 0
10380:             .ForeColor = RGB(90, 90, 90)
10381:             .Visible   = .T.
10382:         ENDWITH
10383: 
10384:         *-- Say15: "Teor :" (T:458 L:498 W:31)
10385:         loc_oPg.AddObject("lbl_4c_LblTeor", "Label")
10386:         WITH loc_oPg.lbl_4c_LblTeor
10387:             .Caption   = "Teor :"
10388:             .Top       = 458
10389:             .Left      = 498
10390:             .Width     = 31
10391:             .Height    = 15
10392:             .FontName  = "Tahoma"
10393:             .FontSize  = 8
10394:             .BackStyle = 0
10395:             .ForeColor = RGB(90, 90, 90)
10396:             .Visible   = .T.
10397:         ENDWITH
10398: 
10399:         *-- Say10: "IPPT/CST :" (T:483 L:147 W:54)
10400:         loc_oPg.AddObject("lbl_4c_LblIpptCST", "Label")
10401:         WITH loc_oPg.lbl_4c_LblIpptCST
10402:             .Caption   = "IPPT/CST :"
10403:             .Top       = 483
10404:             .Left      = 147
10405:             .Width     = 54
10406:             .Height    = 15
10407:             .FontName  = "Tahoma"
10408:             .FontSize  = 8
10409:             .BackStyle = 0
10410:             .ForeColor = RGB(90, 90, 90)
10411:             .Visible   = .T.
10412:         ENDWITH
10413: 
10414:         *-- Say9: "Valor do Grama Produzido" (T:320 L:756 W:125)
10415:         loc_oPg.AddObject("lbl_4c_LblGramPro", "Label")
10416:         WITH loc_oPg.lbl_4c_LblGramPro
10417:             .Caption   = "Valor do Grama Produzido"
10418:             .Top       = 320
10419:             .Left      = 756
10420:             .Width     = 125
10421:             .Height    = 15
10422:             .FontName  = "Tahoma"
10423:             .FontSize  = 8
10424:             .BackStyle = 0

*-- Linhas 10432 a 10441:
10432:         *-- get_gruccus: Grupo de Custo (T:161 L:206 W:80 H:23)
10433:         loc_oPg.AddObject("txt_4c_Gruccus", "TextBox")
10434:         WITH loc_oPg.txt_4c_Gruccus
10435:             .Top           = 161
10436:             .Left          = 206
10437:             .Width         = 80
10438:             .Height        = 23
10439:             .Value         = ""
10440:             .FontName      = "Tahoma"
10441:             .FontSize      = 8

*-- Linhas 10449 a 10458:
10449:         *-- get_dgruccus: Descricao Grupo CC (T:161 L:288 W:318 H:23) readonly
10450:         loc_oPg.AddObject("txt_4c_Dgruccus", "TextBox")
10451:         WITH loc_oPg.txt_4c_Dgruccus
10452:             .Top           = 161
10453:             .Left          = 288
10454:             .Width         = 318
10455:             .Height        = 23
10456:             .Value         = ""
10457:             .FontName      = "Tahoma"
10458:             .FontSize      = 8

*-- Linhas 10466 a 10475:
10466:         *-- get_contaccus: Conta de Custo (T:186 L:206 W:80 H:23)
10467:         loc_oPg.AddObject("txt_4c_Contaccus", "TextBox")
10468:         WITH loc_oPg.txt_4c_Contaccus
10469:             .Top           = 186
10470:             .Left          = 206
10471:             .Width         = 80
10472:             .Height        = 23
10473:             .Value         = ""
10474:             .FontName      = "Tahoma"
10475:             .FontSize      = 8

*-- Linhas 10483 a 10492:
10483:         *-- get_dcontaccus: Descricao Conta CC (T:186 L:288 W:318 H:23) readonly
10484:         loc_oPg.AddObject("txt_4c_Dcontaccus", "TextBox")
10485:         WITH loc_oPg.txt_4c_Dcontaccus
10486:             .Top           = 186
10487:             .Left          = 288
10488:             .Width         = 318
10489:             .Height        = 23
10490:             .Value         = ""
10491:             .FontName      = "Tahoma"
10492:             .FontSize      = 8

*-- Linhas 10503 a 10512:
10503:         *-- getClfiscal: Classificacao Fiscal (T:211 L:206 W:94 H:23)
10504:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
10505:         WITH loc_oPg.txt_4c_Clfiscal
10506:             .Top           = 211
10507:             .Left          = 206
10508:             .Width         = 94
10509:             .Height        = 23
10510:             .Value         = ""
10511:             .FontName      = "Tahoma"
10512:             .FontSize      = 8

*-- Linhas 10520 a 10529:
10520:         *-- getDclfiscal: Descricao Classif. Fiscal (T:211 L:303 W:303 H:23) readonly
10521:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
10522:         WITH loc_oPg.txt_4c_Dclfiscal
10523:             .Top           = 211
10524:             .Left          = 303
10525:             .Width         = 303
10526:             .Height        = 23
10527:             .Value         = ""
10528:             .FontName      = "Tahoma"
10529:             .FontSize      = 8

*-- Linhas 10538 a 10547:
10538:         *-- getOrigmerc: Origem Mercadoria (T:236 L:206 W:17 H:23)
10539:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
10540:         WITH loc_oPg.txt_4c_Origmerc
10541:             .Top           = 236
10542:             .Left          = 206
10543:             .Width         = 17
10544:             .Height        = 23
10545:             .Value         = ""
10546:             .FontName      = "Tahoma"
10547:             .FontSize      = 8

*-- Linhas 10556 a 10565:
10556:         *-- Visivel apenas quando Origmerc vazio (readonly com busca reversa)
10557:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
10558:         WITH loc_oPg.txt_4c_Dorigmerc
10559:             .Top           = 236
10560:             .Left          = 226
10561:             .Width         = 380
10562:             .Height        = 23
10563:             .Value         = ""
10564:             .FontName      = "Tahoma"
10565:             .FontSize      = 8

*-- Linhas 10573 a 10582:
10573:         *-- getSittricm: Situacao Tributaria ICMS (T:261 L:206 W:31 H:23)
10574:         loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
10575:         WITH loc_oPg.txt_4c_Sittricm
10576:             .Top           = 261
10577:             .Left          = 206
10578:             .Width         = 31
10579:             .Height        = 23
10580:             .Value         = ""
10581:             .FontName      = "Tahoma"
10582:             .FontSize      = 8

*-- Linhas 10590 a 10599:
10590:         *-- getDsittricm: Descricao Sit. Trib. ICMS (T:261 L:240 W:366 H:23) readonly
10591:         loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
10592:         WITH loc_oPg.txt_4c_Dsittricm
10593:             .Top           = 261
10594:             .Left          = 240
10595:             .Width         = 366
10596:             .Height        = 23
10597:             .Value         = ""
10598:             .FontName      = "Tahoma"
10599:             .FontSize      = 8

*-- Linhas 10607 a 10616:
10607:         *-- Get_CodServs: Cod. Servicos ICMS (T:286 L:206 W:38 H:23)
10608:         loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
10609:         WITH loc_oPg.txt_4c_CodServs
10610:             .Top           = 286
10611:             .Left          = 206
10612:             .Width         = 38
10613:             .Height        = 23
10614:             .Value         = ""
10615:             .FontName      = "Tahoma"
10616:             .FontSize      = 8

*-- Linhas 10624 a 10633:
10624:         *-- getIcms: Aliquota ICMS (T:286 L:342 W:45 H:23)
10625:         loc_oPg.AddObject("txt_4c_Icms", "TextBox")
10626:         WITH loc_oPg.txt_4c_Icms
10627:             .Top           = 286
10628:             .Left          = 342
10629:             .Width         = 45
10630:             .Height        = 23
10631:             .Value         = 0
10632:             .FontName      = "Tahoma"
10633:             .FontSize      = 8

*-- Linhas 10640 a 10649:
10640:         *-- Get_TpTrib: Tipo Tributacao (T:286 L:513 W:38 H:23)
10641:         loc_oPg.AddObject("txt_4c_TpTrib", "TextBox")
10642:         WITH loc_oPg.txt_4c_TpTrib
10643:             .Top           = 286
10644:             .Left          = 513
10645:             .Width         = 38
10646:             .Height        = 23
10647:             .Value         = ""
10648:             .FontName      = "Tahoma"
10649:             .FontSize      = 8

*-- Linhas 10657 a 10666:
10657:         *-- getiat: IAT - Arredondamento/Truncamento (T:286 L:589 W:17 H:23) MaxLength=1
10658:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
10659:         WITH loc_oPg.txt_4c_Iat
10660:             .Top           = 286
10661:             .Left          = 589
10662:             .Width         = 17
10663:             .Height        = 23
10664:             .Value         = ""
10665:             .FontName      = "Tahoma"
10666:             .FontSize      = 8

*-- Linhas 10678 a 10687:
10678:         *----------------------------------------------------------------------
10679:         loc_oPg.AddObject("cmb_4c_Ipi", "ComboBox")
10680:         WITH loc_oPg.cmb_4c_Ipi
10681:             .Top           = 311
10682:             .Left          = 206
10683:             .Width         = 108
10684:             .Height        = 25
10685:             .FontName      = "Tahoma"
10686:             .FontSize      = 8
10687:             .SpecialEffect = 1

*-- Linhas 10698 a 10707:
10698:         *-- Get_AliqIPI: Aliquota IPI (T:311 L:425 W:45 H:25)
10699:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
10700:         WITH loc_oPg.txt_4c_AliqIPI
10701:             .Top           = 311
10702:             .Left          = 425
10703:             .Width         = 45
10704:             .Height        = 25
10705:             .Value         = 0
10706:             .FontName      = "Tahoma"
10707:             .FontSize      = 8

*-- Linhas 10714 a 10723:
10714:         *-- getextipi: Excecao TIPI (T:311 L:601 W:35 H:25)
10715:         loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
10716:         WITH loc_oPg.txt_4c_Extipi
10717:             .Top           = 311
10718:             .Left          = 601
10719:             .Width         = 35
10720:             .Height        = 25
10721:             .Value         = ""
10722:             .FontName      = "Tahoma"
10723:             .FontSize      = 8

*-- Linhas 10730 a 10761:
10730:         *----------------------------------------------------------------------
10731:         *-- btnDescFis: Gerar Descricao Fiscal (T:359 L:162 W:32 H:32)
10732:         *----------------------------------------------------------------------
10733:         loc_oPg.AddObject("cmd_4c_DescFis", "CommandButton")
10734:         WITH loc_oPg.cmd_4c_DescFis
10735:             .Top             = 359
10736:             .Left            = 162
10737:             .Width           = 32
10738:             .Height          = 32
10739:             .Caption         = ""
10740:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.bmp"
10741:             .FontName        = "Tahoma"
10742:             .FontSize        = 8
10743:             .Themes          = .F.
10744:             .ToolTipText     = "Gerar Descri" + CHR(231) + CHR(227) + "o Fiscal"
10745:             .Enabled         = .F.
10746:             .Visible         = .T.
10747:         ENDWITH
10748:         BINDEVENT(loc_oPg.cmd_4c_DescFis, "Click", THIS, "CmdDescFisClick")
10749: 
10750:         *----------------------------------------------------------------------
10751:         *-- EditBox mgetdescfi: Descricao Fiscal (T:338 L:206 W:509 H:89)
10752:         *----------------------------------------------------------------------
10753:         loc_oPg.AddObject("obj_4c_Descfis", "EditBox")
10754:         WITH loc_oPg.obj_4c_Descfis
10755:             .Top           = 338
10756:             .Left          = 206
10757:             .Width         = 509
10758:             .Height        = 89
10759:             .Value         = ""
10760:             .FontName      = "Tahoma"
10761:             .FontSize      = 8

*-- Linhas 10771 a 10780:
10771:         *-- getDescEcfs: Descricao ECF (T:429 L:206 W:213 H:23)
10772:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
10773:         WITH loc_oPg.txt_4c_DescEcfs
10774:             .Top           = 429
10775:             .Left          = 206
10776:             .Width         = 213
10777:             .Height        = 23
10778:             .Value         = ""
10779:             .FontName      = "Tahoma"
10780:             .FontSize      = 8

*-- Linhas 10788 a 10797:
10788:         *-- Get_metal: Metal (T:429 L:537 W:24 H:23)
10789:         loc_oPg.AddObject("txt_4c_Metal", "TextBox")
10790:         WITH loc_oPg.txt_4c_Metal
10791:             .Top           = 429
10792:             .Left          = 537
10793:             .Width         = 24
10794:             .Height        = 23
10795:             .Value         = ""
10796:             .FontName      = "Tahoma"
10797:             .FontSize      = 8

*-- Linhas 10805 a 10814:
10805:         *-- Get_DesMetal: Descricao Metal (T:429 L:564 W:150 H:23) readonly
10806:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
10807:         WITH loc_oPg.txt_4c_DesMetal
10808:             .Top           = 429
10809:             .Left          = 564
10810:             .Width         = 150
10811:             .Height        = 23
10812:             .Value         = ""
10813:             .FontName      = "Tahoma"
10814:             .FontSize      = 8

*-- Linhas 10822 a 10831:
10822:         *-- getValor: Valor Estimado (T:454 L:206 W:108 H:23) numeric
10823:         loc_oPg.AddObject("txt_4c_ValorEstim", "TextBox")
10824:         WITH loc_oPg.txt_4c_ValorEstim
10825:             .Top           = 454
10826:             .Left          = 206
10827:             .Width         = 108
10828:             .Height        = 23
10829:             .Value         = 0
10830:             .FontName      = "Tahoma"
10831:             .FontSize      = 8

*-- Linhas 10838 a 10847:
10838:         *-- GetMvalor: Moeda do Valor (T:454 L:317 W:31 H:23) - lookup SigCdMoe
10839:         loc_oPg.AddObject("txt_4c_Mvalor", "TextBox")
10840:         WITH loc_oPg.txt_4c_Mvalor
10841:             .Top           = 454
10842:             .Left          = 317
10843:             .Width         = 31
10844:             .Height        = 23
10845:             .Value         = ""
10846:             .FontName      = "Tahoma"
10847:             .FontSize      = 8

*-- Linhas 10855 a 10864:
10855:         *-- Get_teor: Teor (T:454 L:537 W:24 H:23)
10856:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
10857:         WITH loc_oPg.txt_4c_Teor
10858:             .Top           = 454
10859:             .Left          = 537
10860:             .Width         = 24
10861:             .Height        = 23
10862:             .Value         = ""
10863:             .FontName      = "Tahoma"
10864:             .FontSize      = 8

*-- Linhas 10872 a 10881:
10872:         *-- Get_DesTeor: Descricao Teor (T:454 L:564 W:150 H:23) readonly
10873:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
10874:         WITH loc_oPg.txt_4c_DesTeor
10875:             .Top           = 454
10876:             .Left          = 564
10877:             .Width         = 150
10878:             .Height        = 23
10879:             .Value         = ""
10880:             .FontName      = "Tahoma"
10881:             .FontSize      = 8

*-- Linhas 10889 a 10898:
10889:         *-- getIPPTCST: IPPT/CST (T:479 L:206 W:108 H:23) readonly (When=.f.)
10890:         loc_oPg.AddObject("txt_4c_IpptCST", "TextBox")
10891:         WITH loc_oPg.txt_4c_IpptCST
10892:             .Top           = 479
10893:             .Left          = 206
10894:             .Width         = 108
10895:             .Height        = 23
10896:             .Value         = ""
10897:             .FontName      = "Tahoma"
10898:             .FontSize      = 8

*-- Linhas 10909 a 10918:
10909:         *----------------------------------------------------------------------
10910:         loc_oPg.AddObject("grd_4c_Cmv", "Grid")
10911:         WITH loc_oPg.grd_4c_Cmv
10912:             .Top         = 338
10913:             .Left        = 754
10914:             .Width       = 223
10915:             .Height      = 141
10916:             .ColumnCount = 3
10917:             .FontName    = "Tahoma"
10918:             .FontSize    = 8

*-- Linhas 10928 a 10956:
10928:         WITH loc_oPg.grd_4c_Cmv
10929:             WITH .Column1
10930:                 .ControlSource    = "cursor_4c_Cmv.Datas"
10931:                 .Header1.Caption  = "Per" + CHR(237) + "odo"
10932:                 .Header1.FontName = "Tahoma"
10933:                 .Header1.FontSize = 8
10934:                 .Width            = 59
10935:                 .Movable          = .F.
10936:                 .Resizable        = .F.
10937:                 .ReadOnly         = .T.
10938:             ENDWITH
10939:             WITH .Column2
10940:                 .ControlSource    = "cursor_4c_Cmv.ValCuss"
10941:                 .Header1.Caption  = "Valor Custo GR"
10942:                 .Header1.FontName = "Tahoma"
10943:                 .Header1.FontSize = 8
10944:                 .Width            = 100
10945:                 .Movable          = .F.
10946:                 .Resizable        = .F.
10947:                 .ReadOnly         = .T.
10948:             ENDWITH
10949:             WITH .Column3
10950:                 .ControlSource    = "cursor_4c_Cmv.Moedas"
10951:                 .Header1.Caption  = "Moe"
10952:                 .Header1.FontName = "Tahoma"
10953:                 .Header1.FontSize = 8
10954:                 .Width            = 31
10955:                 .Movable          = .F.
10956:                 .Resizable        = .F.

*-- Linhas 10993 a 11001:
10993:                     loc_oPg.txt_4c_CodServs.Value = ALLTRIM(.this_cCodservs)
10994:                 ENDIF
10995:                 IF VARTYPE(loc_oPg.txt_4c_Icms) = "O"
10996:                     loc_oPg.txt_4c_Icms.Value = .this_nIcms
10997:                 ENDIF
10998:                 IF VARTYPE(loc_oPg.txt_4c_TpTrib) = "O"
10999:                     loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(.this_cTptribs)
11000:                 ENDIF
11001:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"

*-- Linhas 11016 a 11024:
11016:                     loc_oPg.cmb_4c_Ipi.Value = loc_cIpiVal
11017:                 ENDIF
11018:                 IF VARTYPE(loc_oPg.txt_4c_AliqIPI) = "O"
11019:                     loc_oPg.txt_4c_AliqIPI.Value = .this_nAliqipis
11020:                 ENDIF
11021:                 IF VARTYPE(loc_oPg.txt_4c_Extipi) = "O"
11022:                     loc_oPg.txt_4c_Extipi.Value = ALLTRIM(.this_cExtipi)
11023:                 ENDIF
11024:                 IF VARTYPE(loc_oPg.obj_4c_Descfis) = "O"

*-- Linhas 11031 a 11039:
11031:                     loc_oPg.txt_4c_Metal.Value = ALLTRIM(.this_cMetals)
11032:                 ENDIF
11033:                 IF VARTYPE(loc_oPg.txt_4c_ValorEstim) = "O"
11034:                     loc_oPg.txt_4c_ValorEstim.Value = .this_nValors
11035:                 ENDIF
11036:                 IF VARTYPE(loc_oPg.txt_4c_Mvalor) = "O"
11037:                     loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(.this_cMoedas)
11038:                 ENDIF
11039:                 IF VARTYPE(loc_oPg.txt_4c_Teor) = "O"

*-- Linhas 11845 a 11869:
11845:         *----------------------------------------------------------------------
11846:         loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
11847:         WITH loc_oPg.shp_4c_ArqFundo
11848:             .Top         = 415
11849:             .Left        = 584
11850:             .Width       = 407
11851:             .Height      = 202
11852:             .BackColor   = RGB(230, 230, 230)
11853:             .BorderColor = RGB(180, 180, 180)
11854:             .Visible     = .T.
11855:         ENDWITH
11856: 
11857:         *----------------------------------------------------------------------
11858:         *-- Say31: "Observacao da Tarefa" (T:144 L:583 W:126 H:15)
11859:         *----------------------------------------------------------------------
11860:         loc_oPg.AddObject("lbl_4c_ObsTarLabel", "Label")
11861:         WITH loc_oPg.lbl_4c_ObsTarLabel
11862:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
11863:             .Top       = 144
11864:             .Left      = 583
11865:             .Width     = 126
11866:             .Height    = 15
11867:             .FontName  = "Tahoma"
11868:             .FontSize  = 8
11869:             .FontBold  = .T.

*-- Linhas 11879 a 11888:
11879:         *----------------------------------------------------------------------
11880:         loc_oPg.AddObject("grd_4c_Designer", "Grid")
11881:         WITH loc_oPg.grd_4c_Designer
11882:             .Top         = 160
11883:             .Left        = 10
11884:             .Width       = 495
11885:             .Height      = 238
11886:             .ColumnCount = 4
11887:             .FontName    = "Tahoma"
11888:             .FontSize    = 8

*-- Linhas 11896 a 11939:
11896:         WITH loc_oPg.grd_4c_Designer
11897:             WITH .Column1
11898:                 .ControlSource     = "cursor_4c_SigPrTar.DtInis"
11899:                 .Header1.Caption   = "Data de In" + CHR(237) + "cio"
11900:                 .Header1.FontName  = "Tahoma"
11901:                 .Header1.FontSize  = 8
11902:                 .Header1.Alignment = 2
11903:                 .Width             = 140
11904:                 .Movable           = .F.
11905:                 .Resizable         = .F.
11906:                 .ReadOnly          = .T.
11907:                 .Alignment         = 2
11908:             ENDWITH
11909:             WITH .Column2
11910:                 .ControlSource     = "cursor_4c_SigPrTar.DtFims"
11911:                 .Header1.Caption   = "Data de Conclus" + CHR(227) + "o"
11912:                 .Header1.FontName  = "Tahoma"
11913:                 .Header1.FontSize  = 8
11914:                 .Header1.Alignment = 2
11915:                 .Width             = 140
11916:                 .Movable           = .F.
11917:                 .Resizable         = .F.
11918:                 .ReadOnly          = .T.
11919:                 .Alignment         = 2
11920:             ENDWITH
11921:             WITH .Column3
11922:                 .ControlSource     = "cursor_4c_SigPrTar.Usuars"
11923:                 .Header1.Caption   = "Usu" + CHR(225) + "rio"
11924:                 .Header1.FontName  = "Tahoma"
11925:                 .Header1.FontSize  = 8
11926:                 .Header1.Alignment = 2
11927:                 .Width             = 90
11928:                 .Movable           = .F.
11929:                 .Resizable         = .F.
11930:                 .ReadOnly          = .T.
11931:             ENDWITH
11932:             WITH .Column4
11933:                 .ControlSource     = "cursor_4c_SigPrTar.Tarefas"
11934:                 .Header1.Caption   = "Tarefa"
11935:                 .Header1.FontName  = "Tahoma"
11936:                 .Header1.FontSize  = 8
11937:                 .Header1.Alignment = 2
11938:                 .Width             = 90
11939:                 .Movable           = .F.

*-- Linhas 11949 a 12016:
11949:         *----------------------------------------------------------------------
11950:         loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
11951:         WITH loc_oPg.obj_4c_ObsTarefas
11952:             .Top              = 160
11953:             .Left             = 584
11954:             .Width            = 407
11955:             .Height           = 238
11956:             .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
11957:             .FontName         = "Tahoma"
11958:             .FontSize         = 8
11959:             .SpecialEffect    = 1
11960:             .ForeColor        = RGB(36, 84, 155)
11961:             .Enabled          = .T.
11962:             .Visible          = .T.
11963:         ENDWITH
11964: 
11965:         *----------------------------------------------------------------------
11966:         *-- btnIniTarefa: Iniciar Tarefa (T:161 L:509 W:42 H:42)
11967:         *----------------------------------------------------------------------
11968:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
11969:         WITH loc_oPg.cmd_4c_IniTarefa
11970:             .Top             = 161
11971:             .Left            = 509
11972:             .Width           = 42
11973:             .Height          = 42
11974:             .Caption         = ""
11975:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.bmp"
11976:             .FontName        = "Tahoma"
11977:             .FontSize        = 8
11978:             .Themes          = .F.
11979:             .ToolTipText     = "Iniciar Nova Tarefa"
11980:             .Enabled         = .F.
11981:             .Visible         = .T.
11982:         ENDWITH
11983:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "Click", THIS, "BtnIniTarefaClick")
11984: 
11985:         *----------------------------------------------------------------------
11986:         *-- btnFimTarefa: Encerrar Tarefa (T:203 L:509 W:42 H:42)
11987:         *----------------------------------------------------------------------
11988:         loc_oPg.AddObject("cmd_4c_FimTarefa", "CommandButton")
11989:         WITH loc_oPg.cmd_4c_FimTarefa
11990:             .Top             = 203
11991:             .Left            = 509
11992:             .Width           = 42
11993:             .Height          = 42
11994:             .Caption         = ""
11995:             .Picture         = gc_4c_CaminhoIcones + "geral_datas_26.bmp"
11996:             .FontName        = "Tahoma"
11997:             .FontSize        = 8
11998:             .Themes          = .F.
11999:             .ToolTipText     = "Encerrar Tarefa"
12000:             .Enabled         = .F.
12001:             .Visible         = .T.
12002:         ENDWITH
12003:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "Click", THIS, "BtnFimTarefaClick")
12004: 
12005:         *----------------------------------------------------------------------
12006:         *-- grdArquivos: Grade de Arquivos (T:415 L:10 W:495 H:202) 1 coluna
12007:         *----------------------------------------------------------------------
12008:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
12009:         WITH loc_oPg.grd_4c_Arquivos
12010:             .Top         = 415
12011:             .Left        = 10
12012:             .Width       = 495
12013:             .Height      = 202
12014:             .ColumnCount = 1
12015:             .FontName    = "Tahoma"
12016:             .FontSize    = 8

*-- Linhas 12025 a 12033:
12025:         WITH loc_oPg.grd_4c_Arquivos
12026:             WITH .Column1
12027:                 .ControlSource     = "cursor_4c_SigPrArq.Arquivos"
12028:                 .Header1.Caption   = "Arquivos Para Designer"
12029:                 .Header1.FontName  = "Tahoma"
12030:                 .Header1.FontSize  = 8
12031:                 .Header1.Alignment = 2
12032:                 .Width             = 464
12033:                 .Movable           = .F.

*-- Linhas 12040 a 12111:
12040:         *----------------------------------------------------------------------
12041:         *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
12042:         *----------------------------------------------------------------------
12043:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
12044:         WITH loc_oPg.cmd_4c_InsArqs
12045:             .Top             = 416
12046:             .Left            = 509
12047:             .Width           = 42
12048:             .Height          = 42
12049:             .Caption         = ""
12050:             .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_26.bmp"
12051:             .FontName        = "Tahoma"
12052:             .FontSize        = 8
12053:             .Themes          = .F.
12054:             .ToolTipText     = "Inserir Arquivo"
12055:             .Enabled         = .F.
12056:             .Visible         = .T.
12057:         ENDWITH
12058:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")
12059: 
12060:         *----------------------------------------------------------------------
12061:         *-- btnOpnArqs: Abrir Arquivo (T:500 L:509 W:42 H:42)
12062:         *----------------------------------------------------------------------
12063:         loc_oPg.AddObject("cmd_4c_OpnArqs", "CommandButton")
12064:         WITH loc_oPg.cmd_4c_OpnArqs
12065:             .Top             = 500
12066:             .Left            = 509
12067:             .Width           = 42
12068:             .Height          = 42
12069:             .Caption         = ""
12070:             .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.bmp"
12071:             .FontName        = "Tahoma"
12072:             .FontSize        = 8
12073:             .Themes          = .F.
12074:             .ToolTipText     = "Abrir Arquivo"
12075:             .Enabled         = .T.
12076:             .Visible         = .T.
12077:         ENDWITH
12078:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "Click", THIS, "BtnOpnArqsClick")
12079: 
12080:         *----------------------------------------------------------------------
12081:         *-- btnExcArqs: Excluir Arquivo (T:458 L:509 W:42 H:42)
12082:         *----------------------------------------------------------------------
12083:         loc_oPg.AddObject("cmd_4c_ExcArqs", "CommandButton")
12084:         WITH loc_oPg.cmd_4c_ExcArqs
12085:             .Top             = 458
12086:             .Left            = 509
12087:             .Width           = 42
12088:             .Height          = 42
12089:             .Caption         = ""
12090:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.bmp"
12091:             .FontName        = "Tahoma"
12092:             .FontSize        = 8
12093:             .Themes          = .F.
12094:             .ToolTipText     = "Excluir Arquivo"
12095:             .Enabled         = .F.
12096:             .Visible         = .T.
12097:         ENDWITH
12098:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "Click", THIS, "BtnExcArqsClick")
12099: 
12100:         *----------------------------------------------------------------------
12101:         *-- imgArqJpg: Imagem do arquivo (T:417 L:586 W:403 H:198)
12102:         *----------------------------------------------------------------------
12103:         loc_oPg.AddObject("img_4c_ArqJpg", "Image")
12104:         WITH loc_oPg.img_4c_ArqJpg
12105:             .Top         = 417
12106:             .Left        = 586
12107:             .Width       = 403
12108:             .Height      = 198
12109:             .Stretch     = 1
12110:             .Visible     = .F.
12111:             .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"

*-- Linhas 12125 a 12148:
12125:         BINDEVENT(loc_oPg.obj_4c_ObsTarefas, "When", THIS, "ObsTarefasWhen")
12126: 
12127:         *----------------------------------------------------------------------
12128:         *-- Bindings When para botoes de tarefa
12129:         *----------------------------------------------------------------------
12130:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "When", THIS, "BtnIniTarefaWhen")
12131:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "When", THIS, "BtnFimTarefaWhen")
12132: 
12133:         *----------------------------------------------------------------------
12134:         *-- Binding When para Column1 do grdArquivos
12135:         *----------------------------------------------------------------------
12136:         BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")
12137: 
12138:         *----------------------------------------------------------------------
12139:         *-- Bindings When para botoes de arquivo
12140:         *----------------------------------------------------------------------
12141:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "When", THIS, "BtnInsArqsWhen")
12142:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "When", THIS, "BtnOpnArqsWhen")
12143:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "When", THIS, "BtnExcArqsWhen")
12144:     ENDPROC
12145: 
12146:     *--------------------------------------------------------------------------
12147:     * GrdDesignerAfterRowColChange - Atualiza EditBox Obs ao mudar linha da grade
12148:     * Legado: grdDesigner.Procedure (AfterRowColChange) ? refresh getObsTarefas

