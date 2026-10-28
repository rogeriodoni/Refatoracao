# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (28)
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3822 linhas total):

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

*-- Linhas 1479 a 1963:
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
1565:         loc_oGrdH.ColumnCount  = IIF(loc_lSaldo, 8, 7)
1566:         loc_oGrdH.ColumnCount = 3
1567:         loc_oGrdH.RecordSource = "cursor_4c_Historico"
1568:         WITH loc_oGrdH
1569:             THIS.FormatarGradeResultado(loc_oGrdH)
1570:             .Width          = 588
1571:             .LinkMaster     = "cursor_4c_Saldo"
1572:             .ChildOrder     = "moedata"
1573:             .RelationalExpr = "moedas"
1574: 
1575:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Historico.emps", ;
1576:                 31, "Emp", 2, "", "")
1577:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Historico.datas", ;
1578:                 80, "Data", 2, "", "")
1579:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Historico.valors", ;
1580:                 94, "Valor", 2, "9,999,999.99", "9,999,999.99")
1581:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Historico.opers", ;
1582:                 18, "O", 2, "", "")
1583: 
1584:             IF loc_lSaldo
1585:                 THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_Historico.saldos", ;
1586:                     94, "Saldo", 2, "9,999,999.99", "9,999,999.99")
1587:                 THIS.ConfigurarColunaResultado(.Column6, "cursor_4c_Historico.vencs", ;
1588:                     80, "Vencimento", 2, "", "")
1589:                 THIS.ConfigurarColunaResultado(.Column7, "cursor_4c_Historico.nfs", ;
1590:                     80, "Nota", 2, "", "")
1591:                 THIS.ConfigurarColunaResultado(.Column8, ;
1592:                     "IIF(cursor_4c_Historico.valors - cursor_4c_Historico.valpags = 0, '*', '')", ;
1593:                     20, "Pg", 2, "", "")
1594:             ELSE
1595:                 THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_Historico.vencs", ;
1596:                     80, "Vencimento", 2, "", "")
1597:                 THIS.ConfigurarColunaResultado(.Column6, "cursor_4c_Historico.nfs", ;
1598:                     80, "Nota", 2, "", "")
1599:                 THIS.ConfigurarColunaResultado(.Column7, ;
1600:                     "IIF(cursor_4c_Historico.valors - cursor_4c_Historico.valpags = 0, '*', '')", ;
1601:                     20, "Pg", 2, "", "")
1602:             ENDIF
1603:         ENDWITH
1604: 
1605:         *---------------------------------------------------------------
1606:         *-- Grade de SALDO POR MOEDA (grade mae)
1607:         *---------------------------------------------------------------
1608:         loc_oGrdS.ColumnCount  = IIF(loc_lSaldo, 2, 1)
1609:         loc_oGrdS.ColumnCount = 3
1610:         loc_oGrdS.RecordSource = "cursor_4c_Saldo"
1611:         WITH loc_oGrdS
1612:             THIS.FormatarGradeResultado(loc_oGrdS)
1613:             .Width        = IIF(loc_lSaldo, 156, 156 - 94)
1614: 
1615:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Saldo.moedas", ;
1616:                 31, "M.", 2, "", "")
1617: 
1618:             IF loc_lSaldo
1619:                 THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Saldo.saldos", ;
1620:                     94, "Saldo", 2, "", "")
1621:             ENDIF
1622:         ENDWITH
1623: 
1624:         *-- moldura e titulo acompanham o numero de colunas (legado)
1625:         loc_oPage.shp_4c_MoldSaldo.Width = IIF(loc_lSaldo, 165, 165 - 94)
1626:         loc_oPage.lbl_4c_TitSaldo.Caption = IIF(loc_lSaldo, "Saldo por Moeda", "Moedas")
1627:     ENDPROC
1628: 
1629:     *==========================================================================
1630:     * ConfigurarColunaResultado - aplica de uma vez as propriedades que toda
1631:     * coluna de grade de resultado recebe. A Width eh atribuida DEPOIS do
1632:     * ControlSource de proposito: mexer no ControlSource reseta a largura para
1633:     * o default 90.
1634:     *==========================================================================
1635:     PROTECTED PROCEDURE ConfigurarColunaResultado(par_oCol, par_cFonte, ;
1636:             par_nWidth, par_cCaption, par_nAlinhaHeader, par_cFormat, par_cMask)
1637:         WITH par_oCol
1638:             .ControlSource = par_cFonte
1639:             .Width         = par_nWidth
1640:             .Movable       = .F.
1641:             .Resizable     = .F.
1642:             .ReadOnly      = .T.
1643:             .FontName      = "Tahoma"
1644:             .FontSize      = 8
1645: 
1646:             IF !EMPTY(par_cFormat)
1647:                 .Format = par_cFormat
1648:             ENDIF
1649:             IF !EMPTY(par_cMask)
1650:                 .InputMask = par_cMask
1651:             ENDIF
1652: 
1653:             .Header1.Caption   = par_cCaption
1654:             .Header1.Alignment = par_nAlinhaHeader
1655:             .Header1.FontName  = "Tahoma"
1656:             .Header1.FontSize  = 8
1657:             .Header1.ForeColor = RGB(90, 90, 90)
1658: 
1659:             .Text1.BorderStyle = 0
1660:             .Text1.Margin      = 0
1661:             .Text1.ReadOnly    = .T.
1662:         ENDWITH
1663:     ENDPROC
1664: 
1665:     *==========================================================================
1666:     * ConfigurarAbaPendencias - Page "Pendencias" do Result: parcelas e
1667:     * lancamentos de conta corrente em aberto (cursor_4c_Parcela).
1668:     *
1669:     * Grid1 do legado (a grade de baixo) nasce Visible = .F. / Enabled = .F.
1670:     * com TODAS as colunas invisiveis - eh um resto de layout que o legado
1671:     * nunca mostra. Reproduzida para nao perder objeto da tela, e por isso
1672:     * entra na lista de excecao de TornarControlesVisiveis.
1673:     *==========================================================================
1674:     PROTECTED PROCEDURE ConfigurarAbaPendencias(par_oPage)
1675:         LOCAL loc_oGrd
1676: 
1677:         par_oPage.AddObject("shp_4c_MoldPendencias", "Shape")
1678:         WITH par_oPage.shp_4c_MoldPendencias
1679:             .Top           = 17
1680:             .Left          = 9
1681:             .Width         = 663
1682:             .Height        = 199
1683:             .BackStyle     = 0
1684:             .SpecialEffect = 1
1685:         ENDWITH
1686: 
1687:         par_oPage.AddObject("lbl_4c_TitPendencias", "Label")
1688:         WITH par_oPage.lbl_4c_TitPendencias
1689:             .Top        = 3
1690:             .Left       = 20
1691:             .Width      = 66
1692:             .Height     = 15
1693:             .AutoSize   = .F.
1694:             .FontName   = "Tahoma"
1695:             .FontSize   = 8
1696:             .FontBold   = .T.
1697:             .FontItalic = .T.
1698:             .BackStyle  = 0
1699:             .Alignment  = 0
1700:             .ForeColor  = RGB(90, 90, 90)
1701:             .Caption    = "Pend" + CHR(234) + "ncias"
1702:         ENDWITH
1703: 
1704:         par_oPage.AddObject("grd_4c_Pendente", "Grid")
1705:         loc_oGrd = par_oPage.grd_4c_Pendente
1706:         loc_oGrd.ColumnCount  = 4
1707:         loc_oGrd.RecordSource = "cursor_4c_Parcela"
1708:         WITH loc_oGrd
1709:             .Top               = 23
1710:             .Left              = 14
1711:             .Width             = 652
1712:             .Height            = 184
1713:             .AllowHeaderSizing = .F.
1714:             .AllowRowSizing    = .F.
1715:             THIS.FormatarGradeResultado(loc_oGrd)
1716: 
1717:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Parcela.valos", ;
1718:                 77, "Valor", 2, "", "999,999,999.99")
1719:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Parcela.moefpgs", ;
1720:                 30, "Moe", 2, "", "")
1721:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Parcela.vencs", ;
1722:                 90, "Vecto", 2, "", "")
1723:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Parcela.hists", ;
1724:                 370, "Tipo", 2, "", "")
1725: 
1726:             .Column1.ColumnOrder = 2
1727:             .Column2.ColumnOrder = 3
1728:             .Column3.ColumnOrder = 1
1729:             .Column4.ColumnOrder = 4
1730:         ENDWITH
1731: 
1732:         *-- Grid1 do legado: oculta e desabilitada, mantida por fidelidade
1733:         par_oPage.AddObject("grd_4c_PendenteOculta", "Grid")
1734:         loc_oGrd = par_oPage.grd_4c_PendenteOculta
1735:         loc_oGrd.ColumnCount  = 5
1736:         loc_oGrd.RecordSource = "cursor_4c_Parcela"
1737:         WITH loc_oGrd
1738:             .Top               = 222
1739:             .Left              = 5
1740:             .Width             = 557
1741:             .Height            = 166
1742:             .AllowHeaderSizing = .F.
1743:             .AllowRowSizing    = .F.
1744:             THIS.FormatarGradeResultado(loc_oGrd)
1745: 
1746:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Parcela.fpags", ;
1747:                 177, "Tipo", 2, "", "")
1748:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Parcela.valos", ;
1749:                 77, "Valor", 2, "", "999,999,999.99")
1750:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Parcela.moefpgs", ;
1751:                 30, "Moe", 2, "", "")
1752:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Parcela.vencs", ;
1753:                 90, "Vecto", 2, "", "")
1754:             THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_Parcela.hists", ;
1755:                 192, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
1756: 
1757:             .Column1.ColumnOrder = 4
1758:             .Column3.ColumnOrder = 3
1759:             .Column4.ColumnOrder = 1
1760: 
1761:             .Enabled = .F.
1762:             .Visible = .F.
1763:         ENDWITH
1764:     ENDPROC
1765: 
1766:     *==========================================================================
1767:     * ConfigurarAbaMovimentacao - Page "Movimentacao" do Result: grade de
1768:     * produtos do fornecedor, total por operacao, operacoes do produto
1769:     * selecionado (grade filha), filtro Ativo/Inativo/Ambos e o botao que
1770:     * abre o painel de opcoes de impressao.
1771:     *==========================================================================
1772:     PROTECTED PROCEDURE ConfigurarAbaMovimentacao(par_oPage)
1773:         LOCAL loc_oGrd
1774: 
1775:         par_oPage.AddObject("lbl_4c_TitProdutos", "Label")
1776:         WITH par_oPage.lbl_4c_TitProdutos
1777:             .Top        = 30
1778:             .Left       = 3
1779:             .Width      = 59
1780:             .Height     = 15
1781:             .AutoSize   = .F.
1782:             .FontName   = "Tahoma"
1783:             .FontSize   = 8
1784:             .FontBold   = .T.
1785:             .FontItalic = .T.
1786:             .BackStyle  = 0
1787:             .Alignment  = 0
1788:             .ForeColor  = RGB(90, 90, 90)
1789:             .Caption    = " Produtos "
1790:         ENDWITH
1791: 
1792:         *-- Grd_Produto: 10 colunas, ColumnOrder do legado
1793:         par_oPage.AddObject("grd_4c_Produto", "Grid")
1794:         loc_oGrd = par_oPage.grd_4c_Produto
1795:         loc_oGrd.ColumnCount  = 10
1796:         loc_oGrd.RecordSource = "cursor_4c_ProdFor"
1797:         WITH loc_oGrd
1798:             .Top          = 44
1799:             .Left         = 2
1800:             .Width        = 690
1801:             .Height       = 106
1802:             THIS.FormatarGradeResultado(loc_oGrd)
1803:             .RowHeight    = 17
1804:             .Highlight    = .T.
1805:             .HighlightRow = .T.
1806: 
1807:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_ProdFor.cpros", ;
1808:                 108, "Produto", 2, "", "")
1809:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_ProdFor.custofs", ;
1810:                 70, "Custo", 2, "", "999,999,999.99")
1811:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_ProdFor.moecusfs", ;
1812:                 21, "Moe", 2, "", "")
1813:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_ProdFor.marca", ;
1814:                 10, "", 2, "", "")
1815:             THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_ProdFor.qtvend", ;
1816:                 70, "Qt. Vendas", 2, "", "999,999.999")
1817:             THIS.ConfigurarColunaResultado(.Column6, "cursor_4c_ProdFor.vlvend", ;
1818:                 70, "Valor Vendas", 2, "", "99,999,999.99")
1819:             THIS.ConfigurarColunaResultado(.Column7, "cursor_4c_ProdFor.estoque", ;
1820:                 70, "Estoque Atual", 2, "9999,999.999", "")
1821:             THIS.ConfigurarColunaResultado(.Column8, "cursor_4c_ProdFor.pvens", ;
1822:                 79, "Pre" + CHR(231) + "o de Venda", 2, "", "999,999,999.99")
1823:             THIS.ConfigurarColunaResultado(.Column9, "cursor_4c_ProdFor.moedas", ;
1824:                 21, "Moe", 2, "", "")
1825:             THIS.ConfigurarColunaResultado(.Column10, "cursor_4c_ProdFor.reffs", ;
1826:                 141, "Ref.Fornec", 2, "", "")
1827: 
1828:             .Column1.ColumnOrder  = 2
1829:             .Column1.FontBold     = .T.
1830:             .Column1.Alignment    = 3
1831:             .Column2.ColumnOrder  = 4
1832:             .Column2.Alignment    = 3
1833:             .Column3.ColumnOrder  = 5
1834:             .Column4.ColumnOrder  = 1
1835:             .Column5.ColumnOrder  = 6
1836:             .Column6.ColumnOrder  = 7
1837:             .Column7.ColumnOrder  = 8
1838:             .Column8.ColumnOrder  = 9
1839:             .Column9.ColumnOrder  = 10
1840:             .Column10.ColumnOrder = 3
1841:         ENDWITH
1842: 
1843:         *-- Click/DblClick dos headers ordenam a grade (ascendente /
1844:         *-- descendente), igual ao legado
1845:         BINDEVENT(loc_oGrd.Column1.Header1,  "Click",    THIS, "HeaderProdutoClick")
1846:         BINDEVENT(loc_oGrd.Column1.Header1,  "DblClick", THIS, "HeaderProdutoDblClick")
1847:         BINDEVENT(loc_oGrd.Column5.Header1,  "Click",    THIS, "HeaderQtVendClick")
1848:         BINDEVENT(loc_oGrd.Column5.Header1,  "DblClick", THIS, "HeaderQtVendDblClick")
1849:         BINDEVENT(loc_oGrd.Column6.Header1,  "Click",    THIS, "HeaderVlVendClick")
1850:         BINDEVENT(loc_oGrd.Column6.Header1,  "DblClick", THIS, "HeaderVlVendDblClick")
1851:         BINDEVENT(loc_oGrd.Column10.Header1, "Click",    THIS, "HeaderReffsClick")
1852:         BINDEVENT(loc_oGrd.Column10.Header1, "DblClick", THIS, "HeaderReffsDblClick")
1853: 
1854:         *-- shp_produto / lbl_produto + Grd_Resumo (total por operacao)
1855:         par_oPage.AddObject("shp_4c_MoldResumo", "Shape")
1856:         WITH par_oPage.shp_4c_MoldResumo
1857:             .Top           = 173
1858:             .Left          = 10
1859:             .Width         = 329
1860:             .Height        = 127
1861:             .BackStyle     = 0
1862:             .SpecialEffect = 1
1863:             .BorderColor   = RGB(136, 188, 189)
1864:         ENDWITH
1865: 
1866:         par_oPage.AddObject("lbl_4c_TitResumo", "Label")
1867:         WITH par_oPage.lbl_4c_TitResumo
1868:             .Top        = 160
1869:             .Left       = 11
1870:             .Width      = 116
1871:             .Height     = 15
1872:             .AutoSize   = .F.
1873:             .FontName   = "Tahoma"
1874:             .FontSize   = 8
1875:             .FontBold   = .T.
1876:             .FontItalic = .T.
1877:             .BackStyle  = 0
1878:             .Alignment  = 0
1879:             .ForeColor  = RGB(90, 90, 90)
1880:             .Caption    = " Total por Opera" + CHR(231) + CHR(227) + "o "
1881:         ENDWITH
1882: 
1883:         *-- No SCX as Columns de grd_resumo ficaram com ControlSource VAZIO e
1884:         *-- os Text1 internos apontando para um alias "dbproduto" que nao
1885:         *-- existe neste form (residuo de copia de outra grade). As ligacoes
1886:         *-- abaixo vem dos captions dos headers e da estrutura de dbResumo -
1887:         *-- deixar o ControlSource vazio exibiria a grade em branco.
1888:         par_oPage.AddObject("grd_4c_Resumo", "Grid")
1889:         loc_oGrd = par_oPage.grd_4c_Resumo
1890:         loc_oGrd.ColumnCount  = 3
1891:         loc_oGrd.RecordSource = "cursor_4c_Resumo"
1892:         WITH loc_oGrd
1893:             .Top          = 180
1894:             .Left         = 14
1895:             .Width        = 320
1896:             .Height       = 113
1897:             THIS.FormatarGradeResultado(loc_oGrd)
1898:             .Highlight    = .T.
1899:             .HighlightRow = .T.
1900: 
1901:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Resumo.dopes", ;
1902:                 150, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
1903:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Resumo.valos", ;
1904:                 90, "Valor Total", 2, "", "999,999,999.99")
1905:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Resumo.qtds", ;
1906:                 58, "Qtds", 0, "99999.99", "")
1907: 
1908:             .Column1.ColumnOrder = 1
1909:             .Column1.Alignment   = 3
1910:             .Column2.ColumnOrder = 3
1911:             .Column2.Alignment   = 3
1912:             .Column3.ColumnOrder = 2
1913:         ENDWITH
1914: 
1915:         *-- Shape2 + Grd_OperaProd (operacoes do produto selecionado)
1916:         par_oPage.AddObject("shp_4c_MoldOperaProd", "Shape")
1917:         WITH par_oPage.shp_4c_MoldOperaProd
1918:             .Top           = 152
1919:             .Left          = 337
1920:             .Width         = 332
1921:             .Height        = 93
1922:             .BackStyle     = 0
1923:             .SpecialEffect = 1
1924:             .BorderColor   = RGB(136, 188, 189)
1925:         ENDWITH
1926: 
1927:         par_oPage.AddObject("grd_4c_OperaProd", "Grid")
1928:         loc_oGrd = par_oPage.grd_4c_OperaProd
1929:         loc_oGrd.ColumnCount  = 3
1930:         loc_oGrd.RecordSource = "cursor_4c_OperaProd"
1931:         WITH loc_oGrd
1932:             .Top            = 154
1933:             .Left           = 340
1934:             .Width          = 324
1935:             .Height         = 88
1936:             THIS.FormatarGradeResultado(loc_oGrd)
1937:             .RowHeight      = 17
1938:             .Highlight      = .T.
1939:             .HighlightRow   = .T.
1940:             .LinkMaster     = "cursor_4c_ProdFor"
1941:             .ChildOrder     = "cprosdopes"
1942:             .RelationalExpr = "cpros"
1943: 
1944:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_OperaProd.dopes", ;
1945:                 127, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
1946:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_OperaProd.valos", ;
1947:                 80, "Valor Total", 2, "", "999,999,999.99")
1948:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_OperaProd.qtds", ;
1949:                 55, "Qtde.", 2, "", "999,999.999")
1950: 
1951:             .Column1.ColumnOrder = 1
1952:             .Column1.Alignment   = 3
1953:             .Column2.ColumnOrder = 3
1954:             .Column2.Alignment   = 3
1955:             .Column3.ColumnOrder = 2
1956:         ENDWITH
1957: 
1958:         *-- Mensagem1 / Mensagem2: aparecem quando a Analise de Vendas NAO foi
1959:         *-- pedida (Opt_Analise = 2), no lugar das duas grades de totais
1960:         par_oPage.AddObject("lbl_4c_Mensagem1", "Label")
1961:         WITH par_oPage.lbl_4c_Mensagem1
1962:             .Top       = 195
1963:             .Left      = 370

*-- Linhas 2001 a 2047:
2001:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2002:             .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2003:         ENDWITH
2004:         BINDEVENT(par_oPage.cmd_4c_ImprimirMov, "Click", THIS, "BtnImprimirMovClick")
2005: 
2006:         *-- OptSituas: filtro de situacao da grade de produtos
2007:         par_oPage.AddObject("obj_4c_OptSituas", "OptionGroup")
2008:         WITH par_oPage.obj_4c_OptSituas
2009:             .ButtonCount   = 3
2010:             .Top           = 9
2011:             .Left          = 434
2012:             .Width         = 197
2013:             .Height        = 26
2014:             .BackStyle     = 0
2015:             .SpecialEffect = 1
2016:             .Value         = 3
2017: 
2018:             WITH .Buttons(1)
2019:                 .Caption   = "Ativo"
2020:                 .Top       = 5
2021:                 .Left      = 9
2022:                 .Width     = 43
2023:                 .Height    = 15
2024:                 .AutoSize  = .F.
2025:                 .BackStyle = 0
2026:                 .FontName  = "Tahoma"
2027:                 .FontSize  = 8
2028:                 .ForeColor = RGB(90, 90, 90)
2029:             ENDWITH
2030: 
2031:             WITH .Buttons(2)
2032:                 .Caption   = "Inativo"
2033:                 .Top       = 5
2034:                 .Left      = 66
2035:                 .Width     = 52
2036:                 .Height    = 15
2037:                 .AutoSize  = .F.
2038:                 .BackStyle = 0
2039:                 .FontName  = "Tahoma"
2040:                 .FontSize  = 8
2041:                 .ForeColor = RGB(90, 90, 90)
2042:             ENDWITH
2043: 
2044:             WITH .Buttons(3)
2045:                 .Caption   = "Ambos"
2046:                 .Top       = 5
2047:                 .Left      = 130

*-- Linhas 2054 a 2349:
2054:                 .ForeColor = RGB(90, 90, 90)
2055:             ENDWITH
2056:         ENDWITH
2057:         BINDEVENT(par_oPage.obj_4c_OptSituas, "InteractiveChange", THIS, "OptSituasChange")
2058:     ENDPROC
2059: 
2060:     *==========================================================================
2061:     * ConfigurarAbaEstoque - Page "Estoque" do Result: produtos do fornecedor
2062:     * em poder das empresas + a foto do produto da linha selecionada.
2063:     *
2064:     * O olebcFigura (OleBoundControl) do legado NAO eh reproduzido: TODOS os
2065:     * caminhos de codigo do legado o deixam Visible = .F. e quem desenha a
2066:     * imagem eh o Image ImgFigJpg, a partir de um arquivo temporario.
2067:     *==========================================================================
2068:     PROTECTED PROCEDURE ConfigurarAbaEstoque(par_oPage)
2069:         LOCAL loc_oGrd
2070: 
2071:         par_oPage.AddObject("shp_4c_MoldEstoque", "Shape")
2072:         WITH par_oPage.shp_4c_MoldEstoque
2073:             .Top           = 27
2074:             .Left          = 13
2075:             .Width         = 239
2076:             .Height        = 360
2077:             .BackStyle     = 0
2078:             .SpecialEffect = 1
2079:         ENDWITH
2080: 
2081:         par_oPage.AddObject("lbl_4c_TitEstoque", "Label")
2082:         WITH par_oPage.lbl_4c_TitEstoque
2083:             .Top        = 13
2084:             .Left       = 22
2085:             .Width      = 133
2086:             .Height     = 15
2087:             .AutoSize   = .F.
2088:             .FontName   = "Tahoma"
2089:             .FontSize   = 8
2090:             .FontBold   = .T.
2091:             .FontItalic = .T.
2092:             .BackStyle  = 0
2093:             .Alignment  = 0
2094:             .ForeColor  = RGB(90, 90, 90)
2095:             .Caption    = "Produtos em seu poder"
2096:         ENDWITH
2097: 
2098:         par_oPage.AddObject("grd_4c_EstoqueProd", "Grid")
2099:         loc_oGrd = par_oPage.grd_4c_EstoqueProd
2100:         loc_oGrd.ColumnCount  = 2
2101:         loc_oGrd.RecordSource = "cursor_4c_Estoque"
2102:         WITH loc_oGrd
2103:             .Top          = 34
2104:             .Left         = 18
2105:             .Width        = 229
2106:             .Height       = 346
2107:             THIS.FormatarGradeResultado(loc_oGrd)
2108:             .Highlight    = .T.
2109:             .HighlightRow = .T.
2110: 
2111:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Estoque.cpros", ;
2112:                 108, "Produto", 2, "", "")
2113:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Estoque.sqtds", ;
2114:                 100, "Qtde.", 2, "", "99,999,999.999")
2115: 
2116:             .Column1.ColumnOrder = 1
2117:             .Column1.Alignment   = 3
2118:             .Column2.ColumnOrder = 2
2119:             .Column2.Alignment   = 3
2120:         ENDWITH
2121:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeEstoqueAfterRowColChange")
2122: 
2123:         par_oPage.AddObject("shp_4c_MoldFoto", "Shape")
2124:         WITH par_oPage.shp_4c_MoldFoto
2125:             .Top           = 27
2126:             .Left          = 251
2127:             .Width         = 181
2128:             .Height        = 138
2129:             .BackStyle     = 0
2130:             .SpecialEffect = 1
2131:         ENDWITH
2132: 
2133:         par_oPage.AddObject("img_4c_FotoProduto", "Image")
2134:         WITH par_oPage.img_4c_FotoProduto
2135:             .Top     = 32
2136:             .Left    = 255
2137:             .Width   = 172
2138:             .Height  = 129
2139:             .Stretch = 1
2140:             .Enabled = .F.
2141:             .Visible = .F.
2142:         ENDWITH
2143: 
2144:         par_oPage.AddObject("lbl_4c_MsgFotoProduto", "Label")
2145:         WITH par_oPage.lbl_4c_MsgFotoProduto
2146:             .Top       = 90
2147:             .Left      = 260
2148:             .Width     = 109
2149:             .Height    = 16
2150:             .AutoSize  = .F.
2151:             .FontBold  = .T.
2152:             .FontSize  = 8
2153:             .BackStyle = 0
2154:             .ForeColor = RGB(90, 90, 90)
2155:             .Caption   = "Foto n" + CHR(227) + "o dispon" + CHR(237) + "vel"
2156:             .Visible   = .F.
2157:         ENDWITH
2158:     ENDPROC
2159: 
2160:     *==========================================================================
2161:     * ConfigurarAbaConsertos - Page "Consertos" do Result: operacoes de
2162:     * conserto do fornecedor ainda nao baixadas.
2163:     *==========================================================================
2164:     PROTECTED PROCEDURE ConfigurarAbaConsertos(par_oPage)
2165:         LOCAL loc_oGrd
2166: 
2167:         par_oPage.AddObject("shp_4c_MoldConserto", "Shape")
2168:         WITH par_oPage.shp_4c_MoldConserto
2169:             .Top           = 27
2170:             .Left          = 7
2171:             .Width         = 663
2172:             .Height        = 289
2173:             .BackStyle     = 0
2174:             .SpecialEffect = 1
2175:         ENDWITH
2176: 
2177:         par_oPage.AddObject("lbl_4c_TitConserto", "Label")
2178:         WITH par_oPage.lbl_4c_TitConserto
2179:             .Top        = 12
2180:             .Left       = 17
2181:             .Width      = 122
2182:             .Height     = 15
2183:             .AutoSize   = .F.
2184:             .FontName   = "Tahoma"
2185:             .FontSize   = 8
2186:             .FontBold   = .T.
2187:             .FontItalic = .T.
2188:             .BackStyle  = 0
2189:             .Alignment  = 0
2190:             .ForeColor  = RGB(90, 90, 90)
2191:             .Caption    = "Consertos Pendentes"
2192:         ENDWITH
2193: 
2194:         par_oPage.AddObject("grd_4c_Conserto", "Grid")
2195:         loc_oGrd = par_oPage.grd_4c_Conserto
2196:         loc_oGrd.ColumnCount  = 4
2197:         loc_oGrd.RecordSource = "cursor_4c_Conserto"
2198:         WITH loc_oGrd
2199:             .Top          = 37
2200:             .Left         = 11
2201:             .Width        = 654
2202:             .Height       = 275
2203:             THIS.FormatarGradeResultado(loc_oGrd)
2204:             .Highlight    = .T.
2205:             .HighlightRow = .T.
2206: 
2207:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Conserto.datas", ;
2208:                 75, "Data", 2, "", "")
2209:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Conserto.emps", ;
2210:                 27, "Emp", 2, "", "")
2211:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Conserto.opers", ;
2212:                 130, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
2213:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Conserto.obscon", ;
2214:                 399, "Observa" + CHR(231) + CHR(227) + "o", 2, "", "")
2215: 
2216:             .Column1.ColumnOrder = 1
2217:             .Column1.Alignment   = 3
2218:             .Column2.ColumnOrder = 2
2219:             .Column2.Alignment   = 3
2220:             .Column3.ColumnOrder = 3
2221:             .Column3.Alignment   = 3
2222:             .Column4.ColumnOrder = 4
2223:         ENDWITH
2224:     ENDPROC
2225: 
2226:     *==========================================================================
2227:     * ConfigurarImprimeOpcoes - container "ImprimeOpcoes" do legado: painel
2228:     * flutuante (Visible = .F.) com as tres opcoes de abrangencia do
2229:     * relatorio e os botoes Visualizar / Imprimir / Sair. Top compensado
2230:     * (+29): legado 241 -> 270.
2231:     *
2232:     * Nasce invisivel e eh alternado por BtnImprimirMovClick / BtnSairOpcoes
2233:     * - por isso entra na lista de excecao de TornarControlesVisiveis.
2234:     *==========================================================================
2235:     PROTECTED PROCEDURE ConfigurarImprimeOpcoes(par_oPag)
2236:         LOCAL loc_oCnt
2237: 
2238:         par_oPag.AddObject("cnt_4c_ImprimeOpcoes", "Container")
2239:         loc_oCnt = par_oPag.cnt_4c_ImprimeOpcoes
2240:         WITH loc_oCnt
2241:             .Top           = 270
2242:             .Left          = 263
2243:             .Width         = 291
2244:             .Height        = 127
2245:             .BackStyle     = 1
2246:             .BackColor     = RGB(255, 255, 255)
2247:             .SpecialEffect = 0
2248:             .BorderWidth   = 1
2249:         ENDWITH
2250: 
2251:         loc_oCnt.AddObject("cmd_4c_VisualizarOpc", "CommandButton")
2252:         WITH loc_oCnt.cmd_4c_VisualizarOpc
2253:             .Top             = 8
2254:             .Left            = 164
2255:             .Width           = 40
2256:             .Height          = 40
2257:             .FontName        = "Verdana"
2258:             .FontSize        = 8
2259:             .WordWrap        = .T.
2260:             .Caption         = ""
2261:             .ToolTipText     = "Visualizar"
2262:             .ForeColor       = RGB(36, 84, 155)
2263:             .BackColor       = RGB(255, 255, 255)
2264:             .Themes          = .T.
2265:             .Picture         = gc_4c_CaminhoIcones + "kghostview.ico"
2266:             .DisabledPicture = gc_4c_CaminhoIcones + "kghostview.ico"
2267:         ENDWITH
2268:         BINDEVENT(loc_oCnt.cmd_4c_VisualizarOpc, "Click", THIS, "BtnVisualizarOpcoesClick")
2269: 
2270:         loc_oCnt.AddObject("cmd_4c_ImprimirOpc", "CommandButton")
2271:         WITH loc_oCnt.cmd_4c_ImprimirOpc
2272:             .Top             = 8
2273:             .Left            = 204
2274:             .Width           = 40
2275:             .Height          = 40
2276:             .FontName        = "Verdana"
2277:             .FontSize        = 8
2278:             .WordWrap        = .T.
2279:             .Caption         = ""
2280:             .ToolTipText     = "Imprimir"
2281:             .ForeColor       = RGB(36, 84, 155)
2282:             .BackColor       = RGB(255, 255, 255)
2283:             .Themes          = .T.
2284:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2285:             .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2286:         ENDWITH
2287:         BINDEVENT(loc_oCnt.cmd_4c_ImprimirOpc, "Click", THIS, "BtnImprimirOpcoesClick")
2288: 
2289:         loc_oCnt.AddObject("cmd_4c_SairOpc", "CommandButton")
2290:         WITH loc_oCnt.cmd_4c_SairOpc
2291:             .Top             = 8
2292:             .Left            = 244
2293:             .Width           = 40
2294:             .Height          = 40
2295:             .FontName        = "Verdana"
2296:             .FontSize        = 8
2297:             .WordWrap        = .T.
2298:             .Caption         = ""
2299:             .Cancel          = .T.
2300:             .ToolTipText     = "Sair"
2301:             .ForeColor       = RGB(36, 84, 155)
2302:             .BackColor       = RGB(255, 255, 255)
2303:             .Themes          = .T.
2304:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
2305:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
2306:         ENDWITH
2307:         BINDEVENT(loc_oCnt.cmd_4c_SairOpc, "Click", THIS, "BtnSairOpcoesClick")
2308: 
2309:         loc_oCnt.AddObject("obj_4c_Opcao", "OptionGroup")
2310:         WITH loc_oCnt.obj_4c_Opcao
2311:             .ButtonCount   = 3
2312:             .Top           = 53
2313:             .Left          = 49
2314:             .Width         = 191
2315:             .Height        = 64
2316:             .BackStyle     = 0
2317:             .BorderStyle   = 1
2318:             .SpecialEffect = 1
2319:             .Value         = 1
2320: 
2321:             WITH .Buttons(1)
2322:                 .Caption   = "Produto Selecionado"
2323:                 .Top       = 5
2324:                 .Left      = 5
2325:                 .Width     = 116
2326:                 .Height    = 15
2327:                 .AutoSize  = .F.
2328:                 .BackStyle = 0
2329:                 .FontName  = "Tahoma"
2330:                 .FontSize  = 8
2331:                 .ForeColor = RGB(90, 90, 90)
2332:             ENDWITH
2333: 
2334:             WITH .Buttons(2)
2335:                 .Caption   = "Todos os Produtos"
2336:                 .Top       = 24
2337:                 .Left      = 5
2338:                 .Width     = 107
2339:                 .Height    = 15
2340:                 .AutoSize  = .F.
2341:                 .BackStyle = 0
2342:                 .FontName  = "Tahoma"
2343:                 .FontSize  = 8
2344:                 .ForeColor = RGB(90, 90, 90)
2345:             ENDWITH
2346: 
2347:             WITH .Buttons(3)
2348:                 .Caption   = "Todos com Movimenta" + CHR(231) + CHR(227) + "o"
2349:                 .Top       = 43

*-- Linhas 2366 a 2409:
2366:     * Resultado), espelhando ThisForm.Fld_Principal.ActivePage = N do
2367:     * legado.
2368:     *==========================================================================
2369:     PROCEDURE AlternarPagina(par_nPagina)
2370:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2371: 
2372:         *-- Refresh em pagina OCULTA nao pinta: as grades do Resultado sao
2373:         *-- repintadas aqui, DEPOIS da troca de ActivePage, senao o usuario ve
2374:         *-- as grades vazias com os cursores cheios.
2375:         IF par_nPagina = 2
2376:             THIS.AtualizarGrades()
2377:         ENDIF
2378:     ENDPROC
2379: 
2380:     *==========================================================================
2381:     * ValidarFiltrosConsulta - Do Case comum aos dois botoes do
2382:     * grp_operacao (legado: cmd_cadastro.Click e cmd_movimenta.Click tem
2383:     * o MESMO bloco de validacao, so o que roda depois diverge). Grupo e
2384:     * Conta sao sempre obrigatorios e tem de existir em SigCdGcr/SigCdCli;
2385:     * quando Opt_Analise = 1 ("Sim"), Data Inicial/Moeda tambem se tornam
2386:     * obrigatorias e a Data Final nao pode ser anterior a Data Inicial.
2387:     *==========================================================================
2388:     PROTECTED FUNCTION ValidarFiltrosConsulta()
2389:         LOCAL loc_oPag, loc_oOrigem, loc_cGrupo, loc_cConta, loc_cMoeda, ;
2390:               loc_nResult, loc_oErro, loc_lValido, loc_lErroSql, loc_cMsg, loc_oFoco
2391: 
2392:         loc_oPag     = THIS.pgf_4c_Paginas.Page1
2393:         loc_oOrigem  = loc_oPag.cnt_4c_Origem
2394:         loc_cGrupo   = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
2395:         loc_cConta   = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
2396:         loc_cMoeda   = ALLTRIM(loc_oPag.txt_4c_Moeda.Value)
2397:         loc_lValido  = .T.
2398:         loc_lErroSql = .F.
2399:         loc_cMsg     = ""
2400:         loc_oFoco    = .NULL.
2401: 
2402:         TRY
2403:             IF loc_lValido AND EMPTY(loc_cGrupo)
2404:                 loc_lValido = .F.
2405:                 loc_cMsg    = "Grupo de Estoque Inv" + CHR(225) + "lido !!!"
2406:                 loc_oFoco   = loc_oOrigem.txt_4c_Grupo
2407:             ENDIF
2408: 
2409:             IF loc_lValido

*-- Linhas 2486 a 2529:
2486:             IF loc_lErroSql
2487:                 MsgErro(loc_cMsg, "Erro")
2488:             ELSE
2489:                 MsgAviso(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
2490:                 IF VARTYPE(loc_oFoco) = "O"
2491:                     loc_oFoco.SetFocus()
2492:                 ENDIF
2493:             ENDIF
2494:         ENDIF
2495: 
2496:         RETURN loc_lValido
2497:     ENDFUNC
2498: 
2499:     *==========================================================================
2500:     * ExecutarProcessamento - o "ThisForm.Processa" do legado visto pelos dois
2501:     * botoes do grp_operacao.
2502:     *
2503:     * O legado envolve TODO o corpo de Processa em "If !ThisForm.
2504:     * ConsultaExecutada": com os filtros inalterados desde a ultima consulta
2505:     * nada eh reconsultado nem repintado (os dados na tela ja sao os certos).
2506:     * Reproduzido aqui com o mesmo guard - cada handler de filtro zera a flag.
2507:     *
2508:     * Ordem: Buscar (dados cadastrais do fornecedor, TmpCli do legado) ->
2509:     * Processar (as 9 etapas de agregacao) -> BOParaForm + CarregarLista
2510:     * (a parte de UI do fim de Processa).
2511:     *==========================================================================
2512:     PROTECTED FUNCTION ExecutarProcessamento()
2513:         LOCAL loc_lOk
2514:         loc_lOk = .T.
2515: 
2516:         IF !THIS.this_oBusinessObject.this_lConsultaExecutada
2517:             THIS.FormParaBO()
2518: 
2519:             IF !THIS.this_oBusinessObject.Buscar( ;
2520:                     THIS.this_oBusinessObject.this_cGrupo, ;
2521:                     THIS.this_oBusinessObject.this_cConta)
2522:                 IF !THIS.this_oBusinessObject.this_lErroExibido
2523:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
2524:                 ENDIF
2525:                 loc_lOk = .F.
2526:             ENDIF
2527: 
2528:             IF loc_lOk
2529:                 IF !THIS.this_oBusinessObject.Processar()

*-- Linhas 2568 a 3522:
2568:     * OCULTA tambem nao pinta, por isso AlternarPagina(2) chama
2569:     * AtualizarGrades() novamente DEPOIS de trocar o ActivePage.
2570:     *==========================================================================
2571:     PROCEDURE CarregarLista()
2572:         LOCAL loc_lSucesso, loc_oErro, loc_oRes, loc_oMov, loc_cTitMoeda, ;
2573:               loc_lAnalise, loc_oPag1
2574: 
2575:         loc_lSucesso = .F.
2576: 
2577:         IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Result", 5)
2578:             RETURN .F.
2579:         ENDIF
2580: 
2581:         TRY
2582:             loc_oRes  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result
2583:             loc_oMov  = loc_oRes.Page3
2584:             loc_oPag1 = THIS.pgf_4c_Paginas.Page1
2585: 
2586:             loc_lAnalise = (loc_oPag1.obj_4c_Opt_Analise.Value = 1)
2587: 
2588:             *-- grades de totais x mensagens (legado: If lnAnalise = 1)
2589:             loc_oMov.grd_4c_Resumo.Visible    = loc_lAnalise
2590:             loc_oMov.grd_4c_OperaProd.Visible = loc_lAnalise
2591:             loc_oMov.lbl_4c_Mensagem1.Visible = !loc_lAnalise
2592:             loc_oMov.lbl_4c_Mensagem2.Visible = !loc_lAnalise
2593: 
2594:             *-- _TitMoeda do legado: a moeda do filtro entra entre parenteses
2595:             *-- no caption das tres colunas de valor
2596:             loc_cTitMoeda = ""
2597:             IF !EMPTY(ALLTRIM(loc_oPag1.txt_4c_Moeda.Value))
2598:                 loc_cTitMoeda = "(" + ALLTRIM(loc_oPag1.txt_4c_Moeda.Value) + ")"
2599:             ENDIF
2600: 
2601:             loc_oMov.grd_4c_Produto.Column6.Header1.Caption   = "Total Vendas" + loc_cTitMoeda
2602:             loc_oMov.grd_4c_OperaProd.Column2.Header1.Caption = "Valor Total" + loc_cTitMoeda
2603:             loc_oMov.grd_4c_Resumo.Column2.Header1.Caption    = "Valor Total" + loc_cTitMoeda
2604: 
2605:             THIS.AtualizarFotoFornecedor()
2606:             THIS.AtualizarGrades()
2607: 
2608:             loc_oRes.ActivePage = 1
2609:             loc_lSucesso = .T.
2610:         CATCH TO loc_oErro
2611:             MsgErro(loc_oErro.Message + CHR(13) + ;
2612:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2613:                 "Procedure: " + loc_oErro.Procedure, "Erro ao exibir o resultado")
2614:         ENDTRY
2615: 
2616:         RETURN loc_lSucesso
2617:     ENDPROC
2618: 
2619:     *==========================================================================
2620:     * AtualizarGrades - GO TOP em cada cursor + Refresh de cada grade. Metodo
2621:     * UNICO, chamado de CarregarLista e de AlternarPagina(2) - esta ultima
2622:     * porque Refresh em pagina oculta nao pinta, e a Pagina Resultado so fica
2623:     * visivel DEPOIS da troca de ActivePage.
2624:     *==========================================================================
2625:     PROCEDURE AtualizarGrades()
2626:         LOCAL loc_oRes, loc_oErro
2627: 
2628:         IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Result", 5)
2629:             RETURN
2630:         ENDIF
2631: 
2632:         TRY
2633:             THIS.this_oBusinessObject.PosicionarCursores()
2634: 
2635:             loc_oRes = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result
2636: 
2637:             loc_oRes.Page1.grd_4c_Saldo.Refresh()
2638:             loc_oRes.Page1.grd_4c_Historico.Refresh()
2639:             loc_oRes.Page1.txt_4c_Hists.Refresh()
2640:             loc_oRes.Page1.txt_4c_Hist2s.Refresh()
2641:             loc_oRes.Page2.grd_4c_Pendente.Refresh()
2642:             loc_oRes.Page3.grd_4c_Produto.Refresh()
2643:             loc_oRes.Page3.grd_4c_Resumo.Refresh()
2644:             loc_oRes.Page3.grd_4c_OperaProd.Refresh()
2645:             loc_oRes.Page4.grd_4c_EstoqueProd.Refresh()
2646:             loc_oRes.Page5.grd_4c_Conserto.Refresh()
2647: 
2648:             *-- foto do produto da linha corrente da aba Estoque (o legado
2649:             *-- dispara "Result.Estoque.Grd_Produto.AfterRowColChange" a mao)
2650:             THIS.GradeEstoqueAfterRowColChange(1)
2651:         CATCH TO loc_oErro
2652:             MsgErro(loc_oErro.Message + CHR(13) + ;
2653:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao atualizar as grades")
2654:         ENDTRY
2655:     ENDPROC
2656: 
2657:     *==========================================================================
2658:     * MostrarBlocoCadastro / MostrarBlocoMovimento - o par de blocos "With
2659:     * ThisForm.Fld_Principal.Pag_Resultado" do legado, que alterna a Pagina
2660:     * Resultado entre o cadastro do fornecedor e o resultado da consulta, e
2661:     * troca qual botao de navegacao (Cmd_MudaFor / Cmd_MudaMov) fica visivel.
2662:     *
2663:     * fChecaAcesso decide se o botao de ida pode aparecer, como no legado.
2664:     *==========================================================================
2665:     PROTECTED PROCEDURE MostrarBlocoCadastro()
2666:         LOCAL loc_oPag2
2667: 
2668:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2669: 
2670:         loc_oPag2.cnt_4c_Cadastro.Visible = .T.
2671:         loc_oPag2.cnt_4c_Cadastro.Enabled = .T.
2672:         loc_oPag2.pgf_4c_Result.Visible   = .F.
2673:         loc_oPag2.pgf_4c_Result.Enabled   = .F.
2674: 
2675:         loc_oPag2.cmg_4c_MudaFor.Visible = .F.
2676:         loc_oPag2.cmg_4c_MudaFor.Enabled = .F.
2677: 
2678:         IF fChecaAcesso("SIGOPCGC", "MOVIMENTA")
2679:             loc_oPag2.cmg_4c_MudaMov.Visible = .T.
2680:             loc_oPag2.cmg_4c_MudaMov.Enabled = .T.
2681:         ENDIF
2682:     ENDPROC
2683: 
2684:     PROTECTED PROCEDURE MostrarBlocoMovimento()
2685:         LOCAL loc_oPag2
2686: 
2687:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2688: 
2689:         loc_oPag2.cnt_4c_Cadastro.Visible = .F.
2690:         loc_oPag2.cnt_4c_Cadastro.Enabled = .F.
2691:         loc_oPag2.pgf_4c_Result.Visible   = .T.
2692:         loc_oPag2.pgf_4c_Result.Enabled   = .T.
2693: 
2694:         loc_oPag2.cmg_4c_MudaMov.Visible = .F.
2695:         loc_oPag2.cmg_4c_MudaMov.Enabled = .F.
2696: 
2697:         IF fChecaAcesso("SIGOPCGC", "CADASTRO")
2698:             loc_oPag2.cmg_4c_MudaFor.Visible = .T.
2699:             loc_oPag2.cmg_4c_MudaFor.Enabled = .T.
2700:         ENDIF
2701:     ENDPROC
2702: 
2703:     *==========================================================================
2704:     * AtualizarFotoFornecedor - bloco "With .Pag_Resultado.Cadastro" do fim de
2705:     * Processa: a foto so aparece quando o GRUPO de contas esta marcado para
2706:     * exibir foto (CrSigCdGcr.mfotos = 1); sem foto, mostra o aviso "Foto nao
2707:     * disponivel"; com o grupo sem foto, esconde moldura, imagem e aviso.
2708:     *
2709:     * CLEAR RESOURCES antes de atribuir o .Picture eh do legado e eh
2710:     * necessario: sem ele o VFP reaproveita a imagem em cache do arquivo
2711:     * temporario anterior e a tela mostra a foto do fornecedor errado.
2712:     *==========================================================================
2713:     PROTECTED PROCEDURE AtualizarFotoFornecedor()
2714:         LOCAL loc_oCad, loc_cArquivo
2715: 
2716:         loc_oCad = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cadastro
2717: 
2718:         IF THIS.this_oBusinessObject.this_nMFotos != 1
2719:             loc_oCad.shp_4c_Figura.Visible  = .F.
2720:             loc_oCad.img_4c_Figura.Visible  = .F.
2721:             loc_oCad.img_4c_Figura.Picture  = ""
2722:             loc_oCad.lbl_4c_MsgFoto.Visible = .F.
2723:             RETURN
2724:         ENDIF
2725: 
2726:         loc_oCad.shp_4c_Figura.Visible = .T.
2727:         loc_cArquivo = THIS.this_oBusinessObject.ObterArquivoFotoFornecedor()
2728: 
2729:         IF EMPTY(loc_cArquivo)
2730:             loc_oCad.img_4c_Figura.Visible  = .F.
2731:             loc_oCad.img_4c_Figura.Picture  = ""
2732:             loc_oCad.lbl_4c_MsgFoto.Visible = .T.
2733:         ELSE
2734:             CLEAR RESOURCES
2735:             loc_oCad.img_4c_Figura.Picture  = loc_cArquivo
2736:             loc_oCad.img_4c_Figura.Visible  = .T.
2737:             loc_oCad.lbl_4c_MsgFoto.Visible = .F.
2738:         ENDIF
2739:     ENDPROC
2740: 
2741:     *==========================================================================
2742:     * BtnCadastroClick - botao "Dados Cadastrais" do grp_operacao (Page1).
2743:     * Legado (cmd_cadastro.Click): valida Grupo/Conta/periodo/moeda, poe
2744:     * pcMensagem = .T. (nao avisa fornecedor sem informacao), roda Processa e
2745:     * abre a Pagina Resultado no bloco de CADASTRO do fornecedor.
2746:     *==========================================================================
2747:     PROCEDURE BtnCadastroClick()
2748:         IF !THIS.ValidarFiltrosConsulta()
2749:             RETURN
2750:         ENDIF
2751: 
2752:         THIS.this_oBusinessObject.this_lMensagem = .T.
2753: 
2754:         IF !THIS.ExecutarProcessamento()
2755:             RETURN
2756:         ENDIF
2757: 
2758:         THIS.MostrarBlocoCadastro()
2759:         THIS.AlternarPagina(2)
2760:     ENDPROC
2761: 
2762:     *==========================================================================
2763:     * BtnMovimentoClick - botao "Movimentacao" do grp_operacao (Page1).
2764:     * Legado (cmd_movimenta.Click): MESMA validacao do botao de cadastro, poe
2765:     * pcMensagem = .F. (avisa quando o fornecedor nao tem informacao nenhuma),
2766:     * roda Processa, abre a Pagina Resultado direto no bloco de RESULTADO,
2767:     * RECONFIGURA as grades de Saldo/Historico (o numero de colunas depende da
2768:     * permissao de SALDO) e posiciona o historico no lancamento mais recente.
2769:     *==========================================================================
2770:     PROCEDURE BtnMovimentoClick()
2771:         LOCAL loc_oErro
2772: 
2773:         IF !THIS.ValidarFiltrosConsulta()
2774:             RETURN
2775:         ENDIF
2776: 
2777:         THIS.this_oBusinessObject.this_lMensagem = .F.
2778: 
2779:         IF !THIS.ExecutarProcessamento()
2780:             RETURN
2781:         ENDIF
2782: 
2783:         THIS.MostrarBlocoMovimento()
2784: 
2785:         *-- O legado refaz a configuracao das duas grades da aba Saldo a cada
2786:         *-- clique neste botao (ColumnCount depende da permissao) - mexer em
2787:         *-- ColumnCount recria as Column, por isso ControlSource/Width/Header
2788:         *-- sao reaplicados dentro de ConfigurarGradesSaldo.
2789:         THIS.ConfigurarGradesSaldo()
2790: 
2791:         THIS.AlternarPagina(2)
2792: 
2793:         *-- "Select dbHistorico / Go Bottom" do legado: o extrato abre no
2794:         *-- lancamento mais RECENTE. Tem de vir DEPOIS de AlternarPagina, que
2795:         *-- chama AtualizarGrades -> PosicionarCursores (GO TOP em todos os
2796:         *-- cursores) - antes dela, o GO TOP desfaria este GO BOTTOM.
2797:         IF USED("cursor_4c_Historico")
2798:             SELECT cursor_4c_Historico
2799:             GO BOTTOM
2800:         ENDIF
2801: 
2802:         TRY
2803:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.Refresh()
2804:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.SetFocus()
2805:         CATCH TO loc_oErro
2806:             *-- SetFocus falha quando a grade ainda nao esta visivel; eh so o
2807:             *-- foco inicial, nao afeta o conteudo exibido
2808:         ENDTRY
2809:     ENDPROC
2810: 
2811:     *==========================================================================
2812:     * BtnCancelarClick - botao "Encerrar" do grp_operacao (Page1), que no
2813:     * legado eh o objeto cmd_cancela (Cancel = .T., ou seja tambem responde ao
2814:     * ESC) e cujo Click eh apenas "ThisForm.Release".
2815:     *==========================================================================
2816:     PROCEDURE BtnCancelarClick()
2817:         THIS.Release()
2818:     ENDPROC
2819: 
2820:     *==========================================================================
2821:     * BtnVoltarClick - grp_operacao da Page2 (botao unico). Legado:
2822:     * If ThisForm.Automatico / ThisForm.Release / Else / ThisForm.
2823:     * Fld_Principal.ActivePage = 1 / EndIf. No modo Automatico (form aberto
2824:     * por outra tela, com Grupo/Conta recebidos por parametro) nao ha pagina
2825:     * de Consulta para onde voltar - a tela fecha.
2826:     *==========================================================================
2827:     PROCEDURE BtnVoltarClick()
2828:         IF THIS.this_oBusinessObject.this_lAutomatico
2829:             THIS.Release()
2830:         ELSE
2831:             THIS.AlternarPagina(1)
2832:         ENDIF
2833:     ENDPROC
2834: 
2835:     *==========================================================================
2836:     * BtnMudaForClick - mostra o bloco de CADASTRO do fornecedor e oculta o
2837:     * resultado da consulta (legado Cmd_MudaFor.cmd_cadastro.Click, que ainda
2838:     * poe pcMensagem = .T.).
2839:     *==========================================================================
2840:     PROCEDURE BtnMudaForClick()
2841:         THIS.this_oBusinessObject.this_lMensagem = .T.
2842:         THIS.LockScreen = .T.
2843:         THIS.MostrarBlocoCadastro()
2844:         THIS.LockScreen = .F.
2845:     ENDPROC
2846: 
2847:     *==========================================================================
2848:     * BtnMudaMovClick - mostra o RESULTADO da consulta e oculta o cadastro
2849:     * (legado Cmd_MudaMov.cmd_movimenta.Click, que ainda poe
2850:     * pcMensagem = .F.).
2851:     *==========================================================================
2852:     PROCEDURE BtnMudaMovClick()
2853:         THIS.this_oBusinessObject.this_lMensagem = .F.
2854:         THIS.LockScreen = .T.
2855:         THIS.MostrarBlocoMovimento()
2856:         THIS.LockScreen = .F.
2857:         THIS.AtualizarGrades()
2858:     ENDPROC
2859: 
2860:     *==========================================================================
2861:     * GradeSaldoAfterRowColChange - AfterRowColChange de grd_saldo: trocar de
2862:     * moeda na grade mae repinta a grade filha de historico (a relacao filtra
2863:     * por moeda).
2864:     *==========================================================================
2865:     PROCEDURE GradeSaldoAfterRowColChange(par_nColIndex)
2866:         LOCAL loc_oErro
2867: 
2868:         TRY
2869:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.Refresh()
2870:         CATCH TO loc_oErro
2871:             MsgErro(loc_oErro.Message, "Erro")
2872:         ENDTRY
2873:     ENDPROC
2874: 
2875:     *==========================================================================
2876:     * GradeHistoricoAfterRowColChange - AfterRowColChange de grd_historico:
2877:     * os dois campos de historico abaixo da grade acompanham a linha corrente.
2878:     *==========================================================================
2879:     PROCEDURE GradeHistoricoAfterRowColChange(par_nColIndex)
2880:         LOCAL loc_oPage, loc_oErro
2881: 
2882:         TRY
2883:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1
2884:             loc_oPage.txt_4c_Hists.Refresh()
2885:             loc_oPage.txt_4c_Hist2s.Refresh()
2886:         CATCH TO loc_oErro
2887:             MsgErro(loc_oErro.Message, "Erro")
2888:         ENDTRY
2889:     ENDPROC
2890: 
2891:     *==========================================================================
2892:     * GradeEstoqueAfterRowColChange - AfterRowColChange da grade da aba
2893:     * Estoque: carrega a foto do produto da linha corrente (SigCdPro.figjpgs
2894:     * gravado num arquivo temporario) ou mostra "Foto nao disponivel".
2895:     *==========================================================================
2896:     PROCEDURE GradeEstoqueAfterRowColChange(par_nColIndex)
2897:         LOCAL loc_oPage, loc_cArquivo, loc_cProduto, loc_oErro
2898: 
2899:         TRY
2900:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page4
2901: 
2902:             loc_cProduto = ""
2903:             IF USED("cursor_4c_Estoque") AND !EOF("cursor_4c_Estoque")
2904:                 loc_cProduto = cursor_4c_Estoque.cpros
2905:             ENDIF
2906: 
2907:             loc_cArquivo = ""
2908:             IF !EMPTY(ALLTRIM(loc_cProduto))
2909:                 loc_cArquivo = THIS.this_oBusinessObject.CarregarFotoProduto(loc_cProduto)
2910:             ENDIF
2911: 
2912:             IF EMPTY(loc_cArquivo)
2913:                 loc_oPage.img_4c_FotoProduto.Visible    = .F.
2914:                 loc_oPage.img_4c_FotoProduto.Picture    = ""
2915:                 loc_oPage.lbl_4c_MsgFotoProduto.Visible = .T.
2916:             ELSE
2917:                 CLEAR RESOURCES
2918:                 loc_oPage.img_4c_FotoProduto.Picture    = loc_cArquivo
2919:                 loc_oPage.img_4c_FotoProduto.Visible    = .T.
2920:                 loc_oPage.lbl_4c_MsgFotoProduto.Visible = .F.
2921:             ENDIF
2922:         CATCH TO loc_oErro
2923:             MsgErro(loc_oErro.Message + CHR(13) + ;
2924:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao carregar a foto")
2925:         ENDTRY
2926:     ENDPROC
2927: 
2928:     *==========================================================================
2929:     * OptSituasChange - InteractiveChange de OptSituas: filtra a grade de
2930:     * produtos por situacao (1 = Ativo, 2 = Inativo, 3 = Ambos / sem filtro).
2931:     * Transcrito do legado, inclusive o GO TOP + Refresh no fim (sem eles a
2932:     * grade continua mostrando a pagina antiga).
2933:     *==========================================================================
2934:     PROCEDURE OptSituasChange()
2935:         LOCAL loc_oPage, loc_nValor, loc_oErro
2936: 
2937:         *-- Guarda ANTES do TRY: RETURN dentro de TRY/CATCH eh proibido (o
2938:         *-- VFP9 nao garante o desvio e o bloco fica abandonado).
2939:         IF !USED("cursor_4c_ProdFor")
2940:             RETURN
2941:         ENDIF
2942: 
2943:         TRY
2944:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page3
2945:             loc_nValor = loc_oPage.obj_4c_OptSituas.Value
2946: 
2947:             SELECT cursor_4c_ProdFor
2948:             IF loc_nValor != 3
2949:                 IF loc_nValor = 1
2950:                     SET FILTER TO situas = 1
2951:                 ELSE
2952:                     SET FILTER TO situas = 2
2953:                 ENDIF
2954:             ELSE
2955:                 SET FILTER TO
2956:             ENDIF
2957: 
2958:             GO TOP IN cursor_4c_ProdFor
2959:             loc_oPage.grd_4c_Produto.Refresh()
2960:         CATCH TO loc_oErro
2961:             MsgErro(loc_oErro.Message, "Erro")
2962:         ENDTRY
2963:     ENDPROC
2964: 
2965:     *==========================================================================
2966:     * OrdenarGradeProdutos - corpo comum aos 8 handlers de Click/DblClick dos
2967:     * headers da grade de produtos: o legado troca a ordem corrente do cursor
2968:     * (Click = ascendente, DblClick = descendente) e repinta a grade.
2969:     *==========================================================================
2970:     PROTECTED PROCEDURE OrdenarGradeProdutos(par_cTag, par_lDescendente)
2971:         LOCAL loc_oErro
2972: 
2973:         IF !USED("cursor_4c_ProdFor")
2974:             RETURN
2975:         ENDIF
2976: 
2977:         TRY
2978:             SELECT cursor_4c_ProdFor
2979:             IF par_lDescendente
2980:                 SET ORDER TO (par_cTag) DESCENDING
2981:             ELSE
2982:                 SET ORDER TO (par_cTag) ASCENDING
2983:             ENDIF
2984:             GO TOP IN cursor_4c_ProdFor
2985:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page3.grd_4c_Produto.Refresh()
2986:         CATCH TO loc_oErro
2987:             MsgErro(loc_oErro.Message, "Erro")
2988:         ENDTRY
2989:     ENDPROC
2990: 
2991:     PROCEDURE HeaderProdutoClick()
2992:         THIS.OrdenarGradeProdutos("cpros", .F.)
2993:     ENDPROC
2994: 
2995:     PROCEDURE HeaderProdutoDblClick()
2996:         THIS.OrdenarGradeProdutos("cpros", .T.)
2997:     ENDPROC
2998: 
2999:     PROCEDURE HeaderQtVendClick()
3000:         THIS.OrdenarGradeProdutos("qtvend", .F.)
3001:     ENDPROC
3002: 
3003:     PROCEDURE HeaderQtVendDblClick()
3004:         THIS.OrdenarGradeProdutos("qtvend", .T.)
3005:     ENDPROC
3006: 
3007:     PROCEDURE HeaderVlVendClick()
3008:         THIS.OrdenarGradeProdutos("vlvend", .F.)
3009:     ENDPROC
3010: 
3011:     PROCEDURE HeaderVlVendDblClick()
3012:         THIS.OrdenarGradeProdutos("vlvend", .T.)
3013:     ENDPROC
3014: 
3015:     PROCEDURE HeaderReffsClick()
3016:         THIS.OrdenarGradeProdutos("reffs", .F.)
3017:     ENDPROC
3018: 
3019:     PROCEDURE HeaderReffsDblClick()
3020:         THIS.OrdenarGradeProdutos("reffs", .T.)
3021:     ENDPROC
3022: 
3023:     *==========================================================================
3024:     * BtnImprimirExtratoClick - btnImprimir da aba Saldo. Legado:
3025:     *   Do Form SigReCgc With Get_Grupo.Value, Get_Conta.Value
3026:     * O relatorio migrado eh FormSigReCgc, cujo Init recebe (grupo, conta).
3027:     *==========================================================================
3028:     PROCEDURE BtnImprimirExtratoClick()
3029:         LOCAL loc_oForm, loc_oOrigem, loc_oErro
3030: 
3031:         loc_oForm = .NULL.
3032: 
3033:         TRY
3034:             loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3035:             loc_oForm   = CREATEOBJECT("FormSigReCgc", ;
3036:                 ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value), ;
3037:                 ALLTRIM(loc_oOrigem.txt_4c_Conta.Value))
3038:         CATCH TO loc_oErro
3039:             loc_oForm = .NULL.
3040:             MsgErro("Erro ao abrir o relat" + CHR(243) + "rio:" + CHR(13) + ;
3041:                 loc_oErro.Message, "Erro")
3042:         ENDTRY
3043: 
3044:         *-- Show() FORA do TRY: form modal faz o Show BLOQUEAR, e com ele
3045:         *-- dentro do TRY qualquer erro de runtime da tela aberta cairia neste
3046:         *-- CATCH, a referencia LOCAL seria perdida e o form fecharia sozinho.
3047:         IF VARTYPE(loc_oForm) = "O"
3048:             loc_oForm.Show()
3049:         ENDIF
3050:     ENDPROC
3051: 
3052:     *==========================================================================
3053:     * BtnImprimirMovClick - botao Imprimir da aba Movimentacao. Legado: NAO
3054:     * imprime nada ainda - desabilita a tela e abre o painel ImprimeOpcoes,
3055:     * onde o usuario escolhe a abrangencia e so entao visualiza ou imprime.
3056:     * A opcao "Produto Selecionado" so fica disponivel quando ha produto na
3057:     * linha corrente da grade.
3058:     *==========================================================================
3059:     PROCEDURE BtnImprimirMovClick()
3060:         LOCAL loc_oPag1, loc_oPag2, loc_lTemProduto, loc_oCnt
3061: 
3062:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
3063:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
3064:         loc_oCnt  = loc_oPag2.cnt_4c_ImprimeOpcoes
3065: 
3066:         loc_oPag1.Enabled                 = .F.
3067:         loc_oPag2.pgf_4c_Result.Enabled   = .F.
3068:         loc_oPag2.cmg_4c_MudaMov.Enabled  = .F.
3069:         loc_oPag2.cmg_4c_MudaFor.Enabled  = .F.
3070:         loc_oPag2.cnt_4c_BotoesAcao.Enabled = .F.
3071: 
3072:         loc_lTemProduto = .F.
3073:         IF USED("cursor_4c_ProdFor") AND !EOF("cursor_4c_ProdFor")
3074:             loc_lTemProduto = !EMPTY(ALLTRIM(cursor_4c_ProdFor.cpros))
3075:         ENDIF
3076: 
3077:         loc_oCnt.obj_4c_Opcao.Buttons(1).Enabled = loc_lTemProduto
3078:         loc_oCnt.obj_4c_Opcao.Value              = IIF(loc_lTemProduto, 1, 2)
3079:         loc_oCnt.Visible                         = .T.
3080:     ENDPROC
3081: 
3082:     *==========================================================================
3083:     * ReabilitarAposImpressao - o bloco de 6 linhas que o legado repete nos
3084:     * tres botoes do painel ImprimeOpcoes (Visualizar, Imprimir e Sair), para
3085:     * devolver a tela ao estado normal e fechar o painel.
3086:     *==========================================================================
3087:     PROTECTED PROCEDURE ReabilitarAposImpressao()
3088:         LOCAL loc_oPag1, loc_oPag2
3089: 
3090:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
3091:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
3092: 
3093:         loc_oPag1.Enabled                   = .T.
3094:         loc_oPag2.pgf_4c_Result.Enabled     = .T.
3095:         loc_oPag2.cmg_4c_MudaMov.Enabled    = .T.
3096:         loc_oPag2.cmg_4c_MudaFor.Enabled    = .T.
3097:         loc_oPag2.cnt_4c_BotoesAcao.Enabled = .T.
3098:         loc_oPag2.cnt_4c_ImprimeOpcoes.Visible = .F.
3099:     ENDPROC
3100: 
3101:     *==========================================================================
3102:     * BtnVisualizarOpcoesClick / BtnImprimirOpcoesClick - botoes Visualizar e
3103:     * Imprimir do painel ImprimeOpcoes. Legado: ThisForm.ProcImp() monta
3104:     * TmpRelat/TmpFinal, "Report Form SIGOPCGC Preview|To Print Prompt",
3105:     * libera os dois cursores e reabilita a tela.
3106:     *==========================================================================
3107:     PROCEDURE BtnVisualizarOpcoesClick()
3108:         THIS.ExecutarImpressao("PREVIEW")
3109:     ENDPROC
3110: 
3111:     PROCEDURE BtnImprimirOpcoesClick()
3112:         THIS.ExecutarImpressao("PRINTER_PROMPT")
3113:     ENDPROC
3114: 
3115:     PROTECTED PROCEDURE ExecutarImpressao(par_cModo)
3116:         LOCAL loc_oPag2, loc_nOpcao, loc_nFiltro
3117: 
3118:         loc_oPag2   = THIS.pgf_4c_Paginas.Page2
3119:         loc_nOpcao  = loc_oPag2.cnt_4c_ImprimeOpcoes.obj_4c_Opcao.Value
3120:         loc_nFiltro = loc_oPag2.pgf_4c_Result.Page3.obj_4c_OptSituas.Value
3121: 
3122:         THIS.FormParaBO()
3123: 
3124:         IF THIS.this_oBusinessObject.PrepararDadosImpressao(loc_nOpcao, loc_nFiltro)
3125:             THIS.this_oBusinessObject.ExecutarRelatorio(par_cModo)
3126:         ENDIF
3127: 
3128:         THIS.this_oBusinessObject.LiberarCursoresImpressao()
3129:         THIS.ReabilitarAposImpressao()
3130:     ENDPROC
3131: 
3132:     *==========================================================================
3133:     * BtnSairOpcoesClick - botao Sair do painel ImprimeOpcoes: so fecha o
3134:     * painel e devolve a tela ao estado normal.
3135:     *==========================================================================
3136:     PROCEDURE BtnSairOpcoesClick()
3137:         THIS.ReabilitarAposImpressao()
3138:     ENDPROC
3139: 
3140:     *==========================================================================
3141:     * AplicarPermissoes - bloco de fChecaAcesso do Init do legado, que esconde
3142:     * os botoes que o usuario nao pode acionar:
3143:     *   sem CADASTRO   -> some o botao "Dados Cadastrais" e os dois botoes de
3144:     *                     troca de bloco da Pagina Resultado;
3145:     *   sem MOVIMENTA  -> some o botao "Movimentacao" e os mesmos dois;
3146:     *   sem IMPRIMIR   -> some o botao de impressao do extrato (aba Saldo).
3147:     *
3148:     * O legado ainda reposiciona o CommandGroup (Left + 81 / Width - 81) a
3149:     * cada botao escondido, para a fileira nao ficar com buraco - transcrito.
3150:     *==========================================================================
3151:     PROTECTED PROCEDURE AplicarPermissoes()
3152:         LOCAL loc_oPag1, loc_oPag2, loc_oGrupo
3153: 
3154:         loc_oPag1  = THIS.pgf_4c_Paginas.Page1
3155:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2
3156:         loc_oGrupo = loc_oPag1.cnt_4c_Botoes.cmg_4c_Operacao
3157: 
3158:         IF !fChecaAcesso("SIGOPCGC", "CADASTRO")
3159:             loc_oPag2.cmg_4c_MudaMov.Visible = .F.
3160:             loc_oPag2.cmg_4c_MudaMov.Enabled = .F.
3161:             loc_oPag2.cmg_4c_MudaFor.Visible = .F.
3162:             loc_oPag2.cmg_4c_MudaFor.Enabled = .F.
3163: 
3164:             *-- Buttons(3) = cmd_cadastro no legado
3165:             loc_oGrupo.Buttons(3).Visible = .F.
3166:             loc_oGrupo.Buttons(3).Enabled = .F.
3167:             loc_oGrupo.Buttons(1).Left    = loc_oGrupo.Buttons(1).Left - 81
3168:             loc_oGrupo.Buttons(2).Left    = loc_oGrupo.Buttons(2).Left - 81
3169:             loc_oGrupo.Width              = loc_oGrupo.Width - 81
3170:             loc_oGrupo.Left               = loc_oGrupo.Left  + 81
3171:         ENDIF
3172: 
3173:         IF !fChecaAcesso("SIGOPCGC", "MOVIMENTA")
3174:             loc_oPag2.cmg_4c_MudaMov.Visible = .F.
3175:             loc_oPag2.cmg_4c_MudaMov.Enabled = .F.
3176:             loc_oPag2.cmg_4c_MudaFor.Visible = .F.
3177:             loc_oPag2.cmg_4c_MudaFor.Enabled = .F.
3178: 
3179:             *-- Buttons(1) = cmd_movimenta no legado
3180:             loc_oGrupo.Buttons(1).Visible = .F.
3181:             loc_oGrupo.Buttons(1).Enabled = .F.
3182:             loc_oGrupo.Buttons(2).Left    = loc_oGrupo.Buttons(2).Left - 81
3183:             loc_oGrupo.Width              = loc_oGrupo.Width - 81
3184:             loc_oGrupo.Left               = loc_oGrupo.Left  + 81
3185:         ENDIF
3186: 
3187:         IF !fChecaAcesso("SIGOPCGC", "IMPRIMIR")
3188:             loc_oPag2.pgf_4c_Result.Page1.cmd_4c_ImprimirExtrato.Visible = .F.
3189:         ENDIF
3190:     ENDPROC
3191: 
3192:     *==========================================================================
3193:     * OptAnaliseChange - InteractiveChange de obj_4c_Opt_Analise (Page1).
3194:     * Legado: os When de Get_DataI/Get_DataF/Get_Moeda/Get_Empresa so
3195:     * retornam .T. (campo habilitado) quando Opt_Analise.Value = 1 ("Sim");
3196:     * o Valid de Opt_Analise ainda limpa os 4 campos quando Value = 2.
3197:     *==========================================================================
3198:     PROCEDURE OptAnaliseChange()
3199:         LOCAL loc_oPag, loc_lHabilita
3200: 
3201:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3202: 
3203:         loc_oPag      = THIS.pgf_4c_Paginas.Page1
3204:         loc_lHabilita = (loc_oPag.obj_4c_Opt_Analise.Value = 1)
3205: 
3206:         loc_oPag.txt_4c_Datai.Enabled   = loc_lHabilita
3207:         loc_oPag.txt_4c_Dataf.Enabled   = loc_lHabilita
3208:         loc_oPag.txt_4c_Moeda.Enabled   = loc_lHabilita
3209:         loc_oPag.txt_4c_Empresa.Enabled = loc_lHabilita
3210: 
3211:         IF !loc_lHabilita
3212:             loc_oPag.txt_4c_Datai.Value   = {}
3213:             loc_oPag.txt_4c_Dataf.Value   = {}
3214:             loc_oPag.txt_4c_Moeda.Value   = ""
3215:             loc_oPag.txt_4c_Empresa.Value = ""
3216:         ENDIF
3217:     ENDPROC
3218: 
3219:     *==========================================================================
3220:     * ValidarDataI - KeyPress de txt_4c_Datai (Page1). Legado (Get_Datai.
3221:     * Valid): se Get_DataF estiver vazio, preenche com GoMonth(DataI, 1).
3222:     *==========================================================================
3223:     PROCEDURE ValidarDataI(par_nKeyCode, par_nShiftAltCtrl)
3224:         LOCAL loc_oPag
3225: 
3226:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3227: 
3228:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3229:             RETURN
3230:         ENDIF
3231: 
3232:         loc_oPag = THIS.pgf_4c_Paginas.Page1
3233:         IF EMPTY(loc_oPag.txt_4c_Dataf.Value) AND !EMPTY(loc_oPag.txt_4c_Datai.Value)
3234:             loc_oPag.txt_4c_Dataf.Value = GOMONTH(loc_oPag.txt_4c_Datai.Value, 1)
3235:         ENDIF
3236:     ENDPROC
3237: 
3238:     *==========================================================================
3239:     * ValidarDataF - KeyPress de txt_4c_Dataf (Page1). Legado (Get_Dataf.
3240:     * InteractiveChange): ThisForm.ConsultaExecutada = .F. - sem validacao
3241:     * de valor no Valid, so invalida o cache da ultima consulta.
3242:     *==========================================================================
3243:     PROCEDURE ValidarDataF(par_nKeyCode, par_nShiftAltCtrl)
3244:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3245:     ENDPROC
3246: 
3247:     *==========================================================================
3248:     * ValidarMoeda - KeyPress de txt_4c_Moeda (Page1). Legado (Get_Moeda.
3249:     * Valid): fwbuscaext em SigCdMoe.cmoes - aqui com match exato via
3250:     * SQLEXEC e fallback no picker AbrirBuscaMoeda().
3251:     *==========================================================================
3252:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
3253:         LOCAL loc_cVal, loc_nResult, loc_oErro
3254: 
3255:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3256: 
3257:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3258:             RETURN
3259:         ENDIF
3260: 
3261:         loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value)
3262:         IF EMPTY(loc_cVal)
3263:             RETURN
3264:         ENDIF
3265: 
3266:         TRY
3267:             IF USED("cursor_4c_MoedaVal")
3268:                 USE IN cursor_4c_MoedaVal
3269:             ENDIF
3270:             loc_nResult = SQLEXEC(gnConnHandle, ;
3271:                 "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cVal), ;
3272:                 "cursor_4c_MoedaVal")
3273:             IF loc_nResult > 0 AND USED("cursor_4c_MoedaVal") AND !EOF("cursor_4c_MoedaVal")
3274:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_MoedaVal.cmoes)
3275:             ELSE
3276:                 THIS.AbrirBuscaMoeda()
3277:             ENDIF
3278:             IF USED("cursor_4c_MoedaVal")
3279:                 USE IN cursor_4c_MoedaVal
3280:             ENDIF
3281:         CATCH TO loc_oErro
3282:             MsgErro(loc_oErro.Message, "Erro")
3283:         ENDTRY
3284:     ENDPROC
3285: 
3286:     *==========================================================================
3287:     * AbrirBuscaMoeda - picker por cmoes/dmoes em SigCdMoe
3288:     *==========================================================================
3289:     PROCEDURE AbrirBuscaMoeda()
3290:         LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_lProsseguir, loc_oErro
3291: 
3292:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value)
3293: 
3294:         IF USED("cursor_4c_BuscaMoeda")
3295:             USE IN cursor_4c_BuscaMoeda
3296:         ENDIF
3297: 
3298:         loc_lProsseguir = .T.
3299:         TRY
3300:             IF EMPTY(loc_cValor)
3301:                 loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe ORDER BY cmoes"
3302:             ELSE
3303:                 loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
3304:                            "WHERE cmoes LIKE " + EscaparSQL(loc_cValor + "%") + ;
3305:                            " OR RTRIM(dmoes) LIKE " + EscaparSQL(loc_cValor + "%") + ;
3306:                            " ORDER BY cmoes"
3307:             ENDIF
3308:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda")
3309: 
3310:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaMoeda") OR RECCOUNT("cursor_4c_BuscaMoeda") = 0) ;
3311:                     AND !EMPTY(loc_cValor)
3312:                 IF USED("cursor_4c_BuscaMoeda")
3313:                     USE IN cursor_4c_BuscaMoeda
3314:                 ENDIF
3315:                 loc_nResult = SQLEXEC(gnConnHandle, ;
3316:                     "SELECT cmoes, dmoes FROM SigCdMoe ORDER BY cmoes", "cursor_4c_BuscaMoeda")
3317:             ENDIF
3318: 
3319:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaMoeda") OR RECCOUNT("cursor_4c_BuscaMoeda") = 0
3320:                 MsgAviso("Nenhuma moeda encontrada.", "Moedas")
3321:                 loc_lProsseguir = .F.
3322:             ENDIF
3323: 
3324:             IF loc_lProsseguir
3325:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3326:                 IF VARTYPE(loc_oBusca) = "O"
3327:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMoeda"
3328:                     loc_oBusca.this_cTitulo        = "Moedas"
3329:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Moedas"
3330:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = "Moedas"
3331:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3332:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3333:                     loc_oBusca.Show()
3334:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
3335:                         SELECT cursor_4c_BuscaMoeda
3336:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
3337:                     ELSE
3338:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ""
3339:                     ENDIF
3340:                     loc_oBusca.Release()
3341:                 ENDIF
3342:             ELSE
3343:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ""
3344:             ENDIF
3345:         CATCH TO loc_oErro
3346:             MsgErro(loc_oErro.Message, "Erro")
3347:         ENDTRY
3348: 
3349:         IF USED("cursor_4c_BuscaMoeda")
3350:             USE IN cursor_4c_BuscaMoeda
3351:         ENDIF
3352:     ENDPROC
3353: 
3354:     *==========================================================================
3355:     * ValidarEmpresa - KeyPress de txt_4c_Empresa (Page1). Legado (Get_
3356:     * Empresa.Valid): fAcessoEmpresa(Usuar,'C',This.Value,This.Parent.
3357:     * Get_Empresa) - fAcessoEmpresa NAO foi portada (regra CLAUDE.md), aqui
3358:     * substituida por match exato em SigCdEmp.Cemps + VerificarAcessoEmpresa
3359:     * (modo check) + fallback no picker AbrirBuscaEmpresa().
3360:     *==========================================================================
3361:     PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
3362:         LOCAL loc_cVal, loc_nResult, loc_oErro
3363: 
3364:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3365: 
3366:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3367:             RETURN
3368:         ENDIF
3369: 
3370:         loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
3371:         IF EMPTY(loc_cVal)
3372:             RETURN
3373:         ENDIF
3374: 
3375:         TRY
3376:             IF USED("cursor_4c_EmpVal")
3377:                 USE IN cursor_4c_EmpVal
3378:             ENDIF
3379:             loc_nResult = SQLEXEC(gnConnHandle, ;
3380:                 "SELECT TOP 1 Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
3381:                 "cursor_4c_EmpVal")
3382:             IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
3383:                 IF !VerificarAcessoEmpresa(gc_4c_UsuarioLogado, ALLTRIM(cursor_4c_EmpVal.Cemps))
3384:                     MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3385:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3386:                 ELSE
3387:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_EmpVal.Cemps)
3388:                 ENDIF
3389:             ELSE
3390:                 THIS.AbrirBuscaEmpresa()
3391:             ENDIF
3392:             IF USED("cursor_4c_EmpVal")
3393:                 USE IN cursor_4c_EmpVal
3394:             ENDIF
3395:         CATCH TO loc_oErro
3396:             MsgErro(loc_oErro.Message, "Erro")
3397:         ENDTRY
3398:     ENDPROC
3399: 
3400:     *==========================================================================
3401:     * AbrirBuscaEmpresa - picker por Cemps/Razas em SigCdEmp
3402:     *==========================================================================
3403:     PROCEDURE AbrirBuscaEmpresa()
3404:         LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_lProsseguir, loc_oErro, loc_cTitulo
3405: 
3406:         loc_cValor  = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
3407:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"
3408: 
3409:         IF USED("cursor_4c_BuscaEmp")
3410:             USE IN cursor_4c_BuscaEmp
3411:         ENDIF
3412: 
3413:         loc_lProsseguir = .T.
3414:         TRY
3415:             IF EMPTY(loc_cValor)
3416:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
3417:             ELSE
3418:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
3419:                            "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
3420:                            " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
3421:                            " ORDER BY Cemps"
3422:             ENDIF
3423:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
3424: 
3425:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0) ;
3426:                     AND !EMPTY(loc_cValor)
3427:                 IF USED("cursor_4c_BuscaEmp")
3428:                     USE IN cursor_4c_BuscaEmp
3429:                 ENDIF
3430:                 loc_nResult = SQLEXEC(gnConnHandle, ;
3431:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", "cursor_4c_BuscaEmp")
3432:             ENDIF
3433: 
3434:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0
3435:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
3436:                 loc_lProsseguir = .F.
3437:             ENDIF
3438: 
3439:             IF loc_lProsseguir
3440:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3441:                 IF VARTYPE(loc_oBusca) = "O"
3442:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
3443:                     loc_oBusca.this_cTitulo        = loc_cTitulo
3444:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
3445:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
3446:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
3447:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
3448:                     loc_oBusca.Show()
3449:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
3450:                         SELECT cursor_4c_BuscaEmp
3451:                         IF VerificarAcessoEmpresa(gc_4c_UsuarioLogado, ALLTRIM(cursor_4c_BuscaEmp.Cemps))
3452:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
3453:                         ELSE
3454:                             MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3455:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3456:                         ENDIF
3457:                     ELSE
3458:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3459:                     ENDIF
3460:                     loc_oBusca.Release()
3461:                 ENDIF
3462:             ELSE
3463:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3464:             ENDIF
3465:         CATCH TO loc_oErro
3466:             MsgErro(loc_oErro.Message, "Erro")
3467:         ENDTRY
3468: 
3469:         IF USED("cursor_4c_BuscaEmp")
3470:             USE IN cursor_4c_BuscaEmp
3471:         ENDIF
3472:     ENDPROC
3473: 
3474:     *==========================================================================
3475:     * ValidarGrupo - KeyPress de txt_4c_Grupo (container cnt_4c_Origem,
3476:     * Page1). Legado (Origem.Get_grupo.Valid): fAcessoContab(...) + Seek em
3477:     * CrSigCdGcr + ajusta Left/Width/Visible de Get_DConta/Get_Cpf conforme
3478:     * CrSigCdGcr.tpcads (1 = mostra CPF e encolhe DConta; != 1 = esconde CPF
3479:     * e DConta ocupa a largura toda). fAcessoContab ja esta portada em
3480:     * utils\functions.prg (abre o picker internamente quando nao acha).
3481:     *==========================================================================
3482:     PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
3483:         LOCAL loc_oOrigem, loc_cVal, loc_nResult, loc_oErro
3484: 
3485:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3486: 
3487:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3488:             RETURN
3489:         ENDIF
3490: 
3491:         loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3492:         loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3493: 
3494:         IF EMPTY(loc_cVal)
3495:             RETURN
3496:         ENDIF
3497: 
3498:         TRY
3499:             fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cVal, loc_oOrigem.txt_4c_Grupo)
3500: 
3501:             loc_cVal = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3502:             IF !EMPTY(loc_cVal)
3503:                 IF USED("cursor_4c_GrpVal")
3504:                     USE IN cursor_4c_GrpVal
3505:                 ENDIF
3506:                 loc_nResult = SQLEXEC(gnConnHandle, ;
3507:                     "SELECT TOP 1 tpcads FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cVal), ;
3508:                     "cursor_4c_GrpVal")
3509:                 IF loc_nResult > 0 AND USED("cursor_4c_GrpVal") AND !EOF("cursor_4c_GrpVal")
3510:                     IF cursor_4c_GrpVal.tpcads = 1
3511:                         loc_oOrigem.txt_4c_Dconta.Left  = 326
3512:                         loc_oOrigem.txt_4c_Dconta.Width = 278
3513:                         loc_oOrigem.lbl_4c__dConta.Left = 329
3514:                         loc_oOrigem.txt_4c_Cpf.Visible   = .T.
3515:                         loc_oOrigem.lbl_4c__CPF.Visible  = .T.
3516:                     ELSE
3517:                         loc_oOrigem.txt_4c_Dconta.Left  = 177
3518:                         loc_oOrigem.txt_4c_Dconta.Width = 427
3519:                         loc_oOrigem.lbl_4c__dConta.Left = 180
3520:                         loc_oOrigem.txt_4c_Cpf.Visible   = .F.
3521:                         loc_oOrigem.lbl_4c__CPF.Visible  = .F.
3522:                     ENDIF

*-- Linhas 3529 a 3822:
3529:             MsgErro(loc_oErro.Message, "Erro")
3530:         ENDTRY
3531:     ENDPROC
3532: 
3533:     *==========================================================================
3534:     * ValidarConta - KeyPress de txt_4c_Conta (container cnt_4c_Origem,
3535:     * Page1). Legado (Origem.Get_conta.Valid): fAcessoContas(...) valida o
3536:     * acesso e preenche Get_DConta; em caso de sucesso, CursorQuery em
3537:     * SigCdCli completa Grupo (se vazio) e Cpf.
3538:     *==========================================================================
3539:     PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
3540:         LOCAL loc_oOrigem, loc_cVal, loc_cGrupo, loc_nResult, loc_oErro
3541: 
3542:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3543: 
3544:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3545:             RETURN
3546:         ENDIF
3547: 
3548:         loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3549:         loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
3550:         loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3551: 
3552:         IF EMPTY(loc_cVal)
3553:             loc_oOrigem.txt_4c_Dconta.Value = ""
3554:             loc_oOrigem.txt_4c_Cpf.Value    = ""
3555:             RETURN
3556:         ENDIF
3557: 
3558:         TRY
3559:             IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cVal, ;
3560:                     loc_oOrigem.txt_4c_Conta, loc_oOrigem.txt_4c_Dconta)
3561:                 MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3562:                 loc_oOrigem.txt_4c_Conta.Value  = ""
3563:                 loc_oOrigem.txt_4c_Dconta.Value = ""
3564:                 loc_oOrigem.txt_4c_Cpf.Value    = ""
3565:             ELSE
3566:                 loc_cVal = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
3567:                 IF !EMPTY(loc_cVal)
3568:                     IF USED("cursor_4c_CtaVal")
3569:                         USE IN cursor_4c_CtaVal
3570:                     ENDIF
3571:                     loc_nResult = SQLEXEC(gnConnHandle, ;
3572:                         "SELECT TOP 1 grupos, cpfs FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cVal), ;
3573:                         "cursor_4c_CtaVal")
3574:                     IF loc_nResult > 0 AND USED("cursor_4c_CtaVal") AND !EOF("cursor_4c_CtaVal")
3575:                         IF EMPTY(loc_oOrigem.txt_4c_Grupo.Value)
3576:                             loc_oOrigem.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_CtaVal.grupos)
3577:                         ENDIF
3578:                         loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_CtaVal.cpfs)
3579:                     ENDIF
3580:                     IF USED("cursor_4c_CtaVal")
3581:                         USE IN cursor_4c_CtaVal
3582:                     ENDIF
3583:                 ENDIF
3584:             ENDIF
3585:         CATCH TO loc_oErro
3586:             MsgErro(loc_oErro.Message, "Erro")
3587:         ENDTRY
3588:     ENDPROC
3589: 
3590:     *==========================================================================
3591:     * ValidarDConta - KeyPress de txt_4c_Dconta (container cnt_4c_Origem,
3592:     * Page1). Legado (Origem.Get_dconta.Valid): fAcessoContas(...,'D',...)
3593:     * busca pelo NOME e preenche Get_Conta; mesmo complemento de Grupo/Cpf
3594:     * via CursorQuery do ValidarConta.
3595:     *==========================================================================
3596:     PROCEDURE ValidarDConta(par_nKeyCode, par_nShiftAltCtrl)
3597:         LOCAL loc_oOrigem, loc_cVal, loc_cGrupo, loc_nResult, loc_oErro
3598: 
3599:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3600: 
3601:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3602:             RETURN
3603:         ENDIF
3604: 
3605:         loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3606:         loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Dconta.Value)
3607:         loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3608: 
3609:         IF EMPTY(loc_cVal)
3610:             loc_oOrigem.txt_4c_Conta.Value = ""
3611:             loc_oOrigem.txt_4c_Cpf.Value   = ""
3612:             RETURN
3613:         ENDIF
3614: 
3615:         TRY
3616:             IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cVal, ;
3617:                     loc_oOrigem.txt_4c_Conta, loc_oOrigem.txt_4c_Dconta)
3618:                 MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3619:                 loc_oOrigem.txt_4c_Conta.Value  = ""
3620:                 loc_oOrigem.txt_4c_Dconta.Value = ""
3621:                 loc_oOrigem.txt_4c_Cpf.Value    = ""
3622:             ELSE
3623:                 loc_cVal = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
3624:                 IF !EMPTY(loc_cVal)
3625:                     IF USED("cursor_4c_CtaVal")
3626:                         USE IN cursor_4c_CtaVal
3627:                     ENDIF
3628:                     loc_nResult = SQLEXEC(gnConnHandle, ;
3629:                         "SELECT TOP 1 grupos, cpfs FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cVal), ;
3630:                         "cursor_4c_CtaVal")
3631:                     IF loc_nResult > 0 AND USED("cursor_4c_CtaVal") AND !EOF("cursor_4c_CtaVal")
3632:                         IF EMPTY(loc_oOrigem.txt_4c_Grupo.Value)
3633:                             loc_oOrigem.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_CtaVal.grupos)
3634:                         ENDIF
3635:                         loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_CtaVal.cpfs)
3636:                     ENDIF
3637:                     IF USED("cursor_4c_CtaVal")
3638:                         USE IN cursor_4c_CtaVal
3639:                     ENDIF
3640:                 ENDIF
3641:             ENDIF
3642:         CATCH TO loc_oErro
3643:             MsgErro(loc_oErro.Message, "Erro")
3644:         ENDTRY
3645:     ENDPROC
3646: 
3647:     *==========================================================================
3648:     * ValidarCpf - KeyPress de txt_4c_Cpf (container cnt_4c_Origem, Page1).
3649:     * Legado (Origem.Get_cpf.Valid): fwbuscaext em SigCdCli.cpfs (aqui via
3650:     * FormBuscaAuxiliar - mAddColuna cpfs/iclis/rclis) + fAcessoContas para
3651:     * validar o acesso ao registro escolhido e preencher Conta/DConta.
3652:     *==========================================================================
3653:     PROCEDURE ValidarCpf(par_nKeyCode, par_nShiftAltCtrl)
3654:         LOCAL loc_oOrigem, loc_cVal, loc_cGrupo, loc_oBusca, loc_oErro
3655: 
3656:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3657: 
3658:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3659:             RETURN
3660:         ENDIF
3661: 
3662:         loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3663:         loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Cpf.Value)
3664:         loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3665: 
3666:         IF EMPTY(loc_cVal)
3667:             loc_oOrigem.txt_4c_Dconta.Value = ""
3668:             loc_oOrigem.txt_4c_Conta.Value  = ""
3669:             RETURN
3670:         ENDIF
3671: 
3672:         TRY
3673:             IF USED("cursor_4c_BuscaCpf")
3674:                 USE IN cursor_4c_BuscaCpf
3675:             ENDIF
3676: 
3677:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
3678:                 "cursor_4c_BuscaCpf", "cpfs", loc_cVal, "Fornecedores")
3679: 
3680:             IF VARTYPE(loc_oBusca) = "O"
3681:                 IF !loc_oBusca.this_lAchouRegistro
3682:                     loc_oBusca.mAddColuna("cpfs",  "", "CPF / CGC")
3683:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
3684:                     loc_oBusca.mAddColuna("rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
3685:                     loc_oBusca.Show()
3686:                 ENDIF
3687: 
3688:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
3689:                     SELECT cursor_4c_BuscaCpf
3690:                     loc_cVal = ALLTRIM(cursor_4c_BuscaCpf.iclis)
3691: 
3692:                     IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cVal, ;
3693:                             loc_oOrigem.txt_4c_Conta, loc_oOrigem.txt_4c_Dconta)
3694:                         MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3695:                         loc_oOrigem.txt_4c_Cpf.Value    = ""
3696:                         loc_oOrigem.txt_4c_Conta.Value  = ""
3697:                         loc_oOrigem.txt_4c_Dconta.Value = ""
3698:                     ELSE
3699:                         loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCpf.cpfs)
3700:                     ENDIF
3701:                 ENDIF
3702:                 loc_oBusca.Release()
3703:             ENDIF
3704: 
3705:             IF USED("cursor_4c_BuscaCpf")
3706:                 USE IN cursor_4c_BuscaCpf
3707:             ENDIF
3708:         CATCH TO loc_oErro
3709:             MsgErro(loc_oErro.Message, "Erro")
3710:         ENDTRY
3711:     ENDPROC
3712: 
3713:     *==========================================================================
3714:     * FormParaBO - Transfere filtros da Page1 para o Business Object
3715:     *==========================================================================
3716:     PROCEDURE FormParaBO()
3717:         LOCAL loc_oPag, loc_oOrigem
3718: 
3719:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
3720:         loc_oOrigem = loc_oPag.cnt_4c_Origem
3721: 
3722:         WITH THIS.this_oBusinessObject
3723:             .this_nAnalise = loc_oPag.obj_4c_Opt_Analise.Value
3724:             .this_dDataI   = ConverterParaData(loc_oPag.txt_4c_Datai.Value)
3725:             .this_dDataF   = ConverterParaData(loc_oPag.txt_4c_Dataf.Value)
3726:             .this_cMoeda   = ALLTRIM(loc_oPag.txt_4c_Moeda.Value)
3727:             .this_cEmpresa = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)
3728: 
3729:             .this_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3730:             .this_cConta  = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
3731:             .this_cDConta = ALLTRIM(loc_oOrigem.txt_4c_Dconta.Value)
3732:             .this_cCpf    = ALLTRIM(loc_oOrigem.txt_4c_Cpf.Value)
3733:         ENDWITH
3734:     ENDPROC
3735: 
3736:     *==========================================================================
3737:     * BOParaForm - Transfere os dados cadastrais do fornecedor pesquisado
3738:     * (Business Object) para os TextBoxes de cnt_4c_Cadastro (Page2).
3739:     *==========================================================================
3740:     PROCEDURE BOParaForm()
3741:         LOCAL loc_oCad
3742: 
3743:         loc_oCad = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cadastro
3744: 
3745:         WITH THIS.this_oBusinessObject
3746:             loc_oCad.txt_4c_CodFor.Value = .this_cCodFor
3747:             loc_oCad.txt_4c_Nome.Value   = .this_cNome
3748:             loc_oCad.txt_4c_End.Value    = .this_cEnd
3749:             loc_oCad.txt_4c_Bairro.Value = .this_cBairro
3750:             loc_oCad.txt_4c_Cep.Value    = .this_cCep
3751:             loc_oCad.txt_4c_Cid.Value    = .this_cCid
3752:             loc_oCad.txt_4c_Est.Value    = .this_cEst
3753:             loc_oCad.txt_4c_Tel1.Value   = .this_cTel1
3754:             loc_oCad.txt_4c_Tel2.Value   = .this_cTel2
3755:             loc_oCad.txt_4c_Fax.Value    = .this_cFax
3756:             loc_oCad.txt_4c_Cgc.Value    = .this_cCgc
3757:             loc_oCad.txt_4c_Ie.Value     = .this_cIe
3758:         ENDWITH
3759:     ENDPROC
3760: 
3761:     *==========================================================================
3762:     * TornarControlesVisiveis - Torna visiveis os controles criados via
3763:     * AddObject (que nascem com Visible=.F.), recursivamente em Pages e
3764:     * Containers. cmg_4c_MudaFor comeca Visible=.F. de proposito (igual ao
3765:     * legado: so um dos Cmd_MudaFor/Cmd_MudaMov fica visivel por vez,
3766:     * alternado por BtnMudaForClick/BtnMudaMovClick) e img_4c_Figura comeca
3767:     * Visible=.F. porque SigCdCli nao tem coluna de foto (fica so o aviso
3768:     * "Foto nao disponivel") - pular esses nomes SEM deixar de recursar nos
3769:     * filhos deles (regra CLAUDE.md "Form OPERACIONAL / Containers
3770:     * Flutuantes").
3771:     *==========================================================================
3772:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3773:         LOCAL loc_nI, loc_oObjeto, loc_nP, loc_lPularVisible
3774: 
3775:         IF VARTYPE(par_oContainer) != "O"
3776:             RETURN
3777:         ENDIF
3778: 
3779:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3780:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3781: 
3782:             *-- Controles que NASCEM ocultos no legado e sao revelados por
3783:             *-- codigo. O LOOP nao eh usado aqui de proposito: pular o
3784:             *-- objeto sem recursar deixaria os FILHOS dele com Visible = .F.
3785:             *-- para sempre, e o container apareceria VAZIO quando revelado.
3786:             *--   CMG_4C_MUDAFOR / CMG_4C_MUDAMOV - so um por vez, alternados
3787:             *--   PGF_4C_RESULT         - a Pagina Resultado abre no cadastro
3788:             *--   CNT_4C_IMPRIMEOPCOES  - painel de opcoes de impressao
3789:             *--   GRD_4C_PENDENTEOCULTA - Grid1 do legado, nunca exibida
3790:             *--   IMG_4C_FIGURA / IMG_4C_FOTOPRODUTO - so com foto disponivel
3791:             *--   LBL_4C_MSGFOTO / LBL_4C_MSGFOTOPRODUTO - so SEM foto
3792:             *--   LBL_4C_MENSAGEM1 / 2 - so sem Analise de Vendas
3793:             loc_lPularVisible = INLIST(UPPER(loc_oObjeto.Name), ;
3794:                 "CMG_4C_MUDAFOR", "CMG_4C_MUDAMOV", "PGF_4C_RESULT", ;
3795:                 "CNT_4C_IMPRIMEOPCOES", "GRD_4C_PENDENTEOCULTA", ;
3796:                 "IMG_4C_FIGURA", "IMG_4C_FOTOPRODUTO", "LBL_4C_MSGFOTO", ;
3797:                 "LBL_4C_MSGFOTOPRODUTO", "LBL_4C_MENSAGEM1", "LBL_4C_MENSAGEM2")
3798: 
3799:             IF !loc_lPularVisible AND PEMSTATUS(loc_oObjeto, "Visible", 5)
3800:                 loc_oObjeto.Visible = .T.
3801:             ENDIF
3802: 
3803:             IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3804:                 FOR loc_nP = 1 TO loc_oObjeto.PageCount
3805:                     THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3806:                 ENDFOR
3807:             ELSE
3808:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3809:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3810:                 ENDIF
3811:             ENDIF
3812:         ENDFOR
3813:     ENDPROC
3814: 
3815:     *==========================================================================
3816:     * DESTROY - delega para FormBase.Destroy (restaura menu apos fechamento)
3817:     *==========================================================================
3818:     PROCEDURE Destroy()
3819:         RETURN DODEFAULT()
3820:     ENDPROC
3821: 
3822: ENDDEFINE

