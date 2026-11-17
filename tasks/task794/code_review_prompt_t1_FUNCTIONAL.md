# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarProdutoOrigem()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpRef.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1670 linhas total):

*-- Linhas 26 a 475:
26: * do SIGOPREF.SCX legado), bem menor que o canonico 1000x600 de CRUD.
27: *
28: * Fase 3/8 - Estrutura base: propriedades visuais, Init() recebendo e
29: * validando os mesmos parametros do Init legado, InicializarForm() (cria o
30: * Business Object, monta o cabecalho e carrega o produto de ORIGEM - a unica
31: * consulta que o legado tambem faz incondicionalmente no Init, antes de
32: * exibir qualquer campo), e o cabecalho (cntSombra -> cnt_4c_Cabecalho).
33: * Campos de origem/destino, Opc_situacao e os dois botoes ficam para as
34: * proximas fases.
35: *
36: * Fase 4/8 - Dialogo de CAPTURA (sem Page1/Lista): o dump nao tem NENHUMA
37: * superficie de lista (zero BaseClass grid/pageframe, zero AddCursor/
38: * pColuna/RecordSource com valor, zero ControlSource com valor fora do
39: * CommandGroup) e TEM superficie de campos editaveis (5 TextBox fwget +
40: * 1 OptionGroup, nenhum ReadOnly=.T. incondicional - GetOldCPro/
41: * getOldCGrus/getolddpro so ficam Enabled=.F. porque espelham o produto
42: * de ORIGEM, que o usuario nao edita, mas nao sao campos de EXIBICAO do
43: * dialogo como um todo). Entao nao ha Grid nem 6 botoes CRUD a entregar
44: * aqui (inventa-los violaria o PILAR 1) - o entregavel real desta fase eh
45: * o container de botoes de ACAO do legado (cntBotoes -> cmg_4c_Botoes,
46: * CommandGroup com Confirmar/Cancelar), equivalente ao "cnt_4c_Botoes" do
47: * template CRUD. Mesmo padrao de FormSigMvChv.prg/FormSigOpCcj.prg
48: * (familia de dialogo OPERACIONAL flat sem Lista). Os campos (Fase 5) e
49: * os handlers de Click (fase de eventos/acao) ficam para as proximas
50: * fases.
51: *
52: * Fase 5/8 - Campos de CODIGO/GRUPO (primeira metade): este dialogo nao
53: * tem PageFrame/Page2 (regra da Fase 3 - form PLANO), entao os controles
54: * vao direto sobre THIS, igual a cnt_4c_Cabecalho/cmg_4c_Botoes. Metade 1
55: * cobre a dupla de linhas Codigo/Grupo (Say1/Say3/Say5/Say2 + GetOldCPro/
56: * getOldCGrus/getNewCpro/getNewCGrus do dump), transcrita 1:1 (Left/Top/
57: * Width/Height/MaxLength/InputMask/SpecialEffect/BorderColor/TabIndex/
58: * Enabled/DisabledBackColor/DisabledForeColor). GetOldCPro/getOldCGrus
59: * ficam Enabled=.F. (espelham o produto de ORIGEM - regra do dump, nao
60: * ReadOnly). Nomes de objeto seguem o nome da property do BO (ja criada
61: * nas Fases 1/2) para nao divergir (regra "BO property name DEVE bater
62: * com uso no Form"). A segunda metade (Descricao/Quantidade/Situacao +
63: * os dois labels de status) e o binding (BOParaForm/FormParaBO) ficam
64: * para a Fase 6.
65: *
66: * Fase 6/8 - Campos restantes (segunda metade) + binding: Say7/getolddpro
67: * (Descricao do produto de ORIGEM, Enabled=.F. - mesmo padrao das demais
68: * linhas de origem), Say6/getnewdpro (Descricao do produto NOVO, editavel -
69: * so usada quando o usuario digita manualmente; nos demais casos o legado
70: * remonta a descricao via fGerarDescrs/fGerDescritivo, que nao vieram no
71: * acervo - regra #27, ja documentado em SigOpRefBO.Inserir), Say4/Get_Qtd
72: * (Quantidade), Say19/Opc_situacao (Situacao Ativo/Inativo - ControlSource
73: * NUMERICO direto, Value = coluna, sem +1/-1) e os dois labels de status
74: * (lblOk/lblNotOk) - estes DOIS ultimos sao dead code no legado: nenhum
75: * metodo do SCX (Init/btnConfirmar.Click/btnSair.Click) jamais atribui
76: * .Visible aos dois (confirmado varrendo o dump inteiro) - ficam sempre
77: * ocultos, e por isso TornarControlesVisiveis tem uma excecao para NAO
78: * forcar .Visible = .T. neles (mesma tecnica de "containers flutuantes"
79: * do guia de migracao - um controle que o legado nunca exibe nao pode
80: * passar a aparecer so porque a ferramenta generica torna tudo visivel).
81: * Say19 nao declara Width/Height no dump (classe say AutoSize=.T.,
82: * regra CLAUDE.md #23) - como AutoSize eh no-op em Label criado por
83: * AddObject, a Width foi calculada para caber o texto "Situacao :" sem
84: * encostar no Opc_situacao (Left=190), seguindo a mesma regra.
85: *
86: * BOParaForm()/FormParaBO() fazem o binding completo entre os controles
87: * e as properties do SigOpRefBO (todas ja declaradas nas Fases 1/2).
88: * BOParaForm() tambem repete o bloco do Init legado que trava
89: * Opc_situacao.Enabled = .f. quando a Situacao foi fixada por parametro
90: * (pSit = 1 ou 2).
91: *
92: * Fase 6/8 - Validacao do campo "Grupo de Destino": este dialogo NAO tem
93: * lookup de picker (varrido o dump inteiro: zero fwBuscaExt/fwBuscaSel/
94: * fwBuscaInt/sigacess/mAddColuna) - inventar um FormBuscaAuxiliar aqui
95: * violaria o PILAR 1 e a regra "NUNCA inventar tabelas de lookup". O que
96: * o legado tem no lugar eh UM Valid de verdade, no getNewCGrus: digitado
97: * o grupo, ele consulta SigCdGrp/SigCdGpr e GERA o codigo do produto
98: * novo. Essa e a validacao de campo desta fase, e esta implementada em
99: * ValidarGrupoDestino() (tela) + SigOpRefBO.GerarCodigoProdutoDestino()
100: * (regra de negocio, transcrita linha a linha - regra #17).
101: *
102: * Eventos ligados: BINDEVENT em "LostFocus" (NUNCA "KeyPress" - regra
103: * #47: o legado valida ao SAIR do campo, e em KeyPress a consulta
104: * dispararia a cada caractere) e em "GotFocus" (reproduz a primeira
105: * linha do When legado, que guarda o AntValue). Os tres PROCEDURE When
106: * do legado (getNewCpro/getNewCGrus/Get_Qtd) viram .Enabled em
107: * AjustarCamposPorEstado(), reaplicado sempre que Automatico/AcesGru
108: * mudam. O bloco do Init legado que decide se o grupo eh digitavel
109: * (csTmpGru.DigGprs <> 1 Or SaiAuto) esta em AplicarEstadoGrupoDestino(),
110: * chamado no fim do BOParaForm.
111: *
112: * Fase 7/8 - Eventos principais dos botoes. Este dialogo NAO tem a barra
113: * CRUD do frmcadastro (o legado herda de "form" puro: zero frmcadastro,
114: * zero Grupo_Op, zero pcEscolha no dump inteiro) - os UNICOS botoes do
115: * SCX sao os dois do cntBotoes, btnConfirmar ("Salvar") e btnSair
116: * ("Cancelar", Cancel = .T.). Inventar BtnIncluir/BtnAlterar/
117: * BtnVisualizar/BtnExcluir aqui violaria o PILAR 1 e a regra "NUNCA
118: * inventar"; os eventos principais desta tela sao, literalmente, esses
119: * dois - ligados por BINDEVENT em Buttons(1)/Buttons(2) no fim de
120: * ConfigurarBotoes:
121: *
122: *   BtnConfirmarClick  -> btnConfirmar.Click: valida duplicidade e codigo
123: *       vazio, pede a confirmacao (pulada quando SaiAuto) e dispara a
124: *       copia via NovoRegistro() + Salvar() do Business Object
125: *   BtnCancelarClick   -> btnSair.Click: devolve ao contador o sequencial
126: *       reservado (SigOpRefBO.CancelarCodigoReservado) e fecha sem gerar
127: *
128: * Entra tambem o ULTIMO bloco do Init legado ("If .SaiAuto /
129: * .cntBotoes.btnConfirmar.Click()"), em InicializarForm: quem abre com
130: * SaiAuto = .T. nunca exibe a tela e recebe o resultado pronto.
131: *
132: * RETORNO DO DIALOGO: o legado devolve o codigo gerado pelo RETURN do
133: * evento Unload ("Return ThisForm.RetCodProduto"), que so chega a quem
134: * abre com "DO FORM ... TO <var>" - e eh assim que SIGOPPRO e SIGMVCAB o
135: * abrem. O sistema novo abre por CREATEOBJECT + Show(), onde esse retorno
136: * eh inalcancavel, entao ele vem por ObterRetorno(). Como consequencia os
137: * dois botoes fecham com Hide() (funil FecharDialogo), nao com Release():
138: * Release destroi o objeto mesmo com o chamador segurando a referencia, e
139: * a leitura seguinte estouraria "is not an object". Quem chama o dialogo
140: * eh quem da o Release(), DEPOIS de ler. O PROCEDURE Unload continua
141: * existindo, lendo o cache preenchido no fechamento e no Destroy.
142: *
143: * Fase 8/8 - Consolidacao final. O dialogo ja estava funcionalmente
144: * completo ao fim da Fase 7 (os dois unicos botoes do SCX ligados, os
145: * cinco campos editaveis mapeados nos dois sentidos, a validacao do
146: * Grupo de Destino e os tres When do legado traduzidos para .Enabled).
147: * Esta fase fecha a migracao com:
148: *
149: *   - BtnCancelarClick: o handler do botao de abandono passou a usar o
150: *     nome canonico do projeto, em vez do nome do objeto legado
151: *     (btnSair). Ver o bloco do proprio metodo.
152: *   - FormParaBO()/BOParaForm(): conferidos campo a campo contra as
153: *     properties do SigOpRefBO - os 5 controles editaveis (codigo, grupo,
154: *     descricao, quantidade e situacao do produto NOVO) vao para o BO, e
155: *     os 3 de ORIGEM mais os 5 do destino voltam dele. As properties de
156: *     ESTADO do legado (SaiAuto/IdentFixa/CadPro/Dopes/SituacaoIt), que
157: *     nao tem controle na tela, sao alimentadas pelos parametros do Init
158: *     em CarregarProdutoOrigem.
159: *
160: * Os quatro nomes canonicos restantes do template CRUD NAO se aplicam a
161: * esta tela e inventa-los violaria o PILAR 1:
162: *
163: *   - CarregarLista()/AjustarBotoesPorModo(): nao ha Page1 de Lista nem
164: *     grade alguma no SCX (analise.json: temGrid = false), e tampouco
165: *     existe o conceito de MODO (zero pcEscolha no dump inteiro) - este
166: *     dialogo tem um unico fluxo, do Init ate o botao de acao.
167: *   - HabilitarCampos(): o equivalente fiel ja existe com o nome que
168: *     descreve o que o legado de fato faz - AjustarCamposPorEstado(),
169: *     transcricao dos tres PROCEDURE When do SCX; um HabilitarCampos
170: *     generico por modo nao teria modo nenhum para ler.
171: *   - LimparCampos(): o legado nunca limpa a tela - ele fecha. O dialogo
172: *     eh de uso unico (Init carrega o produto de origem, o botao de acao
173: *     gera e fecha), entao nao ha caminho de volta a limpar.
174: *==============================================================================
175: 
176: DEFINE CLASS FormSigOpRef AS FormBase
177: 
178:     *-- Propriedades visuais (PILAR 1: identico ao legado SigOpRef.SCX)
179:     Width        = 583
180:     Height       = 282
181:     AutoCenter   = .T.
182:     Caption      = "Cadastro de Produto"
183:     ShowWindow   = 1
184:     WindowType   = 1
185:     ControlBox   = .F.
186:     Closable     = .F.
187:     MaxButton    = .F.
188:     MinButton    = .F.
189:     TitleBar     = 0
190:     BorderStyle  = 2
191:     ShowTips     = .T.
192:     ClipControls = .F.
193:     Themes       = .F.
194: 
195:     *-- Parametros recebidos em Init() (legado pSit/pAut/pIFx/pCad/pDop/pGru) -
196:     *-- guardados aqui porque o Business Object so existe depois de
197:     *-- DODEFAULT() disparar FormBase.Init() -> InicializarForm().
198:     this_cParCodProdOrigem = ""
199:     this_nParSituacao      = 0
200:     this_lParSaiAuto       = .F.
201:     this_nParIdentFixa     = 0
202:     this_nParCadPro        = 0
203:     this_cParDopes         = ""
204:     this_cParGrupoDestino  = ""
205: 
206:     *-- Guarda de reentrancia do handler do "Grupo de Destino": ValidarGrupoDestino
207:     *-- esta ligado a LostFocus e escreve no .Value/.Enabled de outros campos,
208:     *-- o que pode devolver o foco a este - sem a guarda o proprio LostFocus
209:     *-- redispararia a consulta.
210:     this_lEmValidacaoGrupo = .F.
211: 
212:     *-- Guarda de reentrancia do botao "Salvar": o Click pode ser disparado
213:     *-- duas vezes (duplo clique, ou o disparo automatico do SaiAuto somado a
214:     *-- um clique do usuario) e cada passagem GERA UM PRODUTO - sem a guarda o
215:     *-- mesmo pedido criaria dois registros em SigCdPro.
216:     this_lEmGravacao = .F.
217: 
218:     *-- Cache do retorno do dialogo (RetCodProduto do legado). Preenchido no
219:     *-- FUNIL de fechamento e de novo no Destroy, enquanto o Business Object
220:     *-- ainda existe: o Unload - que devolve o valor a quem abriu com
221:     *-- "DO FORM ... TO <var>" - dispara DEPOIS do Destroy, e nesse ponto
222:     *-- FormBase.Destroy ja fez this_oBusinessObject = .NULL.
223:     *-- Comeca com " " (um espaco), igual ao legado ("ThisForm.RetCodproduto
224:     *-- = ' '"); EMPTY() trata vazio e espaco igual, entao o teste do
225:     *-- chamador ("If Not Empty(lcCodProduto)") nao muda.
226:     this_cRetCodProduto = " "
227: 
228:     *--------------------------------------------------------------------------
229:     * Init - Recebe os mesmos parametros do Init legado e reproduz a mesma
230:     * exigencia: o produto de origem (pPro) tem de ser informado - sem ele o
231:     * dialogo nao tem o que replicar. Os demais parametros sao opcionais,
232:     * com os mesmos defaults do legado (Iif(Type(...)...)). Em modo de teste
233:     * automatizado (TestFormWrapper/ValidarUIFidelity) a exigencia e
234:     * dispensada, para permitir instanciar o form so para validar a
235:     * estrutura visual - mesma excecao ja aplicada na familia SigOp
236:     * (FormSigOpCcj.Init).
237:     *--------------------------------------------------------------------------
238:     PROCEDURE Init(par_cCodProdOrigem, par_nSituacao, par_lSaiAuto, ;
239:             par_nIdentFixa, par_nCadPro, par_cDopes, par_cGrupoDestino)
240:         LOCAL loc_lParametrosOk, loc_lSucesso, loc_lModoTeste
241:         loc_lParametrosOk = .T.
242:         loc_lSucesso = .F.
243: 
244:         loc_lModoTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
245: 
246:         IF !loc_lModoTeste
247:             IF VARTYPE(par_cCodProdOrigem) != "C" OR EMPTY(ALLTRIM(par_cCodProdOrigem))
248:                 MsgAviso("O produto de origem informado n" + CHR(227) + "o " + ;
249:                     CHR(233) + " v" + CHR(225) + "lido...", "Par" + CHR(226) + ;
250:                     "metros Inv" + CHR(225) + "lidos!")
251:                 loc_lParametrosOk = .F.
252:             ENDIF
253:         ENDIF
254: 
255:         IF loc_lParametrosOk
256:             THIS.this_cParCodProdOrigem = IIF(VARTYPE(par_cCodProdOrigem) = "C", par_cCodProdOrigem, "")
257:             THIS.this_nParSituacao      = IIF(VARTYPE(par_nSituacao) = "N", par_nSituacao, 0)
258:             THIS.this_lParSaiAuto       = IIF(VARTYPE(par_lSaiAuto) = "L", par_lSaiAuto, .F.)
259:             THIS.this_nParIdentFixa     = IIF(VARTYPE(par_nIdentFixa) = "N", par_nIdentFixa, 0)
260:             THIS.this_nParCadPro        = IIF(VARTYPE(par_nCadPro) = "N", par_nCadPro, 0)
261:             THIS.this_cParDopes         = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
262:             THIS.this_cParGrupoDestino  = IIF(VARTYPE(par_cGrupoDestino) = "C", par_cGrupoDestino, "")
263: 
264:             loc_lSucesso = DODEFAULT()
265:         ENDIF
266: 
267:         RETURN loc_lSucesso
268:     ENDPROC
269: 
270:     *--------------------------------------------------------------------------
271:     * InicializarForm - Cria o Business Object, monta a estrutura visual
272:     * basica (cabecalho) e carrega o produto de ORIGEM. Nao ha Grid nem
273:     * PageFrame neste dialogo - o SCX legado nao tem nenhum dos dois.
274:     *--------------------------------------------------------------------------
275:     PROTECTED PROCEDURE InicializarForm()
276:         LOCAL loc_lSucesso, loc_lModoTeste, loc_oErro
277:         loc_lSucesso = .F.
278: 
279:         TRY
280:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpRefBO")
281: 
282:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
283:                 THIS.ConfigurarPageFrame()
284:                 THIS.ConfigurarCabecalho()
285:                 THIS.ConfigurarBotoes()
286:                 THIS.ConfigurarCamposCodigos()
287:                 THIS.ConfigurarCamposRestantes()
288: 
289:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
290:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
291: 
292:                 loc_lModoTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
293:                     (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
294: 
295:                 IF loc_lModoTeste OR EMPTY(ALLTRIM(THIS.this_cParCodProdOrigem))
296:                     loc_lSucesso = .T.
297:                 ELSE
298:                     loc_lSucesso = THIS.CarregarProdutoOrigem()
299:                 ENDIF
300: 
301:                 IF loc_lSucesso
302:                     THIS.BOParaForm()
303:                     THIS.TornarControlesVisiveis(THIS)
304: 
305:                     *-- legado, ULTIMO bloco do Init:
306:                     *--   If .SaiAuto
307:                     *--       .cntBotoes.btnConfirmar.Click()
308:                     *--   EndIf
309:                     *-- Quem abre com SaiAuto = .T. nunca exibe a tela (o
310:                     *-- chamador legado usa "DO FORM ... NOSHOW"): a copia roda
311:                     *-- aqui mesmo e o resultado sai por ObterRetorno(). Em
312:                     *-- modo de teste automatizado nao dispara - o disparo
313:                     *-- GRAVA no banco, e instanciar o form para validar
314:                     *-- estrutura nao pode criar produto nenhum.
315:                     IF !loc_lModoTeste AND THIS.this_oBusinessObject.this_lSaiAuto
316:                         THIS.BtnConfirmarClick()
317:                     ENDIF
318:                 ENDIF
319:             ELSE
320:                 MsgErro("Erro ao criar Business Object de Replica" + CHR(231) + ;
321:                     CHR(227) + "o de Produto." + CHR(13) + "VARTYPE retornou: " + ;
322:                     VARTYPE(THIS.this_oBusinessObject), "Erro")
323:             ENDIF
324:         CATCH TO loc_oErro
325:             MsgErro(loc_oErro.Message + CHR(13) + ;
326:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
327:                 "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpRef")
328:         ENDTRY
329: 
330:         RETURN loc_lSucesso
331:     ENDPROC
332: 
333:     *--------------------------------------------------------------------------
334:     * ConfigurarPageFrame - SigOpRef legado NAO TEM PageFrame: layout PLANO
335:     * com fundo new_background.jpg (Picture do dump), igual ao padrao de
336:     * dialogos OPERACIONAL pequenos sem abas (ver FormSigOpCcj.prg). Mantido
337:     * so para configurar a aparencia base do form - nao cria pagina alguma.
338:     *--------------------------------------------------------------------------
339:     PROTECTED PROCEDURE ConfigurarPageFrame()
340:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
341:         THIS.SetAll("FontName", "Tahoma")
342:         THIS.SetAll("FontSize", 8)
343:     ENDPROC
344: 
345:     *--------------------------------------------------------------------------
346:     * ConfigurarCabecalho - Container header cinza (cntSombra do legado).
347:     * Original: cntSombra Top=0, Left=0, Width=800 (boilerplate do template -
348:     * regra CLAUDE.md #11: usar THIS.Width, nunca o literal do SCX),
349:     * Height=80, BackColor=100,100,100; lblSombra/lblTitulo Left=10,
350:     * Width=THIS.Width-21, ForeColor preto/branco, FontSize=18.
351:     *--------------------------------------------------------------------------
352:     PROTECTED PROCEDURE ConfigurarCabecalho()
353:         LOCAL loc_oErro
354:         TRY
355:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
356:             WITH THIS.cnt_4c_Cabecalho
357:                 .Top         = 0
358:                 .Left        = 0
359:                 .Width       = THIS.Width
360:                 .Height      = 80
361:                 .BackStyle   = 1
362:                 .BackColor   = RGB(100, 100, 100)
363:                 .BorderWidth = 0
364:                 .Visible     = .T.
365:             ENDWITH
366: 
367:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
368:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
369:                 .FontBold      = .T.
370:                 .FontName      = "Tahoma"
371:                 .FontSize      = 18
372:                 .FontUnderline = .F.
373:                 .WordWrap      = .T.
374:                 .Alignment     = 0
375:                 .BackStyle     = 0
376:                 .AutoSize      = .F.
377:                 .Caption       = THIS.Caption
378:                 .Height        = 40
379:                 .Left          = 10
380:                 .Top           = 18
381:                 .Width         = THIS.Width - 21
382:                 .ForeColor     = RGB(0, 0, 0)
383:                 .Visible       = .T.
384:             ENDWITH
385: 
386:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
387:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
388:                 .FontBold      = .T.
389:                 .FontName      = "Tahoma"
390:                 .FontSize      = 18
391:                 .WordWrap      = .T.
392:                 .Alignment     = 0
393:                 .BackStyle     = 0
394:                 .AutoSize      = .F.
395:                 .Caption       = THIS.Caption
396:                 .Height        = 46
397:                 .Left          = 10
398:                 .Top           = 17
399:                 .Width         = THIS.Width - 21
400:                 .ForeColor     = RGB(255, 255, 255)
401:                 .ToolTipText   = "T" + CHR(237) + "tulo do Di" + CHR(225) + "logo"
402:                 .Visible       = .T.
403:             ENDWITH
404:         CATCH TO loc_oErro
405:             MsgErro(loc_oErro.Message + CHR(13) + ;
406:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
407:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpRef.ConfigurarCabecalho")
408:         ENDTRY
409:     ENDPROC
410: 
411:     *--------------------------------------------------------------------------
412:     * ConfigurarBotoes - CommandGroup cntBotoes do legado (ButtonCount=2):
413:     * Buttons(1) = Command1/btnConfirmar ("Salvar" - realiza a copia do
414:     * produto), Buttons(2) = Command2/btnSair ("Cancelar" - fecha sem
415:     * gravar, Cancel=.T.). Nao ha Page/Lista neste dialogo (regra #30: o
416:     * container flutua direto sobre o Form, por cima da faixa do
417:     * cabecalho - por isso eh chamado DEPOIS de ConfigurarCabecalho, igual
418:     * ao padrao canonico de saida da familia CRUD). Geometria, icones,
419:     * captions e ToolTipText transcritos do dump (SIGOPREF.cntBotoes):
420:     * Top=-2, Left=425, Width=160, Height=85; botoes 75x75 em
421:     * Left=5/80, Top=5, Comic Sans MS 8 bold italic.
422:     *
423:     * O BINDEVENT dos Click (BtnConfirmarClick/BtnCancelarClick) e a
424:     * implementacao dos handlers sao a Fase 7/8 e ja estao aqui: os dois
425:     * botoes do legado (os UNICOS deste dialogo) sao ligados no fim deste
426:     * metodo, junto da criacao do CommandGroup.
427:     *
428:     * No legado cada botao tem o SEU Click (cntBotoes.btnConfirmar.Click e
429:     * cntBotoes.btnSair.Click), nao o Click do grupo - por isso o BINDEVENT
430:     * vai em Buttons(1)/Buttons(2), um por botao, e nao no CommandGroup
431:     * (que dispararia um handler unico para os dois). Os handlers sao PUBLIC
432:     * de proposito: BINDEVENT em metodo PROTECTED falha em SILENCIO (regra
433:     * #3).
434:     *--------------------------------------------------------------------------
435:     PROTECTED PROCEDURE ConfigurarBotoes()
436:         LOCAL loc_oCmg, loc_oErro
437: 
438:         TRY
439:             THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
440:             loc_oCmg = THIS.cmg_4c_Botoes
441:             WITH loc_oCmg
442:                 .Top           = -2
443:                 .Left          = 425
444:                 .Width         = 160
445:                 .Height        = 85
446:                 .ButtonCount   = 2
447:                 .AutoSize      = .T.
448:                 .BackStyle     = 0
449:                 .BorderStyle   = 0
450:                 .SpecialEffect = 1
451:                 .BorderColor   = RGB(136, 189, 188)
452:                 .Themes        = .F.
453:                 .Value         = 0
454: 
455:                 WITH .Buttons(1)
456:                     .Top           = 5
457:                     .Left          = 5
458:                     .Width         = 75
459:                     .Height        = 75
460:                     .AutoSize      = .F.
461:                     .FontName      = "Comic Sans MS"
462:                     .FontSize      = 8
463:                     .FontBold      = .T.
464:                     .FontItalic    = .T.
465:                     .WordWrap      = .T.
466:                     .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
467:                     *-- "\<" = tecla de acesso Alt+S do legado
468:                     *-- (Command1.Caption = "\<Salvar").
469:                     .Caption       = "\<Salvar"
470:                     .MousePointer  = 15
471:                     .ToolTipText   = "Realizar a C" + CHR(243) + "pia de Produtos"
472:                     .SpecialEffect = 0
473:                     .PicturePosition = 13
474:                     .ForeColor     = RGB(90, 90, 90)
475:                     .BackColor     = RGB(255, 255, 255)

*-- Linhas 501 a 561:
501:             ENDWITH
502: 
503:             *-- legado: cntBotoes.btnConfirmar.Click / cntBotoes.btnSair.Click
504:             BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnConfirmarClick")
505:             BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnCancelarClick")
506:         CATCH TO loc_oErro
507:             MsgErro(loc_oErro.Message + CHR(13) + ;
508:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
509:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpRef.ConfigurarBotoes")
510:         ENDTRY
511:     ENDPROC
512: 
513:     *--------------------------------------------------------------------------
514:     * ConfigurarCamposCodigos - Fase 5/8 (primeira metade dos campos): as
515:     * duas linhas de Codigo/Grupo do dump (Say1/Say3/GetOldCPro/getOldCGrus
516:     * = ORIGEM, Say5/Say2/getNewCpro/getNewCGrus = DESTINO). Controles direto
517:     * sobre THIS (form PLANO, sem PageFrame - regra da Fase 3). Geometria,
518:     * MaxLength, InputMask, SpecialEffect, BorderColor, Enabled e cores de
519:     * desabilitado transcritos LITERALMENTE do dump do SCX legado.
520:     *--------------------------------------------------------------------------
521:     PROTECTED PROCEDURE ConfigurarCamposCodigos()
522:         LOCAL loc_oErro
523: 
524:         TRY
525:             *-- Say1 "Codigo de Origem :"
526:             THIS.AddObject("lbl_4c_Label1", "Label")
527:             WITH THIS.lbl_4c_Label1
528:                 .FontName  = "Tahoma"
529:                 .FontSize  = 8
530:                 .Caption   = "C" + CHR(243) + "digo de Origem :"
531:                 .Height    = 15
532:                 .Left      = 98
533:                 .Top       = 93
534:                 .Width     = 94
535:                 .BackStyle = 0
536:                 .ForeColor = RGB(0, 0, 0)
537:                 .Visible   = .T.
538:             ENDWITH
539: 
540:             *-- GetOldCPro -> this_cCodProdOrigem (produto de ORIGEM, Enabled=.F.)
541:             THIS.AddObject("txt_4c_CodProdOrigem", "TextBox")
542:             WITH THIS.txt_4c_CodProdOrigem
543:                 .Value             = ""
544:                 .Height            = 23
545:                 .Left              = 197
546:                 .Top               = 89
547:                 .Width             = 108
548:                 .MaxLength         = 14
549:                 .SpecialEffect     = 1
550:                 .TabIndex          = 2
551:                 .Enabled           = .F.
552:                 .DisabledBackColor = RGB(251, 254, 226)
553:                 .DisabledForeColor = RGB(36, 84, 155)
554:                 .BorderColor       = RGB(0, 0, 0)
555:                 .Visible           = .T.
556:             ENDWITH
557: 
558:             *-- Say3 "Grupo de Origem :"
559:             THIS.AddObject("lbl_4c_Label3", "Label")
560:             WITH THIS.lbl_4c_Label3
561:                 .FontName  = "Tahoma"

*-- Linhas 653 a 723:
653:             *-- evento certo eh "LostFocus", NUNCA "KeyPress" (regra #47: um
654:             *-- handler ligado a KeyPress dispararia a consulta e a geracao do
655:             *-- codigo a cada caractere, e o usuario nao conseguiria terminar
656:             *-- de digitar o grupo). "Valid" nao eh confiavel em BINDEVENT de
657:             *-- TextBox (regra #3), e o legado nao tem KeyPress neste campo.
658:             *--
659:             *-- GotFocus reproduz o When do legado ("ThisForm.Antvalue =
660:             *-- This.Value"), que roda ANTES de o campo receber o foco e
661:             *-- guarda o valor anterior - eh ele que alimenta o guard de
662:             *-- "valor nao mudou" no inicio do Valid.
663:             BINDEVENT(THIS.txt_4c_GrupoDestino, "GotFocus", THIS, "GrupoDestinoGotFocus")
664:             BINDEVENT(THIS.txt_4c_GrupoDestino, "LostFocus", THIS, "ValidarGrupoDestino")
665:         CATCH TO loc_oErro
666:             MsgErro(loc_oErro.Message + CHR(13) + ;
667:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
668:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpRef.ConfigurarCamposCodigos")
669:         ENDTRY
670:     ENDPROC
671: 
672:     *--------------------------------------------------------------------------
673:     * ConfigurarCamposRestantes - Fase 6/8 (segunda metade dos campos): as
674:     * duas linhas de Descricao (Say7/getolddpro = ORIGEM, Say6/getnewdpro =
675:     * DESTINO - os captions de Say6/Say7 no dump SAO "C"+CHR(243)+"digo de
676:     * Destino :"/"C"+CHR(243)+"digo de Origem :", duplicando literalmente
677:     * Say5/Say1: peculiaridade do SCX legado, transcrita 1:1 - regra PILAR 1,
678:     * nao se "corrige" rotulo do legado), a linha de Quantidade (Say4/
679:     * Get_Qtd) e a linha de Situacao (Say19/Opc_situacao), alem dos dois
680:     * labels de status (lblOk/lblNotOk) que o legado cria mas nunca exibe
681:     * (ver nota no cabecalho do arquivo - ficam sempre Visible = .F.).
682:     *--------------------------------------------------------------------------
683:     PROTECTED PROCEDURE ConfigurarCamposRestantes()
684:         LOCAL loc_oErro
685: 
686:         TRY
687:             *-- Say7 "Codigo de Origem :" (rotulo da linha de Descricao ORIGEM)
688:             THIS.AddObject("lbl_4c_Label7", "Label")
689:             WITH THIS.lbl_4c_Label7
690:                 .FontName  = "Tahoma"
691:                 .FontSize  = 8
692:                 .Caption   = "C" + CHR(243) + "digo de Origem :"
693:                 .Height    = 15
694:                 .Left      = 98
695:                 .Top       = 170
696:                 .Width     = 94
697:                 .BackStyle = 0
698:                 .ForeColor = RGB(0, 0, 0)
699:                 .Visible   = .T.
700:             ENDWITH
701: 
702:             *-- getolddpro -> this_cDescProdOrigem (produto de ORIGEM, Enabled=.F.)
703:             THIS.AddObject("txt_4c_DescProdOrigem", "TextBox")
704:             WITH THIS.txt_4c_DescProdOrigem
705:                 .Value             = ""
706:                 .Height            = 23
707:                 .Left              = 196
708:                 .Top               = 166
709:                 .Width             = 290
710:                 .SpecialEffect     = 1
711:                 .TabIndex          = 4
712:                 .Enabled           = .F.
713:                 .DisabledBackColor = RGB(251, 254, 226)
714:                 .DisabledForeColor = RGB(36, 84, 155)
715:                 .BorderColor       = RGB(0, 0, 0)
716:                 .Visible           = .T.
717:             ENDWITH
718: 
719:             *-- Say6 "Codigo de Destino :" (rotulo da linha de Descricao DESTINO)
720:             THIS.AddObject("lbl_4c_Label6", "Label")
721:             WITH THIS.lbl_4c_Label6
722:                 .FontName  = "Tahoma"
723:                 .FontSize  = 8

*-- Linhas 800 a 1140:
800: 
801:             *-- Opc_situacao -> this_nSituacao (ControlSource numerico direto:
802:             *-- Value = 1 Ativo / 2 Inativo, sem +1/-1 - regra #188)
803:             THIS.AddObject("opt_4c_Situacao", "OptionGroup")
804:             WITH THIS.opt_4c_Situacao
805:                 .Top           = 143
806:                 .Left          = 190
807:                 .Width         = 129
808:                 .Height        = 17
809:                 .ButtonCount   = 2
810:                 .AutoSize      = .F.
811:                 .BackStyle     = 0
812:                 .BorderStyle   = 0
813:                 .Value         = 1
814:                 .Visible       = .T.
815: 
816:                 WITH .Buttons(1)
817:                     .FontName  = "Comic Sans MS"
818:                     .FontSize  = 8
819:                     .BackStyle = 0
820:                     .Caption   = "Ativ\<o"
821:                     .Height    = 15
822:                     .Left      = 5
823:                     .Top       = 1
824:                     .Width     = 43
825:                     .ForeColor = RGB(0, 0, 0)
826:                 ENDWITH
827: 
828:                 WITH .Buttons(2)
829:                     .FontName  = "Comic Sans MS"
830:                     .FontSize  = 8
831:                     .BackStyle = 0
832:                     .Caption   = "I\<nativo"
833:                     .Height    = 17
834:                     .Left      = 63
835:                     .Top       = 0
836:                     .Width     = 61
837:                     .ForeColor = RGB(0, 0, 0)
838:                 ENDWITH
839:             ENDWITH
840: 
841:             *-- lblNotOk - dead code no legado (nunca recebe .Visible = .T. em
842:             *-- nenhum metodo do SCX) - criado para fidelidade estrutural, mas
843:             *-- permanece OCULTO para sempre (ver TornarControlesVisiveis).
844:             THIS.AddObject("lbl_4c_LblNotOk", "Label")
845:             WITH THIS.lbl_4c_LblNotOk
846:                 .FontBold   = .T.
847:                 .FontItalic = .F.
848:                 .FontName   = "Tahoma"
849:                 .FontSize   = 9
850:                 .Alignment  = 2
851:                 .BackStyle  = 0
852:                 .Caption    = "Novo Produto N" + CHR(227) + "o Foi Criado!"
853:                 .Height     = 17
854:                 .Left       = 147
855:                 .Top        = 226
856:                 .Width      = 306
857:                 .ForeColor  = RGB(192, 46, 20)
858:                 .Visible    = .F.
859:             ENDWITH
860: 
861:             *-- lblOk - mesma situacao: dead code, permanece OCULTO para sempre.
862:             THIS.AddObject("lbl_4c_LblOk", "Label")
863:             WITH THIS.lbl_4c_LblOk
864:                 .FontBold   = .T.
865:                 .FontItalic = .F.
866:                 .FontName   = "Tahoma"
867:                 .FontSize   = 9
868:                 .Alignment  = 2
869:                 .BackStyle  = 0
870:                 .Caption    = "Novo Produto Criado!"
871:                 .Height     = 37
872:                 .Left       = 144
873:                 .Top        = 239
874:                 .Width      = 306
875:                 .ForeColor  = RGB(0, 128, 0)
876:                 .Visible    = .F.
877:             ENDWITH
878:         CATCH TO loc_oErro
879:             MsgErro(loc_oErro.Message + CHR(13) + ;
880:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
881:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpRef.ConfigurarCamposRestantes")
882:         ENDTRY
883:     ENDPROC
884: 
885:     *--------------------------------------------------------------------------
886:     * BOParaForm - Copia as properties do Business Object (ja carregadas por
887:     * CarregarProdutoOrigem) para os controles de tela. Equivalente ao bloco
888:     * final do Init legado que preenche GetOldCPro/GetOldCGrus/getNewCGrus/
889:     * getOldDpro/Get_Qtd e trava Opc_situacao quando a Situacao foi fixada
890:     * por parametro (pSit = 1 ou 2).
891:     *--------------------------------------------------------------------------
892:     PROTECTED PROCEDURE BOParaForm()
893:         LOCAL loc_oBO
894: 
895:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
896:             RETURN
897:         ENDIF
898:         loc_oBO = THIS.this_oBusinessObject
899: 
900:         *-- Produto de ORIGEM (somente exibicao)
901:         THIS.txt_4c_CodProdOrigem.Value  = ALLTRIM(NVL(loc_oBO.this_cCodProdOrigem, ""))
902:         THIS.txt_4c_GrupoOrigem.Value    = ALLTRIM(NVL(loc_oBO.this_cGrupoOrigem, ""))
903:         THIS.txt_4c_DescProdOrigem.Value = ALLTRIM(NVL(loc_oBO.this_cDescProdOrigem, ""))
904: 
905:         *-- Produto NOVO (editavel pelo usuario)
906:         THIS.txt_4c_CodProdDestino.Value  = ALLTRIM(NVL(loc_oBO.this_cCodProdDestino, ""))
907:         THIS.txt_4c_GrupoDestino.Value    = ALLTRIM(NVL(loc_oBO.this_cGrupoDestino, ""))
908:         THIS.txt_4c_DescProdDestino.Value = ALLTRIM(NVL(loc_oBO.this_cDescProdDestino, ""))
909:         THIS.txt_4c_Quantidade.Value      = IIF(VARTYPE(loc_oBO.this_nQuantidade) = "N" AND loc_oBO.this_nQuantidade > 0, loc_oBO.this_nQuantidade, 1)
910:         THIS.opt_4c_Situacao.Value        = IIF(INLIST(loc_oBO.this_nSituacao, 1, 2), loc_oBO.this_nSituacao, 1)
911: 
912:         *-- legado: If (.Situacaoit = 1) Or (.Situacaoit = 2) -> Opc_situacao.Enabled = .f.
913:         THIS.opt_4c_Situacao.Enabled = !(loc_oBO.this_nSituacaoIt = 1 OR loc_oBO.this_nSituacaoIt = 2)
914: 
915:         *-- legado (Init), bloco que fecha o preenchimento da tela:
916:         *--   If (csTmpGru.DigGprs <> 1) Or .SaiAuto
917:         *--       .AcesGru = .f.
918:         *--       .GetNewCGrus.Valid()
919:         *--       .GetNewCGrus.ReadOnly = .t.
920:         *--   Else
921:         *--       .AcesGru = .t.
922:         *--       .GetNewCGrus.ReadOnly = .f.
923:         *--       .GetNewCGrus.Setfocus
924:         *--   EndIf
925:         THIS.AplicarEstadoGrupoDestino()
926:     ENDPROC
927: 
928:     *--------------------------------------------------------------------------
929:     * FormParaBO - Copia os campos editaveis de tela para o Business Object,
930:     * imediatamente antes de validar/gravar (equivalente a leitura de
931:     * Thisform.getNewCpro/getNewCGrus/getnewdpro/Get_Qtd/Opc_situacao no
932:     * inicio de btnConfirmar.Click). Chamado pelo handler de Confirmar na
933:     * Fase 7.
934:     *--------------------------------------------------------------------------
935:     PROTECTED PROCEDURE FormParaBO()
936:         LOCAL loc_oBO
937: 
938:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
939:             RETURN
940:         ENDIF
941:         loc_oBO = THIS.this_oBusinessObject
942: 
943:         loc_oBO.this_cCodProdDestino  = ALLTRIM(NVL(THIS.txt_4c_CodProdDestino.Value, ""))
944:         loc_oBO.this_cGrupoDestino    = ALLTRIM(NVL(THIS.txt_4c_GrupoDestino.Value, ""))
945:         loc_oBO.this_cDescProdDestino = ALLTRIM(NVL(THIS.txt_4c_DescProdDestino.Value, ""))
946:         loc_oBO.this_nQuantidade      = IIF(VARTYPE(THIS.txt_4c_Quantidade.Value) = "N", THIS.txt_4c_Quantidade.Value, VAL(THIS.txt_4c_Quantidade.Value))
947:         loc_oBO.this_nSituacao        = THIS.opt_4c_Situacao.Value
948:     ENDPROC
949: 
950:     *--------------------------------------------------------------------------
951:     * AplicarEstadoGrupoDestino - Transcricao do bloco final do Init legado
952:     * que decide se o GRUPO de destino eh digitavel e, quando nao eh, ja
953:     * dispara a geracao do codigo:
954:     *
955:     *   If (csTmpGru.DigGprs <> 1) Or .SaiAuto
956:     *       .AcesGru = .f.
957:     *       .GetNewCGrus.Valid()
958:     *       .GetNewCGrus.ReadOnly = .t.
959:     *   Else
960:     *       .AcesGru = .t.
961:     *       .GetNewCGrus.ReadOnly = .f.
962:     *       .GetNewCGrus.Setfocus
963:     *   EndIf
964:     *
965:     * O SetFocus so faz sentido com a tela ja visivel; em modo de teste
966:     * automatizado (sem Show) ele eh dispensado, igual as demais consultas.
967:     *--------------------------------------------------------------------------
968:     PROCEDURE AplicarEstadoGrupoDestino()
969:         LOCAL loc_oBO, loc_lModoTeste
970: 
971:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
972:             RETURN
973:         ENDIF
974:         loc_oBO = THIS.this_oBusinessObject
975: 
976:         loc_lModoTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
977:             (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
978: 
979:         IF loc_oBO.this_nGrupoDestinoDigGprs != 1 OR loc_oBO.this_lSaiAuto
980:             loc_oBO.this_lAcesGru = .F.
981: 
982:             *-- legado: .GetNewCGrus.Valid() - a geracao do codigo roda JA no
983:             *-- Init quando o usuario nao tem acesso a digitar o grupo.
984:             THIS.ValidarGrupoDestino()
985: 
986:             THIS.txt_4c_GrupoDestino.ReadOnly = .T.
987:         ELSE
988:             loc_oBO.this_lAcesGru = .T.
989:             THIS.txt_4c_GrupoDestino.ReadOnly = .F.
990: 
991:             IF !loc_lModoTeste AND THIS.Visible AND THIS.txt_4c_GrupoDestino.Enabled
992:                 THIS.txt_4c_GrupoDestino.SetFocus()
993:             ENDIF
994:         ENDIF
995: 
996:         THIS.AjustarCamposPorEstado()
997:     ENDPROC
998: 
999:     *--------------------------------------------------------------------------
1000:     * AjustarCamposPorEstado - Reproduz os tres PROCEDURE When do legado, que
1001:     * controlam quais campos aceitam digitacao conforme o estado do processo:
1002:     *
1003:     *   getNewCpro.When  -> Return Not ThisForm.Automatico
1004:     *   getNewCGrus.When -> Return (ThisForm.AcesGru)
1005:     *   Get_Qtd.When     -> Return (ThisForm.Automatico And Not ThisForm.SaiAuto)
1006:     *
1007:     * Em VFP9 o When de um controle criado por AddObject nao eh alcancavel por
1008:     * BINDEVENT de forma confiavel (e BINDEVENT descarta o retorno do
1009:     * delegate, logo um When ligado assim nao bloquearia nada - regra #3).
1010:     * O equivalente fiel eh traduzir cada When para .Enabled e reaplicar
1011:     * sempre que o estado muda: no fim do BOParaForm (via
1012:     * AplicarEstadoGrupoDestino) e no fim de ValidarGrupoDestino, que sao os
1013:     * dois unicos pontos onde Automatico/AcesGru mudam.
1014:     *
1015:     * PUBLIC de proposito (regra #3/#51): e chamado pelos handlers ligados por
1016:     * BINDEVENT e pode ser acionado pelo harness de teste automatizado.
1017:     *--------------------------------------------------------------------------
1018:     PROCEDURE AjustarCamposPorEstado()
1019:         LOCAL loc_oBO
1020: 
1021:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1022:             RETURN
1023:         ENDIF
1024:         loc_oBO = THIS.this_oBusinessObject
1025: 
1026:         *-- getNewCpro.When: Return Not ThisForm.Automatico
1027:         THIS.txt_4c_CodProdDestino.Enabled = !loc_oBO.this_lAutomatico
1028: 
1029:         *-- getNewCGrus.When: Return (ThisForm.AcesGru)
1030:         THIS.txt_4c_GrupoDestino.Enabled = loc_oBO.this_lAcesGru
1031: 
1032:         *-- Get_Qtd.When: Return (ThisForm.Automatico And Not ThisForm.SaiAuto)
1033:         THIS.txt_4c_Quantidade.Enabled = (loc_oBO.this_lAutomatico AND !loc_oBO.this_lSaiAuto)
1034:     ENDPROC
1035: 
1036:     *--------------------------------------------------------------------------
1037:     * GrupoDestinoGotFocus - Reproduz a primeira linha do getNewCGrus.When do
1038:     * legado ("ThisForm.Antvalue = This.Value"), que roda ANTES de o campo
1039:     * receber o foco e guarda o valor que esta la. E esse valor que o guard do
1040:     * inicio do Valid compara para nao repetir a consulta/geracao quando o
1041:     * usuario entra e sai do campo sem alterar nada.
1042:     *
1043:     * PUBLIC: ligado por BINDEVENT (regra #3 - PROTECTED falha em silencio).
1044:     *--------------------------------------------------------------------------
1045:     PROCEDURE GrupoDestinoGotFocus()
1046:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1047:             THIS.this_oBusinessObject.this_cAntValue = ALLTRIM(NVL(THIS.txt_4c_GrupoDestino.Value, ""))
1048:         ENDIF
1049:     ENDPROC
1050: 
1051:     *--------------------------------------------------------------------------
1052:     * ValidarGrupoDestino - Handler do campo "Grupo de Destino", equivalente ao
1053:     * PROCEDURE Valid do getNewCGrus legado:
1054:     *
1055:     *   If (ThisForm.AntValue = This.Value) And Not Empty(Thisform.GetNewCpro.Value)
1056:     *       Return .t.
1057:     *   EndIf
1058:     *   ThisForm.Automatico = .f.
1059:     *   lcCGrus = Alltrim(This.Value)
1060:     *   ... (consulta SigCdGrp / SigCdGpr e monta lcNewCPros) ...
1061:     *   With ThisForm
1062:     *       .getNewCpro.Value = lcNewCPros
1063:     *       .getNewCpro.Refresh
1064:     *   EndWith
1065:     *   If Not Empty(lcnewCpros)
1066:     *       ThisForm.Automatico = .t.
1067:     *   EndIf
1068:     *
1069:     * O calculo propriamente dito (a REGRA DE NEGOCIO: tipo de geracao,
1070:     * mascaras, fGerUniqueKey) fica no Business Object
1071:     * (SigOpRefBO.GerarCodigoProdutoDestino), transcrito linha a linha do
1072:     * legado - aqui ficam so o guard de "valor nao mudou", a leitura/escrita
1073:     * dos controles e a flag Automatico, que sao responsabilidade da tela.
1074:     *
1075:     * IMPORTANTE (regra #50): grupo cujo tipo de geracao NAO produz codigo
1076:     * automatico (lnTpPro fora de {2,4,5}) devolve "" e o legado grava esse ""
1077:     * no campo do codigo, deixando Automatico = .F. para o usuario digitar a
1078:     * mao - nao eh erro, nao avisa nada e NAO se apaga o grupo digitado.
1079:     *
1080:     * PUBLIC: ligado por BINDEVENT (regra #3) e chamado por
1081:     * AplicarEstadoGrupoDestino, que reproduz o ".GetNewCGrus.Valid()" do Init.
1082:     *--------------------------------------------------------------------------
1083:     PROCEDURE ValidarGrupoDestino()
1084:         LOCAL loc_oBO, loc_cGrus, loc_cNewCPros, loc_lModoTeste, ;
1085:             loc_lProsseguir, loc_oErro
1086:         loc_lProsseguir = .T.
1087: 
1088:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1089:             RETURN
1090:         ENDIF
1091: 
1092:         *-- Guarda de reentrancia: o handler esta ligado a LostFocus e escreve
1093:         *-- no .Value/.Enabled de outros campos, o que pode devolver o foco a
1094:         *-- este - sem a guarda o LostFocus redispararia a consulta.
1095:         IF THIS.this_lEmValidacaoGrupo
1096:             RETURN
1097:         ENDIF
1098: 
1099:         *-- Sem conexao (harness de teste automatizado / ValidarUIFidelity) a
1100:         *-- consulta nao roda - mesma excecao de InicializarForm.
1101:         loc_lModoTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
1102:             (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
1103: 
1104:         IF loc_lModoTeste
1105:             RETURN
1106:         ENDIF
1107: 
1108:         loc_oBO   = THIS.this_oBusinessObject
1109:         loc_cGrus = ALLTRIM(NVL(THIS.txt_4c_GrupoDestino.Value, ""))
1110: 
1111:         *-- legado: If (ThisForm.AntValue = This.Value) And Not
1112:         *--             Empty(Thisform.GetNewCpro.Value) -> Return .t.
1113:         IF ALLTRIM(NVL(loc_oBO.this_cAntValue, "")) == loc_cGrus AND ;
1114:                 !EMPTY(ALLTRIM(NVL(THIS.txt_4c_CodProdDestino.Value, "")))
1115:             RETURN
1116:         ENDIF
1117: 
1118:         *-- A partir daqui o corpo roda sob TRY/CATCH: o handler eh disparado
1119:         *-- por LostFocus, fora de qualquer TRY do form, e sem isto uma falha
1120:         *-- aqui apareceria como "Program Error" CRU do VFP em vez do dialogo
1121:         *-- do sistema. A flag de reentrancia eh liberada DEPOIS do ENDTRY,
1122:         *-- para valer tambem quando o CATCH dispara (senao ela travaria ligada
1123:         *-- e mataria a validacao pelo resto da vida do form).
1124:         THIS.this_lEmValidacaoGrupo = .T.
1125: 
1126:         TRY
1127:             *-- legado: ThisForm.Automatico = .f. (antes de tentar gerar)
1128:             loc_oBO.this_lAutomatico   = .F.
1129:             loc_oBO.this_cGrupoDestino = loc_cGrus
1130: 
1131:             loc_cNewCPros = loc_oBO.GerarCodigoProdutoDestino(loc_cGrus)
1132: 
1133:             *-- legado: .getNewCpro.Value = lcNewCPros / .getNewCpro.Refresh
1134:             *-- (atribui MESMO vazio - e assim que o legado devolve o campo ao
1135:             *-- usuario quando o grupo nao gera codigo automatico)
1136:             loc_oBO.this_cCodProdDestino      = loc_cNewCPros
1137:             THIS.txt_4c_CodProdDestino.Value  = loc_cNewCPros
1138:             THIS.txt_4c_CodProdDestino.Refresh()
1139: 
1140:             *-- legado: If Not Empty(lcnewCpros) -> ThisForm.Automatico = .t.

*-- Linhas 1155 a 1198:
1155: 
1156:             MsgErro(loc_oErro.Message + CHR(13) + ;
1157:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1158:                 "Procedure: " + loc_oErro.Procedure, ;
1159:                 "Erro em FormSigOpRef.ValidarGrupoDestino")
1160:         ENDTRY
1161: 
1162:         THIS.this_lEmValidacaoGrupo = .F.
1163: 
1164:         RETURN loc_lProsseguir
1165:     ENDPROC
1166: 
1167:     *--------------------------------------------------------------------------
1168:     * CarregarProdutoOrigem - Equivalente a CursorQuery([SigCdPro],[csTmpPro],
1169:     * [CPros],pPro,[CPros,CGrus,Dpros]) do Init legado: busca o produto de
1170:     * origem por codigo e delega ao Business Object (CarregarDoCursor, ja
1171:     * escrito na Fase 1/2), que mapeia Cpros/Cgrus/Dpros para as properties
1172:     * do produto de ORIGEM. Tambem repassa os demais parametros recebidos em
1173:     * Init() (situacao/saiauto/identfixa/cadpro/dopes) e inicializa o grupo
1174:     * de destino igual ao grupo de origem quando nenhum foi informado -
1175:     * mesma regra do legado (lcGrp = Iif(Type(pGru)=C, pGru, csTmpPro.Cgrus)).
1176:     *
1177:     * Se o produto de origem nao existir, aborta - exatamente como o legado
1178:     * fazia ao nao conseguir popular csTmpPro (MessageBox + Return .f.).
1179:     *--------------------------------------------------------------------------
1180:     PROTECTED FUNCTION CarregarProdutoOrigem()
1181:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
1182:         loc_lSucesso = .F.
1183: 
1184:         TRY
1185:             IF USED("cursor_4c_ProdOrigemRef")
1186:                 USE IN cursor_4c_ProdOrigemRef
1187:             ENDIF
1188: 
1189:             loc_cSQL = "SELECT cpros, cgrus, dpros FROM SigCdPro WHERE cpros = " + ;
1190:                 EscaparSQL(PADR(ALLTRIM(THIS.this_cParCodProdOrigem), 14))
1191: 
1192:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdOrigemRef")
1193: 
1194:             IF loc_nResultado < 0
1195:                 MsgErro("Erro ao consultar o produto de origem:" + CHR(13) + ;
1196:                     CapturarErroSQL(), "Erro SQL")
1197:                 loc_lSucesso = .F.
1198:             ELSE

*-- Linhas 1242 a 1329:
1242:         CATCH TO loc_oErro
1243:             MsgErro(loc_oErro.Message + CHR(13) + ;
1244:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1245:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpRef.CarregarProdutoOrigem")
1246:             loc_lSucesso = .F.
1247:         ENDTRY
1248: 
1249:         RETURN loc_lSucesso
1250:     ENDFUNC
1251: 
1252:     *--------------------------------------------------------------------------
1253:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1254:     * (AddObject cria com Visible=.F. por padrao). Itera Controls e, se algum
1255:     * for PageFrame, tambem as Pages dele (este form nao tem PageFrame, mas o
1256:     * metodo fica generico para reaproveitar nas fases seguintes).
1257:     *
1258:     * EXCECAO: lbl_4c_LblOk/lbl_4c_LblNotOk (lblOk/lblNotOk do legado) nunca
1259:     * recebem .Visible = .T. em NENHUM metodo do SCX original (Init,
1260:     * btnConfirmar.Click, btnSair.Click) - sao dead code herdado, e tornar
1261:     * esses dois visiveis aqui faria a tela mostrar algo que o legado jamais
1262:     * mostrou. Mesma tecnica de "containers flutuantes" do guia de migracao.
1263:     *--------------------------------------------------------------------------
1264:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1265:         LOCAL loc_nI, loc_oControl, loc_nP
1266: 
1267:         IF VARTYPE(par_oContainer) != "O"
1268:             RETURN
1269:         ENDIF
1270: 
1271:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1272:             loc_oControl = par_oContainer.Controls(loc_nI)
1273: 
1274:             IF INLIST(UPPER(loc_oControl.Name), "LBL_4C_LBLOK", "LBL_4C_LBLNOTOK")
1275:                 LOOP
1276:             ENDIF
1277: 
1278:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1279:                 loc_oControl.Visible = .T.
1280:             ENDIF
1281: 
1282:             IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1283:                 FOR loc_nP = 1 TO loc_oControl.PageCount
1284:                     THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
1285:                 ENDFOR
1286:             ENDIF
1287: 
1288:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1289:                 THIS.TornarControlesVisiveis(loc_oControl)
1290:             ENDIF
1291:         ENDFOR
1292:     ENDPROC
1293: 
1294: 
1295:     *--------------------------------------------------------------------------
1296:     * BtnConfirmarClick - Fase 7/8. Handler do botao "Salvar"
1297:     * (cntBotoes.btnConfirmar do legado), a acao principal do dialogo: gera o
1298:     * PRODUTO NOVO a partir do produto de origem. Transcricao do
1299:     * btnConfirmar.Click legado, na MESMA ordem:
1300:     *
1301:     *   lcNewPros = Padr(Thisform.getNewCpro.Value, 14)
1302:     *   lcLocGrus = Padr(Thisform.getOldCGrus.Value, 03)
1303:     *   lcNewGrus = Padr(Thisform.getNewCGrus.Value, 03)
1304:     *   ThisForm.RetCodproduto = ' '
1305:     *   CursorQuery('SigCdPro','crTmp','CPros',lcNewPros)
1306:     *   If (Reccount('crTmp') > 0)
1307:     *       =MessageBox('A Nova Referencia Informada Ja Esta Cadastrada!!!',48)
1308:     *       Thisform.getNewCpro.SetFocus
1309:     *       Return 0
1310:     *   EndIf
1311:     *   If Empty(lcNewPros) Or fVerificarBarras(lcNewPros, crSigCdPam.TpCBars)
1312:     *       =MessageBox('Codigo de Produto Invalido!!!', 48)
1313:     *       Return 0
1314:     *   EndIf
1315:     *   If Not ThisForm.SaiAuto And MessageBox('Sera Gerado Um Novo Produto
1316:     *            ... Confirma a Geracao ?', 4+32+256, ...) <> 6
1317:     *       Wait Window 'Operacao Cancelada Pelo Usuario...' timeOut 2
1318:     *       Wait Clear
1319:     *       Return 0
1320:     *   EndIf
1321:     *   ... (copia de SigPrCpo / SigCdPrf / SigCdPro) ...
1322:     *   ThisForm.RetCodproduto = ' '
1323:     *   If ThisForm.mSv_Inserir()
1324:     *       ThisForm.retcodproduto = Padr(lcNewPros,14) + Str(Get_Qtd.Value,2)
1325:     *   EndIf
1326:     *   ThisForm.Release
1327:     *
1328:     * A COPIA em si (os tres Zap/Scatter/Insert mais o mSv_Inserir) esta toda
1329:     * no Business Object (SigOpRefBO.Inserir, Fase 2), chamada pelo par

*-- Linhas 1349 a 1445:
1349:     * gravou, o retorno fica vazio e eh assim que o chamador descobre
1350:     * ("If Not Empty(lcCodProduto)").
1351:     *
1352:     * PUBLIC: ligado por BINDEVENT em Buttons(1).Click (regra #3 - handler
1353:     * PROTECTED falha em silencio) e chamado pelo disparo automatico do
1354:     * SaiAuto em InicializarForm.
1355:     *--------------------------------------------------------------------------
1356:     PROCEDURE BtnConfirmarClick()
1357:         LOCAL loc_oBO, loc_cNovo, loc_cGrupoNovo, loc_cGrupoOrigem, ;
1358:             loc_cMsg, loc_cLinhaGrupo, loc_lProsseguir, loc_oErro
1359: 
1360:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1361:             RETURN
1362:         ENDIF
1363: 
1364:         *-- Guarda de reentrancia: cada passagem GERA UM PRODUTO. Liberada
1365:         *-- DEPOIS do ENDTRY para valer tambem quando o CATCH dispara (senao
1366:         *-- travaria ligada e mataria o botao pelo resto da vida do form).
1367:         IF THIS.this_lEmGravacao
1368:             RETURN
1369:         ENDIF
1370: 
1371:         THIS.this_lEmGravacao = .T.
1372:         loc_lProsseguir       = .T.
1373: 
1374:         TRY
1375:             loc_oBO = THIS.this_oBusinessObject
1376: 
1377:             *-- legado: as tres primeiras linhas do Click leem a tela
1378:             THIS.FormParaBO()
1379: 
1380:             *-- legado: ThisForm.RetCodproduto = ' '
1381:             loc_oBO.this_cRetCodProduto = " "
1382:             THIS.this_cRetCodProduto    = " "
1383: 
1384:             loc_cNovo        = PADR(ALLTRIM(NVL(THIS.txt_4c_CodProdDestino.Value, "")), 14)
1385:             loc_cGrupoOrigem = PADR(ALLTRIM(NVL(THIS.txt_4c_GrupoOrigem.Value, "")), 3)
1386:             loc_cGrupoNovo   = PADR(ALLTRIM(NVL(THIS.txt_4c_GrupoDestino.Value, "")), 3)
1387: 
1388:             *-- legado: a Nova Referencia ja esta cadastrada -> avisa, devolve
1389:             *-- o foco ao campo do codigo e NAO fecha a tela
1390:             IF loc_oBO.ExisteProduto(loc_cNovo)
1391:                 MsgAviso("A Nova Refer" + CHR(234) + "ncia Informada J" + ;
1392:                     CHR(225) + " Est" + CHR(225) + " Cadastrada!!!", ;
1393:                     "Aten" + CHR(231) + CHR(227) + "o")
1394: 
1395:                 IF THIS.Visible AND THIS.txt_4c_CodProdDestino.Enabled AND ;
1396:                         THIS.txt_4c_CodProdDestino.Visible
1397:                     THIS.txt_4c_CodProdDestino.SetFocus()
1398:                 ENDIF
1399: 
1400:                 loc_lProsseguir = .F.
1401:             ENDIF
1402: 
1403:             *-- legado: If Empty(lcNewPros) Or fVerificarBarras(...)
1404:             IF loc_lProsseguir AND EMPTY(ALLTRIM(loc_cNovo))
1405:                 MsgAviso("C" + CHR(243) + "digo de Produto Inv" + CHR(225) + ;
1406:                     "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1407:                 loc_lProsseguir = .F.
1408:             ENDIF
1409: 
1410:             *-- legado: a confirmacao so eh pedida quando NAO eh processamento
1411:             *-- automatico (SaiAuto), e a linha do grupo so entra na mensagem
1412:             *-- quando o grupo de destino foi informado E mudou
1413:             IF loc_lProsseguir AND !loc_oBO.this_lSaiAuto
1414:                 loc_cLinhaGrupo = ""
1415:                 IF !EMPTY(ALLTRIM(loc_cGrupoNovo)) AND loc_cGrupoOrigem <> loc_cGrupoNovo
1416:                     loc_cLinhaGrupo = "O Grupo Gerado Ser" + CHR(225) + " o [" + ;
1417:                         ALLTRIM(loc_cGrupoNovo) + "]"
1418:                 ENDIF
1419: 
1420:                 loc_cMsg = "Ser" + CHR(225) + " Gerado Um Novo Produto Com a " + ;
1421:                         "Refer" + CHR(234) + "ncia : [" + loc_cNovo + "]" + CHR(13) + ;
1422:                     "Com a Situa" + CHR(231) + CHR(227) + "o : [" + ;
1423:                         IIF(THIS.opt_4c_Situacao.Value = 1, "ATIVA", ;
1424:                             "N" + CHR(195) + "O ATIVA") + "]" + CHR(13) + ;
1425:                     loc_cLinhaGrupo + CHR(13) + ;
1426:                     "Confirma a Gera" + CHR(231) + CHR(227) + "o ?"
1427: 
1428:                 IF !MsgConfirma(loc_cMsg, "Solicita" + CHR(231) + CHR(227) + ;
1429:                         "o de Confirma" + CHR(231) + CHR(227) + "o...")
1430:                     WAIT WINDOW "Opera" + CHR(231) + CHR(227) + "o Cancelada " + ;
1431:                         "Pelo Usu" + CHR(225) + "rio..." TIMEOUT 2
1432:                     WAIT CLEAR
1433:                     loc_lProsseguir = .F.
1434:                 ENDIF
1435:             ENDIF
1436: 
1437:             IF loc_lProsseguir
1438:                 *-- Par canonico: este dialogo SEMPRE inclui (nao ha ramo de
1439:                 *-- alteracao no legado), entao NovoRegistro() deixa o BO em
1440:                 *-- modo de edicao/novo e Salvar() delega a Inserir(), que faz
1441:                 *-- a copia inteira (SigCdPro + SigPrCpo + SigCdPrf) num unico
1442:                 *-- lote transacionado e ja preenche this_cRetCodProduto no
1443:                 *-- formato do legado (Padr(cod,14) + Str(qtd,2)).
1444:                 loc_oBO.NovoRegistro()
1445: 

*-- Linhas 1456 a 1670:
1456:         CATCH TO loc_oErro
1457:             MsgErro(loc_oErro.Message + CHR(13) + ;
1458:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1459:                 "Procedure: " + loc_oErro.Procedure, ;
1460:                 "Erro em FormSigOpRef.BtnConfirmarClick")
1461:         ENDTRY
1462: 
1463:         THIS.this_lEmGravacao = .F.
1464:     ENDPROC
1465: 
1466:     *--------------------------------------------------------------------------
1467:     * BtnCancelarClick - Fase 7/8. Handler do botao "Cancelar"
1468:     * (cntBotoes.btnSair do legado, Cancel = .T. / tecla [Esc]).
1469:     *
1470:     * NOME: batizado pelo PAPEL do botao (Caption = "\<Cancelar", ToolTipText
1471:     * "[Esc] Sair Sem Gravar os Dados"), que eh o nome canonico do projeto para
1472:     * o botao de abandono, e nao pelo nome do objeto legado (btnSair) - o
1473:     * PILAR 3 manda nomes DIFERENTES do legado de qualquer forma, e o Caption
1474:     * continua transcrito do dump (PILAR 1). Mesma decisao ja tomada para o
1475:     * botao de gravar em outros forms da familia.
1476:     *
1477:     * NAO eh um simples "fecha a tela": antes de sair ele DEVOLVE ao contador o
1478:     * sequencial que a geracao do codigo havia reservado, para o numero nao
1479:     * ficar queimado quando o usuario desiste.
1480:     *
1481:     * A regra (qual chave de contador devolver, conforme o tipo de geracao do
1482:     * grupo) mora no Business Object - SigOpRefBO.CancelarCodigoReservado eh a
1483:     * inversa exata de GerarCodigoProdutoDestino e esta transcrita linha a
1484:     * linha do btnSair.Click legado. Aqui ficam so a leitura do controle e o
1485:     * fechamento, que sao responsabilidade da tela.
1486:     *
1487:     * legado:
1488:     *   ... =fCanUniqueKey(ThisForm.NewSeq, 'PRODUTO' + ...) ...
1489:     *   ThisForm.Retcodproduto = ' '
1490:     *   ThisForm.Release
1491:     *
1492:     * PUBLIC: ligado por BINDEVENT em Buttons(2).Click (regra #3).
1493:     *--------------------------------------------------------------------------
1494:     PROCEDURE BtnCancelarClick()
1495:         LOCAL loc_oBO, loc_oErro
1496: 
1497:         TRY
1498:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1499:                 loc_oBO = THIS.this_oBusinessObject
1500: 
1501:                 loc_oBO.CancelarCodigoReservado( ;
1502:                     ALLTRIM(NVL(THIS.txt_4c_GrupoDestino.Value, "")))
1503: 
1504:                 *-- legado: ThisForm.Retcodproduto = ' ' (sai sem gerar nada)
1505:                 loc_oBO.this_cRetCodProduto = " "
1506:             ENDIF
1507:         CATCH TO loc_oErro
1508:             *-- Falhar ao devolver o sequencial nao pode impedir a saida: o
1509:             *-- numero apenas fica queimado, que eh o desfecho seguro.
1510:             MsgAviso(loc_oErro.Message + CHR(13) + ;
1511:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1512:                 "Aviso em FormSigOpRef.BtnCancelarClick")
1513:         ENDTRY
1514: 
1515:         THIS.this_cRetCodProduto = " "
1516: 
1517:         *-- legado: ThisForm.Release
1518:         THIS.FecharDialogo()
1519:     ENDPROC
1520: 
1521:     *--------------------------------------------------------------------------
1522:     * FecharDialogo - FUNIL de fechamento ("Thisform.Release" do legado), com
1523:     * UMA divergencia deliberada de PILAR 3: fecha com Hide(), nao com
1524:     * Release().
1525:     *
1526:     * Medido no VFP9: THIS.Release() destroi o objeto mesmo havendo variavel
1527:     * externa apontando para ele - a referencia do chamador vira VARTYPE "X" e
1528:     * a leitura seguinte estoura "is not an object". Este dialogo existe para
1529:     * DEVOLVER o codigo do produto gerado, e no legado essa resposta chega
1530:     * pelo RETURN do evento Unload, que so alcanca quem abre com
1531:     * "DO FORM ... TO <var>" (eh exatamente o que SIGOPPRO e SIGMVCAB fazem:
1532:     * "DO Form SigOpRef With ... to lcCodPro" e tambem
1533:     * "... name loProduto linked noshow" + "Left(loProduto.Retcodproduto,14)").
1534:     * No sistema novo, que abre por CREATEOBJECT + Show(), esse retorno eh
1535:     * inalcancavel - ele vem por ObterRetorno(). Hide() em form modal tambem
1536:     * devolve o Show(), entao para o usuario a tela fecha igual (PILAR 1
1537:     * preservado); muda so o tempo de vida do objeto, e eh o CHAMADOR quem
1538:     * chama Release() depois de ler. Mesmo desenho que o FormBuscaAuxiliar do
1539:     * projeto ja adota.
1540:     *--------------------------------------------------------------------------
1541:     PROCEDURE FecharDialogo()
1542:         *-- Enquanto o Business Object ainda existe: guarda o retorno para o
1543:         *-- Unload, que so dispara depois de o Destroy ter zerado
1544:         *-- this_oBusinessObject.
1545:         THIS.CachearRetorno()
1546: 
1547:         THIS.Hide()
1548:     ENDPROC
1549: 
1550:     *--------------------------------------------------------------------------
1551:     * CachearRetorno - Copia para this_cRetCodProduto o retorno que o Business
1552:     * Object montou, enquanto ele ainda existe. Chamado no FUNIL de
1553:     * fechamento (FecharDialogo, por onde passam os dois botoes) e de novo no
1554:     * Destroy, antes do DODEFAULT que libera o BO.
1555:     *
1556:     * PROTECTED: nao eh ligado por BINDEVENT nem chamado de fora - quem le o
1557:     * resultado usa ObterRetorno(). Sempre com THIS. (regra #8).
1558:     *--------------------------------------------------------------------------
1559:     PROTECTED PROCEDURE CachearRetorno()
1560:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1561:             THIS.this_cRetCodProduto = THIS.this_oBusinessObject.ObterRetorno()
1562:         ENDIF
1563:     ENDPROC
1564: 
1565:     *--------------------------------------------------------------------------
1566:     * ObterRetorno - Contrato de retorno do dialogo, equivalente ao
1567:     * PROCEDURE Unload legado ("Return ThisForm.RetCodProduto").
1568:     *
1569:     * Formato do legado: PADR(codigo,14) + STR(quantidade,2). Vazio (ou um
1570:     * espaco) = nenhum produto foi gerado.
1571:     *
1572:     * COMO O CHAMADOR USA (o legado abria com "DO FORM SigOpRef With ... to
1573:     * lcCodPro", que entrega o retorno do Unload; o sistema novo abre por
1574:     * CREATEOBJECT + Show() e esse retorno eh inalcancavel, por isso ele vem
1575:     * por aqui):
1576:     *
1577:     *   loc_oRef = CREATEOBJECT("FormSigOpRef", loc_cCodProdOrigem, ;
1578:     *                           loc_nSituacao, .F.)
1579:     *   IF VARTYPE(loc_oRef) = "O"
1580:     *       loc_oRef.Show()                       && modal: bloqueia
1581:     *       loc_cRetorno = loc_oRef.ObterRetorno()
1582:     *   ENDIF
1583:     *   loc_cCodProduto = LEFT(loc_cRetorno, 14)
1584:     *   IF !EMPTY(loc_cCodProduto)
1585:     *       *-- produto gerado; VAL(SUBSTR(loc_cRetorno, 15)) = quantidade
1586:     *   ENDIF
1587:     *
1588:     * Com SaiAuto = .T. (processamento automatico) nao ha Show(): a copia
1589:     * roda dentro do proprio Init e o retorno ja esta pronto ao final do
1590:     * CREATEOBJECT - exatamente como o "noshow" do chamador legado.
1591:     *
1592:     * A ordem importa: o dialogo fecha com Hide() (ver FecharDialogo), entao
1593:     * continua legivel depois do Show(), e eh o CHAMADOR quem da o Release()
1594:     * - DEPOIS de ler.
1595:     *--------------------------------------------------------------------------
1596:     FUNCTION ObterRetorno()
1597:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1598:             THIS.this_cRetCodProduto = THIS.this_oBusinessObject.ObterRetorno()
1599:         ENDIF
1600: 
1601:         RETURN THIS.this_cRetCodProduto
1602:     ENDFUNC
1603: 
1604:     *--------------------------------------------------------------------------
1605:     * Destroy - Fecha os cursores que o form e o Business Object possam ter
1606:     * deixado abertos e guarda o retorno antes de o BO ser liberado.
1607:     *
1608:     * Todos os cursores abaixo sao fechados pelos proprios metodos que os
1609:     * criam; sao conferidos aqui so por seguranca, para o form nao vazar
1610:     * alias quando algum deles aborta no meio (CATCH).
1611:     *
1612:     * DODEFAULT() eh obrigatorio e fica por ULTIMO: FormBase.Destroy refaz os
1613:     * popups do menu principal, e omiti-lo encolhe o menu do sistema.
1614:     *--------------------------------------------------------------------------
1615:     PROCEDURE Destroy()
1616:         LOCAL loc_nI, loc_cAlias
1617:         LOCAL ARRAY loc_aCursores[8]
1618: 
1619:         loc_aCursores[1] = "cursor_4c_ProdOrigemRef"
1620:         loc_aCursores[2] = "cursor_4c_PamRef"
1621:         loc_aCursores[3] = "cursor_4c_GrpDestRef"
1622:         loc_aCursores[4] = "cursor_4c_GruProRef"
1623:         loc_aCursores[5] = "cursor_4c_GruCanRef"
1624:         loc_aCursores[6] = "cursor_4c_GprRef"
1625:         loc_aCursores[7] = "cursor_4c_ExisteProRef"
1626:         loc_aCursores[8] = "cursor_4c_OpCddRef"
1627: 
1628:         FOR loc_nI = 1 TO ALEN(loc_aCursores)
1629:             loc_cAlias = loc_aCursores[loc_nI]
1630: 
1631:             IF USED(loc_cAlias)
1632:                 *-- TABLEREVERT so com buffering ligado: sem ele a chamada nao
1633:                 *-- eh no-op, estoura "Function requires row or table buffering
1634:                 *-- mode" (regra #52). USE IN fecha o alias de qualquer forma.
1635:                 IF CURSORGETPROP("Buffering", loc_cAlias) > 1
1636:                     TABLEREVERT(.T., loc_cAlias)
1637:                 ENDIF
1638:                 USE IN (loc_cAlias)
1639:             ENDIF
1640:         ENDFOR
1641: 
1642:         *-- Ultima chance de guardar o retorno: o DODEFAULT abaixo chega a
1643:         *-- FormBase.Destroy, que faz this_oBusinessObject = .NULL., e o Unload
1644:         *-- (que devolve o valor a quem abriu com "DO FORM ... TO") so dispara
1645:         *-- DEPOIS disso.
1646:         THIS.CachearRetorno()
1647: 
1648:         DODEFAULT()
1649:     ENDPROC
1650: 
1651:     *--------------------------------------------------------------------------
1652:     * Unload - PROCEDURE Unload legado, mantido LITERAL para quem abrir este
1653:     * dialogo com "DO FORM ... TO <var>", forma em que o VFP entrega ao
1654:     * chamador justamente o retorno deste evento:
1655:     *
1656:     *   PROCEDURE Unload
1657:     *   Return ThisForm.RetCodProduto
1658:     *
1659:     * Le o CACHE e nao o BO: o Unload dispara DEPOIS do Destroy, e nesse
1660:     * ponto FormBase.Destroy ja fez this_oBusinessObject = .NULL. - perguntar
1661:     * ao BO aqui estouraria. Quem enche o cache eh CachearRetorno, chamado no
1662:     * fechamento e no Destroy.
1663:     *
1664:     * O caminho recomendado no sistema novo continua sendo CREATEOBJECT +
1665:     * Show() + ObterRetorno(), que nao depende do ciclo de destruicao.
1666:     *--------------------------------------------------------------------------
1667:     PROCEDURE Unload()
1668:         RETURN THIS.this_cRetCodProduto
1669:     ENDPROC
1670: ENDDEFINE

