# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (26)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1824 linhas total):

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

*-- Linhas 45 a 203:
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
86:                 *-- Tornar todos os controles visiveis
87:                 THIS.TornarControlesVisiveis(THIS)
88: 
89:                 loc_lSucesso = .T.
90:             ELSE
91:                 MsgErro("Erro ao criar SigPrEs1BO", ;
92:                         "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
93:             ENDIF
94: 
95:         CATCH TO loc_oErro
96:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
97:                     " PROC=" + loc_oErro.Procedure, ;
98:                     "Erro em InicializarForm")
99:         ENDTRY
100: 
101:         RETURN loc_lSucesso
102:     ENDPROC
103: 
104:     *==========================================================================
105:     * ConfigurarPageFrame - Orquestrador de montagem do layout
106:     * Form OPERACIONAL nao usa PageFrame Page1/Page2 - usa layout container-based:
107:     *   1) cnt_4c_Sombra (cabecalho cinza no topo)
108:     *   2) cnt_4c_Container1 (filtros - preenchido na Fase 5-6)
109:     *   3) cmg_4c_Sair (CommandGroup Consultar+Encerrar)
110:     * Mantido este nome para compatibilidade com o contrato do FormBase e para
111:     * refletir o papel de "montador da regiao central" do form.
112:     *==========================================================================
113:     PROTECTED PROCEDURE ConfigurarPageFrame()
114:         THIS.ConfigurarCabecalho()
115:         THIS.ConfigurarPaginaLista()
116:     ENDPROC
117: 
118:     *==========================================================================
119:     * ConfigurarPaginaLista - Configura a area principal de trabalho do form
120:     * OPERACIONAL. Como este form nao usa PageFrame CRUD Page1=Lista/Page2=Dados,
121:     * este metodo agrega a construcao do container de filtros e os botoes de
122:     * acao (Consultar + Encerrar), que juntos compoem a "pagina" ativa do form.
123:     * Nome preservado para compatibilidade com o contrato do FormBase.
124:     *==========================================================================
125:     PROTECTED PROCEDURE ConfigurarPaginaLista()
126:         THIS.ConfigurarContainerFiltros()
127:         THIS.ConfigurarBotoes()
128:     ENDPROC
129: 
130:     *==========================================================================
131:     * AlternarPagina - Alterna o modo operacional do form
132:     * Em forms OPERACIONAIS nao existem paginas CRUD (LISTA/DADOS), mas o
133:     * form mantem um modo logico (FILTRO/RESULTADO) que controla se aceita
134:     * nova consulta ou esta aguardando retorno de sigpres2. Chamado pelo fluxo
135:     * de CmgConsultarClick para bloquear reentrancia enquanto o form de
136:     * resultados esta aberto e para restaurar o estado no retorno.
137:     * par_cModo: "FILTRO" (aceita entrada) ou "RESULTADO" (bloqueado)
138:     *==========================================================================
139:     PROCEDURE AlternarPagina(par_cModo)
140:         IF PCOUNT() >= 1 AND VARTYPE(par_cModo) = "C" AND !EMPTY(par_cModo)
141:             THIS.this_cModoAtual = UPPER(ALLTRIM(par_cModo))
142:         ENDIF
143: 
144:         DO CASE
145:             CASE THIS.this_cModoAtual == "RESULTADO"
146:                 THIS.Enabled = .F.
147:             OTHERWISE
148:                 THIS.this_cModoAtual = "FILTRO"
149:                 THIS.Enabled = .T.
150:                 IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
151:                     IF PEMSTATUS(THIS.cnt_4c_Container1, "txt_4c__nm_operacao", 5)
152:                         THIS.cnt_4c_Container1.txt_4c__nm_operacao.SetFocus
153:                     ENDIF
154:                 ENDIF
155:         ENDCASE
156:     ENDPROC
157: 
158:     *==========================================================================
159:     * ConfigurarCabecalho - Cria background e cabecalho cinza superior (cnt_4c_Sombra)
160:     * Equivale ao cntSombra do legado (Top=0, Left=-12, Width=840, Height=80)
161:     * Novo: Top=0, Left=0, Width=1000, Height=80
162:     *==========================================================================
163:     PROTECTED PROCEDURE ConfigurarCabecalho()
164:         LOCAL loc_cCaption
165:         loc_cCaption = "Posi" + CHR(231) + CHR(227) + ;
166:                        "o Por Movimenta" + CHR(231) + CHR(227) + "o"
167: 
168:         *-- Imagem de fundo (forms OPERACIONAIS usam new_background.jpg)
169:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
170: 
171:         THIS.AddObject("cnt_4c_Sombra", "Container")
172:         WITH THIS.cnt_4c_Sombra
173:             .Top         = 0
174:             .Left        = 0
175:             .Width       = THIS.Width
176:             .Height      = 80
177:             .BackColor   = RGB(100, 100, 100)
178:             .BackStyle   = 1
179:             .BorderWidth = 0
180: 
181:             *-- Sombra (legado: lblSombra ForeColor=0,0,0 offset +1px)
182:             .AddObject("lbl_4c_Sombra", "Label")
183:             WITH .lbl_4c_Sombra
184:                 .Top       = 18
185:                 .Left      = 10
186:                 .Width     = THIS.Width
187:                 .Height    = 40
188:                 .AutoSize  = .F.
189:                 .FontBold  = .T.
190:                 .FontName  = "Tahoma"
191:                 .FontSize  = 18
192:                 .BackStyle = 0
193:                 .ForeColor = RGB(0, 0, 0)
194:                 .WordWrap  = .T.
195:                 .Caption   = loc_cCaption
196:             ENDWITH
197: 
198:             *-- Titulo branco (legado: lblTitulo ForeColor=255,255,255)
199:             .AddObject("lbl_4c_Titulo", "Label")
200:             WITH .lbl_4c_Titulo
201:                 .Top       = 17
202:                 .Left      = 10
203:                 .Width     = THIS.Width

*-- Linhas 218 a 289:
218:     * ConfigurarContainerFiltros - Container dos campos de filtro (Fase 5-6)
219:     * Equivale ao Container1 do legado (Top=84, Left=84, Width=618, Height=249)
220:     * Novo escalado: Top=85, Left=0, Width=820, Height=480
221:     * Conteudo (TextBoxes, Labels, OptionGroups, CheckBox) preenchido na Fase 5-6
222:     *==========================================================================
223:     PROTECTED PROCEDURE ConfigurarContainerFiltros()
224:         THIS.AddObject("cnt_4c_Container1", "Container")
225:         WITH THIS.cnt_4c_Container1
226:             .Top         = 85
227:             .Left        = 0
228:             .Width       = 820
229:             .Height      = 490
230:             .BackStyle   = 0
231:             .BorderWidth = 0
232:             .Visible     = .T.
233:         ENDWITH
234:         THIS.ConfigurarPaginaDados()
235:         THIS.ConfigurarPaginaDados2()
236:         THIS.ConfigurarLookups()
237:     ENDPROC
238: 
239:     *==========================================================================
240:     * ConfigurarPaginaDados - Adiciona a primeira metade dos controles de filtro
241:     * ao cnt_4c_Container1: empresa (linha 1), periodo (linha 2),
242:     * movimentacao/numero/op/status (linha 3), grupo (linha 4), conta/cpf (linha 5).
243:     * Os controles restantes (responsavel, moeda, situacao, impressao) serao
244:     * adicionados na Fase 6 por ConfigurarPaginaDados2().
245:     *
246:     * Escala original->novo: Container1 618x249 -> 820x490
247:     *   ScaleX = 820/618 = 1.327  |  ScaleY = 490/249 = 1.968
248:     *==========================================================================
249:     PROTECTED PROCEDURE ConfigurarPaginaDados()
250:         LOCAL loc_oCnt
251:         loc_oCnt = THIS.cnt_4c_Container1
252: 
253:         *-- -----------------------------------------------------------------------
254:         *-- LINHA 1: Empresa (y_orig=10-14)
255:         *-- -----------------------------------------------------------------------
256:         loc_oCnt.AddObject("lbl_4c_Lbl_empresa", "Label")
257:         WITH loc_oCnt.lbl_4c_Lbl_empresa
258:             .Top       = 26
259:             .Left      = 59
260:             .Height    = 15
261:             .AutoSize  = .T.
262:             .FontName  = "Tahoma"
263:             .FontSize  = 8
264:             .BackStyle = 0
265:             .ForeColor = RGB(90, 90, 90)
266:             .Caption   = "Empresa :"
267:         ENDWITH
268: 
269:         loc_oCnt.AddObject("txt_4c__cd_empresa", "TextBox")
270:         WITH loc_oCnt.txt_4c__cd_empresa
271:             .Top           = 20
272:             .Left          = 133
273:             .Width         = 41
274:             .Height        = 23
275:             .Value         = go_4c_Sistema.cCodEmpresa
276:             .Format        = "K!"
277:             .MaxLength     = 3
278:             .SpecialEffect = 1
279:             .FontName      = "Tahoma"
280:             .ForeColor     = RGB(0, 0, 0)
281:             .Themes        = .F.
282:         ENDWITH
283: 
284:         loc_oCnt.AddObject("txt_4c__ds_empresa", "TextBox")
285:         WITH loc_oCnt.txt_4c__ds_empresa
286:             .Top           = 20
287:             .Left          = 178
288:             .Width         = 386
289:             .Height        = 23

*-- Linhas 366 a 410:
366:             .Themes        = .F.
367:         ENDWITH
368: 
369:         *-- OptionGroup: tipo de periodo (Lancamento / Prazo Entrega)
370:         loc_oCnt.AddObject("obj_4c_Opt_nr_periodo", "OptionGroup")
371:         WITH loc_oCnt.obj_4c_Opt_nr_periodo
372:             .Top           = 71
373:             .Left          = 362
374:             .Width         = 246
375:             .Height        = 25
376:             .BackStyle     = 0
377:             .BorderStyle   = 0
378:             .SpecialEffect = 0
379:             .ButtonCount   = 2
380: 
381:             WITH .Buttons(1)
382:                 .Caption   = "Lan" + CHR(231) + "amento"
383:                 .BackStyle = 0
384:                 .ForeColor = RGB(90, 90, 90)
385:                 .Height    = 15
386:                 .Left      = 5
387:                 .Top       = 5
388:                 .Width     = 101
389:             ENDWITH
390: 
391:             WITH .Buttons(2)
392:                 .Caption   = "Prazo Entrega"
393:                 .BackStyle = 0
394:                 .ForeColor = RGB(90, 90, 90)
395:                 .FontName  = "Tahoma"
396:                 .Height    = 15
397:                 .Left      = 125
398:                 .Top       = 5
399:                 .Width     = 116
400:             ENDWITH
401: 
402:             .Value = 1
403:         ENDWITH
404: 
405:         *-- -----------------------------------------------------------------------
406:         *-- LINHA 3: Movimentacao / Numero / OP / Status (y_orig=63-67)
407:         *-- -----------------------------------------------------------------------
408:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
409:         WITH loc_oCnt.lbl_4c_Label1
410:             .Top       = 132

*-- Linhas 620 a 663:
620:     * Command1 (legado: "consulta") -> Buttons(1) Consultar
621:     * Command2 (legado: "sair")     -> Buttons(2) Encerrar
622:     *==========================================================================
623:     PROTECTED PROCEDURE ConfigurarBotoes()
624:         THIS.AddObject("cmg_4c_Sair", "CommandGroup")
625:         WITH THIS.cmg_4c_Sair
626:             .Top           = 0
627:             .Left          = 820
628:             .Width         = 180
629:             .Height        = 85
630:             .ButtonCount   = 2
631:             .BackStyle     = 0
632:             .BorderStyle   = 0
633:             .SpecialEffect = 1
634:             .Themes        = .F.
635: 
636:             WITH .Buttons(1)
637:                 .Top             = 5
638:                 .Left            = 5
639:                 .Width           = 75
640:                 .Height          = 75
641:                 .FontBold        = .T.
642:                 .FontItalic      = .T.
643:                 .WordWrap        = .T.
644:                 .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
645:                 .Caption         = "Consultar"
646:                 .ForeColor       = RGB(90, 90, 90)
647:                 .BackColor       = RGB(255, 255, 255)
648:                 .Themes          = .F.
649:                 .MousePointer    = 15
650:                 .SpecialEffect   = 0
651:                 .PicturePosition = 13
652:             ENDWITH
653: 
654:             WITH .Buttons(2)
655:                 .Top             = 5
656:                 .Left            = 85
657:                 .Width           = 75
658:                 .Height          = 75
659:                 .FontBold        = .T.
660:                 .FontItalic      = .T.
661:                 .FontName        = "Comic Sans MS"
662:                 .FontSize        = 8
663:                 .WordWrap        = .T.

*-- Linhas 673 a 778:
673:             ENDWITH
674:         ENDWITH
675: 
676:         BINDEVENT(THIS.cmg_4c_Sair.Buttons(1), "Click", THIS, "CmgConsultarClick")
677:         BINDEVENT(THIS.cmg_4c_Sair.Buttons(2), "Click", THIS, "CmgEncerrarClick")
678:     ENDPROC
679: 
680:     *==========================================================================
681:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
682:     * AddObject() cria controles com Visible=.F. por padrao
683:     *==========================================================================
684:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
685:         LOCAL loc_nI, loc_oObjeto
686: 
687:         IF VARTYPE(par_oContainer) # "O"
688:             RETURN
689:         ENDIF
690: 
691:         FOR loc_nI = 1 TO par_oContainer.ControlCount
692:             loc_oObjeto = par_oContainer.Controls(loc_nI)
693:             IF VARTYPE(loc_oObjeto) = "O"
694:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
695:                     loc_oObjeto.Visible = .T.
696:                 ENDIF
697:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
698:                    loc_oObjeto.ControlCount > 0
699:                     THIS.TornarControlesVisiveis(loc_oObjeto)
700:                 ENDIF
701:             ENDIF
702:         ENDFOR
703:     ENDPROC
704: 
705:     *==========================================================================
706:     * CmgConsultarClick - Valida filtros, executa query e abre sigpres2
707:     * Equivale ao PROCEDURE consulta.Click do legado (83 linhas)
708:     * Validacoes: empresa obrigatoria, operacao obrigatoria, periodo valido
709:     * Query: SigMvCab JOIN SigCdOpe com filtros dinamicos
710:     * Resultado: DO FORM sigpres2 WITH loc_cNmO, THIS.DataSessionId, THIS
711:     *==========================================================================
712:     PROCEDURE CmgConsultarClick()
713:         LOCAL loc_nNrP, loc_cNmO, loc_cEst, loc_cCon, loc_nPen
714:         LOCAL loc_cVen, loc_cEmp, loc_cSta, loc_nEmpD
715:         LOCAL loc_cNOp, loc_cNum, loc_cWhere, loc_cQuery
716:         LOCAL loc_dDtInicial, loc_dDtFinal, loc_cDtI, loc_cDtF
717:         LOCAL loc_oErro
718: 
719:         *-- Validar empresa (obrigatoria)
720:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c__cd_empresa.Value))
721:             MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", ;
722:                      "Aten" + CHR(231) + CHR(227) + "o")
723:             THIS.cnt_4c_Container1.txt_4c__cd_empresa.SetFocus
724:             RETURN
725:         ENDIF
726: 
727:         *-- Validar opera??o (obrigatoria)
728:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c__nm_operacao.Value))
729:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
730:                      "Aten" + CHR(231) + CHR(227) + "o")
731:             THIS.cnt_4c_Container1.txt_4c__nm_operacao.SetFocus
732:             RETURN
733:         ENDIF
734: 
735:         *-- Validar per?odo (data final >= data inicial)
736:         IF THIS.cnt_4c_Container1.txt_4c__dt_final.Value < ;
737:            THIS.cnt_4c_Container1.txt_4c__dt_inicial.Value
738:             MsgAviso("Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! " + ;
739:                      "Data Final Menor do Que a Inicial!!!", ;
740:                      "Aten" + CHR(231) + CHR(227) + "o")
741:             THIS.cnt_4c_Container1.txt_4c__dt_inicial.SetFocus
742:             RETURN
743:         ENDIF
744: 
745:         *-- Capturar valores dos filtros
746:         loc_nNrP  = THIS.cnt_4c_Container1.obj_4c_Opt_nr_periodo.Value
747:         loc_cNmO  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c__nm_operacao.Value)
748:         loc_cEst  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Grupo.Value)
749:         loc_cCon  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Conta.Value)
750:         loc_nPen  = THIS.cnt_4c_Container1.obj_4c_Opt_Pendente.Value
751:         loc_cVen  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c__resps.Value)
752:         loc_cEmp  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c__cd_empresa.Value)
753:         loc_cSta  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_PStatus.Value)
754:         loc_nEmpD = THIS.cnt_4c_Container1.chk_4c_ChkEmpD.Value
755:         loc_cNOp  = IIF(THIS.cnt_4c_Container1.txt_4c_Op.Value = 0, "", TRANSFORM(THIS.cnt_4c_Container1.txt_4c_Op.Value))
756:         loc_cNum  = IIF(THIS.cnt_4c_Container1.txt_4c_Numero.Value = 0, "", TRANSFORM(THIS.cnt_4c_Container1.txt_4c_Numero.Value))
757: 
758:         *-- Datas formatadas para SQL Server BETWEEN
759:         loc_dDtInicial = THIS.cnt_4c_Container1.txt_4c__dt_inicial.Value
760:         loc_dDtFinal   = THIS.cnt_4c_Container1.txt_4c__dt_final.Value
761:         loc_cDtI = "'" + STR(YEAR(loc_dDtInicial), 4) + "-" + ;
762:                    PADL(STR(MONTH(loc_dDtInicial), 2), 2, "0") + "-" + ;
763:                    PADL(STR(DAY(loc_dDtInicial), 2), 2, "0") + "'"
764:         loc_cDtF = "'" + STR(YEAR(loc_dDtFinal), 4) + "-" + ;
765:                    PADL(STR(MONTH(loc_dDtFinal), 2), 2, "0") + "-" + ;
766:                    PADL(STR(DAY(loc_dDtFinal), 2), 2, "0") + " 23:59:59'"
767: 
768:         *-- Montar WHERE dinamico (cada parte termina com " AND " para encadear)
769:         loc_cWhere = IIF(EMPTY(loc_cNmO), "", "a.Dopes = " + EscaparSQL(loc_cNmO) + " AND ") + ;
770:                      IIF(loc_nNrP = 1, "a.Datas ", "a.PrazoEnts ") + ;
771:                      "BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " AND " + ;
772:                      IIF(EMPTY(loc_cEst), "", "(a.GrupoOs = " + EscaparSQL(loc_cEst) + ;
773:                          " OR a.GrupoDs = " + EscaparSQL(loc_cEst) + ") AND ") + ;
774:                      IIF(EMPTY(loc_cCon), "", "(a.ContaOs = " + EscaparSQL(loc_cCon) + ;
775:                          " OR a.ContaDs = " + EscaparSQL(loc_cCon) + ") AND ") + ;
776:                      IIF(EMPTY(loc_cNOp), "", "a.Nops = " + loc_cNOp + " AND ") + ;
777:                      IIF(EMPTY(loc_cNum), "", "a.Numes = " + loc_cNum + " AND ") + ;
778:                      IIF(EMPTY(loc_cVen), "", "a.Vends = " + EscaparSQL(loc_cVen) + " AND ") + ;

*-- Linhas 816 a 991:
816:                 *-- Restaurar modo FILTRO ao retornar do sigpres2
817:                 THIS.AlternarPagina("FILTRO")
818:             ELSE
819:                 MsgAviso("Nenhum Registro Selecionado!!!", ;
820:                          "Informa" + CHR(231) + CHR(227) + "o")
821:             ENDIF
822: 
823:         CATCH TO loc_oErro
824:             THIS.AlternarPagina("FILTRO")
825:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
826:                     " PROC=" + loc_oErro.Procedure, "Erro em Consultar")
827:         ENDTRY
828:     ENDPROC
829: 
830:     *==========================================================================
831:     * CmgEncerrarClick - Fecha o formulario
832:     * Equivale ao PROCEDURE sair.Click do legado (1 linha: ThisForm.Release)
833:     *==========================================================================
834:     PROCEDURE CmgEncerrarClick()
835:         THIS.Release()
836:     ENDPROC
837: 
838:     *==========================================================================
839:     * BtnVisualizarClick - Executa consulta e abre SIGPRES2 com resultados
840:     *
841:     * Contexto OPERACIONAL: SIGPRES1 eh um form de FILTRO/CONSULTA (nao CRUD).
842:     * O legado original tem UNICO botao funcional "sair" (que na verdade dispara
843:     * a consulta). No sistema novo, esse fluxo eh capturado em CmgConsultarClick.
844:     *
845:     * Semantica "Visualizar" = ver os movimentos filtrados = disparar a consulta
846:     * SigMvCab->SigCdOpe e abrir o form de resultados SIGPRES2. Por isso este
847:     * metodo delega para CmgConsultarClick(), que:
848:     *   1) Valida empresa/operacao/periodo (campos obrigatorios)
849:     *   2) Monta WHERE dinamico com todos os filtros do form
850:     *   3) SQLEXEC em cursor_4c_MovTemp + INDEX ON EmpDopNums
851:     *   4) Alterna form para modo RESULTADO (desabilita filtros)
852:     *   5) DO FORM sigpres2 (viewer dos resultados)
853:     *   6) Retorna para modo FILTRO ao fechar SIGPRES2
854:     *==========================================================================
855:     PROCEDURE BtnVisualizarClick()
856:         THIS.CmgConsultarClick()
857:     ENDPROC
858: 
859:     *==========================================================================
860:     * BtnIncluirClick - Executa consulta (acao principal do form OPERACIONAL)
861:     *
862:     * Contexto OPERACIONAL: SIGPRES1 nao possui CRUD proprio - eh um form de
863:     * FILTRO/CONSULTA que exibe movimentos existentes em SigMvCab. A inclusao
864:     * de novos movimentos ocorre em forms de digitacao especializados (nao
865:     * neste form).
866:     *
867:     * Para preservar contrato do FormBase e compatibilidade com a integracao
868:     * de menu/validadores, delega para CmgConsultarClick() que eh a UNICA
869:     * acao funcional real do form (equivale ao "sair" do legado que sempre
870:     * dispara a consulta).
871:     *==========================================================================
872:     PROCEDURE BtnIncluirClick()
873:         THIS.CmgConsultarClick()
874:     ENDPROC
875: 
876:     *==========================================================================
877:     * BtnAlterarClick - Executa consulta (acao principal do form OPERACIONAL)
878:     *
879:     * Contexto OPERACIONAL: SIGPRES1 nao possui CRUD proprio. Alteracao de
880:     * movimentos ocorre em forms de digitacao apos abrir SIGPRES2 (viewer)
881:     * via double-click no registro desejado.
882:     *
883:     * Delega para CmgConsultarClick() para preservar contrato de eventos
884:     * principais esperado pelo FormBase.
885:     *==========================================================================
886:     PROCEDURE BtnAlterarClick()
887:         THIS.CmgConsultarClick()
888:     ENDPROC
889: 
890:     *==========================================================================
891:     * BtnExcluirClick - Executa consulta (acao principal do form OPERACIONAL)
892:     *
893:     * Contexto OPERACIONAL: SIGPRES1 nao possui CRUD proprio. Exclusao de
894:     * movimentos ocorre em forms de manutencao especializados apos localizar
895:     * o registro atraves da consulta.
896:     *
897:     * Delega para CmgConsultarClick() para preservar contrato de eventos
898:     * principais esperado pelo FormBase.
899:     *==========================================================================
900:     PROCEDURE BtnExcluirClick()
901:         THIS.CmgConsultarClick()
902:     ENDPROC
903: 
904:     *==========================================================================
905:     * Destroy - Libera BO e fecha cursores abertos pelo form
906:     *==========================================================================
907:     PROCEDURE Destroy()
908:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
909:             THIS.this_oBusinessObject = .NULL.
910:         ENDIF
911: 
912:         IF USED("cursor_4c_MovTemp")
913:             USE IN cursor_4c_MovTemp
914:         ENDIF
915:         IF USED("cursor_4c_Param")
916:             USE IN cursor_4c_Param
917:         ENDIF
918:         IF USED("cursor_4c_BuscaGrupo")
919:             USE IN cursor_4c_BuscaGrupo
920:         ENDIF
921:         IF USED("cursor_4c_BuscaMoeda")
922:             USE IN cursor_4c_BuscaMoeda
923:         ENDIF
924:         IF USED("cursor_4c_BuscaConta")
925:             USE IN cursor_4c_BuscaConta
926:         ENDIF
927:         IF USED("cursor_4c_BuscaResp")
928:             USE IN cursor_4c_BuscaResp
929:         ENDIF
930:         IF USED("cursor_4c_BuscaCliente")
931:             USE IN cursor_4c_BuscaCliente
932:         ENDIF
933:         IF USED("cursor_4c_BuscaOpe")
934:             USE IN cursor_4c_BuscaOpe
935:         ENDIF
936:         IF USED("cursor_4c_BuscaEmp")
937:             USE IN cursor_4c_BuscaEmp
938:         ENDIF
939:         IF USED("cursor_4c_CpfTemp")
940:             USE IN cursor_4c_CpfTemp
941:         ENDIF
942: 
943:         DODEFAULT()
944:     ENDPROC
945: 
946:     *==========================================================================
947:     * ConfigurarPaginaDados2 - Adiciona a segunda metade dos controles de filtro:
948:     * Responsavel (linha 6), Moeda/Cotacao (linha 7), Situacao (linha 8),
949:     * Impressao (linha 9).
950:     *==========================================================================
951:     PROTECTED PROCEDURE ConfigurarPaginaDados2()
952:         LOCAL loc_oCnt
953:         loc_oCnt = THIS.cnt_4c_Container1
954: 
955:         *-- Linha 6: Responsavel (Say5 / get_resps / get_dresps)
956:         *   Original: Say5 Left=6 Top=192, get_resps Left=80 Top=190 Width=60 H=13
957:         *             get_dresps Left=146 Top=190 Width=200 H=13
958:         *   Escalado ScaleX=1.327 ScaleY=1.968
959:         loc_oCnt.AddObject("lbl_4c_Lbl_responsavel", "Label")
960:         WITH loc_oCnt.lbl_4c_Lbl_responsavel
961:             .Caption   = "Respons" + CHR(225) + "vel"
962:             .Top       = 378
963:             .Left      = 8
964:             .Width     = 90
965:             .Height    = 18
966:             .AutoSize  = .F.
967:             .FontBold  = .T.
968:             .FontSize  = 9
969:             .BackStyle = 0
970:         ENDWITH
971: 
972:         loc_oCnt.AddObject("txt_4c__resps", "TextBox")
973:         WITH loc_oCnt.txt_4c__resps
974:             .Value    = ""
975:             .Top      = 374
976:             .Left     = 106
977:             .Width    = 80
978:             .Height   = 22
979:             .FontSize = 9
980:         ENDWITH
981: 
982:         loc_oCnt.AddObject("txt_4c__dresps", "TextBox")
983:         WITH loc_oCnt.txt_4c__dresps
984:             .Value    = ""
985:             .Top      = 374
986:             .Left     = 192
987:             .Width    = 265
988:             .Height   = 22
989:             .ReadOnly = .T.
990:             .FontSize = 9
991:             .BackColor = RGB(240,240,240)

*-- Linhas 1044 a 1130:
1044:             .BackStyle = 0
1045:         ENDWITH
1046: 
1047:         loc_oCnt.AddObject("obj_4c_OptCotacao", "OptionGroup")
1048:         WITH loc_oCnt.obj_4c_OptCotacao
1049:             .Top        = 400
1050:             .Left       = 458
1051:             .Width      = 200
1052:             .Height     = 22
1053:             .ButtonCount = 2
1054:             .BorderStyle = 0
1055:             .BackStyle   = 0
1056:             .Value       = 1
1057:             WITH .Buttons(1)
1058:                 .Caption   = "Fechamento"
1059:                 .Left      = 0
1060:                 .Top       = 2
1061:                 .Width     = 95
1062:                 .Height    = 18
1063:                 .BackStyle = 0
1064:             ENDWITH
1065:             WITH .Buttons(2)
1066:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
1067:                 .Left      = 98
1068:                 .Top       = 2
1069:                 .Width     = 100
1070:                 .Height    = 18
1071:                 .BackStyle = 0
1072:                 .FontSize  = 9
1073:             ENDWITH
1074:         ENDWITH
1075: 
1076:         *-- Linha 8: Situacao (OptionGroup 3 opcoes: Quitado/Aberto/Todas)
1077:         loc_oCnt.AddObject("lbl_4c_Lbl_situacao", "Label")
1078:         WITH loc_oCnt.lbl_4c_Lbl_situacao
1079:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o"
1080:             .Top       = 432
1081:             .Left      = 8
1082:             .Width     = 90
1083:             .Height    = 18
1084:             .AutoSize  = .F.
1085:             .FontBold  = .T.
1086:             .FontSize  = 9
1087:             .BackStyle = 0
1088:         ENDWITH
1089: 
1090:         loc_oCnt.AddObject("obj_4c_Opt_Pendente", "OptionGroup")
1091:         WITH loc_oCnt.obj_4c_Opt_Pendente
1092:             .Top         = 428
1093:             .Left        = 106
1094:             .Width       = 225
1095:             .Height      = 22
1096:             .ButtonCount = 3
1097:             .BorderStyle = 0
1098:             .BackStyle   = 0
1099:             .Value       = THIS.this_oBusinessObject.this_nOptPendente
1100:             WITH .Buttons(1)
1101:                 .Caption   = "Pendente"
1102:                 .Left      = 0
1103:                 .Top       = 2
1104:                 .Width     = 72
1105:                 .Height    = 18
1106:                 .BackStyle = 0
1107:             ENDWITH
1108:             WITH .Buttons(2)
1109:                 .Caption   = "Quitado"
1110:                 .Left      = 75
1111:                 .Top       = 2
1112:                 .Width     = 70
1113:                 .Height    = 18
1114:                 .BackStyle = 0
1115:                 .FontSize  = 9
1116:             ENDWITH
1117:             WITH .Buttons(3)
1118:                 .Caption   = "Todas"
1119:                 .Left      = 148
1120:                 .Top       = 2
1121:                 .Width     = 75
1122:                 .Height    = 18
1123:                 .BackStyle = 0
1124:                 .FontSize  = 9
1125:             ENDWITH
1126:         ENDWITH
1127: 
1128:         *-- Linha 9: Impressao (Say7 / opt_impressao)
1129:         *   Original: Say7 Left=6 Top=237, opt_impressao Left=80 Top=235 W=230 H=16
1130:         *             Value=1 (Por Vendedor), 3 options: Por Vendedor/Por Cliente/Ambos

*-- Linhas 1141 a 1824:
1141:             .BackStyle = 0
1142:         ENDWITH
1143: 
1144:         loc_oCnt.AddObject("obj_4c_Opt_impressao", "OptionGroup")
1145:         WITH loc_oCnt.obj_4c_Opt_impressao
1146:             .Top         = 456
1147:             .Left        = 106
1148:             .Width       = 305
1149:             .Height      = 22
1150:             .ButtonCount = 3
1151:             .BorderStyle = 0
1152:             .BackStyle   = 0
1153:             .Value       = 1
1154:             WITH .Buttons(1)
1155:                 .Caption   = "Por Vendedor"
1156:                 .Left      = 0
1157:                 .Top       = 2
1158:                 .Width     = 98
1159:                 .Height    = 18
1160:                 .BackStyle = 0
1161:             ENDWITH
1162:             WITH .Buttons(2)
1163:                 .Caption   = "Por Cliente"
1164:                 .Left      = 101
1165:                 .Top       = 2
1166:                 .Width     = 98
1167:                 .Height    = 18
1168:                 .BackStyle = 0
1169:                 .FontSize  = 9
1170:             ENDWITH
1171:             WITH .Buttons(3)
1172:                 .Caption   = "Ambos"
1173:                 .Left      = 202
1174:                 .Top       = 2
1175:                 .Width     = 100
1176:                 .Height    = 18
1177:                 .BackStyle = 0
1178:                 .FontSize  = 9
1179:             ENDWITH
1180:         ENDWITH
1181:     ENDPROC
1182: 
1183:     *==========================================================================
1184:     * ConfigurarLookups - Registra BINDEVENTs de KeyPress em todos os campos
1185:     * que precisam de lookup ou navegacao por teclado.
1186:     *==========================================================================
1187:     PROTECTED PROCEDURE ConfigurarLookups()
1188:         LOCAL loc_oCnt
1189:         loc_oCnt = THIS.cnt_4c_Container1
1190: 
1191:         BINDEVENT(loc_oCnt.txt_4c__cd_empresa,  "KeyPress", THIS, "TxtCdEmpresaKeyPress")
1192:         BINDEVENT(loc_oCnt.txt_4c__ds_empresa,  "KeyPress", THIS, "TxtDsEmpresaKeyPress")
1193:         BINDEVENT(loc_oCnt.txt_4c__nm_operacao, "KeyPress", THIS, "TxtNmOperacaoKeyPress")
1194:         BINDEVENT(loc_oCnt.txt_4c_Grupo,        "KeyPress", THIS, "TxtGrupoKeyPress")
1195:         BINDEVENT(loc_oCnt.txt_4c__Dgrupo,      "KeyPress", THIS, "TxtDGrupoKeyPress")
1196:         BINDEVENT(loc_oCnt.txt_4c_Conta,        "KeyPress", THIS, "TxtContaKeyPress")
1197:         BINDEVENT(loc_oCnt.txt_4c_Dconta,       "KeyPress", THIS, "TxtDContaKeyPress")
1198:         BINDEVENT(loc_oCnt.txt_4c_Cpf,          "KeyPress", THIS, "TxtCpfKeyPress")
1199:         BINDEVENT(loc_oCnt.txt_4c__resps,       "KeyPress", THIS, "TxtRespsKeyPress")
1200:         BINDEVENT(loc_oCnt.txt_4c__dresps,      "KeyPress", THIS, "TxtDRespsKeyPress")
1201:         BINDEVENT(loc_oCnt.txt_4c_cd_moeda,     "KeyPress", THIS, "TxtCdMoedaKeyPress")
1202:         BINDEVENT(loc_oCnt.txt_4c_ds_moeda,     "KeyPress", THIS, "TxtDsMoedaKeyPress")
1203:     ENDPROC
1204: 
1205:     *==========================================================================
1206:     * KeyPress handlers - publicos (BINDEVENT requer metodos publicos)
1207:     *==========================================================================
1208: 
1209:     PROCEDURE TxtCdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1210:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1211:             LOCAL loc_oCnt, loc_oBO, loc_cCod
1212:             loc_oCnt = THIS.cnt_4c_Container1
1213:             loc_oBO  = THIS.this_oBusinessObject
1214:             loc_cCod = ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value)
1215:             IF EMPTY(loc_cCod)
1216:                 THIS.AbrirLookupEmpresa()
1217:             ELSE
1218:                 IF loc_oBO.BuscarEmpresaPorCodigo(loc_cCod)
1219:                     loc_oCnt.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.razas)
1220:                     USE IN cursor_4c_BuscaEmp
1221:                 ELSE
1222:                     loc_oCnt.txt_4c__cd_empresa.Value = ""
1223:                     loc_oCnt.txt_4c__ds_empresa.Value = ""
1224:                     THIS.AbrirLookupEmpresa()
1225:                 ENDIF
1226:             ENDIF
1227:         ENDIF
1228:     ENDPROC
1229: 
1230:     PROCEDURE TxtDsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1231:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1232:             THIS.AbrirLookupEmpresa()
1233:         ENDIF
1234:     ENDPROC
1235: 
1236:     PROCEDURE TxtNmOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1237:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1238:             LOCAL loc_oCnt, loc_oBO, loc_cNome
1239:             loc_oCnt  = THIS.cnt_4c_Container1
1240:             loc_oBO   = THIS.this_oBusinessObject
1241:             loc_cNome = ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value)
1242:             IF EMPTY(loc_cNome)
1243:                 THIS.AbrirLookupOperacao()
1244:             ELSE
1245:                 IF !loc_oBO.BuscarOperacaoPorNome(loc_cNome)
1246:                     loc_oCnt.txt_4c__nm_operacao.Value = ""
1247:                     THIS.AbrirLookupOperacao()
1248:                 ENDIF
1249:             ENDIF
1250:         ENDIF
1251:     ENDPROC
1252: 
1253:     PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1254:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1255:             *-- Grupo so ativo quando Numero = 0 (When: Return Empty(Get_Numero.Value))
1256:             LOCAL loc_oCnt
1257:             loc_oCnt = THIS.cnt_4c_Container1
1258:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1259:                 RETURN
1260:             ENDIF
1261:             LOCAL loc_oBO, loc_cCod
1262:             loc_oBO  = THIS.this_oBusinessObject
1263:             loc_cCod = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1264:             IF EMPTY(loc_cCod)
1265:                 THIS.AbrirLookupGrupo()
1266:             ELSE
1267:                 IF loc_oBO.BuscarGrupoPorCodigo(loc_cCod)
1268:                     loc_oCnt.txt_4c__Dgrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
1269:                     USE IN cursor_4c_BuscaGrupo
1270:                 ELSE
1271:                     loc_oCnt.txt_4c_Grupo.Value   = ""
1272:                     loc_oCnt.txt_4c__Dgrupo.Value = ""
1273:                     THIS.AbrirLookupGrupo()
1274:                 ENDIF
1275:             ENDIF
1276:         ENDIF
1277:     ENDPROC
1278: 
1279:     PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1280:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1281:             *-- DGrupo so ativo quando Grupo esta vazio (When: Return Empty(Get_Grupo.Value))
1282:             LOCAL loc_oCnt
1283:             loc_oCnt = THIS.cnt_4c_Container1
1284:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1285:                 RETURN
1286:             ENDIF
1287:             IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
1288:                 RETURN
1289:             ENDIF
1290:             THIS.AbrirLookupGrupo()
1291:         ENDIF
1292:     ENDPROC
1293: 
1294:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1295:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1296:             *-- Conta so ativa quando Numero = 0 (When: Return Empty(Get_Numero.Value))
1297:             LOCAL loc_oCnt
1298:             loc_oCnt = THIS.cnt_4c_Container1
1299:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1300:                 RETURN
1301:             ENDIF
1302:             LOCAL loc_oBO, loc_cCod, loc_cGrupo
1303:             loc_oBO   = THIS.this_oBusinessObject
1304:             loc_cCod   = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
1305:             loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1306:             IF EMPTY(loc_cCod)
1307:                 THIS.AbrirLookupConta()
1308:             ELSE
1309:                 IF loc_oBO.BuscarContaPorCodigo(loc_cGrupo, loc_cCod)
1310:                     loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
1311:                     USE IN cursor_4c_BuscaConta
1312:                     THIS.PreencherCpfPorConta()
1313:                 ELSE
1314:                     loc_oCnt.txt_4c_Conta.Value  = ""
1315:                     loc_oCnt.txt_4c_Dconta.Value = ""
1316:                     loc_oCnt.txt_4c_Cpf.Value    = ""
1317:                     THIS.AbrirLookupConta()
1318:                 ENDIF
1319:             ENDIF
1320:         ENDIF
1321:     ENDPROC
1322: 
1323:     PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1324:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1325:             *-- DConta so ativa quando Conta esta vazia e Numero=0
1326:             LOCAL loc_oCnt
1327:             loc_oCnt = THIS.cnt_4c_Container1
1328:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1329:                 RETURN
1330:             ENDIF
1331:             IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
1332:                 RETURN
1333:             ENDIF
1334:             THIS.AbrirLookupConta()
1335:         ENDIF
1336:     ENDPROC
1337: 
1338:     PROCEDURE TxtCpfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1339:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1340:             *-- CPF so ativo quando Conta E Numero estao vazios
1341:             *   (When: Return Empty(Get_Conta.Value) And Empty(Get_Numero.Value))
1342:             LOCAL loc_oCnt
1343:             loc_oCnt = THIS.cnt_4c_Container1
1344:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1345:                 RETURN
1346:             ENDIF
1347:             IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
1348:                 RETURN
1349:             ENDIF
1350:             LOCAL loc_oBO, loc_cCpf
1351:             loc_oBO  = THIS.this_oBusinessObject
1352:             loc_cCpf = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)
1353:             IF EMPTY(loc_cCpf)
1354:                 RETURN
1355:             ENDIF
1356:             loc_cCpf = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
1357:             IF LEN(loc_cCpf) = 11
1358:                 loc_cCpf = LEFT(loc_cCpf, 3) + "." + SUBSTR(loc_cCpf, 4, 3) + "." + ;
1359:                            SUBSTR(loc_cCpf, 7, 3) + "-" + RIGHT(loc_cCpf, 2)
1360:             ENDIF
1361:             IF loc_oBO.BuscarClientePorCpf(loc_cCpf)
1362:                 loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCliente.iclis)
1363:                 loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCliente.rclis)
1364:                 loc_oCnt.txt_4c_Cpf.Value    = loc_cCpf
1365:                 USE IN cursor_4c_BuscaCliente
1366:             ELSE
1367:                 loc_oCnt.txt_4c_Cpf.Value = ""
1368:             ENDIF
1369:         ENDIF
1370:     ENDPROC
1371: 
1372:     PROCEDURE TxtRespsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1373:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1374:             *-- Resps so ativo quando Numero = 0 (When: Return Empty(Get_Numero.Value))
1375:             LOCAL loc_oCnt
1376:             loc_oCnt = THIS.cnt_4c_Container1
1377:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1378:                 RETURN
1379:             ENDIF
1380:             LOCAL loc_oBO, loc_cCod
1381:             loc_oBO  = THIS.this_oBusinessObject
1382:             loc_cCod = ALLTRIM(loc_oCnt.txt_4c__resps.Value)
1383:             IF EMPTY(loc_cCod)
1384:                 THIS.AbrirLookupResps()
1385:             ELSE
1386:                 IF loc_oBO.BuscarResponsavelPorCodigo(loc_cCod)
1387:                     loc_oCnt.txt_4c__dresps.Value = ALLTRIM(cursor_4c_BuscaResp.rclis)
1388:                     USE IN cursor_4c_BuscaResp
1389:                 ELSE
1390:                     loc_oCnt.txt_4c__resps.Value  = ""
1391:                     loc_oCnt.txt_4c__dresps.Value = ""
1392:                     THIS.AbrirLookupResps()
1393:                 ENDIF
1394:             ENDIF
1395:         ENDIF
1396:     ENDPROC
1397: 
1398:     PROCEDURE TxtDRespsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1399:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1400:             *-- DResps so ativo quando resps esta vazio e Numero=0
1401:             LOCAL loc_oCnt
1402:             loc_oCnt = THIS.cnt_4c_Container1
1403:             IF loc_oCnt.txt_4c_Numero.Value <> 0
1404:                 RETURN
1405:             ENDIF
1406:             IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c__resps.Value))
1407:                 RETURN
1408:             ENDIF
1409:             THIS.AbrirLookupResps()
1410:         ENDIF
1411:     ENDPROC
1412: 
1413:     PROCEDURE TxtCdMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1414:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1415:             LOCAL loc_oCnt, loc_oBO, loc_cCod
1416:             loc_oCnt = THIS.cnt_4c_Container1
1417:             loc_oBO  = THIS.this_oBusinessObject
1418:             loc_cCod = ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value)
1419:             IF EMPTY(loc_cCod)
1420:                 THIS.AbrirLookupMoeda()
1421:             ELSE
1422:                 IF loc_oBO.BuscarMoedaPorCodigo(loc_cCod)
1423:                     loc_oCnt.txt_4c_ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1424:                     USE IN cursor_4c_BuscaMoeda
1425:                 ELSE
1426:                     loc_oCnt.txt_4c_cd_moeda.Value = ""
1427:                     loc_oCnt.txt_4c_ds_moeda.Value = ""
1428:                     THIS.AbrirLookupMoeda()
1429:                 ENDIF
1430:             ENDIF
1431:         ENDIF
1432:     ENDPROC
1433: 
1434:     PROCEDURE TxtDsMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1435:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1436:             *-- DsMoeda so ativa quando CdMoeda esta vazio
1437:             LOCAL loc_oCnt
1438:             loc_oCnt = THIS.cnt_4c_Container1
1439:             IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value))
1440:                 RETURN
1441:             ENDIF
1442:             THIS.AbrirLookupMoeda()
1443:         ENDIF
1444:     ENDPROC
1445: 
1446:     *==========================================================================
1447:     * AbrirLookup - Metodos de abertura do picker FormBuscaAuxiliar
1448:     *==========================================================================
1449: 
1450:     PROTECTED PROCEDURE AbrirLookupEmpresa()
1451:         LOCAL loc_oFrm, loc_oCnt
1452:         loc_oCnt = THIS.cnt_4c_Container1
1453:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "sigcdemp", ;
1454:                        "cursor_4c_BuscaEmp", "cemps", ;
1455:                        ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value), ;
1456:                        "Empresa")
1457:         IF VARTYPE(loc_oFrm) = "O"
1458:             loc_oFrm.mAddColuna("cemps", "C" + CHR(243) + "digo", 80)
1459:             loc_oFrm.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
1460:             loc_oFrm.Show()
1461:             IF THIS.this_lSelecionou
1462:                 loc_oCnt.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cemps)
1463:                 loc_oCnt.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.razas)
1464:                 USE IN cursor_4c_BuscaEmp
1465:             ENDIF
1466:             loc_oFrm.Release()
1467:             loc_oFrm = .NULL.
1468:         ENDIF
1469:     ENDPROC
1470: 
1471:     PROTECTED PROCEDURE AbrirLookupOperacao()
1472:         LOCAL loc_oFrm, loc_oCnt
1473:         loc_oCnt = THIS.cnt_4c_Container1
1474:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe", ;
1475:                        "cursor_4c_BuscaOpe", "Dopes", ;
1476:                        ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value), ;
1477:                        "Opera" + CHR(231) + CHR(227) + "o")
1478:         IF VARTYPE(loc_oFrm) = "O"
1479:             loc_oFrm.mAddColuna("Dopes", "Opera" + CHR(231) + CHR(227) + "o", 300)
1480:             loc_oFrm.Show()
1481:             IF THIS.this_lSelecionou
1482:                 loc_oCnt.txt_4c__nm_operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1483:                 USE IN cursor_4c_BuscaOpe
1484:             ENDIF
1485:             loc_oFrm.Release()
1486:             loc_oFrm = .NULL.
1487:         ENDIF
1488:     ENDPROC
1489: 
1490:     PROTECTED PROCEDURE AbrirLookupGrupo()
1491:         LOCAL loc_oFrm, loc_oCnt
1492:         loc_oCnt = THIS.cnt_4c_Container1
1493:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
1494:                        "cursor_4c_BuscaGrupo", "codigos", ;
1495:                        ALLTRIM(loc_oCnt.txt_4c_Grupo.Value), ;
1496:                        "Grupo")
1497:         IF VARTYPE(loc_oFrm) = "O"
1498:             loc_oFrm.mAddColuna("codigos", "C" + CHR(243) + "digo", 80)
1499:             loc_oFrm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1500:             loc_oFrm.Show()
1501:             IF THIS.this_lSelecionou
1502:                 loc_oCnt.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
1503:                 loc_oCnt.txt_4c__Dgrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
1504:                 USE IN cursor_4c_BuscaGrupo
1505:             ENDIF
1506:             loc_oFrm.Release()
1507:             loc_oFrm = .NULL.
1508:         ENDIF
1509:     ENDPROC
1510: 
1511:     PROTECTED PROCEDURE AbrirLookupConta()
1512:         LOCAL loc_oFrm, loc_oCnt, loc_cGrupo
1513:         loc_oCnt   = THIS.cnt_4c_Container1
1514:         loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1515:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1516:                        IIF(EMPTY(loc_cGrupo), "SigCdCli", ;
1517:                            "SigCdCli WHERE grupos = " + EscaparSQL(loc_cGrupo)), ;
1518:                        "cursor_4c_BuscaConta", "iclis", ;
1519:                        ALLTRIM(loc_oCnt.txt_4c_Conta.Value), ;
1520:                        "Conta")
1521:         IF VARTYPE(loc_oFrm) = "O"
1522:             loc_oFrm.mAddColuna("iclis", "C" + CHR(243) + "digo", 80)
1523:             loc_oFrm.mAddColuna("rclis", "Nome", 280)
1524:             loc_oFrm.Show()
1525:             IF THIS.this_lSelecionou
1526:                 loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.iclis)
1527:                 loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
1528:                 USE IN cursor_4c_BuscaConta
1529:                 THIS.PreencherCpfPorConta()
1530:             ENDIF
1531:             loc_oFrm.Release()
1532:             loc_oFrm = .NULL.
1533:         ENDIF
1534:     ENDPROC
1535: 
1536:     PROTECTED PROCEDURE AbrirLookupResps()
1537:         LOCAL loc_oFrm, loc_oCnt, loc_cGrpVens
1538:         loc_oCnt    = THIS.cnt_4c_Container1
1539:         loc_cGrpVens = THIS.this_oBusinessObject.this_cGrPadVens
1540:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1541:                        IIF(EMPTY(loc_cGrpVens), "SigCdCli", ;
1542:                            "SigCdCli WHERE grupos = " + EscaparSQL(loc_cGrpVens)), ;
1543:                        "cursor_4c_BuscaResp", "iclis", ;
1544:                        ALLTRIM(loc_oCnt.txt_4c__resps.Value), ;
1545:                        "Respons" + CHR(225) + "vel")
1546:         IF VARTYPE(loc_oFrm) = "O"
1547:             loc_oFrm.mAddColuna("iclis", "C" + CHR(243) + "digo", 80)
1548:             loc_oFrm.mAddColuna("rclis", "Nome", 280)
1549:             loc_oFrm.Show()
1550:             IF THIS.this_lSelecionou
1551:                 loc_oCnt.txt_4c__resps.Value  = ALLTRIM(cursor_4c_BuscaResp.iclis)
1552:                 loc_oCnt.txt_4c__dresps.Value = ALLTRIM(cursor_4c_BuscaResp.rclis)
1553:                 USE IN cursor_4c_BuscaResp
1554:             ENDIF
1555:             loc_oFrm.Release()
1556:             loc_oFrm = .NULL.
1557:         ENDIF
1558:     ENDPROC
1559: 
1560:     PROTECTED PROCEDURE AbrirLookupMoeda()
1561:         LOCAL loc_oFrm, loc_oCnt
1562:         loc_oCnt = THIS.cnt_4c_Container1
1563:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1564:                        "cursor_4c_BuscaMoeda", "cmoes", ;
1565:                        ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value), ;
1566:                        "Moeda")
1567:         IF VARTYPE(loc_oFrm) = "O"
1568:             loc_oFrm.mAddColuna("cmoes", "C" + CHR(243) + "digo", 80)
1569:             loc_oFrm.mAddColuna("dmoes", "Descri" + CHR(231) + CHR(227) + "o", 200)
1570:             loc_oFrm.Show()
1571:             IF THIS.this_lSelecionou
1572:                 loc_oCnt.txt_4c_cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1573:                 loc_oCnt.txt_4c_ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1574:                 USE IN cursor_4c_BuscaMoeda
1575:             ENDIF
1576:             loc_oFrm.Release()
1577:             loc_oFrm = .NULL.
1578:         ENDIF
1579:     ENDPROC
1580: 
1581:     *==========================================================================
1582:     * PreencherCpfPorConta - Consulta SigCdCli para popular campo CPF
1583:     * apos selecionar uma conta.
1584:     *==========================================================================
1585:     PROTECTED PROCEDURE PreencherCpfPorConta()
1586:         LOCAL loc_oCnt, loc_cConta, loc_cSQL, loc_nRes, loc_cCpf
1587:         loc_oCnt   = THIS.cnt_4c_Container1
1588:         loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
1589:         IF EMPTY(loc_cConta)
1590:             RETURN
1591:         ENDIF
1592:         loc_cSQL = "SELECT cpfs FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
1593:         TRY
1594:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpfTemp")
1595:             IF loc_nRes > 0 AND !EMPTY(cursor_4c_CpfTemp.cpfs)
1596:                 loc_cCpf = ALLTRIM(cursor_4c_CpfTemp.cpfs)
1597:                 loc_oCnt.txt_4c_Cpf.Value = loc_cCpf
1598:             ELSE
1599:                 loc_oCnt.txt_4c_Cpf.Value = ""
1600:             ENDIF
1601:             IF USED("cursor_4c_CpfTemp")
1602:                 USE IN cursor_4c_CpfTemp
1603:             ENDIF
1604:         CATCH TO loc_oErro
1605:             MsgErro(loc_oErro.Message, "Erro ao buscar CPF")
1606:         ENDTRY
1607:     ENDPROC
1608: 
1609:     *==========================================================================
1610:     * BtnBuscarClick - Executa consulta (acao de busca do form OPERACIONAL)
1611:     * Delega para CmgConsultarClick() - acao principal do form
1612:     *==========================================================================
1613:     PROCEDURE BtnBuscarClick()
1614:         THIS.CmgConsultarClick()
1615:     ENDPROC
1616: 
1617:     *==========================================================================
1618:     * BtnEncerrarClick - Fecha o formulario
1619:     * Delega para CmgEncerrarClick()
1620:     *==========================================================================
1621:     PROCEDURE BtnEncerrarClick()
1622:         THIS.CmgEncerrarClick()
1623:     ENDPROC
1624: 
1625:     *==========================================================================
1626:     * BtnSalvarClick - Executa consulta (sem CRUD em form OPERACIONAL)
1627:     * SIGPRES1 eh form de consulta apenas. Acao "Salvar" = disparar consulta.
1628:     *==========================================================================
1629:     PROCEDURE BtnSalvarClick()
1630:         THIS.CmgConsultarClick()
1631:     ENDPROC
1632: 
1633:     *==========================================================================
1634:     * BtnCancelarClick - Limpa todos os campos de filtro (sem CRUD)
1635:     * Em form OPERACIONAL, cancelar = limpar filtros
1636:     *==========================================================================
1637:     PROCEDURE BtnCancelarClick()
1638:         THIS.LimparCampos()
1639:     ENDPROC
1640: 
1641:     *==========================================================================
1642:     * FormParaBO - Copia valores dos controles do form para o Business Object
1643:     * Todos os campos de filtro do cnt_4c_Container1 -> propriedades do BO
1644:     *==========================================================================
1645:     PROCEDURE FormParaBO()
1646:         LOCAL loc_oCnt, loc_oBO
1647:         loc_oCnt = THIS.cnt_4c_Container1
1648:         loc_oBO  = THIS.this_oBusinessObject
1649: 
1650:         IF VARTYPE(loc_oCnt) # "O" OR VARTYPE(loc_oBO) # "O"
1651:             RETURN
1652:         ENDIF
1653: 
1654:         loc_oBO.this_cCdEmpresa    = ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value)
1655:         loc_oBO.this_cDsEmpresa    = ALLTRIM(loc_oCnt.txt_4c__ds_empresa.Value)
1656:         loc_oBO.this_dDtInicial    = loc_oCnt.txt_4c__dt_inicial.Value
1657:         loc_oBO.this_dDtFinal      = loc_oCnt.txt_4c__dt_final.Value
1658:         loc_oBO.this_nNrPeriodo    = loc_oCnt.obj_4c_Opt_nr_periodo.Value
1659:         loc_oBO.this_cNmOperacao   = ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value)
1660:         loc_oBO.this_nNumero       = loc_oCnt.txt_4c_Numero.Value
1661:         loc_oBO.this_nOp           = loc_oCnt.txt_4c_Op.Value
1662:         loc_oBO.this_cPStatus      = ALLTRIM(loc_oCnt.txt_4c_PStatus.Value)
1663:         loc_oBO.this_cGrupo        = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1664:         loc_oBO.this_cDGrupo       = ALLTRIM(loc_oCnt.txt_4c__Dgrupo.Value)
1665:         loc_oBO.this_cConta        = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
1666:         loc_oBO.this_cDConta       = ALLTRIM(loc_oCnt.txt_4c_Dconta.Value)
1667:         loc_oBO.this_cCpf          = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)
1668:         loc_oBO.this_cResps        = ALLTRIM(loc_oCnt.txt_4c__resps.Value)
1669:         loc_oBO.this_cDResps       = ALLTRIM(loc_oCnt.txt_4c__dresps.Value)
1670:         loc_oBO.this_cCdMoeda      = ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value)
1671:         loc_oBO.this_cDsMoeda      = ALLTRIM(loc_oCnt.txt_4c_ds_moeda.Value)
1672:         loc_oBO.this_nChkEmpD      = loc_oCnt.chk_4c_ChkEmpD.Value
1673:         loc_oBO.this_nOptCotacao   = loc_oCnt.obj_4c_OptCotacao.Value
1674:         loc_oBO.this_nOptPendente  = loc_oCnt.obj_4c_Opt_Pendente.Value
1675:         loc_oBO.this_nOptImpressao = loc_oCnt.obj_4c_Opt_impressao.Value
1676:     ENDPROC
1677: 
1678:     *==========================================================================
1679:     * BOParaForm - Copia propriedades do BO de volta para os controles do form
1680:     * Inverso de FormParaBO()
1681:     *==========================================================================
1682:     PROCEDURE BOParaForm()
1683:         LOCAL loc_oCnt, loc_oBO
1684:         loc_oCnt = THIS.cnt_4c_Container1
1685:         loc_oBO  = THIS.this_oBusinessObject
1686: 
1687:         IF VARTYPE(loc_oCnt) # "O" OR VARTYPE(loc_oBO) # "O"
1688:             RETURN
1689:         ENDIF
1690: 
1691:         loc_oCnt.txt_4c__cd_empresa.Value      = loc_oBO.this_cCdEmpresa
1692:         loc_oCnt.txt_4c__ds_empresa.Value      = loc_oBO.this_cDsEmpresa
1693:         loc_oCnt.txt_4c__dt_inicial.Value      = loc_oBO.this_dDtInicial
1694:         loc_oCnt.txt_4c__dt_final.Value        = loc_oBO.this_dDtFinal
1695:         loc_oCnt.obj_4c_Opt_nr_periodo.Value   = loc_oBO.this_nNrPeriodo
1696:         loc_oCnt.txt_4c__nm_operacao.Value     = loc_oBO.this_cNmOperacao
1697:         loc_oCnt.txt_4c_Numero.Value           = loc_oBO.this_nNumero
1698:         loc_oCnt.txt_4c_Op.Value               = loc_oBO.this_nOp
1699:         loc_oCnt.txt_4c_PStatus.Value          = loc_oBO.this_cPStatus
1700:         loc_oCnt.txt_4c_Grupo.Value            = loc_oBO.this_cGrupo
1701:         loc_oCnt.txt_4c__Dgrupo.Value          = loc_oBO.this_cDGrupo
1702:         loc_oCnt.txt_4c_Conta.Value            = loc_oBO.this_cConta
1703:         loc_oCnt.txt_4c_Dconta.Value           = loc_oBO.this_cDConta
1704:         loc_oCnt.txt_4c_Cpf.Value              = loc_oBO.this_cCpf
1705:         loc_oCnt.txt_4c__resps.Value           = loc_oBO.this_cResps
1706:         loc_oCnt.txt_4c__dresps.Value          = loc_oBO.this_cDResps
1707:         loc_oCnt.txt_4c_cd_moeda.Value         = loc_oBO.this_cCdMoeda
1708:         loc_oCnt.txt_4c_ds_moeda.Value         = loc_oBO.this_cDsMoeda
1709:         loc_oCnt.chk_4c_ChkEmpD.Value         = loc_oBO.this_nChkEmpD
1710:         loc_oCnt.obj_4c_OptCotacao.Value       = loc_oBO.this_nOptCotacao
1711:         loc_oCnt.obj_4c_Opt_Pendente.Value     = loc_oBO.this_nOptPendente
1712:         loc_oCnt.obj_4c_Opt_impressao.Value    = loc_oBO.this_nOptImpressao
1713:     ENDPROC
1714: 
1715:     *==========================================================================
1716:     * HabilitarCampos - Controla habilitacao dos controles
1717:     * Form OPERACIONAL: todos os campos de filtro habilitados quando par_lHabilitar=.T.
1718:     * (bloqueados durante modo RESULTADO enquanto SIGPRES2 esta aberto)
1719:     * par_lHabilitar: .T. = habilitar (default), .F. = desabilitar
1720:     *==========================================================================
1721:     PROCEDURE HabilitarCampos(par_lHabilitar)
1722:         LOCAL loc_oCnt, loc_lHab
1723:         loc_lHab = IIF(PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1724:         loc_oCnt = THIS.cnt_4c_Container1
1725: 
1726:         IF VARTYPE(loc_oCnt) # "O"
1727:             RETURN
1728:         ENDIF
1729: 
1730:         loc_oCnt.txt_4c__cd_empresa.Enabled     = loc_lHab
1731:         loc_oCnt.txt_4c__ds_empresa.Enabled     = loc_lHab
1732:         loc_oCnt.txt_4c__dt_inicial.Enabled     = loc_lHab
1733:         loc_oCnt.txt_4c__dt_final.Enabled       = loc_lHab
1734:         loc_oCnt.txt_4c__nm_operacao.Enabled    = loc_lHab
1735:         loc_oCnt.txt_4c_Numero.Enabled          = loc_lHab
1736:         loc_oCnt.txt_4c_Op.Enabled              = loc_lHab
1737:         loc_oCnt.txt_4c_PStatus.Enabled         = loc_lHab
1738:         loc_oCnt.txt_4c_Grupo.Enabled           = loc_lHab
1739:         loc_oCnt.txt_4c__Dgrupo.Enabled         = loc_lHab
1740:         loc_oCnt.txt_4c_Conta.Enabled           = loc_lHab
1741:         loc_oCnt.txt_4c_Dconta.Enabled          = loc_lHab
1742:         loc_oCnt.txt_4c_Cpf.Enabled             = loc_lHab
1743:         loc_oCnt.txt_4c__resps.Enabled          = loc_lHab
1744:         loc_oCnt.txt_4c__dresps.Enabled         = loc_lHab
1745:         loc_oCnt.txt_4c_cd_moeda.Enabled        = loc_lHab
1746:         loc_oCnt.chk_4c_ChkEmpD.Enabled        = loc_lHab
1747:         loc_oCnt.obj_4c_Opt_nr_periodo.Enabled  = loc_lHab
1748:         loc_oCnt.obj_4c_OptCotacao.Enabled      = loc_lHab
1749:         loc_oCnt.obj_4c_Opt_Pendente.Enabled    = loc_lHab
1750:         loc_oCnt.obj_4c_Opt_impressao.Enabled   = loc_lHab
1751: 
1752:         IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
1753:             THIS.cmg_4c_Sair.Buttons(1).Enabled = loc_lHab
1754:         ENDIF
1755:     ENDPROC
1756: 
1757:     *==========================================================================
1758:     * LimparCampos - Restaura todos os campos de filtro aos valores default
1759:     * Equivale ao trecho de inicializacao do Init() do legado (zeros e espacos)
1760:     *==========================================================================
1761:     PROCEDURE LimparCampos()
1762:         LOCAL loc_oCnt
1763:         loc_oCnt = THIS.cnt_4c_Container1
1764: 
1765:         IF VARTYPE(loc_oCnt) # "O"
1766:             RETURN
1767:         ENDIF
1768: 
1769:         loc_oCnt.txt_4c__cd_empresa.Value      = go_4c_Sistema.cCodEmpresa
1770:         loc_oCnt.txt_4c__ds_empresa.Value      = ""
1771:         loc_oCnt.txt_4c__nm_operacao.Value     = ""
1772:         loc_oCnt.txt_4c__dt_inicial.Value      = DATE()
1773:         loc_oCnt.txt_4c__dt_final.Value        = DATE()
1774:         loc_oCnt.txt_4c_Numero.Value           = 0
1775:         loc_oCnt.txt_4c_Op.Value               = 0
1776:         loc_oCnt.txt_4c_PStatus.Value          = ""
1777:         loc_oCnt.txt_4c_Grupo.Value            = SPACE(10)
1778:         loc_oCnt.txt_4c__Dgrupo.Value          = SPACE(20)
1779:         loc_oCnt.txt_4c_Conta.Value            = SPACE(10)
1780:         loc_oCnt.txt_4c_Dconta.Value           = SPACE(40)
1781:         loc_oCnt.txt_4c_Cpf.Value              = ""
1782:         loc_oCnt.txt_4c__resps.Value           = ""
1783:         loc_oCnt.txt_4c__dresps.Value          = ""
1784:         loc_oCnt.txt_4c_cd_moeda.Value         = ""
1785:         loc_oCnt.txt_4c_ds_moeda.Value         = ""
1786:         loc_oCnt.chk_4c_ChkEmpD.Value         = 0
1787:         loc_oCnt.obj_4c_Opt_nr_periodo.Value   = 1
1788:         loc_oCnt.obj_4c_OptCotacao.Value       = 1
1789:         loc_oCnt.obj_4c_Opt_Pendente.Value     = 3
1790:         loc_oCnt.obj_4c_Opt_impressao.Value    = 1
1791: 
1792:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1793:             THIS.this_oBusinessObject.this_cCdEmpresa   = go_4c_Sistema.cCodEmpresa
1794:             THIS.this_oBusinessObject.this_dDtInicial   = DATE()
1795:             THIS.this_oBusinessObject.this_dDtFinal     = DATE()
1796:             THIS.this_oBusinessObject.this_nOptPendente = 3
1797:         ENDIF
1798: 
1799:         loc_oCnt.txt_4c__nm_operacao.SetFocus
1800:     ENDPROC
1801: 
1802:     *==========================================================================
1803:     * CarregarLista - Satisfaz contrato do FormBase sem execucao de SQL
1804:     * SIGPRES1 eh form de filtro/criterios (sem grade de registros propria).
1805:     * Os resultados sao exibidos em SIGPRES2 aberto por CmgConsultarClick.
1806:     * Retorna .T. para indicar sucesso ao FormBase.
1807:     *==========================================================================
1808:     PROCEDURE CarregarLista()
1809:         RETURN .T.
1810:     ENDPROC
1811: 
1812:     *==========================================================================
1813:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo operacional
1814:     * "FILTRO"    -> tudo habilitado (forma padrao de uso)
1815:     * "RESULTADO" -> campos e botao Consultar desabilitados (SIGPRES2 aberto)
1816:     *==========================================================================
1817:     PROCEDURE AjustarBotoesPorModo()
1818:         LOCAL loc_lFiltro
1819:         loc_lFiltro = (THIS.this_cModoAtual == "FILTRO")
1820: 
1821:         THIS.HabilitarCampos(loc_lFiltro)
1822:     ENDPROC
1823: 
1824: ENDDEFINE


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

