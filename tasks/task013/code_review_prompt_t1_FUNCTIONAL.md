# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (38)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtConquilhaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtConquilhaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtCorLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtCorLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtTamLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtTamLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtClfiscalFiscLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtClfiscalFiscLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtDclfiscalFiscLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtDclfiscalFiscLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtOrigmercFiscLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtOrigmercFiscLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtSittricmFiscLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtSittricmFiscLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtTpTribFiscLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtTpTribFiscLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtMetalFiscLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtMetalFiscLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtMvalorFiscLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtMvalorFiscLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtTeorFiscLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtTeorFiscLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Subgrupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Grp, Data de Início, Data de Conclusão, Tarefa, Arquivos Para Designer. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Total ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Grp, Data de Início, Data de Conclusão, Tarefa, Arquivos Para Designer. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Subgrupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Grp, Data de Início, Data de Conclusão, Tarefa, Arquivos Para Designer. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Total ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Grp, Data de Início, Data de Conclusão, Tarefa, Arquivos Para Designer. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Top original=32 vs migrado 'lbl_4c_Label13FP' Top=156 (diff=124px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Left original=72 vs migrado 'lbl_4c_Label13FP' Left=33 (diff=39px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=171 vs migrado 'cnt_4c_Botoes' Top=29 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=959 vs migrado 'cnt_4c_Botoes' Left=542 (diff=417px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=83 vs migrado 'obj_4c_Opc_situacao' Top=130 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Left original=102 vs migrado 'obj_4c_Opc_situacao' Left=735 (diff=633px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblGrupo' (parent: SIGCDPRO.Pagina.Lista.cntFiltros): Top original=18 vs migrado 'lbl_4c_LblGrupoP' Top=182 (diff=164px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblGrupo' (parent: SIGCDPRO.Pagina.Lista.cntFiltros): Left original=21 vs migrado 'lbl_4c_LblGrupoP' Left=73 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Top original=5 vs migrado 'lbl_4c_Label8FP' Top=281 (diff=276px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Left original=8 vs migrado 'lbl_4c_Label8FP' Left=72 (diff=64px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=134 vs migrado 'lbl_4c_Label2' Top=415 (diff=281px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=58 vs migrado 'lbl_4c_Label2' Left=479 (diff=421px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'lbl_4c_Label10FP' Top=256 (diff=195px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=967 vs migrado 'lbl_4c_Label10FP' Left=74 (diff=893px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'lbl_4c_Label9FP' Top=231 (diff=220px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=884 vs migrado 'lbl_4c_Label9FP' Left=58 (diff=826px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAltura' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=474 vs migrado 'lbl_4c_LblAltura' Top=250 (diff=224px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAltura' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=749 vs migrado 'lbl_4c_LblAltura' Left=860 (diff=111px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=172 vs migrado 'chk_4c_Fwoption1' Top=331 (diff=159px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=879 vs migrado 'chk_4c_Fwoption1' Left=180 (diff=699px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (12470 linhas total):

*-- Linhas 31 a 388:
31:     *--------------------------------------------------------------------------
32:     * Init - Inicializacao do formulario
33:     *--------------------------------------------------------------------------
34:     PROCEDURE Init()
35:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
36:         RETURN DODEFAULT()
37:     ENDPROC
38: 
39:     *--------------------------------------------------------------------------
40:     * InicializarForm - Configuracao inicial do formulario
41:     *--------------------------------------------------------------------------
42:     PROTECTED PROCEDURE InicializarForm()
43:         LOCAL loc_lSucesso
44:         loc_lSucesso = .F.
45: 
46:         TRY
47:             *-- Criar instancia do Business Object
48:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
49: 
50:             IF ISNULL(THIS.this_oBusinessObject)
51:                 MostrarErro("Erro ao criar Business Object ProdutoBO", "Erro Cr" + CHR(237) + "tico")
52:                 loc_lSucesso = .F.
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.ConfigurarPaginaLista()
56:                 THIS.ConfigurarPaginaDados()
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58: 
59:                 *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
60:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
61:                     IF !THIS.CarregarLista()
62:                         *-- Se falhar ao carregar, nao impede abertura
63:                     ENDIF
64:                 ENDIF
65: 
66:                 THIS.pgf_4c_Paginas.Visible = .T.
67:                 THIS.pgf_4c_Paginas.ActivePage = 1
68:                 THIS.this_cModoAtual = "LISTA"
69:                 loc_lSucesso = .T.
70:             ENDIF
71: 
72:         CATCH TO loException
73:             MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
74:             loc_lSucesso = .F.
75:         ENDTRY
76: 
77:         RETURN loc_lSucesso
78:     ENDPROC
79: 
80:     *--------------------------------------------------------------------------
81:     * ConfigurarPageFrame - Configura o PageFrame principal
82:     * Legado: Pagina Width=1003, PageFrame.Top=-29 (oculta abas)
83:     *--------------------------------------------------------------------------
84:     PROTECTED PROCEDURE ConfigurarPageFrame()
85:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
86: 
87:         WITH THIS.pgf_4c_Paginas
88:             .Top       = -29
89:             .Left      = 0
90:             .Width     = 1003
91:             .Height    = 600
92:             .PageCount = 2
93:             .Tabs      = .F.
94:             .Visible   = .T.
95: 
96:             *-- Page1 - Lista
97:             .Page1.Caption   = "Lista"
98:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page1.BackColor = RGB(255, 255, 255)
100: 
101:             *-- Page2 - Dados
102:             .Page2.Caption   = "Dados"
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.BackColor = RGB(255, 255, 255)
105:         ENDWITH
106:     ENDPROC
107: 
108:     *--------------------------------------------------------------------------
109:     * ConfigurarPaginaLista - Configura Page1 (Lista)
110:     * Compensacao +29 em TODOS os controles (Top_original + 29)
111:     * FASE 4: Cabecalho, Botoes CRUD, Saida, Filtros completos, Grid
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         LOCAL loc_oPagina
115:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
116: 
117:         *-- Container de cabecalho (cntSombra: Top=2 -> 31)
118:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH loc_oPagina.cnt_4c_Cabecalho
120:             .Top         = 31
121:             .Left        = 0
122:             .Width       = 1020
123:             .Height      = 80
124:             .BackStyle   = 1
125:             .BackColor   = RGB(53, 53, 53)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         *-- Sombra do titulo (lbl_4c_Sombra: Top=15, Left=10)
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
133:             .Caption   = "Cadastro de Produtos"
134:             .Top       = 17
135:             .Left      = 12
136:             .Width     = 769
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .BackStyle = 0
142:             .ForeColor = RGB(0, 0, 0)
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         *-- Titulo do cabecalho (lbl_4c_Titulo: Top=18, Left=10)
147:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
148:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
149:             .Caption   = "Cadastro de Produtos"
150:             .Top       = 15
151:             .Left      = 10
152:             .Width     = 769
153:             .Height    = 46
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16
156:             .FontBold  = .T.
157:             .BackStyle = 0
158:             .ForeColor = RGB(255, 255, 255)
159:             .Visible   = .T.
160:         ENDWITH
161: 
162:         *-- Container de botoes CRUD (Grupo_op: Left=542, Top=0 -> 29)
163:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
164:         WITH loc_oPagina.cnt_4c_Botoes
165:             .Top         = 29
166:             .Left        = 542
167:             .Width       = 390
168:             .Height      = 85
169:             .BackStyle = 1
170:             .BackColor = RGB(53, 53, 53)
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         *-- Botao Incluir (Left=5)
176:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
177:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
178:             .Caption         = "Incluir"
179:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:             .PicturePosition = 13
181:             .Width           = 75
182:             .Height          = 75
183:             .Left            = 5
184:             .Top             = 5
185:             .FontName        = "Tahoma"
186:             .FontSize        = 8
187:             .Themes          = .F.
188:             .SpecialEffect   = 0
189:             .BackColor       = RGB(255, 255, 255)
190:             .ForeColor       = RGB(90, 90, 90)
191:             .Visible         = .T.
192:         ENDWITH
193:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
194: 
195:         *-- Botao Visualizar (Left=80)
196:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
197:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
198:             .Caption         = "Visualizar"
199:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
200:             .PicturePosition = 13
201:             .Width           = 75
202:             .Height          = 75
203:             .Left            = 80
204:             .Top             = 5
205:             .FontName        = "Tahoma"
206:             .FontSize        = 8
207:             .Themes          = .F.
208:             .SpecialEffect   = 0
209:             .BackColor       = RGB(255, 255, 255)
210:             .ForeColor       = RGB(90, 90, 90)
211:             .Visible         = .T.
212:         ENDWITH
213:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
214: 
215:         *-- Botao Alterar (Left=155)
216:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
217:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
218:             .Caption         = "Alterar"
219:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
220:             .PicturePosition = 13
221:             .Width           = 75
222:             .Height          = 75
223:             .Left            = 155
224:             .Top             = 5
225:             .FontName        = "Tahoma"
226:             .FontSize        = 8
227:             .Themes          = .F.
228:             .SpecialEffect   = 0
229:             .BackColor       = RGB(255, 255, 255)
230:             .ForeColor       = RGB(90, 90, 90)
231:             .Visible         = .T.
232:         ENDWITH
233:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
234: 
235:         *-- Botao Excluir (Left=230)
236:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
237:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
238:             .Caption         = "Excluir"
239:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
240:             .PicturePosition = 13
241:             .Width           = 75
242:             .Height          = 75
243:             .Left            = 230
244:             .Top             = 5
245:             .FontName        = "Tahoma"
246:             .FontSize        = 8
247:             .Themes          = .F.
248:             .SpecialEffect   = 0
249:             .BackColor       = RGB(255, 255, 255)
250:             .ForeColor       = RGB(90, 90, 90)
251:             .Visible         = .T.
252:         ENDWITH
253:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
254: 
255:         *-- Botao Buscar (Left=305)
256:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
257:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
258:             .Caption         = "Buscar"
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
260:             .PicturePosition = 13
261:             .Width           = 75
262:             .Height          = 75
263:             .Left            = 305
264:             .Top             = 5
265:             .FontName        = "Tahoma"
266:             .FontSize        = 8
267:             .Themes          = .F.
268:             .SpecialEffect   = 0
269:             .BackColor       = RGB(255, 255, 255)
270:             .ForeColor       = RGB(90, 90, 90)
271:             .Visible         = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
274: 
275:         *-- Container de saida (Grupo_Saida: Left=935, Top=0 -> 29)
276:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
277:         WITH loc_oPagina.cnt_4c_Saida
278:             .Top         = 29
279:             .Left        = 935
280:             .Width       = 60
281:             .Height      = 85
282:             .BackStyle = 1
283:             .BackColor = RGB(53, 53, 53)
284:             .BorderWidth = 0
285:             .Visible     = .T.
286:         ENDWITH
287: 
288:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
289:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
290:             .Caption         = "X"
291:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
292:             .PicturePosition = 13
293:             .Width           = 50
294:             .Height          = 75
295:             .Left            = 5
296:             .Top             = 5
297:             .FontName        = "Tahoma"
298:             .FontSize        = 8
299:             .Themes          = .F.
300:             .SpecialEffect   = 0
301:             .BackColor       = RGB(255, 255, 255)
302:             .ForeColor       = RGB(90, 90, 90)
303:             .Visible         = .T.
304:         ENDWITH
305:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
306: 
307:         *-- Container de filtros (cntFiltros: Top=116, Left=5, com +29 de compensacao)
308:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
309:         WITH loc_oPagina.cnt_4c_Filtros
310:             .Top         = 116
311:             .Left        = 5
312:             .Width       = 535
313:             .Height      = 65
314:             .BackStyle   = 1
315:             .BackColor   = RGB(245, 245, 245)
316:             .BorderWidth = 1
317:             .Visible     = .T.
318:         ENDWITH
319: 
320:         *-- Label "Grupo de Produto:"
321:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
322:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
323:             .Caption   = "Grupo de Produto:"
324:             .Top       = 18
325:             .Left      = 5
326:             .Width     = 110
327:             .Height    = 15
328:             .FontName  = "Tahoma"
329:             .FontSize  = 8
330:             .BackStyle = 0
331:             .ForeColor = RGB(60, 60, 60)
332:             .Visible   = .T.
333:         ENDWITH
334: 
335:         *-- getCgru -> txt_4c_Cgru (codigo do grupo, F4 abre lookup)
336:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Cgru", "TextBox")
337:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru
338:             .Top      = 14
339:             .Left     = 116
340:             .Width    = 31
341:             .Height   = 23
342:             .FontName = "Tahoma"
343:             .FontSize = 8
344:             .Value    = ""
345:             .Visible  = .T.
346:         ENDWITH
347:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru, "KeyPress",  THIS, "TxtCgruKeyPress")
348:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru, "LostFocus", THIS, "TxtCgruLostFocus")
349: 
350:         *-- getDgru -> txt_4c_Dgru (descricao do grupo, somente leitura)
351:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Dgru", "TextBox")
352:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru
353:             .Top      = 14
354:             .Left     = 149
355:             .Width    = 154
356:             .Height   = 23
357:             .FontName = "Tahoma"
358:             .FontSize = 8
359:             .Value    = ""
360:             .ReadOnly = .T.
361:             .Visible  = .T.
362:         ENDWITH
363: 
364:         *-- Label "Ultima Alteracao:"
365:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData1", "Label")
366:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData1
367:             .Caption   = CHR(218) + "lt. Altera" + CHR(231) + CHR(227) + "o:"
368:             .Top       = 43
369:             .Left      = 5
370:             .Width     = 110
371:             .Height    = 15
372:             .FontName  = "Tahoma"
373:             .FontSize  = 8
374:             .BackStyle = 0
375:             .ForeColor = RGB(60, 60, 60)
376:             .Visible   = .T.
377:         ENDWITH
378: 
379:         *-- getDtIni -> txt_4c_DtIni (data inicial do filtro de alteracao)
380:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtIni", "TextBox")
381:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni
382:             .Top      = 39
383:             .Left     = 116
384:             .Width    = 85
385:             .Height   = 23
386:             .FontName = "Tahoma"
387:             .FontSize = 8
388:             .Value    = ""

*-- Linhas 418 a 461:
418:         ENDWITH
419: 
420:         *-- optFilSituas -> opt_4c_Situas (1=Todos, 2=Ativos, 3=Inativos)
421:         loc_oPagina.cnt_4c_Filtros.AddObject("opt_4c_Situas", "OptionGroup")
422:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_Situas
423:             .Top         = 15
424:             .Left        = 348
425:             .Width       = 182
426:             .Height      = 20
427:             .ButtonCount = 3
428:             .Value       = 1
429:             .BorderStyle = 0
430:             .Visible     = .T.
431:         ENDWITH
432: 
433:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_Situas
434:             .Buttons(1).Caption   = "Todos"
435:             .Buttons(1).Left      = 0
436:             .Buttons(1).Top       = 0
437:             .Buttons(1).Width     = 55
438:             .Buttons(1).Height    = 18
439:             .Buttons(1).FontName  = "Tahoma"
440:             .Buttons(1).FontSize  = 8
441:             .Buttons(1).ForeColor = RGB(60, 60, 60)
442:             .Buttons(1).BackStyle = 0
443:             .Buttons(1).Themes    = .F.
444:             .Buttons(1).AutoSize  = .F.
445: 
446:             .Buttons(2).Caption   = "Ativos"
447:             .Buttons(2).Left      = 60
448:             .Buttons(2).Top       = 0
449:             .Buttons(2).Width     = 55
450:             .Buttons(2).Height    = 18
451:             .Buttons(2).FontName  = "Tahoma"
452:             .Buttons(2).FontSize  = 8
453:             .Buttons(2).ForeColor = RGB(60, 60, 60)
454:             .Buttons(2).BackStyle = 0
455:             .Buttons(2).Themes    = .F.
456:             .Buttons(2).AutoSize  = .F.
457: 
458:             .Buttons(3).Caption   = "Inativos"
459:             .Buttons(3).Left      = 120
460:             .Buttons(3).Top       = 0
461:             .Buttons(3).Width     = 62

*-- Linhas 467 a 548:
467:             .Buttons(3).Themes    = .F.
468:             .Buttons(3).AutoSize  = .F.
469:         ENDWITH
470:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")
471: 
472:         *----------------------------------------------------------------------
473:         *-- Criar cursor placeholder ANTES do grid (para RecordSource estavel)
474:         *-- Campos identicos ao que ProdutoBO.Buscar() cria
475:         *----------------------------------------------------------------------
476:         IF !USED("cursor_4c_Dados")
477:             CREATE CURSOR cursor_4c_Dados (;
478:                 cpros    C(14), dpros  C(65), cgrus C(3), ;
479:                 sgrus    C(6),  reffs  C(40), ;
480:                 usuaalts C(20), situas N(1,0))
481:         ENDIF
482: 
483:         *----------------------------------------------------------------------
484:         *-- Grid principal da lista (Grade: Top=183, Left=5)
485:         *-- ColumnCount e Visible no WITH; RecordSource FORA do WITH
486:         *----------------------------------------------------------------------
487:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
488:         WITH loc_oPagina.grd_4c_Lista
489:             .Top         = 183
490:             .Left        = 5
491:             .Width       = 950
492:             .Height      = 389
493:             .ColumnCount = 7
494:             .Visible     = .T.
495:             .RecordMark   = .F.
496:             .DeleteMark   = .F.
497:         ENDWITH
498: 
499:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
500:         loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
501: 
502:         *-- ControlSources e larguras APOS RecordSource
503:         loc_oPagina.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.cpros"
504:         loc_oPagina.grd_4c_Lista.Column1.Width            = 70
505:         loc_oPagina.grd_4c_Lista.Column1.ReadOnly         = .T.
506:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption  = "Produto"
507: 
508:         loc_oPagina.grd_4c_Lista.Column2.ControlSource   = "cursor_4c_Dados.dpros"
509:         loc_oPagina.grd_4c_Lista.Column2.Width            = 315
510:         loc_oPagina.grd_4c_Lista.Column2.ReadOnly         = .T.
511:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
512: 
513:         loc_oPagina.grd_4c_Lista.Column3.ControlSource   = "cursor_4c_Dados.cgrus"
514:         loc_oPagina.grd_4c_Lista.Column3.Width            = 55
515:         loc_oPagina.grd_4c_Lista.Column3.ReadOnly         = .T.
516:         loc_oPagina.grd_4c_Lista.Column3.Header1.Caption  = "Grupo"
517: 
518:         loc_oPagina.grd_4c_Lista.Column4.ControlSource   = "cursor_4c_Dados.sgrus"
519:         loc_oPagina.grd_4c_Lista.Column4.Width            = 70
520:         loc_oPagina.grd_4c_Lista.Column4.ReadOnly         = .T.
521:         loc_oPagina.grd_4c_Lista.Column4.Header1.Caption  = "Subgrupo"
522: 
523:         loc_oPagina.grd_4c_Lista.Column5.ControlSource   = "cursor_4c_Dados.reffs"
524:         loc_oPagina.grd_4c_Lista.Column5.Width            = 225
525:         loc_oPagina.grd_4c_Lista.Column5.ReadOnly         = .T.
526:         loc_oPagina.grd_4c_Lista.Column5.Header1.Caption  = "Ref. Fornecedor"
527: 
528:         loc_oPagina.grd_4c_Lista.Column6.ControlSource   = "cursor_4c_Dados.usuaalts"
529:         loc_oPagina.grd_4c_Lista.Column6.Width            = 150
530:         loc_oPagina.grd_4c_Lista.Column6.ReadOnly         = .T.
531:         loc_oPagina.grd_4c_Lista.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"
532: 
533:         loc_oPagina.grd_4c_Lista.Column7.ControlSource   = "cursor_4c_Dados.situas"
534:         loc_oPagina.grd_4c_Lista.Column7.Width            = 30
535:         loc_oPagina.grd_4c_Lista.Column7.ReadOnly         = .T.
536:         loc_oPagina.grd_4c_Lista.Column7.Header1.Caption  = "I"
537: 
538:         *-- Formatacao padrao (Verdana 8, gridlines, RowHeight=16)
539:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
540: 
541:         *-- Label de contagem de produtos (lblProdutos: Top=584 + 29 = 613 -> 575)
542:         loc_oPagina.AddObject("lbl_4c_Contagem", "Label")
543:         WITH loc_oPagina.lbl_4c_Contagem
544:             .Caption   = "Produtos Selecionados : 0"
545:             .Top       = 575
546:             .Left      = 38
547:             .Width     = 200
548:             .Height    = 15

*-- Linhas 554 a 660:
554:         ENDWITH
555: 
556:         *-- Tornar controles visiveis (apenas prefixos validos)
557:         THIS.TornarControlesVisiveis(loc_oPagina)
558:     ENDPROC
559: 
560:     *--------------------------------------------------------------------------
561:     * ConfigurarPaginaDados - Configura Page2 (Dados)
562:     * FASE 4/5: Botoes Salvar/Cancelar + PageFrame interno (7 abas) + pgDados
563:     * Compensacao +29 em controles de Page2; controles de pgf_4c_Dados sem compensacao
564:     *--------------------------------------------------------------------------
565:     PROTECTED PROCEDURE ConfigurarPaginaDados()
566:         LOCAL loc_oPagina, loc_oPgfDados
567:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
568: 
569:         *-- Container de botoes de acao (Grupo_Salva: Top=4 -> 33, Left=842)
570:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
571:         WITH loc_oPagina.cnt_4c_BotoesAcao
572:             .Top         = 33
573:             .Left        = 842
574:             .Width       = 160
575:             .Height      = 85
576:             .BackStyle = 1
577:             .BackColor = RGB(53, 53, 53)
578:             .BorderWidth = 0
579:             .Visible     = .T.
580:         ENDWITH
581: 
582:         *-- Botao Salvar (Left=5)
583:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
584:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
585:             .Caption         = "Salvar"
586:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
587:             .PicturePosition = 13
588:             .Width           = 75
589:             .Height          = 75
590:             .Left            = 5
591:             .Top             = 5
592:             .FontName        = "Tahoma"
593:             .FontSize        = 8
594:             .Themes          = .F.
595:             .SpecialEffect   = 0
596:             .BackColor       = RGB(255, 255, 255)
597:             .ForeColor       = RGB(90, 90, 90)
598:             .Visible         = .T.
599:         ENDWITH
600:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
601: 
602:         *-- Botao Cancelar (Left=80)
603:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
604:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
605:             .Caption         = "Cancelar"
606:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
607:             .PicturePosition = 13
608:             .Width           = 75
609:             .Height          = 75
610:             .Left            = 80
611:             .Top             = 5
612:             .FontName        = "Tahoma"
613:             .FontSize        = 8
614:             .Themes          = .F.
615:             .SpecialEffect   = 0
616:             .BackColor       = RGB(255, 255, 255)
617:             .ForeColor       = RGB(90, 90, 90)
618:             .Visible         = .T.
619:         ENDWITH
620:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
621: 
622:         *----------------------------------------------------------------------
623:         *-- PageFrame interno com 7 abas de dados
624:         *-- Legado: pgframeDados Top=-54, Left=-1, Width=1003, Height=656
625:         *-- Compensacao outer PF (-29) + inner PF (-54) = total -83 para controles internos
626:         *-- Top relativo a Page2: -54 + 29 = -25
627:         *----------------------------------------------------------------------
628:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
629:         loc_oPgfDados = loc_oPagina.pgf_4c_Dados
630: 
631:         WITH loc_oPgfDados
632:             .Top       = -25
633:             .Left      = -1
634:             .Width     = 1003
635:             .Height    = 656
636:             .PageCount = 7
637:             .Tabs      = .T.
638:             .Visible   = .T.
639:             .TabStyle  = 0
640:         ENDWITH
641: 
642:         *-- Aba 1: Dados Gerais (pgDados)
643:         WITH loc_oPgfDados.Page1
644:             .Caption   = "Dados"
645:             .BackColor = RGB(255, 255, 255)
646:         ENDWITH
647: 
648:         *-- Aba 2: Composicao (pgComposicao)
649:         WITH loc_oPgfDados.Page2
650:             .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
651:             .BackColor = RGB(255, 255, 255)
652:         ENDWITH
653: 
654:         *-- Aba 3: Dados Fiscais (pgDadosFiscais)
655:         WITH loc_oPgfDados.Page3
656:             .Caption   = "Dados Fiscais"
657:             .BackColor = RGB(255, 255, 255)
658:         ENDWITH
659: 
660:         *-- Aba 4: Fases de Producao (PgDadosFaseP)

*-- Linhas 703 a 755:
703:         THIS.ConfigurarPgPgDesigner()
704: 
705:         *-- Tornar controles visiveis
706:         THIS.TornarControlesVisiveis(loc_oPagina)
707:     ENDPROC
708: 
709:     *==========================================================================
710:     * FASE 9 - Aba Composicao (pgComposicao - Page2 do pgf_4c_Dados)
711:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao
712:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
713:     * 144 controles: 3 grids (14+15+3 cols), 2 cmd groups, textboxes, labels, shapes
714:     *==========================================================================
715:     PROTECTED PROCEDURE ConfigurarPgpgComposicao()
716:         LOCAL loc_oPg, loc_oGrd
717: 
718:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
719: 
720:         *----------------------------------------------------------------------
721:         *-- Cursor placeholder para grdCompo (SigPrCpo)
722:         *-- Campos: cpros(PK), mats(material), dcomps(descricao), unicompos(un),
723:         *--         pcompos(valor), qtds(qtde), totals(total), bloqueio(moeda),
724:         *--         obscompos(obs), etiq(E), consumo(consumo), qtd2(qtde cons),
725:         *--         uni2(un cons), ord(ordem), matrizes(material alternativo)
726:         *----------------------------------------------------------------------
727:         IF !USED("cursor_4c_Compo")
728:             SET NULL ON
729:             CREATE CURSOR cursor_4c_Compo (;
730:                 cpros    C(14), mats     C(14), dcomps   C(65), ;
731:                 unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
732:                 totals   N(12,4), bloqueio C(5), obscompos C(40), ;
733:                 etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
734:                 uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
735:                 cgrus    C(3),  moeds    C(5))
736:             SET NULL OFF
737:         ENDIF
738: 
739:         *----------------------------------------------------------------------
740:         *-- Cursor placeholder para grdsubcp (SigSubCp)
741:         *----------------------------------------------------------------------
742:         IF !USED("cursor_4c_SubCp")
743:             SET NULL ON
744:             CREATE CURSOR cursor_4c_SubCp (;
745:                 cpros    C(14), mats     C(14), dcomps   C(65), ;
746:                 unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
747:                 totals   N(12,4), bloqueio C(5), obscompos C(40), ;
748:                 etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
749:                 uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
750:                 tamanhos C(20))
751:             SET NULL OFF
752:         ENDIF
753: 
754:         *----------------------------------------------------------------------
755:         *-- Cursor placeholder para GradeGRUPO (TotGrupo)

*-- Linhas 857 a 901:
857:             .ForeColor     = RGB(36, 84, 155)
858:             .Visible       = .T.
859:         ENDWITH
860:         BINDEVENT(loc_oPg.txt_4c_MatP, "KeyPress",  THIS, "TxtMatPKeyPress")
861:         BINDEVENT(loc_oPg.txt_4c_MatP, "LostFocus", THIS, "TxtMatPLostFocus")
862: 
863:         *----------------------------------------------------------------------
864:         *-- Grid grdCompo (14 colunas) - Composicao do produto
865:         *-- Top:148 Left:6 Width:943 Height:147
866:         *----------------------------------------------------------------------
867:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
868:         WITH loc_oPg.grd_4c_Compo
869:             .Top         = 148
870:             .Left        = 6
871:             .Width       = 943
872:             .Height      = 147
873:             .ColumnCount = 14
874:             .FontName    = "Verdana"
875:             .FontSize    = 8
876:             .GridLines   = 3
877:             .GridLineWidth = 1
878:             .GridLineColor = RGB(238, 238, 238)
879:             .RecordMark  = .F.
880:             .DeleteMark  = .F.
881:             .AllowRowSizing = .F.
882:             .ReadOnly    = .F.
883:             .BackColor   = RGB(255, 255, 255)
884:             .ForeColor   = RGB(90, 90, 90)
885:             .HighlightBackColor = RGB(220, 230, 242)
886:             .HighlightForeColor = RGB(15, 41, 104)
887:             .HighlightStyle = 2
888:             .RowHeight   = 16
889:             .ScrollBars  = 2
890:             .Visible     = .T.
891:         ENDWITH
892: 
893:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
894:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
895: 
896:         *-- Configurar colunas do grd_4c_Compo APOS RecordSource
897:         WITH loc_oPg.grd_4c_Compo
898:             *-- Col1: Material (C14) W:80
899:             .Column1.Header1.Caption       = "Material"
900:             .Column1.Width                 = 80
901:             .Column1.ControlSource         = "cursor_4c_Compo.mats"

*-- Linhas 977 a 1128:
977:             .Column14.Width                = 83
978:             .Column14.ControlSource        = "cursor_4c_Compo.matrizes"
979:         ENDWITH
980:         BINDEVENT(loc_oPg.grd_4c_Compo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
981: 
982:         *----------------------------------------------------------------------
983:         *-- Botoes do grdCompo (cmdgCompo: 5 botoes, Right of grid)
984:         *-- Container em T:145 L:947 W:50 H:210 (cada botao 50x42)
985:         *----------------------------------------------------------------------
986:         loc_oPg.AddObject("cnt_4c_BotoesCompo", "Container")
987:         WITH loc_oPg.cnt_4c_BotoesCompo
988:             .Top         = 145
989:             .Left        = 947
990:             .Width       = 50
991:             .Height      = 210
992:             .BackStyle = 1
993:             .BackColor = RGB(53, 53, 53)
994:             .BorderWidth = 0
995:             .Visible     = .T.
996:         ENDWITH
997: 
998:         *-- Botao 1: Inserir componente
999:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_InserirCompo", "CommandButton")
1000:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_InserirCompo
1001:             .Caption     = "+"
1002:             .Top         = 0
1003:             .Left        = 0
1004:             .Width       = 50
1005:             .Height      = 42
1006:             .FontName    = "Tahoma"
1007:             .FontSize    = 10
1008:             .FontBold    = .T.
1009:             .Themes      = .F.
1010:             .SpecialEffect = 0
1011:             .BackColor   = RGB(255, 255, 255)
1012:             .ForeColor   = RGB(0, 128, 0)
1013:             .Visible     = .T.
1014:         ENDWITH
1015:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_InserirCompo, "Click", THIS, "CmdInserirCompoClick")
1016: 
1017:         *-- Botao 2: Excluir componente
1018:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_ExcluirCompo", "CommandButton")
1019:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_ExcluirCompo
1020:             .Caption     = "-"
1021:             .Top         = 42
1022:             .Left        = 0
1023:             .Width       = 50
1024:             .Height      = 42
1025:             .FontName    = "Tahoma"
1026:             .FontSize    = 10
1027:             .FontBold    = .T.
1028:             .Themes      = .F.
1029:             .SpecialEffect = 0
1030:             .BackColor   = RGB(255, 255, 255)
1031:             .ForeColor   = RGB(192, 0, 0)
1032:             .Visible     = .T.
1033:         ENDWITH
1034:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_ExcluirCompo, "Click", THIS, "CmdExcluirCompoClick")
1035: 
1036:         *-- Botao 3: Calcular preco (fornecedor)
1037:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_CalcFornec", "CommandButton")
1038:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_CalcFornec
1039:             .Caption     = "F"
1040:             .Top         = 84
1041:             .Left        = 0
1042:             .Width       = 50
1043:             .Height      = 42
1044:             .FontName    = "Tahoma"
1045:             .FontSize    = 9
1046:             .Themes      = .F.
1047:             .SpecialEffect = 0
1048:             .BackColor   = RGB(255, 255, 255)
1049:             .ForeColor   = RGB(90, 90, 90)
1050:             .Visible     = .T.
1051:         ENDWITH
1052:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_CalcFornec, "Click", THIS, "CmdCalcFornecClick")
1053: 
1054:         *-- Botao 4: Atualizar composicao
1055:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_AtualizarCompo", "CommandButton")
1056:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarCompo
1057:             .Caption     = "A"
1058:             .Top         = 126
1059:             .Left        = 0
1060:             .Width       = 50
1061:             .Height      = 42
1062:             .FontName    = "Tahoma"
1063:             .FontSize    = 9
1064:             .Themes      = .F.
1065:             .SpecialEffect = 0
1066:             .BackColor   = RGB(255, 255, 255)
1067:             .ForeColor   = RGB(90, 90, 90)
1068:             .Visible     = .T.
1069:         ENDWITH
1070:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarCompo, "Click", THIS, "CmdAtualizarCompoClick")
1071: 
1072:         *-- Botao 5: Atualizar pesos
1073:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_AtualizarPesos", "CommandButton")
1074:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarPesos
1075:             .Caption     = "P"
1076:             .Top         = 168
1077:             .Left        = 0
1078:             .Width       = 50
1079:             .Height      = 42
1080:             .FontName    = "Tahoma"
1081:             .FontSize    = 9
1082:             .Themes      = .F.
1083:             .SpecialEffect = 0
1084:             .BackColor   = RGB(255, 255, 255)
1085:             .ForeColor   = RGB(90, 90, 90)
1086:             .Visible     = .T.
1087:         ENDWITH
1088:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarPesos, "Click", THIS, "CmdAtualizarPesosClick")
1089: 
1090:         *----------------------------------------------------------------------
1091:         *-- Grid grdsubcp (15 colunas) - Sub-componentes
1092:         *-- Top:348 Left:6 Width:943 Height:83
1093:         *----------------------------------------------------------------------
1094:         loc_oPg.AddObject("grd_4c_SubCp", "Grid")
1095:         WITH loc_oPg.grd_4c_SubCp
1096:             .Top         = 348
1097:             .Left        = 6
1098:             .Width       = 943
1099:             .Height      = 83
1100:             .ColumnCount = 15
1101:             .FontName    = "Verdana"
1102:             .FontSize    = 8
1103:             .GridLines   = 3
1104:             .GridLineWidth = 1
1105:             .GridLineColor = RGB(238, 238, 238)
1106:             .RecordMark  = .F.
1107:             .DeleteMark  = .F.
1108:             .AllowRowSizing = .F.
1109:             .ReadOnly    = .F.
1110:             .BackColor   = RGB(255, 255, 255)
1111:             .ForeColor   = RGB(90, 90, 90)
1112:             .HighlightBackColor = RGB(220, 230, 242)
1113:             .HighlightForeColor = RGB(15, 41, 104)
1114:             .HighlightStyle = 2
1115:             .RowHeight   = 16
1116:             .ScrollBars  = 2
1117:             .Visible     = .T.
1118:         ENDWITH
1119: 
1120:         *-- RecordSource FORA do WITH
1121:         loc_oPg.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"
1122: 
1123:         *-- Configurar colunas do grd_4c_SubCp APOS RecordSource
1124:         WITH loc_oPg.grd_4c_SubCp
1125:             .Column1.Header1.Caption       = "Material"
1126:             .Column1.Width                 = 75
1127:             .Column1.ControlSource         = "cursor_4c_SubCp.mats"
1128: 

*-- Linhas 1194 a 1291:
1194:             .Column15.ControlSource        = "cursor_4c_SubCp.tamanhos"
1195:             .Column15.Alignment            = 0
1196:         ENDWITH
1197:         BINDEVENT(loc_oPg.grd_4c_SubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
1198: 
1199:         *----------------------------------------------------------------------
1200:         *-- Botoes do grdsubcp (cmdgSubCp: 2 botoes, Right of grid)
1201:         *-- Container em T:345 L:947 W:50 H:90 (cada botao 50x45)
1202:         *----------------------------------------------------------------------
1203:         loc_oPg.AddObject("cnt_4c_BotoesSubCp", "Container")
1204:         WITH loc_oPg.cnt_4c_BotoesSubCp
1205:             .Top         = 345
1206:             .Left        = 947
1207:             .Width       = 50
1208:             .Height      = 90
1209:             .BackStyle = 1
1210:             .BackColor = RGB(53, 53, 53)
1211:             .BorderWidth = 0
1212:             .Visible     = .T.
1213:         ENDWITH
1214: 
1215:         *-- Botao 1: Inserir sub-componente
1216:         loc_oPg.cnt_4c_BotoesSubCp.AddObject("cmd_4c_InserirSubCp", "CommandButton")
1217:         WITH loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_InserirSubCp
1218:             .Caption     = "+"
1219:             .Top         = 0
1220:             .Left        = 0
1221:             .Width       = 50
1222:             .Height      = 45
1223:             .FontName    = "Tahoma"
1224:             .FontSize    = 10
1225:             .FontBold    = .T.
1226:             .Themes      = .F.
1227:             .SpecialEffect = 0
1228:             .BackColor   = RGB(255, 255, 255)
1229:             .ForeColor   = RGB(0, 128, 0)
1230:             .Visible     = .T.
1231:         ENDWITH
1232:         BINDEVENT(loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_InserirSubCp, "Click", THIS, "CmdInserirSubCpClick")
1233: 
1234:         *-- Botao 2: Excluir sub-componente
1235:         loc_oPg.cnt_4c_BotoesSubCp.AddObject("cmd_4c_ExcluirSubCp", "CommandButton")
1236:         WITH loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_ExcluirSubCp
1237:             .Caption     = "-"
1238:             .Top         = 45
1239:             .Left        = 0
1240:             .Width       = 50
1241:             .Height      = 45
1242:             .FontName    = "Tahoma"
1243:             .FontSize    = 10
1244:             .FontBold    = .T.
1245:             .Themes      = .F.
1246:             .SpecialEffect = 0
1247:             .BackColor   = RGB(255, 255, 255)
1248:             .ForeColor   = RGB(192, 0, 0)
1249:             .Visible     = .T.
1250:         ENDWITH
1251:         BINDEVENT(loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_ExcluirSubCp, "Click", THIS, "CmdExcluirSubCpClick")
1252: 
1253:         *----------------------------------------------------------------------
1254:         *-- Descricao / Substitui (abaixo grdsubcp)
1255:         *-- Say3: "Descricao :" (T:435 L:39 W:55)
1256:         *-- get_desccp: (T:432 L:99 W:298 H:21) - readonly
1257:         *-- Say5: "Substitui :" (T:435 L:465 W:50)
1258:         *-- get_matsub: (T:432 L:517 W:108 H:21) - readonly
1259:         *----------------------------------------------------------------------
1260:         loc_oPg.AddObject("lbl_4c_DescCp", "Label")
1261:         WITH loc_oPg.lbl_4c_DescCp
1262:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
1263:             .Top       = 435
1264:             .Left      = 39
1265:             .Width     = 55
1266:             .Height    = 15
1267:             .FontName  = "Tahoma"
1268:             .FontSize  = 8
1269:             .BackStyle = 0
1270:             .ForeColor = RGB(90, 90, 90)
1271:             .Visible   = .T.
1272:         ENDWITH
1273: 
1274:         loc_oPg.AddObject("txt_4c_DescCp", "TextBox")
1275:         WITH loc_oPg.txt_4c_DescCp
1276:             .Top           = 432
1277:             .Left          = 99
1278:             .Width         = 298
1279:             .Height        = 21
1280:             .FontName      = "Tahoma"
1281:             .FontSize      = 8
1282:             .MaxLength     = 65
1283:             .Value         = ""
1284:             .SpecialEffect = 1
1285:             .Enabled       = .F.
1286:             .Visible       = .T.
1287:         ENDWITH
1288: 
1289:         loc_oPg.AddObject("lbl_4c_Substitui", "Label")
1290:         WITH loc_oPg.lbl_4c_Substitui
1291:             .Caption   = "Substitui :"

*-- Linhas 1420 a 1479:
1420:             .Themes    = .F.
1421:             .Visible   = .T.
1422:         ENDWITH
1423:         BINDEVENT(loc_oPg.chk_4c_LiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
1424: 
1425:         loc_oPg.AddObject("chk_4c_LiberaVenda", "CheckBox")
1426:         WITH loc_oPg.chk_4c_LiberaVenda
1427:             .Caption   = ""
1428:             .Top       = 459
1429:             .Left      = 323
1430:             .Width     = 39
1431:             .Height    = 38
1432:             .FontName  = "Tahoma"
1433:             .FontSize  = 8
1434:             .Value     = 0
1435:             .BackStyle = 0
1436:             .Themes    = .F.
1437:             .Visible   = .T.
1438:         ENDWITH
1439:         BINDEVENT(loc_oPg.chk_4c_LiberaVenda, "Click", THIS, "ChkLiberaVendaClick")
1440: 
1441:         *----------------------------------------------------------------------
1442:         *-- Linha separadora - Shape6 (T:497 L:9 W:158 H:2 - secao custo)
1443:         *-- Shape4 (T:498 L:323 W:158 H:2 - secao venda)
1444:         *----------------------------------------------------------------------
1445:         loc_oPg.AddObject("shp_4c_Shape6", "Shape")
1446:         WITH loc_oPg.shp_4c_Shape6
1447:             .Top         = 497
1448:             .Left        = 9
1449:             .Width       = 158
1450:             .Height      = 2
1451:             .FillStyle   = 0
1452:             .BackStyle   = 1
1453:             .FillColor   = RGB(128, 128, 128)
1454:             .BorderStyle = 1
1455:             .Visible     = .T.
1456:         ENDWITH
1457: 
1458:         loc_oPg.AddObject("shp_4c_Shape4", "Shape")
1459:         WITH loc_oPg.shp_4c_Shape4
1460:             .Top         = 498
1461:             .Left        = 323
1462:             .Width       = 158
1463:             .Height      = 2
1464:             .FillStyle   = 0
1465:             .BackStyle   = 1
1466:             .FillColor   = RGB(128, 128, 128)
1467:             .BorderStyle = 1
1468:             .Visible     = .T.
1469:         ENDWITH
1470: 
1471:         *----------------------------------------------------------------------
1472:         *-- Secao CUSTO (controlada por chkLiberaCusto)
1473:         *-- lblCompra: "Preco de Custo (Moeda 1)" T:502 L:9 W:127
1474:         *-- getPcus: T:517 L:9 W:115 H:23
1475:         *-- getMoec: T:517 L:127 W:31 H:23 (moeda custo 1)
1476:         *-- lblCuVda: "Fator de Custo (Moeda 2)" T:502 L:161 W:126
1477:         *-- getFcusto: T:517 L:161 W:115 H:23
1478:         *-- getMoepc: T:517 L:279 W:31 H:23 (moeda custo 2)
1479:         *-- Say8: "Total " T:542 L:161 W:29

*-- Linhas 1518 a 1834:
1518:             .Enabled       = .F.
1519:             .Visible       = .T.
1520:         ENDWITH
1521:         BINDEVENT(loc_oPg.txt_4c_Pcus, "LostFocus", THIS, "TxtPcusLostFocus")
1522: 
1523:         loc_oPg.AddObject("txt_4c_Moec", "TextBox")
1524:         WITH loc_oPg.txt_4c_Moec
1525:             .Top           = 517
1526:             .Left          = 127
1527:             .Width         = 31
1528:             .Height        = 23
1529:             .FontName      = "Tahoma"
1530:             .FontSize      = 8
1531:             .MaxLength     = 5
1532:             .Value         = ""
1533:             .SpecialEffect = 1
1534:             .ForeColor     = RGB(36, 84, 155)
1535:             .Enabled       = .F.
1536:             .Visible       = .T.
1537:         ENDWITH
1538:         BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress",  THIS, "TxtMoecKeyPress")
1539:         BINDEVENT(loc_oPg.txt_4c_Moec, "LostFocus", THIS, "TxtMoecLostFocus")
1540: 
1541:         loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
1542:         WITH loc_oPg.lbl_4c_LblCuVda
1543:             .Caption   = "Fator de Custo (Moeda 2)"
1544:             .Top       = 502
1545:             .Left      = 161
1546:             .Width     = 126
1547:             .Height    = 15
1548:             .FontName  = "Tahoma"
1549:             .FontSize  = 8
1550:             .BackStyle = 0
1551:             .ForeColor = RGB(90, 90, 90)
1552:             .Visible   = .T.
1553:         ENDWITH
1554: 
1555:         loc_oPg.AddObject("txt_4c_Fcusto", "TextBox")
1556:         WITH loc_oPg.txt_4c_Fcusto
1557:             .Top           = 517
1558:             .Left          = 161
1559:             .Width         = 115
1560:             .Height        = 23
1561:             .FontName      = "Tahoma"
1562:             .FontSize      = 8
1563:             .Value         = 0.0
1564:             .SpecialEffect = 1
1565:             .ForeColor     = RGB(36, 84, 155)
1566:             .Enabled       = .F.
1567:             .Visible       = .T.
1568:         ENDWITH
1569:         BINDEVENT(loc_oPg.txt_4c_Fcusto, "LostFocus", THIS, "TxtFcustoLostFocus")
1570: 
1571:         loc_oPg.AddObject("txt_4c_Moepc", "TextBox")
1572:         WITH loc_oPg.txt_4c_Moepc
1573:             .Top           = 517
1574:             .Left          = 279
1575:             .Width         = 31
1576:             .Height        = 23
1577:             .FontName      = "Tahoma"
1578:             .FontSize      = 8
1579:             .MaxLength     = 5
1580:             .Value         = ""
1581:             .SpecialEffect = 1
1582:             .ForeColor     = RGB(36, 84, 155)
1583:             .Enabled       = .F.
1584:             .Visible       = .T.
1585:         ENDWITH
1586:         BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress",  THIS, "TxtMoepcKeyPress")
1587:         BINDEVENT(loc_oPg.txt_4c_Moepc, "LostFocus", THIS, "TxtMoepcLostFocus")
1588: 
1589:         loc_oPg.AddObject("lbl_4c_LblTotalCusto", "Label")
1590:         WITH loc_oPg.lbl_4c_LblTotalCusto
1591:             .Caption   = "Total "
1592:             .Top       = 542
1593:             .Left      = 161
1594:             .Width     = 29
1595:             .Height    = 15
1596:             .FontName  = "Tahoma"
1597:             .FontSize  = 8
1598:             .BackStyle = 0
1599:             .ForeColor = RGB(90, 90, 90)
1600:             .Visible   = .T.
1601:         ENDWITH
1602: 
1603:         loc_oPg.AddObject("txt_4c_Custof", "TextBox")
1604:         WITH loc_oPg.txt_4c_Custof
1605:             .Top           = 557
1606:             .Left          = 161
1607:             .Width         = 115
1608:             .Height        = 23
1609:             .FontName      = "Tahoma"
1610:             .FontSize      = 8
1611:             .Value         = 0.0
1612:             .SpecialEffect = 1
1613:             .ForeColor     = RGB(36, 84, 155)
1614:             .Enabled       = .F.
1615:             .Visible       = .T.
1616:         ENDWITH
1617:         BINDEVENT(loc_oPg.txt_4c_Custof, "LostFocus", THIS, "TxtCustofLostFocus")
1618: 
1619:         loc_oPg.AddObject("txt_4c_Moecusf", "TextBox")
1620:         WITH loc_oPg.txt_4c_Moecusf
1621:             .Top           = 557
1622:             .Left          = 279
1623:             .Width         = 31
1624:             .Height        = 23
1625:             .FontName      = "Tahoma"
1626:             .FontSize      = 8
1627:             .MaxLength     = 5
1628:             .Value         = ""
1629:             .SpecialEffect = 1
1630:             .ForeColor     = RGB(36, 84, 155)
1631:             .Enabled       = .F.
1632:             .Visible       = .T.
1633:         ENDWITH
1634:         BINDEVENT(loc_oPg.txt_4c_Moecusf, "KeyPress",  THIS, "TxtMoecusfKeyPress")
1635:         BINDEVENT(loc_oPg.txt_4c_Moecusf, "LostFocus", THIS, "TxtMoecusfLostFocus")
1636: 
1637:         loc_oPg.AddObject("lbl_4c_LblMkp", "Label")
1638:         WITH loc_oPg.lbl_4c_LblMkp
1639:             .Caption   = "MKP"
1640:             .Top       = 542
1641:             .Left      = 9
1642:             .Width     = 22
1643:             .Height    = 15
1644:             .FontName  = "Tahoma"
1645:             .FontSize  = 8
1646:             .BackStyle = 0
1647:             .ForeColor = RGB(90, 90, 90)
1648:             .Visible   = .T.
1649:         ENDWITH
1650: 
1651:         loc_oPg.AddObject("txt_4c_GetCmkpc", "TextBox")
1652:         WITH loc_oPg.txt_4c_GetCmkpc
1653:             .Top           = 557
1654:             .Left          = 9
1655:             .Width         = 24
1656:             .Height        = 23
1657:             .FontName      = "Tahoma"
1658:             .FontSize      = 8
1659:             .MaxLength     = 5
1660:             .Value         = ""
1661:             .SpecialEffect = 1
1662:             .ForeColor     = RGB(36, 84, 155)
1663:             .Enabled       = .F.
1664:             .Visible       = .T.
1665:         ENDWITH
1666:         BINDEVENT(loc_oPg.txt_4c_GetCmkpc, "KeyPress",  THIS, "TxtGetCmkpcKeyPress")
1667:         BINDEVENT(loc_oPg.txt_4c_GetCmkpc, "LostFocus", THIS, "TxtGetCmkpcLostFocus")
1668: 
1669:         loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
1670:         WITH loc_oPg.lbl_4c_LblValAdics
1671:             .Caption   = "Valor Adicional"
1672:             .Top       = 542
1673:             .Left      = 64
1674:             .Width     = 71
1675:             .Height    = 15
1676:             .FontName  = "Tahoma"
1677:             .FontSize  = 8
1678:             .BackStyle = 0
1679:             .ForeColor = RGB(90, 90, 90)
1680:             .Visible   = .T.
1681:         ENDWITH
1682: 
1683:         loc_oPg.AddObject("txt_4c_GetPftioc", "TextBox")
1684:         WITH loc_oPg.txt_4c_GetPftioc
1685:             .Top           = 557
1686:             .Left          = 64
1687:             .Width         = 94
1688:             .Height        = 23
1689:             .FontName      = "Tahoma"
1690:             .FontSize      = 8
1691:             .MaxLength     = 5
1692:             .Value         = ""
1693:             .SpecialEffect = 1
1694:             .ForeColor     = RGB(36, 84, 155)
1695:             .Enabled       = .F.
1696:             .Visible       = .T.
1697:         ENDWITH
1698:         BINDEVENT(loc_oPg.txt_4c_GetPftioc, "KeyPress",  THIS, "TxtGetPftiocKeyPress")
1699:         BINDEVENT(loc_oPg.txt_4c_GetPftioc, "LostFocus", THIS, "TxtGetPftiocLostFocus")
1700: 
1701:         *-- chkPlanCus (T:556 L:36 W:25 H:25) - plano custo
1702:         loc_oPg.AddObject("chk_4c_PlanCus", "CheckBox")
1703:         WITH loc_oPg.chk_4c_PlanCus
1704:             .Caption   = ""
1705:             .Top       = 556
1706:             .Left      = 36
1707:             .Width     = 25
1708:             .Height    = 25
1709:             .Value     = 0
1710:             .BackStyle = 0
1711:             .Themes    = .F.
1712:             .Enabled   = .F.
1713:             .Visible   = .T.
1714:         ENDWITH
1715:         BINDEVENT(loc_oPg.chk_4c_PlanCus, "Click", THIS, "ChkPlanCusClick")
1716: 
1717:         loc_oPg.AddObject("lbl_4c_PesoMedio", "Label")
1718:         WITH loc_oPg.lbl_4c_PesoMedio
1719:             .Caption   = "Peso M" + CHR(233) + "dio"
1720:             .Top       = 581
1721:             .Left      = 10
1722:             .Width     = 56
1723:             .Height    = 15
1724:             .FontName  = "Tahoma"
1725:             .FontSize  = 8
1726:             .BackStyle = 0
1727:             .ForeColor = RGB(90, 90, 90)
1728:             .Visible   = .T.
1729:         ENDWITH
1730: 
1731:         loc_oPg.AddObject("txt_4c_Pesom", "TextBox")
1732:         WITH loc_oPg.txt_4c_Pesom
1733:             .Top           = 596
1734:             .Left          = 10
1735:             .Width         = 79
1736:             .Height        = 23
1737:             .FontName      = "Tahoma"
1738:             .FontSize      = 8
1739:             .Value         = 0.0
1740:             .SpecialEffect = 1
1741:             .ForeColor     = RGB(36, 84, 155)
1742:             .Enabled       = .F.
1743:             .Visible       = .T.
1744:         ENDWITH
1745:         BINDEVENT(loc_oPg.txt_4c_Pesom, "LostFocus", THIS, "TxtPesomLostFocus")
1746: 
1747:         *-- cmdPesoM: "..." T:597 L:92 W:26 H:23
1748:         loc_oPg.AddObject("cmd_4c_PesoM", "CommandButton")
1749:         WITH loc_oPg.cmd_4c_PesoM
1750:             .Caption     = "..."
1751:             .Top         = 597
1752:             .Left        = 92
1753:             .Width       = 26
1754:             .Height      = 23
1755:             .FontName    = "Tahoma"
1756:             .FontSize    = 8
1757:             .Themes      = .F.
1758:             .SpecialEffect = 0
1759:             .BackColor   = RGB(255, 255, 255)
1760:             .ForeColor   = RGB(90, 90, 90)
1761:             .Enabled     = .F.
1762:             .Visible     = .T.
1763:         ENDWITH
1764:         BINDEVENT(loc_oPg.cmd_4c_PesoM, "Click", THIS, "CmdPesoMClick")
1765: 
1766:         loc_oPg.AddObject("lbl_4c_LblCotacao", "Label")
1767:         WITH loc_oPg.lbl_4c_LblCotacao
1768:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
1769:             .Top       = 581
1770:             .Left      = 161
1771:             .Width     = 42
1772:             .Height    = 15
1773:             .FontName  = "Tahoma"
1774:             .FontSize  = 8
1775:             .BackStyle = 0
1776:             .ForeColor = RGB(90, 90, 90)
1777:             .Visible   = .T.
1778:         ENDWITH
1779: 
1780:         loc_oPg.AddObject("txt_4c_CotaCalcP", "TextBox")
1781:         WITH loc_oPg.txt_4c_CotaCalcP
1782:             .Top           = 596
1783:             .Left          = 161
1784:             .Width         = 115
1785:             .Height        = 23
1786:             .FontName      = "Tahoma"
1787:             .FontSize      = 8
1788:             .Value         = 0.0
1789:             .SpecialEffect = 1
1790:             .ForeColor     = RGB(36, 84, 155)
1791:             .Enabled       = .F.
1792:             .Visible       = .T.
1793:         ENDWITH
1794:         BINDEVENT(loc_oPg.txt_4c_CotaCalcP, "LostFocus", THIS, "TxtCotaCalcPLostFocus")
1795: 
1796:         *----------------------------------------------------------------------
1797:         *-- Secao VENDA (controlada por chkLiberaVenda)
1798:         *-- lblMkpVenda: "MKP Ideal" T:504 L:324 W:49
1799:         *-- getMargem: T:517 L:323 W:89 H:23
1800:         *-- Say24: "Sts" T:542 L:324 W:17
1801:         *-- getStatus: T:557 L:324 W:31 H:23 (status lookup SigCdPst)
1802:         *-- lblMkpApl: "MKP Aplic." T:581 L:324 W:51
1803:         *-- getMarkupA: T:596 L:323 W:62 H:23
1804:         *-- Chk_Pvenda: T:595 L:387 W:25 H:25
1805:         *-- chkPlanVen: T:556 L:387 W:25 H:25
1806:         *-- Say14: "MKP" T:542 L:360 W:22
1807:         *-- Getftio: T:557 L:360 W:24 H:23 (MKP fator)
1808:         *-- lblIdeal: "Preco Ideal (Moeda 1)" T:503 L:416 W:111
1809:         *-- Say13: "Valor Adicional" T:542 L:416 W:71
1810:         *-- Get_Pftio: T:557 L:416 W:110 H:23 (fator adicional)
1811:         *-- getMoeda: T:517 L:529 W:31 H:23 (moeda venda ideal)
1812:         *-- Say12: "Fator" T:542 L:563 W:28
1813:         *-- Get_mftio: T:557 L:529 W:31 H:23 (moeda fator)
1814:         *-- getFIdeals: T:517 L:563 W:110 H:23
1815:         *-- getPvideal: T:517 L:416 W:110 H:23 (preco ideal)
1816:         *-- lblVenda: "Preco Atual (Moeda 2)" T:581 L:416 W:115
1817:         *-- getMoepv: T:557 L:677 W:31 H:23 (moeda preco venda)
1818:         *-- getMoev: T:596 L:529 W:31 H:23 (moeda venda)
1819:         *-- getFvenda: T:557 L:563 W:110 H:23 (fator venda)
1820:         *-- getPven: T:596 L:416 W:110 H:23 (preco venda)
1821:         *-- lblFIdeals: "Fator Ideal" T:503 L:563 W:55
1822:         *-- lblFAtuals: "Fator Atual" T:581 L:563 W:56
1823:         *-- getFAtuals: T:596 L:563 W:110 H:23
1824:         *-- Say25: "Financeiro" T:581 L:678 W:51
1825:         *-- Get_Encarg: T:595 L:678 W:62 H:23
1826:         *-- cmdCalcVals: T:507 L:678 W:40 H:40
1827:         *----------------------------------------------------------------------
1828: 
1829:         loc_oPg.AddObject("lbl_4c_LblMkpVenda", "Label")
1830:         WITH loc_oPg.lbl_4c_LblMkpVenda
1831:             .Caption   = "MKP Ideal"
1832:             .Top       = 504
1833:             .Left      = 324
1834:             .Width     = 49

*-- Linhas 1854 a 2132:
1854:             .Enabled       = .F.
1855:             .Visible       = .T.
1856:         ENDWITH
1857:         BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TxtMargemLostFocus")
1858: 
1859:         loc_oPg.AddObject("lbl_4c_LblSts", "Label")
1860:         WITH loc_oPg.lbl_4c_LblSts
1861:             .Caption   = "Sts"
1862:             .Top       = 542
1863:             .Left      = 324
1864:             .Width     = 17
1865:             .Height    = 15
1866:             .FontName  = "Tahoma"
1867:             .FontSize  = 8
1868:             .BackStyle = 0
1869:             .ForeColor = RGB(90, 90, 90)
1870:             .Visible   = .T.
1871:         ENDWITH
1872: 
1873:         loc_oPg.AddObject("txt_4c_GetStatus", "TextBox")
1874:         WITH loc_oPg.txt_4c_GetStatus
1875:             .Top           = 557
1876:             .Left          = 324
1877:             .Width         = 31
1878:             .Height        = 23
1879:             .FontName      = "Tahoma"
1880:             .FontSize      = 8
1881:             .MaxLength     = 5
1882:             .Value         = ""
1883:             .SpecialEffect = 1
1884:             .ForeColor     = RGB(36, 84, 155)
1885:             .Enabled       = .F.
1886:             .Visible       = .T.
1887:         ENDWITH
1888:         BINDEVENT(loc_oPg.txt_4c_GetStatus, "KeyPress",  THIS, "TxtGetStatusKeyPress")
1889:         BINDEVENT(loc_oPg.txt_4c_GetStatus, "LostFocus", THIS, "TxtGetStatusLostFocus")
1890: 
1891:         loc_oPg.AddObject("lbl_4c_LblMkpApl", "Label")
1892:         WITH loc_oPg.lbl_4c_LblMkpApl
1893:             .Caption   = "MKP Aplic."
1894:             .Top       = 581
1895:             .Left      = 324
1896:             .Width     = 51
1897:             .Height    = 15
1898:             .FontName  = "Tahoma"
1899:             .FontSize  = 8
1900:             .BackStyle = 0
1901:             .ForeColor = RGB(90, 90, 90)
1902:             .Visible   = .T.
1903:         ENDWITH
1904: 
1905:         loc_oPg.AddObject("txt_4c_MarkupA", "TextBox")
1906:         WITH loc_oPg.txt_4c_MarkupA
1907:             .Top           = 596
1908:             .Left          = 323
1909:             .Width         = 62
1910:             .Height        = 23
1911:             .FontName      = "Tahoma"
1912:             .FontSize      = 8
1913:             .Value         = 0.0
1914:             .SpecialEffect = 1
1915:             .ForeColor     = RGB(36, 84, 155)
1916:             .Enabled       = .F.
1917:             .Visible       = .T.
1918:         ENDWITH
1919:         BINDEVENT(loc_oPg.txt_4c_MarkupA, "LostFocus", THIS, "TxtMarkupALostFocus")
1920: 
1921:         *-- Chk_Pvenda (T:595 L:387 W:25 H:25) - usa preco de venda atual
1922:         loc_oPg.AddObject("chk_4c_PVenda", "CheckBox")
1923:         WITH loc_oPg.chk_4c_PVenda
1924:             .Caption   = ""
1925:             .Top       = 595
1926:             .Left      = 387
1927:             .Width     = 25
1928:             .Height    = 25
1929:             .Value     = 0
1930:             .BackStyle = 0
1931:             .Themes    = .F.
1932:             .Enabled   = .F.
1933:             .Visible   = .T.
1934:         ENDWITH
1935:         BINDEVENT(loc_oPg.chk_4c_PVenda, "Click", THIS, "ChkPVendaClick")
1936: 
1937:         *-- chkPlanVen (T:556 L:387 W:25 H:25) - plano venda
1938:         loc_oPg.AddObject("chk_4c_PlanVen", "CheckBox")
1939:         WITH loc_oPg.chk_4c_PlanVen
1940:             .Caption   = ""
1941:             .Top       = 556
1942:             .Left      = 387
1943:             .Width     = 25
1944:             .Height    = 25
1945:             .Value     = 0
1946:             .BackStyle = 0
1947:             .Themes    = .F.
1948:             .Enabled   = .F.
1949:             .Visible   = .T.
1950:         ENDWITH
1951:         BINDEVENT(loc_oPg.chk_4c_PlanVen, "Click", THIS, "ChkPlanVenClick")
1952: 
1953:         loc_oPg.AddObject("lbl_4c_LblMkpFat", "Label")
1954:         WITH loc_oPg.lbl_4c_LblMkpFat
1955:             .Caption   = "MKP"
1956:             .Top       = 542
1957:             .Left      = 360
1958:             .Width     = 22
1959:             .Height    = 15
1960:             .FontName  = "Tahoma"
1961:             .FontSize  = 8
1962:             .BackStyle = 0
1963:             .ForeColor = RGB(90, 90, 90)
1964:             .Visible   = .T.
1965:         ENDWITH
1966: 
1967:         loc_oPg.AddObject("txt_4c_Getftio", "TextBox")
1968:         WITH loc_oPg.txt_4c_Getftio
1969:             .Top           = 557
1970:             .Left          = 360
1971:             .Width         = 24
1972:             .Height        = 23
1973:             .FontName      = "Tahoma"
1974:             .FontSize      = 8
1975:             .MaxLength     = 5
1976:             .Value         = ""
1977:             .SpecialEffect = 1
1978:             .ForeColor     = RGB(36, 84, 155)
1979:             .Enabled       = .F.
1980:             .Visible       = .T.
1981:         ENDWITH
1982:         BINDEVENT(loc_oPg.txt_4c_Getftio, "KeyPress",  THIS, "TxtGetftioKeyPress")
1983:         BINDEVENT(loc_oPg.txt_4c_Getftio, "LostFocus", THIS, "TxtGetftioLostFocus")
1984: 
1985:         loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
1986:         WITH loc_oPg.lbl_4c_LblIdeal
1987:             .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
1988:             .Top       = 503
1989:             .Left      = 416
1990:             .Width     = 111
1991:             .Height    = 15
1992:             .FontName  = "Tahoma"
1993:             .FontSize  = 8
1994:             .BackStyle = 0
1995:             .ForeColor = RGB(90, 90, 90)
1996:             .Visible   = .T.
1997:         ENDWITH
1998: 
1999:         loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
2000:         WITH loc_oPg.txt_4c_Pvideal
2001:             .Top           = 517
2002:             .Left          = 416
2003:             .Width         = 110
2004:             .Height        = 23
2005:             .FontName      = "Tahoma"
2006:             .FontSize      = 8
2007:             .Value         = 0.0
2008:             .SpecialEffect = 1
2009:             .ForeColor     = RGB(36, 84, 155)
2010:             .Enabled       = .F.
2011:             .Visible       = .T.
2012:         ENDWITH
2013:         BINDEVENT(loc_oPg.txt_4c_Pvideal, "LostFocus", THIS, "TxtPvidealLostFocus")
2014: 
2015:         loc_oPg.AddObject("lbl_4c_LblValAdicV", "Label")
2016:         WITH loc_oPg.lbl_4c_LblValAdicV
2017:             .Caption   = "Valor Adicional"
2018:             .Top       = 542
2019:             .Left      = 416
2020:             .Width     = 71
2021:             .Height    = 15
2022:             .FontName  = "Tahoma"
2023:             .FontSize  = 8
2024:             .BackStyle = 0
2025:             .ForeColor = RGB(90, 90, 90)
2026:             .Visible   = .T.
2027:         ENDWITH
2028: 
2029:         loc_oPg.AddObject("txt_4c_GetPftio", "TextBox")
2030:         WITH loc_oPg.txt_4c_GetPftio
2031:             .Top           = 557
2032:             .Left          = 416
2033:             .Width         = 110
2034:             .Height        = 23
2035:             .FontName      = "Tahoma"
2036:             .FontSize      = 8
2037:             .MaxLength     = 5
2038:             .Value         = ""
2039:             .SpecialEffect = 1
2040:             .ForeColor     = RGB(36, 84, 155)
2041:             .Enabled       = .F.
2042:             .Visible       = .T.
2043:         ENDWITH
2044: 
2045:         loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
2046:         WITH loc_oPg.txt_4c_Moeda
2047:             .Top           = 517
2048:             .Left          = 529
2049:             .Width         = 31
2050:             .Height        = 23
2051:             .FontName      = "Tahoma"
2052:             .FontSize      = 8
2053:             .MaxLength     = 5
2054:             .Value         = ""
2055:             .SpecialEffect = 1
2056:             .ForeColor     = RGB(36, 84, 155)
2057:             .Enabled       = .F.
2058:             .Visible       = .T.
2059:         ENDWITH
2060:         BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress",  THIS, "TxtMoedaKeyPress")
2061:         BINDEVENT(loc_oPg.txt_4c_Moeda, "LostFocus", THIS, "TxtMoedaLostFocus")
2062: 
2063:         loc_oPg.AddObject("lbl_4c_LblFatorI", "Label")
2064:         WITH loc_oPg.lbl_4c_LblFatorI
2065:             .Caption   = "Fator"
2066:             .Top       = 542
2067:             .Left      = 563
2068:             .Width     = 28
2069:             .Height    = 15
2070:             .FontName  = "Tahoma"
2071:             .FontSize  = 8
2072:             .BackStyle = 0
2073:             .ForeColor = RGB(90, 90, 90)
2074:             .Visible   = .T.
2075:         ENDWITH
2076: 
2077:         loc_oPg.AddObject("txt_4c_GetMftio", "TextBox")
2078:         WITH loc_oPg.txt_4c_GetMftio
2079:             .Top           = 557
2080:             .Left          = 529
2081:             .Width         = 31
2082:             .Height        = 23
2083:             .FontName      = "Tahoma"
2084:             .FontSize      = 8
2085:             .MaxLength     = 5
2086:             .Value         = ""
2087:             .SpecialEffect = 1
2088:             .ForeColor     = RGB(36, 84, 155)
2089:             .Enabled       = .F.
2090:             .Visible       = .T.
2091:         ENDWITH
2092:         BINDEVENT(loc_oPg.txt_4c_GetMftio, "LostFocus", THIS, "TxtGetMftioLostFocus")
2093: 
2094:         loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
2095:         WITH loc_oPg.lbl_4c_LblFIdeals
2096:             .Caption   = "Fator Ideal"
2097:             .Top       = 503
2098:             .Left      = 563
2099:             .Width     = 55
2100:             .Height    = 15
2101:             .FontName  = "Tahoma"
2102:             .FontSize  = 8
2103:             .BackStyle = 0
2104:             .ForeColor = RGB(90, 90, 90)
2105:             .Visible   = .T.
2106:         ENDWITH
2107: 
2108:         loc_oPg.AddObject("txt_4c_FIdeals", "TextBox")
2109:         WITH loc_oPg.txt_4c_FIdeals
2110:             .Top           = 517
2111:             .Left          = 563
2112:             .Width         = 110
2113:             .Height        = 23
2114:             .FontName      = "Tahoma"
2115:             .FontSize      = 8
2116:             .Value         = 0.0
2117:             .SpecialEffect = 1
2118:             .ForeColor     = RGB(36, 84, 155)
2119:             .Enabled       = .F.
2120:             .Visible       = .T.
2121:         ENDWITH
2122: 
2123:         loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
2124:         WITH loc_oPg.lbl_4c_LblVenda
2125:             .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
2126:             .Top       = 581
2127:             .Left      = 416
2128:             .Width     = 115
2129:             .Height    = 15
2130:             .FontName  = "Tahoma"
2131:             .FontSize  = 8
2132:             .BackStyle = 0

*-- Linhas 2149 a 2243:
2149:             .Enabled       = .F.
2150:             .Visible       = .T.
2151:         ENDWITH
2152:         BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress",  THIS, "TxtMoepvKeyPress")
2153:         BINDEVENT(loc_oPg.txt_4c_Moepv, "LostFocus", THIS, "TxtMoepvLostFocus")
2154: 
2155:         loc_oPg.AddObject("txt_4c_Moev", "TextBox")
2156:         WITH loc_oPg.txt_4c_Moev
2157:             .Top           = 596
2158:             .Left          = 529
2159:             .Width         = 31
2160:             .Height        = 23
2161:             .FontName      = "Tahoma"
2162:             .FontSize      = 8
2163:             .MaxLength     = 5
2164:             .Value         = ""
2165:             .SpecialEffect = 1
2166:             .ForeColor     = RGB(36, 84, 155)
2167:             .Enabled       = .F.
2168:             .Visible       = .T.
2169:         ENDWITH
2170:         BINDEVENT(loc_oPg.txt_4c_Moev, "KeyPress",  THIS, "TxtMoevKeyPress")
2171:         BINDEVENT(loc_oPg.txt_4c_Moev, "LostFocus", THIS, "TxtMoevLostFocus")
2172: 
2173:         loc_oPg.AddObject("txt_4c_Fvenda", "TextBox")
2174:         WITH loc_oPg.txt_4c_Fvenda
2175:             .Top           = 557
2176:             .Left          = 563
2177:             .Width         = 110
2178:             .Height        = 23
2179:             .FontName      = "Tahoma"
2180:             .FontSize      = 8
2181:             .Value         = 0.0
2182:             .SpecialEffect = 1
2183:             .ForeColor     = RGB(36, 84, 155)
2184:             .Enabled       = .F.
2185:             .Visible       = .T.
2186:         ENDWITH
2187:         BINDEVENT(loc_oPg.txt_4c_Fvenda, "LostFocus", THIS, "TxtFvendaLostFocus")
2188: 
2189:         loc_oPg.AddObject("txt_4c_Pven", "TextBox")
2190:         WITH loc_oPg.txt_4c_Pven
2191:             .Top           = 596
2192:             .Left          = 416
2193:             .Width         = 110
2194:             .Height        = 23
2195:             .FontName      = "Tahoma"
2196:             .FontSize      = 8
2197:             .Value         = 0.0
2198:             .SpecialEffect = 1
2199:             .ForeColor     = RGB(36, 84, 155)
2200:             .Enabled       = .F.
2201:             .Visible       = .T.
2202:         ENDWITH
2203:         BINDEVENT(loc_oPg.txt_4c_Pven, "LostFocus", THIS, "TxtPvenLostFocus")
2204: 
2205:         loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
2206:         WITH loc_oPg.lbl_4c_LblFAtuals
2207:             .Caption   = "Fator Atual"
2208:             .Top       = 581
2209:             .Left      = 563
2210:             .Width     = 56
2211:             .Height    = 15
2212:             .FontName  = "Tahoma"
2213:             .FontSize  = 8
2214:             .BackStyle = 0
2215:             .ForeColor = RGB(90, 90, 90)
2216:             .Visible   = .T.
2217:         ENDWITH
2218: 
2219:         loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
2220:         WITH loc_oPg.txt_4c_FAtuals
2221:             .Top           = 596
2222:             .Left          = 563
2223:             .Width         = 110
2224:             .Height        = 23
2225:             .FontName      = "Tahoma"
2226:             .FontSize      = 8
2227:             .Value         = 0.0
2228:             .SpecialEffect = 1
2229:             .ForeColor     = RGB(36, 84, 155)
2230:             .Enabled       = .F.
2231:             .Visible       = .T.
2232:         ENDWITH
2233: 
2234:         loc_oPg.AddObject("lbl_4c_LblFinanc", "Label")
2235:         WITH loc_oPg.lbl_4c_LblFinanc
2236:             .Caption   = "Financeiro"
2237:             .Top       = 581
2238:             .Left      = 678
2239:             .Width     = 51
2240:             .Height    = 15
2241:             .FontName  = "Tahoma"
2242:             .FontSize  = 8
2243:             .BackStyle = 0

*-- Linhas 2259 a 2321:
2259:             .Enabled       = .F.
2260:             .Visible       = .T.
2261:         ENDWITH
2262:         BINDEVENT(loc_oPg.txt_4c_GetEncarg, "LostFocus", THIS, "TxtGetEncargLostFocus")
2263: 
2264:         *-- cmdCalcVals (T:507 L:678 W:40 H:40) - calcular valores
2265:         loc_oPg.AddObject("cmd_4c_CalcVals", "CommandButton")
2266:         WITH loc_oPg.cmd_4c_CalcVals
2267:             .Caption     = "Calc."
2268:             .Top         = 507
2269:             .Left        = 678
2270:             .Width       = 40
2271:             .Height      = 40
2272:             .FontName    = "Tahoma"
2273:             .FontSize    = 7
2274:             .Themes      = .F.
2275:             .SpecialEffect = 0
2276:             .BackColor   = RGB(255, 255, 255)
2277:             .ForeColor   = RGB(90, 90, 90)
2278:             .Enabled     = .F.
2279:             .Visible     = .T.
2280:         ENDWITH
2281:         BINDEVENT(loc_oPg.cmd_4c_CalcVals, "Click", THIS, "CmdCalcValsClick")
2282: 
2283:         *----------------------------------------------------------------------
2284:         *-- Container cntMtPrima (T:511 L:752 W:242 H:108)
2285:         *-- Controles internos: Composicao, Montagem, Digitos, Ordem, Casas
2286:         *----------------------------------------------------------------------
2287:         loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
2288:         WITH loc_oPg.cnt_4c_MtPrima
2289:             .Top         = 511
2290:             .Left        = 752
2291:             .Width       = 242
2292:             .Height      = 108
2293:             .BackStyle   = 1
2294:             .BackColor   = RGB(240, 240, 240)
2295:             .BorderWidth = 1
2296:             .Visible     = .T.
2297:         ENDWITH
2298: 
2299:         *-- lblCompos: "Composicao :" T:1 L:6 W:66
2300:         loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_LblCompos", "Label")
2301:         WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_LblCompos
2302:             .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
2303:             .Top       = 1
2304:             .Left      = 6
2305:             .Width     = 66
2306:             .Height    = 15
2307:             .FontName  = "Tahoma"
2308:             .FontSize  = 8
2309:             .BackStyle = 0
2310:             .ForeColor = RGB(90, 90, 90)
2311:             .Visible   = .T.
2312:         ENDWITH
2313: 
2314:         *-- getCompos: T:18 L:6 W:233
2315:         loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_Compos", "TextBox")
2316:         WITH loc_oPg.cnt_4c_MtPrima.txt_4c_Compos
2317:             .Top           = 18
2318:             .Left          = 6
2319:             .Width         = 233
2320:             .Height        = 21
2321:             .FontName      = "Tahoma"

*-- Linhas 2453 a 3279:
2453: 
2454:     *==========================================================================
2455:     * FASE 9 - Handlers publicos da aba Composicao
2456:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
2457:     *==========================================================================
2458: 
2459:     *--------------------------------------------------------------------------
2460:     * GrdCompoAfterRowColChange - Atualiza Get_Desc e getObsOFs ao navegar
2461:     *--------------------------------------------------------------------------
2462:     PROCEDURE GrdCompoAfterRowColChange(par_nColIndex)
2463:         LOCAL loc_oPg
2464:         TRY
2465:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2466:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
2467:                 loc_oPg.txt_4c_Desc.Value  = ALLTRIM(cursor_4c_Compo.dcomps)
2468:                 loc_oPg.txt_4c_MatSub.Value = ALLTRIM(cursor_4c_Compo.matrizes)
2469:             ENDIF
2470:         CATCH TO loc_oErro
2471:             *-- silencioso: refresh de display nao deve bloquear navegacao
2472:         ENDTRY
2473:     ENDPROC
2474: 
2475:     *--------------------------------------------------------------------------
2476:     * GrdSubCpAfterRowColChange - Atualiza get_desccp e get_matsub ao navegar
2477:     *--------------------------------------------------------------------------
2478:     PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
2479:         LOCAL loc_oPg
2480:         TRY
2481:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2482:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
2483:                 loc_oPg.txt_4c_DescCp.Value  = ALLTRIM(cursor_4c_SubCp.dcomps)
2484:                 loc_oPg.txt_4c_MatSub.Value  = ALLTRIM(cursor_4c_SubCp.matrizes)
2485:             ENDIF
2486:         CATCH TO loc_oErro
2487:             *-- silencioso
2488:         ENDTRY
2489:     ENDPROC
2490: 
2491:     *--------------------------------------------------------------------------
2492:     * ChkLiberaCustoClick - Habilita/desabilita campos de custo
2493:     *--------------------------------------------------------------------------
2494:     PROCEDURE ChkLiberaCustoClick()
2495:         LOCAL loc_oPg, loc_lLivre
2496:         TRY
2497:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2498:             loc_lLivre = (loc_oPg.chk_4c_LiberaCusto.Value = 1) AND ;
2499:                          INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2500:             loc_oPg.txt_4c_Pcus.Enabled       = loc_lLivre
2501:             loc_oPg.txt_4c_Moec.Enabled        = loc_lLivre
2502:             loc_oPg.txt_4c_Fcusto.Enabled      = loc_lLivre
2503:             loc_oPg.txt_4c_Moepc.Enabled       = loc_lLivre
2504:             loc_oPg.txt_4c_Custof.Enabled      = loc_lLivre
2505:             loc_oPg.txt_4c_Moecusf.Enabled     = loc_lLivre
2506:             loc_oPg.txt_4c_GetCmkpc.Enabled    = loc_lLivre
2507:             loc_oPg.txt_4c_GetPftioc.Enabled   = loc_lLivre
2508:             loc_oPg.chk_4c_PlanCus.Enabled     = loc_lLivre
2509:             loc_oPg.txt_4c_Pesom.Enabled        = loc_lLivre
2510:             loc_oPg.cmd_4c_PesoM.Enabled        = loc_lLivre
2511:             loc_oPg.txt_4c_CotaCalcP.Enabled   = loc_lLivre
2512:         CATCH TO loc_oErro
2513:             MsgErro(loc_oErro.Message, "Erro ao alterar libera" + CHR(231) + CHR(227) + "o custo")
2514:         ENDTRY
2515:     ENDPROC
2516: 
2517:     *--------------------------------------------------------------------------
2518:     * ChkLiberaVendaClick - Habilita/desabilita campos de venda
2519:     *--------------------------------------------------------------------------
2520:     PROCEDURE ChkLiberaVendaClick()
2521:         LOCAL loc_oPg, loc_lLivre
2522:         TRY
2523:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2524:             loc_lLivre = (loc_oPg.chk_4c_LiberaVenda.Value = 1) AND ;
2525:                          INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2526:             loc_oPg.txt_4c_Margem.Enabled      = loc_lLivre
2527:             loc_oPg.txt_4c_GetStatus.Enabled   = loc_lLivre
2528:             loc_oPg.txt_4c_MarkupA.Enabled     = loc_lLivre
2529:             loc_oPg.chk_4c_PVenda.Enabled      = loc_lLivre
2530:             loc_oPg.chk_4c_PlanVen.Enabled     = loc_lLivre
2531:             loc_oPg.txt_4c_Getftio.Enabled     = loc_lLivre
2532:             loc_oPg.txt_4c_Pvideal.Enabled     = loc_lLivre
2533:             loc_oPg.txt_4c_Moeda.Enabled        = loc_lLivre
2534:             loc_oPg.txt_4c_GetPftio.Enabled    = loc_lLivre
2535:             loc_oPg.txt_4c_GetMftio.Enabled    = loc_lLivre
2536:             loc_oPg.txt_4c_FIdeals.Enabled     = loc_lLivre
2537:             loc_oPg.txt_4c_Moepv.Enabled        = loc_lLivre
2538:             loc_oPg.txt_4c_Moev.Enabled         = loc_lLivre
2539:             loc_oPg.txt_4c_Fvenda.Enabled       = loc_lLivre
2540:             loc_oPg.txt_4c_Pven.Enabled         = loc_lLivre
2541:             loc_oPg.txt_4c_FAtuals.Enabled      = loc_lLivre
2542:             loc_oPg.txt_4c_GetEncarg.Enabled    = loc_lLivre
2543:         CATCH TO loc_oErro
2544:             MsgErro(loc_oErro.Message, "Erro ao alterar libera" + CHR(231) + CHR(227) + "o venda")
2545:         ENDTRY
2546:     ENDPROC
2547: 
2548:     *--------------------------------------------------------------------------
2549:     * CmdInserirCompoClick - Adiciona nova linha na composicao
2550:     *--------------------------------------------------------------------------
2551:     PROCEDURE CmdInserirCompoClick()
2552:         TRY
2553:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2554:                 RETURN
2555:             ENDIF
2556:             IF USED("cursor_4c_Compo")
2557:                 SELECT cursor_4c_Compo
2558:                 APPEND BLANK
2559:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2560:             ENDIF
2561:         CATCH TO loc_oErro
2562:             MsgErro(loc_oErro.Message, "Erro ao inserir componente")
2563:         ENDTRY
2564:     ENDPROC
2565: 
2566:     *--------------------------------------------------------------------------
2567:     * CmdExcluirCompoClick - Remove linha da composicao
2568:     *--------------------------------------------------------------------------
2569:     PROCEDURE CmdExcluirCompoClick()
2570:         LOCAL loc_lConfirma
2571:         TRY
2572:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2573:                 RETURN
2574:             ENDIF
2575:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
2576:                 loc_lConfirma = MsgConfirma("Excluir componente selecionado?")
2577:                 IF loc_lConfirma
2578:                     SELECT cursor_4c_Compo
2579:                     DELETE
2580:                     IF !EOF()
2581:                         SKIP
2582:                         SKIP -1
2583:                     ENDIF
2584:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2585:                 ENDIF
2586:             ENDIF
2587:         CATCH TO loc_oErro
2588:             MsgErro(loc_oErro.Message, "Erro ao excluir componente")
2589:         ENDTRY
2590:     ENDPROC
2591: 
2592:     *--------------------------------------------------------------------------
2593:     * CmdCalcFornecClick - Recalcula precos de custo via fornecedor
2594:     *--------------------------------------------------------------------------
2595:     PROCEDURE CmdCalcFornecClick()
2596:         TRY
2597:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2598:                 RETURN
2599:             ENDIF
2600:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2601:                 THIS.this_oBusinessObject.CalcFornec()
2602:             ENDIF
2603:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2604:         CATCH TO loc_oErro
2605:             MsgErro(loc_oErro.Message, "Erro ao calcular por fornecedor")
2606:         ENDTRY
2607:     ENDPROC
2608: 
2609:     *--------------------------------------------------------------------------
2610:     * CmdAtualizarCompoClick - Atualiza composicao (recalcula totais/grupos)
2611:     *--------------------------------------------------------------------------
2612:     PROCEDURE CmdAtualizarCompoClick()
2613:         TRY
2614:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2615:                 RETURN
2616:             ENDIF
2617:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2618:                 THIS.this_oBusinessObject.AtualizarComposicao()
2619:             ENDIF
2620:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2621:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Grupo.Refresh()
2622:         CATCH TO loc_oErro
2623:             MsgErro(loc_oErro.Message, "Erro ao atualizar composi" + CHR(231) + CHR(227) + "o")
2624:         ENDTRY
2625:     ENDPROC
2626: 
2627:     *--------------------------------------------------------------------------
2628:     * CmdAtualizarPesosClick - Atualiza pesos medios dos componentes
2629:     *--------------------------------------------------------------------------
2630:     PROCEDURE CmdAtualizarPesosClick()
2631:         TRY
2632:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2633:                 THIS.this_oBusinessObject.AtualizarPesos()
2634:             ENDIF
2635:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2636:         CATCH TO loc_oErro
2637:             MsgErro(loc_oErro.Message, "Erro ao atualizar pesos")
2638:         ENDTRY
2639:     ENDPROC
2640: 
2641:     *--------------------------------------------------------------------------
2642:     * CmdInserirSubCpClick - Adiciona linha no grid de sub-componentes
2643:     *--------------------------------------------------------------------------
2644:     PROCEDURE CmdInserirSubCpClick()
2645:         TRY
2646:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2647:                 RETURN
2648:             ENDIF
2649:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo") AND ;
2650:                !EMPTY(cursor_4c_Compo.mats)
2651:                 IF USED("cursor_4c_SubCp")
2652:                     SELECT cursor_4c_SubCp
2653:                     APPEND BLANK
2654:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
2655:                 ENDIF
2656:             ELSE
2657:                 MsgAviso("Selecione um componente antes de adicionar sub-componente.")
2658:             ENDIF
2659:         CATCH TO loc_oErro
2660:             MsgErro(loc_oErro.Message, "Erro ao inserir sub-componente")
2661:         ENDTRY
2662:     ENDPROC
2663: 
2664:     *--------------------------------------------------------------------------
2665:     * CmdExcluirSubCpClick - Remove linha do grid de sub-componentes
2666:     *--------------------------------------------------------------------------
2667:     PROCEDURE CmdExcluirSubCpClick()
2668:         LOCAL loc_lConfirma
2669:         TRY
2670:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2671:                 RETURN
2672:             ENDIF
2673:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
2674:                 loc_lConfirma = MsgConfirma("Excluir sub-componente selecionado?")
2675:                 IF loc_lConfirma
2676:                     SELECT cursor_4c_SubCp
2677:                     DELETE
2678:                     IF !EOF()
2679:                         SKIP
2680:                         SKIP -1
2681:                     ENDIF
2682:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
2683:                 ENDIF
2684:             ENDIF
2685:         CATCH TO loc_oErro
2686:             MsgErro(loc_oErro.Message, "Erro ao excluir sub-componente")
2687:         ENDTRY
2688:     ENDPROC
2689: 
2690:     *--------------------------------------------------------------------------
2691:     * CmdCalcValsClick - Calcular valores de preco/custo/venda
2692:     *--------------------------------------------------------------------------
2693:     PROCEDURE CmdCalcValsClick()
2694:         TRY
2695:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2696:                 THIS.this_oBusinessObject.CalcVals()
2697:             ENDIF
2698:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.Refresh()
2699:         CATCH TO loc_oErro
2700:             MsgErro(loc_oErro.Message, "Erro ao calcular valores")
2701:         ENDTRY
2702:     ENDPROC
2703: 
2704:     *--------------------------------------------------------------------------
2705:     * CmdPesoMClick - Atualizar peso medio do produto
2706:     *--------------------------------------------------------------------------
2707:     PROCEDURE CmdPesoMClick()
2708:         TRY
2709:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2710:                 THIS.this_oBusinessObject.AtualizarPesoMedio()
2711:             ENDIF
2712:         CATCH TO loc_oErro
2713:             MsgErro(loc_oErro.Message, "Erro ao atualizar peso m" + CHR(233) + "dio")
2714:         ENDTRY
2715:     ENDPROC
2716: 
2717:     *--------------------------------------------------------------------------
2718:     * ChkPlanCusClick - Plano de custo
2719:     *--------------------------------------------------------------------------
2720:     PROCEDURE ChkPlanCusClick()
2721:         *-- chkPlanCus.Valid: If Value=1, Do Form SigOpPcu With ThisForm,'C'
2722:         *-- Na migracao: exibe mensagem de funcionalidade em desenvolvimento
2723:         TRY
2724:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.chk_4c_PlanCus.Value = 0
2725:         CATCH TO loc_oErro
2726:             *-- silencioso
2727:         ENDTRY
2728:     ENDPROC
2729: 
2730:     *--------------------------------------------------------------------------
2731:     * ChkPVendaClick - Usar preco de venda atual no calculo
2732:     *--------------------------------------------------------------------------
2733:     PROCEDURE ChkPVendaClick()
2734:         *-- chkPVenda.Click: recalcular
2735:         TRY
2736:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2737:                 THIS.this_oBusinessObject.CalcPreco()
2738:             ENDIF
2739:         CATCH TO loc_oErro
2740:             MsgErro(loc_oErro.Message, "Erro ao calcular pre" + CHR(231) + "o")
2741:         ENDTRY
2742:     ENDPROC
2743: 
2744:     *--------------------------------------------------------------------------
2745:     * ChkPlanVenClick - Plano de venda
2746:     *--------------------------------------------------------------------------
2747:     PROCEDURE ChkPlanVenClick()
2748:         *-- chkPlanVen.Valid: If Value=1, Do Form SigOpPcu With ThisForm,'V'
2749:         TRY
2750:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.chk_4c_PlanVen.Value = 0
2751:         CATCH TO loc_oErro
2752:             *-- silencioso
2753:         ENDTRY
2754:     ENDPROC
2755: 
2756:     *--------------------------------------------------------------------------
2757:     * Moeda lookups F4 para todos os campos de moeda da aba Composicao
2758:     *--------------------------------------------------------------------------
2759:     PROCEDURE TxtMoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2760:         IF par_nKeyCode = 115 && F4
2761:             THIS.AbrirLookupMoedaCompo("txt_4c_Moec")
2762:         ENDIF
2763:     ENDPROC
2764: 
2765:     PROCEDURE TxtMoecLostFocus()
2766:         THIS.ValidarMoedaCompo("txt_4c_Moec")
2767:     ENDPROC
2768: 
2769:     PROCEDURE TxtMoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2770:         IF par_nKeyCode = 115 && F4
2771:             THIS.AbrirLookupMoedaCompo("txt_4c_Moepc")
2772:         ENDIF
2773:     ENDPROC
2774: 
2775:     PROCEDURE TxtMoepcLostFocus()
2776:         THIS.ValidarMoedaCompo("txt_4c_Moepc")
2777:         THIS.CalcPrecoCompo()
2778:     ENDPROC
2779: 
2780:     PROCEDURE TxtMoecusfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2781:         IF par_nKeyCode = 115 && F4
2782:             THIS.AbrirLookupMoedaCompo("txt_4c_Moecusf")
2783:         ENDIF
2784:     ENDPROC
2785: 
2786:     PROCEDURE TxtMoecusfLostFocus()
2787:         THIS.ValidarMoedaCompo("txt_4c_Moecusf")
2788:         THIS.CalcPrecoCompo()
2789:     ENDPROC
2790: 
2791:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2792:         IF par_nKeyCode = 115 && F4
2793:             THIS.AbrirLookupMoedaCompo("txt_4c_Moeda")
2794:         ENDIF
2795:     ENDPROC
2796: 
2797:     PROCEDURE TxtMoedaLostFocus()
2798:         THIS.ValidarMoedaCompo("txt_4c_Moeda")
2799:         THIS.CalcPrecoCompo()
2800:     ENDPROC
2801: 
2802:     PROCEDURE TxtMoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2803:         IF par_nKeyCode = 115 && F4
2804:             THIS.AbrirLookupMoedaCompo("txt_4c_Moepv")
2805:         ENDIF
2806:     ENDPROC
2807: 
2808:     PROCEDURE TxtMoepvLostFocus()
2809:         THIS.ValidarMoedaCompo("txt_4c_Moepv")
2810:     ENDPROC
2811: 
2812:     PROCEDURE TxtMoevKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2813:         IF par_nKeyCode = 115 && F4
2814:             THIS.AbrirLookupMoedaCompo("txt_4c_Moev")
2815:         ENDIF
2816:     ENDPROC
2817: 
2818:     PROCEDURE TxtMoevLostFocus()
2819:         THIS.ValidarMoedaCompo("txt_4c_Moev")
2820:     ENDPROC
2821: 
2822:     *--------------------------------------------------------------------------
2823:     * AbrirLookupMoedaCompo - Abre FormBuscaAuxiliar para SigCdMoe
2824:     *--------------------------------------------------------------------------
2825:     PROCEDURE AbrirLookupMoedaCompo(par_cCampo)
2826:         LOCAL loc_oPg, loc_oBusca, loc_cAtual, loc_oCtrl
2827:         TRY
2828:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2829:             loc_oCtrl  = EVALUATE("loc_oPg." + par_cCampo)
2830:             loc_cAtual = ALLTRIM(loc_oCtrl.Value)
2831: 
2832:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2833:                 "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cAtual, ;
2834:                 "Buscar Moeda")
2835:             IF VARTYPE(loc_oBusca) = "O"
2836:                 IF !loc_oBusca.this_lAchouRegistro
2837:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "d.")
2838:                     loc_oBusca.mAddColuna("DMoes", "", "Moeda")
2839:                     loc_oBusca.Show()
2840:                 ENDIF
2841:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2842:                     loc_oCtrl.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2843:                 ENDIF
2844:                 loc_oBusca.Release()
2845:             ENDIF
2846:             IF USED("cursor_4c_BuscaMoe")
2847:                 USE IN cursor_4c_BuscaMoe
2848:             ENDIF
2849:         CATCH TO loc_oErro
2850:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
2851:         ENDTRY
2852:     ENDPROC
2853: 
2854:     *--------------------------------------------------------------------------
2855:     * ValidarMoedaCompo - Valida codigo de moeda via SQLEXEC
2856:     *--------------------------------------------------------------------------
2857:     PROCEDURE ValidarMoedaCompo(par_cCampo)
2858:         LOCAL loc_oPg, loc_oCtrl, loc_cMoe, loc_nRet
2859:         TRY
2860:             IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
2861:                 RETURN
2862:             ENDIF
2863:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2864:             loc_oCtrl = EVALUATE("loc_oPg." + par_cCampo)
2865:             loc_cMoe  = ALLTRIM(loc_oCtrl.Value)
2866:             IF EMPTY(loc_cMoe)
2867:                 RETURN
2868:             ENDIF
2869:             loc_nRet = SQLEXEC(gnConnHandle, ;
2870:                 "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoe), ;
2871:                 "cursor_4c_TmpMoe")
2872:             IF loc_nRet < 1 OR RECCOUNT("cursor_4c_TmpMoe") < 1
2873:                 MsgAviso("Moeda '" + loc_cMoe + "' n" + CHR(227) + "o encontrada!")
2874:                 loc_oCtrl.Value = ""
2875:             ENDIF
2876:             IF USED("cursor_4c_TmpMoe")
2877:                 USE IN cursor_4c_TmpMoe
2878:             ENDIF
2879:         CATCH TO loc_oErro
2880:             MsgErro(loc_oErro.Message, "Erro ao validar moeda")
2881:         ENDTRY
2882:     ENDPROC
2883: 
2884:     *--------------------------------------------------------------------------
2885:     * CalcPrecoCompo - Chama calculo de preco pelo BO
2886:     *--------------------------------------------------------------------------
2887:     PROCEDURE CalcPrecoCompo()
2888:         TRY
2889:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2890:                 THIS.this_oBusinessObject.CalcPreco()
2891:             ENDIF
2892:         CATCH TO loc_oErro
2893:             MsgErro(loc_oErro.Message, "Erro ao calcular pre" + CHR(231) + "o")
2894:         ENDTRY
2895:     ENDPROC
2896: 
2897:     *--------------------------------------------------------------------------
2898:     * TxtPcusLostFocus - Recalcular ao sair do preco de custo
2899:     *--------------------------------------------------------------------------
2900:     PROCEDURE TxtPcusLostFocus()
2901:         THIS.CalcPrecoCompo()
2902:     ENDPROC
2903: 
2904:     *--------------------------------------------------------------------------
2905:     * TxtFcustoLostFocus - Recalcular ao sair do fator de custo
2906:     *--------------------------------------------------------------------------
2907:     PROCEDURE TxtFcustoLostFocus()
2908:         THIS.CalcPrecoCompo()
2909:     ENDPROC
2910: 
2911:     *--------------------------------------------------------------------------
2912:     * TxtCustofLostFocus - Recalcular ao sair do custo total
2913:     *--------------------------------------------------------------------------
2914:     PROCEDURE TxtCustofLostFocus()
2915:         THIS.CalcPrecoCompo()
2916:     ENDPROC
2917: 
2918:     *--------------------------------------------------------------------------
2919:     * TxtGetCmkpcKeyPress / LostFocus - MKP custo (F4 = lookup SigPrFti)
2920:     *--------------------------------------------------------------------------
2921:     PROCEDURE TxtGetCmkpcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2922:         IF par_nKeyCode = 115 && F4
2923:             THIS.AbrirLookupFtioCusto()
2924:         ENDIF
2925:     ENDPROC
2926: 
2927:     PROCEDURE TxtGetCmkpcLostFocus()
2928:         THIS.CalcPrecoCompo()
2929:     ENDPROC
2930: 
2931:     PROCEDURE AbrirLookupFtioCusto()
2932:         LOCAL loc_oPg, loc_oBusca, loc_cAtual, loc_nRet
2933:         TRY
2934:             IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
2935:                 RETURN
2936:             ENDIF
2937:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2938:             loc_cAtual = ALLTRIM(loc_oPg.txt_4c_GetCmkpc.Value)
2939:             loc_nRet = SQLEXEC(gnConnHandle, ;
2940:                 "SELECT Cods, Descs, Moedas, Valors, TpFtios FROM SigPrFti WHERE Tipos = 1", ;
2941:                 "cursor_4c_ListaFtioCusto")
2942:             IF loc_nRet > 0
2943:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2944:                     "SigPrFti", "cursor_4c_BuscaFtioCusto", "Cods", loc_cAtual, ;
2945:                     "Fator de Custo")
2946:                 IF VARTYPE(loc_oBusca) = "O"
2947:                     IF !loc_oBusca.this_lAchouRegistro
2948:                         loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "d.")
2949:                         loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2950:                         loc_oBusca.mAddColuna("Moedas", "", "Moeda")
2951:                         loc_oBusca.Show()
2952:                     ENDIF
2953:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioCusto")
2954:                         loc_oPg.txt_4c_GetCmkpc.Value = ALLTRIM(cursor_4c_BuscaFtioCusto.Cods)
2955:                     ENDIF
2956:                     loc_oBusca.Release()
2957:                 ENDIF
2958:                 IF USED("cursor_4c_BuscaFtioCusto")
2959:                     USE IN cursor_4c_BuscaFtioCusto
2960:                 ENDIF
2961:             ENDIF
2962:             IF USED("cursor_4c_ListaFtioCusto")
2963:                 USE IN cursor_4c_ListaFtioCusto
2964:             ENDIF
2965:         CATCH TO loc_oErro
2966:             MsgErro(loc_oErro.Message, "Erro ao buscar fator de custo")
2967:         ENDTRY
2968:     ENDPROC
2969: 
2970:     *--------------------------------------------------------------------------
2971:     * TxtGetPftiocKeyPress / LostFocus - Fator adicional custo
2972:     *--------------------------------------------------------------------------
2973:     PROCEDURE TxtGetPftiocKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2974:         IF par_nKeyCode = 115 && F4
2975:             THIS.AbrirLookupFtioCusto()
2976:         ENDIF
2977:     ENDPROC
2978: 
2979:     PROCEDURE TxtGetPftiocLostFocus()
2980:         THIS.CalcPrecoCompo()
2981:     ENDPROC
2982: 
2983:     *--------------------------------------------------------------------------
2984:     * TxtPesomLostFocus - Recalcular ao sair do peso medio
2985:     *--------------------------------------------------------------------------
2986:     PROCEDURE TxtPesomLostFocus()
2987:         THIS.CalcPrecoCompo()
2988:     ENDPROC
2989: 
2990:     *--------------------------------------------------------------------------
2991:     * TxtCotaCalcPLostFocus - Recalcular ao sair da cotacao
2992:     *--------------------------------------------------------------------------
2993:     PROCEDURE TxtCotaCalcPLostFocus()
2994:         THIS.CalcPrecoCompo()
2995:     ENDPROC
2996: 
2997:     *--------------------------------------------------------------------------
2998:     * TxtGetftioKeyPress / LostFocus - MKP Fator venda (F4 = lookup SigPrFti)
2999:     *--------------------------------------------------------------------------
3000:     PROCEDURE TxtGetftioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3001:         IF par_nKeyCode = 115 && F4
3002:             THIS.AbrirLookupFtioVenda()
3003:         ENDIF
3004:     ENDPROC
3005: 
3006:     PROCEDURE TxtGetftioLostFocus()
3007:         THIS.CalcPrecoCompo()
3008:     ENDPROC
3009: 
3010:     PROCEDURE AbrirLookupFtioVenda()
3011:         LOCAL loc_oPg, loc_oBusca, loc_cAtual, loc_nRet
3012:         TRY
3013:             IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
3014:                 RETURN
3015:             ENDIF
3016:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3017:             loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Getftio.Value)
3018:             loc_nRet = SQLEXEC(gnConnHandle, ;
3019:                 "SELECT Cods, Descs FROM SigPrFti", ;
3020:                 "cursor_4c_ListaFtioVenda")
3021:             IF loc_nRet > 0
3022:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3023:                     "SigPrFti", "cursor_4c_BuscaFtioVenda", "Cods", loc_cAtual, ;
3024:                     "Fator de Venda")
3025:                 IF VARTYPE(loc_oBusca) = "O"
3026:                     IF !loc_oBusca.this_lAchouRegistro
3027:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
3028:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3029:                         loc_oBusca.Show()
3030:                     ENDIF
3031:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioVenda")
3032:                         loc_oPg.txt_4c_Getftio.Value = ALLTRIM(cursor_4c_BuscaFtioVenda.Cods)
3033:                     ENDIF
3034:                     loc_oBusca.Release()
3035:                 ENDIF
3036:                 IF USED("cursor_4c_BuscaFtioVenda")
3037:                     USE IN cursor_4c_BuscaFtioVenda
3038:                 ENDIF
3039:             ENDIF
3040:             IF USED("cursor_4c_ListaFtioVenda")
3041:                 USE IN cursor_4c_ListaFtioVenda
3042:             ENDIF
3043:         CATCH TO loc_oErro
3044:             MsgErro(loc_oErro.Message, "Erro ao buscar fator de venda")
3045:         ENDTRY
3046:     ENDPROC
3047: 
3048:     *--------------------------------------------------------------------------
3049:     * TxtMargemLostFocus - Recalcular ao sair da margem
3050:     *--------------------------------------------------------------------------
3051:     PROCEDURE TxtMargemLostFocus()
3052:         THIS.CalcPrecoCompo()
3053:     ENDPROC
3054: 
3055:     *--------------------------------------------------------------------------
3056:     * TxtPvidealLostFocus - Recalcular ao sair do preco ideal
3057:     *--------------------------------------------------------------------------
3058:     PROCEDURE TxtPvidealLostFocus()
3059:         THIS.CalcPrecoCompo()
3060:     ENDPROC
3061: 
3062:     *--------------------------------------------------------------------------
3063:     * TxtGetStatusKeyPress / LostFocus - Status do produto (F4 = lookup SigCdPst)
3064:     *--------------------------------------------------------------------------
3065:     PROCEDURE TxtGetStatusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3066:         IF par_nKeyCode = 115 && F4
3067:             THIS.AbrirLookupStatusCompo()
3068:         ENDIF
3069:     ENDPROC
3070: 
3071:     PROCEDURE TxtGetStatusLostFocus()
3072:         LOCAL loc_oPg, loc_cSts, loc_nRet
3073:         TRY
3074:             IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
3075:                 RETURN
3076:             ENDIF
3077:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3078:             loc_cSts = ALLTRIM(loc_oPg.txt_4c_GetStatus.Value)
3079:             IF EMPTY(loc_cSts)
3080:                 RETURN
3081:             ENDIF
3082:             loc_nRet = SQLEXEC(gnConnHandle, ;
3083:                 "SELECT Cods FROM SigCdPst WHERE Cods = " + EscaparSQL(loc_cSts), ;
3084:                 "cursor_4c_TmpSts")
3085:             IF loc_nRet < 1 OR RECCOUNT("cursor_4c_TmpSts") < 1
3086:                 MsgAviso("Status '" + loc_cSts + "' n" + CHR(227) + "o encontrado!")
3087:                 loc_oPg.txt_4c_GetStatus.Value = ""
3088:             ENDIF
3089:             IF USED("cursor_4c_TmpSts")
3090:                 USE IN cursor_4c_TmpSts
3091:             ENDIF
3092:         CATCH TO loc_oErro
3093:             MsgErro(loc_oErro.Message, "Erro ao validar status")
3094:         ENDTRY
3095:     ENDPROC
3096: 
3097:     PROCEDURE AbrirLookupStatusCompo()
3098:         LOCAL loc_oPg, loc_oBusca, loc_cAtual
3099:         TRY
3100:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3101:             loc_cAtual = ALLTRIM(loc_oPg.txt_4c_GetStatus.Value)
3102:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3103:                 "SigCdPst", "cursor_4c_BuscaSts", "Cods", loc_cAtual, ;
3104:                 "Buscar Status")
3105:             IF VARTYPE(loc_oBusca) = "O"
3106:                 IF !loc_oBusca.this_lAchouRegistro
3107:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
3108:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3109:                     loc_oBusca.Show()
3110:                 ENDIF
3111:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSts")
3112:                     loc_oPg.txt_4c_GetStatus.Value = ALLTRIM(cursor_4c_BuscaSts.Cods)
3113:                 ENDIF
3114:                 loc_oBusca.Release()
3115:             ENDIF
3116:             IF USED("cursor_4c_BuscaSts")
3117:                 USE IN cursor_4c_BuscaSts
3118:             ENDIF
3119:         CATCH TO loc_oErro
3120:             MsgErro(loc_oErro.Message, "Erro ao buscar status")
3121:         ENDTRY
3122:     ENDPROC
3123: 
3124:     *--------------------------------------------------------------------------
3125:     * TxtMarkupALostFocus - Recalcular ao sair do markup aplicado
3126:     *--------------------------------------------------------------------------
3127:     PROCEDURE TxtMarkupALostFocus()
3128:         THIS.CalcPrecoCompo()
3129:     ENDPROC
3130: 
3131:     *--------------------------------------------------------------------------
3132:     * TxtFvendaLostFocus - Recalcular ao sair do fator de venda
3133:     *--------------------------------------------------------------------------
3134:     PROCEDURE TxtFvendaLostFocus()
3135:         THIS.CalcPrecoCompo()
3136:     ENDPROC
3137: 
3138:     *--------------------------------------------------------------------------
3139:     * TxtPvenLostFocus - Recalcular ao sair do preco de venda
3140:     *--------------------------------------------------------------------------
3141:     PROCEDURE TxtPvenLostFocus()
3142:         THIS.CalcPrecoCompo()
3143:     ENDPROC
3144: 
3145:     *--------------------------------------------------------------------------
3146:     * TxtGetMftioLostFocus - Recalcular ao sair do fator moeda
3147:     *--------------------------------------------------------------------------
3148:     PROCEDURE TxtGetMftioLostFocus()
3149:         THIS.CalcPrecoCompo()
3150:     ENDPROC
3151: 
3152:     *--------------------------------------------------------------------------
3153:     * TxtGetEncargLostFocus - Validar valor financeiro (encargos)
3154:     *--------------------------------------------------------------------------
3155:     PROCEDURE TxtGetEncargLostFocus()
3156:         LOCAL loc_oPg
3157:         TRY
3158:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3159:             IF loc_oPg.txt_4c_GetEncarg.Value < 0
3160:                 MsgAviso("Valor inv" + CHR(225) + "lido!")
3161:                 loc_oPg.txt_4c_GetEncarg.Value = 0
3162:             ENDIF
3163:         CATCH TO loc_oErro
3164:             MsgErro(loc_oErro.Message, "Erro ao validar encargo")
3165:         ENDTRY
3166:     ENDPROC
3167: 
3168:     *--------------------------------------------------------------------------
3169:     * TxtMatPKeyPress / LostFocus - Material Principal (F4 = lookup SigCdPro)
3170:     *--------------------------------------------------------------------------
3171:     PROCEDURE TxtMatPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3172:         IF par_nKeyCode = 115 && F4
3173:             THIS.AbrirLookupMatP()
3174:         ENDIF
3175:     ENDPROC
3176: 
3177:     PROCEDURE TxtMatPLostFocus()
3178:         LOCAL loc_oPg, loc_cMatP, loc_nRet
3179:         TRY
3180:             IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
3181:                 RETURN
3182:             ENDIF
3183:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3184:             loc_cMatP = ALLTRIM(loc_oPg.txt_4c_MatP.Value)
3185:             IF EMPTY(loc_cMatP)
3186:                 loc_oPg.txt_4c_Desc.Value = ""
3187:                 RETURN
3188:             ENDIF
3189:             loc_nRet = SQLEXEC(gnConnHandle, ;
3190:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cMatP), ;
3191:                 "cursor_4c_TmpMatP")
3192:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpMatP") > 0
3193:                 loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_TmpMatP.dpros)
3194:             ELSE
3195:                 MsgAviso("Produto '" + loc_cMatP + "' n" + CHR(227) + "o encontrado!")
3196:                 loc_oPg.txt_4c_MatP.Value = ""
3197:                 loc_oPg.txt_4c_Desc.Value = ""
3198:             ENDIF
3199:             IF USED("cursor_4c_TmpMatP")
3200:                 USE IN cursor_4c_TmpMatP
3201:             ENDIF
3202:         CATCH TO loc_oErro
3203:             MsgErro(loc_oErro.Message, "Erro ao validar material principal")
3204:         ENDTRY
3205:     ENDPROC
3206: 
3207:     PROCEDURE AbrirLookupMatP()
3208:         LOCAL loc_oPg, loc_oBusca, loc_cAtual
3209:         TRY
3210:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3211:             loc_cAtual = ALLTRIM(loc_oPg.txt_4c_MatP.Value)
3212:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3213:                 "SigCdPro", "cursor_4c_BuscaMatP", "cpros", loc_cAtual, ;
3214:                 "Buscar Material Principal")
3215:             IF VARTYPE(loc_oBusca) = "O"
3216:                 IF !loc_oBusca.this_lAchouRegistro
3217:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "d.")
3218:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
3219:                     loc_oBusca.Show()
3220:                 ENDIF
3221:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatP")
3222:                     loc_oPg.txt_4c_MatP.Value  = ALLTRIM(cursor_4c_BuscaMatP.cpros)
3223:                     loc_oPg.txt_4c_Desc.Value  = ALLTRIM(cursor_4c_BuscaMatP.dpros)
3224:                 ENDIF
3225:                 loc_oBusca.Release()
3226:             ENDIF
3227:             IF USED("cursor_4c_BuscaMatP")
3228:                 USE IN cursor_4c_BuscaMatP
3229:             ENDIF
3230:         CATCH TO loc_oErro
3231:             MsgErro(loc_oErro.Message, "Erro ao buscar material principal")
3232:         ENDTRY
3233:     ENDPROC
3234: 
3235:     *--------------------------------------------------------------------------
3236:     * CarregarLista - Carrega registros no grid usando filtros da UI
3237:     * Legado: fCarregaGrade() leia cntFiltros.getCgru/optFilSituas
3238:     *--------------------------------------------------------------------------
3239:     PROCEDURE CarregarLista()
3240:         LOCAL loc_lResultado, loc_cFiltro, loc_oPagina
3241:         LOCAL loc_cCgru, loc_nSitI, loc_nSitF, loc_oGrid
3242:         loc_lResultado = .F.
3243: 
3244:         *-- Guard: pular se validando UI (sem conexao SQL)
3245:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3246:             RETURN .T.
3247:         ENDIF
3248: 
3249:         TRY
3250:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
3251: 
3252:             *-- Capturar filtros da UI (com guard de existencia)
3253:             loc_cCgru = ""
3254:             loc_nSitI = 1
3255:             loc_nSitF = 2
3256: 
3257:             IF VARTYPE(loc_oPagina.cnt_4c_Filtros) = "O"
3258:                 loc_cCgru = ALLTRIM(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value)
3259: 
3260:                 *-- optFilSituas: 1=Todos, 2=Ativos(situas=1), 3=Inativos(situas=2)
3261:                 loc_nSitI = IIF(loc_oPagina.cnt_4c_Filtros.opt_4c_Situas.Value = 3, 2, 1)
3262:                 loc_nSitF = IIF(loc_oPagina.cnt_4c_Filtros.opt_4c_Situas.Value = 2, 1, 2)
3263:             ENDIF
3264: 
3265:             *-- Construir WHERE clause
3266:             loc_cFiltro = "situas BETWEEN " + TRANSFORM(loc_nSitI) + " AND " + TRANSFORM(loc_nSitF)
3267:             IF !EMPTY(loc_cCgru)
3268:                 loc_cFiltro = loc_cFiltro + " AND cgrus = " + EscaparSQL(loc_cCgru)
3269:             ENDIF
3270: 
3271:             *-- Buscar dados via BO (ZAP+APPEND preserva estrutura do cursor/grid)
3272:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
3273: 
3274:                 *-- Redefinir headers APOS cada Buscar() (VFP9 pode resetar)
3275:                 IF VARTYPE(loc_oPagina.grd_4c_Lista) = "O"
3276:                     loc_oGrid = loc_oPagina.grd_4c_Lista
3277:                     loc_oGrid.Column1.Header1.Caption = "Produto"
3278:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3279:                     loc_oGrid.Column3.Header1.Caption = "Grupo"

*-- Linhas 3285 a 3749:
3285:                 ENDIF
3286: 
3287:                 *-- Atualizar contagem
3288:                 IF VARTYPE(loc_oPagina.lbl_4c_Contagem) = "O"
3289:                     loc_oPagina.lbl_4c_Contagem.Caption = "Produtos Selecionados : " + ;
3290:                         TRANSFORM(RECCOUNT("cursor_4c_Dados"))
3291:                 ENDIF
3292: 
3293:                 loc_lResultado = .T.
3294:             ENDIF
3295: 
3296:         CATCH TO loException
3297:             MsgErro("Erro ao carregar lista:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
3298:             loc_lResultado = .F.
3299:         ENDTRY
3300: 
3301:         RETURN loc_lResultado
3302:     ENDPROC
3303: 
3304:     *--------------------------------------------------------------------------
3305:     * AlternarPagina - Navega entre paginas do PageFrame principal
3306:     * Page1=Lista, Page2=Dados
3307:     *--------------------------------------------------------------------------
3308:     PROCEDURE AlternarPagina(par_nPagina)
3309: 
3310:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
3311:             RETURN
3312:         ENDIF
3313: 
3314:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
3315: 
3316:         *-- Ao voltar para Page1, recarregar lista
3317:         IF par_nPagina = 1
3318:             IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
3319:                 THIS.CarregarLista()
3320:             ENDIF
3321:         ENDIF
3322:     ENDPROC
3323: 
3324:     *--------------------------------------------------------------------------
3325:     * TxtCgruKeyPress - F4 abre lookup de grupos de produto
3326:     * BINDEVENT requer PUBLIC + LPARAMETERS declarados
3327:     *--------------------------------------------------------------------------
3328:     PROCEDURE TxtCgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3329:         IF par_nKeyCode = 115 && F4
3330:             THIS.AbrirLookupGrupo()
3331:         ENDIF
3332:     ENDPROC
3333: 
3334:     *--------------------------------------------------------------------------
3335:     * TxtCgruLostFocus - Valida codigo do grupo ao sair do campo
3336:     *--------------------------------------------------------------------------
3337:     PROCEDURE TxtCgruLostFocus()
3338:         LOCAL loc_oPagina, loc_cCgru, loc_nRet
3339:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
3340:         loc_cCgru   = ALLTRIM(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value)
3341: 
3342:         IF EMPTY(loc_cCgru)
3343:             loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
3344:             THIS.CarregarLista()
3345:             RETURN
3346:         ENDIF
3347: 
3348:         IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3349:             TRY
3350:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3351:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCgru), ;
3352:                     "cursor_4c_TmpGrupo")
3353: 
3354:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpGrupo") > 0
3355:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_TmpGrupo.dgrus)
3356:                 ELSE
3357:                     MsgAviso("Grupo '" + loc_cCgru + "' n" + CHR(227) + "o encontrado!")
3358:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value = ""
3359:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
3360:                 ENDIF
3361: 
3362:                 IF USED("cursor_4c_TmpGrupo")
3363:                     USE IN cursor_4c_TmpGrupo
3364:                 ENDIF
3365:             CATCH TO loc_oErro
3366:                 MsgErro(loc_oErro.Message, "Erro ao validar grupo")
3367:             ENDTRY
3368:         ENDIF
3369: 
3370:         THIS.CarregarLista()
3371:     ENDPROC
3372: 
3373:     *--------------------------------------------------------------------------
3374:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para SigCdGrp
3375:     *--------------------------------------------------------------------------
3376:     PROCEDURE AbrirLookupGrupo()
3377:         LOCAL loc_oBusca, loc_oPagina
3378:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
3379: 
3380:         TRY
3381:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3382:                 "SigCdGrp", "cursor_4c_BuscaGrupo", "cgrus", "", ;
3383:                 "Buscar Grupo de Produto")
3384: 
3385:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
3386:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
3387:             loc_oBusca.Show()
3388: 
3389:             IF loc_oBusca.this_lSelecionou
3390:                 IF USED("cursor_4c_BuscaGrupo")
3391:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
3392:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrupo.dgrus)
3393:                     THIS.CarregarLista()
3394:                 ENDIF
3395:             ENDIF
3396: 
3397:             IF USED("cursor_4c_BuscaGrupo")
3398:                 USE IN cursor_4c_BuscaGrupo
3399:             ENDIF
3400:             loc_oBusca.Release()
3401: 
3402:         CATCH TO loc_oErro
3403:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
3404:         ENDTRY
3405:     ENDPROC
3406: 
3407:     *--------------------------------------------------------------------------
3408:     * OptSituasChange - Recarrega lista ao mudar filtro de situacao
3409:     *--------------------------------------------------------------------------
3410:     PROCEDURE OptSituasChange()
3411:         THIS.CarregarLista()
3412:     ENDPROC
3413: 
3414:     *--------------------------------------------------------------------------
3415:     * TornarControlesVisiveis - Torna visiveis apenas controles nomeados
3416:     * Evita tornar visiveis containers flutuantes (Visible=.F. por design)
3417:     *--------------------------------------------------------------------------
3418:     PROCEDURE TornarControlesVisiveis(par_oContainer)
3419: 
3420:         LOCAL loc_i, loc_oCtrl, loc_cNome
3421:         LOCAL loc_j, loc_lPrefixoValido
3422:         LOCAL loc_aPrefixos(8)
3423:         loc_aPrefixos(1) = "cnt_"
3424:         loc_aPrefixos(2) = "txt_"
3425:         loc_aPrefixos(3) = "lbl_"
3426:         loc_aPrefixos(4) = "cmd_"
3427:         loc_aPrefixos(5) = "chk_"
3428:         loc_aPrefixos(6) = "cmb_"
3429:         loc_aPrefixos(7) = "grd_"
3430:         loc_aPrefixos(8) = "pgf_"
3431: 
3432:         IF VARTYPE(par_oContainer) # "O"
3433:             RETURN
3434:         ENDIF
3435: 
3436:         FOR loc_i = 1 TO par_oContainer.ControlCount
3437:             loc_oCtrl         = par_oContainer.Controls(loc_i)
3438:             loc_cNome         = loc_oCtrl.Name
3439:             loc_lPrefixoValido = .F.
3440: 
3441:             FOR loc_j = 1 TO 8
3442:                 IF LEFT(loc_cNome, 4) = loc_aPrefixos(loc_j)
3443:                     loc_lPrefixoValido = .T.
3444:                     EXIT
3445:                 ENDIF
3446:             ENDFOR
3447: 
3448:             IF loc_lPrefixoValido
3449:                 loc_oCtrl.Visible = .T.
3450:                 IF loc_oCtrl.ControlCount > 0
3451:                     THIS.TornarControlesVisiveis(loc_oCtrl)
3452:                 ENDIF
3453:             ENDIF
3454:         ENDFOR
3455:     ENDPROC
3456: 
3457:     *--------------------------------------------------------------------------
3458:     * FormatarGridLista - Aplica formatacao padrao ao grid de lista
3459:     *--------------------------------------------------------------------------
3460:     PROCEDURE FormatarGridLista(par_oGrid)
3461: 
3462:         IF VARTYPE(par_oGrid) # "O"
3463:             RETURN
3464:         ENDIF
3465: 
3466:         WITH par_oGrid
3467:             .FontName           = "Verdana"
3468:             .FontSize           = 8
3469:             .GridLines          = 3
3470:             .GridLineWidth      = 1
3471:             .GridLineColor      = RGB(238, 238, 238)
3472:             .RecordMark         = .F.
3473:             .DeleteMark         = .F.
3474:             .AllowRowSizing     = .F.
3475:             .ReadOnly           = .T.
3476:             .BackColor          = RGB(255, 255, 255)
3477:             .ForeColor          = RGB(90, 90, 90)
3478:             .HighlightBackColor = RGB(255, 255, 255)
3479:             .HighlightForeColor = RGB(15, 41, 104)
3480:             .HighlightStyle     = 2
3481:             .RowHeight          = 16
3482:             .ScrollBars         = 2
3483:         ENDWITH
3484:     ENDPROC
3485: 
3486:     *--------------------------------------------------------------------------
3487:     * BtnIncluirClick - Incluir novo produto
3488:     *--------------------------------------------------------------------------
3489:     PROCEDURE BtnIncluirClick()
3490:         LOCAL loc_lResultado
3491:         loc_lResultado = .F.
3492: 
3493:         TRY
3494:             THIS.this_oBusinessObject.NovoRegistro()
3495:             THIS.LimparCampos()
3496:             THIS.this_cModoAtual = "INCLUIR"
3497:             THIS.HabilitarCampos(.T.)
3498:             THIS.AjustarBotoesPorModo()
3499:             THIS.AlternarPagina(2)
3500:             loc_lResultado = .T.
3501:         CATCH TO loc_oErro
3502:             MsgErro(loc_oErro.Message, "Erro ao incluir produto")
3503:         ENDTRY
3504: 
3505:         RETURN loc_lResultado
3506:     ENDPROC
3507: 
3508:     *--------------------------------------------------------------------------
3509:     * BtnVisualizarClick - Visualizar produto selecionado
3510:     *--------------------------------------------------------------------------
3511:     PROCEDURE BtnVisualizarClick()
3512:         LOCAL loc_cCodigo, loc_lResultado
3513:         loc_lResultado = .F.
3514: 
3515:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3516:             MsgAviso("Nenhum registro selecionado!")
3517:             RETURN .F.
3518:         ENDIF
3519: 
3520:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
3521: 
3522:         TRY
3523:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3524:                 THIS.BOParaForm()
3525:                 THIS.this_cModoAtual = "VISUALIZAR"
3526:                 THIS.HabilitarCampos(.F.)
3527:                 THIS.AjustarBotoesPorModo()
3528:                 THIS.AlternarPagina(2)
3529:                 loc_lResultado = .T.
3530:             ENDIF
3531:         CATCH TO loc_oErro
3532:             MsgErro(loc_oErro.Message, "Erro ao visualizar produto")
3533:         ENDTRY
3534: 
3535:         RETURN loc_lResultado
3536:     ENDPROC
3537: 
3538:     *--------------------------------------------------------------------------
3539:     * BtnAlterarClick - Alterar produto selecionado
3540:     *--------------------------------------------------------------------------
3541:     PROCEDURE BtnAlterarClick()
3542:         LOCAL loc_cCodigo, loc_lResultado
3543:         loc_lResultado = .F.
3544: 
3545:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3546:             MsgAviso("Nenhum registro selecionado!")
3547:             RETURN .F.
3548:         ENDIF
3549: 
3550:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
3551: 
3552:         TRY
3553:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3554:                 THIS.this_oBusinessObject.EditarRegistro()
3555:                 THIS.BOParaForm()
3556:                 THIS.this_cModoAtual = "ALTERAR"
3557:                 THIS.HabilitarCampos(.T.)
3558:                 THIS.AjustarBotoesPorModo()
3559:                 THIS.AlternarPagina(2)
3560:                 loc_lResultado = .T.
3561:             ENDIF
3562:         CATCH TO loc_oErro
3563:             MsgErro(loc_oErro.Message, "Erro ao alterar produto")
3564:         ENDTRY
3565: 
3566:         RETURN loc_lResultado
3567:     ENDPROC
3568: 
3569:     *--------------------------------------------------------------------------
3570:     * BtnExcluirClick - Excluir produto selecionado
3571:     * Legado: verifica uso em outros registros antes de excluir
3572:     *--------------------------------------------------------------------------
3573:     PROCEDURE BtnExcluirClick()
3574:         LOCAL loc_cCodigo, loc_cDescricao, loc_lResultado
3575:         loc_lResultado = .F.
3576: 
3577:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3578:             MsgAviso("Nenhum registro selecionado!")
3579:             RETURN .F.
3580:         ENDIF
3581: 
3582:         loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cpros)
3583:         loc_cDescricao = ALLTRIM(cursor_4c_Dados.dpros)
3584: 
3585:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do produto:" + CHR(13) + loc_cCodigo + " - " + loc_cDescricao + "?")
3586:             TRY
3587:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3588:                     IF THIS.this_oBusinessObject.Excluir()
3589:                         MsgSucesso("Produto exclu" + CHR(237) + "do com sucesso!")
3590:                         THIS.CarregarLista()
3591:                         loc_lResultado = .T.
3592:                     ENDIF
3593:                 ENDIF
3594:             CATCH TO loc_oErro
3595:                 MsgErro(loc_oErro.Message, "Erro ao excluir produto")
3596:             ENDTRY
3597:         ENDIF
3598: 
3599:         RETURN loc_lResultado
3600:     ENDPROC
3601: 
3602:     *--------------------------------------------------------------------------
3603:     * BtnBuscarClick - Abre busca auxiliar de produtos
3604:     *--------------------------------------------------------------------------
3605:     PROCEDURE BtnBuscarClick()
3606:         LOCAL loc_oBusca
3607: 
3608:         TRY
3609:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Buscar Produto")
3610: 
3611:             loc_oBusca.mAddColuna("cpros", "", "Produto")
3612:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
3613:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
3614: 
3615:             loc_oBusca.Show()
3616: 
3617:             IF loc_oBusca.this_lSelecionou
3618:                 IF USED("cursor_4c_Busca")
3619:                     LOCAL loc_cCodigo
3620:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
3621: 
3622:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3623:                         THIS.BOParaForm()
3624:                         THIS.this_cModoAtual = "VISUALIZAR"
3625:                         THIS.HabilitarCampos(.F.)
3626:                         THIS.AlternarPagina(2)
3627:                     ENDIF
3628:                 ENDIF
3629:             ENDIF
3630: 
3631:             IF USED("cursor_4c_Busca")
3632:                 USE IN cursor_4c_Busca
3633:             ENDIF
3634:             loc_oBusca.Release()
3635: 
3636:         CATCH TO loException
3637:             MostrarErro("Erro ao buscar produto:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
3638:         ENDTRY
3639:     ENDPROC
3640: 
3641:     *--------------------------------------------------------------------------
3642:     * BtnEncerrarClick - Fechar o formulario
3643:     *--------------------------------------------------------------------------
3644:     PROCEDURE BtnEncerrarClick()
3645:         THIS.Release()
3646:     ENDPROC
3647: 
3648:     *--------------------------------------------------------------------------
3649:     * BtnSalvarClick - Salvar produto
3650:     * Valida campos obrigatorios, transfere Form->BO e chama Salvar()
3651:     *--------------------------------------------------------------------------
3652:     PROCEDURE BtnSalvarClick()
3653:         LOCAL loc_lResultado, loc_oPg, loc_cCpro, loc_cDpro
3654:         loc_lResultado = .F.
3655: 
3656:         *-- Validacoes FORA do TRY (VFP9: nunca RETURN dentro de TRY/CATCH)
3657:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
3658:             RETURN .F.
3659:         ENDIF
3660:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3661:         loc_cCpro = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)
3662:         loc_cDpro = ALLTRIM(loc_oPg.txt_4c_Dpro.Value)
3663: 
3664:         IF EMPTY(loc_cCpro)
3665:             MsgAviso("C" + CHR(243) + "digo do produto obrigat" + CHR(243) + "rio!", "Valida" + CHR(231) + CHR(227) + "o")
3666:             loc_oPg.txt_4c_Cpro.SetFocus()
3667:             RETURN .F.
3668:         ENDIF
3669: 
3670:         IF EMPTY(loc_cDpro)
3671:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o do produto obrigat" + CHR(243) + "ria!", "Valida" + CHR(231) + CHR(227) + "o")
3672:             loc_oPg.txt_4c_Dpro.SetFocus()
3673:             RETURN .F.
3674:         ENDIF
3675: 
3676:         TRY
3677:             THIS.FormParaBO()
3678: 
3679:             IF THIS.this_oBusinessObject.Salvar()
3680:                 MsgSucesso("Produto salvo com sucesso!")
3681:                 THIS.this_cModoAtual = "LISTA"
3682:                 THIS.AjustarBotoesPorModo()
3683:                 THIS.AlternarPagina(1)  && AlternarPagina(1) ja chama CarregarLista()
3684:                 loc_lResultado = .T.
3685:             ENDIF
3686:             *-- Erros de validacao: exibidos por ValidarDados() via MsgAviso (form permanece em Dados)
3687:             *-- Erros de BD: exibidos por Inserir/Atualizar via MsgErro (form permanece em Dados)
3688: 
3689:         CATCH TO loc_oErro
3690:             MsgErro("Erro ao salvar produto:" + CHR(13) + "Linha: " + ;
3691:                 TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "Erro")
3692:         ENDTRY
3693: 
3694:         RETURN loc_lResultado
3695:     ENDPROC
3696: 
3697:     *--------------------------------------------------------------------------
3698:     * BtnCancelarClick - Cancelar operacao
3699:     *--------------------------------------------------------------------------
3700:     PROCEDURE BtnCancelarClick()
3701:         THIS.this_cModoAtual = "LISTA"
3702:         THIS.AlternarPagina(1)
3703:         THIS.CarregarLista()
3704:     ENDPROC
3705: 
3706:     *--------------------------------------------------------------------------
3707:     * FormParaBO - Transfere dados do Form para o BO (campos pgDados Fase 5)
3708:     *--------------------------------------------------------------------------
3709:     PROTECTED PROCEDURE FormParaBO()
3710:         LOCAL loc_oPg
3711:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3712: 
3713:         WITH THIS.this_oBusinessObject
3714:             .this_cCpros    = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)
3715:             .this_cDpros    = ALLTRIM(loc_oPg.txt_4c_Dpro.Value)
3716:             .this_nSituas   = loc_oPg.obj_4c_Opc_situacao.Value
3717:             .this_cCproeqs  = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)
3718:             .this_cDpro2s   = ALLTRIM(loc_oPg.txt_4c_DPro2s.Value)
3719:             .this_nCbars    = ALLTRIM(loc_oPg.txt_4c_Cbar.Value)
3720:             .this_cCgrus    = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
3721:             .this_cMercs    = ALLTRIM(loc_oPg.txt_4c_Merc.Value)
3722:             .this_cIdecpros = ALLTRIM(loc_oPg.txt_4c_IdeCPros.Value)
3723:             .this_nEan13    = ALLTRIM(loc_oPg.txt_4c_EAN13.Value)
3724:             .this_cSgrus    = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
3725:             .this_cConjunts = ALLTRIM(loc_oPg.txt_4c_Conjunto.Value)
3726:             .this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
3727:             .this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Col.Value)
3728:             .this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
3729:             .this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Refs.Value)
3730:             *-- Fase 6: campos adicionais
3731:             .this_cCodfinp    = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
3732:             .this_cCodacbs    = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
3733:             .this_cCclass     = ALLTRIM(loc_oPg.txt_4c_Class.Value)
3734:             .this_cLocals     = ALLTRIM(loc_oPg.txt_4c_Local.Value)
3735:             .this_nPesobs     = ALLTRIM(loc_oPg.txt_4c_PesoBs.Value)
3736:             .this_nPesoms     = ALLTRIM(loc_oPg.txt_4c_Pmedio.Value)
3737:             .this_cCunis      = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
3738:             .this_cCunips     = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
3739:             .this_cCodident   = ALLTRIM(loc_oPg.txt_4c_CodIdent.Value)
3740:             .this_nTents      = ALLTRIM(loc_oPg.txt_4c_TEnts.Value)
3741:             .this_lConsigs    = (loc_oPg.chk_4c_Consig.Value = 1)
3742:             .this_lFabrproprs = (loc_oPg.chk_4c_FabrProprs.Value = 1)
3743:             .this_lEncoms     = (loc_oPg.chk_4c_Encoms.Value = 1)
3744:             .this_nTamps      = ALLTRIM(loc_oPg.txt_4c_Tamps.Value)
3745:             .this_nTamhs      = ALLTRIM(loc_oPg.txt_4c_Tamhs.Value)
3746:             .this_nTamls      = ALLTRIM(loc_oPg.txt_4c_Tamls.Value)
3747:             .this_nVolumes    = ALLTRIM(loc_oPg.txt_4c_Volumes.Value)
3748:             .this_cDsccompras = loc_oPg.edt_4c_DscCompras.Value
3749:             .this_cDpro3s     = loc_oPg.edt_4c_DPro3s.Value

*-- Linhas 3768 a 3811:
3768:     *--------------------------------------------------------------------------
3769:     * BOParaForm - Transfere dados do BO para o Form (campos pgDados Fase 5)
3770:     *--------------------------------------------------------------------------
3771:     PROTECTED PROCEDURE BOParaForm()
3772:         LOCAL loc_oPg
3773:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3774: 
3775:         WITH THIS.this_oBusinessObject
3776:             loc_oPg.txt_4c_Cpro.Value              = ALLTRIM(.this_cCpros)
3777:             loc_oPg.txt_4c_Dpro.Value              = ALLTRIM(.this_cDpros)
3778:             loc_oPg.obj_4c_Opc_situacao.Value      = IIF(.this_nSituas = 2, 2, 1)
3779:             loc_oPg.txt_4c_CProEq.Value            = ALLTRIM(.this_cCproeqs)
3780:             loc_oPg.txt_4c_DPro2s.Value            = ALLTRIM(.this_cDpro2s)
3781:             *-- cbars e ean13 sao numericos: converter para string de exibicao
3782:             loc_oPg.txt_4c_Cbar.Value              = IIF(.this_nCbars = 0, "", LTRIM(STR(.this_nCbars, 14, 0)))
3783:             loc_oPg.txt_4c_CgruP.Value             = ALLTRIM(.this_cCgrus)
3784:             loc_oPg.txt_4c_DgruP.Value             = ""
3785:             loc_oPg.txt_4c_Merc.Value              = ALLTRIM(.this_cMercs)
3786:             loc_oPg.txt_4c_IdeCPros.Value          = ALLTRIM(.this_cIdecpros)
3787:             loc_oPg.txt_4c_EAN13.Value             = IIF(.this_nEan13 = 0, "", LTRIM(STR(.this_nEan13, 13, 0)))
3788:             loc_oPg.txt_4c_CSGru.Value             = ALLTRIM(.this_cSgrus)
3789:             loc_oPg.txt_4c_DsGru.Value             = ""
3790:             loc_oPg.txt_4c_Conjunto.Value          = ALLTRIM(.this_cConjunts)
3791:             loc_oPg.txt_4c_Lin.Value               = ALLTRIM(.this_cLinhas)
3792:             loc_oPg.txt_4c_DLin.Value              = ""
3793:             loc_oPg.txt_4c_Col.Value               = ALLTRIM(.this_cColecoes)
3794:             loc_oPg.txt_4c_DCol.Value              = ""
3795:             loc_oPg.txt_4c_Ifor.Value              = ALLTRIM(.this_cIfors)
3796:             loc_oPg.txt_4c_Dfor.Value              = ""
3797:             loc_oPg.txt_4c_Refs.Value              = ALLTRIM(.this_cReffs)
3798:             *-- Fase 6: campos adicionais
3799:             loc_oPg.txt_4c_CodFinP.Value   = ALLTRIM(.this_cCodfinp)
3800:             loc_oPg.txt_4c_DFinP.Value     = ""
3801:             loc_oPg.txt_4c_CodAcb.Value    = ALLTRIM(.this_cCodacbs)
3802:             loc_oPg.txt_4c_DAcb.Value      = ""
3803:             loc_oPg.txt_4c_Class.Value     = ALLTRIM(.this_cCclass)
3804:             loc_oPg.txt_4c_DClass.Value    = ""
3805:             loc_oPg.txt_4c_Local.Value     = ALLTRIM(.this_cLocals)
3806:             loc_oPg.txt_4c_PesoBs.Value    = IIF(.this_nPesobs = 0, "", LTRIM(STR(.this_nPesobs, 10, 3)))
3807:             loc_oPg.txt_4c_Pmedio.Value    = IIF(.this_nPesoms = 0, "", LTRIM(STR(.this_nPesoms, 11, 3)))
3808:             loc_oPg.txt_4c_Estoques.Value  = ""
3809:             loc_oPg.txt_4c_QtdEsts.Value   = ""
3810:             *-- Custo/Venda/Fator (display only - readonly)
3811:             loc_oPg.txt_4c_Ctotal.Value    = IIF(.this_nCustofs = 0, "", LTRIM(STR(.this_nCustofs, 14, 5)))

*-- Linhas 3871 a 3914:
3871:     *--------------------------------------------------------------------------
3872:     * LimparCampos - Limpa todos os campos do formulario (pgDados Fase 5)
3873:     *--------------------------------------------------------------------------
3874:     PROTECTED PROCEDURE LimparCampos()
3875:         LOCAL loc_oPg
3876:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
3877:             RETURN
3878:         ENDIF
3879:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3880:         IF VARTYPE(loc_oPg.txt_4c_Cpro) # "O"
3881:             RETURN
3882:         ENDIF
3883: 
3884:         loc_oPg.txt_4c_Cpro.Value              = ""
3885:         loc_oPg.txt_4c_Dpro.Value              = ""
3886:         loc_oPg.obj_4c_Opc_situacao.Value      = 1
3887:         loc_oPg.txt_4c_CProEq.Value            = ""
3888:         loc_oPg.txt_4c_DPro2s.Value            = ""
3889:         loc_oPg.txt_4c_Cbar.Value              = ""
3890:         loc_oPg.txt_4c_CgruP.Value             = ""
3891:         loc_oPg.txt_4c_DgruP.Value             = ""
3892:         loc_oPg.txt_4c_Merc.Value              = ""
3893:         loc_oPg.txt_4c_IdeCPros.Value          = ""
3894:         loc_oPg.txt_4c_EAN13.Value             = ""
3895:         loc_oPg.txt_4c_CSGru.Value             = ""
3896:         loc_oPg.txt_4c_DsGru.Value             = ""
3897:         loc_oPg.txt_4c_Conjunto.Value          = ""
3898:         loc_oPg.txt_4c_Lin.Value               = ""
3899:         loc_oPg.txt_4c_DLin.Value              = ""
3900:         loc_oPg.txt_4c_Col.Value               = ""
3901:         loc_oPg.txt_4c_DCol.Value              = ""
3902:         loc_oPg.txt_4c_Ifor.Value              = ""
3903:         loc_oPg.txt_4c_Dfor.Value              = ""
3904:         loc_oPg.txt_4c_Refs.Value              = ""
3905: 
3906:         *-- Fase 6
3907:         IF VARTYPE(loc_oPg.txt_4c_CodFinP) # "O"
3908:             RETURN
3909:         ENDIF
3910:         loc_oPg.txt_4c_CodFinP.Value   = ""
3911:         loc_oPg.txt_4c_DFinP.Value     = ""
3912:         loc_oPg.txt_4c_CodAcb.Value    = ""
3913:         loc_oPg.txt_4c_DAcb.Value      = ""
3914:         loc_oPg.txt_4c_Class.Value     = ""

*-- Linhas 3961 a 4004:
3961:     *--------------------------------------------------------------------------
3962:     * HabilitarCampos - Habilita/desabilita campos conforme modo (Fase 5)
3963:     *--------------------------------------------------------------------------
3964:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3965:         LOCAL loc_oPg
3966:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
3967:             RETURN
3968:         ENDIF
3969:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3970:         IF VARTYPE(loc_oPg.txt_4c_Cpro) # "O"
3971:             RETURN
3972:         ENDIF
3973: 
3974:         *-- Codigo do produto: habilitado apenas em INCLUIR (PK nao pode mudar)
3975:         loc_oPg.txt_4c_Cpro.Enabled           = IIF(THIS.this_cModoAtual = "INCLUIR", par_lHabilitar, .F.)
3976:         loc_oPg.txt_4c_Dpro.Enabled           = par_lHabilitar
3977:         loc_oPg.obj_4c_Opc_situacao.Enabled   = par_lHabilitar
3978:         loc_oPg.txt_4c_CProEq.Enabled         = par_lHabilitar
3979:         loc_oPg.txt_4c_DPro2s.Enabled         = par_lHabilitar
3980:         loc_oPg.txt_4c_Cbar.Enabled           = par_lHabilitar
3981:         loc_oPg.txt_4c_CgruP.Enabled          = par_lHabilitar
3982:         loc_oPg.txt_4c_Merc.Enabled           = par_lHabilitar
3983:         loc_oPg.txt_4c_IdeCPros.Enabled       = par_lHabilitar
3984:         loc_oPg.txt_4c_EAN13.Enabled          = par_lHabilitar
3985:         loc_oPg.txt_4c_CSGru.Enabled          = par_lHabilitar
3986:         loc_oPg.txt_4c_Conjunto.Enabled       = par_lHabilitar
3987:         loc_oPg.txt_4c_Lin.Enabled            = par_lHabilitar
3988:         loc_oPg.txt_4c_Col.Enabled            = par_lHabilitar
3989:         loc_oPg.txt_4c_Ifor.Enabled           = par_lHabilitar
3990:         loc_oPg.txt_4c_Refs.Enabled           = par_lHabilitar
3991: 
3992:         *-- Fase 6 - campos editaveis
3993:         IF VARTYPE(loc_oPg.txt_4c_CodFinP) # "O"
3994:             RETURN
3995:         ENDIF
3996:         loc_oPg.txt_4c_CodFinP.Enabled    = par_lHabilitar
3997:         loc_oPg.txt_4c_CodAcb.Enabled     = par_lHabilitar
3998:         loc_oPg.txt_4c_Class.Enabled      = par_lHabilitar
3999:         loc_oPg.txt_4c_Local.Enabled      = par_lHabilitar
4000:         loc_oPg.txt_4c_PesoBs.Enabled     = par_lHabilitar
4001:         loc_oPg.txt_4c_Pmedio.Enabled     = par_lHabilitar
4002:         loc_oPg.txt_4c_Cuni.Enabled       = par_lHabilitar
4003:         loc_oPg.txt_4c_Cunip.Enabled      = par_lHabilitar
4004:         loc_oPg.txt_4c_CodIdent.Enabled   = par_lHabilitar

*-- Linhas 4031 a 4074:
4031:     * ConfigurarPgDados - Configura campos da aba Dados (primeiros 50%)
4032:     * Legado: pgDados controles T:130-T:298 (sem compensacao adicional)
4033:     *--------------------------------------------------------------------------
4034:     PROTECTED PROCEDURE ConfigurarPgDados()
4035:         LOCAL loc_oPg
4036:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4037: 
4038:         *-- Linha 1 (T:130-134): Produto / Descricao / Situacao
4039:         *-- Label2: "Produto :" (T:134 L:58 W:53 FontBold)
4040:         loc_oPg.AddObject("lbl_4c_LblProduto", "Label")
4041:         WITH loc_oPg.lbl_4c_LblProduto
4042:             .Caption   = "Produto :"
4043:             .Top       = 134
4044:             .Left      = 58
4045:             .Width     = 53
4046:             .Height    = 15
4047:             .FontName  = "Tahoma"
4048:             .FontSize  = 8
4049:             .FontBold  = .T.
4050:             .BackStyle = 0
4051:             .ForeColor = RGB(90, 90, 90)
4052:             .Visible   = .T.
4053:         ENDWITH
4054: 
4055:         *-- getCpro -> txt_4c_Cpro (T:130 L:113 W:108 H:23) - PK do produto
4056:         loc_oPg.AddObject("txt_4c_Cpro", "TextBox")
4057:         WITH loc_oPg.txt_4c_Cpro
4058:             .Top           = 130
4059:             .Left          = 113
4060:             .Width         = 108
4061:             .Height        = 23
4062:             .FontName      = "Tahoma"
4063:             .FontSize      = 8
4064:             .MaxLength     = 14
4065:             .Value         = ""
4066:             .SpecialEffect = 1
4067:             .Visible       = .T.
4068:         ENDWITH
4069: 
4070:         *-- getDpro -> txt_4c_Dpro (T:130 L:222 W:290 H:23) - descricao
4071:         loc_oPg.AddObject("txt_4c_Dpro", "TextBox")
4072:         WITH loc_oPg.txt_4c_Dpro
4073:             .Top           = 130
4074:             .Left          = 222

*-- Linhas 4084 a 4127:
4084: 
4085:         *-- opc_situacao -> obj_4c_Opc_situacao (T:130 L:735 W:142 H:25)
4086:         *-- Value=1 Ativo, Value=2 Inativo (situas numeric no banco)
4087:         loc_oPg.AddObject("obj_4c_Opc_situacao", "OptionGroup")
4088:         WITH loc_oPg.obj_4c_Opc_situacao
4089:             .Top         = 130
4090:             .Left        = 735
4091:             .Width       = 142
4092:             .Height      = 25
4093:             .ButtonCount = 2
4094:             .Value       = 1
4095:             .BorderStyle = 0
4096:             .Visible     = .T.
4097:         ENDWITH
4098:         WITH loc_oPg.obj_4c_Opc_situacao
4099:             .Buttons(1).Caption   = "Ativo"
4100:             .Buttons(1).Left      = 5
4101:             .Buttons(1).Top       = 5
4102:             .Buttons(1).Height    = 15
4103:             .Buttons(1).FontName  = "Tahoma"
4104:             .Buttons(1).FontSize  = 8
4105:             .Buttons(1).ForeColor = RGB(90, 90, 90)
4106:             .Buttons(1).BackStyle = 0
4107:             .Buttons(1).AutoSize  = .T.
4108:             .Buttons(1).Themes    = .F.
4109: 
4110:             .Buttons(2).Caption   = "Inativo - Ap" + CHR(243) + "s :"
4111:             .Buttons(2).Left      = 50
4112:             .Buttons(2).Top       = 5
4113:             .Buttons(2).Height    = 15
4114:             .Buttons(2).FontName  = "Tahoma"
4115:             .Buttons(2).FontSize  = 8
4116:             .Buttons(2).ForeColor = RGB(90, 90, 90)
4117:             .Buttons(2).BackStyle = 0
4118:             .Buttons(2).AutoSize  = .T.
4119:             .Buttons(2).Themes    = .F.
4120:         ENDWITH
4121: 
4122:         *-- Linha 2 (T:133-158): Equivalente / Descritivo / Barra
4123:         *-- Say2: "Equivalente :" (T:137 L:560 W:65)
4124:         loc_oPg.AddObject("lbl_4c_LblEquivalente", "Label")
4125:         WITH loc_oPg.lbl_4c_LblEquivalente
4126:             .Caption   = "Equivalente :"
4127:             .Top       = 137

*-- Linhas 4150 a 4194:
4150:             .ForeColor     = RGB(36, 84, 155)
4151:             .Visible       = .T.
4152:         ENDWITH
4153:         BINDEVENT(loc_oPg.txt_4c_CProEq, "KeyPress",  THIS, "TxtCProEqKeyPress")
4154:         BINDEVENT(loc_oPg.txt_4c_CProEq, "LostFocus", THIS, "TxtCProEqLostFocus")
4155: 
4156:         *-- Say10: "Descritivo :" (T:158 L:55 W:56)
4157:         loc_oPg.AddObject("lbl_4c_LblDPro2", "Label")
4158:         WITH loc_oPg.lbl_4c_LblDPro2
4159:             .Caption   = "Descritivo :"
4160:             .Top       = 158
4161:             .Left      = 55
4162:             .Width     = 56
4163:             .Height    = 15
4164:             .FontName  = "Tahoma"
4165:             .FontSize  = 8
4166:             .BackStyle = 0
4167:             .ForeColor = RGB(90, 90, 90)
4168:             .Visible   = .T.
4169:         ENDWITH
4170: 
4171:         *-- getDPro2s -> txt_4c_DPro2s (T:154 L:113 W:399 H:23) - 2a descricao
4172:         loc_oPg.AddObject("txt_4c_DPro2s", "TextBox")
4173:         WITH loc_oPg.txt_4c_DPro2s
4174:             .Top           = 154
4175:             .Left          = 113
4176:             .Width         = 399
4177:             .Height        = 23
4178:             .FontName      = "Tahoma"
4179:             .FontSize      = 8
4180:             .MaxLength     = 45
4181:             .Value         = ""
4182:             .SpecialEffect = 1
4183:             .Visible       = .T.
4184:         ENDWITH
4185: 
4186:         *-- Say15: "Barra :" (T:157 L:590 W:35)
4187:         loc_oPg.AddObject("lbl_4c_LblBarra", "Label")
4188:         WITH loc_oPg.lbl_4c_LblBarra
4189:             .Caption   = "Barra :"
4190:             .Top       = 157
4191:             .Left      = 590
4192:             .Width     = 35
4193:             .Height    = 15
4194:             .FontName  = "Tahoma"

*-- Linhas 4245 a 4289:
4245:             .SpecialEffect = 1
4246:             .Visible       = .T.
4247:         ENDWITH
4248:         BINDEVENT(loc_oPg.txt_4c_CgruP, "KeyPress",  THIS, "TxtCgruPKeyPress")
4249:         BINDEVENT(loc_oPg.txt_4c_CgruP, "LostFocus", THIS, "TxtCgruPLostFocus")
4250: 
4251:         *-- getDgru -> txt_4c_DgruP (T:178 L:145 W:171 H:23) - desc grupo (readonly)
4252:         loc_oPg.AddObject("txt_4c_DgruP", "TextBox")
4253:         WITH loc_oPg.txt_4c_DgruP
4254:             .Top           = 178
4255:             .Left          = 145
4256:             .Width         = 171
4257:             .Height        = 23
4258:             .FontName      = "Tahoma"
4259:             .FontSize      = 8
4260:             .ReadOnly      = .T.
4261:             .Value         = ""
4262:             .SpecialEffect = 1
4263:             .Visible       = .T.
4264:         ENDWITH
4265: 
4266:         *-- getMerc -> txt_4c_Merc (T:178 L:318 W:31 H:23) - mercadoria
4267:         loc_oPg.AddObject("txt_4c_Merc", "TextBox")
4268:         WITH loc_oPg.txt_4c_Merc
4269:             .Top           = 178
4270:             .Left          = 318
4271:             .Width         = 31
4272:             .Height        = 23
4273:             .FontName      = "Tahoma"
4274:             .FontSize      = 8
4275:             .MaxLength     = 3
4276:             .Value         = ""
4277:             .SpecialEffect = 1
4278:             .BackColor     = RGB(231, 242, 254)
4279:             .Visible       = .T.
4280:         ENDWITH
4281: 
4282:         *-- Say23: "Identificador :" (T:182 L:408 W:70)
4283:         loc_oPg.AddObject("lbl_4c_LblIdeCPros", "Label")
4284:         WITH loc_oPg.lbl_4c_LblIdeCPros
4285:             .Caption   = "Identificador :"
4286:             .Top       = 182
4287:             .Left      = 408
4288:             .Width     = 70
4289:             .Height    = 15

*-- Linhas 4371 a 4587:
4371:             .SpecialEffect = 1
4372:             .Visible       = .T.
4373:         ENDWITH
4374:         BINDEVENT(loc_oPg.txt_4c_CSGru, "KeyPress",  THIS, "TxtCSGruKeyPress")
4375:         BINDEVENT(loc_oPg.txt_4c_CSGru, "LostFocus", THIS, "TxtCSGruLostFocus")
4376: 
4377:         *-- GetDsGru -> txt_4c_DsGru (T:202 L:166 W:150 H:23) - desc subgrupo (readonly)
4378:         loc_oPg.AddObject("txt_4c_DsGru", "TextBox")
4379:         WITH loc_oPg.txt_4c_DsGru
4380:             .Top           = 202
4381:             .Left          = 166
4382:             .Width         = 150
4383:             .Height        = 23
4384:             .FontName      = "Tahoma"
4385:             .FontSize      = 8
4386:             .ReadOnly      = .T.
4387:             .Value         = ""
4388:             .SpecialEffect = 1
4389:             .Visible       = .T.
4390:         ENDWITH
4391: 
4392:         *-- Say37: "Conjunto :" (T:206 L:408 W:53)
4393:         loc_oPg.AddObject("lbl_4c_LblConjunto", "Label")
4394:         WITH loc_oPg.lbl_4c_LblConjunto
4395:             .Caption   = "Conjunto :"
4396:             .Top       = 206
4397:             .Left      = 408
4398:             .Width     = 53
4399:             .Height    = 15
4400:             .FontName  = "Tahoma"
4401:             .FontSize  = 8
4402:             .BackStyle = 0
4403:             .ForeColor = RGB(90, 90, 90)
4404:             .Visible   = .T.
4405:         ENDWITH
4406: 
4407:         *-- getConjunto -> txt_4c_Conjunto (T:202 L:460 W:52 H:23)
4408:         loc_oPg.AddObject("txt_4c_Conjunto", "TextBox")
4409:         WITH loc_oPg.txt_4c_Conjunto
4410:             .Top           = 202
4411:             .Left          = 460
4412:             .Width         = 52
4413:             .Height        = 23
4414:             .FontName      = "Tahoma"
4415:             .FontSize      = 8
4416:             .Value         = ""
4417:             .SpecialEffect = 1
4418:             .Visible       = .T.
4419:         ENDWITH
4420:         BINDEVENT(loc_oPg.txt_4c_Conjunto, "KeyPress",  THIS, "TxtConjuntoKeyPress")
4421: 
4422:         *-- Linha 5 (T:226-230): Linha
4423:         *-- Say16: "Linha :" (T:230 L:77 W:34)
4424:         loc_oPg.AddObject("lbl_4c_LblLinha", "Label")
4425:         WITH loc_oPg.lbl_4c_LblLinha
4426:             .Caption   = "Linha :"
4427:             .Top       = 230
4428:             .Left      = 77
4429:             .Width     = 34
4430:             .Height    = 15
4431:             .FontName  = "Tahoma"
4432:             .FontSize  = 8
4433:             .BackStyle = 0
4434:             .ForeColor = RGB(90, 90, 90)
4435:             .Visible   = .T.
4436:         ENDWITH
4437: 
4438:         *-- GetLin -> txt_4c_Lin (T:226 L:113 W:80 H:23) - codigo de linha
4439:         loc_oPg.AddObject("txt_4c_Lin", "TextBox")
4440:         WITH loc_oPg.txt_4c_Lin
4441:             .Top           = 226
4442:             .Left          = 113
4443:             .Width         = 80
4444:             .Height        = 23
4445:             .FontName      = "Tahoma"
4446:             .FontSize      = 8
4447:             .Value         = ""
4448:             .SpecialEffect = 1
4449:             .Visible       = .T.
4450:         ENDWITH
4451:         BINDEVENT(loc_oPg.txt_4c_Lin, "KeyPress",  THIS, "TxtLinKeyPress")
4452:         BINDEVENT(loc_oPg.txt_4c_Lin, "LostFocus", THIS, "TxtLinLostFocus")
4453: 
4454:         *-- GetDLin -> txt_4c_DLin (T:226 L:194 W:318 H:23) - desc linha (readonly)
4455:         loc_oPg.AddObject("txt_4c_DLin", "TextBox")
4456:         WITH loc_oPg.txt_4c_DLin
4457:             .Top           = 226
4458:             .Left          = 194
4459:             .Width         = 318
4460:             .Height        = 23
4461:             .FontName      = "Tahoma"
4462:             .FontSize      = 8
4463:             .ReadOnly      = .T.
4464:             .Value         = ""
4465:             .SpecialEffect = 1
4466:             .Visible       = .T.
4467:         ENDWITH
4468: 
4469:         *-- Linha 6 (T:250-253): Grupo de Venda (Colecoes)
4470:         *-- Say17: "Grupo de Venda :" (T:253 L:25 W:86)
4471:         loc_oPg.AddObject("lbl_4c_LblGVenda", "Label")
4472:         WITH loc_oPg.lbl_4c_LblGVenda
4473:             .Caption   = "Grupo de Venda :"
4474:             .Top       = 253
4475:             .Left      = 25
4476:             .Width     = 86
4477:             .Height    = 15
4478:             .FontName  = "Tahoma"
4479:             .FontSize  = 8
4480:             .BackStyle = 0
4481:             .ForeColor = RGB(90, 90, 90)
4482:             .Visible   = .T.
4483:         ENDWITH
4484: 
4485:         *-- GetCol -> txt_4c_Col (T:250 L:113 W:80 H:23) - colecoes (grupo venda)
4486:         loc_oPg.AddObject("txt_4c_Col", "TextBox")
4487:         WITH loc_oPg.txt_4c_Col
4488:             .Top           = 250
4489:             .Left          = 113
4490:             .Width         = 80
4491:             .Height        = 23
4492:             .FontName      = "Tahoma"
4493:             .FontSize      = 8
4494:             .Value         = ""
4495:             .SpecialEffect = 1
4496:             .Visible       = .T.
4497:         ENDWITH
4498:         BINDEVENT(loc_oPg.txt_4c_Col, "KeyPress",  THIS, "TxtColKeyPress")
4499:         BINDEVENT(loc_oPg.txt_4c_Col, "LostFocus", THIS, "TxtColLostFocus")
4500: 
4501:         *-- GetDCol -> txt_4c_DCol (T:250 L:194 W:318 H:23) - desc grupo venda (readonly)
4502:         loc_oPg.AddObject("txt_4c_DCol", "TextBox")
4503:         WITH loc_oPg.txt_4c_DCol
4504:             .Top           = 250
4505:             .Left          = 194
4506:             .Width         = 318
4507:             .Height        = 23
4508:             .FontName      = "Tahoma"
4509:             .FontSize      = 8
4510:             .ReadOnly      = .T.
4511:             .Value         = ""
4512:             .SpecialEffect = 1
4513:             .Visible       = .T.
4514:         ENDWITH
4515: 
4516:         *-- Linha 7 (T:274-278): Fornecedor
4517:         *-- Say11: "Fornecedor :" (T:278 L:47 W:64)
4518:         loc_oPg.AddObject("lbl_4c_LblFornecedor", "Label")
4519:         WITH loc_oPg.lbl_4c_LblFornecedor
4520:             .Caption   = "Fornecedor :"
4521:             .Top       = 278
4522:             .Left      = 47
4523:             .Width     = 64
4524:             .Height    = 15
4525:             .FontName  = "Tahoma"
4526:             .FontSize  = 8
4527:             .BackStyle = 0
4528:             .ForeColor = RGB(90, 90, 90)
4529:             .Visible   = .T.
4530:         ENDWITH
4531: 
4532:         *-- getIfor -> txt_4c_Ifor (T:274 L:113 W:80 H:23) - codigo fornecedor
4533:         loc_oPg.AddObject("txt_4c_Ifor", "TextBox")
4534:         WITH loc_oPg.txt_4c_Ifor
4535:             .Top           = 274
4536:             .Left          = 113
4537:             .Width         = 80
4538:             .Height        = 23
4539:             .FontName      = "Tahoma"
4540:             .FontSize      = 8
4541:             .MaxLength     = 10
4542:             .Value         = ""
4543:             .SpecialEffect = 1
4544:             .Visible       = .T.
4545:         ENDWITH
4546:         BINDEVENT(loc_oPg.txt_4c_Ifor, "KeyPress",  THIS, "TxtIforKeyPress")
4547:         BINDEVENT(loc_oPg.txt_4c_Ifor, "LostFocus", THIS, "TxtIforLostFocus")
4548: 
4549:         *-- getDfor -> txt_4c_Dfor (T:274 L:194 W:318 H:23) - desc fornecedor (readonly)
4550:         loc_oPg.AddObject("txt_4c_Dfor", "TextBox")
4551:         WITH loc_oPg.txt_4c_Dfor
4552:             .Top           = 274
4553:             .Left          = 194
4554:             .Width         = 318
4555:             .Height        = 23
4556:             .FontName      = "Tahoma"
4557:             .FontSize      = 8
4558:             .ReadOnly      = .T.
4559:             .Value         = ""
4560:             .SpecialEffect = 1
4561:             .Visible       = .T.
4562:         ENDWITH
4563: 
4564:         *-- Linha 8 (T:298-301): Ref. Fornecedor
4565:         *-- Say12: "Ref. Fornecedor :" (T:301 L:23 W:88)
4566:         loc_oPg.AddObject("lbl_4c_LblRefs", "Label")
4567:         WITH loc_oPg.lbl_4c_LblRefs
4568:             .Caption   = "Ref. Fornecedor :"
4569:             .Top       = 301
4570:             .Left      = 23
4571:             .Width     = 88
4572:             .Height    = 15
4573:             .FontName  = "Tahoma"
4574:             .FontSize  = 8
4575:             .BackStyle = 0
4576:             .ForeColor = RGB(90, 90, 90)
4577:             .Visible   = .T.
4578:         ENDWITH
4579: 
4580:         *-- getRefs -> txt_4c_Refs (T:298 L:113 W:152 H:23) - referencia fornecedor
4581:         loc_oPg.AddObject("txt_4c_Refs", "TextBox")
4582:         WITH loc_oPg.txt_4c_Refs
4583:             .Top           = 298
4584:             .Left          = 113
4585:             .Width         = 152
4586:             .Height        = 23
4587:             .FontName      = "Tahoma"

*-- Linhas 4600 a 4643:
4600:     * PreencherDescricoesPgDados - Busca descricoes dos campos lookup (readonly)
4601:     * Chamado por BOParaForm apos preencher codigos
4602:     *--------------------------------------------------------------------------
4603:     PROCEDURE PreencherDescricoesPgDados()
4604:         LOCAL loc_oPg, loc_cCod, loc_nRet
4605:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4606: 
4607:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4608:             RETURN
4609:         ENDIF
4610: 
4611:         TRY
4612:             *-- Descricao do Grupo (cgrus -> SigCdGrp.dgrus)
4613:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4614:             IF !EMPTY(loc_cCod)
4615:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4616:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
4617:                     "cursor_4c_TmpDgru")
4618:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpDgru") > 0
4619:                     loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpDgru.dgrus)
4620:                 ENDIF
4621:                 IF USED("cursor_4c_TmpDgru")
4622:                     USE IN cursor_4c_TmpDgru
4623:                 ENDIF
4624:             ENDIF
4625: 
4626:             *-- Descricao do SubGrupo (sgrus -> SigCdPsg.descricaos, filtrado por cgrus)
4627:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
4628:             IF !EMPTY(loc_cCod)
4629:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4630:                     "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cCod) + ;
4631:                     " AND cgrus = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CgruP.Value)), ;
4632:                     "cursor_4c_TmpSGru")
4633:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
4634:                     loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
4635:                 ENDIF
4636:                 IF USED("cursor_4c_TmpSGru")
4637:                     USE IN cursor_4c_TmpSGru
4638:                 ENDIF
4639:             ENDIF
4640: 
4641:             *-- Descricao da Linha (linhas -> SigCdLin.descs)
4642:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
4643:             IF !EMPTY(loc_cCod)

*-- Linhas 4687 a 5255:
4687: 
4688:     *==========================================================================
4689:     * HANDLERS DE EVENTOS - Lookups da Aba Dados (Fase 5)
4690:     * BINDEVENT exige PUBLIC: sem prefixo PROTECTED
4691:     *==========================================================================
4692: 
4693:     *--------------------------------------------------------------------------
4694:     * TxtCgruP - F4 abre lookup de grupos; LostFocus valida codigo
4695:     *--------------------------------------------------------------------------
4696:     PROCEDURE TxtCgruPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4697:         IF par_nKeyCode = 115 && F4
4698:             THIS.AbrirLookupGrupoP2()
4699:         ENDIF
4700:     ENDPROC
4701: 
4702:     PROCEDURE TxtCgruPLostFocus()
4703:         LOCAL loc_oPg, loc_cCgru, loc_nRet
4704:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4705:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4706: 
4707:         IF EMPTY(loc_cCgru)
4708:             loc_oPg.txt_4c_DgruP.Value = ""
4709:             RETURN
4710:         ENDIF
4711:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4712:             RETURN
4713:         ENDIF
4714: 
4715:         TRY
4716:             loc_nRet = SQLEXEC(gnConnHandle, ;
4717:                 "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCgru), ;
4718:                 "cursor_4c_TmpGruP")
4719:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpGruP") > 0
4720:                 loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpGruP.dgrus)
4721:                 *-- Limpar subgrupo ao trocar grupo
4722:                 loc_oPg.txt_4c_CSGru.Value = ""
4723:                 loc_oPg.txt_4c_DsGru.Value = ""
4724:             ELSE
4725:                 MsgAviso("Grupo '" + loc_cCgru + "' n" + CHR(227) + "o encontrado!")
4726:                 loc_oPg.txt_4c_CgruP.Value = ""
4727:                 loc_oPg.txt_4c_DgruP.Value = ""
4728:             ENDIF
4729:             IF USED("cursor_4c_TmpGruP")
4730:                 USE IN cursor_4c_TmpGruP
4731:             ENDIF
4732:         CATCH TO loc_oErro
4733:             MsgErro(loc_oErro.Message, "Erro ao validar grupo")
4734:         ENDTRY
4735:     ENDPROC
4736: 
4737:     PROCEDURE AbrirLookupGrupoP2()
4738:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
4739:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4740:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4741: 
4742:         TRY
4743:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4744:                 "SigCdGrp", "cursor_4c_BuscaGruP", "cgrus", loc_cAtual, ;
4745:                 "Buscar Grupo de Produto")
4746:             IF VARTYPE(loc_oBusca) = "O"
4747:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4748:                     IF USED("cursor_4c_BuscaGruP")
4749:                         loc_oPg.txt_4c_CgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.cgrus)
4750:                         loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.dgrus)
4751:                         loc_oPg.txt_4c_CSGru.Value = ""
4752:                         loc_oPg.txt_4c_DsGru.Value = ""
4753:                     ENDIF
4754:                 ELSE
4755:                     IF !loc_oBusca.this_lAchouRegistro
4756:                     loc_oBusca.mAddColuna("cgrus", "", "Grupo")
4757:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
4758:                     loc_oBusca.Show()
4759:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruP")
4760:                         loc_oPg.txt_4c_CgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.cgrus)
4761:                         loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.dgrus)
4762:                         loc_oPg.txt_4c_CSGru.Value = ""
4763:                         loc_oPg.txt_4c_DsGru.Value = ""
4764:                     ENDIF
4765:                     ENDIF
4766:                 ENDIF
4767:                 loc_oBusca.Release()
4768:             ENDIF
4769:             IF USED("cursor_4c_BuscaGruP")
4770:                 USE IN cursor_4c_BuscaGruP
4771:             ENDIF
4772:         CATCH TO loc_oErro
4773:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
4774:         ENDTRY
4775:     ENDPROC
4776: 
4777:     *--------------------------------------------------------------------------
4778:     * TxtCSGru - F4 abre lookup de subgrupos filtrados por cgrus; LostFocus valida
4779:     *--------------------------------------------------------------------------
4780:     PROCEDURE TxtCSGruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4781:         IF par_nKeyCode = 115 && F4
4782:             THIS.AbrirLookupSubGrupo()
4783:         ENDIF
4784:     ENDPROC
4785: 
4786:     PROCEDURE TxtCSGruLostFocus()
4787:         LOCAL loc_oPg, loc_cSGru, loc_cCgru, loc_nRet
4788:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4789:         loc_cSGru = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
4790:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4791: 
4792:         IF EMPTY(loc_cSGru)
4793:             loc_oPg.txt_4c_DsGru.Value = ""
4794:             RETURN
4795:         ENDIF
4796:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4797:             RETURN
4798:         ENDIF
4799: 
4800:         TRY
4801:             loc_nRet = SQLEXEC(gnConnHandle, ;
4802:                 "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cSGru) + ;
4803:                 IIF(EMPTY(loc_cCgru), "", " AND cgrus = " + EscaparSQL(loc_cCgru)), ;
4804:                 "cursor_4c_TmpSGru")
4805:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
4806:                 loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
4807:             ELSE
4808:                 MsgAviso("Subgrupo '" + loc_cSGru + "' n" + CHR(227) + "o encontrado!")
4809:                 loc_oPg.txt_4c_CSGru.Value = ""
4810:                 loc_oPg.txt_4c_DsGru.Value = ""
4811:             ENDIF
4812:             IF USED("cursor_4c_TmpSGru")
4813:                 USE IN cursor_4c_TmpSGru
4814:             ENDIF
4815:         CATCH TO loc_oErro
4816:             MsgErro(loc_oErro.Message, "Erro ao validar subgrupo")
4817:         ENDTRY
4818:     ENDPROC
4819: 
4820:     PROCEDURE AbrirLookupSubGrupo()
4821:         LOCAL loc_oBusca, loc_oPg, loc_cCgru, loc_cAtual
4822:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4823:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4824:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
4825: 
4826:         TRY
4827:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4828:                 "SigCdPsg", "cursor_4c_BuscaSGru", "codigos", loc_cAtual, ;
4829:                 "Buscar Subgrupo", .F., .T., ;
4830:                 IIF(EMPTY(loc_cCgru), "", "cgrus = " + EscaparSQL(loc_cCgru)))
4831:             IF VARTYPE(loc_oBusca) = "O"
4832:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4833:                     IF USED("cursor_4c_BuscaSGru")
4834:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4835:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4836:                     ENDIF
4837:                 ELSE
4838:                     IF !loc_oBusca.this_lAchouRegistro
4839:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
4840:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4841:                     loc_oBusca.Show()
4842:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
4843:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4844:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4845:                     ENDIF
4846:                     ENDIF
4847:                 ENDIF
4848:                 loc_oBusca.Release()
4849:             ENDIF
4850:             IF USED("cursor_4c_BuscaSGru")
4851:                 USE IN cursor_4c_BuscaSGru
4852:             ENDIF
4853:         CATCH TO loc_oErro
4854:             MsgErro(loc_oErro.Message, "Erro ao buscar subgrupo")
4855:         ENDTRY
4856:     ENDPROC
4857: 
4858:     *--------------------------------------------------------------------------
4859:     * TxtLin - F4 abre lookup de linhas; LostFocus valida codigo
4860:     *--------------------------------------------------------------------------
4861:     PROCEDURE TxtLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4862:         IF par_nKeyCode = 115 && F4
4863:             THIS.AbrirLookupLinha()
4864:         ENDIF
4865:     ENDPROC
4866: 
4867:     PROCEDURE TxtLinLostFocus()
4868:         LOCAL loc_oPg, loc_cLin, loc_nRet
4869:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4870:         loc_cLin = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
4871: 
4872:         IF EMPTY(loc_cLin)
4873:             loc_oPg.txt_4c_DLin.Value = ""
4874:             RETURN
4875:         ENDIF
4876:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4877:             RETURN
4878:         ENDIF
4879: 
4880:         TRY
4881:             loc_nRet = SQLEXEC(gnConnHandle, ;
4882:                 "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cLin), ;
4883:                 "cursor_4c_TmpLin")
4884:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLin") > 0
4885:                 loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_TmpLin.descs)
4886:             ELSE
4887:                 MsgAviso("Linha '" + loc_cLin + "' n" + CHR(227) + "o encontrada!")
4888:                 loc_oPg.txt_4c_Lin.Value  = ""
4889:                 loc_oPg.txt_4c_DLin.Value = ""
4890:             ENDIF
4891:             IF USED("cursor_4c_TmpLin")
4892:                 USE IN cursor_4c_TmpLin
4893:             ENDIF
4894:         CATCH TO loc_oErro
4895:             MsgErro(loc_oErro.Message, "Erro ao validar linha")
4896:         ENDTRY
4897:     ENDPROC
4898: 
4899:     PROCEDURE AbrirLookupLinha()
4900:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
4901:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4902:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
4903: 
4904:         TRY
4905:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4906:                 "SigCdLin", "cursor_4c_BuscaLin", "linhas", loc_cAtual, ;
4907:                 "Buscar Linha")
4908:             IF VARTYPE(loc_oBusca) = "O"
4909:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4910:                     IF USED("cursor_4c_BuscaLin")
4911:                         loc_oPg.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_BuscaLin.linhas)
4912:                         loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_BuscaLin.descs)
4913:                     ENDIF
4914:                 ELSE
4915:                     IF !loc_oBusca.this_lAchouRegistro
4916:                     loc_oBusca.mAddColuna("linhas", "", "Linha")
4917:                     loc_oBusca.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4918:                     loc_oBusca.Show()
4919:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
4920:                         loc_oPg.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_BuscaLin.linhas)
4921:                         loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_BuscaLin.descs)
4922:                     ENDIF
4923:                     ENDIF
4924:                 ENDIF
4925:                 loc_oBusca.Release()
4926:             ENDIF
4927:             IF USED("cursor_4c_BuscaLin")
4928:                 USE IN cursor_4c_BuscaLin
4929:             ENDIF
4930:         CATCH TO loc_oErro
4931:             MsgErro(loc_oErro.Message, "Erro ao buscar linha")
4932:         ENDTRY
4933:     ENDPROC
4934: 
4935:     *--------------------------------------------------------------------------
4936:     * TxtCol - F4 abre lookup de grupos de venda (SIGCDCOL); LostFocus valida
4937:     *--------------------------------------------------------------------------
4938:     PROCEDURE TxtColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4939:         IF par_nKeyCode = 115 && F4
4940:             THIS.AbrirLookupGVenda()
4941:         ENDIF
4942:     ENDPROC
4943: 
4944:     PROCEDURE TxtColLostFocus()
4945:         LOCAL loc_oPg, loc_cCol, loc_nRet
4946:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4947:         loc_cCol = ALLTRIM(loc_oPg.txt_4c_Col.Value)
4948: 
4949:         IF EMPTY(loc_cCol)
4950:             loc_oPg.txt_4c_DCol.Value = ""
4951:             RETURN
4952:         ENDIF
4953:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4954:             RETURN
4955:         ENDIF
4956: 
4957:         TRY
4958:             loc_nRet = SQLEXEC(gnConnHandle, ;
4959:                 "SELECT descs FROM SIGCDCOL WHERE colecoes = " + EscaparSQL(loc_cCol), ;
4960:                 "cursor_4c_TmpCol")
4961:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCol") > 0
4962:                 loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_TmpCol.descs)
4963:             ELSE
4964:                 MsgAviso("Grupo de Venda '" + loc_cCol + "' n" + CHR(227) + "o encontrado!")
4965:                 loc_oPg.txt_4c_Col.Value  = ""
4966:                 loc_oPg.txt_4c_DCol.Value = ""
4967:             ENDIF
4968:             IF USED("cursor_4c_TmpCol")
4969:                 USE IN cursor_4c_TmpCol
4970:             ENDIF
4971:         CATCH TO loc_oErro
4972:             MsgErro(loc_oErro.Message, "Erro ao validar grupo de venda")
4973:         ENDTRY
4974:     ENDPROC
4975: 
4976:     PROCEDURE AbrirLookupGVenda()
4977:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
4978:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4979:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Col.Value)
4980: 
4981:         TRY
4982:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4983:                 "SIGCDCOL", "cursor_4c_BuscaCol", "colecoes", loc_cAtual, ;
4984:                 "Buscar Grupo de Venda")
4985:             IF VARTYPE(loc_oBusca) = "O"
4986:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4987:                     IF USED("cursor_4c_BuscaCol")
4988:                         loc_oPg.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.colecoes)
4989:                         loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.descs)
4990:                     ENDIF
4991:                 ELSE
4992:                     IF !loc_oBusca.this_lAchouRegistro
4993:                     loc_oBusca.mAddColuna("colecoes", "", "C" + CHR(243) + "digo")
4994:                     loc_oBusca.mAddColuna("descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
4995:                     loc_oBusca.Show()
4996:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
4997:                         loc_oPg.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.colecoes)
4998:                         loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.descs)
4999:                     ENDIF
5000:                     ENDIF
5001:                 ENDIF
5002:                 loc_oBusca.Release()
5003:             ENDIF
5004:             IF USED("cursor_4c_BuscaCol")
5005:                 USE IN cursor_4c_BuscaCol
5006:             ENDIF
5007:         CATCH TO loc_oErro
5008:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo de venda")
5009:         ENDTRY
5010:     ENDPROC
5011: 
5012:     *--------------------------------------------------------------------------
5013:     * TxtIfor - F4 abre lookup de fornecedores (SigCdCli); LostFocus valida
5014:     *--------------------------------------------------------------------------
5015:     PROCEDURE TxtIforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5016:         IF par_nKeyCode = 115 && F4
5017:             THIS.AbrirLookupFornecedor()
5018:         ENDIF
5019:     ENDPROC
5020: 
5021:     PROCEDURE TxtIforLostFocus()
5022:         LOCAL loc_oPg, loc_cIfor, loc_nRet
5023:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5024:         loc_cIfor = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
5025: 
5026:         IF EMPTY(loc_cIfor)
5027:             loc_oPg.txt_4c_Dfor.Value = ""
5028:             RETURN
5029:         ENDIF
5030:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
5031:             RETURN
5032:         ENDIF
5033: 
5034:         TRY
5035:             loc_nRet = SQLEXEC(gnConnHandle, ;
5036:                 "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cIfor), ;
5037:                 "cursor_4c_TmpIfor")
5038:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpIfor") > 0
5039:                 loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_TmpIfor.rclis)
5040:             ELSE
5041:                 MsgAviso("Fornecedor '" + loc_cIfor + "' n" + CHR(227) + "o encontrado!")
5042:                 loc_oPg.txt_4c_Ifor.Value = ""
5043:                 loc_oPg.txt_4c_Dfor.Value = ""
5044:             ENDIF
5045:             IF USED("cursor_4c_TmpIfor")
5046:                 USE IN cursor_4c_TmpIfor
5047:             ENDIF
5048:         CATCH TO loc_oErro
5049:             MsgErro(loc_oErro.Message, "Erro ao validar fornecedor")
5050:         ENDTRY
5051:     ENDPROC
5052: 
5053:     PROCEDURE AbrirLookupFornecedor()
5054:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
5055:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5056:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
5057: 
5058:         TRY
5059:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5060:                 "SigCdCli", "cursor_4c_BuscaIfor", "iclis", loc_cAtual, ;
5061:                 "Buscar Fornecedor")
5062:             IF VARTYPE(loc_oBusca) = "O"
5063:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
5064:                     IF USED("cursor_4c_BuscaIfor")
5065:                         loc_oPg.txt_4c_Ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.iclis)
5066:                         loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.rclis)
5067:                     ENDIF
5068:                 ELSE
5069:                     IF !loc_oBusca.this_lAchouRegistro
5070:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
5071:                     loc_oBusca.mAddColuna("rclis", "", "Nome/Raz" + CHR(227) + "o Social")
5072:                     loc_oBusca.Show()
5073:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
5074:                         loc_oPg.txt_4c_Ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.iclis)
5075:                         loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.rclis)
5076:                     ENDIF
5077:                     ENDIF
5078:                 ENDIF
5079:                 loc_oBusca.Release()
5080:             ENDIF
5081:             IF USED("cursor_4c_BuscaIfor")
5082:                 USE IN cursor_4c_BuscaIfor
5083:             ENDIF
5084:         CATCH TO loc_oErro
5085:             MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
5086:         ENDTRY
5087:     ENDPROC
5088: 
5089:     *--------------------------------------------------------------------------
5090:     * TxtCProEq - F4 abre lookup de produto equivalente; LostFocus valida
5091:     *--------------------------------------------------------------------------
5092:     PROCEDURE TxtCProEqKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5093:         IF par_nKeyCode = 115 && F4
5094:             THIS.AbrirLookupProdEq()
5095:         ENDIF
5096:     ENDPROC
5097: 
5098:     PROCEDURE TxtCProEqLostFocus()
5099:         LOCAL loc_oPg, loc_cCpro, loc_nRet
5100:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5101:         loc_cCpro = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)
5102: 
5103:         IF EMPTY(loc_cCpro)
5104:             RETURN
5105:         ENDIF
5106:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
5107:             RETURN
5108:         ENDIF
5109: 
5110:         TRY
5111:             loc_nRet = SQLEXEC(gnConnHandle, ;
5112:                 "SELECT cpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpro), ;
5113:                 "cursor_4c_TmpProEq")
5114:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpProEq") = 0
5115:                 MsgAviso("Produto equivalente '" + loc_cCpro + "' n" + CHR(227) + "o encontrado!")
5116:                 loc_oPg.txt_4c_CProEq.Value = ""
5117:             ENDIF
5118:             IF USED("cursor_4c_TmpProEq")
5119:                 USE IN cursor_4c_TmpProEq
5120:             ENDIF
5121:         CATCH TO loc_oErro
5122:             MsgErro(loc_oErro.Message, "Erro ao validar produto equivalente")
5123:         ENDTRY
5124:     ENDPROC
5125: 
5126:     PROCEDURE AbrirLookupProdEq()
5127:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
5128:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5129:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)
5130: 
5131:         TRY
5132:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5133:                 "SigCdPro", "cursor_4c_BuscaProEq", "cpros", loc_cAtual, ;
5134:                 "Buscar Produto Equivalente")
5135:             IF VARTYPE(loc_oBusca) = "O"
5136:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
5137:                     IF USED("cursor_4c_BuscaProEq")
5138:                         loc_oPg.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaProEq.cpros)
5139:                     ENDIF
5140:                 ELSE
5141:                     IF !loc_oBusca.this_lAchouRegistro
5142:                     loc_oBusca.mAddColuna("cpros", "", "Produto")
5143:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
5144:                     loc_oBusca.Show()
5145:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProEq")
5146:                         loc_oPg.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaProEq.cpros)
5147:                     ENDIF
5148:                     ENDIF
5149:                 ENDIF
5150:                 loc_oBusca.Release()
5151:             ENDIF
5152:             IF USED("cursor_4c_BuscaProEq")
5153:                 USE IN cursor_4c_BuscaProEq
5154:             ENDIF
5155:         CATCH TO loc_oErro
5156:             MsgErro(loc_oErro.Message, "Erro ao buscar produto equivalente")
5157:         ENDTRY
5158:     ENDPROC
5159: 
5160:     *--------------------------------------------------------------------------
5161:     * TxtConjunto - F4 abre lookup de conjuntos (valores distintos de SigCdPro)
5162:     *--------------------------------------------------------------------------
5163:     PROCEDURE TxtConjuntoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5164:         IF par_nKeyCode = 115 && F4
5165:             THIS.AbrirLookupConjunto()
5166:         ENDIF
5167:     ENDPROC
5168: 
5169:     PROCEDURE AbrirLookupConjunto()
5170:         LOCAL loc_oBusca, loc_oPg, loc_nRet
5171:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5172: 
5173:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
5174:             RETURN
5175:         ENDIF
5176: 
5177:         TRY
5178:             *-- Busca conjuntos distintos ja cadastrados em SigCdPro
5179:             loc_nRet = SQLEXEC(gnConnHandle, ;
5180:                 "SELECT DISTINCT conjunts FROM SigCdPro WHERE LTRIM(RTRIM(conjunts)) <> '' ORDER BY conjunts", ;
5181:                 "cursor_4c_BuscaCnj")
5182: 
5183:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaCnj") > 0
5184:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5185:                 IF VARTYPE(loc_oBusca) = "O"
5186:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCnj"
5187:                     loc_oBusca.this_cTitulo        = "Buscar Conjunto"
5188:                     loc_oBusca.mAddColuna("conjunts", "", "Conjunto")
5189:                     loc_oBusca.Show()
5190:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnj")
5191:                         loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_BuscaCnj.conjunts)
5192:                     ENDIF
5193:                     loc_oBusca.Release()
5194:                 ENDIF
5195:             ENDIF
5196: 
5197:             IF USED("cursor_4c_BuscaCnj")
5198:                 USE IN cursor_4c_BuscaCnj
5199:             ENDIF
5200:         CATCH TO loc_oErro
5201:             MsgErro(loc_oErro.Message, "Erro ao buscar conjunto")
5202:         ENDTRY
5203:     ENDPROC
5204: 
5205:     *==========================================================================
5206:     * FASE 6 - Configuracao da Aba Dados (pgDados - campos restantes)
5207:     *==========================================================================
5208: 
5209:     *--------------------------------------------------------------------------
5210:     * ConfigurarPgDadosP2 - Configura campos restantes da aba Dados
5211:     * Cobre: Qt.Pedido, Garantia, Dimensoes fisicas, Ultima Compra,
5212:     *        Modelo, Acabamento, Classif., Local, Custos, Unidades,
5213:     *        Auditoria, CodIdent, Checkboxes, Memos, Dimensoes embalagem
5214:     *--------------------------------------------------------------------------
5215:     PROTECTED PROCEDURE ConfigurarPgDadosP2()
5216:         LOCAL loc_oPg
5217:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5218: 
5219:         *----------------------------------------------------------------------
5220:         *-- Qt. Pedido (T:221 L:626) + Garantia (T:224 L:880)
5221:         *----------------------------------------------------------------------
5222:         loc_oPg.AddObject("lbl_4c_LblQtPed", "Label")
5223:         WITH loc_oPg.lbl_4c_LblQtPed
5224:             .Caption   = "Qt. Pedido :"
5225:             .Top       = 224
5226:             .Left      = 541
5227:             .Width     = 80
5228:             .Height    = 15
5229:             .FontName  = "Tahoma"
5230:             .FontSize  = 8
5231:             .BackStyle = 0
5232:             .ForeColor = RGB(90, 90, 90)
5233:             .Visible   = .T.
5234:         ENDWITH
5235: 
5236:         loc_oPg.AddObject("txt_4c_QtPed", "TextBox")
5237:         WITH loc_oPg.txt_4c_QtPed
5238:             .Top           = 221
5239:             .Left          = 626
5240:             .Width         = 80
5241:             .Height        = 21
5242:             .FontName      = "Tahoma"
5243:             .FontSize      = 8
5244:             .MaxLength     = 10
5245:             .Value         = ""
5246:             .SpecialEffect = 1
5247:             .Visible       = .T.
5248:         ENDWITH
5249: 
5250:         loc_oPg.AddObject("lbl_4c_LblGarantia", "Label")
5251:         WITH loc_oPg.lbl_4c_LblGarantia
5252:             .Caption   = "Gar.(dias):"
5253:             .Top       = 227
5254:             .Left      = 820
5255:             .Width     = 57

*-- Linhas 5653 a 5697:
5653:             .SpecialEffect = 1
5654:             .Visible       = .T.
5655:         ENDWITH
5656:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "KeyPress",  THIS, "TxtCodFinPKeyPress")
5657:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "LostFocus", THIS, "TxtCodFinPLostFocus")
5658: 
5659:         *-- Say35: "Peso Bruto :" (T:326 L:336 W:61)
5660:         loc_oPg.AddObject("lbl_4c_LblPesoBs", "Label")
5661:         WITH loc_oPg.lbl_4c_LblPesoBs
5662:             .Caption   = "Peso Bruto :"
5663:             .Top       = 326
5664:             .Left      = 336
5665:             .Width     = 61
5666:             .Height    = 15
5667:             .FontName  = "Tahoma"
5668:             .FontSize  = 8
5669:             .BackStyle = 0
5670:             .ForeColor = RGB(90, 90, 90)
5671:             .Visible   = .T.
5672:         ENDWITH
5673: 
5674:         *-- getPesoBs -> txt_4c_PesoBs (T:322 L:401 W:111 H:23) - pesobs numeric(7,3)
5675:         loc_oPg.AddObject("txt_4c_PesoBs", "TextBox")
5676:         WITH loc_oPg.txt_4c_PesoBs
5677:             .Top           = 322
5678:             .Left          = 401
5679:             .Width         = 111
5680:             .Height        = 23
5681:             .FontName      = "Tahoma"
5682:             .FontSize      = 8
5683:             .MaxLength     = 10
5684:             .Value         = ""
5685:             .SpecialEffect = 1
5686:             .Visible       = .T.
5687:         ENDWITH
5688: 
5689:         *----------------------------------------------------------------------
5690:         *-- Acabamento (T:346) - lblAcabamento: "Acabamento :" (T:350 L:7)
5691:         *----------------------------------------------------------------------
5692:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
5693:         WITH loc_oPg.lbl_4c_LblAcabamento
5694:             .Caption   = "Acabamento :"
5695:             .Top       = 350
5696:             .Left      = 7
5697:             .Width     = 104

*-- Linhas 5732 a 5776:
5732:             .SpecialEffect = 1
5733:             .Visible       = .T.
5734:         ENDWITH
5735:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "KeyPress",  THIS, "TxtCodAcbKeyPress")
5736:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "LostFocus", THIS, "TxtCodAcbLostFocus")
5737: 
5738:         *-- Say34: "Peso Liquido :" (T:350 L:329 W:68)
5739:         loc_oPg.AddObject("lbl_4c_LblPmedio", "Label")
5740:         WITH loc_oPg.lbl_4c_LblPmedio
5741:             .Caption   = "Peso L" + CHR(237) + "quido :"
5742:             .Top       = 350
5743:             .Left      = 329
5744:             .Width     = 68
5745:             .Height    = 15
5746:             .FontName  = "Tahoma"
5747:             .FontSize  = 8
5748:             .BackStyle = 0
5749:             .ForeColor = RGB(90, 90, 90)
5750:             .Visible   = .T.
5751:         ENDWITH
5752: 
5753:         *-- getPmedio -> txt_4c_Pmedio (T:346 L:401 W:111 H:23) - pesoms numeric(8,3)
5754:         loc_oPg.AddObject("txt_4c_Pmedio", "TextBox")
5755:         WITH loc_oPg.txt_4c_Pmedio
5756:             .Top           = 346
5757:             .Left          = 401
5758:             .Width         = 111
5759:             .Height        = 23
5760:             .FontName      = "Tahoma"
5761:             .FontSize      = 8
5762:             .MaxLength     = 10
5763:             .Value         = ""
5764:             .SpecialEffect = 1
5765:             .Visible       = .T.
5766:         ENDWITH
5767: 
5768:         *----------------------------------------------------------------------
5769:         *-- Estoque (T:353) - Say28: "Estoque :" (T:357 L:577 W:48)
5770:         *----------------------------------------------------------------------
5771:         loc_oPg.AddObject("lbl_4c_LblEstoque", "Label")
5772:         WITH loc_oPg.lbl_4c_LblEstoque
5773:             .Caption   = "Estoque :"
5774:             .Top       = 357
5775:             .Left      = 577
5776:             .Width     = 48

*-- Linhas 5862 a 5938:
5862:             .SpecialEffect = 1
5863:             .Visible       = .T.
5864:         ENDWITH
5865:         BINDEVENT(loc_oPg.txt_4c_Class, "KeyPress",  THIS, "TxtClassKeyPress")
5866:         BINDEVENT(loc_oPg.txt_4c_Class, "LostFocus", THIS, "TxtClassLostFocus")
5867: 
5868:         *-- Say5: "Local :" (T:374 L:364 W:33)
5869:         loc_oPg.AddObject("lbl_4c_LblLocal", "Label")
5870:         WITH loc_oPg.lbl_4c_LblLocal
5871:             .Caption   = "Local :"
5872:             .Top       = 374
5873:             .Left      = 364
5874:             .Width     = 33
5875:             .Height    = 15
5876:             .FontName  = "Tahoma"
5877:             .FontSize  = 8
5878:             .BackStyle = 0
5879:             .ForeColor = RGB(90, 90, 90)
5880:             .Visible   = .T.
5881:         ENDWITH
5882: 
5883:         *-- Get_Local -> txt_4c_Local (T:370 L:401 W:111 H:23) - locals char(10)
5884:         loc_oPg.AddObject("txt_4c_Local", "TextBox")
5885:         WITH loc_oPg.txt_4c_Local
5886:             .Top           = 370
5887:             .Left          = 401
5888:             .Width         = 111
5889:             .Height        = 23
5890:             .FontName      = "Tahoma"
5891:             .FontSize      = 8
5892:             .MaxLength     = 10
5893:             .Value         = ""
5894:             .SpecialEffect = 1
5895:             .Visible       = .T.
5896:         ENDWITH
5897:         BINDEVENT(loc_oPg.txt_4c_Local, "KeyPress",  THIS, "TxtLocalKeyPress")
5898:         BINDEVENT(loc_oPg.txt_4c_Local, "LostFocus", THIS, "TxtLocalLostFocus")
5899: 
5900:         *----------------------------------------------------------------------
5901:         *-- Custo (T:375) - Say3: "Valor de Custo :" (T:379 L:546 W:79)
5902:         *----------------------------------------------------------------------
5903:         loc_oPg.AddObject("lbl_4c_LblCusto", "Label")
5904:         WITH loc_oPg.lbl_4c_LblCusto
5905:             .Caption   = "Valor de Custo :"
5906:             .Top       = 379
5907:             .Left      = 546
5908:             .Width     = 79
5909:             .Height    = 15
5910:             .FontName  = "Tahoma"
5911:             .FontSize  = 8
5912:             .BackStyle = 0
5913:             .ForeColor = RGB(90, 90, 90)
5914:             .Visible   = .T.
5915:         ENDWITH
5916: 
5917:         *-- getCtotal -> txt_4c_Ctotal (T:375 L:626 W:127 H:21) - custofs (display)
5918:         loc_oPg.AddObject("txt_4c_Ctotal", "TextBox")
5919:         WITH loc_oPg.txt_4c_Ctotal
5920:             .Top           = 375
5921:             .Left          = 626
5922:             .Width         = 127
5923:             .Height        = 21
5924:             .FontName      = "Tahoma"
5925:             .FontSize      = 8
5926:             .ReadOnly      = .T.
5927:             .MaxLength     = 14
5928:             .Value         = ""
5929:             .SpecialEffect = 1
5930:             .ForeColor     = RGB(36, 84, 155)
5931:             .BackColor     = RGB(224, 235, 235)
5932:             .Visible       = .T.
5933:         ENDWITH
5934: 
5935:         *-- getMctotal -> txt_4c_Mctotal (T:375 L:754 W:31 H:21) - moecusfs (display)
5936:         loc_oPg.AddObject("txt_4c_Mctotal", "TextBox")
5937:         WITH loc_oPg.txt_4c_Mctotal
5938:             .Top           = 375

*-- Linhas 6029 a 6120:
6029:             .SpecialEffect = 1
6030:             .Visible       = .T.
6031:         ENDWITH
6032:         BINDEVENT(loc_oPg.txt_4c_Cuni, "KeyPress",  THIS, "TxtCuniKeyPress")
6033:         BINDEVENT(loc_oPg.txt_4c_Cuni, "LostFocus", THIS, "TxtCuniLostFocus")
6034: 
6035:         *-- Get_Duni -> txt_4c_DUni (T:394 L:145 W:150 H:23) - desc unid1 (readonly)
6036:         loc_oPg.AddObject("txt_4c_DUni", "TextBox")
6037:         WITH loc_oPg.txt_4c_DUni
6038:             .Top           = 394
6039:             .Left          = 145
6040:             .Width         = 150
6041:             .Height        = 23
6042:             .FontName      = "Tahoma"
6043:             .FontSize      = 8
6044:             .ReadOnly      = .T.
6045:             .Value         = ""
6046:             .SpecialEffect = 1
6047:             .Visible       = .T.
6048:         ENDWITH
6049: 
6050:         *-- Say18: "(2) :" (T:398 L:301 W:23)
6051:         loc_oPg.AddObject("lbl_4c_LblUnid2", "Label")
6052:         WITH loc_oPg.lbl_4c_LblUnid2
6053:             .Caption   = "(2) :"
6054:             .Top       = 398
6055:             .Left      = 301
6056:             .Width     = 23
6057:             .Height    = 15
6058:             .FontName  = "Tahoma"
6059:             .FontSize  = 8
6060:             .BackStyle = 0
6061:             .ForeColor = RGB(90, 90, 90)
6062:             .Visible   = .T.
6063:         ENDWITH
6064: 
6065:         *-- Get_cunip -> txt_4c_Cunip (T:394 L:330 W:31 H:23) - cunips char(3)
6066:         loc_oPg.AddObject("txt_4c_Cunip", "TextBox")
6067:         WITH loc_oPg.txt_4c_Cunip
6068:             .Top           = 394
6069:             .Left          = 330
6070:             .Width         = 31
6071:             .Height        = 23
6072:             .FontName      = "Tahoma"
6073:             .FontSize      = 8
6074:             .MaxLength     = 3
6075:             .Value         = ""
6076:             .SpecialEffect = 1
6077:             .Visible       = .T.
6078:         ENDWITH
6079:         BINDEVENT(loc_oPg.txt_4c_Cunip, "KeyPress",  THIS, "TxtCunipKeyPress")
6080:         BINDEVENT(loc_oPg.txt_4c_Cunip, "LostFocus", THIS, "TxtCunipLostFocus")
6081: 
6082:         *-- get_dunip -> txt_4c_DUnip (T:394 L:362 W:150 H:23) - desc unid2 (readonly)
6083:         loc_oPg.AddObject("txt_4c_DUnip", "TextBox")
6084:         WITH loc_oPg.txt_4c_DUnip
6085:             .Top           = 394
6086:             .Left          = 362
6087:             .Width         = 150
6088:             .Height        = 23
6089:             .FontName      = "Tahoma"
6090:             .FontSize      = 8
6091:             .ReadOnly      = .T.
6092:             .Value         = ""
6093:             .SpecialEffect = 1
6094:             .Visible       = .T.
6095:         ENDWITH
6096: 
6097:         *----------------------------------------------------------------------
6098:         *-- Preco Venda + Auditoria linha 1 (T:397)
6099:         *-- Say4: "Valor de Venda :" (T:400 L:505 W:120)
6100:         *----------------------------------------------------------------------
6101:         loc_oPg.AddObject("lbl_4c_LblPvenda", "Label")
6102:         WITH loc_oPg.lbl_4c_LblPvenda
6103:             .Caption   = "Valor de Venda :"
6104:             .Top       = 400
6105:             .Left      = 505
6106:             .Width     = 120
6107:             .Height    = 15
6108:             .FontName  = "Tahoma"
6109:             .FontSize  = 8
6110:             .BackStyle = 0
6111:             .ForeColor = RGB(90, 90, 90)
6112:             .Visible   = .T.
6113:         ENDWITH
6114: 
6115:         *-- getPvenda -> txt_4c_Pvenda (T:397 L:626 W:127 H:21) - pvens (display)
6116:         loc_oPg.AddObject("txt_4c_Pvenda", "TextBox")
6117:         WITH loc_oPg.txt_4c_Pvenda
6118:             .Top           = 397
6119:             .Left          = 626
6120:             .Width         = 127

*-- Linhas 6648 a 6691:
6648:     *--------------------------------------------------------------------------
6649:     * PreencherDescricoesPgDadosP2 - Busca descricoes de unidades (readonly)
6650:     *--------------------------------------------------------------------------
6651:     PROCEDURE PreencherDescricoesPgDadosP2()
6652:         LOCAL loc_oPg, loc_cCod, loc_cCgru, loc_nRet
6653:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6654: 
6655:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6656:             RETURN
6657:         ENDIF
6658:         IF VARTYPE(loc_oPg.txt_4c_Cuni) # "O"
6659:             RETURN
6660:         ENDIF
6661: 
6662:         TRY
6663:             *-- Descricao Unidade 1 (cunis -> SigCdUni.dunis)
6664:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6665:             IF !EMPTY(loc_cCod)
6666:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6667:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6668:                     "cursor_4c_TmpUni")
6669:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUni") > 0
6670:                     loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpUni.dunis)
6671:                 ENDIF
6672:                 IF USED("cursor_4c_TmpUni")
6673:                     USE IN cursor_4c_TmpUni
6674:                 ENDIF
6675:             ENDIF
6676: 
6677:             *-- Descricao Unidade 2 (cunips -> SigCdUni.dunis)
6678:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6679:             IF !EMPTY(loc_cCod)
6680:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6681:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6682:                     "cursor_4c_TmpUnip")
6683:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUnip") > 0
6684:                     loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpUnip.dunis)
6685:                 ENDIF
6686:                 IF USED("cursor_4c_TmpUnip")
6687:                     USE IN cursor_4c_TmpUnip
6688:                 ENDIF
6689:             ENDIF
6690: 
6691:             *-- Descricao Modelo (codfinp -> SigCdFip.descs)

*-- Linhas 6754 a 7267:
6754: 
6755:     *==========================================================================
6756:     * HANDLERS DE EVENTOS - Lookups da Aba Dados (Fase 6)
6757:     * BINDEVENT exige PUBLIC: sem prefixo PROTECTED
6758:     *==========================================================================
6759: 
6760:     *--------------------------------------------------------------------------
6761:     * TxtCuni - F4 abre lookup de unidades; LostFocus valida codigo
6762:     *--------------------------------------------------------------------------
6763:     PROCEDURE TxtCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6764:         IF par_nKeyCode = 115 && F4
6765:             THIS.AbrirLookupUnidade1()
6766:         ENDIF
6767:     ENDPROC
6768: 
6769:     PROCEDURE TxtCuniLostFocus()
6770:         LOCAL loc_oPg, loc_cCuni, loc_nRet
6771:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6772:         loc_cCuni = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6773: 
6774:         IF EMPTY(loc_cCuni)
6775:             loc_oPg.txt_4c_DUni.Value = ""
6776:             RETURN
6777:         ENDIF
6778:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6779:             RETURN
6780:         ENDIF
6781: 
6782:         TRY
6783:             loc_nRet = SQLEXEC(gnConnHandle, ;
6784:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCuni), ;
6785:                 "cursor_4c_TmpCuni")
6786:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCuni") > 0
6787:                 loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpCuni.dunis)
6788:             ELSE
6789:                 MsgAviso("Unidade '" + loc_cCuni + "' n" + CHR(227) + "o encontrada!")
6790:                 loc_oPg.txt_4c_Cuni.Value = ""
6791:                 loc_oPg.txt_4c_DUni.Value = ""
6792:             ENDIF
6793:             IF USED("cursor_4c_TmpCuni")
6794:                 USE IN cursor_4c_TmpCuni
6795:             ENDIF
6796:         CATCH TO loc_oErro
6797:             MsgErro(loc_oErro.Message, "Erro ao validar unidade")
6798:         ENDTRY
6799:     ENDPROC
6800: 
6801:     PROCEDURE AbrirLookupUnidade1()
6802:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
6803:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6804:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6805: 
6806:         TRY
6807:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6808:                 "SigCdUni", "cursor_4c_BuscaUni", "cunis", loc_cAtual, ;
6809:                 "Buscar Unidade")
6810:             IF VARTYPE(loc_oBusca) = "O"
6811:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
6812:                     IF USED("cursor_4c_BuscaUni")
6813:                         loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
6814:                         loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
6815:                     ENDIF
6816:                 ELSE
6817:                     IF !loc_oBusca.this_lAchouRegistro
6818:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6819:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6820:                     loc_oBusca.Show()
6821:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
6822:                         loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
6823:                         loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
6824:                     ENDIF
6825:                     ENDIF
6826:                 ENDIF
6827:                 loc_oBusca.Release()
6828:             ENDIF
6829:             IF USED("cursor_4c_BuscaUni")
6830:                 USE IN cursor_4c_BuscaUni
6831:             ENDIF
6832:         CATCH TO loc_oErro
6833:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
6834:         ENDTRY
6835:     ENDPROC
6836: 
6837:     *--------------------------------------------------------------------------
6838:     * TxtCunip - F4 abre lookup de unidades 2; LostFocus valida codigo
6839:     *--------------------------------------------------------------------------
6840:     PROCEDURE TxtCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6841:         IF par_nKeyCode = 115 && F4
6842:             THIS.AbrirLookupUnidade2()
6843:         ENDIF
6844:     ENDPROC
6845: 
6846:     PROCEDURE TxtCunipLostFocus()
6847:         LOCAL loc_oPg, loc_cCunip, loc_nRet
6848:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6849:         loc_cCunip = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6850: 
6851:         IF EMPTY(loc_cCunip)
6852:             loc_oPg.txt_4c_DUnip.Value = ""
6853:             RETURN
6854:         ENDIF
6855:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6856:             RETURN
6857:         ENDIF
6858: 
6859:         TRY
6860:             loc_nRet = SQLEXEC(gnConnHandle, ;
6861:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCunip), ;
6862:                 "cursor_4c_TmpCunip")
6863:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCunip") > 0
6864:                 loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpCunip.dunis)
6865:             ELSE
6866:                 MsgAviso("Unidade '" + loc_cCunip + "' n" + CHR(227) + "o encontrada!")
6867:                 loc_oPg.txt_4c_Cunip.Value = ""
6868:                 loc_oPg.txt_4c_DUnip.Value = ""
6869:             ENDIF
6870:             IF USED("cursor_4c_TmpCunip")
6871:                 USE IN cursor_4c_TmpCunip
6872:             ENDIF
6873:         CATCH TO loc_oErro
6874:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
6875:         ENDTRY
6876:     ENDPROC
6877: 
6878:     PROCEDURE AbrirLookupUnidade2()
6879:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
6880:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6881:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6882: 
6883:         TRY
6884:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6885:                 "SigCdUni", "cursor_4c_BuscaUnip", "cunis", loc_cAtual, ;
6886:                 "Buscar Unidade 2")
6887:             IF VARTYPE(loc_oBusca) = "O"
6888:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
6889:                     IF USED("cursor_4c_BuscaUnip")
6890:                         loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
6891:                         loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
6892:                     ENDIF
6893:                 ELSE
6894:                     IF !loc_oBusca.this_lAchouRegistro
6895:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6896:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6897:                     loc_oBusca.Show()
6898:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnip")
6899:                         loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
6900:                         loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
6901:                     ENDIF
6902:                     ENDIF
6903:                 ENDIF
6904:                 loc_oBusca.Release()
6905:             ENDIF
6906:             IF USED("cursor_4c_BuscaUnip")
6907:                 USE IN cursor_4c_BuscaUnip
6908:             ENDIF
6909:         CATCH TO loc_oErro
6910:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade 2")
6911:         ENDTRY
6912:     ENDPROC
6913: 
6914:     *--------------------------------------------------------------------------
6915:     * TxtCodFinP - F4 abre lookup de modelos (SigCdFip); LostFocus valida
6916:     *--------------------------------------------------------------------------
6917:     PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6918:         IF par_nKeyCode = 115 && F4
6919:             THIS.AbrirLookupModelo()
6920:         ENDIF
6921:     ENDPROC
6922: 
6923:     PROCEDURE TxtCodFinPLostFocus()
6924:         LOCAL loc_oPg, loc_cCod, loc_nRet
6925:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6926:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
6927: 
6928:         IF EMPTY(loc_cCod)
6929:             loc_oPg.txt_4c_DFinP.Value = ""
6930:             RETURN
6931:         ENDIF
6932:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6933:             RETURN
6934:         ENDIF
6935: 
6936:         TRY
6937:             loc_nRet = SQLEXEC(gnConnHandle, ;
6938:                 "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
6939:                 "cursor_4c_TmpFinP")
6940:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
6941:                 loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
6942:             ELSE
6943:                 MsgAviso("Modelo '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
6944:                 loc_oPg.txt_4c_CodFinP.Value = ""
6945:                 loc_oPg.txt_4c_DFinP.Value   = ""
6946:             ENDIF
6947:             IF USED("cursor_4c_TmpFinP")
6948:                 USE IN cursor_4c_TmpFinP
6949:             ENDIF
6950:         CATCH TO loc_oErro
6951:             MsgErro(loc_oErro.Message, "Erro ao validar modelo")
6952:         ENDTRY
6953:     ENDPROC
6954: 
6955:     PROCEDURE AbrirLookupModelo()
6956:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
6957:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6958:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
6959: 
6960:         TRY
6961:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6962:                 "SigCdFip", "cursor_4c_BuscaFinP", "cods", loc_cAtual, ;
6963:                 "Buscar Modelo")
6964:             IF VARTYPE(loc_oBusca) = "O"
6965:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
6966:                     IF USED("cursor_4c_BuscaFinP")
6967:                         loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
6968:                         loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
6969:                     ENDIF
6970:                 ELSE
6971:                     IF !loc_oBusca.this_lAchouRegistro
6972:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
6973:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
6974:                     loc_oBusca.Show()
6975:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFinP")
6976:                         loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
6977:                         loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
6978:                     ENDIF
6979:                     ENDIF
6980:                 ENDIF
6981:                 loc_oBusca.Release()
6982:             ENDIF
6983:             IF USED("cursor_4c_BuscaFinP")
6984:                 USE IN cursor_4c_BuscaFinP
6985:             ENDIF
6986:         CATCH TO loc_oErro
6987:             MsgErro(loc_oErro.Message, "Erro ao buscar modelo")
6988:         ENDTRY
6989:     ENDPROC
6990: 
6991:     *--------------------------------------------------------------------------
6992:     * TxtCodAcb - F4 abre lookup de acabamentos (SigCdAca); LostFocus valida
6993:     *--------------------------------------------------------------------------
6994:     PROCEDURE TxtCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6995:         IF par_nKeyCode = 115 && F4
6996:             THIS.AbrirLookupAcabamento()
6997:         ENDIF
6998:     ENDPROC
6999: 
7000:     PROCEDURE TxtCodAcbLostFocus()
7001:         LOCAL loc_oPg, loc_cCod, loc_nRet
7002:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7003:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
7004: 
7005:         IF EMPTY(loc_cCod)
7006:             loc_oPg.txt_4c_DAcb.Value = ""
7007:             RETURN
7008:         ENDIF
7009:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
7010:             RETURN
7011:         ENDIF
7012: 
7013:         TRY
7014:             loc_nRet = SQLEXEC(gnConnHandle, ;
7015:                 "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
7016:                 "cursor_4c_TmpAcb")
7017:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
7018:                 loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
7019:             ELSE
7020:                 MsgAviso("Acabamento '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7021:                 loc_oPg.txt_4c_CodAcb.Value = ""
7022:                 loc_oPg.txt_4c_DAcb.Value   = ""
7023:             ENDIF
7024:             IF USED("cursor_4c_TmpAcb")
7025:                 USE IN cursor_4c_TmpAcb
7026:             ENDIF
7027:         CATCH TO loc_oErro
7028:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
7029:         ENDTRY
7030:     ENDPROC
7031: 
7032:     PROCEDURE AbrirLookupAcabamento()
7033:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
7034:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7035:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
7036: 
7037:         TRY
7038:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7039:                 "SigCdAca", "cursor_4c_BuscaAcb", "cods", loc_cAtual, ;
7040:                 "Buscar Acabamento")
7041:             IF VARTYPE(loc_oBusca) = "O"
7042:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7043:                     IF USED("cursor_4c_BuscaAcb")
7044:                         loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
7045:                         loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
7046:                     ENDIF
7047:                 ELSE
7048:                     IF !loc_oBusca.this_lAchouRegistro
7049:                     loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
7050:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7051:                     loc_oBusca.Show()
7052:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
7053:                         loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
7054:                         loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
7055:                     ENDIF
7056:                     ENDIF
7057:                 ENDIF
7058:                 loc_oBusca.Release()
7059:             ENDIF
7060:             IF USED("cursor_4c_BuscaAcb")
7061:                 USE IN cursor_4c_BuscaAcb
7062:             ENDIF
7063:         CATCH TO loc_oErro
7064:             MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
7065:         ENDTRY
7066:     ENDPROC
7067: 
7068:     *--------------------------------------------------------------------------
7069:     * TxtClass - F4 abre lookup de classificacoes (SigCdCls); LostFocus valida
7070:     * SigCdCls: filtrado por cgrus do grupo de produto corrente
7071:     *--------------------------------------------------------------------------
7072:     PROCEDURE TxtClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7073:         IF par_nKeyCode = 115 && F4
7074:             THIS.AbrirLookupClassificacao()
7075:         ENDIF
7076:     ENDPROC
7077: 
7078:     PROCEDURE TxtClassLostFocus()
7079:         LOCAL loc_oPg, loc_cCod, loc_cCgru, loc_nRet
7080:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7081:         loc_cCod  = ALLTRIM(loc_oPg.txt_4c_Class.Value)
7082:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
7083: 
7084:         IF EMPTY(loc_cCod)
7085:             loc_oPg.txt_4c_DClass.Value = ""
7086:             RETURN
7087:         ENDIF
7088:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
7089:             RETURN
7090:         ENDIF
7091: 
7092:         TRY
7093:             loc_nRet = SQLEXEC(gnConnHandle, ;
7094:                 "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
7095:                 IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
7096:                 "cursor_4c_TmpClass")
7097:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
7098:                 loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
7099:             ELSE
7100:                 MsgAviso("Classifica" + CHR(231) + CHR(227) + "o '" + loc_cCod + "' n" + CHR(227) + "o encontrada!")
7101:                 loc_oPg.txt_4c_Class.Value  = ""
7102:                 loc_oPg.txt_4c_DClass.Value = ""
7103:             ENDIF
7104:             IF USED("cursor_4c_TmpClass")
7105:                 USE IN cursor_4c_TmpClass
7106:             ENDIF
7107:         CATCH TO loc_oErro
7108:             MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
7109:         ENDTRY
7110:     ENDPROC
7111: 
7112:     PROCEDURE AbrirLookupClassificacao()
7113:         LOCAL loc_oBusca, loc_oPg, loc_cAtual, loc_cCgru
7114:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7115:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Class.Value)
7116:         loc_cCgru  = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
7117: 
7118:         TRY
7119:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7120:                 "SigCdCls", "cursor_4c_BuscaClass", "cods", loc_cAtual, ;
7121:                 "Buscar Classifica" + CHR(231) + CHR(227) + "o", .F., .T., ;
7122:                 IIF(EMPTY(loc_cCgru), "", "(cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"))
7123:             IF VARTYPE(loc_oBusca) = "O"
7124:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7125:                     IF USED("cursor_4c_BuscaClass")
7126:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7127:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7128:                     ENDIF
7129:                 ELSE
7130:                     IF !loc_oBusca.this_lAchouRegistro
7131:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
7132:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7133:                     loc_oBusca.Show()
7134:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
7135:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7136:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7137:                     ENDIF
7138:                     ENDIF
7139:                 ENDIF
7140:                 loc_oBusca.Release()
7141:             ENDIF
7142:             IF USED("cursor_4c_BuscaClass")
7143:                 USE IN cursor_4c_BuscaClass
7144:             ENDIF
7145:         CATCH TO loc_oErro
7146:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
7147:         ENDTRY
7148:     ENDPROC
7149: 
7150:     *--------------------------------------------------------------------------
7151:     * TxtLocal - F4 abre lookup de locais (SigPrLcl); LostFocus valida
7152:     *--------------------------------------------------------------------------
7153:     PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7154:         IF par_nKeyCode = 115 && F4
7155:             THIS.AbrirLookupLocal()
7156:         ENDIF
7157:     ENDPROC
7158: 
7159:     PROCEDURE TxtLocalLostFocus()
7160:         LOCAL loc_oPg, loc_cCod, loc_nRet
7161:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7162:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Local.Value)
7163: 
7164:         IF EMPTY(loc_cCod)
7165:             RETURN
7166:         ENDIF
7167:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
7168:             RETURN
7169:         ENDIF
7170: 
7171:         TRY
7172:             loc_nRet = SQLEXEC(gnConnHandle, ;
7173:                 "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
7174:                 "cursor_4c_TmpLocal")
7175:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpLocal") = 0
7176:                 MsgAviso("Local '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7177:                 loc_oPg.txt_4c_Local.Value = ""
7178:             ENDIF
7179:             IF USED("cursor_4c_TmpLocal")
7180:                 USE IN cursor_4c_TmpLocal
7181:             ENDIF
7182:         CATCH TO loc_oErro
7183:             MsgErro(loc_oErro.Message, "Erro ao validar local")
7184:         ENDTRY
7185:     ENDPROC
7186: 
7187:     PROCEDURE AbrirLookupLocal()
7188:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
7189:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7190:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Local.Value)
7191: 
7192:         TRY
7193:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7194:                 "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", loc_cAtual, ;
7195:                 "Buscar Local")
7196:             IF VARTYPE(loc_oBusca) = "O"
7197:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7198:                     IF USED("cursor_4c_BuscaLocal")
7199:                         loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
7200:                     ENDIF
7201:                 ELSE
7202:                     IF !loc_oBusca.this_lAchouRegistro
7203:                     loc_oBusca.mAddColuna("codigos",    "", "Local")
7204:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
7205:                     loc_oBusca.Show()
7206:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
7207:                         loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
7208:                     ENDIF
7209:                     ENDIF
7210:                 ENDIF
7211:                 loc_oBusca.Release()
7212:             ENDIF
7213:             IF USED("cursor_4c_BuscaLocal")
7214:                 USE IN cursor_4c_BuscaLocal
7215:             ENDIF
7216:         CATCH TO loc_oErro
7217:             MsgErro(loc_oErro.Message, "Erro ao buscar local")
7218:         ENDTRY
7219:     ENDPROC
7220: 
7221:     *==========================================================================
7222:     * FASE 11 - Aba Consulta de Componentes (PgDadosConsP - Page5 do pgf_4c_Dados)
7223:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP
7224:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
7225:     * Controles: GrdCons(9 cols), Getqtcpnt, Say7, chkFund, Say1, grDTEMP(2 cols)
7226:     *==========================================================================
7227:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP()
7228:         LOCAL loc_oPg, loc_oGrd
7229: 
7230:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
7231: 
7232:         *----------------------------------------------------------------------
7233:         *-- Cursor placeholder para GrdCons (SigPrCpo + SigCdPrf + SigCdCat)
7234:         *-- Campos: mats(comp), qtds(qtde), unicompos(uni), Grupos(fase code),
7235:         *--         Descrs(fase desc), Ordems(ord), consumo, Cods(cat), dcats(cat desc)
7236:         *----------------------------------------------------------------------
7237:         IF !USED("cursor_4c_GrdCons")
7238:             SET NULL ON
7239:             CREATE CURSOR cursor_4c_GrdCons (;
7240:                 mats      C(14), ;
7241:                 qtds      N(12,4), ;
7242:                 unicompos C(5), ;
7243:                 Grupos    C(3), ;
7244:                 Descrs    C(65), ;
7245:                 Ordems    N(5,0), ;
7246:                 consumo   N(12,4), ;
7247:                 Cods      C(5), ;
7248:                 dcats     C(65), ;
7249:                 Dopes     C(5))
7250:             SET NULL OFF
7251:         ENDIF
7252: 
7253:         *----------------------------------------------------------------------
7254:         *-- Cursor placeholder para grDTEMP (Tempo por Agrupamento)
7255:         *----------------------------------------------------------------------
7256:         IF !USED("cursor_4c_GrDTEMP")
7257:             SET NULL ON
7258:             CREATE CURSOR cursor_4c_GrDTEMP (;
7259:                 agrup C(30), ;
7260:                 tempo N(12,4))
7261:             SET NULL OFF
7262:         ENDIF
7263: 
7264:         *----------------------------------------------------------------------
7265:         *-- Grid GrdCons (T:155 L:6 W:987 H:362) - 9 colunas
7266:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.GrdCons
7267:         *-- Cols: Componente, Qtde., Uni, Fase, Descricao, Ord., Consumo, Cat., Descricao

*-- Linhas 7364 a 7411:
7364:             .Column9.ReadOnly        = .F.
7365:         ENDWITH
7366: 
7367:         *-- BINDEVENT: AfterRowColChange + KeyPress nos campos de lookup
7368:         BINDEVENT(loc_oPg.grd_4c_GrdCons, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
7369:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
7370:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
7371:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
7372: 
7373:         *----------------------------------------------------------------------
7374:         *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
7375:         *----------------------------------------------------------------------
7376:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
7377:         WITH loc_oPg.lbl_4c_Label7
7378:             .Caption   = "Qtde Componentes : "
7379:             .Top       = 523
7380:             .Left      = 25
7381:             .Width     = 105
7382:             .Height    = 15
7383:             .FontName  = "Tahoma"
7384:             .FontSize  = 8
7385:             .BackStyle = 0
7386:             .ForeColor = RGB(90, 90, 90)
7387:             .Visible   = .T.
7388:         ENDWITH
7389: 
7390:         *----------------------------------------------------------------------
7391:         *-- TextBox Getqtcpnt (T:519 L:131 W:31 H:23)
7392:         *-- Legado When: Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
7393:         *-- Habilitado somente em modo edicao (via HabilitarCampos/DesabilitarCampos)
7394:         *----------------------------------------------------------------------
7395:         loc_oPg.AddObject("txt_4c_Qtcpnt", "TextBox")
7396:         WITH loc_oPg.txt_4c_Qtcpnt
7397:             .Top           = 519
7398:             .Left          = 131
7399:             .Width         = 31
7400:             .Height        = 23
7401:             .FontName      = "Tahoma"
7402:             .FontSize      = 8
7403:             .Value         = 0
7404:             .SpecialEffect = 1
7405:             .ForeColor     = RGB(36, 84, 155)
7406:             .Enabled       = .F.
7407:             .Visible       = .T.
7408:         ENDWITH
7409: 
7410:         *----------------------------------------------------------------------
7411:         *-- CheckBox chkFund (T:544 L:10 W:182 H:15)

*-- Linhas 7502 a 7764:
7502: 
7503:     *==========================================================================
7504:     * FASE 11 - Handlers publicos da aba Consulta de Componentes (PgDadosConsP)
7505:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
7506:     *==========================================================================
7507: 
7508:     *--------------------------------------------------------------------------
7509:     * GrdConsAfterRowColChange - Naveg. no GrdCons: refresh silencioso
7510:     *--------------------------------------------------------------------------
7511:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
7512:         TRY
7513:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7514:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7515:             ENDIF
7516:         CATCH TO loc_oErro
7517:             *-- silencioso: refresh de navegacao nao deve bloquear
7518:         ENDTRY
7519:     ENDPROC
7520: 
7521:     *--------------------------------------------------------------------------
7522:     * GrdConsCol4KeyPress - F4 abre lookup de Fase (SigCdPrf) para coluna Grupos
7523:     * Legado: Column4.Text1.Valid = fwBuscaInt on crSigCdPrf index GrpOrdem
7524:     *--------------------------------------------------------------------------
7525:     PROCEDURE GrdConsCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7526:         LOCAL loc_oBusca, loc_cAtual, loc_oPg
7527:         IF par_nKeyCode = 115  && F4
7528:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7529:                 RETURN
7530:             ENDIF
7531:             TRY
7532:                 loc_cAtual = ""
7533:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7534:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7535:                 ENDIF
7536:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7537:                     "SigCdPrf", "cursor_4c_BuscaPrf", "Grupos", loc_cAtual, ;
7538:                     "Buscar Fase")
7539:                 IF VARTYPE(loc_oBusca) = "O"
7540:                     IF !loc_oBusca.this_lAchouRegistro
7541:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7542:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7543:                         loc_oBusca.Show()
7544:                     ENDIF
7545:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf")
7546:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7547:                             SELECT cursor_4c_GrdCons
7548:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf.Grupos)
7549:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf.Descrs)
7550:                         ENDIF
7551:                     ENDIF
7552:                     loc_oBusca.Release()
7553:                 ENDIF
7554:                 IF USED("cursor_4c_BuscaPrf")
7555:                     USE IN cursor_4c_BuscaPrf
7556:                 ENDIF
7557:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7558:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7559:                 ENDIF
7560:             CATCH TO loc_oErro
7561:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
7562:             ENDTRY
7563:         ENDIF
7564:     ENDPROC
7565: 
7566:     *--------------------------------------------------------------------------
7567:     * GrdConsCol5KeyPress - F4 abre lookup de Descricao de Fase (SigCdPrf)
7568:     * Legado: Column5.Text1.Valid = fwBuscaInt on crSigCdPrf by Descrs
7569:     *         Apos selecao: Replace Grupos, Ordems, Dopes in crSigPrCpo
7570:     * Habilitado somente quando Column4 (Grupos) estiver vazio
7571:     *--------------------------------------------------------------------------
7572:     PROCEDURE GrdConsCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7573:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos
7574:         IF par_nKeyCode = 115  && F4
7575:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7576:                 RETURN
7577:             ENDIF
7578:             *-- Column5 so editavel quando Column4 (Grupos) esta vazio
7579:             loc_cGrupos = ""
7580:             IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7581:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7582:             ENDIF
7583:             IF !EMPTY(loc_cGrupos)
7584:                 RETURN
7585:             ENDIF
7586:             TRY
7587:                 loc_cAtual = ""
7588:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7589:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Descrs, ""))
7590:                 ENDIF
7591:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7592:                     "SigCdPrf", "cursor_4c_BuscaPrf2", "Descrs", loc_cAtual, ;
7593:                     "Buscar Descri" + CHR(231) + CHR(227) + "o de Fase")
7594:                 IF VARTYPE(loc_oBusca) = "O"
7595:                     IF !loc_oBusca.this_lAchouRegistro
7596:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7597:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7598:                         loc_oBusca.mAddColuna("Ordems", "", "Ord.")
7599:                         loc_oBusca.Show()
7600:                     ENDIF
7601:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf2")
7602:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7603:                             SELECT cursor_4c_GrdCons
7604:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf2.Descrs)
7605:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf2.Grupos)
7606:                             IF TYPE("cursor_4c_BuscaPrf2.Ordems") = "N"
7607:                                 REPLACE Ordems WITH cursor_4c_BuscaPrf2.Ordems
7608:                             ENDIF
7609:                             IF PEMSTATUS(cursor_4c_BuscaPrf2, "Dopes", 5)
7610:                                 REPLACE Dopes WITH ALLTRIM(NVL(cursor_4c_BuscaPrf2.Dopes, ""))
7611:                             ENDIF
7612:                         ENDIF
7613:                     ENDIF
7614:                     loc_oBusca.Release()
7615:                 ENDIF
7616:                 IF USED("cursor_4c_BuscaPrf2")
7617:                     USE IN cursor_4c_BuscaPrf2
7618:                 ENDIF
7619:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7620:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7621:                 ENDIF
7622:             CATCH TO loc_oErro
7623:                 MsgErro(loc_oErro.Message, "Erro ao buscar descri" + CHR(231) + CHR(227) + "o de fase")
7624:             ENDTRY
7625:         ENDIF
7626:     ENDPROC
7627: 
7628:     *--------------------------------------------------------------------------
7629:     * GrdConsCol8KeyPress - F4 abre lookup de Categoria (SigCdCat) para coluna Cods
7630:     * Legado: Column8.Text1.Valid = fwBuscaExt on SigCdCat by Cods
7631:     *         Apos selecao: Column8 = Cods; Column9 (dcats) = Descs
7632:     *--------------------------------------------------------------------------
7633:     PROCEDURE GrdConsCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7634:         LOCAL loc_oBusca, loc_cAtual
7635:         IF par_nKeyCode = 115  && F4
7636:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7637:                 RETURN
7638:             ENDIF
7639:             TRY
7640:                 loc_cAtual = ""
7641:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7642:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Cods, ""))
7643:                 ENDIF
7644:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7645:                     "SigCdCat", "cursor_4c_BuscaCat", "Cods", loc_cAtual, ;
7646:                     "Buscar Categoria")
7647:                 IF VARTYPE(loc_oBusca) = "O"
7648:                     IF !loc_oBusca.this_lAchouRegistro
7649:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
7650:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7651:                         loc_oBusca.Show()
7652:                     ENDIF
7653:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
7654:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7655:                             SELECT cursor_4c_GrdCons
7656:                             REPLACE Cods  WITH ALLTRIM(cursor_4c_BuscaCat.Cods)
7657:                             REPLACE dcats WITH ALLTRIM(cursor_4c_BuscaCat.Descs)
7658:                         ENDIF
7659:                     ENDIF
7660:                     loc_oBusca.Release()
7661:                 ENDIF
7662:                 IF USED("cursor_4c_BuscaCat")
7663:                     USE IN cursor_4c_BuscaCat
7664:                 ENDIF
7665:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7666:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7667:                 ENDIF
7668:             CATCH TO loc_oErro
7669:                 MsgErro(loc_oErro.Message, "Erro ao buscar categoria")
7670:             ENDTRY
7671:         ENDIF
7672:     ENDPROC
7673: 
7674:     *==========================================================================
7675:     * FASE 10 - Aba Custo (pgCusto - Page6 do pgf_4c_Dados)
7676:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto
7677:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7678:     * Controles: cmbTipos, grdCompo(12 cols), cmdgCompo(2 btn),
7679:     *            Say16/Get_Desc, Say2/getDGruCompos, Say3, Shape2, GradeGRUPO2(3 cols)
7680:     *==========================================================================
7681:     PROTECTED PROCEDURE ConfigurarPgpgCusto()
7682:         LOCAL loc_oPg, loc_oGrd
7683: 
7684:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7685: 
7686:         *----------------------------------------------------------------------
7687:         *-- Cursors cursor_4c_Compo e cursor_4c_Grupo sao compartilhados
7688:         *-- com pgComposicao (criados em ConfigurarPgpgComposicao).
7689:         *-- Nao recriar - usar os ja existentes.
7690:         *----------------------------------------------------------------------
7691: 
7692:         *----------------------------------------------------------------------
7693:         *-- Tipo: lbl_4c_Label1 + cbo_4c_CmbTipos
7694:         *-- Say1: "Tipo :" T:159 L:112 W:29
7695:         *-- cmbTipos: T:154 L:143 W:187 H:23
7696:         *----------------------------------------------------------------------
7697:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
7698:         WITH loc_oPg.lbl_4c_Label1
7699:             .Caption   = "Tipo :"
7700:             .Top       = 159
7701:             .Left      = 112
7702:             .Width     = 29
7703:             .Height    = 15
7704:             .FontName  = "Tahoma"
7705:             .FontSize  = 8
7706:             .BackStyle = 0
7707:             .ForeColor = RGB(90, 90, 90)
7708:             .Visible   = .T.
7709:         ENDWITH
7710: 
7711:         loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
7712:         WITH loc_oPg.cbo_4c_CmbTipos
7713:             .Top           = 154
7714:             .Left          = 143
7715:             .Width         = 187
7716:             .Height        = 23
7717:             .FontName      = "Tahoma"
7718:             .FontSize      = 8
7719:             .RowSourceType = 0
7720:             .Value         = ""
7721:             .SpecialEffect = 1
7722:             .Visible       = .T.
7723:         ENDWITH
7724:         BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
7725: 
7726:         *----------------------------------------------------------------------
7727:         *-- Grid grdCompo (12 colunas) - Composicao de custo
7728:         *-- T:178 L:34 W:813 H:230 - usa cursor_4c_Compo (compartilhado)
7729:         *-- Colunas: Item, Descricao, Un, Valor, Qtd, Total, Moe,
7730:         *--          Observacao, Etiq, Consumo, Qtd, Un
7731:         *----------------------------------------------------------------------
7732:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
7733:         WITH loc_oPg.grd_4c_CustoCompo
7734:             .Top               = 178
7735:             .Left              = 34
7736:             .Width             = 813
7737:             .Height            = 230
7738:             .ColumnCount       = 12
7739:             .FontName          = "Verdana"
7740:             .FontSize          = 8
7741:             .GridLines         = 3
7742:             .GridLineWidth     = 1
7743:             .GridLineColor     = RGB(238, 238, 238)
7744:             .RecordMark        = .F.
7745:             .DeleteMark        = .F.
7746:             .AllowRowSizing    = .F.
7747:             .ReadOnly          = .F.
7748:             .BackColor         = RGB(255, 255, 255)
7749:             .ForeColor         = RGB(90, 90, 90)
7750:             .HighlightBackColor = RGB(220, 230, 242)
7751:             .HighlightForeColor = RGB(15, 41, 104)
7752:             .HighlightStyle    = 2
7753:             .RowHeight         = 16
7754:             .ScrollBars        = 2
7755:             .Visible           = .T.
7756:         ENDWITH
7757: 
7758:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7759:         loc_oPg.grd_4c_CustoCompo.RecordSource = "cursor_4c_Compo"
7760: 
7761:         *-- Configurar colunas APOS RecordSource
7762:         WITH loc_oPg.grd_4c_CustoCompo
7763:             *-- Col1: Item/Material (C14) W:80
7764:             .Column1.Header1.Caption   = "Item"

*-- Linhas 7831 a 7928:
7831:             .Column12.ControlSource    = "cursor_4c_Compo.uni2"
7832:             .Column12.ReadOnly         = .T.
7833:         ENDWITH
7834:         BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
7835: 
7836:         *----------------------------------------------------------------------
7837:         *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
7838:         *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
7839:         *----------------------------------------------------------------------
7840:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
7841:         WITH loc_oPg.cnt_4c_BotoesCusto
7842:             .Top         = 240
7843:             .Left        = 851
7844:             .Width       = 50
7845:             .Height      = 90
7846:             .BackStyle = 1
7847:             .BackColor = RGB(53, 53, 53)
7848:             .BorderWidth = 0
7849:             .Visible     = .T.
7850:         ENDWITH
7851: 
7852:         *-- Botao 1: Inserir componente de custo
7853:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_InserirCusto", "CommandButton")
7854:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto
7855:             .Caption       = "+"
7856:             .Top           = 0
7857:             .Left          = 0
7858:             .Width         = 50
7859:             .Height        = 45
7860:             .FontName      = "Tahoma"
7861:             .FontSize      = 10
7862:             .FontBold      = .T.
7863:             .Themes        = .F.
7864:             .SpecialEffect = 0
7865:             .BackColor     = RGB(255, 255, 255)
7866:             .ForeColor     = RGB(0, 128, 0)
7867:             .Visible       = .T.
7868:         ENDWITH
7869:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto, "Click", THIS, "CmdInserirCustoClick")
7870: 
7871:         *-- Botao 2: Excluir componente de custo
7872:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_ExcluirCusto", "CommandButton")
7873:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_ExcluirCusto
7874:             .Caption       = "-"
7875:             .Top           = 45
7876:             .Left          = 0
7877:             .Width         = 50
7878:             .Height        = 45
7879:             .FontName      = "Tahoma"
7880:             .FontSize      = 10
7881:             .FontBold      = .T.
7882:             .Themes        = .F.
7883:             .SpecialEffect = 0
7884:             .BackColor     = RGB(255, 255, 255)
7885:             .ForeColor     = RGB(192, 0, 0)
7886:             .Visible       = .T.
7887:         ENDWITH
7888:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_ExcluirCusto, "Click", THIS, "CmdExcluirCustoClick")
7889: 
7890:         *----------------------------------------------------------------------
7891:         *-- Linha Descricao / Grupo (abaixo do grid e botoes)
7892:         *-- Say16: "Descricao :" T:415 L:52 W:55
7893:         *-- Get_Desc: T:412 L:116 W:304 H:21 - readonly (When=.F.)
7894:         *-- Say2: "Grupo :" T:415 L:479 W:38
7895:         *-- getDGruCompos: T:412 L:522 W:304 H:21 - readonly (When=.F.)
7896:         *----------------------------------------------------------------------
7897:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
7898:         WITH loc_oPg.lbl_4c_Label16
7899:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
7900:             .Top       = 415
7901:             .Left      = 52
7902:             .Width     = 55
7903:             .Height    = 15
7904:             .FontName  = "Tahoma"
7905:             .FontSize  = 8
7906:             .BackStyle = 0
7907:             .ForeColor = RGB(90, 90, 90)
7908:             .Visible   = .T.
7909:         ENDWITH
7910: 
7911:         loc_oPg.AddObject("txt_4c_CustoDesc", "TextBox")
7912:         WITH loc_oPg.txt_4c_CustoDesc
7913:             .Top           = 412
7914:             .Left          = 116
7915:             .Width         = 304
7916:             .Height        = 21
7917:             .FontName      = "Tahoma"
7918:             .FontSize      = 8
7919:             .MaxLength     = 65
7920:             .Value         = ""
7921:             .SpecialEffect = 1
7922:             .Enabled       = .F.
7923:             .Visible       = .T.
7924:         ENDWITH
7925: 
7926:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
7927:         WITH loc_oPg.lbl_4c_Label2
7928:             .Caption   = "Grupo :"

*-- Linhas 8041 a 8216:
8041:     *--------------------------------------------------------------------------
8042:     * GrdCustoAfterRowColChange - Atualiza Descricao e Grupo ao navegar pgCusto
8043:     *--------------------------------------------------------------------------
8044:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
8045:         LOCAL loc_oPg, loc_nRet
8046:         TRY
8047:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8048:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
8049:                 loc_oPg.txt_4c_CustoDesc.Value = ALLTRIM(cursor_4c_Compo.dcomps)
8050:                 *-- Buscar descricao do grupo
8051:                 IF !EMPTY(ALLTRIM(cursor_4c_Compo.cgrus))
8052:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8053:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
8054:                         EscaparSQL(ALLTRIM(cursor_4c_Compo.cgrus)), ;
8055:                         "cursor_4c_TmpGrpCusto")
8056:                     IF loc_nRet >= 1 AND !EOF("cursor_4c_TmpGrpCusto")
8057:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_TmpGrpCusto.DGrus)
8058:                     ELSE
8059:                         loc_oPg.txt_4c_DGruCompos.Value = ""
8060:                     ENDIF
8061:                     IF USED("cursor_4c_TmpGrpCusto")
8062:                         USE IN cursor_4c_TmpGrpCusto
8063:                     ENDIF
8064:                 ELSE
8065:                     loc_oPg.txt_4c_DGruCompos.Value = ""
8066:                 ENDIF
8067:             ENDIF
8068:         CATCH TO loc_oErro
8069:             *-- silencioso: refresh de display nao deve bloquear navegacao
8070:         ENDTRY
8071:     ENDPROC
8072: 
8073:     *--------------------------------------------------------------------------
8074:     * CboTiposCustoInteractiveChange - Filtra composicao pelo tipo selecionado
8075:     *--------------------------------------------------------------------------
8076:     PROCEDURE CboTiposCustoInteractiveChange()
8077:         LOCAL loc_oPg
8078:         TRY
8079:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8080:             IF USED("cursor_4c_Compo")
8081:                 GO TOP IN cursor_4c_Compo
8082:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8083:             ENDIF
8084:         CATCH TO loc_oErro
8085:             MsgErro(loc_oErro.Message, "Erro ao filtrar por tipo")
8086:         ENDTRY
8087:     ENDPROC
8088: 
8089:     *--------------------------------------------------------------------------
8090:     * CmdInserirCustoClick - Insere nova linha de custo no grdCompo (pgCusto)
8091:     *--------------------------------------------------------------------------
8092:     PROCEDURE CmdInserirCustoClick()
8093:         LOCAL loc_oPg, loc_cTipo
8094:         TRY
8095:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8096:                 RETURN
8097:             ENDIF
8098:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8099:             loc_cTipo = ""
8100:             IF VARTYPE(loc_oPg.cbo_4c_CmbTipos) = "O"
8101:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
8102:             ENDIF
8103:             IF USED("cursor_4c_Compo")
8104:                 SELECT cursor_4c_Compo
8105:                 GO TOP IN cursor_4c_Compo
8106:                 LOCATE FOR EMPTY(mats)
8107:                 IF EOF("cursor_4c_Compo")
8108:                     INSERT INTO cursor_4c_Compo (cpros) VALUES ("")
8109:                 ENDIF
8110:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8111:                 IF VARTYPE(loc_oPg.grd_4c_CustoCompo.Column1) = "O"
8112:                     loc_oPg.grd_4c_CustoCompo.Column1.SetFocus()
8113:                 ENDIF
8114:             ENDIF
8115:         CATCH TO loc_oErro
8116:             MsgErro(loc_oErro.Message, "Erro ao inserir linha de custo")
8117:         ENDTRY
8118:     ENDPROC
8119: 
8120:     *--------------------------------------------------------------------------
8121:     * CmdExcluirCustoClick - Remove linha de custo selecionada (pgCusto)
8122:     *--------------------------------------------------------------------------
8123:     PROCEDURE CmdExcluirCustoClick()
8124:         LOCAL loc_oPg
8125:         TRY
8126:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8127:                 RETURN
8128:             ENDIF
8129:             IF USED("cursor_4c_Compo")
8130:                 SELECT cursor_4c_Compo
8131:                 IF !EOF("cursor_4c_Compo")
8132:                     DELETE
8133:                     IF !EOF("cursor_4c_Compo")
8134:                         SKIP
8135:                         SKIP -1
8136:                     ENDIF
8137:                     GO BOTTOM IN cursor_4c_Compo
8138:                 ENDIF
8139:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8140:                 loc_oPg.grd_4c_CustoCompo.SetFocus()
8141:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8142:             ENDIF
8143:         CATCH TO loc_oErro
8144:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8145:         ENDTRY
8146:     ENDPROC
8147: 
8148:     *--------------------------------------------------------------------------
8149:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
8150:     * LISTA/VISUALIZAR: Salvar desabilitado; INCLUIR/ALTERAR: Salvar habilitado
8151:     *--------------------------------------------------------------------------
8152:     PROCEDURE AjustarBotoesPorModo()
8153:         LOCAL loc_oPg2, loc_lEditando
8154:         loc_lEditando = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
8155: 
8156:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
8157:             RETURN
8158:         ENDIF
8159: 
8160:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
8161: 
8162:         IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
8163:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar) = "O"
8164:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEditando
8165:             ENDIF
8166:         ENDIF
8167:     ENDPROC
8168: 
8169:     *==========================================================================
8170:     * FASE 12 - Aba Fases de Producao (PgDadosFaseP - Page4 do pgf_4c_Dados)
8171:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP
8172:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8173:     * Controles: 2 grids (GradFase 5col + grdMatrizes 3col), 8 textboxes,
8174:     *            2 checkboxes, 1 editbox, labels, shapes, images, 8 commandbuttons
8175:     *==========================================================================
8176:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP()
8177:         LOCAL loc_oPg, loc_oGrd
8178:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8179: 
8180:         *----------------------------------------------------------------------
8181:         *-- Cursor placeholder cursor_4c_GradFase (SigCdPrf + SigCdGcr JOIN)
8182:         *-- Campos: Ordems, Grupos (fase code), Descrs (utilizacao), UniPrdts, MatPrdts
8183:         *----------------------------------------------------------------------
8184:         IF !USED("cursor_4c_GradFase")
8185:             SET NULL ON
8186:             CREATE CURSOR cursor_4c_GradFase (;
8187:                 Ordems   N(5,0), ;
8188:                 Grupos   C(10), ;
8189:                 Descrs   C(65), ;
8190:                 UniPrdts C(10), ;
8191:                 MatPrdts C(15), ;
8192:                 Obs      M, ;
8193:                 FigProcs M)
8194:             SET NULL OFF
8195:         ENDIF
8196: 
8197:         *----------------------------------------------------------------------
8198:         *-- Cursor placeholder cursor_4c_SigPrMtz (SigPrMtz + SigCdPro JOIN)
8199:         *-- Campos: CMats (cod matriz), DLocs (local), Qtds (quantidade)
8200:         *----------------------------------------------------------------------
8201:         IF !USED("cursor_4c_SigPrMtz")
8202:             SET NULL ON
8203:             CREATE CURSOR cursor_4c_SigPrMtz (;
8204:                 CMats C(14), ;
8205:                 DLocs C(40), ;
8206:                 Qtds  N(3,0))
8207:             SET NULL OFF
8208:         ENDIF
8209: 
8210:         *----------------------------------------------------------------------
8211:         *-- Shape: shpFig (T:152 L:231 W:244 H:148) - borda imagem de fase
8212:         *----------------------------------------------------------------------
8213:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
8214:         WITH loc_oPg.shp_4c_ShpFig
8215:             .Top         = 152
8216:             .Left        = 231

*-- Linhas 8237 a 8280:
8237:             .Stretch = 2
8238:             .Visible = .F.
8239:         ENDWITH
8240:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
8241: 
8242:         *----------------------------------------------------------------------
8243:         *-- Grid GradFase (T:152 L:527 W:420 H:312) - 5 colunas fases de producao
8244:         *-- Legado: SIGCDPRO.PgDadosFaseP.GradFase (fwgrade)
8245:         *-- Cols: Ordem | Fase | Utilizacao | Uni. Produtiva | Material
8246:         *----------------------------------------------------------------------
8247:         loc_oPg.AddObject("grd_4c_GradFase", "Grid")
8248:         loc_oGrd = loc_oPg.grd_4c_GradFase
8249: 
8250:         WITH loc_oGrd
8251:             .Top                = 152
8252:             .Left               = 527
8253:             .Width              = 420
8254:             .Height             = 312
8255:             .FontName           = "Tahoma"
8256:             .FontSize           = 8
8257:             .ColumnCount        = 5
8258:             .GridLines          = 3
8259:             .GridLineWidth      = 1
8260:             .GridLineColor      = RGB(238, 238, 238)
8261:             .RecordMark         = .F.
8262:             .DeleteMark         = .F.
8263:             .AllowRowSizing     = .F.
8264:             .ReadOnly           = .F.
8265:             .BackColor          = RGB(255, 255, 255)
8266:             .ForeColor          = RGB(90, 90, 90)
8267:             .HighlightBackColor = RGB(220, 230, 242)
8268:             .HighlightForeColor = RGB(15, 41, 104)
8269:             .HighlightStyle     = 2
8270:             .RowHeight          = 16
8271:             .ScrollBars         = 2
8272:             .Themes             = .F.
8273:             .Visible            = .T.
8274:         ENDWITH
8275: 
8276:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8277:         loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8278: 
8279:         *-- Configurar colunas APOS RecordSource
8280:         WITH loc_oPg.grd_4c_GradFase

*-- Linhas 8314 a 8491:
8314:             .Column5.ReadOnly        = .F.
8315:         ENDWITH
8316: 
8317:         *-- BINDEVENT: GradFase
8318:         BINDEVENT(loc_oPg.grd_4c_GradFase, "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
8319:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "GotFocus",  THIS, "GradFaseCol1GotFocus")
8320:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "LostFocus", THIS, "GradFaseCol1LostFocus")
8321:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column2.Text1, "KeyPress",  THIS, "GradFaseCol2KeyPress")
8322:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column4.Text1, "KeyPress",  THIS, "GradFaseCol4KeyPress")
8323:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column5.Text1, "KeyPress",  THIS, "GradFaseCol5KeyPress")
8324: 
8325:         *----------------------------------------------------------------------
8326:         *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
8327:         *-- Legado: inserir.Click - insere nova linha com resequenciamento
8328:         *----------------------------------------------------------------------
8329:         loc_oPg.AddObject("cmd_4c_IncluirFase", "CommandButton")
8330:         WITH loc_oPg.cmd_4c_IncluirFase
8331:             .Caption       = "+"
8332:             .Top           = 152
8333:             .Left          = 950
8334:             .Width         = 38
8335:             .Height        = 38
8336:             .FontName      = "Tahoma"
8337:             .FontSize      = 10
8338:             .FontBold      = .T.
8339:             .Themes        = .F.
8340:             .SpecialEffect = 0
8341:             .BackColor     = RGB(255, 255, 255)
8342:             .ForeColor     = RGB(0, 128, 0)
8343:             .Visible       = .T.
8344:         ENDWITH
8345:         BINDEVENT(loc_oPg.cmd_4c_IncluirFase, "Click", THIS, "CmdIncluirFaseClick")
8346: 
8347:         *----------------------------------------------------------------------
8348:         *-- Botao Excluir Fase (excluir: T:192 L:950 W:38 H:38)
8349:         *-- Legado: excluir.Click - exclui linha corrente e resequencia
8350:         *----------------------------------------------------------------------
8351:         loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
8352:         WITH loc_oPg.cmd_4c_ExcluirFase
8353:             .Caption       = "-"
8354:             .Top           = 192
8355:             .Left          = 950
8356:             .Width         = 38
8357:             .Height        = 38
8358:             .FontName      = "Tahoma"
8359:             .FontSize      = 10
8360:             .FontBold      = .T.
8361:             .Themes        = .F.
8362:             .SpecialEffect = 0
8363:             .BackColor     = RGB(255, 255, 255)
8364:             .ForeColor     = RGB(192, 0, 0)
8365:             .Visible       = .T.
8366:         ENDWITH
8367:         BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "CmdExcluirFaseClick")
8368: 
8369:         *----------------------------------------------------------------------
8370:         *-- Botao Alternativa (Alternativa: T:232 L:950 W:38 H:38)
8371:         *-- Legado: Alternativa.Click - copia linha corrente como alternativa
8372:         *----------------------------------------------------------------------
8373:         loc_oPg.AddObject("cmd_4c_AlternativaFase", "CommandButton")
8374:         WITH loc_oPg.cmd_4c_AlternativaFase
8375:             .Caption       = "A"
8376:             .Top           = 232
8377:             .Left          = 950
8378:             .Width         = 38
8379:             .Height        = 38
8380:             .FontName      = "Tahoma"
8381:             .FontSize      = 9
8382:             .Themes        = .F.
8383:             .SpecialEffect = 0
8384:             .BackColor     = RGB(255, 255, 255)
8385:             .ForeColor     = RGB(90, 90, 90)
8386:             .Visible       = .T.
8387:         ENDWITH
8388:         BINDEVENT(loc_oPg.cmd_4c_AlternativaFase, "Click", THIS, "CmdAlternativaFaseClick")
8389: 
8390:         *----------------------------------------------------------------------
8391:         *-- Botao Ficha Tecnica (CmdFicha: T:152 L:482 W:38 H:38)
8392:         *-- Legado: CmdFicha.Click - gera ficha tecnica com REPORT FORM
8393:         *----------------------------------------------------------------------
8394:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
8395:         WITH loc_oPg.cmd_4c_CmdFicha
8396:             .Caption       = "F"
8397:             .Top           = 152
8398:             .Left          = 482
8399:             .Width         = 38
8400:             .Height        = 38
8401:             .FontName      = "Tahoma"
8402:             .FontSize      = 9
8403:             .Themes        = .F.
8404:             .SpecialEffect = 0
8405:             .BackColor     = RGB(255, 255, 255)
8406:             .ForeColor     = RGB(90, 90, 90)
8407:             .Visible       = .T.
8408:         ENDWITH
8409:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
8410: 
8411:         *----------------------------------------------------------------------
8412:         *-- Botao Selecionar Imagem (cmdgFigura: T:192 L:482 W:40 H:40)
8413:         *-- Legado: cmdgFigura.Click - abre seletor GetPict JPG/BMP
8414:         *----------------------------------------------------------------------
8415:         loc_oPg.AddObject("cmd_4c_CmdgFigura", "CommandButton")
8416:         WITH loc_oPg.cmd_4c_CmdgFigura
8417:             .Caption       = "I"
8418:             .Top           = 192
8419:             .Left          = 482
8420:             .Width         = 40
8421:             .Height        = 40
8422:             .FontName      = "Tahoma"
8423:             .FontSize      = 9
8424:             .Themes        = .F.
8425:             .SpecialEffect = 0
8426:             .BackColor     = RGB(255, 255, 255)
8427:             .ForeColor     = RGB(90, 90, 90)
8428:             .Visible       = .T.
8429:         ENDWITH
8430:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
8431: 
8432:         *----------------------------------------------------------------------
8433:         *-- Botao Capturar Webcam (cmdgFigCam: T:232 L:482 W:40 H:40)
8434:         *-- Legado: cmdgFigCam.Click - captura imagem via SigImage form
8435:         *----------------------------------------------------------------------
8436:         loc_oPg.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
8437:         WITH loc_oPg.cmd_4c_CmdgFigCam
8438:             .Caption       = "C"
8439:             .Top           = 232
8440:             .Left          = 482
8441:             .Width         = 40
8442:             .Height        = 40
8443:             .FontName      = "Tahoma"
8444:             .FontSize      = 9
8445:             .Themes        = .F.
8446:             .SpecialEffect = 0
8447:             .BackColor     = RGB(255, 255, 255)
8448:             .ForeColor     = RGB(90, 90, 90)
8449:             .Visible       = .T.
8450:         ENDWITH
8451:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
8452: 
8453:         *----------------------------------------------------------------------
8454:         *-- Label Say1: "Descricao :" (T:474 L:527 W:67 H:17)
8455:         *----------------------------------------------------------------------
8456:         loc_oPg.AddObject("lbl_4c_Label1FP", "Label")
8457:         WITH loc_oPg.lbl_4c_Label1FP
8458:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
8459:             .Top       = 474
8460:             .Left      = 527
8461:             .Width     = 67
8462:             .Height    = 17
8463:             .FontName  = "Tahoma"
8464:             .FontSize  = 8
8465:             .BackStyle = 0
8466:             .ForeColor = RGB(90, 90, 90)
8467:             .Visible   = .T.
8468:         ENDWITH
8469: 
8470:         *----------------------------------------------------------------------
8471:         *-- TextBox Get_Desc (T:471 L:595 W:395 H:23) - descricao da fase
8472:         *-- Readonly - preenchido pelo GradFaseAfterRowColChange (campo Descrs)
8473:         *----------------------------------------------------------------------
8474:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
8475:         WITH loc_oPg.txt_4c_Desc
8476:             .Top           = 471
8477:             .Left          = 595
8478:             .Width         = 395
8479:             .Height        = 23
8480:             .Value         = ""
8481:             .FontName      = "Tahoma"
8482:             .FontSize      = 8
8483:             .ReadOnly      = .T.
8484:             .SpecialEffect = 1
8485:             .ForeColor     = RGB(36, 84, 155)
8486:             .BackColor     = RGB(240, 240, 240)
8487:             .Visible       = .T.
8488:         ENDWITH
8489: 
8490:         *----------------------------------------------------------------------
8491:         *-- EditBox Get_Obs (T:497 L:527 W:463 H:122) - observacoes da fase

*-- Linhas 8609 a 8652:
8609:             .Enabled       = .F.
8610:             .Visible       = .T.
8611:         ENDWITH
8612:         BINDEVENT(loc_oPg.txt_4c_Conquilha, "LostFocus", THIS, "TxtConquilhaLostFocus")
8613: 
8614:         *-- Label Say9: "Peso Brilhante :" (T:231 L:58 W:77 H:15)
8615:         loc_oPg.AddObject("lbl_4c_Label9FP", "Label")
8616:         WITH loc_oPg.lbl_4c_Label9FP
8617:             .Caption   = "Peso Brilhante :"
8618:             .Top       = 231
8619:             .Left      = 58
8620:             .Width     = 77
8621:             .Height    = 15
8622:             .FontName  = "Tahoma"
8623:             .FontSize  = 8
8624:             .BackStyle = 0
8625:             .ForeColor = RGB(90, 90, 90)
8626:             .Visible   = .T.
8627:         ENDWITH
8628: 
8629:         *-- TextBox getPesoBris (T:227 L:137 W:80 H:23)
8630:         *-- Legado: pesobris de SigCdPro
8631:         loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
8632:         WITH loc_oPg.txt_4c_PesoBris
8633:             .Top           = 227
8634:             .Left          = 137
8635:             .Width         = 80
8636:             .Height        = 23
8637:             .Value         = 0
8638:             .FontName      = "Tahoma"
8639:             .FontSize      = 8
8640:             .SpecialEffect = 1
8641:             .ForeColor     = RGB(36, 84, 155)
8642:             .Enabled       = .F.
8643:             .Visible       = .T.
8644:         ENDWITH
8645: 
8646:         *-- Label Say10: "Peso Metal :" (T:256 L:74 W:61 H:15)
8647:         loc_oPg.AddObject("lbl_4c_Label10FP", "Label")
8648:         WITH loc_oPg.lbl_4c_Label10FP
8649:             .Caption   = "Peso Metal :"
8650:             .Top       = 256
8651:             .Left      = 74
8652:             .Width     = 61

*-- Linhas 8738 a 8781:
8738:             .Enabled       = .F.
8739:             .Visible       = .T.
8740:         ENDWITH
8741:         BINDEVENT(loc_oPg.txt_4c_Cor, "LostFocus", THIS, "TxtCorLostFocus")
8742: 
8743:         *-- CheckBox opc_CravCera: "Cravacao em Cera" (T:306 L:180 W:120 H:15)
8744:         *-- Legado: cravcers de SigCdPro (numeric 1,0 com semantica booleana)
8745:         loc_oPg.AddObject("chk_4c_Opc_CravCera", "CheckBox")
8746:         WITH loc_oPg.chk_4c_Opc_CravCera
8747:             .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera"
8748:             .Top       = 306
8749:             .Left      = 180
8750:             .Width     = 120
8751:             .Height    = 15
8752:             .Value     = 0
8753:             .FontName  = "Tahoma"
8754:             .FontSize  = 8
8755:             .BackStyle = 0
8756:             .Themes    = .F.
8757:             .Enabled   = .F.
8758:             .Visible   = .T.
8759:         ENDWITH
8760: 
8761:         *-- Label Say2: "Tamanho Padrao :" (T:331 L:45 W:90 H:15)
8762:         loc_oPg.AddObject("lbl_4c_Label2FP", "Label")
8763:         WITH loc_oPg.lbl_4c_Label2FP
8764:             .Caption   = "Tamanho Padr" + CHR(227) + "o :"
8765:             .Top       = 331
8766:             .Left      = 45
8767:             .Width     = 90
8768:             .Height    = 15
8769:             .FontName  = "Tahoma"
8770:             .FontSize  = 8
8771:             .BackStyle = 0
8772:             .ForeColor = RGB(90, 90, 90)
8773:             .Visible   = .T.
8774:         ENDWITH
8775: 
8776:         *-- TextBox getTam: tamanho padrao (T:327 L:137 W:38 H:23)
8777:         *-- Legado: codtams de SigCdPro - LostFocus lookup SigCdTam
8778:         loc_oPg.AddObject("txt_4c_Tam", "TextBox")
8779:         WITH loc_oPg.txt_4c_Tam
8780:             .Top           = 327
8781:             .Left          = 137

*-- Linhas 8789 a 8832:
8789:             .Enabled       = .F.
8790:             .Visible       = .T.
8791:         ENDWITH
8792:         BINDEVENT(loc_oPg.txt_4c_Tam, "LostFocus", THIS, "TxtTamLostFocus")
8793: 
8794:         *-- CheckBox fwoption1: "Peso Variavel" (T:331 L:180 W:90 H:15)
8795:         *-- Legado: prodvars de SigCdPro (numeric 1,0 com semantica booleana)
8796:         loc_oPg.AddObject("chk_4c_Fwoption1", "CheckBox")
8797:         WITH loc_oPg.chk_4c_Fwoption1
8798:             .Caption   = "Peso Vari" + CHR(225) + "vel"
8799:             .Top       = 331
8800:             .Left      = 180
8801:             .Width     = 90
8802:             .Height    = 15
8803:             .Value     = 0
8804:             .FontName  = "Tahoma"
8805:             .FontSize  = 8
8806:             .BackStyle = 0
8807:             .Themes    = .F.
8808:             .Enabled   = .F.
8809:             .Visible   = .T.
8810:         ENDWITH
8811: 
8812:         *-- Label lblAcabamento: "Acabamento :" (T:356 L:16 W:119 H:15)
8813:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
8814:         WITH loc_oPg.lbl_4c_LblAcabamento
8815:             .Caption   = "Acabamento :"
8816:             .Top       = 356
8817:             .Left      = 16
8818:             .Width     = 119
8819:             .Height    = 15
8820:             .FontName  = "Tahoma"
8821:             .FontSize  = 8
8822:             .BackStyle = 0
8823:             .ForeColor = RGB(90, 90, 90)
8824:             .Visible   = .T.
8825:         ENDWITH
8826: 
8827:         *-- TextBox get_codacb: codigo acabamento (T:352 L:137 W:38 H:23)
8828:         *-- Legado: codacbs de SigCdPro - LostFocus lookup SigCdAca
8829:         loc_oPg.AddObject("txt_4c__codacb", "TextBox")
8830:         WITH loc_oPg.txt_4c__codacb
8831:             .Top           = 352
8832:             .Left          = 137

*-- Linhas 8840 a 8883:
8840:             .Enabled       = .F.
8841:             .Visible       = .T.
8842:         ENDWITH
8843:         BINDEVENT(loc_oPg.txt_4c__codacb, "LostFocus", THIS, "TxtCodacbLostFocus")
8844: 
8845:         *-- TextBox get_Dacb: descricao acabamento (T:352 L:177 W:207 H:23)
8846:         *-- Legado: When=.F. (readonly sempre) - preenchido pelo lookup de get_codacb
8847:         loc_oPg.AddObject("txt_4c__Dacb", "TextBox")
8848:         WITH loc_oPg.txt_4c__Dacb
8849:             .Top           = 352
8850:             .Left          = 177
8851:             .Width         = 207
8852:             .Height        = 23
8853:             .Value         = ""
8854:             .FontName      = "Tahoma"
8855:             .FontSize      = 8
8856:             .ReadOnly      = .T.
8857:             .SpecialEffect = 1
8858:             .ForeColor     = RGB(36, 84, 155)
8859:             .BackColor     = RGB(240, 240, 240)
8860:             .Enabled       = .F.
8861:             .Visible       = .T.
8862:         ENDWITH
8863: 
8864:         *----------------------------------------------------------------------
8865:         *-- Secao inferior esquerda: grdMatrizes + botoes + imagem borracha
8866:         *----------------------------------------------------------------------
8867: 
8868:         *-- Grid grdMatrizes (T:380 L:7 W:246 H:240) - 3 colunas: Matriz|Local|Qtde
8869:         *-- Legado: grdMatrizes com crSigPrMtz (matrizes do produto)
8870:         loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
8871:         loc_oGrd = loc_oPg.grd_4c_Matrizes
8872: 
8873:         WITH loc_oGrd
8874:             .Top                = 380
8875:             .Left               = 7
8876:             .Width              = 246
8877:             .Height             = 240
8878:             .FontName           = "Tahoma"
8879:             .FontSize           = 8
8880:             .ColumnCount        = 3
8881:             .GridLines          = 3
8882:             .GridLineWidth      = 1
8883:             .GridLineColor      = RGB(238, 238, 238)

*-- Linhas 8923 a 9050:
8923:             .Column3.ReadOnly        = .F.
8924:         ENDWITH
8925: 
8926:         *-- BINDEVENT: grdMatrizes
8927:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8928:         BINDEVENT(loc_oPg.grd_4c_Matrizes.Column1.Text1, "KeyPress", THIS, "GrdMatrizesCol1KeyPress")
8929: 
8930:         *----------------------------------------------------------------------
8931:         *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
8932:         *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
8933:         *----------------------------------------------------------------------
8934:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
8935:         WITH loc_oPg.cmd_4c_BtnInsereMtx
8936:             .Caption       = "+"
8937:             .Top           = 380
8938:             .Left          = 258
8939:             .Width         = 38
8940:             .Height        = 38
8941:             .FontName      = "Tahoma"
8942:             .FontSize      = 10
8943:             .FontBold      = .T.
8944:             .Themes        = .F.
8945:             .SpecialEffect = 0
8946:             .BackColor     = RGB(255, 255, 255)
8947:             .ForeColor     = RGB(0, 128, 0)
8948:             .Visible       = .T.
8949:         ENDWITH
8950:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInsereMtxClick")
8951: 
8952:         *----------------------------------------------------------------------
8953:         *-- Botao Excluir Matriz (btnExcluiMtz: T:420 L:258 W:38 H:38)
8954:         *-- Legado: btnExcluiMtz.Click - exclui linha de crSigPrMtz
8955:         *----------------------------------------------------------------------
8956:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
8957:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
8958:             .Caption       = "-"
8959:             .Top           = 420
8960:             .Left          = 258
8961:             .Width         = 38
8962:             .Height        = 38
8963:             .FontName      = "Tahoma"
8964:             .FontSize      = 10
8965:             .FontBold      = .T.
8966:             .Themes        = .F.
8967:             .SpecialEffect = 0
8968:             .BackColor     = RGB(255, 255, 255)
8969:             .ForeColor     = RGB(192, 0, 0)
8970:             .Visible       = .T.
8971:         ENDWITH
8972:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluiMtzClick")
8973: 
8974:         *----------------------------------------------------------------------
8975:         *-- Shape: shpBorracha (T:464 L:258 W:236 H:156) - borda imagem borracha
8976:         *----------------------------------------------------------------------
8977:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
8978:         WITH loc_oPg.shp_4c_ShpBorracha
8979:             .Top         = 464
8980:             .Left        = 258
8981:             .Width       = 236
8982:             .Height      = 156
8983:             .BackStyle   = 1
8984:             .BackColor   = RGB(255, 255, 255)
8985:             .BorderColor = RGB(192, 192, 192)
8986:             .BorderWidth = 1
8987:             .Visible     = .T.
8988:         ENDWITH
8989: 
8990:         *----------------------------------------------------------------------
8991:         *-- Image: ImgBorracha (T:465 L:260 W:232 H:154) - imagem borracha da matriz
8992:         *-- Legado: GrdMatrizes.AfterRowColChange carrega SigCdPro da matriz corrente
8993:         *----------------------------------------------------------------------
8994:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
8995:         WITH loc_oPg.img_4c_ImgBorracha
8996:             .Top     = 465
8997:             .Left    = 260
8998:             .Width   = 232
8999:             .Height  = 154
9000:             .Picture = ""
9001:             .Stretch = 2
9002:             .Visible = .F.
9003:         ENDWITH
9004:     ENDPROC
9005: 
9006:     *--------------------------------------------------------------------------
9007:     * PreencherCamposFaseP - Popula controles da aba FaseP a partir do BO
9008:     * Chamado por BOParaForm apos carregar dados de SigCdPro
9009:     *--------------------------------------------------------------------------
9010:     PROTECTED PROCEDURE PreencherCamposFaseP()
9011:         LOCAL loc_oPg
9012:         TRY
9013:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9014:                 RETURN
9015:             ENDIF
9016:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9017:             IF VARTYPE(loc_oPg) # "O"
9018:                 RETURN
9019:             ENDIF
9020:             WITH THIS.this_oBusinessObject
9021:                 IF VARTYPE(loc_oPg.txt_4c_Qmin) = "O"
9022:                     loc_oPg.txt_4c_Qmin.Value = IIF(.this_nQmins = 0, 0, .this_nQmins)
9023:                 ENDIF
9024:                 IF VARTYPE(loc_oPg.txt_4c_CodGarras) = "O"
9025:                     loc_oPg.txt_4c_CodGarras.Value = ALLTRIM(.this_cCodgarras)
9026:                 ENDIF
9027:                 IF VARTYPE(loc_oPg.txt_4c_Conquilha) = "O"
9028:                     loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(.this_cConquilhas)
9029:                 ENDIF
9030:                 IF VARTYPE(loc_oPg.txt_4c_PesoBris) = "O"
9031:                     loc_oPg.txt_4c_PesoBris.Value = .this_nPesobris
9032:                 ENDIF
9033:                 IF VARTYPE(loc_oPg.txt_4c_PesoMetal) = "O"
9034:                     loc_oPg.txt_4c_PesoMetal.Value = .this_nPesometal
9035:                 ENDIF
9036:                 IF VARTYPE(loc_oPg.txt_4c_PesoPdrs) = "O"
9037:                     loc_oPg.txt_4c_PesoPdrs.Value = .this_nPesopdrs
9038:                 ENDIF
9039:                 IF VARTYPE(loc_oPg.txt_4c_Cor) = "O"
9040:                     loc_oPg.txt_4c_Cor.Value = ALLTRIM(.this_cCodcors)
9041:                 ENDIF
9042:                 IF VARTYPE(loc_oPg.txt_4c_Tam) = "O"
9043:                     loc_oPg.txt_4c_Tam.Value = ALLTRIM(.this_cCodtams)
9044:                 ENDIF
9045:                 IF VARTYPE(loc_oPg.txt_4c__codacb) = "O"
9046:                     loc_oPg.txt_4c__codacb.Value = ALLTRIM(.this_cCodacbs)
9047:                 ENDIF
9048:                 IF VARTYPE(loc_oPg.txt_4c__Dacb) = "O"
9049:                     loc_oPg.txt_4c__Dacb.Value = ""
9050:                 ENDIF

*-- Linhas 9064 a 9107:
9064:     * LerCamposFaseP - Le controles da aba FaseP e transfere para o BO
9065:     * Chamado por FormParaBO antes de salvar
9066:     *--------------------------------------------------------------------------
9067:     PROTECTED PROCEDURE LerCamposFaseP()
9068:         LOCAL loc_oPg
9069:         TRY
9070:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9071:                 RETURN
9072:             ENDIF
9073:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9074:             IF VARTYPE(loc_oPg) # "O"
9075:                 RETURN
9076:             ENDIF
9077:             WITH THIS.this_oBusinessObject
9078:                 IF VARTYPE(loc_oPg.txt_4c_Qmin) = "O"
9079:                     .this_nQmins = loc_oPg.txt_4c_Qmin.Value
9080:                 ENDIF
9081:                 IF VARTYPE(loc_oPg.txt_4c_Conquilha) = "O"
9082:                     .this_cConquilhas = ALLTRIM(loc_oPg.txt_4c_Conquilha.Value)
9083:                 ENDIF
9084:                 IF VARTYPE(loc_oPg.txt_4c_PesoBris) = "O"
9085:                     .this_nPesobris = loc_oPg.txt_4c_PesoBris.Value
9086:                 ENDIF
9087:                 IF VARTYPE(loc_oPg.txt_4c_PesoMetal) = "O"
9088:                     .this_nPesometal = loc_oPg.txt_4c_PesoMetal.Value
9089:                 ENDIF
9090:                 IF VARTYPE(loc_oPg.txt_4c_PesoPdrs) = "O"
9091:                     .this_nPesopdrs = loc_oPg.txt_4c_PesoPdrs.Value
9092:                 ENDIF
9093:                 IF VARTYPE(loc_oPg.txt_4c_Cor) = "O"
9094:                     .this_cCodcors = ALLTRIM(loc_oPg.txt_4c_Cor.Value)
9095:                 ENDIF
9096:                 IF VARTYPE(loc_oPg.txt_4c_Tam) = "O"
9097:                     .this_cCodtams = ALLTRIM(loc_oPg.txt_4c_Tam.Value)
9098:                 ENDIF
9099:                 IF VARTYPE(loc_oPg.txt_4c__codacb) = "O"
9100:                     .this_cCodacbs = ALLTRIM(loc_oPg.txt_4c__codacb.Value)
9101:                 ENDIF
9102:                 IF VARTYPE(loc_oPg.chk_4c_Opc_CravCera) = "O"
9103:                     .this_lCravcers = (loc_oPg.chk_4c_Opc_CravCera.Value = 1)
9104:                 ENDIF
9105:                 IF VARTYPE(loc_oPg.chk_4c_Fwoption1) = "O"
9106:                     .this_nProdvars = IIF(loc_oPg.chk_4c_Fwoption1.Value = 1, 1, 0)
9107:                 ENDIF

*-- Linhas 9113 a 9158:
9113: 
9114:     *--------------------------------------------------------------------------
9115:     * GradFaseAfterRowColChange - Atualiza imagem e descricao ao navegar GradFase
9116:     * Legado: GradFase.AfterRowColChange (Procedure) - carrega FigProcs, Get_Desc, Get_Obs
9117:     *--------------------------------------------------------------------------
9118:     PROCEDURE GradFaseAfterRowColChange(par_nColIndex)
9119:         LOCAL loc_oPg, loc_lcArquivo
9120:         TRY
9121:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9122:                 RETURN
9123:             ENDIF
9124:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9125:             IF VARTYPE(loc_oPg) # "O"
9126:                 RETURN
9127:             ENDIF
9128: 
9129:             *-- Atualizar descricao da fase (campo Descrs do cursor)
9130:             IF VARTYPE(loc_oPg.txt_4c_Desc) = "O"
9131:                 loc_oPg.txt_4c_Desc.Value = ""
9132:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9133:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(NVL(cursor_4c_GradFase.Descrs, ""))
9134:                 ENDIF
9135:             ENDIF
9136: 
9137:             *-- Atualizar observacoes da fase (campo Obs de crSigCdPrf se disponivel)
9138:             IF VARTYPE(loc_oPg.obj_4c_Get_Obs) = "O"
9139:                 loc_oPg.obj_4c_Get_Obs.Value = ""
9140:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9141:                     IF TYPE("cursor_4c_GradFase.Obs") # "U"
9142:                         loc_oPg.obj_4c_Get_Obs.Value = NVL(cursor_4c_GradFase.Obs, "")
9143:                     ENDIF
9144:                 ENDIF
9145:             ENDIF
9146: 
9147:             *-- Atualizar imagem da fase (campo FigProcs de crSigCdPrf se disponivel)
9148:             IF VARTYPE(loc_oPg.img_4c_ImgFigJpg) = "O"
9149:                 CLEAR RESOURCES
9150:                 loc_oPg.img_4c_ImgFigJpg.Picture = ""
9151:                 loc_oPg.img_4c_ImgFigJpg.Visible = .F.
9152:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9153:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9154:                         IF !EMPTY(NVL(cursor_4c_GradFase.FigProcs, ""))
9155:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9156:                             IF STRTOFILE(cursor_4c_GradFase.FigProcs, loc_lcArquivo) > 0
9157:                                 loc_oPg.img_4c_ImgFigJpg.Picture  = loc_lcArquivo
9158:                                 loc_oPg.img_4c_ImgFigJpg.Visible  = .T.

*-- Linhas 9172 a 9420:
9172:     * GradFaseCol1GotFocus - Salva valor atual de Ordem antes de editar
9173:     * Legado: GradFase.Column1.Text1.GotFocus = "ThisForm.AntOrd = This.Value"
9174:     *--------------------------------------------------------------------------
9175:     PROCEDURE GradFaseCol1GotFocus()
9176:         TRY
9177:             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9178:                 THIS.this_nAntOrdFase = cursor_4c_GradFase.Ordems
9179:             ENDIF
9180:         CATCH TO loc_oErro
9181:             MsgErro(loc_oErro.Message, "Erro ao registrar ordem anterior")
9182:         ENDTRY
9183:     ENDPROC
9184: 
9185:     *--------------------------------------------------------------------------
9186:     * GradFaseCol1LostFocus - Resequencia fases se ordem foi alterada
9187:     * Legado: GradFase.Column1.Text1.LostFocus - reordena SCAN por Ordem2
9188:     *--------------------------------------------------------------------------
9189:     PROCEDURE GradFaseCol1LostFocus()
9190:         LOCAL loc_lResultado, loc_nPonteiro, loc_nNovaOrdem, loc_nOrdem2
9191:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9192:             RETURN
9193:         ENDIF
9194:         loc_lResultado = .T.
9195:         TRY
9196:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
9197:                 loc_lResultado = .F.
9198:             ENDIF
9199:             IF loc_lResultado
9200:                 loc_nNovaOrdem = cursor_4c_GradFase.Ordems
9201:                 IF loc_nNovaOrdem <= 0 OR loc_nNovaOrdem = THIS.this_nAntOrdFase
9202:                     loc_lResultado = .F.
9203:                 ENDIF
9204:             ENDIF
9205:             IF loc_lResultado
9206:                 *-- Calcular Ordem2 para resequenciamento
9207:                 loc_nPonteiro = RECNO("cursor_4c_GradFase")
9208:                 SELECT cursor_4c_GradFase
9209:                 SCAN
9210:                     IF RECNO() # loc_nPonteiro
9211:                         REPLACE Ordems WITH cursor_4c_GradFase.Ordems IN cursor_4c_GradFase
9212:                     ENDIF
9213:                 ENDSCAN
9214:                 GO loc_nPonteiro IN cursor_4c_GradFase
9215:                 SELECT cursor_4c_GradFase
9216:                 *-- Reordenar por Ordems para refletir nova sequencia
9217:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9218:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9219:                 ENDIF
9220:             ENDIF
9221:         CATCH TO loc_oErro
9222:             MsgErro(loc_oErro.Message, "Erro ao resequenciar fases")
9223:         ENDTRY
9224:     ENDPROC
9225: 
9226:     *--------------------------------------------------------------------------
9227:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr) para coluna Grupos
9228:     * Legado: Column2.Text1.Valid = fwBuscaExt on SigCdGcr by Codigos
9229:     *         Apos selecao: preenche Grupos e Descrs no cursor
9230:     *--------------------------------------------------------------------------
9231:     PROCEDURE GradFaseCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9232:         LOCAL loc_oBusca, loc_cAtual
9233:         IF par_nKeyCode = 115  && F4
9234:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9235:                 RETURN
9236:             ENDIF
9237:             TRY
9238:                 loc_cAtual = ""
9239:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9240:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9241:                 ENDIF
9242:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9243:                     "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cAtual, ;
9244:                     "Buscar Fase de Produ" + CHR(231) + CHR(227) + "o")
9245:                 IF VARTYPE(loc_oBusca) = "O"
9246:                     IF !loc_oBusca.this_lAchouRegistro
9247:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
9248:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
9249:                         loc_oBusca.Show()
9250:                     ENDIF
9251:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
9252:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9253:                             SELECT cursor_4c_GradFase
9254:                             REPLACE Grupos WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Codigos, ""))
9255:                             REPLACE Descrs WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Descrs,  ""))
9256:                         ENDIF
9257:                     ENDIF
9258:                     loc_oBusca.Release()
9259:                 ENDIF
9260:                 IF USED("cursor_4c_BuscaGcr")
9261:                     USE IN cursor_4c_BuscaGcr
9262:                 ENDIF
9263:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9264:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9265:                 ENDIF
9266:             CATCH TO loc_oErro
9267:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
9268:             ENDTRY
9269:         ENDIF
9270:     ENDPROC
9271: 
9272:     *--------------------------------------------------------------------------
9273:     * GradFaseCol4KeyPress - F4 abre lookup de Unidade Produtiva (SigCdUpd)
9274:     * Legado: Column4.Text1.Valid = fwBuscaInt on SigCdUpd filtered by Grupos
9275:     *         Apos selecao: preenche UniPrdts no cursor
9276:     *--------------------------------------------------------------------------
9277:     PROCEDURE GradFaseCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9278:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos, loc_cSQL, loc_nRet
9279:         IF par_nKeyCode = 115  && F4
9280:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9281:                 RETURN
9282:             ENDIF
9283:             TRY
9284:                 loc_cAtual  = ""
9285:                 loc_cGrupos = ""
9286:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9287:                     loc_cAtual  = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9288:                     loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9289:                 ENDIF
9290:                 *-- Busca unidades produtivas filtradas pelo grupo da fase corrente
9291:                 IF !EMPTY(loc_cGrupos)
9292:                     loc_cSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupos)
9293:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9294:                 ELSE
9295:                     loc_cSQL = "SELECT DISTINCT UniPrdts FROM SigCdUpd"
9296:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9297:                 ENDIF
9298:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaUpd")
9299:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9300:                         "SigCdUpd", "cursor_4c_BuscaUpd2", "UniPrdts", loc_cAtual, ;
9301:                         "Buscar Uni. Produtiva")
9302:                     IF VARTYPE(loc_oBusca) = "O"
9303:                         IF !loc_oBusca.this_lAchouRegistro
9304:                             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
9305:                             loc_oBusca.Show()
9306:                         ENDIF
9307:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd2")
9308:                             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9309:                                 SELECT cursor_4c_GradFase
9310:                                 REPLACE UniPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaUpd2.UniPrdts, ""))
9311:                             ENDIF
9312:                         ENDIF
9313:                         loc_oBusca.Release()
9314:                     ENDIF
9315:                     IF USED("cursor_4c_BuscaUpd2")
9316:                         USE IN cursor_4c_BuscaUpd2
9317:                     ENDIF
9318:                 ENDIF
9319:                 IF USED("cursor_4c_BuscaUpd")
9320:                     USE IN cursor_4c_BuscaUpd
9321:                 ENDIF
9322:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9323:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9324:                 ENDIF
9325:             CATCH TO loc_oErro
9326:                 MsgErro(loc_oErro.Message, "Erro ao buscar Uni. Produtiva")
9327:             ENDTRY
9328:         ENDIF
9329:     ENDPROC
9330: 
9331:     *--------------------------------------------------------------------------
9332:     * GradFaseCol5KeyPress - F4 abre lookup de Material (SigOpOpt) para coluna MatPrdts
9333:     * Legado: Column5.Text1.Valid = fwBuscaExt on SigOpOpt by Cods
9334:     *         Apos selecao: preenche MatPrdts no cursor
9335:     *--------------------------------------------------------------------------
9336:     PROCEDURE GradFaseCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9337:         LOCAL loc_oBusca, loc_cAtual
9338:         IF par_nKeyCode = 115  && F4
9339:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9340:                 RETURN
9341:             ENDIF
9342:             TRY
9343:                 loc_cAtual = ""
9344:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9345:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9346:                 ENDIF
9347:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9348:                     "SigOpOpt", "cursor_4c_BuscaOpt", "Cods", loc_cAtual, ;
9349:                     "Buscar Tipo de Material")
9350:                 IF VARTYPE(loc_oBusca) = "O"
9351:                     IF !loc_oBusca.this_lAchouRegistro
9352:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9353:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9354:                         loc_oBusca.Show()
9355:                     ENDIF
9356:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
9357:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9358:                             SELECT cursor_4c_GradFase
9359:                             REPLACE MatPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaOpt.Cods, ""))
9360:                         ENDIF
9361:                     ENDIF
9362:                     loc_oBusca.Release()
9363:                 ENDIF
9364:                 IF USED("cursor_4c_BuscaOpt")
9365:                     USE IN cursor_4c_BuscaOpt
9366:                 ENDIF
9367:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9368:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9369:                 ENDIF
9370:             CATCH TO loc_oErro
9371:                 MsgErro(loc_oErro.Message, "Erro ao buscar material")
9372:             ENDTRY
9373:         ENDIF
9374:     ENDPROC
9375: 
9376:     *--------------------------------------------------------------------------
9377:     * GrdMatrizesAfterRowColChange - Carrega imagem da borracha da matriz selecionada
9378:     * Legado: grdMatrizes.Procedure(AfterRowColChange) - query SigCdPro e mostra FigJpgs
9379:     *--------------------------------------------------------------------------
9380:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
9381:         LOCAL loc_oPg, loc_lcArquivo, loc_cSQL, loc_nRet
9382:         TRY
9383:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9384:                 RETURN
9385:             ENDIF
9386:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9387:             IF VARTYPE(loc_oPg) # "O"
9388:                 RETURN
9389:             ENDIF
9390: 
9391:             *-- Limpar imagem anterior
9392:             CLEAR RESOURCES
9393:             loc_oPg.img_4c_ImgBorracha.Picture = ""
9394:             loc_oPg.img_4c_ImgBorracha.Visible = .F.
9395: 
9396:             *-- Carregar imagem da borracha do produto-matriz corrente
9397:             IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9398:                 IF !EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9399:                     loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
9400:                                EscaparSQL(ALLTRIM(cursor_4c_SigPrMtz.CMats))
9401:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalImgPro")
9402:                     IF loc_nRet > 0 AND USED("cursor_4c_LocalImgPro")
9403:                         GO TOP IN cursor_4c_LocalImgPro
9404:                         IF !EOF("cursor_4c_LocalImgPro")
9405:                             IF TYPE("cursor_4c_LocalImgPro.FigJpgs") # "U"
9406:                                 IF !EMPTY(NVL(cursor_4c_LocalImgPro.FigJpgs, ""))
9407:                                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_bor.jpg"
9408:                                     IF STRTOFILE(cursor_4c_LocalImgPro.FigJpgs, loc_lcArquivo) > 0
9409:                                         loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9410:                                         loc_oPg.img_4c_ImgBorracha.Visible = .T.
9411:                                     ENDIF
9412:                                 ENDIF
9413:                             ENDIF
9414:                         ENDIF
9415:                         USE IN cursor_4c_LocalImgPro
9416:                     ENDIF
9417:                 ENDIF
9418:             ENDIF
9419: 
9420:             loc_oPg.grd_4c_Matrizes.Refresh()

*-- Linhas 9428 a 10104:
9428:     * Legado: grdMatrizes.Column1.Text1.Valid = fwBuscaInt on crMatrizes by CPros
9429:     *         Apos selecao: preenche CMats e DLocs no cursor_4c_SigPrMtz
9430:     *--------------------------------------------------------------------------
9431:     PROCEDURE GrdMatrizesCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9432:         LOCAL loc_oBusca, loc_cAtual
9433:         IF par_nKeyCode = 115  && F4
9434:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9435:                 RETURN
9436:             ENDIF
9437:             TRY
9438:                 loc_cAtual = ""
9439:                 IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9440:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, ""))
9441:                 ENDIF
9442:                 *-- Busca na tabela SigCdPro (produtos que sao matrizes)
9443:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9444:                     "SigCdPro", "cursor_4c_BuscaMatriz", "CPros", loc_cAtual, ;
9445:                     "Buscar Matriz")
9446:                 IF VARTYPE(loc_oBusca) = "O"
9447:                     IF !loc_oBusca.this_lAchouRegistro
9448:                         loc_oBusca.mAddColuna("CPros",  "", "Matriz")
9449:                         loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
9450:                         loc_oBusca.mAddColuna("Locals", "", "Local")
9451:                         loc_oBusca.Show()
9452:                     ENDIF
9453:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatriz")
9454:                         IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9455:                             SELECT cursor_4c_SigPrMtz
9456:                             REPLACE CMats WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.CPros, ""))
9457:                             IF PEMSTATUS(cursor_4c_BuscaMatriz, "Locals", 5)
9458:                                 REPLACE DLocs WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.Locals, ""))
9459:                             ENDIF
9460:                         ENDIF
9461:                     ENDIF
9462:                     loc_oBusca.Release()
9463:                 ENDIF
9464:                 IF USED("cursor_4c_BuscaMatriz")
9465:                     USE IN cursor_4c_BuscaMatriz
9466:                 ENDIF
9467:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9468:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes.Refresh()
9469:                 ENDIF
9470:             CATCH TO loc_oErro
9471:                 MsgErro(loc_oErro.Message, "Erro ao buscar matriz")
9472:             ENDTRY
9473:         ENDIF
9474:     ENDPROC
9475: 
9476:     *--------------------------------------------------------------------------
9477:     * CmdIncluirFaseClick - Insere nova linha de fase em cursor_4c_GradFase
9478:     * Legado: inserir.Click - calcula proximo Ordems e insere com resequenciamento
9479:     *--------------------------------------------------------------------------
9480:     PROCEDURE CmdIncluirFaseClick()
9481:         LOCAL loc_oPg, loc_nOrdem
9482:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9483:             RETURN
9484:         ENDIF
9485:         TRY
9486:             IF !USED("cursor_4c_GradFase")
9487:                 RETURN
9488:             ENDIF
9489:             *-- Calcular proximo numero de ordem
9490:             loc_nOrdem = 0
9491:             IF !EOF("cursor_4c_GradFase")
9492:                 SELECT MAX(Ordems) AS nMaxOrdem FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpOrd NOFILTER
9493:                 IF USED("cursor_4c_TmpOrd") AND !EOF("cursor_4c_TmpOrd")
9494:                     loc_nOrdem = NVL(cursor_4c_TmpOrd.nMaxOrdem, 0)
9495:                 ENDIF
9496:                 IF USED("cursor_4c_TmpOrd")
9497:                     USE IN cursor_4c_TmpOrd
9498:                 ENDIF
9499:             ENDIF
9500:             loc_nOrdem = loc_nOrdem + 1
9501:             *-- Inserir nova linha
9502:             INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9503:                 VALUES (loc_nOrdem, "", "", "", "")
9504:             *-- Posicionar no novo registro e focar grid
9505:             GO BOTTOM IN cursor_4c_GradFase
9506:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9507:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9508:                 IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9509:                     loc_oPg.grd_4c_GradFase.Refresh()
9510:                     loc_oPg.grd_4c_GradFase.SetFocus()
9511:                 ENDIF
9512:             ENDIF
9513:         CATCH TO loc_oErro
9514:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9515:         ENDTRY
9516:     ENDPROC
9517: 
9518:     *--------------------------------------------------------------------------
9519:     * CmdExcluirFaseClick - Exclui linha corrente de cursor_4c_GradFase
9520:     * Legado: excluir.Click - DELETE e resequencia Ordems
9521:     *--------------------------------------------------------------------------
9522:     PROCEDURE CmdExcluirFaseClick()
9523:         LOCAL loc_oPg, loc_lResultado
9524:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9525:             RETURN
9526:         ENDIF
9527:         loc_lResultado = .T.
9528:         TRY
9529:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9530:                 loc_lResultado = .F.
9531:             ENDIF
9532:             IF loc_lResultado
9533:                 IF !MsgConfirma("Excluir fase selecionada?")
9534:                     loc_lResultado = .F.
9535:                 ENDIF
9536:             ENDIF
9537:             IF loc_lResultado
9538:                 SELECT cursor_4c_GradFase
9539:                 DELETE
9540:                 IF !EOF("cursor_4c_GradFase")
9541:                     SKIP
9542:                 ENDIF
9543:                 IF EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
9544:                     GO BOTTOM IN cursor_4c_GradFase
9545:                 ENDIF
9546:                 *-- Resequenciar Ordems
9547:                 LOCAL loc_nSeq
9548:                 loc_nSeq = 1
9549:                 GO TOP IN cursor_4c_GradFase
9550:                 SCAN FOR !DELETED()
9551:                     REPLACE Ordems WITH loc_nSeq
9552:                     loc_nSeq = loc_nSeq + 1
9553:                 ENDSCAN
9554:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9555:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9556:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9557:                         loc_oPg.grd_4c_GradFase.Refresh()
9558:                     ENDIF
9559:                 ENDIF
9560:             ENDIF
9561:         CATCH TO loc_oErro
9562:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9563:         ENDTRY
9564:     ENDPROC
9565: 
9566:     *--------------------------------------------------------------------------
9567:     * CmdAlternativaFaseClick - Copia linha corrente como alternativa
9568:     * Legado: Alternativa.Click - duplica linha com mesmo Grupos mas nova Ordems
9569:     *--------------------------------------------------------------------------
9570:     PROCEDURE CmdAlternativaFaseClick()
9571:         LOCAL loc_oPg, loc_lResultado, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat
9572:         LOCAL loc_nOrdem
9573:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9574:             RETURN
9575:         ENDIF
9576:         loc_lResultado = .T.
9577:         TRY
9578:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
9579:                 loc_lResultado = .F.
9580:             ENDIF
9581:             IF loc_lResultado
9582:                 IF EMPTY(ALLTRIM(NVL(cursor_4c_GradFase.Grupos, "")))
9583:                     MsgAviso("Selecione uma fase para criar alternativa.")
9584:                     loc_lResultado = .F.
9585:                 ENDIF
9586:             ENDIF
9587:             IF loc_lResultado
9588:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9589:                 loc_cDescrs = ALLTRIM(NVL(cursor_4c_GradFase.Descrs, ""))
9590:                 loc_cUni    = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9591:                 loc_cMat    = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9592:                 *-- Calcular proxima ordem
9593:                 SELECT MAX(Ordems) AS nMaxOrd FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpAlt NOFILTER
9594:                 loc_nOrdem = 1
9595:                 IF USED("cursor_4c_TmpAlt") AND !EOF("cursor_4c_TmpAlt")
9596:                     loc_nOrdem = NVL(cursor_4c_TmpAlt.nMaxOrd, 0) + 1
9597:                 ENDIF
9598:                 IF USED("cursor_4c_TmpAlt")
9599:                     USE IN cursor_4c_TmpAlt
9600:                 ENDIF
9601:                 *-- Inserir copia como alternativa
9602:                 INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9603:                     VALUES (loc_nOrdem, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat)
9604:                 GO BOTTOM IN cursor_4c_GradFase
9605:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9606:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9607:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9608:                         loc_oPg.grd_4c_GradFase.Refresh()
9609:                     ENDIF
9610:                 ENDIF
9611:             ENDIF
9612:         CATCH TO loc_oErro
9613:             MsgErro(loc_oErro.Message, "Erro ao criar alternativa de fase")
9614:         ENDTRY
9615:     ENDPROC
9616: 
9617:     *--------------------------------------------------------------------------
9618:     * CmdFichaClick - Gera ficha tecnica do produto (REPORT FORM)
9619:     * Legado: CmdFicha.Click - cria CsCabecalho cursor e REPORT FORM TP_FasePro
9620:     *--------------------------------------------------------------------------
9621:     PROCEDURE CmdFichaClick()
9622:         LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cNmEmp
9623:         loc_lResultado = .T.
9624:         TRY
9625:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
9626:                 loc_lResultado = .F.
9627:             ENDIF
9628:             IF loc_lResultado
9629:                 IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCpros))
9630:                     MsgAviso("Produto n" + CHR(227) + "o selecionado.")
9631:                     loc_lResultado = .F.
9632:                 ENDIF
9633:             ENDIF
9634:             IF loc_lResultado
9635:                 *-- Nome da empresa ja disponivel em go_4c_Sistema.cEmpresa
9636:                 loc_cNmEmp = ALLTRIM(NVL(go_4c_Sistema.cEmpresa, ""))
9637:                 *-- Preparar cursor de cabecalho para o relatorio
9638:                 IF USED("CsCabecalho")
9639:                     USE IN CsCabecalho
9640:                 ENDIF
9641:                 CREATE CURSOR CsCabecalho (;
9642:                     _NmEmp C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
9643:                     _cGrus C(3),  _dGrus C(20),  _sGrus C(6),  _sDesc C(20), ;
9644:                     _cLinh C(10), _dLinh C(40),  _cGVen C(10), _dGVen C(40), ;
9645:                     _nPeso N(9,2))
9646:                 WITH THIS.this_oBusinessObject
9647:                     INSERT INTO CsCabecalho (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _nPeso) ;
9648:                         VALUES (loc_cNmEmp, ;
9649:                                 "Ficha T" + CHR(233) + "cnica de Produto", ;
9650:                                 ALLTRIM(.this_cCpros), ;
9651:                                 ALLTRIM(.this_cDpros), ;
9652:                                 ALLTRIM(.this_cCgrus), ;
9653:                                 .this_nPesobs)
9654:                 ENDWITH
9655:                 *-- Verificar e executar relatorio
9656:                 LOCAL loc_cRepPath
9657:                 loc_cRepPath = gc_4c_CaminhoReports + "TP_FasePro.frx"
9658:                 IF FILE(loc_cRepPath)
9659:                     REPORT FORM (loc_cRepPath) PREVIEW NOCONSOLE
9660:                 ELSE
9661:                     MsgAviso("Relat" + CHR(243) + "rio TP_FasePro.frx n" + CHR(227) + "o encontrado.")
9662:                 ENDIF
9663:                 IF USED("CsCabecalho")
9664:                     USE IN CsCabecalho
9665:                 ENDIF
9666:             ENDIF
9667:         CATCH TO loc_oErro
9668:             MsgErro(loc_oErro.Message, "Erro ao gerar ficha t" + CHR(233) + "cnica")
9669:         ENDTRY
9670:     ENDPROC
9671: 
9672:     *--------------------------------------------------------------------------
9673:     * CmdgFiguraClick - Seleciona imagem JPG/BMP para a fase corrente
9674:     * Legado: cmdgFigura.Click - GETPICT e armazena em crSigCdPrf.FigProcs
9675:     *--------------------------------------------------------------------------
9676:     PROCEDURE CmdgFiguraClick()
9677:         LOCAL loc_lResultado, loc_cFigura, loc_cArquivo
9678:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9679:             RETURN
9680:         ENDIF
9681:         loc_lResultado = .T.
9682:         TRY
9683:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9684:                 loc_lResultado = .F.
9685:             ENDIF
9686:             IF loc_lResultado
9687:                 *-- Abrir seletor de arquivo de imagem
9688:                 loc_cFigura = ALLTRIM(GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", ;
9689:                     "Nome do Arquivo:", "Selecionar"))
9690:                 IF !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9691:                     *-- Armazenar imagem binaria no campo memo FigProcs
9692:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9693:                         SELECT cursor_4c_GradFase
9694:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9695:                     ENDIF
9696:                     *-- Atualizar exibicao da imagem
9697:                     THIS.GradFaseAfterRowColChange(0)
9698:                 ENDIF
9699:             ENDIF
9700:         CATCH TO loc_oErro
9701:             MsgErro(loc_oErro.Message, "Erro ao selecionar imagem")
9702:         ENDTRY
9703:     ENDPROC
9704: 
9705:     *--------------------------------------------------------------------------
9706:     * CmdgFigCamClick - Captura imagem via webcam (SigImage form)
9707:     * Legado: cmdgFigCam.Click - DO form SigImage TO lcFigura e armazena
9708:     *--------------------------------------------------------------------------
9709:     PROCEDURE CmdgFigCamClick()
9710:         LOCAL loc_lResultado, loc_cFigura
9711:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9712:             RETURN
9713:         ENDIF
9714:         loc_lResultado = .T.
9715:         TRY
9716:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9717:                 loc_lResultado = .F.
9718:             ENDIF
9719:             IF loc_lResultado
9720:                 loc_cFigura = ""
9721:                 *-- Acionar captura de webcam via form legado SigImage
9722:                 IF FILE(gc_4c_CaminhoBase + "SigImage.scx")
9723:                     DO FORM (gc_4c_CaminhoBase + "SigImage") TO loc_cFigura
9724:                 ELSE
9725:                     MsgAviso("Captura de imagem (SigImage) n" + CHR(227) + "o dispon" + CHR(237) + "vel.")
9726:                     loc_lResultado = .F.
9727:                 ENDIF
9728:                 IF loc_lResultado AND !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9729:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9730:                         SELECT cursor_4c_GradFase
9731:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9732:                     ENDIF
9733:                     THIS.GradFaseAfterRowColChange(0)
9734:                 ENDIF
9735:             ENDIF
9736:         CATCH TO loc_oErro
9737:             MsgErro(loc_oErro.Message, "Erro ao capturar imagem via webcam")
9738:         ENDTRY
9739:     ENDPROC
9740: 
9741:     *--------------------------------------------------------------------------
9742:     * ImgFigJpgClick - Abre imagem da fase em zoom (SigOpZom form)
9743:     * Legado: ImgFigJpg.Click - StrToFile e DO form SigOpZom
9744:     *--------------------------------------------------------------------------
9745:     PROCEDURE ImgFigJpgClick()
9746:         LOCAL loc_lcArquivo
9747:         TRY
9748:             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9749:                 IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9750:                     IF !EMPTY(NVL(cursor_4c_GradFase.FigProcs, ""))
9751:                         loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_zoom.jpg"
9752:                         IF STRTOFILE(cursor_4c_GradFase.FigProcs, loc_lcArquivo) > 0
9753:                             IF FILE(loc_lcArquivo)
9754:                                 DO FORM SigOpZom WITH loc_lcArquivo, .F.
9755:                             ENDIF
9756:                         ENDIF
9757:                     ENDIF
9758:                 ENDIF
9759:             ENDIF
9760:         CATCH TO loc_oErro
9761:             MsgErro(loc_oErro.Message, "Erro ao exibir imagem em zoom")
9762:         ENDTRY
9763:     ENDPROC
9764: 
9765:     *--------------------------------------------------------------------------
9766:     * BtnInsereMtxClick - Insere nova linha de matriz em cursor_4c_SigPrMtz
9767:     * Legado: btnInsereMtx.Click - Insert Into crSigPrMtz se vazio
9768:     *--------------------------------------------------------------------------
9769:     PROCEDURE BtnInsereMtxClick()
9770:         LOCAL loc_oPg, loc_lResultado
9771:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9772:             RETURN
9773:         ENDIF
9774:         loc_lResultado = .T.
9775:         TRY
9776:             IF !USED("cursor_4c_SigPrMtz")
9777:                 loc_lResultado = .F.
9778:             ENDIF
9779:             IF loc_lResultado
9780:                 *-- Verificar se ja existe linha vazia (evitar duplicatas)
9781:                 GO TOP IN cursor_4c_SigPrMtz
9782:                 LOCATE FOR EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9783:                 IF !EOF("cursor_4c_SigPrMtz")
9784:                     *-- Ja existe linha vazia - apenas focar
9785:                     loc_lResultado = .F.
9786:                 ENDIF
9787:             ENDIF
9788:             IF loc_lResultado
9789:                 INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9790:                 GO BOTTOM IN cursor_4c_SigPrMtz
9791:             ENDIF
9792:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9793:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9794:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9795:                     loc_oPg.grd_4c_Matrizes.Refresh()
9796:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9797:                 ENDIF
9798:             ENDIF
9799:         CATCH TO loc_oErro
9800:             MsgErro(loc_oErro.Message, "Erro ao inserir matriz")
9801:         ENDTRY
9802:     ENDPROC
9803: 
9804:     *--------------------------------------------------------------------------
9805:     * BtnExcluiMtzClick - Exclui linha corrente de cursor_4c_SigPrMtz
9806:     * Legado: btnExcluiMtz.Click - DELETE e reinsere placeholder se vazio
9807:     *--------------------------------------------------------------------------
9808:     PROCEDURE BtnExcluiMtzClick()
9809:         LOCAL loc_oPg, loc_lResultado
9810:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9811:             RETURN
9812:         ENDIF
9813:         loc_lResultado = .T.
9814:         TRY
9815:             IF !USED("cursor_4c_SigPrMtz") OR EOF("cursor_4c_SigPrMtz")
9816:                 loc_lResultado = .F.
9817:             ENDIF
9818:             IF loc_lResultado
9819:                 SELECT cursor_4c_SigPrMtz
9820:                 DELETE
9821:                 *-- Se cursor ficou vazio, reinsere linha placeholder
9822:                 GO TOP IN cursor_4c_SigPrMtz
9823:                 LOCATE FOR !DELETED()
9824:                 IF EOF("cursor_4c_SigPrMtz")
9825:                     INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9826:                 ENDIF
9827:             ENDIF
9828:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9829:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9830:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9831:                     loc_oPg.grd_4c_Matrizes.Refresh()
9832:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9833:                 ENDIF
9834:             ENDIF
9835:         CATCH TO loc_oErro
9836:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9837:         ENDTRY
9838:     ENDPROC
9839: 
9840:     *--------------------------------------------------------------------------
9841:     * TxtCodacbLostFocus - Valida e busca acabamento (SigCdAca) ao sair do campo
9842:     * Legado: get_codacb.Valid = fwBuscaExt on SigCdAca by Cods
9843:     *         Apos selecao: preenche txt_4c__Dacb e atualiza BO
9844:     *--------------------------------------------------------------------------
9845:     PROCEDURE TxtCodacbLostFocus()
9846:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9847:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9848:             RETURN
9849:         ENDIF
9850:         loc_lResultado = .T.
9851:         TRY
9852:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9853:                 loc_lResultado = .F.
9854:             ENDIF
9855:             IF loc_lResultado
9856:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9857:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c__codacb.Value, ""))
9858:                 IF EMPTY(loc_cCod)
9859:                     loc_oPg.txt_4c__Dacb.Value = ""
9860:                     THIS.this_oBusinessObject.this_cCodacbs = ""
9861:                     loc_lResultado = .F.
9862:                 ENDIF
9863:             ENDIF
9864:             IF loc_lResultado
9865:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9866:                     "SigCdAca", "cursor_4c_BuscaAca", "Cods", loc_cCod, ;
9867:                     "Buscar Acabamento")
9868:                 IF VARTYPE(loc_oBusca) = "O"
9869:                     IF !loc_oBusca.this_lAchouRegistro
9870:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9871:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9872:                         loc_oBusca.Show()
9873:                     ENDIF
9874:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAca")
9875:                         loc_oPg.txt_4c__codacb.Value = ALLTRIM(NVL(cursor_4c_BuscaAca.Cods, ""))
9876:                         loc_oPg.txt_4c__Dacb.Value   = ALLTRIM(NVL(cursor_4c_BuscaAca.Descrs, ""))
9877:                         THIS.this_oBusinessObject.this_cCodacbs = loc_oPg.txt_4c__codacb.Value
9878:                     ELSE
9879:                         loc_oPg.txt_4c__codacb.Value = ""
9880:                         loc_oPg.txt_4c__Dacb.Value   = ""
9881:                         THIS.this_oBusinessObject.this_cCodacbs = ""
9882:                     ENDIF
9883:                     loc_oBusca.Release()
9884:                 ENDIF
9885:                 IF USED("cursor_4c_BuscaAca")
9886:                     USE IN cursor_4c_BuscaAca
9887:                 ENDIF
9888:             ENDIF
9889:         CATCH TO loc_oErro
9890:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
9891:         ENDTRY
9892:     ENDPROC
9893: 
9894:     *--------------------------------------------------------------------------
9895:     * TxtTamLostFocus - Valida e busca tamanho (SigCdTam) ao sair do campo
9896:     * Legado: getTam.Valid = fwBuscaExt on SigCdTam by Cods
9897:     *--------------------------------------------------------------------------
9898:     PROCEDURE TxtTamLostFocus()
9899:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9900:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9901:             RETURN
9902:         ENDIF
9903:         loc_lResultado = .T.
9904:         TRY
9905:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9906:                 loc_lResultado = .F.
9907:             ENDIF
9908:             IF loc_lResultado
9909:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9910:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Tam.Value, ""))
9911:                 IF EMPTY(loc_cCod)
9912:                     THIS.this_oBusinessObject.this_cCodtams = ""
9913:                     loc_lResultado = .F.
9914:                 ENDIF
9915:             ENDIF
9916:             IF loc_lResultado
9917:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9918:                     "SigCdTam", "cursor_4c_BuscaTam", "Cods", loc_cCod, ;
9919:                     "Buscar Tamanho Padr" + CHR(227) + "o")
9920:                 IF VARTYPE(loc_oBusca) = "O"
9921:                     IF !loc_oBusca.this_lAchouRegistro
9922:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9923:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9924:                         loc_oBusca.Show()
9925:                     ENDIF
9926:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
9927:                         loc_oPg.txt_4c_Tam.Value = ALLTRIM(NVL(cursor_4c_BuscaTam.Cods, ""))
9928:                         THIS.this_oBusinessObject.this_cCodtams = loc_oPg.txt_4c_Tam.Value
9929:                     ELSE
9930:                         loc_oPg.txt_4c_Tam.Value = ""
9931:                         THIS.this_oBusinessObject.this_cCodtams = ""
9932:                     ENDIF
9933:                     loc_oBusca.Release()
9934:                 ENDIF
9935:                 IF USED("cursor_4c_BuscaTam")
9936:                     USE IN cursor_4c_BuscaTam
9937:                 ENDIF
9938:             ENDIF
9939:         CATCH TO loc_oErro
9940:             MsgErro(loc_oErro.Message, "Erro ao validar tamanho")
9941:         ENDTRY
9942:     ENDPROC
9943: 
9944:     *--------------------------------------------------------------------------
9945:     * TxtCorLostFocus - Valida e busca cor padrao (SigCdCor) ao sair do campo
9946:     * Legado: getCor.Valid = fwBuscaExt on SigCdCor by Cods
9947:     *--------------------------------------------------------------------------
9948:     PROCEDURE TxtCorLostFocus()
9949:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9950:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9951:             RETURN
9952:         ENDIF
9953:         loc_lResultado = .T.
9954:         TRY
9955:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9956:                 loc_lResultado = .F.
9957:             ENDIF
9958:             IF loc_lResultado
9959:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9960:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Cor.Value, ""))
9961:                 IF EMPTY(loc_cCod)
9962:                     THIS.this_oBusinessObject.this_cCodcors = ""
9963:                     loc_lResultado = .F.
9964:                 ENDIF
9965:             ENDIF
9966:             IF loc_lResultado
9967:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9968:                     "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cCod, ;
9969:                     "Buscar Cor Padr" + CHR(227) + "o")
9970:                 IF VARTYPE(loc_oBusca) = "O"
9971:                     IF !loc_oBusca.this_lAchouRegistro
9972:                         loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
9973:                         loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9974:                         loc_oBusca.Show()
9975:                     ENDIF
9976:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
9977:                         loc_oPg.txt_4c_Cor.Value = ALLTRIM(NVL(cursor_4c_BuscaCor.cods, ""))
9978:                         THIS.this_oBusinessObject.this_cCodcors = loc_oPg.txt_4c_Cor.Value
9979:                     ELSE
9980:                         loc_oPg.txt_4c_Cor.Value = ""
9981:                         THIS.this_oBusinessObject.this_cCodcors = ""
9982:                     ENDIF
9983:                     loc_oBusca.Release()
9984:                 ENDIF
9985:                 IF USED("cursor_4c_BuscaCor")
9986:                     USE IN cursor_4c_BuscaCor
9987:                 ENDIF
9988:             ENDIF
9989:         CATCH TO loc_oErro
9990:             MsgErro(loc_oErro.Message, "Erro ao validar cor")
9991:         ENDTRY
9992:     ENDPROC
9993: 
9994:     *--------------------------------------------------------------------------
9995:     * TxtConquilhaLostFocus - Valida conquilha (SigCdCnq) ao sair do campo
9996:     * Legado: getConquilha.Valid = SQL SELECT conquilhas FROM SigCdCnq + fwBuscaInt
9997:     *--------------------------------------------------------------------------
9998:     PROCEDURE TxtConquilhaLostFocus()
9999:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
10000:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10001:             RETURN
10002:         ENDIF
10003:         loc_lResultado = .T.
10004:         TRY
10005:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10006:                 loc_lResultado = .F.
10007:             ENDIF
10008:             IF loc_lResultado
10009:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10010:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Conquilha.Value, ""))
10011:                 IF EMPTY(loc_cCod)
10012:                     THIS.this_oBusinessObject.this_cConquilhas = ""
10013:                     loc_lResultado = .F.
10014:                 ENDIF
10015:             ENDIF
10016:             IF loc_lResultado
10017:                 *-- Buscar conquilhas disponiveis em SigCdCnq
10018:                 loc_cSQL = "SELECT DISTINCT conquilhas FROM SigCdCnq"
10019:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaCnq")
10020:                 IF loc_nRet > 0 AND USED("cursor_4c_ListaCnq")
10021:                     SELECT cursor_4c_ListaCnq
10022:                     LOCATE FOR ALLTRIM(NVL(conquilhas, "")) = PADR(loc_cCod, 10)
10023:                     IF !EOF("cursor_4c_ListaCnq")
10024:                         *-- Encontrado direto
10025:                         loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(cursor_4c_ListaCnq.conquilhas)
10026:                         THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10027:                     ELSE
10028:                         *-- Nao encontrado - abrir lookup
10029:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10030:                             "SigCdCnq", "cursor_4c_BuscaCnq", "conquilhas", loc_cCod, ;
10031:                             "Buscar Conquilha")
10032:                         IF VARTYPE(loc_oBusca) = "O"
10033:                             IF !loc_oBusca.this_lAchouRegistro
10034:                                 loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
10035:                                 loc_oBusca.Show()
10036:                             ENDIF
10037:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnq")
10038:                                 loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(NVL(cursor_4c_BuscaCnq.conquilhas, ""))
10039:                                 THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10040:                             ELSE
10041:                                 loc_oPg.txt_4c_Conquilha.Value = ""
10042:                                 THIS.this_oBusinessObject.this_cConquilhas = ""
10043:                             ENDIF
10044:                             loc_oBusca.Release()
10045:                         ENDIF
10046:                         IF USED("cursor_4c_BuscaCnq")
10047:                             USE IN cursor_4c_BuscaCnq
10048:                         ENDIF
10049:                     ENDIF
10050:                     USE IN cursor_4c_ListaCnq
10051:                 ENDIF
10052:             ENDIF
10053:         CATCH TO loc_oErro
10054:             MsgErro(loc_oErro.Message, "Erro ao validar conquilha")
10055:         ENDTRY
10056:     ENDPROC
10057: 
10058:     *==========================================================================
10059:     * FASE 13 - Aba Dados Fiscais (pgDadosFiscais - Page3 do pgf_4c_Dados)
10060:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais
10061:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10062:     * Controles: 16 textboxes, 11 labels, 1 editbox, 1 combobox, 1 grid(3col), 1 button
10063:     *==========================================================================
10064:     PROTECTED PROCEDURE ConfigurarPgPgDadosFiscais()
10065:         LOCAL loc_oPg, loc_oGrd
10066:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10067: 
10068:         *----------------------------------------------------------------------
10069:         *-- Cursor placeholder cursor_4c_Cmv (SigCdCmv - Valor Grama)
10070:         *-- Campos: Datas, ValCuss, Moedas (readonly grid)
10071:         *----------------------------------------------------------------------
10072:         IF !USED("cursor_4c_Cmv")
10073:             SET NULL ON
10074:             CREATE CURSOR cursor_4c_Cmv (;
10075:                 Datas   D, ;
10076:                 ValCuss N(12,3), ;
10077:                 Moedas  C(3))
10078:             SET NULL OFF
10079:         ENDIF
10080: 
10081:         *----------------------------------------------------------------------
10082:         *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
10083:         *----------------------------------------------------------------------
10084:         loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
10085:         WITH loc_oPg.lbl_4c_LblGruCus
10086:             .Caption   = "Grupo C.C. :"
10087:             .Top       = 165
10088:             .Left      = 138
10089:             .Width     = 63
10090:             .Height    = 15
10091:             .FontName  = "Tahoma"
10092:             .FontSize  = 8
10093:             .BackStyle = 0
10094:             .ForeColor = RGB(90, 90, 90)
10095:             .Visible   = .T.
10096:         ENDWITH
10097: 
10098:         loc_oPg.AddObject("lbl_4c_LblContaCus", "Label")
10099:         WITH loc_oPg.lbl_4c_LblContaCus
10100:             .Caption   = "Conta C.C. :"
10101:             .Top       = 189
10102:             .Left      = 138
10103:             .Width     = 63
10104:             .Height    = 15

*-- Linhas 10397 a 10666:
10397:             .Enabled       = .F.
10398:             .Visible       = .T.
10399:         ENDWITH
10400:         BINDEVENT(loc_oPg.txt_4c_Gruccus, "LostFocus", THIS, "TxtGruccusFiscLostFocus")
10401: 
10402:         *-- get_dgruccus: Descricao Grupo CC (T:161 L:288 W:318 H:23) readonly
10403:         loc_oPg.AddObject("txt_4c_Dgruccus", "TextBox")
10404:         WITH loc_oPg.txt_4c_Dgruccus
10405:             .Top           = 161
10406:             .Left          = 288
10407:             .Width         = 318
10408:             .Height        = 23
10409:             .Value         = ""
10410:             .FontName      = "Tahoma"
10411:             .FontSize      = 8
10412:             .SpecialEffect = 1
10413:             .ForeColor     = RGB(36, 84, 155)
10414:             .ReadOnly      = .T.
10415:             .Enabled       = .F.
10416:             .Visible       = .T.
10417:         ENDWITH
10418: 
10419:         *-- get_contaccus: Conta de Custo (T:186 L:206 W:80 H:23)
10420:         loc_oPg.AddObject("txt_4c_Contaccus", "TextBox")
10421:         WITH loc_oPg.txt_4c_Contaccus
10422:             .Top           = 186
10423:             .Left          = 206
10424:             .Width         = 80
10425:             .Height        = 23
10426:             .Value         = ""
10427:             .FontName      = "Tahoma"
10428:             .FontSize      = 8
10429:             .SpecialEffect = 1
10430:             .ForeColor     = RGB(36, 84, 155)
10431:             .Enabled       = .F.
10432:             .Visible       = .T.
10433:         ENDWITH
10434:         BINDEVENT(loc_oPg.txt_4c_Contaccus, "LostFocus", THIS, "TxtContaccusFiscLostFocus")
10435: 
10436:         *-- get_dcontaccus: Descricao Conta CC (T:186 L:288 W:318 H:23) readonly
10437:         loc_oPg.AddObject("txt_4c_Dcontaccus", "TextBox")
10438:         WITH loc_oPg.txt_4c_Dcontaccus
10439:             .Top           = 186
10440:             .Left          = 288
10441:             .Width         = 318
10442:             .Height        = 23
10443:             .Value         = ""
10444:             .FontName      = "Tahoma"
10445:             .FontSize      = 8
10446:             .SpecialEffect = 1
10447:             .ForeColor     = RGB(36, 84, 155)
10448:             .ReadOnly      = .T.
10449:             .Enabled       = .F.
10450:             .Visible       = .T.
10451:         ENDWITH
10452: 
10453:         *----------------------------------------------------------------------
10454:         *-- TextBoxes da area Fiscal Principal
10455:         *----------------------------------------------------------------------
10456:         *-- getClfiscal: Classificacao Fiscal (T:211 L:206 W:94 H:23)
10457:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
10458:         WITH loc_oPg.txt_4c_Clfiscal
10459:             .Top           = 211
10460:             .Left          = 206
10461:             .Width         = 94
10462:             .Height        = 23
10463:             .Value         = ""
10464:             .FontName      = "Tahoma"
10465:             .FontSize      = 8
10466:             .SpecialEffect = 1
10467:             .ForeColor     = RGB(36, 84, 155)
10468:             .Enabled       = .F.
10469:             .Visible       = .T.
10470:         ENDWITH
10471:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "LostFocus", THIS, "TxtClfiscalFiscLostFocus")
10472: 
10473:         *-- getDclfiscal: Descricao Classif. Fiscal (T:211 L:303 W:303 H:23) readonly
10474:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
10475:         WITH loc_oPg.txt_4c_Dclfiscal
10476:             .Top           = 211
10477:             .Left          = 303
10478:             .Width         = 303
10479:             .Height        = 23
10480:             .Value         = ""
10481:             .FontName      = "Tahoma"
10482:             .FontSize      = 8
10483:             .SpecialEffect = 1
10484:             .ForeColor     = RGB(36, 84, 155)
10485:             .ReadOnly      = .T.
10486:             .Enabled       = .F.
10487:             .Visible       = .T.
10488:         ENDWITH
10489:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "LostFocus", THIS, "TxtDclfiscalFiscLostFocus")
10490: 
10491:         *-- getOrigmerc: Origem Mercadoria (T:236 L:206 W:17 H:23)
10492:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
10493:         WITH loc_oPg.txt_4c_Origmerc
10494:             .Top           = 236
10495:             .Left          = 206
10496:             .Width         = 17
10497:             .Height        = 23
10498:             .Value         = ""
10499:             .FontName      = "Tahoma"
10500:             .FontSize      = 8
10501:             .SpecialEffect = 1
10502:             .ForeColor     = RGB(36, 84, 155)
10503:             .Enabled       = .F.
10504:             .Visible       = .T.
10505:         ENDWITH
10506:         BINDEVENT(loc_oPg.txt_4c_Origmerc, "LostFocus", THIS, "TxtOrigmercFiscLostFocus")
10507: 
10508:         *-- getDorigmerc: Descricao Origem (T:236 L:226 W:380 H:23)
10509:         *-- Visivel apenas quando Origmerc vazio (readonly com busca reversa)
10510:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
10511:         WITH loc_oPg.txt_4c_Dorigmerc
10512:             .Top           = 236
10513:             .Left          = 226
10514:             .Width         = 380
10515:             .Height        = 23
10516:             .Value         = ""
10517:             .FontName      = "Tahoma"
10518:             .FontSize      = 8
10519:             .SpecialEffect = 1
10520:             .ForeColor     = RGB(36, 84, 155)
10521:             .ReadOnly      = .T.
10522:             .Enabled       = .F.
10523:             .Visible       = .T.
10524:         ENDWITH
10525: 
10526:         *-- getSittricm: Situacao Tributaria ICMS (T:261 L:206 W:31 H:23)
10527:         loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
10528:         WITH loc_oPg.txt_4c_Sittricm
10529:             .Top           = 261
10530:             .Left          = 206
10531:             .Width         = 31
10532:             .Height        = 23
10533:             .Value         = ""
10534:             .FontName      = "Tahoma"
10535:             .FontSize      = 8
10536:             .SpecialEffect = 1
10537:             .ForeColor     = RGB(36, 84, 155)
10538:             .Enabled       = .F.
10539:             .Visible       = .T.
10540:         ENDWITH
10541:         BINDEVENT(loc_oPg.txt_4c_Sittricm, "LostFocus", THIS, "TxtSittricmFiscLostFocus")
10542: 
10543:         *-- getDsittricm: Descricao Sit. Trib. ICMS (T:261 L:240 W:366 H:23) readonly
10544:         loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
10545:         WITH loc_oPg.txt_4c_Dsittricm
10546:             .Top           = 261
10547:             .Left          = 240
10548:             .Width         = 366
10549:             .Height        = 23
10550:             .Value         = ""
10551:             .FontName      = "Tahoma"
10552:             .FontSize      = 8
10553:             .SpecialEffect = 1
10554:             .ForeColor     = RGB(36, 84, 155)
10555:             .ReadOnly      = .T.
10556:             .Enabled       = .F.
10557:             .Visible       = .T.
10558:         ENDWITH
10559: 
10560:         *-- Get_CodServs: Cod. Servicos ICMS (T:286 L:206 W:38 H:23)
10561:         loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
10562:         WITH loc_oPg.txt_4c_CodServs
10563:             .Top           = 286
10564:             .Left          = 206
10565:             .Width         = 38
10566:             .Height        = 23
10567:             .Value         = ""
10568:             .FontName      = "Tahoma"
10569:             .FontSize      = 8
10570:             .SpecialEffect = 1
10571:             .ForeColor     = RGB(36, 84, 155)
10572:             .Enabled       = .F.
10573:             .Visible       = .T.
10574:         ENDWITH
10575:         BINDEVENT(loc_oPg.txt_4c_CodServs, "LostFocus", THIS, "TxtCodServsFiscLostFocus")
10576: 
10577:         *-- getIcms: Aliquota ICMS (T:286 L:342 W:45 H:23)
10578:         loc_oPg.AddObject("txt_4c_Icms", "TextBox")
10579:         WITH loc_oPg.txt_4c_Icms
10580:             .Top           = 286
10581:             .Left          = 342
10582:             .Width         = 45
10583:             .Height        = 23
10584:             .Value         = 0
10585:             .FontName      = "Tahoma"
10586:             .FontSize      = 8
10587:             .SpecialEffect = 1
10588:             .ForeColor     = RGB(36, 84, 155)
10589:             .Enabled       = .F.
10590:             .Visible       = .T.
10591:         ENDWITH
10592: 
10593:         *-- Get_TpTrib: Tipo Tributacao (T:286 L:513 W:38 H:23)
10594:         loc_oPg.AddObject("txt_4c_TpTrib", "TextBox")
10595:         WITH loc_oPg.txt_4c_TpTrib
10596:             .Top           = 286
10597:             .Left          = 513
10598:             .Width         = 38
10599:             .Height        = 23
10600:             .Value         = ""
10601:             .FontName      = "Tahoma"
10602:             .FontSize      = 8
10603:             .SpecialEffect = 1
10604:             .ForeColor     = RGB(36, 84, 155)
10605:             .Enabled       = .F.
10606:             .Visible       = .T.
10607:         ENDWITH
10608:         BINDEVENT(loc_oPg.txt_4c_TpTrib, "LostFocus", THIS, "TxtTpTribFiscLostFocus")
10609: 
10610:         *-- getiat: IAT - Arredondamento/Truncamento (T:286 L:589 W:17 H:23) MaxLength=1
10611:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
10612:         WITH loc_oPg.txt_4c_Iat
10613:             .Top           = 286
10614:             .Left          = 589
10615:             .Width         = 17
10616:             .Height        = 23
10617:             .Value         = ""
10618:             .FontName      = "Tahoma"
10619:             .FontSize      = 8
10620:             .SpecialEffect = 1
10621:             .ForeColor     = RGB(36, 84, 155)
10622:             .MaxLength     = 1
10623:             .Enabled       = .F.
10624:             .Visible       = .T.
10625:         ENDWITH
10626:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "TxtIatFiscLostFocus")
10627: 
10628:         *----------------------------------------------------------------------
10629:         *-- ComboBox cmbIpi: Tipo IPI (T:311 L:206 W:108 H:25)
10630:         *-- Items: '' | Tributado | Isento | Outros
10631:         *----------------------------------------------------------------------
10632:         loc_oPg.AddObject("cmb_4c_Ipi", "ComboBox")
10633:         WITH loc_oPg.cmb_4c_Ipi
10634:             .Top           = 311
10635:             .Left          = 206
10636:             .Width         = 108
10637:             .Height        = 25
10638:             .FontName      = "Tahoma"
10639:             .FontSize      = 8
10640:             .SpecialEffect = 1
10641:             .Style         = 2
10642:             .Enabled       = .F.
10643:             .Visible       = .T.
10644:         ENDWITH
10645:         loc_oPg.cmb_4c_Ipi.Clear()
10646:         loc_oPg.cmb_4c_Ipi.AddItem(PADR("", 10))
10647:         loc_oPg.cmb_4c_Ipi.AddItem("Tributado")
10648:         loc_oPg.cmb_4c_Ipi.AddItem("Isento   ")
10649:         loc_oPg.cmb_4c_Ipi.AddItem("Outros   ")
10650: 
10651:         *-- Get_AliqIPI: Aliquota IPI (T:311 L:425 W:45 H:25)
10652:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
10653:         WITH loc_oPg.txt_4c_AliqIPI
10654:             .Top           = 311
10655:             .Left          = 425
10656:             .Width         = 45
10657:             .Height        = 25
10658:             .Value         = 0
10659:             .FontName      = "Tahoma"
10660:             .FontSize      = 8
10661:             .SpecialEffect = 1
10662:             .ForeColor     = RGB(36, 84, 155)
10663:             .Enabled       = .F.
10664:             .Visible       = .T.
10665:         ENDWITH
10666: 

*-- Linhas 10698 a 10741:
10698:             .Enabled         = .F.
10699:             .Visible         = .T.
10700:         ENDWITH
10701:         BINDEVENT(loc_oPg.cmd_4c_DescFis, "Click", THIS, "CmdDescFisClick")
10702: 
10703:         *----------------------------------------------------------------------
10704:         *-- EditBox mgetdescfi: Descricao Fiscal (T:338 L:206 W:509 H:89)
10705:         *----------------------------------------------------------------------
10706:         loc_oPg.AddObject("obj_4c_Descfis", "EditBox")
10707:         WITH loc_oPg.obj_4c_Descfis
10708:             .Top           = 338
10709:             .Left          = 206
10710:             .Width         = 509
10711:             .Height        = 89
10712:             .Value         = ""
10713:             .FontName      = "Tahoma"
10714:             .FontSize      = 8
10715:             .SpecialEffect = 1
10716:             .ForeColor     = RGB(36, 84, 155)
10717:             .Enabled       = .F.
10718:             .Visible       = .T.
10719:         ENDWITH
10720: 
10721:         *----------------------------------------------------------------------
10722:         *-- TextBoxes area ECF / Metal / Teor / Valor
10723:         *----------------------------------------------------------------------
10724:         *-- getDescEcfs: Descricao ECF (T:429 L:206 W:213 H:23)
10725:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
10726:         WITH loc_oPg.txt_4c_DescEcfs
10727:             .Top           = 429
10728:             .Left          = 206
10729:             .Width         = 213
10730:             .Height        = 23
10731:             .Value         = ""
10732:             .FontName      = "Tahoma"
10733:             .FontSize      = 8
10734:             .SpecialEffect = 1
10735:             .ForeColor     = RGB(36, 84, 155)
10736:             .MaxLength     = 29
10737:             .Enabled       = .F.
10738:             .Visible       = .T.
10739:         ENDWITH
10740: 
10741:         *-- Get_metal: Metal (T:429 L:537 W:24 H:23)

*-- Linhas 10753 a 10796:
10753:             .Enabled       = .F.
10754:             .Visible       = .T.
10755:         ENDWITH
10756:         BINDEVENT(loc_oPg.txt_4c_Metal, "LostFocus", THIS, "TxtMetalFiscLostFocus")
10757: 
10758:         *-- Get_DesMetal: Descricao Metal (T:429 L:564 W:150 H:23) readonly
10759:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
10760:         WITH loc_oPg.txt_4c_DesMetal
10761:             .Top           = 429
10762:             .Left          = 564
10763:             .Width         = 150
10764:             .Height        = 23
10765:             .Value         = ""
10766:             .FontName      = "Tahoma"
10767:             .FontSize      = 8
10768:             .SpecialEffect = 1
10769:             .ForeColor     = RGB(36, 84, 155)
10770:             .ReadOnly      = .T.
10771:             .Enabled       = .F.
10772:             .Visible       = .T.
10773:         ENDWITH
10774: 
10775:         *-- getValor: Valor Estimado (T:454 L:206 W:108 H:23) numeric
10776:         loc_oPg.AddObject("txt_4c_ValorEstim", "TextBox")
10777:         WITH loc_oPg.txt_4c_ValorEstim
10778:             .Top           = 454
10779:             .Left          = 206
10780:             .Width         = 108
10781:             .Height        = 23
10782:             .Value         = 0
10783:             .FontName      = "Tahoma"
10784:             .FontSize      = 8
10785:             .SpecialEffect = 1
10786:             .ForeColor     = RGB(36, 84, 155)
10787:             .Enabled       = .F.
10788:             .Visible       = .T.
10789:         ENDWITH
10790: 
10791:         *-- GetMvalor: Moeda do Valor (T:454 L:317 W:31 H:23) - lookup SigCdMoe
10792:         loc_oPg.AddObject("txt_4c_Mvalor", "TextBox")
10793:         WITH loc_oPg.txt_4c_Mvalor
10794:             .Top           = 454
10795:             .Left          = 317
10796:             .Width         = 31

*-- Linhas 10803 a 10863:
10803:             .Enabled       = .F.
10804:             .Visible       = .T.
10805:         ENDWITH
10806:         BINDEVENT(loc_oPg.txt_4c_Mvalor, "LostFocus", THIS, "TxtMvalorFiscLostFocus")
10807: 
10808:         *-- Get_teor: Teor (T:454 L:537 W:24 H:23)
10809:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
10810:         WITH loc_oPg.txt_4c_Teor
10811:             .Top           = 454
10812:             .Left          = 537
10813:             .Width         = 24
10814:             .Height        = 23
10815:             .Value         = ""
10816:             .FontName      = "Tahoma"
10817:             .FontSize      = 8
10818:             .SpecialEffect = 1
10819:             .ForeColor     = RGB(36, 84, 155)
10820:             .Enabled       = .F.
10821:             .Visible       = .T.
10822:         ENDWITH
10823:         BINDEVENT(loc_oPg.txt_4c_Teor, "LostFocus", THIS, "TxtTeorFiscLostFocus")
10824: 
10825:         *-- Get_DesTeor: Descricao Teor (T:454 L:564 W:150 H:23) readonly
10826:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
10827:         WITH loc_oPg.txt_4c_DesTeor
10828:             .Top           = 454
10829:             .Left          = 564
10830:             .Width         = 150
10831:             .Height        = 23
10832:             .Value         = ""
10833:             .FontName      = "Tahoma"
10834:             .FontSize      = 8
10835:             .SpecialEffect = 1
10836:             .ForeColor     = RGB(36, 84, 155)
10837:             .ReadOnly      = .T.
10838:             .Enabled       = .F.
10839:             .Visible       = .T.
10840:         ENDWITH
10841: 
10842:         *-- getIPPTCST: IPPT/CST (T:479 L:206 W:108 H:23) readonly (When=.f.)
10843:         loc_oPg.AddObject("txt_4c_IpptCST", "TextBox")
10844:         WITH loc_oPg.txt_4c_IpptCST
10845:             .Top           = 479
10846:             .Left          = 206
10847:             .Width         = 108
10848:             .Height        = 23
10849:             .Value         = ""
10850:             .FontName      = "Tahoma"
10851:             .FontSize      = 8
10852:             .SpecialEffect = 1
10853:             .ForeColor     = RGB(36, 84, 155)
10854:             .ReadOnly      = .T.
10855:             .Enabled       = .F.
10856:             .Visible       = .T.
10857:         ENDWITH
10858: 
10859:         *----------------------------------------------------------------------
10860:         *-- Grid grdCmv: Valor do Grama Produzido (T:338 L:754 W:223 H:141)
10861:         *-- Colunas: Periodo | Valor Custo GR | Moe (readonly)
10862:         *----------------------------------------------------------------------
10863:         loc_oPg.AddObject("grd_4c_Cmv", "Grid")

*-- Linhas 10916 a 10959:
10916:     * PreencherCamposFiscais - Popula controles de pgDadosFiscais a partir do BO
10917:     * Chamado por BOParaForm apos carregar dados de SigCdPro
10918:     *--------------------------------------------------------------------------
10919:     PROTECTED PROCEDURE PreencherCamposFiscais()
10920:         LOCAL loc_oPg, loc_cIpiVal
10921:         TRY
10922:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10923:                 RETURN
10924:             ENDIF
10925:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10926:             IF VARTYPE(loc_oPg) # "O"
10927:                 RETURN
10928:             ENDIF
10929:             WITH THIS.this_oBusinessObject
10930:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
10931:                     loc_oPg.txt_4c_Gruccus.Value = ALLTRIM(.this_cGruccus)
10932:                 ENDIF
10933:                 IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
10934:                     loc_oPg.txt_4c_Contaccus.Value = ALLTRIM(.this_cContaccus)
10935:                 ENDIF
10936:                 IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
10937:                     loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(.this_cClfiscals)
10938:                 ENDIF
10939:                 IF VARTYPE(loc_oPg.txt_4c_Origmerc) = "O"
10940:                     loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(.this_cOrigmercs)
10941:                 ENDIF
10942:                 IF VARTYPE(loc_oPg.txt_4c_Sittricm) = "O"
10943:                     loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(.this_cSittricms)
10944:                 ENDIF
10945:                 IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
10946:                     loc_oPg.txt_4c_CodServs.Value = ALLTRIM(.this_cCodservs)
10947:                 ENDIF
10948:                 IF VARTYPE(loc_oPg.txt_4c_Icms) = "O"
10949:                     loc_oPg.txt_4c_Icms.Value = .this_nIcms
10950:                 ENDIF
10951:                 IF VARTYPE(loc_oPg.txt_4c_TpTrib) = "O"
10952:                     loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(.this_cTptribs)
10953:                 ENDIF
10954:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
10955:                     loc_oPg.txt_4c_Iat.Value = ALLTRIM(.this_cIats)
10956:                 ENDIF
10957:                 *-- cmbIpi: converte this_cIpis (T/I/O/'') para texto do combo
10958:                 IF VARTYPE(loc_oPg.cmb_4c_Ipi) = "O"
10959:                     DO CASE

*-- Linhas 11002 a 11045:
11002:     * LerCamposFiscais - Le controles de pgDadosFiscais e transfere para o BO
11003:     * Chamado por FormParaBO antes de salvar
11004:     *--------------------------------------------------------------------------
11005:     PROTECTED PROCEDURE LerCamposFiscais()
11006:         LOCAL loc_oPg, loc_cIpiTxt
11007:         TRY
11008:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11009:                 RETURN
11010:             ENDIF
11011:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11012:             IF VARTYPE(loc_oPg) # "O"
11013:                 RETURN
11014:             ENDIF
11015:             WITH THIS.this_oBusinessObject
11016:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
11017:                     .this_cGruccus = ALLTRIM(loc_oPg.txt_4c_Gruccus.Value)
11018:                 ENDIF
11019:                 IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
11020:                     .this_cContaccus = ALLTRIM(loc_oPg.txt_4c_Contaccus.Value)
11021:                 ENDIF
11022:                 IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
11023:                     .this_cClfiscals = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
11024:                 ENDIF
11025:                 IF VARTYPE(loc_oPg.txt_4c_Origmerc) = "O"
11026:                     .this_cOrigmercs = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
11027:                 ENDIF
11028:                 IF VARTYPE(loc_oPg.txt_4c_Sittricm) = "O"
11029:                     .this_cSittricms = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
11030:                 ENDIF
11031:                 IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
11032:                     .this_cCodservs = ALLTRIM(loc_oPg.txt_4c_CodServs.Value)
11033:                 ENDIF
11034:                 IF VARTYPE(loc_oPg.txt_4c_Icms) = "O"
11035:                     .this_nIcms = loc_oPg.txt_4c_Icms.Value
11036:                 ENDIF
11037:                 IF VARTYPE(loc_oPg.txt_4c_TpTrib) = "O"
11038:                     .this_cTptribs = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
11039:                 ENDIF
11040:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
11041:                     .this_cIats = ALLTRIM(loc_oPg.txt_4c_Iat.Value)
11042:                 ENDIF
11043:                 *-- cmbIpi: converte texto para char(1)
11044:                 IF VARTYPE(loc_oPg.cmb_4c_Ipi) = "O"
11045:                     loc_cIpiTxt = UPPER(LEFT(ALLTRIM(loc_oPg.cmb_4c_Ipi.Value), 1))

*-- Linhas 11082 a 11734:
11082:     *--------------------------------------------------------------------------
11083:     * TxtClfiscalFiscLostFocus - Lookup SigCdClf por Codigos
11084:     *--------------------------------------------------------------------------
11085:     PROCEDURE TxtClfiscalFiscLostFocus()
11086:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11087:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11088:             RETURN
11089:         ENDIF
11090:         loc_lResultado = .T.
11091:         TRY
11092:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11093:                 loc_lResultado = .F.
11094:             ENDIF
11095:             IF loc_lResultado
11096:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11097:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, ""))
11098:                 IF EMPTY(loc_cCod)
11099:                     THIS.this_oBusinessObject.this_cClfiscals = ""
11100:                     IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11101:                         loc_oPg.txt_4c_Dclfiscal.Value = ""
11102:                     ENDIF
11103:                     loc_lResultado = .F.
11104:                 ENDIF
11105:             ENDIF
11106:             IF loc_lResultado
11107:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11108:                     "SigCdClf", "cursor_4c_BuscaClf", "Codigos", loc_cCod, ;
11109:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11110:                 IF VARTYPE(loc_oBusca) = "O"
11111:                     IF !loc_oBusca.this_lAchouRegistro
11112:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11113:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11114:                         loc_oBusca.Show()
11115:                     ENDIF
11116:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11117:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Codigos, ""))
11118:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11119:                             loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Descricaos, ""))
11120:                         ENDIF
11121:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11122:                     ELSE
11123:                         loc_oPg.txt_4c_Clfiscal.Value = ""
11124:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11125:                             loc_oPg.txt_4c_Dclfiscal.Value = ""
11126:                         ENDIF
11127:                         THIS.this_oBusinessObject.this_cClfiscals = ""
11128:                     ENDIF
11129:                     loc_oBusca.Release()
11130:                 ENDIF
11131:                 IF USED("cursor_4c_BuscaClf")
11132:                     USE IN cursor_4c_BuscaClf
11133:                 ENDIF
11134:             ENDIF
11135:         CATCH TO loc_oErro
11136:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
11137:         ENDTRY
11138:     ENDPROC
11139: 
11140:     *--------------------------------------------------------------------------
11141:     * TxtDclfiscalFiscLostFocus - Busca reversa SigCdClf por Descricaos
11142:     * Ativado quando getClfiscal esta vazio
11143:     *--------------------------------------------------------------------------
11144:     PROCEDURE TxtDclfiscalFiscLostFocus()
11145:         LOCAL loc_oPg, loc_oBusca, loc_cDesc, loc_lResultado
11146:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11147:             RETURN
11148:         ENDIF
11149:         loc_lResultado = .T.
11150:         TRY
11151:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11152:                 loc_lResultado = .F.
11153:             ENDIF
11154:             IF loc_lResultado
11155:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11156:                 *-- Apenas ativo quando codigo vazio
11157:                 IF NOT EMPTY(ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, "")))
11158:                     loc_lResultado = .F.
11159:                 ENDIF
11160:             ENDIF
11161:             IF loc_lResultado
11162:                 loc_cDesc = ALLTRIM(NVL(loc_oPg.txt_4c_Dclfiscal.Value, ""))
11163:                 IF EMPTY(loc_cDesc)
11164:                     loc_lResultado = .F.
11165:                 ENDIF
11166:             ENDIF
11167:             IF loc_lResultado
11168:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11169:                     "SigCdClf", "cursor_4c_BuscaClfR", "Descricaos", loc_cDesc, ;
11170:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11171:                 IF VARTYPE(loc_oBusca) = "O"
11172:                     IF !loc_oBusca.this_lAchouRegistro
11173:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11174:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11175:                         loc_oBusca.Show()
11176:                     ENDIF
11177:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClfR")
11178:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(NVL(cursor_4c_BuscaClfR.Codigos, ""))
11179:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClfR.Descricaos, ""))
11180:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11181:                     ENDIF
11182:                     loc_oBusca.Release()
11183:                 ENDIF
11184:                 IF USED("cursor_4c_BuscaClfR")
11185:                     USE IN cursor_4c_BuscaClfR
11186:                 ENDIF
11187:             ENDIF
11188:         CATCH TO loc_oErro
11189:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
11190:         ENDTRY
11191:     ENDPROC
11192: 
11193:     *--------------------------------------------------------------------------
11194:     * TxtOrigmercFiscLostFocus - Lookup SigCdOrg por Codigos (origem mercadoria)
11195:     *--------------------------------------------------------------------------
11196:     PROCEDURE TxtOrigmercFiscLostFocus()
11197:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11198:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11199:             RETURN
11200:         ENDIF
11201:         loc_lResultado = .T.
11202:         TRY
11203:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11204:                 loc_lResultado = .F.
11205:             ENDIF
11206:             IF loc_lResultado
11207:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11208:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Origmerc.Value, ""))
11209:                 IF EMPTY(loc_cCod)
11210:                     THIS.this_oBusinessObject.this_cOrigmercs = ""
11211:                     IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11212:                         loc_oPg.txt_4c_Dorigmerc.Value = ""
11213:                     ENDIF
11214:                     loc_lResultado = .F.
11215:                 ENDIF
11216:             ENDIF
11217:             IF loc_lResultado
11218:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11219:                     "SigCdOrg", "cursor_4c_BuscaOrg", "Codigos", loc_cCod, ;
11220:                     "Buscar Origem da Mercadoria")
11221:                 IF VARTYPE(loc_oBusca) = "O"
11222:                     IF !loc_oBusca.this_lAchouRegistro
11223:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11224:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11225:                         loc_oBusca.Show()
11226:                     ENDIF
11227:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11228:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Codigos, ""))
11229:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11230:                             loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Descricaos, ""))
11231:                         ENDIF
11232:                         THIS.this_oBusinessObject.this_cOrigmercs = loc_oPg.txt_4c_Origmerc.Value
11233:                     ELSE
11234:                         loc_oPg.txt_4c_Origmerc.Value = ""
11235:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11236:                             loc_oPg.txt_4c_Dorigmerc.Value = ""
11237:                         ENDIF
11238:                         THIS.this_oBusinessObject.this_cOrigmercs = ""
11239:                     ENDIF
11240:                     loc_oBusca.Release()
11241:                 ENDIF
11242:                 IF USED("cursor_4c_BuscaOrg")
11243:                     USE IN cursor_4c_BuscaOrg
11244:                 ENDIF
11245:             ENDIF
11246:         CATCH TO loc_oErro
11247:             MsgErro(loc_oErro.Message, "Erro ao buscar origem da mercadoria")
11248:         ENDTRY
11249:     ENDPROC
11250: 
11251:     *--------------------------------------------------------------------------
11252:     * TxtSittricmFiscLostFocus - Lookup SigCdIcm por Codigos (sit. trib. ICMS)
11253:     *--------------------------------------------------------------------------
11254:     PROCEDURE TxtSittricmFiscLostFocus()
11255:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11256:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11257:             RETURN
11258:         ENDIF
11259:         loc_lResultado = .T.
11260:         TRY
11261:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11262:                 loc_lResultado = .F.
11263:             ENDIF
11264:             IF loc_lResultado
11265:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11266:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Sittricm.Value, ""))
11267:                 IF EMPTY(loc_cCod)
11268:                     THIS.this_oBusinessObject.this_cSittricms = ""
11269:                     IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11270:                         loc_oPg.txt_4c_Dsittricm.Value = ""
11271:                     ENDIF
11272:                     loc_lResultado = .F.
11273:                 ENDIF
11274:             ENDIF
11275:             IF loc_lResultado
11276:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11277:                     "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", loc_cCod, ;
11278:                     "Buscar Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11279:                 IF VARTYPE(loc_oBusca) = "O"
11280:                     IF !loc_oBusca.this_lAchouRegistro
11281:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11282:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11283:                         loc_oBusca.Show()
11284:                     ENDIF
11285:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11286:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Codigos, ""))
11287:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11288:                             loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Descricaos, ""))
11289:                         ENDIF
11290:                         THIS.this_oBusinessObject.this_cSittricms = loc_oPg.txt_4c_Sittricm.Value
11291:                     ELSE
11292:                         loc_oPg.txt_4c_Sittricm.Value = ""
11293:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11294:                             loc_oPg.txt_4c_Dsittricm.Value = ""
11295:                         ENDIF
11296:                         THIS.this_oBusinessObject.this_cSittricms = ""
11297:                     ENDIF
11298:                     loc_oBusca.Release()
11299:                 ENDIF
11300:                 IF USED("cursor_4c_BuscaIcm")
11301:                     USE IN cursor_4c_BuscaIcm
11302:                 ENDIF
11303:             ENDIF
11304:         CATCH TO loc_oErro
11305:             MsgErro(loc_oErro.Message, "Erro ao buscar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
11306:         ENDTRY
11307:     ENDPROC
11308: 
11309:     *--------------------------------------------------------------------------
11310:     * TxtCodServsFiscLostFocus - Armazena codigo de servicos no BO
11311:     *--------------------------------------------------------------------------
11312:     PROCEDURE TxtCodServsFiscLostFocus()
11313:         LOCAL loc_oPg
11314:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11315:             RETURN
11316:         ENDIF
11317:         TRY
11318:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11319:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11320:                 IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
11321:                     THIS.this_oBusinessObject.this_cCodservs = ALLTRIM(NVL(loc_oPg.txt_4c_CodServs.Value, ""))
11322:                 ENDIF
11323:             ENDIF
11324:         CATCH TO loc_oErro
11325:             MsgErro(loc_oErro.Message, "Erro ao atualizar c" + CHR(243) + "digo de servi" + CHR(231) + "os")
11326:         ENDTRY
11327:     ENDPROC
11328: 
11329:     *--------------------------------------------------------------------------
11330:     * TxtTpTribFiscLostFocus - Lookup SigPrTri por Tipos (tipo tributacao)
11331:     *--------------------------------------------------------------------------
11332:     PROCEDURE TxtTpTribFiscLostFocus()
11333:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11334:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11335:             RETURN
11336:         ENDIF
11337:         loc_lResultado = .T.
11338:         TRY
11339:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11340:                 loc_lResultado = .F.
11341:             ENDIF
11342:             IF loc_lResultado
11343:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11344:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_TpTrib.Value, ""))
11345:                 IF EMPTY(loc_cCod)
11346:                     THIS.this_oBusinessObject.this_cTptribs = ""
11347:                     loc_lResultado = .F.
11348:                 ENDIF
11349:             ENDIF
11350:             IF loc_lResultado
11351:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11352:                     "SigPrTri", "cursor_4c_BuscaTri", "Tipos", loc_cCod, ;
11353:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11354:                 IF VARTYPE(loc_oBusca) = "O"
11355:                     IF !loc_oBusca.this_lAchouRegistro
11356:                         loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11357:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11358:                         loc_oBusca.Show()
11359:                     ENDIF
11360:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
11361:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(NVL(cursor_4c_BuscaTri.Tipos, ""))
11362:                         THIS.this_oBusinessObject.this_cTptribs = loc_oPg.txt_4c_TpTrib.Value
11363:                     ELSE
11364:                         loc_oPg.txt_4c_TpTrib.Value = ""
11365:                         THIS.this_oBusinessObject.this_cTptribs = ""
11366:                     ENDIF
11367:                     loc_oBusca.Release()
11368:                 ENDIF
11369:                 IF USED("cursor_4c_BuscaTri")
11370:                     USE IN cursor_4c_BuscaTri
11371:                 ENDIF
11372:             ENDIF
11373:         CATCH TO loc_oErro
11374:             MsgErro(loc_oErro.Message, "Erro ao buscar tipo de tributa" + CHR(231) + CHR(227) + "o")
11375:         ENDTRY
11376:     ENDPROC
11377: 
11378:     *--------------------------------------------------------------------------
11379:     * TxtIatFiscLostFocus - Valida IAT: apenas 'A', 'T' ou vazio
11380:     *--------------------------------------------------------------------------
11381:     PROCEDURE TxtIatFiscLostFocus()
11382:         LOCAL loc_oPg, loc_cVal
11383:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11384:             RETURN
11385:         ENDIF
11386:         TRY
11387:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11388:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11389:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
11390:                     loc_cVal = UPPER(ALLTRIM(NVL(loc_oPg.txt_4c_Iat.Value, "")))
11391:                     IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "A", "T")
11392:                         MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
11393:                             "Digite [A] Arredondamento ou [T] Truncamento!", "IAT")
11394:                         loc_oPg.txt_4c_Iat.Value = ""
11395:                         THIS.this_oBusinessObject.this_cIats = ""
11396:                     ELSE
11397:                         THIS.this_oBusinessObject.this_cIats = loc_cVal
11398:                     ENDIF
11399:                 ENDIF
11400:             ENDIF
11401:         CATCH TO loc_oErro
11402:             MsgErro(loc_oErro.Message, "Erro ao validar IAT")
11403:         ENDTRY
11404:     ENDPROC
11405: 
11406:     *--------------------------------------------------------------------------
11407:     * TxtMvalorFiscLostFocus - Lookup SigCdMoe por CMoes (moeda do valor)
11408:     *--------------------------------------------------------------------------
11409:     PROCEDURE TxtMvalorFiscLostFocus()
11410:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11411:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11412:             RETURN
11413:         ENDIF
11414:         loc_lResultado = .T.
11415:         TRY
11416:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11417:                 loc_lResultado = .F.
11418:             ENDIF
11419:             IF loc_lResultado
11420:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11421:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Mvalor.Value, ""))
11422:                 IF EMPTY(loc_cCod)
11423:                     THIS.this_oBusinessObject.this_cMoedas = ""
11424:                     loc_lResultado = .F.
11425:                 ENDIF
11426:             ENDIF
11427:             IF loc_lResultado
11428:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11429:                     "SigCdMoe", "cursor_4c_BuscaMoeFisc", "cmoes", loc_cCod, ;
11430:                     "Buscar Moeda")
11431:                 IF VARTYPE(loc_oBusca) = "O"
11432:                     IF !loc_oBusca.this_lAchouRegistro
11433:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "d.")
11434:                         loc_oBusca.mAddColuna("dmoes", "", "Moeda")
11435:                         loc_oBusca.Show()
11436:                     ENDIF
11437:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeFisc")
11438:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(NVL(cursor_4c_BuscaMoeFisc.cmoes, ""))
11439:                         THIS.this_oBusinessObject.this_cMoedas = loc_oPg.txt_4c_Mvalor.Value
11440:                     ELSE
11441:                         loc_oPg.txt_4c_Mvalor.Value = ""
11442:                         THIS.this_oBusinessObject.this_cMoedas = ""
11443:                     ENDIF
11444:                     loc_oBusca.Release()
11445:                 ENDIF
11446:                 IF USED("cursor_4c_BuscaMoeFisc")
11447:                     USE IN cursor_4c_BuscaMoeFisc
11448:                 ENDIF
11449:             ENDIF
11450:         CATCH TO loc_oErro
11451:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
11452:         ENDTRY
11453:     ENDPROC
11454: 
11455:     *--------------------------------------------------------------------------
11456:     * TxtMetalFiscLostFocus - Lookup SigCdMtl por Codigos WHERE Tipos='M'
11457:     *--------------------------------------------------------------------------
11458:     PROCEDURE TxtMetalFiscLostFocus()
11459:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
11460:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11461:             RETURN
11462:         ENDIF
11463:         loc_lResultado = .T.
11464:         TRY
11465:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11466:                 loc_lResultado = .F.
11467:             ENDIF
11468:             IF loc_lResultado
11469:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11470:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Metal.Value, ""))
11471:                 IF EMPTY(loc_cCod)
11472:                     THIS.this_oBusinessObject.this_cMetals = ""
11473:                     IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11474:                         loc_oPg.txt_4c_DesMetal.Value = ""
11475:                     ENDIF
11476:                     loc_lResultado = .F.
11477:                 ENDIF
11478:             ENDIF
11479:             IF loc_lResultado
11480:                 *-- Carregar lista de metais (Tipos='M') para lookup
11481:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos = 'M'"
11482:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlM")
11483:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlM")
11484:                     *-- Verificar se codigo existe diretamente
11485:                     SELECT cursor_4c_BuscaMtlM
11486:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11487:                     IF !EOF("cursor_4c_BuscaMtlM")
11488:                         IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11489:                             loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlM.Descs, ""))
11490:                         ENDIF
11491:                         THIS.this_oBusinessObject.this_cMetals = loc_cCod
11492:                     ELSE
11493:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11494:                             "SigCdMtl", "cursor_4c_BuscaMtlSel", "Codigos", loc_cCod, ;
11495:                             "Buscar Metal")
11496:                         IF VARTYPE(loc_oBusca) = "O"
11497:                             IF !loc_oBusca.this_lAchouRegistro
11498:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11499:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11500:                                 loc_oBusca.Show()
11501:                             ENDIF
11502:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtlSel")
11503:                                 loc_oPg.txt_4c_Metal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Codigos, ""))
11504:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11505:                                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Descs, ""))
11506:                                 ENDIF
11507:                                 THIS.this_oBusinessObject.this_cMetals = loc_oPg.txt_4c_Metal.Value
11508:                             ELSE
11509:                                 loc_oPg.txt_4c_Metal.Value = ""
11510:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11511:                                     loc_oPg.txt_4c_DesMetal.Value = ""
11512:                                 ENDIF
11513:                                 THIS.this_oBusinessObject.this_cMetals = ""
11514:                             ENDIF
11515:                             loc_oBusca.Release()
11516:                         ENDIF
11517:                         IF USED("cursor_4c_BuscaMtlSel")
11518:                             USE IN cursor_4c_BuscaMtlSel
11519:                         ENDIF
11520:                     ENDIF
11521:                     USE IN cursor_4c_BuscaMtlM
11522:                 ENDIF
11523:             ENDIF
11524:         CATCH TO loc_oErro
11525:             MsgErro(loc_oErro.Message, "Erro ao buscar metal")
11526:         ENDTRY
11527:     ENDPROC
11528: 
11529:     *--------------------------------------------------------------------------
11530:     * TxtTeorFiscLostFocus - Lookup SigCdMtl por Codigos WHERE Tipos<>'M'
11531:     *--------------------------------------------------------------------------
11532:     PROCEDURE TxtTeorFiscLostFocus()
11533:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
11534:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11535:             RETURN
11536:         ENDIF
11537:         loc_lResultado = .T.
11538:         TRY
11539:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11540:                 loc_lResultado = .F.
11541:             ENDIF
11542:             IF loc_lResultado
11543:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11544:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Teor.Value, ""))
11545:                 IF EMPTY(loc_cCod)
11546:                     THIS.this_oBusinessObject.this_cTeors = ""
11547:                     IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11548:                         loc_oPg.txt_4c_DesTeor.Value = ""
11549:                     ENDIF
11550:                     loc_lResultado = .F.
11551:                 ENDIF
11552:             ENDIF
11553:             IF loc_lResultado
11554:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos <> 'M'"
11555:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlT")
11556:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlT")
11557:                     SELECT cursor_4c_BuscaMtlT
11558:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11559:                     IF !EOF("cursor_4c_BuscaMtlT")
11560:                         IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11561:                             loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlT.Descs, ""))
11562:                         ENDIF
11563:                         THIS.this_oBusinessObject.this_cTeors = loc_cCod
11564:                     ELSE
11565:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11566:                             "SigCdMtl", "cursor_4c_BuscaTeorSel", "Codigos", loc_cCod, ;
11567:                             "Buscar Teor")
11568:                         IF VARTYPE(loc_oBusca) = "O"
11569:                             IF !loc_oBusca.this_lAchouRegistro
11570:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11571:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11572:                                 loc_oBusca.Show()
11573:                             ENDIF
11574:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTeorSel")
11575:                                 loc_oPg.txt_4c_Teor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Codigos, ""))
11576:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11577:                                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Descs, ""))
11578:                                 ENDIF
11579:                                 THIS.this_oBusinessObject.this_cTeors = loc_oPg.txt_4c_Teor.Value
11580:                             ELSE
11581:                                 loc_oPg.txt_4c_Teor.Value = ""
11582:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11583:                                     loc_oPg.txt_4c_DesTeor.Value = ""
11584:                                 ENDIF
11585:                                 THIS.this_oBusinessObject.this_cTeors = ""
11586:                             ENDIF
11587:                             loc_oBusca.Release()
11588:                         ENDIF
11589:                         IF USED("cursor_4c_BuscaTeorSel")
11590:                             USE IN cursor_4c_BuscaTeorSel
11591:                         ENDIF
11592:                     ENDIF
11593:                     USE IN cursor_4c_BuscaMtlT
11594:                 ENDIF
11595:             ENDIF
11596:         CATCH TO loc_oErro
11597:             MsgErro(loc_oErro.Message, "Erro ao buscar teor")
11598:         ENDTRY
11599:     ENDPROC
11600: 
11601:     *--------------------------------------------------------------------------
11602:     * TxtGruccusFiscLostFocus - Armazena grupo de custo no BO
11603:     *--------------------------------------------------------------------------
11604:     PROCEDURE TxtGruccusFiscLostFocus()
11605:         LOCAL loc_oPg
11606:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11607:             RETURN
11608:         ENDIF
11609:         TRY
11610:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11611:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11612:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
11613:                     THIS.this_oBusinessObject.this_cGruccus = ALLTRIM(NVL(loc_oPg.txt_4c_Gruccus.Value, ""))
11614:                 ENDIF
11615:             ENDIF
11616:         CATCH TO loc_oErro
11617:             MsgErro(loc_oErro.Message, "Erro ao atualizar grupo de custo")
11618:         ENDTRY
11619:     ENDPROC
11620: 
11621:     *--------------------------------------------------------------------------
11622:     * TxtContaccusFiscLostFocus - Armazena conta de custo no BO
11623:     *--------------------------------------------------------------------------
11624:     PROCEDURE TxtContaccusFiscLostFocus()
11625:         LOCAL loc_oPg
11626:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11627:             RETURN
11628:         ENDIF
11629:         TRY
11630:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11631:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11632:                 IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
11633:                     THIS.this_oBusinessObject.this_cContaccus = ALLTRIM(NVL(loc_oPg.txt_4c_Contaccus.Value, ""))
11634:                 ENDIF
11635:             ENDIF
11636:         CATCH TO loc_oErro
11637:             MsgErro(loc_oErro.Message, "Erro ao atualizar conta de custo")
11638:         ENDTRY
11639:     ENDPROC
11640: 
11641:     *--------------------------------------------------------------------------
11642:     * CmdDescFisClick - Gerar Descricao Fiscal automatica
11643:     * Legado: fGerDescFis(0, crSigCdPro.CPros, ThisForm.poDataMgr)
11644:     *--------------------------------------------------------------------------
11645:     PROCEDURE CmdDescFisClick()
11646:         LOCAL loc_oPg, loc_cCpro
11647:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11648:             RETURN
11649:         ENDIF
11650:         TRY
11651:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11652:                 RETURN
11653:             ENDIF
11654:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11655:             loc_cCpro = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11656:             IF EMPTY(loc_cCpro)
11657:                 MsgAviso("Informe o c" + CHR(243) + "digo do produto antes de gerar a descri" + ;
11658:                     CHR(231) + CHR(227) + "o fiscal.", "Aten" + CHR(231) + CHR(227) + "o")
11659:                 RETURN
11660:             ENDIF
11661:             *-- Gerar descricao fiscal a partir dos campos fiscais
11662:             *-- Legado usa fGerDescFis() - funcao de framework nao disponivel
11663:             *-- Implementacao simplificada: combina classificacao + origem + ICMS
11664:             LOCAL loc_cDescFis
11665:             loc_cDescFis = ""
11666:             IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
11667:                 loc_cDescFis = ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, ""))
11668:             ENDIF
11669:             IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O" AND !EMPTY(loc_oPg.txt_4c_Dclfiscal.Value)
11670:                 IF !EMPTY(loc_cDescFis)
11671:                     loc_cDescFis = loc_cDescFis + " - "
11672:                 ENDIF
11673:                 loc_cDescFis = loc_cDescFis + ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
11674:             ENDIF
11675:             IF !EMPTY(loc_cDescFis)
11676:                 IF VARTYPE(loc_oPg.obj_4c_Descfis) = "O"
11677:                     loc_oPg.obj_4c_Descfis.Value = loc_cDescFis
11678:                     THIS.this_oBusinessObject.this_cDescfis = loc_cDescFis
11679:                 ENDIF
11680:             ELSE
11681:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!", "Aten" + CHR(231) + CHR(227) + "o")
11682:             ENDIF
11683:         CATCH TO loc_oErro
11684:             MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
11685:         ENDTRY
11686:     ENDPROC
11687: 
11688:     *==========================================================================
11689:     * FASE 14 - Aba Designer (pgDesigner - Page7 do pgf_4c_Dados)
11690:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner
11691:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11692:     * Controles: 2 grids (4col + 1col), 1 editbox, 1 label, 3 buttons, 1 image, 1 shape
11693:     *==========================================================================
11694:     PROTECTED PROCEDURE ConfigurarPgPgDesigner()
11695:         LOCAL loc_oPg, loc_oGrd
11696:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11697: 
11698:         *----------------------------------------------------------------------
11699:         *-- Cursor placeholder cursor_4c_SigPrTar (SigPrTar - Tarefas Designer)
11700:         *-- Campos: DtInis, DtFims, Usuars, Tarefas, ObsTars
11701:         *----------------------------------------------------------------------
11702:         IF !USED("cursor_4c_SigPrTar")
11703:             SET NULL ON
11704:             CREATE CURSOR cursor_4c_SigPrTar (;
11705:                 DtInis  D NULL, ;
11706:                 DtFims  D NULL, ;
11707:                 Usuars  C(10), ;
11708:                 Tarefas C(10), ;
11709:                 ObsTars M)
11710:             SET NULL OFF
11711:         ENDIF
11712: 
11713:         *----------------------------------------------------------------------
11714:         *-- Cursor placeholder cursor_4c_SigPrArq (SigPrArq - Arquivos Designer)
11715:         *-- Campos: Arquivos
11716:         *----------------------------------------------------------------------
11717:         IF !USED("cursor_4c_SigPrArq")
11718:             SET NULL ON
11719:             CREATE CURSOR cursor_4c_SigPrArq (;
11720:                 Arquivos C(200))
11721:             SET NULL OFF
11722:         ENDIF
11723: 
11724:         *----------------------------------------------------------------------
11725:         *-- Shape1: fundo da area de imagem (T:415 L:584 W:407 H:202)
11726:         *----------------------------------------------------------------------
11727:         loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
11728:         WITH loc_oPg.shp_4c_ArqFundo
11729:             .Top         = 415
11730:             .Left        = 584
11731:             .Width       = 407
11732:             .Height      = 202
11733:             .BackColor   = RGB(230, 230, 230)
11734:             .BorderColor = RGB(180, 180, 180)

*-- Linhas 11822 a 12470:
11822:                 .ReadOnly          = .F.
11823:             ENDWITH
11824:         ENDWITH
11825:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
11826: 
11827:         *----------------------------------------------------------------------
11828:         *-- EditBox getObsTarefas: Obs da Tarefa (T:160 L:584 W:407 H:238)
11829:         *-- ControlSource ? cursor_4c_SigPrTar.ObsTars (sincronizado automaticamente)
11830:         *----------------------------------------------------------------------
11831:         loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
11832:         WITH loc_oPg.obj_4c_ObsTarefas
11833:             .Top              = 160
11834:             .Left             = 584
11835:             .Width            = 407
11836:             .Height           = 238
11837:             .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
11838:             .FontName         = "Tahoma"
11839:             .FontSize         = 8
11840:             .SpecialEffect    = 1
11841:             .ForeColor        = RGB(36, 84, 155)
11842:             .Enabled          = .T.
11843:             .Visible          = .T.
11844:         ENDWITH
11845: 
11846:         *----------------------------------------------------------------------
11847:         *-- btnIniTarefa: Iniciar Tarefa (T:161 L:509 W:42 H:42)
11848:         *----------------------------------------------------------------------
11849:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
11850:         WITH loc_oPg.cmd_4c_IniTarefa
11851:             .Top             = 161
11852:             .Left            = 509
11853:             .Width           = 42
11854:             .Height          = 42
11855:             .Caption         = ""
11856:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.bmp"
11857:             .FontName        = "Tahoma"
11858:             .FontSize        = 8
11859:             .Themes          = .F.
11860:             .ToolTipText     = "Iniciar Nova Tarefa"
11861:             .Enabled         = .F.
11862:             .Visible         = .T.
11863:         ENDWITH
11864:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "Click", THIS, "BtnIniTarefaClick")
11865: 
11866:         *----------------------------------------------------------------------
11867:         *-- btnFimTarefa: Encerrar Tarefa (T:203 L:509 W:42 H:42)
11868:         *----------------------------------------------------------------------
11869:         loc_oPg.AddObject("cmd_4c_FimTarefa", "CommandButton")
11870:         WITH loc_oPg.cmd_4c_FimTarefa
11871:             .Top             = 203
11872:             .Left            = 509
11873:             .Width           = 42
11874:             .Height          = 42
11875:             .Caption         = ""
11876:             .Picture         = gc_4c_CaminhoIcones + "geral_datas_26.bmp"
11877:             .FontName        = "Tahoma"
11878:             .FontSize        = 8
11879:             .Themes          = .F.
11880:             .ToolTipText     = "Encerrar Tarefa"
11881:             .Enabled         = .F.
11882:             .Visible         = .T.
11883:         ENDWITH
11884:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "Click", THIS, "BtnFimTarefaClick")
11885: 
11886:         *----------------------------------------------------------------------
11887:         *-- grdArquivos: Grade de Arquivos (T:415 L:10 W:495 H:202) 1 coluna
11888:         *----------------------------------------------------------------------
11889:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
11890:         WITH loc_oPg.grd_4c_Arquivos
11891:             .Top         = 415
11892:             .Left        = 10
11893:             .Width       = 495
11894:             .Height      = 202
11895:             .ColumnCount = 1
11896:             .FontName    = "Tahoma"
11897:             .FontSize    = 8
11898:             .DeleteMark  = .F.
11899:             .ScrollBars  = 2
11900:             .ReadOnly    = .T.
11901:             .Themes      = .F.
11902:             .Visible     = .T.
11903:             .RecordMark   = .F.
11904:         ENDWITH
11905:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_SigPrArq"
11906:         WITH loc_oPg.grd_4c_Arquivos
11907:             WITH .Column1
11908:                 .ControlSource     = "cursor_4c_SigPrArq.Arquivos"
11909:                 .Header1.Caption   = "Arquivos Para Designer"
11910:                 .Header1.FontName  = "Tahoma"
11911:                 .Header1.FontSize  = 8
11912:                 .Header1.Alignment = 2
11913:                 .Width             = 464
11914:                 .Movable           = .F.
11915:                 .Resizable         = .F.
11916:                 .ReadOnly          = .T.
11917:             ENDWITH
11918:         ENDWITH
11919:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
11920: 
11921:         *----------------------------------------------------------------------
11922:         *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
11923:         *----------------------------------------------------------------------
11924:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
11925:         WITH loc_oPg.cmd_4c_InsArqs
11926:             .Top             = 416
11927:             .Left            = 509
11928:             .Width           = 42
11929:             .Height          = 42
11930:             .Caption         = ""
11931:             .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_26.bmp"
11932:             .FontName        = "Tahoma"
11933:             .FontSize        = 8
11934:             .Themes          = .F.
11935:             .ToolTipText     = "Inserir Arquivo"
11936:             .Enabled         = .F.
11937:             .Visible         = .T.
11938:         ENDWITH
11939:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")
11940: 
11941:         *----------------------------------------------------------------------
11942:         *-- btnOpnArqs: Abrir Arquivo (T:500 L:509 W:42 H:42)
11943:         *----------------------------------------------------------------------
11944:         loc_oPg.AddObject("cmd_4c_OpnArqs", "CommandButton")
11945:         WITH loc_oPg.cmd_4c_OpnArqs
11946:             .Top             = 500
11947:             .Left            = 509
11948:             .Width           = 42
11949:             .Height          = 42
11950:             .Caption         = ""
11951:             .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.bmp"
11952:             .FontName        = "Tahoma"
11953:             .FontSize        = 8
11954:             .Themes          = .F.
11955:             .ToolTipText     = "Abrir Arquivo"
11956:             .Enabled         = .T.
11957:             .Visible         = .T.
11958:         ENDWITH
11959:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "Click", THIS, "BtnOpnArqsClick")
11960: 
11961:         *----------------------------------------------------------------------
11962:         *-- btnExcArqs: Excluir Arquivo (T:458 L:509 W:42 H:42)
11963:         *----------------------------------------------------------------------
11964:         loc_oPg.AddObject("cmd_4c_ExcArqs", "CommandButton")
11965:         WITH loc_oPg.cmd_4c_ExcArqs
11966:             .Top             = 458
11967:             .Left            = 509
11968:             .Width           = 42
11969:             .Height          = 42
11970:             .Caption         = ""
11971:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.bmp"
11972:             .FontName        = "Tahoma"
11973:             .FontSize        = 8
11974:             .Themes          = .F.
11975:             .ToolTipText     = "Excluir Arquivo"
11976:             .Enabled         = .F.
11977:             .Visible         = .T.
11978:         ENDWITH
11979:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "Click", THIS, "BtnExcArqsClick")
11980: 
11981:         *----------------------------------------------------------------------
11982:         *-- imgArqJpg: Imagem do arquivo (T:417 L:586 W:403 H:198)
11983:         *----------------------------------------------------------------------
11984:         loc_oPg.AddObject("img_4c_ArqJpg", "Image")
11985:         WITH loc_oPg.img_4c_ArqJpg
11986:             .Top         = 417
11987:             .Left        = 586
11988:             .Width       = 403
11989:             .Height      = 198
11990:             .Stretch     = 1
11991:             .Visible     = .F.
11992:             .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
11993:         ENDWITH
11994:         BINDEVENT(loc_oPg.img_4c_ArqJpg, "Click", THIS, "ImgArqJpgClick")
11995: 
11996:         *----------------------------------------------------------------------
11997:         *-- Bindings When / Valid / LostFocus para Column4 (campo Tarefa)
11998:         *----------------------------------------------------------------------
11999:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
12000:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
12001:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "LostFocus", THIS, "GrdDesignerCol4LostFocus")
12002: 
12003:         *----------------------------------------------------------------------
12004:         *-- Binding When para EditBox Obs da Tarefa
12005:         *----------------------------------------------------------------------
12006:         BINDEVENT(loc_oPg.obj_4c_ObsTarefas, "When", THIS, "ObsTarefasWhen")
12007: 
12008:         *----------------------------------------------------------------------
12009:         *-- Bindings When para botoes de tarefa
12010:         *----------------------------------------------------------------------
12011:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "When", THIS, "BtnIniTarefaWhen")
12012:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "When", THIS, "BtnFimTarefaWhen")
12013: 
12014:         *----------------------------------------------------------------------
12015:         *-- Binding When para Column1 do grdArquivos
12016:         *----------------------------------------------------------------------
12017:         BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")
12018: 
12019:         *----------------------------------------------------------------------
12020:         *-- Bindings When para botoes de arquivo
12021:         *----------------------------------------------------------------------
12022:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "When", THIS, "BtnInsArqsWhen")
12023:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "When", THIS, "BtnOpnArqsWhen")
12024:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "When", THIS, "BtnExcArqsWhen")
12025:     ENDPROC
12026: 
12027:     *--------------------------------------------------------------------------
12028:     * GrdDesignerAfterRowColChange - Atualiza EditBox Obs ao mudar linha da grade
12029:     * Legado: grdDesigner.Procedure (AfterRowColChange) ? refresh getObsTarefas
12030:     *--------------------------------------------------------------------------
12031:     PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
12032:         LOCAL loc_oPg
12033:         TRY
12034:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12035:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12036:                 IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12037:                     *-- Sincronizar editbox com observacao da tarefa selecionada
12038:                     IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
12039:                         loc_oPg.obj_4c_ObsTarefas.Value = NVL(cursor_4c_SigPrTar.ObsTars, "")
12040:                     ELSE
12041:                         loc_oPg.obj_4c_ObsTarefas.Value = ""
12042:                     ENDIF
12043:                     loc_oPg.obj_4c_ObsTarefas.Refresh()
12044:                 ENDIF
12045:             ENDIF
12046:         CATCH TO loc_oErro
12047:             MsgErro(loc_oErro.Message, "Erro ao atualizar observa" + CHR(231) + CHR(227) + "o da tarefa")
12048:         ENDTRY
12049:     ENDPROC
12050: 
12051:     *--------------------------------------------------------------------------
12052:     * GrdArquivosAfterRowColChange - Mostra imagem do arquivo selecionado
12053:     * Legado: grdArquivos.Procedure (AfterRowColChange) ? mostra imagem JPG/BMP
12054:     *--------------------------------------------------------------------------
12055:     PROCEDURE GrdArquivosAfterRowColChange(par_nColIndex)
12056:         LOCAL loc_oPg, loc_cArq, loc_cExt
12057:         TRY
12058:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
12059:                 RETURN
12060:             ENDIF
12061:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12062:             IF VARTYPE(loc_oPg.img_4c_ArqJpg) # "O"
12063:                 RETURN
12064:             ENDIF
12065:             CLEAR RESOURCES
12066:             loc_oPg.img_4c_ArqJpg.Picture = ""
12067:             loc_oPg.img_4c_ArqJpg.Visible = .F.
12068:             IF USED("cursor_4c_SigPrArq") AND !EOF("cursor_4c_SigPrArq")
12069:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
12070:                 IF !EMPTY(loc_cArq) AND AT(".", loc_cArq) > 0
12071:                     loc_cExt = UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq)))
12072:                     IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
12073:                         loc_oPg.img_4c_ArqJpg.Picture  = loc_cArq
12074:                         loc_oPg.img_4c_ArqJpg.Visible  = .T.
12075:                     ENDIF
12076:                 ENDIF
12077:             ENDIF
12078:         CATCH TO loc_oErro
12079:             MsgErro(loc_oErro.Message, "Erro ao exibir imagem do arquivo")
12080:         ENDTRY
12081:     ENDPROC
12082: 
12083:     *--------------------------------------------------------------------------
12084:     * BtnIniTarefaClick - Inicia nova tarefa para o usuario logado
12085:     * Legado: btnIniTarefa.Click - verifica tarefa nao encerrada, insere novo registro
12086:     *--------------------------------------------------------------------------
12087:     PROCEDURE BtnIniTarefaClick()
12088:         LOCAL loc_lResultado
12089:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12090:             RETURN
12091:         ENDIF
12092:         loc_lResultado = .T.
12093:         TRY
12094:             IF !USED("cursor_4c_SigPrTar")
12095:                 loc_lResultado = .F.
12096:             ENDIF
12097:             IF loc_lResultado
12098:                 *-- Verificar se existe tarefa nao encerrada para este usuario
12099:                 SELECT cursor_4c_SigPrTar
12100:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12101:                     AND EMPTY(NVL(DtFims, {}))
12102:                 IF !EOF("cursor_4c_SigPrTar")
12103:                     MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
12104:                         CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12105:                     loc_lResultado = .F.
12106:                 ENDIF
12107:             ENDIF
12108:             IF loc_lResultado
12109:                 *-- Verificar se existe tarefa sem codigo informado
12110:                 SELECT cursor_4c_SigPrTar
12111:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12112:                     AND EMPTY(Tarefas)
12113:                 IF !EOF("cursor_4c_SigPrTar")
12114:                     MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", "Aten" + CHR(231) + CHR(227) + "o")
12115:                     loc_lResultado = .F.
12116:                 ENDIF
12117:             ENDIF
12118:             IF loc_lResultado
12119:                 *-- Inserir nova tarefa com data/hora de inicio
12120:                 SELECT cursor_4c_SigPrTar
12121:                 APPEND BLANK
12122:                 REPLACE cursor_4c_SigPrTar.DtInis  WITH DATE()
12123:                 REPLACE cursor_4c_SigPrTar.Usuars  WITH PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
12124:                 REPLACE cursor_4c_SigPrTar.Tarefas WITH ""
12125:                 REPLACE cursor_4c_SigPrTar.ObsTars WITH ""
12126:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12127:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12128:                 ENDIF
12129:             ENDIF
12130:         CATCH TO loc_oErro
12131:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12132:         ENDTRY
12133:     ENDPROC
12134: 
12135:     *--------------------------------------------------------------------------
12136:     * BtnFimTarefaClick - Encerra tarefa do usuario logado
12137:     * Legado: btnFimTarefa.Click - valida usuario e data, replace DtFims
12138:     *--------------------------------------------------------------------------
12139:     PROCEDURE BtnFimTarefaClick()
12140:         LOCAL loc_lResultado
12141:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12142:             RETURN
12143:         ENDIF
12144:         loc_lResultado = .T.
12145:         TRY
12146:             IF !USED("cursor_4c_SigPrTar") OR EOF("cursor_4c_SigPrTar")
12147:                 loc_lResultado = .F.
12148:             ENDIF
12149:             IF loc_lResultado
12150:                 IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) # ALLTRIM(gc_4c_UsuarioLogado)
12151:                     MsgAviso("Essa tarefa n" + CHR(227) + "o pertence a esse usu" + CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12152:                     loc_lResultado = .F.
12153:                 ENDIF
12154:             ENDIF
12155:             IF loc_lResultado
12156:                 IF !EMPTY(cursor_4c_SigPrTar.DtFims)
12157:                     MsgAviso("Essa tarefa j" + CHR(225) + " se encontra finalizada!", "Aten" + CHR(231) + CHR(227) + "o")
12158:                     loc_lResultado = .F.
12159:                 ENDIF
12160:             ENDIF
12161:             IF loc_lResultado
12162:                 SELECT cursor_4c_SigPrTar
12163:                 REPLACE cursor_4c_SigPrTar.DtFims WITH DATE()
12164:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12165:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12166:                 ENDIF
12167:             ENDIF
12168:         CATCH TO loc_oErro
12169:             MsgErro(loc_oErro.Message, "Erro ao encerrar tarefa")
12170:         ENDTRY
12171:     ENDPROC
12172: 
12173:     *--------------------------------------------------------------------------
12174:     * BtnInsArqsClick - Seleciona e insere arquivo na lista de arquivos designer
12175:     * Legado: btnInsArqs.Click - GETFILE + INSERT INTO crSigPrArq
12176:     *--------------------------------------------------------------------------
12177:     PROCEDURE BtnInsArqsClick()
12178:         LOCAL loc_cArq, loc_lResultado
12179:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12180:             RETURN
12181:         ENDIF
12182:         loc_lResultado = .T.
12183:         TRY
12184:             loc_cArq = GETFILE("*.*", "Selecione o Arquivo", "Selecione o Arquivo", 0)
12185:             IF EMPTY(loc_cArq)
12186:                 loc_lResultado = .F.
12187:             ENDIF
12188:             IF loc_lResultado AND USED("cursor_4c_SigPrArq")
12189:                 SELECT cursor_4c_SigPrArq
12190:                 APPEND BLANK
12191:                 REPLACE cursor_4c_SigPrArq.Arquivos WITH UPPER(ALLTRIM(loc_cArq))
12192:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12193:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12194:                 ENDIF
12195:             ENDIF
12196:         CATCH TO loc_oErro
12197:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12198:         ENDTRY
12199:     ENDPROC
12200: 
12201:     *--------------------------------------------------------------------------
12202:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao do SO
12203:     * Legado: btnOpnArqs.Click - Shell.Application.Open(lcArq)
12204:     *--------------------------------------------------------------------------
12205:     PROCEDURE BtnOpnArqsClick()
12206:         LOCAL loc_cArq, loc_oApp, loc_lResultado
12207:         loc_lResultado = .T.
12208:         TRY
12209:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12210:                 loc_lResultado = .F.
12211:             ENDIF
12212:             IF loc_lResultado
12213:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
12214:                 IF EMPTY(loc_cArq)
12215:                     loc_lResultado = .F.
12216:                 ENDIF
12217:             ENDIF
12218:             IF loc_lResultado
12219:                 IF !FILE(loc_cArq)
12220:                     MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArq, "Aten" + CHR(231) + CHR(227) + "o")
12221:                     loc_lResultado = .F.
12222:                 ENDIF
12223:             ENDIF
12224:             IF loc_lResultado
12225:                 loc_oApp = CREATEOBJECT("Shell.Application")
12226:                 IF VARTYPE(loc_oApp) = "O"
12227:                     loc_oApp.Open(loc_cArq)
12228:                 ENDIF
12229:             ENDIF
12230:         CATCH TO loc_oErro
12231:             MsgErro(loc_oErro.Message, "Erro ao abrir arquivo")
12232:         ENDTRY
12233:     ENDPROC
12234: 
12235:     *--------------------------------------------------------------------------
12236:     * BtnExcArqsClick - Exclui arquivo da lista de arquivos designer
12237:     * Legado: btnExcArqs.Click - Delete In crSigPrArq + Refresh
12238:     *--------------------------------------------------------------------------
12239:     PROCEDURE BtnExcArqsClick()
12240:         LOCAL loc_lResultado
12241:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12242:             RETURN
12243:         ENDIF
12244:         loc_lResultado = .T.
12245:         TRY
12246:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12247:                 loc_lResultado = .F.
12248:             ENDIF
12249:             IF loc_lResultado
12250:                 IF EMPTY(ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, "")))
12251:                     loc_lResultado = .F.
12252:                 ENDIF
12253:             ENDIF
12254:             IF loc_lResultado
12255:                 SELECT cursor_4c_SigPrArq
12256:                 DELETE
12257:                 IF !EOF("cursor_4c_SigPrArq")
12258:                     SKIP
12259:                     SKIP -1
12260:                 ENDIF
12261:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12262:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12263:                 ENDIF
12264:                 *-- Limpar imagem ao excluir arquivo
12265:                 LOCAL loc_oPg
12266:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12267:                 IF VARTYPE(loc_oPg.img_4c_ArqJpg) = "O"
12268:                     CLEAR RESOURCES
12269:                     loc_oPg.img_4c_ArqJpg.Picture = ""
12270:                     loc_oPg.img_4c_ArqJpg.Visible = .F.
12271:                 ENDIF
12272:             ENDIF
12273:         CATCH TO loc_oErro
12274:             MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
12275:         ENDTRY
12276:     ENDPROC
12277: 
12278:     *--------------------------------------------------------------------------
12279:     * ImgArqJpgClick - Abre imagem em modo zoom (form SigOpZom)
12280:     * Legado: imgArqJpg.Click - Do Form SigOpZom With lcArq, "Arquivo : " + lcArq
12281:     *--------------------------------------------------------------------------
12282:     PROCEDURE ImgArqJpgClick()
12283:         LOCAL loc_cArq, loc_cExt, loc_lResultado
12284:         loc_lResultado = .T.
12285:         TRY
12286:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12287:                 loc_lResultado = .F.
12288:             ENDIF
12289:             IF loc_lResultado
12290:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
12291:                 IF EMPTY(loc_cArq) OR !FILE(loc_cArq)
12292:                     loc_lResultado = .F.
12293:                 ENDIF
12294:             ENDIF
12295:             IF loc_lResultado
12296:                 IF AT(".", loc_cArq) > 0
12297:                     loc_cExt = UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq)))
12298:                     IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
12299:                         *-- Tentar abrir zoom form se disponivel
12300:                         IF PEMSTATUS("FormSigOpZom", "NAME", 5) OR FILE(gc_4c_CaminhoForms + "SigOpZom.prg")
12301:                             DO FORM (gc_4c_CaminhoForms + "SigOpZom") WITH loc_cArq, "Arquivo : " + loc_cArq
12302:                         ELSE
12303:                             *-- Fallback: abrir com aplicativo padrao do SO
12304:                             LOCAL loc_oApp
12305:                             loc_oApp = CREATEOBJECT("Shell.Application")
12306:                             IF VARTYPE(loc_oApp) = "O"
12307:                                 loc_oApp.Open(loc_cArq)
12308:                             ENDIF
12309:                         ENDIF
12310:                     ENDIF
12311:                 ENDIF
12312:             ENDIF
12313:         CATCH TO loc_oErro
12314:             MsgErro(loc_oErro.Message, "Erro ao abrir imagem em zoom")
12315:         ENDTRY
12316:     ENDPROC
12317: 
12318:     *--------------------------------------------------------------------------
12319:     * GrdDesignerCol4When - Permite edicao somente para usuario dono da tarefa nao finalizada
12320:     * Legado: grdDesigner.Column4.Text1.When
12321:     *--------------------------------------------------------------------------
12322:     PROCEDURE GrdDesignerCol4When()
12323:         LOCAL loc_lResult
12324:         loc_lResult = .F.
12325:         TRY
12326:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12327:                 IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
12328:                     IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12329:                         AND EMPTY(cursor_4c_SigPrTar.DtFims)
12330:                         loc_lResult = .T.
12331:                     ENDIF
12332:                 ENDIF
12333:             ENDIF
12334:         CATCH TO loc_oErro
12335:             MsgErro(loc_oErro.Message, "Erro ao verificar permiss" + CHR(227) + "o de edi" + CHR(231) + CHR(227) + "o")
12336:         ENDTRY
12337:         RETURN loc_lResult
12338:     ENDPROC
12339: 
12340:     *--------------------------------------------------------------------------
12341:     * GrdDesignerCol4Valid - Valida codigo de tarefa, abre lookup se nao encontrado
12342:     * Legado: grdDesigner.Column4.Text1.Valid - fwBuscaInt crTarefas CodCads/DesCads
12343:     *--------------------------------------------------------------------------
12344:     PROCEDURE GrdDesignerCol4Valid()
12345:         LOCAL loc_lResult, loc_cCodigo, loc_oBusca, loc_oPg
12346:         loc_lResult = .T.
12347:         TRY
12348:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
12349:                 loc_lResultado = .T.
12350:             ENDIF
12351:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12352:             loc_cCodigo = ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, ""))
12353:             IF !EMPTY(loc_cCodigo)
12354:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
12355:                     "sigcdtar", "cursor_4c_BuscaTar", "codcads", loc_cCodigo, ;
12356:                     "Buscar Tarefa")
12357:                 IF VARTYPE(loc_oBusca) = "O"
12358:                     IF !loc_oBusca.this_lAchouRegistro
12359:                         loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "d.")
12360:                         loc_oBusca.mAddColuna("descads", "", "Descri" + CHR(231) + CHR(227) + "o")
12361:                         loc_oBusca.Show()
12362:                     ENDIF
12363:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
12364:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ALLTRIM(NVL(cursor_4c_BuscaTar.codcads, ""))
12365:                     ELSE
12366:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ""
12367:                     ENDIF
12368:                     loc_oBusca.Release()
12369:                 ENDIF
12370:                 IF USED("cursor_4c_BuscaTar")
12371:                     USE IN cursor_4c_BuscaTar
12372:                 ENDIF
12373:             ENDIF
12374:         CATCH TO loc_oErro
12375:             MsgErro(loc_oErro.Message, "Erro ao validar tarefa")
12376:         ENDTRY
12377:         RETURN loc_lResult
12378:     ENDPROC
12379: 
12380:     *--------------------------------------------------------------------------
12381:     * GrdDesignerCol4LostFocus - Ao sair com Enter de tarefa nao vazia, foca ObsTarefas
12382:     * Legado: grdDesigner.Column4.Text1.LostFocus
12383:     *--------------------------------------------------------------------------
12384:     PROCEDURE GrdDesignerCol4LostFocus()
12385:         LOCAL loc_oPg
12386:         TRY
12387:             IF LASTKEY() = 13
12388:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12389:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12390:                     IF VARTYPE(loc_oPg.grd_4c_Designer.Column4.Text1) = "O"
12391:                         IF !EMPTY(ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, "")))
12392:                             IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12393:                                 loc_oPg.obj_4c_ObsTarefas.SetFocus()
12394:                             ENDIF
12395:                         ENDIF
12396:                     ENDIF
12397:                 ENDIF
12398:             ENDIF
12399:         CATCH TO loc_oErro
12400:             MsgErro(loc_oErro.Message, "Erro ao mover foco para observa" + CHR(231) + CHR(227) + "o")
12401:         ENDTRY
12402:     ENDPROC
12403: 
12404:     *--------------------------------------------------------------------------
12405:     * ObsTarefasWhen - Permite edicao somente em INCLUIR/ALTERAR
12406:     * Legado: getObsTarefas.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12407:     *--------------------------------------------------------------------------
12408:     PROCEDURE ObsTarefasWhen()
12409:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12410:     ENDPROC
12411: 
12412:     *--------------------------------------------------------------------------
12413:     * BtnIniTarefaWhen - Habilita botao Iniciar Tarefa somente em INCLUIR/ALTERAR
12414:     * Legado: btnIniTarefa.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12415:     *--------------------------------------------------------------------------
12416:     PROCEDURE BtnIniTarefaWhen()
12417:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12418:     ENDPROC
12419: 
12420:     *--------------------------------------------------------------------------
12421:     * BtnFimTarefaWhen - Habilita botao Encerrar Tarefa somente em INCLUIR/ALTERAR
12422:     * Legado: btnFimTarefa.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12423:     *--------------------------------------------------------------------------
12424:     PROCEDURE BtnFimTarefaWhen()
12425:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12426:     ENDPROC
12427: 
12428:     *--------------------------------------------------------------------------
12429:     * GrdArquivosCol1When - Permite foco em Column1 somente em INCLUIR/ALTERAR
12430:     * Legado: grdArquivos.Column1.Text1.When
12431:     *--------------------------------------------------------------------------
12432:     PROCEDURE GrdArquivosCol1When()
12433:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12434:     ENDPROC
12435: 
12436:     *--------------------------------------------------------------------------
12437:     * BtnInsArqsWhen - Habilita botao Inserir Arquivo somente em INCLUIR/ALTERAR
12438:     * Legado: btnInsArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12439:     *--------------------------------------------------------------------------
12440:     PROCEDURE BtnInsArqsWhen()
12441:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12442:     ENDPROC
12443: 
12444:     *--------------------------------------------------------------------------
12445:     * BtnOpnArqsWhen - Habilita botao Abrir Arquivo sempre
12446:     * Legado: btnOpnArqs.When - Return .t.
12447:     *--------------------------------------------------------------------------
12448:     PROCEDURE BtnOpnArqsWhen()
12449:         RETURN .T.
12450:     ENDPROC
12451: 
12452:     *--------------------------------------------------------------------------
12453:     * BtnExcArqsWhen - Habilita botao Excluir Arquivo somente em INCLUIR/ALTERAR
12454:     * Legado: btnExcArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12455:     *--------------------------------------------------------------------------
12456:     PROCEDURE BtnExcArqsWhen()
12457:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12458:     ENDPROC
12459: 
12460:     *--------------------------------------------------------------------------
12461:     * Destroy - Liberar recursos
12462:     *--------------------------------------------------------------------------
12463:     PROCEDURE Destroy()
12464:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
12465:             THIS.this_oBusinessObject = .NULL.
12466:         ENDIF
12467:         DODEFAULT()
12468:     ENDPROC
12469: 
12470: ENDDEFINE

