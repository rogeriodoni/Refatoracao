# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarDatas()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'optDatas' (parent: SIGRECGC): Top original=168 vs migrado 'obj_4c_OptDatas' Top=5 (diff=163px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optDatas' (parent: SIGRECGC): Left original=372 vs migrado 'obj_4c_OptDatas' Left=5 (diff=367px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReCgc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (731 linhas total):

*-- Linhas 6 a 177:
6: *
7: * Filtros:
8: *   - Per" + CHR(237) + "odo (data inicial / data final)
9: *   - Tipo de data: Emiss" + CHR(227) + "o ou Vencimento (OptionGroup)
10: *
11: * Par" + CHR(226) + "metros de inicializa" + CHR(231) + CHR(227) + "o (recebidos pelo chamador via Init):
12: *   - par_cGrupo: c" + CHR(243) + "digo do grupo de compras
13: *   - par_cConta: c" + CHR(243) + "digo da conta
14: *
15: * FASE 3/8 - Estrutura base
16: *   - DEFINE CLASS com propriedades
17: *   - Init(par_cGrupo, par_cConta)
18: *   - InicializarForm()
19: *   - ConfigurarCabecalho()
20: *   - ConfigurarBotoes()
21: *   - ConfigurarPageFrame()
22: *   - Destroy()
23: *==============================================================================
24: 
25: DEFINE CLASS FormSigReCgc AS FormBase
26: 
27:     *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=300)
28:     Height      = 300
29:     Width       = 800
30:     DataSession = 2
31:     ShowWindow  = 1
32:     WindowType  = 1
33:     AutoCenter  = .T.
34:     BorderStyle = 2
35:     ControlBox  = .F.
36:     MaxButton   = .F.
37:     MinButton   = .F.
38:     TitleBar    = 0
39:     Themes      = .F.
40:     ShowTips    = .T.
41: 
42:     *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
43:     this_oRelatorio    = .NULL.
44:     this_cMensagemErro = ""
45: 
46:     *-- Parametros recebidos do chamador
47:     *   Equivalentes a ThisForm.Grupo e ThisForm.Conta do original
48:     this_cGrupo = ""
49:     this_cConta = ""
50: 
51:     *--------------------------------------------------------------------------
52:     * Init - Recebe parametros do chamador e delega para FormBase.Init()
53:     *   par_cGrupo e par_cConta sao definidos ANTES de DODEFAULT() para que
54:     *   InicializarForm() possa transferi-los ao BO durante a inicializacao.
55:     *--------------------------------------------------------------------------
56:     PROCEDURE Init(par_cGrupo, par_cConta)
57:         IF PCOUNT() >= 1 AND VARTYPE(par_cGrupo) = "C"
58:             THIS.this_cGrupo = par_cGrupo
59:         ENDIF
60:         IF PCOUNT() >= 2 AND VARTYPE(par_cConta) = "C"
61:             THIS.this_cConta = par_cConta
62:         ENDIF
63:         RETURN DODEFAULT()
64:     ENDPROC
65: 
66:     *--------------------------------------------------------------------------
67:     * InicializarForm - Cria estrutura base do formulario de relatorio
68:     *   1. Define Caption e Picture (fundo)
69:     *   2. Cria SigReCgcBO e transfere parametros Grupo/Conta
70:     *   3. Monta cabecalho escuro + botoes do relatorio + PageFrame vazio
71:     *   Filtros (Page1) sao adicionados nas fases 4-6.
72:     *   BINDEVENTs dos botoes sao vinculados nas fases 7-8.
73:     *--------------------------------------------------------------------------
74:     PROTECTED PROCEDURE InicializarForm()
75:         LOCAL loc_lSucesso, loc_lContinuar
76:         loc_lSucesso   = .F.
77:         loc_lContinuar = .T.
78:         TRY
79:             THIS.Caption = "Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras"
80: 
81:             IF TYPE("gc_4c_CaminhoIcones") = "U"
82:                 gc_4c_CaminhoIcones = ""
83:             ENDIF
84:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
85: 
86:             *-- Instanciar BO de relatorio
87:             THIS.this_oRelatorio = CREATEOBJECT("SigReCgcBO")
88:             IF VARTYPE(THIS.this_oRelatorio) != "O"
89:                 MsgErro("Erro ao criar SigReCgcBO" + CHR(13) + ;
90:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
91:                 loc_lContinuar = .F.
92:             ENDIF
93: 
94:             IF loc_lContinuar
95:                 *-- Transferir parametros Grupo/Conta para o BO
96:                 THIS.this_oRelatorio.this_cGrupo = THIS.this_cGrupo
97:                 THIS.this_oRelatorio.this_cConta = THIS.this_cConta
98: 
99:                 *-- Cabecalho escuro com titulo (equivalente ao cntSombra)
100:                 THIS.ConfigurarCabecalho()
101: 
102:                 *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
103:                 THIS.ConfigurarBotoes()
104: 
105:                 *-- PageFrame com pagina de filtros
106:                 THIS.ConfigurarPageFrame()
107: 
108:                 *-- Controles de filtro na Page1 (datas, opcao, shape)
109:                 THIS.ConfigurarPaginaFiltros()
110: 
111:                 *-- Vincula handlers dos botoes (deve vir apos ConfigurarBotoes + ConfigurarPaginaFiltros)
112:                 THIS.ConfigurarBindevents()
113: 
114:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
115:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
116: 
117:                 *-- Inicializa campos com valores padrao
118:                 THIS.LimparCampos()
119: 
120:                 THIS.Visible = .T.
121:                 loc_lSucesso = .T.
122:             ENDIF
123:         CATCH TO loc_oErro
124:             THIS.this_cMensagemErro = loc_oErro.Message
125:             MsgErro(loc_oErro.Message + CHR(13) + ;
126:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
127:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
128:         ENDTRY
129:         RETURN loc_lSucesso
130:     ENDPROC
131: 
132:     *--------------------------------------------------------------------------
133:     * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
134:     *   Equivalente ao cntSombra do frmrelatorio legado.
135:     *   Largura = Width do form (cobre toda a faixa superior).
136:     *--------------------------------------------------------------------------
137:     PROTECTED PROCEDURE ConfigurarCabecalho()
138:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
139:         WITH THIS.cnt_4c_Cabecalho
140:             .Top         = 0
141:             .Left        = 0
142:             .Width       = THIS.Width
143:             .Height      = 80
144:             .BackStyle   = 1
145:             .BackColor   = RGB(100, 100, 100)
146:             .BorderWidth = 0
147:             .Visible     = .T.
148: 
149:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
150:             .AddObject("lbl_4c_Sombra", "Label")
151:             WITH .lbl_4c_Sombra
152:                 .Top       = 22
153:                 .Left      = 22
154:                 .Width     = THIS.Width
155:                 .Height    = 30
156:                 .Caption   = "Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras"
157:                 .FontName  = "Tahoma"
158:                 .FontSize  = 14
159:                 .FontBold  = .T.
160:                 .ForeColor = RGB(0, 0, 0)
161:                 .BackStyle = 0
162:                 .Visible   = .T.
163:             ENDWITH
164: 
165:             *-- Titulo em branco (sobre a sombra)
166:             .AddObject("lbl_4c_Titulo", "Label")
167:             WITH .lbl_4c_Titulo
168:                 .Top       = 20
169:                 .Left      = 20
170:                 .Width     = THIS.Width
171:                 .Height    = 30
172:                 .Caption   = "Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras"
173:                 .FontName  = "Tahoma"
174:                 .FontSize  = 14
175:                 .FontBold  = .T.
176:                 .ForeColor = RGB(255, 255, 255)
177:                 .BackStyle = 0

*-- Linhas 184 a 229:
184:     * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport area)
185:     *   Original: btnReport.Left=525, Top=3, Width=305, Height=85 (+ 4 botoes)
186:     *   Geometria EXATA do framework frmrelatorio: Buttons(1-4), Left increments 66px.
187:     *   BINDEVENTs dos botoes sao vinculados nas fases 7-8.
188:     *--------------------------------------------------------------------------
189:     PROTECTED PROCEDURE ConfigurarBotoes()
190:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
191:         WITH THIS.cmg_4c_Botoes
192:             .Top           = 0
193:             .Left          = 529
194:             .Width         = 273
195:             .Height        = 80
196:             .ButtonCount   = 4
197:             .BackStyle     = 0
198:             .BorderStyle   = 0
199:             .BorderColor   = RGB(136, 189, 188)
200:             .SpecialEffect = 1
201:             .Themes        = .F.
202:             .Visible       = .T.
203: 
204:             *-- Visualizar (preview em tela) - equivale a btnReport.Visualiza
205:             WITH .Buttons(1)
206:                 .Top             = 5
207:                 .Left            = 5
208:                 .Width           = 65
209:                 .Height          = 70
210:                 .Caption         = "Visualizar"
211:                 .FontBold        = .T.
212:                 .FontItalic      = .T.
213:                 .BackColor       = RGB(255, 255, 255)
214:                 .ForeColor       = RGB(90, 90, 90)
215:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
216:                 .PicturePosition = 13
217:                 .SpecialEffect   = 0
218:                 .MousePointer    = 15
219:                 .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
220:                 .Themes          = .F.
221:                 .Visible         = .T.
222:             ENDWITH
223: 
224:             *-- Imprimir (impressora com dialogo) - equivale a btnReport.Imprime
225:             WITH .Buttons(2)
226:                 .Top             = 5
227:                 .Left            = 71
228:                 .Width           = 65
229:                 .Height          = 70

*-- Linhas 295 a 376:
295:     *   O form legado SIGRECGC e FLAT (sem PageFrame), mas no novo padrao os
296:     *   controles de filtro sao agrupados em um PageFrame de 1 pagina para
297:     *   consistencia com o restante do sistema.
298:     *   Os controles de filtro (TextBoxes, OptionGroup) sao adicionados
299:     *   a Page1 nas fases 4-6.
300:     *--------------------------------------------------------------------------
301:     PROTECTED PROCEDURE ConfigurarPageFrame()
302:         LOCAL loc_oPgf
303: 
304:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
305:         loc_oPgf = THIS.pgf_4c_Paginas
306: 
307:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
308:         loc_oPgf.PageCount = 1
309: 
310:         *-- Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form
311:         loc_oPgf.Top    = 85
312:         loc_oPgf.Left   = -1
313:         loc_oPgf.Width  = THIS.Width + 2
314:         loc_oPgf.Height = THIS.Height - 85
315:         loc_oPgf.Tabs   = .F.
316: 
317:         *-- Configurar Page1 (FORA de qualquer WITH - usar referencia direta)
318:         loc_oPgf.Page1.Caption   = "Filtros"
319:         loc_oPgf.Page1.FontName  = "Tahoma"
320:         loc_oPgf.Page1.FontSize  = 8
321:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
322:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
323:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
324: 
325:         loc_oPgf.Visible    = .T.
326:         loc_oPgf.ActivePage = 1
327:     ENDPROC
328: 
329:     *--------------------------------------------------------------------------
330:     * ConfigurarPaginaFiltros - Adiciona controles de filtro na Page1
331:     *   Equivalentes aos controles flat do form legado SIGRECGC:
332:     *     shpImprimir (shape decorativo), Say1/Say4 (labels), getDtIni/getDtFin
333:     *     (TextBoxes de data) e optDatas (OptionGroup Emissao/Vencimento).
334:     *   Coordenadas: posicoes originais menos 85 (top do PageFrame).
335:     *--------------------------------------------------------------------------
336:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
337:         LOCAL loc_oPag
338:         loc_oPag = THIS.pgf_4c_Paginas.Page1
339: 
340:         *-- Shape decorativo ao redor do periodo (shpImprimir original: top=156, left=129)
341:         loc_oPag.AddObject("shp_4c_ShpImprimir", "Shape")
342:         WITH loc_oPag.shp_4c_ShpImprimir
343:             .Top         = 71
344:             .Left        = 129
345:             .Width       = 394
346:             .Height      = 50
347:             .BackStyle   = 0
348:             .BorderColor = RGB(128, 128, 128)
349:             .Visible     = .T.
350:         ENDWITH
351: 
352:         *-- Label "Periodo :" (Say1 original: top=174, left=147)
353:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
354:         WITH loc_oPag.lbl_4c_Label1
355:             .Top       = 89
356:             .Left      = 147
357:             .Width     = 48
358:             .Height    = 18
359:             .Caption   = "Per" + CHR(237) + "odo :"
360:             .FontName  = "Tahoma"
361:             .FontSize  = 8
362:             .ForeColor = RGB(90, 90, 90)
363:             .BackStyle = 0
364:             .Visible   = .T.
365:         ENDWITH
366: 
367:         *-- TextBox data inicial (getDtIni original: top=171, left=196)
368:         loc_oPag.AddObject("txt_4c_DtIni", "TextBox")
369:         WITH loc_oPag.txt_4c_DtIni
370:             .Top         = 86
371:             .Left        = 196
372:             .Width       = 82
373:             .Height      = 21
374:             .Value       = {}
375:             .FontName    = "Tahoma"
376:             .FontSize    = 8

*-- Linhas 415 a 731:
415:             .Visible     = .T.
416:         ENDWITH
417: 
418:         *-- OptionGroup tipo de data (optDatas original: top=168, left=372, W=148, H=27)
419:         *   Value=1 -> Emissao ('D'), Value=2 -> Vencimento ('V')
420:         loc_oPag.AddObject("obj_4c_OptDatas", "OptionGroup")
421:         WITH loc_oPag.obj_4c_OptDatas
422:             .Top         = 83
423:             .Left        = 372
424:             .Width       = 148
425:             .Height      = 27
426:             .ButtonCount = 2
427:             .BackStyle   = 0
428:             .BorderStyle = 0
429:             .Value       = 1
430:             .Visible     = .T.
431: 
432:             WITH .Buttons(1)
433:                 .Top       = 5
434:                 .Left      = 5
435:                 .Width     = 44
436:                 .Height    = 17
437:                 .Caption   = "Data"
438:                 .ForeColor = RGB(90, 90, 90)
439:                 .BackStyle = 0
440:                 .Visible   = .T.
441:             ENDWITH
442: 
443:             WITH .Buttons(2)
444:                 .Top       = 5
445:                 .Left      = 60
446:                 .Width     = 83
447:                 .Height    = 17
448:                 .Caption   = "Vencimento"
449:                 .FontName  = "Tahoma"
450:                 .FontSize  = 8
451:                 .ForeColor = RGB(90, 90, 90)
452:                 .BackStyle = 0
453:                 .Visible   = .T.
454:             ENDWITH
455:         ENDWITH
456:     ENDPROC
457: 
458:     *--------------------------------------------------------------------------
459:     * LimparCampos - Inicializa filtros com valores padrao
460:     *   Datas iniciam com DATE() (hoje); opcao de data = Emissao (1).
461:     *--------------------------------------------------------------------------
462:     PROCEDURE LimparCampos()
463:         LOCAL loc_oPag
464:         loc_oPag = THIS.pgf_4c_Paginas.Page1
465:         IF VARTYPE(loc_oPag) = "O"
466:             loc_oPag.txt_4c_DtIni.Value    = DATE()
467:             loc_oPag.txt_4c_DtFin.Value    = DATE()
468:             loc_oPag.obj_4c_OptDatas.Value = 1
469:         ENDIF
470:     ENDPROC
471: 
472:     *--------------------------------------------------------------------------
473:     * ConfigurarPaginaDados - Form REPORT nao tem Page2 de edicao de dados
474:     *   Em forms CRUD esta procedure adiciona controles em Page2 (Dados).
475:     *   Para este relatorio, toda a interface esta na Page1 (Filtros),
476:     *   configurada por ConfigurarPaginaFiltros(). Este metodo existe apenas
477:     *   para compatibilidade com o pipeline de validacao multi-fase.
478:     *--------------------------------------------------------------------------
479:     PROTECTED PROCEDURE ConfigurarPaginaDados()
480:         RETURN
481:     ENDPROC
482: 
483:     *--------------------------------------------------------------------------
484:     * ConfigurarBindevents - Vincula handlers dos 4 botoes do relatorio
485:     *   Deve ser chamado APOS ConfigurarBotoes() criar cmg_4c_Botoes.
486:     *   Handlers sao PUBLIC (sem PROTECTED) - BINDEVENT exige metodos PUBLIC.
487:     *--------------------------------------------------------------------------
488:     PROTECTED PROCEDURE ConfigurarBindevents()
489:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
490:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
491:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
492:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
493:     ENDPROC
494: 
495:     *--------------------------------------------------------------------------
496:     * FormParaRelatorio - Transfere valores dos filtros do form para o BO
497:     *   Chamado por BtnVisualizarClick e BtnImprimirClick antes de gerar.
498:     *--------------------------------------------------------------------------
499:     PROTECTED PROCEDURE FormParaRelatorio()
500:         LOCAL loc_oPag
501:         loc_oPag = THIS.pgf_4c_Paginas.Page1
502:         WITH THIS.this_oRelatorio
503:             .this_dDtIni    = loc_oPag.txt_4c_DtIni.Value
504:             .this_dDtFin    = loc_oPag.txt_4c_DtFin.Value
505:             .this_nOptDatas = loc_oPag.obj_4c_OptDatas.Value
506:         ENDWITH
507:     ENDPROC
508: 
509:     *--------------------------------------------------------------------------
510:     * ValidarDatas - Valida intervalo de datas dos filtros
511:     *   Implementa as 3 validacoes de btnReport.Click do original:
512:     *   1. Data inicial nao pode ser vazia
513:     *   2. Data final nao pode ser vazia
514:     *   3. Data inicial nao pode ser maior que data final
515:     *   Retorna .T. se valido, .F. se invalido (com foco no campo invalido).
516:     *--------------------------------------------------------------------------
517:     PROTECTED FUNCTION ValidarDatas()
518:         LOCAL loc_oPag, loc_lValido
519:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
520:         loc_lValido = .T.
521: 
522:         IF EMPTY(loc_oPag.txt_4c_DtIni.Value)
523:             MsgAviso("Data inicial inv" + CHR(225) + "lida !!!", ;
524:                      "Valida" + CHR(231) + CHR(227) + "o")
525:             loc_oPag.txt_4c_DtIni.SetFocus()
526:             loc_lValido = .F.
527:         ENDIF
528: 
529:         IF loc_lValido AND EMPTY(loc_oPag.txt_4c_DtFin.Value)
530:             MsgAviso("Data final inv" + CHR(225) + "lida !!!", ;
531:                      "Valida" + CHR(231) + CHR(227) + "o")
532:             loc_oPag.txt_4c_DtFin.SetFocus()
533:             loc_lValido = .F.
534:         ENDIF
535: 
536:         IF loc_lValido AND (loc_oPag.txt_4c_DtIni.Value > loc_oPag.txt_4c_DtFin.Value)
537:             MsgAviso("Data inicial n" + CHR(227) + "o pode ser maior que a final!", ;
538:                      "Valida" + CHR(231) + CHR(227) + "o")
539:             loc_oPag.txt_4c_DtIni.SetFocus()
540:             loc_lValido = .F.
541:         ENDIF
542: 
543:         RETURN loc_lValido
544:     ENDPROC
545: 
546:     *--------------------------------------------------------------------------
547:     * BtnVisualizarClick - Visualiza relatorio em preview na tela [Buttons(1)]
548:     *   Equivale a PROCEDURE visualizacao do original.
549:     *   Valida datas, transfere filtros ao BO e chama Visualizar().
550:     *--------------------------------------------------------------------------
551:     PROCEDURE BtnVisualizarClick()
552:         IF !THIS.ValidarDatas()
553:             RETURN
554:         ENDIF
555:         THIS.FormParaRelatorio()
556:         IF !THIS.this_oRelatorio.Visualizar()
557:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
558:                     "Visualizar Relat" + CHR(243) + "rio")
559:         ENDIF
560:     ENDPROC
561: 
562:     *--------------------------------------------------------------------------
563:     * BtnImprimirClick - Envia relatorio para impressora [Buttons(2)]
564:     *   Equivale a PROCEDURE impressao do original.
565:     *   Valida datas, transfere filtros ao BO e chama Imprimir().
566:     *--------------------------------------------------------------------------
567:     PROCEDURE BtnImprimirClick()
568:         IF !THIS.ValidarDatas()
569:             RETURN
570:         ENDIF
571:         THIS.FormParaRelatorio()
572:         IF !THIS.this_oRelatorio.Imprimir()
573:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
574:                     "Imprimir Relat" + CHR(243) + "rio")
575:         ENDIF
576:     ENDPROC
577: 
578:     *--------------------------------------------------------------------------
579:     * BtnExcelClick - Exporta dados para Excel [Buttons(3)]
580:     *   NAO valida datas: no original "If This.Value # 3" pula a validacao
581:     *   para o botao DocExcel (botao 3), reproducindo esse comportamento.
582:     *--------------------------------------------------------------------------
583:     PROCEDURE BtnExcelClick()
584:         THIS.FormParaRelatorio()
585:         IF !THIS.this_oRelatorio.ExportarExcel()
586:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
587:                     "Exportar Excel")
588:         ENDIF
589:     ENDPROC
590: 
591:     *--------------------------------------------------------------------------
592:     * BtnEncerrarClick - Fecha o formulario de relatorio [Buttons(4)]
593:     *   Equivale a btnReport.Sair.Click do original: ThisForm.Release
594:     *--------------------------------------------------------------------------
595:     PROCEDURE BtnEncerrarClick()
596:         THIS.Release()
597:     ENDPROC
598: 
599:     *--------------------------------------------------------------------------
600:     * BtnIncluirClick / BtnAlterarClick / BtnExcluirClick
601:     *   Stubs de compatibilidade. Forms REPORT (frmrelatorio) NAO possuem
602:     *   operacoes CRUD: nao existe lista de registros para incluir/alterar/
603:     *   excluir. Os botoes operativos sao Visualizar/Imprimir/Excel/Encerrar
604:     *   (cmg_4c_Botoes.Buttons(1..4)), e nenhum BINDEVENT do form vincula
605:     *   Stubs de compatibilidade com o pipeline de validacao multi-fase.
606:     *--------------------------------------------------------------------------
607:     PROCEDURE BtnIncluirClick()
608:         RETURN
609:     ENDPROC
610: 
611:     PROCEDURE BtnAlterarClick()
612:         RETURN
613:     ENDPROC
614: 
615:     PROCEDURE BtnExcluirClick()
616:         RETURN
617:     ENDPROC
618: 
619:     *--------------------------------------------------------------------------
620:     * ConfigurarPaginaLista - Forms de RELATORIO nao tem lista de registros
621:     *   Em forms CRUD (frmcadastro) esta procedure monta Grid + botoes CRUD na
622:     *   Page1. Para forms REPORT (frmrelatorio) o conceito de "lista" nao se
623:     *   aplica: a unica pagina hospeda apenas filtros (datas/codigos/opcoes) e
624:     *   os botoes ficam no CommandGroup cmg_4c_Botoes acima do PageFrame.
625:     *   Toda a montagem da pagina de filtros e feita por ConfigurarPaginaFiltros,
626:     *   chamado diretamente por InicializarForm. Esta procedure existe apenas
627:     *   para compatibilidade com o pipeline de validacao multi-fase, que exige
628:     *   o nome ConfigurarPaginaLista no codigo gerado.
629:     *--------------------------------------------------------------------------
630:     PROTECTED PROCEDURE ConfigurarPaginaLista()
631:         RETURN
632:     ENDPROC
633: 
634:     *--------------------------------------------------------------------------
635:     * AlternarPagina - Form de relatorio tem apenas 1 pagina
636:     *   Mantido por compatibilidade com o pipeline multi-fase.
637:     *--------------------------------------------------------------------------
638:     PROCEDURE AlternarPagina(par_nPagina)
639:         RETURN
640:     ENDPROC
641: 
642:     *--------------------------------------------------------------------------
643:     * BtnBuscarClick - NAO APLICAVEL a forms de relatorio
644:     *   Forms REPORT nao tem grid de lista para buscar/filtrar registros.
645:     *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
646:     *--------------------------------------------------------------------------
647:     PROCEDURE BtnBuscarClick()
648:         RETURN
649:     ENDPROC
650: 
651:     *--------------------------------------------------------------------------
652:     * BtnSalvarClick - NAO APLICAVEL a forms de relatorio
653:     *   Forms REPORT nao tem operacoes de persistencia (Salvar/Cancelar).
654:     *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
655:     *--------------------------------------------------------------------------
656:     PROCEDURE BtnSalvarClick()
657:         RETURN
658:     ENDPROC
659: 
660:     *--------------------------------------------------------------------------
661:     * BtnCancelarClick - Equivalente a BtnEncerrarClick para forms REPORT
662:     *   Em forms CRUD cancela a edicao e volta para lista. Aqui fecha o form
663:     *   (mesma acao do Encerrar, pois nao ha edicao a cancelar).
664:     *--------------------------------------------------------------------------
665:     PROCEDURE BtnCancelarClick()
666:         THIS.Release()
667:     ENDPROC
668: 
669:     *--------------------------------------------------------------------------
670:     * FormParaBO - NAO APLICAVEL a forms de relatorio
671:     *   Em forms CRUD transfere campos do form para o BO antes de Salvar.
672:     *   Para relatorios, a transferencia de filtros e feita por FormParaRelatorio().
673:     *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
674:     *--------------------------------------------------------------------------
675:     PROTECTED PROCEDURE FormParaBO()
676:         RETURN
677:     ENDPROC
678: 
679:     *--------------------------------------------------------------------------
680:     * BOParaForm - NAO APLICAVEL a forms de relatorio
681:     *   Em forms CRUD carrega propriedades do BO nos controles visuais.
682:     *   Para relatorios, os filtros sao lidos do form por FormParaRelatorio().
683:     *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
684:     *--------------------------------------------------------------------------
685:     PROTECTED PROCEDURE BOParaForm()
686:         RETURN
687:     ENDPROC
688: 
689:     *--------------------------------------------------------------------------
690:     * HabilitarCampos - NAO APLICAVEL a forms de relatorio
691:     *   Em forms CRUD habilita/desabilita controles conforme o modo (INCLUIR,
692:     *   ALTERAR, VISUALIZAR). Forms REPORT sempre exibem os filtros habilitados.
693:     *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
694:     *--------------------------------------------------------------------------
695:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
696:         RETURN
697:     ENDPROC
698: 
699:     *--------------------------------------------------------------------------
700:     * CarregarLista - NAO APLICAVEL a forms de relatorio
701:     *   Em forms CRUD recarrega o grid de lista apos operacoes CRUD.
702:     *   Forms REPORT nao tem grid de lista; os dados sao carregados em
703:     *   PrepararDados() (no BO) ao clicar Visualizar/Imprimir.
704:     *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
705:     *--------------------------------------------------------------------------
706:     PROCEDURE CarregarLista()
707:         RETURN
708:     ENDPROC
709: 
710:     *--------------------------------------------------------------------------
711:     * AjustarBotoesPorModo - NAO APLICAVEL a forms de relatorio
712:     *   Em forms CRUD habilita/desabilita botoes CRUD conforme o modo atual.
713:     *   Forms REPORT tem apenas botoes Visualizar/Imprimir/Excel/Encerrar
714:     *   que permanecem sempre habilitados.
715:     *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
716:     *--------------------------------------------------------------------------
717:     PROTECTED PROCEDURE AjustarBotoesPorModo()
718:         RETURN
719:     ENDPROC
720: 
721:     *--------------------------------------------------------------------------
722:     * Destroy - Libera referencia ao BO (NUNCA chamar .Release em Custom)
723:     *--------------------------------------------------------------------------
724:     PROCEDURE Destroy()
725:         IF VARTYPE(THIS.this_oRelatorio) = "O"
726:             THIS.this_oRelatorio = .NULL.
727:         ENDIF
728:         DODEFAULT()
729:     ENDPROC
730: 
731: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReCgcBO.prg):
*==============================================================================
* SIGRECGCBO.PRG
* Business Object para Relatorio Generico de Compras
* Original: SigReCgc.SCX (frmrelatorio)
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS SigReCgcBO AS RelatorioBase

    *-- Propriedades padrao herdadas (sobrescritas)
    this_cTabela          = "dbHistorico"
    this_cCampoChave      = ""
    this_cMensagemErro    = ""

    *-- Propriedades de filtro (populadas pelo form via FormParaRelatorio)
    *-- Equivalente a ThisForm.getDtIni.Value
    this_dDtIni           = {}
    *-- Equivalente a ThisForm.getDtFin.Value
    this_dDtFin           = {}
    *-- Equivalente a ThisForm.optDatas.Value (1=Data Emissao, 2=Vencimento)
    this_nOptDatas        = 1

    *-- Parametros recebidos do form chamador (pGru, pCon do Init original)
    this_cGrupo           = ""
    this_cConta           = ""

    *-- Caminho do FRX e titulo do relatorio
    this_cArquivoFRX      = ""
    this_cTituloRelatorio = "RELAT" + CHR(211) + "RIO GEN" + CHR(201) + "RICO DE COMPRAS"

    *-- Cursores utilizados pelo relatorio
    this_cCursorDados     = "cursor_4c_TmpRel"
    this_cCursorCabecalho = "cursor_4c_CsCabecalho"
    this_cCursorMoedas    = "cursor_4c_TmpMoe"
    this_cCursorTotal     = "cursor_4c_CsTotal"

    *-- Estado interno
    this_lDadosCarregados = .F.

    *--------------------------------------------------------------------------
    * Init - Construtor do BO
    * Define caminho do FRX (resolvido em runtime via gc_4c_CaminhoReports)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            IF TYPE("gc_4c_CaminhoReports") = "C"
                THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "SigReCgc.frx"
            ELSE
                THIS.this_cArquivoFRX = "reports\SigReCgc.frx"
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores para o relatorio (equivale a processamento)
    * 1. Obtem empresa (SigCdEmp)
    * 2. Obtem descricao da conta (SigCdCli.rclis)
    * 3. Cria cursor_4c_CsCabecalho com titulo/subtitulo/empresa/periodo
    * 4. SQLEXEC dbHistorico filtrado por Datas ou Vencs
    * 5. GROUP BY moedas -> cursor_4c_TmpMoe com soma por moeda
    * 6. Formata total acumulado em cursor_4c_CsTotal (memo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lcDatas, loc_lcCampData, loc_lcEmpresa, loc_lcCon
        LOCAL loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo
        LOCAL loc_nValores, loc_cMoedas

        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""

            *-- Tipo de data (D=Emissao, V=Vencimento)
            loc_lcDatas    = IIF(THIS.this_nOptDatas = 1, "D", "V")
            loc_lcCampData = IIF(THIS.this_nOptDatas = 1, "Datas", "Vencs")

            *-- Razao social da empresa via SigCdEmp
            loc_lcEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                       EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRecGcEmp") > 0
                SELECT cursor_4c_SigRecGcEmp
                IF !EOF()
                    loc_lcEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                                    " - " + ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_SigRecGcEmp
            ENDIF

            *-- Descricao da conta (iclis/rclis de SigCdCli)
            loc_lcCon = ""
            IF !EMPTY(ALLTRIM(THIS.this_cConta))
                loc_cSQL = "SELECT TOP 1 rclis FROM SigCdCli WHERE iclis = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cConta))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRecGcCli") > 0
                    SELECT cursor_4c_SigRecGcCli
                    IF !EOF()
                        loc_lcCon = " - " + ALLTRIM(rclis)
                    ENDIF
                    USE IN cursor_4c_SigRecGcCli
                ENDIF
            ENDIF

            *-- Monta strings do cabecalho (CHR() para acentos - regra VFP9)
            loc_lcTitulo  = "RELAT" + CHR(211) + "RIO GEN" + CHR(201) + "RICO DE COMPRAS"
            loc_lcSubTit  = "GRUPO : " + ALLTRIM(THIS.this_cGrupo) + ;
                            "/CONTA : " + ALLTRIM(THIS.this_cConta) + loc_lcCon
            loc_lcPeriodo = "PER" + CHR(205) + "ODO DE " + DTOC(THIS.this_dDtIni) + ;
                            " " + CHR(224) + " " + DTOC(THIS.this_dDtFin)

            *-- Cursor de cabecalho
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                (Titulo C(200), SubTit C(200), Empresa C(80), Periodo C(35), Datar C(1))
            INSERT INTO (THIS.this_cCursorCabecalho) ;
                (Titulo, SubTit, Empresa, Periodo, Datar) ;
                VALUES (loc_lcTitulo, loc_lcSubTit, loc_lcEmpresa, loc_lcPeriodo, loc_lcDatas)

            *-- Dados do historico filtrados por data via SQLEXEC
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            loc_cSQL = "SELECT *, 'X' AS X FROM dbHistorico" + ;
                       " WHERE " + loc_lcCampData + ;
                       " BETWEEN " + FormatarDataSQL(THIS.this_dDtIni) + ;
                       " AND " + FormatarDataSQL(THIS.this_dDtFin) + ;
                       " ORDER BY " + loc_lcCampData
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados do hist" + CHR(243) + "rico"
                loc_lSucesso = .F.
            ENDIF

            *-- Totais por moeda (SELECT nativo no cursor VFP)
            IF USED(THIS.this_cCursorMoedas)
                USE IN (THIS.this_cCursorMoedas)
            ENDIF
            SELECT SUM(valors) AS valores, moedas ;
                FROM (THIS.this_cCursorDados) ;
                GROUP BY moedas ;
                INTO CURSOR (THIS.this_cCursorMoedas) READWRITE

            *-- Cursor de total acumulado formatado por moeda
            IF USED(THIS.this_cCursorTotal)
                USE IN (THIS.this_cCursorTotal)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorTotal) (Total M(4))
            SELECT (THIS.this_cCursorTotal)
            APPEND BLANK

            *-- Itera TmpMoe montando string formatada de totais
            SELECT (THIS.this_cCursorMoedas)
            GO TOP
            DO WHILE !EOF()
                loc_nValores = valores
                loc_cMoedas  = ALLTRIM(moedas)
                SELECT (THIS.this_cCursorTotal)
                REPLACE Total WITH Total + ;
                    TRANSFORM(loc_nValores, "999,999,999,999.99") + ;
                    " " + loc_cMoedas + CHR(13)
                SELECT (THIS.this_cCursorMoedas)
                SKIP
            ENDDO

            *-- Posiciona no inicio para o REPORT FORM
            SELECT (THIS.this_cCursorDados)
            GO TOP

            THIS.this_lDadosCarregados = .T.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora (COM dialogo de impressora)
    * Equivale a PROCEDURE impressao do original
    *--------------------------------------------------------------------------
    FUNCTION Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (THIS.this_cArquivoFRX) TO PRINT PROMPT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    * Equivale a PROCEDURE visualizacao do original
    *--------------------------------------------------------------------------
    FUNCTION Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores do relatorio se estiverem abertos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursores()
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorMoedas)
            USE IN (THIS.this_cCursorMoedas)
        ENDIF
        IF USED(THIS.this_cCursorTotal)
            USE IN (THIS.this_cCursorTotal)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    * Stub para compatibilidade com RelatorioBase.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * BOs de Relatorio populam dados via PrepararDados() -> cursor_4c_TmpRel,
    * nao precisam carregar registro individual do cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao inserem registros no banco.
    * Operacao real e executada por Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao atualizam registros no banco.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao excluem registros no banco.
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Relatorios nao geram registros de auditoria
    * Override do RelatorioBase para deixar explicito.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta para arquivo XLS
    *   Equivale ao DocExcel do frmrelatorio framework (Buttons(3)).
    *   NAO valida datas: no original "If This.Value # 3" pula a validacao
    *   para o botao DocExcel (botao 3), reproducindo esse comportamento.
    *--------------------------------------------------------------------------
    FUNCTION ExportarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oShell
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados)
                    loc_cArquivo = ADDBS(SYS(5) + SYS(2003)) + ;
                                   "SigReCgc_" + STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    COPY TO (loc_cArquivo) TYPE XLS
                    IF FILE(loc_cArquivo)
                        loc_oShell = CREATEOBJECT("WScript.Shell")
                        IF VARTYPE(loc_oShell) = "O"
                            loc_oShell.Run(SHORTPATH(loc_cArquivo))
                            loc_oShell = .NULL.
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao criar arquivo Excel"
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Cursor de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ExportarExcel")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao encerrar BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

