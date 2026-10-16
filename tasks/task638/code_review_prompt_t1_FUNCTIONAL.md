# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.KeyPress()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1487 linhas total):

*-- Linhas 17 a 67:
17: * FASE 6 (campos restantes e lookups):
18: *  - LOOKUP: nenhum. O dump original (SigPrMlu_form_codigo_fonte.txt) nao tem
19: *    fwBuscaExt/fwBuscaSel/fwBuscaInt, mAddColuna, sigacess() nem Acesso*() -
20: *    o unico CreateObject do form eh o fSqlConector (gerenciador de dados, ja
21: *    coberto pelo BO). Inventar lookup aqui violaria o PILAR 1 e a regra
22: *    "NUNCA inventar tabelas de lookup que nao existem no original".
23: *  - CAMPOS: o unico campo DIGITAVEL do legado eh cntNova.getNova ("Nome da
24: *    Unificacao") -> cnt_4c_Nova.txt_4c_Nova, criado em
25: *    ConfigurarContainerNova() com Format = "K" e MaxLength = 20 transcritos
26: *    do SCX (regra #49). Os 5 Text1 das Column2..Column6 sao celulas da grade
27: *    e sao somente-leitura no legado (PROCEDURE When / Return(.f.)),
28: *    reproduzidas como Column.ReadOnly = .T. em ConfigurarGridDados().
29: *  - REGRA DO CAMPO: o getNova nao tem Valid/When/LostFocus - a regra que o
30: *    governa mora DENTRO do cmdProcessar.Click do legado (tres guards:
31: *    nenhuma mala marcada, uma so mala marcada, nome em branco). Ela eh de
32: *    QUEM ela governa, nao de quem a chama: entregue nesta fase como o funil
33: *    unico PUBLIC ValidarProcessamento(), que BtnProcessarClick apenas chama.
34: *
35: * FASE 7 (eventos principais dos botoes):
36: *  - NAO EXISTEM BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
37: *    BtnExcluirClick porque o legado NAO TEM CRUD - e inventa-los violaria o
38: *    PILAR 1. Prova, medida no dump e no layout.json da task:
39: *      . "Class: form" PURO - nao herda de frmcadastro (de onde viria a barra
40: *        Incluir/Alterar/Visualizar/Excluir/Procurar), nem de frmrelatorio.
41: *      . nenhum objeto chamado cmdIncluir/cmdAlterar/cmdVisualizar/cmdExcluir,
42: *        nenhum Grupo_Op e nenhuma referencia a pcEscolha no dump inteiro.
43: *      . a superficie de botao do SCX sao 3 CommandGroup e nada mais:
44: *        cmdProcessar (ButtonCount 1, "btnProcessar"), Commandgroup2
45: *        (ButtonCount 1, "btnsair") e cmdBtnGrade (ButtonCount 2, "btnMarcar"
46: *        + "btnDesmarcar") = 4 botoes, TODOS com handler nesta classe
47: *        (BtnProcessarClick, BtnEncerrarClick, CmdSelTudoClick, CmdApagaTudoClick).
48: *    Esta tela nao cadastra mala direta nenhuma: ela SELECIONA malas existentes
49: *    (checkbox da Column1) e as UNIFICA numa nova. Quem inclui/altera/exclui
50: *    mala direta eh o cadastro de Mala Direta, outro form.
51: *  - O que esta fase entregou de verdade nos eventos dos botoes:
52: *      . MarcarTodasAs() - funil unico dos DOIS botoes do cmdBtnGrade, que no
53: *        legado compartilham UM Click so (o indice do botao eh o proprio valor
54: *        gravado), com UPDATE-SQL no lugar de REPLACE ALL para nao jogar o
55: *        ponteiro do cursor em EOF e fazer a grade saltar para o fim.
56: *      . BtnProcessarClick() - reabilitacao INCONDICIONAL do botao Processar
57: *        depois do ENDTRY, equivalente aos quatro "This.Enabled = .t." que o
58: *        legado repete em cada caminho de saida do cmdProcessar.Click.
59: *      . ValidarProcessamento() - TRY/CATCH que REPROVA quando a validacao nao
60: *        consegue concluir, em vez de deixar o Program Error cru do VFP subir.
61: *
62: * FASE 8 (eventos auxiliares e consolidacao final):
63: *  - RENOMEADOS para o nome CANONICO do projeto, que eh o VERBO da acao e nao
64: *    o nome do objeto legado: CmdProcessarClick -> BtnProcessarClick (botao de
65: *    acao, Caption "\<Processar", objeto legado cmdProcessar/btnProcessar) e
66: *    CmdSairClick -> BtnEncerrarClick (Caption "Encerrar", objeto legado
67: *    btnsair). CmdSelTudoClick/CmdApagaTudoClick FICAM com o prefixo Cmd: nao

*-- Linhas 93 a 195:
93: *    (btnsair.Click = "ThisForm.Release"). Inventar o botao violaria o PILAR 1
94: *    e escrever o metodo vazio seria stub (proibido pela regra de completude).
95: *  - HabilitarCampos(): nao existe no legado estado em que campo ou grade
96: *    mudem de Enabled/ReadOnly. Os unicos "PROCEDURE When" do SCX sao os cinco
97: *    "Return(.f.)" das celulas Column2..Column6, ja migrados como
98: *    Column.ReadOnly = .T. em ConfigurarGridDados, e o unico Enabled que o
99: *    legado move em runtime eh o do PROPRIO botao Processar - que virou
100: *    AjustarBotoesPorModo. Implementar o metodo aqui seria ou um no-op (stub)
101: *    ou a invencao de um estado desabilitado que o legado nao tem.
102: *  - BtnBuscarClick(): a tela nao tem busca. A grade carrega a tabela inteira
103: *    ("Select 0 as SelImp, * From SigMlItn", sem Where no Init legado) e a
104: *    ordenacao por clique no cabecalho ja esta em OrdenarGrade/GradeHeader*Click.
105: *==============================================================================
106: 
107: DEFINE CLASS FormSigPrMlu AS FormBase
108: 
109:     *-- Dimensoes (PILAR 1: identico ao legado SIGPRMLU.SCX)
110:     Width       = 794
111:     Height      = 533
112:     AutoCenter  = .T.
113:     TitleBar    = 0
114:     ShowWindow  = 1
115:     WindowType  = 1
116:     ControlBox  = .F.
117:     Closable    = .F.
118:     MaxButton   = .F.
119:     MinButton   = .F.
120:     BorderStyle = 2
121:     DataSession = 2
122:     KeyPreview  = .T.
123:     Caption     = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"
124: 
125:     *-- Business Object
126:     this_oBusinessObject = .NULL.
127: 
128:     *-- Estado da tela. O legado NAO tem pcEscolha (nao herda de frmcadastro):
129:     *-- os estados reais sao "LISTA" (grade de malas disponivel para selecao)
130:     *-- e "PROCESSANDO" (unificacao em curso, com This.Enabled = .f. no
131:     *-- CommandGroup cmdProcessar - grade e botoes travados durante o SCAN).
132:     this_cModoAtual = "LISTA"
133: 
134:     *-- Equivalente a ThisForm.GridOrder do legado (AcertaGrades/MontaGrades):
135:     *-- coluna de ordenacao corrente da grade (2=Codigos, 3=Descs, 4=UsuIns,
136:     *-- 5=DatIns). Legado inicializa GridOrder = 2 no Init.
137:     this_nGridOrder = 2
138: 
139:     *==========================================================================
140:     * Init - Legado: "Lparameters pCodigos" (declarado mas nunca referenciado
141:     * no corpo do metodo nem em nenhum outro ponto do form) - nao ha parametro
142:     * real para repassar.
143:     *==========================================================================
144:     PROCEDURE Init()
145:     *==========================================================================
146:         RETURN DODEFAULT()
147:     ENDPROC
148: 
149:     *==========================================================================
150:     * ConfigurarCabecalho - Cria cnt_4c_Sombra com os labels de titulo
151:     * Original: cntSombra Top=0, Left=0, Width=800, Height=80, BackColor=100,100,100
152:     *   lblSombra  Top=18, Left=10, Width=769, Height=40, ForeColor=0,0,0 (sombra)
153:     *   lblTitulo  Top=17, Left=10, Width=769, Height=46, ForeColor=255,255,255
154:     *==========================================================================
155:     PROTECTED PROCEDURE ConfigurarCabecalho()
156:     *==========================================================================
157:         LOCAL loc_oErro
158:         TRY
159:             THIS.AddObject("cnt_4c_Sombra", "Container")
160:             WITH THIS.cnt_4c_Sombra
161:                 .Top         = 0
162:                 .Left        = 0
163:                 .Width       = THIS.Width
164:                 .Height      = 80
165:                 .BackStyle   = 1
166:                 .BackColor   = RGB(100, 100, 100)
167:                 .BorderWidth = 0
168:                 .Visible     = .T.
169:             ENDWITH
170: 
171:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
172:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
173:                 .FontBold      = .T.
174:                 .FontName      = "Tahoma"
175:                 .FontSize      = 18
176:                 .FontUnderline = .F.
177:                 .WordWrap      = .T.
178:                 .Alignment     = 0
179:                 .BackStyle     = 0
180:                 .AutoSize      = .F.
181:                 .Caption       = THIS.Caption
182:                 .Height        = 40
183:                 .Left          = 10
184:                 .Top           = 18
185:                 .Width         = THIS.Width - 20
186:                 .ForeColor     = RGB(0, 0, 0)
187:                 .Visible       = .T.
188:             ENDWITH
189: 
190:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
191:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
192:                 .FontBold      = .T.
193:                 .FontName      = "Tahoma"
194:                 .FontSize      = 18
195:                 .WordWrap      = .T.

*-- Linhas 207 a 262:
207:             ENDWITH
208:         CATCH TO loc_oErro
209:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
210:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
211:         ENDTRY
212:     ENDPROC
213: 
214:     *==========================================================================
215:     * ConfigurarGridDados - Grade "grdselecoes" do legado: lista as malas
216:     * diretas cadastradas (SigMlItn), com checkbox de selecao na Column1
217:     * (SelImp) para escolher quais malas serao unificadas pelo cmd_4c_Processar.
218:     * ControlSource/RecordSource ficam para CarregarLista() - cursor_4c_Dados
219:     * ainda nao existe aqui (regra #41 do CLAUDE.md).
220:     * Original: grdselecoes Top=159 Left=49 Width=660 Height=324
221:     *==========================================================================
222:     PROTECTED PROCEDURE ConfigurarGridDados()
223:     *==========================================================================
224:         LOCAL loc_oGrid
225: 
226:         THIS.AddObject("grd_4c_Dados", "Grid")
227:         loc_oGrid = THIS.grd_4c_Dados
228: 
229:         WITH loc_oGrid
230:             .Top               = 159
231:             .Left              = 49
232:             .Width             = 660
233:             .Height            = 324
234:             .ColumnCount       = 6
235:             .FontName          = "Tahoma"
236:             .FontSize          = 8
237:             .HeaderHeight      = 16
238:             .RowHeight         = 16
239:             .AllowHeaderSizing = .F.
240:             .AllowRowSizing    = .F.
241:             .DeleteMark        = .F.
242:             .RecordMark        = .F.
243:             .ReadOnly          = .F.
244:             .ScrollBars        = 2
245:             .GridLineColor     = RGB(238, 238, 238)
246:             .Visible           = .T.
247:         ENDWITH
248: 
249:         *-- Column1: checkbox de marcacao (SelImp). Pattern #185/#186
250:         *-- (Erro146): CheckBox de Column exige AddObject + CurrentControl +
251:         *-- Sparse = .F., e NAO alterna sem os 4 handlers de evento abaixo.
252:         WITH loc_oGrid.Column1
253:             .Width     = 15
254:             .ReadOnly  = .F.
255:             .Sparse    = .F.
256:             .Movable   = .F.
257:             .Resizable = .F.
258:             .AddObject("chk_4c_Check1", "CheckBox")
259:             .chk_4c_Check1.Top       = 9
260:             .chk_4c_Check1.Left      = 2
261:             .chk_4c_Check1.Height    = 17
262:             .chk_4c_Check1.Width     = 22

*-- Linhas 382 a 538:
382: 
383:         *-- Ordenacao por clique no cabecalho (legado: Column2..5.Header1.Click
384:         *-- chama AcertaGrades(N) - Column1/Column6 nao tem Click no dump)
385:         BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GradeHeaderCodigosClick")
386:         BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "GradeHeaderDescsClick")
387:         BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "GradeHeaderUsuInsClick")
388:         BINDEVENT(loc_oGrid.Column5.Header1, "Click", THIS, "GradeHeaderDatInsClick")
389:     ENDPROC
390: 
391:     *==========================================================================
392:     * ConfigurarBotoesAcao - Botoes de acao da tela (equivalentes aos 3
393:     * CommandGroups do legado - cmdProcessar/Commandgroup2/cmdBtnGrade, cada
394:     * um com ButtonCount 1 ou 2); migrados para CommandButton standalone,
395:     * preservando a geometria ABSOLUTA (grupo.Left/Top + botao.Left/Top do
396:     * dump) e Caption/Picture/cor de cada botao interno.
397:     *==========================================================================
398:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
399:     *==========================================================================
400:         *-- cmdProcessar (Command1/btnProcessar): grupo Left=637 Top=-2,
401:         *-- botao Left=5 Top=5 -> absoluto 642,3. Themes=.T.+DisabledPicture
402:         *-- SAO EXCECAO ao legado (Themes=.F.): este botao e desabilitado em
403:         *-- runtime (This.Enabled=.f. durante o processamento) e sem Themes=.T.
404:         *-- o icone desaparece com Enabled=.F. (regra #99 do CLAUDE.md).
405:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
406:         WITH THIS.cmd_4c_Processar
407:             .Top             = 3
408:             .Left            = 642
409:             .Width           = 75
410:             .Height          = 75
411:             .FontBold        = .T.
412:             .FontItalic      = .T.
413:             .FontName        = "Comic Sans MS"
414:             .FontSize        = 8
415:             .WordWrap        = .T.
416:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
417:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
418:             .Caption         = "\<Processar"
419:             .ForeColor       = RGB(90, 90, 90)
420:             .BackColor       = RGB(255, 255, 255)
421:             .Themes          = .T.
422:             .Visible         = .T.
423:         ENDWITH
424:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
425: 
426:         *-- Commandgroup2 (Command1/btnsair): grupo Left=712 Top=-2, botao
427:         *-- Left=5 Top=5 -> absoluto 717,3. Themes=.F. como no legado (nunca
428:         *-- desabilitado em runtime).
429:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
430:         WITH THIS.cmd_4c_Sair
431:             .Top        = 3
432:             .Left       = 717
433:             .Width      = 75
434:             .Height     = 75
435:             .FontBold   = .T.
436:             .FontItalic = .T.
437:             .FontName   = "Comic Sans MS"
438:             .FontSize   = 8
439:             .WordWrap   = .T.
440:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
441:             .Cancel     = .T.
442:             .Caption    = "Encerrar"
443:             .ForeColor  = RGB(90, 90, 90)
444:             .BackColor  = RGB(255, 255, 255)
445:             .Themes           = .T.
446:             .Visible    = .T.
447:         ENDWITH
448:         BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnEncerrarClick")
449: 
450:         *-- cmdBtnGrade (Command1/btnMarcar + Command2/btnDesmarcar): grupo
451:         *-- Left=715 Top=280. Command1 Left=5 Top=5 -> absoluto 720,285.
452:         *-- Command2 Left=5 Top=45 -> absoluto 720,325.
453:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
454:         WITH THIS.cmd_4c_SelTudo
455:             .Top         = 285
456:             .Left        = 720
457:             .Width       = 40
458:             .Height      = 40
459:             .FontName    = "Verdana"
460:             .FontSize    = 8
461:             .WordWrap    = .T.
462:             .Picture     = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
463:             .Caption     = ""
464:             .ToolTipText = "Seleciona Tudo"
465:             .ForeColor   = RGB(36, 84, 155)
466:             .BackColor   = RGB(255, 255, 255)
467:             .Themes           = .T.
468:             .Visible     = .T.
469:         ENDWITH
470:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
471: 
472:         THIS.AddObject("cmd_4c_ApagaTudo", "CommandButton")
473:         WITH THIS.cmd_4c_ApagaTudo
474:             .Top         = 325
475:             .Left        = 720
476:             .Width       = 40
477:             .Height      = 40
478:             .FontName    = "Verdana"
479:             .FontSize    = 8
480:             .WordWrap    = .T.
481:             .Picture     = gc_4c_CaminhoIcones + "onebit_33.ico"
482:             .Caption     = ""
483:             .ToolTipText = "Apaga Tudo"
484:             .ForeColor   = RGB(36, 84, 155)
485:             .BackColor   = RGB(255, 255, 255)
486:             .Themes           = .T.
487:             .Visible     = .T.
488:         ENDWITH
489:         BINDEVENT(THIS.cmd_4c_ApagaTudo, "Click", THIS, "CmdApagaTudoClick")
490:     ENDPROC
491: 
492:     *==========================================================================
493:     * ConfigurarContainerNova - Container "cntNova": campo onde o usuario
494:     * digita o nome da unificacao (equivalente a ThisForm.cntNova.getNova do
495:     * legado, lido em BtnProcessarClick/ProcessarUnificacao).
496:     * Original: cntNova Top=112 Left=49 Width=660 Height=42
497:     *==========================================================================
498:     PROTECTED PROCEDURE ConfigurarContainerNova()
499:     *==========================================================================
500:         THIS.AddObject("cnt_4c_Nova", "Container")
501:         WITH THIS.cnt_4c_Nova
502:             .Top           = 112
503:             .Left          = 49
504:             .Width         = 660
505:             .Height        = 42
506:             .BackStyle     = 0
507:             .BorderWidth   = 0
508:             .SpecialEffect = 0
509:             .Visible       = .T.
510:         ENDWITH
511: 
512:         *-- Label1: classe "say" do legado (AutoSize=.T. sem Width/Alignment
513:         *-- declarados) - regra #23 do CLAUDE.md: AutoSize e no-op em
514:         *-- AddObject, usar Width/Height ja calculados pelo Form Designer.
515:         THIS.cnt_4c_Nova.AddObject("lbl_4c_Label1", "Label")
516:         WITH THIS.cnt_4c_Nova.lbl_4c_Label1
517:             .AutoSize  = .F.
518:             .FontBold  = .T.
519:             .FontName  = "Tahoma"
520:             .FontSize  = 8
521:             .BackStyle = 0
522:             .Alignment = 0
523:             .Caption   = " \<Nome da Unifica" + CHR(231) + CHR(227) + "o :"
524:             .Height    = 15
525:             .Left      = 20
526:             .Top       = 13
527:             .Width     = 121
528:             .ForeColor = RGB(90, 90, 90)
529:             .Visible   = .T.
530:         ENDWITH
531: 
532:         THIS.cnt_4c_Nova.AddObject("txt_4c_Nova", "TextBox")
533:         WITH THIS.cnt_4c_Nova.txt_4c_Nova
534:             .FontName          = "Courier New"
535:             .FontSize          = 9
536:             .Format            = "K"
537:             .Height            = 25
538:             .Left              = 151

*-- Linhas 552 a 654:
552:     ENDPROC
553: 
554:     *==========================================================================
555:     * InicializarForm - Cria o BO e a estrutura visual completa: cabecalho,
556:     * grade de selecao (grd_4c_Dados), botoes de acao (Processar/Sair/
557:     * Marcar/Desmarcar) e o campo "Nome da Unificacao".
558:     *==========================================================================
559:     PROTECTED PROCEDURE InicializarForm()
560:     *==========================================================================
561:         LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
562:         loc_lSucesso = .F.
563:         loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
564:                                     (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
565: 
566:         TRY
567:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
568: 
569:             *-- DataSession=2 nasce no default do VFP (regra #9.4) - SET DELETED
570:             *-- nao herda o SET do config.prg
571:             SET DELETED ON
572: 
573:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrMluBO")
574: 
575:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
576:                 THIS.ConfigurarCabecalho()
577:                 THIS.ConfigurarGridDados()
578:                 THIS.ConfigurarBotoesAcao()
579:                 THIS.ConfigurarContainerNova()
580: 
581:                 THIS.TornarControlesVisiveis(THIS)
582: 
583:                 *-- Estado inicial pelo funil unico: a tela nasce em "LISTA"
584:                 *-- (grade disponivel para selecao, Processar liberado)
585:                 THIS.this_cModoAtual = "LISTA"
586:                 THIS.AjustarBotoesPorModo()
587: 
588:                 *-- Carga inicial da grade - pulada em validacao de UI / modo
589:                 *-- teste (sem gnConnHandle real)
590:                 IF !loc_lModoValidacaoOuTeste
591:                     THIS.CarregarLista()
592:                 ENDIF
593: 
594:                 THIS.Visible = .T.
595:                 loc_lSucesso = .T.
596:             ELSE
597:                 MsgErro("Falha ao criar SigPrMluBO.", "Erro em InicializarForm")
598:             ENDIF
599:         CATCH TO loc_oErro
600:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
601:                 "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
602:         ENDTRY
603: 
604:         RETURN loc_lSucesso
605:     ENDPROC
606: 
607:     *==========================================================================
608:     * CarregarLista - Popula cursor_4c_Dados (equivalente a crSigMlItn) com
609:     * as malas diretas cadastradas e liga a grade. O cursor precisa ser
610:     * READWRITE porque a Column1 (chk_4c_Check1) grava SelImp por linha
611:     * (regra do CLAUDE.md: Grid com coluna editavel exige cursor READWRITE -
612:     * SQLEXEC() cria cursor somente-leitura).
613:     *==========================================================================
614:     PROCEDURE CarregarLista()
615:     *==========================================================================
616:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
617: 
618:         loc_lSucesso = .F.
619: 
620:         IF USED("cursor_4c_DadosTmp")
621:             USE IN cursor_4c_DadosTmp
622:         ENDIF
623: 
624:         loc_cSQL = "SELECT 0 AS SelImp, codigos AS Codigos, descs AS Descs, " + ;
625:             "usuins AS UsuIns, datins AS DatIns, nregis AS NRegis FROM SigMlItn"
626: 
627:         SET NULL ON
628:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
629:         SET NULL OFF
630: 
631:         IF loc_nResultado >= 0
632:             IF USED("cursor_4c_Dados")
633:                 USE IN cursor_4c_Dados
634:             ENDIF
635: 
636:             SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
637:             USE IN cursor_4c_DadosTmp
638: 
639:             SELECT cursor_4c_Dados
640:             INDEX ON Codigos TAG Codigos
641:             INDEX ON Descs   TAG Descs
642:             INDEX ON UsuIns  TAG UsuIns
643:             INDEX ON DatIns  TAG DatIns
644: 
645:             THIS.grd_4c_Dados.RecordSource = ""
646:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.SelImp"
647:             THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.Codigos"
648:             THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Dados.Descs"
649:             THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Dados.UsuIns"
650:             THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Dados.DatIns"
651:             THIS.grd_4c_Dados.Column6.ControlSource = "cursor_4c_Dados.NRegis"
652:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
653: 
654:             *-- RecordSource reseta ControlSource/Width/Header/CurrentControl

*-- Linhas 691 a 1078:
691:     * (equivalente a AcertaGrades(pColuna) do legado) e realca o cabecalho
692:     * da coluna ativa com RGB(220,255,220), como no legado.
693:     *==========================================================================
694:     PROCEDURE OrdenarGrade(par_nColuna)
695:     *==========================================================================
696:         LOCAL loc_cTag, loc_nI, loc_cCaminho
697: 
698:         IF VARTYPE(par_nColuna) = "N"
699:             THIS.this_nGridOrder = par_nColuna
700:         ENDIF
701: 
702:         DO CASE
703:             CASE THIS.this_nGridOrder = 3
704:                 loc_cTag = "Descs"
705:             CASE THIS.this_nGridOrder = 4
706:                 loc_cTag = "UsuIns"
707:             CASE THIS.this_nGridOrder = 5
708:                 loc_cTag = "DatIns"
709:             OTHERWISE
710:                 loc_cTag = "Codigos"
711:         ENDCASE
712: 
713:         IF USED("cursor_4c_Dados")
714:             SELECT cursor_4c_Dados
715:             SET ORDER TO TAG (loc_cTag)
716:             GO TOP
717:         ENDIF
718: 
719:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
720:             FOR loc_nI = 1 TO THIS.grd_4c_Dados.ColumnCount
721:                 loc_cCaminho = "THIS.grd_4c_Dados.Column" + ALLTRIM(STR(loc_nI, 2)) + ".Header1.BackColor"
722:                 STORE IIF(THIS.this_nGridOrder = loc_nI, RGB(220, 255, 220), THIS.BackColor) TO (loc_cCaminho)
723:             ENDFOR
724:             THIS.grd_4c_Dados.Refresh()
725:         ENDIF
726:     ENDPROC
727: 
728:     *==========================================================================
729:     * GradeHeader*Click - Disparados pelo clique nos cabecalhos das colunas
730:     * 2 a 5 (equivalente a Column2..5.Header1.Click chamando AcertaGrades(N)
731:     * no legado - Column1/Column6 nao tem Click no dump)
732:     *==========================================================================
733:     PROCEDURE GradeHeaderCodigosClick()
734:     *==========================================================================
735:         THIS.OrdenarGrade(2)
736:     ENDPROC
737: 
738:     PROCEDURE GradeHeaderDescsClick()
739:     *==========================================================================
740:         THIS.OrdenarGrade(3)
741:     ENDPROC
742: 
743:     PROCEDURE GradeHeaderUsuInsClick()
744:     *==========================================================================
745:         THIS.OrdenarGrade(4)
746:     ENDPROC
747: 
748:     PROCEDURE GradeHeaderDatInsClick()
749:     *==========================================================================
750:         THIS.OrdenarGrade(5)
751:     ENDPROC
752: 
753:     *==========================================================================
754:     * BindToggleSelecao - Liga os 4 eventos do checkbox de selecao da grade
755:     * (Pattern #185/#186 - Erro146: CheckBox de Column NAO alterna sem os
756:     * handlers de Click/MouseDown/MouseUp/KeyPress, todos com NODEFAULT)
757:     *==========================================================================
758:     PROTECTED PROCEDURE BindToggleSelecao(par_oChk)
759:     *==========================================================================
760:         BINDEVENT(par_oChk, "KeyPress",  THIS, "ChkSelecaoKeyPress")
761:         BINDEVENT(par_oChk, "MouseDown", THIS, "ChkSelecaoMouseDown")
762:         BINDEVENT(par_oChk, "MouseUp",   THIS, "ChkSelecaoMouseUp")
763:         BINDEVENT(par_oChk, "Click",     THIS, "ChkSelecaoClick")
764:     ENDPROC
765: 
766:     *==========================================================================
767:     * ChkSelecaoToggle - Alterna SelImp da linha corrente de cursor_4c_Dados
768:     * (equivalente a "m.SelImp = Iif(crSigMlItn.SelImp=1, 0, 1) / Gather
769:     * Memvar Fields SelImp" do legado - disparado no MouseDown/KeyPress)
770:     *==========================================================================
771:     PROCEDURE ChkSelecaoToggle()
772:     *==========================================================================
773:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
774:             SELECT cursor_4c_Dados
775:             REPLACE SelImp WITH IIF(NVL(SelImp, 0) = 1, 0, 1)
776:             THIS.grd_4c_Dados.Refresh()
777:         ENDIF
778:     ENDPROC
779: 
780:     PROCEDURE ChkSelecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
781:     *==========================================================================
782:         IF INLIST(par_nKeyCode, 13, 32)
783:             THIS.ChkSelecaoToggle()
784:             NODEFAULT
785:         ENDIF
786:     ENDPROC
787: 
788:     *-- MouseDown apenas SUPRIME o toggle nativo (legado: "NoDefault" e nada
789:     *-- mais). Quem alterna eh o MouseUp - o legado chama "This.KeyPress(13,0)"
790:     *-- de dentro dele. Invertidos, o valor alterna antes de o clique terminar
791:     *-- e um arraste sobre a celula alterna sem o usuario soltar o botao.
792:     PROCEDURE ChkSelecaoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
793:     *==========================================================================
794:         NODEFAULT
795:     ENDPROC
796: 
797:     PROCEDURE ChkSelecaoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
798:     *==========================================================================
799:         THIS.ChkSelecaoToggle()
800:         NODEFAULT
801:     ENDPROC
802: 
803:     PROCEDURE ChkSelecaoClick()
804:     *==========================================================================
805:         NODEFAULT
806:     ENDPROC
807: 
808:     *==========================================================================
809:     * BtnEncerrarClick - Encerra o formulario (equivalente a ThisForm.Release do
810:     * btnsair.Click legado)
811:     *==========================================================================
812:     PROCEDURE BtnEncerrarClick()
813:     *==========================================================================
814:         THIS.Release()
815:     ENDPROC
816: 
817:     *==========================================================================
818:     * MarcarTodasAs - Funil UNICO dos dois botoes do cmdBtnGrade legado. No
819:     * SCX os dois sao um CommandGroup com ButtonCount = 2 e UM Click so:
820:     *
821:     *     Update crSigMlItn Set SelImp = This.Value
822:     *     ThisForm.grdSelecoes.Refresh
823:     *
824:     * O unico dado que muda entre btnMarcar e btnDesmarcar e o "This.Value"
825:     * do grupo, isto e o INDICE do botao clicado - 1 no primeiro e 2 no
826:     * segundo. Por isso os dois handlers abaixo apenas chamam este metodo com
827:     * o indice correspondente, em vez de duplicar a logica.
828:     *
829:     * O valor 2 do botao Desmarcar e transcricao LITERAL (regra #17): o
830:     * legado nao grava 0 ao desmarcar, grava o indice do botao, e != 1 ja
831:     * basta para a linha sair do filtro "SelImp = 1" usado em
832:     * ValidarProcessamento/ProcessarUnificacao.
833:     *
834:     * UPDATE-SQL e nao REPLACE ALL: o legado usa "Update ... Set" porque
835:     * REPLACE ALL percorre o cursor inteiro e deixa o ponteiro em EOF - a
836:     * grade saltaria para o fim e perderia a linha corrente a cada clique nos
837:     * botoes, divergencia visivel que o legado nao tem. O RECNO() e salvo e
838:     * restaurado porque a grade continua ancorada no ponteiro do cursor
839:     * (regra #21a), e fechamos com Refresh como o legado.
840:     *
841:     * "m.par_nValor" com prefixo m. e obrigatorio: em comando SQL do VFP um
842:     * identificador solto e resolvido primeiro como COLUNA do cursor.
843:     *==========================================================================
844:     PROTECTED PROCEDURE MarcarTodasAs(par_nValor)
845:     *==========================================================================
846:         LOCAL loc_nRec, loc_oErro
847: 
848:         TRY
849:             IF USED("cursor_4c_Dados")
850:                 SELECT cursor_4c_Dados
851:                 loc_nRec = RECNO()
852: 
853:                 UPDATE cursor_4c_Dados SET SelImp = m.par_nValor
854: 
855:                 SELECT cursor_4c_Dados
856:                 IF BETWEEN(loc_nRec, 1, RECCOUNT("cursor_4c_Dados"))
857:                     GO loc_nRec
858:                 ELSE
859:                     GO TOP
860:                 ENDIF
861: 
862:                 THIS.grd_4c_Dados.Refresh()
863:             ENDIF
864:         CATCH TO loc_oErro
865:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
866:                 "Procedure: " + loc_oErro.Procedure, "Erro em MarcarTodasAs")
867:         ENDTRY
868:     ENDPROC
869: 
870:     *==========================================================================
871:     * CmdSelTudoClick - 1o botao do cmdBtnGrade ("btnMarcar", ToolTip
872:     * "Seleciona Tudo"): marca todas as malas da grade. This.Value = 1.
873:     *==========================================================================
874:     PROCEDURE CmdSelTudoClick()
875:     *==========================================================================
876:         THIS.MarcarTodasAs(1)
877:     ENDPROC
878: 
879:     *==========================================================================
880:     * CmdApagaTudoClick - 2o botao do cmdBtnGrade ("btnDesmarcar", ToolTip
881:     * "Apaga Tudo"): desmarca todas as malas da grade. This.Value = 2.
882:     *==========================================================================
883:     PROCEDURE CmdApagaTudoClick()
884:     *==========================================================================
885:         THIS.MarcarTodasAs(2)
886:     ENDPROC
887: 
888:     *==========================================================================
889:     * ValidarProcessamento - REGRA DOS CAMPOS que esta fase entrega, em FONTE
890:     * UNICA. No legado ela NAO mora em evento de campo: o dump nao tem
891:     * Valid/When/LostFocus em getNova (grep "PROCEDURE" no SIGPRMLU devolve so
892:     * acertagrades/montagrades/processamento/Release/Init e os Click/KeyPress/
893:     * MouseUp/MouseDown do Check1 da grade) - ela mora DENTRO do
894:     * cmdProcessar.Click e governa o campo "Nome da Unificacao"
895:     * (cnt_4c_Nova.txt_4c_Nova) mais a selecao da grade. Por isso nasce AQUI e
896:     * o handler do botao apenas CHAMA.
897:     *
898:     * Transcricao literal dos tres guards do legado, na MESMA ordem, com as
899:     * MESMAS mensagens e os MESMOS destinos de SetFocus:
900:     *   1) Reccount('csTmp') < 1   -> "Nenhuma Mala Direta Com Registros..."    -> grade
901:     *   2) Reccount('csTmp') = 1   -> "Apenas Uma Mala Direta Com Registros..." -> grade
902:     *   3) IsEmpty(getNova.Value)  -> "Nome da Unificacao Invalido!!!..."        -> campo
903:     *
904:     * O csTmp do legado ("Select Codigos From crSigMlItn Where (SelImp = 1)
905:     * Into Cursor csTmp") so existe para ser contado: aqui o equivalente eh o
906:     * COUNT FOR sobre cursor_4c_Dados, sem criar cursor.
907:     *
908:     * O TEXTBOX eh a FONTE UNICA do nome - o legado le
909:     * ThisForm.cntNova.getNova.Value direto, inclusive no Insert e na mensagem
910:     * final de conclusao. O espelho para a property do BO eh feito aqui, DEPOIS
911:     * de validar, para que nenhum caminho grave o nome ANTIGO quando o usuario
912:     * limpa o campo entre duas unificacoes.
913:     *
914:     * PUBLIC de proposito: chamado de FORA da classe pelo handler do botao
915:     * (BINDEVENT descarta retorno de delegate, por isso o guard eh chamado em
916:     * codigo) e pelos harnesses de teste - regras #3 e #51 do CLAUDE.md.
917:     *
918:     * Retorna .T. quando os tres guards passam.
919:     *==========================================================================
920:     PROCEDURE ValidarProcessamento()
921:     *==========================================================================
922:         LOCAL loc_lValido, loc_nSelecionadas, loc_oErro
923: 
924:         loc_lValido       = .T.
925:         loc_nSelecionadas = 0
926: 
927:         *-- TRY/CATCH obrigatorio: este metodo eh o funil de validacao chamado
928:         *-- de FORA (BtnProcessarClick e harness de teste). Sem ele uma falha
929:         *-- aqui sobe como "Program Error" CRU do VFP, em vez do dialogo do
930:         *-- sistema, e o BtnProcessarClick nem chegaria a reabilitar o botao.
931:         *-- Nenhum RETURN dentro do TRY (regra #1): o veredicto sai pela flag
932:         *-- loc_lValido e ha um RETURN unico DEPOIS do ENDTRY.
933:         TRY
934:             IF USED("cursor_4c_Dados")
935:                 SELECT cursor_4c_Dados
936:                 GO TOP
937:                 COUNT FOR NVL(SelImp, 0) = 1 TO loc_nSelecionadas
938:             ENDIF
939: 
940:             DO CASE
941:                 CASE loc_nSelecionadas < 1
942:                     MsgAviso("Nenhuma Mala Direta Com Registros Foi Selecionada Para Unifica" + ;
943:                         CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
944:                     THIS.grd_4c_Dados.SetFocus()
945:                     loc_lValido = .F.
946: 
947:                 CASE loc_nSelecionadas = 1
948:                     MsgAviso("Apenas Uma Mala Direta Com Registros Foi Selecionada Para Ser Unificada!!!" + CHR(13) + ;
949:                         "N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + ;
950:                         "vel Unificar Apenas Uma Mala Direta, Selecione Ao Menos Duas!!!", ;
951:                         "Aten" + CHR(231) + CHR(227) + "o")
952:                     THIS.grd_4c_Dados.SetFocus()
953:                     loc_lValido = .F.
954: 
955:                 CASE EMPTY(ALLTRIM(THIS.cnt_4c_Nova.txt_4c_Nova.Value))
956:                     MsgAviso("Nome da Unifica" + CHR(231) + CHR(227) + "o Invalido!!! Este " + CHR(233) + ;
957:                         " o Nome Que" + CHR(13) + "Vai Ser Utilizado Na Unifica" + CHR(231) + CHR(227) + ;
958:                         "o Que Ser" + CHR(225) + " Gerada!!!", "Aten" + CHR(231) + CHR(227) + "o")
959:                     THIS.cnt_4c_Nova.txt_4c_Nova.SetFocus()
960:                     loc_lValido = .F.
961:             ENDCASE
962: 
963:             *-- Espelho tela -> BO (so com os guards aprovados), delegado ao
964:             *-- funil unico FormParaBO. Fica DEPOIS da validacao para que
965:             *-- nenhum caminho grave o nome ANTIGO quando o usuario limpa o
966:             *-- campo entre duas unificacoes, e a falha dele REPROVA: sem o
967:             *-- espelho, ProcessarUnificacao leria property vazia.
968:             IF loc_lValido
969:                 loc_lValido = THIS.FormParaBO()
970:             ENDIF
971:         CATCH TO loc_oErro
972:             *-- Validacao que nao conseguiu concluir REPROVA: deixar passar
973:             *-- gravaria a unificacao sem os tres guards do legado.
974:             loc_lValido = .F.
975:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
976:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarProcessamento")
977:         ENDTRY
978: 
979:         RETURN loc_lValido
980:     ENDPROC
981: 
982:     *==========================================================================
983:     * BtnProcessarClick - Handler do botao Processar (cmdProcessar.Click do
984:     * legado). Reproduz, na ordem do legado: repinta a grade e volta ao topo
985:     * (Refresh / Go Top In crSigMlItn / Refresh - regra #21a: popular/alterar
986:     * cursor nao repinta sozinho, e o toggle do checkbox grava por REPLACE),
987:     * trava o botao (This.Enabled = .f.), valida pelo funil unico
988:     * ValidarProcessamento(), pede confirmacao e dispara ProcessarUnificacao().
989:     * O "This.Enabled = .t." aparece em TODOS os caminhos de saida do legado -
990:     * aqui eh uma unica linha no fim, equivalente e sem repeticao.
991:     *==========================================================================
992:     PROCEDURE BtnProcessarClick()
993:     *==========================================================================
994:         LOCAL loc_oErro
995: 
996:         TRY
997:             THIS.grd_4c_Dados.Refresh()
998:             IF USED("cursor_4c_Dados")
999:                 SELECT cursor_4c_Dados
1000:                 GO TOP
1001:             ENDIF
1002:             THIS.grd_4c_Dados.Refresh()
1003: 
1004:             THIS.this_cModoAtual = "PROCESSANDO"
1005:             THIS.AjustarBotoesPorModo()
1006: 
1007:             IF THIS.ValidarProcessamento()
1008:                 IF MsgConfirma("Confirma a Unifica" + CHR(231) + CHR(227) + "o das Malas Diretas?", ;
1009:                     "Confirma" + CHR(231) + CHR(227) + "o")
1010:                     THIS.ProcessarUnificacao()
1011:                 ENDIF
1012:             ENDIF
1013:         CATCH TO loc_oErro
1014:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1015:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
1016:         ENDTRY
1017: 
1018:         *-- Reabilitacao INCONDICIONAL e FORA do TRY. O legado repete
1019:         *-- "This.Enabled = .t." nos QUATRO caminhos de saida do
1020:         *-- cmdProcessar.Click (os tres "Return 0" dos guards e o fim do
1021:         *-- metodo) exatamente para que nenhuma saida deixe o botao travado.
1022:         *-- Uma unica linha depois do ENDTRY cobre os quatro MAIS o caminho de
1023:         *-- excecao: sem ela, um erro em ValidarProcessamento/
1024:         *-- ProcessarUnificacao deixaria o Processar cinza pelo resto da vida
1025:         *-- do form e a tela ficaria inutilizavel sem fechar e reabrir
1026:         *-- (regra #40 - quem DESABILITA reabilita no funil de volta).
1027:         THIS.this_cModoAtual = "LISTA"
1028:         THIS.AjustarBotoesPorModo()
1029:     ENDPROC
1030: 
1031:     *==========================================================================
1032:     * ProcessarUnificacao - Unifica as malas diretas marcadas numa mala NOVA
1033:     * (equivalente ao PROCEDURE processamento do legado): gera um codigo novo,
1034:     * duplica os registros de SigMlCab de cada mala selecionada na mala nova
1035:     * (deduplicando por Desti+Ceps+Endes+Nums+Compls) e grava o cabecalho da
1036:     * mala nova em SigMlItn via o BusinessObject.
1037:     *==========================================================================
1038:     PROCEDURE ProcessarUnificacao()
1039:     *==========================================================================
1040:         LOCAL loc_cCodigoNovo, loc_cNomeUnificacao, loc_cUnificas, loc_nTotalOrigem, ;
1041:             loc_nTotalUnificado, loc_nMalasSelecionadas, loc_cSQL, loc_nResultado, ;
1042:             loc_cChaveUnica, loc_lSucesso, loc_oErro, loc_cCodMala, loc_lErroInsercao, loc_cMsg, ;
1043:             loc_lSnapshotOk
1044: 
1045:         loc_lSucesso        = .F.
1046:         loc_lErroInsercao   = .F.
1047:         loc_cUnificas        = ""
1048:         loc_nTotalOrigem     = 0
1049:         loc_nMalasSelecionadas = 0
1050: 
1051:         TRY
1052:             loc_cCodigoNovo = PADR(SUBSTR(SYS(2015), 3, 10), 10)
1053: 
1054:             *-- Snapshot da tela pelo funil unico FormParaBO. Chamado tambem
1055:             *-- aqui (e nao so no ValidarProcessamento) para o metodo ser
1056:             *-- auto-suficiente quando acionado de fora - harness de teste - e
1057:             *-- porque eh puro: reler a mesma tela devolve o mesmo valor.
1058:             *-- Dai em diante o TextBox e a contagem da grade NAO sao mais
1059:             *-- lidos: tudo vem das properties do BO.
1060:             loc_lSnapshotOk = THIS.FormParaBO()
1061:             IF !loc_lSnapshotOk
1062:                 *-- FormParaBO ja exibiu o proprio erro - aqui so aborta, sem
1063:                 *-- segunda mensagem (regra #9: CATCH nunca silencioso, mas
1064:                 *-- tambem nunca em duplicata).
1065:                 loc_lErroInsercao = .T.
1066:             ENDIF
1067: 
1068:             loc_cNomeUnificacao    = ALLTRIM(THIS.this_oBusinessObject.this_cNomeUnificacao)
1069:             loc_cUnificas          = THIS.this_oBusinessObject.this_cCodigosSelecionados
1070:             loc_nMalasSelecionadas = THIS.this_oBusinessObject.this_nTotalMalasSelecionadas
1071: 
1072:             *-- Cursor de dedup final (equivalente a csMalaUnificada), chave
1073:             *-- de unicidade igual ao legado: Padr(Upper(StrTran(Desti+Ceps+
1074:             *-- Endes+Nums+Compls,' ','')),200)
1075:             IF USED("cursor_4c_Unificada")
1076:                 USE IN cursor_4c_Unificada
1077:             ENDIF
1078: 

*-- Linhas 1251 a 1487:
1251: 
1252:         CATCH TO loc_oErro
1253:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1254:                 "Procedure: " + loc_oErro.Procedure, "Erro em ProcessarUnificacao")
1255:         ENDTRY
1256: 
1257:         *-- Encerra qualquer cursor temporario que tenha sobrevivido a um erro
1258:         IF USED("cursor_4c_MalasSel")
1259:             USE IN cursor_4c_MalasSel
1260:         ENDIF
1261:         IF USED("cursor_4c_MlCabTmp")
1262:             USE IN cursor_4c_MlCabTmp
1263:         ENDIF
1264:         IF USED("cursor_4c_Unificada")
1265:             USE IN cursor_4c_Unificada
1266:         ENDIF
1267: 
1268:         RETURN loc_lSucesso
1269:     ENDPROC
1270: 
1271:     *==========================================================================
1272:     * FormParaBO - Transferencia TELA -> BO, em FONTE UNICA.
1273:     *
1274:     * Nao eh convencao importada de form CRUD: o bloco EXISTE no legado, so
1275:     * nao tem esse nome. O cmdProcessar.Click le a tela em dois pontos -
1276:     * "ThisForm.cntNova.getNova.Value" (nome da unificacao) e o
1277:     * "Select Codigos From crSigMlItn Where (SelImp = 1)" (malas marcadas) -
1278:     * e o Processamento legado reusa os dois. Aqui os dois
1279:     * viram UMA leitura, gravada nas properties do BO, e nenhum outro metodo
1280:     * volta a tocar no TextBox nem a recontar a grade.
1281:     *
1282:     * PROTECTED obrigatoriamente: FormBase declara FormParaBO como PROTECTED e
1283:     * VFP9 nao permite ALARGAR o escopo de metodo herdado.
1284:     *
1285:     * O RECNO eh salvo e restaurado porque a grade continua ancorada no
1286:     * ponteiro do cursor (regra #21a) - o SCAN abaixo deixaria o ponteiro em
1287:     * EOF e a grade saltaria para o fim a cada clique em Processar.
1288:     *
1289:     * Retorna .T. quando a transferencia concluiu.
1290:     *==========================================================================
1291:     PROTECTED PROCEDURE FormParaBO()
1292:     *==========================================================================
1293:         LOCAL loc_lSucesso, loc_cCodigos, loc_nMalas, loc_nRec, loc_oErro
1294: 
1295:         loc_lSucesso = .F.
1296:         loc_cCodigos = ""
1297:         loc_nMalas   = 0
1298: 
1299:         *-- Nenhum RETURN dentro do TRY (regra #1): o veredicto sai pela flag
1300:         *-- loc_lSucesso e ha um RETURN unico DEPOIS do ENDTRY.
1301:         TRY
1302:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1303:                 IF USED("cursor_4c_Dados")
1304:                     SELECT cursor_4c_Dados
1305:                     loc_nRec = RECNO()
1306: 
1307:                     SCAN FOR NVL(SelImp, 0) = 1
1308:                         loc_cCodigos = loc_cCodigos + ALLTRIM(cursor_4c_Dados.Codigos) + "; "
1309:                         loc_nMalas   = loc_nMalas + 1
1310:                     ENDSCAN
1311: 
1312:                     SELECT cursor_4c_Dados
1313:                     IF BETWEEN(loc_nRec, 1, RECCOUNT("cursor_4c_Dados"))
1314:                         GO loc_nRec
1315:                     ELSE
1316:                         GO TOP
1317:                     ENDIF
1318:                 ENDIF
1319: 
1320:                 *-- MaxLength = 20 no SCX e SigMlItn.descs eh char(30): PADR em
1321:                 *-- 20 preserva a largura que o campo aceita, igual ao
1322:                 *-- Alltrim(getNova.Value) do Insert legado.
1323:                 THIS.this_oBusinessObject.this_cNomeUnificacao = ;
1324:                     PADR(ALLTRIM(THIS.cnt_4c_Nova.txt_4c_Nova.Value), 20)
1325: 
1326:                 THIS.this_oBusinessObject.this_cCodigosSelecionados    = loc_cCodigos
1327:                 THIS.this_oBusinessObject.this_nTotalMalasSelecionadas = loc_nMalas
1328: 
1329:                 loc_lSucesso = .T.
1330:             ENDIF
1331:         CATCH TO loc_oErro
1332:             loc_lSucesso = .F.
1333:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1334:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
1335:         ENDTRY
1336: 
1337:         RETURN loc_lSucesso
1338:     ENDPROC
1339: 
1340:     *==========================================================================
1341:     * BOParaForm - Transferencia BO -> TELA (sentido inverso de FormParaBO).
1342:     * Reflete this_cNomeUnificacao no campo "Nome da Unificacao". Usado como
1343:     * ponto de RECARGA em dois lugares: na criacao do campo
1344:     * (ConfigurarContainerNova) e no LimparCampos, que zera o BO e deixa este
1345:     * metodo apagar a tela - assim o valor exibido nunca divirge do BO.
1346:     *
1347:     * PROTECTED obrigatoriamente - FormBase declara BOParaForm como PROTECTED.
1348:     *==========================================================================
1349:     PROTECTED PROCEDURE BOParaForm()
1350:     *==========================================================================
1351:         LOCAL loc_oErro
1352: 
1353:         TRY
1354:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND PEMSTATUS(THIS, "cnt_4c_Nova", 5)
1355:                 THIS.cnt_4c_Nova.txt_4c_Nova.Value = ;
1356:                     ALLTRIM(NVL(THIS.this_oBusinessObject.this_cNomeUnificacao, ""))
1357:             ENDIF
1358:         CATCH TO loc_oErro
1359:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1360:                 "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
1361:         ENDTRY
1362:     ENDPROC
1363: 
1364:     *==========================================================================
1365:     * LimparCampos - Zera o estado de uma unificacao concluida: limpa as
1366:     * properties do BO (SigPrMluBO.LimparDados) e deixa o BOParaForm refletir
1367:     * o BO zerado no campo "Nome da Unificacao".
1368:     *
1369:     * A GRADE nao eh tocada aqui de proposito: o legado desmarca as malas
1370:     * refazendo a consulta ("ThisForm.poDataMgr.Requery('crSigMlItn')" sobre
1371:     * "Select 0 as SelImp, * From SigMlItn"), e no migrado quem reproduz isso
1372:     * eh CarregarLista, cujo SELECT tambem traz "0 AS SelImp". Desmarcar aqui
1373:     * tambem duplicaria a regra em dois lugares.
1374:     *
1375:     * PROTECTED obrigatoriamente - FormBase declara LimparCampos como PROTECTED.
1376:     *==========================================================================
1377:     PROTECTED PROCEDURE LimparCampos()
1378:     *==========================================================================
1379:         LOCAL loc_oErro
1380: 
1381:         TRY
1382:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1383:                 THIS.this_oBusinessObject.LimparDados()
1384:             ENDIF
1385: 
1386:             THIS.BOParaForm()
1387:         CATCH TO loc_oErro
1388:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1389:                 "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
1390:         ENDTRY
1391:     ENDPROC
1392: 
1393:     *==========================================================================
1394:     * AjustarBotoesPorModo - FUNIL UNICO do estado habilitado/desabilitado dos
1395:     * botoes, derivado de this_cModoAtual ("LISTA" / "PROCESSANDO").
1396:     *
1397:     * Reproduz EXATAMENTE o que o legado faz, e so isso: o cmdProcessar.Click
1398:     * trava e destrava o PROPRIO botao ("This.Enabled = .f." no inicio e
1399:     * "This.Enabled = .t." nos quatro caminhos de saida) e NAO mexe em
1400:     * Enabled/ReadOnly de mais nada - nem da grade, nem do campo, nem dos
1401:     * botoes de marcar/desmarcar. Travar mais do que isso seria divergencia
1402:     * visivel do legado (PILAR 1).
1403:     *
1404:     * Por que o funil existe em vez das duas atribuicoes soltas: quem
1405:     * DESABILITA tem de REABILITAR no caminho de volta (regra #40), e com a
1406:     * atribuicao espalhada pelos caminhos de saida basta um deles esquecer para
1407:     * o botao ficar cinza pelo resto da vida do form. Aqui o modo eh a unica
1408:     * fonte e BtnProcessarClick repoe "LISTA" DEPOIS do ENDTRY, cobrindo
1409:     * tambem o caminho de excecao.
1410:     *
1411:     * PUBLIC de proposito: o harness TesteAutomatico.prg chama
1412:     * oForm.AjustarBotoesPorModo() de FORA da classe (regras #3 e #51).
1413:     *==========================================================================
1414:     PROCEDURE AjustarBotoesPorModo()
1415:     *==========================================================================
1416:         LOCAL loc_lLiberado
1417: 
1418:         loc_lLiberado = (UPPER(ALLTRIM(NVL(THIS.this_cModoAtual, "LISTA"))) != "PROCESSANDO")
1419: 
1420:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
1421:             THIS.cmd_4c_Processar.Enabled = loc_lLiberado
1422:         ENDIF
1423:     ENDPROC
1424: 
1425:     *==========================================================================
1426:     * TornarControlesVisiveis - Torna visiveis os controles criados por
1427:     * AddObject (nascem com Visible=.F.), recursando em Pages e Containers.
1428:     * Este form nao tem container flutuante (Visible=.F. toggled por botao) -
1429:     * todos os objetos do SIGPRMLU.SCX sao estaticos.
1430:     *==========================================================================
1431:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1432:     *==========================================================================
1433:         LOCAL loc_nI, loc_oControle
1434: 
1435:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1436:             loc_oControle = par_oContainer.Controls(loc_nI)
1437: 
1438:             IF VARTYPE(loc_oControle) != "O"
1439:                 LOOP
1440:             ENDIF
1441: 
1442:             IF PEMSTATUS(loc_oControle, "Visible", 5)
1443:                 loc_oControle.Visible = .T.
1444:             ENDIF
1445: 
1446:             IF UPPER(loc_oControle.BaseClass) = "PAGEFRAME"
1447:                 LOCAL loc_nP
1448:                 FOR loc_nP = 1 TO loc_oControle.PageCount
1449:                     THIS.TornarControlesVisiveis(loc_oControle.Pages(loc_nP))
1450:                 ENDFOR
1451:             ENDIF
1452: 
1453:             IF PEMSTATUS(loc_oControle, "ControlCount", 5)
1454:                 THIS.TornarControlesVisiveis(loc_oControle)
1455:             ENDIF
1456:         ENDFOR
1457:     ENDPROC
1458: 
1459:     *==========================================================================
1460:     * Destroy - Libera o BO e os cursores abertos pelo form
1461:     *==========================================================================
1462:     PROCEDURE Destroy()
1463:     *==========================================================================
1464:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1465:             THIS.this_oBusinessObject = .NULL.
1466:         ENDIF
1467: 
1468:         IF USED("cursor_4c_Dados")
1469:             USE IN cursor_4c_Dados
1470:         ENDIF
1471:         IF USED("cursor_4c_DadosTmp")
1472:             USE IN cursor_4c_DadosTmp
1473:         ENDIF
1474:         IF USED("cursor_4c_MalasSel")
1475:             USE IN cursor_4c_MalasSel
1476:         ENDIF
1477:         IF USED("cursor_4c_MlCabTmp")
1478:             USE IN cursor_4c_MlCabTmp
1479:         ENDIF
1480:         IF USED("cursor_4c_Unificada")
1481:             USE IN cursor_4c_Unificada
1482:         ENDIF
1483: 
1484:         DODEFAULT()
1485:     ENDPROC
1486: 
1487: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrMluBO.prg):
*============================================================================
* SigPrMluBO.prg - Business Object para Unificacao de Mala Direta (SIGPRMLU)
*
* Form OPERACIONAL (SIGPRMLU / FormSigPrMlu): lista as malas diretas
* cadastradas (SigMlItn, grid com checkbox de selecao), permite ao usuario
* marcar duas ou mais e "Processar" a unificacao delas numa mala NOVA:
*   - gera um codigo novo (equivalente a Substr(Sys(2015),3,10) do legado)
*   - duplica, deduplicando por chave logica (Desti+Ceps+Endes+Nums+Compls),
*     os registros de SigMlCab (Where Codigos = <malaSelecionada>) na mala
*     nova
*   - insere o cabecalho da mala nova em SigMlItn (Codigos/Descs/Ativos/
*     UsuIns/DatIns/NRegis/Espelhos/Unificas)
*
* this_cTabela/this_cCampoChave apontam para SigMlItn (cabecalho da mala,
* entidade listada na grade principal do form - equivalente ao
* AddCursor('SigMlItn', 'Codigos', 'crSigMlItn', ...) do Init legado).
* SigMlCab (registros/clientes dentro de cada mala, PK cidchaves) e
* manipulada em bloco durante o Processamento (Fase 2+), sem mapeamento
* propriedade-a-propriedade, pois o legado faz Select * / Scatter Memvar /
* Gather Memvar (copia integral do registro, nao campo a campo).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrMluBO AS BusinessBase

    *==========================================================================
    * Propriedades de registro - espelham as colunas de SigMlItn (docs/
    * schema.sql) efetivamente usadas pelo SIGPRMLU.scx (cabecalho da mala
    * direta exibido na grade e gravado ao final da unificacao). As demais
    * colunas de SigMlItn (filtros de geracao da mala: anivfs/cepfs/faixafs/
    * opsexs/etc.) pertencem ao cadastro de Mala Direta (outro form) e NAO
    * sao tocadas por SIGPRMLU - nao sao declaradas aqui.
    *==========================================================================
    this_cCodigos    = SPACE(10)  && SigMlItn.codigos  - char(10) NOT NULL (PK) - grdselecoes.Column2
    this_cDescs      = SPACE(30)  && SigMlItn.descs    - char(30) NOT NULL - grdselecoes.Column3 / nome da unificacao
    this_lAtivos     = .F.        && SigMlItn.ativos   - bit NOT NULL - sempre .T. na mala resultante da unificacao
    this_cUsuIns     = SPACE(10)  && SigMlItn.usuins   - char(10) NOT NULL - grdselecoes.Column4 (Usuar do legado)
    this_dDatIns     = {}         && SigMlItn.datins   - datetime NULL - grdselecoes.Column5 (DateTime() na gravacao)
    this_dDatAlts    = {}         && SigMlItn.datalts  - datetime NULL - nao gravado por este form (.NULL. no Insert legado)
    this_dUlts       = {}         && SigMlItn.ults     - datetime NULL - nao gravado por este form (.NULL. no Insert legado)
    this_dDtEnts     = {}         && SigMlItn.dtents   - datetime NULL - nao gravado por este form (.NULL. no Insert legado)
    this_nNRegis     = 0          && SigMlItn.nregis   - numeric(8,0) NOT NULL - grdselecoes.Column6 (Reccount da mala unificada)
    this_cEspelhos   = SPACE(8)   && SigMlItn.espelhos - char(8) NOT NULL - origem fixa 'SigPrMlu' (Insert legado)
    this_cUnificas   = ""         && SigMlItn.unificas - text NULL - lista "codigo1; codigo2; " das malas de origem

    *==========================================================================
    * Estado de processamento - nao sao colunas persistidas isoladamente;
    * controlam a unificacao (Processamento() legado) e espelham o estado da
    * tela (txt_4c_Nova/getNova e os resultados intermediarios do calculo)
    *==========================================================================
    this_cNomeUnificacao        = SPACE(20)  && cntNova.getNova.Value - MaxLength=20 no SCX legado
    this_cCodigoGerado          = SPACE(10)  && lcNew  - Substr(Sys(2015),3,10), codigo da mala resultante
    this_nTotalRegistrosOrigem  = 0          && lnTot  - soma de Reccount('crTmp') de cada mala selecionada
    this_cCodigosSelecionados   = ""         && lcUni  - "codigo1; codigo2; " das malas marcadas (SelImp = 1)
    this_nTotalMalasSelecionadas = 0         && Reccount('csMalasSelecionadas') - quantidade de malas marcadas

    *==========================================================================
    * Init - Inicializa o Business Object configurando a tabela/chave
    * primaria de referencia (SigMlItn/codigos - equivalente ao AddCursor(
    * 'SigMlItn', 'Codigos', 'crSigMlItn', ...) do Init legado, que define
    * qual entidade a grade principal do form lista e processa)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMlItn"
            THIS.this_cCampoChave = "codigos"

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas do cursor (crSigMlItn, populado via
    * SQLEXEC/AddCursor equivalente) para as propriedades this_* deste BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigos  = TratarNulo(codigos, "")
            THIS.this_cDescs    = TratarNulo(descs, "")
            IF VARTYPE(ativos) = "L"
                THIS.this_lAtivos = TratarNulo(ativos, .F.)
            ELSE
                THIS.this_lAtivos = (TratarNulo(ativos, 0) = 1)
            ENDIF
            THIS.this_cUsuIns   = TratarNulo(usuins, "")
            THIS.this_dDatIns   = TratarNulo(datins, {})
            THIS.this_dDatAlts  = TratarNulo(datalts, {})
            THIS.this_dUlts     = TratarNulo(ults, {})
            THIS.this_dDtEnts   = TratarNulo(dtents, {})
            THIS.this_nNRegis   = TratarNulo(nregis, 0)
            THIS.this_cEspelhos = TratarNulo(espelhos, "")
            THIS.this_cUnificas = TratarNulo(unificas, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT do cabecalho da mala direta unificada em SigMlItn
    * (equivalente ao "Insert Into crSigMlItn (Codigos, Descs, Ativos, UsuIns,
    * DatIns, DatAlts, Ults, DtEnts, NRegis, Espelhos, Unificas) Values (...)"
    * do Processamento legado).
    *
    * SigMlItn tem dezenas de colunas NOT NULL sem DEFAULT que pertencem aos
    * FILTROS de geracao de mala direta (cadastro de Mala Direta - outro form)
    * e NUNCA sao tocadas pelo SIGPRMLU. O legado grava o registro INTEIRO
    * (AddCursor sem query = Select * + Gather Memvar/TableUpdate), entao essas
    * colunas vao em branco/zero junto das que a tela de fato edita. A lista
    * abaixo vem do docs/schema.sql (regra #22 do CLAUDE.md - a lista de
    * colunas NOT NULL vem do SCHEMA, nunca do dump do legado).
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro, loc_cIdChaves
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                THIS.this_cCodigoGerado = PADR(SUBSTR(SYS(2015), 3, 10), 10)
                THIS.this_cCodigos      = THIS.this_cCodigoGerado
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cUsuIns))
                THIS.this_cUsuIns = gc_4c_UsuarioLogado
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cEspelhos))
                THIS.this_cEspelhos = "SigPrMlu"
            ENDIF

            * Legado grava Ativos = .t. incondicionalmente na mala resultante
            THIS.this_lAtivos = .T.

            loc_cIdChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigMlItn (" + ;
                "anivfs, anivis, ativos, cadas, cemps, cepfs, cepis, cidades, " + ;
                "ckanis, ckcads, ckceps, ckcids, ckemps, ckests, ckfnoms, cknomes, " + ;
                "ckprofs, ckrsocs, cksexs, ckults, codigos, datins, demps, descs, " + ;
                "destis, espelhos, ests, faixafs, faixais, nomes, nregis, opsexs, " + ;
                "optceps, optnrs, optults, profs, rsocs, usualts, usuins, ckclass, " + ;
                "cksituas, classifis, classifss, situas, ckregis, cksitua, opsitua, regifs, " + ;
                "regiis, situa, linhas, ckcivils, opanis, ckdtents, cklinhas, tabufs, " + ;
                "opcivis, bairs, ckbairs, estados, unificas, ckvends, vends, cidchaves, " + ;
                "ckidade, idadefs, idadeis, opidade, cparents, ckdtatus, opendes, cktlmk, " + ;
                "optlmk, ckncomp, ckultcom, ckpais, paises, ckmov, dopes, endigual, " + ;
                "valosf, valosi, ckconjuge, conjuge, ckpubls, cksegs, fpubls, codsegs" + ;
                ") VALUES (" + ;
                EscaparSQL("") + ", " + EscaparSQL("") + ", " + IIF(THIS.this_lAtivos, "1", "0") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                "0, 0, 0, 0, 0, 0, 0, 0, " + ;
                "0, 0, 0, 0, " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cCodigos), 10)) + ", " + ;
                    FormatarDataSQL(IIF(EMPTY(THIS.this_dDatIns), DATETIME(), THIS.this_dDatIns)) + ", " + ;
                    EscaparSQL("") + ", " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cDescs), 30)) + ", " + ;
                "0, " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEspelhos), 8)) + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", 0, " + ;
                "0, 0, 0, " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL(PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuIns), 10)) + ", 0, " + ;
                "0, " + EscaparSQL("") + ", " + EscaparSQL("") + ", 0, 0, 0, 0, " + EscaparSQL("") + ", " + ;
                EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", 0, 0, 0, 0, " + EscaparSQL("") + ", " + ;
                "0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ", " + ;
                    EscaparSQL(NVL(THIS.this_cUnificas, "")) + ", 0, " + EscaparSQL("") + ", " + ;
                    EscaparSQL(LEFT(loc_cIdChaves, 20)) + ", " + ;
                "0, 0, 0, 0, " + EscaparSQL("") + ", 0, 0, 0, " + ;
                "0, 0, 0, 0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ", 0, " + ;
                FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", 0, " + EscaparSQL("") + ", 0, 0, " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir mala direta unificada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir mala direta unificada:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE do cabecalho da mala direta em SigMlItn (apenas as
    * colunas que este form mantem - as demais colunas NOT NULL de SigMlItn
    * pertencem ao cadastro de Mala Direta e nao sao alteradas aqui)
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o definido para atualiza" + ;
                    CHR(231) + CHR(227) + "o", "SigPrMluBO.Atualizar")
            ELSE
                loc_cSQL = "UPDATE SigMlItn SET " + ;
                    "descs = "    + EscaparSQL(PADR(ALLTRIM(THIS.this_cDescs), 30)) + ", " + ;
                    "ativos = "   + IIF(THIS.this_lAtivos, "1", "0") + ", " + ;
                    "nregis = "   + FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", " + ;
                    "unificas = " + EscaparSQL(NVL(THIS.this_cUnificas, "")) + ", " + ;
                    "usualts = "  + EscaparSQL(PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                    "datalts = GETDATE() " + ;
                    "WHERE codigos = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodigos), 10))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar mala direta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar mala direta:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Zera as properties deste BO. Sobrescreve o stub da
    * BusinessBase (que limpa apenas this_cMensagemErro) porque este form NAO
    * eh modal-por-registro como o legado: ele fica aberto e o usuario pode
    * fazer uma unificacao depois da outra. Sem o reset, o estado da anterior
    * (nome, codigo gerado, totais e a lista de malas de origem) sobrevive na
    * instancia e qualquer caminho que deixe de reatribuir uma dessas
    * properties gravaria o valor da unificacao PASSADA - o mesmo risco de
    * ciclo de vida da regra #32 do CLAUDE.md.
    *
    * PUBLIC (sem modificador) obrigatoriamente: LimparDados eh PUBLIC na
    * BusinessBase, o Form a chama de fora em LimparCampos, e VFP9 nao permite
    * REDUZIR o escopo sem quebrar o chamador (regra #51).
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        *-- Colunas de SigMlItn mantidas por este form
        THIS.this_cCodigos  = SPACE(10)
        THIS.this_cDescs    = SPACE(30)
        THIS.this_lAtivos   = .F.
        THIS.this_cUsuIns   = SPACE(10)
        THIS.this_dDatIns   = {}
        THIS.this_dDatAlts  = {}
        THIS.this_dUlts     = {}
        THIS.this_dDtEnts   = {}
        THIS.this_nNRegis   = 0
        THIS.this_cEspelhos = SPACE(8)
        THIS.this_cUnificas = ""

        *-- Estado de processamento (espelho da tela e resultados do calculo)
        THIS.this_cNomeUnificacao          = SPACE(20)
        THIS.this_cCodigoGerado            = SPACE(10)
        THIS.this_nTotalRegistrosOrigem    = 0
        THIS.this_cCodigosSelecionados     = ""
        THIS.this_nTotalMalasSelecionadas  = 0

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna o codigo (char(10), PK de SigMlItn) do
    * registro atual
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDPROC

ENDDEFINE

