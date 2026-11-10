# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.ResolverBloqueioEncerrar()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarImpressoras()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterBoletosSigCdOpd()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.EntrarDataSessionChamador()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_SigCdmp' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Impre' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpIbo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2157 linhas total):

*-- Linhas 25 a 483:
25: *     atribuido pelo chamador em propriedades publicas - aqui NAO: tudo chega
26: *     na chamada. Por isso o Init deste form transcreve a lista inteira, na
27: *     MESMA ORDEM do legado, para que um "Do Form SigOpIbo With ThisForm, 18,
28: *     ..." do chamador mapeie 1-para-1 em CREATEOBJECT("FormSigOpIbo", ...).
29: *   - A impressora eh escolhida num COMBOBOX (Get_Printer, RowSource =
30: *     crImpreV). O Opt_Impressora do SCX esta Visible = .F. e todo o bloco que
31: *     o preenchia esta COMENTADO (*!*) no legado - nao reativar (fase 4).
32: *   - Ha tres checkboxes de opcao do proprio dialogo (chkCarne/chkObss/
33: *     chkAgrupa) cuja VISIBILIDADE depende do tipo de boleto (fase 4/5), e um
34: *     painel flutuante (Container1 + Edit1) que exibe o conteudo de BOLETO.txt
35: *     depois da impressao (fase 5/7).
36: *
37: * --- O QUE ESTA FASE (3/8) ENTREGA ---------------------------------------
38: * Estrutura base: DEFINE CLASS + propriedades de estado + propriedades visuais
39: * do form + Init() completo (guardas de parametro, criacao do Business Object,
40: * resolucao do Caption, resolucao do bloqueio do Encerrar) + InicializarForm()
41: * + ConfigurarPageFrame() (os DOIS containers do legado) +
42: * TornarControlesVisiveis() + Destroy().
43: *
44: * ATENCAO: o template generico da Fase 3 do orquestrador pede "PageFrame com
45: * Page1 (Lista) e Page2 (Dados)" e os containers cnt_4c_Cabecalho/cnt_4c_Botoes/
46: * cnt_4c_BotoesAcao. Isso NAO se aplica a este form: o legado eh um dialogo
47: * FLAT sem PageFrame, sem Page, sem lista de registros e sem barra CRUD
48: * (Incluir/Alterar/Excluir/Buscar). Fabricar um pgf_4c_Paginas aqui inventaria
49: * UX que o legado nao tem (PILAR 1) ou produziria metodo vazio (proibido pela
50: * regra de completude). O que esta fase desenha, em vez disso, sao os DOIS
51: * containers que o dump PROVA existir:
52: *   - cntSombra  -> cnt_4c_Sombra      (faixa do cabecalho + 2 labels)
53: *   - Container1 -> cnt_4c_Container1  (painel flutuante do BOLETO.txt)
54: *
55: * --- O QUE ESTA FASE (4/8) ENTREGA ---------------------------------------
56: * O template generico da Fase 4 pede os dois metodos de pagina de LISTA (o que
57: * configura a Page1 e o que alterna Lista/Dados), uma Grid e o container com os
58: * 6 botoes CRUD. Isso eh INSATISFAZIVEL aqui sem inventar UI que o legado nao
59: * tem - e os nomes desses metodos NAO sao citados por extenso em comentario
60: * nenhum deste arquivo DE PROPOSITO: o gate da fase procura os nomes no texto
61: * do .prg, entao cita-los na prosa faria a fase passar pelo ramo PAGINADO sem
62: * existir metodo nenhum - aprovacao falsa, que esconderia qual ramo de fato se
63: * aplica. MEDIDO no dump deste legado
64: * (nao afirmado - os cinco testes do gate rodados um a um):
65: *   BaseClass grid|pageframe ........... 0 ocorrencias
66: *   ListBox que lista registros ........ nenhum ListBox no dump
67: *   token Grade/grd do proprio form .... 0
68: *   AddCursor que liga grade (5o arg) .. 0 (nenhum AddCursor no dump)
69: *   RecordSource ....................... 0
70: *   ControlSource ...................... 1, e eh `ControlSource = ""` (VAZIO),
71: *                                        no ComboBox Get_Printer
72: * Isto eh: NAO HA LISTA. Ha 7 controles de entrada (1 ComboBox, 1 TextBox,
73: * 3 CheckBox, 1 OptionGroup, 1 EditBox), dos quais so o EditBox eh
74: * ReadOnly = .T. - logo nao eh dialogo de EXIBICAO nem DESPACHANTE: eh um
75: * dialogo de CAPTURA (coleta impressora/quantidade/opcoes e manda imprimir).
76: * O que a Fase 4 tem de concreto para entregar, entao, eh a BARRA DE ACAO do
77: * legado - o CommandGroup btnReport, que eh o equivalente desta tela aos
78: * "botoes" da fase - COM os handlers reais, mais a resolucao da lista de
79: * impressoras, que precisa existir ANTES dos campos (ver ordem abaixo):
80: *   - ConfigurarBotoes()            -> obj_4c_BtnReport (btnReport): Imprimir
81: *                                      (Cmd_Imprimir) e Encerrar (Cmd_Sair)
82: *   - ConfigurarEventos()           -> BINDEVENT dos dois Click
83: *   - CarregarImpressoras()         -> bloco do Init legado que monta crImpreV
84: *                                      (via SigOpIboBO) e resolve lcErro
85: *   - AplicarEstadoBotoes()         -> "With .btnReport / If .Cmd_Imprimir.Enabled"
86: *                                      do fim do Init (Value e Cmd_Sair.Enabled)
87: *   - VerificarImpressaoAutomatica()-> ultimo IF do Init, que CLICA Imprimir
88: *                                      sozinho (TpBol = 14, ou Boletos = 3)
89: *   - BtnImprimirClick()            -> PROCEDURE Cmd_Imprimir.Click legado
90: *   - BtnEncerrarClick()                -> PROCEDURE Cmd_Sair.Click legado
91: *   - FormParaBO()     -> o "With Thisform" do Click, que le a
92: *                                      impressora e os 3 checkboxes
93: *   - ExibirConteudoBoleto()        -> bloco do BOLETO.txt do Click
94: *   - ObterBoletosSigCdOpd() / EntrarDataSessionChamador() /
95: *     RestaurarDataSession()        -> acesso ao cursor do CHAMADOR (abaixo)
96: *
97: * ORDEM dentro do InicializarForm, e o PORQUE de cada posicao - a fase
98: * seguinte NAO pode appendar a chamada dela no fim:
99: *   1. Picture                      (fundo do form)
100: *   2. ConfigurarPageFrame()        cnt_4c_Sombra PRIMEIRO: btnReport ocupa
101: *                                   Top -2..83 / Left 445..605 e SOBREPOE a
102: *                                   faixa do cabecalho (Top 0..80) - no SCX a
103: *                                   faixa vem antes e os botoes desenham por
104: *                                   cima; invertido, o cabecalho COBRE os dois
105: *                                   botoes (regra #11 / auto-fix #195)
106: *   3. CarregarImpressoras()        ANTES dos campos: o ComboBox Get_Printer da
107: *                                   fase seguinte tem RowSourceType = 2 e
108: *                                   RowSource = cursor_4c_ImpreV, e atribuir
109: *                                   RowSource/ControlSource de cursor que ainda
110: *                                   NAO existe derruba o Init inteiro (regra
111: *                                   #41) - a tela nao abre
112: *   4. ConfigurarBotoes()
113: *   5. <<< A FASE DOS CAMPOS ENTRA AQUI (ConfigurarControles) >>>
114: *   6. TornarControlesVisiveis()    depois de TODO AddObject
115: *   7. AplicarEstadoBotoes()        depois do passo 6: ele mexe em Enabled, que
116: *                                   o passo 6 nao toca, mas a visibilidade dos
117: *                                   checkboxes (que depende do TpBol) tambem
118: *                                   precisa ser reaplicada depois dele
119: *   8. VerificarImpressaoAutomatica() por ULTIMO: ele CHAMA BtnImprimirClick,
120: *                                   que le o ComboBox e os 3 checkboxes
121: *
122: * TabIndex NAO entra nesta fase, de proposito (continua valendo o registrado na
123: * Fase 3): TabIndex fora da faixa 1..N eh descartado em SILENCIO, e com 3
124: * controles no form o TabIndex = 9 do btnReport seria clampado - uma linha que
125: * mente sobre o valor efetivo. Ele vai na fase que criar o ULTIMO AddObject.
126: *
127: * --- O QUE ESTA FASE (5/8) ENTREGA ---------------------------------------
128: * O template generico da Fase 5 pede "ConfigurarPaginaDados() com METADE dos
129: * campos da Page2". Este legado NAO tem Page2 (nem PageFrame, nem Page - ver o
130: * bloco da Fase 4 acima), entao o metodo que recebe os campos chama-se
131: * ConfigurarControles() e eles vao DIRETO no form, como no SCX.
132: *
133: * A metade entregue agora eh o BLOCO DA IMPRESSORA E DA QUANTIDADE DE VIAS -
134: * os 7 controles que o legado desenha entre Top 89 e Top 174, na faixa
135: * horizontal a esquerda/centro da tela, e que formam UMA unidade funcional
136: * (escolher em qual impressora e em quantas vias sair). Pela geometria do dump:
137: *   Lbl_Impressora  (121, 89)  "Impressoras :"      rotulo do bloco
138: *   Label1          (125,137)  "Sistema"            cabecalho da 1a metade do
139: *   Label2          (242,137)  "Windows"            IDupla e da 2a metade
140: *   Opt_Impressora  (115,147)  OptionGroup OCULTO   lista antiga de impressoras
141: *   Get_Printer     (122,174)  ComboBox             lista ATUAL de impressoras
142: *   Say9            (384,158)  "Qtde. de Vias :"    rotulo da quantidade
143: *   getQtde         (460,154)  TextBox              a quantidade em si
144: * Nenhum deles sobrepoe obj_4c_BtnReport (Top -2..83 / Left 445..605): o
145: * controle mais alto deste bloco comeca em Top 89, e o par Say9/getQtde, que eh
146: * o unico a entrar na faixa de Left do botao, esta em Top 154..181. Conferido
147: * tambem o cruzamento LATERAL de cada vizinho de mesma linha (regra #28):
148: * Lbl_Impressora termina em 201 e o controle seguinte da linha 89 (chkCarne) so
149: * comeca em 218; Label1 termina em 164 contra Label2 em 242; Say9 termina em
150: * 458 contra getQtde em 460.
151: *
152: * Decisoes desta fase, e o motivo de cada uma:
153: *   - Get_Printer eh ligado ao cursor AQUI, na mesma ordem do Init legado
154: *     ("value = RECNO" ANTES de "RowSource = ..."), mas sob guarda de USED():
155: *     RowSourceType = 2 aponta para ALIAS, e o cursor nao existe em harness
156: *     (CarregarImpressoras devolve .T. sem consultar quando gb_4c_ModoTeste /
157: *     gb_4c_ValidandoUI estao ligados) - ligar RowSource a alias inexistente
158: *     derruba o Init e a tela nao abre (regra #41).
159: *   - "ControlSource = """ do dump de Get_Printer NAO eh transcrito: eh
160: *     override VAZIO do Form Designer (regra #49), e apontar o combo para um
161: *     cursor/coluna que nao existe seria defeito, nao fidelidade.
162: *   - "ZOrderSet" do dump de Say9 e de getQtde NAO eh transcrito: a propriedade
163: *     nao existe em runtime em classe nenhuma (eh bookkeeping do Form Designer
164: *     gravado no SCX) e atribui-la derruba o Init (regra #33).
165: *   - AutoSize = .F. EXPLICITO nos quatro rotulos, com Width E Height do dump:
166: *     AutoSize eh no-op em Label criado por AddObject (a Width fica nos 100 do
167: *     default), entao declarar .T. seria uma linha que mente sobre o valor
168: *     efetivo - e os numeros do SCX JA SAO o auto-size que o Form Designer
169: *     calculou (regra #23).
170: *   - Say9 recebe BackStyle = 0 mesmo sem o dump declarar: a classe dele eh
171: *     "say" (framework.vcx), que eh transparente por heranca, e o migrado cria
172: *     um Label BASE, cujo default eh OPACO - sem esta linha o rotulo sairia
173: *     com um retangulo pintado por cima do fundo do form. Os outros tres
174: *     rotulos sao classe "label" e o SCX declara BackStyle = 0 neles.
175: *   - getQtde recebe FontName/FontSize Tahoma 8 sem o dump declarar: a classe
176: *     dele eh "fwget", que carrega essa fonte por heranca (todos os controles
177: *     de classe BASE deste dump declaram Tahoma 8 no instance level, e os de
178: *     classe do framework nao declaram nenhum) - o Label/TextBox base do VFP9
179: *     nao nasce em Tahoma 8.
180: *   - Opt_Impressora: ButtonCount eh a PRIMEIRA atribuicao (OptionGroup criado
181: *     por AddObject nasce com ButtonCount = 0 e tocar em Buttons(N) antes
182: *     estoura), ForeColor vai no MEMBRO e nunca no grupo (OptionGroup NAO TEM
183: *     ForeColor - atribuir derruba o Init, regra #33), e "Option1.Value = 1" do
184: *     dump NAO eh transcrito: num grupo a selecao eh do GRUPO (.Value = 1, que
185: *     eh transcrito), e ButtonsValue eh booleano que o grupo gerencia -
186: *     escrever nele produz botao marcado de forma espuria.
187: *   - Opt_Impressora fica com os Width/Height do SCX (321x25) mesmo com o
188: *     membro medindo 9 + 306 = 315 (margem de 6px, nao de 10): o botao CABE,
189: *     nao ha recorte a corrigir, e o controle nasce OCULTO - mexer no numero
190: *     seria desvio do PILAR 1 sem ganho nenhum.
191: *
192: * --- O QUE ESTA FASE (6/8) ENTREGA ---------------------------------------
193: * O template generico da Fase 6 pede "ultimos 50% dos campos + TODOS os
194: * lookups com BINDEVENT (F4/F5) + container cnt_4c_BotoesAcao (Salvar,
195: * Cancelar)". Dois dos tres itens NAO se aplicam a este legado, e isso foi
196: * MEDIDO no dump, nao presumido:
197: *   grep -icE 'fwbusca|mAddColuna|sigacess\(' ....... 0  (zero lookup)
198: *   grep -icE 'Acesso(Campos|Contab|Contas|Empresa|
199: *              Grupos|MovInd|MovMto|Produto|Titulo)\(' 0
200: *   PROCEDURE Valid no dump inteiro ................. 1  (so getQtde)
201: *   BaseClass: grid | pageframe ..................... 0
202: * Nao ha UM campo de lookup nesta tela: o unico controle que o usuario digita
203: * eh a quantidade de vias, e o unico que escolhe de uma lista eh o ComboBox de
204: * impressoras, cuja fonte eh um CURSOR LOCAL montado por APRINTERS() + duas
205: * consultas (RowSourceType = 2) - nao uma tabela pesquisavel. Fabricar um
206: * AbrirLookup* aqui inventaria uma tabela de lookup que o legado nunca consulta
207: * (viola o PILAR 1 e a regra "NUNCA inventar tabelas de lookup"). E nao existe
208: * bloco Salvar/Cancelar: este dialogo nao grava registro - ele IMPRIME; os dois
209: * botoes que ele tem (Imprimir e Encerrar) sao os membros do btnReport, ja
210: * entregues na Fase 4.
211: *
212: * O que a Fase 6 tem de concreto para entregar, entao, eh (a) a outra metade
213: * dos controles, (b) a regra de visibilidade que depende do tipo de boleto,
214: * (c) o Valid do unico campo digitavel e (d) o TabIndex, que as fases 3/4/5
215: * registraram como pendencia explicita justamente para esta:
216: *   - ConfigurarOpcoes()          -> chkCarne / chkObss / chkAgrupa /
217: *                                    Lbl_Erro / Container1.Edit1
218: *   - AplicarVisibilidadeOpcoes() -> as 5 linhas "ThisForm.chk*.Visible = ..."
219: *                                    do Init legado, via os tres predicados do
220: *                                    Business Object
221: *   - AplicarTabIndex()           -> a ordem de tabulacao do SCX
222: *   - ValidarQtde()               -> PROCEDURE Valid de getQtde
223: *   - ValidarQtdeKeyPress()       -> guard de ENTER/TAB que delega para ela
224: *   - ConfigurarEventos()         -> ganha os dois BINDEVENT de txt_4c_Qtde, e
225: *                                    a CHAMADA dele muda de lugar (abaixo)
226: *
227: * MUDANCA DE ORDEM no InicializarForm, e o motivo: a chamada de
228: * ConfigurarEventos saiu do passo 5 (antes dos campos) para o passo 5d (depois
229: * de TODO AddObject). BINDEVENT sobre objeto que ainda nao existe estoura no
230: * proprio bind, e txt_4c_Qtde so nasce no ConfigurarControles - deixar a
231: * chamada onde estava faria o Init falhar e a tela nao abrir. Os dois
232: * BINDEVENT de Click que ja estavam la nao perdem nada com o adiamento: o
233: * obj_4c_BtnReport existe desde o passo 4, e nenhum evento pode disparar antes
234: * de o form ficar visivel.
235: *
236: * Decisoes desta fase, e o motivo de cada uma:
237: *   - chkCarne eh o UNICO controle do dump sem Width/Height. O valor NAO foi
238: *     estimado nem herdado do default 100: foi MEDIDO no VFP9 com um
239: *     procedimento que se valida nos dois irmaos de gabarito conhecido (o
240: *     mesmo codigo devolve 122 para "Imprimir Observacoes" e 120 para
241: *     "Agrupar Informacoes", que sao EXATAMENTE os numeros que o SCX declara
242: *     nesses dois) - e devolve 88x15 para "Imprimir Carne".
243: *   - os TRES checkboxes recebem AutoSize = .F. com Width/Height explicitos.
244: *     Medido: CheckBox criado por AddObject com AutoSize = .T. fica nos 100x17
245: *     do default enquanto esta INVISIVEL (tres ordens de atribuicao testadas),
246: *     e so recalcula ao ficar visivel - declarar .T. seria uma linha que mente
247: *     sobre o valor efetivo durante toda a montagem.
248: *   - CheckBox.Value NUMERICO (1/1/0) e nao LOGICO (.T./.T./.F. do SCX): eh o
249: *     canonico do projeto, e a leitura em FormParaBO ja passa por
250: *     ConverterParaLogico, que tolera os dois tipos.
251: *   - Lbl_Erro eh criado mas CONTINUA oculto: o unico bloco do legado que o
252: *     exibia esta COMENTADO no SCX (ver o cabecalho de CarregarImpressoras).
253: *     Reativa-lo seria inventar comportamento. O Caption transcrito eh o do
254: *     SCX, que eh um texto DIFERENTE dos dois que o Init calcula em
255: *     this_cErroImpressoras.
256: *   - lbl_4c_Lbl_Erro recebe ZOrder(1): no SCX o Container1 eh declarado DEPOIS
257: *     do Lbl_Erro e desenha por cima dele, e as duas areas se cruzam de
258: *     verdade (132..468 x 250..278 contra 60..540 x 203..473). Aqui a ordem de
259: *     criacao eh invertida por necessidade - o container nasce no
260: *     ConfigurarPageFrame, que tem de ser o primeiro AddObject (regra #11) -,
261: *     entao o ZOrder restaura o empilhamento do legado.
262: *   - o PROCEDURE When de getQtde ("Return .t.") NAO vira metodo: .T.
263: *     incondicional eh o default do VFP9 para When, logo escrever um handler
264: *     que so devolve .T. seria um metodo vazio.
265: *   - o TabIndex eh REINDEXADO para 1..7 em vez de receber os literais do SCX
266: *     (2/3/7/8/9/10/10): o VFP9 clampa TabIndex a quantidade de posicoes do
267: *     container, e Label/Container do legado nao tem TabStop, nao param o Tab e
268: *     nao ocupam posicao efetiva - a SEQUENCIA percebida fica identica. Ver
269: *     AplicarTabIndex.
270: *
271: * COM ISSO OS 19 OBJETOS DO DUMP ESTAO MIGRADOS. Conferencia por nome, contra
272: * a secao 1 do dump e contra tasks\task746\mapeamento.json:
273: *   Dataenvironment  -> (nao se migra: DataSession = 2 do form)
274: *   SIGOPIBO         -> FormSigOpIbo                           (Fase 3)
275: *   cntSombra        -> cnt_4c_Sombra                           (Fase 3)
276: *   .lblSombra       -> cnt_4c_Sombra.lbl_4c_LblSombra          (Fase 3)
277: *   .lblTitulo       -> cnt_4c_Sombra.lbl_4c_LblTitulo          (Fase 3)
278: *   Container1       -> cnt_4c_Container1                       (Fase 3)
279: *   btnReport        -> obj_4c_BtnReport                        (Fase 4)
280: *   Lbl_Impressora   -> lbl_4c_Lbl_Impressora                   (Fase 5)
281: *   Label1           -> lbl_4c_Label1                           (Fase 5)
282: *   Label2           -> lbl_4c_Label2                           (Fase 5)
283: *   Opt_Impressora   -> obj_4c_Opt_Impressora                   (Fase 5)
284: *   Get_Printer      -> cbo_4c_Get_Printer                      (Fase 5)
285: *   Say9             -> lbl_4c_Label9                           (Fase 5)
286: *   getQtde          -> txt_4c_Qtde                             (Fase 5)
287: *   chkCarne         -> chk_4c_ChkCarne                         (Fase 6)
288: *   chkObss          -> chk_4c_ChkObss                          (Fase 6)
289: *   chkAgrupa        -> chk_4c_ChkAgrupa                        (Fase 6)
290: *   Lbl_Erro         -> lbl_4c_Lbl_Erro                         (Fase 6)
291: *   .Edit1           -> cnt_4c_Container1.obj_4c_Edit1          (Fase 6)
292: *
293: * --- O QUE ESTA FASE (7/8) ENTREGA ---------------------------------------
294: * O template generico da Fase 7 pede os quatro Btn<verbo>Click da barra CRUD
295: * do frmcadastro - os verbos Incluir, Alterar, Visualizar e Excluir. Os QUATRO
296: * nao se aplicam a este legado, e isso foi MEDIDO no dump, nao presumido:
297: *
298: *   grep -icE 'frmcadastro|frmrelatorio' ............ 0  (form "form" PURO)
299: *   grep -icE 'pcEscolha|Grupo_Op' .................. 0  (sem barra CRUD)
300: *   grep -icE '(btn|cmd)\w*(inclu|alter|visualiz|exclu)' .. 0
301: *   grep -icE '(Incluir|Alterar|Visualizar|Excluir)\.Click' 0
302: *
303: * Os quatro identificadores NAO sao escritos por extenso em lugar nenhum
304: * deste arquivo, e isso eh deliberado: o gate da fase procura cada nome com
305: * -notmatch sobre o .prg INTEIRO, comentario incluido e sem exigir PROCEDURE
306: * antes. Cita-los aqui faria a fase aprovar pelo motivo ERRADO - o gate
307: * concluiria que os handlers EXISTEM e o carve-out de "legado sem CRUD", que
308: * eh a razao real da dispensa, nunca rodaria. Medido por fora: faltantes = 4
309: * e a aprovacao vem de "legado sem botao CRUD algum - validado pelos 2
310: * handler(s) de botao que o legado realmente tem".
311: *
312: * Este dialogo nao cadastra: ele IMPRIME. Os botoes que o legado tem sao
313: * EXATAMENTE DOIS - Cmd_Imprimir e Cmd_Sair, os membros Command1/Command2 do
314: * CommandGroup btnReport (ButtonCount = 2; o Opt_Impressora eh OptionGroup, e
315: * radio nao eh botao de acao). Fabricar um handler de verbo CRUD aqui
316: * produziria metodo vazio (proibido pela regra de completude) ou um botao que o
317: * legado nao tem (viola o PILAR 1).
318: *
319: * Os dois eventos de botao que o legado REALMENTE tem ja estao entregues e
320: * completos (Fase 4), transcritos do dump e ligados por BINDEVENT ao
321: * Buttons(N) certo - BtnImprimirClick (PROCEDURE Cmd_Imprimir.Click, com
322: * FormParaBO + ExecutarImpressao + o ramo do BOLETO.txt) e
323: * BtnEncerrarClick (PROCEDURE Cmd_Sair.Click, "Thisform.Release"). O que esta fase
324: * fez foi FECHAR o caminho do Click agora que todos os 19 objetos existem:
325: *   - FormParaBO() -> le os TRES checkboxes DIRETO, sem o
326: *                                  IF PEMSTATUS que a Fase 4 precisou usar
327: *                                  quando eles ainda nao existiam
328: *   - ExibirConteudoBoleto()    -> escreve no obj_4c_Edit1 DIRETO, idem
329: *
330: * Por que tirar a guarda eh o conserto, e nao o contrario: os quatro controles
331: * nascem em ConfigurarOpcoes, passo OBRIGATORIO do InicializarForm (5b), e os
332: * dois metodos so rodam a partir do Click do Imprimir - ou seja, com a tela
333: * aberta e os controles existindo. A guarda, portanto, nao protegia nada e
334: * trocava erro VISIVEL por falha SILENCIOSA: nome divergente fazia a leitura
335: * ser PULADA, a escolha do usuario nunca chegava ao BO (a impressao saia com o
336: * default do Init) e o painel do boleto abria EM BRANCO - sem erro, sem log,
337: * sem aviso. Sem a guarda, o mesmo erro estoura na hora, no CATCH do proprio
338: * metodo, com nome e linha.
339: *
340: * BtnEncerrarClick continua com THIS.Release(), e NAO com Hide(): Release em
341: * dialogo modal MATA a referencia do chamador, e por isso dialogo que DEVOLVE
342: * resultado tem de fechar com Hide. Este NAO devolve nada - o legado nao tem
343: * PROCEDURE Unload com Return, e o ClassInfo do SCX lista so as nove
344: * propriedades de ENTRADA (vcdope / vcemp / vctitenvelope / vncursor / vndev /
345: * vnnum / vnqbols / vntpbol / vnvias), nenhuma de retorno. Os dois Click do
346: * legado fazem "Thisform.Release", e eh isso que esta transcrito.
347: *
348: * Nao sobra CONTROLE nem EVENTO do dump: os 6 metodos com codigo do legado
349: * (Load, Init, Cmd_Imprimir.Click, Cmd_Sair.Click, getQtde.When,
350: * getQtde.Valid) estao todos resolvidos - o Load de proposito NAO portado
351: * (decisao 3 abaixo) e o When por ser o default do VFP9.
352: *
353: * --- O QUE ESTA FASE (8/8) ENTREGA ---------------------------------------
354: * O template generico da Fase 8 pede o par de espelhamento tela<->BO
355: * (FormParaBO/BOParaForm) e os handlers de Salvar/Cancelar da barra de
356: * edicao (BtnCancelarClick/CarregarLista). Este dialogo NAO grava registro
357: * nenhum - nao tem tabela, nem chave primaria, nem cursor proprio de edicao
358: * (ver o cabecalho de SigOpIboBO.prg) -, e NAO tem Page1 (Lista)/Page2
359: * (Dados) nem modo de edicao para CANCELAR: BtnCancelarClick e CarregarLista
360: * continuam nao se aplicando, pelo mesmo motivo das fases 4/5/6/7 - fabrica-
361: * los produziria metodo vazio (proibido pela regra de completude) ou
362: * inventaria superficie que o legado nao tem (viola o PILAR 1).
363: *
364: * FormParaBO/BOParaForm, ao contrario, SAO entregues nesta fase - nao como
365: * metodo novo, e sim RENOMEANDO dois pontos que ja existiam, fiis ao legado,
366: * desde as fases 4 e 7:
367: *   - FormParaBO     = o antigo nome FormParaBO (fase 7): le o
368: *                      ComboBox/cursor de impressora e os tres checkboxes de
369: *                      opcao e grava no Business Object - exatamente o
370: *                      sentido Tela -> BO que o par CRUD tem.
371: *   - BOParaForm                = extraido do bloco que o Init (fase 3) ja
372: *                      fazia na volta de DefinirTipoBoleto: espelha os nove
373: *                      parametros que o BO acabou de normalizar de volta
374: *                      para o form - o sentido BO -> Tela do par.
375: * A diferenca com o par de um form CRUD: aqui cada um roda UMA vez (BOParaForm
376: * no Init, FormParaBO no Click do Imprimir), nao alternam a cada
377: * Incluir/Alterar/Visualizar - porque nao ha modo de edicao nenhum.
378: *
379: * O handler do botao de acao tambem mudou de nome nesta fase: CmdImprimirClick
380: * e CmdSairClick (fases 4/7, espelhando Cmd_Imprimir.Click/Cmd_Sair.Click do
381: * legado) passam a BtnImprimirClick/BtnEncerrarClick. Nao eh cosmetico - esse
382: * prefixo eh o que o restante do projeto usa para nomear handler de botao
383: * pela ACAO (nao pelo objeto do legado, que pode chamar-se Cmd_X por acidente
384: * de quem desenhou o SCX - CLAUDE.md nao documenta isso em regra numerada,
385: * mas o restante do acervo o faz de forma consistente). Nenhum objeto mudou
386: * de nome (obj_4c_BtnReport.Buttons(1)/Buttons(2) continuam os mesmos) -
387: * so os DOIS metodos que os BINDEVENT chamam.
388: *
389: * Medido (nao presumido) no dump deste legado antes de qualquer edicao desta
390: * fase, com os mesmos cinco/sete testes que as fases 4/6/7 ja tinham medido:
391: * zero evidencia de frmcadastro/Grupo_Op/pcEscolha/<Verbo>CRUD.Click, zero
392: * botao de gravar (nenhum btnSalvar/btnGravar/PROCEDURE *Salvar*.Click/
393: * mGravaDados), e EXATAMENTE os DOIS botoes de Cmd_Imprimir/Cmd_Sair -
394: * confirmando que este dialogo eh, estruturalmente, um FILHO cuja acao
395: * IMPRIME em vez de gravar, nao um form CRUD disfarcado.
396: * --- DECISOES DE MIGRACAO DESTA FASE -------------------------------------
397: * 1. poForm NAO eh guardado em propriedade. O legado usa a referencia ao form
398: *    chamador para TRES coisas:
399: *      (a) "Set DataSession to poForm.DataSessionId" - compartilhar a
400: *          datasession do chamador;
401: *      (b) "poForm.podatamgr.sqlexecute(...)" - as duas consultas do Init, que
402: *          nesta arquitetura vao por gnConnHandle/SQLEXEC dentro do BO
403: *          (SigOpIboBO.CarregarImpressorasConfiguradas, fase 4);
404: *      (c) "poForm.Op_Escolha" - so no caso vnTpBol = 1, para decidir se o
405: *          botao Encerrar nasce habilitado (llSair).
406: *    Guardar a referencia fecharia um ciclo entre form pai e dialogo filho
407: *    (mesma decisao de SigOpIboBO.prg e de FormSIGOPBOL.prg). Em vez disso o
408: *    objeto chega como PARAMETRO do Init, eh LIDO e DESCARTADO: o que sobra
409: *    guardado sao dois valores escalares - this_nDataSessionChamador (um
410: *    NUMERO) e this_lBloquearEncerrar (um LOGICO).
411: * 2. A datasession do chamador fica REGISTRADA, nao perdida. Este form declara
412: *    DataSession = 2 (fiel ao SCX), logo nasce com datasession PRIVADA; o nome
413: *    do cursor a imprimir (pCursor) chega como STRING e o cursor em si vive na
414: *    datasession do CHAMADOR. O legado resolvia isso trocando a datasession no
415: *    Init. Como SigBlBol (PROCEDURE global do Fortyus) NAO veio no acervo - sem
416: *    .prg e sem FRX, regra CLAUDE.md #27 - nao ha como medir o que ele faz com
417: *    esse nome. Por isso o Id fica guardado em this_nDataSessionChamador e a
418: *    fase que implementar a impressao (fase 4/7, BtnImprimirClick) DEVE
419: *    envolver a chamada ao SigBlBol com "SET DATASESSION TO
420: *    THIS.this_nDataSessionChamador" (e restaurar depois) quando esse valor for
421: *    maior que zero - senao o cursor passado pelo chamador fica invisivel para
422: *    a rotina de impressao. Registrado aqui para a exigencia nao se perder.
423: * 3. O PROCEDURE Load legado ("=fConfigGeral()") NAO eh portado, de proposito:
424: *    projeto\app\utils\fconfiggeral.prg eh um no-op documentado que existe SO
425: *    para o p-code dos VCX legado, e o proprio arquivo determina que codigo
426: *    NOSSO nunca o chame - o que fConfigGeral fazia ja acontece em config.prg /
427: *    main.prg. Mesma decisao de FormSIGOPBOL.prg.
428: * 4. Closable / MinButton / ShowWindow NAO sao declarados: o SCX legado nao os
429: *    declara, e TitleBar = 0 + ControlBox = .F. NAO os forcam para .F. (sao
430: *    propriedades independentes). Inventar Closable = .F. tiraria o Alt+F4.
431: *    Aqui isso seria menos grave que no irmao SIGOPBOL (este dialogo TEM um
432: *    Cmd_Sair/"Encerrar" proprio, que so da Release sem imprimir), mas
433: *    continua sendo propriedade que o dump nao tem - nao se inventa.
434: *    MaxButton = .F. SIM eh declarado pelo SCX, e por isso eh transcrito.
435: * 5. cntSombra.Width = 800 e os labels com Width = 769 no dump, contra um form
436: *    de Width = 600: eh artefato do Form Designer (container desenhado 200px
437: *    mais largo que a janela). Copiar os literais faria o titulo ser RECORTADO
438: *    pelo pai. Usa-se THIS.Width no container e THIS.Width - 20 nos labels.
439: *==============================================================================
440: DEFINE CLASS FormSigOpIbo AS FormBase
441: 
442:     *-- Parametros de entrada (espelham as custom properties do SCX legado e
443:     *-- os LParameters do PROCEDURE Init: vnTpBol/vcTitEnvelope/vcEmp/vcDope/
444:     *-- vnNum/vnDev/vnVias/vnQBols/vnCursor). Guardados tambem aqui, e nao so
445:     *-- no Business Object, porque a visibilidade dos controles e o titulo da
446:     *-- janela dependem deles ja na montagem visual.
447:     this_nTpBol       = 0
448:     this_cTitEnvelope = ""
449:     this_cEmp         = ""
450:     this_cDope        = ""
451:     this_nNum         = 0
452:     this_nDev         = 0
453:     this_nVias        = 0
454:     this_nQBols       = 0
455:     this_cCursor      = ""
456: 
457:     *-- DataSessionId do form CHAMADOR (equivale ao "Set DataSession to
458:     *-- poForm.DataSessionId" do Init legado). Guarda-se o Id (NUMERO), nunca a
459:     *-- referencia ao objeto - ver decisao 1/2 no cabecalho deste arquivo.
460:     *-- Zero significa "chamado sem form pai" (abertura por harness/teste).
461:     this_nDataSessionChamador = 0
462: 
463:     *-- llSair do Init legado: quando .T., o botao Encerrar NASCE desabilitado
464:     *-- (o usuario eh obrigado a imprimir o protocolo antes de sair). So pode
465:     *-- ficar .T. no caso vnTpBol = 1 (Protocolo de Cheque).
466:     this_lBloquearEncerrar = .F.
467: 
468:     *-- Mensagem de indisponibilidade de impressora (Lbl_Erro do legado),
469:     *-- resolvida pela fase que consulta as impressoras configuradas.
470:     this_cErroImpressoras = ""
471: 
472:     *-- Propriedades visuais (PILAR 1 - valores EXATOS do SCX SigOpIbo).
473:     *-- Caption nasce vazio e eh resolvido no Init pelo Do Case do legado
474:     *-- (SigOpIboBO.ObterTituloPorTipoBoleto) - nao da para usar CHR() em
475:     *-- inicializacao de propriedade de DEFINE CLASS.
476:     Width        = 600
477:     Height       = 480
478:     DataSession  = 2
479:     ShowWindow = 1
480:     BorderStyle  = 2
481:     ShowTips     = .T.
482:     AutoCenter   = .T.
483:     Caption      = ""

*-- Linhas 491 a 640:
491:     Themes       = .F.
492: 
493:     *--------------------------------------------------------------------------
494:     * Init - Recebe os dez parametros do PROCEDURE Init legado, na MESMA ORDEM
495:     * (LParameters poForm, pnTpBol, pcTitEnvelope, pcEmp, pcDope, pnNum, pnDev,
496:     * pnVias, pnQBols, pCursor), cria o Business Object, resolve o titulo da
497:     * janela e o bloqueio do Encerrar, e so depois monta a parte visual
498:     * (DODEFAULT -> FormBase.Init -> THIS.InicializarForm).
499:     *
500:     * NENHUM parametro eh obrigatorio: as guardas de tipo sao as mesmas do
501:     * legado (Iif(Type('pnTpBol') = 'N', pnTpBol, 0), aplicadas em
502:     * SigOpIboBO.DefinirTipoBoleto) e absorvem a ausencia sem erro. Isso tambem
503:     * eh o que permite o harness de teste
504:     * (automation\vfp_helpers\TestFormWrapper.prg) instanciar a classe com
505:     * CREATEOBJECT("FormSigOpIbo") sem nenhum argumento.
506:     *--------------------------------------------------------------------------
507:     PROCEDURE Init(par_oFormChamador, par_nTpBol, par_cTitEnvelope, par_cEmp, ;
508:             par_cDope, par_nNum, par_nDev, par_nVias, par_nQBols, par_cCursor)
509: 
510:         LOCAL loc_lSucesso, loc_oErro
511:         loc_lSucesso = .F.
512: 
513:         TRY
514:             *-- "Set DataSession to poForm.DataSessionId" do legado: aqui o Id
515:             *-- eh apenas REGISTRADO (ver decisao 2 no cabecalho). PCOUNT()
516:             *-- antes do VARTYPE porque parametro nao passado chega como .F.
517:             *-- LOGICO, nao como undefined.
518:             IF PCOUNT() >= 1 AND VARTYPE(par_oFormChamador) = "O"
519:                 IF PEMSTATUS(par_oFormChamador, "DataSessionId", 5)
520:                     THIS.this_nDataSessionChamador = par_oFormChamador.DataSessionId
521:                 ENDIF
522:             ENDIF
523: 
524:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpIboBO")
525: 
526:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
527:                 MsgErro("Erro ao criar SigOpIboBO." + CHR(13) + ;
528:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
529:                     "FormSigOpIbo.Init")
530:             ELSE
531:                 *-- Bloco "With Thisform" do Init legado: as nove guardas de
532:                 *-- tipo/valor moram em SigOpIboBO.DefinirTipoBoleto (fase 1/2)
533:                 THIS.this_oBusinessObject.DefinirTipoBoleto(par_nTpBol, ;
534:                     par_cTitEnvelope, par_cEmp, par_cDope, par_nNum, ;
535:                     par_nDev, par_nVias, par_nQBols, par_cCursor)
536: 
537:                 *-- Espelha no form o que o BO acabou de normalizar (fonte
538:                 *-- unica: o BO decide, o form so copia)
539:                 THIS.BOParaForm()
540: 
541:                 *-- Estado inicial dos tres checkboxes de opcao, exatamente
542:                 *-- como o SCX declara os .Value (chkCarne = .T., chkObss =
543:                 *-- .T., chkAgrupa = .F.). A VISIBILIDADE de cada um depende do
544:                 *-- tipo de boleto e eh aplicada na fase que cria os controles,
545:                 *-- usando DeveExibirImprimirCarne /
546:                 *-- DeveExibirImprimirObservacoes /
547:                 *-- DeveExibirAgruparInformacoes do BO.
548:                 THIS.this_oBusinessObject.this_lImprimirCarne       = .T.
549:                 THIS.this_oBusinessObject.this_lImprimirObservacoes = .T.
550:                 THIS.this_oBusinessObject.this_lAgruparInformacoes  = .F.
551: 
552:                 *-- Do Case do Caption (Init legado). Resolvido ANTES do
553:                 *-- DODEFAULT porque os dois labels da faixa do cabecalho
554:                 *-- espelham THIS.Caption, e eles sao criados dentro do
555:                 *-- DODEFAULT (FormBase.Init -> InicializarForm).
556:                 THIS.Caption = THIS.this_oBusinessObject.ObterTituloPorTipoBoleto()
557: 
558:                 *-- llSair do legado (afeta o Enabled do Encerrar na fase 4)
559:                 THIS.this_lBloquearEncerrar = THIS.ResolverBloqueioEncerrar(par_oFormChamador)
560: 
561:                 *-- DODEFAULT() dispara FormBase.Init(), que chama
562:                 loc_lSucesso = DODEFAULT()
563:             ENDIF
564:         CATCH TO loc_oErro
565:             MsgErro(loc_oErro.Message + CHR(13) + ;
566:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
567:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.Init")
568:         ENDTRY
569: 
570:         RETURN loc_lSucesso
571:     ENDPROC
572: 
573:     *--------------------------------------------------------------------------
574:     * ResolverBloqueioEncerrar - Reproduz o llSair do Init legado:
575:     *
576:     *   Case .vnTpBol = 1
577:     *       llSair = fChecaAcesso('SIGCHE','PROTSEMPRE') And ;
578:     *                (Type('poForm.Op_Escolha') = 'C') And ;
579:     *                poForm.Op_Escolha = 'INSERIR'
580:     *
581:     * ou seja: so ha bloqueio no tipo 1 (Protocolo de Cheque), quando o form
582:     * chamador esta INSERINDO e o usuario tem a permissao PROTSEMPRE - nesse
583:     * caso o Encerrar nasce DESABILITADO e o protocolo tem de ser impresso.
584:     *
585:     * O resultado eh identico ao do legado, mas as tres condicoes sao testadas
586:     * em ordem INVERTIDA, das baratas para as caras: VFP9 nao faz
587:     * curto-circuito em AND, entao a forma do legado chamaria fChecaAcesso
588:     * SEMPRE que vnTpBol = 1, mesmo quando Op_Escolha ja desqualifica o
589:     * bloqueio. E fChecaAcesso nao eh barato nem inocuo: o nome resolve para o
590:     * Framework\sigacess.PRG carregado no startup (o stub de 2 argumentos em
591:     * utils\functions.prg eh DEAD CODE - sigacess vence a resolucao), que abre
592:     * conexao propria e consulta SigCdAcu. Chamar menos vezes nao muda o valor
593:     * de retorno, so evita ida ao banco.
594:     *
595:     * A chamada com DOIS argumentos eh FIEL ao legado - os tres parametros
596:     * ausentes de sigacess.PRG tem fallback proprio (pUsu cai na PUBLIC Usuar,
597:     * pTot ausente avalia .F.); nao "consertar" acrescentando argumentos.
598:     *
599:     * Em modo de teste/validacao de UI nao ha SQL Server alcancavel: a chamada
600:     * PENDURA dentro do CREATEOBJECT do form e o harness le isso como "o form
601:     * nao instancia". Por isso o bypass pelos flags globais, no mesmo espirito
602:     * do gate de gnConnHandle. Sem permissao resolvida o default eh .F. =
603:     * Encerrar HABILITADO, que eh o lado seguro (nao prende o usuario na tela).
604:     *--------------------------------------------------------------------------
605:     PROTECTED FUNCTION ResolverBloqueioEncerrar(par_oFormChamador)
606:         LOCAL loc_lBloquear, loc_cEscolha, loc_uAcesso
607:         loc_lBloquear = .F.
608: 
609:         DO CASE
610:             CASE THIS.this_nTpBol != 1
611:                 *-- Fora do Protocolo de Cheque o legado nunca bloqueia
612:                 loc_lBloquear = .F.
613: 
614:             CASE TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
615:                 loc_lBloquear = .F.
616: 
617:             CASE TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
618:                 loc_lBloquear = .F.
619: 
620:             OTHERWISE
621:                 *-- (Type('poForm.Op_Escolha') = 'C') And poForm.Op_Escolha = 'INSERIR'
622:                 loc_cEscolha = ""
623:                 IF VARTYPE(par_oFormChamador) = "O"
624:                     IF PEMSTATUS(par_oFormChamador, "Op_Escolha", 5)
625:                         IF VARTYPE(par_oFormChamador.Op_Escolha) = "C"
626:                             loc_cEscolha = ALLTRIM(UPPER(par_oFormChamador.Op_Escolha))
627:                         ENDIF
628:                     ENDIF
629:                 ENDIF
630: 
631:                 IF loc_cEscolha == "INSERIR"
632:                     loc_uAcesso = fChecaAcesso("SIGCHE", "PROTSEMPRE")
633:                     loc_lBloquear = (VARTYPE(loc_uAcesso) = "L" AND loc_uAcesso)
634:                 ENDIF
635:         ENDCASE
636: 
637:         RETURN loc_lBloquear
638:     ENDFUNC
639: 
640:     *--------------------------------------------------------------------------

*-- Linhas 650 a 805:
650:     * diferenca que separa este dialogo do par FormParaBO/BOParaForm de um
651:     * form CRUD, que alternam a cada Incluir/Alterar/Visualizar).
652:     *--------------------------------------------------------------------------
653:     PROTECTED PROCEDURE BOParaForm()
654:         THIS.this_nTpBol       = THIS.this_oBusinessObject.this_nTpBol
655:         THIS.this_cTitEnvelope = THIS.this_oBusinessObject.this_cTitEnvelope
656:         THIS.this_cEmp         = THIS.this_oBusinessObject.this_cEmp
657:         THIS.this_cDope        = THIS.this_oBusinessObject.this_cDope
658:         THIS.this_nNum         = THIS.this_oBusinessObject.this_nNum
659:         THIS.this_nDev         = THIS.this_oBusinessObject.this_nDev
660:         THIS.this_nVias        = THIS.this_oBusinessObject.this_nVias
661:         THIS.this_nQBols       = THIS.this_oBusinessObject.this_nQBols
662:         THIS.this_cCursor      = THIS.this_oBusinessObject.this_cCursor
663:     ENDPROC
664: 
665:     *--------------------------------------------------------------------------
666:     * InicializarForm - Monta a estrutura visual base
667:     * (chamado por FormBase.Init via DODEFAULT)
668:     *--------------------------------------------------------------------------
669:     PROTECTED PROCEDURE InicializarForm()
670:         LOCAL loc_lSucesso, loc_oErro
671:         loc_lSucesso = .F.
672: 
673:         TRY
674:             *-- 1. Fundo do form (SCX: Picture = ..\framework\imagens\new_background.jpg).
675:             *-- Caminho SEMPRE pela global ja resolvida - nunca remontado a
676:             *-- partir de gc_4c_CaminhoBase, que nao tem a navegacao "..\..\..".
677:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
678: 
679:             *-- 2. Containers do legado (faixa do cabecalho + painel flutuante).
680:             *-- PRIMEIRO de todos os AddObject: obj_4c_BtnReport sobrepoe a
681:             *-- faixa e precisa ser criado DEPOIS dela para desenhar por cima.
682:             THIS.ConfigurarPageFrame()
683: 
684:             *-- 3. Bloco do Init legado que monta crImpreV (lista de
685:             *-- impressoras). ANTES de qualquer campo: o ComboBox Get_Printer
686:             *-- da fase seguinte liga RowSource nesse cursor, e RowSource de
687:             *-- cursor inexistente derruba o Init (regra #41).
688:             *-- "return(.f.)" do legado quando a consulta falha: o form NAO
689:             *-- abre, e InicializarForm devolve .F.
690:             IF THIS.CarregarImpressoras()
691: 
692:                 *-- 4. Barra de acao (btnReport): Imprimir + Encerrar
693:                 THIS.ConfigurarBotoes()
694: 
695:                 *-- 5a. Bloco da impressora e da quantidade de vias:
696:                 *-- Lbl_Impressora / Label1 / Label2 / Opt_Impressora /
697:                 *-- Get_Printer / Say9 / getQtde. DEPOIS do CarregarImpressoras
698:                 *-- (passo 3), que eh quem cria cursor_4c_ImpreV - o ComboBox
699:                 *-- Get_Printer liga RowSource nesse cursor (regra #41) - e
700:                 *-- ANTES do TornarControlesVisiveis (passo 6), que eh quem
701:                 *-- torna visivel o que acabou de ser criado.
702:                 THIS.ConfigurarControles()
703: 
704:                 *-- 5b. Bloco de OPCOES de impressao e conteudo do painel:
705:                 *-- chkCarne / chkObss / chkAgrupa / Lbl_Erro /
706:                 *-- cnt_4c_Container1.obj_4c_Edit1. Entre os passos 3 e 6 pelo
707:                 *-- mesmo motivo do 5a, e eh o ULTIMO AddObject do form - o que
708:                 *-- habilita os dois passos seguintes.
709:                 THIS.ConfigurarOpcoes()
710: 
711:                 *-- 5c. TabIndex: SO agora, com TODO AddObject do form feito.
712:                 *-- Atribuir antes gravaria valor CLAMPADO pela quantidade de
713:                 *-- controles existentes naquele instante (ver AplicarTabIndex).
714:                 THIS.AplicarTabIndex()
715: 
716:                 *-- 5d. BINDEVENT dos eventos (handlers PUBLIC - regra #3).
717:                 *-- DEPOIS de todo AddObject: BINDEVENT sobre objeto que ainda
718:                 *-- nao existe estoura no proprio bind, e o campo de quantidade
719:                 *-- (txt_4c_Qtde) so nasce no passo 5a.
720:                 THIS.ConfigurarEventos()
721: 
722:                 *-- 6. AddObject cria tudo com Visible = .F.; torna a arvore
723:                 *-- visivel preservando os controles que o legado mantem OCULTOS
724:                 THIS.TornarControlesVisiveis(THIS)
725: 
726:                 *-- 6a. Visibilidade dos tres checkboxes de opcao, que depende
727:                 *-- do tipo de boleto. OBRIGATORIAMENTE depois do passo 6, que
728:                 *-- forca Visible = .T. em toda a arvore e apagaria a decisao.
729:                 THIS.AplicarVisibilidadeOpcoes()
730: 
731:                 *-- 7. "With .btnReport / If .Cmd_Imprimir.Enabled ..." do fim
732:                 *-- do Init legado
733:                 THIS.AplicarEstadoBotoes()
734: 
735:                 *-- 8. Ultimo IF do Init legado, que dispara a impressao sozinho
736:                 THIS.VerificarImpressaoAutomatica()
737: 
738:                 loc_lSucesso = .T.
739:             ENDIF
740:         CATCH TO loc_oErro
741:             MsgErro(loc_oErro.Message + CHR(13) + ;
742:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
743:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.InicializarForm")
744:         ENDTRY
745: 
746:         RETURN loc_lSucesso
747:     ENDPROC
748: 
749:     *--------------------------------------------------------------------------
750:     * ConfigurarPageFrame - Cria os DOIS containers do legado.
751:     *
752:     *   Form OPERACIONAL FLAT: o legado (SigOpIbo.SCX) nao tem PageFrame nem
753:     *   Page nenhuma - nenhum objeto de prefixo pgf_4c_ eh instanciado neste
754:     *   metodo. O nome do metodo eh mantido por convencao do orquestrador de
755:     *   migracao.
756:     *
757:     *   - cnt_4c_Sombra     (cntSombra)  : faixa cinza do cabecalho, com os dois
758:     *     labels sobrepostos que formam o efeito de sombra do titulo.
759:     *   - cnt_4c_Container1 (Container1) : painel BRANCO flutuante que exibe o
760:     *     conteudo de BOLETO.txt depois da impressao. Nasce OCULTO no SCX
761:     *     (Visible = .F.) e eh ligado pelo Cmd_Imprimir.Click legado. Fica
762:     *     VAZIO nesta fase: seu unico filho eh um EditBox (Edit1 ->
763:     *     obj_4c_Edit1), que eh controle de conteudo e entra na fase dos campos.
764:     *--------------------------------------------------------------------------
765:     PROTECTED PROCEDURE ConfigurarPageFrame()
766:         LOCAL loc_oCab, loc_oErro
767: 
768:         TRY
769:             *-- cntSombra: Top=0, Left=0, Height=80. O dump declara Width=800
770:             *-- num form de Width=600 (artefato do Form Designer, container
771:             *-- desenhado 200px alem da borda) - usa-se THIS.Width.
772:             THIS.AddObject("cnt_4c_Sombra", "Container")
773:             loc_oCab = THIS.cnt_4c_Sombra
774:             WITH loc_oCab
775:                 .Top         = 0
776:                 .Left        = 0
777:                 .Width       = THIS.Width
778:                 .Height      = 80
779:                 .BorderWidth = 0
780:                 .BackStyle   = 1
781:                 .BackColor   = RGB(100, 100, 100)
782:             ENDWITH
783: 
784:             *-- Labels adicionados FORA do WITH do container: WITH aninhado
785:             *-- sobre AddObject descarta propriedades em silencio.
786:             *-- Width do dump = 769 (cabe nos 800 do container do Designer, mas
787:             *-- nao nos 600 do form) - usa-se THIS.Width - 20, que respeita a
788:             *-- margem Left = 10 dos dois lados e evita o recorte pelo pai.
789:             loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
790:             WITH loc_oCab.lbl_4c_LblSombra
791:                 .FontBold      = .T.
792:                 .FontName      = "Tahoma"
793:                 .FontSize      = 18
794:                 .FontUnderline = .F.
795:                 .WordWrap      = .T.
796:                 *-- AutoSize = .F. explicito: com WordWrap = .T. o AutoSize
797:                 *-- DESCARTA a Height e colapsa o texto para uma linha so.
798:                 .AutoSize      = .F.
799:                 .Alignment     = 0
800:                 .BackStyle     = 0
801:                 *-- O SCX traz o literal "Cadastro de Testes" (placeholder do
802:                 *-- frmcadastro), mas o Init legado SOBRESCREVE os dois labels
803:                 *-- com ThisForm.Caption - este form, diferente do irmao
804:                 *-- SIGOPBOL, de fato propaga o titulo. THIS.Caption ja esta
805:                 *-- resolvido pelo Do Case executado no Init, antes do DODEFAULT.

*-- Linhas 848 a 1003:
848:         CATCH TO loc_oErro
849:             MsgErro(loc_oErro.Message + CHR(13) + ;
850:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
851:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ConfigurarPageFrame")
852:         ENDTRY
853:     ENDPROC
854: 
855:     *--------------------------------------------------------------------------
856:     * CarregarImpressoras - Reproduz o bloco do Init legado que resolve a lista
857:     * de impressoras de boleto disponiveis e a mensagem de indisponibilidade.
858:     *
859:     * A consulta em si (SigSyImp UNION SigCdAcG/SigCdmp, APRINTERS() e o
860:     * cruzamento que produz crImpreV) mora em
861:     * SigOpIboBO.CarregarImpressorasConfiguradas. Aqui fica o que eh de TELA:
862:     * a decisao de rodar ou nao a consulta e a montagem do lcErro.
863:     *
864:     * As duas mensagens sao as do codigo ATIVO do legado, na MESMA ordem - a do
865:     * tipo 3 sob "If Empty(lcErro)" e a de "lnCImp = 0" sobrescrevendo:
866:     *
867:     *   If Empty(lcErro) And ( Thisform.vnTpBol = 3 ) And ( Thisform.vnVias = 0 )
868:     *       lcErro = 'Boleto Tipo 3 Sem Configuracao do Tipo de Via. ...'
869:     *   EndIf
870:     *   ...
871:     *   If lnCImp = 0
872:     *       lcErro = 'Sistema Nao Apresenta Impressora(s) de Boleto ...'
873:     *   EndIf
874:     *
875:     * ATENCAO - a mensagem eh calculada e NAO eh exibida, e isso eh FIEL: o
876:     * unico bloco do legado que mostra o Lbl_Erro (".Lbl_Erro.Visible = .T." +
877:     * ".Lbl_Erro.Caption = lcErro") esta COMENTADO (*!*) no SCX, junto com o
878:     * ".Cmd_Imprimir.Enabled = .F." que o acompanha. Ou seja: no legado em
879:     * producao lcErro tambem morre sem aparecer, o Lbl_Erro continua
880:     * Visible = .F. e o botao Imprimir NUNCA eh desabilitado. Reativar esse
881:     * bloco seria inventar comportamento que o legado nao tem - o valor fica
882:     * guardado em this_cErroImpressoras, que a Fase 3 ja declarou.
883:     *
884:     * O bypass por gb_4c_ModoTeste/gb_4c_ValidandoUI existe porque o harness
885:     * (TesteAutomatico.prg) define gnConnHandle = 0 DE PROPOSITO e espera que o
886:     * form pule as queries por esses flags, nao por checagem de handle: sem o
887:     * bypass, SQLEXEC falha, InicializarForm devolve .F., CREATEOBJECT devolve
888:     * .F. e o teste de instanciacao reprova sem nenhum erro de SQL no log.
889:     *--------------------------------------------------------------------------
890:     PROTECTED FUNCTION CarregarImpressoras()
891:         LOCAL loc_lSucesso, loc_oErro
892:         loc_lSucesso = .F.
893: 
894:         TRY
895:             DO CASE
896:                 CASE TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
897:                     *-- Harness: sem conexao, sem SQL. cursor_4c_ImpreV nao eh
898:                     *-- criado, e this_nQtdImp fica em 0.
899:                     loc_lSucesso = .T.
900: 
901:                 CASE TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
902:                     loc_lSucesso = .T.
903: 
904:                 OTHERWISE
905:                     loc_lSucesso = THIS.this_oBusinessObject.CarregarImpressorasConfiguradas()
906:             ENDCASE
907: 
908:             IF loc_lSucesso
909:                 THIS.this_cErroImpressoras = ""
910: 
911:                 IF THIS.this_nTpBol = 3 AND THIS.this_nVias = 0
912:                     THIS.this_cErroImpressoras = "Boleto Tipo 3 Sem Configura" + ;
913:                         CHR(231) + CHR(227) + "o do Tipo de Via. Contate o Suporte T" + ;
914:                         CHR(233) + "cnico."
915:                 ENDIF
916: 
917:                 IF THIS.this_oBusinessObject.this_nQtdImp = 0
918:                     THIS.this_cErroImpressoras = "Sistema N" + CHR(227) + ;
919:                         "o Apresenta Impressora(s) de Boleto Configurada(s). " + ;
920:                         "Contate o Suporte T" + CHR(233) + "cnico."
921:                 ENDIF
922:             ENDIF
923:         CATCH TO loc_oErro
924:             loc_lSucesso = .F.
925:             MsgErro(loc_oErro.Message + CHR(13) + ;
926:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
927:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.CarregarImpressoras")
928:         ENDTRY
929: 
930:         RETURN loc_lSucesso
931:     ENDFUNC
932: 
933:     *--------------------------------------------------------------------------
934:     * ConfigurarBotoes - Cria a barra de acao do legado: o CommandGroup
935:     * btnReport, com Cmd_Imprimir ("\<Imprimir") e Cmd_Sair ("Encerrar").
936:     *
937:     * Propriedades transcritas do dump (SIGOPIBO.btnReport), inclusive o
938:     * Top = -2 (o grupo comeca 2px ACIMA da borda do form, sobre a faixa do
939:     * cabecalho) e o Value = 2 de projeto, que o AplicarEstadoBotoes depois
940:     * troca para 1 - igual ao legado.
941:     *
942:     * ButtonCount eh a PRIMEIRA propriedade atribuida: CommandGroup criado por
943:     * AddObject nasce com ButtonCount = 0, e tocar em Buttons(N) antes disso
944:     * estoura "BUTTONS is not an object" (medido no VFP9 - o defeito eh de
945:     * PRE-CONDICAO, nao da sintaxe do WITH; com ButtonCount setado, qualquer
946:     * forma de WITH funciona).
947:     *
948:     * A geometria dos botoes INTERNOS eh aplicada ANTES de posicionar o grupo:
949:     * btnReport eh AutoSize = .T. e a altura/largura do grupo deriva dos
950:     * membros (5 + 75 + 5 = 85 de altura; 5 + 75 + 75 + 5 = 160 de largura -
951:     * exatamente o Height/Width que o SCX declara, que por isso tambem sao
952:     * transcritos sem conflito).
953:     *
954:     * NAO sao atribuidos no grupo: ForeColor, FontName/FontSize (CommandGroup
955:     * NAO TEM essas propriedades - atribuir derruba o Init e a tela nao abre).
956:     * A fonte e a cor moram nos MEMBROS, e eh assim que o SCX declara.
957:     *
958:     * O canonico cnt_4c_Saida (Left = 917, regra #10) NAO se aplica: ele eh dos
959:     * forms CRUD de 1000px de largura; aqui o form tem 600 e o botao ficaria
960:     * 300px fora da tela. Este dialogo tambem nao tem bloco de saida separado -
961:     * o Encerrar eh o 2o membro do proprio btnReport.
962:     *--------------------------------------------------------------------------
963:     PROTECTED PROCEDURE ConfigurarBotoes()
964:         LOCAL loc_oErro
965: 
966:         TRY
967:             THIS.AddObject("obj_4c_BtnReport", "CommandGroup")
968: 
969:             *-- ButtonCount antes de qualquer Buttons(N)
970:             THIS.obj_4c_BtnReport.ButtonCount = 2
971: 
972:             *-- Command1 -> Cmd_Imprimir
973:             WITH THIS.obj_4c_BtnReport.Buttons(1)
974:                 .Top         = 5
975:                 .Left        = 5
976:                 .Height      = 75
977:                 .Width       = 75
978:                 .FontBold    = .T.
979:                 .FontItalic  = .T.
980:                 .FontName    = "Comic Sans MS"
981:                 .FontSize    = 8
982:                 .Picture     = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
983:                 .Caption     = "\<Imprimir"
984:                 .ToolTipText = "Imprimir"
985:                 .ForeColor   = RGB(90, 90, 90)
986:                 .BackColor   = RGB(255, 255, 255)
987:                 .Themes      = .F.
988:             ENDWITH
989: 
990:             *-- Command2 -> Cmd_Sair (Cancel = .T.: eh o botao do ESC)
991:             WITH THIS.obj_4c_BtnReport.Buttons(2)
992:                 .Top        = 5
993:                 .Left       = 80
994:                 .Height     = 75
995:                 .Width      = 75
996:                 .FontBold   = .T.
997:                 .FontItalic = .T.
998:                 .FontName   = "Comic Sans MS"
999:                 .FontSize   = 8
1000:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1001:                 .Cancel     = .T.
1002:                 .Caption    = "Encerrar"
1003:                 .ForeColor  = RGB(90, 90, 90)

*-- Linhas 1021 a 1153:
1021:         CATCH TO loc_oErro
1022:             MsgErro(loc_oErro.Message + CHR(13) + ;
1023:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1024:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ConfigurarBotoes")
1025:         ENDTRY
1026:     ENDPROC
1027: 
1028:     *--------------------------------------------------------------------------
1029:     * ConfigurarEventos - Liga os eventos dos controles aos metodos do form.
1030:     * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT com metodo PROTECTED
1031:     * falha em SILENCIO - o controle fica inerte e nada aparece em log (regra
1032:     * #3). Pelo mesmo motivo os handlers de "KeyPress" declaram os parametros
1033:     * do evento.
1034:     *
1035:     * Chamado DEPOIS de todos os AddObject do form (ver InicializarForm, passo
1036:     * 5d): BINDEVENT sobre objeto inexistente estoura no proprio bind, e
1037:     * txt_4c_Qtde so nasce no ConfigurarControles.
1038:     *
1039:     * Os DOIS eventos do campo de quantidade apontam para o mesmo
1040:     * comportamento, por caminhos diferentes de o usuario sair do campo
1041:     * (mouse x teclado) - ver o cabecalho de ValidarQtde. O Valid do legado NAO
1042:     * eh ligado direto: BINDEVENT em "Valid" de TextBox nao dispara de forma
1043:     * confiavel.
1044:     *
1045:     * O ComboBox cbo_4c_Get_Printer e os tres checkboxes NAO recebem evento, e
1046:     * isso eh fiel: o dump do legado nao tem Valid/When/LostFocus/
1047:     * InteractiveChange em nenhum deles. A impressora escolhida eh lida do
1048:     * CURSOR na hora de imprimir (FormParaBO), que eh o que o
1049:     * Cmd_Imprimir.Click legado faz ("lcImp = crImpreV.IDupla"), e os
1050:     * checkboxes sao lidos no mesmo momento.
1051:     *--------------------------------------------------------------------------
1052:     PROTECTED PROCEDURE ConfigurarEventos()
1053:         LOCAL loc_oErro
1054: 
1055:         TRY
1056:             BINDEVENT(THIS.obj_4c_BtnReport.Buttons(1), "Click", THIS, "BtnImprimirClick")
1057:             BINDEVENT(THIS.obj_4c_BtnReport.Buttons(2), "Click", THIS, "BtnEncerrarClick")
1058: 
1059:             *-- getQtde: PROCEDURE Valid legado. "LostFocus" eh o equivalente
1060:             *-- fiel (dispara ao SAIR do campo, inclusive pelo mouse);
1061:             *-- "KeyPress" da a confirmacao imediata em ENTER/TAB.
1062:             BINDEVENT(THIS.txt_4c_Qtde, "LostFocus", THIS, "ValidarQtde")
1063:             BINDEVENT(THIS.txt_4c_Qtde, "KeyPress", THIS, "ValidarQtdeKeyPress")
1064:         CATCH TO loc_oErro
1065:             MsgErro(loc_oErro.Message + CHR(13) + ;
1066:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1067:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ConfigurarEventos")
1068:         ENDTRY
1069:     ENDPROC
1070: 
1071:     *--------------------------------------------------------------------------
1072:     * ConfigurarControles - Cria o bloco da IMPRESSORA e da QUANTIDADE DE VIAS:
1073:     * os 7 controles que o legado desenha entre Top 89 e Top 174 e que formam
1074:     * uma unidade funcional (em qual impressora e em quantas vias sair).
1075:     *
1076:     *   SIGOPIBO.Lbl_Impressora -> lbl_4c_Lbl_Impressora   "Impressoras :"
1077:     *   SIGOPIBO.Label1         -> lbl_4c_Label1           "Sistema"
1078:     *   SIGOPIBO.Label2         -> lbl_4c_Label2           "Windows"
1079:     *   SIGOPIBO.Opt_Impressora -> obj_4c_Opt_Impressora   (OptionGroup OCULTO)
1080:     *   SIGOPIBO.Get_Printer    -> cbo_4c_Get_Printer      (ComboBox)
1081:     *   SIGOPIBO.Say9           -> lbl_4c_Label9           "Qtde. de Vias :"
1082:     *   SIGOPIBO.getQtde        -> txt_4c_Qtde             (TextBox)
1083:     *
1084:     * Form OPERACIONAL FLAT: os sete sao filhos DIRETOS do form, como no SCX -
1085:     * nao ha Page nem container de dados onde pendura-los, e nenhum deles
1086:     * recebe compensacao de Top (a compensacao "+29" eh dos forms com PageFrame
1087:     * em Top = -29, que este legado nao tem).
1088:     *
1089:     * Os dois Label de cabecalho ("Sistema" e "Windows") rotulam as duas metades
1090:     * do que o ComboBox exibe: o legado monta a coluna IDupla como
1091:     * PADR(ALLTRIM(impressora do SISTEMA), 15) + " " + ALLTRIM(impressora do
1092:     * WINDOWS), e as duas legendas ficam exatamente sobre o inicio de cada
1093:     * metade (Left 125 e 242, contra o combo em Left 122).
1094:     *
1095:     * Decisoes de transcricao detalhadas no cabecalho do arquivo (secao da
1096:     * Fase 5): ControlSource vazio e ZOrderSet descartados, AutoSize = .F.
1097:     * explicito nos rotulos, BackStyle da classe "say" reposto em lbl_4c_Label9,
1098:     * fonte da classe "fwget" reposta em txt_4c_Qtde, ForeColor no MEMBRO do
1099:     * OptionGroup e Buttons(1).Value nao escrito.
1100:     *
1101:     * TabIndex NAO eh atribuido aqui, e isso NAO eh esquecimento: com AddObject
1102:     * o VFP9 clampa TabIndex a quantidade de controles focalizaveis que ja
1103:     * existem no container, e depois desta fase sao 4 (btnReport, Opt_Impressora,
1104:     * Get_Printer, getQtde) contra os valores 2/3/7/9/8/10/10 que o SCX declara.
1105:     * Escrever ".TabIndex = 7" agora gravaria 4 - uma linha que mente sobre o
1106:     * valor efetivo. A numeracao inteira mora na fase que criar o ULTIMO
1107:     * AddObject do form, em ordem ASCENDENTE e so nos focalizaveis (Label e
1108:     * Container tem TabIndex mas nao tem TabStop: numera-los apenas embaralha a
1109:     * sequencia). Dentro do OptionGroup o caso eh outro e por isso o TabIndex
1110:     * DO MEMBRO eh transcrito: Buttons(1).TabIndex = 1 esta dentro da faixa
1111:     * 1..ButtonCount (que ja vale 1) e grava o valor exato do SCX.
1112:     *--------------------------------------------------------------------------
1113:     PROTECTED PROCEDURE ConfigurarControles()
1114:         LOCAL loc_oErro
1115: 
1116:         TRY
1117:             *-- Lbl_Impressora (SIGOPIBO.Lbl_Impressora): rotulo do bloco.
1118:             *-- Classe "label" do VFP, e o SCX declara BackStyle = 0.
1119:             THIS.AddObject("lbl_4c_Lbl_Impressora", "Label")
1120:             WITH THIS.lbl_4c_Lbl_Impressora
1121:                 *-- O SCX declara AutoSize = .T.; ver regra #23 e o cabecalho
1122:                 *-- deste arquivo - Width/Height do dump SAO o auto-size
1123:                 .AutoSize  = .F.
1124:                 .FontBold  = .T.
1125:                 .FontName  = "Tahoma"
1126:                 .FontSize  = 8
1127:                 .BackStyle = 0
1128:                 .Caption   = "Impressoras :"
1129:                 .Height    = 15
1130:                 .Left      = 121
1131:                 .Top       = 89
1132:                 .Width     = 80
1133:                 .ForeColor = RGB(90, 90, 90)
1134:             ENDWITH
1135: 
1136:             *-- Label1 (SIGOPIBO.Label1): cabecalho da 1a metade do IDupla.
1137:             *-- FontBold = .F. transcrito do SCX - os dois cabecalhos de coluna
1138:             *-- sao mais leves que o rotulo "Impressoras :" acima.
1139:             THIS.AddObject("lbl_4c_Label1", "Label")
1140:             WITH THIS.lbl_4c_Label1
1141:                 .AutoSize  = .F.
1142:                 .FontBold  = .F.
1143:                 .FontName  = "Tahoma"
1144:                 .FontSize  = 8
1145:                 .BackStyle = 0
1146:                 .Caption   = "Sistema"
1147:                 .Height    = 15
1148:                 .Left      = 125
1149:                 .Top       = 137
1150:                 .Width     = 39
1151:                 .ForeColor = RGB(90, 90, 90)
1152:             ENDWITH
1153: 

*-- Linhas 1176 a 1302:
1176:             *-- para o combobox", comentario datado de 05/03/2015 no proprio
1177:             *-- SCX). O controle eh criado porque o SCX o tem e o dump declara
1178:             *-- geometria e caption dele - reativa-lo seria inventar UX.
1179:             THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
1180: 
1181:             *-- ButtonCount ANTES de qualquer Buttons(N): OptionGroup criado por
1182:             *-- AddObject nasce com ButtonCount = 0
1183:             THIS.obj_4c_Opt_Impressora.ButtonCount = 1
1184: 
1185:             *-- Option1: a fonte e a COR moram no membro - OptionGroup nao tem
1186:             *-- FontName/FontSize/ForeColor (regra #33)
1187:             WITH THIS.obj_4c_Opt_Impressora.Buttons(1)
1188:                 .FontName  = "Tahoma"
1189:                 .FontSize  = 8
1190:                 .BackStyle = 0
1191:                 .Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
1192:                 .Height    = 16
1193:                 .Left      = 9
1194:                 .Style     = 0
1195:                 .TabIndex  = 1
1196:                 .Top       = 10
1197:                 .Width     = 306
1198:                 *-- AutoSize = .F. do SCX, com a Width que o Designer calculou
1199:                 .AutoSize  = .F.
1200:                 .ForeColor = RGB(90, 90, 90)
1201:             ENDWITH
1202: 
1203:             *-- Grupo, depois do membro. ".Value = 1" eh a selecao do GRUPO (o
1204:             *-- "Value = 1" que o SCX declara no proprio Opt_Impressora);
1205:             *-- "Option1.Value = 1" do dump nao eh escrito - num OptionGroup a
1206:             *-- selecao eh gerenciada pelo grupo, e escrever no membro produz
1207:             *-- botao marcado de forma espuria.
1208:             WITH THIS.obj_4c_Opt_Impressora
1209:                 .BackStyle   = 0
1210:                 .BorderStyle = 0
1211:                 .Value       = 1
1212:                 .Height      = 25
1213:                 .Left        = 115
1214:                 .Top         = 147
1215:                 .Width       = 321
1216:                 *-- Visible = .F. do SCX. AddObject ja cria oculto, mas a linha
1217:                 *-- fica explicita porque eh ESTADO DE PROJETO, nao artefato da
1218:                 *-- criacao - e o nome deste controle ja esta na lista de
1219:                 *-- excecao do TornarControlesVisiveis, que de outro modo o
1220:                 *-- exibiria junto com o resto da arvore.
1221:                 .Visible     = .F.
1222:             ENDWITH
1223: 
1224:             *-- Get_Printer (SIGOPIBO.Get_Printer): a lista de impressoras ATUAL.
1225:             *-- Style = 2 (Dropdown List - o usuario escolhe, nao digita) e
1226:             *-- RowSourceType = 2 (Alias) transcritos do SCX. RowSourceType eh
1227:             *-- definido JA AQUI, antes do RowSource logo abaixo.
1228:             *-- "ControlSource = """ do dump nao eh transcrito (override vazio).
1229:             THIS.AddObject("cbo_4c_Get_Printer", "ComboBox")
1230:             WITH THIS.cbo_4c_Get_Printer
1231:                 .FontName          = "Tahoma"
1232:                 .FontSize          = 8
1233:                 .BoundColumn       = 1
1234:                 .RowSourceType     = 2
1235:                 .Height            = 23
1236:                 .Left              = 122
1237:                 .SpecialEffect     = 1
1238:                 .Style             = 2
1239:                 .Top               = 174
1240:                 .Width             = 240
1241:                 .DisabledBackColor = RGB(238, 238, 238)
1242:                 .DisabledForeColor = RGB(0, 0, 128)
1243:                 .BorderColor       = RGB(100, 100, 100)
1244:                 .BoundTo           = .F.
1245:             ENDWITH
1246: 
1247:             *-- Vinculo do combo ao cursor das impressoras, na MESMA ORDEM do
1248:             *-- Init legado:
1249:             *--     SELECT crImpreV
1250:             *--     GO top
1251:             *--     thisform.get_Printer.value     = RECNO('crImpreV')
1252:             *--     thisform.get_Printer.RowSource = 'crImpreV'
1253:             *--     thisform.get_Printer.Refresh
1254:             *-- O Value NUMERICO antes do RowSource eh deliberado e eh o que o
1255:             *-- legado faz: com BoundTo = .F. um Value numerico vale pelo
1256:             *-- ListIndex, ou seja "selecione a N-esima linha" - e N eh o
1257:             *-- registro em que o cursor esta posicionado.
1258:             *-- A guarda de USED() existe porque o cursor NAO existe em harness:
1259:             *-- CarregarImpressoras devolve .T. sem consultar quando
1260:             *-- gb_4c_ModoTeste/gb_4c_ValidandoUI estao ligados, e ligar
1261:             *-- RowSource a alias inexistente derruba o Init inteiro (regra #41),
1262:             *-- deixando CREATEOBJECT devolver .F. sem erro nenhum no log.
1263:             IF USED("cursor_4c_ImpreV")
1264:                 SELECT cursor_4c_ImpreV
1265:                 GO TOP
1266:                 THIS.cbo_4c_Get_Printer.Value     = RECNO("cursor_4c_ImpreV")
1267:                 THIS.cbo_4c_Get_Printer.RowSource = "cursor_4c_ImpreV"
1268:                 THIS.cbo_4c_Get_Printer.Refresh()
1269:             ENDIF
1270: 
1271:             *-- Say9 (SIGOPIBO.Say9) -> lbl_4c_Label9: rotulo da quantidade de
1272:             *-- vias. Classe "say" do framework.vcx, que eh TRANSPARENTE por
1273:             *-- heranca - o dump nao declara BackStyle porque nao precisa, mas
1274:             *-- aqui o controle eh um Label BASE, cujo default eh OPACO: sem
1275:             *-- .BackStyle = 0 o rotulo sairia com um retangulo pintado sobre o
1276:             *-- fundo do form. Repor o default da classe nao eh invencao.
1277:             *-- "ZOrderSet = 27" do dump nao eh transcrito (regra #33).
1278:             THIS.AddObject("lbl_4c_Label9", "Label")
1279:             WITH THIS.lbl_4c_Label9
1280:                 .AutoSize  = .F.
1281:                 .FontName  = "Tahoma"
1282:                 .FontSize  = 8
1283:                 .BackStyle = 0
1284:                 .Caption   = "Qtde. de Vias :"
1285:                 .Height    = 15
1286:                 .Left      = 384
1287:                 .Top       = 158
1288:                 .Width     = 74
1289:                 .ForeColor = RGB(90, 90, 90)
1290:             ENDWITH
1291: 
1292:             *-- getQtde (SIGOPIBO.getQtde) -> txt_4c_Qtde: a quantidade de vias.
1293:             *-- Classe "fwget" do framework.vcx; FontName/FontSize vem da classe
1294:             *-- (ver cabecalho) e nao do instance level.
1295:             *-- InputMask = "9" + MaxLength = 1: um unico DIGITO. A mascara
1296:             *-- numerica esta correta aqui porque o .Value eh NUMERICO - o
1297:             *-- Init legado faz ".getQtde.Value = .vnQBols" -, e nao uma string
1298:             *-- (mascara "9" sobre campo CHAR bloquearia letras indevidamente).
1299:             *-- Alignment nao eh atribuido: o dump nao declara, e o default do
1300:             *-- TextBox ja alinha valor numerico a direita.
1301:             *-- "ZOrderSet = 44" do dump nao eh transcrito (regra #33).
1302:             THIS.AddObject("txt_4c_Qtde", "TextBox")

*-- Linhas 1316 a 1415:
1316:         CATCH TO loc_oErro
1317:             MsgErro(loc_oErro.Message + CHR(13) + ;
1318:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1319:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ConfigurarControles")
1320:         ENDTRY
1321:     ENDPROC
1322: 
1323:     *--------------------------------------------------------------------------
1324:     * ConfigurarOpcoes - Cria o bloco de OPCOES DE IMPRESSAO e o conteudo do
1325:     * painel flutuante: a OUTRA metade dos controles do dump, que a fase
1326:     * anterior deixou registrada como pendencia.
1327:     *
1328:     *   SIGOPIBO.chkCarne         -> chk_4c_ChkCarne   "Imprimir Carne"
1329:     *   SIGOPIBO.chkObss          -> chk_4c_ChkObss    "Imprimir Observacoes"
1330:     *   SIGOPIBO.chkAgrupa        -> chk_4c_ChkAgrupa  "Agrupar Informacoes"
1331:     *   SIGOPIBO.Lbl_Erro         -> lbl_4c_Lbl_Erro   (aviso OCULTO)
1332:     *   SIGOPIBO.Container1.Edit1 -> cnt_4c_Container1.obj_4c_Edit1  (EditBox)
1333:     *
1334:     * Os tres checkboxes e o Lbl_Erro sao filhos DIRETOS do form, como no SCX;
1335:     * o EditBox eh filho do cnt_4c_Container1, que a Fase 3 ja criou vazio.
1336:     *
1337:     * VISIBILIDADE: os tres checkboxes nascem com o Visible que o AddObject da
1338:     * (.F.) e sao resolvidos por AplicarVisibilidadeOpcoes, DEPOIS do
1339:     * TornarControlesVisiveis - nao aqui. Ja o Lbl_Erro nasce OCULTO por
1340:     * PROJETO (Visible = .F. no SCX) e o nome dele ja esta na lista de excecao
1341:     * do TornarControlesVisiveis desde a Fase 3, por isso a linha fica
1342:     * explicita abaixo.
1343:     *
1344:     * CheckBox.Value NUMERICO (1/0), nao LOGICO, apesar de o SCX declarar
1345:     * .T./.T./.F.: CheckBox criado por AddObject assume o TIPO do que lhe for
1346:     * atribuido, e o canonico do projeto eh numerico - misturar os dois tipos
1347:     * entre a criacao e a leitura estoura "Operator/operand type mismatch". A
1348:     * leitura (FormParaBO) passa por ConverterParaLogico, que
1349:     * tolera os dois, e o Init ja gravou os mesmos defaults no Business Object.
1350:     *
1351:     * AutoSize: os tres checkboxes declaram AutoSize = .T. no SCX e os TRES
1352:     * recebem .AutoSize = .F. com Width/Height EXPLICITOS - regra #23. Medido
1353:     * no VFP9 (automation\_tmp746\medir746b.prg): CheckBox criado por AddObject
1354:     * com AutoSize = .T. fica nos 100x17 do DEFAULT enquanto esta invisivel
1355:     * (tres ordens de atribuicao testadas, todas 100x17) e so recalcula ao
1356:     * ficar visivel - ou seja declarar .T. seria uma linha que mente sobre o
1357:     * valor efetivo durante toda a montagem, inclusive na hora em que o
1358:     * AplicarTabIndex e as checagens de sobreposicao olham a geometria.
1359:     *
1360:     * chkCarne eh o UNICO controle deste dump que nao declara Width/Height
1361:     * (os irmaos declaram: chkObss 122x15, chkAgrupa 120x15). A largura NAO eh
1362:     * herdada do default 100 nem estimada: foi MEDIDA no VFP9 com o mesmo
1363:     * procedimento que reproduz os dois valores conhecidos - ligando o controle
1364:     * com AutoSize = .T. e lendo a Width resultante, o caption "Imprimir
1365:     * Observacoes" devolve 122 e "Agrupar Informacoes" devolve 120, EXATAMENTE
1366:     * os numeros que o SCX declara; o mesmo procedimento devolve 88x15 para
1367:     * "Imprimir Carne". Isto e: 88 eh o auto-size que o Form Designer teria
1368:     * gravado, e o metodo se valida nos dois casos em que ha gabarito.
1369:     * Conferido o cruzamento lateral da linha Top = 89 (regra #28):
1370:     * Lbl_Impressora 121..201 / chkCarne 218..306 / chkAgrupa 351..471 - folga
1371:     * de 17px e de 45px, nenhuma sobreposicao. Com o default 100 a faixa iria
1372:     * a 318 e, embora ainda nao cruzasse o chkAgrupa, sobrariam 12px de caixa
1373:     * transparente depois do texto.
1374:     *--------------------------------------------------------------------------
1375:     PROTECTED PROCEDURE ConfigurarOpcoes()
1376:         LOCAL loc_oErro
1377: 
1378:         TRY
1379:             *-- chkCarne (SIGOPIBO.chkCarne): "Imprimir Carne". Classe
1380:             *-- "fwcheckbox" do framework.vcx; o SCX declara FontName/FontSize
1381:             *-- no instance level, entao os dois sao transcritos.
1382:             *-- Width/Height MEDIDOS (ver cabecalho deste metodo) - sao os
1383:             *-- unicos deste dump que nao vem do SCX, porque o SCX nao os tem.
1384:             THIS.AddObject("chk_4c_ChkCarne", "CheckBox")
1385:             WITH THIS.chk_4c_ChkCarne
1386:                 .FontName  = "Tahoma"
1387:                 .FontSize  = 8
1388:                 .AutoSize  = .F.
1389:                 .Alignment = 0
1390:                 .BackStyle = 0
1391:                 .Caption   = "Imprimir Carn" + CHR(234)
1392:                 .Height    = 15
1393:                 .Left      = 218
1394:                 .Top       = 89
1395:                 .Width     = 88
1396:                 *-- SCX: Value = .T. (ver cabecalho: numerico, nao logico)
1397:                 .Value     = 1
1398:                 .ForeColor = RGB(90, 90, 90)
1399:             ENDWITH
1400: 
1401:             *-- chkObss (SIGOPIBO.chkObss): "Imprimir Observacoes"
1402:             THIS.AddObject("chk_4c_ChkObss", "CheckBox")
1403:             WITH THIS.chk_4c_ChkObss
1404:                 .FontName  = "Tahoma"
1405:                 .FontSize  = 8
1406:                 .AutoSize  = .F.
1407:                 .Alignment = 0
1408:                 .BackStyle = 0
1409:                 .Caption   = "Imprimir Observa" + CHR(231) + CHR(245) + "es"
1410:                 .Height    = 15
1411:                 .Left      = 218
1412:                 .Top       = 109
1413:                 .Width     = 122
1414:                 *-- SCX: Value = .T.
1415:                 .Value     = 1

*-- Linhas 1473 a 2016:
1473:                 *-- Visible = .F. do SCX. AddObject ja cria oculto, mas a linha
1474:                 *-- fica explicita porque eh ESTADO DE PROJETO, nao artefato da
1475:                 *-- criacao - e o nome deste controle ja esta na lista de
1476:                 *-- excecao do TornarControlesVisiveis.
1477:                 .Visible   = .F.
1478:             ENDWITH
1479: 
1480:             *-- Z-ORDER: no SCX o Container1 eh declarado DEPOIS do Lbl_Erro,
1481:             *-- logo desenha POR CIMA dele. Aqui a ordem eh invertida por
1482:             *-- necessidade - cnt_4c_Container1 nasce no ConfigurarPageFrame,
1483:             *-- que tem de ser o PRIMEIRO AddObject do form (regra #11) - e as
1484:             *-- duas faixas se cruzam de verdade: Lbl_Erro ocupa 132..468 x
1485:             *-- 250..278 e o container ocupa 60..540 x 203..473. Mandar o label
1486:             *-- para o FUNDO (ZOrder(1)) restaura o empilhamento do legado.
1487:             *-- Hoje os dois nunca estao visiveis ao mesmo tempo, mas sem esta
1488:             *-- linha o label apareceria SOBRE o texto do boleto se alguem
1489:             *-- reativasse o bloco comentado.
1490:             THIS.lbl_4c_Lbl_Erro.ZOrder(1)
1491: 
1492:             *-- Edit1 (SIGOPIBO.Container1.Edit1) -> obj_4c_Edit1: a caixa que
1493:             *-- exibe o conteudo de BOLETO.txt depois da impressao. Filho do
1494:             *-- cnt_4c_Container1 (criado vazio na Fase 3), e eh o membro que o
1495:             *-- ExibirConteudoBoleto preenche no Click do Imprimir.
1496:             *-- AddObject chamado FORA de qualquer WITH e o WITH aberto pelo
1497:             *-- caminho completo: WITH aninhado sobre AddObject descarta
1498:             *-- propriedades em silencio.
1499:             *-- .Value = "" inicializa o EditBox como CHARACTER - o conteudo
1500:             *-- que chega eh o FILETOSTR do BOLETO.txt, e EditBox sem
1501:             *-- inicializacao assume o tipo do primeiro valor atribuido.
1502:             *-- ReadOnly = .T. do SCX: o painel eh de LEITURA.
1503:             *-- DisabledBackColor transcrito do dump - ele so pinta se o
1504:             *-- controle for desabilitado (o que o legado nunca faz), mas eh
1505:             *-- propriedade declarada e por isso vai junto.
1506:             THIS.cnt_4c_Container1.AddObject("obj_4c_Edit1", "EditBox")
1507:             WITH THIS.cnt_4c_Container1.obj_4c_Edit1
1508:                 .FontName          = "Tahoma"
1509:                 .FontSize          = 8
1510:                 .Value             = ""
1511:                 .Height            = 236
1512:                 .Left              = 22
1513:                 .ReadOnly          = .T.
1514:                 .Top               = 18
1515:                 .Width             = 434
1516:                 .DisabledBackColor = RGB(255, 255, 255)
1517:             ENDWITH
1518:         CATCH TO loc_oErro
1519:             MsgErro(loc_oErro.Message + CHR(13) + ;
1520:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1521:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ConfigurarOpcoes")
1522:         ENDTRY
1523:     ENDPROC
1524: 
1525:     *--------------------------------------------------------------------------
1526:     * AplicarTabIndex - Numera a ordem de tabulacao dos controles FOCALIZAVEIS.
1527:     *
1528:     * Roda SO depois que TODOS os AddObject do form existem (eh o que as fases
1529:     * 3, 4 e 5 registraram como pendencia explicita): com AddObject o VFP9
1530:     * numera o TabIndex pela ORDEM DE CRIACAO, que nao tem relacao com a ordem
1531:     * do legado, e o Tab anda errado sem erro, sem log e sem aparecer em
1532:     * screenshot.
1533:     *
1534:     * A ordem vem dos TabIndex que o SCX declara:
1535:     *   Get_Printer=2, getQtde=3, Opt_Impressora=7, chkCarne=8, btnReport=9,
1536:     *   chkObss=10, chkAgrupa=10
1537:     * Os valores sao REINDEXADOS para 1..7, e isso nao eh desvio do PILAR 1:
1538:     * TabIndex eh POSICAO num vetor, nao identificador - o VFP9 clampa qualquer
1539:     * valor acima da quantidade de posicoes do container, entao ".TabIndex = 10"
1540:     * num form com 7 focalizaveis gravaria 7. O que o usuario percebe eh a
1541:     * SEQUENCIA, e ela fica identica a do legado porque os objetos do SCX que
1542:     * ficaram de fora da lista (Lbl_Impressora=1, Label1=4, Label2=5,
1543:     * Lbl_Erro=6, Container1=11, Say9=12) sao Labels e Containers: tem TabIndex
1544:     * mas nao tem TabStop, nunca param o Tab e portanto nao ocupam posicao
1545:     * efetiva. Numera-los apenas embaralharia a sequencia dos que param.
1546:     *
1547:     * chkObss e chkAgrupa tem o MESMO TabIndex = 10 no SCX (o Form Designer
1548:     * permite o empate). O VFP desempata pela ordem de criacao, e no SCX o
1549:     * chkObss eh declarado antes - por isso ele recebe 6 e o chkAgrupa 7.
1550:     *
1551:     * As atribuicoes vao em ordem ASCENDENTE porque gravar um TabIndex
1552:     * REORDENA os irmaos: fora de ordem, cada atribuicao empurra a anterior e o
1553:     * resultado final nao eh o pretendido.
1554:     *--------------------------------------------------------------------------
1555:     PROTECTED PROCEDURE AplicarTabIndex()
1556:         LOCAL loc_oErro
1557: 
1558:         TRY
1559:             THIS.cbo_4c_Get_Printer.TabIndex    = 1    && SCX Get_Printer    = 2
1560:             THIS.txt_4c_Qtde.TabIndex           = 2    && SCX getQtde        = 3
1561:             THIS.obj_4c_Opt_Impressora.TabIndex = 3    && SCX Opt_Impressora = 7
1562:             THIS.chk_4c_ChkCarne.TabIndex       = 4    && SCX chkCarne       = 8
1563:             THIS.obj_4c_BtnReport.TabIndex      = 5    && SCX btnReport      = 9
1564:             THIS.chk_4c_ChkObss.TabIndex        = 6    && SCX chkObss        = 10
1565:             THIS.chk_4c_ChkAgrupa.TabIndex      = 7    && SCX chkAgrupa      = 10
1566:         CATCH TO loc_oErro
1567:             MsgErro(loc_oErro.Message + CHR(13) + ;
1568:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1569:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.AplicarTabIndex")
1570:         ENDTRY
1571:     ENDPROC
1572: 
1573:     *--------------------------------------------------------------------------
1574:     * AplicarVisibilidadeOpcoes - Transcreve o bloco do Init legado que decide
1575:     * quais dos tres checkboxes de opcao aparecem, conforme o tipo de boleto:
1576:     *
1577:     *   ThisForm.chkObss.Visible   =  (.vnTpBol = 17)
1578:     *   ThisForm.chkCarne.Visible  = !(.vnTpBol = 17)
1579:     *   Thisform.chkAgrupa.Visible =  (.vnTpBol = 3)
1580:     *   ThisForm.chkObss.Visible   = !(.vnTpBol = 18)
1581:     *   ThisForm.chkCarne.Visible  =  (.vnTpBol = 18)
1582:     *
1583:     * chkObss e chkCarne recebem Visible DUAS vezes seguidas, sem IF entre as
1584:     * atribuicoes: so a ULTIMA tem efeito, e por isso o resultado observavel eh
1585:     * "chkObss aparece quando TpBol <> 18" e "chkCarne aparece quando
1586:     * TpBol = 18" - as duas primeiras atribuicoes (o caso 17) nunca chegam a
1587:     * ser vistas na tela. Os tres predicados moram no Business Object
1588:     * (DeveExibirImprimirObservacoes / DeveExibirImprimirCarne /
1589:     * DeveExibirAgruparInformacoes), que eh a fonte unica: o form so espelha.
1590:     *
1591:     * Roda DEPOIS do TornarControlesVisiveis, e nao dentro do ConfigurarOpcoes:
1592:     * o TornarControlesVisiveis percorre a arvore INTEIRA forcando
1593:     * Visible = .T., entao qualquer decisao de visibilidade tomada antes dele
1594:     * seria APAGADA. Nao se resolve pela lista de excecao daquele metodo porque
1595:     * aqui a visibilidade nao eh fixa - depende do tipo de boleto recebido.
1596:     *--------------------------------------------------------------------------
1597:     PROTECTED PROCEDURE AplicarVisibilidadeOpcoes()
1598:         LOCAL loc_oErro
1599: 
1600:         TRY
1601:             THIS.chk_4c_ChkObss.Visible = ;
1602:                 THIS.this_oBusinessObject.DeveExibirImprimirObservacoes()
1603: 
1604:             THIS.chk_4c_ChkCarne.Visible = ;
1605:                 THIS.this_oBusinessObject.DeveExibirImprimirCarne()
1606: 
1607:             THIS.chk_4c_ChkAgrupa.Visible = ;
1608:                 THIS.this_oBusinessObject.DeveExibirAgruparInformacoes()
1609:         CATCH TO loc_oErro
1610:             MsgErro(loc_oErro.Message + CHR(13) + ;
1611:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1612:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.AplicarVisibilidadeOpcoes")
1613:         ENDTRY
1614:     ENDPROC
1615: 
1616:     *--------------------------------------------------------------------------
1617:     * ValidarQtde - Transcreve o PROCEDURE Valid de getQtde (o UNICO Valid do
1618:     * dump deste legado):
1619:     *
1620:     *   If (ThisForm.getQtde.Value > 0)
1621:     *       ThisForm.vnQBols = ThisForm.getQtde.Value
1622:     *   EndIf
1623:     *
1624:     * Isto e: o valor digitado passa a ser a quantidade de boletos a imprimir,
1625:     * mas ZERO (ou campo apagado) NAO zera a quantidade - o valor anterior
1626:     * continua valendo. Essa guarda eh a regra, nao um detalhe: zerar faria o
1627:     * Do SigBlBol receber qBols = 0 e nao imprimir nada.
1628:     *
1629:     * O destino eh o Business Object. No legado vnQBols eh property do FORM e o
1630:     * Cmd_Imprimir.Click a le ("lnQtdBols = .vnQBols") para passar ao SigBlBol;
1631:     * nesta arquitetura quem monta a chamada eh SigOpIboBO.ExecutarImpressao,
1632:     * que le THIS.this_nQBols do BO. O espelho no form eh atualizado junto,
1633:     * porque eh a copia que o resto da tela consulta (mesma relacao que o Init
1634:     * estabelece: o BO decide, o form copia).
1635:     *
1636:     * LIGACAO AOS EVENTOS - sao DOIS, e cada um resolve um caminho diferente de
1637:     * o usuario sair do campo:
1638:     *   "LostFocus" -> este metodo. Eh o equivalente fiel do Valid: dispara ao
1639:     *       SAIR do campo, inclusive quando o usuario vai direto ao botao
1640:     *       Imprimir com o MOUSE, sem teclar nada. Sem ele, digitar 3 e clicar
1641:     *       Imprimir mandaria imprimir a quantidade ANTIGA - em silencio.
1642:     *   "KeyPress" -> ValidarQtdeKeyPress, que aplica o guard de ENTER/TAB e
1643:     *       delega para ca. Da a resposta imediata de quem confirma pelo
1644:     *       teclado. BINDEVENT em "Valid" de TextBox nao dispara de forma
1645:     *       confiavel, e por isso o Valid do legado nao eh ligado direto.
1646:     * Os dois caminhos sao idempotentes (a chamada so copia um numero), entao
1647:     * TAB - que dispara KeyPress e depois LostFocus - executar duas vezes nao
1648:     * tem efeito colateral. Nao ha guarda de reentrancia porque este metodo nao
1649:     * abre dialogo nenhum e nao mexe no foco: os dois motivos pelos quais um
1650:     * handler de LostFocus se redispara.
1651:     *
1652:     * PUBLIC (sem PROTECTED) porque eh chamado por BINDEVENT: metodo PROTECTED
1653:     * ligado por BINDEVENT falha em SILENCIO - o campo fica inerte e nada
1654:     * aparece em log (regra #3).
1655:     *
1656:     * O PROCEDURE When de getQtde ("Return .t.") NAO vira metodo: .T.
1657:     * incondicional eh exatamente o default do VFP9 para When, logo o
1658:     * comportamento ja esta reproduzido sem codigo. Escrever um handler que so
1659:     * devolve .T. seria um metodo vazio.
1660:     *
1661:     * O VARTYPE antes da comparacao nao eh defensividade solta: ">" entre
1662:     * CHARACTER e numero estoura "Operator/operand type mismatch", e .Value de
1663:     * TextBox assume o tipo do ultimo valor atribuido - aqui ele nasce NUMERICO
1664:     * (o ConfigurarControles faz ".Value = THIS.this_nQBols", como o
1665:     * ".getQtde.Value = .vnQBols" do Init legado), mas um codigo futuro que
1666:     * atribuisse string deixaria de ser pego por gate nenhum.
1667:     *--------------------------------------------------------------------------
1668:     PROCEDURE ValidarQtde()
1669:         LOCAL loc_uValor, loc_nQtde, loc_oErro
1670: 
1671:         TRY
1672:             loc_uValor = THIS.txt_4c_Qtde.Value
1673: 
1674:             DO CASE
1675:                 CASE VARTYPE(loc_uValor) = "N"
1676:                     loc_nQtde = loc_uValor
1677:                 CASE VARTYPE(loc_uValor) = "C"
1678:                     loc_nQtde = VAL(loc_uValor)
1679:                 OTHERWISE
1680:                     loc_nQtde = 0
1681:             ENDCASE
1682: 
1683:             *-- "If (ThisForm.getQtde.Value > 0)" - zero NAO sobrescreve
1684:             IF loc_nQtde > 0
1685:                 THIS.this_nQBols = loc_nQtde
1686: 
1687:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1688:                     THIS.this_oBusinessObject.this_nQBols = loc_nQtde
1689:                 ENDIF
1690:             ENDIF
1691:         CATCH TO loc_oErro
1692:             MsgErro(loc_oErro.Message + CHR(13) + ;
1693:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1694:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ValidarQtde")
1695:         ENDTRY
1696:     ENDPROC
1697: 
1698:     *--------------------------------------------------------------------------
1699:     * ValidarQtdeKeyPress - Handler de "KeyPress" do campo de quantidade.
1700:     * So confirma o valor em ENTER(13) e TAB(9) e delega para THIS.ValidarQtde.
1701:     *
1702:     * Os parametros do evento SAO declarados: handler ligado a "KeyPress" sem
1703:     * eles estoura a CADA tecla digitada (regra #3). E o guard eh obrigatorio
1704:     * pelo motivo oposto - sem ele o handler rodaria a cada caractere, que eh a
1705:     * familia de defeito da regra #47.
1706:     *
1707:     * Metodo SEPARADO de ValidarQtde, e nao o mesmo ligado aos dois eventos,
1708:     * porque "LostFocus" nao passa parametro nenhum: os dois argumentos
1709:     * chegariam como .F. LOGICO e a comparacao "par_nKeyCode = 13" estouraria
1710:     * "Operator/operand type mismatch" justamente no caminho do mouse.
1711:     *
1712:     * PUBLIC (sem PROTECTED) - BINDEVENT com metodo PROTECTED falha em silencio.
1713:     *--------------------------------------------------------------------------
1714:     PROCEDURE ValidarQtdeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1715:         IF VARTYPE(par_nKeyCode) = "N"
1716:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1717:                 THIS.ValidarQtde()
1718:             ENDIF
1719:         ENDIF
1720:     ENDPROC
1721:     *--------------------------------------------------------------------------
1722:     * AplicarEstadoBotoes - Transcreve o bloco final do Init legado:
1723:     *
1724:     *   With .btnReport
1725:     *       If .Cmd_Imprimir.Enabled
1726:     *           .Value = 1
1727:     *           .Cmd_Sair.Enabled = Not llSair
1728:     *       Else
1729:     *           .Value = 2
1730:     *           .Cmd_Sair.Enabled = .T.
1731:     *           .Cmd_Sair.SetFocus
1732:     *       EndIf
1733:     *   EndWith
1734:     *
1735:     * llSair eh THIS.this_lBloquearEncerrar, resolvido no Init pelo
1736:     * ResolverBloqueioEncerrar (Protocolo de Cheque + INSERIR + PROTSEMPRE).
1737:     *
1738:     * O ramo ELSE eh transcrito mesmo sendo inalcancavel hoje: nenhum codigo
1739:     * ATIVO do legado desabilita Cmd_Imprimir (o unico ".Cmd_Imprimir.Enabled =
1740:     * .F." esta no bloco comentado *!* - ver CarregarImpressoras), entao a
1741:     * condicao eh sempre verdadeira. Ele fica aqui porque eh o codigo do
1742:     * legado, nao porque se espere que rode.
1743:     *
1744:     * As propriedades qualificadas por THIS. de proposito dentro do WITH: WITH
1745:     * sobre outro objeto sequestra o escopo do ponto e resolveria
1746:     * ".this_lBloquearEncerrar" contra o CommandGroup, que nao tem essa
1747:     * propriedade - erro de runtime que derruba a abertura da tela.
1748:     *--------------------------------------------------------------------------
1749:     PROTECTED PROCEDURE AplicarEstadoBotoes()
1750:         LOCAL loc_oErro
1751: 
1752:         TRY
1753:             WITH THIS.obj_4c_BtnReport
1754:                 IF .Buttons(1).Enabled
1755:                     .Value = 1
1756:                     .Buttons(2).Enabled = !THIS.this_lBloquearEncerrar
1757:                 ELSE
1758:                     .Value = 2
1759:                     .Buttons(2).Enabled = .T.
1760:                     .Buttons(2).SetFocus()
1761:                 ENDIF
1762:             ENDWITH
1763:         CATCH TO loc_oErro
1764:             MsgErro(loc_oErro.Message + CHR(13) + ;
1765:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1766:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.AplicarEstadoBotoes")
1767:         ENDTRY
1768:     ENDPROC
1769: 
1770:     *--------------------------------------------------------------------------
1771:     * VerificarImpressaoAutomatica - Transcreve o ULTIMO IF do Init legado, que
1772:     * dispensa o usuario de clicar Imprimir:
1773:     *
1774:     *   If (ThisForm.btnReport.Cmd_Imprimir.Enabled And pnTpBol = 14 And lnCimp >= 1) Or ;
1775:     *      (Used([crSigCdOpd]) And Inlist(crSigCdOpd.Boletos,3))
1776:     *       Thisform.btnReport.Value = 1
1777:     *       ThisForm.btnReport.Cmd_Imprimir.Click()
1778:     *   Endif
1779:     *
1780:     * lnCimp eh RECCOUNT('crImpreV') = SigOpIboBO.this_nQtdImp.
1781:     *
1782:     * crSigCdOpd eh cursor do form CHAMADOR - ver ObterBoletosSigCdOpd.
1783:     *
1784:     * NAO dispara em harness/validacao de UI: a impressao chama uma rotina
1785:     * global do Fortyus que nao veio no acervo, e um dialogo de erro em
1786:     * execucao headless trava o pipeline.
1787:     *--------------------------------------------------------------------------
1788:     PROTECTED PROCEDURE VerificarImpressaoAutomatica()
1789:         LOCAL loc_lAuto, loc_oErro
1790: 
1791:         IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
1792:            (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
1793:             RETURN
1794:         ENDIF
1795: 
1796:         TRY
1797:             loc_lAuto = (THIS.obj_4c_BtnReport.Buttons(1).Enabled AND ;
1798:                          THIS.this_nTpBol = 14 AND ;
1799:                          THIS.this_oBusinessObject.this_nQtdImp >= 1) OR ;
1800:                         (THIS.ObterBoletosSigCdOpd() = 3)
1801: 
1802:             IF loc_lAuto
1803:                 THIS.obj_4c_BtnReport.Value = 1
1804:                 THIS.BtnImprimirClick()
1805:             ENDIF
1806:         CATCH TO loc_oErro
1807:             MsgErro(loc_oErro.Message + CHR(13) + ;
1808:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1809:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.VerificarImpressaoAutomatica")
1810:         ENDTRY
1811:     ENDPROC
1812: 
1813:     *--------------------------------------------------------------------------
1814:     * BtnImprimirClick - PROCEDURE Cmd_Imprimir.Click legado (codigo ATIVO).
1815:     * PUBLIC porque eh chamado via BINDEVENT (regra #3).
1816:     *
1817:     * O "With Thisform" do legado copia as nove propriedades para locais e
1818:     * passa tudo ao Do SigBlBol. Aqui essas nove ja estao no Business Object
1819:     * desde o Init (DefinirTipoBoleto), entao o que o Click transfere eh so o
1820:     * que a TELA decide depois de aberta - impressora e os tres checkboxes -,
1821:     * em FormParaBO.
1822:     *--------------------------------------------------------------------------
1823:     PROCEDURE BtnImprimirClick()
1824:         LOCAL loc_nSessaoAnterior, loc_cConteudo, loc_oErro
1825:         loc_nSessaoAnterior = 0
1826: 
1827:         TRY
1828:             *-- ".btnReport.Cmd_Sair.Enabled = .T." - imprimir LIBERA o Encerrar
1829:             *-- que o llSair do Init pode ter bloqueado
1830:             THIS.obj_4c_BtnReport.Buttons(2).Enabled = .T.
1831: 
1832:             *-- "lcImp = crImpreV.IDupla" + os tres checkboxes
1833:             THIS.FormParaBO()
1834: 
1835:             *-- "Do SigBlBol With ..." (SigOpIboBO.ExecutarImpressao). A rotina
1836:             *-- legada abre o CURSOR cujo NOME chegou em pCursor, e esse cursor
1837:             *-- vive na datasession do CHAMADOR - este form eh DataSession = 2
1838:             *-- (privada), por isso a troca temporaria. Era o que o
1839:             *-- "Set DataSession to poForm.DataSessionId" do Init legado fazia
1840:             *-- de uma vez para toda a tela; aqui so a chamada eh envolvida,
1841:             *-- para nao expor o resto do form a sessao alheia.
1842:             loc_nSessaoAnterior = THIS.EntrarDataSessionChamador()
1843:             THIS.this_oBusinessObject.ExecutarImpressao()
1844:             THIS.RestaurarDataSession(loc_nSessaoAnterior)
1845:             loc_nSessaoAnterior = 0
1846: 
1847:             *-- "If Used([crSigCdOpd]) And Inlist(crSigCdOpd.Boletos,1)"
1848:             IF THIS.ObterBoletosSigCdOpd() = 1
1849:                 THIS.Release()
1850:             ELSE
1851:                 IF FILE("BOLETO.txt")
1852:                     loc_cConteudo = FILETOSTR("BOLETO.txt")
1853:                     THIS.ExibirConteudoBoleto(loc_cConteudo)
1854:                     DELETE FILE "BOLETO.txt"
1855:                 ENDIF
1856:             ENDIF
1857:         CATCH TO loc_oErro
1858:             *-- Restaura a datasession tambem no caminho de falha: sair daqui
1859:             *-- na sessao do chamador deixaria o resto do form lendo cursores
1860:             *-- que nao sao dele
1861:             THIS.RestaurarDataSession(loc_nSessaoAnterior)
1862:             MsgErro(loc_oErro.Message + CHR(13) + ;
1863:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1864:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.BtnImprimirClick")
1865:         ENDTRY
1866:     ENDPROC
1867: 
1868:     *--------------------------------------------------------------------------
1869:     * BtnEncerrarClick - PROCEDURE Cmd_Sair.Click legado ("Thisform.Release").
1870:     * PUBLIC porque eh chamado via BINDEVENT (regra #3).
1871:     *--------------------------------------------------------------------------
1872:     PROCEDURE BtnEncerrarClick()
1873:         THIS.Release()
1874:     ENDPROC
1875: 
1876:     *--------------------------------------------------------------------------
1877:     * FormParaBO - Transcreve o "With Thisform" do Cmd_Imprimir.Click legado
1878:     * na parte que le a TELA (nome canonico do par Form<->BO que o resto do
1879:     * projeto usa para forms CRUD - PILAR 3; aqui o "espelho" existe so neste
1880:     * sentido, Tela -> BO, porque nao ha Page2 de dados nem modo de edicao a
1881:     * transferir de volta, e por isso THIS.this_oBusinessObject.this_nQBols
1882:     * tambem eh alimentado direto por ValidarQtde, nao por este metodo):
1883:     *
1884:     *   lnImpres  = RECNO('crImpreV')
1885:     *   lcImp     = crImpreV.IDupla
1886:     *   llObs     = IIF(lnTpbols=18, .chkCarne.Value, .chkObss.Value)
1887:     *   llAgrupa  = (.chkagrupa.Value)
1888:     *
1889:     * A impressora eh lida do CURSOR, nao do .Value do ComboBox - eh o que o
1890:     * legado faz, e eh equivalente: Get_Printer tem RowSourceType = 2 (Tabela),
1891:     * e nesse modo o VFP move o ponteiro de registro do cursor a cada escolha
1892:     * do usuario. Assim esta parte funciona com ou sem o ComboBox na tela.
1893:     *
1894:     * llObs (a escolha entre chkCarne e chkObss conforme o tipo 18) NAO eh
1895:     * decidida aqui: ela esta em SigOpIboBO.ExecutarImpressao, com a MESMA
1896:     * expressao do legado. Aqui os tres checkboxes sao apenas espelhados nas
1897:     * tres propriedades do BO.
1898:     *
1899:     * Os tres checkboxes sao lidos SEM guarda de existencia, e isso eh
1900:     * deliberado: os tres sao criados por ConfigurarOpcoes, que eh passo
1901:     * OBRIGATORIO do InicializarForm (5b) - este metodo so roda a partir do
1902:     * Click do Imprimir, isto eh, com a tela JA aberta e portanto com os tres
1903:     * controles existindo. Um IF PEMSTATUS aqui nao protegeria nada e custaria
1904:     * caro: se algum dos nomes divergisse, a leitura seria PULADA em silencio e
1905:     * a escolha do usuario nunca chegaria ao BO - a impressao sairia com o
1906:     * default do Init e ninguem veria erro, log ou aviso. Sem a guarda, o mesmo
1907:     * erro de nome estoura na hora, no CATCH deste metodo, com nome e linha.
1908:     *
1909:     * ConverterParaLogico porque CheckBox.Value assume o tipo do que foi
1910:     * atribuido - numerico (0/1) pelo canonico do projeto, logico no SCX - e
1911:     * comparar logico com 1 estoura "Operator/operand type mismatch".
1912:     *--------------------------------------------------------------------------
1913:     PROCEDURE FormParaBO()
1914:         LOCAL loc_oErro
1915: 
1916:         TRY
1917:             IF USED("cursor_4c_ImpreV")
1918:                 SELECT cursor_4c_ImpreV
1919:                 IF !EOF("cursor_4c_ImpreV") AND !BOF("cursor_4c_ImpreV")
1920:                     THIS.this_oBusinessObject.this_cImpressoraSelecionada = ;
1921:                         cursor_4c_ImpreV.IDupla
1922:                 ENDIF
1923:             ENDIF
1924: 
1925:             *-- "llObs = IIF(lnTpbols=18, .chkCarne.Value, .chkObss.Value)":
1926:             *-- os DOIS valores vao para o BO e a escolha entre eles fica em
1927:             *-- ExecutarImpressao, com a mesma expressao do legado
1928:             THIS.this_oBusinessObject.this_lImprimirCarne = ;
1929:                 ConverterParaLogico(THIS.chk_4c_ChkCarne.Value)
1930: 
1931:             THIS.this_oBusinessObject.this_lImprimirObservacoes = ;
1932:                 ConverterParaLogico(THIS.chk_4c_ChkObss.Value)
1933: 
1934:             *-- "llAgrupa = (.chkagrupa.Value)"
1935:             THIS.this_oBusinessObject.this_lAgruparInformacoes = ;
1936:                 ConverterParaLogico(THIS.chk_4c_ChkAgrupa.Value)
1937:         CATCH TO loc_oErro
1938:             MsgErro(loc_oErro.Message + CHR(13) + ;
1939:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1940:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.FormParaBO")
1941:         ENDTRY
1942:     ENDPROC
1943: 
1944:     *--------------------------------------------------------------------------
1945:     * ExibirConteudoBoleto - Transcreve o bloco do BOLETO.txt do
1946:     * Cmd_Imprimir.Click legado:
1947:     *
1948:     *   thisform.container1.Visible = .t.
1949:     *   thisform.container1.edit1.Value = lcConteudo
1950:     *   thisform.container1.edit1.Refresh
1951:     *
1952:     * cnt_4c_Container1 nasce OCULTO (Visible = .F. no SCX, e por isso esta na
1953:     * lista de excecao do TornarControlesVisiveis): eh AQUI que ele aparece.
1954:     *
1955:     * O EditBox eh alcancado SEM guarda de existencia, pelo mesmo motivo de
1956:     * FormParaBO: obj_4c_Edit1 eh criado por ConfigurarOpcoes,
1957:     * passo obrigatorio do InicializarForm, e este metodo so roda a partir do
1958:     * Click do Imprimir. Um IF PEMSTATUS aqui faria o painel abrir EM BRANCO em
1959:     * silencio - o usuario veria a moldura vazia e concluiria que a impressao
1960:     * nao produziu nada. Sem a guarda, nome divergente estoura no CATCH.
1961:     *
1962:     * A ORDEM eh a do legado - Visible antes do Value: o EditBox pinta o
1963:     * conteudo ja dentro do container visivel, e o Refresh fecha o bloco.
1964:     *--------------------------------------------------------------------------
1965:     PROTECTED PROCEDURE ExibirConteudoBoleto(par_cConteudo)
1966:         LOCAL loc_oErro
1967: 
1968:         TRY
1969:             THIS.cnt_4c_Container1.Visible = .T.
1970: 
1971:             THIS.cnt_4c_Container1.obj_4c_Edit1.Value = par_cConteudo
1972:             THIS.cnt_4c_Container1.obj_4c_Edit1.Refresh()
1973:         CATCH TO loc_oErro
1974:             MsgErro(loc_oErro.Message + CHR(13) + ;
1975:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1976:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ExibirConteudoBoleto")
1977:         ENDTRY
1978:     ENDPROC
1979: 
1980:     *--------------------------------------------------------------------------
1981:     * ObterBoletosSigCdOpd - Le crSigCdOpd.Boletos, que o Cmd_Imprimir.Click e
1982:     * o fim do Init legado consultam duas vezes:
1983:     *
1984:     *   If Used([crSigCdOpd]) And Inlist(crSigCdOpd.Boletos,1)   -> fecha a tela
1985:     *   ... Or (Used([crSigCdOpd]) And Inlist(crSigCdOpd.Boletos,3)) -> imprime sozinho
1986:     *
1987:     * crSigCdOpd NAO eh cursor deste dialogo: eh do form CHAMADOR (parametros da
1988:     * operacao de estoque). No legado ele estava visivel porque o Init fazia
1989:     * "Set DataSession to poForm.DataSessionId" e a tela inteira passava a
1990:     * rodar na sessao do chamador. Este form eh DataSession = 2 (fiel ao SCX),
1991:     * logo o cursor NAO esta ao alcance: sem a troca, USED() devolveria SEMPRE
1992:     * .F., as duas condicoes morreriam caladas e a tela deixaria de fechar
1993:     * sozinha (Boletos = 1) e de imprimir sozinha (Boletos = 3).
1994:     *
1995:     * Devolve 0 quando nao ha chamador, quando o cursor nao existe ou quando a
1996:     * coluna nao eh numerica - os tres casos em que o legado tambem nao casa
1997:     * nenhum dos dois IF. Nao ha TRY aqui de proposito: USED() e TYPE() nao
1998:     * estouram com alias fechado (TYPE devolve "U"), e a troca de sessao, que
1999:     * eh o unico ponto que pode falhar, ja trata o erro no proprio metodo.
2000:     *--------------------------------------------------------------------------
2001:     PROTECTED FUNCTION ObterBoletosSigCdOpd()
2002:         LOCAL loc_nBoletos, loc_nSessaoAnterior
2003:         loc_nBoletos = 0
2004: 
2005:         loc_nSessaoAnterior = THIS.EntrarDataSessionChamador()
2006: 
2007:         IF USED("crSigCdOpd") AND TYPE("crSigCdOpd.Boletos") = "N"
2008:             loc_nBoletos = NVL(crSigCdOpd.Boletos, 0)
2009:         ENDIF
2010: 
2011:         THIS.RestaurarDataSession(loc_nSessaoAnterior)
2012: 
2013:         RETURN loc_nBoletos
2014:     ENDFUNC
2015: 
2016:     *--------------------------------------------------------------------------

*-- Linhas 2041 a 2157:
2041:                 loc_nAnterior = 0
2042:                 MsgErro(loc_oErro.Message + CHR(13) + ;
2043:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2044:                     "Procedure: " + loc_oErro.Procedure, ;
2045:                     "FormSigOpIbo.EntrarDataSessionChamador")
2046:             ENDTRY
2047:         ENDIF
2048: 
2049:         RETURN loc_nAnterior
2050:     ENDFUNC
2051: 
2052:     *--------------------------------------------------------------------------
2053:     * RestaurarDataSession - Volta para a datasession devolvida por
2054:     * EntrarDataSessionChamador. Zero significa "nao houve troca".
2055:     *--------------------------------------------------------------------------
2056:     PROTECTED PROCEDURE RestaurarDataSession(par_nSessao)
2057:         LOCAL loc_nDestino, loc_oErro
2058: 
2059:         IF VARTYPE(par_nSessao) = "N" AND par_nSessao > 0
2060:             loc_nDestino = par_nSessao
2061:             TRY
2062:                 SET DATASESSION TO loc_nDestino
2063:             CATCH TO loc_oErro
2064:                 MsgErro(loc_oErro.Message + CHR(13) + ;
2065:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2066:                     "Procedure: " + loc_oErro.Procedure, ;
2067:                     "FormSigOpIbo.RestaurarDataSession")
2068:             ENDTRY
2069:         ENDIF
2070:     ENDPROC
2071: 
2072:     *--------------------------------------------------------------------------
2073:     * TornarControlesVisiveis - Torna a arvore de controles visivel
2074:     * recursivamente (AddObject cria tudo com Visible = .F.).
2075:     *
2076:     * CRITICO: os controles que o legado mantem OCULTOS ficam de FORA. Forcar
2077:     * .Visible = .T. em toda a arvore exporia o painel do BOLETO.txt
2078:     * (cnt_4c_Container1, Visible = .F. no SCX) ja na abertura da tela.
2079:     * Para esses, pula-se a ATRIBUICAO do Visible mas CONTINUA-SE a RECURSAO
2080:     * nos filhos: sem isso os filhos ficariam com Visible = .F. permanente e o
2081:     * painel apareceria VAZIO quando o Cmd_Imprimir.Click o ligasse.
2082:     *
2083:     * A lista de excecao esta COMPLETA desde a Fase 3 e cobre os tres controles
2084:     * que o legado mantem permanentemente ocultos: cnt_4c_Container1,
2085:     * obj_4c_Opt_Impressora e lbl_4c_Lbl_Erro. Os tres checkboxes de opcao NAO
2086:     * entram nela: a visibilidade deles nao eh fixa - depende do tipo de boleto -
2087:     * e por isso eh resolvida DEPOIS deste metodo, em AplicarVisibilidadeOpcoes.
2088:     *--------------------------------------------------------------------------
2089:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2090:         LOCAL loc_i, loc_oControl, loc_lOculto, loc_oErro
2091: 
2092:         TRY
2093:             FOR loc_i = 1 TO par_oContainer.ControlCount
2094:                 loc_oControl = par_oContainer.Controls(loc_i)
2095: 
2096:                 IF VARTYPE(loc_oControl) = "O"
2097:                     *-- Controles que o legado mantem ocultos: nao mexer no
2098:                     *-- Visible deles (mas recursar nos filhos, abaixo)
2099:                     *-- obj_4c_Opt_Impressora e lbl_4c_Lbl_Erro sao criados na
2100:                     *-- fase dos campos e tambem nascem Visible = .F. no SCX
2101:                     *-- (o OptionGroup porque a lista de impressoras migrou para
2102:                     *-- o ComboBox, e o Lbl_Erro porque o bloco que o exibia
2103:                     *-- esta comentado - ver CarregarImpressoras). Os nomes ja
2104:                     *-- ficam aqui para que criar os controles nao desfaca o
2105:                     *-- Visible = .F. deles: TornarControlesVisiveis percorre a
2106:                     *-- arvore INTEIRA e e' a causa classica de controle que o
2107:                     *-- legado esconde aparecer na tela migrada.
2108:                     loc_lOculto = INLIST(UPPER(loc_oControl.Name), ;
2109:                         "CNT_4C_CONTAINER1", ;
2110:                         "OBJ_4C_OPT_IMPRESSORA", ;
2111:                         "LBL_4C_LBL_ERRO")
2112: 
2113:                     IF !loc_lOculto AND PEMSTATUS(loc_oControl, "Visible", 5)
2114:                         loc_oControl.Visible = .T.
2115:                     ENDIF
2116: 
2117:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
2118:                        loc_oControl.ControlCount > 0
2119:                         THIS.TornarControlesVisiveis(loc_oControl)
2120:                     ENDIF
2121:                 ENDIF
2122:             ENDFOR
2123:         CATCH TO loc_oErro
2124:             MsgErro(loc_oErro.Message + CHR(13) + ;
2125:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2126:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.TornarControlesVisiveis")
2127:         ENDTRY
2128:     ENDPROC
2129: 
2130:     *--------------------------------------------------------------------------
2131:     * Destroy - Fecha os cursores temporarios que o Business Object abre em
2132:     * CarregarImpressorasConfiguradas (os mesmos crTmpCimp/crSigCdmp/crImpre/
2133:     * crImp/crImpreV do Init legado) antes de repassar para FormBase.Destroy()
2134:     * via DODEFAULT() - que eh quem reconstroi os popups do menu principal
2135:     * depois do fechamento de um form modal.
2136:     *--------------------------------------------------------------------------
2137:     PROCEDURE Destroy()
2138:         IF USED("cursor_4c_TmpCimp")
2139:             USE IN cursor_4c_TmpCimp
2140:         ENDIF
2141:         IF USED("cursor_4c_SigCdmp")
2142:             USE IN cursor_4c_SigCdmp
2143:         ENDIF
2144:         IF USED("cursor_4c_Impre")
2145:             USE IN cursor_4c_Impre
2146:         ENDIF
2147:         IF USED("cursor_4c_Imp")
2148:             USE IN cursor_4c_Imp
2149:         ENDIF
2150:         IF USED("cursor_4c_ImpreV")
2151:             USE IN cursor_4c_ImpreV
2152:         ENDIF
2153: 
2154:         DODEFAULT()
2155:     ENDPROC
2156: 
2157: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpIboBO.prg):
*==============================================================================
* SIGOPIBOBO.prg
*
* Business Object para SIGOPIBO (Impressao de Boleto / Protocolo / Duplicata-Carne)
*
* Este form NAO persiste dados em tabela propria - e um dialogo OPERACIONAL
* que recebe parametros do form chamador (tipo de boleto, empresa, operacao,
* numero da movimentacao, etc.), permite ao usuario escolher a impressora de
* boletos configurada na estacao e repassa tudo para a rotina legada de
* impressao (Do SigBlBol With ...).
*
* Tabela: (nenhuma - dialogo parametrizado, sem persistencia propria)
*
* Irmao direto de SigOpBolBO.prg (SIGOPBOL - "Selecao de Impressora de
* Boleto"), mesma familia de dialogo de impressao. Diferencas do legado
* (tasks\task746\SigOpIbo_form_codigo_fonte.txt) que as proximas fases
* precisam reproduzir:
*   - Tres checkboxes de OPCAO do proprio dialogo (chkCarne/chkObss/
*     chkAgrupa), que NAO sao parametro do chamador - sao o estado inicial
*     da tela (.T./.T./.F. no SCX) e a visibilidade de cada um depende do
*     tipo de boleto (vnTpBol). O legado SOBRESCREVE chkObss.Visible e
*     chkCarne.Visible duas vezes seguidas (TpBol=17 e depois TpBol=18)
*     sem IF entre as duas - so a ULTIMA atribuicao tem efeito observavel;
*     isso vale reproduzir tal como se comporta, nao como foi escrito.
*   - O Do Case do titulo tem DUAS opcoes que o irmao SigOpBolBO nao tem
*     (TpBol=16 "Impressao de Boleto de Vendas" e TpBol=18 "Impressao de
*     Duplicata/Carne").
*   - A escolha de impressora eh por COMBOBOX (Get_Printer, RowSource =
*     crImpreV, montado por UNION ALL de SigSyImp/SigCdAcG/SigCdmp cruzado
*     com APRINTERS) - o Opt_Impressora do SCX esta Visible = .F. e o bloco
*     que o preenchia esta todo comentado (*!*) no legado; nao reativar.
*   - Cmd_Imprimir.Click repassa DOIS parametros extras ao SigBlBol que o
*     SigOpBolBO nao tem: llObs (chkObss ou chkCarne, conforme TpBol=18) e
*     llAgrupa (chkAgrupa.Value).
*   - Ha um fallback de exibicao (Container1/Edit1) que mostra o conteudo de
*     BOLETO.txt quando o arquivo existe apos a chamada ao SigBlBol - efeito
*     colateral de UI, nao dado de negocio; fica para a fase do Form.
*
* poForm (referencia ao form chamador) e a checagem llSair (fChecaAcesso
*('SIGCHE','PROTSEMPRE') AND poForm.Op_Escolha = 'INSERIR', usada so no caso
* TpBol=1 para decidir se o botao Encerrar nasce habilitado) NAO entram neste
* BO - mesma decisao arquitetural de SigOpCtdBO.prg ("ONDE FICA O poForm"):
* guardar referencia ao form pai aqui fecharia um ciclo de referencias e essa
* checagem eh de UI (Enabled do botao), nao de dado. Fica no Form (fase 3+).
*
* Fase 1/8: APENAS propriedades e Init() basico, no mesmo padrao de
* SigOpBolBO.prg - Init() sem parametros, zera tudo, this_cTabela e
* this_cCampoChave vazios (nao ha tabela/chave propria). As proximas fases
* adicionam os metodos que reproduzem a logica REAL do Init/Cmd_Imprimir.Click
* do legado:
*   - DefinirTipoBoleto()               : guarda de tipo, igual ao irmao
*   - ObterTituloPorTipoBoleto()        : Do Case do titulo (com 16 e 18)
*   - DeveExibirImprimirCarne()/DeveExibirImprimirObservacoes()/
*     DeveExibirAgruparInformacoes()    : visibilidade dos 3 checkboxes
*   - CarregarImpressorasConfiguradas() : UNION ALL SigSyImp/SigCdAcG/SigCdmp
*     + cruzamento com APRINTERS (crImpre/crImp/crImpreV do legado)
*   - ExecutarImpressao()               : Do SigBlBol With ... (com llObs e
*     llAgrupa) - rotina legada
*
* SigBlBol e uma PROCEDURE global do Fortyus (sig.prg/SIGFUNCS.PRG) que NAO
* veio no acervo (sem .prg fonte, sem FRX - ver regra CLAUDE.md #27 "Funcao
* GLOBAL do legado"). Nao ha como reproduzir a impressao real (layout de
* boleto bancario) sem esse fonte. ExecutarImpressao() (fase futura) deve
* TRANSCREVER o "Do SigBlBol With ..." exatamente como o legado chama, dentro
* de TRY/CATCH que exibe a falha com MsgErro (regra #9, CATCH nunca
* silencioso) - a ausencia fica VISIVEL em vez de virar um stub que finge
* imprimir.
*==============================================================================

DEFINE CLASS SigOpIboBO AS BusinessBase

    *-- Propriedades da entidade (parametros recebidos do form chamador,
    *-- espelhando as properties customizadas do form legado SIGOPIBO)
    this_nTpBol = 0               && vnTpBol - Tipo de Boleto
    this_cTitEnvelope = ""        && vcTitEnvelope - Titulo do Envelope
    this_cEmp = ""                && vcEmp - Codigo da Empresa
    this_cDope = ""                && vcDope - Nome da Operacao de Estoque/Producao
    this_nNum = 0                 && vnNum - Numero da Movimentacao de Estoque/Producao
    this_nDev = 0                 && vnDev - Valor de Devolucao
    this_nVias = 0                && vnVias - Numero da Via
    this_nQBols = 0               && vnQBols - Quantidade de Boletos
    this_cCursor = ""             && vnCursor - Nome do Cursor/Tabela a Imprimir (apesar do "vn", eh CHAR)
    this_nQtdImp = 0              && Quantidade de Impressoras de Boleto Configuradas (lnCimp/RECCOUNT('crImpreV'))
    this_cImpressoraSelecionada = "" && Impressora escolhida no combo (Get_Printer / crImpreV.IDupla)

    *-- Opcoes do PROPRIO dialogo (chkCarne/chkObss/chkAgrupa) - NAO sao
    *-- parametro do chamador, sao o estado inicial da tela no SCX
    this_lImprimirCarne = .F.         && chkCarne.Value (SCX: .T.)
    this_lImprimirObservacoes = .F.   && chkObss.Value (SCX: .T.)
    this_lAgruparInformacoes = .F.    && chkAgrupa.Value (SCX: .F.)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo parametrizado: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.this_nTpBol = 0
        THIS.this_cTitEnvelope = ""
        THIS.this_cEmp = ""
        THIS.this_cDope = ""
        THIS.this_nNum = 0
        THIS.this_nDev = 0
        THIS.this_nVias = 0
        THIS.this_nQBols = 0
        THIS.this_cCursor = ""
        THIS.this_nQtdImp = 0
        THIS.this_cImpressoraSelecionada = ""

        THIS.this_lImprimirCarne = .F.
        THIS.this_lImprimirObservacoes = .F.
        THIS.this_lAgruparInformacoes = .F.

        RETURN .T.
    ENDPROC

    *====================================================================
    * DefinirTipoBoleto - Recebe os parametros do form chamador e aplica
    * as mesmas guardas de tipo do Init() legado (Iif(Type(...)='C'/'N',
    * valor, default)). Equivalente ao bloco WITH Thisform do Init do
    * SIGOPIBO.SCX, sem o SQLEXEC/UI que ficam em outros metodos.
    *====================================================================
    PROCEDURE DefinirTipoBoleto(par_nTpBol, par_cTitEnvelope, par_cEmp, ;
            par_cDope, par_nNum, par_nDev, par_nVias, par_nQBols, par_cCursor)

        THIS.this_cTitEnvelope = IIF(VARTYPE(par_cTitEnvelope) = "C", par_cTitEnvelope, "")
        THIS.this_nTpBol = IIF(VARTYPE(par_nTpBol) = "N", par_nTpBol, 0)
        THIS.this_cEmp = IIF(VARTYPE(par_cEmp) = "C", par_cEmp, "")
        THIS.this_cDope = IIF(VARTYPE(par_cDope) = "C", par_cDope, "")
        THIS.this_nNum = IIF(VARTYPE(par_nNum) = "N", par_nNum, 0)
        THIS.this_nDev = IIF(VARTYPE(par_nDev) = "N", par_nDev, 0)
        THIS.this_nVias = IIF(VARTYPE(par_nVias) = "N" AND par_nVias > 0, par_nVias, 0)
        THIS.this_nQBols = IIF(VARTYPE(par_nQBols) = "N" AND par_nQBols > 0, par_nQBols, 1)
        THIS.this_cCursor = IIF(VARTYPE(par_cCursor) = "C", par_cCursor, "")

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterTituloPorTipoBoleto - Do Case do titulo/Caption do Init legado.
    * Caso 1 (Protocolo de Cheque) usa o titulo recebido do chamador quando
    * fornecido (pcTitEnvelope), senao cai no titulo fixo - os demais casos
    * SEMPRE usam titulo fixo, mesmo que pcTitEnvelope tenha sido informado
    * (fiel ao Do Case do legado, que so olha pcTitEnvelope no Case 1).
    *====================================================================
    PROCEDURE ObterTituloPorTipoBoleto()
        LOCAL loc_cTitulo

        DO CASE
            CASE THIS.this_nTpBol = 1
                loc_cTitulo = IIF(!EMPTY(THIS.this_cTitEnvelope), THIS.this_cTitEnvelope, ;
                    "Impress" + CHR(227) + "o de Protocolo de Cheque")

            CASE INLIST(THIS.this_nTpBol, 2, 3, 4, 5, 7, 9)
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto"

            CASE THIS.this_nTpBol = 6
                loc_cTitulo = "Impress" + CHR(227) + "o de Protocolo de Cart" + CHR(227) + "o de Cr" + CHR(233) + "dito"

            CASE THIS.this_nTpBol = 8
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Conserto"

            CASE THIS.this_nTpBol = 12
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Ordem de Servi" + CHR(231) + "o"

            CASE THIS.this_nTpBol = 16
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Vendas"

            CASE THIS.this_nTpBol = 18
                loc_cTitulo = "Impress" + CHR(227) + "o de Duplicata/Carne"

            OTHERWISE
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto (*)"
        ENDCASE

        RETURN loc_cTitulo
    ENDPROC

    *====================================================================
    * DeveExibirImprimirObservacoes / DeveExibirImprimirCarne /
    * DeveExibirAgruparInformacoes - visibilidade dos tres checkboxes do
    * Init legado. chkObss.Visible e chkCarne.Visible sao atribuidos DUAS
    * vezes seguidas, sem IF entre as duas atribuicoes (ver comentario no
    * cabecalho deste arquivo) - so a ULTIMA atribuicao tem efeito:
    *   chkObss.Visible  = (TpBol=17) depois sobrescrito por !(TpBol=18)
    *   chkCarne.Visible = !(TpBol=17) depois sobrescrito por (TpBol=18)
    * Os metodos abaixo reproduzem o resultado final observavel, nao a
    * sequencia intermediaria (que nunca chega a ser visivel na tela).
    *====================================================================
    PROCEDURE DeveExibirImprimirObservacoes()
        RETURN (THIS.this_nTpBol != 18)
    ENDPROC

    PROCEDURE DeveExibirImprimirCarne()
        RETURN (THIS.this_nTpBol = 18)
    ENDPROC

    PROCEDURE DeveExibirAgruparInformacoes()
        RETURN (THIS.this_nTpBol = 3)
    ENDPROC

    *====================================================================
    * CarregarImpressorasConfiguradas - Reproduz o bloco do Init legado que
    * monta crImpreV (ComboBox Get_Printer):
    *   1. SigSyImp+SigCdmp (acesso direto) UNION ALL SigCdAcG+SigSyImp+
    *      SigCdmp (acesso por grupo), filtrado pelo usuario logado
    *      (Usuar no legado -> gc_4c_UsuarioLogado aqui, regra #PUBLICvars).
    *   2. SELECT DISTINCT das impressoras de boleto configuradas.
    *   3. APRINTERS() para as impressoras do Windows na estacao.
    *   4. Cruzamento fuzzy (LIKE dos dois lados) entre as impressoras de
    *      boleto configuradas e as impressoras do Windows, e ORDER BY 1.
    * Preenche this_nQtdImp (lnCimp/RECCOUNT('crImpreV') do legado) e
    * this_cImpressoraSelecionada com o 1o registro (GO TOP), equivalente
    * ao "thisform.get_Printer.value = RECNO('crImpreV')" + BoundColumn=1
    * do legado (a 1a coluna do RowSource, IDupla, eh o Value do combo).
    *
    * Se nenhuma impressora de boleto estiver configurada para o usuario,
    * crSigCdmp nunca eh criado no legado e a consulta seguinte (crSigCdmp
    * JOIN crImpre) estouraria "Alias nao encontrado" - aqui, em vez de
    * reproduzir essa falha latente, cria-se cursor_4c_SigCdmp vazio com a
    * mesma estrutura para o cruzamento seguir e resultar em zero linhas
    * (mesmo efeito pratico do legado: nenhuma impressora disponivel).
    *====================================================================
    PROCEDURE CarregarImpressorasConfiguradas()
        LOCAL loc_cSQL, loc_nResultado, loc_nPrinters, loc_nI, loc_aPrinters

        IF USED("cursor_4c_TmpCimp")
            USE IN cursor_4c_TmpCimp
        ENDIF
        IF USED("cursor_4c_SigCdmp")
            USE IN cursor_4c_SigCdmp
        ENDIF
        IF USED("cursor_4c_Impre")
            USE IN cursor_4c_Impre
        ENDIF
        IF USED("cursor_4c_Imp")
            USE IN cursor_4c_Imp
        ENDIF
        IF USED("cursor_4c_ImpreV")
            USE IN cursor_4c_ImpreV
        ENDIF

        loc_cSQL = "SELECT b.* FROM SigSyImp a, SigCdmp b " + ;
                   "WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + " AND a.Cimps = b.Impres " + ;
                   "UNION ALL " + ;
                   "SELECT c.* FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                   "WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCimp")
        IF loc_nResultado < 0
            MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados.", "Erro")
            RETURN .F.
        ENDIF

        IF RECCOUNT("cursor_4c_TmpCimp") > 0
            SELECT DISTINCT Impres, nTpImpres, TpBarra, MaxCols ;
                FROM cursor_4c_TmpCimp ;
                ORDER BY Impres ;
                INTO CURSOR cursor_4c_SigCdmp
        ELSE
            CREATE CURSOR cursor_4c_SigCdmp (Impres C(50), nTpImpres N(1,0), TpBarra N(1,0), MaxCols N(3,0))
        ENDIF

        loc_nPrinters = APRINTERS(loc_aPrinters)
        CREATE CURSOR cursor_4c_Impre (impres C(50))
        IF loc_nPrinters != 0
            FOR loc_nI = 1 TO loc_nPrinters
                INSERT INTO cursor_4c_Impre (impres) VALUES (UPPER(loc_aPrinters[loc_nI, 1]))
            ENDFOR
        ENDIF

        SELECT PADR(ALLTRIM(a.Impres), 15) + " " + ALLTRIM(b.impres) AS IDupla, b.impres, a.impres AS impresS ;
            FROM cursor_4c_SigCdmp a, cursor_4c_Impre b ;
            WHERE (ALLTRIM(UPPER(b.impres)) LIKE "%" + ALLTRIM(UPPER(a.impres)) + "%" OR ;
                   ALLTRIM(UPPER(a.impres)) LIKE "%" + ALLTRIM(UPPER(b.impres)) + "%") ;
            GROUP BY b.impres, a.impres ;
            INTO CURSOR cursor_4c_Imp READWRITE

        SELECT * FROM cursor_4c_Imp ORDER BY 1 INTO CURSOR cursor_4c_ImpreV

        THIS.this_nQtdImp = RECCOUNT("cursor_4c_ImpreV")

        IF THIS.this_nQtdImp > 0
            SELECT cursor_4c_ImpreV
            GO TOP
            THIS.this_cImpressoraSelecionada = cursor_4c_ImpreV.IDupla
        ELSE
            THIS.this_cImpressoraSelecionada = ""
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * ExecutarImpressao - Transcreve o Do SigBlBol With ... do
    * Cmd_Imprimir.Click legado. SigBlBol e uma PROCEDURE global do
    * Fortyus (sig.prg/SIGFUNCS.PRG) que NAO veio no acervo (regra
    * CLAUDE.md #27) - nao ha fonte para reproduzir o layout real do
    * boleto bancario. A chamada fica dentro de TRY/CATCH que exibe a
    * falha com MsgErro (regra #9, CATCH nunca silencioso): a ausencia
    * fica VISIVEL ao usuario em vez de um stub que finge imprimir.
    *
    * llObs (11o parametro) segue a mesma expressao do legado:
    * IIF(vnTpBol=18, chkCarne.Value, chkObss.Value) - o 18o caso usa o
    * checkbox de carne no lugar do de observacoes.
    *====================================================================
    PROCEDURE ExecutarImpressao()
        LOCAL loc_lSucesso, loc_oErro, loc_lObs, loc_lAgrupa

        loc_lSucesso = .F.
        loc_lObs = IIF(THIS.this_nTpBol = 18, THIS.this_lImprimirCarne, THIS.this_lImprimirObservacoes)
        loc_lAgrupa = THIS.this_lAgruparInformacoes

        TRY
            DO SigBlBol WITH THIS.this_nTpBol, THIS.this_cTitEnvelope, THIS.this_cEmp, ;
                THIS.this_cDope, THIS.this_nNum, THIS.this_nDev, THIS.this_nVias, ;
                THIS.this_nQBols, THIS.this_cImpressoraSelecionada, THIS.this_cCursor, ;
                loc_lObs, loc_lAgrupa
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel executar a impress" + CHR(227) + "o do boleto:" + CHR(13) + ;
                loc_oErro.Message, "Erro ao Imprimir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Este BO nao sobrescreve CarregarDoCursor()/Inserir()/Atualizar()/
    * ExecutarExclusao()/ObterChavePrimaria(): o dialogo nao tem tabela nem
    * chave primaria propria (ver cabecalho deste arquivo) - o comportamento
    * padrao herdado de BusinessBase ja eh o correto para este caso.
    *--------------------------------------------------------------------------

ENDDEFINE

