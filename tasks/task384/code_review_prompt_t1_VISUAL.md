# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (7)
- [FONTNAME-ERRADO] Linha 199: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 224: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 249: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 274: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 299: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 421: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 446: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcrp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1287 linhas total):

*-- Linhas 34 a 46:
34: 
35:         DO CASE
36:         CASE THIS.this_nTipos = 1
37:             THIS.Caption = "Caracter" + CHR(237) + "sticas de Contas"
38:         CASE THIS.this_nTipos = 2
39:             THIS.Caption = "Caracter" + CHR(237) + "sticas de Movimenta" + CHR(231) + CHR(245) + "es"
40:         OTHERWISE
41:             THIS.Caption = "Caracter" + CHR(237) + "sticas de Produtos"
42:         ENDCASE
43: 
44:         RETURN DODEFAULT()
45:     ENDPROC
46: 

*-- Linhas 63 a 72:
63:                 THIS.this_oBusinessObject.this_nTipos = THIS.this_nTipos
64: 
65:                 THIS.ConfigurarPageFrame()
66:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
67:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
68:                 THIS.pgf_4c_Paginas.Visible = .T.
69:                 THIS.pgf_4c_Paginas.ActivePage = 1
70:                 THIS.this_cModoAtual = "LISTA"
71: 
72:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 95 a 114:
95: 
96:         WITH THIS.pgf_4c_Paginas
97:             .PageCount = 2
98:             .Top       = -29
99:             .Left      = 0
100:             .Width     = THIS.Width
101:             .Height    = THIS.Height + 29
102:             .Tabs      = .F.
103:             .Visible   = .T.
104: 
105:             .Page1.Caption   = "Lista"
106:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Page1.BackColor = RGB(255, 255, 255)
108: 
109:             .Page2.Caption   = "Dados"
110:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111:             .Page2.BackColor = RGB(255, 255, 255)
112:         ENDWITH
113: 
114:         THIS.ConfigurarPaginaLista()

*-- Linhas 131 a 169:
131:         *-- Original: cntSombra.Width=1100. Com comp PageFrame +29: Top=31
132:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
133:         WITH loc_oPagina.cnt_4c_Cabecalho
134:             .Top       = 31
135:             .Left      = 0
136:             .Width     = THIS.Width
137:             .Height    = 80
138:             .BackColor = RGB(100, 100, 100)
139:             .BackStyle = 1
140:             .BorderWidth = 0
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
146:             .Caption   = THIS.Caption
147:             .Top       = 15
148:             .Left      = 10
149:             .Width     = 769
150:             .Height    = 40
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .ForeColor = RGB(0, 0, 0)
155:             .BackStyle = 0
156:             .AutoSize  = .F.
157:             .Visible   = .T.
158:         ENDWITH
159: 
160:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
161:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
162:             .Caption   = THIS.Caption
163:             .Top       = 18
164:             .Left      = 10
165:             .Width     = 769
166:             .Height    = 46
167:             .FontName  = "Tahoma"
168:             .FontSize  = 16
169:             .FontBold  = .T.

*-- Linhas 177 a 339:
177:         *-- Canonico: Left=542, Top=28 (-1+29 compensacao), Width=390, Height=85
178:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
179:         WITH loc_oPagina.cnt_4c_Botoes
180:             .Top       = 28
181:             .Left      = 542
182:             .Width     = 390
183:             .Height    = 85
184:             .BackStyle = 0
185:             .BorderWidth = 0
186:             .Visible   = .T.
187:         ENDWITH
188: 
189:         *-- Botao Incluir (usa cadastro_inserir_26.jpg - padrao framework para Incluir)
190:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
191:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
192:             .Caption         = "Incluir"
193:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
194:             .PicturePosition = 13
195:             .Top             = 5
196:             .Left            = 5
197:             .Width           = 75
198:             .Height          = 75
199:             .FontName        = "Comic Sans MS"
200:             .FontBold        = .T.
201:             .FontItalic      = .T.
202:             .FontSize        = 8
203:             .ForeColor       = RGB(90, 90, 90)
204:             .BackColor       = RGB(255, 255, 255)
205:             .Themes          = .F.
206:             .SpecialEffect   = 0
207:             .MousePointer    = 15
208:             .WordWrap        = .T.
209:             .AutoSize        = .F.
210:             .Visible         = .T.
211:         ENDWITH
212:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
213: 
214:         *-- Botao Visualizar
215:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
216:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
217:             .Caption         = "Visualizar"
218:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
219:             .PicturePosition = 13
220:             .Top             = 5
221:             .Left            = 80
222:             .Width           = 75
223:             .Height          = 75
224:             .FontName        = "Comic Sans MS"
225:             .FontBold        = .T.
226:             .FontItalic      = .T.
227:             .FontSize        = 8
228:             .ForeColor       = RGB(90, 90, 90)
229:             .BackColor       = RGB(255, 255, 255)
230:             .Themes          = .F.
231:             .SpecialEffect   = 0
232:             .MousePointer    = 15
233:             .WordWrap        = .T.
234:             .AutoSize        = .F.
235:             .Visible         = .T.
236:         ENDWITH
237:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
238: 
239:         *-- Botao Alterar
240:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
241:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
242:             .Caption         = "Alterar"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
244:             .PicturePosition = 13
245:             .Top             = 5
246:             .Left            = 155
247:             .Width           = 75
248:             .Height          = 75
249:             .FontName        = "Comic Sans MS"
250:             .FontBold        = .T.
251:             .FontItalic      = .T.
252:             .FontSize        = 8
253:             .ForeColor       = RGB(90, 90, 90)
254:             .BackColor       = RGB(255, 255, 255)
255:             .Themes          = .F.
256:             .SpecialEffect   = 0
257:             .MousePointer    = 15
258:             .WordWrap        = .T.
259:             .AutoSize        = .F.
260:             .Visible         = .T.
261:         ENDWITH
262:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
263: 
264:         *-- Botao Excluir
265:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
266:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
267:             .Caption         = "Excluir"
268:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
269:             .PicturePosition = 13
270:             .Top             = 5
271:             .Left            = 230
272:             .Width           = 75
273:             .Height          = 75
274:             .FontName        = "Comic Sans MS"
275:             .FontBold        = .T.
276:             .FontItalic      = .T.
277:             .FontSize        = 8
278:             .ForeColor       = RGB(90, 90, 90)
279:             .BackColor       = RGB(255, 255, 255)
280:             .Themes          = .F.
281:             .SpecialEffect   = 0
282:             .MousePointer    = 15
283:             .WordWrap        = .T.
284:             .AutoSize        = .F.
285:             .Visible         = .T.
286:         ENDWITH
287:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
288: 
289:         *-- Botao Buscar
290:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
291:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
292:             .Caption         = "Buscar"
293:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
294:             .PicturePosition = 13
295:             .Top             = 5
296:             .Left            = 305
297:             .Width           = 75
298:             .Height          = 75
299:             .FontName        = "Comic Sans MS"
300:             .FontBold        = .T.
301:             .FontItalic      = .T.
302:             .FontSize        = 8
303:             .ForeColor       = RGB(90, 90, 90)
304:             .BackColor       = RGB(255, 255, 255)
305:             .Themes          = .F.
306:             .SpecialEffect   = 0
307:             .MousePointer    = 15
308:             .WordWrap        = .T.
309:             .AutoSize        = .F.
310:             .Visible         = .T.
311:         ENDWITH
312:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
313: 
314:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado per CLAUDE.md regra #10)
315:         *-- Legado: Grupo_Saida.Left=919, Top=-1. Canonico: Left=917, Top=29, Width=90
316:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
317:         WITH loc_oPagina.cnt_4c_Saida
318:             .Top       = 29
319:             .Left      = 917
320:             .Width     = 90
321:             .Height    = 85
322:             .BackStyle = 0
323:             .BorderWidth = 0
324:             .Visible   = .T.
325:         ENDWITH
326: 
327:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
328:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
329:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
330:             .Caption         = "Encerrar"
331:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
332:             .PicturePosition = 13
333:             .Top             = 5
334:             .Left            = 5
335:             .Width           = 75
336:             .Height          = 75
337:             .FontName        = "Tahoma"
338:             .FontBold        = .T.
339:             .FontItalic      = .T.

*-- Linhas 347 a 364:
347:             .AutoSize        = .F.
348:             .Visible         = .T.
349:         ENDWITH
350:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
351: 
352:         *-- Grid de lista (Grade no legado: Top=102, Left=29, Width=940, Height=479)
353:         *-- Top=117 seguindo padrao framework (compensacao +29 do PageFrame)
354:         *-- Width=890: Left=26, termina em 916, nao sobrepoe cnt_4c_Saida (Left=917)
355:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
356:         loc_oPagina.grd_4c_Dados.ColumnCount = 5
357:         WITH loc_oPagina.grd_4c_Dados
358:             .Top                = 117
359:             .Left               = 26
360:             .Width              = 890
361:             .Height             = 479
362:             .FontName           = "Verdana"
363:             .FontSize           = 8
364:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 399 a 471:
399:         *-- Com comp +29: Top=26, Left=843
400:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
401:         WITH loc_oPagina.cnt_4c_BotoesAcao
402:             .Top       = 26
403:             .Left      = 843
404:             .Width     = 160
405:             .Height    = 85
406:             .BackStyle = 0
407:             .BorderWidth = 0
408:             .Visible   = .T.
409:         ENDWITH
410: 
411:         *-- Botao Confirmar (Salva.Salva no legado: Left=5, Top=5)
412:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
413:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
414:             .Caption         = "Confirmar"
415:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
416:             .PicturePosition = 13
417:             .Top             = 5
418:             .Left            = 5
419:             .Width           = 75
420:             .Height          = 75
421:             .FontName        = "Comic Sans MS"
422:             .FontBold        = .T.
423:             .FontItalic      = .T.
424:             .FontSize        = 8
425:             .ForeColor       = RGB(90, 90, 90)
426:             .BackColor       = RGB(255, 255, 255)
427:             .Themes          = .F.
428:             .SpecialEffect   = 0
429:             .MousePointer    = 15
430:             .WordWrap        = .T.
431:             .AutoSize        = .F.
432:             .Visible         = .T.
433:         ENDWITH
434:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
435: 
436:         *-- Botao Cancelar (Salva.Cancela no legado: Left=80, Top=5)
437:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
438:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
439:             .Caption         = "Encerrar"
440:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
441:             .PicturePosition = 13
442:             .Top             = 5
443:             .Left            = 80
444:             .Width           = 75
445:             .Height          = 75
446:             .FontName        = "Comic Sans MS"
447:             .FontBold        = .T.
448:             .FontItalic      = .T.
449:             .FontSize        = 8
450:             .ForeColor       = RGB(90, 90, 90)
451:             .BackColor       = RGB(255, 255, 255)
452:             .Themes          = .F.
453:             .SpecialEffect   = 0
454:             .MousePointer    = 15
455:             .WordWrap        = .T.
456:             .AutoSize        = .F.
457:             .Visible         = .T.
458:         ENDWITH
459:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
460: 
461:         *-- Label Codigo (Say1: top=192, left=339 -> +29 comp: top=221)
462:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
463:         WITH loc_oPagina.lbl_4c_Codigo
464:             .Caption   = "C" + CHR(243) + "digo :"
465:             .Top       = 221
466:             .Left      = 339
467:             .Width     = 42
468:             .Height    = 17
469:             .FontName  = "Tahoma"
470:             .FontSize  = 8
471:             .FontBold  = .F.

*-- Linhas 481 a 505:
481:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
482:         WITH loc_oPagina.txt_4c_Codigos
483:             .Value     = ""
484:             .Top       = 217
485:             .Left      = 383
486:             .Width     = 150
487:             .Height    = 23
488:             .FontName  = "Tahoma"
489:             .FontSize  = 8
490:             .MaxLength = 20
491:             .TabIndex  = 1
492:             .Visible   = .T.
493:         ENDWITH
494: 
495:         *-- Label Descricao (Say2: top=218, left=326 -> +29 comp: top=247)
496:         loc_oPagina.AddObject("lbl_4c_Descrs", "Label")
497:         WITH loc_oPagina.lbl_4c_Descrs
498:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
499:             .Top       = 247
500:             .Left      = 326
501:             .Width     = 55
502:             .Height    = 17
503:             .FontName  = "Tahoma"
504:             .FontSize  = 8
505:             .FontBold  = .F.

*-- Linhas 514 a 538:
514:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
515:         WITH loc_oPagina.txt_4c_Descrs
516:             .Value     = ""
517:             .Top       = 243
518:             .Left      = 383
519:             .Width     = 290
520:             .Height    = 23
521:             .FontName  = "Tahoma"
522:             .FontSize  = 8
523:             .MaxLength = 40
524:             .TabIndex  = 2
525:             .Visible   = .T.
526:         ENDWITH
527: 
528:         *-- Label Ordem (Say4: top=192, left=573 -> +29 comp: top=221)
529:         loc_oPagina.AddObject("lbl_4c_Ordem", "Label")
530:         WITH loc_oPagina.lbl_4c_Ordem
531:             .Caption   = "Ordem :"
532:             .Top       = 221
533:             .Left      = 573
534:             .Width     = 44
535:             .Height    = 17
536:             .FontName  = "Tahoma"
537:             .FontSize  = 8
538:             .FontBold  = .F.

*-- Linhas 548 a 572:
548:         loc_oPagina.AddObject("txt_4c_Ordens", "TextBox")
549:         WITH loc_oPagina.txt_4c_Ordens
550:             .Value     = 0
551:             .Top       = 217
552:             .Left      = 619
553:             .Width     = 54
554:             .Height    = 23
555:             .FontName  = "Tahoma"
556:             .FontSize  = 8
557:             .MaxLength = 6
558:             .TabIndex  = 3
559:             .Visible   = .T.
560:         ENDWITH
561: 
562:         *-- Label Grupo (lbl_grupo: top=244, left=343, width=38, height=15 -> +29=273)
563:         loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
564:         WITH loc_oPagina.lbl_4c_Grupo
565:             .Caption   = "Grupo :"
566:             .Top       = 273
567:             .Left      = 343
568:             .Width     = 38
569:             .Height    = 15
570:             .FontName  = "Tahoma"
571:             .FontSize  = 8
572:             .FontBold  = .F.

*-- Linhas 582 a 591:
582:         loc_oPagina.AddObject("txt_4c_CdGrupo", "TextBox")
583:         WITH loc_oPagina.txt_4c_CdGrupo
584:             .Value          = ""
585:             .Top            = 269
586:             .Left           = 383
587:             .Width          = 31
588:             .Height         = 23
589:             .FontName       = "Tahoma"
590:             .FontSize       = 8
591:             .ForeColor      = RGB(0, 0, 0)

*-- Linhas 601 a 610:
601:         loc_oPagina.AddObject("txt_4c_DsGrupo", "TextBox")
602:         WITH loc_oPagina.txt_4c_DsGrupo
603:             .Value          = ""
604:             .Top            = 269
605:             .Left           = 416
606:             .Width          = 150
607:             .Height         = 23
608:             .FontName       = "Tahoma"
609:             .FontSize       = 8
610:             .ForeColor      = RGB(0, 0, 0)

*-- Linhas 616 a 630:
616:         BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "KeyPress", THIS, "DsGrupoKeyPress")
617:         BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "DblClick", THIS, "DsGrupoDblClick")
618: 
619:         *-- CheckBox Obrigatorio (chkObrig: top=244, left=573, height=15, width=72 -> top=273)
620:         loc_oPagina.AddObject("chk_4c_Obrig", "CheckBox")
621:         WITH loc_oPagina.chk_4c_Obrig
622:             .Caption   = "Obrigat" + CHR(243) + "rio"
623:             .Value     = 0
624:             .Top       = 273
625:             .Left      = 573
626:             .Width     = 72
627:             .Height    = 15
628:             .FontName  = "Tahoma"
629:             .FontSize  = 8
630:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 670 a 682:
670:                                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Dgrus"
671:                                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ordens"
672:                                 *-- Headers APOS ControlSource (reset pelo RecordSource)
673:                                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
674:                                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
675:                                 loc_oGrid.Column3.Header1.Caption = "Grupo"
676:                                 loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Grupo"
677:                                 loc_oGrid.Column5.Header1.Caption = "Ordem"
678:                                 THIS.FormatarGridLista(loc_oGrid)
679:                             ENDIF
680:                         ENDIF
681:                         loc_lResultado = .T.
682:                     ENDIF

*-- Linhas 761 a 770:
761:             THIS.AjustarBotoesPorModo()
762:             THIS.AlternarPagina(2)
763:             IF VARTYPE(THIS.pgf_4c_Paginas.Page2) = "O"
764:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
765:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
766:                 ENDIF
767:             ENDIF
768:         ENDIF
769:     ENDPROC
770: 

*-- Linhas 949 a 961:
949:         loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
950:         loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
951: 
952:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
953:             loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lModoEdicao
954:         ENDIF
955:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
956:             loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
957:         ENDIF
958:     ENDPROC
959: 
960:     *==========================================================================
961:     * FormatarGridLista - Aplica formatacao visual padrao ao grid


### BO (C:\4c\projeto\app\classes\crpBO.prg):
*------------------------------------------------------------------------------
* crpBO.prg - Business Object para Cadastro de Caracteristicas
* Tabela: SigCrRaP | PK: Codigos
* Herda de: BusinessBase
* nTipos: 0=Produtos, 1=Contas, 2=Movimentacoes
*------------------------------------------------------------------------------

DEFINE CLASS crpBO AS BusinessBase

    *-- Propriedades mapeadas da tabela SIGCRRAP (schema.sql)
    *-- codigos char(20) NOT NULL (PK)
    this_cCodigos     = ""
    *-- descrs char(40) NOT NULL
    this_cDescrs      = ""
    *-- impetqs numeric(1,0) NOT NULL
    this_nImpetqs     = 0
    *-- ordens numeric(6,0) NOT NULL
    this_nOrdens      = 0
    *-- ntipos numeric(1,0) NOT NULL (0=Produto, 1=Conta, 2=Movimentacao)
    this_nTipos       = 0
    *-- cgrus char(3) NOT NULL (FK -> SigCdGrp ou SigCdGpr conforme nTipos)
    this_cCgrus       = ""
    *-- cidchaves char(20) NOT NULL (chave interna unica)
    this_cCidchaves   = ""
    *-- chkobrig numeric(1,0) NOT NULL DEFAULT(0)
    this_nChkobrig    = 0
    *-- dgrus: descricao do grupo (calculada via JOIN, nao armazenada na tabela)
    this_cDgrus       = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCrRaP"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "crpBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * Cursores de Buscar/CarregarPorCodigo sempre incluem dgrus via JOIN
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos     = TratarNulo(codigos,   "C")
                THIS.this_cDescrs      = TratarNulo(descrs,    "C")
                THIS.this_nImpetqs     = TratarNulo(impetqs,   "N")
                THIS.this_nOrdens      = TratarNulo(ordens,    "N")
                THIS.this_nTipos       = TratarNulo(ntipos,    "N")
                THIS.this_cCgrus       = TratarNulo(cgrus,     "C")
                THIS.this_cCidchaves   = TratarNulo(cidchaves, "C")
                THIS.this_nChkobrig    = TratarNulo(chkobrig,  "N")
                THIS.this_cDgrus       = TratarNulo(dgrus,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "crpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    * Verifica: Codigos obrigatorio, Descrs obrigatorio,
    *           Codigos duplicado (INSERT), Ordens duplicada (INSERT/UPDATE)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cSQL, loc_nResultado
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            *-- Verificar se Codigos ja existe para o mesmo nTipos
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRaP" + ;
                " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                " AND nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                IF cursor_4c_ChkCod.qtd > 0
                    MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + " cadastrada!")
                    loc_lValido = .F.
                ENDIF
                USE IN cursor_4c_ChkCod
            ELSE
                MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND THIS.this_nOrdens > 0
            *-- Verificar se Ordem ja existe para diferente Codigos com mesmo nTipos
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRaP" + ;
                " WHERE Ordens = " + FormatarNumeroSQL(THIS.this_nOrdens, 0) + ;
                " AND Codigos <> " + EscaparSQL(THIS.this_cCodigos) + ;
                " AND nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOrd")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOrd")
                SELECT cursor_4c_ChkOrd
                IF cursor_4c_ChkOrd.qtd > 0
                    MsgAviso("Ordem da Caracter" + CHR(237) + "stica j" + CHR(225) + " cadastrada!")
                    loc_lValido = .F.
                ENDIF
                USE IN cursor_4c_ChkOrd
            ELSE
                MostrarErro("Erro ao verificar ordem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCrRaP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves (substitui fUniqueIds do framework Fortyus)
            THIS.this_cCidchaves = LEFT(SYS(2015) + SYS(2015), 20)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCrRaP (codigos, descrs, impetqs, ordens, ntipos, cgrus, cidchaves, chkobrig)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescrs)>>,
                    <<FormatarNumeroSQL(THIS.this_nImpetqs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdens, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<EscaparSQL(THIS.this_cCgrus)>>,
                    <<EscaparSQL(THIS.this_cCidchaves)>>,
                    <<FormatarNumeroSQL(THIS.this_nChkobrig, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "crpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCrRaP
    * Nao atualiza: codigos (PK), ntipos, cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCrRaP
                SET descrs   = <<EscaparSQL(THIS.this_cDescrs)>>,
                    impetqs  = <<FormatarNumeroSQL(THIS.this_nImpetqs, 0)>>,
                    ordens   = <<FormatarNumeroSQL(THIS.this_nOrdens, 0)>>,
                    cgrus    = <<EscaparSQL(THIS.this_cCgrus)>>,
                    chkobrig = <<FormatarNumeroSQL(THIS.this_nChkobrig, 0)>>
                WHERE Codigos = <<EscaparSQL(THIS.this_cCodigos)>>
                  AND nTipos  = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "crpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCrRaP
    * Para nTipos=0 (Produtos): verifica uso em sigprcar antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.

        TRY
            IF THIS.this_nTipos = 0
                *-- Verificar se caracteristica esta sendo usada em produtos
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM sigprcar" + ;
                    " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPrCar")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkPrCar")
                    SELECT cursor_4c_ChkPrCar
                    loc_nUso = cursor_4c_ChkPrCar.qtd
                    USE IN cursor_4c_ChkPrCar
                    IF loc_nUso > 0
                        MsgAviso("Caracter" + CHR(237) + "stica sendo utilizada em Produtos!")
                        loc_lSucesso = .F.
                    ELSE
                        loc_cSQL = "DELETE FROM SigCrRaP" + ;
                            " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                            " AND nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado >= 0
                            THIS.RegistrarAuditoria("DELETE")
                            loc_lSucesso = .T.
                        ELSE
                            MostrarErro("Erro ao excluir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ELSE
                    MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                *-- Contas (nTipos=1) e Movimentacoes (nTipos=2): excluir diretamente
                loc_cSQL = "DELETE FROM SigCrRaP" + ;
                    " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                    " AND nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "crpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com: codigos, descrs, cgrus, ordens, dgrus
    * Filtra por this_nTipos e usa JOIN condicional para descricao do grupo
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (codigos C(20), descrs C(40), cgrus C(3), ordens N(6,0), dgrus C(40))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF THIS.this_nTipos = 2
                    *-- Movimentacoes: JOIN com SigCdGpr (Codigos/Descs)
                    loc_cSQL = "SELECT a.Codigos, a.Descrs, a.Cgrus, a.Ordens," + ;
                        " ISNULL(b.Descs, '') AS Dgrus" + ;
                        " FROM SigCrRaP a" + ;
                        " LEFT JOIN SigCdGpr b ON a.Cgrus = b.Codigos" + ;
                        " WHERE a.nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
                ELSE
                    *-- Produtos (0) e Contas (1): JOIN com SigCdGrp (Cgrus/Dgrus)
                    loc_cSQL = "SELECT a.Codigos, a.Descrs, a.Cgrus, a.Ordens," + ;
                        " ISNULL(b.Dgrus, '') AS Dgrus" + ;
                        " FROM SigCrRaP a" + ;
                        " LEFT JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                        " WHERE a.nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
                ENDIF

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " AND " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Ordens, a.Codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar caracter" + CHR(237) + "sticas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar caracter" + CHR(237) + "sticas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "crpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    * Faz JOIN condicional baseado em this_nTipos para obter dgrus
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.this_nTipos = 2
                *-- Movimentacoes: JOIN com SigCdGpr
                loc_cSQL = "SELECT a.codigos, a.descrs, a.impetqs, a.ordens, a.ntipos," + ;
                    " a.cgrus, a.cidchaves, a.chkobrig," + ;
                    " ISNULL(b.Descs, '') AS dgrus" + ;
                    " FROM SigCrRaP a" + ;
                    " LEFT JOIN SigCdGpr b ON a.Cgrus = b.Codigos" + ;
                    " WHERE a.Codigos = " + EscaparSQL(par_cCodigo) + ;
                    " AND a.nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
            ELSE
                *-- Produtos e Contas: JOIN com SigCdGrp
                loc_cSQL = "SELECT a.codigos, a.descrs, a.impetqs, a.ordens, a.ntipos," + ;
                    " a.cgrus, a.cidchaves, a.chkobrig," + ;
                    " ISNULL(b.Dgrus, '') AS dgrus" + ;
                    " FROM SigCrRaP a" + ;
                    " LEFT JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                    " WHERE a.Codigos = " + EscaparSQL(par_cCodigo) + ;
                    " AND a.nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Caracter" + CHR(237) + "stica n" + CHR(227) + "o encontrada!")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "crpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

