# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarGrVenda' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarGrVendaValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDgrVenda' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDgrVendaValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarGrProduto' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarGrProdutoValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDgrProduto' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDgrProdutoValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarMoeVenda' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarMoeVendaValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDmoeVenda' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDmoeVendaValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Linhas' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Produtos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_ProdutosCopia' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopsep.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2114 linhas total):

*-- Linhas 45 a 375:
45: * Fase 2/8 - sigopsepBO.prg: BuscarLinhas/MarcarTodasLinhas/BuscarProdutos/
46: *            MarcarTodosProdutos/ObterProdutosParaCopia/LimparCursores.
47: * Fase 3/8 - estrutura base do Form: DEFINE CLASS + propriedades visuais do
48: *            dump, Init completo (contexto do pai + BO + InicializarForm),
49: *            cabecalho cinza (cntSombra -> cnt_4c_Sombra) e Destroy.
50: *
51: * Fase 4/8 (ESTA FASE) - as DUAS grades do dialogo e os botoes de acao:
52: *   - cnt_4c_Filtro (CrtFiltro): campos de filtro + grd_4c_Linhas
53: *     (GradeLinhas) + cmd_4c_Marcar/cmd_4c_Desmarcar
54: *   - grd_4c_Itens (GradeItens, direto na Form, 6 colunas)
55: *   - botoes de acao direto na Form: cmd_4c_Processar, cmd_4c_CopiaLista,
56: *     cmd_4c_Encerrar (Sair), cmd_4c_MarcaProd, cmd_4c_DesmarcaProd
57: *   - funis de carga CarregarLinhas()/CarregarDados(), que ligam cada grade
58: *     ao seu cursor e instalam o CheckBox da coluna de marcacao
59: *     (InstalarCheckBoxColuna) - replicam o fecho do SIGOPSEP.Init
60: *
61: * NAO existe aqui PageFrame nem pagina Lista/Dados: o SCX legado NAO tem
62: * Page nenhuma (layout FLAT, controles direto na Form) - igual ao padrao ja
63: * usado em FormSigOpCrd.prg para a mesma familia de dialogos OPERACIONAL.
64: * Inventar PageFrame Lista/Dados violaria o PILAR 1. Os nomes de metodo
65: * ConfigurarPageFrame/ConfigurarPaginaLista/ConfigurarPaginaDados seguem o
66: * CONTRATO do pipeline, mas o conteudo de cada um e o que de fato existe no
67: * dump:
68: *
69: *   ConfigurarPageFrame   -> fundo do form (Picture new_background.jpg)
70: *   ConfigurarPaginaLista -> cnt_4c_Filtro (CrtFiltro do legado): campos de
71: *       filtro (Grupo Venda/Produto, Moeda, Acrescimo/Desconto,
72: *       Arredondamento, Situacao) + grd_4c_Linhas + cmd_4c_Marcar/
73: *       cmd_4c_Desmarcar
74: *   ConfigurarPaginaDados -> grd_4c_Itens (GradeItens) + os cinco botoes de
75: *       acao, todos filhos diretos da Form no dump
76: *
77: * mapeamento.json (gerado automaticamente) mapeia GradeLinhas E GradeItens
78: * para o MESMO nome "grd_4c_Dados" - colisao de gerador (mesma familia de
79: * bug ja registrada em outras tasks: alvo duplicado no mapeamento auto).
80: * Por isso os dois grids usam nomes DISTINTOS e explicitos (grd_4c_Linhas /
81: * grd_4c_Itens), escolhidos manualmente, e os botoes cmdMarcaProd/
82: * cmdDesmarcaProd (que marcam PRODUTOS) usam cmd_4c_MarcaProd/
83: * cmd_4c_DesmarcaProd para nao colidir com cmd_4c_Marcar/cmd_4c_Desmarcar
84: * (que marcam LINHAS, dentro de cnt_4c_Filtro).
85: *
86: * Fase 5/8 - FormParaBO()/BOParaForm() dos campos de filtro de cnt_4c_Filtro
87: *   (Grupo Venda/Produto codigo+descricao, Moeda Venda codigo+descricao,
88: *   Acrescimo/Desconto, Arredondamento, Situacao), espelhando 1:1 as
89: *   properties ja existentes em sigopsepBO (Fase 1/8).
90: *
91: * Fase 6/8 (ESTA FASE) - os 6 lookups de cnt_4c_Filtro, transcritos de
92: *   Get_grVenda/Get_DgrVenda (SigCdCol: colecoes/descs),
93: *   Get_grProduto/Get_DgrProduto (SigCdGrp: cgrus/dgrus) e
94: *   Get_moevenda/Get_Dmoevenda (SigCdMoe: cmoes/dmoes) - cada par nos DOIS
95: *   sentidos, via FormBuscaAuxiliar (NAO fwBuscaExt: padrao canonico do
96: *   projeto). O campo de descricao deixou de ser ReadOnly (Fase 4/5 tinha
97: *   essa suposicao errada - o legado o deixa editavel, com mutua exclusao
98: *   via When: so recebe foco quando o campo de codigo irmao esta vazio).
99: *   Validacao em LostFocus, nunca KeyPress (regra #47); guarda de
100: *   reentrancia this_lEmLookup compartilhada entre os 3 pares (picker eh
101: *   modal e tira o foco, regra #37). Tambem entrou aqui o InteractiveChange
102: *   dos 6 campos (FiltroAlterado), que desabilita CopiaLista - mesma
103: *   propriedade de UMA linha so, repetida no dump nos DOIS lados de cada
104: *   par (codigo E descricao, nao so o codigo - corrigido na Fase 8/8,
105: *   faltavam os 3 campos de descricao).
106: *
107: * Fase 7/8 (ESTA FASE) - os eventos restantes:
108: *   - cmd_4c_Marcar/cmd_4c_Desmarcar.Click -> BO.MarcarTodasLinhas(1/0) +
109: *     Refresh de grd_4c_Linhas (Marcar/Desmarcar do legado)
110: *   - cmd_4c_MarcaProd/cmd_4c_DesmarcaProd.Click -> BO.MarcarTodosProdutos
111: *     (1/0) + Refresh de grd_4c_Itens (cmdMarcaProd/cmdDesmarcaProd)
112: *   - chk_4c_MarcaProduto.When -> so edita a celula quando
113: *     cursor_4c_Produtos.lMarcas = 0 (GradeItens.Column1.Check1.When do
114: *     legado, literal)
115: *   - cmd_4c_Processar.Click -> FormParaBO() + BO.BuscarProdutos(""),
116: *     religa grd_4c_Itens (ReligarGradeItens, novo - fatorado de
117: *     CarregarDados porque o BO recria o alias e a grade precisa ser
118: *     religada nas DUAS situacoes) e replica o aviso "Nao existem
119: *     produtos.../habilita CopiaLista" do fim do Processar.Click legado
120: *   - cmd_4c_CopiaLista.Click -> FormParaBO() + BO.ObterProdutosParaCopia
121: *     ("") preenche cursor_4c_ProdutosCopia (cpros/dpros/pvens/pliqs/moevs)
122: *     com os candidatos (flagctabs=1 AND lMarcas=0, filtrados por
123: *     Situacao) - EXATAMENTE o SCAN do CopiaLista.Click legado, so sem a
124: *     parte que pertence ao form PAI (abaixo)
125: *   - cmd_4c_Encerrar Click -> THIS.Release() (literal)
126: *
127: * O QUE CONTINUA DEFERIDO (documentado desde a Fase 3, linhas 35-39): a
128: * gravacao real em CrSigCdLpi - Delete From CrSigCdLpi Where Empty(cpros),
129: * cidchaves via fUniqueIds(), lprecos do cabecalho CrSigCdLpc, flagutabs,
130: * vencis/vencfs, e o arredondamento condicional via fArredondamento
131: * (NAO portada - this_oFormPai so guarda a referencia, gnConnHandle. PILAR
132: * 3 impede acessar objeto do pai por nome fixo (Pagina.Dados.Grade), e
133: * nenhum form SIGOPPxx desta familia foi migrado ainda para expor um
134: * CONTRATO conhecido. BtnCopiaListaClick entrega o cursor ja filtrado
135: * (cursor_4c_ProdutosCopia) ao pai atraves de um metodo PUBLIC opcional
136: * (AdicionarProdutosSelecionados), chamado de forma DEFENSIVA via
137: * PEMSTATUS - o mesmo padrao ja usado em ReabilitarFormPai/RepintarFormPai
138: * (e em FormSigOpCrd.LerTextoDoPai) para nunca estourar enquanto o pai nao
139: * existir. BtnProcessarClick passa par_cCursorListaPrecos = "" pelo mesmo
140: * motivo (equivalente a "lista ainda vazia" no legado).
141: *
142: *------------------------------------------------------------------------------
143: * Fase 8/8 (ESTA FASE) - consolidacao final.
144: *
145: * O prompt generico de Fase 8 pede BtnBuscarClick/BtnSalvarClick/
146: * BtnCancelarClick/HabilitarCampos/LimparCampos/CarregarLista/
147: * AjustarBotoesPorModo - vocabulario do padrao CRUD (frmcadastro, paginas
148: * Lista/Dados, modos INCLUIR/ALTERAR/VISUALIZAR). Este dialogo NAO tem
149: * nenhum desses conceitos no legado (confirmado em comportamento.json: 26
150: * metodos, nenhum Buscar/Salvar/Cancelar, nenhuma nocao de modo) - os
151: * botoes reais sao Processar/Copia p/ Lista/Encerrar/Marcar/Desmarcar/
152: * MarcaProd/DesmarcaProd, TODOS ja ligados nas Fases 4 e 7. Inventar esses
153: * metodos so para satisfazer o nome do template violaria o PILAR 1 (UI e
154: * comportamento inexistentes no legado) e a regra de NUNCA criar stub.
155: *
156: * Verificacao final contra comportamento.json (26/26 metodos) encontrou UM
157: * gap real: Get_DgrVenda/Get_DgrProduto/Get_Dmoevenda (os 3 campos de
158: * DESCRICAO) tambem tem InteractiveChange -> "ThisForm.CopiaLista.Enabled =
159: * .F." no dump (SIGOPSEP.CrtFiltro.Get_DgrVenda etc, linhas ~1239/1289/1333
160: * do dump) - a Fase 6/8 so tinha ligado os 3 campos de CODIGO. Os 3
161: * BINDEVENT faltantes foram adicionados em ConfigurarPaginaLista, reusando
162: * o mesmo handler FiltroAlterado (PILAR 3: 1 metodo so, igual ao dump que
163: * repete a MESMA linha 6 vezes).
164: *
165: * PROCEDURE Load do legado ("=fConfigGeral()") NAO PORTADO, pelo mesmo
166: * motivo ja registrado em FormSigMvExp.prg/FormSigMvMen.prg e nos demais
167: * BOs da familia SigOp*: fConfigGeral era funcao GLOBAL de inicializacao da
168: * aplicacao Fortyus (sig.prg/SIGFUNCS.PRG), ausente do acervo; o wrapper
169: * utils\fconfiggeral.prg (RETURN .T.) existe so para o p-code de VCX
170: * legado que ainda a invoca, nunca para ser chamado por codigo novo. O que
171: * fConfigGeral fazia (SETs, paths, aliases, conexao) ja ocorre antes deste
172: * dialogo abrir, em config.prg/main.prg.
173: *==============================================================================
174: 
175: DEFINE CLASS Formsigopsep AS FormBase
176: 
177:     *==========================================================================
178:     * PROPRIEDADES VISUAIS - PILAR 1: transcritas do dump do SCX
179:     *
180:     * Declaradas no dump de SIGOPSEP: BorderStyle = 2, Height = 600,
181:     * Width = 800, ControlBox = .F., MaxButton = .F., MinButton = .F.,
182:     * TitleBar = 0, Caption = "Seleciona Produtos".
183:     *
184:     * NAO declaradas no dump e portanto NAO inventadas (regra #25): Closable
185:     * fica no default .T. - sem barra de titulo ele nao desenha, mas
186:     * Closable = .F. mataria o Alt+F4 (nao ha botao Encerrar visivel ate a
187:     * fase 5, e mesmo depois o legado nao declara Closable).
188:     *
189:     * DoCreate = .T. do dump NAO entra: flag de design-time do SCX, nao
190:     * property de runtime (regra #33).
191:     *
192:     * WindowType / ShowWindow NAO vem do SCX (legado abria com "Do Form"):
193:     * canonico do projeto e 1 (modal), igual a FormSigOpCrd - o form e
194:     * criado com CREATEOBJECT + Show().
195:     *==========================================================================
196:     this_cMensagemErro = ""
197:     BorderStyle  = 2
198:     Height       = 600
199:     Width        = 800
200:     ControlBox   = .F.
201:     MaxButton    = .F.
202:     MinButton    = .F.
203:     TitleBar     = 0
204:     WindowType   = 1
205:     ShowWindow   = 1
206:     AutoCenter   = .T.
207:     Caption      = "Seleciona Produtos"
208: 
209:     *==========================================================================
210:     * PROPRIEDADES DE ESTADO
211:     *==========================================================================
212:     this_oBusinessObject = .NULL.
213: 
214:     *-- Form PAI (ParentForm do legado). O legado NAO desabilita o pai no
215:     *-- Init (diferente de SigOpCrd) - por isso nao ha flag
216:     *-- this_lPaiDesabilitado aqui; o Destroy ainda reabilita o pai de forma
217:     *-- defensiva (PEMSTATUS) para nunca deixa-lo travado, mesmo que o
218:     *-- caller venha a desabilita-lo por fora no futuro.
219:     this_oFormPai = .NULL.
220: 
221:     *-- Guarda de reentrancia dos 6 lookups de cnt_4c_Filtro: o picker
222:     *-- (FormBuscaAuxiliar) eh MODAL e tira o foco do campo, o que redispara
223:     *-- o proprio LostFocus (regra #37). Compartilhada entre os 3 pares
224:     *-- codigo/descricao, igual ao padrao de FormCco.
225:     this_lEmLookup = .F.
226: 
227: 
228:     *==========================================================================
229:     * Init - recebe o contexto do form PAI
230:     *
231:     * A ORDEM aqui e regra, nao estilo: FormBase.Init() chama
232:     * InicializarForm(), logo o contexto vindo por parametro tem de estar
233:     * guardado ANTES do DODEFAULT().
234:     *
235:     * par_oFormPai - form que abriu o dialogo (ParentForm do legado)
236:     *==========================================================================
237:     PROCEDURE Init(par_oFormPai)
238:         IF VARTYPE(par_oFormPai) = "O"
239:             THIS.this_oFormPai = par_oFormPai
240:         ENDIF
241: 
242:         RETURN DODEFAULT()
243:     ENDPROC
244: 
245: 
246:     *==========================================================================
247:     * InicializarForm - monta a estrutura base do dialogo
248:     *==========================================================================
249:     PROTECTED PROCEDURE InicializarForm()
250:         LOCAL loc_lSucesso, loc_oErro
251: 
252:         loc_lSucesso = .F.
253: 
254:         TRY
255:             THIS.this_oBusinessObject = CREATEOBJECT("sigopsepBO")
256: 
257:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
258:                 *-- Fundo do form (new_background.jpg do dump)
259:                 THIS.ConfigurarPageFrame()
260: 
261:                 *-- Cabecalho cinza (cntSombra do legado) - PRIMEIRO AddObject,
262:                 *-- para os controles das fases seguintes desenharem por cima
263:                 *-- (regra #11)
264:                 THIS.ConfigurarCabecalho()
265: 
266:                 *-- Fase 4: filtros + grade de LINHAS (ConfigurarPaginaLista)
267:                 *-- e grade de PRODUTOS + botoes de acao (ConfigurarPaginaDados)
268:                 THIS.ConfigurarPaginaLista()
269:                 THIS.ConfigurarPaginaDados()
270: 
271:                 *-- AddObject cria tudo com Visible = .F.
272:                 THIS.TornarControlesVisiveis()
273: 
274:                 *-- Replica o fecho do SIGOPSEP.Init: popula CsSigCdLin
275:                 *-- (cursor_4c_Linhas), cria CsSigCdPro (cursor_4c_Produtos)
276:                 *-- vazio e liga as DUAS grades. Entra so aqui, depois de
277:                 *-- TornarControlesVisiveis, porque RecordSource/ControlSource
278:                 *-- exigem o cursor ja criado (regra #41) e o CheckBox das
279:                 *-- colunas de marcacao exige o bind feito (ver CarregarLinhas).
280:                 *-- As duas cargas sao independentes: a falha da primeira nao
281:                 *-- deve mascarar o resultado da segunda, por isso o AND vem
282:                 *-- depois das duas chamadas, nao em curto-circuito.
283:                 loc_lSucesso = THIS.CarregarLinhas()
284:                 loc_lSucesso = THIS.CarregarDados() AND loc_lSucesso
285:             ELSE
286:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
287:                         "vel criar o objeto de neg" + CHR(243) + "cio sigopsepBO.", ;
288:                         "Erro ao Inicializar")
289:             ENDIF
290: 
291:         CATCH TO loc_oErro
292:             THIS.this_cMensagemErro = loc_oErro.Message
293:             MsgErro(loc_oErro.Message + ;
294:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
295:                     " | Proc: " + loc_oErro.Procedure, ;
296:                     "Erro ao inicializar Formsigopsep")
297:             loc_lSucesso = .F.
298:         ENDTRY
299: 
300:         RETURN loc_lSucesso
301:     ENDPROC
302: 
303: 
304:     *==========================================================================
305:     * ConfigurarPageFrame - aparencia base do form
306:     *
307:     * O nome e o do contrato do pipeline; NAO ha PageFrame a criar porque o
308:     * SCX legado nao tem Page nenhuma (layout FLAT - ver cabecalho). Picture
309:     * do dump: ..\framework\imagens\new_background.jpg - o caminho NUNCA se
310:     * reconstroi a partir de gc_4c_CaminhoBase (regra #156/#170); o arquivo
311:     * existe tanto em vbmp\ quanto em Framework\imagens\, e o canonico do
312:     * projeto e gc_4c_CaminhoIcones.
313:     *==========================================================================
314:     PROTECTED PROCEDURE ConfigurarPageFrame()
315:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
316:         THIS.ScrollBars = 0
317: 
318:         RETURN .T.
319:     ENDPROC
320: 
321: 
322:     *==========================================================================
323:     * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
324:     *
325:     * Dump: cntSombra Top=0 Left=0 Width=800 Height=80 BackColor=100,100,100
326:     *       lblSombra Top=18 Height=40 Left=10 Width=769 ForeColor=0,0,0
327:     *       lblTitulo Top=17 Height=46 Left=10 Width=769 ForeColor=255,255,255
328:     *       ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
329:     *
330:     * As larguras 800/769 do dump batem com o Width do form (800), entao nao
331:     * ha o artefato do Form Designer visto em outros dumps (container maior
332:     * que o form) - mesmo assim o container e os labels acompanham
333:     * THIS.Width, nunca o literal, para nao quebrar se o Width mudar.
334:     *==========================================================================
335:     PROTECTED PROCEDURE ConfigurarCabecalho()
336:         THIS.AddObject("cnt_4c_Sombra", "Container")
337:         WITH THIS.cnt_4c_Sombra
338:             .Top           = 0
339:             .Left          = 0
340:             .Width         = THIS.Width
341:             .Height        = 80
342:             .BorderWidth   = 0
343:             .BackStyle     = 1
344:             .BackColor     = RGB(100, 100, 100)
345:             .SpecialEffect = 0
346:             .Visible       = .T.
347:         ENDWITH
348: 
349:         *-- Label de sombra: preto, 1px acima do titulo (efeito de relevo)
350:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
351:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
352:             *-- AutoSize = .F. explicito: AutoSize e NO-OP em Label criado
353:             *-- por AddObject e, com WordWrap = .T., DESCARTA a Height e
354:             *-- corta o texto (regra #23).
355:             .AutoSize      = .F.
356:             .FontName      = "Tahoma"
357:             .FontSize      = 18
358:             .FontBold      = .T.
359:             .FontUnderline = .F.
360:             .WordWrap      = .T.
361:             .Alignment     = 0
362:             .BackStyle     = 0
363:             .Caption       = THIS.Caption
364:             .Top           = 18
365:             .Left          = 10
366:             .Width         = THIS.Width - 20
367:             .Height        = 40
368:             .ForeColor     = RGB(0, 0, 0)
369:             .Visible       = .T.
370:         ENDWITH
371: 
372:         *-- Label do titulo: branco sobre o cinza do container OPACO - este
373:         *-- e o caso em que o branco esta CORRETO (regra #12)
374:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
375:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo

*-- Linhas 414 a 468:
414:     * explicita que caiba o texto (regra #23/#12). AutoSize=.T. NAO entra:
415:     * eh no-op em Label criado por AddObject.
416:     *
417:     * obj_4c_Situacao (Opc_situacao): OptionGroup com ControlSource
418:     * NUMERICO - Value = INDICE do botao (1=Ativos, 2=Inativos, 3=Todos),
419:     * NUNCA 0/1 (regra #45/#188). Legenda/ordem/Top de cada botao
420:     * transcritos do dump, nunca inventados.
421:     *
422:     * grd_4c_Linhas: estrutura so (ColumnCount, fontes, larguras, headers);
423:     * ControlSource e RecordSource ficam para CarregarLinhas(), chamado
424:     * depois de TornarControlesVisiveis() em InicializarForm - atribuir
425:     * ControlSource contra cursor_4c_Linhas aqui derrubaria o Init, porque
426:     * o cursor ainda nao existe (regra #41).
427:     *==========================================================================
428:     PROTECTED PROCEDURE ConfigurarPaginaLista()
429:         THIS.AddObject("cnt_4c_Filtro", "Container")
430:         WITH THIS.cnt_4c_Filtro
431:             .Top           = 130
432:             .Left          = 62
433:             .Width         = 656
434:             .Height        = 182
435:             .BackStyle     = 0
436:             .BorderWidth   = 0
437:             .SpecialEffect = 2
438:             .Visible       = .T.
439:         ENDWITH
440: 
441:         *-- Labels (Say1..Say7 do legado)
442:         THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label1", "Label")
443:         WITH THIS.cnt_4c_Filtro.lbl_4c_Label1
444:             .Caption   = "Grupo Venda :"
445:             .Top       = 9
446:             .Left      = 36
447:             .Width     = 69
448:             .Height    = 17
449:             .FontName  = "Tahoma"
450:             .FontSize  = 8
451:             .Alignment = 0
452:             .BackStyle = 0
453:             .AutoSize  = .F.
454:             .ForeColor = RGB(90, 90, 90)
455:             .Visible   = .T.
456:         ENDWITH
457: 
458:         THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label2", "Label")
459:         WITH THIS.cnt_4c_Filtro.lbl_4c_Label2
460:             .Caption   = "Moeda Venda :"
461:             .Top       = 57
462:             .Left      = 33
463:             .Width     = 72
464:             .Height    = 17
465:             .FontName  = "Tahoma"
466:             .FontSize  = 8
467:             .Alignment = 0
468:             .BackStyle = 0

*-- Linhas 565 a 718:
565:             .Value     = ""
566:             .Visible   = .T.
567:         ENDWITH
568:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrVenda, "LostFocus", THIS, "ValidarGrVenda")
569:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrVenda, "InteractiveChange", THIS, "FiltroAlterado")
570: 
571:         *-- Get_DgrVenda do legado NAO eh ReadOnly: o When so permite foco
572:         *-- quando txt_4c_GrVenda esta vazio (mutua exclusao), e o Valid faz o
573:         *-- lookup reverso por descricao (colecoes.descs)
574:         THIS.cnt_4c_Filtro.AddObject("txt_4c_DgrVenda", "TextBox")
575:         WITH THIS.cnt_4c_Filtro.txt_4c_DgrVenda
576:             .Top       = 6
577:             .Left      = 189
578:             .Width     = 366
579:             .Height    = 23
580:             .MaxLength = 40
581:             .ForeColor = RGB(0, 0, 0)
582:             .TabIndex  = 2
583:             .Value     = ""
584:             .Visible   = .T.
585:         ENDWITH
586:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrVenda, "When",      THIS, "DgrVendaWhenCheck")
587:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrVenda, "LostFocus", THIS, "ValidarDgrVenda")
588:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrVenda, "InteractiveChange", THIS, "FiltroAlterado")
589: 
590:         *-- Grupo de Produto: codigo + descricao, lookup SigCdGrp (cgrus/dgrus)
591:         THIS.cnt_4c_Filtro.AddObject("txt_4c_GrProduto", "TextBox")
592:         WITH THIS.cnt_4c_Filtro.txt_4c_GrProduto
593:             .Top       = 30
594:             .Left      = 109
595:             .Width     = 31
596:             .MaxLength = 3
597:             .ForeColor = RGB(0, 0, 0)
598:             .TabIndex  = 3
599:             .Value     = ""
600:             .Visible   = .T.
601:         ENDWITH
602:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrProduto, "LostFocus", THIS, "ValidarGrProduto")
603:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrProduto, "InteractiveChange", THIS, "FiltroAlterado")
604: 
605:         THIS.cnt_4c_Filtro.AddObject("txt_4c_DgrProduto", "TextBox")
606:         WITH THIS.cnt_4c_Filtro.txt_4c_DgrProduto
607:             .Top       = 30
608:             .Left      = 140
609:             .Width     = 150
610:             .MaxLength = 20
611:             .ForeColor = RGB(0, 0, 0)
612:             .TabIndex  = 4
613:             .Value     = ""
614:             .Visible   = .T.
615:         ENDWITH
616:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrProduto, "When",      THIS, "DgrProdutoWhenCheck")
617:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrProduto, "LostFocus", THIS, "ValidarDgrProduto")
618:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrProduto, "InteractiveChange", THIS, "FiltroAlterado")
619: 
620:         *-- Arredondamento (InputMask "9.9" do dump - regra #49)
621:         THIS.cnt_4c_Filtro.AddObject("txt_4c_Arrend", "TextBox")
622:         WITH THIS.cnt_4c_Filtro.txt_4c_Arrend
623:             .Top       = 30
624:             .Left      = 524
625:             .Width     = 31
626:             .MaxLength = 3
627:             .InputMask = "9.9"
628:             .TabIndex  = 5
629:             .Value     = 0
630:             .Visible   = .T.
631:         ENDWITH
632: 
633:         *-- Moeda de Venda: codigo + descricao, lookup SigCdMoe (cmoes/dmoes)
634:         THIS.cnt_4c_Filtro.AddObject("txt_4c_MoeVenda", "TextBox")
635:         WITH THIS.cnt_4c_Filtro.txt_4c_MoeVenda
636:             .Top       = 54
637:             .Left      = 109
638:             .Width     = 31
639:             .MaxLength = 3
640:             .ForeColor = RGB(0, 0, 0)
641:             .TabIndex  = 6
642:             .Value     = ""
643:             .Visible   = .T.
644:         ENDWITH
645:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_MoeVenda, "LostFocus", THIS, "ValidarMoeVenda")
646:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_MoeVenda, "InteractiveChange", THIS, "FiltroAlterado")
647: 
648:         THIS.cnt_4c_Filtro.AddObject("txt_4c_DmoeVenda", "TextBox")
649:         WITH THIS.cnt_4c_Filtro.txt_4c_DmoeVenda
650:             .Top       = 54
651:             .Left      = 140
652:             .Width     = 115
653:             .MaxLength = 15
654:             .ForeColor = RGB(0, 0, 0)
655:             .TabIndex  = 7
656:             .Value     = ""
657:             .Visible   = .T.
658:         ENDWITH
659:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda, "When",      THIS, "DmoeVendaWhenCheck")
660:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda, "LostFocus", THIS, "ValidarDmoeVenda")
661:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda, "InteractiveChange", THIS, "FiltroAlterado")
662: 
663:         *-- Acrescimo/Desconto percentual (InputMask "9999" do dump)
664:         THIS.cnt_4c_Filtro.AddObject("txt_4c_AcreDesc", "TextBox")
665:         WITH THIS.cnt_4c_Filtro.txt_4c_AcreDesc
666:             .Top       = 54
667:             .Left      = 503
668:             .Width     = 38
669:             .MaxLength = 4
670:             .InputMask = "9999"
671:             .TabIndex  = 8
672:             .Value     = 0
673:             .Visible   = .T.
674:         ENDWITH
675: 
676:         *-- Situacao (Opc_situacao do legado) - Value = indice do botao
677:         *-- (1=Ativos, 2=Inativos, 3=Todos), transcrito do dump
678:         THIS.cnt_4c_Filtro.AddObject("obj_4c_Situacao", "OptionGroup")
679:         WITH THIS.cnt_4c_Filtro.obj_4c_Situacao
680:             .Top         = 6
681:             .Left        = 569
682:             .Width       = 79
683:             .Height      = 69
684:             .ButtonCount = 3
685:             .BackStyle   = 0
686:             .TabIndex    = 9
687:             .Value       = 1
688:             .Visible     = .T.
689: 
690:             WITH .Buttons(1)
691:                 .FontName  = "Tahoma"
692:                 .Caption   = "\<Ativos"
693:                 .Left      = 10
694:                 .Top       = 5
695:                 .BackStyle = 0
696:                 .ForeColor = RGB(90, 90, 90)
697:             ENDWITH
698: 
699:             WITH .Buttons(2)
700:                 .FontName  = "Tahoma"
701:                 .Caption   = "\<Inativos"
702:                 .Left      = 10
703:                 .Top       = 26
704:                 .BackStyle = 0
705:                 .ForeColor = RGB(90, 90, 90)
706:             ENDWITH
707: 
708:             WITH .Buttons(3)
709:                 .FontName  = "Tahoma"
710:                 .FontSize  = 8
711:                 .BackStyle = 0
712:                 .Caption   = "\<Todos"
713:                 .Height    = 15
714:                 .Left      = 10
715:                 .Top       = 47
716:                 .Width     = 47
717:                 .ForeColor = RGB(90, 90, 90)
718:             ENDWITH

*-- Linhas 799 a 1275:
799:             .Themes          = .T.
800:             .Visible         = .T.
801:         ENDWITH
802:         BINDEVENT(THIS.cnt_4c_Filtro.cmd_4c_Marcar, "Click", THIS, "BtnMarcarClick")
803: 
804:         THIS.cnt_4c_Filtro.AddObject("cmd_4c_Desmarcar", "CommandButton")
805:         WITH THIS.cnt_4c_Filtro.cmd_4c_Desmarcar
806:             .Top             = 128
807:             .Left            = 573
808:             .Width           = 40
809:             .Height          = 40
810:             .Caption         = ""
811:             .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
812:             .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
813:             .FontName        = "Comic Sans MS"
814:             .FontSize        = 8
815:             .FontBold        = .T.
816:             .FontItalic      = .T.
817:             .WordWrap        = .T.
818:             .MousePointer    = 15
819:             .ForeColor       = RGB(90, 90, 90)
820:             .BackColor       = RGB(255, 255, 255)
821:             .ToolTipText     = "Desmarca Todas as Linhas de Produto"
822:             .Themes          = .T.
823:             .Visible         = .T.
824:         ENDWITH
825:         BINDEVENT(THIS.cnt_4c_Filtro.cmd_4c_Desmarcar, "Click", THIS, "BtnDesmarcarClick")
826: 
827:         RETURN .T.
828:     ENDPROC
829: 
830: 
831:     *==========================================================================
832:     * CarregarLinhas - FUNIL de carga da grade de Linhas (GradeLinhas)
833:     *
834:     * Replica o trecho do SIGOPSEP.Init que popula CsSigCdLin e liga a grade.
835:     * A ORDEM aqui e regra medida, nao estilo:
836:     *   RecordSource -> ControlSource de TODAS as colunas -> Column.AddObject
837:     *   do CheckBox + .Value = 0 -> Sparse = .F. + CurrentControl -> Width /
838:     *   Header1.Caption.
839:     * Motivos: (a) atribuir ControlSource antes do cursor existir estoura
840:     * "Alias not found" dentro do TRY do InicializarForm e a tela nao abre
841:     * (regra #41); (b) Grid sem RecordSource AUTO-BINDA na area de trabalho
842:     * CORRENTE quando o ColumnCount e definido, e um AddObject de CheckBox
843:     * sobre coluna de texto estoura "Data type mismatch" - por isso o CheckBox
844:     * e instalado AQUI, depois do bind, e nao em ConfigurarPaginaLista;
845:     * (c) BuscarLinhas faz USE IN no alias, o que DESTROI o controle posto por
846:     * Column.AddObject (CurrentControl volta a "Text1") preservando
847:     * ColumnCount/Width/Header - perda PARCIAL e silenciosa, por isso a
848:     * instalacao e reentrante; (d) RecordSource reseta Width/Header1.Caption
849:     * para o default (Problema 48), que tem de ser reaplicados DEPOIS do bind.
850:     *==========================================================================
851:     PROTECTED PROCEDURE CarregarLinhas()
852:         LOCAL loc_oGrid
853: 
854:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
855:             RETURN .F.
856:         ENDIF
857: 
858:         IF !THIS.this_oBusinessObject.BuscarLinhas()
859:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
860:                     NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""), ;
861:                     "Falha na Conex" + CHR(227) + "o")
862:             RETURN .F.
863:         ENDIF
864: 
865:         loc_oGrid = THIS.cnt_4c_Filtro.grd_4c_Linhas
866: 
867:         loc_oGrid.RecordSource = ""
868:         loc_oGrid.ColumnCount = 3
869:         loc_oGrid.RecordSource = "cursor_4c_Linhas"
870:         loc_oGrid.Column1.ControlSource = "cursor_4c_Linhas.lMarcas"
871:         loc_oGrid.Column2.ControlSource = "cursor_4c_Linhas.linhas"
872:         loc_oGrid.Column3.ControlSource = "cursor_4c_Linhas.descs"
873: 
874:         *-- Column1.Check1 do dump: a coluna de marcacao das Linhas
875:         THIS.InstalarCheckBoxColuna(loc_oGrid.Column1, "chk_4c_MarcaLinha")
876: 
877:         *-- A fonte do GRID vai ANTES dos cabecalhos: medido no VFP9 em
878:         *-- 2026-11-17, atribuir Grid.FontName/FontSize PROPAGA para
879:         *-- Column.FontName E para Column.Header1.FontName, sobrescrevendo o
880:         *-- Tahoma 8 que o dump declara por Header1 (ficava Courier New 9).
881:         THIS.FormatarGridLista(loc_oGrid)
882: 
883:         *-- RecordSource reseta Width/Header1.Caption para o default, e a
884:         *-- fonte do grid acabou de achatar o Header1 - reaplicar os dois
885:         *-- (Problema 48). Header1: Tahoma 8 em todas, Alignment 2 nas de
886:         *-- texto, como no dump de GradeLinhas.
887:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column1,  20, "", 0, -1)
888:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column2, 120, ;
889:             "C" + CHR(243) + "digo", 2, -1)
890:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column3, 290, ;
891:             "Descri" + CHR(231) + CHR(227) + "o do Produto", 2, -1)
892: 
893:         SELECT cursor_4c_Linhas
894:         GO TOP
895:         loc_oGrid.Refresh()
896: 
897:         RETURN .T.
898:     ENDPROC
899: 
900: 
901:     *==========================================================================
902:     * FiltroAlterado - InteractiveChange dos 6 campos de cnt_4c_Filtro (os 3
903:     * pares codigo/descricao: GrVenda/DgrVenda, GrProduto/DgrProduto,
904:     * MoeVenda/DmoeVenda). Legado: as SEIS propriedades InteractiveChange do
905:     * SCX fazem so "ThisForm.CopiaLista.Enabled = .F." - qualquer alteracao
906:     * no filtro, pelo codigo OU pela descricao, invalida a selecao de
907:     * produtos ja feita.
908:     *==========================================================================
909:     PROCEDURE FiltroAlterado()
910:         THIS.cmd_4c_CopiaLista.Enabled = .F.
911:     ENDPROC
912: 
913: 
914:     *==========================================================================
915:     * Lookups de cnt_4c_Filtro (fase 6/8) - 3 pares codigo/descricao, cada um
916:     * nos DOIS sentidos, transcritos de Get_grVenda/Get_DgrVenda,
917:     * Get_grProduto/Get_DgrProduto e Get_moevenda/Get_Dmoevenda.
918:     *
919:     * Padrao (igual nos 3 pares):
920:     *   - campo CODIGO: Valid do legado sem When - sempre editavel. Vazio
921:     *     limpa so a descricao (This.Parent.Get_DX.Value = ''); preenchido,
922:     *     faz SEEK exato e abre o picker so se nao achou (contrato
923:     *     this_lAchouRegistro - regra #37); ESC/cancelamento LIMPA os DOIS
924:     *     campos (LastKey()<>27 And Used(...) no legado) - diferente da
925:     *     regra #50 (que veda apagar o digitado quando NAO ha picker): aqui
926:     *     o picker SEMPRE abre antes de limpar, e o proprio legado manda
927:     *     limpar no cancelamento.
928:     *   - campo DESCRICAO: so recebe foco quando o campo CODIGO irmao esta
929:     *     vazio (When = Return(Empty(Parent.Get_X.Value)), mutua exclusao -
930:     *     BINDEVENT "When" compartilha o retorno com o nativo). Mesmo
931:     *     contrato do lookup, buscando pela coluna de DESCRICAO.
932:     *
933:     * Guarda this_lEmLookup: o picker eh MODAL e tira o foco do campo, o que
934:     * redispara o proprio LostFocus (regra #37) - compartilhada entre os 3
935:     * pares, igual ao padrao de FormCco.
936:     *==========================================================================
937: 
938:     *--------------------------------------------------------------------------
939:     * Par 1: Grupo de Venda <-> Descricao (SigCdCol: colecoes/descs)
940:     *--------------------------------------------------------------------------
941:     PROCEDURE DgrVendaWhenCheck()
942:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value))
943:     ENDPROC
944: 
945:     PROCEDURE ValidarGrVenda()
946:         IF THIS.this_lEmLookup
947:             RETURN
948:         ENDIF
949: 
950:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value))
951:             THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ""
952:         ELSE
953:             THIS.AbrirBuscaGrVenda()
954:         ENDIF
955:     ENDPROC
956: 
957:     PROCEDURE ValidarDgrVenda()
958:         IF THIS.this_lEmLookup
959:             RETURN
960:         ENDIF
961: 
962:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value))
963:             THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value = ""
964:         ELSE
965:             THIS.AbrirBuscaDgrVenda()
966:         ENDIF
967:     ENDPROC
968: 
969:     PROTECTED PROCEDURE AbrirBuscaGrVenda()
970:         LOCAL loc_oBusca, loc_cValor, loc_oErro
971: 
972:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value)
973: 
974:         THIS.this_lEmLookup = .T.
975:         TRY
976:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
977:                 "SigCdCol", "cursor_4c_BuscaColecoes", "colecoes", loc_cValor, ;
978:                 "Cole" + CHR(231) + CHR(245) + "es")
979: 
980:             IF VARTYPE(loc_oBusca) = "O"
981:                 IF !loc_oBusca.this_lAchouRegistro
982:                     loc_oBusca.mAddColuna("colecoes", "XXXXXXXXXX", "C" + CHR(243) + "digo")
983:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
984:                     loc_oBusca.Show()
985:                 ENDIF
986: 
987:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaColecoes")
988:                     THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value  = ALLTRIM(cursor_4c_BuscaColecoes.colecoes)
989:                     THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ALLTRIM(cursor_4c_BuscaColecoes.descs)
990:                 ELSE
991:                     THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value  = ""
992:                     THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ""
993:                 ENDIF
994: 
995:                 loc_oBusca.Release()
996:             ENDIF
997:         CATCH TO loc_oErro
998:             MsgErro("Erro em Formsigopsep.AbrirBuscaGrVenda: " + loc_oErro.Message, "Erro")
999:         ENDTRY
1000:         THIS.this_lEmLookup = .F.
1001: 
1002:         IF USED("cursor_4c_BuscaColecoes")
1003:             USE IN cursor_4c_BuscaColecoes
1004:         ENDIF
1005:     ENDPROC
1006: 
1007:     PROTECTED PROCEDURE AbrirBuscaDgrVenda()
1008:         LOCAL loc_oBusca, loc_cValor, loc_oErro
1009: 
1010:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value)
1011: 
1012:         THIS.this_lEmLookup = .T.
1013:         TRY
1014:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1015:                 "SigCdCol", "cursor_4c_BuscaColecoes", "descs", loc_cValor, ;
1016:                 "Cole" + CHR(231) + CHR(245) + "es")
1017: 
1018:             IF VARTYPE(loc_oBusca) = "O"
1019:                 IF !loc_oBusca.this_lAchouRegistro
1020:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1021:                     loc_oBusca.mAddColuna("colecoes", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1022:                     loc_oBusca.Show()
1023:                 ENDIF
1024: 
1025:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaColecoes")
1026:                     THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ALLTRIM(cursor_4c_BuscaColecoes.descs)
1027:                     THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value  = ALLTRIM(cursor_4c_BuscaColecoes.colecoes)
1028:                 ELSE
1029:                     THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ""
1030:                     THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value  = ""
1031:                 ENDIF
1032: 
1033:                 loc_oBusca.Release()
1034:             ENDIF
1035:         CATCH TO loc_oErro
1036:             MsgErro("Erro em Formsigopsep.AbrirBuscaDgrVenda: " + loc_oErro.Message, "Erro")
1037:         ENDTRY
1038:         THIS.this_lEmLookup = .F.
1039: 
1040:         IF USED("cursor_4c_BuscaColecoes")
1041:             USE IN cursor_4c_BuscaColecoes
1042:         ENDIF
1043:     ENDPROC
1044: 
1045: 
1046:     *--------------------------------------------------------------------------
1047:     * Par 2: Grupo de Produto <-> Descricao (SigCdGrp: cgrus/dgrus)
1048:     *--------------------------------------------------------------------------
1049:     PROCEDURE DgrProdutoWhenCheck()
1050:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value))
1051:     ENDPROC
1052: 
1053:     PROCEDURE ValidarGrProduto()
1054:         IF THIS.this_lEmLookup
1055:             RETURN
1056:         ENDIF
1057: 
1058:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value))
1059:             THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ""
1060:         ELSE
1061:             THIS.AbrirBuscaGrProduto()
1062:         ENDIF
1063:     ENDPROC
1064: 
1065:     PROCEDURE ValidarDgrProduto()
1066:         IF THIS.this_lEmLookup
1067:             RETURN
1068:         ENDIF
1069: 
1070:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value))
1071:             THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value = ""
1072:         ELSE
1073:             THIS.AbrirBuscaDgrProduto()
1074:         ENDIF
1075:     ENDPROC
1076: 
1077:     PROTECTED PROCEDURE AbrirBuscaGrProduto()
1078:         LOCAL loc_oBusca, loc_cValor, loc_oErro
1079: 
1080:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value)
1081: 
1082:         THIS.this_lEmLookup = .T.
1083:         TRY
1084:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1085:                 "SigCdGrp", "cursor_4c_BuscaGrupos", "cgrus", loc_cValor, ;
1086:                 "Sele" + CHR(231) + CHR(227) + "o")
1087: 
1088:             IF VARTYPE(loc_oBusca) = "O"
1089:                 IF !loc_oBusca.this_lAchouRegistro
1090:                     loc_oBusca.mAddColuna("cgrus", "XXXXXX", "C" + CHR(243) + "digo")
1091:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1092:                     loc_oBusca.Show()
1093:                 ENDIF
1094: 
1095:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupos")
1096:                     THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = ALLTRIM(cursor_4c_BuscaGrupos.cgrus)
1097:                     THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ALLTRIM(cursor_4c_BuscaGrupos.dgrus)
1098:                 ELSE
1099:                     THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = ""
1100:                     THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ""
1101:                 ENDIF
1102: 
1103:                 loc_oBusca.Release()
1104:             ENDIF
1105:         CATCH TO loc_oErro
1106:             MsgErro("Erro em Formsigopsep.AbrirBuscaGrProduto: " + loc_oErro.Message, "Erro")
1107:         ENDTRY
1108:         THIS.this_lEmLookup = .F.
1109: 
1110:         IF USED("cursor_4c_BuscaGrupos")
1111:             USE IN cursor_4c_BuscaGrupos
1112:         ENDIF
1113:     ENDPROC
1114: 
1115:     PROTECTED PROCEDURE AbrirBuscaDgrProduto()
1116:         LOCAL loc_oBusca, loc_cValor, loc_oErro
1117: 
1118:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value)
1119: 
1120:         THIS.this_lEmLookup = .T.
1121:         TRY
1122:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1123:                 "SigCdGrp", "cursor_4c_BuscaGrupos", "dgrus", loc_cValor, ;
1124:                 "Sele" + CHR(231) + CHR(227) + "o")
1125: 
1126:             IF VARTYPE(loc_oBusca) = "O"
1127:                 IF !loc_oBusca.this_lAchouRegistro
1128:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1129:                     loc_oBusca.mAddColuna("cgrus", "XXXXXX", "C" + CHR(243) + "digo")
1130:                     loc_oBusca.Show()
1131:                 ENDIF
1132: 
1133:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupos")
1134:                     THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ALLTRIM(cursor_4c_BuscaGrupos.dgrus)
1135:                     THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = ALLTRIM(cursor_4c_BuscaGrupos.cgrus)
1136:                 ELSE
1137:                     THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ""
1138:                     THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = ""
1139:                 ENDIF
1140: 
1141:                 loc_oBusca.Release()
1142:             ENDIF
1143:         CATCH TO loc_oErro
1144:             MsgErro("Erro em Formsigopsep.AbrirBuscaDgrProduto: " + loc_oErro.Message, "Erro")
1145:         ENDTRY
1146:         THIS.this_lEmLookup = .F.
1147: 
1148:         IF USED("cursor_4c_BuscaGrupos")
1149:             USE IN cursor_4c_BuscaGrupos
1150:         ENDIF
1151:     ENDPROC
1152: 
1153: 
1154:     *--------------------------------------------------------------------------
1155:     * Par 3: Moeda de Venda <-> Descricao (SigCdMoe: cmoes/dmoes)
1156:     *
1157:     * Unica assimetria do trio: Get_Dmoevenda.Valid do legado NAO tem o ramo
1158:     * "If Empty(This.Value) / Parent.Get_MoeVenda.Value = ''" que os outros
1159:     * dois pares tem - so entra no bloco de lookup quando !Empty(This.Value).
1160:     * Com o campo vazio, o codigo e simplesmente IGNORADO (o When ja garante
1161:     * que so se chega aqui com o codigo vazio de qualquer forma). Transcrito
1162:     * literalmente: ValidarDmoeVenda NAO limpa txt_4c_MoeVenda no ramo vazio.
1163:     *--------------------------------------------------------------------------
1164:     PROCEDURE DmoeVendaWhenCheck()
1165:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value))
1166:     ENDPROC
1167: 
1168:     PROCEDURE ValidarMoeVenda()
1169:         IF THIS.this_lEmLookup
1170:             RETURN
1171:         ENDIF
1172: 
1173:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value))
1174:             THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ""
1175:         ELSE
1176:             THIS.AbrirBuscaMoeVenda()
1177:         ENDIF
1178:     ENDPROC
1179: 
1180:     PROCEDURE ValidarDmoeVenda()
1181:         IF THIS.this_lEmLookup
1182:             RETURN
1183:         ENDIF
1184: 
1185:         IF !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value))
1186:             THIS.AbrirBuscaDmoeVenda()
1187:         ENDIF
1188:     ENDPROC
1189: 
1190:     PROTECTED PROCEDURE AbrirBuscaMoeVenda()
1191:         LOCAL loc_oBusca, loc_cValor, loc_oErro
1192: 
1193:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value)
1194: 
1195:         THIS.this_lEmLookup = .T.
1196:         TRY
1197:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1198:                 "SigCdMoe", "cursor_4c_BuscaMoedas", "cmoes", loc_cValor, ;
1199:                 "Sele" + CHR(231) + CHR(227) + "o")
1200: 
1201:             IF VARTYPE(loc_oBusca) = "O"
1202:                 IF !loc_oBusca.this_lAchouRegistro
1203:                     loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
1204:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1205:                     loc_oBusca.Show()
1206:                 ENDIF
1207: 
1208:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedas")
1209:                     THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value  = ALLTRIM(cursor_4c_BuscaMoedas.cmoes)
1210:                     THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ALLTRIM(cursor_4c_BuscaMoedas.dmoes)
1211:                 ELSE
1212:                     THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value  = ""
1213:                     THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ""
1214:                 ENDIF
1215: 
1216:                 loc_oBusca.Release()
1217:             ENDIF
1218:         CATCH TO loc_oErro
1219:             MsgErro("Erro em Formsigopsep.AbrirBuscaMoeVenda: " + loc_oErro.Message, "Erro")
1220:         ENDTRY
1221:         THIS.this_lEmLookup = .F.
1222: 
1223:         IF USED("cursor_4c_BuscaMoedas")
1224:             USE IN cursor_4c_BuscaMoedas
1225:         ENDIF
1226:     ENDPROC
1227: 
1228:     PROTECTED PROCEDURE AbrirBuscaDmoeVenda()
1229:         LOCAL loc_oBusca, loc_cValor, loc_oErro
1230: 
1231:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value)
1232: 
1233:         THIS.this_lEmLookup = .T.
1234:         TRY
1235:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1236:                 "SigCdMoe", "cursor_4c_BuscaMoedas", "dmoes", loc_cValor, ;
1237:                 "Sele" + CHR(231) + CHR(227) + "o")
1238: 
1239:             IF VARTYPE(loc_oBusca) = "O"
1240:                 IF !loc_oBusca.this_lAchouRegistro
1241:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1242:                     loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
1243:                     loc_oBusca.Show()
1244:                 ENDIF
1245: 
1246:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedas")
1247:                     THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ALLTRIM(cursor_4c_BuscaMoedas.dmoes)
1248:                     THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value  = ALLTRIM(cursor_4c_BuscaMoedas.cmoes)
1249:                 ELSE
1250:                     THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ""
1251:                     THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value  = ""
1252:                 ENDIF
1253: 
1254:                 loc_oBusca.Release()
1255:             ENDIF
1256:         CATCH TO loc_oErro
1257:             MsgErro("Erro em Formsigopsep.AbrirBuscaDmoeVenda: " + loc_oErro.Message, "Erro")
1258:         ENDTRY
1259:         THIS.this_lEmLookup = .F.
1260: 
1261:         IF USED("cursor_4c_BuscaMoedas")
1262:             USE IN cursor_4c_BuscaMoedas
1263:         ENDIF
1264:     ENDPROC
1265: 
1266: 
1267:     *==========================================================================
1268:     * ConfigurarPaginaDados - grade de PRODUTOS + botoes de acao
1269:     *
1270:     * O nome vem do contrato do pipeline; nao ha Page a configurar (layout
1271:     * FLAT - ver cabecalho). Aqui entram os objetos que o dump declara direto
1272:     * na Form: GradeItens (grd_4c_Itens) e os cinco CommandButton de acao
1273:     * (Sair/CopiaLista/Processar/cmdMarcaProd/cmdDesmarcaProd).
1274:     *
1275:     * APENAS a estrutura da grade (ColumnCount, fontes, larguras, headers):

*-- Linhas 1291 a 1334:
1291:     * cmdMarcaProd/cmdDesmarcaProd sao fwbtnp (classe: 40x40), icone-only.
1292:     * Picture: todos TRANSCRITOS do dump (regra #25), conferidos em vbmp\.
1293:     *==========================================================================
1294:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1295:         *----------------------------------------------------------------------
1296:         * GradeItens -> grd_4c_Itens (dump: Top=316 Left=64 Width=673
1297:         * Height=130 ColumnCount=6 FontName="Courier New" TabIndex=2)
1298:         *
1299:         * RecordMark/DeleteMark nao sao declarados no dump desta grade (ao
1300:         * contrario de GradeLinhas, que declara RecordMark = .F.); ficam .F.
1301:         * por serem o canonico do projeto para grade de dados em OPERACIONAL.
1302:         *----------------------------------------------------------------------
1303:         THIS.AddObject("grd_4c_Itens", "Grid")
1304:         WITH THIS.grd_4c_Itens
1305:             .Top         = 316
1306:             .Left        = 64
1307:             .Width       = 673
1308:             .Height      = 130
1309:             .ColumnCount = 6
1310:             .FontName    = "Courier New"
1311:             .FontSize    = 9
1312:             .ReadOnly    = .F.
1313:             .RecordMark  = .F.
1314:             .DeleteMark  = .F.
1315:             .TabIndex    = 2
1316:             .Visible     = .T.
1317:         ENDWITH
1318: 
1319:         *-- Column1: marcacao (CheckBox). O ReadOnly da COLUNA vem DEPOIS do
1320:         *-- ReadOnly do GRID, que propaga e sobrescreveria (regra #18).
1321:         WITH THIS.grd_4c_Itens.Column1
1322:             .FontName          = "Courier New"
1323:             .Width             = 20
1324:             .Movable           = .F.
1325:             .Resizable         = .F.
1326:             .Sparse            = .F.
1327:             .ReadOnly          = .F.
1328:             .Visible           = .T.
1329:             .Header1.Caption   = ""
1330:             .Header1.FontName  = "Tahoma"
1331:             .Header1.FontSize  = 8
1332:             .Header1.ForeColor = RGB(0, 0, 0)
1333:         ENDWITH
1334: 

*-- Linhas 1468 a 1895:
1468:             .ToolTipText     = "Seleciona os Produtos Conforme os Filtros"
1469:             .Visible         = .T.
1470:         ENDWITH
1471:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
1472: 
1473:         *-- Copia p/ Lista (dump: Top=3 Left=576, geral_pendencia_60.jpg,
1474:         *-- PicturePosition = 7)
1475:         THIS.AddObject("cmd_4c_CopiaLista", "CommandButton")
1476:         WITH THIS.cmd_4c_CopiaLista
1477:             .Top             = 3
1478:             .Left            = 576
1479:             .Width           = 75
1480:             .Height          = 75
1481:             .Caption         = "Copia p/ \<Lista"
1482:             .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
1483:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
1484:             .PicturePosition = 7
1485:             .FontName        = "Comic Sans MS"
1486:             .FontSize        = 8
1487:             .FontBold        = .T.
1488:             .FontItalic      = .T.
1489:             .WordWrap        = .T.
1490:             .AutoSize        = .F.
1491:             .MousePointer    = 15
1492:             .ForeColor       = RGB(90, 90, 90)
1493:             .BackColor       = RGB(255, 255, 255)
1494:             .Themes          = .T.
1495:             .ToolTipText     = "Copia os Produtos Marcados Para a Lista"
1496:             .Visible         = .T.
1497:         ENDWITH
1498:         BINDEVENT(THIS.cmd_4c_CopiaLista, "Click", THIS, "BtnCopiaListaClick")
1499: 
1500:         *-- Encerrar (Sair do dump: Top=3 Left=725, Cancel = .T. - e o botao
1501:         *-- que responde ao ESC; cadastro_sair_60.jpg)
1502:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
1503:         WITH THIS.cmd_4c_Encerrar
1504:             .Top             = 3
1505:             .Left            = 725
1506:             .Width           = 75
1507:             .Height          = 75
1508:             .Caption         = "Encerrar"
1509:             .Cancel          = .T.
1510:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1511:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1512:             .FontName        = "Comic Sans MS"
1513:             .FontSize        = 8
1514:             .FontBold        = .T.
1515:             .FontItalic      = .T.
1516:             .WordWrap        = .T.
1517:             .AutoSize        = .F.
1518:             .MousePointer    = 15
1519:             .ForeColor       = RGB(90, 90, 90)
1520:             .BackColor       = RGB(255, 255, 255)
1521:             .Themes          = .T.
1522:             .ToolTipText     = "Encerra a Sele" + CHR(231) + CHR(227) + "o de Produtos"
1523:             .Visible         = .T.
1524:         ENDWITH
1525:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
1526: 
1527:         *-- Marca / Desmarca TODOS os PRODUTOS (cmdMarcaProd/cmdDesmarcaProd
1528:         *-- do dump: Top=455, Left=626/666, fwbtnp 40x40, icone-only).
1529:         *-- Nomes distintos dos irmaos de cnt_4c_Filtro (cmd_4c_Marcar/
1530:         *-- cmd_4c_Desmarcar), que marcam LINHAS e nao PRODUTOS.
1531:         THIS.AddObject("cmd_4c_MarcaProd", "CommandButton")
1532:         WITH THIS.cmd_4c_MarcaProd
1533:             .Top             = 455
1534:             .Left            = 626
1535:             .Width           = 40
1536:             .Height          = 40
1537:             .Caption         = ""
1538:             .Picture         = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
1539:             .DisabledPicture = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
1540:             .FontName        = "Comic Sans MS"
1541:             .FontSize        = 8
1542:             .FontBold        = .T.
1543:             .FontItalic      = .T.
1544:             .WordWrap        = .T.
1545:             .MousePointer    = 15
1546:             .ForeColor       = RGB(90, 90, 90)
1547:             .BackColor       = RGB(255, 255, 255)
1548:             .Themes          = .T.
1549:             .ToolTipText     = "Marca Todas as Linhas de Produto"
1550:             .Visible         = .T.
1551:         ENDWITH
1552:         BINDEVENT(THIS.cmd_4c_MarcaProd, "Click", THIS, "BtnMarcaProdClick")
1553: 
1554:         THIS.AddObject("cmd_4c_DesmarcaProd", "CommandButton")
1555:         WITH THIS.cmd_4c_DesmarcaProd
1556:             .Top             = 455
1557:             .Left            = 666
1558:             .Width           = 40
1559:             .Height          = 40
1560:             .Caption         = ""
1561:             .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
1562:             .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
1563:             .FontName        = "Comic Sans MS"
1564:             .FontSize        = 8
1565:             .FontBold        = .T.
1566:             .FontItalic      = .T.
1567:             .WordWrap        = .T.
1568:             .MousePointer    = 15
1569:             .ForeColor       = RGB(90, 90, 90)
1570:             .BackColor       = RGB(255, 255, 255)
1571:             .Themes          = .T.
1572:             .ToolTipText     = "Desmarca Todas as Linhas de Produto"
1573:             .Visible         = .T.
1574:         ENDWITH
1575:         BINDEVENT(THIS.cmd_4c_DesmarcaProd, "Click", THIS, "BtnDesmarcaProdClick")
1576: 
1577:         RETURN .T.
1578:     ENDPROC
1579: 
1580: 
1581:     *==========================================================================
1582:     * CarregarDados - FUNIL de carga da grade de Produtos (GradeItens)
1583:     *
1584:     * Replica o fecho do SIGOPSEP.Init: cria CsSigCdPro VAZIO, liga a grade,
1585:     * aplica o DynamicForeColor e deixa CopiaLista desabilitado (so Processar
1586:     * habilita, quando trouxer produtos).
1587:     *
1588:     * A estrutura do cursor mora UNICAMENTE no BO (CriarCursorProdutos):
1589:     * repetir o CREATE CURSOR aqui criaria duas versoes do mesmo cursor, e
1590:     * divergencia de ordem/nome de campo quebra em silencio o APPEND e o
1591:     * ControlSource. Serve a toda repintura (aqui e, na fase de eventos, em
1592:     * Processar), pela mesma sequencia medida que CarregarLinhas documenta.
1593:     *==========================================================================
1594:     PROTECTED PROCEDURE CarregarDados()
1595:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1596:             RETURN .F.
1597:         ENDIF
1598: 
1599:         *-- Sem o cursor, atribuir ControlSource estoura "Alias not found"
1600:         *-- dentro do TRY do InicializarForm e a tela nao abre (regra #41)
1601:         THIS.this_oBusinessObject.CriarCursorProdutos()
1602: 
1603:         IF !THIS.ReligarGradeItens()
1604:             RETURN .F.
1605:         ENDIF
1606: 
1607:         *-- SIGOPSEP.Init termina com CopiaLista.Enabled = .F.
1608:         THIS.cmd_4c_CopiaLista.Enabled = .F.
1609: 
1610:         RETURN .T.
1611:     ENDPROC
1612: 
1613: 
1614:     *==========================================================================
1615:     * ReligarGradeItens - (re)liga grd_4c_Itens a cursor_4c_Produtos
1616:     *
1617:     * Fatorado de CarregarDados (Fase 4) porque BO.BuscarProdutos (Fase 7,
1618:     * usado em BtnProcessarClick) RECRIA cursor_4c_Produtos (USE IN +
1619:     * CREATE CURSOR, via CriarCursorProdutos) para popula-lo com dados
1620:     * reais - a MESMA razao, ja documentada em InstalarCheckBoxColuna, pela
1621:     * qual fechar/recriar o alias do RecordSource destroi o CheckBox posto
1622:     * por Column.AddObject. Por isso o bind tem de ser refeito do ZERO
1623:     * depois de QUALQUER recriacao do cursor, nao so na carga inicial.
1624:     *==========================================================================
1625:     PROTECTED PROCEDURE ReligarGradeItens()
1626:         LOCAL loc_oGrid
1627: 
1628:         IF !USED("cursor_4c_Produtos")
1629:             RETURN .F.
1630:         ENDIF
1631: 
1632:         loc_oGrid = THIS.grd_4c_Itens
1633: 
1634:         loc_oGrid.RecordSource = ""
1635:         loc_oGrid.ColumnCount = 6
1636:         loc_oGrid.RecordSource = "cursor_4c_Produtos"
1637:         loc_oGrid.Column1.ControlSource = "cursor_4c_Produtos.flagctabs"
1638:         loc_oGrid.Column2.ControlSource = "cursor_4c_Produtos.cpros"
1639:         loc_oGrid.Column3.ControlSource = "cursor_4c_Produtos.dpros"
1640:         loc_oGrid.Column4.ControlSource = "cursor_4c_Produtos.pvens"
1641:         loc_oGrid.Column5.ControlSource = "cursor_4c_Produtos.moevs"
1642:         loc_oGrid.Column6.ControlSource = "cursor_4c_Produtos.pliqs"
1643: 
1644:         *-- Column1.Check1 do dump: a coluna de marcacao dos Produtos. O
1645:         *-- objeto acabou de nascer de novo (RecordSource acima destruiu o
1646:         *-- anterior) - religar o When (GradeItens.Column1.Check1.When do
1647:         *-- legado: "Return(CsSigCdPro.lMarcas = 0)") no objeto NOVO.
1648:         THIS.InstalarCheckBoxColuna(loc_oGrid.Column1, "chk_4c_MarcaProduto")
1649:         BINDEVENT(loc_oGrid.Column1.chk_4c_MarcaProduto, "When", THIS, "WhenMarcaProduto")
1650: 
1651:         *-- DynamicForeColor do legado: azul no produto que JA esta na lista de
1652:         *-- precos do form pai (lMarcas = 1), preto nos demais. Transcrito do
1653:         *-- SIGOPSEP.Init, com o nome do cursor migrado.
1654:         loc_oGrid.SetAll("DynamicForeColor", ;
1655:             "RGB(0,0,IIF(cursor_4c_Produtos.lMarcas = 0,0,255))", "Column")
1656: 
1657:         *-- A fonte do GRID vai ANTES dos cabecalhos: medido no VFP9 em
1658:         *-- 2026-11-17, atribuir Grid.FontName/FontSize PROPAGA para
1659:         *-- Column.FontName E para Column.Header1.FontName, sobrescrevendo o
1660:         *-- Tahoma 8 que o dump declara por Header1 (ficava Courier New 9).
1661:         THIS.FormatarGridLista(loc_oGrid)
1662: 
1663:         *-- RecordSource reseta Width/Header1.Caption para o default, e a
1664:         *-- fonte do grid acabou de achatar o Header1 - reaplicar os dois
1665:         *-- (Problema 48). Header1 de GradeItens no dump: Tahoma 8,
1666:         *-- Alignment 2 nas colunas de texto, ForeColor 0,0,0 em todas MENOS
1667:         *-- a de Preco de Venda (C), que o legado pinta de 36,84,155.
1668:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column1,  20, "", 0, RGB(0, 0, 0))
1669:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column2, 108, ;
1670:             "C" + CHR(243) + "digo Produto", 2, RGB(0, 0, 0))
1671:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column3, 250, ;
1672:             "Descri" + CHR(231) + CHR(227) + "o do Produto", 2, RGB(0, 0, 0))
1673:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column4, 110, ;
1674:             "Pre" + CHR(231) + "o de Venda (C)", 2, RGB(36, 84, 155))
1675:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column5,  40, "Moeda", 2, RGB(0, 0, 0))
1676:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column6, 110, ;
1677:             "Pre" + CHR(231) + "o de Venda (L)", 2, RGB(0, 0, 0))
1678: 
1679:         SELECT cursor_4c_Produtos
1680:         GO TOP
1681:         loc_oGrid.Refresh()
1682: 
1683:         RETURN .T.
1684:     ENDPROC
1685: 
1686: 
1687:     *==========================================================================
1688:     * WhenMarcaProduto - When do CheckBox de marcacao de grd_4c_Itens
1689:     * (GradeItens.Column1.Check1.When do legado: "Return(CsSigCdPro.lMarcas
1690:     * = 0)", literal). So permite editar a celula quando o produto AINDA
1691:     * NAO esta na lista de precos do pai - produto ja presente (lMarcas=1)
1692:     * fica travado, visualmente distinguido pelo DynamicForeColor azul de
1693:     * ReligarGradeItens.
1694:     *==========================================================================
1695:     PROCEDURE WhenMarcaProduto()
1696:         IF USED("cursor_4c_Produtos")
1697:             RETURN (cursor_4c_Produtos.lMarcas = 0)
1698:         ENDIF
1699: 
1700:         RETURN .T.
1701:     ENDPROC
1702: 
1703: 
1704:     *==========================================================================
1705:     * Eventos dos botoes de acao (Fase 7/8)
1706:     *==========================================================================
1707: 
1708:     *--------------------------------------------------------------------------
1709:     * BtnMarcarClick / BtnDesmarcarClick - Marcar.Click/Desmarcar.Click do
1710:     * legado (marcam/desmarcam TODAS as linhas da grade de filtro).
1711:     *--------------------------------------------------------------------------
1712:     PROCEDURE BtnMarcarClick()
1713:         IF THIS.this_oBusinessObject.MarcarTodasLinhas(1)
1714:             THIS.cnt_4c_Filtro.grd_4c_Linhas.Refresh()
1715:         ENDIF
1716:     ENDPROC
1717: 
1718:     PROCEDURE BtnDesmarcarClick()
1719:         IF THIS.this_oBusinessObject.MarcarTodasLinhas(0)
1720:             THIS.cnt_4c_Filtro.grd_4c_Linhas.Refresh()
1721:         ENDIF
1722:     ENDPROC
1723: 
1724:     *--------------------------------------------------------------------------
1725:     * BtnMarcaProdClick / BtnDesmarcaProdClick - cmdMarcaProd.Click/
1726:     * cmdDesmarcaProd.Click do legado (marcam/desmarcam TODOS os produtos
1727:     * da grade de resultado que ainda nao estao na lista - lMarcas = 0).
1728:     *--------------------------------------------------------------------------
1729:     PROCEDURE BtnMarcaProdClick()
1730:         IF THIS.this_oBusinessObject.MarcarTodosProdutos(1)
1731:             THIS.grd_4c_Itens.Refresh()
1732:         ENDIF
1733:     ENDPROC
1734: 
1735:     PROCEDURE BtnDesmarcaProdClick()
1736:         IF THIS.this_oBusinessObject.MarcarTodosProdutos(0)
1737:             THIS.grd_4c_Itens.Refresh()
1738:         ENDIF
1739:     ENDPROC
1740: 
1741:     *--------------------------------------------------------------------------
1742:     * BtnProcessarClick - Processar.Click do legado: consulta SigCdPro
1743:     * pelos filtros atuais (FormParaBO sincroniza a UI nas properties do
1744:     * BO) e preenche grd_4c_Itens.
1745:     *
1746:     * par_cCursorListaPrecos de BuscarProdutos() vai "" por ora: o form pai
1747:     * (SIGOPPxx) ainda nao existe migrado, e o nome do cursor de itens dele
1748:     * eh desconhecido neste CONTRATO (PILAR 3 - ver nota no cabecalho do
1749:     * arquivo). BuscarProdutos trata "" como "nenhum item ja esta na
1750:     * lista", que eh exatamente o caso mais comum (Processar roda ANTES de
1751:     * qualquer Copia p/ Lista).
1752:     *--------------------------------------------------------------------------
1753:     PROCEDURE BtnProcessarClick()
1754:         WAIT WINDOW "Aguarde !!! Selecionando Produtos..." NOWAIT
1755: 
1756:         THIS.FormParaBO()
1757: 
1758:         IF !THIS.this_oBusinessObject.BuscarProdutos("")
1759:             WAIT CLEAR
1760:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
1761:                     NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""), ;
1762:                     "Falha na Conex" + CHR(227) + "o")
1763:             THIS.Release()
1764:             RETURN
1765:         ENDIF
1766: 
1767:         THIS.ReligarGradeItens()
1768: 
1769:         WAIT CLEAR
1770: 
1771:         IF EOF("cursor_4c_Produtos")
1772:             MsgAviso("N" + CHR(227) + "o existem produtos com esses par" + ;
1773:                      CHR(226) + "metros !!!", "Aten" + CHR(231) + CHR(227) + "o")
1774:             THIS.cnt_4c_Filtro.txt_4c_GrVenda.SetFocus()
1775:         ELSE
1776:             THIS.cmd_4c_CopiaLista.Enabled = .T.
1777:             THIS.grd_4c_Itens.SetFocus()
1778:         ENDIF
1779:     ENDPROC
1780: 
1781:     *--------------------------------------------------------------------------
1782:     * BtnCopiaListaClick - CopiaLista.Click do legado: devolve ao form pai
1783:     * os produtos marcados (flagctabs=1) que ainda nao estao na lista
1784:     * (lMarcas=0), respeitando a Situacao do filtro, e encerra o dialogo.
1785:     *
1786:     * BO.ObterProdutosParaCopia("") replica o SCAN inteiro do legado
1787:     * (guard de Situacao incluso) e preenche cursor_4c_ProdutosCopia
1788:     * (cpros/dpros/pvens/pliqs/moevs) - exatamente os candidatos que o
1789:     * legado insere em CrSigCdLpi.
1790:     *
1791:     * A gravacao em si (limpar a linha em branco, cidchaves via
1792:     * fUniqueIds(), lprecos do cabecalho CrSigCdLpc, flagutabs, vencis/
1793:     * vencfs, arredondamento condicional via fArredondamento quando
1794:     * CompVenda <> "C") pertence ao form PAI - ele quem conhece
1795:     * CrSigCdLpi/CrSigCdLpc/CompVenda/poDataMgr. Entregar o cursor por um
1796:     * metodo PUBLIC opcional (AdicionarProdutosSelecionados), chamado
1797:     * DEFENSIVAMENTE via PEMSTATUS, eh o mesmo padrao ja usado em
1798:     * ReabilitarFormPai/RepintarFormPai - nao estoura enquanto nenhum form
1799:     * SIGOPPxx desta familia existir migrado.
1800:     *--------------------------------------------------------------------------
1801:     PROCEDURE BtnCopiaListaClick()
1802:         LOCAL loc_oErro
1803: 
1804:         THIS.FormParaBO()
1805: 
1806:         IF !THIS.this_oBusinessObject.ObterProdutosParaCopia("")
1807:             MsgErro(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""), ;
1808:                     "Formsigopsep.BtnCopiaListaClick")
1809:             RETURN
1810:         ENDIF
1811: 
1812:         IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
1813:                 PEMSTATUS(THIS.this_oFormPai, "AdicionarProdutosSelecionados", 5)
1814:             TRY
1815:                 THIS.this_oFormPai.AdicionarProdutosSelecionados("cursor_4c_ProdutosCopia")
1816:             CATCH TO loc_oErro
1817:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
1818:                         "vel copiar os produtos para a lista: " + loc_oErro.Message, ;
1819:                         "Formsigopsep.BtnCopiaListaClick")
1820:             ENDTRY
1821:         ENDIF
1822: 
1823:         THIS.Release()
1824:     ENDPROC
1825: 
1826:     *--------------------------------------------------------------------------
1827:     * BtnEncerrarClick - Sair.Click do legado (literal: ThisForm.Release()).
1828:     * Destroy() (abaixo) replica o fecho de SIGOPSEP.Release - cursores
1829:     * locais, repintar e reabilitar o pai.
1830:     *--------------------------------------------------------------------------
1831:     PROCEDURE BtnEncerrarClick()
1832:         THIS.Release()
1833:     ENDPROC
1834: 
1835: 
1836:     *==========================================================================
1837:     * InstalarCheckBoxColuna - instala (ou REINSTALA) o CheckBox de marcacao
1838:     * numa Column de Grid, no estado em que o dump declara Column1.Check1
1839:     * (Top=27 Left=7 Width=60 Height=17 Alignment=0 Caption="" ReadOnly=.F.) -
1840:     * o mesmo nos dois grids do form.
1841:     *
1842:     * Column.AddObject cria o objeto mas NAO o exibe: sem CurrentControl a
1843:     * coluna segue desenhando o Text1 dela, e sem Sparse = .F. o controle
1844:     * aparece so na linha ativa (regra #18).
1845:     *
1846:     * REENTRANTE de proposito: fechar/recriar o alias do RecordSource destroi
1847:     * o objeto adicionado por Column.AddObject (CurrentControl volta a
1848:     * "Text1") preservando ColumnCount/Width/Header - perda PARCIAL e
1849:     * silenciosa. Por isso o AddObject so corre quando o membro sumiu, e todo
1850:     * o resto e sempre reaplicado.
1851:     *
1852:     * par_oColuna - objeto Column, JA ligado via ControlSource
1853:     * par_cNome   - nome do CheckBox a instalar nessa coluna
1854:     *==========================================================================
1855:     PROTECTED PROCEDURE InstalarCheckBoxColuna(par_oColuna, par_cNome)
1856:         LOCAL loc_oChk
1857: 
1858:         IF VARTYPE(par_oColuna) != "O" OR VARTYPE(par_cNome) != "C" OR EMPTY(par_cNome)
1859:             RETURN .F.
1860:         ENDIF
1861: 
1862:         IF !PEMSTATUS(par_oColuna, par_cNome, 5)
1863:             par_oColuna.AddObject(par_cNome, "CheckBox")
1864:         ENDIF
1865: 
1866:         *-- Membro alcancado por NOME: EVALUATE na leitura. Controls(<nome>) e
1867:         *-- indexado por NUMERO e estouraria em runtime (regras #15/#34).
1868:         loc_oChk = EVALUATE("par_oColuna." + par_cNome)
1869: 
1870:         IF VARTYPE(loc_oChk) != "O"
1871:             RETURN .F.
1872:         ENDIF
1873: 
1874:         WITH loc_oChk
1875:             .Caption   = ""
1876:             .Alignment = 0
1877:             .Top       = 27
1878:             .Left      = 7
1879:             .Width     = 60
1880:             .Height    = 17
1881:             .ReadOnly  = .F.
1882:             *-- CheckBox.Value e NUMERICO (0/1), nunca .F./.T.: as colunas
1883:             *-- ligadas (lMarcas/flagctabs) sao N(1)
1884:             .Value     = 0
1885:             .Visible   = .T.
1886:         ENDWITH
1887: 
1888:         par_oColuna.Sparse         = .F.
1889:         par_oColuna.CurrentControl = par_cNome
1890:         par_oColuna.ReadOnly       = .F.
1891: 
1892:         RETURN .T.
1893:     ENDPROC
1894: 
1895:     *==========================================================================

*-- Linhas 1910 a 2114:
1910:     *                   NAO declara ForeColor, para nao inventar propriedade
1911:     *                   que o legado deixou no default (regra #25)
1912:     *==========================================================================
1913:     PROTECTED PROCEDURE AplicarCabecalhoColuna(par_oColuna, par_nWidth, ;
1914:             par_cCaption, par_nAlignment, par_nForeColor)
1915: 
1916:         IF VARTYPE(par_oColuna) != "O"
1917:             RETURN .F.
1918:         ENDIF
1919: 
1920:         WITH par_oColuna
1921:             .Width             = par_nWidth
1922:             .Header1.Caption   = par_cCaption
1923:             .Header1.FontName  = "Tahoma"
1924:             .Header1.FontSize  = 8
1925:             .Header1.Alignment = par_nAlignment
1926: 
1927:             IF par_nForeColor >= 0
1928:                 .Header1.ForeColor = par_nForeColor
1929:             ENDIF
1930:         ENDWITH
1931: 
1932:         RETURN .T.
1933:     ENDPROC
1934: 
1935: 
1936:     *==========================================================================
1937:     * FormParaBO - le os campos de cnt_4c_Filtro para as properties do BO.
1938:     *
1939:     * Chamado ANTES de Processar (Fase 6/8): o legado le os mesmos campos
1940:     * direto do container CrtFiltro dentro de Grupo_op.Processar.Click (With
1941:     * ThisForm.CrtFiltro / lcCGrus = ... / lcColecoes = ... / lcMoevs = ...
1942:     * / lnAjuste = 1 + (.Get_AcreDesc.Value/100) / lnArredonda =
1943:     * .Get_Arrend.Value / lnSitua = .Opc_situacao.Value).
1944:     *
1945:     * Os campos de DESCRICAO (txt_4c_DgrVenda/DgrProduto/DmoeVenda) sao
1946:     * ReadOnly e preenchidos so pelo lookup (fase 6/8) - ainda assim sao
1947:     * espelhados aqui porque BOParaForm precisa do caminho inverso simetrico
1948:     * (ex.: reabrir o dialogo com filtro ja preenchido pelo form pai).
1949:     *
1950:     * obj_4c_Situacao.Value JA eh o indice do botao (1/2/3) - nunca 0/1
1951:     * (regra #45/#188), por isso vai direto, sem IIF.
1952:     *==========================================================================
1953:     PROTECTED PROCEDURE FormParaBO()
1954:         WITH THIS.this_oBusinessObject
1955:             .this_cGrupoVenda        = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value)
1956:             .this_cDescGrupoVenda    = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value)
1957:             .this_cGrupoProduto      = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value)
1958:             .this_cDescGrupoProduto  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value)
1959:             .this_cMoedaVenda        = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value)
1960:             .this_cDescMoedaVenda    = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value)
1961:             .this_nAcrescimoDesconto = THIS.cnt_4c_Filtro.txt_4c_AcreDesc.Value
1962:             .this_nArredondamento    = THIS.cnt_4c_Filtro.txt_4c_Arrend.Value
1963:             .this_nSituacao          = THIS.cnt_4c_Filtro.obj_4c_Situacao.Value
1964:         ENDWITH
1965:     ENDPROC
1966: 
1967: 
1968:     *==========================================================================
1969:     * BOParaForm - caminho inverso de FormParaBO, usado pelo Init (Fase 1/8
1970:     * ja guarda o estado no BO com os defaults do SIGOPSEP.Init - pcMercs
1971:     * vazio) e por qualquer recarga futura do filtro a partir do BO.
1972:     *==========================================================================
1973:     PROTECTED PROCEDURE BOParaForm()
1974:         WITH THIS.this_oBusinessObject
1975:             THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value    = .this_cGrupoVenda
1976:             THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value   = .this_cDescGrupoVenda
1977:             THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = .this_cGrupoProduto
1978:             THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = .this_cDescGrupoProduto
1979:             THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value   = .this_cMoedaVenda
1980:             THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value  = .this_cDescMoedaVenda
1981:             THIS.cnt_4c_Filtro.txt_4c_AcreDesc.Value   = .this_nAcrescimoDesconto
1982:             THIS.cnt_4c_Filtro.txt_4c_Arrend.Value     = .this_nArredondamento
1983:             THIS.cnt_4c_Filtro.obj_4c_Situacao.Value   = .this_nSituacao
1984:         ENDWITH
1985:     ENDPROC
1986: 
1987: 
1988:     *==========================================================================
1989:     * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
1990:     *
1991:     * Sem parametro (igual FormSigOpCrd): este form nao tem container
1992:     * flutuante a filtrar ate agora. Se uma fase futura introduzir painel
1993:     * Visible=.F. alternado por botao, o filtro entra aqui.
1994:     *==========================================================================
1995:     PROTECTED PROCEDURE TornarControlesVisiveis()
1996:         LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho
1997: 
1998:         FOR loc_nI = 1 TO THIS.ControlCount
1999:             loc_oControle = THIS.Controls(loc_nI)
2000: 
2001:             IF VARTYPE(loc_oControle) = "O"
2002:                 IF PEMSTATUS(loc_oControle, "Visible", 5)
2003:                     loc_oControle.Visible = .T.
2004:                 ENDIF
2005: 
2006:                 IF PEMSTATUS(loc_oControle, "ControlCount", 5)
2007:                     FOR loc_nJ = 1 TO loc_oControle.ControlCount
2008:                         loc_oFilho = loc_oControle.Controls(loc_nJ)
2009:                         IF VARTYPE(loc_oFilho) = "O" AND PEMSTATUS(loc_oFilho, "Visible", 5)
2010:                             loc_oFilho.Visible = .T.
2011:                         ENDIF
2012:                     ENDFOR
2013:                 ENDIF
2014:             ENDIF
2015:         ENDFOR
2016: 
2017:         RETURN .T.
2018:     ENDPROC
2019: 
2020: 
2021:     *==========================================================================
2022:     * FormatarGridLista - formatacao visual padrao de grid (fase 4/5 chamam
2023:     * apos popular grd_4c_Linhas / grd_4c_Itens)
2024:     *==========================================================================
2025:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2026:         IF VARTYPE(par_oGrid) != "O"
2027:             RETURN .F.
2028:         ENDIF
2029: 
2030:         par_oGrid.FontName = "Courier New"
2031:         par_oGrid.FontSize = 9
2032:         par_oGrid.Refresh()
2033: 
2034:         RETURN .T.
2035:     ENDPROC
2036: 
2037: 
2038:     *==========================================================================
2039:     * RepintarFormPai - ParentForm.Pagina.Dados.Refresh do legado
2040:     * (SIGOPSEP.Release). THIS.this_oFormPai.Refresh() cascateia para TODOS
2041:     * os controles do form pai (containers/paginas/grids) - o Form.Refresh
2042:     * nativo do VFP9 ja desce a arvore de controles sozinho, entao nao e
2043:     * preciso conhecer os nomes _4c_ do pai (PILAR 3) nem presumir a
2044:     * hierarquia Pagina.Dados.Grade do legado. Serve a QUALQUER form pai
2045:     * desta familia (SIGOPPxx), migrado com qualquer layout.
2046:     *==========================================================================
2047:     PROCEDURE RepintarFormPai()
2048:         LOCAL loc_oErro
2049: 
2050:         IF VARTYPE(THIS.this_oFormPai) != "O"
2051:             RETURN .F.
2052:         ENDIF
2053: 
2054:         TRY
2055:             THIS.this_oFormPai.Refresh()
2056:         CATCH TO loc_oErro
2057:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel repintar a tela de origem: " + ;
2058:                     loc_oErro.Message, "Formsigopsep.RepintarFormPai")
2059:         ENDTRY
2060: 
2061:         RETURN .T.
2062:     ENDPROC
2063: 
2064: 
2065:     *==========================================================================
2066:     * ReabilitarFormPai - ParentForm.Enabled = .T. do legado (SIGOPSEP.Release)
2067:     *
2068:     * O legado faz isso INCONDICIONALMENTE (sem flag de "fomos nos que
2069:     * desabilitamos") - diferente de SigOpCrd. Mantido defensivo via
2070:     * PEMSTATUS para nunca estourar se o pai nao tiver a property.
2071:     *==========================================================================
2072:     PROCEDURE ReabilitarFormPai()
2073:         LOCAL loc_oErro
2074: 
2075:         IF VARTYPE(THIS.this_oFormPai) != "O"
2076:             RETURN .F.
2077:         ENDIF
2078: 
2079:         TRY
2080:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
2081:                 THIS.this_oFormPai.Enabled = .T.
2082:             ENDIF
2083:         CATCH TO loc_oErro
2084:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel reabilitar a tela de origem: " + ;
2085:                     loc_oErro.Message, "Formsigopsep.ReabilitarFormPai")
2086:         ENDTRY
2087: 
2088:         RETURN .T.
2089:     ENDPROC
2090: 
2091: 
2092:     *==========================================================================
2093:     * Destroy - equivalente ao SIGOPSEP.Release: cursores locais, repintar
2094:     * (RepintarFormPai) e reabilitar (ReabilitarFormPai) o pai, na mesma
2095:     * ordem do legado (Refresh antes de Enabled = .T.). SetFocus no Grade
2096:     * do pai (Pagina.Dados.Grade.Column1.SetFocus) fica de fora - exigiria
2097:     * conhecer o nome do grid do pai, violando o PILAR 3 (ver nota de
2098:     * CONTRATO no cabecalho do arquivo); o Refresh em cascata ja garante
2099:     * que os dados aparecam.
2100:     *==========================================================================
2101:     PROCEDURE Destroy()
2102:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2103:             THIS.this_oBusinessObject.LimparCursores()
2104:             THIS.this_oBusinessObject = .NULL.
2105:         ENDIF
2106: 
2107:         THIS.RepintarFormPai()
2108:         THIS.ReabilitarFormPai()
2109:         THIS.this_oFormPai = .NULL.
2110: 
2111:         DODEFAULT()
2112:     ENDPROC
2113: 
2114: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopsepBO.prg):
*==============================================================================
* SIGOPSEPBO.PRG
* Business Object - Selecao de Produtos para Lista de Preco
* Origem: SIGOPSEP.SCX (form filho, chamado por ThisForm.ParentForm)
*==============================================================================

DEFINE CLASS sigopsepBO AS BusinessBase

    *-- Filtro: Grupo de Venda (colecoes - SigCdCol)
    this_cGrupoVenda = ""
    this_cDescGrupoVenda = ""

    *-- Filtro: Grupo de Produto (cgrus - SigCdGrp)
    this_cGrupoProduto = ""
    this_cDescGrupoProduto = ""

    *-- Filtro: Moeda de Venda (cmoes - SigCdMoe)
    this_cMoedaVenda = ""
    this_cDescMoedaVenda = ""

    *-- Filtro: Acrescimo/Desconto percentual
    this_nAcrescimoDesconto = 0

    *-- Filtro: Arredondamento
    this_nArredondamento = 0

    *-- Filtro: Situacao (1=Ativos, 2=Inativos, 3=Todos)
    this_nSituacao = 1

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdPro")

        THIS.this_cCampoChave = "cpros"

        THIS.this_cGrupoVenda = ""
        THIS.this_cDescGrupoVenda = ""
        THIS.this_cGrupoProduto = ""
        THIS.this_cDescGrupoProduto = ""
        THIS.this_cMoedaVenda = ""
        THIS.this_cDescMoedaVenda = ""
        THIS.this_nAcrescimoDesconto = 0
        THIS.this_nArredondamento = 0
        THIS.this_nSituacao = 1

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhas - Carrega cursor_4c_Linhas (SigCdLin) para a grade de
    * marcacao de linhas do filtro (SIGOPSEP.Init: CsSigCdLin).
    * SQLEXEC() devolve cursor SOMENTE-LEITURA; como a grade marca/desmarca
    * via REPLACE, convertemos para READWRITE antes de expor o cursor.
    *
    * O bypass de teste vem no TOPO porque o TesteAutomatico.prg e o
    * ValidarUIFidelity.prg NAO conectam ao SQL Server (definem gnConnHandle
    * como SENTINELA). Sem ele a falha de conexao devolveria .F., o
    * InicializarForm do Form devolveria .F., CREATEOBJECT devolveria o
    * LOGICO .F. e a tela simplesmente nao abriria no harness - com uma
    * mensagem de conexao que nao corresponde a falha de rede nenhuma. O
    * cursor VAZIO e criado com a MESMA estrutura e ordem de campos do SELECT
    * abaixo (lMarcas, linhas C(10), descs C(40) - larguras de SigCdLin no
    * schema), para a grade ter o que ligar em ControlSource.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinhas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF
            CREATE CURSOR cursor_4c_Linhas (lMarcas N(1), linhas C(10), descs C(40))
            SELECT cursor_4c_Linhas
            GO TOP
            RETURN .T.
        ENDIF

        TRY
            IF USED("cursor_4c_LinhasTmp")
                USE IN cursor_4c_LinhasTmp
            ENDIF
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF

            loc_cSQL = "SELECT 0 AS lMarcas, linhas, descs FROM SigCdLin"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhasTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_LinhasTmp INTO CURSOR cursor_4c_Linhas READWRITE

                IF USED("cursor_4c_LinhasTmp")
                    USE IN cursor_4c_LinhasTmp
                ENDIF

                SELECT cursor_4c_Linhas
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasLinhas - Replica Marcar.Click/Desmarcar.Click (Replace All
    * lMarcas With <valor> In CsSigCdLin).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodasLinhas(par_nValor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Linhas")
                SELECT cursor_4c_Linhas
                REPLACE ALL lMarcas WITH par_nValor
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorProdutos - Estrutura identica ao "Create Cursor CsSigCdPro"
    * do SIGOPSEP.Init. Cursor local (nao vem de SQLEXEC), por isso ja nasce
    * READWRITE - suporta o CheckBox da coluna flagctabs (Column1) e os
    * REPLACE de MarcarTodosProdutos/ObterProdutosParaCopia.
    *
    * PUBLIC de proposito: o Form chama este metodo para criar o cursor VAZIO
    * antes de ligar a grade de produtos (o SIGOPSEP.Init legado faz o
    * "Create Cursor" inline, antes do RecordSource/ControlSource). Deixar a
    * estrutura do cursor SO aqui evita duas versoes do mesmo CREATE CURSOR -
    * divergencia de ordem/nome de campo quebra em silencio o APPEND e o
    * ControlSource da grade. Metodo que o Form chama de fora NAO pode ser
    * PROTECTED em nenhum nivel da heranca (regra #51): a chamada compila
    * limpo e estoura em runtime com "Property ... is not found".
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorProdutos()
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF

        CREATE CURSOR cursor_4c_Produtos (flagctabs N(1), cpros C(14), dpros C(40), pvens N(12,2), ;
            pliqs N(12,2), moevs C(3), situas N(1), cgrus C(3), colecoes C(10), linhas C(10), lMarcas N(1))

        INDEX ON cpros + cgrus TAG CProGrus
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Replica SIGOPSEP.Processar.Click: monta o WHERE a
    * partir dos filtros (this_cGrupoProduto/this_cGrupoVenda/
    * this_cMoedaVenda) e das linhas marcadas em cursor_4c_Linhas, consulta
    * SigCdPro e recria cursor_4c_Produtos com pliqs calculado
    * (this_nAcrescimoDesconto/this_nArredondamento).
    *
    * par_cCursorListaPrecos: cursor VFP do form pai (equivalente a
    * CrSigCdLpi) - usado so para marcar flagctabs/lMarcas = 1 quando o
    * produto ja esta na lista de precos (Seek por CPros, igual ao legado).
    * Passar "" quando o form pai ainda nao disponibilizar esse cursor.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos(par_cCursorListaPrecos)
        LOCAL loc_lSucesso, loc_cWhere, loc_cLinhas, loc_cSQL, loc_nResultado, ;
            loc_nVariacao, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cWhere = "0 = 0 "

            IF !EMPTY(THIS.this_cGrupoProduto)
                loc_cWhere = loc_cWhere + "AND cgrus = " + EscaparSQL(THIS.this_cGrupoProduto) + " "
            ENDIF
            IF !EMPTY(THIS.this_cGrupoVenda)
                loc_cWhere = loc_cWhere + "AND colecoes = " + EscaparSQL(THIS.this_cGrupoVenda) + " "
            ENDIF
            IF !EMPTY(THIS.this_cMoedaVenda)
                loc_cWhere = loc_cWhere + "AND moevs = " + EscaparSQL(THIS.this_cMoedaVenda) + " "
            ENDIF

            loc_cLinhas = ""
            IF USED("cursor_4c_Linhas")
                SELECT cursor_4c_Linhas
                GO TOP
                SCAN
                    IF cursor_4c_Linhas.lMarcas = 1
                        loc_cLinhas = loc_cLinhas + "linhas = " + EscaparSQL(cursor_4c_Linhas.linhas) + " OR "
                    ENDIF
                ENDSCAN
            ENDIF
            IF !EMPTY(loc_cLinhas)
                loc_cWhere = loc_cWhere + "AND (" + LEFT(loc_cLinhas, LEN(loc_cLinhas) - 3) + ") "
            ENDIF

            loc_cSQL = "SELECT flagctabs, cpros, dpros, pvens, moevs, situas, cgrus, colecoes, linhas " + ;
                       "FROM SigCdPro " + ;
                       "WHERE " + loc_cWhere + ;
                       "ORDER BY cpros, cgrus, flagctabs, dpros, pvens, moevs, situas, colecoes, linhas"

            IF USED("cursor_4c_ProdutosTmp")
                USE IN cursor_4c_ProdutosTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTmp")

            IF loc_nResultado >= 0
                THIS.CriarCursorProdutos()

                loc_nVariacao = 1 + (THIS.this_nAcrescimoDesconto / 100)

                SELECT cursor_4c_ProdutosTmp
                GO TOP
                SCAN
                    SCATTER MEMVAR

                    IF !EMPTY(par_cCursorListaPrecos) AND USED(par_cCursorListaPrecos) ;
                            AND SEEK(cursor_4c_ProdutosTmp.cpros, par_cCursorListaPrecos, "CPros")
                        m.flagctabs = 1
                    ELSE
                        m.flagctabs = 0
                    ENDIF
                    m.lMarcas = m.flagctabs

                    m.pliqs = ROUND(cursor_4c_ProdutosTmp.pvens * loc_nVariacao, 2)
                    IF THIS.this_nArredondamento <> 0
                        m.pliqs = ROUND(m.pliqs / THIS.this_nArredondamento, 0) * THIS.this_nArredondamento
                    ENDIF

                    INSERT INTO cursor_4c_Produtos FROM MEMVAR

                    SELECT cursor_4c_ProdutosTmp
                ENDSCAN

                IF USED("cursor_4c_ProdutosTmp")
                    USE IN cursor_4c_ProdutosTmp
                ENDIF

                SELECT cursor_4c_Produtos
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodosProdutos - Replica cmdMarcaProd.Click/cmdDesmarcaProd.Click
    * (Replace All flagctabs With <valor> For lMarcas = 0).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodosProdutos(par_nValor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                REPLACE ALL flagctabs WITH par_nValor FOR lMarcas = 0
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterProdutosParaCopia - Replica o SCAN de SIGOPSEP.CopiaLista.Click:
    * seleciona os produtos marcados pelo usuario (flagctabs=1) que ainda
    * nao estavam na lista (lMarcas=0), respeitando o filtro de situacao
    * (this_nSituacao: 3=Todos), e reconfere que nao foram copiados nesse
    * meio-tempo (Seek por CPros no cursor do form pai).
    *
    * par_cCursorListaPrecos: cursor VFP do form pai (CrSigCdLpi).
    *
    * A INSERCAO final nesse cursor (cidchaves=fUniqueIds(), lprecos do
    * cabecalho CrSigCdLpc, vencis/vencfs={}, flagutabs=.T., pvens=pliqs)
    * fica por conta do Form: a estrutura de CrSigCdLpi/CrSigCdLpc pertence
    * ao form pai (fora do escopo deste BO, que so enxerga SigCdPro/
    * SigCdLin). fArredondamento(pvens, poDataMgr) do legado NAO foi
    * portada (funcao global Fortyus ausente do acervo, SIGFUNCS.PRG) -
    * fica de fora de proposito; o Form aplica essa funcao, quando portada,
    * somente quando o form pai indicar CompVenda <> "C" (mesmo guard do
    * legado). NUNCA substituir por ROUND/INT/CEILING.
    *
    * Popula cursor_4c_ProdutosCopia com cpros/dpros/pvens/pliqs/moevs.
    *--------------------------------------------------------------------------
    PROCEDURE ObterProdutosParaCopia(par_cCursorListaPrecos)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro

        loc_lSucesso = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        IF !USED("cursor_4c_Produtos")
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            TRY
                IF USED("cursor_4c_ProdutosCopia")
                    USE IN cursor_4c_ProdutosCopia
                ENDIF

                CREATE CURSOR cursor_4c_ProdutosCopia (cpros C(14), dpros C(40), pvens N(12,2), ;
                    pliqs N(12,2), moevs C(3))

                SELECT cursor_4c_Produtos
                GO TOP
                SCAN FOR cursor_4c_Produtos.flagctabs = 1 AND cursor_4c_Produtos.lMarcas = 0
                    IF THIS.this_nSituacao = 3 OR THIS.this_nSituacao = cursor_4c_Produtos.situas
                        IF EMPTY(par_cCursorListaPrecos) OR !USED(par_cCursorListaPrecos) ;
                                OR !SEEK(cursor_4c_Produtos.cpros, par_cCursorListaPrecos, "CPros")
                            INSERT INTO cursor_4c_ProdutosCopia (cpros, dpros, pvens, pliqs, moevs) VALUES ;
                                (cursor_4c_Produtos.cpros, cursor_4c_Produtos.dpros, cursor_4c_Produtos.pvens, ;
                                 cursor_4c_Produtos.pliqs, cursor_4c_Produtos.moevs)
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_Produtos
                ENDSCAN

                SELECT cursor_4c_ProdutosCopia
                GO TOP

                loc_lSucesso = .T.

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha os cursores locais abertos pelo BO.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED("cursor_4c_Linhas")
            USE IN cursor_4c_Linhas
        ENDIF
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF
        IF USED("cursor_4c_ProdutosCopia")
            USE IN cursor_4c_ProdutosCopia
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores locais ao destruir o BO.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Este BO NAO persiste nenhuma tabela propria: o SIGOPSEP legado apenas
    * CONSULTA SigCdPro/SigCdLin (filtros + grade de selecao) e copia os
    * produtos marcados para o cursor de ITENS do form pai (CrSigCdLpi,
    * fora do escopo deste BO) - nunca grava em SigCdPro. Por isso
    * Inserir()/Atualizar()/ExecutarExclusao()/RegistrarAuditoria()/
    * CarregarDoCursor()/ObterChavePrimaria() NAO sao sobrescritos aqui - o
    * comportamento padrao herdado de BusinessBase ja eh o correto para
    * este caso (mesmo padrao de SigOpCtsBO.prg/SigOpAutBO.prg, outras
    * telas operacionais sem tabela mestre propria).
    *==========================================================================

ENDDEFINE

