# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 193: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 218: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 243: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 268: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 293: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 329: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 428: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 452: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMrc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1035 linhas total):

*-- Linhas 53 a 65:
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55: 
56:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra") = "O"
57:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
58:                 ENDIF
59:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo") = "O"
60:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
61:                 ENDIF
62: 
63:                 THIS.pgf_4c_Paginas.Visible = .T.
64:                 THIS.pgf_4c_Paginas.ActivePage = 1
65:                 THIS.this_cModoAtual = "LISTA"

*-- Linhas 91 a 112:
91: 
92:         WITH THIS.pgf_4c_Paginas
93:             .PageCount = 2
94:             .Top       = -29
95:             .Left      = 0
96:             .Width     = THIS.Width
97:             .Height    = THIS.Height
98:             .Tabs      = .F.
99: 
100:             .Page1.BackColor = RGB(100, 100, 100)
101:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page1.Caption   = "Lista"
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104: 
105:             .Page2.BackColor = RGB(100, 100, 100)
106:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Page2.Caption   = "Dados"
108:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
109:         ENDWITH
110: 
111:         THIS.ConfigurarPaginaLista()
112:         THIS.ConfigurarPaginaDados()

*-- Linhas 125 a 162:
125:         *-- Cabecalho cinza escuro (cntSombra no legado)
126:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
127:         WITH loc_oPagina.cnt_4c_Cabecalho
128:             .Top         = 31
129:             .Left        = 0
130:             .Width       = THIS.Width
131:             .Height      = 80
132:             .BackColor   = RGB(100, 100, 100)
133:             .BorderWidth = 0
134:             .Visible     = .T.
135:         ENDWITH
136: 
137:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
138:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
139:             .Caption   = THIS.Caption
140:             .Top       = 15
141:             .Left      = 10
142:             .Width     = THIS.Width - 20
143:             .Height    = 40
144:             .FontName  = "Tahoma"
145:             .FontSize  = 16
146:             .FontBold  = .T.
147:             .ForeColor = RGB(0, 0, 0)
148:             .BackStyle = 0
149:             .AutoSize  = .F.
150:             .Visible   = .T.
151:         ENDWITH
152: 
153:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
154:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
155:             .Caption   = THIS.Caption
156:             .Top       = 18
157:             .Left      = 10
158:             .Width     = THIS.Width - 20
159:             .Height    = 46
160:             .FontName  = "Tahoma"
161:             .FontSize  = 16
162:             .FontBold  = .T.

*-- Linhas 169 a 354:
169:         *-- Container botoes CRUD (Grupo_op no legado: Left=343, Top=-1 -> canonico Left=542, Top=29)
170:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
171:         WITH loc_oPagina.cnt_4c_Botoes
172:             .Top         = 29
173:             .Left        = 542
174:             .Width       = 385
175:             .Height      = 85
176:             .BackStyle = 0
177:             .BorderWidth = 0
178:             .Visible     = .T.
179:         ENDWITH
180: 
181:         *-- Incluir (Inserir no legado: Left=5, Top=5)
182:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
183:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
184:             .Caption         = "Incluir"
185:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
186:             .PicturePosition = 13
187:             .Top             = 5
188:             .Left            = 5
189:             .Width           = 75
190:             .Height          = 75
191:             .BackColor       = RGB(255, 255, 255)
192:             .ForeColor       = RGB(90, 90, 90)
193:             .FontName        = "Comic Sans MS"
194:             .FontSize        = 8
195:             .FontBold        = .T.
196:             .FontItalic      = .T.
197:             .Themes          = .F.
198:             .SpecialEffect   = 0
199:             .MousePointer    = 15
200:             .WordWrap        = .T.
201:             .AutoSize        = .F.
202:             .Visible         = .T.
203:         ENDWITH
204:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
205: 
206:         *-- Visualizar (Consultar no legado: Left=80, Top=5)
207:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
208:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
209:             .Caption         = "Visualizar"
210:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
211:             .PicturePosition = 13
212:             .Top             = 5
213:             .Left            = 80
214:             .Width           = 75
215:             .Height          = 75
216:             .BackColor       = RGB(255, 255, 255)
217:             .ForeColor       = RGB(90, 90, 90)
218:             .FontName        = "Comic Sans MS"
219:             .FontSize        = 8
220:             .FontBold        = .T.
221:             .FontItalic      = .T.
222:             .Themes          = .F.
223:             .SpecialEffect   = 0
224:             .MousePointer    = 15
225:             .WordWrap        = .T.
226:             .AutoSize        = .F.
227:             .Visible         = .T.
228:         ENDWITH
229:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
230: 
231:         *-- Alterar (Left=155, Top=5)
232:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
233:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
234:             .Caption         = "Alterar"
235:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
236:             .PicturePosition = 13
237:             .Top             = 5
238:             .Left            = 155
239:             .Width           = 75
240:             .Height          = 75
241:             .BackColor       = RGB(255, 255, 255)
242:             .ForeColor       = RGB(90, 90, 90)
243:             .FontName        = "Comic Sans MS"
244:             .FontSize        = 8
245:             .FontBold        = .T.
246:             .FontItalic      = .T.
247:             .Themes          = .F.
248:             .SpecialEffect   = 0
249:             .MousePointer    = 15
250:             .WordWrap        = .T.
251:             .AutoSize        = .F.
252:             .Visible         = .T.
253:         ENDWITH
254:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
255: 
256:         *-- Excluir (Left=230, Top=5)
257:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
258:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
259:             .Caption         = "Excluir"
260:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
261:             .PicturePosition = 13
262:             .Top             = 5
263:             .Left            = 230
264:             .Width           = 75
265:             .Height          = 75
266:             .BackColor       = RGB(255, 255, 255)
267:             .ForeColor       = RGB(90, 90, 90)
268:             .FontName        = "Comic Sans MS"
269:             .FontSize        = 8
270:             .FontBold        = .T.
271:             .FontItalic      = .T.
272:             .Themes          = .F.
273:             .SpecialEffect   = 0
274:             .MousePointer    = 15
275:             .WordWrap        = .T.
276:             .AutoSize        = .F.
277:             .Visible         = .T.
278:         ENDWITH
279:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
280: 
281:         *-- Buscar (Procurar no legado: Left=305, Top=5)
282:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
283:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
284:             .Caption         = "Buscar"
285:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
286:             .PicturePosition = 13
287:             .Top             = 5
288:             .Left            = 305
289:             .Width           = 75
290:             .Height          = 75
291:             .BackColor       = RGB(255, 255, 255)
292:             .ForeColor       = RGB(90, 90, 90)
293:             .FontName        = "Comic Sans MS"
294:             .FontSize        = 8
295:             .FontBold        = .T.
296:             .FontItalic      = .T.
297:             .Themes          = .F.
298:             .SpecialEffect   = 0
299:             .MousePointer    = 15
300:             .WordWrap        = .T.
301:             .AutoSize        = .F.
302:             .Visible         = .T.
303:         ENDWITH
304:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
305: 
306:         *-- Container Saida - padrao canonico (Grupo_Saida no legado: Left=718, Top=-1)
307:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
308:         WITH loc_oPagina.cnt_4c_Saida
309:             .Top         = 29
310:             .Left        = 917
311:             .Width       = 90
312:             .Height      = 85
313:             .BackStyle   = 0
314:             .BorderWidth = 0
315:             .Visible     = .T.
316:         ENDWITH
317: 
318:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
319:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
320:             .Caption         = "Encerrar"
321:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
322:             .PicturePosition = 13
323:             .Top             = 5
324:             .Left            = 5
325:             .Width           = 75
326:             .Height          = 75
327:             .BackColor       = RGB(255, 255, 255)
328:             .ForeColor       = RGB(90, 90, 90)
329:             .FontName        = "Comic Sans MS"
330:             .FontSize        = 8
331:             .FontBold        = .T.
332:             .FontItalic      = .T.
333:             .Themes          = .F.
334:             .SpecialEffect   = 0
335:             .MousePointer    = 15
336:             .WordWrap        = .T.
337:             .AutoSize        = .F.
338:             .Visible         = .T.
339:         ENDWITH
340:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Botao Itens (Legado: Top=86, Left=347, Width=105, Height=45 -> Top compensado +29)
343:         loc_oPagina.AddObject("cmd_4c_Itens", "CommandButton")
344:         WITH loc_oPagina.cmd_4c_Itens
345:             .Caption         = "Itens"
346:             .Picture         = gc_4c_CaminhoIcones + "folder31.ico"
347:             .PicturePosition = 13
348:             .Top             = 115
349:             .Left            = 347
350:             .Width           = 105
351:             .Height          = 45
352:             .BackColor       = RGB(255, 255, 255)
353:             .ForeColor       = RGB(90, 90, 90)
354:             .FontName        = "Tahoma"

*-- Linhas 360 a 374:
360:             .ToolTipText     = "Itens"
361:             .Visible         = .T.
362:         ENDWITH
363:         BINDEVENT(loc_oPagina.cmd_4c_Itens, "Click", THIS, "BtnItensClick")
364: 
365:         *-- Grade (Legado: Grade.Top=133, Left=32, Width=736, Height=433 -> Top +29=162)
366:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
367:         WITH loc_oPagina.grd_4c_Lista
368:             .Top                = 162
369:             .Left               = 32
370:             .Width              = 736
371:             .Height             = 433
372:             .FontName           = "Tahoma"
373:             .FontSize           = 8
374:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 405 a 507:
405:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
406:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
407:         WITH loc_oPagina.cnt_4c_BotoesAcao
408:             .Top         = 33
409:             .Left        = 842
410:             .Width       = 160
411:             .Height      = 85
412:             .BackStyle   = 0
413:             .BorderWidth = 0
414:             .Visible     = .T.
415:         ENDWITH
416: 
417:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
418:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
419:             .Caption         = "Confirmar"
420:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
421:             .PicturePosition = 13
422:             .Top             = 5
423:             .Left            = 5
424:             .Width           = 75
425:             .Height          = 75
426:             .BackColor       = RGB(255, 255, 255)
427:             .ForeColor       = RGB(90, 90, 90)
428:             .FontName        = "Comic Sans MS"
429:             .FontSize        = 8
430:             .FontBold        = .T.
431:             .FontItalic      = .T.
432:             .Themes          = .F.
433:             .SpecialEffect   = 0
434:             .MousePointer    = 15
435:             .WordWrap        = .T.
436:             .AutoSize        = .F.
437:             .Visible         = .T.
438:         ENDWITH
439:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
440: 
441:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
442:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
443:             .Caption         = "Encerrar"
444:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
445:             .PicturePosition = 13
446:             .Top             = 5
447:             .Left            = 80
448:             .Width           = 75
449:             .Height          = 75
450:             .BackColor       = RGB(255, 255, 255)
451:             .ForeColor       = RGB(90, 90, 90)
452:             .FontName        = "Comic Sans MS"
453:             .FontSize        = 8
454:             .FontBold        = .T.
455:             .FontItalic      = .T.
456:             .Themes          = .F.
457:             .SpecialEffect   = 0
458:             .MousePointer    = 15
459:             .WordWrap        = .T.
460:             .AutoSize        = .F.
461:             .Visible         = .T.
462:         ENDWITH
463:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
464: 
465:         *-- Label: Demonstrativo (Say1: Top=195, Left=210, Height=15 -> Top +29=224)
466:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
467:         WITH loc_oPagina.lbl_4c_Label1
468:             .Caption   = "Demonstrativo : "
469:             .Top       = 224
470:             .Left      = 210
471:             .Height    = 15
472:             .Width     = 87
473:             .AutoSize  = .F.
474:             .FontName  = "Tahoma"
475:             .FontSize  = 8
476:             .ForeColor = RGB(90, 90, 90)
477:             .BackStyle = 0
478:             .Visible   = .T.
479:         ENDWITH
480: 
481:         *-- Label: Titulo (Say2: Top=220, Left=254 -> Top +29=249)
482:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
483:         WITH loc_oPagina.lbl_4c_Label2
484:             .Caption   = "T" + CHR(237) + "tulo : "
485:             .Top       = 249
486:             .Left      = 254
487:             .Height    = 15
488:             .Width     = 43
489:             .AutoSize  = .F.
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8
492:             .ForeColor = RGB(90, 90, 90)
493:             .BackStyle = 0
494:             .Visible   = .T.
495:         ENDWITH
496: 
497:         *-- Label: Impressao (Say3: Top=247, Left=230 -> Top +29=276)
498:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
499:         WITH loc_oPagina.lbl_4c_Label3
500:             .Caption   = "Impress" + CHR(227) + "o : "
501:             .Top       = 276
502:             .Left      = 230
503:             .Height    = 15
504:             .Width     = 67
505:             .AutoSize  = .F.
506:             .FontName  = "Tahoma"
507:             .FontSize  = 8

*-- Linhas 515 a 524:
515:         loc_oPagina.AddObject("txt_4c_Balanco", "TextBox")
516:         WITH loc_oPagina.txt_4c_Balanco
517:             .Value     = ""
518:             .Top       = 221
519:             .Left      = 299
520:             .Width     = 150
521:             .Height    = 20
522:             .MaxLength = 20
523:             .Format    = "!K"
524:             .FontName  = "Tahoma"

*-- Linhas 534 a 543:
534:         loc_oPagina.AddObject("txt_4c_Titulo", "TextBox")
535:         WITH loc_oPagina.txt_4c_Titulo
536:             .Value     = ""
537:             .Top       = 246
538:             .Left      = 299
539:             .Width     = 290
540:             .Height    = 20
541:             .MaxLength = 40
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8

*-- Linhas 554 a 587:
554:         loc_oPagina.opt_4c_Impressao.ButtonCount = 2
555:         WITH loc_oPagina.opt_4c_Impressao
556:             .Value       = 1
557:             .Top         = 271
558:             .Left        = 299
559:             .Width       = 246
560:             .Height      = 27
561:             .BackStyle   = 0
562:             .BorderStyle = 0
563:             .TabIndex    = 3
564:             .Visible     = .T.
565:         ENDWITH
566: 
567:         WITH loc_oPagina.opt_4c_Impressao.Buttons(1)
568:             .Caption   = "Plano de Contas"
569:             .Top       = 5
570:             .Left      = 5
571:             .Width     = 110
572:             .Height    = 17
573:             .FontName  = "Tahoma"
574:             .FontSize  = 8
575:             .ForeColor = RGB(90, 90, 90)
576:             .BackStyle = 0
577:         ENDWITH
578: 
579:         WITH loc_oPagina.opt_4c_Impressao.Buttons(2)
580:             .Caption   = "Mapa de Contas"
581:             .Top       = 5
582:             .Left      = 126
583:             .Width     = 110
584:             .Height    = 17
585:             .FontName  = "Tahoma"
586:             .FontSize  = 8
587:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 618 a 628:
618:                         "IIF(cursor_4c_Dados.Mapas=2,'MAPA','PLANO')"
619: 
620:                     *-- Headers APOS RecordSource (Problema 6/32: VFP reseta headers)
621:                     loc_oGrid.Column1.Header1.Caption = "Demonstrativo"
622:                     loc_oGrid.Column2.Header1.Caption = "T" + CHR(237) + "tulo"
623:                     loc_oGrid.Column3.Header1.Caption = "Impress" + CHR(227) + "o"
624: 
625:                     *-- Larguras conforme legado
626:                     loc_oGrid.Column1.Width = 150
627:                     loc_oGrid.Column2.Width = 290
628:                     loc_oGrid.Column3.Width = 75

*-- Linhas 708 a 717:
708:             THIS.HabilitarCampos(.F.)
709:             THIS.AjustarBotoesPorModo()
710:             THIS.AlternarPagina(2)
711:             IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar") = "O"
712:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
713:             ENDIF
714:         ENDIF
715:     ENDPROC
716: 
717:     *--------------------------------------------------------------------------

*-- Linhas 761 a 770:
761:             THIS.HabilitarCampos(.F.)
762:             THIS.AjustarBotoesPorModo()
763:             THIS.AlternarPagina(2)
764:             IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
765:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
766:             ENDIF
767:         ENDIF
768:     ENDPROC
769: 
770:     *--------------------------------------------------------------------------

*-- Linhas 973 a 984:
973:         LOCAL loc_oPg2
974:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
975: 
976:         IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
977:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
978:                 INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "EXCLUIR")
979:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
980:         ENDIF
981:     ENDPROC
982: 
983:     *--------------------------------------------------------------------------
984:     * TornarControlesVisiveis - Torna controles visiveis recursivamente


### BO (C:\4c\projeto\app\classes\MrcBO.prg):
*==============================================================================
* MrcBO.prg - Business Object para Cadastro de Demonstrativos
* Tabela principal: SigCdMrr (Demonstrativos)
* Tabela relacionada: SigCdMri (Itens do Demonstrativo)
*==============================================================================
DEFINE CLASS MrcBO AS BusinessBase

    *-- Propriedades da entidade SigCdMrr
    this_cBalanco   = ""   && balancos char(20) - chave primaria
    this_cTitulo    = ""   && titulos  char(40)
    this_nMapa      = 1    && mapas    numeric(1,0): 1=Plano de Contas, 2=Mapa de Contas

    *-- Nome do cursor principal
    this_cCursorDados = "cursor_4c_Dados"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMrr"
        THIS.this_cCampoChave = "Balancos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cBalanco
    ENDFUNC

    *--------------------------------------------------------------------------
    * NovoRegistro - Prepara BO para INSERT
    *--------------------------------------------------------------------------
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cBalanco = ""
        THIS.this_cTitulo  = ""
        THIS.this_nMapa    = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * EditarRegistro - Prepara BO para UPDATE
    *--------------------------------------------------------------------------
    PROCEDURE EditarRegistro()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cBalanco = TratarNulo(Balancos, "C")
            THIS.this_cTitulo  = TratarNulo(Titulos,  "C")
            THIS.this_nMapa    = TratarNulo(Mapas,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cBalanco))
            THIS.this_cMensagemErro = "Demonstrativo " + CHR(233) + " obrigat" + CHR(243) + "rio."
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona registros de SigCdMrr para a grade
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE Balancos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = "SELECT Balancos, Titulos, Mapas" + ;
                       " FROM SigCdMrr" + ;
                       loc_cWhere + ;
                       " ORDER BY Balancos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar demonstrativos: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao buscar demonstrativos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um demonstrativo pelo codigo (Balancos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Balancos, Titulos, Mapas" + ;
                       " FROM SigCdMrr" + ;
                       " WHERE Balancos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Demonstrativo n" + CHR(227) + "o encontrado."
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se Balancos ja existe em SigCdMrr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdMrr" + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DupChk") > 0
                SELECT cursor_4c_DupChk
                loc_lExiste = (cursor_4c_DupChk.Total > 0)
            ENDIF

            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo demonstrativo em SigCdMrr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                THIS.this_cMensagemErro = "Demonstrativo j" + CHR(225) + " cadastrado."
                MsgAviso(THIS.this_cMensagemErro, "Registro Duplicado")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "INSERT INTO SigCdMrr (Balancos, Titulos, Mapas)" + ;
                           " VALUES (" + EscaparSQL(THIS.this_cBalanco) + ;
                           ", " + EscaparSQL(THIS.this_cTitulo) + ;
                           ", " + FormatarNumeroSQL(THIS.this_nMapa) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao inserir demonstrativo: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza demonstrativo existente em SigCdMrr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMrr" + ;
                       " SET Titulos = " + EscaparSQL(THIS.this_cTitulo) + ;
                       ", Mapas = " + FormatarNumeroSQL(THIS.this_nMapa) + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar demonstrativo: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui demonstrativo e seus itens (PROTECTED)
    * Cascade: DELETE SigCdMri primeiro, depois SigCdMrr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- 1. Excluir itens do demonstrativo (SigCdMri) - cascade
            loc_cSQL = "DELETE FROM SigCdMri WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelMri")

            IF USED("cursor_4c_DelMri")
                USE IN cursor_4c_DelMri
            ENDIF

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao excluir itens: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                *-- 2. Excluir o demonstrativo principal (SigCdMrr)
                loc_cSQL = "DELETE FROM SigCdMrr WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelMrr")

                IF USED("cursor_4c_DelMrr")
                    USE IN cursor_4c_DelMrr
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao excluir demonstrativo: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao excluir demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DelMri")
                USE IN cursor_4c_DelMri
            ENDIF
            IF USED("cursor_4c_DelMrr")
                USE IN cursor_4c_DelMrr
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

