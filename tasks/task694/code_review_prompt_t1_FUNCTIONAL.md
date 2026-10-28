# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarPedidoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarPedidoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCgr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1788 linhas total):

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

*-- Linhas 196 a 403:
196:     Themes      = .F.
197: 
198:     *-- Guarda de reentrancia do lookup de Pedido (regra CLAUDE.md #37/#47 -
199:     *-- FormBuscaAuxiliar eh modal, tira o foco e redispara o proprio
200:     *-- LostFocus do campo que o abriu).
201:     this_lEmLookupPedido = .F.
202: 
203:     *==========================================================================
204:     * Init() - o legado nao recebe parametros ("PROCEDURE Init" sem
205:     * LPARAMETERS) - DODEFAULT() ja chama InicializarForm via FormBase.Init
206:     *==========================================================================
207:     PROCEDURE Init()
208:         RETURN DODEFAULT()
209:     ENDPROC
210: 
211:     *==========================================================================
212:     * ValidarParametros - guarda de conexao do Init legado ("Impossivel
213:     * Efetuar Conexao Com o Servidor de Banco de Dados..." no CreateObject
214:     * de poDataMgr), com bypass para os modos sem usuario (teste
215:     * automatizado / validacao de UI).
216:     *
217:     * PUBLIC de proposito: o harness da etapa 06b chama metodos do form de
218:     * FORA da classe, e metodo PROTECTED falha em runtime mesmo com
219:     * PEMSTATUS devolvendo .T. (regra CLAUDE.md #1/TesteAutomatico).
220:     *==========================================================================
221:     PROCEDURE ValidarParametros()
222:         LOCAL loc_lValido
223:         loc_lValido = .T.
224: 
225:         IF TYPE("gb_4c_ModoTeste") = "L"
226:             IF gb_4c_ModoTeste
227:                 RETURN .T.
228:             ENDIF
229:         ENDIF
230: 
231:         IF TYPE("gb_4c_ValidandoUI") = "L"
232:             IF gb_4c_ValidandoUI
233:                 RETURN .T.
234:             ENDIF
235:         ENDIF
236: 
237:         DO CASE
238:             CASE TYPE("gnConnHandle") != "N"
239:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
240:                         "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
241:                 loc_lValido = .F.
242:             CASE gnConnHandle <= 0
243:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
244:                         "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
245:                 loc_lValido = .F.
246:         ENDCASE
247: 
248:         RETURN loc_lValido
249:     ENDPROC
250: 
251:     *==========================================================================
252:     * InicializarCursorResultado - Cria o cursor placeholder de resultado
253:     * (equivalente ao "Create Cursor dbProduto(...) / Index On Nops Tag Nops"
254:     * do PROCEDURE Load legado). Estrutura IDENTICA a que a Fase 7/8 vai
255:     * popular via SQLEXEC/APPEND FROM DBF, para o Grid poder ser configurado
256:     * (RecordSource/ControlSource) nesta mesma fase sem a tela quebrar.
257:     *==========================================================================
258:     PROTECTED PROCEDURE InicializarCursorResultado()
259:         LOCAL loc_cCursor
260:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
261: 
262:         IF !USED(loc_cCursor)
263:             SET NULL ON
264:             CREATE CURSOR (loc_cCursor) ;
265:                 (Nenvs N(10), Nops N(10), DopNums C(26), Cpros C(14), ;
266:                  Qtds N(12,3), Grupods C(10), Contads C(10))
267:             SET NULL OFF
268:             INDEX ON Nops TAG Nops
269:         ENDIF
270:     ENDPROC
271: 
272:     *==========================================================================
273:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
274:     *==========================================================================
275:     PROTECTED PROCEDURE InicializarForm()
276:         LOCAL loc_lSucesso, loc_oErro
277:         loc_lSucesso = .F.
278: 
279:         *-- A guarda de conexao fica FORA do TRY (mesmo padrao de
280:         *-- Formsigopcgc.prg): o harness de teste automatizado define
281:         *-- gnConnHandle = 0 de proposito, e a guarda precisa devolver
282:         *-- antes de qualquer SQLEXEC/CREATEOBJECT que dependa de conexao.
283:         IF !THIS.ValidarParametros()
284:             RETURN .F.
285:         ENDIF
286: 
287:         TRY
288:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCgrBO")
289: 
290:             *-- cursor_4c_Operacoes (equivalente a TmpOper do Init legado) -
291:             *-- precisa estar carregado ANTES de ConfigurarPaginaLista, pois
292:             *-- o lookup do campo Pedido (Fase 6) faz SEEK nele. Falha aqui
293:             *-- aborta a abertura do form, igual ao legado ("Favor
294:             *-- Reinicializar o Processo!!!" + Return .f. no Init).
295:             IF THIS.this_oBusinessObject.CarregarOperacoes()
296: 
297:                 *-- Cursor placeholder de cursor_4c_Resultado ANTES do
298:                 *-- PageFrame: a Page2 liga Grid.RecordSource a este alias
299:                 *-- na mesma fase (regra CLAUDE.md #41 - Column.ControlSource
300:                 *-- de cursor inexistente derruba o Init). A estrutura e
301:                 *-- IDENTICA ao Create Cursor dbProduto do Load() legado.
302:                 THIS.InicializarCursorResultado()
303: 
304:                 THIS.ConfigurarPageFrame()
305:                 THIS.ConfigurarPaginaLista()
306:                 THIS.ConfigurarPaginaDados()
307:                 THIS.TornarControlesVisiveis(THIS)
308: 
309:                 THIS.pgf_4c_Paginas.Visible    = .T.
310:                 THIS.pgf_4c_Paginas.ActivePage = 1
311: 
312:                 *-- Estado inicial do Init legado (valores dos 4 filtros +
313:                 *-- ConsultaExecutada = .f.), consolidado em LimparCampos na
314:                 *-- Fase 8 - inclui o guard dos When (HabilitarCampos) e a
315:                 *-- primeira repintura da grade vazia.
316:                 THIS.LimparCampos()
317: 
318:                 loc_lSucesso = .T.
319:             ENDIF
320:         CATCH TO loc_oErro
321:             MsgErro(loc_oErro.Message + CHR(13) + ;
322:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
323:                     "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
324:         ENDTRY
325: 
326:         RETURN loc_lSucesso
327:     ENDPROC
328: 
329:     *==========================================================================
330:     * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas
331:     * (Consulta/Resultado, espelhando pag_consulta/pag_resultado do legado)
332:     *==========================================================================
333:     PROTECTED PROCEDURE ConfigurarPageFrame()
334:         LOCAL loc_oPgf
335: 
336:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
337:         loc_oPgf = THIS.pgf_4c_Paginas
338: 
339:         loc_oPgf.PageCount = 2
340:         loc_oPgf.Top       = -29
341:         loc_oPgf.Left      = 0
342:         loc_oPgf.Width     = THIS.Width
343:         loc_oPgf.Height    = THIS.Height + 29
344:         loc_oPgf.TabIndex  = 1
345:         loc_oPgf.Tabs      = .F.
346: 
347:         loc_oPgf.Page1.Caption = "Consulta"
348:         loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
349: 
350:         loc_oPgf.Page2.Caption = "Resultado"
351:         loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
352: 
353:         loc_oPgf.Visible    = .T.
354:         loc_oPgf.ActivePage = 1
355:     ENDPROC
356: 
357:     *==========================================================================
358:     * ConfigurarPaginaLista - Estrutura da Page1 (Consulta)
359:     * Fase 3/8: so a faixa do cabecalho + container vazio para o botao
360:     * Processar e o CommandGroup Encerrar (Fase 4). Campos de filtro
361:     * (N. Op / Envelope / Pedido / Numero) vem na Fase 5.
362:     *==========================================================================
363:     PROTECTED PROCEDURE ConfigurarPaginaLista()
364:         LOCAL loc_oPag, loc_oCab
365: 
366:         loc_oPag = THIS.pgf_4c_Paginas.Page1
367: 
368:         *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra #11/#39
369:         *-- do CLAUDE.md): os containers de botao ficam em Top=29..33
370:         *-- (dentro da area da faixa) e tem de ser criados DEPOIS para
371:         *-- desenhar por cima.
372:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
373:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
374:         WITH loc_oCab
375:             .Top           = 29
376:             .Left          = 0
377:             .Width         = THIS.Width
378:             .Height        = 80
379:             .BorderWidth   = 0
380:             .SpecialEffect = 0
381:             .BackColor     = RGB(100, 100, 100)
382: 
383:             .AddObject("lbl_4c_Sombra", "Label")
384:             WITH .lbl_4c_Sombra
385:                 .Top       = 15
386:                 .Left      = 10
387:                 .Width     = THIS.Width
388:                 .Height    = 40
389:                 .FontName  = "Tahoma"
390:                 .FontSize  = 16
391:                 .FontBold  = .T.
392:                 .WordWrap  = .T.
393:                 .Alignment = 0
394:                 .BackStyle = 0
395:                 .ForeColor = RGB(0, 0, 0)
396:                 .Caption   = THIS.Caption
397:             ENDWITH
398: 
399:             .AddObject("lbl_4c_Titulo", "Label")
400:             WITH .lbl_4c_Titulo
401:                 .Top       = 18
402:                 .Left      = 10
403:                 .Width     = THIS.Width

*-- Linhas 416 a 437:
416:         *-- Container "Dados para pesquisa" (Origem no legado, Top=201+29=230
417:         *-- apos compensacao do PageFrame.Top=-29 - regra CLAUDE.md #1/#11 -
418:         *-- bem acima do limite Top>=109 imposto pela faixa do cabecalho).
419:         *-- Centralizado horizontalmente no form 1000px (legado: Left=203 no
420:         *-- canvas 800px fica Left=203+(1000-800)/2=303 no canonico 1000px).
421:         loc_oPag.AddObject("cnt_4c_Origem", "Container")
422:         WITH loc_oPag.cnt_4c_Origem
423:             .Top         = 230
424:             .Left        = 303
425:             .Width       = 393
426:             .Height      = 129
427:             .BackStyle   = 0
428:             .BorderColor = RGB(90, 90, 90)
429: 
430:             .AddObject("lbl_4c__Origem1", "Label")
431:             WITH .lbl_4c__Origem1
432:                 .Top       = 5
433:                 .Left      = 6
434:                 .Width     = 119
435:                 .Height    = 15
436:                 .FontName  = "Tahoma"
437:                 .FontSize  = 8

*-- Linhas 646 a 715:
646:             ENDWITH
647:         ENDWITH
648: 
649:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Processar,          "Click", THIS, "BtnProcessarClick")
650:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnEncerrarClick")
651: 
652:         *-- Valid/When dos 3 filtros mutuamente exclusivos (Op OU Envelope OU
653:         *-- Pedido+Numero - regra CLAUDE.md #47: lookup/validacao em
654:         *-- LostFocus, nunca em KeyPress sem testar a tecla).
655:         LOCAL loc_oPedido
656:         loc_oPedido = loc_oPag.cnt_4c_Origem.cnt_4c_Pedido
657: 
658:         BINDEVENT(loc_oPedido.txt_4c_Op,     "LostFocus", THIS, "ValidarOpLostFocus")
659:         BINDEVENT(loc_oPedido.txt_4c_Env,    "LostFocus", THIS, "ValidarEnvLostFocus")
660:         BINDEVENT(loc_oPedido.txt_4c_Pedido, "LostFocus", THIS, "ValidarPedidoLostFocus")
661: 
662:         BINDEVENT(loc_oPedido.txt_4c_Op,     "When", THIS, "GetOpWhenCheck")
663:         BINDEVENT(loc_oPedido.txt_4c_Env,    "When", THIS, "GetEnvWhenCheck")
664:         BINDEVENT(loc_oPedido.txt_4c_Pedido, "When", THIS, "GetPedidoWhenCheck")
665:         BINDEVENT(loc_oPedido.txt_4c_Numero, "When", THIS, "GetNumeroWhenCheck")
666:     ENDPROC
667: 
668:     *==========================================================================
669:     * ConfigurarPaginaDados - Estrutura da Page2 (Resultado)
670:     * Fase 3/8: so a faixa do cabecalho + container vazio para o botao
671:     * Rastreab. e o CommandGroup Voltar (Fase 4). A grade de resultado
672:     * (Grd_Produto) e o Container1 (CheckBoxes de modo de rastreabilidade)
673:     * vem na Fase 4.
674:     *==========================================================================
675:     PROTECTED PROCEDURE ConfigurarPaginaDados()
676:         LOCAL loc_oPag, loc_oCab
677: 
678:         loc_oPag = THIS.pgf_4c_Paginas.Page2
679: 
680:         *-- Faixa do cabecalho - regra #11: o legado so tem cntSombra em
681:         *-- pag_consulta, mas o padrao do sistema novo repete a faixa nas
682:         *-- DUAS paginas (decisao do time, prevalece sobre o PILAR 1).
683:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
684:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
685:         WITH loc_oCab
686:             .Top           = 29
687:             .Left          = 0
688:             .Width         = THIS.Width
689:             .Height        = 80
690:             .BorderWidth   = 0
691:             .SpecialEffect = 0
692:             .BackColor     = RGB(100, 100, 100)
693: 
694:             .AddObject("lbl_4c_Sombra", "Label")
695:             WITH .lbl_4c_Sombra
696:                 .Top       = 15
697:                 .Left      = 10
698:                 .Width     = THIS.Width
699:                 .Height    = 40
700:                 .FontName  = "Tahoma"
701:                 .FontSize  = 16
702:                 .FontBold  = .T.
703:                 .WordWrap  = .T.
704:                 .Alignment = 0
705:                 .BackStyle = 0
706:                 .ForeColor = RGB(0, 0, 0)
707:                 .Caption   = THIS.Caption
708:             ENDWITH
709: 
710:             .AddObject("lbl_4c_Titulo", "Label")
711:             WITH .lbl_4c_Titulo
712:                 .Top       = 18
713:                 .Left      = 10
714:                 .Width     = THIS.Width
715:                 .Height    = 46

*-- Linhas 795 a 839:
795:             ENDWITH
796:         ENDWITH
797: 
798:         BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Rastreab,          "Click", THIS, "BtnRastreabClick")
799:         BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnVoltarClick")
800: 
801:         *-- Container1 do legado - "Pesquisar OP por" (3 CheckBoxes
802:         *-- mutuamente exclusivos que escolhem a chave usada por
803:         *-- Bot_Rastro.Click: Op/Envelope/Pedido). Top original=46 fica
804:         *-- MUITO perto do topo da pagina (regra do re-layout da faixa de
805:         *-- cabecalho, CLAUDE.md #11: controle de dados tem de ficar com
806:         *-- Top >= 115, nao so +29 - no legado esta pagina nao tinha
807:         *-- cabecalho nenhum, e agora tem). Deslocamento aplicado: +40
808:         *-- (Container1 46+29+40=115; Grd_Produto 150+29+40=219, cabe
809:         *-- dentro do form - ver grade abaixo).
810:         loc_oPag.AddObject("cnt_4c_ModoRastro", "Container")
811:         WITH loc_oPag.cnt_4c_ModoRastro
812:             .Top         = 115
813:             .Left        = 35
814:             .Width       = 168
815:             .Height      = 101
816:             .BackStyle   = 0
817:             .BorderColor = RGB(90, 90, 90)
818:             .BorderWidth = 1
819:             .SpecialEffect = 1
820: 
821:             .AddObject("lbl_4c_PesquisarPor", "Label")
822:             WITH .lbl_4c_PesquisarPor
823:                 .Top       = 4
824:                 .Left      = 3
825:                 .Width     = 97
826:                 .Height    = 15
827:                 .FontName  = "Tahoma"
828:                 .FontSize  = 8
829:                 .FontBold  = .T.
830:                 .BackStyle = 0
831:                 .ForeColor = RGB(90, 90, 90)
832:                 .Caption   = "Pesquisar OP por"
833:             ENDWITH
834: 
835:             .AddObject("chk_4c_Op", "CheckBox")
836:             WITH .chk_4c_Op
837:                 .Top       = 24
838:                 .Left      = 36
839:                 .Width     = 93

*-- Linhas 884 a 976:
884:             ENDWITH
885:         ENDWITH
886: 
887:         BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Op,       "Click", THIS, "ChkOpClick")
888:         BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Envelope, "Click", THIS, "ChkEnvelopeClick")
889:         BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Pedido,   "Click", THIS, "ChkPedidoClick")
890: 
891:         *-- Grd_Produto do legado - grade de resultado. ControlSource/
892:         *-- Header1.Caption/Width TRANSCRITOS do PROCEDURE Init legado (que
893:         *-- SOBRESCREVE os headers do dump estatico do SCX - regra "a pagina
894:         *-- segue o Init legado, nao o SCX desenhado"), nao do dump da
895:         *-- SECAO 2 (que tem Column6/7 com Header1.Caption = "Header1").
896:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
897:         WITH loc_oPag.grd_4c_Dados
898:             .Top           = 219
899:             .Left          = 35
900:             .Width         = 729
901:             .Height        = 400
902:             .FontName      = "Tahoma"
903:             .FontSize      = 8
904:             .ReadOnly      = .T.
905:             .DeleteMark    = .F.
906:             .RecordMark    = .F.
907:             .RowHeight     = 17
908:             .ScrollBars    = 2
909:             .GridLineColor = RGB(238, 238, 238)
910:         ENDWITH
911: 
912:         *-- ColumnCount/RecordSource/ControlSource/Width/Header1.Caption
913:         *-- ficam em VincularGradeResultado (Fase 8) - FONTE UNICA do bind,
914:         *-- compartilhada com CarregarLista.
915:         THIS.VincularGradeResultado()
916: 
917:         BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
918:     ENDPROC
919: 
920:     *==========================================================================
921:     * VincularGradeResultado - Liga grd_4c_Dados ao cursor de resultado.
922:     * Transcrito do "With .Fld_Principal.Pag_Resultado.Grd_Produto" do
923:     * PROCEDURE Init legado (que SOBRESCREVE os headers do dump estatico do
924:     * SCX - a pagina segue o Init legado, nao o SCX desenhado: por isso
925:     * Column6/Column7 recebem "Fase"/"Conta" e nao o "Header1" do dump).
926:     *
927:     * ORDEM OBRIGATORIA (regra CLAUDE.md #41/#48): ColumnCount ->
928:     * RecordSource -> ControlSource -> Width -> Header1.Caption. Atribuir
929:     * RecordSource RECALCULA as larguras para o default 90 e zera os
930:     * captions, entao Width/Caption tem de vir DEPOIS - em TODO site que
931:     * re-vincula a grade, e nao so na montagem inicial.
932:     *
933:     * PUBLIC de proposito (regra CLAUDE.md #1/#51 - o harness da etapa 06b
934:     * chama metodos do form de FORA da classe).
935:     *==========================================================================
936:     PROCEDURE VincularGradeResultado()
937:         LOCAL loc_oGrid, loc_cCursor, loc_lSucesso, loc_oErro
938: 
939:         loc_lSucesso = .F.
940:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorResultado
941: 
942:         *-- Column.ControlSource de cursor INEXISTENTE derruba o Init
943:         *-- (regra CLAUDE.md #41) - o placeholder tem de existir antes.
944:         IF !USED(loc_cCursor)
945:             THIS.InicializarCursorResultado()
946:         ENDIF
947: 
948:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
949: 
950:         TRY
951:             *-- ColumnCount so eh reatribuido quando DIVERGE de 7: qualquer
952:             *-- atribuicao recria os objetos Column (regra CLAUDE.md #144) e
953:             *-- aqui nao ha motivo para pagar esse custo a cada repintura.
954:             IF loc_oGrid.ColumnCount != 7
955:                 loc_oGrid.ColumnCount = 7
956:             ENDIF
957: 
958:             loc_oGrid.RecordSource = loc_cCursor
959: 
960:             loc_oGrid.Column1.ControlSource = loc_cCursor + ".Nenvs"
961:             loc_oGrid.Column2.ControlSource = loc_cCursor + ".Nops"
962:             loc_oGrid.Column3.ControlSource = loc_cCursor + ".DopNums"
963:             loc_oGrid.Column4.ControlSource = loc_cCursor + ".Cpros"
964:             loc_oGrid.Column5.ControlSource = loc_cCursor + ".Qtds"
965:             loc_oGrid.Column6.ControlSource = loc_cCursor + ".Grupods"
966:             loc_oGrid.Column7.ControlSource = loc_cCursor + ".Contads"
967: 
968:             *-- Width e Header1.Caption DEPOIS do RecordSource/ControlSource
969:             WITH loc_oGrid.Column1
970:                 .FontSize          = 8
971:                 .Movable           = .F.
972:                 .Resizable         = .F.
973:                 .Width             = 68
974:                 .Header1.Caption   = "Envelope"
975:                 .Header1.Alignment = 2
976:                 .Header1.FontSize  = 8

*-- Linhas 1048 a 1788:
1048:         CATCH TO loc_oErro
1049:             MsgErro(loc_oErro.Message + CHR(13) + ;
1050:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1051:                     "Procedure: " + loc_oErro.Procedure, ;
1052:                     "Erro ao Vincular a Grade de Resultado")
1053:         ENDTRY
1054: 
1055:         RETURN loc_lSucesso
1056:     ENDPROC
1057: 
1058:     *==========================================================================
1059:     * AlternarPagina - troca a pagina ativa do PageFrame (equivalente a
1060:     * ThisForm.fld_principal.ActivePage = N no legado). A ida para a
1061:     * Pagina 2 (Resultado) so acontece se a consulta ja tiver sido rodada
1062:     * (equivalente ao guard do pag_resultado.Activate legado: "If Not
1063:     * ConsultaExecutada Then ActivePage = 1"); na Fase 4 isso bloqueia a
1064:     * navegacao ate a Fase 7/8 implementar Processa() e marcar
1065:     * this_lConsultaExecutada = .T. - comportamento correto, pois sem
1066:     * consulta executada o legado tambem nao muda de pagina.
1067:     *
1068:     * PUBLIC de proposito (regra CLAUDE.md #1/TesteAutomatico - o harness
1069:     * chama metodos do form direto de fora da classe).
1070:     *==========================================================================
1071:     PROCEDURE AlternarPagina(par_nPagina)
1072:         IF par_nPagina = 2 AND !THIS.this_oBusinessObject.this_lConsultaExecutada
1073:             RETURN
1074:         ENDIF
1075: 
1076:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1077: 
1078:         *-- FUNIL de volta (regra CLAUDE.md #40): quem desabilita botao/campo
1079:         *-- ao SAIR de uma pagina tem de reabilitar ao VOLTAR, e isso mora
1080:         *-- aqui, nao em cada botao que entra.
1081:         THIS.AjustarBotoesPorModo()
1082: 
1083:         IF par_nPagina = 2
1084:             *-- Repintura da grade DEPOIS do ActivePage: Refresh em pagina
1085:             *-- OCULTA nao pinta (regra CLAUDE.md #21/Erro192) - o cursor
1086:             *-- foi populado com a Page2 ainda escondida.
1087:             THIS.CarregarLista()
1088: 
1089:             *-- pag_resultado.Activate legado (ramo Else, ja garantido pelo
1090:             *-- guard acima: ConsultaExecutada = .T.): foco na 1a coluna da
1091:             *-- grade de resultado.
1092:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
1093:         ENDIF
1094:     ENDPROC
1095: 
1096:     *==========================================================================
1097:     * AtualizarBotaoRastreab - equivalente ao When do Bot_Rastro legado
1098:     * ("Return Not Eof('dbProduto')"): o botao so fica habilitado quando o
1099:     * cursor de resultado tem pelo menos uma linha.
1100:     *==========================================================================
1101:     PROCEDURE AtualizarBotaoRastreab()
1102:         LOCAL loc_cCursor, loc_lTemRegistro
1103: 
1104:         loc_cCursor      = THIS.this_oBusinessObject.this_cCursorResultado
1105:         loc_lTemRegistro = USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1106: 
1107:         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Rastreab.Enabled = loc_lTemRegistro
1108:     ENDPROC
1109: 
1110:     *==========================================================================
1111:     * BtnProcessarClick - botao "Processar" (Page1). Equivalente a
1112:     * cmdprocessar.Click do legado:
1113:     *   1) guard "preencher ao menos um dos 3 filtros" - sem isso, MsgAviso
1114:     *      + foco em N. Op (m.llRetorno = .f., nao processa nada);
1115:     *   2) transfere os criterios da tela para o BO (equivalente a ler
1116:     *      Get_Op/Get_Env/Get_Pedido/Get_Numero direto no corpo do Click
1117:     *      legado - este dialogo nao tem FormParaBO/BOParaForm porque e
1118:     *      so-leitura, sem Inserir/Atualizar/Excluir);
1119:     *   3) ThisForm.Processa() -> THIS.this_oBusinessObject.Processar();
1120:     *   4) Not Eof('DbProduto') -> avanca para a Pagina Resultado, senao
1121:     *      MsgAviso("Nenhum Registro Encontrado!!!");
1122:     *   5) sincroniza os 3 CheckBoxes de Container1 (Page2) com o criterio
1123:     *      efetivamente usado - SEMPRE, dentro ou fora do bloco If/Else,
1124:     *      igual ao legado (o With final do Click roda incondicionalmente).
1125:     *==========================================================================
1126:     PROCEDURE BtnProcessarClick()
1127:         LOCAL loc_oPg, loc_lSucesso, loc_cCursor
1128: 
1129:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1130: 
1131:         IF EMPTY(loc_oPg.txt_4c_Env.Value) AND EMPTY(loc_oPg.txt_4c_Op.Value) AND ;
1132:            EMPTY(loc_oPg.txt_4c_Pedido.Value)
1133:             MsgAviso("Nenhum Op" + CHR(231) + CHR(227) + "o de Filtro Foi Informada!!!", ;
1134:                      "Aten" + CHR(231) + CHR(227) + "o")
1135:             loc_oPg.txt_4c_Op.SetFocus()
1136:             RETURN
1137:         ENDIF
1138: 
1139:         *-- Criterios da tela -> BO (Fase 8: extraido para FormParaBO).
1140:         IF !THIS.FormParaBO()
1141:             RETURN
1142:         ENDIF
1143: 
1144:         THIS.LockScreen = .T.
1145: 
1146:         loc_lSucesso = THIS.this_oBusinessObject.Processar()
1147:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorResultado
1148: 
1149:         IF loc_lSucesso AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1150:             *-- AlternarPagina(2) ja repinta a grade (CarregarLista) DEPOIS
1151:             *-- de trocar o ActivePage - regra CLAUDE.md #21/Erro192.
1152:             THIS.AlternarPagina(2)
1153:             THIS.Refresh()
1154:         ELSE
1155:             IF loc_lSucesso
1156:                 MsgAviso("Nenhum Registro Encontrado!!!", ;
1157:                          "Aten" + CHR(231) + CHR(227) + "o")
1158:             ENDIF
1159:         ENDIF
1160: 
1161:         THIS.LockScreen = .F.
1162: 
1163:         *-- "With This.Parent.Parent.pag_resultado.Container1" do fim do
1164:         *-- cmdprocessar.Click legado - roda SEMPRE depois do Processa,
1165:         *-- dentro ou fora do ramo "Not Eof('DbProduto')". Fase 8: os 3
1166:         *-- CheckBoxes e as flags this_lRastroPor* saem de BOParaForm, que
1167:         *-- le os MESMOS criterios que FormParaBO acabou de gravar no BO.
1168:         THIS.BOParaForm()
1169:     ENDPROC
1170: 
1171:     *==========================================================================
1172:     * BtnEncerrarClick - grp_operacao da Page1 (cmd_cancela.Click legado:
1173:     * "ThisForm.Release").
1174:     *==========================================================================
1175:     PROCEDURE BtnEncerrarClick()
1176:         THIS.Release()
1177:     ENDPROC
1178: 
1179:     *==========================================================================
1180:     * ValidarOpLostFocus - Get_Op.Valid legado: se preenchido, invalida a
1181:     * consulta (ConsultaExecutada = .f.) e confere que a Op existe em
1182:     * SigOpPic e pertence a empresa corrente. O legado cancela o Valid
1183:     * (Return 0) sem limpar o valor digitado - aqui devolve o foco ao campo
1184:     * com MsgAviso, tambem sem apagar o que o usuario digitou.
1185:     *==========================================================================
1186:     PROCEDURE ValidarOpLostFocus()
1187:         LOCAL loc_oPg, loc_nValor, loc_lValido, loc_oErro
1188: 
1189:         loc_oPg    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1190:         loc_nValor = loc_oPg.txt_4c_Op.Value
1191: 
1192:         *-- Guard dos When (Fase 8): reaplicado ANTES do early return, senao
1193:         *-- limpar o campo nunca reabriria os outros dois filtros.
1194:         THIS.HabilitarCampos(.T.)
1195: 
1196:         IF loc_nValor = 0
1197:             RETURN
1198:         ENDIF
1199: 
1200:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
1201: 
1202:         loc_lValido = .F.
1203:         TRY
1204:             loc_lValido = THIS.this_oBusinessObject.ValidarOperacao(loc_nValor)
1205:         CATCH TO loc_oErro
1206:             MsgErro(loc_oErro.Message + CHR(13) + ;
1207:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1208:                     "Procedure: " + loc_oErro.Procedure, ;
1209:                     "Erro ao Validar Opera" + CHR(231) + CHR(227) + "o")
1210:         ENDTRY
1211: 
1212:         IF !loc_lValido
1213:             MsgAviso(THIS.this_oBusinessObject.this_cMensagemErroOp, ;
1214:                      "Aten" + CHR(231) + CHR(227) + "o")
1215:             loc_oPg.txt_4c_Op.SetFocus()
1216:         ENDIF
1217:     ENDPROC
1218: 
1219:     *==========================================================================
1220:     * ValidarEnvLostFocus - Get_Env.Valid legado: so invalida a consulta
1221:     * executada quando o campo esta preenchido, sem checagem adicional.
1222:     *==========================================================================
1223:     PROCEDURE ValidarEnvLostFocus()
1224:         LOCAL loc_oPg
1225:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1226: 
1227:         IF loc_oPg.txt_4c_Env.Value != 0
1228:             THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
1229:         ENDIF
1230: 
1231:         *-- Guard dos When (Fase 8)
1232:         THIS.HabilitarCampos(.T.)
1233:     ENDPROC
1234: 
1235:     *==========================================================================
1236:     * ValidarPedidoLostFocus - Get_Pedido.Valid legado: se preenchido,
1237:     * invalida a consulta e confere (Seek) se o codigo digitado existe em
1238:     * cursor_4c_Operacoes; se nao existir, abre o picker local
1239:     * (AbrirLookupPedido). Se vazio, zera txt_4c_Numero (igual ao Else do
1240:     * legado: "This.Parent.Get_Numero.Value = 0 / Refresh").
1241:     *==========================================================================
1242:     PROCEDURE ValidarPedidoLostFocus()
1243:         LOCAL loc_oPg, loc_cValor
1244: 
1245:         *-- Guarda de reentrancia (regra CLAUDE.md #37/#47): o picker eh
1246:         *-- modal, tira o foco do campo e redispara o proprio LostFocus.
1247:         IF THIS.this_lEmLookupPedido
1248:             RETURN
1249:         ENDIF
1250: 
1251:         loc_oPg    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1252:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Pedido.Value)
1253: 
1254:         IF !EMPTY(loc_cValor)
1255:             THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
1256: 
1257:             IF !SEEK(loc_cValor, THIS.this_oBusinessObject.this_cCursorOperacoes, "Dopes")
1258:                 THIS.this_lEmLookupPedido = .T.
1259:                 THIS.AbrirLookupPedido()
1260:                 THIS.this_lEmLookupPedido = .F.
1261:             ENDIF
1262:         ELSE
1263:             loc_oPg.txt_4c_Numero.Value = 0
1264:             loc_oPg.txt_4c_Numero.Refresh()
1265:         ENDIF
1266: 
1267:         *-- Guard dos When (Fase 8): roda nos DOIS ramos - preencher Pedido
1268:         *-- libera Numero e bloqueia Op/Envelope; limpar Pedido faz o
1269:         *-- caminho inverso.
1270:         THIS.HabilitarCampos(.T.)
1271:     ENDPROC
1272: 
1273:     *==========================================================================
1274:     * AbrirLookupPedido - fwBuscaSel('TmpOper', 'Dopes', ...) legado: abre o
1275:     * picker local (FormBuscaAuxiliar Pattern A - DefinirCursor/Mostrar)
1276:     * SOBRE cursor_4c_Operacoes JA carregado, sem nova consulta SQL.
1277:     *==========================================================================
1278:     PROCEDURE AbrirLookupPedido()
1279:         LOCAL loc_oBusca, loc_cCursor, loc_oPg
1280: 
1281:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
1282:         loc_oPg     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1283: 
1284:         IF !USED(loc_cCursor)
1285:             RETURN
1286:         ENDIF
1287: 
1288:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1289:         loc_oBusca.DefinirCursor(loc_cCursor, "Dopes", "NDopes", ;
1290:             "Cadastro de Opera" + CHR(231) + CHR(245) + "es")
1291:         loc_oBusca.this_aColunas[1, 3] = "Opera" + CHR(231) + CHR(227) + "o"
1292:         loc_oBusca.this_aColunas[2, 3] = "C" + CHR(243) + "digo"
1293: 
1294:         IF loc_oBusca.Mostrar()
1295:             loc_oPg.txt_4c_Pedido.Value = loc_oBusca.cCodigoSelecionado
1296:         ENDIF
1297: 
1298:         loc_oBusca.Release()
1299:     ENDPROC
1300: 
1301:     *==========================================================================
1302:     * GetOpWhenCheck/GetEnvWhenCheck/GetPedidoWhenCheck/GetNumeroWhenCheck -
1303:     * equivalentes aos When dos 4 campos de filtro do legado: cada grupo
1304:     * (Op, Envelope, Pedido+Numero) so recebe foco quando os OUTROS dois
1305:     * grupos estao vazios - o usuario preenche APENAS um dos tres.
1306:     *==========================================================================
1307:     FUNCTION GetOpWhenCheck()
1308:         LOCAL loc_oPg
1309:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1310:         RETURN EMPTY(loc_oPg.txt_4c_Pedido.Value) AND EMPTY(loc_oPg.txt_4c_Env.Value)
1311:     ENDFUNC
1312: 
1313:     FUNCTION GetEnvWhenCheck()
1314:         LOCAL loc_oPg
1315:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1316:         RETURN EMPTY(loc_oPg.txt_4c_Pedido.Value) AND EMPTY(loc_oPg.txt_4c_Op.Value)
1317:     ENDFUNC
1318: 
1319:     FUNCTION GetPedidoWhenCheck()
1320:         LOCAL loc_oPg
1321:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1322:         RETURN EMPTY(loc_oPg.txt_4c_Op.Value) AND EMPTY(loc_oPg.txt_4c_Env.Value)
1323:     ENDFUNC
1324: 
1325:     FUNCTION GetNumeroWhenCheck()
1326:         LOCAL loc_oPg
1327:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1328:         RETURN !EMPTY(loc_oPg.txt_4c_Pedido.Value)
1329:     ENDFUNC
1330: 
1331:     *==========================================================================
1332:     * BtnVoltarClick - grp_operacao da Page2 (cmd_voltar.Click legado:
1333:     * "ThisForm.fld_principal.ActivePage = 1").
1334:     *==========================================================================
1335:     PROCEDURE BtnVoltarClick()
1336:         THIS.AlternarPagina(1)
1337:     ENDPROC
1338: 
1339:     *==========================================================================
1340:     * BtnRastreabClick - Bot_Rastro.Click legado: abre o relatorio
1341:     * SigReCgr (Formsigrecgr, ja migrado) filtrado pela chave
1342:     * correspondente ao modo marcado no cnt_4c_ModoRastro (Op/Envelope/
1343:     * Pedido). As properties this_nSel*/this_cSel* vem de
1344:     * CarregarDoCursor(), chamado a cada AfterRowColChange da grade.
1345:     *==========================================================================
1346:     PROCEDURE BtnRastreabClick()
1347:         LOCAL loc_nTipo, loc_cFiltro, loc_oForm, loc_cCursor
1348: 
1349:         *-- O legado le a chave DIRETO da linha corrente ("dbProduto.Nops"),
1350:         *-- nao de uma copia guardada: reposicionar as properties aqui
1351:         *-- garante o mesmo valor mesmo que a grade nunca tenha disparado
1352:         *-- AfterRowColChange (usuario clica Rastreab. sem trocar de linha).
1353:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
1354:         IF USED(loc_cCursor)
1355:             THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
1356:         ENDIF
1357: 
1358:         DO CASE
1359:             CASE THIS.this_oBusinessObject.this_lRastroPorOp
1360:                 loc_nTipo   = 2
1361:                 loc_cFiltro = ALLTRIM(STR(THIS.this_oBusinessObject.this_nSelNops, 10))
1362:             CASE THIS.this_oBusinessObject.this_lRastroPorEnvelop
1363:                 loc_nTipo   = 3
1364:                 loc_cFiltro = ALLTRIM(STR(THIS.this_oBusinessObject.this_nSelNenvs, 10))
1365:             CASE THIS.this_oBusinessObject.this_lRastroPorPedido
1366:                 loc_nTipo   = 4
1367:                 loc_cFiltro = ALLTRIM(THIS.this_oBusinessObject.this_cSelDopNums)
1368:             OTHERWISE
1369:                 RETURN
1370:         ENDCASE
1371: 
1372:         loc_oForm = CREATEOBJECT("Formsigrecgr", loc_nTipo, loc_cFiltro, THIS)
1373:         IF VARTYPE(loc_oForm) = "O"
1374:             loc_oForm.Show()
1375:         ENDIF
1376:     ENDPROC
1377: 
1378:     *==========================================================================
1379:     * ChkOp/Envelope/PedidoClick - Container1 do legado: os tres
1380:     * CheckBoxes sao mutuamente exclusivos (marcar um desmarca os outros
1381:     * dois) e definem a chave que Bot_Rastro.Click usa.
1382:     *==========================================================================
1383:     PROCEDURE ChkOpClick()
1384:         LOCAL loc_oCnt
1385:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro
1386: 
1387:         loc_oCnt.chk_4c_Op.Value       = 1
1388:         loc_oCnt.chk_4c_Envelope.Value = 0
1389:         loc_oCnt.chk_4c_Pedido.Value   = 0
1390:         loc_oCnt.chk_4c_Envelope.Refresh()
1391:         loc_oCnt.chk_4c_Pedido.Refresh()
1392: 
1393:         THIS.this_oBusinessObject.this_lRastroPorOp      = .T.
1394:         THIS.this_oBusinessObject.this_lRastroPorEnvelop = .F.
1395:         THIS.this_oBusinessObject.this_lRastroPorPedido  = .F.
1396: 
1397:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
1398:     ENDPROC
1399: 
1400:     PROCEDURE ChkEnvelopeClick()
1401:         LOCAL loc_oCnt
1402:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro
1403: 
1404:         loc_oCnt.chk_4c_Envelope.Value = 1
1405:         loc_oCnt.chk_4c_Op.Value       = 0
1406:         loc_oCnt.chk_4c_Pedido.Value   = 0
1407:         loc_oCnt.chk_4c_Op.Refresh()
1408:         loc_oCnt.chk_4c_Pedido.Refresh()
1409: 
1410:         THIS.this_oBusinessObject.this_lRastroPorOp      = .F.
1411:         THIS.this_oBusinessObject.this_lRastroPorEnvelop = .T.
1412:         THIS.this_oBusinessObject.this_lRastroPorPedido  = .F.
1413: 
1414:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
1415:     ENDPROC
1416: 
1417:     PROCEDURE ChkPedidoClick()
1418:         LOCAL loc_oCnt
1419:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro
1420: 
1421:         loc_oCnt.chk_4c_Pedido.Value   = 1
1422:         loc_oCnt.chk_4c_Envelope.Value = 0
1423:         loc_oCnt.chk_4c_Op.Value       = 0
1424:         loc_oCnt.chk_4c_Envelope.Refresh()
1425:         loc_oCnt.chk_4c_Op.Refresh()
1426: 
1427:         THIS.this_oBusinessObject.this_lRastroPorOp      = .F.
1428:         THIS.this_oBusinessObject.this_lRastroPorEnvelop = .F.
1429:         THIS.this_oBusinessObject.this_lRastroPorPedido  = .T.
1430: 
1431:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
1432:     ENDPROC
1433: 
1434:     *==========================================================================
1435:     * GrdDadosAfterRowColChange - reposiciona as properties this_nSel*/
1436:     * this_cSel* do BO (CarregarDoCursor) e reavalia o Enabled do botao
1437:     * Rastreab. a cada troca de linha/coluna na grade de resultado. Metodo
1438:     * SEM filtro de coluna (regra CLAUDE.md #46 - carregar detalhe da
1439:     * linha corrente eh o uso correto de AfterRowColChange).
1440:     *==========================================================================
1441:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
1442:         LOCAL loc_cCursor
1443:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
1444: 
1445:         IF USED(loc_cCursor)
1446:             THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
1447:         ENDIF
1448: 
1449:         THIS.AtualizarBotaoRastreab()
1450:     ENDPROC
1451: 
1452:     *==========================================================================
1453:     * CarregarLista - Repinta a grade de resultado. Popular um cursor NAO
1454:     * repinta a grade ligada a ele (regra CLAUDE.md #21): o legado sempre
1455:     * fecha o ciclo com "Go Top In <cursor>" + "<grid>.Refresh", e aqui
1456:     * isso vira um METODO UNICO chamado em TODO caminho que popula ou
1457:     * exibe o resultado - BtnProcessarClick (depois do Processar),
1458:     * AlternarPagina(2) DEPOIS de trocar o ActivePage (Refresh em pagina
1459:     * OCULTA nao pinta - regra #21/Erro192) e LimparCampos.
1460:     *
1461:     * O rebind so acontece quando o alias ligado ao Grid DEIXOU de ser o
1462:     * cursor de resultado: o BO popula por ZAP + APPEND BLANK/REPLACE no
1463:     * MESMO alias (nunca derruba o cursor), entao no caminho normal basta
1464:     * reposicionar e repintar - re-atribuir RecordSource a toa resetaria
1465:     * Width/Caption e a posicao de rolagem sem necessidade.
1466:     *
1467:     * PUBLIC de proposito (regra CLAUDE.md #1/#51).
1468:     *==========================================================================
1469:     PROCEDURE CarregarLista()
1470:         LOCAL loc_cCursor, loc_oGrid, loc_lSucesso, loc_oErro
1471: 
1472:         loc_lSucesso = .F.
1473:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorResultado
1474: 
1475:         IF !USED(loc_cCursor)
1476:             THIS.InicializarCursorResultado()
1477:         ENDIF
1478: 
1479:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
1480: 
1481:         TRY
1482:             IF UPPER(ALLTRIM(loc_oGrid.RecordSource)) != UPPER(ALLTRIM(loc_cCursor))
1483:                 THIS.VincularGradeResultado()
1484:             ENDIF
1485: 
1486:             SELECT (loc_cCursor)
1487:             GO TOP
1488: 
1489:             loc_oGrid.Refresh()
1490:             loc_lSucesso = .T.
1491:         CATCH TO loc_oErro
1492:             MsgErro(loc_oErro.Message + CHR(13) + ;
1493:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1494:                     "Procedure: " + loc_oErro.Procedure, ;
1495:                     "Erro ao Carregar a Lista de Resultado")
1496:         ENDTRY
1497: 
1498:         *-- A linha corrente mudou (GO TOP) - reposiciona as properties
1499:         *-- this_nSel*/this_cSel* do BO e reavalia o Enabled do Rastreab.
1500:         IF USED(loc_cCursor)
1501:             THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
1502:         ENDIF
1503:         THIS.AtualizarBotaoRastreab()
1504: 
1505:         RETURN loc_lSucesso
1506:     ENDPROC
1507: 
1508:     *==========================================================================
1509:     * FormParaBO - Transfere os 4 campos de filtro da tela para o BO
1510:     * (equivalente a leitura de Get_Op/Get_Env/Get_Pedido/Get_Numero no
1511:     * corpo do PROCEDURE processa legado: "lnOp = ...Get_Op.Value" etc).
1512:     * Este dialogo eh so-leitura: a "ficha" transferida sao os criterios de
1513:     * pesquisa, nao campos de um registro a gravar.
1514:     *
1515:     * PROTECTED EXPLICITO, e nao por preferencia de estilo: FormBase declara
1516:     * PROTECTED PROCEDURE FormParaBO (hook chamado por FormBase.Salvar/Novo/
1517:     * Cancelar) e o VFP9 NAO deixa a subclasse ALARGAR o escopo - omitir a
1518:     * palavra nao torna o metodo publico, so esconde que ele continua
1519:     * protegido. Medido neste form em 2026-10-24: oForm.FormParaBO() de FORA
1520:     * da classe estoura "Property FORMPARABO is not found" mesmo declarado
1521:     * sem modificador (e PEMSTATUS(...,5) responde .T., porque so verifica
1522:     * existencia - mesma armadilha da regra CLAUDE.md #3/#51). Chamar SEMPRE
1523:     * por THIS. de dentro da classe.
1524:     *==========================================================================
1525:     PROTECTED PROCEDURE FormParaBO()
1526:         LOCAL loc_oPg, loc_lSucesso, loc_oErro
1527: 
1528:         loc_lSucesso = .F.
1529: 
1530:         TRY
1531:             loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1532: 
1533:             WITH THIS.this_oBusinessObject
1534:                 .this_nOps    = loc_oPg.txt_4c_Op.Value
1535:                 .this_nEnvs   = loc_oPg.txt_4c_Env.Value
1536:                 .this_cPedido = loc_oPg.txt_4c_Pedido.Value
1537:                 .this_nNumero = loc_oPg.txt_4c_Numero.Value
1538:             ENDWITH
1539: 
1540:             loc_lSucesso = .T.
1541:         CATCH TO loc_oErro
1542:             MsgErro(loc_oErro.Message + CHR(13) + ;
1543:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1544:                     "Procedure: " + loc_oErro.Procedure, ;
1545:                     "Erro ao Ler os Filtros da Tela")
1546:         ENDTRY
1547: 
1548:         RETURN loc_lSucesso
1549:     ENDPROC
1550: 
1551:     *==========================================================================
1552:     * BOParaForm - Sentido inverso de FormParaBO: escreve os criterios
1553:     * guardados no BO de volta nos 4 campos de filtro (Page1) e sincroniza
1554:     * os 3 CheckBoxes de cnt_4c_ModoRastro (Page2) com o criterio
1555:     * efetivamente usado - este segundo trecho eh o "With
1556:     * This.Parent.Parent.pag_resultado.Container1 / .Chk_op.Value =
1557:     * Iif(Empty(...Get_Op.Value), 0, 1) / ..." que fecha o
1558:     * cmdprocessar.Click legado.
1559:     *
1560:     * As flags this_lRastroPor* do BO sao derivadas no MESMO ponto, para
1561:     * nao divergirem dos CheckBoxes: BtnRastreabClick as consulta para
1562:     * escolher a chave (equivalente ao "If Chk_op.Value = 1" do
1563:     * Bot_Rastro.Click legado).
1564:     *
1565:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: o escopo vem da
1566:     * HERANCA (FormBase declara PROTECTED PROCEDURE BOParaForm) e nao da
1567:     * ausencia do modificador aqui.
1568:     *==========================================================================
1569:     PROTECTED PROCEDURE BOParaForm()
1570:         LOCAL loc_oPg, loc_oCnt, loc_lSucesso, loc_oErro
1571: 
1572:         loc_lSucesso = .F.
1573: 
1574:         TRY
1575:             loc_oPg  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1576:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro
1577: 
1578:             WITH THIS.this_oBusinessObject
1579:                 loc_oPg.txt_4c_Op.Value     = .this_nOps
1580:                 loc_oPg.txt_4c_Env.Value    = .this_nEnvs
1581:                 loc_oPg.txt_4c_Pedido.Value = PADR(.this_cPedido, 20)
1582:                 loc_oPg.txt_4c_Numero.Value = .this_nNumero
1583: 
1584:                 *-- Iif(Empty(<campo>), 0, 1) do legado, campo a campo
1585:                 .this_lRastroPorOp      = !EMPTY(.this_nOps)
1586:                 .this_lRastroPorEnvelop = !EMPTY(.this_nEnvs)
1587:                 .this_lRastroPorPedido  = !EMPTY(.this_cPedido)
1588: 
1589:                 loc_oCnt.chk_4c_Op.Value       = IIF(.this_lRastroPorOp, 1, 0)
1590:                 loc_oCnt.chk_4c_Envelope.Value = IIF(.this_lRastroPorEnvelop, 1, 0)
1591:                 loc_oCnt.chk_4c_Pedido.Value   = IIF(.this_lRastroPorPedido, 1, 0)
1592:             ENDWITH
1593: 
1594:             loc_oCnt.chk_4c_Op.Refresh()
1595:             loc_oCnt.chk_4c_Envelope.Refresh()
1596:             loc_oCnt.chk_4c_Pedido.Refresh()
1597: 
1598:             loc_lSucesso = .T.
1599:         CATCH TO loc_oErro
1600:             MsgErro(loc_oErro.Message + CHR(13) + ;
1601:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1602:                     "Procedure: " + loc_oErro.Procedure, ;
1603:                     "Erro ao Exibir os Filtros na Tela")
1604:         ENDTRY
1605: 
1606:         RETURN loc_lSucesso
1607:     ENDPROC
1608: 
1609:     *==========================================================================
1610:     * LimparCampos - Estado inicial do dialogo. Transcrito de dois trechos
1611:     * do legado:
1612:     *   PROCEDURE Init  -> "With .fld_principal.pag_consulta.Origem.Pedido /
1613:     *                       .get_Env.Value = 0 / .get_Op.Value = 0 /
1614:     *                       .get_Numero.Value = 0 /
1615:     *                       .get_Pedido.Value = Space(20) / EndWith"
1616:     *                      e ".ConsultaExecutada = .f."
1617:     *   PROCEDURE processa -> "*-[ Limpa os Arquivos ]-* / Select DbProduto /
1618:     *                       Zap" (o resultado anterior some junto com os
1619:     *                       criterios que o produziram).
1620:     * Fecha reaplicando o guard dos When (HabilitarCampos), repintando a
1621:     * grade vazia (CarregarLista) e reavaliando os botoes.
1622:     *
1623:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: o escopo vem da
1624:     * HERANCA (FormBase declara PROTECTED PROCEDURE LimparCampos) e nao da
1625:     * ausencia do modificador aqui. Quem precisa de um ponto de entrada
1626:     * PUBLICO para zerar a tela usa THIS.AjustarBotoesPorModo /
1627:     * THIS.CarregarLista, que nao existem em FormBase e sao publicos de
1628:     * verdade.
1629:     *==========================================================================
1630:     PROTECTED PROCEDURE LimparCampos()
1631:         LOCAL loc_oPg, loc_cCursor, loc_oErro
1632: 
1633:         TRY
1634:             loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1635: 
1636:             loc_oPg.txt_4c_Env.Value    = 0
1637:             loc_oPg.txt_4c_Op.Value     = 0
1638:             loc_oPg.txt_4c_Numero.Value = 0
1639:             loc_oPg.txt_4c_Pedido.Value = SPACE(20)
1640: 
1641:             WITH THIS.this_oBusinessObject
1642:                 .this_nOps                = 0
1643:                 .this_nEnvs               = 0
1644:                 .this_cPedido             = SPACE(20)
1645:                 .this_nNumero             = 0
1646:                 .this_lConsultaExecutada  = .F.
1647:                 .this_cMensagemErroOp     = ""
1648:             ENDWITH
1649: 
1650:             *-- "Select DbProduto / Zap" do processa legado
1651:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
1652:             IF USED(loc_cCursor)
1653:                 SELECT (loc_cCursor)
1654:                 ZAP
1655:             ENDIF
1656:         CATCH TO loc_oErro
1657:             MsgErro(loc_oErro.Message + CHR(13) + ;
1658:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1659:                     "Procedure: " + loc_oErro.Procedure, ;
1660:                     "Erro ao Limpar os Campos")
1661:         ENDTRY
1662: 
1663:         *-- BOParaForm zera tambem os 3 CheckBoxes de modo e as flags
1664:         *-- this_lRastroPor* (todos os criterios estao vazios agora).
1665:         THIS.BOParaForm()
1666:         THIS.HabilitarCampos(.T.)
1667:         THIS.CarregarLista()
1668:         THIS.AjustarBotoesPorModo()
1669: 
1670:         *-- ".Fld_Principal.pag_consulta.origem.Pedido.get_Op.SetFocus" do
1671:         *-- Init legado. Guardado por Visible: durante o Init o form ainda
1672:         *-- nao foi exibido e SetFocus em controle invisivel estoura.
1673:         IF VARTYPE(loc_oPg) = "O" AND THIS.Visible AND ;
1674:            THIS.pgf_4c_Paginas.ActivePage = 1 AND loc_oPg.txt_4c_Op.Enabled
1675:             loc_oPg.txt_4c_Op.SetFocus()
1676:         ENDIF
1677:     ENDPROC
1678: 
1679:     *==========================================================================
1680:     * HabilitarCampos - Guard "preencher APENAS um dos tres filtros"
1681:     * (Op OU Envelope OU Pedido+Numero), que no legado mora nos When dos
1682:     * 4 campos:
1683:     *   Get_Op.When     -> Empty(Get_Pedido.Value) And Empty(Get_Env.Value)
1684:     *   Get_Env.When    -> Empty(Get_Pedido.Value) And Empty(Get_Op.Value)
1685:     *   Get_Pedido.When -> Empty(Get_Op.Value)     And Empty(Get_Env.Value)
1686:     *   Get_Numero.When -> Not Empty(Get_Pedido.Value)
1687:     *
1688:     * par_lHabilitar = .F. bloqueia os quatro de uma vez (usado enquanto a
1689:     * consulta roda e quando a pagina ativa e' a de Resultado); .T. ou
1690:     * ausente aplica o guard campo a campo, reusando os MESMOS predicados
1691:     * dos GetXWhenCheck da Fase 6 (fonte unica - os dois call sites nao
1692:     * podem divergir em silencio).
1693:     *
1694:     * DESVIO registrado no cabecalho do arquivo: o mecanismo e' .Enabled e
1695:     * nao When, porque When e' evento (nao se atribui a controle criado por
1696:     * AddObject) e, ligado por BINDEVENT, tem o retorno DESCARTADO - o
1697:     * guard do legado nao chegaria a bloquear nada.
1698:     *
1699:     * PUBLIC de proposito (regra CLAUDE.md #1/#51).
1700:     *==========================================================================
1701:     PROCEDURE HabilitarCampos(par_lHabilitar)
1702:         LOCAL loc_oPg, loc_lHabilitar
1703: 
1704:         loc_lHabilitar = .T.
1705:         IF VARTYPE(par_lHabilitar) = "L"
1706:             loc_lHabilitar = par_lHabilitar
1707:         ENDIF
1708: 
1709:         loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
1710: 
1711:         IF loc_lHabilitar
1712:             loc_oPg.txt_4c_Op.Enabled     = THIS.GetOpWhenCheck()
1713:             loc_oPg.txt_4c_Env.Enabled    = THIS.GetEnvWhenCheck()
1714:             loc_oPg.txt_4c_Pedido.Enabled = THIS.GetPedidoWhenCheck()
1715:             loc_oPg.txt_4c_Numero.Enabled = THIS.GetNumeroWhenCheck()
1716:         ELSE
1717:             loc_oPg.txt_4c_Op.Enabled     = .F.
1718:             loc_oPg.txt_4c_Env.Enabled    = .F.
1719:             loc_oPg.txt_4c_Pedido.Enabled = .F.
1720:             loc_oPg.txt_4c_Numero.Enabled = .F.
1721:         ENDIF
1722:     ENDPROC
1723: 
1724:     *==========================================================================
1725:     * AjustarBotoesPorModo - FUNIL do estado dos botoes (regra CLAUDE.md
1726:     * #40: quem desabilita tem de reabilitar no caminho de VOLTA, e isso
1727:     * mora no funil de troca de pagina, nunca so no botao que entra).
1728:     *
1729:     * Pagina 1 (Consulta): Processar ativo; os campos de filtro voltam ao
1730:     * guard dos When. Pagina 2 (Resultado): Rastreab. ativo apenas com
1731:     * linha no cursor (o When "Return Not Eof('dbProduto')" do Bot_Rastro
1732:     * legado, em AtualizarBotaoRastreab) e os filtros ficam bloqueados -
1733:     * eles pertencem a outra pagina e so voltam a valer no retorno.
1734:     * Encerrar e Voltar NUNCA sao desabilitados: sao a unica saida da tela
1735:     * (o form tem ControlBox = .F. / Closable = .F.).
1736:     *
1737:     * PUBLIC de proposito (regra CLAUDE.md #1/#51).
1738:     *==========================================================================
1739:     PROCEDURE AjustarBotoesPorModo()
1740:         LOCAL loc_lNaConsulta
1741: 
1742:         loc_lNaConsulta = (THIS.pgf_4c_Paginas.ActivePage = 1)
1743: 
1744:         THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Processar.Enabled = loc_lNaConsulta
1745: 
1746:         THIS.HabilitarCampos(loc_lNaConsulta)
1747:         THIS.AtualizarBotaoRastreab()
1748:     ENDPROC
1749: 
1750:     *==========================================================================
1751:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F.;
1752:     * este metodo percorre Pages E Controls recursivamente tornando tudo
1753:     * visivel apos a montagem do form.
1754:     *==========================================================================
1755:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1756:         LOCAL loc_nI, loc_oObjeto, loc_nP
1757: 
1758:         IF VARTYPE(par_oContainer) != "O"
1759:             RETURN
1760:         ENDIF
1761: 
1762:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1763:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1764: 
1765:             IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1766:                 loc_oObjeto.Visible = .T.
1767:             ENDIF
1768: 
1769:             IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1770:                 FOR loc_nP = 1 TO loc_oObjeto.PageCount
1771:                     THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1772:                 ENDFOR
1773:             ELSE
1774:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1775:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1776:                 ENDIF
1777:             ENDIF
1778:         ENDFOR
1779:     ENDPROC
1780: 
1781:     *==========================================================================
1782:     * Destroy - delega para FormBase.Destroy (restaura menu apos fechamento)
1783:     *==========================================================================
1784:     PROCEDURE Destroy()
1785:         RETURN DODEFAULT()
1786:     ENDPROC
1787: 
1788: ENDDEFINE


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

