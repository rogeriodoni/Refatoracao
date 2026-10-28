# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (35)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [METODO-INEXISTENTE] Metodo 'THIS.ExecutarProcessamento()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarFiltrosConsulta()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Saldo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Historico' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Estoque' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Conserto' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Parcela' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_ProdFor' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Resumo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_OperaProd' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-HEADER] Header Caption 'Total Vendas' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: M., Saldo, Data, Valor, O, Vencimento, Emp, Notas, Pg, Qtds, Ref.Fornec, Moe, Vecto, Tipo, Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Valor Total' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: M., Saldo, Data, Valor, O, Vencimento, Emp, Notas, Pg, Qtds, Ref.Fornec, Moe, Vecto, Tipo, Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Valor Total' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: M., Saldo, Data, Valor, O, Vencimento, Emp, Notas, Pg, Qtds, Ref.Fornec, Moe, Vecto, Tipo, Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Opt_Analise' (parent: SIGOPCGC.fld_principal.pag_consulta): Top original=309 vs migrado 'obj_4c_Opt_Analise' Top=5 (diff=304px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Analise' (parent: SIGOPCGC.fld_principal.pag_consulta): Left original=214 vs migrado 'obj_4c_Opt_Analise' Left=7 (diff=207px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Origem' (parent: SIGOPCGC.fld_principal.pag_consulta): Top original=239 vs migrado 'cnt_4c_Origem' Top=2 (diff=237px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Origem' (parent: SIGOPCGC.fld_principal.pag_consulta): Left original=92 vs migrado 'cnt_4c_Origem' Left=6 (diff=86px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'MsgFoto' (parent: SIGOPCGC.fld_principal.pag_resultado.Cadastro.Dados): Left original=518 vs migrado 'lbl_4c_MsgFotoProduto' Left=260 (diff=258px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPCGC.fld_principal.pag_resultado.Result.Saldo): Top original=254 vs migrado 'lbl_4c_Label1' Top=309 (diff=55px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPCGC.fld_principal.pag_resultado.Result.Saldo): Left original=192 vs migrado 'lbl_4c_Label1' Left=296 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPCGC.fld_principal.pag_resultado.Result.Movimenta): Top original=30 vs migrado 'lbl_4c_Label1' Top=309 (diff=279px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPCGC.fld_principal.pag_resultado.Result.Movimenta): Left original=3 vs migrado 'lbl_4c_Label1' Left=296 (diff=293px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Imprimir' (parent: SIGOPCGC.fld_principal.pag_resultado.Result.Movimenta): Top original=255 vs migrado 'cmd_4c_ImprimirOpc' Top=8 (diff=247px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Imprimir' (parent: SIGOPCGC.fld_principal.pag_resultado.Result.Movimenta): Left original=342 vs migrado 'cmd_4c_ImprimirOpc' Left=204 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptSituas' (parent: SIGOPCGC.fld_principal.pag_resultado.Result.Movimenta): Left original=434 vs migrado 'obj_4c_OptSituas' Left=9 (diff=425px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPCGC.fld_principal.pag_resultado.Result.Pendencias): Top original=3 vs migrado 'lbl_4c_Label1' Top=309 (diff=306px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPCGC.fld_principal.pag_resultado.Result.Pendencias): Left original=20 vs migrado 'lbl_4c_Label1' Left=296 (diff=276px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3820 linhas total):

*-- Linhas 20 a 292:
20: * As duas paginas do legado ja tem a faixa cinza (cntSombra) - replicada
21: * aqui como cnt_4c_Cabecalho nas duas (regra CLAUDE.md #11).
22: *
23: * FASE 3/8: Estrutura base do Form - DEFINE CLASS, Init/InicializarForm,
24: * ConfigurarPageFrame com as 2 paginas (Consulta/Resultado) e os
25: * containers principais (cnt_4c_Cabecalho completo nas duas paginas).
26: *
27: * FASE 4/8: Botoes de navegacao (este form OPERACIONAL de CONSULTA nao
28: * tem grid nem CRUD na Page1 - o legado so tem o CommandGroup
29: * grp_operacao com 3 botoes Cadastro/Movimento/Sair). Adicionados:
30: * cmg_4c_Operacao (Page1, 3 botoes) + AlternarPagina(); na Page2,
31: * cmg_4c_Operacao (botao Voltar) + cmg_4c_MudaFor/cmg_4c_MudaMov. A
32: * validacao e a consulta SQL dos botoes Cadastro/Movimento dependem dos
33: * campos de filtro (Fases 5-6) e da logica de negocio (Fases 7-8).
34: * Campos de dados para as Fases 5-6, BINDEVENTs/logica de negocio
35: * restante para as Fases 7-8.
36: *
37: * FASE 5/8: Primeiros 50% dos campos de Cadastro.Dados do legado
38: * (Codigo/Nome/Endereco/Bairro - TextBoxes + Labels - e os Labels de
39: * Cep/Cidade/Estado/Telefone 1, cujos TextBoxes entram na Fase 6/8
40: * junto com Telefone 2/Fax/CGC/IE e a foto do fornecedor).
41: * Container cnt_4c_Cadastro (legado: PageFrame "Cadastro", pagina
42: * unica "Dados", Top=155/Left=59/Width=701/Height=421 em
43: * pag_resultado) replicado como Container simples com Top compensado
44: * (+29 do PageFrame.Top=-29). Todos os TextBoxes desta aba sao
45: * somente-leitura (legado: Get_codfor/Get_nome/Get_end/Get_bairro/...
46: * tem Procedure When / Return(.F.) - nunca recebem foco, so exibem o
47: * resultado da consulta). Populados pelo BOParaForm nas Fases 7-8.
48: *==============================================================================
49: 
50: DEFINE CLASS Formsigopcgc AS FormBase
51: 
52:     *-- Dimensoes e propriedades visuais (padrao canonico de form OPERACIONAL)
53:     Height      = 600
54:     Width       = 1000
55:     BorderStyle = 2
56:     AutoCenter  = .T.
57:     ShowTips    = .T.
58:     Caption     = "Consulta Gen" + CHR(233) + "rica de Compras"
59:     ControlBox  = .F.
60:     MaxButton   = .F.
61:     MinButton   = .F.
62:     TitleBar    = 0
63:     WindowState = 0
64:     ShowWindow  = 1
65:     WindowType  = 1
66:     DataSession = 2
67:     Themes      = .F.
68: 
69:     *-- Business Object
70:     this_oBusinessObject = .NULL.
71: 
72:     *==========================================================================
73:     * Init(par_cGrupo, par_cConta) - o legado recebe os mesmos dois
74:     * parametros ("LParameters _Grupo, _Conta"). Quando os dois vem
75:     * preenchidos (form aberto por OUTRA tela, nao pelo menu), o legado liga
76:     * ThisForm.Automatico, roda a consulta NA HORA e abre direto na Pagina
77:     * Resultado no bloco de Movimentacao - e nesse modo o botao Voltar fecha
78:     * a tela em vez de voltar para os filtros.
79:     *==========================================================================
80:     PROCEDURE Init(par_cGrupo, par_cConta)
81:         LOCAL loc_lSucesso, loc_cGrupo, loc_cConta
82: 
83:         loc_lSucesso = DODEFAULT()
84: 
85:         IF loc_lSucesso
86:             loc_cGrupo = IIF(VARTYPE(par_cGrupo) = "C", ALLTRIM(par_cGrupo), "")
87:             loc_cConta = IIF(VARTYPE(par_cConta) = "C", ALLTRIM(par_cConta), "")
88: 
89:             IF !EMPTY(loc_cGrupo + loc_cConta) AND ;
90:                     PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
91:                 THIS.AbrirModoAutomatico(loc_cGrupo, loc_cConta)
92:             ENDIF
93:         ENDIF
94: 
95:         RETURN loc_lSucesso
96:     ENDPROC
97: 
98:     *==========================================================================
99:     * AbrirModoAutomatico - bloco final do Init do legado
100:     * ("If Type('_Grupo') = 'C' And ... ThisForm.Automatico = .T."): preenche
101:     * Grupo/Conta, consulta na hora e abre a Pagina Resultado no bloco de
102:     * Movimentacao, sem o botao de volta para os filtros.
103:     *==========================================================================
104:     PROTECTED PROCEDURE AbrirModoAutomatico(par_cGrupo, par_cConta)
105:         THIS.this_oBusinessObject.this_lAutomatico = .T.
106: 
107:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
108:             .txt_4c_Grupo.Value = par_cGrupo
109:             .txt_4c_Conta.Value = par_cConta
110:         ENDWITH
111: 
112:         THIS.this_oBusinessObject.this_lMensagem = .F.
113: 
114:         IF THIS.ExecutarProcessamento()
115:             THIS.MostrarBlocoMovimento()
116:             THIS.ConfigurarGradesSaldo()
117: 
118:             *-- no modo Automatico nao existe caminho de volta para os
119:             *-- filtros: so o botao de ida para o cadastro fica disponivel
120:             THIS.pgf_4c_Paginas.Page2.cmg_4c_MudaMov.Visible = .F.
121:             THIS.pgf_4c_Paginas.Page2.cmg_4c_MudaMov.Enabled = .F.
122: 
123:             THIS.AlternarPagina(2)
124:         ENDIF
125:     ENDPROC
126: 
127:     *==========================================================================
128:     * ValidarParametros - guarda de conexao do Init legado ("Impossivel
129:     * Efetuar Conexao Com o Servidor de Banco de Dados..."), extraida de
130:     * InicializarForm com bypass para os dois modos sem usuario.
131:     *
132:     * PUBLIC de proposito: o harness da etapa 06b chama metodos do form de
133:     * FORA da classe, e metodo PROTECTED falha em runtime mesmo com PEMSTATUS
134:     * devolvendo .T.
135:     *==========================================================================
136:     PROCEDURE ValidarParametros()
137:         LOCAL loc_lValido
138:         loc_lValido = .T.
139: 
140:         IF TYPE("gb_4c_ModoTeste") = "L"
141:             IF gb_4c_ModoTeste
142:                 RETURN .T.
143:             ENDIF
144:         ENDIF
145: 
146:         IF TYPE("gb_4c_ValidandoUI") = "L"
147:             IF gb_4c_ValidandoUI
148:                 RETURN .T.
149:             ENDIF
150:         ENDIF
151: 
152:         DO CASE
153:             CASE TYPE("gnConnHandle") != "N"
154:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
155:                         "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
156:                 loc_lValido = .F.
157:             CASE gnConnHandle <= 0
158:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
159:                         "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
160:                 loc_lValido = .F.
161:         ENDCASE
162: 
163:         RETURN loc_lValido
164:     ENDPROC
165: 
166:     *==========================================================================
167:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
168:     *==========================================================================
169:     PROTECTED PROCEDURE InicializarForm()
170:         LOCAL loc_lSucesso, loc_oErro
171:         loc_lSucesso = .F.
172: 
173:         *-- A guarda de conexao sai do corpo do metodo (ValidarParametros) e o
174:         *-- RETURN fica FORA do TRY: com a guarda aqui dentro, o harness de
175:         *-- teste automatizado - que define gnConnHandle = 0 de proposito,
176:         *-- porque SQLSTRINGCONNECT bloqueia 300s quando o servidor esta
177:         *-- inacessivel - reprovaria SEMPRE a instanciacao do form.
178:         IF !THIS.ValidarParametros()
179:             RETURN .F.
180:         ENDIF
181: 
182:         TRY
183:             THIS.this_oBusinessObject = CREATEOBJECT("sigopcgcBO")
184: 
185:             THIS.ConfigurarPageFrame()
186:             THIS.ConfigurarPaginaLista()
187:             THIS.ConfigurarPaginaDados()
188:             THIS.TornarControlesVisiveis(THIS)
189: 
190:             *-- Init do legado: o filtro Grupo nasce com o grupo padrao de
191:             *-- fornecedores (CrSigCdPam.grpadfors) e os demais campos de
192:             *-- Origem em branco.
193:             WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
194:                 .txt_4c_Grupo.Value  = THIS.this_oBusinessObject.ObterGrupoPadrao()
195:                 .txt_4c_Conta.Value  = ""
196:                 .txt_4c_Cpf.Value    = ""
197:                 .txt_4c_Dconta.Value = ""
198:             ENDWITH
199: 
200:             *-- estado inicial da Pagina Resultado: bloco de cadastro visivel,
201:             *-- resultado oculto (igual ao legado)
202:             THIS.MostrarBlocoCadastro()
203:             THIS.AplicarPermissoes()
204: 
205:             THIS.pgf_4c_Paginas.Visible = .T.
206:             THIS.pgf_4c_Paginas.ActivePage = 1
207:             loc_lSucesso = .T.
208:         CATCH TO loc_oErro
209:             MsgErro(loc_oErro.Message + CHR(13) + ;
210:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
211:                     "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
212:         ENDTRY
213: 
214:         RETURN loc_lSucesso
215:     ENDPROC
216: 
217:     *==========================================================================
218:     * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas
219:     * (Consulta/Resultado, espelhando pag_consulta/pag_resultado do legado)
220:     *==========================================================================
221:     PROTECTED PROCEDURE ConfigurarPageFrame()
222:         LOCAL loc_oPgf
223: 
224:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
225:         loc_oPgf = THIS.pgf_4c_Paginas
226: 
227:         loc_oPgf.PageCount = 2
228:         loc_oPgf.Top       = -29
229:         loc_oPgf.Left      = 0
230:         loc_oPgf.Width     = THIS.Width
231:         loc_oPgf.Height    = THIS.Height + 29
232:         loc_oPgf.TabIndex  = 1
233:         loc_oPgf.Tabs      = .F.
234: 
235:         loc_oPgf.Page1.Caption = "Consulta"
236:         loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
237: 
238:         loc_oPgf.Page2.Caption = "Resultado"
239:         loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
240: 
241:         loc_oPgf.Visible    = .T.
242:         loc_oPgf.ActivePage = 1
243:     ENDPROC
244: 
245:     *==========================================================================
246:     * ConfigurarPaginaLista - Estrutura da Page1 (Consulta)
247:     * Fase 3/8: so a faixa do cabecalho + container vazio para o
248:     * CommandGroup grp_operacao (Cadastro/Movimento/Sair do legado, Fase 4).
249:     * Campos de filtro (Grupo/Conta/CPF, periodo, moeda, empresa) vem nas
250:     * Fases 5-6.
251:     *==========================================================================
252:     PROTECTED PROCEDURE ConfigurarPaginaLista()
253:         LOCAL loc_oPag, loc_oCab
254: 
255:         loc_oPag = THIS.pgf_4c_Paginas.Page1
256: 
257:         *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra #11/#39):
258:         *-- containers de botao ficam em Top=29..33 (dentro da faixa) e tem
259:         *-- de ser criados DEPOIS para desenhar por cima.
260:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
261:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
262:         WITH loc_oCab
263:             .Top           = 29
264:             .Left          = 0
265:             .Width         = THIS.Width
266:             .Height        = 80
267:             .BorderWidth   = 0
268:             .SpecialEffect = 0
269:             .BackColor     = RGB(100, 100, 100)
270: 
271:             .AddObject("lbl_4c_Sombra", "Label")
272:             WITH .lbl_4c_Sombra
273:                 .Top       = 15
274:                 .Left      = 10
275:                 .Width     = THIS.Width
276:                 .Height    = 40
277:                 .FontName  = "Tahoma"
278:                 .FontSize  = 16
279:                 .FontBold  = .T.
280:                 .WordWrap  = .T.
281:                 .Alignment = 0
282:                 .BackStyle = 0
283:                 .ForeColor = RGB(0, 0, 0)
284:                 .Caption   = THIS.Caption
285:             ENDWITH
286: 
287:             .AddObject("lbl_4c_Titulo", "Label")
288:             WITH .lbl_4c_Titulo
289:                 .Top       = 18
290:                 .Left      = 10
291:                 .Width     = THIS.Width
292:                 .Height    = 46

*-- Linhas 388 a 765:
388:         *-- A ordem dos Buttons segue a do legado (Command1 = cmd_movimenta,
389:         *-- Command2 = cmd_cancela, Command3 = cmd_cadastro) - o que o usuario
390:         *-- ve da esquerda para a direita vem do .Left, nao do indice.
391:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Operacao.Buttons(3), "Click", THIS, "BtnCadastroClick")
392:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnMovimentoClick")
393:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Operacao.Buttons(2), "Click", THIS, "BtnCancelarClick")
394: 
395:         *-- FASE 6/8: campos de filtro da Pagina Consulta (shp_principal +
396:         *-- Label1/2/3/5/6/7 + Opt_Analise + Get_Datai/Dataf/Moeda/Empresa +
397:         *-- container Origem com Get_grupo/Get_conta/Get_dconta/Get_cpf).
398:         *-- Todos com os lookups do legado (fAcessoContab/fAcessoContas,
399:         *-- ja portados em utils\functions.prg, e FormBuscaAuxiliar para
400:         *-- Moeda/Empresa/Cpf - fAcessoEmpresa NAO foi portada, regra
401:         *-- CLAUDE.md "fAcessoEmpresa() NAO EXISTE").
402:         loc_oPag.AddObject("shp_4c_Shp_principal", "Shape")
403:         WITH loc_oPag.shp_4c_Shp_principal
404:             .Top           = 296
405:             .Left          = 92
406:             .Width         = 615
407:             .Height        = 69
408:             .BackStyle     = 0
409:             .SpecialEffect = 1
410:         ENDWITH
411: 
412:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
413:         WITH loc_oPag.lbl_4c_Label2
414:             .Top       = 313
415:             .Left      = 146
416:             .Width     = 51
417:             .Height    = 28
418:             .FontName  = "Tahoma"
419:             .FontSize  = 8
420:             .WordWrap  = .T.
421:             .Alignment = 1
422:             .BackStyle = 0
423:             .ForeColor = RGB(90, 90, 90)
424:             .Caption   = "An" + CHR(225) + "lise de Vendas :"
425:         ENDWITH
426: 
427:         loc_oPag.AddObject("obj_4c_Opt_Analise", "OptionGroup")
428:         WITH loc_oPag.obj_4c_Opt_Analise
429:             .Top           = 309
430:             .Left          = 214
431:             .Width         = 56
432:             .Height        = 46
433:             .ButtonCount   = 2
434:             .BackStyle     = 0
435:             .SpecialEffect = 1
436:             .BorderColor   = RGB(136, 188, 189)
437:             .Value         = 2
438: 
439:             WITH .Buttons(1)
440:                 .Caption   = "Sim"
441:                 .FontName  = "Verdana"
442:                 .FontSize  = 8
443:                 .BackStyle = 0
444:                 .Top       = 5
445:                 .Left      = 7
446:                 .Width     = 42
447:                 .Height    = 17
448:                 .ForeColor = RGB(36, 84, 155)
449:             ENDWITH
450: 
451:             WITH .Buttons(2)
452:                 .Caption   = "N" + CHR(227) + "o"
453:                 .FontName  = "Verdana"
454:                 .FontSize  = 8
455:                 .BackStyle = 0
456:                 .Top       = 22
457:                 .Left      = 7
458:                 .Width     = 42
459:                 .Height    = 17
460:                 .ForeColor = RGB(36, 84, 155)
461:             ENDWITH
462:         ENDWITH
463:         BINDEVENT(loc_oPag.obj_4c_Opt_Analise, "InteractiveChange", THIS, "OptAnaliseChange")
464: 
465:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
466:         WITH loc_oPag.lbl_4c_Label1
467:             .Top       = 309
468:             .Left      = 296
469:             .Width     = 45
470:             .Height    = 15
471:             .FontName  = "Tahoma"
472:             .FontSize  = 8
473:             .Alignment = 0
474:             .BackStyle = 0
475:             .ForeColor = RGB(90, 90, 90)
476:             .Caption   = "Per" + CHR(237) + "odo :"
477:         ENDWITH
478: 
479:         loc_oPag.AddObject("txt_4c_Datai", "TextBox")
480:         WITH loc_oPag.txt_4c_Datai
481:             .Top      = 306
482:             .Left     = 368
483:             .Width    = 88
484:             .Height   = 23
485:             .FontName = "Courier New"
486:             .Alignment = 3
487:             .Value    = {}
488:             .Format   = "K!"
489:         ENDWITH
490:         BINDEVENT(loc_oPag.txt_4c_Datai, "KeyPress", THIS, "ValidarDataI")
491: 
492:         loc_oPag.AddObject("lbl_4c_Label7", "Label")
493:         WITH loc_oPag.lbl_4c_Label7
494:             .Top       = 309
495:             .Left      = 349
496:             .Width     = 14
497:             .Height    = 15
498:             .FontName  = "Tahoma"
499:             .FontSize  = 8
500:             .Alignment = 0
501:             .BackStyle = 0
502:             .ForeColor = RGB(90, 90, 90)
503:             .Caption   = "de"
504:         ENDWITH
505: 
506:         loc_oPag.AddObject("lbl_4c_Label6", "Label")
507:         WITH loc_oPag.lbl_4c_Label6
508:             .Top       = 334
509:             .Left      = 346
510:             .Width     = 18
511:             .Height    = 15
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8
514:             .Alignment = 0
515:             .BackStyle = 0
516:             .ForeColor = RGB(90, 90, 90)
517:             .Caption   = "at" + CHR(233)
518:         ENDWITH
519: 
520:         loc_oPag.AddObject("txt_4c_Dataf", "TextBox")
521:         WITH loc_oPag.txt_4c_Dataf
522:             .Top      = 332
523:             .Left     = 368
524:             .Width    = 88
525:             .Height   = 23
526:             .FontName = "Courier New"
527:             .Alignment = 3
528:             .Value    = {}
529:             .Format   = "K!"
530:         ENDWITH
531:         BINDEVENT(loc_oPag.txt_4c_Dataf, "KeyPress", THIS, "ValidarDataF")
532: 
533:         loc_oPag.AddObject("lbl_4c_Label3", "Label")
534:         WITH loc_oPag.lbl_4c_Label3
535:             .Top       = 310
536:             .Left      = 511
537:             .Width     = 41
538:             .Height    = 15
539:             .FontName  = "Tahoma"
540:             .FontSize  = 8
541:             .Alignment = 0
542:             .BackStyle = 0
543:             .ForeColor = RGB(90, 90, 90)
544:             .Caption   = "Moeda :"
545:         ENDWITH
546: 
547:         loc_oPag.AddObject("txt_4c_Moeda", "TextBox")
548:         WITH loc_oPag.txt_4c_Moeda
549:             .Top        = 306
550:             .Left       = 555
551:             .Width      = 36
552:             .Height     = 23
553:             .FontName   = "Courier New"
554:             .FontItalic = .F.
555:             .Alignment  = 0
556:             .Format     = "K"
557:             .InputMask  = "!!!"
558:             .MaxLength  = 3
559:             .Value      = ""
560:         ENDWITH
561:         BINDEVENT(loc_oPag.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")
562: 
563:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
564:         WITH loc_oPag.lbl_4c_Label5
565:             .Top       = 336
566:             .Left      = 502
567:             .Width     = 50
568:             .Height    = 15
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .Alignment = 0
572:             .BackStyle = 0
573:             .ForeColor = RGB(90, 90, 90)
574:             .Caption   = "Empresa :"
575:         ENDWITH
576: 
577:         loc_oPag.AddObject("txt_4c_Empresa", "TextBox")
578:         WITH loc_oPag.txt_4c_Empresa
579:             .Top       = 332
580:             .Left      = 555
581:             .Width     = 36
582:             .Height    = 23
583:             .FontName  = "Courier New"
584:             .Alignment = 3
585:             .Value     = ""
586:             .MaxLength   = 3
587:         ENDWITH
588:         BINDEVENT(loc_oPag.txt_4c_Empresa, "KeyPress", THIS, "ValidarEmpresa")
589: 
590:         *-- Container Origem - Grupo/Conta do fornecedor pesquisado
591:         loc_oPag.AddObject("cnt_4c_Origem", "Container")
592:         WITH loc_oPag.cnt_4c_Origem
593:             .Top       = 239
594:             .Left      = 92
595:             .Width     = 615
596:             .Height    = 40
597:             .BackStyle = 0
598: 
599:             .AddObject("lbl_4c__Origem1", "Label")
600:             WITH .lbl_4c__Origem1
601:                 .Top       = 2
602:                 .Left      = 6
603:                 .FontBold  = .T.
604:                 .FontSize  = 8
605:                 .BackStyle = 0
606:                 .ForeColor = RGB(90, 90, 90)
607:                 .Caption   = "Grupo / Conta"
608:             ENDWITH
609: 
610:             .AddObject("lbl_4c_Label1", "Label")
611:             WITH .lbl_4c_Label1
612:                 .Top       = 17
613:                 .Left      = 87
614:                 .Width     = 11
615:                 .Height    = 15
616:                 .FontBold  = .T.
617:                 .Caption   = " : "
618:             ENDWITH
619: 
620:             .AddObject("txt_4c_Grupo", "TextBox")
621:             WITH .txt_4c_Grupo
622:                 .Top       = 15
623:                 .Left      = 7
624:                 .Width     = 80
625:                 .Height    = 21
626:                 .FontBold  = .T.
627:                 .Alignment = 3
628:                 .Margin    = 0
629:                 .InputMask = "XXXXXXXXXX"
630:                 .MaxLength = 10
631:                 .DisabledBackColor = RGB(255, 255, 255)
632:                 .Value     = ""
633:             ENDWITH
634:             BINDEVENT(.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
635: 
636:             .AddObject("lbl_4c_Label2", "Label")
637:             WITH .lbl_4c_Label2
638:                 .Top       = 2
639:                 .Left      = 107
640:                 .FontBold  = .F.
641:                 .FontSize  = 8
642:                 .BackStyle = 0
643:                 .ForeColor = RGB(90, 90, 90)
644:                 .Caption   = "Conta"
645:             ENDWITH
646: 
647:             .AddObject("txt_4c_Conta", "TextBox")
648:             WITH .txt_4c_Conta
649:                 .Top       = 15
650:                 .Left      = 97
651:                 .Width     = 80
652:                 .Height    = 21
653:                 .Margin    = 0
654:                 .InputMask = "XXXXXXXXXX"
655:                 .MaxLength = 10
656:                 .DisabledBackColor = RGB(255, 255, 255)
657:                 .Value     = ""
658:             ENDWITH
659:             BINDEVENT(.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
660: 
661:             .AddObject("lbl_4c__CPF", "Label")
662:             WITH .lbl_4c__CPF
663:                 .Top       = 2
664:                 .Left      = 183
665:                 .FontBold  = .F.
666:                 .FontSize  = 8
667:                 .BackStyle = 0
668:                 .ForeColor = RGB(90, 90, 90)
669:                 .Caption   = "CPF / CGC"
670:             ENDWITH
671: 
672:             .AddObject("txt_4c_Cpf", "TextBox")
673:             WITH .txt_4c_Cpf
674:                 .Top       = 15
675:                 .Left      = 181
676:                 .Width     = 146
677:                 .Height    = 21
678:                 .Margin    = 0
679:                 .InputMask = "XXXXXXXXXXXXXXXXXXXX"
680:                 .MaxLength = 20
681:                 .DisabledBackColor = RGB(255, 255, 255)
682:                 .Value     = ""
683:             ENDWITH
684:             BINDEVENT(.txt_4c_Cpf, "KeyPress", THIS, "ValidarCpf")
685: 
686:             .AddObject("lbl_4c__dConta", "Label")
687:             WITH .lbl_4c__dConta
688:                 .Top       = 2
689:                 .Left      = 332
690:                 .FontBold  = .F.
691:                 .FontSize  = 8
692:                 .BackStyle = 0
693:                 .ForeColor = RGB(90, 90, 90)
694:                 .Caption   = "Nome"
695:             ENDWITH
696: 
697:             .AddObject("txt_4c_Dconta", "TextBox")
698:             WITH .txt_4c_Dconta
699:                 .Top       = 15
700:                 .Left      = 330
701:                 .Width     = 278
702:                 .Height    = 21
703:                 .Margin    = 0
704:                 .InputMask = REPLICATE("X", 40)
705:                 .MaxLength = 40
706:                 .DisabledBackColor = RGB(255, 255, 255)
707:                 .Value     = ""
708:             ENDWITH
709:             BINDEVENT(.txt_4c_Dconta, "KeyPress", THIS, "ValidarDConta")
710:         ENDWITH
711: 
712:         *-- Estado inicial dos campos de analise (legado: Opt_Analise.Value=2
713:         *-- "Nao" por default -> Data/Moeda/Empresa comecam desabilitados -
714:         *-- regra do When "Return(Opt_Analise.Value = 1)")
715:         THIS.OptAnaliseChange()
716:     ENDPROC
717: 
718:     *==========================================================================
719:     * ConfigurarPaginaDados - Estrutura base da Page2 (Resultado)
720:     * Fase 3/8: so a faixa do cabecalho (regra #11, repetida nas duas
721:     * paginas) + container vazio para os botoes de acao (grp_operacao +
722:     * Cmd_MudaFor/Cmd_MudaMov do legado, que alternam entre a aba Cadastro
723:     * e a aba Movimento - entram na Fase 4).
724:     *==========================================================================
725:     PROTECTED PROCEDURE ConfigurarPaginaDados()
726:         LOCAL loc_oPag, loc_oCab
727: 
728:         loc_oPag = THIS.pgf_4c_Paginas.Page2
729: 
730:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
731:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
732:         WITH loc_oCab
733:             .Top           = 29
734:             .Left          = 0
735:             .Width         = THIS.Width
736:             .Height        = 80
737:             .BorderWidth   = 0
738:             .SpecialEffect = 0
739:             .BackColor     = RGB(100, 100, 100)
740: 
741:             .AddObject("lbl_4c_Sombra", "Label")
742:             WITH .lbl_4c_Sombra
743:                 .Top       = 15
744:                 .Left      = 10
745:                 .Width     = THIS.Width
746:                 .Height    = 40
747:                 .FontName  = "Tahoma"
748:                 .FontSize  = 16
749:                 .FontBold  = .T.
750:                 .WordWrap  = .T.
751:                 .Alignment = 0
752:                 .BackStyle = 0
753:                 .ForeColor = RGB(0, 0, 0)
754:                 .Caption   = THIS.Caption
755:             ENDWITH
756: 
757:             .AddObject("lbl_4c_Titulo", "Label")
758:             WITH .lbl_4c_Titulo
759:                 .Top       = 18
760:                 .Left      = 10
761:                 .Width     = THIS.Width
762:                 .Height    = 46
763:                 .FontName  = "Tahoma"
764:                 .FontSize  = 16
765:                 .FontBold  = .T.

*-- Linhas 1172 a 1315:
1172:                 .Picture    = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1173:             ENDWITH
1174:         ENDWITH
1175:         BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnVoltarClick")
1176: 
1177:         *-- Cmd_MudaFor / Cmd_MudaMov (legado: Top=101,Left=629/671,W=50,
1178:         *-- H=50,ButtonCount=1 cada) - alternam a exibicao entre a
1179:         *-- sub-pagina Cadastro e a sub-pagina Movimento/Result da Page2
1180:         *-- (Top compensado +29 pelo PageFrame.Top=-29). Os containers
1181:         *-- Cadastro/Result ainda nao existem (entram quando as paginas
1182:         *-- internas forem construidas) - os handlers ja alternam a
1183:         *-- visibilidade entre os dois botoes, igual ao legado
1184:         *-- (Cmd_MudaFor.Click/Cmd_MudaMov.Click trocam Enabled/Visible um
1185:         *-- do outro); a troca de Cadastro.Visible/Result.Visible eh
1186:         *-- concluida quando esses containers existirem.
1187:         loc_oPag.AddObject("cmg_4c_MudaFor", "CommandGroup")
1188:         WITH loc_oPag.cmg_4c_MudaFor
1189:             .Top         = 130
1190:             .Left        = 629
1191:             .Width       = 50
1192:             .Height      = 50
1193:             .ButtonCount = 1
1194:             .BackStyle   = 0
1195:             .BorderStyle = 0
1196:             .Themes      = .F.
1197:             .Visible     = .F.
1198: 
1199:             *-- Legado Cmd_MudaFor.Command1 (cmd_cadastro): botao SO de icone,
1200:             *-- Caption vazio, ToolTipText "Dados Cadastrais", Verdana 8.
1201:             WITH .Buttons(1)
1202:                 .Caption     = ""
1203:                 .Top         = 5
1204:                 .Left        = 5
1205:                 .Width       = 40
1206:                 .Height      = 40
1207:                 .FontName    = "Verdana"
1208:                 .FontSize    = 8
1209:                 .WordWrap    = .T.
1210:                 .ToolTipText = "Dados Cadastrais"
1211:                 .ForeColor   = RGB(36, 84, 155)
1212:                 .BackColor   = RGB(255, 255, 255)
1213:                 .Themes      = .T.
1214:                 .Picture         = gc_4c_CaminhoIcones + "profile_add.ico"
1215:                 .DisabledPicture = gc_4c_CaminhoIcones + "profile_add.ico"
1216:             ENDWITH
1217:         ENDWITH
1218:         BINDEVENT(loc_oPag.cmg_4c_MudaFor.Buttons(1), "Click", THIS, "BtnMudaForClick")
1219: 
1220:         loc_oPag.AddObject("cmg_4c_MudaMov", "CommandGroup")
1221:         WITH loc_oPag.cmg_4c_MudaMov
1222:             .Top         = 130
1223:             .Left        = 671
1224:             .Width       = 50
1225:             .Height      = 50
1226:             .ButtonCount = 1
1227:             .BackStyle   = 0
1228:             .BorderStyle = 0
1229:             .Themes      = .F.
1230: 
1231:             *-- Legado Cmd_MudaMov.Command1 (cmd_movimenta): idem, ToolTipText
1232:             *-- "Movimentacao".
1233:             WITH .Buttons(1)
1234:                 .Caption     = ""
1235:                 .Top         = 5
1236:                 .Left        = 5
1237:                 .Width       = 40
1238:                 .Height      = 40
1239:                 .FontName    = "Verdana"
1240:                 .FontSize    = 8
1241:                 .WordWrap    = .T.
1242:                 .ToolTipText = "Movimenta" + CHR(231) + CHR(227) + "o"
1243:                 .ForeColor   = RGB(36, 84, 155)
1244:                 .BackColor   = RGB(255, 255, 255)
1245:                 .Themes      = .T.
1246:                 .Picture         = gc_4c_CaminhoIcones + "coins.ico"
1247:                 .DisabledPicture = gc_4c_CaminhoIcones + "coins.ico"
1248:             ENDWITH
1249:         ENDWITH
1250:         BINDEVENT(loc_oPag.cmg_4c_MudaMov.Buttons(1), "Click", THIS, "BtnMudaMovClick")
1251: 
1252:         *-- PageFrame Result (5 sub-paginas) + container ImprimeOpcoes
1253:         THIS.ConfigurarPaginaResultado(loc_oPag)
1254:     ENDPROC
1255: 
1256:     *==========================================================================
1257:     * ConfigurarPaginaResultado - PageFrame "Result" do legado, com as 5
1258:     * sub-paginas de resultado da consulta, e o container ImprimeOpcoes.
1259:     *
1260:     * As paginas sao criadas na ordem do PageOrder do legado (Saldo=1,
1261:     * Pendencias=2, Movimentacao=3, Estoque=4, Consertos=5), NAO na ordem em
1262:     * que o SCX declara os objetos (Saldo, Movimenta, Estoque, Pendencias,
1263:     * Conserto): ActivePage eh o PageOrder, nao a ordem de declaracao, e eh o
1264:     * PageOrder que o usuario ve na fileira de abas.
1265:     *
1266:     * Top do PageFrame compensado (+29 pelo pgf_4c_Paginas.Top = -29): legado
1267:     * 157 -> 186. Dentro dele os Tops sao relativos a cada Page e vao CRUS do
1268:     * dump, sem compensacao.
1269:     *
1270:     * Os grids sao ligados aos cursores AQUI porque os 8 cursores locais ja
1271:     * existem neste ponto: o BO eh instanciado no inicio de InicializarForm e
1272:     * cria todos em InicializarCursoresDados. Column.Width vem DEPOIS de
1273:     * RecordSource/ControlSource, que resetam a largura para o default 90.
1274:     *==========================================================================
1275:     PROTECTED PROCEDURE ConfigurarPaginaResultado(par_oPag)
1276:         LOCAL loc_oPgf
1277: 
1278:         par_oPag.AddObject("pgf_4c_Result", "PageFrame")
1279:         loc_oPgf = par_oPag.pgf_4c_Result
1280: 
1281:         WITH loc_oPgf
1282:             .PageCount = 5
1283:             .Top       = 186
1284:             .Left      = 59
1285:             .Width     = 701
1286:             .Height    = 421
1287:             .Tabs      = .T.
1288: 
1289:             .Page1.Caption   = "Saldo"
1290:             .Page1.FontName  = "Tahoma"
1291:             .Page1.FontSize  = 8
1292:             .Page1.BackColor = RGB(255, 255, 255)
1293:             .Page1.ForeColor = RGB(90, 90, 90)
1294: 
1295:             .Page2.Caption   = "Pend" + CHR(234) + "ncias"
1296:             .Page2.FontName  = "Tahoma"
1297:             .Page2.FontSize  = 8
1298:             .Page2.BackColor = RGB(255, 255, 255)
1299:             .Page2.ForeColor = RGB(90, 90, 90)
1300: 
1301:             .Page3.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
1302:             .Page3.FontName  = "Tahoma"
1303:             .Page3.FontSize  = 8
1304:             .Page3.BackColor = RGB(255, 255, 255)
1305:             .Page3.ForeColor = RGB(90, 90, 90)
1306: 
1307:             .Page4.Caption   = "Estoque"
1308:             .Page4.FontName  = "Tahoma"
1309:             .Page4.FontSize  = 8
1310:             .Page4.BackColor = RGB(255, 255, 255)
1311:             .Page4.ForeColor = RGB(90, 90, 90)
1312: 
1313:             .Page5.Caption   = "Consertos"
1314:             .Page5.FontName  = "Tahoma"
1315:             .Page5.FontSize  = 8

*-- Linhas 1328 a 1401:
1328:         *-- Inicio: a Pagina Resultado abre no bloco Cadastro (o legado so
1329:         *-- mostra o Result depois do botao Movimentacao), por isso o
1330:         *-- PageFrame nasce oculto - BtnMovimentoClick / BtnMudaMovClick o
1331:         *-- revelam. Entra na lista de excecao de TornarControlesVisiveis.
1332:         loc_oPgf.Visible = .F.
1333:         loc_oPgf.Enabled = .F.
1334: 
1335:         THIS.ConfigurarImprimeOpcoes(par_oPag)
1336:     ENDPROC
1337: 
1338:     *==========================================================================
1339:     * FormatarGradeResultado - propriedades comuns a todas as grades de
1340:     * resultado (todas somente-leitura, sem marcador de registro/exclusao e
1341:     * com a cor de linha de grade do legado).
1342:     *==========================================================================
1343:     PROTECTED PROCEDURE FormatarGradeResultado(par_oGrid)
1344:         WITH par_oGrid
1345:             .ReadOnly         = .T.
1346:             .DeleteMark       = .F.
1347:             .RecordMark       = .F.
1348:             .ScrollBars       = 2
1349:             .RecordSourceType = 1
1350:             .GridLineColor    = RGB(238, 238, 238)
1351:             .FontName         = "Tahoma"
1352:             .FontSize         = 8
1353:         ENDWITH
1354:     ENDPROC
1355: 
1356:     *==========================================================================
1357:     * ConfigurarAbaSaldo - Page "Saldo" do Result: historico de conta corrente
1358:     * (grade FILHA da grade de saldos pela moeda), saldo por moeda, os dois
1359:     * campos de historico da linha corrente e o botao de impressao do extrato.
1360:     *==========================================================================
1361:     PROTECTED PROCEDURE ConfigurarAbaSaldo(par_oPage)
1362:         *-- shp_historico / shp_saldo / Shape1 - molduras do legado
1363:         par_oPage.AddObject("shp_4c_MoldHistorico", "Shape")
1364:         WITH par_oPage.shp_4c_MoldHistorico
1365:             .Top           = 21
1366:             .Left          = 9
1367:             .Width         = 664
1368:             .Height        = 233
1369:             .BackStyle     = 0
1370:             .SpecialEffect = 1
1371:         ENDWITH
1372: 
1373:         par_oPage.AddObject("shp_4c_MoldSaldo", "Shape")
1374:         WITH par_oPage.shp_4c_MoldSaldo
1375:             .Top           = 267
1376:             .Left          = 9
1377:             .Width         = 165
1378:             .Height        = 125
1379:             .BackStyle     = 0
1380:             .SpecialEffect = 1
1381:         ENDWITH
1382: 
1383:         par_oPage.AddObject("shp_4c_MoldHists", "Shape")
1384:         WITH par_oPage.shp_4c_MoldHists
1385:             .Top           = 267
1386:             .Left          = 182
1387:             .Width         = 411
1388:             .Height        = 59
1389:             .BackStyle     = 0
1390:             .SpecialEffect = 1
1391:         ENDWITH
1392: 
1393:         *-- Labels (AutoSize = .F. + Width/Height explicitos: AutoSize eh
1394:         *-- no-op em Label criado por AddObject)
1395:         par_oPage.AddObject("lbl_4c_TitHistorico", "Label")
1396:         WITH par_oPage.lbl_4c_TitHistorico
1397:             .Top        = 6
1398:             .Left       = 14
1399:             .Width      = 141
1400:             .Height     = 15
1401:             .AutoSize   = .F.

*-- Linhas 1479 a 1918:
1479:             .FontSize      = 8
1480:             .ReadOnly      = .T.
1481:             .TabStop       = .F.
1482:             .ForeColor     = RGB(0, 0, 0)
1483:             .BackColor     = RGB(255, 255, 255)
1484:             .ControlSource = "cursor_4c_Historico.hists"
1485:         ENDWITH
1486: 
1487:         par_oPage.AddObject("txt_4c_Hist2s", "TextBox")
1488:         WITH par_oPage.txt_4c_Hist2s
1489:             .Top           = 299
1490:             .Left          = 187
1491:             .Width         = 401
1492:             .Height        = 23
1493:             .FontName      = "Tahoma"
1494:             .FontSize      = 8
1495:             .ReadOnly      = .T.
1496:             .TabStop       = .F.
1497:             .ForeColor     = RGB(0, 0, 0)
1498:             .BackColor     = RGB(255, 255, 255)
1499:             .ControlSource = "cursor_4c_Historico.hist2s"
1500:         ENDWITH
1501: 
1502:         *-- btnImprimir: abre o relatorio SigReCgc do fornecedor (legado:
1503:         *-- "Do Form SigReCgc With Get_Grupo.Value, Get_Conta.Value")
1504:         par_oPage.AddObject("cmd_4c_ImprimirExtrato", "CommandButton")
1505:         WITH par_oPage.cmd_4c_ImprimirExtrato
1506:             .Top             = 277
1507:             .Left            = 618
1508:             .Width           = 40
1509:             .Height          = 40
1510:             .FontName        = "Verdana"
1511:             .FontSize        = 8
1512:             .WordWrap        = .T.
1513:             .Caption         = ""
1514:             .ToolTipText     = "Imprimir"
1515:             .ForeColor       = RGB(36, 84, 155)
1516:             .BackColor       = RGB(255, 255, 255)
1517:             .Themes          = .T.
1518:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
1519:             .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
1520:         ENDWITH
1521:         BINDEVENT(par_oPage.cmd_4c_ImprimirExtrato, "Click", THIS, "BtnImprimirExtratoClick")
1522: 
1523:         BINDEVENT(par_oPage.grd_4c_Saldo, "AfterRowColChange", THIS, "GradeSaldoAfterRowColChange")
1524:         BINDEVENT(par_oPage.grd_4c_Historico, "AfterRowColChange", THIS, "GradeHistoricoAfterRowColChange")
1525: 
1526:         THIS.ConfigurarGradesSaldo()
1527:     ENDPROC
1528: 
1529:     *==========================================================================
1530:     * ConfigurarGradesSaldo - (re)configura grd_4c_Saldo e grd_4c_Historico.
1531:     *
1532:     * O legado faz isso DENTRO do cmd_movimenta.Click, e nao no SCX, porque o
1533:     * numero de colunas depende da permissao: com acesso ao saldo a grade de
1534:     * historico tem 8 colunas (inclui Saldo) e a de moedas tem 2; sem acesso,
1535:     * 7 e 1, a moldura encolhe 94px e o titulo muda de "Saldo por Moeda" para
1536:     * "Moedas". Como mexer em ColumnCount RECRIA os objetos Column, toda a
1537:     * configuracao (ControlSource / Width / Header) eh refeita aqui - e a
1538:     * Width sempre DEPOIS do ControlSource, que a reseta para o default 90.
1539:     *
1540:     * llSaldo transcrito do legado:
1541:     *     llSaldo = !fChecaAcesso('SIGOPCGC','SALDO') Or llSupervis
1542:     * ATENCAO: o "!" eh do legado e esta preservado (regra #17 - nao inverter
1543:     * sinal de regra de negocio). Como fChecaAcesso em utils\functions.prg eh
1544:     * um stub que devolve SEMPRE .T., o efeito pratico hoje eh: coluna Saldo
1545:     * visivel apenas para o usuario 4CONTROL. Se a intencao do negocio for o
1546:     * contrario, a correcao eh de UMA linha aqui - mas inverter sem confirmar
1547:     * exporia saldo financeiro a quem o legado esconde.
1548:     *==========================================================================
1549:     PROTECTED PROCEDURE ConfigurarGradesSaldo()
1550:         LOCAL loc_oPage, loc_oGrdH, loc_oGrdS, loc_lSaldo, loc_lSupervis, loc_nCol
1551: 
1552:         loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1
1553:         loc_oGrdH = loc_oPage.grd_4c_Historico
1554:         loc_oGrdS = loc_oPage.grd_4c_Saldo
1555: 
1556:         loc_lSupervis = .F.
1557:         IF TYPE("gc_4c_UsuarioLogado") = "C"
1558:             loc_lSupervis = (UPPER(ALLTRIM(gc_4c_UsuarioLogado)) == "4CONTROL")
1559:         ENDIF
1560:         loc_lSaldo    = !fChecaAcesso("SIGOPCGC", "SALDO") OR loc_lSupervis
1561: 
1562:         *---------------------------------------------------------------
1563:         *-- Grade de HISTORICO (grade filha da grade de saldos)
1564:         *---------------------------------------------------------------
1565:         WITH loc_oGrdH
1566:             .ColumnCount = IIF(loc_lSaldo, 8, 7)
1567:             THIS.FormatarGradeResultado(loc_oGrdH)
1568:             .Width          = 588
1569:             .RecordSource   = "cursor_4c_Historico"
1570:             .LinkMaster     = "cursor_4c_Saldo"
1571:             .ChildOrder     = "moedata"
1572:             .RelationalExpr = "moedas"
1573: 
1574:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Historico.emps", ;
1575:                 31, "Emp", 2, "", "")
1576:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Historico.datas", ;
1577:                 80, "Data", 2, "", "")
1578:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Historico.valors", ;
1579:                 94, "Valor", 2, "9,999,999.99", "9,999,999.99")
1580:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Historico.opers", ;
1581:                 18, "O", 2, "", "")
1582: 
1583:             IF loc_lSaldo
1584:                 THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_Historico.saldos", ;
1585:                     94, "Saldo", 2, "9,999,999.99", "9,999,999.99")
1586:                 THIS.ConfigurarColunaResultado(.Column6, "cursor_4c_Historico.vencs", ;
1587:                     80, "Vencimento", 2, "", "")
1588:                 THIS.ConfigurarColunaResultado(.Column7, "cursor_4c_Historico.nfs", ;
1589:                     80, "Nota", 2, "", "")
1590:                 THIS.ConfigurarColunaResultado(.Column8, ;
1591:                     "IIF(cursor_4c_Historico.valors - cursor_4c_Historico.valpags = 0, '*', '')", ;
1592:                     20, "Pg", 2, "", "")
1593:             ELSE
1594:                 THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_Historico.vencs", ;
1595:                     80, "Vencimento", 2, "", "")
1596:                 THIS.ConfigurarColunaResultado(.Column6, "cursor_4c_Historico.nfs", ;
1597:                     80, "Nota", 2, "", "")
1598:                 THIS.ConfigurarColunaResultado(.Column7, ;
1599:                     "IIF(cursor_4c_Historico.valors - cursor_4c_Historico.valpags = 0, '*', '')", ;
1600:                     20, "Pg", 2, "", "")
1601:             ENDIF
1602:         ENDWITH
1603: 
1604:         *---------------------------------------------------------------
1605:         *-- Grade de SALDO POR MOEDA (grade mae)
1606:         *---------------------------------------------------------------
1607:         WITH loc_oGrdS
1608:             .ColumnCount = IIF(loc_lSaldo, 2, 1)
1609:             THIS.FormatarGradeResultado(loc_oGrdS)
1610:             .Width        = IIF(loc_lSaldo, 156, 156 - 94)
1611:             .RecordSource = "cursor_4c_Saldo"
1612: 
1613:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Saldo.moedas", ;
1614:                 31, "M.", 2, "", "")
1615: 
1616:             IF loc_lSaldo
1617:                 THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Saldo.saldos", ;
1618:                     94, "Saldo", 2, "", "")
1619:             ENDIF
1620:         ENDWITH
1621: 
1622:         *-- moldura e titulo acompanham o numero de colunas (legado)
1623:         loc_oPage.shp_4c_MoldSaldo.Width = IIF(loc_lSaldo, 165, 165 - 94)
1624:         loc_oPage.lbl_4c_TitSaldo.Caption = IIF(loc_lSaldo, "Saldo por Moeda", "Moedas")
1625:     ENDPROC
1626: 
1627:     *==========================================================================
1628:     * ConfigurarColunaResultado - aplica de uma vez as propriedades que toda
1629:     * coluna de grade de resultado recebe. A Width eh atribuida DEPOIS do
1630:     * ControlSource de proposito: mexer no ControlSource reseta a largura para
1631:     * o default 90.
1632:     *==========================================================================
1633:     PROTECTED PROCEDURE ConfigurarColunaResultado(par_oCol, par_cFonte, ;
1634:             par_nWidth, par_cCaption, par_nAlinhaHeader, par_cFormat, par_cMask)
1635:         WITH par_oCol
1636:             .ControlSource = par_cFonte
1637:             .Width         = par_nWidth
1638:             .Movable       = .F.
1639:             .Resizable     = .F.
1640:             .ReadOnly      = .T.
1641:             .FontName      = "Tahoma"
1642:             .FontSize      = 8
1643: 
1644:             IF !EMPTY(par_cFormat)
1645:                 .Format = par_cFormat
1646:             ENDIF
1647:             IF !EMPTY(par_cMask)
1648:                 .InputMask = par_cMask
1649:             ENDIF
1650: 
1651:             .Header1.Caption   = par_cCaption
1652:             .Header1.Alignment = par_nAlinhaHeader
1653:             .Header1.FontName  = "Tahoma"
1654:             .Header1.FontSize  = 8
1655:             .Header1.ForeColor = RGB(90, 90, 90)
1656: 
1657:             .Text1.BorderStyle = 0
1658:             .Text1.Margin      = 0
1659:             .Text1.ReadOnly    = .T.
1660:         ENDWITH
1661:     ENDPROC
1662: 
1663:     *==========================================================================
1664:     * ConfigurarAbaPendencias - Page "Pendencias" do Result: parcelas e
1665:     * lancamentos de conta corrente em aberto (cursor_4c_Parcela).
1666:     *
1667:     * Grid1 do legado (a grade de baixo) nasce Visible = .F. / Enabled = .F.
1668:     * com TODAS as colunas invisiveis - eh um resto de layout que o legado
1669:     * nunca mostra. Reproduzida para nao perder objeto da tela, e por isso
1670:     * entra na lista de excecao de TornarControlesVisiveis.
1671:     *==========================================================================
1672:     PROTECTED PROCEDURE ConfigurarAbaPendencias(par_oPage)
1673:         LOCAL loc_oGrd
1674: 
1675:         par_oPage.AddObject("shp_4c_MoldPendencias", "Shape")
1676:         WITH par_oPage.shp_4c_MoldPendencias
1677:             .Top           = 17
1678:             .Left          = 9
1679:             .Width         = 663
1680:             .Height        = 199
1681:             .BackStyle     = 0
1682:             .SpecialEffect = 1
1683:         ENDWITH
1684: 
1685:         par_oPage.AddObject("lbl_4c_TitPendencias", "Label")
1686:         WITH par_oPage.lbl_4c_TitPendencias
1687:             .Top        = 3
1688:             .Left       = 20
1689:             .Width      = 66
1690:             .Height     = 15
1691:             .AutoSize   = .F.
1692:             .FontName   = "Tahoma"
1693:             .FontSize   = 8
1694:             .FontBold   = .T.
1695:             .FontItalic = .T.
1696:             .BackStyle  = 0
1697:             .Alignment  = 0
1698:             .ForeColor  = RGB(90, 90, 90)
1699:             .Caption    = "Pend" + CHR(234) + "ncias"
1700:         ENDWITH
1701: 
1702:         par_oPage.AddObject("grd_4c_Pendente", "Grid")
1703:         loc_oGrd = par_oPage.grd_4c_Pendente
1704:         WITH loc_oGrd
1705:             .Top               = 23
1706:             .Left              = 14
1707:             .Width             = 652
1708:             .Height            = 184
1709:             .AllowHeaderSizing = .F.
1710:             .AllowRowSizing    = .F.
1711:             .ColumnCount       = 4
1712:             THIS.FormatarGradeResultado(loc_oGrd)
1713:             .RecordSource      = "cursor_4c_Parcela"
1714: 
1715:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Parcela.valos", ;
1716:                 77, "Valor", 2, "", "999,999,999.99")
1717:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Parcela.moefpgs", ;
1718:                 30, "Moe", 2, "", "")
1719:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Parcela.vencs", ;
1720:                 90, "Vecto", 2, "", "")
1721:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Parcela.hists", ;
1722:                 370, "Tipo", 2, "", "")
1723: 
1724:             .Column1.ColumnOrder = 2
1725:             .Column2.ColumnOrder = 3
1726:             .Column3.ColumnOrder = 1
1727:             .Column4.ColumnOrder = 4
1728:         ENDWITH
1729: 
1730:         *-- Grid1 do legado: oculta e desabilitada, mantida por fidelidade
1731:         par_oPage.AddObject("grd_4c_PendenteOculta", "Grid")
1732:         loc_oGrd = par_oPage.grd_4c_PendenteOculta
1733:         WITH loc_oGrd
1734:             .Top               = 222
1735:             .Left              = 5
1736:             .Width             = 557
1737:             .Height            = 166
1738:             .AllowHeaderSizing = .F.
1739:             .AllowRowSizing    = .F.
1740:             .ColumnCount       = 5
1741:             THIS.FormatarGradeResultado(loc_oGrd)
1742:             .RecordSource      = "cursor_4c_Parcela"
1743: 
1744:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Parcela.fpags", ;
1745:                 177, "Tipo", 2, "", "")
1746:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Parcela.valos", ;
1747:                 77, "Valor", 2, "", "999,999,999.99")
1748:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Parcela.moefpgs", ;
1749:                 30, "Moe", 2, "", "")
1750:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Parcela.vencs", ;
1751:                 90, "Vecto", 2, "", "")
1752:             THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_Parcela.hists", ;
1753:                 192, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
1754: 
1755:             .Column1.ColumnOrder = 4
1756:             .Column3.ColumnOrder = 3
1757:             .Column4.ColumnOrder = 1
1758: 
1759:             .Enabled = .F.
1760:             .Visible = .F.
1761:         ENDWITH
1762:     ENDPROC
1763: 
1764:     *==========================================================================
1765:     * ConfigurarAbaMovimentacao - Page "Movimentacao" do Result: grade de
1766:     * produtos do fornecedor, total por operacao, operacoes do produto
1767:     * selecionado (grade filha), filtro Ativo/Inativo/Ambos e o botao que
1768:     * abre o painel de opcoes de impressao.
1769:     *==========================================================================
1770:     PROTECTED PROCEDURE ConfigurarAbaMovimentacao(par_oPage)
1771:         LOCAL loc_oGrd
1772: 
1773:         par_oPage.AddObject("lbl_4c_TitProdutos", "Label")
1774:         WITH par_oPage.lbl_4c_TitProdutos
1775:             .Top        = 30
1776:             .Left       = 3
1777:             .Width      = 59
1778:             .Height     = 15
1779:             .AutoSize   = .F.
1780:             .FontName   = "Tahoma"
1781:             .FontSize   = 8
1782:             .FontBold   = .T.
1783:             .FontItalic = .T.
1784:             .BackStyle  = 0
1785:             .Alignment  = 0
1786:             .ForeColor  = RGB(90, 90, 90)
1787:             .Caption    = " Produtos "
1788:         ENDWITH
1789: 
1790:         *-- Grd_Produto: 10 colunas, ColumnOrder do legado
1791:         par_oPage.AddObject("grd_4c_Produto", "Grid")
1792:         loc_oGrd = par_oPage.grd_4c_Produto
1793:         WITH loc_oGrd
1794:             .Top          = 44
1795:             .Left         = 2
1796:             .Width        = 690
1797:             .Height       = 106
1798:             .ColumnCount  = 10
1799:             THIS.FormatarGradeResultado(loc_oGrd)
1800:             .RowHeight    = 17
1801:             .Highlight    = .T.
1802:             .HighlightRow = .T.
1803:             .RecordSource = "cursor_4c_ProdFor"
1804: 
1805:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_ProdFor.cpros", ;
1806:                 108, "Produto", 2, "", "")
1807:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_ProdFor.custofs", ;
1808:                 70, "Custo", 2, "", "999,999,999.99")
1809:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_ProdFor.moecusfs", ;
1810:                 21, "Moe", 2, "", "")
1811:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_ProdFor.marca", ;
1812:                 10, "", 2, "", "")
1813:             THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_ProdFor.qtvend", ;
1814:                 70, "Qt. Vendas", 2, "", "999,999.999")
1815:             THIS.ConfigurarColunaResultado(.Column6, "cursor_4c_ProdFor.vlvend", ;
1816:                 70, "Valor Vendas", 2, "", "99,999,999.99")
1817:             THIS.ConfigurarColunaResultado(.Column7, "cursor_4c_ProdFor.estoque", ;
1818:                 70, "Estoque Atual", 2, "9999,999.999", "")
1819:             THIS.ConfigurarColunaResultado(.Column8, "cursor_4c_ProdFor.pvens", ;
1820:                 79, "Pre" + CHR(231) + "o de Venda", 2, "", "999,999,999.99")
1821:             THIS.ConfigurarColunaResultado(.Column9, "cursor_4c_ProdFor.moedas", ;
1822:                 21, "Moe", 2, "", "")
1823:             THIS.ConfigurarColunaResultado(.Column10, "cursor_4c_ProdFor.reffs", ;
1824:                 141, "Ref.Fornec", 2, "", "")
1825: 
1826:             .Column1.ColumnOrder  = 2
1827:             .Column1.FontBold     = .T.
1828:             .Column1.Alignment    = 3
1829:             .Column2.ColumnOrder  = 4
1830:             .Column2.Alignment    = 3
1831:             .Column3.ColumnOrder  = 5
1832:             .Column4.ColumnOrder  = 1
1833:             .Column5.ColumnOrder  = 6
1834:             .Column6.ColumnOrder  = 7
1835:             .Column7.ColumnOrder  = 8
1836:             .Column8.ColumnOrder  = 9
1837:             .Column9.ColumnOrder  = 10
1838:             .Column10.ColumnOrder = 3
1839:         ENDWITH
1840: 
1841:         *-- Click/DblClick dos headers ordenam a grade (ascendente /
1842:         *-- descendente), igual ao legado
1843:         BINDEVENT(loc_oGrd.Column1.Header1,  "Click",    THIS, "HeaderProdutoClick")
1844:         BINDEVENT(loc_oGrd.Column1.Header1,  "DblClick", THIS, "HeaderProdutoDblClick")
1845:         BINDEVENT(loc_oGrd.Column5.Header1,  "Click",    THIS, "HeaderQtVendClick")
1846:         BINDEVENT(loc_oGrd.Column5.Header1,  "DblClick", THIS, "HeaderQtVendDblClick")
1847:         BINDEVENT(loc_oGrd.Column6.Header1,  "Click",    THIS, "HeaderVlVendClick")
1848:         BINDEVENT(loc_oGrd.Column6.Header1,  "DblClick", THIS, "HeaderVlVendDblClick")
1849:         BINDEVENT(loc_oGrd.Column10.Header1, "Click",    THIS, "HeaderReffsClick")
1850:         BINDEVENT(loc_oGrd.Column10.Header1, "DblClick", THIS, "HeaderReffsDblClick")
1851: 
1852:         *-- shp_produto / lbl_produto + Grd_Resumo (total por operacao)
1853:         par_oPage.AddObject("shp_4c_MoldResumo", "Shape")
1854:         WITH par_oPage.shp_4c_MoldResumo
1855:             .Top           = 173
1856:             .Left          = 10
1857:             .Width         = 329
1858:             .Height        = 127
1859:             .BackStyle     = 0
1860:             .SpecialEffect = 1
1861:             .BorderColor   = RGB(136, 188, 189)
1862:         ENDWITH
1863: 
1864:         par_oPage.AddObject("lbl_4c_TitResumo", "Label")
1865:         WITH par_oPage.lbl_4c_TitResumo
1866:             .Top        = 160
1867:             .Left       = 11
1868:             .Width      = 116
1869:             .Height     = 15
1870:             .AutoSize   = .F.
1871:             .FontName   = "Tahoma"
1872:             .FontSize   = 8
1873:             .FontBold   = .T.
1874:             .FontItalic = .T.
1875:             .BackStyle  = 0
1876:             .Alignment  = 0
1877:             .ForeColor  = RGB(90, 90, 90)
1878:             .Caption    = " Total por Opera" + CHR(231) + CHR(227) + "o "
1879:         ENDWITH
1880: 
1881:         *-- No SCX as Columns de grd_resumo ficaram com ControlSource VAZIO e
1882:         *-- os Text1 internos apontando para um alias "dbproduto" que nao
1883:         *-- existe neste form (residuo de copia de outra grade). As ligacoes
1884:         *-- abaixo vem dos captions dos headers e da estrutura de dbResumo -
1885:         *-- deixar o ControlSource vazio exibiria a grade em branco.
1886:         par_oPage.AddObject("grd_4c_Resumo", "Grid")
1887:         loc_oGrd = par_oPage.grd_4c_Resumo
1888:         WITH loc_oGrd
1889:             .Top          = 180
1890:             .Left         = 14
1891:             .Width        = 320
1892:             .Height       = 113
1893:             .ColumnCount  = 3
1894:             THIS.FormatarGradeResultado(loc_oGrd)
1895:             .Highlight    = .T.
1896:             .HighlightRow = .T.
1897:             .RecordSource = "cursor_4c_Resumo"
1898: 
1899:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Resumo.dopes", ;
1900:                 150, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
1901:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Resumo.valos", ;
1902:                 90, "Valor Total", 2, "", "999,999,999.99")
1903:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Resumo.qtds", ;
1904:                 58, "Qtds", 0, "99999.99", "")
1905: 
1906:             .Column1.ColumnOrder = 1
1907:             .Column1.Alignment   = 3
1908:             .Column2.ColumnOrder = 3
1909:             .Column2.Alignment   = 3
1910:             .Column3.ColumnOrder = 2
1911:         ENDWITH
1912: 
1913:         *-- Shape2 + Grd_OperaProd (operacoes do produto selecionado)
1914:         par_oPage.AddObject("shp_4c_MoldOperaProd", "Shape")
1915:         WITH par_oPage.shp_4c_MoldOperaProd
1916:             .Top           = 152
1917:             .Left          = 337
1918:             .Width         = 332

*-- Linhas 1932 a 1961:
1932:             .ColumnCount    = 3
1933:             THIS.FormatarGradeResultado(loc_oGrd)
1934:             .RowHeight      = 17
1935:             .Highlight      = .T.
1936:             .HighlightRow   = .T.
1937:             .RecordSource   = "cursor_4c_OperaProd"
1938:             .LinkMaster     = "cursor_4c_ProdFor"
1939:             .ChildOrder     = "cprosdopes"
1940:             .RelationalExpr = "cpros"
1941: 
1942:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_OperaProd.dopes", ;
1943:                 127, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
1944:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_OperaProd.valos", ;
1945:                 80, "Valor Total", 2, "", "999,999,999.99")
1946:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_OperaProd.qtds", ;
1947:                 55, "Qtde.", 2, "", "999,999.999")
1948: 
1949:             .Column1.ColumnOrder = 1
1950:             .Column1.Alignment   = 3
1951:             .Column2.ColumnOrder = 3
1952:             .Column2.Alignment   = 3
1953:             .Column3.ColumnOrder = 2
1954:         ENDWITH
1955: 
1956:         *-- Mensagem1 / Mensagem2: aparecem quando a Analise de Vendas NAO foi
1957:         *-- pedida (Opt_Analise = 2), no lugar das duas grades de totais
1958:         par_oPage.AddObject("lbl_4c_Mensagem1", "Label")
1959:         WITH par_oPage.lbl_4c_Mensagem1
1960:             .Top       = 195
1961:             .Left      = 370

*-- Linhas 1999 a 2045:
1999:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2000:             .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2001:         ENDWITH
2002:         BINDEVENT(par_oPage.cmd_4c_ImprimirMov, "Click", THIS, "BtnImprimirMovClick")
2003: 
2004:         *-- OptSituas: filtro de situacao da grade de produtos
2005:         par_oPage.AddObject("obj_4c_OptSituas", "OptionGroup")
2006:         WITH par_oPage.obj_4c_OptSituas
2007:             .ButtonCount   = 3
2008:             .Top           = 9
2009:             .Left          = 434
2010:             .Width         = 197
2011:             .Height        = 26
2012:             .BackStyle     = 0
2013:             .SpecialEffect = 1
2014:             .Value         = 3
2015: 
2016:             WITH .Buttons(1)
2017:                 .Caption   = "Ativo"
2018:                 .Top       = 5
2019:                 .Left      = 9
2020:                 .Width     = 43
2021:                 .Height    = 15
2022:                 .AutoSize  = .F.
2023:                 .BackStyle = 0
2024:                 .FontName  = "Tahoma"
2025:                 .FontSize  = 8
2026:                 .ForeColor = RGB(90, 90, 90)
2027:             ENDWITH
2028: 
2029:             WITH .Buttons(2)
2030:                 .Caption   = "Inativo"
2031:                 .Top       = 5
2032:                 .Left      = 66
2033:                 .Width     = 52
2034:                 .Height    = 15
2035:                 .AutoSize  = .F.
2036:                 .BackStyle = 0
2037:                 .FontName  = "Tahoma"
2038:                 .FontSize  = 8
2039:                 .ForeColor = RGB(90, 90, 90)
2040:             ENDWITH
2041: 
2042:             WITH .Buttons(3)
2043:                 .Caption   = "Ambos"
2044:                 .Top       = 5
2045:                 .Left      = 130

*-- Linhas 2052 a 2347:
2052:                 .ForeColor = RGB(90, 90, 90)
2053:             ENDWITH
2054:         ENDWITH
2055:         BINDEVENT(par_oPage.obj_4c_OptSituas, "InteractiveChange", THIS, "OptSituasChange")
2056:     ENDPROC
2057: 
2058:     *==========================================================================
2059:     * ConfigurarAbaEstoque - Page "Estoque" do Result: produtos do fornecedor
2060:     * em poder das empresas + a foto do produto da linha selecionada.
2061:     *
2062:     * O olebcFigura (OleBoundControl) do legado NAO eh reproduzido: TODOS os
2063:     * caminhos de codigo do legado o deixam Visible = .F. e quem desenha a
2064:     * imagem eh o Image ImgFigJpg, a partir de um arquivo temporario.
2065:     *==========================================================================
2066:     PROTECTED PROCEDURE ConfigurarAbaEstoque(par_oPage)
2067:         LOCAL loc_oGrd
2068: 
2069:         par_oPage.AddObject("shp_4c_MoldEstoque", "Shape")
2070:         WITH par_oPage.shp_4c_MoldEstoque
2071:             .Top           = 27
2072:             .Left          = 13
2073:             .Width         = 239
2074:             .Height        = 360
2075:             .BackStyle     = 0
2076:             .SpecialEffect = 1
2077:         ENDWITH
2078: 
2079:         par_oPage.AddObject("lbl_4c_TitEstoque", "Label")
2080:         WITH par_oPage.lbl_4c_TitEstoque
2081:             .Top        = 13
2082:             .Left       = 22
2083:             .Width      = 133
2084:             .Height     = 15
2085:             .AutoSize   = .F.
2086:             .FontName   = "Tahoma"
2087:             .FontSize   = 8
2088:             .FontBold   = .T.
2089:             .FontItalic = .T.
2090:             .BackStyle  = 0
2091:             .Alignment  = 0
2092:             .ForeColor  = RGB(90, 90, 90)
2093:             .Caption    = "Produtos em seu poder"
2094:         ENDWITH
2095: 
2096:         par_oPage.AddObject("grd_4c_EstoqueProd", "Grid")
2097:         loc_oGrd = par_oPage.grd_4c_EstoqueProd
2098:         WITH loc_oGrd
2099:             .Top          = 34
2100:             .Left         = 18
2101:             .Width        = 229
2102:             .Height       = 346
2103:             .ColumnCount  = 2
2104:             THIS.FormatarGradeResultado(loc_oGrd)
2105:             .Highlight    = .T.
2106:             .HighlightRow = .T.
2107:             .RecordSource = "cursor_4c_Estoque"
2108: 
2109:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Estoque.cpros", ;
2110:                 108, "Produto", 2, "", "")
2111:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Estoque.sqtds", ;
2112:                 100, "Qtde.", 2, "", "99,999,999.999")
2113: 
2114:             .Column1.ColumnOrder = 1
2115:             .Column1.Alignment   = 3
2116:             .Column2.ColumnOrder = 2
2117:             .Column2.Alignment   = 3
2118:         ENDWITH
2119:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeEstoqueAfterRowColChange")
2120: 
2121:         par_oPage.AddObject("shp_4c_MoldFoto", "Shape")
2122:         WITH par_oPage.shp_4c_MoldFoto
2123:             .Top           = 27
2124:             .Left          = 251
2125:             .Width         = 181
2126:             .Height        = 138
2127:             .BackStyle     = 0
2128:             .SpecialEffect = 1
2129:         ENDWITH
2130: 
2131:         par_oPage.AddObject("img_4c_FotoProduto", "Image")
2132:         WITH par_oPage.img_4c_FotoProduto
2133:             .Top     = 32
2134:             .Left    = 255
2135:             .Width   = 172
2136:             .Height  = 129
2137:             .Stretch = 1
2138:             .Enabled = .F.
2139:             .Visible = .F.
2140:         ENDWITH
2141: 
2142:         par_oPage.AddObject("lbl_4c_MsgFotoProduto", "Label")
2143:         WITH par_oPage.lbl_4c_MsgFotoProduto
2144:             .Top       = 90
2145:             .Left      = 260
2146:             .Width     = 109
2147:             .Height    = 16
2148:             .AutoSize  = .F.
2149:             .FontBold  = .T.
2150:             .FontSize  = 8
2151:             .BackStyle = 0
2152:             .ForeColor = RGB(90, 90, 90)
2153:             .Caption   = "Foto n" + CHR(227) + "o dispon" + CHR(237) + "vel"
2154:             .Visible   = .F.
2155:         ENDWITH
2156:     ENDPROC
2157: 
2158:     *==========================================================================
2159:     * ConfigurarAbaConsertos - Page "Consertos" do Result: operacoes de
2160:     * conserto do fornecedor ainda nao baixadas.
2161:     *==========================================================================
2162:     PROTECTED PROCEDURE ConfigurarAbaConsertos(par_oPage)
2163:         LOCAL loc_oGrd
2164: 
2165:         par_oPage.AddObject("shp_4c_MoldConserto", "Shape")
2166:         WITH par_oPage.shp_4c_MoldConserto
2167:             .Top           = 27
2168:             .Left          = 7
2169:             .Width         = 663
2170:             .Height        = 289
2171:             .BackStyle     = 0
2172:             .SpecialEffect = 1
2173:         ENDWITH
2174: 
2175:         par_oPage.AddObject("lbl_4c_TitConserto", "Label")
2176:         WITH par_oPage.lbl_4c_TitConserto
2177:             .Top        = 12
2178:             .Left       = 17
2179:             .Width      = 122
2180:             .Height     = 15
2181:             .AutoSize   = .F.
2182:             .FontName   = "Tahoma"
2183:             .FontSize   = 8
2184:             .FontBold   = .T.
2185:             .FontItalic = .T.
2186:             .BackStyle  = 0
2187:             .Alignment  = 0
2188:             .ForeColor  = RGB(90, 90, 90)
2189:             .Caption    = "Consertos Pendentes"
2190:         ENDWITH
2191: 
2192:         par_oPage.AddObject("grd_4c_Conserto", "Grid")
2193:         loc_oGrd = par_oPage.grd_4c_Conserto
2194:         WITH loc_oGrd
2195:             .Top          = 37
2196:             .Left         = 11
2197:             .Width        = 654
2198:             .Height       = 275
2199:             .ColumnCount  = 4
2200:             THIS.FormatarGradeResultado(loc_oGrd)
2201:             .Highlight    = .T.
2202:             .HighlightRow = .T.
2203:             .RecordSource = "cursor_4c_Conserto"
2204: 
2205:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Conserto.datas", ;
2206:                 75, "Data", 2, "", "")
2207:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Conserto.emps", ;
2208:                 27, "Emp", 2, "", "")
2209:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Conserto.opers", ;
2210:                 130, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
2211:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Conserto.obscon", ;
2212:                 399, "Observa" + CHR(231) + CHR(227) + "o", 2, "", "")
2213: 
2214:             .Column1.ColumnOrder = 1
2215:             .Column1.Alignment   = 3
2216:             .Column2.ColumnOrder = 2
2217:             .Column2.Alignment   = 3
2218:             .Column3.ColumnOrder = 3
2219:             .Column3.Alignment   = 3
2220:             .Column4.ColumnOrder = 4
2221:         ENDWITH
2222:     ENDPROC
2223: 
2224:     *==========================================================================
2225:     * ConfigurarImprimeOpcoes - container "ImprimeOpcoes" do legado: painel
2226:     * flutuante (Visible = .F.) com as tres opcoes de abrangencia do
2227:     * relatorio e os botoes Visualizar / Imprimir / Sair. Top compensado
2228:     * (+29): legado 241 -> 270.
2229:     *
2230:     * Nasce invisivel e eh alternado por BtnImprimirMovClick / BtnSairOpcoes
2231:     * - por isso entra na lista de excecao de TornarControlesVisiveis.
2232:     *==========================================================================
2233:     PROTECTED PROCEDURE ConfigurarImprimeOpcoes(par_oPag)
2234:         LOCAL loc_oCnt
2235: 
2236:         par_oPag.AddObject("cnt_4c_ImprimeOpcoes", "Container")
2237:         loc_oCnt = par_oPag.cnt_4c_ImprimeOpcoes
2238:         WITH loc_oCnt
2239:             .Top           = 270
2240:             .Left          = 263
2241:             .Width         = 291
2242:             .Height        = 127
2243:             .BackStyle     = 1
2244:             .BackColor     = RGB(255, 255, 255)
2245:             .SpecialEffect = 0
2246:             .BorderWidth   = 1
2247:         ENDWITH
2248: 
2249:         loc_oCnt.AddObject("cmd_4c_VisualizarOpc", "CommandButton")
2250:         WITH loc_oCnt.cmd_4c_VisualizarOpc
2251:             .Top             = 8
2252:             .Left            = 164
2253:             .Width           = 40
2254:             .Height          = 40
2255:             .FontName        = "Verdana"
2256:             .FontSize        = 8
2257:             .WordWrap        = .T.
2258:             .Caption         = ""
2259:             .ToolTipText     = "Visualizar"
2260:             .ForeColor       = RGB(36, 84, 155)
2261:             .BackColor       = RGB(255, 255, 255)
2262:             .Themes          = .T.
2263:             .Picture         = gc_4c_CaminhoIcones + "kghostview.ico"
2264:             .DisabledPicture = gc_4c_CaminhoIcones + "kghostview.ico"
2265:         ENDWITH
2266:         BINDEVENT(loc_oCnt.cmd_4c_VisualizarOpc, "Click", THIS, "BtnVisualizarOpcoesClick")
2267: 
2268:         loc_oCnt.AddObject("cmd_4c_ImprimirOpc", "CommandButton")
2269:         WITH loc_oCnt.cmd_4c_ImprimirOpc
2270:             .Top             = 8
2271:             .Left            = 204
2272:             .Width           = 40
2273:             .Height          = 40
2274:             .FontName        = "Verdana"
2275:             .FontSize        = 8
2276:             .WordWrap        = .T.
2277:             .Caption         = ""
2278:             .ToolTipText     = "Imprimir"
2279:             .ForeColor       = RGB(36, 84, 155)
2280:             .BackColor       = RGB(255, 255, 255)
2281:             .Themes          = .T.
2282:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2283:             .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2284:         ENDWITH
2285:         BINDEVENT(loc_oCnt.cmd_4c_ImprimirOpc, "Click", THIS, "BtnImprimirOpcoesClick")
2286: 
2287:         loc_oCnt.AddObject("cmd_4c_SairOpc", "CommandButton")
2288:         WITH loc_oCnt.cmd_4c_SairOpc
2289:             .Top             = 8
2290:             .Left            = 244
2291:             .Width           = 40
2292:             .Height          = 40
2293:             .FontName        = "Verdana"
2294:             .FontSize        = 8
2295:             .WordWrap        = .T.
2296:             .Caption         = ""
2297:             .Cancel          = .T.
2298:             .ToolTipText     = "Sair"
2299:             .ForeColor       = RGB(36, 84, 155)
2300:             .BackColor       = RGB(255, 255, 255)
2301:             .Themes          = .T.
2302:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
2303:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
2304:         ENDWITH
2305:         BINDEVENT(loc_oCnt.cmd_4c_SairOpc, "Click", THIS, "BtnSairOpcoesClick")
2306: 
2307:         loc_oCnt.AddObject("obj_4c_Opcao", "OptionGroup")
2308:         WITH loc_oCnt.obj_4c_Opcao
2309:             .ButtonCount   = 3
2310:             .Top           = 53
2311:             .Left          = 49
2312:             .Width         = 191
2313:             .Height        = 64
2314:             .BackStyle     = 0
2315:             .BorderStyle   = 1
2316:             .SpecialEffect = 1
2317:             .Value         = 1
2318: 
2319:             WITH .Buttons(1)
2320:                 .Caption   = "Produto Selecionado"
2321:                 .Top       = 5
2322:                 .Left      = 5
2323:                 .Width     = 116
2324:                 .Height    = 15
2325:                 .AutoSize  = .F.
2326:                 .BackStyle = 0
2327:                 .FontName  = "Tahoma"
2328:                 .FontSize  = 8
2329:                 .ForeColor = RGB(90, 90, 90)
2330:             ENDWITH
2331: 
2332:             WITH .Buttons(2)
2333:                 .Caption   = "Todos os Produtos"
2334:                 .Top       = 24
2335:                 .Left      = 5
2336:                 .Width     = 107
2337:                 .Height    = 15
2338:                 .AutoSize  = .F.
2339:                 .BackStyle = 0
2340:                 .FontName  = "Tahoma"
2341:                 .FontSize  = 8
2342:                 .ForeColor = RGB(90, 90, 90)
2343:             ENDWITH
2344: 
2345:             WITH .Buttons(3)
2346:                 .Caption   = "Todos com Movimenta" + CHR(231) + CHR(227) + "o"
2347:                 .Top       = 43

*-- Linhas 2364 a 2407:
2364:     * Resultado), espelhando ThisForm.Fld_Principal.ActivePage = N do
2365:     * legado.
2366:     *==========================================================================
2367:     PROCEDURE AlternarPagina(par_nPagina)
2368:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2369: 
2370:         *-- Refresh em pagina OCULTA nao pinta: as grades do Resultado sao
2371:         *-- repintadas aqui, DEPOIS da troca de ActivePage, senao o usuario ve
2372:         *-- as grades vazias com os cursores cheios.
2373:         IF par_nPagina = 2
2374:             THIS.AtualizarGrades()
2375:         ENDIF
2376:     ENDPROC
2377: 
2378:     *==========================================================================
2379:     * ValidarFiltrosConsulta - Do Case comum aos dois botoes do
2380:     * grp_operacao (legado: cmd_cadastro.Click e cmd_movimenta.Click tem
2381:     * o MESMO bloco de validacao, so o que roda depois diverge). Grupo e
2382:     * Conta sao sempre obrigatorios e tem de existir em SigCdGcr/SigCdCli;
2383:     * quando Opt_Analise = 1 ("Sim"), Data Inicial/Moeda tambem se tornam
2384:     * obrigatorias e a Data Final nao pode ser anterior a Data Inicial.
2385:     *==========================================================================
2386:     PROTECTED FUNCTION ValidarFiltrosConsulta()
2387:         LOCAL loc_oPag, loc_oOrigem, loc_cGrupo, loc_cConta, loc_cMoeda, ;
2388:               loc_nResult, loc_oErro, loc_lValido, loc_lErroSql, loc_cMsg, loc_oFoco
2389: 
2390:         loc_oPag     = THIS.pgf_4c_Paginas.Page1
2391:         loc_oOrigem  = loc_oPag.cnt_4c_Origem
2392:         loc_cGrupo   = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
2393:         loc_cConta   = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
2394:         loc_cMoeda   = ALLTRIM(loc_oPag.txt_4c_Moeda.Value)
2395:         loc_lValido  = .T.
2396:         loc_lErroSql = .F.
2397:         loc_cMsg     = ""
2398:         loc_oFoco    = .NULL.
2399: 
2400:         TRY
2401:             IF loc_lValido AND EMPTY(loc_cGrupo)
2402:                 loc_lValido = .F.
2403:                 loc_cMsg    = "Grupo de Estoque Inv" + CHR(225) + "lido !!!"
2404:                 loc_oFoco   = loc_oOrigem.txt_4c_Grupo
2405:             ENDIF
2406: 
2407:             IF loc_lValido

*-- Linhas 2484 a 2527:
2484:             IF loc_lErroSql
2485:                 MsgErro(loc_cMsg, "Erro")
2486:             ELSE
2487:                 MsgAviso(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
2488:                 IF VARTYPE(loc_oFoco) = "O"
2489:                     loc_oFoco.SetFocus()
2490:                 ENDIF
2491:             ENDIF
2492:         ENDIF
2493: 
2494:         RETURN loc_lValido
2495:     ENDFUNC
2496: 
2497:     *==========================================================================
2498:     * ExecutarProcessamento - o "ThisForm.Processa" do legado visto pelos dois
2499:     * botoes do grp_operacao.
2500:     *
2501:     * O legado envolve TODO o corpo de Processa em "If !ThisForm.
2502:     * ConsultaExecutada": com os filtros inalterados desde a ultima consulta
2503:     * nada eh reconsultado nem repintado (os dados na tela ja sao os certos).
2504:     * Reproduzido aqui com o mesmo guard - cada handler de filtro zera a flag.
2505:     *
2506:     * Ordem: Buscar (dados cadastrais do fornecedor, TmpCli do legado) ->
2507:     * Processar (as 9 etapas de agregacao) -> BOParaForm + CarregarLista
2508:     * (a parte de UI do fim de Processa).
2509:     *==========================================================================
2510:     PROTECTED FUNCTION ExecutarProcessamento()
2511:         LOCAL loc_lOk
2512:         loc_lOk = .T.
2513: 
2514:         IF !THIS.this_oBusinessObject.this_lConsultaExecutada
2515:             THIS.FormParaBO()
2516: 
2517:             IF !THIS.this_oBusinessObject.Buscar( ;
2518:                     THIS.this_oBusinessObject.this_cGrupo, ;
2519:                     THIS.this_oBusinessObject.this_cConta)
2520:                 IF !THIS.this_oBusinessObject.this_lErroExibido
2521:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
2522:                 ENDIF
2523:                 loc_lOk = .F.
2524:             ENDIF
2525: 
2526:             IF loc_lOk
2527:                 IF !THIS.this_oBusinessObject.Processar()

*-- Linhas 2566 a 3520:
2566:     * OCULTA tambem nao pinta, por isso AlternarPagina(2) chama
2567:     * AtualizarGrades() novamente DEPOIS de trocar o ActivePage.
2568:     *==========================================================================
2569:     PROCEDURE CarregarLista()
2570:         LOCAL loc_lSucesso, loc_oErro, loc_oRes, loc_oMov, loc_cTitMoeda, ;
2571:               loc_lAnalise, loc_oPag1
2572: 
2573:         loc_lSucesso = .F.
2574: 
2575:         IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Result", 5)
2576:             RETURN .F.
2577:         ENDIF
2578: 
2579:         TRY
2580:             loc_oRes  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result
2581:             loc_oMov  = loc_oRes.Page3
2582:             loc_oPag1 = THIS.pgf_4c_Paginas.Page1
2583: 
2584:             loc_lAnalise = (loc_oPag1.obj_4c_Opt_Analise.Value = 1)
2585: 
2586:             *-- grades de totais x mensagens (legado: If lnAnalise = 1)
2587:             loc_oMov.grd_4c_Resumo.Visible    = loc_lAnalise
2588:             loc_oMov.grd_4c_OperaProd.Visible = loc_lAnalise
2589:             loc_oMov.lbl_4c_Mensagem1.Visible = !loc_lAnalise
2590:             loc_oMov.lbl_4c_Mensagem2.Visible = !loc_lAnalise
2591: 
2592:             *-- _TitMoeda do legado: a moeda do filtro entra entre parenteses
2593:             *-- no caption das tres colunas de valor
2594:             loc_cTitMoeda = ""
2595:             IF !EMPTY(ALLTRIM(loc_oPag1.txt_4c_Moeda.Value))
2596:                 loc_cTitMoeda = "(" + ALLTRIM(loc_oPag1.txt_4c_Moeda.Value) + ")"
2597:             ENDIF
2598: 
2599:             loc_oMov.grd_4c_Produto.Column6.Header1.Caption   = "Total Vendas" + loc_cTitMoeda
2600:             loc_oMov.grd_4c_OperaProd.Column2.Header1.Caption = "Valor Total" + loc_cTitMoeda
2601:             loc_oMov.grd_4c_Resumo.Column2.Header1.Caption    = "Valor Total" + loc_cTitMoeda
2602: 
2603:             THIS.AtualizarFotoFornecedor()
2604:             THIS.AtualizarGrades()
2605: 
2606:             loc_oRes.ActivePage = 1
2607:             loc_lSucesso = .T.
2608:         CATCH TO loc_oErro
2609:             MsgErro(loc_oErro.Message + CHR(13) + ;
2610:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2611:                 "Procedure: " + loc_oErro.Procedure, "Erro ao exibir o resultado")
2612:         ENDTRY
2613: 
2614:         RETURN loc_lSucesso
2615:     ENDPROC
2616: 
2617:     *==========================================================================
2618:     * AtualizarGrades - GO TOP em cada cursor + Refresh de cada grade. Metodo
2619:     * UNICO, chamado de CarregarLista e de AlternarPagina(2) - esta ultima
2620:     * porque Refresh em pagina oculta nao pinta, e a Pagina Resultado so fica
2621:     * visivel DEPOIS da troca de ActivePage.
2622:     *==========================================================================
2623:     PROCEDURE AtualizarGrades()
2624:         LOCAL loc_oRes, loc_oErro
2625: 
2626:         IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Result", 5)
2627:             RETURN
2628:         ENDIF
2629: 
2630:         TRY
2631:             THIS.this_oBusinessObject.PosicionarCursores()
2632: 
2633:             loc_oRes = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result
2634: 
2635:             loc_oRes.Page1.grd_4c_Saldo.Refresh()
2636:             loc_oRes.Page1.grd_4c_Historico.Refresh()
2637:             loc_oRes.Page1.txt_4c_Hists.Refresh()
2638:             loc_oRes.Page1.txt_4c_Hist2s.Refresh()
2639:             loc_oRes.Page2.grd_4c_Pendente.Refresh()
2640:             loc_oRes.Page3.grd_4c_Produto.Refresh()
2641:             loc_oRes.Page3.grd_4c_Resumo.Refresh()
2642:             loc_oRes.Page3.grd_4c_OperaProd.Refresh()
2643:             loc_oRes.Page4.grd_4c_EstoqueProd.Refresh()
2644:             loc_oRes.Page5.grd_4c_Conserto.Refresh()
2645: 
2646:             *-- foto do produto da linha corrente da aba Estoque (o legado
2647:             *-- dispara "Result.Estoque.Grd_Produto.AfterRowColChange" a mao)
2648:             THIS.GradeEstoqueAfterRowColChange(1)
2649:         CATCH TO loc_oErro
2650:             MsgErro(loc_oErro.Message + CHR(13) + ;
2651:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao atualizar as grades")
2652:         ENDTRY
2653:     ENDPROC
2654: 
2655:     *==========================================================================
2656:     * MostrarBlocoCadastro / MostrarBlocoMovimento - o par de blocos "With
2657:     * ThisForm.Fld_Principal.Pag_Resultado" do legado, que alterna a Pagina
2658:     * Resultado entre o cadastro do fornecedor e o resultado da consulta, e
2659:     * troca qual botao de navegacao (Cmd_MudaFor / Cmd_MudaMov) fica visivel.
2660:     *
2661:     * fChecaAcesso decide se o botao de ida pode aparecer, como no legado.
2662:     *==========================================================================
2663:     PROTECTED PROCEDURE MostrarBlocoCadastro()
2664:         LOCAL loc_oPag2
2665: 
2666:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2667: 
2668:         loc_oPag2.cnt_4c_Cadastro.Visible = .T.
2669:         loc_oPag2.cnt_4c_Cadastro.Enabled = .T.
2670:         loc_oPag2.pgf_4c_Result.Visible   = .F.
2671:         loc_oPag2.pgf_4c_Result.Enabled   = .F.
2672: 
2673:         loc_oPag2.cmg_4c_MudaFor.Visible = .F.
2674:         loc_oPag2.cmg_4c_MudaFor.Enabled = .F.
2675: 
2676:         IF fChecaAcesso("SIGOPCGC", "MOVIMENTA")
2677:             loc_oPag2.cmg_4c_MudaMov.Visible = .T.
2678:             loc_oPag2.cmg_4c_MudaMov.Enabled = .T.
2679:         ENDIF
2680:     ENDPROC
2681: 
2682:     PROTECTED PROCEDURE MostrarBlocoMovimento()
2683:         LOCAL loc_oPag2
2684: 
2685:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2686: 
2687:         loc_oPag2.cnt_4c_Cadastro.Visible = .F.
2688:         loc_oPag2.cnt_4c_Cadastro.Enabled = .F.
2689:         loc_oPag2.pgf_4c_Result.Visible   = .T.
2690:         loc_oPag2.pgf_4c_Result.Enabled   = .T.
2691: 
2692:         loc_oPag2.cmg_4c_MudaMov.Visible = .F.
2693:         loc_oPag2.cmg_4c_MudaMov.Enabled = .F.
2694: 
2695:         IF fChecaAcesso("SIGOPCGC", "CADASTRO")
2696:             loc_oPag2.cmg_4c_MudaFor.Visible = .T.
2697:             loc_oPag2.cmg_4c_MudaFor.Enabled = .T.
2698:         ENDIF
2699:     ENDPROC
2700: 
2701:     *==========================================================================
2702:     * AtualizarFotoFornecedor - bloco "With .Pag_Resultado.Cadastro" do fim de
2703:     * Processa: a foto so aparece quando o GRUPO de contas esta marcado para
2704:     * exibir foto (CrSigCdGcr.mfotos = 1); sem foto, mostra o aviso "Foto nao
2705:     * disponivel"; com o grupo sem foto, esconde moldura, imagem e aviso.
2706:     *
2707:     * CLEAR RESOURCES antes de atribuir o .Picture eh do legado e eh
2708:     * necessario: sem ele o VFP reaproveita a imagem em cache do arquivo
2709:     * temporario anterior e a tela mostra a foto do fornecedor errado.
2710:     *==========================================================================
2711:     PROTECTED PROCEDURE AtualizarFotoFornecedor()
2712:         LOCAL loc_oCad, loc_cArquivo
2713: 
2714:         loc_oCad = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cadastro
2715: 
2716:         IF THIS.this_oBusinessObject.this_nMFotos != 1
2717:             loc_oCad.shp_4c_Figura.Visible  = .F.
2718:             loc_oCad.img_4c_Figura.Visible  = .F.
2719:             loc_oCad.img_4c_Figura.Picture  = ""
2720:             loc_oCad.lbl_4c_MsgFoto.Visible = .F.
2721:             RETURN
2722:         ENDIF
2723: 
2724:         loc_oCad.shp_4c_Figura.Visible = .T.
2725:         loc_cArquivo = THIS.this_oBusinessObject.ObterArquivoFotoFornecedor()
2726: 
2727:         IF EMPTY(loc_cArquivo)
2728:             loc_oCad.img_4c_Figura.Visible  = .F.
2729:             loc_oCad.img_4c_Figura.Picture  = ""
2730:             loc_oCad.lbl_4c_MsgFoto.Visible = .T.
2731:         ELSE
2732:             CLEAR RESOURCES
2733:             loc_oCad.img_4c_Figura.Picture  = loc_cArquivo
2734:             loc_oCad.img_4c_Figura.Visible  = .T.
2735:             loc_oCad.lbl_4c_MsgFoto.Visible = .F.
2736:         ENDIF
2737:     ENDPROC
2738: 
2739:     *==========================================================================
2740:     * BtnCadastroClick - botao "Dados Cadastrais" do grp_operacao (Page1).
2741:     * Legado (cmd_cadastro.Click): valida Grupo/Conta/periodo/moeda, poe
2742:     * pcMensagem = .T. (nao avisa fornecedor sem informacao), roda Processa e
2743:     * abre a Pagina Resultado no bloco de CADASTRO do fornecedor.
2744:     *==========================================================================
2745:     PROCEDURE BtnCadastroClick()
2746:         IF !THIS.ValidarFiltrosConsulta()
2747:             RETURN
2748:         ENDIF
2749: 
2750:         THIS.this_oBusinessObject.this_lMensagem = .T.
2751: 
2752:         IF !THIS.ExecutarProcessamento()
2753:             RETURN
2754:         ENDIF
2755: 
2756:         THIS.MostrarBlocoCadastro()
2757:         THIS.AlternarPagina(2)
2758:     ENDPROC
2759: 
2760:     *==========================================================================
2761:     * BtnMovimentoClick - botao "Movimentacao" do grp_operacao (Page1).
2762:     * Legado (cmd_movimenta.Click): MESMA validacao do botao de cadastro, poe
2763:     * pcMensagem = .F. (avisa quando o fornecedor nao tem informacao nenhuma),
2764:     * roda Processa, abre a Pagina Resultado direto no bloco de RESULTADO,
2765:     * RECONFIGURA as grades de Saldo/Historico (o numero de colunas depende da
2766:     * permissao de SALDO) e posiciona o historico no lancamento mais recente.
2767:     *==========================================================================
2768:     PROCEDURE BtnMovimentoClick()
2769:         LOCAL loc_oErro
2770: 
2771:         IF !THIS.ValidarFiltrosConsulta()
2772:             RETURN
2773:         ENDIF
2774: 
2775:         THIS.this_oBusinessObject.this_lMensagem = .F.
2776: 
2777:         IF !THIS.ExecutarProcessamento()
2778:             RETURN
2779:         ENDIF
2780: 
2781:         THIS.MostrarBlocoMovimento()
2782: 
2783:         *-- O legado refaz a configuracao das duas grades da aba Saldo a cada
2784:         *-- clique neste botao (ColumnCount depende da permissao) - mexer em
2785:         *-- ColumnCount recria as Column, por isso ControlSource/Width/Header
2786:         *-- sao reaplicados dentro de ConfigurarGradesSaldo.
2787:         THIS.ConfigurarGradesSaldo()
2788: 
2789:         THIS.AlternarPagina(2)
2790: 
2791:         *-- "Select dbHistorico / Go Bottom" do legado: o extrato abre no
2792:         *-- lancamento mais RECENTE. Tem de vir DEPOIS de AlternarPagina, que
2793:         *-- chama AtualizarGrades -> PosicionarCursores (GO TOP em todos os
2794:         *-- cursores) - antes dela, o GO TOP desfaria este GO BOTTOM.
2795:         IF USED("cursor_4c_Historico")
2796:             SELECT cursor_4c_Historico
2797:             GO BOTTOM
2798:         ENDIF
2799: 
2800:         TRY
2801:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.Refresh()
2802:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.SetFocus()
2803:         CATCH TO loc_oErro
2804:             *-- SetFocus falha quando a grade ainda nao esta visivel; eh so o
2805:             *-- foco inicial, nao afeta o conteudo exibido
2806:         ENDTRY
2807:     ENDPROC
2808: 
2809:     *==========================================================================
2810:     * BtnCancelarClick - botao "Encerrar" do grp_operacao (Page1), que no
2811:     * legado eh o objeto cmd_cancela (Cancel = .T., ou seja tambem responde ao
2812:     * ESC) e cujo Click eh apenas "ThisForm.Release".
2813:     *==========================================================================
2814:     PROCEDURE BtnCancelarClick()
2815:         THIS.Release()
2816:     ENDPROC
2817: 
2818:     *==========================================================================
2819:     * BtnVoltarClick - grp_operacao da Page2 (botao unico). Legado:
2820:     * If ThisForm.Automatico / ThisForm.Release / Else / ThisForm.
2821:     * Fld_Principal.ActivePage = 1 / EndIf. No modo Automatico (form aberto
2822:     * por outra tela, com Grupo/Conta recebidos por parametro) nao ha pagina
2823:     * de Consulta para onde voltar - a tela fecha.
2824:     *==========================================================================
2825:     PROCEDURE BtnVoltarClick()
2826:         IF THIS.this_oBusinessObject.this_lAutomatico
2827:             THIS.Release()
2828:         ELSE
2829:             THIS.AlternarPagina(1)
2830:         ENDIF
2831:     ENDPROC
2832: 
2833:     *==========================================================================
2834:     * BtnMudaForClick - mostra o bloco de CADASTRO do fornecedor e oculta o
2835:     * resultado da consulta (legado Cmd_MudaFor.cmd_cadastro.Click, que ainda
2836:     * poe pcMensagem = .T.).
2837:     *==========================================================================
2838:     PROCEDURE BtnMudaForClick()
2839:         THIS.this_oBusinessObject.this_lMensagem = .T.
2840:         THIS.LockScreen = .T.
2841:         THIS.MostrarBlocoCadastro()
2842:         THIS.LockScreen = .F.
2843:     ENDPROC
2844: 
2845:     *==========================================================================
2846:     * BtnMudaMovClick - mostra o RESULTADO da consulta e oculta o cadastro
2847:     * (legado Cmd_MudaMov.cmd_movimenta.Click, que ainda poe
2848:     * pcMensagem = .F.).
2849:     *==========================================================================
2850:     PROCEDURE BtnMudaMovClick()
2851:         THIS.this_oBusinessObject.this_lMensagem = .F.
2852:         THIS.LockScreen = .T.
2853:         THIS.MostrarBlocoMovimento()
2854:         THIS.LockScreen = .F.
2855:         THIS.AtualizarGrades()
2856:     ENDPROC
2857: 
2858:     *==========================================================================
2859:     * GradeSaldoAfterRowColChange - AfterRowColChange de grd_saldo: trocar de
2860:     * moeda na grade mae repinta a grade filha de historico (a relacao filtra
2861:     * por moeda).
2862:     *==========================================================================
2863:     PROCEDURE GradeSaldoAfterRowColChange(par_nColIndex)
2864:         LOCAL loc_oErro
2865: 
2866:         TRY
2867:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.Refresh()
2868:         CATCH TO loc_oErro
2869:             MsgErro(loc_oErro.Message, "Erro")
2870:         ENDTRY
2871:     ENDPROC
2872: 
2873:     *==========================================================================
2874:     * GradeHistoricoAfterRowColChange - AfterRowColChange de grd_historico:
2875:     * os dois campos de historico abaixo da grade acompanham a linha corrente.
2876:     *==========================================================================
2877:     PROCEDURE GradeHistoricoAfterRowColChange(par_nColIndex)
2878:         LOCAL loc_oPage, loc_oErro
2879: 
2880:         TRY
2881:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1
2882:             loc_oPage.txt_4c_Hists.Refresh()
2883:             loc_oPage.txt_4c_Hist2s.Refresh()
2884:         CATCH TO loc_oErro
2885:             MsgErro(loc_oErro.Message, "Erro")
2886:         ENDTRY
2887:     ENDPROC
2888: 
2889:     *==========================================================================
2890:     * GradeEstoqueAfterRowColChange - AfterRowColChange da grade da aba
2891:     * Estoque: carrega a foto do produto da linha corrente (SigCdPro.figjpgs
2892:     * gravado num arquivo temporario) ou mostra "Foto nao disponivel".
2893:     *==========================================================================
2894:     PROCEDURE GradeEstoqueAfterRowColChange(par_nColIndex)
2895:         LOCAL loc_oPage, loc_cArquivo, loc_cProduto, loc_oErro
2896: 
2897:         TRY
2898:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page4
2899: 
2900:             loc_cProduto = ""
2901:             IF USED("cursor_4c_Estoque") AND !EOF("cursor_4c_Estoque")
2902:                 loc_cProduto = cursor_4c_Estoque.cpros
2903:             ENDIF
2904: 
2905:             loc_cArquivo = ""
2906:             IF !EMPTY(ALLTRIM(loc_cProduto))
2907:                 loc_cArquivo = THIS.this_oBusinessObject.CarregarFotoProduto(loc_cProduto)
2908:             ENDIF
2909: 
2910:             IF EMPTY(loc_cArquivo)
2911:                 loc_oPage.img_4c_FotoProduto.Visible    = .F.
2912:                 loc_oPage.img_4c_FotoProduto.Picture    = ""
2913:                 loc_oPage.lbl_4c_MsgFotoProduto.Visible = .T.
2914:             ELSE
2915:                 CLEAR RESOURCES
2916:                 loc_oPage.img_4c_FotoProduto.Picture    = loc_cArquivo
2917:                 loc_oPage.img_4c_FotoProduto.Visible    = .T.
2918:                 loc_oPage.lbl_4c_MsgFotoProduto.Visible = .F.
2919:             ENDIF
2920:         CATCH TO loc_oErro
2921:             MsgErro(loc_oErro.Message + CHR(13) + ;
2922:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao carregar a foto")
2923:         ENDTRY
2924:     ENDPROC
2925: 
2926:     *==========================================================================
2927:     * OptSituasChange - InteractiveChange de OptSituas: filtra a grade de
2928:     * produtos por situacao (1 = Ativo, 2 = Inativo, 3 = Ambos / sem filtro).
2929:     * Transcrito do legado, inclusive o GO TOP + Refresh no fim (sem eles a
2930:     * grade continua mostrando a pagina antiga).
2931:     *==========================================================================
2932:     PROCEDURE OptSituasChange()
2933:         LOCAL loc_oPage, loc_nValor, loc_oErro
2934: 
2935:         *-- Guarda ANTES do TRY: RETURN dentro de TRY/CATCH eh proibido (o
2936:         *-- VFP9 nao garante o desvio e o bloco fica abandonado).
2937:         IF !USED("cursor_4c_ProdFor")
2938:             RETURN
2939:         ENDIF
2940: 
2941:         TRY
2942:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page3
2943:             loc_nValor = loc_oPage.obj_4c_OptSituas.Value
2944: 
2945:             SELECT cursor_4c_ProdFor
2946:             IF loc_nValor != 3
2947:                 IF loc_nValor = 1
2948:                     SET FILTER TO situas = 1
2949:                 ELSE
2950:                     SET FILTER TO situas = 2
2951:                 ENDIF
2952:             ELSE
2953:                 SET FILTER TO
2954:             ENDIF
2955: 
2956:             GO TOP IN cursor_4c_ProdFor
2957:             loc_oPage.grd_4c_Produto.Refresh()
2958:         CATCH TO loc_oErro
2959:             MsgErro(loc_oErro.Message, "Erro")
2960:         ENDTRY
2961:     ENDPROC
2962: 
2963:     *==========================================================================
2964:     * OrdenarGradeProdutos - corpo comum aos 8 handlers de Click/DblClick dos
2965:     * headers da grade de produtos: o legado troca a ordem corrente do cursor
2966:     * (Click = ascendente, DblClick = descendente) e repinta a grade.
2967:     *==========================================================================
2968:     PROTECTED PROCEDURE OrdenarGradeProdutos(par_cTag, par_lDescendente)
2969:         LOCAL loc_oErro
2970: 
2971:         IF !USED("cursor_4c_ProdFor")
2972:             RETURN
2973:         ENDIF
2974: 
2975:         TRY
2976:             SELECT cursor_4c_ProdFor
2977:             IF par_lDescendente
2978:                 SET ORDER TO (par_cTag) DESCENDING
2979:             ELSE
2980:                 SET ORDER TO (par_cTag) ASCENDING
2981:             ENDIF
2982:             GO TOP IN cursor_4c_ProdFor
2983:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page3.grd_4c_Produto.Refresh()
2984:         CATCH TO loc_oErro
2985:             MsgErro(loc_oErro.Message, "Erro")
2986:         ENDTRY
2987:     ENDPROC
2988: 
2989:     PROCEDURE HeaderProdutoClick()
2990:         THIS.OrdenarGradeProdutos("cpros", .F.)
2991:     ENDPROC
2992: 
2993:     PROCEDURE HeaderProdutoDblClick()
2994:         THIS.OrdenarGradeProdutos("cpros", .T.)
2995:     ENDPROC
2996: 
2997:     PROCEDURE HeaderQtVendClick()
2998:         THIS.OrdenarGradeProdutos("qtvend", .F.)
2999:     ENDPROC
3000: 
3001:     PROCEDURE HeaderQtVendDblClick()
3002:         THIS.OrdenarGradeProdutos("qtvend", .T.)
3003:     ENDPROC
3004: 
3005:     PROCEDURE HeaderVlVendClick()
3006:         THIS.OrdenarGradeProdutos("vlvend", .F.)
3007:     ENDPROC
3008: 
3009:     PROCEDURE HeaderVlVendDblClick()
3010:         THIS.OrdenarGradeProdutos("vlvend", .T.)
3011:     ENDPROC
3012: 
3013:     PROCEDURE HeaderReffsClick()
3014:         THIS.OrdenarGradeProdutos("reffs", .F.)
3015:     ENDPROC
3016: 
3017:     PROCEDURE HeaderReffsDblClick()
3018:         THIS.OrdenarGradeProdutos("reffs", .T.)
3019:     ENDPROC
3020: 
3021:     *==========================================================================
3022:     * BtnImprimirExtratoClick - btnImprimir da aba Saldo. Legado:
3023:     *   Do Form SigReCgc With Get_Grupo.Value, Get_Conta.Value
3024:     * O relatorio migrado eh FormSigReCgc, cujo Init recebe (grupo, conta).
3025:     *==========================================================================
3026:     PROCEDURE BtnImprimirExtratoClick()
3027:         LOCAL loc_oForm, loc_oOrigem, loc_oErro
3028: 
3029:         loc_oForm = .NULL.
3030: 
3031:         TRY
3032:             loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3033:             loc_oForm   = CREATEOBJECT("FormSigReCgc", ;
3034:                 ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value), ;
3035:                 ALLTRIM(loc_oOrigem.txt_4c_Conta.Value))
3036:         CATCH TO loc_oErro
3037:             loc_oForm = .NULL.
3038:             MsgErro("Erro ao abrir o relat" + CHR(243) + "rio:" + CHR(13) + ;
3039:                 loc_oErro.Message, "Erro")
3040:         ENDTRY
3041: 
3042:         *-- Show() FORA do TRY: form modal faz o Show BLOQUEAR, e com ele
3043:         *-- dentro do TRY qualquer erro de runtime da tela aberta cairia neste
3044:         *-- CATCH, a referencia LOCAL seria perdida e o form fecharia sozinho.
3045:         IF VARTYPE(loc_oForm) = "O"
3046:             loc_oForm.Show()
3047:         ENDIF
3048:     ENDPROC
3049: 
3050:     *==========================================================================
3051:     * BtnImprimirMovClick - botao Imprimir da aba Movimentacao. Legado: NAO
3052:     * imprime nada ainda - desabilita a tela e abre o painel ImprimeOpcoes,
3053:     * onde o usuario escolhe a abrangencia e so entao visualiza ou imprime.
3054:     * A opcao "Produto Selecionado" so fica disponivel quando ha produto na
3055:     * linha corrente da grade.
3056:     *==========================================================================
3057:     PROCEDURE BtnImprimirMovClick()
3058:         LOCAL loc_oPag1, loc_oPag2, loc_lTemProduto, loc_oCnt
3059: 
3060:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
3061:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
3062:         loc_oCnt  = loc_oPag2.cnt_4c_ImprimeOpcoes
3063: 
3064:         loc_oPag1.Enabled                 = .F.
3065:         loc_oPag2.pgf_4c_Result.Enabled   = .F.
3066:         loc_oPag2.cmg_4c_MudaMov.Enabled  = .F.
3067:         loc_oPag2.cmg_4c_MudaFor.Enabled  = .F.
3068:         loc_oPag2.cnt_4c_BotoesAcao.Enabled = .F.
3069: 
3070:         loc_lTemProduto = .F.
3071:         IF USED("cursor_4c_ProdFor") AND !EOF("cursor_4c_ProdFor")
3072:             loc_lTemProduto = !EMPTY(ALLTRIM(cursor_4c_ProdFor.cpros))
3073:         ENDIF
3074: 
3075:         loc_oCnt.obj_4c_Opcao.Buttons(1).Enabled = loc_lTemProduto
3076:         loc_oCnt.obj_4c_Opcao.Value              = IIF(loc_lTemProduto, 1, 2)
3077:         loc_oCnt.Visible                         = .T.
3078:     ENDPROC
3079: 
3080:     *==========================================================================
3081:     * ReabilitarAposImpressao - o bloco de 6 linhas que o legado repete nos
3082:     * tres botoes do painel ImprimeOpcoes (Visualizar, Imprimir e Sair), para
3083:     * devolver a tela ao estado normal e fechar o painel.
3084:     *==========================================================================
3085:     PROTECTED PROCEDURE ReabilitarAposImpressao()
3086:         LOCAL loc_oPag1, loc_oPag2
3087: 
3088:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
3089:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
3090: 
3091:         loc_oPag1.Enabled                   = .T.
3092:         loc_oPag2.pgf_4c_Result.Enabled     = .T.
3093:         loc_oPag2.cmg_4c_MudaMov.Enabled    = .T.
3094:         loc_oPag2.cmg_4c_MudaFor.Enabled    = .T.
3095:         loc_oPag2.cnt_4c_BotoesAcao.Enabled = .T.
3096:         loc_oPag2.cnt_4c_ImprimeOpcoes.Visible = .F.
3097:     ENDPROC
3098: 
3099:     *==========================================================================
3100:     * BtnVisualizarOpcoesClick / BtnImprimirOpcoesClick - botoes Visualizar e
3101:     * Imprimir do painel ImprimeOpcoes. Legado: ThisForm.ProcImp() monta
3102:     * TmpRelat/TmpFinal, "Report Form SIGOPCGC Preview|To Print Prompt",
3103:     * libera os dois cursores e reabilita a tela.
3104:     *==========================================================================
3105:     PROCEDURE BtnVisualizarOpcoesClick()
3106:         THIS.ExecutarImpressao("PREVIEW")
3107:     ENDPROC
3108: 
3109:     PROCEDURE BtnImprimirOpcoesClick()
3110:         THIS.ExecutarImpressao("PRINTER_PROMPT")
3111:     ENDPROC
3112: 
3113:     PROTECTED PROCEDURE ExecutarImpressao(par_cModo)
3114:         LOCAL loc_oPag2, loc_nOpcao, loc_nFiltro
3115: 
3116:         loc_oPag2   = THIS.pgf_4c_Paginas.Page2
3117:         loc_nOpcao  = loc_oPag2.cnt_4c_ImprimeOpcoes.obj_4c_Opcao.Value
3118:         loc_nFiltro = loc_oPag2.pgf_4c_Result.Page3.obj_4c_OptSituas.Value
3119: 
3120:         THIS.FormParaBO()
3121: 
3122:         IF THIS.this_oBusinessObject.PrepararDadosImpressao(loc_nOpcao, loc_nFiltro)
3123:             THIS.this_oBusinessObject.ExecutarRelatorio(par_cModo)
3124:         ENDIF
3125: 
3126:         THIS.this_oBusinessObject.LiberarCursoresImpressao()
3127:         THIS.ReabilitarAposImpressao()
3128:     ENDPROC
3129: 
3130:     *==========================================================================
3131:     * BtnSairOpcoesClick - botao Sair do painel ImprimeOpcoes: so fecha o
3132:     * painel e devolve a tela ao estado normal.
3133:     *==========================================================================
3134:     PROCEDURE BtnSairOpcoesClick()
3135:         THIS.ReabilitarAposImpressao()
3136:     ENDPROC
3137: 
3138:     *==========================================================================
3139:     * AplicarPermissoes - bloco de fChecaAcesso do Init do legado, que esconde
3140:     * os botoes que o usuario nao pode acionar:
3141:     *   sem CADASTRO   -> some o botao "Dados Cadastrais" e os dois botoes de
3142:     *                     troca de bloco da Pagina Resultado;
3143:     *   sem MOVIMENTA  -> some o botao "Movimentacao" e os mesmos dois;
3144:     *   sem IMPRIMIR   -> some o botao de impressao do extrato (aba Saldo).
3145:     *
3146:     * O legado ainda reposiciona o CommandGroup (Left + 81 / Width - 81) a
3147:     * cada botao escondido, para a fileira nao ficar com buraco - transcrito.
3148:     *==========================================================================
3149:     PROTECTED PROCEDURE AplicarPermissoes()
3150:         LOCAL loc_oPag1, loc_oPag2, loc_oGrupo
3151: 
3152:         loc_oPag1  = THIS.pgf_4c_Paginas.Page1
3153:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2
3154:         loc_oGrupo = loc_oPag1.cnt_4c_Botoes.cmg_4c_Operacao
3155: 
3156:         IF !fChecaAcesso("SIGOPCGC", "CADASTRO")
3157:             loc_oPag2.cmg_4c_MudaMov.Visible = .F.
3158:             loc_oPag2.cmg_4c_MudaMov.Enabled = .F.
3159:             loc_oPag2.cmg_4c_MudaFor.Visible = .F.
3160:             loc_oPag2.cmg_4c_MudaFor.Enabled = .F.
3161: 
3162:             *-- Buttons(3) = cmd_cadastro no legado
3163:             loc_oGrupo.Buttons(3).Visible = .F.
3164:             loc_oGrupo.Buttons(3).Enabled = .F.
3165:             loc_oGrupo.Buttons(1).Left    = loc_oGrupo.Buttons(1).Left - 81
3166:             loc_oGrupo.Buttons(2).Left    = loc_oGrupo.Buttons(2).Left - 81
3167:             loc_oGrupo.Width              = loc_oGrupo.Width - 81
3168:             loc_oGrupo.Left               = loc_oGrupo.Left  + 81
3169:         ENDIF
3170: 
3171:         IF !fChecaAcesso("SIGOPCGC", "MOVIMENTA")
3172:             loc_oPag2.cmg_4c_MudaMov.Visible = .F.
3173:             loc_oPag2.cmg_4c_MudaMov.Enabled = .F.
3174:             loc_oPag2.cmg_4c_MudaFor.Visible = .F.
3175:             loc_oPag2.cmg_4c_MudaFor.Enabled = .F.
3176: 
3177:             *-- Buttons(1) = cmd_movimenta no legado
3178:             loc_oGrupo.Buttons(1).Visible = .F.
3179:             loc_oGrupo.Buttons(1).Enabled = .F.
3180:             loc_oGrupo.Buttons(2).Left    = loc_oGrupo.Buttons(2).Left - 81
3181:             loc_oGrupo.Width              = loc_oGrupo.Width - 81
3182:             loc_oGrupo.Left               = loc_oGrupo.Left  + 81
3183:         ENDIF
3184: 
3185:         IF !fChecaAcesso("SIGOPCGC", "IMPRIMIR")
3186:             loc_oPag2.pgf_4c_Result.Page1.cmd_4c_ImprimirExtrato.Visible = .F.
3187:         ENDIF
3188:     ENDPROC
3189: 
3190:     *==========================================================================
3191:     * OptAnaliseChange - InteractiveChange de obj_4c_Opt_Analise (Page1).
3192:     * Legado: os When de Get_DataI/Get_DataF/Get_Moeda/Get_Empresa so
3193:     * retornam .T. (campo habilitado) quando Opt_Analise.Value = 1 ("Sim");
3194:     * o Valid de Opt_Analise ainda limpa os 4 campos quando Value = 2.
3195:     *==========================================================================
3196:     PROCEDURE OptAnaliseChange()
3197:         LOCAL loc_oPag, loc_lHabilita
3198: 
3199:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3200: 
3201:         loc_oPag      = THIS.pgf_4c_Paginas.Page1
3202:         loc_lHabilita = (loc_oPag.obj_4c_Opt_Analise.Value = 1)
3203: 
3204:         loc_oPag.txt_4c_Datai.Enabled   = loc_lHabilita
3205:         loc_oPag.txt_4c_Dataf.Enabled   = loc_lHabilita
3206:         loc_oPag.txt_4c_Moeda.Enabled   = loc_lHabilita
3207:         loc_oPag.txt_4c_Empresa.Enabled = loc_lHabilita
3208: 
3209:         IF !loc_lHabilita
3210:             loc_oPag.txt_4c_Datai.Value   = {}
3211:             loc_oPag.txt_4c_Dataf.Value   = {}
3212:             loc_oPag.txt_4c_Moeda.Value   = ""
3213:             loc_oPag.txt_4c_Empresa.Value = ""
3214:         ENDIF
3215:     ENDPROC
3216: 
3217:     *==========================================================================
3218:     * ValidarDataI - KeyPress de txt_4c_Datai (Page1). Legado (Get_Datai.
3219:     * Valid): se Get_DataF estiver vazio, preenche com GoMonth(DataI, 1).
3220:     *==========================================================================
3221:     PROCEDURE ValidarDataI(par_nKeyCode, par_nShiftAltCtrl)
3222:         LOCAL loc_oPag
3223: 
3224:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3225: 
3226:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3227:             RETURN
3228:         ENDIF
3229: 
3230:         loc_oPag = THIS.pgf_4c_Paginas.Page1
3231:         IF EMPTY(loc_oPag.txt_4c_Dataf.Value) AND !EMPTY(loc_oPag.txt_4c_Datai.Value)
3232:             loc_oPag.txt_4c_Dataf.Value = GOMONTH(loc_oPag.txt_4c_Datai.Value, 1)
3233:         ENDIF
3234:     ENDPROC
3235: 
3236:     *==========================================================================
3237:     * ValidarDataF - KeyPress de txt_4c_Dataf (Page1). Legado (Get_Dataf.
3238:     * InteractiveChange): ThisForm.ConsultaExecutada = .F. - sem validacao
3239:     * de valor no Valid, so invalida o cache da ultima consulta.
3240:     *==========================================================================
3241:     PROCEDURE ValidarDataF(par_nKeyCode, par_nShiftAltCtrl)
3242:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3243:     ENDPROC
3244: 
3245:     *==========================================================================
3246:     * ValidarMoeda - KeyPress de txt_4c_Moeda (Page1). Legado (Get_Moeda.
3247:     * Valid): fwbuscaext em SigCdMoe.cmoes - aqui com match exato via
3248:     * SQLEXEC e fallback no picker AbrirBuscaMoeda().
3249:     *==========================================================================
3250:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
3251:         LOCAL loc_cVal, loc_nResult, loc_oErro
3252: 
3253:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3254: 
3255:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3256:             RETURN
3257:         ENDIF
3258: 
3259:         loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value)
3260:         IF EMPTY(loc_cVal)
3261:             RETURN
3262:         ENDIF
3263: 
3264:         TRY
3265:             IF USED("cursor_4c_MoedaVal")
3266:                 USE IN cursor_4c_MoedaVal
3267:             ENDIF
3268:             loc_nResult = SQLEXEC(gnConnHandle, ;
3269:                 "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cVal), ;
3270:                 "cursor_4c_MoedaVal")
3271:             IF loc_nResult > 0 AND USED("cursor_4c_MoedaVal") AND !EOF("cursor_4c_MoedaVal")
3272:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_MoedaVal.cmoes)
3273:             ELSE
3274:                 THIS.AbrirBuscaMoeda()
3275:             ENDIF
3276:             IF USED("cursor_4c_MoedaVal")
3277:                 USE IN cursor_4c_MoedaVal
3278:             ENDIF
3279:         CATCH TO loc_oErro
3280:             MsgErro(loc_oErro.Message, "Erro")
3281:         ENDTRY
3282:     ENDPROC
3283: 
3284:     *==========================================================================
3285:     * AbrirBuscaMoeda - picker por cmoes/dmoes em SigCdMoe
3286:     *==========================================================================
3287:     PROCEDURE AbrirBuscaMoeda()
3288:         LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_lProsseguir, loc_oErro
3289: 
3290:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value)
3291: 
3292:         IF USED("cursor_4c_BuscaMoeda")
3293:             USE IN cursor_4c_BuscaMoeda
3294:         ENDIF
3295: 
3296:         loc_lProsseguir = .T.
3297:         TRY
3298:             IF EMPTY(loc_cValor)
3299:                 loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe ORDER BY cmoes"
3300:             ELSE
3301:                 loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
3302:                            "WHERE cmoes LIKE " + EscaparSQL(loc_cValor + "%") + ;
3303:                            " OR RTRIM(dmoes) LIKE " + EscaparSQL(loc_cValor + "%") + ;
3304:                            " ORDER BY cmoes"
3305:             ENDIF
3306:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda")
3307: 
3308:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaMoeda") OR RECCOUNT("cursor_4c_BuscaMoeda") = 0) ;
3309:                     AND !EMPTY(loc_cValor)
3310:                 IF USED("cursor_4c_BuscaMoeda")
3311:                     USE IN cursor_4c_BuscaMoeda
3312:                 ENDIF
3313:                 loc_nResult = SQLEXEC(gnConnHandle, ;
3314:                     "SELECT cmoes, dmoes FROM SigCdMoe ORDER BY cmoes", "cursor_4c_BuscaMoeda")
3315:             ENDIF
3316: 
3317:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaMoeda") OR RECCOUNT("cursor_4c_BuscaMoeda") = 0
3318:                 MsgAviso("Nenhuma moeda encontrada.", "Moedas")
3319:                 loc_lProsseguir = .F.
3320:             ENDIF
3321: 
3322:             IF loc_lProsseguir
3323:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3324:                 IF VARTYPE(loc_oBusca) = "O"
3325:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMoeda"
3326:                     loc_oBusca.this_cTitulo        = "Moedas"
3327:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Moedas"
3328:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = "Moedas"
3329:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3330:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3331:                     loc_oBusca.Show()
3332:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
3333:                         SELECT cursor_4c_BuscaMoeda
3334:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
3335:                     ELSE
3336:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ""
3337:                     ENDIF
3338:                     loc_oBusca.Release()
3339:                 ENDIF
3340:             ELSE
3341:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ""
3342:             ENDIF
3343:         CATCH TO loc_oErro
3344:             MsgErro(loc_oErro.Message, "Erro")
3345:         ENDTRY
3346: 
3347:         IF USED("cursor_4c_BuscaMoeda")
3348:             USE IN cursor_4c_BuscaMoeda
3349:         ENDIF
3350:     ENDPROC
3351: 
3352:     *==========================================================================
3353:     * ValidarEmpresa - KeyPress de txt_4c_Empresa (Page1). Legado (Get_
3354:     * Empresa.Valid): fAcessoEmpresa(Usuar,'C',This.Value,This.Parent.
3355:     * Get_Empresa) - fAcessoEmpresa NAO foi portada (regra CLAUDE.md), aqui
3356:     * substituida por match exato em SigCdEmp.Cemps + VerificarAcessoEmpresa
3357:     * (modo check) + fallback no picker AbrirBuscaEmpresa().
3358:     *==========================================================================
3359:     PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
3360:         LOCAL loc_cVal, loc_nResult, loc_oErro
3361: 
3362:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3363: 
3364:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3365:             RETURN
3366:         ENDIF
3367: 
3368:         loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
3369:         IF EMPTY(loc_cVal)
3370:             RETURN
3371:         ENDIF
3372: 
3373:         TRY
3374:             IF USED("cursor_4c_EmpVal")
3375:                 USE IN cursor_4c_EmpVal
3376:             ENDIF
3377:             loc_nResult = SQLEXEC(gnConnHandle, ;
3378:                 "SELECT TOP 1 Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
3379:                 "cursor_4c_EmpVal")
3380:             IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
3381:                 IF !VerificarAcessoEmpresa(gc_4c_UsuarioLogado, ALLTRIM(cursor_4c_EmpVal.Cemps))
3382:                     MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3383:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3384:                 ELSE
3385:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_EmpVal.Cemps)
3386:                 ENDIF
3387:             ELSE
3388:                 THIS.AbrirBuscaEmpresa()
3389:             ENDIF
3390:             IF USED("cursor_4c_EmpVal")
3391:                 USE IN cursor_4c_EmpVal
3392:             ENDIF
3393:         CATCH TO loc_oErro
3394:             MsgErro(loc_oErro.Message, "Erro")
3395:         ENDTRY
3396:     ENDPROC
3397: 
3398:     *==========================================================================
3399:     * AbrirBuscaEmpresa - picker por Cemps/Razas em SigCdEmp
3400:     *==========================================================================
3401:     PROCEDURE AbrirBuscaEmpresa()
3402:         LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_lProsseguir, loc_oErro, loc_cTitulo
3403: 
3404:         loc_cValor  = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
3405:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"
3406: 
3407:         IF USED("cursor_4c_BuscaEmp")
3408:             USE IN cursor_4c_BuscaEmp
3409:         ENDIF
3410: 
3411:         loc_lProsseguir = .T.
3412:         TRY
3413:             IF EMPTY(loc_cValor)
3414:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
3415:             ELSE
3416:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
3417:                            "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
3418:                            " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
3419:                            " ORDER BY Cemps"
3420:             ENDIF
3421:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
3422: 
3423:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0) ;
3424:                     AND !EMPTY(loc_cValor)
3425:                 IF USED("cursor_4c_BuscaEmp")
3426:                     USE IN cursor_4c_BuscaEmp
3427:                 ENDIF
3428:                 loc_nResult = SQLEXEC(gnConnHandle, ;
3429:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", "cursor_4c_BuscaEmp")
3430:             ENDIF
3431: 
3432:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0
3433:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
3434:                 loc_lProsseguir = .F.
3435:             ENDIF
3436: 
3437:             IF loc_lProsseguir
3438:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3439:                 IF VARTYPE(loc_oBusca) = "O"
3440:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
3441:                     loc_oBusca.this_cTitulo        = loc_cTitulo
3442:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
3443:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
3444:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
3445:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
3446:                     loc_oBusca.Show()
3447:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
3448:                         SELECT cursor_4c_BuscaEmp
3449:                         IF VerificarAcessoEmpresa(gc_4c_UsuarioLogado, ALLTRIM(cursor_4c_BuscaEmp.Cemps))
3450:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
3451:                         ELSE
3452:                             MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3453:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3454:                         ENDIF
3455:                     ELSE
3456:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3457:                     ENDIF
3458:                     loc_oBusca.Release()
3459:                 ENDIF
3460:             ELSE
3461:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3462:             ENDIF
3463:         CATCH TO loc_oErro
3464:             MsgErro(loc_oErro.Message, "Erro")
3465:         ENDTRY
3466: 
3467:         IF USED("cursor_4c_BuscaEmp")
3468:             USE IN cursor_4c_BuscaEmp
3469:         ENDIF
3470:     ENDPROC
3471: 
3472:     *==========================================================================
3473:     * ValidarGrupo - KeyPress de txt_4c_Grupo (container cnt_4c_Origem,
3474:     * Page1). Legado (Origem.Get_grupo.Valid): fAcessoContab(...) + Seek em
3475:     * CrSigCdGcr + ajusta Left/Width/Visible de Get_DConta/Get_Cpf conforme
3476:     * CrSigCdGcr.tpcads (1 = mostra CPF e encolhe DConta; != 1 = esconde CPF
3477:     * e DConta ocupa a largura toda). fAcessoContab ja esta portada em
3478:     * utils\functions.prg (abre o picker internamente quando nao acha).
3479:     *==========================================================================
3480:     PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
3481:         LOCAL loc_oOrigem, loc_cVal, loc_nResult, loc_oErro
3482: 
3483:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3484: 
3485:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3486:             RETURN
3487:         ENDIF
3488: 
3489:         loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3490:         loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3491: 
3492:         IF EMPTY(loc_cVal)
3493:             RETURN
3494:         ENDIF
3495: 
3496:         TRY
3497:             fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cVal, loc_oOrigem.txt_4c_Grupo)
3498: 
3499:             loc_cVal = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3500:             IF !EMPTY(loc_cVal)
3501:                 IF USED("cursor_4c_GrpVal")
3502:                     USE IN cursor_4c_GrpVal
3503:                 ENDIF
3504:                 loc_nResult = SQLEXEC(gnConnHandle, ;
3505:                     "SELECT TOP 1 tpcads FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cVal), ;
3506:                     "cursor_4c_GrpVal")
3507:                 IF loc_nResult > 0 AND USED("cursor_4c_GrpVal") AND !EOF("cursor_4c_GrpVal")
3508:                     IF cursor_4c_GrpVal.tpcads = 1
3509:                         loc_oOrigem.txt_4c_Dconta.Left  = 326
3510:                         loc_oOrigem.txt_4c_Dconta.Width = 278
3511:                         loc_oOrigem.lbl_4c__dConta.Left = 329
3512:                         loc_oOrigem.txt_4c_Cpf.Visible   = .T.
3513:                         loc_oOrigem.lbl_4c__CPF.Visible  = .T.
3514:                     ELSE
3515:                         loc_oOrigem.txt_4c_Dconta.Left  = 177
3516:                         loc_oOrigem.txt_4c_Dconta.Width = 427
3517:                         loc_oOrigem.lbl_4c__dConta.Left = 180
3518:                         loc_oOrigem.txt_4c_Cpf.Visible   = .F.
3519:                         loc_oOrigem.lbl_4c__CPF.Visible  = .F.
3520:                     ENDIF

*-- Linhas 3527 a 3820:
3527:             MsgErro(loc_oErro.Message, "Erro")
3528:         ENDTRY
3529:     ENDPROC
3530: 
3531:     *==========================================================================
3532:     * ValidarConta - KeyPress de txt_4c_Conta (container cnt_4c_Origem,
3533:     * Page1). Legado (Origem.Get_conta.Valid): fAcessoContas(...) valida o
3534:     * acesso e preenche Get_DConta; em caso de sucesso, CursorQuery em
3535:     * SigCdCli completa Grupo (se vazio) e Cpf.
3536:     *==========================================================================
3537:     PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
3538:         LOCAL loc_oOrigem, loc_cVal, loc_cGrupo, loc_nResult, loc_oErro
3539: 
3540:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3541: 
3542:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3543:             RETURN
3544:         ENDIF
3545: 
3546:         loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3547:         loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
3548:         loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3549: 
3550:         IF EMPTY(loc_cVal)
3551:             loc_oOrigem.txt_4c_Dconta.Value = ""
3552:             loc_oOrigem.txt_4c_Cpf.Value    = ""
3553:             RETURN
3554:         ENDIF
3555: 
3556:         TRY
3557:             IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cVal, ;
3558:                     loc_oOrigem.txt_4c_Conta, loc_oOrigem.txt_4c_Dconta)
3559:                 MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3560:                 loc_oOrigem.txt_4c_Conta.Value  = ""
3561:                 loc_oOrigem.txt_4c_Dconta.Value = ""
3562:                 loc_oOrigem.txt_4c_Cpf.Value    = ""
3563:             ELSE
3564:                 loc_cVal = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
3565:                 IF !EMPTY(loc_cVal)
3566:                     IF USED("cursor_4c_CtaVal")
3567:                         USE IN cursor_4c_CtaVal
3568:                     ENDIF
3569:                     loc_nResult = SQLEXEC(gnConnHandle, ;
3570:                         "SELECT TOP 1 grupos, cpfs FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cVal), ;
3571:                         "cursor_4c_CtaVal")
3572:                     IF loc_nResult > 0 AND USED("cursor_4c_CtaVal") AND !EOF("cursor_4c_CtaVal")
3573:                         IF EMPTY(loc_oOrigem.txt_4c_Grupo.Value)
3574:                             loc_oOrigem.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_CtaVal.grupos)
3575:                         ENDIF
3576:                         loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_CtaVal.cpfs)
3577:                     ENDIF
3578:                     IF USED("cursor_4c_CtaVal")
3579:                         USE IN cursor_4c_CtaVal
3580:                     ENDIF
3581:                 ENDIF
3582:             ENDIF
3583:         CATCH TO loc_oErro
3584:             MsgErro(loc_oErro.Message, "Erro")
3585:         ENDTRY
3586:     ENDPROC
3587: 
3588:     *==========================================================================
3589:     * ValidarDConta - KeyPress de txt_4c_Dconta (container cnt_4c_Origem,
3590:     * Page1). Legado (Origem.Get_dconta.Valid): fAcessoContas(...,'D',...)
3591:     * busca pelo NOME e preenche Get_Conta; mesmo complemento de Grupo/Cpf
3592:     * via CursorQuery do ValidarConta.
3593:     *==========================================================================
3594:     PROCEDURE ValidarDConta(par_nKeyCode, par_nShiftAltCtrl)
3595:         LOCAL loc_oOrigem, loc_cVal, loc_cGrupo, loc_nResult, loc_oErro
3596: 
3597:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3598: 
3599:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3600:             RETURN
3601:         ENDIF
3602: 
3603:         loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3604:         loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Dconta.Value)
3605:         loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3606: 
3607:         IF EMPTY(loc_cVal)
3608:             loc_oOrigem.txt_4c_Conta.Value = ""
3609:             loc_oOrigem.txt_4c_Cpf.Value   = ""
3610:             RETURN
3611:         ENDIF
3612: 
3613:         TRY
3614:             IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cVal, ;
3615:                     loc_oOrigem.txt_4c_Conta, loc_oOrigem.txt_4c_Dconta)
3616:                 MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3617:                 loc_oOrigem.txt_4c_Conta.Value  = ""
3618:                 loc_oOrigem.txt_4c_Dconta.Value = ""
3619:                 loc_oOrigem.txt_4c_Cpf.Value    = ""
3620:             ELSE
3621:                 loc_cVal = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
3622:                 IF !EMPTY(loc_cVal)
3623:                     IF USED("cursor_4c_CtaVal")
3624:                         USE IN cursor_4c_CtaVal
3625:                     ENDIF
3626:                     loc_nResult = SQLEXEC(gnConnHandle, ;
3627:                         "SELECT TOP 1 grupos, cpfs FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cVal), ;
3628:                         "cursor_4c_CtaVal")
3629:                     IF loc_nResult > 0 AND USED("cursor_4c_CtaVal") AND !EOF("cursor_4c_CtaVal")
3630:                         IF EMPTY(loc_oOrigem.txt_4c_Grupo.Value)
3631:                             loc_oOrigem.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_CtaVal.grupos)
3632:                         ENDIF
3633:                         loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_CtaVal.cpfs)
3634:                     ENDIF
3635:                     IF USED("cursor_4c_CtaVal")
3636:                         USE IN cursor_4c_CtaVal
3637:                     ENDIF
3638:                 ENDIF
3639:             ENDIF
3640:         CATCH TO loc_oErro
3641:             MsgErro(loc_oErro.Message, "Erro")
3642:         ENDTRY
3643:     ENDPROC
3644: 
3645:     *==========================================================================
3646:     * ValidarCpf - KeyPress de txt_4c_Cpf (container cnt_4c_Origem, Page1).
3647:     * Legado (Origem.Get_cpf.Valid): fwbuscaext em SigCdCli.cpfs (aqui via
3648:     * FormBuscaAuxiliar - mAddColuna cpfs/iclis/rclis) + fAcessoContas para
3649:     * validar o acesso ao registro escolhido e preencher Conta/DConta.
3650:     *==========================================================================
3651:     PROCEDURE ValidarCpf(par_nKeyCode, par_nShiftAltCtrl)
3652:         LOCAL loc_oOrigem, loc_cVal, loc_cGrupo, loc_oBusca, loc_oErro
3653: 
3654:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3655: 
3656:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3657:             RETURN
3658:         ENDIF
3659: 
3660:         loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3661:         loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Cpf.Value)
3662:         loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3663: 
3664:         IF EMPTY(loc_cVal)
3665:             loc_oOrigem.txt_4c_Dconta.Value = ""
3666:             loc_oOrigem.txt_4c_Conta.Value  = ""
3667:             RETURN
3668:         ENDIF
3669: 
3670:         TRY
3671:             IF USED("cursor_4c_BuscaCpf")
3672:                 USE IN cursor_4c_BuscaCpf
3673:             ENDIF
3674: 
3675:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
3676:                 "cursor_4c_BuscaCpf", "cpfs", loc_cVal, "Fornecedores")
3677: 
3678:             IF VARTYPE(loc_oBusca) = "O"
3679:                 IF !loc_oBusca.this_lAchouRegistro
3680:                     loc_oBusca.mAddColuna("cpfs",  "", "CPF / CGC")
3681:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
3682:                     loc_oBusca.mAddColuna("rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
3683:                     loc_oBusca.Show()
3684:                 ENDIF
3685: 
3686:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
3687:                     SELECT cursor_4c_BuscaCpf
3688:                     loc_cVal = ALLTRIM(cursor_4c_BuscaCpf.iclis)
3689: 
3690:                     IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cVal, ;
3691:                             loc_oOrigem.txt_4c_Conta, loc_oOrigem.txt_4c_Dconta)
3692:                         MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3693:                         loc_oOrigem.txt_4c_Cpf.Value    = ""
3694:                         loc_oOrigem.txt_4c_Conta.Value  = ""
3695:                         loc_oOrigem.txt_4c_Dconta.Value = ""
3696:                     ELSE
3697:                         loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCpf.cpfs)
3698:                     ENDIF
3699:                 ENDIF
3700:                 loc_oBusca.Release()
3701:             ENDIF
3702: 
3703:             IF USED("cursor_4c_BuscaCpf")
3704:                 USE IN cursor_4c_BuscaCpf
3705:             ENDIF
3706:         CATCH TO loc_oErro
3707:             MsgErro(loc_oErro.Message, "Erro")
3708:         ENDTRY
3709:     ENDPROC
3710: 
3711:     *==========================================================================
3712:     * FormParaBO - Transfere filtros da Page1 para o Business Object
3713:     *==========================================================================
3714:     PROCEDURE FormParaBO()
3715:         LOCAL loc_oPag, loc_oOrigem
3716: 
3717:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
3718:         loc_oOrigem = loc_oPag.cnt_4c_Origem
3719: 
3720:         WITH THIS.this_oBusinessObject
3721:             .this_nAnalise = loc_oPag.obj_4c_Opt_Analise.Value
3722:             .this_dDataI   = ConverterParaData(loc_oPag.txt_4c_Datai.Value)
3723:             .this_dDataF   = ConverterParaData(loc_oPag.txt_4c_Dataf.Value)
3724:             .this_cMoeda   = ALLTRIM(loc_oPag.txt_4c_Moeda.Value)
3725:             .this_cEmpresa = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)
3726: 
3727:             .this_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3728:             .this_cConta  = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
3729:             .this_cDConta = ALLTRIM(loc_oOrigem.txt_4c_Dconta.Value)
3730:             .this_cCpf    = ALLTRIM(loc_oOrigem.txt_4c_Cpf.Value)
3731:         ENDWITH
3732:     ENDPROC
3733: 
3734:     *==========================================================================
3735:     * BOParaForm - Transfere os dados cadastrais do fornecedor pesquisado
3736:     * (Business Object) para os TextBoxes de cnt_4c_Cadastro (Page2).
3737:     *==========================================================================
3738:     PROCEDURE BOParaForm()
3739:         LOCAL loc_oCad
3740: 
3741:         loc_oCad = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cadastro
3742: 
3743:         WITH THIS.this_oBusinessObject
3744:             loc_oCad.txt_4c_CodFor.Value = .this_cCodFor
3745:             loc_oCad.txt_4c_Nome.Value   = .this_cNome
3746:             loc_oCad.txt_4c_End.Value    = .this_cEnd
3747:             loc_oCad.txt_4c_Bairro.Value = .this_cBairro
3748:             loc_oCad.txt_4c_Cep.Value    = .this_cCep
3749:             loc_oCad.txt_4c_Cid.Value    = .this_cCid
3750:             loc_oCad.txt_4c_Est.Value    = .this_cEst
3751:             loc_oCad.txt_4c_Tel1.Value   = .this_cTel1
3752:             loc_oCad.txt_4c_Tel2.Value   = .this_cTel2
3753:             loc_oCad.txt_4c_Fax.Value    = .this_cFax
3754:             loc_oCad.txt_4c_Cgc.Value    = .this_cCgc
3755:             loc_oCad.txt_4c_Ie.Value     = .this_cIe
3756:         ENDWITH
3757:     ENDPROC
3758: 
3759:     *==========================================================================
3760:     * TornarControlesVisiveis - Torna visiveis os controles criados via
3761:     * AddObject (que nascem com Visible=.F.), recursivamente em Pages e
3762:     * Containers. cmg_4c_MudaFor comeca Visible=.F. de proposito (igual ao
3763:     * legado: so um dos Cmd_MudaFor/Cmd_MudaMov fica visivel por vez,
3764:     * alternado por BtnMudaForClick/BtnMudaMovClick) e img_4c_Figura comeca
3765:     * Visible=.F. porque SigCdCli nao tem coluna de foto (fica so o aviso
3766:     * "Foto nao disponivel") - pular esses nomes SEM deixar de recursar nos
3767:     * filhos deles (regra CLAUDE.md "Form OPERACIONAL / Containers
3768:     * Flutuantes").
3769:     *==========================================================================
3770:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3771:         LOCAL loc_nI, loc_oObjeto, loc_nP, loc_lPularVisible
3772: 
3773:         IF VARTYPE(par_oContainer) != "O"
3774:             RETURN
3775:         ENDIF
3776: 
3777:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3778:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3779: 
3780:             *-- Controles que NASCEM ocultos no legado e sao revelados por
3781:             *-- codigo. O LOOP nao eh usado aqui de proposito: pular o
3782:             *-- objeto sem recursar deixaria os FILHOS dele com Visible = .F.
3783:             *-- para sempre, e o container apareceria VAZIO quando revelado.
3784:             *--   CMG_4C_MUDAFOR / CMG_4C_MUDAMOV - so um por vez, alternados
3785:             *--   PGF_4C_RESULT         - a Pagina Resultado abre no cadastro
3786:             *--   CNT_4C_IMPRIMEOPCOES  - painel de opcoes de impressao
3787:             *--   GRD_4C_PENDENTEOCULTA - Grid1 do legado, nunca exibida
3788:             *--   IMG_4C_FIGURA / IMG_4C_FOTOPRODUTO - so com foto disponivel
3789:             *--   LBL_4C_MSGFOTO / LBL_4C_MSGFOTOPRODUTO - so SEM foto
3790:             *--   LBL_4C_MENSAGEM1 / 2 - so sem Analise de Vendas
3791:             loc_lPularVisible = INLIST(UPPER(loc_oObjeto.Name), ;
3792:                 "CMG_4C_MUDAFOR", "CMG_4C_MUDAMOV", "PGF_4C_RESULT", ;
3793:                 "CNT_4C_IMPRIMEOPCOES", "GRD_4C_PENDENTEOCULTA", ;
3794:                 "IMG_4C_FIGURA", "IMG_4C_FOTOPRODUTO", "LBL_4C_MSGFOTO", ;
3795:                 "LBL_4C_MSGFOTOPRODUTO", "LBL_4C_MENSAGEM1", "LBL_4C_MENSAGEM2")
3796: 
3797:             IF !loc_lPularVisible AND PEMSTATUS(loc_oObjeto, "Visible", 5)
3798:                 loc_oObjeto.Visible = .T.
3799:             ENDIF
3800: 
3801:             IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3802:                 FOR loc_nP = 1 TO loc_oObjeto.PageCount
3803:                     THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3804:                 ENDFOR
3805:             ELSE
3806:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3807:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3808:                 ENDIF
3809:             ENDIF
3810:         ENDFOR
3811:     ENDPROC
3812: 
3813:     *==========================================================================
3814:     * DESTROY - delega para FormBase.Destroy (restaura menu apos fechamento)
3815:     *==========================================================================
3816:     PROCEDURE Destroy()
3817:         RETURN DODEFAULT()
3818:     ENDPROC
3819: 
3820: ENDDEFINE

