# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 186: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 208: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 231: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 254: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 277: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 312: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 401: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 423: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formfnl.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1603 linhas total):

*-- Linhas 40 a 60:
40:         loc_lSucesso = .F.
41: 
42:         TRY
43:             THIS.Caption = "Tabela de Finaliza" + CHR(231) + CHR(245) + "es"
44: 
45:             THIS.this_oBusinessObject = CREATEOBJECT("fnlBO")
46: 
47:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
48:                 MostrarErro("Erro ao criar fnlBO" + CHR(13) + ;
49:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
50:                     "Formfnl.InicializarForm")
51:             ELSE
52:                 THIS.ConfigurarPageFrame()
53: 
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Visible    = .T.
57:                 THIS.pgf_4c_Paginas.ActivePage = 1
58:                 THIS.this_cModoAtual = "LISTA"
59: 
60:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 83 a 157:
83: 
84:         WITH THIS.pgf_4c_Paginas
85:             .PageCount = 2
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .Tabs      = .F.
91:             .Visible   = .T.
92: 
93:             .Page1.Caption   = "Lista"
94:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page1.BackColor = RGB(255, 255, 255)
96: 
97:             .Page2.Caption   = "Dados"
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()
103:         THIS.ConfigurarPaginaDados()
104:     ENDPROC
105: 
106:     *===========================================================================
107:     * ConfigurarPaginaLista - Configura Page1 (Lista): cabecalho, botoes e grid
108:     * Posicoes do original (compensacao +29 aplicada):
109:     *   cntSombra.Top=1 -> cnt_4c_Cabecalho.Top=30
110:     *   Grupo_op.Top=-1 -> cnt_4c_Botoes.Top=28  (Left=542 canonico)
111:     *   Grupo_Saida.Top=-1 -> cnt_4c_Saida.Top=28 (Left=917 canonico)
112:     *   Grade original Top=88 -> grd_4c_Lista.Top=117
113:     *===========================================================================
114:     PROTECTED PROCEDURE ConfigurarPaginaLista()
115:         LOCAL loc_oPagina
116:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
117: 
118:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
119:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120: 
121:         *-- Container Cabecalho (cntSombra no legado)
122:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
123:         WITH loc_oPagina.cnt_4c_Cabecalho
124:             .Top         = 30
125:             .Left        = 0
126:             .Width       = THIS.Width
127:             .Height      = 80
128:             .BackColor   = RGB(100, 100, 100)
129:             .BorderWidth = 0
130:             .Visible     = .T.
131: 
132:             .AddObject("lbl_4c_Sombra", "Label")
133:             WITH .lbl_4c_Sombra
134:                 .Caption   = ""
135:                 .Top       = 15
136:                 .Left      = 10
137:                 .Width     = THIS.Width
138:                 .Height    = 40
139:                 .FontName  = "Tahoma"
140:                 .FontSize  = 16
141:                 .FontBold  = .T.
142:                 .ForeColor = RGB(0, 0, 0)
143:                 .BackStyle = 0
144:                 .AutoSize  = .F.
145:                 .Visible   = .T.
146:             ENDWITH
147: 
148:             .AddObject("lbl_4c_Titulo", "Label")
149:             WITH .lbl_4c_Titulo
150:                 .Caption   = ""
151:                 .Top       = 18
152:                 .Left      = 10
153:                 .Width     = THIS.Width
154:                 .Height    = 46
155:                 .FontName  = "Tahoma"
156:                 .FontSize  = 16
157:                 .FontBold  = .T.

*-- Linhas 165 a 283:
165:         *-- Container Botoes CRUD (Grupo_op no legado) - Left=542 canonico, Top=28
166:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
167:         WITH loc_oPagina.cnt_4c_Botoes
168:             .Top         = 28
169:             .Left        = 542
170:             .Width       = 390
171:             .Height      = 85
172:             .BackStyle   = 1
173:             .BackColor   = RGB(53, 53, 53)
174:             .BorderWidth = 0
175:             .Visible     = .T.
176: 
177:             .AddObject("cmd_4c_Incluir", "CommandButton")
178:             WITH .cmd_4c_Incluir
179:                 .Caption         = "Incluir"
180:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
181:                 .PicturePosition = 13
182:                 .Top             = 5
183:                 .Left            =  542
184:                 .Width           = 75
185:                 .Height          = 75
186:                 .FontName        = "Comic Sans MS"
187:                 .FontBold        = .T.
188:                 .FontItalic      = .T.
189:                 .FontSize        = 8
190:                 .ForeColor       = RGB(90, 90, 90)
191:                 .BackColor       = RGB(255, 255, 255)
192:                 .SpecialEffect   = 0
193:                 .MousePointer    = 15
194:                 .WordWrap        = .T.
195:                 .AutoSize        = .F.
196:                 .Visible         = .T.
197:             ENDWITH
198: 
199:             .AddObject("cmd_4c_Visualizar", "CommandButton")
200:             WITH .cmd_4c_Visualizar
201:                 .Caption         = "Visualizar"
202:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:                 .PicturePosition = 13
204:                 .Top             = 5
205:                 .Left            =  542
206:                 .Width           = 75
207:                 .Height          = 75
208:                 .FontName        = "Comic Sans MS"
209:                 .FontBold        = .T.
210:                 .FontItalic      = .T.
211:                 .FontSize        = 8
212:                 .ForeColor       = RGB(90, 90, 90)
213:                 .BackColor       = RGB(255, 255, 255)
214:                 .Themes          = .F.
215:                 .SpecialEffect   = 0
216:                 .MousePointer    = 15
217:                 .WordWrap        = .T.
218:                 .AutoSize        = .F.
219:                 .Visible         = .T.
220:             ENDWITH
221: 
222:             .AddObject("cmd_4c_Alterar", "CommandButton")
223:             WITH .cmd_4c_Alterar
224:                 .Caption         = "Alterar"
225:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:                 .PicturePosition = 13
227:                 .Top             = 5
228:                 .Left            =  542
229:                 .Width           = 75
230:                 .Height          = 75
231:                 .FontName        = "Comic Sans MS"
232:                 .FontBold        = .T.
233:                 .FontItalic      = .T.
234:                 .FontSize        = 8
235:                 .ForeColor       = RGB(90, 90, 90)
236:                 .BackColor       = RGB(255, 255, 255)
237:                 .Themes          = .F.
238:                 .SpecialEffect   = 0
239:                 .MousePointer    = 15
240:                 .WordWrap        = .T.
241:                 .AutoSize        = .F.
242:                 .Visible         = .T.
243:             ENDWITH
244: 
245:             .AddObject("cmd_4c_Excluir", "CommandButton")
246:             WITH .cmd_4c_Excluir
247:                 .Caption         = "Excluir"
248:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
249:                 .PicturePosition = 13
250:                 .Top             = 5
251:                 .Left            =  542
252:                 .Width           = 75
253:                 .Height          = 75
254:                 .FontName        = "Comic Sans MS"
255:                 .FontBold        = .T.
256:                 .FontItalic      = .T.
257:                 .FontSize        = 8
258:                 .ForeColor       = RGB(90, 90, 90)
259:                 .BackColor       = RGB(255, 255, 255)
260:                 .Themes          = .F.
261:                 .SpecialEffect   = 0
262:                 .MousePointer    = 15
263:                 .WordWrap        = .T.
264:                 .AutoSize        = .F.
265:                 .Visible         = .T.
266:             ENDWITH
267: 
268:             .AddObject("cmd_4c_Buscar", "CommandButton")
269:             WITH .cmd_4c_Buscar
270:                 .Caption         = "Buscar"
271:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
272:                 .PicturePosition = 13
273:                 .Top             = 5
274:                 .Left            =  542
275:                 .Width           = 75
276:                 .Height          = 75
277:                 .FontName        = "Comic Sans MS"
278:                 .FontBold        = .T.
279:                 .FontItalic      = .T.
280:                 .FontSize        = 8
281:                 .ForeColor       = RGB(90, 90, 90)
282:                 .BackColor       = RGB(255, 255, 255)
283:                 .Themes          = .F.

*-- Linhas 292 a 318:
292:         *-- Container Saida - padrao canonico: Left=917, Width=90
293:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
294:         WITH loc_oPagina.cnt_4c_Saida
295:             .Top         = 28
296:             .Left        = 917
297:             .Width       = 90
298:             .Height      = 85
299:             .BackStyle   = 0
300:             .BorderWidth = 0
301:             .Visible     = .T.
302: 
303:             .AddObject("cmd_4c_Encerrar", "CommandButton")
304:             WITH .cmd_4c_Encerrar
305:                 .Caption         = "Encerrar"
306:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
307:                 .PicturePosition = 13
308:                 .Top             = 5
309:                 .Left            = 917
310:                 .Width           = 90
311:                 .Height          = 75
312:                 .FontName        = "Comic Sans MS"
313:                 .FontBold        = .T.
314:                 .FontItalic      = .T.
315:                 .FontSize        = 8
316:                 .ForeColor       = RGB(90, 90, 90)
317:                 .BackColor       = RGB(255, 255, 255)
318:                 .SpecialEffect   = 0

*-- Linhas 329 a 338:
329:         loc_oPagina.grd_4c_Lista.RecordSource = ""
330:         loc_oPagina.grd_4c_Lista.ColumnCount  = 4
331:         WITH loc_oPagina.grd_4c_Lista
332:             .Top                = 117
333:             .Left               = 2
334:             .Width              = 890
335:             .Height             = 492
336:             .FontName           = "Verdana"
337:             .FontSize           = 8
338:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 351 a 429:
351: 
352:         *-- BINDEVENTs dos botoes CRUD
353:         WITH loc_oPagina.cnt_4c_Botoes
354:             BINDEVENT(.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
355:             BINDEVENT(.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
356:             BINDEVENT(.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
357:             BINDEVENT(.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
358:             BINDEVENT(.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
359:             .Visible     = .T.
360:         ENDWITH
361:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
362: 
363:         THIS.TornarControlesVisiveis(loc_oPagina)
364:     ENDPROC
365: 
366:     *===========================================================================
367:     * ConfigurarPaginaDados - Configura Page2 (Dados)
368:     * Fase 5: botoes Confirmar/Cancelar + primeiros 50% dos campos
369:     * Fase 6: segundo 50% (Opc_fixo, Vincs, RelGerencial)
370:     *
371:     * Posicoes do original (compensacao +29 aplicada):
372:     *   Grupo_Salva.Top=4+29=33, Left=842
373:     *   Campos: Top_original + 29
374:     *===========================================================================
375:     PROTECTED PROCEDURE ConfigurarPaginaDados()
376:         LOCAL loc_oPagina
377:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
378: 
379:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
380:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
381: 
382:         *-- Container Salvar/Cancelar (Grupo_Salva no legado: Top=4+29=33, Left=842)
383:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
384:         WITH loc_oPagina.cnt_4c_BotoesAcao
385:             .Top         = 33
386:             .Left        = 842
387:             .Width       = 160
388:             .Height      = 85
389:             .BackStyle   = 0
390:             .Visible     = .T.
391: 
392:             .AddObject("cmd_4c_Confirmar", "CommandButton")
393:             WITH .cmd_4c_Confirmar
394:                 .Caption         = "Confirmar"
395:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
396:                 .PicturePosition = 13
397:                 .Top             = 5
398:                 .Left            = 5
399:                 .Width           = 75
400:                 .Height          = 75
401:                 .FontName        = "Comic Sans MS"
402:                 .FontBold        = .T.
403:                 .FontItalic      = .T.
404:                 .FontSize        = 8
405:                 .ForeColor       = RGB(90, 90, 90)
406:                 .BackColor       = RGB(255, 255, 255)
407:                 .SpecialEffect   = 0
408:                 .MousePointer    = 15
409:                 .WordWrap        = .T.
410:                 .AutoSize        = .F.
411:                 .Visible         = .T.
412:             ENDWITH
413: 
414:             .AddObject("cmd_4c_Cancelar", "CommandButton")
415:             WITH .cmd_4c_Cancelar
416:                 .Caption         = "Encerrar"
417:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
418:                 .PicturePosition = 13
419:                 .Top             = 5
420:                 .Left            = 80
421:                 .Width           = 75
422:                 .Height          = 75
423:                 .FontName        = "Comic Sans MS"
424:                 .FontBold        = .T.
425:                 .FontItalic      = .T.
426:                 .FontSize        = 8
427:                 .ForeColor       = RGB(90, 90, 90)
428:                 .BackColor       = RGB(255, 255, 255)
429:                 .Themes          = .F.

*-- Linhas 435 a 453:
435:             ENDWITH
436:         ENDWITH
437: 
438:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
439:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
440: 
441:         *-- === FASE 5: PRIMEIROS 50% DOS CAMPOS ===
442: 
443:         *-- Label Impressora (Say6 original: top=129, left=181 -> +29: top=158)
444:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
445:         WITH loc_oPagina.lbl_4c_Label6
446:             .Caption   = "Impressora :"
447:             .Top       = 158
448:             .Left      = 181
449:             .Width     = 68
450:             .Height    = 17
451:             .FontName  = "Tahoma"
452:             .FontSize  = 8
453:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 459 a 483:
459:         *-- ComboBox Impressora (Cmb_Imp original: top=125, left=249 -> +29: top=154)
460:         loc_oPagina.AddObject("cbo_4c_Cmb_Imp", "ComboBox")
461:         WITH loc_oPagina.cbo_4c_Cmb_Imp
462:             .Top           = 154
463:             .Left          = 249
464:             .Width         = 105
465:             .Height        = 24
466:             .FontName      = "Tahoma"
467:             .FontSize      = 8
468:             .SpecialEffect = 1
469:             .Style         = 2
470:             .Visible       = .T.
471:         ENDWITH
472: 
473:         *-- Label Codigo finalizador (Say32 original: top=154, left=202 -> +29: top=183)
474:         loc_oPagina.AddObject("lbl_4c_Label32", "Label")
475:         WITH loc_oPagina.lbl_4c_Label32
476:             .Caption   = "C" + CHR(243) + "digo :"
477:             .Top       = 183
478:             .Left      = 202
479:             .Width     = 44
480:             .Height    = 17
481:             .FontName  = "Tahoma"
482:             .FontSize  = 8
483:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 491 a 514:
491:         WITH loc_oPagina.txt_4c_Finalz
492:             .Value         = 0
493:             .InputMask     = "99"
494:             .Top           = 180
495:             .Left          = 249
496:             .Width         = 24
497:             .Height        = 21
498:             .FontName      = "Tahoma"
499:             .FontSize      = 8
500:             .SpecialEffect = 1
501:             .Visible       = .T.
502:         ENDWITH
503: 
504:         *-- Label Ordem Finalizadora (Say1 original: top=179, left=143 -> +29: top=208)
505:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
506:         WITH loc_oPagina.lbl_4c_Label1
507:             .Caption   = "Ordem Finalizadora :"
508:             .Top       = 208
509:             .Left      = 143
510:             .Width     = 103
511:             .Height    = 17
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8
514:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 522 a 545:
522:         WITH loc_oPagina.txt_4c_Ordem
523:             .Value         = 0
524:             .InputMask     = "99"
525:             .Top           = 205
526:             .Left          = 249
527:             .Width         = 24
528:             .Height        = 21
529:             .FontName      = "Tahoma"
530:             .FontSize      = 8
531:             .SpecialEffect = 1
532:             .Visible       = .T.
533:         ENDWITH
534: 
535:         *-- Label Descricao (Say2 original: top=203, left=189 -> +29: top=232)
536:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
537:         WITH loc_oPagina.lbl_4c_Label2
538:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
539:             .Top       = 232
540:             .Left      = 189
541:             .Width     = 57
542:             .Height    = 17
543:             .FontName  = "Tahoma"
544:             .FontSize  = 8
545:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 553 a 562:
553:         WITH loc_oPagina.txt_4c_Descr
554:             .Value         = ""
555:             .MaxLength     = 40
556:             .Top           = 229
557:             .Left          = 249
558:             .Width         = 290
559:             .Height        = 21
560:             .FontName      = "Tahoma"
561:             .FontSize      = 8
562:             .SpecialEffect = 1

*-- Linhas 571 a 583:
571:         *-- === FASE 6: CAMPOS RESTANTES ===
572: 
573:         *-- Label Fixo (Say3 original: top=230, left=215 -> +29: top=259)
574:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
575:         WITH loc_oPagina.lbl_4c_Label3
576:             .Caption   = "Fixo :"
577:             .Top       = 259
578:             .Left      = 215
579:             .Width     = 30
580:             .Height    = 17
581:             .FontName  = "Tahoma"
582:             .FontSize  = 8
583:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 592 a 635:
592:         WITH loc_oPagina.opt_4c_Opc_fixo
593:             .ButtonCount = 2
594:             .Value       = 2
595:             .Top         = 254
596:             .Left        = 249
597:             .BackStyle   = 0
598:             .BorderStyle = 0
599:             .AutoSize    = .T.
600:             .Visible     = .T.
601:         ENDWITH
602:         WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(1)
603:             .Caption   = "Sim"
604:             .Left      = 5
605:             .Top       = 5
606:             .AutoSize  = .T.
607:             .FontName  = "Tahoma"
608:             .FontSize  = 8
609:             .BackStyle = 0
610:             .ForeColor = RGB(90, 90, 90)
611:             .Themes    = .F.
612:         ENDWITH
613:         WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(2)
614:             .Caption   = "N" + CHR(227) + "o"
615:             .Left      = 47
616:             .Top       = 5
617:             .AutoSize  = .T.
618:             .FontName  = "Tahoma"
619:             .FontSize  = 8
620:             .BackStyle = 0
621:             .ForeColor = RGB(90, 90, 90)
622:             .Themes    = .F.
623:         ENDWITH
624: 
625:         *-- Label Vinculado (Say4 original: top=255, left=162 -> +29: top=284)
626:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
627:         WITH loc_oPagina.lbl_4c_Label4
628:             .Caption   = "Vinculado (S/N) :"
629:             .Top       = 284
630:             .Left      = 162
631:             .Width     = 85
632:             .Height    = 17
633:             .FontName  = "Tahoma"
634:             .FontSize  = 8
635:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 644 a 667:
644:         WITH loc_oPagina.txt_4c_Vincs
645:             .Value         = "N"
646:             .MaxLength     = 1
647:             .Top           = 281
648:             .Left          = 249
649:             .Width         = 17
650:             .Height        = 21
651:             .FontName      = "Tahoma"
652:             .FontSize      = 8
653:             .SpecialEffect = 1
654:             .Visible       = .T.
655:         ENDWITH
656: 
657:         *-- Label Relatorio Gerencial (Say5 original: top=280, left=145 -> +29: top=309)
658:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
659:         WITH loc_oPagina.lbl_4c_Label5
660:             .Caption   = "Relat" + CHR(243) + "rio Gerencial :"
661:             .Top       = 309
662:             .Left      = 145
663:             .Width     = 100
664:             .Height    = 17
665:             .FontName  = "Tahoma"
666:             .FontSize  = 8
667:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 675 a 684:
675:         WITH loc_oPagina.txt_4c_CodRelGer
676:             .Value         = 0
677:             .InputMask     = "99"
678:             .Top           = 306
679:             .Left          = 249
680:             .Width         = 24
681:             .Height        = 21
682:             .FontName      = "Tahoma"
683:             .FontSize      = 8
684:             .SpecialEffect = 1

*-- Linhas 690 a 699:
690:         WITH loc_oPagina.txt_4c_DesRelGer
691:             .Value         = ""
692:             .MaxLength     = 50
693:             .Top           = 306
694:             .Left          = 275
695:             .Width         = 272
696:             .Height        = 23
697:             .FontName      = "Tahoma"
698:             .FontSize      = 8
699:             .SpecialEffect = 1

*-- Linhas 735 a 755:
735:                     WITH loc_oGrid
736:                         .Column1.ControlSource   = "crSigFiNal.imps"
737:                         .Column1.Width           = 160
738:                         .Column1.Header1.Caption = "Impressora"
739: 
740:                         .Column2.ControlSource   = "crSigFiNal.ordems"
741:                         .Column2.Width           = 80
742:                         .Column2.Header1.Caption = "Ordem"
743: 
744:                         .Column3.ControlSource   = "crSigFiNal.descrs"
745:                         .Column3.Width           = 350
746:                         .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
747: 
748:                         .Column4.ControlSource   = "crSigFiNal.descs"
749:                         .Column4.Width           = 250
750:                         .Column4.Header1.Caption = "Rel. Gerencial"
751:                     ENDWITH
752: 
753:                     THIS.FormatarGridLista(loc_oGrid)
754:                     loc_lResultado = .T.
755:                 ENDIF

*-- Linhas 1153 a 1165:
1153: 
1154:         IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
1155:             WITH loc_oPg2.cnt_4c_BotoesAcao
1156:                 IF VARTYPE(.cmd_4c_Confirmar) = "O"
1157:                     .cmd_4c_Confirmar.Enabled = loc_lPodeEditar
1158:                 ENDIF
1159:                 IF VARTYPE(.cmd_4c_Cancelar) = "O"
1160:                     .cmd_4c_Cancelar.Enabled = .T.
1161:                 ENDIF
1162:                 .Visible     = .T.
1163:             ENDWITH
1164:         ENDIF
1165:     ENDPROC


### BO (C:\4c\projeto\app\classes\fnlBO.prg):
*==============================================================================
* fnlBO.prg - Business Object para Tabela de Finalizacoes (SigFiNal)
* Herda de: BusinessBase
* Tabela: SigFiNal (PK composta: imps + ordems)
*==============================================================================

DEFINE CLASS fnlBO AS BusinessBase

    *-- Propriedades da tabela SigFiNal
    this_cImps       = ""   && char(20) - Impressora (PK parte 1)
    this_nOrdems     = 0    && numeric(2,0) - Ordem finalizadora
    this_cDescrs     = ""   && char(40) - Descricao
    this_nCodFinzs   = 0    && numeric(2,0) - Codigo finalizador
    this_nFixos      = 2    && numeric(1,0) - Fixo (1=Sim, 2=Nao)
    this_cVincs      = "N"  && char(1) - Vinculado (S/N)
    this_nRelGers    = 0    && numeric(1,0) - FK SigFiRlg.ordems
    this_cDescs      = ""   && alias SigFiRlg.descrs (nao coluna real - lookup display)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiNal"
        THIS.this_cCampoChave = "imps"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cImps) + STR(THIS.this_nOrdems, 2, 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cImps       = TratarNulo(imps,       "C")
            THIS.this_nOrdems     = TratarNulo(ordems,     "N")
            THIS.this_cDescrs     = TratarNulo(descrs,     "C")
            THIS.this_nCodFinzs   = TratarNulo(ncodfinzs,  "N")
            THIS.this_nFixos      = TratarNulo(nfixos,     "N")
            THIS.this_cVincs      = TratarNulo(vincs,      "C")
            THIS.this_nRelGers    = TratarNulo(nrelgers,   "N")
            *-- descs vem do JOIN; se coluna existir no cursor, carregar
            IF TYPE("descs") != "U"
                THIS.this_cDescs  = TratarNulo(descs,      "C")
            ELSE
                THIS.this_cDescs  = ""
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.imps, a.ordems, a.descrs," + ;
                       " a.nfixos, a.ncodfinzs, a.vincs, a.nrelgers," + ;
                       " b.descrs AS descs" + ;
                       " FROM SigFiNal a" + ;
                       " LEFT JOIN SigFiRlg b ON b.ordems = a.nrelgers AND b.imps = a.imps"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.imps, a.ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiNal")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar finalizacoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cImps, par_nOrdems)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.imps, a.ordems, a.descrs," + ;
                       " a.nfixos, a.ncodfinzs, a.vincs, a.nrelgers," + ;
                       " b.descrs AS descs" + ;
                       " FROM SigFiNal a" + ;
                       " LEFT JOIN SigFiRlg b ON b.ordems = a.nrelgers AND b.imps = a.imps" + ;
                       " WHERE a.imps = " + EscaparSQL(par_cImps) + ;
                       " AND a.ordems = " + FormatarNumeroSQL(par_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFnl")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_CarregaFnl") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CarregaFnl")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_CarregaFnl")
            USE IN cursor_4c_CarregaFnl
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarRelGerencial - Busca registros de SigFiRlg para lookup de Rel. Gerencial
    *--------------------------------------------------------------------------
    PROCEDURE BuscarRelGerencial(par_cImps, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(par_cCursorDestino)
            par_cCursorDestino = "cursor_4c_RelGer"
        ENDIF

        TRY
            loc_cSQL = "SELECT ordems, descrs FROM SigFiRlg" + ;
                       " WHERE imps = " + EscaparSQL(par_cImps) + ;
                       " ORDER BY ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Rel. Gerencial:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigFiNal" + ;
                       " (imps, ordems, descrs, nfixos, ncodfinzs, vincs, nrelgers)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cImps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodFinzs) + ", " + ;
                       EscaparSQL(THIS.this_cVincs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nRelGers) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigFiNal SET" + ;
                       " imps = "      + EscaparSQL(THIS.this_cImps) + ", " + ;
                       " ordems = "    + FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       " descrs = "    + EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       " nfixos = "    + FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       " ncodfinzs = " + FormatarNumeroSQL(THIS.this_nCodFinzs) + ", " + ;
                       " vincs = "     + EscaparSQL(THIS.this_cVincs) + ", " + ;
                       " nrelgers = "  + FormatarNumeroSQL(THIS.this_nRelGers) + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(THIS.this_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOrdemDuplicada - Verifica se Imps+Ordems ja existe (INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOrdemDuplicada(par_cImps, par_nOrdems)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(par_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(par_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldOrd")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VldOrd") > 0
                loc_lDuplicado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VldOrd")
            USE IN cursor_4c_VldOrd
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigoDuplicado - Verifica se Imps+ncodfinzs ja existe (INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodigoDuplicado(par_cImps, par_nCodFinzs)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(par_cImps) + ;
                       " AND ncodfinzs = " + FormatarNumeroSQL(par_nCodFinzs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldCod")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VldCod") > 0
                loc_lDuplicado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VldCod")
            USE IN cursor_4c_VldCod
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarProximoNcodFinzs - Proximo codigo finalizador disponivel por impressora
    * Substitui fGerUniqueKey('SigFiNal') do legado
    *--------------------------------------------------------------------------
    PROCEDURE GerarProximoNcodFinzs(par_cImps)
        LOCAL loc_nResultado, loc_nProximo
        loc_nProximo = 1

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(ncodfinzs), 0) + 1 AS Proximo FROM SigFiNal" + ;
                " WHERE imps = " + EscaparSQL(par_cImps), ;
                "cursor_4c_ProxCod")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nProximo = cursor_4c_ProxCod.Proximo
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao gerar pr" + CHR(243) + "ximo c" + CHR(243) + "digo:" + ;
                CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_nProximo
    ENDPROC

ENDDEFINE

