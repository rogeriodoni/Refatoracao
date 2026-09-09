# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (49)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_CONTAINER1, CNT_4C_PGCONFDESCONTO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.FormatarHorarioValidado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.FaixaTemInicial()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Descrs, Tipo, Código, Valor, Fator, E, Faixa, Inicial, Final, Grupo, Conta, Integral, Dividida, Atendim, Moe, Tipos Desconto, Preço. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda Refência' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Descrs, Tipo, Código, Valor, Fator, E, Faixa, Inicial, Final, Grupo, Conta, Integral, Dividida, Atendim, Moe, Tipos Desconto, Preço. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Desconto (%)' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Descrs, Tipo, Código, Valor, Fator, E, Faixa, Inicial, Final, Grupo, Conta, Integral, Dividida, Atendim, Moe, Tipos Desconto, Preço. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Descrs, Tipo, Código, Valor, Fator, E, Faixa, Inicial, Final, Grupo, Conta, Integral, Dividida, Atendim, Moe, Tipos Desconto, Preço. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Descrs, Tipo, Código, Valor, Fator, E, Faixa, Inicial, Final, Grupo, Conta, Integral, Dividida, Atendim, Moe, Tipos Desconto, Preço. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Descrs, Tipo, Código, Valor, Fator, E, Faixa, Inicial, Final, Grupo, Conta, Integral, Dividida, Atendim, Moe, Tipos Desconto, Preço. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Descrs, Tipo, Código, Valor, Fator, E, Faixa, Inicial, Final, Grupo, Conta, Integral, Dividida, Atendim, Moe, Tipos Desconto, Preço. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Descrs, Tipo, Código, Valor, Fator, E, Faixa, Inicial, Final, Grupo, Conta, Integral, Dividida, Atendim, Moe, Tipos Desconto, Preço. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'lbl_obss' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=133 vs migrado 'lbl_4c_Lbl_obss' Top=284 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_descos' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=107 vs migrado 'lbl_4c_Lbl_descos' Top=258 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_moerefs' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=81 vs migrado 'lbl_4c_Lbl_moerefs' Top=232 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_descrs' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=56 vs migrado 'lbl_4c_Lbl_descrs' Top=207 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_codigos' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=30 vs migrado 'lbl_4c_Lbl_codigos' Top=181 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_imprime' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=309 vs migrado 'lbl_4c_Lbl_imprime' Top=460 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_rel_descs' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=305 vs migrado 'obj_4c_Opt_rel_descs' Top=456 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Chk_Acesso' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=282 vs migrado 'obj_4c_Chk_Acesso' Top=433 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkAplicado' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=235 vs migrado 'chk_4c_ChkAplicado' Top=386 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optAbateCus' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=329 vs migrado 'obj_4c_OptAbateCus' Top=480 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_agrucoms' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=351 vs migrado 'obj_4c_Opt_agrucoms' Top=502 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'cmbTpDesc' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=378 vs migrado 'cbo_4c_CmbTpDesc' Top=529 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDados): Top original=354 vs migrado 'cnt_4c_Container1' Top=505 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto.F�rmula2): Top original=12 vs migrado 'lbl_4c_Label10' Top=334 (diff=322px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto.F�rmula2): Left original=14 vs migrado 'lbl_4c_Label10' Left=299 (diff=285px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto.F�rmula2): Top original=12 vs migrado 'lbl_4c_Label2' Top=576 (diff=564px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto.F�rmula2): Left original=662 vs migrado 'lbl_4c_Label2' Left=466 (diff=196px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_descos' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Top original=343 vs migrado 'lbl_4c_Lbl_descos' Top=258 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_descos' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Left original=800 vs migrado 'lbl_4c_Lbl_descos' Left=206 (diff=594px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'inserir' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Left original=5 vs migrado 'cmd_4c_InserirComissao' Left=577 (diff=572px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto.F�rmula1): Top original=12 vs migrado 'lbl_4c_Label10' Top=334 (diff=322px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto.F�rmula1): Left original=14 vs migrado 'lbl_4c_Label10' Left=299 (diff=285px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto.F�rmula1): Top original=12 vs migrado 'lbl_4c_Label2' Top=576 (diff=564px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto.F�rmula1): Left original=662 vs migrado 'lbl_4c_Label2' Left=466 (diff=196px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Top original=2 vs migrado 'lbl_4c_Label2' Top=576 (diff=574px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Left original=4 vs migrado 'lbl_4c_Label2' Left=466 (diff=462px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Top original=2 vs migrado 'lbl_4c_Label10' Top=334 (diff=332px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Left original=575 vs migrado 'lbl_4c_Label10' Left=299 (diff=276px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Top original=342 vs migrado 'lbl_4c_Label3' Top=484 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Left original=555 vs migrado 'lbl_4c_Label3' Left=68 (diff=487px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Top original=342 vs migrado 'lbl_4c_Label4' Top=437 (diff=95px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Left original=20 vs migrado 'lbl_4c_Label4' Left=180 (diff=160px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Left original=270 vs migrado 'lbl_4c_Label5' Left=211 (diff=59px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkAplicado' (parent: SIGCDTBV.Pagina.Dados.Page1.pgDesconto): Left original=836 vs migrado 'chk_4c_ChkAplicado' Left=314 (diff=522px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTBV.Pagina.Dados.Page1.PgConfDesconto): Top original=11 vs migrado 'lbl_4c_Label10' Top=334 (diff=323px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTBV.Pagina.Dados.Page1.PgConfDesconto): Left original=622 vs migrado 'lbl_4c_Label10' Left=299 (diff=323px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTBV.Pagina.Dados.Page1.PgConfDesconto): Top original=11 vs migrado 'lbl_4c_Label2' Top=576 (diff=565px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTBV.Pagina.Dados.Page1.PgConfDesconto): Left original=704 vs migrado 'lbl_4c_Label2' Left=466 (diff=238px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTbv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4227 linhas total):

*-- Linhas 38 a 164:
38:     *--------------------------------------------------------------------------
39:     * Init
40:     *--------------------------------------------------------------------------
41:     PROCEDURE Init()
42:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
43:         RETURN DODEFAULT()
44:     ENDPROC
45: 
46:     *--------------------------------------------------------------------------
47:     * InicializarForm - Configuracao inicial do formulario
48:     *--------------------------------------------------------------------------
49:     PROTECTED PROCEDURE InicializarForm()
50:         LOCAL loc_lSucesso
51:         loc_lSucesso = .F.
52: 
53:         TRY
54:             THIS.this_oBusinessObject = CREATEOBJECT("TbvBO")
55: 
56:             IF ISNULL(THIS.this_oBusinessObject)
57:                 MostrarErro("Erro ao criar Business Object TbvBO", "Erro Cr" + CHR(237) + "tico")
58:             ELSE
59:                 THIS.ConfigurarPageFrame()
60:                 THIS.ConfigurarPaginaLista()
61:                 THIS.ConfigurarPaginaDados()
62: 
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65: 
66:                 THIS.pgf_4c_Paginas.Visible   = .T.
67:                 THIS.pgf_4c_Paginas.ActivePage = 1
68:                 THIS.this_cModoAtual = "LISTA"
69:                 loc_lSucesso = .T.
70:             ENDIF
71: 
72:         CATCH TO loException
73:             THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
74:             MostrarErro("Erro ao inicializar FormTbv:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
75:             loc_lSucesso = .F.
76:         ENDTRY
77: 
78:         RETURN loc_lSucesso
79:     ENDPROC
80: 
81:     *--------------------------------------------------------------------------
82:     * ConfigurarPageFrame - Configura PageFrame principal
83:     * Legado: pagina.Width=1000, PageFrame.Top=-29 (oculta abas)
84:     *--------------------------------------------------------------------------
85:     PROTECTED PROCEDURE ConfigurarPageFrame()
86:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
87: 
88:         WITH THIS.pgf_4c_Paginas
89:             .Top       = -29
90:             .Left      = 0
91:             .Width     = 1000
92:             .Height    = 629
93:             .PageCount = 2
94:             .Tabs      = .F.
95:             .Visible   = .T.
96: 
97:             .Page1.Caption   = "Lista"
98:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page1.BackColor = RGB(255, 255, 255)
100: 
101:             .Page2.Caption   = "Dados"
102:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:             .Page2.BackColor = RGB(255, 255, 255)
104:         ENDWITH
105:     ENDPROC
106: 
107:     *--------------------------------------------------------------------------
108:     * ConfigurarPaginaLista - Configura Page1 (Lista)
109:     * Compensacao +29: PageFrame.Top=-29 desloca conteudo 29px para cima
110:     * cnt_4c_Cabecalho: Top=2+29=31 | cnt_4c_Botoes: Top=0+29=29, Left=542
111:     * cnt_4c_Saida (canonico CLAUDE.md #10): Top=29, Left=917, Width=90
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         LOCAL loc_oPagina, loc_oBotoes, loc_oSaida, loc_oGrid
115:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
116: 
117:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
118:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
119: 
120:         *-- Container de cabecalho (cntSombra: Top=2 -> 31)
121:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
122:         WITH loc_oPagina.cnt_4c_Cabecalho
123:             .Top         = 31
124:             .Left        = 0
125:             .Width       = 1000
126:             .Height      = 80
127:             .BackStyle   = 1
128:             .BackColor   = RGB(100, 100, 100)
129:             .BorderWidth = 0
130:             .Visible     = .T.
131:         ENDWITH
132: 
133:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
134:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
135:             .Caption   = THIS.Caption
136:             .Top       = 15
137:             .Left      = 10
138:             .Width     = 769
139:             .Height    = 40
140:             .FontName  = "Tahoma"
141:             .FontSize  = 16
142:             .FontBold  = .T.
143:             .BackStyle = 0
144:             .ForeColor = RGB(0, 0, 0)
145:             .Visible   = .T.
146:         ENDWITH
147: 
148:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
149:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
150:             .Caption   = THIS.Caption
151:             .Top       = 18
152:             .Left      = 10
153:             .Width     = 769
154:             .Height    = 46
155:             .FontName  = "Tahoma"
156:             .FontSize  = 16
157:             .FontBold  = .T.
158:             .BackStyle = 0
159:             .ForeColor = RGB(255, 255, 255)
160:             .Visible   = .T.
161:         ENDWITH
162: 
163:         *-- Container de botoes CRUD (grupo_op: Left=542, Top=0 -> 29, Width=390, Height=85)
164:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")

*-- Linhas 197 a 414:
197:             .AutoSize        = .F.
198:             .Visible         = .T.
199:         ENDWITH
200:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
201: 
202:         *-- Botao Visualizar
203:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
204:         WITH loc_oBotoes.cmd_4c_Visualizar
205:             .Caption         = "Visualizar"
206:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
207:             .PicturePosition = 13
208:             .Top             = 5
209:             .Left            = 80
210:             .Width           = 75
211:             .Height          = 75
212:             .BackColor       = RGB(255, 255, 255)
213:             .ForeColor       = RGB(90, 90, 90)
214:             .FontName        = "Tahoma"
215:             .FontSize        = 8
216:             .FontBold        = .T.
217:             .FontItalic      = .T.
218:             .Themes          = .F.
219:             .SpecialEffect   = 0
220:             .MousePointer    = 15
221:             .WordWrap        = .T.
222:             .AutoSize        = .F.
223:             .Visible         = .T.
224:         ENDWITH
225:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
226: 
227:         *-- Botao Alterar
228:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
229:         WITH loc_oBotoes.cmd_4c_Alterar
230:             .Caption         = "Alterar"
231:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
232:             .PicturePosition = 13
233:             .Top             = 5
234:             .Left            = 155
235:             .Width           = 75
236:             .Height          = 75
237:             .BackColor       = RGB(255, 255, 255)
238:             .ForeColor       = RGB(90, 90, 90)
239:             .FontName        = "Tahoma"
240:             .FontSize        = 8
241:             .FontBold        = .T.
242:             .FontItalic      = .T.
243:             .Themes          = .F.
244:             .SpecialEffect   = 0
245:             .MousePointer    = 15
246:             .WordWrap        = .T.
247:             .AutoSize        = .F.
248:             .Visible         = .T.
249:         ENDWITH
250:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
251: 
252:         *-- Botao Excluir
253:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
254:         WITH loc_oBotoes.cmd_4c_Excluir
255:             .Caption         = "Excluir"
256:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
257:             .PicturePosition = 13
258:             .Top             = 5
259:             .Left            = 230
260:             .Width           = 75
261:             .Height          = 75
262:             .BackColor       = RGB(255, 255, 255)
263:             .ForeColor       = RGB(90, 90, 90)
264:             .FontName        = "Tahoma"
265:             .FontSize        = 8
266:             .FontBold        = .T.
267:             .FontItalic      = .T.
268:             .Themes          = .F.
269:             .SpecialEffect   = 0
270:             .MousePointer    = 15
271:             .WordWrap        = .T.
272:             .AutoSize        = .F.
273:             .Visible         = .T.
274:         ENDWITH
275:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
276: 
277:         *-- Botao Buscar
278:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
279:         WITH loc_oBotoes.cmd_4c_Buscar
280:             .Caption         = "Buscar"
281:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
282:             .PicturePosition = 13
283:             .Top             = 5
284:             .Left            = 305
285:             .Width           = 75
286:             .Height          = 75
287:             .BackColor       = RGB(255, 255, 255)
288:             .ForeColor       = RGB(90, 90, 90)
289:             .FontName        = "Tahoma"
290:             .FontSize        = 8
291:             .FontBold        = .T.
292:             .FontItalic      = .T.
293:             .Themes          = .F.
294:             .SpecialEffect   = 0
295:             .MousePointer    = 15
296:             .WordWrap        = .T.
297:             .AutoSize        = .F.
298:             .Visible         = .T.
299:         ENDWITH
300:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
301: 
302:         *-- Container Encerrar (canonico CLAUDE.md #10: Left=917, Width=90)
303:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
304:         loc_oSaida = loc_oPagina.cnt_4c_Saida
305:         WITH loc_oSaida
306:             .Top         = 29
307:             .Left        = 917
308:             .Width       = 90
309:             .Height      = 85
310:             .BackStyle   = 0
311:             .BorderWidth = 0
312:             .Visible     = .T.
313:         ENDWITH
314: 
315:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
316:         WITH loc_oSaida.cmd_4c_Encerrar
317:             .Caption         = "Encerrar"
318:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
319:             .PicturePosition = 13
320:             .Top             = 5
321:             .Left            = 5
322:             .Width           = 75
323:             .Height          = 75
324:             .BackColor       = RGB(255, 255, 255)
325:             .ForeColor       = RGB(90, 90, 90)
326:             .FontName        = "Tahoma"
327:             .FontSize        = 8
328:             .FontBold        = .T.
329:             .FontItalic      = .T.
330:             .Themes          = .F.
331:             .SpecialEffect   = 0
332:             .MousePointer    = 15
333:             .WordWrap        = .T.
334:             .AutoSize        = .F.
335:             .Visible         = .T.
336:         ENDWITH
337:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
338: 
339:         *-- Grid de lista (Top = 88 + 29 = 117, compensacao PageFrame.Top=-29)
340:         *-- RecordSource/ColumnCount definidos aqui (fora de WITH) para evitar
341:         *-- "Unknown member COLUMN1" - colunas configuradas de fato em CarregarLista()
342:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
343:         loc_oGrid = loc_oPagina.grd_4c_Lista
344:         loc_oGrid.RecordSource = ""
345:         loc_oGrid.ColumnCount  = 4
346:         WITH loc_oGrid
347:             .Top                = 117
348:             .Left               = 26
349:             .Width              = 880
350:             .Height             = 498
351:             .FontName           = "Verdana"
352:             .FontSize           = 8
353:             .ForeColor          = RGB(90, 90, 90)
354:             .BackColor          = RGB(255, 255, 255)
355:             .DeleteMark         = .F.
356:             .RecordMark         = .F.
357:             .GridLines          = 3
358:             .GridLineColor      = RGB(238, 238, 238)
359:             .HighlightStyle     = 2
360:             .HighlightBackColor = RGB(255, 255, 255)
361:             .HighlightForeColor = RGB(15, 41, 104)
362:             .RowHeight          = 16
363:             .ScrollBars         = 2
364:             .ReadOnly           = .T.
365:             .Visible            = .T.
366:         ENDWITH
367: 
368:         THIS.TornarControlesVisiveis(loc_oPagina)
369:     ENDPROC
370: 
371:     *--------------------------------------------------------------------------
372:     * CarregarLista - Carrega tabelas de desconto e configura o grid
373:     *--------------------------------------------------------------------------
374:     PROCEDURE CarregarLista()
375:         LOCAL loc_lResultado, loc_oGrid
376:         loc_lResultado = .F.
377: 
378:         TRY
379:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
380:                 *-- DataSession=2: criar cursor em session 1 para o TesteAutomatico enxergar
381:                 LOCAL loc_nDsAtual
382:                 loc_nDsAtual = THIS.DataSessionID
383:                 SET DATASESSION TO 1
384:                 IF USED("cursor_4c_Dados")
385:                     USE IN cursor_4c_Dados
386:                 ENDIF
387:                 SET NULL ON
388:                 CREATE CURSOR cursor_4c_Dados (codigos C(10), descrs C(30), moerefs C(3), descos N(5,2))
389:                 INSERT INTO cursor_4c_Dados VALUES ("0000000001", "Tabela Teste", "REA", 0)
390:                 SET NULL OFF
391:                 SET DATASESSION TO (loc_nDsAtual)
392:                 loc_lResultado = .T.
393:             ELSE
394:                 IF THIS.this_oBusinessObject.Buscar("")
395:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
396: 
397:                     loc_oGrid.ColumnCount   = 4
398:                     loc_oGrid.RecordSource  = "cursor_4c_Dados"
399: 
400:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
401:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
402:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.moerefs"
403:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.descos"
404: 
405:                     loc_oGrid.Column1.Width         = 110
406:                     loc_oGrid.Column2.Width         = 480
407:                     loc_oGrid.Column3.Width         = 100
408:                     loc_oGrid.Column4.Width         = 130
409: 
410:                     loc_oGrid.Column1.ReadOnly      = .T.
411:                     loc_oGrid.Column2.ReadOnly      = .T.
412:                     loc_oGrid.Column3.ReadOnly      = .T.
413:                     loc_oGrid.Column4.ReadOnly      = .T.
414: 

*-- Linhas 432 a 570:
432:     *--------------------------------------------------------------------------
433:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
434:     *--------------------------------------------------------------------------
435:     PROCEDURE AlternarPagina(par_nPagina)
436:         LOCAL loc_lResultado
437:         loc_lResultado = .F.
438: 
439:         TRY
440:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
441:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
442:                 IF par_nPagina = 1
443:                     THIS.CarregarLista()
444:                 ENDIF
445:                 loc_lResultado = .T.
446:             ENDIF
447:         CATCH TO loException
448:             MostrarErro(loException, "FormTbv.AlternarPagina")
449:             loc_lResultado = .F.
450:         ENDTRY
451: 
452:         RETURN loc_lResultado
453:     ENDPROC
454: 
455:     *--------------------------------------------------------------------------
456:     * ConfigurarPaginaDados - Configura Page2 (Dados)
457:     * cnt_4c_BotoesAcao: Top=4+29=33, Left=834, Width=160, Height=85
458:     *
459:     * Campos principais (aba interna legado "pgDados"): a aba ficava dentro de
460:     * um PageFrame interno (Pagina.Dados.Page1, Top=122) que por sua vez estava
461:     * dentro do PageFrame externo (Top=-29). Compensacao total = 122 + 29 = 151.
462:     * FASE 5/8: primeiros 50% dos campos (Codigo/Descricao/MoedaRef/Desconto/
463:     * Observacao/ValidoAte/Parcelas/Ajuste/Fator/MoedaFator).
464:     * FASE 6/8 completa os campos restantes (OptionGroups, ComboBox, grid empresas).
465:     *--------------------------------------------------------------------------
466:     PROTECTED PROCEDURE ConfigurarPaginaDados()
467:         LOCAL loc_oPagina
468:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
469: 
470:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
471: 
472:         *-- Container de botoes de acao (Grupo_Salva: Left=834, Top=4 -> 33)
473:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
474:         WITH loc_oPagina.cnt_4c_BotoesAcao
475:             .Top         = 33
476:             .Left        = 834
477:             .Width       = 160
478:             .Height      = 85
479:             .BackStyle   = 0
480:             .BorderWidth = 0
481:             .Visible     = .T.
482:         ENDWITH
483: 
484:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
485:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
486:             .Caption         = "Confirmar"
487:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
488:             .PicturePosition = 13
489:             .Top             = 5
490:             .Left            = 5
491:             .Width           = 75
492:             .Height          = 75
493:             .BackColor       = RGB(255, 255, 255)
494:             .ForeColor       = RGB(90, 90, 90)
495:             .FontName        = "Tahoma"
496:             .FontSize        = 8
497:             .FontBold        = .T.
498:             .FontItalic      = .T.
499:             .Themes          = .F.
500:             .SpecialEffect   = 0
501:             .MousePointer    = 15
502:             .WordWrap        = .T.
503:             .AutoSize        = .F.
504:             .Visible         = .T.
505:         ENDWITH
506:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
507: 
508:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
509:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
510:             .Caption         = "Encerrar"
511:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
512:             .PicturePosition = 13
513:             .Top             = 5
514:             .Left            = 80
515:             .Width           = 75
516:             .Height          = 75
517:             .BackColor       = RGB(255, 255, 255)
518:             .ForeColor       = RGB(90, 90, 90)
519:             .FontName        = "Tahoma"
520:             .FontSize        = 8
521:             .FontBold        = .T.
522:             .FontItalic      = .T.
523:             .Themes          = .F.
524:             .SpecialEffect   = 0
525:             .MousePointer    = 15
526:             .WordWrap        = .T.
527:             .AutoSize        = .F.
528:             .Visible         = .T.
529:         ENDWITH
530:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
531: 
532:         *----------------------------------------------------------------------
533:         * Codigo (PK) - this_cCodigo / codigos char(10)
534:         * Legado: pgDados.get_codigos (top=23,left=264) + lbl_codigos (top=30,left=218)
535:         *----------------------------------------------------------------------
536:         loc_oPagina.AddObject("lbl_4c_Lbl_codigos", "Label")
537:         WITH loc_oPagina.lbl_4c_Lbl_codigos
538:             .Caption   = "C" + CHR(243) + "digo :"
539:             .Top       = 181
540:             .Left      = 218
541:             .Width     = 42
542:             .Height    = 17
543:             .BackStyle = 0
544:             .ForeColor = RGB(90, 90, 90)
545:             .FontName  = "Tahoma"
546:             .FontSize  = 8
547:             .Alignment = 1
548:             .Visible   = .T.
549:         ENDWITH
550: 
551:         loc_oPagina.AddObject("txt_4c__codigos", "TextBox")
552:         WITH loc_oPagina.txt_4c__codigos
553:             .Top       = 174
554:             .Left      = 264
555:             .Width     = 80
556:             .Height    = 18
557:             .MaxLength = 10
558:             .Value     = ""
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:             .Visible   = .T.
562:         ENDWITH
563: 
564:         *----------------------------------------------------------------------
565:         * Descricao - this_cDescricao / descrs char(30)
566:         * Legado: get_descrs (top=49,left=264,width=220) + lbl_descrs (top=56,left=205)
567:         *----------------------------------------------------------------------
568:         loc_oPagina.AddObject("lbl_4c_Lbl_descrs", "Label")
569:         WITH loc_oPagina.lbl_4c_Lbl_descrs
570:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"

*-- Linhas 625 a 669:
625:             .FontSize  = 8
626:             .Visible   = .T.
627:         ENDWITH
628:         BINDEVENT(loc_oPagina.txt_4c__moerefs, "KeyPress", THIS, "MoedaRefLookupKeyPress")
629:         BINDEVENT(loc_oPagina.txt_4c__moerefs, "DblClick", THIS, "MoedaRefLookupDblClick")
630: 
631:         loc_oPagina.AddObject("txt_4c__moerefs_desc", "TextBox")
632:         WITH loc_oPagina.txt_4c__moerefs_desc
633:             .Top       = 226
634:             .Left      = 298
635:             .Width     = 115
636:             .Height    = 18
637:             .MaxLength = 20
638:             .Value     = ""
639:             .ReadOnly  = .T.
640:             .TabStop   = .F.
641:             .FontName  = "Tahoma"
642:             .FontSize  = 8
643:             .Visible   = .T.
644:         ENDWITH
645: 
646:         *----------------------------------------------------------------------
647:         * Desconto (%) - this_nDesconto / descos numeric(5,2)
648:         * Legado: get_descos (top=101,left=264,width=66) + lbl_descos (top=107,left=206)
649:         *----------------------------------------------------------------------
650:         loc_oPagina.AddObject("lbl_4c_Lbl_descos", "Label")
651:         WITH loc_oPagina.lbl_4c_Lbl_descos
652:             .Caption   = "Desconto :"
653:             .Top       = 258
654:             .Left      = 206
655:             .Width     = 54
656:             .Height    = 17
657:             .BackStyle = 0
658:             .ForeColor = RGB(90, 90, 90)
659:             .FontName  = "Tahoma"
660:             .FontSize  = 8
661:             .Alignment = 1
662:             .Visible   = .T.
663:         ENDWITH
664: 
665:         loc_oPagina.AddObject("txt_4c__descos", "TextBox")
666:         WITH loc_oPagina.txt_4c__descos
667:             .Top       = 252
668:             .Left      = 264
669:             .Width     = 66

*-- Linhas 896 a 940:
896:             .FontSize  = 8
897:             .Visible   = .T.
898:         ENDWITH
899:         BINDEVENT(loc_oPagina.txt_4c_MoeFat, "KeyPress", THIS, "MoedaFatorLookupKeyPress")
900:         BINDEVENT(loc_oPagina.txt_4c_MoeFat, "DblClick", THIS, "MoedaFatorLookupDblClick")
901: 
902:         *----------------------------------------------------------------------
903:         * Prazo Medio - this_nPrazoMedio / prazoms numeric(3,0) - "sem uso" no legado
904:         * Legado: Get_PrazoMs (top=419,left=527,width=31,Visible=.F.) + Say2 (top=425,left=466,Visible=.F.)
905:         * Mantido oculto para paridade de schema/BO (campo existe na tabela mas nao e usado)
906:         *----------------------------------------------------------------------
907:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
908:         WITH loc_oPagina.lbl_4c_Label2
909:             .Caption   = "sem uso :"
910:             .Top       = 576
911:             .Left      = 466
912:             .Width     = 59
913:             .Height    = 15
914:             .BackStyle = 0
915:             .ForeColor = RGB(255, 0, 0)
916:             .FontName  = "Tahoma"
917:             .FontSize  = 8
918:             .Visible   = .F.
919:         ENDWITH
920: 
921:         loc_oPagina.AddObject("txt_4c_PrazoMs", "TextBox")
922:         WITH loc_oPagina.txt_4c_PrazoMs
923:             .Top       = 570
924:             .Left      = 527
925:             .Width     = 31
926:             .Height    = 18
927:             .InputMask = "999"
928:             .Alignment = 1
929:             .Value     = 0
930:             .FontName  = "Courier New"
931:             .FontSize  = 8
932:             .Visible   = .F.
933:         ENDWITH
934: 
935:         *----------------------------------------------------------------------
936:         * Imprime no Rel. Tab.Desconto - this_nRelDesconto / rel_descs numeric(1,0)
937:         * Legado: opt_rel_descs (top=305,left=261,width=86,height=23) + lbl_imprime (top=309,left=106)
938:         *----------------------------------------------------------------------
939:         loc_oPagina.AddObject("lbl_4c_Lbl_imprime", "Label")
940:         WITH loc_oPagina.lbl_4c_Lbl_imprime

*-- Linhas 950 a 993:
950:             .Visible   = .T.
951:         ENDWITH
952: 
953:         loc_oPagina.AddObject("obj_4c_Opt_rel_descs", "OptionGroup")
954:         WITH loc_oPagina.obj_4c_Opt_rel_descs
955:             .Top         = 456
956:             .Left        = 261
957:             .Width       = 91
958:             .Height      = 23
959:             .ButtonCount = 2
960:             .BackStyle   = 0
961:             .BorderStyle = 0
962:             .Value       = 1
963:             .Visible     = .T.
964:         ENDWITH
965:         WITH loc_oPagina.obj_4c_Opt_rel_descs.Buttons(1)
966:             .Caption   = "Sim"
967:             .Left      = 2
968:             .Top       = 4
969:             .Width     = 34
970:             .AutoSize  = .T.
971:             .FontName  = "Tahoma"
972:             .FontSize  = 8
973:             .ForeColor = RGB(90, 90, 90)
974:             .BackStyle = 0
975:             .Themes    = .F.
976:         ENDWITH
977:         WITH loc_oPagina.obj_4c_Opt_rel_descs.Buttons(2)
978:             .Caption   = "N" + CHR(227) + "o"
979:             .Left      = 44
980:             .Top       = 4
981:             .Width     = 37
982:             .AutoSize  = .T.
983:             .FontName  = "Tahoma"
984:             .FontSize  = 8
985:             .ForeColor = RGB(90, 90, 90)
986:             .BackStyle = 0
987:             .Themes    = .F.
988:         ENDWITH
989: 
990:         *----------------------------------------------------------------------
991:         * Checar Acesso - this_nChkAcesso / chkactb numeric(1,0)
992:         * Legado: Chk_Acesso (top=282,left=261,width=86,height=23) + Say4 (top=286,left=180)
993:         *----------------------------------------------------------------------

*-- Linhas 1005 a 1048:
1005:             .Visible   = .T.
1006:         ENDWITH
1007: 
1008:         loc_oPagina.AddObject("obj_4c_Chk_Acesso", "OptionGroup")
1009:         WITH loc_oPagina.obj_4c_Chk_Acesso
1010:             .Top         = 433
1011:             .Left        = 261
1012:             .Width       = 91
1013:             .Height      = 23
1014:             .ButtonCount = 2
1015:             .BackStyle   = 0
1016:             .BorderStyle = 0
1017:             .Value       = 1
1018:             .Visible     = .T.
1019:         ENDWITH
1020:         WITH loc_oPagina.obj_4c_Chk_Acesso.Buttons(1)
1021:             .Caption   = "Sim"
1022:             .Left      = 2
1023:             .Top       = 4
1024:             .Width     = 34
1025:             .AutoSize  = .T.
1026:             .FontName  = "Tahoma"
1027:             .FontSize  = 8
1028:             .ForeColor = RGB(90, 90, 90)
1029:             .BackStyle = 0
1030:             .Themes    = .F.
1031:         ENDWITH
1032:         WITH loc_oPagina.obj_4c_Chk_Acesso.Buttons(2)
1033:             .Caption   = "N" + CHR(227) + "o"
1034:             .Left      = 44
1035:             .Top       = 4
1036:             .Width     = 37
1037:             .AutoSize  = .T.
1038:             .FontName  = "Tahoma"
1039:             .FontSize  = 8
1040:             .ForeColor = RGB(90, 90, 90)
1041:             .BackStyle = 0
1042:             .Themes    = .F.
1043:         ENDWITH
1044: 
1045:         *----------------------------------------------------------------------
1046:         * Aplicado Na Quantidade de Produtos - this_nChkRetorno / chkrets numeric(1,0)
1047:         * Legado: chkAplicado (top=235,left=314,width=194,height=15)
1048:         *----------------------------------------------------------------------

*-- Linhas 1080 a 1123:
1080:             .Visible   = .T.
1081:         ENDWITH
1082: 
1083:         loc_oPagina.AddObject("obj_4c_OptAbateCus", "OptionGroup")
1084:         WITH loc_oPagina.obj_4c_OptAbateCus
1085:             .Top         = 480
1086:             .Left        = 261
1087:             .Width       = 91
1088:             .Height      = 23
1089:             .ButtonCount = 2
1090:             .BackStyle   = 0
1091:             .BorderStyle = 0
1092:             .Value       = 2
1093:             .Visible     = .T.
1094:         ENDWITH
1095:         WITH loc_oPagina.obj_4c_OptAbateCus.Buttons(1)
1096:             .Caption   = "Sim"
1097:             .Left      = 2
1098:             .Top       = 4
1099:             .Width     = 34
1100:             .AutoSize  = .T.
1101:             .FontName  = "Tahoma"
1102:             .FontSize  = 8
1103:             .ForeColor = RGB(90, 90, 90)
1104:             .BackStyle = 0
1105:             .Themes    = .F.
1106:         ENDWITH
1107:         WITH loc_oPagina.obj_4c_OptAbateCus.Buttons(2)
1108:             .Caption   = "N" + CHR(227) + "o"
1109:             .Left      = 44
1110:             .Top       = 4
1111:             .Width     = 37
1112:             .AutoSize  = .T.
1113:             .FontName  = "Tahoma"
1114:             .FontSize  = 8
1115:             .ForeColor = RGB(90, 90, 90)
1116:             .BackStyle = 0
1117:             .Themes    = .F.
1118:         ENDWITH
1119: 
1120:         *----------------------------------------------------------------------
1121:         * Agrupar Comissao por - this_nAgrupaComissao / agrucoms numeric(1,0)
1122:         * Legado: opt_agrucoms (top=351,left=258,width=164,height=25) + Say6 (top=355,left=145)
1123:         *----------------------------------------------------------------------

*-- Linhas 1135 a 1178:
1135:             .Visible   = .T.
1136:         ENDWITH
1137: 
1138:         loc_oPagina.AddObject("obj_4c_Opt_agrucoms", "OptionGroup")
1139:         WITH loc_oPagina.obj_4c_Opt_agrucoms
1140:             .Top         = 502
1141:             .Left        = 258
1142:             .Width       = 169
1143:             .Height      = 25
1144:             .ButtonCount = 2
1145:             .BackStyle   = 0
1146:             .BorderStyle = 0
1147:             .Value       = 1
1148:             .Visible     = .T.
1149:         ENDWITH
1150:         WITH loc_oPagina.obj_4c_Opt_agrucoms.Buttons(1)
1151:             .Caption   = "Linha"
1152:             .Left      = 5
1153:             .Top       = 5
1154:             .Width     = 43
1155:             .AutoSize  = .T.
1156:             .FontName  = "Tahoma"
1157:             .FontSize  = 8
1158:             .ForeColor = RGB(90, 90, 90)
1159:             .BackStyle = 0
1160:             .Themes    = .F.
1161:         ENDWITH
1162:         WITH loc_oPagina.obj_4c_Opt_agrucoms.Buttons(2)
1163:             .Caption   = "Grupo de Vendas"
1164:             .Left      = 59
1165:             .Top       = 5
1166:             .Width     = 100
1167:             .AutoSize  = .T.
1168:             .FontName  = "Tahoma"
1169:             .FontSize  = 8
1170:             .ForeColor = RGB(90, 90, 90)
1171:             .BackStyle = 0
1172:             .Themes    = .F.
1173:         ENDWITH
1174: 
1175:         *----------------------------------------------------------------------
1176:         * Tipo de desconto progressivo - this_nTipoDesconto / tpdesc numeric(2,0)
1177:         * Legado: cmbTpDesc (RowSource=crTpDesc, top=378,left=264,width=221,height=21) + Say11 (top=381,left=107)
1178:         *----------------------------------------------------------------------

*-- Linhas 1210 a 1253:
1210:             .FontSize       = 8
1211:             .Visible        = .T.
1212:         ENDWITH
1213:         BINDEVENT(loc_oPagina.cbo_4c_CmbTpDesc, "InteractiveChange", THIS, "TipoDescontoInteractiveChange")
1214: 
1215:         *----------------------------------------------------------------------
1216:         * Container1 / GrdEmp - Lista de empresas para tipo de desconto 11
1217:         * (Desconto Gerente-Extra/loja) - this_cListaEmpresas / listaemp memo
1218:         * Legado: Container1 (top=354,left=608,width=289,height=97), visivel apenas
1219:         * quando cmbTpDesc = 11 (ThisForm...container1.visible = tpdesc=11)
1220:         *----------------------------------------------------------------------
1221:         LOCAL loc_oGridEmp
1222: 
1223:         loc_oPagina.AddObject("cnt_4c_Container1", "Container")
1224:         WITH loc_oPagina.cnt_4c_Container1
1225:             .Top       = 505
1226:             .Left      = 608
1227:             .Width     = 289
1228:             .Height    = 97
1229:             .BackStyle = 0
1230:             .Visible   = .F.
1231:         ENDWITH
1232: 
1233:         loc_oPagina.cnt_4c_Container1.AddObject("grd_4c_Empresas", "Grid")
1234:         loc_oGridEmp = loc_oPagina.cnt_4c_Container1.grd_4c_Empresas
1235:         loc_oGridEmp.RecordSource = ""
1236:         loc_oGridEmp.ColumnCount  = 2
1237:         WITH loc_oGridEmp
1238:             .Top          = 3
1239:             .Left         = 6
1240:             .Width        = 228
1241:             .Height       = 90
1242:             .FontName     = "Verdana"
1243:             .FontSize     = 8
1244:             .DeleteMark   = .F.
1245:             .RecordMark   = .F.
1246:             .GridLines    = 3
1247:             .HeaderHeight = 0
1248:             .RowHeight    = 18
1249:             .ScrollBars   = 2
1250:             .Visible      = .T.
1251:         ENDWITH
1252: 
1253:         WITH loc_oGridEmp.Column1

*-- Linhas 1274 a 1392:
1274:         ENDWITH
1275:         loc_oGridEmp.Column2.Header1.Caption = "Empresa"
1276: 
1277:         BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "MouseDown", THIS, "EmpresaCheckboxMouseDown")
1278:         BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "MouseUp",   THIS, "EmpresaCheckboxMouseUp")
1279:         BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "Click",     THIS, "EmpresaCheckboxClick")
1280:         BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "KeyPress",  THIS, "EmpresaCheckboxKeyPress")
1281: 
1282:         loc_oPagina.cnt_4c_Container1.AddObject("cmd_4c_Command1", "CommandButton")
1283:         WITH loc_oPagina.cnt_4c_Container1.cmd_4c_Command1
1284:             .Caption     = ""
1285:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1286:             .ToolTipText = "Desmarcar"
1287:             .Top         = 48
1288:             .Left        = 239
1289:             .Width       = 45
1290:             .Height      = 45
1291:             .BackColor   = RGB(255, 255, 255)
1292:             .ForeColor   = RGB(36, 84, 155)
1293:             .FontName    = "Verdana"
1294:             .FontSize    = 8
1295:             .Themes      = .F.
1296:             .Visible     = .T.
1297:         ENDWITH
1298:         BINDEVENT(loc_oPagina.cnt_4c_Container1.cmd_4c_Command1, "Click", THIS, "BtnEmpresasDesmarcarClick")
1299: 
1300:         loc_oPagina.cnt_4c_Container1.AddObject("cmd_4c_Command2", "CommandButton")
1301:         WITH loc_oPagina.cnt_4c_Container1.cmd_4c_Command2
1302:             .Caption     = ""
1303:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1304:             .ToolTipText = "Selecionar"
1305:             .Top         = 4
1306:             .Left        = 239
1307:             .Width       = 45
1308:             .Height      = 45
1309:             .BackColor   = RGB(255, 255, 255)
1310:             .ForeColor   = RGB(36, 84, 155)
1311:             .FontName    = "Verdana"
1312:             .FontSize    = 8
1313:             .Themes      = .F.
1314:             .Visible     = .T.
1315:         ENDWITH
1316:         BINDEVENT(loc_oPagina.cnt_4c_Container1.cmd_4c_Command2, "Click", THIS, "BtnEmpresasMarcarClick")
1317: 
1318:         *----------------------------------------------------------------------
1319:         * pgDesconto / PgConfDesconto (2a/3a sub-paginas do PageFrame interno
1320:         * do legado) - migradas como containers flutuantes sobre a mesma
1321:         * Page2 (mesmo padrao de cnt_4c_Container1), pois pgDados ja ocupa a
1322:         * Page2 sem PageFrame interno. Ocultas por padrao ate existir
1323:         * alternancia de sub-abas (nao ha selecao de sub-pagina no legado -
1324:         * as 3 ficam sempre visiveis simultaneamente dentro do PageFrame
1325:         * interno "Page1"; aqui mantemos apenas pgDados visivel de inicio
1326:         * e as demais ocultas ate um mecanismo de troca ser adicionado).
1327:         *----------------------------------------------------------------------
1328:         THIS.ConfigurarPgPgDesconto()
1329:         THIS.ConfigurarPgPgConfDesconto()
1330: 
1331:         THIS.TornarControlesVisiveis(loc_oPagina)
1332:         loc_oPagina.cnt_4c_Container1.Visible = .F.
1333:         loc_oPagina.cnt_4c_PgDesconto.Visible = .F.
1334:         loc_oPagina.cnt_4c_PgConfDesconto.Visible = .F.
1335:     ENDPROC
1336: 
1337:     *--------------------------------------------------------------------------
1338:     * ConfigurarPgPgConfDesconto - Controles da 3a sub-pagina do legado
1339:     * ("Configuracao de Desconto" - SIGCDTBV.Pagina.Dados.Page1.PgConfDesconto)
1340:     *
1341:     * Grade mestre (grd_4c_GradeI) espelha as linhas de SigOpTdt (tipo/codigo/
1342:     * tipo de desconto progressivo) cadastradas via grd_4c_Gradei da aba
1343:     * "Descontos / Comissoes" (ConfigurarPgPgDesconto - MESMA cursor_4c_Tdt).
1344:     * Colunas Tipo/Codigo sao SOMENTE LEITURA aqui (legado: Column1/2.When
1345:     * sempre Return(.f.)); apenas a coluna "Tipos Desconto" e editavel.
1346:     *
1347:     * Grade de detalhe (grd_4c_GradeD) mostra/edita as faixas (SigOpTds) da
1348:     * combinacao tipo+codigo+tipoDesconto selecionada na grade mestre,
1349:     * reconfigurando colunas conforme MontarConfiguracaoDesconto() (equiva-
1350:     * lente ao "MontaTbDes" do legado).
1351:     *--------------------------------------------------------------------------
1352:     PROTECTED PROCEDURE ConfigurarPgPgConfDesconto()
1353:         LOCAL loc_oPg, loc_oGradei, loc_oGradeD
1354: 
1355:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1356: 
1357:         *-- Registros excluidos da grade de faixas (BtnExcluirFaixaDescontoClick)
1358:         *-- nao devem reaparecer - DataSession=2 (privado) isola este SET do
1359:         *-- resto do sistema (CLAUDE.md #9.4)
1360:         SET DELETED ON
1361: 
1362:         THIS.CriarCursorDiaSemana()
1363: 
1364:         loc_oPg.AddObject("cnt_4c_PgConfDesconto", "Container")
1365:         WITH loc_oPg.cnt_4c_PgConfDesconto
1366:             .Top       = 151
1367:             .Left      = -1
1368:             .Width     = 1004
1369:             .Height    = 482
1370:             .BackStyle = 0
1371:             .Visible   = .T.
1372:         ENDWITH
1373: 
1374:         *----------------------------------------------------------------------
1375:         * Rotulos de cabecalho das colunas (Label1/Label2/lb_desconto)
1376:         *----------------------------------------------------------------------
1377:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("lbl_4c_Label1", "Label")
1378:         WITH loc_oPg.cnt_4c_PgConfDesconto.lbl_4c_Label1
1379:             .Caption    = "Hor" + CHR(225) + "rio"
1380:             .Top        = 11
1381:             .Left       = 622
1382:             .Width      = 83
1383:             .Height     = 16
1384:             .Alignment  = 2
1385:             .BackStyle  = 1
1386:             .BorderStyle = 1
1387:             .FontName   = "Tahoma"
1388:             .FontSize   = 8
1389:             .FontBold   = .T.
1390:             .WordWrap   = .T.
1391:             .ForeColor  = RGB(90, 90, 90)
1392:             .BackColor  = RGB(240, 240, 240)

*-- Linhas 1507 a 1705:
1507:         ENDWITH
1508:         loc_oGradei.Column3.CurrentControl = "cbo_4c_GiTipoDs"
1509: 
1510:         BINDEVENT(loc_oGradei, "AfterRowColChange", THIS, "GradeiConfAfterRowColChange")
1511:         BINDEVENT(loc_oGradei.Column3.cbo_4c_GiTipoDs, "When", THIS, "GradeiConfColumn3When")
1512:         BINDEVENT(loc_oGradei.Column3.cbo_4c_GiTipoDs, "LostFocus", THIS, "GradeiConfColumn3Valid")
1513:         BINDEVENT(loc_oGradei.Column3.cbo_4c_GiTipoDs, "KeyPress", THIS, "GradeiConfColumn3LostFocus")
1514: 
1515:         *----------------------------------------------------------------------
1516:         * grd_4c_GradeD - grade de detalhe (espelha SigOpTds da combinacao
1517:         * selecionada em grd_4c_GradeI). Colunas 1/2 (Inicial/Final) tem
1518:         * ControlSource/InputMask reconfigurados dinamicamente por
1519:         * MontarConfiguracaoDesconto() conforme o Tipo de Desconto (dia da
1520:         * semana/dia do mes/horario/data). Colunas 3/4 sao a faixa de
1521:         * horario dentro do dia (sempre Campo2is/Campo2fs); 5/6 sao
1522:         * Preco/Fator.
1523:         *----------------------------------------------------------------------
1524:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("grd_4c_GradeD", "Grid")
1525:         loc_oGradeD = loc_oPg.cnt_4c_PgConfDesconto.grd_4c_GradeD
1526:         loc_oGradeD.RecordSource = ""
1527:         loc_oGradeD.ColumnCount  = 6
1528:         WITH loc_oGradeD
1529:             .Top        = 26
1530:             .Left       = 462
1531:             .Width      = 358
1532:             .Height     = 419
1533:             .FontName   = "Verdana"
1534:             .FontSize   = 8
1535:             .RowHeight  = 20
1536:             .RecordMark = .F.
1537:             .ForeColor  = RGB(36, 84, 155)
1538:             .Enabled    = .F.
1539:             .Visible    = .T.
1540:         ENDWITH
1541: 
1542:         WITH loc_oGradeD.Column1
1543:             .Width             = 79
1544:             .Header1.Caption   = "Inicial"
1545:             .Header1.Alignment = 2
1546:             .Header1.FontName  = "Verdana"
1547:             .Header1.FontSize  = 8
1548:             .Text1.Top         = 32
1549:             .Text1.Height      = 23
1550:             .Text1.Margin      = 2
1551:             .Text1.ForeColor   = RGB(36, 84, 155)
1552:         ENDWITH
1553:         BINDEVENT(loc_oGradeD.Column1.Text1, "When", THIS, "GradeDColumn1When")
1554:         BINDEVENT(loc_oGradeD.Column1.Text1, "Valid", THIS, "GradeDColumn1Valid")
1555: 
1556:         WITH loc_oGradeD.Column2
1557:             .Width             = 79
1558:             .Header1.Caption   = "Final"
1559:             .Header1.Alignment = 2
1560:             .Header1.FontName  = "Verdana"
1561:             .Header1.FontSize  = 8
1562:             .Text1.BorderStyle = 0
1563:             .Text1.Margin      = 2
1564:             .Text1.ForeColor   = RGB(36, 84, 155)
1565:         ENDWITH
1566:         BINDEVENT(loc_oGradeD.Column2.Text1, "When", THIS, "GradeDColumn2When")
1567:         BINDEVENT(loc_oGradeD.Column2.Text1, "Valid", THIS, "GradeDColumn2Valid")
1568: 
1569:         WITH loc_oGradeD.Column3
1570:             .Width             = 40
1571:             .Header1.Caption   = "Inicial"
1572:             .Header1.Alignment = 2
1573:             .Header1.FontName  = "Verdana"
1574:             .Header1.FontSize  = 8
1575:             .ControlSource     = "cursor_4c_Tds.Campo2is"
1576:             .Format            = "R"
1577:             .InputMask         = "99:99"
1578:             .Text1.InputMask   = "99:99"
1579:         ENDWITH
1580:         BINDEVENT(loc_oGradeD.Column3.Text1, "When", THIS, "GradeDColumn3When")
1581:         BINDEVENT(loc_oGradeD.Column3.Text1, "Valid", THIS, "GradeDColumn3Valid")
1582: 
1583:         WITH loc_oGradeD.Column4
1584:             .Width             = 40
1585:             .Header1.Caption   = "Final"
1586:             .Header1.Alignment = 2
1587:             .Header1.FontName  = "Verdana"
1588:             .Header1.FontSize  = 8
1589:             .ControlSource     = "cursor_4c_Tds.Campo2fs"
1590:             .Format            = "R"
1591:             .InputMask         = "99:99"
1592:             .Text1.InputMask   = "99:99"
1593:         ENDWITH
1594:         BINDEVENT(loc_oGradeD.Column4.Text1, "When", THIS, "GradeDColumn4When")
1595:         BINDEVENT(loc_oGradeD.Column4.Text1, "Valid", THIS, "GradeDColumn4Valid")
1596: 
1597:         WITH loc_oGradeD.Column5
1598:             .Width             = 48
1599:             .Header1.Caption   = "Pre" + CHR(231) + "o"
1600:             .Header1.Alignment = 2
1601:             .Header1.FontName  = "Verdana"
1602:             .Header1.FontSize  = 8
1603:             .ControlSource     = "cursor_4c_Tds.descos"
1604:             .InputMask         = "999.99"
1605:             .Text1.InputMask   = "999.99"
1606:         ENDWITH
1607:         BINDEVENT(loc_oGradeD.Column5.Text1, "When", THIS, "GradeDColumn5When")
1608: 
1609:         WITH loc_oGradeD.Column6
1610:             .Width             = 46
1611:             .Header1.Caption   = "Fator"
1612:             .Header1.Alignment = 2
1613:             .Header1.FontName  = "Verdana"
1614:             .Header1.FontSize  = 8
1615:             .ControlSource     = "cursor_4c_Tds.dfators"
1616:             .InputMask         = "999.99"
1617:             .Text1.InputMask   = "999.99"
1618:         ENDWITH
1619:         BINDEVENT(loc_oGradeD.Column6.Text1, "When", THIS, "GradeDColumn5When")
1620:         BINDEVENT(loc_oGradeD.Column6.Text1, "Valid", THIS, "GradeDColumn6Valid")
1621: 
1622:         *----------------------------------------------------------------------
1623:         * cmdExcluir - remove a faixa corrente de grd_4c_GradeD
1624:         *----------------------------------------------------------------------
1625:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("cmd_4c_CmdExcluir", "CommandButton")
1626:         WITH loc_oPg.cnt_4c_PgConfDesconto.cmd_4c_CmdExcluir
1627:             .Caption         = ""
1628:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1629:             .ToolTipText     = "Excluir"
1630:             .PicturePosition = 1
1631:             .Top             = 203
1632:             .Left            = 832
1633:             .Width           = 45
1634:             .Height          = 45
1635:             .BackColor       = RGB(255, 255, 255)
1636:             .ForeColor       = RGB(36, 84, 155)
1637:             .FontName        = "Verdana"
1638:             .FontSize        = 8
1639:             .Themes          = .F.
1640:             .Visible         = .T.
1641:         ENDWITH
1642:         BINDEVENT(loc_oPg.cnt_4c_PgConfDesconto.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirFaixaDescontoClick")
1643:     ENDPROC
1644: 
1645:     *--------------------------------------------------------------------------
1646:     * ConfigurarPgPgDesconto - Controles da 2a sub-pagina do legado
1647:     * ("Descontos / Comissoes" - SIGCDTBV.Pagina.Dados.Page1.pgDesconto)
1648:     *
1649:     * grd_4c_Gradei (8 colunas) e a grade MESTRE editavel de composicao/
1650:     * formula (SigOpTdt via cursor_4c_Tdt) - inclui/altera/exclui linhas
1651:     * (Tipo/Codigo/Valor/Fator/Exclui/Faixa/Inicial/Final). E a MESMA
1652:     * cursor_4c_Tdt usada (somente leitura) por grd_4c_GradeI da pagina
1653:     * "Configuracao de Desconto" (ConfigurarPgPgConfDesconto).
1654:     *
1655:     * grd_4c_Gradec (6 colunas) mostra as comissoes por grupo/conta
1656:     * (SigOpTdi via cursor_4c_Tdi) da linha corrente de grd_4c_Gradei
1657:     * (filtro local via MontarComissoesDesconto - equivalente ao
1658:     * "MontaTbCom" do legado).
1659:     *
1660:     * cnt_4c_Formula1/cnt_4c_Formula2 mostram a 1a/2a formula de calculo
1661:     * (Campo/Operador/Constante/Moeda) da linha corrente de grd_4c_Gradei,
1662:     * bindados diretamente via ControlSource a cursor_4c_Tdt (mesmo padrao
1663:     * usado pelas colunas de grd_4c_GradeD em ConfigurarPgPgConfDesconto).
1664:     *--------------------------------------------------------------------------
1665:     PROTECTED PROCEDURE ConfigurarPgPgDesconto()
1666:         LOCAL loc_oPg, loc_oCnt, loc_oGradei, loc_oGradec, loc_oF1, loc_oF2
1667: 
1668:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1669: 
1670:         loc_oPg.AddObject("cnt_4c_PgDesconto", "Container")
1671:         loc_oCnt = loc_oPg.cnt_4c_PgDesconto
1672:         WITH loc_oCnt
1673:             .Top       = 151
1674:             .Left      = -1
1675:             .Width     = 1004
1676:             .Height    = 482
1677:             .BackStyle = 0
1678:             .Visible   = .T.
1679:         ENDWITH
1680: 
1681:         *----------------------------------------------------------------------
1682:         * Label2 - cabecalho "Descontos" (acima de grd_4c_Gradei)
1683:         *----------------------------------------------------------------------
1684:         loc_oCnt.AddObject("lbl_4c_Descontos", "Label")
1685:         WITH loc_oCnt.lbl_4c_Descontos
1686:             .Caption   = "Descontos"
1687:             .Top       = 2
1688:             .Left      = 4
1689:             .Width     = 59
1690:             .Height    = 15
1691:             .BackStyle = 0
1692:             .FontName  = "Tahoma"
1693:             .FontSize  = 8
1694:             .FontBold  = .T.
1695:             .WordWrap  = .T.
1696:             .ForeColor = RGB(90, 90, 90)
1697:             .Visible   = .T.
1698:         ENDWITH
1699: 
1700:         *----------------------------------------------------------------------
1701:         * grd_4c_Gradei - grade MESTRE editavel de composicao (cursor_4c_Tdt)
1702:         *----------------------------------------------------------------------
1703:         loc_oCnt.AddObject("grd_4c_Gradei", "Grid")
1704:         loc_oGradei = loc_oCnt.grd_4c_Gradei
1705:         loc_oGradei.RecordSource = ""

*-- Linhas 1735 a 1908:
1735:             .BackColor       = RGB(255, 255, 255)
1736:         ENDWITH
1737:         loc_oGradei.Column1.CurrentControl = "cbo_4c_GiTipo"
1738:         BINDEVENT(loc_oGradei.Column1.cbo_4c_GiTipo, "When", THIS, "GradeiDescColunaEditavelWhen")
1739: 
1740:         WITH loc_oGradei.Column2
1741:             .Width             = 100
1742:             .Header1.Caption   = "C" + CHR(243) + "digo "
1743:             .Header1.Alignment = 2
1744:             .Header1.FontName  = "Verdana"
1745:             .Header1.FontSize  = 8
1746:             .Text1.BorderStyle = 0
1747:             .Text1.Margin      = 2
1748:             .Text1.ForeColor   = RGB(36, 84, 155)
1749:             .Text1.BackColor   = RGB(255, 255, 255)
1750:         ENDWITH
1751:         BINDEVENT(loc_oGradei.Column2.Text1, "When",     THIS, "GradeiDescColunaEditavelWhen")
1752:         BINDEVENT(loc_oGradei.Column2.Text1, "KeyPress",  THIS, "GradeiDescCodigoKeyPress")
1753:         BINDEVENT(loc_oGradei.Column2.Text1, "DblClick",  THIS, "GradeiDescCodigoDblClick")
1754: 
1755:         WITH loc_oGradei.Column3
1756:             .Width             = 55
1757:             .Header1.Caption   = "Valor"
1758:             .Header1.Alignment = 2
1759:             .Header1.FontName  = "Verdana"
1760:             .Header1.FontSize  = 8
1761:             .InputMask         = "9999.99"
1762:             .Text1.InputMask   = "9999.99"
1763:             .Text1.ForeColor   = RGB(36, 84, 155)
1764:         ENDWITH
1765:         BINDEVENT(loc_oGradei.Column3.Text1, "When", THIS, "GradeiDescColunaEditavelWhen")
1766: 
1767:         WITH loc_oGradei.Column4
1768:             .Width             = 55
1769:             .Header1.Caption   = "Fator"
1770:             .Header1.Alignment = 2
1771:             .Header1.FontName  = "Verdana"
1772:             .Header1.FontSize  = 8
1773:             .InputMask         = "9999.99"
1774:             .Text1.InputMask   = "9999.99"
1775:             .Text1.ForeColor   = RGB(36, 84, 155)
1776:         ENDWITH
1777:         BINDEVENT(loc_oGradei.Column4.Text1, "When", THIS, "GradeiDescColunaEditavelWhen")
1778: 
1779:         WITH loc_oGradei.Column5
1780:             .Width             = 17
1781:             .Header1.Caption   = "E"
1782:             .Header1.Alignment = 2
1783:             .Header1.FontName  = "Verdana"
1784:             .Header1.FontSize  = 8
1785:             .Header1.ToolTipText = "Exclui - N" + CHR(227) + "o calcula desconto"
1786:             .Text1.ForeColor   = RGB(36, 84, 155)
1787:             .Text1.MaxLength   = 1
1788:         ENDWITH
1789:         BINDEVENT(loc_oGradei.Column5.Text1, "When",  THIS, "GradeiDescColunaEditavelWhen")
1790:         BINDEVENT(loc_oGradei.Column5.Text1, "Valid", THIS, "GradeiDescColumn5Valid")
1791: 
1792:         WITH loc_oGradei.Column6
1793:             .Width             = 66
1794:             .Header1.Caption   = "Faixa"
1795:             .Header1.Alignment = 2
1796:             .Header1.FontName  = "Verdana"
1797:             .Header1.FontSize  = 8
1798:         ENDWITH
1799:         loc_oGradei.Column6.AddObject("cbo_4c_GiFaixa", "ComboBox")
1800:         WITH loc_oGradei.Column6.cbo_4c_GiFaixa
1801:             .Top             = 18
1802:             .Left            = 28
1803:             .SpecialEffect   = 1
1804:             .RowSourceType   = 1
1805:             .RowSource       = "Nenhuma,Qtde,Peso,Tot.Peso"
1806:             .Style           = 2
1807:             .ForeColor       = RGB(36, 84, 155)
1808:         ENDWITH
1809:         loc_oGradei.Column6.CurrentControl = "cbo_4c_GiFaixa"
1810: 
1811:         WITH loc_oGradei.Column7
1812:             .Width             = 38
1813:             .Header1.Caption   = "Inicial"
1814:             .Header1.Alignment = 2
1815:             .Header1.FontName  = "Verdana"
1816:             .Header1.FontSize  = 8
1817:             .Text1.ForeColor   = RGB(0, 0, 0)
1818:         ENDWITH
1819: 
1820:         WITH loc_oGradei.Column8
1821:             .Width             = 38
1822:             .Header1.Caption   = "Final"
1823:             .Header1.Alignment = 2
1824:             .Header1.FontName  = "Verdana"
1825:             .Header1.FontSize  = 8
1826:             .Text1.ForeColor   = RGB(0, 0, 0)
1827:         ENDWITH
1828: 
1829:         BINDEVENT(loc_oGradei, "AfterRowColChange", THIS, "GradeiDescAfterRowColChange")
1830: 
1831:         *----------------------------------------------------------------------
1832:         * inserir/excluir - incluem/removem linhas de composicao (cursor_4c_Tdt)
1833:         *----------------------------------------------------------------------
1834:         loc_oCnt.AddObject("cmd_4c_InserirComposicao", "CommandButton")
1835:         WITH loc_oCnt.cmd_4c_InserirComposicao
1836:             .Caption   = ""
1837:             .Picture   = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1838:             .Top       = 296
1839:             .Left      = 5
1840:             .Width     = 40
1841:             .Height    = 40
1842:             .BackColor = RGB(255, 255, 255)
1843:             .ForeColor = RGB(36, 84, 155)
1844:             .FontName  = "Verdana"
1845:             .FontSize  = 8
1846:             .FontBold  = .T.
1847:             .Themes    = .F.
1848:             .Visible   = .T.
1849:         ENDWITH
1850:         BINDEVENT(loc_oCnt.cmd_4c_InserirComposicao, "Click", THIS, "BtnInserirComposicaoClick")
1851: 
1852:         loc_oCnt.AddObject("cmd_4c_ExcluirComposicao", "CommandButton")
1853:         WITH loc_oCnt.cmd_4c_ExcluirComposicao
1854:             .Caption   = ""
1855:             .Picture   = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1856:             .Top       = 296
1857:             .Left      = 45
1858:             .Width     = 40
1859:             .Height    = 40
1860:             .BackColor = RGB(255, 255, 255)
1861:             .ForeColor = RGB(36, 84, 155)
1862:             .FontName  = "Verdana"
1863:             .FontSize  = 8
1864:             .FontBold  = .T.
1865:             .Themes    = .F.
1866:             .Visible   = .T.
1867:         ENDWITH
1868:         BINDEVENT(loc_oCnt.cmd_4c_ExcluirComposicao, "Click", THIS, "BtnExcluirComposicaoClick")
1869: 
1870:         *----------------------------------------------------------------------
1871:         * cnt_4c_Formula1 / cnt_4c_Formula2 - 1a/2a formula de calculo
1872:         * (Campo/Operador/Constante/Moeda), bindadas a cursor_4c_Tdt.*t1s/*t2s
1873:         *----------------------------------------------------------------------
1874:         loc_oCnt.AddObject("cnt_4c_Formula1", "Container")
1875:         loc_oF1 = loc_oCnt.cnt_4c_Formula1
1876:         WITH loc_oF1
1877:             .Top         = 365
1878:             .Left        = 27
1879:             .Width       = 945
1880:             .Height      = 37
1881:             .BackStyle   = 0
1882:             .SpecialEffect = 2
1883:             .BackColor   = RGB(255, 255, 255)
1884:             .Visible     = .T.
1885:         ENDWITH
1886:         THIS.ConfigurarFormulaDesconto(loc_oF1, "t1s", "Primeira F" + CHR(243) + "rmula :")
1887: 
1888:         loc_oCnt.AddObject("cnt_4c_Formula2", "Container")
1889:         loc_oF2 = loc_oCnt.cnt_4c_Formula2
1890:         WITH loc_oF2
1891:             .Top         = 415
1892:             .Left        = 27
1893:             .Width       = 945
1894:             .Height      = 37
1895:             .BackStyle   = 0
1896:             .SpecialEffect = 2
1897:             .BackColor   = RGB(255, 255, 255)
1898:             .Visible     = .T.
1899:         ENDWITH
1900:         THIS.ConfigurarFormulaDesconto(loc_oF2, "t2s", "Segunda F" + CHR(243) + "rmula :")
1901: 
1902:         *----------------------------------------------------------------------
1903:         * Desconto Maximo (crSigOpTdz.descmxs - registro principal, NAO a
1904:         * linha corrente de composicao) - this_nDescontoMaximo no BO
1905:         *----------------------------------------------------------------------
1906:         loc_oCnt.AddObject("lbl_4c_DescontoMaximo", "Label")
1907:         WITH loc_oCnt.lbl_4c_DescontoMaximo
1908:             .Caption   = "Desconto M" + CHR(225) + "ximo :"

*-- Linhas 1994 a 2131:
1994:             .Header1.FontSize  = 8
1995:             .Text1.ForeColor   = RGB(0, 0, 0)
1996:         ENDWITH
1997:         BINDEVENT(loc_oGradec.Column1.Text1, "Valid", THIS, "GradecColumn1Valid")
1998: 
1999:         WITH loc_oGradec.Column2
2000:             .Width             = 100
2001:             .Header1.Caption   = "Conta"
2002:             .Header1.Alignment = 2
2003:             .Header1.FontName  = "Verdana"
2004:             .Header1.FontSize  = 8
2005:             .InputMask         = "XXXXXXXXXX"
2006:             .Text1.InputMask   = "XXXXXXXXXX"
2007:             .Text1.ForeColor   = RGB(0, 0, 0)
2008:         ENDWITH
2009:         BINDEVENT(loc_oGradec.Column2.Text1, "Valid", THIS, "GradecColumn2Valid")
2010: 
2011:         WITH loc_oGradec.Column3
2012:             .Width             = 55
2013:             .Header1.Caption   = "Integral"
2014:             .Header1.Alignment = 2
2015:             .Header1.FontName  = "Verdana"
2016:             .Header1.FontSize  = 8
2017:             .InputMask         = "999.99"
2018:             .Text1.InputMask   = "999.99"
2019:             .Text1.ForeColor   = RGB(0, 0, 0)
2020:         ENDWITH
2021: 
2022:         WITH loc_oGradec.Column4
2023:             .Width             = 55
2024:             .Header1.Caption   = "Dividida"
2025:             .Header1.Alignment = 2
2026:             .Header1.FontName  = "Verdana"
2027:             .Header1.FontSize  = 8
2028:             .InputMask         = "999.99"
2029:             .Text1.InputMask   = "999.99"
2030:             .Text1.ForeColor   = RGB(0, 0, 0)
2031:         ENDWITH
2032: 
2033:         WITH loc_oGradec.Column5
2034:             .Width             = 55
2035:             .Header1.Caption   = "Atendim"
2036:             .Header1.Alignment = 2
2037:             .Header1.FontName  = "Verdana"
2038:             .Header1.FontSize  = 8
2039:             .InputMask         = "999.99"
2040:             .Text1.InputMask   = "999.99"
2041:             .Text1.ForeColor   = RGB(0, 0, 0)
2042:         ENDWITH
2043: 
2044:         WITH loc_oGradec.Column6
2045:             .Width             = 30
2046:             .Header1.Caption   = "Moe"
2047:             .Header1.Alignment = 2
2048:             .Header1.FontName  = "Verdana"
2049:             .Header1.FontSize  = 8
2050:             .Text1.ForeColor   = RGB(0, 0, 0)
2051:             .Text1.BackColor   = RGB(255, 255, 255)
2052:         ENDWITH
2053: 
2054:         *----------------------------------------------------------------------
2055:         * Inscomis/exccomis - incluem/removem comissoes (cursor_4c_Tdi)
2056:         *----------------------------------------------------------------------
2057:         loc_oCnt.AddObject("cmd_4c_InserirComissao", "CommandButton")
2058:         WITH loc_oCnt.cmd_4c_InserirComissao
2059:             .Caption   = ""
2060:             .Picture   = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2061:             .Top       = 296
2062:             .Left      = 577
2063:             .Width     = 40
2064:             .Height    = 40
2065:             .BackColor = RGB(255, 255, 255)
2066:             .ForeColor = RGB(36, 84, 155)
2067:             .FontName  = "Verdana"
2068:             .FontSize  = 8
2069:             .FontBold  = .T.
2070:             .Themes    = .F.
2071:             .Visible   = .T.
2072:         ENDWITH
2073:         BINDEVENT(loc_oCnt.cmd_4c_InserirComissao, "Click", THIS, "BtnInserirComissaoClick")
2074: 
2075:         loc_oCnt.AddObject("cmd_4c_ExcluirComissao", "CommandButton")
2076:         WITH loc_oCnt.cmd_4c_ExcluirComissao
2077:             .Caption   = ""
2078:             .Picture   = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2079:             .Top       = 296
2080:             .Left      = 617
2081:             .Width     = 40
2082:             .Height    = 40
2083:             .BackColor = RGB(255, 255, 255)
2084:             .ForeColor = RGB(36, 84, 155)
2085:             .FontName  = "Verdana"
2086:             .FontSize  = 8
2087:             .FontBold  = .T.
2088:             .Themes    = .F.
2089:             .Visible   = .T.
2090:         ENDWITH
2091:         BINDEVENT(loc_oCnt.cmd_4c_ExcluirComissao, "Click", THIS, "BtnExcluirComissaoClick")
2092: 
2093:         *----------------------------------------------------------------------
2094:         * Combo_Comis / getDescFats / getFatorPads / chkAplicado(Ignora
2095:         * cotacao) - bindados a cursor_4c_Tdt.* (linha corrente de composicao)
2096:         *----------------------------------------------------------------------
2097:         loc_oCnt.AddObject("lbl_4c_Comissao", "Label")
2098:         WITH loc_oCnt.lbl_4c_Comissao
2099:             .Caption   = "Comiss" + CHR(227) + "o:"
2100:             .Top       = 342
2101:             .Left      = 555
2102:             .Width     = 59
2103:             .Height    = 15
2104:             .BackStyle = 0
2105:             .FontName  = "Tahoma"
2106:             .FontSize  = 8
2107:             .FontBold  = .T.
2108:             .ForeColor = RGB(90, 90, 90)
2109:             .Visible   = .T.
2110:         ENDWITH
2111: 
2112:         loc_oCnt.AddObject("cbo_4c_ComboComis", "ComboBox")
2113:         WITH loc_oCnt.cbo_4c_ComboComis
2114:             .Top            = 338
2115:             .Left           = 617
2116:             .Width          = 161
2117:             .Height         = 23
2118:             .Style          = 2
2119:             .RowSourceType  = 1
2120:             .RowSource      = "Normal,Pelo Custo,Pelo Feitio"
2121:             .ControlSource  = "cursor_4c_Tdt.tpcomis"
2122:             .FontName       = "Tahoma"
2123:             .FontSize       = 8
2124:             .Visible        = .T.
2125:         ENDWITH
2126: 
2127:         loc_oCnt.AddObject("lbl_4c_DescritivoFator", "Label")
2128:         WITH loc_oCnt.lbl_4c_DescritivoFator
2129:             .Caption   = "Descritivo de Fator :"
2130:             .Top       = 342
2131:             .Left      = 20

*-- Linhas 2199 a 2254:
2199:             .Visible       = .T.
2200:         ENDWITH
2201: 
2202:         THIS.TornarControlesVisiveis(loc_oCnt)
2203:     ENDPROC
2204: 
2205:     *--------------------------------------------------------------------------
2206:     * ConfigurarFormulaDesconto - Cria os controles de uma formula (1a/2a)
2207:     * dentro do container informado, bindados a cursor_4c_Tdt.*<sufixo>
2208:     * (sufixo "t1s" ou "t2s"). Espelha o container F?rmula1/F?rmula2 do
2209:     * legado: Campo1/Oper1/Campo2/Oper2/Campo3/Const1/Const2/Const3/Moeda.
2210:     * Visible dos campos 2/3 (encadeados) e recalculado dinamicamente pelo
2211:     * legado via Refresh(); aqui simplificado para SEMPRE visivel (o
2212:     * usuario ve os 3 campos da formula e preenche os que precisar).
2213:     *--------------------------------------------------------------------------
2214:     PROTECTED PROCEDURE ConfigurarFormulaDesconto(par_oCnt, par_cSufixo, par_cLabel)
2215:         WITH par_oCnt
2216:             .AddObject("lbl_4c_TituloFormula", "Label")
2217:             WITH .lbl_4c_TituloFormula
2218:                 .Caption   = par_cLabel
2219:                 .Top       = 12
2220:                 .Left      = 14
2221:                 .Width     = 106
2222:                 .Height    = 15
2223:                 .BackStyle = 0
2224:                 .FontName  = "Tahoma"
2225:                 .FontSize  = 8
2226:                 .FontBold  = .T.
2227:                 .ForeColor = RGB(90, 90, 90)
2228:                 .Visible   = .T.
2229:             ENDWITH
2230: 
2231:             .AddObject("cbo_4c_Campo1", "ComboBox")
2232:             WITH .cbo_4c_Campo1
2233:                 .Top           = 7
2234:                 .Left          = 145
2235:                 .Width         = 127
2236:                 .Height        = 24
2237:                 .Style         = 2
2238:                 .SpecialEffect = 1
2239:                 .RowSourceType = 1
2240:                 .RowSource     = "Nenhum,Peso,Fator,Pre" + CHR(231) + "o,Constante,Quantidade,Comprimento"
2241:                 .ControlSource = "cursor_4c_Tdt.campo1" + par_cSufixo
2242:                 .BackColor     = RGB(220, 211, 194)
2243:                 .FontName      = "Tahoma"
2244:                 .FontSize      = 8
2245:                 .Visible       = .T.
2246:             ENDWITH
2247: 
2248:             .AddObject("cbo_4c_Oper1", "ComboBox")
2249:             WITH .cbo_4c_Oper1
2250:                 .Top           = 7
2251:                 .Left          = 283
2252:                 .Width         = 39
2253:                 .Height        = 24
2254:                 .Style         = 2

*-- Linhas 2391 a 2511:
2391:     *--------------------------------------------------------------------------
2392:     * FormParaBO - Transfere dados do Form para Business Object
2393:     *--------------------------------------------------------------------------
2394:     PROCEDURE FormParaBO()
2395:         LOCAL loc_oPg
2396: 
2397:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2398: 
2399:         WITH THIS.this_oBusinessObject
2400:             .this_cCodigo         = ALLTRIM(loc_oPg.txt_4c__codigos.Value)
2401:             .this_cDescricao      = ALLTRIM(loc_oPg.txt_4c__descrs.Value)
2402:             .this_cMoeRef         = ALLTRIM(loc_oPg.txt_4c__moerefs.Value)
2403:             .this_nDesconto       = loc_oPg.txt_4c__descos.Value
2404:             .this_cObservacao     = ALLTRIM(loc_oPg.txt_4c__obss.Value)
2405:             .this_nRelDesconto    = loc_oPg.obj_4c_Opt_rel_descs.Value
2406:             .this_dDataTermino    = loc_oPg.txt_4c_Dtval.Value
2407:             .this_nPrazoMedio     = loc_oPg.txt_4c_PrazoMs.Value
2408:             .this_nChkAcesso      = loc_oPg.obj_4c_Chk_Acesso.Value
2409:             .this_nChkRetorno     = IIF(loc_oPg.chk_4c_ChkAplicado.Value = 1, 1, 0)
2410:             .this_nAjuste         = loc_oPg.txt_4c_Ajuste.Value
2411:             .this_nFator          = loc_oPg.txt_4c_Fator.Value
2412:             .this_cMoedaFator     = ALLTRIM(loc_oPg.txt_4c_MoeFat.Value)
2413:             .this_nAbateCusto     = loc_oPg.obj_4c_OptAbateCus.Value
2414:             .this_nAgrupaComissao = loc_oPg.obj_4c_Opt_agrucoms.Value
2415:             .this_nParcelas       = loc_oPg.txt_4c_NParcs.Value
2416:             .this_nParcelas2      = loc_oPg.txt_4c_NParc2s.Value
2417:             .this_nTipoDesconto   = loc_oPg.cbo_4c_CmbTpDesc.Value
2418:             .this_cListaEmpresas  = THIS.MontarListaEmpresas()
2419:             .this_nDescontoMaximo = loc_oPg.cnt_4c_PgDesconto.txt_4c_DescontoMaximo.Value
2420:         ENDWITH
2421:     ENDPROC
2422: 
2423:     *--------------------------------------------------------------------------
2424:     * BOParaForm - Transfere dados do Business Object para Form
2425:     *--------------------------------------------------------------------------
2426:     PROCEDURE BOParaForm()
2427:         LOCAL loc_oPg
2428: 
2429:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2430: 
2431:         WITH THIS.this_oBusinessObject
2432:             loc_oPg.txt_4c__codigos.Value       = .this_cCodigo
2433:             loc_oPg.txt_4c__descrs.Value        = .this_cDescricao
2434:             loc_oPg.txt_4c__moerefs.Value       = .this_cMoeRef
2435:             loc_oPg.txt_4c__moerefs_desc.Value  = THIS.this_oBusinessObject.ObterDescricaoMoeda(.this_cMoeRef)
2436:             loc_oPg.txt_4c__descos.Value        = .this_nDesconto
2437:             loc_oPg.txt_4c__obss.Value          = .this_cObservacao
2438:             *-- Legado forca Rel_Descs=2 (Nao) em registro novo (INSERIR/PROCURAR)
2439:             loc_oPg.obj_4c_Opt_rel_descs.Value  = IIF(.this_nRelDesconto = 0, 2, .this_nRelDesconto)
2440:             loc_oPg.txt_4c_Dtval.Value          = .this_dDataTermino
2441:             loc_oPg.txt_4c_PrazoMs.Value        = .this_nPrazoMedio
2442:             loc_oPg.obj_4c_Chk_Acesso.Value     = .this_nChkAcesso
2443:             loc_oPg.chk_4c_ChkAplicado.Value    = (.this_nChkRetorno .Value    = IIF(.this_nChkRetorno = 1, 1, 0))
2444:             loc_oPg.txt_4c_Ajuste.Value         = .this_nAjuste
2445:             loc_oPg.txt_4c_Fator.Value          = .this_nFator
2446:             loc_oPg.txt_4c_MoeFat.Value         = .this_cMoedaFator
2447:             loc_oPg.obj_4c_OptAbateCus.Value    = IIF(.this_nAbateCusto = 0, 2, .this_nAbateCusto)
2448:             loc_oPg.obj_4c_Opt_agrucoms.Value   = IIF(.this_nAgrupaComissao = 0, 1, .this_nAgrupaComissao)
2449:             loc_oPg.txt_4c_NParcs.Value         = .this_nParcelas
2450:             loc_oPg.txt_4c_NParc2s.Value        = .this_nParcelas2
2451:             loc_oPg.cbo_4c_CmbTpDesc.Value      = .this_nTipoDesconto
2452:             loc_oPg.cnt_4c_PgDesconto.txt_4c_DescontoMaximo.Value = .this_nDescontoMaximo
2453:         ENDWITH
2454: 
2455:         THIS.CarregarGradeEmpresas()
2456: 
2457:         *-- Container de empresas so aparece para o tipo de desconto 11
2458:         *-- (Desconto Gerente-Extra/loja), igual ao legado
2459:         loc_oPg.cnt_4c_Container1.Visible = (loc_oPg.cbo_4c_CmbTpDesc.Value = 11)
2460: 
2461:         *-- Pagina "Configuracao de Desconto" (grades de composicao/faixas)
2462:         THIS.CarregarConfiguracaoDesconto()
2463:     ENDPROC
2464: 
2465:     *--------------------------------------------------------------------------
2466:     * LimparCampos - Limpa todos os campos da Page2 para novo registro
2467:     *--------------------------------------------------------------------------
2468:     PROTECTED PROCEDURE LimparCampos()
2469:         LOCAL loc_oPg2
2470:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2471: 
2472:         TRY
2473:             loc_oPg2.txt_4c__codigos.Value      = ""
2474:             loc_oPg2.txt_4c__descrs.Value       = ""
2475:             loc_oPg2.txt_4c__moerefs.Value      = ""
2476:             loc_oPg2.txt_4c__moerefs_desc.Value = ""
2477:             loc_oPg2.txt_4c__descos.Value       = 0
2478:             loc_oPg2.txt_4c__obss.Value         = ""
2479:             *-- Legado forca Rel_Descs=2 (Nao) em registro novo (INSERIR/PROCURAR)
2480:             loc_oPg2.obj_4c_Opt_rel_descs.Value = 2
2481:             loc_oPg2.txt_4c_Dtval.Value         = {}
2482:             loc_oPg2.txt_4c_PrazoMs.Value       = 0
2483:             loc_oPg2.obj_4c_Chk_Acesso.Value    = 1
2484:             loc_oPg2.chk_4c_ChkAplicado.Value   = 0
2485:             loc_oPg2.txt_4c_Ajuste.Value        = 0
2486:             loc_oPg2.txt_4c_Fator.Value         = 0
2487:             loc_oPg2.txt_4c_MoeFat.Value        = ""
2488:             loc_oPg2.obj_4c_OptAbateCus.Value   = 2
2489:             loc_oPg2.obj_4c_Opt_agrucoms.Value  = 1
2490:             loc_oPg2.txt_4c_NParcs.Value        = 0
2491:             loc_oPg2.txt_4c_NParc2s.Value       = 0
2492:             loc_oPg2.cbo_4c_CmbTpDesc.Value     = 0
2493:             loc_oPg2.cnt_4c_PgDesconto.txt_4c_DescontoMaximo.Value = 0
2494: 
2495:             *-- Container de empresas: comeca oculto ate o usuario escolher tipo 11
2496:             loc_oPg2.cnt_4c_Container1.Visible  = .F.
2497:             IF USED("cursor_4c_Empresas")
2498:                 SELECT cursor_4c_Empresas
2499:                 REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
2500:                 GO TOP IN cursor_4c_Empresas
2501:             ENDIF
2502: 
2503:             *-- Registro novo (INCLUIR) ainda nao tem composicao/comissoes/
2504:             *-- faixas de desconto cadastradas
2505:             IF USED("cursor_4c_Tdt")
2506:                 USE IN cursor_4c_Tdt
2507:             ENDIF
2508:             IF USED("cursor_4c_Tdi")
2509:                 USE IN cursor_4c_Tdi
2510:             ENDIF
2511:             IF USED("cursor_4c_Tds")

*-- Linhas 2520 a 2574:
2520:     *--------------------------------------------------------------------------
2521:     * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
2522:     *--------------------------------------------------------------------------
2523:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2524:         LOCAL loc_oPg2, loc_lCodHabilitar
2525:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2526: 
2527:         TRY
2528:             *-- Codigo (PK): editavel apenas em INCLUIR ou BUSCAR
2529:             loc_lCodHabilitar = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
2530:             loc_oPg2.txt_4c__codigos.Enabled = loc_lCodHabilitar
2531: 
2532:             loc_oPg2.txt_4c__descrs.Enabled       = par_lHabilitar
2533:             loc_oPg2.txt_4c__moerefs.Enabled      = par_lHabilitar
2534:             loc_oPg2.txt_4c__descos.Enabled       = par_lHabilitar
2535:             loc_oPg2.txt_4c__obss.Enabled         = par_lHabilitar
2536:             loc_oPg2.obj_4c_Opt_rel_descs.Enabled = par_lHabilitar
2537:             loc_oPg2.txt_4c_Dtval.Enabled         = par_lHabilitar
2538:             loc_oPg2.obj_4c_Chk_Acesso.Enabled    = par_lHabilitar
2539:             loc_oPg2.chk_4c_ChkAplicado.Enabled   = par_lHabilitar
2540:             loc_oPg2.txt_4c_Ajuste.Enabled        = par_lHabilitar
2541:             loc_oPg2.txt_4c_Fator.Enabled         = par_lHabilitar
2542:             loc_oPg2.txt_4c_MoeFat.Enabled        = par_lHabilitar
2543:             loc_oPg2.obj_4c_OptAbateCus.Enabled   = par_lHabilitar
2544:             loc_oPg2.obj_4c_Opt_agrucoms.Enabled  = par_lHabilitar
2545:             loc_oPg2.txt_4c_NParcs.Enabled        = par_lHabilitar
2546:             loc_oPg2.txt_4c_NParc2s.Enabled       = par_lHabilitar
2547:             loc_oPg2.cbo_4c_CmbTpDesc.Enabled     = par_lHabilitar
2548: 
2549:             *-- Grade de empresas (tipo de desconto 11): ReadOnly nos modos nao-edicao
2550:             loc_oPg2.cnt_4c_Container1.grd_4c_Empresas.ReadOnly = !par_lHabilitar
2551: 
2552:             *-- Pagina "Descontos / Comissoes"
2553:             WITH loc_oPg2.cnt_4c_PgDesconto
2554:                 .txt_4c_DescontoMaximo.Enabled  = par_lHabilitar
2555:                 .grd_4c_Gradei.ReadOnly         = !par_lHabilitar
2556:                 .grd_4c_Gradec.ReadOnly         = !par_lHabilitar
2557:                 .cmd_4c_InserirComposicao.Enabled = par_lHabilitar
2558:                 .cmd_4c_ExcluirComposicao.Enabled = par_lHabilitar
2559:                 .cmd_4c_InserirComissao.Enabled   = par_lHabilitar
2560:                 .cmd_4c_ExcluirComissao.Enabled   = par_lHabilitar
2561:                 .cbo_4c_ComboComis.Enabled      = par_lHabilitar
2562:                 .txt_4c_DescFats.Enabled        = par_lHabilitar
2563:                 .txt_4c_FatorPads.Enabled       = par_lHabilitar
2564:                 .chk_4c_IgnoraCotacao.Enabled   = par_lHabilitar
2565:                 .cnt_4c_Formula1.cbo_4c_Campo1.Enabled = par_lHabilitar
2566:                 .cnt_4c_Formula1.cbo_4c_Oper1.Enabled  = par_lHabilitar
2567:                 .cnt_4c_Formula1.txt_4c_Const1.Enabled = par_lHabilitar
2568:                 .cnt_4c_Formula1.cbo_4c_Campo2.Enabled = par_lHabilitar
2569:                 .cnt_4c_Formula1.cbo_4c_Oper2.Enabled  = par_lHabilitar
2570:                 .cnt_4c_Formula1.txt_4c_Const2.Enabled = par_lHabilitar
2571:                 .cnt_4c_Formula1.cbo_4c_Campo3.Enabled = par_lHabilitar
2572:                 .cnt_4c_Formula1.txt_4c_Const3.Enabled = par_lHabilitar
2573:                 .cnt_4c_Formula1.txt_4c_Moeda.Enabled  = par_lHabilitar
2574:                 .cnt_4c_Formula2.cbo_4c_Campo1.Enabled = par_lHabilitar

*-- Linhas 2591 a 3252:
2591:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
2592:     * PUBLIC: chamado a partir dos eventos Btn*Click
2593:     *--------------------------------------------------------------------------
2594:     PROCEDURE AjustarBotoesPorModo()
2595:         LOCAL loc_oBotoesAcao
2596:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2597: 
2598:         TRY
2599:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
2600:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2601:         CATCH TO loException
2602:             MostrarErro(loException, "FormTbv.AjustarBotoesPorModo")
2603:         ENDTRY
2604:     ENDPROC
2605: 
2606:     *--------------------------------------------------------------------------
2607:     * BtnIncluirClick - Prepara Page2 para inclusao de nova tabela de desconto
2608:     * PUBLIC: BINDEVENT requer metodo publico
2609:     *--------------------------------------------------------------------------
2610:     PROCEDURE BtnIncluirClick()
2611:         LOCAL loc_lResultado
2612:         loc_lResultado = .F.
2613: 
2614:         TRY
2615:             THIS.this_oBusinessObject.NovoRegistro()
2616:             THIS.LimparCampos()
2617:             THIS.this_cModoAtual = "INCLUIR"
2618:             THIS.HabilitarCampos(.T.)
2619:             THIS.AjustarBotoesPorModo()
2620:             THIS.CarregarGradeEmpresas()
2621:             THIS.AlternarPagina(2)
2622:             loc_lResultado = .T.
2623:         CATCH TO loException
2624:             MostrarErro(loException, "FormTbv.BtnIncluirClick")
2625:             loc_lResultado = .F.
2626:         ENDTRY
2627: 
2628:         RETURN loc_lResultado
2629:     ENDPROC
2630: 
2631:     *--------------------------------------------------------------------------
2632:     * BtnVisualizarClick - Abre a tabela de desconto selecionada em modo
2633:     * somente leitura
2634:     * PUBLIC: BINDEVENT requer metodo publico
2635:     *--------------------------------------------------------------------------
2636:     PROCEDURE BtnVisualizarClick()
2637:         LOCAL loc_cCodigo, loc_lResultado
2638:         loc_lResultado = .F.
2639: 
2640:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2641:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
2642:             RETURN loc_lResultado
2643:         ENDIF
2644: 
2645:         SELECT cursor_4c_Dados
2646:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
2647: 
2648:         TRY
2649:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2650:                 THIS.BOParaForm()
2651:                 THIS.this_cModoAtual = "VISUALIZAR"
2652:                 THIS.HabilitarCampos(.F.)
2653:                 THIS.AjustarBotoesPorModo()
2654:                 THIS.AlternarPagina(2)
2655:                 loc_lResultado = .T.
2656:             ENDIF
2657:         CATCH TO loException
2658:             MostrarErro(loException, "FormTbv.BtnVisualizarClick")
2659:             loc_lResultado = .F.
2660:         ENDTRY
2661: 
2662:         RETURN loc_lResultado
2663:     ENDPROC
2664: 
2665:     *--------------------------------------------------------------------------
2666:     * BtnAlterarClick - Abre a tabela de desconto selecionada para edicao
2667:     * PUBLIC: BINDEVENT requer metodo publico
2668:     *--------------------------------------------------------------------------
2669:     PROCEDURE BtnAlterarClick()
2670:         LOCAL loc_cCodigo, loc_lResultado
2671:         loc_lResultado = .F.
2672: 
2673:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2674:             MsgAviso("Nenhum registro selecionado.", "Alterar")
2675:             RETURN loc_lResultado
2676:         ENDIF
2677: 
2678:         SELECT cursor_4c_Dados
2679:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
2680: 
2681:         TRY
2682:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2683:                 THIS.this_oBusinessObject.EditarRegistro()
2684:                 THIS.BOParaForm()
2685:                 THIS.this_cModoAtual = "ALTERAR"
2686:                 THIS.HabilitarCampos(.T.)
2687:                 THIS.AjustarBotoesPorModo()
2688:                 THIS.AlternarPagina(2)
2689:                 loc_lResultado = .T.
2690:             ENDIF
2691:         CATCH TO loException
2692:             MostrarErro(loException, "FormTbv.BtnAlterarClick")
2693:             loc_lResultado = .F.
2694:         ENDTRY
2695: 
2696:         RETURN loc_lResultado
2697:     ENDPROC
2698: 
2699:     *--------------------------------------------------------------------------
2700:     * BtnExcluirClick - Exclui a tabela de desconto selecionada apos
2701:     * confirmacao (remove tambem SigOpTdt/SigOpTdi/SigOpTds relacionadas)
2702:     * PUBLIC: BINDEVENT requer metodo publico
2703:     *--------------------------------------------------------------------------
2704:     PROCEDURE BtnExcluirClick()
2705:         LOCAL loc_cCodigo, loc_lResultado
2706:         loc_lResultado = .F.
2707: 
2708:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2709:             MsgAviso("Nenhum registro selecionado.", "Excluir")
2710:             RETURN loc_lResultado
2711:         ENDIF
2712: 
2713:         SELECT cursor_4c_Dados
2714:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
2715: 
2716:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2717:             RETURN loc_lResultado
2718:         ENDIF
2719: 
2720:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da tabela de desconto " + loc_cCodigo + "?", "Excluir")
2721:             RETURN loc_lResultado
2722:         ENDIF
2723: 
2724:         TRY
2725:             IF THIS.this_oBusinessObject.Excluir()
2726:                 MsgInfo("Tabela de desconto exclu" + CHR(237) + "da com sucesso!")
2727:                 THIS.CarregarLista()
2728:                 loc_lResultado = .T.
2729:             ELSE
2730:                 MsgErro(THIS.this_oBusinessObject.ObterMensagemErro(), "Erro ao Excluir")
2731:             ENDIF
2732:         CATCH TO loException
2733:             MostrarErro(loException, "FormTbv.BtnExcluirClick")
2734:             loc_lResultado = .F.
2735:         ENDTRY
2736: 
2737:         RETURN loc_lResultado
2738:     ENDPROC
2739: 
2740:     *--------------------------------------------------------------------------
2741:     * BtnBuscarClick - Prepara Page2 em modo BUSCAR (localizar registro ja
2742:     * carregado na lista por codigo ou descricao), reproduzindo o Busca=1/
2743:     * Busca=2 do legado (Select CrSigOpTdz / Seek por Codigos ou Descrs)
2744:     * PUBLIC: BINDEVENT requer metodo publico
2745:     *--------------------------------------------------------------------------
2746:     PROCEDURE BtnBuscarClick()
2747:         LOCAL loc_lResultado
2748:         loc_lResultado = .F.
2749: 
2750:         TRY
2751:             THIS.this_oBusinessObject.NovoRegistro()
2752:             THIS.LimparCampos()
2753:             THIS.this_cModoAtual = "BUSCAR"
2754:             THIS.HabilitarCampos(.T.)
2755:             THIS.AjustarBotoesPorModo()
2756:             THIS.AlternarPagina(2)
2757:             loc_lResultado = .T.
2758:         CATCH TO loException
2759:             MostrarErro(loException, "FormTbv.BtnBuscarClick")
2760:             loc_lResultado = .F.
2761:         ENDTRY
2762: 
2763:         RETURN loc_lResultado
2764:     ENDPROC
2765: 
2766:     *--------------------------------------------------------------------------
2767:     * BtnEncerrarClick - Fecha o formulario
2768:     * PUBLIC: BINDEVENT requer metodo publico
2769:     *--------------------------------------------------------------------------
2770:     PROCEDURE BtnEncerrarClick()
2771:         THIS.Release()
2772:     ENDPROC
2773: 
2774:     *--------------------------------------------------------------------------
2775:     * BtnConfirmarClick - Modo BUSCAR: localiza o registro na lista pelo
2776:     * codigo ou pela descricao informados. Modo INCLUIR/ALTERAR: valida
2777:     * codigo/descricao obrigatorios (legado: "Codigo Invalido !!!" /
2778:     * descricao obrigatoria), checa duplicidade de codigo em INCLUIR
2779:     * (legado: "Codigo ja cadastrado !!!") e grava via Salvar()
2780:     * PUBLIC: BINDEVENT requer metodo publico
2781:     *--------------------------------------------------------------------------
2782:     PROCEDURE BtnConfirmarClick()
2783:         LOCAL loc_oPg2, loc_cCodBusca, loc_cDescBusca, loc_lResultado
2784:         loc_lResultado = .F.
2785: 
2786:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2787: 
2788:         *-- Validacoes antes do TRY (RETURN valido fora de TRY/CATCH)
2789:         IF THIS.this_cModoAtual != "BUSCAR" AND EMPTY(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
2790:             MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido !!!", "")
2791:             loc_oPg2.txt_4c__codigos.SetFocus
2792:             RETURN .F.
2793:         ENDIF
2794: 
2795:         IF THIS.this_cModoAtual != "BUSCAR" AND EMPTY(ALLTRIM(loc_oPg2.txt_4c__descrs.Value))
2796:             MsgAviso("A descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria.", "")
2797:             loc_oPg2.txt_4c__descrs.SetFocus
2798:             RETURN .F.
2799:         ENDIF
2800: 
2801:         TRY
2802:             IF THIS.this_cModoAtual = "BUSCAR"
2803:                 loc_cCodBusca  = ALLTRIM(loc_oPg2.txt_4c__codigos.Value)
2804:                 loc_cDescBusca = ALLTRIM(loc_oPg2.txt_4c__descrs.Value)
2805:                 THIS.this_cModoAtual = "LISTA"
2806:                 THIS.AlternarPagina(1)
2807:                 IF USED("cursor_4c_Dados")
2808:                     SELECT cursor_4c_Dados
2809:                     IF !EMPTY(loc_cCodBusca)
2810:                         LOCATE FOR ALLTRIM(cursor_4c_Dados.codigos) = loc_cCodBusca
2811:                     ELSE
2812:                         IF !EMPTY(loc_cDescBusca)
2813:                             LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.descrs)) = UPPER(loc_cDescBusca)
2814:                         ENDIF
2815:                     ENDIF
2816:                 ENDIF
2817:                 loc_lResultado = .T.
2818:             ELSE
2819:                 IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2820:                     IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
2821:                         MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado !!!", "")
2822:                         THIS.this_oBusinessObject.NovoRegistro()
2823:                         loc_oPg2.txt_4c__codigos.SetFocus
2824:                     ELSE
2825:                         THIS.FormParaBO()
2826:                         IF THIS.this_oBusinessObject.Salvar()
2827:                             *-- Composicao/comissoes/faixas de desconto (paginas
2828:                             *-- "Descontos / Comissoes" e "Configuracao de
2829:                             *-- Desconto") nao fazem parte do FormParaBO/Salvar
2830:                             *-- padrao (SigOpTdt/SigOpTdi/SigOpTds sao sub-tabelas)
2831:                             IF !THIS.this_oBusinessObject.SalvarComposicaoDesconto(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
2832:                                 MsgErro("Tabela de desconto salva, mas houve falha ao gravar a composi" + CHR(231) + CHR(227) + "o de desconto.", "Erro ao Salvar")
2833:                             ENDIF
2834:                             IF !THIS.this_oBusinessObject.SalvarComissoesDesconto(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
2835:                                 MsgErro("Tabela de desconto salva, mas houve falha ao gravar as comiss" + CHR(245) + "es de desconto.", "Erro ao Salvar")
2836:                             ENDIF
2837:                             IF !THIS.this_oBusinessObject.SalvarFaixasDesconto(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
2838:                                 MsgErro("Tabela de desconto salva, mas houve falha ao gravar as faixas de desconto.", "Erro ao Salvar")
2839:                             ENDIF
2840:                             MsgInfo("Tabela de desconto salva com sucesso!")
2841:                             THIS.this_cModoAtual = "LISTA"
2842:                             THIS.AlternarPagina(1)
2843:                             loc_lResultado = .T.
2844:                         ELSE
2845:                             MsgErro(THIS.this_oBusinessObject.ObterMensagemErro(), "Erro ao Salvar")
2846:                         ENDIF
2847:                     ENDIF
2848:                 ENDIF
2849:             ENDIF
2850:         CATCH TO loException
2851:             MostrarErro(loException, "FormTbv.BtnConfirmarClick")
2852:             loc_lResultado = .F.
2853:         ENDTRY
2854: 
2855:         RETURN loc_lResultado
2856:     ENDPROC
2857: 
2858:     *--------------------------------------------------------------------------
2859:     * BtnSalvarClick - Alias canonico para BtnConfirmarClick
2860:     * PUBLIC: BINDEVENT requer metodo publico
2861:     *--------------------------------------------------------------------------
2862:     PROCEDURE BtnSalvarClick()
2863:         RETURN THIS.BtnConfirmarClick()
2864:     ENDPROC
2865: 
2866:     *--------------------------------------------------------------------------
2867:     * BtnCancelarClick - Cancela (BUSCAR/INCLUIR/ALTERAR) e volta para a lista
2868:     * PUBLIC: BINDEVENT requer metodo publico
2869:     *--------------------------------------------------------------------------
2870:     PROCEDURE BtnCancelarClick()
2871:         TRY
2872:             THIS.this_cModoAtual = "LISTA"
2873:             THIS.AlternarPagina(1)
2874:         CATCH TO loException
2875:             MostrarErro(loException, "FormTbv.BtnCancelarClick")
2876:         ENDTRY
2877:     ENDPROC
2878: 
2879:     *--------------------------------------------------------------------------
2880:     * CriarCursorTipoDesconto - Cria cursor local (lista fixa) para cbo_4c_CmbTpDesc
2881:     * Legado: Create Cursor crTpDesc (Descrs c(40), ordem N(2,0)) no Init()
2882:     *--------------------------------------------------------------------------
2883:     PROTECTED PROCEDURE CriarCursorTipoDesconto()
2884:         IF USED("cursor_4c_TipoDesconto")
2885:             RETURN
2886:         ENDIF
2887: 
2888:         SET NULL ON
2889:         CREATE CURSOR cursor_4c_TipoDesconto (Descrs C(40), Ordem N(2, 0))
2890:         SET NULL OFF
2891:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("1-Anivers" + CHR(225) + "rio", 1)
2892:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("2-Desconto Vendedor", 2)
2893:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("3-Desconto Gerente-Grupo", 3)
2894:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("4-Desconto Gerente-Lancamento", 4)
2895:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("5-Desconto Gerente-qq pe" + CHR(231) + "a", 5)
2896:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("6-Troca Zerada", 6)
2897:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("7-Troca Upgrade", 7)
2898:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("8-Desconto Supervisor", 8)
2899:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("9-Desconto Diretoria", 9)
2900:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("10-Troca Up Alianca", 10)
2901:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("11-Desconto Gerente-Extra/loja", 11)
2902:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("12-Desconto Gerente-Brinde", 12)
2903:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("13-Desconto Gerente-Troca de pre" + CHR(231) + "o", 13)
2904:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES (SPACE(40), 0)
2905:         GO TOP IN cursor_4c_TipoDesconto
2906:     ENDPROC
2907: 
2908:     *--------------------------------------------------------------------------
2909:     * TipoDescontoInteractiveChange - Mostra/oculta a lista de empresas conforme
2910:     * o tipo de desconto selecionado (11 = Desconto Gerente-Extra/loja)
2911:     * PUBLIC: BINDEVENT requer metodo publico
2912:     *--------------------------------------------------------------------------
2913:     PROCEDURE TipoDescontoInteractiveChange()
2914:         LOCAL loc_oPg, loc_lMostrarEmpresas
2915: 
2916:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2917:         loc_lMostrarEmpresas = (loc_oPg.cbo_4c_CmbTpDesc.Value = 11)
2918: 
2919:         loc_oPg.cnt_4c_Container1.Visible = loc_lMostrarEmpresas
2920: 
2921:         IF !loc_lMostrarEmpresas AND USED("cursor_4c_Empresas")
2922:             SELECT cursor_4c_Empresas
2923:             REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
2924:             GO TOP IN cursor_4c_Empresas
2925:             IF PEMSTATUS(loc_oPg.cnt_4c_Container1, "grd_4c_Empresas", 5)
2926:                 loc_oPg.cnt_4c_Container1.grd_4c_Empresas.Refresh()
2927:             ENDIF
2928:         ENDIF
2929:     ENDPROC
2930: 
2931:     *--------------------------------------------------------------------------
2932:     * CarregarGradeEmpresas - Carrega grade de empresas (SigCdEmp) e marca as
2933:     * empresas presentes em this_cListaEmpresas (formato ";EMP1;EMP2;...")
2934:     *--------------------------------------------------------------------------
2935:     PROCEDURE CarregarGradeEmpresas()
2936:         LOCAL loc_lResultado, loc_oGrid, loc_cListaEmpresas
2937: 
2938:         loc_lResultado = .F.
2939: 
2940:         TRY
2941:             IF THIS.this_oBusinessObject.CarregarEmpresas()
2942:                 loc_cListaEmpresas = THIS.this_oBusinessObject.this_cListaEmpresas
2943: 
2944:                 SELECT cursor_4c_Empresas
2945:                 SCAN
2946:                     IF !EMPTY(ALLTRIM(cursor_4c_Empresas.cemps)) AND ALLTRIM(cursor_4c_Empresas.cemps) $ loc_cListaEmpresas
2947:                         REPLACE nMarca WITH 1 IN cursor_4c_Empresas
2948:                     ELSE
2949:                         REPLACE nMarca WITH 0 IN cursor_4c_Empresas
2950:                     ENDIF
2951:                 ENDSCAN
2952:                 GO TOP IN cursor_4c_Empresas
2953: 
2954:                 *-- NAO reatribuir ColumnCount aqui: destruiria o chk_4c_Marca
2955:                 *-- (AddObject em Column1) criado em ConfigurarPaginaDados (Pattern #183)
2956:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas
2957:                 loc_oGrid.RecordSource = "cursor_4c_Empresas"
2958:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Empresas.nMarca"
2959:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Empresas.cemps"
2960:                 loc_oGrid.Column1.Header1.Caption = ""
2961:                 loc_oGrid.Column2.Header1.Caption = "Empresa"
2962:                 loc_oGrid.Column1.Width  = 30
2963:                 loc_oGrid.Column2.Width  = 190
2964:                 loc_oGrid.Column1.CurrentControl = "chk_4c_Marca"
2965:                 loc_oGrid.Column2.ReadOnly = .T.
2966:                 loc_oGrid.Refresh()
2967: 
2968:                 loc_lResultado = .T.
2969:             ENDIF
2970:         CATCH TO loException
2971:             MostrarErro(loException, "FormTbv.CarregarGradeEmpresas")
2972:             loc_lResultado = .F.
2973:         ENDTRY
2974: 
2975:         RETURN loc_lResultado
2976:     ENDPROC
2977: 
2978:     *--------------------------------------------------------------------------
2979:     * MontarListaEmpresas - Le as empresas marcadas na grade e monta a string
2980:     * ";EMP1;EMP2;..." gravada em this_cListaEmpresas (listaemp)
2981:     *--------------------------------------------------------------------------
2982:     PROCEDURE MontarListaEmpresas()
2983:         LOCAL loc_cLista
2984: 
2985:         loc_cLista = ""
2986: 
2987:         IF USED("cursor_4c_Empresas")
2988:             SELECT cursor_4c_Empresas
2989:             GO TOP
2990:             SCAN
2991:                 IF cursor_4c_Empresas.nMarca = 1
2992:                     loc_cLista = loc_cLista + ";" + ALLTRIM(cursor_4c_Empresas.cemps)
2993:                 ENDIF
2994:             ENDSCAN
2995:         ENDIF
2996: 
2997:         RETURN loc_cLista
2998:     ENDPROC
2999: 
3000:     *--------------------------------------------------------------------------
3001:     * BtnEmpresasDesmarcarClick - Desmarca todas as empresas da grade
3002:     * PUBLIC: BINDEVENT requer metodo publico
3003:     *--------------------------------------------------------------------------
3004:     PROCEDURE BtnEmpresasDesmarcarClick()
3005:         IF USED("cursor_4c_Empresas")
3006:             SELECT cursor_4c_Empresas
3007:             REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
3008:             GO TOP IN cursor_4c_Empresas
3009:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3010:         ENDIF
3011:     ENDPROC
3012: 
3013:     *--------------------------------------------------------------------------
3014:     * BtnEmpresasMarcarClick - Marca todas as empresas da grade
3015:     * PUBLIC: BINDEVENT requer metodo publico
3016:     *--------------------------------------------------------------------------
3017:     PROCEDURE BtnEmpresasMarcarClick()
3018:         IF USED("cursor_4c_Empresas")
3019:             SELECT cursor_4c_Empresas
3020:             REPLACE ALL nMarca WITH 1 IN cursor_4c_Empresas
3021:             GO TOP IN cursor_4c_Empresas
3022:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3023:         ENDIF
3024:     ENDPROC
3025: 
3026:     *--------------------------------------------------------------------------
3027:     * EmpresaCheckboxMouseDown - Toggle nMarca em cursor_4c_Empresas via mouse
3028:     * Grid nao alterna CheckBox pelo binding nativo (campo numerico) - alterna
3029:     * manualmente e suprime o toggle padrao com NODEFAULT
3030:     * PUBLIC: BINDEVENT requer metodo publico
3031:     *--------------------------------------------------------------------------
3032:     PROCEDURE EmpresaCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
3033:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("cursor_4c_Empresas") AND !EOF("cursor_4c_Empresas")
3034:             SELECT cursor_4c_Empresas
3035:             REPLACE nMarca WITH IIF(cursor_4c_Empresas.nMarca = 0, 1, 0) IN cursor_4c_Empresas
3036:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1, "grd_4c_Empresas", 5)
3037:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3038:             ENDIF
3039:         ENDIF
3040:         NODEFAULT
3041:     ENDPROC
3042: 
3043:     *--------------------------------------------------------------------------
3044:     * EmpresaCheckboxMouseUp - Suprime comportamento padrao
3045:     * PUBLIC: BINDEVENT requer metodo publico
3046:     *--------------------------------------------------------------------------
3047:     PROCEDURE EmpresaCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
3048:         NODEFAULT
3049:     ENDPROC
3050: 
3051:     *--------------------------------------------------------------------------
3052:     * EmpresaCheckboxClick - Suprime toggle automatico (MouseDown ja atualizou)
3053:     * PUBLIC: BINDEVENT requer metodo publico
3054:     *--------------------------------------------------------------------------
3055:     PROCEDURE EmpresaCheckboxClick()
3056:         NODEFAULT
3057:     ENDPROC
3058: 
3059:     *--------------------------------------------------------------------------
3060:     * EmpresaCheckboxKeyPress - Toggle nMarca em cursor_4c_Empresas via teclado
3061:     * PUBLIC: BINDEVENT requer metodo publico
3062:     *--------------------------------------------------------------------------
3063:     PROCEDURE EmpresaCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3064:         IF INLIST(par_nKeyCode, 13, 32)
3065:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("cursor_4c_Empresas") AND !EOF("cursor_4c_Empresas")
3066:                 SELECT cursor_4c_Empresas
3067:                 REPLACE nMarca WITH IIF(cursor_4c_Empresas.nMarca = 0, 1, 0) IN cursor_4c_Empresas
3068:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1, "grd_4c_Empresas", 5)
3069:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3070:                 ENDIF
3071:             ENDIF
3072:             NODEFAULT
3073:         ENDIF
3074:     ENDPROC
3075: 
3076:     *--------------------------------------------------------------------------
3077:     * MoedaRefLookupKeyPress / MoedaRefLookupDblClick - F4/DblClick para
3078:     * lookup de Moeda de Referencia (SigCdMoe) em txt_4c__moerefs
3079:     * PUBLIC: BINDEVENT requer metodo publico
3080:     *--------------------------------------------------------------------------
3081:     PROCEDURE MoedaRefLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3082:         IF par_nKeyCode = 28  && F4
3083:             THIS.AbrirLookupMoedaRef()
3084:         ENDIF
3085:     ENDPROC
3086: 
3087:     PROCEDURE MoedaRefLookupDblClick()
3088:         THIS.AbrirLookupMoedaRef()
3089:     ENDPROC
3090: 
3091:     *--------------------------------------------------------------------------
3092:     * AbrirLookupMoedaRef - Busca SigCdMoe por codigo (cmoes) e preenche
3093:     * codigo + descricao da Moeda de Referencia
3094:     *--------------------------------------------------------------------------
3095:     PROCEDURE AbrirLookupMoedaRef()
3096:         LOCAL loc_oPg, loc_cValor, loc_oBusca
3097: 
3098:         loc_oPg    = THIS.pgf_4c_Paginas.Page2
3099:         loc_cValor = ALLTRIM(loc_oPg.txt_4c__moerefs.Value)
3100: 
3101:         TRY
3102:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3103:                 "SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", loc_cValor, ;
3104:                 "Buscar Moeda")
3105: 
3106:             IF VARTYPE(loc_oBusca) = "O"
3107:                 IF !loc_oBusca.this_lAchouRegistro
3108:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3109:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3110:                     loc_oBusca.Show()
3111:                 ENDIF
3112: 
3113:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
3114:                     SELECT cursor_4c_BuscaMoeda
3115:                     loc_oPg.txt_4c__moerefs.Value      = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
3116:                     loc_oPg.txt_4c__moerefs_desc.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
3117:                 ENDIF
3118: 
3119:                 loc_oBusca.Release()
3120:             ENDIF
3121:         CATCH TO loException
3122:             MostrarErro(loException, "FormTbv.AbrirLookupMoedaRef")
3123:         ENDTRY
3124: 
3125:         IF USED("cursor_4c_BuscaMoeda")
3126:             USE IN cursor_4c_BuscaMoeda
3127:         ENDIF
3128:     ENDPROC
3129: 
3130:     *--------------------------------------------------------------------------
3131:     * MoedaFatorLookupKeyPress / MoedaFatorLookupDblClick - F4/DblClick para
3132:     * lookup de Moeda do Fator (SigCdMoe) em txt_4c_MoeFat
3133:     * PUBLIC: BINDEVENT requer metodo publico
3134:     *--------------------------------------------------------------------------
3135:     PROCEDURE MoedaFatorLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3136:         IF par_nKeyCode = 28  && F4
3137:             THIS.AbrirLookupMoedaFator()
3138:         ENDIF
3139:     ENDPROC
3140: 
3141:     PROCEDURE MoedaFatorLookupDblClick()
3142:         THIS.AbrirLookupMoedaFator()
3143:     ENDPROC
3144: 
3145:     *--------------------------------------------------------------------------
3146:     * AbrirLookupMoedaFator - Busca SigCdMoe por codigo (cmoes) e preenche
3147:     * a Moeda do Fator
3148:     *--------------------------------------------------------------------------
3149:     PROCEDURE AbrirLookupMoedaFator()
3150:         LOCAL loc_oPg, loc_cValor, loc_oBusca
3151: 
3152:         loc_oPg    = THIS.pgf_4c_Paginas.Page2
3153:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_MoeFat.Value)
3154: 
3155:         TRY
3156:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3157:                 "SigCdMoe", "cursor_4c_BuscaMoedaFator", "cmoes", loc_cValor, ;
3158:                 "Buscar Moeda")
3159: 
3160:             IF VARTYPE(loc_oBusca) = "O"
3161:                 IF !loc_oBusca.this_lAchouRegistro
3162:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3163:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3164:                     loc_oBusca.Show()
3165:                 ENDIF
3166: 
3167:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedaFator")
3168:                     SELECT cursor_4c_BuscaMoedaFator
3169:                     loc_oPg.txt_4c_MoeFat.Value = ALLTRIM(cursor_4c_BuscaMoedaFator.cmoes)
3170:                 ENDIF
3171: 
3172:                 loc_oBusca.Release()
3173:             ENDIF
3174:         CATCH TO loException
3175:             MostrarErro(loException, "FormTbv.AbrirLookupMoedaFator")
3176:         ENDTRY
3177: 
3178:         IF USED("cursor_4c_BuscaMoedaFator")
3179:             USE IN cursor_4c_BuscaMoedaFator
3180:         ENDIF
3181:     ENDPROC
3182: 
3183:     *--------------------------------------------------------------------------
3184:     * CriarCursorDiaSemana - Cria cursor local (lista fixa) com os 7 dias da
3185:     * semana, usado na validacao de faixas de desconto por Dia da Semana
3186:     * Legado: Create Cursor DiaSemana (ndias n(1), Descrs c(7)) no Init()
3187:     *--------------------------------------------------------------------------
3188:     PROTECTED PROCEDURE CriarCursorDiaSemana()
3189:         IF USED("cursor_4c_DiaSemana")
3190:             RETURN
3191:         ENDIF
3192: 
3193:         SET NULL ON
3194:         CREATE CURSOR cursor_4c_DiaSemana (nDias N(1), Descrs C(7))
3195:         SET NULL OFF
3196:         INDEX ON Descrs TAG Descrs
3197:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (1, "DOMINGO")
3198:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (2, "SEGUNDA")
3199:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (3, "TERCA  ")
3200:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (4, "QUARTA ")
3201:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (5, "QUINTA ")
3202:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (6, "SEXTA  ")
3203:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (7, "SABADO ")
3204:         GO TOP IN cursor_4c_DiaSemana
3205:     ENDPROC
3206: 
3207:     *--------------------------------------------------------------------------
3208:     * CarregarConfiguracaoDesconto - Carrega grd_4c_GradeI (SigOpTdt) e
3209:     * grd_4c_GradeD (SigOpTds) do codigo corrente. Chamado por BOParaForm()
3210:     * ao entrar em ALTERAR/VISUALIZAR/EXCLUIR e por LimparCampos() (INCLUIR).
3211:     *--------------------------------------------------------------------------
3212:     PROCEDURE CarregarConfiguracaoDesconto()
3213:         LOCAL loc_oPgConf, loc_oPgDesc, loc_oGradei, loc_oGradeiDesc, loc_oGradec, loc_cCodigo
3214: 
3215:         TRY
3216:             loc_oPgConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto
3217:             loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
3218:             loc_oGradei     = loc_oPgConf.grd_4c_GradeI
3219:             loc_oGradeiDesc = loc_oPgDesc.grd_4c_Gradei
3220:             loc_oGradec     = loc_oPgDesc.grd_4c_Gradec
3221:             loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
3222: 
3223:             IF EMPTY(loc_cCodigo)
3224:                 loc_oGradei.RecordSource        = ""
3225:                 loc_oPgConf.grd_4c_GradeD.RecordSource = ""
3226:                 loc_oPgConf.grd_4c_GradeD.Enabled      = .F.
3227:                 loc_oPgConf.lbl_4c_Lb_desconto.Caption = "Tipo de Desconto"
3228:                 loc_oGradeiDesc.RecordSource    = ""
3229:                 loc_oGradec.RecordSource        = ""
3230:                 RETURN
3231:             ENDIF
3232: 
3233:             THIS.this_oBusinessObject.CarregarComposicaoDesconto(loc_cCodigo)
3234:             THIS.this_oBusinessObject.CarregarComissoesDesconto(loc_cCodigo)
3235:             THIS.this_oBusinessObject.CarregarFaixasDesconto(loc_cCodigo)
3236: 
3237:             loc_oGradei.RecordSource        = "cursor_4c_Tdt"
3238:             loc_oGradei.Column1.ControlSource = "cursor_4c_Tdt.tipos"
3239:             loc_oGradei.Column2.ControlSource = "cursor_4c_Tdt.codtips"
3240:             loc_oGradei.Column3.ControlSource = "cursor_4c_Tdt.tipods"
3241:             loc_oGradei.SetAll("DynamicBackColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(128,128,128), RGB(255,255,255))", "Column")
3242:             loc_oGradei.SetAll("DynamicForeColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(255,255,255), RGB(0,0,0))", "Column")
3243:             loc_oGradei.Refresh()
3244: 
3245:             *-- grd_4c_Gradei (pgDesconto) - MESMA cursor_4c_Tdt, colunas
3246:             *-- adicionais de valor/fator/exclui/faixa/inicial/final
3247:             loc_oGradeiDesc.RecordSource        = "cursor_4c_Tdt"
3248:             loc_oGradeiDesc.Column1.ControlSource = "cursor_4c_Tdt.tipos"
3249:             loc_oGradeiDesc.Column2.ControlSource = "cursor_4c_Tdt.codtips"
3250:             loc_oGradeiDesc.Column3.ControlSource = "cursor_4c_Tdt.descos"
3251:             loc_oGradeiDesc.Column4.ControlSource = "cursor_4c_Tdt.dfators"
3252:             loc_oGradeiDesc.Column5.ControlSource = "cursor_4c_Tdt.texclus"

*-- Linhas 3303 a 3394:
3303:     * GradeiConfAfterRowColChange - troca de linha em grd_4c_GradeI: marca a
3304:     * linha corrente (flag "regs", equivalente ao legado) e reconfigura a
3305:     * grade de faixas (grd_4c_GradeD) para a nova combinacao Tipo/Codigo
3306:     * PUBLIC: BINDEVENT requer metodo publico + parametro do evento
3307:     *--------------------------------------------------------------------------
3308:     PROCEDURE GradeiConfAfterRowColChange(par_nColIndex)
3309:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3310:             RETURN
3311:         ENDIF
3312: 
3313:         SELECT cursor_4c_Tdt
3314:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3315:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3316: 
3317:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3318:         THIS.MontarConfiguracaoDesconto()
3319:     ENDPROC
3320: 
3321:     *--------------------------------------------------------------------------
3322:     * GradeiConfColumn3When - habilita edicao da coluna "Tipos Desconto"
3323:     * apenas em INCLUIR/ALTERAR (equivalente ao When original)
3324:     * PUBLIC: BINDEVENT requer metodo publico
3325:     *--------------------------------------------------------------------------
3326:     PROCEDURE GradeiConfColumn3When()
3327:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3328:     ENDPROC
3329: 
3330:     *--------------------------------------------------------------------------
3331:     * GradeiConfColumn3Valid / GradeiConfColumn3LostFocus - reconfigura a
3332:     * grade de faixas ao mudar o tipo de desconto progressivo da linha
3333:     * PUBLIC: BINDEVENT requer metodo publico
3334:     *--------------------------------------------------------------------------
3335:     PROCEDURE GradeiConfColumn3Valid()
3336:         THIS.MontarConfiguracaoDesconto()
3337:     ENDPROC
3338: 
3339:     PROCEDURE GradeiConfColumn3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
3340:         THIS.MontarConfiguracaoDesconto()
3341:         IF LASTKEY() = 9
3342:             THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD.Column1.SetFocus
3343:         ENDIF
3344:     ENDPROC
3345: 
3346:     *--------------------------------------------------------------------------
3347:     * MontarConfiguracaoDesconto - Equivalente ao "MontaTbDes" do legado.
3348:     * Filtra cursor_4c_Tds pela combinacao Tipo+Codigo+TipoDesconto da linha
3349:     * corrente de grd_4c_GradeI, cria a faixa inicial (00:00-23:59) quando
3350:     * ainda nao existe nenhuma, e reconfigura grd_4c_GradeD (ControlSource/
3351:     * InputMask das colunas Inicial/Final) conforme o Tipo de Desconto:
3352:     * 2=Dia da Semana, 3=Dia do Mes, 4=Horario, 5=Data
3353:     *--------------------------------------------------------------------------
3354:     PROTECTED PROCEDURE MontarConfiguracaoDesconto()
3355:         LOCAL loc_oGD, loc_oPgConf, loc_cCodigo, loc_nTipos, loc_cCodTips, ;
3356:               loc_nTipoDs, loc_cTitulo
3357: 
3358:         loc_oPgConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto
3359:         loc_oGD     = loc_oPgConf.grd_4c_GradeD
3360: 
3361:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3362:             loc_oGD.RecordSource = ""
3363:             loc_oGD.Enabled      = .F.
3364:             loc_oPgConf.lbl_4c_Lb_desconto.Caption = "Tipo de Desconto"
3365:             RETURN
3366:         ENDIF
3367: 
3368:         loc_cCodigo  = ALLTRIM(cursor_4c_Tdt.codigos)
3369:         loc_nTipos   = cursor_4c_Tdt.tipos
3370:         loc_cCodTips = ALLTRIM(cursor_4c_Tdt.codtips)
3371:         loc_nTipoDs  = cursor_4c_Tdt.tipods
3372: 
3373:         DO CASE
3374:             CASE loc_nTipoDs = 2
3375:                 loc_cTitulo = "Dia da Semana"
3376:             CASE loc_nTipoDs = 3
3377:                 loc_cTitulo = "Dia do Mes"
3378:             CASE loc_nTipoDs = 4
3379:                 loc_cTitulo = "Horario"
3380:             OTHERWISE
3381:                 loc_cTitulo = "Data"
3382:         ENDCASE
3383:         loc_oPgConf.lbl_4c_Lb_desconto.Caption = loc_cTitulo
3384: 
3385:         IF USED("cursor_4c_Tds")
3386:             SELECT cursor_4c_Tds
3387:             SET FILTER TO ALLTRIM(codigos) == loc_cCodigo AND tipos = loc_nTipos ;
3388:                 AND ALLTRIM(codtips) == loc_cCodTips AND tipods = loc_nTipoDs
3389:             GO TOP
3390:             IF EOF()
3391:                 APPEND BLANK
3392:                 REPLACE cidchaves WITH fUniqueIds(), ;
3393:                         codigos   WITH loc_cCodigo, ;
3394:                         tipos     WITH loc_nTipos, ;

*-- Linhas 3472 a 3937:
3472:         loc_nMin   = VAL(SUBSTR(loc_cValor, 4, 2))
3473: 
3474:         IF !BETWEEN(loc_nHora, 0, 23)
3475:             MsgAviso("Horas s" + CHR(243) + " pode ser entre 00:00 e 23:59", "")
3476:             RETURN ""
3477:         ENDIF
3478:         IF !BETWEEN(loc_nMin, 0, 59)
3479:             MsgAviso("Minutos s" + CHR(243) + " pode ser entre 00 e 59", "")
3480:             RETURN ""
3481:         ENDIF
3482: 
3483:         RETURN TRANSFORM(loc_nHora, "@L 99") + ":" + TRANSFORM(loc_nMin, "@L 99")
3484:     ENDFUNC
3485: 
3486:     *--------------------------------------------------------------------------
3487:     * FaixaTemInicial - Indica se a faixa (linha corrente de cursor_4c_Tds)
3488:     * ja tem o valor Inicial preenchido, condicao para habilitar as demais
3489:     * colunas de grd_4c_GradeD (equivalente ao "Left(Campo1is,2)" do legado).
3490:     * Quando o Tipo de Desconto e "Data" (5), o Inicial fica em Campo3is
3491:     * (nao em Campo1is - ver MontarConfiguracaoDesconto)
3492:     *--------------------------------------------------------------------------
3493:     PROTECTED FUNCTION FaixaTemInicial()
3494:         LOCAL loc_nTipoDs
3495: 
3496:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3497:             RETURN .F.
3498:         ENDIF
3499: 
3500:         loc_nTipoDs = 0
3501:         IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
3502:             loc_nTipoDs = cursor_4c_Tdt.tipods
3503:         ENDIF
3504: 
3505:         IF loc_nTipoDs = 5
3506:             RETURN !EMPTY(cursor_4c_Tds.Campo3is)
3507:         ENDIF
3508: 
3509:         RETURN !EMPTY(LEFT(NVL(cursor_4c_Tds.Campo1is, ""), 2))
3510:     ENDFUNC
3511: 
3512:     *--------------------------------------------------------------------------
3513:     * GradeD Column1/Column2 (Inicial/Final) - When/Valid
3514:     * Equivalente ao "PgConfDesconto.GradeD.Column1/2.Text1" do legado:
3515:     * validacao/formatacao depende do Tipo de Desconto (tipods) da linha
3516:     * corrente de grd_4c_GradeI (cursor_4c_Tdt)
3517:     * PUBLIC: BINDEVENT requer metodo publico
3518:     *--------------------------------------------------------------------------
3519:     PROCEDURE GradeDColumn1When()
3520:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3521:     ENDPROC
3522: 
3523:     PROCEDURE GradeDColumn1Valid()
3524:         LOCAL loc_oGD, loc_cValor, loc_cFormatado
3525: 
3526:         IF !USED("cursor_4c_Tdt") OR !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tdt") OR EOF("cursor_4c_Tds")
3527:             RETURN
3528:         ENDIF
3529: 
3530:         loc_oGD    = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3531:         loc_cValor = ALLTRIM(loc_oGD.Column1.Text1.Value)
3532: 
3533:         IF EMPTY(loc_cValor)
3534:             RETURN
3535:         ENDIF
3536: 
3537:         DO CASE
3538:             CASE cursor_4c_Tdt.tipods = 2  && Dia da Semana
3539:                 IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3540:                     MsgAviso("Dia da semana inv" + CHR(225) + "lido. Informe Domingo, Segunda, Terca, Quarta, Quinta, Sexta ou Sabado.", "")
3541:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3542:                 ELSE
3543:                     REPLACE Campo1is WITH ALLTRIM(cursor_4c_DiaSemana.Descrs) IN cursor_4c_Tds
3544:                     IF EMPTY(ALLTRIM(cursor_4c_Tds.Campo1fs))
3545:                         REPLACE Campo1fs WITH cursor_4c_Tds.Campo1is IN cursor_4c_Tds
3546:                     ENDIF
3547:                 ENDIF
3548: 
3549:             CASE cursor_4c_Tdt.tipods = 3  && Dia do Mes
3550:                 IF !BETWEEN(VAL(loc_cValor), 1, 31)
3551:                     MsgAviso("Dia do m" + CHR(234) + "s deve ser entre 1 e 31 !!!", "")
3552:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3553:                 ELSE
3554:                     REPLACE Campo1is WITH PADL(TRANSFORM(INT(VAL(loc_cValor))), 2, "0") IN cursor_4c_Tds
3555:                     IF VAL(cursor_4c_Tds.Campo1fs) = 0 OR VAL(cursor_4c_Tds.Campo1is) > VAL(cursor_4c_Tds.Campo1fs)
3556:                         REPLACE Campo1fs WITH cursor_4c_Tds.Campo1is IN cursor_4c_Tds
3557:                     ENDIF
3558:                 ENDIF
3559: 
3560:             CASE cursor_4c_Tdt.tipods = 4  && Horario
3561:                 loc_cFormatado = THIS.FormatarHorarioValidado(loc_cValor)
3562:                 IF EMPTY(loc_cFormatado)
3563:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3564:                 ELSE
3565:                     REPLACE Campo1is WITH loc_cFormatado IN cursor_4c_Tds
3566:                     IF EMPTY(cursor_4c_Tds.Campo1fs) OR VAL(STRTRAN(loc_cFormatado, ":", "")) > VAL(STRTRAN(cursor_4c_Tds.Campo1fs, ":", ""))
3567:                         REPLACE Campo1fs WITH loc_cFormatado IN cursor_4c_Tds
3568:                     ENDIF
3569:                 ENDIF
3570: 
3571:             OTHERWISE  && 5 = Data (Campo3is/Campo3fs, DATETIME - VFP valida o tipo na propria coluna)
3572:                 IF !EMPTY(cursor_4c_Tds.Campo3fs) AND cursor_4c_Tds.Campo3is > cursor_4c_Tds.Campo3fs
3573:                     REPLACE Campo3fs WITH cursor_4c_Tds.Campo3is IN cursor_4c_Tds
3574:                 ENDIF
3575:         ENDCASE
3576: 
3577:         loc_oGD.Refresh()
3578:     ENDPROC
3579: 
3580:     PROCEDURE GradeDColumn2When()
3581:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial()
3582:     ENDPROC
3583: 
3584:     PROCEDURE GradeDColumn2Valid()
3585:         LOCAL loc_oGD, loc_cValor, loc_nDiaIni, loc_cFormatado
3586: 
3587:         IF !USED("cursor_4c_Tdt") OR !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tdt") OR EOF("cursor_4c_Tds")
3588:             RETURN
3589:         ENDIF
3590: 
3591:         loc_oGD    = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3592:         loc_cValor = ALLTRIM(loc_oGD.Column2.Text1.Value)
3593: 
3594:         IF EMPTY(loc_cValor)
3595:             RETURN
3596:         ENDIF
3597: 
3598:         DO CASE
3599:             CASE cursor_4c_Tdt.tipods = 2  && Dia da Semana
3600:                 IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3601:                     MsgAviso("Dia da semana inv" + CHR(225) + "lido.", "")
3602:                     RETURN
3603:                 ENDIF
3604:                 IF SEEK(PADR(UPPER(ALLTRIM(cursor_4c_Tds.Campo1is)), 7), "cursor_4c_DiaSemana", "Descrs")
3605:                     loc_nDiaIni = cursor_4c_DiaSemana.nDias
3606:                     IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs") OR cursor_4c_DiaSemana.nDias < loc_nDiaIni
3607:                         MsgAviso("Dia final n" + CHR(227) + "o pode ser anterior ao dia inicial !!!", "")
3608:                         RETURN
3609:                     ENDIF
3610:                 ENDIF
3611:                 =SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3612:                 REPLACE Campo1fs WITH ALLTRIM(cursor_4c_DiaSemana.Descrs) IN cursor_4c_Tds
3613: 
3614:             CASE cursor_4c_Tdt.tipods = 3  && Dia do Mes
3615:                 IF !BETWEEN(VAL(loc_cValor), 1, 31)
3616:                     MsgAviso("Dia do m" + CHR(234) + "s deve ser entre 1 e 31 !!!", "")
3617:                     RETURN
3618:                 ENDIF
3619:                 IF VAL(loc_cValor) < VAL(cursor_4c_Tds.Campo1is)
3620:                     MsgAviso("Intervalo de dias inv" + CHR(225) + "lido. O dia final " + CHR(233) + " menor que o inicial.", "")
3621:                     RETURN
3622:                 ENDIF
3623:                 REPLACE Campo1fs WITH PADL(TRANSFORM(INT(VAL(loc_cValor))), 2, "0") IN cursor_4c_Tds
3624: 
3625:             CASE cursor_4c_Tdt.tipods = 4  && Horario
3626:                 loc_cFormatado = THIS.FormatarHorarioValidado(loc_cValor)
3627:                 IF EMPTY(loc_cFormatado)
3628:                     RETURN
3629:                 ENDIF
3630:                 IF VAL(STRTRAN(loc_cFormatado, ":", "")) < VAL(STRTRAN(cursor_4c_Tds.Campo1is, ":", ""))
3631:                     MsgAviso("Intervalo de hor" + CHR(225) + "rio inv" + CHR(225) + "lido. A hora final " + CHR(233) + " menor que a inicial.", "")
3632:                     RETURN
3633:                 ENDIF
3634:                 REPLACE Campo1fs WITH loc_cFormatado IN cursor_4c_Tds
3635: 
3636:             OTHERWISE  && 5 = Data
3637:                 IF cursor_4c_Tds.Campo3fs < cursor_4c_Tds.Campo3is
3638:                     MsgAviso("Data final n" + CHR(227) + "o pode ser menor que a inicial !!!", "")
3639:                 ENDIF
3640:         ENDCASE
3641: 
3642:         loc_oGD.Refresh()
3643:     ENDPROC
3644: 
3645:     *--------------------------------------------------------------------------
3646:     * GradeD Column3/Column4 - faixa de horario dentro do dia (Campo2is/fs).
3647:     * Nao se aplica quando o Tipo de Desconto ja e "Horario" (Column1/2)
3648:     * PUBLIC: BINDEVENT requer metodo publico
3649:     *--------------------------------------------------------------------------
3650:     PROCEDURE GradeDColumn3When()
3651:         LOCAL loc_nTipoDs
3652:         loc_nTipoDs = 0
3653:         IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
3654:             loc_nTipoDs = cursor_4c_Tdt.tipods
3655:         ENDIF
3656:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial() AND loc_nTipoDs != 4
3657:     ENDPROC
3658: 
3659:     PROCEDURE GradeDColumn3Valid()
3660:         LOCAL loc_oGD, loc_cFormatado
3661: 
3662:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3663:             RETURN
3664:         ENDIF
3665: 
3666:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3667:         loc_cFormatado = THIS.FormatarHorarioValidado(ALLTRIM(loc_oGD.Column3.Text1.Value))
3668:         IF EMPTY(loc_cFormatado)
3669:             RETURN
3670:         ENDIF
3671: 
3672:         REPLACE Campo2is WITH loc_cFormatado IN cursor_4c_Tds
3673:         IF EMPTY(cursor_4c_Tds.Campo2fs) OR VAL(STRTRAN(loc_cFormatado, ":", "")) > VAL(STRTRAN(cursor_4c_Tds.Campo2fs, ":", ""))
3674:             REPLACE Campo2fs WITH loc_cFormatado IN cursor_4c_Tds
3675:         ENDIF
3676: 
3677:         loc_oGD.Refresh()
3678:     ENDPROC
3679: 
3680:     PROCEDURE GradeDColumn4When()
3681:         RETURN THIS.GradeDColumn3When()
3682:     ENDPROC
3683: 
3684:     PROCEDURE GradeDColumn4Valid()
3685:         LOCAL loc_oGD, loc_cFormatado
3686: 
3687:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3688:             RETURN
3689:         ENDIF
3690: 
3691:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3692:         loc_cFormatado = THIS.FormatarHorarioValidado(ALLTRIM(loc_oGD.Column4.Text1.Value))
3693:         IF EMPTY(loc_cFormatado)
3694:             RETURN
3695:         ENDIF
3696: 
3697:         IF VAL(STRTRAN(loc_cFormatado, ":", "")) < VAL(STRTRAN(cursor_4c_Tds.Campo2is, ":", ""))
3698:             MsgAviso("Intervalo de horas inv" + CHR(225) + "lido. A hora final " + CHR(233) + " menor que a inicial.", "")
3699:             RETURN
3700:         ENDIF
3701: 
3702:         REPLACE Campo2fs WITH loc_cFormatado IN cursor_4c_Tds
3703:         loc_oGD.Refresh()
3704:     ENDPROC
3705: 
3706:     *--------------------------------------------------------------------------
3707:     * GradeD Column5/Column6 - Preco/Fator da faixa. Column6 (Fator), ao
3708:     * confirmar com ENTER, cria automaticamente uma nova faixa em branco
3709:     * (equivalente ao legado)
3710:     * PUBLIC: BINDEVENT requer metodo publico
3711:     *--------------------------------------------------------------------------
3712:     PROCEDURE GradeDColumn5When()
3713:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial()
3714:     ENDPROC
3715: 
3716:     PROCEDURE GradeDColumn6Valid()
3717:         LOCAL loc_oGD
3718: 
3719:         IF LASTKEY() != 13 OR !USED("cursor_4c_Tds") OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3720:             RETURN
3721:         ENDIF
3722: 
3723:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3724: 
3725:         SELECT cursor_4c_Tds
3726:         SKIP
3727:         IF EOF()
3728:             APPEND BLANK
3729:             REPLACE cidchaves WITH fUniqueIds(), ;
3730:                     codigos   WITH ALLTRIM(cursor_4c_Tdt.codigos), ;
3731:                     tipos     WITH cursor_4c_Tdt.tipos, ;
3732:                     codtips   WITH ALLTRIM(cursor_4c_Tdt.codtips), ;
3733:                     tipods    WITH cursor_4c_Tdt.tipods, ;
3734:                     campo2is  WITH "00:00", ;
3735:                     campo2fs  WITH "23:59" IN cursor_4c_Tds
3736:             GO BOTTOM IN cursor_4c_Tds
3737:         ENDIF
3738: 
3739:         loc_oGD.Refresh()
3740:     ENDPROC
3741: 
3742:     *--------------------------------------------------------------------------
3743:     * BtnExcluirFaixaDescontoClick - remove a faixa corrente de grd_4c_GradeD;
3744:     * garante que sempre reste ao menos uma faixa (equivalente ao legado)
3745:     * PUBLIC: BINDEVENT requer metodo publico
3746:     *--------------------------------------------------------------------------
3747:     PROCEDURE BtnExcluirFaixaDescontoClick()
3748:         LOCAL loc_oGD, loc_nRegistros
3749: 
3750:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tds") ;
3751:                 OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3752:             RETURN
3753:         ENDIF
3754: 
3755:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3756: 
3757:         SELECT cursor_4c_Tds
3758:         IF !EOF()
3759:             DELETE
3760:         ENDIF
3761: 
3762:         COUNT FOR !DELETED() TO loc_nRegistros
3763:         IF loc_nRegistros = 0
3764:             APPEND BLANK
3765:             REPLACE cidchaves WITH fUniqueIds(), ;
3766:                     codigos   WITH ALLTRIM(cursor_4c_Tdt.codigos), ;
3767:                     tipos     WITH cursor_4c_Tdt.tipos, ;
3768:                     codtips   WITH ALLTRIM(cursor_4c_Tdt.codtips), ;
3769:                     tipods    WITH cursor_4c_Tdt.tipods, ;
3770:                     campo2is  WITH "00:00", ;
3771:                     campo2fs  WITH "23:59" IN cursor_4c_Tds
3772:         ENDIF
3773: 
3774:         GO TOP IN cursor_4c_Tds
3775:         loc_oGD.Refresh()
3776:         loc_oGD.SetFocus
3777:     ENDPROC
3778: 
3779:     *--------------------------------------------------------------------------
3780:     * MontarComissoesDesconto - Equivalente ao "MontaTbCom" do legado.
3781:     * Filtra localmente cursor_4c_Tdi pela combinacao Tipo+Codigo da linha
3782:     * corrente de grd_4c_Gradei (cursor_4c_Tdt) e atualiza grd_4c_Gradec.
3783:     *--------------------------------------------------------------------------
3784:     PROTECTED PROCEDURE MontarComissoesDesconto()
3785:         LOCAL loc_oGradec, loc_nTipos, loc_cCodTips
3786: 
3787:         loc_oGradec = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec
3788: 
3789:         IF !USED("cursor_4c_Tdi")
3790:             RETURN
3791:         ENDIF
3792: 
3793:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3794:             SELECT cursor_4c_Tdi
3795:             SET FILTER TO .F.
3796:             loc_oGradec.Refresh()
3797:             RETURN
3798:         ENDIF
3799: 
3800:         loc_nTipos   = cursor_4c_Tdt.tipos
3801:         loc_cCodTips = ALLTRIM(cursor_4c_Tdt.codtips)
3802: 
3803:         SELECT cursor_4c_Tdi
3804:         SET FILTER TO tipos = loc_nTipos AND ALLTRIM(codtips) = loc_cCodTips
3805:         GO TOP IN cursor_4c_Tdi
3806:         loc_oGradec.Refresh()
3807:     ENDPROC
3808: 
3809:     *--------------------------------------------------------------------------
3810:     * GradeiDescAfterRowColChange - troca de linha em grd_4c_Gradei (pagina
3811:     * "Descontos / Comissoes"): marca a linha corrente (flag "regs",
3812:     * compartilhada com grd_4c_GradeI de PgConfDesconto), refresca os
3813:     * controles bindados a cursor_4c_Tdt (formulas 1a/2a, comissao, fator/
3814:     * descritivo, ignora cotacao) e reconfigura grd_4c_Gradec (comissoes)
3815:     * PUBLIC: BINDEVENT requer metodo publico + parametro do evento
3816:     *--------------------------------------------------------------------------
3817:     PROCEDURE GradeiDescAfterRowColChange(par_nColIndex)
3818:         LOCAL loc_oCnt
3819: 
3820:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3821:             RETURN
3822:         ENDIF
3823: 
3824:         SELECT cursor_4c_Tdt
3825:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3826:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3827: 
3828:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
3829:         loc_oCnt.grd_4c_Gradei.Refresh()
3830:         loc_oCnt.cnt_4c_Formula1.Refresh()
3831:         loc_oCnt.cnt_4c_Formula2.Refresh()
3832:         loc_oCnt.cbo_4c_ComboComis.Refresh()
3833:         loc_oCnt.txt_4c_DescFats.Refresh()
3834:         loc_oCnt.txt_4c_FatorPads.Refresh()
3835:         loc_oCnt.chk_4c_IgnoraCotacao.Refresh()
3836: 
3837:         *-- grd_4c_GradeI de PgConfDesconto compartilha a mesma cursor_4c_Tdt
3838:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3839: 
3840:         THIS.MontarComissoesDesconto()
3841:     ENDPROC
3842: 
3843:     *--------------------------------------------------------------------------
3844:     * GradeiDescColunaEditavelWhen - habilita edicao das colunas de
3845:     * grd_4c_Gradei (Tipo/Codigo/Valor/Fator/Exclui) apenas em INCLUIR/
3846:     * ALTERAR (equivalente ao When original de cada coluna)
3847:     * PUBLIC: BINDEVENT requer metodo publico
3848:     *--------------------------------------------------------------------------
3849:     PROCEDURE GradeiDescColunaEditavelWhen()
3850:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3851:     ENDPROC
3852: 
3853:     *--------------------------------------------------------------------------
3854:     * GradeiDescColumn5Valid - valida coluna "E" (texclus): apenas S, N ou
3855:     * vazio (equivalente ao legado)
3856:     * PUBLIC: BINDEVENT requer metodo publico
3857:     *--------------------------------------------------------------------------
3858:     PROCEDURE GradeiDescColumn5Valid()
3859:         LOCAL loc_oText, loc_cValor
3860: 
3861:         loc_oText = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradei.Column5.Text1
3862:         loc_cValor = UPPER(ALLTRIM(loc_oText.Value))
3863: 
3864:         IF !INLIST(loc_cValor, "S", "N", "")
3865:             MsgAviso("Dados Inv" + CHR(225) + "lidos. Informe [S/N/ ]", "")
3866:             RETURN .F.
3867:         ENDIF
3868: 
3869:         RETURN .T.
3870:     ENDPROC
3871: 
3872:     *--------------------------------------------------------------------------
3873:     * GradeiDescCodigoKeyPress / GradeiDescCodigoDblClick - F4/DblClick para
3874:     * lookup do codigo da linha de composicao (Column2), conforme o Tipo
3875:     * (Column1) selecionado na mesma linha
3876:     * PUBLIC: BINDEVENT requer metodo publico + parametros do evento
3877:     *--------------------------------------------------------------------------
3878:     PROCEDURE GradeiDescCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3879:         IF par_nKeyCode = 28  && F4
3880:             THIS.AbrirLookupCodigoComposicao()
3881:         ENDIF
3882:     ENDPROC
3883: 
3884:     PROCEDURE GradeiDescCodigoDblClick()
3885:         THIS.AbrirLookupCodigoComposicao()
3886:     ENDPROC
3887: 
3888:     *--------------------------------------------------------------------------
3889:     * AbrirLookupCodigoComposicao - Busca o codigo da linha corrente de
3890:     * grd_4c_Gradei (cursor_4c_Tdt.codtips) na tabela correspondente ao
3891:     * Tipo (cursor_4c_Tdt.tipos), igual ao Do Case do legado:
3892:     * 1=Grupo(SigCdGrp/cgrus) 2=Linha(SigCdLin/linhas) 3=Gr.Venda(SigCdCol/
3893:     * colecoes) 4=Produto(SigCdPro/cpros) 5=Moeda(SigCdMoe/cmoes)
3894:     * 6=Unidade(SigCdUni/cunis) 7=Feitio(SigPrFti/cods) 8=SubGrupo(SigCdPsg/
3895:     * codigos) 9=Finalidade(SigCdFip/cods)
3896:     *--------------------------------------------------------------------------
3897:     PROCEDURE AbrirLookupCodigoComposicao()
3898:         LOCAL loc_oGradei, loc_nTipos, loc_cTabela, loc_cCampo, loc_cDescCampo, ;
3899:               loc_cTitulo, loc_cValor, loc_oBusca
3900: 
3901:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3902:             RETURN
3903:         ENDIF
3904: 
3905:         loc_oGradei = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradei
3906:         loc_nTipos  = cursor_4c_Tdt.tipos
3907:         loc_cValor  = ALLTRIM(cursor_4c_Tdt.codtips)
3908: 
3909:         DO CASE
3910:             CASE loc_nTipos = 1
3911:                 loc_cTabela = "SigCdGrp"  && Grupo
3912:                 loc_cCampo = "cgrus"
3913:                 loc_cDescCampo = "dgrus"
3914:                 loc_cTitulo = "Grupos"
3915:             CASE loc_nTipos = 2
3916:                 loc_cTabela = "SigCdLin"  && Linha
3917:                 loc_cCampo = "linhas"
3918:                 loc_cDescCampo = "descs"
3919:                 loc_cTitulo = "Linhas"
3920:             CASE loc_nTipos = 3
3921:                 loc_cTabela = "SigCdCol"  && Gr. Venda
3922:                 loc_cCampo = "colecoes"
3923:                 loc_cDescCampo = "descs"
3924:                 loc_cTitulo = "Grupos de Venda"
3925:             CASE loc_nTipos = 4
3926:                 loc_cTabela = "SigCdPro"  && Produto
3927:                 loc_cCampo = "cpros"
3928:                 loc_cDescCampo = "dpros"
3929:                 loc_cTitulo = "Produtos"
3930:             CASE loc_nTipos = 5
3931:                 loc_cTabela = "SigCdMoe"  && Moeda
3932:                 loc_cCampo = "cmoes"
3933:                 loc_cDescCampo = "dmoes"
3934:                 loc_cTitulo = "Moedas"
3935:             CASE loc_nTipos = 6
3936:                 loc_cTabela = "SigCdUni"  && Unidade
3937:                 loc_cCampo = "cunis"

*-- Linhas 3953 a 4227:
3953:                 loc_cDescCampo = "descs"
3954:                 loc_cTitulo = "Finalidade"
3955:             OTHERWISE
3956:                 MsgAviso("Selecione o Tipo antes de buscar o C" + CHR(243) + "digo.", "")
3957:                 RETURN
3958:         ENDCASE
3959: 
3960:         TRY
3961:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3962:                 loc_cTabela, "cursor_4c_BuscaComposicao", loc_cCampo, loc_cValor, ;
3963:                 loc_cTitulo)
3964: 
3965:             IF VARTYPE(loc_oBusca) = "O"
3966:                 IF !loc_oBusca.this_lAchouRegistro
3967:                     loc_oBusca.mAddColuna(loc_cCampo, "", "C" + CHR(243) + "digo")
3968:                     loc_oBusca.mAddColuna(loc_cDescCampo, "", "Descri" + CHR(231) + CHR(227) + "o")
3969:                     loc_oBusca.Show()
3970:                 ENDIF
3971: 
3972:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaComposicao")
3973:                     SELECT cursor_4c_BuscaComposicao
3974:                     REPLACE codtips WITH ALLTRIM(EVALUATE("cursor_4c_BuscaComposicao." + loc_cCampo)) IN cursor_4c_Tdt
3975:                     loc_oGradei.Refresh()
3976:                 ENDIF
3977: 
3978:                 loc_oBusca.Release()
3979:             ENDIF
3980:         CATCH TO loException
3981:             MostrarErro(loException, "FormTbv.AbrirLookupCodigoComposicao")
3982:         ENDTRY
3983: 
3984:         IF USED("cursor_4c_BuscaComposicao")
3985:             USE IN cursor_4c_BuscaComposicao
3986:         ENDIF
3987:     ENDPROC
3988: 
3989:     *--------------------------------------------------------------------------
3990:     * BtnInserirComposicaoClick - Inclui uma nova linha de composicao
3991:     * (cursor_4c_Tdt) para o codigo corrente
3992:     * PUBLIC: BINDEVENT requer metodo publico
3993:     *--------------------------------------------------------------------------
3994:     PROCEDURE BtnInserirComposicaoClick()
3995:         LOCAL loc_oPgDesc
3996: 
3997:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt")
3998:             RETURN
3999:         ENDIF
4000: 
4001:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
4002: 
4003:         INSERT INTO cursor_4c_Tdt (codigos) VALUES (ALLTRIM(THIS.this_oBusinessObject.this_cCodigo))
4004:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
4005:         REPLACE regs WITH 1 IN cursor_4c_Tdt
4006: 
4007:         loc_oPgDesc.grd_4c_Gradei.Refresh()
4008:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
4009:         loc_oPgDesc.grd_4c_Gradei.Column1.SetFocus
4010:         THIS.MontarComissoesDesconto()
4011:     ENDPROC
4012: 
4013:     *--------------------------------------------------------------------------
4014:     * BtnExcluirComposicaoClick - Remove a linha corrente de composicao
4015:     * (cursor_4c_Tdt); bloqueia se ainda houver comissoes vinculadas
4016:     * (equivalente ao legado - "Exclua primeiro as comissoes...")
4017:     * PUBLIC: BINDEVENT requer metodo publico
4018:     *--------------------------------------------------------------------------
4019:     PROCEDURE BtnExcluirComposicaoClick()
4020:         LOCAL loc_oPgDesc
4021: 
4022:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
4023:             RETURN
4024:         ENDIF
4025: 
4026:         THIS.MontarComissoesDesconto()
4027:         IF USED("cursor_4c_Tdi") AND !EOF("cursor_4c_Tdi")
4028:             MsgAviso("Imposs" + CHR(237) + "vel excluir!!! Exclua primeiro as comiss" + CHR(245) + "es...", "")
4029:             RETURN
4030:         ENDIF
4031: 
4032:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
4033: 
4034:         SELECT cursor_4c_Tdt
4035:         DELETE
4036:         GO BOTTOM IN cursor_4c_Tdt
4037:         IF !EOF("cursor_4c_Tdt")
4038:             REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
4039:             REPLACE regs WITH 1 IN cursor_4c_Tdt
4040:         ENDIF
4041: 
4042:         loc_oPgDesc.grd_4c_Gradei.Refresh()
4043:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
4044:         loc_oPgDesc.grd_4c_Gradei.Column1.SetFocus
4045:         THIS.MontarComissoesDesconto()
4046:     ENDPROC
4047: 
4048:     *--------------------------------------------------------------------------
4049:     * BtnInserirComissaoClick - Inclui uma nova comissao (cursor_4c_Tdi)
4050:     * para a linha corrente de composicao (Tipo/Codigo)
4051:     * PUBLIC: BINDEVENT requer metodo publico
4052:     *--------------------------------------------------------------------------
4053:     PROCEDURE BtnInserirComissaoClick()
4054:         LOCAL loc_oPgDesc
4055: 
4056:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt") ;
4057:                 OR EOF("cursor_4c_Tdt") OR !USED("cursor_4c_Tdi")
4058:             RETURN
4059:         ENDIF
4060: 
4061:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
4062: 
4063:         INSERT INTO cursor_4c_Tdi (codigos, tipos, codtips) VALUES ;
4064:             (ALLTRIM(THIS.this_oBusinessObject.this_cCodigo), cursor_4c_Tdt.tipos, ALLTRIM(cursor_4c_Tdt.codtips))
4065: 
4066:         THIS.MontarComissoesDesconto()
4067:         loc_oPgDesc.grd_4c_Gradec.Column1.SetFocus
4068:     ENDPROC
4069: 
4070:     *--------------------------------------------------------------------------
4071:     * BtnExcluirComissaoClick - Remove a comissao corrente (cursor_4c_Tdi)
4072:     * PUBLIC: BINDEVENT requer metodo publico
4073:     *--------------------------------------------------------------------------
4074:     PROCEDURE BtnExcluirComissaoClick()
4075:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdi") OR EOF("cursor_4c_Tdi")
4076:             RETURN
4077:         ENDIF
4078: 
4079:         SELECT cursor_4c_Tdi
4080:         DELETE
4081:         GO BOTTOM IN cursor_4c_Tdi
4082: 
4083:         THIS.MontarComissoesDesconto()
4084:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec.Column1.SetFocus
4085:     ENDPROC
4086: 
4087:     *--------------------------------------------------------------------------
4088:     * GradecColumn1Valid / GradecColumn2Valid - Grupo/Conta da comissao.
4089:     * Simplificado em relacao ao legado: NAO reproduz as checagens de
4090:     * acesso contabil (fAcessoContab/fAcessoContas do Framework legado -
4091:     * fora do escopo desta migracao). Column2 (Conta) valida contra
4092:     * SigCdCli e preenche automaticamente o Grupo quando vazio.
4093:     * PUBLIC: BINDEVENT requer metodo publico
4094:     *--------------------------------------------------------------------------
4095:     PROCEDURE GradecColumn1Valid()
4096:         RETURN .T.
4097:     ENDPROC
4098: 
4099:     PROCEDURE GradecColumn2Valid()
4100:         LOCAL loc_oGradec, loc_cConta, loc_cSQL
4101: 
4102:         IF !USED("cursor_4c_Tdi") OR EOF("cursor_4c_Tdi")
4103:             RETURN .T.
4104:         ENDIF
4105: 
4106:         loc_oGradec = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec
4107:         loc_cConta  = ALLTRIM(loc_oGradec.Column2.Text1.Value)
4108: 
4109:         IF EMPTY(loc_cConta)
4110:             RETURN .T.
4111:         ENDIF
4112: 
4113:         TRY
4114:             loc_cSQL = "SELECT iclis, grupos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
4115: 
4116:             IF USED("cursor_4c_BuscaConta")
4117:                 USE IN cursor_4c_BuscaConta
4118:             ENDIF
4119: 
4120:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") < 1 OR !USED("cursor_4c_BuscaConta") OR EOF("cursor_4c_BuscaConta")
4121:                 MsgAviso("Conta Inv" + CHR(225) + "lida !!!", "Acesso Negado")
4122:                 IF USED("cursor_4c_BuscaConta")
4123:                     USE IN cursor_4c_BuscaConta
4124:                 ENDIF
4125:                 loc_lResultado = .F.
4126:             ENDIF
4127: 
4128:             REPLACE contas WITH loc_cConta IN cursor_4c_Tdi
4129:             IF EMPTY(ALLTRIM(cursor_4c_Tdi.grupos))
4130:                 REPLACE grupos WITH ALLTRIM(TratarNulo(cursor_4c_BuscaConta.grupos, "C")) IN cursor_4c_Tdi
4131:             ENDIF
4132:             loc_oGradec.Refresh()
4133:         CATCH TO loException
4134:             MostrarErro(loException, "FormTbv.GradecColumn2Valid")
4135:         ENDTRY
4136: 
4137:         IF USED("cursor_4c_BuscaConta")
4138:             USE IN cursor_4c_BuscaConta
4139:         ENDIF
4140: 
4141:         RETURN .T.
4142:     ENDPROC
4143: 
4144:     *--------------------------------------------------------------------------
4145:     * TornarControlesVisiveis - Torna controles do container visiveis (recursivo)
4146:     *--------------------------------------------------------------------------
4147:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4148:         LOCAL loc_nI, loc_oControl
4149: 
4150:         IF VARTYPE(par_oContainer) != "O"
4151:             RETURN
4152:         ENDIF
4153: 
4154:         FOR loc_nI = 1 TO par_oContainer.ControlCount
4155:             loc_oControl = par_oContainer.Controls(loc_nI)
4156: 
4157:             *-- Containers com visibilidade condicional (controlada por
4158:             *-- outra logica do form - ex: tipo de desconto 11 mostra
4159:             *-- cnt_4c_Container1, PgConfDesconto so aparece na aba de
4160:             *-- configuracao) NAO podem ser forcados a Visible=.T. aqui
4161:             IF PEMSTATUS(loc_oControl, "Visible", 5) ;
4162:                     AND !INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO", "CNT_4C_CONTAINER1", "CNT_4C_PGCONFDESCONTO")
4163:                 loc_oControl.Visible = .T.
4164:             ENDIF
4165: 
4166:             *-- Trata PageFrame - itera Pages
4167:             IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
4168:                 LOCAL loc_nP
4169:                 FOR loc_nP = 1 TO loc_oControl.PageCount
4170:                     THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
4171:                 ENDFOR
4172:             ENDIF
4173: 
4174:             *-- Trata containers com ControlCount
4175:             IF PEMSTATUS(loc_oControl, "ControlCount", 5)
4176:                 THIS.TornarControlesVisiveis(loc_oControl)
4177:             ENDIF
4178:         ENDFOR
4179:     ENDPROC
4180: 
4181:     *--------------------------------------------------------------------------
4182:     * FormatarGridLista - Formata visual do grid da lista
4183:     *--------------------------------------------------------------------------
4184:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
4185:         IF VARTYPE(par_oGrid) != "O"
4186:             RETURN
4187:         ENDIF
4188: 
4189:         WITH par_oGrid
4190:             .FontName = "Tahoma"
4191:             .FontSize = 8
4192:         ENDWITH
4193:     ENDPROC
4194: 
4195:     *--------------------------------------------------------------------------
4196:     * Destroy - Liberacao de recursos
4197:     *--------------------------------------------------------------------------
4198:     PROCEDURE Destroy()
4199:         TRY
4200:             IF USED("cursor_4c_Dados")
4201:                 USE IN cursor_4c_Dados
4202:             ENDIF
4203:             IF USED("cursor_4c_TipoDesconto")
4204:                 USE IN cursor_4c_TipoDesconto
4205:             ENDIF
4206:             IF USED("cursor_4c_Empresas")
4207:                 USE IN cursor_4c_Empresas
4208:             ENDIF
4209:             IF USED("cursor_4c_Tdt")
4210:                 USE IN cursor_4c_Tdt
4211:             ENDIF
4212:             IF USED("cursor_4c_Tdi")
4213:                 USE IN cursor_4c_Tdi
4214:             ENDIF
4215:             IF USED("cursor_4c_Tds")
4216:                 USE IN cursor_4c_Tds
4217:             ENDIF
4218:             IF USED("cursor_4c_DiaSemana")
4219:                 USE IN cursor_4c_DiaSemana
4220:             ENDIF
4221:         CATCH TO loException
4222:             *-- Ignorar erros na destruicao
4223:         ENDTRY
4224:         DODEFAULT()
4225:     ENDPROC
4226: 
4227: ENDDEFINE


### BO (C:\4c\projeto\app\classes\TbvBO.prg):
*====================================================================
* TbvBO.prg
*
* Business Object para Tabelas de Descontos
* Tabela principal: SigOpTdz (codigos PK)
* Sub-tabelas (grades - tratadas em fases posteriores via cursor):
*   SigOpTdt (composicao/formula), SigOpTdi (comissoes por grupo/conta),
*   SigOpTds (faixas de horario/dia de desconto), SigCdEmp (empresas)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TbvBO AS BusinessBase

	*-- Propriedades da entidade (SigOpTdz)
	this_cCodigo          = ""   && codigos char(10)      - PK codigo da tabela de desconto
	this_cDescricao       = ""   && descrs char(30)        - descricao
	this_cMoeRef          = ""   && moerefs char(3)        - moeda de referencia
	this_nDesconto        = 0    && descos numeric(5,2)    - percentual de desconto
	this_cObservacao      = ""   && obss char(30)          - observacao
	this_nRelDesconto     = 0    && rel_descs numeric(1,0) - imprime no relatorio de tab. desconto (OptionGroup)
	this_dDataTermino     = {}   && dtterms datetime (NULL) - valido ate (data de termino)
	this_nPrazoMedio      = 0    && prazoms numeric(3,0)   - prazo medio (sem uso)
	this_nChkAcesso       = 0    && chkactb numeric(1,0)   - checar acesso (OptionGroup)
	this_nChkRetorno      = 0    && chkrets numeric(1,0)   - checagem de retorno (OptionGroup)
	this_nAjuste          = 0    && ajustes numeric(8,6)   - valor de ajuste
	this_nFator           = 0    && fators numeric(4,2)    - fator
	this_cMoedaFator      = ""   && moefats char(3)        - moeda do fator
	this_nChaveTabDesc    = 0    && nchvtbds numeric(6,0)  - chave interna da tabela de desconto (auto-gerada)
	this_nDescontoMaximo  = 0    && descmxs numeric(5,2)   - desconto maximo
	this_nAbateCusto      = 0    && abatecus numeric(1,0)  - abater custo de produto da comissao (OptionGroup)
	this_nAgrupaComissao  = 0    && agrucoms numeric(1,0)  - agrupar comissao por (OptionGroup)
	this_nParcelas        = 0    && nparcs numeric(3,0)    - numero de parcelas
	this_nParcelas2       = 0    && nparc2s numeric(3,0)   - numero de parcelas (2)
	this_cListaEmpresas   = ""   && listaemp text (NULL)   - lista de empresas selecionadas (memo)
	this_nTipoDesconto    = 0    && tpdesc numeric(2,0)    - tipo de desconto progressivo (ComboBox)

	*-- Propriedades locais (NAO existem no schema de SigOpTdz - apenas estado UI)
	this_cMoeRefDescricao = ""   && nao persiste - descricao da moeda de referencia (lookup exibicao)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigOpTdz"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna PK para auditoria
	*====================================================================
	PROTECTED FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCodigo)
	ENDFUNC

	*====================================================================
	* Buscar - SELECT dos registros de SigOpTdz (filtro opcional por descricao)
	*====================================================================
	FUNCTION Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT codigos, descrs, moerefs, descos" + ;
					   " FROM SigOpTdz"

			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + ;
					" WHERE UPPER(descrs) LIKE UPPER(" + ;
					EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")"
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY codigos"

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarPorCodigo - SELECT registro por chave primaria (codigos)
	*====================================================================
	FUNCTION CarregarPorCodigo(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT codigos, descos, descrs, moerefs, obss," + ;
					   " rel_descs, dtterms, prazoms, chkactb, chkrets," + ;
					   " ajustes, fators, moefats, nchvtbds, descmxs," + ;
					   " abatecus, agrucoms, nparcs, nparc2s, listaemp, tpdesc" + ;
					   " FROM SigOpTdz" + ;
					   " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
				IF loc_lResultado
					THIS.this_lNovoRegistro = .F.
				ENDIF
			ELSE
				IF loc_nResultado < 0
					MsgErro("Erro ao carregar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCodigo         = ALLTRIM(TratarNulo(codigos, "C"))
				THIS.this_nDesconto       = TratarNulo(descos, 0)
				THIS.this_cDescricao      = ALLTRIM(TratarNulo(descrs, "C"))
				THIS.this_cMoeRef         = ALLTRIM(TratarNulo(moerefs, "C"))
				THIS.this_cObservacao     = ALLTRIM(TratarNulo(obss, "C"))
				THIS.this_nRelDesconto    = TratarNulo(rel_descs, 0)
				THIS.this_dDataTermino    = TratarNulo(dtterms, {})
				THIS.this_nPrazoMedio     = TratarNulo(prazoms, 0)
				THIS.this_nChkAcesso      = TratarNulo(chkactb, 0)
				THIS.this_nChkRetorno     = TratarNulo(chkrets, 0)
				THIS.this_nAjuste         = TratarNulo(ajustes, 0)
				THIS.this_nFator          = TratarNulo(fators, 0)
				THIS.this_cMoedaFator     = ALLTRIM(TratarNulo(moefats, "C"))
				THIS.this_nChaveTabDesc   = TratarNulo(nchvtbds, 0)
				THIS.this_nDescontoMaximo = TratarNulo(descmxs, 0)
				THIS.this_nAbateCusto     = TratarNulo(abatecus, 0)
				THIS.this_nAgrupaComissao = TratarNulo(agrucoms, 0)
				THIS.this_nParcelas       = TratarNulo(nparcs, 0)
				THIS.this_nParcelas2      = TratarNulo(nparc2s, 0)
				THIS.this_cListaEmpresas  = ALLTRIM(TratarNulo(listaemp, ""))
				THIS.this_nTipoDesconto   = TratarNulo(tpdesc, 0)

				THIS.this_cMoeRefDescricao = ""

				loc_lResultado = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* Inserir - INSERT INTO SigOpTdz
	*====================================================================
	PROTECTED FUNCTION Inserir()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "INSERT INTO SigOpTdz" + ;
					   " (codigos, descos, descrs, moerefs, obss," + ;
					   " rel_descs, dtterms, prazoms, chkactb, chkrets," + ;
					   " ajustes, fators, moefats, nchvtbds, descmxs," + ;
					   " abatecus, agrucoms, nparcs, nparc2s, listaemp, tpdesc)" + ;
					   " VALUES (" + ;
					   EscaparSQL(THIS.this_cCodigo) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nDesconto, 2) + ", " + ;
					   EscaparSQL(THIS.this_cDescricao) + ", " + ;
					   EscaparSQL(THIS.this_cMoeRef) + ", " + ;
					   EscaparSQL(THIS.this_cObservacao) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nRelDesconto, 0) + ", " + ;
					   FormatarDataSQL(THIS.this_dDataTermino) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nPrazoMedio, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nChkAcesso, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nChkRetorno, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nAjuste, 6) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nFator, 2) + ", " + ;
					   EscaparSQL(THIS.this_cMoedaFator) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nChaveTabDesc, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nDescontoMaximo, 2) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nAbateCusto, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nAgrupaComissao, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nParcelas, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nParcelas2, 0) + ", " + ;
					   EscaparSQL(THIS.this_cListaEmpresas) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nTipoDesconto, 0) + ")"

			*-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
			IF USED("cursor_4c_Ins")
				TABLEREVERT(.T., "cursor_4c_Ins")
				USE IN cursor_4c_Ins
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
			IF USED("cursor_4c_Ins")
				USE IN cursor_4c_Ins
			ENDIF

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* Atualizar - UPDATE SigOpTdz
	*====================================================================
	PROTECTED FUNCTION Atualizar()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigOpTdz SET" + ;
					   " descos     = " + FormatarNumeroSQL(THIS.this_nDesconto, 2) + "," + ;
					   " descrs     = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
					   " moerefs    = " + EscaparSQL(THIS.this_cMoeRef) + "," + ;
					   " obss       = " + EscaparSQL(THIS.this_cObservacao) + "," + ;
					   " rel_descs  = " + FormatarNumeroSQL(THIS.this_nRelDesconto, 0) + "," + ;
					   " dtterms    = " + FormatarDataSQL(THIS.this_dDataTermino) + "," + ;
					   " prazoms    = " + FormatarNumeroSQL(THIS.this_nPrazoMedio, 0) + "," + ;
					   " chkactb    = " + FormatarNumeroSQL(THIS.this_nChkAcesso, 0) + "," + ;
					   " chkrets    = " + FormatarNumeroSQL(THIS.this_nChkRetorno, 0) + "," + ;
					   " ajustes    = " + FormatarNumeroSQL(THIS.this_nAjuste, 6) + "," + ;
					   " fators     = " + FormatarNumeroSQL(THIS.this_nFator, 2) + "," + ;
					   " moefats    = " + EscaparSQL(THIS.this_cMoedaFator) + "," + ;
					   " nchvtbds   = " + FormatarNumeroSQL(THIS.this_nChaveTabDesc, 0) + "," + ;
					   " descmxs    = " + FormatarNumeroSQL(THIS.this_nDescontoMaximo, 2) + "," + ;
					   " abatecus   = " + FormatarNumeroSQL(THIS.this_nAbateCusto, 0) + "," + ;
					   " agrucoms   = " + FormatarNumeroSQL(THIS.this_nAgrupaComissao, 0) + "," + ;
					   " nparcs     = " + FormatarNumeroSQL(THIS.this_nParcelas, 0) + "," + ;
					   " nparc2s    = " + FormatarNumeroSQL(THIS.this_nParcelas2, 0) + "," + ;
					   " listaemp   = " + EscaparSQL(THIS.this_cListaEmpresas) + "," + ;
					   " tpdesc     = " + FormatarNumeroSQL(THIS.this_nTipoDesconto, 0) + ;
					   " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)

			*-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
			IF USED("cursor_4c_Upd")
				TABLEREVERT(.T., "cursor_4c_Upd")
				USE IN cursor_4c_Upd
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
			IF USED("cursor_4c_Upd")
				USE IN cursor_4c_Upd
			ENDIF

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* ObterDescricaoMoeda - Busca a descricao (dmoes) de uma moeda pelo codigo
	* Usado para exibir a descricao da Moeda de Referencia ao carregar registro
	*====================================================================
	FUNCTION ObterDescricaoMoeda(par_cCodigoMoeda)
		LOCAL loc_cDescricao, loc_cSQL, loc_nResultado
		loc_cDescricao = ""

		IF VARTYPE(par_cCodigoMoeda) != "C" OR EMPTY(ALLTRIM(par_cCodigoMoeda))
			RETURN loc_cDescricao
		ENDIF

		TRY
			loc_cSQL = "SELECT dmoes FROM SigCdMoe WHERE cmoes = " + ;
					   EscaparSQL(ALLTRIM(par_cCodigoMoeda))

			IF USED("cursor_4c_Moeda")
				USE IN cursor_4c_Moeda
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Moeda") > 0
				loc_cDescricao = ALLTRIM(TratarNulo(cursor_4c_Moeda.dmoes, "C"))
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.ObterDescricaoMoeda:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Moeda")
			USE IN cursor_4c_Moeda
		ENDIF

		RETURN loc_cDescricao
	ENDFUNC

	*====================================================================
	* CarregarEmpresas - SELECT das empresas (SigCdEmp) para a grade de
	* selecao usada no tipo de desconto 11 (Desconto Gerente-Extra/loja)
	* Popula cursor_4c_Empresas (READWRITE) com coluna virtual nMarca
	*====================================================================
	FUNCTION CarregarEmpresas()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cemps FROM SigCdEmp ORDER BY cemps"

			IF USED("cursor_4c_EmpresasTemp")
				USE IN cursor_4c_EmpresasTemp
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresasTemp")
			IF loc_nResultado >= 0
				IF USED("cursor_4c_Empresas")
					USE IN cursor_4c_Empresas
				ENDIF

				SELECT 0 AS nMarca, cemps ;
					FROM cursor_4c_EmpresasTemp ;
					INTO CURSOR cursor_4c_Empresas READWRITE

				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao carregar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarEmpresas:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_EmpresasTemp")
			USE IN cursor_4c_EmpresasTemp
		ENDIF

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* ExecutarExclusao - DELETE das sub-tabelas (Tdt/Tdi/Tds) + SigOpTdz
	*====================================================================
	PROTECTED FUNCTION ExecutarExclusao()
		LOCAL loc_lResultado, loc_lContinua, loc_cSQL, loc_nResultado
		loc_lResultado = .F.
		loc_lContinua  = .T.

		TRY
			*-- Remove registros das grades relacionadas primeiro (formula/comissao/faixas)
			loc_cSQL = "DELETE FROM SigOpTdt WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
			IF USED("cursor_4c_DelTdt")
				TABLEREVERT(.T., "cursor_4c_DelTdt")
				USE IN cursor_4c_DelTdt
			ENDIF
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdt")
			IF USED("cursor_4c_DelTdt")
				USE IN cursor_4c_DelTdt
			ENDIF

			IF loc_nResultado < 0
				MsgErro("Erro ao excluir formulas da tabela de desconto:" + CHR(13) + ;
						 CapturarErroSQL(), "Erro SQL")
				loc_lContinua = .F.
			ENDIF

			IF loc_lContinua
				loc_cSQL = "DELETE FROM SigOpTdi WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
				IF USED("cursor_4c_DelTdi")
					TABLEREVERT(.T., "cursor_4c_DelTdi")
					USE IN cursor_4c_DelTdi
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdi")
				IF USED("cursor_4c_DelTdi")
					USE IN cursor_4c_DelTdi
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao excluir comissoes da tabela de desconto:" + CHR(13) + ;
							 CapturarErroSQL(), "Erro SQL")
					loc_lContinua = .F.
				ENDIF
			ENDIF

			IF loc_lContinua
				loc_cSQL = "DELETE FROM SigOpTds WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
				IF USED("cursor_4c_DelTds")
					TABLEREVERT(.T., "cursor_4c_DelTds")
					USE IN cursor_4c_DelTds
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTds")
				IF USED("cursor_4c_DelTds")
					USE IN cursor_4c_DelTds
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao excluir faixas de desconto:" + CHR(13) + ;
							 CapturarErroSQL(), "Erro SQL")
					loc_lContinua = .F.
				ENDIF
			ENDIF

			IF loc_lContinua
				*-- Remove o registro principal
				loc_cSQL = "DELETE FROM SigOpTdz WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
				IF USED("cursor_4c_Del")
					TABLEREVERT(.T., "cursor_4c_Del")
					USE IN cursor_4c_Del
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
				IF USED("cursor_4c_Del")
					USE IN cursor_4c_Del
				ENDIF

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("DELETE")
					loc_lResultado = .T.
				ELSE
					MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + ;
							 CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarComposicaoDesconto - SELECT das linhas de formula/tipo
	* (SigOpTdt) do codigo corrente, usadas como mestre pela grade
	* Gradei da pagina "Configuracao de Desconto" (somente leitura la) e
	* pela grade editavel Gradei da pagina "Descontos / Comissoes"
	* (grd_4c_Gradei em ConfigurarPgPgDesconto - fonte da verdade para
	* incluir/alterar/excluir linhas de composicao).
	* Popula cursor_4c_Tdt (READWRITE) com coluna virtual "regs" (flag
	* de linha corrente, equivalente ao "regs" do legado). Inclui TODAS
	* as colunas NOT NULL de SigOpTdt (cidchaves, formulas 1a/2a, moedas,
	* tpcomis, descfats, fatorpads, chkcots, tpunidade, chkmultcot) para
	* que SalvarComposicaoDesconto() consiga regravar a linha completa.
	*====================================================================
	FUNCTION CarregarComposicaoDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, codigos, tipos, codtips, tipods, descos, dfators," + ;
					   " texclus, faixas, finicias, ffinals," + ;
					   " campo1t1s, campo2t1s, campo3t1s, oper1t1s, oper2t1s," + ;
					   " const1t1s, const2t1s, const3t1s, moeda1s," + ;
					   " campo1t2s, campo2t2s, campo3t2s, oper1t2s, oper2t2s," + ;
					   " const1t2s, const2t2s, const3t2s, moeda2s, moeda3s," + ;
					   " tpcomis, descfats, fatorpads, chkcots, tpunidade, chkmultcot" + ;
					   " FROM SigOpTdt WHERE codigos = " + EscaparSQL(par_cCodigo) + ;
					   " ORDER BY codigos, tipos, codtips"

			IF USED("cursor_4c_TdtTemp")
				USE IN cursor_4c_TdtTemp
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TdtTemp")
			IF loc_nResultado >= 0
				IF USED("cursor_4c_Tdt")
					USE IN cursor_4c_Tdt
				ENDIF

				SELECT 0 AS regs, * ;
					FROM cursor_4c_TdtTemp ;
					INTO CURSOR cursor_4c_Tdt READWRITE

				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao carregar composi" + CHR(231) + CHR(227) + "o de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarComposicaoDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_TdtTemp")
			USE IN cursor_4c_TdtTemp
		ENDIF

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarFaixasDesconto - SELECT de TODAS as faixas de horario/dia/
	* mes/data (SigOpTds) do codigo corrente. O form filtra localmente
	* (SET FILTER) pela combinacao tipos+codtips+tipods da linha corrente
	* de cursor_4c_Tdt - mesmo padrao do legado (CrSigOpTds carregado 1x
	* no Init, filtrado via Set Key a cada troca de linha da grade mestre).
	* Popula cursor_4c_Tds (READWRITE).
	*====================================================================
	FUNCTION CarregarFaixasDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, codigos, tipos, codtips, tipods," + ;
					   " campo1is, campo1fs, campo2is, campo2fs," + ;
					   " campo3is, campo3fs, campo4is, campo4fs," + ;
					   " descos, dfators, nchvtbds" + ;
					   " FROM SigOpTds WHERE codigos = " + EscaparSQL(par_cCodigo) + ;
					   " ORDER BY codigos, tipos, codtips, tipods"

			IF USED("cursor_4c_Tds")
				USE IN cursor_4c_Tds
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tds")
			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao carregar faixas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarFaixasDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		*-- cursor_4c_Tds precisa ser READWRITE para APPEND/REPLACE feitos
		*-- na grade GradeD - o cursor de saida do SQLEXEC ja e editavel,
		*-- mas garantimos a existencia mesmo sem linhas retornadas
		IF loc_lResultado AND USED("cursor_4c_Tds") AND RECCOUNT("cursor_4c_Tds") = 0
			*-- SQLEXEC sem linhas ainda cria a estrutura do cursor - ok
		ENDIF

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* SalvarFaixasDesconto - Grava (substitui) as faixas de horario/dia/
	* mes/data (SigOpTds) do codigo corrente a partir do conteudo atual
	* de cursor_4c_Tds. Estrategia DELETE + INSERT (mesmo padrao usado
	* em ExecutarExclusao para as sub-tabelas relacionadas).
	*====================================================================
	FUNCTION SalvarFaixasDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		IF !USED("cursor_4c_Tds")
			RETURN .T.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigOpTds WHERE codigos = " + EscaparSQL(par_cCodigo)
			IF USED("cursor_4c_DelTdsSalvar")
				USE IN cursor_4c_DelTdsSalvar
			ENDIF
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdsSalvar")
			IF USED("cursor_4c_DelTdsSalvar")
				USE IN cursor_4c_DelTdsSalvar
			ENDIF

			IF loc_nResultado < 0
				MsgErro("Erro ao substituir faixas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				loc_lResultado = .F.
			ENDIF

			loc_lResultado = .T.

			SELECT cursor_4c_Tds
			*-- O form filtra localmente (SET FILTER) pela combinacao
			*-- Tipo/Codigo/TipoDesconto exibida em grd_4c_GradeD - ao gravar
			*-- e preciso considerar TODAS as combinacoes, nao so a ultima
			*-- filtrada
			SET FILTER TO
			SCAN FOR !DELETED()
				loc_cSQL = "INSERT INTO SigOpTds (cidchaves, codigos, tipos, codtips, tipods," + ;
						   " campo1is, campo1fs, campo2is, campo2fs, campo3is, campo3fs," + ;
						   " campo4is, campo4fs, descos, dfators, nchvtbds) VALUES (" + ;
						   EscaparSQL(NVL(cursor_4c_Tds.cidchaves, fUniqueIds())) + ", " + ;
						   EscaparSQL(par_cCodigo) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.tipos, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.codtips) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.tipods, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo1is) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo1fs) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo2is) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo2fs) + ", " + ;
						   FormatarDataSQL(cursor_4c_Tds.campo3is) + ", " + ;
						   FormatarDataSQL(cursor_4c_Tds.campo3fs) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo4is) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo4fs) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.descos, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.dfators, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.nchvtbds, 0) + ")"

				IF USED("cursor_4c_InsTds")
					USE IN cursor_4c_InsTds
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsTds")
				IF USED("cursor_4c_InsTds")
					USE IN cursor_4c_InsTds
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao gravar faixa de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lResultado = .F.
					EXIT
				ENDIF
			ENDSCAN
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.SalvarFaixasDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarComissoesDesconto - SELECT de TODAS as comissoes por grupo/
	* conta (SigOpTdi) do codigo corrente. O form filtra localmente
	* (SET FILTER) pela combinacao tipos+codtips da linha corrente de
	* cursor_4c_Tdt (grd_4c_Gradei da pagina "Descontos / Comissoes"),
	* mesmo padrao usado para cursor_4c_Tds (MontarConfiguracaoDesconto).
	* Popula cursor_4c_Tdi (READWRITE - saida do SQLEXEC ja e editavel).
	*====================================================================
	FUNCTION CarregarComissoesDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, codigos, tipos, codtips, grupos, contas," + ;
					   " moedas, pintegrals, pdivididas, patendes" + ;
					   " FROM SigOpTdi WHERE codigos = " + EscaparSQL(par_cCodigo) + ;
					   " ORDER BY codigos, tipos, codtips"

			IF USED("cursor_4c_Tdi")
				USE IN cursor_4c_Tdi
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tdi")
			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao carregar comiss" + CHR(245) + "es de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarComissoesDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* SalvarComposicaoDesconto - Grava (substitui) as linhas de formula/
	* tipo (SigOpTdt) do codigo corrente a partir do conteudo atual de
	* cursor_4c_Tdt (grd_4c_Gradei editavel da pagina "Descontos /
	* Comissoes"). Estrategia DELETE + INSERT (mesmo padrao de
	* SalvarFaixasDesconto). tpunidade/chkmultcot nao tem controle na UI
	* (sem uso no legado migrado) - gravados como 0.
	*====================================================================
	FUNCTION SalvarComposicaoDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		IF !USED("cursor_4c_Tdt")
			RETURN .T.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigOpTdt WHERE codigos = " + EscaparSQL(par_cCodigo)
			IF USED("cursor_4c_DelTdtSalvar")
				USE IN cursor_4c_DelTdtSalvar
			ENDIF
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdtSalvar")
			IF USED("cursor_4c_DelTdtSalvar")
				USE IN cursor_4c_DelTdtSalvar
			ENDIF

			IF loc_nResultado < 0
				MsgErro("Erro ao substituir composi" + CHR(231) + CHR(227) + "o de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				loc_lResultado = .F.
			ENDIF

			loc_lResultado = .T.

			SELECT cursor_4c_Tdt
			SCAN FOR !DELETED()
				loc_cSQL = "INSERT INTO SigOpTdt (cidchaves, codigos, tipos, codtips, tipods," + ;
						   " descos, dfators, texclus, faixas, finicias, ffinals," + ;
						   " campo1t1s, campo2t1s, campo3t1s, oper1t1s, oper2t1s," + ;
						   " const1t1s, const2t1s, const3t1s, moeda1s," + ;
						   " campo1t2s, campo2t2s, campo3t2s, oper1t2s, oper2t2s," + ;
						   " const1t2s, const2t2s, const3t2s, moeda2s, moeda3s," + ;
						   " tpcomis, descfats, fatorpads, chkcots, tpunidade, chkmultcot)" + ;
						   " VALUES (" + ;
						   EscaparSQL(NVL(cursor_4c_Tdt.cidchaves, fUniqueIds())) + ", " + ;
						   EscaparSQL(par_cCodigo) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.tipos, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.codtips) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.tipods, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.descos, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.dfators, 2) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.texclus) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.faixas, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.finicias, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.ffinals, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo1t1s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo2t1s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo3t1s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.oper1t1s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.oper2t1s, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const1t1s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const2t1s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const3t1s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.moeda1s) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo1t2s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo2t2s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo3t2s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.oper1t2s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.oper2t2s, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const1t2s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const2t2s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const3t2s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.moeda2s) + ", " + ;
						   EscaparSQL(NVL(cursor_4c_Tdt.moeda3s, "")) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.tpcomis, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.descfats) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.fatorpads, 3) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.chkcots, 0) + ", " + ;
						   FormatarNumeroSQL(NVL(cursor_4c_Tdt.tpunidade, 0), 0) + ", " + ;
						   FormatarNumeroSQL(NVL(cursor_4c_Tdt.chkmultcot, 0), 0) + ")"

				IF USED("cursor_4c_InsTdt")
					USE IN cursor_4c_InsTdt
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsTdt")
				IF USED("cursor_4c_InsTdt")
					USE IN cursor_4c_InsTdt
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao gravar linha de composi" + CHR(231) + CHR(227) + "o de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lResultado = .F.
					EXIT
				ENDIF
			ENDSCAN
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.SalvarComposicaoDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* SalvarComissoesDesconto - Grava (substitui) as comissoes por grupo/
	* conta (SigOpTdi) do codigo corrente a partir do conteudo atual de
	* cursor_4c_Tdi (grd_4c_Gradec da pagina "Descontos / Comissoes").
	* Estrategia DELETE + INSERT (mesmo padrao de SalvarFaixasDesconto).
	*====================================================================
	FUNCTION SalvarComissoesDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		IF !USED("cursor_4c_Tdi")
			RETURN .T.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigOpTdi WHERE codigos = " + EscaparSQL(par_cCodigo)
			IF USED("cursor_4c_DelTdiSalvar")
				USE IN cursor_4c_DelTdiSalvar
			ENDIF
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdiSalvar")
			IF USED("cursor_4c_DelTdiSalvar")
				USE IN cursor_4c_DelTdiSalvar
			ENDIF

			IF loc_nResultado < 0
				MsgErro("Erro ao substituir comiss" + CHR(245) + "es de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				loc_lResultado = .F.
			ENDIF

			loc_lResultado = .T.

			SELECT cursor_4c_Tdi
			SET FILTER TO
			SCAN FOR !DELETED()
				loc_cSQL = "INSERT INTO SigOpTdi (cidchaves, codigos, tipos, codtips," + ;
						   " grupos, contas, moedas, pintegrals, pdivididas, patendes) VALUES (" + ;
						   EscaparSQL(NVL(cursor_4c_Tdi.cidchaves, fUniqueIds())) + ", " + ;
						   EscaparSQL(par_cCodigo) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdi.tipos, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdi.codtips) + ", " + ;
						   EscaparSQL(cursor_4c_Tdi.grupos) + ", " + ;
						   EscaparSQL(cursor_4c_Tdi.contas) + ", " + ;
						   EscaparSQL(cursor_4c_Tdi.moedas) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdi.pintegrals, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdi.pdivididas, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdi.patendes, 2) + ")"

				IF USED("cursor_4c_InsTdi")
					USE IN cursor_4c_InsTdi
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsTdi")
				IF USED("cursor_4c_InsTdi")
					USE IN cursor_4c_InsTdi
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao gravar comiss" + CHR(227) + "o de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lResultado = .F.
					EXIT
				ENDIF
			ENDSCAN
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.SalvarComissoesDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

ENDDEFINE

