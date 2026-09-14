# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (20)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGPRES1): Left original=84 vs migrado 'cnt_4c_Container1' Left=0 (diff=84px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_moeda' (parent: SIGPRES1.Container1): Top original=171 vs migrado 'lbl_4c_Lbl_moeda' Top=404 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_moeda' (parent: SIGPRES1.Container1): Left original=54 vs migrado 'lbl_4c_Lbl_moeda' Left=8 (diff=46px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptCotacao' (parent: SIGPRES1.Container1): Top original=165 vs migrado 'obj_4c_OptCotacao' Top=2 (diff=163px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptCotacao' (parent: SIGPRES1.Container1): Left original=308 vs migrado 'obj_4c_OptCotacao' Left=0 (diff=308px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGPRES1.Container1): Top original=41 vs migrado 'lbl_4c_Lbl_periodo_a' Top=81 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGPRES1.Container1): Left original=50 vs migrado 'lbl_4c_Lbl_periodo_a' Left=243 (diff=193px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_impressao' (parent: SIGPRES1.Container1): Top original=213 vs migrado 'obj_4c_Opt_impressao' Top=2 (diff=211px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_impressao' (parent: SIGPRES1.Container1): Left original=94 vs migrado 'obj_4c_Opt_impressao' Left=0 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo_a' (parent: SIGPRES1.Container1): Top original=41 vs migrado 'lbl_4c_Lbl_periodo_a' Top=81 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo_a' (parent: SIGPRES1.Container1): Left original=183 vs migrado 'lbl_4c_Lbl_periodo_a' Left=243 (diff=60px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Pendente' (parent: SIGPRES1.Container1): Top original=191 vs migrado 'obj_4c_Opt_Pendente' Top=2 (diff=189px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Pendente' (parent: SIGPRES1.Container1): Left original=94 vs migrado 'obj_4c_Opt_Pendente' Left=0 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_nr_periodo' (parent: SIGPRES1.Container1): Top original=36 vs migrado 'obj_4c_Opt_nr_periodo' Top=5 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_nr_periodo' (parent: SIGPRES1.Container1): Left original=273 vs migrado 'obj_4c_Opt_nr_periodo' Left=5 (diff=268px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkEmpD' (parent: SIGPRES1.Container1): Left original=436 vs migrado 'chk_4c_ChkEmpD' Left=579 (diff=143px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1856 linhas total):

*-- Linhas 10 a 30:
10: *   CODE -> arquitetura em camadas (FormBase / SigPrEs1BO)
11: *
12: * Fases de construcao:
13: *   FASE 3 (esta): Estrutura base - cabecalho, containers vazios, Destroy
14: *   FASE 4       : CommandGroup cmg_4c_Sair (Consultar + Encerrar)
15: *   FASES 5-6   : TextBoxes e controles de filtro em cnt_4c_Container1
16: *   FASES 7-8   : Eventos (KeyPress, LostFocus, validacoes, CmgConsultarClick)
17: *
18: * Nota sobre ConfigurarPageFrame:
19: *   Este eh um form OPERACIONAL de FILTRO/CONSULTA (nao CRUD).
20: *   Em vez de um PageFrame Page1=Lista/Page2=Dados, o layout eh
21: *   container-based: cabecalho no topo + container de filtros + botoes.
22: *   ConfigurarPageFrame() atua como orquestrador da montagem do layout
23: *   preservando o contrato semantico do FormBase.
24: *==============================================================================
25: 
26: DEFINE CLASS FormSigPrEs1 AS FormBase
27: 
28:     *-- Propriedades visuais (PILAR 1 - escalado de 823x400 para 1000x600)
29:     Width       = 1000
30:     Height      = 600

*-- Linhas 45 a 207:
45:     this_cModoAtual      = "FILTRO"
46: 
47:     *==========================================================================
48:     * Init - Delega para FormBase que chama InicializarForm
49:     * FormBase.Init() seta SET DATE TO BRITISH + SET CENTURY ON (DataSession=2)
50:     *==========================================================================
51:     PROCEDURE Init()
52:         RETURN DODEFAULT()
53:     ENDPROC
54: 
55:     *==========================================================================
56:     * InicializarForm - Constroi BO, configura cabecalho e containers base
57:     * Chamado automaticamente por FormBase.Init()
58:     *==========================================================================
59:     PROTECTED PROCEDURE InicializarForm()
60:         LOCAL loc_lSucesso, loc_oErro
61:         loc_lSucesso = .F.
62: 
63:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
64:             THIS.ConfigurarCabecalho()
65:             RETURN .T.
66:         ENDIF
67: 
68:         TRY
69:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrEs1BO")
70: 
71:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
72:                 *-- Carregar GrPadVens e parametros de SigCdPam
73:                 IF gnConnHandle > 0
74:                     THIS.this_oBusinessObject.CarregarParametros()
75:                 ENDIF
76: 
77:                 *-- Pre-popular defaults do BO (equivale ao Init() original)
78:                 THIS.this_oBusinessObject.this_cCdEmpresa = go_4c_Sistema.cCodEmpresa
79:                 THIS.this_oBusinessObject.this_dDtInicial = DATE()
80:                 THIS.this_oBusinessObject.this_dDtFinal   = DATE()
81:                 THIS.this_oBusinessObject.this_nOptPendente = 3
82: 
83:                 *-- Orquestrador de montagem do layout (cabecalho + filtros + botoes)
84:                 THIS.ConfigurarPageFrame()
85: 
86:                 *-- Propagar titulo do form para labels do cabecalho
87:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
88:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
89: 
90:                 *-- Tornar todos os controles visiveis
91:                 THIS.TornarControlesVisiveis(THIS)
92: 
93:                 loc_lSucesso = .T.
94:             ELSE
95:                 MsgErro("Erro ao criar SigPrEs1BO", ;
96:                         "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
97:             ENDIF
98: 
99:         CATCH TO loc_oErro
100:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
101:                     " PROC=" + loc_oErro.Procedure, ;
102:                     "Erro em InicializarForm")
103:         ENDTRY
104: 
105:         RETURN loc_lSucesso
106:     ENDPROC
107: 
108:     *==========================================================================
109:     * ConfigurarPageFrame - Orquestrador de montagem do layout
110:     * Form OPERACIONAL nao usa PageFrame Page1/Page2 - usa layout container-based:
111:     *   1) cnt_4c_Sombra (cabecalho cinza no topo)
112:     *   2) cnt_4c_Container1 (filtros - preenchido na Fase 5-6)
113:     *   3) cmg_4c_Sair (CommandGroup Consultar+Encerrar)
114:     * Mantido este nome para compatibilidade com o contrato do FormBase e para
115:     * refletir o papel de "montador da regiao central" do form.
116:     *==========================================================================
117:     PROTECTED PROCEDURE ConfigurarPageFrame()
118:         THIS.ConfigurarCabecalho()
119:         THIS.ConfigurarPaginaLista()
120:     ENDPROC
121: 
122:     *==========================================================================
123:     * ConfigurarPaginaLista - Configura a area principal de trabalho do form
124:     * OPERACIONAL. Como este form nao usa PageFrame CRUD Page1=Lista/Page2=Dados,
125:     * este metodo agrega a construcao do container de filtros e os botoes de
126:     * acao (Consultar + Encerrar), que juntos compoem a "pagina" ativa do form.
127:     * Nome preservado para compatibilidade com o contrato do FormBase.
128:     *==========================================================================
129:     PROTECTED PROCEDURE ConfigurarPaginaLista()
130:         THIS.ConfigurarContainerFiltros()
131:         THIS.ConfigurarBotoes()
132:     ENDPROC
133: 
134:     *==========================================================================
135:     * AlternarPagina - Alterna o modo operacional do form
136:     * Em forms OPERACIONAIS nao existem paginas CRUD (LISTA/DADOS), mas o
137:     * form mantem um modo logico (FILTRO/RESULTADO) que controla se aceita
138:     * nova consulta ou esta aguardando retorno de sigpres2. Chamado pelo fluxo
139:     * de CmgConsultarClick para bloquear reentrancia enquanto o form de
140:     * resultados esta aberto e para restaurar o estado no retorno.
141:     * par_cModo: "FILTRO" (aceita entrada) ou "RESULTADO" (bloqueado)
142:     *==========================================================================
143:     PROCEDURE AlternarPagina(par_cModo)
144:         IF PCOUNT() >= 1 AND VARTYPE(par_cModo) = "C" AND !EMPTY(par_cModo)
145:             THIS.this_cModoAtual = UPPER(ALLTRIM(par_cModo))
146:         ENDIF
147: 
148:         DO CASE
149:             CASE THIS.this_cModoAtual == "RESULTADO"
150:                 THIS.Enabled = .F.
151:             OTHERWISE
152:                 THIS.this_cModoAtual = "FILTRO"
153:                 THIS.Enabled = .T.
154:                 IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
155:                     IF PEMSTATUS(THIS.cnt_4c_Container1, "txt_4c__nm_operacao", 5)
156:                         THIS.cnt_4c_Container1.txt_4c__nm_operacao.SetFocus
157:                     ENDIF
158:                 ENDIF
159:         ENDCASE
160:     ENDPROC
161: 
162:     *==========================================================================
163:     * ConfigurarCabecalho - Cria background e cabecalho cinza superior (cnt_4c_Sombra)
164:     * Equivale ao cntSombra do legado (Top=0, Left=-12, Width=840, Height=80)
165:     * Novo: Top=0, Left=0, Width=1000, Height=80
166:     *==========================================================================
167:     PROTECTED PROCEDURE ConfigurarCabecalho()
168:         LOCAL loc_cCaption
169:         loc_cCaption = "Posi" + CHR(231) + CHR(227) + ;
170:                        "o Por Movimenta" + CHR(231) + CHR(227) + "o"
171: 
172:         *-- Imagem de fundo (forms OPERACIONAIS usam new_background.jpg)
173:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
174: 
175:         THIS.AddObject("cnt_4c_Sombra", "Container")
176:         WITH THIS.cnt_4c_Sombra
177:             .Top         = 0
178:             .Left        = 0
179:             .Width       = THIS.Width
180:             .Height      = 80
181:             .BackColor   = RGB(100, 100, 100)
182:             .BackStyle   = 1
183:             .BorderWidth = 0
184: 
185:             *-- Sombra (legado: lblSombra ForeColor=0,0,0 offset +1px)
186:             .AddObject("lbl_4c_Sombra", "Label")
187:             WITH .lbl_4c_Sombra
188:                 .Top       = 18
189:                 .Left      = 10
190:                 .Width     = THIS.Width
191:                 .Height    = 40
192:                 .AutoSize  = .F.
193:                 .FontBold  = .T.
194:                 .FontName  = "Tahoma"
195:                 .FontSize  = 18
196:                 .BackStyle = 0
197:                 .ForeColor = RGB(0, 0, 0)
198:                 .WordWrap  = .T.
199:                 .Caption   = loc_cCaption
200:             ENDWITH
201: 
202:             *-- Titulo branco (legado: lblTitulo ForeColor=255,255,255)
203:             .AddObject("lbl_4c_Titulo", "Label")
204:             WITH .lbl_4c_Titulo
205:                 .Top       = 17
206:                 .Left      = 10
207:                 .Width     = THIS.Width

*-- Linhas 222 a 293:
222:     * ConfigurarContainerFiltros - Container dos campos de filtro (Fase 5-6)
223:     * Equivale ao Container1 do legado (Top=84, Left=84, Width=618, Height=249)
224:     * Novo escalado: Top=85, Left=0, Width=820, Height=480
225:     * Conteudo (TextBoxes, Labels, OptionGroups, CheckBox) preenchido na Fase 5-6
226:     *==========================================================================
227:     PROTECTED PROCEDURE ConfigurarContainerFiltros()
228:         THIS.AddObject("cnt_4c_Container1", "Container")
229:         WITH THIS.cnt_4c_Container1
230:             .Top         = 85
231:             .Left        = 0
232:             .Width       = 820
233:             .Height      = 490
234:             .BackStyle   = 0
235:             .BorderWidth = 0
236:             .Visible     = .T.
237:         ENDWITH
238:         THIS.ConfigurarPaginaDados()
239:         THIS.ConfigurarPaginaDados2()
240:         THIS.ConfigurarLookups()
241:     ENDPROC
242: 
243:     *==========================================================================
244:     * ConfigurarPaginaDados - Adiciona a primeira metade dos controles de filtro
245:     * ao cnt_4c_Container1: empresa (linha 1), periodo (linha 2),
246:     * movimentacao/numero/op/status (linha 3), grupo (linha 4), conta/cpf (linha 5).
247:     * Os controles restantes (responsavel, moeda, situacao, impressao) serao
248:     * adicionados na Fase 6 por ConfigurarPaginaDados2().
249:     *
250:     * Escala original->novo: Container1 618x249 -> 820x490
251:     *   ScaleX = 820/618 = 1.327  |  ScaleY = 490/249 = 1.968
252:     *==========================================================================
253:     PROTECTED PROCEDURE ConfigurarPaginaDados()
254:         LOCAL loc_oCnt
255:         loc_oCnt = THIS.cnt_4c_Container1
256: 
257:         *-- -----------------------------------------------------------------------
258:         *-- LINHA 1: Empresa (y_orig=10-14)
259:         *-- -----------------------------------------------------------------------
260:         loc_oCnt.AddObject("lbl_4c_Lbl_empresa", "Label")
261:         WITH loc_oCnt.lbl_4c_Lbl_empresa
262:             .Top       = 26
263:             .Left      = 59
264:             .Height    = 15
265:             .AutoSize  = .T.
266:             .FontName  = "Tahoma"
267:             .FontSize  = 8
268:             .BackStyle = 0
269:             .ForeColor = RGB(90, 90, 90)
270:             .Caption   = "Empresa :"
271:         ENDWITH
272: 
273:         loc_oCnt.AddObject("txt_4c__cd_empresa", "TextBox")
274:         WITH loc_oCnt.txt_4c__cd_empresa
275:             .Top           = 20
276:             .Left          = 133
277:             .Width         = 41
278:             .Height        = 23
279:             .Value         = go_4c_Sistema.cCodEmpresa
280:             .Format        = "K!"
281:             .MaxLength     = 3
282:             .SpecialEffect = 1
283:             .FontName      = "Tahoma"
284:             .ForeColor     = RGB(0, 0, 0)
285:             .Themes        = .F.
286:         ENDWITH
287: 
288:         loc_oCnt.AddObject("txt_4c__ds_empresa", "TextBox")
289:         WITH loc_oCnt.txt_4c__ds_empresa
290:             .Top           = 20
291:             .Left          = 178
292:             .Width         = 386
293:             .Height        = 23

*-- Linhas 370 a 414:
370:             .Themes        = .F.
371:         ENDWITH
372: 
373:         *-- OptionGroup: tipo de periodo (Lancamento / Prazo Entrega)
374:         loc_oCnt.AddObject("obj_4c_Opt_nr_periodo", "OptionGroup")
375:         WITH loc_oCnt.obj_4c_Opt_nr_periodo
376:             .Top           = 71
377:             .Left          = 362
378:             .Width         = 246
379:             .Height        = 25
380:             .BackStyle     = 0
381:             .BorderStyle   = 0
382:             .SpecialEffect = 0
383:             .ButtonCount   = 2
384: 
385:             WITH .Buttons(1)
386:                 .Caption   = "Lan" + CHR(231) + "amento"
387:                 .AutoSize  = .F.
388:                 .BackStyle = 0
389:                 .ForeColor = RGB(90, 90, 90)
390:                 .Themes    = .F.
391:                 .Height    = 15
392:                 .Left      = 5
393:                 .Top       = 5
394:                 .Width     = 101
395:             ENDWITH
396: 
397:             WITH .Buttons(2)
398:                 .Caption   = "Prazo Entrega"
399:                 .AutoSize  = .F.
400:                 .BackStyle = 0
401:                 .ForeColor = RGB(90, 90, 90)
402:                 .FontName  = "Tahoma"
403:                 .Themes    = .F.
404:                 .Height    = 15
405:                 .Left      = 125
406:                 .Top       = 5
407:                 .Width     = 116
408:             ENDWITH
409: 
410:             .Value = 1
411:         ENDWITH
412: 
413:         *-- -----------------------------------------------------------------------
414:         *-- LINHA 3: Movimentacao / Numero / OP / Status (y_orig=63-67)

*-- Linhas 628 a 671:
628:     * Command1 (legado: "consulta") -> Buttons(1) Consultar
629:     * Command2 (legado: "sair")     -> Buttons(2) Encerrar
630:     *==========================================================================
631:     PROTECTED PROCEDURE ConfigurarBotoes()
632:         THIS.AddObject("cmg_4c_Sair", "CommandGroup")
633:         WITH THIS.cmg_4c_Sair
634:             .Top           = 0
635:             .Left          = 820
636:             .Width         = 180
637:             .Height        = 85
638:             .ButtonCount   = 2
639:             .BackStyle     = 0
640:             .BorderStyle   = 0
641:             .SpecialEffect = 1
642:             .Themes        = .F.
643: 
644:             WITH .Buttons(1)
645:                 .Top             = 5
646:                 .Left            = 5
647:                 .Width           = 75
648:                 .Height          = 75
649:                 .FontBold        = .T.
650:                 .FontItalic      = .T.
651:                 .WordWrap        = .T.
652:                 .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
653:                 .Caption         = "Consultar"
654:                 .ForeColor       = RGB(90, 90, 90)
655:                 .BackColor       = RGB(255, 255, 255)
656:                 .Themes          = .F.
657:                 .MousePointer    = 15
658:                 .SpecialEffect   = 0
659:                 .PicturePosition = 13
660:             ENDWITH
661: 
662:             WITH .Buttons(2)
663:                 .Top             = 5
664:                 .Left            = 85
665:                 .Width           = 75
666:                 .Height          = 75
667:                 .FontBold        = .T.
668:                 .FontItalic      = .T.
669:                 .FontName        = "Tahoma"
670:                 .FontSize        = 8
671:                 .WordWrap        = .T.

*-- Linhas 681 a 786:
681:             ENDWITH
682:         ENDWITH
683: 
684:         BINDEVENT(THIS.cmg_4c_Sair.Buttons(1), "Click", THIS, "CmgConsultarClick")
685:         BINDEVENT(THIS.cmg_4c_Sair.Buttons(2), "Click", THIS, "CmgEncerrarClick")
686:     ENDPROC
687: 
688:     *==========================================================================
689:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
690:     * AddObject() cria controles com Visible=.F. por padrao
691:     *==========================================================================
692:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
693:         LOCAL loc_nI, loc_oObjeto
694: 
695:         IF VARTYPE(par_oContainer) # "O"
696:             RETURN
697:         ENDIF
698: 
699:         FOR loc_nI = 1 TO par_oContainer.ControlCount
700:             loc_oObjeto = par_oContainer.Controls(loc_nI)
701:             IF VARTYPE(loc_oObjeto) = "O"
702:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
703:                     loc_oObjeto.Visible = .T.
704:                 ENDIF
705:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
706:                    loc_oObjeto.ControlCount > 0
707:                     THIS.TornarControlesVisiveis(loc_oObjeto)
708:                 ENDIF
709:             ENDIF
710:         ENDFOR
711:     ENDPROC
712: 
713:     *==========================================================================
714:     * CmgConsultarClick - Valida filtros, executa query e abre sigpres2
715:     * Equivale ao PROCEDURE consulta.Click do legado (83 linhas)
716:     * Validacoes: empresa obrigatoria, operacao obrigatoria, periodo valido
717:     * Query: SigMvCab JOIN SigCdOpe com filtros dinamicos
718:     * Resultado: DO FORM sigpres2 WITH loc_cNmO, THIS.DataSessionId, THIS
719:     *==========================================================================
720:     PROCEDURE CmgConsultarClick()
721:         LOCAL loc_nNrP, loc_cNmO, loc_cEst, loc_cCon, loc_nPen
722:         LOCAL loc_cVen, loc_cEmp, loc_cSta, loc_nEmpD
723:         LOCAL loc_cNOp, loc_cNum, loc_cWhere, loc_cQuery
724:         LOCAL loc_dDtInicial, loc_dDtFinal, loc_cDtI, loc_cDtF
725:         LOCAL loc_oErro
726: 
727:         *-- Validar empresa (obrigatoria)
728:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c__cd_empresa.Value))
729:             MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", ;
730:                      "Aten" + CHR(231) + CHR(227) + "o")
731:             THIS.cnt_4c_Container1.txt_4c__cd_empresa.SetFocus
732:             RETURN
733:         ENDIF
734: 
735:         *-- Validar opera??o (obrigatoria)
736:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c__nm_operacao.Value))
737:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
738:                      "Aten" + CHR(231) + CHR(227) + "o")
739:             THIS.cnt_4c_Container1.txt_4c__nm_operacao.SetFocus
740:             RETURN
741:         ENDIF
742: 
743:         *-- Validar per?odo (data final >= data inicial)
744:         IF THIS.cnt_4c_Container1.txt_4c__dt_final.Value < ;
745:            THIS.cnt_4c_Container1.txt_4c__dt_inicial.Value
746:             MsgAviso("Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! " + ;
747:                      "Data Final Menor do Que a Inicial!!!", ;
748:                      "Aten" + CHR(231) + CHR(227) + "o")
749:             THIS.cnt_4c_Container1.txt_4c__dt_inicial.SetFocus
750:             RETURN
751:         ENDIF
752: 
753:         *-- Capturar valores dos filtros
754:         loc_nNrP  = THIS.cnt_4c_Container1.obj_4c_Opt_nr_periodo.Value
755:         loc_cNmO  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c__nm_operacao.Value)
756:         loc_cEst  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Grupo.Value)
757:         loc_cCon  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Conta.Value)
758:         loc_nPen  = THIS.cnt_4c_Container1.obj_4c_Opt_Pendente.Value
759:         loc_cVen  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c__resps.Value)
760:         loc_cEmp  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c__cd_empresa.Value)
761:         loc_cSta  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_PStatus.Value)
762:         loc_nEmpD = THIS.cnt_4c_Container1.chk_4c_ChkEmpD.Value
763:         loc_cNOp  = IIF(THIS.cnt_4c_Container1.txt_4c_Op.Value = 0, "", TRANSFORM(THIS.cnt_4c_Container1.txt_4c_Op.Value))
764:         loc_cNum  = IIF(THIS.cnt_4c_Container1.txt_4c_Numero.Value = 0, "", TRANSFORM(THIS.cnt_4c_Container1.txt_4c_Numero.Value))
765: 
766:         *-- Datas formatadas para SQL Server BETWEEN
767:         loc_dDtInicial = THIS.cnt_4c_Container1.txt_4c__dt_inicial.Value
768:         loc_dDtFinal   = THIS.cnt_4c_Container1.txt_4c__dt_final.Value
769:         loc_cDtI = "'" + STR(YEAR(loc_dDtInicial), 4) + "-" + ;
770:                    PADL(STR(MONTH(loc_dDtInicial), 2), 2, "0") + "-" + ;
771:                    PADL(STR(DAY(loc_dDtInicial), 2), 2, "0") + "'"
772:         loc_cDtF = "'" + STR(YEAR(loc_dDtFinal), 4) + "-" + ;
773:                    PADL(STR(MONTH(loc_dDtFinal), 2), 2, "0") + "-" + ;
774:                    PADL(STR(DAY(loc_dDtFinal), 2), 2, "0") + " 23:59:59'"
775: 
776:         *-- Montar WHERE dinamico (cada parte termina com " AND " para encadear)
777:         loc_cWhere = IIF(EMPTY(loc_cNmO), "", "a.Dopes = " + EscaparSQL(loc_cNmO) + " AND ") + ;
778:                      IIF(loc_nNrP = 1, "a.Datas ", "a.PrazoEnts ") + ;
779:                      "BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " AND " + ;
780:                      IIF(EMPTY(loc_cEst), "", "(a.GrupoOs = " + EscaparSQL(loc_cEst) + ;
781:                          " OR a.GrupoDs = " + EscaparSQL(loc_cEst) + ") AND ") + ;
782:                      IIF(EMPTY(loc_cCon), "", "(a.ContaOs = " + EscaparSQL(loc_cCon) + ;
783:                          " OR a.ContaDs = " + EscaparSQL(loc_cCon) + ") AND ") + ;
784:                      IIF(EMPTY(loc_cNOp), "", "a.Nops = " + loc_cNOp + " AND ") + ;
785:                      IIF(EMPTY(loc_cNum), "", "a.Numes = " + loc_cNum + " AND ") + ;
786:                      IIF(EMPTY(loc_cVen), "", "a.Vends = " + EscaparSQL(loc_cVen) + " AND ") + ;

*-- Linhas 824 a 999:
824:                 *-- Restaurar modo FILTRO ao retornar do sigpres2
825:                 THIS.AlternarPagina("FILTRO")
826:             ELSE
827:                 MsgAviso("Nenhum Registro Selecionado!!!", ;
828:                          "Informa" + CHR(231) + CHR(227) + "o")
829:             ENDIF
830: 
831:         CATCH TO loc_oErro
832:             THIS.AlternarPagina("FILTRO")
833:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
834:                     " PROC=" + loc_oErro.Procedure, "Erro em Consultar")
835:         ENDTRY
836:     ENDPROC
837: 
838:     *==========================================================================
839:     * CmgEncerrarClick - Fecha o formulario
840:     * Equivale ao PROCEDURE sair.Click do legado (1 linha: ThisForm.Release)
841:     *==========================================================================
842:     PROCEDURE CmgEncerrarClick()
843:         THIS.Release()
844:     ENDPROC
845: 
846:     *==========================================================================
847:     * BtnVisualizarClick - Executa consulta e abre SIGPRES2 com resultados
848:     *
849:     * Contexto OPERACIONAL: SIGPRES1 eh um form de FILTRO/CONSULTA (nao CRUD).
850:     * O legado original tem UNICO botao funcional "sair" (que na verdade dispara
851:     * a consulta). No sistema novo, esse fluxo eh capturado em CmgConsultarClick.
852:     *
853:     * Semantica "Visualizar" = ver os movimentos filtrados = disparar a consulta
854:     * SigMvCab->SigCdOpe e abrir o form de resultados SIGPRES2. Por isso este
855:     * metodo delega para CmgConsultarClick(), que:
856:     *   1) Valida empresa/operacao/periodo (campos obrigatorios)
857:     *   2) Monta WHERE dinamico com todos os filtros do form
858:     *   3) SQLEXEC em cursor_4c_MovTemp + INDEX ON EmpDopNums
859:     *   4) Alterna form para modo RESULTADO (desabilita filtros)
860:     *   5) DO FORM sigpres2 (viewer dos resultados)
861:     *   6) Retorna para modo FILTRO ao fechar SIGPRES2
862:     *==========================================================================
863:     PROCEDURE BtnVisualizarClick()
864:         THIS.CmgConsultarClick()
865:     ENDPROC
866: 
867:     *==========================================================================
868:     * BtnIncluirClick - Executa consulta (acao principal do form OPERACIONAL)
869:     *
870:     * Contexto OPERACIONAL: SIGPRES1 nao possui CRUD proprio - eh um form de
871:     * FILTRO/CONSULTA que exibe movimentos existentes em SigMvCab. A inclusao
872:     * de novos movimentos ocorre em forms de digitacao especializados (nao
873:     * neste form).
874:     *
875:     * Para preservar contrato do FormBase e compatibilidade com a integracao
876:     * de menu/validadores, delega para CmgConsultarClick() que eh a UNICA
877:     * acao funcional real do form (equivale ao "sair" do legado que sempre
878:     * dispara a consulta).
879:     *==========================================================================
880:     PROCEDURE BtnIncluirClick()
881:         THIS.CmgConsultarClick()
882:     ENDPROC
883: 
884:     *==========================================================================
885:     * BtnAlterarClick - Executa consulta (acao principal do form OPERACIONAL)
886:     *
887:     * Contexto OPERACIONAL: SIGPRES1 nao possui CRUD proprio. Alteracao de
888:     * movimentos ocorre em forms de digitacao apos abrir SIGPRES2 (viewer)
889:     * via double-click no registro desejado.
890:     *
891:     * Delega para CmgConsultarClick() para preservar contrato de eventos
892:     * principais esperado pelo FormBase.
893:     *==========================================================================
894:     PROCEDURE BtnAlterarClick()
895:         THIS.CmgConsultarClick()
896:     ENDPROC
897: 
898:     *==========================================================================
899:     * BtnExcluirClick - Executa consulta (acao principal do form OPERACIONAL)
900:     *
901:     * Contexto OPERACIONAL: SIGPRES1 nao possui CRUD proprio. Exclusao de
902:     * movimentos ocorre em forms de manutencao especializados apos localizar
903:     * o registro atraves da consulta.
904:     *
905:     * Delega para CmgConsultarClick() para preservar contrato de eventos
906:     * principais esperado pelo FormBase.
907:     *==========================================================================
908:     PROCEDURE BtnExcluirClick()
909:         THIS.CmgConsultarClick()
910:     ENDPROC
911: 
912:     *==========================================================================
913:     * Destroy - Libera BO e fecha cursores abertos pelo form
914:     *==========================================================================
915:     PROCEDURE Destroy()
916:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
917:             THIS.this_oBusinessObject = .NULL.
918:         ENDIF
919: 
920:         IF USED("cursor_4c_MovTemp")
921:             USE IN cursor_4c_MovTemp
922:         ENDIF
923:         IF USED("cursor_4c_Param")
924:             USE IN cursor_4c_Param
925:         ENDIF
926:         IF USED("cursor_4c_BuscaGrupo")
927:             USE IN cursor_4c_BuscaGrupo
928:         ENDIF
929:         IF USED("cursor_4c_BuscaMoeda")
930:             USE IN cursor_4c_BuscaMoeda
931:         ENDIF
932:         IF USED("cursor_4c_BuscaConta")
933:             USE IN cursor_4c_BuscaConta
934:         ENDIF
935:         IF USED("cursor_4c_BuscaResp")
936:             USE IN cursor_4c_BuscaResp
937:         ENDIF
938:         IF USED("cursor_4c_BuscaCliente")
939:             USE IN cursor_4c_BuscaCliente
940:         ENDIF
941:         IF USED("cursor_4c_BuscaOpe")
942:             USE IN cursor_4c_BuscaOpe
943:         ENDIF
944:         IF USED("cursor_4c_BuscaEmp")
945:             USE IN cursor_4c_BuscaEmp
946:         ENDIF
947:         IF USED("cursor_4c_CpfTemp")
948:             USE IN cursor_4c_CpfTemp
949:         ENDIF
950: 
951:         DODEFAULT()
952:     ENDPROC
953: 
954:     *==========================================================================
955:     * ConfigurarPaginaDados2 - Adiciona a segunda metade dos controles de filtro:
956:     * Responsavel (linha 6), Moeda/Cotacao (linha 7), Situacao (linha 8),
957:     * Impressao (linha 9).
958:     *==========================================================================
959:     PROTECTED PROCEDURE ConfigurarPaginaDados2()
960:         LOCAL loc_oCnt
961:         loc_oCnt = THIS.cnt_4c_Container1
962: 
963:         *-- Linha 6: Responsavel (Say5 / get_resps / get_dresps)
964:         *   Original: Say5 Left=6 Top=192, get_resps Left=80 Top=190 Width=60 H=13
965:         *             get_dresps Left=146 Top=190 Width=200 H=13
966:         *   Escalado ScaleX=1.327 ScaleY=1.968
967:         loc_oCnt.AddObject("lbl_4c_Lbl_responsavel", "Label")
968:         WITH loc_oCnt.lbl_4c_Lbl_responsavel
969:             .Caption   = "Respons" + CHR(225) + "vel"
970:             .Top       = 378
971:             .Left      = 8
972:             .Width     = 90
973:             .Height    = 18
974:             .AutoSize  = .F.
975:             .FontBold  = .T.
976:             .FontSize  = 9
977:             .BackStyle = 0
978:         ENDWITH
979: 
980:         loc_oCnt.AddObject("txt_4c__resps", "TextBox")
981:         WITH loc_oCnt.txt_4c__resps
982:             .Value    = ""
983:             .Top      = 374
984:             .Left     = 106
985:             .Width    = 80
986:             .Height   = 22
987:             .FontSize = 9
988:         ENDWITH
989: 
990:         loc_oCnt.AddObject("txt_4c__dresps", "TextBox")
991:         WITH loc_oCnt.txt_4c__dresps
992:             .Value    = ""
993:             .Top      = 374
994:             .Left     = 192
995:             .Width    = 265
996:             .Height   = 22
997:             .ReadOnly = .T.
998:             .FontSize = 9
999:             .BackColor = RGB(240,240,240)

*-- Linhas 1052 a 1144:
1052:             .BackStyle = 0
1053:         ENDWITH
1054: 
1055:         loc_oCnt.AddObject("obj_4c_OptCotacao", "OptionGroup")
1056:         WITH loc_oCnt.obj_4c_OptCotacao
1057:             .Top        = 400
1058:             .Left       = 458
1059:             .Width      = 200
1060:             .Height     = 22
1061:             .ButtonCount = 2
1062:             .BorderStyle = 0
1063:             .BackStyle   = 0
1064:             .Value       = 1
1065:             WITH .Buttons(1)
1066:                 .Caption   = "Fechamento"
1067:                 .AutoSize  = .F.
1068:                 .BackStyle = 0
1069:                 .ForeColor = RGB(90, 90, 90)
1070:                 .Themes    = .F.
1071:                 .Left      = 0
1072:                 .Top       = 2
1073:                 .Width     = 95
1074:                 .Height    = 18
1075:             ENDWITH
1076:             WITH .Buttons(2)
1077:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
1078:                 .AutoSize  = .F.
1079:                 .BackStyle = 0
1080:                 .ForeColor = RGB(90, 90, 90)
1081:                 .FontSize  = 9
1082:                 .Themes    = .F.
1083:                 .Left      = 98
1084:                 .Top       = 2
1085:                 .Width     = 100
1086:                 .Height    = 18
1087:             ENDWITH
1088:         ENDWITH
1089: 
1090:         *-- Linha 8: Situacao (OptionGroup 3 opcoes: Quitado/Aberto/Todas)
1091:         loc_oCnt.AddObject("lbl_4c_Lbl_situacao", "Label")
1092:         WITH loc_oCnt.lbl_4c_Lbl_situacao
1093:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o"
1094:             .Top       = 432
1095:             .Left      = 8
1096:             .Width     = 90
1097:             .Height    = 18
1098:             .AutoSize  = .F.
1099:             .FontBold  = .T.
1100:             .FontSize  = 9
1101:             .BackStyle = 0
1102:         ENDWITH
1103: 
1104:         loc_oCnt.AddObject("obj_4c_Opt_Pendente", "OptionGroup")
1105:         WITH loc_oCnt.obj_4c_Opt_Pendente
1106:             .Top         = 428
1107:             .Left        = 106
1108:             .Width       = 225
1109:             .Height      = 22
1110:             .ButtonCount = 3
1111:             .BorderStyle = 0
1112:             .BackStyle   = 0
1113:             .Value       = THIS.this_oBusinessObject.this_nOptPendente
1114:             WITH .Buttons(1)
1115:                 .Caption   = "Pendente"
1116:                 .AutoSize  = .F.
1117:                 .BackStyle = 0
1118:                 .ForeColor = RGB(90, 90, 90)
1119:                 .Themes    = .F.
1120:                 .Left      = 0
1121:                 .Top       = 2
1122:                 .Width     = 72
1123:                 .Height    = 18
1124:             ENDWITH
1125:             WITH .Buttons(2)
1126:                 .Caption   = "Quitado"
1127:                 .AutoSize  = .F.
1128:                 .BackStyle = 0
1129:                 .ForeColor = RGB(90, 90, 90)
1130:                 .FontSize  = 9
1131:                 .Themes    = .F.
1132:                 .Left      = 75
1133:                 .Top       = 2
1134:                 .Width     = 70
1135:                 .Height    = 18
1136:             ENDWITH
1137:             WITH .Buttons(3)
1138:                 .Caption   = "Todas"
1139:                 .AutoSize  = .F.
1140:                 .BackStyle = 0
1141:                 .ForeColor = RGB(90, 90, 90)
1142:                 .FontSize  = 9
1143:                 .Themes    = .F.
1144:                 .Left      = 148

*-- Linhas 1164 a 1207:
1164:             .BackStyle = 0
1165:         ENDWITH
1166: 
1167:         loc_oCnt.AddObject("obj_4c_Opt_impressao", "OptionGroup")
1168:         WITH loc_oCnt.obj_4c_Opt_impressao
1169:             .Top         = 456
1170:             .Left        = 106
1171:             .Width       = 305
1172:             .Height      = 22
1173:             .ButtonCount = 3
1174:             .BorderStyle = 0
1175:             .BackStyle   = 0
1176:             .Value       = 1
1177:             WITH .Buttons(1)
1178:                 .Caption   = "Por Vendedor"
1179:                 .AutoSize  = .F.
1180:                 .BackStyle = 0
1181:                 .ForeColor = RGB(90, 90, 90)
1182:                 .Themes    = .F.
1183:                 .Left      = 0
1184:                 .Top       = 2
1185:                 .Width     = 98
1186:                 .Height    = 18
1187:             ENDWITH
1188:             WITH .Buttons(2)
1189:                 .Caption   = "Por Cliente"
1190:                 .AutoSize  = .F.
1191:                 .BackStyle = 0
1192:                 .ForeColor = RGB(90, 90, 90)
1193:                 .FontSize  = 9
1194:                 .Themes    = .F.
1195:                 .Left      = 101
1196:                 .Top       = 2
1197:                 .Width     = 98
1198:                 .Height    = 18
1199:             ENDWITH
1200:             WITH .Buttons(3)
1201:                 .Caption   = "Ambos"
1202:                 .AutoSize  = .F.
1203:                 .BackStyle = 0
1204:                 .ForeColor = RGB(90, 90, 90)
1205:                 .FontSize  = 9
1206:                 .Themes    = .F.
1207:                 .Left      = 202

*-- Linhas 1213 a 1856:
1213:     ENDPROC
1214: 
1215:     *==========================================================================
1216:     * ConfigurarLookups - Registra BINDEVENTs de KeyPress em todos os campos
1217:     * que precisam de lookup ou navegacao por teclado.
1218:     *==========================================================================
1219:     PROTECTED PROCEDURE ConfigurarLookups()
1220:         LOCAL loc_oCnt
1221:         loc_oCnt = THIS.cnt_4c_Container1
1222: 
1223:         BINDEVENT(loc_oCnt.txt_4c__cd_empresa,  "KeyPress", THIS, "TxtCdEmpresaKeyPress")
1224:         BINDEVENT(loc_oCnt.txt_4c__ds_empresa,  "KeyPress", THIS, "TxtDsEmpresaKeyPress")
1225:         BINDEVENT(loc_oCnt.txt_4c__nm_operacao, "KeyPress", THIS, "TxtNmOperacaoKeyPress")
1226:         BINDEVENT(loc_oCnt.txt_4c_Grupo,        "KeyPress", THIS, "TxtGrupoKeyPress")
1227:         BINDEVENT(loc_oCnt.txt_4c__Dgrupo,      "KeyPress", THIS, "TxtDGrupoKeyPress")
1228:         BINDEVENT(loc_oCnt.txt_4c_Conta,        "KeyPress", THIS, "TxtContaKeyPress")
1229:         BINDEVENT(loc_oCnt.txt_4c_Dconta,       "KeyPress", THIS, "TxtDContaKeyPress")
1230:         BINDEVENT(loc_oCnt.txt_4c_Cpf,          "KeyPress", THIS, "TxtCpfKeyPress")
1231:         BINDEVENT(loc_oCnt.txt_4c__resps,       "KeyPress", THIS, "TxtRespsKeyPress")
1232:         BINDEVENT(loc_oCnt.txt_4c__dresps,      "KeyPress", THIS, "TxtDRespsKeyPress")
1233:         BINDEVENT(loc_oCnt.txt_4c_cd_moeda,     "KeyPress", THIS, "TxtCdMoedaKeyPress")
1234:         BINDEVENT(loc_oCnt.txt_4c_ds_moeda,     "KeyPress", THIS, "TxtDsMoedaKeyPress")
1235:     ENDPROC
1236: 
1237:     *==========================================================================
1238:     * KeyPress handlers - publicos (BINDEVENT requer metodos publicos)
1239:     *==========================================================================
1240: 
1241:     PROCEDURE TxtCdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1242:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1243:             LOCAL loc_oCnt, loc_oBO, loc_cCod
1244:             loc_oCnt = THIS.cnt_4c_Container1
1245:             loc_oBO  = THIS.this_oBusinessObject
1246:             loc_cCod = ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value)
1247:             IF EMPTY(loc_cCod)
1248:                 THIS.AbrirLookupEmpresa()
1249:             ELSE
1250:                 IF loc_oBO.BuscarEmpresaPorCodigo(loc_cCod)
1251:                     loc_oCnt.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.razas)
1252:                     USE IN cursor_4c_BuscaEmp
1253:                 ELSE
1254:                     loc_oCnt.txt_4c__cd_empresa.Value = ""
1255:                     loc_oCnt.txt_4c__ds_empresa.Value = ""
1256:                     THIS.AbrirLookupEmpresa()
1257:                 ENDIF
1258:             ENDIF
1259:         ENDIF
1260:     ENDPROC
1261: 
1262:     PROCEDURE TxtDsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1263:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1264:             THIS.AbrirLookupEmpresa()
1265:         ENDIF
1266:     ENDPROC
1267: 
1268:     PROCEDURE TxtNmOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1269:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1270:             LOCAL loc_oCnt, loc_oBO, loc_cNome
1271:             loc_oCnt  = THIS.cnt_4c_Container1
1272:             loc_oBO   = THIS.this_oBusinessObject
1273:             loc_cNome = ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value)
1274:             IF EMPTY(loc_cNome)
1275:                 THIS.AbrirLookupOperacao()
1276:             ELSE
1277:                 IF !loc_oBO.BuscarOperacaoPorNome(loc_cNome)
1278:                     loc_oCnt.txt_4c__nm_operacao.Value = ""
1279:                     THIS.AbrirLookupOperacao()
1280:                 ENDIF
1281:             ENDIF
1282:         ENDIF
1283:     ENDPROC
1284: 
1285:     PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1286:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1287:             *-- Grupo so ativo quando Numero = 0 (When: Return Empty(Get_Numero.Value))
1288:             LOCAL loc_oCnt
1289:             loc_oCnt = THIS.cnt_4c_Container1
1290:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1291:                 RETURN
1292:             ENDIF
1293:             LOCAL loc_oBO, loc_cCod
1294:             loc_oBO  = THIS.this_oBusinessObject
1295:             loc_cCod = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1296:             IF EMPTY(loc_cCod)
1297:                 THIS.AbrirLookupGrupo()
1298:             ELSE
1299:                 IF loc_oBO.BuscarGrupoPorCodigo(loc_cCod)
1300:                     loc_oCnt.txt_4c__Dgrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
1301:                     USE IN cursor_4c_BuscaGrupo
1302:                 ELSE
1303:                     loc_oCnt.txt_4c_Grupo.Value   = ""
1304:                     loc_oCnt.txt_4c__Dgrupo.Value = ""
1305:                     THIS.AbrirLookupGrupo()
1306:                 ENDIF
1307:             ENDIF
1308:         ENDIF
1309:     ENDPROC
1310: 
1311:     PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1312:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1313:             *-- DGrupo so ativo quando Grupo esta vazio (When: Return Empty(Get_Grupo.Value))
1314:             LOCAL loc_oCnt
1315:             loc_oCnt = THIS.cnt_4c_Container1
1316:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1317:                 RETURN
1318:             ENDIF
1319:             IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
1320:                 RETURN
1321:             ENDIF
1322:             THIS.AbrirLookupGrupo()
1323:         ENDIF
1324:     ENDPROC
1325: 
1326:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1327:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1328:             *-- Conta so ativa quando Numero = 0 (When: Return Empty(Get_Numero.Value))
1329:             LOCAL loc_oCnt
1330:             loc_oCnt = THIS.cnt_4c_Container1
1331:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1332:                 RETURN
1333:             ENDIF
1334:             LOCAL loc_oBO, loc_cCod, loc_cGrupo
1335:             loc_oBO   = THIS.this_oBusinessObject
1336:             loc_cCod   = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
1337:             loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1338:             IF EMPTY(loc_cCod)
1339:                 THIS.AbrirLookupConta()
1340:             ELSE
1341:                 IF loc_oBO.BuscarContaPorCodigo(loc_cGrupo, loc_cCod)
1342:                     loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
1343:                     USE IN cursor_4c_BuscaConta
1344:                     THIS.PreencherCpfPorConta()
1345:                 ELSE
1346:                     loc_oCnt.txt_4c_Conta.Value  = ""
1347:                     loc_oCnt.txt_4c_Dconta.Value = ""
1348:                     loc_oCnt.txt_4c_Cpf.Value    = ""
1349:                     THIS.AbrirLookupConta()
1350:                 ENDIF
1351:             ENDIF
1352:         ENDIF
1353:     ENDPROC
1354: 
1355:     PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1356:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1357:             *-- DConta so ativa quando Conta esta vazia e Numero=0
1358:             LOCAL loc_oCnt
1359:             loc_oCnt = THIS.cnt_4c_Container1
1360:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1361:                 RETURN
1362:             ENDIF
1363:             IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
1364:                 RETURN
1365:             ENDIF
1366:             THIS.AbrirLookupConta()
1367:         ENDIF
1368:     ENDPROC
1369: 
1370:     PROCEDURE TxtCpfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1371:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1372:             *-- CPF so ativo quando Conta E Numero estao vazios
1373:             *   (When: Return Empty(Get_Conta.Value) And Empty(Get_Numero.Value))
1374:             LOCAL loc_oCnt
1375:             loc_oCnt = THIS.cnt_4c_Container1
1376:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1377:                 RETURN
1378:             ENDIF
1379:             IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
1380:                 RETURN
1381:             ENDIF
1382:             LOCAL loc_oBO, loc_cCpf
1383:             loc_oBO  = THIS.this_oBusinessObject
1384:             loc_cCpf = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)
1385:             IF EMPTY(loc_cCpf)
1386:                 RETURN
1387:             ENDIF
1388:             loc_cCpf = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
1389:             IF LEN(loc_cCpf) = 11
1390:                 loc_cCpf = LEFT(loc_cCpf, 3) + "." + SUBSTR(loc_cCpf, 4, 3) + "." + ;
1391:                            SUBSTR(loc_cCpf, 7, 3) + "-" + RIGHT(loc_cCpf, 2)
1392:             ENDIF
1393:             IF loc_oBO.BuscarClientePorCpf(loc_cCpf)
1394:                 loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCliente.iclis)
1395:                 loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCliente.rclis)
1396:                 loc_oCnt.txt_4c_Cpf.Value    = loc_cCpf
1397:                 USE IN cursor_4c_BuscaCliente
1398:             ELSE
1399:                 loc_oCnt.txt_4c_Cpf.Value = ""
1400:             ENDIF
1401:         ENDIF
1402:     ENDPROC
1403: 
1404:     PROCEDURE TxtRespsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1405:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1406:             *-- Resps so ativo quando Numero = 0 (When: Return Empty(Get_Numero.Value))
1407:             LOCAL loc_oCnt
1408:             loc_oCnt = THIS.cnt_4c_Container1
1409:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1410:                 RETURN
1411:             ENDIF
1412:             LOCAL loc_oBO, loc_cCod
1413:             loc_oBO  = THIS.this_oBusinessObject
1414:             loc_cCod = ALLTRIM(loc_oCnt.txt_4c__resps.Value)
1415:             IF EMPTY(loc_cCod)
1416:                 THIS.AbrirLookupResps()
1417:             ELSE
1418:                 IF loc_oBO.BuscarResponsavelPorCodigo(loc_cCod)
1419:                     loc_oCnt.txt_4c__dresps.Value = ALLTRIM(cursor_4c_BuscaResp.rclis)
1420:                     USE IN cursor_4c_BuscaResp
1421:                 ELSE
1422:                     loc_oCnt.txt_4c__resps.Value  = ""
1423:                     loc_oCnt.txt_4c__dresps.Value = ""
1424:                     THIS.AbrirLookupResps()
1425:                 ENDIF
1426:             ENDIF
1427:         ENDIF
1428:     ENDPROC
1429: 
1430:     PROCEDURE TxtDRespsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1431:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1432:             *-- DResps so ativo quando resps esta vazio e Numero=0
1433:             LOCAL loc_oCnt
1434:             loc_oCnt = THIS.cnt_4c_Container1
1435:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1436:                 RETURN
1437:             ENDIF
1438:             IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c__resps.Value))
1439:                 RETURN
1440:             ENDIF
1441:             THIS.AbrirLookupResps()
1442:         ENDIF
1443:     ENDPROC
1444: 
1445:     PROCEDURE TxtCdMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1446:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1447:             LOCAL loc_oCnt, loc_oBO, loc_cCod
1448:             loc_oCnt = THIS.cnt_4c_Container1
1449:             loc_oBO  = THIS.this_oBusinessObject
1450:             loc_cCod = ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value)
1451:             IF EMPTY(loc_cCod)
1452:                 THIS.AbrirLookupMoeda()
1453:             ELSE
1454:                 IF loc_oBO.BuscarMoedaPorCodigo(loc_cCod)
1455:                     loc_oCnt.txt_4c_ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1456:                     USE IN cursor_4c_BuscaMoeda
1457:                 ELSE
1458:                     loc_oCnt.txt_4c_cd_moeda.Value = ""
1459:                     loc_oCnt.txt_4c_ds_moeda.Value = ""
1460:                     THIS.AbrirLookupMoeda()
1461:                 ENDIF
1462:             ENDIF
1463:         ENDIF
1464:     ENDPROC
1465: 
1466:     PROCEDURE TxtDsMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1467:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1468:             *-- DsMoeda so ativa quando CdMoeda esta vazio
1469:             LOCAL loc_oCnt
1470:             loc_oCnt = THIS.cnt_4c_Container1
1471:             IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value))
1472:                 RETURN
1473:             ENDIF
1474:             THIS.AbrirLookupMoeda()
1475:         ENDIF
1476:     ENDPROC
1477: 
1478:     *==========================================================================
1479:     * AbrirLookup - Metodos de abertura do picker FormBuscaAuxiliar
1480:     *==========================================================================
1481: 
1482:     PROTECTED PROCEDURE AbrirLookupEmpresa()
1483:         LOCAL loc_oFrm, loc_oCnt
1484:         loc_oCnt = THIS.cnt_4c_Container1
1485:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "sigcdemp", ;
1486:                        "cursor_4c_BuscaEmp", "cemps", ;
1487:                        ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value), ;
1488:                        "Empresa")
1489:         IF VARTYPE(loc_oFrm) = "O"
1490:             loc_oFrm.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
1491:             loc_oFrm.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
1492:             loc_oFrm.Show()
1493:             IF THIS.this_lSelecionou
1494:                 loc_oCnt.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cemps)
1495:                 loc_oCnt.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.razas)
1496:                 USE IN cursor_4c_BuscaEmp
1497:             ENDIF
1498:             loc_oFrm.Release()
1499:             loc_oFrm = .NULL.
1500:         ENDIF
1501:     ENDPROC
1502: 
1503:     PROTECTED PROCEDURE AbrirLookupOperacao()
1504:         LOCAL loc_oFrm, loc_oCnt
1505:         loc_oCnt = THIS.cnt_4c_Container1
1506:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe", ;
1507:                        "cursor_4c_BuscaOpe", "Dopes", ;
1508:                        ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value), ;
1509:                        "Opera" + CHR(231) + CHR(227) + "o")
1510:         IF VARTYPE(loc_oFrm) = "O"
1511:             loc_oFrm.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1512:             loc_oFrm.Show()
1513:             IF THIS.this_lSelecionou
1514:                 loc_oCnt.txt_4c__nm_operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1515:                 USE IN cursor_4c_BuscaOpe
1516:             ENDIF
1517:             loc_oFrm.Release()
1518:             loc_oFrm = .NULL.
1519:         ENDIF
1520:     ENDPROC
1521: 
1522:     PROTECTED PROCEDURE AbrirLookupGrupo()
1523:         LOCAL loc_oFrm, loc_oCnt
1524:         loc_oCnt = THIS.cnt_4c_Container1
1525:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
1526:                        "cursor_4c_BuscaGrupo", "codigos", ;
1527:                        ALLTRIM(loc_oCnt.txt_4c_Grupo.Value), ;
1528:                        "Grupo")
1529:         IF VARTYPE(loc_oFrm) = "O"
1530:             loc_oFrm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1531:             loc_oFrm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1532:             loc_oFrm.Show()
1533:             IF THIS.this_lSelecionou
1534:                 loc_oCnt.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
1535:                 loc_oCnt.txt_4c__Dgrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
1536:                 USE IN cursor_4c_BuscaGrupo
1537:             ENDIF
1538:             loc_oFrm.Release()
1539:             loc_oFrm = .NULL.
1540:         ENDIF
1541:     ENDPROC
1542: 
1543:     PROTECTED PROCEDURE AbrirLookupConta()
1544:         LOCAL loc_oFrm, loc_oCnt, loc_cGrupo
1545:         loc_oCnt   = THIS.cnt_4c_Container1
1546:         loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1547:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1548:                        IIF(EMPTY(loc_cGrupo), "SigCdCli", ;
1549:                            "SigCdCli WHERE grupos = " + EscaparSQL(loc_cGrupo)), ;
1550:                        "cursor_4c_BuscaConta", "iclis", ;
1551:                        ALLTRIM(loc_oCnt.txt_4c_Conta.Value), ;
1552:                        "Conta")
1553:         IF VARTYPE(loc_oFrm) = "O"
1554:             loc_oFrm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1555:             loc_oFrm.mAddColuna("rclis", "", "Nome")
1556:             loc_oFrm.Show()
1557:             IF THIS.this_lSelecionou
1558:                 loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.iclis)
1559:                 loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
1560:                 USE IN cursor_4c_BuscaConta
1561:                 THIS.PreencherCpfPorConta()
1562:             ENDIF
1563:             loc_oFrm.Release()
1564:             loc_oFrm = .NULL.
1565:         ENDIF
1566:     ENDPROC
1567: 
1568:     PROTECTED PROCEDURE AbrirLookupResps()
1569:         LOCAL loc_oFrm, loc_oCnt, loc_cGrpVens
1570:         loc_oCnt    = THIS.cnt_4c_Container1
1571:         loc_cGrpVens = THIS.this_oBusinessObject.this_cGrPadVens
1572:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1573:                        IIF(EMPTY(loc_cGrpVens), "SigCdCli", ;
1574:                            "SigCdCli WHERE grupos = " + EscaparSQL(loc_cGrpVens)), ;
1575:                        "cursor_4c_BuscaResp", "iclis", ;
1576:                        ALLTRIM(loc_oCnt.txt_4c__resps.Value), ;
1577:                        "Respons" + CHR(225) + "vel")
1578:         IF VARTYPE(loc_oFrm) = "O"
1579:             loc_oFrm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1580:             loc_oFrm.mAddColuna("rclis", "", "Nome")
1581:             loc_oFrm.Show()
1582:             IF THIS.this_lSelecionou
1583:                 loc_oCnt.txt_4c__resps.Value  = ALLTRIM(cursor_4c_BuscaResp.iclis)
1584:                 loc_oCnt.txt_4c__dresps.Value = ALLTRIM(cursor_4c_BuscaResp.rclis)
1585:                 USE IN cursor_4c_BuscaResp
1586:             ENDIF
1587:             loc_oFrm.Release()
1588:             loc_oFrm = .NULL.
1589:         ENDIF
1590:     ENDPROC
1591: 
1592:     PROTECTED PROCEDURE AbrirLookupMoeda()
1593:         LOCAL loc_oFrm, loc_oCnt
1594:         loc_oCnt = THIS.cnt_4c_Container1
1595:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1596:                        "cursor_4c_BuscaMoeda", "cmoes", ;
1597:                        ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value), ;
1598:                        "Moeda")
1599:         IF VARTYPE(loc_oFrm) = "O"
1600:             loc_oFrm.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1601:             loc_oFrm.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1602:             loc_oFrm.Show()
1603:             IF THIS.this_lSelecionou
1604:                 loc_oCnt.txt_4c_cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1605:                 loc_oCnt.txt_4c_ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1606:                 USE IN cursor_4c_BuscaMoeda
1607:             ENDIF
1608:             loc_oFrm.Release()
1609:             loc_oFrm = .NULL.
1610:         ENDIF
1611:     ENDPROC
1612: 
1613:     *==========================================================================
1614:     * PreencherCpfPorConta - Consulta SigCdCli para popular campo CPF
1615:     * apos selecionar uma conta.
1616:     *==========================================================================
1617:     PROTECTED PROCEDURE PreencherCpfPorConta()
1618:         LOCAL loc_oCnt, loc_cConta, loc_cSQL, loc_nRes, loc_cCpf
1619:         loc_oCnt   = THIS.cnt_4c_Container1
1620:         loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
1621:         IF EMPTY(loc_cConta)
1622:             RETURN
1623:         ENDIF
1624:         loc_cSQL = "SELECT cpfs FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
1625:         TRY
1626:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpfTemp")
1627:             IF loc_nRes > 0 AND !EMPTY(cursor_4c_CpfTemp.cpfs)
1628:                 loc_cCpf = ALLTRIM(cursor_4c_CpfTemp.cpfs)
1629:                 loc_oCnt.txt_4c_Cpf.Value = loc_cCpf
1630:             ELSE
1631:                 loc_oCnt.txt_4c_Cpf.Value = ""
1632:             ENDIF
1633:             IF USED("cursor_4c_CpfTemp")
1634:                 USE IN cursor_4c_CpfTemp
1635:             ENDIF
1636:         CATCH TO loc_oErro
1637:             MsgErro(loc_oErro.Message, "Erro ao buscar CPF")
1638:         ENDTRY
1639:     ENDPROC
1640: 
1641:     *==========================================================================
1642:     * BtnBuscarClick - Executa consulta (acao de busca do form OPERACIONAL)
1643:     * Delega para CmgConsultarClick() - acao principal do form
1644:     *==========================================================================
1645:     PROCEDURE BtnBuscarClick()
1646:         THIS.CmgConsultarClick()
1647:     ENDPROC
1648: 
1649:     *==========================================================================
1650:     * BtnEncerrarClick - Fecha o formulario
1651:     * Delega para CmgEncerrarClick()
1652:     *==========================================================================
1653:     PROCEDURE BtnEncerrarClick()
1654:         THIS.CmgEncerrarClick()
1655:     ENDPROC
1656: 
1657:     *==========================================================================
1658:     * BtnSalvarClick - Executa consulta (sem CRUD em form OPERACIONAL)
1659:     * SIGPRES1 eh form de consulta apenas. Acao "Salvar" = disparar consulta.
1660:     *==========================================================================
1661:     PROCEDURE BtnSalvarClick()
1662:         THIS.CmgConsultarClick()
1663:     ENDPROC
1664: 
1665:     *==========================================================================
1666:     * BtnCancelarClick - Limpa todos os campos de filtro (sem CRUD)
1667:     * Em form OPERACIONAL, cancelar = limpar filtros
1668:     *==========================================================================
1669:     PROCEDURE BtnCancelarClick()
1670:         THIS.LimparCampos()
1671:     ENDPROC
1672: 
1673:     *==========================================================================
1674:     * FormParaBO - Copia valores dos controles do form para o Business Object
1675:     * Todos os campos de filtro do cnt_4c_Container1 -> propriedades do BO
1676:     *==========================================================================
1677:     PROCEDURE FormParaBO()
1678:         LOCAL loc_oCnt, loc_oBO
1679:         loc_oCnt = THIS.cnt_4c_Container1
1680:         loc_oBO  = THIS.this_oBusinessObject
1681: 
1682:         IF VARTYPE(loc_oCnt) # "O" OR VARTYPE(loc_oBO) # "O"
1683:             RETURN
1684:         ENDIF
1685: 
1686:         loc_oBO.this_cCdEmpresa    = ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value)
1687:         loc_oBO.this_cDsEmpresa    = ALLTRIM(loc_oCnt.txt_4c__ds_empresa.Value)
1688:         loc_oBO.this_dDtInicial    = loc_oCnt.txt_4c__dt_inicial.Value
1689:         loc_oBO.this_dDtFinal      = loc_oCnt.txt_4c__dt_final.Value
1690:         loc_oBO.this_nNrPeriodo    = loc_oCnt.obj_4c_Opt_nr_periodo.Value
1691:         loc_oBO.this_cNmOperacao   = ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value)
1692:         loc_oBO.this_nNumero       = loc_oCnt.txt_4c_Numero.Value
1693:         loc_oBO.this_nOp           = loc_oCnt.txt_4c_Op.Value
1694:         loc_oBO.this_cPStatus      = ALLTRIM(loc_oCnt.txt_4c_PStatus.Value)
1695:         loc_oBO.this_cGrupo        = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1696:         loc_oBO.this_cDGrupo       = ALLTRIM(loc_oCnt.txt_4c__Dgrupo.Value)
1697:         loc_oBO.this_cConta        = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
1698:         loc_oBO.this_cDConta       = ALLTRIM(loc_oCnt.txt_4c_Dconta.Value)
1699:         loc_oBO.this_cCpf          = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)
1700:         loc_oBO.this_cResps        = ALLTRIM(loc_oCnt.txt_4c__resps.Value)
1701:         loc_oBO.this_cDResps       = ALLTRIM(loc_oCnt.txt_4c__dresps.Value)
1702:         loc_oBO.this_cCdMoeda      = ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value)
1703:         loc_oBO.this_cDsMoeda      = ALLTRIM(loc_oCnt.txt_4c_ds_moeda.Value)
1704:         loc_oBO.this_nChkEmpD      = loc_oCnt.chk_4c_ChkEmpD.Value
1705:         loc_oBO.this_nOptCotacao   = loc_oCnt.obj_4c_OptCotacao.Value
1706:         loc_oBO.this_nOptPendente  = loc_oCnt.obj_4c_Opt_Pendente.Value
1707:         loc_oBO.this_nOptImpressao = loc_oCnt.obj_4c_Opt_impressao.Value
1708:     ENDPROC
1709: 
1710:     *==========================================================================
1711:     * BOParaForm - Copia propriedades do BO de volta para os controles do form
1712:     * Inverso de FormParaBO()
1713:     *==========================================================================
1714:     PROCEDURE BOParaForm()
1715:         LOCAL loc_oCnt, loc_oBO
1716:         loc_oCnt = THIS.cnt_4c_Container1
1717:         loc_oBO  = THIS.this_oBusinessObject
1718: 
1719:         IF VARTYPE(loc_oCnt) # "O" OR VARTYPE(loc_oBO) # "O"
1720:             RETURN
1721:         ENDIF
1722: 
1723:         loc_oCnt.txt_4c__cd_empresa.Value      = loc_oBO.this_cCdEmpresa
1724:         loc_oCnt.txt_4c__ds_empresa.Value      = loc_oBO.this_cDsEmpresa
1725:         loc_oCnt.txt_4c__dt_inicial.Value      = loc_oBO.this_dDtInicial
1726:         loc_oCnt.txt_4c__dt_final.Value        = loc_oBO.this_dDtFinal
1727:         loc_oCnt.obj_4c_Opt_nr_periodo.Value   = loc_oBO.this_nNrPeriodo
1728:         loc_oCnt.txt_4c__nm_operacao.Value     = loc_oBO.this_cNmOperacao
1729:         loc_oCnt.txt_4c_Numero.Value           = loc_oBO.this_nNumero
1730:         loc_oCnt.txt_4c_Op.Value               = loc_oBO.this_nOp
1731:         loc_oCnt.txt_4c_PStatus.Value          = loc_oBO.this_cPStatus
1732:         loc_oCnt.txt_4c_Grupo.Value            = loc_oBO.this_cGrupo
1733:         loc_oCnt.txt_4c__Dgrupo.Value          = loc_oBO.this_cDGrupo
1734:         loc_oCnt.txt_4c_Conta.Value            = loc_oBO.this_cConta
1735:         loc_oCnt.txt_4c_Dconta.Value           = loc_oBO.this_cDConta
1736:         loc_oCnt.txt_4c_Cpf.Value              = loc_oBO.this_cCpf
1737:         loc_oCnt.txt_4c__resps.Value           = loc_oBO.this_cResps
1738:         loc_oCnt.txt_4c__dresps.Value          = loc_oBO.this_cDResps
1739:         loc_oCnt.txt_4c_cd_moeda.Value         = loc_oBO.this_cCdMoeda
1740:         loc_oCnt.txt_4c_ds_moeda.Value         = loc_oBO.this_cDsMoeda
1741:         loc_oCnt.chk_4c_ChkEmpD.Value         = loc_oBO.this_nChkEmpD
1742:         loc_oCnt.obj_4c_OptCotacao.Value       = loc_oBO.this_nOptCotacao
1743:         loc_oCnt.obj_4c_Opt_Pendente.Value     = loc_oBO.this_nOptPendente
1744:         loc_oCnt.obj_4c_Opt_impressao.Value    = loc_oBO.this_nOptImpressao
1745:     ENDPROC
1746: 
1747:     *==========================================================================
1748:     * HabilitarCampos - Controla habilitacao dos controles
1749:     * Form OPERACIONAL: todos os campos de filtro habilitados quando par_lHabilitar=.T.
1750:     * (bloqueados durante modo RESULTADO enquanto SIGPRES2 esta aberto)
1751:     * par_lHabilitar: .T. = habilitar (default), .F. = desabilitar
1752:     *==========================================================================
1753:     PROCEDURE HabilitarCampos(par_lHabilitar)
1754:         LOCAL loc_oCnt, loc_lHab
1755:         loc_lHab = IIF(PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1756:         loc_oCnt = THIS.cnt_4c_Container1
1757: 
1758:         IF VARTYPE(loc_oCnt) # "O"
1759:             RETURN
1760:         ENDIF
1761: 
1762:         loc_oCnt.txt_4c__cd_empresa.Enabled     = loc_lHab
1763:         loc_oCnt.txt_4c__ds_empresa.Enabled     = loc_lHab
1764:         loc_oCnt.txt_4c__dt_inicial.Enabled     = loc_lHab
1765:         loc_oCnt.txt_4c__dt_final.Enabled       = loc_lHab
1766:         loc_oCnt.txt_4c__nm_operacao.Enabled    = loc_lHab
1767:         loc_oCnt.txt_4c_Numero.Enabled          = loc_lHab
1768:         loc_oCnt.txt_4c_Op.Enabled              = loc_lHab
1769:         loc_oCnt.txt_4c_PStatus.Enabled         = loc_lHab
1770:         loc_oCnt.txt_4c_Grupo.Enabled           = loc_lHab
1771:         loc_oCnt.txt_4c__Dgrupo.Enabled         = loc_lHab
1772:         loc_oCnt.txt_4c_Conta.Enabled           = loc_lHab
1773:         loc_oCnt.txt_4c_Dconta.Enabled          = loc_lHab
1774:         loc_oCnt.txt_4c_Cpf.Enabled             = loc_lHab
1775:         loc_oCnt.txt_4c__resps.Enabled          = loc_lHab
1776:         loc_oCnt.txt_4c__dresps.Enabled         = loc_lHab
1777:         loc_oCnt.txt_4c_cd_moeda.Enabled        = loc_lHab
1778:         loc_oCnt.chk_4c_ChkEmpD.Enabled        = loc_lHab
1779:         loc_oCnt.obj_4c_Opt_nr_periodo.Enabled  = loc_lHab
1780:         loc_oCnt.obj_4c_OptCotacao.Enabled      = loc_lHab
1781:         loc_oCnt.obj_4c_Opt_Pendente.Enabled    = loc_lHab
1782:         loc_oCnt.obj_4c_Opt_impressao.Enabled   = loc_lHab
1783: 
1784:         IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
1785:             THIS.cmg_4c_Sair.Buttons(1).Enabled = loc_lHab
1786:         ENDIF
1787:     ENDPROC
1788: 
1789:     *==========================================================================
1790:     * LimparCampos - Restaura todos os campos de filtro aos valores default
1791:     * Equivale ao trecho de inicializacao do Init() do legado (zeros e espacos)
1792:     *==========================================================================
1793:     PROCEDURE LimparCampos()
1794:         LOCAL loc_oCnt
1795:         loc_oCnt = THIS.cnt_4c_Container1
1796: 
1797:         IF VARTYPE(loc_oCnt) # "O"
1798:             RETURN
1799:         ENDIF
1800: 
1801:         loc_oCnt.txt_4c__cd_empresa.Value      = go_4c_Sistema.cCodEmpresa
1802:         loc_oCnt.txt_4c__ds_empresa.Value      = ""
1803:         loc_oCnt.txt_4c__nm_operacao.Value     = ""
1804:         loc_oCnt.txt_4c__dt_inicial.Value      = DATE()
1805:         loc_oCnt.txt_4c__dt_final.Value        = DATE()
1806:         loc_oCnt.txt_4c_Numero.Value           = 0
1807:         loc_oCnt.txt_4c_Op.Value               = 0
1808:         loc_oCnt.txt_4c_PStatus.Value          = ""
1809:         loc_oCnt.txt_4c_Grupo.Value            = SPACE(10)
1810:         loc_oCnt.txt_4c__Dgrupo.Value          = SPACE(20)
1811:         loc_oCnt.txt_4c_Conta.Value            = SPACE(10)
1812:         loc_oCnt.txt_4c_Dconta.Value           = SPACE(40)
1813:         loc_oCnt.txt_4c_Cpf.Value              = ""
1814:         loc_oCnt.txt_4c__resps.Value           = ""
1815:         loc_oCnt.txt_4c__dresps.Value          = ""
1816:         loc_oCnt.txt_4c_cd_moeda.Value         = ""
1817:         loc_oCnt.txt_4c_ds_moeda.Value         = ""
1818:         loc_oCnt.chk_4c_ChkEmpD.Value         = 0
1819:         loc_oCnt.obj_4c_Opt_nr_periodo.Value   = 1
1820:         loc_oCnt.obj_4c_OptCotacao.Value       = 1
1821:         loc_oCnt.obj_4c_Opt_Pendente.Value     = 3
1822:         loc_oCnt.obj_4c_Opt_impressao.Value    = 1
1823: 
1824:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1825:             THIS.this_oBusinessObject.this_cCdEmpresa   = go_4c_Sistema.cCodEmpresa
1826:             THIS.this_oBusinessObject.this_dDtInicial   = DATE()
1827:             THIS.this_oBusinessObject.this_dDtFinal     = DATE()
1828:             THIS.this_oBusinessObject.this_nOptPendente = 3
1829:         ENDIF
1830: 
1831:         loc_oCnt.txt_4c__nm_operacao.SetFocus
1832:     ENDPROC
1833: 
1834:     *==========================================================================
1835:     * CarregarLista - Satisfaz contrato do FormBase sem execucao de SQL
1836:     * SIGPRES1 eh form de filtro/criterios (sem grade de registros propria).
1837:     * Os resultados sao exibidos em SIGPRES2 aberto por CmgConsultarClick.
1838:     * Retorna .T. para indicar sucesso ao FormBase.
1839:     *==========================================================================
1840:     PROCEDURE CarregarLista()
1841:         RETURN .T.
1842:     ENDPROC
1843: 
1844:     *==========================================================================
1845:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo operacional
1846:     * "FILTRO"    -> tudo habilitado (forma padrao de uso)
1847:     * "RESULTADO" -> campos e botao Consultar desabilitados (SIGPRES2 aberto)
1848:     *==========================================================================
1849:     PROCEDURE AjustarBotoesPorModo()
1850:         LOCAL loc_lFiltro
1851:         loc_lFiltro = (THIS.this_cModoAtual == "FILTRO")
1852: 
1853:         THIS.HabilitarCampos(loc_lFiltro)
1854:     ENDPROC
1855: 
1856: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEs1BO.prg):
*==============================================================================
* SigPrEs1BO.prg - Business Object: Posicao Por Movimentacao
* Herda de: BusinessBase
* Tipo: OPERACIONAL (filtro/consulta - sem CRUD direto)
* Tabela principal: SigMvCab
*==============================================================================

DEFINE CLASS SigPrEs1BO AS BusinessBase

    *--------------------------------------------------------------------------
    * Filtros de periodo
    *--------------------------------------------------------------------------
    this_dDtInicial    = {}
    this_dDtFinal      = {}
    this_nNrPeriodo    = 1        && 1=Lancamento, 2=Prazo Entrega

    *--------------------------------------------------------------------------
    * Filtro Movimentacao / Operacao
    *--------------------------------------------------------------------------
    this_cNmOperacao   = ""       && C(20) - Nome da movimentacao (SigCdOpe.Dopes)

    *--------------------------------------------------------------------------
    * Filtros Numero / OP
    *--------------------------------------------------------------------------
    this_nNumero       = 0        && N(6,0) - Numero do lancamento (SigMvCab.numes)
    this_nOp           = 0        && N(6,0) - Numero da OP (SigMvCab.nops)

    *--------------------------------------------------------------------------
    * Filtro Status
    *--------------------------------------------------------------------------
    this_cPStatus      = ""       && C(1) - Status (SigMvCab.pstatus)

    *--------------------------------------------------------------------------
    * Filtro Grupo Contabil (SigCdGcr - origem/destino)
    *--------------------------------------------------------------------------
    this_cGrupo        = ""       && C(10) - Codigo do grupo (grupoos/grupods)
    this_cDGrupo       = ""       && C(40) - Descricao do grupo (descrs)

    *--------------------------------------------------------------------------
    * Filtro Conta / CPF/CNPJ (SigCdCli)
    *--------------------------------------------------------------------------
    this_cConta        = ""       && C(10) - Codigo da conta (contaos/contads)
    this_cDConta       = ""       && C(50) - Descricao da conta (rclis)
    this_cCpf          = ""       && C(20) - CPF/CNPJ (SigCdCli.cpfs)

    *--------------------------------------------------------------------------
    * Filtro Moeda (SigCdMoe - exibido em sigpres2, nao filtra SQL principal)
    *--------------------------------------------------------------------------
    this_cCdMoeda      = ""       && C(3)  - Codigo da moeda (cmoes)
    this_cDsMoeda      = ""       && C(15) - Descricao da moeda (dmoes)

    *--------------------------------------------------------------------------
    * Filtro Responsavel / Vendedor (SigCdCli com grupo = GrPadVens)
    *--------------------------------------------------------------------------
    this_cResps        = ""       && C(10) - Codigo do responsavel (vends)
    this_cDResps       = ""       && C(50) - Descricao do responsavel (rclis)

    *--------------------------------------------------------------------------
    * Filtro Empresa (sigcdemp)
    *--------------------------------------------------------------------------
    this_cCdEmpresa    = ""       && C(3)  - Codigo da empresa (emps)
    this_cDsEmpresa    = ""       && C(40) - Descricao da empresa (razas)
    this_nChkEmpD      = 0        && N(1)  - 0=nao filtrar Empds, 1=incluir Empds

    *--------------------------------------------------------------------------
    * OptionGroups - passados a sigpres2 para controle de exibicao/impressao
    *--------------------------------------------------------------------------
    this_nOptCotacao   = 1        && 1=Fechamento, 2=Movimentacao
    this_nOptImpressao = 1        && 1=Por Vendedor, 2=Por Movimentacao
    this_nOptPendente  = 3        && 1=Pendentes, 2=Baixadas, 3=Todas

    *--------------------------------------------------------------------------
    * Parametro operacional carregado de SigCdPam
    *--------------------------------------------------------------------------
    this_cGrPadVens    = ""       && C(10) - Grupo padrao de vendedores (grpadvens)

    *==========================================================================
    * Init - Inicializa o BO configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna identificador para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nNumero)
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega GrPadVens e demais config de SigCdPam
    * Deve ser chamado no Init() do Form apos criar o BO
    * Retorna .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 grpadvens FROM SigCdPam"

            IF USED("cursor_4c_Param")
                USE IN cursor_4c_Param
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
                IF !EOF("cursor_4c_Param")
                    SELECT cursor_4c_Param
                    THIS.this_cGrPadVens = NVL(grpadvens, "")
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Param")
                USE IN cursor_4c_Param
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar par" + CHR(226) + "metros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarFiltros - Valida campos obrigatorios antes da consulta
    * Retorna: "" se valido, mensagem de erro se invalido
    *==========================================================================
    PROCEDURE ValidarFiltros()
        LOCAL loc_cMensagem
        loc_cMensagem = ""

        IF EMPTY(THIS.this_cCdEmpresa)
            RETURN "Empresa Inv" + CHR(225) + "lida!!!"
        ENDIF

        IF EMPTY(THIS.this_cNmOperacao)
            RETURN "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!"
        ENDIF

        IF !EMPTY(THIS.this_dDtFinal) AND !EMPTY(THIS.this_dDtInicial)
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                RETURN "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! " + ;
                       "Data Final Menor do Que a Inicial!!!"
            ENDIF
        ENDIF

        RETURN loc_cMensagem
    ENDPROC

    *==========================================================================
    * ExecutarConsulta - Monta e executa consulta principal em SigMvCab
    * Popula cursor_4c_MovTemp com resultados indexados por EmpDopNums
    * Requer: this_cCdEmpresa, this_dDtInicial, this_dDtFinal validados
    * Retorna: .T. se consulta gerou ao menos 1 registro
    *==========================================================================
    PROCEDURE ExecutarConsulta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_cDtI, loc_cDtF, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cDtI = "'" + DTOC(THIS.this_dDtInicial, 1) + "'"
            loc_cDtF = "'" + DTOC(THIS.this_dDtFinal, 1) + " 23:59:59'"

            loc_cWhere = IIF(EMPTY(THIS.this_cNmOperacao), "", ;
                             "a.dopes = " + EscaparSQL(THIS.this_cNmOperacao) + " And ") + ;
                         IIF(THIS.this_nNrPeriodo = 1, "a.datas ", "a.prazoents ") + ;
                             "Between " + loc_cDtI + " And " + loc_cDtF + " And " + ;
                         IIF(EMPTY(THIS.this_cGrupo), "", ;
                             "(a.grupoos = " + EscaparSQL(THIS.this_cGrupo) + ;
                             " Or a.grupods = " + EscaparSQL(THIS.this_cGrupo) + ") And ") + ;
                         IIF(EMPTY(THIS.this_cConta), "", ;
                             "(a.contaos = " + EscaparSQL(THIS.this_cConta) + ;
                             " Or a.contads = " + EscaparSQL(THIS.this_cConta) + ") And ") + ;
                         IIF(THIS.this_nOp = 0, "", ;
                             "a.nops = " + TRANSFORM(THIS.this_nOp) + " And ") + ;
                         IIF(THIS.this_nNumero = 0, "", ;
                             "a.numes = " + TRANSFORM(THIS.this_nNumero) + " And ") + ;
                         IIF(EMPTY(THIS.this_cResps), "", ;
                             "a.vends = " + EscaparSQL(THIS.this_cResps) + " And ") + ;
                         IIF(THIS.this_nOptPendente = 1, "a.chksubn = 0 And ", ;
                             IIF(THIS.this_nOptPendente = 2, "a.chksubn = 1 And ", "")) + ;
                         IIF(EMPTY(THIS.this_cPStatus), "", ;
                             "a.pstatus = " + EscaparSQL(THIS.this_cPStatus) + " And ")

            loc_cSQL = "SELECT a.* " + ;
                       "FROM SigMvCab a, SigCdOpe b " + ;
                       "WHERE (a.emps = " + EscaparSQL(THIS.this_cCdEmpresa) + ;
                           IIF(THIS.this_nChkEmpD = 0, "", ;
                               " Or a.empds = " + EscaparSQL(THIS.this_cCdEmpresa)) + ;
                           ") And " + ;
                       loc_cWhere + ;
                       "a.dopes = b.Dopes"

            IF USED("cursor_4c_MovTemp")
                USE IN cursor_4c_MovTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovTemp") > 0
                SELECT cursor_4c_MovTemp
                IF !EOF("cursor_4c_MovTemp")
                    INDEX ON empdopnums TAG empdopnums
                    UPDATE cursor_4c_MovTemp ;
                        SET prazoents = IIF(ISNULL(prazoents), {}, prazoents)
                    GO TOP IN cursor_4c_MovTemp
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao executar consulta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarGrupoPorCodigo - Lookup SigCdGcr por codigo (equivale fAcessoContab C)
    * Popula cursor_4c_BuscaGrupo com codigos, descrs
    * Retorna .T. se encontrou exatamente 1 registro
    *==========================================================================
    PROCEDURE BuscarGrupoPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
                       "WHERE RTRIM(codigos) = RTRIM(" + EscaparSQL(par_cCodigo) + ")"

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaGrupo")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarGrupoPorDescricao - Lookup SigCdGcr por descricao (fAcessoContab D)
    * Popula cursor_4c_BuscaGrupo com codigos, descrs
    * Retorna .T. se encontrou exatamente 1 match (auto-preenche sem picker)
    *==========================================================================
    PROCEDURE BuscarGrupoPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
                       "WHERE RTRIM(descrs) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       " ORDER BY descrs"

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo") > 0
                SELECT cursor_4c_BuscaGrupo
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaGrupo")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarMoedaPorCodigo - Lookup SigCdMoe por cmoes
    * Popula cursor_4c_BuscaMoeda com cmoes, dmoes
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarMoedaPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                       "WHERE RTRIM(cmoes) = RTRIM(" + EscaparSQL(par_cCodigo) + ")"

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaMoeda")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarMoedaPorDescricao - Lookup SigCdMoe por dmoes
    * Popula cursor_4c_BuscaMoeda com cmoes, dmoes
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarMoedaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                       "WHERE RTRIM(dmoes) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       " ORDER BY dmoes"

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda") > 0
                SELECT cursor_4c_BuscaMoeda
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaMoeda")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarContaPorCodigo - Lookup SigCdCli por iclis com filtro de grupo
    * Equivale a fAcessoContas(usu, grupo, 'C', ...)
    * Popula cursor_4c_BuscaConta com iclis, rclis
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarContaPorCodigo(par_cGrupo, par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(par_cGrupo), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(par_cGrupo) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(iclis) = RTRIM(" + EscaparSQL(par_cCodigo) + ")" + ;
                       loc_cFiltroGrupo

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaConta")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar conta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarContaPorDescricao - Lookup SigCdCli por rclis com filtro de grupo
    * Equivale a fAcessoContas(usu, grupo, 'D', ...)
    * Popula cursor_4c_BuscaConta com iclis, rclis
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarContaPorDescricao(par_cGrupo, par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(par_cGrupo), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(par_cGrupo) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(rclis) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       loc_cFiltroGrupo + ;
                       " ORDER BY rclis"

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") > 0
                SELECT cursor_4c_BuscaConta
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaConta")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar conta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarResponsavelPorCodigo - Lookup vendedor/resp por iclis
    * Usa this_cGrPadVens como filtro de grupo (SigCdCli.grupos)
    * Equivale a fAcessoContas(usu, GrPadVens, 'C', ...)
    * Popula cursor_4c_BuscaResp com iclis, rclis
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarResponsavelPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(THIS.this_cGrPadVens), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(THIS.this_cGrPadVens) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(iclis) = RTRIM(" + EscaparSQL(par_cCodigo) + ")" + ;
                       loc_cFiltroGrupo

            IF USED("cursor_4c_BuscaResp")
                USE IN cursor_4c_BuscaResp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaResp") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaResp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar respons" + CHR(225) + "vel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarResponsavelPorDescricao - Lookup vendedor/resp por rclis
    * Usa this_cGrPadVens como filtro de grupo
    * Equivale a fAcessoContas(usu, GrPadVens, 'D', ...)
    * Popula cursor_4c_BuscaResp com iclis, rclis
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarResponsavelPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(THIS.this_cGrPadVens), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(THIS.this_cGrPadVens) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(rclis) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       loc_cFiltroGrupo + ;
                       " ORDER BY rclis"

            IF USED("cursor_4c_BuscaResp")
                USE IN cursor_4c_BuscaResp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaResp") > 0
                SELECT cursor_4c_BuscaResp
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaResp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar respons" + CHR(225) + "vel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarClientePorCpf - Lookup SigCdCli por cpfs (CPF/CNPJ)
    * Popula cursor_4c_BuscaCliente com iclis, rclis, cpfs
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarClientePorCpf(par_cCpf)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT iclis, rclis, cpfs FROM SIGCDCLI " + ;
                       "WHERE RTRIM(cpfs) = " + EscaparSQL(PADR(ALLTRIM(par_cCpf), 20))

            IF USED("cursor_4c_BuscaCliente")
                USE IN cursor_4c_BuscaCliente
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCliente") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaCliente")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar cliente por CPF")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarOperacaoPorNome - Valida existencia da operacao em SigCdOpe
    * Equivale a fAcessoMovmto - verifica que Dopes existe
    * Popula cursor_4c_BuscaOpe com Dopes
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarOperacaoPorNome(par_cNome)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes FROM SigCdOpe " + ;
                       "WHERE RTRIM(Dopes) = RTRIM(" + EscaparSQL(par_cNome) + ")"

            IF USED("cursor_4c_BuscaOpe")
                USE IN cursor_4c_BuscaOpe
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaOpe")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar opera" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarEmpresaPorCodigo - Lookup sigcdemp por cemps
    * Equivale a fAcessoEmpresa modo C
    * Popula cursor_4c_BuscaEmp com cemps, razas
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarEmpresaPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cemps, razas FROM sigcdemp " + ;
                       "WHERE RTRIM(cemps) = RTRIM(" + EscaparSQL(par_cCodigo) + ")"

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaEmp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar empresa")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia registro atual de cursor SigMvCab para propriedades
    * Usado quando form carrega movimentacao selecionada (double-click no grid de sigpres2)
    * par_cAliasCursor: nome do cursor com dados de SigMvCab (a.* da ExecutarConsulta)
    * Retorna .T. se mapeou com sucesso
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)

            IF EOF() OR BOF()
                loc_lSucesso = .F.
            ENDIF

            IF TYPE(par_cAliasCursor + ".emps") != "U"
                THIS.this_cCdEmpresa = NVL(emps, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".dopes") != "U"
                THIS.this_cNmOperacao = NVL(dopes, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".datas") != "U"
                THIS.this_dDtInicial = IIF(ISNULL(datas), {}, datas)
                THIS.this_dDtFinal   = IIF(ISNULL(datas), {}, datas)
            ENDIF
            IF TYPE(par_cAliasCursor + ".numes") != "U"
                THIS.this_nNumero = NVL(numes, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".nops") != "U"
                THIS.this_nOp = NVL(nops, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".pstatus") != "U"
                THIS.this_cPStatus = NVL(pstatus, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".grupoos") != "U"
                THIS.this_cGrupo = NVL(grupoos, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".contaos") != "U"
                THIS.this_cConta = NVL(contaos, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".vends") != "U"
                THIS.this_cResps = NVL(vends, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".chksubn") != "U"
                IF VARTYPE(chksubn) = "N"
                    THIS.this_nOptPendente = IIF(NVL(chksubn, 0) = 1, 2, 1)
                ELSE
                    THIS.this_nOptPendente = IIF(NVL(chksubn, .F.), 2, 1)
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar do cursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Nao suportado
    * SigPrEs1 eh form OPERACIONAL de consulta/relatorio (Posicao Por Movimentacao).
    * Os registros de SigMvCab sao criados/mantidos pelos forms de movimentacao
    * (sigcdmov e derivados). Este BO apenas consulta - retorna .F. explicitamente
    * para impedir uso indevido em vez de gravar dados inconsistentes.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        MsgAviso("Este relat" + CHR(243) + "rio de posi" + CHR(231) + CHR(227) + "o eh somente leitura. " + ;
                "Use os formul" + CHR(225) + "rios de movimenta" + CHR(231) + CHR(227) + "o para incluir registros.", ;
                "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Atualizar - Nao suportado
    * Ver comentario em Inserir(). Consultas/relatorios nao atualizam SigMvCab.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        MsgAviso("Este relat" + CHR(243) + "rio de posi" + CHR(231) + CHR(227) + "o eh somente leitura. " + ;
                "Use os formul" + CHR(225) + "rios de movimenta" + CHR(231) + CHR(227) + "o para alterar registros.", ;
                "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BuscarEmpresaPorDescricao - Lookup sigcdemp por razas
    * Equivale a fAcessoEmpresa modo D
    * Popula cursor_4c_BuscaEmp com cemps, razas
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarEmpresaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cemps, razas FROM sigcdemp " + ;
                       "WHERE RTRIM(razas) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       " ORDER BY razas"

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp") > 0
                SELECT cursor_4c_BuscaEmp
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaEmp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar empresa")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

