# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprico.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (717 linhas total):

*-- Linhas 37 a 149:
37:     *============================================================================
38:     * Init - Inicializa o formulario via FormBase
39:     *============================================================================
40:     PROCEDURE Init()
41:         RETURN DODEFAULT()
42:     ENDPROC
43: 
44:     *============================================================================
45:     * InicializarForm - Cria BO, configura PageFrame e prepara o formulario
46:     *============================================================================
47:     PROTECTED PROCEDURE InicializarForm()
48:         LOCAL loc_lSucesso, loc_oErro
49:         loc_lSucesso = .F.
50: 
51:         TRY
52:             THIS.this_oBusinessObject = CREATEOBJECT("sigpricoBO")
53: 
54:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
55:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigpricoBO", "Erro")
56:             ELSE
57:                 THIS.ConfigurarPageFrame()
58:                 THIS.ConfigurarContainersPrincipais()
59:                 THIS.ConfigurarPaginaLista()
60:                 THIS.ConfigurarPaginaDados()
61: 
62:                 THIS.pgf_4c_Paginas.Visible    = .T.
63:                 THIS.pgf_4c_Paginas.ActivePage = 1
64:                 THIS.this_cModoAtual           = "VISUAL"
65: 
66:                 THIS.TornarControlesVisiveis(THIS)
67: 
68:                 loc_lSucesso = .T.
69:             ENDIF
70:         CATCH TO loc_oErro
71:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
72:                     " PROC=" + loc_oErro.Procedure, "Erro")
73:         ENDTRY
74: 
75:         RETURN loc_lSucesso
76:     ENDPROC
77: 
78:     *============================================================================
79:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
80:     * PageFrame.Top = -29 e Tabs = .F. seguindo padrao do framework
81:     *============================================================================
82:     PROTECTED PROCEDURE ConfigurarPageFrame()
83:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
84: 
85:         WITH THIS.pgf_4c_Paginas
86:             .Top        = -29
87:             .Left       = 0
88:             .Width      = THIS.Width
89:             .Height     = THIS.Height + 29
90:             .PageCount  = 2
91:             .Tabs       = .F.
92:             .BorderWidth = 0
93:             .Themes     = .F.
94:             .Visible    = .F.
95: 
96:             .Page1.Caption = "Lista"
97:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98: 
99:             .Page2.Caption = "Dados"
100:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:         ENDWITH
102:     ENDPROC
103: 
104:     *============================================================================
105:     * ConfigurarContainersPrincipais - Cria containers vazios das 2 paginas
106:     * Estes containers sao populados nas fases seguintes (Grid, botoes CRUD,
107:     * campos de dados, etc)
108:     *============================================================================
109:     PROTECTED PROCEDURE ConfigurarContainersPrincipais()
110:         LOCAL loc_oPag1, loc_oPag2
111: 
112:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
113: 
114:         *-- Container do cabecalho escuro (topo da pagina Lista)
115:         loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
116:         WITH loc_oPag1.cnt_4c_Cabecalho
117:             .Top         = 31
118:             .Left        = 0
119:             .Width       = THIS.Width
120:             .Height      = 80
121:             .BackStyle   = 1
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         *-- Container dos botoes CRUD (lado direito, sera populado na Fase 4)
128:         loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
129:         WITH loc_oPag1.cnt_4c_Botoes
130:             .Top         = 29
131:             .Left        = 542
132:             .Width       = 390
133:             .Height      = 85
134:             .BackStyle   = 1
135:             .BackColor   = RGB(53, 53, 53)
136:             .BorderWidth = 0
137:             .Visible     = .T.
138:         ENDWITH
139: 
140:         *-- Container de Saida/Encerrar (padrao canonico)
141:         loc_oPag1.AddObject("cnt_4c_Saida", "Container")
142:         WITH loc_oPag1.cnt_4c_Saida
143:             .Top         = 29
144:             .Left        = 917
145:             .Width       = 90
146:             .Height      = 85
147:             .BackStyle   = 0
148:             .BorderWidth = 0
149:             .Visible     = .T.

*-- Linhas 165 a 240:
165:     ENDPROC
166: 
167:     *============================================================================
168:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
169:     * Percorre Pages de PageFrames e Controls de Containers
170:     *============================================================================
171:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
172:         LOCAL loc_nI, loc_nP, loc_oControl
173: 
174:         FOR loc_nI = 1 TO par_oContainer.ControlCount
175:             loc_oControl = par_oContainer.Controls(loc_nI)
176: 
177:             IF VARTYPE(loc_oControl) = "O"
178:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
179:                     loc_oControl.Visible = .T.
180:                 ENDIF
181: 
182:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
183:                     FOR loc_nP = 1 TO loc_oControl.PageCount
184:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
185:                     ENDFOR
186:                 ENDIF
187: 
188:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
189:                    loc_oControl.ControlCount > 0
190:                     THIS.TornarControlesVisiveis(loc_oControl)
191:                 ENDIF
192:             ENDIF
193:         ENDFOR
194:     ENDPROC
195: 
196:     *============================================================================
197:     * ConfigurarPaginaLista - Popula Page1 com cabecalho, botao Encerrar e
198:     * as 27 imagens do mapa visual (diagrama de icones do sistema)
199:     *============================================================================
200:     PROTECTED PROCEDURE ConfigurarPaginaLista()
201:         LOCAL loc_oPag1, loc_nL, loc_nT
202: 
203:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
204:         loc_nL    = 371
205:         loc_nT    = 257
206: 
207:         *-- Labels do cabecalho (sombra deslocada + titulo branco)
208:         WITH loc_oPag1.cnt_4c_Cabecalho
209:             .AddObject("lbl_4c_Sombra", "Label")
210:             WITH .lbl_4c_Sombra
211:                 .Top       = 15
212:                 .Left      = 12
213:                 .Width     = 769
214:                 .Height    = 40
215:                 .AutoSize  = .F.
216:                 .Caption   = "Mapa Visual"
217:                 .FontName  = "Tahoma"
218:                 .FontSize  = 16
219:                 .FontBold  = .T.
220:                 .ForeColor = RGB(0, 0, 0)
221:                 .BackStyle = 0
222:             ENDWITH
223: 
224:             .AddObject("lbl_4c_Titulo", "Label")
225:             WITH .lbl_4c_Titulo
226:                 .Top       = 18
227:                 .Left      = 10
228:                 .Width     = 769
229:                 .Height    = 46
230:                 .AutoSize  = .F.
231:                 .Caption   = "Mapa Visual"
232:                 .FontName  = "Tahoma"
233:                 .FontSize  = 16
234:                 .FontBold  = .T.
235:                 .ForeColor = RGB(255, 255, 255)
236:                 .BackStyle = 0
237:             ENDWITH
238:         ENDWITH
239: 
240:         *-- Botao Encerrar (padrao canonico cnt_4c_Saida)

*-- Linhas 262 a 305:
262:             ENDWITH
263:         ENDWITH
264: 
265:         BINDEVENT(loc_oPag1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
266: 
267:         *-- Form puramente visual: cnt_4c_Botoes oculto (sem operacoes CRUD)
268:         loc_oPag1.cnt_4c_Botoes.Visible = .F.
269: 
270:         *-- 27 imagens do mapa visual centralizadas na area de conteudo
271:         loc_oPag1.AddObject("img_4c_Image1", "Image")
272:         WITH loc_oPag1.img_4c_Image1
273:             .Picture = gc_4c_CaminhoIcones + "form4.ico"
274:             .Stretch = 2
275:             .Top     = loc_nT + 0
276:             .Left    = loc_nL + 0
277:             .Width   = 18
278:             .Height  = 17
279:         ENDWITH
280: 
281:         loc_oPag1.AddObject("img_4c_Image2", "Image")
282:         WITH loc_oPag1.img_4c_Image2
283:             .Picture = gc_4c_CaminhoIcones + "form7.ico"
284:             .Stretch = 2
285:             .Top     = loc_nT + 18
286:             .Left    = loc_nL + 0
287:             .Width   = 18
288:             .Height  = 17
289:         ENDWITH
290: 
291:         loc_oPag1.AddObject("img_4c_Image3", "Image")
292:         WITH loc_oPag1.img_4c_Image3
293:             .Picture = gc_4c_CaminhoIcones + "ohist.ico"
294:             .Stretch = 2
295:             .Top     = loc_nT + 36
296:             .Left    = loc_nL + 0
297:             .Width   = 18
298:             .Height  = 17
299:         ENDWITH
300: 
301:         loc_oPag1.AddObject("img_4c_Image4", "Image")
302:         WITH loc_oPag1.img_4c_Image4
303:             .Picture = gc_4c_CaminhoIcones + "replace.ico"
304:             .Stretch = 2
305:             .Top     = loc_nT + 1

*-- Linhas 515 a 558:
515:     * lookups nem labels de conteudo ? apenas 27 imagens em Page1.
516:     * Page2 existe na estrutura padrao mas nao contem controles de dados.
517:     *============================================================================
518:     PROTECTED PROCEDURE ConfigurarPaginaDados()
519:         LOCAL loc_oPag2
520:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
521: 
522:         *-- Cabecalho padrao da Page2 (cinza escuro com titulo)
523:         loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
524:         WITH loc_oPag2.cnt_4c_Cabecalho
525:             .Top         = 31
526:             .Left        = 0
527:             .Width       = THIS.Width
528:             .Height      = 80
529:             .BackStyle   = 1
530:             .BackColor   = RGB(100, 100, 100)
531:             .BorderWidth = 0
532:             .Visible     = .T.
533: 
534:             .AddObject("lbl_4c_Sombra", "Label")
535:             WITH .lbl_4c_Sombra
536:                 .Top       = 15
537:                 .Left      = 12
538:                 .Width     = THIS.Width
539:                 .Height    = 40
540:                 .AutoSize  = .F.
541:                 .Caption   = "Mapa Visual"
542:                 .FontName  = "Tahoma"
543:                 .FontSize  = 16
544:                 .FontBold  = .T.
545:                 .ForeColor = RGB(0, 0, 0)
546:                 .BackStyle = 0
547:             ENDWITH
548: 
549:             .AddObject("lbl_4c_Titulo", "Label")
550:             WITH .lbl_4c_Titulo
551:                 .Top       = 18
552:                 .Left      = 10
553:                 .Width     = THIS.Width
554:                 .Height    = 46
555:                 .AutoSize  = .F.
556:                 .Caption   = "Mapa Visual"
557:                 .FontName  = "Tahoma"
558:                 .FontSize  = 16

*-- Linhas 566 a 717:
566:     *============================================================================
567:     * AlternarPagina - Alterna a pagina ativa do PageFrame
568:     *============================================================================
569:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
570:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
571:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
572:         ENDIF
573:     ENDPROC
574: 
575:     *============================================================================
576:     * BtnIncluirClick - Handler de inclusao
577:     * Form sigprico e puramente visual (Mapa Visual com 27 icones): nao possui
578:     * dados persistidos nem operacoes CRUD. Informa o usuario e retorna sem
579:     * alterar o estado do formulario.
580:     *============================================================================
581:     PROCEDURE BtnIncluirClick()
582:         MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + " apenas visual " + ;
583:                  "(Mapa Visual do sistema)." + CHR(13) + ;
584:                  "N" + CHR(227) + "o h" + CHR(225) + " opera" + CHR(231) + CHR(227) + "o de inclus" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
585:                  "Aviso")
586:     ENDPROC
587: 
588:     *============================================================================
589:     * BtnAlterarClick - Handler de alteracao
590:     * Form sigprico e puramente visual (Mapa Visual com 27 icones): nao possui
591:     * dados persistidos nem operacoes CRUD. Informa o usuario e retorna sem
592:     * alterar o estado do formulario.
593:     *============================================================================
594:     PROCEDURE BtnAlterarClick()
595:         MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + " apenas visual " + ;
596:                  "(Mapa Visual do sistema)." + CHR(13) + ;
597:                  "N" + CHR(227) + "o h" + CHR(225) + " opera" + CHR(231) + CHR(227) + "o de altera" + CHR(231) + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
598:                  "Aviso")
599:     ENDPROC
600: 
601:     *============================================================================
602:     * BtnVisualizarClick - Handler de visualizacao
603:     * Form sigprico ja exibe o Mapa Visual completo em Page1 (27 icones
604:     * organizados no diagrama). Garante que a pagina de visualizacao esteja
605:     * ativa e o PageFrame visivel.
606:     *============================================================================
607:     PROCEDURE BtnVisualizarClick()
608:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
609:             THIS.pgf_4c_Paginas.Visible    = .T.
610:             THIS.pgf_4c_Paginas.ActivePage = 1
611:             THIS.this_cModoAtual           = "VISUAL"
612:         ENDIF
613:     ENDPROC
614: 
615:     *============================================================================
616:     * BtnExcluirClick - Handler de exclusao
617:     * Form sigprico e puramente visual (Mapa Visual com 27 icones): nao possui
618:     * dados persistidos nem operacoes CRUD. Informa o usuario e retorna sem
619:     * alterar o estado do formulario.
620:     *============================================================================
621:     PROCEDURE BtnExcluirClick()
622:         MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + " apenas visual " + ;
623:                  "(Mapa Visual do sistema)." + CHR(13) + ;
624:                  "N" + CHR(227) + "o h" + CHR(225) + " opera" + CHR(231) + CHR(227) + "o de exclus" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
625:                  "Aviso")
626:     ENDPROC
627: 
628:     *============================================================================
629:     * CarregarLista - Formulario visual: nao ha lista de dados para carregar
630:     *============================================================================
631:     PROTECTED FUNCTION CarregarLista()
632:         THIS.pgf_4c_Paginas.ActivePage = 1
633:         RETURN .T.
634:     ENDFUNC
635: 
636:     *============================================================================
637:     * AjustarBotoesPorModo - Formulario visual: botoes CRUD ocultos
638:     *============================================================================
639:     PROTECTED PROCEDURE AjustarBotoesPorModo()
640:         *-- Form puramente visual: cnt_4c_Botoes permanece oculto (sem CRUD)
641:         RETURN
642:     ENDPROC
643: 
644:     *============================================================================
645:     * HabilitarCampos - Formulario visual: sem campos de entrada
646:     *============================================================================
647:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
648:         *-- Sem controles de entrada de dados
649:         RETURN
650:     ENDPROC
651: 
652:     *============================================================================
653:     * LimparCampos - Formulario visual: sem campos a limpar
654:     *============================================================================
655:     PROTECTED PROCEDURE LimparCampos()
656:         *-- Sem controles de entrada de dados
657:         RETURN
658:     ENDPROC
659: 
660:     *============================================================================
661:     * FormParaBO - Formulario visual: sem campos a transferir para o BO
662:     *============================================================================
663:     PROTECTED PROCEDURE FormParaBO()
664:         *-- Formulario exclusivamente visual: sem propriedades de dados no BO
665:         RETURN
666:     ENDPROC
667: 
668:     *============================================================================
669:     * BOParaForm - Formulario visual: sem campos a popular do BO
670:     *============================================================================
671:     PROTECTED PROCEDURE BOParaForm()
672:         *-- Formulario exclusivamente visual: sem propriedades de dados no BO
673:         RETURN
674:     ENDPROC
675: 
676:     *============================================================================
677:     * BtnBuscarClick - Formulario visual: sem operacao de busca
678:     *============================================================================
679:     PROCEDURE BtnBuscarClick()
680:         *-- Form puramente visual: sem dados para buscar
681:         RETURN
682:     ENDPROC
683: 
684:     *============================================================================
685:     * BtnSalvarClick - Formulario visual: retorna para visualizacao
686:     *============================================================================
687:     PROCEDURE BtnSalvarClick()
688:         THIS.pgf_4c_Paginas.ActivePage = 1
689:         THIS.this_cModoAtual           = "VISUAL"
690:     ENDPROC
691: 
692:     *============================================================================
693:     * BtnCancelarClick - Formulario visual: retorna para visualizacao
694:     *============================================================================
695:     PROCEDURE BtnCancelarClick()
696:         THIS.pgf_4c_Paginas.ActivePage = 1
697:         THIS.this_cModoAtual           = "VISUAL"
698:     ENDPROC
699: 
700:     *============================================================================
701:     * BtnEncerrarClick - Fecha o formulario
702:     *============================================================================
703:     PROCEDURE BtnEncerrarClick()
704:         THIS.Release()
705:     ENDPROC
706: 
707:     *============================================================================
708:     * Destroy - Libera recursos ao fechar
709:     *============================================================================
710:     PROCEDURE Destroy()
711:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
712:             THIS.this_oBusinessObject = .NULL.
713:         ENDIF
714:         DODEFAULT()
715:     ENDPROC
716: 
717: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpricoBO.prg):
*==============================================================================
* sigpricoBO.prg
*
* Business Object para Formsigprico
* Formulario de mapa visual/diagrama operacional
* Sem tabela propria - apenas imagens de navegacao
*==============================================================================

DEFINE CLASS sigpricoBO AS BusinessBase

	*-- Sem propriedades de dados: formulario apenas visual (27 imagens)
	*-- Metodos CRUD implementados como no-op para conformidade com BusinessBase

	*============================================================================
	* Init - Inicializa Business Object
	*============================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela    = ""
		THIS.this_cCampoChave = ""
		RETURN .T.
	ENDPROC

	*============================================================================
	* ObterChavePrimaria - Retorna chave primaria (vazia: sem tabela)
	*============================================================================
	PROTECTED FUNCTION ObterChavePrimaria()
		RETURN ""
	ENDFUNC

	*============================================================================
	* CarregarDoCursor - No-op: form nao tem cursor de dados (apenas imagens)
	*============================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Nao ha dados para carregar de cursor
		RETURN .T.
	ENDPROC

	*============================================================================
	* Inserir - No-op: form nao persiste dados
	*============================================================================
	FUNCTION Inserir()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma operacao INSERT realizada
		THIS.this_cUltimoErro = "Formulario sem persistencia de dados"

		RETURN loc_lResultado
	ENDFUNC

	*============================================================================
	* Atualizar - No-op: form nao persiste dados
	*============================================================================
	FUNCTION Atualizar()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma operacao UPDATE realizada
		THIS.this_cUltimoErro = "Formulario sem persistencia de dados"

		RETURN loc_lResultado
	ENDFUNC

	*============================================================================
	* ExecutarExclusao - No-op: form nao persiste dados
	*============================================================================
	PROTECTED FUNCTION ExecutarExclusao()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma operacao DELETE realizada
		THIS.this_cUltimoErro = "Formulario sem persistencia de dados"

		RETURN loc_lResultado
	ENDFUNC

	*============================================================================
	* Buscar - No-op: form nao possui lista de registros
	*============================================================================
	FUNCTION Buscar(par_cFiltro)
		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma consulta SELECT realizada
		RETURN .T.
	ENDFUNC

	*============================================================================
	* RegistrarAuditoria - No-op: sem operacoes que exijam auditoria
	*============================================================================
	PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Nenhuma operacao de dados a auditar
		RETURN
	ENDPROC

ENDDEFINE

