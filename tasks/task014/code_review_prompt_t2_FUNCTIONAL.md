# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (37)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [CARGA-DADOS] Metodo ValidarAliqIPI faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_DescLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_DescLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MatPLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MatPLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_DesccpLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_DesccpLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MatsubLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MatsubLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_CmkpcLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_CmkpcLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MoedaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MoedaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_FtioLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_FtioLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MoepvLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MoepvLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MoevLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MoevLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MoecLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MoecLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MoecusfLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MoecusfLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarGruccus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarGruccusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDgruccus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDgruccusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarContaccus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarContaccusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDcontaccus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDcontaccusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarClfiscal' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarClfiscalValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDclfiscal' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDclfiscalValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarOrigmerc' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarOrigmercValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDorigmerc' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDorigmercValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarSittricms' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarSittricmsValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDsittricms' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDsittricmsValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCodServs' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCodServsValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarTptribs' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarTptribsValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarMoedaEstimada' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarMoedaEstimadaValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDesc()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDescSgru()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Top original=32 vs migrado 'lbl_4c_Label1' Top=473 (diff=441px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=171 vs migrado 'cnt_4c_Botoes' Top=29 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=959 vs migrado 'cnt_4c_Botoes' Left=542 (diff=417px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Top original=5 vs migrado 'lbl_4c_Label8' Top=542 (diff=537px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Left original=8 vs migrado 'lbl_4c_Label8' Left=161 (diff=153px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=134 vs migrado 'lbl_4c_Label24' Top=542 (diff=408px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=58 vs migrado 'lbl_4c_Label24' Left=324 (diff=266px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAltura' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=474 vs migrado 'lbl_4c_LblAltura' Top=250 (diff=224px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAltura' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=749 vs migrado 'lbl_4c_LblAltura' Left=881 (diff=132px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (13541 linhas total):

*-- Linhas 53 a 395:
53:     *--------------------------------------------------------------------------
54:     * Init - Inicializacao do formulario
55:     *--------------------------------------------------------------------------
56:     PROCEDURE Init()
57:         RETURN DODEFAULT()
58:     ENDPROC
59: 
60:     *--------------------------------------------------------------------------
61:     * InicializarForm - Configuracao inicial do formulario
62:     *--------------------------------------------------------------------------
63:     PROTECTED PROCEDURE InicializarForm()
64:         LOCAL loc_lSucesso
65:         loc_lSucesso = .F.
66: 
67:         TRY
68:             *-- Guard: evitar loops de SQL durante validacao UI
69:             IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
70:                 gb_4c_ValidandoUI = .F.
71:             ENDIF
72: 
73:             *-- Criar instancia do Business Object
74:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
75: 
76:             IF ISNULL(THIS.this_oBusinessObject)
77:                 MsgErro("Erro ao criar Business Object ProdutoBO", "FormProduto.InicializarForm")
78:                 loc_lSucesso = .F.
79:             ELSE
80:                 THIS.ConfigurarPageFrame()
81:                 THIS.ConfigurarPaginaLista()
82:                 THIS.ConfigurarPaginaDados()
83:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
84: 
85:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
86:                     IF !THIS.CarregarLista()
87:                         *-- Se falhar ao carregar, nao impede abertura
88:                     ENDIF
89:                 ENDIF
90: 
91:                 THIS.pgf_4c_Paginas.Visible    = .T.
92:                 THIS.pgf_4c_Paginas.ActivePage = 1
93:                 THIS.this_cModoAtual           = "LISTA"
94:                 loc_lSucesso = .T.
95:             ENDIF
96: 
97:         CATCH TO loc_oErro
98:             MsgErro("Erro ao inicializar FormProduto:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "FormProduto.InicializarForm")
99:             loc_lSucesso = .F.
100:         ENDTRY
101: 
102:         RETURN loc_lSucesso
103:     ENDPROC
104: 
105:     *--------------------------------------------------------------------------
106:     * ConfigurarPageFrame - Configura o PageFrame principal (2 paginas)
107:     *--------------------------------------------------------------------------
108:     PROTECTED PROCEDURE ConfigurarPageFrame()
109:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
110: 
111:         WITH THIS.pgf_4c_Paginas
112:             .Top       = -29
113:             .Left      = 0
114:             .Width     = 1003
115:             .Height    = 660
116:             .PageCount = 2
117:             .Tabs      = .F.
118:             .Visible   = .T.
119: 
120:             .Page1.Caption  = "Lista"
121:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
122:             .Page1.BackColor = RGB(255, 255, 255)
123: 
124:             .Page2.Caption  = "Dados"
125:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
126:             .Page2.BackColor = RGB(255, 255, 255)
127:         ENDWITH
128:     ENDPROC
129: 
130:     *--------------------------------------------------------------------------
131:     * ConfigurarPaginaLista - Configura Page1 (Lista de Produtos)
132:     * Compensacao +29: Top_legado + 29
133:     * Grid legado: Grade top=173, left=38, width=922, height=409
134:     *--------------------------------------------------------------------------
135:     PROTECTED PROCEDURE ConfigurarPaginaLista()
136:         LOCAL loc_oPagina
137:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
138: 
139:         *-- Container cabecalho
140:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
141:         WITH loc_oPagina.cnt_4c_Cabecalho
142:             .Top         = 31
143:             .Left        = 0
144:             .Width       = 1020
145:             .Height      = 80
146:             .BackStyle   = 1
147:             .BackColor   = RGB(53, 53, 53)
148:             .BorderWidth = 0
149:             .Visible     = .T.
150:         ENDWITH
151: 
152:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
153:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
154:             .Caption   = "Cadastro de Produtos"
155:             .Top       = 20
156:             .Left      = 20
157:             .Width     = 400
158:             .Height    = 30
159:             .FontName  = "Tahoma"
160:             .FontSize  = 14
161:             .FontBold  = .T.
162:             .BackStyle = 0
163:             .ForeColor = RGB(255, 255, 255)
164:             .Visible   = .T.
165:         ENDWITH
166: 
167:         *-- Container de botoes CRUD (Grupo_op: Left=542 no legado, Top=0 -> 29)
168:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
169:         WITH loc_oPagina.cnt_4c_Botoes
170:             .Top         = 29
171:             .Left        = 542
172:             .Width       = 380
173:             .Height      = 85
174:             .BackStyle = 1
175:             .BackColor = RGB(53, 53, 53)
176:             .BorderWidth = 0
177:             .Visible     = .T.
178:         ENDWITH
179: 
180:         *-- Botao Incluir (Left=5)
181:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
182:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
183:             .Caption         = "Incluir"
184:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
185:             .PicturePosition = 13
186:             .Width           = 75
187:             .Height          = 75
188:             .Left            = 5
189:             .Top             = 5
190:             .FontName        = "Tahoma"
191:             .FontSize        = 8
192:             .Themes          = .F.
193:             .SpecialEffect   = 0
194:             .BackColor       = RGB(255, 255, 255)
195:             .ForeColor       = RGB(90, 90, 90)
196:             .Visible         = .T.
197:         ENDWITH
198:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
199: 
200:         *-- Botao Visualizar (Left=80)
201:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
202:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
203:             .Caption         = "Visualizar"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
205:             .PicturePosition = 13
206:             .Width           = 75
207:             .Height          = 75
208:             .Left            = 80
209:             .Top             = 5
210:             .FontName        = "Tahoma"
211:             .FontSize        = 8
212:             .Themes          = .F.
213:             .SpecialEffect   = 0
214:             .BackColor       = RGB(255, 255, 255)
215:             .ForeColor       = RGB(90, 90, 90)
216:             .Visible         = .T.
217:         ENDWITH
218:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
219: 
220:         *-- Botao Alterar (Left=155)
221:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
222:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
223:             .Caption         = "Alterar"
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
225:             .PicturePosition = 13
226:             .Width           = 75
227:             .Height          = 75
228:             .Left            = 155
229:             .Top             = 5
230:             .FontName        = "Tahoma"
231:             .FontSize        = 8
232:             .Themes          = .F.
233:             .SpecialEffect   = 0
234:             .BackColor       = RGB(255, 255, 255)
235:             .ForeColor       = RGB(90, 90, 90)
236:             .Visible         = .T.
237:         ENDWITH
238:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
239: 
240:         *-- Botao Excluir (Left=230)
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
243:             .Caption         = "Excluir"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
245:             .PicturePosition = 13
246:             .Width           = 75
247:             .Height          = 75
248:             .Left            = 230
249:             .Top             = 5
250:             .FontName        = "Tahoma"
251:             .FontSize        = 8
252:             .Themes          = .F.
253:             .SpecialEffect   = 0
254:             .BackColor       = RGB(255, 255, 255)
255:             .ForeColor       = RGB(90, 90, 90)
256:             .Visible         = .T.
257:         ENDWITH
258:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
259: 
260:         *-- Botao Buscar (Left=305)
261:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
262:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
263:             .Caption         = "Buscar"
264:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
265:             .PicturePosition = 13
266:             .Width           = 75
267:             .Height          = 75
268:             .Left            = 305
269:             .Top             = 5
270:             .FontName        = "Tahoma"
271:             .FontSize        = 8
272:             .Themes          = .F.
273:             .SpecialEffect   = 0
274:             .BackColor       = RGB(255, 255, 255)
275:             .ForeColor       = RGB(90, 90, 90)
276:             .Visible         = .T.
277:         ENDWITH
278:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
279: 
280:         *-- Container de saida separado (Left=917, Top=29)
281:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
282:         WITH loc_oPagina.cnt_4c_Saida
283:             .Top         = 29
284:             .Left        = 917
285:             .Width       = 90
286:             .Height      = 85
287:             .BackStyle = 1
288:             .BackColor = RGB(53, 53, 53)
289:             .BorderWidth = 0
290:             .Visible     = .T.
291:         ENDWITH
292: 
293:         *-- Botao Encerrar
294:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
295:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
296:             .Caption         = "Encerrar"
297:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
298:             .PicturePosition = 13
299:             .Width           = 75
300:             .Height          = 75
301:             .Left            = 5
302:             .Top             = 5
303:             .FontName        = "Tahoma"
304:             .FontSize        = 8
305:             .Themes          = .F.
306:             .SpecialEffect   = 0
307:             .BackColor       = RGB(255, 255, 255)
308:             .ForeColor       = RGB(90, 90, 90)
309:             .Visible         = .T.
310:         ENDWITH
311:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
312: 
313:         *-- Container de filtros (cntFiltros legado: continha getCgru/getDgru/getDtIni/Fim/optFilSituas)
314:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
315:         WITH loc_oPagina.cnt_4c_Filtros
316:             .Top         = 120
317:             .Left        = 12
318:             .Width       = 940
319:             .Height      = 55
320:             .BackStyle   = 0
321:             .BorderWidth = 0
322:             .Visible     = .T.
323:         ENDWITH
324: 
325:         *-- Filtro: Label Grupo
326:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
327:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
328:             .Caption   = "Grupo:"
329:             .Left      = 5
330:             .Top       = 8
331:             .Width     = 40
332:             .Height    = 15
333:             .FontName  = "Tahoma"
334:             .FontSize  = 8
335:             .BackStyle = 0
336:             .ForeColor = RGB(90, 90, 90)
337:             .Visible   = .T.
338:         ENDWITH
339: 
340:         *-- Filtro: Codigo do grupo
341:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroCgru", "TextBox")
342:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru
343:             .Value         = ""
344:             .Left          = 47
345:             .Top           = 3
346:             .Width         = 35
347:             .Height        = 22
348:             .FontName      = "Tahoma"
349:             .FontSize      = 8
350:             .SpecialEffect = 1
351:             .MaxLength     = 3
352:             .Visible       = .T.
353:         ENDWITH
354:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru, "KeyPress", THIS, "FiltroGrupo_KeyPress")
355:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru, "LostFocus", THIS, "ValidarFiltroGrupo")
356: 
357:         *-- Filtro: Descricao do grupo (leitura)
358:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDgru", "TextBox")
359:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDgru
360:             .Value         = ""
361:             .Left          = 84
362:             .Top           = 3
363:             .Width         = 156
364:             .Height        = 22
365:             .FontName      = "Tahoma"
366:             .FontSize      = 8
367:             .SpecialEffect = 1
368:             .ReadOnly      = .T.
369:             .Enabled       = .F.
370:             .Visible       = .T.
371:         ENDWITH
372: 
373:         *-- Filtro: Label Ultima alteracao
374:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData", "Label")
375:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData
376:             .Caption   = "Ult. Alt.:"
377:             .Left      = 248
378:             .Top       = 8
379:             .Width     = 52
380:             .Height    = 15
381:             .FontName  = "Tahoma"
382:             .FontSize  = 8
383:             .BackStyle = 0
384:             .ForeColor = RGB(90, 90, 90)
385:             .Visible   = .T.
386:         ENDWITH
387: 
388:         *-- Filtro: Data Inicio
389:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDataIni", "TextBox")
390:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDataIni
391:             .Value         = {}
392:             .Left          = 302
393:             .Top           = 3
394:             .Width         = 80
395:             .Height        = 22

*-- Linhas 429 a 627:
429:         ENDWITH
430: 
431:         *-- Filtro: Situacao (Todos/Ativos/Inativos) - legado: optFilSituas
432:         loc_oPagina.cnt_4c_Filtros.AddObject("opt_4c_FiltraSituas", "OptionGroup")
433:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas
434:             .Left        = 500
435:             .Top         = 3
436:             .Width       = 200
437:             .Height      = 25
438:             .ButtonCount = 3
439:             .BorderStyle = 0
440:             .Themes      = .F.
441:             .Value       = 1
442:             .Visible     = .T.
443:         ENDWITH
444:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas
445:             .Buttons(1).Caption   = "Todos"
446:             .Buttons(1).Left      = 0
447:             .Buttons(1).Top       = 0
448:             .Buttons(1).AutoSize  = .T.
449:             .Buttons(1).Themes    = .F.
450:             .Buttons(1).FontName  = "Tahoma"
451:             .Buttons(1).FontSize  = 8
452:             .Buttons(2).Caption   = "Ativos"
453:             .Buttons(2).Left      = 65
454:             .Buttons(2).Top       = 0
455:             .Buttons(2).AutoSize  = .T.
456:             .Buttons(2).Themes    = .F.
457:             .Buttons(2).FontName  = "Tahoma"
458:             .Buttons(2).FontSize  = 8
459:             .Buttons(3).Caption   = "Inativos"
460:             .Buttons(3).Left      = 130
461:             .Buttons(3).Top       = 0
462:             .Buttons(3).AutoSize  = .T.
463:             .Buttons(3).Themes    = .F.
464:             .Buttons(3).FontName  = "Tahoma"
465:             .Buttons(3).FontSize  = 8
466:         ENDWITH
467:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas, "InteractiveChange", THIS, "FiltroSituas_InteractiveChange")
468: 
469:         *-- Botao Pesquisar
470:         loc_oPagina.cnt_4c_Filtros.AddObject("cmd_4c_Pesquisar", "CommandButton")
471:         WITH loc_oPagina.cnt_4c_Filtros.cmd_4c_Pesquisar
472:             .Caption         = "Pesquisar"
473:             .Left            = 708
474:             .Top             = 2
475:             .Width           = 75
476:             .Height          = 22
477:             .FontName        = "Tahoma"
478:             .FontSize        = 8
479:             .Themes          = .F.
480:             .SpecialEffect   = 0
481:             .BackColor       = RGB(255, 255, 255)
482:             .ForeColor       = RGB(90, 90, 90)
483:             .Visible         = .T.
484:         ENDWITH
485:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.cmd_4c_Pesquisar, "Click", THIS, "BtnPesquisarClick")
486: 
487:         *-- Label contador de produtos (legado: lblProdutos top=584)
488:         loc_oPagina.AddObject("lbl_4c_ContadorProdutos", "Label")
489:         WITH loc_oPagina.lbl_4c_ContadorProdutos
490:             .Caption   = "0 produto(s)"
491:             .Top       = 583
492:             .Left      = 38
493:             .Width     = 200
494:             .Height    = 15
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .BackStyle = 0
498:             .ForeColor = RGB(90, 90, 90)
499:             .Visible   = .T.
500:         ENDWITH
501: 
502:         *-- Grid de lista (Grade: top=173, left=38, width=922, height=409)
503:         *-- 7 colunas: cpros, dpros, cgrus, sgrus, reffs, usuaalts, situacao
504:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
505:         WITH loc_oPagina.grd_4c_Lista
506:             .Top               = 182
507:             .Left              = 12
508:             .Width             = 940
509:             .Height            = 395
510:             .ReadOnly          = .T.
511:             .DeleteMark        = .F.
512:             .RecordMark        = .F.
513:             .ScrollBars        = 3
514:             .GridLines         = 3
515:             .ColumnCount       = 7
516:             .AllowHeaderSizing = .T.
517:             .Visible           = .T.
518:         ENDWITH
519:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdLista_DblClick")
520: 
521:         THIS.TornarControlesVisiveis(loc_oPagina)
522:     ENDPROC
523: 
524:     *--------------------------------------------------------------------------
525:     * ConfigurarPaginaDados - Configura Page2 (Dados do Produto)
526:     * Legado: Optiongroup1 top=5->34, pgframeDados top=-54->-54
527:     *--------------------------------------------------------------------------
528:     PROTECTED PROCEDURE ConfigurarPaginaDados()
529:         LOCAL loc_oPagina
530:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
531: 
532:         *-- Container de botoes Salvar/Cancelar (Top=34, Left=819)
533:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
534:         WITH loc_oPagina.cnt_4c_BotoesDados
535:             .Top         = 34
536:             .Left        = 819
537:             .Width       = 165
538:             .Height      = 85
539:             .BackStyle = 1
540:             .BackColor = RGB(53, 53, 53)
541:             .BorderWidth = 0
542:             .Visible     = .T.
543:         ENDWITH
544: 
545:         *-- Botao Salvar (Left=7, Top=5)
546:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
547:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
548:             .Caption         = "Salvar"
549:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
550:             .PicturePosition = 13
551:             .Width           = 75
552:             .Height          = 75
553:             .Left            = 7
554:             .Top             = 5
555:             .FontName        = "Tahoma"
556:             .FontSize        = 8
557:             .Themes          = .F.
558:             .SpecialEffect   = 0
559:             .BackColor       = RGB(255, 255, 255)
560:             .ForeColor       = RGB(90, 90, 90)
561:             .Visible         = .T.
562:         ENDWITH
563:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
564: 
565:         *-- Botao Cancelar (Left=83, Top=5)
566:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
567:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
568:             .Caption         = "Cancelar"
569:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
570:             .PicturePosition = 13
571:             .Width           = 75
572:             .Height          = 75
573:             .Left            = 83
574:             .Top             = 5
575:             .FontName        = "Tahoma"
576:             .FontSize        = 8
577:             .Themes          = .F.
578:             .SpecialEffect   = 0
579:             .BackColor       = RGB(255, 255, 255)
580:             .ForeColor       = RGB(90, 90, 90)
581:             .Visible         = .T.
582:         ENDWITH
583:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
584: 
585:         *-- OptionGroup para navegacao entre abas internas
586:         *-- Legado: Optiongroup1 top=5->34, left=5, width=535, height=85, buttonCount=7
587:         loc_oPagina.AddObject("opt_4c_Abas", "OptionGroup")
588:         WITH loc_oPagina.opt_4c_Abas
589:             .Left        = 5
590:             .Top         = 34
591:             .Width       = 800
592:             .Height      = 85
593:             .ButtonCount = 7
594:             .BorderStyle = 0
595:             .Themes      = .F.
596:             .Value       = 1
597:             .Visible     = .T.
598:         ENDWITH
599:         WITH loc_oPagina.opt_4c_Abas
600:             .Buttons(1).Caption   = "Principal"
601:             .Buttons(1).Left      = 0
602:             .Buttons(1).Top       = 25
603:             .Buttons(1).Width     = 85
604:             .Buttons(1).Height    = 30
605:             .Buttons(1).Themes    = .F.
606:             .Buttons(1).FontName  = "Tahoma"
607:             .Buttons(1).FontSize  = 8
608:             .Buttons(1).ForeColor = RGB(50, 50, 50)
609:             .Buttons(2).Caption   = "Composi" + CHR(231) + CHR(227) + "o"
610:             .Buttons(2).Left      = 90
611:             .Buttons(2).Top       = 25
612:             .Buttons(2).Width     = 90
613:             .Buttons(2).Height    = 30
614:             .Buttons(2).Themes    = .F.
615:             .Buttons(2).FontName  = "Tahoma"
616:             .Buttons(2).FontSize  = 8
617:             .Buttons(2).ForeColor = RGB(50, 50, 50)
618:             .Buttons(3).Caption   = "Custos"
619:             .Buttons(3).Left      = 185
620:             .Buttons(3).Top       = 25
621:             .Buttons(3).Width     = 75
622:             .Buttons(3).Height    = 30
623:             .Buttons(3).Themes    = .F.
624:             .Buttons(3).FontName  = "Tahoma"
625:             .Buttons(3).FontSize  = 8
626:             .Buttons(3).ForeColor = RGB(50, 50, 50)
627:             .Buttons(4).Caption   = "Dados Fiscais"

*-- Linhas 661 a 753:
661:             .Buttons(7).FontSize  = 8
662:             .Buttons(7).ForeColor = RGB(50, 50, 50)
663:         ENDWITH
664:         BINDEVENT(loc_oPagina.opt_4c_Abas, "InteractiveChange", THIS, "OpcaoAbasChange")
665: 
666:         *-- PageFrame interno (pgframeDados legado: top=-54, left=-1, width=1003, height=656)
667:         *-- Tabs=.F. para ocultar abas (navegacao pelo OptionGroup)
668:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
669:         WITH loc_oPagina.pgf_4c_Dados
670:             .Top       = -54
671:             .Left      = -1
672:             .Width     = 1003
673:             .Height    = 685
674:             .PageCount = 7
675:             .Tabs      = .F.
676:             .Visible   = .T.
677: 
678:             .Page1.Caption  = "Principal"
679:             .Page1.BackColor = RGB(255, 255, 255)
680:             .Page2.Caption  = "Composicao"
681:             .Page2.BackColor = RGB(255, 255, 255)
682:             .Page3.Caption  = "Custos"
683:             .Page3.BackColor = RGB(255, 255, 255)
684:             .Page4.Caption  = "Dados Fiscais"
685:             .Page4.BackColor = RGB(255, 255, 255)
686:             .Page5.Caption  = "Designer"
687:             .Page5.BackColor = RGB(255, 255, 255)
688:             .Page6.Caption  = "Consulta"
689:             .Page6.BackColor = RGB(255, 255, 255)
690:             .Page7.Caption  = "Fases"
691:             .Page7.BackColor = RGB(255, 255, 255)
692:         ENDWITH
693: 
694:         *-- Configurar conteudo de cada aba
695:         THIS.ConfigurarTabPrincipal()
696:         THIS.ConfigurarTabComposicao()
697:         THIS.ConfigurarTabCustos()
698:         THIS.ConfigurarTabDadosFiscais()
699:         THIS.ConfigurarPgpgDadosFiscais()
700:         THIS.ConfigurarTabDesigner()
701:         THIS.ConfigurarPgpgDesigner()
702:         THIS.ConfigurarTabConsulta()
703:         THIS.ConfigurarTabFases()
704: 
705:         THIS.TornarControlesVisiveis(loc_oPagina)
706:     ENDPROC
707: 
708:     *--------------------------------------------------------------------------
709:     * ConfigurarTabPrincipal - Aba 1: Dados principais do produto (pgDados)
710:     * Legado: pgframeDados.pgDados (167 controles)
711:     * Posicoes direto do layout.json (sem compensacao - dentro de pgf_4c_Dados)
712:     *--------------------------------------------------------------------------
713:     PROTECTED PROCEDURE ConfigurarTabPrincipal()
714:         LOCAL loc_oPg
715:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
716: 
717:         *-- === CODIGO e DESCRICAO =============================================
718: 
719:         loc_oPg.AddObject("lbl_4c_LblCpros", "Label")
720:         WITH loc_oPg.lbl_4c_LblCpros
721:             .Caption = "Produto :"
722:             .Top = 134
723:             .Left = 58
724:             .Width = 53
725:             .Height = 15
726:             .FontName = "Tahoma"
727:             .FontSize = 8
728:             .BackStyle = 0
729:             .ForeColor = RGB(90,90,90)
730:         ENDWITH
731: 
732:         loc_oPg.AddObject("txt_4c_Cpros", "TextBox")
733:         WITH loc_oPg.txt_4c_Cpros
734:             .Value = ""
735:             .Top = 130
736:             .Left = 113
737:             .Width = 108
738:             .Height = 23
739:             .FontName = "Tahoma"
740:             .FontSize = 8
741:             .SpecialEffect = 1
742:             .MaxLength = 14
743:         ENDWITH
744: 
745:         loc_oPg.AddObject("lbl_4c_LblDpros", "Label")
746:         WITH loc_oPg.lbl_4c_LblDpros
747:             .Caption = "Descri" + CHR(231) + CHR(227) + "o :"
748:             .Top = 134
749:             .Left = 222
750:             .Width = 70
751:             .Height = 15
752:             .FontName = "Tahoma"
753:             .FontSize = 8

*-- Linhas 821 a 865:
821:             .SpecialEffect = 1
822:             .MaxLength = 3
823:         ENDWITH
824:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "TabPrincipal_CgruKeyPress")
825:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "LostFocus", THIS, "TabPrincipal_CgruLostFocus")
826: 
827:         loc_oPg.AddObject("txt_4c_Dgrus", "TextBox")
828:         WITH loc_oPg.txt_4c_Dgrus
829:             .Value = ""
830:             .Top = 178
831:             .Left = 145
832:             .Width = 171
833:             .Height = 23
834:             .FontName = "Tahoma"
835:             .FontSize = 8
836:             .SpecialEffect = 1
837:             .ReadOnly = .T.
838:             .Enabled = .F.
839:         ENDWITH
840: 
841:         loc_oPg.AddObject("lbl_4c_LblSgrus", "Label")
842:         WITH loc_oPg.lbl_4c_LblSgrus
843:             .Caption = "Subgrupo :"
844:             .Top = 206
845:             .Left = 56
846:             .Width = 55
847:             .Height = 15
848:             .FontName = "Tahoma"
849:             .FontSize = 8
850:             .BackStyle = 0
851:             .ForeColor = RGB(90,90,90)
852:         ENDWITH
853: 
854:         loc_oPg.AddObject("txt_4c_Csgrus", "TextBox")
855:         WITH loc_oPg.txt_4c_Csgrus
856:             .Value = ""
857:             .Top = 202
858:             .Left = 113
859:             .Width = 52
860:             .Height = 23
861:             .FontName = "Tahoma"
862:             .FontSize = 8
863:             .SpecialEffect = 1
864:             .MaxLength = 6
865:         ENDWITH

*-- Linhas 905 a 1035:
905:             .SpecialEffect = 1
906:             .MaxLength = 10
907:         ENDWITH
908:         BINDEVENT(loc_oPg.txt_4c_Linhas, "KeyPress", THIS, "TabPrincipal_LinhasKeyPress")
909:         BINDEVENT(loc_oPg.txt_4c_Linhas, "LostFocus", THIS, "TabPrincipal_LinhasLostFocus")
910: 
911:         loc_oPg.AddObject("txt_4c_Dlinhas", "TextBox")
912:         WITH loc_oPg.txt_4c_Dlinhas
913:             .Value = ""
914:             .Top = 226
915:             .Left = 194
916:             .Width = 318
917:             .Height = 23
918:             .FontName = "Tahoma"
919:             .FontSize = 8
920:             .SpecialEffect = 1
921:             .ReadOnly = .T.
922:             .Enabled = .F.
923:         ENDWITH
924: 
925:         loc_oPg.AddObject("lbl_4c_LblColecoes", "Label")
926:         WITH loc_oPg.lbl_4c_LblColecoes
927:             .Caption = "Grupo de Venda :"
928:             .Top = 253
929:             .Left = 25
930:             .Width = 86
931:             .Height = 15
932:             .FontName = "Tahoma"
933:             .FontSize = 8
934:             .BackStyle = 0
935:             .ForeColor = RGB(90,90,90)
936:         ENDWITH
937: 
938:         loc_oPg.AddObject("txt_4c_Colecoes", "TextBox")
939:         WITH loc_oPg.txt_4c_Colecoes
940:             .Value = ""
941:             .Top = 250
942:             .Left = 113
943:             .Width = 80
944:             .Height = 23
945:             .FontName = "Tahoma"
946:             .FontSize = 8
947:             .SpecialEffect = 1
948:             .MaxLength = 10
949:         ENDWITH
950:         BINDEVENT(loc_oPg.txt_4c_Colecoes, "KeyPress", THIS, "TabPrincipal_ColecoesKeyPress")
951:         BINDEVENT(loc_oPg.txt_4c_Colecoes, "LostFocus", THIS, "TabPrincipal_ColecoesLostFocus")
952: 
953:         loc_oPg.AddObject("txt_4c_Dcolecoes", "TextBox")
954:         WITH loc_oPg.txt_4c_Dcolecoes
955:             .Value = ""
956:             .Top = 250
957:             .Left = 194
958:             .Width = 318
959:             .Height = 23
960:             .FontName = "Tahoma"
961:             .FontSize = 8
962:             .SpecialEffect = 1
963:             .ReadOnly = .T.
964:             .Enabled = .F.
965:         ENDWITH
966: 
967:         *-- === FORNECEDOR / REF ==============================================
968: 
969:         loc_oPg.AddObject("lbl_4c_LblIfors", "Label")
970:         WITH loc_oPg.lbl_4c_LblIfors
971:             .Caption = "Fornecedor :"
972:             .Top = 278
973:             .Left = 47
974:             .Width = 64
975:             .Height = 15
976:             .FontName = "Tahoma"
977:             .FontSize = 8
978:             .BackStyle = 0
979:             .ForeColor = RGB(90,90,90)
980:         ENDWITH
981: 
982:         loc_oPg.AddObject("txt_4c_Ifors", "TextBox")
983:         WITH loc_oPg.txt_4c_Ifors
984:             .Value = ""
985:             .Top = 274
986:             .Left = 113
987:             .Width = 80
988:             .Height = 23
989:             .FontName = "Tahoma"
990:             .FontSize = 8
991:             .SpecialEffect = 1
992:             .MaxLength = 10
993:         ENDWITH
994:         BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyPress", THIS, "TabPrincipal_IforsKeyPress")
995:         BINDEVENT(loc_oPg.txt_4c_Ifors, "LostFocus", THIS, "TabPrincipal_IforsLostFocus")
996: 
997:         loc_oPg.AddObject("txt_4c_Dfors", "TextBox")
998:         WITH loc_oPg.txt_4c_Dfors
999:             .Value = ""
1000:             .Top = 274
1001:             .Left = 194
1002:             .Width = 318
1003:             .Height = 23
1004:             .FontName = "Tahoma"
1005:             .FontSize = 8
1006:             .SpecialEffect = 1
1007:             .ReadOnly = .T.
1008:             .Enabled = .F.
1009:         ENDWITH
1010: 
1011:         loc_oPg.AddObject("lbl_4c_LblReffs", "Label")
1012:         WITH loc_oPg.lbl_4c_LblReffs
1013:             .Caption = "Ref. Fornecedor :"
1014:             .Top = 301
1015:             .Left = 23
1016:             .Width = 88
1017:             .Height = 15
1018:             .FontName = "Tahoma"
1019:             .FontSize = 8
1020:             .BackStyle = 0
1021:             .ForeColor = RGB(90,90,90)
1022:         ENDWITH
1023: 
1024:         loc_oPg.AddObject("txt_4c_Reffs", "TextBox")
1025:         WITH loc_oPg.txt_4c_Reffs
1026:             .Value = ""
1027:             .Top = 298
1028:             .Left = 113
1029:             .Width = 152
1030:             .Height = 23
1031:             .FontName = "Tahoma"
1032:             .FontSize = 8
1033:             .SpecialEffect = 1
1034:             .MaxLength = 40
1035:         ENDWITH

*-- Linhas 1141 a 1184:
1141:             .SpecialEffect = 1
1142:             .MaxLength = 14
1143:         ENDWITH
1144:         BINDEVENT(loc_oPg.txt_4c_Cproeqs, "KeyPress", THIS, "TabPrincipal_CproeqsKeyPress")
1145: 
1146:         loc_oPg.AddObject("lbl_4c_LblCbars", "Label")
1147:         WITH loc_oPg.lbl_4c_LblCbars
1148:             .Caption = "Barra :"
1149:             .Top = 157
1150:             .Left = 590
1151:             .Width = 35
1152:             .Height = 15
1153:             .FontName = "Tahoma"
1154:             .FontSize = 8
1155:             .BackStyle = 0
1156:             .ForeColor = RGB(90,90,90)
1157:         ENDWITH
1158: 
1159:         loc_oPg.AddObject("txt_4c_Cbars", "TextBox")
1160:         WITH loc_oPg.txt_4c_Cbars
1161:             .Value = 0
1162:             .Top = 155
1163:             .Left = 626
1164:             .Width = 108
1165:             .Height = 21
1166:             .FontName = "Tahoma"
1167:             .FontSize = 8
1168:             .SpecialEffect = 1
1169:         ENDWITH
1170: 
1171:         loc_oPg.AddObject("lbl_4c_LblEan13", "Label")
1172:         WITH loc_oPg.lbl_4c_LblEan13
1173:             .Caption = "EAN/GTIN :"
1174:             .Top = 181
1175:             .Left = 568
1176:             .Width = 57
1177:             .Height = 15
1178:             .FontName = "Tahoma"
1179:             .FontSize = 8
1180:             .BackStyle = 0
1181:             .ForeColor = RGB(90,90,90)
1182:         ENDWITH
1183: 
1184:         loc_oPg.AddObject("txt_4c_Ean13", "TextBox")

*-- Linhas 1195 a 1265:
1195: 
1196:         *-- === SITUACAO / DATA SITUACAO ======================================
1197: 
1198:         loc_oPg.AddObject("opt_4c_Situas", "OptionGroup")
1199:         WITH loc_oPg.opt_4c_Situas
1200:             .Top = 130
1201:             .Left = 735
1202:             .Width = 142
1203:             .Height = 25
1204:             .ButtonCount = 2
1205:             .BorderStyle = 0
1206:             .Themes = .F.
1207:             .Value = 1
1208:         ENDWITH
1209:         WITH loc_oPg.opt_4c_Situas
1210:             .Buttons(1).Caption = "Ativo"
1211:             .Buttons(1).Left = 0
1212:             .Buttons(1).Top = 0
1213:             .Buttons(1).AutoSize = .T.
1214:             .Buttons(1).Themes = .F.
1215:             .Buttons(1).FontName = "Tahoma"
1216:             .Buttons(1).FontSize = 8
1217:             .Buttons(2).Caption = "Inativo"
1218:             .Buttons(2).Left = 60
1219:             .Buttons(2).Top = 0
1220:             .Buttons(2).AutoSize = .T.
1221:             .Buttons(2).Themes = .F.
1222:             .Buttons(2).FontName = "Tahoma"
1223:             .Buttons(2).FontSize = 8
1224:         ENDWITH
1225:         BINDEVENT(loc_oPg.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")
1226: 
1227:         loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
1228:         WITH loc_oPg.txt_4c_DtSituas
1229:             .Value = {}
1230:             .Top = 132
1231:             .Left = 878
1232:             .Width = 80
1233:             .Height = 21
1234:             .FontName = "Tahoma"
1235:             .FontSize = 8
1236:             .SpecialEffect = 1
1237:             .ReadOnly = .T.
1238:             .Enabled = .F.
1239:         ENDWITH
1240: 
1241:         *-- === LOTE MINIMO ===================================================
1242: 
1243:         loc_oPg.AddObject("lbl_4c_LblLtmins", "Label")
1244:         WITH loc_oPg.lbl_4c_LblLtmins
1245:             .Caption = "Lote M" + CHR(237) + "nimo :"
1246:             .Top = 157
1247:             .Left = 812
1248:             .Width = 65
1249:             .Height = 15
1250:             .FontName = "Tahoma"
1251:             .FontSize = 8
1252:             .BackStyle = 0
1253:             .ForeColor = RGB(90,90,90)
1254:         ENDWITH
1255: 
1256:         loc_oPg.AddObject("txt_4c_Ltminsv", "TextBox")
1257:         WITH loc_oPg.txt_4c_Ltminsv
1258:             .Value = 0
1259:             .Top = 154
1260:             .Left = 878
1261:             .Width = 80
1262:             .Height = 21
1263:             .FontName = "Tahoma"
1264:             .FontSize = 8
1265:             .SpecialEffect = 1

*-- Linhas 1557 a 1641:
1557:             .SpecialEffect = 1
1558:             .MaxLength = 3
1559:         ENDWITH
1560:         BINDEVENT(loc_oPg.txt_4c_Moecs, "KeyPress", THIS, "TabPrincipal_MoeKeyPress")
1561:         BINDEVENT(loc_oPg.txt_4c_Moecs, "LostFocus", THIS, "TabPrincipal_MoeLostFocus")
1562: 
1563:         loc_oPg.AddObject("lbl_4c_LblPvens", "Label")
1564:         WITH loc_oPg.lbl_4c_LblPvens
1565:             .Caption = "Valor de Venda :"
1566:             .Top = 400
1567:             .Left = 505
1568:             .Width = 120
1569:             .Height = 15
1570:             .FontName = "Tahoma"
1571:             .FontSize = 8
1572:             .BackStyle = 0
1573:             .ForeColor = RGB(90,90,90)
1574:         ENDWITH
1575: 
1576:         loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
1577:         WITH loc_oPg.txt_4c_Pvens
1578:             .Value = 0
1579:             .Top = 397
1580:             .Left = 626
1581:             .Width = 127
1582:             .Height = 21
1583:             .FontName = "Tahoma"
1584:             .FontSize = 8
1585:             .SpecialEffect = 1
1586:         ENDWITH
1587: 
1588:         loc_oPg.AddObject("txt_4c_Moepvs", "TextBox")
1589:         WITH loc_oPg.txt_4c_Moepvs
1590:             .Value = ""
1591:             .Top = 397
1592:             .Left = 754
1593:             .Width = 31
1594:             .Height = 21
1595:             .FontName = "Tahoma"
1596:             .FontSize = 8
1597:             .SpecialEffect = 1
1598:             .MaxLength = 3
1599:         ENDWITH
1600:         BINDEVENT(loc_oPg.txt_4c_Moepvs, "KeyPress", THIS, "TabPrincipal_MoeKeyPress")
1601:         BINDEVENT(loc_oPg.txt_4c_Moepvs, "LostFocus", THIS, "TabPrincipal_MoeLostFocus")
1602: 
1603:         loc_oPg.AddObject("lbl_4c_LblFvendas", "Label")
1604:         WITH loc_oPg.lbl_4c_LblFvendas
1605:             .Caption = "Fator  de Venda :"
1606:             .Top = 422
1607:             .Left = 539
1608:             .Width = 86
1609:             .Height = 15
1610:             .FontName = "Tahoma"
1611:             .FontSize = 8
1612:             .BackStyle = 0
1613:             .ForeColor = RGB(90,90,90)
1614:         ENDWITH
1615: 
1616:         loc_oPg.AddObject("txt_4c_Fvendas", "TextBox")
1617:         WITH loc_oPg.txt_4c_Fvendas
1618:             .Value = 0
1619:             .Top = 419
1620:             .Left = 626
1621:             .Width = 127
1622:             .Height = 21
1623:             .FontName = "Tahoma"
1624:             .FontSize = 8
1625:             .SpecialEffect = 1
1626:         ENDWITH
1627: 
1628:         loc_oPg.AddObject("txt_4c_Moevs", "TextBox")
1629:         WITH loc_oPg.txt_4c_Moevs
1630:             .Value = ""
1631:             .Top = 419
1632:             .Left = 754
1633:             .Width = 31
1634:             .Height = 21
1635:             .FontName = "Tahoma"
1636:             .FontSize = 8
1637:             .SpecialEffect = 1
1638:             .MaxLength = 3
1639:         ENDWITH
1640: 
1641:         *-- === AUDITORIA (ReadOnly) ==========================================

*-- Linhas 1762 a 1848:
1762:             .SpecialEffect = 1
1763:             .MaxLength = 3
1764:         ENDWITH
1765:         BINDEVENT(loc_oPg.txt_4c_Cunis, "KeyPress", THIS, "TabPrincipal_CunisKeyPress")
1766:         BINDEVENT(loc_oPg.txt_4c_Cunis, "LostFocus", THIS, "TabPrincipal_CunisLostFocus")
1767: 
1768:         loc_oPg.AddObject("txt_4c_Dunis", "TextBox")
1769:         WITH loc_oPg.txt_4c_Dunis
1770:             .Value = ""
1771:             .Top = 394
1772:             .Left = 145
1773:             .Width = 150
1774:             .Height = 23
1775:             .FontName = "Tahoma"
1776:             .FontSize = 8
1777:             .SpecialEffect = 1
1778:             .ReadOnly = .T.
1779:             .Enabled = .F.
1780:         ENDWITH
1781: 
1782:         loc_oPg.AddObject("lbl_4c_LblCunips", "Label")
1783:         WITH loc_oPg.lbl_4c_LblCunips
1784:             .Caption = "(2) :"
1785:             .Top = 398
1786:             .Left = 301
1787:             .Width = 23
1788:             .Height = 15
1789:             .FontName = "Tahoma"
1790:             .FontSize = 8
1791:             .BackStyle = 0
1792:             .ForeColor = RGB(90,90,90)
1793:         ENDWITH
1794: 
1795:         loc_oPg.AddObject("txt_4c_Cunips", "TextBox")
1796:         WITH loc_oPg.txt_4c_Cunips
1797:             .Value = ""
1798:             .Top = 394
1799:             .Left = 330
1800:             .Width = 31
1801:             .Height = 23
1802:             .FontName = "Tahoma"
1803:             .FontSize = 8
1804:             .SpecialEffect = 1
1805:             .MaxLength = 3
1806:         ENDWITH
1807:         BINDEVENT(loc_oPg.txt_4c_Cunips, "KeyPress", THIS, "TabPrincipal_CunipsKeyPress")
1808:         BINDEVENT(loc_oPg.txt_4c_Cunips, "LostFocus", THIS, "TabPrincipal_CunipsLostFocus")
1809: 
1810:         loc_oPg.AddObject("txt_4c_Dunips", "TextBox")
1811:         WITH loc_oPg.txt_4c_Dunips
1812:             .Value = ""
1813:             .Top = 394
1814:             .Left = 362
1815:             .Width = 150
1816:             .Height = 23
1817:             .FontName = "Tahoma"
1818:             .FontSize = 8
1819:             .SpecialEffect = 1
1820:             .ReadOnly = .T.
1821:             .Enabled = .F.
1822:         ENDWITH
1823: 
1824:         *-- === CLASSIFICACAO / MODELO / ACABAMENTO / LOCAL ===================
1825: 
1826:         loc_oPg.AddObject("lbl_4c_LblCclass", "Label")
1827:         WITH loc_oPg.lbl_4c_LblCclass
1828:             .Caption = "Classifica" + CHR(231) + CHR(227) + "o :"
1829:             .Top = 374
1830:             .Left = 7
1831:             .Width = 104
1832:             .Height = 15
1833:             .FontName = "Tahoma"
1834:             .FontSize = 8
1835:             .BackStyle = 0
1836:             .ForeColor = RGB(90,90,90)
1837:         ENDWITH
1838: 
1839:         loc_oPg.AddObject("txt_4c_Cclass", "TextBox")
1840:         WITH loc_oPg.txt_4c_Cclass
1841:             .Value = ""
1842:             .Top = 370
1843:             .Left = 113
1844:             .Width = 31
1845:             .Height = 23
1846:             .FontName = "Tahoma"
1847:             .FontSize = 8
1848:             .SpecialEffect = 1

*-- Linhas 1928 a 1972:
1928:             .SpecialEffect = 1
1929:             .MaxLength = 3
1930:         ENDWITH
1931:         BINDEVENT(loc_oPg.txt_4c_Codacbs, "KeyPress", THIS, "TabPrincipal_CodacbsKeyPress")
1932:         BINDEVENT(loc_oPg.txt_4c_Codacbs, "LostFocus", THIS, "TabPrincipal_CodacbsLostFocus")
1933: 
1934:         loc_oPg.AddObject("txt_4c_Dcodacbs", "TextBox")
1935:         WITH loc_oPg.txt_4c_Dcodacbs
1936:             .Value = ""
1937:             .Top = 346
1938:             .Left = 145
1939:             .Width = 150
1940:             .Height = 23
1941:             .FontName = "Tahoma"
1942:             .FontSize = 8
1943:             .SpecialEffect = 1
1944:             .ReadOnly = .T.
1945:             .Enabled = .F.
1946:         ENDWITH
1947: 
1948:         loc_oPg.AddObject("lbl_4c_LblLocals", "Label")
1949:         WITH loc_oPg.lbl_4c_LblLocals
1950:             .Caption = "Local :"
1951:             .Top = 374
1952:             .Left = 364
1953:             .Width = 33
1954:             .Height = 15
1955:             .FontName = "Tahoma"
1956:             .FontSize = 8
1957:             .BackStyle = 0
1958:             .ForeColor = RGB(90,90,90)
1959:         ENDWITH
1960: 
1961:         loc_oPg.AddObject("txt_4c_Locals", "TextBox")
1962:         WITH loc_oPg.txt_4c_Locals
1963:             .Value = ""
1964:             .Top = 370
1965:             .Left = 401
1966:             .Width = 111
1967:             .Height = 23
1968:             .FontName = "Tahoma"
1969:             .FontSize = 8
1970:             .SpecialEffect = 1
1971:             .MaxLength = 10
1972:         ENDWITH

*-- Linhas 2048 a 2119:
2048:             .SpecialEffect = 1
2049:             .MaxLength = 4
2050:         ENDWITH
2051:         BINDEVENT(loc_oPg.txt_4c_Codcors, "KeyPress", THIS, "TabPrincipal_CodcorsKeyPress")
2052:         BINDEVENT(loc_oPg.txt_4c_Codcors, "LostFocus", THIS, "TabPrincipal_CodcorsLostFocus")
2053: 
2054:         loc_oPg.AddObject("lbl_4c_LblCodtams", "Label")
2055:         WITH loc_oPg.lbl_4c_LblCodtams
2056:             .Caption = "Tam:"
2057:             .Top = 302
2058:             .Left = 442
2059:             .Width = 30
2060:             .Height = 15
2061:             .FontName = "Tahoma"
2062:             .FontSize = 8
2063:             .BackStyle = 0
2064:             .ForeColor = RGB(90,90,90)
2065:         ENDWITH
2066: 
2067:         loc_oPg.AddObject("txt_4c_Codtams", "TextBox")
2068:         WITH loc_oPg.txt_4c_Codtams
2069:             .Value = ""
2070:             .Top = 298
2071:             .Left = 474
2072:             .Width = 38
2073:             .Height = 23
2074:             .FontName = "Tahoma"
2075:             .FontSize = 8
2076:             .SpecialEffect = 1
2077:             .MaxLength = 4
2078:         ENDWITH
2079:         BINDEVENT(loc_oPg.txt_4c_Codtams, "KeyPress", THIS, "TabPrincipal_CodtamsKeyPress")
2080: 
2081:         loc_oPg.AddObject("lbl_4c_LblCodident", "Label")
2082:         WITH loc_oPg.lbl_4c_LblCodident
2083:             .Caption = "Cod. Identidade :"
2084:             .Top = 422
2085:             .Left = 24
2086:             .Width = 87
2087:             .Height = 15
2088:             .FontName = "Tahoma"
2089:             .FontSize = 8
2090:             .BackStyle = 0
2091:             .ForeColor = RGB(90,90,90)
2092:         ENDWITH
2093: 
2094:         loc_oPg.AddObject("txt_4c_Codident", "TextBox")
2095:         WITH loc_oPg.txt_4c_Codident
2096:             .Value = ""
2097:             .Top = 418
2098:             .Left = 113
2099:             .Width = 182
2100:             .Height = 23
2101:             .FontName = "Tahoma"
2102:             .FontSize = 8
2103:             .SpecialEffect = 1
2104:             .MaxLength = 20
2105:         ENDWITH
2106: 
2107:         *-- === GARANTIA / PRODUTO WEB / VARIACAO =============================
2108: 
2109:         loc_oPg.AddObject("lbl_4c_LblDiasgar", "Label")
2110:         WITH loc_oPg.lbl_4c_LblDiasgar
2111:             .Caption = "Garantia :"
2112:             .Top = 228
2113:             .Left = 827
2114:             .Width = 50
2115:             .Height = 15
2116:             .FontName = "Tahoma"
2117:             .FontSize = 8
2118:             .BackStyle = 0
2119:             .ForeColor = RGB(90,90,90)

*-- Linhas 2170 a 2296:
2170:             .ForeColor = RGB(90,90,90)
2171:         ENDWITH
2172: 
2173:         loc_oPg.AddObject("opt_4c_ProdWeb", "OptionGroup")
2174:         WITH loc_oPg.opt_4c_ProdWeb
2175:             .Top = 172
2176:             .Left = 879
2177:             .Width = 117
2178:             .Height = 42
2179:             .ButtonCount = 4
2180:             .BorderStyle = 0
2181:             .Themes = .F.
2182:             .Value = 1
2183:         ENDWITH
2184:         WITH loc_oPg.opt_4c_ProdWeb
2185:             .Buttons(1).Caption = "N" + CHR(227) + "o"
2186:             .Buttons(1).Left = 0 
2187:             .Buttons(1).Top = 0
2188:             .Buttons(1).AutoSize = .T.
2189:             .Buttons(1).Themes = .F.
2190:             .Buttons(1).FontName = "Tahoma"
2191:             .Buttons(1).FontSize = 8
2192:             .Buttons(2).Caption = "Sim"  
2193:             .Buttons(2).Left = 35
2194:             .Buttons(2).Top = 0
2195:             .Buttons(2).AutoSize = .T.
2196:             .Buttons(2).Themes = .F.
2197:             .Buttons(2).FontName = "Tahoma"
2198:             .Buttons(2).FontSize = 8
2199:             .Buttons(3).Caption = "Img"  
2200:             .Buttons(3).Left = 65
2201:             .Buttons(3).Top = 0
2202:             .Buttons(3).AutoSize = .T.
2203:             .Buttons(3).Themes = .F.
2204:             .Buttons(3).FontName = "Tahoma"
2205:             .Buttons(3).FontSize = 8
2206:             .Buttons(4).Caption = "Sim+Img"
2207:             .Buttons(4).Left = 0
2208:             .Buttons(4).Top = 22
2209:             .Buttons(4).AutoSize = .T.
2210:             .Buttons(4).Themes = .F.
2211:             .Buttons(4).FontName = "Tahoma"
2212:             .Buttons(4).FontSize = 8
2213:         ENDWITH
2214:         BINDEVENT(loc_oPg.opt_4c_ProdWeb, "InteractiveChange", THIS, "OptProdWebChange")
2215: 
2216:         loc_oPg.AddObject("lbl_4c_LblVariacao", "Label")
2217:         WITH loc_oPg.lbl_4c_LblVariacao
2218:             .Caption = "Varia" + CHR(231) + CHR(227) + "o :"
2219:             .Top = 207
2220:             .Left = 827
2221:             .Width = 50
2222:             .Height = 15
2223:             .FontName = "Tahoma"
2224:             .FontSize = 8
2225:             .BackStyle = 0
2226:             .ForeColor = RGB(90,90,90)
2227:         ENDWITH
2228: 
2229:         loc_oPg.AddObject("opt_4c_Varias", "OptionGroup")
2230:         WITH loc_oPg.opt_4c_Varias
2231:             .Top = 203
2232:             .Left = 874
2233:             .Width = 107
2234:             .Height = 22
2235:             .ButtonCount = 2
2236:             .BorderStyle = 0
2237:             .Themes = .F.
2238:             .Value = 2
2239:         ENDWITH
2240:         WITH loc_oPg.opt_4c_Varias
2241:             .Buttons(1).Caption = "Sim"        
2242:             .Buttons(1).Left = 0 
2243:             .Buttons(1).Top = 0
2244:             .Buttons(1).AutoSize = .T.
2245:             .Buttons(1).Themes = .F.
2246:             .Buttons(1).FontName = "Tahoma"
2247:             .Buttons(1).FontSize = 8
2248:             .Buttons(2).Caption = "N" + CHR(227) + "o"
2249:             .Buttons(2).Left = 42
2250:             .Buttons(2).Top = 0
2251:             .Buttons(2).AutoSize = .T.
2252:             .Buttons(2).Themes = .F.
2253:             .Buttons(2).FontName = "Tahoma"
2254:             .Buttons(2).FontSize = 8
2255:         ENDWITH
2256:         BINDEVENT(loc_oPg.opt_4c_Varias, "InteractiveChange", THIS, "OptVariasChange")
2257: 
2258:         *-- === DIMENSOES FINAS (altura/largura/diametro/espessura/comprimento) =
2259: 
2260:         loc_oPg.AddObject("lbl_4c_LblAltura", "Label")
2261:         WITH loc_oPg.lbl_4c_LblAltura
2262:             .Caption = "Altura :"
2263:             .Top = 250
2264:             .Left = 881
2265:             .Width = 38
2266:             .Height = 15
2267:             .FontName = "Tahoma"
2268:             .FontSize = 8
2269:             .BackStyle = 0
2270:             .ForeColor = RGB(90,90,90)
2271:         ENDWITH
2272:         loc_oPg.AddObject("txt_4c_Altura", "TextBox")
2273:         WITH loc_oPg.txt_4c_Altura
2274:             .Value = 0
2275:             .Top = 247
2276:             .Left = 923
2277:             .Width = 48
2278:             .Height = 21
2279:             .FontName = "Tahoma"
2280:             .FontSize = 8
2281:             .SpecialEffect = 1
2282:         ENDWITH
2283:         loc_oPg.AddObject("lbl_4c_MmAltura", "Label")
2284:         WITH loc_oPg.lbl_4c_MmAltura
2285:             .Caption = "MM"
2286:             .Top = 251
2287:             .Left = 976
2288:             .Width = 18
2289:             .Height = 15
2290:             .FontName = "Tahoma"
2291:             .FontSize = 8
2292:             .BackStyle = 0
2293:             .ForeColor = RGB(90,90,90)
2294:         ENDWITH
2295: 
2296:         loc_oPg.AddObject("lbl_4c_LblLargura", "Label")

*-- Linhas 2753 a 2796:
2753:     * ConfigurarTabComposicao - Aba 2: Composicao de materiais (pgComposicao)
2754:     * IMPLEMENTADO NA FASE 5
2755:     *--------------------------------------------------------------------------
2756:     PROTECTED PROCEDURE ConfigurarTabComposicao()
2757:         LOCAL loc_oPg
2758:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2759: 
2760:         *-- GradeGRUPO (top=34, left=582, width=229, height=107, 3 cols)
2761:         *-- Mostra totais por grupo de composicao
2762:         loc_oPg.AddObject("grd_4c_GrupoCompo", "Grid")
2763:         WITH loc_oPg.grd_4c_GrupoCompo
2764:             .Top         = 34
2765:             .Left        = 582
2766:             .Width       = 229
2767:             .Height      = 107
2768:             .ReadOnly    = .T.
2769:             .DeleteMark  = .F.
2770:             .RecordMark  = .F.
2771:             .ScrollBars  = 3
2772:             .GridLines   = 3
2773:             .ColumnCount = 3
2774:             .FontName    = "Verdana"
2775:             .FontSize    = 8
2776:             .Visible     = .T.
2777:         ENDWITH
2778:         WITH loc_oPg.grd_4c_GrupoCompo
2779:             .Column1.Header1.Caption = "Grupo"
2780:             .Column1.Width = 70
2781:             .Column2.Header1.Caption = "Total"
2782:             .Column2.Width = 95
2783:             .Column3.Header1.Caption = "Moe"
2784:             .Column3.Width = 50
2785:         ENDWITH
2786: 
2787:         *-- grdCompo - Composicao principal (top=148, left=6, width=943, height=147, 14 cols)
2788:         *-- Dados: SIGPRCPO - Material, Descricao, Unidade, Valor, Qtde, Total, Moeda, Obs, Etiq, Consumo, QtdCV, UnCV, Ordem, Compos
2789:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
2790:         WITH loc_oPg.grd_4c_Compo
2791:             .Top         = 148
2792:             .Left        = 6
2793:             .Width       = 943
2794:             .Height      = 147
2795:             .ReadOnly    = .T.
2796:             .DeleteMark  = .F.

*-- Linhas 3161 a 3327:
3161:             .ToolTipText     = "Incluir"
3162:             .Visible         = .T.
3163:         ENDWITH
3164:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoIncluir, "Click", THIS, "CmdCompoIncluirClick")
3165: 
3166:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoExcluir", "CommandButton")
3167:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoExcluir
3168:             .Caption         = "-"
3169:             .Top             = 42
3170:             .Left            = 0
3171:             .Width           = 50
3172:             .Height          = 42
3173:             .FontName        = "Tahoma"
3174:             .FontSize        = 14
3175:             .FontBold        = .T.
3176:             .Themes          = .F.
3177:             .SpecialEffect   = 0
3178:             .BackColor       = RGB(255,255,255)
3179:             .ForeColor       = RGB(180,0,0)
3180:             .ToolTipText     = "Excluir"
3181:             .Visible         = .T.
3182:         ENDWITH
3183:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoExcluir, "Click", THIS, "CmdCompoExcluirClick")
3184: 
3185:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoAtualizar", "CommandButton")
3186:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoAtualizar
3187:             .Caption         = CHR(8635)
3188:             .Top             = 84
3189:             .Left            = 0
3190:             .Width           = 50
3191:             .Height          = 42
3192:             .FontName        = "Tahoma"
3193:             .FontSize        = 10
3194:             .Themes          = .F.
3195:             .SpecialEffect   = 0
3196:             .BackColor       = RGB(255,255,255)
3197:             .ForeColor       = RGB(0,0,180)
3198:             .ToolTipText     = "Atualizar Pre" + CHR(231) + "os"
3199:             .Visible         = .T.
3200:         ENDWITH
3201:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoAtualizar, "Click", THIS, "CmdCompoAtualizarClick")
3202: 
3203:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoPeso", "CommandButton")
3204:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoPeso
3205:             .Caption         = "Kg"
3206:             .Top             = 126
3207:             .Left            = 0
3208:             .Width           = 50
3209:             .Height          = 42
3210:             .FontName        = "Tahoma"
3211:             .FontSize        = 8
3212:             .Themes          = .F.
3213:             .SpecialEffect   = 0
3214:             .BackColor       = RGB(255,255,255)
3215:             .ForeColor       = RGB(90,90,90)
3216:             .ToolTipText     = "Atualizar Pesos"
3217:             .Visible         = .T.
3218:         ENDWITH
3219:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoPeso, "Click", THIS, "CmdCompoAtuPesosClick")
3220: 
3221:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoRecalc", "CommandButton")
3222:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoRecalc
3223:             .Caption         = "="
3224:             .Top             = 168
3225:             .Left            = 0
3226:             .Width           = 50
3227:             .Height          = 42
3228:             .FontName        = "Tahoma"
3229:             .FontSize        = 14
3230:             .Themes          = .F.
3231:             .SpecialEffect   = 0
3232:             .BackColor       = RGB(255,255,255)
3233:             .ForeColor       = RGB(90,90,90)
3234:             .ToolTipText     = "Recalcular"
3235:             .Visible         = .T.
3236:         ENDWITH
3237:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoRecalc, "Click", THIS, "CmdCompoRecalcClick")
3238: 
3239:         *-- === COMANDOS PARA grdsubcp (Container com 2 botoes, top=345, left=947) ==========
3240:         loc_oPg.AddObject("obj_4c_CmdgSubCp", "Container")
3241:         WITH loc_oPg.obj_4c_CmdgSubCp
3242:             .Top         = 345
3243:             .Left        = 947
3244:             .Width       = 50
3245:             .Height      = 90
3246:             .BackStyle   = 0
3247:             .BorderWidth = 0
3248:             .Visible     = .T.
3249:         ENDWITH
3250: 
3251:         loc_oPg.obj_4c_CmdgSubCp.AddObject("cmd_4c_SubCpIncluir", "CommandButton")
3252:         WITH loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpIncluir
3253:             .Caption         = "+"
3254:             .Top             = 0
3255:             .Left            = 0
3256:             .Width           = 50
3257:             .Height          = 45
3258:             .FontName        = "Tahoma"
3259:             .FontSize        = 14
3260:             .FontBold        = .T.
3261:             .Themes          = .F.
3262:             .SpecialEffect   = 0
3263:             .BackColor       = RGB(255,255,255)
3264:             .ForeColor       = RGB(0,128,0)
3265:             .ToolTipText     = "Incluir Sub-Componente"
3266:             .Visible         = .T.
3267:         ENDWITH
3268:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpIncluir, "Click", THIS, "CmdSubCpIncluirClick")
3269: 
3270:         loc_oPg.obj_4c_CmdgSubCp.AddObject("cmd_4c_SubCpExcluir", "CommandButton")
3271:         WITH loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpExcluir
3272:             .Caption         = "-"
3273:             .Top             = 45
3274:             .Left            = 0
3275:             .Width           = 50
3276:             .Height          = 45
3277:             .FontName        = "Tahoma"
3278:             .FontSize        = 14
3279:             .FontBold        = .T.
3280:             .Themes          = .F.
3281:             .SpecialEffect   = 0
3282:             .BackColor       = RGB(255,255,255)
3283:             .ForeColor       = RGB(180,0,0)
3284:             .ToolTipText     = "Excluir Sub-Componente"
3285:             .Visible         = .T.
3286:         ENDWITH
3287:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpExcluir, "Click", THIS, "CmdSubCpExcluirClick")
3288: 
3289:         *-- === OBSERVACAO E DESCRICAO (entre grdCompo e grdsubcp, top=297-325) =============
3290:         loc_oPg.AddObject("lbl_4c_Label4", "Label")
3291:         WITH loc_oPg.lbl_4c_Label4
3292:             .Caption   = "Obs. da OF :"
3293:             .Top       = 300
3294:             .Left      = 36
3295:             .Width     = 64
3296:             .Height    = 15
3297:             .FontName  = "Tahoma"
3298:             .FontSize  = 8
3299:             .BackStyle = 0
3300:             .ForeColor = RGB(90,90,90)
3301:         ENDWITH
3302: 
3303:         loc_oPg.AddObject("txt_4c_ObsOFs", "TextBox")
3304:         WITH loc_oPg.txt_4c_ObsOFs
3305:             .Value    = ""
3306:             .Top      = 297
3307:             .Left     = 99
3308:             .Width    = 850
3309:             .Height   = 21
3310:             .FontName = "Tahoma"
3311:             .FontSize = 8
3312:             .MaxLength = 100
3313:         ENDWITH
3314: 
3315:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
3316:         WITH loc_oPg.lbl_4c_Label16
3317:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3318:             .Top       = 324
3319:             .Left      = 45
3320:             .Width     = 55
3321:             .Height    = 15
3322:             .FontName  = "Tahoma"
3323:             .FontSize  = 8
3324:             .BackStyle = 0
3325:             .ForeColor = RGB(90,90,90)
3326:         ENDWITH
3327: 

*-- Linhas 3335 a 3487:
3335:             .FontName = "Tahoma"
3336:             .FontSize = 8
3337:         ENDWITH
3338:         BINDEVENT(loc_oPg.txt_4c_Desc, "LostFocus", THIS, "TabCompo_DescLostFocus")
3339: 
3340:         loc_oPg.AddObject("lbl_4c_Label15", "Label")
3341:         WITH loc_oPg.lbl_4c_Label15
3342:             .Caption   = "Material Principal :"
3343:             .Top       = 324
3344:             .Left      = 421
3345:             .Width     = 89
3346:             .Height    = 15
3347:             .FontName  = "Tahoma"
3348:             .FontSize  = 8
3349:             .BackStyle = 0
3350:             .ForeColor = RGB(90,90,90)
3351:         ENDWITH
3352: 
3353:         loc_oPg.AddObject("txt_4c_MatP", "TextBox")
3354:         WITH loc_oPg.txt_4c_MatP
3355:             .Value    = ""
3356:             .Top      = 321
3357:             .Left     = 517
3358:             .Width    = 108
3359:             .Height   = 21
3360:             .FontName = "Tahoma"
3361:             .FontSize = 8
3362:         ENDWITH
3363:         BINDEVENT(loc_oPg.txt_4c_MatP, "LostFocus", THIS, "TabCompo_MatPLostFocus")
3364: 
3365:         *-- === CAMPOS SUB-COMPONENTE (abaixo de grdsubcp, top=432-435) =====================
3366:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
3367:         WITH loc_oPg.lbl_4c_Label3
3368:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3369:             .Top       = 435
3370:             .Left      = 39
3371:             .Width     = 55
3372:             .Height    = 15
3373:             .FontName  = "Tahoma"
3374:             .FontSize  = 8
3375:             .BackStyle = 0
3376:             .ForeColor = RGB(90,90,90)
3377:         ENDWITH
3378: 
3379:         loc_oPg.AddObject("txt_4c__desccp", "TextBox")
3380:         WITH loc_oPg.txt_4c__desccp
3381:             .Value    = ""
3382:             .Top      = 432
3383:             .Left     = 99
3384:             .Width    = 298
3385:             .Height   = 21
3386:             .FontName = "Tahoma"
3387:             .FontSize = 8
3388:         ENDWITH
3389:         BINDEVENT(loc_oPg.txt_4c__desccp, "LostFocus", THIS, "TabCompo_DesccpLostFocus")
3390: 
3391:         loc_oPg.AddObject("lbl_4c_Label5", "Label")
3392:         WITH loc_oPg.lbl_4c_Label5
3393:             .Caption   = "Substitui :"
3394:             .Top       = 435
3395:             .Left      = 465
3396:             .Width     = 50
3397:             .Height    = 15
3398:             .FontName  = "Tahoma"
3399:             .FontSize  = 8
3400:             .BackStyle = 0
3401:             .ForeColor = RGB(90,90,90)
3402:         ENDWITH
3403: 
3404:         loc_oPg.AddObject("txt_4c__matsub", "TextBox")
3405:         WITH loc_oPg.txt_4c__matsub
3406:             .Value    = ""
3407:             .Top      = 432
3408:             .Left     = 517
3409:             .Width    = 108
3410:             .Height   = 21
3411:             .FontName = "Tahoma"
3412:             .FontSize = 8
3413:         ENDWITH
3414:         BINDEVENT(loc_oPg.txt_4c__matsub, "LostFocus", THIS, "TabCompo_MatsubLostFocus")
3415: 
3416:         *-- === CHECKBOXES LIBERAR CUSTO / VENDA (top=458-459) ==============================
3417:         loc_oPg.AddObject("chk_4c_ChkLiberaCusto", "CheckBox")
3418:         WITH loc_oPg.chk_4c_ChkLiberaCusto
3419:             .Caption   = "Custo"
3420:             .Value     = .F.
3421:             .Top       = 458
3422:             .Left      = 9
3423:             .Width     = 39
3424:             .Height    = 38
3425:             .FontName  = "Tahoma"
3426:             .FontSize  = 8
3427:             .BackStyle = 0
3428:             .Themes    = .F.
3429:             .Visible   = .T.
3430:         ENDWITH
3431:         BINDEVENT(loc_oPg.chk_4c_ChkLiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
3432: 
3433:         loc_oPg.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
3434:         WITH loc_oPg.chk_4c_ChkLiberaVenda
3435:             .Caption   = "Venda"
3436:             .Value     = .F.
3437:             .Top       = 459
3438:             .Left      = 323
3439:             .Width     = 39
3440:             .Height    = 38
3441:             .FontName  = "Tahoma"
3442:             .FontSize  = 8
3443:             .BackStyle = 0
3444:             .Themes    = .F.
3445:             .Visible   = .T.
3446:         ENDWITH
3447:         BINDEVENT(loc_oPg.chk_4c_ChkLiberaVenda, "Click", THIS, "ChkLiberaVendaClick")
3448: 
3449:         *-- === LABELS DIVISORES CUSTO/VENDA (top=473-474) ==================================
3450:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
3451:         WITH loc_oPg.lbl_4c_Label1
3452:             .Caption   = " Custo "
3453:             .Top       = 473
3454:             .Left      = 47
3455:             .Width     = 46
3456:             .Height    = 16
3457:             .FontName  = "Tahoma"
3458:             .FontSize  = 8
3459:             .BackStyle = 1
3460:             .BackColor = RGB(220,220,220)
3461:             .ForeColor = RGB(50,50,50)
3462:         ENDWITH
3463: 
3464:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
3465:         WITH loc_oPg.lbl_4c_Label2
3466:             .Caption   = " Venda "
3467:             .Top       = 474
3468:             .Left      = 361
3469:             .Width     = 48
3470:             .Height    = 16
3471:             .FontName  = "Tahoma"
3472:             .FontSize  = 8
3473:             .BackStyle = 1
3474:             .BackColor = RGB(220,220,220)
3475:             .ForeColor = RGB(50,50,50)
3476:         ENDWITH
3477: 
3478:         *-- === SHAPES DIVISORES VISUAIS (top=497-498) ======================================
3479:         loc_oPg.AddObject("shp_4c_Shape6", "Shape")
3480:         WITH loc_oPg.shp_4c_Shape6
3481:             .Top         = 497
3482:             .Left        = 9
3483:             .Width       = 158
3484:             .Height      = 2
3485:             .BackColor   = RGB(180,180,180)
3486:             .BackStyle   = 1
3487:             .BorderColor = RGB(180,180,180)

*-- Linhas 3585 a 3655:
3585:             .ToolTipText     = "Calcular Peso"
3586:             .Visible         = .T.
3587:         ENDWITH
3588:         BINDEVENT(loc_oPg.cmd_4c_CmdPesoM, "Click", THIS, "CmdPesoMClick")
3589: 
3590:         *-- Say22 "MKP" (top=542, left=9) - label para Get_cmkpc
3591:         loc_oPg.AddObject("lbl_4c_Label22", "Label")
3592:         WITH loc_oPg.lbl_4c_Label22
3593:             .Caption   = "MKP"
3594:             .Top       = 542
3595:             .Left      = 9
3596:             .Width     = 22
3597:             .Height    = 15
3598:             .FontName  = "Tahoma"
3599:             .FontSize  = 8
3600:             .BackStyle = 0
3601:             .ForeColor = RGB(90,90,90)
3602:         ENDWITH
3603: 
3604:         *-- Get_cmkpc (top=557, left=9, w=24): markup de custo
3605:         loc_oPg.AddObject("txt_4c_Cmkpc", "TextBox")
3606:         WITH loc_oPg.txt_4c_Cmkpc
3607:             .Value    = ""
3608:             .Top      = 557
3609:             .Left     = 9
3610:             .Width    = 24
3611:             .Height   = 23
3612:             .FontName = "Tahoma"
3613:             .FontSize = 8
3614:         ENDWITH
3615:         BINDEVENT(loc_oPg.txt_4c_Cmkpc, "LostFocus", THIS, "TabCompo_CmkpcLostFocus")
3616: 
3617:         *-- lblValAdics (top=542, left=64): "Valor Adicional"
3618:         loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
3619:         WITH loc_oPg.lbl_4c_LblValAdics
3620:             .Caption   = "Valor Adicional"
3621:             .Top       = 542
3622:             .Left      = 64
3623:             .Width     = 71
3624:             .Height    = 15
3625:             .FontName  = "Tahoma"
3626:             .FontSize  = 8
3627:             .BackStyle = 0
3628:             .ForeColor = RGB(90,90,90)
3629:         ENDWITH
3630: 
3631:         *-- get_pftioc (top=557, left=64, w=94): valor adicional custo (read-only)
3632:         loc_oPg.AddObject("txt_4c__pftioc", "TextBox")
3633:         WITH loc_oPg.txt_4c__pftioc
3634:             .Value    = 0
3635:             .Top      = 557
3636:             .Left     = 64
3637:             .Width    = 94
3638:             .Height   = 23
3639:             .FontName = "Tahoma"
3640:             .FontSize = 8
3641:             .ReadOnly = .T.
3642:         ENDWITH
3643: 
3644:         *-- chkPlanCus (top=556, left=36): planejamento custo
3645:         loc_oPg.AddObject("chk_4c_ChkPlanCus", "CheckBox")
3646:         WITH loc_oPg.chk_4c_ChkPlanCus
3647:             .Caption   = ""
3648:             .Value     = .F.
3649:             .Top       = 556
3650:             .Left      = 36
3651:             .Width     = 25
3652:             .Height    = 25
3653:             .BackStyle = 0
3654:             .Themes    = .F.
3655:             .Visible   = .T.

*-- Linhas 3681 a 3764:
3681:             .FontName = "Tahoma"
3682:             .FontSize = 8
3683:         ENDWITH
3684:         BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TabCompo_MargemLostFocus")
3685: 
3686:         *-- lblIdeal "Preco Ideal (Moeda 1)" (top=503, left=416)
3687:         loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
3688:         WITH loc_oPg.lbl_4c_LblIdeal
3689:             .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
3690:             .Top       = 503
3691:             .Left      = 416
3692:             .Width     = 111
3693:             .Height    = 15
3694:             .FontName  = "Tahoma"
3695:             .FontSize  = 8
3696:             .BackStyle = 0
3697:             .ForeColor = RGB(90,90,90)
3698:         ENDWITH
3699: 
3700:         *-- getPvideal (top=517, left=416, w=110): preco ideal (read-only)
3701:         loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
3702:         WITH loc_oPg.txt_4c_Pvideal
3703:             .Value    = 0
3704:             .Top      = 517
3705:             .Left     = 416
3706:             .Width    = 110
3707:             .Height   = 23
3708:             .FontName = "Tahoma"
3709:             .FontSize = 8
3710:             .ReadOnly = .T.
3711:         ENDWITH
3712: 
3713:         *-- getMoeda (top=517, left=529, w=31): moeda de venda (editable+lookup)
3714:         loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
3715:         WITH loc_oPg.txt_4c_Moeda
3716:             .Value    = ""
3717:             .Top      = 517
3718:             .Left     = 529
3719:             .Width    = 31
3720:             .Height   = 23
3721:             .FontName = "Tahoma"
3722:             .FontSize = 8
3723:         ENDWITH
3724:         BINDEVENT(loc_oPg.txt_4c_Moeda, "LostFocus", THIS, "TabCompo_MoedaLostFocus")
3725: 
3726:         *-- lblFIdeals "Fator Ideal" (top=503, left=563)
3727:         loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
3728:         WITH loc_oPg.lbl_4c_LblFIdeals
3729:             .Caption   = "Fator Ideal"
3730:             .Top       = 503
3731:             .Left      = 563
3732:             .Width     = 55
3733:             .Height    = 15
3734:             .FontName  = "Tahoma"
3735:             .FontSize  = 8
3736:             .BackStyle = 0
3737:             .ForeColor = RGB(90,90,90)
3738:         ENDWITH
3739: 
3740:         *-- getFIdeals (top=517, left=563, w=110): fator ideal (read-only)
3741:         loc_oPg.AddObject("txt_4c_FIdeals", "TextBox")
3742:         WITH loc_oPg.txt_4c_FIdeals
3743:             .Value    = 0
3744:             .Top      = 517
3745:             .Left     = 563
3746:             .Width    = 110
3747:             .Height   = 23
3748:             .FontName = "Tahoma"
3749:             .FontSize = 8
3750:             .ReadOnly = .T.
3751:         ENDWITH
3752: 
3753:         *-- Say14 "MKP" (top=542, left=360) - label para Getftio
3754:         loc_oPg.AddObject("lbl_4c_Label14", "Label")
3755:         WITH loc_oPg.lbl_4c_Label14
3756:             .Caption   = "MKP"
3757:             .Top       = 542
3758:             .Left      = 360
3759:             .Width     = 22
3760:             .Height    = 15
3761:             .FontName  = "Tahoma"
3762:             .FontSize  = 8
3763:             .BackStyle = 0
3764:             .ForeColor = RGB(90,90,90)

*-- Linhas 3775 a 3818:
3775:             .FontName = "Tahoma"
3776:             .FontSize = 8
3777:         ENDWITH
3778:         BINDEVENT(loc_oPg.txt_4c_Ftio, "LostFocus", THIS, "TabCompo_FtioLostFocus")
3779: 
3780:         *-- Say13 "Valor Adicional" (top=542, left=416)
3781:         loc_oPg.AddObject("lbl_4c_Label13", "Label")
3782:         WITH loc_oPg.lbl_4c_Label13
3783:             .Caption   = "Valor Adicional"
3784:             .Top       = 542
3785:             .Left      = 416
3786:             .Width     = 71
3787:             .Height    = 15
3788:             .FontName  = "Tahoma"
3789:             .FontSize  = 8
3790:             .BackStyle = 0
3791:             .ForeColor = RGB(90,90,90)
3792:         ENDWITH
3793: 
3794:         *-- Get_Pftio (top=557, left=416, w=110): valor adicional/preco com fiacao (read-only)
3795:         loc_oPg.AddObject("txt_4c_Pftio", "TextBox")
3796:         WITH loc_oPg.txt_4c_Pftio
3797:             .Value    = 0
3798:             .Top      = 557
3799:             .Left     = 416
3800:             .Width    = 110
3801:             .Height   = 23
3802:             .FontName = "Tahoma"
3803:             .FontSize = 8
3804:             .ReadOnly = .T.
3805:         ENDWITH
3806: 
3807:         *-- Say12 "Fator" (top=542, left=563)
3808:         loc_oPg.AddObject("lbl_4c_Label12", "Label")
3809:         WITH loc_oPg.lbl_4c_Label12
3810:             .Caption   = "Fator"
3811:             .Top       = 542
3812:             .Left      = 563
3813:             .Width     = 28
3814:             .Height    = 15
3815:             .FontName  = "Tahoma"
3816:             .FontSize  = 8
3817:             .BackStyle = 0
3818:             .ForeColor = RGB(90,90,90)

*-- Linhas 3829 a 3995:
3829:             .FontName = "Tahoma"
3830:             .FontSize = 8
3831:         ENDWITH
3832:         BINDEVENT(loc_oPg.txt_4c_Fvenda, "LostFocus", THIS, "TabCompo_FvendaLostFocus")
3833: 
3834:         *-- getMoepv (top=557, left=677, w=31): moeda preco venda (editable+lookup)
3835:         loc_oPg.AddObject("txt_4c_Moepv", "TextBox")
3836:         WITH loc_oPg.txt_4c_Moepv
3837:             .Value    = ""
3838:             .Top      = 557
3839:             .Left     = 677
3840:             .Width    = 31
3841:             .Height   = 23
3842:             .FontName = "Tahoma"
3843:             .FontSize = 8
3844:         ENDWITH
3845:         BINDEVENT(loc_oPg.txt_4c_Moepv, "LostFocus", THIS, "TabCompo_MoepvLostFocus")
3846: 
3847:         *-- Get_mftio (top=557, left=529, w=31): markup fiacao (read-only)
3848:         loc_oPg.AddObject("txt_4c_Mftio", "TextBox")
3849:         WITH loc_oPg.txt_4c_Mftio
3850:             .Value    = 0
3851:             .Top      = 557
3852:             .Left     = 529
3853:             .Width    = 31
3854:             .Height   = 23
3855:             .FontName = "Tahoma"
3856:             .FontSize = 8
3857:             .ReadOnly = .T.
3858:         ENDWITH
3859: 
3860:         *-- Say24 "Sts" (top=542, left=324) - label para getStatus
3861:         loc_oPg.AddObject("lbl_4c_Label24", "Label")
3862:         WITH loc_oPg.lbl_4c_Label24
3863:             .Caption   = "Sts"
3864:             .Top       = 542
3865:             .Left      = 324
3866:             .Width     = 17
3867:             .Height    = 15
3868:             .FontName  = "Tahoma"
3869:             .FontSize  = 8
3870:             .BackStyle = 0
3871:             .ForeColor = RGB(90,90,90)
3872:         ENDWITH
3873: 
3874:         *-- getStatus (top=557, left=324, w=31): status composicao (editable+lookup)
3875:         loc_oPg.AddObject("txt_4c_Status", "TextBox")
3876:         WITH loc_oPg.txt_4c_Status
3877:             .Value    = ""
3878:             .Top      = 557
3879:             .Left     = 324
3880:             .Width    = 31
3881:             .Height   = 23
3882:             .FontName = "Tahoma"
3883:             .FontSize = 8
3884:         ENDWITH
3885:         BINDEVENT(loc_oPg.txt_4c_Status, "LostFocus", THIS, "TabCompo_StatusLostFocus")
3886: 
3887:         *-- chkPlanVen (top=556, left=387): planejamento venda
3888:         loc_oPg.AddObject("chk_4c_ChkPlanVen", "CheckBox")
3889:         WITH loc_oPg.chk_4c_ChkPlanVen
3890:             .Caption   = ""
3891:             .Value     = .F.
3892:             .Top       = 556
3893:             .Left      = 387
3894:             .Width     = 25
3895:             .Height    = 25
3896:             .BackStyle = 0
3897:             .Themes    = .F.
3898:             .Visible   = .T.
3899:         ENDWITH
3900: 
3901:         *-- Chk_Pvenda (top=595, left=387, w=25, h=25): usar preco ideal
3902:         loc_oPg.AddObject("chk_4c_ChkPvenda", "CheckBox")
3903:         WITH loc_oPg.chk_4c_ChkPvenda
3904:             .Caption   = ""
3905:             .Value     = .F.
3906:             .Top       = 595
3907:             .Left      = 387
3908:             .Width     = 25
3909:             .Height    = 25
3910:             .BackStyle = 0
3911:             .Themes    = .F.
3912:             .ToolTipText = "Usar Pre" + CHR(231) + "o Ideal"
3913:             .Visible   = .T.
3914:         ENDWITH
3915:         BINDEVENT(loc_oPg.chk_4c_ChkPvenda, "Click", THIS, "ChkPvendaClick")
3916: 
3917:         *-- lblVenda "Preco Atual (Moeda 2)" (top=581, left=416)
3918:         loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
3919:         WITH loc_oPg.lbl_4c_LblVenda
3920:             .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
3921:             .Top       = 581
3922:             .Left      = 416
3923:             .Width     = 115
3924:             .Height    = 15
3925:             .FontName  = "Tahoma"
3926:             .FontSize  = 8
3927:             .BackStyle = 0
3928:             .ForeColor = RGB(90,90,90)
3929:         ENDWITH
3930: 
3931:         *-- getPven (top=596, left=416, w=110): preco de venda atual (read-only)
3932:         loc_oPg.AddObject("txt_4c_Pven", "TextBox")
3933:         WITH loc_oPg.txt_4c_Pven
3934:             .Value    = 0
3935:             .Top      = 596
3936:             .Left     = 416
3937:             .Width    = 110
3938:             .Height   = 23
3939:             .FontName = "Tahoma"
3940:             .FontSize = 8
3941:             .ReadOnly = .T.
3942:         ENDWITH
3943: 
3944:         *-- getMoev (top=596, left=529, w=31): moeda valor venda (editable+lookup)
3945:         loc_oPg.AddObject("txt_4c_Moev", "TextBox")
3946:         WITH loc_oPg.txt_4c_Moev
3947:             .Value    = ""
3948:             .Top      = 596
3949:             .Left     = 529
3950:             .Width    = 31
3951:             .Height   = 23
3952:             .FontName = "Tahoma"
3953:             .FontSize = 8
3954:         ENDWITH
3955:         BINDEVENT(loc_oPg.txt_4c_Moev, "LostFocus", THIS, "TabCompo_MoevLostFocus")
3956: 
3957:         *-- lblFAtuals "Fator Atual" (top=581, left=563)
3958:         loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
3959:         WITH loc_oPg.lbl_4c_LblFAtuals
3960:             .Caption   = "Fator Atual"
3961:             .Top       = 581
3962:             .Left      = 563
3963:             .Width     = 56
3964:             .Height    = 15
3965:             .FontName  = "Tahoma"
3966:             .FontSize  = 8
3967:             .BackStyle = 0
3968:             .ForeColor = RGB(90,90,90)
3969:         ENDWITH
3970: 
3971:         *-- getFAtuals (top=596, left=563, w=110): fator atual (read-only)
3972:         loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
3973:         WITH loc_oPg.txt_4c_FAtuals
3974:             .Value    = 0
3975:             .Top      = 596
3976:             .Left     = 563
3977:             .Width    = 110
3978:             .Height   = 23
3979:             .FontName = "Tahoma"
3980:             .FontSize = 8
3981:             .ReadOnly = .T.
3982:         ENDWITH
3983: 
3984:         *-- Say25 "Financeiro" (top=581, left=678) - label para Get_Encarg
3985:         loc_oPg.AddObject("lbl_4c_Label25", "Label")
3986:         WITH loc_oPg.lbl_4c_Label25
3987:             .Caption   = "Financeiro"
3988:             .Top       = 581
3989:             .Left      = 678
3990:             .Width     = 51
3991:             .Height    = 15
3992:             .FontName  = "Tahoma"
3993:             .FontSize  = 8
3994:             .BackStyle = 0
3995:             .ForeColor = RGB(90,90,90)

*-- Linhas 4039 a 4090:
4039:             .ToolTipText     = "Calcular Valores"
4040:             .Visible         = .T.
4041:         ENDWITH
4042:         BINDEVENT(loc_oPg.cmd_4c_CmdCalcVals, "Click", THIS, "CmdCalcValsClick")
4043: 
4044:         *-- BINDEVENT para campos de moeda existentes (getMoec, getMoecusf)
4045:         BINDEVENT(loc_oPg.txt_4c_PcusMoe,  "LostFocus", THIS, "TabCompo_MoecLostFocus")
4046:         BINDEVENT(loc_oPg.txt_4c_MoecusFoe,"LostFocus", THIS, "TabCompo_MoecusfLostFocus")
4047: 
4048:         *-- BINDEVENT para AfterRowColChange dos grids
4049:         BINDEVENT(loc_oPg.grd_4c_Compo,    "AfterRowColChange", THIS, "CompoGrd_AfterRowColChange")
4050:         BINDEVENT(loc_oPg.grd_4c_SubCompo, "AfterRowColChange", THIS, "SubCompoGrd_AfterRowColChange")
4051: 
4052:         *-- Criar cursors placeholder para os grids (evitar erro de RecordSource vazio)
4053:         IF !USED("cursor_4c_Compo")
4054:             SET NULL ON
4055:             CREATE CURSOR cursor_4c_Compo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), compos C(10))
4056:             SET NULL OFF
4057:         ENDIF
4058:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
4059:         WITH loc_oPg.grd_4c_Compo
4060:             .Column1.ControlSource  = "cursor_4c_Compo.mats"
4061:             .Column2.ControlSource  = "cursor_4c_Compo.dcompos"
4062:             .Column3.ControlSource  = "cursor_4c_Compo.unicompos"
4063:             .Column4.ControlSource  = "cursor_4c_Compo.pcompos"
4064:             .Column5.ControlSource  = "cursor_4c_Compo.qtds"
4065:             .Column6.ControlSource  = "cursor_4c_Compo.totas"
4066:             .Column7.ControlSource  = "cursor_4c_Compo.moeds"
4067:             .Column8.ControlSource  = "cursor_4c_Compo.obscompos"
4068:             .Column9.ControlSource  = "cursor_4c_Compo.etiqs"
4069:             .Column10.ControlSource = "cursor_4c_Compo.qtscons"
4070:             .Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
4071:             .Column12.ControlSource = "cursor_4c_Compo.cunips"
4072:             .Column13.ControlSource = "cursor_4c_Compo.ordems"
4073:             .Column14.ControlSource = "cursor_4c_Compo.compos"
4074:         ENDWITH
4075: 
4076:         IF !USED("cursor_4c_SubCompo")
4077:             SET NULL ON
4078:             CREATE CURSOR cursor_4c_SubCompo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), matsubs C(14), codtams C(4))
4079:             SET NULL OFF
4080:         ENDIF
4081:         loc_oPg.grd_4c_SubCompo.RecordSource = "cursor_4c_SubCompo"
4082:         WITH loc_oPg.grd_4c_SubCompo
4083:             .Column1.ControlSource  = "cursor_4c_SubCompo.mats"
4084:             .Column2.ControlSource  = "cursor_4c_SubCompo.dcompos"
4085:             .Column3.ControlSource  = "cursor_4c_SubCompo.unicompos"
4086:             .Column4.ControlSource  = "cursor_4c_SubCompo.pcompos"
4087:             .Column5.ControlSource  = "cursor_4c_SubCompo.qtds"
4088:             .Column6.ControlSource  = "cursor_4c_SubCompo.totas"
4089:             .Column7.ControlSource  = "cursor_4c_SubCompo.moeds"
4090:             .Column8.ControlSource  = "cursor_4c_SubCompo.obscompos"

*-- Linhas 4113 a 4291:
4113:     *--------------------------------------------------------------------------
4114:     * ConfigurarTabCustos - Aba 3: Custo da composicao (pgCusto)
4115:     * Legado: pgframeDados.pgCusto (grdCompo 12-col, cmbTipos, cmdgCompo)
4116:     * FASE 9: implementacao completa com BINDEVENTs e botoes
4117:     *--------------------------------------------------------------------------
4118:     PROTECTED PROCEDURE ConfigurarTabCustos()
4119:         LOCAL loc_oPg
4120:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
4121: 
4122:         *-- Label "Tipo :" (top=159, left=112)
4123:         loc_oPg.AddObject("lbl_4c_TipoCusto", "Label")
4124:         WITH loc_oPg.lbl_4c_TipoCusto
4125:             .Caption   = "Tipo :"
4126:             .Top       = 159
4127:             .Left      = 112
4128:             .Width     = 29
4129:             .Height    = 15
4130:             .FontName  = "Tahoma"
4131:             .FontSize  = 8
4132:             .BackStyle = 0
4133:             .ForeColor = RGB(90, 90, 90)
4134:         ENDWITH
4135: 
4136:         *-- ComboBox cmbTipos (top=154, left=143, width=187)
4137:         *-- Filtra o grid de custos por tipo de calculo de custo
4138:         loc_oPg.AddObject("cmb_4c_TiposCusto", "ComboBox")
4139:         WITH loc_oPg.cmb_4c_TiposCusto
4140:             .Top       = 154
4141:             .Left      = 143
4142:             .Width     = 187
4143:             .Height    = 23
4144:             .Style     = 2
4145:             .FontName  = "Tahoma"
4146:             .FontSize  = 8
4147:         ENDWITH
4148:         WITH loc_oPg.cmb_4c_TiposCusto
4149:             .AddItem("Todos")
4150:             .AddItem("Custo Completo")
4151:             .AddItem("Custo Parcial")
4152:             .AddItem("Custo Calculado")
4153:             .ListIndex = 1
4154:         ENDWITH
4155:         BINDEVENT(loc_oPg.cmb_4c_TiposCusto, "LostFocus", THIS, "CmbTiposCustoValid")
4156: 
4157:         *-- grdCompo - Grid de composicao de custo (top=178, left=34, width=813, height=230, 12 cols)
4158:         *-- Dados: SIGPRCPO filtrado por Tipos (tipo de calculo)
4159:         loc_oPg.AddObject("grd_4c_CompoCusto", "Grid")
4160:         WITH loc_oPg.grd_4c_CompoCusto
4161:             .Top         = 178
4162:             .Left        = 34
4163:             .Width       = 813
4164:             .Height      = 230
4165:             .ReadOnly    = .F.
4166:             .DeleteMark  = .F.
4167:             .RecordMark  = .F.
4168:             .ScrollBars  = 3
4169:             .GridLines   = 3
4170:             .ColumnCount = 12
4171:             .FontName    = "Verdana"
4172:             .FontSize    = 8
4173:             .Visible     = .T.
4174:         ENDWITH
4175:         WITH loc_oPg.grd_4c_CompoCusto
4176:             .Column1.Header1.Caption  = "Item"
4177:             .Column1.Width  = 80
4178:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
4179:             .Column2.Width  = 180
4180:             .Column3.Header1.Caption  = "Un"
4181:             .Column3.Width  = 35
4182:             .Column4.Header1.Caption  = "Valor"
4183:             .Column4.Width  = 75
4184:             .Column5.Header1.Caption  = "Qtd"
4185:             .Column5.Width  = 60
4186:             .Column6.Header1.Caption  = "Total"
4187:             .Column6.Width  = 75
4188:             .Column7.Header1.Caption  = "Moe"
4189:             .Column7.Width  = 35
4190:             .Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
4191:             .Column8.Width  = 75
4192:             .Column9.Header1.Caption  = "Etiq"
4193:             .Column9.Width  = 35
4194:             .Column10.Header1.Caption = "Consumo"
4195:             .Column10.Width = 70
4196:             .Column11.Header1.Caption = "Qtd"
4197:             .Column11.Width = 55
4198:             .Column12.Header1.Caption = "Un"
4199:             .Column12.Width = 35
4200:         ENDWITH
4201:         BINDEVENT(loc_oPg.grd_4c_CompoCusto, "AfterRowColChange", THIS, "CustosGrd_AfterRowColChange")
4202: 
4203:         *-- Botoes Incluir/Excluir para grid de custo
4204:         *-- Legado: cmdgCompo (CommandGroup) top=240, left=851, buttonCount=2
4205:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
4206:         WITH loc_oPg.cnt_4c_BotoesCusto
4207:             .Top         = 178
4208:             .Left        = 851
4209:             .Width       = 50
4210:             .Height      = 90
4211:             .BackStyle = 1
4212:             .BackColor = RGB(53, 53, 53)
4213:             .BorderWidth = 0
4214:             .Visible     = .T.
4215:         ENDWITH
4216: 
4217:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_CustoIncluir", "CommandButton")
4218:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoIncluir
4219:             .Caption       = "+"
4220:             .Top           = 0
4221:             .Left          = 0
4222:             .Width         = 50
4223:             .Height        = 45
4224:             .FontName      = "Tahoma"
4225:             .FontSize      = 14
4226:             .FontBold      = .T.
4227:             .Themes        = .F.
4228:             .SpecialEffect = 0
4229:             .BackColor     = RGB(230, 255, 230)
4230:             .ForeColor     = RGB(0, 128, 0)
4231:             .Visible       = .T.
4232:         ENDWITH
4233:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoIncluir, "Click", THIS, "CmdCustoIncluirClick")
4234: 
4235:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_CustoExcluir", "CommandButton")
4236:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoExcluir
4237:             .Caption       = "-"
4238:             .Top           = 45
4239:             .Left          = 0
4240:             .Width         = 50
4241:             .Height        = 45
4242:             .FontName      = "Tahoma"
4243:             .FontSize      = 14
4244:             .FontBold      = .T.
4245:             .Themes        = .F.
4246:             .SpecialEffect = 0
4247:             .BackColor     = RGB(255, 230, 230)
4248:             .ForeColor     = RGB(192, 0, 0)
4249:             .Visible       = .T.
4250:         ENDWITH
4251:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoExcluir, "Click", THIS, "CmdCustoExcluirClick")
4252: 
4253:         *-- Shape separador horizontal (Shape2: top=460, left=35, width=158, height=2)
4254:         loc_oPg.AddObject("shp_4c_SepCusto", "Shape")
4255:         WITH loc_oPg.shp_4c_SepCusto
4256:             .Top         = 460
4257:             .Left        = 35
4258:             .Width       = 158
4259:             .Height      = 2
4260:             .FillColor   = RGB(180, 180, 180)
4261:             .BackColor   = RGB(180, 180, 180)
4262:             .BorderColor = RGB(180, 180, 180)
4263:         ENDWITH
4264: 
4265:         *-- Label "Descricao :" (Say16: top=415, left=52)
4266:         loc_oPg.AddObject("lbl_4c_DescCusto", "Label")
4267:         WITH loc_oPg.lbl_4c_DescCusto
4268:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4269:             .Top       = 415
4270:             .Left      = 52
4271:             .Width     = 62
4272:             .Height    = 15
4273:             .FontName  = "Tahoma"
4274:             .FontSize  = 8
4275:             .BackStyle = 0
4276:             .ForeColor = RGB(90, 90, 90)
4277:         ENDWITH
4278: 
4279:         *-- TextBox Get_Desc - mostra descricao do item selecionado (top=412, left=116, width=304)
4280:         loc_oPg.AddObject("txt_4c_DescCusto", "TextBox")
4281:         WITH loc_oPg.txt_4c_DescCusto
4282:             .Value    = ""
4283:             .Top      = 412
4284:             .Left     = 116
4285:             .Width    = 304
4286:             .Height   = 21
4287:             .FontName = "Tahoma"
4288:             .FontSize = 8
4289:             .ReadOnly = .T.
4290:         ENDWITH
4291: 

*-- Linhas 4396 a 4468:
4396:     * ConfigurarTabDadosFiscais - Aba 4: Dados fiscais (pgDadosFiscais)
4397:     * IMPLEMENTADO NA FASE 6
4398:     *--------------------------------------------------------------------------
4399:     PROTECTED PROCEDURE ConfigurarTabDadosFiscais()
4400:         LOCAL loc_oPg
4401:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
4402: 
4403:         *-- Classificacao Fiscal (top=211, left=206, width=94)
4404:         loc_oPg.AddObject("lbl_4c_Clfiscal", "Label")
4405:         WITH loc_oPg.lbl_4c_Clfiscal
4406:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
4407:             .Top       = 216
4408:             .Left      = 102
4409:             .Width     = 99
4410:             .Height    = 15
4411:             .FontName  = "Tahoma"
4412:             .FontSize  = 8
4413:             .BackStyle = 0
4414:             .ForeColor = RGB(90,90,90)
4415:         ENDWITH
4416: 
4417:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
4418:         WITH loc_oPg.txt_4c_Clfiscal
4419:             .Value    = ""
4420:             .Top      = 211
4421:             .Left     = 206
4422:             .Width    = 94
4423:             .Height   = 23
4424:             .FontName = "Tahoma"
4425:             .FontSize = 8
4426:             .MaxLength = 10
4427:         ENDWITH
4428:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TabFiscal_ClfiscalKeyPress")
4429: 
4430:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
4431:         WITH loc_oPg.txt_4c_Dclfiscal
4432:             .Value    = ""
4433:             .Top      = 211
4434:             .Left     = 303
4435:             .Width    = 303
4436:             .Height   = 23
4437:             .FontName = "Tahoma"
4438:             .FontSize = 8
4439:             .ReadOnly = .T.
4440:         ENDWITH
4441: 
4442:         *-- Origem Mercadoria (top=236, left=206, width=17)
4443:         loc_oPg.AddObject("lbl_4c_Origmerc", "Label")
4444:         WITH loc_oPg.lbl_4c_Origmerc
4445:             .Caption   = "Origem da Mercadoria :"
4446:             .Top       = 241
4447:             .Left      = 87
4448:             .Width     = 114
4449:             .Height    = 15
4450:             .FontName  = "Tahoma"
4451:             .FontSize  = 8
4452:             .BackStyle = 0
4453:             .ForeColor = RGB(90,90,90)
4454:         ENDWITH
4455: 
4456:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
4457:         WITH loc_oPg.txt_4c_Origmerc
4458:             .Value    = ""
4459:             .Top      = 236
4460:             .Left     = 206
4461:             .Width    = 17
4462:             .Height   = 23
4463:             .FontName = "Tahoma"
4464:             .FontSize = 8
4465:             .MaxLength = 1
4466:         ENDWITH
4467: 
4468:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")

*-- Linhas 4674 a 4756:
4674:             .FontSize = 8
4675:             .MaxLength = 2
4676:         ENDWITH
4677:         BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TabFiscal_MetalKeyPress")
4678: 
4679:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
4680:         WITH loc_oPg.txt_4c_DesMetal
4681:             .Value    = ""
4682:             .Top      = 429
4683:             .Left     = 564
4684:             .Width    = 150
4685:             .Height   = 23
4686:             .FontName = "Tahoma"
4687:             .FontSize = 8
4688:             .ReadOnly = .T.
4689:         ENDWITH
4690: 
4691:         *-- Teor (top=454, left=537)
4692:         loc_oPg.AddObject("lbl_4c_Teor", "Label")
4693:         WITH loc_oPg.lbl_4c_Teor
4694:             .Caption   = "Teor :"
4695:             .Top       = 454
4696:             .Left      = 490
4697:             .Width     = 45
4698:             .Height    = 15
4699:             .FontName  = "Tahoma"
4700:             .FontSize  = 8
4701:             .BackStyle = 0
4702:             .ForeColor = RGB(90,90,90)
4703:         ENDWITH
4704: 
4705:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
4706:         WITH loc_oPg.txt_4c_Teor
4707:             .Value    = ""
4708:             .Top      = 454
4709:             .Left     = 537
4710:             .Width    = 24
4711:             .Height   = 23
4712:             .FontName = "Tahoma"
4713:             .FontSize = 8
4714:             .MaxLength = 2
4715:         ENDWITH
4716:         BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TabFiscal_TeorKeyPress")
4717: 
4718:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
4719:         WITH loc_oPg.txt_4c_DesTeor
4720:             .Value    = ""
4721:             .Top      = 454
4722:             .Left     = 564
4723:             .Width    = 150
4724:             .Height   = 23
4725:             .FontName = "Tahoma"
4726:             .FontSize = 8
4727:             .ReadOnly = .T.
4728:         ENDWITH
4729: 
4730:         *-- Descricao ECF (top=429, left=206, width=213)
4731:         loc_oPg.AddObject("lbl_4c_DescEcf", "Label")
4732:         WITH loc_oPg.lbl_4c_DescEcf
4733:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
4734:             .Top       = 433
4735:             .Left      = 124
4736:             .Width     = 77
4737:             .Height    = 15
4738:             .FontName  = "Tahoma"
4739:             .FontSize  = 8
4740:             .BackStyle = 0
4741:             .ForeColor = RGB(90,90,90)
4742:         ENDWITH
4743: 
4744:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
4745:         WITH loc_oPg.txt_4c_DescEcfs
4746:             .Value    = ""
4747:             .Top      = 429
4748:             .Left     = 206
4749:             .Width    = 213
4750:             .Height   = 23
4751:             .FontName = "Tahoma"
4752:             .FontSize = 8
4753:             .MaxLength = 29
4754:         ENDWITH
4755: 
4756:         *-- Valor Estimado (top=454, left=206)

*-- Linhas 4793 a 5021:
4793: 
4794:     *--------------------------------------------------------------------------
4795:     * ConfigurarPgpgDadosFiscais - Completa Aba 4 Dados Fiscais
4796:     * Adiciona controles restantes + BINDEVENTs de todos os campos do tab fiscal
4797:     * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDadosFiscais()
4798:     *--------------------------------------------------------------------------
4799:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais()
4800:         LOCAL loc_oPg
4801:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
4802: 
4803:         *-- === GRUPO C.C. (get_gruccus: top=161, left=206, width=80) ============
4804: 
4805:         loc_oPg.AddObject("lbl_4c_Gruccus", "Label")
4806:         WITH loc_oPg.lbl_4c_Gruccus
4807:             .Caption   = "Grupo C.C. :"
4808:             .Top       = 165
4809:             .Left      = 138
4810:             .Width     = 63
4811:             .Height    = 15
4812:             .FontName  = "Tahoma"
4813:             .FontSize  = 8
4814:             .BackStyle = 0
4815:             .ForeColor = RGB(90, 90, 90)
4816:         ENDWITH
4817: 
4818:         loc_oPg.AddObject("txt_4c__gruccus", "TextBox")
4819:         WITH loc_oPg.txt_4c__gruccus
4820:             .Value         = ""
4821:             .Top           = 161
4822:             .Left          = 206
4823:             .Width         = 80
4824:             .Height        = 23
4825:             .FontName      = "Tahoma"
4826:             .FontSize      = 8
4827:             .MaxLength     = 10
4828:             .SpecialEffect = 1
4829:         ENDWITH
4830:         BINDEVENT(loc_oPg.txt_4c__gruccus, "LostFocus", THIS, "ValidarGruccus")
4831: 
4832:         loc_oPg.AddObject("txt_4c__dgruccus", "TextBox")
4833:         WITH loc_oPg.txt_4c__dgruccus
4834:             .Value    = ""
4835:             .Top      = 161
4836:             .Left     = 288
4837:             .Width    = 318
4838:             .Height   = 23
4839:             .FontName = "Tahoma"
4840:             .FontSize = 8
4841:             .ReadOnly = .T.
4842:         ENDWITH
4843:         BINDEVENT(loc_oPg.txt_4c__dgruccus, "LostFocus", THIS, "ValidarDgruccus")
4844: 
4845:         *-- === CONTA C.C. (get_contaccus: top=186, left=206, width=80) ==========
4846: 
4847:         loc_oPg.AddObject("lbl_4c_Contaccus", "Label")
4848:         WITH loc_oPg.lbl_4c_Contaccus
4849:             .Caption   = "Conta C.C. :"
4850:             .Top       = 189
4851:             .Left      = 138
4852:             .Width     = 63
4853:             .Height    = 15
4854:             .FontName  = "Tahoma"
4855:             .FontSize  = 8
4856:             .BackStyle = 0
4857:             .ForeColor = RGB(90, 90, 90)
4858:         ENDWITH
4859: 
4860:         loc_oPg.AddObject("txt_4c__contaccus", "TextBox")
4861:         WITH loc_oPg.txt_4c__contaccus
4862:             .Value         = ""
4863:             .Top           = 186
4864:             .Left          = 206
4865:             .Width         = 80
4866:             .Height        = 23
4867:             .FontName      = "Tahoma"
4868:             .FontSize      = 8
4869:             .MaxLength     = 10
4870:             .SpecialEffect = 1
4871:         ENDWITH
4872:         BINDEVENT(loc_oPg.txt_4c__contaccus, "LostFocus", THIS, "ValidarContaccus")
4873: 
4874:         loc_oPg.AddObject("txt_4c__dcontaccus", "TextBox")
4875:         WITH loc_oPg.txt_4c__dcontaccus
4876:             .Value    = ""
4877:             .Top      = 186
4878:             .Left     = 288
4879:             .Width    = 318
4880:             .Height   = 23
4881:             .FontName = "Tahoma"
4882:             .FontSize = 8
4883:             .ReadOnly = .T.
4884:         ENDWITH
4885:         BINDEVENT(loc_oPg.txt_4c__dcontaccus, "LostFocus", THIS, "ValidarDcontaccus")
4886: 
4887:         *-- === ALIQUOTA IPI (Get_AliqIPI: top=311, left=425, width=45) ==========
4888: 
4889:         loc_oPg.AddObject("lbl_4c_AliqIPI", "Label")
4890:         WITH loc_oPg.lbl_4c_AliqIPI
4891:             .Caption   = "Al" + CHR(237) + "quota de IPI :"
4892:             .Top       = 316
4893:             .Left      = 327
4894:             .Width     = 90
4895:             .Height    = 15
4896:             .FontName  = "Tahoma"
4897:             .FontSize  = 8
4898:             .BackStyle = 0
4899:             .ForeColor = RGB(90, 90, 90)
4900:         ENDWITH
4901: 
4902:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
4903:         WITH loc_oPg.txt_4c_AliqIPI
4904:             .Value    = 0
4905:             .Top      = 311
4906:             .Left     = 425
4907:             .Width    = 45
4908:             .Height   = 25
4909:             .FontName = "Tahoma"
4910:             .FontSize = 8
4911:         ENDWITH
4912:         BINDEVENT(loc_oPg.txt_4c_AliqIPI, "LostFocus", THIS, "ValidarAliqIPI")
4913: 
4914:         *-- === EXCECAO DA TIPI/IPI (getextipi: top=311, left=601, width=35) ======
4915: 
4916:         loc_oPg.AddObject("lbl_4c_Extipi", "Label")
4917:         WITH loc_oPg.lbl_4c_Extipi
4918:             .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
4919:             .Top       = 316
4920:             .Left      = 495
4921:             .Width     = 98
4922:             .Height    = 15
4923:             .FontName  = "Tahoma"
4924:             .FontSize  = 8
4925:             .BackStyle = 0
4926:             .ForeColor = RGB(90, 90, 90)
4927:         ENDWITH
4928: 
4929:         loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
4930:         WITH loc_oPg.txt_4c_Extipi
4931:             .Value     = ""
4932:             .Top       = 311
4933:             .Left      = 601
4934:             .Width     = 35
4935:             .Height    = 25
4936:             .FontName  = "Tahoma"
4937:             .FontSize  = 8
4938:             .MaxLength = 3
4939:         ENDWITH
4940:         BINDEVENT(loc_oPg.txt_4c_Extipi, "GotFocus", THIS, "TabFiscal_ExtIpiGotFocus")
4941: 
4942:         *-- === IAT (getiat: top=286, left=589, width=17) ========================
4943: 
4944:         loc_oPg.AddObject("lbl_4c_Iat", "Label")
4945:         WITH loc_oPg.lbl_4c_Iat
4946:             .Caption   = "IAT :"
4947:             .Top       = 290
4948:             .Left      = 558
4949:             .Width     = 26
4950:             .Height    = 15
4951:             .FontName  = "Tahoma"
4952:             .FontSize  = 8
4953:             .BackStyle = 0
4954:             .ForeColor = RGB(90, 90, 90)
4955:         ENDWITH
4956: 
4957:         loc_oPg.AddObject("lbl_4c_IatDesc", "Label")
4958:         WITH loc_oPg.lbl_4c_IatDesc
4959:             .Caption   = "[A]rredondamento [T]runcamento"
4960:             .Top       = 290
4961:             .Left      = 609
4962:             .Width     = 165
4963:             .Height    = 15
4964:             .FontName  = "Tahoma"
4965:             .FontSize  = 8
4966:             .BackStyle = 0
4967:             .ForeColor = RGB(120, 120, 120)
4968:         ENDWITH
4969: 
4970:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
4971:         WITH loc_oPg.txt_4c_Iat
4972:             .Value     = ""
4973:             .Top       = 286
4974:             .Left      = 589
4975:             .Width     = 17
4976:             .Height    = 23
4977:             .FontName  = "Tahoma"
4978:             .FontSize  = 8
4979:             .MaxLength = 1
4980:         ENDWITH
4981:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "ValidarIat")
4982: 
4983:         *-- === IPPT/CST (getIPPTCST: top=479, left=206, width=108) =============
4984:         *-- Campo de exibicao calculado: nao armazenado, somente leitura
4985: 
4986:         loc_oPg.AddObject("lbl_4c_IPPTCST", "Label")
4987:         WITH loc_oPg.lbl_4c_IPPTCST
4988:             .Caption   = "IPPT/CST :"
4989:             .Top       = 483
4990:             .Left      = 147
4991:             .Width     = 54
4992:             .Height    = 15
4993:             .FontName  = "Tahoma"
4994:             .FontSize  = 8
4995:             .BackStyle = 0
4996:             .ForeColor = RGB(90, 90, 90)
4997:         ENDWITH
4998: 
4999:         loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
5000:         WITH loc_oPg.txt_4c_IPPTCST
5001:             .Value    = ""
5002:             .Top      = 479
5003:             .Left     = 206
5004:             .Width    = 108
5005:             .Height   = 23
5006:             .FontName = "Tahoma"
5007:             .FontSize = 8
5008:             .ReadOnly = .T.
5009:         ENDWITH
5010: 
5011:         *-- === GRID CMV - Custo GR (grdCmv: top=338, left=754, width=223, h=141)
5012:         *-- 3 colunas: Periodo, Valor Custo GR, Moe
5013: 
5014:         loc_oPg.AddObject("lbl_4c_CmvTitulo", "Label")
5015:         WITH loc_oPg.lbl_4c_CmvTitulo
5016:             .Caption   = "Valor do Grama Produzido"
5017:             .Top       = 320
5018:             .Left      = 756
5019:             .Width     = 125
5020:             .Height    = 15
5021:             .FontName  = "Tahoma"

*-- Linhas 5078 a 5143:
5078:             .SpecialEffect   = 0
5079:             .ToolTipText     = "Gerar Descri" + CHR(231) + CHR(227) + "o Fiscal"
5080:         ENDWITH
5081:         BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "BtnDescFisClick")
5082: 
5083:         *-- === BINDEVENTS para controles JA CRIADOS em ConfigurarTabDadosFiscais ==
5084:         *-- Adicionar LostFocus nos campos lookup existentes
5085: 
5086:         BINDEVENT(loc_oPg.txt_4c_Clfiscal,  "LostFocus", THIS, "ValidarClfiscal")
5087:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "LostFocus", THIS, "ValidarDclfiscal")
5088:         BINDEVENT(loc_oPg.txt_4c_Origmerc,  "LostFocus", THIS, "ValidarOrigmerc")
5089:         BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "LostFocus", THIS, "ValidarDorigmerc")
5090:         BINDEVENT(loc_oPg.txt_4c_Sittricms, "LostFocus", THIS, "ValidarSittricms")
5091:         BINDEVENT(loc_oPg.txt_4c_Dsittricms,"LostFocus", THIS, "ValidarDsittricms")
5092:         BINDEVENT(loc_oPg.txt_4c_CodServs,  "LostFocus", THIS, "ValidarCodServs")
5093:         BINDEVENT(loc_oPg.txt_4c_Tptribs,   "LostFocus", THIS, "ValidarTptribs")
5094:         BINDEVENT(loc_oPg.txt_4c_Metal,     "LostFocus", THIS, "ValidarMetal")
5095:         BINDEVENT(loc_oPg.txt_4c_Teor,      "LostFocus", THIS, "ValidarTeor")
5096:         BINDEVENT(loc_oPg.txt_4c_Moedas,    "LostFocus", THIS, "ValidarMoedaEstimada")
5097:     ENDPROC
5098: 
5099:     *--------------------------------------------------------------------------
5100:     * ConfigurarTabDesigner - Aba 5: Designer/arquivos (pgDesigner)
5101:     * IMPLEMENTADO NA FASE 7
5102:     *--------------------------------------------------------------------------
5103:     PROTECTED PROCEDURE ConfigurarTabDesigner()
5104:         LOCAL loc_oPg
5105:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
5106: 
5107:         *-- grdDesigner (top=160, left=10, width=495, height=238, 4 cols)
5108:         *-- Dados: sigprtar - Data Inicio, Data Conclusao, Usuario, Tarefa
5109:         loc_oPg.AddObject("grd_4c_Designer", "Grid")
5110:         WITH loc_oPg.grd_4c_Designer
5111:             .Top         = 160
5112:             .Left        = 10
5113:             .Width       = 495
5114:             .Height      = 238
5115:             .ReadOnly    = .T.
5116:             .DeleteMark  = .F.
5117:             .RecordMark  = .F.
5118:             .ScrollBars  = 3
5119:             .GridLines   = 3
5120:             .ColumnCount = 4
5121:             .FontName    = "Verdana"
5122:             .FontSize    = 8
5123:             .Visible     = .T.
5124:         ENDWITH
5125:         WITH loc_oPg.grd_4c_Designer
5126:             .Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
5127:             .Column1.Width = 110
5128:             .Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
5129:             .Column2.Width = 120
5130:             .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
5131:             .Column3.Width = 100
5132:             .Column4.Header1.Caption = "Tarefa"
5133:             .Column4.Width = 160
5134:         ENDWITH
5135: 
5136:         *-- Observacao da Tarefa - EditBox (top=160, left=584, width=407, height=238)
5137:         loc_oPg.AddObject("lbl_4c_ObsTarefa", "Label")
5138:         WITH loc_oPg.lbl_4c_ObsTarefa
5139:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
5140:             .Top       = 144
5141:             .Left      = 583
5142:             .Width     = 130
5143:             .Height    = 15

*-- Linhas 5172 a 5390:
5172:             .Themes  = .F.
5173:             .Visible = .T.
5174:         ENDWITH
5175:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "Click", THIS, "BtnIniTarefaClick")
5176: 
5177:         loc_oPg.AddObject("cmd_4c_FimTarefa", "CommandButton")
5178:         WITH loc_oPg.cmd_4c_FimTarefa
5179:             .Caption = "Fim"
5180:             .Top     = 203
5181:             .Left    = 509
5182:             .Width   = 42
5183:             .Height  = 42
5184:             .FontName = "Tahoma"
5185:             .FontSize = 7
5186:             .Themes  = .F.
5187:             .Visible = .T.
5188:         ENDWITH
5189:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "Click", THIS, "BtnFimTarefaClick")
5190: 
5191:         *-- grdArquivos (top=415, left=10, width=495, height=202, 1 col)
5192:         *-- Dados: sigprarq - Arquivos do designer
5193:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
5194:         WITH loc_oPg.grd_4c_Arquivos
5195:             .Top         = 415
5196:             .Left        = 10
5197:             .Width       = 495
5198:             .Height      = 202
5199:             .ReadOnly    = .T.
5200:             .DeleteMark  = .F.
5201:             .RecordMark  = .F.
5202:             .ScrollBars  = 3
5203:             .GridLines   = 3
5204:             .ColumnCount = 1
5205:             .FontName    = "Verdana"
5206:             .FontSize    = 8
5207:             .Visible     = .T.
5208:         ENDWITH
5209:         WITH loc_oPg.grd_4c_Arquivos
5210:             .Column1.Header1.Caption = "Arquivos Para Designer"
5211:             .Column1.Width = 492
5212:         ENDWITH
5213: 
5214:         *-- Botoes de arquivo (top=416, 458, 500, left=509)
5215:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
5216:         WITH loc_oPg.cmd_4c_InsArqs
5217:             .Caption = "Inserir"
5218:             .Top     = 416
5219:             .Left    = 509
5220:             .Width   = 42
5221:             .Height  = 42
5222:             .FontName = "Tahoma"
5223:             .FontSize = 7
5224:             .Themes  = .F.
5225:             .Visible = .T.
5226:         ENDWITH
5227:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")
5228: 
5229:         loc_oPg.AddObject("cmd_4c_ExcArqs", "CommandButton")
5230:         WITH loc_oPg.cmd_4c_ExcArqs
5231:             .Caption = "Excluir"
5232:             .Top     = 458
5233:             .Left    = 509
5234:             .Width   = 42
5235:             .Height  = 42
5236:             .FontName = "Tahoma"
5237:             .FontSize = 7
5238:             .Themes  = .F.
5239:             .Visible = .T.
5240:         ENDWITH
5241:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "Click", THIS, "BtnExcArqsClick")
5242: 
5243:         loc_oPg.AddObject("cmd_4c_OpnArqs", "CommandButton")
5244:         WITH loc_oPg.cmd_4c_OpnArqs
5245:             .Caption = "Abrir"
5246:             .Top     = 500
5247:             .Left    = 509
5248:             .Width   = 42
5249:             .Height  = 42
5250:             .FontName = "Tahoma"
5251:             .FontSize = 7
5252:             .Themes  = .F.
5253:             .Visible = .T.
5254:         ENDWITH
5255:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "Click", THIS, "BtnOpnArqsClick")
5256: 
5257:         *-- Criar cursors placeholder
5258:         IF !USED("cursor_4c_Designer")
5259:             SET NULL ON
5260:             CREATE CURSOR cursor_4c_Designer (dtinis D, dtfims D, usuars C(10), tarefas C(20))
5261:             SET NULL OFF
5262:         ENDIF
5263:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_Designer"
5264:         WITH loc_oPg.grd_4c_Designer
5265:             .Column1.ControlSource = "cursor_4c_Designer.dtinis"
5266:             .Column2.ControlSource = "cursor_4c_Designer.dtfims"
5267:             .Column3.ControlSource = "cursor_4c_Designer.usuars"
5268:             .Column4.ControlSource = "cursor_4c_Designer.tarefas"
5269:         ENDWITH
5270: 
5271:         IF !USED("cursor_4c_Arquivos")
5272:             SET NULL ON
5273:             CREATE CURSOR cursor_4c_Arquivos (arquivos C(250))
5274:             SET NULL OFF
5275:         ENDIF
5276:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_Arquivos"
5277:         WITH loc_oPg.grd_4c_Arquivos
5278:             .Column1.ControlSource = "cursor_4c_Arquivos.arquivos"
5279:         ENDWITH
5280:     ENDPROC
5281: 
5282:     *--------------------------------------------------------------------------
5283:     * ConfigurarPgpgDesigner - Completa Aba 5 Designer
5284:     * Adiciona img_4c_ImgArqJpg, shp_4c_Shape1 e todos os BINDEVENTs
5285:     * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDesigner()
5286:     *--------------------------------------------------------------------------
5287:     PROTECTED PROCEDURE ConfigurarPgpgDesigner()
5288:         LOCAL loc_oPg
5289:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
5290: 
5291:         *-- Corrigir ReadOnly do grd_4c_Designer: .F. para Column4 ser editavel
5292:         *-- Colunas 1-3 usam When=.F. via BINDEVENT para somente leitura
5293:         loc_oPg.grd_4c_Designer.ReadOnly = .F.
5294: 
5295:         *-- Shape decorativo em volta da area de imagem (top=415, left=584, width=407, height=202)
5296:         loc_oPg.AddObject("shp_4c_Shape1", "Shape")
5297:         WITH loc_oPg.shp_4c_Shape1
5298:             .Top         = 415
5299:             .Left        = 584
5300:             .Width       = 407
5301:             .Height      = 202
5302:             .BorderColor = RGB(128, 128, 128)
5303:             .BorderWidth = 1
5304:             .BackStyle   = 0
5305:             .Visible     = .T.
5306:         ENDWITH
5307: 
5308:         *-- Imagem preview do arquivo selecionado (top=417, left=586, width=403, height=198)
5309:         loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
5310:         WITH loc_oPg.img_4c_ImgArqJpg
5311:             .Top     = 417
5312:             .Left    = 586
5313:             .Width   = 403
5314:             .Height  = 198
5315:             .Stretch = 2
5316:             .Visible = .F.
5317:         ENDWITH
5318:         BINDEVENT(loc_oPg.img_4c_ImgArqJpg, "Click", THIS, "ImgArqJpgClick")
5319: 
5320:         *-- BINDEVENTs para AfterRowColChange dos grids
5321:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "DesignerGrd_AfterRowColChange")
5322:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "ArquivosGrd_AfterRowColChange")
5323: 
5324:         *-- BINDEVENTs Colunas 1/2/3 do grd_4c_Designer (somente leitura sempre)
5325:         BINDEVENT(loc_oPg.grd_4c_Designer.Column1.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
5326:         BINDEVENT(loc_oPg.grd_4c_Designer.Column2.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
5327:         BINDEVENT(loc_oPg.grd_4c_Designer.Column3.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
5328: 
5329:         *-- BINDEVENTs Coluna 4 do grd_4c_Designer (Tarefa: editavel condicionalmente)
5330:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
5331:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
5332:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "LostFocus", THIS, "GrdDesignerCol4LostFocus")
5333: 
5334:         *-- BINDEVENT Column1 do grd_4c_Arquivos (editavel em INCLUIR/ALTERAR)
5335:         BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")
5336: 
5337:         *-- Cursor de tarefas para lookup do Column4 (codigo + descricao)
5338:         IF !USED("cursor_4c_Tarefas")
5339:             SET NULL ON
5340:             CREATE CURSOR cursor_4c_Tarefas (CodCads C(20), DesCads C(50))
5341:             SET NULL OFF
5342:         ENDIF
5343:     ENDPROC
5344: 
5345:     *--------------------------------------------------------------------------
5346:     * ConfigurarTabConsulta - Aba 6: Consulta de componentes por fase (PgDadosConsP)
5347:     * Legado: PgDadosConsP com GrdCons (9 cols editaveis) e grDTEMP (2 cols)
5348:     * IMPLEMENTADO NA FASE 9
5349:     *--------------------------------------------------------------------------
5350:     PROTECTED PROCEDURE ConfigurarTabConsulta()
5351:         LOCAL loc_oPg
5352:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
5353: 
5354:         *-- Criar cursors placeholder ANTES dos grids (evitar erro de RecordSource vazio)
5355:         *-- cursor_4c_Consulta: SIGPRCPO - componentes com fase (SigCdPrf) e categoria (SigCdCat)
5356:         IF !USED("cursor_4c_Consulta")
5357:             SET NULL ON
5358:             CREATE CURSOR cursor_4c_Consulta (mats C(14) NULL, qtds N(8,3) NULL, unicompos C(3) NULL, grupos C(10) NULL, dcompos C(40) NULL, ordems N(2,0) NULL, qtscons N(8,3) NULL, cats C(6) NULL, dscgrp C(20) NULL)
5359:             SET NULL OFF
5360:         ENDIF
5361: 
5362:         *-- cursor_4c_Temp: agrupamento x tempo (grDTEMP)
5363:         IF !USED("cursor_4c_Temp")
5364:             SET NULL ON
5365:             CREATE CURSOR cursor_4c_Temp (grupos C(10) NULL, totas N(11,3) NULL)
5366:             SET NULL OFF
5367:         ENDIF
5368: 
5369:         *-- GrdCons - Grid de componentes consulta (top=155, left=6, width=987, height=362, 9 cols)
5370:         *-- Colunas editaveis (INSERIR/ALTERAR): 4-Fase, 5-Descricao, 7-Consumo, 8-Cat
5371:         *-- Colunas somente leitura: 1-Componente, 2-Qtde, 3-Uni, 6-Ord, 9-DescCat
5372:         loc_oPg.AddObject("grd_4c_Consulta", "Grid")
5373:         WITH loc_oPg.grd_4c_Consulta
5374:             .Top         = 155
5375:             .Left        = 6
5376:             .Width       = 987
5377:             .Height      = 362
5378:             .ReadOnly    = .F.
5379:             .DeleteMark  = .F.
5380:             .RecordMark  = .F.
5381:             .ScrollBars  = 3
5382:             .GridLines   = 3
5383:             .ColumnCount = 9
5384:             .FontName    = "Verdana"
5385:             .FontSize    = 8
5386:             .Visible     = .T.
5387:         ENDWITH
5388:         *-- RecordSource ANTES dos headers/ControlSources (evita reset de colunas)
5389:         loc_oPg.grd_4c_Consulta.RecordSource = "cursor_4c_Consulta"
5390:         WITH loc_oPg.grd_4c_Consulta

*-- Linhas 5421 a 5464:
5421:             .Column9.ControlSource   = "cursor_4c_Consulta.dscgrp"
5422:             .Column9.ReadOnly        = .T.
5423:         ENDWITH
5424:         BINDEVENT(loc_oPg.grd_4c_Consulta, "AfterRowColChange", THIS, "ConsultaGrd_AfterRowColChange")
5425: 
5426:         *-- Say7/lbl_4c_QtdCpnt: "Qtde Componentes :" (top=523, left=25)
5427:         loc_oPg.AddObject("lbl_4c_QtdCpnt", "Label")
5428:         WITH loc_oPg.lbl_4c_QtdCpnt
5429:             .Caption   = "Qtde Componentes : "
5430:             .Top       = 523
5431:             .Left      = 25
5432:             .Width     = 115
5433:             .Height    = 15
5434:             .FontName  = "Tahoma"
5435:             .FontSize  = 8
5436:             .BackStyle = 0
5437:             .ForeColor = RGB(90, 90, 90)
5438:         ENDWITH
5439: 
5440:         *-- Getqtcpnt/txt_4c_QtdCpnt: quantidade de componentes (top=519, left=131, width=31)
5441:         loc_oPg.AddObject("txt_4c_QtdCpnt", "TextBox")
5442:         WITH loc_oPg.txt_4c_QtdCpnt
5443:             .Top           = 519
5444:             .Left          = 131
5445:             .Width         = 31
5446:             .Height        = 23
5447:             .Value         = 0
5448:             .ReadOnly      = .T.
5449:             .SpecialEffect = 1
5450:             .FontName      = "Tahoma"
5451:             .FontSize      = 8
5452:         ENDWITH
5453: 
5454:         *-- chkFund/chk_4c_ChkFund: "Nao Checar Cadastro de Fundicao" (top=544, left=10)
5455:         loc_oPg.AddObject("chk_4c_ChkFund", "CheckBox")
5456:         WITH loc_oPg.chk_4c_ChkFund
5457:             .Caption  = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
5458:             .Top      = 544
5459:             .Left     = 10
5460:             .Width    = 200
5461:             .Height   = 15
5462:             .FontName = "Tahoma"
5463:             .FontSize = 8
5464:             .Value    = 0

*-- Linhas 5513 a 5556:
5513:     * ConfigurarTabFases - Aba 7: Fases de producao (PgDadosFaseP)
5514:     * IMPLEMENTADO NA FASE 7
5515:     *--------------------------------------------------------------------------
5516:     PROTECTED PROCEDURE ConfigurarTabFases()
5517:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oCtrl, loc_oLbl, loc_oChk
5518:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
5519: 
5520:         *-- Cursor placeholder para GradFase (SigCdPrf)
5521:         *-- ordems N(2,0), grupos C(10), minutos N(9,1), uniprdts C(10), matprdts C(15)
5522:         IF !USED("cursor_4c_Fases")
5523:             SET NULL ON
5524:             CREATE CURSOR cursor_4c_Fases (ordems N(2,0) NULL, grupos C(10) NULL, minutos N(9,1) NULL, uniprdts C(10) NULL, matprdts C(15) NULL)
5525:             SET NULL OFF
5526:         ENDIF
5527: 
5528:         *-- Cursor placeholder para grdMatrizes (SigPrMtz + Locals de SigCdPro)
5529:         IF !USED("cursor_4c_Matrizes")
5530:             SET NULL ON
5531:             CREATE CURSOR cursor_4c_Matrizes (cidchaves C(20) NULL, cmats C(14) NULL, cpros C(14) NULL, qtds N(3,0) NULL, locals C(10) NULL)
5532:             SET NULL OFF
5533:         ENDIF
5534: 
5535:         *======================================================
5536:         *-- LABEL: Say13 - "Qtd. Min. Producao :"
5537:         *======================================================
5538:         loc_oPg.AddObject("lbl_4c_Qmin", "Label")
5539:         WITH loc_oPg.lbl_4c_Qmin
5540:             .Top      = 156
5541:             .Left     = 33
5542:             .Width    = 102
5543:             .Height   = 15
5544:             .Caption  = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
5545:             .AutoSize = .F.
5546:             .FontName = "Tahoma"
5547:             .FontSize = 8
5548:             .Visible  = .T.
5549:         ENDWITH
5550: 
5551:         *======================================================
5552:         *-- TEXTBOX: getQmin - Qtde minima fabricacao
5553:         *======================================================
5554:         loc_oPg.AddObject("txt_4c_Qminfab", "TextBox")
5555:         WITH loc_oPg.txt_4c_Qminfab
5556:             .Top           = 152

*-- Linhas 5989 a 6331:
5989:             .Stretch = 2
5990:             .Visible = .F.
5991:         ENDWITH
5992:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
5993: 
5994:         *======================================================
5995:         *-- BUTTON: cmd_4c_CmdFicha - Imprimir ficha da fase
5996:         *-- top=152, left=482
5997:         *======================================================
5998:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
5999:         WITH loc_oPg.cmd_4c_CmdFicha
6000:             .Caption       = "Ficha"
6001:             .Top           = 152
6002:             .Left          = 482
6003:             .Width         = 38
6004:             .Height        = 23
6005:             .FontName      = "Tahoma"
6006:             .FontSize      = 8
6007:             .Themes        = .F.
6008:             .SpecialEffect = 0
6009:             .BackColor     = RGB(255, 255, 255)
6010:             .ForeColor     = RGB(90, 90, 90)
6011:             .Visible       = .T.
6012:         ENDWITH
6013:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
6014: 
6015:         *======================================================
6016:         *-- BUTTON: cmd_4c_CmdgFigura - Carregar imagem da fase (cmdgFigura)
6017:         *-- top=192, left=482
6018:         *======================================================
6019:         loc_oPg.AddObject("cmd_4c_CmdgFigura", "CommandButton")
6020:         WITH loc_oPg.cmd_4c_CmdgFigura
6021:             .Caption       = "..."
6022:             .Top           = 192
6023:             .Left          = 482
6024:             .Width         = 38
6025:             .Height        = 23
6026:             .FontName      = "Tahoma"
6027:             .FontSize      = 8
6028:             .Themes        = .F.
6029:             .SpecialEffect = 0
6030:             .BackColor     = RGB(255, 255, 255)
6031:             .ForeColor     = RGB(90, 90, 90)
6032:             .Visible       = .T.
6033:         ENDWITH
6034:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
6035: 
6036:         *======================================================
6037:         *-- BUTTON: cmd_4c_CmdgFigCam - Camera para imagem de borracha (cmdgFigCam)
6038:         *-- top=232, left=482
6039:         *======================================================
6040:         loc_oPg.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
6041:         WITH loc_oPg.cmd_4c_CmdgFigCam
6042:             .Caption       = "..."
6043:             .Top           = 232
6044:             .Left          = 482
6045:             .Width         = 38
6046:             .Height        = 23
6047:             .FontName      = "Tahoma"
6048:             .FontSize      = 8
6049:             .Themes        = .F.
6050:             .SpecialEffect = 0
6051:             .BackColor     = RGB(255, 255, 255)
6052:             .ForeColor     = RGB(90, 90, 90)
6053:             .Visible       = .T.
6054:         ENDWITH
6055:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
6056: 
6057:         *======================================================
6058:         *-- BUTTON: cmd_4c_InserirFase - Inserir nova fase (inserir)
6059:         *-- top=152, left=950
6060:         *======================================================
6061:         loc_oPg.AddObject("cmd_4c_InserirFase", "CommandButton")
6062:         WITH loc_oPg.cmd_4c_InserirFase
6063:             .Caption       = "Inserir"
6064:             .Top           = 152
6065:             .Left          = 950
6066:             .Width         = 45
6067:             .Height        = 23
6068:             .FontName      = "Tahoma"
6069:             .FontSize      = 8
6070:             .Themes        = .F.
6071:             .SpecialEffect = 0
6072:             .BackColor     = RGB(255, 255, 255)
6073:             .ForeColor     = RGB(90, 90, 90)
6074:             .Visible       = .T.
6075:         ENDWITH
6076:         BINDEVENT(loc_oPg.cmd_4c_InserirFase, "Click", THIS, "BtnInserirFaseClick")
6077: 
6078:         *======================================================
6079:         *-- BUTTON: cmd_4c_ExcluirFase - Excluir fase (excluir)
6080:         *-- top=192, left=950
6081:         *======================================================
6082:         loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
6083:         WITH loc_oPg.cmd_4c_ExcluirFase
6084:             .Caption       = "Excluir"
6085:             .Top           = 192
6086:             .Left          = 950
6087:             .Width         = 45
6088:             .Height        = 23
6089:             .FontName      = "Tahoma"
6090:             .FontSize      = 8
6091:             .Themes        = .F.
6092:             .SpecialEffect = 0
6093:             .BackColor     = RGB(255, 255, 255)
6094:             .ForeColor     = RGB(90, 90, 90)
6095:             .Visible       = .T.
6096:         ENDWITH
6097:         BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "BtnExcluirFaseClick")
6098: 
6099:         *======================================================
6100:         *-- BUTTON: cmd_4c_Alternativa - Alternativa de fase
6101:         *-- top=232, left=950
6102:         *======================================================
6103:         loc_oPg.AddObject("cmd_4c_Alternativa", "CommandButton")
6104:         WITH loc_oPg.cmd_4c_Alternativa
6105:             .Caption       = "Altern."
6106:             .Top           = 232
6107:             .Left          = 950
6108:             .Width         = 45
6109:             .Height        = 23
6110:             .FontName      = "Tahoma"
6111:             .FontSize      = 8
6112:             .Themes        = .F.
6113:             .SpecialEffect = 0
6114:             .BackColor     = RGB(255, 255, 255)
6115:             .ForeColor     = RGB(90, 90, 90)
6116:             .Visible       = .T.
6117:         ENDWITH
6118:         BINDEVENT(loc_oPg.cmd_4c_Alternativa, "Click", THIS, "BtnAlternativaFaseClick")
6119: 
6120:         *======================================================
6121:         *-- BUTTON: cmd_4c_BtnInsereMtx - Inserir linha na grade de matrizes
6122:         *-- top=380, left=258
6123:         *======================================================
6124:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
6125:         WITH loc_oPg.cmd_4c_BtnInsereMtx
6126:             .Caption       = "+"
6127:             .Top           = 380
6128:             .Left          = 258
6129:             .Width         = 23
6130:             .Height        = 23
6131:             .FontName      = "Tahoma"
6132:             .FontSize      = 10
6133:             .FontBold      = .T.
6134:             .Themes        = .F.
6135:             .SpecialEffect = 0
6136:             .BackColor     = RGB(255, 255, 255)
6137:             .ForeColor     = RGB(90, 90, 90)
6138:             .Visible       = .T.
6139:         ENDWITH
6140:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInserirMatrizClick")
6141: 
6142:         *======================================================
6143:         *-- BUTTON: cmd_4c_BtnExcluiMtz - Excluir linha da grade de matrizes
6144:         *-- top=420, left=258
6145:         *======================================================
6146:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
6147:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
6148:             .Caption       = "-"
6149:             .Top           = 420
6150:             .Left          = 258
6151:             .Width         = 23
6152:             .Height        = 23
6153:             .FontName      = "Tahoma"
6154:             .FontSize      = 10
6155:             .FontBold      = .T.
6156:             .Themes        = .F.
6157:             .SpecialEffect = 0
6158:             .BackColor     = RGB(255, 255, 255)
6159:             .ForeColor     = RGB(90, 90, 90)
6160:             .Visible       = .T.
6161:         ENDWITH
6162:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluirMatrizClick")
6163: 
6164:         *======================================================
6165:         *-- SHAPE: shp_4c_ShpBorracha - Borda ao redor da imagem da borracha
6166:         *-- top=464, left=258, width=236, height=156
6167:         *======================================================
6168:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
6169:         WITH loc_oPg.shp_4c_ShpBorracha
6170:             .Top         = 464
6171:             .Left        = 258
6172:             .Width       = 236
6173:             .Height      = 156
6174:             .BorderColor = RGB(150, 150, 150)
6175:             .BorderWidth = 1
6176:             .FillStyle   = 1
6177:             .Curvature   = 0
6178:             .Visible     = .T.
6179:         ENDWITH
6180: 
6181:         *======================================================
6182:         *-- IMAGE: img_4c_ImgBorracha - Imagem da borracha (molde)
6183:         *-- top=465, left=260, width=232, height=154
6184:         *======================================================
6185:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
6186:         WITH loc_oPg.img_4c_ImgBorracha
6187:             .Top     = 465
6188:             .Left    = 260
6189:             .Width   = 232
6190:             .Height  = 154
6191:             .Stretch = 2
6192:             .Visible = .F.
6193:         ENDWITH
6194: 
6195:         *======================================================
6196:         *-- BINDEVENTs para grids (AfterRowColChange)
6197:         *======================================================
6198:         BINDEVENT(loc_oPg.grd_4c_Fases,    "AfterRowColChange", THIS, "GrdFasesAfterRowColChange")
6199:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
6200: 
6201:         *======================================================
6202:         *-- BINDEVENTs para lookups da aba Fases
6203:         *======================================================
6204:         BINDEVENT(loc_oPg.txt_4c_CodcorsFas,  "KeyPress", THIS, "TabFases_CodcorsKeyPress")
6205:         BINDEVENT(loc_oPg.txt_4c_CodcorsFas,  "LostFocus", THIS, "TabFases_CodcorsLostFocus")
6206:         BINDEVENT(loc_oPg.txt_4c_CodtamsFas,  "KeyPress", THIS, "TabFases_CodtamsKeyPress")
6207:         BINDEVENT(loc_oPg.txt_4c_CodtamsFas,  "LostFocus", THIS, "TabFases_CodtamsLostFocus")
6208:         BINDEVENT(loc_oPg.txt_4c_CodacbsFas,  "KeyPress", THIS, "TabFases_CodacbsKeyPress")
6209:         BINDEVENT(loc_oPg.txt_4c_CodacbsFas,  "LostFocus", THIS, "TabFases_CodacbsLostFocus")
6210:         BINDEVENT(loc_oPg.txt_4c_Conquilhas,  "KeyPress", THIS, "TabFases_ConquilhaKeyPress")
6211:         BINDEVENT(loc_oPg.txt_4c_Conquilhas,  "LostFocus", THIS, "TabFases_ConquilhaLostFocus")
6212:         BINDEVENT(loc_oPg.txt_4c_Codgarras,   "KeyPress", THIS, "TabFases_GarraKeyPress")
6213:         BINDEVENT(loc_oPg.txt_4c_Codgarras,   "LostFocus", THIS, "TabFases_GarraLostFocus")
6214: 
6215:     ENDPROC
6216: 
6217:     *--------------------------------------------------------------------------
6218:     * OptSituasChange - OptionGroup Situacao muda Ativo/Inativo
6219:     *--------------------------------------------------------------------------
6220:     PROCEDURE OptSituasChange()
6221:         LOCAL loc_oPg
6222:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6223:         IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
6224:             IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
6225:                 IF loc_oPg.opt_4c_Situas.Value = 2
6226:                     loc_oPg.txt_4c_DtSituas.Value = DATE()
6227:                 ENDIF
6228:             ENDIF
6229:         ENDIF
6230:     ENDPROC
6231: 
6232:     *--------------------------------------------------------------------------
6233:     * OptProdWebChange - OptionGroup Produto Web muda valor
6234:     *--------------------------------------------------------------------------
6235:     PROCEDURE OptProdWebChange()
6236:         RETURN
6237:     ENDPROC
6238: 
6239:     *--------------------------------------------------------------------------
6240:     * OptVariasChange - OptionGroup Variacao muda valor
6241:     *--------------------------------------------------------------------------
6242:     PROCEDURE OptVariasChange()
6243:         RETURN
6244:     ENDPROC
6245: 
6246:     *--------------------------------------------------------------------------
6247:     * OpcaoAbasChange - Navegacao entre abas pelo OptionGroup
6248:     * Legado: Optiongroup1.InteractiveChange
6249:     *--------------------------------------------------------------------------
6250:     PROCEDURE OpcaoAbasChange()
6251:         LOCAL loc_nAba, loc_lTemProduto
6252:         loc_nAba      = THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value
6253:         loc_lTemProduto = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCpros))
6254: 
6255:         DO CASE
6256:             CASE loc_nAba = 1   && Principal
6257:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
6258:             CASE loc_nAba = 2   && Composicao
6259:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 2
6260:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6261:                     THIS.CarregarComposicao()
6262:                 ENDIF
6263:             CASE loc_nAba = 3   && Custos
6264:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 3
6265:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6266:                     THIS.CarregarCustos()
6267:                 ENDIF
6268:             CASE loc_nAba = 4   && Dados Fiscais
6269:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 4
6270:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6271:                     THIS.CarregarDadosFiscais()
6272:                 ENDIF
6273:             CASE loc_nAba = 5   && Designer
6274:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 5
6275:             CASE loc_nAba = 6   && Consulta P.
6276:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 6
6277:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6278:                     THIS.CarregarConsultaP()
6279:                 ENDIF
6280:             CASE loc_nAba = 7   && Fases
6281:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 7
6282:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6283:                     THIS.CarregarFases()
6284:                 ENDIF
6285:         ENDCASE
6286:     ENDPROC
6287: 
6288:     *--------------------------------------------------------------------------
6289:     * CarregarLista - Busca e exibe lista de produtos no grid
6290:     *--------------------------------------------------------------------------
6291:     PROCEDURE CarregarLista()
6292:         LOCAL loc_oGrid, loc_lResultado, loc_cFiltro, loc_cWhere
6293:         LOCAL loc_cCgru, loc_dIni, loc_dFim, loc_nSit
6294:         loc_lResultado = .F.
6295: 
6296:         TRY
6297:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
6298: 
6299:             *-- Montar filtro a partir dos controles
6300:             loc_cWhere = ""
6301:             loc_cFiltro = ""
6302: 
6303:             *-- Filtro grupo
6304:             loc_cCgru = ""
6305:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
6306:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru, "Value", 5)
6307:                     loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
6308:                 ENDIF
6309:             ENDIF
6310: 
6311:             IF !EMPTY(loc_cCgru)
6312:                 loc_cFiltro = "p.cgrus = " + EscaparSQL(loc_cCgru)
6313:             ENDIF
6314: 
6315:             *-- Filtro situacao
6316:             loc_nSit = 1
6317:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
6318:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas, "Value", 5)
6319:                     loc_nSit = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas.Value
6320:                 ENDIF
6321:             ENDIF
6322: 
6323:             IF loc_nSit = 2   && Apenas ativos (situas=1)
6324:                 IF !EMPTY(loc_cFiltro)
6325:                     loc_cFiltro = loc_cFiltro + " AND p.situas = 1"
6326:                 ELSE
6327:                     loc_cFiltro = "p.situas = 1"
6328:                 ENDIF
6329:             ENDIF
6330:             IF loc_nSit = 3   && Apenas inativos (situas=2)
6331:                 IF !EMPTY(loc_cFiltro)

*-- Linhas 6404 a 6447:
6404:     * FormParaBO - Transfere dados do formulario para o Business Object
6405:     * Todos os campos editaveis da aba Principal
6406:     *--------------------------------------------------------------------------
6407:     PROTECTED PROCEDURE FormParaBO()
6408:         LOCAL loc_oBO, loc_oPg
6409:         loc_oBO = THIS.this_oBusinessObject
6410:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6411: 
6412:         *-- Identificacao
6413:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
6414:             loc_oBO.this_cCpros  = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
6415:         ENDIF
6416:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
6417:             loc_oBO.this_cDpros  = ALLTRIM(loc_oPg.txt_4c_Dpros.Value)
6418:         ENDIF
6419:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
6420:             loc_oBO.this_cDpro2s = ALLTRIM(loc_oPg.txt_4c_Dpro2s.Value)
6421:         ENDIF
6422: 
6423:         *-- Grupo / Subgrupo
6424:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
6425:             loc_oBO.this_cCgrus  = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
6426:         ENDIF
6427:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
6428:             loc_oBO.this_cSgrus  = ALLTRIM(loc_oPg.txt_4c_Csgrus.Value)
6429:         ENDIF
6430: 
6431:         *-- Linha / Colecao / Fornecedor / Referencia
6432:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
6433:             loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
6434:         ENDIF
6435:         IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
6436:             loc_oBO.this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
6437:         ENDIF
6438:         IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
6439:             loc_oBO.this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
6440:         ENDIF
6441:         IF PEMSTATUS(loc_oPg, "txt_4c_Reffs", 5)
6442:             loc_oBO.this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Reffs.Value)
6443:         ENDIF
6444: 
6445:         *-- Tipo / Identificador / Conjunto / Equivalente
6446:         IF PEMSTATUS(loc_oPg, "txt_4c_Mercs", 5)
6447:             loc_oBO.this_cMercs    = ALLTRIM(loc_oPg.txt_4c_Mercs.Value)

*-- Linhas 6464 a 6507:
6464:             loc_oBO.this_nEan13 = loc_oPg.txt_4c_Ean13.Value
6465:         ENDIF
6466: 
6467:         *-- Situacao (OptionGroup Value=1=Ativo, Value=2=Inativo -> nSituas)
6468:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
6469:             loc_oBO.this_nSituas = loc_oPg.opt_4c_Situas.Value
6470:         ENDIF
6471: 
6472:         *-- Lote Minimo / Qtde
6473:         IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
6474:             loc_oBO.this_nLtminsv = loc_oPg.txt_4c_Ltminsv.Value
6475:         ENDIF
6476:         IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
6477:             loc_oBO.this_nQmins   = loc_oPg.txt_4c_Qmins.Value
6478:         ENDIF
6479:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
6480:             loc_oBO.this_nQtped   = loc_oPg.txt_4c_Qtped.Value
6481:         ENDIF
6482: 
6483:         *-- Observacoes curtas
6484:         IF PEMSTATUS(loc_oPg, "txt_4c_Obsetqs", 5)
6485:             loc_oBO.this_cObsetqs = ALLTRIM(loc_oPg.txt_4c_Obsetqs.Value)
6486:         ENDIF
6487:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspeds", 5)
6488:             loc_oBO.this_cObspeds = ALLTRIM(loc_oPg.txt_4c_Obspeds.Value)
6489:         ENDIF
6490:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspes", 5)
6491:             loc_oBO.this_cObspes  = ALLTRIM(loc_oPg.txt_4c_Obspes.Value)
6492:         ENDIF
6493: 
6494:         *-- Custo / Moeda custo
6495:         IF PEMSTATUS(loc_oPg, "txt_4c_Custofs", 5)
6496:             loc_oBO.this_nCustofs = loc_oPg.txt_4c_Custofs.Value
6497:         ENDIF
6498:         IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
6499:             loc_oBO.this_cMoecs   = ALLTRIM(loc_oPg.txt_4c_Moecs.Value)
6500:         ENDIF
6501: 
6502:         *-- Preco / Moeda preco
6503:         IF PEMSTATUS(loc_oPg, "txt_4c_Pvens", 5)
6504:             loc_oBO.this_nPvens   = loc_oPg.txt_4c_Pvens.Value
6505:         ENDIF
6506:         IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
6507:             loc_oBO.this_cMoepvs  = ALLTRIM(loc_oPg.txt_4c_Moepvs.Value)

*-- Linhas 6712 a 6755:
6712:     * BOParaForm - Transfere dados do Business Object para o formulario
6713:     * Inclui carga de descricoes de campos lookup via SQL
6714:     *--------------------------------------------------------------------------
6715:     PROTECTED PROCEDURE BOParaForm()
6716:         LOCAL loc_oBO, loc_oPg
6717:         loc_oBO = THIS.this_oBusinessObject
6718:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6719: 
6720:         *-- Identificacao
6721:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
6722:             loc_oPg.txt_4c_Cpros.Value  = loc_oBO.this_cCpros
6723:         ENDIF
6724:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
6725:             loc_oPg.txt_4c_Dpros.Value  = loc_oBO.this_cDpros
6726:         ENDIF
6727:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
6728:             loc_oPg.txt_4c_Dpro2s.Value = loc_oBO.this_cDpro2s
6729:         ENDIF
6730: 
6731:         *-- Grupo + descricao
6732:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
6733:             loc_oPg.txt_4c_Cgrus.Value = loc_oBO.this_cCgrus
6734:         ENDIF
6735:         IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
6736:             loc_oPg.txt_4c_Dgrus.Value = THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus")
6737:         ENDIF
6738: 
6739:         *-- Subgrupo + descricao
6740:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
6741:             loc_oPg.txt_4c_Csgrus.Value = loc_oBO.this_cSgrus
6742:         ENDIF
6743:         IF PEMSTATUS(loc_oPg, "txt_4c_Dsgrus", 5)
6744:             loc_oPg.txt_4c_Dsgrus.Value = THIS.CarregarDescSgru(loc_oBO.this_cCgrus, loc_oBO.this_cSgrus)
6745:         ENDIF
6746: 
6747:         *-- Linha + descricao
6748:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
6749:             loc_oPg.txt_4c_Linhas.Value  = loc_oBO.this_cLinhas
6750:         ENDIF
6751:         IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
6752:             loc_oPg.txt_4c_Dlinhas.Value = THIS.CarregarDesc("SigCdLin", "Linhas", loc_oBO.this_cLinhas, "Descs")
6753:         ENDIF
6754: 
6755:         *-- Colecao + descricao

*-- Linhas 6795 a 6838:
6795:             loc_oPg.txt_4c_Ean13.Value = loc_oBO.this_nEan13
6796:         ENDIF
6797: 
6798:         *-- Situacao (nSituas 1=Ativo, 2=Inativo -> OptionGroup.Value)
6799:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
6800:             loc_oPg.opt_4c_Situas.Value = IIF(loc_oBO.this_nSituas >= 1, loc_oBO.this_nSituas, 1)
6801:         ENDIF
6802:         IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
6803:             loc_oPg.txt_4c_DtSituas.Value = NVL(loc_oBO.this_dDtsituas, {})
6804:         ENDIF
6805: 
6806:         *-- Lote Minimo / Qtde
6807:         IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
6808:             loc_oPg.txt_4c_Ltminsv.Value = loc_oBO.this_nLtminsv
6809:         ENDIF
6810:         IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
6811:             loc_oPg.txt_4c_Qmins.Value   = loc_oBO.this_nQmins
6812:         ENDIF
6813:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
6814:             loc_oPg.txt_4c_Qtped.Value   = loc_oBO.this_nQtped
6815:         ENDIF
6816: 
6817:         *-- Observacoes curtas
6818:         IF PEMSTATUS(loc_oPg, "txt_4c_Obsetqs", 5)
6819:             loc_oPg.txt_4c_Obsetqs.Value = loc_oBO.this_cObsetqs
6820:         ENDIF
6821:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspeds", 5)
6822:             loc_oPg.txt_4c_Obspeds.Value = loc_oBO.this_cObspeds
6823:         ENDIF
6824:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspes", 5)
6825:             loc_oPg.txt_4c_Obspes.Value  = loc_oBO.this_cObspes
6826:         ENDIF
6827: 
6828:         *-- Ultima Compra (ReadOnly)
6829:         IF PEMSTATUS(loc_oPg, "txt_4c_Dtucp", 5)
6830:             loc_oPg.txt_4c_Dtucp.Value      = NVL(loc_oBO.this_dUltcomps, {})
6831:         ENDIF
6832:         IF PEMSTATUS(loc_oPg, "txt_4c_Vucp", 5)
6833:             loc_oPg.txt_4c_Vucp.Value       = loc_oBO.this_nVultcomps
6834:         ENDIF
6835:         IF PEMSTATUS(loc_oPg, "txt_4c_Mucp", 5)
6836:             loc_oPg.txt_4c_Mucp.Value       = loc_oBO.this_cMultcomps
6837:         ENDIF
6838:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtdultcomp", 5)

*-- Linhas 7192 a 7235:
7192:     *--------------------------------------------------------------------------
7193:     * LimparCampos - Limpa todos os campos do formulario (aba Principal)
7194:     *--------------------------------------------------------------------------
7195:     PROTECTED PROCEDURE LimparCampos()
7196:         LOCAL loc_oPg
7197:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7198: 
7199:         *-- Identificacao
7200:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
7201:             loc_oPg.txt_4c_Cpros.Value  = ""
7202:         ENDIF
7203:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
7204:             loc_oPg.txt_4c_Dpros.Value  = ""
7205:         ENDIF
7206:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
7207:             loc_oPg.txt_4c_Dpro2s.Value = ""
7208:         ENDIF
7209: 
7210:         *-- Grupo / Subgrupo
7211:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
7212:             loc_oPg.txt_4c_Cgrus.Value  = ""
7213:         ENDIF
7214:         IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
7215:             loc_oPg.txt_4c_Dgrus.Value  = ""
7216:         ENDIF
7217:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
7218:             loc_oPg.txt_4c_Csgrus.Value = ""
7219:         ENDIF
7220:         IF PEMSTATUS(loc_oPg, "txt_4c_Dsgrus", 5)
7221:             loc_oPg.txt_4c_Dsgrus.Value = ""
7222:         ENDIF
7223: 
7224:         *-- Linha / Colecao / Fornecedor / Ref
7225:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
7226:             loc_oPg.txt_4c_Linhas.Value    = ""
7227:         ENDIF
7228:         IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
7229:             loc_oPg.txt_4c_Dlinhas.Value   = ""
7230:         ENDIF
7231:         IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
7232:             loc_oPg.txt_4c_Colecoes.Value  = ""
7233:         ENDIF
7234:         IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
7235:             loc_oPg.txt_4c_Dcolecoes.Value = ""

*-- Linhas 7699 a 7742:
7699:     * HabilitarCampos - Habilita/desabilita campos conforme modo de edicao
7700:     * par_lHabilitar: .T. = edicao/inclusao, .F. = visualizacao
7701:     *--------------------------------------------------------------------------
7702:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
7703:         LOCAL loc_oPg, loc_lNovoReg
7704:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7705:         loc_lNovoReg = (THIS.this_cModoAtual = "INCLUIR")
7706: 
7707:         *-- Codigo: editavel SOMENTE na inclusao (PK nao se altera)
7708:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
7709:             loc_oPg.txt_4c_Cpros.ReadOnly = !loc_lNovoReg
7710:         ENDIF
7711: 
7712:         *-- Campos texto editaveis
7713:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
7714:             loc_oPg.txt_4c_Dpros.ReadOnly    = !par_lHabilitar
7715:         ENDIF
7716:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
7717:             loc_oPg.txt_4c_Dpro2s.ReadOnly   = !par_lHabilitar
7718:         ENDIF
7719:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
7720:             loc_oPg.txt_4c_Cgrus.ReadOnly    = !par_lHabilitar
7721:         ENDIF
7722:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
7723:             loc_oPg.txt_4c_Csgrus.ReadOnly   = !par_lHabilitar
7724:         ENDIF
7725:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
7726:             loc_oPg.txt_4c_Linhas.ReadOnly   = !par_lHabilitar
7727:         ENDIF
7728:         IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
7729:             loc_oPg.txt_4c_Colecoes.ReadOnly = !par_lHabilitar
7730:         ENDIF
7731:         IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
7732:             loc_oPg.txt_4c_Ifors.ReadOnly    = !par_lHabilitar
7733:         ENDIF
7734:         IF PEMSTATUS(loc_oPg, "txt_4c_Reffs", 5)
7735:             loc_oPg.txt_4c_Reffs.ReadOnly    = !par_lHabilitar
7736:         ENDIF
7737:         IF PEMSTATUS(loc_oPg, "txt_4c_Mercs", 5)
7738:             loc_oPg.txt_4c_Mercs.ReadOnly    = !par_lHabilitar
7739:         ENDIF
7740:         IF PEMSTATUS(loc_oPg, "txt_4c_Idecpros", 5)
7741:             loc_oPg.txt_4c_Idecpros.ReadOnly  = !par_lHabilitar
7742:         ENDIF

*-- Linhas 7855 a 7898:
7855:             loc_oPg.txt_4c_Volumes.ReadOnly   = !par_lHabilitar
7856:         ENDIF
7857: 
7858:         *-- OptionGroups e CheckBoxes: Enabled
7859:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
7860:             loc_oPg.opt_4c_Situas.Enabled     = par_lHabilitar
7861:         ENDIF
7862:         IF PEMSTATUS(loc_oPg, "opt_4c_ProdWeb", 5)
7863:             loc_oPg.opt_4c_ProdWeb.Enabled    = par_lHabilitar
7864:         ENDIF
7865:         IF PEMSTATUS(loc_oPg, "opt_4c_Varias", 5)
7866:             loc_oPg.opt_4c_Varias.Enabled     = par_lHabilitar
7867:         ENDIF
7868:         IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
7869:             loc_oPg.chk_4c_Chkgarvit.Enabled  = par_lHabilitar
7870:         ENDIF
7871:         IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
7872:             loc_oPg.chk_4c_Consigs.Enabled    = par_lHabilitar
7873:         ENDIF
7874:         IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
7875:             loc_oPg.chk_4c_Fabrproprs.Enabled = par_lHabilitar
7876:         ENDIF
7877:         IF PEMSTATUS(loc_oPg, "chk_4c_Encoms", 5)
7878:             loc_oPg.chk_4c_Encoms.Enabled     = par_lHabilitar
7879:         ENDIF
7880: 
7881:         *-- EditBoxes (Memo)
7882:         IF PEMSTATUS(loc_oPg, "edt_4c_Dsccompras", 5)
7883:             loc_oPg.edt_4c_Dsccompras.ReadOnly = !par_lHabilitar
7884:         ENDIF
7885:         IF PEMSTATUS(loc_oPg, "edt_4c_Dpro3s", 5)
7886:             loc_oPg.edt_4c_Dpro3s.ReadOnly     = !par_lHabilitar
7887:         ENDIF
7888:         IF PEMSTATUS(loc_oPg, "edt_4c_Obscompras", 5)
7889:             loc_oPg.edt_4c_Obscompras.ReadOnly  = !par_lHabilitar
7890:         ENDIF
7891: 
7892:         *-- Tab 7: Fases - campos e botoes de operacao
7893:         LOCAL loc_oPg7
7894:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
7895: 
7896:         IF PEMSTATUS(loc_oPg7, "txt_4c_Qminfab", 5)
7897:             loc_oPg7.txt_4c_Qminfab.ReadOnly   = !par_lHabilitar
7898:         ENDIF

*-- Linhas 7960 a 9253:
7960:     *--------------------------------------------------------------------------
7961:     * BtnIncluirClick - Incluir novo produto
7962:     *--------------------------------------------------------------------------
7963:     PROCEDURE BtnIncluirClick()
7964:         THIS.this_oBusinessObject.NovoRegistro()
7965:         THIS.LimparCampos()
7966:         THIS.this_cModoAtual = "INCLUIR"
7967:         THIS.HabilitarCampos(.T.)
7968:         THIS.AjustarBotoesPorModo()
7969:         THIS.AlternarPagina(2)
7970:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
7971:         THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
7972:     ENDPROC
7973: 
7974:     *--------------------------------------------------------------------------
7975:     * BtnVisualizarClick - Visualizar produto selecionado
7976:     *--------------------------------------------------------------------------
7977:     PROCEDURE BtnVisualizarClick()
7978:         LOCAL loc_cCodigo
7979: 
7980:         IF !USED("cursor_4c_Dados")
7981:             MsgAviso("Nenhum produto selecionado!")
7982:             RETURN
7983:         ENDIF
7984:         IF RECCOUNT("cursor_4c_Dados") = 0
7985:             MsgAviso("Nenhum produto selecionado!")
7986:             RETURN
7987:         ENDIF
7988: 
7989:         SELECT cursor_4c_Dados
7990:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
7991: 
7992:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
7993:             THIS.BOParaForm()
7994:             THIS.this_cModoAtual = "VISUALIZAR"
7995:             THIS.HabilitarCampos(.F.)
7996:             THIS.AjustarBotoesPorModo()
7997:             THIS.AlternarPagina(2)
7998:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
7999:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8000:         ENDIF
8001:     ENDPROC
8002: 
8003:     *--------------------------------------------------------------------------
8004:     * BtnAlterarClick - Alterar produto selecionado
8005:     *--------------------------------------------------------------------------
8006:     PROCEDURE BtnAlterarClick()
8007:         LOCAL loc_cCodigo
8008: 
8009:         IF !USED("cursor_4c_Dados")
8010:             MsgAviso("Nenhum produto selecionado!")
8011:             RETURN
8012:         ENDIF
8013:         IF RECCOUNT("cursor_4c_Dados") = 0
8014:             MsgAviso("Nenhum produto selecionado!")
8015:             RETURN
8016:         ENDIF
8017: 
8018:         SELECT cursor_4c_Dados
8019:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8020: 
8021:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8022:             THIS.this_oBusinessObject.EditarRegistro()
8023:             THIS.BOParaForm()
8024:             THIS.this_cModoAtual = "ALTERAR"
8025:             THIS.HabilitarCampos(.T.)
8026:             THIS.AjustarBotoesPorModo()
8027:             THIS.AlternarPagina(2)
8028:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8029:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8030:         ENDIF
8031:     ENDPROC
8032: 
8033:     *--------------------------------------------------------------------------
8034:     * BtnExcluirClick - Excluir produto selecionado
8035:     * Legado: verifica se produto e usado em pedidos/fichas tecnicas
8036:     *--------------------------------------------------------------------------
8037:     PROCEDURE BtnExcluirClick()
8038:         LOCAL loc_cCodigo, loc_cSQL, loc_nResultado
8039: 
8040:         IF !USED("cursor_4c_Dados")
8041:             MsgAviso("Nenhum produto selecionado!")
8042:             RETURN
8043:         ENDIF
8044:         IF RECCOUNT("cursor_4c_Dados") = 0
8045:             MsgAviso("Nenhum produto selecionado!")
8046:             RETURN
8047:         ENDIF
8048: 
8049:         SELECT cursor_4c_Dados
8050:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8051: 
8052:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8053: 
8054:             *-- Verificar uso em itens de pedido (SigMvCIte)
8055:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8056:                 SELECT COUNT(*) AS nExiste
8057:                 FROM SigMvCIte
8058:                 WHERE cpros = <<EscaparSQL(loc_cCodigo)>>
8059:             ENDTEXT
8060: 
8061:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerPro")
8062: 
8063:             IF loc_nResultado < 0
8064:                 MsgErro("Falha ao verificar uso do produto!")
8065:                 IF USED("cursor_4c_VerPro")
8066:                     USE IN cursor_4c_VerPro
8067:                 ENDIF
8068:                 RETURN
8069:             ENDIF
8070: 
8071:             IF NVL(cursor_4c_VerPro.nExiste, 0) > 0
8072:                 MsgAviso("Produto em uso em pedidos - n" + CHR(227) + "o pode ser exclu" + CHR(237) + "do!")
8073:                 IF USED("cursor_4c_VerPro")
8074:                     USE IN cursor_4c_VerPro
8075:                 ENDIF
8076:                 RETURN
8077:             ENDIF
8078: 
8079:             IF USED("cursor_4c_VerPro")
8080:                 USE IN cursor_4c_VerPro
8081:             ENDIF
8082: 
8083:             IF MsgConfirma("Confirma exclus" + CHR(227) + "o do produto '" + loc_cCodigo + "'?")
8084:                 IF THIS.this_oBusinessObject.Excluir()
8085:                     MsgSucesso("Produto exclu" + CHR(237) + "do com sucesso!")
8086:                     THIS.CarregarLista()
8087:                 ENDIF
8088:             ENDIF
8089:         ENDIF
8090:     ENDPROC
8091: 
8092:     *--------------------------------------------------------------------------
8093:     * BtnSalvarClick - Salvar produto
8094:     *--------------------------------------------------------------------------
8095:     PROCEDURE BtnSalvarClick()
8096:         LOCAL loc_oPg, loc_cCodNovo, loc_cSQLDup, loc_nDup
8097: 
8098:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8099: 
8100:         *-- Validacao: codigo obrigatorio
8101:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8102:             IF EMPTY(loc_oPg.txt_4c_Cpros.Value)
8103:                 MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o pode ficar em branco!")
8104:                 IF PEMSTATUS(loc_oPg.txt_4c_Cpros, "SetFocus", 5)
8105:                     loc_oPg.txt_4c_Cpros.SetFocus()
8106:                 ENDIF
8107:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8108:                 THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8109:                 RETURN
8110:             ENDIF
8111:         ENDIF
8112: 
8113:         *-- Validacao: codigo duplicado (apenas no modo INCLUIR)
8114:         IF THIS.this_cModoAtual = "INCLUIR"
8115:             IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8116:                 loc_cCodNovo = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
8117: 
8118:                 TEXT TO loc_cSQLDup TEXTMERGE NOSHOW
8119:                     SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = <<EscaparSQL(loc_cCodNovo)>>
8120:                 ENDTEXT
8121: 
8122:                 loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupPro")
8123: 
8124:                 IF loc_nDup >= 0 AND NVL(cursor_4c_DupPro.nExiste, 0) > 0
8125:                     IF USED("cursor_4c_DupPro")
8126:                         USE IN cursor_4c_DupPro
8127:                     ENDIF
8128:                     MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
8129:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8130:                         loc_oPg.txt_4c_Cpros.SetFocus()
8131:                     ENDIF
8132:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8133:                     THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8134:                     RETURN
8135:                 ENDIF
8136: 
8137:                 IF USED("cursor_4c_DupPro")
8138:                     USE IN cursor_4c_DupPro
8139:                 ENDIF
8140:             ENDIF
8141:         ENDIF
8142: 
8143:         THIS.FormParaBO()
8144: 
8145:         IF THIS.this_oBusinessObject.Salvar()
8146:             MsgSucesso("Produto salvo com sucesso!")
8147:             THIS.AlternarPagina(1)
8148:             THIS.CarregarLista()
8149:         ENDIF
8150:     ENDPROC
8151: 
8152:     *--------------------------------------------------------------------------
8153:     * BtnCancelarClick - Cancelar edicao
8154:     *--------------------------------------------------------------------------
8155:     PROCEDURE BtnCancelarClick()
8156:         THIS.this_cModoAtual = "LISTA"
8157:         THIS.AlternarPagina(1)
8158:         THIS.CarregarLista()
8159:     ENDPROC
8160: 
8161:     *--------------------------------------------------------------------------
8162:     * BtnBuscarClick - Abre FormBuscaAuxiliar para busca de produtos
8163:     *--------------------------------------------------------------------------
8164:     PROCEDURE BtnBuscarClick()
8165:         LOCAL loc_oBusca, loc_cCodigo
8166: 
8167:         TRY
8168:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Buscar Produto")
8169: 
8170:             loc_oBusca.mAddColuna("cpros", "", "Produto")
8171:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8172:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
8173: 
8174:             loc_oBusca.Show()
8175: 
8176:             IF loc_oBusca.this_lSelecionou
8177:                 IF USED("cursor_4c_Busca")
8178:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
8179: 
8180:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8181:                         THIS.BOParaForm()
8182:                         THIS.this_cModoAtual = "VISUALIZAR"
8183:                         THIS.HabilitarCampos(.F.)
8184:                         THIS.AjustarBotoesPorModo()
8185:                         THIS.AlternarPagina(2)
8186:                         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8187:                         THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8188:                     ENDIF
8189:                 ENDIF
8190:             ENDIF
8191: 
8192:             IF USED("cursor_4c_Busca")
8193:                 USE IN cursor_4c_Busca
8194:             ENDIF
8195:             loc_oBusca.Release()
8196: 
8197:         CATCH TO loc_oErro
8198:             MsgErro("Erro ao buscar produto:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "FormProduto.BtnBuscarClick")
8199:         ENDTRY
8200:     ENDPROC
8201: 
8202:     *--------------------------------------------------------------------------
8203:     * BtnEncerrarClick - Fechar formulario
8204:     *--------------------------------------------------------------------------
8205:     PROCEDURE BtnEncerrarClick()
8206:         THIS.Release()
8207:     ENDPROC
8208: 
8209:     *--------------------------------------------------------------------------
8210:     * BtnPesquisarClick - Recarregar lista com filtros aplicados
8211:     *--------------------------------------------------------------------------
8212:     PROCEDURE BtnPesquisarClick()
8213:         THIS.CarregarLista()
8214:     ENDPROC
8215: 
8216:     *--------------------------------------------------------------------------
8217:     * GrdLista_DblClick - Duplo clique na grade abre visualizacao
8218:     *--------------------------------------------------------------------------
8219:     PROCEDURE GrdLista_DblClick()
8220:         THIS.BtnVisualizarClick()
8221:     ENDPROC
8222: 
8223:     *--------------------------------------------------------------------------
8224:     * FiltroGrupo_KeyPress - F4 no filtro de grupo abre lookup de grupos
8225:     *--------------------------------------------------------------------------
8226:     PROCEDURE FiltroGrupo_KeyPress
8227:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8228:         IF par_nKeyCode = 115    && F4=115 (VFP9)
8229:             THIS.AbrirLookupFiltroGrupo()
8230:         ENDIF
8231:     ENDPROC
8232: 
8233:     *--------------------------------------------------------------------------
8234:     * ValidarFiltroGrupo - LostFocus no filtro de grupo
8235:     *--------------------------------------------------------------------------
8236:     PROCEDURE ValidarFiltroGrupo()
8237:         LOCAL loc_cCgru, loc_cSQL, loc_nRes, loc_oBusca
8238:         loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
8239: 
8240:         IF loc_cCgru == THIS.this_cUltFiltroGru
8241:             RETURN
8242:         ENDIF
8243:         THIS.this_cUltFiltroGru = loc_cCgru
8244: 
8245:         IF EMPTY(loc_cCgru)
8246:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ""
8247:             RETURN
8248:         ENDIF
8249: 
8250:         TRY
8251:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8252:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCgru)>>
8253:             ENDTEXT
8254: 
8255:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerGru")
8256: 
8257:             IF loc_nRes > 0 AND !EOF("cursor_4c_VerGru")
8258:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_VerGru.dgrus)
8259:             ELSE
8260:                 *-- Codigo nao encontrado: abrir lookup
8261:                 THIS.AbrirLookupFiltroGrupo()
8262:             ENDIF
8263: 
8264:             IF USED("cursor_4c_VerGru")
8265:                 USE IN cursor_4c_VerGru
8266:             ENDIF
8267:         CATCH TO loc_oErro
8268:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarFiltroGrupo")
8269:         ENDTRY
8270:     ENDPROC
8271: 
8272:     *--------------------------------------------------------------------------
8273:     * AbrirLookupFiltroGrupo - Lookup F4 no filtro de grupo
8274:     *--------------------------------------------------------------------------
8275:     PROTECTED PROCEDURE AbrirLookupFiltroGrupo()
8276:         LOCAL loc_oBusca, loc_cValor
8277:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
8278: 
8279:         TRY
8280:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Gru", "cgrus", loc_cValor, "Selecionar Grupo")
8281:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
8282:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
8283:             loc_oBusca.Show()
8284: 
8285:             IF loc_oBusca.this_lSelecionou
8286:                 IF USED("cursor_4c_Gru")
8287:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value = ALLTRIM(cursor_4c_Gru.cgrus)
8288:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_Gru.dgrus)
8289:                 ENDIF
8290:             ELSE
8291:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value = ""
8292:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ""
8293:             ENDIF
8294: 
8295:             IF USED("cursor_4c_Gru")
8296:                 USE IN cursor_4c_Gru
8297:             ENDIF
8298:             loc_oBusca.Release()
8299:         CATCH TO loc_oErro
8300:             MsgErro("Erro no lookup de grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupFiltroGrupo")
8301:         ENDTRY
8302:     ENDPROC
8303: 
8304:     *--------------------------------------------------------------------------
8305:     * FiltroSituas_InteractiveChange - Mudar filtro de situacao
8306:     *--------------------------------------------------------------------------
8307:     PROCEDURE FiltroSituas_InteractiveChange()
8308:         THIS.CarregarLista()
8309:     ENDPROC
8310: 
8311:     *--------------------------------------------------------------------------
8312:     * FormatarGridLista - Formata visual do grid da lista
8313:     *--------------------------------------------------------------------------
8314:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
8315:         WITH par_oGrid
8316:             IF .ColumnCount > 0
8317:                 .FontName = "Tahoma"
8318:                 .FontSize = 8
8319:             ENDIF
8320:         ENDWITH
8321:     ENDPROC
8322: 
8323:     *--------------------------------------------------------------------------
8324:     * TornarControlesVisiveis - Torna todos os controles visiveis
8325:     * Filtra por nome para evitar tornar containers flutuantes visiveis
8326:     *--------------------------------------------------------------------------
8327:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
8328:         LOCAL loc_nI, loc_oObjeto, loc_cNome
8329: 
8330:         FOR loc_nI = 1 TO par_oContainer.ControlCount
8331:             loc_oObjeto = par_oContainer.Controls(loc_nI)
8332: 
8333:             IF VARTYPE(loc_oObjeto) = "O"
8334:                 loc_cNome = LOWER(loc_oObjeto.Name)
8335: 
8336:                 *-- Nao tornar visiveis containers flutuantes (Visible=.F. por design)
8337:                 IF INLIST(loc_cNome, "cntmensagem", "cntacabado", "cnt_4c_cabecalho")
8338:                     LOOP
8339:                 ENDIF
8340: 
8341:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
8342:                     loc_oObjeto.Visible = .T.
8343:                 ENDIF
8344: 
8345:                 *-- Trata PageFrame - itera Pages
8346:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
8347:                     LOCAL loc_nP
8348:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
8349:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
8350:                     ENDFOR
8351:                 ENDIF
8352: 
8353:                 *-- Trata containers com ControlCount
8354:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
8355:                     THIS.TornarControlesVisiveis(loc_oObjeto)
8356:                 ENDIF
8357:             ENDIF
8358:         ENDFOR
8359:     ENDPROC
8360: 
8361:     *--------------------------------------------------------------------------
8362:     * Destroy - Limpar recursos ao fechar
8363:     *--------------------------------------------------------------------------
8364:     PROCEDURE Destroy()
8365:         IF USED("cursor_4c_Dados")
8366:             USE IN cursor_4c_Dados
8367:         ENDIF
8368:         IF USED("cursor_4c_Busca")
8369:             USE IN cursor_4c_Busca
8370:         ENDIF
8371:         IF USED("cursor_4c_Registro")
8372:             USE IN cursor_4c_Registro
8373:         ENDIF
8374: 
8375:         IF !ISNULL(THIS.this_oBusinessObject)
8376:             THIS.this_oBusinessObject = .NULL.
8377:         ENDIF
8378: 
8379:         DODEFAULT()
8380:     ENDPROC
8381: 
8382:     *==========================================================================
8383:     * === METODOS PUBLICOS DE LOOKUP / VALIDACAO (Tab Principal) ==============
8384:     * BINDEVENT requer metodos PUBLIC
8385:     *==========================================================================
8386: 
8387:     *--------------------------------------------------------------------------
8388:     * TabPrincipal_CgruKeyPress - F4 no campo Grupo abre lookup
8389:     *--------------------------------------------------------------------------
8390:     PROCEDURE TabPrincipal_CgruKeyPress
8391:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8392:         IF par_nKeyCode = 115    && F4=115 em VFP9
8393:             THIS.AbrirLookupGrupo()
8394:         ENDIF
8395:     ENDPROC
8396: 
8397:     *--------------------------------------------------------------------------
8398:     * TabPrincipal_CgruLostFocus - LostFocus valida e carrega descricao do grupo
8399:     *--------------------------------------------------------------------------
8400:     PROCEDURE TabPrincipal_CgruLostFocus()
8401:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8402:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8403:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
8404:             RETURN
8405:         ENDIF
8406:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
8407: 
8408:         IF loc_cCod == THIS.this_cUltCgrus
8409:             RETURN
8410:         ENDIF
8411:         THIS.this_cUltCgrus = loc_cCod
8412: 
8413:         IF EMPTY(loc_cCod)
8414:             IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8415:                 loc_oPg.txt_4c_Dgrus.Value = ""
8416:             ENDIF
8417:             RETURN
8418:         ENDIF
8419: 
8420:         TRY
8421:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8422:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCod)>>
8423:             ENDTEXT
8424:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGrp")
8425:             IF loc_nR > 0 AND !EOF("cursor_4c_VGrp")
8426:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8427:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_VGrp.dgrus)
8428:                 ENDIF
8429:             ELSE
8430:                 THIS.AbrirLookupGrupo()
8431:             ENDIF
8432:             IF USED("cursor_4c_VGrp")
8433:                 USE IN cursor_4c_VGrp
8434:             ENDIF
8435:         CATCH TO loc_oErro
8436:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CgruLostFocus")
8437:         ENDTRY
8438:     ENDPROC
8439: 
8440:     *--------------------------------------------------------------------------
8441:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para selecionar grupo de produto
8442:     *--------------------------------------------------------------------------
8443:     PROTECTED PROCEDURE AbrirLookupGrupo()
8444:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8445:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8446:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5), ALLTRIM(loc_oPg.txt_4c_Cgrus.Value), "")
8447: 
8448:         TRY
8449:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Grp", "cgrus", loc_cVal, "Selecionar Grupo")
8450:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
8451:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
8452:             loc_oBusca.Show()
8453: 
8454:             IF loc_oBusca.this_lSelecionou
8455:                 IF USED("cursor_4c_Grp")
8456:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
8457:                         loc_oPg.txt_4c_Cgrus.Value = ALLTRIM(cursor_4c_Grp.cgrus)
8458:                     ENDIF
8459:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8460:                         loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_Grp.dgrus)
8461:                     ENDIF
8462:                 ENDIF
8463:             ELSE
8464:                 IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
8465:                     loc_oPg.txt_4c_Cgrus.Value = ""
8466:                 ENDIF
8467:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8468:                     loc_oPg.txt_4c_Dgrus.Value = ""
8469:                 ENDIF
8470:             ENDIF
8471: 
8472:             IF USED("cursor_4c_Grp")
8473:                 USE IN cursor_4c_Grp
8474:             ENDIF
8475:             loc_oBusca.Release()
8476:         CATCH TO loc_oErro
8477:             MsgErro("Erro no lookup de grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupGrupo")
8478:         ENDTRY
8479:     ENDPROC
8480: 
8481:     *--------------------------------------------------------------------------
8482:     * TabPrincipal_LinhasKeyPress - F4 no campo Linha abre lookup
8483:     *--------------------------------------------------------------------------
8484:     PROCEDURE TabPrincipal_LinhasKeyPress
8485:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8486:         IF par_nKeyCode = 115
8487:             THIS.AbrirLookupLinha()
8488:         ENDIF
8489:     ENDPROC
8490: 
8491:     *--------------------------------------------------------------------------
8492:     * TabPrincipal_LinhasLostFocus - LostFocus valida e carrega descricao da linha
8493:     *--------------------------------------------------------------------------
8494:     PROCEDURE TabPrincipal_LinhasLostFocus()
8495:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8496:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8497:         IF !PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
8498:             RETURN
8499:         ENDIF
8500:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
8501: 
8502:         IF loc_cCod == THIS.this_cUltLinhas
8503:             RETURN
8504:         ENDIF
8505:         THIS.this_cUltLinhas = loc_cCod
8506: 
8507:         IF EMPTY(loc_cCod)
8508:             IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8509:                 loc_oPg.txt_4c_Dlinhas.Value = ""
8510:             ENDIF
8511:             RETURN
8512:         ENDIF
8513: 
8514:         TRY
8515:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8516:                 SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = <<EscaparSQL(loc_cCod)>>
8517:             ENDTEXT
8518:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VLin")
8519:             IF loc_nR > 0 AND !EOF("cursor_4c_VLin")
8520:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8521:                     loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_VLin.Descs)
8522:                 ENDIF
8523:             ELSE
8524:                 THIS.AbrirLookupLinha()
8525:             ENDIF
8526:             IF USED("cursor_4c_VLin")
8527:                 USE IN cursor_4c_VLin
8528:             ENDIF
8529:         CATCH TO loc_oErro
8530:             MsgErro("Erro ao validar linha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_LinhasLostFocus")
8531:         ENDTRY
8532:     ENDPROC
8533: 
8534:     *--------------------------------------------------------------------------
8535:     * AbrirLookupLinha - Abre FormBuscaAuxiliar para selecionar linha de produto
8536:     *--------------------------------------------------------------------------
8537:     PROTECTED PROCEDURE AbrirLookupLinha()
8538:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8539:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8540:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5), ALLTRIM(loc_oPg.txt_4c_Linhas.Value), "")
8541: 
8542:         TRY
8543:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", "cursor_4c_Lin", "Linhas", loc_cVal, "Selecionar Linha")
8544:             loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
8545:             loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
8546:             loc_oBusca.Show()
8547: 
8548:             IF loc_oBusca.this_lSelecionou
8549:                 IF USED("cursor_4c_Lin")
8550:                     IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
8551:                         loc_oPg.txt_4c_Linhas.Value  = ALLTRIM(cursor_4c_Lin.Linhas)
8552:                     ENDIF
8553:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8554:                         loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_Lin.Descs)
8555:                     ENDIF
8556:                 ENDIF
8557:             ELSE
8558:                 IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
8559:                     loc_oPg.txt_4c_Linhas.Value  = ""
8560:                 ENDIF
8561:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8562:                     loc_oPg.txt_4c_Dlinhas.Value = ""
8563:                 ENDIF
8564:             ENDIF
8565: 
8566:             IF USED("cursor_4c_Lin")
8567:                 USE IN cursor_4c_Lin
8568:             ENDIF
8569:             loc_oBusca.Release()
8570:         CATCH TO loc_oErro
8571:             MsgErro("Erro no lookup de linha:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupLinha")
8572:         ENDTRY
8573:     ENDPROC
8574: 
8575:     *--------------------------------------------------------------------------
8576:     * TabPrincipal_ColecoesKeyPress - F4 no campo Grupo de Venda abre lookup
8577:     *--------------------------------------------------------------------------
8578:     PROCEDURE TabPrincipal_ColecoesKeyPress
8579:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8580:         IF par_nKeyCode = 115
8581:             THIS.AbrirLookupColecao()
8582:         ENDIF
8583:     ENDPROC
8584: 
8585:     *--------------------------------------------------------------------------
8586:     * TabPrincipal_ColecoesLostFocus - LostFocus valida e carrega descricao
8587:     *--------------------------------------------------------------------------
8588:     PROCEDURE TabPrincipal_ColecoesLostFocus()
8589:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8590:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8591:         IF !PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
8592:             RETURN
8593:         ENDIF
8594:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
8595: 
8596:         IF loc_cCod == THIS.this_cUltColecoes
8597:             RETURN
8598:         ENDIF
8599:         THIS.this_cUltColecoes = loc_cCod
8600: 
8601:         IF EMPTY(loc_cCod)
8602:             IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8603:                 loc_oPg.txt_4c_Dcolecoes.Value = ""
8604:             ENDIF
8605:             RETURN
8606:         ENDIF
8607: 
8608:         TRY
8609:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8610:                 SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = <<EscaparSQL(loc_cCod)>>
8611:             ENDTEXT
8612:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCol")
8613:             IF loc_nR > 0 AND !EOF("cursor_4c_VCol")
8614:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8615:                     loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_VCol.Descs)
8616:                 ENDIF
8617:             ELSE
8618:                 THIS.AbrirLookupColecao()
8619:             ENDIF
8620:             IF USED("cursor_4c_VCol")
8621:                 USE IN cursor_4c_VCol
8622:             ENDIF
8623:         CATCH TO loc_oErro
8624:             MsgErro("Erro ao validar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_ColecoesLostFocus")
8625:         ENDTRY
8626:     ENDPROC
8627: 
8628:     *--------------------------------------------------------------------------
8629:     * AbrirLookupColecao - Abre FormBuscaAuxiliar para selecionar grupo de venda
8630:     *--------------------------------------------------------------------------
8631:     PROTECTED PROCEDURE AbrirLookupColecao()
8632:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8633:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8634:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5), ALLTRIM(loc_oPg.txt_4c_Colecoes.Value), "")
8635: 
8636:         TRY
8637:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", "cursor_4c_Col", "Colecoes", loc_cVal, "Selecionar Grupo de Venda")
8638:             loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
8639:             loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
8640:             loc_oBusca.Show()
8641: 
8642:             IF loc_oBusca.this_lSelecionou
8643:                 IF USED("cursor_4c_Col")
8644:                     IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
8645:                         loc_oPg.txt_4c_Colecoes.Value  = ALLTRIM(cursor_4c_Col.Colecoes)
8646:                     ENDIF
8647:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8648:                         loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_Col.Descs)
8649:                     ENDIF
8650:                 ENDIF
8651:             ELSE
8652:                 IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
8653:                     loc_oPg.txt_4c_Colecoes.Value  = ""
8654:                 ENDIF
8655:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8656:                     loc_oPg.txt_4c_Dcolecoes.Value = ""
8657:                 ENDIF
8658:             ENDIF
8659: 
8660:             IF USED("cursor_4c_Col")
8661:                 USE IN cursor_4c_Col
8662:             ENDIF
8663:             loc_oBusca.Release()
8664:         CATCH TO loc_oErro
8665:             MsgErro("Erro no lookup de cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupColecao")
8666:         ENDTRY
8667:     ENDPROC
8668: 
8669:     *--------------------------------------------------------------------------
8670:     * TabPrincipal_IforsKeyPress - F4 no campo Fornecedor abre lookup
8671:     *--------------------------------------------------------------------------
8672:     PROCEDURE TabPrincipal_IforsKeyPress
8673:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8674:         IF par_nKeyCode = 115
8675:             THIS.AbrirLookupFornecedor()
8676:         ENDIF
8677:     ENDPROC
8678: 
8679:     *--------------------------------------------------------------------------
8680:     * TabPrincipal_IforsLostFocus - LostFocus valida e carrega nome do fornecedor
8681:     *--------------------------------------------------------------------------
8682:     PROCEDURE TabPrincipal_IforsLostFocus()
8683:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8684:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8685:         IF !PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
8686:             RETURN
8687:         ENDIF
8688:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
8689: 
8690:         IF loc_cCod == THIS.this_cUltIfors
8691:             RETURN
8692:         ENDIF
8693:         THIS.this_cUltIfors = loc_cCod
8694: 
8695:         IF EMPTY(loc_cCod)
8696:             IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8697:                 loc_oPg.txt_4c_Dfors.Value = ""
8698:             ENDIF
8699:             RETURN
8700:         ENDIF
8701: 
8702:         TRY
8703:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8704:                 SELECT TOP 1 IClis, Rclis FROM SigCdCli WHERE IClis = <<EscaparSQL(loc_cCod)>>
8705:             ENDTEXT
8706:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VFor")
8707:             IF loc_nR > 0 AND !EOF("cursor_4c_VFor")
8708:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8709:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_VFor.Rclis)
8710:                 ENDIF
8711:             ELSE
8712:                 THIS.AbrirLookupFornecedor()
8713:             ENDIF
8714:             IF USED("cursor_4c_VFor")
8715:                 USE IN cursor_4c_VFor
8716:             ENDIF
8717:         CATCH TO loc_oErro
8718:             MsgErro("Erro ao validar fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_IforsLostFocus")
8719:         ENDTRY
8720:     ENDPROC
8721: 
8722:     *--------------------------------------------------------------------------
8723:     * AbrirLookupFornecedor - Abre FormBuscaAuxiliar para selecionar fornecedor
8724:     *--------------------------------------------------------------------------
8725:     PROTECTED PROCEDURE AbrirLookupFornecedor()
8726:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8727:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8728:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5), ALLTRIM(loc_oPg.txt_4c_Ifors.Value), "")
8729: 
8730:         TRY
8731:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_For", "IClis", loc_cVal, "Selecionar Fornecedor")
8732:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
8733:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
8734:             loc_oBusca.Show()
8735: 
8736:             IF loc_oBusca.this_lSelecionou
8737:                 IF USED("cursor_4c_For")
8738:                     IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
8739:                         loc_oPg.txt_4c_Ifors.Value = ALLTRIM(cursor_4c_For.IClis)
8740:                     ENDIF
8741:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8742:                         loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_For.Rclis)
8743:                     ENDIF
8744:                 ENDIF
8745:             ELSE
8746:                 IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
8747:                     loc_oPg.txt_4c_Ifors.Value = ""
8748:                 ENDIF
8749:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8750:                     loc_oPg.txt_4c_Dfors.Value = ""
8751:                 ENDIF
8752:             ENDIF
8753: 
8754:             IF USED("cursor_4c_For")
8755:                 USE IN cursor_4c_For
8756:             ENDIF
8757:             loc_oBusca.Release()
8758:         CATCH TO loc_oErro
8759:             MsgErro("Erro no lookup de fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupFornecedor")
8760:         ENDTRY
8761:     ENDPROC
8762: 
8763:     *--------------------------------------------------------------------------
8764:     * TabPrincipal_CproeqsKeyPress - F4 no campo Produto Equivalente
8765:     *--------------------------------------------------------------------------
8766:     PROCEDURE TabPrincipal_CproeqsKeyPress
8767:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8768:         IF par_nKeyCode = 115
8769:             THIS.AbrirLookupEquivalente()
8770:         ENDIF
8771:     ENDPROC
8772: 
8773:     *--------------------------------------------------------------------------
8774:     * AbrirLookupEquivalente - Abre FormBuscaAuxiliar para produto equivalente
8775:     *--------------------------------------------------------------------------
8776:     PROTECTED PROCEDURE AbrirLookupEquivalente()
8777:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8778:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8779:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5), ALLTRIM(loc_oPg.txt_4c_Cproeqs.Value), "")
8780: 
8781:         TRY
8782:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Eq", "cpros", loc_cVal, "Selecionar Produto Equivalente")
8783:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
8784:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8785:             loc_oBusca.Show()
8786: 
8787:             IF loc_oBusca.this_lSelecionou
8788:                 IF USED("cursor_4c_Eq")
8789:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
8790:                         loc_oPg.txt_4c_Cproeqs.Value = ALLTRIM(cursor_4c_Eq.cpros)
8791:                     ENDIF
8792:                 ENDIF
8793:             ELSE
8794:                 IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
8795:                     loc_oPg.txt_4c_Cproeqs.Value = ""
8796:                 ENDIF
8797:             ENDIF
8798: 
8799:             IF USED("cursor_4c_Eq")
8800:                 USE IN cursor_4c_Eq
8801:             ENDIF
8802:             loc_oBusca.Release()
8803:         CATCH TO loc_oErro
8804:             MsgErro("Erro no lookup de equivalente:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupEquivalente")
8805:         ENDTRY
8806:     ENDPROC
8807: 
8808:     *--------------------------------------------------------------------------
8809:     * TabPrincipal_MoeKeyPress - F4 nos campos de moeda abre lookup
8810:     *--------------------------------------------------------------------------
8811:     PROCEDURE TabPrincipal_MoeKeyPress
8812:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8813:         IF par_nKeyCode = 115
8814:             THIS.AbrirLookupMoeda()
8815:         ENDIF
8816:     ENDPROC
8817: 
8818:     *--------------------------------------------------------------------------
8819:     * TabPrincipal_MoeLostFocus - LostFocus nos campos de moeda (sem acao)
8820:     * Validacao de moeda ocorre no BO.Validar() ao salvar
8821:     *--------------------------------------------------------------------------
8822:     PROCEDURE TabPrincipal_MoeLostFocus()
8823:         RETURN
8824:     ENDPROC
8825: 
8826:     *--------------------------------------------------------------------------
8827:     * AbrirLookupMoeda - Abre FormBuscaAuxiliar para selecionar moeda
8828:     *--------------------------------------------------------------------------
8829:     PROTECTED PROCEDURE AbrirLookupMoeda()
8830:         LOCAL loc_oBusca, loc_oPg, loc_cMoeCod
8831:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8832: 
8833:         TRY
8834:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", "cursor_4c_Moe", "CMoes", "", "Selecionar Moeda")
8835:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
8836:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
8837:             loc_oBusca.Show()
8838: 
8839:             IF loc_oBusca.this_lSelecionou
8840:                 IF USED("cursor_4c_Moe")
8841:                     loc_cMoeCod = ALLTRIM(cursor_4c_Moe.CMoes)
8842:                     *-- Aplicar ao campo de moeda que nao estiver ReadOnly
8843:                     IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
8844:                         IF !loc_oPg.txt_4c_Moecs.ReadOnly
8845:                             loc_oPg.txt_4c_Moecs.Value = loc_cMoeCod
8846:                         ENDIF
8847:                     ENDIF
8848:                     IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
8849:                         IF !loc_oPg.txt_4c_Moepvs.ReadOnly
8850:                             loc_oPg.txt_4c_Moepvs.Value = loc_cMoeCod
8851:                         ENDIF
8852:                     ENDIF
8853:                 ENDIF
8854:             ENDIF
8855: 
8856:             IF USED("cursor_4c_Moe")
8857:                 USE IN cursor_4c_Moe
8858:             ENDIF
8859:             loc_oBusca.Release()
8860:         CATCH TO loc_oErro
8861:             MsgErro("Erro no lookup de moeda:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupMoeda")
8862:         ENDTRY
8863:     ENDPROC
8864: 
8865:     *--------------------------------------------------------------------------
8866:     * TabPrincipal_CunisKeyPress - F4 no campo Unidade 1 abre lookup
8867:     *--------------------------------------------------------------------------
8868:     PROCEDURE TabPrincipal_CunisKeyPress
8869:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8870:         IF par_nKeyCode = 115
8871:             THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
8872:         ENDIF
8873:     ENDPROC
8874: 
8875:     *--------------------------------------------------------------------------
8876:     * TabPrincipal_CunisLostFocus - LostFocus valida unidade 1
8877:     *--------------------------------------------------------------------------
8878:     PROCEDURE TabPrincipal_CunisLostFocus()
8879:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8880:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8881:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cunis", 5)
8882:             RETURN
8883:         ENDIF
8884:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
8885: 
8886:         IF loc_cCod == THIS.this_cUltCunis
8887:             RETURN
8888:         ENDIF
8889:         THIS.this_cUltCunis = loc_cCod
8890: 
8891:         IF EMPTY(loc_cCod)
8892:             IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
8893:                 loc_oPg.txt_4c_Dunis.Value = ""
8894:             ENDIF
8895:             RETURN
8896:         ENDIF
8897: 
8898:         TRY
8899:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8900:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8901:             ENDTEXT
8902:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUni")
8903:             IF loc_nR > 0 AND !EOF("cursor_4c_VUni")
8904:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
8905:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_VUni.dunis)
8906:                 ENDIF
8907:             ELSE
8908:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
8909:             ENDIF
8910:             IF USED("cursor_4c_VUni")
8911:                 USE IN cursor_4c_VUni
8912:             ENDIF
8913:         CATCH TO loc_oErro
8914:             MsgErro("Erro ao validar unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunisLostFocus")
8915:         ENDTRY
8916:     ENDPROC
8917: 
8918:     *--------------------------------------------------------------------------
8919:     * TabPrincipal_CunipsKeyPress - F4 no campo Unidade 2 abre lookup
8920:     *--------------------------------------------------------------------------
8921:     PROCEDURE TabPrincipal_CunipsKeyPress
8922:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8923:         IF par_nKeyCode = 115
8924:             THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
8925:         ENDIF
8926:     ENDPROC
8927: 
8928:     *--------------------------------------------------------------------------
8929:     * TabPrincipal_CunipsLostFocus - LostFocus valida unidade 2
8930:     *--------------------------------------------------------------------------
8931:     PROCEDURE TabPrincipal_CunipsLostFocus()
8932:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8933:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8934:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cunips", 5)
8935:             RETURN
8936:         ENDIF
8937:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunips.Value)
8938: 
8939:         IF loc_cCod == THIS.this_cUltCunips
8940:             RETURN
8941:         ENDIF
8942:         THIS.this_cUltCunips = loc_cCod
8943: 
8944:         IF EMPTY(loc_cCod)
8945:             IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
8946:                 loc_oPg.txt_4c_Dunips.Value = ""
8947:             ENDIF
8948:             RETURN
8949:         ENDIF
8950: 
8951:         TRY
8952:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8953:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8954:             ENDTEXT
8955:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUn2")
8956:             IF loc_nR > 0 AND !EOF("cursor_4c_VUn2")
8957:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
8958:                     loc_oPg.txt_4c_Dunips.Value = ALLTRIM(cursor_4c_VUn2.dunis)
8959:                 ENDIF
8960:             ELSE
8961:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
8962:             ENDIF
8963:             IF USED("cursor_4c_VUn2")
8964:                 USE IN cursor_4c_VUn2
8965:             ENDIF
8966:         CATCH TO loc_oErro
8967:             MsgErro("Erro ao validar unidade 2:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunipsLostFocus")
8968:         ENDTRY
8969:     ENDPROC
8970: 
8971:     *--------------------------------------------------------------------------
8972:     * AbrirLookupUnidade - Abre FormBuscaAuxiliar para selecionar unidade
8973:     * par_cKeyField: campo chave na SigCdUni
8974:     * par_cTxtCode: nome do TextBox de codigo na Page1
8975:     * par_cTxtDesc: nome do TextBox de descricao na Page1
8976:     *--------------------------------------------------------------------------
8977:     PROTECTED PROCEDURE AbrirLookupUnidade(par_cKeyField, par_cTxtCode, par_cTxtDesc)
8978:         LOCAL loc_oBusca, loc_oPg, loc_cVal, loc_cTxtCodeRef, loc_cTxtDescRef
8979:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8980:         loc_cVal = IIF(PEMSTATUS(loc_oPg, par_cTxtCode, 5), ALLTRIM(loc_oPg.&par_cTxtCode..Value), "")
8981: 
8982:         TRY
8983:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUni", "cursor_4c_Uni", par_cKeyField, loc_cVal, "Selecionar Unidade")
8984:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
8985:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
8986:             loc_oBusca.Show()
8987: 
8988:             IF loc_oBusca.this_lSelecionou
8989:                 IF USED("cursor_4c_Uni")
8990:                     IF PEMSTATUS(loc_oPg, par_cTxtCode, 5)
8991:                         loc_oPg.&par_cTxtCode..Value = ALLTRIM(cursor_4c_Uni.cunis)
8992:                     ENDIF
8993:                     IF PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
8994:                         loc_oPg.&par_cTxtDesc..Value = ALLTRIM(cursor_4c_Uni.dunis)
8995:                     ENDIF
8996:                 ENDIF
8997:             ELSE
8998:                 IF PEMSTATUS(loc_oPg, par_cTxtCode, 5)
8999:                     loc_oPg.&par_cTxtCode..Value = ""
9000:                 ENDIF
9001:                 IF PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
9002:                     loc_oPg.&par_cTxtDesc..Value = ""
9003:                 ENDIF
9004:             ENDIF
9005: 
9006:             IF USED("cursor_4c_Uni")
9007:                 USE IN cursor_4c_Uni
9008:             ENDIF
9009:             loc_oBusca.Release()
9010:         CATCH TO loc_oErro
9011:             MsgErro("Erro no lookup de unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupUnidade")
9012:         ENDTRY
9013:     ENDPROC
9014: 
9015:     *--------------------------------------------------------------------------
9016:     * TabPrincipal_CodacbsKeyPress - F4 no campo Acabamento abre lookup
9017:     *--------------------------------------------------------------------------
9018:     PROCEDURE TabPrincipal_CodacbsKeyPress
9019:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9020:         IF par_nKeyCode = 115
9021:             THIS.AbrirLookupAcabamento()
9022:         ENDIF
9023:     ENDPROC
9024: 
9025:     *--------------------------------------------------------------------------
9026:     * TabPrincipal_CodacbsLostFocus - LostFocus valida acabamento
9027:     *--------------------------------------------------------------------------
9028:     PROCEDURE TabPrincipal_CodacbsLostFocus()
9029:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
9030:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9031:         IF !PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
9032:             RETURN
9033:         ENDIF
9034:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codacbs.Value)
9035: 
9036:         IF loc_cCod == THIS.this_cUltCodacbs
9037:             RETURN
9038:         ENDIF
9039:         THIS.this_cUltCodacbs = loc_cCod
9040: 
9041:         IF EMPTY(loc_cCod)
9042:             IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9043:                 loc_oPg.txt_4c_Dcodacbs.Value = ""
9044:             ENDIF
9045:             RETURN
9046:         ENDIF
9047: 
9048:         TRY
9049:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9050:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
9051:             ENDTEXT
9052:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcb")
9053:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcb")
9054:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9055:                     loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_VAcb.descrs)
9056:                 ENDIF
9057:             ELSE
9058:                 THIS.AbrirLookupAcabamento()
9059:             ENDIF
9060:             IF USED("cursor_4c_VAcb")
9061:                 USE IN cursor_4c_VAcb
9062:             ENDIF
9063:         CATCH TO loc_oErro
9064:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodacbsLostFocus")
9065:         ENDTRY
9066:     ENDPROC
9067: 
9068:     *--------------------------------------------------------------------------
9069:     * AbrirLookupAcabamento - Abre FormBuscaAuxiliar para selecionar acabamento
9070:     *--------------------------------------------------------------------------
9071:     PROTECTED PROCEDURE AbrirLookupAcabamento()
9072:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9073:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9074:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5), ALLTRIM(loc_oPg.txt_4c_Codacbs.Value), "")
9075: 
9076:         TRY
9077:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", "cursor_4c_Acb", "cods", loc_cVal, "Selecionar Acabamento")
9078:             loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
9079:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9080:             loc_oBusca.Show()
9081: 
9082:             IF loc_oBusca.this_lSelecionou
9083:                 IF USED("cursor_4c_Acb")
9084:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
9085:                         loc_oPg.txt_4c_Codacbs.Value  = ALLTRIM(cursor_4c_Acb.cods)
9086:                     ENDIF
9087:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9088:                         loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_Acb.descrs)
9089:                     ENDIF
9090:                 ENDIF
9091:             ELSE
9092:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
9093:                     loc_oPg.txt_4c_Codacbs.Value  = ""
9094:                 ENDIF
9095:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9096:                     loc_oPg.txt_4c_Dcodacbs.Value = ""
9097:                 ENDIF
9098:             ENDIF
9099: 
9100:             IF USED("cursor_4c_Acb")
9101:                 USE IN cursor_4c_Acb
9102:             ENDIF
9103:             loc_oBusca.Release()
9104:         CATCH TO loc_oErro
9105:             MsgErro("Erro no lookup de acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupAcabamento")
9106:         ENDTRY
9107:     ENDPROC
9108: 
9109:     *--------------------------------------------------------------------------
9110:     * TabPrincipal_CodcorsKeyPress - F4 no campo Cor abre lookup
9111:     *--------------------------------------------------------------------------
9112:     PROCEDURE TabPrincipal_CodcorsKeyPress
9113:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9114:         IF par_nKeyCode = 115
9115:             THIS.AbrirLookupCor()
9116:         ENDIF
9117:     ENDPROC
9118: 
9119:     *--------------------------------------------------------------------------
9120:     * TabPrincipal_CodcorsLostFocus - LostFocus valida cor
9121:     *--------------------------------------------------------------------------
9122:     PROCEDURE TabPrincipal_CodcorsLostFocus()
9123:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
9124:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9125:         IF !PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
9126:             RETURN
9127:         ENDIF
9128:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codcors.Value)
9129: 
9130:         IF loc_cCod == THIS.this_cUltCodcors
9131:             RETURN
9132:         ENDIF
9133:         THIS.this_cUltCodcors = loc_cCod
9134: 
9135:         IF EMPTY(loc_cCod)
9136:             RETURN
9137:         ENDIF
9138: 
9139:         TRY
9140:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9141:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
9142:             ENDTEXT
9143:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCor")
9144:             IF loc_nR <= 0
9145:                 THIS.AbrirLookupCor()
9146:             ELSE
9147:                 IF EOF("cursor_4c_VCor")
9148:                     THIS.AbrirLookupCor()
9149:                 ENDIF
9150:             ENDIF
9151:             IF USED("cursor_4c_VCor")
9152:                 USE IN cursor_4c_VCor
9153:             ENDIF
9154:         CATCH TO loc_oErro
9155:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodcorsLostFocus")
9156:         ENDTRY
9157:     ENDPROC
9158: 
9159:     *--------------------------------------------------------------------------
9160:     * AbrirLookupCor - Abre FormBuscaAuxiliar para selecionar cor
9161:     *--------------------------------------------------------------------------
9162:     PROTECTED PROCEDURE AbrirLookupCor()
9163:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9164:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9165:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5), ALLTRIM(loc_oPg.txt_4c_Codcors.Value), "")
9166: 
9167:         TRY
9168:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", "cursor_4c_Cor", "cods", loc_cVal, "Selecionar Cor")
9169:             loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
9170:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9171:             loc_oBusca.Show()
9172: 
9173:             IF loc_oBusca.this_lSelecionou
9174:                 IF USED("cursor_4c_Cor")
9175:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
9176:                         loc_oPg.txt_4c_Codcors.Value = ALLTRIM(cursor_4c_Cor.cods)
9177:                     ENDIF
9178:                 ENDIF
9179:             ELSE
9180:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
9181:                     loc_oPg.txt_4c_Codcors.Value = ""
9182:                 ENDIF
9183:             ENDIF
9184: 
9185:             IF USED("cursor_4c_Cor")
9186:                 USE IN cursor_4c_Cor
9187:             ENDIF
9188:             loc_oBusca.Release()
9189:         CATCH TO loc_oErro
9190:             MsgErro("Erro no lookup de cor:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupCor")
9191:         ENDTRY
9192:     ENDPROC
9193: 
9194:     *--------------------------------------------------------------------------
9195:     * TabPrincipal_CodtamsKeyPress - F4 no campo Tamanho abre lookup
9196:     *--------------------------------------------------------------------------
9197:     PROCEDURE TabPrincipal_CodtamsKeyPress
9198:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9199:         IF par_nKeyCode = 115
9200:             THIS.AbrirLookupTamanho()
9201:         ENDIF
9202:     ENDPROC
9203: 
9204:     *--------------------------------------------------------------------------
9205:     * AbrirLookupTamanho - Abre FormBuscaAuxiliar para selecionar tamanho
9206:     *--------------------------------------------------------------------------
9207:     PROTECTED PROCEDURE AbrirLookupTamanho()
9208:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9209:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9210:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5), ALLTRIM(loc_oPg.txt_4c_Codtams.Value), "")
9211: 
9212:         TRY
9213:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_Tam", "cods", loc_cVal, "Selecionar Tamanho")
9214:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9215:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9216:             loc_oBusca.Show()
9217: 
9218:             IF loc_oBusca.this_lSelecionou
9219:                 IF USED("cursor_4c_Tam")
9220:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
9221:                         loc_oPg.txt_4c_Codtams.Value = ALLTRIM(cursor_4c_Tam.cods)
9222:                     ENDIF
9223:                 ENDIF
9224:             ELSE
9225:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
9226:                     loc_oPg.txt_4c_Codtams.Value = ""
9227:                 ENDIF
9228:             ENDIF
9229: 
9230:             IF USED("cursor_4c_Tam")
9231:                 USE IN cursor_4c_Tam
9232:             ENDIF
9233:             loc_oBusca.Release()
9234:         CATCH TO loc_oErro
9235:             MsgErro("Erro no lookup de tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupTamanho")
9236:         ENDTRY
9237:     ENDPROC
9238: 
9239:     *--------------------------------------------------------------------------
9240:     * CarregarDesc - Helper: carrega descricao de um campo lookup via SQL
9241:     * Retorna "" se nao encontrado ou valor vazio
9242:     *--------------------------------------------------------------------------
9243:     PROTECTED FUNCTION CarregarDesc(par_cTabela, par_cCampoChave, par_cValor, par_cCampoDesc)
9244:         LOCAL loc_cDesc, loc_cSQL, loc_nR, loc_cAliasField
9245:         loc_cDesc = ""
9246: 
9247:         IF !EMPTY(par_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
9248:             TRY
9249:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9250:                     SELECT TOP 1 <<par_cCampoDesc>> FROM <<par_cTabela>> WHERE <<par_cCampoChave>> = <<EscaparSQL(par_cValor)>>
9251:                 ENDTEXT
9252:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescH")
9253:                 IF loc_nR > 0 AND !EOF("cursor_4c_DescH")

*-- Linhas 9269 a 9312:
9269:     * CarregarComposicao - Carrega grid de composicao (Tab 2)
9270:     * Tabela: SIGPRCPO JOIN SigCdPro
9271:     *--------------------------------------------------------------------------
9272:     PROTECTED PROCEDURE CarregarComposicao()
9273:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9274:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9275:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9276: 
9277:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9278:             RETURN
9279:         ENDIF
9280: 
9281:         TRY
9282:             *-- Composicao principal
9283:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9284:                 SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9285:                        c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9286:                        c.qtdcvs, c.cunips, c.ordems, c.compos
9287:                 FROM SIGPRCPO c
9288:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9289:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9290:                 ORDER BY c.ordems
9291:             ENDTEXT
9292:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTmp")
9293:             IF loc_nR > 0
9294:                 IF USED("cursor_4c_Compo")
9295:                     SELECT cursor_4c_Compo
9296:                     ZAP
9297:                     APPEND FROM DBF("cursor_4c_CompoTmp")
9298:                 ENDIF
9299:                 IF USED("cursor_4c_CompoTmp")
9300:                     USE IN cursor_4c_CompoTmp
9301:                 ENDIF
9302:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
9303:                     loc_oPg.grd_4c_Compo.Refresh()
9304:                 ENDIF
9305:             ENDIF
9306: 
9307:             *-- Sub-composicao
9308:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9309:                 SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9310:                        c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9311:                        c.qtdcvs, c.cunips, c.ordems, c.matsubs, c.codtams
9312:                 FROM sigsubcp c

*-- Linhas 9339 a 9382:
9339:     * GrdCons: SIGPRCPO JOIN SigCdPrf(fase) JOIN SigCdCat(categoria)
9340:     * grDTEMP:  SIGPRCPO agrupado por fase (consumo total)
9341:     *--------------------------------------------------------------------------
9342:     PROTECTED PROCEDURE CarregarConsultaP()
9343:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nCount, loc_oPg
9344:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9345:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9346: 
9347:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9348:             RETURN
9349:         ENDIF
9350: 
9351:         TRY
9352:             *-- Carregar componentes com descricao de fase e categoria
9353:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9354:                 SELECT c.mats, c.qtds, c.unicompos, c.grupos,
9355:                        ISNULL((SELECT TOP 1 g.Descrs FROM SigCdGcr g WHERE RTRIM(g.Codigos) = RTRIM(c.grupos)), '') AS dcompos,
9356:                        c.ordems, c.qtscons, c.cats,
9357:                        ISNULL(cat.descs, '') AS dscgrp
9358:                 FROM SIGPRCPO c
9359:                 LEFT JOIN SigCdCat cat ON RTRIM(c.cats) = RTRIM(cat.cods)
9360:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9361:                 ORDER BY c.ordems, c.mats
9362:             ENDTEXT
9363:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaTmp")
9364:             IF loc_nR > 0
9365:                 IF USED("cursor_4c_Consulta")
9366:                     SELECT cursor_4c_Consulta
9367:                     ZAP
9368:                     APPEND FROM DBF("cursor_4c_ConsultaTmp")
9369:                 ENDIF
9370:                 IF USED("cursor_4c_ConsultaTmp")
9371:                     USE IN cursor_4c_ConsultaTmp
9372:                 ENDIF
9373:                 *-- Atualizar contagem de componentes
9374:                 loc_nCount = RECCOUNT("cursor_4c_Consulta")
9375:                 IF PEMSTATUS(loc_oPg, "txt_4c_QtdCpnt", 5)
9376:                     loc_oPg.txt_4c_QtdCpnt.Value = loc_nCount
9377:                 ENDIF
9378:                 IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
9379:                     loc_oPg.grd_4c_Consulta.Refresh()
9380:                 ENDIF
9381:             ENDIF
9382: 

*-- Linhas 9414 a 9457:
9414:     * CarregarCustos - Carrega grid de custo da composicao (Tab 3 - pgCusto)
9415:     * Tabela: SIGPRCPO filtrado por Tipos (tipo de calculo de custo)
9416:     *--------------------------------------------------------------------------
9417:     PROTECTED PROCEDURE CarregarCustos()
9418:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_nTipo
9419:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9420:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9421: 
9422:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9423:             RETURN
9424:         ENDIF
9425: 
9426:         TRY
9427:             *-- Obter tipo selecionado no combo (0=Todos, 1/2/3=tipo especifico)
9428:             loc_nTipo = 0
9429:             IF PEMSTATUS(loc_oPg, "cmb_4c_TiposCusto", 5)
9430:                 loc_nTipo = NVL(loc_oPg.cmb_4c_TiposCusto.ListIndex, 1) - 1
9431:             ENDIF
9432: 
9433:             *-- Composicao de custo
9434:             IF loc_nTipo = 0
9435:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9436:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9437:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9438:                            c.qtdcvs, c.cunips
9439:                     FROM SIGPRCPO c
9440:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9441:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9442:                     AND c.tipos IS NOT NULL
9443:                     ORDER BY c.mats
9444:                 ENDTEXT
9445:             ELSE
9446:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9447:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9448:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9449:                            c.qtdcvs, c.cunips
9450:                     FROM SIGPRCPO c
9451:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9452:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9453:                     AND c.tipos = <<TRANSFORM(loc_nTipo)>>
9454:                     ORDER BY c.mats
9455:                 ENDTEXT
9456:             ENDIF
9457: 

*-- Linhas 9525 a 9568:
9525:     * CarregarFases - Carrega grid de fases (Tab 7)
9526:     * Tabela: SigCdPrf
9527:     *--------------------------------------------------------------------------
9528:     PROTECTED PROCEDURE CarregarFases()
9529:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_oBO
9530:         loc_oBO    = THIS.this_oBusinessObject
9531:         loc_cCpros = ALLTRIM(loc_oBO.this_cCpros)
9532:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
9533: 
9534:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9535:             RETURN
9536:         ENDIF
9537: 
9538:         TRY
9539:             *-- Fases de producao
9540:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9541:                 SELECT ordems, grupos, minutos, uniprdts, matprdts
9542:                 FROM SigCdPrf
9543:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9544:                 ORDER BY ordems
9545:             ENDTEXT
9546:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesTmp")
9547:             IF loc_nR > 0
9548:                 IF USED("cursor_4c_Fases")
9549:                     SELECT cursor_4c_Fases
9550:                     ZAP
9551:                     APPEND FROM DBF("cursor_4c_FasesTmp")
9552:                 ENDIF
9553:                 IF USED("cursor_4c_FasesTmp")
9554:                     USE IN cursor_4c_FasesTmp
9555:                 ENDIF
9556:                 IF PEMSTATUS(loc_oPg, "grd_4c_Fases", 5)
9557:                     loc_oPg.grd_4c_Fases.Refresh()
9558:                 ENDIF
9559:             ENDIF
9560: 
9561:             *-- Matrizes
9562:             THIS.CarregarMatrizes()
9563: 
9564:             *-- Preencher campos do BO nas textboxes da tab
9565:             IF PEMSTATUS(loc_oPg, "txt_4c_Qminfab", 5)
9566:                 loc_oPg.txt_4c_Qminfab.Value   = loc_oBO.this_nQtminfabs
9567:             ENDIF
9568:             IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)

*-- Linhas 9608 a 9651:
9608:     * CarregarMatrizes - Carrega grid de matrizes (Tab 7 - sub-grid)
9609:     * Tabela: SigPrMtz JOIN SigCdPro (para Locals)
9610:     *--------------------------------------------------------------------------
9611:     PROTECTED PROCEDURE CarregarMatrizes()
9612:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9613:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9614:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
9615: 
9616:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9617:             RETURN
9618:         ENDIF
9619: 
9620:         TRY
9621:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9622:                 SELECT a.cidchaves, a.cmats, a.cpros, a.qtds, b.locals
9623:                 FROM SigPrMtz a
9624:                 INNER JOIN SigCdPro b ON RTRIM(a.cmats) = RTRIM(b.cpros)
9625:                 WHERE RTRIM(a.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9626:             ENDTEXT
9627:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizesTmp")
9628:             IF loc_nR > 0
9629:                 IF USED("cursor_4c_Matrizes")
9630:                     SELECT cursor_4c_Matrizes
9631:                     ZAP
9632:                     APPEND FROM DBF("cursor_4c_MatrizesTmp")
9633:                 ENDIF
9634:                 IF USED("cursor_4c_MatrizesTmp")
9635:                     USE IN cursor_4c_MatrizesTmp
9636:                 ENDIF
9637:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
9638:                     loc_oPg.grd_4c_Matrizes.Refresh()
9639:                 ENDIF
9640:             ENDIF
9641: 
9642:         CATCH TO loc_oErro
9643:             MsgErro("Erro ao carregar matrizes:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarMatrizes")
9644:         ENDTRY
9645:     ENDPROC
9646: 
9647:     *--------------------------------------------------------------------------
9648:     * CarregarDescSgru - Carrega descricao do subgrupo (SigCdPsg com filtro grupo)
9649:     *--------------------------------------------------------------------------
9650:     PROTECTED FUNCTION CarregarDescSgru(par_cCgrus, par_cSgrus)
9651:         LOCAL loc_cDesc, loc_cSQL, loc_nR

*-- Linhas 9676 a 9833:
9676:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
9677:     * par_nPagina: 1=Lista, 2=Dados
9678:     *--------------------------------------------------------------------------
9679:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
9680:         LOCAL loc_lResultado
9681:         loc_lResultado = .F.
9682: 
9683:         TRY
9684:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
9685:                 loc_lResultado = .F.
9686:             ELSE
9687:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
9688: 
9689:                 IF par_nPagina = 1
9690:                     THIS.CarregarLista()
9691:                 ENDIF
9692: 
9693:                 loc_lResultado = .T.
9694:             ENDIF
9695: 
9696:         CATCH TO loc_oErro
9697:             MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormProduto.AlternarPagina")
9698:             loc_lResultado = .F.
9699:         ENDTRY
9700: 
9701:         RETURN loc_lResultado
9702:     ENDPROC
9703: 
9704:     *--------------------------------------------------------------------------
9705:     * TabFiscal_ClfiscalKeyPress - F4 no campo Classif. Fiscal abre lookup
9706:     *--------------------------------------------------------------------------
9707:     PROCEDURE TabFiscal_ClfiscalKeyPress
9708:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9709:         IF par_nKeyCode = 115
9710:             THIS.AbrirLookupClassFiscal()
9711:         ENDIF
9712:     ENDPROC
9713: 
9714:     *--------------------------------------------------------------------------
9715:     * AbrirLookupClassFiscal - Abre FormBuscaAuxiliar para Classif. Fiscal
9716:     * Tabela: SigCdClf | Chave: clfiscals | Desc: dclfiscals
9717:     *--------------------------------------------------------------------------
9718:     PROTECTED PROCEDURE AbrirLookupClassFiscal()
9719:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9720:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9721:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5), ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), "")
9722: 
9723:         TRY
9724:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_Clf", "clfiscals", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
9725:             loc_oBusca.mAddColuna("clfiscals",  "", "C" + CHR(243) + "digo")
9726:             loc_oBusca.mAddColuna("dclfiscals", "", "Descri" + CHR(231) + CHR(227) + "o")
9727:             loc_oBusca.Show()
9728: 
9729:             IF loc_oBusca.this_lSelecionou
9730:                 IF USED("cursor_4c_Clf")
9731:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9732:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_Clf.clfiscals)
9733:                     ENDIF
9734:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9735:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_Clf.dclfiscals)
9736:                     ENDIF
9737:                 ENDIF
9738:             ELSE
9739:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9740:                     loc_oPg.txt_4c_Clfiscal.Value  = ""
9741:                 ENDIF
9742:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9743:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9744:                 ENDIF
9745:             ENDIF
9746: 
9747:             IF USED("cursor_4c_Clf")
9748:                 USE IN cursor_4c_Clf
9749:             ENDIF
9750:             loc_oBusca.Release()
9751:         CATCH TO loc_oErro
9752:             MsgErro("Erro no lookup de classifica" + CHR(231) + CHR(227) + "o fiscal:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupClassFiscal")
9753:         ENDTRY
9754:     ENDPROC
9755: 
9756:     *--------------------------------------------------------------------------
9757:     * TabFiscal_MetalKeyPress - KeyPress no campo Metal (sem lookup auxiliar)
9758:     * Metal e Teor sao campos de classificacao IPI preenchidos manualmente
9759:     *--------------------------------------------------------------------------
9760:     PROCEDURE TabFiscal_MetalKeyPress
9761:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9762:         *-- Sem lookup: Metal e Teor sao codigos livres no contexto IPI
9763:     ENDPROC
9764: 
9765:     *--------------------------------------------------------------------------
9766:     * TabFiscal_TeorKeyPress - KeyPress no campo Teor (sem lookup auxiliar)
9767:     *--------------------------------------------------------------------------
9768:     PROCEDURE TabFiscal_TeorKeyPress
9769:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9770:         *-- Sem lookup: Teor e codigo livre no contexto IPI
9771:     ENDPROC
9772: 
9773:     *--------------------------------------------------------------------------
9774:     * ValidarClfiscal - LostFocus no campo Classificacao Fiscal
9775:     * Tabela: SigCdClf | Chave: Codigos | Desc: Descricaos
9776:     * Ao selecionar, popula AliqIPI com aliqipis da classificacao
9777:     *--------------------------------------------------------------------------
9778:     PROCEDURE ValidarClfiscal()
9779:         LOCAL loc_oPg, loc_cVal
9780:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9781:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9782:             RETURN
9783:         ENDIF
9784:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9785: 
9786:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltClassFiscal
9787:             RETURN
9788:         ENDIF
9789:         THIS.this_cUltClassFiscal = loc_cVal
9790: 
9791:         TRY
9792:             LOCAL loc_oBusca, loc_cSQL, loc_nR
9793:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_ClfV", "Codigos", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
9794:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9795:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9796:             loc_oBusca.Show()
9797: 
9798:             IF loc_oBusca.this_lSelecionou
9799:                 IF USED("cursor_4c_ClfV")
9800:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9801:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_ClfV.Codigos)
9802:                     ENDIF
9803:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9804:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfV.Descricaos)
9805:                     ENDIF
9806:                     *-- Popula AliqIPI com aliqipis da classificacao fiscal
9807:                     IF PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
9808:                         TEXT TO loc_cSQL TEXTMERGE NOSHOW
9809:                             SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(cursor_4c_ClfV.Codigos))>>)
9810:                         ENDTEXT
9811:                         loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliq")
9812:                         IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliq")
9813:                             loc_oPg.txt_4c_AliqIPI.Value = cursor_4c_ClfAliq.aliqipis
9814:                         ENDIF
9815:                         IF USED("cursor_4c_ClfAliq")
9816:                             USE IN cursor_4c_ClfAliq
9817:                         ENDIF
9818:                     ENDIF
9819:                 ENDIF
9820:             ELSE
9821:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9822:                     loc_oPg.txt_4c_Clfiscal.Value  = ""
9823:                 ENDIF
9824:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9825:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9826:                 ENDIF
9827:                 THIS.this_cUltClassFiscal = ""
9828:             ENDIF
9829: 
9830:             IF USED("cursor_4c_ClfV")
9831:                 USE IN cursor_4c_ClfV
9832:             ENDIF
9833:             loc_oBusca.Release()

*-- Linhas 9844 a 10696:
9844:     * ValidarDclfiscal - LostFocus no campo Descricao Classificacao Fiscal
9845:     * Busca por descricao e preenche codigo
9846:     *--------------------------------------------------------------------------
9847:     PROCEDURE ValidarDclfiscal()
9848:         LOCAL loc_oPg, loc_cVal
9849:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9850:         IF !PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9851:             RETURN
9852:         ENDIF
9853:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
9854: 
9855:         *-- So abre busca se o codigo estiver vazio (getDclfiscal.When logic)
9856:         IF EMPTY(loc_cVal)
9857:             RETURN
9858:         ENDIF
9859:         IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9860:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
9861:                 RETURN
9862:             ENDIF
9863:         ENDIF
9864: 
9865:         TRY
9866:             LOCAL loc_oBusca
9867:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_ClfD", "Descricaos", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
9868:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9869:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9870:             loc_oBusca.Show()
9871: 
9872:             IF loc_oBusca.this_lSelecionou
9873:                 IF USED("cursor_4c_ClfD")
9874:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9875:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_ClfD.Codigos)
9876:                     ENDIF
9877:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9878:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfD.Descricaos)
9879:                     ENDIF
9880:                     THIS.this_cUltClassFiscal = ALLTRIM(cursor_4c_ClfD.Codigos)
9881:                 ENDIF
9882:             ELSE
9883:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9884:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9885:                 ENDIF
9886:             ENDIF
9887: 
9888:             IF USED("cursor_4c_ClfD")
9889:                 USE IN cursor_4c_ClfD
9890:             ENDIF
9891:             loc_oBusca.Release()
9892:         CATCH TO loc_oErro
9893:             MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDclfiscal")
9894:         ENDTRY
9895:     ENDPROC
9896: 
9897:     *--------------------------------------------------------------------------
9898:     * ValidarOrigmerc - LostFocus no campo Origem Mercadoria
9899:     * Tabela: SigCdOrg | Chave: Codigos | Desc: Descricaos
9900:     *--------------------------------------------------------------------------
9901:     PROCEDURE ValidarOrigmerc()
9902:         LOCAL loc_oPg, loc_cVal
9903:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9904:         IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9905:             RETURN
9906:         ENDIF
9907:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
9908: 
9909:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltOrganizacao
9910:             RETURN
9911:         ENDIF
9912:         THIS.this_cUltOrganizacao = loc_cVal
9913: 
9914:         TRY
9915:             LOCAL loc_oBusca
9916:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", "cursor_4c_Org", "Codigos", loc_cVal, "Origem da Mercadoria")
9917:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9918:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9919:             loc_oBusca.Show()
9920: 
9921:             IF loc_oBusca.this_lSelecionou
9922:                 IF USED("cursor_4c_Org")
9923:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9924:                         loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_Org.Codigos)
9925:                     ENDIF
9926:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9927:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_Org.Descricaos)
9928:                     ENDIF
9929:                 ENDIF
9930:             ELSE
9931:                 IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9932:                     loc_oPg.txt_4c_Origmerc.Value  = ""
9933:                 ENDIF
9934:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9935:                     loc_oPg.txt_4c_Dorigmerc.Value = ""
9936:                 ENDIF
9937:                 THIS.this_cUltOrganizacao = ""
9938:             ENDIF
9939: 
9940:             IF USED("cursor_4c_Org")
9941:                 USE IN cursor_4c_Org
9942:             ENDIF
9943:             loc_oBusca.Release()
9944:         CATCH TO loc_oErro
9945:             MsgErro("Erro ao validar origem da mercadoria:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarOrigmerc")
9946:         ENDTRY
9947:     ENDPROC
9948: 
9949:     *--------------------------------------------------------------------------
9950:     * ValidarDorigmerc - LostFocus no campo Descricao Origem Mercadoria
9951:     * Busca por descricao, preenche codigo (so se codigo estiver vazio)
9952:     *--------------------------------------------------------------------------
9953:     PROCEDURE ValidarDorigmerc()
9954:         LOCAL loc_oPg, loc_cVal
9955:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9956:         IF !PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9957:             RETURN
9958:         ENDIF
9959:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value)
9960: 
9961:         IF EMPTY(loc_cVal)
9962:             RETURN
9963:         ENDIF
9964:         IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9965:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value))
9966:                 RETURN
9967:             ENDIF
9968:         ENDIF
9969: 
9970:         TRY
9971:             LOCAL loc_oBusca
9972:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", "cursor_4c_OrgD", "Descricaos", loc_cVal, "Origem da Mercadoria")
9973:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9974:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9975:             loc_oBusca.Show()
9976: 
9977:             IF loc_oBusca.this_lSelecionou
9978:                 IF USED("cursor_4c_OrgD")
9979:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9980:                         loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_OrgD.Codigos)
9981:                     ENDIF
9982:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9983:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgD.Descricaos)
9984:                     ENDIF
9985:                     THIS.this_cUltOrganizacao = ALLTRIM(cursor_4c_OrgD.Codigos)
9986:                 ENDIF
9987:             ELSE
9988:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9989:                     loc_oPg.txt_4c_Dorigmerc.Value = ""
9990:                 ENDIF
9991:             ENDIF
9992: 
9993:             IF USED("cursor_4c_OrgD")
9994:                 USE IN cursor_4c_OrgD
9995:             ENDIF
9996:             loc_oBusca.Release()
9997:         CATCH TO loc_oErro
9998:             MsgErro("Erro ao buscar origem mercadoria:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDorigmerc")
9999:         ENDTRY
10000:     ENDPROC
10001: 
10002:     *--------------------------------------------------------------------------
10003:     * ValidarSittricms - LostFocus no campo Situacao Tributaria ICMS
10004:     * Tabela: SigCdIcm | Chave: Codigos | Desc: Descricaos
10005:     *--------------------------------------------------------------------------
10006:     PROCEDURE ValidarSittricms()
10007:         LOCAL loc_oPg, loc_cVal
10008:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10009:         IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10010:             RETURN
10011:         ENDIF
10012:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Sittricms.Value)
10013: 
10014:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltIcm
10015:             RETURN
10016:         ENDIF
10017:         THIS.this_cUltIcm = loc_cVal
10018: 
10019:         TRY
10020:             LOCAL loc_oBusca
10021:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_Icm", "Codigos", loc_cVal, "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10022:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10023:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10024:             loc_oBusca.Show()
10025: 
10026:             IF loc_oBusca.this_lSelecionou
10027:                 IF USED("cursor_4c_Icm")
10028:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10029:                         loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_Icm.Codigos)
10030:                     ENDIF
10031:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10032:                         loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_Icm.Descricaos)
10033:                     ENDIF
10034:                 ENDIF
10035:             ELSE
10036:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10037:                     loc_oPg.txt_4c_Sittricms.Value  = ""
10038:                 ENDIF
10039:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10040:                     loc_oPg.txt_4c_Dsittricms.Value = ""
10041:                 ENDIF
10042:                 THIS.this_cUltIcm = ""
10043:             ENDIF
10044: 
10045:             IF USED("cursor_4c_Icm")
10046:                 USE IN cursor_4c_Icm
10047:             ENDIF
10048:             loc_oBusca.Release()
10049:         CATCH TO loc_oErro
10050:             MsgErro("Erro ao validar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarSittricms")
10051:         ENDTRY
10052:     ENDPROC
10053: 
10054:     *--------------------------------------------------------------------------
10055:     * ValidarDsittricms - LostFocus no campo Descricao Situacao Tributaria ICMS
10056:     * Busca por descricao (so se codigo estiver vazio)
10057:     *--------------------------------------------------------------------------
10058:     PROCEDURE ValidarDsittricms()
10059:         LOCAL loc_oPg, loc_cVal
10060:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10061:         IF !PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10062:             RETURN
10063:         ENDIF
10064:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dsittricms.Value)
10065: 
10066:         IF EMPTY(loc_cVal)
10067:             RETURN
10068:         ENDIF
10069:         IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10070:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Sittricms.Value))
10071:                 RETURN
10072:             ENDIF
10073:         ENDIF
10074: 
10075:         TRY
10076:             LOCAL loc_oBusca
10077:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_IcmD", "Descricaos", loc_cVal, "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10078:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10079:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10080:             loc_oBusca.Show()
10081: 
10082:             IF loc_oBusca.this_lSelecionou
10083:                 IF USED("cursor_4c_IcmD")
10084:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10085:                         loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_IcmD.Codigos)
10086:                     ENDIF
10087:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10088:                         loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_IcmD.Descricaos)
10089:                     ENDIF
10090:                     THIS.this_cUltIcm = ALLTRIM(cursor_4c_IcmD.Codigos)
10091:                 ENDIF
10092:             ELSE
10093:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10094:                     loc_oPg.txt_4c_Dsittricms.Value = ""
10095:                 ENDIF
10096:             ENDIF
10097: 
10098:             IF USED("cursor_4c_IcmD")
10099:                 USE IN cursor_4c_IcmD
10100:             ENDIF
10101:             loc_oBusca.Release()
10102:         CATCH TO loc_oErro
10103:             MsgErro("Erro ao buscar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDsittricms")
10104:         ENDTRY
10105:     ENDPROC
10106: 
10107:     *--------------------------------------------------------------------------
10108:     * ValidarCodServs - LostFocus no campo Codigo de Servicos ICMS
10109:     * Tabela: SigCdIcm | tambem preenche getSittricm quando seleciona
10110:     *--------------------------------------------------------------------------
10111:     PROCEDURE ValidarCodServs()
10112:         LOCAL loc_oPg, loc_cVal
10113:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10114:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
10115:             RETURN
10116:         ENDIF
10117:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_CodServs.Value)
10118: 
10119:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltIcm
10120:             RETURN
10121:         ENDIF
10122:         THIS.this_cUltIcm = loc_cVal
10123: 
10124:         TRY
10125:             LOCAL loc_oBusca
10126:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_CodServ", "Codigos", loc_cVal, "C" + CHR(243) + "digo Servi" + CHR(231) + "os ICMS")
10127:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10128:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10129:             loc_oBusca.Show()
10130: 
10131:             IF loc_oBusca.this_lSelecionou
10132:                 IF USED("cursor_4c_CodServ")
10133:                     IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
10134:                         loc_oPg.txt_4c_CodServs.Value  = ALLTRIM(cursor_4c_CodServ.Codigos)
10135:                     ENDIF
10136:                     *-- Tambem preenche Sittricms (como no legado)
10137:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10138:                         loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_CodServ.Codigos)
10139:                     ENDIF
10140:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10141:                         loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_CodServ.Descricaos)
10142:                     ENDIF
10143:                     THIS.this_cUltIcm = ALLTRIM(cursor_4c_CodServ.Codigos)
10144:                 ENDIF
10145:             ELSE
10146:                 IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
10147:                     loc_oPg.txt_4c_CodServs.Value = ""
10148:                 ENDIF
10149:             ENDIF
10150: 
10151:             IF USED("cursor_4c_CodServ")
10152:                 USE IN cursor_4c_CodServ
10153:             ENDIF
10154:             loc_oBusca.Release()
10155:         CATCH TO loc_oErro
10156:             MsgErro("Erro ao validar c" + CHR(243) + "digo de servi" + CHR(231) + "os:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarCodServs")
10157:         ENDTRY
10158:     ENDPROC
10159: 
10160:     *--------------------------------------------------------------------------
10161:     * ValidarTptribs - LostFocus no campo Tipo de Tributacao
10162:     * Tabela: SigPrTri | Chave: Tipos | Desc: Descs
10163:     *--------------------------------------------------------------------------
10164:     PROCEDURE ValidarTptribs()
10165:         LOCAL loc_oPg, loc_cVal
10166:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10167:         IF !PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
10168:             RETURN
10169:         ENDIF
10170:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Tptribs.Value)
10171: 
10172:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltTptribs
10173:             RETURN
10174:         ENDIF
10175:         THIS.this_cUltTptribs = loc_cVal
10176: 
10177:         TRY
10178:             LOCAL loc_oBusca
10179:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrTri", "cursor_4c_TpTrib", "Tipos", loc_cVal, "Tipo de Tributa" + CHR(231) + CHR(227) + "o")
10180:             loc_oBusca.mAddColuna("Tipos", "", "Tipo")
10181:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10182:             loc_oBusca.Show()
10183: 
10184:             IF loc_oBusca.this_lSelecionou
10185:                 IF USED("cursor_4c_TpTrib")
10186:                     IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
10187:                         loc_oPg.txt_4c_Tptribs.Value = ALLTRIM(cursor_4c_TpTrib.Tipos)
10188:                     ENDIF
10189:                     THIS.this_cUltTptribs = ALLTRIM(cursor_4c_TpTrib.Tipos)
10190:                 ENDIF
10191:             ELSE
10192:                 IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
10193:                     loc_oPg.txt_4c_Tptribs.Value = ""
10194:                 ENDIF
10195:                 THIS.this_cUltTptribs = ""
10196:             ENDIF
10197: 
10198:             IF USED("cursor_4c_TpTrib")
10199:                 USE IN cursor_4c_TpTrib
10200:             ENDIF
10201:             loc_oBusca.Release()
10202:         CATCH TO loc_oErro
10203:             MsgErro("Erro ao validar tipo de tributa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarTptribs")
10204:         ENDTRY
10205:     ENDPROC
10206: 
10207:     *--------------------------------------------------------------------------
10208:     * ValidarIat - LostFocus no campo IAT
10209:     * Aceita apenas: 'A' (arredondamento), 'T' (truncamento) ou vazio
10210:     *--------------------------------------------------------------------------
10211:     PROCEDURE ValidarIat()
10212:         LOCAL loc_oPg, loc_cVal
10213:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10214:         IF !PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
10215:             RETURN
10216:         ENDIF
10217:         loc_cVal = UPPER(ALLTRIM(loc_oPg.txt_4c_Iat.Value))
10218: 
10219:         IF EMPTY(loc_cVal)
10220:             RETURN
10221:         ENDIF
10222: 
10223:         IF !INLIST(loc_cVal, "A", "T")
10224:             MsgAviso("Op" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida. Digite [A] Arredondamento ou [T] Truncamento!", "IAT")
10225:             IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
10226:                 loc_oPg.txt_4c_Iat.Value = ""
10227:             ENDIF
10228:         ELSE
10229:             IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
10230:                 loc_oPg.txt_4c_Iat.Value = loc_cVal
10231:             ENDIF
10232:         ENDIF
10233:     ENDPROC
10234: 
10235:     *--------------------------------------------------------------------------
10236:     * ValidarAliqIPI - LostFocus no campo Aliquota IPI
10237:     * Avisa se identica a aliquota da classificacao fiscal
10238:     *--------------------------------------------------------------------------
10239:     PROCEDURE ValidarAliqIPI()
10240:         LOCAL loc_oPg, loc_nVal, loc_cSQL, loc_nR, loc_nAliqClf
10241:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10242:         IF !PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
10243:             RETURN
10244:         ENDIF
10245:         loc_nVal = loc_oPg.txt_4c_AliqIPI.Value
10246: 
10247:         IF loc_nVal = 0
10248:             RETURN
10249:         ENDIF
10250:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10251:             RETURN
10252:         ENDIF
10253:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
10254:             RETURN
10255:         ENDIF
10256: 
10257:         TRY
10258:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10259:                 SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))>>)
10260:             ENDTEXT
10261:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliqV")
10262:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliqV")
10263:                 loc_nAliqClf = cursor_4c_ClfAliqV.aliqipis
10264:                 IF loc_nVal = loc_nAliqClf
10265:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal." + CHR(13) + "Deixe zero para utilizar a classifica" + CHR(231) + CHR(227) + "o fiscal.", "Al" + CHR(237) + "quota IPI")
10266:                 ENDIF
10267:             ENDIF
10268:             IF USED("cursor_4c_ClfAliqV")
10269:                 USE IN cursor_4c_ClfAliqV
10270:             ENDIF
10271:         CATCH TO loc_oErro
10272:             MsgErro("Erro ao validar al" + CHR(237) + "quota IPI:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarAliqIPI")
10273:         ENDTRY
10274:     ENDPROC
10275: 
10276:     *--------------------------------------------------------------------------
10277:     * ValidarMetal - LostFocus no campo Metal (codigo livre IPI)
10278:     *--------------------------------------------------------------------------
10279:     PROCEDURE ValidarMetal()
10280:         RETURN
10281:     ENDPROC
10282: 
10283:     *--------------------------------------------------------------------------
10284:     * ValidarTeor - LostFocus no campo Teor (codigo livre IPI)
10285:     *--------------------------------------------------------------------------
10286:     PROCEDURE ValidarTeor()
10287:         RETURN
10288:     ENDPROC
10289: 
10290:     *--------------------------------------------------------------------------
10291:     * ValidarMoedaEstimada - LostFocus no campo Moeda Valor Estimado
10292:     * Tabela: SigCdMoe | Chave: CMoes | Desc: DMoes
10293:     *--------------------------------------------------------------------------
10294:     PROCEDURE ValidarMoedaEstimada()
10295:         LOCAL loc_oPg, loc_cVal
10296:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10297:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
10298:             RETURN
10299:         ENDIF
10300:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Moedas.Value)
10301: 
10302:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltMoeda
10303:             RETURN
10304:         ENDIF
10305:         THIS.this_cUltMoeda = loc_cVal
10306: 
10307:         TRY
10308:             LOCAL loc_oBusca
10309:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", "cursor_4c_MoeEstim", "CMoes", loc_cVal, "Moeda")
10310:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
10311:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10312:             loc_oBusca.Show()
10313: 
10314:             IF loc_oBusca.this_lSelecionou
10315:                 IF USED("cursor_4c_MoeEstim")
10316:                     IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
10317:                         loc_oPg.txt_4c_Moedas.Value = ALLTRIM(cursor_4c_MoeEstim.CMoes)
10318:                     ENDIF
10319:                     THIS.this_cUltMoeda = ALLTRIM(cursor_4c_MoeEstim.CMoes)
10320:                 ENDIF
10321:             ELSE
10322:                 IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
10323:                     loc_oPg.txt_4c_Moedas.Value = ""
10324:                 ENDIF
10325:                 THIS.this_cUltMoeda = ""
10326:             ENDIF
10327: 
10328:             IF USED("cursor_4c_MoeEstim")
10329:                 USE IN cursor_4c_MoeEstim
10330:             ENDIF
10331:             loc_oBusca.Release()
10332:         CATCH TO loc_oErro
10333:             MsgErro("Erro ao validar moeda:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarMoedaEstimada")
10334:         ENDTRY
10335:     ENDPROC
10336: 
10337:     *--------------------------------------------------------------------------
10338:     * ValidarGruccus - LostFocus no campo Grupo Conta Corrente Custo
10339:     * Tabela: SigCdGcr | Chave: Codigos | Desc: Descrs
10340:     *--------------------------------------------------------------------------
10341:     PROCEDURE ValidarGruccus()
10342:         LOCAL loc_oPg, loc_cVal
10343:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10344:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10345:             RETURN
10346:         ENDIF
10347:         loc_cVal = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10348: 
10349:         IF EMPTY(loc_cVal)
10350:             IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10351:                 loc_oPg.txt_4c__dgruccus.Value  = ""
10352:             ENDIF
10353:             IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10354:                 loc_oPg.txt_4c__contaccus.Value = ""
10355:             ENDIF
10356:             IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10357:                 loc_oPg.txt_4c__dcontaccus.Value = ""
10358:             ENDIF
10359:             THIS.this_cUltGrupoCC = ""
10360:             RETURN
10361:         ENDIF
10362: 
10363:         IF loc_cVal = THIS.this_cUltGrupoCC
10364:             RETURN
10365:         ENDIF
10366:         THIS.this_cUltGrupoCC = loc_cVal
10367: 
10368:         TRY
10369:             LOCAL loc_oBusca
10370:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", "cursor_4c_Gcr", "Codigos", loc_cVal, "Grupo Conta Corrente")
10371:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10372:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10373:             loc_oBusca.Show()
10374: 
10375:             IF loc_oBusca.this_lSelecionou
10376:                 IF USED("cursor_4c_Gcr")
10377:                     IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10378:                         loc_oPg.txt_4c__gruccus.Value  = ALLTRIM(cursor_4c_Gcr.Codigos)
10379:                     ENDIF
10380:                     IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10381:                         loc_oPg.txt_4c__dgruccus.Value = ALLTRIM(cursor_4c_Gcr.Descrs)
10382:                     ENDIF
10383:                 ENDIF
10384:             ELSE
10385:                 IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10386:                     loc_oPg.txt_4c__gruccus.Value  = ""
10387:                 ENDIF
10388:                 IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10389:                     loc_oPg.txt_4c__dgruccus.Value = ""
10390:                 ENDIF
10391:                 IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10392:                     loc_oPg.txt_4c__contaccus.Value = ""
10393:                 ENDIF
10394:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10395:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10396:                 ENDIF
10397:                 THIS.this_cUltGrupoCC = ""
10398:             ENDIF
10399: 
10400:             IF USED("cursor_4c_Gcr")
10401:                 USE IN cursor_4c_Gcr
10402:             ENDIF
10403:             loc_oBusca.Release()
10404:         CATCH TO loc_oErro
10405:             MsgErro("Erro ao validar grupo conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarGruccus")
10406:         ENDTRY
10407:     ENDPROC
10408: 
10409:     *--------------------------------------------------------------------------
10410:     * ValidarDgruccus - LostFocus na Descricao do Grupo Conta Corrente
10411:     * Busca por descricao (so se codigo estiver vazio)
10412:     *--------------------------------------------------------------------------
10413:     PROCEDURE ValidarDgruccus()
10414:         LOCAL loc_oPg, loc_cVal
10415:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10416:         IF !PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10417:             RETURN
10418:         ENDIF
10419:         loc_cVal = ALLTRIM(loc_oPg.txt_4c__dgruccus.Value)
10420: 
10421:         IF EMPTY(loc_cVal)
10422:             RETURN
10423:         ENDIF
10424:         IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10425:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
10426:                 RETURN
10427:             ENDIF
10428:         ENDIF
10429: 
10430:         TRY
10431:             LOCAL loc_oBusca
10432:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", "cursor_4c_GcrD", "Descrs", loc_cVal, "Grupo Conta Corrente")
10433:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10434:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10435:             loc_oBusca.Show()
10436: 
10437:             IF loc_oBusca.this_lSelecionou
10438:                 IF USED("cursor_4c_GcrD")
10439:                     IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10440:                         loc_oPg.txt_4c__gruccus.Value  = ALLTRIM(cursor_4c_GcrD.Codigos)
10441:                     ENDIF
10442:                     IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10443:                         loc_oPg.txt_4c__dgruccus.Value = ALLTRIM(cursor_4c_GcrD.Descrs)
10444:                     ENDIF
10445:                     THIS.this_cUltGrupoCC = ALLTRIM(cursor_4c_GcrD.Codigos)
10446:                 ENDIF
10447:             ELSE
10448:                 IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10449:                     loc_oPg.txt_4c__dgruccus.Value = ""
10450:                 ENDIF
10451:             ENDIF
10452: 
10453:             IF USED("cursor_4c_GcrD")
10454:                 USE IN cursor_4c_GcrD
10455:             ENDIF
10456:             loc_oBusca.Release()
10457:         CATCH TO loc_oErro
10458:             MsgErro("Erro ao buscar grupo conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDgruccus")
10459:         ENDTRY
10460:     ENDPROC
10461: 
10462:     *--------------------------------------------------------------------------
10463:     * ValidarContaccus - LostFocus no campo Conta Corrente Custo
10464:     * Tabela: SigCdCli | Chave: IClis | Desc: Rclis
10465:     * So acessivel quando grupo gruccus preenchido
10466:     *--------------------------------------------------------------------------
10467:     PROCEDURE ValidarContaccus()
10468:         LOCAL loc_oPg, loc_cVal, loc_cGrupo
10469:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10470:         IF !PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10471:             RETURN
10472:         ENDIF
10473:         loc_cVal   = ALLTRIM(loc_oPg.txt_4c__contaccus.Value)
10474:         loc_cGrupo = ""
10475:         IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10476:             loc_cGrupo = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10477:         ENDIF
10478: 
10479:         *-- Grupo obrigatorio para acessar conta
10480:         IF EMPTY(loc_cGrupo)
10481:             IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10482:                 loc_oPg.txt_4c__contaccus.Value = ""
10483:             ENDIF
10484:             IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10485:                 loc_oPg.txt_4c__dcontaccus.Value = ""
10486:             ENDIF
10487:             RETURN
10488:         ENDIF
10489: 
10490:         IF EMPTY(loc_cVal)
10491:             IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10492:                 loc_oPg.txt_4c__dcontaccus.Value = ""
10493:             ENDIF
10494:             THIS.this_cUltContaCC = ""
10495:             RETURN
10496:         ENDIF
10497: 
10498:         IF loc_cVal = THIS.this_cUltContaCC
10499:             RETURN
10500:         ENDIF
10501:         THIS.this_cUltContaCC = loc_cVal
10502: 
10503:         TRY
10504:             LOCAL loc_oBusca
10505:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_ContaCC", "IClis", loc_cVal, "Conta Corrente")
10506:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10507:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10508:             loc_oBusca.Show()
10509: 
10510:             IF loc_oBusca.this_lSelecionou
10511:                 IF USED("cursor_4c_ContaCC")
10512:                     IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10513:                         loc_oPg.txt_4c__contaccus.Value  = ALLTRIM(cursor_4c_ContaCC.IClis)
10514:                     ENDIF
10515:                     IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10516:                         loc_oPg.txt_4c__dcontaccus.Value = ALLTRIM(cursor_4c_ContaCC.Rclis)
10517:                     ENDIF
10518:                 ENDIF
10519:             ELSE
10520:                 IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10521:                     loc_oPg.txt_4c__contaccus.Value  = ""
10522:                 ENDIF
10523:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10524:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10525:                 ENDIF
10526:                 THIS.this_cUltContaCC = ""
10527:             ENDIF
10528: 
10529:             IF USED("cursor_4c_ContaCC")
10530:                 USE IN cursor_4c_ContaCC
10531:             ENDIF
10532:             loc_oBusca.Release()
10533:         CATCH TO loc_oErro
10534:             MsgErro("Erro ao validar conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarContaccus")
10535:         ENDTRY
10536:     ENDPROC
10537: 
10538:     *--------------------------------------------------------------------------
10539:     * ValidarDcontaccus - LostFocus na Descricao Conta Corrente
10540:     * Busca por nome (so se codigo estiver vazio e grupo preenchido)
10541:     *--------------------------------------------------------------------------
10542:     PROCEDURE ValidarDcontaccus()
10543:         LOCAL loc_oPg, loc_cVal, loc_cGrupo
10544:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10545:         IF !PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10546:             RETURN
10547:         ENDIF
10548:         loc_cVal   = ALLTRIM(loc_oPg.txt_4c__dcontaccus.Value)
10549:         loc_cGrupo = ""
10550:         IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10551:             loc_cGrupo = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10552:         ENDIF
10553: 
10554:         IF EMPTY(loc_cVal) OR EMPTY(loc_cGrupo)
10555:             RETURN
10556:         ENDIF
10557:         IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10558:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c__contaccus.Value))
10559:                 RETURN
10560:             ENDIF
10561:         ENDIF
10562: 
10563:         TRY
10564:             LOCAL loc_oBusca
10565:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_ContaCCD", "Rclis", loc_cVal, "Conta Corrente")
10566:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10567:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10568:             loc_oBusca.Show()
10569: 
10570:             IF loc_oBusca.this_lSelecionou
10571:                 IF USED("cursor_4c_ContaCCD")
10572:                     IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10573:                         loc_oPg.txt_4c__contaccus.Value  = ALLTRIM(cursor_4c_ContaCCD.IClis)
10574:                     ENDIF
10575:                     IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10576:                         loc_oPg.txt_4c__dcontaccus.Value = ALLTRIM(cursor_4c_ContaCCD.Rclis)
10577:                     ENDIF
10578:                     THIS.this_cUltContaCC = ALLTRIM(cursor_4c_ContaCCD.IClis)
10579:                 ENDIF
10580:             ELSE
10581:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10582:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10583:                 ENDIF
10584:             ENDIF
10585: 
10586:             IF USED("cursor_4c_ContaCCD")
10587:                 USE IN cursor_4c_ContaCCD
10588:             ENDIF
10589:             loc_oBusca.Release()
10590:         CATCH TO loc_oErro
10591:             MsgErro("Erro ao buscar conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDcontaccus")
10592:         ENDTRY
10593:     ENDPROC
10594: 
10595:     *--------------------------------------------------------------------------
10596:     * TabFiscal_ExtIpiGotFocus - GotFocus no campo Excecao da TIPI
10597:     * Verifica se campo deve estar habilitado (IpiProds = 'S' em SigCdClf)
10598:     *--------------------------------------------------------------------------
10599:     PROCEDURE TabFiscal_ExtIpiGotFocus()
10600:         LOCAL loc_oPg, loc_cClf, loc_cSQL, loc_nR, loc_lHabilitar
10601:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10602:         loc_lHabilitar = .F.
10603: 
10604:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10605:             RETURN
10606:         ENDIF
10607:         loc_cClf = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
10608: 
10609:         IF EMPTY(loc_cClf)
10610:             RETURN
10611:         ENDIF
10612: 
10613:         TRY
10614:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10615:                 SELECT IpiProds FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(loc_cClf)>>)
10616:             ENDTEXT
10617:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfIpi")
10618:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfIpi")
10619:                 loc_lHabilitar = (ALLTRIM(cursor_4c_ClfIpi.IpiProds) = "S")
10620:             ENDIF
10621:             IF USED("cursor_4c_ClfIpi")
10622:                 USE IN cursor_4c_ClfIpi
10623:             ENDIF
10624:         CATCH TO loc_oErro
10625:             MsgErro("Erro ao verificar IpiProds:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFiscal_ExtIpiGotFocus")
10626:         ENDTRY
10627: 
10628:         IF !loc_lHabilitar
10629:             IF PEMSTATUS(loc_oPg, "txt_4c_Extipi", 5)
10630:                 loc_oPg.txt_4c_Extipi.ReadOnly = .T.
10631:             ENDIF
10632:         ENDIF
10633:     ENDPROC
10634: 
10635:     *--------------------------------------------------------------------------
10636:     * BtnDescFisClick - Gerar Descricao Fiscal automaticamente
10637:     * Equivalente ao legacy fGerDescFis - stub funcional
10638:     *--------------------------------------------------------------------------
10639:     PROCEDURE BtnDescFisClick()
10640:         LOCAL loc_oPg, loc_cCpros
10641:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10642:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10643: 
10644:         IF EMPTY(loc_cCpros)
10645:             MsgAviso("Selecione um produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.", "Descri" + CHR(231) + CHR(227) + "o Fiscal")
10646:             RETURN
10647:         ENDIF
10648: 
10649:         MsgAviso("Funcionalidade de gera" + CHR(231) + CHR(227) + "o autom" + CHR(225) + "tica de descri" + CHR(231) + CHR(227) + "o fiscal n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o." + CHR(13) + "Edite a descri" + CHR(231) + CHR(227) + "o fiscal diretamente no campo.", "Descri" + CHR(231) + CHR(227) + "o Fiscal")
10650:     ENDPROC
10651: 
10652:     *--------------------------------------------------------------------------
10653:     * CarregarDadosFiscais - Carrega grid CMV (custos gramas) da aba Fiscal
10654:     * Tabela: SigCdCmv | Colunas: Datas, ValCuss, Moedas
10655:     *--------------------------------------------------------------------------
10656:     PROTECTED PROCEDURE CarregarDadosFiscais()
10657:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
10658:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10659:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10660: 
10661:         IF EMPTY(loc_cCpros)
10662:             IF USED("cursor_4c_Cmv")
10663:                 ZAP IN cursor_4c_Cmv
10664:             ENDIF
10665:             IF PEMSTATUS(loc_oPg, "grd_4c_Cmv", 5)
10666:                 loc_oPg.grd_4c_Cmv.Refresh()
10667:             ENDIF
10668:             RETURN
10669:         ENDIF
10670: 
10671:         TRY
10672:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10673:                 SELECT Datas AS periodos, ValCuss AS valcustos, Moedas AS moedas
10674:                 FROM SigCdCmv
10675:                 WHERE RTRIM(Cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10676:                 ORDER BY Datas DESC
10677:             ENDTEXT
10678: 
10679:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp")
10680: 
10681:             IF USED("cursor_4c_Cmv")
10682:                 ZAP IN cursor_4c_Cmv
10683:             ENDIF
10684: 
10685:             IF loc_nR > 0
10686:                 IF !USED("cursor_4c_Cmv")
10687:                     SET NULL ON
10688:                     CREATE CURSOR cursor_4c_Cmv (periodos C(10) NULL, valcustos N(12, 2) NULL, moedas C(3) NULL)
10689:                     SET NULL OFF
10690:                 ENDIF
10691:                 IF USED("cursor_4c_CmvTemp")
10692:                     SELECT cursor_4c_Cmv
10693:                     APPEND FROM DBF("cursor_4c_CmvTemp")
10694:                 ENDIF
10695:             ENDIF
10696: 

*-- Linhas 10716 a 10911:
10716:     * BtnIniTarefaClick - Registra inicio de tarefa do Designer
10717:     * Tabela: sigprtar (cpros, dtinis, usuars)
10718:     *--------------------------------------------------------------------------
10719:     PROCEDURE BtnIniTarefaClick()
10720:         LOCAL loc_cCpros, loc_cSQL, loc_nR
10721:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10722: 
10723:         IF EMPTY(loc_cCpros)
10724:             MsgAviso("Selecione um produto antes de iniciar tarefa.", "Tarefa Designer")
10725:             RETURN
10726:         ENDIF
10727: 
10728:         TRY
10729:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10730:                 INSERT INTO sigprtar (cpros, dtinis, usuars)
10731:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<FormatarDataSQL(DATE())>>, <<EscaparSQL(gc_4c_UsuarioLogado)>>)
10732:             ENDTEXT
10733:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10734:             IF loc_nR > 0
10735:                 THIS.CarregarDesigner()
10736:             ELSE
10737:                 MsgErro("Erro ao registrar in" + CHR(237) + "cio de tarefa.", "FormProduto.BtnIniTarefaClick")
10738:             ENDIF
10739:         CATCH TO loc_oErro
10740:             MsgErro("Erro ao iniciar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnIniTarefaClick")
10741:         ENDTRY
10742:     ENDPROC
10743: 
10744:     *--------------------------------------------------------------------------
10745:     * BtnFimTarefaClick - Registra fim de tarefa do Designer
10746:     * Atualiza dtfims na ultima tarefa em aberto (dtfims IS NULL)
10747:     *--------------------------------------------------------------------------
10748:     PROCEDURE BtnFimTarefaClick()
10749:         LOCAL loc_cCpros, loc_cSQL, loc_nR
10750:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10751: 
10752:         IF EMPTY(loc_cCpros)
10753:             MsgAviso("Selecione um produto antes de finalizar tarefa.", "Tarefa Designer")
10754:             RETURN
10755:         ENDIF
10756: 
10757:         TRY
10758:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10759:                 UPDATE TOP(1) sigprtar SET dtfims = <<FormatarDataSQL(DATE())>>
10760:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10761:             ENDTEXT
10762:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10763:             IF loc_nR > 0
10764:                 THIS.CarregarDesigner()
10765:             ELSE
10766:                 MsgErro("Nenhuma tarefa em aberto para finalizar.", "FormProduto.BtnFimTarefaClick")
10767:             ENDIF
10768:         CATCH TO loc_oErro
10769:             MsgErro("Erro ao finalizar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnFimTarefaClick")
10770:         ENDTRY
10771:     ENDPROC
10772: 
10773:     *--------------------------------------------------------------------------
10774:     * BtnInsArqsClick - Insere arquivo do Designer via dialogo de arquivo
10775:     * Tabela: sigprarq (cpros, arquivos)
10776:     *--------------------------------------------------------------------------
10777:     PROCEDURE BtnInsArqsClick()
10778:         LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR
10779:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10780: 
10781:         IF EMPTY(loc_cCpros)
10782:             MsgAviso("Selecione um produto para inserir arquivo.", "Arquivos Designer")
10783:             RETURN
10784:         ENDIF
10785: 
10786:         loc_cArquivo = GETFILE("*.*", "Selecionar Arquivo para Designer")
10787:         IF EMPTY(loc_cArquivo)
10788:             RETURN
10789:         ENDIF
10790: 
10791:         TRY
10792:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10793:                 INSERT INTO sigprarq (cpros, arquivos)
10794:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<EscaparSQL(loc_cArquivo)>>)
10795:             ENDTEXT
10796:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10797:             IF loc_nR > 0
10798:                 THIS.CarregarDesigner()
10799:             ELSE
10800:                 MsgErro("Erro ao inserir arquivo.", "FormProduto.BtnInsArqsClick")
10801:             ENDIF
10802:         CATCH TO loc_oErro
10803:             MsgErro("Erro ao inserir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInsArqsClick")
10804:         ENDTRY
10805:     ENDPROC
10806: 
10807:     *--------------------------------------------------------------------------
10808:     * BtnExcArqsClick - Exclui arquivo selecionado no grid de arquivos
10809:     *--------------------------------------------------------------------------
10810:     PROCEDURE BtnExcArqsClick()
10811:         LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR
10812:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10813: 
10814:         IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
10815:             MsgAviso("Selecione um arquivo para excluir.", "Arquivos Designer")
10816:             RETURN
10817:         ENDIF
10818: 
10819:         loc_cArquivo = ALLTRIM(cursor_4c_Arquivos.arquivos)
10820: 
10821:         IF MsgConfirma("Excluir o arquivo selecionado?", "Arquivos Designer")
10822:             TRY
10823:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
10824:                     DELETE FROM sigprarq
10825:                     WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND RTRIM(arquivos) = RTRIM(<<EscaparSQL(loc_cArquivo)>>)
10826:                 ENDTEXT
10827:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10828:                 IF loc_nR > 0
10829:                     THIS.CarregarDesigner()
10830:                 ELSE
10831:                     MsgErro("Erro ao excluir arquivo.", "FormProduto.BtnExcArqsClick")
10832:                 ENDIF
10833:             CATCH TO loc_oErro
10834:                 MsgErro("Erro ao excluir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcArqsClick")
10835:             ENDTRY
10836:         ENDIF
10837:     ENDPROC
10838: 
10839:     *--------------------------------------------------------------------------
10840:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao
10841:     *--------------------------------------------------------------------------
10842:     PROCEDURE BtnOpnArqsClick()
10843:         LOCAL loc_cArquivo
10844: 
10845:         IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
10846:             MsgAviso("Selecione um arquivo para abrir.", "Arquivos Designer")
10847:             RETURN
10848:         ENDIF
10849: 
10850:         loc_cArquivo = ALLTRIM(cursor_4c_Arquivos.arquivos)
10851: 
10852:         IF EMPTY(loc_cArquivo)
10853:             MsgAviso("Caminho do arquivo n" + CHR(227) + "o informado.", "Arquivos Designer")
10854:             RETURN
10855:         ENDIF
10856: 
10857:         TRY
10858:             DECLARE INTEGER ShellExecute IN "Shell32.dll" ;
10859:                 INTEGER hwnd, STRING lpOperation, STRING lpFile, ;
10860:                 STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
10861:             ShellExecute(0, "open", loc_cArquivo, "", "", 1)
10862:         CATCH TO loc_oErro
10863:             MsgErro("Erro ao abrir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnOpnArqsClick")
10864:         ENDTRY
10865:     ENDPROC
10866: 
10867:     *--------------------------------------------------------------------------
10868:     * CarregarDesigner - Carrega grids de tarefas e arquivos do Designer (Tab 5)
10869:     * Tabelas: sigprtar (tarefas), sigprarq (arquivos)
10870:     *--------------------------------------------------------------------------
10871:     PROTECTED PROCEDURE CarregarDesigner()
10872:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
10873:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10874:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
10875: 
10876:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
10877:             RETURN
10878:         ENDIF
10879: 
10880:         TRY
10881:             *-- Tarefas do Designer
10882:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10883:                 SELECT dtinis, dtfims, usuars, tarefas
10884:                 FROM sigprtar
10885:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10886:                 ORDER BY dtinis DESC
10887:             ENDTEXT
10888:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesignerTmp")
10889:             IF loc_nR > 0
10890:                 IF USED("cursor_4c_Designer")
10891:                     SELECT cursor_4c_Designer
10892:                     ZAP
10893:                     APPEND FROM DBF("cursor_4c_DesignerTmp")
10894:                 ENDIF
10895:                 IF USED("cursor_4c_DesignerTmp")
10896:                     USE IN cursor_4c_DesignerTmp
10897:                 ENDIF
10898:                 IF PEMSTATUS(loc_oPg, "grd_4c_Designer", 5)
10899:                     loc_oPg.grd_4c_Designer.Refresh()
10900:                 ENDIF
10901:             ENDIF
10902: 
10903:             *-- Arquivos do Designer
10904:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10905:                 SELECT arquivos FROM sigprarq
10906:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10907:                 ORDER BY arquivos
10908:             ENDTEXT
10909:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArquivosTmp")
10910:             IF loc_nR > 0
10911:                 IF USED("cursor_4c_Arquivos")

*-- Linhas 10950 a 12052:
10950:     * Salvar: habilitado apenas em INCLUIR e ALTERAR
10951:     * Cancelar: sempre habilitado em Page2
10952:     *--------------------------------------------------------------------------
10953:     PROCEDURE AjustarBotoesPorModo()
10954:         LOCAL loc_oBotoesDados, loc_lEmEdicao
10955:         loc_oBotoesDados = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados
10956:         loc_lEmEdicao    = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10957: 
10958:         TRY
10959:             IF PEMSTATUS(loc_oBotoesDados, "cmd_4c_Salvar", 5)
10960:                 loc_oBotoesDados.cmd_4c_Salvar.Enabled = loc_lEmEdicao
10961:             ENDIF
10962:             IF PEMSTATUS(loc_oBotoesDados, "cmd_4c_Cancelar", 5)
10963:                 loc_oBotoesDados.cmd_4c_Cancelar.Enabled = .T.
10964:             ENDIF
10965:         CATCH TO loc_oErro
10966:             MsgErro(loc_oErro.Message, "FormProduto.AjustarBotoesPorModo")
10967:         ENDTRY
10968:     ENDPROC
10969: 
10970:     *--------------------------------------------------------------------------
10971:     * CompoGrd_AfterRowColChange - Grid composicao: ao mover linha/coluna
10972:     * Atualiza campos Get_Desc e getObsOFs com dados da linha atual
10973:     *--------------------------------------------------------------------------
10974:     PROCEDURE CompoGrd_AfterRowColChange(par_nColIndex)
10975:         LOCAL loc_oPg
10976:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
10977: 
10978:         TRY
10979:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
10980:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
10981:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(NVL(cursor_4c_Compo.dcompos, ""))
10982:                 ENDIF
10983:             ENDIF
10984:         CATCH TO loc_oErro
10985:             MsgErro(loc_oErro.Message, "FormProduto.CompoGrd_AfterRowColChange")
10986:         ENDTRY
10987:     ENDPROC
10988: 
10989:     *--------------------------------------------------------------------------
10990:     * SubCompoGrd_AfterRowColChange - Grid sub-componente: ao mover linha
10991:     * Atualiza campos get_desccp e get_matsub com dados da linha atual
10992:     *--------------------------------------------------------------------------
10993:     PROCEDURE SubCompoGrd_AfterRowColChange(par_nColIndex)
10994:         LOCAL loc_oPg
10995:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
10996: 
10997:         TRY
10998:             IF USED("cursor_4c_SubCompo") AND !EOF("cursor_4c_SubCompo")
10999:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11000:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(NVL(cursor_4c_SubCompo.dcompos, ""))
11001:                 ENDIF
11002:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11003:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(NVL(cursor_4c_SubCompo.matsubs, ""))
11004:                 ENDIF
11005:             ENDIF
11006:         CATCH TO loc_oErro
11007:             MsgErro(loc_oErro.Message, "FormProduto.SubCompoGrd_AfterRowColChange")
11008:         ENDTRY
11009:     ENDPROC
11010: 
11011:     *--------------------------------------------------------------------------
11012:     * ChkLiberaCustoClick - Checkbox liberar custo: habilita/desabilita campos
11013:     *--------------------------------------------------------------------------
11014:     PROCEDURE ChkLiberaCustoClick()
11015:         LOCAL loc_oPg, loc_lLibera
11016:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11017:         loc_lLibera = .F.
11018: 
11019:         TRY
11020:             IF PEMSTATUS(loc_oPg, "chk_4c_ChkLiberaCusto", 5)
11021:                 loc_lLibera = (loc_oPg.chk_4c_ChkLiberaCusto.Value = 1)
11022:             ENDIF
11023:             IF PEMSTATUS(loc_oPg, "txt_4c_Pcus", 5)
11024:                 loc_oPg.txt_4c_Pcus.ReadOnly     = !loc_lLibera
11025:             ENDIF
11026:             IF PEMSTATUS(loc_oPg, "txt_4c_PcusMoe", 5)
11027:                 loc_oPg.txt_4c_PcusMoe.ReadOnly  = !loc_lLibera
11028:             ENDIF
11029:             IF PEMSTATUS(loc_oPg, "txt_4c_Fcusto", 5)
11030:                 loc_oPg.txt_4c_Fcusto.ReadOnly   = !loc_lLibera
11031:             ENDIF
11032:             IF PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
11033:                 loc_oPg.txt_4c_Cmkpc.ReadOnly    = !loc_lLibera
11034:             ENDIF
11035:         CATCH TO loc_oErro
11036:             MsgErro(loc_oErro.Message, "FormProduto.ChkLiberaCustoClick")
11037:         ENDTRY
11038:     ENDPROC
11039: 
11040:     *--------------------------------------------------------------------------
11041:     * ChkLiberaVendaClick - Checkbox liberar venda: habilita/desabilita campos
11042:     *--------------------------------------------------------------------------
11043:     PROCEDURE ChkLiberaVendaClick()
11044:         LOCAL loc_oPg, loc_lLibera
11045:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11046:         loc_lLibera = .F.
11047: 
11048:         TRY
11049:             IF PEMSTATUS(loc_oPg, "chk_4c_ChkLiberaVenda", 5)
11050:                 loc_lLibera = (loc_oPg.chk_4c_ChkLiberaVenda.Value = 1)
11051:             ENDIF
11052:             IF PEMSTATUS(loc_oPg, "txt_4c_Margem", 5)
11053:                 loc_oPg.txt_4c_Margem.ReadOnly   = !loc_lLibera
11054:             ENDIF
11055:             IF PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
11056:                 loc_oPg.txt_4c_Moeda.ReadOnly    = !loc_lLibera
11057:             ENDIF
11058:             IF PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
11059:                 loc_oPg.txt_4c_Ftio.ReadOnly     = !loc_lLibera
11060:             ENDIF
11061:             IF PEMSTATUS(loc_oPg, "txt_4c_Fvenda", 5)
11062:                 loc_oPg.txt_4c_Fvenda.ReadOnly   = !loc_lLibera
11063:             ENDIF
11064:             IF PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
11065:                 loc_oPg.txt_4c_Moepv.ReadOnly    = !loc_lLibera
11066:             ENDIF
11067:             IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
11068:                 loc_oPg.txt_4c_Moev.ReadOnly     = !loc_lLibera
11069:             ENDIF
11070:         CATCH TO loc_oErro
11071:             MsgErro(loc_oErro.Message, "FormProduto.ChkLiberaVendaClick")
11072:         ENDTRY
11073:     ENDPROC
11074: 
11075:     *--------------------------------------------------------------------------
11076:     * ChkPvendaClick - Checkbox usar preco ideal: aplica preco ideal ao preco venda
11077:     *--------------------------------------------------------------------------
11078:     PROCEDURE ChkPvendaClick()
11079:         LOCAL loc_oPg, loc_nPvideal, loc_nEncarg
11080:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11081: 
11082:         TRY
11083:             IF PEMSTATUS(loc_oPg, "txt_4c_Pvideal", 5)
11084:                 loc_nPvideal = loc_oPg.txt_4c_Pvideal.Value
11085:             ELSE
11086:                 loc_nPvideal = 0
11087:             ENDIF
11088:             IF PEMSTATUS(loc_oPg, "txt_4c_Encarg", 5)
11089:                 loc_nEncarg = loc_oPg.txt_4c_Encarg.Value
11090:             ELSE
11091:                 loc_nEncarg = 1
11092:             ENDIF
11093:             IF loc_nEncarg = 0
11094:                 loc_nEncarg = 1
11095:             ENDIF
11096:             IF PEMSTATUS(loc_oPg, "txt_4c_Pven", 5)
11097:                 loc_oPg.txt_4c_Pven.Value = loc_nPvideal / loc_nEncarg
11098:             ENDIF
11099:             IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5) AND PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
11100:                 loc_oPg.txt_4c_Moev.Value = loc_oPg.txt_4c_Moeda.Value
11101:             ENDIF
11102:         CATCH TO loc_oErro
11103:             MsgErro(loc_oErro.Message, "FormProduto.ChkPvendaClick")
11104:         ENDTRY
11105:     ENDPROC
11106: 
11107:     *--------------------------------------------------------------------------
11108:     * TabCompo_MoecLostFocus - LostFocus de txt_4c_PcusMoe (getMoec)
11109:     * Valida codigo de moeda de custo - lookup em SigCdMoe
11110:     *--------------------------------------------------------------------------
11111:     PROCEDURE TabCompo_MoecLostFocus()
11112:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11113:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11114:         loc_lResultado = .T.
11115: 
11116:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11117:             RETURN
11118:         ENDIF
11119: 
11120:         TRY
11121:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_PcusMoe", 5)
11122:                 RETURN
11123:             ENDIF
11124:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_PcusMoe.Value)
11125:             IF EMPTY(loc_cCod)
11126:                 RETURN
11127:             ENDIF
11128: 
11129:             gb_4c_ValidandoUI = .T.
11130:             loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11131:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecTmp")
11132:             gb_4c_ValidandoUI = .F.
11133: 
11134:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecTmp")
11135:                 *-- Nao encontrou: abre lookup
11136:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11137:                 loc_oForm.Caption = "Moedas"
11138:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11139:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11140:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11141:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11142:                 loc_oForm.Show()
11143:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11144:                     loc_oPg.txt_4c_PcusMoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11145:                     USE IN cursor_4c_BuscaAux
11146:                 ELSE
11147:                     loc_oPg.txt_4c_PcusMoe.Value = ""
11148:                 ENDIF
11149:                 loc_oForm.Release()
11150:             ENDIF
11151:             IF USED("cursor_4c_MoecTmp")
11152:                 USE IN cursor_4c_MoecTmp
11153:             ENDIF
11154:         CATCH TO loc_oErro
11155:             gb_4c_ValidandoUI = .F.
11156:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecLostFocus")
11157:         ENDTRY
11158:     ENDPROC
11159: 
11160:     *--------------------------------------------------------------------------
11161:     * TabCompo_MoecusfLostFocus - LostFocus de txt_4c_MoecusFoe (getMoecusf)
11162:     * Valida codigo de moeda de custo com feitio - lookup em SigCdMoe
11163:     *--------------------------------------------------------------------------
11164:     PROCEDURE TabCompo_MoecusfLostFocus()
11165:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11166:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11167: 
11168:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11169:             RETURN
11170:         ENDIF
11171: 
11172:         TRY
11173:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_MoecusFoe", 5)
11174:                 RETURN
11175:             ENDIF
11176:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_MoecusFoe.Value)
11177:             IF EMPTY(loc_cCod)
11178:                 RETURN
11179:             ENDIF
11180: 
11181:             gb_4c_ValidandoUI = .T.
11182:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11183:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecusfTmp")
11184:             gb_4c_ValidandoUI = .F.
11185: 
11186:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecusfTmp")
11187:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11188:                 loc_oForm.Caption = "Moedas"
11189:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11190:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11191:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11192:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11193:                 loc_oForm.Show()
11194:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11195:                     loc_oPg.txt_4c_MoecusFoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11196:                     USE IN cursor_4c_BuscaAux
11197:                 ELSE
11198:                     loc_oPg.txt_4c_MoecusFoe.Value = ""
11199:                 ENDIF
11200:                 loc_oForm.Release()
11201:             ENDIF
11202:             IF USED("cursor_4c_MoecusfTmp")
11203:                 USE IN cursor_4c_MoecusfTmp
11204:             ENDIF
11205:         CATCH TO loc_oErro
11206:             gb_4c_ValidandoUI = .F.
11207:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecusfLostFocus")
11208:         ENDTRY
11209:     ENDPROC
11210: 
11211:     *--------------------------------------------------------------------------
11212:     * TabCompo_MoedaLostFocus - LostFocus de txt_4c_Moeda (getMoeda)
11213:     * Valida moeda de venda - lookup em SigCdMoe
11214:     *--------------------------------------------------------------------------
11215:     PROCEDURE TabCompo_MoedaLostFocus()
11216:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11217:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11218: 
11219:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11220:             RETURN
11221:         ENDIF
11222: 
11223:         TRY
11224:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
11225:                 RETURN
11226:             ENDIF
11227:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
11228:             IF EMPTY(loc_cCod)
11229:                 RETURN
11230:             ENDIF
11231: 
11232:             gb_4c_ValidandoUI = .T.
11233:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11234:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaTmp")
11235:             gb_4c_ValidandoUI = .F.
11236: 
11237:             IF loc_nR <= 0 OR EOF("cursor_4c_MoedaTmp")
11238:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11239:                 loc_oForm.Caption = "Moedas"
11240:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11241:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11242:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11243:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11244:                 loc_oForm.Show()
11245:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11246:                     loc_oPg.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11247:                     USE IN cursor_4c_BuscaAux
11248:                 ELSE
11249:                     loc_oPg.txt_4c_Moeda.Value = ""
11250:                 ENDIF
11251:                 loc_oForm.Release()
11252:             ENDIF
11253:             IF USED("cursor_4c_MoedaTmp")
11254:                 USE IN cursor_4c_MoedaTmp
11255:             ENDIF
11256:         CATCH TO loc_oErro
11257:             gb_4c_ValidandoUI = .F.
11258:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoedaLostFocus")
11259:         ENDTRY
11260:     ENDPROC
11261: 
11262:     *--------------------------------------------------------------------------
11263:     * TabCompo_MoepvLostFocus - LostFocus de txt_4c_Moepv (getMoepv)
11264:     * Valida moeda do preco de venda - lookup em SigCdMoe
11265:     *--------------------------------------------------------------------------
11266:     PROCEDURE TabCompo_MoepvLostFocus()
11267:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11268:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11269: 
11270:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11271:             RETURN
11272:         ENDIF
11273: 
11274:         TRY
11275:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
11276:                 RETURN
11277:             ENDIF
11278:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moepv.Value)
11279:             IF EMPTY(loc_cCod)
11280:                 RETURN
11281:             ENDIF
11282: 
11283:             gb_4c_ValidandoUI = .T.
11284:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11285:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoepvTmp")
11286:             gb_4c_ValidandoUI = .F.
11287: 
11288:             IF loc_nR <= 0 OR EOF("cursor_4c_MoepvTmp")
11289:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11290:                 loc_oForm.Caption = "Moedas"
11291:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11292:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11293:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11294:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11295:                 loc_oForm.Show()
11296:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11297:                     loc_oPg.txt_4c_Moepv.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11298:                     USE IN cursor_4c_BuscaAux
11299:                 ELSE
11300:                     loc_oPg.txt_4c_Moepv.Value = ""
11301:                 ENDIF
11302:                 loc_oForm.Release()
11303:             ENDIF
11304:             IF USED("cursor_4c_MoepvTmp")
11305:                 USE IN cursor_4c_MoepvTmp
11306:             ENDIF
11307:         CATCH TO loc_oErro
11308:             gb_4c_ValidandoUI = .F.
11309:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoepvLostFocus")
11310:         ENDTRY
11311:     ENDPROC
11312: 
11313:     *--------------------------------------------------------------------------
11314:     * TabCompo_MoevLostFocus - LostFocus de txt_4c_Moev (getMoev)
11315:     * Valida moeda do valor de venda - lookup em SigCdMoe
11316:     *--------------------------------------------------------------------------
11317:     PROCEDURE TabCompo_MoevLostFocus()
11318:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11319:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11320: 
11321:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11322:             RETURN
11323:         ENDIF
11324: 
11325:         TRY
11326:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
11327:                 RETURN
11328:             ENDIF
11329:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moev.Value)
11330:             IF EMPTY(loc_cCod)
11331:                 RETURN
11332:             ENDIF
11333: 
11334:             gb_4c_ValidandoUI = .T.
11335:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11336:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoevTmp")
11337:             gb_4c_ValidandoUI = .F.
11338: 
11339:             IF loc_nR <= 0 OR EOF("cursor_4c_MoevTmp")
11340:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11341:                 loc_oForm.Caption = "Moedas"
11342:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11343:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11344:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11345:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11346:                 loc_oForm.Show()
11347:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11348:                     loc_oPg.txt_4c_Moev.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11349:                     USE IN cursor_4c_BuscaAux
11350:                 ELSE
11351:                     loc_oPg.txt_4c_Moev.Value = ""
11352:                 ENDIF
11353:                 loc_oForm.Release()
11354:             ENDIF
11355:             IF USED("cursor_4c_MoevTmp")
11356:                 USE IN cursor_4c_MoevTmp
11357:             ENDIF
11358:         CATCH TO loc_oErro
11359:             gb_4c_ValidandoUI = .F.
11360:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoevLostFocus")
11361:         ENDTRY
11362:     ENDPROC
11363: 
11364:     *--------------------------------------------------------------------------
11365:     * TabCompo_FtioLostFocus - LostFocus de txt_4c_Ftio (Getftio)
11366:     * Valida codigo de feitio de venda - lookup em SigPrFti (Tipos<>1)
11367:     *--------------------------------------------------------------------------
11368:     PROCEDURE TabCompo_FtioLostFocus()
11369:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11370:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11371: 
11372:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11373:             RETURN
11374:         ENDIF
11375: 
11376:         TRY
11377:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
11378:                 RETURN
11379:             ENDIF
11380:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ftio.Value)
11381:             IF EMPTY(loc_cCod)
11382:                 THIS.CarregarComposicao()
11383:                 RETURN
11384:             ENDIF
11385: 
11386:             gb_4c_ValidandoUI = .T.
11387:             loc_cSQL = "SELECT Cods, Descs, Acrescs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos<>1"
11388:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtioTmp")
11389:             gb_4c_ValidandoUI = .F.
11390: 
11391:             IF loc_nR <= 0 OR EOF("cursor_4c_FtioTmp")
11392:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11393:                 loc_oForm.Caption = "Feitios"
11394:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11395:                 loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
11396:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11397:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos<>1 ORDER BY Cods"
11398:                 loc_oForm.Show()
11399:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11400:                     loc_oPg.txt_4c_Ftio.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11401:                     USE IN cursor_4c_BuscaAux
11402:                 ELSE
11403:                     loc_oPg.txt_4c_Ftio.Value = ""
11404:                     IF USED("cursor_4c_FtioTmp")
11405:                         USE IN cursor_4c_FtioTmp
11406:                     ENDIF
11407:                     THIS.CarregarComposicao()
11408:                     RETURN
11409:                 ENDIF
11410:                 loc_oForm.Release()
11411:             ENDIF
11412:             IF USED("cursor_4c_FtioTmp")
11413:                 USE IN cursor_4c_FtioTmp
11414:             ENDIF
11415:             THIS.CarregarComposicao()
11416:         CATCH TO loc_oErro
11417:             gb_4c_ValidandoUI = .F.
11418:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_FtioLostFocus")
11419:         ENDTRY
11420:     ENDPROC
11421: 
11422:     *--------------------------------------------------------------------------
11423:     * TabCompo_CmkpcLostFocus - LostFocus de txt_4c_Cmkpc (Get_cmkpc)
11424:     * Valida codigo de feitio de custo - lookup em SigPrFti (Tipos=1)
11425:     *--------------------------------------------------------------------------
11426:     PROCEDURE TabCompo_CmkpcLostFocus()
11427:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11428:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11429: 
11430:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11431:             RETURN
11432:         ENDIF
11433: 
11434:         TRY
11435:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
11436:                 RETURN
11437:             ENDIF
11438:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cmkpc.Value)
11439:             IF EMPTY(loc_cCod)
11440:                 THIS.CarregarComposicao()
11441:                 RETURN
11442:             ENDIF
11443: 
11444:             gb_4c_ValidandoUI = .T.
11445:             loc_cSQL = "SELECT Cods, Descs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos=1"
11446:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmkpcTmp")
11447:             gb_4c_ValidandoUI = .F.
11448: 
11449:             IF loc_nR <= 0 OR EOF("cursor_4c_CmkpcTmp")
11450:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11451:                 loc_oForm.Caption = "Feitios de Custo"
11452:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11453:                 loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
11454:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11455:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos=1 ORDER BY Cods"
11456:                 loc_oForm.Show()
11457:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11458:                     loc_oPg.txt_4c_Cmkpc.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11459:                     USE IN cursor_4c_BuscaAux
11460:                 ELSE
11461:                     loc_oPg.txt_4c_Cmkpc.Value = ""
11462:                     IF USED("cursor_4c_CmkpcTmp")
11463:                         USE IN cursor_4c_CmkpcTmp
11464:                     ENDIF
11465:                     THIS.CarregarComposicao()
11466:                     RETURN
11467:                 ENDIF
11468:                 loc_oForm.Release()
11469:             ENDIF
11470:             IF USED("cursor_4c_CmkpcTmp")
11471:                 USE IN cursor_4c_CmkpcTmp
11472:             ENDIF
11473:             THIS.CarregarComposicao()
11474:         CATCH TO loc_oErro
11475:             gb_4c_ValidandoUI = .F.
11476:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_CmkpcLostFocus")
11477:         ENDTRY
11478:     ENDPROC
11479: 
11480:     *--------------------------------------------------------------------------
11481:     * TabCompo_StatusLostFocus - LostFocus de txt_4c_Status (getStatus)
11482:     * Atualiza composicao apos mudanca de status
11483:     *--------------------------------------------------------------------------
11484:     PROCEDURE TabCompo_StatusLostFocus()
11485:         TRY
11486:             THIS.CarregarComposicao()
11487:         CATCH TO loc_oErro
11488:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_StatusLostFocus")
11489:         ENDTRY
11490:     ENDPROC
11491: 
11492:     *--------------------------------------------------------------------------
11493:     * TabCompo_MargemLostFocus - LostFocus de txt_4c_Margem (getMargem)
11494:     * Recalcula preco de venda ao mudar margem/markup
11495:     *--------------------------------------------------------------------------
11496:     PROCEDURE TabCompo_MargemLostFocus()
11497:         TRY
11498:             THIS.CarregarComposicao()
11499:         CATCH TO loc_oErro
11500:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MargemLostFocus")
11501:         ENDTRY
11502:     ENDPROC
11503: 
11504:     *--------------------------------------------------------------------------
11505:     * TabCompo_FvendaLostFocus - LostFocus de txt_4c_Fvenda (getFvenda)
11506:     * Recalcula preco de venda ao mudar fator
11507:     *--------------------------------------------------------------------------
11508:     PROCEDURE TabCompo_FvendaLostFocus()
11509:         TRY
11510:             THIS.CarregarComposicao()
11511:         CATCH TO loc_oErro
11512:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_FvendaLostFocus")
11513:         ENDTRY
11514:     ENDPROC
11515: 
11516:     *--------------------------------------------------------------------------
11517:     * TabCompo_DescLostFocus - LostFocus de txt_4c_Desc (Get_Desc)
11518:     * Valida/atualiza descricao do material de composicao
11519:     *--------------------------------------------------------------------------
11520:     PROCEDURE TabCompo_DescLostFocus()
11521:         LOCAL loc_oPg, loc_cDesc, loc_oForm, loc_nR, loc_cSQL
11522:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11523: 
11524:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11525:             RETURN
11526:         ENDIF
11527: 
11528:         TRY
11529:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11530:                 RETURN
11531:             ENDIF
11532:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Desc.Value)
11533:             IF EMPTY(loc_cDesc)
11534:                 RETURN
11535:             ENDIF
11536: 
11537:             gb_4c_ValidandoUI = .T.
11538:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11539:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTmp")
11540:             gb_4c_ValidandoUI = .F.
11541: 
11542:             IF loc_nR <= 0 OR EOF("cursor_4c_DescTmp")
11543:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11544:                 loc_oForm.Caption = "Produtos"
11545:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11546:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11547:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11548:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11549:                 loc_oForm.Show()
11550:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11551:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11552:                     IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11553:                         loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11554:                     ENDIF
11555:                     USE IN cursor_4c_BuscaAux
11556:                 ELSE
11557:                     loc_oPg.txt_4c_Desc.Value = ""
11558:                 ENDIF
11559:                 loc_oForm.Release()
11560:             ELSE
11561:                 IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11562:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_DescTmp.CPros)
11563:                 ENDIF
11564:             ENDIF
11565:             IF USED("cursor_4c_DescTmp")
11566:                 USE IN cursor_4c_DescTmp
11567:             ENDIF
11568:         CATCH TO loc_oErro
11569:             gb_4c_ValidandoUI = .F.
11570:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_DescLostFocus")
11571:         ENDTRY
11572:     ENDPROC
11573: 
11574:     *--------------------------------------------------------------------------
11575:     * TabCompo_MatPLostFocus - LostFocus de txt_4c_MatP (Get_MatP)
11576:     * Valida codigo de material principal - lookup em SigCdPro
11577:     *--------------------------------------------------------------------------
11578:     PROCEDURE TabCompo_MatPLostFocus()
11579:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11580:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11581: 
11582:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11583:             RETURN
11584:         ENDIF
11585: 
11586:         TRY
11587:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11588:                 RETURN
11589:             ENDIF
11590:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_MatP.Value)
11591:             IF EMPTY(loc_cCod)
11592:                 RETURN
11593:             ENDIF
11594: 
11595:             gb_4c_ValidandoUI = .T.
11596:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11597:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatPTmp")
11598:             gb_4c_ValidandoUI = .F.
11599: 
11600:             IF loc_nR <= 0 OR EOF("cursor_4c_MatPTmp")
11601:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11602:                 loc_oForm.Caption = "Material Principal"
11603:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11604:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11605:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11606:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11607:                 loc_oForm.Show()
11608:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11609:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11610:                     IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11611:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11612:                     ENDIF
11613:                     USE IN cursor_4c_BuscaAux
11614:                 ELSE
11615:                     loc_oPg.txt_4c_MatP.Value = ""
11616:                 ENDIF
11617:                 loc_oForm.Release()
11618:             ELSE
11619:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11620:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_MatPTmp.DPros)
11621:                 ENDIF
11622:             ENDIF
11623:             IF USED("cursor_4c_MatPTmp")
11624:                 USE IN cursor_4c_MatPTmp
11625:             ENDIF
11626:         CATCH TO loc_oErro
11627:             gb_4c_ValidandoUI = .F.
11628:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MatPLostFocus")
11629:         ENDTRY
11630:     ENDPROC
11631: 
11632:     *--------------------------------------------------------------------------
11633:     * TabCompo_DesccpLostFocus - LostFocus de txt_4c__desccp (get_desccp)
11634:     * Valida descricao de sub-componente - lookup em SigCdPro
11635:     *--------------------------------------------------------------------------
11636:     PROCEDURE TabCompo_DesccpLostFocus()
11637:         LOCAL loc_oPg, loc_cDesc, loc_oForm, loc_nR, loc_cSQL
11638:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11639: 
11640:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11641:             RETURN
11642:         ENDIF
11643: 
11644:         TRY
11645:             IF NOT PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11646:                 RETURN
11647:             ENDIF
11648:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c__desccp.Value)
11649:             IF EMPTY(loc_cDesc)
11650:                 RETURN
11651:             ENDIF
11652: 
11653:             gb_4c_ValidandoUI = .T.
11654:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11655:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesccpTmp")
11656:             gb_4c_ValidandoUI = .F.
11657: 
11658:             IF loc_nR <= 0 OR EOF("cursor_4c_DesccpTmp")
11659:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11660:                 loc_oForm.Caption = "Sub-Componentes"
11661:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11662:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11663:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11664:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11665:                 loc_oForm.Show()
11666:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11667:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11668:                     IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11669:                         loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11670:                     ENDIF
11671:                     USE IN cursor_4c_BuscaAux
11672:                 ELSE
11673:                     loc_oPg.txt_4c__desccp.Value = ""
11674:                 ENDIF
11675:                 loc_oForm.Release()
11676:             ELSE
11677:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11678:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_DesccpTmp.CPros)
11679:                 ENDIF
11680:             ENDIF
11681:             IF USED("cursor_4c_DesccpTmp")
11682:                 USE IN cursor_4c_DesccpTmp
11683:             ENDIF
11684:         CATCH TO loc_oErro
11685:             gb_4c_ValidandoUI = .F.
11686:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_DesccpLostFocus")
11687:         ENDTRY
11688:     ENDPROC
11689: 
11690:     *--------------------------------------------------------------------------
11691:     * TabCompo_MatsubLostFocus - LostFocus de txt_4c__matsub (get_matsub)
11692:     * Valida codigo do substituto - lookup em SigCdPro
11693:     *--------------------------------------------------------------------------
11694:     PROCEDURE TabCompo_MatsubLostFocus()
11695:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11696:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11697: 
11698:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11699:             RETURN
11700:         ENDIF
11701: 
11702:         TRY
11703:             IF NOT PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11704:                 RETURN
11705:             ENDIF
11706:             loc_cCod = ALLTRIM(loc_oPg.txt_4c__matsub.Value)
11707:             IF EMPTY(loc_cCod)
11708:                 RETURN
11709:             ENDIF
11710: 
11711:             gb_4c_ValidandoUI = .T.
11712:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11713:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatsubTmp")
11714:             gb_4c_ValidandoUI = .F.
11715: 
11716:             IF loc_nR <= 0 OR EOF("cursor_4c_MatsubTmp")
11717:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11718:                 loc_oForm.Caption = "Produto Substituto"
11719:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11720:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11721:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11722:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11723:                 loc_oForm.Show()
11724:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11725:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11726:                     IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11727:                         loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11728:                     ENDIF
11729:                     USE IN cursor_4c_BuscaAux
11730:                 ELSE
11731:                     loc_oPg.txt_4c__matsub.Value = ""
11732:                 ENDIF
11733:                 loc_oForm.Release()
11734:             ELSE
11735:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11736:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_MatsubTmp.DPros)
11737:                 ENDIF
11738:             ENDIF
11739:             IF USED("cursor_4c_MatsubTmp")
11740:                 USE IN cursor_4c_MatsubTmp
11741:             ENDIF
11742:         CATCH TO loc_oErro
11743:             gb_4c_ValidandoUI = .F.
11744:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MatsubLostFocus")
11745:         ENDTRY
11746:     ENDPROC
11747: 
11748:     *--------------------------------------------------------------------------
11749:     * CmdCompoIncluirClick - Botao incluir linha na composicao (grdCompo)
11750:     *--------------------------------------------------------------------------
11751:     PROCEDURE CmdCompoIncluirClick()
11752:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
11753:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11754:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11755: 
11756:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11757:             RETURN
11758:         ENDIF
11759:         IF EMPTY(loc_cCpros)
11760:             RETURN
11761:         ENDIF
11762: 
11763:         TRY
11764:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves) VALUES (" + ;
11765:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID())"
11766:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11767:             IF loc_nR > 0
11768:                 THIS.CarregarComposicao()
11769:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
11770:                     loc_oPg.grd_4c_Compo.SetFocus()
11771:                 ENDIF
11772:             ELSE
11773:                 MsgErro("Erro ao incluir linha na composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoIncluirClick")
11774:             ENDIF
11775:         CATCH TO loc_oErro
11776:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoIncluirClick")
11777:         ENDTRY
11778:     ENDPROC
11779: 
11780:     *--------------------------------------------------------------------------
11781:     * CmdCompoExcluirClick - Botao excluir linha da composicao (grdCompo)
11782:     *--------------------------------------------------------------------------
11783:     PROCEDURE CmdCompoExcluirClick()
11784:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg
11785:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11786:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11787: 
11788:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11789:             RETURN
11790:         ENDIF
11791:         IF NOT USED("cursor_4c_Compo") OR EOF("cursor_4c_Compo")
11792:             RETURN
11793:         ENDIF
11794: 
11795:         TRY
11796:             loc_cMats = ALLTRIM(NVL(cursor_4c_Compo.mats, ""))
11797:             IF EMPTY(loc_cMats)
11798:                 RETURN
11799:             ENDIF
11800:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11801:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11802:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11803:             IF loc_nR > 0
11804:                 THIS.CarregarComposicao()
11805:             ELSE
11806:                 MsgErro("Erro ao excluir linha da composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoExcluirClick")
11807:             ENDIF
11808:         CATCH TO loc_oErro
11809:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoExcluirClick")
11810:         ENDTRY
11811:     ENDPROC
11812: 
11813:     *--------------------------------------------------------------------------
11814:     * CmdCompoAtualizarClick - Botao atualizar/recalcular precos da composicao
11815:     *--------------------------------------------------------------------------
11816:     PROCEDURE CmdCompoAtualizarClick()
11817:         TRY
11818:             THIS.CarregarComposicao()
11819:         CATCH TO loc_oErro
11820:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoAtualizarClick")
11821:         ENDTRY
11822:     ENDPROC
11823: 
11824:     *--------------------------------------------------------------------------
11825:     * CmdCompoAtuPesosClick - Botao atualizar pesos da composicao
11826:     *--------------------------------------------------------------------------
11827:     PROCEDURE CmdCompoAtuPesosClick()
11828:         TRY
11829:             THIS.CarregarComposicao()
11830:         CATCH TO loc_oErro
11831:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoAtuPesosClick")
11832:         ENDTRY
11833:     ENDPROC
11834: 
11835:     *--------------------------------------------------------------------------
11836:     * CmdCompoRecalcClick - Botao recalcular todos os precos
11837:     *--------------------------------------------------------------------------
11838:     PROCEDURE CmdCompoRecalcClick()
11839:         TRY
11840:             THIS.CarregarComposicao()
11841:         CATCH TO loc_oErro
11842:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoRecalcClick")
11843:         ENDTRY
11844:     ENDPROC
11845: 
11846:     *--------------------------------------------------------------------------
11847:     * CmdSubCpIncluirClick - Botao incluir sub-componente (grdsubcp)
11848:     *--------------------------------------------------------------------------
11849:     PROCEDURE CmdSubCpIncluirClick()
11850:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg
11851:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11852:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11853: 
11854:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11855:             RETURN
11856:         ENDIF
11857:         IF EMPTY(loc_cCpros)
11858:             RETURN
11859:         ENDIF
11860:         IF NOT USED("cursor_4c_Compo") OR EOF("cursor_4c_Compo")
11861:             MsgErro("Selecione um item na composi" + CHR(231) + CHR(227) + "o principal primeiro.", "FormProduto.CmdSubCpIncluirClick")
11862:             RETURN
11863:         ENDIF
11864: 
11865:         TRY
11866:             loc_cMats = ALLTRIM(NVL(cursor_4c_Compo.mats, ""))
11867:             IF EMPTY(loc_cMats)
11868:                 MsgErro("Item da composi" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido.", "FormProduto.CmdSubCpIncluirClick")
11869:                 RETURN
11870:             ENDIF
11871:             loc_cSQL = "INSERT INTO sigsubcp (cpros, dtmovs, cidchaves, matsubs) VALUES (" + ;
11872:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + EscaparSQL(loc_cMats) + ")"
11873:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11874:             IF loc_nR > 0
11875:                 THIS.CarregarComposicao()
11876:                 IF PEMSTATUS(loc_oPg, "grd_4c_SubCompo", 5)
11877:                     loc_oPg.grd_4c_SubCompo.SetFocus()
11878:                 ENDIF
11879:             ELSE
11880:                 MsgErro("Erro ao incluir sub-componente.", "FormProduto.CmdSubCpIncluirClick")
11881:             ENDIF
11882:         CATCH TO loc_oErro
11883:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpIncluirClick")
11884:         ENDTRY
11885:     ENDPROC
11886: 
11887:     *--------------------------------------------------------------------------
11888:     * CmdSubCpExcluirClick - Botao excluir sub-componente (grdsubcp)
11889:     *--------------------------------------------------------------------------
11890:     PROCEDURE CmdSubCpExcluirClick()
11891:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR
11892:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11893: 
11894:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11895:             RETURN
11896:         ENDIF
11897:         IF NOT USED("cursor_4c_SubCompo") OR EOF("cursor_4c_SubCompo")
11898:             RETURN
11899:         ENDIF
11900: 
11901:         TRY
11902:             loc_cMats = ALLTRIM(NVL(cursor_4c_SubCompo.mats, ""))
11903:             IF EMPTY(loc_cMats)
11904:                 RETURN
11905:             ENDIF
11906:             loc_cSQL = "DELETE FROM sigsubcp WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11907:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11908:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11909:             IF loc_nR > 0
11910:                 THIS.CarregarComposicao()
11911:             ELSE
11912:                 MsgErro("Erro ao excluir sub-componente.", "FormProduto.CmdSubCpExcluirClick")
11913:             ENDIF
11914:         CATCH TO loc_oErro
11915:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpExcluirClick")
11916:         ENDTRY
11917:     ENDPROC
11918: 
11919:     *--------------------------------------------------------------------------
11920:     * CmdCalcValsClick - Botao calcular valores de preco/custo
11921:     *--------------------------------------------------------------------------
11922:     PROCEDURE CmdCalcValsClick()
11923:         TRY
11924:             THIS.CarregarComposicao()
11925:         CATCH TO loc_oErro
11926:             MsgErro(loc_oErro.Message, "FormProduto.CmdCalcValsClick")
11927:         ENDTRY
11928:     ENDPROC
11929: 
11930:     *--------------------------------------------------------------------------
11931:     * CmdPesoMClick - Botao calcular/atualizar peso medio
11932:     *--------------------------------------------------------------------------
11933:     PROCEDURE CmdPesoMClick()
11934:         LOCAL loc_oPg, loc_cCpros, loc_cSQL, loc_nR
11935:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11936:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11937: 
11938:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
11939:             RETURN
11940:         ENDIF
11941: 
11942:         TRY
11943:             *-- Busca peso calculado a partir da composicao
11944:             loc_cSQL = "SELECT SUM(c.qtds * p.pesobs) AS peso_calc " + ;
11945:                        "FROM SIGPRCPO c " + ;
11946:                        "LEFT JOIN SigCdPro p ON RTRIM(c.mats) = RTRIM(p.cpros) " + ;
11947:                        "WHERE RTRIM(c.cpros) = " + EscaparSQL(loc_cCpros)
11948:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesoMTmp")
11949:             IF loc_nR > 0 AND !EOF("cursor_4c_PesoMTmp")
11950:                 IF PEMSTATUS(loc_oPg, "txt_4c_Pesom", 5)
11951:                     loc_oPg.txt_4c_Pesom.Value = NVL(cursor_4c_PesoMTmp.peso_calc, 0)
11952:                 ENDIF
11953:             ENDIF
11954:             IF USED("cursor_4c_PesoMTmp")
11955:                 USE IN cursor_4c_PesoMTmp
11956:             ENDIF
11957:         CATCH TO loc_oErro
11958:             MsgErro(loc_oErro.Message, "FormProduto.CmdPesoMClick")
11959:         ENDTRY
11960:     ENDPROC
11961: 
11962:     *--------------------------------------------------------------------------
11963:     * CustosGrd_AfterRowColChange - Grid custos: ao mudar linha/coluna
11964:     * Atualiza campos txt_4c_DescCusto e txt_4c_DGruCompos com dados do item
11965:     *--------------------------------------------------------------------------
11966:     PROCEDURE CustosGrd_AfterRowColChange(par_nColIndex)
11967:         LOCAL loc_oPg, loc_cMats, loc_cSQL, loc_nR
11968:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11969: 
11970:         TRY
11971:             IF USED("cursor_4c_CompoCusto") AND !EOF("cursor_4c_CompoCusto")
11972:                 *-- Atualizar campo Descricao
11973:                 IF PEMSTATUS(loc_oPg, "txt_4c_DescCusto", 5)
11974:                     loc_oPg.txt_4c_DescCusto.Value = ALLTRIM(NVL(cursor_4c_CompoCusto.dcompos, ""))
11975:                 ENDIF
11976: 
11977:                 *-- Buscar descricao do grupo com base no material
11978:                 loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))
11979:                 IF !EMPTY(loc_cMats) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
11980:                     loc_cSQL = "SELECT g.dgrus FROM SigCdPro p " + ;
11981:                                "INNER JOIN SigCdGrp g ON RTRIM(p.cgrus) = RTRIM(g.cgrus) " + ;
11982:                                "WHERE RTRIM(p.cpros) = " + EscaparSQL(loc_cMats)
11983:                     gb_4c_ValidandoUI = .T.
11984:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoTmpC")
11985:                     gb_4c_ValidandoUI = .F.
11986:                     IF loc_nR > 0 AND !EOF("cursor_4c_GrupoTmpC")
11987:                         IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
11988:                             loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(NVL(cursor_4c_GrupoTmpC.dgrus, ""))
11989:                         ENDIF
11990:                     ENDIF
11991:                     IF USED("cursor_4c_GrupoTmpC")
11992:                         USE IN cursor_4c_GrupoTmpC
11993:                     ENDIF
11994:                 ELSE
11995:                     IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
11996:                         loc_oPg.txt_4c_DGruCompos.Value = ""
11997:                     ENDIF
11998:                 ENDIF
11999:             ENDIF
12000:         CATCH TO loc_oErro
12001:             gb_4c_ValidandoUI = .F.
12002:             MsgErro(loc_oErro.Message, "FormProduto.CustosGrd_AfterRowColChange")
12003:         ENDTRY
12004:     ENDPROC
12005: 
12006:     *--------------------------------------------------------------------------
12007:     * ConsultaGrd_AfterRowColChange - Grid GrdCons consulta: ao sair de coluna
12008:     * Col4 (Fase/Grupos): busca descricao em SigCdPrf; se nao encontrado abre lookup
12009:     * Col5 (Descricao fase): busca grupos em SigCdPrf por descricao
12010:     * Col8 (Cat): busca descricao em SigCdCat; se nao encontrado abre lookup
12011:     *--------------------------------------------------------------------------
12012:     PROCEDURE ConsultaGrd_AfterRowColChange(par_nColIndex)
12013:         LOCAL loc_oPg, loc_cSQL, loc_nR, loc_cGrupos, loc_cCats, loc_cDcompos
12014:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
12015: 
12016:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
12017:             RETURN
12018:         ENDIF
12019: 
12020:         IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
12021:             RETURN
12022:         ENDIF
12023: 
12024:         TRY
12025:             DO CASE
12026: 
12027:             *-- Coluna 4 (Fase/Grupos): busca descricao da fase em SigCdPrf
12028:             CASE par_nColIndex = 4
12029:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
12030:                 IF !EMPTY(loc_cGrupos)
12031:                     loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = " + EscaparSQL(loc_cGrupos)
12032:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfDesc")
12033:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfDesc")
12034:                         REPLACE cursor_4c_Consulta.dcompos WITH ALLTRIM(NVL(cursor_4c_PrfDesc.descrs, ""))
12035:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12036:                             loc_oPg.grd_4c_Consulta.Refresh()
12037:                         ENDIF
12038:                     ELSE
12039:                         THIS.AbrirLookupConsultaFase()
12040:                     ENDIF
12041:                     IF USED("cursor_4c_PrfDesc")
12042:                         USE IN cursor_4c_PrfDesc
12043:                     ENDIF
12044:                 ENDIF
12045: 
12046:             *-- Coluna 5 (Descricao fase): busca grupos em SigCdPrf por descricao
12047:             CASE par_nColIndex = 5
12048:                 loc_cDcompos = ALLTRIM(NVL(cursor_4c_Consulta.dcompos, ""))
12049:                 IF !EMPTY(loc_cDcompos)
12050:                     loc_cSQL = "SELECT TOP 1 Codigos AS grupos, Descrs AS descrs FROM SigCdGcr WHERE RTRIM(Descrs) = " + EscaparSQL(loc_cDcompos)
12051:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfGrp")
12052:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfGrp")

*-- Linhas 12089 a 12322:
12089:     *--------------------------------------------------------------------------
12090:     * AbrirLookupConsultaFase - Abre lookup SigCdPrf para selecionar fase (col 4)
12091:     *--------------------------------------------------------------------------
12092:     PROCEDURE AbrirLookupConsultaFase()
12093:         LOCAL loc_oPg, loc_oBusca, loc_cGrupos, loc_cDescrs
12094: 
12095:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
12096: 
12097:         TRY
12098:             IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
12099:                 RETURN
12100:             ENDIF
12101: 
12102:             loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
12103:             loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPrf", "cursor_4c_PrfSel", "grupos", loc_cGrupos, "Selecionar Fase")
12104:             loc_oBusca.mAddColuna("grupos", "", "C" + CHR(243) + "digo")
12105:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
12106:             loc_oBusca.Show()
12107: 
12108:             IF loc_oBusca.this_lSelecionou
12109:                 IF USED("cursor_4c_PrfSel")
12110:                     loc_cGrupos = ALLTRIM(NVL(cursor_4c_PrfSel.grupos, ""))
12111:                     loc_cDescrs = ALLTRIM(NVL(cursor_4c_PrfSel.descrs, ""))
12112:                     REPLACE cursor_4c_Consulta.grupos  WITH loc_cGrupos
12113:                     REPLACE cursor_4c_Consulta.dcompos WITH loc_cDescrs
12114:                     IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12115:                         loc_oPg.grd_4c_Consulta.Refresh()
12116:                     ENDIF
12117:                 ENDIF
12118:             ELSE
12119:                 REPLACE cursor_4c_Consulta.grupos  WITH ""
12120:                 REPLACE cursor_4c_Consulta.dcompos WITH ""
12121:             ENDIF
12122: 
12123:             IF USED("cursor_4c_PrfSel")
12124:                 USE IN cursor_4c_PrfSel
12125:             ENDIF
12126:             loc_oBusca.Release()
12127:             loc_oBusca = .NULL.
12128: 
12129:         CATCH TO loc_oErro
12130:             MsgErro(loc_oErro.Message, "FormProduto.AbrirLookupConsultaFase")
12131:         ENDTRY
12132:     ENDPROC
12133: 
12134:     *--------------------------------------------------------------------------
12135:     * AbrirLookupConsultaCat - Abre lookup SigCdCat para selecionar categoria (col 8)
12136:     *--------------------------------------------------------------------------
12137:     PROCEDURE AbrirLookupConsultaCat()
12138:         LOCAL loc_oPg, loc_oBusca, loc_cCods, loc_cDescs
12139: 
12140:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
12141: 
12142:         TRY
12143:             IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
12144:                 RETURN
12145:             ENDIF
12146: 
12147:             loc_cCods  = ALLTRIM(NVL(cursor_4c_Consulta.cats, ""))
12148:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCat", "cursor_4c_CatSel", "cods", loc_cCods, "Selecionar Categoria")
12149:             loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
12150:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
12151:             loc_oBusca.Show()
12152: 
12153:             IF loc_oBusca.this_lSelecionou
12154:                 IF USED("cursor_4c_CatSel")
12155:                     loc_cCods  = ALLTRIM(NVL(cursor_4c_CatSel.cods,  ""))
12156:                     loc_cDescs = ALLTRIM(NVL(cursor_4c_CatSel.descs, ""))
12157:                     REPLACE cursor_4c_Consulta.cats   WITH loc_cCods
12158:                     REPLACE cursor_4c_Consulta.dscgrp WITH loc_cDescs
12159:                     IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12160:                         loc_oPg.grd_4c_Consulta.Refresh()
12161:                     ENDIF
12162:                 ENDIF
12163:             ELSE
12164:                 REPLACE cursor_4c_Consulta.cats   WITH ""
12165:                 REPLACE cursor_4c_Consulta.dscgrp WITH ""
12166:             ENDIF
12167: 
12168:             IF USED("cursor_4c_CatSel")
12169:                 USE IN cursor_4c_CatSel
12170:             ENDIF
12171:             loc_oBusca.Release()
12172:             loc_oBusca = .NULL.
12173: 
12174:         CATCH TO loc_oErro
12175:             MsgErro(loc_oErro.Message, "FormProduto.AbrirLookupConsultaCat")
12176:         ENDTRY
12177:     ENDPROC
12178: 
12179:     *--------------------------------------------------------------------------
12180:     * CmbTiposCustoValid - ComboBox tipo custo: ao mudar selecao, recarrega grid
12181:     *--------------------------------------------------------------------------
12182:     PROCEDURE CmbTiposCustoValid()
12183:         TRY
12184:             THIS.CarregarCustos()
12185:         CATCH TO loc_oErro
12186:             MsgErro(loc_oErro.Message, "FormProduto.CmbTiposCustoValid")
12187:         ENDTRY
12188:     ENDPROC
12189: 
12190:     *--------------------------------------------------------------------------
12191:     * CmdCustoIncluirClick - Botao incluir linha no grid de custo
12192:     * Insere novo registro em SIGPRCPO com Tipos = valor selecionado no combo
12193:     *--------------------------------------------------------------------------
12194:     PROCEDURE CmdCustoIncluirClick()
12195:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_nTipo
12196:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
12197:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12198: 
12199:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12200:             RETURN
12201:         ENDIF
12202:         IF EMPTY(loc_cCpros)
12203:             RETURN
12204:         ENDIF
12205: 
12206:         TRY
12207:             loc_nTipo = 1
12208:             IF PEMSTATUS(loc_oPg, "cmb_4c_TiposCusto", 5)
12209:                 loc_nTipo = NVL(loc_oPg.cmb_4c_TiposCusto.ListIndex, 1)
12210:                 *-- ListIndex 1=Todos: usar tipo 1; demais: usar o proprio valor
12211:                 IF loc_nTipo < 1
12212:                     loc_nTipo = 1
12213:                 ENDIF
12214:             ENDIF
12215: 
12216:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves, tipos) VALUES (" + ;
12217:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + TRANSFORM(loc_nTipo) + ")"
12218:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12219:             IF loc_nR > 0
12220:                 THIS.CarregarCustos()
12221:                 IF PEMSTATUS(loc_oPg, "grd_4c_CompoCusto", 5)
12222:                     loc_oPg.grd_4c_CompoCusto.SetFocus()
12223:                 ENDIF
12224:             ELSE
12225:                 MsgErro("Erro ao incluir linha no custo.", "FormProduto.CmdCustoIncluirClick")
12226:             ENDIF
12227:         CATCH TO loc_oErro
12228:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoIncluirClick")
12229:         ENDTRY
12230:     ENDPROC
12231: 
12232:     *--------------------------------------------------------------------------
12233:     * CmdCustoExcluirClick - Botao excluir linha do grid de custo
12234:     * Remove registro de SIGPRCPO com base no material selecionado
12235:     *--------------------------------------------------------------------------
12236:     PROCEDURE CmdCustoExcluirClick()
12237:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg, loc_lConfirma
12238:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
12239:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12240: 
12241:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12242:             RETURN
12243:         ENDIF
12244:         IF NOT USED("cursor_4c_CompoCusto") OR EOF("cursor_4c_CompoCusto")
12245:             RETURN
12246:         ENDIF
12247: 
12248:         TRY
12249:             loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))
12250: 
12251:             IF EMPTY(loc_cMats)
12252:                 MsgAviso("Selecione um item para excluir.", "FormProduto")
12253:                 RETURN
12254:             ENDIF
12255: 
12256:             loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do item '" + loc_cMats + "'?", "FormProduto")
12257:             IF !loc_lConfirma
12258:                 RETURN
12259:             ENDIF
12260: 
12261:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCpros) + ;
12262:                        " AND RTRIM(mats) = " + EscaparSQL(loc_cMats)
12263:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12264:             IF loc_nR > 0
12265:                 THIS.CarregarCustos()
12266:             ELSE
12267:                 MsgErro("Erro ao excluir linha do custo.", "FormProduto.CmdCustoExcluirClick")
12268:             ENDIF
12269:         CATCH TO loc_oErro
12270:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoExcluirClick")
12271:         ENDTRY
12272:     ENDPROC
12273: 
12274:     *==========================================================================
12275:     * METODOS DA ABA FASES (Tab 7 - PgDadosFaseP)
12276:     *==========================================================================
12277: 
12278:     *--------------------------------------------------------------------------
12279:     * GrdFasesAfterRowColChange - Atualiza imagem + descricao ao navegar no grid
12280:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
12281:     *--------------------------------------------------------------------------
12282:     PROCEDURE GrdFasesAfterRowColChange
12283:         LPARAMETERS par_nColIndex
12284:         LOCAL loc_oPg, loc_cCpros, loc_cGrupos, loc_cSQL, loc_nR, loc_cArquivo
12285:         LOCAL loc_nOrdems
12286: 
12287:         TRY
12288:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12289:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12290: 
12291:             IF EMPTY(loc_cCpros) OR !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases") OR BOF("cursor_4c_Fases")
12292:                 RETURN
12293:             ENDIF
12294: 
12295:             loc_cGrupos  = ALLTRIM(NVL(cursor_4c_Fases.grupos, ""))
12296:             loc_nOrdems  = NVL(cursor_4c_Fases.ordems, 0)
12297: 
12298:             *-- Limpar imagem anterior
12299:             IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
12300:                 loc_oPg.img_4c_ImgFigJpg.Picture = ""
12301:                 loc_oPg.img_4c_ImgFigJpg.Visible = .F.
12302:             ENDIF
12303: 
12304:             *-- Carregar imagem FigProcs da fase atual (campo binario em SigCdPrf)
12305:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND loc_nOrdems > 0
12306:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
12307:                     SELECT TOP 1 FigProcs FROM SigCdPrf
12308:                     WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12309:                     AND ordems = <<loc_nOrdems>>
12310:                 ENDTEXT
12311:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigFase")
12312:                 IF loc_nR > 0 AND !EOF("cursor_4c_FigFase")
12313:                     IF !EMPTY(NVL(cursor_4c_FigFase.FigProcs, ""))
12314:                         loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12315:                         IF (STRTOFILE(cursor_4c_FigFase.FigProcs, loc_cArquivo) > 0)
12316:                             IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5) AND FILE(loc_cArquivo)
12317:                                 loc_oPg.img_4c_ImgFigJpg.Picture = loc_cArquivo
12318:                                 loc_oPg.img_4c_ImgFigJpg.Visible = .T.
12319:                             ENDIF
12320:                         ENDIF
12321:                     ENDIF
12322:                 ENDIF

*-- Linhas 12359 a 12404:
12359: 
12360:     *--------------------------------------------------------------------------
12361:     * GrdMatrizesAfterRowColChange - Atualiza imagem ao navegar no grid de matrizes
12362:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
12363:     *--------------------------------------------------------------------------
12364:     PROCEDURE GrdMatrizesAfterRowColChange
12365:         LPARAMETERS par_nColIndex
12366:         LOCAL loc_oPg, loc_cCmats, loc_cSQL, loc_nR, loc_cArquivo, loc_cFigB64
12367: 
12368:         TRY
12369:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12370: 
12371:             *-- Limpar imagem anterior
12372:             IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5)
12373:                 loc_oPg.img_4c_ImgBorracha.Picture = ""
12374:                 loc_oPg.img_4c_ImgBorracha.Visible = .F.
12375:             ENDIF
12376: 
12377:             IF !USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes") OR BOF("cursor_4c_Matrizes")
12378:                 RETURN
12379:             ENDIF
12380: 
12381:             loc_cCmats = ALLTRIM(NVL(cursor_4c_Matrizes.cmats, ""))
12382:             IF EMPTY(loc_cCmats) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
12383:                 RETURN
12384:             ENDIF
12385: 
12386:             *-- Carregar imagem FigJpgs do produto matriz (SigCdPro)
12387:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12388:                 SELECT TOP 1 FigJpgs FROM SigCdPro WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
12389:             ENDTEXT
12390:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigBorr")
12391:             IF loc_nR > 0 AND !EOF("cursor_4c_FigBorr")
12392:                 loc_cFigB64 = NVL(cursor_4c_FigBorr.FigJpgs, "")
12393:                 IF !EMPTY(loc_cFigB64)
12394:                     *-- Converter de Base64 para binario
12395:                     LOCAL loc_cFigBin
12396:                     loc_cFigBin = STRCONV( ;
12397:                         STRTRAN(STRTRAN(STRTRAN(loc_cFigB64, ;
12398:                             "data:image/png;base64,", ""), ;
12399:                             "data:image/jpeg;base64,", ""), ;
12400:                             "data:image/jpg;base64,", ""), 14)
12401:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12402:                     IF STRTOFILE(loc_cFigBin, loc_cArquivo) > 0
12403:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
12404:                             loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo

*-- Linhas 12419 a 13141:
12419:     *--------------------------------------------------------------------------
12420:     * ImgFigJpgClick - Clique na imagem da fase: abre zoom
12421:     *--------------------------------------------------------------------------
12422:     PROCEDURE ImgFigJpgClick()
12423:         LOCAL loc_oPg, loc_cArquivo
12424:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12425:         IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
12426:             loc_cArquivo = loc_oPg.img_4c_ImgFigJpg.Picture
12427:             IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
12428:                 MsgInfo("Zoom de imagem: " + loc_cArquivo, "Imagem da Fase")
12429:             ENDIF
12430:         ENDIF
12431:     ENDPROC
12432: 
12433:     *--------------------------------------------------------------------------
12434:     * TabFases_CodcorsKeyPress - F4 no campo Cor (aba Fases) abre lookup
12435:     *--------------------------------------------------------------------------
12436:     PROCEDURE TabFases_CodcorsKeyPress
12437:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12438:         IF par_nKeyCode = 115
12439:             THIS.AbrirLookupCorFas()
12440:         ENDIF
12441:     ENDPROC
12442: 
12443:     *--------------------------------------------------------------------------
12444:     * TabFases_CodcorsLostFocus - LostFocus valida cor na aba Fases
12445:     *--------------------------------------------------------------------------
12446:     PROCEDURE TabFases_CodcorsLostFocus()
12447:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12448:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12449:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodcorsFas", 5)
12450:             RETURN
12451:         ENDIF
12452:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodcorsFas.Value)
12453:         IF loc_cCod == THIS.this_cUltCorFas
12454:             RETURN
12455:         ENDIF
12456:         THIS.this_cUltCorFas = loc_cCod
12457:         IF EMPTY(loc_cCod)
12458:             RETURN
12459:         ENDIF
12460:         TRY
12461:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12462:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
12463:             ENDTEXT
12464:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCorFas")
12465:             IF loc_nR <= 0 OR EOF("cursor_4c_VCorFas")
12466:                 THIS.AbrirLookupCorFas()
12467:             ELSE
12468:                 THIS.this_oBusinessObject.this_cCodcors = loc_cCod
12469:             ENDIF
12470:             IF USED("cursor_4c_VCorFas")
12471:                 USE IN cursor_4c_VCorFas
12472:             ENDIF
12473:         CATCH TO loc_oErro
12474:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodcorsLostFocus")
12475:         ENDTRY
12476:     ENDPROC
12477: 
12478:     *--------------------------------------------------------------------------
12479:     * AbrirLookupCorFas - Lookup Cor para a aba Fases
12480:     * Atualiza Page7 e Page1 (campos sincronizados)
12481:     *--------------------------------------------------------------------------
12482:     PROTECTED PROCEDURE AbrirLookupCorFas()
12483:         LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
12484:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12485:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
12486:         loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodcorsFas.Value), "")
12487: 
12488:         TRY
12489:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", "cursor_4c_CorFas", "cods", loc_cVal, "Selecionar Cor")
12490:             loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
12491:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
12492:             loc_oBusca.Show()
12493: 
12494:             IF loc_oBusca.this_lSelecionou
12495:                 IF USED("cursor_4c_CorFas")
12496:                     LOCAL loc_cCodSel
12497:                     loc_cCodSel = ALLTRIM(cursor_4c_CorFas.cods)
12498:                     IF PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5)
12499:                         loc_oPg7.txt_4c_CodcorsFas.Value = loc_cCodSel
12500:                     ENDIF
12501:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Codcors", 5)
12502:                         loc_oPg1.txt_4c_Codcors.Value = loc_cCodSel
12503:                     ENDIF
12504:                     THIS.this_oBusinessObject.this_cCodcors = loc_cCodSel
12505:                 ENDIF
12506:             ELSE
12507:                 IF PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5)
12508:                     loc_oPg7.txt_4c_CodcorsFas.Value = ""
12509:                 ENDIF
12510:             ENDIF
12511: 
12512:             IF USED("cursor_4c_CorFas")
12513:                 USE IN cursor_4c_CorFas
12514:             ENDIF
12515:             loc_oBusca.Release()
12516:         CATCH TO loc_oErro
12517:             MsgErro("Erro no lookup de cor (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupCorFas")
12518:         ENDTRY
12519:     ENDPROC
12520: 
12521:     *--------------------------------------------------------------------------
12522:     * TabFases_CodtamsKeyPress - F4 no campo Tamanho (aba Fases) abre lookup
12523:     *--------------------------------------------------------------------------
12524:     PROCEDURE TabFases_CodtamsKeyPress
12525:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12526:         IF par_nKeyCode = 115
12527:             THIS.AbrirLookupTamanhoFas()
12528:         ENDIF
12529:     ENDPROC
12530: 
12531:     *--------------------------------------------------------------------------
12532:     * TabFases_CodtamsLostFocus - LostFocus valida tamanho na aba Fases
12533:     *--------------------------------------------------------------------------
12534:     PROCEDURE TabFases_CodtamsLostFocus()
12535:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12536:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12537:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodtamsFas", 5)
12538:             RETURN
12539:         ENDIF
12540:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodtamsFas.Value)
12541:         IF loc_cCod == THIS.this_cUltTamFas
12542:             RETURN
12543:         ENDIF
12544:         THIS.this_cUltTamFas = loc_cCod
12545:         IF EMPTY(loc_cCod)
12546:             RETURN
12547:         ENDIF
12548:         TRY
12549:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12550:                 SELECT TOP 1 Cods FROM SigCdTam WHERE Cods = <<EscaparSQL(loc_cCod)>>
12551:             ENDTEXT
12552:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VTamFas")
12553:             IF loc_nR <= 0 OR EOF("cursor_4c_VTamFas")
12554:                 THIS.AbrirLookupTamanhoFas()
12555:             ELSE
12556:                 THIS.this_oBusinessObject.this_cCodtams = loc_cCod
12557:             ENDIF
12558:             IF USED("cursor_4c_VTamFas")
12559:                 USE IN cursor_4c_VTamFas
12560:             ENDIF
12561:         CATCH TO loc_oErro
12562:             MsgErro("Erro ao validar tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodtamsLostFocus")
12563:         ENDTRY
12564:     ENDPROC
12565: 
12566:     *--------------------------------------------------------------------------
12567:     * AbrirLookupTamanhoFas - Lookup Tamanho para a aba Fases
12568:     *--------------------------------------------------------------------------
12569:     PROTECTED PROCEDURE AbrirLookupTamanhoFas()
12570:         LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
12571:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12572:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
12573:         loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodtamsFas.Value), "")
12574: 
12575:         TRY
12576:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_TamFas", "Cods", loc_cVal, "Selecionar Tamanho")
12577:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
12578:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
12579:             loc_oBusca.Show()
12580: 
12581:             IF loc_oBusca.this_lSelecionou
12582:                 IF USED("cursor_4c_TamFas")
12583:                     LOCAL loc_cCodSel
12584:                     loc_cCodSel = ALLTRIM(cursor_4c_TamFas.Cods)
12585:                     IF PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5)
12586:                         loc_oPg7.txt_4c_CodtamsFas.Value = loc_cCodSel
12587:                     ENDIF
12588:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Codtams", 5)
12589:                         loc_oPg1.txt_4c_Codtams.Value = loc_cCodSel
12590:                     ENDIF
12591:                     THIS.this_oBusinessObject.this_cCodtams = loc_cCodSel
12592:                 ENDIF
12593:             ELSE
12594:                 IF PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5)
12595:                     loc_oPg7.txt_4c_CodtamsFas.Value = ""
12596:                 ENDIF
12597:             ENDIF
12598: 
12599:             IF USED("cursor_4c_TamFas")
12600:                 USE IN cursor_4c_TamFas
12601:             ENDIF
12602:             loc_oBusca.Release()
12603:         CATCH TO loc_oErro
12604:             MsgErro("Erro no lookup de tamanho (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupTamanhoFas")
12605:         ENDTRY
12606:     ENDPROC
12607: 
12608:     *--------------------------------------------------------------------------
12609:     * TabFases_CodacbsKeyPress - F4 no campo Acabamento (aba Fases) abre lookup
12610:     *--------------------------------------------------------------------------
12611:     PROCEDURE TabFases_CodacbsKeyPress
12612:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12613:         IF par_nKeyCode = 115
12614:             THIS.AbrirLookupAcabamentoFas()
12615:         ENDIF
12616:     ENDPROC
12617: 
12618:     *--------------------------------------------------------------------------
12619:     * TabFases_CodacbsLostFocus - LostFocus valida acabamento na aba Fases
12620:     *--------------------------------------------------------------------------
12621:     PROCEDURE TabFases_CodacbsLostFocus()
12622:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12623:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12624:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodacbsFas", 5)
12625:             RETURN
12626:         ENDIF
12627:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodacbsFas.Value)
12628:         IF loc_cCod == THIS.this_cUltAcbFas
12629:             RETURN
12630:         ENDIF
12631:         THIS.this_cUltAcbFas = loc_cCod
12632:         IF EMPTY(loc_cCod)
12633:             IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
12634:                 loc_oPg.txt_4c_DacbsFas.Value = ""
12635:             ENDIF
12636:             RETURN
12637:         ENDIF
12638:         TRY
12639:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12640:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
12641:             ENDTEXT
12642:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcbFas")
12643:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcbFas")
12644:                 IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
12645:                     loc_oPg.txt_4c_DacbsFas.Value = ALLTRIM(cursor_4c_VAcbFas.descrs)
12646:                 ENDIF
12647:                 THIS.this_oBusinessObject.this_cCodacbs = loc_cCod
12648:             ELSE
12649:                 THIS.AbrirLookupAcabamentoFas()
12650:             ENDIF
12651:             IF USED("cursor_4c_VAcbFas")
12652:                 USE IN cursor_4c_VAcbFas
12653:             ENDIF
12654:         CATCH TO loc_oErro
12655:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodacbsLostFocus")
12656:         ENDTRY
12657:     ENDPROC
12658: 
12659:     *--------------------------------------------------------------------------
12660:     * AbrirLookupAcabamentoFas - Lookup Acabamento para a aba Fases
12661:     *--------------------------------------------------------------------------
12662:     PROTECTED PROCEDURE AbrirLookupAcabamentoFas()
12663:         LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
12664:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12665:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
12666:         loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodacbsFas.Value), "")
12667: 
12668:         TRY
12669:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", "cursor_4c_AcbFas", "cods", loc_cVal, "Selecionar Acabamento")
12670:             loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
12671:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
12672:             loc_oBusca.Show()
12673: 
12674:             IF loc_oBusca.this_lSelecionou
12675:                 IF USED("cursor_4c_AcbFas")
12676:                     LOCAL loc_cCodSel, loc_cDescSel
12677:                     loc_cCodSel  = ALLTRIM(cursor_4c_AcbFas.cods)
12678:                     loc_cDescSel = ALLTRIM(cursor_4c_AcbFas.descrs)
12679:                     IF PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5)
12680:                         loc_oPg7.txt_4c_CodacbsFas.Value = loc_cCodSel
12681:                     ENDIF
12682:                     IF PEMSTATUS(loc_oPg7, "txt_4c_DacbsFas", 5)
12683:                         loc_oPg7.txt_4c_DacbsFas.Value = loc_cDescSel
12684:                     ENDIF
12685:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Codacbs", 5)
12686:                         loc_oPg1.txt_4c_Codacbs.Value = loc_cCodSel
12687:                     ENDIF
12688:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Dcodacbs", 5)
12689:                         loc_oPg1.txt_4c_Dcodacbs.Value = loc_cDescSel
12690:                     ENDIF
12691:                     THIS.this_oBusinessObject.this_cCodacbs = loc_cCodSel
12692:                 ENDIF
12693:             ELSE
12694:                 IF PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5)
12695:                     loc_oPg7.txt_4c_CodacbsFas.Value = ""
12696:                 ENDIF
12697:                 IF PEMSTATUS(loc_oPg7, "txt_4c_DacbsFas", 5)
12698:                     loc_oPg7.txt_4c_DacbsFas.Value = ""
12699:                 ENDIF
12700:             ENDIF
12701: 
12702:             IF USED("cursor_4c_AcbFas")
12703:                 USE IN cursor_4c_AcbFas
12704:             ENDIF
12705:             loc_oBusca.Release()
12706:         CATCH TO loc_oErro
12707:             MsgErro("Erro no lookup de acabamento (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupAcabamentoFas")
12708:         ENDTRY
12709:     ENDPROC
12710: 
12711:     *--------------------------------------------------------------------------
12712:     * TabFases_ConquilhaKeyPress - F4 no campo Conquilha abre lookup
12713:     *--------------------------------------------------------------------------
12714:     PROCEDURE TabFases_ConquilhaKeyPress
12715:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12716:         IF par_nKeyCode = 115
12717:             THIS.AbrirLookupConquilha()
12718:         ENDIF
12719:     ENDPROC
12720: 
12721:     *--------------------------------------------------------------------------
12722:     * TabFases_ConquilhaLostFocus - LostFocus valida conquilha
12723:     *--------------------------------------------------------------------------
12724:     PROCEDURE TabFases_ConquilhaLostFocus()
12725:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12726:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12727:         IF !PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
12728:             RETURN
12729:         ENDIF
12730:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value)
12731:         IF loc_cCod == THIS.this_cUltConquilha
12732:             RETURN
12733:         ENDIF
12734:         THIS.this_cUltConquilha = loc_cCod
12735:         IF EMPTY(loc_cCod)
12736:             RETURN
12737:         ENDIF
12738:         TRY
12739:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12740:                 SELECT TOP 1 conquilhas FROM SigCdCnq WHERE RTRIM(conquilhas) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12741:             ENDTEXT
12742:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCnq")
12743:             IF loc_nR <= 0 OR EOF("cursor_4c_VCnq")
12744:                 THIS.AbrirLookupConquilha()
12745:             ELSE
12746:                 THIS.this_oBusinessObject.this_cConquilhas = loc_cCod
12747:             ENDIF
12748:             IF USED("cursor_4c_VCnq")
12749:                 USE IN cursor_4c_VCnq
12750:             ENDIF
12751:         CATCH TO loc_oErro
12752:             MsgErro("Erro ao validar conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_ConquilhaLostFocus")
12753:         ENDTRY
12754:     ENDPROC
12755: 
12756:     *--------------------------------------------------------------------------
12757:     * AbrirLookupConquilha - Lookup para campo Conquilha (SigCdCnq)
12758:     *--------------------------------------------------------------------------
12759:     PROTECTED PROCEDURE AbrirLookupConquilha()
12760:         LOCAL loc_oBusca, loc_oPg, loc_cVal
12761:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12762:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5), ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value), "")
12763: 
12764:         TRY
12765:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCnq", "cursor_4c_Cnq", "conquilhas", loc_cVal, "Selecionar Conquilha")
12766:             loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
12767:             loc_oBusca.Show()
12768: 
12769:             IF loc_oBusca.this_lSelecionou
12770:                 IF USED("cursor_4c_Cnq")
12771:                     LOCAL loc_cCodSel
12772:                     loc_cCodSel = ALLTRIM(cursor_4c_Cnq.conquilhas)
12773:                     IF PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
12774:                         loc_oPg.txt_4c_Conquilhas.Value = loc_cCodSel
12775:                     ENDIF
12776:                     THIS.this_oBusinessObject.this_cConquilhas = loc_cCodSel
12777:                 ENDIF
12778:             ELSE
12779:                 IF PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
12780:                     loc_oPg.txt_4c_Conquilhas.Value = ""
12781:                 ENDIF
12782:             ENDIF
12783: 
12784:             IF USED("cursor_4c_Cnq")
12785:                 USE IN cursor_4c_Cnq
12786:             ENDIF
12787:             loc_oBusca.Release()
12788:         CATCH TO loc_oErro
12789:             MsgErro("Erro no lookup de conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupConquilha")
12790:         ENDTRY
12791:     ENDPROC
12792: 
12793:     *--------------------------------------------------------------------------
12794:     * TabFases_GarraKeyPress - F4 no campo Garra abre lookup
12795:     *--------------------------------------------------------------------------
12796:     PROCEDURE TabFases_GarraKeyPress
12797:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12798:         IF par_nKeyCode = 115
12799:             THIS.AbrirLookupGarra()
12800:         ENDIF
12801:     ENDPROC
12802: 
12803:     *--------------------------------------------------------------------------
12804:     * TabFases_GarraLostFocus - LostFocus valida garra
12805:     *--------------------------------------------------------------------------
12806:     PROCEDURE TabFases_GarraLostFocus()
12807:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12808:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12809:         IF !PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
12810:             RETURN
12811:         ENDIF
12812:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codgarras.Value)
12813:         IF loc_cCod == THIS.this_cUltGarra
12814:             RETURN
12815:         ENDIF
12816:         THIS.this_cUltGarra = loc_cCod
12817:         IF EMPTY(loc_cCod)
12818:             RETURN
12819:         ENDIF
12820:         TRY
12821:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12822:                 SELECT TOP 1 codgarras FROM SigCdGar WHERE RTRIM(codgarras) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12823:             ENDTEXT
12824:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGar")
12825:             IF loc_nR <= 0 OR EOF("cursor_4c_VGar")
12826:                 THIS.AbrirLookupGarra()
12827:             ELSE
12828:                 THIS.this_oBusinessObject.this_cCodgarras = loc_cCod
12829:             ENDIF
12830:             IF USED("cursor_4c_VGar")
12831:                 USE IN cursor_4c_VGar
12832:             ENDIF
12833:         CATCH TO loc_oErro
12834:             MsgErro("Erro ao validar garra:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_GarraLostFocus")
12835:         ENDTRY
12836:     ENDPROC
12837: 
12838:     *--------------------------------------------------------------------------
12839:     * AbrirLookupGarra - Lookup para campo Garra (SigCdGar)
12840:     *--------------------------------------------------------------------------
12841:     PROTECTED PROCEDURE AbrirLookupGarra()
12842:         LOCAL loc_oBusca, loc_oPg, loc_cVal
12843:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12844:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5), ALLTRIM(loc_oPg.txt_4c_Codgarras.Value), "")
12845: 
12846:         TRY
12847:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGar", "cursor_4c_Gar", "codgarras", loc_cVal, "Selecionar Garra")
12848:             loc_oBusca.mAddColuna("codgarras", "", "C" + CHR(243) + "digo")
12849:             loc_oBusca.Show()
12850: 
12851:             IF loc_oBusca.this_lSelecionou
12852:                 IF USED("cursor_4c_Gar")
12853:                     LOCAL loc_cCodSel
12854:                     loc_cCodSel = ALLTRIM(cursor_4c_Gar.codgarras)
12855:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
12856:                         loc_oPg.txt_4c_Codgarras.Value = loc_cCodSel
12857:                     ENDIF
12858:                     THIS.this_oBusinessObject.this_cCodgarras = loc_cCodSel
12859:                 ENDIF
12860:             ELSE
12861:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
12862:                     loc_oPg.txt_4c_Codgarras.Value = ""
12863:                 ENDIF
12864:             ENDIF
12865: 
12866:             IF USED("cursor_4c_Gar")
12867:                 USE IN cursor_4c_Gar
12868:             ENDIF
12869:             loc_oBusca.Release()
12870:         CATCH TO loc_oErro
12871:             MsgErro("Erro no lookup de garra:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupGarra")
12872:         ENDTRY
12873:     ENDPROC
12874: 
12875:     *--------------------------------------------------------------------------
12876:     * BtnInserirFaseClick - Inserir nova fase de producao em SigCdPrf
12877:     *--------------------------------------------------------------------------
12878:     PROCEDURE BtnInserirFaseClick()
12879:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nProxOrdem, loc_nMaxOrdem
12880: 
12881:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12882:             MsgAviso("Salve ou edite o produto antes de inserir fases.", "FormProduto")
12883:             RETURN
12884:         ENDIF
12885: 
12886:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12887:         IF EMPTY(loc_cCpros)
12888:             MsgAviso("Produto n" + CHR(227) + "o identificado. Salve o produto primeiro.", "FormProduto")
12889:             RETURN
12890:         ENDIF
12891: 
12892:         TRY
12893:             *-- Calcular proximo numero de ordem
12894:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12895:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
12896:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12897:             ENDTEXT
12898:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdem")
12899:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdem")
12900:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdem.proximo, 1)
12901:             ELSE
12902:                 loc_nProxOrdem = 1
12903:             ENDIF
12904:             IF USED("cursor_4c_MaxOrdem")
12905:                 USE IN cursor_4c_MaxOrdem
12906:             ENDIF
12907: 
12908:             *-- Inserir nova fase
12909:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12910:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
12911:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, '', 0, '', '')
12912:             ENDTEXT
12913:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12914:             IF loc_nR > 0
12915:                 THIS.CarregarFases()
12916:                 LOCAL loc_oPg7
12917:                 loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12918:                 IF PEMSTATUS(loc_oPg7, "grd_4c_Fases", 5)
12919:                     loc_oPg7.grd_4c_Fases.SetFocus()
12920:                 ENDIF
12921:             ELSE
12922:                 MsgErro("Erro ao inserir fase.", "FormProduto.BtnInserirFaseClick")
12923:             ENDIF
12924:         CATCH TO loc_oErro
12925:             MsgErro("Erro ao inserir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirFaseClick")
12926:         ENDTRY
12927:     ENDPROC
12928: 
12929:     *--------------------------------------------------------------------------
12930:     * BtnExcluirFaseClick - Excluir fase de producao selecionada
12931:     *--------------------------------------------------------------------------
12932:     PROCEDURE BtnExcluirFaseClick()
12933:         LOCAL loc_cCpros, loc_nOrdems, loc_cSQL, loc_nR, loc_lConfirma
12934: 
12935:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12936:             RETURN
12937:         ENDIF
12938: 
12939:         IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases") OR BOF("cursor_4c_Fases")
12940:             MsgAviso("Selecione uma fase para excluir.", "FormProduto")
12941:             RETURN
12942:         ENDIF
12943: 
12944:         loc_cCpros  = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12945:         loc_nOrdems = NVL(cursor_4c_Fases.ordems, 0)
12946: 
12947:         IF loc_nOrdems <= 0
12948:             MsgAviso("Selecione uma fase v" + CHR(225) + "lida para excluir.", "FormProduto")
12949:             RETURN
12950:         ENDIF
12951: 
12952:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da fase " + TRANSFORM(loc_nOrdems) + "?", "FormProduto")
12953:         IF !loc_lConfirma
12954:             RETURN
12955:         ENDIF
12956: 
12957:         TRY
12958:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12959:                 DELETE FROM SigCdPrf
12960:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12961:                 AND ordems = <<loc_nOrdems>>
12962:             ENDTEXT
12963:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12964:             IF loc_nR > 0
12965:                 THIS.CarregarFases()
12966:             ELSE
12967:                 MsgErro("Erro ao excluir fase.", "FormProduto.BtnExcluirFaseClick")
12968:             ENDIF
12969:         CATCH TO loc_oErro
12970:             MsgErro("Erro ao excluir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirFaseClick")
12971:         ENDTRY
12972:     ENDPROC
12973: 
12974:     *--------------------------------------------------------------------------
12975:     * BtnAlternativaFaseClick - Inserir fase alternativa (alternativa da fase atual)
12976:     *--------------------------------------------------------------------------
12977:     PROCEDURE BtnAlternativaFaseClick()
12978:         LOCAL loc_cCpros, loc_cGrupoAtual, loc_cSQL, loc_nR, loc_nProxOrdem
12979: 
12980:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12981:             MsgAviso("Salve ou edite o produto antes de inserir alternativas.", "FormProduto")
12982:             RETURN
12983:         ENDIF
12984: 
12985:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12986:         IF EMPTY(loc_cCpros)
12987:             MsgAviso("Produto n" + CHR(227) + "o identificado. Salve o produto primeiro.", "FormProduto")
12988:             RETURN
12989:         ENDIF
12990: 
12991:         IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
12992:             MsgAviso("Selecione uma fase base para criar a alternativa.", "FormProduto")
12993:             RETURN
12994:         ENDIF
12995: 
12996:         loc_cGrupoAtual = ALLTRIM(NVL(cursor_4c_Fases.grupos, ""))
12997:         IF EMPTY(loc_cGrupoAtual)
12998:             MsgAviso("A fase selecionada precisa ter um grupo definido.", "FormProduto")
12999:             RETURN
13000:         ENDIF
13001: 
13002:         TRY
13003:             *-- Calcular proximo numero de ordem
13004:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13005:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
13006:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
13007:             ENDTEXT
13008:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdAlt")
13009:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdAlt")
13010:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdAlt.proximo, 1)
13011:             ELSE
13012:                 loc_nProxOrdem = 1
13013:             ENDIF
13014:             IF USED("cursor_4c_MaxOrdAlt")
13015:                 USE IN cursor_4c_MaxOrdAlt
13016:             ENDIF
13017: 
13018:             *-- Inserir fase alternativa copiando o grupo da fase atual
13019:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13020:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
13021:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, <<EscaparSQL(loc_cGrupoAtual)>>, 0, '', '')
13022:             ENDTEXT
13023:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13024:             IF loc_nR > 0
13025:                 THIS.CarregarFases()
13026:             ELSE
13027:                 MsgErro("Erro ao inserir fase alternativa.", "FormProduto.BtnAlternativaFaseClick")
13028:             ENDIF
13029:         CATCH TO loc_oErro
13030:             MsgErro("Erro ao inserir alternativa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnAlternativaFaseClick")
13031:         ENDTRY
13032:     ENDPROC
13033: 
13034:     *--------------------------------------------------------------------------
13035:     * CmdFichaClick - Imprimir ficha tecnica das fases do produto
13036:     *--------------------------------------------------------------------------
13037:     PROCEDURE CmdFichaClick()
13038:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oBO
13039: 
13040:         loc_oBO    = THIS.this_oBusinessObject
13041:         loc_cCpros = ALLTRIM(loc_oBO.this_cCpros)
13042: 
13043:         IF EMPTY(loc_cCpros)
13044:             MsgAviso("Nenhum produto selecionado.", "FormProduto")
13045:             RETURN
13046:         ENDIF
13047: 
13048:         TRY
13049:             *-- Criar cursor de cabecalho para o relatorio
13050:             IF USED("CsCabecalho")
13051:                 USE IN CsCabecalho
13052:             ENDIF
13053:             CREATE CURSOR CsCabecalho ( ;
13054:                 _NmEmp  C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
13055:                 _cGrus  C(03), _dGrus C(20), _sGrus C(06), _sDesc C(20), ;
13056:                 _cLinh  C(10), _dLinh C(40), _cGVen C(10), _dGVen C(40), ;
13057:                 _nPeso  N(9,2), _DtIni D(08), _DtFin D(08), _TExec C(15), _cMode C(10))
13058: 
13059:             INSERT INTO CsCabecalho ;
13060:                 (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _dGrus, _cMode) ;
13061:                 VALUES( ;
13062:                     go_4c_Sistema.cEmpresa, ;
13063:                     "Ficha T" + CHR(233) + "cnica de Fases", ;
13064:                     loc_cCpros, ;
13065:                     loc_oBO.this_cDpros, ;
13066:                     loc_oBO.this_cCgrus, ;
13067:                     THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus"), ;
13068:                     THIS.this_cModoAtual)
13069: 
13070:             MsgInfo("Ficha t" + CHR(233) + "cnica gerada. Configure o relat" + CHR(243) + "rio RelFase.frx para impress" + CHR(227) + "o.", "Ficha T" + CHR(233) + "cnica")
13071: 
13072:             IF USED("CsCabecalho")
13073:                 USE IN CsCabecalho
13074:             ENDIF
13075: 
13076:         CATCH TO loc_oErro
13077:             MsgErro("Erro ao gerar ficha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdFichaClick")
13078:         ENDTRY
13079:     ENDPROC
13080: 
13081:     *--------------------------------------------------------------------------
13082:     * CmdgFiguraClick - Carregar/remover imagem da fase selecionada (FigProcs)
13083:     *--------------------------------------------------------------------------
13084:     PROCEDURE CmdgFiguraClick()
13085:         LOCAL loc_cCpros, loc_nOrdems, loc_cSQL, loc_nR, loc_cArquivo, loc_cFig
13086:         LOCAL loc_oPg, loc_lConfirma
13087: 
13088:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13089:             RETURN
13090:         ENDIF
13091: 
13092:         IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
13093:             MsgAviso("Selecione uma fase para carregar a imagem.", "FormProduto")
13094:             RETURN
13095:         ENDIF
13096: 
13097:         loc_cCpros  = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13098:         loc_nOrdems = NVL(cursor_4c_Fases.ordems, 0)
13099: 
13100:         IF loc_nOrdems <= 0
13101:             MsgAviso("Selecione uma fase v" + CHR(225) + "lida.", "FormProduto")
13102:             RETURN
13103:         ENDIF
13104: 
13105:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13106: 
13107:         TRY
13108:             *-- Verificar se ja tem imagem
13109:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13110:                 SELECT TOP 1 CASE WHEN FigProcs IS NULL OR LEN(RTRIM(FigProcs))=0 THEN 0 ELSE 1 END AS temFig
13111:                 FROM SigCdPrf
13112:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13113:             ENDTEXT
13114:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerFig")
13115:             LOCAL loc_lTemFig
13116:             loc_lTemFig = .F.
13117:             IF loc_nR > 0 AND !EOF("cursor_4c_VerFig")
13118:                 loc_lTemFig = (cursor_4c_VerFig.temFig > 0)
13119:             ENDIF
13120:             IF USED("cursor_4c_VerFig")
13121:                 USE IN cursor_4c_VerFig
13122:             ENDIF
13123: 
13124:             IF loc_lTemFig
13125:                 *-- Oferecer opcoes: substituir ou remover
13126:                 loc_lConfirma = MsgConfirma("Esta fase j" + CHR(225) + " possui imagem. Deseja remov" + CHR(234) + "-la?", "Imagem da Fase")
13127:                 IF loc_lConfirma
13128:                     TEXT TO loc_cSQL TEXTMERGE NOSHOW
13129:                         UPDATE SigCdPrf SET FigProcs = NULL
13130:                         WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13131:                     ENDTEXT
13132:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13133:                     IF loc_nR > 0
13134:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
13135:                             loc_oPg.img_4c_ImgFigJpg.Picture = ""
13136:                             loc_oPg.img_4c_ImgFigJpg.Visible = .F.
13137:                         ENDIF
13138:                         MsgInfo("Imagem removida.", "FormProduto")
13139:                     ENDIF
13140:                     RETURN
13141:                 ENDIF

*-- Linhas 13181 a 13541:
13181:     * CmdgFigCamClick - Carregar/remover imagem de borracha (camera/molde)
13182:     * Equivalente ao cmdgFigCam do legado: camera para imagem da borracha
13183:     *--------------------------------------------------------------------------
13184:     PROCEDURE CmdgFigCamClick()
13185:         LOCAL loc_cCmats, loc_cSQL, loc_nR, loc_cArquivo, loc_cFig, loc_oPg
13186: 
13187:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13188:             RETURN
13189:         ENDIF
13190: 
13191:         IF NOT USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes")
13192:             MsgAviso("Selecione uma matriz para carregar a imagem.", "FormProduto")
13193:             RETURN
13194:         ENDIF
13195: 
13196:         loc_cCmats = ALLTRIM(NVL(cursor_4c_Matrizes.cmats, ""))
13197:         IF EMPTY(loc_cCmats)
13198:             MsgAviso("Selecione uma matriz v" + CHR(225) + "lida.", "FormProduto")
13199:             RETURN
13200:         ENDIF
13201: 
13202:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13203: 
13204:         TRY
13205:             *-- Selecionar arquivo de imagem
13206:             loc_cFig = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar Imagem da Borracha:")
13207:             IF EMPTY(loc_cFig) OR !FILE(loc_cFig)
13208:                 RETURN
13209:             ENDIF
13210: 
13211:             *-- Converter para Base64 e salvar em SigCdPro.FigJpgs
13212:             LOCAL loc_cBinImg, loc_cB64
13213:             loc_cBinImg = FILETOSTR(loc_cFig)
13214:             IF EMPTY(loc_cBinImg)
13215:                 MsgErro("Falha ao ler arquivo de imagem.", "FormProduto.CmdgFigCamClick")
13216:                 RETURN
13217:             ENDIF
13218: 
13219:             loc_cB64 = "data:image/jpeg;base64," + STRCONV(loc_cBinImg, 13)
13220: 
13221:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13222:                 UPDATE SigCdPro SET FigJpgs = ?loc_cB64
13223:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
13224:             ENDTEXT
13225:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13226:             IF loc_nR > 0
13227:                 *-- Exibir imagem
13228:                 loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
13229:                 STRTOFILE(loc_cBinImg, loc_cArquivo)
13230:                 IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
13231:                     loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo
13232:                     loc_oPg.img_4c_ImgBorracha.Visible = .T.
13233:                 ENDIF
13234:             ELSE
13235:                 MsgErro("Erro ao salvar imagem.", "FormProduto.CmdgFigCamClick")
13236:             ENDIF
13237: 
13238:         CATCH TO loc_oErro
13239:             MsgErro("Erro ao carregar imagem de borracha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdgFigCamClick")
13240:         ENDTRY
13241:     ENDPROC
13242: 
13243:     *--------------------------------------------------------------------------
13244:     * BtnInserirMatrizClick - Inserir nova linha na grade de matrizes (SigPrMtz)
13245:     *--------------------------------------------------------------------------
13246:     PROCEDURE BtnInserirMatrizClick()
13247:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
13248: 
13249:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13250:             MsgAviso("Salve ou edite o produto antes de inserir matrizes.", "FormProduto")
13251:             RETURN
13252:         ENDIF
13253: 
13254:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13255:         IF EMPTY(loc_cCpros)
13256:             MsgAviso("Produto n" + CHR(227) + "o identificado.", "FormProduto")
13257:             RETURN
13258:         ENDIF
13259: 
13260:         TRY
13261:             *-- Inserir nova linha vazia em SigPrMtz com cIdChaves unico
13262:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13263:                 INSERT INTO SigPrMtz (cpros, cidchaves, cmats, qtds)
13264:                 VALUES (<<EscaparSQL(loc_cCpros)>>, NEWID(), '', 0)
13265:             ENDTEXT
13266:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13267:             IF loc_nR > 0
13268:                 THIS.CarregarMatrizes()
13269:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13270:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
13271:                     loc_oPg.grd_4c_Matrizes.SetFocus()
13272:                 ENDIF
13273:             ELSE
13274:                 MsgErro("Erro ao inserir matriz.", "FormProduto.BtnInserirMatrizClick")
13275:             ENDIF
13276:         CATCH TO loc_oErro
13277:             MsgErro("Erro ao inserir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirMatrizClick")
13278:         ENDTRY
13279:     ENDPROC
13280: 
13281:     *--------------------------------------------------------------------------
13282:     * BtnExcluirMatrizClick - Excluir linha selecionada da grade de matrizes
13283:     *--------------------------------------------------------------------------
13284:     PROCEDURE BtnExcluirMatrizClick()
13285:         LOCAL loc_cCpros, loc_cCidChaves, loc_cSQL, loc_nR, loc_lConfirma
13286: 
13287:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13288:             RETURN
13289:         ENDIF
13290: 
13291:         IF NOT USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes") OR BOF("cursor_4c_Matrizes")
13292:             MsgAviso("Selecione uma matriz para excluir.", "FormProduto")
13293:             RETURN
13294:         ENDIF
13295: 
13296:         loc_cCpros     = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13297:         loc_cCidChaves = ALLTRIM(NVL(cursor_4c_Matrizes.cidchaves, ""))
13298: 
13299:         IF EMPTY(loc_cCidChaves)
13300:             MsgAviso("Selecione uma linha v" + CHR(225) + "lida para excluir.", "FormProduto")
13301:             RETURN
13302:         ENDIF
13303: 
13304:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o desta matriz?", "FormProduto")
13305:         IF !loc_lConfirma
13306:             RETURN
13307:         ENDIF
13308: 
13309:         TRY
13310:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13311:                 DELETE FROM SigPrMtz
13312:                 WHERE RTRIM(cidchaves) = RTRIM(<<EscaparSQL(loc_cCidChaves)>>)
13313:             ENDTEXT
13314:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13315:             IF loc_nR > 0
13316:                 THIS.CarregarMatrizes()
13317:             ELSE
13318:                 MsgErro("Erro ao excluir matriz.", "FormProduto.BtnExcluirMatrizClick")
13319:             ENDIF
13320:         CATCH TO loc_oErro
13321:             MsgErro("Erro ao excluir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirMatrizClick")
13322:         ENDTRY
13323:     ENDPROC
13324: 
13325:     *--------------------------------------------------------------------------
13326:     * DesignerGrd_AfterRowColChange - Grid tarefas: ao navegar linha/coluna
13327:     * Atualiza txt_4c_ObsTarefas com descricao da tarefa da linha atual
13328:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
13329:     *--------------------------------------------------------------------------
13330:     PROCEDURE DesignerGrd_AfterRowColChange(par_nColIndex)
13331:         LOCAL loc_oPg, loc_cCodTarefa, loc_cDesTarefa
13332:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13333: 
13334:         TRY
13335:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13336:                 loc_cCodTarefa = ALLTRIM(NVL(cursor_4c_Designer.tarefas, ""))
13337:                 loc_cDesTarefa = ""
13338: 
13339:                 *-- Buscar descricao no cursor de tarefas
13340:                 IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas") AND !EMPTY(loc_cCodTarefa)
13341:                     SELECT cursor_4c_Tarefas
13342:                     LOCATE FOR ALLTRIM(CodCads) = loc_cCodTarefa
13343:                     IF !EOF("cursor_4c_Tarefas")
13344:                         loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13345:                     ENDIF
13346:                 ENDIF
13347: 
13348:                 IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13349:                     loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13350:                     loc_oPg.txt_4c_ObsTarefas.Refresh()
13351:                 ENDIF
13352:             ENDIF
13353:         CATCH TO loc_oErro
13354:             MsgErro(loc_oErro.Message, "FormProduto.DesignerGrd_AfterRowColChange")
13355:         ENDTRY
13356:     ENDPROC
13357: 
13358:     *--------------------------------------------------------------------------
13359:     * ArquivosGrd_AfterRowColChange - Grid arquivos: ao navegar linha/coluna
13360:     * Exibe preview de imagem em img_4c_ImgArqJpg se arquivo for JPG/ICO/BMP/JPEG
13361:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
13362:     *--------------------------------------------------------------------------
13363:     PROCEDURE ArquivosGrd_AfterRowColChange(par_nColIndex)
13364:         LOCAL loc_oPg, loc_cArq, loc_cExt
13365:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13366: 
13367:         TRY
13368:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgArqJpg", 5)
13369:                 RETURN
13370:             ENDIF
13371: 
13372:             *-- Limpar preview
13373:             CLEAR RESOURCES
13374:             loc_oPg.img_4c_ImgArqJpg.Picture = ""
13375:             loc_oPg.img_4c_ImgArqJpg.Visible = .F.
13376: 
13377:             IF USED("cursor_4c_Arquivos") AND !EOF("cursor_4c_Arquivos")
13378:                 loc_cArq = ALLTRIM(NVL(cursor_4c_Arquivos.arquivos, ""))
13379: 
13380:                 IF !EMPTY(loc_cArq)
13381:                     loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))
13382: 
13383:                     IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
13384:                         loc_oPg.img_4c_ImgArqJpg.Picture = loc_cArq
13385:                         loc_oPg.img_4c_ImgArqJpg.Visible = .T.
13386:                     ENDIF
13387:                 ENDIF
13388:             ENDIF
13389:         CATCH TO loc_oErro
13390:             MsgErro(loc_oErro.Message, "FormProduto.ArquivosGrd_AfterRowColChange")
13391:         ENDTRY
13392:     ENDPROC
13393: 
13394:     *--------------------------------------------------------------------------
13395:     * GrdDesignerColReadOnlyWhen - Colunas 1/2/3 do grd_4c_Designer: sempre somente leitura
13396:     * Retorna .F. para bloquear edicao (original: Return .f.)
13397:     *--------------------------------------------------------------------------
13398:     PROCEDURE GrdDesignerColReadOnlyWhen()
13399:         RETURN .F.
13400:     ENDPROC
13401: 
13402:     *--------------------------------------------------------------------------
13403:     * GrdDesignerCol4When - Column4 do grd_4c_Designer (Tarefa): editavel condicionalmente
13404:     * Editavel apenas em INSERIR/ALTERAR, para o usuario atual, sem DtFims
13405:     * Original: Return InList(pcEscolha, INSERIR, ALTERAR) And Usuars=Usuar And IsEmpty(DtFims)
13406:     *--------------------------------------------------------------------------
13407:     PROCEDURE GrdDesignerCol4When()
13408:         LOCAL loc_lEditavel, loc_cUsuars, loc_cDtFims
13409: 
13410:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13411:             RETURN .F.
13412:         ENDIF
13413: 
13414:         IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13415:             loc_cUsuars = ALLTRIM(NVL(cursor_4c_Designer.usuars, ""))
13416:             loc_cDtFims = NVL(cursor_4c_Designer.dtfims, {})
13417: 
13418:             IF loc_cUsuars <> ALLTRIM(gc_4c_UsuarioLogado)
13419:                 RETURN .F.
13420:             ENDIF
13421: 
13422:             IF !EMPTY(loc_cDtFims)
13423:                 RETURN .F.
13424:             ENDIF
13425: 
13426:             RETURN .T.
13427:         ENDIF
13428: 
13429:         RETURN .F.
13430:     ENDPROC
13431: 
13432:     *--------------------------------------------------------------------------
13433:     * GrdDesignerCol4Valid - Column4 do grd_4c_Designer: valida/lookup de tarefa
13434:     * Se cursor_4c_Tarefas tem dados: valida codigo; se nao encontrado, limpa campo
13435:     * Se cursor_4c_Tarefas vazio (tabela SigPrTrf inexistente): aceita qualquer valor
13436:     * Original: fwBuscaInt em crTarefas (CodCads/DesCads)
13437:     *--------------------------------------------------------------------------
13438:     PROCEDURE GrdDesignerCol4Valid()
13439:         LOCAL loc_oPg, loc_cValor, loc_cCodTarefa, loc_cDesTarefa, loc_lEncontrou
13440:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13441: 
13442:         TRY
13443:             *-- Obter valor atual da celula via cursor_4c_Designer
13444:             loc_cValor = ""
13445:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13446:                 loc_cValor = ALLTRIM(NVL(cursor_4c_Designer.tarefas, ""))
13447:             ENDIF
13448: 
13449:             IF EMPTY(loc_cValor)
13450:                 loc_lResultado = .T.
13451:             ENDIF
13452: 
13453:             *-- Cursor de tarefas vazio: tabela mestre nao disponivel, aceitar qualquer valor
13454:             IF !USED("cursor_4c_Tarefas") OR RECCOUNT("cursor_4c_Tarefas") = 0
13455:                 loc_lResultado = .T.
13456:             ENDIF
13457: 
13458:             *-- Verificar se codigo existe no cursor de tarefas
13459:             loc_lEncontrou = .F.
13460:             loc_cCodTarefa = ""
13461:             loc_cDesTarefa = ""
13462: 
13463:             SELECT cursor_4c_Tarefas
13464:             LOCATE FOR ALLTRIM(CodCads) = loc_cValor
13465:             IF !EOF("cursor_4c_Tarefas")
13466:                 loc_lEncontrou = .T.
13467:                 loc_cCodTarefa = ALLTRIM(cursor_4c_Tarefas.CodCads)
13468:                 loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13469:             ENDIF
13470: 
13471:             *-- Atualizar descricao se encontrou; limpar se nao encontrou
13472:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13473:                 IF loc_lEncontrou
13474:                     IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13475:                         loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13476:                     ENDIF
13477:                 ELSE
13478:                     MsgAviso("C" + CHR(243) + "digo de tarefa n" + CHR(227) + "o encontrado.", "Tarefa Designer")
13479:                     REPLACE cursor_4c_Designer.tarefas WITH ""
13480:                     IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13481:                         loc_oPg.txt_4c_ObsTarefas.Value = ""
13482:                     ENDIF
13483:                 ENDIF
13484:             ENDIF
13485: 
13486:         CATCH TO loc_oErro
13487:             MsgErro(loc_oErro.Message, "FormProduto.GrdDesignerCol4Valid")
13488:         ENDTRY
13489: 
13490:         RETURN .T.
13491:     ENDPROC
13492: 
13493:     *--------------------------------------------------------------------------
13494:     * GrdDesignerCol4LostFocus - Column4 perde foco: navega para txt_4c_ObsTarefas ao Enter
13495:     * Original: If Not Empty(This.Value) And (Lastkey()=13) -> getObsTarefas.SetFocus
13496:     *--------------------------------------------------------------------------
13497:     PROCEDURE GrdDesignerCol4LostFocus()
13498:         LOCAL loc_oPg
13499:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13500: 
13501:         TRY
13502:             IF LASTKEY() = 13
13503:                 IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13504:                     IF !EMPTY(ALLTRIM(NVL(cursor_4c_Designer.tarefas, "")))
13505:                         IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13506:                             loc_oPg.txt_4c_ObsTarefas.SetFocus()
13507:                         ENDIF
13508:                     ENDIF
13509:                 ENDIF
13510:             ENDIF
13511:         CATCH TO loc_oErro
13512:             MsgErro(loc_oErro.Message, "FormProduto.GrdDesignerCol4LostFocus")
13513:         ENDTRY
13514:     ENDPROC
13515: 
13516:     *--------------------------------------------------------------------------
13517:     * GrdArquivosCol1When - Column1 do grd_4c_Arquivos: editavel em INCLUIR/ALTERAR
13518:     * Original: Return InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
13519:     *--------------------------------------------------------------------------
13520:     PROCEDURE GrdArquivosCol1When()
13521:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13522:     ENDPROC
13523: 
13524:     *--------------------------------------------------------------------------
13525:     * ImgArqJpgClick - Clique na imagem: exibe caminho do arquivo
13526:     * Original: Do Form SigOpZom (zoom view) - forma simplificada: exibe path
13527:     *--------------------------------------------------------------------------
13528:     PROCEDURE ImgArqJpgClick()
13529:         LOCAL loc_cArq
13530:         loc_cArq = ""
13531: 
13532:         IF USED("cursor_4c_Arquivos") AND !EOF("cursor_4c_Arquivos")
13533:             loc_cArq = ALLTRIM(NVL(cursor_4c_Arquivos.arquivos, ""))
13534:         ENDIF
13535: 
13536:         IF !EMPTY(loc_cArq)
13537:             MsgAviso(loc_cArq, "Arquivo Selecionado")
13538:         ENDIF
13539:     ENDPROC
13540: 
13541: ENDDEFINE

