# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [METODO-INEXISTENTE] Metodo 'THIS.Value()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'chkFranquias' (parent: SIGREEVV): Top original=213 vs migrado 'chk_4c_ChkFranquias' Top=128 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkZerados' (parent: SIGREEVV): Top original=213 vs migrado 'chk_4c_ChkZerados' Top=128 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_estoque' (parent: SIGREEVV): Top original=165 vs migrado 'lbl_4c_Lbl_estoque' Top=80 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREEVV.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1478 linhas total):

*-- Linhas 14 a 175:
14: *
15: * FASES 3-7/8 - Estrutura base + corre" + CHR(231) + CHR(245) + "es visuais PILAR 1 + Eventos
16: *   * Propriedades visuais do form (Closable=.F. adicionado - Fase 5)
17: *   * Init() / InicializarForm() / Destroy()
18: *   * ConfigurarCabecalho()  (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)
19: *   * ConfigurarBotoes()     (Visualizar / Imprimir / Excel / Encerrar)
20: *   * ConfigurarPageFrame()  (PageFrame com 1 p" + CHR(225) + "gina - "Filtros")
21: *   * ConfigurarPaginaFiltros() (todos os campos de filtro - Fase 4)
22: *   * ConfigurarPaginaDados()   (corre" + CHR(231) + CHR(245) + "es InputMask/Alignment/MaxLength - Fase 5)
23: *   * VincularEventosBotoes()   (BINDEVENT do CommandGroup - Fase 7)
24: *   * BotoesClick()             (dispatcher central Value=1..4 - Fase 7)
25: *   * ValidarFiltrosForm()      (replica validacoes do Click legado - Fase 7)
26: *   * FormParaRelatorio()       (copia filtros do form para o BO - Fase 7)
27: *   * BotaoVisualizarClick()    (preview em tela - Fase 7)
28: *   * BotaoImprimirClick()      (enviar para impressora - Fase 7)
29: *   * BotaoExcelClick()         (exportar para XLS - Fase 7)
30: *   * BotaoEncerrarClick()      (fechar o formulario - Fase 7)
31: *
32: * FASE 8/8 - Eventos auxiliares e consolidacao final
33: *   * BtnBuscarClick()          (preview do relatorio - Fase 8)
34: *   * BtnEncerrarClick()        (fechar form - Fase 8)
35: *   * BtnSalvarClick()          (imprimir - Fase 8)
36: *   * BtnCancelarClick()        (fechar form - Fase 8)
37: *   * FormParaBO()              (alias de FormParaRelatorio - Fase 8)
38: *   * BOParaForm()              (restaura filtros do BO para o form - Fase 8)
39: *   * HabilitarCampos()         (habilita/desabilita campos de filtro - Fase 8)
40: *   * CarregarLista()           (stub - nao aplicavel para REPORT - Fase 8)
41: *   * AjustarBotoesPorModo()    (stub - nao aplicavel para REPORT - Fase 8)
42: *==============================================================================
43: 
44: DEFINE CLASS FormSIGREEVV AS FormBase
45: 
46:     *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=300)
47:     Height      = 300
48:     Width       = 800
49:     DataSession = 2
50:     ShowWindow  = 1
51:     WindowType  = 1
52:     AutoCenter  = .T.
53:     BorderStyle = 2
54:     ControlBox  = .F.
55:     MaxButton   = .F.
56:     MinButton   = .F.
57:     Closable    = .F.
58:     TitleBar    = 0
59:     Themes      = .F.
60:     ShowTips    = .T.
61: 
62:     *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio (instanciado em InicializarForm)
63:     this_oRelatorio    = .NULL.
64:     this_cMensagemErro = ""
65: 
66:     *--------------------------------------------------------------------------
67:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
68:     *--------------------------------------------------------------------------
69:     PROCEDURE Init()
70:         RETURN DODEFAULT()
71:     ENDPROC
72: 
73:     *--------------------------------------------------------------------------
74:     * InicializarForm - Cria estrutura base do formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
75:     *   1. Define Caption / Picture (fundo)
76:     *   2. Cria SIGREEVVBO
77:     *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es do relat" + CHR(243) + "rio + PageFrame
78:     *--------------------------------------------------------------------------
79:     PROTECTED PROCEDURE InicializarForm()
80:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
81:         loc_lSucesso   = .F.
82:         loc_lContinuar = .T.
83:         TRY
84:             THIS.Caption = "Estoque Por Valor de Venda"
85: 
86:             IF TYPE("gc_4c_CaminhoIcones") = "U"
87:                 gc_4c_CaminhoIcones = ""
88:             ENDIF
89:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90: 
91:             *-- Instanciar BO de relat" + CHR(243) + "rio
92:             THIS.this_oRelatorio = CREATEOBJECT("SIGREEVVBO")
93:             IF VARTYPE(THIS.this_oRelatorio) != "O"
94:                 MsgErro("Erro ao criar SIGREEVVBO" + CHR(13) + ;
95:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
96:                 loc_lContinuar = .F.
97:             ENDIF
98: 
99:             IF loc_lContinuar
100:                 *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente a cntSombra)
101:                 THIS.ConfigurarCabecalho()
102: 
103:                 *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
104:                 THIS.ConfigurarBotoes()
105: 
106:                 *-- PageFrame com p" + CHR(225) + "gina de filtros
107:                 THIS.ConfigurarPageFrame()
108:                 THIS.ConfigurarPaginaFiltros()
109:                 THIS.ConfigurarPaginaDados()
110:                 THIS.LimparCampos()
111: 
112:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
113:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
114: 
115:                 *-- Vincular Click do CommandGroup (equivale ao Click do legado)
116:                 THIS.VincularEventosBotoes()
117: 
118:                 THIS.Visible   = .T.
119:                 loc_lSucesso   = .T.
120:             ENDIF
121:         CATCH TO loc_oErro
122:             THIS.this_cMensagemErro = loc_oErro.Message
123:             MsgErro(loc_oErro.Message + CHR(13) + ;
124:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
125:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
126:         ENDTRY
127:         RETURN loc_lSucesso
128:     ENDPROC
129: 
130:     *--------------------------------------------------------------------------
131:     * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo do relat" + CHR(243) + "rio
132:     *   Equivalente ao cntSombra do frmrelatorio legado.
133:     *   Largura = Width do form (cobre toda a faixa superior).
134:     *--------------------------------------------------------------------------
135:     PROTECTED PROCEDURE ConfigurarCabecalho()
136:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
137:         WITH THIS.cnt_4c_Cabecalho
138:             .Top         = 0
139:             .Left        = 0
140:             .Width       = THIS.Width
141:             .Height      = 80
142:             .BackStyle   = 1
143:             .BackColor   = RGB(100, 100, 100)
144:             .BorderWidth = 0
145:             .Visible     = .T.
146: 
147:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
148:             .AddObject("lbl_4c_Sombra", "Label")
149:             WITH .lbl_4c_Sombra
150:                 .Top       = 22
151:                 .Left      = 22
152:                 .Width     = THIS.Width
153:                 .Height    = 30
154:                 .Caption   = "Estoque Por Valor de Venda"
155:                 .FontName  = "Tahoma"
156:                 .FontSize  = 14
157:                 .FontBold  = .T.
158:                 .ForeColor = RGB(0, 0, 0)
159:                 .BackStyle = 0
160:                 .Visible   = .T.
161:             ENDWITH
162: 
163:             *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
164:             .AddObject("lbl_4c_Titulo", "Label")
165:             WITH .lbl_4c_Titulo
166:                 .Top       = 20
167:                 .Left      = 20
168:                 .Width     = THIS.Width
169:                 .Height    = 30
170:                 .Caption   = "Estoque Por Valor de Venda"
171:                 .FontName  = "Tahoma"
172:                 .FontSize  = 14
173:                 .FontBold  = .T.
174:                 .ForeColor = RGB(255, 255, 255)
175:                 .BackStyle = 0

*-- Linhas 185 a 228:
185:     *   Lefts dos bot" + CHR(245) + "es: 5 / 71 / 137 / 203 (incrementos de 66)
186:     *   Eventos Click vinculados nas fases seguintes (Fase 7).
187:     *--------------------------------------------------------------------------
188:     PROTECTED PROCEDURE ConfigurarBotoes()
189:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
190:         WITH THIS.cmg_4c_Botoes
191:             .Top           = 0
192:             .Left          = 529
193:             .Width         = 273
194:             .Height        = 80
195:             .ButtonCount   = 4
196:             .BackStyle     = 0
197:             .BorderStyle   = 0
198:             .BorderColor   = RGB(136, 189, 188)
199:             .SpecialEffect = 1
200:             .Themes        = .F.
201:             .Visible       = .T.
202: 
203:             *-- Visualizar (preview em tela)
204:             WITH .Buttons(1)
205:                 .Top             = 5
206:                 .Left            = 5
207:                 .Width           = 65
208:                 .Height          = 70
209:                 .Caption         = "Visualizar"
210:                 .FontBold        = .T.
211:                 .FontItalic      = .T.
212:                 .BackColor       = RGB(255, 255, 255)
213:                 .ForeColor       = RGB(90, 90, 90)
214:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
215:                 .PicturePosition = 13
216:                 .SpecialEffect   = 0
217:                 .MousePointer    = 15
218:                 .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
219:                 .Themes          = .F.
220:                 .Visible         = .T.
221:             ENDWITH
222: 
223:             *-- Imprimir (impressora padr" + CHR(227) + "o)
224:             WITH .Buttons(2)
225:                 .Top             = 5
226:                 .Left            = 71
227:                 .Width           = 65
228:                 .Height          = 70

*-- Linhas 296 a 537:
296:     *   com o restante do sistema.
297:     *   Os campos de filtro s" + CHR(227) + "o adicionados a Page1 nas fases seguintes (5-6).
298:     *--------------------------------------------------------------------------
299:     PROTECTED PROCEDURE ConfigurarPageFrame()
300:         LOCAL loc_oPgf
301: 
302:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
303:         loc_oPgf = THIS.pgf_4c_Paginas
304: 
305:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
306:         loc_oPgf.PageCount = 1
307: 
308:         *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form
309:         loc_oPgf.Top    = 85
310:         loc_oPgf.Left   = -1
311:         loc_oPgf.Width  = THIS.Width + 2
312:         loc_oPgf.Height = THIS.Height - 85
313:         loc_oPgf.Tabs   = .F.
314: 
315:         *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
316:         loc_oPgf.Page1.Caption   = "Filtros"
317:         loc_oPgf.Page1.FontName  = "Tahoma"
318:         loc_oPgf.Page1.FontSize  = 8
319:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
320:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
321:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
322: 
323:         loc_oPgf.Visible    = .T.
324:         loc_oPgf.ActivePage = 1
325:     ENDPROC
326: 
327:     *--------------------------------------------------------------------------
328:     * Destroy - Libera refer" + CHR(234) + "ncia ao BO (NUNCA chamar .Release em Custom)
329:     *--------------------------------------------------------------------------
330:     PROCEDURE Destroy()
331:         IF VARTYPE(THIS.this_oRelatorio) = "O"
332:             THIS.this_oRelatorio = .NULL.
333:         ENDIF
334:         DODEFAULT()
335:     ENDPROC
336: 
337:     *--------------------------------------------------------------------------
338:     * ConfigurarPaginaFiltros - Cria todos os controles de filtro em Page1
339:     * Posicoes relativas a Page1 = posicao original no form - PageFrame.Top (85)
340:     * Mapeamento: Say3=lbl_4c_Label3, getTabela=txt_4c_Tabela, etc.
341:     *--------------------------------------------------------------------------
342:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
343:         LOCAL loc_oPag, loc_oErro
344:         TRY
345:             loc_oPag = THIS.pgf_4c_Paginas.Page1
346: 
347:             *-- Rotulo: Tab. Desconto : (Say3 original: top=111 -> 111-85=26)
348:             loc_oPag.AddObject("lbl_4c_Label3", "Label")
349:             WITH loc_oPag.lbl_4c_Label3
350:                 .Top       = 26
351:                 .Left      = 194
352:                 .Width     = 79
353:                 .Height    = 18
354:                 .Caption   = "Tab. Desconto :"
355:                 .FontName  = "Tahoma"
356:                 .FontSize  = 8
357:                 .ForeColor = RGB(90, 90, 90)
358:                 .BackStyle = 0
359:                 .Visible   = .T.
360:             ENDWITH
361: 
362:             *-- Codigo da tabela de desconto (getTabela: top=108 -> 23)
363:             loc_oPag.AddObject("txt_4c_Tabela", "TextBox")
364:             WITH loc_oPag.txt_4c_Tabela
365:                 .Top         = 23
366:                 .Left        = 278
367:                 .Width       = 80
368:                 .Height      = 23
369:                 .Value       = ""
370:                 .FontName    = "Tahoma"
371:                 .FontSize    = 8
372:                 .ForeColor   = RGB(0, 0, 0)
373:                 .ToolTipText = "[F4] Pesquisar tabela de desconto"
374:                 .Visible     = .T.
375:             ENDWITH
376:             BINDEVENT(loc_oPag.txt_4c_Tabela, "KeyPress", THIS, "TeclaTabela")
377:             BINDEVENT(loc_oPag.txt_4c_Tabela, "DblClick", THIS, "TabelaDblClick")
378: 
379:             *-- Descricao da tabela de desconto (getDTabela: top=108 -> 23)
380:             loc_oPag.AddObject("txt_4c_DTabela", "TextBox")
381:             WITH loc_oPag.txt_4c_DTabela
382:                 .Top         = 23
383:                 .Left        = 360
384:                 .Width       = 255
385:                 .Height      = 23
386:                 .Value       = ""
387:                 .FontName    = "Tahoma"
388:                 .FontSize    = 8
389:                 .ForeColor   = RGB(0, 0, 0)
390:                 .ToolTipText = "[F4] Pesquisar por descri" + CHR(231) + CHR(227) + "o"
391:                 .Visible     = .T.
392:             ENDWITH
393:             BINDEVENT(loc_oPag.txt_4c_DTabela, "KeyPress", THIS, "TeclaDTabela")
394:             BINDEVENT(loc_oPag.txt_4c_DTabela, "DblClick", THIS, "DTabelaDblClick")
395: 
396:             *-- Rotulo: Grupo : (Say4 original: top=137 -> 52)
397:             loc_oPag.AddObject("lbl_4c_Label4", "Label")
398:             WITH loc_oPag.lbl_4c_Label4
399:                 .Top       = 52
400:                 .Left      = 235
401:                 .Width     = 38
402:                 .Height    = 18
403:                 .Caption   = "Grupo :"
404:                 .FontName  = "Tahoma"
405:                 .FontSize  = 8
406:                 .ForeColor = RGB(90, 90, 90)
407:                 .BackStyle = 0
408:                 .Visible   = .T.
409:             ENDWITH
410: 
411:             *-- Codigo do grupo contabil (getGrupo: top=133 -> 48)
412:             loc_oPag.AddObject("txt_4c_Grupo", "TextBox")
413:             WITH loc_oPag.txt_4c_Grupo
414:                 .Top         = 48
415:                 .Left        = 278
416:                 .Width       = 80
417:                 .Height      = 25
418:                 .Value       = ""
419:                 .MaxLength   = 10
420:                 .FontName    = "Tahoma"
421:                 .FontSize    = 8
422:                 .ForeColor   = RGB(0, 0, 0)
423:                 .ToolTipText = "[F4] Pesquisar grupo cont" + CHR(225) + "bil"
424:                 .Visible     = .T.
425:             ENDWITH
426:             BINDEVENT(loc_oPag.txt_4c_Grupo, "KeyPress", THIS, "TeclaGrupo")
427:             BINDEVENT(loc_oPag.txt_4c_Grupo, "DblClick", THIS, "GrupoDblClick")
428: 
429:             *-- Descricao do grupo contabil (getDGrupo: top=133 -> 48)
430:             *-- Editavel: usuario digita descricao p/ busca reversa (replica getDGrupo.Valid + fAcessoContab)
431:             loc_oPag.AddObject("txt_4c_DGrupo", "TextBox")
432:             WITH loc_oPag.txt_4c_DGrupo
433:                 .Top         = 48
434:                 .Left        = 360
435:                 .Width       = 150
436:                 .Height      = 25
437:                 .Value       = ""
438:                 .MaxLength   = 20
439:                 .FontName    = "Tahoma"
440:                 .FontSize    = 8
441:                 .ForeColor   = RGB(0, 0, 0)
442:                 .ToolTipText = "[F4] Pesquisar grupo por descri" + CHR(231) + CHR(227) + "o"
443:                 .Visible     = .T.
444:             ENDWITH
445:             BINDEVENT(loc_oPag.txt_4c_DGrupo, "KeyPress", THIS, "TeclaDGrupo")
446:             BINDEVENT(loc_oPag.txt_4c_DGrupo, "DblClick", THIS, "DGrupoDblClick")
447: 
448:             *-- Rotulo: Conta : (lbl_estoque original: top=165 -> 80)
449:             loc_oPag.AddObject("lbl_4c_Lbl_estoque", "Label")
450:             WITH loc_oPag.lbl_4c_Lbl_estoque
451:                 .Top       = 80
452:                 .Left      = 235
453:                 .Width     = 38
454:                 .Height    = 18
455:                 .Caption   = "Conta :"
456:                 .FontName  = "Tahoma"
457:                 .FontSize  = 8
458:                 .ForeColor = RGB(90, 90, 90)
459:                 .BackStyle = 0
460:                 .Visible   = .T.
461:             ENDWITH
462: 
463:             *-- Codigo da conta contabil (getConta: top=160 -> 75)
464:             loc_oPag.AddObject("txt_4c_Conta", "TextBox")
465:             WITH loc_oPag.txt_4c_Conta
466:                 .Top         = 75
467:                 .Left        = 278
468:                 .Width       = 80
469:                 .Height      = 25
470:                 .Value       = ""
471:                 .MaxLength   = 10
472:                 .FontName    = "Tahoma"
473:                 .FontSize    = 8
474:                 .ForeColor   = RGB(0, 0, 0)
475:                 .ToolTipText = "[F4] Pesquisar conta cont" + CHR(225) + "bil"
476:                 .Visible     = .T.
477:             ENDWITH
478:             BINDEVENT(loc_oPag.txt_4c_Conta, "KeyPress", THIS, "TeclaConta")
479:             BINDEVENT(loc_oPag.txt_4c_Conta, "DblClick", THIS, "ContaDblClick")
480: 
481:             *-- Descricao da conta contabil (getDConta: top=160 -> 75) - somente leitura
482:             loc_oPag.AddObject("txt_4c_DConta", "TextBox")
483:             WITH loc_oPag.txt_4c_DConta
484:                 .Top         = 75
485:                 .Left        = 360
486:                 .Width       = 298
487:                 .Height      = 25
488:                 .Value       = ""
489:                 .MaxLength   = 40
490:                 .FontName    = "Tahoma"
491:                 .FontSize    = 8
492:                 .ForeColor   = RGB(0, 0, 0)
493:                 .ReadOnly    = .T.
494:                 .ToolTipText = "[DblClique] Abrir busca de conta"
495:                 .Visible     = .T.
496:             ENDWITH
497:             BINDEVENT(loc_oPag.txt_4c_DConta, "DblClick", THIS, "DContaDblClick")
498: 
499:             *-- Rotulo: Faixa de Valor : (Say1 original: top=190 -> 105)
500:             loc_oPag.AddObject("lbl_4c_Label1", "Label")
501:             WITH loc_oPag.lbl_4c_Label1
502:                 .Top       = 105
503:                 .Left      = 196
504:                 .Width     = 77
505:                 .Height    = 18
506:                 .Caption   = "Faixa de Valor :"
507:                 .FontName  = "Tahoma"
508:                 .FontSize  = 8
509:                 .ForeColor = RGB(90, 90, 90)
510:                 .BackStyle = 0
511:                 .Visible   = .T.
512:             ENDWITH
513: 
514:             *-- Valor inicial da faixa (getValorIni: top=187 -> 102)
515:             loc_oPag.AddObject("txt_4c_ValorIni", "TextBox")
516:             WITH loc_oPag.txt_4c_ValorIni
517:                 .Top       = 102
518:                 .Left      = 278
519:                 .Width     = 80
520:                 .Height    = 23
521:                 .Value     = 0
522:                 .InputMask = "9999999.99"
523:                 .FontName  = "Tahoma"
524:                 .FontSize  = 8
525:                 .ForeColor = RGB(0, 0, 0)
526:                 .Visible   = .T.
527:             ENDWITH
528: 
529:             *-- Separador de faixa (Say2 original: top=190 -> 105, CHR(224)=a-grave="a")
530:             loc_oPag.AddObject("lbl_4c_Label2", "Label")
531:             WITH loc_oPag.lbl_4c_Label2
532:                 .Top       = 105
533:                 .Left      = 364
534:                 .Width     = 8
535:                 .Height    = 18
536:                 .Caption   = CHR(224)
537:                 .FontName  = "Tahoma"

*-- Linhas 622 a 1478:
622:     * AbrirBuscaTabela - Lookup de tabela de desconto em SigOpTdz (por codigo)
623:     * Preenche txt_4c_Tabela, txt_4c_DTabela e this_nPercentual do BO
624:     *--------------------------------------------------------------------------
625:     PROCEDURE AbrirBuscaTabela()
626:         LOCAL loc_oPag, loc_cValor, loc_oForm, loc_lSelecionou
627:         loc_oPag        = THIS.pgf_4c_Paginas.Page1
628:         loc_cValor      = ALLTRIM(loc_oPag.txt_4c_Tabela.Value)
629:         loc_lSelecionou = .F.
630: 
631:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
632:             "SigOpTdz", "cursor_4c_BuscaTab", "Codigos", loc_cValor, ;
633:             "Sele" + CHR(231) + CHR(227) + "o - Tabela de Desconto")
634: 
635:         IF ISNULL(loc_oForm)
636:             RETURN
637:         ENDIF
638: 
639:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
640:             loc_lSelecionou = .T.
641:         ELSE
642:             IF !loc_oForm.this_lAchouRegistro
643:             loc_oForm.mAddColuna("Codigos", "", "Tabela")
644:             loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
645:             loc_oForm.mAddColuna("Descos",  "9999.99", "%")
646:             loc_oForm.Show()
647:             IF loc_oForm.this_lSelecionou
648:                 loc_lSelecionou = .T.
649:             ENDIF
650:             ENDIF
651:         ENDIF
652: 
653:         IF loc_lSelecionou AND USED("cursor_4c_BuscaTab")
654:             SELECT cursor_4c_BuscaTab
655:             IF !EOF()
656:                 loc_oPag.txt_4c_Tabela.Value  = ALLTRIM(cursor_4c_BuscaTab.Codigos)
657:                 loc_oPag.txt_4c_DTabela.Value = ALLTRIM(cursor_4c_BuscaTab.Descrs)
658:                 THIS.this_oRelatorio.this_nPercentual = cursor_4c_BuscaTab.Descos
659:             ENDIF
660:         ENDIF
661: 
662:         IF USED("cursor_4c_BuscaTab")
663:             USE IN cursor_4c_BuscaTab
664:         ENDIF
665:         loc_oForm.Release()
666:     ENDPROC
667: 
668:     *--------------------------------------------------------------------------
669:     * ValidarTabela - Valida codigo digitado em txt_4c_Tabela (ENTER/TAB)
670:     * Se encontrado: preenche descricao e percentual.
671:     * Se nao encontrado: abre lookup.
672:     *--------------------------------------------------------------------------
673:     PROCEDURE ValidarTabela()
674:         LOCAL loc_oPag, loc_cValor, loc_nResult, loc_oErro
675:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
676:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Tabela.Value)
677:         TRY
678:             IF EMPTY(loc_cValor)
679:                 loc_oPag.txt_4c_DTabela.Value = ""
680:                 THIS.this_oRelatorio.this_nPercentual = 0
681:                 RETURN
682:             ENDIF
683:             loc_nResult = SQLEXEC(gnConnHandle, ;
684:                 "SELECT Codigos, Descrs, Descos FROM SigOpTdz WHERE Codigos = " + ;
685:                 EscaparSQL(loc_cValor), ;
686:                 "cursor_4c_ValTab")
687:             IF loc_nResult > 0
688:                 SELECT cursor_4c_ValTab
689:                 IF !EOF()
690:                     loc_oPag.txt_4c_Tabela.Value  = ALLTRIM(cursor_4c_ValTab.Codigos)
691:                     loc_oPag.txt_4c_DTabela.Value = ALLTRIM(cursor_4c_ValTab.Descrs)
692:                     THIS.this_oRelatorio.this_nPercentual = cursor_4c_ValTab.Descos
693:                     USE IN cursor_4c_ValTab
694:                     RETURN
695:                 ENDIF
696:                 USE IN cursor_4c_ValTab
697:             ENDIF
698:             THIS.AbrirBuscaTabela()
699:         CATCH TO loc_oErro
700:             MsgErro(loc_oErro.Message, "ValidarTabela")
701:         ENDTRY
702:     ENDPROC
703: 
704:     *--------------------------------------------------------------------------
705:     * AbrirBuscaDTabela - Lookup de tabela de desconto em SigOpTdz (por descricao)
706:     * Preenche txt_4c_Tabela, txt_4c_DTabela e this_nPercentual do BO
707:     *--------------------------------------------------------------------------
708:     PROCEDURE AbrirBuscaDTabela()
709:         LOCAL loc_oPag, loc_cValor, loc_oForm, loc_lSelecionou
710:         loc_oPag        = THIS.pgf_4c_Paginas.Page1
711:         loc_cValor      = ALLTRIM(loc_oPag.txt_4c_DTabela.Value)
712:         loc_lSelecionou = .F.
713: 
714:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
715:             "SigOpTdz", "cursor_4c_BuscaDTab", "Descrs", loc_cValor, ;
716:             "Sele" + CHR(231) + CHR(227) + "o - Tabela de Desconto (por Descri" + ;
717:             CHR(231) + CHR(227) + "o)")
718: 
719:         IF ISNULL(loc_oForm)
720:             RETURN
721:         ENDIF
722: 
723:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
724:             loc_lSelecionou = .T.
725:         ELSE
726:             IF !loc_oForm.this_lAchouRegistro
727:             loc_oForm.mAddColuna("Codigos", "", "Tabela")
728:             loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
729:             loc_oForm.mAddColuna("Descos",  "9999.99", "%")
730:             loc_oForm.Show()
731:             IF loc_oForm.this_lSelecionou
732:                 loc_lSelecionou = .T.
733:             ENDIF
734:             ENDIF
735:         ENDIF
736: 
737:         IF loc_lSelecionou AND USED("cursor_4c_BuscaDTab")
738:             SELECT cursor_4c_BuscaDTab
739:             IF !EOF()
740:                 loc_oPag.txt_4c_Tabela.Value  = ALLTRIM(cursor_4c_BuscaDTab.Codigos)
741:                 loc_oPag.txt_4c_DTabela.Value = ALLTRIM(cursor_4c_BuscaDTab.Descrs)
742:                 THIS.this_oRelatorio.this_nPercentual = cursor_4c_BuscaDTab.Descos
743:             ENDIF
744:         ENDIF
745: 
746:         IF USED("cursor_4c_BuscaDTab")
747:             USE IN cursor_4c_BuscaDTab
748:         ENDIF
749:         loc_oForm.Release()
750:     ENDPROC
751: 
752:     *--------------------------------------------------------------------------
753:     * TeclaTabela - Handler KeyPress de txt_4c_Tabela
754:     * F4/F5: abre lookup direto. ENTER/TAB: valida codigo digitado.
755:     *--------------------------------------------------------------------------
756:     PROCEDURE TeclaTabela(par_nKeyCode, par_nShiftAltCtrl)
757:         IF INLIST(par_nKeyCode, 115, 116)
758:             THIS.AbrirBuscaTabela()
759:         ELSE
760:             IF INLIST(par_nKeyCode, 13, 9)
761:             THIS.ValidarTabela()
762:             ENDIF
763:         ENDIF
764:     ENDPROC
765: 
766:     *--------------------------------------------------------------------------
767:     * TeclaDTabela - Handler KeyPress de txt_4c_DTabela
768:     * F4/F5/ENTER/TAB: abre lookup por descricao.
769:     *--------------------------------------------------------------------------
770:     PROCEDURE TeclaDTabela(par_nKeyCode, par_nShiftAltCtrl)
771:         IF INLIST(par_nKeyCode, 115, 116, 13, 9)
772:             THIS.AbrirBuscaDTabela()
773:         ENDIF
774:     ENDPROC
775: 
776:     *--------------------------------------------------------------------------
777:     * AbrirBuscaGrupo - Lookup de grupo em SigCdGcr
778:     * Preenche txt_4c_Grupo e txt_4c_DGrupo
779:     *--------------------------------------------------------------------------
780:     PROCEDURE AbrirBuscaGrupo()
781:         LOCAL loc_oPag, loc_cValor, loc_oForm, loc_lSelecionou
782:         loc_oPag        = THIS.pgf_4c_Paginas.Page1
783:         loc_cValor      = ALLTRIM(loc_oPag.txt_4c_Grupo.Value)
784:         loc_lSelecionou = .F.
785: 
786:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
787:             "SigCdGcr", "cursor_4c_BuscaGrupo", "codigos", loc_cValor, ;
788:             "Sele" + CHR(231) + CHR(227) + "o - Grupo")
789: 
790:         IF ISNULL(loc_oForm)
791:             RETURN
792:         ENDIF
793: 
794:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
795:             loc_lSelecionou = .T.
796:         ELSE
797:             IF !loc_oForm.this_lAchouRegistro
798:             loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
799:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
800:             loc_oForm.Show()
801:             IF loc_oForm.this_lSelecionou
802:                 loc_lSelecionou = .T.
803:             ENDIF
804:             ENDIF
805:         ENDIF
806: 
807:         IF loc_lSelecionou AND USED("cursor_4c_BuscaGrupo")
808:             SELECT cursor_4c_BuscaGrupo
809:             IF !EOF()
810:                 loc_oPag.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
811:                 loc_oPag.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
812:             ENDIF
813:         ENDIF
814: 
815:         IF USED("cursor_4c_BuscaGrupo")
816:             USE IN cursor_4c_BuscaGrupo
817:         ENDIF
818:         loc_oForm.Release()
819:     ENDPROC
820: 
821:     *--------------------------------------------------------------------------
822:     * ValidarGrupo - Valida codigo digitado em txt_4c_Grupo (ENTER/TAB)
823:     * Se encontrado: preenche descricao. Se nao encontrado: abre lookup.
824:     *--------------------------------------------------------------------------
825:     PROCEDURE ValidarGrupo()
826:         LOCAL loc_oPag, loc_cValor, loc_nResult, loc_oErro
827:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
828:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Grupo.Value)
829:         TRY
830:             IF EMPTY(loc_cValor)
831:                 loc_oPag.txt_4c_DGrupo.Value = ""
832:                 RETURN
833:             ENDIF
834:             loc_nResult = SQLEXEC(gnConnHandle, ;
835:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
836:                 EscaparSQL(loc_cValor), ;
837:                 "cursor_4c_ValGrupo")
838:             IF loc_nResult > 0
839:                 SELECT cursor_4c_ValGrupo
840:                 IF !EOF()
841:                     loc_oPag.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_ValGrupo.codigos)
842:                     loc_oPag.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ValGrupo.descrs)
843:                     USE IN cursor_4c_ValGrupo
844:                     RETURN
845:                 ENDIF
846:                 USE IN cursor_4c_ValGrupo
847:             ENDIF
848:             THIS.AbrirBuscaGrupo()
849:         CATCH TO loc_oErro
850:             MsgErro(loc_oErro.Message, "ValidarGrupo")
851:         ENDTRY
852:     ENDPROC
853: 
854:     *--------------------------------------------------------------------------
855:     * TeclaGrupo - Handler KeyPress de txt_4c_Grupo
856:     * F4/F5: abre lookup direto. ENTER/TAB: valida codigo digitado.
857:     *--------------------------------------------------------------------------
858:     PROCEDURE TeclaGrupo(par_nKeyCode, par_nShiftAltCtrl)
859:         IF INLIST(par_nKeyCode, 115, 116)
860:             THIS.AbrirBuscaGrupo()
861:         ELSE
862:             IF INLIST(par_nKeyCode, 13, 9)
863:             THIS.ValidarGrupo()
864:             ENDIF
865:         ENDIF
866:     ENDPROC
867: 
868:     *--------------------------------------------------------------------------
869:     * AbrirBuscaConta - Lookup de conta contabil em SigReCtb
870:     * Preenche txt_4c_Conta e txt_4c_DConta
871:     *--------------------------------------------------------------------------
872:     PROCEDURE AbrirBuscaConta()
873:         LOCAL loc_oPag, loc_cValor, loc_oForm, loc_lSelecionou
874:         loc_oPag        = THIS.pgf_4c_Paginas.Page1
875:         loc_cValor      = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
876:         loc_lSelecionou = .F.
877: 
878:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
879:             "SigReCtb", "cursor_4c_BuscaConta", "contas", loc_cValor, ;
880:             "Sele" + CHR(231) + CHR(227) + "o - Conta")
881: 
882:         IF ISNULL(loc_oForm)
883:             RETURN
884:         ENDIF
885: 
886:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
887:             loc_lSelecionou = .T.
888:         ELSE
889:             IF !loc_oForm.this_lAchouRegistro
890:             loc_oForm.mAddColuna("contas", "", "C" + CHR(243) + "digo")
891:             loc_oForm.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
892:             loc_oForm.Show()
893:             IF loc_oForm.this_lSelecionou
894:                 loc_lSelecionou = .T.
895:             ENDIF
896:             ENDIF
897:         ENDIF
898: 
899:         IF loc_lSelecionou AND USED("cursor_4c_BuscaConta")
900:             SELECT cursor_4c_BuscaConta
901:             IF !EOF()
902:                 loc_oPag.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.contas)
903:                 loc_oPag.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.descs)
904:             ENDIF
905:         ENDIF
906: 
907:         IF USED("cursor_4c_BuscaConta")
908:             USE IN cursor_4c_BuscaConta
909:         ENDIF
910:         loc_oForm.Release()
911:     ENDPROC
912: 
913:     *--------------------------------------------------------------------------
914:     * ValidarConta - Valida codigo digitado em txt_4c_Conta (ENTER/TAB)
915:     * Se encontrado: preenche descricao. Se nao encontrado: abre lookup.
916:     *--------------------------------------------------------------------------
917:     PROCEDURE ValidarConta()
918:         LOCAL loc_oPag, loc_cValor, loc_nResult, loc_oErro
919:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
920:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
921:         TRY
922:             IF EMPTY(loc_cValor)
923:                 loc_oPag.txt_4c_DConta.Value = ""
924:                 RETURN
925:             ENDIF
926:             loc_nResult = SQLEXEC(gnConnHandle, ;
927:                 "SELECT contas, descs FROM SigReCtb WHERE contas = " + ;
928:                 EscaparSQL(loc_cValor), ;
929:                 "cursor_4c_ValConta")
930:             IF loc_nResult > 0
931:                 SELECT cursor_4c_ValConta
932:                 IF !EOF()
933:                     loc_oPag.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ValConta.contas)
934:                     loc_oPag.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValConta.descs)
935:                     USE IN cursor_4c_ValConta
936:                     RETURN
937:                 ENDIF
938:                 USE IN cursor_4c_ValConta
939:             ENDIF
940:             THIS.AbrirBuscaConta()
941:         CATCH TO loc_oErro
942:             MsgErro(loc_oErro.Message, "ValidarConta")
943:         ENDTRY
944:     ENDPROC
945: 
946:     *--------------------------------------------------------------------------
947:     * TeclaConta - Handler KeyPress de txt_4c_Conta
948:     * F4/F5: abre lookup direto. ENTER/TAB: valida codigo digitado.
949:     *--------------------------------------------------------------------------
950:     PROCEDURE TeclaConta(par_nKeyCode, par_nShiftAltCtrl)
951:         IF INLIST(par_nKeyCode, 115, 116)
952:             THIS.AbrirBuscaConta()
953:         ELSE
954:             IF INLIST(par_nKeyCode, 13, 9)
955:             THIS.ValidarConta()
956:             ENDIF
957:         ENDIF
958:     ENDPROC
959: 
960:     *--------------------------------------------------------------------------
961:     * LimparCampos - Reseta todos os campos de filtro para valores padrao
962:     *--------------------------------------------------------------------------
963:     PROCEDURE LimparCampos()
964:         LOCAL loc_oPag, loc_oErro
965:         TRY
966:             loc_oPag = THIS.pgf_4c_Paginas.Page1
967:             loc_oPag.txt_4c_Tabela.Value          = ""
968:             loc_oPag.txt_4c_DTabela.Value          = ""
969:             loc_oPag.txt_4c_Grupo.Value            = ""
970:             loc_oPag.txt_4c_DGrupo.Value           = ""
971:             loc_oPag.txt_4c_Conta.Value            = ""
972:             loc_oPag.txt_4c_DConta.Value           = ""
973:             loc_oPag.txt_4c_ValorIni.Value         = 0
974:             loc_oPag.txt_4c_ValorFin.Value         = 0
975:             loc_oPag.chk_4c_ChkFranquias.Value     = 0
976:             loc_oPag.chk_4c_ChkZerados.Value       = 0
977:             THIS.this_oRelatorio.this_nPercentual  = 0
978:         CATCH TO loc_oErro
979:             MsgErro(loc_oErro.Message, "LimparCampos")
980:         ENDTRY
981:     ENDPROC
982: 
983:     *--------------------------------------------------------------------------
984:     * FormParaRelatorio - Copia valores dos filtros para o BO antes de imprimir
985:     *--------------------------------------------------------------------------
986:     PROTECTED PROCEDURE FormParaRelatorio()
987:         LOCAL loc_oPag
988:         loc_oPag = THIS.pgf_4c_Paginas.Page1
989:         WITH THIS.this_oRelatorio
990:             .this_cCodTab    = ALLTRIM(loc_oPag.txt_4c_Tabela.Value)
991:             .this_cDsTab     = ALLTRIM(loc_oPag.txt_4c_DTabela.Value)
992:             .this_cGrupo     = ALLTRIM(loc_oPag.txt_4c_Grupo.Value)
993:             .this_cDGrupo    = ALLTRIM(loc_oPag.txt_4c_DGrupo.Value)
994:             .this_cConta     = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
995:             .this_cDConta    = ALLTRIM(loc_oPag.txt_4c_DConta.Value)
996:             .this_nValorIni  = loc_oPag.txt_4c_ValorIni.Value
997:             .this_nValorFin  = loc_oPag.txt_4c_ValorFin.Value
998:             .this_lFranquias = (loc_oPag.chk_4c_ChkFranquias.Value = 1)
999:             .this_lZerados   = (loc_oPag.chk_4c_ChkZerados.Value = 1)
1000:         ENDWITH
1001:     ENDPROC
1002: 
1003:     *--------------------------------------------------------------------------
1004:     * VincularEventosBotoes - Faz BINDEVENT do Click do CommandGroup
1005:     * O legado SIGREEVV.SCX tinha um unico Click no grupo que tratava todos os
1006:     * 4 bot" + CHR(245) + "es testando This.Value (1=Visualizar, 2=Imprimir, 3=Excel, 4=Sair).
1007:     * Aqui usamos o mesmo padr" + CHR(227) + "o: um " + CHR(250) + "nico handler BotoesClick
1008:     * que consulta cmg_4c_Botoes.Value e despacha para o m" + CHR(233) + "todo correto.
1009:     *--------------------------------------------------------------------------
1010:     PROTECTED PROCEDURE VincularEventosBotoes()
1011:         BINDEVENT(THIS.cmg_4c_Botoes, "Click", THIS, "BotoesClick")
1012:     ENDPROC
1013: 
1014:     *--------------------------------------------------------------------------
1015:     * BotoesClick - Dispatcher central do CommandGroup cmg_4c_Botoes
1016:     * Replica a l" + CHR(243) + "gica do Click do legado (PROCEDURE Click do bot" + CHR(227) + "o no SCX):
1017:     *   1. Se for Sair (Value=4) -> fecha o form
1018:     *   2. Caso contr" + CHR(225) + "rio -> valida filtros, copia para BO e despacha
1019:     *      - Value=1 -> Visualizar (preview)
1020:     *      - Value=2 -> Imprimir (impressora padr" + CHR(227) + "o)
1021:     *      - Value=3 -> Excel (exportar dados)
1022:     *--------------------------------------------------------------------------
1023:     PROCEDURE BotoesClick()
1024:         LOCAL loc_nBotao
1025:         loc_nBotao = THIS.cmg_4c_Botoes.Value
1026: 
1027:         *-- Bot" + CHR(227) + "o 4 = Encerrar/Sair (sem valida" + CHR(231) + CHR(227) + "o de filtros)
1028:         IF loc_nBotao = 4
1029:             THIS.BotaoEncerrarClick()
1030:             RETURN
1031:         ENDIF
1032: 
1033:         *-- Para os demais: valida filtros antes de gerar relat" + CHR(243) + "rio
1034:         IF !THIS.ValidarFiltrosForm()
1035:             RETURN
1036:         ENDIF
1037: 
1038:         *-- Copiar filtros do form para o BO
1039:         THIS.FormParaRelatorio()
1040: 
1041:         DO CASE
1042:             CASE loc_nBotao = 1
1043:                 THIS.BotaoVisualizarClick()
1044:             CASE loc_nBotao = 2
1045:                 THIS.BotaoImprimirClick()
1046:             CASE loc_nBotao = 3
1047:                 THIS.BotaoExcelClick()
1048:         ENDCASE
1049:     ENDPROC
1050: 
1051:     *--------------------------------------------------------------------------
1052:     * ValidarFiltrosForm - Aplica as mesmas valida" + CHR(231) + CHR(245) + "es do Click legado,
1053:     * exibindo a mensagem e devolvendo o foco para o campo problem" + CHR(225) + "tico.
1054:     * Retorna .T. se filtros est" + CHR(227) + "o v" + CHR(225) + "lidos, .F. caso contr" + CHR(225) + "rio.
1055:     *--------------------------------------------------------------------------
1056:     PROTECTED PROCEDURE ValidarFiltrosForm()
1057:         LOCAL loc_oPag, loc_lValido
1058:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1059:         loc_lValido = .T.
1060: 
1061:         IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Tabela.Value))
1062:             MsgAviso("Tabela de Desconto Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
1063:             loc_oPag.txt_4c_Tabela.SetFocus()
1064:             loc_lValido = .F.
1065:         ENDIF
1066: 
1067:         IF loc_lValido AND loc_oPag.txt_4c_ValorIni.Value < 0
1068:             MsgAviso("Faixa Inicial de Valor Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
1069:             loc_oPag.txt_4c_ValorIni.SetFocus()
1070:             loc_lValido = .F.
1071:         ENDIF
1072: 
1073:         IF loc_lValido AND loc_oPag.txt_4c_ValorIni.Value > loc_oPag.txt_4c_ValorFin.Value
1074:             MsgAviso("Faixa Inicial de Valor Maior do Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o")
1075:             loc_oPag.txt_4c_ValorIni.SetFocus()
1076:             loc_lValido = .F.
1077:         ENDIF
1078: 
1079:         RETURN loc_lValido
1080:     ENDPROC
1081: 
1082:     *--------------------------------------------------------------------------
1083:     * BotaoVisualizarClick - Gera o relat" + CHR(243) + "rio em preview na tela
1084:     *--------------------------------------------------------------------------
1085:     PROCEDURE BotaoVisualizarClick()
1086:         LOCAL loc_oErro
1087:         TRY
1088:             IF !THIS.this_oRelatorio.Visualizar()
1089:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
1090:                     "Erro ao visualizar relat" + CHR(243) + "rio")
1091:             ENDIF
1092:         CATCH TO loc_oErro
1093:             MsgErro(loc_oErro.Message, "BotaoVisualizarClick")
1094:         ENDTRY
1095:     ENDPROC
1096: 
1097:     *--------------------------------------------------------------------------
1098:     * BotaoImprimirClick - Envia o relat" + CHR(243) + "rio para a impressora
1099:     *--------------------------------------------------------------------------
1100:     PROCEDURE BotaoImprimirClick()
1101:         LOCAL loc_oErro
1102:         TRY
1103:             IF !THIS.this_oRelatorio.Imprimir()
1104:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
1105:                     "Erro ao imprimir relat" + CHR(243) + "rio")
1106:             ENDIF
1107:         CATCH TO loc_oErro
1108:             MsgErro(loc_oErro.Message, "BotaoImprimirClick")
1109:         ENDTRY
1110:     ENDPROC
1111: 
1112:     *--------------------------------------------------------------------------
1113:     * BotaoExcelClick - Exporta os dados do relat" + CHR(243) + "rio para uma planilha XLS
1114:     * 1. Chama PrepararDados() do BO para popular o cursor crImprimir
1115:     * 2. Solicita destino via GETFILE
1116:     * 3. Faz COPY TO ... TYPE XL5 do cursor
1117:     *--------------------------------------------------------------------------
1118:     PROCEDURE BotaoExcelClick()
1119:         LOCAL loc_cArquivo, loc_cAlias, loc_oErro
1120:         TRY
1121:             IF !THIS.this_oRelatorio.PrepararDados()
1122:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
1123:                     "Erro ao preparar dados para exporta" + CHR(231) + CHR(227) + "o")
1124:                 RETURN
1125:             ENDIF
1126: 
1127:             loc_cAlias = THIS.this_oRelatorio.this_cCursorDados
1128:             IF !USED(loc_cAlias)
1129:                 MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para exporta" + ;
1130:                     CHR(231) + CHR(227) + "o.", "Excel")
1131:                 RETURN
1132:             ENDIF
1133: 
1134:             loc_cArquivo = PUTFILE("Salvar como:", "EstoqueValorVenda.xls", "xls")
1135:             IF EMPTY(loc_cArquivo)
1136:                 RETURN
1137:             ENDIF
1138: 
1139:             SELECT (loc_cAlias)
1140:             COPY TO (loc_cArquivo) TYPE XL5
1141:             MsgInfo("Arquivo exportado com sucesso para:" + CHR(13) + loc_cArquivo, "Excel")
1142:         CATCH TO loc_oErro
1143:             MsgErro(loc_oErro.Message, "BotaoExcelClick")
1144:         ENDTRY
1145:     ENDPROC
1146: 
1147:     *--------------------------------------------------------------------------
1148:     * BotaoEncerrarClick - Fecha o formul" + CHR(225) + "rio (equivale ao bot" + CHR(227) + "o Sair do legado)
1149:     * O cmg_4c_Botoes.Buttons(4) j" + CHR(225) + " tem .Cancel=.T., ent" + CHR(227) + "o ESC tamb" + CHR(233) + "m dispara aqui.
1150:     *--------------------------------------------------------------------------
1151:     PROCEDURE BotaoEncerrarClick()
1152:         THIS.Release()
1153:     ENDPROC
1154: 
1155:     *--------------------------------------------------------------------------
1156:     * TabelaDblClick - DblClick em txt_4c_Tabela abre lookup de tabela de desconto
1157:     *--------------------------------------------------------------------------
1158:     PROCEDURE TabelaDblClick()
1159:         THIS.AbrirBuscaTabela()
1160:     ENDPROC
1161: 
1162:     *--------------------------------------------------------------------------
1163:     * DTabelaDblClick - DblClick em txt_4c_DTabela abre lookup por descricao
1164:     *--------------------------------------------------------------------------
1165:     PROCEDURE DTabelaDblClick()
1166:         THIS.AbrirBuscaDTabela()
1167:     ENDPROC
1168: 
1169:     *--------------------------------------------------------------------------
1170:     * GrupoDblClick - DblClick em txt_4c_Grupo abre lookup de grupo contabil
1171:     *--------------------------------------------------------------------------
1172:     PROCEDURE GrupoDblClick()
1173:         THIS.AbrirBuscaGrupo()
1174:     ENDPROC
1175: 
1176:     *--------------------------------------------------------------------------
1177:     * AbrirBuscaDGrupo - Lookup reverso em SigCdGcr por descricao
1178:     * Replica getDGrupo.Valid + fAcessoContab('D'): usuario digita descricao,
1179:     * sistema busca o codigo correspondente e preenche txt_4c_Grupo.
1180:     *--------------------------------------------------------------------------
1181:     PROCEDURE AbrirBuscaDGrupo()
1182:         LOCAL loc_oPag, loc_cValor, loc_oForm, loc_lSelecionou, loc_oErro
1183:         loc_oPag        = THIS.pgf_4c_Paginas.Page1
1184:         loc_cValor      = ALLTRIM(loc_oPag.txt_4c_DGrupo.Value)
1185:         loc_lSelecionou = .F.
1186: 
1187:         TRY
1188:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1189:                 "SigCdGcr", "cursor_4c_BuscaDGrupo", "descrs", loc_cValor, ;
1190:                 "Sele" + CHR(231) + CHR(227) + "o - Grupo (por Descri" + CHR(231) + CHR(227) + "o)")
1191: 
1192:             IF ISNULL(loc_oForm)
1193:                 RETURN
1194:             ENDIF
1195: 
1196:             IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1197:                 loc_lSelecionou = .T.
1198:             ELSE
1199:                 IF !loc_oForm.this_lAchouRegistro
1200:                 loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1201:                 loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1202:                 loc_oForm.Show()
1203:                 IF loc_oForm.this_lSelecionou
1204:                     loc_lSelecionou = .T.
1205:                 ENDIF
1206:                 ENDIF
1207:             ENDIF
1208: 
1209:             IF loc_lSelecionou AND USED("cursor_4c_BuscaDGrupo")
1210:                 SELECT cursor_4c_BuscaDGrupo
1211:                 IF !EOF()
1212:                     loc_oPag.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaDGrupo.codigos)
1213:                     loc_oPag.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaDGrupo.descrs)
1214:                 ENDIF
1215:             ENDIF
1216: 
1217:             IF USED("cursor_4c_BuscaDGrupo")
1218:                 USE IN cursor_4c_BuscaDGrupo
1219:             ENDIF
1220:             loc_oForm.Release()
1221:         CATCH TO loc_oErro
1222:             MsgErro(loc_oErro.Message, "AbrirBuscaDGrupo")
1223:         ENDTRY
1224:     ENDPROC
1225: 
1226:     *--------------------------------------------------------------------------
1227:     * TeclaDGrupo - Handler KeyPress de txt_4c_DGrupo
1228:     * F4/F5/ENTER/TAB: abre lookup reverso por descricao (replica fAcessoContab 'D').
1229:     * Se campo vazio ao confirmar: limpa codigo do grupo.
1230:     *--------------------------------------------------------------------------
1231:     PROCEDURE TeclaDGrupo(par_nKeyCode, par_nShiftAltCtrl)
1232:         LOCAL loc_oPag
1233:         IF INLIST(par_nKeyCode, 115, 116, 13, 9)
1234:             loc_oPag = THIS.pgf_4c_Paginas.Page1
1235:             IF EMPTY(ALLTRIM(loc_oPag.txt_4c_DGrupo.Value))
1236:                 loc_oPag.txt_4c_Grupo.Value = ""
1237:             ELSE
1238:                 THIS.AbrirBuscaDGrupo()
1239:             ENDIF
1240:         ENDIF
1241:     ENDPROC
1242: 
1243:     *--------------------------------------------------------------------------
1244:     * DGrupoDblClick - DblClick em txt_4c_DGrupo abre lookup reverso de grupo
1245:     *--------------------------------------------------------------------------
1246:     PROCEDURE DGrupoDblClick()
1247:         THIS.AbrirBuscaDGrupo()
1248:     ENDPROC
1249: 
1250:     *--------------------------------------------------------------------------
1251:     * ContaDblClick - DblClick em txt_4c_Conta abre lookup de conta contabil
1252:     *--------------------------------------------------------------------------
1253:     PROCEDURE ContaDblClick()
1254:         THIS.AbrirBuscaConta()
1255:     ENDPROC
1256: 
1257:     *--------------------------------------------------------------------------
1258:     * DContaDblClick - DblClick em txt_4c_DConta (campo descricao read-only)
1259:     * Abre o mesmo lookup de conta, permitindo busca a partir do campo descricao.
1260:     * Replica o comportamento de getDConta.When: abertura facilitada para o usuario.
1261:     *--------------------------------------------------------------------------
1262:     PROCEDURE DContaDblClick()
1263:         THIS.AbrirBuscaConta()
1264:     ENDPROC
1265: 
1266:     *==========================================================================
1267:     * EVENTOS PRINCIPAIS - FASE 7
1268:     *
1269:     * Forms REPORT nao tem CRUD; o pipeline padroniza nomes (BtnXxxClick)
1270:     * para todos os tipos de form. Aqui mapeamos os 4 handlers padrao para
1271:     * as 4 acoes reais de um relatorio (Visualizar/Imprimir/Excel/Encerrar).
1272:     *==========================================================================
1273: 
1274:     *--------------------------------------------------------------------------
1275:     * BtnVisualizarClick - Acao "Visualizar" do form REPORT
1276:     * Valida filtros, copia para o BO e gera preview em tela.
1277:     *--------------------------------------------------------------------------
1278:     PROCEDURE BtnVisualizarClick()
1279:         IF !THIS.ValidarFiltrosForm()
1280:             RETURN
1281:         ENDIF
1282:         THIS.FormParaRelatorio()
1283:         THIS.BotaoVisualizarClick()
1284:     ENDPROC
1285: 
1286:     *--------------------------------------------------------------------------
1287:     * BtnIncluirClick - Em REPORT nao ha Incluir CRUD; alias para Imprimir.
1288:     * Gera o relatorio e envia para a impressora padrao.
1289:     *--------------------------------------------------------------------------
1290:     PROCEDURE BtnIncluirClick()
1291:         IF !THIS.ValidarFiltrosForm()
1292:             RETURN
1293:         ENDIF
1294:         THIS.FormParaRelatorio()
1295:         THIS.BotaoImprimirClick()
1296:     ENDPROC
1297: 
1298:     *--------------------------------------------------------------------------
1299:     * BtnAlterarClick - Em REPORT nao ha Alterar CRUD; alias para Exportar Excel.
1300:     *--------------------------------------------------------------------------
1301:     PROCEDURE BtnAlterarClick()
1302:         IF !THIS.ValidarFiltrosForm()
1303:             RETURN
1304:         ENDIF
1305:         THIS.FormParaRelatorio()
1306:         THIS.BotaoExcelClick()
1307:     ENDPROC
1308: 
1309:     *--------------------------------------------------------------------------
1310:     * BtnExcluirClick - Em REPORT nao ha Excluir CRUD; alias para Encerrar.
1311:     *--------------------------------------------------------------------------
1312:     PROCEDURE BtnExcluirClick()
1313:         THIS.BotaoEncerrarClick()
1314:     ENDPROC
1315: 
1316:     *--------------------------------------------------------------------------
1317:     * ConfigurarPaginaDados - FASE 5/8: corre" + CHR(231) + CHR(245) + "es de fidelidade PILAR 1
1318:     * Para form REPORT (layout FLAT sem Page2): aplica propriedades do original
1319:     * que n" + CHR(227) + "o foram capturadas em ConfigurarPaginaFiltros():
1320:     *   - InputMask dos campos numericos ("99,999,999" conforme original)
1321:     *   - Alignment=3 (direita) nos campos numericos
1322:     *   - MaxLength em campos de descricao de grupo e conta
1323:     *   - getConta.FontSize=9 (original usa fonte 9, diferente dos demais=8)
1324:     *   - lblMensagem: FontBold, FontSize=12, Alignment=2, ForeColor azul marinho
1325:     *--------------------------------------------------------------------------
1326:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1327:         LOCAL loc_oPag, loc_oErro
1328:         TRY
1329:             loc_oPag = THIS.pgf_4c_Paginas.Page1
1330: 
1331:             *-- Campos numericos: InputMask e alinhamento a direita (original: "99,999,999", Alignment=3)
1332:             WITH loc_oPag.txt_4c_ValorIni
1333:                 .InputMask = "99,999,999"
1334:                 .Alignment = 3
1335:             ENDWITH
1336: 
1337:             WITH loc_oPag.txt_4c_ValorFin
1338:                 .InputMask = "99,999,999"
1339:                 .Alignment = 3
1340:             ENDWITH
1341: 
1342:             *-- MaxLength para campos de descri" + CHR(231) + CHR(227) + "o (original: getDGrupo=20, getDConta=40)
1343:             loc_oPag.txt_4c_DGrupo.MaxLength = 20
1344:             loc_oPag.txt_4c_DConta.MaxLength = 40
1345: 
1346:             *-- getConta usa FontSize=9 no original (diferente dos demais campos que usam 8)
1347:             loc_oPag.txt_4c_Conta.FontSize = 9
1348: 
1349:             *-- lblMensagem: propriedades originais (FontBold=.T., FontSize=12, Alignment=2 centralizado, ForeColor azul)
1350:             WITH loc_oPag.cnt_4c_Mensagem.lbl_4c_LblMensagem
1351:                 .FontBold  = .T.
1352:                 .FontSize  = 12
1353:                 .Alignment = 2
1354:                 .ForeColor = RGB(0, 0, 128)
1355:             ENDWITH
1356: 
1357:         CATCH TO loc_oErro
1358:             MsgErro(loc_oErro.Message + CHR(13) + ;
1359:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1360:                 "ConfigurarPaginaDados")
1361:         ENDTRY
1362:     ENDPROC
1363: 
1364:     *==========================================================================
1365:     * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
1366:     *==========================================================================
1367: 
1368:     *--------------------------------------------------------------------------
1369:     * BtnBuscarClick - Para form REPORT: preview do relatorio na tela
1370:     * Equivalente a Visualizar - acao principal de consulta de dados
1371:     *--------------------------------------------------------------------------
1372:     PROCEDURE BtnBuscarClick()
1373:         IF !THIS.ValidarFiltrosForm()
1374:             RETURN
1375:         ENDIF
1376:         THIS.FormParaRelatorio()
1377:         THIS.BotaoVisualizarClick()
1378:     ENDPROC
1379: 
1380:     *--------------------------------------------------------------------------
1381:     * BtnEncerrarClick - Fecha o formulario de relatorio
1382:     *--------------------------------------------------------------------------
1383:     PROCEDURE BtnEncerrarClick()
1384:         THIS.BotaoEncerrarClick()
1385:     ENDPROC
1386: 
1387:     *--------------------------------------------------------------------------
1388:     * BtnSalvarClick - Para form REPORT: imprime o relatorio
1389:     * Equivalente a Imprimir - acao de producao do documento impresso
1390:     *--------------------------------------------------------------------------
1391:     PROCEDURE BtnSalvarClick()
1392:         IF !THIS.ValidarFiltrosForm()
1393:             RETURN
1394:         ENDIF
1395:         THIS.FormParaRelatorio()
1396:         THIS.BotaoImprimirClick()
1397:     ENDPROC
1398: 
1399:     *--------------------------------------------------------------------------
1400:     * BtnCancelarClick - Fecha o formulario sem gerar relatorio
1401:     *--------------------------------------------------------------------------
1402:     PROCEDURE BtnCancelarClick()
1403:         THIS.BotaoEncerrarClick()
1404:     ENDPROC
1405: 
1406:     *--------------------------------------------------------------------------
1407:     * FormParaBO - Alias de FormParaRelatorio para compatibilidade com FormBase
1408:     * Transfere valores dos filtros do form para o BO de relatorio
1409:     *--------------------------------------------------------------------------
1410:     PROCEDURE FormParaBO()
1411:         THIS.FormParaRelatorio()
1412:     ENDPROC
1413: 
1414:     *--------------------------------------------------------------------------
1415:     * BOParaForm - Restaura filtros do BO para os controles do form
1416:     * Util para reexibir parametros carregados via CarregarDoCursor()
1417:     *--------------------------------------------------------------------------
1418:     PROCEDURE BOParaForm()
1419:         LOCAL loc_oPag, loc_oErro
1420:         TRY
1421:             loc_oPag = THIS.pgf_4c_Paginas.Page1
1422:             loc_oPag.txt_4c_Tabela.Value        = ALLTRIM(THIS.this_oRelatorio.this_cCodTab)
1423:             loc_oPag.txt_4c_DTabela.Value        = ALLTRIM(THIS.this_oRelatorio.this_cDsTab)
1424:             loc_oPag.txt_4c_Grupo.Value          = ALLTRIM(THIS.this_oRelatorio.this_cGrupo)
1425:             loc_oPag.txt_4c_DGrupo.Value         = ALLTRIM(THIS.this_oRelatorio.this_cDGrupo)
1426:             loc_oPag.txt_4c_Conta.Value          = ALLTRIM(THIS.this_oRelatorio.this_cConta)
1427:             loc_oPag.txt_4c_DConta.Value         = ALLTRIM(THIS.this_oRelatorio.this_cDConta)
1428:             loc_oPag.txt_4c_ValorIni.Value       = THIS.this_oRelatorio.this_nValorIni
1429:             loc_oPag.txt_4c_ValorFin.Value       = THIS.this_oRelatorio.this_nValorFin
1430:             loc_oPag.chk_4c_ChkFranquias.Value   = IIF(THIS.this_oRelatorio.this_lFranquias = .T., 1, 0)
1431:             loc_oPag.chk_4c_ChkZerados.Value     = IIF(THIS.this_oRelatorio.this_lZerados   = .T., 1, 0)
1432:         CATCH TO loc_oErro
1433:             MsgErro(loc_oErro.Message, "BOParaForm")
1434:         ENDTRY
1435:     ENDPROC
1436: 
1437:     *--------------------------------------------------------------------------
1438:     * HabilitarCampos - Habilita ou desabilita todos os campos de filtro
1439:     * par_lHabilitar: .T. para habilitar, .F. para desabilitar durante geracao
1440:     *--------------------------------------------------------------------------
1441:     PROCEDURE HabilitarCampos(par_lHabilitar)
1442:         LOCAL loc_oPag, loc_oErro
1443:         TRY
1444:             loc_oPag = THIS.pgf_4c_Paginas.Page1
1445:             loc_oPag.txt_4c_Tabela.Enabled       = par_lHabilitar
1446:             loc_oPag.txt_4c_DTabela.Enabled       = par_lHabilitar
1447:             loc_oPag.txt_4c_Grupo.Enabled         = par_lHabilitar
1448:             loc_oPag.txt_4c_DGrupo.Enabled        = par_lHabilitar
1449:             loc_oPag.txt_4c_Conta.Enabled         = par_lHabilitar
1450:             loc_oPag.txt_4c_ValorIni.Enabled      = par_lHabilitar
1451:             loc_oPag.txt_4c_ValorFin.Enabled      = par_lHabilitar
1452:             loc_oPag.chk_4c_ChkFranquias.Enabled  = par_lHabilitar
1453:             loc_oPag.chk_4c_ChkZerados.Enabled    = par_lHabilitar
1454:             THIS.cmg_4c_Botoes.Enabled            = par_lHabilitar
1455:         CATCH TO loc_oErro
1456:             MsgErro(loc_oErro.Message, "HabilitarCampos")
1457:         ENDTRY
1458:     ENDPROC
1459: 
1460:     *--------------------------------------------------------------------------
1461:     * CarregarLista - Nao aplicavel para form REPORT (sem grid de lista CRUD)
1462:     * Retorna .T. para compatibilidade com o contrato de FormBase
1463:     *--------------------------------------------------------------------------
1464:     PROCEDURE CarregarLista()
1465:         RETURN .T.
1466:     ENDPROC
1467: 
1468:     *--------------------------------------------------------------------------
1469:     * AjustarBotoesPorModo - Nao aplicavel para form REPORT
1470:     * Botoes do relatorio nao mudam de estado por modo CRUD
1471:     *--------------------------------------------------------------------------
1472:     PROCEDURE AjustarBotoesPorModo()
1473:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1474:             THIS.cmg_4c_Botoes.Enabled = .T.
1475:         ENDIF
1476:     ENDPROC
1477: 
1478: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGREEVVBO.prg):
*==============================================================================
* SIGREEVVBO.PRG
* Business Object para Relatorio - Estoque Por Valor de Venda (SIGREEVV)
* Herda de RelatorioBase
*
* Tabelas principais: SigMvEst, SigCdPro, SigCdMoe, SigCdEmp
* Relatorio FRX: SigReEvv.frx
*
* Filtros:
*   - Tabela de desconto (codigo + descricao + percentual - SigOpTdz)
*   - Grupo contabil    (codigo + descricao)
*   - Conta contabil    (codigo + descricao)
*   - Faixa de valor    (valor inicial / valor final)
*   - Incluir Franquias (checkbox)
*   - Incluir Zerados   (checkbox)
*==============================================================================

DEFINE CLASS SIGREEVVBO AS RelatorioBase

    *-- Filtro: tabela de desconto (SigOpTdz)
    this_cCodTab     = ""    && Codigo da tabela de desconto (getTabela no legado)
    this_cDsTab      = ""    && Descricao da tabela de desconto (getDTabela no legado)
    this_nPercentual = 0     && Percentual de desconto (Descos de SigOpTdz)

    *-- Filtro: grupo contabil
    this_cGrupo      = ""    && Codigo do grupo contabil (getGrupo no legado)
    this_cDGrupo     = ""    && Descricao do grupo contabil (getDGrupo no legado)

    *-- Filtro: conta contabil
    this_cConta      = ""    && Codigo da conta contabil (getConta no legado)
    this_cDConta     = ""    && Descricao da conta contabil (getDConta no legado)

    *-- Filtro: faixa de valor de venda
    this_nValorIni   = 0     && Valor inicial da faixa (getValorIni no legado)
    this_nValorFin   = 0     && Valor final da faixa (getValorFin no legado)

    *-- Filtro: opcoes de inclusao
    this_lFranquias  = .F.   && Incluir empresas franquias (chkFranquias no legado)
    this_lZerados    = .F.   && Incluir itens com quantidade zerada (chkZerados no legado)

    *-- Cursor de saida populado por PrepararDados() - usado pelo REPORT FORM SigReEvv
    this_cCursorDados = "crImprimir"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de estoque por valor de venda
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvEst"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCotacao - Busca cotacao da moeda em SigCdCot (equivale a fBuscarCotacao)
    * par_cMoeda: codigo da moeda (3 chars)
    * Retorna: valor da cotacao (0 se nao encontrada)
    *--------------------------------------------------------------------------
    PROCEDURE ObterCotacao(par_cMoeda)
        LOCAL loc_nValor, loc_nResult
        loc_nValor = 0
        IF !EMPTY(par_cMoeda)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                " ORDER BY datas DESC, horas DESC", ;
                "cursor_4c_CotacaoTemp")
            IF loc_nResult > 0
                SELECT cursor_4c_CotacaoTemp
                IF !EOF()
                    loc_nValor = cursor_4c_CotacaoTemp.valos
                ENDIF
                USE IN cursor_4c_CotacaoTemp
            ENDIF
        ENDIF
        RETURN loc_nValor
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio Estoque Por Valor de Venda
    * Replica logica do PROCEDURE processamento do SIGREEVV.SCX legado
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lOk, loc_oErro
        LOCAL loc_cTab, loc_cGru, loc_cCon, loc_cDtb
        LOCAL loc_nVlI, loc_nVlF, loc_nPct
        LOCAL loc_llFra, loc_llZer
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cSubTitulo, loc_cFaixa, loc_cEmpresa
        LOCAL loc_cEmpCod
        LOCAL loc_nTot, loc_nOrd

        loc_lSucesso = .F.
        loc_lOk      = .T.

        TRY
            *-- Extrair filtros das propriedades do BO
            loc_cTab  = PADR(ALLTRIM(THIS.this_cCodTab), 10)
            loc_cGru  = PADR(ALLTRIM(THIS.this_cGrupo),  10)
            loc_cCon  = PADR(ALLTRIM(THIS.this_cConta),  10)
            loc_cDtb  = PADR(ALLTRIM(THIS.this_cDsTab),  30)
            loc_nVlI  = THIS.this_nValorIni
            loc_nVlF  = THIS.this_nValorFin
            loc_nPct  = 1 - (THIS.this_nPercentual / 100)
            loc_llFra = THIS.this_lFranquias
            loc_llZer = THIS.this_lZerados

            *-- Subtitulo e faixa de valor para cabecalho do relatorio
            loc_cSubTitulo = "Tabela : " + ALLTRIM(loc_cTab) + " - " + ALLTRIM(loc_cDtb) + ;
                IIF(EMPTY(ALLTRIM(loc_cGru)), "", " - Grupo : " + ALLTRIM(loc_cGru)) + ;
                IIF(EMPTY(ALLTRIM(loc_cCon)), "", " - Conta : " + ALLTRIM(loc_cCon))
            loc_cFaixa = ALLTRIM(STR(loc_nVlI, 10)) + " / " + ALLTRIM(STR(loc_nVlF, 10))

            *-- Obter codigo da empresa atual
            loc_cEmpCod = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_cEmpresa = loc_cEmpCod

            *-- Criar cursor de cabecalho do relatorio
            IF USED("crCabecalho")
                USE IN crCabecalho
            ENDIF
            CREATE CURSOR crCabecalho (Empresa c(80), Titulo c(80), SubTitulo c(80), ;
                Faixa c(80), MedFaixa n(10,2), MedGeral n(10,2))
            INSERT INTO crCabecalho (Empresa, Titulo, SubTitulo, Faixa) ;
                VALUES (loc_cEmpresa, "Estoque Por Valor de Venda", loc_cSubTitulo, loc_cFaixa)

            *-- PASSO 1: Cotacoes de todas as moedas (Valor=cotacao propria, ValCustos=cotacao equivalente)
            IF USED("crSigCdMoe")
                USE IN crSigCdMoe
            ENDIF
            loc_cSQL = "SELECT cmoes, moeqs, qtdeqs, " + ;
                "CAST(0 AS NUMERIC(15,6)) AS Valor, " + ;
                "CAST(0 AS NUMERIC(15,6)) AS ValCustos " + ;
                "FROM SigCdMoe ORDER BY cmoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdMoe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao consultar moedas (SigCdMoe)"
                loc_lOk = .F.
            ENDIF

            IF loc_lOk
                SELECT crSigCdMoe
                SCAN
                    IF !EMPTY(ALLTRIM(crSigCdMoe.moeqs))
                        REPLACE ValCustos WITH THIS.ObterCotacao(ALLTRIM(crSigCdMoe.moeqs)) * ;
                            crSigCdMoe.qtdeqs IN crSigCdMoe
                    ELSE
                        REPLACE ValCustos WITH THIS.ObterCotacao(ALLTRIM(crSigCdMoe.cmoes)) IN crSigCdMoe
                    ENDIF
                    REPLACE Valor WITH THIS.ObterCotacao(ALLTRIM(crSigCdMoe.cmoes)) IN crSigCdMoe
                ENDSCAN
            ENDIF

            *-- PASSO 2: Estoque agrupado por empresa e produto (com filtros de grupo/conta)
            IF loc_lOk
                IF USED("crSigMvEst")
                    USE IN crSigMvEst
                ENDIF
                loc_cSQL = "SELECT emps, cpros, SUM(sqtds) AS SQtds " + ;
                    "FROM SigMvEst " + ;
                    "WHERE 0 = 0" + ;
                    IIF(EMPTY(ALLTRIM(loc_cGru)), "", " AND grupos = " + EscaparSQL(ALLTRIM(loc_cGru))) + ;
                    IIF(EMPTY(ALLTRIM(loc_cCon)), "", " AND estos = " + EscaparSQL(ALLTRIM(loc_cCon))) + ;
                    " GROUP BY emps, cpros"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvEst")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar estoques (SigMvEst)"
                    loc_lOk = .F.
                ENDIF
            ENDIF

            IF loc_lOk
                SELECT crSigMvEst
                INDEX ON cpros TAG cpros
            ENDIF

            *-- PASSO 3: Empresas a excluir (inativas, sem funcionarios, franquias se aplicavel)
            IF loc_lOk
                IF USED("crSigCdEmpExcl")
                    USE IN crSigCdEmpExcl
                ENDIF
                loc_cSQL = "SELECT cemps FROM SigCdEmp " + ;
                    "WHERE nemps < 1" + ;
                    IIF(loc_llFra, "", " OR nums = '1' ") + ;
                    "ORDER BY cemps"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmpExcl")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar empresas (SigCdEmp)"
                    loc_lOk = .F.
                ENDIF
            ENDIF

            IF loc_lOk
                SET DELETED ON
                SELECT crSigCdEmpExcl
                SCAN
                    DELETE FROM crSigMvEst WHERE emps = crSigCdEmpExcl.cemps
                ENDSCAN
                USE IN crSigCdEmpExcl
            ENDIF

            *-- PASSO 4: Dados dos produtos (preco venda, moeda, custo, moeda custo)
            IF loc_lOk
                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF
                loc_cSQL = "SELECT cpros, pvens, moevs, custofs, moecusfs " + ;
                    "FROM SigCdPro ORDER BY cpros"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPro")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar produtos (SigCdPro)"
                    loc_lOk = .F.
                ENDIF
            ENDIF

            *-- PASSO 5: Calcular valor de venda (estoque x preco x cotacao x percentual desconto)
            IF loc_lOk
                IF USED("crVenda")
                    USE IN crVenda
                ENDIF
                SELECT a.emps, a.cpros, ;
                    a.SQtds * b.pvens * c.Valor * loc_nPct AS PVens, ;
                    b.moevs, a.SQtds, a.SQtds * b.custofs AS CustoFs, b.moecusfs ;
                    FROM crSigMvEst a, crSigCdPro b, crSigCdMoe c ;
                    WHERE a.cpros = b.cpros AND b.moevs = c.cmoes ;
                    INTO CURSOR crVenda READWRITE
                IF USED("crSigMvEst")
                    USE IN crSigMvEst
                ENDIF
            ENDIF

            *-- PASSO 6: Converter custo para moeda base usando ValCustos da moeda
            IF loc_lOk
                IF USED("crProcessar")
                    USE IN crProcessar
                ENDIF
                SELECT a.emps, a.cpros, a.PVens, a.moevs, a.SQtds, ;
                    a.CustoFs * b.ValCustos AS CustoFs, a.moecusfs ;
                    FROM crVenda a, crSigCdMoe b ;
                    WHERE a.moecusfs = b.cmoes ;
                    ORDER BY a.emps, a.cpros ;
                    INTO CURSOR crProcessar READWRITE
                IF USED("crVenda")
                    USE IN crVenda
                ENDIF
                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF
                IF USED("crSigCdMoe")
                    USE IN crSigCdMoe
                ENDIF
            ENDIF

            *-- PASSO 7: Totalizar por empresa - todas as quantidades e valores
            IF loc_lOk
                IF USED("crTotPorEmp")
                    USE IN crTotPorEmp
                ENDIF
                SELECT emps, SUM(SQtds) AS Qtds, SUM(PVens) AS Total, SUM(CustoFs) AS TotalCusto ;
                    FROM crProcessar ;
                    GROUP BY emps ;
                    INTO CURSOR crTotPorEmp READWRITE
            ENDIF

            *-- PASSO 8: Totalizar por empresa - apenas itens dentro da faixa de valor informada
            IF loc_lOk
                IF USED("crTotPorFxa")
                    USE IN crTotPorFxa
                ENDIF
                SELECT emps, SUM(SQtds) AS Qtds, SUM(PVens) AS Total, SUM(CustoFs) AS TotalCusto ;
                    FROM crProcessar ;
                    WHERE (PVens / SQtds) BETWEEN loc_nVlI AND loc_nVlF ;
                    GROUP BY emps ;
                    INTO CURSOR crTotPorFxa READWRITE
                IF USED("crProcessar")
                    USE IN crProcessar
                ENDIF
            ENDIF

            *-- PASSO 9: Montar cursor final crImprimir com LEFT JOIN faixa e geral por empresa
            IF loc_lOk
                IF USED("crImprimir")
                    USE IN crImprimir
                ENDIF
                SELECT a.emps, ;
                    VAL(STR(NVL(b.Qtds, 0), 15, 2)) AS QtdsFaixa, ;
                    VAL(STR(NVL(b.Total, 0), 15, 2)) AS TotalFaixa, ;
                    VAL(STR(a.Qtds, 15, 2)) AS QtdsGeral, ;
                    VAL(STR(a.Total, 15, 2)) AS TotalGeral, ;
                    0.00 AS PctFaixa, 0.00 AS PctGeral, ;
                    VAL(STR(a.TotalCusto, 15, 2)) AS TotCusGeral, ;
                    VAL(STR(NVL(b.TotalCusto, 0), 15, 2)) AS TotCusFaixa, ;
                    0 AS Ordem ;
                    FROM crTotPorEmp a LEFT JOIN crTotPorFxa b ON a.emps = b.emps ;
                    ORDER BY a.emps ;
                    INTO CURSOR crImprimir READWRITE
                IF USED("crTotPorEmp")
                    USE IN crTotPorEmp
                ENDIF
                IF USED("crTotPorFxa")
                    USE IN crTotPorFxa
                ENDIF
            ENDIF

            *-- PASSO 10: Calcular percentuais e marcar como excluidos os zerados (se !llZer)
            IF loc_lOk
                SELECT crImprimir
                SUM TotalFaixa TO loc_nTot
                loc_nOrd = 0
                GO TOP
                SCAN
                    IF crImprimir.TotalFaixa <> 0
                        REPLACE PctFaixa WITH (crImprimir.TotalFaixa / loc_nTot) * 100, ;
                            PctGeral WITH (crImprimir.TotalFaixa / crImprimir.TotalGeral) * 100 ;
                            IN crImprimir
                    ENDIF
                    IF !loc_llZer AND EMPTY(crImprimir.QtdsFaixa)
                        DELETE IN crImprimir
                    ELSE
                        loc_nOrd = loc_nOrd + 1
                        REPLACE Ordem WITH loc_nOrd IN crImprimir
                    ENDIF
                ENDSCAN
            ENDIF

            *-- PASSO 11: Calcular medias e atualizar cabecalho do relatorio
            IF loc_lOk
                IF USED("crMedias")
                    USE IN crMedias
                ENDIF
                SELECT AVG(PctFaixa) AS MedFaixa, AVG(PctGeral) AS MedGeral ;
                    FROM crImprimir ;
                    INTO CURSOR crMedias
                GO TOP IN crMedias
                REPLACE MedFaixa WITH NVL(crMedias.MedFaixa, 0), ;
                    MedGeral WITH NVL(crMedias.MedGeral, 0) IN crCabecalho
                USE IN crMedias
            ENDIF

            IF loc_lOk
                SELECT crImprimir
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Relat" + CHR(243) + "rio Estoque Por Valor de Venda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "SigReEvv") TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe o relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "SigReEvv") PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria de tabela
    * Retorna identificador composto dos filtros usado para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TAB=" + ALLTRIM(THIS.this_cCodTab) + ;
                     ";GRU=" + ALLTRIM(THIS.this_cGrupo) + ;
                     ";CON=" + ALLTRIM(THIS.this_cConta) + ;
                     ";VLI=" + ALLTRIM(STR(THIS.this_nValorIni, 15, 2)) + ;
                     ";VLF=" + ALLTRIM(STR(THIS.this_nValorFin, 15, 2)) + ;
                     ";PCT=" + ALLTRIM(STR(THIS.this_nPercentual, 6, 2)) + ;
                     ";FRA=" + IIF(THIS.this_lFranquias, "S", "N") + ;
                     ";ZER=" + IIF(THIS.this_lZerados, "S", "N")
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Permite restaurar parametros previamente salvos para reexecucao
    * par_cAliasCursor: cursor com colunas no formato preset
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + "o dispon" + ;
                                          CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.cCodTab") = "C"
                        THIS.this_cCodTab = ALLTRIM(m.cCodTab)
                    ENDIF
                    IF TYPE("m.cDsTab") = "C"
                        THIS.this_cDsTab = ALLTRIM(m.cDsTab)
                    ENDIF
                    IF TYPE("m.nPercentual") = "N"
                        THIS.this_nPercentual = m.nPercentual
                    ENDIF
                    IF TYPE("m.cGrupo") = "C"
                        THIS.this_cGrupo = ALLTRIM(m.cGrupo)
                    ENDIF
                    IF TYPE("m.cDGrupo") = "C"
                        THIS.this_cDGrupo = ALLTRIM(m.cDGrupo)
                    ENDIF
                    IF TYPE("m.cConta") = "C"
                        THIS.this_cConta = ALLTRIM(m.cConta)
                    ENDIF
                    IF TYPE("m.cDConta") = "C"
                        THIS.this_cDConta = ALLTRIM(m.cDConta)
                    ENDIF
                    IF TYPE("m.nValorIni") = "N"
                        THIS.this_nValorIni = m.nValorIni
                    ENDIF
                    IF TYPE("m.nValorFin") = "N"
                        THIS.this_nValorFin = m.nValorFin
                    ENDIF
                    IF TYPE("m.lFranquias") = "L"
                        THIS.this_lFranquias = m.lFranquias
                    ENDIF
                    IF TYPE("m.lZerados") = "L"
                        THIS.this_lZerados = m.lZerados
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Aplica as mesmas validacoes do Click do legado
    * (Tabela obrigatoria, Valor Inicial >= 0, Valor Inicial <= Valor Final)
    * Retorna .T. se filtros estao validos, .F. caso contrario (mensagem em this_cMensagemErro)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(ALLTRIM(THIS.this_cCodTab))
            THIS.this_cMensagemErro = "Tabela de Desconto Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nValorIni < 0
            THIS.this_cMensagemErro = "Faixa Inicial de Valor Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nValorIni > THIS.this_nValorFin
            THIS.this_cMensagemErro = "Faixa Inicial de Valor Maior do Que a Final!!!"
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Valida filtros obrigatorios, delega para Imprimir() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarFiltros()
                loc_lSucesso = THIS.Imprimir()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("IMPRESSAO")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Valida filtros obrigatorios, delega para Visualizar() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarFiltros()
                loc_lSucesso = THIS.Visualizar()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("VISUALIZACAO")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO, EXCEL)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReEvv") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de todos os cursores criados pelo relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(11), loc_nI
        loc_aCursores(1)  = "crCabecalho"
        loc_aCursores(2)  = "crSigCdMoe"
        loc_aCursores(3)  = "crSigMvEst"
        loc_aCursores(4)  = "crSigCdEmpExcl"
        loc_aCursores(5)  = "crSigCdPro"
        loc_aCursores(6)  = "crVenda"
        loc_aCursores(7)  = "crProcessar"
        loc_aCursores(8)  = "crTotPorEmp"
        loc_aCursores(9)  = "crTotPorFxa"
        loc_aCursores(10) = "crImprimir"
        loc_aCursores(11) = "crMedias"
        FOR loc_nI = 1 TO 11
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

ENDDEFINE

