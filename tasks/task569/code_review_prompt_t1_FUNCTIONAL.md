# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (23)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=8 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Dados' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_DadosTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Dados' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_DadosTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-HEADER] Header Caption 'Total ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Grp, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Arquivos Para Designer, Data de Início, Data de Conclusão, Tarefa, Serviços, Código, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Total ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Grp, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Arquivos Para Designer, Data de Início, Data de Conclusão, Tarefa, Serviços, Código, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Top original=32 vs migrado 'lbl_4c_Label19' Top=504 (diff=472px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Left original=49 vs migrado 'lbl_4c_Label19' Left=18 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Left original=102 vs migrado 'obj_4c_Opc_situacao' Left=758 (diff=656px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=85 vs migrado 'cnt_4c_Botoes' Top=29 (diff=56px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=9 vs migrado 'cnt_4c_Botoes' Left=542 (diff=533px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Top original=5 vs migrado 'lbl_4c_Label8' Top=355 (diff=350px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Left original=8 vs migrado 'lbl_4c_Label8' Left=263 (diff=255px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=121 vs migrado 'lbl_4c_Label2' Top=305 (diff=184px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=47 vs migrado 'lbl_4c_Label2' Left=88 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAcabamento' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=374 vs migrado 'lbl_4c_LblAcabamento' Top=333 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=330 vs migrado 'obj_4c_Fwoption1' Top=123 (diff=207px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=899 vs migrado 'obj_4c_Fwoption1' Left=204 (diff=695px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GradeGRUPO' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=41 vs migrado 'grd_4c_GradeGrupo2' Top=468 (diff=427px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GradeGRUPO' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=619 vs migrado 'grd_4c_GradeGrupo2' Left=35 (diff=584px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'excluir' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=950 vs migrado 'cmd_4c_Excluir' Left=230 (diff=720px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=87 vs migrado 'lbl_4c_Label9' Left=756 (diff=669px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=308 vs migrado 'obj_4c_Fwoption1' Top=123 (diff=185px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (8398 linhas total):

*-- Linhas 5 a 173:
5: * ESTRUTURA DE NAVEGACAO (transcrita do legado - Erro178):
6: *   pgf_4c_Paginas  (externo)  Page1 = Lista / Page2 = Dados
7: *   pgf_4c_Divisoes (interno, dentro da Page2) 8 abas SEM barra de abas
8: *   opt_4c_Navegacao (OptionGroup de 8 botoes graficos) e quem troca de aba
9: *
10: * O legado esconde as abas do PageFrame interno empurrando-o para cima
11: * (pgframeDados.Top = -58, altura da barra de 2 linhas de abas = 58). Aqui a
12: * barra e desligada (Tabs = .F.) e o Top compensa os mesmos 58 pixels, de forma
13: * que os controles das abas usam as coordenadas do layout.json SEM deslocamento.
14: *==============================================================================
15: 
16: DEFINE CLASS FormProduto AS FormBase
17: 
18:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY: valores EXATOS do SCX legado)
19:     Height      = 600
20:     Width       = 1010
21:     Caption     = "Cadastro de Produtos"
22:     AutoCenter  = .T.
23:     ShowWindow  = 1
24:     WindowType  = 1
25:     ControlBox  = .F.
26:     TitleBar    = 0
27:     Themes      = .F.
28:     BorderStyle = 2
29: 
30:     *-- DataSession = 2 (sessao privada, igual ao legado). FormBase.Init()
31:     *-- reaplica SET DATE BRITISH / SET CENTURY ON, que a sessao privada reseta.
32:     DataSession = 2
33: 
34:     *-- Propriedades de estado
35:     this_oBusinessObject      = .NULL.
36:     this_cModoAtual           = "LISTA"
37:     this_nDivisaoAtual        = 1        && Aba ativa do pgf_4c_Divisoes (1..8)
38:     this_cUltimoGrupoValidado = ""       && Guarda de reentrancia do filtro de grupo (regra #45)
39: 
40:     *-- ThisForm.Tipo2 do legado: quando .T. a tela opera sobre SigCdPrc
41:     *-- (produtos de custo) em vez de SigCdPro. O legado recebe isso pelo 3o
42:     *-- parametro do Init (prTp2); o form migrado abre sempre pelo menu, logo
43:     *-- .F. - a property existe para o Do Case da busca por exemplo continuar
44:     *-- com a MESMA estrutura do msv_procurar.
45:     this_lTipo2               = .F.
46: 
47:     *===========================================================================
48:     * Init - Inicializa o formulario
49:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada
50:     *===========================================================================
51:     PROCEDURE Init()
52:         RETURN DODEFAULT()
53:     ENDPROC
54: 
55:     *===========================================================================
56:     * InicializarForm - Cria o Business Object e monta a estrutura visual
57:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
58:     *===========================================================================
59:     PROTECTED PROCEDURE InicializarForm()
60:         LOCAL loc_lSucesso, loException
61:         loc_lSucesso = .F.
62: 
63:         TRY
64:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
65: 
66:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
67:                 MostrarErro("Erro ao criar ProdutoBO" + CHR(13) + ;
68:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
69:                     "FormProduto.InicializarForm")
70:             ELSE
71:                 THIS.ConfigurarPageFrame()
72: 
73:                 THIS.pgf_4c_Paginas.Visible    = .T.
74:                 THIS.pgf_4c_Paginas.ActivePage = 1
75: 
76:                 THIS.this_cModoAtual    = "LISTA"
77:                 THIS.this_nDivisaoAtual = 1
78: 
79:                 loc_lSucesso = .T.
80:             ENDIF
81: 
82:         CATCH TO loException
83:             MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + ;
84:                 loException.Message + CHR(13) + ;
85:                 "Linha: " + TRANSFORM(loException.LineNo), ;
86:                 "FormProduto.InicializarForm")
87:             loc_lSucesso = .F.
88:         ENDTRY
89: 
90:         RETURN loc_lSucesso
91:     ENDPROC
92: 
93:     *===========================================================================
94:     * ConfigurarPageFrame - PageFrame externo: Page1 (Lista) e Page2 (Dados)
95:     * Legado: Pagina.Top = -24 / Height = 635 / Width = 1013 (abas escondidas)
96:     * Canonico do projeto: Top = -29 e Tabs = .F.; controles das Pages compensam
97:     * +29 no Top (o resultado absoluto e identico ao do legado).
98:     *===========================================================================
99:     PROTECTED PROCEDURE ConfigurarPageFrame()
100:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
101: 
102:         WITH THIS.pgf_4c_Paginas
103:             .PageCount = 2
104:             .Top       = -29
105:             .Left      = 0
106:             .Width     = THIS.Width
107:             .Height    = THIS.Height + 29
108:             .Tabs      = .F.
109:             .Visible   = .T.
110: 
111:             .Page1.Caption   = "Lista"
112:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113:             .Page1.BackColor = RGB(255, 255, 255)
114: 
115:             .Page2.Caption   = "Dados"
116:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117:             .Page2.BackColor = RGB(255, 255, 255)
118:         ENDWITH
119: 
120:         THIS.ConfigurarPaginaLista()
121:         THIS.ConfigurarPaginaDados()
122:     ENDPROC
123: 
124:     *===========================================================================
125:     * ConfigurarPaginaLista - Page1: cabecalho, containers de botoes, filtros e
126:     * a grade de produtos.
127:     * Geometria legada (Pagina.Lista, +29 de compensacao do PageFrame externo):
128:     *   cntSombra   Top=1   Left=-1  Width=1012 Height=80
129:     *   Grupo_op    Top=-1  Left=552 Width=385  Height=85
130:     *   Grupo_Saida Top=-1  Left=927 (padrao canonico prevalece - CLAUDE.md #10)
131:     *   cntFiltros  Top=93  Left=31  Width=388  Height=63
132:     *===========================================================================
133:     PROTECTED PROCEDURE ConfigurarPaginaLista()
134:         LOCAL loc_oPagina
135:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
136: 
137:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
138: 
139:         *-- Faixa cinza do cabecalho: PRIMEIRO AddObject da pagina (CLAUDE.md #11)
140:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
141:         WITH loc_oPagina.cnt_4c_Cabecalho
142:             .Top           = 30
143:             .Left          = 0
144:             .Width         = THIS.Width
145:             .Height        = 80
146:             .BackColor     = RGB(100, 100, 100)
147:             .BorderWidth   = 0
148:             .SpecialEffect = 0
149:             .Visible       = .T.
150: 
151:             .AddObject("lbl_4c_Sombra", "Label")
152:             WITH .lbl_4c_Sombra
153:                 .Caption   = THIS.Caption
154:                 .Top       = 15
155:                 .Left      = 10
156:                 .Width     = THIS.Width
157:                 .Height    = 40
158:                 .FontName  = "Tahoma"
159:                 .FontSize  = 16
160:                 .FontBold  = .T.
161:                 .ForeColor = RGB(0, 0, 0)
162:                 .BackStyle = 0
163:                 .AutoSize  = .F.
164:                 .Visible   = .T.
165:             ENDWITH
166: 
167:             .AddObject("lbl_4c_Titulo", "Label")
168:             WITH .lbl_4c_Titulo
169:                 .Caption   = THIS.Caption
170:                 .Top       = 18
171:                 .Left      = 10
172:                 .Width     = THIS.Width
173:                 .Height    = 46

*-- Linhas 182 a 995:
182:         ENDWITH
183: 
184:         *-- Container dos botoes CRUD (Grupo_op legado). Left canonico 542:
185:         *-- os 5 botoes (5/80/155/230/305 x 75) terminam em 922, exatamente
186:         *-- onde comeca o botao Encerrar do cnt_4c_Saida (917 + 5).
187:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
188:         WITH loc_oPagina.cnt_4c_Botoes
189:             .Top           = 29
190:             .Left          = 542
191:             .Width         = 390
192:             .Height        = 85
193:             .BackStyle = 1
194:             .BackColor = RGB(255, 255, 255)
195:             .BorderWidth   = 0
196:             .SpecialEffect = 0
197:             .Visible       = .T.
198:         ENDWITH
199: 
200:         *-- Botao Incluir (Left=5)
201:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
202:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
203:             .Caption         = "Incluir"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
205:             .PicturePosition = 13
206:             .Top             = 5
207:             .Left            = 5
208:             .Width           = 75
209:             .Height          = 75
210:             .FontName        = "Comic Sans MS"
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .FontSize        = 8
214:             .ForeColor       = RGB(90, 90, 90)
215:             .BackColor       = RGB(255, 255, 255)
216:             .Themes          = .F.
217:             .SpecialEffect   = 0
218:             .MousePointer    = 15
219:             .WordWrap        = .T.
220:             .AutoSize        = .F.
221:             .Visible         = .T.
222:         ENDWITH
223:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
224: 
225:         *-- Botao Visualizar (Left=80)
226:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
227:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
228:             .Caption         = "Visualizar"
229:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
230:             .PicturePosition = 13
231:             .Top             = 5
232:             .Left            = 80
233:             .Width           = 75
234:             .Height          = 75
235:             .FontName        = "Comic Sans MS"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .FontSize        = 8
239:             .ForeColor       = RGB(90, 90, 90)
240:             .BackColor       = RGB(255, 255, 255)
241:             .Themes          = .F.
242:             .SpecialEffect   = 0
243:             .MousePointer    = 15
244:             .WordWrap        = .T.
245:             .AutoSize        = .F.
246:             .Visible         = .T.
247:         ENDWITH
248:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
249: 
250:         *-- Botao Alterar (Left=155)
251:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
252:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
253:             .Caption         = "Alterar"
254:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
255:             .PicturePosition = 13
256:             .Top             = 5
257:             .Left            = 155
258:             .Width           = 75
259:             .Height          = 75
260:             .FontName        = "Comic Sans MS"
261:             .FontBold        = .T.
262:             .FontItalic      = .T.
263:             .FontSize        = 8
264:             .ForeColor       = RGB(90, 90, 90)
265:             .BackColor       = RGB(255, 255, 255)
266:             .Themes          = .F.
267:             .SpecialEffect   = 0
268:             .MousePointer    = 15
269:             .WordWrap        = .T.
270:             .AutoSize        = .F.
271:             .Visible         = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
274: 
275:         *-- Botao Excluir (Left=230)
276:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
277:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
278:             .Caption         = "Excluir"
279:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
280:             .PicturePosition = 13
281:             .Top             = 5
282:             .Left            = 230
283:             .Width           = 75
284:             .Height          = 75
285:             .FontName        = "Comic Sans MS"
286:             .FontBold        = .T.
287:             .FontItalic      = .T.
288:             .FontSize        = 8
289:             .ForeColor       = RGB(90, 90, 90)
290:             .BackColor       = RGB(255, 255, 255)
291:             .Themes          = .F.
292:             .SpecialEffect   = 0
293:             .MousePointer    = 15
294:             .WordWrap        = .T.
295:             .AutoSize        = .F.
296:             .Visible         = .T.
297:         ENDWITH
298:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
299: 
300:         *-- Botao Buscar (Left=305). NAO abre picker (Erro167/Erro177): o legado
301:         *-- (PROCEDURE msv_procurar) faz busca POR EXEMPLO na propria pagina de
302:         *-- Dados, com os campos plProcurar editaveis - ver ADENDO de Erro178.
303:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
304:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
305:             .Caption         = "Buscar"
306:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
307:             .PicturePosition = 13
308:             .Top             = 5
309:             .Left            = 305
310:             .Width           = 75
311:             .Height          = 75
312:             .FontName        = "Comic Sans MS"
313:             .FontBold        = .T.
314:             .FontItalic      = .T.
315:             .FontSize        = 8
316:             .ForeColor       = RGB(90, 90, 90)
317:             .BackColor       = RGB(255, 255, 255)
318:             .Themes          = .F.
319:             .SpecialEffect   = 0
320:             .MousePointer    = 15
321:             .WordWrap        = .T.
322:             .AutoSize        = .F.
323:             .Visible         = .T.
324:         ENDWITH
325:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
326: 
327:         *-- Container de saida - padrao canonico (CLAUDE.md #10) prevalece
328:         *-- sobre o SCX legado (Grupo_Saida.Left = 927).
329:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
330:         WITH loc_oPagina.cnt_4c_Saida
331:             .Top           = 29
332:             .Left          = 917
333:             .Width         = 90
334:             .Height        = 85
335:             .BackStyle = 1
336:             .BackColor = RGB(255, 255, 255)
337:             .BorderWidth   = 0
338:             .SpecialEffect = 0
339:             .Visible       = .T.
340:         ENDWITH
341: 
342:         *-- Botao Encerrar - padrao canonico (Caption="Encerrar", 75x75)
343:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
344:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
345:             .Caption         = "Encerrar"
346:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
347:             .PicturePosition = 13
348:             .Top             = 5
349:             .Left            = 5
350:             .Width           = 75
351:             .Height          = 75
352:             .FontName        = "Comic Sans MS"
353:             .FontBold        = .T.
354:             .FontItalic      = .T.
355:             .FontSize        = 8
356:             .ForeColor       = RGB(90, 90, 90)
357:             .BackColor       = RGB(255, 255, 255)
358:             .Themes          = .F.
359:             .SpecialEffect   = 0
360:             .MousePointer    = 15
361:             .WordWrap        = .T.
362:             .AutoSize        = .F.
363:             .Visible         = .T.
364:         ENDWITH
365:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
366: 
367:         *-- Container dos filtros da lista (cntFiltros legado: grupo de produto,
368:         *-- faixa de datas de ultima alteracao e situacao Geral/Ativos/Inativos).
369:         *-- Regra #35 do CLAUDE.md: o filtro eh aplicado SEMPRE - com o grupo
370:         *-- vazio a lista abre vazia de proposito, esperando o usuario escolher.
371:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
372:         WITH loc_oPagina.cnt_4c_Filtros
373:             .Top           = 122
374:             .Left          = 31
375:             .Width         = 388
376:             .Height        = 63
377:             .BackStyle     = 0
378:             .BorderWidth   = 0
379:             .SpecialEffect = 0
380:             .Visible       = .T.
381: 
382:             .AddObject("lbl_4c_Grupo", "Label")
383:             WITH .lbl_4c_Grupo
384:                 .Caption   = "Grupo de Produto :"
385:                 .Top       = 10
386:                 .Left      = 19
387:                 .Width     = 94
388:                 .Height    = 15
389:                 .BackStyle = 0
390:                 .ForeColor = RGB(90, 90, 90)
391:                 .FontName  = "Tahoma"
392:                 .FontSize  = 8
393:                 .Visible   = .T.
394:             ENDWITH
395: 
396:             .AddObject("txt_4c_Cgru", "TextBox")
397:             WITH .txt_4c_Cgru
398:                 .Top       = 6
399:                 .Left      = 116
400:                 .Width     = 31
401:                 .Height    = 23
402:                 .MaxLength = 3
403:                 .FontName  = "Tahoma"
404:                 .FontSize  = 8
405:                 .Visible   = .T.
406:             ENDWITH
407:             BINDEVENT(.txt_4c_Cgru, "KeyPress", THIS, "ValidarGrupoFiltro")
408: 
409:             .AddObject("txt_4c_Dgru", "TextBox")
410:             WITH .txt_4c_Dgru
411:                 .Top       = 6
412:                 .Left      = 149
413:                 .Width     = 156
414:                 .Height    = 23
415:                 .MaxLength = 20
416:                 .FontName  = "Tahoma"
417:                 .FontSize  = 8
418:                 .Visible   = .T.
419:             ENDWITH
420:             BINDEVENT(.txt_4c_Dgru, "KeyPress", THIS, "ValidarGrupoPorDescricao")
421: 
422:             .AddObject("lbl_4c_UltimaAlteracao", "Label")
423:             WITH .lbl_4c_UltimaAlteracao
424:                 .Caption   = "" + CHR(218) + "ltima Altera" + CHR(231) + CHR(227) + "o :"
425:                 .Top       = 35
426:                 .Left      = 26
427:                 .Width     = 87
428:                 .Height    = 15
429:                 .BackStyle = 0
430:                 .ForeColor = RGB(90, 90, 90)
431:                 .FontName  = "Tahoma"
432:                 .FontSize  = 8
433:                 .Visible   = .T.
434:             ENDWITH
435: 
436:             .AddObject("txt_4c_DtIni", "TextBox")
437:             WITH .txt_4c_DtIni
438:                 .Top      = 31
439:                 .Left     = 116
440:                 .Width    = 78
441:                 .Height   = 23
442:                 .FontName = "Tahoma"
443:                 .FontSize = 8
444:                 .Value    = {^1900-01-01}
445:                 .Visible  = .T.
446:             ENDWITH
447:             BINDEVENT(.txt_4c_DtIni, "LostFocus", THIS, "RecarregarListaFiltrada")
448: 
449:             .AddObject("lbl_4c_Ate", "Label")
450:             WITH .lbl_4c_Ate
451:                 .Caption   = "at" + CHR(233)
452:                 .Top       = 35
453:                 .Left      = 202
454:                 .Width     = 18
455:                 .Height    = 15
456:                 .BackStyle = 0
457:                 .ForeColor = RGB(90, 90, 90)
458:                 .FontName  = "Tahoma"
459:                 .FontSize  = 8
460:                 .Visible   = .T.
461:             ENDWITH
462: 
463:             .AddObject("txt_4c_DtFim", "TextBox")
464:             WITH .txt_4c_DtFim
465:                 .Top      = 31
466:                 .Left     = 225
467:                 .Width    = 78
468:                 .Height   = 23
469:                 .FontName = "Tahoma"
470:                 .FontSize = 8
471:                 .Value    = {^2900-12-31}
472:                 .Visible  = .T.
473:             ENDWITH
474:             BINDEVENT(.txt_4c_DtFim, "LostFocus", THIS, "RecarregarListaFiltrada")
475: 
476:             .AddObject("opt_4c_FilSituas", "OptionGroup")
477:             WITH .opt_4c_FilSituas
478:                 .ButtonCount = 3
479:                 .Top         = 6
480:                 .Left        = 308
481:                 .Width       = 78
482:                 .Height      = 46
483:                 .BackStyle   = 0
484:                 .Value       = 1
485:                 .Visible     = .T.
486:             ENDWITH
487:             WITH .opt_4c_FilSituas.Buttons(1)
488:                 .Caption   = "Geral"
489:                 .Top       = 2
490:                 .Left      = 2
491:                 .Width     = 70
492:                 .AutoSize  = .T.
493:                 .ForeColor = RGB(90, 90, 90)
494:                 .FontName  = "Tahoma"
495:                 .FontSize  = 8
496:             ENDWITH
497:             WITH .opt_4c_FilSituas.Buttons(2)
498:                 .Caption   = "Ativos"
499:                 .Top       = 17
500:                 .Left      = 2
501:                 .Width     = 70
502:                 .AutoSize  = .T.
503:                 .ForeColor = RGB(90, 90, 90)
504:                 .FontName  = "Tahoma"
505:                 .FontSize  = 8
506:             ENDWITH
507:             WITH .opt_4c_FilSituas.Buttons(3)
508:                 .Caption   = "Inativos"
509:                 .Top       = 32
510:                 .Left      = 2
511:                 .Width     = 70
512:                 .AutoSize  = .T.
513:                 .ForeColor = RGB(90, 90, 90)
514:                 .FontName  = "Tahoma"
515:                 .FontSize  = 8
516:             ENDWITH
517:             BINDEVENT(.opt_4c_FilSituas, "InteractiveChange", THIS, "RecarregarListaFiltrada")
518:         ENDWITH
519: 
520:         *-- Grade de produtos (Grade legada). Left=26/Width=860 nao sobrepoe o
521:         *-- cnt_4c_Saida (Left=917). Colunas conforme pColuna do legado
522:         *-- (regra #35 do CLAUDE.md - o header vem do runtime, nao do SCX).
523:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
524:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas)
525:         loc_oPagina.grd_4c_Dados.ColumnCount = 7
526:         WITH loc_oPagina.grd_4c_Dados
527:             .Top                = 195
528:             .Left               = 26
529:             .Width              = 860
530:             .Height             = 400
531:             .FontName           = "Verdana"
532:             .FontSize           = 8
533:             .ForeColor          = RGB(90, 90, 90)
534:             .BackColor          = RGB(255, 255, 255)
535:             .GridLineColor      = RGB(238, 238, 238)
536:             .HighlightBackColor = RGB(255, 255, 255)
537:             .HighlightForeColor = RGB(15, 41, 104)
538:             .HighlightStyle     = 2
539:             .DeleteMark         = .F.
540:             .RecordMark         = .F.
541:             .RowHeight          = 16
542:             .ScrollBars         = 2
543:             .GridLines          = 3
544:             .ReadOnly           = .T.
545:             .AllowHeaderSizing  = .F.
546:             .AllowRowSizing     = .F.
547:             .Visible            = .T.
548:         ENDWITH
549: 
550:         *-- Coluna 7 (checkbox "I" = Inativo): AddObject + CurrentControl
551:         *-- obrigatorios para o controle aparecer (regra #18 do CLAUDE.md).
552:         loc_oPagina.grd_4c_Dados.Column7.AddObject("chk_4c_Inativo", "CheckBox")
553:         WITH loc_oPagina.grd_4c_Dados.Column7
554:             .CurrentControl = "chk_4c_Inativo"
555:             .Sparse         = .F.
556:             .ReadOnly       = .T.
557:             .chk_4c_Inativo.Enabled = .F.
558:         ENDWITH
559: 
560:         BINDEVENT(loc_oPagina.grd_4c_Dados, "DblClick", THIS, "BtnVisualizarClick")
561:         BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GridDadosAfterRowColChange")
562: 
563:         *-- Rodape: contador de produtos selecionados/listados (lblProdutos legado)
564:         loc_oPagina.AddObject("lbl_4c_Produtos", "Label")
565:         WITH loc_oPagina.lbl_4c_Produtos
566:             .Caption   = "Produtos Selecionados : 0"
567:             .Top       = 600
568:             .Left      = 35
569:             .Width     = 250
570:             .Height    = 15
571:             .BackStyle = 0
572:             .ForeColor = RGB(90, 90, 90)
573:             .FontName  = "Tahoma"
574:             .FontSize  = 8
575:             .Visible   = .T.
576:         ENDWITH
577: 
578:         THIS.TornarControlesVisiveis(loc_oPagina)
579:     ENDPROC
580: 
581:     *===========================================================================
582:     * CarregarLista - Consulta a grade de produtos com os filtros atuais
583:     * Regra #2 (docs/FORMCOR_LICOES_APRENDIDAS.md): headers SEMPRE redefinidos
584:     * DEPOIS do RecordSource, que os reseta.
585:     *===========================================================================
586:     *-- PUBLIC: o TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA
587:     *-- da classe. PEMSTATUS(...,5) devolve .T. mesmo para PROTECTED, entao o
588:     *-- harness entraria no branch e a chamada estouraria em runtime
589:     *-- ("Property CARREGARLISTA is not found") - CLAUDE.md regra #3.
590:     PROCEDURE CarregarLista()
591:         LOCAL loc_lResultado, loc_oGrid, loc_oFiltros, loc_cGrupo, loc_dDtIni, ;
592:             loc_dDtFim, loc_nSituacao, loException
593:         loc_lResultado = .F.
594: 
595:         TRY
596:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
597:                 loc_lResultado = .T.
598:             ELSE
599:                 loc_oFiltros  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
600:                 loc_cGrupo    = ALLTRIM(loc_oFiltros.txt_4c_Cgru.Value)
601:                 loc_dDtIni    = loc_oFiltros.txt_4c_DtIni.Value
602:                 loc_dDtFim    = loc_oFiltros.txt_4c_DtFim.Value
603:                 loc_nSituacao = loc_oFiltros.opt_4c_FilSituas.Value
604: 
605:                 IF !THIS.this_oBusinessObject.BuscarLista(loc_cGrupo, loc_dDtIni, loc_dDtFim, loc_nSituacao)
606:                     loc_lResultado = .F.
607:                 ELSE
608:                     *-- Bind, larguras e headers ficam em VincularGradeLista
609:                     *-- (o mesmo bloco eh usado pela busca por exemplo, que
610:                     *-- popula cursor_4c_Dados por outro caminho).
611:                     THIS.VincularGradeLista()
612: 
613:                     loc_lResultado = .T.
614:                 ENDIF
615:             ENDIF
616: 
617:         CATCH TO loException
618:             MostrarErro("Erro ao carregar lista de produtos:" + CHR(13) + ;
619:                 loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
620:                 "FormProduto.CarregarLista")
621:             loc_lResultado = .F.
622:         ENDTRY
623: 
624:         RETURN loc_lResultado
625:     ENDPROC
626: 
627:     *===========================================================================
628:     * AtualizarContadorProdutos - Atualiza o rotulo "Produtos Selecionados"
629:     *===========================================================================
630:     PROTECTED PROCEDURE AtualizarContadorProdutos()
631:         LOCAL loc_nTotal
632:         loc_nTotal = 0
633: 
634:         IF USED("cursor_4c_Dados")
635:             loc_nTotal = RECCOUNT("cursor_4c_Dados")
636:         ENDIF
637: 
638:         THIS.pgf_4c_Paginas.Page1.lbl_4c_Produtos.Caption = ;
639:             "Produtos Selecionados : " + TRANSFORM(loc_nTotal)
640:     ENDPROC
641: 
642:     *===========================================================================
643:     * GridDadosAfterRowColChange - Handler de BINDEVENT (regra #38 - precisa
644:     * declarar o parametro do evento, senao "No PARAMETER statement is found")
645:     *===========================================================================
646:     PROCEDURE GridDadosAfterRowColChange(par_nColIndex)
647:         THIS.AtualizarContadorProdutos()
648:     ENDPROC
649: 
650:     *===========================================================================
651:     * RecarregarListaFiltrada - Handler de LostFocus/InteractiveChange dos
652:     * campos de filtro (data inicial/final, situacao) - regra #31 do CLAUDE.md
653:     *===========================================================================
654:     PROCEDURE RecarregarListaFiltrada()
655:         THIS.CarregarLista()
656:     ENDPROC
657: 
658:     *===========================================================================
659:     * ValidarGrupoFiltro - LostFocus de txt_4c_Cgru (filtro de grupo por codigo)
660:     * Transcricao do getCgru.Valid do legado: busca exata em SigCdGrp; se nao
661:     * achar, abre o picker (FormBuscaAuxiliar Modo 1) para o usuario escolher.
662:     * Regra #45: so revalida se o valor realmente mudou.
663:     *===========================================================================
664:     PROCEDURE ValidarGrupoFiltro(par_nKeyCode, par_nShiftAltCtrl)
665:         LOCAL loc_oFiltros, loc_cValor, loc_oBusca, loException
666:         loc_oFiltros = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
667:         loc_cValor   = PADR(ALLTRIM(loc_oFiltros.txt_4c_Cgru.Value), 3)
668: 
669:         IF loc_cValor == THIS.this_cUltimoGrupoValidado
670:             RETURN
671:         ENDIF
672:         THIS.this_cUltimoGrupoValidado = loc_cValor
673: 
674:         IF EMPTY(loc_cValor)
675:             loc_oFiltros.txt_4c_Dgru.Value = ""
676:             THIS.CarregarLista()
677:             RETURN
678:         ENDIF
679: 
680:         TRY
681:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
682:                 "SigCdGrp", "cursor_4c_BuscaGrpFiltro", "cgrus", loc_cValor, ;
683:                 "Grupo de Produto")
684: 
685:             IF VARTYPE(loc_oBusca) = "O"
686:                 IF !loc_oBusca.this_lAchouRegistro
687:                     loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
688:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
689:                     loc_oBusca.Show()
690:                 ENDIF
691: 
692:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFiltro")
693:                     SELECT cursor_4c_BuscaGrpFiltro
694:                     loc_oFiltros.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrpFiltro.cgrus)
695:                     loc_oFiltros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrpFiltro.dgrus)
696:                     THIS.this_cUltimoGrupoValidado = PADR(ALLTRIM(cursor_4c_BuscaGrpFiltro.cgrus), 3)
697:                 ELSE
698:                     loc_oFiltros.txt_4c_Cgru.Value = ""
699:                     loc_oFiltros.txt_4c_Dgru.Value = ""
700:                     THIS.this_cUltimoGrupoValidado = ""
701:                 ENDIF
702: 
703:                 loc_oBusca.Release()
704:             ENDIF
705: 
706:             IF USED("cursor_4c_BuscaGrpFiltro")
707:                 USE IN cursor_4c_BuscaGrpFiltro
708:             ENDIF
709: 
710:         CATCH TO loException
711:             MostrarErro("Erro ao validar o grupo de produto:" + CHR(13) + ;
712:                 loException.Message, "FormProduto.ValidarGrupoFiltro")
713:         ENDTRY
714: 
715:         THIS.CarregarLista()
716:     ENDPROC
717: 
718:     *===========================================================================
719:     * ValidarGrupoPorDescricao - LostFocus de txt_4c_Dgru (filtro de grupo por
720:     * descricao) - mesmo padrao de ValidarGrupoFiltro, buscando por dgrus.
721:     *===========================================================================
722:     PROCEDURE ValidarGrupoPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
723:         LOCAL loc_oFiltros, loc_cValor, loc_oBusca, loException
724:         loc_oFiltros = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
725:         loc_cValor   = ALLTRIM(loc_oFiltros.txt_4c_Dgru.Value)
726: 
727:         IF EMPTY(loc_cValor) OR !EMPTY(ALLTRIM(loc_oFiltros.txt_4c_Cgru.Value))
728:             RETURN
729:         ENDIF
730: 
731:         TRY
732:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
733:                 "SigCdGrp", "cursor_4c_BuscaGrpFiltro", "dgrus", loc_cValor, ;
734:                 "Grupo de Produto")
735: 
736:             IF VARTYPE(loc_oBusca) = "O"
737:                 IF !loc_oBusca.this_lAchouRegistro
738:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
739:                     loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
740:                     loc_oBusca.Show()
741:                 ENDIF
742: 
743:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFiltro")
744:                     SELECT cursor_4c_BuscaGrpFiltro
745:                     loc_oFiltros.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrpFiltro.cgrus)
746:                     loc_oFiltros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrpFiltro.dgrus)
747:                     THIS.this_cUltimoGrupoValidado = PADR(ALLTRIM(cursor_4c_BuscaGrpFiltro.cgrus), 3)
748:                 ELSE
749:                     loc_oFiltros.txt_4c_Dgru.Value = ""
750:                 ENDIF
751: 
752:                 loc_oBusca.Release()
753:             ENDIF
754: 
755:             IF USED("cursor_4c_BuscaGrpFiltro")
756:                 USE IN cursor_4c_BuscaGrpFiltro
757:             ENDIF
758: 
759:         CATCH TO loException
760:             MostrarErro("Erro ao validar o grupo de produto:" + CHR(13) + ;
761:                 loException.Message, "FormProduto.ValidarGrupoPorDescricao")
762:         ENDTRY
763: 
764:         THIS.CarregarLista()
765:     ENDPROC
766: 
767:     *===========================================================================
768:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
769:     * Ao voltar para a Lista, repoe o modo e recarrega a grade (regra #40 do
770:     * CLAUDE.md - sem isso os botoes/estado ficam desatualizados).
771:     *===========================================================================
772:     PROCEDURE AlternarPagina(par_nPagina)
773:         LOCAL loc_lResultado, loException
774:         loc_lResultado = .F.
775: 
776:         TRY
777:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
778:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
779:             ELSE
780:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
781: 
782:                 IF par_nPagina = 1
783:                     THIS.this_cModoAtual = "LISTA"
784:                     THIS.CarregarLista()
785:                 ENDIF
786: 
787:                 *-- Regra #40 (Erro176): quem desabilita os botoes CRUD ao
788:                 *-- entrar em edicao TEM de reabilita-los no funil de volta.
789:                 *-- Fica aqui, no funil, e nao em cada caller.
790:                 THIS.AjustarBotoesPorModo()
791: 
792:                 loc_lResultado = .T.
793:             ENDIF
794: 
795:         CATCH TO loException
796:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
797:                 loException.Message, "FormProduto.AlternarPagina")
798:             loc_lResultado = .F.
799:         ENDTRY
800: 
801:         RETURN loc_lResultado
802:     ENDPROC
803: 
804:     *===========================================================================
805:     * BtnIncluirClick - Prepara o BO para um novo produto e abre a pagina Dados
806:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
807:     *===========================================================================
808:     PROCEDURE BtnIncluirClick()
809:         THIS.this_oBusinessObject.NovoRegistro()
810: 
811:         *-- Modo ANTES de HabilitarCampos (Problema 19): o metodo decide a
812:         *-- edicao do codigo/chave a partir de this_cModoAtual.
813:         THIS.this_cModoAtual = "INCLUIR"
814: 
815:         THIS.LimparCampos()
816:         THIS.HabilitarCampos(.T.)
817:         THIS.AjustarBotoesPorModo()
818:         THIS.AlternarPagina(2)
819:         THIS.IrParaDivisao(1)
820:     ENDPROC
821: 
822:     *===========================================================================
823:     * BtnVisualizarClick - Abre o produto selecionado na grade em modo leitura
824:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
825:     *===========================================================================
826:     PROCEDURE BtnVisualizarClick()
827:         LOCAL loc_cCodigo
828:         loc_cCodigo = ""
829: 
830:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
831:             SELECT cursor_4c_Dados
832:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
833:         ENDIF
834: 
835:         IF EMPTY(loc_cCodigo)
836:             MsgAviso("Selecione um produto para visualizar.")
837:         ELSE
838:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
839:                 THIS.this_cModoAtual = "VISUALIZAR"
840:                 THIS.BOParaForm()
841:                 THIS.HabilitarCampos(.F.)
842:                 THIS.AjustarBotoesPorModo()
843:                 THIS.AlternarPagina(2)
844:                 THIS.IrParaDivisao(1)
845:             ENDIF
846:         ENDIF
847:     ENDPROC
848: 
849:     *===========================================================================
850:     * BtnAlterarClick - Abre o produto selecionado na grade em modo alteracao
851:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
852:     *===========================================================================
853:     PROCEDURE BtnAlterarClick()
854:         LOCAL loc_cCodigo
855:         loc_cCodigo = ""
856: 
857:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
858:             SELECT cursor_4c_Dados
859:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
860:         ENDIF
861: 
862:         IF EMPTY(loc_cCodigo)
863:             MsgAviso("Selecione um produto para alterar.")
864:         ELSE
865:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
866:                 THIS.this_oBusinessObject.EditarRegistro()
867:                 THIS.this_cModoAtual = "ALTERAR"
868:                 THIS.BOParaForm()
869:                 THIS.HabilitarCampos(.T.)
870:                 THIS.AjustarBotoesPorModo()
871:                 THIS.AlternarPagina(2)
872:                 THIS.IrParaDivisao(1)
873:             ENDIF
874:         ENDIF
875:     ENDPROC
876: 
877:     *===========================================================================
878:     * BtnExcluirClick - Exclui o produto selecionado na grade, com confirmacao
879:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
880:     *===========================================================================
881:     PROCEDURE BtnExcluirClick()
882:         LOCAL loc_cCodigo
883:         loc_cCodigo = ""
884: 
885:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
886:             SELECT cursor_4c_Dados
887:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
888:         ENDIF
889: 
890:         IF EMPTY(loc_cCodigo)
891:             MsgAviso("Selecione um produto para excluir.")
892:         ELSE
893:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
894:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto [" + ;
895:                         loc_cCodigo + "]?", "Confirmar Exclus" + CHR(227) + "o")
896:                     IF THIS.this_oBusinessObject.Excluir()
897:                         MsgInfo("Produto exclu" + CHR(237) + "do com sucesso!")
898:                         THIS.CarregarLista()
899:                     ENDIF
900:                 ENDIF
901:             ENDIF
902:         ENDIF
903:     ENDPROC
904: 
905:     *===========================================================================
906:     * BtnBuscarClick - Busca POR EXEMPLO (NAO eh picker - Erro167/Erro177).
907:     * O legado (PROCEDURE msv_procurar) abre a propria pagina de Dados com os
908:     * campos plProcurar editaveis (getCpro, getDpro, getDpro2s, getRefs,
909:     * Getifor, getCbar, getconjunto) e o Confirmar executa o Do Case do
910:     * msv_procurar. Os campos da pgDados e o Confirmar entram numa fase
911:     * posterior (Pagina Dados Principais) - aqui o form entra no modo BUSCAR
912:     * e abre a pagina de Dados em branco, pronta para o usuario digitar.
913:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
914:     *===========================================================================
915:     PROCEDURE BtnBuscarClick()
916:         THIS.this_oBusinessObject.NovoRegistro()
917: 
918:         *-- Modo ANTES de HabilitarCampos: em PROCURAR so os 7 campos
919:         *-- plProcurar do legado ficam editaveis (ver HabilitarCampos).
920:         THIS.this_cModoAtual = "BUSCAR"
921: 
922:         THIS.LimparCampos()
923:         THIS.HabilitarCampos(.T.)
924:         THIS.AjustarBotoesPorModo()
925:         THIS.AlternarPagina(2)
926:         THIS.IrParaDivisao(1)
927: 
928:         MsgInfo("Informe um ou mais campos e clique em Confirmar para procurar." + ;
929:             CHR(13) + "Campos de procura: Produto, Descri" + CHR(231) + CHR(227) + "o, " + ;
930:             "Descritivo, Ref. Fornecedor," + CHR(13) + "Fornecedor, Barra e Cod. Pai.", ;
931:             "Procurar Produto")
932:     ENDPROC
933: 
934:     *===========================================================================
935:     * BtnEncerrarClick - Fecha o formulario
936:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
937:     *===========================================================================
938:     PROCEDURE BtnEncerrarClick()
939:         THIS.Release()
940:     ENDPROC
941: 
942:     *===========================================================================
943:     * ConfigurarPaginaDados - Page2: faixa, PageFrame interno de 8 abas,
944:     * barra de navegacao (OptionGroup) e container Confirmar/Cancelar
945:     *
946:     * Ordem dos AddObject (importa para o Z-ORDER):
947:     *   1) cnt_4c_Cabecalho  - faixa cinza, primeiro objeto da pagina (#11/#195)
948:     *   2) pgf_4c_Divisoes   - cobre a pagina inteira e pinta sobre a faixa,
949:     *                          reproduzindo o visual do legado (que nao tem faixa
950:     *                          nesta pagina) sem esconder os botoes que as abas
951:     *                          possuem no topo (cmdProduto/cmdArquivos, Top=38)
952:     *   3) opt_4c_Navegacao  - barra de abas grafica, POR CIMA do PageFrame
953:     *   4) cnt_4c_BotoesAcao - Confirmar / Cancelar, POR CIMA do PageFrame
954:     *===========================================================================
955:     PROTECTED PROCEDURE ConfigurarPaginaDados()
956:         LOCAL loc_oPagina
957:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
958: 
959:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
960: 
961:         *-- Faixa cinza do cabecalho (CLAUDE.md #11 - nas DUAS paginas)
962:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
963:         WITH loc_oPagina.cnt_4c_Cabecalho
964:             .Top           = 29
965:             .Left          = 0
966:             .Width         = THIS.Width
967:             .Height        = 80
968:             .BackColor     = RGB(100, 100, 100)
969:             .BorderWidth   = 0
970:             .SpecialEffect = 0
971:             .Visible       = .T.
972: 
973:             .AddObject("lbl_4c_Sombra", "Label")
974:             WITH .lbl_4c_Sombra
975:                 .Caption   = THIS.Caption
976:                 .Top       = 15
977:                 .Left      = 10
978:                 .Width     = THIS.Width
979:                 .Height    = 40
980:                 .FontName  = "Tahoma"
981:                 .FontSize  = 16
982:                 .FontBold  = .T.
983:                 .ForeColor = RGB(0, 0, 0)
984:                 .BackStyle = 0
985:                 .AutoSize  = .F.
986:                 .Visible   = .T.
987:             ENDWITH
988: 
989:             .AddObject("lbl_4c_Titulo", "Label")
990:             WITH .lbl_4c_Titulo
991:                 .Caption   = THIS.Caption
992:                 .Top       = 18
993:                 .Left      = 10
994:                 .Width     = THIS.Width
995:                 .Height    = 46

*-- Linhas 1119 a 1292:
1119: 
1120:         THIS.ConfigurarNavegacaoDivisoes(loc_oPagina)
1121: 
1122:         *-- Container Confirmar / Cancelar (Grupo_Salva legado: Top=2, Left=848,
1123:         *-- Height=85, com Salva em Left=5 e Cancelar em Left=80)
1124:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
1125:         WITH loc_oPagina.cnt_4c_BotoesAcao
1126:             .Top           = 31
1127:             .Left          = 848
1128:             .Width         = 160
1129:             .Height        = 85
1130:             .BackStyle = 1
1131:             .BackColor = RGB(255, 255, 255)
1132:             .BorderWidth   = 0
1133:             .SpecialEffect = 0
1134:             .Visible       = .T.
1135:         ENDWITH
1136: 
1137:         *-- Botao Confirmar (Salva legado: Left=5 dentro do Grupo_Salva)
1138:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
1139:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
1140:             .Caption         = "Confirmar"
1141:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1142:             .PicturePosition = 13
1143:             .Top             = 5
1144:             .Left            = 5
1145:             .Width           = 75
1146:             .Height          = 75
1147:             .FontName        = "Comic Sans MS"
1148:             .FontBold        = .T.
1149:             .FontItalic      = .T.
1150:             .FontSize        = 8
1151:             .ForeColor       = RGB(90, 90, 90)
1152:             .BackColor       = RGB(255, 255, 255)
1153:             .Themes          = .F.
1154:             .SpecialEffect   = 0
1155:             .MousePointer    = 15
1156:             .WordWrap        = .T.
1157:             .AutoSize        = .F.
1158:             .Visible         = .T.
1159:         ENDWITH
1160:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1161: 
1162:         *-- Botao Cancelar (Cancelar legado: Left=80 dentro do Grupo_Salva)
1163:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
1164:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
1165:             .Caption         = "Encerrar"
1166:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1167:             .PicturePosition = 13
1168:             .Top             = 5
1169:             .Left            = 80
1170:             .Width           = 75
1171:             .Height          = 75
1172:             .FontName        = "Comic Sans MS"
1173:             .FontBold        = .T.
1174:             .FontItalic      = .T.
1175:             .FontSize        = 8
1176:             .ForeColor       = RGB(90, 90, 90)
1177:             .BackColor       = RGB(255, 255, 255)
1178:             .Themes          = .F.
1179:             .SpecialEffect   = 0
1180:             .MousePointer    = 15
1181:             .WordWrap        = .T.
1182:             .AutoSize        = .F.
1183:             .Visible         = .T.
1184:         ENDWITH
1185:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
1186: 
1187:         *-- Z-ORDER: navegacao e botoes de acao sempre na frente do PageFrame
1188:         loc_oPagina.opt_4c_Navegacao.ZOrder(0)
1189:         loc_oPagina.cnt_4c_BotoesAcao.ZOrder(0)
1190: 
1191:         THIS.TornarControlesVisiveis(loc_oPagina)
1192:     ENDPROC
1193: 
1194:     *===========================================================================
1195:     * ConfigurarAbaDadosPrincipais - Campos da aba "Principal" (pgDados legado)
1196:     * dentro de pgf_4c_Divisoes.Page1. Posicoes/Top/Left saem DIRETO do
1197:     * layout.json (sem compensacao adicional - ver comentario em
1198:     * ConfigurarPaginaDados sobre o calculo do PageFrame interno).
1199:     *
1200:     * FASE 5/8 - primeira metade dos 176 controles do legado (identificacao
1201:     * do produto, grupo/subgrupo/linha/colecao, unidade, EAN/GTIN, fornecedor,
1202:     * modelo, moedas de custo/venda, auditoria de inclusao/alteracao).
1203:     *===========================================================================
1204:     PROTECTED PROCEDURE ConfigurarAbaDadosPrincipais(par_oPagina)
1205:         *-- Imagem principal do produto (shpFig / ImgFigJpg)
1206:         par_oPagina.AddObject("shp_4c_ShpFig", "Shape")
1207:         WITH par_oPagina.shp_4c_ShpFig
1208:             .Top     = 505
1209:             .Left    = 600
1210:             .Width   = 174
1211:             .Height  = 114
1212:             .Visible = .T.
1213:         ENDWITH
1214: 
1215:         par_oPagina.AddObject("img_4c_ImgFigJpg", "Image")
1216:         WITH par_oPagina.img_4c_ImgFigJpg
1217:             .Top      = 506
1218:             .Left     = 601
1219:             .Width    = 172
1220:             .Height   = 112
1221:             .Stretch  = 2
1222:             .Visible  = .T.
1223:         ENDWITH
1224: 
1225:         *-- Produto :  (Label2 - colide com Say2 "Equivalente :" no mapeamento
1226:         *-- original; renomeado para lbl_4c_LblProduto - fix no mapeamento.json)
1227:         par_oPagina.AddObject("lbl_4c_LblProduto", "Label")
1228:         WITH par_oPagina.lbl_4c_LblProduto
1229:             .Caption   = "Produto :"
1230:             .Top       = 121
1231:             .Left      = 47
1232:             .Width     = 53
1233:             .Height    = 15
1234:             .BackStyle = 0
1235:             .ForeColor = RGB(90, 90, 90)
1236:             .FontName  = "Tahoma"
1237:             .FontSize  = 8
1238:             .Visible   = .T.
1239:         ENDWITH
1240: 
1241:         par_oPagina.AddObject("txt_4c_Cpro", "TextBox")
1242:         WITH par_oPagina.txt_4c_Cpro
1243:             .Top       = 117
1244:             .Left      = 102
1245:             .Width     = 108
1246:             .Height    = 22
1247:             .MaxLength = 14
1248:             .FontName  = "Tahoma"
1249:             .FontSize  = 8
1250:             .Visible   = .T.
1251:         ENDWITH
1252:         BINDEVENT(par_oPagina.txt_4c_Cpro, "KeyPress", THIS, "ValidarCodigoProdutoDados")
1253: 
1254:         par_oPagina.AddObject("txt_4c_Dpro", "TextBox")
1255:         WITH par_oPagina.txt_4c_Dpro
1256:             .Top       = 117
1257:             .Left      = 211
1258:             .Width     = 290
1259:             .Height    = 22
1260:             .MaxLength = 65
1261:             .FontName  = "Tahoma"
1262:             .FontSize  = 8
1263:             .Visible   = .T.
1264:         ENDWITH
1265: 
1266:         *-- Descritivo :  (getDPro2s)
1267:         par_oPagina.AddObject("lbl_4c_Label10", "Label")
1268:         WITH par_oPagina.lbl_4c_Label10
1269:             .Caption   = "Descritivo :"
1270:             .Top       = 144
1271:             .Left      = 44
1272:             .Width     = 56
1273:             .Height    = 15
1274:             .BackStyle = 0
1275:             .ForeColor = RGB(90, 90, 90)
1276:             .FontName  = "Tahoma"
1277:             .FontSize  = 8
1278:             .Visible   = .T.
1279:         ENDWITH
1280: 
1281:         par_oPagina.AddObject("txt_4c_DPro2s", "TextBox")
1282:         WITH par_oPagina.txt_4c_DPro2s
1283:             .Top       = 140
1284:             .Left      = 102
1285:             .Width     = 399
1286:             .Height    = 22
1287:             .MaxLength = 45
1288:             .FontName  = "Tahoma"
1289:             .FontSize  = 8
1290:             .Visible   = .T.
1291:         ENDWITH
1292: 

*-- Linhas 1368 a 1614:
1368:             .FontSize  = 8
1369:             .Visible   = .T.
1370:         ENDWITH
1371:         BINDEVENT(par_oPagina.txt_4c_CProEq, "KeyPress", THIS, "ValidarProdutoEquivalente")
1372: 
1373:         *-- Grupo / Subgrupo / Linha / Colecao / Grupo de Venda (Mercs)
1374:         par_oPagina.AddObject("lbl_4c_Label8", "Label")
1375:         WITH par_oPagina.lbl_4c_Label8
1376:             .Caption   = "Grupo :"
1377:             .Top       = 190
1378:             .Left      = 62
1379:             .Width     = 38
1380:             .Height    = 15
1381:             .BackStyle = 0
1382:             .ForeColor = RGB(90, 90, 90)
1383:             .FontName  = "Tahoma"
1384:             .FontSize  = 8
1385:             .Visible   = .T.
1386:         ENDWITH
1387: 
1388:         par_oPagina.AddObject("txt_4c_Cgru", "TextBox")
1389:         WITH par_oPagina.txt_4c_Cgru
1390:             .Top       = 186
1391:             .Left      = 102
1392:             .Width     = 31
1393:             .Height    = 22
1394:             .MaxLength = 3
1395:             .FontName  = "Tahoma"
1396:             .FontSize  = 8
1397:             .Visible   = .T.
1398:         ENDWITH
1399:         BINDEVENT(par_oPagina.txt_4c_Cgru, "KeyPress", THIS, "ValidarGrupoDadosPorCodigo")
1400: 
1401:         par_oPagina.AddObject("txt_4c_Dgru", "TextBox")
1402:         WITH par_oPagina.txt_4c_Dgru
1403:             .Top       = 186
1404:             .Left      = 134
1405:             .Width     = 171
1406:             .Height    = 22
1407:             .MaxLength = 30
1408:             .FontName  = "Tahoma"
1409:             .FontSize  = 8
1410:             .Visible   = .T.
1411:         ENDWITH
1412:         BINDEVENT(par_oPagina.txt_4c_Dgru, "KeyPress", THIS, "ValidarGrupoDadosPorDescricao")
1413: 
1414:         par_oPagina.AddObject("lbl_4c_Label9", "Label")
1415:         WITH par_oPagina.lbl_4c_Label9
1416:             .Caption   = "Subgrupo :"
1417:             .Top       = 213
1418:             .Left      = 45
1419:             .Width     = 55
1420:             .Height    = 15
1421:             .BackStyle = 0
1422:             .ForeColor = RGB(90, 90, 90)
1423:             .FontName  = "Tahoma"
1424:             .FontSize  = 8
1425:             .Visible   = .T.
1426:         ENDWITH
1427: 
1428:         par_oPagina.AddObject("txt_4c_CSGru", "TextBox")
1429:         WITH par_oPagina.txt_4c_CSGru
1430:             .Top       = 209
1431:             .Left      = 102
1432:             .Width     = 52
1433:             .Height    = 22
1434:             .MaxLength = 6
1435:             .FontName  = "Tahoma"
1436:             .FontSize  = 8
1437:             .Visible   = .T.
1438:         ENDWITH
1439:         BINDEVENT(par_oPagina.txt_4c_CSGru, "KeyPress", THIS, "ValidarSubgrupoDadosPorCodigo")
1440: 
1441:         par_oPagina.AddObject("txt_4c_DsGru", "TextBox")
1442:         WITH par_oPagina.txt_4c_DsGru
1443:             .Top       = 209
1444:             .Left      = 155
1445:             .Width     = 150
1446:             .Height    = 22
1447:             .MaxLength = 30
1448:             .FontName  = "Tahoma"
1449:             .FontSize  = 8
1450:             .Visible   = .T.
1451:         ENDWITH
1452:         BINDEVENT(par_oPagina.txt_4c_DsGru, "KeyPress", THIS, "ValidarSubgrupoDadosPorDescricao")
1453: 
1454:         par_oPagina.AddObject("lbl_4c_Label16", "Label")
1455:         WITH par_oPagina.lbl_4c_Label16
1456:             .Caption   = "Linha :"
1457:             .Top       = 236
1458:             .Left      = 66
1459:             .Width     = 34
1460:             .Height    = 15
1461:             .BackStyle = 0
1462:             .ForeColor = RGB(90, 90, 90)
1463:             .FontName  = "Tahoma"
1464:             .FontSize  = 8
1465:             .Visible   = .T.
1466:         ENDWITH
1467: 
1468:         par_oPagina.AddObject("txt_4c_Lin", "TextBox")
1469:         WITH par_oPagina.txt_4c_Lin
1470:             .Top       = 232
1471:             .Left      = 102
1472:             .Width     = 80
1473:             .Height    = 22
1474:             .MaxLength = 10
1475:             .FontName  = "Tahoma"
1476:             .FontSize  = 8
1477:             .Visible   = .T.
1478:         ENDWITH
1479:         BINDEVENT(par_oPagina.txt_4c_Lin, "KeyPress", THIS, "ValidarLinhaDadosPorCodigo")
1480: 
1481:         par_oPagina.AddObject("txt_4c_DLin", "TextBox")
1482:         WITH par_oPagina.txt_4c_DLin
1483:             .Top       = 232
1484:             .Left      = 183
1485:             .Width     = 196
1486:             .Height    = 22
1487:             .MaxLength = 30
1488:             .FontName  = "Tahoma"
1489:             .FontSize  = 8
1490:             .Visible   = .T.
1491:         ENDWITH
1492:         BINDEVENT(par_oPagina.txt_4c_DLin, "KeyPress", THIS, "ValidarLinhaDadosPorDescricao")
1493: 
1494:         par_oPagina.AddObject("lbl_4c_Label17", "Label")
1495:         WITH par_oPagina.lbl_4c_Label17
1496:             .Caption   = "Grupo de Venda :"
1497:             .Top       = 258
1498:             .Left      = 14
1499:             .Width     = 86
1500:             .Height    = 15
1501:             .BackStyle = 0
1502:             .ForeColor = RGB(90, 90, 90)
1503:             .FontName  = "Tahoma"
1504:             .FontSize  = 8
1505:             .Visible   = .T.
1506:         ENDWITH
1507: 
1508:         par_oPagina.AddObject("txt_4c_Col", "TextBox")
1509:         WITH par_oPagina.txt_4c_Col
1510:             .Top       = 255
1511:             .Left      = 102
1512:             .Width     = 80
1513:             .Height    = 22
1514:             .MaxLength = 10
1515:             .FontName  = "Tahoma"
1516:             .FontSize  = 8
1517:             .Visible   = .T.
1518:         ENDWITH
1519:         BINDEVENT(par_oPagina.txt_4c_Col, "KeyPress", THIS, "ValidarColecaoDadosPorCodigo")
1520: 
1521:         par_oPagina.AddObject("txt_4c_DCol", "TextBox")
1522:         WITH par_oPagina.txt_4c_DCol
1523:             .Top       = 255
1524:             .Left      = 183
1525:             .Width     = 318
1526:             .Height    = 22
1527:             .MaxLength = 30
1528:             .FontName  = "Tahoma"
1529:             .FontSize  = 8
1530:             .Visible   = .T.
1531:         ENDWITH
1532:         BINDEVENT(par_oPagina.txt_4c_DCol, "KeyPress", THIS, "ValidarColecaoDadosPorDescricao")
1533: 
1534:         *-- Grande Grupo (Mercs) - preenchido automaticamente pelo grupo
1535:         par_oPagina.AddObject("txt_4c_Merc", "TextBox")
1536:         WITH par_oPagina.txt_4c_Merc
1537:             .Top       = 186
1538:             .Left      = 307
1539:             .Width     = 31
1540:             .Height    = 23
1541:             .MaxLength = 3
1542:             .ReadOnly  = .T.
1543:             .FontName  = "Tahoma"
1544:             .FontSize  = 8
1545:             .Visible   = .T.
1546:         ENDWITH
1547: 
1548:         *-- Classificacao (Get_Class) + Identificador (getIdeCPros)
1549:         par_oPagina.AddObject("lbl_4c_LblClassificacao", "Label")
1550:         WITH par_oPagina.lbl_4c_LblClassificacao
1551:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
1552:             .Top       = 397
1553:             .Left      = -4
1554:             .Width     = 104
1555:             .Height    = 15
1556:             .BackStyle = 0
1557:             .ForeColor = RGB(90, 90, 90)
1558:             .FontName  = "Tahoma"
1559:             .FontSize  = 8
1560:             .Visible   = .T.
1561:         ENDWITH
1562: 
1563:         par_oPagina.AddObject("txt_4c_Class", "TextBox")
1564:         WITH par_oPagina.txt_4c_Class
1565:             .Top       = 393
1566:             .Left      = 102
1567:             .Width     = 31
1568:             .Height    = 22
1569:             .MaxLength = 3
1570:             .FontName  = "Tahoma"
1571:             .FontSize  = 8
1572:             .Visible   = .T.
1573:         ENDWITH
1574:         BINDEVENT(par_oPagina.txt_4c_Class, "KeyPress", THIS, "ValidarClassificacaoDados")
1575: 
1576:         par_oPagina.AddObject("lbl_4c_Label23", "Label")
1577:         WITH par_oPagina.lbl_4c_Label23
1578:             .Caption   = "Identificador :"
1579:             .Top       = 213
1580:             .Left      = 397
1581:             .Width     = 70
1582:             .Height    = 15
1583:             .BackStyle = 0
1584:             .ForeColor = RGB(90, 90, 90)
1585:             .FontName  = "Tahoma"
1586:             .FontSize  = 8
1587:             .Visible   = .T.
1588:         ENDWITH
1589: 
1590:         par_oPagina.AddObject("txt_4c_IdeCPros", "TextBox")
1591:         WITH par_oPagina.txt_4c_IdeCPros
1592:             .Top       = 209
1593:             .Left      = 470
1594:             .Width     = 31
1595:             .Height    = 22
1596:             .MaxLength = 3
1597:             .FontName  = "Tahoma"
1598:             .FontSize  = 8
1599:             .Visible   = .T.
1600:         ENDWITH
1601: 
1602:         *-- Fornecedor / Ref. Fornecedor
1603:         par_oPagina.AddObject("lbl_4c_Label11", "Label")
1604:         WITH par_oPagina.lbl_4c_Label11
1605:             .Caption   = "Fornecedor :"
1606:             .Top       = 305
1607:             .Left      = 36
1608:             .Width     = 64
1609:             .Height    = 15
1610:             .BackStyle = 0
1611:             .ForeColor = RGB(90, 90, 90)
1612:             .FontName  = "Tahoma"
1613:             .FontSize  = 8
1614:             .Visible   = .T.

*-- Linhas 1625 a 1681:
1625:             .FontSize  = 8
1626:             .Visible   = .T.
1627:         ENDWITH
1628:         BINDEVENT(par_oPagina.txt_4c_Ifor, "KeyPress", THIS, "ValidarFornecedorDadosPorCodigo")
1629: 
1630:         par_oPagina.AddObject("txt_4c_Dfor", "TextBox")
1631:         WITH par_oPagina.txt_4c_Dfor
1632:             .Top       = 301
1633:             .Left      = 183
1634:             .Width     = 318
1635:             .Height    = 22
1636:             .MaxLength = 40
1637:             .FontName  = "Tahoma"
1638:             .FontSize  = 8
1639:             .Visible   = .T.
1640:         ENDWITH
1641:         BINDEVENT(par_oPagina.txt_4c_Dfor, "KeyPress", THIS, "ValidarFornecedorDadosPorDescricao")
1642: 
1643:         par_oPagina.AddObject("lbl_4c_Label12", "Label")
1644:         WITH par_oPagina.lbl_4c_Label12
1645:             .Caption   = "Ref. Fornecedor :"
1646:             .Top       = 327
1647:             .Left      = 12
1648:             .Width     = 88
1649:             .Height    = 15
1650:             .BackStyle = 0
1651:             .ForeColor = RGB(90, 90, 90)
1652:             .FontName  = "Tahoma"
1653:             .FontSize  = 8
1654:             .Visible   = .T.
1655:         ENDWITH
1656: 
1657:         par_oPagina.AddObject("txt_4c_Refs", "TextBox")
1658:         WITH par_oPagina.txt_4c_Refs
1659:             .Top       = 324
1660:             .Left      = 102
1661:             .Width     = 221
1662:             .Height    = 22
1663:             .MaxLength = 40
1664:             .FontName  = "Tahoma"
1665:             .FontSize  = 8
1666:             .Visible   = .T.
1667:         ENDWITH
1668: 
1669:         par_oPagina.AddObject("obj_4c_Bot_Fornecedor", "CommandGroup")
1670:         WITH par_oPagina.obj_4c_Bot_Fornecedor
1671:             .ButtonCount = 1
1672:             .Top         = 323
1673:             .Left        = 323
1674:             .Width       = 27
1675:             .Height      = 24
1676:             .BackStyle   = 0
1677:             .Visible     = .T.
1678:         ENDWITH
1679:         WITH par_oPagina.obj_4c_Bot_Fornecedor.Buttons(1)
1680:             .Caption = "..."
1681:             .Top     = 0

*-- Linhas 1710 a 1878:
1710:             .FontSize  = 8
1711:             .Visible   = .T.
1712:         ENDWITH
1713:         BINDEVENT(par_oPagina.txt_4c_CodFinP, "KeyPress", THIS, "ValidarModeloDadosPorCodigo")
1714: 
1715:         par_oPagina.AddObject("txt_4c_DesFinP", "TextBox")
1716:         WITH par_oPagina.txt_4c_DesFinP
1717:             .Top       = 347
1718:             .Left      = 134
1719:             .Width     = 150
1720:             .Height    = 22
1721:             .MaxLength = 30
1722:             .FontName  = "Tahoma"
1723:             .FontSize  = 8
1724:             .Visible   = .T.
1725:         ENDWITH
1726:         BINDEVENT(par_oPagina.txt_4c_DesFinP, "KeyPress", THIS, "ValidarModeloDadosPorDescricao")
1727: 
1728:         *-- Unidade (1) / Unidade (2) - Get_Cuni/Get_Duni e Get_cunip/get_dunip
1729:         par_oPagina.AddObject("lbl_4c_Label14", "Label")
1730:         WITH par_oPagina.lbl_4c_Label14
1731:             .Caption   = "Unidades (1) :"
1732:             .Top       = 420
1733:             .Left      = 30
1734:             .Width     = 70
1735:             .Height    = 15
1736:             .BackStyle = 0
1737:             .ForeColor = RGB(90, 90, 90)
1738:             .FontName  = "Tahoma"
1739:             .FontSize  = 8
1740:             .Visible   = .T.
1741:         ENDWITH
1742: 
1743:         par_oPagina.AddObject("txt_4c_Cuni", "TextBox")
1744:         WITH par_oPagina.txt_4c_Cuni
1745:             .Top       = 416
1746:             .Left      = 102
1747:             .Width     = 31
1748:             .Height    = 22
1749:             .MaxLength = 3
1750:             .FontName  = "Tahoma"
1751:             .FontSize  = 8
1752:             .Visible   = .T.
1753:         ENDWITH
1754:         BINDEVENT(par_oPagina.txt_4c_Cuni, "KeyPress", THIS, "ValidarUnidadeDadosPorCodigo")
1755: 
1756:         par_oPagina.AddObject("txt_4c_Duni", "TextBox")
1757:         WITH par_oPagina.txt_4c_Duni
1758:             .Top       = 416
1759:             .Left      = 134
1760:             .Width     = 150
1761:             .Height    = 22
1762:             .MaxLength = 30
1763:             .FontName  = "Tahoma"
1764:             .FontSize  = 8
1765:             .Visible   = .T.
1766:         ENDWITH
1767:         BINDEVENT(par_oPagina.txt_4c_Duni, "KeyPress", THIS, "ValidarUnidadeDadosPorDescricao")
1768: 
1769:         par_oPagina.AddObject("lbl_4c_Label18", "Label")
1770:         WITH par_oPagina.lbl_4c_Label18
1771:             .Caption   = "(2) :"
1772:             .Top       = 420
1773:             .Left      = 290
1774:             .Width     = 23
1775:             .Height    = 15
1776:             .BackStyle = 0
1777:             .ForeColor = RGB(90, 90, 90)
1778:             .FontName  = "Tahoma"
1779:             .FontSize  = 8
1780:             .Visible   = .T.
1781:         ENDWITH
1782: 
1783:         par_oPagina.AddObject("txt_4c_Cunip", "TextBox")
1784:         WITH par_oPagina.txt_4c_Cunip
1785:             .Top       = 416
1786:             .Left      = 319
1787:             .Width     = 31
1788:             .Height    = 22
1789:             .MaxLength = 3
1790:             .FontName  = "Tahoma"
1791:             .FontSize  = 8
1792:             .Visible   = .T.
1793:         ENDWITH
1794:         BINDEVENT(par_oPagina.txt_4c_Cunip, "KeyPress", THIS, "ValidarUnidadePedidoDadosPorCodigo")
1795: 
1796:         par_oPagina.AddObject("txt_4c__dunip", "TextBox")
1797:         WITH par_oPagina.txt_4c__dunip
1798:             .Top       = 416
1799:             .Left      = 351
1800:             .Width     = 150
1801:             .Height    = 22
1802:             .MaxLength = 30
1803:             .FontName  = "Tahoma"
1804:             .FontSize  = 8
1805:             .Visible   = .T.
1806:         ENDWITH
1807:         BINDEVENT(par_oPagina.txt_4c__dunip, "KeyPress", THIS, "ValidarUnidadePedidoDadosPorDescricao")
1808: 
1809:         *-- Local (Get_Local)
1810:         par_oPagina.AddObject("lbl_4c_Label5", "Label")
1811:         WITH par_oPagina.lbl_4c_Label5
1812:             .Caption   = "Local :"
1813:             .Top       = 397
1814:             .Left      = 354
1815:             .Width     = 33
1816:             .Height    = 15
1817:             .BackStyle = 0
1818:             .ForeColor = RGB(90, 90, 90)
1819:             .FontName  = "Tahoma"
1820:             .FontSize  = 8
1821:             .Visible   = .T.
1822:         ENDWITH
1823: 
1824:         par_oPagina.AddObject("txt_4c_Local", "TextBox")
1825:         WITH par_oPagina.txt_4c_Local
1826:             .Top       = 393
1827:             .Left      = 390
1828:             .Width     = 111
1829:             .Height    = 22
1830:             .MaxLength = 10
1831:             .FontName  = "Tahoma"
1832:             .FontSize  = 8
1833:             .Visible   = .T.
1834:         ENDWITH
1835:         BINDEVENT(par_oPagina.txt_4c_Local, "KeyPress", THIS, "ValidarLocalDados")
1836: 
1837:         *-- Situacao (opc_situacao) - Ativo/Inativo (situas)
1838:         par_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
1839:         WITH par_oPagina.obj_4c_Opc_situacao
1840:             .ButtonCount = 2
1841:             .Top         = 114
1842:             .Left        = 758
1843:             .Width       = 160
1844:             .Height      = 25
1845:             .BackStyle   = 0
1846:             .Value       = 1
1847:             .Visible     = .T.
1848:         ENDWITH
1849:         WITH par_oPagina.obj_4c_Opc_situacao.Buttons(1)
1850:             .Caption   = "Ativo"
1851:             .BackStyle = 0
1852:             .Top       = 3
1853:             .Left      = 2
1854:             .Width     = 70
1855:             .AutoSize  = .T.
1856:             .ForeColor = RGB(90, 90, 90)
1857:             .FontName  = "Tahoma"
1858:             .FontSize  = 8
1859:         ENDWITH
1860:         WITH par_oPagina.obj_4c_Opc_situacao.Buttons(2)
1861:             .Caption   = "Inativo"
1862:             .BackStyle = 0
1863:             .Top       = 3
1864:             .Left      = 80
1865:             .Width     = 70
1866:             .AutoSize  = .T.
1867:             .ForeColor = RGB(90, 90, 90)
1868:             .FontName  = "Tahoma"
1869:             .FontSize  = 8
1870:         ENDWITH
1871: 
1872:         *-- Observacoes livres (getObs1/getObs2/GetObs3)
1873:         par_oPagina.AddObject("txt_4c_Obs1", "TextBox")
1874:         WITH par_oPagina.txt_4c_Obs1
1875:             .Top       = 235
1876:             .Left      = 633
1877:             .Width     = 159
1878:             .Height    = 23

*-- Linhas 1945 a 2066:
1945:             .FontSize  = 8
1946:             .Visible   = .T.
1947:         ENDWITH
1948:         BINDEVENT(par_oPagina.txt_4c_Mctotal, "KeyPress", THIS, "ValidarMoedaCustoTotalDados")
1949: 
1950:         par_oPagina.AddObject("lbl_4c_Label4", "Label")
1951:         WITH par_oPagina.lbl_4c_Label4
1952:             .Caption   = "Valor de Venda :"
1953:             .Top       = 335
1954:             .Left      = 510
1955:             .Width     = 120
1956:             .Height    = 15
1957:             .BackStyle = 0
1958:             .ForeColor = RGB(90, 90, 90)
1959:             .FontName  = "Tahoma"
1960:             .FontSize  = 8
1961:             .Visible   = .T.
1962:         ENDWITH
1963: 
1964:         par_oPagina.AddObject("txt_4c_Pvenda", "TextBox")
1965:         WITH par_oPagina.txt_4c_Pvenda
1966:             .Top       = 331
1967:             .Left      = 633
1968:             .Width     = 127
1969:             .Height    = 23
1970:             .ReadOnly  = .T.
1971:             .FontName  = "Tahoma"
1972:             .FontSize  = 8
1973:             .Visible   = .T.
1974:         ENDWITH
1975: 
1976:         par_oPagina.AddObject("txt_4c_Mpvenda", "TextBox")
1977:         WITH par_oPagina.txt_4c_Mpvenda
1978:             .Top       = 331
1979:             .Left      = 761
1980:             .Width     = 31
1981:             .Height    = 23
1982:             .MaxLength = 3
1983:             .FontName  = "Tahoma"
1984:             .FontSize  = 8
1985:             .Visible   = .T.
1986:         ENDWITH
1987:         BINDEVENT(par_oPagina.txt_4c_Mpvenda, "KeyPress", THIS, "ValidarMoedaValorVendaDados")
1988: 
1989:         par_oPagina.AddObject("lbl_4c_Label6", "Label")
1990:         WITH par_oPagina.lbl_4c_Label6
1991:             .Caption   = "Fator  de Venda :"
1992:             .Top       = 359
1993:             .Left      = 544
1994:             .Width     = 86
1995:             .Height    = 15
1996:             .BackStyle = 0
1997:             .ForeColor = RGB(90, 90, 90)
1998:             .FontName  = "Tahoma"
1999:             .FontSize  = 8
2000:             .Visible   = .T.
2001:         ENDWITH
2002: 
2003:         par_oPagina.AddObject("txt_4c_Fvenda", "TextBox")
2004:         WITH par_oPagina.txt_4c_Fvenda
2005:             .Top       = 355
2006:             .Left      = 633
2007:             .Width     = 127
2008:             .Height    = 23
2009:             .ReadOnly  = .T.
2010:             .FontName  = "Tahoma"
2011:             .FontSize  = 8
2012:             .Visible   = .T.
2013:         ENDWITH
2014: 
2015:         par_oPagina.AddObject("txt_4c_Mfvenda", "TextBox")
2016:         WITH par_oPagina.txt_4c_Mfvenda
2017:             .Top       = 355
2018:             .Left      = 761
2019:             .Width     = 31
2020:             .Height    = 23
2021:             .MaxLength = 3
2022:             .FontName  = "Tahoma"
2023:             .FontSize  = 8
2024:             .Visible   = .T.
2025:         ENDWITH
2026:         BINDEVENT(par_oPagina.txt_4c_Mfvenda, "KeyPress", THIS, "ValidarMoedaFatorVendaDados")
2027: 
2028:         *-- Estoque (calculado - somente leitura)
2029:         par_oPagina.AddObject("lbl_4c_Label28", "Label")
2030:         WITH par_oPagina.lbl_4c_Label28
2031:             .Caption   = "Estoque :"
2032:             .Top       = 287
2033:             .Left      = 582
2034:             .Width     = 48
2035:             .Height    = 15
2036:             .BackStyle = 0
2037:             .ForeColor = RGB(90, 90, 90)
2038:             .FontName  = "Tahoma"
2039:             .FontSize  = 8
2040:             .Visible   = .T.
2041:         ENDWITH
2042: 
2043:         par_oPagina.AddObject("txt_4c_Estoques", "TextBox")
2044:         WITH par_oPagina.txt_4c_Estoques
2045:             .Top       = 283
2046:             .Left      = 633
2047:             .Width     = 79
2048:             .Height    = 23
2049:             .ReadOnly  = .T.
2050:             .FontName  = "Tahoma"
2051:             .FontSize  = 8
2052:             .Visible   = .T.
2053:         ENDWITH
2054: 
2055:         par_oPagina.AddObject("txt_4c_QtdEsts", "TextBox")
2056:         WITH par_oPagina.txt_4c_QtdEsts
2057:             .Top       = 283
2058:             .Left      = 713
2059:             .Width     = 79
2060:             .Height    = 23
2061:             .ReadOnly  = .T.
2062:             .FontName  = "Tahoma"
2063:             .FontSize  = 8
2064:             .Visible   = .T.
2065:         ENDWITH
2066: 

*-- Linhas 2314 a 2440:
2314:             .FontSize      = 8
2315:             .Visible       = .T.
2316:         ENDWITH
2317:         BINDEVENT(par_oPagina.txt_4c_Conjunto, "KeyPress", THIS, "ValidarConjuntoDados")
2318: 
2319:         *-- cmdConjunto: gera um Cod. Pai novo (legado usa fGerUniqueKey)
2320:         par_oPagina.AddObject("obj_4c_CmdConjunto", "CommandGroup")
2321:         WITH par_oPagina.obj_4c_CmdConjunto
2322:             .ButtonCount = 1
2323:             .Top         = 186
2324:             .Left        = 502
2325:             .Width       = 27
2326:             .Height      = 24
2327:             .BackStyle   = 0
2328:             .BorderStyle = 0
2329:             .BackColor   = RGB(255, 255, 255)
2330:             .AutoSize    = .F.
2331:             .Visible     = .T.
2332:         ENDWITH
2333:         WITH par_oPagina.obj_4c_CmdConjunto.Buttons(1)
2334:             .Caption       = ""
2335:             .Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
2336:             .ToolTipText   = "Gerar Cod. Pai"
2337:             .Top           = -1
2338:             .Left          = -1
2339:             .Width         = 29
2340:             .Height        = 26
2341:             .FontName      = "Small Fonts"
2342:             .FontSize      = 7
2343:             .SpecialEffect = 0
2344:             .BackColor     = RGB(162, 214, 242)
2345:         ENDWITH
2346:         BINDEVENT(par_oPagina.obj_4c_CmdConjunto, "Click", THIS, "BtnGerarConjuntoClick")
2347: 
2348:         *-- cmdLocConj: localiza um Cod. Pai ja existente
2349:         par_oPagina.AddObject("obj_4c_CmdLocConj", "CommandGroup")
2350:         WITH par_oPagina.obj_4c_CmdLocConj
2351:             .ButtonCount = 1
2352:             .Top         = 186
2353:             .Left        = 529
2354:             .Width       = 27
2355:             .Height      = 24
2356:             .BackStyle   = 0
2357:             .BorderStyle = 0
2358:             .BackColor   = RGB(255, 255, 255)
2359:             .AutoSize    = .F.
2360:             .Visible     = .T.
2361:         ENDWITH
2362:         WITH par_oPagina.obj_4c_CmdLocConj.Buttons(1)
2363:             .Caption       = ""
2364:             .Picture       = gc_4c_CaminhoIcones + "geral_lupa_16.jpg"
2365:             .ToolTipText   = "Localizar Cod. Pai."
2366:             .Top           = -1
2367:             .Left          = -1
2368:             .Width         = 29
2369:             .Height        = 26
2370:             .FontName      = "Small Fonts"
2371:             .FontSize      = 7
2372:             .SpecialEffect = 0
2373:             .BackColor     = RGB(240, 240, 240)
2374:         ENDWITH
2375:         BINDEVENT(par_oPagina.obj_4c_CmdLocConj, "Click", THIS, "BtnLocalizarConjuntoClick")
2376: 
2377:         THIS.TornarControlesVisiveis(par_oPagina)
2378:     ENDPROC
2379: 
2380:     *===========================================================================
2381:     * ConfigurarPgpgComposicao - Campos da aba "Componente" (pgComposicao
2382:     * legado) dentro de pgf_4c_Divisoes.Page2. Posicoes saem DIRETO do
2383:     * layout.json (mesmo calculo do PageFrame interno usado em
2384:     * ConfigurarAbaDadosPrincipais - ver comentario em ConfigurarPaginaDados).
2385:     *
2386:     * FASE 9 - so a camada VISUAL (controles + lookups de codigo isolado).
2387:     * As grades de dados (grd_4c_Compo/SubCp/GradeGrupo/Relogios) ficam SEM
2388:     * RecordSource/ControlSource nesta fase (regra #41 do CLAUDE.md: ligar
2389:     * Column.ControlSource antes do cursor existir derruba o Init) e os
2390:     * botoes cmdgCompo/cmdgSubCp/cmdCalcVals ficam SEM Click - a logica de
2391:     * negocio (FiltrarCompo, CalcPreco, AtuaPreco, CalcFornec, TotalGrupo)
2392:     * e as 4 grades legadas de composicao entram em fase propria.
2393:     *
2394:     * DESVIO DE NOME (mapeamento.json): o gerador colidiu "grd_4c_Dados" nas
2395:     * QUATRO grades desta mesma pagina (grdCompo/GradeGRUPO/grdsubcp/
2396:     * grdRelogios sao todas filhas diretas de pgComposicao) - AddObject
2397:     * duplicado no mesmo container. Renomeado para grd_4c_Compo/GradeGrupo/
2398:     * SubCp/Relogios; mapeamento.json atualizado para registrar a correcao.
2399:     *===========================================================================
2400:     PROTECTED PROCEDURE ConfigurarPgpgComposicao()
2401:         LOCAL par_oPagina
2402:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
2403: 
2404:         *-- Grade principal de componentes (grdCompo legado, 14 colunas)
2405:         par_oPagina.AddObject("grd_4c_Compo", "Grid")
2406:         par_oPagina.grd_4c_Compo.ColumnCount = 14
2407:         WITH par_oPagina.grd_4c_Compo
2408:             .Top                = 117
2409:             .Left               = 6
2410:             .Width              = 943
2411:             .Height             = 147
2412:             .FontName           = "Verdana"
2413:             .FontSize           = 8
2414:             .ForeColor          = RGB(90, 90, 90)
2415:             .BackColor          = RGB(255, 255, 255)
2416:             .GridLineColor      = RGB(238, 238, 238)
2417:             .HighlightBackColor = RGB(255, 255, 255)
2418:             .HighlightForeColor = RGB(15, 41, 104)
2419:             .HighlightStyle     = 2
2420:             .DeleteMark         = .F.
2421:             .RecordMark         = .F.
2422:             .RowHeight          = 16
2423:             .ScrollBars         = 2
2424:             .GridLines          = 3
2425:             .ReadOnly           = .F.
2426:             .Visible            = .T.
2427: 
2428:             .Column1.Width  = 85
2429:             .Column1.Header1.Caption = "Material"
2430:             .Column2.Width  = 224
2431:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2432:             .Column3.Width  = 30
2433:             .Column3.Header1.Caption = "Un"
2434:             .Column4.Width  = 65
2435:             .Column4.Header1.Caption = "Valor"
2436:             .Column5.Width  = 55
2437:             .Column5.Header1.Caption = "Qtde."
2438:             .Column6.Width  = 65
2439:             .Column6.Header1.Caption = "Total"
2440:             .Column7.Width  = 32

*-- Linhas 2735 a 2805:
2735:             .FontSize  = 8
2736:             .Visible   = .T.
2737:         ENDWITH
2738:         BINDEVENT(par_oPagina.txt_4c_Moec, "KeyPress", THIS, "ValidarMoedaCustoComposicao")
2739: 
2740:         par_oPagina.AddObject("lbl_4c_Label22", "Label")
2741:         WITH par_oPagina.lbl_4c_Label22
2742:             .Caption   = "MKP"
2743:             .Top       = 514
2744:             .Left      = 7
2745:             .Width     = 22
2746:             .Height    = 15
2747:             .BackStyle = 0
2748:             .ForeColor = RGB(90, 90, 90)
2749:             .FontName  = "Tahoma"
2750:             .FontSize  = 8
2751:             .Visible   = .T.
2752:         ENDWITH
2753: 
2754:         par_oPagina.AddObject("txt_4c_Cmkpc", "TextBox")
2755:         WITH par_oPagina.txt_4c_Cmkpc
2756:             .Top       = 529
2757:             .Left      = 7
2758:             .Width     = 24
2759:             .Height    = 23
2760:             .MaxLength = 2
2761:             .FontName  = "Tahoma"
2762:             .FontSize  = 8
2763:             .Visible   = .T.
2764:         ENDWITH
2765:         BINDEVENT(par_oPagina.txt_4c_Cmkpc, "KeyPress", THIS, "ValidarFeitioCustoComposicao")
2766: 
2767:         par_oPagina.AddObject("lbl_4c_LblValAdics", "Label")
2768:         WITH par_oPagina.lbl_4c_LblValAdics
2769:             .Caption   = "Valor Adicional"
2770:             .Top       = 514
2771:             .Left      = 62
2772:             .Width     = 71
2773:             .Height    = 15
2774:             .BackStyle = 0
2775:             .ForeColor = RGB(90, 90, 90)
2776:             .FontName  = "Tahoma"
2777:             .FontSize  = 8
2778:             .Visible   = .T.
2779:         ENDWITH
2780: 
2781:         par_oPagina.AddObject("txt_4c__pftioc", "TextBox")
2782:         WITH par_oPagina.txt_4c__pftioc
2783:             .Top      = 529
2784:             .Left     = 62
2785:             .Width    = 94
2786:             .Height   = 23
2787:             .FontName = "Tahoma"
2788:             .FontSize = 8
2789:             .Visible  = .T.
2790:         ENDWITH
2791: 
2792:         par_oPagina.AddObject("chk_4c_ChkPlanCus", "CheckBox")
2793:         WITH par_oPagina.chk_4c_ChkPlanCus
2794:             .Caption = ""
2795:             .Top     = 528
2796:             .Left    = 34
2797:             .Width   = 25
2798:             .Height  = 25
2799:             .Value   = 0
2800:             .Visible = .T.
2801:         ENDWITH
2802: 
2803:         par_oPagina.AddObject("lbl_4c_Label6", "Label")
2804:         WITH par_oPagina.lbl_4c_Label6
2805:             .Caption   = "Peso M" + CHR(233) + "dio"

*-- Linhas 2911 a 2967:
2911:             .FontSize  = 8
2912:             .Visible   = .T.
2913:         ENDWITH
2914:         BINDEVENT(par_oPagina.txt_4c_Moepc, "KeyPress", THIS, "ValidarMoedaCustoPComposicao")
2915: 
2916:         par_oPagina.AddObject("txt_4c_Moecusf", "TextBox")
2917:         WITH par_oPagina.txt_4c_Moecusf
2918:             .Top       = 529
2919:             .Left      = 270
2920:             .Width     = 31
2921:             .Height    = 23
2922:             .MaxLength = 3
2923:             .FontName  = "Tahoma"
2924:             .FontSize  = 8
2925:             .Visible   = .T.
2926:         ENDWITH
2927:         BINDEVENT(par_oPagina.txt_4c_Moecusf, "KeyPress", THIS, "ValidarMoedaCustoFComposicao")
2928: 
2929:         par_oPagina.AddObject("shp_4c_Shape6", "Shape")
2930:         WITH par_oPagina.shp_4c_Shape6
2931:             .Top     = 468
2932:             .Left    = 7
2933:             .Width   = 369
2934:             .Height  = 2
2935:             .Visible = .T.
2936:         ENDWITH
2937: 
2938:         *-- Bloco "Venda" (direita) - Preco Ideal / Preco Atual
2939:         par_oPagina.AddObject("lbl_4c_Label2", "Label")
2940:         WITH par_oPagina.lbl_4c_Label2
2941:             .Caption   = " Venda "
2942:             .Top       = 442
2943:             .Left      = 421
2944:             .Width     = 48
2945:             .Height    = 16
2946:             .BackStyle = 0
2947:             .ForeColor = RGB(90, 90, 90)
2948:             .FontName  = "Tahoma"
2949:             .FontSize  = 8
2950:             .Visible   = .T.
2951:         ENDWITH
2952: 
2953:         par_oPagina.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
2954:         WITH par_oPagina.chk_4c_ChkLiberaVenda
2955:             .Caption = ""
2956:             .Top     = 431
2957:             .Left    = 383
2958:             .Width   = 35
2959:             .Height  = 35
2960:             .Value   = 0
2961:             .Visible = .T.
2962:         ENDWITH
2963: 
2964:         par_oPagina.AddObject("txt_4c_Margem", "TextBox")
2965:         WITH par_oPagina.txt_4c_Margem
2966:             .Top      = 489
2967:             .Left     = 383

*-- Linhas 3011 a 3054:
3011:             .FontSize  = 8
3012:             .Visible   = .T.
3013:         ENDWITH
3014:         BINDEVENT(par_oPagina.txt_4c_Status, "KeyPress", THIS, "ValidarStatusComposicao")
3015: 
3016:         par_oPagina.AddObject("lbl_4c_LblMkpApl", "Label")
3017:         WITH par_oPagina.lbl_4c_LblMkpApl
3018:             .Caption   = "MKP Aplic."
3019:             .Top       = 553
3020:             .Left      = 384
3021:             .Width     = 51
3022:             .Height    = 15
3023:             .BackStyle = 0
3024:             .ForeColor = RGB(90, 90, 90)
3025:             .FontName  = "Tahoma"
3026:             .FontSize  = 8
3027:             .Visible   = .T.
3028:         ENDWITH
3029: 
3030:         par_oPagina.AddObject("chk_4c_ChkPlanVen", "CheckBox")
3031:         WITH par_oPagina.chk_4c_ChkPlanVen
3032:             .Caption = ""
3033:             .Top     = 528
3034:             .Left    = 447
3035:             .Width   = 25
3036:             .Height  = 25
3037:             .Value   = 0
3038:             .Visible = .T.
3039:         ENDWITH
3040: 
3041:         par_oPagina.AddObject("shp_4c_Shape4", "Shape")
3042:         WITH par_oPagina.shp_4c_Shape4
3043:             .Top     = 468
3044:             .Left    = 383
3045:             .Width   = 350
3046:             .Height  = 2
3047:             .Visible = .T.
3048:         ENDWITH
3049: 
3050:         par_oPagina.AddObject("chk_4c_Chk_Pvenda", "CheckBox")
3051:         WITH par_oPagina.chk_4c_Chk_Pvenda
3052:             .Caption = ""
3053:             .Top     = 567
3054:             .Left    = 447

*-- Linhas 3283 a 3377:
3283:             .FontSize  = 8
3284:             .Visible   = .T.
3285:         ENDWITH
3286:         BINDEVENT(par_oPagina.txt_4c_Ftio, "KeyPress", THIS, "ValidarFeitioVendaComposicao")
3287: 
3288:         par_oPagina.AddObject("txt_4c_Mftio", "TextBox")
3289:         WITH par_oPagina.txt_4c_Mftio
3290:             .Top       = 529
3291:             .Left      = 584
3292:             .Width     = 31
3293:             .Height    = 23
3294:             .ReadOnly  = .T.
3295:             .FontName  = "Tahoma"
3296:             .FontSize  = 8
3297:             .Visible   = .T.
3298:         ENDWITH
3299: 
3300:         par_oPagina.AddObject("txt_4c_Moeda", "TextBox")
3301:         WITH par_oPagina.txt_4c_Moeda
3302:             .Top       = 489
3303:             .Left      = 584
3304:             .Width     = 31
3305:             .Height    = 23
3306:             .MaxLength = 3
3307:             .FontName  = "Tahoma"
3308:             .FontSize  = 8
3309:             .Visible   = .T.
3310:         ENDWITH
3311:         BINDEVENT(par_oPagina.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoedaVendaComposicao")
3312: 
3313:         par_oPagina.AddObject("txt_4c_Moev", "TextBox")
3314:         WITH par_oPagina.txt_4c_Moev
3315:             .Top       = 568
3316:             .Left      = 584
3317:             .Width     = 31
3318:             .Height    = 23
3319:             .MaxLength = 3
3320:             .FontName  = "Tahoma"
3321:             .FontSize  = 8
3322:             .Visible   = .T.
3323:         ENDWITH
3324:         BINDEVENT(par_oPagina.txt_4c_Moev, "KeyPress", THIS, "ValidarMoedaVendaVComposicao")
3325: 
3326:         par_oPagina.AddObject("txt_4c_Moepv", "TextBox")
3327:         WITH par_oPagina.txt_4c_Moepv
3328:             .Top       = 529
3329:             .Left      = 726
3330:             .Width     = 31
3331:             .Height    = 23
3332:             .MaxLength = 3
3333:             .FontName  = "Tahoma"
3334:             .FontSize  = 8
3335:             .Visible   = .T.
3336:         ENDWITH
3337:         BINDEVENT(par_oPagina.txt_4c_Moepv, "KeyPress", THIS, "ValidarMoedaVendaPVComposicao")
3338: 
3339:         par_oPagina.AddObject("lbl_4c_Label25", "Label")
3340:         WITH par_oPagina.lbl_4c_Label25
3341:             .Caption   = "Financeiro"
3342:             .Top       = 553
3343:             .Left      = 727
3344:             .Width     = 51
3345:             .Height    = 15
3346:             .BackStyle = 0
3347:             .ForeColor = RGB(90, 90, 90)
3348:             .FontName  = "Tahoma"
3349:             .FontSize  = 8
3350:             .Visible   = .T.
3351:         ENDWITH
3352: 
3353:         par_oPagina.AddObject("txt_4c_Encarg", "TextBox")
3354:         WITH par_oPagina.txt_4c_Encarg
3355:             .Top      = 567
3356:             .Left     = 727
3357:             .Width    = 62
3358:             .Height   = 23
3359:             .FontName = "Tahoma"
3360:             .FontSize = 8
3361:             .Visible  = .T.
3362:         ENDWITH
3363: 
3364:         *-- Botao "Calcular" (cmdCalcVals legado - icone-only sem evidencia
3365:         *-- de Picture no dump; regra #25 do CLAUDE.md - usar texto em vez
3366:         *-- de inventar icone)
3367:         par_oPagina.AddObject("cmd_4c_CalcVals", "CommandButton")
3368:         WITH par_oPagina.cmd_4c_CalcVals
3369:             .Caption  = "Calc"
3370:             .Top      = 479
3371:             .Left     = 727
3372:             .Width    = 40
3373:             .Height   = 40
3374:             .FontName = "Tahoma"
3375:             .FontSize = 7
3376:             .Visible  = .T.
3377:         ENDWITH

*-- Linhas 3429 a 3472:
3429:             .FontSize  = 8
3430:             .Visible   = .T.
3431:         ENDWITH
3432:         BINDEVENT(par_oPagina.txt_4c_MatP, "KeyPress", THIS, "ValidarMaterialPrincipalComposicao")
3433: 
3434:         *-- Observacao da OF (getObsOFs - obsofs char(120))
3435:         par_oPagina.AddObject("lbl_4c_Label4", "Label")
3436:         WITH par_oPagina.lbl_4c_Label4
3437:             .Caption   = "Obs. da OF :"
3438:             .Top       = 269
3439:             .Left      = 33
3440:             .Width     = 64
3441:             .Height    = 15
3442:             .BackStyle = 0
3443:             .ForeColor = RGB(90, 90, 90)
3444:             .FontName  = "Tahoma"
3445:             .FontSize  = 8
3446:             .Visible   = .T.
3447:         ENDWITH
3448: 
3449:         par_oPagina.AddObject("txt_4c_ObsOFs", "TextBox")
3450:         WITH par_oPagina.txt_4c_ObsOFs
3451:             .Top       = 266
3452:             .Left      = 99
3453:             .Width     = 850
3454:             .Height    = 21
3455:             .MaxLength = 120
3456:             .FontName  = "Tahoma"
3457:             .FontSize  = 8
3458:             .Visible   = .T.
3459:         ENDWITH
3460: 
3461:         *-- Resumo por grupo (GradeGRUPO legado - 3 colunas, so leitura)
3462:         par_oPagina.AddObject("grd_4c_GradeGrupo", "Grid")
3463:         par_oPagina.grd_4c_GradeGrupo.ColumnCount = 3
3464:         WITH par_oPagina.grd_4c_GradeGrupo
3465:             .Top                = 41
3466:             .Left               = 619
3467:             .Width              = 215
3468:             .Height             = 68
3469:             .FontName           = "Verdana"
3470:             .FontSize           = 8
3471:             .ForeColor          = RGB(90, 90, 90)
3472:             .BackColor          = RGB(255, 255, 255)

*-- Linhas 3640 a 3747:
3640:         *-- Left/Width/Height do grd_4c_Compo - so uma das duas aparece por
3641:         *-- vez conforme ThisForm.Relogios no legado. A logica de alternancia
3642:         *-- fica para fase posterior (aqui so a camada visual): a grade fica
3643:         *-- OCULTA por padrao (produto normal), via excecao em TornarControlesVisiveis.
3644:         par_oPagina.AddObject("grd_4c_Relogios", "Grid")
3645:         par_oPagina.grd_4c_Relogios.ColumnCount = 4
3646:         WITH par_oPagina.grd_4c_Relogios
3647:             .Top                = 117
3648:             .Left               = 6
3649:             .Width              = 943
3650:             .Height             = 307
3651:             .FontName           = "Verdana"
3652:             .FontSize           = 8
3653:             .ForeColor          = RGB(90, 90, 90)
3654:             .BackColor          = RGB(255, 255, 255)
3655:             .GridLineColor      = RGB(238, 238, 238)
3656:             .HighlightBackColor = RGB(255, 255, 255)
3657:             .HighlightForeColor = RGB(15, 41, 104)
3658:             .HighlightStyle     = 2
3659:             .DeleteMark         = .F.
3660:             .RecordMark         = .F.
3661:             .RowHeight          = 16
3662:             .ScrollBars         = 2
3663:             .GridLines          = 3
3664:             .ReadOnly           = .T.
3665:             .Visible            = .F.
3666: 
3667:             .Column1.Width = 60
3668:             .Column1.Header1.Caption = "Grp"
3669:             .Column2.Width = 350
3670:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3671:             .Column3.Width = 150
3672:             .Column3.Header1.Caption = "Produto"
3673:             .Column4.Width = 383
3674:             .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3675:         ENDWITH
3676: 
3677:         THIS.TornarControlesVisiveis(par_oPagina)
3678:     ENDPROC
3679: 
3680:     *===========================================================================
3681:     * ConfigurarPgpgCusto - Campos da aba "Composicao" (pgCusto legado) dentro
3682:     * de pgf_4c_Divisoes.Page6. Posicoes saem DIRETO do layout.json, mesmo
3683:     * calculo das demais sub-paginas (sem offset adicional).
3684:     *
3685:     * FASE 10 - so a camada VISUAL. pgCusto eh uma visao ALTERNATIVA da mesma
3686:     * grade de composicao (crSigPrCpo) ja tratada em ConfigurarPgpgComposicao,
3687:     * agrupada por Tipo (cmbTipos). Por isso:
3688:     *   - grd_4c_Compo fica SEM RecordSource/ControlSource (regra #41 do
3689:     *     CLAUDE.md: ligar antes do cursor existir derruba o Init);
3690:     *   - obj_4c_CmdgCompo (Inserir/Excluir) fica SEM Click - mesma logica de
3691:     *     negocio (FiltrarCompo) ja fora de escopo na pagina irma;
3692:     *   - cmbTipos.Valid dispara FiltrarCompo(2) no legado - fora de escopo;
3693:     *   - grdCompo.Procedure (AfterRowColChange) atualiza getDGruCompos via
3694:     *     SQL na linha selecionada - depende de cursor populado, fora de
3695:     *     escopo por ser reacao a dado, nao layout.
3696:     *
3697:     * Coluna 9 ("Etiq"): mesma cursor/tabela (crSigPrCpo) e mesma posicao
3698:     * relativa da coluna "E" (chk_4c_Etiqueta) ja criada em
3699:     * ConfigurarPgpgComposicao - reproduzida aqui como checkbox pela regra
3700:     * #18 (AddObject + CurrentControl + Sparse = .F.).
3701:     *
3702:     * grd_4c_Compo/grd_4c_GradeGrupo2 (DESVIO DE NOME, mapeamento.json): o
3703:     * gerador colidiu "grd_4c_Dados" nas DUAS grades desta pagina (ambas
3704:     * filhas diretas de pgCusto) - renomeado para grd_4c_Compo/GradeGrupo2,
3705:     * mesmo padrao ja usado em pgComposicao; mapeamento.json atualizado.
3706:     *===========================================================================
3707:     PROTECTED PROCEDURE ConfigurarPgpgCusto()
3708:         LOCAL par_oPagina
3709:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
3710: 
3711:         *-- Grade de composicao por tipo (grdCompo legado, 12 colunas)
3712:         par_oPagina.AddObject("grd_4c_Compo", "Grid")
3713:         par_oPagina.grd_4c_Compo.ColumnCount = 12
3714:         WITH par_oPagina.grd_4c_Compo
3715:             .Top                = 178
3716:             .Left               = 34
3717:             .Width              = 813
3718:             .Height             = 230
3719:             .FontName           = "Verdana"
3720:             .FontSize           = 8
3721:             .ForeColor          = RGB(90, 90, 90)
3722:             .BackColor          = RGB(255, 255, 255)
3723:             .GridLineColor      = RGB(238, 238, 238)
3724:             .HighlightBackColor = RGB(255, 255, 255)
3725:             .HighlightForeColor = RGB(15, 41, 104)
3726:             .HighlightStyle     = 2
3727:             .DeleteMark         = .F.
3728:             .RecordMark         = .F.
3729:             .RowHeight          = 16
3730:             .ScrollBars         = 2
3731:             .GridLines          = 3
3732:             .ReadOnly           = .F.
3733:             .Visible            = .T.
3734: 
3735:             .Column1.Width  = 45
3736:             .Column1.Header1.Caption = "Item"
3737:             .Column2.Width  = 215
3738:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3739:             .Column3.Width  = 32
3740:             .Column3.Header1.Caption = "Un"
3741:             .Column4.Width  = 68
3742:             .Column4.Header1.Caption = "Valor"
3743:             .Column5.Width  = 50
3744:             .Column5.Header1.Caption = "Qtd"
3745:             .Column6.Width  = 68
3746:             .Column6.Header1.Caption = "Total"
3747:             .Column7.Width  = 35

*-- Linhas 3904 a 3926:
3904:             .Width   = 158
3905:             .Height  = 2
3906:             .Visible = .T.
3907:         ENDWITH
3908: 
3909:         par_oPagina.AddObject("grd_4c_GradeGrupo2", "Grid")
3910:         par_oPagina.grd_4c_GradeGrupo2.ColumnCount = 3
3911:         WITH par_oPagina.grd_4c_GradeGrupo2
3912:             .Top                = 468
3913:             .Left               = 35
3914:             .Width              = 195
3915:             .Height             = 141
3916:             .FontName           = "Verdana"
3917:             .FontSize           = 8
3918:             .ForeColor          = RGB(90, 90, 90)
3919:             .BackColor          = RGB(255, 255, 255)
3920:             .GridLineColor      = RGB(238, 238, 238)
3921:             .HighlightBackColor = RGB(255, 255, 255)
3922:             .HighlightForeColor = RGB(15, 41, 104)
3923:             .HighlightStyle     = 2
3924:             .DeleteMark         = .F.
3925:             .RecordMark         = .F.
3926:             .RowHeight          = 16

*-- Linhas 3937 a 4002:
3937:             .Column3.Header1.Caption = "Moe"
3938:         ENDWITH
3939: 
3940:         THIS.TornarControlesVisiveis(par_oPagina)
3941:     ENDPROC
3942: 
3943:     *===========================================================================
3944:     * ConfigurarPgPgDadosFaseP - Aba "Processos" (PgDadosFaseP legado - Page4)
3945:     *
3946:     * FASE 12 - camada VISUAL completa (70 objetos do layout.json/dump).
3947:     * GradFase (5 colunas) e grdMatrizes (3 colunas) espelham os cursores
3948:     * crSigCdPrf/crSigPrMtz do legado - NAO existem nesta fase (regra #41 do
3949:     * CLAUDE.md: ligar Column.ControlSource antes do cursor existir derruba o
3950:     * Init), por isso ficam SEM RecordSource/ControlSource, e os botoes
3951:     * inserir/excluir/Alternativa/CmdFicha/btnInsereMtx/btnExcluiMtz (que
3952:     * operam sobre essas grades) ficam SEM Click - mesmo padrao de deferimento
3953:     * usado em ConfigurarPgpgComposicao/ConfigurarPgpgCusto/ConfigurarPgPgDadosConsP.
3954:     * Get_Desc/Get_Obs (ControlSource crSigCdGcr.descrs / crSigCdPrf.Obs) pela
3955:     * mesma razao ficam sem ControlSource.
3956:     *
3957:     * Os QUATRO campos de codigo isolado (Acabamento/Cor/Tamanho/Conquilha)
3958:     * SAO lookups simples contra tabela mestre (sem dependencia de cursor de
3959:     * grade) e por isso recebem BINDEVENT + ExecutarLookupGenerico, igual aos
3960:     * demais campos de codigo isolado da aba "Dados Principais".
3961:     *===========================================================================
3962:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP()
3963:         LOCAL par_oPagina
3964:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
3965: 
3966:         *-- Imagem do processo/fase (shpFig / ImgFigJpg - espelha crSigCdPrf.FigProcs)
3967:         par_oPagina.AddObject("shp_4c_ShpFig", "Shape")
3968:         WITH par_oPagina.shp_4c_ShpFig
3969:             .Top     = 129
3970:             .Left    = 231
3971:             .Width   = 244
3972:             .Height  = 148
3973:             .Visible = .T.
3974:         ENDWITH
3975: 
3976:         par_oPagina.AddObject("img_4c_ImgFigJpg", "Image")
3977:         WITH par_oPagina.img_4c_ImgFigJpg
3978:             .Top     = 130
3979:             .Left    = 232
3980:             .Width   = 241
3981:             .Height  = 146
3982:             .Stretch = 2
3983:             .Visible = .T.
3984:         ENDWITH
3985: 
3986:         *-- Botoes de captura de imagem (arquivo / webcam) - estruturais nesta
3987:         *-- fase (Picture + posicao); Click entra quando o subsistema de
3988:         *-- imagem for migrado (mesmo padrao de ConfigurarAbaDadosPrincipais).
3989:         par_oPagina.AddObject("obj_4c_CmdgFigura", "CommandGroup")
3990:         WITH par_oPagina.obj_4c_CmdgFigura
3991:             .ButtonCount = 1
3992:             .Top         = 169
3993:             .Left        = 482
3994:             .Width       = 40
3995:             .Height      = 40
3996:             .BackStyle   = 0
3997:             .Visible     = .T.
3998:         ENDWITH
3999:         WITH par_oPagina.obj_4c_CmdgFigura.Buttons(1)
4000:             .Picture     = gc_4c_CaminhoIcones + "geral_picture_26.jpg"
4001:             .ToolTipText = "Capturar Imagem do Produto"
4002:             .Top         = 0

*-- Linhas 4123 a 4166:
4123:             .FontSize  = 8
4124:             .Visible   = .T.
4125:         ENDWITH
4126:         BINDEVENT(par_oPagina.txt_4c_Conquilha, "KeyPress", THIS, "ValidarConquilhaDados")
4127: 
4128:         *-- Peso Brilhante / Peso Metal / Peso Pedra (getPesoBris/getPesoMetal/getPesoPdrs)
4129:         par_oPagina.AddObject("lbl_4c_Label9", "Label")
4130:         WITH par_oPagina.lbl_4c_Label9
4131:             .Caption   = "Peso Brilhante :"
4132:             .Top       = 208
4133:             .Left      = 57
4134:             .Width     = 77
4135:             .Height    = 15
4136:             .BackStyle = 0
4137:             .ForeColor = RGB(90, 90, 90)
4138:             .FontName  = "Tahoma"
4139:             .FontSize  = 8
4140:             .Visible   = .T.
4141:         ENDWITH
4142: 
4143:         par_oPagina.AddObject("txt_4c_PesoBris", "TextBox")
4144:         WITH par_oPagina.txt_4c_PesoBris
4145:             .Top       = 204
4146:             .Left      = 137
4147:             .Width     = 80
4148:             .Height    = 23
4149:             .MaxLength = 10
4150:             .InputMask = "99,999.999"
4151:             .FontName  = "Tahoma"
4152:             .FontSize  = 8
4153:             .Visible   = .T.
4154:         ENDWITH
4155: 
4156:         par_oPagina.AddObject("lbl_4c_Label10", "Label")
4157:         WITH par_oPagina.lbl_4c_Label10
4158:             .Caption   = "Peso Metal :"
4159:             .Top       = 233
4160:             .Left      = 73
4161:             .Width     = 61
4162:             .Height    = 15
4163:             .BackStyle = 0
4164:             .ForeColor = RGB(90, 90, 90)
4165:             .FontName  = "Tahoma"
4166:             .FontSize  = 8

*-- Linhas 4233 a 4361:
4233:             .FontSize  = 8
4234:             .Visible   = .T.
4235:         ENDWITH
4236:         BINDEVENT(par_oPagina.txt_4c_Cor, "KeyPress", THIS, "ValidarCorPadraoDados")
4237: 
4238:         *-- Peso Variavel (fwoption1 legado - checkbox, ControlSource Varias)
4239:         par_oPagina.AddObject("chk_4c_Fwoption1", "CheckBox")
4240:         WITH par_oPagina.chk_4c_Fwoption1
4241:             .Caption   = "Peso Vari" + CHR(225) + "vel"
4242:             .Top       = 308
4243:             .Left      = 180
4244:             .Width     = 90
4245:             .Height    = 15
4246:             .Value     = 0
4247:             .Alignment = 0
4248:             .BackStyle = 0
4249:             .ForeColor = RGB(90, 90, 90)
4250:             .FontName  = "Tahoma"
4251:             .FontSize  = 8
4252:             .Visible   = .T.
4253:         ENDWITH
4254: 
4255:         par_oPagina.AddObject("lbl_4c_Label2", "Label")
4256:         WITH par_oPagina.lbl_4c_Label2
4257:             .Caption   = "Tamanho Padr" + CHR(227) + "o :"
4258:             .Top       = 308
4259:             .Left      = 44
4260:             .Width     = 90
4261:             .Height    = 15
4262:             .BackStyle = 0
4263:             .ForeColor = RGB(90, 90, 90)
4264:             .FontName  = "Tahoma"
4265:             .FontSize  = 8
4266:             .Visible   = .T.
4267:         ENDWITH
4268: 
4269:         par_oPagina.AddObject("txt_4c_Tam", "TextBox")
4270:         WITH par_oPagina.txt_4c_Tam
4271:             .Top       = 304
4272:             .Left      = 137
4273:             .Width     = 38
4274:             .Height    = 23
4275:             .MaxLength = 4
4276:             .FontName  = "Tahoma"
4277:             .FontSize  = 8
4278:             .Visible   = .T.
4279:         ENDWITH
4280:         BINDEVENT(par_oPagina.txt_4c_Tam, "KeyPress", THIS, "ValidarTamanhoPadraoDados")
4281: 
4282:         *-- Acabamento (get_codacb/get_Dacb - lookup SigCdAca)
4283:         par_oPagina.AddObject("lbl_4c_LblAcabamento", "Label")
4284:         WITH par_oPagina.lbl_4c_LblAcabamento
4285:             .Caption   = "Acabamento :"
4286:             .Top       = 333
4287:             .Left      = 15
4288:             .Width     = 119
4289:             .Height    = 15
4290:             .Alignment = 1
4291:             .BackStyle = 0
4292:             .ForeColor = RGB(90, 90, 90)
4293:             .FontName  = "Tahoma"
4294:             .FontSize  = 8
4295:             .Visible   = .T.
4296:         ENDWITH
4297: 
4298:         par_oPagina.AddObject("txt_4c_CodAcb", "TextBox")
4299:         WITH par_oPagina.txt_4c_CodAcb
4300:             .Top       = 329
4301:             .Left      = 137
4302:             .Width     = 38
4303:             .Height    = 23
4304:             .MaxLength = 3
4305:             .FontName  = "Tahoma"
4306:             .FontSize  = 8
4307:             .Visible   = .T.
4308:         ENDWITH
4309:         BINDEVENT(par_oPagina.txt_4c_CodAcb, "KeyPress", THIS, "ValidarAcabamentoDadosPorCodigo")
4310: 
4311:         par_oPagina.AddObject("txt_4c_DescAcb", "TextBox")
4312:         WITH par_oPagina.txt_4c_DescAcb
4313:             .Top       = 329
4314:             .Left      = 177
4315:             .Width     = 207
4316:             .Height    = 23
4317:             .FontName  = "Tahoma"
4318:             .FontSize  = 8
4319:             .Visible   = .T.
4320:         ENDWITH
4321:         BINDEVENT(par_oPagina.txt_4c_DescAcb, "KeyPress", THIS, "ValidarAcabamentoDadosPorDescricao")
4322: 
4323:         *-- Cravacao em Cera (opc_CravCera legado - checkbox, ControlSource CravCers)
4324:         par_oPagina.AddObject("chk_4c_OpcCravCera", "CheckBox")
4325:         WITH par_oPagina.chk_4c_OpcCravCera
4326:             .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera"
4327:             .Top       = 283
4328:             .Left      = 180
4329:             .Width     = 100
4330:             .Height    = 15
4331:             .Value     = 0
4332:             .Alignment = 0
4333:             .BackStyle = 0
4334:             .ForeColor = RGB(90, 90, 90)
4335:             .FontName  = "Tahoma"
4336:             .FontSize  = 8
4337:             .Visible   = .T.
4338:         ENDWITH
4339: 
4340:         *-- Garantia + Dias (Say46/Say47/getDiasGar)
4341:         par_oPagina.AddObject("lbl_4c_Label46", "Label")
4342:         WITH par_oPagina.lbl_4c_Label46
4343:             .Caption   = "Garantia :"
4344:             .Top       = 384
4345:             .Left      = 84
4346:             .Width     = 50
4347:             .Height    = 15
4348:             .BackStyle = 0
4349:             .ForeColor = RGB(90, 90, 90)
4350:             .FontName  = "Tahoma"
4351:             .FontSize  = 8
4352:             .Visible   = .T.
4353:         ENDWITH
4354: 
4355:         par_oPagina.AddObject("txt_4c_DiasGar", "TextBox")
4356:         WITH par_oPagina.txt_4c_DiasGar
4357:             .Top       = 380
4358:             .Left      = 137
4359:             .Width     = 31
4360:             .Height    = 23
4361:             .MaxLength = 3

*-- Linhas 4530 a 4588:
4530:             .Visible   = .T.
4531:         ENDWITH
4532: 
4533:         *-- Variacao (Say36/Fwoption2 - OptionGroup Sim/Nao, ControlSource prodvars)
4534:         par_oPagina.AddObject("lbl_4c_Label36", "Label")
4535:         WITH par_oPagina.lbl_4c_Label36
4536:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o :"
4537:             .Top       = 481
4538:             .Left      = 84
4539:             .Width     = 50
4540:             .Height    = 15
4541:             .BackStyle = 0
4542:             .ForeColor = RGB(90, 90, 90)
4543:             .FontName  = "Tahoma"
4544:             .FontSize  = 8
4545:             .Visible   = .T.
4546:         ENDWITH
4547: 
4548:         par_oPagina.AddObject("obj_4c_Fwoption2", "OptionGroup")
4549:         WITH par_oPagina.obj_4c_Fwoption2
4550:             .ButtonCount = 2
4551:             .Top         = 482
4552:             .Left        = 132
4553:             .Width       = 93
4554:             .Height      = 15
4555:             .BackStyle   = 0
4556:             .Value       = 1
4557:             .ToolTipText = "Setar se exporta varia" + CHR(231) + CHR(227) + "o para e-commerce"
4558:             .Visible     = .T.
4559:         ENDWITH
4560:         WITH par_oPagina.obj_4c_Fwoption2.Buttons(1)
4561:             .Caption   = "Sim"
4562:             .BackStyle = 0
4563:             .Top       = 0
4564:             .Left      = 5
4565:             .Height    = 15
4566:             .ForeColor = RGB(90, 90, 90)
4567:             .FontName  = "Tahoma"
4568:             .FontSize  = 8
4569:         ENDWITH
4570:         WITH par_oPagina.obj_4c_Fwoption2.Buttons(2)
4571:             .Caption   = "N" + CHR(227) + "o"
4572:             .BackStyle = 0
4573:             .Top       = 0
4574:             .Left      = 47
4575:             .Height    = 15
4576:             .ForeColor = RGB(90, 90, 90)
4577:             .FontName  = "Tahoma"
4578:             .FontSize  = 8
4579:         ENDWITH
4580: 
4581:         *-- Descricao do grupo/fase selecionada (Get_Desc - espelha
4582:         *-- crSigCdGcr.descrs; sem ControlSource nesta fase - regra #41)
4583:         par_oPagina.AddObject("lbl_4c_Label1", "Label")
4584:         WITH par_oPagina.lbl_4c_Label1
4585:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4586:             .Top       = 508
4587:             .Left      = 527
4588:             .Width     = 67

*-- Linhas 4662 a 4683:
4662:             .Themes          = .T.
4663:             .Enabled         = .T.
4664:             .Visible         = .T.
4665:         ENDWITH
4666: 
4667:         par_oPagina.AddObject("cmd_4c_Excluir", "CommandButton")
4668:         WITH par_oPagina.cmd_4c_Excluir
4669:             .Top             = 169
4670:             .Left = 230
4671:             .Width           = 39
4672:             .Height          = 40
4673:             .Caption         = ""
4674:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4675:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4676:             .ToolTipText     = "Excluir"
4677:             .Themes          = .T.
4678:             .Enabled         = .T.
4679:             .Visible         = .T.
4680:         ENDWITH
4681: 
4682:         par_oPagina.AddObject("cmd_4c_Alternativa", "CommandButton")
4683:         WITH par_oPagina.cmd_4c_Alternativa

*-- Linhas 4801 a 4863:
4801:             .Visible = .T.
4802:         ENDWITH
4803: 
4804:         THIS.TornarControlesVisiveis(par_oPagina)
4805:     ENDPROC
4806: 
4807:     *===========================================================================
4808:     * ConfigurarPgPgDadosConsP - Aba "Consumo" (PgDadosConsP legado - Page5)
4809:     *
4810:     * GrdCons (9 colunas) espelha o MESMO cursor crSigPrCpo do grdCompo/
4811:     * grdSubCp (pgComposicao/pgCusto), mostrando as colunas de consumo do
4812:     * componente (Fase/Grupo, Descricao do grupo, Ordem, Qtde. de Consumo,
4813:     * Categoria). O legado reordena a exibicao via .ColumnOrder - a ordem
4814:     * declarada (Column1..9) NAO e a ordem visual; replicada abaixo:
4815:     * Componente(1), Descricao(9), Qtde.(2), Uni(3), Fase(4), Descricao(5),
4816:     * Ord.(6), Consumo(7), Cat.(8) - conferido contra sigcdpro_06.png.
4817:     *
4818:     * grDTEMP (2 colunas, Agrupamento/Tempo %) recebe nome interno distinto
4819:     * (grd_4c_Tempos) para nao colidir com "grd_4c_Dados" - o mapeamento.json
4820:     * mapeia as DUAS grades desta pagina para "grd_4c_Dados" (colisao de
4821:     * geracao automatica; nomes internos resolvidos aqui, nao no JSON).
4822:     *===========================================================================
4823:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP()
4824:         LOCAL par_oPagina
4825:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
4826: 
4827:         *-- Qtde. Componentes (Getqtcpnt legado - espelha crSigCdPro.qtdcpnts)
4828:         par_oPagina.AddObject("lbl_4c_Label7", "Label")
4829:         WITH par_oPagina.lbl_4c_Label7
4830:             .Caption   = "Qtde Componentes : "
4831:             .Top       = 505
4832:             .Left      = 23
4833:             .Width     = 105
4834:             .Height    = 15
4835:             .BackStyle = 0
4836:             .ForeColor = RGB(90, 90, 90)
4837:             .FontName  = "Tahoma"
4838:             .FontSize  = 8
4839:             .Visible   = .T.
4840:         ENDWITH
4841: 
4842:         par_oPagina.AddObject("txt_4c_Qtcpnt", "TextBox")
4843:         WITH par_oPagina.txt_4c_Qtcpnt
4844:             .Top       = 500
4845:             .Left      = 132
4846:             .Width     = 31
4847:             .Height    = 23
4848:             .MaxLength = 3
4849:             .InputMask = "999"
4850:             .FontName  = "Tahoma"
4851:             .FontSize  = 8
4852:             .ForeColor = RGB(90, 90, 90)
4853:             .Visible   = .T.
4854:         ENDWITH
4855: 
4856:         *-- Nao Checar Cadastro de Fundicao (chkFund legado - espelha
4857:         *-- crSigCdPro.chkFunds)
4858:         par_oPagina.AddObject("chk_4c_ChkFund", "CheckBox")
4859:         WITH par_oPagina.chk_4c_ChkFund
4860:             .Caption   = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
4861:             .Top       = 525
4862:             .Left      = 11
4863:             .Width     = 182

*-- Linhas 4985 a 5059:
4985:             .Column2.Header1.Caption = "Tempo %"
4986:         ENDWITH
4987: 
4988:         THIS.TornarControlesVisiveis(par_oPagina)
4989:     ENDPROC
4990: 
4991:     *===========================================================================
4992:     * ConfigurarPgpgDadosFiscais - Campos da aba "Dados Fiscais" (pgDadosFiscais
4993:     * legado - classificacao fiscal, ICMS/IPI, conta contabil e grade de CMV -
4994:     * FASE 13). Alvo real eh pgf_4c_Divisoes.Page3 (Page3.Caption = "Dados
4995:     * Fiscais" em ConfigurarPaginaDados / PageOrder 3 em AlternarDivisao); o
4996:     * "Page6" citado no prompt generico desta fase pertence a pgCusto
4997:     * (ConfigurarPgpgCusto), que ja ocupa esse slot.
4998:     *===========================================================================
4999:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais()
5000:         LOCAL par_oPagina
5001:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3
5002: 
5003:         *-- Configuracao (Fwoption1 legado - sem Valid/Click no dump, so
5004:         *-- estrutura visual: ButtonCount=2, sem captions capturadas)
5005:         par_oPagina.AddObject("lbl_4c_Label29", "Label")
5006:         WITH par_oPagina.lbl_4c_Label29
5007:             .Caption   = "Configura" + CHR(231) + CHR(227) + "o :"
5008:             .Top       = 128
5009:             .Left      = 129
5010:             .Width     = 73
5011:             .Height    = 15
5012:             .BackStyle = 0
5013:             .ForeColor = RGB(90, 90, 90)
5014:             .FontName  = "Tahoma"
5015:             .FontSize  = 8
5016:             .Visible   = .T.
5017:         ENDWITH
5018: 
5019:         par_oPagina.AddObject("obj_4c_Fwoption1", "OptionGroup")
5020:         WITH par_oPagina.obj_4c_Fwoption1
5021:             .ButtonCount = 2
5022:             .Top         = 123
5023:             .Left        = 204
5024:             .Width       = 151
5025:             .Height      = 24
5026:             .Visible     = .T.
5027:         ENDWITH
5028: 
5029:         *-- Codigo Importado / Codigo Nacional / Codigo DCR (get_CodImpPro,
5030:         *-- get_codnacpro, get_coddcr legado - sem Valid/Click no dump e sem
5031:         *-- coluna correspondente em SigCdPro/docs/schema.sql; mantidos como
5032:         *-- campo simples, sem persistencia (regra #17 - nao inventar coluna)
5033:         par_oPagina.AddObject("lbl_4c_Label14", "Label")
5034:         WITH par_oPagina.lbl_4c_Label14
5035:             .Caption   = "C" + CHR(243) + "digo Importado :"
5036:             .Top       = 154
5037:             .Left      = 107
5038:             .Width     = 95
5039:             .Height    = 15
5040:             .BackStyle = 0
5041:             .ForeColor = RGB(90, 90, 90)
5042:             .FontName  = "Tahoma"
5043:             .FontSize  = 8
5044:             .Visible   = .T.
5045:         ENDWITH
5046: 
5047:         par_oPagina.AddObject("txt_4c__CodImpPro", "TextBox")
5048:         WITH par_oPagina.txt_4c__CodImpPro
5049:             .Top       = 150
5050:             .Left      = 206
5051:             .Width     = 80
5052:             .Height    = 23
5053:             .MaxLength = 20
5054:             .FontName  = "Tahoma"
5055:             .FontSize  = 8
5056:             .Visible   = .T.
5057:         ENDWITH
5058: 
5059:         par_oPagina.AddObject("txt_4c__DCodImpPro", "TextBox")

*-- Linhas 5240 a 5409:
5240:             .FontSize  = 8
5241:             .Visible   = .T.
5242:         ENDWITH
5243:         BINDEVENT(par_oPagina.txt_4c_Clfiscal, "KeyPress", THIS, "ValidarClassificacaoFiscalPorCodigo")
5244: 
5245:         par_oPagina.AddObject("txt_4c_Dclfiscal", "TextBox")
5246:         WITH par_oPagina.txt_4c_Dclfiscal
5247:             .Top       = 275
5248:             .Left      = 303
5249:             .Width     = 303
5250:             .Height    = 23
5251:             .MaxLength = 40
5252:             .FontName  = "Tahoma"
5253:             .FontSize  = 8
5254:             .Visible   = .T.
5255:         ENDWITH
5256:         BINDEVENT(par_oPagina.txt_4c_Dclfiscal, "KeyPress", THIS, "ValidarClassificacaoFiscalPorDescricao")
5257: 
5258:         *-- Origem da Mercadoria (getOrigmerc/getDorigmerc legado - SigCdOrg)
5259:         par_oPagina.AddObject("lbl_4c_Label2", "Label")
5260:         WITH par_oPagina.lbl_4c_Label2
5261:             .Caption   = "Origem da Mercadoria :"
5262:             .Top       = 305
5263:             .Left      = 88
5264:             .Width     = 114
5265:             .Height    = 15
5266:             .BackStyle = 0
5267:             .ForeColor = RGB(90, 90, 90)
5268:             .FontName  = "Tahoma"
5269:             .FontSize  = 8
5270:             .Visible   = .T.
5271:         ENDWITH
5272: 
5273:         par_oPagina.AddObject("txt_4c_Origmerc", "TextBox")
5274:         WITH par_oPagina.txt_4c_Origmerc
5275:             .Top       = 300
5276:             .Left      = 206
5277:             .Width     = 17
5278:             .Height    = 23
5279:             .MaxLength = 1
5280:             .FontName  = "Tahoma"
5281:             .FontSize  = 8
5282:             .Visible   = .T.
5283:         ENDWITH
5284:         BINDEVENT(par_oPagina.txt_4c_Origmerc, "KeyPress", THIS, "ValidarOrigemMercadoriaPorCodigo")
5285: 
5286:         par_oPagina.AddObject("txt_4c_Dorigmerc", "TextBox")
5287:         WITH par_oPagina.txt_4c_Dorigmerc
5288:             .Top       = 300
5289:             .Left      = 226
5290:             .Width     = 380
5291:             .Height    = 23
5292:             .MaxLength = 40
5293:             .FontName  = "Tahoma"
5294:             .FontSize  = 8
5295:             .Visible   = .T.
5296:         ENDWITH
5297:         BINDEVENT(par_oPagina.txt_4c_Dorigmerc, "KeyPress", THIS, "ValidarOrigemMercadoriaPorDescricao")
5298: 
5299:         *-- Situacao Tributaria ICMS (getSittricm/getDsittricm/Get_CodServs
5300:         *-- legado - SigCdIcm; Get_CodServs eh o codigo de servico que
5301:         *-- resolve a mesma situacao tributaria e grava o resultado em
5302:         *-- getSittricm/getDsittricm, exatamente como no Valid original)
5303:         par_oPagina.AddObject("lbl_4c_Label3", "Label")
5304:         WITH par_oPagina.lbl_4c_Label3
5305:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
5306:             .Top       = 330
5307:             .Left      = 75
5308:             .Width     = 127
5309:             .Height    = 15
5310:             .BackStyle = 0
5311:             .ForeColor = RGB(90, 90, 90)
5312:             .FontName  = "Tahoma"
5313:             .FontSize  = 8
5314:             .Visible   = .T.
5315:         ENDWITH
5316: 
5317:         par_oPagina.AddObject("txt_4c_Sittricm", "TextBox")
5318:         WITH par_oPagina.txt_4c_Sittricm
5319:             .Top       = 325
5320:             .Left      = 206
5321:             .Width     = 31
5322:             .Height    = 23
5323:             .MaxLength = 3
5324:             .FontName  = "Tahoma"
5325:             .FontSize  = 8
5326:             .Visible   = .T.
5327:         ENDWITH
5328:         BINDEVENT(par_oPagina.txt_4c_Sittricm, "KeyPress", THIS, "ValidarSituacaoTributariaPorCodigo")
5329: 
5330:         par_oPagina.AddObject("txt_4c_Dsittricm", "TextBox")
5331:         WITH par_oPagina.txt_4c_Dsittricm
5332:             .Top       = 325
5333:             .Left      = 240
5334:             .Width     = 366
5335:             .Height    = 23
5336:             .MaxLength = 40
5337:             .FontName  = "Tahoma"
5338:             .FontSize  = 8
5339:             .Visible   = .T.
5340:         ENDWITH
5341:         BINDEVENT(par_oPagina.txt_4c_Dsittricm, "KeyPress", THIS, "ValidarSituacaoTributariaPorDescricao")
5342: 
5343:         *-- Codigo de Servicos para ICMS (Get_CodServs legado)
5344:         par_oPagina.AddObject("lbl_4c_Label6", "Label")
5345:         WITH par_oPagina.lbl_4c_Label6
5346:             .Caption   = "C" + CHR(243) + "digo de Servi" + CHR(231) + "os para ICMS :"
5347:             .Top       = 355
5348:             .Left      = 49
5349:             .Width     = 153
5350:             .Height    = 15
5351:             .BackStyle = 0
5352:             .ForeColor = RGB(90, 90, 90)
5353:             .FontName  = "Tahoma"
5354:             .FontSize  = 8
5355:             .Visible   = .T.
5356:         ENDWITH
5357: 
5358:         par_oPagina.AddObject("txt_4c_Codigo", "TextBox")
5359:         WITH par_oPagina.txt_4c_Codigo
5360:             .Top       = 350
5361:             .Left      = 206
5362:             .Width     = 38
5363:             .Height    = 23
5364:             .MaxLength = 4
5365:             .FontName  = "Tahoma"
5366:             .FontSize  = 8
5367:             .Visible   = .T.
5368:         ENDWITH
5369:         BINDEVENT(par_oPagina.txt_4c_Codigo, "KeyPress", THIS, "ValidarCodigoServicoIcmsDadosFiscais")
5370: 
5371:         *-- Aliquota ICMS (getIcms legado - icms numeric(5,2))
5372:         par_oPagina.AddObject("lbl_4c_Label8", "Label")
5373:         WITH par_oPagina.lbl_4c_Label8
5374:             .Caption   = "Al" + CHR(237) + "quota ICMS :"
5375:             .Top       = 355
5376:             .Left      = 263
5377:             .Width     = 76
5378:             .Height    = 15
5379:             .BackStyle = 0
5380:             .ForeColor = RGB(90, 90, 90)
5381:             .FontName  = "Tahoma"
5382:             .FontSize  = 8
5383:             .Visible   = .T.
5384:         ENDWITH
5385: 
5386:         par_oPagina.AddObject("txt_4c_Icms", "TextBox")
5387:         WITH par_oPagina.txt_4c_Icms
5388:             .Top       = 350
5389:             .Left      = 342
5390:             .Width     = 45
5391:             .Height    = 23
5392:             .InputMask = "999.99"
5393:             .FontName  = "Tahoma"
5394:             .FontSize  = 8
5395:             .Visible   = .T.
5396:         ENDWITH
5397: 
5398:         *-- Tipo de Tributacao (Get_TpTrib legado - SigPrTri)
5399:         par_oPagina.AddObject("lbl_4c_Label4", "Label")
5400:         WITH par_oPagina.lbl_4c_Label4
5401:             .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
5402:             .Top       = 355
5403:             .Left      = 411
5404:             .Width     = 98
5405:             .Height    = 15
5406:             .BackStyle = 0
5407:             .ForeColor = RGB(90, 90, 90)
5408:             .FontName  = "Tahoma"
5409:             .FontSize  = 8

*-- Linhas 5421 a 5494:
5421:             .FontSize  = 8
5422:             .Visible   = .T.
5423:         ENDWITH
5424:         BINDEVENT(par_oPagina.txt_4c_TpTrib, "KeyPress", THIS, "ValidarTipoTributacaoDadosFiscais")
5425: 
5426:         *-- IAT - Indicador de Arredondamento/Truncamento (getiat legado -
5427:         *-- aceita so A, T ou espaco)
5428:         par_oPagina.AddObject("lbl_4c_Label41", "Label")
5429:         WITH par_oPagina.lbl_4c_Label41
5430:             .Caption   = "IAT :"
5431:             .Top       = 354
5432:             .Left      = 558
5433:             .Width     = 26
5434:             .Height    = 15
5435:             .BackStyle = 0
5436:             .ForeColor = RGB(90, 90, 90)
5437:             .FontName  = "Tahoma"
5438:             .FontSize  = 8
5439:             .Visible   = .T.
5440:         ENDWITH
5441: 
5442:         par_oPagina.AddObject("txt_4c_Iat", "TextBox")
5443:         WITH par_oPagina.txt_4c_Iat
5444:             .Top       = 350
5445:             .Left      = 589
5446:             .Width     = 17
5447:             .Height    = 23
5448:             .MaxLength = 1
5449:             .Format    = "!"
5450:             .FontName  = "Tahoma"
5451:             .FontSize  = 8
5452:             .Visible   = .T.
5453:         ENDWITH
5454:         BINDEVENT(par_oPagina.txt_4c_Iat, "KeyPress", THIS, "ValidarIatDadosFiscais")
5455: 
5456:         par_oPagina.AddObject("lbl_4c_Label42", "Label")
5457:         WITH par_oPagina.lbl_4c_Label42
5458:             .Caption   = "[A]rredondamento [T]runcamento"
5459:             .Top       = 354
5460:             .Left      = 609
5461:             .Width     = 165
5462:             .Height    = 15
5463:             .BackStyle = 0
5464:             .ForeColor = RGB(90, 90, 90)
5465:             .FontName  = "Tahoma"
5466:             .FontSize  = 8
5467:             .Visible   = .T.
5468:         ENDWITH
5469: 
5470:         *-- Situacao Tributaria IPI - Combo (cmbIpi legado - ipis char(1))
5471:         par_oPagina.AddObject("lbl_4c_Label5", "Label")
5472:         WITH par_oPagina.lbl_4c_Label5
5473:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria IPI :"
5474:             .Top       = 380
5475:             .Left      = 86
5476:             .Width     = 116
5477:             .Height    = 15
5478:             .BackStyle = 0
5479:             .ForeColor = RGB(90, 90, 90)
5480:             .FontName  = "Tahoma"
5481:             .FontSize  = 8
5482:             .Visible   = .T.
5483:         ENDWITH
5484: 
5485:         par_oPagina.AddObject("cbo_4c_CmbIpi", "ComboBox")
5486:         WITH par_oPagina.cbo_4c_CmbIpi
5487:             .Top       = 375
5488:             .Left      = 206
5489:             .Width     = 108
5490:             .Height    = 25
5491:             .FontName  = "Tahoma"
5492:             .FontSize  = 8
5493:             .Visible   = .T.
5494:         ENDWITH

*-- Linhas 5521 a 5564:
5521:             .FontSize  = 8
5522:             .Visible   = .T.
5523:         ENDWITH
5524:         BINDEVENT(par_oPagina.txt_4c_AliqIPI, "KeyPress", THIS, "ValidarAliquotaIpiDadosFiscais")
5525: 
5526:         *-- Excecao da TIPI (getextipi legado - extipi char(3). O legado
5527:         *-- habilita o campo so quando SigCdClf.IpiProds = 'S' (When
5528:         *-- dinamico); nao reproduzido aqui por depender de refresh a cada
5529:         *-- foco - o campo fica sempre habilitado, regra #17)
5530:         par_oPagina.AddObject("lbl_4c_Label13", "Label")
5531:         WITH par_oPagina.lbl_4c_Label13
5532:             .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
5533:             .Top       = 380
5534:             .Left      = 511
5535:             .Width     = 87
5536:             .Height    = 15
5537:             .BackStyle = 0
5538:             .ForeColor = RGB(90, 90, 90)
5539:             .FontName  = "Tahoma"
5540:             .FontSize  = 8
5541:             .Visible   = .T.
5542:         ENDWITH
5543: 
5544:         par_oPagina.AddObject("txt_4c_Extipi", "TextBox")
5545:         WITH par_oPagina.txt_4c_Extipi
5546:             .Top       = 375
5547:             .Left      = 601
5548:             .Width     = 35
5549:             .Height    = 25
5550:             .MaxLength = 3
5551:             .FontName  = "Tahoma"
5552:             .FontSize  = 8
5553:             .Visible   = .T.
5554:         ENDWITH
5555: 
5556:         *-- Valor do Grama Produzido - grade de CMV por periodo (grdCmv
5557:         *-- legado, 3 colunas)
5558:         par_oPagina.AddObject("lbl_4c_Label9", "Label")
5559:         WITH par_oPagina.lbl_4c_Label9
5560:             .Caption   = "Valor do Grama Produzido"
5561:             .Top       = 384
5562:             .Left      = 756
5563:             .Width     = 125
5564:             .Height    = 15

*-- Linhas 5797 a 5906:
5797:             .FontSize  = 8
5798:             .Visible   = .T.
5799:         ENDWITH
5800:         BINDEVENT(par_oPagina.txt_4c_Mvalor, "KeyPress", THIS, "ValidarMoedaValorEstimadoDadosFiscais")
5801: 
5802:         *-- IPPT/CST (getIPPTCST legado - When retorna .F. sempre, ou seja o
5803:         *-- campo nunca recebe foco no legado; sem coluna correspondente em
5804:         *-- SigCdPro. Mantido desabilitado, fiel ao comportamento original)
5805:         par_oPagina.AddObject("lbl_4c_Label10", "Label")
5806:         WITH par_oPagina.lbl_4c_Label10
5807:             .Caption   = "IPPT/CST :"
5808:             .Top       = 547
5809:             .Left      = 148
5810:             .Width     = 54
5811:             .Height    = 15
5812:             .BackStyle = 0
5813:             .ForeColor = RGB(90, 90, 90)
5814:             .FontName  = "Tahoma"
5815:             .FontSize  = 8
5816:             .Visible   = .T.
5817:         ENDWITH
5818: 
5819:         par_oPagina.AddObject("txt_4c_IPPTCST", "TextBox")
5820:         WITH par_oPagina.txt_4c_IPPTCST
5821:             .Top       = 543
5822:             .Left      = 206
5823:             .Width     = 108
5824:             .Height    = 23
5825:             .Enabled   = .F.
5826:             .FontName  = "Tahoma"
5827:             .FontSize  = 8
5828:             .Visible   = .T.
5829:         ENDWITH
5830: 
5831:         THIS.TornarControlesVisiveis(par_oPagina)
5832:     ENDPROC
5833: 
5834:     *===========================================================================
5835:     * ConfigurarPgpgDesigner - Aba "Designer" (pgDesigner legado - Page7,
5836:     * caption "Page1" no proprio SCX). 21 objetos: grade de tarefas do
5837:     * designer (crSigPrTar) + observacao da tarefa, grade de arquivos
5838:     * anexados (crSigPrArq) + preview de imagem, campo de inspiracao
5839:     * (crSigCdPro.ObsInsp), bloco "Dados do Lancamento" (Desenvolvido por /
5840:     * Criado por - lookup SigCdUsu / Data Apr. Amostra).
5841:     *
5842:     * grd_4c_Dados (grdDesigner) e grd_4c_Arquivos (grdArquivos) ficam SEM
5843:     * RecordSource/ControlSource nesta fase (regra #41 do CLAUDE.md:
5844:     * crSigPrTar/crSigPrArq ainda nao existem - nenhum BO deste projeto os
5845:     * popula). Pelo mesmo motivo os botoes que operam sobre essas grades
5846:     * (Iniciar/Encerrar Tarefa, Inserir/Abrir/Excluir Arquivo) e o
5847:     * AfterRowColChange/DblClick que atualizam a preview de imagem ficam SEM
5848:     * Click/evento - mesmo padrao de deferimento de ConfigurarPgPgDadosFaseP/
5849:     * ConfigurarPgPgDadosConsP (GradFase/grdMatrizes/inserir/excluir/...).
5850:     * Nomes internos das grades distintos de proposito (nao ambos
5851:     * "grd_4c_Dados") para nao colidir - o mapeamento.json mapeia as DUAS
5852:     * grades desta pagina para "grd_4c_Dados" (mesma colisao ja documentada
5853:     * em ConfigurarPgPgDadosConsP/grd_4c_Tempos).
5854:     *
5855:     * getObsTarefas (ControlSource legado crSigPrTar.ObsTars) e getObsInsp
5856:     * (ControlSource legado crSigCdPro.ObsInsp) ficam so estruturais - esta
5857:     * arquitetura nao usa TextBox.ControlSource (FormParaBO/BOParaForm fazem
5858:     * o bind manual) e getObsTarefas depende do cursor de tarefas acima.
5859:     *
5860:     * GetDesLacto/GetCriaLacto SAO lookups reais contra SigCdUsu, filtrados
5861:     * por "Not cAtivos='N' and deptos in (select codigos from sigcddpt where
5862:     * UtiLacto = 1)" (transcrito do Valid legado), e recebem BINDEVENT +
5863:     * ExecutarLookupGenerico, igual aos demais campos de codigo isolado do
5864:     * form.
5865:     *===========================================================================
5866:     PROTECTED PROCEDURE ConfigurarPgpgDesigner()
5867:         LOCAL par_oPagina
5868:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page7
5869: 
5870:         *-- Moldura decorativa ao redor do bloco Inspiracao/Observacao (Shape1)
5871:         par_oPagina.AddObject("shp_4c_Shape1", "Shape")
5872:         WITH par_oPagina.shp_4c_Shape1
5873:             .Top           = 400
5874:             .Left          = 584
5875:             .Width         = 407
5876:             .Height        = 202
5877:             .BackStyle     = 0
5878:             .BorderWidth   = 1
5879:             .BorderColor   = RGB(231, 254, 253)
5880:             .SpecialEffect = 1
5881:             .Visible       = .T.
5882:         ENDWITH
5883: 
5884:         *-- Grade de tarefas do designer (grdDesigner legado, 4 colunas) -
5885:         *-- espelha crSigPrTar; SEM RecordSource/ControlSource nesta fase
5886:         *-- (regra #41)
5887:         par_oPagina.AddObject("grd_4c_Dados", "Grid")
5888:         par_oPagina.grd_4c_Dados.ColumnCount = 4
5889:         WITH par_oPagina.grd_4c_Dados
5890:             .Top                = 145
5891:             .Left               = 10
5892:             .Width              = 495
5893:             .Height             = 180
5894:             .FontName           = "Tahoma"
5895:             .FontSize           = 8
5896:             .ForeColor          = RGB(90, 90, 90)
5897:             .BackColor          = RGB(255, 255, 255)
5898:             .GridLineColor      = RGB(238, 238, 238)
5899:             .HighlightBackColor = RGB(255, 255, 255)
5900:             .HighlightForeColor = RGB(15, 41, 104)
5901:             .HighlightStyle     = 2
5902:             .AllowHeaderSizing  = .F.
5903:             .DeleteMark         = .F.
5904:             .RecordMark         = .F.
5905:             .RowHeight          = 16
5906:             .ScrollBars         = 2

*-- Linhas 6204 a 7027:
6204:             .FontSize      = 8
6205:             .Visible       = .T.
6206:         ENDWITH
6207:         BINDEVENT(par_oPagina.txt_4c_DesLacto, "KeyPress", THIS, "ValidarDesenvolvidoPorLacto")
6208: 
6209:         par_oPagina.AddObject("lbl_4c_Label5", "Label")
6210:         WITH par_oPagina.lbl_4c_Label5
6211:             .Caption   = "Criado por :"
6212:             .Top       = 580
6213:             .Left      = 56
6214:             .Width     = 59
6215:             .Height    = 15
6216:             .BackStyle = 0
6217:             .ForeColor = RGB(90, 90, 90)
6218:             .FontName  = "Tahoma"
6219:             .FontSize  = 8
6220:             .Visible   = .T.
6221:         ENDWITH
6222: 
6223:         par_oPagina.AddObject("txt_4c_CriaLacto", "TextBox")
6224:         WITH par_oPagina.txt_4c_CriaLacto
6225:             .Top           = 576
6226:             .Left          = 118
6227:             .Width         = 91
6228:             .Height        = 22
6229:             .MaxLength     = 30
6230:             .Format        = "K!"
6231:             .SpecialEffect = 1
6232:             .FontName      = "Tahoma"
6233:             .FontSize      = 8
6234:             .Visible       = .T.
6235:         ENDWITH
6236:         BINDEVENT(par_oPagina.txt_4c_CriaLacto, "KeyPress", THIS, "ValidarCriadoPorLacto")
6237: 
6238:         THIS.TornarControlesVisiveis(par_oPagina)
6239:     ENDPROC
6240: 
6241:     *===========================================================================
6242:     * ConfigurarPgpgServico - Sub-pagina "Servicos" (pgServico legado - Page8):
6243:     * grade de servicos vinculados ao produto (crSigPrSer legado), com colunas
6244:     * Servicos/Codigo e checkbox de marcacao na Coluna3 - FASE 15. SEM
6245:     * RecordSource/ControlSource nesta fase (regra #41 CLAUDE.md - cursor
6246:     * ainda nao populado, mesmo estagio dos demais grids desta pagina).
6247:     *===========================================================================
6248:     PROTECTED PROCEDURE ConfigurarPgpgServico()
6249:         LOCAL par_oPagina
6250:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8
6251: 
6252:         *-- Grade de servicos (grdServico legado, 3 colunas)
6253:         par_oPagina.AddObject("grd_4c_Dados", "Grid")
6254:         par_oPagina.grd_4c_Dados.ColumnCount = 3
6255:         WITH par_oPagina.grd_4c_Dados
6256:             .Top                = 171
6257:             .Left               = 339
6258:             .Width              = 320
6259:             .Height             = 387
6260:             .FontName           = "Verdana"
6261:             .FontSize           = 8
6262:             .ForeColor          = RGB(90, 90, 90)
6263:             .BackColor          = RGB(255, 255, 255)
6264:             .GridLineColor      = RGB(238, 238, 238)
6265:             .HighlightBackColor = RGB(255, 255, 255)
6266:             .HighlightForeColor = RGB(15, 41, 104)
6267:             .HighlightStyle     = 2
6268:             .DeleteMark         = .F.
6269:             .RecordMark         = .F.
6270:             .RowHeight          = 16
6271:             .ScrollBars         = 2
6272:             .GridLines          = 3
6273:             .ReadOnly           = .F.
6274:             .Visible            = .T.
6275: 
6276:             .Column1.Width           = 180
6277:             .Column1.Header1.Caption = "Servi" + CHR(231) + "os"
6278: 
6279:             .Column2.Width           = 90
6280:             .Column2.Header1.Caption = "C" + CHR(243) + "digo"
6281: 
6282:             .Column3.Width           = 50
6283:             .Column3.Header1.Caption = ""
6284:         ENDWITH
6285: 
6286:         *-- Coluna 3 (checkbox de marcacao, sem legenda no legado): AddObject +
6287:         *-- CurrentControl obrigatorios para o checkbox aparecer (regra #18
6288:         *-- CLAUDE.md)
6289:         par_oPagina.grd_4c_Dados.Column3.AddObject("chk_4c_Marcado", "CheckBox")
6290:         WITH par_oPagina.grd_4c_Dados.Column3
6291:             .CurrentControl = "chk_4c_Marcado"
6292:             .Sparse         = .F.
6293:         ENDWITH
6294: 
6295:         THIS.TornarControlesVisiveis(par_oPagina)
6296:     ENDPROC
6297: 
6298:     *===========================================================================
6299:     * ExecutarLookupGenerico - Motor comum dos lookups FK da aba Dados
6300:     * Principais. Reproduz o padrao ValidarGrupoFiltro/ValidarGrupoPorDescricao
6301:     * ja usado na pagina de Lista, generalizado por parametro (tabela, campos,
6302:     * cursor e - opcionalmente - filtro adicional, ex.: Classificacao por
6303:     * grupo). PUBLIC porque eh chamado por metodo PUBLIC (nao precisa ser
6304:     * PUBLIC ele mesmo, mas mantido PROTECTED por ser chamado so via THIS.).
6305:     *===========================================================================
6306:     PROTECTED PROCEDURE ExecutarLookupGenerico(par_oTxtCod, par_oTxtDesc, ;
6307:             par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, ;
6308:             par_cCursor, par_cCampoBusca, par_cValorBusca, par_cFiltro)
6309:         LOCAL loc_oBusca, loException
6310: 
6311:         IF EMPTY(par_cValorBusca)
6312:             par_oTxtCod.Value = ""
6313:             IF VARTYPE(par_oTxtDesc) = "O"
6314:                 par_oTxtDesc.Value = ""
6315:             ENDIF
6316:             RETURN
6317:         ENDIF
6318: 
6319:         TRY
6320:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
6321:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6322:                     par_cTabela, par_cCursor, par_cCampoBusca, par_cValorBusca, ;
6323:                     par_cTitulo, .T., .T., par_cFiltro)
6324:             ELSE
6325:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6326:                     par_cTabela, par_cCursor, par_cCampoBusca, par_cValorBusca, ;
6327:                     par_cTitulo)
6328:             ENDIF
6329: 
6330:             IF VARTYPE(loc_oBusca) = "O"
6331:                 IF !loc_oBusca.this_lAchouRegistro
6332:                     loc_oBusca.mAddColuna(par_cCampoCod, "", "C" + CHR(243) + "digo")
6333:                     IF !EMPTY(par_cCampoDesc)
6334:                         loc_oBusca.mAddColuna(par_cCampoDesc, "", ;
6335:                             "Descri" + CHR(231) + CHR(227) + "o")
6336:                     ENDIF
6337:                     loc_oBusca.Show()
6338:                 ENDIF
6339: 
6340:                 IF loc_oBusca.this_lSelecionou AND USED(par_cCursor)
6341:                     SELECT (par_cCursor)
6342:                     par_oTxtCod.Value = ALLTRIM(EVALUATE(par_cCursor + "." + par_cCampoCod))
6343:                     IF VARTYPE(par_oTxtDesc) = "O" AND !EMPTY(par_cCampoDesc)
6344:                         par_oTxtDesc.Value = ALLTRIM(EVALUATE(par_cCursor + "." + par_cCampoDesc))
6345:                     ENDIF
6346:                 ELSE
6347:                     par_oTxtCod.Value = ""
6348:                     IF VARTYPE(par_oTxtDesc) = "O"
6349:                         par_oTxtDesc.Value = ""
6350:                     ENDIF
6351:                 ENDIF
6352: 
6353:                 loc_oBusca.Release()
6354:             ENDIF
6355: 
6356:             IF USED(par_cCursor)
6357:                 USE IN (par_cCursor)
6358:             ENDIF
6359: 
6360:         CATCH TO loException
6361:             MostrarErro("Erro ao buscar " + par_cTitulo + ":" + CHR(13) + ;
6362:                 loException.Message, "FormProduto.ExecutarLookupGenerico")
6363:         ENDTRY
6364:     ENDPROC
6365: 
6366:     *===========================================================================
6367:     * ValidarCodigoProdutoDados - LostFocus de txt_4c_Cpro (aba Dados). Em modo
6368:     * PROCURAR o campo eh o filtro da busca por exemplo (ver BtnBuscarClick);
6369:     * fora dele so normaliza o codigo digitado - o legado (getCpro.When) trata
6370:     * o proprio codigo como chave, sem lookup externo.
6371:     *===========================================================================
6372:     PROCEDURE ValidarCodigoProdutoDados(par_nKeyCode, par_nShiftAltCtrl)
6373:         LOCAL loc_oPg
6374:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6375:         loc_oPg.txt_4c_Cpro.Value = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)
6376:     ENDPROC
6377: 
6378:     PROCEDURE ValidarProdutoEquivalente(par_nKeyCode, par_nShiftAltCtrl)
6379:         LOCAL loc_oPg, loc_cValor
6380:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6381:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_CProEq.Value), 14)
6382:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CProEq, .NULL., "SigCdPro", ;
6383:             "CPros", "", "Produto Equivalente", "cursor_4c_BuscaProEqDados", ;
6384:             "CPros", loc_cValor, "")
6385:     ENDPROC
6386: 
6387:     PROCEDURE ValidarGrupoDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6388:         LOCAL loc_oPg, loc_cValor
6389:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6390:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Cgru.Value), 3)
6391:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cgru, loc_oPg.txt_4c_Dgru, ;
6392:             "SigCdGrp", "cgrus", "dgrus", "Grupo de Produto", ;
6393:             "cursor_4c_BuscaGrpDados", "cgrus", loc_cValor, "")
6394:         *-- txt_4c_Merc (Grande Grupo) eh populado a partir de SigCdGrp.Mercs
6395:         *-- pelo BO ao carregar/gravar o produto - sem evidencia no dump de que
6396:         *-- o legado copia esse valor no proprio Valid do campo Grupo, por isso
6397:         *-- NAO reproduzido aqui (regra #17 do CLAUDE.md: nao inventar formula).
6398:     ENDPROC
6399: 
6400:     PROCEDURE ValidarGrupoDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6401:         LOCAL loc_oPg, loc_cValor
6402:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6403:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dgru.Value)
6404:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Cgru.Value))
6405:             RETURN
6406:         ENDIF
6407:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cgru, loc_oPg.txt_4c_Dgru, ;
6408:             "SigCdGrp", "cgrus", "dgrus", "Grupo de Produto", ;
6409:             "cursor_4c_BuscaGrpDados", "dgrus", loc_cValor, "")
6410:     ENDPROC
6411: 
6412:     PROCEDURE ValidarSubgrupoDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6413:         LOCAL loc_oPg, loc_cValor, loc_cFiltro
6414:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6415:         loc_cValor  = PADR(ALLTRIM(loc_oPg.txt_4c_CSGru.Value), 6)
6416:         loc_cFiltro = "CGrus = " + EscaparSQL(PADR(ALLTRIM(loc_oPg.txt_4c_Cgru.Value), 3))
6417:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CSGru, loc_oPg.txt_4c_DsGru, ;
6418:             "SigCdPsg", "Codigos", "Descricaos", "Subgrupo", ;
6419:             "cursor_4c_BuscaSubGrpDados", "Codigos", loc_cValor, loc_cFiltro)
6420:     ENDPROC
6421: 
6422:     PROCEDURE ValidarSubgrupoDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6423:         LOCAL loc_oPg, loc_cValor, loc_cFiltro
6424:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6425:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsGru.Value)
6426:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_CSGru.Value))
6427:             RETURN
6428:         ENDIF
6429:         loc_cFiltro = "CGrus = " + EscaparSQL(PADR(ALLTRIM(loc_oPg.txt_4c_Cgru.Value), 3))
6430:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CSGru, loc_oPg.txt_4c_DsGru, ;
6431:             "SigCdPsg", "Codigos", "Descricaos", "Subgrupo", ;
6432:             "cursor_4c_BuscaSubGrpDados", "Descricaos", loc_cValor, loc_cFiltro)
6433:     ENDPROC
6434: 
6435:     PROCEDURE ValidarLinhaDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6436:         LOCAL loc_oPg, loc_cValor
6437:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6438:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Lin.Value), 10)
6439:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Lin, loc_oPg.txt_4c_DLin, ;
6440:             "SigCdLin", "Linhas", "Descs", "Linha", "cursor_4c_BuscaLinDados", ;
6441:             "Linhas", loc_cValor, "")
6442:     ENDPROC
6443: 
6444:     PROCEDURE ValidarLinhaDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6445:         LOCAL loc_oPg, loc_cValor
6446:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6447:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DLin.Value)
6448:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Lin.Value))
6449:             RETURN
6450:         ENDIF
6451:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Lin, loc_oPg.txt_4c_DLin, ;
6452:             "SigCdLin", "Linhas", "Descs", "Linha", "cursor_4c_BuscaLinDados", ;
6453:             "Descs", loc_cValor, "")
6454:     ENDPROC
6455: 
6456:     PROCEDURE ValidarColecaoDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6457:         LOCAL loc_oPg, loc_cValor
6458:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6459:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Col.Value), 10)
6460:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Col, loc_oPg.txt_4c_DCol, ;
6461:             "SigCdCol", "Colecoes", "Descs", "Cole" + CHR(231) + CHR(227) + "o", ;
6462:             "cursor_4c_BuscaColDados", "Colecoes", loc_cValor, "")
6463:     ENDPROC
6464: 
6465:     PROCEDURE ValidarColecaoDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6466:         LOCAL loc_oPg, loc_cValor
6467:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6468:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DCol.Value)
6469:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Col.Value))
6470:             RETURN
6471:         ENDIF
6472:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Col, loc_oPg.txt_4c_DCol, ;
6473:             "SigCdCol", "Colecoes", "Descs", "Cole" + CHR(231) + CHR(227) + "o", ;
6474:             "cursor_4c_BuscaColDados", "Descs", loc_cValor, "")
6475:     ENDPROC
6476: 
6477:     PROCEDURE ValidarClassificacaoDados(par_nKeyCode, par_nShiftAltCtrl)
6478:         LOCAL loc_oPg, loc_cValor, loc_cFiltro
6479:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6480:         loc_cValor  = PADR(ALLTRIM(loc_oPg.txt_4c_Class.Value), 3)
6481:         loc_cFiltro = "CGrus IN (" + EscaparSQL(PADR(ALLTRIM(loc_oPg.txt_4c_Cgru.Value), 3)) + ;
6482:             ", " + EscaparSQL(SPACE(3)) + ")"
6483:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Class, .NULL., "SigCdCls", ;
6484:             "Cods", "", "Classifica" + CHR(231) + CHR(227) + "o", ;
6485:             "cursor_4c_BuscaClsDados", "Cods", loc_cValor, loc_cFiltro)
6486:     ENDPROC
6487: 
6488:     PROCEDURE ValidarFornecedorDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6489:         LOCAL loc_oPg, loc_cValor
6490:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6491:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Ifor.Value), 10)
6492:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Ifor, loc_oPg.txt_4c_Dfor, ;
6493:             "SigCdCli", "Iclis", "Rclis", "Fornecedor", ;
6494:             "cursor_4c_BuscaForDados", "Iclis", loc_cValor, "")
6495:     ENDPROC
6496: 
6497:     PROCEDURE ValidarFornecedorDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6498:         LOCAL loc_oPg, loc_cValor
6499:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6500:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dfor.Value)
6501:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Ifor.Value))
6502:             RETURN
6503:         ENDIF
6504:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Ifor, loc_oPg.txt_4c_Dfor, ;
6505:             "SigCdCli", "Iclis", "Rclis", "Fornecedor", ;
6506:             "cursor_4c_BuscaForDados", "Rclis", loc_cValor, "")
6507:     ENDPROC
6508: 
6509:     PROCEDURE ValidarModeloDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6510:         LOCAL loc_oPg, loc_cValor
6511:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6512:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_CodFinP.Value), 3)
6513:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CodFinP, loc_oPg.txt_4c_DesFinP, ;
6514:             "SigCdFip", "Cods", "Descs", "Modelo", "cursor_4c_BuscaFinPDados", ;
6515:             "Cods", loc_cValor, "")
6516:     ENDPROC
6517: 
6518:     PROCEDURE ValidarModeloDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6519:         LOCAL loc_oPg, loc_cValor
6520:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6521:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DesFinP.Value)
6522:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_CodFinP.Value))
6523:             RETURN
6524:         ENDIF
6525:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CodFinP, loc_oPg.txt_4c_DesFinP, ;
6526:             "SigCdFip", "Cods", "Descs", "Modelo", "cursor_4c_BuscaFinPDados", ;
6527:             "Descs", loc_cValor, "")
6528:     ENDPROC
6529: 
6530:     PROCEDURE ValidarUnidadeDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6531:         LOCAL loc_oPg, loc_cValor
6532:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6533:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Cuni.Value), 3)
6534:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cuni, loc_oPg.txt_4c_Duni, ;
6535:             "SigCdUni", "CUnis", "DUnis", "Unidade", "cursor_4c_BuscaUniDados", ;
6536:             "CUnis", loc_cValor, "")
6537:     ENDPROC
6538: 
6539:     PROCEDURE ValidarUnidadeDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6540:         LOCAL loc_oPg, loc_cValor
6541:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6542:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Duni.Value)
6543:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Cuni.Value))
6544:             RETURN
6545:         ENDIF
6546:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cuni, loc_oPg.txt_4c_Duni, ;
6547:             "SigCdUni", "CUnis", "DUnis", "Unidade", "cursor_4c_BuscaUniDados", ;
6548:             "DUnis", loc_cValor, "")
6549:     ENDPROC
6550: 
6551:     PROCEDURE ValidarUnidadePedidoDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6552:         LOCAL loc_oPg, loc_cValor
6553:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6554:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Cunip.Value), 3)
6555:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cunip, loc_oPg.txt_4c__dunip, ;
6556:             "SigCdUni", "CUnis", "DUnis", "Unidade de Pedido", ;
6557:             "cursor_4c_BuscaUniPDados", "CUnis", loc_cValor, "")
6558:     ENDPROC
6559: 
6560:     PROCEDURE ValidarUnidadePedidoDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6561:         LOCAL loc_oPg, loc_cValor
6562:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6563:         loc_cValor = ALLTRIM(loc_oPg.txt_4c__dunip.Value)
6564:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Cunip.Value))
6565:             RETURN
6566:         ENDIF
6567:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cunip, loc_oPg.txt_4c__dunip, ;
6568:             "SigCdUni", "CUnis", "DUnis", "Unidade de Pedido", ;
6569:             "cursor_4c_BuscaUniPDados", "DUnis", loc_cValor, "")
6570:     ENDPROC
6571: 
6572:     PROCEDURE ValidarLocalDados(par_nKeyCode, par_nShiftAltCtrl)
6573:         LOCAL loc_oPg, loc_cValor
6574:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6575:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Local.Value), 10)
6576:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Local, .NULL., "SigPrLcl", ;
6577:             "Codigos", "", "Localiza" + CHR(231) + CHR(227) + "o", ;
6578:             "cursor_4c_BuscaLocalDados", "Codigos", loc_cValor, "")
6579:     ENDPROC
6580: 
6581:     PROCEDURE ValidarMoedaCustoTotalDados(par_nKeyCode, par_nShiftAltCtrl)
6582:         LOCAL loc_oPg, loc_cValor
6583:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6584:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Mctotal.Value), 3)
6585:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Mctotal, .NULL., "SigCdMoe", ;
6586:             "CMoes", "", "Moeda", "cursor_4c_BuscaMoeCtotalDados", "CMoes", ;
6587:             loc_cValor, "")
6588:     ENDPROC
6589: 
6590:     PROCEDURE ValidarMoedaValorVendaDados(par_nKeyCode, par_nShiftAltCtrl)
6591:         LOCAL loc_oPg, loc_cValor
6592:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6593:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value), 3)
6594:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Mpvenda, .NULL., "SigCdMoe", ;
6595:             "CMoes", "", "Moeda", "cursor_4c_BuscaMoePvendaDados", "CMoes", ;
6596:             loc_cValor, "")
6597:     ENDPROC
6598: 
6599:     PROCEDURE ValidarMoedaFatorVendaDados(par_nKeyCode, par_nShiftAltCtrl)
6600:         LOCAL loc_oPg, loc_cValor
6601:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6602:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value), 3)
6603:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Mfvenda, .NULL., "SigCdMoe", ;
6604:             "CMoes", "", "Moeda", "cursor_4c_BuscaMoeFvendaDados", "CMoes", ;
6605:             loc_cValor, "")
6606:     ENDPROC
6607: 
6608:     *-- Lookups da aba "Processos" (PgDadosFaseP - FASE 12)
6609:     PROCEDURE ValidarCorPadraoDados(par_nKeyCode, par_nShiftAltCtrl)
6610:         LOCAL loc_oPg, loc_cValor
6611:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
6612:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Cor.Value), 4)
6613:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cor, .NULL., "SigCdCor", ;
6614:             "Cods", "", "Cor", "cursor_4c_BuscaCorFaseDados", "Cods", ;
6615:             loc_cValor, "")
6616:     ENDPROC
6617: 
6618:     PROCEDURE ValidarTamanhoPadraoDados(par_nKeyCode, par_nShiftAltCtrl)
6619:         LOCAL loc_oPg, loc_cValor
6620:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
6621:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Tam.Value), 4)
6622:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Tam, .NULL., "SigCdTam", ;
6623:             "Cods", "", "Tamanho", "cursor_4c_BuscaTamFaseDados", "Cods", ;
6624:             loc_cValor, "")
6625:     ENDPROC
6626: 
6627:     PROCEDURE ValidarConquilhaDados(par_nKeyCode, par_nShiftAltCtrl)
6628:         LOCAL loc_oPg, loc_cValor
6629:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
6630:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Conquilha.Value), 10)
6631:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Conquilha, .NULL., "SigCdCnq", ;
6632:             "Conquilhas", "", "Conquilha", "cursor_4c_BuscaConquilhaDados", ;
6633:             "Conquilhas", loc_cValor, "")
6634:     ENDPROC
6635: 
6636:     PROCEDURE ValidarAcabamentoDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6637:         LOCAL loc_oPg, loc_cValor
6638:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
6639:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_CodAcb.Value), 3)
6640:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CodAcb, loc_oPg.txt_4c_DescAcb, ;
6641:             "SigCdAca", "Cods", "Descrs", "Acabamento", ;
6642:             "cursor_4c_BuscaAcbDados", "Cods", loc_cValor, "")
6643:     ENDPROC
6644: 
6645:     PROCEDURE ValidarAcabamentoDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6646:         LOCAL loc_oPg, loc_cValor
6647:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
6648:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DescAcb.Value)
6649:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_CodAcb.Value))
6650:             RETURN
6651:         ENDIF
6652:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CodAcb, loc_oPg.txt_4c_DescAcb, ;
6653:             "SigCdAca", "Cods", "Descrs", "Acabamento", ;
6654:             "cursor_4c_BuscaAcbDados", "Descrs", loc_cValor, "")
6655:     ENDPROC
6656: 
6657:     *===========================================================================
6658:     * ObterPaginaComposicao - Atalho para a aba "Componente" (pgComposicao
6659:     * legado), espelhando ObterPaginaDados
6660:     *===========================================================================
6661:     PROTECTED PROCEDURE ObterPaginaComposicao()
6662:         RETURN THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
6663:     ENDPROC
6664: 
6665:     *===========================================================================
6666:     * Validar*Composicao - Lookups de codigo isolado da aba "Componente"
6667:     * (pgComposicao). Mesmo motor ExecutarLookupGenerico das outras abas.
6668:     *===========================================================================
6669:     PROCEDURE ValidarMoedaCustoComposicao(par_nKeyCode, par_nShiftAltCtrl)
6670:         LOCAL loc_oPg, loc_cValor
6671:         loc_oPg    = THIS.ObterPaginaComposicao()
6672:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Moec.Value), 3)
6673:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Moec, .NULL., "SigCdMoe", ;
6674:             "CMoes", "", "Moeda", "cursor_4c_BuscaMoeCustoComp", "CMoes", ;
6675:             loc_cValor, "")
6676:     ENDPROC
6677: 
6678:     PROCEDURE ValidarMoedaCustoPComposicao(par_nKeyCode, par_nShiftAltCtrl)
6679:         LOCAL loc_oPg, loc_cValor
6680:         loc_oPg    = THIS.ObterPaginaComposicao()
6681:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Moepc.Value), 3)
6682:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Moepc, .NULL., "SigCdMoe", ;
6683:             "CMoes", "", "Moeda", "cursor_4c_BuscaMoeCustoPComp", "CMoes", ;
6684:             loc_cValor, "")
6685:     ENDPROC
6686: 
6687:     PROCEDURE ValidarMoedaCustoFComposicao(par_nKeyCode, par_nShiftAltCtrl)
6688:         LOCAL loc_oPg, loc_cValor
6689:         loc_oPg    = THIS.ObterPaginaComposicao()
6690:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Moecusf.Value), 3)
6691:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Moecusf, .NULL., "SigCdMoe", ;
6692:             "CMoes", "", "Moeda", "cursor_4c_BuscaMoeCustoFComp", "CMoes", ;
6693:             loc_cValor, "")
6694:     ENDPROC
6695: 
6696:     PROCEDURE ValidarMoedaVendaComposicao(par_nKeyCode, par_nShiftAltCtrl)
6697:         LOCAL loc_oPg, loc_cValor
6698:         loc_oPg    = THIS.ObterPaginaComposicao()
6699:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Moeda.Value), 3)
6700:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Moeda, .NULL., "SigCdMoe", ;
6701:             "CMoes", "", "Moeda", "cursor_4c_BuscaMoeVendaComp", "CMoes", ;
6702:             loc_cValor, "")
6703:     ENDPROC
6704: 
6705:     PROCEDURE ValidarMoedaVendaVComposicao(par_nKeyCode, par_nShiftAltCtrl)
6706:         LOCAL loc_oPg, loc_cValor
6707:         loc_oPg    = THIS.ObterPaginaComposicao()
6708:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Moev.Value), 3)
6709:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Moev, .NULL., "SigCdMoe", ;
6710:             "CMoes", "", "Moeda", "cursor_4c_BuscaMoeVendaVComp", "CMoes", ;
6711:             loc_cValor, "")
6712:     ENDPROC
6713: 
6714:     PROCEDURE ValidarMoedaVendaPVComposicao(par_nKeyCode, par_nShiftAltCtrl)
6715:         LOCAL loc_oPg, loc_cValor
6716:         loc_oPg    = THIS.ObterPaginaComposicao()
6717:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Moepv.Value), 3)
6718:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Moepv, .NULL., "SigCdMoe", ;
6719:             "CMoes", "", "Moeda", "cursor_4c_BuscaMoeVendaPVComp", "CMoes", ;
6720:             loc_cValor, "")
6721:     ENDPROC
6722: 
6723:     *-- Feitio de Venda (Getftio legado - SigPrFti.Tipos <> 1)
6724:     PROCEDURE ValidarFeitioVendaComposicao(par_nKeyCode, par_nShiftAltCtrl)
6725:         LOCAL loc_oPg, loc_cValor
6726:         loc_oPg    = THIS.ObterPaginaComposicao()
6727:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Ftio.Value), 2)
6728:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Ftio, .NULL., "SigPrFti", ;
6729:             "Cods", "Descs", "Feitio", "cursor_4c_BuscaFeitioVendaComp", ;
6730:             "Cods", loc_cValor, "Tipos <> 1")
6731:     ENDPROC
6732: 
6733:     *-- Feitio de Custo (Get_cmkpc legado - SigPrFti.Tipos = 1)
6734:     PROCEDURE ValidarFeitioCustoComposicao(par_nKeyCode, par_nShiftAltCtrl)
6735:         LOCAL loc_oPg, loc_cValor
6736:         loc_oPg    = THIS.ObterPaginaComposicao()
6737:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Cmkpc.Value), 2)
6738:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cmkpc, .NULL., "SigPrFti", ;
6739:             "Cods", "Descs", "Feitio", "cursor_4c_BuscaFeitioCustoComp", ;
6740:             "Cods", loc_cValor, "Tipos = 1")
6741:     ENDPROC
6742: 
6743:     *-- Status do componente (getStatus legado - SigCdPst)
6744:     PROCEDURE ValidarStatusComposicao(par_nKeyCode, par_nShiftAltCtrl)
6745:         LOCAL loc_oPg, loc_cValor
6746:         loc_oPg    = THIS.ObterPaginaComposicao()
6747:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Status.Value), 3)
6748:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Status, .NULL., "SigCdPst", ;
6749:             "Cods", "Descs", "Status", "cursor_4c_BuscaStatusComp", "Cods", ;
6750:             loc_cValor, "")
6751:     ENDPROC
6752: 
6753:     *-- Material Principal (Get_MatP legado - SigCdPro). O legado ainda
6754:     *-- valida CrProds.Varias = 1 (material de peso variavel); a checagem
6755:     *-- de negocio fica para a fase de calculo (CalcPreco/CalcFornec).
6756:     PROCEDURE ValidarMaterialPrincipalComposicao(par_nKeyCode, par_nShiftAltCtrl)
6757:         LOCAL loc_oPg, loc_cValor
6758:         loc_oPg    = THIS.ObterPaginaComposicao()
6759:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_MatP.Value), 14)
6760:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_MatP, loc_oPg.txt_4c_Desc, ;
6761:             "SigCdPro", "CPros", "DPros", "Produtos", ;
6762:             "cursor_4c_BuscaMatPrincipalComp", "CPros", loc_cValor, "")
6763:     ENDPROC
6764: 
6765:     *===========================================================================
6766:     * ObterPaginaDadosFiscais - Atalho para a aba "Dados Fiscais"
6767:     * (pgDadosFiscais legado), espelhando ObterPaginaDados/ObterPaginaComposicao
6768:     *===========================================================================
6769:     PROTECTED PROCEDURE ObterPaginaDadosFiscais()
6770:         RETURN THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3
6771:     ENDPROC
6772: 
6773:     *===========================================================================
6774:     * Validar*DadosFiscais - Lookups e validacoes da aba "Dados Fiscais"
6775:     * (pgDadosFiscais). Mesmo motor ExecutarLookupGenerico das outras abas.
6776:     *===========================================================================
6777:     PROCEDURE ValidarClassificacaoFiscalPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6778:         LOCAL loc_oPg, loc_cValor
6779:         loc_oPg    = THIS.ObterPaginaDadosFiscais()
6780:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), 10)
6781:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Clfiscal, loc_oPg.txt_4c_Dclfiscal, ;
6782:             "SigCdClf", "Codigos", "Descricaos", ;
6783:             "Classifica" + CHR(231) + CHR(227) + "o Fiscal", ;
6784:             "cursor_4c_BuscaClfDadosFiscais", "Codigos", loc_cValor, "")
6785:     ENDPROC
6786: 
6787:     PROCEDURE ValidarClassificacaoFiscalPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6788:         LOCAL loc_oPg, loc_cValor
6789:         loc_oPg    = THIS.ObterPaginaDadosFiscais()
6790:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
6791:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
6792:             RETURN
6793:         ENDIF
6794:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Clfiscal, loc_oPg.txt_4c_Dclfiscal, ;
6795:             "SigCdClf", "Codigos", "Descricaos", ;
6796:             "Classifica" + CHR(231) + CHR(227) + "o Fiscal", ;
6797:             "cursor_4c_BuscaClfDadosFiscais", "Descricaos", loc_cValor, "")
6798:     ENDPROC
6799: 
6800:     PROCEDURE ValidarOrigemMercadoriaPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6801:         LOCAL loc_oPg, loc_cValor
6802:         loc_oPg    = THIS.ObterPaginaDadosFiscais()
6803:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value), 1)
6804:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Origmerc, loc_oPg.txt_4c_Dorigmerc, ;
6805:             "SigCdOrg", "Codigos", "Descricaos", "Origem da Mercadoria", ;
6806:             "cursor_4c_BuscaOrgDadosFiscais", "Codigos", loc_cValor, "")
6807:     ENDPROC
6808: 
6809:     PROCEDURE ValidarOrigemMercadoriaPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6810:         LOCAL loc_oPg, loc_cValor
6811:         loc_oPg    = THIS.ObterPaginaDadosFiscais()
6812:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value)
6813:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value))
6814:             RETURN
6815:         ENDIF
6816:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Origmerc, loc_oPg.txt_4c_Dorigmerc, ;
6817:             "SigCdOrg", "Codigos", "Descricaos", "Origem da Mercadoria", ;
6818:             "cursor_4c_BuscaOrgDadosFiscais", "Descricaos", loc_cValor, "")
6819:     ENDPROC
6820: 
6821:     PROCEDURE ValidarSituacaoTributariaPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6822:         LOCAL loc_oPg, loc_cValor
6823:         loc_oPg    = THIS.ObterPaginaDadosFiscais()
6824:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Sittricm.Value), 3)
6825:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Sittricm, loc_oPg.txt_4c_Dsittricm, ;
6826:             "SigCdIcm", "Codigos", "Descricaos", ;
6827:             "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS", ;
6828:             "cursor_4c_BuscaIcmDadosFiscais", "Codigos", loc_cValor, "")
6829:     ENDPROC
6830: 
6831:     PROCEDURE ValidarSituacaoTributariaPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6832:         LOCAL loc_oPg, loc_cValor
6833:         loc_oPg    = THIS.ObterPaginaDadosFiscais()
6834:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dsittricm.Value)
6835:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Sittricm.Value))
6836:             RETURN
6837:         ENDIF
6838:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Sittricm, loc_oPg.txt_4c_Dsittricm, ;
6839:             "SigCdIcm", "Codigos", "Descricaos", ;
6840:             "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS", ;
6841:             "cursor_4c_BuscaIcmDadosFiscais", "Descricaos", loc_cValor, "")
6842:     ENDPROC
6843: 
6844:     *-- Get_CodServs legado: o Valid NAO grava no proprio campo - abre o
6845:     *-- lookup SigCdIcm e grava o resultado em getSittricm/getDsittricm
6846:     *-- (aqui txt_4c_Sittricm/txt_4c_Dsittricm), exatamente como no dump.
6847:     PROCEDURE ValidarCodigoServicoIcmsDadosFiscais(par_nKeyCode, par_nShiftAltCtrl)
6848:         LOCAL loc_oPg, loc_cValor
6849:         loc_oPg    = THIS.ObterPaginaDadosFiscais()
6850:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Codigo.Value), 4)
6851:         IF EMPTY(loc_cValor)
6852:             RETURN
6853:         ENDIF
6854:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Sittricm, loc_oPg.txt_4c_Dsittricm, ;
6855:             "SigCdIcm", "Codigos", "Descricaos", ;
6856:             "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS", ;
6857:             "cursor_4c_BuscaIcmCodServDadosFiscais", "Codigos", loc_cValor, "")
6858:     ENDPROC
6859: 
6860:     PROCEDURE ValidarTipoTributacaoDadosFiscais(par_nKeyCode, par_nShiftAltCtrl)
6861:         LOCAL loc_oPg, loc_cValor
6862:         loc_oPg    = THIS.ObterPaginaDadosFiscais()
6863:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_TpTrib.Value), 4)
6864:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_TpTrib, .NULL., "SigPrTri", ;
6865:             "Tipos", "Descs", "Tipo", "cursor_4c_BuscaTpTribDadosFiscais", ;
6866:             "Tipos", loc_cValor, "")
6867:     ENDPROC
6868: 
6869:     *===========================================================================
6870:     * ValidarIatDadosFiscais - LostFocus de txt_4c_Iat (getiat legado). So
6871:     * aceita 'A' (Arredondamento), 'T' (Truncamento) ou vazio - transcrito
6872:     * do Valid original.
6873:     *===========================================================================
6874:     PROCEDURE ValidarIatDadosFiscais(par_nKeyCode, par_nShiftAltCtrl)
6875:         LOCAL loc_oPg, loc_cValor
6876:         loc_oPg    = THIS.ObterPaginaDadosFiscais()
6877:         loc_cValor = UPPER(ALLTRIM(loc_oPg.txt_4c_Iat.Value))
6878: 
6879:         IF !INLIST(loc_cValor, "A", "T", "")
6880:             MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
6881:                 "lida. Digite [A] Indicador de Arredondamento Ou [T] " + ;
6882:                 "Indicador de Truncamento!", "Aviso")
6883:             loc_oPg.txt_4c_Iat.Value = ""
6884:         ELSE
6885:             loc_oPg.txt_4c_Iat.Value = loc_cValor
6886:         ENDIF
6887:     ENDPROC
6888: 
6889:     *===========================================================================
6890:     * ValidarAliquotaIpiDadosFiscais - LostFocus de txt_4c_AliqIPI
6891:     * (Get_AliqIPI legado). Avisa quando a aliquota informada eh IDENTICA a
6892:     * da Classificacao Fiscal (SigCdClf.aipis) - no legado isso bloqueava a
6893:     * saida do campo (Valid Return .F.); em TextBox/LostFocus so o aviso eh
6894:     * reproduzido (docs/vfp9-migration regra sobre LostFocus x Valid de GET).
6895:     *===========================================================================
6896:     PROCEDURE ValidarAliquotaIpiDadosFiscais(par_nKeyCode, par_nShiftAltCtrl)
6897:         LOCAL loc_oPg, loc_nValor, loc_cClfiscal, loc_cSQL, loc_nResultado, loException
6898:         loc_oPg       = THIS.ObterPaginaDadosFiscais()
6899:         loc_nValor    = VAL(ALLTRIM(loc_oPg.txt_4c_AliqIPI.Value))
6900:         loc_cClfiscal = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
6901: 
6902:         IF EMPTY(loc_cClfiscal) OR loc_nValor = 0
6903:             RETURN
6904:         ENDIF
6905: 
6906:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
6907:             RETURN
6908:         ENDIF
6909: 
6910:         TRY
6911:             IF USED("cursor_4c_AliqClfDadosFiscais")
6912:                 USE IN cursor_4c_AliqClfDadosFiscais
6913:             ENDIF
6914: 
6915:             loc_cSQL = "SELECT aipis FROM SigCdClf WHERE Codigos = " + ;
6916:                 EscaparSQL(PADR(loc_cClfiscal, 10))
6917:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AliqClfDadosFiscais")
6918: 
6919:             IF loc_nResultado >= 0 AND USED("cursor_4c_AliqClfDadosFiscais") ;
6920:                     AND RECCOUNT("cursor_4c_AliqClfDadosFiscais") > 0
6921:                 IF loc_nValor = cursor_4c_AliqClfDadosFiscais.aipis
6922:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no " + ;
6923:                         "produto id" + CHR(234) + "ntica " + CHR(224) + ;
6924:                         " classifica" + CHR(231) + CHR(227) + "o fiscal, " + ;
6925:                         "deixe zero e ser" + CHR(225) + " utilizada a " + ;
6926:                         "classifica" + CHR(231) + CHR(227) + "o fiscal!", ;
6927:                         "Aten" + CHR(231) + CHR(227) + "o")
6928:                 ENDIF
6929:             ENDIF
6930: 
6931:             IF USED("cursor_4c_AliqClfDadosFiscais")
6932:                 USE IN cursor_4c_AliqClfDadosFiscais
6933:             ENDIF
6934: 
6935:         CATCH TO loException
6936:             MostrarErro("Erro ao validar al" + CHR(237) + "quota de IPI:" + ;
6937:                 CHR(13) + loException.Message, ;
6938:                 "FormProduto.ValidarAliquotaIpiDadosFiscais")
6939:         ENDTRY
6940:     ENDPROC
6941: 
6942:     *-- GetMvalor legado: lookup de moeda real (SigCdMoe), mesmo padrao das
6943:     *-- demais moedas do form (ValidarMoedaCustoComposicao etc.)
6944:     PROCEDURE ValidarMoedaValorEstimadoDadosFiscais(par_nKeyCode, par_nShiftAltCtrl)
6945:         LOCAL loc_oPg, loc_cValor
6946:         loc_oPg    = THIS.ObterPaginaDadosFiscais()
6947:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Mvalor.Value), 3)
6948:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Mvalor, .NULL., "SigCdMoe", ;
6949:             "CMoes", "DMoes", "Moeda", "cursor_4c_BuscaMoedaValorDadosFiscais", ;
6950:             "CMoes", loc_cValor, "")
6951:     ENDPROC
6952: 
6953:     *-- Desenvolvido por / Criado por (aba Designer) - lookup de usuario
6954:     *-- (SigCdUsu) restrito aos usuarios de departamento com UtiLacto=1,
6955:     *-- filtro transcrito do Valid legado de GetDesLacto/GetCriaLacto
6956:     PROCEDURE ValidarDesenvolvidoPorLacto(par_nKeyCode, par_nShiftAltCtrl)
6957:         LOCAL loc_oPg, loc_cValor, loc_cFiltro
6958:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page7
6959:         loc_cValor  = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
6960:         loc_cFiltro = "cAtivos <> " + EscaparSQL("N") + " AND deptos IN " + ;
6961:             "(SELECT codigos FROM sigcddpt WHERE UtiLacto = 1)"
6962:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_DesLacto, .NULL., "SigCdUsu", ;
6963:             "Usuarios", "NComps", "Usu" + CHR(225) + "rio", ;
6964:             "cursor_4c_BuscaDesLactoDesigner", "Usuarios", loc_cValor, loc_cFiltro)
6965:     ENDPROC
6966: 
6967:     PROCEDURE ValidarCriadoPorLacto(par_nKeyCode, par_nShiftAltCtrl)
6968:         LOCAL loc_oPg, loc_cValor, loc_cFiltro
6969:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page7
6970:         loc_cValor  = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
6971:         loc_cFiltro = "cAtivos <> " + EscaparSQL("N") + " AND deptos IN " + ;
6972:             "(SELECT codigos FROM sigcddpt WHERE UtiLacto = 1)"
6973:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CriaLacto, .NULL., "SigCdUsu", ;
6974:             "Usuarios", "NComps", "Usu" + CHR(225) + "rio", ;
6975:             "cursor_4c_BuscaCriaLactoDesigner", "Usuarios", loc_cValor, loc_cFiltro)
6976:     ENDPROC
6977: 
6978:     *===========================================================================
6979:     * ConfigurarNavegacaoDivisoes - OptionGroup de 8 botoes graficos que faz o
6980:     * papel da barra de abas (Optiongroup1 legado: Top=3, Left=8, 610 x 85)
6981:     *
6982:     * Cada botao mantem o Left, o Picture e a tecla de atalho do SCX. A ordem
6983:     * dos botoes na tela (Left) NAO e a ordem do Value: o Value e o indice da
6984:     * Option, e e ele que o legado usa no DO CASE do InteractiveChange.
6985:     *===========================================================================
6986:     PROTECTED PROCEDURE ConfigurarNavegacaoDivisoes(par_oPagina)
6987:         par_oPagina.AddObject("opt_4c_Navegacao", "OptionGroup")
6988: 
6989:         *-- AutoSize = .F. com Width/Height explicitos (o legado usa AutoSize
6990:         *-- = .T., que resulta nestes mesmos 610 x 85 - aqui fica deterministico)
6991:         WITH par_oPagina.opt_4c_Navegacao
6992:             .ButtonCount   = 8
6993:             .Top           = 32
6994:             .Left          = 8
6995:             .Width         = 615
6996:             .Height        = 85
6997:             .BackStyle     = 0
6998:             .BorderStyle   = 0
6999:             .SpecialEffect = 1
7000:             .AutoSize      = .F.
7001:             .Value         = 1
7002:             .Visible       = .T.
7003:         ENDWITH
7004: 
7005:         *-- Botao 1: Principal -> aba pgDados
7006:         WITH par_oPagina.opt_4c_Navegacao.Buttons(1)
7007:             .Caption       = "\<Principal"
7008:             .BackStyle = 0
7009:             .Picture       = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
7010:             .Top           = 5
7011:             .Left          = 5
7012:             .Width         = 75
7013:             .Height        = 75
7014:             .Style         = 1
7015:             .FontName      = "Comic Sans MS"
7016:             .FontSize      = 8
7017:             .FontBold      = .T.
7018:             .FontItalic    = .T.
7019:             .ForeColor     = RGB(90, 90, 90)
7020:             .BackColor     = RGB(255, 255, 255)
7021:             .Themes        = .F.
7022:             .SpecialEffect = 0
7023:             .WordWrap      = .F.
7024:             .AutoSize      = .F.
7025:             .Visible       = .T.
7026:         ENDWITH
7027: 

*-- Linhas 7186 a 7587:
7186:             .Visible       = .T.
7187:         ENDWITH
7188: 
7189:         BINDEVENT(par_oPagina.opt_4c_Navegacao, "InteractiveChange", ;
7190:             THIS, "AlternarDivisao")
7191:     ENDPROC
7192: 
7193:     *===========================================================================
7194:     * AlternarDivisao - Troca a aba do pgf_4c_Divisoes conforme o botao marcado
7195:     * Transcricao do DO CASE de Optiongroup1.InteractiveChange do legado:
7196:     *   1 Principal -> pgDados        (PageOrder 1)
7197:     *   2 Componente-> pgComposicao   (PageOrder 2)
7198:     *   3 Custo     -> pgCusto        (PageOrder 6)
7199:     *   4 Fiscal    -> pgDadosFiscais (PageOrder 3)
7200:     *   5 Processo  -> pgDadosFaseP   (PageOrder 4)
7201:     *   6 Consumo   -> pgDadosConsP   (PageOrder 5)
7202:     *   7 Designer  -> pgDesigner     (PageOrder 7)
7203:     *   8 Servico   -> pgServico      (PageOrder 8)
7204:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
7205:     *===========================================================================
7206:     PROCEDURE AlternarDivisao()
7207:         LOCAL loc_oPagina, loc_nOpcao, loc_nAba, loException
7208: 
7209:         TRY
7210:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
7211:             loc_nOpcao  = loc_oPagina.opt_4c_Navegacao.Value
7212: 
7213:             DO CASE
7214:                 CASE loc_nOpcao = 1
7215:                     loc_nAba = 1
7216:                 CASE loc_nOpcao = 2
7217:                     loc_nAba = 2
7218:                 CASE loc_nOpcao = 3
7219:                     loc_nAba = 6
7220:                 CASE loc_nOpcao = 4
7221:                     loc_nAba = 3
7222:                 CASE loc_nOpcao = 5
7223:                     loc_nAba = 4
7224:                 CASE loc_nOpcao = 6
7225:                     loc_nAba = 5
7226:                 CASE loc_nOpcao = 7
7227:                     loc_nAba = 7
7228:                 CASE loc_nOpcao = 8
7229:                     loc_nAba = 8
7230:                 OTHERWISE
7231:                     loc_nAba = 1
7232:             ENDCASE
7233: 
7234:             loc_oPagina.pgf_4c_Divisoes.ActivePage = loc_nAba
7235:             THIS.this_nDivisaoAtual = loc_nAba
7236: 
7237:         CATCH TO loException
7238:             MostrarErro("Erro ao alternar a aba de dados:" + CHR(13) + ;
7239:                 loException.Message, "FormProduto.AlternarDivisao")
7240:         ENDTRY
7241:     ENDPROC
7242: 
7243:     *===========================================================================
7244:     * IrParaDivisao - Posiciona o PageFrame interno e a barra de navegacao na
7245:     * aba informada (1..8). O legado sempre volta para "Principal" ao entrar
7246:     * em INSERIR/ALTERAR/CONSULTAR/PROCURAR.
7247:     *
7248:     * O Value do OptionGroup NAO eh o indice da Page: AlternarDivisao traduz
7249:     * (3 Custo -> Page6, 4 Fiscal -> Page3 ...). Aqui fazemos o caminho
7250:     * inverso, para o botao marcado bater com a aba exibida.
7251:     *===========================================================================
7252:     PROCEDURE IrParaDivisao(par_nAba)
7253:         LOCAL loc_oPagina, loc_nAba, loc_nOpcao, loException
7254: 
7255:         TRY
7256:             loc_nAba = IIF(VARTYPE(par_nAba) = "N" AND BETWEEN(par_nAba, 1, 8), par_nAba, 1)
7257: 
7258:             DO CASE
7259:                 CASE loc_nAba = 1
7260:                     loc_nOpcao = 1
7261:                 CASE loc_nAba = 2
7262:                     loc_nOpcao = 2
7263:                 CASE loc_nAba = 3
7264:                     loc_nOpcao = 4
7265:                 CASE loc_nAba = 4
7266:                     loc_nOpcao = 5
7267:                 CASE loc_nAba = 5
7268:                     loc_nOpcao = 6
7269:                 CASE loc_nAba = 6
7270:                     loc_nOpcao = 3
7271:                 CASE loc_nAba = 7
7272:                     loc_nOpcao = 7
7273:                 OTHERWISE
7274:                     loc_nOpcao = 8
7275:             ENDCASE
7276: 
7277:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
7278:             loc_oPagina.pgf_4c_Divisoes.ActivePage = loc_nAba
7279:             loc_oPagina.opt_4c_Navegacao.Value     = loc_nOpcao
7280:             THIS.this_nDivisaoAtual                = loc_nAba
7281: 
7282:         CATCH TO loException
7283:             MostrarErro("Erro ao posicionar a aba de dados:" + CHR(13) + ;
7284:                 loException.Message, "FormProduto.IrParaDivisao")
7285:         ENDTRY
7286:     ENDPROC
7287: 
7288:     *===========================================================================
7289:     * ObterPaginaDados - Atalho para a aba "Dados Principais" (pgDados legado)
7290:     *===========================================================================
7291:     PROTECTED PROCEDURE ObterPaginaDados()
7292:         RETURN THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
7293:     ENDPROC
7294: 
7295:     *===========================================================================
7296:     * FormParaBO - Transfere os campos da aba Dados Principais para o BO
7297:     *
7298:     * O mapa campo -> coluna eh a transcricao dos ControlSource do SCX legado
7299:     * (crSigCdPro.<coluna>), coluna por coluna. Campos de DESCRICAO de lookup
7300:     * (Dgru, DsGru, DLin, DCol, Dfor, DesFinP, Duni, _dunip) NAO tem
7301:     * ControlSource no legado: sao so apoio visual e por isso nao entram aqui.
7302:     * Estoques/QtdEsts tambem ficam de fora - o SCX zera o ControlSource deles
7303:     * (sao calculados, nao existem em SigCdPro).
7304:     *===========================================================================
7305:     PROTECTED PROCEDURE FormParaBO()
7306:         LOCAL loc_lResultado, loc_oPg, loc_oBO, loException
7307:         loc_lResultado = .F.
7308: 
7309:         TRY
7310:             loc_oPg = THIS.ObterPaginaDados()
7311:             loc_oBO = THIS.this_oBusinessObject
7312: 
7313:             *-- Identificacao ------------------------------------------------
7314:             loc_oBO.this_cCpros    = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)          && cpros
7315:             loc_oBO.this_cDpros    = ALLTRIM(loc_oPg.txt_4c_Dpro.Value)          && dpros
7316:             loc_oBO.this_cDpro2s   = ALLTRIM(loc_oPg.txt_4c_DPro2s.Value)        && dpro2s
7317:             loc_oBO.this_cCproeqs  = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)        && cproeqs
7318:             loc_oBO.this_nCbars    = ALLTRIM(loc_oPg.txt_4c_Cbar.Value)     && cbars
7319:             loc_oBO.this_nEan13    = ALLTRIM(loc_oPg.txt_4c_EAN13.Value)    && ean13
7320: 
7321:             *-- Classificacao ------------------------------------------------
7322:             loc_oBO.this_cCgrus    = ALLTRIM(loc_oPg.txt_4c_Cgru.Value)          && cgrus
7323:             loc_oBO.this_cSgrus    = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)         && sgrus
7324:             loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Lin.Value)           && linhas
7325:             loc_oBO.this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Col.Value)           && colecoes
7326:             loc_oBO.this_cMercs    = ALLTRIM(loc_oPg.txt_4c_Merc.Value)          && mercs
7327:             loc_oBO.this_cCclass   = ALLTRIM(loc_oPg.txt_4c_Class.Value)         && cClass
7328:             loc_oBO.this_cIdecpros = ALLTRIM(loc_oPg.txt_4c_IdeCPros.Value)      && IdeCPros
7329:             loc_oBO.this_cConjunts = ALLTRIM(loc_oPg.txt_4c_Conjunto.Value)      && Conjunts
7330: 
7331:             *-- Fornecedor / referencia / modelo ------------------------------
7332:             loc_oBO.this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)          && ifors
7333:             loc_oBO.this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Refs.Value)          && reffs
7334:             loc_oBO.this_cCodfinp  = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)       && CodFinP
7335: 
7336:             *-- Unidades e localizacao ----------------------------------------
7337:             loc_oBO.this_cCunis    = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)          && cunis
7338:             loc_oBO.this_cCunips   = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)         && cunips
7339:             loc_oBO.this_cLocals   = ALLTRIM(loc_oPg.txt_4c_Local.Value)         && locals
7340: 
7341:             *-- Situacao (OptionGroup: 1 = Ativo, 2 = Inativo) -----------------
7342:             loc_oBO.this_nSituas   = loc_oPg.obj_4c_Opc_situacao.Value           && situas
7343: 
7344:             *-- Observacoes livres --------------------------------------------
7345:             loc_oBO.this_cObspes   = ALLTRIM(loc_oPg.txt_4c_Obs1.Value)          && obspes
7346:             loc_oBO.this_cObspeds  = ALLTRIM(loc_oPg.txt_4c_Obs2.Value)          && obspeds
7347:             loc_oBO.this_cObsetqs  = ALLTRIM(loc_oPg.txt_4c_Obs3.Value)          && obsetqs
7348: 
7349:             *-- Custo / venda e suas moedas -----------------------------------
7350:             loc_oBO.this_nCustofs  = ALLTRIM(loc_oPg.txt_4c_Ctotal.Value)   && custofs
7351:             loc_oBO.this_cMoecusfs = ALLTRIM(loc_oPg.txt_4c_Mctotal.Value)       && moecusfs
7352:             loc_oBO.this_nPvens    = ALLTRIM(loc_oPg.txt_4c_Pvenda.Value)   && pvens
7353:             loc_oBO.this_cMoevs    = ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value)       && moevs
7354:             loc_oBO.this_nFvendas  = ALLTRIM(loc_oPg.txt_4c_Fvenda.Value)   && fvendas
7355:             loc_oBO.this_cMoepvs   = ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value)       && moepvs
7356: 
7357:             *-- Auditoria: data/usuario de inclusao e de alteracao.
7358:             *-- Os carimbos sao aplicados pelo BO (AplicarCarimboInclusao /
7359:             *-- AplicarCarimboAlteracao); aqui so devolvemos o que ja estava
7360:             *-- gravado, para o UPDATE nao zerar a inclusao original.
7361:             loc_oBO.this_dDtincs   = ConverterParaData(loc_oPg.txt_4c_DtIncs.Value)   && dtincs
7362:             loc_oBO.this_cUsuincs  = ALLTRIM(loc_oPg.txt_4c_Usuario.Value)            && UsuIncs
7363:             loc_oBO.this_dDtalts   = ConverterParaData(loc_oPg.txt_4c_DataAlts.Value) && dtalts
7364:             loc_oBO.this_cUsuaalts = ALLTRIM(loc_oPg.txt_4c_UsuaAlts.Value)           && usuaalts
7365: 
7366:             loc_oBO.MarcarComoAlterado()
7367:             loc_lResultado = .T.
7368: 
7369:         CATCH TO loException
7370:             MostrarErro("Erro ao transferir os dados do formul" + CHR(225) + "rio:" + ;
7371:                 CHR(13) + loException.Message + CHR(13) + ;
7372:                 "Linha: " + TRANSFORM(loException.LineNo), "FormProduto.FormParaBO")
7373:             loc_lResultado = .F.
7374:         ENDTRY
7375: 
7376:         RETURN loc_lResultado
7377:     ENDPROC
7378: 
7379:     *===========================================================================
7380:     * BOParaForm - Transfere o BO para os campos da aba Dados Principais
7381:     * Espelho EXATO de FormParaBO (mesma lista de campos, mesma ordem).
7382:     *
7383:     * Os campos de DESCRICAO dos lookups nao existem no BO; sao recarregados
7384:     * por PreencherDescricoesLookup(), que consulta as tabelas de apoio.
7385:     *===========================================================================
7386:     PROTECTED PROCEDURE BOParaForm()
7387:         LOCAL loc_lResultado, loc_oPg, loc_oBO, loException
7388:         loc_lResultado = .F.
7389: 
7390:         TRY
7391:             loc_oPg = THIS.ObterPaginaDados()
7392:             loc_oBO = THIS.this_oBusinessObject
7393: 
7394:             *-- Identificacao ------------------------------------------------
7395:             loc_oPg.txt_4c_Cpro.Value    = ALLTRIM(loc_oBO.this_cCpros)
7396:             loc_oPg.txt_4c_Dpro.Value    = ALLTRIM(loc_oBO.this_cDpros)
7397:             loc_oPg.txt_4c_DPro2s.Value  = ALLTRIM(loc_oBO.this_cDpro2s)
7398:             loc_oPg.txt_4c_CProEq.Value  = ALLTRIM(loc_oBO.this_cCproeqs)
7399:             loc_oPg.txt_4c_Cbar.Value    = THIS.FormatarNumeroTexto(loc_oBO.this_nCbars, 0)
7400:             loc_oPg.txt_4c_EAN13.Value   = THIS.FormatarNumeroTexto(loc_oBO.this_nEan13, 0)
7401: 
7402:             *-- Classificacao ------------------------------------------------
7403:             loc_oPg.txt_4c_Cgru.Value     = ALLTRIM(loc_oBO.this_cCgrus)
7404:             loc_oPg.txt_4c_CSGru.Value    = ALLTRIM(loc_oBO.this_cSgrus)
7405:             loc_oPg.txt_4c_Lin.Value      = ALLTRIM(loc_oBO.this_cLinhas)
7406:             loc_oPg.txt_4c_Col.Value      = ALLTRIM(loc_oBO.this_cColecoes)
7407:             loc_oPg.txt_4c_Merc.Value     = ALLTRIM(loc_oBO.this_cMercs)
7408:             loc_oPg.txt_4c_Class.Value    = ALLTRIM(loc_oBO.this_cCclass)
7409:             loc_oPg.txt_4c_IdeCPros.Value = ALLTRIM(loc_oBO.this_cIdecpros)
7410:             loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(loc_oBO.this_cConjunts)
7411: 
7412:             *-- Fornecedor / referencia / modelo ------------------------------
7413:             loc_oPg.txt_4c_Ifor.Value    = ALLTRIM(loc_oBO.this_cIfors)
7414:             loc_oPg.txt_4c_Refs.Value    = ALLTRIM(loc_oBO.this_cReffs)
7415:             loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(loc_oBO.this_cCodfinp)
7416: 
7417:             *-- Unidades e localizacao ----------------------------------------
7418:             loc_oPg.txt_4c_Cuni.Value  = ALLTRIM(loc_oBO.this_cCunis)
7419:             loc_oPg.txt_4c_Cunip.Value = ALLTRIM(loc_oBO.this_cCunips)
7420:             loc_oPg.txt_4c_Local.Value = ALLTRIM(loc_oBO.this_cLocals)
7421: 
7422:             *-- Situacao: o OptionGroup so aceita 1 ou 2 (Ativo / Inativo)
7423:             loc_oPg.obj_4c_Opc_situacao.Value = IIF(loc_oBO.this_nSituas = 2, 2, 1)
7424: 
7425:             *-- Observacoes livres --------------------------------------------
7426:             loc_oPg.txt_4c_Obs1.Value = ALLTRIM(loc_oBO.this_cObspes)
7427:             loc_oPg.txt_4c_Obs2.Value = ALLTRIM(loc_oBO.this_cObspeds)
7428:             loc_oPg.txt_4c_Obs3.Value = ALLTRIM(loc_oBO.this_cObsetqs)
7429: 
7430:             *-- Custo / venda e suas moedas -----------------------------------
7431:             loc_oPg.txt_4c_Ctotal.Value   = THIS.FormatarNumeroTexto(loc_oBO.this_nCustofs, 3)
7432:             loc_oPg.txt_4c_Mctotal.Value  = ALLTRIM(loc_oBO.this_cMoecusfs)
7433:             loc_oPg.txt_4c_Pvenda.Value   = THIS.FormatarNumeroTexto(loc_oBO.this_nPvens, 5)
7434:             loc_oPg.txt_4c_Mpvenda.Value  = ALLTRIM(loc_oBO.this_cMoevs)
7435:             loc_oPg.txt_4c_Fvenda.Value   = THIS.FormatarNumeroTexto(loc_oBO.this_nFvendas, 3)
7436:             loc_oPg.txt_4c_Mfvenda.Value  = ALLTRIM(loc_oBO.this_cMoepvs)
7437: 
7438:             *-- Auditoria -----------------------------------------------------
7439:             loc_oPg.txt_4c_DtIncs.Value   = THIS.FormatarDataTexto(loc_oBO.this_dDtincs)
7440:             loc_oPg.txt_4c_Usuario.Value  = ALLTRIM(loc_oBO.this_cUsuincs)
7441:             loc_oPg.txt_4c_DataAlts.Value = THIS.FormatarDataTexto(loc_oBO.this_dDtalts)
7442:             loc_oPg.txt_4c_UsuaAlts.Value = ALLTRIM(loc_oBO.this_cUsuaalts)
7443: 
7444:             *-- Descricoes dos lookups (nao existem em SigCdPro)
7445:             THIS.PreencherDescricoesLookup()
7446: 
7447:             loc_lResultado = .T.
7448: 
7449:         CATCH TO loException
7450:             MostrarErro("Erro ao exibir os dados do produto:" + CHR(13) + ;
7451:                 loException.Message + CHR(13) + ;
7452:                 "Linha: " + TRANSFORM(loException.LineNo), "FormProduto.BOParaForm")
7453:             loc_lResultado = .F.
7454:         ENDTRY
7455: 
7456:         RETURN loc_lResultado
7457:     ENDPROC
7458: 
7459:     *===========================================================================
7460:     * FormatarNumeroTexto - Converte numerico para o texto exibido no TextBox
7461:     * Os TextBox numericos desta aba sao de tipo Caractere (o legado usa
7462:     * ControlSource direto na coluna; aqui o valor entra como texto), entao a
7463:     * conversao passa por aqui em vez de atribuir o numero cru.
7464:     *===========================================================================
7465:     PROTECTED PROCEDURE FormatarNumeroTexto(par_nValor, par_nDecimais)
7466:         LOCAL loc_nValor, loc_nDec, loc_cTexto
7467:         loc_nValor = IIF(VARTYPE(par_nValor) = "N", par_nValor, 0)
7468:         loc_nDec   = IIF(VARTYPE(par_nDecimais) = "N", par_nDecimais, 0)
7469:         loc_cTexto = ""
7470: 
7471:         IF loc_nValor != 0
7472:             IF loc_nDec > 0
7473:                 loc_cTexto = ALLTRIM(STR(loc_nValor, 20, loc_nDec))
7474:             ELSE
7475:                 loc_cTexto = ALLTRIM(STR(loc_nValor, 20, 0))
7476:             ENDIF
7477:         ENDIF
7478: 
7479:         RETURN loc_cTexto
7480:     ENDPROC
7481: 
7482:     *===========================================================================
7483:     * FormatarDataTexto - Converte DATE/DATETIME para o texto do TextBox
7484:     * Regra #16: NUNCA TTOD() direto - o valor chega como DATE (campo em
7485:     * branco) ou DATETIME (vindo do SQL Server) conforme o caminho.
7486:     *===========================================================================
7487:     PROTECTED PROCEDURE FormatarDataTexto(par_uData)
7488:         LOCAL loc_dData, loc_cTexto
7489:         loc_cTexto = ""
7490:         loc_dData  = ConverterParaData(par_uData)
7491: 
7492:         IF VARTYPE(loc_dData) = "D" AND !EMPTY(loc_dData)
7493:             loc_cTexto = DTOC(loc_dData)
7494:         ENDIF
7495: 
7496:         RETURN loc_cTexto
7497:     ENDPROC
7498: 
7499:     *===========================================================================
7500:     * PreencherDescricoesLookup - Recarrega os campos de descricao dos lookups
7501:     * (Grupo, Subgrupo, Linha, Colecao, Fornecedor, Modelo, Unidades). Eles nao
7502:     * existem em SigCdPro, por isso sao consultados nas tabelas de apoio.
7503:     *===========================================================================
7504:     PROTECTED PROCEDURE PreencherDescricoesLookup()
7505:         LOCAL loc_oPg, loc_cGrupo, loException
7506:         loc_oPg = THIS.ObterPaginaDados()
7507: 
7508:         TRY
7509:             loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_Cgru.Value)
7510: 
7511:             loc_oPg.txt_4c_Dgru.Value = THIS.ObterDescricaoTabela("SigCdGrp", ;
7512:                 "dgrus", "cgrus", loc_cGrupo, "")
7513: 
7514:             loc_oPg.txt_4c_DsGru.Value = THIS.ObterDescricaoTabela("SigCdPsg", ;
7515:                 "Descricaos", "Codigos", ALLTRIM(loc_oPg.txt_4c_CSGru.Value), ;
7516:                 IIF(EMPTY(loc_cGrupo), "", "CGrus = " + EscaparSQL(PADR(loc_cGrupo, 3))))
7517: 
7518:             loc_oPg.txt_4c_DLin.Value = THIS.ObterDescricaoTabela("SigCdLin", ;
7519:                 "Descs", "Linhas", ALLTRIM(loc_oPg.txt_4c_Lin.Value), "")
7520: 
7521:             loc_oPg.txt_4c_DCol.Value = THIS.ObterDescricaoTabela("SigCdCol", ;
7522:                 "Descs", "Colecoes", ALLTRIM(loc_oPg.txt_4c_Col.Value), "")
7523: 
7524:             loc_oPg.txt_4c_Dfor.Value = THIS.ObterDescricaoTabela("SigCdCli", ;
7525:                 "Rclis", "Iclis", ALLTRIM(loc_oPg.txt_4c_Ifor.Value), "")
7526: 
7527:             loc_oPg.txt_4c_DesFinP.Value = THIS.ObterDescricaoTabela("SigCdFip", ;
7528:                 "Descs", "Cods", ALLTRIM(loc_oPg.txt_4c_CodFinP.Value), "")
7529: 
7530:             loc_oPg.txt_4c_Duni.Value = THIS.ObterDescricaoTabela("SigCdUni", ;
7531:                 "DUnis", "CUnis", ALLTRIM(loc_oPg.txt_4c_Cuni.Value), "")
7532: 
7533:             loc_oPg.txt_4c__dunip.Value = THIS.ObterDescricaoTabela("SigCdUni", ;
7534:                 "DUnis", "CUnis", ALLTRIM(loc_oPg.txt_4c_Cunip.Value), "")
7535: 
7536:         CATCH TO loException
7537:             MostrarErro("Erro ao carregar as descri" + CHR(231) + CHR(245) + "es:" + ;
7538:                 CHR(13) + loException.Message, "FormProduto.PreencherDescricoesLookup")
7539:         ENDTRY
7540:     ENDPROC
7541: 
7542:     *===========================================================================
7543:     * ObterDescricaoTabela - Le UMA descricao de uma tabela de apoio
7544:     * Devolve "" quando o codigo esta vazio ou nao existe (sem mensagem: aqui
7545:     * a ausencia de descricao nao eh erro, eh campo em branco).
7546:     *===========================================================================
7547:     PROTECTED PROCEDURE ObterDescricaoTabela(par_cTabela, par_cCampoDesc, ;
7548:             par_cCampoChave, par_cValor, par_cFiltro)
7549:         LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loException
7550:         loc_cDescricao = ""
7551: 
7552:         IF EMPTY(ALLTRIM(NVL(par_cValor, "")))
7553:             RETURN ""
7554:         ENDIF
7555: 
7556:         *-- Sem conexao (validacao de UI / teste headless) nao ha o que
7557:         *-- consultar. Sai antes do SQLEXEC: senao cada um dos 8 lookups de
7558:         *-- PreencherDescricoesLookup abriria o seu proprio dialogo de erro.
7559:         *-- O CATCH abaixo continua reportando falha REAL de SQL (regra #9).
7560:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
7561:             RETURN ""
7562:         ENDIF
7563: 
7564:         TRY
7565:             IF USED("cursor_4c_DescAux")
7566:                 USE IN cursor_4c_DescAux
7567:             ENDIF
7568: 
7569:             loc_cSQL = "SELECT " + par_cCampoDesc + " FROM " + par_cTabela + ;
7570:                 " WHERE " + par_cCampoChave + " = " + EscaparSQL(ALLTRIM(par_cValor))
7571: 
7572:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
7573:                 loc_cSQL = loc_cSQL + " AND " + par_cFiltro
7574:             ENDIF
7575: 
7576:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescAux")
7577: 
7578:             IF loc_nResultado >= 0 AND USED("cursor_4c_DescAux")
7579:                 IF RECCOUNT("cursor_4c_DescAux") > 0
7580:                     SELECT cursor_4c_DescAux
7581:                     GO TOP
7582:                     loc_cDescricao = ALLTRIM(NVL(EVALUATE("cursor_4c_DescAux." + par_cCampoDesc), ""))
7583:                 ENDIF
7584:             ENDIF
7585: 
7586:             IF USED("cursor_4c_DescAux")
7587:                 USE IN cursor_4c_DescAux

*-- Linhas 7599 a 7708:
7599:     *===========================================================================
7600:     * LimparCampos - Zera todos os campos da aba Dados Principais
7601:     *===========================================================================
7602:     PROTECTED PROCEDURE LimparCampos()
7603:         LOCAL loc_oPg, loException
7604: 
7605:         TRY
7606:             loc_oPg = THIS.ObterPaginaDados()
7607: 
7608:             STORE "" TO loc_oPg.txt_4c_Cpro.Value,     loc_oPg.txt_4c_Dpro.Value, ;
7609:                         loc_oPg.txt_4c_DPro2s.Value,   loc_oPg.txt_4c_CProEq.Value, ;
7610:                         loc_oPg.txt_4c_Cbar.Value,     loc_oPg.txt_4c_EAN13.Value
7611: 
7612:             STORE "" TO loc_oPg.txt_4c_Cgru.Value,     loc_oPg.txt_4c_Dgru.Value, ;
7613:                         loc_oPg.txt_4c_CSGru.Value,    loc_oPg.txt_4c_DsGru.Value, ;
7614:                         loc_oPg.txt_4c_Lin.Value,      loc_oPg.txt_4c_DLin.Value, ;
7615:                         loc_oPg.txt_4c_Col.Value,      loc_oPg.txt_4c_DCol.Value
7616: 
7617:             STORE "" TO loc_oPg.txt_4c_Merc.Value,     loc_oPg.txt_4c_Class.Value, ;
7618:                         loc_oPg.txt_4c_IdeCPros.Value, loc_oPg.txt_4c_Conjunto.Value
7619: 
7620:             STORE "" TO loc_oPg.txt_4c_Ifor.Value,     loc_oPg.txt_4c_Dfor.Value, ;
7621:                         loc_oPg.txt_4c_Refs.Value,     loc_oPg.txt_4c_CodFinP.Value, ;
7622:                         loc_oPg.txt_4c_DesFinP.Value
7623: 
7624:             STORE "" TO loc_oPg.txt_4c_Cuni.Value,     loc_oPg.txt_4c_Duni.Value, ;
7625:                         loc_oPg.txt_4c_Cunip.Value,    loc_oPg.txt_4c__dunip.Value, ;
7626:                         loc_oPg.txt_4c_Local.Value
7627: 
7628:             STORE "" TO loc_oPg.txt_4c_Obs1.Value,     loc_oPg.txt_4c_Obs2.Value, ;
7629:                         loc_oPg.txt_4c_Obs3.Value
7630: 
7631:             STORE "" TO loc_oPg.txt_4c_Ctotal.Value,   loc_oPg.txt_4c_Mctotal.Value, ;
7632:                         loc_oPg.txt_4c_Pvenda.Value,   loc_oPg.txt_4c_Mpvenda.Value, ;
7633:                         loc_oPg.txt_4c_Fvenda.Value,   loc_oPg.txt_4c_Mfvenda.Value
7634: 
7635:             STORE "" TO loc_oPg.txt_4c_Estoques.Value, loc_oPg.txt_4c_QtdEsts.Value
7636: 
7637:             STORE "" TO loc_oPg.txt_4c_DtIncs.Value,   loc_oPg.txt_4c_Usuario.Value, ;
7638:                         loc_oPg.txt_4c_DataAlts.Value, loc_oPg.txt_4c_UsuaAlts.Value
7639: 
7640:             *-- Situacao volta para Ativo (default do legado ao incluir)
7641:             loc_oPg.obj_4c_Opc_situacao.Value = 1
7642: 
7643:             *-- Guarda de reentrancia dos lookups (regra #45)
7644:             THIS.this_cUltimoGrupoValidado = ""
7645: 
7646:         CATCH TO loException
7647:             MostrarErro("Erro ao limpar os campos:" + CHR(13) + ;
7648:                 loException.Message, "FormProduto.LimparCampos")
7649:         ENDTRY
7650:     ENDPROC
7651: 
7652:     *===========================================================================
7653:     * HabilitarCampos - Liga/desliga a edicao dos campos da aba Dados
7654:     *
7655:     * Tres estados, transcritos do legado:
7656:     *   INCLUIR / ALTERAR -> tudo editavel, menos os campos calculados
7657:     *                        (getCtotal/getPvenda/getFvenda/getEstoques/
7658:     *                        getQtdEsts/Get_DtIncs/Get_Usuario/getDataAlts/
7659:     *                        getUsuaAlts, que tem When = .F. no SCX)
7660:     *   BUSCAR            -> SOMENTE os 7 campos plProcurar = .T. do SCX
7661:     *                        (getCpro, getDpro, getDpro2s, getRefs, getIfor,
7662:     *                        getCbar, getConjunto) - msv_procurar so le esses
7663:     *   VISUALIZAR/EXCLUIR-> nada editavel
7664:     *
7665:     * O codigo do produto segue a mesma regra do legado: so eh digitavel
7666:     * enquanto se INCLUI ou se PROCURA - em ALTERAR ele eh a chave.
7667:     *===========================================================================
7668:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
7669:         LOCAL loc_oPg, loc_lEdita, loc_lProcura, loc_lChave, loException
7670: 
7671:         TRY
7672:             loc_oPg      = THIS.ObterPaginaDados()
7673:             loc_lProcura = (THIS.this_cModoAtual == "BUSCAR")
7674:             loc_lEdita   = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.) ;
7675:                            AND !loc_lProcura
7676:             loc_lChave   = (loc_lEdita AND THIS.this_cModoAtual == "INCLUIR") OR loc_lProcura
7677: 
7678:             *-- Campos plProcurar: editaveis em INCLUIR/ALTERAR e em BUSCAR
7679:             loc_oPg.txt_4c_Cpro.Enabled     = loc_lChave
7680:             loc_oPg.txt_4c_Dpro.Enabled     = loc_lEdita OR loc_lProcura
7681:             loc_oPg.txt_4c_DPro2s.Enabled   = loc_lEdita OR loc_lProcura
7682:             loc_oPg.txt_4c_Refs.Enabled     = loc_lEdita OR loc_lProcura
7683:             loc_oPg.txt_4c_Ifor.Enabled     = loc_lEdita OR loc_lProcura
7684:             loc_oPg.txt_4c_Cbar.Enabled     = loc_lEdita OR loc_lProcura
7685:             loc_oPg.txt_4c_Conjunto.Enabled = loc_lEdita OR loc_lProcura
7686: 
7687:             *-- Demais campos: so em INCLUIR / ALTERAR
7688:             loc_oPg.txt_4c_CProEq.Enabled = loc_lEdita
7689:             loc_oPg.txt_4c_EAN13.Enabled  = loc_lEdita
7690: 
7691:             loc_oPg.txt_4c_Cgru.Enabled     = loc_lEdita
7692:             loc_oPg.txt_4c_Dgru.Enabled     = loc_lEdita
7693:             loc_oPg.txt_4c_CSGru.Enabled    = loc_lEdita
7694:             loc_oPg.txt_4c_DsGru.Enabled    = loc_lEdita
7695:             loc_oPg.txt_4c_Lin.Enabled      = loc_lEdita
7696:             loc_oPg.txt_4c_DLin.Enabled     = loc_lEdita
7697:             loc_oPg.txt_4c_Col.Enabled      = loc_lEdita
7698:             loc_oPg.txt_4c_DCol.Enabled     = loc_lEdita
7699:             loc_oPg.txt_4c_Class.Enabled    = loc_lEdita
7700:             loc_oPg.txt_4c_IdeCPros.Enabled = loc_lEdita
7701: 
7702:             loc_oPg.txt_4c_Dfor.Enabled     = loc_lEdita
7703:             loc_oPg.txt_4c_CodFinP.Enabled  = loc_lEdita
7704:             loc_oPg.txt_4c_DesFinP.Enabled  = loc_lEdita
7705: 
7706:             loc_oPg.txt_4c_Cuni.Enabled     = loc_lEdita
7707:             loc_oPg.txt_4c_Duni.Enabled     = loc_lEdita
7708:             loc_oPg.txt_4c_Cunip.Enabled    = loc_lEdita

*-- Linhas 7757 a 7978:
7757:     * PUBLIC: o TesteAutomatico.prg chama THIS.oForm.AjustarBotoesPorModo() de
7758:     * FORA da classe (CLAUDE.md regra #3).
7759:     *===========================================================================
7760:     PROCEDURE AjustarBotoesPorModo()
7761:         LOCAL loc_oBotoes, loc_oAcao, loc_lLista, loc_lEdicao, loException
7762: 
7763:         TRY
7764:             loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
7765:             loc_oAcao   = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
7766: 
7767:             loc_lLista  = (THIS.this_cModoAtual == "LISTA")
7768:             loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
7769: 
7770:             *-- Botoes CRUD da pagina Lista
7771:             loc_oBotoes.cmd_4c_Incluir.Enabled    = loc_lLista
7772:             loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lLista
7773:             loc_oBotoes.cmd_4c_Alterar.Enabled    = loc_lLista
7774:             loc_oBotoes.cmd_4c_Excluir.Enabled    = loc_lLista
7775:             loc_oBotoes.cmd_4c_Buscar.Enabled     = loc_lLista
7776: 
7777:             *-- Confirmar so quando ha algo a confirmar; Cancelar sempre ativo
7778:             loc_oAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
7779:             loc_oAcao.cmd_4c_Cancelar.Enabled  = .T.
7780: 
7781:             *-- Confirmar muda de rotulo quando esta procurando (o legado troca
7782:             *-- a acao do mesmo botao em msv_procurar)
7783:             loc_oAcao.cmd_4c_Confirmar.Caption = ;
7784:                 IIF(THIS.this_cModoAtual == "BUSCAR", "Procurar", "Confirmar")
7785: 
7786:         CATCH TO loException
7787:             MostrarErro("Erro ao ajustar os bot" + CHR(245) + "es:" + CHR(13) + ;
7788:                 loException.Message, "FormProduto.AjustarBotoesPorModo")
7789:         ENDTRY
7790:     ENDPROC
7791: 
7792:     *===========================================================================
7793:     * BtnSalvarClick - Confirmar da pagina Dados
7794:     *
7795:     * Em modo BUSCAR o botao executa a busca POR EXEMPLO do legado
7796:     * (msv_procurar); nos demais modos grava pelo BO.
7797:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
7798:     *===========================================================================
7799:     PROCEDURE BtnSalvarClick()
7800:         LOCAL loc_oBO, loException
7801: 
7802:         IF THIS.this_cModoAtual == "BUSCAR"
7803:             THIS.ExecutarBuscaPorExemplo()
7804:             RETURN
7805:         ENDIF
7806: 
7807:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7808:             MsgAviso("Nada a confirmar neste modo.")
7809:             RETURN
7810:         ENDIF
7811: 
7812:         IF !THIS.FormParaBO()
7813:             RETURN
7814:         ENDIF
7815: 
7816:         loc_oBO = THIS.this_oBusinessObject
7817: 
7818:         TRY
7819:             IF loc_oBO.Salvar()
7820:                 MsgInfo("Produto gravado com sucesso!", "Confirmar")
7821:                 THIS.this_cModoAtual = "LISTA"
7822:                 THIS.AlternarPagina(1)
7823:             ELSE
7824:                 *-- Regra #20: o BusinessBase ja reporta a falha. So completamos
7825:                 *-- com o foco no campo que a validacao do BO recusou.
7826:                 IF !loc_oBO.this_lErroExibido
7827:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
7828:                         "vel gravar o produto.", "Confirmar")
7829:                 ENDIF
7830:                 THIS.FocarCampoValidacao()
7831:             ENDIF
7832: 
7833:         CATCH TO loException
7834:             MostrarErro("Erro ao gravar o produto:" + CHR(13) + ;
7835:                 loException.Message + CHR(13) + ;
7836:                 "Linha: " + TRANSFORM(loException.LineNo), "FormProduto.BtnSalvarClick")
7837:         ENDTRY
7838:     ENDPROC
7839: 
7840:     *===========================================================================
7841:     * BtnCancelarClick - Cancela a edicao/procura e volta para a Lista
7842:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
7843:     *===========================================================================
7844:     PROCEDURE BtnCancelarClick()
7845:         LOCAL loException
7846: 
7847:         TRY
7848:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
7849:                 THIS.this_oBusinessObject.CancelarEdicao()
7850:             ENDIF
7851: 
7852:             THIS.LimparCampos()
7853:             THIS.this_cModoAtual = "LISTA"
7854: 
7855:             *-- AlternarPagina(1) repoe o modo, recarrega a grade e reabilita
7856:             *-- os botoes CRUD (regra #40)
7857:             THIS.AlternarPagina(1)
7858: 
7859:         CATCH TO loException
7860:             MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, ;
7861:                 "FormProduto.BtnCancelarClick")
7862:         ENDTRY
7863:     ENDPROC
7864: 
7865:     *===========================================================================
7866:     * FocarCampoValidacao - Leva o foco para o campo recusado pelo BO
7867:     * O ProdutoBO preenche this_cPaginaFoco / this_cCampoFoco em ValidarDados.
7868:     * Regra #34: alcancar membro por NOME exige EVALUATE, nunca Controls(nome).
7869:     *===========================================================================
7870:     PROTECTED PROCEDURE FocarCampoValidacao()
7871:         LOCAL loc_oPg, loc_oCampo, loc_cCampo, loc_lProsseguir, loException
7872:         loc_lProsseguir = .T.
7873: 
7874:         TRY
7875:             loc_cCampo = ALLTRIM(THIS.this_oBusinessObject.this_cCampoFoco)
7876: 
7877:             IF EMPTY(loc_cCampo)
7878:                 loc_lProsseguir = .F.
7879:             ENDIF
7880: 
7881:             *-- So a aba Dados Principais existe neste form; campos das outras
7882:             *-- abas (FISCAL / COMPOSICAO) sao ignorados sem erro.
7883:             IF loc_lProsseguir
7884:                 IF !(UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cPaginaFoco)) == "DADOS")
7885:                     loc_lProsseguir = .F.
7886:                 ENDIF
7887:             ENDIF
7888: 
7889:             IF loc_lProsseguir
7890:                 loc_oPg = THIS.ObterPaginaDados()
7891: 
7892:                 IF PEMSTATUS(loc_oPg, loc_cCampo, 5)
7893:                     THIS.IrParaDivisao(1)
7894: 
7895:                     *-- Regra #34: membro por NOME so via EVALUATE. E o
7896:                     *-- resultado precisa de uma variavel - VFP9 nao aceita
7897:                     *-- EVALUATE(...).SetFocus() encadeado.
7898:                     loc_oCampo = EVALUATE("loc_oPg." + loc_cCampo)
7899: 
7900:                     IF VARTYPE(loc_oCampo) = "O" AND loc_oCampo.Enabled
7901:                         loc_oCampo.SetFocus()
7902:                     ENDIF
7903:                 ENDIF
7904:             ENDIF
7905: 
7906:         CATCH TO loException
7907:             *-- Falhar ao focar NAO pode esconder a mensagem de validacao
7908:             MostrarErro("Erro ao posicionar o foco:" + CHR(13) + ;
7909:                 loException.Message, "FormProduto.FocarCampoValidacao")
7910:         ENDTRY
7911:     ENDPROC
7912: 
7913:     *===========================================================================
7914:     * ExecutarBuscaPorExemplo - Transcricao da PROCEDURE msv_procurar do legado
7915:     *
7916:     *   pGru = Padr(cntFiltros.getCgru.Value, 3)
7917:     *   pPro = Padr(pgDados.getCpro.Value, 14)     pDes = Padr(getDpro.Value, 40)
7918:     *   pD2s = Padr(getDpro2s.Value, 40)           pRff = Padr(getRefs.Value, 15)
7919:     *   pFor = Padr(getIfor.Value, 10)             pBar = getCbar.Value
7920:     *   pCnj = getconjunto.Value
7921:     *   lcBus = Iif(Empty(pGru), [], [CGrus = ?pGru And ])
7922:     *
7923:     *   Do Case  (a ORDEM eh regra de negocio - o primeiro campo preenchido
7924:     *             vence e os demais sao ignorados)
7925:     *     Case Not Empty(pPro) -> CPros  = pPro
7926:     *     Case Not Empty(pDes) -> DPros  = pDes   (fallback Like %pDes%)
7927:     *     Case Not Empty(pD2s) -> DPro2s = pD2s   (fallback Like %pD2s%)
7928:     *     Case Not Empty(pFor) -> Ifors  = pFor
7929:     *     Case Not Empty(pRff) -> Reffs  = pRff   (fallback Like %pRff%)
7930:     *     Case Not Empty(pCnj) -> Conjunts = pCnj
7931:     *     Case Not Empty(pBar) -> CBars  = pBar
7932:     *   EndCase
7933:     *
7934:     * O lcBus (filtro de grupo) entra SO nos casos DPros e DPro2s, como no
7935:     * legado - nao generalizar para os outros.
7936:     * PUBLIC: chamado por BtnSalvarClick (metodo publico).
7937:     *===========================================================================
7938:     PROCEDURE ExecutarBuscaPorExemplo()
7939:         LOCAL loc_oPg, loc_oFiltros, loc_cTabela, loc_cBus, loc_cFiltro
7940:         LOCAL loc_cPro, loc_cDes, loc_cD2s, loc_cRff, loc_cFor, loc_cBar, loc_cCnj
7941:         LOCAL loc_cGru, loc_lTemFiltro, loc_lLike, loc_cMsgParcial, loException
7942: 
7943:         TRY
7944:             loc_oPg      = THIS.ObterPaginaDados()
7945:             loc_oFiltros = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
7946: 
7947:             loc_cGru = PADR(ALLTRIM(loc_oFiltros.txt_4c_Cgru.Value), 3)
7948:             loc_cPro = PADR(ALLTRIM(loc_oPg.txt_4c_Cpro.Value), 14)
7949:             loc_cDes = PADR(ALLTRIM(loc_oPg.txt_4c_Dpro.Value), 40)
7950:             loc_cD2s = PADR(ALLTRIM(loc_oPg.txt_4c_DPro2s.Value), 40)
7951:             loc_cRff = PADR(ALLTRIM(loc_oPg.txt_4c_Refs.Value), 15)
7952:             loc_cFor = PADR(ALLTRIM(loc_oPg.txt_4c_Ifor.Value), 10)
7953:             loc_cBar = ALLTRIM(loc_oPg.txt_4c_Cbar.Value)
7954:             loc_cCnj = ALLTRIM(loc_oPg.txt_4c_Conjunto.Value)
7955: 
7956:             *-- ThisForm.Tipo2 escolhe a tabela (SigCdPrc x SigCdPro)
7957:             loc_cTabela = IIF(THIS.this_lTipo2, "SigCdPrc", "SigCdPro")
7958: 
7959:             *-- lcBus: so usado nos casos DPros / DPro2s
7960:             loc_cBus = IIF(EMPTY(ALLTRIM(loc_cGru)), "", ;
7961:                 "cgrus = " + EscaparSQL(loc_cGru) + " AND ")
7962: 
7963:             loc_cFiltro    = ""
7964:             loc_cMsgParcial = ""
7965:             loc_lTemFiltro = .T.
7966:             loc_lLike      = .F.
7967: 
7968:             DO CASE
7969:                 CASE !EMPTY(ALLTRIM(loc_cPro))
7970:                     loc_cFiltro = "cpros = " + EscaparSQL(ALLTRIM(loc_cPro))
7971: 
7972:                 CASE !EMPTY(ALLTRIM(loc_cDes))
7973:                     loc_cFiltro     = loc_cBus + "dpros = " + EscaparSQL(ALLTRIM(loc_cDes))
7974:                     loc_lLike       = .T.
7975:                     loc_cMsgParcial = "N" + CHR(227) + "o Foi Encontrada Uma Descri" + ;
7976:                         CHR(231) + CHR(227) + "o Igual a Digitada!!!" + CHR(13) + ;
7977:                         "Deseja Procurar Parte da Descri" + CHR(231) + CHR(227) + "o?"
7978: 

*-- Linhas 8004 a 8194:
8004:             ENDCASE
8005: 
8006:             IF !loc_lTemFiltro
8007:                 MsgAviso("Informe ao menos um campo de procura: Produto, " + ;
8008:                     "Descri" + CHR(231) + CHR(227) + "o, Descritivo," + CHR(13) + ;
8009:                     "Ref. Fornecedor, Fornecedor, Barra ou Cod. Pai.", "Procurar")
8010:             ELSE
8011:                 THIS.AplicarResultadoBusca(loc_cTabela, loc_cFiltro, loc_lLike, ;
8012:                     loc_cMsgParcial, loc_cBus, loc_cDes, loc_cD2s, loc_cRff)
8013:             ENDIF
8014: 
8015:         CATCH TO loException
8016:             MostrarErro("Erro ao procurar o produto:" + CHR(13) + ;
8017:                 loException.Message + CHR(13) + ;
8018:                 "Linha: " + TRANSFORM(loException.LineNo), ;
8019:                 "FormProduto.ExecutarBuscaPorExemplo")
8020:         ENDTRY
8021:     ENDPROC
8022: 
8023:     *===========================================================================
8024:     * AplicarResultadoBusca - Executa a consulta da busca por exemplo, aplica o
8025:     * fallback "parte da descricao" do legado e devolve o resultado para a
8026:     * grade da Lista.
8027:     *
8028:     * O legado insere os achados em crProcurar e habilita a navegacao; aqui o
8029:     * equivalente natural eh recarregar cursor_4c_Dados (a propria grade da
8030:     * pagina Lista) e voltar para ela - o usuario ve exatamente os produtos
8031:     * que a procura encontrou.
8032:     *===========================================================================
8033:     PROTECTED PROCEDURE AplicarResultadoBusca(par_cTabela, par_cFiltro, ;
8034:             par_lLike, par_cMsgParcial, par_cBus, par_cDes, par_cD2s, par_cRff)
8035:         LOCAL loc_cSQL, loc_nResultado, loc_nAchados, loc_cFiltro, loException
8036: 
8037:         loc_cFiltro  = par_cFiltro
8038:         loc_nAchados = 0
8039: 
8040:         TRY
8041:             IF USED("cursor_4c_Dados")
8042:                 USE IN cursor_4c_Dados
8043:             ENDIF
8044: 
8045:             loc_cSQL = "SELECT " + THIS.ObterColunasBusca() + " FROM " + par_cTabela + ;
8046:                 " WHERE " + loc_cFiltro + " ORDER BY cpros"
8047: 
8048:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
8049: 
8050:             IF loc_nResultado < 0
8051:                 MsgErro("Erro ao procurar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
8052:             ELSE
8053:                 loc_nAchados = RECCOUNT("cursor_4c_Dados")
8054: 
8055:                 *-- Fallback do legado: sem resultado exato, pergunta se quer
8056:                 *-- procurar PARTE do texto (Rtrim(<campo>) Like '%valor%')
8057:                 IF loc_nAchados < 1 AND par_lLike
8058:                     IF MsgConfirma(par_cMsgParcial, "Procura")
8059:                         loc_cFiltro = THIS.MontarFiltroParcial(par_cFiltro, par_cBus, ;
8060:                             par_cDes, par_cD2s, par_cRff)
8061: 
8062:                         IF USED("cursor_4c_Dados")
8063:                             USE IN cursor_4c_Dados
8064:                         ENDIF
8065: 
8066:                         loc_cSQL = "SELECT " + THIS.ObterColunasBusca() + ;
8067:                             " FROM " + par_cTabela + " WHERE " + loc_cFiltro + ;
8068:                             " ORDER BY cpros"
8069: 
8070:                         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
8071: 
8072:                         IF loc_nResultado < 0
8073:                             MsgErro("Erro ao procurar produtos:" + CHR(13) + ;
8074:                                 CapturarErroSQL(), "Erro SQL")
8075:                         ELSE
8076:                             loc_nAchados = RECCOUNT("cursor_4c_Dados")
8077:                         ENDIF
8078:                     ENDIF
8079:                 ENDIF
8080: 
8081:                 IF loc_nAchados < 1
8082:                     MsgAviso("Nenhum produto encontrado com os dados informados.", "Procurar")
8083:                 ELSE
8084:                     GO TOP IN cursor_4c_Dados
8085: 
8086:                     *-- Volta para a Lista mostrando o resultado. A grade eh
8087:                     *-- religada aqui porque AlternarPagina(1) recarregaria o
8088:                     *-- cursor pelos filtros da Lista e descartaria a procura.
8089:                     THIS.this_cModoAtual = "LISTA"
8090:                     THIS.LimparCampos()
8091:                     THIS.pgf_4c_Paginas.ActivePage = 1
8092:                     THIS.VincularGradeLista()
8093:                     THIS.AjustarBotoesPorModo()
8094:                 ENDIF
8095:             ENDIF
8096: 
8097:         CATCH TO loException
8098:             MostrarErro("Erro ao aplicar o resultado da procura:" + CHR(13) + ;
8099:                 loException.Message + CHR(13) + ;
8100:                 "Linha: " + TRANSFORM(loException.LineNo), ;
8101:                 "FormProduto.AplicarResultadoBusca")
8102:         ENDTRY
8103:     ENDPROC
8104: 
8105:     *===========================================================================
8106:     * MontarFiltroParcial - Troca a igualdade pelo Like do legado
8107:     *   Rtrim(DPros)  Like '%<valor>%'
8108:     *   Rtrim(DPro2s) Like '%<valor>%'
8109:     *   Rtrim(Reffs)  Like '%<valor>%'
8110:     * O legado mantem o filtro de grupo (lcBus) em DPros/DPro2s e NAO o aplica
8111:     * em Reffs - reproduzido igual.
8112:     *===========================================================================
8113:     PROTECTED PROCEDURE MontarFiltroParcial(par_cFiltroOriginal, par_cBus, ;
8114:             par_cDes, par_cD2s, par_cRff)
8115:         LOCAL loc_cFiltro
8116:         loc_cFiltro = par_cFiltroOriginal
8117: 
8118:         DO CASE
8119:             CASE "dpros = " $ LOWER(par_cFiltroOriginal)
8120:                 loc_cFiltro = par_cBus + "RTRIM(dpros) LIKE " + ;
8121:                     EscaparSQL("%" + ALLTRIM(par_cDes) + "%")
8122: 
8123:             CASE "dpro2s = " $ LOWER(par_cFiltroOriginal)
8124:                 loc_cFiltro = par_cBus + "RTRIM(dpro2s) LIKE " + ;
8125:                     EscaparSQL("%" + ALLTRIM(par_cD2s) + "%")
8126: 
8127:             CASE "reffs = " $ LOWER(par_cFiltroOriginal)
8128:                 loc_cFiltro = "RTRIM(reffs) LIKE " + ;
8129:                     EscaparSQL("%" + ALLTRIM(par_cRff) + "%")
8130:         ENDCASE
8131: 
8132:         RETURN loc_cFiltro
8133:     ENDPROC
8134: 
8135:     *===========================================================================
8136:     * ObterColunasBusca - Colunas do SELECT da procura
8137:     * TEM de coincidir com as colunas que a grade da Lista usa em
8138:     * VincularGradeLista (regra Grid-SQL: ControlSource sem coluna no SELECT
8139:     * estoura "Variable not found").
8140:     *===========================================================================
8141:     PROTECTED PROCEDURE ObterColunasBusca()
8142:         RETURN "cpros, dpros, dpro2s, cgrus, sgrus, reffs, colecoes," + ;
8143:             " impetiqs, situas, encoms, cbars, cproeqs, compos, codcors," + ;
8144:             " usuaalts, dtalts"
8145:     ENDPROC
8146: 
8147:     *===========================================================================
8148:     * VincularGradeLista - Religa a grade da Lista ao cursor_4c_Dados
8149:     *
8150:     * Extraido de CarregarLista para poder ser reutilizado pela procura, que
8151:     * popula o MESMO cursor por outro caminho. Regra #41 / Problema 48:
8152:     * RecordSource PRIMEIRO, depois ControlSource, Width e Header.
8153:     *===========================================================================
8154:     PROTECTED PROCEDURE VincularGradeLista()
8155:         LOCAL loc_oGrid, loException
8156: 
8157:         TRY
8158:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
8159: 
8160:             loc_oGrid.RecordSource = ""
8161:             loc_oGrid.ColumnCount = 6
8162:             loc_oGrid.RecordSource = "cursor_4c_Dados"
8163: 
8164:             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
8165:             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
8166:             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
8167:             loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
8168:             loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
8169:             loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.usuaalts"
8170:             loc_oGrid.Column7.chk_4c_Inativo.ControlSource = "cursor_4c_Dados.situas = 2"
8171: 
8172:             loc_oGrid.Column1.Width = 90
8173:             loc_oGrid.Column2.Width = 380
8174:             loc_oGrid.Column3.Width = 50
8175:             loc_oGrid.Column4.Width = 70
8176:             loc_oGrid.Column5.Width = 140
8177:             loc_oGrid.Column6.Width = 100
8178:             loc_oGrid.Column7.Width = 30
8179: 
8180:             loc_oGrid.Column1.Header1.Caption = "Produto"
8181:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
8182:             loc_oGrid.Column3.Header1.Caption = "Grupo"
8183:             loc_oGrid.Column4.Header1.Caption = "Subgrp."
8184:             loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
8185:             loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
8186:             loc_oGrid.Column7.Header1.Caption = "I"
8187: 
8188:             THIS.FormatarGridLista(loc_oGrid)
8189:             THIS.AtualizarContadorProdutos()
8190: 
8191:             loc_oGrid.Refresh()
8192: 
8193:         CATCH TO loException
8194:             MostrarErro("Erro ao vincular a grade:" + CHR(13) + ;

*-- Linhas 8201 a 8398:
8201:     * Legado (getConjunto.Valid): procura o conjunto na lista de conjuntos ja
8202:     * cadastrados e, no fim, normaliza para 6 digitos com Padl(...,6,'0').
8203:     *===========================================================================
8204:     PROCEDURE ValidarConjuntoDados(par_nKeyCode, par_nShiftAltCtrl)
8205:         LOCAL loc_oPg, loc_cValor
8206:         loc_oPg    = THIS.ObterPaginaDados()
8207:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conjunto.Value)
8208: 
8209:         IF EMPTY(loc_cValor)
8210:             RETURN
8211:         ENDIF
8212: 
8213:         *-- Padl(this.Value, 6, '0') do legado
8214:         loc_oPg.txt_4c_Conjunto.Value = PADL(loc_cValor, 6, "0")
8215:     ENDPROC
8216: 
8217:     *===========================================================================
8218:     * BtnGerarConjuntoClick - cmdConjunto: gera um Cod. Pai novo
8219:     * Legado: lcConjunto = Transform(fGerUniqueKey([CONJUNTO]), [@L 999999]),
8220:     * so quando o campo esta vazio. fGerUniqueKey nao foi portada; aqui o
8221:     * proximo numero sai do MAX(Conjunts) ja gravado em SigCdPro, que produz
8222:     * o mesmo efeito (sequencial de 6 digitos) sem inventar tabela nova.
8223:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
8224:     *===========================================================================
8225:     PROCEDURE BtnGerarConjuntoClick()
8226:         LOCAL loc_oPg, loc_cSQL, loc_nResultado, loc_nProximo, loException
8227:         loc_oPg = THIS.ObterPaginaDados()
8228: 
8229:         *-- "If Empty(crSigCdPro.Conjunts)" do legado
8230:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Conjunto.Value))
8231:             RETURN
8232:         ENDIF
8233: 
8234:         TRY
8235:             IF USED("cursor_4c_MaxConj")
8236:                 USE IN cursor_4c_MaxConj
8237:             ENDIF
8238: 
8239:             loc_cSQL = "SELECT MAX(CAST(conjunts AS INT)) AS ultimo FROM SigCdPro" + ;
8240:                 " WHERE conjunts <> '' AND ISNUMERIC(conjunts) = 1"
8241: 
8242:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxConj")
8243: 
8244:             IF loc_nResultado < 0
8245:                 MsgErro("Erro ao gerar o Cod. Pai:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
8246:             ELSE
8247:                 loc_nProximo = NVL(cursor_4c_MaxConj.ultimo, 0) + 1
8248:                 loc_oPg.txt_4c_Conjunto.Value = PADL(ALLTRIM(STR(loc_nProximo, 10, 0)), 6, "0")
8249:             ENDIF
8250: 
8251:             IF USED("cursor_4c_MaxConj")
8252:                 USE IN cursor_4c_MaxConj
8253:             ENDIF
8254: 
8255:         CATCH TO loException
8256:             MostrarErro("Erro ao gerar o Cod. Pai:" + CHR(13) + ;
8257:                 loException.Message, "FormProduto.BtnGerarConjuntoClick")
8258:         ENDTRY
8259:     ENDPROC
8260: 
8261:     *===========================================================================
8262:     * BtnLocalizarConjuntoClick - cmdLocConj: localiza um Cod. Pai existente
8263:     * Legado: Do Form SigOpBus ... To lcProduto + Padl(lcProduto, 6, '0').
8264:     * SigOpBus nao existe no sistema novo; o equivalente eh o picker padrao
8265:     * sobre os conjuntos ja gravados em SigCdPro.
8266:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
8267:     *===========================================================================
8268:     PROCEDURE BtnLocalizarConjuntoClick()
8269:         LOCAL loc_oPg, loc_oBusca, loc_cValor, loException
8270:         loc_oPg    = THIS.ObterPaginaDados()
8271:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conjunto.Value)
8272: 
8273:         TRY
8274:             *-- 1o argumento = HANDLE da conexao (regra #36)
8275:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
8276:                 "SigCdPro", "cursor_4c_BuscaConj", "conjunts", loc_cValor, ;
8277:                 "Cod. Pai", .T., .T., "conjunts <> ''")
8278: 
8279:             IF VARTYPE(loc_oBusca) = "O"
8280:                 *-- Regra #37: Show SO quando o Init nao resolveu sozinho
8281:                 IF !loc_oBusca.this_lAchouRegistro
8282:                     loc_oBusca.mAddColuna("conjunts", "", "Cod. Pai")
8283:                     loc_oBusca.mAddColuna("cpros", "", "Produto")
8284:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8285:                     loc_oBusca.Show()
8286:                 ENDIF
8287: 
8288:                 *-- Regra #37: atribui SO sob a guarda de this_lSelecionou,
8289:                 *-- senao o campo seria ZERADO quando o usuario desiste.
8290:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConj")
8291:                     SELECT cursor_4c_BuscaConj
8292:                     loc_oPg.txt_4c_Conjunto.Value = ;
8293:                         PADL(ALLTRIM(NVL(cursor_4c_BuscaConj.conjunts, "")), 6, "0")
8294:                 ENDIF
8295: 
8296:                 loc_oBusca.Release()
8297:             ENDIF
8298: 
8299:             IF USED("cursor_4c_BuscaConj")
8300:                 USE IN cursor_4c_BuscaConj
8301:             ENDIF
8302: 
8303:         CATCH TO loException
8304:             MostrarErro("Erro ao localizar o Cod. Pai:" + CHR(13) + ;
8305:                 loException.Message, "FormProduto.BtnLocalizarConjuntoClick")
8306:         ENDTRY
8307:     ENDPROC
8308: 
8309:     *===========================================================================
8310:     * FormatarGridLista - Formata visual de um grid (FontName / FontSize)
8311:     *===========================================================================
8312:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
8313:         LOCAL loException
8314: 
8315:         TRY
8316:             WITH par_oGrid
8317:                 .FontName = "Tahoma"
8318:                 .FontSize = 8
8319:             ENDWITH
8320:         CATCH TO loException
8321:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
8322:                 "FormProduto.FormatarGridLista")
8323:         ENDTRY
8324:     ENDPROC
8325: 
8326:     *===========================================================================
8327:     * TornarControlesVisiveis - Percorre o container tornando os filhos visiveis
8328:     * AddObject cria os controles com Visible = .F.
8329:     *
8330:     * Os paineis flutuantes do legado (cntMensagem, CntAcabado, CntQtMin e a
8331:     * botoeira lateral Botoes) nascem ocultos e so aparecem por acao do usuario:
8332:     * eles sao pulados aqui, mas a recursao continua nos filhos deles para que os
8333:     * controles internos ja fiquem visiveis quando o painel for exibido.
8334:     *===========================================================================
8335:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
8336:         LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cNome
8337: 
8338:         FOR loc_nI = 1 TO par_oContainer.ControlCount
8339:             loc_oObjeto = par_oContainer.Controls(loc_nI)
8340: 
8341:             IF VARTYPE(loc_oObjeto) = "O"
8342:                 loc_cNome = UPPER(loc_oObjeto.Name)
8343: 
8344:                 IF INLIST(loc_cNome, "CNT_4C_MENSAGEM", "CNT_4C_ACABADO", ;
8345:                         "CNT_4C_QTMIN", "CNT_4C_BOTOESLATERAL", ;
8346:                         "GRD_4C_RELOGIOS")
8347:                     *-- GRD_4C_RELOGIOS: grade alternativa (produto tipo
8348:                     *-- "relogios") sobreposta ao grd_4c_Compo no mesmo Top/
8349:                     *-- Left - fica oculta por padrao (regra #28/#30 do
8350:                     *-- CLAUDE.md: nunca duas grades sobrepostas visiveis).
8351:                     THIS.TornarControlesVisiveis(loc_oObjeto)
8352:                 ELSE
8353:                     IF PEMSTATUS(loc_oObjeto, "Visible", 5)
8354:                         loc_oObjeto.Visible = .T.
8355:                     ENDIF
8356: 
8357:                     IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
8358:                         FOR loc_nP = 1 TO loc_oObjeto.PageCount
8359:                             THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
8360:                         ENDFOR
8361:                     ENDIF
8362: 
8363:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
8364:                         THIS.TornarControlesVisiveis(loc_oObjeto)
8365:                     ENDIF
8366:                 ENDIF
8367:             ENDIF
8368:         ENDFOR
8369:     ENDPROC
8370: 
8371:     *===========================================================================
8372:     * Destroy - Libera o Business Object e fecha os cursores do formulario
8373:     *===========================================================================
8374:     PROCEDURE Destroy()
8375:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
8376:             THIS.this_oBusinessObject = .NULL.
8377:         ENDIF
8378: 
8379:         IF USED("cursor_4c_Dados")
8380:             USE IN cursor_4c_Dados
8381:         ENDIF
8382: 
8383:         IF USED("cursor_4c_DescAux")
8384:             USE IN cursor_4c_DescAux
8385:         ENDIF
8386: 
8387:         IF USED("cursor_4c_BuscaConj")
8388:             USE IN cursor_4c_BuscaConj
8389:         ENDIF
8390: 
8391:         IF USED("cursor_4c_MaxConj")
8392:             USE IN cursor_4c_MaxConj
8393:         ENDIF
8394: 
8395:         DODEFAULT()
8396:     ENDPROC
8397: 
8398: ENDDEFINE

