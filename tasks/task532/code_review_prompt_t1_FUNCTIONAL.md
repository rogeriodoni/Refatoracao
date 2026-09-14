# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (54)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_CONTAINER1, CNT_4C_PGCONFDESCONTO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BINDEVENT-PARAMS] Handler 'GradeiConfColumn3LostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE GradeiConfColumn3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [METODO-INEXISTENTE] Metodo 'THIS.FormatarHorarioValidado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.FaixaTemInicial()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TipoDesconto' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_DiaSemana' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH loc_oGD define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGD.RecordSource).
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTbv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4212 linhas total):

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

*-- Linhas 197 a 416:
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
387:                 CREATE CURSOR cursor_4c_Dados (codigos C(10), descrs C(30), moerefs C(3), descos N(5,2))
388:                 INSERT INTO cursor_4c_Dados VALUES ("0000000001", "Tabela Teste", "REA", 0)
389:                 SET DATASESSION TO (loc_nDsAtual)
390:                 loc_lResultado = .T.
391:             ELSE
392:                 IF THIS.this_oBusinessObject.Buscar("")
393:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
394: 
395:                     loc_oGrid.ColumnCount   = 4
396:                     loc_oGrid.RecordSource  = "cursor_4c_Dados"
397: 
398:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
399:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
400:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.moerefs"
401:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.descos"
402: 
403:                     loc_oGrid.Column1.Width         = 110
404:                     loc_oGrid.Column2.Width         = 480
405:                     loc_oGrid.Column3.Width         = 100
406:                     loc_oGrid.Column4.Width         = 130
407: 
408:                     loc_oGrid.Column1.ReadOnly      = .T.
409:                     loc_oGrid.Column2.ReadOnly      = .T.
410:                     loc_oGrid.Column3.ReadOnly      = .T.
411:                     loc_oGrid.Column4.ReadOnly      = .T.
412: 
413:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
414:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
415:                     loc_oGrid.Column3.Header1.Caption = "Moeda Ref" + CHR(234) + "ncia"
416:                     loc_oGrid.Column4.Header1.Caption = "Desconto (%)"

*-- Linhas 430 a 568:
430:     *--------------------------------------------------------------------------
431:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
432:     *--------------------------------------------------------------------------
433:     PROCEDURE AlternarPagina(par_nPagina)
434:         LOCAL loc_lResultado
435:         loc_lResultado = .F.
436: 
437:         TRY
438:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
439:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
440:                 IF par_nPagina = 1
441:                     THIS.CarregarLista()
442:                 ENDIF
443:                 loc_lResultado = .T.
444:             ENDIF
445:         CATCH TO loException
446:             MostrarErro(loException, "FormTbv.AlternarPagina")
447:             loc_lResultado = .F.
448:         ENDTRY
449: 
450:         RETURN loc_lResultado
451:     ENDPROC
452: 
453:     *--------------------------------------------------------------------------
454:     * ConfigurarPaginaDados - Configura Page2 (Dados)
455:     * cnt_4c_BotoesAcao: Top=4+29=33, Left=834, Width=160, Height=85
456:     *
457:     * Campos principais (aba interna legado "pgDados"): a aba ficava dentro de
458:     * um PageFrame interno (Pagina.Dados.Page1, Top=122) que por sua vez estava
459:     * dentro do PageFrame externo (Top=-29). Compensacao total = 122 + 29 = 151.
460:     * FASE 5/8: primeiros 50% dos campos (Codigo/Descricao/MoedaRef/Desconto/
461:     * Observacao/ValidoAte/Parcelas/Ajuste/Fator/MoedaFator).
462:     * FASE 6/8 completa os campos restantes (OptionGroups, ComboBox, grid empresas).
463:     *--------------------------------------------------------------------------
464:     PROTECTED PROCEDURE ConfigurarPaginaDados()
465:         LOCAL loc_oPagina
466:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
467: 
468:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
469: 
470:         *-- Container de botoes de acao (Grupo_Salva: Left=834, Top=4 -> 33)
471:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
472:         WITH loc_oPagina.cnt_4c_BotoesAcao
473:             .Top         = 33
474:             .Left        = 834
475:             .Width       = 160
476:             .Height      = 85
477:             .BackStyle   = 0
478:             .BorderWidth = 0
479:             .Visible     = .T.
480:         ENDWITH
481: 
482:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
483:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
484:             .Caption         = "Confirmar"
485:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
486:             .PicturePosition = 13
487:             .Top             = 5
488:             .Left            = 5
489:             .Width           = 75
490:             .Height          = 75
491:             .BackColor       = RGB(255, 255, 255)
492:             .ForeColor       = RGB(90, 90, 90)
493:             .FontName        = "Tahoma"
494:             .FontSize        = 8
495:             .FontBold        = .T.
496:             .FontItalic      = .T.
497:             .Themes          = .F.
498:             .SpecialEffect   = 0
499:             .MousePointer    = 15
500:             .WordWrap        = .T.
501:             .AutoSize        = .F.
502:             .Visible         = .T.
503:         ENDWITH
504:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
505: 
506:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
507:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
508:             .Caption         = "Encerrar"
509:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
510:             .PicturePosition = 13
511:             .Top             = 5
512:             .Left            = 80
513:             .Width           = 75
514:             .Height          = 75
515:             .BackColor       = RGB(255, 255, 255)
516:             .ForeColor       = RGB(90, 90, 90)
517:             .FontName        = "Tahoma"
518:             .FontSize        = 8
519:             .FontBold        = .T.
520:             .FontItalic      = .T.
521:             .Themes          = .F.
522:             .SpecialEffect   = 0
523:             .MousePointer    = 15
524:             .WordWrap        = .T.
525:             .AutoSize        = .F.
526:             .Visible         = .T.
527:         ENDWITH
528:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
529: 
530:         *----------------------------------------------------------------------
531:         * Codigo (PK) - this_cCodigo / codigos char(10)
532:         * Legado: pgDados.get_codigos (top=23,left=264) + lbl_codigos (top=30,left=218)
533:         *----------------------------------------------------------------------
534:         loc_oPagina.AddObject("lbl_4c_Lbl_codigos", "Label")
535:         WITH loc_oPagina.lbl_4c_Lbl_codigos
536:             .Caption   = "C" + CHR(243) + "digo :"
537:             .Top       = 181
538:             .Left      = 218
539:             .Width     = 42
540:             .Height    = 17
541:             .BackStyle = 0
542:             .ForeColor = RGB(90, 90, 90)
543:             .FontName  = "Tahoma"
544:             .FontSize  = 8
545:             .Alignment = 1
546:             .Visible   = .T.
547:         ENDWITH
548: 
549:         loc_oPagina.AddObject("txt_4c__codigos", "TextBox")
550:         WITH loc_oPagina.txt_4c__codigos
551:             .Top       = 174
552:             .Left      = 264
553:             .Width     = 80
554:             .Height    = 18
555:             .MaxLength = 10
556:             .Value     = ""
557:             .FontName  = "Tahoma"
558:             .FontSize  = 8
559:             .Visible   = .T.
560:         ENDWITH
561: 
562:         *----------------------------------------------------------------------
563:         * Descricao - this_cDescricao / descrs char(30)
564:         * Legado: get_descrs (top=49,left=264,width=220) + lbl_descrs (top=56,left=205)
565:         *----------------------------------------------------------------------
566:         loc_oPagina.AddObject("lbl_4c_Lbl_descrs", "Label")
567:         WITH loc_oPagina.lbl_4c_Lbl_descrs
568:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"

*-- Linhas 623 a 667:
623:             .FontSize  = 8
624:             .Visible   = .T.
625:         ENDWITH
626:         BINDEVENT(loc_oPagina.txt_4c__moerefs, "KeyPress", THIS, "MoedaRefLookupKeyPress")
627:         BINDEVENT(loc_oPagina.txt_4c__moerefs, "DblClick", THIS, "MoedaRefLookupDblClick")
628: 
629:         loc_oPagina.AddObject("txt_4c__moerefs_desc", "TextBox")
630:         WITH loc_oPagina.txt_4c__moerefs_desc
631:             .Top       = 226
632:             .Left      = 298
633:             .Width     = 115
634:             .Height    = 18
635:             .MaxLength = 20
636:             .Value     = ""
637:             .ReadOnly  = .T.
638:             .TabStop   = .F.
639:             .FontName  = "Tahoma"
640:             .FontSize  = 8
641:             .Visible   = .T.
642:         ENDWITH
643: 
644:         *----------------------------------------------------------------------
645:         * Desconto (%) - this_nDesconto / descos numeric(5,2)
646:         * Legado: get_descos (top=101,left=264,width=66) + lbl_descos (top=107,left=206)
647:         *----------------------------------------------------------------------
648:         loc_oPagina.AddObject("lbl_4c_Lbl_descos", "Label")
649:         WITH loc_oPagina.lbl_4c_Lbl_descos
650:             .Caption   = "Desconto :"
651:             .Top       = 258
652:             .Left      = 206
653:             .Width     = 54
654:             .Height    = 17
655:             .BackStyle = 0
656:             .ForeColor = RGB(90, 90, 90)
657:             .FontName  = "Tahoma"
658:             .FontSize  = 8
659:             .Alignment = 1
660:             .Visible   = .T.
661:         ENDWITH
662: 
663:         loc_oPagina.AddObject("txt_4c__descos", "TextBox")
664:         WITH loc_oPagina.txt_4c__descos
665:             .Top       = 252
666:             .Left      = 264
667:             .Width     = 66

*-- Linhas 894 a 938:
894:             .FontSize  = 8
895:             .Visible   = .T.
896:         ENDWITH
897:         BINDEVENT(loc_oPagina.txt_4c_MoeFat, "KeyPress", THIS, "MoedaFatorLookupKeyPress")
898:         BINDEVENT(loc_oPagina.txt_4c_MoeFat, "DblClick", THIS, "MoedaFatorLookupDblClick")
899: 
900:         *----------------------------------------------------------------------
901:         * Prazo Medio - this_nPrazoMedio / prazoms numeric(3,0) - "sem uso" no legado
902:         * Legado: Get_PrazoMs (top=419,left=527,width=31,Visible=.F.) + Say2 (top=425,left=466,Visible=.F.)
903:         * Mantido oculto para paridade de schema/BO (campo existe na tabela mas nao e usado)
904:         *----------------------------------------------------------------------
905:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
906:         WITH loc_oPagina.lbl_4c_Label2
907:             .Caption   = "sem uso :"
908:             .Top       = 576
909:             .Left      = 466
910:             .Width     = 59
911:             .Height    = 15
912:             .BackStyle = 0
913:             .ForeColor = RGB(255, 0, 0)
914:             .FontName  = "Tahoma"
915:             .FontSize  = 8
916:             .Visible   = .F.
917:         ENDWITH
918: 
919:         loc_oPagina.AddObject("txt_4c_PrazoMs", "TextBox")
920:         WITH loc_oPagina.txt_4c_PrazoMs
921:             .Top       = 570
922:             .Left      = 527
923:             .Width     = 31
924:             .Height    = 18
925:             .InputMask = "999"
926:             .Alignment = 1
927:             .Value     = 0
928:             .FontName  = "Courier New"
929:             .FontSize  = 8
930:             .Visible   = .F.
931:         ENDWITH
932: 
933:         *----------------------------------------------------------------------
934:         * Imprime no Rel. Tab.Desconto - this_nRelDesconto / rel_descs numeric(1,0)
935:         * Legado: opt_rel_descs (top=305,left=261,width=86,height=23) + lbl_imprime (top=309,left=106)
936:         *----------------------------------------------------------------------
937:         loc_oPagina.AddObject("lbl_4c_Lbl_imprime", "Label")
938:         WITH loc_oPagina.lbl_4c_Lbl_imprime

*-- Linhas 948 a 991:
948:             .Visible   = .T.
949:         ENDWITH
950: 
951:         loc_oPagina.AddObject("obj_4c_Opt_rel_descs", "OptionGroup")
952:         WITH loc_oPagina.obj_4c_Opt_rel_descs
953:             .Top         = 456
954:             .Left        = 261
955:             .Width       = 91
956:             .Height      = 23
957:             .ButtonCount = 2
958:             .BackStyle   = 0
959:             .BorderStyle = 0
960:             .Value       = 1
961:             .Visible     = .T.
962:         ENDWITH
963:         WITH loc_oPagina.obj_4c_Opt_rel_descs.Buttons(1)
964:             .Caption   = "Sim"
965:             .Left      = 2
966:             .Top       = 4
967:             .Width     = 34
968:             .AutoSize  = .T.
969:             .FontName  = "Tahoma"
970:             .FontSize  = 8
971:             .ForeColor = RGB(90, 90, 90)
972:             .BackStyle = 0
973:             .Themes    = .F.
974:         ENDWITH
975:         WITH loc_oPagina.obj_4c_Opt_rel_descs.Buttons(2)
976:             .Caption   = "N" + CHR(227) + "o"
977:             .Left      = 44
978:             .Top       = 4
979:             .Width     = 37
980:             .AutoSize  = .T.
981:             .FontName  = "Tahoma"
982:             .FontSize  = 8
983:             .ForeColor = RGB(90, 90, 90)
984:             .BackStyle = 0
985:             .Themes    = .F.
986:         ENDWITH
987: 
988:         *----------------------------------------------------------------------
989:         * Checar Acesso - this_nChkAcesso / chkactb numeric(1,0)
990:         * Legado: Chk_Acesso (top=282,left=261,width=86,height=23) + Say4 (top=286,left=180)
991:         *----------------------------------------------------------------------

*-- Linhas 1003 a 1046:
1003:             .Visible   = .T.
1004:         ENDWITH
1005: 
1006:         loc_oPagina.AddObject("obj_4c_Chk_Acesso", "OptionGroup")
1007:         WITH loc_oPagina.obj_4c_Chk_Acesso
1008:             .Top         = 433
1009:             .Left        = 261
1010:             .Width       = 91
1011:             .Height      = 23
1012:             .ButtonCount = 2
1013:             .BackStyle   = 0
1014:             .BorderStyle = 0
1015:             .Value       = 1
1016:             .Visible     = .T.
1017:         ENDWITH
1018:         WITH loc_oPagina.obj_4c_Chk_Acesso.Buttons(1)
1019:             .Caption   = "Sim"
1020:             .Left      = 2
1021:             .Top       = 4
1022:             .Width     = 34
1023:             .AutoSize  = .T.
1024:             .FontName  = "Tahoma"
1025:             .FontSize  = 8
1026:             .ForeColor = RGB(90, 90, 90)
1027:             .BackStyle = 0
1028:             .Themes    = .F.
1029:         ENDWITH
1030:         WITH loc_oPagina.obj_4c_Chk_Acesso.Buttons(2)
1031:             .Caption   = "N" + CHR(227) + "o"
1032:             .Left      = 44
1033:             .Top       = 4
1034:             .Width     = 37
1035:             .AutoSize  = .T.
1036:             .FontName  = "Tahoma"
1037:             .FontSize  = 8
1038:             .ForeColor = RGB(90, 90, 90)
1039:             .BackStyle = 0
1040:             .Themes    = .F.
1041:         ENDWITH
1042: 
1043:         *----------------------------------------------------------------------
1044:         * Aplicado Na Quantidade de Produtos - this_nChkRetorno / chkrets numeric(1,0)
1045:         * Legado: chkAplicado (top=235,left=314,width=194,height=15)
1046:         *----------------------------------------------------------------------

*-- Linhas 1078 a 1121:
1078:             .Visible   = .T.
1079:         ENDWITH
1080: 
1081:         loc_oPagina.AddObject("obj_4c_OptAbateCus", "OptionGroup")
1082:         WITH loc_oPagina.obj_4c_OptAbateCus
1083:             .Top         = 480
1084:             .Left        = 261
1085:             .Width       = 91
1086:             .Height      = 23
1087:             .ButtonCount = 2
1088:             .BackStyle   = 0
1089:             .BorderStyle = 0
1090:             .Value       = 2
1091:             .Visible     = .T.
1092:         ENDWITH
1093:         WITH loc_oPagina.obj_4c_OptAbateCus.Buttons(1)
1094:             .Caption   = "Sim"
1095:             .Left      = 2
1096:             .Top       = 4
1097:             .Width     = 34
1098:             .AutoSize  = .T.
1099:             .FontName  = "Tahoma"
1100:             .FontSize  = 8
1101:             .ForeColor = RGB(90, 90, 90)
1102:             .BackStyle = 0
1103:             .Themes    = .F.
1104:         ENDWITH
1105:         WITH loc_oPagina.obj_4c_OptAbateCus.Buttons(2)
1106:             .Caption   = "N" + CHR(227) + "o"
1107:             .Left      = 44
1108:             .Top       = 4
1109:             .Width     = 37
1110:             .AutoSize  = .T.
1111:             .FontName  = "Tahoma"
1112:             .FontSize  = 8
1113:             .ForeColor = RGB(90, 90, 90)
1114:             .BackStyle = 0
1115:             .Themes    = .F.
1116:         ENDWITH
1117: 
1118:         *----------------------------------------------------------------------
1119:         * Agrupar Comissao por - this_nAgrupaComissao / agrucoms numeric(1,0)
1120:         * Legado: opt_agrucoms (top=351,left=258,width=164,height=25) + Say6 (top=355,left=145)
1121:         *----------------------------------------------------------------------

*-- Linhas 1133 a 1176:
1133:             .Visible   = .T.
1134:         ENDWITH
1135: 
1136:         loc_oPagina.AddObject("obj_4c_Opt_agrucoms", "OptionGroup")
1137:         WITH loc_oPagina.obj_4c_Opt_agrucoms
1138:             .Top         = 502
1139:             .Left        = 258
1140:             .Width       = 169
1141:             .Height      = 25
1142:             .ButtonCount = 2
1143:             .BackStyle   = 0
1144:             .BorderStyle = 0
1145:             .Value       = 1
1146:             .Visible     = .T.
1147:         ENDWITH
1148:         WITH loc_oPagina.obj_4c_Opt_agrucoms.Buttons(1)
1149:             .Caption   = "Linha"
1150:             .Left      = 5
1151:             .Top       = 5
1152:             .Width     = 43
1153:             .AutoSize  = .T.
1154:             .FontName  = "Tahoma"
1155:             .FontSize  = 8
1156:             .ForeColor = RGB(90, 90, 90)
1157:             .BackStyle = 0
1158:             .Themes    = .F.
1159:         ENDWITH
1160:         WITH loc_oPagina.obj_4c_Opt_agrucoms.Buttons(2)
1161:             .Caption   = "Grupo de Vendas"
1162:             .Left      = 59
1163:             .Top       = 5
1164:             .Width     = 100
1165:             .AutoSize  = .T.
1166:             .FontName  = "Tahoma"
1167:             .FontSize  = 8
1168:             .ForeColor = RGB(90, 90, 90)
1169:             .BackStyle = 0
1170:             .Themes    = .F.
1171:         ENDWITH
1172: 
1173:         *----------------------------------------------------------------------
1174:         * Tipo de desconto progressivo - this_nTipoDesconto / tpdesc numeric(2,0)
1175:         * Legado: cmbTpDesc (RowSource=crTpDesc, top=378,left=264,width=221,height=21) + Say11 (top=381,left=107)
1176:         *----------------------------------------------------------------------

*-- Linhas 1196 a 1251:
1196:             .Left           = 264
1197:             .Width          = 221
1198:             .Height         = 21
1199:             .Style          = 2
1200:             .RowSourceType  = 6
1201:             .RowSource      = "cursor_4c_TipoDesconto.Descrs,cursor_4c_TipoDesconto.Ordem"
1202:             .ColumnCount    = 2
1203:             .ColumnWidths   = "205,0"
1204:             .BoundColumn    = 2
1205:             .Value          = 0
1206:             .ToolTipText    = "Usado Para diversas tabelas para um mesmo item"
1207:             .FontName       = "Tahoma"
1208:             .FontSize       = 8
1209:             .Visible        = .T.
1210:         ENDWITH
1211:         BINDEVENT(loc_oPagina.cbo_4c_CmbTpDesc, "InteractiveChange", THIS, "TipoDescontoInteractiveChange")
1212: 
1213:         *----------------------------------------------------------------------
1214:         * Container1 / GrdEmp - Lista de empresas para tipo de desconto 11
1215:         * (Desconto Gerente-Extra/loja) - this_cListaEmpresas / listaemp memo
1216:         * Legado: Container1 (top=354,left=608,width=289,height=97), visivel apenas
1217:         * quando cmbTpDesc = 11 (ThisForm...container1.visible = tpdesc=11)
1218:         *----------------------------------------------------------------------
1219:         LOCAL loc_oGridEmp
1220: 
1221:         loc_oPagina.AddObject("cnt_4c_Container1", "Container")
1222:         WITH loc_oPagina.cnt_4c_Container1
1223:             .Top       = 505
1224:             .Left      = 608
1225:             .Width     = 289
1226:             .Height    = 97
1227:             .BackStyle = 0
1228:             .Visible   = .F.
1229:         ENDWITH
1230: 
1231:         loc_oPagina.cnt_4c_Container1.AddObject("grd_4c_Empresas", "Grid")
1232:         loc_oGridEmp = loc_oPagina.cnt_4c_Container1.grd_4c_Empresas
1233:         loc_oGridEmp.RecordSource = ""
1234:         loc_oGridEmp.ColumnCount  = 2
1235:         WITH loc_oGridEmp
1236:             .Top          = 3
1237:             .Left         = 6
1238:             .Width        = 228
1239:             .Height       = 90
1240:             .FontName     = "Verdana"
1241:             .FontSize     = 8
1242:             .DeleteMark   = .F.
1243:             .RecordMark   = .F.
1244:             .GridLines    = 3
1245:             .HeaderHeight = 0
1246:             .RowHeight    = 18
1247:             .ScrollBars   = 2
1248:             .Visible      = .T.
1249:         ENDWITH
1250: 
1251:         WITH loc_oGridEmp.Column1

*-- Linhas 1272 a 1390:
1272:         ENDWITH
1273:         loc_oGridEmp.Column2.Header1.Caption = "Empresa"
1274: 
1275:         BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "MouseDown", THIS, "EmpresaCheckboxMouseDown")
1276:         BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "MouseUp",   THIS, "EmpresaCheckboxMouseUp")
1277:         BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "Click",     THIS, "EmpresaCheckboxClick")
1278:         BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "KeyPress",  THIS, "EmpresaCheckboxKeyPress")
1279: 
1280:         loc_oPagina.cnt_4c_Container1.AddObject("cmd_4c_Command1", "CommandButton")
1281:         WITH loc_oPagina.cnt_4c_Container1.cmd_4c_Command1
1282:             .Caption     = ""
1283:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1284:             .ToolTipText = "Desmarcar"
1285:             .Top         = 48
1286:             .Left        = 239
1287:             .Width       = 45
1288:             .Height      = 45
1289:             .BackColor   = RGB(255, 255, 255)
1290:             .ForeColor   = RGB(36, 84, 155)
1291:             .FontName    = "Verdana"
1292:             .FontSize    = 8
1293:             .Themes      = .F.
1294:             .Visible     = .T.
1295:         ENDWITH
1296:         BINDEVENT(loc_oPagina.cnt_4c_Container1.cmd_4c_Command1, "Click", THIS, "BtnEmpresasDesmarcarClick")
1297: 
1298:         loc_oPagina.cnt_4c_Container1.AddObject("cmd_4c_Command2", "CommandButton")
1299:         WITH loc_oPagina.cnt_4c_Container1.cmd_4c_Command2
1300:             .Caption     = ""
1301:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1302:             .ToolTipText = "Selecionar"
1303:             .Top         = 4
1304:             .Left        = 239
1305:             .Width       = 45
1306:             .Height      = 45
1307:             .BackColor   = RGB(255, 255, 255)
1308:             .ForeColor   = RGB(36, 84, 155)
1309:             .FontName    = "Verdana"
1310:             .FontSize    = 8
1311:             .Themes      = .F.
1312:             .Visible     = .T.
1313:         ENDWITH
1314:         BINDEVENT(loc_oPagina.cnt_4c_Container1.cmd_4c_Command2, "Click", THIS, "BtnEmpresasMarcarClick")
1315: 
1316:         *----------------------------------------------------------------------
1317:         * pgDesconto / PgConfDesconto (2a/3a sub-paginas do PageFrame interno
1318:         * do legado) - migradas como containers flutuantes sobre a mesma
1319:         * Page2 (mesmo padrao de cnt_4c_Container1), pois pgDados ja ocupa a
1320:         * Page2 sem PageFrame interno. Ocultas por padrao ate existir
1321:         * alternancia de sub-abas (nao ha selecao de sub-pagina no legado -
1322:         * as 3 ficam sempre visiveis simultaneamente dentro do PageFrame
1323:         * interno "Page1"; aqui mantemos apenas pgDados visivel de inicio
1324:         * e as demais ocultas ate um mecanismo de troca ser adicionado).
1325:         *----------------------------------------------------------------------
1326:         THIS.ConfigurarPgPgDesconto()
1327:         THIS.ConfigurarPgPgConfDesconto()
1328: 
1329:         THIS.TornarControlesVisiveis(loc_oPagina)
1330:         loc_oPagina.cnt_4c_Container1.Visible = .F.
1331:         loc_oPagina.cnt_4c_PgDesconto.Visible = .F.
1332:         loc_oPagina.cnt_4c_PgConfDesconto.Visible = .F.
1333:     ENDPROC
1334: 
1335:     *--------------------------------------------------------------------------
1336:     * ConfigurarPgPgConfDesconto - Controles da 3a sub-pagina do legado
1337:     * ("Configuracao de Desconto" - SIGCDTBV.Pagina.Dados.Page1.PgConfDesconto)
1338:     *
1339:     * Grade mestre (grd_4c_GradeI) espelha as linhas de SigOpTdt (tipo/codigo/
1340:     * tipo de desconto progressivo) cadastradas via grd_4c_Gradei da aba
1341:     * "Descontos / Comissoes" (ConfigurarPgPgDesconto - MESMA cursor_4c_Tdt).
1342:     * Colunas Tipo/Codigo sao SOMENTE LEITURA aqui (legado: Column1/2.When
1343:     * sempre Return(.f.)); apenas a coluna "Tipos Desconto" e editavel.
1344:     *
1345:     * Grade de detalhe (grd_4c_GradeD) mostra/edita as faixas (SigOpTds) da
1346:     * combinacao tipo+codigo+tipoDesconto selecionada na grade mestre,
1347:     * reconfigurando colunas conforme MontarConfiguracaoDesconto() (equiva-
1348:     * lente ao "MontaTbDes" do legado).
1349:     *--------------------------------------------------------------------------
1350:     PROTECTED PROCEDURE ConfigurarPgPgConfDesconto()
1351:         LOCAL loc_oPg, loc_oGradei, loc_oGradeD
1352: 
1353:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1354: 
1355:         *-- Registros excluidos da grade de faixas (BtnExcluirFaixaDescontoClick)
1356:         *-- nao devem reaparecer - DataSession=2 (privado) isola este SET do
1357:         *-- resto do sistema (CLAUDE.md #9.4)
1358:         SET DELETED ON
1359: 
1360:         THIS.CriarCursorDiaSemana()
1361: 
1362:         loc_oPg.AddObject("cnt_4c_PgConfDesconto", "Container")
1363:         WITH loc_oPg.cnt_4c_PgConfDesconto
1364:             .Top       = 151
1365:             .Left      = -1
1366:             .Width     = 1004
1367:             .Height    = 482
1368:             .BackStyle = 0
1369:             .Visible   = .T.
1370:         ENDWITH
1371: 
1372:         *----------------------------------------------------------------------
1373:         * Rotulos de cabecalho das colunas (Label1/Label2/lb_desconto)
1374:         *----------------------------------------------------------------------
1375:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("lbl_4c_Label1", "Label")
1376:         WITH loc_oPg.cnt_4c_PgConfDesconto.lbl_4c_Label1
1377:             .Caption    = "Hor" + CHR(225) + "rio"
1378:             .Top        = 11
1379:             .Left       = 622
1380:             .Width      = 83
1381:             .Height     = 16
1382:             .Alignment  = 2
1383:             .BackStyle  = 1
1384:             .BorderStyle = 1
1385:             .FontName   = "Tahoma"
1386:             .FontSize   = 8
1387:             .FontBold   = .T.
1388:             .WordWrap   = .T.
1389:             .ForeColor  = RGB(90, 90, 90)
1390:             .BackColor  = RGB(240, 240, 240)

*-- Linhas 1505 a 1703:
1505:         ENDWITH
1506:         loc_oGradei.Column3.CurrentControl = "cbo_4c_GiTipoDs"
1507: 
1508:         BINDEVENT(loc_oGradei, "AfterRowColChange", THIS, "GradeiConfAfterRowColChange")
1509:         BINDEVENT(loc_oGradei.Column3.cbo_4c_GiTipoDs, "When", THIS, "GradeiConfColumn3When")
1510:         BINDEVENT(loc_oGradei.Column3.cbo_4c_GiTipoDs, "LostFocus", THIS, "GradeiConfColumn3Valid")
1511:         BINDEVENT(loc_oGradei.Column3.cbo_4c_GiTipoDs, "KeyPress", THIS, "GradeiConfColumn3LostFocus")
1512: 
1513:         *----------------------------------------------------------------------
1514:         * grd_4c_GradeD - grade de detalhe (espelha SigOpTds da combinacao
1515:         * selecionada em grd_4c_GradeI). Colunas 1/2 (Inicial/Final) tem
1516:         * ControlSource/InputMask reconfigurados dinamicamente por
1517:         * MontarConfiguracaoDesconto() conforme o Tipo de Desconto (dia da
1518:         * semana/dia do mes/horario/data). Colunas 3/4 sao a faixa de
1519:         * horario dentro do dia (sempre Campo2is/Campo2fs); 5/6 sao
1520:         * Preco/Fator.
1521:         *----------------------------------------------------------------------
1522:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("grd_4c_GradeD", "Grid")
1523:         loc_oGradeD = loc_oPg.cnt_4c_PgConfDesconto.grd_4c_GradeD
1524:         loc_oGradeD.RecordSource = ""
1525:         loc_oGradeD.ColumnCount  = 6
1526:         WITH loc_oGradeD
1527:             .Top        = 26
1528:             .Left       = 462
1529:             .Width      = 358
1530:             .Height     = 419
1531:             .FontName   = "Verdana"
1532:             .FontSize   = 8
1533:             .RowHeight  = 20
1534:             .RecordMark = .F.
1535:             .ForeColor  = RGB(36, 84, 155)
1536:             .Enabled    = .F.
1537:             .Visible    = .T.
1538:         ENDWITH
1539: 
1540:         WITH loc_oGradeD.Column1
1541:             .Width             = 79
1542:             .Header1.Caption   = "Inicial"
1543:             .Header1.Alignment = 2
1544:             .Header1.FontName  = "Verdana"
1545:             .Header1.FontSize  = 8
1546:             .Text1.Top         = 32
1547:             .Text1.Height      = 23
1548:             .Text1.Margin      = 2
1549:             .Text1.ForeColor   = RGB(36, 84, 155)
1550:         ENDWITH
1551:         BINDEVENT(loc_oGradeD.Column1.Text1, "When", THIS, "GradeDColumn1When")
1552:         BINDEVENT(loc_oGradeD.Column1.Text1, "Valid", THIS, "GradeDColumn1Valid")
1553: 
1554:         WITH loc_oGradeD.Column2
1555:             .Width             = 79
1556:             .Header1.Caption   = "Final"
1557:             .Header1.Alignment = 2
1558:             .Header1.FontName  = "Verdana"
1559:             .Header1.FontSize  = 8
1560:             .Text1.BorderStyle = 0
1561:             .Text1.Margin      = 2
1562:             .Text1.ForeColor   = RGB(36, 84, 155)
1563:         ENDWITH
1564:         BINDEVENT(loc_oGradeD.Column2.Text1, "When", THIS, "GradeDColumn2When")
1565:         BINDEVENT(loc_oGradeD.Column2.Text1, "Valid", THIS, "GradeDColumn2Valid")
1566: 
1567:         WITH loc_oGradeD.Column3
1568:             .Width             = 40
1569:             .Header1.Caption   = "Inicial"
1570:             .Header1.Alignment = 2
1571:             .Header1.FontName  = "Verdana"
1572:             .Header1.FontSize  = 8
1573:             .ControlSource     = "cursor_4c_Tds.Campo2is"
1574:             .Format            = "R"
1575:             .InputMask         = "99:99"
1576:             .Text1.InputMask   = "99:99"
1577:         ENDWITH
1578:         BINDEVENT(loc_oGradeD.Column3.Text1, "When", THIS, "GradeDColumn3When")
1579:         BINDEVENT(loc_oGradeD.Column3.Text1, "Valid", THIS, "GradeDColumn3Valid")
1580: 
1581:         WITH loc_oGradeD.Column4
1582:             .Width             = 40
1583:             .Header1.Caption   = "Final"
1584:             .Header1.Alignment = 2
1585:             .Header1.FontName  = "Verdana"
1586:             .Header1.FontSize  = 8
1587:             .ControlSource     = "cursor_4c_Tds.Campo2fs"
1588:             .Format            = "R"
1589:             .InputMask         = "99:99"
1590:             .Text1.InputMask   = "99:99"
1591:         ENDWITH
1592:         BINDEVENT(loc_oGradeD.Column4.Text1, "When", THIS, "GradeDColumn4When")
1593:         BINDEVENT(loc_oGradeD.Column4.Text1, "Valid", THIS, "GradeDColumn4Valid")
1594: 
1595:         WITH loc_oGradeD.Column5
1596:             .Width             = 48
1597:             .Header1.Caption   = "Pre" + CHR(231) + "o"
1598:             .Header1.Alignment = 2
1599:             .Header1.FontName  = "Verdana"
1600:             .Header1.FontSize  = 8
1601:             .ControlSource     = "cursor_4c_Tds.descos"
1602:             .InputMask         = "999.99"
1603:             .Text1.InputMask   = "999.99"
1604:         ENDWITH
1605:         BINDEVENT(loc_oGradeD.Column5.Text1, "When", THIS, "GradeDColumn5When")
1606: 
1607:         WITH loc_oGradeD.Column6
1608:             .Width             = 46
1609:             .Header1.Caption   = "Fator"
1610:             .Header1.Alignment = 2
1611:             .Header1.FontName  = "Verdana"
1612:             .Header1.FontSize  = 8
1613:             .ControlSource     = "cursor_4c_Tds.dfators"
1614:             .InputMask         = "999.99"
1615:             .Text1.InputMask   = "999.99"
1616:         ENDWITH
1617:         BINDEVENT(loc_oGradeD.Column6.Text1, "When", THIS, "GradeDColumn5When")
1618:         BINDEVENT(loc_oGradeD.Column6.Text1, "Valid", THIS, "GradeDColumn6Valid")
1619: 
1620:         *----------------------------------------------------------------------
1621:         * cmdExcluir - remove a faixa corrente de grd_4c_GradeD
1622:         *----------------------------------------------------------------------
1623:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("cmd_4c_CmdExcluir", "CommandButton")
1624:         WITH loc_oPg.cnt_4c_PgConfDesconto.cmd_4c_CmdExcluir
1625:             .Caption         = ""
1626:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1627:             .ToolTipText     = "Excluir"
1628:             .PicturePosition = 1
1629:             .Top             = 203
1630:             .Left            = 832
1631:             .Width           = 45
1632:             .Height          = 45
1633:             .BackColor       = RGB(255, 255, 255)
1634:             .ForeColor       = RGB(36, 84, 155)
1635:             .FontName        = "Verdana"
1636:             .FontSize        = 8
1637:             .Themes          = .F.
1638:             .Visible         = .T.
1639:         ENDWITH
1640:         BINDEVENT(loc_oPg.cnt_4c_PgConfDesconto.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirFaixaDescontoClick")
1641:     ENDPROC
1642: 
1643:     *--------------------------------------------------------------------------
1644:     * ConfigurarPgPgDesconto - Controles da 2a sub-pagina do legado
1645:     * ("Descontos / Comissoes" - SIGCDTBV.Pagina.Dados.Page1.pgDesconto)
1646:     *
1647:     * grd_4c_Gradei (8 colunas) e a grade MESTRE editavel de composicao/
1648:     * formula (SigOpTdt via cursor_4c_Tdt) - inclui/altera/exclui linhas
1649:     * (Tipo/Codigo/Valor/Fator/Exclui/Faixa/Inicial/Final). E a MESMA
1650:     * cursor_4c_Tdt usada (somente leitura) por grd_4c_GradeI da pagina
1651:     * "Configuracao de Desconto" (ConfigurarPgPgConfDesconto).
1652:     *
1653:     * grd_4c_Gradec (6 colunas) mostra as comissoes por grupo/conta
1654:     * (SigOpTdi via cursor_4c_Tdi) da linha corrente de grd_4c_Gradei
1655:     * (filtro local via MontarComissoesDesconto - equivalente ao
1656:     * "MontaTbCom" do legado).
1657:     *
1658:     * cnt_4c_Formula1/cnt_4c_Formula2 mostram a 1a/2a formula de calculo
1659:     * (Campo/Operador/Constante/Moeda) da linha corrente de grd_4c_Gradei,
1660:     * bindados diretamente via ControlSource a cursor_4c_Tdt (mesmo padrao
1661:     * usado pelas colunas de grd_4c_GradeD em ConfigurarPgPgConfDesconto).
1662:     *--------------------------------------------------------------------------
1663:     PROTECTED PROCEDURE ConfigurarPgPgDesconto()
1664:         LOCAL loc_oPg, loc_oCnt, loc_oGradei, loc_oGradec, loc_oF1, loc_oF2
1665: 
1666:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1667: 
1668:         loc_oPg.AddObject("cnt_4c_PgDesconto", "Container")
1669:         loc_oCnt = loc_oPg.cnt_4c_PgDesconto
1670:         WITH loc_oCnt
1671:             .Top       = 151
1672:             .Left      = -1
1673:             .Width     = 1004
1674:             .Height    = 482
1675:             .BackStyle = 0
1676:             .Visible   = .T.
1677:         ENDWITH
1678: 
1679:         *----------------------------------------------------------------------
1680:         * Label2 - cabecalho "Descontos" (acima de grd_4c_Gradei)
1681:         *----------------------------------------------------------------------
1682:         loc_oCnt.AddObject("lbl_4c_Descontos", "Label")
1683:         WITH loc_oCnt.lbl_4c_Descontos
1684:             .Caption   = "Descontos"
1685:             .Top       = 2
1686:             .Left      = 4
1687:             .Width     = 59
1688:             .Height    = 15
1689:             .BackStyle = 0
1690:             .FontName  = "Tahoma"
1691:             .FontSize  = 8
1692:             .FontBold  = .T.
1693:             .WordWrap  = .T.
1694:             .ForeColor = RGB(90, 90, 90)
1695:             .Visible   = .T.
1696:         ENDWITH
1697: 
1698:         *----------------------------------------------------------------------
1699:         * grd_4c_Gradei - grade MESTRE editavel de composicao (cursor_4c_Tdt)
1700:         *----------------------------------------------------------------------
1701:         loc_oCnt.AddObject("grd_4c_Gradei", "Grid")
1702:         loc_oGradei = loc_oCnt.grd_4c_Gradei
1703:         loc_oGradei.RecordSource = ""

*-- Linhas 1733 a 1906:
1733:             .BackColor       = RGB(255, 255, 255)
1734:         ENDWITH
1735:         loc_oGradei.Column1.CurrentControl = "cbo_4c_GiTipo"
1736:         BINDEVENT(loc_oGradei.Column1.cbo_4c_GiTipo, "When", THIS, "GradeiDescColunaEditavelWhen")
1737: 
1738:         WITH loc_oGradei.Column2
1739:             .Width             = 100
1740:             .Header1.Caption   = "C" + CHR(243) + "digo "
1741:             .Header1.Alignment = 2
1742:             .Header1.FontName  = "Verdana"
1743:             .Header1.FontSize  = 8
1744:             .Text1.BorderStyle = 0
1745:             .Text1.Margin      = 2
1746:             .Text1.ForeColor   = RGB(36, 84, 155)
1747:             .Text1.BackColor   = RGB(255, 255, 255)
1748:         ENDWITH
1749:         BINDEVENT(loc_oGradei.Column2.Text1, "When",     THIS, "GradeiDescColunaEditavelWhen")
1750:         BINDEVENT(loc_oGradei.Column2.Text1, "KeyPress",  THIS, "GradeiDescCodigoKeyPress")
1751:         BINDEVENT(loc_oGradei.Column2.Text1, "DblClick",  THIS, "GradeiDescCodigoDblClick")
1752: 
1753:         WITH loc_oGradei.Column3
1754:             .Width             = 55
1755:             .Header1.Caption   = "Valor"
1756:             .Header1.Alignment = 2
1757:             .Header1.FontName  = "Verdana"
1758:             .Header1.FontSize  = 8
1759:             .InputMask         = "9999.99"
1760:             .Text1.InputMask   = "9999.99"
1761:             .Text1.ForeColor   = RGB(36, 84, 155)
1762:         ENDWITH
1763:         BINDEVENT(loc_oGradei.Column3.Text1, "When", THIS, "GradeiDescColunaEditavelWhen")
1764: 
1765:         WITH loc_oGradei.Column4
1766:             .Width             = 55
1767:             .Header1.Caption   = "Fator"
1768:             .Header1.Alignment = 2
1769:             .Header1.FontName  = "Verdana"
1770:             .Header1.FontSize  = 8
1771:             .InputMask         = "9999.99"
1772:             .Text1.InputMask   = "9999.99"
1773:             .Text1.ForeColor   = RGB(36, 84, 155)
1774:         ENDWITH
1775:         BINDEVENT(loc_oGradei.Column4.Text1, "When", THIS, "GradeiDescColunaEditavelWhen")
1776: 
1777:         WITH loc_oGradei.Column5
1778:             .Width             = 17
1779:             .Header1.Caption   = "E"
1780:             .Header1.Alignment = 2
1781:             .Header1.FontName  = "Verdana"
1782:             .Header1.FontSize  = 8
1783:             .Header1.ToolTipText = "Exclui - N" + CHR(227) + "o calcula desconto"
1784:             .Text1.ForeColor   = RGB(36, 84, 155)
1785:             .Text1.MaxLength   = 1
1786:         ENDWITH
1787:         BINDEVENT(loc_oGradei.Column5.Text1, "When",  THIS, "GradeiDescColunaEditavelWhen")
1788:         BINDEVENT(loc_oGradei.Column5.Text1, "Valid", THIS, "GradeiDescColumn5Valid")
1789: 
1790:         WITH loc_oGradei.Column6
1791:             .Width             = 66
1792:             .Header1.Caption   = "Faixa"
1793:             .Header1.Alignment = 2
1794:             .Header1.FontName  = "Verdana"
1795:             .Header1.FontSize  = 8
1796:         ENDWITH
1797:         loc_oGradei.Column6.AddObject("cbo_4c_GiFaixa", "ComboBox")
1798:         WITH loc_oGradei.Column6.cbo_4c_GiFaixa
1799:             .Top             = 18
1800:             .Left            = 28
1801:             .SpecialEffect   = 1
1802:             .RowSourceType   = 1
1803:             .RowSource       = "Nenhuma,Qtde,Peso,Tot.Peso"
1804:             .Style           = 2
1805:             .ForeColor       = RGB(36, 84, 155)
1806:         ENDWITH
1807:         loc_oGradei.Column6.CurrentControl = "cbo_4c_GiFaixa"
1808: 
1809:         WITH loc_oGradei.Column7
1810:             .Width             = 38
1811:             .Header1.Caption   = "Inicial"
1812:             .Header1.Alignment = 2
1813:             .Header1.FontName  = "Verdana"
1814:             .Header1.FontSize  = 8
1815:             .Text1.ForeColor   = RGB(0, 0, 0)
1816:         ENDWITH
1817: 
1818:         WITH loc_oGradei.Column8
1819:             .Width             = 38
1820:             .Header1.Caption   = "Final"
1821:             .Header1.Alignment = 2
1822:             .Header1.FontName  = "Verdana"
1823:             .Header1.FontSize  = 8
1824:             .Text1.ForeColor   = RGB(0, 0, 0)
1825:         ENDWITH
1826: 
1827:         BINDEVENT(loc_oGradei, "AfterRowColChange", THIS, "GradeiDescAfterRowColChange")
1828: 
1829:         *----------------------------------------------------------------------
1830:         * inserir/excluir - incluem/removem linhas de composicao (cursor_4c_Tdt)
1831:         *----------------------------------------------------------------------
1832:         loc_oCnt.AddObject("cmd_4c_InserirComposicao", "CommandButton")
1833:         WITH loc_oCnt.cmd_4c_InserirComposicao
1834:             .Caption   = ""
1835:             .Picture   = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1836:             .Top       = 296
1837:             .Left      = 5
1838:             .Width     = 40
1839:             .Height    = 40
1840:             .BackColor = RGB(255, 255, 255)
1841:             .ForeColor = RGB(36, 84, 155)
1842:             .FontName  = "Verdana"
1843:             .FontSize  = 8
1844:             .FontBold  = .T.
1845:             .Themes    = .F.
1846:             .Visible   = .T.
1847:         ENDWITH
1848:         BINDEVENT(loc_oCnt.cmd_4c_InserirComposicao, "Click", THIS, "BtnInserirComposicaoClick")
1849: 
1850:         loc_oCnt.AddObject("cmd_4c_ExcluirComposicao", "CommandButton")
1851:         WITH loc_oCnt.cmd_4c_ExcluirComposicao
1852:             .Caption   = ""
1853:             .Picture   = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1854:             .Top       = 296
1855:             .Left      = 45
1856:             .Width     = 40
1857:             .Height    = 40
1858:             .BackColor = RGB(255, 255, 255)
1859:             .ForeColor = RGB(36, 84, 155)
1860:             .FontName  = "Verdana"
1861:             .FontSize  = 8
1862:             .FontBold  = .T.
1863:             .Themes    = .F.
1864:             .Visible   = .T.
1865:         ENDWITH
1866:         BINDEVENT(loc_oCnt.cmd_4c_ExcluirComposicao, "Click", THIS, "BtnExcluirComposicaoClick")
1867: 
1868:         *----------------------------------------------------------------------
1869:         * cnt_4c_Formula1 / cnt_4c_Formula2 - 1a/2a formula de calculo
1870:         * (Campo/Operador/Constante/Moeda), bindadas a cursor_4c_Tdt.*t1s/*t2s
1871:         *----------------------------------------------------------------------
1872:         loc_oCnt.AddObject("cnt_4c_Formula1", "Container")
1873:         loc_oF1 = loc_oCnt.cnt_4c_Formula1
1874:         WITH loc_oF1
1875:             .Top         = 365
1876:             .Left        = 27
1877:             .Width       = 945
1878:             .Height      = 37
1879:             .BackStyle   = 0
1880:             .SpecialEffect = 2
1881:             .BackColor   = RGB(255, 255, 255)
1882:             .Visible     = .T.
1883:         ENDWITH
1884:         THIS.ConfigurarFormulaDesconto(loc_oF1, "t1s", "Primeira F" + CHR(243) + "rmula :")
1885: 
1886:         loc_oCnt.AddObject("cnt_4c_Formula2", "Container")
1887:         loc_oF2 = loc_oCnt.cnt_4c_Formula2
1888:         WITH loc_oF2
1889:             .Top         = 415
1890:             .Left        = 27
1891:             .Width       = 945
1892:             .Height      = 37
1893:             .BackStyle   = 0
1894:             .SpecialEffect = 2
1895:             .BackColor   = RGB(255, 255, 255)
1896:             .Visible     = .T.
1897:         ENDWITH
1898:         THIS.ConfigurarFormulaDesconto(loc_oF2, "t2s", "Segunda F" + CHR(243) + "rmula :")
1899: 
1900:         *----------------------------------------------------------------------
1901:         * Desconto Maximo (crSigOpTdz.descmxs - registro principal, NAO a
1902:         * linha corrente de composicao) - this_nDescontoMaximo no BO
1903:         *----------------------------------------------------------------------
1904:         loc_oCnt.AddObject("lbl_4c_DescontoMaximo", "Label")
1905:         WITH loc_oCnt.lbl_4c_DescontoMaximo
1906:             .Caption   = "Desconto M" + CHR(225) + "ximo :"

*-- Linhas 1992 a 2129:
1992:             .Header1.FontSize  = 8
1993:             .Text1.ForeColor   = RGB(0, 0, 0)
1994:         ENDWITH
1995:         BINDEVENT(loc_oGradec.Column1.Text1, "Valid", THIS, "GradecColumn1Valid")
1996: 
1997:         WITH loc_oGradec.Column2
1998:             .Width             = 100
1999:             .Header1.Caption   = "Conta"
2000:             .Header1.Alignment = 2
2001:             .Header1.FontName  = "Verdana"
2002:             .Header1.FontSize  = 8
2003:             .InputMask         = "XXXXXXXXXX"
2004:             .Text1.InputMask   = "XXXXXXXXXX"
2005:             .Text1.ForeColor   = RGB(0, 0, 0)
2006:         ENDWITH
2007:         BINDEVENT(loc_oGradec.Column2.Text1, "Valid", THIS, "GradecColumn2Valid")
2008: 
2009:         WITH loc_oGradec.Column3
2010:             .Width             = 55
2011:             .Header1.Caption   = "Integral"
2012:             .Header1.Alignment = 2
2013:             .Header1.FontName  = "Verdana"
2014:             .Header1.FontSize  = 8
2015:             .InputMask         = "999.99"
2016:             .Text1.InputMask   = "999.99"
2017:             .Text1.ForeColor   = RGB(0, 0, 0)
2018:         ENDWITH
2019: 
2020:         WITH loc_oGradec.Column4
2021:             .Width             = 55
2022:             .Header1.Caption   = "Dividida"
2023:             .Header1.Alignment = 2
2024:             .Header1.FontName  = "Verdana"
2025:             .Header1.FontSize  = 8
2026:             .InputMask         = "999.99"
2027:             .Text1.InputMask   = "999.99"
2028:             .Text1.ForeColor   = RGB(0, 0, 0)
2029:         ENDWITH
2030: 
2031:         WITH loc_oGradec.Column5
2032:             .Width             = 55
2033:             .Header1.Caption   = "Atendim"
2034:             .Header1.Alignment = 2
2035:             .Header1.FontName  = "Verdana"
2036:             .Header1.FontSize  = 8
2037:             .InputMask         = "999.99"
2038:             .Text1.InputMask   = "999.99"
2039:             .Text1.ForeColor   = RGB(0, 0, 0)
2040:         ENDWITH
2041: 
2042:         WITH loc_oGradec.Column6
2043:             .Width             = 30
2044:             .Header1.Caption   = "Moe"
2045:             .Header1.Alignment = 2
2046:             .Header1.FontName  = "Verdana"
2047:             .Header1.FontSize  = 8
2048:             .Text1.ForeColor   = RGB(0, 0, 0)
2049:             .Text1.BackColor   = RGB(255, 255, 255)
2050:         ENDWITH
2051: 
2052:         *----------------------------------------------------------------------
2053:         * Inscomis/exccomis - incluem/removem comissoes (cursor_4c_Tdi)
2054:         *----------------------------------------------------------------------
2055:         loc_oCnt.AddObject("cmd_4c_InserirComissao", "CommandButton")
2056:         WITH loc_oCnt.cmd_4c_InserirComissao
2057:             .Caption   = ""
2058:             .Picture   = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2059:             .Top       = 296
2060:             .Left      = 577
2061:             .Width     = 40
2062:             .Height    = 40
2063:             .BackColor = RGB(255, 255, 255)
2064:             .ForeColor = RGB(36, 84, 155)
2065:             .FontName  = "Verdana"
2066:             .FontSize  = 8
2067:             .FontBold  = .T.
2068:             .Themes    = .F.
2069:             .Visible   = .T.
2070:         ENDWITH
2071:         BINDEVENT(loc_oCnt.cmd_4c_InserirComissao, "Click", THIS, "BtnInserirComissaoClick")
2072: 
2073:         loc_oCnt.AddObject("cmd_4c_ExcluirComissao", "CommandButton")
2074:         WITH loc_oCnt.cmd_4c_ExcluirComissao
2075:             .Caption   = ""
2076:             .Picture   = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2077:             .Top       = 296
2078:             .Left      = 617
2079:             .Width     = 40
2080:             .Height    = 40
2081:             .BackColor = RGB(255, 255, 255)
2082:             .ForeColor = RGB(36, 84, 155)
2083:             .FontName  = "Verdana"
2084:             .FontSize  = 8
2085:             .FontBold  = .T.
2086:             .Themes    = .F.
2087:             .Visible   = .T.
2088:         ENDWITH
2089:         BINDEVENT(loc_oCnt.cmd_4c_ExcluirComissao, "Click", THIS, "BtnExcluirComissaoClick")
2090: 
2091:         *----------------------------------------------------------------------
2092:         * Combo_Comis / getDescFats / getFatorPads / chkAplicado(Ignora
2093:         * cotacao) - bindados a cursor_4c_Tdt.* (linha corrente de composicao)
2094:         *----------------------------------------------------------------------
2095:         loc_oCnt.AddObject("lbl_4c_Comissao", "Label")
2096:         WITH loc_oCnt.lbl_4c_Comissao
2097:             .Caption   = "Comiss" + CHR(227) + "o:"
2098:             .Top       = 342
2099:             .Left      = 555
2100:             .Width     = 59
2101:             .Height    = 15
2102:             .BackStyle = 0
2103:             .FontName  = "Tahoma"
2104:             .FontSize  = 8
2105:             .FontBold  = .T.
2106:             .ForeColor = RGB(90, 90, 90)
2107:             .Visible   = .T.
2108:         ENDWITH
2109: 
2110:         loc_oCnt.AddObject("cbo_4c_ComboComis", "ComboBox")
2111:         WITH loc_oCnt.cbo_4c_ComboComis
2112:             .Top            = 338
2113:             .Left           = 617
2114:             .Width          = 161
2115:             .Height         = 23
2116:             .Style          = 2
2117:             .RowSourceType  = 1
2118:             .RowSource      = "Normal,Pelo Custo,Pelo Feitio"
2119:             .ControlSource  = "cursor_4c_Tdt.tpcomis"
2120:             .FontName       = "Tahoma"
2121:             .FontSize       = 8
2122:             .Visible        = .T.
2123:         ENDWITH
2124: 
2125:         loc_oCnt.AddObject("lbl_4c_DescritivoFator", "Label")
2126:         WITH loc_oCnt.lbl_4c_DescritivoFator
2127:             .Caption   = "Descritivo de Fator :"
2128:             .Top       = 342
2129:             .Left      = 20

*-- Linhas 2197 a 2252:
2197:             .Visible       = .T.
2198:         ENDWITH
2199: 
2200:         THIS.TornarControlesVisiveis(loc_oCnt)
2201:     ENDPROC
2202: 
2203:     *--------------------------------------------------------------------------
2204:     * ConfigurarFormulaDesconto - Cria os controles de uma formula (1a/2a)
2205:     * dentro do container informado, bindados a cursor_4c_Tdt.*<sufixo>
2206:     * (sufixo "t1s" ou "t2s"). Espelha o container F?rmula1/F?rmula2 do
2207:     * legado: Campo1/Oper1/Campo2/Oper2/Campo3/Const1/Const2/Const3/Moeda.
2208:     * Visible dos campos 2/3 (encadeados) e recalculado dinamicamente pelo
2209:     * legado via Refresh(); aqui simplificado para SEMPRE visivel (o
2210:     * usuario ve os 3 campos da formula e preenche os que precisar).
2211:     *--------------------------------------------------------------------------
2212:     PROTECTED PROCEDURE ConfigurarFormulaDesconto(par_oCnt, par_cSufixo, par_cLabel)
2213:         WITH par_oCnt
2214:             .AddObject("lbl_4c_TituloFormula", "Label")
2215:             WITH .lbl_4c_TituloFormula
2216:                 .Caption   = par_cLabel
2217:                 .Top       = 12
2218:                 .Left      = 14
2219:                 .Width     = 106
2220:                 .Height    = 15
2221:                 .BackStyle = 0
2222:                 .FontName  = "Tahoma"
2223:                 .FontSize  = 8
2224:                 .FontBold  = .T.
2225:                 .ForeColor = RGB(90, 90, 90)
2226:                 .Visible   = .T.
2227:             ENDWITH
2228: 
2229:             .AddObject("cbo_4c_Campo1", "ComboBox")
2230:             WITH .cbo_4c_Campo1
2231:                 .Top           = 7
2232:                 .Left          = 145
2233:                 .Width         = 127
2234:                 .Height        = 24
2235:                 .Style         = 2
2236:                 .SpecialEffect = 1
2237:                 .RowSourceType = 1
2238:                 .RowSource     = "Nenhum,Peso,Fator,Pre" + CHR(231) + "o,Constante,Quantidade,Comprimento"
2239:                 .ControlSource = "cursor_4c_Tdt.campo1" + par_cSufixo
2240:                 .BackColor     = RGB(220, 211, 194)
2241:                 .FontName      = "Tahoma"
2242:                 .FontSize      = 8
2243:                 .Visible       = .T.
2244:             ENDWITH
2245: 
2246:             .AddObject("cbo_4c_Oper1", "ComboBox")
2247:             WITH .cbo_4c_Oper1
2248:                 .Top           = 7
2249:                 .Left          = 283
2250:                 .Width         = 39
2251:                 .Height        = 24
2252:                 .Style         = 2

*-- Linhas 2389 a 2509:
2389:     *--------------------------------------------------------------------------
2390:     * FormParaBO - Transfere dados do Form para Business Object
2391:     *--------------------------------------------------------------------------
2392:     PROCEDURE FormParaBO()
2393:         LOCAL loc_oPg
2394: 
2395:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2396: 
2397:         WITH THIS.this_oBusinessObject
2398:             .this_cCodigo         = ALLTRIM(loc_oPg.txt_4c__codigos.Value)
2399:             .this_cDescricao      = ALLTRIM(loc_oPg.txt_4c__descrs.Value)
2400:             .this_cMoeRef         = ALLTRIM(loc_oPg.txt_4c__moerefs.Value)
2401:             .this_nDesconto       = loc_oPg.txt_4c__descos.Value
2402:             .this_cObservacao     = ALLTRIM(loc_oPg.txt_4c__obss.Value)
2403:             .this_nRelDesconto    = loc_oPg.obj_4c_Opt_rel_descs.Value
2404:             .this_dDataTermino    = loc_oPg.txt_4c_Dtval.Value
2405:             .this_nPrazoMedio     = loc_oPg.txt_4c_PrazoMs.Value
2406:             .this_nChkAcesso      = loc_oPg.obj_4c_Chk_Acesso.Value
2407:             .this_nChkRetorno     = IIF(loc_oPg.chk_4c_ChkAplicado.Value = 1, 1, 0)
2408:             .this_nAjuste         = loc_oPg.txt_4c_Ajuste.Value
2409:             .this_nFator          = loc_oPg.txt_4c_Fator.Value
2410:             .this_cMoedaFator     = ALLTRIM(loc_oPg.txt_4c_MoeFat.Value)
2411:             .this_nAbateCusto     = loc_oPg.obj_4c_OptAbateCus.Value
2412:             .this_nAgrupaComissao = loc_oPg.obj_4c_Opt_agrucoms.Value
2413:             .this_nParcelas       = loc_oPg.txt_4c_NParcs.Value
2414:             .this_nParcelas2      = loc_oPg.txt_4c_NParc2s.Value
2415:             .this_nTipoDesconto   = loc_oPg.cbo_4c_CmbTpDesc.Value
2416:             .this_cListaEmpresas  = THIS.MontarListaEmpresas()
2417:             .this_nDescontoMaximo = loc_oPg.cnt_4c_PgDesconto.txt_4c_DescontoMaximo.Value
2418:         ENDWITH
2419:     ENDPROC
2420: 
2421:     *--------------------------------------------------------------------------
2422:     * BOParaForm - Transfere dados do Business Object para Form
2423:     *--------------------------------------------------------------------------
2424:     PROCEDURE BOParaForm()
2425:         LOCAL loc_oPg
2426: 
2427:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2428: 
2429:         WITH THIS.this_oBusinessObject
2430:             loc_oPg.txt_4c__codigos.Value       = .this_cCodigo
2431:             loc_oPg.txt_4c__descrs.Value        = .this_cDescricao
2432:             loc_oPg.txt_4c__moerefs.Value       = .this_cMoeRef
2433:             loc_oPg.txt_4c__moerefs_desc.Value  = THIS.this_oBusinessObject.ObterDescricaoMoeda(.this_cMoeRef)
2434:             loc_oPg.txt_4c__descos.Value        = .this_nDesconto
2435:             loc_oPg.txt_4c__obss.Value          = .this_cObservacao
2436:             *-- Legado forca Rel_Descs=2 (Nao) em registro novo (INSERIR/PROCURAR)
2437:             loc_oPg.obj_4c_Opt_rel_descs.Value  = IIF(.this_nRelDesconto = 0, 2, .this_nRelDesconto)
2438:             loc_oPg.txt_4c_Dtval.Value          = .this_dDataTermino
2439:             loc_oPg.txt_4c_PrazoMs.Value        = .this_nPrazoMedio
2440:             loc_oPg.obj_4c_Chk_Acesso.Value     = .this_nChkAcesso
2441:             loc_oPg.chk_4c_ChkAplicado.Value    = (.this_nChkRetorno .Value    = IIF(.this_nChkRetorno = 1, 1, 0))
2442:             loc_oPg.txt_4c_Ajuste.Value         = .this_nAjuste
2443:             loc_oPg.txt_4c_Fator.Value          = .this_nFator
2444:             loc_oPg.txt_4c_MoeFat.Value         = .this_cMoedaFator
2445:             loc_oPg.obj_4c_OptAbateCus.Value    = IIF(.this_nAbateCusto = 0, 2, .this_nAbateCusto)
2446:             loc_oPg.obj_4c_Opt_agrucoms.Value   = IIF(.this_nAgrupaComissao = 0, 1, .this_nAgrupaComissao)
2447:             loc_oPg.txt_4c_NParcs.Value         = .this_nParcelas
2448:             loc_oPg.txt_4c_NParc2s.Value        = .this_nParcelas2
2449:             loc_oPg.cbo_4c_CmbTpDesc.Value      = .this_nTipoDesconto
2450:             loc_oPg.cnt_4c_PgDesconto.txt_4c_DescontoMaximo.Value = .this_nDescontoMaximo
2451:         ENDWITH
2452: 
2453:         THIS.CarregarGradeEmpresas()
2454: 
2455:         *-- Container de empresas so aparece para o tipo de desconto 11
2456:         *-- (Desconto Gerente-Extra/loja), igual ao legado
2457:         loc_oPg.cnt_4c_Container1.Visible = (loc_oPg.cbo_4c_CmbTpDesc.Value = 11)
2458: 
2459:         *-- Pagina "Configuracao de Desconto" (grades de composicao/faixas)
2460:         THIS.CarregarConfiguracaoDesconto()
2461:     ENDPROC
2462: 
2463:     *--------------------------------------------------------------------------
2464:     * LimparCampos - Limpa todos os campos da Page2 para novo registro
2465:     *--------------------------------------------------------------------------
2466:     PROTECTED PROCEDURE LimparCampos()
2467:         LOCAL loc_oPg2
2468:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2469: 
2470:         TRY
2471:             loc_oPg2.txt_4c__codigos.Value      = ""
2472:             loc_oPg2.txt_4c__descrs.Value       = ""
2473:             loc_oPg2.txt_4c__moerefs.Value      = ""
2474:             loc_oPg2.txt_4c__moerefs_desc.Value = ""
2475:             loc_oPg2.txt_4c__descos.Value       = 0
2476:             loc_oPg2.txt_4c__obss.Value         = ""
2477:             *-- Legado forca Rel_Descs=2 (Nao) em registro novo (INSERIR/PROCURAR)
2478:             loc_oPg2.obj_4c_Opt_rel_descs.Value = 2
2479:             loc_oPg2.txt_4c_Dtval.Value         = {}
2480:             loc_oPg2.txt_4c_PrazoMs.Value       = 0
2481:             loc_oPg2.obj_4c_Chk_Acesso.Value    = 1
2482:             loc_oPg2.chk_4c_ChkAplicado.Value   = 0
2483:             loc_oPg2.txt_4c_Ajuste.Value        = 0
2484:             loc_oPg2.txt_4c_Fator.Value         = 0
2485:             loc_oPg2.txt_4c_MoeFat.Value        = ""
2486:             loc_oPg2.obj_4c_OptAbateCus.Value   = 2
2487:             loc_oPg2.obj_4c_Opt_agrucoms.Value  = 1
2488:             loc_oPg2.txt_4c_NParcs.Value        = 0
2489:             loc_oPg2.txt_4c_NParc2s.Value       = 0
2490:             loc_oPg2.cbo_4c_CmbTpDesc.Value     = 0
2491:             loc_oPg2.cnt_4c_PgDesconto.txt_4c_DescontoMaximo.Value = 0
2492: 
2493:             *-- Container de empresas: comeca oculto ate o usuario escolher tipo 11
2494:             loc_oPg2.cnt_4c_Container1.Visible  = .F.
2495:             IF USED("cursor_4c_Empresas")
2496:                 SELECT cursor_4c_Empresas
2497:                 REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
2498:                 GO TOP IN cursor_4c_Empresas
2499:             ENDIF
2500: 
2501:             *-- Registro novo (INCLUIR) ainda nao tem composicao/comissoes/
2502:             *-- faixas de desconto cadastradas
2503:             IF USED("cursor_4c_Tdt")
2504:                 USE IN cursor_4c_Tdt
2505:             ENDIF
2506:             IF USED("cursor_4c_Tdi")
2507:                 USE IN cursor_4c_Tdi
2508:             ENDIF
2509:             IF USED("cursor_4c_Tds")

*-- Linhas 2518 a 2572:
2518:     *--------------------------------------------------------------------------
2519:     * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
2520:     *--------------------------------------------------------------------------
2521:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2522:         LOCAL loc_oPg2, loc_lCodHabilitar
2523:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2524: 
2525:         TRY
2526:             *-- Codigo (PK): editavel apenas em INCLUIR ou BUSCAR
2527:             loc_lCodHabilitar = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
2528:             loc_oPg2.txt_4c__codigos.Enabled = loc_lCodHabilitar
2529: 
2530:             loc_oPg2.txt_4c__descrs.Enabled       = par_lHabilitar
2531:             loc_oPg2.txt_4c__moerefs.Enabled      = par_lHabilitar
2532:             loc_oPg2.txt_4c__descos.Enabled       = par_lHabilitar
2533:             loc_oPg2.txt_4c__obss.Enabled         = par_lHabilitar
2534:             loc_oPg2.obj_4c_Opt_rel_descs.Enabled = par_lHabilitar
2535:             loc_oPg2.txt_4c_Dtval.Enabled         = par_lHabilitar
2536:             loc_oPg2.obj_4c_Chk_Acesso.Enabled    = par_lHabilitar
2537:             loc_oPg2.chk_4c_ChkAplicado.Enabled   = par_lHabilitar
2538:             loc_oPg2.txt_4c_Ajuste.Enabled        = par_lHabilitar
2539:             loc_oPg2.txt_4c_Fator.Enabled         = par_lHabilitar
2540:             loc_oPg2.txt_4c_MoeFat.Enabled        = par_lHabilitar
2541:             loc_oPg2.obj_4c_OptAbateCus.Enabled   = par_lHabilitar
2542:             loc_oPg2.obj_4c_Opt_agrucoms.Enabled  = par_lHabilitar
2543:             loc_oPg2.txt_4c_NParcs.Enabled        = par_lHabilitar
2544:             loc_oPg2.txt_4c_NParc2s.Enabled       = par_lHabilitar
2545:             loc_oPg2.cbo_4c_CmbTpDesc.Enabled     = par_lHabilitar
2546: 
2547:             *-- Grade de empresas (tipo de desconto 11): ReadOnly nos modos nao-edicao
2548:             loc_oPg2.cnt_4c_Container1.grd_4c_Empresas.ReadOnly = !par_lHabilitar
2549: 
2550:             *-- Pagina "Descontos / Comissoes"
2551:             WITH loc_oPg2.cnt_4c_PgDesconto
2552:                 .txt_4c_DescontoMaximo.Enabled  = par_lHabilitar
2553:                 .grd_4c_Gradei.ReadOnly         = !par_lHabilitar
2554:                 .grd_4c_Gradec.ReadOnly         = !par_lHabilitar
2555:                 .cmd_4c_InserirComposicao.Enabled = par_lHabilitar
2556:                 .cmd_4c_ExcluirComposicao.Enabled = par_lHabilitar
2557:                 .cmd_4c_InserirComissao.Enabled   = par_lHabilitar
2558:                 .cmd_4c_ExcluirComissao.Enabled   = par_lHabilitar
2559:                 .cbo_4c_ComboComis.Enabled      = par_lHabilitar
2560:                 .txt_4c_DescFats.Enabled        = par_lHabilitar
2561:                 .txt_4c_FatorPads.Enabled       = par_lHabilitar
2562:                 .chk_4c_IgnoraCotacao.Enabled   = par_lHabilitar
2563:                 .cnt_4c_Formula1.cbo_4c_Campo1.Enabled = par_lHabilitar
2564:                 .cnt_4c_Formula1.cbo_4c_Oper1.Enabled  = par_lHabilitar
2565:                 .cnt_4c_Formula1.txt_4c_Const1.Enabled = par_lHabilitar
2566:                 .cnt_4c_Formula1.cbo_4c_Campo2.Enabled = par_lHabilitar
2567:                 .cnt_4c_Formula1.cbo_4c_Oper2.Enabled  = par_lHabilitar
2568:                 .cnt_4c_Formula1.txt_4c_Const2.Enabled = par_lHabilitar
2569:                 .cnt_4c_Formula1.cbo_4c_Campo3.Enabled = par_lHabilitar
2570:                 .cnt_4c_Formula1.txt_4c_Const3.Enabled = par_lHabilitar
2571:                 .cnt_4c_Formula1.txt_4c_Moeda.Enabled  = par_lHabilitar
2572:                 .cnt_4c_Formula2.cbo_4c_Campo1.Enabled = par_lHabilitar

*-- Linhas 2589 a 3246:
2589:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
2590:     * PUBLIC: chamado a partir dos eventos Btn*Click
2591:     *--------------------------------------------------------------------------
2592:     PROCEDURE AjustarBotoesPorModo()
2593:         LOCAL loc_oBotoesAcao
2594:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2595: 
2596:         TRY
2597:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
2598:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2599:         CATCH TO loException
2600:             MostrarErro(loException, "FormTbv.AjustarBotoesPorModo")
2601:         ENDTRY
2602:     ENDPROC
2603: 
2604:     *--------------------------------------------------------------------------
2605:     * BtnIncluirClick - Prepara Page2 para inclusao de nova tabela de desconto
2606:     * PUBLIC: BINDEVENT requer metodo publico
2607:     *--------------------------------------------------------------------------
2608:     PROCEDURE BtnIncluirClick()
2609:         LOCAL loc_lResultado
2610:         loc_lResultado = .F.
2611: 
2612:         TRY
2613:             THIS.this_oBusinessObject.NovoRegistro()
2614:             THIS.LimparCampos()
2615:             THIS.this_cModoAtual = "INCLUIR"
2616:             THIS.HabilitarCampos(.T.)
2617:             THIS.AjustarBotoesPorModo()
2618:             THIS.CarregarGradeEmpresas()
2619:             THIS.AlternarPagina(2)
2620:             loc_lResultado = .T.
2621:         CATCH TO loException
2622:             MostrarErro(loException, "FormTbv.BtnIncluirClick")
2623:             loc_lResultado = .F.
2624:         ENDTRY
2625: 
2626:         RETURN loc_lResultado
2627:     ENDPROC
2628: 
2629:     *--------------------------------------------------------------------------
2630:     * BtnVisualizarClick - Abre a tabela de desconto selecionada em modo
2631:     * somente leitura
2632:     * PUBLIC: BINDEVENT requer metodo publico
2633:     *--------------------------------------------------------------------------
2634:     PROCEDURE BtnVisualizarClick()
2635:         LOCAL loc_cCodigo, loc_lResultado
2636:         loc_lResultado = .F.
2637: 
2638:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2639:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
2640:             RETURN loc_lResultado
2641:         ENDIF
2642: 
2643:         SELECT cursor_4c_Dados
2644:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
2645: 
2646:         TRY
2647:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2648:                 THIS.BOParaForm()
2649:                 THIS.this_cModoAtual = "VISUALIZAR"
2650:                 THIS.HabilitarCampos(.F.)
2651:                 THIS.AjustarBotoesPorModo()
2652:                 THIS.AlternarPagina(2)
2653:                 loc_lResultado = .T.
2654:             ENDIF
2655:         CATCH TO loException
2656:             MostrarErro(loException, "FormTbv.BtnVisualizarClick")
2657:             loc_lResultado = .F.
2658:         ENDTRY
2659: 
2660:         RETURN loc_lResultado
2661:     ENDPROC
2662: 
2663:     *--------------------------------------------------------------------------
2664:     * BtnAlterarClick - Abre a tabela de desconto selecionada para edicao
2665:     * PUBLIC: BINDEVENT requer metodo publico
2666:     *--------------------------------------------------------------------------
2667:     PROCEDURE BtnAlterarClick()
2668:         LOCAL loc_cCodigo, loc_lResultado
2669:         loc_lResultado = .F.
2670: 
2671:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2672:             MsgAviso("Nenhum registro selecionado.", "Alterar")
2673:             RETURN loc_lResultado
2674:         ENDIF
2675: 
2676:         SELECT cursor_4c_Dados
2677:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
2678: 
2679:         TRY
2680:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2681:                 THIS.this_oBusinessObject.EditarRegistro()
2682:                 THIS.BOParaForm()
2683:                 THIS.this_cModoAtual = "ALTERAR"
2684:                 THIS.HabilitarCampos(.T.)
2685:                 THIS.AjustarBotoesPorModo()
2686:                 THIS.AlternarPagina(2)
2687:                 loc_lResultado = .T.
2688:             ENDIF
2689:         CATCH TO loException
2690:             MostrarErro(loException, "FormTbv.BtnAlterarClick")
2691:             loc_lResultado = .F.
2692:         ENDTRY
2693: 
2694:         RETURN loc_lResultado
2695:     ENDPROC
2696: 
2697:     *--------------------------------------------------------------------------
2698:     * BtnExcluirClick - Exclui a tabela de desconto selecionada apos
2699:     * confirmacao (remove tambem SigOpTdt/SigOpTdi/SigOpTds relacionadas)
2700:     * PUBLIC: BINDEVENT requer metodo publico
2701:     *--------------------------------------------------------------------------
2702:     PROCEDURE BtnExcluirClick()
2703:         LOCAL loc_cCodigo, loc_lResultado
2704:         loc_lResultado = .F.
2705: 
2706:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2707:             MsgAviso("Nenhum registro selecionado.", "Excluir")
2708:             RETURN loc_lResultado
2709:         ENDIF
2710: 
2711:         SELECT cursor_4c_Dados
2712:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
2713: 
2714:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2715:             RETURN loc_lResultado
2716:         ENDIF
2717: 
2718:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da tabela de desconto " + loc_cCodigo + "?", "Excluir")
2719:             RETURN loc_lResultado
2720:         ENDIF
2721: 
2722:         TRY
2723:             IF THIS.this_oBusinessObject.Excluir()
2724:                 MsgInfo("Tabela de desconto exclu" + CHR(237) + "da com sucesso!")
2725:                 THIS.CarregarLista()
2726:                 loc_lResultado = .T.
2727:             ELSE
2728:                 MsgErro(THIS.this_oBusinessObject.ObterMensagemErro(), "Erro ao Excluir")
2729:             ENDIF
2730:         CATCH TO loException
2731:             MostrarErro(loException, "FormTbv.BtnExcluirClick")
2732:             loc_lResultado = .F.
2733:         ENDTRY
2734: 
2735:         RETURN loc_lResultado
2736:     ENDPROC
2737: 
2738:     *--------------------------------------------------------------------------
2739:     * BtnBuscarClick - Prepara Page2 em modo BUSCAR (localizar registro ja
2740:     * carregado na lista por codigo ou descricao), reproduzindo o Busca=1/
2741:     * Busca=2 do legado (Select CrSigOpTdz / Seek por Codigos ou Descrs)
2742:     * PUBLIC: BINDEVENT requer metodo publico
2743:     *--------------------------------------------------------------------------
2744:     PROCEDURE BtnBuscarClick()
2745:         LOCAL loc_lResultado
2746:         loc_lResultado = .F.
2747: 
2748:         TRY
2749:             THIS.this_oBusinessObject.NovoRegistro()
2750:             THIS.LimparCampos()
2751:             THIS.this_cModoAtual = "BUSCAR"
2752:             THIS.HabilitarCampos(.T.)
2753:             THIS.AjustarBotoesPorModo()
2754:             THIS.AlternarPagina(2)
2755:             loc_lResultado = .T.
2756:         CATCH TO loException
2757:             MostrarErro(loException, "FormTbv.BtnBuscarClick")
2758:             loc_lResultado = .F.
2759:         ENDTRY
2760: 
2761:         RETURN loc_lResultado
2762:     ENDPROC
2763: 
2764:     *--------------------------------------------------------------------------
2765:     * BtnEncerrarClick - Fecha o formulario
2766:     * PUBLIC: BINDEVENT requer metodo publico
2767:     *--------------------------------------------------------------------------
2768:     PROCEDURE BtnEncerrarClick()
2769:         THIS.Release()
2770:     ENDPROC
2771: 
2772:     *--------------------------------------------------------------------------
2773:     * BtnConfirmarClick - Modo BUSCAR: localiza o registro na lista pelo
2774:     * codigo ou pela descricao informados. Modo INCLUIR/ALTERAR: valida
2775:     * codigo/descricao obrigatorios (legado: "Codigo Invalido !!!" /
2776:     * descricao obrigatoria), checa duplicidade de codigo em INCLUIR
2777:     * (legado: "Codigo ja cadastrado !!!") e grava via Salvar()
2778:     * PUBLIC: BINDEVENT requer metodo publico
2779:     *--------------------------------------------------------------------------
2780:     PROCEDURE BtnConfirmarClick()
2781:         LOCAL loc_oPg2, loc_cCodBusca, loc_cDescBusca, loc_lResultado
2782:         loc_lResultado = .F.
2783: 
2784:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2785: 
2786:         *-- Validacoes antes do TRY (RETURN valido fora de TRY/CATCH)
2787:         IF THIS.this_cModoAtual != "BUSCAR" AND EMPTY(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
2788:             MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido !!!", "")
2789:             loc_oPg2.txt_4c__codigos.SetFocus
2790:             RETURN .F.
2791:         ENDIF
2792: 
2793:         IF THIS.this_cModoAtual != "BUSCAR" AND EMPTY(ALLTRIM(loc_oPg2.txt_4c__descrs.Value))
2794:             MsgAviso("A descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria.", "")
2795:             loc_oPg2.txt_4c__descrs.SetFocus
2796:             RETURN .F.
2797:         ENDIF
2798: 
2799:         TRY
2800:             IF THIS.this_cModoAtual = "BUSCAR"
2801:                 loc_cCodBusca  = ALLTRIM(loc_oPg2.txt_4c__codigos.Value)
2802:                 loc_cDescBusca = ALLTRIM(loc_oPg2.txt_4c__descrs.Value)
2803:                 THIS.this_cModoAtual = "LISTA"
2804:                 THIS.AlternarPagina(1)
2805:                 IF USED("cursor_4c_Dados")
2806:                     SELECT cursor_4c_Dados
2807:                     IF !EMPTY(loc_cCodBusca)
2808:                         LOCATE FOR ALLTRIM(cursor_4c_Dados.codigos) = loc_cCodBusca
2809:                     ELSE
2810:                         IF !EMPTY(loc_cDescBusca)
2811:                             LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.descrs)) = UPPER(loc_cDescBusca)
2812:                         ENDIF
2813:                     ENDIF
2814:                 ENDIF
2815:                 loc_lResultado = .T.
2816:             ELSE
2817:                 IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2818:                     IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
2819:                         MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado !!!", "")
2820:                         THIS.this_oBusinessObject.NovoRegistro()
2821:                         loc_oPg2.txt_4c__codigos.SetFocus
2822:                     ELSE
2823:                         THIS.FormParaBO()
2824:                         IF THIS.this_oBusinessObject.Salvar()
2825:                             *-- Composicao/comissoes/faixas de desconto (paginas
2826:                             *-- "Descontos / Comissoes" e "Configuracao de
2827:                             *-- Desconto") nao fazem parte do FormParaBO/Salvar
2828:                             *-- padrao (SigOpTdt/SigOpTdi/SigOpTds sao sub-tabelas)
2829:                             IF !THIS.this_oBusinessObject.SalvarComposicaoDesconto(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
2830:                                 MsgErro("Tabela de desconto salva, mas houve falha ao gravar a composi" + CHR(231) + CHR(227) + "o de desconto.", "Erro ao Salvar")
2831:                             ENDIF
2832:                             IF !THIS.this_oBusinessObject.SalvarComissoesDesconto(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
2833:                                 MsgErro("Tabela de desconto salva, mas houve falha ao gravar as comiss" + CHR(245) + "es de desconto.", "Erro ao Salvar")
2834:                             ENDIF
2835:                             IF !THIS.this_oBusinessObject.SalvarFaixasDesconto(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
2836:                                 MsgErro("Tabela de desconto salva, mas houve falha ao gravar as faixas de desconto.", "Erro ao Salvar")
2837:                             ENDIF
2838:                             MsgInfo("Tabela de desconto salva com sucesso!")
2839:                             THIS.this_cModoAtual = "LISTA"
2840:                             THIS.AlternarPagina(1)
2841:                             loc_lResultado = .T.
2842:                         ELSE
2843:                             MsgErro(THIS.this_oBusinessObject.ObterMensagemErro(), "Erro ao Salvar")
2844:                         ENDIF
2845:                     ENDIF
2846:                 ENDIF
2847:             ENDIF
2848:         CATCH TO loException
2849:             MostrarErro(loException, "FormTbv.BtnConfirmarClick")
2850:             loc_lResultado = .F.
2851:         ENDTRY
2852: 
2853:         RETURN loc_lResultado
2854:     ENDPROC
2855: 
2856:     *--------------------------------------------------------------------------
2857:     * BtnSalvarClick - Alias canonico para BtnConfirmarClick
2858:     * PUBLIC: BINDEVENT requer metodo publico
2859:     *--------------------------------------------------------------------------
2860:     PROCEDURE BtnSalvarClick()
2861:         RETURN THIS.BtnConfirmarClick()
2862:     ENDPROC
2863: 
2864:     *--------------------------------------------------------------------------
2865:     * BtnCancelarClick - Cancela (BUSCAR/INCLUIR/ALTERAR) e volta para a lista
2866:     * PUBLIC: BINDEVENT requer metodo publico
2867:     *--------------------------------------------------------------------------
2868:     PROCEDURE BtnCancelarClick()
2869:         TRY
2870:             THIS.this_cModoAtual = "LISTA"
2871:             THIS.AlternarPagina(1)
2872:         CATCH TO loException
2873:             MostrarErro(loException, "FormTbv.BtnCancelarClick")
2874:         ENDTRY
2875:     ENDPROC
2876: 
2877:     *--------------------------------------------------------------------------
2878:     * CriarCursorTipoDesconto - Cria cursor local (lista fixa) para cbo_4c_CmbTpDesc
2879:     * Legado: Create Cursor crTpDesc (Descrs c(40), ordem N(2,0)) no Init()
2880:     *--------------------------------------------------------------------------
2881:     PROTECTED PROCEDURE CriarCursorTipoDesconto()
2882:         IF USED("cursor_4c_TipoDesconto")
2883:             RETURN
2884:         ENDIF
2885: 
2886:         CREATE CURSOR cursor_4c_TipoDesconto (Descrs C(40), Ordem N(2, 0))
2887:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("1-Anivers" + CHR(225) + "rio", 1)
2888:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("2-Desconto Vendedor", 2)
2889:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("3-Desconto Gerente-Grupo", 3)
2890:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("4-Desconto Gerente-Lancamento", 4)
2891:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("5-Desconto Gerente-qq pe" + CHR(231) + "a", 5)
2892:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("6-Troca Zerada", 6)
2893:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("7-Troca Upgrade", 7)
2894:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("8-Desconto Supervisor", 8)
2895:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("9-Desconto Diretoria", 9)
2896:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("10-Troca Up Alianca", 10)
2897:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("11-Desconto Gerente-Extra/loja", 11)
2898:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("12-Desconto Gerente-Brinde", 12)
2899:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("13-Desconto Gerente-Troca de pre" + CHR(231) + "o", 13)
2900:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES (SPACE(40), 0)
2901:         GO TOP IN cursor_4c_TipoDesconto
2902:     ENDPROC
2903: 
2904:     *--------------------------------------------------------------------------
2905:     * TipoDescontoInteractiveChange - Mostra/oculta a lista de empresas conforme
2906:     * o tipo de desconto selecionado (11 = Desconto Gerente-Extra/loja)
2907:     * PUBLIC: BINDEVENT requer metodo publico
2908:     *--------------------------------------------------------------------------
2909:     PROCEDURE TipoDescontoInteractiveChange()
2910:         LOCAL loc_oPg, loc_lMostrarEmpresas
2911: 
2912:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2913:         loc_lMostrarEmpresas = (loc_oPg.cbo_4c_CmbTpDesc.Value = 11)
2914: 
2915:         loc_oPg.cnt_4c_Container1.Visible = loc_lMostrarEmpresas
2916: 
2917:         IF !loc_lMostrarEmpresas AND USED("cursor_4c_Empresas")
2918:             SELECT cursor_4c_Empresas
2919:             REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
2920:             GO TOP IN cursor_4c_Empresas
2921:             IF PEMSTATUS(loc_oPg.cnt_4c_Container1, "grd_4c_Empresas", 5)
2922:                 loc_oPg.cnt_4c_Container1.grd_4c_Empresas.Refresh()
2923:             ENDIF
2924:         ENDIF
2925:     ENDPROC
2926: 
2927:     *--------------------------------------------------------------------------
2928:     * CarregarGradeEmpresas - Carrega grade de empresas (SigCdEmp) e marca as
2929:     * empresas presentes em this_cListaEmpresas (formato ";EMP1;EMP2;...")
2930:     *--------------------------------------------------------------------------
2931:     PROCEDURE CarregarGradeEmpresas()
2932:         LOCAL loc_lResultado, loc_oGrid, loc_cListaEmpresas
2933: 
2934:         loc_lResultado = .F.
2935: 
2936:         TRY
2937:             IF THIS.this_oBusinessObject.CarregarEmpresas()
2938:                 loc_cListaEmpresas = THIS.this_oBusinessObject.this_cListaEmpresas
2939: 
2940:                 SELECT cursor_4c_Empresas
2941:                 SCAN
2942:                     IF !EMPTY(ALLTRIM(cursor_4c_Empresas.cemps)) AND ALLTRIM(cursor_4c_Empresas.cemps) $ loc_cListaEmpresas
2943:                         REPLACE nMarca WITH 1 IN cursor_4c_Empresas
2944:                     ELSE
2945:                         REPLACE nMarca WITH 0 IN cursor_4c_Empresas
2946:                     ENDIF
2947:                 ENDSCAN
2948:                 GO TOP IN cursor_4c_Empresas
2949: 
2950:                 *-- NAO reatribuir ColumnCount aqui: destruiria o chk_4c_Marca
2951:                 *-- (AddObject em Column1) criado em ConfigurarPaginaDados (Pattern #183)
2952:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas
2953:                 loc_oGrid.RecordSource = "cursor_4c_Empresas"
2954:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Empresas.nMarca"
2955:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Empresas.cemps"
2956:                 loc_oGrid.Column1.Header1.Caption = ""
2957:                 loc_oGrid.Column2.Header1.Caption = "Empresa"
2958:                 loc_oGrid.Column1.Width  = 30
2959:                 loc_oGrid.Column2.Width  = 190
2960:                 loc_oGrid.Column1.CurrentControl = "chk_4c_Marca"
2961:                 loc_oGrid.Column2.ReadOnly = .T.
2962:                 loc_oGrid.Refresh()
2963: 
2964:                 loc_lResultado = .T.
2965:             ENDIF
2966:         CATCH TO loException
2967:             MostrarErro(loException, "FormTbv.CarregarGradeEmpresas")
2968:             loc_lResultado = .F.
2969:         ENDTRY
2970: 
2971:         RETURN loc_lResultado
2972:     ENDPROC
2973: 
2974:     *--------------------------------------------------------------------------
2975:     * MontarListaEmpresas - Le as empresas marcadas na grade e monta a string
2976:     * ";EMP1;EMP2;..." gravada em this_cListaEmpresas (listaemp)
2977:     *--------------------------------------------------------------------------
2978:     PROCEDURE MontarListaEmpresas()
2979:         LOCAL loc_cLista
2980: 
2981:         loc_cLista = ""
2982: 
2983:         IF USED("cursor_4c_Empresas")
2984:             SELECT cursor_4c_Empresas
2985:             GO TOP
2986:             SCAN
2987:                 IF cursor_4c_Empresas.nMarca = 1
2988:                     loc_cLista = loc_cLista + ";" + ALLTRIM(cursor_4c_Empresas.cemps)
2989:                 ENDIF
2990:             ENDSCAN
2991:         ENDIF
2992: 
2993:         RETURN loc_cLista
2994:     ENDPROC
2995: 
2996:     *--------------------------------------------------------------------------
2997:     * BtnEmpresasDesmarcarClick - Desmarca todas as empresas da grade
2998:     * PUBLIC: BINDEVENT requer metodo publico
2999:     *--------------------------------------------------------------------------
3000:     PROCEDURE BtnEmpresasDesmarcarClick()
3001:         IF USED("cursor_4c_Empresas")
3002:             SELECT cursor_4c_Empresas
3003:             REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
3004:             GO TOP IN cursor_4c_Empresas
3005:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3006:         ENDIF
3007:     ENDPROC
3008: 
3009:     *--------------------------------------------------------------------------
3010:     * BtnEmpresasMarcarClick - Marca todas as empresas da grade
3011:     * PUBLIC: BINDEVENT requer metodo publico
3012:     *--------------------------------------------------------------------------
3013:     PROCEDURE BtnEmpresasMarcarClick()
3014:         IF USED("cursor_4c_Empresas")
3015:             SELECT cursor_4c_Empresas
3016:             REPLACE ALL nMarca WITH 1 IN cursor_4c_Empresas
3017:             GO TOP IN cursor_4c_Empresas
3018:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3019:         ENDIF
3020:     ENDPROC
3021: 
3022:     *--------------------------------------------------------------------------
3023:     * EmpresaCheckboxMouseDown - Toggle nMarca em cursor_4c_Empresas via mouse
3024:     * Grid nao alterna CheckBox pelo binding nativo (campo numerico) - alterna
3025:     * manualmente e suprime o toggle padrao com NODEFAULT
3026:     * PUBLIC: BINDEVENT requer metodo publico
3027:     *--------------------------------------------------------------------------
3028:     PROCEDURE EmpresaCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
3029:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("cursor_4c_Empresas") AND !EOF("cursor_4c_Empresas")
3030:             SELECT cursor_4c_Empresas
3031:             REPLACE nMarca WITH IIF(cursor_4c_Empresas.nMarca = 0, 1, 0) IN cursor_4c_Empresas
3032:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1, "grd_4c_Empresas", 5)
3033:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3034:             ENDIF
3035:         ENDIF
3036:         NODEFAULT
3037:     ENDPROC
3038: 
3039:     *--------------------------------------------------------------------------
3040:     * EmpresaCheckboxMouseUp - Suprime comportamento padrao
3041:     * PUBLIC: BINDEVENT requer metodo publico
3042:     *--------------------------------------------------------------------------
3043:     PROCEDURE EmpresaCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
3044:         NODEFAULT
3045:     ENDPROC
3046: 
3047:     *--------------------------------------------------------------------------
3048:     * EmpresaCheckboxClick - Suprime toggle automatico (MouseDown ja atualizou)
3049:     * PUBLIC: BINDEVENT requer metodo publico
3050:     *--------------------------------------------------------------------------
3051:     PROCEDURE EmpresaCheckboxClick()
3052:         NODEFAULT
3053:     ENDPROC
3054: 
3055:     *--------------------------------------------------------------------------
3056:     * EmpresaCheckboxKeyPress - Toggle nMarca em cursor_4c_Empresas via teclado
3057:     * PUBLIC: BINDEVENT requer metodo publico
3058:     *--------------------------------------------------------------------------
3059:     PROCEDURE EmpresaCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3060:         IF INLIST(par_nKeyCode, 13, 32)
3061:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("cursor_4c_Empresas") AND !EOF("cursor_4c_Empresas")
3062:                 SELECT cursor_4c_Empresas
3063:                 REPLACE nMarca WITH IIF(cursor_4c_Empresas.nMarca = 0, 1, 0) IN cursor_4c_Empresas
3064:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1, "grd_4c_Empresas", 5)
3065:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3066:                 ENDIF
3067:             ENDIF
3068:             NODEFAULT
3069:         ENDIF
3070:     ENDPROC
3071: 
3072:     *--------------------------------------------------------------------------
3073:     * MoedaRefLookupKeyPress / MoedaRefLookupDblClick - F4/DblClick para
3074:     * lookup de Moeda de Referencia (SigCdMoe) em txt_4c__moerefs
3075:     * PUBLIC: BINDEVENT requer metodo publico
3076:     *--------------------------------------------------------------------------
3077:     PROCEDURE MoedaRefLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3078:         IF par_nKeyCode = 28  && F4
3079:             THIS.AbrirLookupMoedaRef()
3080:         ENDIF
3081:     ENDPROC
3082: 
3083:     PROCEDURE MoedaRefLookupDblClick()
3084:         THIS.AbrirLookupMoedaRef()
3085:     ENDPROC
3086: 
3087:     *--------------------------------------------------------------------------
3088:     * AbrirLookupMoedaRef - Busca SigCdMoe por codigo (cmoes) e preenche
3089:     * codigo + descricao da Moeda de Referencia
3090:     *--------------------------------------------------------------------------
3091:     PROCEDURE AbrirLookupMoedaRef()
3092:         LOCAL loc_oPg, loc_cValor, loc_oBusca
3093: 
3094:         loc_oPg    = THIS.pgf_4c_Paginas.Page2
3095:         loc_cValor = ALLTRIM(loc_oPg.txt_4c__moerefs.Value)
3096: 
3097:         TRY
3098:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3099:                 "SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", loc_cValor, ;
3100:                 "Buscar Moeda")
3101: 
3102:             IF VARTYPE(loc_oBusca) = "O"
3103:                 IF !loc_oBusca.this_lAchouRegistro
3104:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3105:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3106:                     loc_oBusca.Show()
3107:                 ENDIF
3108: 
3109:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
3110:                     SELECT cursor_4c_BuscaMoeda
3111:                     loc_oPg.txt_4c__moerefs.Value      = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
3112:                     loc_oPg.txt_4c__moerefs_desc.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
3113:                 ENDIF
3114: 
3115:                 loc_oBusca.Release()
3116:             ENDIF
3117:         CATCH TO loException
3118:             MostrarErro(loException, "FormTbv.AbrirLookupMoedaRef")
3119:         ENDTRY
3120: 
3121:         IF USED("cursor_4c_BuscaMoeda")
3122:             USE IN cursor_4c_BuscaMoeda
3123:         ENDIF
3124:     ENDPROC
3125: 
3126:     *--------------------------------------------------------------------------
3127:     * MoedaFatorLookupKeyPress / MoedaFatorLookupDblClick - F4/DblClick para
3128:     * lookup de Moeda do Fator (SigCdMoe) em txt_4c_MoeFat
3129:     * PUBLIC: BINDEVENT requer metodo publico
3130:     *--------------------------------------------------------------------------
3131:     PROCEDURE MoedaFatorLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3132:         IF par_nKeyCode = 28  && F4
3133:             THIS.AbrirLookupMoedaFator()
3134:         ENDIF
3135:     ENDPROC
3136: 
3137:     PROCEDURE MoedaFatorLookupDblClick()
3138:         THIS.AbrirLookupMoedaFator()
3139:     ENDPROC
3140: 
3141:     *--------------------------------------------------------------------------
3142:     * AbrirLookupMoedaFator - Busca SigCdMoe por codigo (cmoes) e preenche
3143:     * a Moeda do Fator
3144:     *--------------------------------------------------------------------------
3145:     PROCEDURE AbrirLookupMoedaFator()
3146:         LOCAL loc_oPg, loc_cValor, loc_oBusca
3147: 
3148:         loc_oPg    = THIS.pgf_4c_Paginas.Page2
3149:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_MoeFat.Value)
3150: 
3151:         TRY
3152:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3153:                 "SigCdMoe", "cursor_4c_BuscaMoedaFator", "cmoes", loc_cValor, ;
3154:                 "Buscar Moeda")
3155: 
3156:             IF VARTYPE(loc_oBusca) = "O"
3157:                 IF !loc_oBusca.this_lAchouRegistro
3158:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3159:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3160:                     loc_oBusca.Show()
3161:                 ENDIF
3162: 
3163:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedaFator")
3164:                     SELECT cursor_4c_BuscaMoedaFator
3165:                     loc_oPg.txt_4c_MoeFat.Value = ALLTRIM(cursor_4c_BuscaMoedaFator.cmoes)
3166:                 ENDIF
3167: 
3168:                 loc_oBusca.Release()
3169:             ENDIF
3170:         CATCH TO loException
3171:             MostrarErro(loException, "FormTbv.AbrirLookupMoedaFator")
3172:         ENDTRY
3173: 
3174:         IF USED("cursor_4c_BuscaMoedaFator")
3175:             USE IN cursor_4c_BuscaMoedaFator
3176:         ENDIF
3177:     ENDPROC
3178: 
3179:     *--------------------------------------------------------------------------
3180:     * CriarCursorDiaSemana - Cria cursor local (lista fixa) com os 7 dias da
3181:     * semana, usado na validacao de faixas de desconto por Dia da Semana
3182:     * Legado: Create Cursor DiaSemana (ndias n(1), Descrs c(7)) no Init()
3183:     *--------------------------------------------------------------------------
3184:     PROTECTED PROCEDURE CriarCursorDiaSemana()
3185:         IF USED("cursor_4c_DiaSemana")
3186:             RETURN
3187:         ENDIF
3188: 
3189:         CREATE CURSOR cursor_4c_DiaSemana (nDias N(1), Descrs C(7))
3190:         INDEX ON Descrs TAG Descrs
3191:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (1, "DOMINGO")
3192:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (2, "SEGUNDA")
3193:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (3, "TERCA  ")
3194:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (4, "QUARTA ")
3195:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (5, "QUINTA ")
3196:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (6, "SEXTA  ")
3197:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (7, "SABADO ")
3198:         GO TOP IN cursor_4c_DiaSemana
3199:     ENDPROC
3200: 
3201:     *--------------------------------------------------------------------------
3202:     * CarregarConfiguracaoDesconto - Carrega grd_4c_GradeI (SigOpTdt) e
3203:     * grd_4c_GradeD (SigOpTds) do codigo corrente. Chamado por BOParaForm()
3204:     * ao entrar em ALTERAR/VISUALIZAR/EXCLUIR e por LimparCampos() (INCLUIR).
3205:     *--------------------------------------------------------------------------
3206:     PROCEDURE CarregarConfiguracaoDesconto()
3207:         LOCAL loc_oPgConf, loc_oPgDesc, loc_oGradei, loc_oGradeiDesc, loc_oGradec, loc_cCodigo
3208: 
3209:         TRY
3210:             loc_oPgConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto
3211:             loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
3212:             loc_oGradei     = loc_oPgConf.grd_4c_GradeI
3213:             loc_oGradeiDesc = loc_oPgDesc.grd_4c_Gradei
3214:             loc_oGradec     = loc_oPgDesc.grd_4c_Gradec
3215:             loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
3216: 
3217:             IF EMPTY(loc_cCodigo)
3218:                 loc_oGradei.RecordSource        = ""
3219:                 loc_oPgConf.grd_4c_GradeD.RecordSource = ""
3220:                 loc_oPgConf.grd_4c_GradeD.Enabled      = .F.
3221:                 loc_oPgConf.lbl_4c_Lb_desconto.Caption = "Tipo de Desconto"
3222:                 loc_oGradeiDesc.RecordSource    = ""
3223:                 loc_oGradec.RecordSource        = ""
3224:                 RETURN
3225:             ENDIF
3226: 
3227:             THIS.this_oBusinessObject.CarregarComposicaoDesconto(loc_cCodigo)
3228:             THIS.this_oBusinessObject.CarregarComissoesDesconto(loc_cCodigo)
3229:             THIS.this_oBusinessObject.CarregarFaixasDesconto(loc_cCodigo)
3230: 
3231:             loc_oGradei.RecordSource        = "cursor_4c_Tdt"
3232:             loc_oGradei.Column1.ControlSource = "cursor_4c_Tdt.tipos"
3233:             loc_oGradei.Column2.ControlSource = "cursor_4c_Tdt.codtips"
3234:             loc_oGradei.Column3.ControlSource = "cursor_4c_Tdt.tipods"
3235:             loc_oGradei.SetAll("DynamicBackColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(128,128,128), RGB(255,255,255))", "Column")
3236:             loc_oGradei.SetAll("DynamicForeColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(255,255,255), RGB(0,0,0))", "Column")
3237:             loc_oGradei.Refresh()
3238: 
3239:             *-- grd_4c_Gradei (pgDesconto) - MESMA cursor_4c_Tdt, colunas
3240:             *-- adicionais de valor/fator/exclui/faixa/inicial/final
3241:             loc_oGradeiDesc.RecordSource        = "cursor_4c_Tdt"
3242:             loc_oGradeiDesc.Column1.ControlSource = "cursor_4c_Tdt.tipos"
3243:             loc_oGradeiDesc.Column2.ControlSource = "cursor_4c_Tdt.codtips"
3244:             loc_oGradeiDesc.Column3.ControlSource = "cursor_4c_Tdt.descos"
3245:             loc_oGradeiDesc.Column4.ControlSource = "cursor_4c_Tdt.dfators"
3246:             loc_oGradeiDesc.Column5.ControlSource = "cursor_4c_Tdt.texclus"

*-- Linhas 3297 a 3413:
3297:     * GradeiConfAfterRowColChange - troca de linha em grd_4c_GradeI: marca a
3298:     * linha corrente (flag "regs", equivalente ao legado) e reconfigura a
3299:     * grade de faixas (grd_4c_GradeD) para a nova combinacao Tipo/Codigo
3300:     * PUBLIC: BINDEVENT requer metodo publico + parametro do evento
3301:     *--------------------------------------------------------------------------
3302:     PROCEDURE GradeiConfAfterRowColChange(par_nColIndex)
3303:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3304:             RETURN
3305:         ENDIF
3306: 
3307:         SELECT cursor_4c_Tdt
3308:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3309:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3310: 
3311:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3312:         THIS.MontarConfiguracaoDesconto()
3313:     ENDPROC
3314: 
3315:     *--------------------------------------------------------------------------
3316:     * GradeiConfColumn3When - habilita edicao da coluna "Tipos Desconto"
3317:     * apenas em INCLUIR/ALTERAR (equivalente ao When original)
3318:     * PUBLIC: BINDEVENT requer metodo publico
3319:     *--------------------------------------------------------------------------
3320:     PROCEDURE GradeiConfColumn3When()
3321:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3322:     ENDPROC
3323: 
3324:     *--------------------------------------------------------------------------
3325:     * GradeiConfColumn3Valid / GradeiConfColumn3LostFocus - reconfigura a
3326:     * grade de faixas ao mudar o tipo de desconto progressivo da linha
3327:     * PUBLIC: BINDEVENT requer metodo publico
3328:     *--------------------------------------------------------------------------
3329:     PROCEDURE GradeiConfColumn3Valid()
3330:         THIS.MontarConfiguracaoDesconto()
3331:     ENDPROC
3332: 
3333:     PROCEDURE GradeiConfColumn3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
3334:         THIS.MontarConfiguracaoDesconto()
3335:         IF LASTKEY() = 9
3336:             THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD.Column1.SetFocus
3337:         ENDIF
3338:     ENDPROC
3339: 
3340:     *--------------------------------------------------------------------------
3341:     * MontarConfiguracaoDesconto - Equivalente ao "MontaTbDes" do legado.
3342:     * Filtra cursor_4c_Tds pela combinacao Tipo+Codigo+TipoDesconto da linha
3343:     * corrente de grd_4c_GradeI, cria a faixa inicial (00:00-23:59) quando
3344:     * ainda nao existe nenhuma, e reconfigura grd_4c_GradeD (ControlSource/
3345:     * InputMask das colunas Inicial/Final) conforme o Tipo de Desconto:
3346:     * 2=Dia da Semana, 3=Dia do Mes, 4=Horario, 5=Data
3347:     *--------------------------------------------------------------------------
3348:     PROTECTED PROCEDURE MontarConfiguracaoDesconto()
3349:         LOCAL loc_oGD, loc_oPgConf, loc_cCodigo, loc_nTipos, loc_cCodTips, ;
3350:               loc_nTipoDs, loc_cTitulo
3351: 
3352:         loc_oPgConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto
3353:         loc_oGD     = loc_oPgConf.grd_4c_GradeD
3354: 
3355:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3356:             loc_oGD.RecordSource = ""
3357:             loc_oGD.Enabled      = .F.
3358:             loc_oPgConf.lbl_4c_Lb_desconto.Caption = "Tipo de Desconto"
3359:             RETURN
3360:         ENDIF
3361: 
3362:         loc_cCodigo  = ALLTRIM(cursor_4c_Tdt.codigos)
3363:         loc_nTipos   = cursor_4c_Tdt.tipos
3364:         loc_cCodTips = ALLTRIM(cursor_4c_Tdt.codtips)
3365:         loc_nTipoDs  = cursor_4c_Tdt.tipods
3366: 
3367:         DO CASE
3368:             CASE loc_nTipoDs = 2
3369:                 loc_cTitulo = "Dia da Semana"
3370:             CASE loc_nTipoDs = 3
3371:                 loc_cTitulo = "Dia do Mes"
3372:             CASE loc_nTipoDs = 4
3373:                 loc_cTitulo = "Horario"
3374:             OTHERWISE
3375:                 loc_cTitulo = "Data"
3376:         ENDCASE
3377:         loc_oPgConf.lbl_4c_Lb_desconto.Caption = loc_cTitulo
3378: 
3379:         IF USED("cursor_4c_Tds")
3380:             SELECT cursor_4c_Tds
3381:             SET FILTER TO ALLTRIM(codigos) == loc_cCodigo AND tipos = loc_nTipos ;
3382:                 AND ALLTRIM(codtips) == loc_cCodTips AND tipods = loc_nTipoDs
3383:             GO TOP
3384:             IF EOF()
3385:                 APPEND BLANK
3386:                 REPLACE cidchaves WITH fUniqueIds(), ;
3387:                         codigos   WITH loc_cCodigo, ;
3388:                         tipos     WITH loc_nTipos, ;
3389:                         codtips   WITH loc_cCodTips, ;
3390:                         tipods    WITH loc_nTipoDs, ;
3391:                         campo2is  WITH "00:00", ;
3392:                         campo2fs  WITH "23:59" IN cursor_4c_Tds
3393:                 GO TOP
3394:             ENDIF
3395:         ENDIF
3396: 
3397:         WITH loc_oGD
3398:             .RecordSource = ""
3399:             .RecordSource = "cursor_4c_Tds"
3400: 
3401:             *-- Redefinir ControlSource de TODAS as colunas apos reatribuir
3402:             *-- RecordSource - VFP faz auto-bind pela ordem dos campos do
3403:             *-- cursor, ignorando qualquer ControlSource setado antes (Pattern
3404:             *-- GRID-RECORDSOURCE-AUTOBIND)
3405:             DO CASE
3406:                 CASE loc_nTipoDs = 5
3407:                     .Column1.ControlSource = "cursor_4c_Tds.Campo3is"
3408:                     .Column2.ControlSource = "cursor_4c_Tds.Campo3fs"
3409:                 OTHERWISE
3410:                     .Column1.ControlSource = "cursor_4c_Tds.Campo1is"
3411:                     .Column2.ControlSource = "cursor_4c_Tds.Campo1fs"
3412:             ENDCASE
3413:             .Column3.ControlSource = "cursor_4c_Tds.Campo2is"

*-- Linhas 3462 a 3927:
3462:         loc_nMin   = VAL(SUBSTR(loc_cValor, 4, 2))
3463: 
3464:         IF !BETWEEN(loc_nHora, 0, 23)
3465:             MsgAviso("Horas s" + CHR(243) + " pode ser entre 00:00 e 23:59", "")
3466:             RETURN ""
3467:         ENDIF
3468:         IF !BETWEEN(loc_nMin, 0, 59)
3469:             MsgAviso("Minutos s" + CHR(243) + " pode ser entre 00 e 59", "")
3470:             RETURN ""
3471:         ENDIF
3472: 
3473:         RETURN TRANSFORM(loc_nHora, "@L 99") + ":" + TRANSFORM(loc_nMin, "@L 99")
3474:     ENDFUNC
3475: 
3476:     *--------------------------------------------------------------------------
3477:     * FaixaTemInicial - Indica se a faixa (linha corrente de cursor_4c_Tds)
3478:     * ja tem o valor Inicial preenchido, condicao para habilitar as demais
3479:     * colunas de grd_4c_GradeD (equivalente ao "Left(Campo1is,2)" do legado).
3480:     * Quando o Tipo de Desconto e "Data" (5), o Inicial fica em Campo3is
3481:     * (nao em Campo1is - ver MontarConfiguracaoDesconto)
3482:     *--------------------------------------------------------------------------
3483:     PROTECTED FUNCTION FaixaTemInicial()
3484:         LOCAL loc_nTipoDs
3485: 
3486:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3487:             RETURN .F.
3488:         ENDIF
3489: 
3490:         loc_nTipoDs = 0
3491:         IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
3492:             loc_nTipoDs = cursor_4c_Tdt.tipods
3493:         ENDIF
3494: 
3495:         IF loc_nTipoDs = 5
3496:             RETURN !EMPTY(cursor_4c_Tds.Campo3is)
3497:         ENDIF
3498: 
3499:         RETURN !EMPTY(LEFT(NVL(cursor_4c_Tds.Campo1is, ""), 2))
3500:     ENDFUNC
3501: 
3502:     *--------------------------------------------------------------------------
3503:     * GradeD Column1/Column2 (Inicial/Final) - When/Valid
3504:     * Equivalente ao "PgConfDesconto.GradeD.Column1/2.Text1" do legado:
3505:     * validacao/formatacao depende do Tipo de Desconto (tipods) da linha
3506:     * corrente de grd_4c_GradeI (cursor_4c_Tdt)
3507:     * PUBLIC: BINDEVENT requer metodo publico
3508:     *--------------------------------------------------------------------------
3509:     PROCEDURE GradeDColumn1When()
3510:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3511:     ENDPROC
3512: 
3513:     PROCEDURE GradeDColumn1Valid()
3514:         LOCAL loc_oGD, loc_cValor, loc_cFormatado
3515: 
3516:         IF !USED("cursor_4c_Tdt") OR !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tdt") OR EOF("cursor_4c_Tds")
3517:             RETURN
3518:         ENDIF
3519: 
3520:         loc_oGD    = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3521:         loc_cValor = ALLTRIM(loc_oGD.Column1.Text1.Value)
3522: 
3523:         IF EMPTY(loc_cValor)
3524:             RETURN
3525:         ENDIF
3526: 
3527:         DO CASE
3528:             CASE cursor_4c_Tdt.tipods = 2  && Dia da Semana
3529:                 IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3530:                     MsgAviso("Dia da semana inv" + CHR(225) + "lido. Informe Domingo, Segunda, Terca, Quarta, Quinta, Sexta ou Sabado.", "")
3531:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3532:                 ELSE
3533:                     REPLACE Campo1is WITH ALLTRIM(cursor_4c_DiaSemana.Descrs) IN cursor_4c_Tds
3534:                     IF EMPTY(ALLTRIM(cursor_4c_Tds.Campo1fs))
3535:                         REPLACE Campo1fs WITH cursor_4c_Tds.Campo1is IN cursor_4c_Tds
3536:                     ENDIF
3537:                 ENDIF
3538: 
3539:             CASE cursor_4c_Tdt.tipods = 3  && Dia do Mes
3540:                 IF !BETWEEN(VAL(loc_cValor), 1, 31)
3541:                     MsgAviso("Dia do m" + CHR(234) + "s deve ser entre 1 e 31 !!!", "")
3542:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3543:                 ELSE
3544:                     REPLACE Campo1is WITH PADL(TRANSFORM(INT(VAL(loc_cValor))), 2, "0") IN cursor_4c_Tds
3545:                     IF VAL(cursor_4c_Tds.Campo1fs) = 0 OR VAL(cursor_4c_Tds.Campo1is) > VAL(cursor_4c_Tds.Campo1fs)
3546:                         REPLACE Campo1fs WITH cursor_4c_Tds.Campo1is IN cursor_4c_Tds
3547:                     ENDIF
3548:                 ENDIF
3549: 
3550:             CASE cursor_4c_Tdt.tipods = 4  && Horario
3551:                 loc_cFormatado = THIS.FormatarHorarioValidado(loc_cValor)
3552:                 IF EMPTY(loc_cFormatado)
3553:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3554:                 ELSE
3555:                     REPLACE Campo1is WITH loc_cFormatado IN cursor_4c_Tds
3556:                     IF EMPTY(cursor_4c_Tds.Campo1fs) OR VAL(STRTRAN(loc_cFormatado, ":", "")) > VAL(STRTRAN(cursor_4c_Tds.Campo1fs, ":", ""))
3557:                         REPLACE Campo1fs WITH loc_cFormatado IN cursor_4c_Tds
3558:                     ENDIF
3559:                 ENDIF
3560: 
3561:             OTHERWISE  && 5 = Data (Campo3is/Campo3fs, DATETIME - VFP valida o tipo na propria coluna)
3562:                 IF !EMPTY(cursor_4c_Tds.Campo3fs) AND cursor_4c_Tds.Campo3is > cursor_4c_Tds.Campo3fs
3563:                     REPLACE Campo3fs WITH cursor_4c_Tds.Campo3is IN cursor_4c_Tds
3564:                 ENDIF
3565:         ENDCASE
3566: 
3567:         loc_oGD.Refresh()
3568:     ENDPROC
3569: 
3570:     PROCEDURE GradeDColumn2When()
3571:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial()
3572:     ENDPROC
3573: 
3574:     PROCEDURE GradeDColumn2Valid()
3575:         LOCAL loc_oGD, loc_cValor, loc_nDiaIni, loc_cFormatado
3576: 
3577:         IF !USED("cursor_4c_Tdt") OR !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tdt") OR EOF("cursor_4c_Tds")
3578:             RETURN
3579:         ENDIF
3580: 
3581:         loc_oGD    = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3582:         loc_cValor = ALLTRIM(loc_oGD.Column2.Text1.Value)
3583: 
3584:         IF EMPTY(loc_cValor)
3585:             RETURN
3586:         ENDIF
3587: 
3588:         DO CASE
3589:             CASE cursor_4c_Tdt.tipods = 2  && Dia da Semana
3590:                 IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3591:                     MsgAviso("Dia da semana inv" + CHR(225) + "lido.", "")
3592:                     RETURN
3593:                 ENDIF
3594:                 IF SEEK(PADR(UPPER(ALLTRIM(cursor_4c_Tds.Campo1is)), 7), "cursor_4c_DiaSemana", "Descrs")
3595:                     loc_nDiaIni = cursor_4c_DiaSemana.nDias
3596:                     IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs") OR cursor_4c_DiaSemana.nDias < loc_nDiaIni
3597:                         MsgAviso("Dia final n" + CHR(227) + "o pode ser anterior ao dia inicial !!!", "")
3598:                         RETURN
3599:                     ENDIF
3600:                 ENDIF
3601:                 =SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3602:                 REPLACE Campo1fs WITH ALLTRIM(cursor_4c_DiaSemana.Descrs) IN cursor_4c_Tds
3603: 
3604:             CASE cursor_4c_Tdt.tipods = 3  && Dia do Mes
3605:                 IF !BETWEEN(VAL(loc_cValor), 1, 31)
3606:                     MsgAviso("Dia do m" + CHR(234) + "s deve ser entre 1 e 31 !!!", "")
3607:                     RETURN
3608:                 ENDIF
3609:                 IF VAL(loc_cValor) < VAL(cursor_4c_Tds.Campo1is)
3610:                     MsgAviso("Intervalo de dias inv" + CHR(225) + "lido. O dia final " + CHR(233) + " menor que o inicial.", "")
3611:                     RETURN
3612:                 ENDIF
3613:                 REPLACE Campo1fs WITH PADL(TRANSFORM(INT(VAL(loc_cValor))), 2, "0") IN cursor_4c_Tds
3614: 
3615:             CASE cursor_4c_Tdt.tipods = 4  && Horario
3616:                 loc_cFormatado = THIS.FormatarHorarioValidado(loc_cValor)
3617:                 IF EMPTY(loc_cFormatado)
3618:                     RETURN
3619:                 ENDIF
3620:                 IF VAL(STRTRAN(loc_cFormatado, ":", "")) < VAL(STRTRAN(cursor_4c_Tds.Campo1is, ":", ""))
3621:                     MsgAviso("Intervalo de hor" + CHR(225) + "rio inv" + CHR(225) + "lido. A hora final " + CHR(233) + " menor que a inicial.", "")
3622:                     RETURN
3623:                 ENDIF
3624:                 REPLACE Campo1fs WITH loc_cFormatado IN cursor_4c_Tds
3625: 
3626:             OTHERWISE  && 5 = Data
3627:                 IF cursor_4c_Tds.Campo3fs < cursor_4c_Tds.Campo3is
3628:                     MsgAviso("Data final n" + CHR(227) + "o pode ser menor que a inicial !!!", "")
3629:                 ENDIF
3630:         ENDCASE
3631: 
3632:         loc_oGD.Refresh()
3633:     ENDPROC
3634: 
3635:     *--------------------------------------------------------------------------
3636:     * GradeD Column3/Column4 - faixa de horario dentro do dia (Campo2is/fs).
3637:     * Nao se aplica quando o Tipo de Desconto ja e "Horario" (Column1/2)
3638:     * PUBLIC: BINDEVENT requer metodo publico
3639:     *--------------------------------------------------------------------------
3640:     PROCEDURE GradeDColumn3When()
3641:         LOCAL loc_nTipoDs
3642:         loc_nTipoDs = 0
3643:         IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
3644:             loc_nTipoDs = cursor_4c_Tdt.tipods
3645:         ENDIF
3646:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial() AND loc_nTipoDs != 4
3647:     ENDPROC
3648: 
3649:     PROCEDURE GradeDColumn3Valid()
3650:         LOCAL loc_oGD, loc_cFormatado
3651: 
3652:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3653:             RETURN
3654:         ENDIF
3655: 
3656:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3657:         loc_cFormatado = THIS.FormatarHorarioValidado(ALLTRIM(loc_oGD.Column3.Text1.Value))
3658:         IF EMPTY(loc_cFormatado)
3659:             RETURN
3660:         ENDIF
3661: 
3662:         REPLACE Campo2is WITH loc_cFormatado IN cursor_4c_Tds
3663:         IF EMPTY(cursor_4c_Tds.Campo2fs) OR VAL(STRTRAN(loc_cFormatado, ":", "")) > VAL(STRTRAN(cursor_4c_Tds.Campo2fs, ":", ""))
3664:             REPLACE Campo2fs WITH loc_cFormatado IN cursor_4c_Tds
3665:         ENDIF
3666: 
3667:         loc_oGD.Refresh()
3668:     ENDPROC
3669: 
3670:     PROCEDURE GradeDColumn4When()
3671:         RETURN THIS.GradeDColumn3When()
3672:     ENDPROC
3673: 
3674:     PROCEDURE GradeDColumn4Valid()
3675:         LOCAL loc_oGD, loc_cFormatado
3676: 
3677:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3678:             RETURN
3679:         ENDIF
3680: 
3681:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3682:         loc_cFormatado = THIS.FormatarHorarioValidado(ALLTRIM(loc_oGD.Column4.Text1.Value))
3683:         IF EMPTY(loc_cFormatado)
3684:             RETURN
3685:         ENDIF
3686: 
3687:         IF VAL(STRTRAN(loc_cFormatado, ":", "")) < VAL(STRTRAN(cursor_4c_Tds.Campo2is, ":", ""))
3688:             MsgAviso("Intervalo de horas inv" + CHR(225) + "lido. A hora final " + CHR(233) + " menor que a inicial.", "")
3689:             RETURN
3690:         ENDIF
3691: 
3692:         REPLACE Campo2fs WITH loc_cFormatado IN cursor_4c_Tds
3693:         loc_oGD.Refresh()
3694:     ENDPROC
3695: 
3696:     *--------------------------------------------------------------------------
3697:     * GradeD Column5/Column6 - Preco/Fator da faixa. Column6 (Fator), ao
3698:     * confirmar com ENTER, cria automaticamente uma nova faixa em branco
3699:     * (equivalente ao legado)
3700:     * PUBLIC: BINDEVENT requer metodo publico
3701:     *--------------------------------------------------------------------------
3702:     PROCEDURE GradeDColumn5When()
3703:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial()
3704:     ENDPROC
3705: 
3706:     PROCEDURE GradeDColumn6Valid()
3707:         LOCAL loc_oGD
3708: 
3709:         IF LASTKEY() != 13 OR !USED("cursor_4c_Tds") OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3710:             RETURN
3711:         ENDIF
3712: 
3713:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3714: 
3715:         SELECT cursor_4c_Tds
3716:         SKIP
3717:         IF EOF()
3718:             APPEND BLANK
3719:             REPLACE cidchaves WITH fUniqueIds(), ;
3720:                     codigos   WITH ALLTRIM(cursor_4c_Tdt.codigos), ;
3721:                     tipos     WITH cursor_4c_Tdt.tipos, ;
3722:                     codtips   WITH ALLTRIM(cursor_4c_Tdt.codtips), ;
3723:                     tipods    WITH cursor_4c_Tdt.tipods, ;
3724:                     campo2is  WITH "00:00", ;
3725:                     campo2fs  WITH "23:59" IN cursor_4c_Tds
3726:             GO BOTTOM IN cursor_4c_Tds
3727:         ENDIF
3728: 
3729:         loc_oGD.Refresh()
3730:     ENDPROC
3731: 
3732:     *--------------------------------------------------------------------------
3733:     * BtnExcluirFaixaDescontoClick - remove a faixa corrente de grd_4c_GradeD;
3734:     * garante que sempre reste ao menos uma faixa (equivalente ao legado)
3735:     * PUBLIC: BINDEVENT requer metodo publico
3736:     *--------------------------------------------------------------------------
3737:     PROCEDURE BtnExcluirFaixaDescontoClick()
3738:         LOCAL loc_oGD, loc_nRegistros
3739: 
3740:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tds") ;
3741:                 OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3742:             RETURN
3743:         ENDIF
3744: 
3745:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3746: 
3747:         SELECT cursor_4c_Tds
3748:         IF !EOF()
3749:             DELETE
3750:         ENDIF
3751: 
3752:         COUNT FOR !DELETED() TO loc_nRegistros
3753:         IF loc_nRegistros = 0
3754:             APPEND BLANK
3755:             REPLACE cidchaves WITH fUniqueIds(), ;
3756:                     codigos   WITH ALLTRIM(cursor_4c_Tdt.codigos), ;
3757:                     tipos     WITH cursor_4c_Tdt.tipos, ;
3758:                     codtips   WITH ALLTRIM(cursor_4c_Tdt.codtips), ;
3759:                     tipods    WITH cursor_4c_Tdt.tipods, ;
3760:                     campo2is  WITH "00:00", ;
3761:                     campo2fs  WITH "23:59" IN cursor_4c_Tds
3762:         ENDIF
3763: 
3764:         GO TOP IN cursor_4c_Tds
3765:         loc_oGD.Refresh()
3766:         loc_oGD.SetFocus
3767:     ENDPROC
3768: 
3769:     *--------------------------------------------------------------------------
3770:     * MontarComissoesDesconto - Equivalente ao "MontaTbCom" do legado.
3771:     * Filtra localmente cursor_4c_Tdi pela combinacao Tipo+Codigo da linha
3772:     * corrente de grd_4c_Gradei (cursor_4c_Tdt) e atualiza grd_4c_Gradec.
3773:     *--------------------------------------------------------------------------
3774:     PROTECTED PROCEDURE MontarComissoesDesconto()
3775:         LOCAL loc_oGradec, loc_nTipos, loc_cCodTips
3776: 
3777:         loc_oGradec = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec
3778: 
3779:         IF !USED("cursor_4c_Tdi")
3780:             RETURN
3781:         ENDIF
3782: 
3783:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3784:             SELECT cursor_4c_Tdi
3785:             SET FILTER TO .F.
3786:             loc_oGradec.Refresh()
3787:             RETURN
3788:         ENDIF
3789: 
3790:         loc_nTipos   = cursor_4c_Tdt.tipos
3791:         loc_cCodTips = ALLTRIM(cursor_4c_Tdt.codtips)
3792: 
3793:         SELECT cursor_4c_Tdi
3794:         SET FILTER TO tipos = loc_nTipos AND ALLTRIM(codtips) = loc_cCodTips
3795:         GO TOP IN cursor_4c_Tdi
3796:         loc_oGradec.Refresh()
3797:     ENDPROC
3798: 
3799:     *--------------------------------------------------------------------------
3800:     * GradeiDescAfterRowColChange - troca de linha em grd_4c_Gradei (pagina
3801:     * "Descontos / Comissoes"): marca a linha corrente (flag "regs",
3802:     * compartilhada com grd_4c_GradeI de PgConfDesconto), refresca os
3803:     * controles bindados a cursor_4c_Tdt (formulas 1a/2a, comissao, fator/
3804:     * descritivo, ignora cotacao) e reconfigura grd_4c_Gradec (comissoes)
3805:     * PUBLIC: BINDEVENT requer metodo publico + parametro do evento
3806:     *--------------------------------------------------------------------------
3807:     PROCEDURE GradeiDescAfterRowColChange(par_nColIndex)
3808:         LOCAL loc_oCnt
3809: 
3810:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3811:             RETURN
3812:         ENDIF
3813: 
3814:         SELECT cursor_4c_Tdt
3815:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3816:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3817: 
3818:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
3819:         loc_oCnt.grd_4c_Gradei.Refresh()
3820:         loc_oCnt.cnt_4c_Formula1.Refresh()
3821:         loc_oCnt.cnt_4c_Formula2.Refresh()
3822:         loc_oCnt.cbo_4c_ComboComis.Refresh()
3823:         loc_oCnt.txt_4c_DescFats.Refresh()
3824:         loc_oCnt.txt_4c_FatorPads.Refresh()
3825:         loc_oCnt.chk_4c_IgnoraCotacao.Refresh()
3826: 
3827:         *-- grd_4c_GradeI de PgConfDesconto compartilha a mesma cursor_4c_Tdt
3828:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3829: 
3830:         THIS.MontarComissoesDesconto()
3831:     ENDPROC
3832: 
3833:     *--------------------------------------------------------------------------
3834:     * GradeiDescColunaEditavelWhen - habilita edicao das colunas de
3835:     * grd_4c_Gradei (Tipo/Codigo/Valor/Fator/Exclui) apenas em INCLUIR/
3836:     * ALTERAR (equivalente ao When original de cada coluna)
3837:     * PUBLIC: BINDEVENT requer metodo publico
3838:     *--------------------------------------------------------------------------
3839:     PROCEDURE GradeiDescColunaEditavelWhen()
3840:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3841:     ENDPROC
3842: 
3843:     *--------------------------------------------------------------------------
3844:     * GradeiDescColumn5Valid - valida coluna "E" (texclus): apenas S, N ou
3845:     * vazio (equivalente ao legado)
3846:     * PUBLIC: BINDEVENT requer metodo publico
3847:     *--------------------------------------------------------------------------
3848:     PROCEDURE GradeiDescColumn5Valid()
3849:         LOCAL loc_oText, loc_cValor
3850: 
3851:         loc_oText = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradei.Column5.Text1
3852:         loc_cValor = UPPER(ALLTRIM(loc_oText.Value))
3853: 
3854:         IF !INLIST(loc_cValor, "S", "N", "")
3855:             MsgAviso("Dados Inv" + CHR(225) + "lidos. Informe [S/N/ ]", "")
3856:             RETURN .F.
3857:         ENDIF
3858: 
3859:         RETURN .T.
3860:     ENDPROC
3861: 
3862:     *--------------------------------------------------------------------------
3863:     * GradeiDescCodigoKeyPress / GradeiDescCodigoDblClick - F4/DblClick para
3864:     * lookup do codigo da linha de composicao (Column2), conforme o Tipo
3865:     * (Column1) selecionado na mesma linha
3866:     * PUBLIC: BINDEVENT requer metodo publico + parametros do evento
3867:     *--------------------------------------------------------------------------
3868:     PROCEDURE GradeiDescCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3869:         IF par_nKeyCode = 28  && F4
3870:             THIS.AbrirLookupCodigoComposicao()
3871:         ENDIF
3872:     ENDPROC
3873: 
3874:     PROCEDURE GradeiDescCodigoDblClick()
3875:         THIS.AbrirLookupCodigoComposicao()
3876:     ENDPROC
3877: 
3878:     *--------------------------------------------------------------------------
3879:     * AbrirLookupCodigoComposicao - Busca o codigo da linha corrente de
3880:     * grd_4c_Gradei (cursor_4c_Tdt.codtips) na tabela correspondente ao
3881:     * Tipo (cursor_4c_Tdt.tipos), igual ao Do Case do legado:
3882:     * 1=Grupo(SigCdGrp/cgrus) 2=Linha(SigCdLin/linhas) 3=Gr.Venda(SigCdCol/
3883:     * colecoes) 4=Produto(SigCdPro/cpros) 5=Moeda(SigCdMoe/cmoes)
3884:     * 6=Unidade(SigCdUni/cunis) 7=Feitio(SigPrFti/cods) 8=SubGrupo(SigCdPsg/
3885:     * codigos) 9=Finalidade(SigCdFip/cods)
3886:     *--------------------------------------------------------------------------
3887:     PROCEDURE AbrirLookupCodigoComposicao()
3888:         LOCAL loc_oGradei, loc_nTipos, loc_cTabela, loc_cCampo, loc_cDescCampo, ;
3889:               loc_cTitulo, loc_cValor, loc_oBusca
3890: 
3891:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3892:             RETURN
3893:         ENDIF
3894: 
3895:         loc_oGradei = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradei
3896:         loc_nTipos  = cursor_4c_Tdt.tipos
3897:         loc_cValor  = ALLTRIM(cursor_4c_Tdt.codtips)
3898: 
3899:         DO CASE
3900:             CASE loc_nTipos = 1
3901:                 loc_cTabela = "SigCdGrp"  && Grupo
3902:                 loc_cCampo = "cgrus"
3903:                 loc_cDescCampo = "dgrus"
3904:                 loc_cTitulo = "Grupos"
3905:             CASE loc_nTipos = 2
3906:                 loc_cTabela = "SigCdLin"  && Linha
3907:                 loc_cCampo = "linhas"
3908:                 loc_cDescCampo = "descs"
3909:                 loc_cTitulo = "Linhas"
3910:             CASE loc_nTipos = 3
3911:                 loc_cTabela = "SigCdCol"  && Gr. Venda
3912:                 loc_cCampo = "colecoes"
3913:                 loc_cDescCampo = "descs"
3914:                 loc_cTitulo = "Grupos de Venda"
3915:             CASE loc_nTipos = 4
3916:                 loc_cTabela = "SigCdPro"  && Produto
3917:                 loc_cCampo = "cpros"
3918:                 loc_cDescCampo = "dpros"
3919:                 loc_cTitulo = "Produtos"
3920:             CASE loc_nTipos = 5
3921:                 loc_cTabela = "SigCdMoe"  && Moeda
3922:                 loc_cCampo = "cmoes"
3923:                 loc_cDescCampo = "dmoes"
3924:                 loc_cTitulo = "Moedas"
3925:             CASE loc_nTipos = 6
3926:                 loc_cTabela = "SigCdUni"  && Unidade
3927:                 loc_cCampo = "cunis"

*-- Linhas 3943 a 4212:
3943:                 loc_cDescCampo = "descs"
3944:                 loc_cTitulo = "Finalidade"
3945:             OTHERWISE
3946:                 MsgAviso("Selecione o Tipo antes de buscar o C" + CHR(243) + "digo.", "")
3947:                 RETURN
3948:         ENDCASE
3949: 
3950:         TRY
3951:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3952:                 loc_cTabela, "cursor_4c_BuscaComposicao", loc_cCampo, loc_cValor, ;
3953:                 loc_cTitulo)
3954: 
3955:             IF VARTYPE(loc_oBusca) = "O"
3956:                 IF !loc_oBusca.this_lAchouRegistro
3957:                     loc_oBusca.mAddColuna(loc_cCampo, "", "C" + CHR(243) + "digo")
3958:                     loc_oBusca.mAddColuna(loc_cDescCampo, "", "Descri" + CHR(231) + CHR(227) + "o")
3959:                     loc_oBusca.Show()
3960:                 ENDIF
3961: 
3962:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaComposicao")
3963:                     SELECT cursor_4c_BuscaComposicao
3964:                     REPLACE codtips WITH ALLTRIM(EVALUATE("cursor_4c_BuscaComposicao." + loc_cCampo)) IN cursor_4c_Tdt
3965:                     loc_oGradei.Refresh()
3966:                 ENDIF
3967: 
3968:                 loc_oBusca.Release()
3969:             ENDIF
3970:         CATCH TO loException
3971:             MostrarErro(loException, "FormTbv.AbrirLookupCodigoComposicao")
3972:         ENDTRY
3973: 
3974:         IF USED("cursor_4c_BuscaComposicao")
3975:             USE IN cursor_4c_BuscaComposicao
3976:         ENDIF
3977:     ENDPROC
3978: 
3979:     *--------------------------------------------------------------------------
3980:     * BtnInserirComposicaoClick - Inclui uma nova linha de composicao
3981:     * (cursor_4c_Tdt) para o codigo corrente
3982:     * PUBLIC: BINDEVENT requer metodo publico
3983:     *--------------------------------------------------------------------------
3984:     PROCEDURE BtnInserirComposicaoClick()
3985:         LOCAL loc_oPgDesc
3986: 
3987:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt")
3988:             RETURN
3989:         ENDIF
3990: 
3991:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
3992: 
3993:         INSERT INTO cursor_4c_Tdt (codigos) VALUES (ALLTRIM(THIS.this_oBusinessObject.this_cCodigo))
3994:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3995:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3996: 
3997:         loc_oPgDesc.grd_4c_Gradei.Refresh()
3998:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3999:         loc_oPgDesc.grd_4c_Gradei.Column1.SetFocus
4000:         THIS.MontarComissoesDesconto()
4001:     ENDPROC
4002: 
4003:     *--------------------------------------------------------------------------
4004:     * BtnExcluirComposicaoClick - Remove a linha corrente de composicao
4005:     * (cursor_4c_Tdt); bloqueia se ainda houver comissoes vinculadas
4006:     * (equivalente ao legado - "Exclua primeiro as comissoes...")
4007:     * PUBLIC: BINDEVENT requer metodo publico
4008:     *--------------------------------------------------------------------------
4009:     PROCEDURE BtnExcluirComposicaoClick()
4010:         LOCAL loc_oPgDesc
4011: 
4012:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
4013:             RETURN
4014:         ENDIF
4015: 
4016:         THIS.MontarComissoesDesconto()
4017:         IF USED("cursor_4c_Tdi") AND !EOF("cursor_4c_Tdi")
4018:             MsgAviso("Imposs" + CHR(237) + "vel excluir!!! Exclua primeiro as comiss" + CHR(245) + "es...", "")
4019:             RETURN
4020:         ENDIF
4021: 
4022:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
4023: 
4024:         SELECT cursor_4c_Tdt
4025:         DELETE
4026:         GO BOTTOM IN cursor_4c_Tdt
4027:         IF !EOF("cursor_4c_Tdt")
4028:             REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
4029:             REPLACE regs WITH 1 IN cursor_4c_Tdt
4030:         ENDIF
4031: 
4032:         loc_oPgDesc.grd_4c_Gradei.Refresh()
4033:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
4034:         loc_oPgDesc.grd_4c_Gradei.Column1.SetFocus
4035:         THIS.MontarComissoesDesconto()
4036:     ENDPROC
4037: 
4038:     *--------------------------------------------------------------------------
4039:     * BtnInserirComissaoClick - Inclui uma nova comissao (cursor_4c_Tdi)
4040:     * para a linha corrente de composicao (Tipo/Codigo)
4041:     * PUBLIC: BINDEVENT requer metodo publico
4042:     *--------------------------------------------------------------------------
4043:     PROCEDURE BtnInserirComissaoClick()
4044:         LOCAL loc_oPgDesc
4045: 
4046:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt") ;
4047:                 OR EOF("cursor_4c_Tdt") OR !USED("cursor_4c_Tdi")
4048:             RETURN
4049:         ENDIF
4050: 
4051:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
4052: 
4053:         INSERT INTO cursor_4c_Tdi (codigos, tipos, codtips) VALUES ;
4054:             (ALLTRIM(THIS.this_oBusinessObject.this_cCodigo), cursor_4c_Tdt.tipos, ALLTRIM(cursor_4c_Tdt.codtips))
4055: 
4056:         THIS.MontarComissoesDesconto()
4057:         loc_oPgDesc.grd_4c_Gradec.Column1.SetFocus
4058:     ENDPROC
4059: 
4060:     *--------------------------------------------------------------------------
4061:     * BtnExcluirComissaoClick - Remove a comissao corrente (cursor_4c_Tdi)
4062:     * PUBLIC: BINDEVENT requer metodo publico
4063:     *--------------------------------------------------------------------------
4064:     PROCEDURE BtnExcluirComissaoClick()
4065:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdi") OR EOF("cursor_4c_Tdi")
4066:             RETURN
4067:         ENDIF
4068: 
4069:         SELECT cursor_4c_Tdi
4070:         DELETE
4071:         GO BOTTOM IN cursor_4c_Tdi
4072: 
4073:         THIS.MontarComissoesDesconto()
4074:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec.Column1.SetFocus
4075:     ENDPROC
4076: 
4077:     *--------------------------------------------------------------------------
4078:     * GradecColumn1Valid / GradecColumn2Valid - Grupo/Conta da comissao.
4079:     * Simplificado em relacao ao legado: NAO reproduz as checagens de
4080:     * acesso contabil (fAcessoContab/fAcessoContas do Framework legado -
4081:     * fora do escopo desta migracao). Column2 (Conta) valida contra
4082:     * SigCdCli e preenche automaticamente o Grupo quando vazio.
4083:     * PUBLIC: BINDEVENT requer metodo publico
4084:     *--------------------------------------------------------------------------
4085:     PROCEDURE GradecColumn1Valid()
4086:         RETURN .T.
4087:     ENDPROC
4088: 
4089:     PROCEDURE GradecColumn2Valid()
4090:         LOCAL loc_oGradec, loc_cConta, loc_cSQL
4091: 
4092:         IF !USED("cursor_4c_Tdi") OR EOF("cursor_4c_Tdi")
4093:             RETURN .T.
4094:         ENDIF
4095: 
4096:         loc_oGradec = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec
4097:         loc_cConta  = ALLTRIM(loc_oGradec.Column2.Text1.Value)
4098: 
4099:         IF EMPTY(loc_cConta)
4100:             RETURN .T.
4101:         ENDIF
4102: 
4103:         TRY
4104:             loc_cSQL = "SELECT iclis, grupos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
4105: 
4106:             IF USED("cursor_4c_BuscaConta")
4107:                 USE IN cursor_4c_BuscaConta
4108:             ENDIF
4109: 
4110:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") < 1 OR !USED("cursor_4c_BuscaConta") OR EOF("cursor_4c_BuscaConta")
4111:                 MsgAviso("Conta Inv" + CHR(225) + "lida !!!", "Acesso Negado")
4112:                 IF USED("cursor_4c_BuscaConta")
4113:                     USE IN cursor_4c_BuscaConta
4114:                 ENDIF
4115:                 loc_lResultado = .F.
4116:             ENDIF
4117: 
4118:             REPLACE contas WITH loc_cConta IN cursor_4c_Tdi
4119:             IF EMPTY(ALLTRIM(cursor_4c_Tdi.grupos))
4120:                 REPLACE grupos WITH ALLTRIM(TratarNulo(cursor_4c_BuscaConta.grupos, "C")) IN cursor_4c_Tdi
4121:             ENDIF
4122:             loc_oGradec.Refresh()
4123:         CATCH TO loException
4124:             MostrarErro(loException, "FormTbv.GradecColumn2Valid")
4125:         ENDTRY
4126: 
4127:         IF USED("cursor_4c_BuscaConta")
4128:             USE IN cursor_4c_BuscaConta
4129:         ENDIF
4130: 
4131:         RETURN .T.
4132:     ENDPROC
4133: 
4134:     *--------------------------------------------------------------------------
4135:     * TornarControlesVisiveis - Torna controles do container visiveis (recursivo)
4136:     *--------------------------------------------------------------------------
4137:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4138:         LOCAL loc_nI, loc_oControl
4139: 
4140:         IF VARTYPE(par_oContainer) != "O"
4141:             RETURN
4142:         ENDIF
4143: 
4144:         FOR loc_nI = 1 TO par_oContainer.ControlCount
4145:             loc_oControl = par_oContainer.Controls(loc_nI)
4146: 
4147:             IF PEMSTATUS(loc_oControl, "Visible", 5)
4148:                 loc_oControl.Visible = .T.
4149:             ENDIF
4150: 
4151:             *-- Trata PageFrame - itera Pages
4152:             IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
4153:                 LOCAL loc_nP
4154:                 FOR loc_nP = 1 TO loc_oControl.PageCount
4155:                     THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
4156:                 ENDFOR
4157:             ENDIF
4158: 
4159:             *-- Trata containers com ControlCount
4160:             IF PEMSTATUS(loc_oControl, "ControlCount", 5)
4161:                 THIS.TornarControlesVisiveis(loc_oControl)
4162:             ENDIF
4163:         ENDFOR
4164:     ENDPROC
4165: 
4166:     *--------------------------------------------------------------------------
4167:     * FormatarGridLista - Formata visual do grid da lista
4168:     *--------------------------------------------------------------------------
4169:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
4170:         IF VARTYPE(par_oGrid) != "O"
4171:             RETURN
4172:         ENDIF
4173: 
4174:         WITH par_oGrid
4175:             .FontName = "Tahoma"
4176:             .FontSize = 8
4177:         ENDWITH
4178:     ENDPROC
4179: 
4180:     *--------------------------------------------------------------------------
4181:     * Destroy - Liberacao de recursos
4182:     *--------------------------------------------------------------------------
4183:     PROCEDURE Destroy()
4184:         TRY
4185:             IF USED("cursor_4c_Dados")
4186:                 USE IN cursor_4c_Dados
4187:             ENDIF
4188:             IF USED("cursor_4c_TipoDesconto")
4189:                 USE IN cursor_4c_TipoDesconto
4190:             ENDIF
4191:             IF USED("cursor_4c_Empresas")
4192:                 USE IN cursor_4c_Empresas
4193:             ENDIF
4194:             IF USED("cursor_4c_Tdt")
4195:                 USE IN cursor_4c_Tdt
4196:             ENDIF
4197:             IF USED("cursor_4c_Tdi")
4198:                 USE IN cursor_4c_Tdi
4199:             ENDIF
4200:             IF USED("cursor_4c_Tds")
4201:                 USE IN cursor_4c_Tds
4202:             ENDIF
4203:             IF USED("cursor_4c_DiaSemana")
4204:                 USE IN cursor_4c_DiaSemana
4205:             ENDIF
4206:         CATCH TO loException
4207:             *-- Ignorar erros na destruicao
4208:         ENDTRY
4209:         DODEFAULT()
4210:     ENDPROC
4211: 
4212: ENDDEFINE


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

