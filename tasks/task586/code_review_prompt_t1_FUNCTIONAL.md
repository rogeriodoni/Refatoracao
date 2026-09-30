# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (18)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_OPESTOQUE, CNT_4C_OPCUSTO, CNT_4C_OPCOMPRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [INIT-DUPLICADO] Init() chama DODEFAULT() E THIS.InicializarForm(). FormBase.Init() ja chama InicializarForm() internamente. Isso causa 'A member object with this name already exists' porque ConfigurarPageFrame/AddObject executa 2 vezes. CORRIGIR: Remover THIS.InicializarForm() do Init() - DODEFAULT() ja faz isso.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TmpConta' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'OpEstoque' (parent: SIGPRCCC): Top original=200 vs migrado 'cnt_4c_OpEstoque' Top=2 (diff=198px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpEstoque' (parent: SIGPRCCC): Left original=139 vs migrado 'cnt_4c_OpEstoque' Left=182 (diff=43px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCCC.OpEstoque): Top original=90 vs migrado 'lbl_4c_Label1' Top=547 (diff=457px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCCC.OpEstoque): Left original=35 vs migrado 'lbl_4c_Label1' Left=171 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpConta' (parent: SIGPRCCC): Top original=114 vs migrado 'cnt_4c_OpConta' Top=2 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpConta' (parent: SIGPRCCC): Left original=139 vs migrado 'cnt_4c_OpConta' Left=171 (diff=32px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Estoque' (parent: SIGPRCCC): Left original=425 vs migrado 'cnt_4c_OpEstoque' Left=182 (diff=243px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Conta' (parent: SIGPRCCC): Left original=350 vs migrado 'cnt_4c_OpConta' Left=171 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpCusto' (parent: SIGPRCCC): Top original=349 vs migrado 'cnt_4c_OpCusto' Top=2 (diff=347px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCCC.OpCusto): Top original=39 vs migrado 'lbl_4c_Label1' Top=547 (diff=508px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCCC.OpCusto): Left original=35 vs migrado 'lbl_4c_Label1' Left=171 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpCompra' (parent: SIGPRCCC): Top original=447 vs migrado 'cnt_4c_OpCompra' Top=2 (diff=445px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCCC.OpCompra): Top original=39 vs migrado 'lbl_4c_Label1' Top=547 (diff=508px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCCC.OpCompra): Left original=35 vs migrado 'lbl_4c_Label1' Left=171 (diff=136px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2054 linhas total):

*-- Linhas 5 a 91:
5: * Fase 8/8: Form COMPLETO - eventos principais, eventos auxiliares e
6: *           consolidacao final
7: *
8: * Processo em lote com 4 frentes autonomas de recalculo, cada uma
9: * filtrada pelos campos do respectivo container flutuante:
10: *   - cnt_4c_OpConta   (Conta Corrente)
11: *   - cnt_4c_OpEstoque (Estoque)
12: *   - cnt_4c_OpCusto   (Custo de Produto)   - campos criados nesta fase
13: *   - cnt_4c_OpCompra  (Ultima Compra)      - campos criados nesta fase
14: * Os quatro comecam ocultos (Visible=.F.), exatamente como no legado, e
15: * sao exibidos/expandidos (com a mesma animacao de Width do legado) pelos
16: * checkboxes chk_4c_Conta/Estoque/BtnCusto/BtnCompra (Fase 4).
17: *
18: * Lookups (Fase 6), todos via AbrirLookupCanonico (FormBase - Pattern A
19: * seguro, NUNCA o Pattern B defeituoso "CREATEOBJECT com 2+ args"):
20: *   - Empresa (SigCdEmp.Cemps/Razas)     - nos 4 containers
21: *   - Grupo   (SigCdGcr.Codigos/Descrs)  - OpConta/OpEstoque (substitui
22: *     fAcessoContab, banido como handler de UI - so exato + picker canonico)
23: *   - Conta/Estoque (SigCdCli.IClis/RClis, filtrado por Grupo) - OpConta e
24: *     OpEstoque (substitui fAcessoContas, banido como handler de UI)
25: *   - Moeda   (SigCdMoe.Cmoes/Dmoes)     - OpConta
26: *   - Produto/Descricao (SigCdPro.CPros/DPros, bidirecional) - OpEstoque/
27: *     OpCusto/OpCompra
28: * Cada campo tem KeyPress (Enter/Tab valida por igualdade exata e so abre o
29: * picker se nao achar; F4 sempre abre direto) e DblClick (sempre abre).
30: *
31: * O botao cmd_4c_Processa nasce Enabled=.F. e so eh habilitado quando algum
32: * checkbox eh marcado. O Click dele (BtnProcessarClick, Fase 7) transcreve o
33: * Processa.Click do legado (556 linhas): trava a tela, roda as frentes
34: * MARCADAS na ordem Conta -> Estoque -> Custo -> Ultima Compra delegando cada
35: * uma ao metodo correspondente do BO (RecalcularContaCorrente /
36: * RecalcularEstoque / RecalcularCustoProduto / AtualizarUltimaCompra, onde
37: * moram o SQL, os cursores temporarios, fRecalculaS/P/C e o fwprogressbar),
38: * destrava a tela em QUALQUER saida e exibe o "Processamento Concluido".
39: * cmd_4c_Cancela.Click eh definitivo desde a Fase 4 (THIS.Release(),
40: * identico ao legado "ThisForm.Release").
41: *
42: * Fase 8 - eventos auxiliares fechados nesta fase (os dois "When" do SCX, que
43: * nao existiam no migrado e nao se migram por BINDEVENT, porque o VFP descarta
44: * o retorno do delegate):
45: *   - SIGPRCCC.Get_Registro.When ("Return .f.") -> txt_4c_Registro nasce
46: *     .ReadOnly = .T. / .TabStop = .F. (contador de progresso, escrito so por
47: *     AtualizarContadorRegistros).
48: *   - SIGPRCCC.Op{Estoque,Custo,Compra}.Get_Descs.When
49: *     ("Return(Empty(This.Parent.Get_Produto.Value))") -> AplicarWhenDescricao,
50: *     chamada no InicializarForm, nos dois helpers de lookup de produto e no
51: *     InteractiveChange do respectivo txt_4c_Produto.
52: *
53: *==============================================================================
54: * DISPOSICAO DOS NOMES CANONICOS DE CRUD (nenhum se aplica a esta tela)
55: *==============================================================================
56: * Este form NAO tem CRUD: o legado (SIGPRCCC, Class: form puro) nao herda de
57: * frmcadastro, nao tem Grupo_Op nem botao Incluir/Alterar/Visualizar/Excluir
58: * - tem 2 CommandButton (Processa/Cancela) e 4 CheckBox de toggle. Nao
59: * existe BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
60: * a migrar, e inventa-los violaria o PILAR 1. Pelo mesmo motivo:
61: *
62: *   - BtnBuscarClick / AjustarBotoesPorModo / HabilitarCampos / LimparCampos:
63: *     nao ha modo LISTA/INCLUIR/ALTERAR/VISUALIZAR nesta tela. O unico estado
64: *     que muda eh "lote rodando x lote parado", e ele ja tem metodo proprio -
65: *     HabilitarControlesProcessamento(.T./.F.), que eh a transcricao literal
66: *     do par de blocos "With Thisform / .Conta.Enabled = ..." do
67: *     Processa.Click. O unico botao com habilitacao condicional eh o
68: *     Processar, tratado por AtualizarEstadoProcessar.
69: *   - CarregarLista: o SCX nao tem UM grid (layout.json: zero objeto de
70: *     BaseClass grid; 59 objetos, todos label/textbox/checkbox/commandbutton/
71: *     container/shape). Nao ha lista para carregar. O AddCursor do Init legado
72: *     ('SigOpClU','CidChaves','CrSigOpClU') NAO eh grade: eh a tabela de apoio
73: *     em que a frente "Ultima Compra" grava os valores recalculados antes de
74: *     aplica-los, e vive no BO (GravarApoioUltimaCompra/AplicarTopoSigOpClU).
75: *   - BOParaForm: o sentido dele eh trazer um REGISTRO do BO de volta para a
76: *     ficha. Aqui nao ha registro em edicao - os campos sao FILTROS do lote, o
77: *     trafego eh so num sentido (FormParaBO, chamado no inicio do Processar) e
78: *     o legado nunca escreve de volta nesses campos. O unico retorno do BO
79: *     para a tela durante o processamento eh o contador de registros, que ja
80: *     chega por AtualizarContadorRegistros (chamado pelo BO, por isso PUBLIC).
81: *   - BtnSalvarClick: nao existe botao de gravar no SCX. A gravacao eh o
82: *     resultado do lote e acontece dentro do BO.
83: *
84: * Load legado ("=fConfigGeral()") NAO PORTADO, pelo mesmo motivo ja registrado
85: * em FormSigMvExp.prg (task570): fConfigGeral era rotina de inicializacao
86: * GLOBAL da aplicacao legado, nao comportamento desta tela. O que ela
87: * preparava e que esta tela realmente usa sao os parametros de SigCdPam, hoje
88: * carregados no SigPrCccBO.Init (gruporecs/grupopags/contarecs/contapags/
89: * moecentral), equivalente ao CursorQuery('SigCdPam','CrSigCdPam',...) que o
90: * Init legado fazia logo depois.
91: *==============================================================================

*-- Linhas 123 a 244:
123:     this_nLarguraOpCompra  = 0
124: 
125:     *==========================================================================
126:     PROCEDURE Init()
127:     *==========================================================================
128:         *-- FormBase.Init() ja chama THIS.InicializarForm() e ja corrige
129:         *-- SET DATE/CENTURY para DataSession=2 (regra 9.4) - nao duplicar aqui
130:         RETURN DODEFAULT()
131:     ENDPROC
132: 
133:     *==========================================================================
134:     PROTECTED PROCEDURE InicializarForm
135:     *==========================================================================
136:         LOCAL loc_lSucesso, loc_oErro
137:         loc_lSucesso = .F.
138: 
139:         TRY
140:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrCccBO")
141:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
142:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrCcc.", "Erro")
143:             ELSE
144:                 *-- Montar interface visual (estrutura base)
145:                 THIS.ConfigurarPageFrame()
146:                 THIS.ConfigurarCabecalho()
147:                 THIS.ConfigurarContainersOperacao()
148:                 THIS.ConfigurarCamposOpConta()
149:                 THIS.ConfigurarCamposOpEstoque()
150:                 THIS.ConfigurarCamposOpCusto()
151:                 THIS.ConfigurarCamposOpCompra()
152: 
153:                 *-- Capturar largura-alvo de cada container (para a animacao
154:                 *-- de expandir/recolher nos checkboxes de toggle)
155:                 THIS.this_nLarguraOpConta   = THIS.cnt_4c_OpConta.Width
156:                 THIS.this_nLarguraOpEstoque = THIS.cnt_4c_OpEstoque.Width
157:                 THIS.this_nLarguraOpCusto   = THIS.cnt_4c_OpCusto.Width
158:                 THIS.this_nLarguraOpCompra  = THIS.cnt_4c_OpCompra.Width
159: 
160:                 THIS.ConfigurarBotoesAcao()
161:                 THIS.ConfigurarCheckboxesToggle()
162:                 THIS.ConfigurarControlesStatus()
163: 
164:                 *-- Propagar titulo para os labels do cabecalho
165:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
166:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
167: 
168:                 THIS.TornarControlesVisiveis(THIS)
169: 
170:                 *-- LblEnd so aparece ao final do Processar (Fase de bindings) -
171:                 *-- TornarControlesVisiveis nao pode deixa-lo visivel agora
172:                 THIS.lbl_4c_LblEnd.Visible = .F.
173: 
174:                 *-- Estado inicial do When do Get_Descs nos tres containers que
175:                 *-- tem Produto+Descricao (a tela abre com os dois em branco,
176:                 *-- logo a Descricao comeca digitavel - igual ao legado)
177:                 THIS.AplicarWhenDescricao(THIS.cnt_4c_OpEstoque)
178:                 THIS.AplicarWhenDescricao(THIS.cnt_4c_OpCusto)
179:                 THIS.AplicarWhenDescricao(THIS.cnt_4c_OpCompra)
180: 
181:                 loc_lSucesso = .T.
182:             ENDIF
183:         CATCH TO loc_oErro
184:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
185:                 " PROC=" + loc_oErro.Procedure, "Erro FormSigPrCcc.InicializarForm")
186:         ENDTRY
187: 
188:         RETURN loc_lSucesso
189:     ENDPROC
190: 
191:     *==========================================================================
192:     * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture
193:     * (layout flat identico ao legado - cntSombra + containers flutuantes
194:     * direto no Form, sem Page1/Page2 do padrao CRUD)
195:     *==========================================================================
196:     PROTECTED PROCEDURE ConfigurarPageFrame
197:         THIS.Picture      = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
198:         THIS.ClipControls = .F.
199:     ENDPROC
200: 
201:     *==========================================================================
202:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
203:     *==========================================================================
204:     PROTECTED PROCEDURE ConfigurarCabecalho
205:         THIS.AddObject("cnt_4c_Sombra", "Container")
206:         WITH THIS.cnt_4c_Sombra
207:             .Top         = 0
208:             .Left        = 0
209:             .Width       = THIS.Width
210:             .Height      = 80
211:             .BackColor   = RGB(100, 100, 100)
212:             .BorderWidth = 0
213:             .BackStyle   = 1
214: 
215:             .AddObject("lbl_4c_LblSombra", "Label")
216:             WITH .lbl_4c_LblSombra
217:                 .AutoSize  = .F.
218:                 .BackStyle = 0
219:                 .Caption   = ""
220:                 .FontBold  = .T.
221:                 .FontName  = "Tahoma"
222:                 .FontSize  = 18
223:                 .ForeColor = RGB(0, 0, 0)
224:                 .Height    = 40
225:                 .Left      = 10
226:                 .Top       = 18
227:                 .Width     = THIS.Width
228:                 .WordWrap  = .T.
229:                 .Alignment = 0
230:                 .Visible   = .T.
231:             ENDWITH
232: 
233:             .AddObject("lbl_4c_LblTitulo", "Label")
234:             WITH .lbl_4c_LblTitulo
235:                 .AutoSize    = .F.
236:                 .BackStyle   = 0
237:                 .Caption     = ""
238:                 .FontBold    = .T.
239:                 .FontName    = "Tahoma"
240:                 .FontSize    = 18
241:                 .ForeColor   = RGB(255, 255, 255)
242:                 .Height      = 46
243:                 .Left        = 10
244:                 .Top         = 17

*-- Linhas 259 a 372:
259:     * padrao - exatamente como no legado (BackStyle=0, BorderWidth=2,
260:     * SpecialEffect=2, BorderColor cinza, Visible=.F.). Campos internos
261:     * (Empresa/Grupo/Produto/Descricao/Data) entram nas Fases 5/6.
262:     *==========================================================================
263:     PROTECTED PROCEDURE ConfigurarContainersOperacao
264:         THIS.AddObject("cnt_4c_OpConta", "Container")
265:         WITH THIS.cnt_4c_OpConta
266:             .Top           = 114
267:             .Left          = 139
268:             .Width         = 536
269:             .Height        = 81
270:             .BackStyle     = 0
271:             .BorderWidth   = 2
272:             .SpecialEffect = 2
273:             .BackColor     = RGB(192, 192, 255)
274:             .BorderColor   = RGB(90, 90, 90)
275:             .Enabled       = .F.
276:             .Visible       = .F.
277:         ENDWITH
278: 
279:         THIS.AddObject("cnt_4c_OpEstoque", "Container")
280:         WITH THIS.cnt_4c_OpEstoque
281:             .Top           = 200
282:             .Left          = 139
283:             .Width         = 536
284:             .Height        = 143
285:             .BackStyle     = 0
286:             .BorderWidth   = 2
287:             .SpecialEffect = 2
288:             .BackColor     = RGB(192, 192, 255)
289:             .BorderColor   = RGB(90, 90, 90)
290:             .Enabled       = .F.
291:             .Visible       = .F.
292:         ENDWITH
293: 
294:         THIS.AddObject("cnt_4c_OpCusto", "Container")
295:         WITH THIS.cnt_4c_OpCusto
296:             .Top           = 349
297:             .Left          = 139
298:             .Width         = 536
299:             .Height        = 92
300:             .BackStyle     = 0
301:             .BorderWidth   = 2
302:             .SpecialEffect = 2
303:             .BackColor     = RGB(192, 192, 255)
304:             .BorderColor   = RGB(90, 90, 90)
305:             .Enabled       = .F.
306:             .Visible       = .F.
307:         ENDWITH
308: 
309:         THIS.AddObject("cnt_4c_OpCompra", "Container")
310:         WITH THIS.cnt_4c_OpCompra
311:             .Top           = 447
312:             .Left          = 139
313:             .Width         = 536
314:             .Height        = 91
315:             .BackStyle     = 0
316:             .BorderWidth   = 2
317:             .SpecialEffect = 2
318:             .BackColor     = RGB(192, 192, 255)
319:             .BorderColor   = RGB(90, 90, 90)
320:             .Enabled       = .F.
321:             .Visible       = .F.
322:         ENDWITH
323:     ENDPROC
324: 
325:     *==========================================================================
326:     * ConfigurarCamposOpConta - Campos internos do container Conta Corrente
327:     * (Fase 5/8 - primeira metade dos containers: OpConta + OpEstoque).
328:     * Coordenadas RELATIVAS ao container (top/left do layout.json), copiadas
329:     * do SCX legado. Ainda sem Valid/lookup (fAcessoContas/fAcessoContab/
330:     * fwBuscaExt) - entram na fase de eventos.
331:     *==========================================================================
332:     PROTECTED PROCEDURE ConfigurarCamposOpConta
333:         WITH THIS.cnt_4c_OpConta
334: 
335:             .AddObject("lbl_4c_Label2", "Label")
336:             WITH .lbl_4c_Label2
337:                 .Top       = 2
338:                 .Left      = 171
339:                 .Width     = 250
340:                 .Height    = 15
341:                 .AutoSize  = .F.
342:                 .BackStyle = 0
343:                 .Alignment = 0
344:                 .FontBold  = .T.
345:                 .FontName  = "Tahoma"
346:                 .FontSize  = 8
347:                 .ForeColor = RGB(90, 90, 90)
348:                 .Caption   = "Op" + CHR(231) + CHR(245) + "es de Conta Corrente"
349:                 .Visible   = .T.
350:             ENDWITH
351: 
352:             .AddObject("lbl_4c_Label15", "Label")
353:             WITH .lbl_4c_Label15
354:                 .Top       = 23
355:                 .Left      = 16
356:                 .Width     = 57
357:                 .Height    = 15
358:                 .AutoSize  = .F.
359:                 .BackStyle = 0
360:                 .Alignment = 0
361:                 .FontName  = "Tahoma"
362:                 .FontSize  = 8
363:                 .ForeColor = RGB(90, 90, 90)
364:                 .Caption   = "Empresa :"
365:                 .Visible   = .T.
366:             ENDWITH
367: 
368:             .AddObject("txt_4c_Empresa", "TextBox")
369:             WITH .txt_4c_Empresa
370:                 .Top       = 20
371:                 .Left      = 75
372:                 .Width     = 31

*-- Linhas 495 a 560:
495: 
496:             *-- Lookups (Fase 6): Empresa (SigCdEmp), Grupo (SigCdGcr),
497:             *-- Conta (SigCdCli filtrado por Grupo) e Moeda (SigCdMoe)
498:             BINDEVENT(.txt_4c_Empresa, "KeyPress", THIS, "EmpresaContaKeyPress")
499:             BINDEVENT(.txt_4c_Empresa, "DblClick", THIS, "EmpresaContaDblClick")
500:             BINDEVENT(.txt_4c_TxtGrupos, "KeyPress", THIS, "GrupoContaKeyPress")
501:             BINDEVENT(.txt_4c_TxtGrupos, "DblClick", THIS, "GrupoContaDblClick")
502:             BINDEVENT(.txt_4c_TxtContas, "KeyPress", THIS, "ContaContaKeyPress")
503:             BINDEVENT(.txt_4c_TxtContas, "DblClick", THIS, "ContaContaDblClick")
504:             BINDEVENT(.txt_4c_TxtMoedas, "KeyPress", THIS, "MoedaContaKeyPress")
505:             BINDEVENT(.txt_4c_TxtMoedas, "DblClick", THIS, "MoedaContaDblClick")
506: 
507:         ENDWITH
508:     ENDPROC
509: 
510:     *==========================================================================
511:     * ConfigurarCamposOpEstoque - Campos internos do container Estoque
512:     * (Fase 5/8). Coordenadas RELATIVAS ao container, copiadas do SCX legado.
513:     * NOTA: o legado tem DOIS labels genericos "Label1" nesta pagina (Say1 =
514:     * "Estoque :" e Label1 = "Produto :") que colidiriam se nomeados pelo
515:     * mesmo padrao automatico (mapeamento.json os gerou ambos como
516:     * lbl_4c_Label1) - renomeados por CONTEUDO para lbl_4c_Estoque e
517:     * lbl_4c_Produto (regra CLAUDE.md "nomear pela ACAO/conteudo, nao pelo
518:     * nome generico do legado").
519:     *==========================================================================
520:     PROTECTED PROCEDURE ConfigurarCamposOpEstoque
521:         WITH THIS.cnt_4c_OpEstoque
522: 
523:             .AddObject("lbl_4c_Label2", "Label")
524:             WITH .lbl_4c_Label2
525:                 .Top       = 2
526:                 .Left      = 182
527:                 .Width     = 200
528:                 .Height    = 15
529:                 .AutoSize  = .F.
530:                 .BackStyle = 0
531:                 .Alignment = 0
532:                 .FontBold  = .T.
533:                 .FontName  = "Tahoma"
534:                 .FontSize  = 8
535:                 .ForeColor = RGB(90, 90, 90)
536:                 .Caption   = "Op" + CHR(231) + CHR(245) + "es de Estoque"
537:                 .Visible   = .T.
538:             ENDWITH
539: 
540:             .AddObject("lbl_4c_Label15", "Label")
541:             WITH .lbl_4c_Label15
542:                 .Top       = 15
543:                 .Left      = 31
544:                 .Width     = 57
545:                 .Height    = 15
546:                 .AutoSize  = .F.
547:                 .BackStyle = 0
548:                 .Alignment = 0
549:                 .FontName  = "Tahoma"
550:                 .FontSize  = 8
551:                 .ForeColor = RGB(90, 90, 90)
552:                 .Caption   = "Empresa :"
553:                 .Visible   = .T.
554:             ENDWITH
555: 
556:             .AddObject("txt_4c_Empresa", "TextBox")
557:             WITH .txt_4c_Empresa
558:                 .Top       = 12
559:                 .Left      = 90
560:                 .Width     = 31

*-- Linhas 697 a 763:
697:             *-- Lookups (Fase 6): Empresa (SigCdEmp), Grupo (SigCdGcr),
698:             *-- Estoque=Conta (SigCdCli filtrado por Grupo) e Produto/Descricao
699:             *-- (SigCdPro, bidirecional)
700:             BINDEVENT(.txt_4c_Empresa, "KeyPress", THIS, "EmpresaEstoqueKeyPress")
701:             BINDEVENT(.txt_4c_Empresa, "DblClick", THIS, "EmpresaEstoqueDblClick")
702:             BINDEVENT(.txt_4c_TxtGrupos, "KeyPress", THIS, "GrupoEstoqueKeyPress")
703:             BINDEVENT(.txt_4c_TxtGrupos, "DblClick", THIS, "GrupoEstoqueDblClick")
704:             BINDEVENT(.txt_4c_Estoque, "KeyPress", THIS, "EstoqueKeyPress")
705:             BINDEVENT(.txt_4c_Estoque, "DblClick", THIS, "EstoqueDblClick")
706:             BINDEVENT(.txt_4c_Produto, "KeyPress", THIS, "ProdutoEstoqueKeyPress")
707:             BINDEVENT(.txt_4c_Produto, "DblClick", THIS, "ProdutoEstoqueDblClick")
708:             *-- InteractiveChange: reavalia a cada tecla o When do Get_Descs
709:             *-- legado (Descricao so digitavel com o Produto em branco)
710:             BINDEVENT(.txt_4c_Produto, "InteractiveChange", THIS, "ProdutoEstoqueInteractiveChange")
711:             BINDEVENT(.txt_4c_Descricao, "KeyPress", THIS, "DescricaoEstoqueKeyPress")
712:             BINDEVENT(.txt_4c_Descricao, "DblClick", THIS, "DescricaoEstoqueDblClick")
713: 
714:         ENDWITH
715:     ENDPROC
716: 
717:     *==========================================================================
718:     * ConfigurarCamposOpCusto - Campos internos do container Custo de Produto
719:     * (Fase 6/8). Coordenadas RELATIVAS ao container, copiadas do SCX legado
720:     * (layout.json: cnt_4c_OpCusto). Mesmo padrao de OpEstoque, sem o campo
721:     * Estoque (nao existe nesta frente de recalculo).
722:     *==========================================================================
723:     PROTECTED PROCEDURE ConfigurarCamposOpCusto
724:         WITH THIS.cnt_4c_OpCusto
725: 
726:             .AddObject("lbl_4c_Label2", "Label")
727:             WITH .lbl_4c_Label2
728:                 .Top       = 2
729:                 .Left      = 155
730:                 .Width     = 250
731:                 .Height    = 15
732:                 .AutoSize  = .F.
733:                 .BackStyle = 0
734:                 .Alignment = 0
735:                 .FontBold  = .T.
736:                 .FontName  = "Tahoma"
737:                 .FontSize  = 8
738:                 .ForeColor = RGB(90, 90, 90)
739:                 .Caption   = "Op" + CHR(231) + CHR(245) + "es de Custo de Produto"
740:                 .Visible   = .T.
741:             ENDWITH
742: 
743:             .AddObject("lbl_4c_Label15", "Label")
744:             WITH .lbl_4c_Label15
745:                 .Top       = 14
746:                 .Left      = 31
747:                 .Width     = 57
748:                 .Height    = 15
749:                 .AutoSize  = .F.
750:                 .BackStyle = 0
751:                 .Alignment = 0
752:                 .FontName  = "Tahoma"
753:                 .FontSize  = 8
754:                 .ForeColor = RGB(90, 90, 90)
755:                 .Caption   = "Empresa :"
756:                 .Visible   = .T.
757:             ENDWITH
758: 
759:             .AddObject("txt_4c_Empresa", "TextBox")
760:             WITH .txt_4c_Empresa
761:                 .Top       = 11
762:                 .Left      = 90
763:                 .Width     = 31

*-- Linhas 841 a 903:
841: 
842:             *-- Lookups (Fase 6): Empresa (SigCdEmp) e Produto/Descricao
843:             *-- (SigCdPro, bidirecional)
844:             BINDEVENT(.txt_4c_Empresa, "KeyPress", THIS, "EmpresaCustoKeyPress")
845:             BINDEVENT(.txt_4c_Empresa, "DblClick", THIS, "EmpresaCustoDblClick")
846:             BINDEVENT(.txt_4c_Produto, "KeyPress", THIS, "ProdutoCustoKeyPress")
847:             BINDEVENT(.txt_4c_Produto, "DblClick", THIS, "ProdutoCustoDblClick")
848:             *-- InteractiveChange: reavalia a cada tecla o When do Get_Descs
849:             *-- legado (Descricao so digitavel com o Produto em branco)
850:             BINDEVENT(.txt_4c_Produto, "InteractiveChange", THIS, "ProdutoCustoInteractiveChange")
851:             BINDEVENT(.txt_4c_Descricao, "KeyPress", THIS, "DescricaoCustoKeyPress")
852:             BINDEVENT(.txt_4c_Descricao, "DblClick", THIS, "DescricaoCustoDblClick")
853: 
854:         ENDWITH
855:     ENDPROC
856: 
857:     *==========================================================================
858:     * ConfigurarCamposOpCompra - Campos internos do container Ultima Compra
859:     * do Produto/Cliente (Fase 6/8). Coordenadas RELATIVAS ao container,
860:     * copiadas do SCX legado (layout.json: cnt_4c_OpCompra). Mesmo padrao de
861:     * OpCusto (Empresa + Produto/Descricao, sem campo Estoque).
862:     *==========================================================================
863:     PROTECTED PROCEDURE ConfigurarCamposOpCompra
864:         WITH THIS.cnt_4c_OpCompra
865: 
866:             .AddObject("lbl_4c_Label2", "Label")
867:             WITH .lbl_4c_Label2
868:                 .Top       = 2
869:                 .Left      = 140
870:                 .Width     = 300
871:                 .Height    = 15
872:                 .AutoSize  = .F.
873:                 .BackStyle = 0
874:                 .Alignment = 0
875:                 .FontBold  = .T.
876:                 .FontName  = "Tahoma"
877:                 .FontSize  = 8
878:                 .ForeColor = RGB(90, 90, 90)
879:                 .Caption   = "Op" + CHR(231) + CHR(245) + "es de " + CHR(218) + "ltima Compra do Produto/Cliente"
880:                 .Visible   = .T.
881:             ENDWITH
882: 
883:             .AddObject("lbl_4c_Label15", "Label")
884:             WITH .lbl_4c_Label15
885:                 .Top       = 14
886:                 .Left      = 31
887:                 .Width     = 57
888:                 .Height    = 15
889:                 .AutoSize  = .F.
890:                 .BackStyle = 0
891:                 .Alignment = 0
892:                 .FontName  = "Tahoma"
893:                 .FontSize  = 8
894:                 .ForeColor = RGB(90, 90, 90)
895:                 .Caption   = "Empresa :"
896:                 .Visible   = .T.
897:             ENDWITH
898: 
899:             .AddObject("txt_4c_Empresa", "TextBox")
900:             WITH .txt_4c_Empresa
901:                 .Top       = 10
902:                 .Left      = 90
903:                 .Width     = 31

*-- Linhas 981 a 1520:
981: 
982:             *-- Lookups (Fase 6): Empresa (SigCdEmp) e Produto/Descricao
983:             *-- (SigCdPro, bidirecional)
984:             BINDEVENT(.txt_4c_Empresa, "KeyPress", THIS, "EmpresaCompraKeyPress")
985:             BINDEVENT(.txt_4c_Empresa, "DblClick", THIS, "EmpresaCompraDblClick")
986:             BINDEVENT(.txt_4c_Produto, "KeyPress", THIS, "ProdutoCompraKeyPress")
987:             BINDEVENT(.txt_4c_Produto, "DblClick", THIS, "ProdutoCompraDblClick")
988:             *-- InteractiveChange: reavalia a cada tecla o When do Get_Descs
989:             *-- legado (Descricao so digitavel com o Produto em branco)
990:             BINDEVENT(.txt_4c_Produto, "InteractiveChange", THIS, "ProdutoCompraInteractiveChange")
991:             BINDEVENT(.txt_4c_Descricao, "KeyPress", THIS, "DescricaoCompraKeyPress")
992:             BINDEVENT(.txt_4c_Descricao, "DblClick", THIS, "DescricaoCompraDblClick")
993: 
994:         ENDWITH
995:     ENDPROC
996: 
997:     *==========================================================================
998:     * MontarFiltroGrupo - monta o WHERE extra "Grupos = <valor>" usado nos
999:     * lookups de Conta/Estoque (SigCdCli), espelhando o filtro por grupo que
1000:     * o legado aplicava via fAcessoContas(Usuar, txtGrupos.Value, ...).
1001:     * Retorna "" quando o Grupo ainda nao foi preenchido (lista sem filtro).
1002:     *==========================================================================
1003:     PROTECTED PROCEDURE MontarFiltroGrupo(par_oTxtGrupo)
1004:         LOCAL loc_cGrupo
1005:         loc_cGrupo = ALLTRIM(par_oTxtGrupo.Value)
1006:         IF EMPTY(loc_cGrupo)
1007:             RETURN ""
1008:         ENDIF
1009:         RETURN "Grupos = " + EscaparSQL(loc_cGrupo)
1010:     ENDPROC
1011: 
1012:     *==========================================================================
1013:     * AbrirLookupSimples - abre o picker canonico (FormBuscaAuxiliar via
1014:     * AbrirLookupCanonico, herdado de FormBase) SEM checagem previa - usado
1015:     * por F4 e DblClick, que sempre abrem a busca (regra CLAUDE.md: "F4
1016:     * sempre abre lookup direto").
1017:     *==========================================================================
1018:     PROTECTED PROCEDURE AbrirLookupSimples(par_oTxtCod, par_cTabela, par_cCampoCod, ;
1019:             par_cCampoDesc, par_cTitulo, par_cFiltroExtra)
1020:         THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
1021:             par_cTitulo, ALLTRIM(par_oTxtCod.Value), par_oTxtCod, .NULL., par_cFiltroExtra)
1022:     ENDPROC
1023: 
1024:     *==========================================================================
1025:     * ValidarLookupSimples - usado por Enter/Tab: tenta achar o codigo digitado
1026:     * por igualdade exata primeiro (equivalente ao Seek do legado); so abre o
1027:     * picker se nao encontrar. Campo vazio nao valida (segue o legado, que so
1028:     * dispara a busca com !Empty(This.Value)).
1029:     *==========================================================================
1030:     PROTECTED PROCEDURE ValidarLookupSimples(par_oTxtCod, par_cTabela, par_cCampoCod, ;
1031:             par_cCampoDesc, par_cTitulo, par_cFiltroExtra)
1032:         LOCAL loc_cValor, loc_nResult, loc_cCursor, loc_cSQL
1033:         loc_cValor  = ALLTRIM(par_oTxtCod.Value)
1034:         loc_cCursor = "cursor_4c_ChkLookup"
1035: 
1036:         IF EMPTY(loc_cValor)
1037:             RETURN
1038:         ENDIF
1039: 
1040:         IF USED(loc_cCursor)
1041:             USE IN SELECT(loc_cCursor)
1042:         ENDIF
1043:         loc_cSQL = "SELECT " + par_cCampoCod + " FROM " + par_cTabela + ;
1044:             " WHERE " + par_cCampoCod + " = " + EscaparSQL(loc_cValor) + ;
1045:             IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
1046:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
1047: 
1048:         IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1049:             USE IN SELECT(loc_cCursor)
1050:             RETURN
1051:         ENDIF
1052:         IF USED(loc_cCursor)
1053:             USE IN SELECT(loc_cCursor)
1054:         ENDIF
1055: 
1056:         THIS.AbrirLookupSimples(par_oTxtCod, par_cTabela, par_cCampoCod, ;
1057:             par_cCampoDesc, par_cTitulo, par_cFiltroExtra)
1058:     ENDPROC
1059: 
1060:     *==========================================================================
1061:     * AbrirLookupProduto / ValidarLookupProduto - lookup bidirecional de
1062:     * Produto (SigCdPro.CPros/DPros), usado tanto pelo campo Codigo quanto
1063:     * pelo campo Descricao (igual ao legado: Get_Produto.Valid e
1064:     * Get_Descs.Valid abrem a MESMA busca e preenchem os DOIS campos).
1065:     *==========================================================================
1066:     PROTECTED PROCEDURE AbrirLookupProduto(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc)
1067:         THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", ;
1068:             "Sele" + CHR(231) + CHR(227) + "o de Produto", ;
1069:             ALLTRIM(par_oTxtDigitado.Value), par_oTxtCod, par_oTxtDesc)
1070: 
1071:         *-- O picker preenche Produto E Descricao de uma vez: reavaliar o When
1072:         *-- do Get_Descs legado (so digitavel com o Produto em branco)
1073:         THIS.AplicarWhenDescricaoPorCampo(par_oTxtCod)
1074:     ENDPROC
1075: 
1076:     PROTECTED PROCEDURE ValidarLookupProduto(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc, par_cCampoDigitado)
1077:         LOCAL loc_cValor, loc_nResult, loc_cCursor, loc_cSQL
1078:         loc_cValor  = ALLTRIM(par_oTxtDigitado.Value)
1079:         loc_cCursor = "cursor_4c_ChkProduto"
1080: 
1081:         IF EMPTY(loc_cValor)
1082:             RETURN
1083:         ENDIF
1084: 
1085:         IF USED(loc_cCursor)
1086:             USE IN SELECT(loc_cCursor)
1087:         ENDIF
1088:         loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE " + ;
1089:             par_cCampoDigitado + " = " + EscaparSQL(loc_cValor)
1090:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
1091: 
1092:         IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1093:             par_oTxtCod.Value  = ALLTRIM(cursor_4c_ChkProduto.CPros)
1094:             par_oTxtDesc.Value = ALLTRIM(cursor_4c_ChkProduto.DPros)
1095:             USE IN SELECT(loc_cCursor)
1096:             *-- Achou pelo valor exato: Produto acabou de ficar preenchido,
1097:             *-- entao a Descricao deixa de aceitar digitacao (When legado)
1098:             THIS.AplicarWhenDescricaoPorCampo(par_oTxtCod)
1099:             RETURN
1100:         ENDIF
1101:         IF USED(loc_cCursor)
1102:             USE IN SELECT(loc_cCursor)
1103:         ENDIF
1104: 
1105:         THIS.AbrirLookupProduto(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc)
1106:     ENDPROC
1107: 
1108:     *==========================================================================
1109:     * AplicarWhenDescricao - transcreve o "PROCEDURE When / Return(Empty(
1110:     * This.Parent.Get_Produto.Value))" que os TRES Get_Descs do legado tem
1111:     * (OpEstoque, OpCusto e OpCompra): a Descricao so aceita digitacao
1112:     * enquanto o Produto esta em branco - assim que o codigo do produto eh
1113:     * preenchido (digitado ou trazido pelo picker), a Descricao vira apenas
1114:     * exibicao do que o lookup devolveu, e voltar a digitar nela so eh
1115:     * possivel limpando o Produto.
1116:     *
1117:     * Nao da para migrar o When por BINDEVENT (o VFP descarta o retorno do
1118:     * delegate - mesma limitacao ja registrada para o Valid de TextBox), entao
1119:     * o efeito eh reproduzido por ReadOnly + TabStop, que eh o que o When
1120:     * fazia na pratica: o campo continua visivel e com o texto legivel, mas
1121:     * nao entra na tabulacao nem aceita digitacao. NUNCA .Enabled = .F.: o
1122:     * legado nao acinzenta a Descricao.
1123:     *
1124:     * Chamado de (a) InicializarForm, para o estado inicial dos tres
1125:     * containers, (b) dos dois helpers de lookup de produto, que preenchem os
1126:     * dois campos de uma vez, e (c) do InteractiveChange do Produto, que eh
1127:     * onde o usuario limpa/digita o codigo tecla a tecla.
1128:     *==========================================================================
1129:     PROTECTED PROCEDURE AplicarWhenDescricao(par_oContainer)
1130:         LOCAL loc_lPodeDigitar
1131: 
1132:         IF VARTYPE(par_oContainer) != "O"
1133:             RETURN
1134:         ENDIF
1135:         IF !PEMSTATUS(par_oContainer, "txt_4c_Produto", 5) OR ;
1136:                 !PEMSTATUS(par_oContainer, "txt_4c_Descricao", 5)
1137:             RETURN
1138:         ENDIF
1139: 
1140:         loc_lPodeDigitar = EMPTY(par_oContainer.txt_4c_Produto.Value)
1141: 
1142:         par_oContainer.txt_4c_Descricao.ReadOnly = !loc_lPodeDigitar
1143:         par_oContainer.txt_4c_Descricao.TabStop  = loc_lPodeDigitar
1144:     ENDPROC
1145: 
1146:     *==========================================================================
1147:     * AplicarWhenDescricaoPorCampo - atalho usado pelos helpers de lookup, que
1148:     * recebem os TextBox e nao o container. Produto e Descricao sao sempre
1149:     * irmaos dentro do mesmo cnt_4c_Op*, entao o pai de qualquer um deles eh o
1150:     * container que a regra acima precisa.
1151:     *==========================================================================
1152:     PROTECTED PROCEDURE AplicarWhenDescricaoPorCampo(par_oTxtCod)
1153:         IF VARTYPE(par_oTxtCod) = "O" AND VARTYPE(par_oTxtCod.Parent) = "O"
1154:             THIS.AplicarWhenDescricao(par_oTxtCod.Parent)
1155:         ENDIF
1156:     ENDPROC
1157: 
1158:     *==========================================================================
1159:     * InteractiveChange do Produto nos tres containers que tem Descricao -
1160:     * reavalia o When a cada tecla digitada no codigo do produto (inclusive
1161:     * quando o usuario APAGA o codigo, que eh o caminho de volta para poder
1162:     * digitar na Descricao). PUBLIC: exigido por BINDEVENT (regra #3).
1163:     *==========================================================================
1164:     PROCEDURE ProdutoEstoqueInteractiveChange()
1165:         THIS.AplicarWhenDescricao(THIS.cnt_4c_OpEstoque)
1166:     ENDPROC
1167: 
1168:     PROCEDURE ProdutoCustoInteractiveChange()
1169:         THIS.AplicarWhenDescricao(THIS.cnt_4c_OpCusto)
1170:     ENDPROC
1171: 
1172:     PROCEDURE ProdutoCompraInteractiveChange()
1173:         THIS.AplicarWhenDescricao(THIS.cnt_4c_OpCompra)
1174:     ENDPROC
1175: 
1176:     *==========================================================================
1177:     * Handlers de lookup - OpConta (Empresa/SigCdEmp, Grupo/SigCdGcr,
1178:     * Conta/SigCdCli filtrado por Grupo, Moeda/SigCdMoe). PUBLIC - exigido
1179:     * por BINDEVENT (regra CLAUDE.md #3).
1180:     *==========================================================================
1181:     PROCEDURE EmpresaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1182:         LOCAL loc_oTxt
1183:         loc_oTxt = THIS.cnt_4c_OpConta.txt_4c_Empresa
1184:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1185:             THIS.AbrirLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
1186:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
1187:         ELSE
1188:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1189:                 THIS.ValidarLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
1190:                     "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
1191:             ENDIF
1192:         ENDIF
1193:     ENDPROC
1194: 
1195:     PROCEDURE EmpresaContaDblClick()
1196:         THIS.AbrirLookupSimples(THIS.cnt_4c_OpConta.txt_4c_Empresa, "SigCdEmp", "Cemps", "Razas", ;
1197:             "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
1198:     ENDPROC
1199: 
1200:     PROCEDURE GrupoContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1201:         LOCAL loc_oTxt
1202:         loc_oTxt = THIS.cnt_4c_OpConta.txt_4c_TxtGrupos
1203:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1204:             THIS.AbrirLookupSimples(loc_oTxt, "SigCdGcr", "Codigos", "Descrs", ;
1205:                 "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
1206:         ELSE
1207:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1208:                 THIS.ValidarLookupSimples(loc_oTxt, "SigCdGcr", "Codigos", "Descrs", ;
1209:                     "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
1210:             ENDIF
1211:         ENDIF
1212:     ENDPROC
1213: 
1214:     PROCEDURE GrupoContaDblClick()
1215:         THIS.AbrirLookupSimples(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos, "SigCdGcr", "Codigos", "Descrs", ;
1216:             "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
1217:     ENDPROC
1218: 
1219:     PROCEDURE ContaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1220:         LOCAL loc_oTxt, loc_cFiltro
1221:         loc_oTxt    = THIS.cnt_4c_OpConta.txt_4c_TxtContas
1222:         loc_cFiltro = THIS.MontarFiltroGrupo(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos)
1223:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1224:             THIS.AbrirLookupSimples(loc_oTxt, "SigCdCli", "IClis", "RClis", ;
1225:                 "Sele" + CHR(231) + CHR(227) + "o de Conta", loc_cFiltro)
1226:         ELSE
1227:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1228:                 THIS.ValidarLookupSimples(loc_oTxt, "SigCdCli", "IClis", "RClis", ;
1229:                     "Sele" + CHR(231) + CHR(227) + "o de Conta", loc_cFiltro)
1230:             ENDIF
1231:         ENDIF
1232:     ENDPROC
1233: 
1234:     PROCEDURE ContaContaDblClick()
1235:         LOCAL loc_cFiltro
1236:         loc_cFiltro = THIS.MontarFiltroGrupo(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos)
1237:         THIS.AbrirLookupSimples(THIS.cnt_4c_OpConta.txt_4c_TxtContas, "SigCdCli", "IClis", "RClis", ;
1238:             "Sele" + CHR(231) + CHR(227) + "o de Conta", loc_cFiltro)
1239:     ENDPROC
1240: 
1241:     PROCEDURE MoedaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1242:         LOCAL loc_oTxt
1243:         loc_oTxt = THIS.cnt_4c_OpConta.txt_4c_TxtMoedas
1244:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1245:             THIS.AbrirLookupSimples(loc_oTxt, "SigCdMoe", "Cmoes", "Dmoes", ;
1246:                 "Sele" + CHR(231) + CHR(227) + "o de Moeda", "")
1247:         ELSE
1248:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1249:                 THIS.ValidarLookupSimples(loc_oTxt, "SigCdMoe", "Cmoes", "Dmoes", ;
1250:                     "Sele" + CHR(231) + CHR(227) + "o de Moeda", "")
1251:             ENDIF
1252:         ENDIF
1253:     ENDPROC
1254: 
1255:     PROCEDURE MoedaContaDblClick()
1256:         THIS.AbrirLookupSimples(THIS.cnt_4c_OpConta.txt_4c_TxtMoedas, "SigCdMoe", "Cmoes", "Dmoes", ;
1257:             "Sele" + CHR(231) + CHR(227) + "o de Moeda", "")
1258:     ENDPROC
1259: 
1260:     *==========================================================================
1261:     * Handlers de lookup - OpEstoque (Empresa/SigCdEmp, Grupo/SigCdGcr,
1262:     * Estoque=Conta/SigCdCli filtrado por Grupo, Produto+Descricao/SigCdPro)
1263:     *==========================================================================
1264:     PROCEDURE EmpresaEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1265:         LOCAL loc_oTxt
1266:         loc_oTxt = THIS.cnt_4c_OpEstoque.txt_4c_Empresa
1267:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1268:             THIS.AbrirLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
1269:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
1270:         ELSE
1271:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1272:                 THIS.ValidarLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
1273:                     "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
1274:             ENDIF
1275:         ENDIF
1276:     ENDPROC
1277: 
1278:     PROCEDURE EmpresaEstoqueDblClick()
1279:         THIS.AbrirLookupSimples(THIS.cnt_4c_OpEstoque.txt_4c_Empresa, "SigCdEmp", "Cemps", "Razas", ;
1280:             "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
1281:     ENDPROC
1282: 
1283:     PROCEDURE GrupoEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1284:         LOCAL loc_oTxt
1285:         loc_oTxt = THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos
1286:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1287:             THIS.AbrirLookupSimples(loc_oTxt, "SigCdGcr", "Codigos", "Descrs", ;
1288:                 "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
1289:         ELSE
1290:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1291:                 THIS.ValidarLookupSimples(loc_oTxt, "SigCdGcr", "Codigos", "Descrs", ;
1292:                     "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
1293:             ENDIF
1294:         ENDIF
1295:     ENDPROC
1296: 
1297:     PROCEDURE GrupoEstoqueDblClick()
1298:         THIS.AbrirLookupSimples(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos, "SigCdGcr", "Codigos", "Descrs", ;
1299:             "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
1300:     ENDPROC
1301: 
1302:     PROCEDURE EstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1303:         LOCAL loc_oTxt, loc_cFiltro
1304:         loc_oTxt    = THIS.cnt_4c_OpEstoque.txt_4c_Estoque
1305:         loc_cFiltro = THIS.MontarFiltroGrupo(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos)
1306:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1307:             THIS.AbrirLookupSimples(loc_oTxt, "SigCdCli", "IClis", "RClis", ;
1308:                 "Sele" + CHR(231) + CHR(227) + "o de Conta", loc_cFiltro)
1309:         ELSE
1310:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1311:                 THIS.ValidarLookupSimples(loc_oTxt, "SigCdCli", "IClis", "RClis", ;
1312:                     "Sele" + CHR(231) + CHR(227) + "o de Conta", loc_cFiltro)
1313:             ENDIF
1314:         ENDIF
1315:     ENDPROC
1316: 
1317:     PROCEDURE EstoqueDblClick()
1318:         LOCAL loc_cFiltro
1319:         loc_cFiltro = THIS.MontarFiltroGrupo(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos)
1320:         THIS.AbrirLookupSimples(THIS.cnt_4c_OpEstoque.txt_4c_Estoque, "SigCdCli", "IClis", "RClis", ;
1321:             "Sele" + CHR(231) + CHR(227) + "o de Conta", loc_cFiltro)
1322:     ENDPROC
1323: 
1324:     PROCEDURE ProdutoEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1325:         LOCAL loc_oProduto, loc_oDescricao
1326:         loc_oProduto   = THIS.cnt_4c_OpEstoque.txt_4c_Produto
1327:         loc_oDescricao = THIS.cnt_4c_OpEstoque.txt_4c_Descricao
1328:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1329:             THIS.AbrirLookupProduto(loc_oProduto, loc_oProduto, loc_oDescricao)
1330:         ELSE
1331:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1332:                 THIS.ValidarLookupProduto(loc_oProduto, loc_oProduto, loc_oDescricao, "CPros")
1333:             ENDIF
1334:         ENDIF
1335:     ENDPROC
1336: 
1337:     PROCEDURE ProdutoEstoqueDblClick()
1338:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_Produto, ;
1339:             THIS.cnt_4c_OpEstoque.txt_4c_Produto, THIS.cnt_4c_OpEstoque.txt_4c_Descricao)
1340:     ENDPROC
1341: 
1342:     PROCEDURE DescricaoEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1343:         LOCAL loc_oProduto, loc_oDescricao
1344:         loc_oProduto   = THIS.cnt_4c_OpEstoque.txt_4c_Produto
1345:         loc_oDescricao = THIS.cnt_4c_OpEstoque.txt_4c_Descricao
1346:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1347:             THIS.AbrirLookupProduto(loc_oDescricao, loc_oProduto, loc_oDescricao)
1348:         ELSE
1349:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1350:                 THIS.ValidarLookupProduto(loc_oDescricao, loc_oProduto, loc_oDescricao, "DPros")
1351:             ENDIF
1352:         ENDIF
1353:     ENDPROC
1354: 
1355:     PROCEDURE DescricaoEstoqueDblClick()
1356:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_Descricao, ;
1357:             THIS.cnt_4c_OpEstoque.txt_4c_Produto, THIS.cnt_4c_OpEstoque.txt_4c_Descricao)
1358:     ENDPROC
1359: 
1360:     *==========================================================================
1361:     * Handlers de lookup - OpCusto (Empresa/SigCdEmp, Produto+Descricao/SigCdPro)
1362:     *==========================================================================
1363:     PROCEDURE EmpresaCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1364:         LOCAL loc_oTxt
1365:         loc_oTxt = THIS.cnt_4c_OpCusto.txt_4c_Empresa
1366:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1367:             THIS.AbrirLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
1368:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
1369:         ELSE
1370:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1371:                 THIS.ValidarLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
1372:                     "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
1373:             ENDIF
1374:         ENDIF
1375:     ENDPROC
1376: 
1377:     PROCEDURE EmpresaCustoDblClick()
1378:         THIS.AbrirLookupSimples(THIS.cnt_4c_OpCusto.txt_4c_Empresa, "SigCdEmp", "Cemps", "Razas", ;
1379:             "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
1380:     ENDPROC
1381: 
1382:     PROCEDURE ProdutoCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1383:         LOCAL loc_oProduto, loc_oDescricao
1384:         loc_oProduto   = THIS.cnt_4c_OpCusto.txt_4c_Produto
1385:         loc_oDescricao = THIS.cnt_4c_OpCusto.txt_4c_Descricao
1386:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1387:             THIS.AbrirLookupProduto(loc_oProduto, loc_oProduto, loc_oDescricao)
1388:         ELSE
1389:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1390:                 THIS.ValidarLookupProduto(loc_oProduto, loc_oProduto, loc_oDescricao, "CPros")
1391:             ENDIF
1392:         ENDIF
1393:     ENDPROC
1394: 
1395:     PROCEDURE ProdutoCustoDblClick()
1396:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_Produto, ;
1397:             THIS.cnt_4c_OpCusto.txt_4c_Produto, THIS.cnt_4c_OpCusto.txt_4c_Descricao)
1398:     ENDPROC
1399: 
1400:     PROCEDURE DescricaoCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1401:         LOCAL loc_oProduto, loc_oDescricao
1402:         loc_oProduto   = THIS.cnt_4c_OpCusto.txt_4c_Produto
1403:         loc_oDescricao = THIS.cnt_4c_OpCusto.txt_4c_Descricao
1404:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1405:             THIS.AbrirLookupProduto(loc_oDescricao, loc_oProduto, loc_oDescricao)
1406:         ELSE
1407:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1408:                 THIS.ValidarLookupProduto(loc_oDescricao, loc_oProduto, loc_oDescricao, "DPros")
1409:             ENDIF
1410:         ENDIF
1411:     ENDPROC
1412: 
1413:     PROCEDURE DescricaoCustoDblClick()
1414:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_Descricao, ;
1415:             THIS.cnt_4c_OpCusto.txt_4c_Produto, THIS.cnt_4c_OpCusto.txt_4c_Descricao)
1416:     ENDPROC
1417: 
1418:     *==========================================================================
1419:     * Handlers de lookup - OpCompra (Empresa/SigCdEmp, Produto+Descricao/SigCdPro)
1420:     *==========================================================================
1421:     PROCEDURE EmpresaCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1422:         LOCAL loc_oTxt
1423:         loc_oTxt = THIS.cnt_4c_OpCompra.txt_4c_Empresa
1424:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1425:             THIS.AbrirLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
1426:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
1427:         ELSE
1428:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1429:                 THIS.ValidarLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
1430:                     "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
1431:             ENDIF
1432:         ENDIF
1433:     ENDPROC
1434: 
1435:     PROCEDURE EmpresaCompraDblClick()
1436:         THIS.AbrirLookupSimples(THIS.cnt_4c_OpCompra.txt_4c_Empresa, "SigCdEmp", "Cemps", "Razas", ;
1437:             "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
1438:     ENDPROC
1439: 
1440:     PROCEDURE ProdutoCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1441:         LOCAL loc_oProduto, loc_oDescricao
1442:         loc_oProduto   = THIS.cnt_4c_OpCompra.txt_4c_Produto
1443:         loc_oDescricao = THIS.cnt_4c_OpCompra.txt_4c_Descricao
1444:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1445:             THIS.AbrirLookupProduto(loc_oProduto, loc_oProduto, loc_oDescricao)
1446:         ELSE
1447:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1448:                 THIS.ValidarLookupProduto(loc_oProduto, loc_oProduto, loc_oDescricao, "CPros")
1449:             ENDIF
1450:         ENDIF
1451:     ENDPROC
1452: 
1453:     PROCEDURE ProdutoCompraDblClick()
1454:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_Produto, ;
1455:             THIS.cnt_4c_OpCompra.txt_4c_Produto, THIS.cnt_4c_OpCompra.txt_4c_Descricao)
1456:     ENDPROC
1457: 
1458:     PROCEDURE DescricaoCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1459:         LOCAL loc_oProduto, loc_oDescricao
1460:         loc_oProduto   = THIS.cnt_4c_OpCompra.txt_4c_Produto
1461:         loc_oDescricao = THIS.cnt_4c_OpCompra.txt_4c_Descricao
1462:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1463:             THIS.AbrirLookupProduto(loc_oDescricao, loc_oProduto, loc_oDescricao)
1464:         ELSE
1465:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1466:                 THIS.ValidarLookupProduto(loc_oDescricao, loc_oProduto, loc_oDescricao, "DPros")
1467:             ENDIF
1468:         ENDIF
1469:     ENDPROC
1470: 
1471:     PROCEDURE DescricaoCompraDblClick()
1472:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_Descricao, ;
1473:             THIS.cnt_4c_OpCompra.txt_4c_Produto, THIS.cnt_4c_OpCompra.txt_4c_Descricao)
1474:     ENDPROC
1475: 
1476:     *==========================================================================
1477:     * ConfigurarBotoesAcao - Shape decorativo + botoes Processar/Encerrar
1478:     * (top-level, canto superior direito, identico ao legado)
1479:     *==========================================================================
1480:     PROTECTED PROCEDURE ConfigurarBotoesAcao
1481:         THIS.AddObject("shp_4c_Shape1", "Shape")
1482:         WITH THIS.shp_4c_Shape1
1483:             .Top         = 7
1484:             .Left        = 697
1485:             .Width       = 90
1486:             .Height      = 110
1487:             .BackStyle   = 0
1488:             .BorderStyle = 0
1489:             .BorderColor = RGB(136, 189, 188)
1490:             .Visible     = .T.
1491:         ENDWITH
1492: 
1493:         THIS.AddObject("cmd_4c_Processa", "CommandButton")
1494:         WITH THIS.cmd_4c_Processa
1495:             .Top             = 3
1496:             .Left            = 650
1497:             .Width           = 75
1498:             .Height          = 75
1499:             .FontBold        = .T.
1500:             .FontItalic      = .T.
1501:             .FontName        = "Comic Sans MS"
1502:             .FontSize        = 8
1503:             .Caption         = "Processar"
1504:             .Picture         = gc_4c_CaminhoFramework + "imagens\geral_processar_60.jpg"
1505:             .DisabledPicture = gc_4c_CaminhoFramework + "imagens\geral_processar_60.jpg"
1506:             .Enabled         = .F.
1507:             .ToolTipText     = "Processar"
1508:             .SpecialEffect   = 0
1509:             .ForeColor       = RGB(90, 90, 90)
1510:             .BackColor       = RGB(255, 255, 255)
1511:             .Themes          = .T.
1512:             .Visible         = .T.
1513:         ENDWITH
1514: 
1515:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
1516:         WITH THIS.cmd_4c_Cancela
1517:             .Top             = 3
1518:             .Left            = 725
1519:             .Width           = 75
1520:             .Height          = 75

*-- Linhas 1533 a 2054:
1533:             .Themes          = .T.
1534:             .Visible         = .T.
1535:         ENDWITH
1536:         BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "BtnProcessarClick")
1537:         BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
1538:     ENDPROC
1539: 
1540:     *==========================================================================
1541:     * ConfigurarCheckboxesToggle - os 4 checkboxes graficos que expandem/
1542:     * recolhem cada container flutuante (identico ao Valid do legado:
1543:     * anima o Width, alterna Visible/Enabled e liga o Processar quando
1544:     * algum dos 4 estiver marcado)
1545:     *==========================================================================
1546:     PROTECTED PROCEDURE ConfigurarCheckboxesToggle
1547:         THIS.AddObject("chk_4c_Conta", "CheckBox")
1548:         WITH THIS.chk_4c_Conta
1549:             .Top           = 3
1550:             .Left          = 350
1551:             .Width         = 75
1552:             .Height        = 75
1553:             .FontBold      = .T.
1554:             .FontItalic    = .T.
1555:             .FontName      = "Comic Sans MS"
1556:             .FontSize      = 8
1557:             .AutoSize      = .F.
1558:             .Picture       = gc_4c_CaminhoIcones + "Folder42.ico"
1559:             .DownPicture   = gc_4c_CaminhoIcones + "A_CASH1.BMP"
1560:             .Alignment     = 1
1561:             .BackStyle     = 0
1562:             .Caption       = "C.C."
1563:             .Value         = 0
1564:             .SpecialEffect = 0
1565:             .Style         = 1
1566:             .ToolTipText   = "Conta Corrente"
1567:             .ForeColor     = RGB(90, 90, 90)
1568:             .BackColor     = RGB(255, 255, 255)
1569:             .Themes        = .F.
1570:             .Visible       = .T.
1571:         ENDWITH
1572:         BINDEVENT(THIS.chk_4c_Conta, "Click", THIS, "ChkContaClick")
1573: 
1574:         THIS.AddObject("chk_4c_Estoque", "CheckBox")
1575:         WITH THIS.chk_4c_Estoque
1576:             .Top           = 3
1577:             .Left          = 425
1578:             .Width         = 75
1579:             .Height        = 75
1580:             .FontBold      = .T.
1581:             .FontItalic    = .T.
1582:             .FontName      = "Comic Sans MS"
1583:             .FontSize      = 8
1584:             .AutoSize      = .F.
1585:             .Picture       = gc_4c_CaminhoIcones + "Folder22.ico"
1586:             .DownPicture   = gc_4c_CaminhoIcones + "A_DIAMD1.BMP"
1587:             .Alignment     = 1
1588:             .BackStyle     = 0
1589:             .Caption       = "Estoque"
1590:             .Value         = 0
1591:             .SpecialEffect = 0
1592:             .Style         = 1
1593:             .ToolTipText   = ""
1594:             .ForeColor     = RGB(90, 90, 90)
1595:             .BackColor     = RGB(255, 255, 255)
1596:             .Themes        = .F.
1597:             .Visible       = .T.
1598:         ENDWITH
1599:         BINDEVENT(THIS.chk_4c_Estoque, "Click", THIS, "ChkEstoqueClick")
1600: 
1601:         THIS.AddObject("chk_4c_BtnCusto", "CheckBox")
1602:         WITH THIS.chk_4c_BtnCusto
1603:             .Top           = 3
1604:             .Left          = 500
1605:             .Width         = 75
1606:             .Height        = 75
1607:             .FontBold      = .T.
1608:             .FontItalic    = .T.
1609:             .FontName      = "Comic Sans MS"
1610:             .FontSize      = 8
1611:             .AutoSize      = .F.
1612:             .Picture       = gc_4c_CaminhoIcones + "Folder34.ico"
1613:             .DownPicture   = gc_4c_CaminhoIcones + "D_MISC2.BMP"
1614:             .Alignment     = 1
1615:             .BackStyle     = 0
1616:             .Caption       = "Custo"
1617:             .Value         = 0
1618:             .SpecialEffect = 0
1619:             .Style         = 1
1620:             .ToolTipText   = ""
1621:             .ForeColor     = RGB(90, 90, 90)
1622:             .BackColor     = RGB(255, 255, 255)
1623:             .Themes        = .F.
1624:             .Visible       = .T.
1625:         ENDWITH
1626:         BINDEVENT(THIS.chk_4c_BtnCusto, "Click", THIS, "ChkBtnCustoClick")
1627: 
1628:         THIS.AddObject("chk_4c_BtnCompra", "CheckBox")
1629:         WITH THIS.chk_4c_BtnCompra
1630:             .Top           = 3
1631:             .Left          = 575
1632:             .Width         = 75
1633:             .Height        = 75
1634:             .FontBold      = .T.
1635:             .FontItalic    = .T.
1636:             .FontName      = "Comic Sans MS"
1637:             .FontSize      = 8
1638:             .AutoSize      = .F.
1639:             .Picture       = gc_4c_CaminhoIcones + "Folder27.ico"
1640:             .DownPicture   = gc_4c_CaminhoIcones + "D_MISC2.BMP"
1641:             .Alignment     = 1
1642:             .BackStyle     = 0
1643:             .Caption       = CHR(218) + "lt. Compra"
1644:             .Value         = 0
1645:             .SpecialEffect = 0
1646:             .Style         = 1
1647:             .ToolTipText   = CHR(218) + "ltima Compra"
1648:             .ForeColor     = RGB(90, 90, 90)
1649:             .BackColor     = RGB(255, 255, 255)
1650:             .Themes        = .F.
1651:             .Visible       = .T.
1652:         ENDWITH
1653:         BINDEVENT(THIS.chk_4c_BtnCompra, "Click", THIS, "ChkBtnCompraClick")
1654:     ENDPROC
1655: 
1656:     *==========================================================================
1657:     * ConfigurarControlesStatus - label + contador de registros processados
1658:     * (Get_Registro do legado) e o aviso final de conclusao (LblEnd)
1659:     *==========================================================================
1660:     PROTECTED PROCEDURE ConfigurarControlesStatus
1661:         THIS.AddObject("lbl_4c_Label1", "Label")
1662:         WITH THIS.lbl_4c_Label1
1663:             .AutoSize   = .F.
1664:             .FontBold   = .T.
1665:             .FontItalic = .F.
1666:             .FontName   = "Tahoma"
1667:             .FontSize   = 8
1668:             .WordWrap   = .F.
1669:             .BackStyle  = 0
1670:             .Caption    = "Registros : "
1671:             .Height     = 15
1672:             .Left       = 171
1673:             .Top        = 547
1674:             .Width      = 65
1675:             .ForeColor  = RGB(90, 90, 90)
1676:             .Visible    = .T.
1677:         ENDWITH
1678: 
1679:         THIS.AddObject("txt_4c_Registro", "TextBox")
1680:         WITH THIS.txt_4c_Registro
1681:             .FontName      = "Tahoma"
1682:             .FontSize      = 8
1683:             .Height        = 23
1684:             .InputMask     = "999,999,999"
1685:             .Left          = 238
1686:             .Top           = 543
1687:             .Width         = 93
1688:             .SpecialEffect = 1
1689:             .Value         = 0
1690:             *-- Contador somente-leitura: o legado prende o foco fora dele com
1691:             *-- "PROCEDURE When / Return .f." (SIGPRCCC.Get_Registro). NUNCA
1692:             *-- .Enabled = .F. aqui - o numero ficaria cinza, e o legado o exibe
1693:             *-- normalmente; ReadOnly + TabStop = .F. reproduz o efeito (nao
1694:             *-- entra na tabulacao e nao aceita digitacao) preservando a
1695:             *-- aparencia. Quem escreve nele eh AtualizarContadorRegistros.
1696:             .ReadOnly      = .T.
1697:             .TabStop       = .F.
1698:             .Visible       = .T.
1699:         ENDWITH
1700: 
1701:         THIS.AddObject("lbl_4c_LblEnd", "Label")
1702:         WITH THIS.lbl_4c_LblEnd
1703:             .AutoSize   = .F.
1704:             .FontBold   = .T.
1705:             .FontItalic = .F.
1706:             .FontName   = "Arial"
1707:             .FontSize   = 12
1708:             .WordWrap   = .F.
1709:             .Alignment  = 2
1710:             .BackStyle  = 0
1711:             .Caption    = "Processamento Conclu" + CHR(237) + "do"
1712:             .Height     = 22
1713:             .Left       = 361
1714:             .Top        = 545
1715:             .Width      = 205
1716:             .ForeColor  = RGB(255, 0, 0)
1717:             .Visible    = .F.
1718:         ENDWITH
1719:     ENDPROC
1720: 
1721:     *==========================================================================
1722:     * AjustarLarguraContainer - reproduz a animacao de Width do legado
1723:     * (For 1 To Largura / For Largura To 0 Step -1) ao expandir/recolher
1724:     * o container flutuante de cada frente de recalculo
1725:     *==========================================================================
1726:     PROTECTED PROCEDURE AjustarLarguraContainer(par_oContainer, par_nLarguraAlvo, par_lExpandir)
1727:         LOCAL loc_nI
1728:         IF par_lExpandir
1729:             FOR loc_nI = 1 TO par_nLarguraAlvo
1730:                 par_oContainer.Width = loc_nI
1731:             ENDFOR
1732:         ELSE
1733:             FOR loc_nI = par_nLarguraAlvo TO 0 STEP -1
1734:                 par_oContainer.Width = loc_nI
1735:             ENDFOR
1736:         ENDIF
1737:     ENDPROC
1738: 
1739:     *==========================================================================
1740:     * AtualizarEstadoProcessar - Processar so fica habilitado quando pelo
1741:     * menos uma das 4 frentes esta marcada (mesma condicao OR do legado,
1742:     * repetida nos 4 handlers de checkbox)
1743:     *==========================================================================
1744:     PROTECTED PROCEDURE AtualizarEstadoProcessar
1745:         IF THIS.chk_4c_Conta.Value = 1 OR THIS.chk_4c_Estoque.Value = 1 OR ;
1746:                 THIS.chk_4c_BtnCusto.Value = 1 OR THIS.chk_4c_BtnCompra.Value = 1
1747:             THIS.cmd_4c_Processa.Enabled = .T.
1748:         ELSE
1749:             THIS.cmd_4c_Processa.Enabled = .F.
1750:         ENDIF
1751:     ENDPROC
1752: 
1753:     *==========================================================================
1754:     * Handlers de Click dos checkboxes de toggle (PUBLIC - BINDEVENT exige
1755:     * metodo publico, regra #3) - cada um alterna Enabled/Visible do seu
1756:     * container e reproduz a animacao de Width antes de exibir/ocultar
1757:     *==========================================================================
1758:     PROCEDURE ChkContaClick
1759:         LOCAL loc_lExpandir
1760:         loc_lExpandir = (THIS.chk_4c_Conta.Value = 1)
1761: 
1762:         THIS.cnt_4c_OpConta.Enabled = loc_lExpandir
1763:         THIS.AjustarLarguraContainer(THIS.cnt_4c_OpConta, THIS.this_nLarguraOpConta, loc_lExpandir)
1764:         THIS.cnt_4c_OpConta.Visible = loc_lExpandir
1765: 
1766:         THIS.AtualizarEstadoProcessar()
1767:         THIS.Refresh()
1768:     ENDPROC
1769: 
1770:     PROCEDURE ChkEstoqueClick
1771:         LOCAL loc_lExpandir
1772:         loc_lExpandir = (THIS.chk_4c_Estoque.Value = 1)
1773: 
1774:         THIS.cnt_4c_OpEstoque.Enabled = loc_lExpandir
1775:         THIS.AjustarLarguraContainer(THIS.cnt_4c_OpEstoque, THIS.this_nLarguraOpEstoque, loc_lExpandir)
1776:         THIS.cnt_4c_OpEstoque.Visible = loc_lExpandir
1777: 
1778:         THIS.AtualizarEstadoProcessar()
1779:         THIS.Refresh()
1780:     ENDPROC
1781: 
1782:     PROCEDURE ChkBtnCustoClick
1783:         LOCAL loc_lExpandir
1784:         loc_lExpandir = (THIS.chk_4c_BtnCusto.Value = 1)
1785: 
1786:         THIS.cnt_4c_OpCusto.Enabled = loc_lExpandir
1787:         THIS.AjustarLarguraContainer(THIS.cnt_4c_OpCusto, THIS.this_nLarguraOpCusto, loc_lExpandir)
1788:         THIS.cnt_4c_OpCusto.Visible = loc_lExpandir
1789: 
1790:         THIS.AtualizarEstadoProcessar()
1791:         THIS.Refresh()
1792:     ENDPROC
1793: 
1794:     PROCEDURE ChkBtnCompraClick
1795:         LOCAL loc_lExpandir
1796:         loc_lExpandir = (THIS.chk_4c_BtnCompra.Value = 1)
1797: 
1798:         THIS.cnt_4c_OpCompra.Enabled = loc_lExpandir
1799:         THIS.AjustarLarguraContainer(THIS.cnt_4c_OpCompra, THIS.this_nLarguraOpCompra, loc_lExpandir)
1800:         THIS.cnt_4c_OpCompra.Visible = loc_lExpandir
1801: 
1802:         THIS.AtualizarEstadoProcessar()
1803:         THIS.Refresh()
1804:     ENDPROC
1805: 
1806:     *==========================================================================
1807:     * BtnCancelarClick - PUBLIC (BINDEVENT), identico ao legado ("ThisForm.Release").
1808:     * O nome vem do OBJETO do legado, que se chama "Cancela" (Caption
1809:     * "Encerrar"): nao ha nome inventado nem Page2 de Dados para cancelar -
1810:     * este eh o unico caminho de saida da tela.
1811:     *==========================================================================
1812:     PROCEDURE BtnCancelarClick
1813:         THIS.Release()
1814:     ENDPROC
1815: 
1816: 
1817:     *==========================================================================
1818:     * BtnProcessarClick - PUBLIC (BINDEVENT), evento PRINCIPAL do form e a
1819:     * UNICA acao que ele tem: transcreve o Processa.Click do legado
1820:     * (SIGPRCCC.Processa - o nome do handler vem do nome do objeto legado).
1821:     * Esta tela nao tem Salvar/Confirmar: o que ela grava eh o resultado do
1822:     * lote, dentro dos metodos Recalcular*/AtualizarUltimaCompra do BO.
1823:     *
1824:     * Sequencia do legado, na mesma ordem:
1825:     *   1. desabilita os 4 checkboxes + Processar + Encerrar e esconde o
1826:     *      "Processamento Concluido" (nada pode ser alterado durante o lote);
1827:     *   2. executa as frentes MARCADAS, cada uma autonoma em relacao as outras, na
1828:     *      ordem Conta Corrente -> Estoque -> Custo -> Ultima Compra;
1829:     *   3. reabilita tudo, exibe o "Processamento Concluido" e devolve o foco
1830:     *      ao Encerrar.
1831:     *
1832:     * O "Do While llSaida" do legado eh um laco de UMA passada usado apenas
1833:     * como estrutura de abandono (cada falha faz "llSaida = .f. / Loop", que
1834:     * pula as frentes seguintes). Aqui isso vira a flag loc_lProsseguir
1835:     * testada antes de cada frente - RETURN dentro de TRY/CATCH eh proibido
1836:     * (regra #1), e o bloco de reabilitacao TEM de rodar em qualquer saida,
1837:     * senao a tela fica inutilizavel com tudo cinza (regra #40).
1838:     *==========================================================================
1839:     PROCEDURE BtnProcessarClick
1840:         LOCAL loc_lProsseguir, loc_oErro
1841: 
1842:         *-- Sem conexao nao ha o que processar: avisa e nao mexe na tela
1843:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1844:             MsgAviso("Sem conex" + CHR(227) + "o com o servidor de banco de dados. " + ;
1845:                 "N" + CHR(227) + "o eh poss" + CHR(237) + "vel processar.", ;
1846:                 "Aten" + CHR(231) + CHR(227) + "o")
1847:             RETURN
1848:         ENDIF
1849: 
1850:         *-- Nenhuma frente marcada: o legado nem habilita o Processar nesse
1851:         *-- caso (AtualizarEstadoProcessar), mas o atalho de teclado chega aqui
1852:         IF THIS.chk_4c_Conta.Value != 1 AND THIS.chk_4c_Estoque.Value != 1 AND ;
1853:                 THIS.chk_4c_BtnCusto.Value != 1 AND THIS.chk_4c_BtnCompra.Value != 1
1854:             MsgAviso("Marque ao menos uma op" + CHR(231) + CHR(227) + "o de rec" + ;
1855:                 CHR(225) + "lculo antes de processar.", "Aten" + CHR(231) + CHR(227) + "o")
1856:             RETURN
1857:         ENDIF
1858: 
1859:         loc_lProsseguir = .T.
1860: 
1861:         *-- 1. Travar a tela durante o lote (identico ao 1o With do legado)
1862:         THIS.HabilitarControlesProcessamento(.F.)
1863: 
1864:         TRY
1865:             *-- Levar os filtros de cada container para o BO
1866:             THIS.FormParaBO()
1867:             THIS.this_oBusinessObject.this_oFormUI = THIS
1868: 
1869:             *-- 2a. Conta Corrente (If ThisForm.Conta.Value)
1870:             IF loc_lProsseguir AND THIS.chk_4c_Conta.Value = 1
1871:                 WAIT WINDOW "Aguarde! Selecionando Registros..." NOWAIT
1872:                 loc_lProsseguir = THIS.this_oBusinessObject.RecalcularContaCorrente()
1873:             ENDIF
1874: 
1875:             *-- 2b. Estoque (If ThisForm.Estoque.Value)
1876:             IF loc_lProsseguir AND THIS.chk_4c_Estoque.Value = 1
1877:                 WAIT WINDOW "Aguarde! Selecionando Registros..." NOWAIT
1878:                 loc_lProsseguir = THIS.this_oBusinessObject.RecalcularEstoque()
1879:             ENDIF
1880: 
1881:             *-- 2c. Custo de Produto (If ThisForm.btnCusto.Value)
1882:             IF loc_lProsseguir AND THIS.chk_4c_BtnCusto.Value = 1
1883:                 WAIT WINDOW "Aguarde! Selecionando Registros..." NOWAIT
1884:                 loc_lProsseguir = THIS.this_oBusinessObject.RecalcularCustoProduto()
1885:             ENDIF
1886: 
1887:             *-- 2d. Ultima Compra (If ThisForm.BtnCompra.Value)
1888:             IF loc_lProsseguir AND THIS.chk_4c_BtnCompra.Value = 1
1889:                 WAIT WINDOW "Aguarde! Selecionando Registros..." NOWAIT
1890:                 loc_lProsseguir = THIS.this_oBusinessObject.AtualizarUltimaCompra()
1891:             ENDIF
1892: 
1893:             WAIT CLEAR
1894:         CATCH TO loc_oErro
1895:             loc_lProsseguir = .F.
1896:             WAIT CLEAR
1897:             MsgErro(loc_oErro.Message + CHR(13) + ;
1898:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1899:                 "Procedure: " + loc_oErro.Procedure, "Erro ao processar Rec" + ;
1900:                 CHR(225) + "lculo de Saldos")
1901:         ENDTRY
1902: 
1903:         *-- 3. Destravar a tela SEMPRE - inclusive quando uma frente falhou
1904:         *-- (senao Processar/Encerrar ficam cinza e a tela morre, regra #40)
1905:         THIS.HabilitarControlesProcessamento(.T.)
1906: 
1907:         *-- "Processamento Concluido" so aparece quando tudo correu bem; em
1908:         *-- caso de falha o usuario ja recebeu o MsgErro da frente que parou
1909:         THIS.lbl_4c_LblEnd.Visible = loc_lProsseguir
1910: 
1911:         THIS.cmd_4c_Cancela.SetFocus()
1912:     ENDPROC
1913: 
1914:     *==========================================================================
1915:     * HabilitarControlesProcessamento - o par de blocos "With Thisform /
1916:     * .Conta.Enabled = .F. ... " do inicio e do fim de Processa.Click.
1917:     * Recebe .F. para travar a tela durante o lote e .T. para destravar.
1918:     *==========================================================================
1919:     PROTECTED PROCEDURE HabilitarControlesProcessamento(par_lHabilitar)
1920:         THIS.chk_4c_Conta.Enabled     = par_lHabilitar
1921:         THIS.chk_4c_Estoque.Enabled   = par_lHabilitar
1922:         THIS.chk_4c_BtnCusto.Enabled  = par_lHabilitar
1923:         THIS.chk_4c_BtnCompra.Enabled = par_lHabilitar
1924:         THIS.cmd_4c_Cancela.Enabled   = par_lHabilitar
1925: 
1926:         IF par_lHabilitar
1927:             *-- Processar segue a regra normal da tela (so habilitado com
1928:             *-- alguma frente marcada), NUNCA habilitado incondicionalmente
1929:             THIS.AtualizarEstadoProcessar()
1930:         ELSE
1931:             THIS.cmd_4c_Processa.Enabled = .F.
1932:             THIS.lbl_4c_LblEnd.Visible   = .F.
1933:         ENDIF
1934: 
1935:         THIS.Refresh()
1936:     ENDPROC
1937: 
1938:     *==========================================================================
1939:     * FormParaBO - leva os filtros dos 4 containers flutuantes para as
1940:     * propriedades do BO. Espelha as atribuicoes "_Emps = Padr(...)" que o
1941:     * legado faz no inicio de cada ramo de Processa.Click.
1942:     *
1943:     * PROTECTED EXPLICITO: FormBase declara FormParaBO como PROTECTED e o
1944:     * VFP9 nao deixa a subclasse alargar o escopo - omitir o modificador
1945:     * mentiria para quem le, porque o metodo continua protegido. Chamado
1946:     * sempre por THIS. de dentro da classe (regra #8).
1947:     *
1948:     * As datas ficam como DATE ({} quando em branco) - quem converte para
1949:     * DATETIME/SQL eh o BO, via fDtoSQL. NUNCA TTOD aqui: o TextBox nasce
1950:     * com .Value = {} (DATE) e TTOD com DATE dispara erro 11 (regra #16).
1951:     *==========================================================================
1952:     PROTECTED PROCEDURE FormParaBO()
1953:         LOCAL loc_oBO, loc_oCnt
1954:         loc_oBO = THIS.this_oBusinessObject
1955: 
1956:         *-- Flags das 4 frentes (CheckBox.Value eh NUMERICO - converter)
1957:         loc_oBO.this_lConta   = (THIS.chk_4c_Conta.Value = 1)
1958:         loc_oBO.this_lEstoque = (THIS.chk_4c_Estoque.Value = 1)
1959:         loc_oBO.this_lCusto   = (THIS.chk_4c_BtnCusto.Value = 1)
1960:         loc_oBO.this_lCompra  = (THIS.chk_4c_BtnCompra.Value = 1)
1961: 
1962:         *-- Conta Corrente (OpConta)
1963:         loc_oCnt = THIS.cnt_4c_OpConta
1964:         loc_oBO.this_cContaEmpresa = PADR(ALLTRIM(loc_oCnt.txt_4c_Empresa.Value), 3)
1965:         loc_oBO.this_cContaGrupo   = PADR(ALLTRIM(loc_oCnt.txt_4c_TxtGrupos.Value), 10)
1966:         loc_oBO.this_cContaConta   = PADR(ALLTRIM(loc_oCnt.txt_4c_TxtContas.Value), 10)
1967:         loc_oBO.this_cContaMoeda   = PADR(ALLTRIM(loc_oCnt.txt_4c_TxtMoedas.Value), 3)
1968:         loc_oBO.this_dContaData    = ConverterParaData(loc_oCnt.txt_4c_TxtData.Value)
1969: 
1970:         *-- Estoque (OpEstoque)
1971:         loc_oCnt = THIS.cnt_4c_OpEstoque
1972:         loc_oBO.this_cEstoqueEmpresa   = PADR(ALLTRIM(loc_oCnt.txt_4c_Empresa.Value), 3)
1973:         loc_oBO.this_cEstoqueGrupo     = PADR(ALLTRIM(loc_oCnt.txt_4c_TxtGrupos.Value), 10)
1974:         loc_oBO.this_cEstoqueEstoque   = PADR(ALLTRIM(loc_oCnt.txt_4c_Estoque.Value), 10)
1975:         loc_oBO.this_cEstoqueProduto   = PADR(ALLTRIM(loc_oCnt.txt_4c_Produto.Value), 14)
1976:         loc_oBO.this_cEstoqueDescricao = PADR(ALLTRIM(loc_oCnt.txt_4c_Descricao.Value), 65)
1977:         loc_oBO.this_dEstoqueData      = ConverterParaData(loc_oCnt.txt_4c_TxtData.Value)
1978: 
1979:         *-- Custo de Produto (OpCusto)
1980:         loc_oCnt = THIS.cnt_4c_OpCusto
1981:         loc_oBO.this_cCustoEmpresa   = PADR(ALLTRIM(loc_oCnt.txt_4c_Empresa.Value), 3)
1982:         loc_oBO.this_cCustoProduto   = PADR(ALLTRIM(loc_oCnt.txt_4c_Produto.Value), 14)
1983:         loc_oBO.this_cCustoDescricao = PADR(ALLTRIM(loc_oCnt.txt_4c_Descricao.Value), 65)
1984:         loc_oBO.this_dCustoData      = ConverterParaData(loc_oCnt.txt_4c_TxtData.Value)
1985: 
1986:         *-- Ultima Compra (OpCompra)
1987:         loc_oCnt = THIS.cnt_4c_OpCompra
1988:         loc_oBO.this_cCompraEmpresa   = PADR(ALLTRIM(loc_oCnt.txt_4c_Empresa.Value), 3)
1989:         loc_oBO.this_cCompraProduto   = PADR(ALLTRIM(loc_oCnt.txt_4c_Produto.Value), 14)
1990:         loc_oBO.this_cCompraDescricao = PADR(ALLTRIM(loc_oCnt.txt_4c_Descricao.Value), 65)
1991:         loc_oBO.this_dCompraData      = ConverterParaData(loc_oCnt.txt_4c_TxtData.Value)
1992: 
1993:         RETURN .T.
1994:     ENDPROC
1995: 
1996:     *==========================================================================
1997:     * AtualizarContadorRegistros - PUBLIC (chamado de FORA da classe, pelo BO
1998:     * durante o processamento - metodo PROTECTED falharia em runtime mesmo
1999:     * com PEMSTATUS devolvendo .T., regra #3). Equivale ao par
2000:     * "ThisForm.Get_Registro.Value = lnReg / ThisForm.Get_Registro.Refresh"
2001:     * repetido em todos os Scan de Processa.Click.
2002:     *==========================================================================
2003:     PROCEDURE AtualizarContadorRegistros(par_nRegistros)
2004:         IF VARTYPE(par_nRegistros) = "N"
2005:             THIS.txt_4c_Registro.Value = par_nRegistros
2006:             THIS.txt_4c_Registro.Refresh()
2007:         ENDIF
2008:     ENDPROC
2009:     *==========================================================================
2010:     * TornarControlesVisiveis - Torna visiveis os controles recem-criados,
2011:     * SEM alterar os containers flutuantes (cnt_4c_Op*), que devem comecar
2012:     * ocultos igual ao legado - mas RECURSA dentro deles para que os
2013:     * campos adicionados nas fases seguintes ja nascam visiveis quando o
2014:     * container for exibido pelo checkbox correspondente.
2015:     *==========================================================================
2016:     PROCEDURE TornarControlesVisiveis(par_oContainer)
2017:         LOCAL loc_i, loc_oControl, loc_oAlvo
2018: 
2019:         IF VARTYPE(par_oContainer) = "O"
2020:             loc_oAlvo = par_oContainer
2021:         ELSE
2022:             loc_oAlvo = THIS
2023:         ENDIF
2024: 
2025:         FOR loc_i = 1 TO loc_oAlvo.ControlCount
2026:             loc_oControl = loc_oAlvo.Controls(loc_i)
2027:             IF VARTYPE(loc_oControl) = "O"
2028:                 IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_OPCONTA", "CNT_4C_OPESTOQUE", ;
2029:                         "CNT_4C_OPCUSTO", "CNT_4C_OPCOMPRA")
2030:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2031:                         THIS.TornarControlesVisiveis(loc_oControl)
2032:                     ENDIF
2033:                     LOOP
2034:                 ENDIF
2035:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2036:                     loc_oControl.Visible = .T.
2037:                 ENDIF
2038:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2039:                     THIS.TornarControlesVisiveis(loc_oControl)
2040:                 ENDIF
2041:             ENDIF
2042:         ENDFOR
2043:     ENDPROC
2044: 
2045:     *==========================================================================
2046:     PROCEDURE Destroy()
2047:     *==========================================================================
2048:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2049:             THIS.this_oBusinessObject = .NULL.
2050:         ENDIF
2051:         DODEFAULT()
2052:     ENDPROC
2053: 
2054: ENDDEFINE

