# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 229: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 252: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 275: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 298: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 321: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 356: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 461: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 484: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFre.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1163 linhas total):

*-- Linhas 53 a 61:
53: 
54:             *-- Ajustar caption e variavel global pDopFrt (compatibilidade legado)
55:             IF !EMPTY(THIS.this_cDopes)
56:                 THIS.Caption = "Frete por Cidade " + THIS.this_cDopes
57:             ENDIF
58: 
59:             PUBLIC pDopFrt
60:             pDopFrt = THIS.this_cDopes
61: 

*-- Linhas 91 a 100:
91:                 THIS.ConfigurarPageFrame()
92: 
93:                 *-- 3. Propagar caption para labels do cabecalho
94:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
95:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
96: 
97:                 THIS.pgf_4c_Paginas.Visible   = .T.
98:                 THIS.pgf_4c_Paginas.ActivePage = 1
99:                 THIS.this_cModoAtual           = "LISTA"
100: 

*-- Linhas 126 a 145:
126: 
127:         WITH THIS.pgf_4c_Paginas
128:             .PageCount = 2
129:             .Top       = -29
130:             .Left      = 0
131:             .Width     = THIS.Width
132:             .Height    = THIS.Height + 29
133:             .Tabs      = .F.
134:             .Visible   = .T.
135: 
136:             .Page1.Caption   = "Lista"
137:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
138:             .Page1.BackColor = RGB(255, 255, 255)
139: 
140:             .Page2.Caption   = "Dados"
141:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
142:             .Page2.BackColor = RGB(255, 255, 255)
143:         ENDWITH
144: 
145:         THIS.ConfigurarPaginaLista()

*-- Linhas 161 a 198:
161:         *-- Container cabecalho (cntSombra no legado: Top=1, compensado +29 = 30)
162:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
163:         WITH loc_oPagina.cnt_4c_Cabecalho
164:             .Top         = 30
165:             .Left        = 0
166:             .Width       = THIS.Width
167:             .Height      = 80
168:             .BackColor   = RGB(100, 100, 100)
169:             .BorderWidth = 0
170:             .Visible     = .T.
171:         ENDWITH
172: 
173:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
174:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
175:             .Caption   = THIS.Caption
176:             .Top       = 15
177:             .Left      = 10
178:             .Width     = THIS.Width - 20
179:             .Height    = 40
180:             .FontName  = "Tahoma"
181:             .FontSize  = 16
182:             .FontBold  = .T.
183:             .ForeColor = RGB(0, 0, 0)
184:             .BackStyle = 0
185:             .AutoSize  = .F.
186:             .Visible   = .T.
187:         ENDWITH
188: 
189:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
190:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
191:             .Caption   = THIS.Caption
192:             .Top       = 18
193:             .Left      = 10
194:             .Width     = THIS.Width - 20
195:             .Height    = 46
196:             .FontName  = "Tahoma"
197:             .FontSize  = 16
198:             .FontBold  = .T.

*-- Linhas 205 a 380:
205:         *-- Container botoes CRUD (Grupo_op no legado: Left=543, Top=-1, compensado +29 = 28)
206:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
207:         WITH loc_oPagina.cnt_4c_Botoes
208:             .Top         = 28
209:             .Left        =  542
210:             .Width       = 385
211:             .Height      = 85
212:             .BackStyle = 0
213:             .BorderWidth = 0
214:             .Visible     = .T.
215:         ENDWITH
216: 
217:         *-- Botao Incluir (Left=5)
218:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
219:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
220:             .Caption         = "Incluir"
221:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
222:             .PicturePosition = 13
223:             .Top             = 5
224:             .Left            = 5
225:             .Width           = 75
226:             .Height          = 75
227:             .BackColor       = RGB(255, 255, 255)
228:             .ForeColor       = RGB(90, 90, 90)
229:             .FontName        = "Comic Sans MS"
230:             .FontSize        = 8
231:             .FontBold        = .T.
232:             .FontItalic      = .T.
233:             .Themes          = .F.
234:             .SpecialEffect   = 0
235:             .MousePointer    = 15
236:             .WordWrap        = .T.
237:         ENDWITH
238:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
239: 
240:         *-- Botao Visualizar (Left=80)
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
243:             .Caption         = "Visualizar"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
245:             .PicturePosition = 13
246:             .Top             = 5
247:             .Left            = 80
248:             .Width           = 75
249:             .Height          = 75
250:             .BackColor       = RGB(255, 255, 255)
251:             .ForeColor       = RGB(90, 90, 90)
252:             .FontName        = "Comic Sans MS"
253:             .FontSize        = 8
254:             .FontBold        = .T.
255:             .FontItalic      = .T.
256:             .Themes          = .F.
257:             .SpecialEffect   = 0
258:             .MousePointer    = 15
259:             .WordWrap        = .T.
260:         ENDWITH
261:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
262: 
263:         *-- Botao Alterar (Left=155)
264:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
265:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
266:             .Caption         = "Alterar"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 155
271:             .Width           = 75
272:             .Height          = 75
273:             .BackColor       = RGB(255, 255, 255)
274:             .ForeColor       = RGB(90, 90, 90)
275:             .FontName        = "Comic Sans MS"
276:             .FontSize        = 8
277:             .FontBold        = .T.
278:             .FontItalic      = .T.
279:             .Themes          = .F.
280:             .SpecialEffect   = 0
281:             .MousePointer    = 15
282:             .WordWrap        = .T.
283:         ENDWITH
284:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
285: 
286:         *-- Botao Excluir (Left=230)
287:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
288:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
289:             .Caption         = "Excluir"
290:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
291:             .PicturePosition = 13
292:             .Top             = 5
293:             .Left            = 230
294:             .Width           = 75
295:             .Height          = 75
296:             .BackColor       = RGB(255, 255, 255)
297:             .ForeColor       = RGB(90, 90, 90)
298:             .FontName        = "Comic Sans MS"
299:             .FontSize        = 8
300:             .FontBold        = .T.
301:             .FontItalic      = .T.
302:             .Themes          = .F.
303:             .SpecialEffect   = 0
304:             .MousePointer    = 15
305:             .WordWrap        = .T.
306:         ENDWITH
307:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
308: 
309:         *-- Botao Buscar (Left=305)
310:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
311:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
312:             .Caption         = "Buscar"
313:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
314:             .PicturePosition = 13
315:             .Top             = 5
316:             .Left            = 305
317:             .Width           = 75
318:             .Height          = 75
319:             .BackColor       = RGB(255, 255, 255)
320:             .ForeColor       = RGB(90, 90, 90)
321:             .FontName        = "Comic Sans MS"
322:             .FontSize        = 8
323:             .FontBold        = .T.
324:             .FontItalic      = .T.
325:             .Themes          = .F.
326:             .SpecialEffect   = 0
327:             .MousePointer    = 15
328:             .WordWrap        = .T.
329:         ENDWITH
330:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
331: 
332:         *-- Container saida canonico (CLAUDE.md regra #10 - Left=917, Width=90)
333:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
334:         WITH loc_oPagina.cnt_4c_Saida
335:             .Top         = 29
336:             .Left        = 917
337:             .Width       = 90
338:             .Height      = 85
339:             .BackStyle   = 0
340:             .BorderWidth = 0
341:             .Visible     = .T.
342:         ENDWITH
343: 
344:         *-- Botao Encerrar canonico (Left=5, Top=5, Width=75, Height=75, Caption="Encerrar")
345:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
346:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
347:             .Caption         = "Encerrar"
348:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
349:             .PicturePosition = 13
350:             .Top             = 5
351:             .Left            = 5
352:             .Width           = 75
353:             .Height          = 75
354:             .BackColor       = RGB(255, 255, 255)
355:             .ForeColor       = RGB(90, 90, 90)
356:             .FontName        = "Comic Sans MS"
357:             .FontSize        = 8
358:             .FontBold        = .T.
359:             .FontItalic      = .T.
360:             .Themes          = .F.
361:             .SpecialEffect   = 0
362:             .MousePointer    = 15
363:             .WordWrap        = .T.
364:         ENDWITH
365:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
366: 
367:         *-- Botao "Aguarde" visivel apenas durante carga do TmpCep
368:         *-- (btnAguarde no legado: Top=266, Left=338, Height=72, Width=322, Visible=.F.)
369:         loc_oPagina.AddObject("cmd_4c_BtnAguarde", "CommandButton")
370:         WITH loc_oPagina.cmd_4c_BtnAguarde
371:             .Top           = 295
372:             .Left          = 338
373:             .Width         = 322
374:             .Height        = 72
375:             .Caption       = "Aguarde!  Atualizando  Tabela de Cidades . . ."
376:             .FontBold      = .T.
377:             .FontName      = "Tahoma"
378:             .FontSize      = 9
379:             .ForeColor     = RGB(90, 90, 90)
380:             .BackColor     = RGB(255, 255, 255)

*-- Linhas 391 a 400:
391:         loc_oPagina.grd_4c_Lista.RecordSource = ""
392:         loc_oPagina.grd_4c_Lista.ColumnCount  = 2
393:         WITH loc_oPagina.grd_4c_Lista
394:             .Top                = 117
395:             .Left               = 12
396:             .Width              = 970
397:             .Height             = 470
398:             .DeleteMark         = .F.
399:             .RecordMark         = .F.
400:             .GridLines          = 3

*-- Linhas 407 a 505:
407:             .BackColor          = RGB(255, 255, 255)
408:             .FontName           = "Verdana"
409:             .FontSize           = 8
410:             .Column1.Header1.Caption = "Cidade"
411:             .Column1.Width           = 400
412:             .Column2.Header1.Caption = "Valor do Frete"
413:             .Column2.Width           = 120
414:             .Column2.Alignment       = 1
415:         ENDWITH
416:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
417: 
418:         THIS.TornarControlesVisiveis(loc_oPagina)
419: 
420:         *-- Garantir BtnAguarde oculto apos TornarControlesVisiveis
421:         loc_oPagina.cmd_4c_BtnAguarde.Visible = .F.
422:     ENDPROC
423: 
424:     *===========================================================================
425:     * ConfigurarPaginaDados - Configura Page2 (Dados)
426:     * Grupo_Salva: Left=836, Top=-5, compensado +29 = 24
427:     * Campos fase5: lbl_4c_Cidade (Say7) + txt_4c_Cidade (GetCidade)
428:     * Campos fase6: lbl_4c_ValorFrete (Say2) + txt_4c_Frete (get_Frete)
429:     *===========================================================================
430:     PROTECTED PROCEDURE ConfigurarPaginaDados()
431:         LOCAL loc_oPagina
432:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
433: 
434:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
435:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
436: 
437:         *-- Container botoes Confirmar/Cancelar
438:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
439:         WITH loc_oPagina.cnt_4c_BotoesAcao
440:             .Top         = 24
441:             .Left        = 836
442:             .Width       = 161
443:             .Height      = 85
444:             .BackStyle   = 0
445:             .BorderWidth = 0
446:             .Visible     = .T.
447:         ENDWITH
448: 
449:         *-- Botao Confirmar (Grupo_Salva.Salva: Top=5, Left=5)
450:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
451:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
452:             .Caption         = "Confirmar"
453:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
454:             .PicturePosition = 13
455:             .Top             = 5
456:             .Left            = 5
457:             .Width           = 75
458:             .Height          = 75
459:             .BackColor       = RGB(255, 255, 255)
460:             .ForeColor       = RGB(90, 90, 90)
461:             .FontName        = "Comic Sans MS"
462:             .FontSize        = 8
463:             .FontBold        = .T.
464:             .FontItalic      = .T.
465:             .Themes          = .F.
466:             .SpecialEffect   = 0
467:             .MousePointer    = 15
468:             .WordWrap        = .T.
469:         ENDWITH
470:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
471: 
472:         *-- Botao Cancelar (Grupo_Salva.Cancelar: Top=5, Left=81)
473:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
474:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
475:             .Caption         = "Encerrar"
476:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
477:             .PicturePosition = 13
478:             .Top             = 5
479:             .Left            = 81
480:             .Width           = 75
481:             .Height          = 75
482:             .BackColor       = RGB(255, 255, 255)
483:             .ForeColor       = RGB(90, 90, 90)
484:             .FontName        = "Comic Sans MS"
485:             .FontSize        = 8
486:             .FontBold        = .T.
487:             .FontItalic      = .T.
488:             .Themes          = .F.
489:             .SpecialEffect   = 0
490:             .MousePointer    = 15
491:             .WordWrap        = .T.
492:         ENDWITH
493:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
494: 
495:         *-- Label Cidade (Say7: Top=148, Left=314, compensado +29 = 177)
496:         loc_oPagina.AddObject("lbl_4c_Cidade", "Label")
497:         WITH loc_oPagina.lbl_4c_Cidade
498:             .Caption   = "Cidade :"
499:             .Top       = 177
500:             .Left      = 314
501:             .Width     = 55
502:             .Height    = 17
503:             .FontName  = "Tahoma"
504:             .FontSize  = 8
505:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 513 a 522:
513:         loc_oPagina.AddObject("txt_4c_Cidade", "TextBox")
514:         WITH loc_oPagina.txt_4c_Cidade
515:             .Value         = ""
516:             .Top           = 174
517:             .Left          = 359
518:             .Width         = 220
519:             .Height        = 25
520:             .MaxLength     = 30
521:             .SpecialEffect = 1
522:             .FontName      = "Tahoma"

*-- Linhas 530 a 542:
530:         BINDEVENT(loc_oPagina.txt_4c_Cidade, "KeyPress", THIS, "ValidarCidade")
531: 
532:         *-- Label Valor do Frete (Say2: Top=176, Left=279, Height=15, Width=77, compensado +29 = 205)
533:         loc_oPagina.AddObject("lbl_4c_ValorFrete", "Label")
534:         WITH loc_oPagina.lbl_4c_ValorFrete
535:             .Caption   = "Valor do Frete :"
536:             .Top       = 205
537:             .Left      = 279
538:             .Width     = 77
539:             .Height    = 15
540:             .FontName  = "Tahoma"
541:             .FontSize  = 8
542:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 550 a 559:
550:         loc_oPagina.AddObject("txt_4c_Frete", "TextBox")
551:         WITH loc_oPagina.txt_4c_Frete
552:             .Value         = 0
553:             .Top           = 200
554:             .Left          = 359
555:             .Width         = 100
556:             .Height        = 25
557:             .InputMask     = "999,999.99"
558:             .MaxLength     = 10
559:             .SpecialEffect = 1

*-- Linhas 586 a 595:
586: 
587:             *-- Exibir indicador de progresso (equivalente ao btnAguarde do legado)
588:             IF VARTYPE(loc_oPagina) = "O" AND ;
589:                PEMSTATUS(loc_oPagina, "cmd_4c_BtnAguarde", 5)
590:                 loc_oPagina.cmd_4c_BtnAguarde.Visible = .T.
591:                 THIS.Refresh()
592:             ENDIF
593: 
594:             *-- Tentar carregar cidades do banco Cep
595:             SET NULL ON

*-- Linhas 629 a 638:
629: 
630:         *-- Ocultar indicador de progresso
631:         IF VARTYPE(loc_oPagina) = "O" AND ;
632:            PEMSTATUS(loc_oPagina, "cmd_4c_BtnAguarde", 5)
633:             loc_oPagina.cmd_4c_BtnAguarde.Visible = .F.
634:         ENDIF
635:     ENDPROC
636: 
637:     *===========================================================================
638:     * CarregarLista - Carrega dados no grid da Page1 via FreBO.Buscar()

*-- Linhas 653 a 663:
653:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cidas"
654:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.valors"
655:                         *-- Redefinir headers apos RecordSource (auto-bind os sobrescreve)
656:                         loc_oGrid.Column1.Header1.Caption = "Cidade"
657:                         loc_oGrid.Column1.Width           = 400
658:                         loc_oGrid.Column2.Header1.Caption = "Valor do Frete"
659:                         loc_oGrid.Column2.Width           = 120
660:                         loc_oGrid.Column2.Alignment       = 1
661:                         THIS.FormatarGridLista(loc_oGrid)
662:                         loc_lResultado = .T.
663:                     ENDIF

*-- Linhas 798 a 811:
798:             ENDIF
799: 
800:             IF PEMSTATUS(loc_oPag2, "cnt_4c_BotoesAcao", 5)
801:                 IF PEMSTATUS(loc_oPag2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
802:                     *-- Confirmar sempre habilitado (em VISUALIZAR navega de volta para lista)
803:                     loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
804:                 ENDIF
805:                 IF PEMSTATUS(loc_oPag2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
806:                     loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
807:                 ENDIF
808:             ENDIF
809:         CATCH TO loException
810:             MostrarErro(loException, "FormFre.HabilitarCampos")
811:         ENDTRY

*-- Linhas 822 a 834:
822: 
823:         TRY
824:             IF PEMSTATUS(loc_oPag2, "cnt_4c_BotoesAcao", 5) AND ;
825:                PEMSTATUS(loc_oPag2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
826:                 IF THIS.this_cModoAtual = "VISUALIZAR"
827:                     loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "OK"
828:                 ELSE
829:                     loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "Confirmar"
830:                 ENDIF
831:             ENDIF
832:         CATCH TO loException
833:             MostrarErro(loException, "FormFre.AjustarBotoesPorModo")
834:         ENDTRY

*-- Linhas 890 a 899:
890:                     THIS.pgf_4c_Paginas.ActivePage = 2
891:                     *-- Foco no botao Confirmar (legado: Grupo_salva.Salva.setfocus)
892:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5) AND ;
893:                        PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
894:                         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
895:                     ENDIF
896:                 ENDIF
897:             ENDIF
898:         CATCH TO loException
899:             MostrarErro(loException, "FormFre.BtnVisualizarClick")

*-- Linhas 988 a 998:
988:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cidas"
989:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.valors"
990:                     *-- Redefinir headers apos RecordSource
991:                     loc_oGrid.Column1.Header1.Caption = "Cidade"
992:                     loc_oGrid.Column1.Width           = 400
993:                     loc_oGrid.Column2.Header1.Caption = "Valor do Frete"
994:                     loc_oGrid.Column2.Width           = 120
995:                     loc_oGrid.Column2.Alignment       = 1
996:                     THIS.FormatarGridLista(loc_oGrid)
997:                 ENDIF
998:             ENDIF


### BO (C:\4c\projeto\app\classes\FreBO.prg):
*==============================================================================
* FreBO.prg - Business Object: Fretes por Cidade
*==============================================================================
* Tabelas:
*   SigCdFrt  - modo global (this_cDopes vazio): PK = cidas
*   SigOpFrt  - modo operacional (this_cDopes preenchido): chave composta cidas+dopes
*==============================================================================

DEFINE CLASS FreBO AS BusinessBase

    *-- Campos compartilhados (SigCdFrt e SigOpFrt)
    this_cCidade     = ""   && cidas       CHAR(30)       - nome da cidade
    this_nFrete      = 0    && valors      NUMERIC(11,2)  - valor do frete

    *-- Campos exclusivos modo operacional (SigOpFrt)
    this_cDopes      = ""   && dopes       CHAR(20)       - tipo de operacao (vazio = modo global)

    *===========================================================================
    * Init - Inicializa BO no modo global (SigCdFrt / PK = cidas)
    *        Para modo operacional: setar this_cDopes apos Init()
    *===========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFrt"
            THIS.this_cCampoChave = "cidas"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "FreBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *   Ambos os modos: cidas (cidade)
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidade)
    ENDFUNC

    *===========================================================================
    * Buscar - Lista registros no cursor cursor_4c_Dados
    *   par_cFiltro: filtro opcional em cidas (LIKE)
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: SigCdFrt
                IF EMPTY(par_cFiltro)
                    loc_cSQL = "SELECT cidas, valors FROM SigCdFrt ORDER BY cidas"
                ELSE
                    loc_cSQL = "SELECT cidas, valors FROM SigCdFrt" + ;
                        " WHERE cidas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                        " ORDER BY cidas"
                ENDIF
            ELSE
                *-- Modo operacional: SigOpFrt filtrado por dopes
                IF EMPTY(par_cFiltro)
                    loc_cSQL = "SELECT cidas, dopes, valors FROM SigOpFrt" + ;
                        " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                        " ORDER BY cidas"
                ELSE
                    loc_cSQL = "SELECT cidas, dopes, valors FROM SigOpFrt" + ;
                        " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                        " AND cidas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                        " ORDER BY cidas"
                ENDIF
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar fretes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CarregarPorCodigo - Carrega registro por cidas no cursor cursor_4c_Carrega
    *   Modo global:      WHERE cidas = par_cCodigo
    *   Modo operacional: WHERE cidas = par_cCodigo AND dopes = this_cDopes
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                loc_cSQL = "SELECT cidas, valors FROM SigCdFrt" + ;
                    " WHERE cidas = " + EscaparSQL(par_cCodigo)
            ELSE
                loc_cSQL = "SELECT cidas, dopes, valors FROM SigOpFrt" + ;
                    " WHERE cidas = " + EscaparSQL(par_cCodigo) + ;
                    " AND dopes = " + EscaparSQL(THIS.this_cDopes)
            ENDIF

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
        CATCH TO loException
            MostrarErro(loException, "FreBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *===========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidade = TratarNulo(cidas, "C")
                THIS.this_nFrete  = TratarNulo(valors, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * Inserir - INSERT em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: INSERT em SigCdFrt
                loc_cSQL = "INSERT INTO SigCdFrt (cidas, valors) VALUES (" + ;
                    EscaparSQL(THIS.this_cCidade) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nFrete) + ")"
            ELSE
                *-- Modo operacional: INSERT em SigOpFrt com chave composta cidas+dopes
                loc_cSQL = "INSERT INTO SigOpFrt (cidas, dopes, valors) VALUES (" + ;
                    EscaparSQL(THIS.this_cCidade) + ", " + ;
                    EscaparSQL(THIS.this_cDopes) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nFrete) + ")"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * Atualizar - UPDATE em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: UPDATE SigCdFrt por cidas (PK nao alteravel, so valors)
                loc_cSQL = "UPDATE SigCdFrt SET" + ;
                    " valors = " + FormatarNumeroSQL(THIS.this_nFrete) + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade)
            ELSE
                *-- Modo operacional: UPDATE SigOpFrt pela chave composta cidas+dopes
                loc_cSQL = "UPDATE SigOpFrt SET" + ;
                    " valors = " + FormatarNumeroSQL(THIS.this_nFrete) + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade) + ;
                    " AND dopes = " + EscaparSQL(THIS.this_cDopes)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * ExecutarExclusao - DELETE em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                loc_cSQL = "DELETE FROM SigCdFrt WHERE cidas = " + EscaparSQL(THIS.this_cCidade)
            ELSE
                loc_cSQL = "DELETE FROM SigOpFrt" + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade) + ;
                    " AND dopes = " + EscaparSQL(THIS.this_cDopes)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

