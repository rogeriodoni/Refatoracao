# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Dados' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_DadosTemp'), depois ZAP + APPEND FROM DBF() no cursor original.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSEG.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (985 linhas total):

*-- Linhas 48 a 57:
48:                     "FormSEG.InicializarForm")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Visible = .T.
54:                 THIS.pgf_4c_Paginas.ActivePage = 1
55:                 THIS.this_cModoAtual = "LISTA"
56: 
57:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 80 a 99:
80: 
81:         WITH THIS.pgf_4c_Paginas
82:             .PageCount = 2
83:             .Top       = -29
84:             .Left      = 0
85:             .Width     = THIS.Width
86:             .Height    = THIS.Height + 29
87:             .Tabs      = .F.
88:             .Visible   = .T.
89: 
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93: 
94:             .Page2.Caption   = "Dados"
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.BackColor = RGB(255, 255, 255)
97:         ENDWITH
98: 
99:         THIS.ConfigurarPaginaLista()

*-- Linhas 114 a 151:
114:         *-- Container Cabecalho (cntSombra no legado: Top=1, +29 compensacao)
115:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
116:         WITH loc_oPagina.cnt_4c_Cabecalho
117:             .Top         = 31
118:             .Left        = 0
119:             .Width       = THIS.Width
120:             .Height      = 80
121:             .BackColor   = RGB(100, 100, 100)
122:             .BorderWidth = 0
123:             .Visible     = .T.
124:         ENDWITH
125: 
126:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
127:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
128:             .Caption   = THIS.Caption
129:             .Top       = 15
130:             .Left      = 10
131:             .Width     = 769
132:             .Height    = 40
133:             .FontName  = "Tahoma"
134:             .FontSize  = 16
135:             .FontBold  = .T.
136:             .ForeColor = RGB(0, 0, 0)
137:             .BackStyle = 0
138:             .AutoSize  = .F.
139:             .Visible   = .T.
140:         ENDWITH
141: 
142:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
143:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
144:             .Caption   = THIS.Caption
145:             .Top       = 18
146:             .Left      = 10
147:             .Width     = 769
148:             .Height    = 46
149:             .FontName  = "Tahoma"
150:             .FontSize  = 16
151:             .FontBold  = .T.

*-- Linhas 159 a 183:
159:         *-- Com compensacao +29: Top=29
160:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
161:         WITH loc_oPagina.cnt_4c_Botoes
162:             .Top         = 29
163:             .Left        =  542
164:             .Width       = 390
165:             .Height      = 85
166:             .BackStyle   = 0
167:             .BorderWidth = 0
168:             .Visible     = .T.
169:         ENDWITH
170: 
171:         *-- Botao Incluir
172:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
173:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
174:             .Caption         = "Incluir"
175:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
176:             .PicturePosition = 13
177:             .Top             = 5
178:             .Left            = 5
179:             .Width           = 75
180:             .Height          = 75
181:             .FontName        = "Tahoma"
182:             .FontBold        = .T.
183:             .FontItalic      = .T.

*-- Linhas 191 a 208:
191:             .AutoSize        = .F.
192:             .Visible         = .T.
193:         ENDWITH
194:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
195: 
196:         *-- Botao Visualizar
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

*-- Linhas 216 a 233:
216:             .AutoSize        = .F.
217:             .Visible         = .T.
218:         ENDWITH
219:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
220: 
221:         *-- Botao Alterar
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

*-- Linhas 241 a 258:
241:             .AutoSize        = .F.
242:             .Visible         = .T.
243:         ENDWITH
244:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
245: 
246:         *-- Botao Excluir
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

*-- Linhas 266 a 283:
266:             .AutoSize        = .F.
267:             .Visible         = .T.
268:         ENDWITH
269:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
270: 
271:         *-- Botao Buscar
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

*-- Linhas 291 a 320:
291:             .AutoSize        = .F.
292:             .Visible         = .T.
293:         ENDWITH
294:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
295: 
296:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10: Left=917 Width=90)
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

*-- Linhas 328 a 343:
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
332: 
333:         *-- Grid de lista (Grade no legado: Top=97, Left=30, Width=939, Height=490)
334:         *-- Com compensacao +29: Top=126. Width=880 para nao sobrepor cnt_4c_Saida
335:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
336:         WITH loc_oPagina.grd_4c_Lista
337:             .Top                = 126
338:             .Left               = 30
339:             .Width              = 880
340:             .Height             = 458
341:             .ColumnCount        = 2
342:             .FontName           = "Verdana"
343:             .FontSize           = 8

*-- Linhas 362 a 398:
362:     *===========================================================================
363:     * ConfigurarPaginaDados - Configura Page2 com botoes e campos (Fase 5)
364:     * Campos: codigos (PK), descs, impops (OptionGroup Sim/Nao)
365:     * Posicoes: original + 29 (compensacao PageFrame.Top=-29)
366:     *===========================================================================
367:     PROTECTED PROCEDURE ConfigurarPaginaDados()
368:         LOCAL loc_oPagina
369:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
370: 
371:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
372:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
373: 
374:         *-- Container Botoes Acao (Grupo_Salva: Left=843, Top=-4 → +29 = Top=25; canonico=33)
375:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
376:         WITH loc_oPagina.cnt_4c_BotoesAcao
377:             .Top         = 33
378:             .Left        = 842
379:             .Width       = 160
380:             .Height      = 85
381:             .BackStyle   = 0
382:             .BorderWidth = 0
383:             .Visible     = .T.
384:         ENDWITH
385: 
386:         *-- Botao Confirmar (Salva.Left=5, Salva.Top=5)
387:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
388:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
389:             .Caption         = "Confirmar"
390:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
391:             .PicturePosition = 13
392:             .Top             = 5
393:             .Left            = 5
394:             .Width           = 75
395:             .Height          = 75
396:             .FontName        = "Tahoma"
397:             .FontBold        = .T.
398:             .FontItalic      = .T.

*-- Linhas 406 a 423:
406:             .AutoSize        = .F.
407:             .Visible         = .T.
408:         ENDWITH
409:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
410: 
411:         *-- Botao Cancelar (Cancelar.Left=80, Cancelar.Top=5)
412:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
413:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
414:             .Caption         = "Encerrar"
415:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
416:             .PicturePosition = 13
417:             .Top             = 5
418:             .Left            = 80
419:             .Width           = 75
420:             .Height          = 75
421:             .FontName        = "Tahoma"
422:             .FontBold        = .T.
423:             .FontItalic      = .T.

*-- Linhas 431 a 446:
431:             .AutoSize        = .F.
432:             .Visible         = .T.
433:         ENDWITH
434:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
435: 
436:         *-- Label "Codigo :" (Say2: Top=182, Left=403 → +29 = Top=211)
437:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
438:         WITH loc_oPagina.lbl_4c_Label2
439:             .Caption   = "C" + CHR(243) + "digo :"
440:             .Top       = 211
441:             .Left      = 403
442:             .FontName  = "Tahoma"
443:             .FontSize  = 8
444:             .ForeColor = RGB(90, 90, 90)
445:             .BackStyle = 0
446:             .AutoSize  = .T.

*-- Linhas 452 a 478:
452:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
453:         WITH loc_oPagina.txt_4c_Codigo
454:             .Value         = ""
455:             .Top           = 209
456:             .Left          = 447
457:             .Width         = 80
458:             .Height        = 18
459:             .MaxLength     = 10
460:             .FontName      = "Tahoma"
461:             .FontSize      = 8
462:             .ForeColor     = RGB(0, 0, 0)
463:             .BorderColor   = RGB(100, 100, 100)
464:             .SpecialEffect = 1
465:             .Visible       = .T.
466:         ENDWITH
467: 
468:         *-- Label "Descricao :" (Say3: Top=209, Left=390 → +29 = Top=238)
469:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
470:         WITH loc_oPagina.lbl_4c_Label3
471:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
472:             .Top       = 238
473:             .Left      = 390
474:             .FontName  = "Tahoma"
475:             .FontSize  = 8
476:             .ForeColor = RGB(90, 90, 90)
477:             .BackStyle = 0
478:             .AutoSize  = .T.

*-- Linhas 484 a 510:
484:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
485:         WITH loc_oPagina.txt_4c_Descricao
486:             .Value         = ""
487:             .Top           = 235
488:             .Left          = 447
489:             .Width         = 220
490:             .Height        = 18
491:             .MaxLength     = 30
492:             .FontName      = "Tahoma"
493:             .FontSize      = 8
494:             .ForeColor     = RGB(0, 0, 0)
495:             .BorderColor   = RGB(100, 100, 100)
496:             .SpecialEffect = 1
497:             .Visible       = .T.
498:         ENDWITH
499: 
500:         *-- Label impops (Say1: Top=236, Left=332, +29 = Top=265)
501:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
502:         WITH loc_oPagina.lbl_4c_Label1
503:             .Caption   = "Imprimir OF Pendente :"
504:             .Top       = 265
505:             .Left      = 332
506:             .FontName  = "Tahoma"
507:             .FontSize  = 8
508:             .ForeColor = RGB(90, 90, 90)
509:             .BackStyle = 0
510:             .AutoSize  = .T.

*-- Linhas 519 a 547:
519:             .BackStyle     = 0
520:             .BorderStyle   = 0
521:             .SpecialEffect = 0
522:             .Top           = 263
523:             .Left          = 442
524:             .Width         = 109
525:             .Height        = 20
526:             .Value         = 1
527:             .Visible       = .T.
528:         ENDWITH
529:         WITH loc_oPagina.opt_4c_Op_con.Buttons(1)
530:             .Caption   = "Sim"
531:             .Left      = 4
532:             .Top       = 2
533:             .AutoSize  = .T.
534:             .FontName  = "Tahoma"
535:             .FontSize  = 8
536:             .ForeColor = RGB(90, 90, 90)
537:             .BackStyle = 0
538:         ENDWITH
539:         WITH loc_oPagina.opt_4c_Op_con.Buttons(2)
540:             .Caption   = "N" + CHR(227) + "o"
541:             .Left      = 55
542:             .Top       = 2
543:             .AutoSize  = .T.
544:             .FontName  = "Tahoma"
545:             .FontSize  = 8
546:             .ForeColor = RGB(90, 90, 90)
547:             .BackStyle = 0

*-- Linhas 556 a 577:
556:     PROCEDURE Destroy()
557:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
558:             THIS.this_oBusinessObject = .NULL.
559:         ENDIF
560: 
561:         IF USED("cursor_4c_Dados")
562:             USE IN cursor_4c_Dados
563:         ENDIF
564: 
565:         DODEFAULT()
566:     ENDPROC
567: 
568:     *===========================================================================
569:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
570:     * Itera Pages de PageFrames e Controls de Containers
571:     *===========================================================================
572:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
573:         LOCAL loc_nI, loc_oObjeto, loc_nP
574: 
575:         FOR loc_nI = 1 TO par_oContainer.ControlCount
576:             loc_oObjeto = par_oContainer.Controls(loc_nI)
577: 

*-- Linhas 620 a 642:
620:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
621:                 IF THIS.this_oBusinessObject.Buscar("")
622:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
623: 
624:                     loc_oGrid.ColumnCount = 2
625:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
626:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
627:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
628: 
629:                     loc_oGrid.Column1.Width = 80
630:                     loc_oGrid.Column2.Width = 160
631: 
632:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
633:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
634: 
635:                     THIS.FormatarGridLista(loc_oGrid)
636:                     loc_lSucesso = .T.
637:                 ENDIF
638:             ENDIF
639:         CATCH TO loException
640:             MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
641:             loc_lSucesso = .F.
642:         ENDTRY

*-- Linhas 719 a 753:
719:     * HabilitarCampos - Habilita/desabilita campos conforme modo atual
720:     * txt_4c_Codigo: somente em INCLUIR (When original: !ALTERAR/EXCLUIR/CONSULTAR)
721:     * opt_4c_Op_con: somente em INCLUIR e ALTERAR
722:     * cmd_4c_Confirmar: em INCLUIR, ALTERAR e EXCLUIR
723:     *===========================================================================
724:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
725:         LOCAL loc_oPagina, loc_lIncluir, loc_lAlterar, loc_lExcluir
726:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
727:         loc_lIncluir = (THIS.this_cModoAtual = "INCLUIR")
728:         loc_lAlterar = (THIS.this_cModoAtual = "ALTERAR")
729:         loc_lExcluir = (THIS.this_cModoAtual = "EXCLUIR")
730: 
731:         loc_oPagina.txt_4c_Codigo.Enabled    = loc_lIncluir
732:         loc_oPagina.txt_4c_Descricao.Enabled = loc_lIncluir OR loc_lAlterar
733:         loc_oPagina.opt_4c_Op_con.Enabled    = loc_lIncluir OR loc_lAlterar
734:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar OR loc_lExcluir
735:     ENDPROC
736: 
737:     *===========================================================================
738:     * AjustarBotoesPorModo - Todos os botoes da lista ficam habilitados
739:     *===========================================================================
740:     PROTECTED PROCEDURE AjustarBotoesPorModo()
741:         LOCAL loc_oBotoes
742:         loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
743: 
744:         loc_oBotoes.cmd_4c_Incluir.Enabled    = .T.
745:         loc_oBotoes.cmd_4c_Visualizar.Enabled = .T.
746:         loc_oBotoes.cmd_4c_Alterar.Enabled    = .T.
747:         loc_oBotoes.cmd_4c_Excluir.Enabled    = .T.
748:         loc_oBotoes.cmd_4c_Buscar.Enabled     = .T.
749:     ENDPROC
750: 
751:     *===========================================================================
752:     * BtnIncluirClick - Abre Page2 para inserir novo registro
753:     *===========================================================================

*-- Linhas 765 a 853:
765:     *===========================================================================
766:     PROCEDURE BtnAlterarClick()
767:         LOCAL loc_cCodigo, loc_lSucesso
768:         loc_lSucesso = .F.
769: 
770:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
771:             MsgAviso("Selecione um registro para alterar.", "Alterar")
772:             RETURN
773:         ENDIF
774: 
775:         SELECT cursor_4c_Dados
776:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
777: 
778:         TRY
779:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
780:                 THIS.this_oBusinessObject.EditarRegistro()
781:                 THIS.this_cModoAtual = "ALTERAR"
782:                 THIS.BOParaForm()
783:                 THIS.HabilitarCampos(.T.)
784:                 THIS.AlternarPagina(2)
785:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
786:                 loc_lSucesso = .T.
787:             ELSE
788:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro.", "Alterar")
789:             ENDIF
790:         CATCH TO loException
791:             MsgErro("Erro ao alterar:" + CHR(13) + loException.Message, "Erro")
792:         ENDTRY
793:     ENDPROC
794: 
795:     *===========================================================================
796:     * BtnVisualizarClick - Carrega registro selecionado para visualizacao (readonly)
797:     *===========================================================================
798:     PROCEDURE BtnVisualizarClick()
799:         LOCAL loc_cCodigo
800: 
801:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
802:             MsgAviso("Selecione um registro para visualizar.", "Visualizar")
803:             RETURN
804:         ENDIF
805: 
806:         SELECT cursor_4c_Dados
807:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
808: 
809:         TRY
810:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
811:                 THIS.this_cModoAtual = "VISUALIZAR"
812:                 THIS.BOParaForm()
813:                 THIS.HabilitarCampos(.F.)
814:                 THIS.AlternarPagina(2)
815:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
816:             ELSE
817:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro.", "Visualizar")
818:             ENDIF
819:         CATCH TO loException
820:             MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Erro")
821:         ENDTRY
822:     ENDPROC
823: 
824:     *===========================================================================
825:     * BtnExcluirClick - Confirma e prepara exclusao do registro selecionado
826:     *===========================================================================
827:     PROCEDURE BtnExcluirClick()
828:         LOCAL loc_cCodigo
829: 
830:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
831:             MsgAviso("Selecione um registro para excluir.", "Excluir")
832:             RETURN
833:         ENDIF
834: 
835:         SELECT cursor_4c_Dados
836:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
837: 
838:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do segmento '" + loc_cCodigo + "'?", "Excluir")
839:             RETURN
840:         ENDIF
841: 
842:         TRY
843:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
844:                 THIS.this_cModoAtual = "EXCLUIR"
845:                 THIS.BOParaForm()
846:                 THIS.HabilitarCampos(.F.)
847:                 THIS.AlternarPagina(2)
848:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
849:             ELSE
850:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro.", "Excluir")
851:             ENDIF
852:         CATCH TO loException
853:             MsgErro("Erro ao preparar exclus" + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 870 a 902:
870:             loc_cSQL = "SELECT codigos, descs, impops" + ;
871:                        " FROM SigCdSct" + ;
872:                        " WHERE codigos LIKE " + EscaparSQL(ALLTRIM(loc_cFiltro) + "%") + ;
873:                        " ORDER BY codigos"
874: 
875:             IF USED("cursor_4c_Dados")
876:                 USE IN cursor_4c_Dados
877:             ENDIF
878: 
879:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
880: 
881:             IF loc_nResultado >= 0
882:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
883: 
884:                 loc_oGrid.ColumnCount = 2
885:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
886:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
887:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
888: 
889:                 loc_oGrid.Column1.Width = 80
890:                 loc_oGrid.Column2.Width = 160
891: 
892:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
893:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
894: 
895:                 THIS.FormatarGridLista(loc_oGrid)
896:             ELSE
897:                 MsgErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
898:             ENDIF
899:         CATCH TO loException
900:             MsgErro("Erro ao buscar:" + CHR(13) + loException.Message, "Erro")
901:         ENDTRY
902:     ENDPROC


### BO (C:\4c\projeto\app\classes\SEGBO.prg):
*******************************************************************************
* SEGBO.prg - Business Object para Segmentos de Contas
* Tabela   : SigCdSct
* PK       : codigos
* Herda de : BusinessBase
*******************************************************************************

DEFINE CLASS SEGBO AS BusinessBase

    *-- Propriedades da entidade (mapeadas para SigCdSct)
    this_cCodigo    = ""    && codigos    char(10)    PK
    this_cDescricao = ""    && descs      char(30)
    this_nImpops    = 0     && impops     numeric(1,0) - 1=Sim / 2=Nao

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave do BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdSct"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(codigos, "C")
            THIS.this_cDescricao = TratarNulo(descs,   "C")
            THIS.this_nImpops    = TratarNulo(impops,  "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista para o grid (cursor_4c_Dados)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, impops" + ;
                       " FROM SigCdSct" + ;
                       " ORDER BY codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar segmentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo PK
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, impops" + ;
                       " FROM SigCdSct" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdSct (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdSct (codigos, descs, impops)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImpops) + ;
                       ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir segmento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdSct (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdSct SET" + ;
                       " descs = "   + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + "," + ;
                       " impops = "  + FormatarNumeroSQL(THIS.this_nImpops) + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar segmento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdSct (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdSct" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir segmento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

