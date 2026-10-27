# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (12)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.GetOpWhenCheck()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.GetEnvWhenCheck()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.GetPedidoWhenCheck()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.GetNumeroWhenCheck()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-HEADER] Header Caption 'Envelope' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Fase, Quantidade, Dt. Entrega, %, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Op' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Fase, Quantidade, Dt. Entrega, %, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Fase, Quantidade, Dt. Entrega, %, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Qtde' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Fase, Quantidade, Dt. Entrega, %, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Fase, Quantidade, Dt. Entrega, %, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Origem' (parent: SIGOPCGR.fld_principal.pag_consulta): Top original=201 vs migrado 'cnt_4c_Origem' Top=5 (diff=196px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Origem' (parent: SIGOPCGR.fld_principal.pag_consulta): Left original=203 vs migrado 'cnt_4c_Origem' Left=6 (diff=197px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCgr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1804 linhas total):

*-- Linhas 23 a 181:
23: * pipeline (ConfigurarPaginaLista/ConfigurarPaginaDados) mesmo as paginas
24: * nao sendo Lista/Dados de CRUD - mesma convencao de Formsigopcgc.prg.
25: *
26: * FASE 3/8: Estrutura base do Form - DEFINE CLASS, Init/InicializarForm,
27: * ConfigurarPageFrame com as 2 paginas (Consulta/Resultado) e os
28: * containers principais vazios: cnt_4c_Cabecalho (faixa do titulo, nas
29: * DUAS paginas - regra CLAUDE.md #11, que prevalece sobre o legado, cujo
30: * dump so tem cntSombra em pag_consulta), cnt_4c_Botoes (Page1 - vai
31: * receber o CommandGroup Encerrar + o botao Processar na Fase 4) e
32: * cnt_4c_BotoesAcao (Page2 - vai receber o CommandGroup Voltar + o botao
33: * Rastreab. na Fase 4).
34: *
35: * Largura do form escalada para o canonico 1000x600 (legado: 800x600),
36: * mesma convencao de Formsigopcgc.prg/Formsigopcgp.prg (familia de
37: * dialogos de pesquisa/consulta OPERACIONAL). Os botoes sao transcritos
38: * com o tamanho fisico do dump (75x75/85x85) nas Fases 4+; so a largura
39: * do form e a posicao horizontal dos containers mudam.
40: *
41: * FASE 4/8: Grade de resultado (grd_4c_Dados, ligada a
42: * this_oBusinessObject.this_cCursorResultado) e os botoes de acao:
43: * Page1 - CommandGroup cmg_4c_Operacao (Encerrar) + cmd_4c_Processar;
44: * Page2 - CommandGroup cmg_4c_Operacao (Voltar) + cmd_4c_Rastreab +
45: * Container1 (chk_4c_Op/chk_4c_Envelope/chk_4c_Pedido). Navegacao entre
46: * paginas (AlternarPagina) fica funcional; a consulta SQL dos criterios
47: * (Fase 7-8) depende dos campos de filtro das Fases 5-6.
48: *
49: * FASE 5/8 (PARTE 1/2): Campos do bloco "Dados para pesquisa" (Origem/
50: * Pedido no legado) - Page1. Primeira metade: txt_4c_Op (N. Op) e
51: * txt_4c_Env (Envelope) + respectivos labels, dentro dos containers
52: * cnt_4c_Origem/cnt_4c_Pedido. txt_4c_Pedido/txt_4c_Numero + o label
53: * "Pedido :" ficam para a segunda metade (Fase 6), junto com os
54: * handlers de Valid/When (guard "preencher so um dos tres filtros").
55: *
56: * FASE 6/8 (PARTE 2/2): txt_4c_Pedido (codigo da operacao) + txt_4c_Numero
57: * (numero sequencial) + label "Pedido :", completando o bloco "Dados para
58: * pesquisa". Handlers COMPLETOS dos 4 campos de filtro:
59: *   - When (GetOpWhenCheck/GetEnvWhenCheck/GetPedidoWhenCheck/
60: *     GetNumeroWhenCheck) - guard "preencher so um dos tres" (Op OU
61: *     Envelope OU Pedido+Numero), transcrito dos When legados.
62: *   - LostFocus (ValidarOpLostFocus/ValidarEnvLostFocus/
63: *     ValidarPedidoLostFocus) - equivalente ao Valid legado (regra
64: *     CLAUDE.md #47: lookup/validacao em LostFocus, nunca KeyPress sem
65: *     testar a tecla): Op confere existencia em SigOpPic + empresa
66: *     corrente (SigOpCgrBO.ValidarOperacao); Pedido faz SEEK em
67: *     cursor_4c_Operacoes e, se nao achar, abre o picker local
68: *     AbrirLookupPedido (FormBuscaAuxiliar Pattern A - DefinirCursor/
69: *     Mostrar sobre o cursor JA carregado, equivalente ao fwBuscaSel/
70: *     TmpOper legado). Todos resetam this_lConsultaExecutada quando o
71: *     campo e preenchido, igual ao legado.
72: * cursor_4c_Operacoes (equivalente a TmpOper) e carregado uma unica vez em
73: * InicializarForm, via SigOpCgrBO.CarregarOperacoes() - falha no load
74: * aborta a abertura do form, igual ao Init legado.
75: *
76: * FASE 7/8: Evento principal - BtnProcessarClick (cmdprocessar.Click
77: * legado): guard "preencher ao menos um dos 3 filtros" + transferencia dos
78: * criterios da tela para o BO (este dialogo so-leitura nao tem FormParaBO/
79: * BOParaForm) + THIS.this_oBusinessObject.Processar() (equivalente a
80: * ThisForm.Processa() - a consulta SQL REAL contra SigOpPic/SigPdMvf,
81: * implementada em SigOpCgrBO.prg: Processar/ProcessarPorOp/
82: * ProcessarPorEnvelope/ProcessarPorPedido/BuscarTopoPorOp/
83: * AppendPicagemPorOp/AppendResultado) + navegacao condicionada a haver
84: * linha no resultado (senao MsgAviso "Nenhum Registro Encontrado!!!") +
85: * sincronismo dos 3 CheckBoxes de Container1 (Page2), tudo incondicional
86: * apos o Processar() como no legado. AlternarPagina(2) agora tambem foca
87: * a 1a coluna da grade (equivalente ao ramo Else do pag_resultado.Activate
88: * legado, coberto pelo mesmo guard de ConsultaExecutada).
89: *
90: * Este form OPERACIONAL nao tem CRUD (eh dialogo de PESQUISA, sem Incluir/
91: * Alterar/Visualizar/Excluir no legado - ver "Decisao de projeto" no
92: * cabecalho de SigOpCgrBO.prg) - os eventos principais da Fase 7 sao os
93: * do fluxo real do dialogo (Processar/Encerrar/Voltar/Rastreab./
94: * CheckBoxes), ja implementados nas Fases 4-7.
95: *
96: * FASE 8/8: Eventos auxiliares e consolidacao final. Os metodos canonicos
97: * do pipeline ganham aqui o conteudo que o legado de fato tem, cada um
98: * transcrito de um trecho identificado do dump:
99: *
100: *   VincularGradeResultado() - o bloco "With .Fld_Principal.Pag_Resultado.
101: *     Grd_Produto / .RecordSource = 'dbProduto' / .ColumnCount = 7 / ..."
102: *     do PROCEDURE Init legado. Vira FONTE UNICA do bind da grade
103: *     (ConfigurarPaginaDados e CarregarLista chamam o MESMO metodo), para
104: *     os dois call sites nao divergirem em silencio. ControlSource,
105: *     Header1.Caption e Width sao reaplicados DEPOIS do RecordSource
106: *     (regra CLAUDE.md #41/#48 - RecordSource reseta Width e Caption).
107: *
108: *   CarregarLista() - repintura da grade de resultado: GO TOP no cursor +
109: *     Grid.Refresh (regra CLAUDE.md #21 - popular cursor NAO repinta a
110: *     grade), rebind SO quando o alias ligado ao Grid nao for mais o
111: *     cursor de resultado. Chamado em TODO caminho que popula ou exibe o
112: *     resultado: BtnProcessarClick, AlternarPagina(2) DEPOIS do ActivePage
113: *     (regra #21/Erro192 - Refresh em pagina OCULTA nao pinta) e
114: *     LimparCampos.
115: *
116: *   FormParaBO() / BOParaForm() - transferencia dos 4 campos de filtro
117: *     (Op / Envelope / Pedido+Numero) entre a tela e o BO, nos dois
118: *     sentidos. Antes estava embutida em BtnProcessarClick; extraida
119: *     aqui, BOParaForm passa a ser tambem quem sincroniza os 3 CheckBoxes
120: *     de cnt_4c_ModoRastro (o "With This.Parent.Parent.pag_resultado.
121: *     Container1" do fim do cmdprocessar.Click legado) e as flags
122: *     this_lRastroPor* que BtnRastreabClick consulta.
123: *
124: *   LimparCampos() - o "With .fld_principal.pag_consulta.Origem.Pedido /
125: *     .get_Env.Value = 0 / .get_Op.Value = 0 / .get_Numero.Value = 0 /
126: *     .get_Pedido.Value = Space(20) / EndWith" + ".ConsultaExecutada =
127: *     .f." do PROCEDURE Init legado, mais o "Select DbProduto / Zap" do
128: *     PROCEDURE processa. Passa a ser chamado no fim de InicializarForm,
129: *     que antes nao reproduzia esse trecho do Init.
130: *
131: *   HabilitarCampos(par_lHabilitar) - materializa os When dos 4 campos de
132: *     filtro ("preencher APENAS um dos tres": Op OU Envelope OU
133: *     Pedido+Numero). DESVIO CONSCIENTE do mecanismo legado, registrado:
134: *     o When eh EVENTO, nao propriedade, e nao se atribui a controle
135: *     criado por AddObject; ligado por BINDEVENT ele ate dispara, mas o
136: *     BINDEVENT DESCARTA o retorno do delegate, entao GetOpWhenCheck e
137: *     irmaos (Fase 6) avaliam o guard e nao bloqueiam nada. O equivalente
138: *     que funciona sem subclasse nova eh .Enabled: o usuario continua
139: *     impedido de preencher os outros dois grupos e o foco continua
140: *     pulando os campos bloqueados, com a unica diferenca de que o campo
141: *     bloqueado aparece esmaecido. Os BINDEVENT "When" da Fase 6 ficam no
142: *     lugar (documentam o guard do legado e sao inofensivos), mas quem
143: *     faz valer a regra eh este metodo.
144: *
145: *   AjustarBotoesPorModo() - FUNIL do estado dos botoes (regra CLAUDE.md
146: *     #40 - quem desabilita tem de reabilitar no caminho de volta):
147: *     Processar vive na pagina Consulta, Rastreab. na pagina Resultado e
148: *     so com linha no cursor (o When "Return Not Eof('dbProduto')" do
149: *     Bot_Rastro legado, hoje em AtualizarBotaoRastreab). Chamado por
150: *     AlternarPagina nas DUAS direcoes.
151: *
152: * VISIBILIDADE: FormParaBO / BOParaForm / LimparCampos sao PROTECTED
153: * EXPLICITO porque FormBase ja os declara assim (sao hooks chamados por
154: * FormBase por THIS.) e o VFP9 NAO deixa a subclasse ALARGAR escopo -
155: * declarar sem o modificador nao tornaria publico, so esconderia o fato.
156: * Medido neste form em 2026-10-24: chamados de FORA da classe estouram
157: * "Property FORMPARABO is not found" / "Property LIMPARCAMPOS is not
158: * found" mesmo sem o PROTECTED escrito, e PEMSTATUS(...,5) devolve .T.
159: * (so verifica existencia - regra CLAUDE.md #3/#51). Os demais metodos da
160: * fase (VincularGradeResultado / CarregarLista / HabilitarCampos /
161: * AjustarBotoesPorModo) NAO existem em FormBase/BusinessBase/GridBase,
162: * entao sao publicos de verdade e o harness os alcanca.
163: *
164: * AUSENCIAS LEGITIMAS (nao sao omissao - o legado nao tem o que migrar, e
165: * inventar violaria o PILAR 1 e a regra "NUNCA inventar"):
166: *   - BtnSalvarClick / BtnConfirmarClick: o SCX nao tem botao de gravar.
167: *     Este dialogo eh SO-LEITURA (consulta SigOpPic/SigPdMvf e exibe);
168: *     o botao de acao do legado eh "Processar" -> BtnProcessarClick.
169: *   - BtnCancelarClick: nao ha Page2 de Dados nem modo de edicao
170: *     cancelavel. O unico "voltar" do legado eh o grp_operacao da
171: *     pag_resultado ("ThisForm.fld_principal.ActivePage = 1") -> ja
172: *     migrado como BtnVoltarClick, que e' o nome do que o botao faz.
173: *   - BtnBuscarClick: nao existe botao "Buscar" no SCX - a consulta eh
174: *     disparada por "Processar", e a unica busca auxiliar da tela eh o
175: *     picker do campo Pedido (fwBuscaSel/TmpOper) -> AbrirLookupPedido.
176: *==============================================================================
177: 
178: DEFINE CLASS FormSigOpCgr AS FormBase
179: 
180:     *-- Dimensoes e propriedades visuais (padrao canonico de form OPERACIONAL)
181:     Height      = 600

*-- Linhas 196 a 409:
196:     Themes      = .F.
197: 
198:     *-- Guarda de reentrancia do lookup de Pedido (regra CLAUDE.md #37/#47 -
199:     *-- FormBuscaAuxiliar eh modal, tira o foco e redispara o proprio
200:     *-- LostFocus do campo que o abriu).
201:     this_lEmLookupPedido = .F.
202: 
203:     *-- Guarda "valor-nao-mudou" do ValidarPedidoLostFocus (regra CLAUDE.md
204:     *-- #47): LostFocus dispara SEMPRE, ao contrario do Valid legado, que so
205:     *-- dispara quando o valor MUDA - sem isto, passar pelo campo sem alterar
206:     *-- nada reabriria o picker a cada passagem.
207:     this_cUltimoValidarPedidoLostFocusValidado = ""
208: 
209:     *==========================================================================
210:     * Init() - o legado nao recebe parametros ("PROCEDURE Init" sem
211:     * LPARAMETERS) - DODEFAULT() ja chama InicializarForm via FormBase.Init
212:     *==========================================================================
213:     PROCEDURE Init()
214:         RETURN DODEFAULT()
215:     ENDPROC
216: 
217:     *==========================================================================
218:     * ValidarParametros - guarda de conexao do Init legado ("Impossivel
219:     * Efetuar Conexao Com o Servidor de Banco de Dados..." no CreateObject
220:     * de poDataMgr), com bypass para os modos sem usuario (teste
221:     * automatizado / validacao de UI).
222:     *
223:     * PUBLIC de proposito: o harness da etapa 06b chama metodos do form de
224:     * FORA da classe, e metodo PROTECTED falha em runtime mesmo com
225:     * PEMSTATUS devolvendo .T. (regra CLAUDE.md #1/TesteAutomatico).
226:     *==========================================================================
227:     PROCEDURE ValidarParametros()
228:         LOCAL loc_lValido
229:         loc_lValido = .T.
230: 
231:         IF TYPE("gb_4c_ModoTeste") = "L"
232:             IF gb_4c_ModoTeste
233:                 RETURN .T.
234:             ENDIF
235:         ENDIF
236: 
237:         IF TYPE("gb_4c_ValidandoUI") = "L"
238:             IF gb_4c_ValidandoUI
239:                 RETURN .T.
240:             ENDIF
241:         ENDIF
242: 
243:         DO CASE
244:             CASE TYPE("gnConnHandle") != "N"
245:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
246:                         "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
247:                 loc_lValido = .F.
248:             CASE gnConnHandle <= 0
249:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
250:                         "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
251:                 loc_lValido = .F.
252:         ENDCASE
253: 
254:         RETURN loc_lValido
255:     ENDPROC
256: 
257:     *==========================================================================
258:     * InicializarCursorResultado - Cria o cursor placeholder de resultado
259:     * (equivalente ao "Create Cursor dbProduto(...) / Index On Nops Tag Nops"
260:     * do PROCEDURE Load legado). Estrutura IDENTICA a que a Fase 7/8 vai
261:     * popular via SQLEXEC/APPEND FROM DBF, para o Grid poder ser configurado
262:     * (RecordSource/ControlSource) nesta mesma fase sem a tela quebrar.
263:     *==========================================================================
264:     PROTECTED PROCEDURE InicializarCursorResultado()
265:         LOCAL loc_cCursor
266:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
267: 
268:         IF !USED(loc_cCursor)
269:             SET NULL ON
270:             CREATE CURSOR (loc_cCursor) ;
271:                 (Nenvs N(10), Nops N(10), DopNums C(26), Cpros C(14), ;
272:                  Qtds N(12,3), Grupods C(10), Contads C(10))
273:             SET NULL OFF
274:             INDEX ON Nops TAG Nops
275:         ENDIF
276:     ENDPROC
277: 
278:     *==========================================================================
279:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
280:     *==========================================================================
281:     PROTECTED PROCEDURE InicializarForm()
282:         LOCAL loc_lSucesso, loc_oErro
283:         loc_lSucesso = .F.
284: 
285:         *-- A guarda de conexao fica FORA do TRY (mesmo padrao de
286:         *-- Formsigopcgc.prg): o harness de teste automatizado define
287:         *-- gnConnHandle = 0 de proposito, e a guarda precisa devolver
288:         *-- antes de qualquer SQLEXEC/CREATEOBJECT que dependa de conexao.
289:         IF !THIS.ValidarParametros()
290:             RETURN .F.
291:         ENDIF
292: 
293:         TRY
294:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCgrBO")
295: 
296:             *-- cursor_4c_Operacoes (equivalente a TmpOper do Init legado) -
297:             *-- precisa estar carregado ANTES de ConfigurarPaginaLista, pois
298:             *-- o lookup do campo Pedido (Fase 6) faz SEEK nele. Falha aqui
299:             *-- aborta a abertura do form, igual ao legado ("Favor
300:             *-- Reinicializar o Processo!!!" + Return .f. no Init).
301:             IF THIS.this_oBusinessObject.CarregarOperacoes()
302: 
303:                 *-- Cursor placeholder de cursor_4c_Resultado ANTES do
304:                 *-- PageFrame: a Page2 liga Grid.RecordSource a este alias
305:                 *-- na mesma fase (regra CLAUDE.md #41 - Column.ControlSource
306:                 *-- de cursor inexistente derruba o Init). A estrutura e
307:                 *-- IDENTICA ao Create Cursor dbProduto do Load() legado.
308:                 THIS.InicializarCursorResultado()
309: 
310:                 THIS.ConfigurarPageFrame()
311:                 THIS.ConfigurarPaginaLista()
312:                 THIS.ConfigurarPaginaDados()
313:                 THIS.TornarControlesVisiveis(THIS)
314: 
315:                 THIS.pgf_4c_Paginas.Visible    = .T.
316:                 THIS.pgf_4c_Paginas.ActivePage = 1
317: 
318:                 *-- Estado inicial do Init legado (valores dos 4 filtros +
319:                 *-- ConsultaExecutada = .f.), consolidado em LimparCampos na
320:                 *-- Fase 8 - inclui o guard dos When (HabilitarCampos) e a
321:                 *-- primeira repintura da grade vazia.
322:                 THIS.LimparCampos()
323: 
324:                 loc_lSucesso = .T.
325:             ENDIF
326:         CATCH TO loc_oErro
327:             MsgErro(loc_oErro.Message + CHR(13) + ;
328:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
329:                     "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
330:         ENDTRY
331: 
332:         RETURN loc_lSucesso
333:     ENDPROC
334: 
335:     *==========================================================================
336:     * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas
337:     * (Consulta/Resultado, espelhando pag_consulta/pag_resultado do legado)
338:     *==========================================================================
339:     PROTECTED PROCEDURE ConfigurarPageFrame()
340:         LOCAL loc_oPgf
341: 
342:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
343:         loc_oPgf = THIS.pgf_4c_Paginas
344: 
345:         loc_oPgf.PageCount = 2
346:         loc_oPgf.Top       = -29
347:         loc_oPgf.Left      = 0
348:         loc_oPgf.Width     = THIS.Width
349:         loc_oPgf.Height    = THIS.Height + 29
350:         loc_oPgf.TabIndex  = 1
351:         loc_oPgf.Tabs      = .F.
352: 
353:         loc_oPgf.Page1.Caption = "Consulta"
354:         loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
355: 
356:         loc_oPgf.Page2.Caption = "Resultado"
357:         loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
358: 
359:         loc_oPgf.Visible    = .T.
360:         loc_oPgf.ActivePage = 1
361:     ENDPROC
362: 
363:     *==========================================================================
364:     * ConfigurarPaginaLista - Estrutura da Page1 (Consulta)
365:     * Fase 3/8: so a faixa do cabecalho + container vazio para o botao
366:     * Processar e o CommandGroup Encerrar (Fase 4). Campos de filtro
367:     * (N. Op / Envelope / Pedido / Numero) vem na Fase 5.
368:     *==========================================================================
369:     PROTECTED PROCEDURE ConfigurarPaginaLista()
370:         LOCAL loc_oPag, loc_oCab
371: 
372:         loc_oPag = THIS.pgf_4c_Paginas.Page1
373: 
374:         *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra #11/#39
375:         *-- do CLAUDE.md): os containers de botao ficam em Top=29..33
376:         *-- (dentro da area da faixa) e tem de ser criados DEPOIS para
377:         *-- desenhar por cima.
378:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
379:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
380:         WITH loc_oCab
381:             .Top           = 29
382:             .Left          = 0
383:             .Width         = THIS.Width
384:             .Height        = 80
385:             .BorderWidth   = 0
386:             .SpecialEffect = 0
387:             .BackColor     = RGB(100, 100, 100)
388: 
389:             .AddObject("lbl_4c_Sombra", "Label")
390:             WITH .lbl_4c_Sombra
391:                 .Top       = 15
392:                 .Left      = 10
393:                 .Width     = THIS.Width
394:                 .Height    = 40
395:                 .FontName  = "Tahoma"
396:                 .FontSize  = 16
397:                 .FontBold  = .T.
398:                 .WordWrap  = .T.
399:                 .Alignment = 0
400:                 .BackStyle = 0
401:                 .ForeColor = RGB(0, 0, 0)
402:                 .Caption   = THIS.Caption
403:             ENDWITH
404: 
405:             .AddObject("lbl_4c_Titulo", "Label")
406:             WITH .lbl_4c_Titulo
407:                 .Top       = 18
408:                 .Left      = 10
409:                 .Width     = THIS.Width

*-- Linhas 422 a 443:
422:         *-- Container "Dados para pesquisa" (Origem no legado, Top=201+29=230
423:         *-- apos compensacao do PageFrame.Top=-29 - regra CLAUDE.md #1/#11 -
424:         *-- bem acima do limite Top>=109 imposto pela faixa do cabecalho).
425:         *-- Centralizado horizontalmente no form 1000px (legado: Left=203 no
426:         *-- canvas 800px fica Left=203+(1000-800)/2=303 no canonico 1000px).
427:         loc_oPag.AddObject("cnt_4c_Origem", "Container")
428:         WITH loc_oPag.cnt_4c_Origem
429:             .Top         = 230
430:             .Left        = 303
431:             .Width       = 393
432:             .Height      = 129
433:             .BackStyle   = 0
434:             .BorderColor = RGB(90, 90, 90)
435: 
436:             .AddObject("lbl_4c__Origem1", "Label")
437:             WITH .lbl_4c__Origem1
438:                 .Top       = 5
439:                 .Left      = 6
440:                 .Width     = 119
441:                 .Height    = 15
442:                 .FontName  = "Tahoma"
443:                 .FontSize  = 8

*-- Linhas 652 a 721:
652:             ENDWITH
653:         ENDWITH
654: 
655:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Processar,          "Click", THIS, "BtnProcessarClick")
656:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnEncerrarClick")
657: 
658:         *-- Valid/When dos 3 filtros mutuamente exclusivos (Op OU Envelope OU
659:         *-- Pedido+Numero - regra CLAUDE.md #47: lookup/validacao em
660:         *-- LostFocus, nunca em KeyPress sem testar a tecla).
661:         LOCAL loc_oPedido
662:         loc_oPedido = loc_oPag.cnt_4c_Origem.cnt_4c_Pedido
663: 
664:         BINDEVENT(loc_oPedido.txt_4c_Op,     "LostFocus", THIS, "ValidarOpLostFocus")
665:         BINDEVENT(loc_oPedido.txt_4c_Env,    "LostFocus", THIS, "ValidarEnvLostFocus")
666:         BINDEVENT(loc_oPedido.txt_4c_Pedido, "LostFocus", THIS, "ValidarPedidoLostFocus")
667: 
668:         BINDEVENT(loc_oPedido.txt_4c_Op,     "When", THIS, "GetOpWhenCheck")
669:         BINDEVENT(loc_oPedido.txt_4c_Env,    "When", THIS, "GetEnvWhenCheck")
670:         BINDEVENT(loc_oPedido.txt_4c_Pedido, "When", THIS, "GetPedidoWhenCheck")
671:         BINDEVENT(loc_oPedido.txt_4c_Numero, "When", THIS, "GetNumeroWhenCheck")
672:     ENDPROC
673: 
674:     *==========================================================================
675:     * ConfigurarPaginaDados - Estrutura da Page2 (Resultado)
676:     * Fase 3/8: so a faixa do cabecalho + container vazio para o botao
677:     * Rastreab. e o CommandGroup Voltar (Fase 4). A grade de resultado
678:     * (Grd_Produto) e o Container1 (CheckBoxes de modo de rastreabilidade)
679:     * vem na Fase 4.
680:     *==========================================================================
681:     PROTECTED PROCEDURE ConfigurarPaginaDados()
682:         LOCAL loc_oPag, loc_oCab
683: 
684:         loc_oPag = THIS.pgf_4c_Paginas.Page2
685: 
686:         *-- Faixa do cabecalho - regra #11: o legado so tem cntSombra em
687:         *-- pag_consulta, mas o padrao do sistema novo repete a faixa nas
688:         *-- DUAS paginas (decisao do time, prevalece sobre o PILAR 1).
689:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
690:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
691:         WITH loc_oCab
692:             .Top           = 29
693:             .Left          = 0
694:             .Width         = THIS.Width
695:             .Height        = 80
696:             .BorderWidth   = 0
697:             .SpecialEffect = 0
698:             .BackColor     = RGB(100, 100, 100)
699: 
700:             .AddObject("lbl_4c_Sombra", "Label")
701:             WITH .lbl_4c_Sombra
702:                 .Top       = 15
703:                 .Left      = 10
704:                 .Width     = THIS.Width
705:                 .Height    = 40
706:                 .FontName  = "Tahoma"
707:                 .FontSize  = 16
708:                 .FontBold  = .T.
709:                 .WordWrap  = .T.
710:                 .Alignment = 0
711:                 .BackStyle = 0
712:                 .ForeColor = RGB(0, 0, 0)
713:                 .Caption   = THIS.Caption
714:             ENDWITH
715: 
716:             .AddObject("lbl_4c_Titulo", "Label")
717:             WITH .lbl_4c_Titulo
718:                 .Top       = 18
719:                 .Left      = 10
720:                 .Width     = THIS.Width
721:                 .Height    = 46

*-- Linhas 801 a 845:
801:             ENDWITH
802:         ENDWITH
803: 
804:         BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Rastreab,          "Click", THIS, "BtnRastreabClick")
805:         BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnVoltarClick")
806: 
807:         *-- Container1 do legado - "Pesquisar OP por" (3 CheckBoxes
808:         *-- mutuamente exclusivos que escolhem a chave usada por
809:         *-- Bot_Rastro.Click: Op/Envelope/Pedido). Top original=46 fica
810:         *-- MUITO perto do topo da pagina (regra do re-layout da faixa de
811:         *-- cabecalho, CLAUDE.md #11: controle de dados tem de ficar com
812:         *-- Top >= 115, nao so +29 - no legado esta pagina nao tinha
813:         *-- cabecalho nenhum, e agora tem). Deslocamento aplicado: +40
814:         *-- (Container1 46+29+40=115; Grd_Produto 150+29+40=219, cabe
815:         *-- dentro do form - ver grade abaixo).
816:         loc_oPag.AddObject("cnt_4c_ModoRastro", "Container")
817:         WITH loc_oPag.cnt_4c_ModoRastro
818:             .Top         = 115
819:             .Left        = 35
820:             .Width       = 168
821:             .Height      = 101
822:             .BackStyle   = 0
823:             .BorderColor = RGB(90, 90, 90)
824:             .BorderWidth = 1
825:             .SpecialEffect = 1
826: 
827:             .AddObject("lbl_4c_PesquisarPor", "Label")
828:             WITH .lbl_4c_PesquisarPor
829:                 .Top       = 4
830:                 .Left      = 3
831:                 .Width     = 97
832:                 .Height    = 15
833:                 .FontName  = "Tahoma"
834:                 .FontSize  = 8
835:                 .FontBold  = .T.
836:                 .BackStyle = 0
837:                 .ForeColor = RGB(90, 90, 90)
838:                 .Caption   = "Pesquisar OP por"
839:             ENDWITH
840: 
841:             .AddObject("chk_4c_Op", "CheckBox")
842:             WITH .chk_4c_Op
843:                 .Top       = 24
844:                 .Left      = 36
845:                 .Width     = 93

*-- Linhas 890 a 982:
890:             ENDWITH
891:         ENDWITH
892: 
893:         BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Op,       "Click", THIS, "ChkOpClick")
894:         BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Envelope, "Click", THIS, "ChkEnvelopeClick")
895:         BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Pedido,   "Click", THIS, "ChkPedidoClick")
896: 
897:         *-- Grd_Produto do legado - grade de resultado. ControlSource/
898:         *-- Header1.Caption/Width TRANSCRITOS do PROCEDURE Init legado (que
899:         *-- SOBRESCREVE os headers do dump estatico do SCX - regra "a pagina
900:         *-- segue o Init legado, nao o SCX desenhado"), nao do dump da
901:         *-- SECAO 2 (que tem Column6/7 com Header1.Caption = "Header1").
902:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
903:         WITH loc_oPag.grd_4c_Dados
904:             .Top           = 219
905:             .Left          = 35
906:             .Width         = 729
907:             .Height        = 400
908:             .FontName      = "Tahoma"
909:             .FontSize      = 8
910:             .ReadOnly      = .T.
911:             .DeleteMark    = .F.
912:             .RecordMark    = .F.
913:             .RowHeight     = 17
914:             .ScrollBars    = 2
915:             .GridLineColor = RGB(238, 238, 238)
916:         ENDWITH
917: 
918:         *-- ColumnCount/RecordSource/ControlSource/Width/Header1.Caption
919:         *-- ficam em VincularGradeResultado (Fase 8) - FONTE UNICA do bind,
920:         *-- compartilhada com CarregarLista.
921:         THIS.VincularGradeResultado()
922: 
923:         BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
924:     ENDPROC
925: 
926:     *==========================================================================
927:     * VincularGradeResultado - Liga grd_4c_Dados ao cursor de resultado.
928:     * Transcrito do "With .Fld_Principal.Pag_Resultado.Grd_Produto" do
929:     * PROCEDURE Init legado (que SOBRESCREVE os headers do dump estatico do
930:     * SCX - a pagina segue o Init legado, nao o SCX desenhado: por isso
931:     * Column6/Column7 recebem "Fase"/"Conta" e nao o "Header1" do dump).
932:     *
933:     * ORDEM OBRIGATORIA (regra CLAUDE.md #41/#48): ColumnCount ->
934:     * RecordSource -> ControlSource -> Width -> Header1.Caption. Atribuir
935:     * RecordSource RECALCULA as larguras para o default 90 e zera os
936:     * captions, entao Width/Caption tem de vir DEPOIS - em TODO site que
937:     * re-vincula a grade, e nao so na montagem inicial.
938:     *
939:     * PUBLIC de proposito (regra CLAUDE.md #1/#51 - o harness da etapa 06b
940:     * chama metodos do form de FORA da classe).
941:     *==========================================================================
942:     PROCEDURE VincularGradeResultado()
943:         LOCAL loc_oGrid, loc_cCursor, loc_lSucesso, loc_oErro
944: 
945:         loc_lSucesso = .F.
946:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorResultado
947: 
948:         *-- Column.ControlSource de cursor INEXISTENTE derruba o Init
949:         *-- (regra CLAUDE.md #41) - o placeholder tem de existir antes.
950:         IF !USED(loc_cCursor)
951:             THIS.InicializarCursorResultado()
952:         ENDIF
953: 
954:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
955: 
956:         TRY
957:             *-- ColumnCount so eh reatribuido quando DIVERGE de 7: qualquer
958:             *-- atribuicao recria os objetos Column (regra CLAUDE.md #144) e
959:             *-- aqui nao ha motivo para pagar esse custo a cada repintura.
960:             IF loc_oGrid.ColumnCount != 7
961:                 loc_oGrid.ColumnCount = 7
962:             ENDIF
963: 
964:             loc_oGrid.RecordSource = loc_cCursor
965: 
966:             loc_oGrid.Column1.ControlSource = loc_cCursor + ".Nenvs"
967:             loc_oGrid.Column2.ControlSource = loc_cCursor + ".Nops"
968:             loc_oGrid.Column3.ControlSource = loc_cCursor + ".DopNums"
969:             loc_oGrid.Column4.ControlSource = loc_cCursor + ".Cpros"
970:             loc_oGrid.Column5.ControlSource = loc_cCursor + ".Qtds"
971:             loc_oGrid.Column6.ControlSource = loc_cCursor + ".Grupods"
972:             loc_oGrid.Column7.ControlSource = loc_cCursor + ".Contads"
973: 
974:             *-- Width e Header1.Caption DEPOIS do RecordSource/ControlSource
975:             WITH loc_oGrid.Column1
976:                 .FontSize          = 8
977:                 .Movable           = .F.
978:                 .Resizable         = .F.
979:                 .Width             = 68
980:                 .Header1.Caption   = "Envelope"
981:                 .Header1.Alignment = 2
982:                 .Header1.FontSize  = 8

*-- Linhas 1054 a 1804:
1054:         CATCH TO loc_oErro
1055:             MsgErro(loc_oErro.Message + CHR(13) + ;
1056:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1057:                     "Procedure: " + loc_oErro.Procedure, ;
1058:                     "Erro ao Vincular a Grade de Resultado")
1059:         ENDTRY
1060: 
1061:         RETURN loc_lSucesso
1062:     ENDPROC
1063: 
1064:     *==========================================================================
1065:     * AlternarPagina - troca a pagina ativa do PageFrame (equivalente a
1066:     * ThisForm.fld_principal.ActivePage = N no legado). A ida para a
1067:     * Pagina 2 (Resultado) so acontece se a consulta ja tiver sido rodada
1068:     * (equivalente ao guard do pag_resultado.Activate legado: "If Not
1069:     * ConsultaExecutada Then ActivePage = 1"); na Fase 4 isso bloqueia a
1070:     * navegacao ate a Fase 7/8 implementar Processa() e marcar
1071:     * this_lConsultaExecutada = .T. - comportamento correto, pois sem
1072:     * consulta executada o legado tambem nao muda de pagina.
1073:     *
1074:     * PUBLIC de proposito (regra CLAUDE.md #1/TesteAutomatico - o harness
1075:     * chama metodos do form direto de fora da classe).
1076:     *==========================================================================
1077:     PROCEDURE AlternarPagina(par_nPagina)
1078:         IF par_nPagina = 2 AND !THIS.this_oBusinessObject.this_lConsultaExecutada
1079:             RETURN
1080:         ENDIF
1081: 
1082:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1083: 
1084:         *-- FUNIL de volta (regra CLAUDE.md #40): quem desabilita botao/campo
1085:         *-- ao SAIR de uma pagina tem de reabilitar ao VOLTAR, e isso mora
1086:         *-- aqui, nao em cada botao que entra.
1087:         THIS.AjustarBotoesPorModo()
1088: 
1089:         IF par_nPagina = 2
1090:             *-- Repintura da grade DEPOIS do ActivePage: Refresh em pagina
1091:             *-- OCULTA nao pinta (regra CLAUDE.md #21/Erro192) - o cursor
1092:             *-- foi populado com a Page2 ainda escondida.
1093:             THIS.CarregarLista()
1094: 
1095:             *-- pag_resultado.Activate legado (ramo Else, ja garantido pelo
1096:             *-- guard acima: ConsultaExecutada = .T.): foco na 1a coluna da
1097:             *-- grade de resultado.
1098:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
1099:         ENDIF
1100:     ENDPROC
1101: 
1102:     *==========================================================================
1103:     * AtualizarBotaoRastreab - equivalente ao When do Bot_Rastro legado
1104:     * ("Return Not Eof('dbProduto')"): o botao so fica habilitado quando o
1105:     * cursor de resultado tem pelo menos uma linha.
1106:     *==========================================================================
1107:     PROCEDURE AtualizarBotaoRastreab()
1108:         LOCAL loc_cCursor, loc_lTemRegistro
1109: 
1110:         loc_cCursor      = THIS.this_oBusinessObject.this_cCursorResultado
1111:         loc_lTemRegistro = USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1112: 
1113:         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Rastreab.Enabled = loc_lTemRegistro
1114:     ENDPROC
1115: 
1116:     *==========================================================================
1117:     * BtnProcessarClick - botao "Processar" (Page1). Equivalente a
1118:     * cmdprocessar.Click do legado:
1119:     *   1) guard "preencher ao menos um dos 3 filtros" - sem isso, MsgAviso
1120:     *      + foco em N. Op (m.llRetorno = .f., nao processa nada);
1121:     *   2) transfere os criterios da tela para o BO (equivalente a ler
1122:     *      Get_Op/Get_Env/Get_Pedido/Get_Numero direto no corpo do Click
1123:     *      legado - este dialogo nao tem FormParaBO/BOParaForm porque e
1124:     *      so-leitura, sem Inserir/Atualizar/Excluir);
1125:     *   3) ThisForm.Processa() -> THIS.this_oBusinessObject.Processar();
1126:     *   4) Not Eof('DbProduto') -> avanca para a Pagina Resultado, senao
1127:     *      MsgAviso("Nenhum Registro Encontrado!!!");
1128:     *   5) sincroniza os 3 CheckBoxes de Container1 (Page2) com o criterio
1129:     *      efetivamente usado - SEMPRE, dentro ou fora do bloco If/Else,
1130:     *      igual ao legado (o With final do Click roda incondicionalmente).
1131:     *==========================================================================
1132:     PROCEDURE BtnProcessarClick()
1133:         LOCAL loc_oPg, loc_lSucesso, loc_cCursor
1134: 
1135:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1136: 
1137:         IF EMPTY(loc_oPg.txt_4c_Env.Value) AND EMPTY(loc_oPg.txt_4c_Op.Value) AND ;
1138:            EMPTY(loc_oPg.txt_4c_Pedido.Value)
1139:             MsgAviso("Nenhum Op" + CHR(231) + CHR(227) + "o de Filtro Foi Informada!!!", ;
1140:                      "Aten" + CHR(231) + CHR(227) + "o")
1141:             loc_oPg.txt_4c_Op.SetFocus()
1142:             RETURN
1143:         ENDIF
1144: 
1145:         *-- Criterios da tela -> BO (Fase 8: extraido para FormParaBO).
1146:         IF !THIS.FormParaBO()
1147:             RETURN
1148:         ENDIF
1149: 
1150:         THIS.LockScreen = .T.
1151: 
1152:         loc_lSucesso = THIS.this_oBusinessObject.Processar()
1153:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorResultado
1154: 
1155:         IF loc_lSucesso AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1156:             *-- AlternarPagina(2) ja repinta a grade (CarregarLista) DEPOIS
1157:             *-- de trocar o ActivePage - regra CLAUDE.md #21/Erro192.
1158:             THIS.AlternarPagina(2)
1159:             THIS.Refresh()
1160:         ELSE
1161:             IF loc_lSucesso
1162:                 MsgAviso("Nenhum Registro Encontrado!!!", ;
1163:                          "Aten" + CHR(231) + CHR(227) + "o")
1164:             ENDIF
1165:         ENDIF
1166: 
1167:         THIS.LockScreen = .F.
1168: 
1169:         *-- "With This.Parent.Parent.pag_resultado.Container1" do fim do
1170:         *-- cmdprocessar.Click legado - roda SEMPRE depois do Processa,
1171:         *-- dentro ou fora do ramo "Not Eof('DbProduto')". Fase 8: os 3
1172:         *-- CheckBoxes e as flags this_lRastroPor* saem de BOParaForm, que
1173:         *-- le os MESMOS criterios que FormParaBO acabou de gravar no BO.
1174:         THIS.BOParaForm()
1175:     ENDPROC
1176: 
1177:     *==========================================================================
1178:     * BtnEncerrarClick - grp_operacao da Page1 (cmd_cancela.Click legado:
1179:     * "ThisForm.Release").
1180:     *==========================================================================
1181:     PROCEDURE BtnEncerrarClick()
1182:         THIS.Release()
1183:     ENDPROC
1184: 
1185:     *==========================================================================
1186:     * ValidarOpLostFocus - Get_Op.Valid legado: se preenchido, invalida a
1187:     * consulta (ConsultaExecutada = .f.) e confere que a Op existe em
1188:     * SigOpPic e pertence a empresa corrente. O legado cancela o Valid
1189:     * (Return 0) sem limpar o valor digitado - aqui devolve o foco ao campo
1190:     * com MsgAviso, tambem sem apagar o que o usuario digitou.
1191:     *==========================================================================
1192:     PROCEDURE ValidarOpLostFocus()
1193:         LOCAL loc_oPg, loc_nValor, loc_lValido, loc_oErro
1194: 
1195:         loc_oPg    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1196:         loc_nValor = loc_oPg.txt_4c_Op.Value
1197: 
1198:         *-- Guard dos When (Fase 8): reaplicado ANTES do early return, senao
1199:         *-- limpar o campo nunca reabriria os outros dois filtros.
1200:         THIS.HabilitarCampos(.T.)
1201: 
1202:         IF loc_nValor = 0
1203:             RETURN
1204:         ENDIF
1205: 
1206:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
1207: 
1208:         loc_lValido = .F.
1209:         TRY
1210:             loc_lValido = THIS.this_oBusinessObject.ValidarOperacao(loc_nValor)
1211:         CATCH TO loc_oErro
1212:             MsgErro(loc_oErro.Message + CHR(13) + ;
1213:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1214:                     "Procedure: " + loc_oErro.Procedure, ;
1215:                     "Erro ao Validar Opera" + CHR(231) + CHR(227) + "o")
1216:         ENDTRY
1217: 
1218:         IF !loc_lValido
1219:             MsgAviso(THIS.this_oBusinessObject.this_cMensagemErroOp, ;
1220:                      "Aten" + CHR(231) + CHR(227) + "o")
1221:             loc_oPg.txt_4c_Op.SetFocus()
1222:         ENDIF
1223:     ENDPROC
1224: 
1225:     *==========================================================================
1226:     * ValidarEnvLostFocus - Get_Env.Valid legado: so invalida a consulta
1227:     * executada quando o campo esta preenchido, sem checagem adicional.
1228:     *==========================================================================
1229:     PROCEDURE ValidarEnvLostFocus()
1230:         LOCAL loc_oPg
1231:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1232: 
1233:         IF loc_oPg.txt_4c_Env.Value != 0
1234:             THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
1235:         ENDIF
1236: 
1237:         *-- Guard dos When (Fase 8)
1238:         THIS.HabilitarCampos(.T.)
1239:     ENDPROC
1240: 
1241:     *==========================================================================
1242:     * ValidarPedidoLostFocus - Get_Pedido.Valid legado: se preenchido,
1243:     * invalida a consulta e confere (Seek) se o codigo digitado existe em
1244:     * cursor_4c_Operacoes; se nao existir, abre o picker local
1245:     * (AbrirLookupPedido). Se vazio, zera txt_4c_Numero (igual ao Else do
1246:     * legado: "This.Parent.Get_Numero.Value = 0 / Refresh").
1247:     *==========================================================================
1248:     PROCEDURE ValidarPedidoLostFocus()
1249:         LOCAL loc_oPg, loc_cValor
1250: 
1251:         *-- Guarda de reentrancia (regra CLAUDE.md #37/#47): o picker eh
1252:         *-- modal, tira o foco do campo e redispara o proprio LostFocus.
1253:         IF THIS.this_lEmLookupPedido
1254:             RETURN
1255:         ENDIF
1256: 
1257:         loc_oPg    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1258:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Pedido.Value)
1259: 
1260:         *-- Guard de valor-nao-mudou (regra CLAUDE.md #47): LostFocus dispara
1261:         *-- SEMPRE, ao contrario do Valid legado, que so dispara quando o
1262:         *-- valor MUDA - sem isto, tabular pelo campo sem digitar nada
1263:         *-- reabriria o picker a cada passagem.
1264:         IF loc_cValor == THIS.this_cUltimoValidarPedidoLostFocusValidado
1265:             RETURN
1266:         ENDIF
1267: 
1268:         IF !EMPTY(loc_cValor)
1269:             THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
1270: 
1271:             IF !SEEK(loc_cValor, THIS.this_oBusinessObject.this_cCursorOperacoes, "Dopes")
1272:                 THIS.this_lEmLookupPedido = .T.
1273:                 THIS.AbrirLookupPedido()
1274:                 THIS.this_lEmLookupPedido = .F.
1275:             ENDIF
1276:         ELSE
1277:             loc_oPg.txt_4c_Numero.Value = 0
1278:             loc_oPg.txt_4c_Numero.Refresh()
1279:         ENDIF
1280: 
1281:         THIS.this_cUltimoValidarPedidoLostFocusValidado = loc_cValor
1282: 
1283:         *-- Guard dos When (Fase 8): roda nos DOIS ramos - preencher Pedido
1284:         *-- libera Numero e bloqueia Op/Envelope; limpar Pedido faz o
1285:         *-- caminho inverso.
1286:         THIS.HabilitarCampos(.T.)
1287:     ENDPROC
1288: 
1289:     *==========================================================================
1290:     * AbrirLookupPedido - fwBuscaSel('TmpOper', 'Dopes', ...) legado: abre o
1291:     * picker local (FormBuscaAuxiliar Pattern A - DefinirCursor/Mostrar)
1292:     * SOBRE cursor_4c_Operacoes JA carregado, sem nova consulta SQL.
1293:     *==========================================================================
1294:     PROCEDURE AbrirLookupPedido()
1295:         LOCAL loc_oBusca, loc_cCursor, loc_oPg
1296: 
1297:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
1298:         loc_oPg     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1299: 
1300:         IF !USED(loc_cCursor)
1301:             RETURN
1302:         ENDIF
1303: 
1304:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1305:         loc_oBusca.DefinirCursor(loc_cCursor, "Dopes", "NDopes", ;
1306:             "Cadastro de Opera" + CHR(231) + CHR(245) + "es")
1307:         loc_oBusca.this_aColunas[1, 3] = "Opera" + CHR(231) + CHR(227) + "o"
1308:         loc_oBusca.this_aColunas[2, 3] = "C" + CHR(243) + "digo"
1309: 
1310:         IF loc_oBusca.Mostrar()
1311:             loc_oPg.txt_4c_Pedido.Value = loc_oBusca.cCodigoSelecionado
1312:         ENDIF
1313: 
1314:         loc_oBusca.Release()
1315:     ENDPROC
1316: 
1317:     *==========================================================================
1318:     * GetOpWhenCheck/GetEnvWhenCheck/GetPedidoWhenCheck/GetNumeroWhenCheck -
1319:     * equivalentes aos When dos 4 campos de filtro do legado: cada grupo
1320:     * (Op, Envelope, Pedido+Numero) so recebe foco quando os OUTROS dois
1321:     * grupos estao vazios - o usuario preenche APENAS um dos tres.
1322:     *==========================================================================
1323:     FUNCTION GetOpWhenCheck()
1324:         LOCAL loc_oPg
1325:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1326:         RETURN EMPTY(loc_oPg.txt_4c_Pedido.Value) AND EMPTY(loc_oPg.txt_4c_Env.Value)
1327:     ENDFUNC
1328: 
1329:     FUNCTION GetEnvWhenCheck()
1330:         LOCAL loc_oPg
1331:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1332:         RETURN EMPTY(loc_oPg.txt_4c_Pedido.Value) AND EMPTY(loc_oPg.txt_4c_Op.Value)
1333:     ENDFUNC
1334: 
1335:     FUNCTION GetPedidoWhenCheck()
1336:         LOCAL loc_oPg
1337:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1338:         RETURN EMPTY(loc_oPg.txt_4c_Op.Value) AND EMPTY(loc_oPg.txt_4c_Env.Value)
1339:     ENDFUNC
1340: 
1341:     FUNCTION GetNumeroWhenCheck()
1342:         LOCAL loc_oPg
1343:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1344:         RETURN !EMPTY(loc_oPg.txt_4c_Pedido.Value)
1345:     ENDFUNC
1346: 
1347:     *==========================================================================
1348:     * BtnVoltarClick - grp_operacao da Page2 (cmd_voltar.Click legado:
1349:     * "ThisForm.fld_principal.ActivePage = 1").
1350:     *==========================================================================
1351:     PROCEDURE BtnVoltarClick()
1352:         THIS.AlternarPagina(1)
1353:     ENDPROC
1354: 
1355:     *==========================================================================
1356:     * BtnRastreabClick - Bot_Rastro.Click legado: abre o relatorio
1357:     * SigReCgr (Formsigrecgr, ja migrado) filtrado pela chave
1358:     * correspondente ao modo marcado no cnt_4c_ModoRastro (Op/Envelope/
1359:     * Pedido). As properties this_nSel*/this_cSel* vem de
1360:     * CarregarDoCursor(), chamado a cada AfterRowColChange da grade.
1361:     *==========================================================================
1362:     PROCEDURE BtnRastreabClick()
1363:         LOCAL loc_nTipo, loc_cFiltro, loc_oForm, loc_cCursor
1364: 
1365:         *-- O legado le a chave DIRETO da linha corrente ("dbProduto.Nops"),
1366:         *-- nao de uma copia guardada: reposicionar as properties aqui
1367:         *-- garante o mesmo valor mesmo que a grade nunca tenha disparado
1368:         *-- AfterRowColChange (usuario clica Rastreab. sem trocar de linha).
1369:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
1370:         IF USED(loc_cCursor)
1371:             THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
1372:         ENDIF
1373: 
1374:         DO CASE
1375:             CASE THIS.this_oBusinessObject.this_lRastroPorOp
1376:                 loc_nTipo   = 2
1377:                 loc_cFiltro = ALLTRIM(STR(THIS.this_oBusinessObject.this_nSelNops, 10))
1378:             CASE THIS.this_oBusinessObject.this_lRastroPorEnvelop
1379:                 loc_nTipo   = 3
1380:                 loc_cFiltro = ALLTRIM(STR(THIS.this_oBusinessObject.this_nSelNenvs, 10))
1381:             CASE THIS.this_oBusinessObject.this_lRastroPorPedido
1382:                 loc_nTipo   = 4
1383:                 loc_cFiltro = ALLTRIM(THIS.this_oBusinessObject.this_cSelDopNums)
1384:             OTHERWISE
1385:                 RETURN
1386:         ENDCASE
1387: 
1388:         loc_oForm = CREATEOBJECT("Formsigrecgr", loc_nTipo, loc_cFiltro, THIS)
1389:         IF VARTYPE(loc_oForm) = "O"
1390:             loc_oForm.Show()
1391:         ENDIF
1392:     ENDPROC
1393: 
1394:     *==========================================================================
1395:     * ChkOp/Envelope/PedidoClick - Container1 do legado: os tres
1396:     * CheckBoxes sao mutuamente exclusivos (marcar um desmarca os outros
1397:     * dois) e definem a chave que Bot_Rastro.Click usa.
1398:     *==========================================================================
1399:     PROCEDURE ChkOpClick()
1400:         LOCAL loc_oCnt
1401:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro
1402: 
1403:         loc_oCnt.chk_4c_Op.Value       = 1
1404:         loc_oCnt.chk_4c_Envelope.Value = 0
1405:         loc_oCnt.chk_4c_Pedido.Value   = 0
1406:         loc_oCnt.chk_4c_Envelope.Refresh()
1407:         loc_oCnt.chk_4c_Pedido.Refresh()
1408: 
1409:         THIS.this_oBusinessObject.this_lRastroPorOp      = .T.
1410:         THIS.this_oBusinessObject.this_lRastroPorEnvelop = .F.
1411:         THIS.this_oBusinessObject.this_lRastroPorPedido  = .F.
1412: 
1413:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
1414:     ENDPROC
1415: 
1416:     PROCEDURE ChkEnvelopeClick()
1417:         LOCAL loc_oCnt
1418:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro
1419: 
1420:         loc_oCnt.chk_4c_Envelope.Value = 1
1421:         loc_oCnt.chk_4c_Op.Value       = 0
1422:         loc_oCnt.chk_4c_Pedido.Value   = 0
1423:         loc_oCnt.chk_4c_Op.Refresh()
1424:         loc_oCnt.chk_4c_Pedido.Refresh()
1425: 
1426:         THIS.this_oBusinessObject.this_lRastroPorOp      = .F.
1427:         THIS.this_oBusinessObject.this_lRastroPorEnvelop = .T.
1428:         THIS.this_oBusinessObject.this_lRastroPorPedido  = .F.
1429: 
1430:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
1431:     ENDPROC
1432: 
1433:     PROCEDURE ChkPedidoClick()
1434:         LOCAL loc_oCnt
1435:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro
1436: 
1437:         loc_oCnt.chk_4c_Pedido.Value   = 1
1438:         loc_oCnt.chk_4c_Envelope.Value = 0
1439:         loc_oCnt.chk_4c_Op.Value       = 0
1440:         loc_oCnt.chk_4c_Envelope.Refresh()
1441:         loc_oCnt.chk_4c_Op.Refresh()
1442: 
1443:         THIS.this_oBusinessObject.this_lRastroPorOp      = .F.
1444:         THIS.this_oBusinessObject.this_lRastroPorEnvelop = .F.
1445:         THIS.this_oBusinessObject.this_lRastroPorPedido  = .T.
1446: 
1447:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
1448:     ENDPROC
1449: 
1450:     *==========================================================================
1451:     * GrdDadosAfterRowColChange - reposiciona as properties this_nSel*/
1452:     * this_cSel* do BO (CarregarDoCursor) e reavalia o Enabled do botao
1453:     * Rastreab. a cada troca de linha/coluna na grade de resultado. Metodo
1454:     * SEM filtro de coluna (regra CLAUDE.md #46 - carregar detalhe da
1455:     * linha corrente eh o uso correto de AfterRowColChange).
1456:     *==========================================================================
1457:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
1458:         LOCAL loc_cCursor
1459:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
1460: 
1461:         IF USED(loc_cCursor)
1462:             THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
1463:         ENDIF
1464: 
1465:         THIS.AtualizarBotaoRastreab()
1466:     ENDPROC
1467: 
1468:     *==========================================================================
1469:     * CarregarLista - Repinta a grade de resultado. Popular um cursor NAO
1470:     * repinta a grade ligada a ele (regra CLAUDE.md #21): o legado sempre
1471:     * fecha o ciclo com "Go Top In <cursor>" + "<grid>.Refresh", e aqui
1472:     * isso vira um METODO UNICO chamado em TODO caminho que popula ou
1473:     * exibe o resultado - BtnProcessarClick (depois do Processar),
1474:     * AlternarPagina(2) DEPOIS de trocar o ActivePage (Refresh em pagina
1475:     * OCULTA nao pinta - regra #21/Erro192) e LimparCampos.
1476:     *
1477:     * O rebind so acontece quando o alias ligado ao Grid DEIXOU de ser o
1478:     * cursor de resultado: o BO popula por ZAP + APPEND BLANK/REPLACE no
1479:     * MESMO alias (nunca derruba o cursor), entao no caminho normal basta
1480:     * reposicionar e repintar - re-atribuir RecordSource a toa resetaria
1481:     * Width/Caption e a posicao de rolagem sem necessidade.
1482:     *
1483:     * PUBLIC de proposito (regra CLAUDE.md #1/#51).
1484:     *==========================================================================
1485:     PROCEDURE CarregarLista()
1486:         LOCAL loc_cCursor, loc_oGrid, loc_lSucesso, loc_oErro
1487: 
1488:         loc_lSucesso = .F.
1489:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorResultado
1490: 
1491:         IF !USED(loc_cCursor)
1492:             THIS.InicializarCursorResultado()
1493:         ENDIF
1494: 
1495:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
1496: 
1497:         TRY
1498:             IF UPPER(ALLTRIM(loc_oGrid.RecordSource)) != UPPER(ALLTRIM(loc_cCursor))
1499:                 THIS.VincularGradeResultado()
1500:             ENDIF
1501: 
1502:             SELECT (loc_cCursor)
1503:             GO TOP
1504: 
1505:             loc_oGrid.Refresh()
1506:             loc_lSucesso = .T.
1507:         CATCH TO loc_oErro
1508:             MsgErro(loc_oErro.Message + CHR(13) + ;
1509:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1510:                     "Procedure: " + loc_oErro.Procedure, ;
1511:                     "Erro ao Carregar a Lista de Resultado")
1512:         ENDTRY
1513: 
1514:         *-- A linha corrente mudou (GO TOP) - reposiciona as properties
1515:         *-- this_nSel*/this_cSel* do BO e reavalia o Enabled do Rastreab.
1516:         IF USED(loc_cCursor)
1517:             THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
1518:         ENDIF
1519:         THIS.AtualizarBotaoRastreab()
1520: 
1521:         RETURN loc_lSucesso
1522:     ENDPROC
1523: 
1524:     *==========================================================================
1525:     * FormParaBO - Transfere os 4 campos de filtro da tela para o BO
1526:     * (equivalente a leitura de Get_Op/Get_Env/Get_Pedido/Get_Numero no
1527:     * corpo do PROCEDURE processa legado: "lnOp = ...Get_Op.Value" etc).
1528:     * Este dialogo eh so-leitura: a "ficha" transferida sao os criterios de
1529:     * pesquisa, nao campos de um registro a gravar.
1530:     *
1531:     * PROTECTED EXPLICITO, e nao por preferencia de estilo: FormBase declara
1532:     * PROTECTED PROCEDURE FormParaBO (hook chamado por FormBase.Salvar/Novo/
1533:     * Cancelar) e o VFP9 NAO deixa a subclasse ALARGAR o escopo - omitir a
1534:     * palavra nao torna o metodo publico, so esconde que ele continua
1535:     * protegido. Medido neste form em 2026-10-24: oForm.FormParaBO() de FORA
1536:     * da classe estoura "Property FORMPARABO is not found" mesmo declarado
1537:     * sem modificador (e PEMSTATUS(...,5) responde .T., porque so verifica
1538:     * existencia - mesma armadilha da regra CLAUDE.md #3/#51). Chamar SEMPRE
1539:     * por THIS. de dentro da classe.
1540:     *==========================================================================
1541:     PROTECTED PROCEDURE FormParaBO()
1542:         LOCAL loc_oPg, loc_lSucesso, loc_oErro
1543: 
1544:         loc_lSucesso = .F.
1545: 
1546:         TRY
1547:             loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1548: 
1549:             WITH THIS.this_oBusinessObject
1550:                 .this_nOps    = loc_oPg.txt_4c_Op.Value
1551:                 .this_nEnvs   = loc_oPg.txt_4c_Env.Value
1552:                 .this_cPedido = loc_oPg.txt_4c_Pedido.Value
1553:                 .this_nNumero = loc_oPg.txt_4c_Numero.Value
1554:             ENDWITH
1555: 
1556:             loc_lSucesso = .T.
1557:         CATCH TO loc_oErro
1558:             MsgErro(loc_oErro.Message + CHR(13) + ;
1559:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1560:                     "Procedure: " + loc_oErro.Procedure, ;
1561:                     "Erro ao Ler os Filtros da Tela")
1562:         ENDTRY
1563: 
1564:         RETURN loc_lSucesso
1565:     ENDPROC
1566: 
1567:     *==========================================================================
1568:     * BOParaForm - Sentido inverso de FormParaBO: escreve os criterios
1569:     * guardados no BO de volta nos 4 campos de filtro (Page1) e sincroniza
1570:     * os 3 CheckBoxes de cnt_4c_ModoRastro (Page2) com o criterio
1571:     * efetivamente usado - este segundo trecho eh o "With
1572:     * This.Parent.Parent.pag_resultado.Container1 / .Chk_op.Value =
1573:     * Iif(Empty(...Get_Op.Value), 0, 1) / ..." que fecha o
1574:     * cmdprocessar.Click legado.
1575:     *
1576:     * As flags this_lRastroPor* do BO sao derivadas no MESMO ponto, para
1577:     * nao divergirem dos CheckBoxes: BtnRastreabClick as consulta para
1578:     * escolher a chave (equivalente ao "If Chk_op.Value = 1" do
1579:     * Bot_Rastro.Click legado).
1580:     *
1581:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: o escopo vem da
1582:     * HERANCA (FormBase declara PROTECTED PROCEDURE BOParaForm) e nao da
1583:     * ausencia do modificador aqui.
1584:     *==========================================================================
1585:     PROTECTED PROCEDURE BOParaForm()
1586:         LOCAL loc_oPg, loc_oCnt, loc_lSucesso, loc_oErro
1587: 
1588:         loc_lSucesso = .F.
1589: 
1590:         TRY
1591:             loc_oPg  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1592:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro
1593: 
1594:             WITH THIS.this_oBusinessObject
1595:                 loc_oPg.txt_4c_Op.Value     = .this_nOps
1596:                 loc_oPg.txt_4c_Env.Value    = .this_nEnvs
1597:                 loc_oPg.txt_4c_Pedido.Value = PADR(.this_cPedido, 20)
1598:                 loc_oPg.txt_4c_Numero.Value = .this_nNumero
1599: 
1600:                 *-- Iif(Empty(<campo>), 0, 1) do legado, campo a campo
1601:                 .this_lRastroPorOp      = !EMPTY(.this_nOps)
1602:                 .this_lRastroPorEnvelop = !EMPTY(.this_nEnvs)
1603:                 .this_lRastroPorPedido  = !EMPTY(.this_cPedido)
1604: 
1605:                 loc_oCnt.chk_4c_Op.Value       = IIF(.this_lRastroPorOp, 1, 0)
1606:                 loc_oCnt.chk_4c_Envelope.Value = IIF(.this_lRastroPorEnvelop, 1, 0)
1607:                 loc_oCnt.chk_4c_Pedido.Value   = IIF(.this_lRastroPorPedido, 1, 0)
1608:             ENDWITH
1609: 
1610:             loc_oCnt.chk_4c_Op.Refresh()
1611:             loc_oCnt.chk_4c_Envelope.Refresh()
1612:             loc_oCnt.chk_4c_Pedido.Refresh()
1613: 
1614:             loc_lSucesso = .T.
1615:         CATCH TO loc_oErro
1616:             MsgErro(loc_oErro.Message + CHR(13) + ;
1617:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1618:                     "Procedure: " + loc_oErro.Procedure, ;
1619:                     "Erro ao Exibir os Filtros na Tela")
1620:         ENDTRY
1621: 
1622:         RETURN loc_lSucesso
1623:     ENDPROC
1624: 
1625:     *==========================================================================
1626:     * LimparCampos - Estado inicial do dialogo. Transcrito de dois trechos
1627:     * do legado:
1628:     *   PROCEDURE Init  -> "With .fld_principal.pag_consulta.Origem.Pedido /
1629:     *                       .get_Env.Value = 0 / .get_Op.Value = 0 /
1630:     *                       .get_Numero.Value = 0 /
1631:     *                       .get_Pedido.Value = Space(20) / EndWith"
1632:     *                      e ".ConsultaExecutada = .f."
1633:     *   PROCEDURE processa -> "*-[ Limpa os Arquivos ]-* / Select DbProduto /
1634:     *                       Zap" (o resultado anterior some junto com os
1635:     *                       criterios que o produziram).
1636:     * Fecha reaplicando o guard dos When (HabilitarCampos), repintando a
1637:     * grade vazia (CarregarLista) e reavaliando os botoes.
1638:     *
1639:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: o escopo vem da
1640:     * HERANCA (FormBase declara PROTECTED PROCEDURE LimparCampos) e nao da
1641:     * ausencia do modificador aqui. Quem precisa de um ponto de entrada
1642:     * PUBLICO para zerar a tela usa THIS.AjustarBotoesPorModo /
1643:     * THIS.CarregarLista, que nao existem em FormBase e sao publicos de
1644:     * verdade.
1645:     *==========================================================================
1646:     PROTECTED PROCEDURE LimparCampos()
1647:         LOCAL loc_oPg, loc_cCursor, loc_oErro
1648: 
1649:         TRY
1650:             loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1651: 
1652:             loc_oPg.txt_4c_Env.Value    = 0
1653:             loc_oPg.txt_4c_Op.Value     = 0
1654:             loc_oPg.txt_4c_Numero.Value = 0
1655:             loc_oPg.txt_4c_Pedido.Value = SPACE(20)
1656: 
1657:             WITH THIS.this_oBusinessObject
1658:                 .this_nOps                = 0
1659:                 .this_nEnvs               = 0
1660:                 .this_cPedido             = SPACE(20)
1661:                 .this_nNumero             = 0
1662:                 .this_lConsultaExecutada  = .F.
1663:                 .this_cMensagemErroOp     = ""
1664:             ENDWITH
1665: 
1666:             *-- "Select DbProduto / Zap" do processa legado
1667:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
1668:             IF USED(loc_cCursor)
1669:                 SELECT (loc_cCursor)
1670:                 ZAP
1671:             ENDIF
1672:         CATCH TO loc_oErro
1673:             MsgErro(loc_oErro.Message + CHR(13) + ;
1674:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1675:                     "Procedure: " + loc_oErro.Procedure, ;
1676:                     "Erro ao Limpar os Campos")
1677:         ENDTRY
1678: 
1679:         *-- BOParaForm zera tambem os 3 CheckBoxes de modo e as flags
1680:         *-- this_lRastroPor* (todos os criterios estao vazios agora).
1681:         THIS.BOParaForm()
1682:         THIS.HabilitarCampos(.T.)
1683:         THIS.CarregarLista()
1684:         THIS.AjustarBotoesPorModo()
1685: 
1686:         *-- ".Fld_Principal.pag_consulta.origem.Pedido.get_Op.SetFocus" do
1687:         *-- Init legado. Guardado por Visible: durante o Init o form ainda
1688:         *-- nao foi exibido e SetFocus em controle invisivel estoura.
1689:         IF VARTYPE(loc_oPg) = "O" AND THIS.Visible AND ;
1690:            THIS.pgf_4c_Paginas.ActivePage = 1 AND loc_oPg.txt_4c_Op.Enabled
1691:             loc_oPg.txt_4c_Op.SetFocus()
1692:         ENDIF
1693:     ENDPROC
1694: 
1695:     *==========================================================================
1696:     * HabilitarCampos - Guard "preencher APENAS um dos tres filtros"
1697:     * (Op OU Envelope OU Pedido+Numero), que no legado mora nos When dos
1698:     * 4 campos:
1699:     *   Get_Op.When     -> Empty(Get_Pedido.Value) And Empty(Get_Env.Value)
1700:     *   Get_Env.When    -> Empty(Get_Pedido.Value) And Empty(Get_Op.Value)
1701:     *   Get_Pedido.When -> Empty(Get_Op.Value)     And Empty(Get_Env.Value)
1702:     *   Get_Numero.When -> Not Empty(Get_Pedido.Value)
1703:     *
1704:     * par_lHabilitar = .F. bloqueia os quatro de uma vez (usado enquanto a
1705:     * consulta roda e quando a pagina ativa e' a de Resultado); .T. ou
1706:     * ausente aplica o guard campo a campo, reusando os MESMOS predicados
1707:     * dos GetXWhenCheck da Fase 6 (fonte unica - os dois call sites nao
1708:     * podem divergir em silencio).
1709:     *
1710:     * DESVIO registrado no cabecalho do arquivo: o mecanismo e' .Enabled e
1711:     * nao When, porque When e' evento (nao se atribui a controle criado por
1712:     * AddObject) e, ligado por BINDEVENT, tem o retorno DESCARTADO - o
1713:     * guard do legado nao chegaria a bloquear nada.
1714:     *
1715:     * PUBLIC de proposito (regra CLAUDE.md #1/#51).
1716:     *==========================================================================
1717:     PROCEDURE HabilitarCampos(par_lHabilitar)
1718:         LOCAL loc_oPg, loc_lHabilitar
1719: 
1720:         loc_lHabilitar = .T.
1721:         IF VARTYPE(par_lHabilitar) = "L"
1722:             loc_lHabilitar = par_lHabilitar
1723:         ENDIF
1724: 
1725:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1726: 
1727:         IF loc_lHabilitar
1728:             loc_oPg.txt_4c_Op.Enabled     = THIS.GetOpWhenCheck()
1729:             loc_oPg.txt_4c_Env.Enabled    = THIS.GetEnvWhenCheck()
1730:             loc_oPg.txt_4c_Pedido.Enabled = THIS.GetPedidoWhenCheck()
1731:             loc_oPg.txt_4c_Numero.Enabled = THIS.GetNumeroWhenCheck()
1732:         ELSE
1733:             loc_oPg.txt_4c_Op.Enabled     = .F.
1734:             loc_oPg.txt_4c_Env.Enabled    = .F.
1735:             loc_oPg.txt_4c_Pedido.Enabled = .F.
1736:             loc_oPg.txt_4c_Numero.Enabled = .F.
1737:         ENDIF
1738:     ENDPROC
1739: 
1740:     *==========================================================================
1741:     * AjustarBotoesPorModo - FUNIL do estado dos botoes (regra CLAUDE.md
1742:     * #40: quem desabilita tem de reabilitar no caminho de VOLTA, e isso
1743:     * mora no funil de troca de pagina, nunca so no botao que entra).
1744:     *
1745:     * Pagina 1 (Consulta): Processar ativo; os campos de filtro voltam ao
1746:     * guard dos When. Pagina 2 (Resultado): Rastreab. ativo apenas com
1747:     * linha no cursor (o When "Return Not Eof('dbProduto')" do Bot_Rastro
1748:     * legado, em AtualizarBotaoRastreab) e os filtros ficam bloqueados -
1749:     * eles pertencem a outra pagina e so voltam a valer no retorno.
1750:     * Encerrar e Voltar NUNCA sao desabilitados: sao a unica saida da tela
1751:     * (o form tem ControlBox = .F. / Closable = .F.).
1752:     *
1753:     * PUBLIC de proposito (regra CLAUDE.md #1/#51).
1754:     *==========================================================================
1755:     PROCEDURE AjustarBotoesPorModo()
1756:         LOCAL loc_lNaConsulta
1757: 
1758:         loc_lNaConsulta = (THIS.pgf_4c_Paginas.ActivePage = 1)
1759: 
1760:         THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Processar.Enabled = loc_lNaConsulta
1761: 
1762:         THIS.HabilitarCampos(loc_lNaConsulta)
1763:         THIS.AtualizarBotaoRastreab()
1764:     ENDPROC
1765: 
1766:     *==========================================================================
1767:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F.;
1768:     * este metodo percorre Pages E Controls recursivamente tornando tudo
1769:     * visivel apos a montagem do form.
1770:     *==========================================================================
1771:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1772:         LOCAL loc_nI, loc_oObjeto, loc_nP
1773: 
1774:         IF VARTYPE(par_oContainer) != "O"
1775:             RETURN
1776:         ENDIF
1777: 
1778:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1779:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1780: 
1781:             IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1782:                 loc_oObjeto.Visible = .T.
1783:             ENDIF
1784: 
1785:             IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1786:                 FOR loc_nP = 1 TO loc_oObjeto.PageCount
1787:                     THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1788:                 ENDFOR
1789:             ELSE
1790:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1791:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1792:                 ENDIF
1793:             ENDIF
1794:         ENDFOR
1795:     ENDPROC
1796: 
1797:     *==========================================================================
1798:     * Destroy - delega para FormBase.Destroy (restaura menu apos fechamento)
1799:     *==========================================================================
1800:     PROCEDURE Destroy()
1801:         RETURN DODEFAULT()
1802:     ENDPROC
1803: 
1804: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCgrBO.prg):
*------------------------------------------------------------------------------
* SigOpCgrBO - Business Object para FormSigOpCgr
* Dialogo operacional de "Pesquisa Global de Rastreabilidade": o usuario
* informa UM dos tres criterios (N. Op, Envelope ou Pedido/Numero), o BO
* monta a lista de produtos envolvidos naquele lote (tabela SigPdMvf,
* cruzada com a picagem de SigOpPic e a lista de operacoes de SigCdOpe) e
* o form exibe o resultado numa grade. A partir de uma linha do resultado,
* o usuario abre o relatorio SigReCgr (rastreabilidade) filtrado por
* Op/Envelope/Pedido, conforme o modo marcado.
* Migrado de: SIGOPCGR (Framework Fortyus)
*
* Este dialogo nao possui tabela propria persistida (nao ha Inserir/
* Atualizar/Excluir no legado - e so consulta). A tabela "principal" para
* efeito de this_cTabela/this_cCampoChave e SigPdMvf, que e a fonte real
* do resultado (equivalente a dbProduto no legado); SigCdOpe e SigOpPic
* sao consultadas apenas como apoio (lista de operacoes e picagem).
*------------------------------------------------------------------------------
DEFINE CLASS SigOpCgrBO AS BusinessBase

    *-- Criterios de pesquisa (equivalentes aos Get_Op/Get_Env/Get_Pedido/
    *-- Get_Numero do dump legado - o usuario preenche APENAS um dos tres
    *-- grupos: Op, OU Envelope, OU Pedido+Numero)
    this_nOps    = 0
    this_nEnvs   = 0
    this_cPedido = ""
    this_nNumero = 0

    *-- Estado de controle (equivalente a ThisForm.ConsultaExecutada) -
    *-- evita reprocessar a mesma consulta enquanto nenhum criterio mudou
    this_lConsultaExecutada = .F.

    *-- Modo de rastreabilidade escolhido na pagina de resultado
    *-- (equivalente aos Chk_op/chk_Env/Chk_Dop do Container1 do legado -
    *-- define qual chave o Bot_Rastro.Click usa para abrir SigReCgr)
    this_lRastroPorOp      = .F.
    this_lRastroPorEnvelop = .F.
    this_lRastroPorPedido  = .F.

    *-- Linha corrente do resultado (equivalente ao registro atual de
    *-- dbProduto - usado pelo Bot_Rastro.Click e pelas colunas da grade)
    this_nSelNenvs   = 0
    this_nSelNops    = 0
    this_cSelDopNums = ""
    this_cSelCpros   = ""
    this_nSelQtds    = 0
    this_cSelGrupods = ""
    this_cSelContads = ""

    *-- Nomes dos cursores que este BO consome/popula (propriedade para o
    *-- Form referenciar sem repetir literais - padrao sigopagrBO/SigMvSbnBO)
    this_cCursorOperacoes = "cursor_4c_Operacoes" && equivalente a TmpOper (SigCdOpe) - lista de operacoes para o lookup do Pedido
    this_cCursorPicagem   = "cursor_4c_Picagem"   && equivalente a crSigOpPic (SigOpPic) - picagem por Op/Envelope/EmpDopNums
    this_cCursorMovimento = "cursor_4c_Movimento" && equivalente a crSigPdMvf (SigPdMvf) - lote/producao por Op ou por EmpDNps
    this_cCursorTopo      = "cursor_4c_Topo"      && equivalente a crTopMfas (SigPdMvf) - top 1 EmpDNps por envelope
    this_cCursorResultado = "cursor_4c_Resultado" && equivalente a dbProduto - grade de resultado exibida na pagina 2

    *-- Mensagem de erro do ultimo ValidarOperacao() (equivalente aos dois
    *-- MessageBox do Get_Op.Valid legado: "Op Nao Cadastrada!!!" / "Op de
    *-- Outra Empresa!!!") - o Form le esta property para exibir o MsgAviso.
    this_cMensagemErroOp = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigPdMvf"
        THIS.this_cCampoChave = "Nops"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os dados da linha CORRENTE do cursor de
    * resultado (equivalente ao registro atual de dbProduto no legado) para
    * as properties this_nSel*/this_cSel*. E chamado pelo form ao posicionar
    * o grid de resultado (AfterRowColChange da grade) e antes de
    * Bot_Rastro.Click, que precisa da linha selecionada para montar a
    * chave (Nops/Nenvs/DopNums) usada ao abrir SigReCgr.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nSelNenvs   = TratarNulo(Nenvs, 0)
            THIS.this_nSelNops    = TratarNulo(Nops, 0)
            THIS.this_cSelDopNums = TratarNulo(DopNums, "")
            THIS.this_cSelCpros   = TratarNulo(Cpros, "")
            THIS.this_nSelQtds    = TratarNulo(Qtds, 0)
            THIS.this_cSelGrupods = TratarNulo(Grupods, "")
            THIS.this_cSelContads = TratarNulo(Contads, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Popula this_cCursorOperacoes (equivalente a TmpOper
    * do PROCEDURE Init legado: Select Dopes, NDopes, Globalizas, Reservas
    * From SigCdOpe Where Globalizas In (1, 2), Index On Dopes Tag Dopes).
    * Usado pelo lookup do campo Pedido (Fase 6): SEEK contra o cursor local
    * + picker FormBuscaAuxiliar.DefinirCursor/Mostrar (Pattern A - regra
    * "FormBuscaAuxiliar Pattern B broken") sobre este MESMO cursor, sem
    * nova consulta SQL - igual ao fwBuscaSel legado, que tambem trabalha
    * em cima do cursor ja carregado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cCursor, loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorOperacoes

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        *-- Modo teste/validacao de UI: sem conexao real de SQL Server -
        *-- SQLEXEC com handle invalido DISPARA excecao (nao devolve -1),
        *-- entao criar o cursor vazio com a MESMA estrutura do TmpOper
        *-- legado, para o SEEK do lookup de Pedido nao estourar "Alias
        *-- CURSOR_4C_OPERACOES is not found".
        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            CREATE CURSOR (loc_cCursor) ;
                (Dopes C(20), NDopes N(4, 0), Globalizas N(1, 0), Reservas N(1, 0))
            INDEX ON Dopes TAG Dopes
            RETURN .T.
        ENDIF

        loc_cSQL = "SELECT Dopes, NDopes, Globalizas, Reservas " + ;
                   "FROM SigCdOpe WHERE Globalizas IN (1, 2)"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado >= 0 AND USED(loc_cCursor)
            SELECT (loc_cCursor)
            INDEX ON Dopes TAG Dopes
            GO TOP
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOperacao - Confere se a Op existe em SigOpPic e pertence a
    * empresa corrente (equivalente ao Get_Op.Valid legado: CursorQuery +
    * Eof('crSigOpPic') + crSigOpPic.Emps <> _Empr). Preenche
    * this_cMensagemErroOp quando invalido, para o Form exibir o MsgAviso.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOperacao(par_nOps)
        LOCAL loc_cCursor, loc_cSQL, loc_nResultado, loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErroOp = ""
        loc_cCursor = "cursor_4c_ValOp"

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT TOP 1 Emps FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(par_nOps, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado > 0 AND USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            IF ALLTRIM(Emps) == ALLTRIM(go_4c_Sistema.cCodEmpresa)
                loc_lValido = .T.
            ELSE
                THIS.this_cMensagemErroOp = "Op de Outra Empresa!!!"
            ENDIF
        ELSE
            THIS.this_cMensagemErroOp = "Op N" + CHR(227) + "o Cadastrada!!!"
        ENDIF

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - equivalente ao PROCEDURE processa do legado: monta o
    * resultado da pesquisa (this_cCursorResultado) a partir de QUAL dos
    * tres criterios foi preenchido (Op, Envelope ou Pedido+Numero). O
    * guard "If Not Thisform.ConsultaExecutada" do legado fica aqui dentro
    * (nao reprocessa enquanto nenhum criterio mudou - os handlers de
    * LostFocus dos filtros resetam this_lConsultaExecutada no Form).
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_cCursorResultado, loc_lSucesso

        loc_lSucesso          = .T.
        loc_cCursorResultado  = THIS.this_cCursorResultado

        IF !THIS.this_lConsultaExecutada
            *-[ Limpa os Arquivos ]-* (equivalente a "Select DbProduto / Zap")
            IF USED(loc_cCursorResultado)
                SELECT (loc_cCursorResultado)
                ZAP
            ENDIF

            DO CASE
                CASE THIS.this_nOps != 0
                    loc_lSucesso = THIS.ProcessarPorOp()
                CASE THIS.this_nEnvs > 0
                    loc_lSucesso = THIS.ProcessarPorEnvelope()
                OTHERWISE
                    loc_lSucesso = THIS.ProcessarPorPedido()
            ENDCASE

            IF loc_lSucesso
                THIS.this_lConsultaExecutada = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPorOp - ramo "If (lnOp <> 0)" do legado: pesquisa a picagem
    * (SigOpPic) da Op informada e, para cada linha, busca o topo de
    * producao (SigPdMvf) correspondente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorOp()
        LOCAL loc_cCursorPic, loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_lSucesso   = .T.
        loc_cCursorPic = THIS.this_cCursorPicagem

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Dopes, Numes, Qtds FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(THIS.this_nOps, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigOpPic)")
            RETURN .F.
        ENDIF

        *-- Snapshot em array ANTES de fechar o cursor: BuscarTopoPorOp faz
        *-- SQLEXEC/SELECT proprios, e um SCAN direto neste cursor perderia
        *-- a posicao corrente quando a funcao chamada troca de workarea.
        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.BuscarTopoPorOp(THIS.this_nOps, loc_aDopes[loc_nI], ;
                    loc_aNumes[loc_nI], loc_aQtds[loc_nI], "1")
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPorEnvelope - ramo "If (lnEnv > 0)" do legado: acha o topo
    * de EmpDNps do envelope informado, pesquisa TODAS as linhas de
    * SigPdMvf daquele EmpDNps e, para cada uma, busca a picagem (SigOpPic)
    * da Op correspondente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorEnvelope()
        LOCAL loc_cCursorTopo, loc_cSQL, loc_nResultado, loc_cChave, loc_lSucesso
        LOCAL loc_cCursorMvf, loc_nTotal, loc_nI
        LOCAL loc_aNops[1], loc_aNenvs[1], loc_aCodPds[1], loc_aGrupods[1], loc_aContads[1]

        loc_lSucesso    = .T.
        loc_cCursorTopo = THIS.this_cCursorTopo

        IF USED(loc_cCursorTopo)
            USE IN (loc_cCursorTopo)
        ENDIF

        loc_cSQL = "SELECT TOP 1 EmpDNps FROM SigPdMvf " + ;
                   "WHERE Nenvs = " + FormatarNumeroSQL(THIS.this_nEnvs, 0) + " " + ;
                   "ORDER BY Nenvs DESC, EmpDNps DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTopo)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crTopMfas)")
            RETURN .F.
        ENDIF

        *-- legado: "If Not Eof()" - sem registro, nao eh erro, simplesmente
        *-- nao ha nada para acrescentar ao resultado.
        IF !USED(loc_cCursorTopo) OR EOF(loc_cCursorTopo)
            IF USED(loc_cCursorTopo)
                USE IN (loc_cCursorTopo)
            ENDIF
            RETURN .T.
        ENDIF

        SELECT (loc_cCursorTopo)
        GO TOP
        loc_cChave = EmpDNps
        USE IN (loc_cCursorTopo)

        loc_cCursorMvf = THIS.this_cCursorMovimento
        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        loc_cSQL = "SELECT Nenvs, Nops, CodPds, Grupods, Contads, Emps, Dopps, Numps " + ;
                   "FROM SigPdMvf WHERE EmpDNps = " + EscaparSQL(loc_cChave) + " " + ;
                   "ORDER BY Nenvs, Nops, CodPds, Grupods, Contads, Emps, Dopps, Numps"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorMvf)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigPdMvf 2)")
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorMvf)
            loc_nTotal = RECCOUNT(loc_cCursorMvf)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aNops[loc_nTotal]
            DIMENSION loc_aNenvs[loc_nTotal]
            DIMENSION loc_aCodPds[loc_nTotal]
            DIMENSION loc_aGrupods[loc_nTotal]
            DIMENSION loc_aContads[loc_nTotal]

            SELECT (loc_cCursorMvf)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aNops[loc_nI]    = Nops
                loc_aNenvs[loc_nI]   = Nenvs
                loc_aCodPds[loc_nI]  = CodPds
                loc_aGrupods[loc_nI] = Grupods
                loc_aContads[loc_nI] = Contads
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.AppendPicagemPorOp(loc_aNops[loc_nI], loc_aNenvs[loc_nI], ;
                    loc_aCodPds[loc_nI], loc_aGrupods[loc_nI], loc_aContads[loc_nI])
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPorPedido - ramo "Else" (nem Op nem Envelope) do legado:
    * monta a chave posicional EmpDopNums (Emps(3)+Dopes(20)+Numero(6) =
    * 29 = SigOpPic.EmpDopNums char(29) - regra CLAUDE.md #42) e pesquisa
    * a picagem direto por ela.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorPedido()
        LOCAL loc_cEDN, loc_cCursorPic, loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_aNops[1], loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_lSucesso = .T.

        *-- Chave POSICIONAL - PADR explicito nas DUAS partes de largura
        *-- fixa (nunca ALLTRIM, regra CLAUDE.md #42), independente do
        *-- padding que txt_4c_Pedido.Value tenha trazido.
        loc_cEDN = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3) + ;
                   PADR(THIS.this_cPedido, 20) + ;
                   STR(THIS.this_nNumero, 6)

        loc_cCursorPic = THIS.this_cCursorPicagem
        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Nops, Dopes, Numes, Qtds FROM SigOpPic " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(loc_cEDN)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigOpPic)")
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aNops[loc_nTotal]
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aNops[loc_nI]  = Nops
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.BuscarTopoPorOp(loc_aNops[loc_nI], loc_aDopes[loc_nI], ;
                    loc_aNumes[loc_nI], loc_aQtds[loc_nI], "3")
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarTopoPorOp - equivalente ao "Select Top 1 Nops, Nenvs, CodPds,
    * Grupods, Contads From SigPdMvf Where Nops = ... Order By ... Desc"
    * repetido nos ramos Op e Pedido do legado. par_cContexto reproduz o
    * numero do MessageBox de falha original (crSigPdMvf 1 / 3).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarTopoPorOp(par_nOps, par_cDopes, par_nNumes, par_nQtds, par_cContexto)
        LOCAL loc_cCursorMvf, loc_cSQL, loc_nResultado
        LOCAL loc_nNenvs, loc_cCodPds, loc_cGrupods, loc_cContads

        loc_cCursorMvf = THIS.this_cCursorMovimento

        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        loc_cSQL = "SELECT TOP 1 Nops, Nenvs, CodPds, Grupods, Contads " + ;
                   "FROM SigPdMvf " + ;
                   "WHERE Nops = " + FormatarNumeroSQL(par_nOps, 0) + " " + ;
                   "ORDER BY Nops DESC, Nenvs DESC, CodPds DESC, Grupods DESC, Contads DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorMvf)

        IF loc_nResultado < 0 OR !USED(loc_cCursorMvf) OR EOF(loc_cCursorMvf)
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigPdMvf " + par_cContexto + ")")
            IF USED(loc_cCursorMvf)
                USE IN (loc_cCursorMvf)
            ENDIF
            RETURN .F.
        ENDIF

        SELECT (loc_cCursorMvf)
        GO TOP
        loc_nNenvs   = Nenvs
        loc_cCodPds  = CodPds
        loc_cGrupods = Grupods
        loc_cContads = Contads

        USE IN (loc_cCursorMvf)

        THIS.AppendResultado(loc_nNenvs, par_nOps, ;
            par_cDopes + STR(par_nNumes, 6), loc_cCodPds, par_nQtds, loc_cGrupods, loc_cContads)

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AppendPicagemPorOp - equivalente ao bloco interno do ramo Envelope do
    * legado: "ThisForm.poDataMgr.CursorQuery('SigOpPic', ..., 'Nops', ...)
    * / Scan / Append Blank" - pesquisa a picagem da Op da linha de
    * SigPdMvf corrente e acrescenta UMA linha de resultado por cada linha
    * de picagem encontrada.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AppendPicagemPorOp(par_nNops, par_nNenvs, par_cCodPds, par_cGrupods, par_cContads)
        LOCAL loc_cCursorPic, loc_cSQL, loc_nResultado
        LOCAL loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_cCursorPic = THIS.this_cCursorPicagem

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Dopes, Numes, Qtds FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(par_nNops, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            IF USED(loc_cCursorPic)
                USE IN (loc_cCursorPic)
            ENDIF
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            THIS.AppendResultado(par_nNenvs, par_nNops, ;
                loc_aDopes[loc_nI] + STR(loc_aNumes[loc_nI], 6), ;
                par_cCodPds, loc_aQtds[loc_nI], par_cGrupods, par_cContads)
        ENDFOR

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AppendResultado - equivalente a "Select DbProduto / Append Blank /
    * Replace ..." do legado. Unico ponto de escrita em
    * this_cCursorResultado, usado pelos tres ramos de Processar().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AppendResultado(par_nNenvs, par_nNops, par_cDopNums, par_cCpros, par_nQtds, par_cGrupods, par_cContads)
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorResultado

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        APPEND BLANK
        REPLACE Nenvs   WITH TratarNulo(par_nNenvs, 0), ;
                Nops    WITH TratarNulo(par_nNops, 0), ;
                DopNums WITH TratarNulo(par_cDopNums, ""), ;
                Cpros   WITH TratarNulo(par_cCpros, ""), ;
                Qtds    WITH TratarNulo(par_nQtds, 0), ;
                Grupods WITH TratarNulo(par_cGrupods, ""), ;
                Contads WITH TratarNulo(par_cContads, "")
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave que identifica a linha corrente do
    * resultado (nao existe PK de tabela gravavel neste dialogo - ver
    * decisao de projeto abaixo). Usa Nops, o mesmo campo definido como
    * this_cCampoChave no Init, igual ao padrao dos demais BOs.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nSelNops)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Decisao de projeto: BO somente-leitura (sem Inserir/Atualizar/Excluir)
    *--------------------------------------------------------------------------
    * O SIGOPCGR legado e um dialogo de PESQUISA (Pesquisa Global de
    * Rastreabilidade): o unico Create Cursor do Init e dbProduto, que e
    * um cursor LOCAL (nunca gravado no SQL Server), e todo Insert
    * Into/Replace do codigo fonte original tem como alvo esse mesmo
    * cursor local. Nao ha TableUpdate nem AddCursor contra tabela remota
    * em lugar nenhum do dump - as unicas chamadas SqlExecute/CursorQuery
    * do Processa()/Init() sao SELECTs de leitura (SigPdMvf, SigOpPic,
    * SigCdOpe). Por isso este BO nao sobrescreve Inserir(), Atualizar()
    * nem ExecutarExclusao(): o comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto para uma tela que
    * so consulta. CarregarDoCursor() acima e o unico ponto de leitura de
    * linha que este BO precisa, pois alimenta a selecao usada por
    * Bot_Rastro.Click; RegistrarAuditoria() herdado de BusinessBase
    * tambem nao e chamado, porque nao ha Inserir/Atualizar/Excluir que o
    * dispare.
    *--------------------------------------------------------------------------

ENDDEFINE

