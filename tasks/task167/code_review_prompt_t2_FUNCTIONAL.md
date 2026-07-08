# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_INFOPROD, CNT_4C_DETALHELINHA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NAVEGACAO-PAGINA] Metodo 'GrdDadosDblClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1545 linhas total):

*-- Linhas 38 a 142:
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
70:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
71:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
72: 
73:                 *-- Carrega dados antes de configurar Page1 (cria cursor_4c_Dados)
74:                 IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
75:                     THIS.CarregarDados()
76:                 ENDIF
77: 
78:                 *-- Popula Page1 com grid e controles (usa cursor_4c_Dados se disponivel)
79:                 THIS.ConfigurarPaginaLista()
80:                 THIS.ConfigurarPaginaDados()
81: 
82:                 THIS.LockScreen = .F.
83: 
84:                 *-- Torna controles visiveis (filtra imagem/shape da foto do produto)
85:                 THIS.TornarControlesVisiveis(THIS)
86: 
87:                 loc_lSucesso = .T.
88:             ENDIF
89: 
90:         CATCH TO loc_oErro
91:             THIS.LockScreen = .F.
92:             MsgErro(loc_oErro.Message, "Erro InicializarForm")
93:         ENDTRY
94: 
95:         RETURN loc_lSucesso
96:     ENDPROC
97: 
98:     *==========================================================================
99:     * ConfigurarCabecalho - Container escuro no topo com titulo do form
100:     * Cria cnt_4c_Cabecalho (equivalente ao cntSombra do legado)
101:     *==========================================================================
102:     PROTECTED PROCEDURE ConfigurarCabecalho()
103:         LOCAL loc_oCab
104: 
105:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
106:         loc_oCab = THIS.cnt_4c_Cabecalho
107:         WITH loc_oCab
108:             .Top         = 0
109:             .Left        = 0
110:             .Width       = THIS.Width
111:             .Height      = 80
112:             .BackStyle   = 1
113:             .BackColor   = RGB(100, 100, 100)
114:             .BorderWidth = 0
115: 
116:             .AddObject("lbl_4c_Sombra", "Label")
117:             WITH .lbl_4c_Sombra
118:                 .AutoSize      = .F.
119:                 .Top           = 18
120:                 .Left          = 10
121:                 .Width         = loc_oCab.Width
122:                 .Height        = 40
123:                 .FontBold      = .T.
124:                 .FontName      = "Tahoma"
125:                 .FontSize      = 18
126:                 .FontUnderline = .F.
127:                 .WordWrap      = .T.
128:                 .Alignment     = 0
129:                 .BackStyle     = 0
130:                 .Caption       = "Capacidade Produtiva"
131:                 .ForeColor     = RGB(0, 0, 0)
132:             ENDWITH
133: 
134:             .AddObject("lbl_4c_Titulo", "Label")
135:             WITH .lbl_4c_Titulo
136:                 .AutoSize  = .F.
137:                 .Top       = 17
138:                 .Left      = 10
139:                 .Width     = loc_oCab.Width
140:                 .Height    = 46
141:                 .FontBold  = .T.
142:                 .FontName  = "Tahoma"

*-- Linhas 159 a 322:
159:     *   Page2 -> reservada para expansao futura (foto ampliada, historico, etc)
160:     * Fases seguintes populam as pages com grid, containers e campos.
161:     *==========================================================================
162:     PROTECTED PROCEDURE ConfigurarPageFrame()
163:         LOCAL loc_oPgf
164: 
165:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
166:         loc_oPgf = THIS.pgf_4c_Paginas
167: 
168:         WITH loc_oPgf
169:             .PageCount = 2
170:             .Top       = 80
171:             .Left      = 0
172:             .Width     = THIS.Width
173:             .Height    = THIS.Height - 80
174:             .TabIndex  = 1
175:             .Tabs      = .F.
176:             .BorderWidth = 0
177:             .BackStyle = 0
178: 
179:             .Page1.Caption = "Principal"
180:             .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
181: 
182:             .Page2.Caption = "Detalhes"
183:             .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
184: 
185:             .Visible    = .T.
186:             .ActivePage = 1
187:         ENDWITH
188:     ENDPROC
189: 
190:     *==========================================================================
191:     * CarregarDados - Delega ao BO o carregamento de todos os cursores
192:     * Chamado em InicializarForm e pode ser chamado novamente para refresh
193:     *==========================================================================
194:     PROCEDURE CarregarDados()
195:         LOCAL loc_lSucesso
196:         loc_lSucesso = THIS.this_oBusinessObject.CarregarDados( ;
197:             THIS.this_nCodigo, ;
198:             THIS.this_cFase, ;
199:             THIS.this_cUnidade, ;
200:             THIS.this_dData)
201:         IF !loc_lSucesso
202:             MsgErro("Falha ao carregar dados de capacidade produtiva.", "Erro")
203:         ENDIF
204:         RETURN loc_lSucesso
205:     ENDPROC
206: 
207:     *==========================================================================
208:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
209:     * Filtra imagem/shape da foto (img_4c_FigJpg/shp_4c_Shape4) que sao toggled
210:     * pelo AfterRowColChange do grid conforme registro selecionado tem FigJpgs.
211:     *==========================================================================
212:     PROCEDURE TornarControlesVisiveis(par_oContainer)
213:         LOCAL loc_i, loc_oControl, loc_cName
214:         FOR loc_i = 1 TO par_oContainer.ControlCount
215:             loc_oControl = par_oContainer.Controls(loc_i)
216:             IF VARTYPE(loc_oControl) != "O"
217:                 LOOP
218:             ENDIF
219: 
220:             loc_cName = UPPER(loc_oControl.Name)
221: 
222:             *-- Controles com visibilidade gerenciada pelo form: recursar filhos mas NAO tornar visiveis
223:             IF INLIST(loc_cName, "IMG_4C_FIGJPG", "SHP_4C_SHAPE4", "CNT_4C_CABECALHO", "CNT_4C_INFOPROD", "CNT_4C_DETALHELINHA")
224:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
225:                     THIS.TornarControlesVisiveis(loc_oControl)
226:                 ENDIF
227:                 LOOP
228:             ENDIF
229: 
230:             IF PEMSTATUS(loc_oControl, "Visible", 5)
231:                 loc_oControl.Visible = .T.
232:             ENDIF
233: 
234:             *-- PageFrame: recursar em Pages (nao em Controls direto)
235:             IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
236:                 LOCAL loc_p
237:                 FOR loc_p = 1 TO loc_oControl.PageCount
238:                     THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
239:                 ENDFOR
240:                 LOOP
241:             ENDIF
242: 
243:             *-- Container generico: recursar em Controls
244:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
245:                 THIS.TornarControlesVisiveis(loc_oControl)
246:             ENDIF
247:         ENDFOR
248:     ENDPROC
249: 
250:     *==========================================================================
251:     * ConfigurarPaginaLista - Popula Page1 com todos os controles:
252:     *   botao Encerrar, filtros (Fase/Data), metricas (Cap/Utz/Sld),
253:     *   grid de 8 colunas, campos informativos abaixo do grid e foto do produto.
254:     * Chamado APOS CarregarDados para que cursor_4c_Dados ja exista.
255:     *==========================================================================
256:     PROTECTED PROCEDURE ConfigurarPaginaLista()
257:         LOCAL loc_oPg, loc_oCnt1, loc_oCnt2, loc_oGrid
258: 
259:         loc_oPg = THIS.pgf_4c_Paginas.Page1
260: 
261:         *-- Botao Encerrar (topo direito da area de conteudo)
262:         loc_oPg.AddObject("cmd_4c_Sair", "CommandButton")
263:         WITH loc_oPg.cmd_4c_Sair
264:             .Top             = 5
265:             .Left            = 725
266:             .Width           = 75
267:             .Height          = 75
268:             .Caption         = "Encerrar"
269:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
270:             .FontName        = "Tahoma"
271:             .FontBold        = .T.
272:             .FontItalic      = .T.
273:             .FontSize        = 8
274:             .ForeColor       = RGB(90, 90, 90)
275:             .BackColor       = RGB(255, 255, 255)
276:             .Themes          = .T.
277:             .SpecialEffect   = 0
278:             .PicturePosition = 13
279:             .MousePointer    = 15
280:             .WordWrap        = .T.
281:         ENDWITH
282:         BINDEVENT(loc_oPg.cmd_4c_Sair, "Click", THIS, "CmdSairClick")
283: 
284:         *-- Container1: parametros de consulta (Fase e Data)
285:         loc_oPg.AddObject("cnt_4c_Container1", "Container")
286:         loc_oCnt1 = loc_oPg.cnt_4c_Container1
287:         WITH loc_oCnt1
288:             .Top         = 24
289:             .Left        = 10
290:             .Width       = 347
291:             .Height      = 36
292:             .BackStyle   = 0
293:             .BorderWidth = 0
294: 
295:             .AddObject("lbl_4c_LblFase", "Label")
296:             WITH .lbl_4c_LblFase
297:                 .Top       = 8
298:                 .Left      = 2
299:                 .Width     = 50
300:                 .Height    = 17
301:                 .Caption   = "Fase :"
302:                 .FontName  = "Tahoma"
303:                 .FontSize  = 8
304:                 .BackStyle = 0
305:                 .ForeColor = RGB(90, 90, 90)
306:             ENDWITH
307: 
308:             .AddObject("txt_4c_Fase", "TextBox")
309:             WITH .txt_4c_Fase
310:                 .Top       = 5
311:                 .Left      = 55
312:                 .Width     = 125
313:                 .Height    = 23
314:                 .FontBold  = .T.
315:                 .FontName  = "Tahoma"
316:                 .FontSize  = 8
317:                 .BackColor = RGB(255, 198, 140)
318:                 .Value     = ""
319:                 .ReadOnly  = .T.
320:             ENDWITH
321: 
322:             .AddObject("lbl_4c_LblData", "Label")

*-- Linhas 570 a 614:
570:                 .Text1.FontSize      = 8
571:             ENDWITH
572:         ENDWITH
573:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
574:         BINDEVENT(loc_oGrid, "DblClick", THIS, "GrdDadosDblClick")
575: 
576:         *-- Labels e campos informativos abaixo do grid
577:         loc_oPg.AddObject("lbl_4c_LblQtde", "Label")
578:         WITH loc_oPg.lbl_4c_LblQtde
579:             .Top       = 378
580:             .Left      = 11
581:             .Width     = 80
582:             .Height    = 15
583:             .Caption   = "Quantidade"
584:             .FontName  = "Tahoma"
585:             .FontSize  = 8
586:             .BackStyle = 0
587:             .ForeColor = RGB(90, 90, 90)
588:         ENDWITH
589: 
590:         loc_oPg.AddObject("txt_4c_Qtde", "TextBox")
591:         WITH loc_oPg.txt_4c_Qtde
592:             .Top       = 391
593:             .Left      = 9
594:             .Width     = 92
595:             .Height    = 23
596:             .FontBold  = .T.
597:             .FontName  = "Tahoma"
598:             .FontSize  = 8
599:             .BackColor = RGB(255, 255, 198)
600:             .InputMask = "99999.999"
601:             .Value     = 0
602:             .ReadOnly  = .T.
603:         ENDWITH
604: 
605:         loc_oPg.AddObject("lbl_4c_LblDescr", "Label")
606:         WITH loc_oPg.lbl_4c_LblDescr
607:             .Top       = 378
608:             .Left      = 112
609:             .Width     = 180
610:             .Height    = 15
611:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto"
612:             .FontName  = "Tahoma"
613:             .FontSize  = 8
614:             .BackStyle = 0

*-- Linhas 734 a 777:
734:     * AtualizarGrid - Vincula grd_4c_Dados ao cursor_4c_Dados e atualiza metricas
735:     * Chamado apos CarregarDados. Pode ser chamado novamente para refresh.
736:     *==========================================================================
737:     PROCEDURE AtualizarGrid()
738:         LOCAL loc_oGrid, loc_oPg, loc_oCnt2
739:         loc_oPg   = THIS.pgf_4c_Paginas.Page1
740:         loc_oGrid = loc_oPg.grd_4c_Dados
741:         loc_oCnt2 = loc_oPg.cnt_4c_Container2
742: 
743:         IF !USED("cursor_4c_Dados")
744:             RETURN
745:         ENDIF
746: 
747:         loc_oGrid.ColumnCount  = 8
748:         loc_oGrid.RecordSource = "cursor_4c_Dados"
749:         WITH loc_oGrid
750:             .Column1.ControlSource = "cursor_4c_Dados.Nenvs"
751:             .Column2.ControlSource = "cursor_4c_Dados.Nops"
752:             .Column3.ControlSource = "cursor_4c_Dados.Ordems"
753:             .Column4.ControlSource = "cursor_4c_Dados.TempoReal"
754:             .Column5.ControlSource = "cursor_4c_Dados.Cpros"
755:             .Column6.ControlSource = "cursor_4c_Dados.Pedido"
756:             .Column7.ControlSource = "cursor_4c_Dados.cliente"
757:             .Column8.ControlSource = "cursor_4c_Dados.UniPrdts"
758: 
759:             *-- Redefine cabecalhos (RecordSource reseta headers)
760:             .Column1.Header1.Caption = "Envelope"
761:             .Column2.Header1.Caption = "O.P."
762:             .Column3.Header1.Caption = "Seq"
763:             .Column4.Header1.Caption = "Minutos"
764:             .Column5.Header1.Caption = "Produto"
765:             .Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
766:             .Column7.Header1.Caption = "Cliente"
767:             .Column8.Header1.Caption = "Unidade Prod."
768: 
769:             *-- Ordem visual: Column8=UniPrdts na 1a posicao (conforme SCX original)
770:             .Column1.ColumnOrder = 2
771:             .Column2.ColumnOrder = 3
772:             .Column3.ColumnOrder = 4
773:             .Column4.ColumnOrder = 5
774:             .Column5.ColumnOrder = 6
775:             .Column6.ColumnOrder = 7
776:             .Column7.ColumnOrder = 8
777:             .Column8.ColumnOrder = 1

*-- Linhas 793 a 848:
793:     *==========================================================================
794:     * FormatarGridLista - Aplica formatacao visual padrao ao grid
795:     *==========================================================================
796:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
797:         WITH par_oGrid
798:             .FontName = "Verdana"
799:             .FontSize = 8
800:         ENDWITH
801:     ENDPROC
802: 
803:     *==========================================================================
804:     * GrdDadosAfterRowColChange - Atualiza campos informativos ao navegar no grid
805:     * Exibe foto do produto, descricao, quantidade, cliente e tempo do envelope
806:     *   par_nColIndex - Indice da coluna (requerido pelo BINDEVENT AfterRowColChange)
807:     *==========================================================================
808:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
809:         LOCAL loc_lTemFoto, loc_oPg
810:         loc_oPg = THIS.pgf_4c_Paginas.Page1
811: 
812:         loc_oPg.img_4c_FigJpg.Visible = .F.
813:         loc_oPg.shp_4c_Shape4.Visible = .F.
814:         loc_oPg.img_4c_FigJpg.Picture = ""
815: 
816:         IF !THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
817:             loc_oPg.txt_4c_Descr.Value   = ""
818:             loc_oPg.txt_4c_Qtde.Value    = 0
819:             loc_oPg.txt_4c_Cliente.Value = ""
820:             loc_oPg.txt_4c_TEnv.Value    = 0
821:             IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_InfoProd") = "O"
822:                 WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_InfoProd
823:                     .txt_4c_Prod2.Value     = ""
824:                     .txt_4c_Descr2.Value    = ""
825:                     .img_4c_FigJpg2.Visible = .F.
826:                     .shp_4c_Shape2.Visible  = .F.
827:                     .img_4c_FigJpg2.Picture = ""
828:                 ENDWITH
829:             ENDIF
830:             IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_DetalheLinha") = "O"
831:                 WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_DetalheLinha
832:                     .txt_4c_Nenvs2.Value = 0
833:                     .txt_4c_Nops2.Value  = 0
834:                     .txt_4c_Seqs2.Value  = 0
835:                     .txt_4c_TReal2.Value = 0
836:                     .txt_4c_Dopes2.Value = ""
837:                     .txt_4c_UniP2.Value  = ""
838:                     .txt_4c_Rclis2.Value = ""
839:                     .Visible     = .T.
840:                 ENDWITH
841:             ENDIF
842:             RETURN
843:         ENDIF
844: 
845:         loc_oPg.txt_4c_Qtde.Value    = THIS.this_oBusinessObject.this_nQuantidade
846:         loc_oPg.txt_4c_Cliente.Value = THIS.this_oBusinessObject.this_cCliente
847:         loc_oPg.txt_4c_TEnv.Value    = THIS.this_oBusinessObject.this_nTempoEnvelope
848: 

*-- Linhas 894 a 982:
894:     *==========================================================================
895:     * CmdSairClick - Fecha o formulario
896:     *==========================================================================
897:     PROCEDURE CmdSairClick()
898:         THIS.Release()
899:     ENDPROC
900: 
901:     *==========================================================================
902:     * AlternarPagina - Navega entre as paginas do PageFrame de conteudo
903:     *   par_nPagina - Numero da pagina (1=Principal, 2=Detalhes)
904:     *==========================================================================
905:     PROCEDURE AlternarPagina(par_nPagina)
906:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
907:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
908:         ENDIF
909:     ENDPROC
910: 
911:     *==========================================================================
912:     * ConfigurarPaginaDados - Popula Page2 com visao detalhada do registro selecionado
913:     * FASE 5/8 - Primeira metade: codigo/descricao do produto e foto ampliada
914:     * Acessada via duplo-clique no grid (GrdDadosDblClick)
915:     *==========================================================================
916:     PROTECTED PROCEDURE ConfigurarPaginaDados()
917:         LOCAL loc_oPg2, loc_oCnt
918: 
919:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
920: 
921:         *-- Botao Voltar (retorna a Page1)
922:         loc_oPg2.AddObject("cmd_4c_Voltar", "CommandButton")
923:         WITH loc_oPg2.cmd_4c_Voltar
924:             .Top             = 5
925:             .Left            = 916
926:             .Width           = 75
927:             .Height          = 75
928:             .Caption         = "Voltar"
929:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
930:             .FontName        = "Tahoma"
931:             .FontBold        = .T.
932:             .FontItalic      = .T.
933:             .FontSize        = 8
934:             .ForeColor       = RGB(90, 90, 90)
935:             .BackColor       = RGB(255, 255, 255)
936:             .Themes          = .T.
937:             .SpecialEffect   = 0
938:             .PicturePosition = 13
939:             .MousePointer    = 15
940:             .WordWrap        = .T.
941:         ENDWITH
942:         BINDEVENT(loc_oPg2.cmd_4c_Voltar, "Click", THIS, "CmdVoltarClick")
943: 
944:         *-- Container de informacoes do produto (primeira metade dos campos de Page2)
945:         loc_oPg2.AddObject("cnt_4c_InfoProd", "Container")
946:         loc_oCnt = loc_oPg2.cnt_4c_InfoProd
947:         WITH loc_oCnt
948:             .Top         = 10
949:             .Left        = 10
950:             .Width       = 500
951:             .Height      = 490
952:             .BackStyle   = 0
953:             .BorderWidth = 0
954: 
955:             .AddObject("lbl_4c_LblProd2", "Label")
956:             WITH .lbl_4c_LblProd2
957:                 .Top       = 10
958:                 .Left      = 5
959:                 .Width     = 150
960:                 .Height    = 17
961:                 .Caption   = "C" + CHR(243) + "d. Produto:"
962:                 .FontName  = "Tahoma"
963:                 .FontBold  = .T.
964:                 .FontSize  = 8
965:                 .BackStyle = 0
966:                 .ForeColor = RGB(90, 90, 90)
967:             ENDWITH
968: 
969:             .AddObject("txt_4c_Prod2", "TextBox")
970:             WITH .txt_4c_Prod2
971:                 .Top       = 30
972:                 .Left      = 5
973:                 .Width     = 200
974:                 .Height    = 23
975:                 .FontName  = "Tahoma"
976:                 .FontBold  = .T.
977:                 .FontSize  = 8
978:                 .Value     = ""
979:                 .ReadOnly  = .T.
980:                 .BackColor = RGB(255, 255, 198)
981:             ENDWITH
982: 

*-- Linhas 1248 a 1545:
1248:     *==========================================================================
1249:     * GrdDadosDblClick - Navega para Page2 (detalhe do produto) ao dar duplo-clique
1250:     *==========================================================================
1251:     PROCEDURE GrdDadosDblClick()
1252:         IF USED("cursor_4c_Dados")
1253:             THIS.GrdDadosAfterRowColChange(0)
1254:             THIS.pgf_4c_Paginas.ActivePage = 2
1255:         ENDIF
1256:     ENDPROC
1257: 
1258:     *==========================================================================
1259:     * CmdVoltarClick - Retorna a Page1 (visao principal do grid)
1260:     *==========================================================================
1261:     PROCEDURE CmdVoltarClick()
1262:         THIS.pgf_4c_Paginas.Visible = .T.
1263:         THIS.pgf_4c_Paginas.ActivePage = 1
1264:         IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1265:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.SetFocus()
1266:         ENDIF
1267:     ENDPROC
1268: 
1269:     *==========================================================================
1270:     * BtnIncluirClick - Recarrega a consulta com os parametros atuais
1271:     * OPERACIONAL read-only: "Incluir" mapeia para refresh dos dados de capacidade
1272:     * (equivalente a reprocessar a consulta parametrizada apos alteracao externa)
1273:     *==========================================================================
1274:     PROCEDURE BtnIncluirClick()
1275:         LOCAL loc_oErro
1276:         TRY
1277:             THIS.LockScreen = .T.
1278:             IF THIS.CarregarDados()
1279:                 IF USED("cursor_4c_Dados")
1280:                     THIS.AtualizarGrid()
1281:                     SELECT cursor_4c_Dados
1282:                     GO TOP
1283:                     THIS.GrdDadosAfterRowColChange(0)
1284:                     IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1285:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1286:                     ENDIF
1287:                 ENDIF
1288:                 THIS.pgf_4c_Paginas.Visible = .T.
1289:                 THIS.pgf_4c_Paginas.ActivePage = 1
1290:             ENDIF
1291:             THIS.LockScreen = .F.
1292:         CATCH TO loc_oErro
1293:             THIS.LockScreen = .F.
1294:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
1295:         ENDTRY
1296:     ENDPROC
1297: 
1298:     *==========================================================================
1299:     * BtnAlterarClick - Alterna para Page2 com o detalhe do registro selecionado
1300:     * OPERACIONAL read-only: "Alterar" mapeia para navegar ao detalhe (edicao
1301:     * nao existe no fluxo original; SigCdPcz eh calculado, nao editavel)
1302:     *==========================================================================
1303:     PROCEDURE BtnAlterarClick()
1304:         LOCAL loc_oErro
1305:         TRY
1306:             IF !USED("cursor_4c_Dados")
1307:                 MsgAviso("Nenhum registro de capacidade produtiva disponivel.", "Aviso")
1308:                 RETURN
1309:             ENDIF
1310:             SELECT cursor_4c_Dados
1311:             IF EOF() OR RECCOUNT() = 0
1312:                 MsgAviso("Selecione um registro do grid.", "Aviso")
1313:                 RETURN
1314:             ENDIF
1315: 
1316:             *-- Garante que campos de detalhe estao populados com a linha corrente
1317:             THIS.GrdDadosAfterRowColChange(0)
1318:             THIS.pgf_4c_Paginas.ActivePage = 2
1319:         CATCH TO loc_oErro
1320:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
1321:         ENDTRY
1322:     ENDPROC
1323: 
1324:     *==========================================================================
1325:     * BtnVisualizarClick - Alterna para Page2 (detalhe do registro selecionado)
1326:     * OPERACIONAL read-only: equivalente ao DblClick no grid (GrdDadosDblClick)
1327:     *==========================================================================
1328:     PROCEDURE BtnVisualizarClick()
1329:         LOCAL loc_oErro
1330:         TRY
1331:             IF !USED("cursor_4c_Dados")
1332:                 MsgAviso("Nenhum registro de capacidade produtiva disponivel.", "Aviso")
1333:                 RETURN
1334:             ENDIF
1335:             SELECT cursor_4c_Dados
1336:             IF EOF() OR RECCOUNT() = 0
1337:                 MsgAviso("Selecione um registro do grid.", "Aviso")
1338:                 RETURN
1339:             ENDIF
1340: 
1341:             *-- Popula Page2 com o registro corrente e navega
1342:             THIS.GrdDadosAfterRowColChange(0)
1343:             THIS.pgf_4c_Paginas.ActivePage = 2
1344:         CATCH TO loc_oErro
1345:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
1346:         ENDTRY
1347:     ENDPROC
1348: 
1349:     *==========================================================================
1350:     * BtnExcluirClick - Encerra a consulta e fecha o formulario
1351:     * OPERACIONAL read-only: "Excluir" mapeia para encerrar a sessao de consulta
1352:     * (equivalente ao botao Encerrar / CmdSairClick do form original)
1353:     *==========================================================================
1354:     PROCEDURE BtnExcluirClick()
1355:         IF MsgConfirma("Deseja encerrar a consulta de capacidade produtiva?", "Confirma" + CHR(231) + CHR(227) + "o")
1356:             THIS.Release()
1357:         ENDIF
1358:     ENDPROC
1359: 
1360:     *==========================================================================
1361:     * CarregarLista - Refresh completo: recarrega dados e atualiza grid
1362:     * OPERACIONAL: equivalente a re-executar a consulta parametrizada
1363:     *==========================================================================
1364:     PROCEDURE CarregarLista()
1365:         LOCAL loc_lSucesso
1366:         loc_lSucesso = THIS.CarregarDados()
1367:         IF loc_lSucesso AND USED("cursor_4c_Dados")
1368:             THIS.AtualizarGrid()
1369:             SELECT cursor_4c_Dados
1370:             GO TOP
1371:             THIS.GrdDadosAfterRowColChange(0)
1372:             IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1373:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1374:             ENDIF
1375:         ENDIF
1376:         RETURN loc_lSucesso
1377:     ENDPROC
1378: 
1379:     *==========================================================================
1380:     * FormParaBO - Transfere parametros do form para o BO antes de consultar
1381:     *==========================================================================
1382:     PROCEDURE FormParaBO()
1383:         WITH THIS.this_oBusinessObject
1384:             .this_nCodigo  = THIS.this_nCodigo
1385:             .this_cFase    = THIS.this_cFase
1386:             .this_cUnidade = THIS.this_cUnidade
1387:             .this_dData    = THIS.this_dData
1388:         ENDWITH
1389:     ENDPROC
1390: 
1391:     *==========================================================================
1392:     * BOParaForm - Popula campos do form com resultados calculados pelo BO
1393:     *==========================================================================
1394:     PROTECTED PROCEDURE BOParaForm()
1395:         LOCAL loc_oPg, loc_oErro
1396:         IF TYPE("THIS.pgf_4c_Paginas") != "O"
1397:             RETURN
1398:         ENDIF
1399:         TRY
1400:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1401:             WITH loc_oPg.cnt_4c_Container1
1402:                 .txt_4c_Fase.Value = ALLTRIM(THIS.this_oBusinessObject.this_cFase)
1403:                 .txt_4c_Data.Value = DTOC(THIS.this_oBusinessObject.this_dData)
1404:                 .Visible     = .T.
1405:             ENDWITH
1406:             WITH loc_oPg.cnt_4c_Container2
1407:                 .txt_4c_Cap.Value = THIS.this_oBusinessObject.this_nCapacidade
1408:                 .txt_4c_Utz.Value = THIS.this_oBusinessObject.this_nUtilizado
1409:                 .txt_4c_Sld.Value = THIS.this_oBusinessObject.this_nSaldo
1410:                 .Visible     = .T.
1411:             ENDWITH
1412:         CATCH TO loc_oErro
1413:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
1414:         ENDTRY
1415:     ENDPROC
1416: 
1417:     *==========================================================================
1418:     * HabilitarCampos - Form OPERACIONAL somente-leitura: todos campos fixos
1419:     *==========================================================================
1420:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1421:         LOCAL loc_oPg
1422:         IF TYPE("THIS.pgf_4c_Paginas") != "O"
1423:             RETURN
1424:         ENDIF
1425:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1426:         IF TYPE("loc_oPg.cnt_4c_Container1") = "O"
1427:             loc_oPg.cnt_4c_Container1.txt_4c_Fase.ReadOnly = .T.
1428:             loc_oPg.cnt_4c_Container1.txt_4c_Data.ReadOnly = .T.
1429:         ENDIF
1430:         IF TYPE("loc_oPg.cnt_4c_Container2") = "O"
1431:             loc_oPg.cnt_4c_Container2.txt_4c_Cap.ReadOnly = .T.
1432:             loc_oPg.cnt_4c_Container2.txt_4c_Utz.ReadOnly = .T.
1433:             loc_oPg.cnt_4c_Container2.txt_4c_Sld.ReadOnly = .T.
1434:         ENDIF
1435:         IF TYPE("loc_oPg.txt_4c_Descr") = "O"
1436:             loc_oPg.txt_4c_Descr.ReadOnly   = .T.
1437:             loc_oPg.txt_4c_Qtde.ReadOnly    = .T.
1438:             loc_oPg.txt_4c_Cliente.ReadOnly = .T.
1439:             loc_oPg.txt_4c_TEnv.ReadOnly    = .T.
1440:         ENDIF
1441:     ENDPROC
1442: 
1443:     *==========================================================================
1444:     * LimparCampos - Limpa campos informativos abaixo do grid
1445:     *==========================================================================
1446:     PROTECTED PROCEDURE LimparCampos()
1447:         LOCAL loc_oPg, loc_oErro
1448:         IF TYPE("THIS.pgf_4c_Paginas") != "O"
1449:             RETURN
1450:         ENDIF
1451:         TRY
1452:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1453:             loc_oPg.txt_4c_Descr.Value    = ""
1454:             loc_oPg.txt_4c_Qtde.Value     = 0
1455:             loc_oPg.txt_4c_Cliente.Value  = ""
1456:             loc_oPg.txt_4c_TEnv.Value     = 0
1457:             loc_oPg.img_4c_FigJpg.Visible = .F.
1458:             loc_oPg.img_4c_FigJpg.Picture = ""
1459:             loc_oPg.shp_4c_Shape4.Visible = .F.
1460:         CATCH TO loc_oErro
1461:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
1462:         ENDTRY
1463:     ENDPROC
1464: 
1465:     *==========================================================================
1466:     * AjustarBotoesPorModo - OPERACIONAL sem modos CRUD: botoes fixos
1467:     *==========================================================================
1468:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1469:         LOCAL loc_oPg
1470:         IF TYPE("THIS.pgf_4c_Paginas") != "O"
1471:             RETURN
1472:         ENDIF
1473:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1474:         IF TYPE("loc_oPg.cmd_4c_Sair") = "O"
1475:             loc_oPg.cmd_4c_Sair.Enabled = .T.
1476:         ENDIF
1477:     ENDPROC
1478: 
1479:     *==========================================================================
1480:     * BtnBuscarClick - Recarrega consulta com parametros atuais (equivale a refresh)
1481:     *==========================================================================
1482:     PROCEDURE BtnBuscarClick()
1483:         LOCAL loc_oErro
1484:         TRY
1485:             THIS.LockScreen = .T.
1486:             IF THIS.CarregarDados()
1487:                 IF USED("cursor_4c_Dados")
1488:                     THIS.AtualizarGrid()
1489:                     SELECT cursor_4c_Dados
1490:                     GO TOP
1491:                     THIS.GrdDadosAfterRowColChange(0)
1492:                     IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1493:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1494:                     ENDIF
1495:                 ENDIF
1496:                 THIS.pgf_4c_Paginas.Visible = .T.
1497:                 THIS.pgf_4c_Paginas.ActivePage = 1
1498:             ENDIF
1499:             THIS.LockScreen = .F.
1500:         CATCH TO loc_oErro
1501:             THIS.LockScreen = .F.
1502:             MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
1503:         ENDTRY
1504:     ENDPROC
1505: 
1506:     *==========================================================================
1507:     * BtnEncerrarClick - Fecha o formulario
1508:     *==========================================================================
1509:     PROCEDURE BtnEncerrarClick()
1510:         THIS.Release()
1511:     ENDPROC
1512: 
1513:     *==========================================================================
1514:     * BtnSalvarClick - Nao aplicavel em form OPERACIONAL somente-leitura
1515:     *==========================================================================
1516:     PROCEDURE BtnSalvarClick()
1517:         MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + ;
1518:             " de consulta somente leitura. " + ;
1519:             "Opera" + CHR(231) + CHR(227) + "o de salvamento n" + ;
1520:             CHR(227) + "o " + CHR(233) + " suportada.", ;
1521:             "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
1522:     ENDPROC
1523: 
1524:     *==========================================================================
1525:     * BtnCancelarClick - Retorna a Page1 (visao principal do grid)
1526:     *==========================================================================
1527:     PROCEDURE BtnCancelarClick()
1528:         THIS.pgf_4c_Paginas.Visible = .T.
1529:         THIS.pgf_4c_Paginas.ActivePage = 1
1530:         IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1531:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.SetFocus()
1532:         ENDIF
1533:     ENDPROC
1534: 
1535:     *==========================================================================
1536:     * Destroy - Libera BO e delega restante ao FormBase
1537:     *==========================================================================
1538:     PROCEDURE Destroy()
1539:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1540:             THIS.this_oBusinessObject = .NULL.
1541:         ENDIF
1542:         DODEFAULT()
1543:     ENDPROC
1544: 
1545: ENDDEFINE


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

