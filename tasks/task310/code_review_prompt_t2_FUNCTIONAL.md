# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BARRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'btnSair' (parent: SIGPRMDC): Left original=725 vs migrado 'cmd_4c_BtnSair' Left=915 (diff=190px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1189 linhas total):

*-- Linhas 30 a 319:
30:     *--------------------------------------------------------------------------
31:     * Init
32:     *--------------------------------------------------------------------------
33:     PROCEDURE Init()
34:         RETURN DODEFAULT()
35:     ENDPROC
36: 
37:     *--------------------------------------------------------------------------
38:     * ConfigurarPageFrame
39:     * Configura aparencia base do form (fundo, fontes, cores).
40:     * Para forms OPERACIONAIS sem PageFrame, este metodo define o Picture
41:     * e propriedades globais do form.
42:     *--------------------------------------------------------------------------
43:     PROTECTED PROCEDURE ConfigurarPageFrame()
44:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
45:         THIS.ScrollBars = 0
46:         THIS.ShowTips   = .F.
47:         THIS.SetAll("FontName", "Tahoma")
48:         THIS.SetAll("FontSize", 8)
49:     ENDPROC
50: 
51:     *--------------------------------------------------------------------------
52:     * InicializarForm
53:     * Chamado por FormBase.Init() - cria BO, monta layout de containers base.
54:     *--------------------------------------------------------------------------
55:     PROTECTED PROCEDURE InicializarForm()
56:         LOCAL loc_lSucesso
57:         loc_lSucesso = .F.
58:         TRY
59:             *-- Configurar aparencia base do form
60:             THIS.ConfigurarPageFrame()
61: 
62:             *-- Criar Business Object
63:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrMdcBO")
64:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
65:                 THIS.this_oBusinessObject.this_lCheckCadPro = THIS.this_lCheckCadPro
66:                 IF THIS.this_oBusinessObject.InicializarCursorContas()
67:                     THIS.ConfigurarCabecalho()
68:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
69:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
70:                     THIS.ConfigurarBotoes()
71:                     THIS.ConfigurarContainerResultado()
72:                     THIS.ConfigurarPaginaLista()
73: 
74:                     *-- Tornar controles visiveis (exceto cnt_4c_Resultado que eh flutuante)
75:                     THIS.TornarControlesVisiveis(THIS)
76: 
77:                     loc_lSucesso = .T.
78:                 ELSE
79:                     MsgErro("Erro ao inicializar cursor de contas.", "Erro")
80:                 ENDIF
81:             ELSE
82:                 MsgErro("Erro ao criar SigPrMdcBO." + CHR(13) + ;
83:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
84:             ENDIF
85:         CATCH TO loc_oErro
86:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
87:                 " PROC=" + loc_oErro.Procedure, "Erro em InicializarForm")
88:         ENDTRY
89:         RETURN loc_lSucesso
90:     ENDPROC
91: 
92:     *--------------------------------------------------------------------------
93:     * ConfigurarCabecalho - cabecalho cinza com titulo (cntSombra do legado)
94:     *--------------------------------------------------------------------------
95:     PROTECTED PROCEDURE ConfigurarCabecalho()
96:         LOCAL loc_oCab
97:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
98:         loc_oCab = THIS.cnt_4c_Cabecalho
99:         WITH loc_oCab
100:             .Top         = 0
101:             .Left        = 0
102:             .Width       = THIS.Width
103:             .Height      = 80
104:             .BackStyle   = 1
105:             .BackColor   = RGB(100, 100, 100)
106:             .BorderWidth = 0
107:         ENDWITH
108:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
109:         WITH loc_oCab.lbl_4c_Sombra
110:             .Top       = 18
111:             .Left      = 10
112:             .Width     = THIS.Width - 20
113:             .Height    = 40
114:             .AutoSize  = .F.
115:             .FontName  = "Tahoma"
116:             .FontSize  = 18
117:             .FontBold  = .T.
118:             .BackStyle = 0
119:             .Caption   = THIS.Caption
120:             .ForeColor = RGB(0, 0, 0)
121:         ENDWITH
122:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
123:         WITH loc_oCab.lbl_4c_Titulo
124:             .Top       = 17
125:             .Left      = 10
126:             .Width     = THIS.Width - 20
127:             .Height    = 46
128:             .AutoSize  = .F.
129:             .FontName  = "Tahoma"
130:             .FontSize  = 18
131:             .FontBold  = .T.
132:             .BackStyle = 0
133:             .Caption   = THIS.Caption
134:             .ForeColor = RGB(255, 255, 255)
135:         ENDWITH
136:     ENDPROC
137: 
138:     *--------------------------------------------------------------------------
139:     * ConfigurarBotoes
140:     * Container para os botoes de acao (Incluir, Excluir, Importar, Processar,
141:     * Encerrar). Fica logo abaixo do cabecalho, cobrindo toda a largura.
142:     *--------------------------------------------------------------------------
143:     PROTECTED PROCEDURE ConfigurarBotoes()
144:         LOCAL loc_oCnt
145:         THIS.AddObject("cnt_4c_Botoes", "Container")
146:         loc_oCnt = THIS.cnt_4c_Botoes
147:         WITH loc_oCnt
148:             .Top         = 80
149:             .Left        =  542
150:             .Width       = THIS.Width
151:             .Height      = 90
152:             .BackStyle   = 0
153:             .BorderWidth = 0
154:         ENDWITH
155:     ENDPROC
156: 
157:     *--------------------------------------------------------------------------
158:     * ConfigurarContainerResultado
159:     * Painel de progresso de processamento (cntResult do legado).
160:     * Inicialmente oculto; exibido durante btnProcessar quando chkReps=.F.
161:     *--------------------------------------------------------------------------
162:     PROTECTED PROCEDURE ConfigurarContainerResultado()
163:         LOCAL loc_oCnt
164:         THIS.AddObject("cnt_4c_Resultado", "Container")
165:         loc_oCnt = THIS.cnt_4c_Resultado
166:         WITH loc_oCnt
167:             .Top         = 170
168:             .Left        = 490
169:             .Width       = 297
170:             .Height      = 183
171:             .BackStyle   = 1
172:             .BackColor   = RGB(255, 255, 255)
173:             .SpecialEffect = 0
174:             .BorderWidth = 1
175:             .Visible     = .F.
176:         ENDWITH
177:     ENDPROC
178: 
179:     *--------------------------------------------------------------------------
180:     * AtualizarProgresso
181:     * Chamado pelo BO (ProcessarMudancaContas) para atualizar a UI em tempo
182:     * real durante o processamento.
183:     * par_cArquivo: nome do arquivo/campo em processamento
184:     * par_nPct    : percentual concluido 0-100
185:     *--------------------------------------------------------------------------
186:     PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
187:         LOCAL loc_nLargura
188:         loc_nLargura = 0
189:         TRY
190:             IF VARTYPE(THIS.cnt_4c_Resultado) = "O" AND THIS.cnt_4c_Resultado.Visible
191:                 THIS.cnt_4c_Resultado.txt_4c_Arquivo.Value = par_cArquivo
192:                 THIS.cnt_4c_Resultado.txt_4c_Arquivo.Refresh
193:                 loc_nLargura = INT((par_nPct * 275) / 100)
194:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.shp_4c_Barra.Width = loc_nLargura
195:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.lbl_4c_Porcento.Caption = ;
196:                     ALLTRIM(TRANSFORM(par_nPct)) + " %"
197:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.Refresh
198:             ENDIF
199:         CATCH TO loc_oErro
200:             *-- progresso nao e critico, pular silenciosamente
201:         ENDTRY
202:     ENDPROC
203: 
204:     *--------------------------------------------------------------------------
205:     * TornarControlesVisiveis
206:     * Torna controles Visible=.T. apos AddObject (que cria com Visible=.F.).
207:     * EXCECAO: cnt_4c_Resultado permanece oculto (container flutuante); seus
208:     * filhos sao visitados recursivamente para render correto ao exibir.
209:     *--------------------------------------------------------------------------
210:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
211:         LOCAL loc_i, loc_oCtrl
212:         FOR loc_i = 1 TO par_oContainer.ControlCount
213:             loc_oCtrl = par_oContainer.Controls(loc_i)
214:             IF VARTYPE(loc_oCtrl) = "O"
215:                 IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_RESULTADO", "CNT_4C_CABECALHO", "CNT_4C_BARRA")
216:                     THIS.TornarControlesVisiveis(loc_oCtrl)
217:                     LOOP
218:                 ENDIF
219:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
220:                     loc_oCtrl.Visible = .T.
221:                 ENDIF
222:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) .AND. ;
223:                    loc_oCtrl.ControlCount > 0
224:                     THIS.TornarControlesVisiveis(loc_oCtrl)
225:                 ENDIF
226:             ENDIF
227:         ENDFOR
228:     ENDPROC
229: 
230:     *--------------------------------------------------------------------------
231:     * Activate - foca o grid quando o form e exibido (padrao legado Init SetFocus)
232:     *--------------------------------------------------------------------------
233:     PROCEDURE Activate()
234:         DODEFAULT()
235:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
236:             THIS.grd_4c_Dados.SetFocus()
237:         ENDIF
238:     ENDPROC
239: 
240:     *--------------------------------------------------------------------------
241:     * Destroy
242:     *--------------------------------------------------------------------------
243:     PROCEDURE Destroy()
244:         TRY
245:             IF USED("cursor_4c_Contas")
246:                 USE IN cursor_4c_Contas
247:             ENDIF
248:             IF USED("csCampos")
249:                 USE IN csCampos
250:             ENDIF
251:             IF USED("csArquivos")
252:                 USE IN csArquivos
253:             ENDIF
254:             THIS.this_oBusinessObject = .NULL.
255:         CATCH TO loc_oErro
256:             *-- ignorar erros de cleanup
257:         ENDTRY
258:         DODEFAULT()
259:     ENDPROC
260: 
261: 
262:     *--------------------------------------------------------------------------
263:     * ConfigurarPaginaLista
264:     * Configura o corpo principal do form OPERACIONAL: botoes de acao, grid
265:     * de pares de contas, checkboxes e internos do painel de progresso.
266:     *--------------------------------------------------------------------------
267:     PROTECTED PROCEDURE ConfigurarPaginaLista()
268:         THIS.ConfigurarBotoesAcao()
269:         THIS.ConfigurarGrid()
270:         THIS.ConfigurarCheckboxes()
271:         THIS.ConfigurarResultadoInternos()
272:         THIS.VincularEventos()
273:     ENDPROC
274: 
275:     *--------------------------------------------------------------------------
276:     * ConfigurarBotoesAcao
277:     * Adiciona os botoes de acao ao container cnt_4c_Botoes.
278:     *--------------------------------------------------------------------------
279:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
280:         LOCAL loc_oCnt
281:         loc_oCnt = THIS.cnt_4c_Botoes
282: 
283:         loc_oCnt.AddObject("cmd_4c_BtnIncluir", "CommandButton")
284:         WITH loc_oCnt.cmd_4c_BtnIncluir
285:             .Top             = 7
286:             .Left            = 425
287:             .Width           = 75
288:             .Height          = 75
289:             .Caption         = "\<Incluir"
290:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
291:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
292:             .FontName        = "Tahoma"
293:             .FontBold        = .T.
294:             .FontItalic      = .T.
295:             .FontSize        = 8
296:             .ForeColor       = RGB(90, 90, 90)
297:             .BackColor       = RGB(255, 255, 255)
298:             .Themes          = .T.
299:             .SpecialEffect   = 0
300:             .PicturePosition = 13
301:             .WordWrap        = .T.
302:             .MousePointer    = 15
303:         ENDWITH
304: 
305:         loc_oCnt.AddObject("cmd_4c_BtnExcluir", "CommandButton")
306:         WITH loc_oCnt.cmd_4c_BtnExcluir
307:             .Top             = 7
308:             .Left            = 500
309:             .Width           = 75
310:             .Height          = 75
311:             .Caption         = "\<Excluir"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
313:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
314:             .FontName        = "Tahoma"
315:             .FontBold        = .T.
316:             .FontItalic      = .T.
317:             .FontSize        = 8
318:             .ForeColor       = RGB(90, 90, 90)
319:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 366 a 387:
366:             .PicturePosition = 13
367:             .WordWrap        = .T.
368:             .MousePointer    = 15
369:         ENDWITH
370: 
371:         loc_oCnt.AddObject("cmd_4c_BtnSair", "CommandButton")
372:         WITH loc_oCnt.cmd_4c_BtnSair
373:             .Top             = 7
374:             .Left            = 915
375:             .Width           = 75
376:             .Height          = 75
377:             .Caption         = "Encerrar"
378:             .Cancel          = .T.
379:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
380:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
381:             .FontName        = "Tahoma"
382:             .FontBold        = .T.
383:             .FontItalic      = .T.
384:             .FontSize        = 8
385:             .ForeColor       = RGB(90, 90, 90)
386:             .BackColor       = RGB(255, 255, 255)
387:             .Themes          = .T.

*-- Linhas 397 a 524:
397:     * Cria grd_4c_Dados com 2 colunas (Conta Antiga / Conta Nova).
398:     * RecordSource: cursor_4c_Contas criado pelo BO em InicializarCursorContas.
399:     *--------------------------------------------------------------------------
400:     PROTECTED PROCEDURE ConfigurarGrid()
401:         LOCAL loc_oGrid
402:         THIS.AddObject("grd_4c_Dados", "Grid")
403:         loc_oGrid = THIS.grd_4c_Dados
404:         WITH loc_oGrid
405:             .Top               = 170
406:             .Left              = 12
407:             .Width             = 460
408:             .Height            = 400
409:             .AllowHeaderSizing = .F.
410:             .AllowRowSizing    = .F.
411:             .DeleteMark        = .F.
412:             .RecordMark        = .F.
413:             .HeaderHeight      = 18
414:             .RowHeight         = 18
415:             .ScrollBars        = 2
416:             .FontName          = "Verdana"
417:             .FontSize          = 8
418:             .ForeColor         = RGB(0, 0, 0)
419:             .BackColor         = RGB(255, 255, 255)
420:             .GridLineColor     = RGB(238, 238, 238)
421:             .HighlightStyle    = 2
422:         ENDWITH
423:         loc_oGrid.ColumnCount  = 2
424:         loc_oGrid.RecordSource = "cursor_4c_Contas"
425:         loc_oGrid.Column1.ControlSource = "cursor_4c_Contas.ContaAnt"
426:         loc_oGrid.Column1.Width         = 220
427:         loc_oGrid.Column1.Sparse        = .F.
428:         loc_oGrid.Column2.ControlSource = "cursor_4c_Contas.ContaNov"
429:         loc_oGrid.Column2.Width         = 220
430:         loc_oGrid.Column2.Sparse        = .F.
431:         *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
432:         loc_oGrid.Column1.Header1.Caption   = "Conta Antiga"
433:         loc_oGrid.Column1.Header1.Alignment = 2
434:         loc_oGrid.Column1.Header1.FontName  = "Tahoma"
435:         loc_oGrid.Column1.Header1.FontSize  = 8
436:         loc_oGrid.Column1.Header1.ForeColor = RGB(0, 0, 0)
437:         loc_oGrid.Column2.Header1.Caption   = "Conta Nova"
438:         loc_oGrid.Column2.Header1.Alignment = 2
439:         loc_oGrid.Column2.Header1.FontName  = "Tahoma"
440:         loc_oGrid.Column2.Header1.FontSize  = 8
441:         loc_oGrid.Column2.Header1.ForeColor = RGB(0, 0, 0)
442:     ENDPROC
443: 
444:     *--------------------------------------------------------------------------
445:     * ConfigurarCheckboxes
446:     * Adiciona checkboxes de controle ao form.
447:     *--------------------------------------------------------------------------
448:     PROTECTED PROCEDURE ConfigurarCheckboxes()
449:         THIS.AddObject("chk_4c_ChkReps", "CheckBox")
450:         WITH THIS.chk_4c_ChkReps
451:             .Top       = 297
452:             .Left      = 393
453:             .Height    = 20
454:             .Width     = 240
455:             .Caption   = "Trocar Apenas Representantes"
456:             .Value     = 0
457:             .AutoSize  = .F.
458:             .BackStyle = 0
459:             .FontName  = "Tahoma"
460:             .FontSize  = 8
461:             .ForeColor = RGB(90, 90, 90)
462:         ENDWITH
463:         THIS.AddObject("chk_4c_Chk_DelCT", "CheckBox")
464:         WITH THIS.chk_4c_Chk_DelCT
465:             .Top       = 278
466:             .Left      = 393
467:             .Height    = 20
468:             .Width     = 260
469:             .Caption   = "Apagar a Conta Antiga do Cadastro"
470:             .Value     = 0
471:             .AutoSize  = .F.
472:             .BackStyle = 0
473:             .FontName  = "Tahoma"
474:             .FontSize  = 8
475:             .ForeColor = RGB(90, 90, 90)
476:         ENDWITH
477:     ENDPROC
478: 
479:     *--------------------------------------------------------------------------
480:     * ConfigurarResultadoInternos
481:     * Adiciona controles internos ao painel de progresso cnt_4c_Resultado.
482:     * Nomes devem bater exatamente com as referencias em AtualizarProgresso().
483:     *--------------------------------------------------------------------------
484:     PROTECTED PROCEDURE ConfigurarResultadoInternos()
485:         LOCAL loc_oCnt
486:         loc_oCnt = THIS.cnt_4c_Resultado
487: 
488:         loc_oCnt.AddObject("lbl_4c_Label5", "Label")
489:         WITH loc_oCnt.lbl_4c_Label5
490:             .Caption   = "Arquivo/Campo :"
491:             .Left      = 7
492:             .Top       = 9
493:             .AutoSize  = .T.
494:             .BackStyle = 0
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .ForeColor = RGB(0, 0, 0)
498:         ENDWITH
499: 
500:         loc_oCnt.AddObject("txt_4c_Arquivo", "TextBox")
501:         WITH loc_oCnt.txt_4c_Arquivo
502:             .Top               = 26
503:             .Left              = 7
504:             .Width             = 278
505:             .Height            = 24
506:             .Enabled           = .F.
507:             .Value             = ""
508:             .Alignment         = 3
509:             .SpecialEffect     = 1
510:             .DisabledBackColor = RGB(255, 255, 255)
511:             .DisabledForeColor = RGB(0, 0, 0)
512:             .BorderColor       = RGB(100, 100, 100)
513:             .FontName          = "Tahoma"
514:             .FontSize          = 8
515:         ENDWITH
516: 
517:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
518:         WITH loc_oCnt.lbl_4c_Label1
519:             .Caption   = "Progresso :"
520:             .Left      = 7
521:             .Top       = 100
522:             .AutoSize  = .T.
523:             .BackStyle = 0
524:             .FontName  = "Tahoma"

*-- Linhas 571 a 1189:
571:     *   cnt_4c_Resultado  - painel de progresso (flutuante)
572:     * Metodo mantido para compatibilidade com o template multi-fase.
573:     *--------------------------------------------------------------------------
574:     PROTECTED PROCEDURE ConfigurarPaginaDados()
575:         *-- Form OPERACIONAL plano: nao ha Page2 separada de edicao de dados.
576:         *-- Todos os controles foram configurados em ConfigurarPaginaLista().
577:         RETURN
578:     ENDPROC
579: 
580:     *--------------------------------------------------------------------------
581:     * VincularEventos
582:     * Vincula eventos dos controles aos handlers do form via BINDEVENT.
583:     *--------------------------------------------------------------------------
584:     PROTECTED PROCEDURE VincularEventos()
585:         LOCAL loc_oCnt
586:         loc_oCnt = THIS.cnt_4c_Botoes
587:         BINDEVENT(loc_oCnt.cmd_4c_BtnIncluir,  "Click", THIS, "CmdIncluirClick")
588:         BINDEVENT(loc_oCnt.cmd_4c_BtnExcluir,  "Click", THIS, "CmdExcluirClick")
589:         BINDEVENT(loc_oCnt.cmd_4c_Exporta,     "Click", THIS, "CmdExportaClick")
590:         BINDEVENT(loc_oCnt.cmd_4c_BtnProcessar,"Click", THIS, "CmdProcessarClick")
591:         BINDEVENT(loc_oCnt.cmd_4c_BtnSair,     "Click", THIS, "CmdSairClick")
592:         BINDEVENT(THIS.chk_4c_ChkReps, "Click", THIS, "ChkRepsClick")
593:         BINDEVENT(THIS.grd_4c_Dados, "KeyPress",          THIS, "GrdDadosKeyPress")
594:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
595:     ENDPROC
596: 
597:     *--------------------------------------------------------------------------
598:     * AlternarPagina
599:     * Exibe ou oculta o painel de progresso (cnt_4c_Resultado).
600:     * par_lMostrar: .T. para exibir, .F. para ocultar, omitir para alternar.
601:     *--------------------------------------------------------------------------
602:     PROCEDURE AlternarPagina(par_lMostrar)
603:         TRY
604:             IF VARTYPE(par_lMostrar) = "L"
605:                 THIS.cnt_4c_Resultado.Visible = par_lMostrar
606:             ELSE
607:                 THIS.cnt_4c_Resultado.Visible = !THIS.cnt_4c_Resultado.Visible
608:             ENDIF
609:             THIS.Refresh()
610:         CATCH TO loc_oErro
611:             MsgErro(loc_oErro.Message, "Erro")
612:         ENDTRY
613:     ENDPROC
614: 
615:     *--------------------------------------------------------------------------
616:     * CmdIncluirClick - Incluir nova linha em branco no grid
617:     *--------------------------------------------------------------------------
618:     PROCEDURE CmdIncluirClick()
619:         TRY
620:             THIS.this_oBusinessObject.IncluirParConta()
621:             THIS.grd_4c_Dados.Refresh()
622:             THIS.grd_4c_Dados.SetFocus()
623:         CATCH TO loc_oErro
624:             MsgErro(loc_oErro.Message, "Erro ao Incluir")
625:         ENDTRY
626:     ENDPROC
627: 
628:     *--------------------------------------------------------------------------
629:     * CmdExcluirClick - Excluir linha corrente do grid
630:     *--------------------------------------------------------------------------
631:     PROCEDURE CmdExcluirClick()
632:         TRY
633:             THIS.this_oBusinessObject.ExcluirParConta()
634:             THIS.grd_4c_Dados.Refresh()
635:             THIS.grd_4c_Dados.SetFocus()
636:         CATCH TO loc_oErro
637:             MsgErro(loc_oErro.Message, "Erro ao Excluir")
638:         ENDTRY
639:     ENDPROC
640: 
641:     *--------------------------------------------------------------------------
642:     * CmdExportaClick - Importar pares de contas de arquivo XLS
643:     *--------------------------------------------------------------------------
644:     PROCEDURE CmdExportaClick()
645:         LOCAL loc_cArquivo
646:         loc_cArquivo = ""
647:         TRY
648:             loc_cArquivo = GETFILE("XLS")
649:             IF EMPTY(loc_cArquivo)
650:                 MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + ;
651:                     "o n" + CHR(227) + "o informado!!!", "Aviso")
652:                 RETURN
653:             ENDIF
654:             IF THIS.this_oBusinessObject.ImportarDeXLS(loc_cArquivo)
655:                 THIS.grd_4c_Dados.Refresh()
656:             ENDIF
657:         CATCH TO loc_oErro
658:             MsgErro(loc_oErro.Message, "Erro ao Importar")
659:         ENDTRY
660:     ENDPROC
661: 
662:     *--------------------------------------------------------------------------
663:     * CmdProcessarClick - Processar troca de contas em todas as tabelas
664:     *--------------------------------------------------------------------------
665:     PROCEDURE CmdProcessarClick()
666:         LOCAL loc_lSucesso, loc_cMensagem, loc_lApagarContaAntiga, loc_lTrocarReps
667:         loc_lSucesso           = .F.
668:         loc_cMensagem          = ""
669:         loc_lApagarContaAntiga = .F.
670:         loc_lTrocarReps        = .F.
671:         TRY
672:             *-- Validar pares antes de processar
673:             IF NOT THIS.this_oBusinessObject.ValidarParesContas(@loc_cMensagem)
674:                 MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
675:                 THIS.grd_4c_Dados.SetFocus()
676:                 RETURN
677:             ENDIF
678: 
679:             *-- Confirmar com usuario
680:             IF NOT MsgConfirma("Confirma a Troca das Contas ?", ;
681:                 "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
682:                 THIS.cnt_4c_Botoes.cmd_4c_BtnSair.SetFocus()
683:                 RETURN
684:             ENDIF
685: 
686:             loc_lTrocarReps        = (THIS.chk_4c_ChkReps.Value   = 1)
687:             loc_lApagarContaAntiga = (THIS.chk_4c_Chk_DelCT.Value = 1)
688: 
689:             IF loc_lTrocarReps
690:                 *-- Troca apenas ContaVens em SigCdCli (representantes)
691:                 loc_lSucesso = THIS.this_oBusinessObject.TrocarContaRepresentantes()
692:             ELSE
693:                 *-- Processamento completo via catalogo ArqDBF
694:                 THIS.cnt_4c_Resultado.Visible = .T.
695:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.shp_4c_Barra.Width   = 0
696:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.lbl_4c_Porcento.Caption = "0 %"
697:                 THIS.cnt_4c_Resultado.Refresh()
698:                 loc_lSucesso = THIS.this_oBusinessObject.ProcessarMudancaContas( ;
699:                     loc_lApagarContaAntiga, THIS)
700:                 THIS.cnt_4c_Resultado.Visible = .F.
701:                 THIS.Refresh()
702:             ENDIF
703: 
704:             *-- Informar resultado
705:             IF loc_lSucesso
706:                 MsgAviso("Todas as Contas Foram Alteradas!!!", ;
707:                     "Processamento Encerrado!!!")
708:             ELSE
709:                 MsgAviso("As Contas N" + CHR(227) + "o Foram Alteradas!!!", ;
710:                     "Processamento Encerrado!!!")
711:             ENDIF
712: 
713:             *-- Reiniciar cursor para nova rodada
714:             IF USED("cursor_4c_Contas")
715:                 SELECT cursor_4c_Contas
716:                 SET ORDER TO
717:                 ZAP
718:                 APPEND BLANK
719:             ENDIF
720:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
721:                 THIS.grd_4c_Dados.Refresh()
722:             ENDIF
723:         CATCH TO loc_oErro
724:             MsgErro(loc_oErro.Message, "Erro no Processamento")
725:             TRY
726:                 THIS.cnt_4c_Resultado.Visible = .F.
727:                 THIS.Refresh()
728:             CATCH TO loc_oErroVis
729:                 *-- ignorar
730:             ENDTRY
731:         ENDTRY
732:     ENDPROC
733: 
734:     *--------------------------------------------------------------------------
735:     * CmdSairClick - Fechar o formulario
736:     *--------------------------------------------------------------------------
737:     PROCEDURE CmdSairClick()
738:         THIS.Release()
739:     ENDPROC
740: 
741:     *--------------------------------------------------------------------------
742:     * ChkRepsClick
743:     * Quando "Trocar Apenas Representantes" e marcado, desabilitar e limpar
744:     * "Apagar Conta Antiga" (legado: When = chkReps.Value = 0).
745:     *--------------------------------------------------------------------------
746:     PROCEDURE ChkRepsClick()
747:         IF THIS.chk_4c_ChkReps.Value = 1
748:             THIS.chk_4c_Chk_DelCT.Value   = 0
749:             THIS.chk_4c_Chk_DelCT.Enabled = .F.
750:         ELSE
751:             THIS.chk_4c_Chk_DelCT.Enabled = .T.
752:         ENDIF
753:     ENDPROC
754: 
755:     *--------------------------------------------------------------------------
756:     * GrdDadosKeyPress - F4 abre lookup para a coluna ativa (Conta Antiga/Nova)
757:     *--------------------------------------------------------------------------
758:     PROCEDURE GrdDadosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
759:         IF par_nKeyCode != 115  && Apenas F4
760:             RETURN
761:         ENDIF
762:         LOCAL loc_nColAtiva
763:         loc_nColAtiva = 0
764:         TRY
765:             loc_nColAtiva = THIS.grd_4c_Dados.ActiveColumn
766:         CATCH TO loc_oErro
767:             *-- ignorar
768:         ENDTRY
769:         IF loc_nColAtiva = 1
770:             THIS.AbrirLookupContaAnt()
771:         ELSE
772:             IF loc_nColAtiva = 2
773:             THIS.AbrirLookupContaNov()
774:             ENDIF
775:         ENDIF
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * GrdDadosAfterRowColChange
780:     * Ao mover para Coluna 2, valida ContaAnt do registro corrente.
781:     * Ao mover para Coluna 1 com ContaNov preenchida, valida ContaNov.
782:     * (Equivale aos Valid de Column1.Text1 e Column2.Text1 do legado.)
783:     *--------------------------------------------------------------------------
784:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
785:         IF THIS.this_lCheckCadPro
786:             RETURN
787:         ENDIF
788:         IF par_nColIndex = 2
789:             THIS.ValidarContaAnt()
790:         ELSE
791:             IF par_nColIndex = 1
792:             *-- Validar ContaNov apenas se tiver valor (usuario saiu da col 2)
793:             IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
794:                 IF NOT EMPTY(NVL(cursor_4c_Contas.ContaNov, ""))
795:                     THIS.ValidarContaNov()
796:                 ENDIF
797:             ENDIF
798:             ENDIF
799:         ENDIF
800:     ENDPROC
801: 
802:     *--------------------------------------------------------------------------
803:     * ValidarContaAnt
804:     * Valida ContaAnt do registro corrente contra SigCdCli. Se nao encontrado,
805:     * abre picker para selecao.
806:     *--------------------------------------------------------------------------
807:     PROCEDURE ValidarContaAnt()
808:         LOCAL loc_cValor, loc_cEncontrado
809:         loc_cValor      = ""
810:         loc_cEncontrado = ""
811:         TRY
812:             IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
813:                 loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, ""))
814:             ENDIF
815:             IF EMPTY(loc_cValor)
816:                 RETURN
817:             ENDIF
818:             loc_cEncontrado = THIS.this_oBusinessObject.ValidarCodigoConta(loc_cValor)
819:             IF EMPTY(loc_cEncontrado)
820:                 THIS.AbrirLookupContaAnt()
821:             ENDIF
822:         CATCH TO loc_oErro
823:             MsgErro(loc_oErro.Message, "Erro ao validar Conta Antiga")
824:         ENDTRY
825:     ENDPROC
826: 
827:     *--------------------------------------------------------------------------
828:     * ValidarContaNov
829:     * Valida ContaNov do registro corrente contra SigCdCli. Se nao encontrado,
830:     * abre picker para selecao.
831:     *--------------------------------------------------------------------------
832:     PROCEDURE ValidarContaNov()
833:         LOCAL loc_cValor, loc_cEncontrado
834:         loc_cValor      = ""
835:         loc_cEncontrado = ""
836:         TRY
837:             IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
838:                 loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))
839:             ENDIF
840:             IF EMPTY(loc_cValor)
841:                 RETURN
842:             ENDIF
843:             loc_cEncontrado = THIS.this_oBusinessObject.ValidarCodigoConta(loc_cValor)
844:             IF EMPTY(loc_cEncontrado)
845:                 THIS.AbrirLookupContaNov()
846:             ENDIF
847:         CATCH TO loc_oErro
848:             MsgErro(loc_oErro.Message, "Erro ao validar Conta Nova")
849:         ENDTRY
850:     ENDPROC
851: 
852:     *--------------------------------------------------------------------------
853:     * AbrirLookupContaAnt
854:     * Abre FormBuscaAuxiliar para selecao de Conta Antiga (SigCdCli.Iclis).
855:     *--------------------------------------------------------------------------
856:     PROCEDURE AbrirLookupContaAnt()
857:         LOCAL loc_oLista, loc_cValor
858:         loc_cValor = ""
859:         TRY
860:             IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
861:                 loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, ""))
862:             ENDIF
863:             loc_oLista = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
864:                 "SigCdCli", "cursor_4c_BuscaCli", "Iclis", loc_cValor, ;
865:                 "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
866:             loc_oLista.mAddColuna("Iclis",  "", "C" + CHR(243) + "digo")
867:             loc_oLista.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
868:             loc_oLista.mAddColuna("Grupos", "", "Grupo")
869:             loc_oLista.Show()
870:             IF loc_oLista.this_lSelecionou .AND. USED("cursor_4c_BuscaCli") .AND. ;
871:                RECCOUNT("cursor_4c_BuscaCli") > 0
872:                 SELECT cursor_4c_BuscaCli
873:                 IF NOT EOF()
874:                     SELECT cursor_4c_Contas
875:                     IF NOT EOF()
876:                         REPLACE cursor_4c_Contas.ContaAnt WITH ;
877:                             ALLTRIM(cursor_4c_BuscaCli.Iclis)
878:                     ENDIF
879:                 ENDIF
880:             ENDIF
881:         CATCH TO loc_oErro
882:             MsgErro(loc_oErro.Message, "Erro ao buscar Conta Antiga")
883:         ENDTRY
884:         IF USED("cursor_4c_BuscaCli")
885:             USE IN cursor_4c_BuscaCli
886:         ENDIF
887:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
888:             THIS.grd_4c_Dados.Refresh()
889:         ENDIF
890:     ENDPROC
891: 
892:     *--------------------------------------------------------------------------
893:     * AbrirLookupContaNov
894:     * Abre FormBuscaAuxiliar para selecao de Conta Nova (SigCdCli.Iclis).
895:     *--------------------------------------------------------------------------
896:     PROCEDURE AbrirLookupContaNov()
897:         LOCAL loc_oLista, loc_cValor
898:         loc_cValor = ""
899:         TRY
900:             IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
901:                 loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))
902:             ENDIF
903:             loc_oLista = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
904:                 "SigCdCli", "cursor_4c_BuscaCli", "Iclis", loc_cValor, ;
905:                 "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
906:             loc_oLista.mAddColuna("Iclis",  "", "C" + CHR(243) + "digo")
907:             loc_oLista.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
908:             loc_oLista.mAddColuna("Grupos", "", "Grupo")
909:             loc_oLista.Show()
910:             IF loc_oLista.this_lSelecionou .AND. USED("cursor_4c_BuscaCli") .AND. ;
911:                RECCOUNT("cursor_4c_BuscaCli") > 0
912:                 SELECT cursor_4c_BuscaCli
913:                 IF NOT EOF()
914:                     SELECT cursor_4c_Contas
915:                     IF NOT EOF()
916:                         REPLACE cursor_4c_Contas.ContaNov WITH ;
917:                             ALLTRIM(cursor_4c_BuscaCli.Iclis)
918:                     ENDIF
919:                 ENDIF
920:             ENDIF
921:         CATCH TO loc_oErro
922:             MsgErro(loc_oErro.Message, "Erro ao buscar Conta Nova")
923:         ENDTRY
924:         IF USED("cursor_4c_BuscaCli")
925:             USE IN cursor_4c_BuscaCli
926:         ENDIF
927:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
928:             THIS.grd_4c_Dados.Refresh()
929:         ENDIF
930:     ENDPROC
931: 
932:     *--------------------------------------------------------------------------
933:     * BtnIncluirClick
934:     * Adiciona novo par de contas em branco no grid (equivalente CRUD Incluir).
935:     * Roteia para CmdIncluirClick (mesmo handler do botao [Incluir] visivel).
936:     *--------------------------------------------------------------------------
937:     PROCEDURE BtnIncluirClick()
938:         THIS.CmdIncluirClick()
939:     ENDPROC
940: 
941:     *--------------------------------------------------------------------------
942:     * BtnAlterarClick
943:     * Coloca foco na Conta Antiga da linha corrente para edicao inline no grid.
944:     * Form OPERACIONAL: grid eh sempre editavel, nao ha modo separado ALTERAR.
945:     *--------------------------------------------------------------------------
946:     PROCEDURE BtnAlterarClick()
947:         TRY
948:             IF NOT USED("cursor_4c_Contas") OR RECCOUNT("cursor_4c_Contas") = 0
949:                 MsgAviso("N" + CHR(227) + "o existem pares de contas para alterar.", ;
950:                     "Aten" + CHR(231) + CHR(227) + "o")
951:                 RETURN
952:             ENDIF
953:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
954:                 THIS.grd_4c_Dados.SetFocus()
955:                 THIS.grd_4c_Dados.ActiveColumn = 1
956:                 IF VARTYPE(THIS.grd_4c_Dados.Column1.Text1) = "O"
957:                     THIS.grd_4c_Dados.Column1.Text1.SetFocus()
958:                 ENDIF
959:             ENDIF
960:         CATCH TO loc_oErro
961:             MsgErro(loc_oErro.Message, "Erro ao Alterar")
962:         ENDTRY
963:     ENDPROC
964: 
965:     *--------------------------------------------------------------------------
966:     * BtnVisualizarClick
967:     * Exibe as descricoes das Contas Antiga/Nova da linha corrente do grid.
968:     * Form OPERACIONAL: nao ha modo VISUALIZAR separado; consulta on-demand.
969:     *--------------------------------------------------------------------------
970:     PROCEDURE BtnVisualizarClick()
971:         LOCAL loc_cContaAnt, loc_cContaNov, loc_cDescAnt, loc_cDescNov, loc_cMsg
972:         loc_cContaAnt = ""
973:         loc_cContaNov = ""
974:         loc_cDescAnt  = ""
975:         loc_cDescNov  = ""
976:         TRY
977:             IF NOT USED("cursor_4c_Contas") OR EOF("cursor_4c_Contas")
978:                 MsgAviso("N" + CHR(227) + "o existem pares de contas para visualizar.", ;
979:                     "Aten" + CHR(231) + CHR(227) + "o")
980:                 RETURN
981:             ENDIF
982:             SELECT cursor_4c_Contas
983:             loc_cContaAnt = ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, ""))
984:             loc_cContaNov = ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))
985:             IF EMPTY(loc_cContaAnt) AND EMPTY(loc_cContaNov)
986:                 MsgAviso("Linha corrente n" + CHR(227) + "o tem contas preenchidas.", ;
987:                     "Aten" + CHR(231) + CHR(227) + "o")
988:                 RETURN
989:             ENDIF
990:             IF NOT EMPTY(loc_cContaAnt)
991:                 loc_cDescAnt = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cContaAnt)
992:             ENDIF
993:             IF NOT EMPTY(loc_cContaNov)
994:                 loc_cDescNov = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cContaNov)
995:             ENDIF
996:             loc_cMsg = "Conta Antiga: " + loc_cContaAnt + CHR(13) + ;
997:                        "Descri" + CHR(231) + CHR(227) + "o.: " + loc_cDescAnt + CHR(13) + CHR(13) + ;
998:                        "Conta Nova..: " + loc_cContaNov + CHR(13) + ;
999:                        "Descri" + CHR(231) + CHR(227) + "o.: " + loc_cDescNov
1000:             MsgInfo(loc_cMsg, "Visualizar Par de Contas")
1001:         CATCH TO loc_oErro
1002:             MsgErro(loc_oErro.Message, "Erro ao Visualizar")
1003:         ENDTRY
1004:     ENDPROC
1005: 
1006:     *--------------------------------------------------------------------------
1007:     * BtnExcluirClick
1008:     * Remove par de contas da linha corrente do grid (equivalente CRUD Excluir).
1009:     * Roteia para CmdExcluirClick (mesmo handler do botao [Excluir] visivel).
1010:     *--------------------------------------------------------------------------
1011:     PROCEDURE BtnExcluirClick()
1012:         IF NOT USED("cursor_4c_Contas") OR RECCOUNT("cursor_4c_Contas") = 0
1013:             MsgAviso("N" + CHR(227) + "o existem pares de contas para excluir.", ;
1014:                 "Aten" + CHR(231) + CHR(227) + "o")
1015:             RETURN
1016:         ENDIF
1017:         IF NOT MsgConfirma("Confirma a exclus" + CHR(227) + "o da linha corrente?", ;
1018:             "Confirma" + CHR(231) + CHR(227) + "o")
1019:             RETURN
1020:         ENDIF
1021:         THIS.CmdExcluirClick()
1022:     ENDPROC
1023: 
1024:     *--------------------------------------------------------------------------
1025:     * BtnEncerrarClick - Fechar o formulario (alias canonico para cmd Encerrar)
1026:     *--------------------------------------------------------------------------
1027:     PROCEDURE BtnEncerrarClick()
1028:         THIS.CmdSairClick()
1029:     ENDPROC
1030: 
1031:     *--------------------------------------------------------------------------
1032:     * BtnBuscarClick - Focar grid para edicao inline (busca e via F4 no grid)
1033:     *--------------------------------------------------------------------------
1034:     PROCEDURE BtnBuscarClick()
1035:         TRY
1036:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1037:                 THIS.grd_4c_Dados.SetFocus()
1038:                 THIS.grd_4c_Dados.ActiveColumn = 1
1039:             ENDIF
1040:         CATCH TO loc_oErro
1041:             *-- ignorar
1042:         ENDTRY
1043:     ENDPROC
1044: 
1045:     *--------------------------------------------------------------------------
1046:     * BtnSalvarClick - Aciona o processamento principal (semantica CRUD Salvar)
1047:     *--------------------------------------------------------------------------
1048:     PROCEDURE BtnSalvarClick()
1049:         THIS.CmdProcessarClick()
1050:     ENDPROC
1051: 
1052:     *--------------------------------------------------------------------------
1053:     * BtnCancelarClick - Limpa a lista de pares (semantica CRUD Cancelar)
1054:     *--------------------------------------------------------------------------
1055:     PROCEDURE BtnCancelarClick()
1056:         THIS.LimparCampos()
1057:     ENDPROC
1058: 
1059:     *--------------------------------------------------------------------------
1060:     * FormParaBO
1061:     * Transfere estado dos controles do form para propriedades do BO.
1062:     * Para este OPERACIONAL: repassa flags dos checkboxes.
1063:     *--------------------------------------------------------------------------
1064:     PROCEDURE FormParaBO()
1065:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1066:             RETURN
1067:         ENDIF
1068:         TRY
1069:             THIS.this_oBusinessObject.this_lCheckCadPro       = THIS.this_lCheckCadPro
1070:             THIS.this_oBusinessObject.this_lTrocarReps        = (THIS.chk_4c_ChkReps.Value = 1)
1071:             THIS.this_oBusinessObject.this_lApagarContaAntiga = (THIS.chk_4c_Chk_DelCT.Value = 1)
1072:         CATCH TO loc_oErro
1073:             MsgErro(loc_oErro.Message, "Erro em FormParaBO")
1074:         ENDTRY
1075:     ENDPROC
1076: 
1077:     *--------------------------------------------------------------------------
1078:     * BOParaForm
1079:     * Carrega propriedades do BO nos controles do form.
1080:     * Para este OPERACIONAL: reflete flags de configuracao nos checkboxes.
1081:     *--------------------------------------------------------------------------
1082:     PROCEDURE BOParaForm()
1083:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1084:             RETURN
1085:         ENDIF
1086:         TRY
1087:             THIS.chk_4c_ChkReps.Value   = IIF(THIS.this_oBusinessObject.this_lTrocarReps, 1, 0)
1088:             THIS.chk_4c_Chk_DelCT.Value = IIF(THIS.this_oBusinessObject.this_lApagarContaAntiga, 1, 0)
1089:         CATCH TO loc_oErro
1090:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
1091:         ENDTRY
1092:     ENDPROC
1093: 
1094:     *--------------------------------------------------------------------------
1095:     * HabilitarCampos
1096:     * Habilita ou desabilita os botoes de acao do formulario.
1097:     * par_lHabilitar: .T. para habilitar, .F. para desabilitar (default .T.)
1098:     *--------------------------------------------------------------------------
1099:     PROCEDURE HabilitarCampos(par_lHabilitar)
1100:         LOCAL loc_lAtivar
1101:         loc_lAtivar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1102:         TRY
1103:             WITH THIS.cnt_4c_Botoes
1104:                 .cmd_4c_BtnIncluir.Enabled   = loc_lAtivar
1105:                 .cmd_4c_BtnExcluir.Enabled   = loc_lAtivar
1106:                 .cmd_4c_Exporta.Enabled      = loc_lAtivar
1107:                 .cmd_4c_BtnProcessar.Enabled = loc_lAtivar
1108:                 .Visible     = .T.
1109:             ENDWITH
1110:         CATCH TO loc_oErro
1111:             *-- ignorar erro de habilitacao
1112:         ENDTRY
1113:     ENDPROC
1114: 
1115:     *--------------------------------------------------------------------------
1116:     * LimparCampos
1117:     * Reinicia cursor_4c_Contas com um registro em branco e limpa checkboxes.
1118:     *--------------------------------------------------------------------------
1119:     PROCEDURE LimparCampos()
1120:         TRY
1121:             IF USED("cursor_4c_Contas")
1122:                 SELECT cursor_4c_Contas
1123:                 SET ORDER TO
1124:                 ZAP
1125:                 APPEND BLANK
1126:             ENDIF
1127:             THIS.chk_4c_ChkReps.Value    = 0
1128:             THIS.chk_4c_Chk_DelCT.Value  = 0
1129:             THIS.chk_4c_Chk_DelCT.Enabled = .T.
1130:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1131:                 THIS.grd_4c_Dados.Refresh()
1132:             ENDIF
1133:         CATCH TO loc_oErro
1134:             MsgErro(loc_oErro.Message, "Erro ao limpar")
1135:         ENDTRY
1136:     ENDPROC
1137: 
1138:     *--------------------------------------------------------------------------
1139:     * CarregarLista
1140:     * Atualiza a exibicao do grid com o estado corrente do cursor_4c_Contas.
1141:     * Returns: .T. em sucesso
1142:     *--------------------------------------------------------------------------
1143:     FUNCTION CarregarLista()
1144:         LOCAL loc_lSucesso
1145:         loc_lSucesso = .F.
1146:         TRY
1147:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1148:                 THIS.grd_4c_Dados.Refresh()
1149:             ENDIF
1150:             loc_lSucesso = .T.
1151:         CATCH TO loc_oErro
1152:             MsgErro(loc_oErro.Message, "Erro ao carregar lista")
1153:         ENDTRY
1154:         RETURN loc_lSucesso
1155:     ENDFUNC
1156: 
1157:     *--------------------------------------------------------------------------
1158:     * AjustarBotoesPorModo
1159:     * Ajusta estado dos botoes conforme conteudo do cursor.
1160:     * Excluir e Processar so ficam ativos se houver pares cadastrados.
1161:     *--------------------------------------------------------------------------
1162:     PROCEDURE AjustarBotoesPorModo(par_cModo)
1163:         LOCAL loc_lTemRegistros
1164:         loc_lTemRegistros = USED("cursor_4c_Contas") AND ;
1165:                             NOT EOF("cursor_4c_Contas") AND ;
1166:                             NOT EMPTY(NVL(cursor_4c_Contas.ContaAnt, ""))
1167:         TRY
1168:             WITH THIS.cnt_4c_Botoes
1169:                 .cmd_4c_BtnExcluir.Enabled   = loc_lTemRegistros
1170:                 .cmd_4c_BtnProcessar.Enabled = loc_lTemRegistros
1171:                 .Visible     = .T.
1172:             ENDWITH
1173:         CATCH TO loc_oErro
1174:             *-- ignorar erro de ajuste
1175:         ENDTRY
1176:     ENDPROC
1177: 
1178:     *--------------------------------------------------------------------------
1179:     * FormatarGridLista
1180:     * Aplica formatacao visual padrao ao grid de pares de contas.
1181:     *--------------------------------------------------------------------------
1182:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1183:         WITH par_oGrid
1184:             .FontName = "Verdana"
1185:             .FontSize = 8
1186:         ENDWITH
1187:     ENDPROC
1188: 
1189: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrMdcBO.prg):
*==============================================================================
* Classe  : SigPrMdcBO
* Herda de: BusinessBase
* Descricao: BO para processamento de mudanca de conta (Muda Conta)
*            Valida pares ContaAnt/ContaNov, importa de XLS e aplica UPDATE
*            em multiplas tabelas do banco conforme catalogo ArqDBF.
*            Form OPERACIONAL - sem CRUD padrao, sem this_cTabela/CampoChave.
*==============================================================================
DEFINE CLASS SigPrMdcBO AS BusinessBase

    *-- Flags de configuracao do processamento
    this_lCheckCadPro       = .F.   && Validar codigo de conta contra SigCdCli
    this_lTrocarReps        = .F.   && Trocar apenas representantes (ContaVens em SigCdCli)
    this_lApagarContaAntiga = .F.   && Apagar conta antiga de SigCdCli apos troca

    *-- Estado do progresso (lido pelo Form para atualizar UI)
    this_cArquivoAtual      = ""    && Arquivo/campo em processamento
    this_nProgresso         = 0     && Progresso 0-100

    *-- Caminho completo do ArqDBF.DBF (sem extensao) - setado por ValidarArqDBF
    this_cArqDBFPath        = ""

    *-- Par corrente de contas (usado por CarregarDoCursor/Inserir/Atualizar)
    this_cContaAnt          = ""
    this_cContaNov          = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - override para auditoria operacional
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "MUDACONTA"
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursorContas
    * Cria cursor_4c_Contas com estrutura e registro inicial em branco.
    * Deve ser chamado por FormSigPrMdc.InicializarForm().
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarCursorContas()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Contas (ContaAnt C(10) NULL, ContaNov C(10) NULL)
            SET NULL OFF
            INDEX ON ContaAnt + ContaNov TAG Duplica
            INDEX ON ContaAnt            TAG ContaAnt
            INDEX ON ContaNov            TAG ContaNov
            SET ORDER TO
            INSERT INTO cursor_4c_Contas (ContaAnt, ContaNov) VALUES ('', '')
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarArqDBF
    * Verifica se ArqDBF.DBF existe no diretorio corrente do sistema.
    * Seta this_cArqDBFPath com caminho completo (sem extensao).
    * Returns: .T. se existe, .F. se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarArqDBF()
        LOCAL loc_lSucesso, loc_cCaminho
        loc_lSucesso = .F.
        loc_cCaminho = ""
        TRY
            loc_cCaminho = SYS(5) + SYS(2003) + "\ArqDBF"
            IF NOT FILE(loc_cCaminho + ".dbf")
                MsgAviso("O ArqDBF n" + CHR(227) + "o est" + CHR(225) + ;
                    " no diret" + CHR(243) + "rio do Sistema!!!", "Aviso")
            ELSE
                THIS.this_cArqDBFPath = loc_cCaminho
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * IncluirParConta
    * Adiciona linha em branco ao cursor_4c_Contas somente se a linha
    * corrente ja estiver preenchida (ContaAnt e ContaNov nao vazios).
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION IncluirParConta()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Contas
            IF !EMPTY(cursor_4c_Contas.ContaAnt) .AND. !EMPTY(cursor_4c_Contas.ContaNov)
                APPEND BLANK
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirParConta
    * Marca o registro corrente de cursor_4c_Contas como excluido.
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION ExcluirParConta()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Contas
            DELETE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParesContas
    * Valida todos os pares em cursor_4c_Contas:
    *   - Nao pode estar vazio (ContaAnt ou ContaNov)
    *   - Nao pode ter ContaAnt = ContaNov
    * par_cMensagem: [BYREF] mensagem de erro se houver
    * Returns: .T. se todos validos, .F. se houver erro
    *--------------------------------------------------------------------------
    FUNCTION ValidarParesContas(par_cMensagem)
        LOCAL loc_lValido
        loc_lValido   = .F.
        par_cMensagem = ""
        TRY
            SELECT cursor_4c_Contas
            GO TOP
            IF EOF()
                par_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
            ELSE
                loc_lValido = .T.
                SCAN
                    IF EMPTY(cursor_4c_Contas.ContaAnt)
                        par_cMensagem = "Existe Uma Conta Antiga Inv" + CHR(225) + "lida!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                    IF EMPTY(cursor_4c_Contas.ContaNov)
                        par_cMensagem = "Existe Uma Conta Nova Inv" + CHR(225) + "lida!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                    IF cursor_4c_Contas.ContaAnt = cursor_4c_Contas.ContaNov
                        par_cMensagem = "Existe Uma Conta Antiga e Uma Conta Nova " + ;
                            "Com o Mesmo C" + CHR(243) + "digo!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCodigoConta
    * Verifica se um codigo de conta existe em SigCdCli.
    * par_cConta: codigo a validar
    * Returns: ALLTRIM(Iclis) se encontrado, "" se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigoConta(par_cConta)
        LOCAL loc_cResultado, loc_cSQL, loc_nRet
        loc_cResultado = ""
        TRY
            IF NOT EMPTY(par_cConta)
                loc_cSQL = "SELECT Iclis FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidCli")
                IF loc_nRet >= 1 .AND. RECCOUNT("cursor_4c_ValidCli") > 0
                    SELECT cursor_4c_ValidCli
                    loc_cResultado = ALLTRIM(cursor_4c_ValidCli.Iclis)
                ENDIF
                IF USED("cursor_4c_ValidCli")
                    USE IN cursor_4c_ValidCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValidCli")
                USE IN cursor_4c_ValidCli
            ENDIF
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoConta
    * Retorna a Razao Social (Rclis) da conta em SigCdCli. String vazia se
    * conta nao existir. Usada por BtnVisualizarClick do Form.
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoConta(par_cConta)
        LOCAL loc_cResultado, loc_cSQL, loc_nRet
        loc_cResultado = ""
        TRY
            IF NOT EMPTY(par_cConta)
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCli")
                IF loc_nRet >= 1 .AND. RECCOUNT("cursor_4c_DescCli") > 0
                    SELECT cursor_4c_DescCli
                    loc_cResultado = ALLTRIM(NVL(cursor_4c_DescCli.Rclis, ""))
                ENDIF
                IF USED("cursor_4c_DescCli")
                    USE IN cursor_4c_DescCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DescCli")
                USE IN cursor_4c_DescCli
            ENDIF
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarDeXLS
    * Importa arquivo XLS e carrega pares em cursor_4c_Contas.
    * Valida ContaAnt contra SigCdCli (se this_lCheckCadPro = .F.).
    * Deduplica via TAG Duplica antes de inserir.
    * par_cArquivo: caminho completo do arquivo XLS (ja validado pela UI)
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION ImportarDeXLS(par_cArquivo)
        LOCAL loc_lSucesso, loc_nTotal, loc_nCont
        LOCAL loc_cContaAnt, loc_cContaNov, loc_cSQL, loc_nRet
        loc_lSucesso  = .F.
        loc_nTotal    = 0
        loc_nCont     = 0
        loc_cContaAnt = ""
        loc_cContaNov = ""
        loc_cSQL      = ""
        loc_nRet      = 0
        TRY
            IF EMPTY(par_cArquivo)
                MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o informado!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF NOT FILE(par_cArquivo)
                MsgAviso("O Arquivo [" + ALLTRIM(par_cArquivo) + "]" + CHR(13) + ;
                    "N" + CHR(227) + "o Foi Encontrado ou o Acesso " + ;
                    "Foi Negado!!! Verifique!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor temporario de importacao
            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            CREATE CURSOR cursor_4c_Importa (ContaAnt C(10), ContaNov C(10))
            INDEX ON ContaAnt TAG Contas
            SET ORDER TO

            *-- Importar registros do XLS
            SELECT cursor_4c_Importa
            APPEND FROM (par_cArquivo) TYPE XLS

            loc_nTotal = RECCOUNT("cursor_4c_Importa")
            loc_nCont  = 0

            SELECT cursor_4c_Importa
            SCAN
                loc_nCont     = loc_nCont + 1
                loc_cContaAnt = cursor_4c_Importa.ContaAnt
                loc_cContaNov = cursor_4c_Importa.ContaNov

                IF EMPTY(loc_cContaAnt) OR EMPTY(loc_cContaNov)
                    LOOP
                ENDIF
                IF loc_cContaAnt = loc_cContaNov
                    LOOP
                ENDIF

                *-- Validar ContaAnt contra SigCdCli se nao em modo CheckCadPro
                IF NOT THIS.this_lCheckCadPro
                    loc_cSQL = "SELECT Iclis FROM SigCdCli WHERE Iclis = " + ;
                        EscaparSQL(ALLTRIM(loc_cContaAnt))
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp")
                    IF loc_nRet < 1 OR RECCOUNT("cursor_4c_CliImp") = 0
                        IF USED("cursor_4c_CliImp")
                            USE IN cursor_4c_CliImp
                        ENDIF
                        LOOP
                    ENDIF
                    IF USED("cursor_4c_CliImp")
                        USE IN cursor_4c_CliImp
                    ENDIF
                ENDIF

                *-- Inserir em cursor_4c_Contas somente se nao duplicado
                SELECT cursor_4c_Contas
                SET ORDER TO Duplica
                IF NOT SEEK(m.loc_cContaAnt + m.loc_cContaNov)
                    APPEND BLANK
                    REPLACE cursor_4c_Contas.ContaAnt WITH loc_cContaAnt, ;
                            cursor_4c_Contas.ContaNov WITH loc_cContaNov
                ENDIF

                *-- Restaurar para o cursor de importacao (proxima iteracao SCAN)
                SELECT cursor_4c_Importa
            ENDSCAN

            *-- Posicionar no final e limpar ordem
            SELECT cursor_4c_Contas
            SET ORDER TO
            GO BOTTOM

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            IF USED("cursor_4c_CliImp")
                USE IN cursor_4c_CliImp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * TrocarContaRepresentantes
    * Troca ContaVens em SigCdCli para todos os pares em cursor_4c_Contas.
    * Executa em transacao SQL Server (COMMIT em sucesso, ROLLBACK em falha).
    * Permite retry interativo em caso de falha (mesma logica do legado).
    * Returns: .T. em sucesso (COMMIT), .F. em falha (ROLLBACK)
    *--------------------------------------------------------------------------
    FUNCTION TrocarContaRepresentantes()
        LOCAL loc_lSucesso, loc_cUpdate, loc_nErro
        loc_lSucesso = .F.
        loc_nErro    = 1
        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            SELECT cursor_4c_Contas
            SCAN
                loc_cUpdate = "UPDATE SigCdCli SET ContaVens = " + ;
                    EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaNov)) + ;
                    " WHERE ContaVens = " + ;
                    EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaAnt))

                loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_TrocaRet")
                IF USED("cursor_4c_TrocaRet")
                    USE IN cursor_4c_TrocaRet
                ENDIF

                IF loc_nErro < 1
                    IF MsgConfirma("Falha ao Tentar Trocar a Conta '" + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + "'" + CHR(13) + ;
                        "Deseja Tentar Novamente?", "Aten" + CHR(231) + CHR(227) + "o!!!")
                        SELECT cursor_4c_Contas
                        SKIP -1
                        LOOP
                    ELSE
                        EXIT
                    ENDIF
                ENDIF
            ENDSCAN

            IF loc_nErro < 1
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 COMMIT TRANSACTION")
                *-- Auditoria
                SELECT cursor_4c_Contas
                SCAN
                    THIS.RegistrarAuditoria("TROCA_REP: " + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + " -> " + ;
                        ALLTRIM(cursor_4c_Contas.ContaNov))
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            CATCH TO loc_oErroTran
                *-- ignorar erro de rollback
            ENDTRY
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarMudancaContas
    * Processamento principal: itera sobre o catalogo ArqDBF.DBF e aplica
    * UPDATE (ou DELETE para SIGMVSLC/SIGMVEST) em todos os campos de todas
    * as tabelas que referenciam os codigos de conta em cursor_4c_Contas.
    *
    * Casos especiais:
    *   SIGMVCCR/CONTAS   -> atualiza GruConMoes + chama fRecalculaS
    *   SIGCDCLI/ICLIS    -> verifica se ContaNov existe; deleta ContaAnt se par_lApagarContaAntiga
    *   SIGMVHST/ESTOS    -> atualiza EmpGruEsts + chama fRecalculaP + fRecalculaC
    *   SIGCDCLH/ICLIS    -> atualiza GruContas
    *   SIGMVSLC/SIGMVEST -> DELETE (nao UPDATE)
    *
    * par_lApagarContaAntiga: apagar ContaAnt de SigCdCli apos troca
    * par_oForm: referencia ao Form para atualizacao de progresso (opcional)
    *            O Form deve ter PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
    * Returns: .T. em sucesso (COMMIT), .F. em falha (ROLLBACK)
    *--------------------------------------------------------------------------
    FUNCTION ProcessarMudancaContas(par_lApagarContaAntiga, par_oForm)
        LOCAL loc_lSucesso, loc_nErro, loc_nRec, loc_nCnt
        LOCAL loc_cArq, loc_cCpo, loc_cUpdate, loc_cDelete, loc_cWhere
        LOCAL loc_cContaNovSalvo, loc_lContaNovExiste, loc_nChkRet, loc_cChkSQL
        loc_lSucesso        = .F.
        loc_nErro           = 1
        loc_nRec            = 0
        loc_nCnt            = 0
        loc_cArq            = ""
        loc_cCpo            = ""
        loc_cUpdate         = ""
        loc_cDelete         = ""
        loc_cWhere          = ""
        loc_cContaNovSalvo  = ""
        loc_lContaNovExiste = .F.
        loc_nChkRet         = 0
        loc_cChkSQL         = ""
        TRY
            IF NOT THIS.ValidarArqDBF()
                loc_lSucesso = .F.
            ENDIF

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            *-- Fechar cursores anteriores se abertos
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF

            *-- Consultar catalogo ArqDBF (SELECT VFP local sobre DBF)
            SELECT Arquivos, Campos ;
            FROM (THIS.this_cArqDBFPath) ;
            WHERE (Tamanhos = 10 OR UPPER(Campos) = 'CLIFORS') AND ;
                  UPPER(Tipos) = 'C' AND ;
                  NOT EMPTY(Dbcs) AND ;
                  Arquivos # 'ArqDBF.DBF' AND ;
                  UPPER(Arquivos) # 'SIGTEMPC.DBF' AND ;
                  UPPER(Arquivos) # 'SIGCDCE.DBF' AND ;
                  UPPER(Arquivos) # 'SIGCDCEE.DBF' AND ;
                  UPPER(Arquivos) # 'SIGALERT.DBF' AND ;
                  INLIST(UPPER(SUBS(Arquivos, 1, 3)), 'SIG') AND ;
                  (AT('CON',    UPPER(Campos)) # 0 OR ;
                   AT('IFOR',   UPPER(Campos)) # 0 OR ;
                   AT('ESTOS',  UPPER(Campos)) # 0 OR ;
                   AT('CLI',    UPPER(Campos)) # 0 OR ;
                   AT('VEN',    UPPER(Campos)) # 0 OR ;
                   AT('RESP',   UPPER(Campos)) # 0) AND ;
                  AT('USU',     UPPER(Campos)) = 0 AND ;
                  AT('GR',      UPPER(Campos)) = 0 AND ;
                  AT('NCONTAS', UPPER(Campos)) = 0 AND ;
                  AT('NRCONS',  UPPER(Campos)) = 0 AND ;
                  AT('CCUSTOS', UPPER(Campos)) = 0 ;
            ORDER BY Arquivos ;
            INTO CURSOR csCampos READWRITE
            INDEX ON Arquivos + Campos TAG ArqCpo

            SELECT DISTINCT Arquivos ;
            FROM csCampos ;
            ORDER BY Arquivos ;
            INTO CURSOR csArquivos READWRITE

            loc_nCnt               = RECCOUNT("csArquivos")
            THIS.this_nProgresso   = 0
            THIS.this_cArquivoAtual = ""

            *-- SCAN externo: cada arquivo do catalogo
            SELECT csArquivos
            SCAN
                loc_cArq = ALLTRIM(STRTRAN(csArquivos.Arquivos, '.DBF', ''))
                THIS.this_cArquivoAtual = loc_cArq
                IF VARTYPE(par_oForm) = "O"
                    par_oForm.AtualizarProgresso(loc_cArq, THIS.this_nProgresso)
                ENDIF

                *-- SCAN medio: cada campo deste arquivo
                SELECT csCampos
                SEEK csArquivos.Arquivos
                SCAN WHILE csArquivos.Arquivos = csCampos.Arquivos .AND. !EOF()
                    loc_cCpo = ALLTRIM(csCampos.Campos)
                    THIS.this_cArquivoAtual = loc_cArq + ' / ' + loc_cCpo
                    IF VARTYPE(par_oForm) = "O"
                        par_oForm.AtualizarProgresso(THIS.this_cArquivoAtual, THIS.this_nProgresso)
                    ENDIF

                    *-- SCAN interno: cada par de contas
                    SELECT cursor_4c_Contas
                    SCAN
                        *-- Caso especial: SIGMVCCR/CONTAS -> recalcular saldo antes de UPDATE
                        IF loc_cArq == 'SIGMVCCR' AND loc_cCpo = 'CONTAS'
                            loc_cWhere = "SELECT DISTINCT Emps, Grupos, Contas, Moedas " + ;
                                "FROM SigMvCcr WHERE " + loc_cCpo + " = '" + ;
                                PADR(cursor_4c_Contas.ContaAnt, 10) + "'"
                            SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_Mccr")
                            IF USED("cursor_4c_Mccr") AND RECCOUNT("cursor_4c_Mccr") > 0
                                loc_cContaNovSalvo = cursor_4c_Contas.ContaNov
                                SELECT cursor_4c_Mccr
                                SCAN
                                    TRY
                                        =fRecalculaS(cursor_4c_Mccr.Grupos, ;
                                            m.loc_cContaNovSalvo, ;
                                            CTOD('01/01/1900'), ;
                                            cursor_4c_Mccr.Moedas, ;
                                            gnConnHandle)
                                    CATCH TO loc_oErroF
                                        *-- fRecalculaS nao portada - pular recalculo
                                    ENDTRY
                                ENDSCAN
                                IF USED("cursor_4c_Mccr")
                                    USE IN cursor_4c_Mccr
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Caso especial: SIGCDCLI/ICLIS
                        *-- Verifica se ContaNov ja existe; se sim, deleta ContaAnt e pula UPDATE
                        IF loc_cArq == 'SIGCDCLI' AND loc_cCpo = 'ICLIS'
                            loc_cChkSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli " + ;
                                "WHERE Iclis = " + EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaNov))
                            loc_nChkRet = SQLEXEC(gnConnHandle, loc_cChkSQL, "cursor_4c_ChkCli")
                            loc_lContaNovExiste = .F.
                            IF loc_nChkRet >= 1 AND RECCOUNT("cursor_4c_ChkCli") > 0
                                SELECT cursor_4c_ChkCli
                                loc_lContaNovExiste = (NVL(cursor_4c_ChkCli.nExiste, 0) > 0)
                            ENDIF
                            IF USED("cursor_4c_ChkCli")
                                USE IN cursor_4c_ChkCli
                            ENDIF

                            IF loc_lContaNovExiste
                                *-- ContaNov ja existe: deletar ContaAnt se solicitado
                                IF par_lApagarContaAntiga
                                    loc_cDelete = "DELETE FROM SigCdCli WHERE Iclis = " + ;
                                        EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaAnt))
                                    SQLEXEC(gnConnHandle, loc_cDelete, "cursor_4c_DelCli")
                                    IF USED("cursor_4c_DelCli")
                                        USE IN cursor_4c_DelCli
                                    ENDIF
                                ENDIF
                                SELECT cursor_4c_Contas
                                LOOP
                            ENDIF
                            *-- ContaNov nao existe: cai no UPDATE padrao abaixo (UPDATE ICLIS)
                        ENDIF

                        *-- Caso especial: SIGMVSLC ou SIGMVEST -> DELETE em vez de UPDATE
                        IF loc_cArq == 'SIGMVSLC' OR loc_cArq == 'SIGMVEST'
                            loc_cDelete = "DELETE FROM " + loc_cArq + ;
                                " WHERE " + loc_cCpo + " = '" + ;
                                cursor_4c_Contas.ContaAnt + "'"
                            loc_nErro = SQLEXEC(gnConnHandle, loc_cDelete, "cursor_4c_DelRet")
                            IF USED("cursor_4c_DelRet")
                                USE IN cursor_4c_DelRet
                            ENDIF
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!! " + ;
                                    "Tentar Novamente?", "Erro de Processamento")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF
                        ELSE
                            *-- UPDATE padrao (casos gerais e casos especiais com campos extras)
                            IF loc_cArq == 'SIGMVCCR' AND loc_cCpo = 'CONTAS'
                                loc_cUpdate = "UPDATE " + loc_cArq + ;
                                    " SET " + loc_cCpo + " = '" + ;
                                    cursor_4c_Contas.ContaNov + ;
                                    "', GruConMoes = Grupos + '" + ;
                                    cursor_4c_Contas.ContaNov + ;
                                    "' + Moedas WHERE " + loc_cCpo + " = '" + ;
                                    cursor_4c_Contas.ContaAnt + "'"
                            ELSE
                                IF loc_cArq == 'SIGMVHST' AND loc_cCpo = 'ESTOS'
                                    *-- Recalcular historico antes de UPDATE
                                    loc_cWhere = "SELECT DISTINCT Emps, Grupos, Estos, " + ;
                                        "Cpros, CodCors, CodTams FROM SigMvHst WHERE " + ;
                                        loc_cCpo + " = '" + ;
                                        PADR(cursor_4c_Contas.ContaAnt, 10) + "'"
                                    SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_His")
                                    IF USED("cursor_4c_His") AND RECCOUNT("cursor_4c_His") > 0
                                        loc_cContaNovSalvo = cursor_4c_Contas.ContaNov
                                        SELECT cursor_4c_His
                                        SCAN
                                            TRY
                                                =fRecalculaP(cursor_4c_His.Emps, ;
                                                    cursor_4c_His.Grupos, ;
                                                    m.loc_cContaNovSalvo, ;
                                                    cursor_4c_His.Cpros, ;
                                                    CTOD('01/01/1900'), ;
                                                    cursor_4c_His.CodCors, ;
                                                    cursor_4c_His.CodTams, ;
                                                    gnConnHandle)
                                                =fRecalculaC(cursor_4c_His.Emps, ;
                                                    cursor_4c_His.Cpros, ;
                                                    CTOD('01/01/1900'), ;
                                                    gnConnHandle)
                                            CATCH TO loc_oErroF
                                                *-- fRecalculaP/C nao portadas - pular recalculo
                                            ENDTRY
                                        ENDSCAN
                                        IF USED("cursor_4c_His")
                                            USE IN cursor_4c_His
                                        ENDIF
                                    ENDIF
                                    loc_cUpdate = "UPDATE " + loc_cArq + ;
                                        " SET " + loc_cCpo + " = '" + ;
                                        cursor_4c_Contas.ContaNov + ;
                                        "', EmpGruEsts = Emps + Grupos + '" + ;
                                        cursor_4c_Contas.ContaNov + ;
                                        "' WHERE " + loc_cCpo + " = '" + ;
                                        cursor_4c_Contas.ContaAnt + "'"
                                ELSE
                                    IF loc_cArq == 'SIGCDCLH' AND loc_cCpo = 'ICLIS'
                                        loc_cUpdate = "UPDATE " + loc_cArq + ;
                                            " SET " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "', GruContas = Grupos + '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "' WHERE " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaAnt + "'"
                                    ELSE
                                        loc_cUpdate = "UPDATE " + loc_cArq + ;
                                            " SET " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "' WHERE " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaAnt + "'"
                                    ENDIF
                                ENDIF
                            ENDIF

                            loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_UpdRet")
                            IF USED("cursor_4c_UpdRet")
                                USE IN cursor_4c_UpdRet
                            ENDIF
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!! " + ;
                                    "Tentar Novamente?", "Erro de Processamento")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN  && cursor_4c_Contas

                    IF loc_nErro < 1
                        EXIT
                    ENDIF
                ENDSCAN  && csCampos WHILE

                IF loc_nErro < 1
                    EXIT
                ENDIF

                *-- Atualizar progresso
                SELECT csArquivos
                loc_nRec             = loc_nRec + 1
                THIS.this_nProgresso  = INT((loc_nRec * 100) / IIF(loc_nCnt > 0, loc_nCnt, 1))
                IF VARTYPE(par_oForm) = "O"
                    par_oForm.AtualizarProgresso(THIS.this_cArquivoAtual, THIS.this_nProgresso)
                ENDIF
            ENDSCAN  && csArquivos

            *-- Recalculos finais (funcoes legado - pular se nao portadas)
            IF loc_nErro > 0
                TRY
                    IF NOT fRecalculaS(.T., gnConnHandle, .T.)
                        loc_nErro = -1
                    ENDIF
                CATCH
                    *-- fRecalculaS nao portada - ignorar
                ENDTRY
            ENDIF
            IF loc_nErro > 0
                TRY
                    IF NOT fRecalculaP(.T., gnConnHandle)
                        loc_nErro = -1
                    ENDIF
                CATCH
                    *-- fRecalculaP nao portada - ignorar
                ENDTRY
            ENDIF
            IF loc_nErro > 0
                TRY
                    IF NOT fRecalculaC(.T., .F., .F., gnConnHandle)
                        loc_nErro = -1
                    ENDIF
                CATCH
                    *-- fRecalculaC nao portada - ignorar
                ENDTRY
            ENDIF

            *-- Commit ou Rollback
            IF loc_nErro < 1
                MsgAviso("Favor reinicializar o processo.", ;
                    "Falha na Conex" + CHR(227) + "o")
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 COMMIT TRANSACTION")
                *-- Auditoria de todas as trocas realizadas
                SELECT cursor_4c_Contas
                SCAN
                    THIS.RegistrarAuditoria("TROCA: " + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + ;
                        IIF(par_lApagarContaAntiga, ;
                            " (Exclu" + CHR(237) + "da)", "") + ;
                        " -> " + ALLTRIM(cursor_4c_Contas.ContaNov))
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF

            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Processamento")
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            CATCH TO loc_oErroTran
                *-- ignorar erro de rollback
            ENDTRY
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor
    * Carrega o par (ContaAnt, ContaNov) do registro corrente de um cursor
    * (tipicamente cursor_4c_Contas) para as propriedades da instancia.
    * Usado antes de operacoes de auditoria/edicao individual do par.
    * par_cAliasCursor: nome do cursor (default "cursor_4c_Contas")
    * Returns: .T. em sucesso, .F. se cursor nao existe ou EOF
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Contas", par_cAliasCursor)
        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                IF NOT EOF() AND NOT BOF()
                    THIS.this_cContaAnt = NVL(EVALUATE(loc_cAlias + ".ContaAnt"), "")
                    THIS.this_cContaNov = NVL(EVALUATE(loc_cAlias + ".ContaNov"), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir
    * Insere o par (this_cContaAnt, this_cContaNov) em cursor_4c_Contas apos
    * validar duplicidade via TAG Duplica e igualdade de codigos.
    * Registra auditoria no LogAuditoria em caso de sucesso.
    * Returns: .T. em sucesso, .F. se invalido ou duplicado
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cContaAnt) OR EMPTY(THIS.this_cContaNov)
                MsgAviso("Informe Conta Antiga e Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(THIS.this_cContaAnt) == ALLTRIM(THIS.this_cContaNov)
                MsgAviso("Conta Antiga n" + CHR(227) + "o pode ser igual " + ;
                    "" + CHR(224) + " Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            IF NOT USED("cursor_4c_Contas")
                THIS.InicializarCursorContas()
            ENDIF

            SELECT cursor_4c_Contas
            SET ORDER TO Duplica
            IF SEEK(THIS.this_cContaAnt + THIS.this_cContaNov)
                SET ORDER TO
                MsgAviso("Par de Contas j" + CHR(225) + " existe na lista.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            SET ORDER TO

            APPEND BLANK
            REPLACE cursor_4c_Contas.ContaAnt WITH THIS.this_cContaAnt, ;
                    cursor_4c_Contas.ContaNov WITH THIS.this_cContaNov

            THIS.RegistrarAuditoria("INCLUSAO_PAR: " + ;
                ALLTRIM(THIS.this_cContaAnt) + " -> " + ;
                ALLTRIM(THIS.this_cContaNov))

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Incluir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar
    * Atualiza o registro corrente de cursor_4c_Contas com
    * (this_cContaAnt, this_cContaNov) apos validar duplicidade e igualdade.
    * Registra auditoria no LogAuditoria em caso de sucesso.
    * Returns: .T. em sucesso, .F. se invalido, EOF ou duplicado
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cAntigoAnt, loc_cAntigoNov
        loc_lSucesso  = .F.
        loc_cAntigoAnt = ""
        loc_cAntigoNov = ""
        TRY
            IF EMPTY(THIS.this_cContaAnt) OR EMPTY(THIS.this_cContaNov)
                MsgAviso("Informe Conta Antiga e Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(THIS.this_cContaAnt) == ALLTRIM(THIS.this_cContaNov)
                MsgAviso("Conta Antiga n" + CHR(227) + "o pode ser igual " + ;
                    "" + CHR(224) + " Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF NOT USED("cursor_4c_Contas")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Contas
            IF EOF() OR BOF()
                MsgAviso("Nenhum registro selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            loc_cAntigoAnt = cursor_4c_Contas.ContaAnt
            loc_cAntigoNov = cursor_4c_Contas.ContaNov

            *-- Se par nao mudou, nada a fazer
            IF loc_cAntigoAnt == THIS.this_cContaAnt AND ;
               loc_cAntigoNov == THIS.this_cContaNov
                loc_lSucesso = .T.
            ENDIF

            REPLACE cursor_4c_Contas.ContaAnt WITH THIS.this_cContaAnt, ;
                    cursor_4c_Contas.ContaNov WITH THIS.this_cContaNov

            THIS.RegistrarAuditoria("ALTERACAO_PAR: (" + ;
                ALLTRIM(loc_cAntigoAnt) + " -> " + ALLTRIM(loc_cAntigoNov) + ;
                ") para (" + ALLTRIM(THIS.this_cContaAnt) + " -> " + ;
                ALLTRIM(THIS.this_cContaNov) + ")")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

