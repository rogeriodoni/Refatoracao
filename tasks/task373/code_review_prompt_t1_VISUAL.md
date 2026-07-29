# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcmp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (994 linhas total):

*-- Linhas 52 a 61:
52:                 *-- Configurar PageFrame com 2 paginas e containers base
53:                 THIS.ConfigurarPageFrame()
54: 
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57: 
58:                 THIS.ConfigurarPaginaLista()
59:                 THIS.ConfigurarPaginaDados()
60: 
61:                 *-- Carregar dados iniciais (pula se validando UI sem conexao SQL)

*-- Linhas 89 a 115:
89: 
90:             WITH THIS.pgf_4c_Paginas
91:                 .PageCount = 2
92:                 .Top       = -29
93:                 .Left      = 0
94:                 .Width     = THIS.Width
95:                 .Height    = THIS.Height + 29
96:                 .Tabs      = .F.
97:                 .Visible   = .T.
98:             ENDWITH
99: 
100:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
101:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
102: 
103:             WITH loc_oPg1
104:                 .Caption   = "Lista"
105:                 .Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
106:                 .BackColor = RGB(240, 240, 240)
107:             ENDWITH
108: 
109:             WITH loc_oPg2
110:                 .Caption   = "Dados"
111:                 .Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:                 .BackColor = RGB(240, 240, 240)
113:             ENDWITH
114: 
115:             *-- Containers estruturais da Page1

*-- Linhas 130 a 201:
130: 
131:         TRY
132:             *-- Container cabecalho (cntSombra no legado)
133:             *-- Top = 2 + 29 (compensacao PageFrame.Top=-29)
134:             par_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
135:             WITH par_oPagina.cnt_4c_Cabecalho
136:                 .Top         = 31
137:                 .Left        = 0
138:                 .Width       = THIS.Width
139:                 .Height      = 80
140:                 .BackColor   = RGB(100, 100, 100)
141:                 .BorderWidth = 0
142:                 .Visible     = .T.
143:             ENDWITH
144: 
145:             par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
146:             WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
147:                 .Caption   = THIS.Caption
148:                 .Top       = 15
149:                 .Left      = 10
150:                 .Width     = 769
151:                 .Height    = 40
152:                 .FontName  = "Tahoma"
153:                 .FontSize  = 16
154:                 .FontBold  = .T.
155:                 .ForeColor = RGB(0, 0, 0)
156:                 .BackStyle = 0
157:                 .AutoSize  = .F.
158:                 .Visible   = .T.
159:             ENDWITH
160: 
161:             par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
162:             WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
163:                 .Caption   = THIS.Caption
164:                 .Top       = 18
165:                 .Left      = 10
166:                 .Width     = 769
167:                 .Height    = 46
168:                 .FontName  = "Tahoma"
169:                 .FontSize  = 16
170:                 .FontBold  = .T.
171:                 .ForeColor = RGB(255, 255, 255)
172:                 .BackStyle = 0
173:                 .AutoSize  = .F.
174:                 .Visible   = .T.
175:             ENDWITH
176: 
177:             *-- Container botoes CRUD (Grupo_op no legado)
178:             *-- Grupo_op.Left=342 no original, Left=542 canonico para form 1000px
179:             *-- Top = -1 + 29 (compensacao) = 28, usar canonico 29
180:             par_oPagina.AddObject("cnt_4c_Botoes", "Container")
181:             WITH par_oPagina.cnt_4c_Botoes
182:                 .Top         = 29
183:                 .Left        = 542
184:                 .Width       = 390
185:                 .Height      = 85
186:                 .BackStyle   = 0
187:                 .BorderWidth = 0
188:                 .Visible     = .T.
189:             ENDWITH
190: 
191:             *-- Container saida - PADRAO CANONICO (prevalece sobre PILAR 1)
192:             *-- Left=917, Width=90 canonico (CLAUDE.md regra #10)
193:             par_oPagina.AddObject("cnt_4c_Saida", "Container")
194:             WITH par_oPagina.cnt_4c_Saida
195:                 .Top         = 29
196:                 .Left        = 917
197:                 .Width       = 90
198:                 .Height      = 85
199:                 .BackStyle   = 0
200:                 .BorderWidth = 0
201:                 .Visible     = .T.

*-- Linhas 213 a 225:
213: 
214:         TRY
215:             *-- Container botoes salvar/cancelar (Grupo_Salva no legado)
216:             *-- Grupo_Salva.Top=17 + 29 = 46, Left=611 (original)
217:             par_oPagina.AddObject("cnt_4c_Salva", "Container")
218:             WITH par_oPagina.cnt_4c_Salva
219:                 .Top         = 46
220:                 .Left        = 611
221:                 .Width       = 160
222:                 .Height      = 85
223:                 .BackStyle = 1
224:                 .BackColor = RGB(255, 255, 255)
225:                 .BorderWidth = 0

*-- Linhas 244 a 258:
244:             loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
245: 
246:             *-- Botao Incluir
247:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
248:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
249:                 .Caption         = "Incluir"
250:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
251:                 .PicturePosition = 13
252:                 .Top             = 5
253:                 .Left            = 5
254:                 .Width           = 75
255:                 .Height          = 75
256:                 .BackColor       = RGB(255, 255, 255)
257:                 .ForeColor       = RGB(90, 90, 90)
258:                 .FontName        = "Tahoma"

*-- Linhas 266 a 283:
266:                 .AutoSize        = .F.
267:                 .Visible         = .T.
268:             ENDWITH
269:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
270: 
271:             *-- Botao Visualizar
272:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
273:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
274:                 .Caption         = "Visualizar"
275:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
276:                 .PicturePosition = 13
277:                 .Top             = 5
278:                 .Left            = 80
279:                 .Width           = 75
280:                 .Height          = 75
281:                 .BackColor       = RGB(255, 255, 255)
282:                 .ForeColor       = RGB(90, 90, 90)
283:                 .FontName        = "Tahoma"

*-- Linhas 291 a 308:
291:                 .AutoSize        = .F.
292:                 .Visible         = .T.
293:             ENDWITH
294:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
295: 
296:             *-- Botao Alterar
297:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
298:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
299:                 .Caption         = "Alterar"
300:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
301:                 .PicturePosition = 13
302:                 .Top             = 5
303:                 .Left            = 155
304:                 .Width           = 75
305:                 .Height          = 75
306:                 .BackColor       = RGB(255, 255, 255)
307:                 .ForeColor       = RGB(90, 90, 90)
308:                 .FontName        = "Tahoma"

*-- Linhas 316 a 333:
316:                 .AutoSize        = .F.
317:                 .Visible         = .T.
318:             ENDWITH
319:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
320: 
321:             *-- Botao Excluir
322:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
323:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
324:                 .Caption         = "Excluir"
325:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
326:                 .PicturePosition = 13
327:                 .Top             = 5
328:                 .Left            = 230
329:                 .Width           = 75
330:                 .Height          = 75
331:                 .BackColor       = RGB(255, 255, 255)
332:                 .ForeColor       = RGB(90, 90, 90)
333:                 .FontName        = "Tahoma"

*-- Linhas 341 a 358:
341:                 .AutoSize        = .F.
342:                 .Visible         = .T.
343:             ENDWITH
344:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
345: 
346:             *-- Botao Buscar (procurar no legado)
347:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
348:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
349:                 .Caption         = "Buscar"
350:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
351:                 .PicturePosition = 13
352:                 .Top             = 5
353:                 .Left            = 305
354:                 .Width           = 75
355:                 .Height          = 75
356:                 .BackColor       = RGB(255, 255, 255)
357:                 .ForeColor       = RGB(90, 90, 90)
358:                 .FontName        = "Tahoma"

*-- Linhas 366 a 383:
366:                 .AutoSize        = .F.
367:                 .Visible         = .T.
368:             ENDWITH
369:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
370: 
371:             *-- Botao Encerrar (PADRAO CANONICO: cnt_4c_Saida, Width=75, Caption="Encerrar")
372:             loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
373:             WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
374:                 .Caption         = "Encerrar"
375:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
376:                 .PicturePosition = 13
377:                 .Top             = 5
378:                 .Left            = 5
379:                 .Width           = 75
380:                 .Height          = 75
381:                 .BackColor       = RGB(255, 255, 255)
382:                 .ForeColor       = RGB(90, 90, 90)
383:                 .FontName        = "Tahoma"

*-- Linhas 391 a 413:
391:                 .AutoSize        = .F.
392:                 .Visible         = .T.
393:             ENDWITH
394:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
395: 
396:             *-- Cursor placeholder com mesmos campos de cursor_4c_Dados retornado por Buscar()
397:             SET NULL ON
398:             CREATE CURSOR cursor_4c_Dados (cods C(10), descs C(60))
399:             SET NULL OFF
400: 
401:             *-- Grid de lista
402:             *-- Top = 117 (canonico: 88+29), Left = 12
403:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
404:             WITH loc_oPagina.grd_4c_Lista
405:                 .Top                = 117
406:                 .Left               = 12
407:                 .Width              = 937
408:                 .Height             = 470
409:                 .FontName           = "Verdana"
410:                 .FontSize           = 8
411:                 .ForeColor          = RGB(90, 90, 90)
412:                 .BackColor          = RGB(255, 255, 255)
413:                 .GridLineColor      = RGB(238, 238, 238)

*-- Linhas 422 a 451:
422:                 .Visible            = .T.
423:             ENDWITH
424: 
425:             *-- RecordSource e ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
426:             loc_oPagina.grd_4c_Lista.ColumnCount  = 2
427:             loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
428:             loc_oPagina.grd_4c_Lista.ColumnCount  = 2
429: 
430:             *-- ControlSources APOS RecordSource (evita auto-bind por ordem de campos)
431:             WITH loc_oPagina.grd_4c_Lista
432:                 .Column1.ControlSource   = "cursor_4c_Dados.cods"
433:                 .Column1.Width           = 90
434:                 .Column1.Header1.Caption = "C" + CHR(243) + "digo"
435: 
436:                 .Column2.ControlSource   = "cursor_4c_Dados.descs"
437:                 .Column2.Width           = 337
438:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
439:             ENDWITH
440: 
441:             THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
442:             THIS.TornarControlesVisiveis(loc_oPagina)
443: 
444:         CATCH TO loException
445:             MostrarErro(loException, "Formcmp.ConfigurarPaginaLista")
446:         ENDTRY
447:     ENDPROC
448: 
449:     *--------------------------------------------------------------------------
450:     * ConfigurarPaginaDados - Adiciona botoes Confirmar/Cancelar e campos na Page2
451:     *--------------------------------------------------------------------------

*-- Linhas 459 a 473:
459:             loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
460: 
461:             *-- Botao Confirmar (Salvar) em cnt_4c_Salva
462:             loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
463:             WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
464:                 .Caption         = "Confirmar"
465:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
466:                 .PicturePosition = 13
467:                 .Top             = 5
468:                 .Left            = 5
469:                 .Width           = 75
470:                 .Height          = 75
471:                 .BackColor       = RGB(255, 255, 255)
472:                 .ForeColor       = RGB(90, 90, 90)
473:                 .FontName        = "Tahoma"

*-- Linhas 481 a 498:
481:                 .AutoSize        = .F.
482:                 .Visible         = .T.
483:             ENDWITH
484:             BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
485: 
486:             *-- Botao Cancelar em cnt_4c_Salva
487:             loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
488:             WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
489:                 .Caption         = "Encerrar"
490:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
491:                 .PicturePosition = 13
492:                 .Top             = 5
493:                 .Left            = 80
494:                 .Width           = 75
495:                 .Height          = 75
496:                 .BackColor       = RGB(255, 255, 255)
497:                 .ForeColor       = RGB(90, 90, 90)
498:                 .FontName        = "Tahoma"

*-- Linhas 506 a 522:
506:                 .AutoSize        = .F.
507:                 .Visible         = .T.
508:             ENDWITH
509:             BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
510: 
511:             *-- Campo 1: Codigo (Get_codigo)
512:             *-- Say1: Top=124+29=153, Left=215, ForeColor=90,90,90
513:             loc_oPagina.AddObject("lbl_4c_Label1", "Label")
514:             WITH loc_oPagina.lbl_4c_Label1
515:                 .Caption   = "C" + CHR(243) + "digo :"
516:                 .Top       = 153
517:                 .Left      = 215
518:                 .Height    = 17
519:                 .Width     = 45
520:                 .FontName  = "Tahoma"
521:                 .FontSize  = 8
522:                 .FontBold  = .F.

*-- Linhas 530 a 556:
530:             loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
531:             WITH loc_oPagina.txt_4c_Codigo
532:                 .Value         = ""
533:                 .Top           = 150
534:                 .Left          = 263
535:                 .Width         = 84
536:                 .Height        = 23
537:                 .FontName      = "Tahoma"
538:                 .FontSize      = 8
539:                 .ForeColor     = RGB(90, 90, 90)
540:                 .BackColor     = RGB(255, 255, 255)
541:                 .SpecialEffect = 1
542:                 .Visible       = .T.
543:             ENDWITH
544: 
545:             *-- Campo 2: Descricao (Get_desc)
546:             *-- Say2: Top=149+29=178, Left=202, ForeColor=90,90,90
547:             loc_oPagina.AddObject("lbl_4c_Label2", "Label")
548:             WITH loc_oPagina.lbl_4c_Label2
549:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
550:                 .Top       = 178
551:                 .Left      = 202
552:                 .Height    = 17
553:                 .Width     = 58
554:                 .FontName  = "Tahoma"
555:                 .FontSize  = 8
556:                 .FontBold  = .F.

*-- Linhas 564 a 573:
564:             loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
565:             WITH loc_oPagina.txt_4c_Desc
566:                 .Value         = ""
567:                 .Top           = 175
568:                 .Left          = 263
569:                 .Width         = 240
570:                 .Height        = 23
571:                 .FontName      = "Tahoma"
572:                 .FontSize      = 8
573:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 601 a 625:
601:             IF !THIS.this_oBusinessObject.Buscar("")
602:                 loc_lResultado = .F.
603:             ELSE
604:                 *-- Reconectar ControlSources apos ZAP+APPEND (evita reset de headers)
605:                 WITH loc_oGrid
606:                     .Column1.ControlSource   = "cursor_4c_Dados.cods"
607:                     .Column1.Width           = 90
608:                     .Column1.Header1.Caption = "C" + CHR(243) + "digo"
609: 
610:                     .Column2.ControlSource   = "cursor_4c_Dados.descs"
611:                     .Column2.Width           = 337
612:                     .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
613:                 ENDWITH
614: 
615:                 loc_oGrid.Refresh()
616:                 loc_lResultado = .T.
617:             ENDIF
618: 
619:         CATCH TO loException
620:             MostrarErro(loException, "Formcmp.CarregarLista")
621:             loc_lResultado = .F.
622:         ENDTRY
623: 
624:         RETURN loc_lResultado
625:     ENDPROC

*-- Linhas 700 a 708:
700: 
701:         *-- Botoes de acao
702:         IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
703:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
704:         ENDIF
705:     ENDPROC
706: 
707:     *--------------------------------------------------------------------------
708:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme o modo atual

*-- Linhas 716 a 735:
716:         *-- Botoes Page1 desabilitados enquanto estiver em edicao
717:         IF VARTYPE(loc_oPg1.cnt_4c_Botoes) = "O"
718:             WITH loc_oPg1.cnt_4c_Botoes
719:                 .cmd_4c_Incluir.Enabled    = !loc_lEdicao
720:                 .cmd_4c_Visualizar.Enabled = !loc_lEdicao
721:                 .cmd_4c_Alterar.Enabled    = !loc_lEdicao
722:                 .cmd_4c_Excluir.Enabled    = !loc_lEdicao
723:                 .cmd_4c_Buscar.Enabled     = !loc_lEdicao
724:                 .Visible     = .T.
725:             ENDWITH
726:         ENDIF
727: 
728:         *-- Confirmar habilitado apenas em edicao
729:         IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
730:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
731:         ENDIF
732:     ENDPROC
733: 
734:     *--------------------------------------------------------------------------
735:     * EVENTOS CRUD - Page1

*-- Linhas 754 a 839:
754:     PROCEDURE BtnVisualizarClick()
755:         LOCAL loc_cCodigo
756:         loc_cCodigo = ""
757: 
758:         *-- Validacao FORA do TRY (Regra 1: nunca RETURN dentro de TRY/CATCH)
759:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
760:             MsgAviso("Selecione um registro para visualizar.")
761:             RETURN
762:         ENDIF
763: 
764:         TRY
765:             SELECT cursor_4c_Dados
766:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
767: 
768:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
769:                 THIS.BOParaForm()
770:                 THIS.this_cModoAtual = "VISUALIZAR"
771:                 THIS.HabilitarCampos(.F.)
772:                 THIS.AlternarPagina(2)
773:                 *-- Foco no Confirmar (Salva.SetFocus no legado - modo consulta)
774:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva) = "O"
775:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
776:                 ENDIF
777:             ENDIF
778:         CATCH TO loException
779:             MostrarErro(loException, "Formcmp.BtnVisualizarClick")
780:         ENDTRY
781:     ENDPROC
782: 
783:     PROCEDURE BtnAlterarClick()
784:         LOCAL loc_cCodigo
785:         loc_cCodigo = ""
786: 
787:         *-- Validacao FORA do TRY (Regra 1: nunca RETURN dentro de TRY/CATCH)
788:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
789:             MsgAviso("Selecione um registro para alterar.")
790:             RETURN
791:         ENDIF
792: 
793:         TRY
794:             SELECT cursor_4c_Dados
795:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
796: 
797:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
798:                 THIS.this_oBusinessObject.EditarRegistro()
799:                 THIS.BOParaForm()
800:                 THIS.this_cModoAtual = "ALTERAR"
801:                 THIS.HabilitarCampos(.T.)
802:                 THIS.AlternarPagina(2)
803:                 *-- Foco na descricao (ALTERAR: Get_Desc.SetFocus no legado)
804:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Desc) = "O"
805:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Desc.SetFocus()
806:                 ENDIF
807:             ENDIF
808:         CATCH TO loException
809:             MostrarErro(loException, "Formcmp.BtnAlterarClick")
810:         ENDTRY
811:     ENDPROC
812: 
813:     PROCEDURE BtnExcluirClick()
814:         LOCAL loc_cCodigo
815:         loc_cCodigo = ""
816: 
817:         *-- Validacoes FORA do TRY (Regra 1: nunca RETURN dentro de TRY/CATCH)
818:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
819:             MsgAviso("Selecione um registro para excluir.")
820:             RETURN
821:         ENDIF
822: 
823:         SELECT cursor_4c_Dados
824:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
825: 
826:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + loc_cCodigo + "'?", ;
827:                         "Excluir Compra Para")
828:             RETURN
829:         ENDIF
830: 
831:         TRY
832:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
833:                 IF THIS.this_oBusinessObject.Excluir()
834:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
835:                     THIS.CarregarLista()
836:                 ENDIF
837:             ENDIF
838:         CATCH TO loException
839:             MostrarErro(loException, "Formcmp.BtnExcluirClick")

*-- Linhas 972 a 993:
972:     *--------------------------------------------------------------------------
973:     * Destroy - Libera recursos ao fechar o formulario
974:     *--------------------------------------------------------------------------
975:     PROCEDURE Destroy()
976:         TRY
977:             IF USED("cursor_4c_Dados")
978:                 USE IN cursor_4c_Dados
979:             ENDIF
980:             IF USED("cursor_4c_BuscaCmp")
981:                 USE IN cursor_4c_BuscaCmp
982:             ENDIF
983: 
984:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
985:                 THIS.this_oBusinessObject = .NULL.
986:             ENDIF
987:         CATCH TO loException
988:             MostrarErro(loException, "Formcmp.Destroy")
989:         ENDTRY
990: 
991:         DODEFAULT()
992:     ENDPROC
993: 


### BO (C:\4c\projeto\app\classes\cmpBO.prg):
*==============================================================================
* cmpBO.prg - Business Object para Compra Para
* Data: 2026-07-29
* Tabela: SigCdCmp | PK: cods
*==============================================================================

DEFINE CLASS cmpBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigCdCmp)
    this_cCodigo    = ""    && cods       CHAR - C" + CHR(243) + "digo (PK)
    this_cDescricao = ""    && descs      CHAR - Descri" + CHR(231) + CHR(227) + "o
    this_cIdChaves  = ""    && cIdChaves  CHAR - Chave " + CHR(250) + "nica UUID

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCmp"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = TratarNulo(cods,      "C")
                THIS.this_cDescricao = TratarNulo(descs,     "C")
                THIS.this_cIdChaves  = TratarNulo(cIdChaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "cmpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_nResultado, loc_cSQL
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        *-- Verificar duplicidade apenas em novo registro
        IF loc_lValido AND THIS.this_lNovoRegistro
            loc_cSQL = "SELECT cods FROM SigCdCmp WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_ChkDup") AND RECCOUNT("cursor_4c_ChkDup") > 0
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                    loc_lValido = .F.
                ENDIF
                IF USED("cursor_4c_ChkDup")
                    USE IN cursor_4c_ChkDup
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cIdChaves
        loc_lSucesso = .F.

        TRY
            loc_cIdChaves = ALLTRIM(fUniqueIds())

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCmp (cods, descs, cIdChaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(loc_cIdChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cIdChaves = loc_cIdChaves
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cmpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCmp
                SET descs = <<EscaparSQL(THIS.this_cDescricao)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cmpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdCmp WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cmpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cods, descs
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Sem conexao: criar cursor vazio para nao bloquear o grid
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (cods C(10), descs C(60))
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            loc_cSQL = "SELECT cods, descs FROM SigCdCmp"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            *-- Protecao de grid: se cursor ja esta aberto (grid vinculado), usar ZAP+APPEND
            IF USED("cursor_4c_Dados")
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF("cursor_4c_DadosTmp")
                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cmpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cods, descs, cIdChaves
                FROM SigCdCmp
                WHERE cods = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Compra Para n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cmpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

