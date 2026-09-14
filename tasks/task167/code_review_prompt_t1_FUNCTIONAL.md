# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_INFOPROD, CNT_4C_DETALHELINHA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [NAVEGACAO-PAGINA] Metodo 'GrdDadosDblClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [LAYOUT-POSITION] Controle 'Sair' (parent: SIGPRCPD): Left original=725 vs migrado 'cmd_4c_Sair' Left=916 (diff=191px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1541 linhas total):

*-- Linhas 38 a 139:
38: 
39:     *==========================================================================
40:     * Init - Recebe parametros do chamador (fase, unidade, data, codigo processo)
41:     * Armazena ANTES de DODEFAULT para que InicializarForm os encontre prontos
42:     *==========================================================================
43:     PROCEDURE Init(par_cFase, par_cUnidade, par_dData, par_nCodigo)
44:         THIS.this_cFase    = IIF(VARTYPE(par_cFase)    = "C", ALLTRIM(par_cFase),    "")
45:         THIS.this_cUnidade = IIF(VARTYPE(par_cUnidade) = "C", ALLTRIM(par_cUnidade), "")
46:         THIS.this_dData    = IIF(VARTYPE(par_dData)    = "D", par_dData,             DATE())
47:         THIS.this_nCodigo  = IIF(VARTYPE(par_nCodigo)  = "N", par_nCodigo,           0)
48:         RETURN DODEFAULT()
49:     ENDPROC
50: 
51:     *==========================================================================
52:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
53:     * Cria BO, monta cabecalho + PageFrame de conteudo e carrega dados iniciais
54:     *==========================================================================
55:     PROTECTED PROCEDURE InicializarForm()
56:         LOCAL loc_lSucesso, loc_oErro
57:         loc_lSucesso = .F.
58: 
59:         TRY
60:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
61: 
62:             THIS.this_oBusinessObject = CREATEOBJECT("sigprcpdBO")
63:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
64:                 MsgErro("Erro ao criar sigprcpdBO", "Erro")
65:             ELSE
66:                 THIS.LockScreen = .T.
67:                 THIS.ConfigurarCabecalho()
68:                 THIS.ConfigurarPageFrame()
69: 
70:                 *-- Carrega dados antes de configurar Page1 (cria cursor_4c_Dados)
71:                 IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
72:                     THIS.CarregarDados()
73:                 ENDIF
74: 
75:                 *-- Popula Page1 com grid e controles (usa cursor_4c_Dados se disponivel)
76:                 THIS.ConfigurarPaginaLista()
77:                 THIS.ConfigurarPaginaDados()
78: 
79:                 THIS.LockScreen = .F.
80: 
81:                 *-- Torna controles visiveis (filtra imagem/shape da foto do produto)
82:                 THIS.TornarControlesVisiveis(THIS)
83: 
84:                 loc_lSucesso = .T.
85:             ENDIF
86: 
87:         CATCH TO loc_oErro
88:             THIS.LockScreen = .F.
89:             MsgErro(loc_oErro.Message, "Erro InicializarForm")
90:         ENDTRY
91: 
92:         RETURN loc_lSucesso
93:     ENDPROC
94: 
95:     *==========================================================================
96:     * ConfigurarCabecalho - Container escuro no topo com titulo do form
97:     * Cria cnt_4c_Cabecalho (equivalente ao cntSombra do legado)
98:     *==========================================================================
99:     PROTECTED PROCEDURE ConfigurarCabecalho()
100:         LOCAL loc_oCab
101: 
102:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
103:         loc_oCab = THIS.cnt_4c_Cabecalho
104:         WITH loc_oCab
105:             .Top         = 0
106:             .Left        = 0
107:             .Width       = THIS.Width
108:             .Height      = 80
109:             .BackStyle   = 1
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112: 
113:             .AddObject("lbl_4c_Sombra", "Label")
114:             WITH .lbl_4c_Sombra
115:                 .AutoSize      = .F.
116:                 .Top           = 18
117:                 .Left          = 10
118:                 .Width         = loc_oCab.Width
119:                 .Height        = 40
120:                 .FontBold      = .T.
121:                 .FontName      = "Tahoma"
122:                 .FontSize      = 18
123:                 .FontUnderline = .F.
124:                 .WordWrap      = .T.
125:                 .Alignment     = 0
126:                 .BackStyle     = 0
127:                 .Caption       = "Capacidade Produtiva"
128:                 .ForeColor     = RGB(0, 0, 0)
129:             ENDWITH
130: 
131:             .AddObject("lbl_4c_Titulo", "Label")
132:             WITH .lbl_4c_Titulo
133:                 .AutoSize  = .F.
134:                 .Top       = 17
135:                 .Left      = 10
136:                 .Width     = loc_oCab.Width
137:                 .Height    = 46
138:                 .FontBold  = .T.
139:                 .FontName  = "Tahoma"

*-- Linhas 156 a 319:
156:     *   Page2 -> reservada para expansao futura (foto ampliada, historico, etc)
157:     * Fases seguintes populam as pages com grid, containers e campos.
158:     *==========================================================================
159:     PROTECTED PROCEDURE ConfigurarPageFrame()
160:         LOCAL loc_oPgf
161: 
162:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
163:         loc_oPgf = THIS.pgf_4c_Paginas
164: 
165:         WITH loc_oPgf
166:             .PageCount = 2
167:             .Top       = 80
168:             .Left      = 0
169:             .Width     = THIS.Width
170:             .Height    = THIS.Height - 80
171:             .TabIndex  = 1
172:             .Tabs      = .F.
173:             .BorderWidth = 0
174:             .BackStyle = 0
175: 
176:             .Page1.Caption = "Principal"
177:             .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
178: 
179:             .Page2.Caption = "Detalhes"
180:             .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
181: 
182:             .Visible    = .T.
183:             .ActivePage = 1
184:         ENDWITH
185:     ENDPROC
186: 
187:     *==========================================================================
188:     * CarregarDados - Delega ao BO o carregamento de todos os cursores
189:     * Chamado em InicializarForm e pode ser chamado novamente para refresh
190:     *==========================================================================
191:     PROCEDURE CarregarDados()
192:         LOCAL loc_lSucesso
193:         loc_lSucesso = THIS.this_oBusinessObject.CarregarDados( ;
194:             THIS.this_nCodigo, ;
195:             THIS.this_cFase, ;
196:             THIS.this_cUnidade, ;
197:             THIS.this_dData)
198:         IF !loc_lSucesso
199:             MsgErro("Falha ao carregar dados de capacidade produtiva.", "Erro")
200:         ENDIF
201:         RETURN loc_lSucesso
202:     ENDPROC
203: 
204:     *==========================================================================
205:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
206:     * Filtra imagem/shape da foto (img_4c_FigJpg/shp_4c_Shape4) que sao toggled
207:     * pelo AfterRowColChange do grid conforme registro selecionado tem FigJpgs.
208:     *==========================================================================
209:     PROCEDURE TornarControlesVisiveis(par_oContainer)
210:         LOCAL loc_i, loc_oControl, loc_cName
211:         FOR loc_i = 1 TO par_oContainer.ControlCount
212:             loc_oControl = par_oContainer.Controls(loc_i)
213:             IF VARTYPE(loc_oControl) != "O"
214:                 LOOP
215:             ENDIF
216: 
217:             loc_cName = UPPER(loc_oControl.Name)
218: 
219:             *-- Foto e shape do preview: recursar filhos mas NAO tornar visiveis
220:             IF INLIST(loc_cName, "IMG_4C_FIGJPG", "SHP_4C_SHAPE4")
221:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
222:                     THIS.TornarControlesVisiveis(loc_oControl)
223:                 ENDIF
224:                 LOOP
225:             ENDIF
226: 
227:             IF PEMSTATUS(loc_oControl, "Visible", 5)
228:                 loc_oControl.Visible = .T.
229:             ENDIF
230: 
231:             *-- PageFrame: recursar em Pages (nao em Controls direto)
232:             IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
233:                 LOCAL loc_p
234:                 FOR loc_p = 1 TO loc_oControl.PageCount
235:                     THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
236:                 ENDFOR
237:                 LOOP
238:             ENDIF
239: 
240:             *-- Container generico: recursar em Controls
241:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
242:                 THIS.TornarControlesVisiveis(loc_oControl)
243:             ENDIF
244:         ENDFOR
245:     ENDPROC
246: 
247:     *==========================================================================
248:     * ConfigurarPaginaLista - Popula Page1 com todos os controles:
249:     *   botao Encerrar, filtros (Fase/Data), metricas (Cap/Utz/Sld),
250:     *   grid de 8 colunas, campos informativos abaixo do grid e foto do produto.
251:     * Chamado APOS CarregarDados para que cursor_4c_Dados ja exista.
252:     *==========================================================================
253:     PROTECTED PROCEDURE ConfigurarPaginaLista()
254:         LOCAL loc_oPg, loc_oCnt1, loc_oCnt2, loc_oGrid
255: 
256:         loc_oPg = THIS.pgf_4c_Paginas.Page1
257: 
258:         *-- Botao Encerrar (topo direito da area de conteudo)
259:         loc_oPg.AddObject("cmd_4c_Sair", "CommandButton")
260:         WITH loc_oPg.cmd_4c_Sair
261:             .Top             = 5
262:             .Left            = 916
263:             .Width           = 75
264:             .Height          = 75
265:             .Caption         = "Encerrar"
266:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
267:             .FontName        = "Comic Sans MS"
268:             .FontBold        = .T.
269:             .FontItalic      = .T.
270:             .FontSize        = 8
271:             .ForeColor       = RGB(90, 90, 90)
272:             .BackColor       = RGB(255, 255, 255)
273:             .Themes          = .T.
274:             .SpecialEffect   = 0
275:             .PicturePosition = 13
276:             .MousePointer    = 15
277:             .WordWrap        = .T.
278:         ENDWITH
279:         BINDEVENT(loc_oPg.cmd_4c_Sair, "Click", THIS, "CmdSairClick")
280: 
281:         *-- Container1: parametros de consulta (Fase e Data)
282:         loc_oPg.AddObject("cnt_4c_Container1", "Container")
283:         loc_oCnt1 = loc_oPg.cnt_4c_Container1
284:         WITH loc_oCnt1
285:             .Top         = 24
286:             .Left        = 10
287:             .Width       = 347
288:             .Height      = 36
289:             .BackStyle   = 0
290:             .BorderWidth = 0
291: 
292:             .AddObject("lbl_4c_LblFase", "Label")
293:             WITH .lbl_4c_LblFase
294:                 .Top       = 8
295:                 .Left      = 2
296:                 .Width     = 50
297:                 .Height    = 17
298:                 .Caption   = "Fase :"
299:                 .FontName  = "Tahoma"
300:                 .FontSize  = 8
301:                 .BackStyle = 0
302:                 .ForeColor = RGB(90, 90, 90)
303:             ENDWITH
304: 
305:             .AddObject("txt_4c_Fase", "TextBox")
306:             WITH .txt_4c_Fase
307:                 .Top       = 5
308:                 .Left      = 55
309:                 .Width     = 125
310:                 .Height    = 23
311:                 .FontBold  = .T.
312:                 .FontName  = "Tahoma"
313:                 .FontSize  = 8
314:                 .BackColor = RGB(255, 198, 140)
315:                 .Value     = ""
316:                 .ReadOnly  = .T.
317:             ENDWITH
318: 
319:             .AddObject("lbl_4c_LblData", "Label")

*-- Linhas 567 a 611:
567:                 .Text1.FontSize      = 8
568:             ENDWITH
569:         ENDWITH
570:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
571:         BINDEVENT(loc_oGrid, "DblClick", THIS, "GrdDadosDblClick")
572: 
573:         *-- Labels e campos informativos abaixo do grid
574:         loc_oPg.AddObject("lbl_4c_LblQtde", "Label")
575:         WITH loc_oPg.lbl_4c_LblQtde
576:             .Top       = 378
577:             .Left      = 11
578:             .Width     = 80
579:             .Height    = 15
580:             .Caption   = "Quantidade"
581:             .FontName  = "Tahoma"
582:             .FontSize  = 8
583:             .BackStyle = 0
584:             .ForeColor = RGB(90, 90, 90)
585:         ENDWITH
586: 
587:         loc_oPg.AddObject("txt_4c_Qtde", "TextBox")
588:         WITH loc_oPg.txt_4c_Qtde
589:             .Top       = 391
590:             .Left      = 9
591:             .Width     = 92
592:             .Height    = 23
593:             .FontBold  = .T.
594:             .FontName  = "Tahoma"
595:             .FontSize  = 8
596:             .BackColor = RGB(255, 255, 198)
597:             .InputMask = "99999.999"
598:             .Value     = 0
599:             .ReadOnly  = .T.
600:         ENDWITH
601: 
602:         loc_oPg.AddObject("lbl_4c_LblDescr", "Label")
603:         WITH loc_oPg.lbl_4c_LblDescr
604:             .Top       = 378
605:             .Left      = 112
606:             .Width     = 180
607:             .Height    = 15
608:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto"
609:             .FontName  = "Tahoma"
610:             .FontSize  = 8
611:             .BackStyle = 0

*-- Linhas 731 a 774:
731:     * AtualizarGrid - Vincula grd_4c_Dados ao cursor_4c_Dados e atualiza metricas
732:     * Chamado apos CarregarDados. Pode ser chamado novamente para refresh.
733:     *==========================================================================
734:     PROCEDURE AtualizarGrid()
735:         LOCAL loc_oGrid, loc_oPg, loc_oCnt2
736:         loc_oPg   = THIS.pgf_4c_Paginas.Page1
737:         loc_oGrid = loc_oPg.grd_4c_Dados
738:         loc_oCnt2 = loc_oPg.cnt_4c_Container2
739: 
740:         IF !USED("cursor_4c_Dados")
741:             RETURN
742:         ENDIF
743: 
744:         WITH loc_oGrid
745:             .ColumnCount           = 8
746:             .RecordSource          = "cursor_4c_Dados"
747:             .Column1.ControlSource = "cursor_4c_Dados.Nenvs"
748:             .Column2.ControlSource = "cursor_4c_Dados.Nops"
749:             .Column3.ControlSource = "cursor_4c_Dados.Ordems"
750:             .Column4.ControlSource = "cursor_4c_Dados.TempoReal"
751:             .Column5.ControlSource = "cursor_4c_Dados.Cpros"
752:             .Column6.ControlSource = "cursor_4c_Dados.Pedido"
753:             .Column7.ControlSource = "cursor_4c_Dados.cliente"
754:             .Column8.ControlSource = "cursor_4c_Dados.UniPrdts"
755: 
756:             *-- Redefine cabecalhos (RecordSource reseta headers)
757:             .Column1.Header1.Caption = "Envelope"
758:             .Column2.Header1.Caption = "O.P."
759:             .Column3.Header1.Caption = "Seq"
760:             .Column4.Header1.Caption = "Minutos"
761:             .Column5.Header1.Caption = "Produto"
762:             .Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
763:             .Column7.Header1.Caption = "Cliente"
764:             .Column8.Header1.Caption = "Unidade Prod."
765: 
766:             *-- Ordem visual: Column8=UniPrdts na 1a posicao (conforme SCX original)
767:             .Column1.ColumnOrder = 2
768:             .Column2.ColumnOrder = 3
769:             .Column3.ColumnOrder = 4
770:             .Column4.ColumnOrder = 5
771:             .Column5.ColumnOrder = 6
772:             .Column6.ColumnOrder = 7
773:             .Column7.ColumnOrder = 8
774:             .Column8.ColumnOrder = 1

*-- Linhas 790 a 845:
790:     *==========================================================================
791:     * FormatarGridLista - Aplica formatacao visual padrao ao grid
792:     *==========================================================================
793:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
794:         WITH par_oGrid
795:             .FontName = "Verdana"
796:             .FontSize = 8
797:         ENDWITH
798:     ENDPROC
799: 
800:     *==========================================================================
801:     * GrdDadosAfterRowColChange - Atualiza campos informativos ao navegar no grid
802:     * Exibe foto do produto, descricao, quantidade, cliente e tempo do envelope
803:     *   par_nColIndex - Indice da coluna (requerido pelo BINDEVENT AfterRowColChange)
804:     *==========================================================================
805:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
806:         LOCAL loc_lTemFoto, loc_oPg
807:         loc_oPg = THIS.pgf_4c_Paginas.Page1
808: 
809:         loc_oPg.img_4c_FigJpg.Visible = .F.
810:         loc_oPg.shp_4c_Shape4.Visible = .F.
811:         loc_oPg.img_4c_FigJpg.Picture = ""
812: 
813:         IF !THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
814:             loc_oPg.txt_4c_Descr.Value   = ""
815:             loc_oPg.txt_4c_Qtde.Value    = 0
816:             loc_oPg.txt_4c_Cliente.Value = ""
817:             loc_oPg.txt_4c_TEnv.Value    = 0
818:             IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_InfoProd") = "O"
819:                 WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_InfoProd
820:                     .txt_4c_Prod2.Value     = ""
821:                     .txt_4c_Descr2.Value    = ""
822:                     .img_4c_FigJpg2.Visible = .F.
823:                     .shp_4c_Shape2.Visible  = .F.
824:                     .img_4c_FigJpg2.Picture = ""
825:                 ENDWITH
826:             ENDIF
827:             IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_DetalheLinha") = "O"
828:                 WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_DetalheLinha
829:                     .txt_4c_Nenvs2.Value = 0
830:                     .txt_4c_Nops2.Value  = 0
831:                     .txt_4c_Seqs2.Value  = 0
832:                     .txt_4c_TReal2.Value = 0
833:                     .txt_4c_Dopes2.Value = ""
834:                     .txt_4c_UniP2.Value  = ""
835:                     .txt_4c_Rclis2.Value = ""
836:                     .Visible     = .T.
837:                 ENDWITH
838:             ENDIF
839:             RETURN
840:         ENDIF
841: 
842:         loc_oPg.txt_4c_Qtde.Value    = THIS.this_oBusinessObject.this_nQuantidade
843:         loc_oPg.txt_4c_Cliente.Value = THIS.this_oBusinessObject.this_cCliente
844:         loc_oPg.txt_4c_TEnv.Value    = THIS.this_oBusinessObject.this_nTempoEnvelope
845: 

*-- Linhas 891 a 979:
891:     *==========================================================================
892:     * CmdSairClick - Fecha o formulario
893:     *==========================================================================
894:     PROCEDURE CmdSairClick()
895:         THIS.Release()
896:     ENDPROC
897: 
898:     *==========================================================================
899:     * AlternarPagina - Navega entre as paginas do PageFrame de conteudo
900:     *   par_nPagina - Numero da pagina (1=Principal, 2=Detalhes)
901:     *==========================================================================
902:     PROCEDURE AlternarPagina(par_nPagina)
903:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
904:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
905:         ENDIF
906:     ENDPROC
907: 
908:     *==========================================================================
909:     * ConfigurarPaginaDados - Popula Page2 com visao detalhada do registro selecionado
910:     * FASE 5/8 - Primeira metade: codigo/descricao do produto e foto ampliada
911:     * Acessada via duplo-clique no grid (GrdDadosDblClick)
912:     *==========================================================================
913:     PROTECTED PROCEDURE ConfigurarPaginaDados()
914:         LOCAL loc_oPg2, loc_oCnt
915: 
916:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
917: 
918:         *-- Botao Voltar (retorna a Page1)
919:         loc_oPg2.AddObject("cmd_4c_Voltar", "CommandButton")
920:         WITH loc_oPg2.cmd_4c_Voltar
921:             .Top             = 5
922:             .Left            = 916
923:             .Width           = 75
924:             .Height          = 75
925:             .Caption         = "Voltar"
926:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
927:             .FontName        = "Comic Sans MS"
928:             .FontBold        = .T.
929:             .FontItalic      = .T.
930:             .FontSize        = 8
931:             .ForeColor       = RGB(90, 90, 90)
932:             .BackColor       = RGB(255, 255, 255)
933:             .Themes          = .T.
934:             .SpecialEffect   = 0
935:             .PicturePosition = 13
936:             .MousePointer    = 15
937:             .WordWrap        = .T.
938:         ENDWITH
939:         BINDEVENT(loc_oPg2.cmd_4c_Voltar, "Click", THIS, "CmdVoltarClick")
940: 
941:         *-- Container de informacoes do produto (primeira metade dos campos de Page2)
942:         loc_oPg2.AddObject("cnt_4c_InfoProd", "Container")
943:         loc_oCnt = loc_oPg2.cnt_4c_InfoProd
944:         WITH loc_oCnt
945:             .Top         = 10
946:             .Left        = 10
947:             .Width       = 500
948:             .Height      = 490
949:             .BackStyle   = 0
950:             .BorderWidth = 0
951: 
952:             .AddObject("lbl_4c_LblProd2", "Label")
953:             WITH .lbl_4c_LblProd2
954:                 .Top       = 10
955:                 .Left      = 5
956:                 .Width     = 150
957:                 .Height    = 17
958:                 .Caption   = "C" + CHR(243) + "d. Produto:"
959:                 .FontName  = "Tahoma"
960:                 .FontBold  = .T.
961:                 .FontSize  = 8
962:                 .BackStyle = 0
963:                 .ForeColor = RGB(90, 90, 90)
964:             ENDWITH
965: 
966:             .AddObject("txt_4c_Prod2", "TextBox")
967:             WITH .txt_4c_Prod2
968:                 .Top       = 30
969:                 .Left      = 5
970:                 .Width     = 200
971:                 .Height    = 23
972:                 .FontName  = "Tahoma"
973:                 .FontBold  = .T.
974:                 .FontSize  = 8
975:                 .Value     = ""
976:                 .ReadOnly  = .T.
977:                 .BackColor = RGB(255, 255, 198)
978:             ENDWITH
979: 

*-- Linhas 1245 a 1541:
1245:     *==========================================================================
1246:     * GrdDadosDblClick - Navega para Page2 (detalhe do produto) ao dar duplo-clique
1247:     *==========================================================================
1248:     PROCEDURE GrdDadosDblClick()
1249:         IF USED("cursor_4c_Dados")
1250:             THIS.pgf_4c_Paginas.ActivePage = 2
1251:         ENDIF
1252:     ENDPROC
1253: 
1254:     *==========================================================================
1255:     * CmdVoltarClick - Retorna a Page1 (visao principal do grid)
1256:     *==========================================================================
1257:     PROCEDURE CmdVoltarClick()
1258:         THIS.pgf_4c_Paginas.Visible = .T.
1259:         THIS.pgf_4c_Paginas.ActivePage = 1
1260:         IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1261:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.SetFocus()
1262:         ENDIF
1263:     ENDPROC
1264: 
1265:     *==========================================================================
1266:     * BtnIncluirClick - Recarrega a consulta com os parametros atuais
1267:     * OPERACIONAL read-only: "Incluir" mapeia para refresh dos dados de capacidade
1268:     * (equivalente a reprocessar a consulta parametrizada apos alteracao externa)
1269:     *==========================================================================
1270:     PROCEDURE BtnIncluirClick()
1271:         LOCAL loc_oErro
1272:         TRY
1273:             THIS.LockScreen = .T.
1274:             IF THIS.CarregarDados()
1275:                 IF USED("cursor_4c_Dados")
1276:                     THIS.AtualizarGrid()
1277:                     SELECT cursor_4c_Dados
1278:                     GO TOP
1279:                     THIS.GrdDadosAfterRowColChange(0)
1280:                     IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1281:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1282:                     ENDIF
1283:                 ENDIF
1284:                 THIS.pgf_4c_Paginas.Visible = .T.
1285:                 THIS.pgf_4c_Paginas.ActivePage = 1
1286:             ENDIF
1287:             THIS.LockScreen = .F.
1288:         CATCH TO loc_oErro
1289:             THIS.LockScreen = .F.
1290:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
1291:         ENDTRY
1292:     ENDPROC
1293: 
1294:     *==========================================================================
1295:     * BtnAlterarClick - Alterna para Page2 com o detalhe do registro selecionado
1296:     * OPERACIONAL read-only: "Alterar" mapeia para navegar ao detalhe (edicao
1297:     * nao existe no fluxo original; SigCdPcz eh calculado, nao editavel)
1298:     *==========================================================================
1299:     PROCEDURE BtnAlterarClick()
1300:         LOCAL loc_oErro
1301:         TRY
1302:             IF !USED("cursor_4c_Dados")
1303:                 MsgAviso("Nenhum registro de capacidade produtiva disponivel.", "Aviso")
1304:                 RETURN
1305:             ENDIF
1306:             SELECT cursor_4c_Dados
1307:             IF EOF() OR RECCOUNT() = 0
1308:                 MsgAviso("Selecione um registro do grid.", "Aviso")
1309:                 RETURN
1310:             ENDIF
1311: 
1312:             *-- Garante que campos de detalhe estao populados com a linha corrente
1313:             THIS.GrdDadosAfterRowColChange(0)
1314:             THIS.pgf_4c_Paginas.ActivePage = 2
1315:         CATCH TO loc_oErro
1316:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
1317:         ENDTRY
1318:     ENDPROC
1319: 
1320:     *==========================================================================
1321:     * BtnVisualizarClick - Alterna para Page2 (detalhe do registro selecionado)
1322:     * OPERACIONAL read-only: equivalente ao DblClick no grid (GrdDadosDblClick)
1323:     *==========================================================================
1324:     PROCEDURE BtnVisualizarClick()
1325:         LOCAL loc_oErro
1326:         TRY
1327:             IF !USED("cursor_4c_Dados")
1328:                 MsgAviso("Nenhum registro de capacidade produtiva disponivel.", "Aviso")
1329:                 RETURN
1330:             ENDIF
1331:             SELECT cursor_4c_Dados
1332:             IF EOF() OR RECCOUNT() = 0
1333:                 MsgAviso("Selecione um registro do grid.", "Aviso")
1334:                 RETURN
1335:             ENDIF
1336: 
1337:             *-- Popula Page2 com o registro corrente e navega
1338:             THIS.GrdDadosAfterRowColChange(0)
1339:             THIS.pgf_4c_Paginas.ActivePage = 2
1340:         CATCH TO loc_oErro
1341:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
1342:         ENDTRY
1343:     ENDPROC
1344: 
1345:     *==========================================================================
1346:     * BtnExcluirClick - Encerra a consulta e fecha o formulario
1347:     * OPERACIONAL read-only: "Excluir" mapeia para encerrar a sessao de consulta
1348:     * (equivalente ao botao Encerrar / CmdSairClick do form original)
1349:     *==========================================================================
1350:     PROCEDURE BtnExcluirClick()
1351:         IF MsgConfirma("Deseja encerrar a consulta de capacidade produtiva?", "Confirma" + CHR(231) + CHR(227) + "o")
1352:             THIS.Release()
1353:         ENDIF
1354:     ENDPROC
1355: 
1356:     *==========================================================================
1357:     * CarregarLista - Refresh completo: recarrega dados e atualiza grid
1358:     * OPERACIONAL: equivalente a re-executar a consulta parametrizada
1359:     *==========================================================================
1360:     PROCEDURE CarregarLista()
1361:         LOCAL loc_lSucesso
1362:         loc_lSucesso = THIS.CarregarDados()
1363:         IF loc_lSucesso AND USED("cursor_4c_Dados")
1364:             THIS.AtualizarGrid()
1365:             SELECT cursor_4c_Dados
1366:             GO TOP
1367:             THIS.GrdDadosAfterRowColChange(0)
1368:             IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1369:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1370:             ENDIF
1371:         ENDIF
1372:         RETURN loc_lSucesso
1373:     ENDPROC
1374: 
1375:     *==========================================================================
1376:     * FormParaBO - Transfere parametros do form para o BO antes de consultar
1377:     *==========================================================================
1378:     PROCEDURE FormParaBO()
1379:         WITH THIS.this_oBusinessObject
1380:             .this_nCodigo  = THIS.this_nCodigo
1381:             .this_cFase    = THIS.this_cFase
1382:             .this_cUnidade = THIS.this_cUnidade
1383:             .this_dData    = THIS.this_dData
1384:         ENDWITH
1385:     ENDPROC
1386: 
1387:     *==========================================================================
1388:     * BOParaForm - Popula campos do form com resultados calculados pelo BO
1389:     *==========================================================================
1390:     PROTECTED PROCEDURE BOParaForm()
1391:         LOCAL loc_oPg, loc_oErro
1392:         IF TYPE("THIS.pgf_4c_Paginas") != "O"
1393:             RETURN
1394:         ENDIF
1395:         TRY
1396:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1397:             WITH loc_oPg.cnt_4c_Container1
1398:                 .txt_4c_Fase.Value = ALLTRIM(THIS.this_oBusinessObject.this_cFase)
1399:                 .txt_4c_Data.Value = DTOC(THIS.this_oBusinessObject.this_dData)
1400:                 .Visible     = .T.
1401:             ENDWITH
1402:             WITH loc_oPg.cnt_4c_Container2
1403:                 .txt_4c_Cap.Value = THIS.this_oBusinessObject.this_nCapacidade
1404:                 .txt_4c_Utz.Value = THIS.this_oBusinessObject.this_nUtilizado
1405:                 .txt_4c_Sld.Value = THIS.this_oBusinessObject.this_nSaldo
1406:                 .Visible     = .T.
1407:             ENDWITH
1408:         CATCH TO loc_oErro
1409:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
1410:         ENDTRY
1411:     ENDPROC
1412: 
1413:     *==========================================================================
1414:     * HabilitarCampos - Form OPERACIONAL somente-leitura: todos campos fixos
1415:     *==========================================================================
1416:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1417:         LOCAL loc_oPg
1418:         IF TYPE("THIS.pgf_4c_Paginas") != "O"
1419:             RETURN
1420:         ENDIF
1421:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1422:         IF TYPE("loc_oPg.cnt_4c_Container1") = "O"
1423:             loc_oPg.cnt_4c_Container1.txt_4c_Fase.ReadOnly = .T.
1424:             loc_oPg.cnt_4c_Container1.txt_4c_Data.ReadOnly = .T.
1425:         ENDIF
1426:         IF TYPE("loc_oPg.cnt_4c_Container2") = "O"
1427:             loc_oPg.cnt_4c_Container2.txt_4c_Cap.ReadOnly = .T.
1428:             loc_oPg.cnt_4c_Container2.txt_4c_Utz.ReadOnly = .T.
1429:             loc_oPg.cnt_4c_Container2.txt_4c_Sld.ReadOnly = .T.
1430:         ENDIF
1431:         IF TYPE("loc_oPg.txt_4c_Descr") = "O"
1432:             loc_oPg.txt_4c_Descr.ReadOnly   = .T.
1433:             loc_oPg.txt_4c_Qtde.ReadOnly    = .T.
1434:             loc_oPg.txt_4c_Cliente.ReadOnly = .T.
1435:             loc_oPg.txt_4c_TEnv.ReadOnly    = .T.
1436:         ENDIF
1437:     ENDPROC
1438: 
1439:     *==========================================================================
1440:     * LimparCampos - Limpa campos informativos abaixo do grid
1441:     *==========================================================================
1442:     PROTECTED PROCEDURE LimparCampos()
1443:         LOCAL loc_oPg, loc_oErro
1444:         IF TYPE("THIS.pgf_4c_Paginas") != "O"
1445:             RETURN
1446:         ENDIF
1447:         TRY
1448:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1449:             loc_oPg.txt_4c_Descr.Value    = ""
1450:             loc_oPg.txt_4c_Qtde.Value     = 0
1451:             loc_oPg.txt_4c_Cliente.Value  = ""
1452:             loc_oPg.txt_4c_TEnv.Value     = 0
1453:             loc_oPg.img_4c_FigJpg.Visible = .F.
1454:             loc_oPg.img_4c_FigJpg.Picture = ""
1455:             loc_oPg.shp_4c_Shape4.Visible = .F.
1456:         CATCH TO loc_oErro
1457:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
1458:         ENDTRY
1459:     ENDPROC
1460: 
1461:     *==========================================================================
1462:     * AjustarBotoesPorModo - OPERACIONAL sem modos CRUD: botoes fixos
1463:     *==========================================================================
1464:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1465:         LOCAL loc_oPg
1466:         IF TYPE("THIS.pgf_4c_Paginas") != "O"
1467:             RETURN
1468:         ENDIF
1469:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1470:         IF TYPE("loc_oPg.cmd_4c_Sair") = "O"
1471:             loc_oPg.cmd_4c_Sair.Enabled = .T.
1472:         ENDIF
1473:     ENDPROC
1474: 
1475:     *==========================================================================
1476:     * BtnBuscarClick - Recarrega consulta com parametros atuais (equivale a refresh)
1477:     *==========================================================================
1478:     PROCEDURE BtnBuscarClick()
1479:         LOCAL loc_oErro
1480:         TRY
1481:             THIS.LockScreen = .T.
1482:             IF THIS.CarregarDados()
1483:                 IF USED("cursor_4c_Dados")
1484:                     THIS.AtualizarGrid()
1485:                     SELECT cursor_4c_Dados
1486:                     GO TOP
1487:                     THIS.GrdDadosAfterRowColChange(0)
1488:                     IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1489:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1490:                     ENDIF
1491:                 ENDIF
1492:                 THIS.pgf_4c_Paginas.Visible = .T.
1493:                 THIS.pgf_4c_Paginas.ActivePage = 1
1494:             ENDIF
1495:             THIS.LockScreen = .F.
1496:         CATCH TO loc_oErro
1497:             THIS.LockScreen = .F.
1498:             MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
1499:         ENDTRY
1500:     ENDPROC
1501: 
1502:     *==========================================================================
1503:     * BtnEncerrarClick - Fecha o formulario
1504:     *==========================================================================
1505:     PROCEDURE BtnEncerrarClick()
1506:         THIS.Release()
1507:     ENDPROC
1508: 
1509:     *==========================================================================
1510:     * BtnSalvarClick - Nao aplicavel em form OPERACIONAL somente-leitura
1511:     *==========================================================================
1512:     PROCEDURE BtnSalvarClick()
1513:         MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + ;
1514:             " de consulta somente leitura. " + ;
1515:             "Opera" + CHR(231) + CHR(227) + "o de salvamento n" + ;
1516:             CHR(227) + "o " + CHR(233) + " suportada.", ;
1517:             "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
1518:     ENDPROC
1519: 
1520:     *==========================================================================
1521:     * BtnCancelarClick - Retorna a Page1 (visao principal do grid)
1522:     *==========================================================================
1523:     PROCEDURE BtnCancelarClick()
1524:         THIS.pgf_4c_Paginas.Visible = .T.
1525:         THIS.pgf_4c_Paginas.ActivePage = 1
1526:         IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1527:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.SetFocus()
1528:         ENDIF
1529:     ENDPROC
1530: 
1531:     *==========================================================================
1532:     * Destroy - Libera BO e delega restante ao FormBase
1533:     *==========================================================================
1534:     PROCEDURE Destroy()
1535:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1536:             THIS.this_oBusinessObject = .NULL.
1537:         ENDIF
1538:         DODEFAULT()
1539:     ENDPROC
1540: 
1541: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprcpdBO.prg):
*==============================================================================
* sigprcpdBO.prg - Business Object para Capacidade Produtiva
* Form OPERACIONAL (consulta somente leitura - sem CRUD)
* Tabelas: SigCdPcz, SigCdPcP, SigCdPcg, SigCdPco, SigCdCli, SigCdPro
*==============================================================================
DEFINE CLASS sigprcpdBO AS BusinessBase

    *-- Parametros de consulta (recebidos do chamador via Form.Init)
    this_nCodigo    = 0
    this_cFase      = ""
    this_cUnidade   = ""
    this_dData      = {}

    *-- Resumo de capacidade (vindos de SigCdPcP agrupado)
    this_nCapacidade  = 0
    this_nUtilizado   = 0
    this_nSaldo       = 0

    *-- Detalhe do produto selecionado no grid (SigCdPro)
    this_cDescricaoProduto = ""
    this_cFotoBase64       = ""
    this_cCaminhoFoto      = ""

    *-- Detalhe do envelope/linha selecionada no grid (cursor_4c_Dados)
    this_nQuantidade    = 0
    this_cCliente       = ""
    this_nTempoEnvelope = 0
    this_cProduto       = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigCdPcz"
        this_cCampoChave = "codigos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega todos os cursores de capacidade produtiva
    *   par_nCodigo  - Codigo do processo (SigCdPcz.codigos)
    *   par_cFase    - Fase/setor de producao
    *   par_cUnidade - Unidade produtiva (vazio = todas as unidades)
    *   par_dData    - Data de consulta
    * Retorna .T. se sucesso, .F. se falha
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados(par_nCodigo, par_cFase, par_cUnidade, par_dData)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_cFiltroUnid

        loc_lSucesso    = .F.
        loc_cFiltroUnid = IIF(EMPTY(par_cUnidade), "", " And UniPrdts = " + EscaparSQL(par_cUnidade))

        THIS.this_nCodigo  = par_nCodigo
        THIS.this_cFase    = par_cFase
        THIS.this_cUnidade = par_cUnidade
        THIS.this_dData    = par_dData

        TRY
            *-- 1. Dados basicos do processo (SigCdPcz)
            IF USED("cursor_4c_Pcp")
                USE IN cursor_4c_Pcp
            ENDIF

            loc_cSQL = "Select * From SigCdPcz Where codigos = " + TRANSFORM(par_nCodigo)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pcp")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar dados do processo (SigCdPcz).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Resumo de capacidade (SigCdPcP agrupado)
            IF USED("cursor_4c_Capacidade")
                USE IN cursor_4c_Capacidade
            ENDIF

            loc_cSQL = "Select Codigos, Sum(minutos) as Minutos, " + ;
                       "sum(minutos-Saldos) as UtilizadoS, Sum(saldos) as Saldos " + ;
                       "From SigCdPcP " + ;
                       "Where Codigos = " + TRANSFORM(par_nCodigo) + ;
                       " And Datas = " + FormatarDataSQL(par_dData) + ;
                       " And Fases = " + EscaparSQL(par_cFase) + ;
                       loc_cFiltroUnid + ;
                       " Group by Codigos"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Capacidade")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar capacidade (SigCdPcP).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF RECCOUNT("cursor_4c_Capacidade") > 0
                SELECT cursor_4c_Capacidade
                GO TOP
                THIS.this_nCapacidade = NVL(cursor_4c_Capacidade.Minutos,    0)
                THIS.this_nUtilizado  = NVL(cursor_4c_Capacidade.UtilizadoS, 0)
                THIS.this_nSaldo      = NVL(cursor_4c_Capacidade.Saldos,     0)
            ELSE
                THIS.this_nCapacidade = 0
                THIS.this_nUtilizado  = 0
                THIS.this_nSaldo      = 0
            ENDIF

            *-- 3. Itens individuais de programacao por item (SigCdPcg)
            IF USED("cursor_4c_PcpPp")
                USE IN cursor_4c_PcpPp
            ENDIF

            loc_cSQL = "Select * from SigCdPcg " + ;
                       "Where datas = " + FormatarDataSQL(par_dData) + ;
                       " And Fases = " + EscaparSQL(par_cFase) + ;
                       " And Codigos = " + TRANSFORM(par_nCodigo) + ;
                       loc_cFiltroUnid + ;
                       " Order by Cidchaves"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PcpPp")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar programa" + CHR(231) + CHR(227) + "o (SigCdPcg).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- 4. Ordens de producao com clientes (SigCdPco + SigCdCli)
            IF USED("cursor_4c_PcpOp2")
                USE IN cursor_4c_PcpOp2
            ENDIF

            loc_cSQL = "Select a.*, " + ;
                       "a.dopes+'-'+RTRIM(STR(a.numes,6)) as Pedido, " + ;
                       "a.contas+'-'+b.rclis as cliente, b.Rclis " + ;
                       "From SigCdPco a, SigCdCli b " + ;
                       "Where a.Codigos = " + TRANSFORM(par_nCodigo) + ;
                       " And a.Fases = " + EscaparSQL(par_cFase) + ;
                       STRTRAN(loc_cFiltroUnid, " UniPrdts", " a.UniPrdts") + ;
                       " And a.Contas = b.Iclis " + ;
                       "Order by a.UniPrdts, a.Seqs, a.Nenvs"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PcpOp2")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar ordens de produ" + CHR(231) + CHR(227) + "o (SigCdPco).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- 5. Agrega minutos por (Fases, UniPrdts, Nenvs, Seqs) via VFP SELECT local
            IF USED("cursor_4c_PcpOp3")
                USE IN cursor_4c_PcpOp3
            ENDIF

            SELECT a.Fases, a.UniPrdts, a.Nenvs, a.Seqs, ;
                   SUM(a.Minutos) AS Minutos ;
            FROM cursor_4c_PcpOp2 a, cursor_4c_PcpPp b ;
            WHERE a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                  b.Fases + b.UniPrdts + STR(b.Nenvs,10) + STR(b.Seqs,2) ;
            INTO CURSOR cursor_4c_PcpOp3 READWRITE ;
            GROUP BY a.Fases, a.UniPrdts, a.Nenvs, a.Seqs

            *-- 6. Cursor final para o grid: combina dados com proporcionalidade de tempo
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            SET NULL ON
            SELECT a.*, b.Minutos AS TempU, c.Minutos AS TempoO, ;
                   fStoM((a.Minutos*60)/(c.Minutos*60)*(b.Minutos*60)) AS TempoReal ;
            FROM cursor_4c_PcpOp2 a, cursor_4c_PcpPp b, cursor_4c_PcpOp3 c ;
            WHERE a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                  b.Fases + b.UniPrdts + STR(b.Nenvs,10) + STR(b.Seqs,2) ;
            AND   a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                  c.Fases + c.UniPrdts + STR(c.Nenvs,10) + STR(c.Seqs,2) ;
            INTO CURSOR cursor_4c_Dados READWRITE ;
            ORDER BY b.Ordems, a.UniPrdts, a.Seqs, a.Nenvs
            SET NULL OFF

            IF RECCOUNT("cursor_4c_Dados") > 0
                SELECT cursor_4c_Dados
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados da linha atual do cursor_4c_Dados para
    * as propriedades da BO. Chamado pelo form em AfterRowColChange do grid,
    * antes de atualizar os labels de descricao, quantidade, cliente e tempo.
    *   par_cAliasCursor - Alias do cursor (normalmente "cursor_4c_Dados")
    * Retorna .T. se carregou, .F. se cursor nao existe ou esta vazio.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Dados", par_cAliasCursor)

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)

        IF EOF() OR BOF() OR RECCOUNT() = 0
            RETURN .F.
        ENDIF

        *-- Chave do envelope/linha selecionada
        IF TYPE(loc_cAlias + ".Nenvs")    != "U"
            THIS.this_nCodigo = NVL(EVALUATE(loc_cAlias + ".Nenvs"), 0)
        ENDIF

        *-- Produto (para lookup em ObterDetalheProduto)
        IF TYPE(loc_cAlias + ".Cpros") != "U"
            THIS.this_cProduto = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Cpros"), ""))
        ENDIF

        *-- Quantidade (Qtds da OP)
        IF TYPE(loc_cAlias + ".Qtds") != "U"
            THIS.this_nQuantidade = NVL(EVALUATE(loc_cAlias + ".Qtds"), 0)
        ENDIF

        *-- Cliente (Rclis - razao social)
        IF TYPE(loc_cAlias + ".Rclis") != "U"
            THIS.this_cCliente = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Rclis"), ""))
        ENDIF

        *-- Tempo do envelope (TempU calculado em CarregarDados)
        IF TYPE(loc_cAlias + ".TempU") != "U"
            THIS.this_nTempoEnvelope = NVL(EVALUATE(loc_cAlias + ".TempU"), 0)
        ENDIF

        *-- Unidade produtiva (UniPrdts)
        IF TYPE(loc_cAlias + ".UniPrdts") != "U"
            THIS.this_cUnidade = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".UniPrdts"), ""))
        ENDIF

        *-- Fase (Fases)
        IF TYPE(loc_cAlias + ".Fases") != "U"
            THIS.this_cFase = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Fases"), ""))
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Override BusinessBase.
    * Form SIGPRCPD e OPERACIONAL de consulta somente leitura: a tela apenas
    * exibe capacidade produtiva vinda de SigCdPcz/SigCdPcP/SigCdPcg/SigCdPco.
    * Nao ha INSERT em nenhuma tabela no codigo legado. Sobrescrever para
    * bloquear qualquer chamada acidental via BusinessBase.Salvar() e informar
    * o motivo de forma explicita.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Capacidade Produtiva " + CHR(233) + ;
            " uma tela de consulta somente leitura. " + ;
            "Opera" + CHR(231) + CHR(227) + "o de inclus" + CHR(227) + "o n" + ;
            CHR(227) + "o " + CHR(233) + " suportada por este processo."
        MsgAviso(THIS.this_cMensagemErro, "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Override BusinessBase.
    * Mesmo motivo de Inserir(): SIGPRCPD nao altera dados persistidos. Todas
    * as tabelas envolvidas sao apenas lidas (Select * From SigCdPcz, etc.).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Capacidade Produtiva " + CHR(233) + ;
            " uma tela de consulta somente leitura. " + ;
            "Opera" + CHR(231) + CHR(227) + "o de altera" + CHR(231) + CHR(227) + "o n" + ;
            CHR(227) + "o " + CHR(233) + " suportada por este processo."
        MsgAviso(THIS.this_cMensagemErro, "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override para log de consulta.
    * Como o form eh read-only, registramos apenas a operacao "CONSULTA"
    * para rastrear quem acessou a capacidade produtiva de qual processo.
    *   par_cOperacao - Descartado (sempre gravamos "CONSULTA")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario

        loc_cChave = THIS.ObterChavePrimaria()

        IF EMPTY(loc_cChave)
            RETURN .F.
        ENDIF

        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + ;
                   EscaparSQL(THIS.this_cTabela)                     + ", " + ;
                   EscaparSQL("CONSULTA")                            + ", " + ;
                   EscaparSQL(loc_cChave)                            + ", " + ;
                   EscaparSQL(loc_cUsuario)                          + ", " + ;
                   "GETDATE())"

        SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDetalheProduto - Carrega foto e descricao do produto da linha atual
    *   par_cCpros    - Codigo do produto (SigCdPro.Cpros)
    * Retorna .T. se produto encontrado com foto valida
    *--------------------------------------------------------------------------
    PROCEDURE ObterDetalheProduto(par_cCpros)
        LOCAL loc_lTemFoto, loc_cSQL, loc_nRet
        LOCAL loc_cFotoBase64, loc_cArquivo

        loc_lTemFoto = .F.

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "Select FigJpgs, Dpros From SigCdPro " + ;
                       "Where Cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_Produto") > 0
                SELECT cursor_4c_Produto
                GO TOP

                THIS.this_cDescricaoProduto = NVL(cursor_4c_Produto.Dpros,   "")
                THIS.this_cFotoBase64       = NVL(cursor_4c_Produto.FigJpgs, "")

                IF !EMPTY(THIS.this_cFotoBase64)
                    loc_cFotoBase64 = THIS.this_cFotoBase64
                    loc_cFotoBase64 = STRTRAN(loc_cFotoBase64, "data:image/png;base64,",  "")
                    loc_cFotoBase64 = STRTRAN(loc_cFotoBase64, "data:image/jpeg;base64,", "")
                    loc_cFotoBase64 = STRTRAN(loc_cFotoBase64, "data:image/jpg;base64,",  "")

                    loc_cArquivo    = SYS(2023) + "\sigprcpd.jpg"
                    loc_cFotoBase64 = STRCONV(loc_cFotoBase64, 14)

                    IF STRTOFILE(loc_cFotoBase64, loc_cArquivo) > 0
                        THIS.this_cCaminhoFoto = loc_cArquivo
                        loc_lTemFoto           = .T.
                    ELSE
                        THIS.this_cCaminhoFoto = ""
                    ENDIF
                ELSE
                    THIS.this_cCaminhoFoto = ""
                ENDIF
            ELSE
                THIS.this_cDescricaoProduto = ""
                THIS.this_cFotoBase64       = ""
                THIS.this_cCaminhoFoto      = ""
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lTemFoto
    ENDPROC

ENDDEFINE

*==============================================================================
* fStoM - Converte segundos em minutos (replica funcao fStoM do framework legado)
* Usada nos VFP SELECTs locais dentro de CarregarDados
*==============================================================================
FUNCTION fStoM(par_nSegundos)
    IF VARTYPE(par_nSegundos) != "N" OR par_nSegundos = 0
        RETURN 0
    ENDIF
    RETURN INT(par_nSegundos / 60)
ENDFUNC

