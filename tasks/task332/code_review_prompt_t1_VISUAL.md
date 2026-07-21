# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-WITH] Bloco WITH THIS.grd_4c_Listas define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Listas.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Itens define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Itens.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSlp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (963 linhas total):

*-- Linhas 29 a 49:
29:     this_cModoAtual       = ""
30:     this_cMensagemErro    = ""
31: 
32:     *-- Parametros recebidos do form pai
33:     this_oParentForm   = .NULL.   && Referencia ao form pai (pedido/venda)
34:     this_cLPrecoAtual  = ""       && Codigo da lista corrente (excluida de grd_4c_Listas)
35: 
36:     *--------------------------------------------------------------------------
37:     * Init - Recebe parametros do form pai, configura Caption e propriedades
38:     *--------------------------------------------------------------------------
39:     PROCEDURE Init(par_oParentForm, par_cLPreco)
40:         THIS.Caption          = "Sele" + CHR(231) + CHR(227) + "o Lista de Pre" + CHR(231) + "o"
41:         THIS.this_oParentForm = par_oParentForm
42:         THIS.this_cLPrecoAtual = ALLTRIM(NVL(par_cLPreco, ""))
43: 
44:         RETURN DODEFAULT()
45:     ENDPROC
46: 
47:     *--------------------------------------------------------------------------
48:     * InicializarForm - Cria estrutura, carrega dados e vincula eventos
49:     *--------------------------------------------------------------------------

*-- Linhas 57 a 137:
57: 
58:             THIS.ConfigurarPageFrame()
59: 
60:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
61:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
62: 
63:             THIS.TornarControlesVisiveis(THIS)
64: 
65:             *-- Carrega listas disponiveis e vincula evento de selecao
66:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
67:                 THIS.CarregarGradeLista()
68:             ENDIF
69:             BINDEVENT(THIS.grd_4c_Listas, "AfterRowColChange", THIS, "GradeListasAfterRowColChange")
70:             BINDEVENT(THIS.grd_4c_Itens.Column1.Check1, "When", THIS, "GradeItensCheck1When")
71: 
72:             loc_lSucesso = .T.
73:         CATCH TO loc_oErro
74:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
75:                     " PROC=" + loc_oErro.Procedure, "Erro")
76:         ENDTRY
77: 
78:         RETURN loc_lSucesso
79:     ENDPROC
80: 
81:     *--------------------------------------------------------------------------
82:     * ConfigurarPageFrame - Cria cabecalho + grids + botoes (flat, sem PageFrame)
83:     *--------------------------------------------------------------------------
84:     PROTECTED PROCEDURE ConfigurarPageFrame()
85:         *-- Fundo do dialogo (original: Picture = new_background.jpg)
86:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
87: 
88:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
89:         WITH THIS.cnt_4c_Cabecalho
90:             .Top         = 0
91:             .Left        = 0
92:             .Width       = THIS.Width
93:             .Height      = 80
94:             .BackStyle   = 1
95:             .BackColor   = RGB(100, 100, 100)
96:             .BorderWidth = 0
97:             .Visible     = .T.
98:         ENDWITH
99: 
100:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
101:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
102:             .Top       = 18
103:             .Left      = 10
104:             .Width     = THIS.Width - 20
105:             .Height    = 40
106:             .AutoSize  = .F.
107:             .FontName  = "Tahoma"
108:             .FontSize  = 18
109:             .FontBold  = .T.
110:             .BackStyle = 0
111:             .WordWrap  = .T.
112:             .Alignment = 0
113:             .ForeColor = RGB(0, 0, 0)
114:             .Caption   = THIS.Caption
115:             .Visible   = .T.
116:         ENDWITH
117: 
118:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
119:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
120:             .Top       = 17
121:             .Left      = 10
122:             .Width     = THIS.Width - 20
123:             .Height    = 46
124:             .AutoSize  = .F.
125:             .FontName  = "Tahoma"
126:             .FontSize  = 18
127:             .FontBold  = .T.
128:             .BackStyle = 0
129:             .WordWrap  = .T.
130:             .Alignment = 0
131:             .ForeColor = RGB(255, 255, 255)
132:             .Caption   = THIS.Caption
133:             .Visible   = .T.
134:         ENDWITH
135: 
136:         *-- Layout flat (dialogo sem PageFrame): grids + botoes de acao
137:         THIS.ConfigurarPaginaLista()

*-- Linhas 150 a 301:
150:     ENDPROC
151: 
152:     *--------------------------------------------------------------------------
153:     * ConfigurarPaginaDados - Mantido por paridade de API com forms CRUD
154:     * Este eh um dialogo OPERACIONAL (sem Page1=Lista/Page2=Dados). Toda a
155:     * area de "dados" do dialogo eh, na pratica, o grd_4c_Itens (checkbox +
156:     * codigo + descricao + preco + moeda + comissao), configurado em
157:     * ConfigurarGradeItens(). Nao ha TextBoxes/Labels individuais para exibir
158:     * porque a selecao acontece diretamente nas linhas do grid.
159:     *
160:     * Metodo delega para ConfigurarGradeItens() para que qualquer chamada
161:     * externa (ex: rerender apos redimensionamento) reconstrua a area de dados.
162:     *--------------------------------------------------------------------------
163:     PROTECTED PROCEDURE ConfigurarPaginaDados()
164:         *-- Nesse dialogo OPERACIONAL, "pagina de dados" = grid de itens marcaveis
165:         IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
166:             THIS.ConfigurarGradeItens()
167:         ENDIF
168:     ENDPROC
169: 
170:     *--------------------------------------------------------------------------
171:     * AlternarPagina - Move o foco entre os dois grids do dialogo.
172:     * par_nPagina = 1  -> grd_4c_Listas (cabecalho: escolha da lista de preco)
173:     * par_nPagina = 2  -> grd_4c_Itens  (detalhe: marcacao dos itens)
174:     * Neste dialogo nao ha PageFrame real; o metodo existe para compatibilidade
175:     * de API com forms CRUD e para permitir navegacao programatica entre grids.
176:     *--------------------------------------------------------------------------
177:     PROCEDURE AlternarPagina(par_nPagina)
178:         LOCAL loc_nPagina
179: 
180:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
181: 
182:         DO CASE
183:             CASE loc_nPagina = 1
184:                 IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
185:                     THIS.grd_4c_Listas.SetFocus()
186:                 ENDIF
187:             CASE loc_nPagina = 2
188:                 IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
189:                     THIS.grd_4c_Itens.SetFocus()
190:                 ENDIF
191:         ENDCASE
192:     ENDPROC
193: 
194:     *--------------------------------------------------------------------------
195:     * ConfigurarGradeLista - Cria grd_4c_Listas para selecao de lista de preco
196:     * Original: GradeLista Top=96 Left=263 Width=258 Height=112 ColumnCount=1
197:     *--------------------------------------------------------------------------
198:     PROTECTED PROCEDURE ConfigurarGradeLista()
199:         THIS.AddObject("grd_4c_Listas", "Grid")
200:         WITH THIS.grd_4c_Listas
201:             .Top         = 96
202:             .Left        = 263
203:             .Width       = 258
204:             .Height      = 112
205:             .ColumnCount = 1
206:             .FontName    = "Courier New"
207:             .FontSize    = 9
208:             .ReadOnly    = .T.
209:             .DeleteMark  = .F.
210:             .RecordMark  = .F.
211:             .HighlightStyle     = 2
212:             .HighlightBackColor = RGB(255, 255, 255)
213:             .HighlightForeColor = RGB(15, 41, 104)
214:             .GridLineColor      = RGB(238, 238, 238)
215:             .ScrollBars  = 2
216:             .RowHeight   = 16
217:             WITH .Column1
218:                 .Width    = 220
219:                 .ReadOnly = .T.
220:                 .FontName = "Courier New"
221:                 .FontSize = 9
222:                 .Header1.Caption   = "Lista de Pre" + CHR(231) + "os"
223:                 .Header1.FontName  = "Tahoma"
224:                 .Header1.FontSize  = 8
225:                 .Header1.Alignment = 2
226:                 .Header1.ForeColor = RGB(0, 0, 0)
227:             ENDWITH
228:             *-- Estilo do TextBox padrao da coluna (fiel ao SCX original)
229:             IF PEMSTATUS(THIS.grd_4c_Listas.Column1, "Text1", 5)
230:                 WITH THIS.grd_4c_Listas.Column1.Text1
231:                     .BorderStyle = 0
232:                     .Margin      = 0
233:                     .ReadOnly    = .T.
234:                     .ForeColor   = RGB(0, 0, 0)
235:                     .BackColor   = RGB(255, 255, 255)
236:                 ENDWITH
237:             ENDIF
238:             .Visible = .T.
239:         ENDWITH
240:     ENDPROC
241: 
242:     *--------------------------------------------------------------------------
243:     * ConfigurarGradeItens - Cria grd_4c_Itens com checkbox na Column1 (6 cols)
244:     * Original: GradeItens Top=215 Left=72 Width=663 Height=184 ColumnCount=6
245:     *--------------------------------------------------------------------------
246:     PROTECTED PROCEDURE ConfigurarGradeItens()
247:         LOCAL loc_oGrid
248: 
249:         THIS.AddObject("grd_4c_Itens", "Grid")
250:         loc_oGrid = THIS.grd_4c_Itens
251: 
252:         WITH loc_oGrid
253:             .Top         = 215
254:             .Left        = 72
255:             .Width       = 663
256:             .Height      = 184
257:             .ColumnCount = 6
258:             .FontName    = "Courier New"
259:             .FontSize    = 9
260:             .ReadOnly    = .F.
261:             .DeleteMark  = .F.
262:             .RecordMark  = .F.
263:             .HighlightStyle     = 2
264:             .HighlightBackColor = RGB(255, 255, 255)
265:             .HighlightForeColor = RGB(15, 41, 104)
266:             .GridLineColor      = RGB(238, 238, 238)
267:             .ScrollBars  = 2
268:             .RowHeight   = 16
269:         ENDWITH
270: 
271:         *-- Column1: CheckBox para marcacao (Sparse=.F. obrigatorio para todas as linhas)
272:         WITH loc_oGrid.Column1
273:             .Width    = 22
274:             .ReadOnly = .F.
275:             .Sparse   = .F.
276:             .AddObject("Check1", "CheckBox")
277:             .Check1.Top       = 23
278:             .Check1.Left      = 3
279:             .Check1.Height    = 17
280:             .Check1.Width     = 60
281:             .Check1.FontName  = "Courier New"
282:             .Check1.Alignment = 0
283:             .Check1.Caption   = ""
284:             .Check1.Value     = 0
285:             .CurrentControl = "Check1"
286:             .Header1.Caption  = ""
287:             .Header1.FontName = "Tahoma"
288:             .Header1.FontSize = 8
289:         ENDWITH
290: 
291:         WITH loc_oGrid.Column2
292:             .Width    = 108
293:             .ReadOnly = .T.
294:             .FontName = "Courier New"
295:             .FontSize = 9
296:             .Header1.Caption   = "C" + CHR(243) + "digo Produto"
297:             .Header1.FontName  = "Tahoma"
298:             .Header1.FontSize  = 8
299:             .Header1.Alignment = 2
300:             .Header1.ForeColor = RGB(0, 0, 0)
301:         ENDWITH

*-- Linhas 314 a 322:
314:             .ReadOnly = .T.
315:             .FontName = "Courier New"
316:             .FontSize = 9
317:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
318:             .Header1.FontName  = "Tahoma"
319:             .Header1.FontSize  = 8
320:             .Header1.Alignment = 2
321:             .Header1.ForeColor = RGB(0, 0, 0)
322:         ENDWITH

*-- Linhas 336 a 344:
336:             .FontName  = "Courier New"
337:             .FontSize  = 9
338:             .InputMask = "999,999,999.99"
339:             .Header1.Caption   = "Pre" + CHR(231) + "o de Venda"
340:             .Header1.FontName  = "Tahoma"
341:             .Header1.FontSize  = 8
342:             .Header1.Alignment = 2
343:             .Header1.ForeColor = RGB(0, 0, 0)
344:         ENDWITH

*-- Linhas 358 a 366:
358:             .ReadOnly = .T.
359:             .FontName = "Courier New"
360:             .FontSize = 9
361:             .Header1.Caption   = "Moeda"
362:             .Header1.FontName  = "Tahoma"
363:             .Header1.FontSize  = 8
364:             .Header1.Alignment = 2
365:             .Header1.ForeColor = RGB(0, 0, 0)
366:         ENDWITH

*-- Linhas 380 a 388:
380:             .FontName  = "Courier New"
381:             .FontSize  = 9
382:             .InputMask = "999.99"
383:             .Header1.Caption   = "Comiss" + CHR(227) + "o"
384:             .Header1.FontName  = "Tahoma"
385:             .Header1.FontSize  = 8
386:             .Header1.Alignment = 2
387:             .Header1.ForeColor = RGB(0, 0, 0)
388:         ENDWITH

*-- Linhas 407 a 474:
407:     *--------------------------------------------------------------------------
408:     PROTECTED PROCEDURE ConfigurarBotoesForm()
409:         *-- Botao principal: adiciona itens marcados a lista atual
410:         THIS.AddObject("cmd_4c_Adicionar", "CommandButton")
411:         WITH THIS.cmd_4c_Adicionar
412:             .Top       = 413
413:             .Left      = 80
414:             .Width     = 288
415:             .Height    = 27
416:             .FontName  = "Tahoma"
417:             .FontSize  = 8
418:             .Caption   = "Adiciona os itens marcados " + CHR(224) + " Lista atual"
419:             .ForeColor = RGB(90, 90, 90)
420:             .BackColor = RGB(255, 255, 255)
421:             .Themes    = .F.
422:             .Visible   = .T.
423:         ENDWITH
424:         BINDEVENT(THIS.cmd_4c_Adicionar, "Click", THIS, "CmdAdicionarClick")
425: 
426:         *-- Botao Selecionar Tudo (icone pequeno ao lado do grid)
427:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
428:         WITH THIS.cmd_4c_SelTudo
429:             .Top             = 407
430:             .Left            = 632
431:             .Width           = 32
432:             .Height          = 32
433:             .Caption         = ""
434:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
435:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
436:             .Themes          = .T.
437:             .SpecialEffect   = 0
438:             .TabStop         = .F.
439:             .ToolTipText     = "Selecionar Tudo"
440:             .Visible         = .T.
441:         ENDWITH
442:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
443: 
444:         *-- Botao Desmarcar Tudo
445:         THIS.AddObject("cmd_4c_ApgaTudo", "CommandButton")
446:         WITH THIS.cmd_4c_ApgaTudo
447:             .Top             = 407
448:             .Left            = 672
449:             .Width           = 32
450:             .Height          = 32
451:             .Caption         = ""
452:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
453:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
454:             .Themes          = .T.
455:             .SpecialEffect   = 0
456:             .TabStop         = .F.
457:             .ToolTipText     = "Desmarcar Tudo"
458:             .Visible         = .T.
459:         ENDWITH
460:         BINDEVENT(THIS.cmd_4c_ApgaTudo, "Click", THIS, "CmdApgaTudoClick")
461: 
462:         *-- Botao Encerrar (canto superior direito, sobre o cabecalho)
463:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
464:         WITH THIS.cmd_4c_Encerrar
465:             .Top             = 3
466:             .Left            = 725
467:             .Width           = 75
468:             .Height          = 75
469:             .Caption         = "Encerrar"
470:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
471:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
472:             .Themes          = .T.
473:             .Cancel          = .T.
474:             .FontName        = "Tahoma"

*-- Linhas 482 a 574:
482:             .WordWrap        = .T.
483:             .Visible         = .T.
484:         ENDWITH
485:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
486:     ENDPROC
487: 
488:     *--------------------------------------------------------------------------
489:     * CarregarGradeLista - Chama BO.BuscarListasDisponiveis e popula grd_4c_Listas
490:     * Apos carregar, chama MontaGrade2 com a primeira lista disponivel
491:     *--------------------------------------------------------------------------
492:     PROCEDURE CarregarGradeLista()
493:         LOCAL loc_lSucesso, loc_cCursorListas
494: 
495:         loc_lSucesso = THIS.this_oBusinessObject.BuscarListasDisponiveis(THIS.this_cLPrecoAtual)
496: 
497:         IF loc_lSucesso
498:             loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
499: 
500:             WITH THIS.grd_4c_Listas
501:                 .RecordSource = ""
502:                 .Column1.ControlSource = loc_cCursorListas + ".lprecos"
503:                 .RecordSource = loc_cCursorListas
504:                 *-- Reconfigurar header apos RecordSource (VFP9 reseta headers)
505:                 .Column1.Header1.Caption   = "Lista de Pre" + CHR(231) + "os"
506:                 .Column1.Header1.FontName  = "Tahoma"
507:                 .Column1.Header1.FontSize  = 8
508:                 .Column1.Header1.Alignment = 2
509:                 .Column1.Header1.ForeColor = RGB(0, 0, 0)
510:             ENDWITH
511: 
512:             *-- Carregar itens da primeira lista disponivel
513:             SELECT (loc_cCursorListas)
514:             GO TOP
515:             IF !EOF()
516:                 THIS.MontaGrade2(ALLTRIM(lprecos))
517:             ENDIF
518:         ENDIF
519: 
520:         RETURN loc_lSucesso
521:     ENDPROC
522: 
523:     *--------------------------------------------------------------------------
524:     * MontaGrade2 - Carrega itens de SigCdLpi para grd_4c_Itens
525:     * par_cLPrecos: codigo da lista selecionada em grd_4c_Listas
526:     *--------------------------------------------------------------------------
527:     PROCEDURE MontaGrade2(par_cLPrecos)
528:         LOCAL loc_lSucesso, loc_cCursorItens
529: 
530:         loc_lSucesso = THIS.this_oBusinessObject.BuscarItensDaLista(par_cLPrecos)
531: 
532:         IF loc_lSucesso
533:             loc_cCursorItens = THIS.this_oBusinessObject.this_cCursorItens
534: 
535:             WITH THIS.grd_4c_Itens
536:                 .RecordSource = ""
537:                 .Column1.ControlSource = loc_cCursorItens + ".lMarcas"
538:                 .Column2.ControlSource = loc_cCursorItens + ".cpros"
539:                 .Column3.ControlSource = loc_cCursorItens + ".dpros"
540:                 .Column4.ControlSource = loc_cCursorItens + ".pvens"
541:                 .Column5.ControlSource = loc_cCursorItens + ".moevs"
542:                 .Column6.ControlSource = loc_cCursorItens + ".comiss"
543:                 .RecordSource = loc_cCursorItens
544:                 *-- Reconfigurar headers apos RecordSource (VFP9 reseta headers)
545:                 .Column1.Header1.Caption = ""
546:                 .Column2.Header1.Caption = "C" + CHR(243) + "digo Produto"
547:                 .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
548:                 .Column4.Header1.Caption = "Pre" + CHR(231) + "o de Venda"
549:                 .Column5.Header1.Caption = "Moeda"
550:                 .Column6.Header1.Caption = "Comiss" + CHR(227) + "o"
551:                 .Refresh
552:             ENDWITH
553:         ENDIF
554: 
555:         RETURN loc_lSucesso
556:     ENDPROC
557: 
558:     *--------------------------------------------------------------------------
559:     * GradeListasAfterRowColChange - Atualiza grd_4c_Itens ao trocar linha em grd_4c_Listas
560:     *--------------------------------------------------------------------------
561:     PROCEDURE GradeListasAfterRowColChange(par_nColIndex)
562:         LOCAL loc_cCursorListas, loc_cLPrecos
563: 
564:         loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
565: 
566:         IF USED(loc_cCursorListas)
567:             SELECT (loc_cCursorListas)
568:             IF !EOF()
569:                 loc_cLPrecos = ALLTRIM(lprecos)
570:                 IF !EMPTY(loc_cLPrecos)
571:                     THIS.MontaGrade2(loc_cLPrecos)
572:                 ENDIF
573:             ENDIF
574:         ENDIF

*-- Linhas 614 a 646:
614:     PROCEDURE CmdEncerrarClick()
615:         THIS.Release()
616:     ENDPROC
617: 
618:     *--------------------------------------------------------------------------
619:     * CmdSelTudoClick - Marca todos os itens de grd_4c_Itens
620:     *--------------------------------------------------------------------------
621:     PROCEDURE CmdSelTudoClick()
622:         THIS.this_oBusinessObject.MarcarTodos()
623:         THIS.grd_4c_Itens.Refresh()
624:     ENDPROC
625: 
626:     *--------------------------------------------------------------------------
627:     * CmdApgaTudoClick - Desmarca todos os itens de grd_4c_Itens
628:     *--------------------------------------------------------------------------
629:     PROCEDURE CmdApgaTudoClick()
630:         THIS.this_oBusinessObject.DesmarcarTodos()
631:         THIS.grd_4c_Itens.Refresh()
632:     ENDPROC
633: 
634:     *--------------------------------------------------------------------------
635:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
636:     *--------------------------------------------------------------------------
637:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
638:         LOCAL loc_i, loc_oControl, loc_p
639: 
640:         FOR loc_i = 1 TO par_oContainer.ControlCount
641:             loc_oControl = par_oContainer.Controls(loc_i)
642: 
643:             IF VARTYPE(loc_oControl) = "O"
644:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
645:                     loc_oControl.Visible = .T.
646:                 ENDIF

*-- Linhas 684 a 709:
684: 
685:         DODEFAULT()
686:     ENDPROC
687: 
688:     *--------------------------------------------------------------------------
689:     * Activate - Define foco inicial no grd_4c_Listas ao exibir o dialogo
690:     * Equivale ao ThisForm.GradeLista.Column1.SetFocus do Init legado
691:     *--------------------------------------------------------------------------
692:     PROCEDURE Activate()
693:         IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
694:             THIS.grd_4c_Listas.SetFocus()
695:         ENDIF
696:         DODEFAULT()
697:     ENDPROC
698: 
699:     *--------------------------------------------------------------------------
700:     * GradeItensCheck1When - Controla se o CheckBox pode ser interagido
701:     * Replica o When event original: Return(CsSigCdLpi.lMarcas = 0)
702:     * Itens ja marcados NAO podem ser desmarcados individualmente;
703:     * para desmarcar usar cmd_4c_ApgaTudo (Desmarcar Tudo)
704:     *--------------------------------------------------------------------------
705:     PROCEDURE GradeItensCheck1When()
706:         LOCAL loc_cCursor, loc_lPermitir
707: 
708:         loc_lPermitir = .T.
709:         loc_cCursor   = THIS.this_oBusinessObject.this_cCursorItens

*-- Linhas 727 a 797:
727:     PROCEDURE BtnIncluirClick()
728:         THIS.CmdAdicionarClick()
729:     ENDPROC
730: 
731:     *--------------------------------------------------------------------------
732:     * BtnAlterarClick - Move o foco para grd_4c_Itens permitindo ao usuario
733:     * alterar (marcar/desmarcar) os itens da lista de preco selecionada. Como
734:     * este eh um dialogo de selecao, "alterar" corresponde a editar quais
735:     * itens estao marcados para inclusao.
736:     *--------------------------------------------------------------------------
737:     PROCEDURE BtnAlterarClick()
738:         LOCAL loc_cCursor
739: 
740:         IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
741:             RETURN
742:         ENDIF
743: 
744:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
745: 
746:         IF USED(loc_cCursor)
747:             SELECT (loc_cCursor)
748:             GO TOP
749:             THIS.grd_4c_Itens.Refresh()
750:             THIS.grd_4c_Itens.SetFocus()
751:         ELSE
752:             MsgAviso("Nenhuma lista de pre" + CHR(231) + "o selecionada.", "Aviso")
753:         ENDIF
754:     ENDPROC
755: 
756:     *--------------------------------------------------------------------------
757:     * BtnVisualizarClick - Move o foco para grd_4c_Listas permitindo ao
758:     * usuario visualizar as listas de preco disponiveis para importacao.
759:     * Neste dialogo de selecao, "visualizar" corresponde a navegar entre as
760:     * listas de preco de origem (o SCX original faz isso via GradeLista).
761:     *--------------------------------------------------------------------------
762:     PROCEDURE BtnVisualizarClick()
763:         LOCAL loc_cCursor
764: 
765:         IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
766:             RETURN
767:         ENDIF
768: 
769:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
770: 
771:         IF USED(loc_cCursor)
772:             SELECT (loc_cCursor)
773:             GO TOP
774:             THIS.grd_4c_Listas.Refresh()
775:             THIS.grd_4c_Listas.SetFocus()
776:         ELSE
777:             MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
778:         ENDIF
779:     ENDPROC
780: 
781:     *--------------------------------------------------------------------------
782:     * BtnExcluirClick - Desmarca todos os itens marcados de grd_4c_Itens.
783:     * Neste dialogo de selecao, "excluir" corresponde a remover as marcacoes
784:     * feitas pelo usuario (mesma acao do CmdApgTudo do SCX original), com
785:     * confirmacao previa se houver itens marcados.
786:     *--------------------------------------------------------------------------
787:     PROCEDURE BtnExcluirClick()
788:         LOCAL loc_cCursor, loc_nMarcados
789: 
790:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
791: 
792:         IF !USED(loc_cCursor)
793:             RETURN
794:         ENDIF
795: 
796:         SELECT (loc_cCursor)
797:         COUNT FOR lMarcas = 1 TO loc_nMarcados

*-- Linhas 836 a 872:
836:     PROCEDURE BtnCancelarClick()
837:         THIS.Release()
838:     ENDPROC
839: 
840:     *--------------------------------------------------------------------------
841:     * BtnBuscarClick - Refoca grd_4c_Listas para navegar entre listas disponiveis
842:     * Se o cursor de listas nao existe, recarrega via CarregarGradeLista()
843:     *--------------------------------------------------------------------------
844:     PROCEDURE BtnBuscarClick()
845:         LOCAL loc_cCursor
846: 
847:         IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
848:             RETURN
849:         ENDIF
850: 
851:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
852: 
853:         IF USED(loc_cCursor)
854:             SELECT (loc_cCursor)
855:             GO TOP
856:             THIS.grd_4c_Listas.Refresh()
857:             THIS.grd_4c_Listas.SetFocus()
858:         ELSE
859:             IF !THIS.CarregarGradeLista()
860:                 MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
861:             ENDIF
862:         ENDIF
863:     ENDPROC
864: 
865:     *--------------------------------------------------------------------------
866:     * FormParaBO - Copia dados do form para o Business Object
867:     * Neste dialogo OPERACIONAL, popula this_cLprecos com a lista selecionada
868:     *--------------------------------------------------------------------------
869:     PROCEDURE FormParaBO()
870:         LOCAL loc_cCursor
871: 
872:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas

*-- Linhas 887 a 963:
887:         LOCAL loc_cCursorListas, loc_cCursorItens
888: 
889:         loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
890:         loc_cCursorItens  = THIS.this_oBusinessObject.this_cCursorItens
891: 
892:         IF USED(loc_cCursorListas) AND PEMSTATUS(THIS, "grd_4c_Listas", 5)
893:             THIS.grd_4c_Listas.Refresh()
894:         ENDIF
895: 
896:         IF USED(loc_cCursorItens) AND PEMSTATUS(THIS, "grd_4c_Itens", 5)
897:             THIS.grd_4c_Itens.Refresh()
898:         ENDIF
899:     ENDPROC
900: 
901:     *--------------------------------------------------------------------------
902:     * HabilitarCampos - Habilita ou desabilita controles editaveis do dialogo
903:     * par_lHabilitar: .T. habilita, .F. desabilita
904:     * OBS: cmd_4c_SelTudo e cmd_4c_ApgaTudo sao icone-only (Caption="") -
905:     *      NUNCA setar .Enabled neles (botao fica caixa vazia sem icone)
906:     *--------------------------------------------------------------------------
907:     PROCEDURE HabilitarCampos(par_lHabilitar)
908:         LOCAL loc_lHabilitar
909: 
910:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
911: 
912:         IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
913:             THIS.grd_4c_Listas.Enabled = loc_lHabilitar
914:         ENDIF
915: 
916:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
917:             THIS.grd_4c_Itens.Enabled = loc_lHabilitar
918:         ENDIF
919: 
920:         IF PEMSTATUS(THIS, "cmd_4c_Adicionar", 5)
921:             THIS.cmd_4c_Adicionar.Enabled = loc_lHabilitar
922:         ENDIF
923:     ENDPROC
924: 
925:     *--------------------------------------------------------------------------
926:     * LimparCampos - Desvincula grids e fecha cursores do BO
927:     *--------------------------------------------------------------------------
928:     PROCEDURE LimparCampos()
929:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
930:             THIS.grd_4c_Itens.RecordSource = ""
931:         ENDIF
932: 
933:         IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
934:             THIS.grd_4c_Listas.RecordSource = ""
935:         ENDIF
936: 
937:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
938:             THIS.this_oBusinessObject.LimparCursores()
939:         ENDIF
940:     ENDPROC
941: 
942:     *--------------------------------------------------------------------------
943:     * AjustarBotoesPorModo - Ajusta estado do botao Adicionar conforme marcacoes
944:     * Conta itens marcados: habilita Adicionar se ha ao menos 1 marcado
945:     * OBS: cmd_4c_SelTudo e cmd_4c_ApgaTudo sao icone-only - nao alterar .Enabled
946:     *--------------------------------------------------------------------------
947:     PROCEDURE AjustarBotoesPorModo()
948:         LOCAL loc_cCursor, loc_nMarcados
949: 
950:         loc_nMarcados = 0
951:         loc_cCursor   = THIS.this_oBusinessObject.this_cCursorItens
952: 
953:         IF USED(loc_cCursor)
954:             SELECT (loc_cCursor)
955:             COUNT FOR lMarcas = 1 TO loc_nMarcados
956:         ENDIF
957: 
958:         IF PEMSTATUS(THIS, "cmd_4c_Adicionar", 5)
959:             THIS.cmd_4c_Adicionar.Enabled = (loc_nMarcados > 0)
960:         ENDIF
961:     ENDPROC
962: 
963: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrSlpBO.prg):
*==============================================================================
* SigPrSlpBO.prg - Business Object: Selecao Lista de Preco
* Herda de: BusinessBase
* Tabelas: SigCdLpc (listas de preco), SigCdLpi (itens da lista)
* Tipo: OPERACIONAL - dialogo filho do form de pedido
*==============================================================================

DEFINE CLASS SigPrSlpBO AS BusinessBase

    *-- Configuracao da tabela base
    this_cTabela     = "SigCdLpi"
    this_cCampoChave = "cidchaves"

    *-- Cursores internos
    this_cCursorListas = "cursor_4c_Listas"
    this_cCursorItens  = "cursor_4c_Itens"

    *-- Propriedades mapeadas para colunas de SigCdLpi
    this_cCidchaves   = ""
    this_cCgrus       = ""
    this_nComiss      = 0
    this_cCpros       = ""
    this_cDpros       = ""
    this_lFlagutabs   = .F.
    this_cLprecos     = ""
    this_cMoevs       = ""
    this_nPvens       = 0
    this_dVencis      = {}
    this_dVencfs      = {}
    this_cOrdems      = ""
    this_cCcontroles  = ""
    this_nEan13       = 0
    this_nPcuss       = 0
    this_cReffs       = ""
    this_nPrecode     = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdLpi"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarListasDisponiveis - Carrega SigCdLpc excluindo a lista atual
    * par_cLPrecoExcluir: codigo da lista de preco atual (a ser excluida)
    * Popula cursor_4c_Listas com colunas: lprecos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarListasDisponiveis(par_cLPrecoExcluir)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorListas)
                USE IN (THIS.this_cCursorListas)
            ENDIF

            loc_cSQL = "SELECT lprecos FROM SigCdLpc " + ;
                       "WHERE lprecos <> " + EscaparSQL(par_cLPrecoExcluir) + " " + ;
                       "ORDER BY lprecos"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorListas) > 0
                SELECT (THIS.this_cCursorListas)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar listas de pre" + CHR(231) + "o.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItensDaLista - Carrega SigCdLpi de uma lista especifica
    * par_cLPrecos: codigo da lista de preco selecionada
    * Popula cursor_4c_Itens com lMarcas=0 e todos os campos de SigCdLpi
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensDaLista(par_cLPrecos)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            loc_cSQL = "SELECT 0 AS lMarcas, a.cgrus, a.comiss, a.cpros, a.dpros, " + ;
                       "a.flagutabs, a.lprecos, a.moevs, a.pvens, a.vencis, a.vencfs, " + ;
                       "a.ordems, a.ccontroles, a.cidchaves, a.ean13, a.pcuss, " + ;
                       "a.reffs, a.precode " + ;
                       "FROM SigCdLpi a " + ;
                       "WHERE a.lprecos = " + EscaparSQL(par_cLPrecos) + " " + ;
                       "ORDER BY a.cpros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens) > 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar itens da lista de pre" + CHR(231) + "o.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarItensMarcados - Copia itens marcados para o cursor de destino
    * par_cLPrecoAtual:        codigo da lista atual (destino)
    * par_cCursorDestino:      nome do cursor VFP local do form pai (CrSigCdLpi)
    * par_lAplicarArredond:    .T. se deve arredondar pvens (CompVenda <> "C")
    * Retorna: numero de itens adicionados, -1 em caso de erro
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarItensMarcados(par_cLPrecoAtual, par_cCursorDestino, par_lAplicarArredond)
        LOCAL loc_nAdicionados, loc_oErro, loc_cLPrecoAtual, loc_lPodeExecutar

        loc_nAdicionados    = 0
        loc_lPodeExecutar   = .T.
        loc_cLPrecoAtual    = ALLTRIM(par_cLPrecoAtual)

        IF !USED(THIS.this_cCursorItens)
            loc_lPodeExecutar = .F.
            loc_nAdicionados  = -1
        ENDIF
        IF loc_lPodeExecutar AND !USED(par_cCursorDestino)
            loc_lPodeExecutar = .F.
            loc_nAdicionados  = -1
        ENDIF

        IF loc_lPodeExecutar
            TRY
                *-- Remove itens vazios do cursor destino (sem cpros)
                DELETE FROM (par_cCursorDestino) WHERE EMPTY(cpros)

                SELECT (THIS.this_cCursorItens)
                GO TOP

                SCAN
                    IF cursor_4c_Itens.lMarcas = 1
                        *-- Verifica se cpros ja existe no cursor destino
                        IF !SEEK(cursor_4c_Itens.cpros, par_cCursorDestino, "CPros")
                            SCATTER MEMVAR

                            m.lMarcas   = 0
                            m.lprecos   = loc_cLPrecoAtual
                            m.cidchaves = fUniqueIds()
                            m.vencis    = NVL(m.vencis, {})
                            m.vencfs    = NVL(m.vencfs, {})

                            IF par_lAplicarArredond
                                m.pvens = ROUND(m.pvens, 2)
                            ENDIF

                            INSERT INTO (par_cCursorDestino) FROM MEMVAR
                            loc_nAdicionados = loc_nAdicionados + 1

                            SELECT (THIS.this_cCursorItens)
                        ENDIF
                    ENDIF
                ENDSCAN

            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro")
                loc_nAdicionados = -1
            ENDTRY
        ENDIF

        RETURN loc_nAdicionados
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todos os itens do cursor de itens
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_cCursorItens)
                SELECT (THIS.this_cCursorItens)
                REPLACE ALL lMarcas WITH 1
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todos os itens do cursor de itens
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_cCursorItens)
                SELECT (THIS.this_cCursorItens)
                REPLACE ALL lMarcas WITH 0
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED(THIS.this_cCursorListas)
            USE IN (THIS.this_cCursorListas)
        ENDIF
        IF USED(THIS.this_cCursorItens)
            USE IN (THIS.this_cCursorItens)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor para as propriedades this_*
    * par_cAliasCursor: nome do cursor com os dados de SigCdLpi
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves  = TratarNulo(cidchaves, "C")
                THIS.this_cCgrus      = TratarNulo(cgrus, "C")
                THIS.this_nComiss     = TratarNulo(comiss, "N")
                THIS.this_cCpros      = TratarNulo(cpros, "C")
                THIS.this_cDpros      = TratarNulo(dpros, "C")

                IF VARTYPE(flagutabs) = "N"
                    IF VARTYPE(flagutabs) = "L"
                        THIS.this_lFlagutabs = flagutabs
                    ELSE
                        IF VARTYPE(flagutabs) = "L"
                            THIS.this_lFlagutabs = flagutabs
                        ELSE
                            IF VARTYPE(flagutabs) = "L"
                                THIS.this_lFlagutabs = flagutabs
                            ELSE
                                IF VARTYPE(flagutabs) = "L"
                                    THIS.this_lFlagutabs = flagutabs
                                ELSE
                                    THIS.this_lFlagutabs = (NVL(flagutabs, 0) = 1)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ELSE
                    THIS.this_lFlagutabs = NVL(flagutabs, .F.)
                ENDIF

                THIS.this_cLprecos    = TratarNulo(lprecos, "C")
                THIS.this_cMoevs      = TratarNulo(moevs, "C")
                THIS.this_nPvens      = TratarNulo(pvens, "N")
                THIS.this_dVencis     = NVL(vencis, {})
                THIS.this_dVencfs     = NVL(vencfs, {})
                THIS.this_cOrdems     = TratarNulo(ordems, "C")
                THIS.this_cCcontroles = TratarNulo(ccontroles, "C")
                THIS.this_nEan13      = TratarNulo(ean13, "N")
                THIS.this_nPcuss      = TratarNulo(pcuss, "N")
                THIS.this_cReffs      = TratarNulo(reffs, "C")
                THIS.this_nPrecode    = TratarNulo(precode, "N")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves do registro atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdLpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdLpi (cgrus, comiss, cpros, dpros, flagutabs, " + ;
                       "lprecos, moevs, pvens, vencis, vencfs, ordems, ccontroles, " + ;
                       "cidchaves, ean13, pcuss, reffs, precode) VALUES (" + ;
                       EscaparSQL(THIS.this_cCgrus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComiss, 2) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       EscaparSQL(THIS.this_cDpros) + ", " + ;
                       IIF(THIS.this_lFlagutabs, "1", "0") + ", " + ;
                       EscaparSQL(THIS.this_cLprecos) + ", " + ;
                       EscaparSQL(THIS.this_cMoevs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPvens, 6) + ", " + ;
                       IIF(EMPTY(THIS.this_dVencis), "NULL", FormatarDataSQL(THIS.this_dVencis)) + ", " + ;
                       IIF(EMPTY(THIS.this_dVencfs), "NULL", FormatarDataSQL(THIS.this_dVencfs)) + ", " + ;
                       EscaparSQL(THIS.this_cOrdems) + ", " + ;
                       EscaparSQL(THIS.this_cCcontroles) + ", " + ;
                       EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEan13, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPcuss, 6) + ", " + ;
                       EscaparSQL(THIS.this_cReffs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecode, 5) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir item da lista de pre" + CHR(231) + "o."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdLpi WHERE cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia. Imposs" + CHR(237) + "vel atualizar."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdLpi SET " + ;
                       "cgrus = " + EscaparSQL(THIS.this_cCgrus) + ", " + ;
                       "comiss = " + FormatarNumeroSQL(THIS.this_nComiss, 2) + ", " + ;
                       "cpros = " + EscaparSQL(THIS.this_cCpros) + ", " + ;
                       "dpros = " + EscaparSQL(THIS.this_cDpros) + ", " + ;
                       "flagutabs = " + IIF(THIS.this_lFlagutabs, "1", "0") + ", " + ;
                       "lprecos = " + EscaparSQL(THIS.this_cLprecos) + ", " + ;
                       "moevs = " + EscaparSQL(THIS.this_cMoevs) + ", " + ;
                       "pvens = " + FormatarNumeroSQL(THIS.this_nPvens, 6) + ", " + ;
                       "vencis = " + IIF(EMPTY(THIS.this_dVencis), "NULL", FormatarDataSQL(THIS.this_dVencis)) + ", " + ;
                       "vencfs = " + IIF(EMPTY(THIS.this_dVencfs), "NULL", FormatarDataSQL(THIS.this_dVencfs)) + ", " + ;
                       "ordems = " + EscaparSQL(THIS.this_cOrdems) + ", " + ;
                       "ccontroles = " + EscaparSQL(THIS.this_cCcontroles) + ", " + ;
                       "ean13 = " + FormatarNumeroSQL(THIS.this_nEan13, 0) + ", " + ;
                       "pcuss = " + FormatarNumeroSQL(THIS.this_nPcuss, 6) + ", " + ;
                       "reffs = " + EscaparSQL(THIS.this_cReffs) + ", " + ;
                       "precode = " + FormatarNumeroSQL(THIS.this_nPrecode, 5) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar item da lista de pre" + CHR(231) + "o."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdLpi WHERE cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia. Imposs" + CHR(237) + "vel excluir."
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SigCdLpi WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao excluir item da lista de pre" + CHR(231) + "o."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa recursos ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

