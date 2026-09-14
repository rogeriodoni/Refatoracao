# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-HEADER] Header Caption 'Setor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSET.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1413 linhas total):

*-- Linhas 50 a 59:
50:                     "FormSET.InicializarForm")
51:             ELSE
52:                 THIS.ConfigurarPageFrame()
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Visible    = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1
57:                 THIS.this_cModoAtual           = "LISTA"
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 82 a 101:
82: 
83:         WITH THIS.pgf_4c_Paginas
84:             .PageCount = 2
85:             .Top       = -29
86:             .Left      = 0
87:             .Width     = THIS.Width
88:             .Height    = THIS.Height + 29
89:             .Tabs      = .F.
90:             .Visible   = .T.
91: 
92:             .Page1.Caption   = "Lista"
93:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page1.BackColor = RGB(255, 255, 255)
95: 
96:             .Page2.Caption   = "Dados"
97:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page2.BackColor = RGB(255, 255, 255)
99:         ENDWITH
100: 
101:         THIS.ConfigurarPaginaLista()

*-- Linhas 116 a 153:
116:         *-- Container Cabecalho (cntSombra no legado, Top=2+29=31)
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127: 
128:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
130:             .Caption   = THIS.Caption
131:             .Top       = 15
132:             .Left      = 10
133:             .Width     = 769
134:             .Height    = 40
135:             .FontName  = "Tahoma"
136:             .FontSize  = 16
137:             .FontBold  = .T.
138:             .ForeColor = RGB(0, 0, 0)
139:             .BackStyle = 0
140:             .AutoSize  = .F.
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
146:             .Caption   = THIS.Caption
147:             .Top       = 18
148:             .Left      = 10
149:             .Width     = 769
150:             .Height    = 46
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.

*-- Linhas 160 a 184:
160:         *-- Container Botoes CRUD (grupo_op canonico: Left=542, Top=29, Width=390)
161:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
162:         WITH loc_oPagina.cnt_4c_Botoes
163:             .Top         = 29
164:             .Left        = 542
165:             .Width       = 390
166:             .Height      = 85
167:             .BackStyle   = 0
168:             .BorderWidth = 0
169:             .Visible     = .T.
170:         ENDWITH
171: 
172:         *-- Botao Incluir
173:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
174:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
175:             .Caption         = "Incluir"
176:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
177:             .PicturePosition = 13
178:             .Top             = 5
179:             .Left            = 5
180:             .Width           = 75
181:             .Height          = 75
182:             .FontName        = "Tahoma"
183:             .FontBold        = .T.
184:             .FontItalic      = .T.

*-- Linhas 192 a 209:
192:             .AutoSize        = .F.
193:             .Visible         = .T.
194:         ENDWITH
195:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
196: 
197:         *-- Botao Visualizar
198:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .FontName        = "Tahoma"
208:             .FontBold        = .T.
209:             .FontItalic      = .T.

*-- Linhas 217 a 234:
217:             .AutoSize        = .F.
218:             .Visible         = .T.
219:         ENDWITH
220:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
221: 
222:         *-- Botao Alterar
223:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
224:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
225:             .Caption         = "Alterar"
226:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
227:             .PicturePosition = 13
228:             .Top             = 5
229:             .Left            = 155
230:             .Width           = 75
231:             .Height          = 75
232:             .FontName        = "Tahoma"
233:             .FontBold        = .T.
234:             .FontItalic      = .T.

*-- Linhas 242 a 259:
242:             .AutoSize        = .F.
243:             .Visible         = .T.
244:         ENDWITH
245:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
246: 
247:         *-- Botao Excluir
248:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
249:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
250:             .Caption         = "Excluir"
251:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
252:             .PicturePosition = 13
253:             .Top             = 5
254:             .Left            = 230
255:             .Width           = 75
256:             .Height          = 75
257:             .FontName        = "Tahoma"
258:             .FontBold        = .T.
259:             .FontItalic      = .T.

*-- Linhas 267 a 284:
267:             .AutoSize        = .F.
268:             .Visible         = .T.
269:         ENDWITH
270:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
271: 
272:         *-- Botao Buscar
273:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
274:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
275:             .Caption         = "Buscar"
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
277:             .PicturePosition = 13
278:             .Top             = 5
279:             .Left            = 305
280:             .Width           = 75
281:             .Height          = 75
282:             .FontName        = "Tahoma"
283:             .FontBold        = .T.
284:             .FontItalic      = .T.

*-- Linhas 292 a 320:
292:             .AutoSize        = .F.
293:             .Visible         = .T.
294:         ENDWITH
295:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
296: 
297:         *-- Container Saida canonico (CLAUDE.md #10: Left=917, Width=90)
298:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
299:         WITH loc_oPagina.cnt_4c_Saida
300:             .Top         = 29
301:             .Left        = 917
302:             .Width       = 90
303:             .Height      = 85
304:             .BackStyle   = 0
305:             .BorderWidth = 0
306:             .Visible     = .T.
307:         ENDWITH
308: 
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

*-- Linhas 328 a 344:
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
332: 
333:         *-- Grid principal (Grade legado: colunas Setores/Descrs, Top=88+29=117)
334:         *-- ColumnCount fora do WITH para criacao imediata das colunas (Problema 36)
335:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
336:         loc_oPagina.grd_4c_Dados.ColumnCount = 2
337:         WITH loc_oPagina.grd_4c_Dados
338:             .Top                = 117
339:             .Left               = 12
340:             .Width              = 890
341:             .Height             = 450
342:             .FontName           = "Verdana"
343:             .FontSize           = 8
344:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 361 a 400:
361: 
362:     *===========================================================================
363:     * ConfigurarPaginaDados - Configura Page2 (Dados) - FASE 5/8 (primeira metade)
364:     * Controles: cnt_4c_Salva, lbl_4c_Setor, txt_4c_Setores, lbl_4c_Descricao
365:     * Demais controles (txt_4c_Descrs, lbl_4c_Localizacoes, grd_4c_Localizacoes,
366:     *   cmd_4c_Apagar) adicionados na Fase 6/8
367:     *===========================================================================
368:     PROTECTED PROCEDURE ConfigurarPaginaDados()
369:         LOCAL loc_oPagina
370:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
371: 
372:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
373:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
374: 
375:         *-- Container Salva (canonico: Left=842, Top=4+29=33, Width=160, Height=85)
376:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
377:         WITH loc_oPagina.cnt_4c_Salva
378:             .Top         = 33
379:             .Left        = 842
380:             .Width       = 160
381:             .Height      = 85
382:             .BackStyle = 1
383:             .BackColor = RGB(255, 255, 255)
384:             .BorderWidth = 0
385:             .Visible     = .T.
386:         ENDWITH
387: 
388:         *-- Botao Confirmar (salva.Left=5)
389:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
390:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
391:             .Caption         = "Confirmar"
392:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
393:             .PicturePosition = 13
394:             .Top             = 5
395:             .Left            = 5
396:             .Width           = 75
397:             .Height          = 75
398:             .FontName        = "Tahoma"
399:             .FontBold        = .T.
400:             .FontItalic      = .T.

*-- Linhas 408 a 425:
408:             .AutoSize        = .F.
409:             .Visible         = .T.
410:         ENDWITH
411:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
412: 
413:         *-- Botao Cancelar (cancelar.Left=88)
414:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
415:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
416:             .Caption         = "Encerrar"
417:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
418:             .PicturePosition = 13
419:             .Top             = 5
420:             .Left            = 88
421:             .Width           = 75
422:             .Height          = 75
423:             .FontName        = "Tahoma"
424:             .FontBold        = .T.
425:             .FontItalic      = .T.

*-- Linhas 433 a 448:
433:             .AutoSize        = .F.
434:             .Visible         = .T.
435:         ENDWITH
436:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
437: 
438:         *-- Label Setor (Label6: Left=141, Top=141+29=170, ForeColor=36,84,155)
439:         loc_oPagina.AddObject("lbl_4c_Setor", "Label")
440:         WITH loc_oPagina.lbl_4c_Setor
441:             .Caption   = "Setor :"
442:             .Top       = 170
443:             .Left      = 141
444:             .Width     = 42
445:             .Height    = 15
446:             .FontName  = "Verdana"
447:             .FontSize  = 8
448:             .FontBold  = .F.

*-- Linhas 456 a 480:
456:         loc_oPagina.AddObject("txt_4c_Setores", "TextBox")
457:         WITH loc_oPagina.txt_4c_Setores
458:             .Value     = ""
459:             .Top       = 167
460:             .Left      = 185
461:             .Width     = 80
462:             .Height    = 20
463:             .FontName  = "Verdana"
464:             .FontSize  = 8
465:             .MaxLength = 10
466:             .Enabled   = .F.
467:             .Visible   = .T.
468:         ENDWITH
469: 
470:         *-- Label Descricao (Label7: Left=298, Top=141+29=170, ForeColor=36,84,155)
471:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
472:         WITH loc_oPagina.lbl_4c_Descricao
473:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
474:             .Top       = 170
475:             .Left      = 298
476:             .Width     = 67
477:             .Height    = 15
478:             .FontName  = "Verdana"
479:             .FontSize  = 8
480:             .FontBold  = .F.

*-- Linhas 488 a 512:
488:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
489:         WITH loc_oPagina.txt_4c_Descrs
490:             .Value     = ""
491:             .Top       = 167
492:             .Left      = 366
493:             .Width     = 290
494:             .Height    = 20
495:             .FontName  = "Verdana"
496:             .FontSize  = 8
497:             .MaxLength = 40
498:             .Enabled   = .F.
499:             .Visible   = .T.
500:         ENDWITH
501: 
502:         *-- Label Localizacoes (Label8: Left=201, Top=185+29=214)
503:         loc_oPagina.AddObject("lbl_4c_Localizacoes", "Label")
504:         WITH loc_oPagina.lbl_4c_Localizacoes
505:             .Caption   = "Localiza" + CHR(231) + CHR(245) + "es :"
506:             .Top       = 214
507:             .Left      = 201
508:             .Width     = 82
509:             .Height    = 15
510:             .FontName  = "Verdana"
511:             .FontSize  = 8
512:             .FontBold  = .F.

*-- Linhas 521 a 530:
521:         loc_oPagina.AddObject("grd_4c_Localizacoes", "Grid")
522:         loc_oPagina.grd_4c_Localizacoes.ColumnCount = 2
523:         WITH loc_oPagina.grd_4c_Localizacoes
524:             .Top                = 212
525:             .Left               = 289
526:             .Width              = 261
527:             .Height             = 274
528:             .FontName           = "Verdana"
529:             .FontSize           = 8
530:             .ForeColor          = RGB(0, 0, 0)

*-- Linhas 546 a 593:
546:             .Width             = 80
547:             .Movable           = .F.
548:             .Resizable         = .F.
549:             .Header1.Caption   = "Localiza" + CHR(231) + CHR(227) + "o"
550:             .Header1.Alignment = 2
551:         ENDWITH
552: 
553:         WITH loc_oPagina.grd_4c_Localizacoes.Column2
554:             .Width             = 150
555:             .Movable           = .F.
556:             .Resizable         = .F.
557:             .ReadOnly          = .T.
558:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
559:             .Header1.Alignment = 2
560:         ENDWITH
561: 
562:         *-- BINDEVENTs para grid de localizacoes (KeyPress=F4 lookup, AfterRowColChange=validacao)
563:         BINDEVENT(loc_oPagina.grd_4c_Localizacoes, "KeyPress", THIS, "GridLocalizacoesKeyPress")
564:         BINDEVENT(loc_oPagina.grd_4c_Localizacoes, "AfterRowColChange", THIS, "GridLocAftRowColChange")
565: 
566:         *-- Botao Apagar linha do grid
567:         *-- Original: cmdApagar(group) Left=559, Top=295+29=324; Command1: Left=5, Top=5, W=40, H=40
568:         *-- Posicao absoluta: Left=564, Top=329
569:         loc_oPagina.AddObject("cmd_4c_Apagar", "CommandButton")
570:         WITH loc_oPagina.cmd_4c_Apagar
571:             .Caption         = ""
572:             .Picture         = gc_4c_CaminhoIcones + "a_misc6.bmp"
573:             .PicturePosition = 0
574:             .ToolTipText     = "Excluir"
575:             .Top             = 329
576:             .Left            = 564
577:             .Width           = 40
578:             .Height          = 40
579:             .FontName        = "Verdana"
580:             .FontSize        = 8
581:             .ForeColor       = RGB(36, 84, 155)
582:             .BackColor       = RGB(255, 255, 255)
583:             .Themes          = .F.
584:             .SpecialEffect   = 0
585:             .Enabled         = .F.
586:             .Visible         = .T.
587:         ENDWITH
588:         BINDEVENT(loc_oPagina.cmd_4c_Apagar, "Click", THIS, "BtnApagarClick")
589: 
590:         THIS.TornarControlesVisiveis(loc_oPagina)
591:     ENDPROC
592: 
593:     *===========================================================================

*-- Linhas 615 a 624:
615:                     ENDWITH
616: 
617:                     *-- Reconfigurar headers apos RecordSource (resetados pelo auto-bind)
618:                     loc_oGrid.Column1.Header1.Caption = "Setor"
619:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
620: 
621:                     THIS.FormatarGridLista(loc_oGrid)
622:                     loc_lResultado = .T.
623:                 ENDIF
624:             ENDIF

*-- Linhas 691 a 700:
691:                 .Column1.ControlSource = "cursor_4c_Localizacoes.Locals"
692:                 .Column2.ControlSource = "cursor_4c_Localizacoes.Descricaos"
693:             ENDWITH
694:             loc_oGrid.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
695:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
696:             loc_oGrid.Refresh()
697:         ENDIF
698: 
699:         THIS.AlternarPagina(2)
700:     ENDPROC

*-- Linhas 969 a 978:
969:                 .Column1.ControlSource = "cursor_4c_Localizacoes.Locals"
970:                 .Column2.ControlSource = "cursor_4c_Localizacoes.Descricaos"
971:             ENDWITH
972:             loc_oPg2.grd_4c_Localizacoes.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
973:             loc_oPg2.grd_4c_Localizacoes.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
974:             loc_oPg2.grd_4c_Localizacoes.Refresh()
975:         ENDIF
976:     ENDPROC
977: 
978:     *===========================================================================

*-- Linhas 1012 a 1027:
1012:             loc_oPg2.grd_4c_Localizacoes.ReadOnly = !par_lHabilitar
1013:         ENDIF
1014: 
1015:         IF PEMSTATUS(loc_oPg2, "cmd_4c_Apagar", 5)
1016:             loc_oPg2.cmd_4c_Apagar.Visible = (par_lHabilitar AND ;
1017:                 INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR"))
1018:         ENDIF
1019: 
1020:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1021:             IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1022:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
1023:                     (par_lHabilitar OR THIS.this_cModoAtual = "EXCLUIR")
1024:             ENDIF
1025:         ENDIF
1026:     ENDPROC
1027: 

*-- Linhas 1352 a 1385:
1352: 
1353:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1354:             loc_oCnt = loc_oPg1.cnt_4c_Botoes
1355:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
1356:                 loc_oCnt.cmd_4c_Incluir.Enabled = !loc_lEmEdicao
1357:             ENDIF
1358:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
1359:                 loc_oCnt.cmd_4c_Visualizar.Enabled = !loc_lEmEdicao
1360:             ENDIF
1361:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
1362:                 loc_oCnt.cmd_4c_Alterar.Enabled = !loc_lEmEdicao
1363:             ENDIF
1364:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
1365:                 loc_oCnt.cmd_4c_Excluir.Enabled = !loc_lEmEdicao
1366:             ENDIF
1367:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Buscar", 5)
1368:                 loc_oCnt.cmd_4c_Buscar.Enabled = !loc_lEmEdicao
1369:             ENDIF
1370:         ENDIF
1371: 
1372:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Saida", 5)
1373:             IF PEMSTATUS(loc_oPg1.cnt_4c_Saida, "cmd_4c_Encerrar", 5)
1374:                 loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = !loc_lEmEdicao
1375:             ENDIF
1376:         ENDIF
1377: 
1378:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1379:             IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1380:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
1381:                     INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "EXCLUIR")
1382:             ENDIF
1383:         ENDIF
1384:     ENDPROC
1385: 


### BO (C:\4c\projeto\app\classes\SETBO.prg):
*==============================================================================
* SETBO.prg
*
* Business Object para Cadastro de Setores
* Tabela principal: SigCdSet
* Tabela filha: SigCdSei (Localizacoes do Setor)
* Lookup: SigPrLcl (Localizacoes - codigo/descricao)
* Herda de: BusinessBase
*
* Colunas SigCdSet:
*   setores   char(10)  PK - Codigo do Setor
*   descrs    char(40)  Descricao do Setor
*
* Colunas SigCdSei:
*   cidchaves char(20)  PK - Chave unica
*   setores   char(10)  FK -> SigCdSet.setores
*   locals    char(10)  Codigo de Localizacao (FK -> SigPrLcl.codigos)
*==============================================================================

DEFINE CLASS SETBO AS BusinessBase

    *-- Propriedades da entidade principal (SigCdSet)
    this_cSetores = ""   && setores  char(10)  PK - Codigo do Setor
    this_cDescrs  = ""   && descrs   char(40)  Descricao do Setor

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdSet"
            THIS.this_cCampoChave = "Setores"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cSetores)
    ENDFUNC

    *==========================================================================
    * NovoRegistro - Prepara BO para INSERT
    *==========================================================================
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cSetores        = ""
        THIS.this_cDescrs         = ""
        THIS.this_lNovoRegistro   = .T.
    ENDPROC

    *==========================================================================
    * EditarRegistro - Prepara BO para UPDATE
    *==========================================================================
    PROCEDURE EditarRegistro()
        DODEFAULT()
        THIS.this_lNovoRegistro = .F.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSetores = TratarNulo(Setores, "C")
            THIS.this_cDescrs  = TratarNulo(Descrs,  "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT em SigCdSet para preencher cursor_4c_Dados
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT Setores, Descrs" + ;
                       " FROM SigCdSet" + ;
                       " ORDER BY Setores"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") >= 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar Setores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo do setor
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT Setores, Descrs" + ;
                       " FROM SigCdSet" + ;
                       " WHERE Setores = " + EscaparSQL(ALLTRIM(par_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.CarregarPorCodigo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarLocalizacoes - Carrega localizacoes do setor em cursor
    *   Enriquece Locals com Descricaos de SigPrLcl
    *   Resultado: cursor_4c_Localizacoes (Setores, Locals, Descricaos)
    *==========================================================================
    FUNCTION CarregarLocalizacoes(par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Localizacoes")
                USE IN cursor_4c_Localizacoes
            ENDIF

            loc_cSQL = "SELECT a.Setores, a.Locals," + ;
                       " ISNULL(b.Descricaos, SPACE(20)) AS Descricaos" + ;
                       " FROM SigCdSei a" + ;
                       " LEFT JOIN SigPrLcl b ON b.Codigos = a.Locals" + ;
                       " WHERE a.Setores = " + EscaparSQL(ALLTRIM(par_cSetores)) + ;
                       " ORDER BY a.Locals"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Localizacoes")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Localizacoes") AND RECCOUNT("cursor_4c_Localizacoes") >= 0
                    GO TOP IN cursor_4c_Localizacoes
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar localizacoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.CarregarLocalizacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarLocalizacaoDuplicada - Verifica se Locals ja existe no setor
    *==========================================================================
    FUNCTION ValidarLocalizacaoDuplicada(par_cLocals, par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.
        TRY
            IF USED("cursor_4c_VldLocal")
                USE IN cursor_4c_VldLocal
            ENDIF

            loc_cSQL = "SELECT COUNT(1) AS Qt" + ;
                       " FROM SigCdSei" + ;
                       " WHERE Locals  = " + EscaparSQL(ALLTRIM(par_cLocals)) + ;
                       " AND   Setores = " + EscaparSQL(ALLTRIM(par_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldLocal")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldLocal") > 0
                SELECT cursor_4c_VldLocal
                loc_lDuplicado = (Qt > 0)
            ENDIF

            IF USED("cursor_4c_VldLocal")
                USE IN cursor_4c_VldLocal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.ValidarLocalizacaoDuplicada")
        ENDTRY
        RETURN loc_lDuplicado
    ENDFUNC

    *==========================================================================
    * ValidarLocalizacaoOutroSetor - Verifica se Locals pertence a outro setor
    *==========================================================================
    FUNCTION ValidarLocalizacaoOutroSetor(par_cLocals, par_cSetoresAtual)
        LOCAL loc_cSQL, loc_nResult, loc_cSetorExistente
        loc_cSetorExistente = ""
        TRY
            IF USED("cursor_4c_VldSetor")
                USE IN cursor_4c_VldSetor
            ENDIF

            loc_cSQL = "SELECT TOP 1 Setores" + ;
                       " FROM SigCdSei" + ;
                       " WHERE Locals  = " + EscaparSQL(ALLTRIM(par_cLocals)) + ;
                       " AND   Setores <> " + EscaparSQL(ALLTRIM(par_cSetoresAtual))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldSetor")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldSetor") > 0
                SELECT cursor_4c_VldSetor
                loc_cSetorExistente = ALLTRIM(Setores)
            ENDIF

            IF USED("cursor_4c_VldSetor")
                USE IN cursor_4c_VldSetor
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.ValidarLocalizacaoOutroSetor")
        ENDTRY
        RETURN loc_cSetorExistente
    ENDFUNC

    *==========================================================================
    * BuscarLocalizacao - Lookup em SigPrLcl pelo codigo
    *   Resultado: cursor_4c_BuscaLocal (Codigos, Descricaos)
    *==========================================================================
    FUNCTION BuscarLocalizacao(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaLocal")
                USE IN cursor_4c_BuscaLocal
            ENDIF

            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl ORDER BY Codigos"
            ELSE
                loc_cSQL = "SELECT Codigos, Descricaos" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaLocal")
                TABLEREVERT(.T., "cursor_4c_BuscaLocal")
                USE IN cursor_4c_BuscaLocal
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaLocal")

            IF loc_nResult >= 0
                IF USED("cursor_4c_BuscaLocal") AND RECCOUNT("cursor_4c_BuscaLocal") >= 0
                    GO TOP IN cursor_4c_BuscaLocal
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.BuscarLocalizacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * VerificarSetorExistente - Verifica se codigo de setor ja existe
    *==========================================================================
    FUNCTION VerificarSetorExistente(par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.
        TRY
            IF USED("cursor_4c_VldSet")
                USE IN cursor_4c_VldSet
            ENDIF

            loc_cSQL = "SELECT TOP 1 Setores FROM SigCdSet" + ;
                       " WHERE Setores = " + EscaparSQL(ALLTRIM(par_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldSet")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldSet") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_VldSet")
                USE IN cursor_4c_VldSet
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.VerificarSetorExistente")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *==========================================================================
    * Inserir (PROTECTED) - INSERT em SigCdSet
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdSet (Setores, Descrs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cSetores)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescrs))  + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar (PROTECTED) - UPDATE em SigCdSet
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdSet SET" + ;
                       " Descrs = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs)) + ;
                       " WHERE Setores = " + EscaparSQL(ALLTRIM(THIS.this_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao (PROTECTED) - DELETE em SigCdSet e SigCdSei
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdSei WHERE Setores = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cSetores))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdSet WHERE Setores = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cSetores))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir localiza" + CHR(231) + CHR(245) + "es do Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarLocalizacoes - Sincroniza SigCdSei com cursor de localizacoes
    *   par_cSetores    - Codigo do setor
    *   par_cCursorSei  - Nome do cursor com registros a salvar (Locals, Descricaos)
    *==========================================================================
    FUNCTION SalvarLocalizacoes(par_cSetores, par_cCursorSei)
        LOCAL loc_cSQL, loc_lSucesso, loc_cLocals, loc_cIdChave
        loc_lSucesso = .F.
        TRY
            *-- Delete all existing localizations for the setor (replace-all approach)
            *-- This ensures removed/changed rows are cleaned from SigCdSei
            loc_cSQL = "DELETE FROM SigCdSei WHERE Setores = " + EscaparSQL(ALLTRIM(par_cSetores))
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Insert all non-empty locals from cursor
            IF USED(par_cCursorSei) AND RECCOUNT(par_cCursorSei) > 0
                SELECT (par_cCursorSei)
                SCAN FOR !EMPTY(ALLTRIM(Locals))
                    loc_cLocals  = ALLTRIM(Locals)
                    loc_cIdChave = LOWER(SYS(2015)) + TRANSFORM(SECONDS(), "@L")
                    loc_cSQL = "INSERT INTO SigCdSei (cidchaves, Setores, Locals)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cIdChave) + ", " + ;
                               EscaparSQL(ALLTRIM(par_cSetores)) + ", " + ;
                               EscaparSQL(loc_cLocals) + ")"
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.SalvarLocalizacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

