# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_LocalVen' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Vendedor, Descricao, Atendimentos. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Vendedor, Descricao, Atendimentos. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Vendedor, Descricao, Atendimentos. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'excluir' (parent: SIGMVATE): Left original=523 vs migrado 'cmd_4c_Excluir' Left=230 (diff=293px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvAte.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1257 linhas total):

*-- Linhas 12 a 32:
12: * Historico de fases:
13: *   Fase 1/2: SigMvAteBO.prg (propriedades + CRUD completo)
14: *   Fase 3:   FormSigMvAte.prg - estrutura base (Init, InicializarForm,
15: *             ConfigurarPageFrame/ConfigurarCabecalho, TornarControlesVisiveis,
16: *             Destroy). Grade + cmg_4c_Botoes (Confirmar/Cancelar) +
17: *             cmd_4c_Incluir + cmd_4c_Excluir ficam para a Fase 4.
18: *==============================================================================
19: DEFINE CLASS FormSigMvAte AS FormBase
20: 
21:     *-- Parametros de entrada recebidos no Init (contexto do documento pai
22:     *-- SigMvCab, equivalente a TprMvCab/pcEscolha do legado)
23:     this_cEmpDopNums  = ""   && empdopnums do documento pai - FK dos atendimentos
24:     this_cEmps        = ""   && empresa do documento pai
25:     this_cGrVends     = ""   && grupo de vendedores aceito (grvends do SigMvCab) - usado no lookup fAcessoContas
26:     this_cModoEscolha = ""   && modo do documento pai: INSERIR/ALTERAR/CONSULTAR - habilita/desabilita Incluir/Excluir na Fase 4
27: 
28:     *-- Business Object
29:     this_oBusinessObject = .NULL.
30: 
31:     *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGMVATE)
32:     Width        = 618

*-- Linhas 92 a 120:
92:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
93: 
94:             *-- Caption identico ao legado (sem acentos - dispensa CHR())
95:             THIS.Caption = "Registra os atendimentos dos vendedores"
96: 
97:             *-- Cursor placeholder da grade (READWRITE por natureza - CREATE
98:             *-- CURSOR sempre eh atualizavel). Precisa existir ANTES de
99:             *-- ConfigurarPageFrame (RecordSource do grid). A ORDEM dos campos
100:             *-- tem de ser IDENTICA a SigMvAteBO.CarregarAtendimentosDocumento.
101:             SET NULL ON
102:             IF USED("cursor_4c_LocalVen")
103:                 USE IN cursor_4c_LocalVen
104:             ENDIF
105:             CREATE CURSOR cursor_4c_LocalVen ;
106:                 (CodVends C(10) NULL, DesVends C(40) NULL, NAtends N(4,0) NULL)
107:             SET NULL OFF
108: 
109:             THIS.ConfigurarPageFrame()
110: 
111:             *-- Propaga o titulo para os labels do cabecalho
112:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
113:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
114: 
115:             *-- Carrega os atendimentos ja gravados para o documento
116:             *-- (sem conexao em modo de teste de UI)
117:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
118:                 THIS.CarregarLista()
119:             ENDIF
120: 

*-- Linhas 154 a 202:
154:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
155:         loc_oCab = THIS.cnt_4c_Cabecalho
156:         WITH loc_oCab
157:             .Top         = 0
158:             .Left        = 0
159:             .Width       = THIS.Width
160:             .Height      = 80
161:             .BorderWidth = 0
162:             .BackStyle   = 1
163:             .BackColor   = RGB(100, 100, 100)
164:         ENDWITH
165: 
166:         *-- Labels adicionados FORA do WITH do container: WITH aninhado com
167:         *-- AddObject ignora propriedades silenciosamente (CLAUDE.md #33)
168:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
169:         WITH loc_oCab.lbl_4c_Sombra
170:             .FontBold  = .T.
171:             .FontName  = "Tahoma"
172:             .FontSize  = 18
173:             .WordWrap  = .T.
174:             .AutoSize  = .F.
175:             .Alignment = 0
176:             .BackStyle = 0
177:             .Caption   = ""
178:             .Height    = 40
179:             .Left      = 10
180:             .Top       = 18
181:             .Width     = 769
182:             .ForeColor = RGB(0, 0, 0)
183:         ENDWITH
184: 
185:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
186:         WITH loc_oCab.lbl_4c_Titulo
187:             .FontBold  = .T.
188:             .FontName  = "Tahoma"
189:             .FontSize  = 18
190:             .WordWrap  = .T.
191:             .AutoSize  = .F.
192:             .Alignment = 0
193:             .BackStyle = 0
194:             .Caption   = ""
195:             .Height    = 46
196:             .Left      = 10
197:             .Top       = 17
198:             .Width     = 769
199:             .ForeColor = RGB(255, 255, 255)
200:         ENDWITH
201:     ENDPROC
202: 

*-- Linhas 215 a 289:
215:             THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
216:             loc_oCmg = THIS.cmg_4c_Botoes
217:             WITH loc_oCmg
218:                 .Top           = -2
219:                 .Left          = 462
220:                 .Width         = 160
221:                 .Height        = 85
222:                 .ButtonCount   = 2
223:                 .AutoSize      = .T.
224:                 .BackStyle     = 0
225:                 .BorderStyle   = 0
226:                 .SpecialEffect = 1
227:                 .BorderColor   = RGB(136, 189, 188)
228:                 .Themes        = .F.
229:                 .Value         = 0
230: 
231:                 WITH .Buttons(1)
232:                     .Top          = 5
233:                     .Left         = 80
234:                     .Width        = 75
235:                     .Height       = 75
236:                     .FontName     = "Comic Sans MS"
237:                     .FontSize     = 8
238:                     .FontBold     = .T.
239:                     .FontItalic   = .T.
240:                     .WordWrap     = .T.
241:                     .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
242:                     .Caption      = "Cancelar"
243:                     .Cancel       = .T.
244:                     .MousePointer = 15
245:                     .ToolTipText  = "[Esc] Encerrar"
246:                     .SpecialEffect = 0
247:                     .ForeColor    = RGB(90, 90, 90)
248:                     .BackColor    = RGB(255, 255, 255)
249:                     .Themes       = .F.
250:                 ENDWITH
251: 
252:                 WITH .Buttons(2)
253:                     .Top          = 5
254:                     .Left         = 5
255:                     .Width        = 75
256:                     .Height       = 75
257:                     .FontName     = "Comic Sans MS"
258:                     .FontSize     = 8
259:                     .FontBold     = .T.
260:                     .FontItalic   = .T.
261:                     .WordWrap     = .T.
262:                     .Picture      = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
263:                     .Caption      = "Confirmar"
264:                     .MousePointer = 15
265:                     .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
266:                     .ForeColor    = RGB(90, 90, 90)
267:                     .BackColor    = RGB(255, 255, 255)
268:                     .Themes       = .F.
269:                 ENDWITH
270:             ENDWITH
271:             BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnCancelarClick")
272:             BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnConfirmarClick")
273: 
274:             *-- Grade de atendimentos (Grade do legado) - cursor_4c_LocalVen
275:             *-- (placeholder ja criado em InicializarForm)
276:             THIS.AddObject("grd_4c_Dados", "Grid")
277:             loc_oGrd = THIS.grd_4c_Dados
278:             WITH loc_oGrd
279:                 .Top                = 96
280:                 .Left               = 50
281:                 .Width              = 463
282:                 .Height             = 234
283:                 .ColumnCount        = 3
284:                 .FontName           = "Verdana"
285:                 .FontSize           = 8
286:                 .HeaderHeight       = 22
287:                 .RowHeight          = 16
288:                 .ScrollBars         = 2
289:                 .ReadOnly           = .F.

*-- Linhas 304 a 312:
304:                 .Resizable = .F.
305:                 .ReadOnly  = .F.
306:             ENDWITH
307:             loc_oGrd.Column1.Header1.Caption   = "Vendedor"
308:             loc_oGrd.Column1.Header1.Alignment = 2
309:             WITH loc_oGrd.Column1.Text1
310:                 .FontName    = "Verdana"
311:                 .FontSize    = 8
312:                 .BorderStyle = 0

*-- Linhas 329 a 337:
329:                 .Width    = 250
330:                 .ReadOnly = .F.
331:             ENDWITH
332:             loc_oGrd.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
333:             loc_oGrd.Column2.Header1.Alignment = 2
334:             WITH loc_oGrd.Column2.Text1
335:                 .BorderStyle = 0
336:                 .InputMask   = ""
337:                 .Margin      = 0

*-- Linhas 346 a 474:
346:                 .Width    = 80
347:                 .ReadOnly = .F.
348:             ENDWITH
349:             loc_oGrd.Column3.Header1.Caption   = "Atendimentos"
350:             loc_oGrd.Column3.Header1.Alignment = 2
351:             WITH loc_oGrd.Column3.Text1
352:                 .BorderStyle = 0
353:                 .Format      = "999,999,999.99"
354:                 .InputMask   = "999"
355:                 .Margin      = 0
356:                 .ForeColor   = RGB(0, 0, 0)
357:                 .BackColor   = RGB(255, 255, 255)
358:             ENDWITH
359: 
360:             *-- RecordSource por ultimo (evita reset de Width/Header - regra
361:             *-- "Column.Width vai por ultimo")
362:             loc_oGrd.ColumnCount = 3
363:             loc_oGrd.RecordSource           = "cursor_4c_LocalVen"
364:             loc_oGrd.Column1.ControlSource  = "cursor_4c_LocalVen.CodVends"
365:             loc_oGrd.Column2.ControlSource  = "cursor_4c_LocalVen.DesVends"
366:             loc_oGrd.Column3.ControlSource  = "cursor_4c_LocalVen.NAtends"
367:             loc_oGrd.Column1.Header1.Caption = "Vendedor"
368:             loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
369:             loc_oGrd.Column3.Header1.Caption = "Atendimentos"
370:             loc_oGrd.Column1.Width           = 110
371:             loc_oGrd.Column2.Width           = 250
372:             loc_oGrd.Column3.Width           = 80
373:             *-- Gate do When legado da coluna Descricao: "Return EMPTY(
374:             *-- localven.codvends)". Column NAO tem DynamicReadOnly em VFP9,
375:             *-- entao o ReadOnly da coluna eh alternado por linha no
376:             *-- AfterRowColChange da grade - o proprio legado fecha o Init
377:             *-- chamando "ThisForm.Grade.AfterRowColChange()".
378:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeAfterRowColChange")
379:             THIS.AjustarColunaDescricao()
380: 
381:             BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "ValidarCodVenGrade")
382:             BINDEVENT(loc_oGrd.Column2.Text1, "KeyPress", THIS, "ValidarNomVenGrade")
383: 
384:             *-- Botoes standalone Incluir/Excluir - habilitados so em
385:             *-- INSERIR/ALTERAR, equivalente ao When legado
386:             *-- "Return(INLIST(Thisform.pcEscolha,'INSERIR','ALTERAR'))"
387:             THIS.AddObject("cmd_4c_Incluir", "CommandButton")
388:             WITH THIS.cmd_4c_Incluir
389:                 .Top             = 182
390:                 .Left = 5
391:                 .Width           = 45
392:                 .Height          = 45
393:                 .FontBold        = .T.
394:                 .FontName        = "Verdana"
395:                 .FontSize        = 8
396:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
397:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
398:                 .Caption         = ""
399:                 .ToolTipText     = "Inserir"
400:                 .ForeColor       = RGB(36, 84, 155)
401:                 .BackColor       = RGB(255, 255, 255)
402:                 .Themes          = .T.
403:                 .Enabled         = INLIST(THIS.this_cModoEscolha, "INSERIR", "ALTERAR")
404:             ENDWITH
405:             BINDEVENT(THIS.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
406: 
407:             THIS.AddObject("cmd_4c_Excluir", "CommandButton")
408:             WITH THIS.cmd_4c_Excluir
409:                 .Top             = 227
410:                 .Left = 230
411:                 .Width           = 45
412:                 .Height          = 45
413:                 .FontBold        = .T.
414:                 .FontName        = "Verdana"
415:                 .FontSize        = 8
416:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
417:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
418:                 .Caption         = ""
419:                 .ToolTipText     = "Excluir"
420:                 .ForeColor       = RGB(36, 84, 155)
421:                 .BackColor       = RGB(255, 255, 255)
422:                 .Themes          = .T.
423:                 .Enabled         = INLIST(THIS.this_cModoEscolha, "INSERIR", "ALTERAR")
424:             ENDWITH
425:             BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
426: 
427:         CATCH TO loc_oErro
428:             MsgErro(loc_oErro.Message + CHR(13) + ;
429:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
430:                 "Procedure: " + loc_oErro.Procedure, "FormSigMvAte.ConfigurarPaginaLista")
431:         ENDTRY
432:     ENDPROC
433: 
434:     *--------------------------------------------------------------------------
435:     * CarregarLista - (Re)carrega os atendimentos ja gravados do documento no
436:     * cursor_4c_LocalVen via BO e rebinda a grade (o BO fecha/recria o
437:     * cursor, entao RecordSource/ControlSource/Header/Width precisam ser
438:     * reaplicados - "Column.Width vai por ultimo").
439:     *--------------------------------------------------------------------------
440:     PROCEDURE CarregarLista()
441:         LOCAL loc_lOk, loc_oErro
442:         loc_lOk = .F.
443: 
444:         TRY
445:             loc_lOk = THIS.this_oBusinessObject.CarregarAtendimentosDocumento( ;
446:                 THIS.this_cEmpDopNums, THIS.this_cGrVends)
447: 
448:             IF loc_lOk AND USED("cursor_4c_LocalVen") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
449:                 THIS.grd_4c_Dados.RecordSource            = "cursor_4c_LocalVen"
450:                 THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_LocalVen.CodVends"
451:                 THIS.grd_4c_Dados.Column2.ControlSource   = "cursor_4c_LocalVen.DesVends"
452:                 THIS.grd_4c_Dados.Column3.ControlSource   = "cursor_4c_LocalVen.NAtends"
453:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "Vendedor"
454:                 THIS.grd_4c_Dados.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
455:                 THIS.grd_4c_Dados.Column3.Header1.Caption = "Atendimentos"
456:                 THIS.grd_4c_Dados.Column1.Width           = 110
457:                 THIS.grd_4c_Dados.Column2.Width           = 250
458:                 THIS.grd_4c_Dados.Column3.Width           = 80
459:                 SELECT cursor_4c_LocalVen
460:                 GO TOP
461:                 THIS.grd_4c_Dados.Refresh()
462: 
463:                 *-- Gate do When legado da coluna Descricao (Column nao tem
464:                 *-- DynamicReadOnly em VFP9) - reaplicado para a linha corrente
465:                 *-- apos o rebind, como o Init legado faz ao chamar
466:                 *-- "ThisForm.Grade.AfterRowColChange()" depois do GO TOP
467:                 THIS.AjustarColunaDescricao()
468:             ENDIF
469:         CATCH TO loc_oErro
470:             MsgErro(loc_oErro.Message + CHR(13) + ;
471:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
472:                 "Procedure: " + loc_oErro.Procedure, "FormSigMvAte.CarregarLista")
473:         ENDTRY
474: 

*-- Linhas 508 a 530:
508:             RETURN
509:         ENDIF
510: 
511:         loc_lCodigoPreenchido = .F.
512: 
513:         IF USED("cursor_4c_LocalVen")
514:             IF RECCOUNT("cursor_4c_LocalVen") > 0 AND !EOF("cursor_4c_LocalVen")
515:                 loc_lCodigoPreenchido = !EMPTY(ALLTRIM(NVL(cursor_4c_LocalVen.CodVends, "")))
516:             ENDIF
517:         ENDIF
518: 
519:         THIS.grd_4c_Dados.Column2.ReadOnly = loc_lCodigoPreenchido
520:     ENDPROC
521: 
522:     *--------------------------------------------------------------------------
523:     * ValidarCodVenGrade - KeyPress na coluna Vendedor (Column1) da grade.
524:     * Enter/Tab: busca exata do vendedor no grupo do documento - achou,
525:     * preenche a descricao; nao achou, abre o picker filtrado pelo grupo.
526:     * F4: abre o picker direto.
527:     * Sempre reverifica duplicidade (equivale ao PROCEDURE Valid de
528:     * SIGMVATE.Grade.Column2.Text1, que usa fAcessoContas modo 'C' -
529:     * PROIBIDO reusar fAcessoContas como lookup UX, ver licoes aprendidas).
530:     *--------------------------------------------------------------------------

*-- Linhas 538 a 576:
538: 
539:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
540:             RETURN
541:         ENDIF
542: 
543:         IF !USED("cursor_4c_LocalVen")
544:             RETURN
545:         ENDIF
546: 
547:         loc_cVal = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
548: 
549:         SELECT cursor_4c_LocalVen
550: 
551:         IF EMPTY(loc_cVal)
552:             REPLACE CodVends WITH "", DesVends WITH ""
553:             THIS.grd_4c_Dados.Refresh()
554:             RETURN
555:         ENDIF
556: 
557:         REPLACE CodVends WITH loc_cVal
558: 
559:         IF THIS.VerificarVendedorDuplicado()
560:             MsgAviso("Vendedor j" + CHR(225) + " inclu" + CHR(237) + "do!", "Aviso")
561:             SELECT cursor_4c_LocalVen
562:             REPLACE CodVends WITH "", DesVends WITH ""
563:             THIS.grd_4c_Dados.Refresh()
564:             RETURN
565:         ENDIF
566: 
567:         loc_cDesc = THIS.this_oBusinessObject.ObterDescricaoVendedor(THIS.this_cGrVends, loc_cVal)
568: 
569:         IF EMPTY(loc_cDesc)
570:             THIS.AbrirBuscaVenGrade()
571:         ELSE
572:             *-- Linha corrente -> BO (FormParaBO preserva o NAtends ja digitado),
573:             *-- aplica o vendedor resolvido e devolve BO -> linha corrente
574:             IF THIS.FormParaBO()
575:                 THIS.this_oBusinessObject.this_cCodVends  = loc_cVal
576:                 THIS.this_oBusinessObject.this_cDescVends = loc_cDesc

*-- Linhas 596 a 623:
596: 
597:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
598:             RETURN
599:         ENDIF
600: 
601:         IF !USED("cursor_4c_LocalVen")
602:             RETURN
603:         ENDIF
604: 
605:         loc_cVal = ALLTRIM(THIS.grd_4c_Dados.Column2.Text1.Value)
606: 
607:         IF EMPTY(loc_cVal)
608:             SELECT cursor_4c_LocalVen
609:             REPLACE CodVends WITH "", DesVends WITH ""
610:             THIS.grd_4c_Dados.Refresh()
611:             RETURN
612:         ENDIF
613: 
614:         IF USED("cursor_4c_VenNomTemp")
615:             USE IN cursor_4c_VenNomTemp
616:         ENDIF
617: 
618:         TRY
619:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
620:                 SELECT TOP 1 iclis, rclis FROM SigCdCli
621:                 WHERE grupos = <<EscaparSQL(THIS.this_cGrVends)>>
622:                   AND RTRIM(rclis) = <<EscaparSQL(loc_cVal)>>
623:             ENDTEXT

*-- Linhas 632 a 656:
632:                     THIS.this_oBusinessObject.this_cCodVends  = ALLTRIM(cursor_4c_VenNomTemp.iclis)
633:                     THIS.this_oBusinessObject.this_cDescVends = ALLTRIM(cursor_4c_VenNomTemp.rclis)
634:                     THIS.BOParaForm()
635:                 ENDIF
636: 
637:                 SELECT cursor_4c_LocalVen
638: 
639:                 IF THIS.VerificarVendedorDuplicado()
640:                     MsgAviso("Vendedor j" + CHR(225) + " inclu" + CHR(237) + "do!", "Aviso")
641:                     SELECT cursor_4c_LocalVen
642:                     REPLACE CodVends WITH "", DesVends WITH ""
643:                 ENDIF
644:                 THIS.grd_4c_Dados.Refresh()
645:             ELSE
646:                 THIS.AbrirBuscaVenGrade()
647:             ENDIF
648: 
649:             IF USED("cursor_4c_VenNomTemp")
650:                 USE IN cursor_4c_VenNomTemp
651:             ENDIF
652:         CATCH TO loc_oErro
653:             MsgErro(loc_oErro.Message, "Erro")
654:         ENDTRY
655:     ENDPROC
656: 

*-- Linhas 663 a 683:
663:     *--------------------------------------------------------------------------
664:     PROCEDURE AbrirBuscaVenGrade()
665:         LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResultado, loc_cTitulo, ;
666:               loc_lProsseguir, loc_cCodSel, loc_cDescSel, loc_oErro
667: 
668:         IF !USED("cursor_4c_LocalVen")
669:             RETURN
670:         ENDIF
671: 
672:         loc_cValor = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
673:         IF EMPTY(loc_cValor)
674:             loc_cValor = ALLTRIM(THIS.grd_4c_Dados.Column2.Text1.Value)
675:         ENDIF
676: 
677:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Vendedor"
678: 
679:         IF USED("cursor_4c_BuscaVenGrade")
680:             USE IN cursor_4c_BuscaVenGrade
681:         ENDIF
682: 
683:         loc_lProsseguir = .T.

*-- Linhas 714 a 828:
714:                 IF VARTYPE(loc_oBusca) = "O"
715:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaVenGrade"
716:                     loc_oBusca.this_cTitulo        = loc_cTitulo
717:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
718:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
719:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
720:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
721:                     loc_oBusca.Show()
722: 
723:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVenGrade") AND USED("cursor_4c_LocalVen")
724:                         SELECT cursor_4c_BuscaVenGrade
725:                         loc_cCodSel  = ALLTRIM(cursor_4c_BuscaVenGrade.iclis)
726:                         loc_cDescSel = ALLTRIM(cursor_4c_BuscaVenGrade.rclis)
727: 
728:                         *-- Linha corrente -> BO (FormParaBO preserva o NAtends
729:                         *-- ja digitado), aplica o vendedor escolhido no picker
730:                         *-- e devolve BO -> linha corrente
731:                         IF THIS.FormParaBO()
732:                             THIS.this_oBusinessObject.this_cCodVends  = loc_cCodSel
733:                             THIS.this_oBusinessObject.this_cDescVends = loc_cDescSel
734:                             THIS.BOParaForm()
735:                         ENDIF
736: 
737:                         SELECT cursor_4c_LocalVen
738: 
739:                         IF THIS.VerificarVendedorDuplicado()
740:                             MsgAviso("Vendedor j" + CHR(225) + " inclu" + CHR(237) + "do!", "Aviso")
741:                             REPLACE CodVends WITH "", DesVends WITH ""
742:                         ENDIF
743:                     ENDIF
744:                     loc_oBusca.Release()
745:                 ENDIF
746:             ENDIF
747:         CATCH TO loc_oErro
748:             MsgErro(loc_oErro.Message, "Erro")
749:         ENDTRY
750: 
751:         IF USED("cursor_4c_BuscaVenGrade")
752:             USE IN cursor_4c_BuscaVenGrade
753:         ENDIF
754:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
755:             THIS.grd_4c_Dados.Refresh()
756:         ENDIF
757:     ENDPROC
758: 
759:     *--------------------------------------------------------------------------
760:     * VerificarVendedorDuplicado - Verifica se o vendedor da linha corrente
761:     * do cursor_4c_LocalVen ja foi incluido em outra linha da grade
762:     * (equivale a "LOCATE for codvends = lcCodven and RECNO() <> lnReg"
763:     * do legado, repetido ao final dos dois PROCEDURE Valid).
764:     *--------------------------------------------------------------------------
765:     PROCEDURE VerificarVendedorDuplicado()
766:         LOCAL loc_nRecAtual, loc_cCodVen, loc_lDuplicado
767: 
768:         loc_lDuplicado = .F.
769: 
770:         IF !USED("cursor_4c_LocalVen")
771:             RETURN loc_lDuplicado
772:         ENDIF
773: 
774:         SELECT cursor_4c_LocalVen
775:         loc_nRecAtual = RECNO()
776:         loc_cCodVen   = ALLTRIM(CodVends)
777: 
778:         IF !EMPTY(loc_cCodVen)
779:             LOCATE FOR ALLTRIM(CodVends) == loc_cCodVen AND RECNO() != loc_nRecAtual
780:             loc_lDuplicado = FOUND()
781:         ENDIF
782: 
783:         IF BETWEEN(loc_nRecAtual, 1, RECCOUNT("cursor_4c_LocalVen"))
784:             GO loc_nRecAtual IN cursor_4c_LocalVen
785:         ENDIF
786: 
787:         RETURN loc_lDuplicado
788:     ENDPROC
789: 
790:     *--------------------------------------------------------------------------
791:     * BtnIncluirClick - Adiciona uma linha vazia na grade e posiciona o foco
792:     * no campo do vendedor (equivale ao PROCEDURE Click de SIGMVATE.inserir)
793:     *--------------------------------------------------------------------------
794:     PROCEDURE BtnIncluirClick()
795:         LOCAL loc_oErro
796: 
797:         IF !USED("cursor_4c_LocalVen")
798:             RETURN
799:         ENDIF
800: 
801:         *-- Mesmo gate do When de SIGMVATE.inserir. O botao ja nasce
802:         *-- desabilitado fora de INSERIR/ALTERAR; a checagem aqui protege as
803:         *-- chamadas por codigo (BINDEVENT/harness).
804:         IF !THIS.PodeEditarDocumento()
805:             MsgAviso("Documento em modo consulta - n" + CHR(227) + "o " + CHR(233) + ;
806:                 " poss" + CHR(237) + "vel incluir atendimentos.", "Atendimentos")
807:             RETURN
808:         ENDIF
809: 
810:         TRY
811:             THIS.LockScreen = .T.
812: 
813:             SELECT cursor_4c_LocalVen
814:             LOCATE FOR EMPTY(ALLTRIM(CodVends))
815:             IF !FOUND()
816:                 APPEND BLANK
817:             ENDIF
818: 
819:             REPLACE CodVends WITH "", DesVends WITH "", NAtends WITH 0
820: 
821:             THIS.grd_4c_Dados.Refresh()
822: 
823:             *-- Entra em edicao na linha recem-criada. Como CodVends esta
824:             *-- vazio, BtnAlterarClick posiciona o foco na coluna do codigo
825:             *-- do vendedor - o mesmo "Thisform.grade.column2.SetFocus" que o
826:             *-- legado executa (Column2 do legado = Column1 aqui).
827:             THIS.BtnAlterarClick()
828: 

*-- Linhas 840 a 878:
840:     * PROCEDURE Click de SIGMVATE.excluir)
841:     *--------------------------------------------------------------------------
842:     PROCEDURE BtnExcluirClick()
843:         LOCAL loc_oErro
844: 
845:         IF !USED("cursor_4c_LocalVen")
846:             RETURN
847:         ENDIF
848: 
849:         IF !THIS.LinhaCorrenteValida()
850:             RETURN
851:         ENDIF
852: 
853:         *-- Mesmo gate do When de SIGMVATE.excluir (ver BtnIncluirClick)
854:         IF !THIS.PodeEditarDocumento()
855:             MsgAviso("Documento em modo consulta - n" + CHR(227) + "o " + CHR(233) + ;
856:                 " poss" + CHR(237) + "vel excluir atendimentos.", "Atendimentos")
857:             RETURN
858:         ENDIF
859: 
860:         TRY
861:             THIS.LockScreen = .T.
862: 
863:             SELECT cursor_4c_LocalVen
864:             DELETE
865: 
866:             THIS.grd_4c_Dados.Refresh()
867: 
868:             THIS.LockScreen = .F.
869:         CATCH TO loc_oErro
870:             THIS.LockScreen = .F.
871:             MsgErro(loc_oErro.Message + CHR(13) + ;
872:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
873:                 "Procedure: " + loc_oErro.Procedure, "FormSigMvAte.BtnExcluirClick")
874:         ENDTRY
875:     ENDPROC
876: 
877:     *--------------------------------------------------------------------------
878:     * PodeEditarDocumento - Reproduz o When dos botoes inserir/excluir do

*-- Linhas 885 a 915:
885:         RETURN INLIST(THIS.this_cModoEscolha, "INSERIR", "ALTERAR")
886:     ENDPROC
887: 
888:     *--------------------------------------------------------------------------
889:     * LinhaCorrenteValida - Garante que ha uma linha posicionada no
890:     * cursor_4c_LocalVen (equivale ao "If Eof() Or Bof() / Return" que o
891:     * legado repete no Click de excluir).
892:     *--------------------------------------------------------------------------
893:     PROCEDURE LinhaCorrenteValida()
894:         LOCAL loc_lOk
895: 
896:         loc_lOk = .F.
897: 
898:         IF USED("cursor_4c_LocalVen")
899:             SELECT cursor_4c_LocalVen
900:             loc_lOk = (RECCOUNT("cursor_4c_LocalVen") > 0 AND !EOF() AND !BOF())
901:         ENDIF
902: 
903:         RETURN loc_lOk
904:     ENDPROC
905: 
906:     *--------------------------------------------------------------------------
907:     * BtnAlterarClick - Entra em edicao na linha corrente da grade.
908:     *
909:     * SIGMVATE nao tem botao "Alterar": a alteracao acontece digitando direto
910:     * na grade, e quem autoriza eh o par de regras do legado - o When de
911:     * inserir/excluir (INLIST(pcEscolha,'INSERIR','ALTERAR')) somado ao When da
912:     * coluna Descricao (RETURN EMPTY(localven.codvends)). Este metodo concentra
913:     * essas duas regras: valida a linha, aplica o mesmo gate e devolve o foco a
914:     * celula que o legado deixa editavel para a linha corrente - Codigo quando o
915:     * vendedor ainda nao foi informado (Descricao tambem fica liberada pelo

*-- Linhas 936 a 1011:
936:         ENDIF
937: 
938:         TRY
939:             THIS.grd_4c_Dados.SetFocus()
940: 
941:             IF EMPTY(ALLTRIM(NVL(cursor_4c_LocalVen.CodVends, "")))
942:                 *-- Vendedor em branco: legado libera Codigo e Descricao
943:                 THIS.grd_4c_Dados.Column1.SetFocus()
944:             ELSE
945:                 *-- Vendedor preenchido: DynamicReadOnly trava a Descricao,
946:                 *-- resta a quantidade de atendimentos
947:                 THIS.grd_4c_Dados.Column3.SetFocus()
948:             ENDIF
949: 
950:             loc_lOk = .T.
951:         CATCH TO loc_oErro
952:             MsgErro(loc_oErro.Message + CHR(13) + ;
953:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
954:                 "Procedure: " + loc_oErro.Procedure, "FormSigMvAte.BtnAlterarClick")
955:         ENDTRY
956: 
957:         RETURN loc_lOk
958:     ENDPROC
959: 
960:     *--------------------------------------------------------------------------
961:     * BtnVisualizarClick - Exibe os atendimentos como estao GRAVADOS para o
962:     * documento (somente leitura): recarrega cursor_4c_LocalVen a partir de
963:     * SigMvAte via BO, que tambem reresolve a descricao de cada vendedor em
964:     * SigCdCli pelo grupo do documento - exatamente a consulta que o Init do
965:     * legado roda linha a linha no SCAN ("Select rclis From SigCdCli where
966:     * grupos = <grvends> and iclis = <codvends>").
967:     *
968:     * Nao grava nada e nao depende do modo do documento (serve em CONSULTAR).
969:     * Como recarregar descarta o que ainda nao foi confirmado, pede confirmacao
970:     * quando o documento esta editavel e a grade ja tem linhas.
971:     *
972:     * NAO cria botao proprio na tela (PILAR 1 - o legado nao tem): eh o ponto
973:     * de entrada programatico de consulta do form.
974:     *--------------------------------------------------------------------------
975:     PROCEDURE BtnVisualizarClick()
976:         LOCAL loc_lOk, loc_lProsseguir, loc_oErro
977: 
978:         loc_lOk         = .F.
979:         loc_lProsseguir = .T.
980: 
981:         IF THIS.PodeEditarDocumento() AND USED("cursor_4c_LocalVen") ;
982:                 AND RECCOUNT("cursor_4c_LocalVen") > 0
983:             loc_lProsseguir = MsgConfirma("Exibir os atendimentos como est" + CHR(227) + "o gravados?" + ;
984:                 CHR(13) + "As altera" + CHR(231) + CHR(245) + "es ainda n" + CHR(227) + "o confirmadas " + ;
985:                 "ser" + CHR(227) + "o perdidas.", "Atendimentos")
986:         ENDIF
987: 
988:         IF !loc_lProsseguir
989:             RETURN loc_lOk
990:         ENDIF
991: 
992:         TRY
993:             loc_lOk = THIS.CarregarLista()
994: 
995:             IF loc_lOk
996:                 IF USED("cursor_4c_LocalVen") AND RECCOUNT("cursor_4c_LocalVen") = 0
997:                     MsgInfo("Nenhum atendimento gravado para este documento.", "Atendimentos")
998:                 ENDIF
999:             ELSE
1000:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar os atendimentos " + ;
1001:                     "gravados deste documento.", "Atendimentos")
1002:             ENDIF
1003:         CATCH TO loc_oErro
1004:             loc_lOk = .F.
1005:             MsgErro(loc_oErro.Message + CHR(13) + ;
1006:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1007:                 "Procedure: " + loc_oErro.Procedure, "FormSigMvAte.BtnVisualizarClick")
1008:         ENDTRY
1009: 
1010:         RETURN loc_lOk
1011:     ENDPROC

*-- Linhas 1019 a 1054:
1019:     * (nome do botao do legado, alvo do BINDEVENT) delega para ca.
1020:     *--------------------------------------------------------------------------
1021:     PROCEDURE BtnSalvarClick()
1022:         LOCAL loc_lSucesso, loc_oErro
1023: 
1024:         IF !USED("cursor_4c_LocalVen")
1025:             THIS.Release()
1026:             RETURN
1027:         ENDIF
1028: 
1029:         loc_lSucesso = .F.
1030: 
1031:         TRY
1032:             SELECT cursor_4c_LocalVen
1033:             GO TOP
1034:             THIS.grd_4c_Dados.Refresh()
1035: 
1036:             loc_lSucesso = THIS.this_oBusinessObject.ExcluirTodosDoDocumento(THIS.this_cEmpDopNums)
1037: 
1038:             IF loc_lSucesso
1039:                 SELECT cursor_4c_LocalVen
1040:                 *-- "DELETE ALL for natends = 0" do legado: as linhas zeradas
1041:                 *-- nao sao reinseridas
1042:                 SCAN FOR NAtends != 0
1043:                     *-- NovoRegistro() antes do mapeamento: LimparDados() zera
1044:                     *-- this_cPkChaves, senao o 2o INSERT do laco colidiria no
1045:                     *-- indice unico com a PK da linha anterior
1046:                     THIS.this_oBusinessObject.NovoRegistro()
1047: 
1048:                     IF !THIS.FormParaBO()
1049:                         LOOP
1050:                     ENDIF
1051: 
1052:                     IF !THIS.this_oBusinessObject.Salvar()
1053:                         loc_lSucesso = .F.
1054:                         EXIT

*-- Linhas 1094 a 1114:
1094:     PROCEDURE BtnEncerrarClick()
1095:         THIS.BtnCancelarClick()
1096:     ENDPROC
1097: 
1098:     *--------------------------------------------------------------------------
1099:     * FormParaBO - Transfere a LINHA CORRENTE da grade (cursor_4c_LocalVen)
1100:     * mais o contexto do documento pai para as propriedades do BO.
1101:     *
1102:     * SIGMVATE eh OPERACIONAL flat: a "ficha" editavel nao sao TextBoxes numa
1103:     * Page2, sao as COLUNAS da grade - uma linha da grade equivale a um
1104:     * registro de SigMvAte. Por isso o mapeamento eh feito por linha.
1105:     *
1106:     * Cobre TODAS as colunas persistidas pelo BO:
1107:     *   CodVends -> this_cCodVends   (codvends   char(10))
1108:     *   NAtends  -> this_nAtends     (natends    numeric(4,0))
1109:     * mais as duas colunas que vem do documento pai (nao tem campo na tela,
1110:     * mas SAO gravadas - SigMvAte.emps/empdopnums sao NOT NULL):
1111:     *   this_cEmps       = empresa do SigMvCab
1112:     *   this_cEmpDopNums = chave do documento pai
1113:     * e as duas de apoio (nao persistidas, usadas nos lookups):
1114:     *   DesVends -> this_cDescVends, this_cGrVends = grupo de vendedores

*-- Linhas 1121 a 1193:
1121:     *--------------------------------------------------------------------------
1122:     PROTECTED PROCEDURE FormParaBO()
1123:         LOCAL loc_lOk
1124:         loc_lOk = .F.
1125: 
1126:         IF USED("cursor_4c_LocalVen") AND VARTYPE(THIS.this_oBusinessObject) = "O"
1127:             SELECT cursor_4c_LocalVen
1128: 
1129:             IF RECCOUNT("cursor_4c_LocalVen") > 0 AND ;
1130:                !EOF("cursor_4c_LocalVen") AND !BOF("cursor_4c_LocalVen")
1131: 
1132:                 *-- Colunas da linha corrente da grade
1133:                 THIS.this_oBusinessObject.this_cCodVends  = ALLTRIM(NVL(cursor_4c_LocalVen.CodVends, ""))
1134:                 THIS.this_oBusinessObject.this_cDescVends = ALLTRIM(NVL(cursor_4c_LocalVen.DesVends, ""))
1135:                 THIS.this_oBusinessObject.this_nAtends    = NVL(cursor_4c_LocalVen.NAtends, 0)
1136: 
1137:                 *-- Contexto do documento pai (SigMvCab), recebido no Init
1138:                 THIS.this_oBusinessObject.this_cEmps       = THIS.this_cEmps
1139:                 THIS.this_oBusinessObject.this_cEmpDopNums = THIS.this_cEmpDopNums
1140:                 THIS.this_oBusinessObject.this_cGrVends    = THIS.this_cGrVends
1141: 
1142:                 loc_lOk = .T.
1143:             ENDIF
1144:         ENDIF
1145: 
1146:         RETURN loc_lOk
1147:     ENDPROC
1148: 
1149:     *--------------------------------------------------------------------------
1150:     * BOParaForm - Caminho inverso de FormParaBO: escreve as propriedades do
1151:     * BO de volta na LINHA CORRENTE da grade (cursor_4c_LocalVen) e repinta a
1152:     * grade (popular/alterar cursor nao repinta a grade sozinho).
1153:     *
1154:     * Usado pelos tres caminhos de lookup de vendedor (Enter/Tab pelo codigo,
1155:     * Enter/Tab pela razao social e selecao no picker): o handler carrega a
1156:     * linha no BO com FormParaBO (o que PRESERVA o NAtends ja digitado),
1157:     * aplica o vendedor resolvido nas propriedades e devolve tudo a grade
1158:     * por aqui.
1159:     *
1160:     * As colunas de contexto (emps/empdopnums) nao voltam para a grade porque
1161:     * nao existem nela - sao do documento pai e vivem so no form/BO.
1162:     *
1163:     * Retorna .F. quando nao ha linha corrente utilizavel.
1164:     *--------------------------------------------------------------------------
1165:     PROTECTED PROCEDURE BOParaForm()
1166:         LOCAL loc_lOk
1167:         loc_lOk = .F.
1168: 
1169:         IF USED("cursor_4c_LocalVen") AND VARTYPE(THIS.this_oBusinessObject) = "O"
1170:             SELECT cursor_4c_LocalVen
1171: 
1172:             IF RECCOUNT("cursor_4c_LocalVen") > 0 AND ;
1173:                !EOF("cursor_4c_LocalVen") AND !BOF("cursor_4c_LocalVen")
1174: 
1175:                 REPLACE CodVends WITH THIS.this_oBusinessObject.this_cCodVends, ;
1176:                         DesVends WITH THIS.this_oBusinessObject.this_cDescVends, ;
1177:                         NAtends  WITH THIS.this_oBusinessObject.this_nAtends ;
1178:                     IN cursor_4c_LocalVen
1179: 
1180:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1181:                     THIS.grd_4c_Dados.Refresh()
1182:                 ENDIF
1183: 
1184:                 *-- Reaplica o When da coluna Descricao para a linha alterada
1185:                 *-- (com o codigo preenchido ela volta a ser somente leitura)
1186:                 THIS.AjustarColunaDescricao()
1187: 
1188:                 loc_lOk = .T.
1189:             ENDIF
1190:         ENDIF
1191: 
1192:         RETURN loc_lOk
1193:     ENDPROC

*-- Linhas 1245 a 1257:
1245:     * do PROCEDURE Release do legado). DODEFAULT() por ultimo: FormBase.Destroy
1246:     * restaura os popups do menu principal apos fechar form modal - sem isso
1247:     * por ultimo, o rendering dos popups fica corrompido (CLAUDE.md).
1248:     *--------------------------------------------------------------------------
1249:     PROCEDURE Destroy()
1250:         IF USED("cursor_4c_LocalVen")
1251:             USE IN cursor_4c_LocalVen
1252:         ENDIF
1253: 
1254:         DODEFAULT()
1255:     ENDPROC
1256: 
1257: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigMvAteBO.prg):
*====================================================================
* SigMvAteBO.prg
*
* Business Object para Atendimentos de Vendedores por Documento
* Tabela: SigMvAte
* Herda de: BusinessBase
*
* Form OPERACIONAL chamado a partir de um documento de movimento
* (SigMvCab): permite escolher, na grade, os vendedores que
* atenderam o pedido/documento e quantos atendimentos cada um teve.
* Ao Confirmar, o legado apaga os registros de SigMvAte do documento
* (empdopnums) e reinsere as linhas atuais da grade.
*====================================================================

DEFINE CLASS SigMvAteBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvAte)
    this_cCodVends   = ""    && codvends   char(10) - codigo do vendedor
    this_cEmps       = ""    && emps       char(3)  - empresa do documento
    this_cEmpDopNums = ""    && empdopnums char(29) - chave do documento pai (SigMvCab)
    this_nAtends     = 0     && natends    numeric(4,0) - quantidade de atendimentos
    this_cPkChaves   = ""    && pkchaves   char(20) - PK

    *-- Propriedade de exibicao (NAO persistida - descricao do vendedor,
    *-- obtida via lookup em SigCdCli.rclis Where grupos = this_cGrVends
    *-- and iclis = this_cCodVends)
    this_cDescVends  = ""

    *-- Contexto do documento pai (TprMvCab no legado), necessario para
    *-- filtrar/validar os vendedores deste documento nas proximas fases
    this_cGrVends    = ""    && grvends do SigMvCab - grupo de vendedores aceito

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvAte"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigMvAteBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - Reseta as propriedades da entidade
    * (chamado por NovoRegistro() antes de cada Inserir() do laco de
    * Confirmar - sem isso this_cPkChaves manteria o valor da linha
    * anterior e o segundo INSERT colidiria no indice unico)
    *====================================================================
    PROCEDURE LimparDados()
        THIS.this_cCodVends   = ""
        THIS.this_cEmps       = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_nAtends     = 0
        THIS.this_cPkChaves   = ""
        THIS.this_cDescVends  = ""
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    * (usado ao percorrer a grade local de atendimentos - ver Formcomp.
    * cursor tipico: crSigMvAte, populado via SELECT * FROM SigMvAte)
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodVends   = TratarNulo(codvends,   "C")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_nAtends     = TratarNulo(natends,    "N")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigMvAteBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * Inserir - Grava novo atendimento de vendedor para o documento
    * (equivale ao INSERT INTO crSigmvAte (...) do legado, feito para
    * cada linha da grade nao-zerada ao Confirmar; gera pkchaves novo)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigMvAte (codvends, emps, empdopnums, natends, pkchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodVends)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<FormatarNumeroSQL(THIS.this_nAtends, 0)>>,
                    <<EscaparSQL(THIS.this_cPkChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir atendimento de vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigMvAteBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza a quantidade de atendimentos do vendedor
    * para o documento (o legado nunca faz UPDATE de linha - apaga e
    * reinsere a grade inteira -, mas o metodo eh mantido para permitir
    * corrigir uma linha isolada sem afetar as demais do documento)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigMvAte
                SET codvends   = <<EscaparSQL(THIS.this_cCodVends)>>,
                    emps       = <<EscaparSQL(THIS.this_cEmps)>>,
                    empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    natends    = <<FormatarNumeroSQL(THIS.this_nAtends, 0)>>
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar atendimento de vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigMvAteBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui o atendimento do vendedor pela pkchaves
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigMvAte
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir atendimento de vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigMvAteBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirTodosDoDocumento - Apaga TODOS os atendimentos ja gravados
    * para o documento (empdopnums), replicando o
    * "Delete all for empdopnums = pcEDN" do legado antes de reinserir
    * a grade atual ao Confirmar (ver FormSigMvAte.BtnConfirmarClick)
    *====================================================================
    PROCEDURE ExcluirTodosDoDocumento(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigMvAte
                WHERE empdopnums = <<EscaparSQL(par_cEmpDopNums)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir atendimentos do documento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir atendimentos do documento:" + CHR(13) + loException.Message, "SigMvAteBO.ExcluirTodosDoDocumento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarAtendimentosDocumento - Popula cursor_4c_LocalVen (cursor
    * local, editavel) com os vendedores ja gravados em SigMvAte para o
    * documento informado, buscando a descricao (Rclis) de cada vendedor
    * em SigCdCli filtrado pelo grupo de vendedores do documento.
    * Equivale ao trecho do Init do legado:
    *   SELECT codvends, SPACE(40) as desVends, nAtends FROM crSigmvate
    *   INTO CURSOR LocalVen READWRITE
    *   SCAN
    *       (busca RClis em SigCdCli where grupos=... and iclis=...)
    *   ENDSCAN
    * IMPORTANTE: a ordem dos campos do CREATE CURSOR abaixo tem de ser
    * IDENTICA ao cursor placeholder criado em
    * FormSigMvAte.InicializarForm (CodVends, DesVends, NAtends).
    *====================================================================
    PROCEDURE CarregarAtendimentosDocumento(par_cEmpDopNums, par_cGrVends)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cDesc

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_AtendTemp")
                USE IN cursor_4c_AtendTemp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT codvends, natends FROM SigMvAte
                WHERE empdopnums = <<EscaparSQL(par_cEmpDopNums)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AtendTemp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_LocalVen")
                    USE IN cursor_4c_LocalVen
                ENDIF
                CREATE CURSOR cursor_4c_LocalVen ;
                    (CodVends C(10), DesVends C(40), NAtends N(4,0))

                IF USED("cursor_4c_AtendTemp")
                    SELECT cursor_4c_AtendTemp
                    GO TOP
                    SCAN
                        loc_cDesc = THIS.ObterDescricaoVendedor(par_cGrVends, ;
                            TratarNulo(cursor_4c_AtendTemp.codvends, "C"))

                        INSERT INTO cursor_4c_LocalVen (CodVends, DesVends, NAtends) ;
                            VALUES (TratarNulo(cursor_4c_AtendTemp.codvends, "C"), ;
                                    loc_cDesc, ;
                                    TratarNulo(cursor_4c_AtendTemp.natends, "N"))
                    ENDSCAN
                    USE IN cursor_4c_AtendTemp
                ENDIF

                SELECT cursor_4c_LocalVen
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar atendimentos do documento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar atendimentos:" + CHR(13) + loException.Message, "SigMvAteBO.CarregarAtendimentosDocumento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterDescricaoVendedor - Busca a razao social (Rclis) do vendedor
    * em SigCdCli, filtrando pelo grupo de vendedores do documento
    * (equivale a SqlExecute("Select rclis From SigCdCli where grupos =
    * ... and iclis = ...") do legado). Retorna "" se nao encontrado -
    * PUBLIC porque o Form chama para revalidar codigos digitados na grade.
    *====================================================================
    PROCEDURE ObterDescricaoVendedor(par_cGrVends, par_cCodVends)
        LOCAL loc_cSQL, loc_nResultado, loc_cRetorno

        loc_cRetorno = ""

        IF EMPTY(par_cCodVends)
            RETURN loc_cRetorno
        ENDIF

        TRY
            IF USED("cursor_4c_VenTemp")
                USE IN cursor_4c_VenTemp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT rclis FROM SigCdCli
                WHERE grupos = <<EscaparSQL(par_cGrVends)>>
                  AND iclis  = <<EscaparSQL(par_cCodVends)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VenTemp")

            IF loc_nResultado > 0 AND USED("cursor_4c_VenTemp") AND RECCOUNT("cursor_4c_VenTemp") > 0
                loc_cRetorno = TratarNulo(cursor_4c_VenTemp.rclis, "C")
            ENDIF

            IF USED("cursor_4c_VenTemp")
                USE IN cursor_4c_VenTemp
            ENDIF
        CATCH TO loException
            loc_cRetorno = ""
        ENDTRY

        RETURN loc_cRetorno
    ENDPROC

ENDDEFINE

