# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTPE.Pagina.Lista): Top original=104 vs migrado 'lbl_4c_Label1' Top=138 (diff=34px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTPE.Pagina.Lista): Left original=42 vs migrado 'lbl_4c_Label1' Left=184 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTPE.Pagina.Lista): Top original=104 vs migrado 'lbl_4c_Label2' Top=162 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTPE.Pagina.Lista): Left original=369 vs migrado 'lbl_4c_Label2' Left=158 (diff=211px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTpe.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1305 linhas total):

*-- Linhas 7 a 21:
7: *   PageFrame (Page1=Lista / Page2=Dados) + containers principais vazios.
8: * FASE 4/8 - Form - Grid e Botoes CRUD (Page1):
9: *   cnt_4c_Botoes com 5 botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar)
10: *   + cnt_4c_Saida com cmd_4c_Encerrar (padrao canonico) + grd_4c_Lista (4
11: *   colunas: ntipos/cetiquetas/nsituas/cordems) + CarregarLista()/AlternarPagina()
12: *   (PUBLIC - CLAUDE.md #3: TesteAutomatico.prg chama direto de fora da classe).
13: * FASE 5/8 - Form - Campos Principais Page2 (Parte 1):
14: *   lbl_4c_Label1+txt_4c_NTipos (Tipo/ntipos), lbl_4c_Label2+txt_4c_CEtiquetas
15: *   (Descricao/cetiquetas), lbl_4c_Label22+obj_4c_Opt_nSituas (Situacao/nsituas).
16: *   Compensacao +29 (PageFrame.Top=-29) aplicada aos Tops originais do SCX.
17: * FASE 6/8 - Form - Campos Restantes e Lookups:
18: *   Ordem/EtiquetasEspeciais/Observacao (cobs/dobs) + lookup fwBuscaExt->SigCdObs
19: *   (ValidarCobs/AbrirLookupObs/CobsKeyPress) + validacao ValidarCOrdems.
20: * FASE 7/8 - Form - Eventos Principais:
21: *   BINDEVENT dos 4 botoes CRUD de cnt_4c_Botoes + BtnIncluirClick/

*-- Linhas 75 a 86:
75:                     "FormTpe.InicializarForm")
76:             ELSE
77:                 THIS.ConfigurarPageFrame()
78:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
79:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
80:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
81:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
82:                 THIS.pgf_4c_Paginas.Visible = .T.
83:                 THIS.pgf_4c_Paginas.ActivePage = 1
84:                 THIS.this_cModoAtual = "LISTA"
85:                 THIS.CarregarLista()
86: 

*-- Linhas 106 a 179:
106: 
107:         WITH THIS.pgf_4c_Paginas
108:             .PageCount = 2
109:             .Top       = -29
110:             .Left      = 0
111:             .Width     = THIS.Width
112:             .Height    = THIS.Height + 29
113:             .Tabs      = .F.
114:             .Visible   = .T.
115: 
116:             .Page1.Caption   = "Lista"
117:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118:             .Page1.BackColor = RGB(255, 255, 255)
119: 
120:             .Page2.Caption   = "Dados"
121:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
122:             .Page2.BackColor = RGB(255, 255, 255)
123:         ENDWITH
124: 
125:         THIS.ConfigurarPaginaLista()
126:         THIS.ConfigurarPaginaDados()
127:     ENDPROC
128: 
129:     *===========================================================================
130:     * ConfigurarPaginaLista - Estrutura completa de Page1 (Lista)
131:     * Cabecalho (regra #11) + cnt_4c_Botoes (5 botoes CRUD) + cnt_4c_Saida
132:     * (cmd_4c_Encerrar canonico) + grd_4c_Lista (4 colunas). BINDEVENT dos
133:     * botoes fica para Fase 7-8, quando os metodos Btn*Click existirem.
134:     *===========================================================================
135:     PROTECTED PROCEDURE ConfigurarPaginaLista()
136:         LOCAL loc_oPagina
137:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
138: 
139:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
140: 
141:         *-- Container Cabecalho (cntSombra no legado)
142:         *-- Original: Top=2 (default da classe). Com compensacao +29: Top=31
143:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
144:         WITH loc_oPagina.cnt_4c_Cabecalho
145:             .Top         = 31
146:             .Left        = 0
147:             .Width       = THIS.Width
148:             .Height      = 80
149:             .BackColor   = RGB(100, 100, 100)
150:             .BorderWidth = 0
151:             .Visible     = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
156:             .Caption   = THIS.Caption
157:             .Top       = 15
158:             .Left      = 10
159:             .Width     = 769
160:             .Height    = 40
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16
163:             .FontBold  = .T.
164:             .ForeColor = RGB(0, 0, 0)
165:             .BackStyle = 0
166:             .AutoSize  = .F.
167:             .Visible   = .T.
168:         ENDWITH
169: 
170:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
171:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
172:             .Caption   = THIS.Caption
173:             .Top       = 18
174:             .Left      = 10
175:             .Width     = 769
176:             .Height    = 46
177:             .FontName  = "Tahoma"
178:             .FontSize  = 16
179:             .FontBold  = .T.

*-- Linhas 187 a 211:
187:         *-- Canonico: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
188:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
189:         WITH loc_oPagina.cnt_4c_Botoes
190:             .Top         = 29
191:             .Left        = 542
192:             .Width       = 390
193:             .Height      = 85
194:             .BackStyle   = 0
195:             .BorderWidth = 0
196:             .Visible     = .T.
197:         ENDWITH
198: 
199:         *-- Botao Incluir (legado Grupo_op.Inserir: Left=5)
200:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
201:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
202:             .Caption         = "Incluir"
203:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
204:             .PicturePosition = 13
205:             .Top             = 5
206:             .Left            = 5
207:             .Width           = 75
208:             .Height          = 75
209:             .FontName        = "Tahoma"
210:             .FontBold        = .T.
211:             .FontItalic      = .T.

*-- Linhas 221 a 235:
221:         ENDWITH
222: 
223:         *-- Botao Visualizar (legado Grupo_op.Consultar: Left=80)
224:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
225:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
226:             .Caption         = "Visualizar"
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
228:             .PicturePosition = 13
229:             .Top             = 5
230:             .Left            = 80
231:             .Width           = 75
232:             .Height          = 75
233:             .FontName        = "Tahoma"
234:             .FontBold        = .T.
235:             .FontItalic      = .T.

*-- Linhas 245 a 259:
245:         ENDWITH
246: 
247:         *-- Botao Alterar (legado Grupo_op.Alterar: Left=155)
248:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
249:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
250:             .Caption         = "Alterar"
251:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
252:             .PicturePosition = 13
253:             .Top             = 5
254:             .Left            = 155
255:             .Width           = 75
256:             .Height          = 75
257:             .FontName        = "Tahoma"
258:             .FontBold        = .T.
259:             .FontItalic      = .T.

*-- Linhas 269 a 283:
269:         ENDWITH
270: 
271:         *-- Botao Excluir (legado Grupo_op.Excluir: Left=230)
272:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
273:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
274:             .Caption         = "Excluir"
275:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
276:             .PicturePosition = 13
277:             .Top             = 5
278:             .Left            = 230
279:             .Width           = 75
280:             .Height          = 75
281:             .FontName        = "Tahoma"
282:             .FontBold        = .T.
283:             .FontItalic      = .T.

*-- Linhas 293 a 307:
293:         ENDWITH
294: 
295:         *-- Botao Buscar (legado Grupo_op.procurar: Left=305)
296:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
297:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
298:             .Caption         = "Buscar"
299:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
300:             .PicturePosition = 13
301:             .Top             = 5
302:             .Left            = 305
303:             .Width           = 75
304:             .Height          = 75
305:             .FontName        = "Tahoma"
306:             .FontBold        = .T.
307:             .FontItalic      = .T.

*-- Linhas 317 a 351:
317:         ENDWITH
318: 
319:         *-- BINDEVENT dos 5 botoes CRUD principais + Encerrar
320:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
321:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
322:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
323:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
324:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
325: 
326:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
327:         *-- Legado: Grupo_Saida.Left=719, Top=-1 / Sair.Caption default. Canonico: Left=917, Width=90
328:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
329:         WITH loc_oPagina.cnt_4c_Saida
330:             .Top         = 29
331:             .Left        = 917
332:             .Width       = 90
333:             .Height      = 85
334:             .BackStyle   = 0
335:             .BorderWidth = 0
336:             .Visible     = .T.
337:         ENDWITH
338: 
339:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
340:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
341:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
342:             .Caption         = "Encerrar"
343:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
344:             .PicturePosition = 13
345:             .Top             = 5
346:             .Left            = 5
347:             .Width           = 75
348:             .Height          = 75
349:             .FontName        = "Tahoma"
350:             .FontBold        = .T.
351:             .FontItalic      = .T.

*-- Linhas 360 a 379:
360:             .Visible         = .T.
361:         ENDWITH
362: 
363:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
364: 
365:         *-- Grid de listagem (Grade no legado)
366:         *-- Legado: pColuna(ntipos,Tipo,50) + pColuna(cetiquetas,Descricao,280) +
367:         *--         pColuna(nsituas,Situacao,50) + pColuna(cordems,Ordem,50)
368:         *-- Posicao canonica (framework_frmcadastro_layout.md): Top=117, Left=26, Width=890
369:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
370:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
371:         loc_oPagina.grd_4c_Lista.ColumnCount = 4
372:         WITH loc_oPagina.grd_4c_Lista
373:             .Top                = 117
374:             .Left               = 26
375:             .Width              = 890
376:             .Height             = 498
377:             .FontName           = "Verdana"
378:             .FontSize           = 8
379:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 392 a 406:
392:         ENDWITH
393: 
394:         loc_oPagina.grd_4c_Lista.Column1.Width = 60
395:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption = "Tipo"
396:         loc_oPagina.grd_4c_Lista.Column2.Width = 550
397:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
398:         loc_oPagina.grd_4c_Lista.Column3.Width = 130
399:         loc_oPagina.grd_4c_Lista.Column3.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
400:         loc_oPagina.grd_4c_Lista.Column4.Width = 100
401:         loc_oPagina.grd_4c_Lista.Column4.Header1.Caption = "Ordem"
402: 
403:         THIS.TornarControlesVisiveis(loc_oPagina)
404:     ENDPROC
405: 
406:     *===========================================================================

*-- Linhas 417 a 454:
417:         *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
418:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
419:         WITH loc_oPagina.cnt_4c_Cabecalho
420:             .Top           = 29
421:             .Left          = 0
422:             .Width         = THIS.Width
423:             .Height        = 80
424:             .BackColor     = RGB(100, 100, 100)
425:             .BorderWidth   = 0
426:             .SpecialEffect = 0
427:             .Visible       = .T.
428: 
429:             .AddObject("lbl_4c_Sombra", "Label")
430:             WITH .lbl_4c_Sombra
431:                 .Caption   = THIS.Caption
432:                 .Top       = 15
433:                 .Left      = 10
434:                 .Width     = THIS.Width
435:                 .Height    = 40
436:                 .FontName  = "Tahoma"
437:                 .FontSize  = 16
438:                 .FontBold  = .T.
439:                 .ForeColor = RGB(0, 0, 0)
440:                 .BackStyle = 0
441:                 .AutoSize  = .F.
442:                 .Visible   = .T.
443:             ENDWITH
444: 
445:             .AddObject("lbl_4c_Titulo", "Label")
446:             WITH .lbl_4c_Titulo
447:                 .Caption   = THIS.Caption
448:                 .Top       = 18
449:                 .Left      = 10
450:                 .Width     = THIS.Width
451:                 .Height    = 46
452:                 .FontName  = "Tahoma"
453:                 .FontSize  = 16
454:                 .FontBold  = .T.

*-- Linhas 464 a 488:
464:         *-- VAZIO nesta fase: botoes Confirmar/Cancelar entram em fase posterior (campos+eventos)
465:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
466:         WITH loc_oPagina.cnt_4c_BotoesAcao
467:             .Top         = 33
468:             .Left        = 842
469:             .Width       = 160
470:             .Height      = 85
471:             .BackStyle = 1
472:             .BackColor   = RGB(255, 255, 255)
473:             .BorderWidth = 0
474:             .Visible     = .T.
475:         ENDWITH
476: 
477:         *-- Label "Tipo :" (Say1 legado: Left=184, Top=109, ForeColor=0,0,0)
478:         *-- Compensacao PageFrame.Top=-29: 109+29=138
479:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
480:         WITH loc_oPagina.lbl_4c_Label1
481:             .Caption   = "Tipo :"
482:             .Left      = 184
483:             .Top       = 138
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .ForeColor = RGB(0, 0, 0)
487:             .BackStyle = 0
488:             .AutoSize  = .T.

*-- Linhas 494 a 520:
494:         *-- MaxLength=3, Left=220, Top=106, Width=31; Height=23 como Get_EtqAtivas/Get_MaxEtqs)
495:         loc_oPagina.AddObject("txt_4c_NTipos", "TextBox")
496:         WITH loc_oPagina.txt_4c_NTipos
497:             .Left        = 220
498:             .Top         = 135
499:             .Width       = 31
500:             .Height      = 23
501:             .InputMask   = "999"
502:             .MaxLength   = 3
503:             .Value       = 0
504:             .FontName    = "Tahoma"
505:             .FontSize    = 8
506:             .ForeColor   = RGB(90, 90, 90)
507:             .Visible     = .T.
508:         ENDWITH
509: 
510:         *-- Label "Descricao :" (Say2 legado: Left=158, Top=133, ForeColor=0,0,0)
511:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
512:         WITH loc_oPagina.lbl_4c_Label2
513:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
514:             .Left      = 158
515:             .Top       = 162
516:             .FontName  = "Tahoma"
517:             .FontSize  = 8
518:             .ForeColor = RGB(0, 0, 0)
519:             .BackStyle = 0
520:             .AutoSize  = .T.

*-- Linhas 526 a 551:
526:         *-- Left=220, Top=131, Width=220; MaxLength=30 conforme schema)
527:         loc_oPagina.AddObject("txt_4c_CEtiquetas", "TextBox")
528:         WITH loc_oPagina.txt_4c_CEtiquetas
529:             .Left        = 220
530:             .Top         = 160
531:             .Width       = 220
532:             .Height      = 23
533:             .MaxLength   = 30
534:             .Value       = ""
535:             .FontName    = "Tahoma"
536:             .FontSize    = 8
537:             .ForeColor   = RGB(90, 90, 90)
538:             .Visible     = .T.
539:         ENDWITH
540: 
541:         *-- Label "Situacao :" (Say22 legado: Left=163, Top=158, ForeColor=0,0,0)
542:         loc_oPagina.AddObject("lbl_4c_Label22", "Label")
543:         WITH loc_oPagina.lbl_4c_Label22
544:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
545:             .Left      = 163
546:             .Top       = 187
547:             .FontName  = "Tahoma"
548:             .FontSize  = 8
549:             .ForeColor = RGB(0, 0, 0)
550:             .BackStyle = 0
551:             .AutoSize  = .T.

*-- Linhas 559 a 607:
559:         loc_oPagina.AddObject("obj_4c_Opt_nSituas", "OptionGroup")
560:         WITH loc_oPagina.obj_4c_Opt_nSituas
561:             .ButtonCount   = 2
562:             .Left          = 220
563:             .Top           = 185
564:             .Width         = 140
565:             .Height        = 20
566:             .BackStyle     = 0
567:             .BorderStyle   = 0
568:             .SpecialEffect = 0
569:             .Value         = 0
570:             .Visible       = .T.
571:         ENDWITH
572: 
573:         WITH loc_oPagina.obj_4c_Opt_nSituas.Buttons(1)
574:             .Caption   = "\<Ativa"
575:             .Value     = 0
576:             .Left      = 5
577:             .Top       = 2
578:             .AutoSize  = .T.
579:             .BackStyle = 0
580:             .FontName  = "Tahoma"
581:             .FontSize  = 8
582:             .ForeColor = RGB(0, 0, 0)
583:         ENDWITH
584: 
585:         WITH loc_oPagina.obj_4c_Opt_nSituas.Buttons(2)
586:             .Caption   = "I\<nativa"
587:             .Value     = 1
588:             .Left      = 75
589:             .Top       = 2
590:             .AutoSize  = .T.
591:             .BackStyle = 0
592:             .FontName  = "Tahoma"
593:             .FontSize  = 8
594:             .ForeColor = RGB(0, 0, 0)
595:         ENDWITH
596: 
597:         *-- Label "Ordem :" (Say3 legado: Left=172, Top=182, ForeColor=0,0,0)
598:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
599:         WITH loc_oPagina.lbl_4c_Label3
600:             .Caption   = "Ordem :"
601:             .Left      = 172
602:             .Top       = 211
603:             .FontName  = "Tahoma"
604:             .FontSize  = 8
605:             .ForeColor = RGB(0, 0, 0)
606:             .BackStyle = 0
607:             .AutoSize  = .T.

*-- Linhas 613 a 639:
613:         *-- Left=220, Top=179, Width=31, MaxLength=3)
614:         loc_oPagina.AddObject("txt_4c_COrdems", "TextBox")
615:         WITH loc_oPagina.txt_4c_COrdems
616:             .Left        = 220
617:             .Top         = 208
618:             .Width       = 31
619:             .Height      = 23
620:             .InputMask   = "999"
621:             .MaxLength   = 3
622:             .Value       = ""
623:             .FontName    = "Tahoma"
624:             .FontSize    = 8
625:             .ForeColor   = RGB(90, 90, 90)
626:             .Visible     = .T.
627:         ENDWITH
628: 
629:         *-- Label "Etiquetas Especiais :" (Say4 legado: Left=113, Top=210, ForeColor=0,0,0)
630:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
631:         WITH loc_oPagina.lbl_4c_Label4
632:             .Caption   = "Etiquetas Especiais :"
633:             .Left      = 113
634:             .Top       = 239
635:             .FontName  = "Tahoma"
636:             .FontSize  = 8
637:             .ForeColor = RGB(0, 0, 0)
638:             .BackStyle = 0
639:             .AutoSize  = .T.

*-- Linhas 649 a 658:
649:         *-- cmbetqesp.ListItemId = 1 (equivalente ao ListIndex no fwcombo).
650:         loc_oPagina.AddObject("cbo_4c_Cmbetqesp", "ComboBox")
651:         WITH loc_oPagina.cbo_4c_Cmbetqesp
652:             .Left          = 220
653:             .Top           = 236
654:             .Width         = 151
655:             .Height        = 24
656:             .Style         = 2
657:             .RowSourceType = 1
658:             .RowSource     = "NENHUMA,TAG MODELO 1"

*-- Linhas 664 a 676:
664:         loc_oPagina.cbo_4c_Cmbetqesp.ListIndex = 1
665: 
666:         *-- Label "Observacao :" (Say5 legado: Left=146, Top=239, ForeColor=0,0,0)
667:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
668:         WITH loc_oPagina.lbl_4c_Label5
669:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
670:             .Left      = 146
671:             .Top       = 268
672:             .FontName  = "Tahoma"
673:             .FontSize  = 8
674:             .ForeColor = RGB(0, 0, 0)
675:             .BackStyle = 0
676:             .AutoSize  = .T.

*-- Linhas 683 a 692:
683:         *-- (codigos/descrs), transcrito via ValidarCobs()/AbrirLookupObs().
684:         loc_oPagina.AddObject("txt_4c_Cobs", "TextBox")
685:         WITH loc_oPagina.txt_4c_Cobs
686:             .Left        = 220
687:             .Top         = 265
688:             .Width       = 31
689:             .Height      = 23
690:             .InputMask   = "999"
691:             .MaxLength   = 3
692:             .Value       = 0

*-- Linhas 700 a 709:
700:         *-- When retorna .F. - nunca recebe foco/edicao. Left=252, Top=236, Width=220)
701:         loc_oPagina.AddObject("txt_4c_Dobs", "TextBox")
702:         WITH loc_oPagina.txt_4c_Dobs
703:             .Left        = 252
704:             .Top         = 265
705:             .Width       = 220
706:             .Height      = 23
707:             .Value       = ""
708:             .ReadOnly    = .T.
709:             .TabStop     = .F.

*-- Linhas 724 a 738:
724:         BINDEVENT(loc_oPagina.txt_4c_Cobs, "DblClick", THIS, "AbrirLookupObs")
725: 
726:         *-- Container BotoesAcao - Confirmar/Cancelar (padrao canonico)
727:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
728:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
729:             .Caption         = "Confirmar"
730:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
731:             .PicturePosition = 13
732:             .Top             = 5
733:             .Left            = 5
734:             .Width           = 75
735:             .Height          = 75
736:             .FontName        = "Tahoma"
737:             .FontBold        = .T.
738:             .FontItalic      = .T.

*-- Linhas 747 a 761:
747:             .Visible         = .T.
748:         ENDWITH
749: 
750:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
751:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
752:             .Caption         = "Encerrar"
753:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
754:             .PicturePosition = 13
755:             .Top             = 5
756:             .Left            = 80
757:             .Width           = 75
758:             .Height          = 75
759:             .FontName        = "Tahoma"
760:             .FontBold        = .T.
761:             .FontItalic      = .T.

*-- Linhas 770 a 779:
770:             .Visible         = .T.
771:         ENDWITH
772: 
773:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
774:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
775: 
776:         THIS.TornarControlesVisiveis(loc_oPagina)
777:     ENDPROC
778: 
779:     *===========================================================================

*-- Linhas 942 a 950:
942:     * Transcrito do legado: Get_nTipos.When = InList(pcEscolha,'INSERIR','PROCURAR')
943:     * (Tipo so editavel na INCLUSAO); Get_cEtiquetas.When = InList('INSERIR',
944:     * 'ALTERAR') (demais campos editaveis em INCLUIR/ALTERAR, bloqueados em
945:     * VISUALIZAR). cmd_4c_Confirmar acompanha o mesmo flag (nunca habilitado
946:     * em modo VISUALIZAR).
947:     *===========================================================================
948:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
949:         LOCAL loc_oPagina, loc_lHabilitarCodigo
950: 

*-- Linhas 959 a 967:
959:         loc_oPagina.txt_4c_Cobs.Enabled        = par_lHabilitar
960:         loc_oPagina.txt_4c_Dobs.Enabled        = .F.
961: 
962:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
963:     ENDPROC
964: 
965:     *===========================================================================
966:     * BtnIncluirClick - Botao Incluir (Page1)
967:     * PUBLIC (CLAUDE.md regra #3): TesteAutomatico.prg chama direto de fora

*-- Linhas 1106 a 1114:
1106:     ENDPROC
1107: 
1108:     *===========================================================================
1109:     * BtnEncerrarClick - Fecha o formulario (cnt_4c_Saida.cmd_4c_Encerrar)
1110:     * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3 / Problema 17)
1111:     *===========================================================================
1112:     PROCEDURE BtnEncerrarClick()
1113:         THIS.Release()
1114:     ENDPROC

*-- Linhas 1149 a 1169:
1149:     *===========================================================================
1150:     * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar conforme this_cModoAtual
1151:     * Confirmar so fica habilitado em INCLUIR/ALTERAR (nunca em VISUALIZAR -
1152:     * ver Problema 40/CLAUDE.md sobre cmd_4c_Confirmar.Enabled por modo).
1153:     *===========================================================================
1154:     PROCEDURE AjustarBotoesPorModo()
1155:         LOCAL loc_oPagina, loc_lEditando
1156:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1157:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1158: 
1159:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1160:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1161:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
1162:             ENDIF
1163:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1164:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1165:             ENDIF
1166:         ENDIF
1167:     ENDPROC
1168: 
1169:     *===========================================================================

*-- Linhas 1200 a 1211:
1200:                     loc_oGrid.Column3.Width = 130
1201:                     loc_oGrid.Column4.Width = 100
1202: 
1203:                     loc_oGrid.Column1.Header1.Caption = "Tipo"
1204:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1205:                     loc_oGrid.Column3.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
1206:                     loc_oGrid.Column4.Header1.Caption = "Ordem"
1207: 
1208:                     *-- Transcrito do legado (SIGCDTPE.Init):
1209:                     *-- .SetAll('DynamicForeColor','RGB(Iif(crSigCdTpe.nSituas # 1, 255, 0),0,0)','Column')
1210:                     loc_oGrid.SetAll("DynamicForeColor", ;
1211:                         "RGB(IIF(cursor_4c_Dados.nsituas # 1, 255, 0), 0, 0)", "Column")


### BO (C:\4c\projeto\app\classes\TpeBO.prg):
*====================================================================
* TpeBO.prg
*
* Business Object para Cadastro de Tipos de Etiquetas de Produto
* Tabela: SigCdTpe
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TpeBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdTpe)
    this_nTipos      = 0     && ntipos numeric(3,0) - PK
    this_cEtiquetas  = ""    && cetiquetas char(30)
    this_nSituas     = 0     && nsituas numeric(1,0) - 0=Ativa, 1=Inativa
    this_cOrdems     = ""    && cordems char(3)
    this_nTpEspes    = 0     && tpespes numeric(3,0) - NENHUMA/TAG MODELO 1
    this_nCodObs     = 0     && codobs numeric(3,0) - FK SigCdObs
    this_nPadrao     = 0     && npadrao numeric(1,0) - NOT NULL, ausente na tela

    *-- Propriedade auxiliar somente-exibicao (nao persistida em SigCdTpe)
    this_cDescObs    = ""    && SigCdObs.descrs referente a this_nCodObs

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdTpe"
            THIS.this_cCampoChave = "ntipos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TpeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria (ntipos) para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nTipos)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nTipos     = TratarNulo(ntipos,     "N")
                THIS.this_cEtiquetas = TratarNulo(cetiquetas, "C")
                THIS.this_nSituas    = TratarNulo(nsituas,    "N")
                THIS.this_cOrdems    = TratarNulo(cordems,    "C")
                THIS.this_nTpEspes   = TratarNulo(tpespes,    "N")
                THIS.this_nCodObs    = TratarNulo(codobs,     "N")
                THIS.this_nPadrao    = TratarNulo(npadrao,    "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TpeBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Transcrito do legado (Pagina.Dados.Grupo_Salva.Salva.Click):
    *   - Descricao da Etiqueta e obrigatoria
    *   - Na INCLUSAO, ntipos e cetiquetas nao podem se repetir (ChkRegister)
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cEtiquetas))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da Etiqueta " + CHR(233) + ;
                " informa" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarTipoExistente(THIS.this_nTipos)
                MsgAviso("Tipo de Etiqueta j" + CHR(225) + " cadastrado.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarEtiquetaExistente(THIS.this_cEtiquetas)
                MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Permitido Etiquetas com a mesma descri" + ;
                    CHR(231) + CHR(227) + "o.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * AntesDeGravar - Normaliza cOrdems antes de gravar
    * Transcrito do legado: Replace cOrdems With PadL(AllTrim(Str(Val(cOrdems))),3)
    *====================================================================
    PROTECTED PROCEDURE AntesDeGravar()
        IF !EMPTY(ALLTRIM(THIS.this_cOrdems))
            THIS.this_cOrdems = PADL(ALLTRIM(STR(VAL(THIS.this_cOrdems))), 3)
        ENDIF
        RETURN .T.
    ENDPROC

    *====================================================================
    * VerificarTipoExistente - Verifica se ntipos ja existe no banco
    *====================================================================
    PROCEDURE VerificarTipoExistente(par_nTipos)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdTpe" + ;
                " WHERE ntipos = " + FormatarNumeroSQL(par_nTipos, 0)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTipo")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkTipo")
                SELECT cursor_4c_ChkTipo
                loc_lExiste = (cursor_4c_ChkTipo.qtd > 0)
                USE IN cursor_4c_ChkTipo
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar tipo:" + CHR(13) + loException.Message, "TpeBO.VerificarTipoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * VerificarEtiquetaExistente - Verifica se cetiquetas ja existe no banco
    *====================================================================
    PROCEDURE VerificarEtiquetaExistente(par_cEtiquetas)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdTpe" + ;
                " WHERE cetiquetas = " + EscaparSQL(par_cEtiquetas)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkEtiq")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkEtiq")
                SELECT cursor_4c_ChkEtiq
                loc_lExiste = (cursor_4c_ChkEtiq.qtd > 0)
                USE IN cursor_4c_ChkEtiq
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar etiqueta:" + CHR(13) + loException.Message, "TpeBO.VerificarEtiquetaExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdTpe
    * Todas as colunas sao NOT NULL - nenhuma pode ficar de fora do INSERT
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdTpe (ntipos, cetiquetas, nsituas, cordems, tpespes, codobs, npadrao)
                VALUES (
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<EscaparSQL(THIS.this_cEtiquetas)>>,
                    <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    <<EscaparSQL(THIS.this_cOrdems)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpEspes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodObs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPadrao, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo de etiqueta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TpeBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdTpe
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdTpe
                SET cetiquetas = <<EscaparSQL(THIS.this_cEtiquetas)>>,
                    nsituas    = <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    cordems    = <<EscaparSQL(THIS.this_cOrdems)>>,
                    tpespes    = <<FormatarNumeroSQL(THIS.this_nTpEspes, 0)>>,
                    codobs     = <<FormatarNumeroSQL(THIS.this_nCodObs, 0)>>,
                    npadrao    = <<FormatarNumeroSQL(THIS.this_nPadrao, 0)>>
                WHERE ntipos = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo de etiqueta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TpeBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdTpe
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdTpe WHERE ntipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo de etiqueta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TpeBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com ntipos, cetiquetas, nsituas, cordems
    * (mesmas colunas usadas na grade do legado: pColuna ntipos/cetiquetas/nsituas/cordems)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (ntipos N(3,0), cetiquetas C(30), nsituas N(1,0), cordems C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT ntipos, cetiquetas, nsituas, cordems FROM SigCdTpe"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY ntipos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar tipos de etiquetas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TpeBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (ntipos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT ntipos, cetiquetas, nsituas, cordems, tpespes, codobs, npadrao" + ;
                " FROM SigCdTpe WHERE ntipos = " + FormatarNumeroSQL(par_nCodigo, 0)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Tipo de Etiqueta n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar tipo de etiqueta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TpeBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarDescricaoObs - Retorna descrs de SigCdObs para exibicao (dobs)
    * Transcrito do legado (Grupo_op.Click):
    *   select descrs from SigCdObs where codigos = ?crSigCdTpe.codobs
    *====================================================================
    PROCEDURE BuscarDescricaoObs(par_nCodObs)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF VARTYPE(par_nCodObs) = "N" AND par_nCodObs > 0
            TRY
                loc_cSQL = "SELECT descrs FROM SigCdObs WHERE codigos = " + FormatarNumeroSQL(par_nCodObs, 0)

                IF USED("cursor_4c_DescObs")
                    USE IN cursor_4c_DescObs
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescObs")

                IF loc_nResultado >= 0 AND USED("cursor_4c_DescObs") AND RECCOUNT("cursor_4c_DescObs") > 0
                    loc_cDescricao = ALLTRIM(TratarNulo(cursor_4c_DescObs.descrs, "C"))
                ENDIF

                IF USED("cursor_4c_DescObs")
                    USE IN cursor_4c_DescObs
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao buscar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "TpeBO.BuscarDescricaoObs")
            ENDTRY
        ENDIF

        THIS.this_cDescObs = loc_cDescricao
        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE

