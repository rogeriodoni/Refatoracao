# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarEmpOsLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarEmpOsLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarOperacaoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarOperacaoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpPck.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2605 linhas total):

*-- Linhas 65 a 108:
65: *   AcessoEmpresas(pCur)          - alimentava fAcessoEmpresa/fAcessoMovmto
66: *                                   (funcoes globais Fortyus nao portadas);
67: *                                   este form usa lookup proprio via
68: *                                   FormBuscaAuxiliar
69: *==============================================================================
70: 
71: DEFINE CLASS FormSigOpPck AS FormBase
72: 
73:     *--------------------------------------------------------------------------
74:     * Propriedades visuais (PILAR 1 - valores exatos do SCX original)
75:     *--------------------------------------------------------------------------
76:     Width        = 1300
77:     Height       = 700
78:     DataSession  = 2
79:     BorderStyle  = 2
80:     AutoCenter   = .T.
81:     Caption      = "Atendimento Picking"
82:     ControlBox   = .F.
83:     Closable     = .F.
84:     MaxButton    = .F.
85:     MinButton    = .F.
86:     ShowTips     = .T.
87:     ShowWindow   = 1
88:     WindowType   = 1
89:     ClipControls = .F.
90:     KeyPreview   = .T.
91:     TitleBar     = 0
92:     SizeBox      = .F.
93:     ZoomBox      = .F.
94:     Themes       = .F.
95:     FontName     = "Tahoma"
96:     FontSize     = 8
97: 
98:     *--------------------------------------------------------------------------
99:     * Business Object (ja declarada em FormBase - this_oBusinessObject)
100:     *--------------------------------------------------------------------------
101: 
102:     *--------------------------------------------------------------------------
103:     * Controle de pagina ativa: FILTROS / DADOS (FormBase declara
104:     * this_cModoAtual = "LISTA" por default; este form nao eh CRUD)
105:     *--------------------------------------------------------------------------
106:     this_cModoAtual = "FILTROS"
107: 
108:     *--------------------------------------------------------------------------

*-- Linhas 114 a 295:
114:     this_lEmLookupOperacao = .F.
115: 
116:     *--------------------------------------------------------------------------
117:     * Init - Chama FormBase.Init() que dispara InicializarForm()
118:     *--------------------------------------------------------------------------
119:     PROCEDURE Init()
120:         RETURN DODEFAULT()
121:     ENDPROC
122: 
123:     *--------------------------------------------------------------------------
124:     * InicializarForm - Cria o Business Object e monta a estrutura base
125:     * (PageFrame com as 2 paginas do legado). Grades, filtros e botoes sao
126:     * adicionados nas fases seguintes.
127:     *--------------------------------------------------------------------------
128:     PROTECTED PROCEDURE InicializarForm()
129:         LOCAL loc_lSucesso, loc_oErro
130:         loc_lSucesso = .F.
131: 
132:         TRY
133:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpPckBO")
134: 
135:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
136:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpPckBO", "Erro")
137:             ELSE
138:                 THIS.ConfigurarPageFrame()
139:                 THIS.ConfigurarPaginaLista()
140:                 THIS.ConfigurarEventosPaginaLista()
141:                 THIS.ConfigurarPaginaDados()
142:                 THIS.ConfigurarEventosPaginaDados()
143: 
144:                 *-- Popula Empresa/this_lAcessoPorTipo e as 3 grades de
145:                 *-- filtro a partir do banco (legado: bloco do Init do SCX -
146:                 *-- ver cabecalho de SigOpPckBO.CarregarFiltros). Pulado em
147:                 *-- modo de validacao de UI (sem conexao SQL real).
148:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
149:                     IF !THIS.this_oBusinessObject.CarregarFiltros()
150:                         MsgErro("Erro ao carregar os filtros da tela.", "Erro")
151:                     ENDIF
152: 
153:                     *-- Layout salvo da grade de resultado por usuario
154:                     *-- (legado: .poSigSyPar.mLerCfg(), objeto fGravaUserXML
155:                     *-- do Framework NAO portado - substituido por SigSyPar
156:                     *-- via SQL, mesmo padrao de FormSIGOPCGF).
157:                     THIS.this_oBusinessObject.CarregarCfgGrade()
158:                 ENDIF
159: 
160:                 *-- Espelha os filtros do BO na tela. FORA do IF acima de
161:                 *-- proposito: inclui getDcI/getDcF = Date(), que o Init do
162:                 *-- legado preenche sempre (codigo_fonte.txt:2792-2793) e que
163:                 *-- nao depende de SQL - os defaults ja vem do
164:                 *-- SigOpPckBO.Init.
165:                 THIS.BOParaForm()
166:                 THIS.AtualizarFiltrosNaTela()
167: 
168:                 *-- Aplica o layout lido acima as colunas da grade de
169:                 *-- resultado (legado: MontaGrades termina em
170:                 *-- ThisForm.AcertaColunas([LER])).
171:                 THIS.AcertaColunas("LER")
172: 
173:                 THIS.pgf_4c_Paginas.Visible    = .T.
174:                 THIS.pgf_4c_Paginas.ActivePage = 1
175:                 THIS.this_cModoAtual           = "FILTROS"
176: 
177:                 loc_lSucesso = .T.
178:             ENDIF
179:         CATCH TO loc_oErro
180:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
181:                     " PROC=" + loc_oErro.Procedure, "Erro")
182:         ENDTRY
183: 
184:         RETURN loc_lSucesso
185:     ENDPROC
186: 
187:     *--------------------------------------------------------------------------
188:     * ConfigurarPageFrame - Cria o PageFrame com as 2 paginas do legado.
189:     * Top/Width/Height EXATOS do dump (SigOpPck_form_codigo_fonte.txt:510-535):
190:     * abas ocultas (Tabs = .F.) com layout customizado - NAO eh o padrao CRUD
191:     * Top=-29/compensacao +29 de frmcadastro.
192:     *--------------------------------------------------------------------------
193:     PROTECTED PROCEDURE ConfigurarPageFrame()
194:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
195: 
196:         WITH THIS.pgf_4c_Paginas
197:             .Top       = -2
198:             .Left      = 0
199:             .Width     = 1301
200:             .Height    = 705
201:             .PageCount = 2
202:             .Tabs      = .F.
203:             *-- TabStyle do SCX NAO eh transcrita: eh READ-ONLY em runtime no
204:             *-- VFP9 ("Property TABSTYLE is read-only") - mesma situacao da
205:             *-- BorderWidth anotada abaixo. Com as abas ocultas (Tabs = .F.)
206:             *-- o estilo de aba nao tem efeito visual nenhum.
207:             .Visible   = .F.
208:             *-- ErasePage do SCX NAO foi transcrita: PageFrame nao tem essa
209:             *-- propriedade no runtime do VFP9 - medido em 2026-11-13 com
210:             *-- automation\_probeErasePage783.prg (PEMSTATUS devolve .F. e a
211:             *-- atribuicao estoura "Property ERASEPAGE is not found."). Eh
212:             *-- propriedade de tempo de PROJETO, gravada no SCX pelo Form
213:             *-- Designer, da mesma familia de ZOrderSet/ShapeType da regra
214:             *-- #33 do CLAUDE.md: transcreve-la derrubava o Init DENTRO do
215:             *-- TRY de InicializarForm e a tela nao abria (CREATEOBJECT
216:             *-- devolvia .F. e o menu nao fazia nada).
217:             *-- PageFrame.BorderWidth eh READ-ONLY em runtime ("Property
218:             *-- BORDERWIDTH is read-only") e o SCX legado nao a declara
219:             *-- com valor diferente do default - nao atribuir.
220: 
221:             .Page1.Caption   = ""
222:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
223:             .Page1.FontName  = "Verdana"
224:             .Page1.FontSize  = 8
225:             .Page1.ForeColor = RGB(36, 84, 155)
226: 
227:             *-- Page2.Caption = "s" no dump legado eh resto de placeholder
228:             *-- de template (as abas estao ocultas - Tabs = .F. - a
229:             *-- caption nunca eh exibida); nao transcrever o lixo.
230:             .Page2.Caption   = ""
231:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
232:             .Page2.FontName  = "Verdana"
233:             .Page2.FontSize  = 8
234:             .Page2.ForeColor = RGB(36, 84, 155)
235:         ENDWITH
236:     ENDPROC
237: 
238:     *--------------------------------------------------------------------------
239:     * ConfigurarPaginaLista - Monta TODO o conteudo da Page1 (pgFiltros):
240:     * faixa do cabecalho, filtros de periodo/empresa/movimentacao, a grade
241:     * de Tipos de Operacao (ou o campo de Movimentacao avulso, conforme o
242:     * acesso do usuario - this_lAcessoPorTipo), as grades de Grande Grupo e
243:     * Grupo de Produto com os botoes Marcar/Desmarcar Tudo, e o
244:     * CommandGroup de acao (Consultar/Sair). NAO segue o padrao CRUD
245:     * Page1=Lista: este form eh OPERACIONAL de consulta/processamento (ver
246:     * cabecalho do arquivo) - Page1 eh a pagina de FILTROS, nao uma lista
247:     * de registros.
248:     *
249:     * As 3 grades sao ligadas a cursores PLACEHOLDER (estrutura final, sem
250:     * linhas) - regra #41 do CLAUDE.md: Column.ControlSource de cursor
251:     * inexistente derruba o Init. A populacao real via SQL (SigCdTom/
252:     * SigCdGpr/SigCdGrp) fica para fase posterior (CarregarFiltros() no BO
253:     * - ver cabecalho de SigOpPckBO.prg).
254:     *--------------------------------------------------------------------------
255:     PROTECTED PROCEDURE ConfigurarPaginaLista()
256:         LOCAL loc_oPag, loc_lAcessoPorTipo
257: 
258:         loc_oPag           = THIS.pgf_4c_Paginas.Page1
259:         loc_lAcessoPorTipo = THIS.this_oBusinessObject.this_lAcessoPorTipo
260: 
261:         THIS.CriarCursoresFiltroPlaceholder()
262: 
263:         *-- Faixa do cabecalho (legado: cntSombra) - regra #11, PRIMEIRO
264:         *-- AddObject da pagina. AddObject do filho e o WITH que configura
265:         *-- suas propriedades ficam FORA do WITH do container (regra #44 -
266:         *-- WITH aninhado com .AddObject + WITH .filho dentro ignora
267:         *-- propriedades em silencio).
268:         loc_oPag.AddObject("cnt_4c_Sombra", "Container")
269:         WITH loc_oPag.cnt_4c_Sombra
270:             .Top         = 2
271:             .Left        = 0
272:             .Width       = 1308
273:             .Height      = 80
274:             .BorderWidth = 0
275:             .BackColor   = RGB(100, 100, 100)
276:             .Visible     = .T.
277:         ENDWITH
278: 
279:         loc_oPag.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
280:         WITH loc_oPag.cnt_4c_Sombra.lbl_4c_LblSombra
281:             .FontName      = "Tahoma"
282:             .FontSize      = 18
283:             .FontBold      = .T.
284:             .FontUnderline = .F.
285:             .WordWrap      = .T.
286:             .AutoSize      = .F.
287:             .Alignment     = 0
288:             .BackStyle     = 0
289:             .Top           = 25
290:             .Left          = 10
291:             .Width         = 769
292:             .Height        = 40
293:             .ForeColor     = RGB(0, 0, 0)
294:             .Caption       = THIS.this_oBusinessObject.this_cCaption
295:             .Visible       = .T.

*-- Linhas 662 a 736:
662:     * Column.ControlSource a um cursor inexistente derruba o Init (regra
663:     * #41 do CLAUDE.md).
664:     *--------------------------------------------------------------------------
665:     PROTECTED PROCEDURE CriarCursoresFiltroPlaceholder()
666:         LOCAL loc_cCursorTipos, loc_cCursorGrdGpr, loc_cCursorGrdGru
667: 
668:         loc_cCursorTipos  = THIS.this_oBusinessObject.this_cCursorTipos
669:         loc_cCursorGrdGpr = THIS.this_oBusinessObject.this_cCursorGrdGpr
670:         loc_cCursorGrdGru = THIS.this_oBusinessObject.this_cCursorGrdGru
671: 
672:         IF USED(loc_cCursorTipos)
673:             USE IN (loc_cCursorTipos)
674:         ENDIF
675:         CREATE CURSOR (loc_cCursorTipos) (nMarcas N(1,0), CCodigos C(2), CDescricaos C(50))
676: 
677:         IF USED(loc_cCursorGrdGpr)
678:             USE IN (loc_cCursorGrdGpr)
679:         ENDIF
680:         CREATE CURSOR (loc_cCursorGrdGpr) (nMarcas N(1,0), Codigos C(3), CDescricaos C(50))
681: 
682:         IF USED(loc_cCursorGrdGru)
683:             USE IN (loc_cCursorGrdGru)
684:         ENDIF
685:         CREATE CURSOR (loc_cCursorGrdGru) (nMarcas N(1,0), Mercs C(3), Codigos C(3), CDescricaos C(50))
686:     ENDPROC
687: 
688:     *--------------------------------------------------------------------------
689:     * ConfigurarGradeFiltro - Helper para as grades de filtro de 2 colunas
690:     * (Check + Descricao): Tipos de Operacao (grdTipo) e Grande Grupo
691:     * (grdMercs). Padrao canonico: Column1 = CheckBox ligado a "nMarcas"
692:     * (regra #18 - AddObject + CurrentControl + Sparse = .F.), Column2 =
693:     * descricao combinada codigo-descricao (ReadOnly). Referencia:
694:     * Formsigrepes.prg ConfigurarGrdP2.
695:     *--------------------------------------------------------------------------
696:     PROTECTED PROCEDURE ConfigurarGradeFiltro(par_oGrd, par_cCursor, par_nLeft, par_nTop, ;
697:             par_nHeight, par_nWidth, par_nCol2Width, par_cCaptionCol2)
698: 
699:         WITH par_oGrd
700:             .RecordSource   = par_cCursor
701:             .ColumnCount    = 2
702:             .FontName       = "Tahoma"
703:             .FontSize       = 8
704:             .AllowRowSizing = .F.
705:             .DeleteMark     = .F.
706:             .RecordMark     = .F.
707:             .GridLines      = 3
708:             .HeaderHeight   = 16
709:             .RowHeight      = 16
710:             .ScrollBars     = 2
711:             .TabStop        = .F.
712:             .Left           = par_nLeft
713:             .Top            = par_nTop
714:             .Height         = par_nHeight
715:             .Width          = par_nWidth
716:             .ForeColor      = RGB(0, 0, 0)
717:             .GridLineColor  = RGB(238, 238, 238)
718:             .Themes         = .F.
719:             .Visible        = .T.
720:         ENDWITH
721: 
722:         *-- WITH das Columns FORA do WITH do grid (regra #44 - nested WITH
723:         *-- com .AddObject dentro ignora propriedades em silencio)
724:         WITH par_oGrd.Column1
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .Alignment = 0
728:             .Width     = 18
729:             .Enabled   = .T.
730:             .Sparse    = .F.
731:             .AddObject("Check1", "CheckBox")
732:             .Check1.Caption   = ""
733:             .Check1.Alignment = 0
734:             .Check1.ReadOnly  = .F.
735:             .Check1.Visible   = .T.
736:             .Check1.Top       = 2

*-- Linhas 762 a 886:
762:     * (legado: btnMarca/btnMarGde/btnMarGrp e btnDesmarca/btnDesGde/
763:     * btnDesGrp - mesmo icone/propriedades nos 3 pares).
764:     *--------------------------------------------------------------------------
765:     PROTECTED PROCEDURE ConfigurarBotaoMarcar(par_oBtn, par_nLeft, par_nTop, par_cToolTip)
766:         WITH par_oBtn
767:             .Top         = par_nTop
768:             .Left        = par_nLeft
769:             .Height      = 45
770:             .Width       = 45
771:             .FontName    = "Arial"
772:             .FontSize    = 7
773:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
774:             .Caption     = ""
775:             .TabStop     = .F.
776:             .ToolTipText = par_cToolTip
777:             .ForeColor   = RGB(255, 0, 0)
778:             .BackColor   = RGB(255, 255, 255)
779:             .Themes      = .F.
780:             .Visible     = .T.
781:         ENDWITH
782:     ENDPROC
783: 
784:     PROTECTED PROCEDURE ConfigurarBotaoDesmarcar(par_oBtn, par_nLeft, par_nTop, par_cToolTip)
785:         WITH par_oBtn
786:             .Top         = par_nTop
787:             .Left        = par_nLeft
788:             .Height      = 45
789:             .Width       = 45
790:             .FontName    = "Arial"
791:             .FontSize    = 7
792:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
793:             .Caption     = ""
794:             .TabStop     = .F.
795:             .ToolTipText = par_cToolTip
796:             .ForeColor   = RGB(255, 0, 0)
797:             .BackColor   = RGB(255, 255, 255)
798:             .Themes      = .F.
799:             .Visible     = .T.
800:         ENDWITH
801:     ENDPROC
802: 
803:     *--------------------------------------------------------------------------
804:     * ConfigurarEventosPaginaLista - BINDEVENT dos botoes de Marcar/
805:     * Desmarcar Tudo das 3 grades de filtro e do CommandGroup de acao
806:     * (Consultar/Sair).
807:     *--------------------------------------------------------------------------
808:     PROTECTED PROCEDURE ConfigurarEventosPaginaLista()
809:         LOCAL loc_oPag
810:         loc_oPag = THIS.pgf_4c_Paginas.Page1
811: 
812:         BINDEVENT(loc_oPag.cmd_4c_BtnMarca,    "Click", THIS, "BtnMarcaClick")
813:         BINDEVENT(loc_oPag.cmd_4c_BtnDesmarca, "Click", THIS, "BtnDesmarcaClick")
814:         BINDEVENT(loc_oPag.cmd_4c_BtnMarGde,   "Click", THIS, "BtnMarGdeClick")
815:         BINDEVENT(loc_oPag.cmd_4c_BtnDesGde,   "Click", THIS, "BtnDesGdeClick")
816:         BINDEVENT(loc_oPag.cmd_4c_BtnMarGrp,   "Click", THIS, "BtnMarGrpClick")
817:         BINDEVENT(loc_oPag.cmd_4c_BtnDesGrp,   "Click", THIS, "BtnDesGrpClick")
818: 
819:         BINDEVENT(loc_oPag.obj_4c_CmgFiltros.Buttons(1), "Click", THIS, "BtnConsultarClick")
820:         BINDEVENT(loc_oPag.obj_4c_CmgFiltros.Buttons(2), "Click", THIS, "BtnSairClick")
821: 
822:         *-- Lookup de Empresa (legado: getEmpOs.Valid/getDEmpOs.Valid =
823:         *-- fAcessoEmpresa - funcao NAO portada; substituicao canonica via
824:         *-- FormBuscaAuxiliar em SigCdEmp - regra #47: LostFocus valida,
825:         *-- F4 abre o picker direto)
826:         BINDEVENT(loc_oPag.txt_4c_EmpOs, "LostFocus", THIS, "ValidarEmpOsLostFocus")
827:         BINDEVENT(loc_oPag.txt_4c_EmpOs, "KeyPress",  THIS, "EmpOsKeyPress")
828: 
829:         *-- Lookup de Operacao/Movimentacao (legado: getOperacao.Valid =
830:         *-- fAcessoMovmto - funcao NAO portada; SigCdOpe eh single-column,
831:         *-- Dopes eh PK e descricao ao mesmo tempo)
832:         BINDEVENT(loc_oPag.txt_4c_Operacao, "LostFocus", THIS, "ValidarOperacaoLostFocus")
833:         BINDEVENT(loc_oPag.txt_4c_Operacao, "KeyPress",  THIS, "OperacaoKeyPress")
834:     ENDPROC
835: 
836:     *--------------------------------------------------------------------------
837:     * AtualizarFiltrosNaTela - Reaplica a visibilidade do criterio de Tipo
838:     * de Operacao (grade de Tipos x campo avulso de Movimentacao) com o
839:     * valor REAL de this_lAcessoPorTipo, ja resolvido por CarregarFiltros
840:     * (que roda DEPOIS de ConfigurarPaginaLista - a visibilidade inicial
841:     * configurada ali usa o default .F. da property, ver cabecalho do BO),
842:     * preenche o campo de Empresa com o default carregado e repinta as 3
843:     * grades de filtro ja populadas (regra #21 do CLAUDE.md - popular
844:     * cursor nao repinta a grade sozinho).
845:     *--------------------------------------------------------------------------
846:     PROTECTED PROCEDURE AtualizarFiltrosNaTela()
847:         LOCAL loc_oPag, loc_oBO, loc_lAcessoPorTipo
848: 
849:         loc_oPag           = THIS.pgf_4c_Paginas.Page1
850:         loc_oBO            = THIS.this_oBusinessObject
851:         loc_lAcessoPorTipo = loc_oBO.this_lAcessoPorTipo
852: 
853:         loc_oPag.lbl_4c_Movimentacao.Visible = !loc_lAcessoPorTipo
854:         loc_oPag.txt_4c_Operacao.Visible     = !loc_lAcessoPorTipo
855:         loc_oPag.lbl_4c_TipoOperacao.Visible = loc_lAcessoPorTipo
856:         loc_oPag.grd_4c_Tipo.Visible         = loc_lAcessoPorTipo
857:         loc_oPag.cmd_4c_BtnMarca.Visible     = loc_lAcessoPorTipo
858:         loc_oPag.cmd_4c_BtnDesmarca.Visible  = loc_lAcessoPorTipo
859: 
860:         *-- Os valores dos campos de filtro ficam em BOParaForm() (fonte
861:         *-- unica) - aqui so a visibilidade condicional e o repintar das
862:         *-- grades.
863:         IF USED(loc_oBO.this_cCursorTipos)
864:             GO TOP IN (loc_oBO.this_cCursorTipos)
865:         ENDIF
866:         loc_oPag.grd_4c_Tipo.Refresh()
867: 
868:         IF USED(loc_oBO.this_cCursorGrdGpr)
869:             GO TOP IN (loc_oBO.this_cCursorGrdGpr)
870:         ENDIF
871:         loc_oPag.grd_4c_GrdGpr.Refresh()
872: 
873:         IF USED(loc_oBO.this_cCursorGrdGru)
874:             GO TOP IN (loc_oBO.this_cCursorGrdGru)
875:         ENDIF
876:         loc_oPag.grd_4c_GrdGru.Refresh()
877:     ENDPROC
878: 
879:     *--------------------------------------------------------------------------
880:     * ConfigurarPaginaDados - Monta a METADE INICIAL do conteudo da Page2
881:     * (pgDados): o PageFrame interno pgResults (legado, 1 pagina - pgRes01,
882:     * Caption "Detalhamento dos Produtos"), a grade de resultado
883:     * (grdDados1, 16 colunas - ControlSource transcrito EXATO do metodo
884:     * Processamento do legado, SigOpPck_form_codigo_fonte.txt:2509-2526;
885:     * Header/Width/cor de cada coluna do dump de propriedades, :1288-1390
886:     * e :1405-1780) e o painel de observacao do item (Say3/getObsItn) com

*-- Linhas 895 a 938:
895:     * populacao real via SQL (processamento dos movimentos filtrados)
896:     * fica para fase posterior (Processar() no BO).
897:     *--------------------------------------------------------------------------
898:     PROTECTED PROCEDURE ConfigurarPaginaDados()
899:         LOCAL loc_oPag, loc_cCursor
900: 
901:         loc_oPag    = THIS.pgf_4c_Paginas.Page2
902:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
903: 
904:         THIS.CriarCursorDadosPlaceholder()
905: 
906:         *-- PageFrame interno (legado: pgResults, 1 pagina - pgRes01)
907:         loc_oPag.AddObject("pgf_4c_Resultados", "PageFrame")
908:         WITH loc_oPag.pgf_4c_Resultados
909:             .Top       = 2
910:             .Left      = -1
911:             .Width     = 1304
912:             .Height    = 600
913:             .PageCount = 1
914:             .Tabs      = .F.
915: 
916:             .Page1.FontName  = "Tahoma"
917:             .Page1.FontSize  = 8
918:             .Page1.Caption   = "Detalhamento dos Produtos"
919:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
920:             .Page1.BackColor = RGB(255, 255, 255)
921:             .Page1.ForeColor = RGB(90, 90, 90)
922:         ENDWITH
923: 
924:         *-- AddObject do filho e o WITH que o configura ficam FORA do WITH
925:         *-- do pai (regra #44 - WITH aninhado com .AddObject dentro ignora
926:         *-- propriedades em silencio).
927:         loc_oPag.pgf_4c_Resultados.Page1.AddObject("grd_4c_Dados", "Grid")
928:         THIS.ConfigurarGrdDados(loc_oPag.pgf_4c_Resultados.Page1.grd_4c_Dados, loc_cCursor)
929: 
930:         loc_oPag.pgf_4c_Resultados.Page1.AddObject("lbl_4c_ObsItem", "Label")
931:         WITH loc_oPag.pgf_4c_Resultados.Page1.lbl_4c_ObsItem
932:             .FontName  = "Tahoma"
933:             .FontSize  = 8
934:             .AutoSize  = .F.
935:             .Alignment = 0
936:             .BackStyle = 0
937:             .Left      = 6
938:             .Top       = 4

*-- Linhas 1218 a 1261:
1218:     * via EVALUATE em CarregarDoCursor). A populacao real fica para fase
1219:     * posterior (Processar() no BO).
1220:     *--------------------------------------------------------------------------
1221:     PROTECTED PROCEDURE CriarCursorDadosPlaceholder()
1222:         LOCAL loc_cCursor
1223:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
1224: 
1225:         IF USED(loc_cCursor)
1226:             USE IN (loc_cCursor)
1227:         ENDIF
1228: 
1229:         CREATE CURSOR (loc_cCursor) ( ;
1230:             Ordem C(1), Filtro N(1,0), Empresa C(3), Movimentacao C(20), Numero N(6,0), ;
1231:             Data_Venda D, Codigo_Vendedora C(10), Item N(10,0), Codigo_Item C(14), ;
1232:             Desc_Item C(40), Obs_Item M, Quantidade N(16,2), Val_Unitario N(16,2), ;
1233:             Total N(16,2), Total_Geral N(16,2), Moeda C(3), Operacao C(1), Barras N(14,0), ;
1234:             Gde_Grupo C(3), Grupo C(3), SubGrupo C(60), Custo_Cadastro N(16,2), ;
1235:             Moe_Cus_Cadastro C(3), Markup N(16,2), Venda_Cadastro N(16,2), Moe_Vda_Cadastro C(3), ;
1236:             Imagem M, Tamanho C(4), Cor C(4), Cod_Cliente C(10), Nome_Cliente C(50), ;
1237:             Cod_Fornecedor C(10), Nome_Fornecedor C(50), Tkt_Medio N(16,2), Ref_Fornecedor C(20), ;
1238:             Valor_Diferenca N(16,2), Perc_Diferenca N(16,2), Pct_Dif_Chr C(20), Parcelas N(3,0), ;
1239:             Cond_Pagto C(100), Venda_CadastroR N(16,2), Desc_Acres N(16,2), CpfCli C(20), ;
1240:             Pedidoweb C(20), pStatus C(1), Dias N(5,0), Descritivo C(45), Local C(10), ;
1241:             Qtde N(12,0), Colecao C(60), Destino C(3), ContaOrigem C(10))
1242: 
1243:         *-- Tags EXATOS do legado (Load(), codigo_fonte.txt:2772-2775). Com
1244:         *-- Filtro/Perc_Diferenca sempre 0 nesta tela (regra de "diferenca"
1245:         *-- nao exercitada aqui), Ordem1/Ordem2 ficam sempre vazios e
1246:         *-- Ordem3 sempre com tudo - SigOpPckBO.MontarCursorDados() usa
1247:         *-- Ordem3 ao final do processamento (legado: Thisform.Filtros(1,3)).
1248:         SELECT (loc_cCursor)
1249:         INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
1250:             FOR Filtro = 1 OR (Perc_Diferenca > 0 AND Filtro <> 3) TAG Ordem1
1251:         INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
1252:             FOR Filtro = 2 OR (Perc_Diferenca < 0 AND Filtro <> 3) TAG Ordem2
1253:         INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
1254:             FOR Filtro <> 1 AND Filtro <> 2 TAG Ordem3
1255:         INDEX ON Data_Venda TAG Ordem4
1256:     ENDPROC
1257: 
1258:     *--------------------------------------------------------------------------
1259:     * ConfigurarGrdDados - Grade de resultado "Detalhamento dos Produtos"
1260:     * (legado: grdDados1), 16 colunas SOMENTE LEITURA (legado:
1261:     * Movable/Resizable/ReadOnly = .F./.F./.T. para TODAS as colunas,

*-- Linhas 1270 a 1313:
1270:     * legado faz (ControlSource explicito no metodo Processamento) -
1271:     * TRANSCREVER, nao "corrigir" (regra #17 do CLAUDE.md).
1272:     *--------------------------------------------------------------------------
1273:     PROTECTED PROCEDURE ConfigurarGrdDados(par_oGrd, par_cCursor)
1274:         WITH par_oGrd
1275:             .RecordSource      = par_cCursor
1276:             .ColumnCount       = 16
1277:             .FontName          = "Tahoma"
1278:             .FontSize          = 7
1279:             .AllowHeaderSizing = .F.
1280:             .AllowRowSizing    = .F.
1281:             .DeleteMark        = .F.
1282:             .RecordMark        = .F.
1283:             .HeaderHeight      = 21
1284:             .RowHeight         = 15
1285:             .ScrollBars        = 3
1286:             .Left              = 4
1287:             .Top               = 320
1288:             .Width             = 1292
1289:             .Height            = 251
1290:             .GridLineColor     = RGB(238, 238, 238)
1291:             .Themes            = .F.
1292:             .Visible           = .T.
1293: 
1294:             *-- Negrito dinamico nas linhas cuja Ordem nao eh "A" (legado:
1295:             *-- MontaGrades, .SetAll([DynamicFontBold], [crPgRes01.Ordem
1296:             *-- <> 'A'], [Column])).
1297:             .SetAll("DynamicFontBold", par_cCursor + ".Ordem <> 'A'", "Column")
1298: 
1299:             *-- NAO aplicar Movable/Resizable/ReadOnly = .F. aqui: o loop do
1300:             *-- legado que faz isso (MontaGrades, codigo_fonte.txt:2467-2505)
1301:             *-- roda SO nas 3 grades de FILTRO (grdTipo/grdMercs/grdCGrus -
1302:             *-- ver ConfigurarGradeFiltro); grdDados1 fica com as colunas
1303:             *-- redimensionaveis DE PROPOSITO, porque eh arrastar a largura
1304:             *-- para 0 que dispara Column<N>.Resize e oferece ocultar a
1305:             *-- coluna (ver ColunaDados<NN>Resize/OcultarColunaDados).
1306:         ENDWITH
1307: 
1308:         WITH par_oGrd.Column1
1309:             .Width               = 31
1310:             .ControlSource       = par_cCursor + ".Destino"
1311:             .Header1.Alignment   = 2
1312:             .Header1.FontBold    = .T.
1313:             .Header1.ForeColor   = RGB(90, 90, 90)

*-- Linhas 1487 a 1614:
1487:     * 2026-11-13 com automation\_probeColOrder783.prg, que devolveu
1488:     * exatamente os 16 ColumnOrder do SCX.
1489:     *--------------------------------------------------------------------------
1490:     PROTECTED PROCEDURE AplicarOrdemColunasDados(par_oGrd)
1491:         LOCAL loc_nPos
1492:         LOCAL ARRAY loc_aColuna[16]
1493: 
1494:         *-- loc_aColuna[posicao] = numero da Column que ocupa essa posicao
1495:         loc_aColuna[1]  = 1
1496:         loc_aColuna[2]  = 3
1497:         loc_aColuna[3]  = 4
1498:         loc_aColuna[4]  = 6
1499:         loc_aColuna[5]  = 15
1500:         loc_aColuna[6]  = 7
1501:         loc_aColuna[7]  = 8
1502:         loc_aColuna[8]  = 9
1503:         loc_aColuna[9]  = 2
1504:         loc_aColuna[10] = 14
1505:         loc_aColuna[11] = 5
1506:         loc_aColuna[12] = 10
1507:         loc_aColuna[13] = 11
1508:         loc_aColuna[14] = 12
1509:         loc_aColuna[15] = 13
1510:         loc_aColuna[16] = 16
1511: 
1512:         FOR loc_nPos = 1 TO 16
1513:             STORE loc_nPos TO ("par_oGrd.Column" + ALLTRIM(STR(loc_aColuna[loc_nPos])) + ".ColumnOrder")
1514:         ENDFOR
1515:     ENDPROC
1516: 
1517:     *--------------------------------------------------------------------------
1518:     * GradePadrao - Restaura larguras e visibilidade das colunas da grade de
1519:     * resultado para a tabela PADRAO do legado (PROCEDURE gradepadrao,
1520:     * SigOpPck_form_codigo_fonte.txt:2400-2432 - array laGrd(1..16) + loop
1521:     * que tambem forca Visible = .t. e termina com Refresh).
1522:     *
1523:     * Esta tabela NAO eh a mesma das larguras iniciais (essas vem do SCX,
1524:     * ver ConfigurarGrdDados): o legado tem as duas, e esta eh a que o
1525:     * botao "Restaurar Grade" aplica.
1526:     *--------------------------------------------------------------------------
1527:     PROCEDURE GradePadrao()
1528:         LOCAL loc_oGrd, loc_nI, loc_cCol
1529:         LOCAL ARRAY loc_aLargura[16]
1530: 
1531:         loc_aLargura[1]  = 31
1532:         loc_aLargura[2]  = 150
1533:         loc_aLargura[3]  = 55
1534:         loc_aLargura[4]  = 71
1535:         loc_aLargura[5]  = 150
1536:         loc_aLargura[6]  = 80
1537:         loc_aLargura[7]  = 110
1538:         loc_aLargura[8]  = 296
1539:         loc_aLargura[9]  = 35
1540:         loc_aLargura[10] = 35
1541:         loc_aLargura[11] = 100
1542:         loc_aLargura[12] = 100
1543:         loc_aLargura[13] = 290
1544:         loc_aLargura[14] = 150
1545:         loc_aLargura[15] = 100
1546:         loc_aLargura[16] = 25
1547: 
1548:         loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados
1549: 
1550:         FOR loc_nI = 1 TO loc_oGrd.ColumnCount
1551:             loc_cCol = "loc_oGrd.Column" + ALLTRIM(STR(loc_nI))
1552:             STORE loc_aLargura[loc_nI] TO (loc_cCol + ".Width")
1553:             STORE .T. TO (loc_cCol + ".Visible")
1554:         ENDFOR
1555: 
1556:         loc_oGrd.Refresh()
1557:     ENDPROC
1558: 
1559:     *--------------------------------------------------------------------------
1560:     * AcertaColunas - Le ("LER") ou monta ("GRAVAR") o layout das colunas da
1561:     * grade de resultado na string de configuracao (legado: PROCEDURE
1562:     * acertacolunas, SigOpPck_form_codigo_fonte.txt:2086-2118).
1563:     *
1564:     * Formato da string (transcrito do legado): um bloco de 5 posicoes por
1565:     * coluna - 1..3 = Width com zeros a esquerda, 4 = Visible ("1"/"0"),
1566:     * 5 = BRANCO reservado para uso futuro. Largura nao gravada (bloco
1567:     * vazio/zero) MANTEM a largura corrente, igual ao legado.
1568:     *
1569:     * O deposito eh o TextBox txt_4c_CfgGrade (legado: getCfgGrade, visivel
1570:     * so para o usuario 4CONTROL); a persistencia por usuario fica em
1571:     * SigOpPckBO.CarregarCfgGrade/GravarCfgGrade (SigSyPar), substituindo o
1572:     * poSigSyPar/fGravaUserXML do Framework legado, que nao foi portado.
1573:     *--------------------------------------------------------------------------
1574:     PROCEDURE AcertaColunas(par_cTipo)
1575:         LOCAL loc_oGrd, loc_oTxt, loc_cStr, loc_nPos, loc_nI, loc_cCol, ;
1576:             loc_cBloco, loc_nLargura, loc_lVisivel
1577: 
1578:         loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados
1579:         loc_oTxt = THIS.pgf_4c_Paginas.Page1.txt_4c_CfgGrade
1580: 
1581:         IF UPPER(ALLTRIM(par_cTipo)) == "LER"
1582:             loc_cStr = loc_oTxt.Value
1583:             loc_nPos = 1
1584: 
1585:             FOR loc_nI = 1 TO loc_oGrd.ColumnCount
1586:                 loc_cBloco   = SUBSTR(loc_cStr, loc_nPos, 5)
1587:                 loc_nLargura = INT(VAL(SUBSTR(loc_cBloco, 1, 3)))
1588:                 loc_lVisivel = !(SUBSTR(loc_cBloco, 4, 1) == "0")
1589:                 loc_cCol     = "loc_oGrd.Column" + ALLTRIM(STR(loc_nI))
1590: 
1591:                 IF loc_nLargura > 0
1592:                     STORE loc_nLargura TO (loc_cCol + ".Width")
1593:                 ENDIF
1594: 
1595:                 STORE loc_lVisivel TO (loc_cCol + ".Visible")
1596: 
1597:                 loc_nPos = loc_nPos + 5
1598:             ENDFOR
1599:         ELSE
1600:             loc_cStr = ""
1601: 
1602:             FOR loc_nI = 1 TO loc_oGrd.ColumnCount
1603:                 loc_cCol     = "loc_oGrd.Column" + ALLTRIM(STR(loc_nI))
1604:                 loc_nLargura = EVALUATE(loc_cCol + ".Width")
1605:                 loc_lVisivel = EVALUATE(loc_cCol + ".Visible")
1606: 
1607:                 *-- Teto de 999: o bloco tem 3 posicoes para a largura e uma
1608:                 *-- coluna arrastada alem disso produziria um bloco de 4
1609:                 *-- caracteres, deslocando TODOS os blocos seguintes na
1610:                 *-- leitura. O legado nao tem essa protecao (corrompe a
1611:                 *-- propria string); aqui o excedente eh apenas limitado.
1612:                 loc_nLargura = MIN(INT(loc_nLargura), 999)
1613: 
1614:                 loc_cStr = loc_cStr + PADL(ALLTRIM(STR(loc_nLargura)), 3, "0") + ;

*-- Linhas 1628 a 2550:
1628:     * (This.Width = 0) And (MessageBox([Deseja Ocultar a Coluna "] + lcHea +
1629:     * [" da Grade?], 4+32+256, [Ocultar Colunas]) = 6) / This.Visible = .f.)
1630:     *--------------------------------------------------------------------------
1631:     PROTECTED PROCEDURE OcultarColunaDados(par_nColuna)
1632:         LOCAL loc_oGrd, loc_cCol, loc_cHeader
1633: 
1634:         loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados
1635:         loc_cCol = "loc_oGrd.Column" + ALLTRIM(STR(par_nColuna))
1636: 
1637:         IF EVALUATE(loc_cCol + ".Width") = 0
1638:             loc_cHeader = ALLTRIM(EVALUATE(loc_cCol + ".Header1.Caption"))
1639: 
1640:             IF MsgConfirma("Deseja Ocultar a Coluna " + CHR(34) + loc_cHeader + CHR(34) + ;
1641:                     " da Grade?", "Ocultar Colunas")
1642:                 STORE .F. TO (loc_cCol + ".Visible")
1643:             ENDIF
1644:         ENDIF
1645:     ENDPROC
1646: 
1647:     *--------------------------------------------------------------------------
1648:     * ColunaDados<NN>Resize - Handlers do Resize de cada coluna da grade de
1649:     * resultado. PUBLIC obrigatorio (regra #3 do CLAUDE.md - BINDEVENT com
1650:     * metodo PROTECTED falha em silencio). O evento nao informa o objeto
1651:     * emissor, por isso um handler fino por coluna delegando o corpo unico.
1652:     *--------------------------------------------------------------------------
1653:     PROCEDURE ColunaDados01Resize()
1654:         THIS.OcultarColunaDados(1)
1655:     ENDPROC
1656: 
1657:     PROCEDURE ColunaDados02Resize()
1658:         THIS.OcultarColunaDados(2)
1659:     ENDPROC
1660: 
1661:     PROCEDURE ColunaDados03Resize()
1662:         THIS.OcultarColunaDados(3)
1663:     ENDPROC
1664: 
1665:     PROCEDURE ColunaDados04Resize()
1666:         THIS.OcultarColunaDados(4)
1667:     ENDPROC
1668: 
1669:     PROCEDURE ColunaDados05Resize()
1670:         THIS.OcultarColunaDados(5)
1671:     ENDPROC
1672: 
1673:     PROCEDURE ColunaDados06Resize()
1674:         THIS.OcultarColunaDados(6)
1675:     ENDPROC
1676: 
1677:     PROCEDURE ColunaDados07Resize()
1678:         THIS.OcultarColunaDados(7)
1679:     ENDPROC
1680: 
1681:     PROCEDURE ColunaDados08Resize()
1682:         THIS.OcultarColunaDados(8)
1683:     ENDPROC
1684: 
1685:     PROCEDURE ColunaDados09Resize()
1686:         THIS.OcultarColunaDados(9)
1687:     ENDPROC
1688: 
1689:     PROCEDURE ColunaDados10Resize()
1690:         THIS.OcultarColunaDados(10)
1691:     ENDPROC
1692: 
1693:     PROCEDURE ColunaDados11Resize()
1694:         THIS.OcultarColunaDados(11)
1695:     ENDPROC
1696: 
1697:     PROCEDURE ColunaDados12Resize()
1698:         THIS.OcultarColunaDados(12)
1699:     ENDPROC
1700: 
1701:     PROCEDURE ColunaDados13Resize()
1702:         THIS.OcultarColunaDados(13)
1703:     ENDPROC
1704: 
1705:     PROCEDURE ColunaDados14Resize()
1706:         THIS.OcultarColunaDados(14)
1707:     ENDPROC
1708: 
1709:     PROCEDURE ColunaDados15Resize()
1710:         THIS.OcultarColunaDados(15)
1711:     ENDPROC
1712: 
1713:     PROCEDURE ColunaDados16Resize()
1714:         THIS.OcultarColunaDados(16)
1715:     ENDPROC
1716: 
1717:     *--------------------------------------------------------------------------
1718:     * GrdDadosProdutoDblClick - Duplo clique na coluna "Produto" abre a
1719:     * Pesquisa Global de Produtos filtrada pelo codigo da linha corrente
1720:     * (legado: grdDados1.Column7.Text1.DblClick - Do Form SigOpCgp NoShow,
1721:     * depois Commandgroup1.Command1.Click() + get_produto_inicial/
1722:     * get_produto_final = Padr(This.Value, 14) + cmd_consulta.Click()).
1723:     *
1724:     * Equivalentes no sistema novo (Formsigopcgp): GrpLimparFiltrosClick()
1725:     * para o Command1 que limpa os filtros, txt_4c_ProdutoI/txt_4c_ProdutoF
1726:     * da pagina de filtro para os dois get_produto_*, e BtnConsultarClick()
1727:     * para o cmd_consulta.
1728:     *
1729:     * DUAS divergencias DELIBERADAS do legado, pelas razoes abaixo:
1730:     * 1) O legado abre com NoShow e guarda a instancia em ThisForm.poObjExt1
1731:     *    para reusar; Formsigopcgp eh MODAL (WindowType = 1), entao nao ha
1732:     *    instancia viva para reusar e a tela eh exibida com Show() - sem
1733:     *    isso o usuario daria o duplo clique e nada apareceria.
1734:     * 2) A guarda goSistema.ConsultaAberta do legado nao tem contrapartida:
1735:     *    essa property nao existe em go_4c_Sistema e nada no sistema novo a
1736:     *    mantem, de modo que testa-la seria sempre .F. (equivalente a
1737:     *    omiti-la).
1738:     *--------------------------------------------------------------------------
1739:     PROCEDURE GrdDadosProdutoDblClick()
1740:         LOCAL loc_cCursor, loc_cCodigo, loc_oForm, loc_oPagFiltro, loc_oErro
1741: 
1742:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
1743:         loc_cCodigo = ""
1744: 
1745:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1746:             loc_cCodigo = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Codigo_Item"), ""))
1747:         ENDIF
1748: 
1749:         IF EMPTY(loc_cCodigo)
1750:             RETURN
1751:         ENDIF
1752: 
1753:         TRY
1754:             GarantirClasse("Formsigopcgp")
1755:             loc_oForm = CREATEOBJECT("Formsigopcgp")
1756: 
1757:             IF VARTYPE(loc_oForm) = "O"
1758:                 loc_oForm.GrpLimparFiltrosClick()
1759: 
1760:                 loc_oPagFiltro = loc_oForm.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
1761:                 loc_oPagFiltro.txt_4c_ProdutoI.Value = PADR(loc_cCodigo, 14)
1762:                 loc_oPagFiltro.txt_4c_ProdutoF.Value = PADR(loc_cCodigo, 14)
1763: 
1764:                 loc_oForm.BtnConsultarClick()
1765:                 loc_oForm.Show()
1766:             ELSE
1767:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a Pesquisa " + ;
1768:                     "Global de Produtos.", "Pesquisa Global de Produtos")
1769:             ENDIF
1770:         CATCH TO loc_oErro
1771:             MsgErro(loc_oErro.Message, "Pesquisa Global de Produtos")
1772:         ENDTRY
1773:     ENDPROC
1774: 
1775:     *--------------------------------------------------------------------------
1776:     * AlternarPagina - Funil unico de navegacao entre FILTROS (Page1) e
1777:     * DADOS (Page2 - grade de resultado; legado: cmgRetornar.Click volta
1778:     * para a Page1). Este form NAO eh CRUD - nao ha botoes de lista para
1779:     * reabilitar (regra #40 nao se aplica), so o modo atual do form.
1780:     *--------------------------------------------------------------------------
1781:     PROCEDURE AlternarPagina(par_nPagina)
1782:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1783: 
1784:         IF par_nPagina = 1
1785:             THIS.this_cModoAtual = "FILTROS"
1786:         ELSE
1787:             THIS.this_cModoAtual = "DADOS"
1788: 
1789:             *-- Repintar SO DEPOIS de trocar o ActivePage: Refresh em pagina
1790:             *-- OCULTA nao pinta (regra #21 do CLAUDE.md) - por isso o funil
1791:             *-- de repintura mora aqui e nao no caller.
1792:             THIS.CarregarGradeResultado()
1793:         ENDIF
1794:     ENDPROC
1795: 
1796:     *--------------------------------------------------------------------------
1797:     * BtnMarcaClick / BtnDesmarcaClick - Marcar/Desmarcar Tudo na grade de
1798:     * Tipos de Operacao (legado: btnMarca.Click / btnDesmarca.Click).
1799:     *--------------------------------------------------------------------------
1800:     PROCEDURE BtnMarcaClick()
1801:         LOCAL loc_cCursor
1802:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
1803: 
1804:         IF USED(loc_cCursor)
1805:             UPDATE (loc_cCursor) SET nMarcas = 1
1806:             GO TOP IN (loc_cCursor)
1807:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1808:         ENDIF
1809:     ENDPROC
1810: 
1811:     PROCEDURE BtnDesmarcaClick()
1812:         LOCAL loc_cCursor
1813:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
1814: 
1815:         IF USED(loc_cCursor)
1816:             UPDATE (loc_cCursor) SET nMarcas = 0
1817:             GO TOP IN (loc_cCursor)
1818:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1819:         ENDIF
1820:     ENDPROC
1821: 
1822:     *--------------------------------------------------------------------------
1823:     * BtnMarGdeClick / BtnDesGdeClick - Marcar/Desmarcar Tudo na grade de
1824:     * Grande Grupo (legado: btnMarGde.Click / btnDesGde.Click).
1825:     *--------------------------------------------------------------------------
1826:     PROCEDURE BtnMarGdeClick()
1827:         LOCAL loc_cCursor
1828:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGpr
1829: 
1830:         IF USED(loc_cCursor)
1831:             UPDATE (loc_cCursor) SET nMarcas = 1
1832:             GO TOP IN (loc_cCursor)
1833:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGpr.Refresh()
1834:         ENDIF
1835:     ENDPROC
1836: 
1837:     PROCEDURE BtnDesGdeClick()
1838:         LOCAL loc_cCursor
1839:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGpr
1840: 
1841:         IF USED(loc_cCursor)
1842:             UPDATE (loc_cCursor) SET nMarcas = 0
1843:             GO TOP IN (loc_cCursor)
1844:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGpr.Refresh()
1845:         ENDIF
1846:     ENDPROC
1847: 
1848:     *--------------------------------------------------------------------------
1849:     * BtnMarGrpClick / BtnDesGrpClick - Marcar/Desmarcar Tudo na grade de
1850:     * Grupo de Produto (legado: btnMarGrp.Click / btnDesGrp.Click).
1851:     *--------------------------------------------------------------------------
1852:     PROCEDURE BtnMarGrpClick()
1853:         LOCAL loc_cCursor
1854:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGru
1855: 
1856:         IF USED(loc_cCursor)
1857:             UPDATE (loc_cCursor) SET nMarcas = 1
1858:             GO TOP IN (loc_cCursor)
1859:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGru.Refresh()
1860:         ENDIF
1861:     ENDPROC
1862: 
1863:     PROCEDURE BtnDesGrpClick()
1864:         LOCAL loc_cCursor
1865:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGru
1866: 
1867:         IF USED(loc_cCursor)
1868:             UPDATE (loc_cCursor) SET nMarcas = 0
1869:             GO TOP IN (loc_cCursor)
1870:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGru.Refresh()
1871:         ENDIF
1872:     ENDPROC
1873: 
1874:     *--------------------------------------------------------------------------
1875:     * BtnConsultarClick - Valida o periodo informado (legado: cmgFiltros.
1876:     * Command1.Click) e processa os movimentos filtrados (legado:
1877:     * ThisForm.Processamento(), chamado apos as mesmas 3 validacoes de
1878:     * data). Com sucesso, segue para a pagina de Dados e repinta a grade
1879:     * de resultado (legado: ActivePage=2 + AfterRowColChange, codigo_
1880:     * fonte.txt:2729-2733).
1881:     *--------------------------------------------------------------------------
1882:     PROCEDURE BtnConsultarClick()
1883:         LOCAL loc_oPag, loc_dIni, loc_dFim
1884: 
1885:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1886:         loc_dIni = loc_oPag.txt_4c_DcI.Value
1887:         loc_dFim = loc_oPag.txt_4c_DcF.Value
1888: 
1889:         IF EMPTY(loc_dIni)
1890:             MsgAviso("A Data Inicial n" + CHR(227) + "o " + CHR(233) + " v" + CHR(225) + "lida!!!", ;
1891:                 "Dados Inv" + CHR(225) + "lidos!!!")
1892:             loc_oPag.txt_4c_DcI.SetFocus()
1893:             RETURN
1894:         ENDIF
1895: 
1896:         IF EMPTY(loc_dFim)
1897:             MsgAviso("A Data Final n" + CHR(227) + "o " + CHR(233) + " v" + CHR(225) + "lida!!!", ;
1898:                 "Dados Inv" + CHR(225) + "lidos!!!")
1899:             loc_oPag.txt_4c_DcF.SetFocus()
1900:             RETURN
1901:         ENDIF
1902: 
1903:         IF loc_dIni > loc_dFim
1904:             MsgAviso("A Data Inicial n" + CHR(227) + "o Pode Ser Maior Que a Final!!!", ;
1905:                 "Dados Inv" + CHR(225) + "lidos!!!")
1906:             loc_oPag.txt_4c_DcI.SetFocus()
1907:             RETURN
1908:         ENDIF
1909: 
1910:         THIS.CarregarDados()
1911:     ENDPROC
1912: 
1913:     *--------------------------------------------------------------------------
1914:     * CarregarDados - FUNIL unico de carga da grade de resultado (legado:
1915:     * cmgFiltros.Command1.Click -> ThisForm.Processamento() -> ActivePage=2).
1916:     * Captura a tela nas propriedades do BO (FormParaBO), processa e, com
1917:     * sucesso, vai para a pagina de Dados - que eh quem repinta a grade
1918:     * (AlternarPagina(2) -> CarregarGradeResultado, regra #21 do CLAUDE.md).
1919:     *--------------------------------------------------------------------------
1920:     PROCEDURE CarregarDados()
1921:         LOCAL loc_lSucesso
1922: 
1923:         loc_lSucesso = .F.
1924: 
1925:         IF THIS.FormParaBO()
1926:             *-- BO ja exibe o proprio MsgErro (ver Processar() no BO) - o form
1927:             *-- so segue adiante se o processamento deu certo (regra #20 do
1928:             *-- CLAUDE.md - falha de processamento nunca eh muda).
1929:             IF THIS.this_oBusinessObject.Processar()
1930:                 THIS.AlternarPagina(2)
1931:                 loc_lSucesso = .T.
1932:             ENDIF
1933:         ENDIF
1934: 
1935:         RETURN loc_lSucesso
1936:     ENDPROC
1937: 
1938:     *--------------------------------------------------------------------------
1939:     * FormParaBO - Transfere os filtros digitados na Page1 para as
1940:     * propriedades do BO (legado: o Click de cmgFiltros le getDcI/getDcF/
1941:     * getEmpOs/getOperacao direto dos controles). PROTECTED obrigatorio:
1942:     * FormBase declara este hook como PROTECTED e VFP9 nao permite ALARGAR
1943:     * o escopo de metodo herdado.
1944:     *--------------------------------------------------------------------------
1945:     PROTECTED PROCEDURE FormParaBO()
1946:         LOCAL loc_oPag, loc_oBO
1947: 
1948:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1949:         loc_oBO  = THIS.this_oBusinessObject
1950: 
1951:         loc_oBO.this_dDataIni     = loc_oPag.txt_4c_DcI.Value
1952:         loc_oBO.this_dDataFim     = loc_oPag.txt_4c_DcF.Value
1953:         loc_oBO.this_cEmpresa     = ALLTRIM(loc_oPag.txt_4c_EmpOs.Value)
1954:         loc_oBO.this_cDescEmpresa = ALLTRIM(loc_oPag.txt_4c_DEmpOs.Value)
1955:         loc_oBO.this_cOperacao    = ALLTRIM(loc_oPag.txt_4c_Operacao.Value)
1956: 
1957:         *-- Layout da grade: SEM ALLTRIM - a string eh POSICIONAL (blocos de
1958:         *-- 5 posicoes por coluna, a 5a eh um BRANCO reservado pelo legado).
1959:         loc_oBO.this_cCfgGrade = loc_oPag.txt_4c_CfgGrade.Value
1960: 
1961:         RETURN .T.
1962:     ENDPROC
1963: 
1964:     *--------------------------------------------------------------------------
1965:     * BOParaForm - Espelha os filtros do BO nos controles da Page1 (legado:
1966:     * bloco do Init que faz getDcI.Value = Date(), getDcF.Value = Date(),
1967:     * getOperacao.Value = [], getEmpOs.Value = _Empr e getDEmpOs.Value =
1968:     * crSigCdEmp.Razas). PROTECTED pelo mesmo motivo de FormParaBO.
1969:     *--------------------------------------------------------------------------
1970:     PROTECTED PROCEDURE BOParaForm()
1971:         LOCAL loc_oPag, loc_oBO
1972: 
1973:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1974:         loc_oBO  = THIS.this_oBusinessObject
1975: 
1976:         loc_oPag.txt_4c_DcI.Value      = ConverterParaData(loc_oBO.this_dDataIni)
1977:         loc_oPag.txt_4c_DcF.Value      = ConverterParaData(loc_oBO.this_dDataFim)
1978:         loc_oPag.txt_4c_EmpOs.Value    = loc_oBO.this_cEmpresa
1979:         loc_oPag.txt_4c_DEmpOs.Value   = loc_oBO.this_cDescEmpresa
1980:         loc_oPag.txt_4c_Operacao.Value = loc_oBO.this_cOperacao
1981:         loc_oPag.txt_4c_CfgGrade.Value = loc_oBO.this_cCfgGrade
1982: 
1983:         RETURN .T.
1984:     ENDPROC
1985: 
1986:     *--------------------------------------------------------------------------
1987:     * CarregarGradeResultado - Repinta a grade de resultado e espelha a
1988:     * linha corrente nas propriedades this_Res* do BO (legado: ActivePage
1989:     * do PageFrame interno + AfterRowColChange explicito apos trocar de
1990:     * pagina, codigo_fonte.txt:2731-2733 - regra #21 do CLAUDE.md, popular
1991:     * cursor nao repinta a grade sozinho).
1992:     *--------------------------------------------------------------------------
1993:     PROCEDURE CarregarGradeResultado()
1994:         LOCAL loc_cCursor
1995: 
1996:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
1997: 
1998:         IF USED(loc_cCursor)
1999:             GO TOP IN (loc_cCursor)
2000:         ENDIF
2001: 
2002:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados.Refresh()
2003:         THIS.GrdDadosAfterRowColChange(1)
2004:     ENDPROC
2005: 
2006:     *--------------------------------------------------------------------------
2007:     * BtnSairClick - Encerra o form, gravando antes o layout da grade de
2008:     * resultado (legado: cmgFiltros.Command2.Click = ThisForm.AcertaColunas
2009:     * ([GRAVAR]) + ThisForm.Release; o Release do legado chama tambem
2010:     * poSigSyPar.fGravaUserCfg(), e aqui a persistencia esta dentro do
2011:     * proprio AcertaColunas("GRAVAR")).
2012:     *--------------------------------------------------------------------------
2013:     PROCEDURE BtnSairClick()
2014:         THIS.AcertaColunas("GRAVAR")
2015:         THIS.Release()
2016:     ENDPROC
2017: 
2018:     *--------------------------------------------------------------------------
2019:     * ValidarEmpOsLostFocus - Resolve o codigo de Empresa digitado contra
2020:     * SigCdEmp (legado: getEmpOs.Valid/getDEmpOs.Valid = fAcessoEmpresa(Usuar,
2021:     * "C"|"D", ...) - funcao global Fortyus NAO portada). Match exato
2022:     * preenche codigo+descricao direto; sem match, abre o picker (regra #50
2023:     * do CLAUDE.md - sem MsgAviso, sem apagar o que o usuario digitou).
2024:     *--------------------------------------------------------------------------
2025:     PROCEDURE ValidarEmpOsLostFocus()
2026:         LOCAL loc_oPag, loc_cCodigo, loc_cSQL, loc_nResultado
2027: 
2028:         IF THIS.this_lEmLookupEmpresa
2029:             RETURN
2030:         ENDIF
2031: 
2032:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
2033:         loc_cCodigo = ALLTRIM(loc_oPag.txt_4c_EmpOs.Value)
2034: 
2035:         IF EMPTY(loc_cCodigo)
2036:             loc_oPag.txt_4c_DEmpOs.Value = ""
2037:             RETURN
2038:         ENDIF
2039: 
2040:         IF USED("cursor_4c_BuscaEmp")
2041:             USE IN cursor_4c_BuscaEmp
2042:         ENDIF
2043: 
2044:         loc_cSQL       = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCodigo)
2045:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
2046: 
2047:         IF loc_nResultado > 0 AND USED("cursor_4c_BuscaEmp") AND RECCOUNT("cursor_4c_BuscaEmp") > 0
2048:             loc_oPag.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2049:             loc_oPag.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2050:         ELSE
2051:             THIS.AbrirLookupEmpresa()
2052:         ENDIF
2053: 
2054:         IF USED("cursor_4c_BuscaEmp")
2055:             USE IN cursor_4c_BuscaEmp
2056:         ENDIF
2057:     ENDPROC
2058: 
2059:     *--------------------------------------------------------------------------
2060:     * EmpOsKeyPress - F4 abre o picker de Empresa direto (regra #47 - so com
2061:     * o teste da tecla; os demais caracteres seguem para o LostFocus).
2062:     *--------------------------------------------------------------------------
2063:     PROCEDURE EmpOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2064:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2065:             THIS.AbrirLookupEmpresa()
2066:         ENDIF
2067:     ENDPROC
2068: 
2069:     *--------------------------------------------------------------------------
2070:     * AbrirLookupEmpresa - Picker de Empresa (SigCdEmp), substituicao
2071:     * canonica de fAcessoEmpresa em modo LOOKUP (memoria: "fAcessoEmpresa
2072:     * nao portada"). Guarda de reentrancia porque o Show() eh modal e tira/
2073:     * devolve o foco, redisparando o proprio LostFocus (regra #37).
2074:     *--------------------------------------------------------------------------
2075:     PROCEDURE AbrirLookupEmpresa()
2076:         LOCAL loc_oPag, loc_oBusca, loc_oErro
2077: 
2078:         IF THIS.this_lEmLookupEmpresa
2079:             RETURN
2080:         ENDIF
2081:         THIS.this_lEmLookupEmpresa = .T.
2082: 
2083:         TRY
2084:             loc_oPag = THIS.pgf_4c_Paginas.Page1
2085: 
2086:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2087:                 "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", ;
2088:                 ALLTRIM(loc_oPag.txt_4c_EmpOs.Value), ;
2089:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa")
2090: 
2091:             IF VARTYPE(loc_oBusca) = "O"
2092:                 IF !loc_oBusca.this_lAchouRegistro
2093:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
2094:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
2095:                     loc_oBusca.Show()
2096:                 ENDIF
2097: 
2098:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
2099:                     SELECT cursor_4c_BuscaEmp
2100:                     loc_oPag.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2101:                     loc_oPag.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2102:                 ENDIF
2103: 
2104:                 loc_oBusca.Release()
2105:             ENDIF
2106: 
2107:             IF USED("cursor_4c_BuscaEmp")
2108:                 USE IN cursor_4c_BuscaEmp
2109:             ENDIF
2110:         CATCH TO loc_oErro
2111:             MsgErro(loc_oErro.Message, "Erro")
2112:         ENDTRY
2113: 
2114:         THIS.this_lEmLookupEmpresa = .F.
2115:     ENDPROC
2116: 
2117:     *--------------------------------------------------------------------------
2118:     * ValidarOperacaoLostFocus - Resolve o codigo de Operacao/Movimentacao
2119:     * digitado contra SigCdOpe (legado: getOperacao.Valid = fAcessoMovmto -
2120:     * funcao global Fortyus NAO portada). SigCdOpe eh single-column - Dopes
2121:     * eh PK e descricao ao mesmo tempo (memoria: "SigCdOpe single column" -
2122:     * NUNCA adicionar uma 2a coluna de descricao).
2123:     *--------------------------------------------------------------------------
2124:     PROCEDURE ValidarOperacaoLostFocus()
2125:         LOCAL loc_oPag, loc_cCodigo, loc_cSQL, loc_nResultado
2126: 
2127:         IF THIS.this_lEmLookupOperacao
2128:             RETURN
2129:         ENDIF
2130: 
2131:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
2132:         loc_cCodigo = ALLTRIM(loc_oPag.txt_4c_Operacao.Value)
2133: 
2134:         IF EMPTY(loc_cCodigo)
2135:             RETURN
2136:         ENDIF
2137: 
2138:         IF USED("cursor_4c_BuscaOpe")
2139:             USE IN cursor_4c_BuscaOpe
2140:         ENDIF
2141: 
2142:         loc_cSQL       = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cCodigo)
2143:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
2144: 
2145:         IF loc_nResultado > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
2146:             loc_oPag.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
2147:         ELSE
2148:             THIS.AbrirLookupOperacao()
2149:         ENDIF
2150: 
2151:         IF USED("cursor_4c_BuscaOpe")
2152:             USE IN cursor_4c_BuscaOpe
2153:         ENDIF
2154:     ENDPROC
2155: 
2156:     *--------------------------------------------------------------------------
2157:     * OperacaoKeyPress - F4 abre o picker de Operacao direto.
2158:     *--------------------------------------------------------------------------
2159:     PROCEDURE OperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2160:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2161:             THIS.AbrirLookupOperacao()
2162:         ENDIF
2163:     ENDPROC
2164: 
2165:     *--------------------------------------------------------------------------
2166:     * AbrirLookupOperacao - Picker de Operacao (SigCdOpe), substituicao
2167:     * canonica de fAcessoMovmto. Guarda de reentrancia pelo mesmo motivo do
2168:     * AbrirLookupEmpresa.
2169:     *--------------------------------------------------------------------------
2170:     PROCEDURE AbrirLookupOperacao()
2171:         LOCAL loc_oPag, loc_oBusca, loc_oErro
2172: 
2173:         IF THIS.this_lEmLookupOperacao
2174:             RETURN
2175:         ENDIF
2176:         THIS.this_lEmLookupOperacao = .T.
2177: 
2178:         TRY
2179:             loc_oPag = THIS.pgf_4c_Paginas.Page1
2180: 
2181:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2182:                 "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
2183:                 ALLTRIM(loc_oPag.txt_4c_Operacao.Value), ;
2184:                 "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o")
2185: 
2186:             IF VARTYPE(loc_oBusca) = "O"
2187:                 IF !loc_oBusca.this_lAchouRegistro
2188:                     loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
2189:                     loc_oBusca.Show()
2190:                 ENDIF
2191: 
2192:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
2193:                     SELECT cursor_4c_BuscaOpe
2194:                     loc_oPag.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
2195:                 ENDIF
2196: 
2197:                 loc_oBusca.Release()
2198:             ENDIF
2199: 
2200:             IF USED("cursor_4c_BuscaOpe")
2201:                 USE IN cursor_4c_BuscaOpe
2202:             ENDIF
2203:         CATCH TO loc_oErro
2204:             MsgErro(loc_oErro.Message, "Erro")
2205:         ENDTRY
2206: 
2207:         THIS.this_lEmLookupOperacao = .F.
2208:     ENDPROC
2209: 
2210:     *--------------------------------------------------------------------------
2211:     * ConfigurarEventosPaginaDados - BINDEVENT dos controles da pagina de
2212:     * Dados (grade de resultado e os botoes ao redor dela - Restaurar Grade/
2213:     * Cadastro/Movimento/Subniveis/Busca por codigo - e os botoes de nivel
2214:     * da Page2 - Retornar/Visualizar/Excel/Imprimir).
2215:     *--------------------------------------------------------------------------
2216:     PROTECTED PROCEDURE ConfigurarEventosPaginaDados()
2217:         LOCAL loc_oPagRes, loc_oPagDados
2218: 
2219:         loc_oPagRes   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
2220:         loc_oPagDados = THIS.pgf_4c_Paginas.Page2
2221: 
2222:         BINDEVENT(loc_oPagRes.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
2223:         BINDEVENT(loc_oPagRes.txt_4c_Busca, "KeyPress", THIS, "BuscaCodigoKeyPress")
2224:         BINDEVENT(loc_oPagRes.cmd_4c_BtnRestaurar, "Click", THIS, "BtnRestaurarClick")
2225:         BINDEVENT(loc_oPagRes.cmd_4c_BtnProduto, "Click", THIS, "BtnProdutoClick")
2226:         BINDEVENT(loc_oPagRes.obj_4c_CmdOperacao.Buttons(1), "Click", THIS, "BtnOperacaoClick")
2227:         BINDEVENT(loc_oPagRes.cmd_4c_SubNiveis, "Click", THIS, "BtnSubNiveisClick")
2228: 
2229:         BINDEVENT(loc_oPagDados.obj_4c_CmgRetornar.Buttons(1), "Click", THIS, "BtnRetornarClick")
2230:         BINDEVENT(loc_oPagDados.cmd_4c_BtnVisualizar, "Click", THIS, "BtnVisualizarClick")
2231:         BINDEVENT(loc_oPagDados.cmd_4c_BtnExcel, "Click", THIS, "GerarXLS")
2232:         BINDEVENT(loc_oPagDados.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")
2233: 
2234:         *-- Coluna "Produto": duplo clique abre a Pesquisa Global de Produtos
2235:         *-- (legado: grdDados1.Column7.Text1.DblClick).
2236:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column7.Text1, "DblClick", THIS, "GrdDadosProdutoDblClick")
2237: 
2238:         *-- Resize de CADA coluna da grade de resultado: arrastar a largura
2239:         *-- para 0 pergunta se o usuario quer ocultar a coluna (legado:
2240:         *-- grdDados1.Column<N>.Resize, as 16 com o MESMO corpo). Um handler
2241:         *-- fino por coluna porque o evento nao informa qual objeto disparou
2242:         *-- (AEVENTS consulta POR objeto de origem, nao devolve o emissor).
2243:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column1,  "Resize", THIS, "ColunaDados01Resize")
2244:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column2,  "Resize", THIS, "ColunaDados02Resize")
2245:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column3,  "Resize", THIS, "ColunaDados03Resize")
2246:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column4,  "Resize", THIS, "ColunaDados04Resize")
2247:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column5,  "Resize", THIS, "ColunaDados05Resize")
2248:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column6,  "Resize", THIS, "ColunaDados06Resize")
2249:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column7,  "Resize", THIS, "ColunaDados07Resize")
2250:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column8,  "Resize", THIS, "ColunaDados08Resize")
2251:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column9,  "Resize", THIS, "ColunaDados09Resize")
2252:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column10, "Resize", THIS, "ColunaDados10Resize")
2253:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column11, "Resize", THIS, "ColunaDados11Resize")
2254:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column12, "Resize", THIS, "ColunaDados12Resize")
2255:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column13, "Resize", THIS, "ColunaDados13Resize")
2256:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column14, "Resize", THIS, "ColunaDados14Resize")
2257:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column15, "Resize", THIS, "ColunaDados15Resize")
2258:         BINDEVENT(loc_oPagRes.grd_4c_Dados.Column16, "Resize", THIS, "ColunaDados16Resize")
2259:     ENDPROC
2260: 
2261:     *--------------------------------------------------------------------------
2262:     * GrdDadosAfterRowColChange - Espelha a linha corrente da grade de
2263:     * resultado nas propriedades this_Res* do BO (CarregarDoCursor) e
2264:     * atualiza o painel de observacao/imagem do item (legado: ControlSource
2265:     * direto de getObsItn/ImgFigJpg em crPgRes01, que se atualizava sozinho
2266:     * ao mudar de linha). Sem filtro de coluna, igual aos outros 11 dos 12
2267:     * handlers do projeto que usam AfterRowColChange para carregar detalhe
2268:     * da linha corrente (regra #46 do CLAUDE.md).
2269:     *--------------------------------------------------------------------------
2270:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2271:         THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_oBusinessObject.this_cCursorDados)
2272:         THIS.AtualizarDetalheItem()
2273:     ENDPROC
2274: 
2275:     *--------------------------------------------------------------------------
2276:     * AtualizarDetalheItem - Copia this_cResObsItem para o EditBox e decodifica
2277:     * this_cResImagem (base64, com os 3 prefixos data:image/... do legado) para
2278:     * um arquivo temporario, exibindo-o no Image (legado: ImgFigJpg.Click).
2279:     *--------------------------------------------------------------------------
2280:     PROTECTED PROCEDURE AtualizarDetalheItem()
2281:         LOCAL loc_oPagRes, loc_cArquivo, loc_cFoto
2282: 
2283:         loc_oPagRes = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
2284: 
2285:         loc_oPagRes.edt_4c_ObsItem.Value = THIS.this_oBusinessObject.this_cResObsItem
2286: 
2287:         loc_oPagRes.img_4c_FigProduto.Picture = ""
2288:         loc_oPagRes.img_4c_FigProduto.Visible = .F.
2289: 
2290:         IF !EMPTY(THIS.this_oBusinessObject.this_cResImagem)
2291:             loc_cArquivo = ADDBS(SYS(2023)) + "sigoppck_" + SYS(2015) + ".jpg"
2292:             loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(THIS.this_oBusinessObject.this_cResImagem, ;
2293:                 "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), "data:image/jpg;base64,", ""), 14)
2294:             STRTOFILE(loc_cFoto, loc_cArquivo)
2295: 
2296:             IF FILE(loc_cArquivo)
2297:                 loc_oPagRes.img_4c_FigProduto.Picture = loc_cArquivo
2298:                 loc_oPagRes.img_4c_FigProduto.Visible = .T.
2299:             ENDIF
2300:         ENDIF
2301:     ENDPROC
2302: 
2303:     *--------------------------------------------------------------------------
2304:     * BuscaCodigoKeyPress - Busca POSICIONAL (nao-lookup) do numero do
2305:     * movimento dentro do cursor ja carregado (legado: getBusca.Valid/
2306:     * LostFocus - Locate For Numero = This.Value, depois foca a coluna 3).
2307:     *--------------------------------------------------------------------------
2308:     PROCEDURE BuscaCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2309:         LOCAL loc_oPagRes, loc_cCursor, loc_nValor
2310: 
2311:         IF INLIST(par_nKeyCode, 13, 9)
2312:             loc_oPagRes = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
2313:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2314:             loc_nValor  = loc_oPagRes.txt_4c_Busca.Value
2315: 
2316:             IF loc_nValor > 0 AND USED(loc_cCursor)
2317:                 SELECT (loc_cCursor)
2318:                 GO TOP
2319:                 LOCATE FOR Numero = loc_nValor
2320:                 loc_oPagRes.grd_4c_Dados.Refresh()
2321: 
2322:                 IF par_nKeyCode = 13
2323:                     loc_oPagRes.grd_4c_Dados.Column3.SetFocus()
2324:                 ENDIF
2325:             ENDIF
2326:         ENDIF
2327:     ENDPROC
2328: 
2329:     *--------------------------------------------------------------------------
2330:     * BtnRestaurarClick - Restaura larguras/visibilidade das colunas da
2331:     * grade de resultado para o padrao do legado e REGRAVA o layout
2332:     * (legado: btnRestaurar.Click = If MessageBox(...) = 6 / GradePadrao() /
2333:     * AcertaColunas([GRAVAR])).
2334:     *--------------------------------------------------------------------------
2335:     PROCEDURE BtnRestaurarClick()
2336:         IF MsgConfirma("Deseja Restaurar as Colunas da Grade (Ocultas e Larguras)?", "Restaurar Grade")
2337:             THIS.GradePadrao()
2338:             THIS.AcertaColunas("GRAVAR")
2339:         ENDIF
2340:     ENDPROC
2341: 
2342:     *--------------------------------------------------------------------------
2343:     * BtnProdutoClick - Abre o Cadastro de Produtos para o item da linha
2344:     * corrente (legado: btnProduto.Click = Do Form SigCdPro linked, que no
2345:     * sistema novo eh FormProduto - CRUD independente, sem parametro de
2346:     * codigo posicional; o usuario busca pelo codigo indicado no aviso,
2347:     * mesmo padrao usado em Formsigoporc.BtnCadastroProdutoClick).
2348:     *--------------------------------------------------------------------------
2349:     PROCEDURE BtnProdutoClick()
2350:         LOCAL loc_cCursor, loc_cCodigoItem, loc_oForm
2351: 
2352:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2353: 
2354:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
2355:             loc_cCodigoItem = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Codigo_Item"), ""))
2356: 
2357:             IF !EMPTY(loc_cCodigoItem)
2358:                 MsgInfo("Produto: " + loc_cCodigoItem + CHR(13) + ;
2359:                     "Digite esse c" + CHR(243) + "digo na busca do Cadastro de Produtos.", ;
2360:                     "Cadastro do Produto")
2361: 
2362:                 GarantirClasse("FormProduto")
2363:                 loc_oForm = CREATEOBJECT("FormProduto")
2364:                 IF VARTYPE(loc_oForm) = "O"
2365:                     loc_oForm.Show()
2366:                 ENDIF
2367:             ENDIF
2368:         ENDIF
2369: 
2370:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados.SetFocus()
2371:     ENDPROC
2372: 
2373:     *--------------------------------------------------------------------------
2374:     * BtnOperacaoClick - Abre o movimento de origem do item corrente
2375:     * (legado: cmdOperacao.btnOperacao.Valid): valida a linha selecionada,
2376:     * confere se a operacao existe em SigCdOpe (Pedido - abre FormSigMvExp)
2377:     * ou SigCdOpd (Devolucao - abre FormSigMvPdt).
2378:     *--------------------------------------------------------------------------
2379:     PROCEDURE BtnOperacaoClick()
2380:         LOCAL loc_cCursor, loc_cEmpresa, loc_cMovimentacao, loc_nNumero, ;
2381:             loc_cSQL, loc_nResultado, loc_oForm
2382: 
2383:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2384: 
2385:         loc_cEmpresa      = ""
2386:         loc_cMovimentacao = ""
2387:         loc_nNumero       = 0
2388: 
2389:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
2390:             loc_cEmpresa      = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Empresa"), ""))
2391:             loc_cMovimentacao = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Movimentacao"), ""))
2392:             loc_nNumero       = TratarNulo(EVALUATE(loc_cCursor + ".Numero"), 0)
2393:         ENDIF
2394: 
2395:         IF EMPTY(loc_cEmpresa) OR EMPTY(loc_cMovimentacao) OR loc_nNumero = 0
2396:             MsgAviso("Selecione Um Registro V" + CHR(225) + "lido Na Grade de Itens!!!", ;
2397:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
2398:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados.SetFocus()
2399:             RETURN
2400:         ENDIF
2401: 
2402:         IF USED("cursor_4c_TmpOpe")
2403:             USE IN cursor_4c_TmpOpe
2404:         ENDIF
2405: 
2406:         loc_cSQL       = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cMovimentacao)
2407:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2408: 
2409:         IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
2410:             IF USED("cursor_4c_TmpOpe")
2411:                 USE IN cursor_4c_TmpOpe
2412:             ENDIF
2413: 
2414:             GarantirClasse("FormSigMvExp")
2415:             loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cMovimentacao, "C", loc_nNumero, loc_cEmpresa, .T.)
2416:             IF VARTYPE(loc_oForm) = "O"
2417:                 loc_oForm.Show()
2418:             ENDIF
2419:         ELSE
2420:             IF USED("cursor_4c_TmpOpe")
2421:                 USE IN cursor_4c_TmpOpe
2422:             ENDIF
2423: 
2424:             loc_cSQL       = "SELECT Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cMovimentacao)
2425:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2426: 
2427:             IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
2428:                 GarantirClasse("FormSigMvPdt")
2429:                 loc_oForm = CREATEOBJECT("FormSigMvPdt", loc_cMovimentacao, "C", loc_nNumero, loc_cEmpresa, .T.)
2430:                 IF VARTYPE(loc_oForm) = "O"
2431:                     loc_oForm.Show()
2432:                 ENDIF
2433:             ENDIF
2434: 
2435:             IF USED("cursor_4c_TmpOpe")
2436:                 USE IN cursor_4c_TmpOpe
2437:             ENDIF
2438:         ENDIF
2439:     ENDPROC
2440: 
2441:     *--------------------------------------------------------------------------
2442:     * BtnSubNiveisClick - Abre a tela de Subniveis do item corrente (legado:
2443:     * SubNiveis.Click = Do Form SigMvSbn with Thisform, Empresa,
2444:     * Movimentacao, Numero - sem guarda no legado, transcrito igual; o
2445:     * proprio FormSigMvSbn tolera Empresa/Movimentacao vazios).
2446:     *--------------------------------------------------------------------------
2447:     PROCEDURE BtnSubNiveisClick()
2448:         LOCAL loc_cCursor, loc_cEmpresa, loc_cMovimentacao, loc_nNumero, loc_oForm
2449: 
2450:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2451: 
2452:         loc_cEmpresa      = ""
2453:         loc_cMovimentacao = ""
2454:         loc_nNumero       = 0
2455: 
2456:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
2457:             loc_cEmpresa      = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Empresa"), ""))
2458:             loc_cMovimentacao = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Movimentacao"), ""))
2459:             loc_nNumero       = TratarNulo(EVALUATE(loc_cCursor + ".Numero"), 0)
2460:         ENDIF
2461: 
2462:         GarantirClasse("FormSigMvSbn")
2463:         loc_oForm = CREATEOBJECT("FormSigMvSbn", THIS, loc_cEmpresa, loc_cMovimentacao, loc_nNumero)
2464:         IF VARTYPE(loc_oForm) = "O"
2465:             loc_oForm.Show()
2466:         ENDIF
2467:     ENDPROC
2468: 
2469:     *--------------------------------------------------------------------------
2470:     * BtnRetornarClick - Volta para a pagina de Filtros (legado:
2471:     * cmgRetornar.btnRetornar.Click = ThisForm.pgfPrincipal.ActivePage = 1).
2472:     *--------------------------------------------------------------------------
2473:     PROCEDURE BtnRetornarClick()
2474:         THIS.AlternarPagina(1)
2475:     ENDPROC
2476: 
2477:     *--------------------------------------------------------------------------
2478:     * BtnVisualizarClick - Preview do REPORT FORM SigOpPck (legado:
2479:     * btnVisualizar.Click = Index on SubGrupo+Codigo_Item + Report Form
2480:     * SigOpPck Preview). Guard de arquivo ausente (regra #25/#49 do
2481:     * CLAUDE.md) - o FRX ainda nao foi portado nesta fase.
2482:     *--------------------------------------------------------------------------
2483:     PROCEDURE BtnVisualizarClick()
2484:         THIS.ExecutarRelatorioSigOpPck("PREVIEW")
2485:     ENDPROC
2486: 
2487:     *--------------------------------------------------------------------------
2488:     * BtnImprimirClick - Imprime o REPORT FORM SigOpPck com prompt de
2489:     * impressora (legado: BtnImprimir.Click = Index on SubGrupo+Codigo_Item
2490:     * + Report Form SigOpPck To PRINTER Prompt).
2491:     *--------------------------------------------------------------------------
2492:     PROCEDURE BtnImprimirClick()
2493:         THIS.ExecutarRelatorioSigOpPck("PRINTER_PROMPT")
2494:     ENDPROC
2495: 
2496:     *--------------------------------------------------------------------------
2497:     * ExecutarRelatorioSigOpPck - Funil comum de Visualizar/Imprimir: ordena
2498:     * o cursor de resultado (legado: Index on SubGrupo + Codigo_Item Tag
2499:     * Ordem1), isola SET POINT/SEPARATOR/REPORTBEHAVIOR (FRX legado Fortyus
2500:     * - regra do CLAUDE.md sobre isolamento de locale em REPORT FORM) e
2501:     * dispara o REPORT FORM, com guard de arquivo ausente.
2502:     *--------------------------------------------------------------------------
2503:     PROTECTED PROCEDURE ExecutarRelatorioSigOpPck(par_cModo)
2504:         LOCAL loc_cCursor, loc_cFrx, loc_cPointAnt, loc_cSeparatorAnt, ;
2505:             loc_nBehaviorAnt, loc_oErro
2506: 
2507:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2508: 
2509:         IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
2510:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para " + ;
2511:                 IIF(par_cModo = "PREVIEW", "visualizar", "imprimir") + ".", ;
2512:                 "Relat" + CHR(243) + "rio")
2513:             RETURN
2514:         ENDIF
2515: 
2516:         loc_cFrx = FULLPATH(gc_4c_CaminhoReports + "SigOpPck.frx")
2517: 
2518:         IF !FILE(loc_cFrx)
2519:             MostrarErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + loc_cFrx, "Erro")
2520:             RETURN
2521:         ENDIF
2522: 
2523:         SELECT (loc_cCursor)
2524: 
2525:         *-- O legado reindexa SO no Visualizar (btnVisualizar.Click = Index
2526:         *-- on SubGrupo + Codigo_Item Tag Ordem1 + Go Top + Report Form ...
2527:         *-- Preview); o Imprimir (BtnImprimir.Click) faz apenas Go Top +
2528:         *-- Report Form ... To PRINTER Prompt, mantendo a ordem corrente
2529:         *-- (Ordem3, posta por SigOpPckBO.MontarCursorDados). Reindexar nos
2530:         *-- dois mudaria a ordem do relatorio IMPRESSO.
2531:         IF par_cModo = "PREVIEW"
2532:             INDEX ON SubGrupo + Codigo_Item TAG Ordem1
2533:         ENDIF
2534: 
2535:         GO TOP
2536: 
2537:         loc_cPointAnt     = SET("POINT")
2538:         loc_cSeparatorAnt = SET("SEPARATOR")
2539:         loc_nBehaviorAnt  = SET("REPORTBEHAVIOR")
2540: 
2541:         TRY
2542:             SET POINT TO "."
2543:             SET SEPARATOR TO ","
2544:             SET REPORTBEHAVIOR 80
2545: 
2546:             IF par_cModo = "PREVIEW"
2547:                 REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
2548:             ELSE
2549:                 REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
2550:             ENDIF

*-- Linhas 2562 a 2605:
2562:     * ThisForm.GerarXLS() = PutFile + Select ... Order By ... Into Cursor
2563:     * crExcel + Copy To ... Type Xl5).
2564:     *--------------------------------------------------------------------------
2565:     PROCEDURE GerarXLS()
2566:         LOCAL loc_cCursor, loc_cArquivo
2567: 
2568:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2569: 
2570:         IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
2571:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para exportar.", ;
2572:                 "Exporta" + CHR(231) + CHR(227) + "o")
2573:             RETURN
2574:         ENDIF
2575: 
2576:         loc_cArquivo = PUTFILE("Nome da Planilha", "", "XLS")
2577: 
2578:         IF !EMPTY(loc_cArquivo)
2579:             IF USED("cursor_4c_Excel")
2580:                 USE IN cursor_4c_Excel
2581:             ENDIF
2582: 
2583:             SELECT * FROM (loc_cCursor) ;
2584:                 ORDER BY Destino, Ordem, Data_Venda, Movimentacao, Numero ;
2585:                 INTO CURSOR cursor_4c_Excel
2586: 
2587:             SELECT cursor_4c_Excel
2588:             COPY TO (loc_cArquivo) TYPE XL5
2589:             USE IN cursor_4c_Excel
2590: 
2591:             MsgInfo('O Arquivo "' + ALLTRIM(loc_cArquivo) + '" Foi Gerado!!!', ;
2592:                 "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
2593:         ENDIF
2594:     ENDPROC
2595: 
2596:     *--------------------------------------------------------------------------
2597:     * Destroy - this_oBusinessObject e o restauro do menu ja sao tratados em
2598:     * FormBase.Destroy(); DODEFAULT() tem de ser a ULTIMA linha (regra do
2599:     * fix menu-shrinks, Erro58).
2600:     *--------------------------------------------------------------------------
2601:     PROCEDURE Destroy()
2602:         DODEFAULT()
2603:     ENDPROC
2604: 
2605: ENDDEFINE

