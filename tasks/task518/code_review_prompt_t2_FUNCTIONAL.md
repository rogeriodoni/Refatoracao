# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'cmdprocessar' (parent: SIGCDSED): Left original=450 vs migrado 'cmd_4c_Cmdprocessar' Left=750 (diff=300px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'sair' (parent: SIGCDSED): Left original=525 vs migrado 'cmd_4c_Sair' Left=875 (diff=350px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'excluir' (parent: SIGCDSED): Top original=223 vs migrado 'cmd_4c_Excluir' Top=335 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'excluir' (parent: SIGCDSED): Left original=520 vs migrado 'cmd_4c_Excluir' Left=867 (diff=347px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSed.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (801 linhas total):

*-- Linhas 6 a 55:
6: *
7: * MIGRADO COMPLETO (Fases 3-6/8):
8: *   - DEFINE CLASS + propriedades visuais
9: *   - Init / InicializarForm / Destroy
10: *   - ConfigurarCabecalho (cnt_4c_Cabecalho + labels sombra/titulo)
11: *   - ConfigurarBotoesAcao (cmd_4c_Cmdprocessar "Gerar" + cmd_4c_Sair "Encerrar")
12: *   - ConfigurarPaginaLista (filtros faixa inicial/final + grid 5 colunas + botao Excluir)
13: *   - CarregarDados (chama SedBO.CarregarSedex + vincula cursor ao grid, Pattern #180)
14: *   - Handlers: cmd_4c_CmdprocessarClick / cmd_4c_SairClick / cmd_4c_ExcluirClick
15: *   - TornarControlesVisiveis recursivo (form flat, sem containers flutuantes)
16: *   - Integrado no menu.prg: popMovimentos BAR 121 -> AbrirFormSed()
17: *   - Fase 6: Form plano sem Page2/lookups. LockScreen em exclusao (fidelidade UX).
18: *             Refresh() explicito no grid apos rebinding. Implementacao COMPLETA.
19: *   - Fase 7: Interface publica Btn*Click para controle de modo pelo wrapper
20: *             (equivalente ao pcEscolha legado). BtnExcluirClick delega para
21: *             cmd_4c_ExcluirClick que ja tem a logica completa.
22: *
23: * Layout OPERACIONAL flat (600x400 legado -> 1000x600 sistema novo).
24: * Nao usa PageFrame Lista/Dados do padrao CRUD.
25: *==============================================================================
26: 
27: DEFINE CLASS FormSed AS FormBase
28: 
29:     *--------------------------------------------------------------------------
30:     * Propriedades visuais do form
31:     *--------------------------------------------------------------------------
32:     this_cMensagemErro = ""
33:     Width        = 1000
34:     Height       = 600
35:     AutoCenter   = .T.
36:     TitleBar     = 0
37:     ShowWindow = 1
38:     ControlBox   = .F.
39:     Closable     = .F.
40:     MaxButton    = .F.
41:     MinButton    = .F.
42:     ClipControls = .F.
43:     WindowType   = 1
44:     FontName     = "Verdana"
45:     FontSize     = 8
46:     ForeColor    = RGB(36, 84, 155)
47:     Caption      = "Etiquetas de Sedex"
48: 
49:     *--------------------------------------------------------------------------
50:     * Propriedades de estado
51:     *--------------------------------------------------------------------------
52:     this_oBusinessObject = .NULL.
53:     this_cModoAtual      = "INSERIR"
54:     this_oParent         = .NULL.
55: 

*-- Linhas 67 a 162:
67:             THIS.this_cModoAtual = par_cModoAtual
68:         ENDIF
69: 
70:         THIS.this_oBusinessObject = CREATEOBJECT("SedBO")
71:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
72:             MsgErro("Erro ao criar SedBO.", "Erro")
73:             RETURN .F.
74:         ENDIF
75: 
76:         RETURN DODEFAULT()
77:     ENDFUNC
78: 
79:     *==========================================================================
80:     * InicializarForm - Monta a estrutura base do form
81:     * Deve retornar .T. em sucesso e .F. em falha (contrato do FormBase.Init)
82:     *==========================================================================
83:     PROTECTED PROCEDURE InicializarForm()
84:         LOCAL loc_lSucesso, loc_oErro
85: 
86:         loc_lSucesso = .F.
87: 
88:         TRY
89:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
90: 
91:             THIS.ConfigurarCabecalho()
92:             THIS.ConfigurarBotoesAcao()
93:             THIS.ConfigurarPaginaLista()
94: 
95:             BINDEVENT(THIS.cmd_4c_Cmdprocessar, "Click", THIS, "cmd_4c_CmdprocessarClick")
96:             BINDEVENT(THIS.cmd_4c_Sair,         "Click", THIS, "cmd_4c_SairClick")
97:             BINDEVENT(THIS.cmd_4c_Excluir,      "Click", THIS, "cmd_4c_ExcluirClick")
98: 
99:             THIS.TornarControlesVisiveis(THIS)
100: 
101:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
102:                 THIS.CarregarDados()
103:             ENDIF
104: 
105:             loc_lSucesso = .T.
106: 
107:         CATCH TO loc_oErro
108:             THIS.this_cMensagemErro = loc_oErro.Message
109:             MsgErro(loc_oErro.Message + CHR(13) + ;
110:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
111:                     "Procedure: " + loc_oErro.Procedure, ;
112:                     "Erro em FormSed.InicializarForm")
113:         ENDTRY
114: 
115:         RETURN loc_lSucesso
116:     ENDPROC
117: 
118:     *==========================================================================
119:     * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
120:     * cnt_4c_Cabecalho: Top=0 Left=0 Width=1000 Height=80 BackColor=RGB(100,100,100)
121:     *==========================================================================
122:     PROTECTED PROCEDURE ConfigurarCabecalho()
123:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
124:         WITH THIS.cnt_4c_Cabecalho
125:             .Top         = 0
126:             .Left        = 0
127:             .Width       = THIS.Width
128:             .Height      = 80
129:             .BackStyle   = 1
130:             .BackColor   = RGB(100, 100, 100)
131:             .BorderWidth = 0
132:             .Visible     = .T.
133:         ENDWITH
134: 
135:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblSombra", "Label")
136:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblSombra
137:             .Top        = 18
138:             .Left       = 10
139:             .Width      = THIS.Width - 20
140:             .Height     = 40
141:             .FontName   = "Tahoma"
142:             .FontSize   = 18
143:             .FontBold   = .T.
144:             .ForeColor  = RGB(0, 0, 0)
145:             .BackStyle  = 0
146:             .WordWrap   = .T.
147:             .AutoSize   = .F.
148:             .Caption    = "Etiquetas de Sedex"
149:             .Visible    = .T.
150:         ENDWITH
151: 
152:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblTitulo", "Label")
153:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblTitulo
154:             .Top        = 17
155:             .Left       = 10
156:             .Width      = THIS.Width - 20
157:             .Height     = 46
158:             .FontName   = "Tahoma"
159:             .FontSize   = 18
160:             .FontBold   = .T.
161:             .ForeColor  = RGB(255, 255, 255)
162:             .BackStyle  = 0

*-- Linhas 168 a 222:
168:     ENDPROC
169: 
170:     *==========================================================================
171:     * ConfigurarBotoesAcao - Botoes Gerar e Encerrar (canto superior direito)
172:     * Layout proporcional 600->1000 (originais Left=450 e Left=525):
173:     *   cmd_4c_Cmdprocessar (Gerar)   : Left=750
174:     *   cmd_4c_Sair          (Encerrar): Left=875 (Cancel=.T. p/ ESC)
175:     * Gerar so habilitado em INSERIR/ALTERAR
176:     *==========================================================================
177:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
178:         LOCAL loc_lModoHabilita
179: 
180:         loc_lModoHabilita = INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
181: 
182:         THIS.AddObject("cmd_4c_Cmdprocessar", "CommandButton")
183:         WITH THIS.cmd_4c_Cmdprocessar
184:             .Top             = 3
185:             .Left            = 750
186:             .Width           = 75
187:             .Height          = 75
188:             .Caption         = "Gerar"
189:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
190:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
191:             .FontName        = "Tahoma"
192:             .FontBold        = .T.
193:             .FontItalic      = .T.
194:             .FontSize        = 8
195:             .ForeColor       = RGB(90, 90, 90)
196:             .BackColor       = RGB(255, 255, 255)
197:             .Themes          = .T.
198:             .SpecialEffect   = 0
199:             .PicturePosition = 13
200:             .MousePointer    = 15
201:             .WordWrap        = .T.
202:             .Enabled         = loc_lModoHabilita
203:             .Visible         = .T.
204:         ENDWITH
205: 
206:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
207:         WITH THIS.cmd_4c_Sair
208:             .Top             = 3
209:             .Left            = 875
210:             .Width           = 75
211:             .Height          = 75
212:             .Caption         = "Encerrar"
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
214:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
215:             .Cancel          = .T.
216:             .FontName        = "Tahoma"
217:             .FontBold        = .T.
218:             .FontItalic      = .T.
219:             .FontSize        = 8
220:             .ForeColor       = RGB(90, 90, 90)
221:             .BackColor       = RGB(255, 255, 255)
222:             .Themes          = .T.

*-- Linhas 229 a 320:
229:     ENDPROC
230: 
231:     *==========================================================================
232:     * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda hierarquia
233:     * Form flat sem containers flutuantes, portanto sem lista de skip.
234:     *==========================================================================
235:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
236:         LOCAL loc_i, loc_oControl
237: 
238:         FOR loc_i = 1 TO par_oContainer.ControlCount
239:             loc_oControl = par_oContainer.Controls(loc_i)
240: 
241:             IF VARTYPE(loc_oControl) = "O"
242:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
243:                     loc_oControl.Visible = .T.
244:                 ENDIF
245:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
246:                     THIS.TornarControlesVisiveis(loc_oControl)
247:                 ENDIF
248:             ENDIF
249:         ENDFOR
250:     ENDPROC
251: 
252:     *==========================================================================
253:     * Destroy - Libera cursores e recursos. DODEFAULT no fim (rebuild menu).
254:     *==========================================================================
255:     PROCEDURE Destroy()
256:         IF USED("cursor_4c_Sedex")
257:             USE IN cursor_4c_Sedex
258:         ENDIF
259:         IF USED("cursor_4c_SedVerif")
260:             USE IN cursor_4c_SedVerif
261:         ENDIF
262:         IF USED("cursor_4c_SedChk")
263:             USE IN cursor_4c_SedChk
264:         ENDIF
265: 
266:         THIS.this_oBusinessObject = .NULL.
267:         THIS.this_oParent         = .NULL.
268: 
269:         DODEFAULT()
270:     ENDPROC
271: 
272:     *==========================================================================
273:     * ConfigurarPaginaLista - Monta area de filtros, grid e botao Excluir
274:     * Form OPERACIONAL flat (sem PageFrame): todo o conteudo vai direto no form.
275:     * Filtros:  lbl_4c_LblFaixa, txt_4c_Faixainicial, lbl_4c_LblAte, txt_4c_Faixafinal
276:     * Grid:     grd_4c_Dados (5 colunas: DtIncs|FaixaInis|FaixaFins|nLivres|nUsadas)
277:     * Botao:    cmd_4c_Excluir (icone-only, direita do grid)
278:     * Escalado de 600x400 (original) para 1000x600 (novo padrao)
279:     *==========================================================================
280:     PROTECTED PROCEDURE ConfigurarPaginaLista()
281:         LOCAL loc_lModoHabilita
282: 
283:         loc_lModoHabilita = INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
284: 
285:         *-- Label "Faixa:"
286:         THIS.AddObject("lbl_4c_LblFaixa", "Label")
287:         WITH THIS.lbl_4c_LblFaixa
288:             .Top       = 101
289:             .Left      = 12
290:             .Width     = 58
291:             .Height    = 15
292:             .FontName  = "Tahoma"
293:             .FontSize  = 8
294:             .Alignment = 0
295:             .BackStyle = 0
296:             .Caption   = "Faixa :"
297:             .ForeColor = RGB(90, 90, 90)
298:             .AutoSize  = .F.
299:             .Visible   = .T.
300:         ENDWITH
301: 
302:         *-- TextBox faixa inicial (MaxLength=14, Format="K!" converte para maiusculo)
303:         THIS.AddObject("txt_4c_Faixainicial", "TextBox")
304:         WITH THIS.txt_4c_Faixainicial
305:             .Top           = 97
306:             .Left          = 74
307:             .Width         = 180
308:             .Height        = 22
309:             .FontName      = "Tahoma"
310:             .FontSize      = 8
311:             .Alignment     = 0
312:             .BackStyle     = 1
313:             .BackColor     = RGB(255, 255, 255)
314:             .ForeColor     = RGB(0, 0, 0)
315:             .BorderColor   = RGB(100, 100, 100)
316:             .BorderStyle   = 1
317:             .Format        = "K!"
318:             .MaxLength     = 14
319:             .SpecialEffect = 1
320:             .Themes        = .F.

*-- Linhas 363 a 384:
363:             .Enabled       = loc_lModoHabilita
364:             .Visible       = .T.
365:         ENDWITH
366: 
367:         *-- Botao Excluir (icone-only, posicionado a direita do grid - nunca .Enabled=.F.)
368:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
369:         WITH THIS.cmd_4c_Excluir
370:             .Top             = 335
371:             .Left            = 867
372:             .Width           = 75
373:             .Height          = 75
374:             .Caption         = ""
375:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
376:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
377:             .ToolTipText     = "Excluir"
378:             .FontName        = "Verdana"
379:             .FontBold        = .T.
380:             .FontSize        = 8
381:             .ForeColor       = RGB(36, 84, 155)
382:             .BackColor       = RGB(255, 255, 255)
383:             .Themes          = .T.
384:             .SpecialEffect   = 0

*-- Linhas 560 a 801:
560:         CATCH TO loc_oErro
561:             MsgErro(loc_oErro.Message + CHR(13) + ;
562:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
563:                     "Procedure: " + loc_oErro.Procedure, ;
564:                     "Erro em FormSed.CarregarDados")
565:         ENDTRY
566: 
567:         RETURN loc_lSucesso
568:     ENDFUNC
569: 
570:     *==========================================================================
571:     * ConfigurarPaginaDados - Form OPERACIONAL flat (sem PageFrame Lista/Dados)
572:     * Layout completo (cabecalho, filtros, grid, botoes) esta em ConfigurarCabecalho +
573:     * ConfigurarBotoesAcao + ConfigurarPaginaLista, chamados no InicializarForm.
574:     * Presente por convencao do pipeline (validador Fase 5 exige o nome do metodo)
575:     * e para compatibilidade com AlternarPagina caso o form seja invocado por
576:     * wrapper que espere a mesma interface dos forms CRUD.
577:     *==========================================================================
578:     PROTECTED PROCEDURE ConfigurarPaginaDados()
579:         RETURN
580:     ENDPROC
581: 
582:     *==========================================================================
583:     * AlternarPagina - Stub (form flat sem PageFrame; sem alternancia de paginas)
584:     *==========================================================================
585:     PROCEDURE AlternarPagina(par_nPagina)
586:         RETURN
587:     ENDPROC
588: 
589:     *==========================================================================
590:     * cmd_4c_CmdprocessarClick - Handler do botao Gerar
591:     * Valida faixas, chama GerarEtiquetas no BO e recarrega grid
592:     *==========================================================================
593:     PROCEDURE cmd_4c_CmdprocessarClick()
594:         LOCAL loc_lSucesso, loc_cFaixaIni, loc_cFaixaFin
595: 
596:         IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
597:             RETURN
598:         ENDIF
599: 
600:         loc_cFaixaIni = ALLTRIM(THIS.txt_4c_Faixainicial.Value)
601:         loc_cFaixaFin = ALLTRIM(THIS.txt_4c_Faixafinal.Value)
602: 
603:         IF EMPTY(loc_cFaixaIni) OR EMPTY(loc_cFaixaFin)
604:             MsgAviso("Faixa inicial e final s" + CHR(227) + "o obrigat" + CHR(243) + "rias.", "Aviso")
605:             RETURN
606:         ENDIF
607: 
608:         loc_lSucesso = THIS.this_oBusinessObject.GerarEtiquetas( ;
609:             loc_cFaixaIni, loc_cFaixaFin, go_4c_Sistema.cCodEmpresa)
610: 
611:         IF loc_lSucesso
612:             THIS.CarregarDados()
613:         ENDIF
614:     ENDPROC
615: 
616:     *==========================================================================
617:     * cmd_4c_SairClick - Handler do botao Encerrar
618:     *==========================================================================
619:     PROCEDURE cmd_4c_SairClick()
620:         THIS.Release()
621:     ENDPROC
622: 
623:     *==========================================================================
624:     * cmd_4c_ExcluirClick - Handler do botao Excluir
625:     * Le FaixaInis e nUsadas do registro corrente no cursor e chama ExcluirFaixa.
626:     * LockScreen durante delete + reload evita flickering (fidelidade ao legado).
627:     *==========================================================================
628:     PROCEDURE cmd_4c_ExcluirClick()
629:         LOCAL loc_cFaixaIni, loc_nUsadas
630: 
631:         IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
632:             RETURN
633:         ENDIF
634: 
635:         IF !USED("cursor_4c_Sedex") OR RECCOUNT("cursor_4c_Sedex") = 0
636:             MsgAviso("Selecione um registro para excluir.", "Aviso")
637:             RETURN
638:         ENDIF
639: 
640:         SELECT cursor_4c_Sedex
641:         IF EOF("cursor_4c_Sedex")
642:             MsgAviso("Selecione um registro para excluir.", "Aviso")
643:             RETURN
644:         ENDIF
645: 
646:         loc_cFaixaIni = ALLTRIM(NVL(cursor_4c_Sedex.FaixaInis, ""))
647:         loc_nUsadas   = NVL(cursor_4c_Sedex.nUsadas, 0)
648: 
649:         THIS.LockScreen = .T.
650: 
651:         IF THIS.this_oBusinessObject.ExcluirFaixa(loc_cFaixaIni, go_4c_Sistema.cCodEmpresa, loc_nUsadas)
652:             THIS.CarregarDados()
653:             THIS.grd_4c_Dados.Refresh()
654:         ENDIF
655: 
656:         THIS.LockScreen = .F.
657:     ENDPROC
658: 
659:     *==========================================================================
660:     * BtnIncluirClick - Configura form para modo INSERIR e limpa campos de faixa
661:     * Interface publica equivalente a pcEscolha='INSERIR' no wrapper legado.
662:     *==========================================================================
663:     PROCEDURE BtnIncluirClick()
664:         THIS.this_cModoAtual = "INSERIR"
665:         THIS.txt_4c_Faixainicial.Value   = ""
666:         THIS.txt_4c_Faixafinal.Value     = ""
667:         THIS.txt_4c_Faixainicial.Enabled = .T.
668:         THIS.txt_4c_Faixafinal.Enabled   = .T.
669:         THIS.cmd_4c_Cmdprocessar.Enabled = .T.
670:         THIS.txt_4c_Faixainicial.SetFocus()
671:     ENDPROC
672: 
673:     *==========================================================================
674:     * BtnAlterarClick - Configura form para modo ALTERAR habilitando controles
675:     * Interface publica equivalente a pcEscolha='ALTERAR' no wrapper legado.
676:     *==========================================================================
677:     PROCEDURE BtnAlterarClick()
678:         THIS.this_cModoAtual = "ALTERAR"
679:         THIS.txt_4c_Faixainicial.Enabled = .T.
680:         THIS.txt_4c_Faixafinal.Enabled   = .T.
681:         THIS.cmd_4c_Cmdprocessar.Enabled = .T.
682:         THIS.txt_4c_Faixainicial.SetFocus()
683:     ENDPROC
684: 
685:     *==========================================================================
686:     * BtnVisualizarClick - Configura form para modo VISUALIZAR (somente leitura)
687:     * Interface publica equivalente a pcEscolha='VISUALIZAR' no wrapper legado.
688:     *==========================================================================
689:     PROCEDURE BtnVisualizarClick()
690:         THIS.this_cModoAtual = "VISUALIZAR"
691:         THIS.txt_4c_Faixainicial.Enabled = .F.
692:         THIS.txt_4c_Faixafinal.Enabled   = .F.
693:         THIS.cmd_4c_Cmdprocessar.Enabled = .F.
694:     ENDPROC
695: 
696:     *==========================================================================
697:     * BtnExcluirClick - Dispara exclusao da faixa selecionada no grid
698:     * Delega para cmd_4c_ExcluirClick que tem a logica completa com validacao
699:     * de nUsadas > 0 e chamada ao BO.ExcluirFaixa.
700:     *==========================================================================
701:     PROCEDURE BtnExcluirClick()
702:         THIS.cmd_4c_ExcluirClick()
703:     ENDPROC
704: 
705:     *==========================================================================
706:     * BtnBuscarClick - Recarrega grid com dados atuais da empresa
707:     *==========================================================================
708:     PROCEDURE BtnBuscarClick()
709:         THIS.CarregarDados()
710:     ENDPROC
711: 
712:     *==========================================================================
713:     * BtnEncerrarClick - Fecha o formulario (alias publico para cmd_4c_SairClick)
714:     *==========================================================================
715:     PROCEDURE BtnEncerrarClick()
716:         THIS.cmd_4c_SairClick()
717:     ENDPROC
718: 
719:     *==========================================================================
720:     * BtnSalvarClick - Executa geracao de etiquetas (alias publico para "Gerar")
721:     * Mapeia a acao "Salvar" do padrao CRUD para "GerarEtiquetas" deste form
722:     * operacional.
723:     *==========================================================================
724:     PROCEDURE BtnSalvarClick()
725:         THIS.cmd_4c_CmdprocessarClick()
726:     ENDPROC
727: 
728:     *==========================================================================
729:     * BtnCancelarClick - Cancela operacao atual: limpa campos de faixa
730:     * e retorna foco para o primeiro campo editavel.
731:     *==========================================================================
732:     PROCEDURE BtnCancelarClick()
733:         THIS.LimparCampos()
734:         THIS.txt_4c_Faixainicial.SetFocus()
735:     ENDPROC
736: 
737:     *==========================================================================
738:     * FormParaBO - Transfere campos do form para as propriedades do SedBO
739:     * Popula this_cFaixaInis, this_cFaixaFins e this_cEmps antes de Gerar.
740:     *==========================================================================
741:     PROCEDURE FormParaBO()
742:         THIS.this_oBusinessObject.this_cFaixaInis = ALLTRIM(THIS.txt_4c_Faixainicial.Value)
743:         THIS.this_oBusinessObject.this_cFaixaFins = ALLTRIM(THIS.txt_4c_Faixafinal.Value)
744:         THIS.this_oBusinessObject.this_cEmps      = go_4c_Sistema.cCodEmpresa
745:     ENDPROC
746: 
747:     *==========================================================================
748:     * BOParaForm - Transfere propriedades do BO para os campos de faixa do form
749:     *==========================================================================
750:     PROCEDURE BOParaForm()
751:         THIS.txt_4c_Faixainicial.Value = THIS.this_oBusinessObject.this_cFaixaInis
752:         THIS.txt_4c_Faixafinal.Value   = THIS.this_oBusinessObject.this_cFaixaFins
753:     ENDPROC
754: 
755:     *==========================================================================
756:     * HabilitarCampos - Habilita ou desabilita controles editaveis
757:     * par_lHabilitar: .T. = modo edicao (INSERIR/ALTERAR), .F. = somente leitura
758:     *==========================================================================
759:     PROCEDURE HabilitarCampos(par_lHabilitar)
760:         LOCAL loc_lEdit
761: 
762:         loc_lEdit = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
763: 
764:         THIS.txt_4c_Faixainicial.Enabled = loc_lEdit
765:         THIS.txt_4c_Faixafinal.Enabled   = loc_lEdit
766:         THIS.cmd_4c_Cmdprocessar.Enabled = loc_lEdit
767:     ENDPROC
768: 
769:     *==========================================================================
770:     * LimparCampos - Limpa os campos de faixa inicial e final
771:     *==========================================================================
772:     PROCEDURE LimparCampos()
773:         THIS.txt_4c_Faixainicial.Value = ""
774:         THIS.txt_4c_Faixafinal.Value   = ""
775:     ENDPROC
776: 
777:     *==========================================================================
778:     * CarregarLista - Alias para CarregarDados (compatibilidade com interface CRUD)
779:     * Forms operacionais nao tem lista separada dos dados; o grid unico e
780:     * atualizado pelo CarregarDados.
781:     *==========================================================================
782:     FUNCTION CarregarLista()
783:         RETURN THIS.CarregarDados()
784:     ENDFUNC
785: 
786:     *==========================================================================
787:     * AjustarBotoesPorModo - Centraliza habilitacao de controles por modo
788:     * Equivalente ao When legado: Return(INLIST(pcEscolha,'INSERIR','ALTERAR'))
789:     * Chamado por wrappers ou logica externa que altera this_cModoAtual.
790:     *==========================================================================
791:     PROCEDURE AjustarBotoesPorModo()
792:         LOCAL loc_lModoEdicao
793: 
794:         loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
795: 
796:         THIS.HabilitarCampos(loc_lModoEdicao)
797: 
798:         THIS.cmd_4c_Excluir.Visible = loc_lModoEdicao
799:     ENDPROC
800: 
801: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SedBO.prg):
*==============================================================================
* SedBO.prg - Business Object para Etiquetas de Sedex (SigCdSed)
* Herda de: BusinessBase
* Tabela principal: SigCdSed
* PK: cBarSedexs char(16)
*==============================================================================

DEFINE CLASS SedBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdSed
    *--------------------------------------------------------------------------
    this_cBarSedexs  = ""   && char(16) - codigo de barras sedex (PK)
    this_cEmps       = ""   && char(3)  - codigo empresa
    this_dDtIncs     = {}   && datetime - data inclusao
    this_dDtUsos     = {}   && datetime - data uso da etiqueta
    this_cEmpDopNums = ""   && char(29) - numero DOP/protocolo ('' = livre)
    this_cFaixaFins  = ""   && char(14) - faixa final da geracao
    this_cFaixaInis  = ""   && char(14) - faixa inicial da geracao
    this_nNumEtiqs   = 0    && numeric(8,0) - numero sequencial da etiqueta
    this_nImpress    = 0    && numeric(1,0) - flag impresso

    *--------------------------------------------------------------------------
    * Configuracao do BusinessBase
    *--------------------------------------------------------------------------
    this_cTabela     = "SigCdSed"
    this_cCampoChave = "cBarSedexs"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    FUNCTION Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cBarSedexs)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAlias)
        IF USED(par_cAlias)
            SELECT (par_cAlias)
            THIS.this_cBarSedexs  = TratarNulo(cBarSedexs,  "C")
            THIS.this_cEmps       = TratarNulo(cEmps,       "C")
            THIS.this_cFaixaInis  = TratarNulo(FaixaInis,   "C")
            THIS.this_cFaixaFins  = TratarNulo(FaixaFins,   "C")
            THIS.this_nNumEtiqs   = TratarNulo(nNumEtiqs,   "N")
            THIS.this_cEmpDopNums = TratarNulo(EmpDopNums,  "C")
            THIS.this_nImpress    = TratarNulo(nImpress,    "N")
            THIS.this_dDtIncs     = TratarNulo(DtIncs,      "D")
            THIS.this_dDtUsos     = TratarNulo(DtUsos,      "D")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarSedex - Carrega cursor_4c_Sedex com dados agrupados por faixa
    * Equivalente ao SELECT do Init legado
    *--------------------------------------------------------------------------
    FUNCTION CarregarSedex(par_cEmps)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Sedex")
                USE IN cursor_4c_Sedex
            ENDIF

            loc_cSQL = "SELECT DtIncs, FaixaInis, FaixaFins, " + ;
                       "SUM(CASE WHEN ISNULL(EmpDopNums,'') = '' THEN 0 ELSE 1 END) AS nUsadas, " + ;
                       "SUM(CASE WHEN ISNULL(EmpDopNums,'') <> '' THEN 0 ELSE 1 END) AS nLivres " + ;
                       "FROM SigCdSed " + ;
                       "WHERE cEmps = " + EscaparSQL(par_cEmps) + " " + ;
                       "GROUP BY DtIncs, FaixaInis, FaixaFins " + ;
                       "ORDER BY DtIncs, FaixaInis, FaixaFins"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Sedex")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar etiquetas de Sedex." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.CarregarSedex")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarEtiquetas - Gera etiquetas de Sedex para a faixa informada
    * Equivalente ao cmdprocessar.Click legado
    *--------------------------------------------------------------------------
    FUNCTION GerarEtiquetas(par_cFaixaIni, par_cFaixaFin, par_cEmps)
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        LOCAL loc_nFaixaIni, loc_nFaixaFin, loc_nX
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cBarEtiq, loc_cServico, loc_cPais
        LOCAL loc_cSeqPadded

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Extrair numeros sequenciais das faixas (8 digitos numericos)
            loc_nFaixaIni = VAL(THIS.ExtrairNumericos(par_cFaixaIni))
            loc_nFaixaFin = VAL(THIS.ExtrairNumericos(par_cFaixaFin))

            IF loc_nFaixaIni = 0 OR loc_nFaixaFin = 0
                MsgAviso("Faixa inicial e final s" + CHR(227) + "o obrigat" + CHR(243) + "rias.", "Aviso")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND loc_nFaixaFin < loc_nFaixaIni
                MsgAviso("Faixa final deve ser maior ou igual " + CHR(224) + " faixa inicial.", "Aviso")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Verificar se ja existem etiquetas na faixa
                loc_cSQL = "SELECT cBarSedexs FROM SigCdSed " + ;
                           "WHERE nNumEtiqs BETWEEN " + TRANSFORM(loc_nFaixaIni) + ;
                           " AND " + TRANSFORM(loc_nFaixaFin) + ;
                           " AND cEmps = " + EscaparSQL(par_cEmps)

                IF USED("cursor_4c_SedVerif")
                    USE IN cursor_4c_SedVerif
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SedVerif")

                IF loc_nResult <= 0
                    MsgErro("Erro ao verificar etiquetas existentes." + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF !EOF("cursor_4c_SedVerif")
                    MsgAviso("J" + CHR(225) + " existe etiquetas geradas na faixa informada.", "Aviso")
                    loc_lContinuar = .F.
                ENDIF

                IF USED("cursor_4c_SedVerif")
                    USE IN cursor_4c_SedVerif
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Servico (2 primeiros chars) e pais (2 ultimos chars da faixa de 14)
                loc_cServico = SUBSTR(par_cFaixaIni, 1, 2)
                loc_cPais    = SUBSTR(par_cFaixaIni, 13, 2)

                *-- Gerar uma etiqueta por numero sequencial
                loc_nX = loc_nFaixaIni
                DO WHILE loc_lContinuar AND loc_nX <= loc_nFaixaFin
                    loc_cSeqPadded = PADL(TRANSFORM(loc_nX), 8, "0")
                    loc_cBarEtiq   = THIS.CalcularBarraSedex(loc_cServico + loc_cSeqPadded + loc_cPais)

                    loc_cSQL = "INSERT INTO SigCdSed " + ;
                               "(cEmps, DtIncs, nNumEtiqs, FaixaInis, FaixaFins, cBarSedexs, EmpDopNums) " + ;
                               "VALUES (" + ;
                               EscaparSQL(par_cEmps) + ", GETDATE(), " + ;
                               FormatarNumeroSQL(loc_nX, 0) + ", " + ;
                               EscaparSQL(par_cFaixaIni) + ", " + ;
                               EscaparSQL(par_cFaixaFin) + ", " + ;
                               EscaparSQL(loc_cBarEtiq) + ", " + ;
                               EscaparSQL("") + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResult <= 0
                        MsgErro("Erro ao inserir etiqueta " + TRANSFORM(loc_nX) + "." + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lContinuar = .F.
                    ELSE
                        loc_nX = loc_nX + 1
                    ENDIF
                ENDDO

                IF loc_lContinuar
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.GerarEtiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirFaixa - Exclui todas as etiquetas de uma faixa do SQL Server
    * Equivalente ao excluir.Click legado
    * par_nUsadas: numero de etiquetas ja usadas (0 = pode excluir)
    *--------------------------------------------------------------------------
    FUNCTION ExcluirFaixa(par_cFaixaIni, par_cEmps, par_nUsadas)
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            IF par_nUsadas > 0
                MsgAviso("Etiquetas j" + CHR(225) + " usadas na faixa selecionada. " + ;
                         "N" + CHR(227) + "o " + CHR(233) + " permitido exclus" + CHR(227) + "o.", ;
                         "Aviso")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_cSQL = "DELETE FROM SigCdSed " + ;
                           "WHERE cEmps = " + EscaparSQL(par_cEmps) + ;
                           " AND FaixaInis = " + EscaparSQL(par_cFaixaIni)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult <= 0
                    MsgErro("Erro ao excluir etiquetas da faixa." + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.ExcluirFaixa")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida propriedades do BO antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_cBarSedexs)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo de barras Sedex " + CHR(233) + " obrigat" + CHR(243) + "rio."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cEmps)
            THIS.this_cMensagemErro = "Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cFaixaInis)
            THIS.this_cMensagemErro = "Faixa inicial " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cFaixaFins)
            THIS.this_cMensagemErro = "Faixa final " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um novo registro na tabela SigCdSed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdSed
                    (cBarSedexs, cEmps, DtIncs, DtUsos, EmpDopNums,
                     FaixaFins, FaixaInis, nNumEtiqs, nImpress)
                VALUES (
                    <<EscaparSQL(THIS.this_cBarSedexs)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    GETDATE(),
                    <<FormatarDataSQL(THIS.this_dDtUsos)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<EscaparSQL(THIS.this_cFaixaFins)>>,
                    <<EscaparSQL(THIS.this_cFaixaInis)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumEtiqs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nImpress, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir etiqueta Sedex: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza um registro existente na tabela SigCdSed
    * Uso tipico: marcar etiqueta como usada (preencher EmpDopNums/DtUsos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdSed
                SET cEmps      = <<EscaparSQL(THIS.this_cEmps)>>,
                    DtUsos     = <<FormatarDataSQL(THIS.this_dDtUsos)>>,
                    EmpDopNums = <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    FaixaFins  = <<EscaparSQL(THIS.this_cFaixaFins)>>,
                    FaixaInis  = <<EscaparSQL(THIS.this_cFaixaInis)>>,
                    nNumEtiqs  = <<FormatarNumeroSQL(THIS.this_nNumEtiqs, 0)>>,
                    nImpress   = <<FormatarNumeroSQL(THIS.this_nImpress, 0)>>
                WHERE cBarSedexs = <<EscaparSQL(THIS.this_cBarSedexs)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar etiqueta Sedex: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui um registro da tabela SigCdSed pela PK
    * Guard: nao permite excluir etiqueta ja usada (EmpDopNums preenchido)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro, loc_lUsada

        loc_lSucesso = .F.
        loc_lUsada   = .F.

        TRY
            *-- Verificar se a etiqueta ja foi usada
            loc_cSQL = "SELECT EmpDopNums FROM SigCdSed " + ;
                       "WHERE cBarSedexs = " + EscaparSQL(THIS.this_cBarSedexs)

            IF USED("cursor_4c_SedChk")
                USE IN cursor_4c_SedChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SedChk")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao verificar etiqueta: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                IF USED("cursor_4c_SedChk") AND !EOF("cursor_4c_SedChk")
                    loc_lUsada = !EMPTY(NVL(cursor_4c_SedChk.EmpDopNums, ""))
                ENDIF

                IF USED("cursor_4c_SedChk")
                    USE IN cursor_4c_SedChk
                ENDIF

                IF loc_lUsada
                    THIS.this_cMensagemErro = "Etiqueta j" + CHR(225) + " utilizada. N" + CHR(227) + "o " + CHR(233) + " permitido exclus" + CHR(227) + "o."
                    MsgAviso(THIS.this_cMensagemErro, "Aviso")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdSed " + ;
                               "WHERE cBarSedexs = " + EscaparSQL(THIS.this_cBarSedexs)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao excluir etiqueta Sedex: " + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExtrairNumericos - Extrai apenas os digitos numericos de uma string
    * Equivalente a fSubstTxt(str, "", "N") do framework legado
    * Retorna os 8 primeiros digitos (numero sequencial da faixa)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExtrairNumericos(par_cTexto)
        LOCAL loc_cResultado, loc_i, loc_cChar

        loc_cResultado = ""

        FOR loc_i = 1 TO LEN(ALLTRIM(par_cTexto))
            loc_cChar = SUBSTR(par_cTexto, loc_i, 1)
            IF ISDIGIT(loc_cChar)
                loc_cResultado = loc_cResultado + loc_cChar
            ENDIF
        ENDFOR

        RETURN SUBSTR(loc_cResultado, 1, 8)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CalcularBarraSedex - Calcula codigo de barras Sedex com digito verificador
    * Equivalente a fBarSedex() do framework legado (Correios Modulo-11)
    * par_cCodigo: 12 chars - Servico(2) + Sequencial(8) + Pais(2)
    * Retorna: 13 chars - Servico(2) + Sequencial(8) + Digito(1) + Pais(2)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CalcularBarraSedex(par_cCodigo)
        LOCAL loc_cServico, loc_cSequencial, loc_cPais
        LOCAL loc_nSoma, loc_nResto, loc_nDigito, loc_i
        LOCAL loc_aPesos[8]

        loc_cServico    = SUBSTR(par_cCodigo, 1, 2)
        loc_cSequencial = SUBSTR(par_cCodigo, 3, 8)
        loc_cPais       = SUBSTR(par_cCodigo, 11, 2)

        *-- Pesos Correios Modulo-11 para Sedex/PAC
        loc_aPesos[1] = 8
        loc_aPesos[2] = 6
        loc_aPesos[3] = 4
        loc_aPesos[4] = 2
        loc_aPesos[5] = 3
        loc_aPesos[6] = 9
        loc_aPesos[7] = 7
        loc_aPesos[8] = 5

        loc_nSoma = 0
        FOR loc_i = 1 TO 8
            loc_nSoma = loc_nSoma + (VAL(SUBSTR(loc_cSequencial, loc_i, 1)) * loc_aPesos[loc_i])
        ENDFOR

        loc_nResto = MOD(loc_nSoma, 11)

        DO CASE
            CASE loc_nResto = 0
                loc_nDigito = 5
            CASE loc_nResto = 1
                loc_nDigito = 0
            OTHERWISE
                loc_nDigito = 11 - loc_nResto
        ENDCASE

        RETURN loc_cServico + loc_cSequencial + TRANSFORM(loc_nDigito) + loc_cPais
    ENDFUNC

ENDDEFINE

