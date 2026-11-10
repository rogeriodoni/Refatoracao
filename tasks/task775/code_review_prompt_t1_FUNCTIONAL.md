# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.ObterOcorrenciaCorrente()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExisteTagCursor()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpOco.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2359 linhas total):

*-- Linhas 13 a 361:
13: *------------------------------------------------------------------------------
14: * CONTRATO EXTERNO - o alias "Historico" eh do form CHAMADOR
15: *
16: * O "PROCEDURE Init" do SCX legado recebe seis parametros e, sem abrir cursor
17: * nenhum, apenas se POSICIONA num alias que ja esta aberto:
18: *
19: *     LParameters lcCodBarra, oOldForm, llRepete, lcObs, lnTop, lnLeft
20: *     ...
21: *     Select Historico
22: *     Set Order To CBars
23: *     Set Key To lcCodBarra
24: *     Go Top
25: *
26: * Esse alias eh montado pelo form PAI (SIGCDBAL, migrado como FormBAL) com
27: * AddCursor sobre SigIvTrH. No sistema novo ele se chama "cursor_4c_Historico"
28: * e nasce em FormBAL.CarregarGradeLeitura() (forms\cadastros\FormBAL.prg:3396).
29: * Dai tres consequencias que valem para o form INTEIRO:
30: *
31: *   (a) DataSession = 1 (sessao CORRENTE), igual ao SCX. Trocar para 2 daria
32: *       sessao privada e o cursor do chamador ficaria INVISIVEL aqui.
33: *   (b) Destroy() NAO fecha cursor_4c_Historico - quem abriu eh o chamador, e
34: *       fechar o alias de outro form deixaria a grade dele morta.
35: *   (c) o nome do alias chega por propriedade (this_cCursorHistorico), nunca
36: *       literal espalhado pelo codigo - mesmo contrato que SigOpOcoBO (Fases
37: *       1-2) ja documenta no proprio cabecalho.
38: *
39: * E o form tem de TOLERAR o alias ausente: o harness de teste
40: * (automation\vfp_helpers\TestFormWrapper.prg) faz CREATEOBJECT(classe) SEM
41: * chamador nenhum, logo sem cursor. Nenhuma guarda deste arquivo devolve .F.
42: * por falta do cursor - InicializarForm que devolve .F. MATA a tela.
43: *
44: *------------------------------------------------------------------------------
45: * PARAMETROS DO Init - capturados SEM validacao que reprove
46: *
47: * O harness chama CREATEOBJECT("FormSigOpOco") sem argumento algum. Em VFP9
48: * parametro nao passado chega como .F. LOGICO, entao cada um eh lido com
49: * guarda de VARTYPE (e PCOUNT no logico, cujo tipo do ausente coincide com o
50: * tipo esperado). NAO existe aqui o bloco "MsgErro + .F." de parametro
51: * obrigatorio: ele reprovaria SEMPRE a etapa 06_testForm, com a propria
52: * mensagem de validacao aparecendo como se fosse bug de logica.
53: *
54: *------------------------------------------------------------------------------
55: * POSICIONAMENTO DA JANELA - transcrito LITERALMENTE, inclusive a anomalia
56: *
57: * O legado faz
58: *
59: *     ThisForm.Top  = lnTop + 22
60: *     ThisForm.Left = lnTop + 390        && <-- lnTop, NAO lnLeft
61: *
62: * A segunda linha usa lnTop nas DUAS coordenadas. Parece erro de digitacao do
63: * legado, mas eh o posicionamento que o usuario ve hoje, e "formula do legado
64: * se TRANSCREVE, nunca se reescreve": corrigir para lnLeft mudaria o lugar em
65: * que a janela aparece (PILAR 1). Fica transcrito como esta, com o desvio
66: * registrado aqui para quem for revisar.
67: *
68: * Por isso AutoCenter = .F. na classe (FormBase declara .T.): AutoCenter age
69: * no Show e SOBRESCREVERIA o Top/Left calculado. Sem chamador - harness, ou
70: * abertura sem as coordenadas - o form cai no AutoCenter, para nao nascer
71: * encavalado no canto 0,0.
72: *
73: *------------------------------------------------------------------------------
74: * LAYOUT FLAT - por que NAO ha PageFrame aqui
75: *
76: * A arvore de objetos do dump tem o objeto raiz como "Class: form / BaseClass:
77: * form" (form GENERICO, nao frmcadastro nem frmrelatorio) e NENHUMA linha
78: * "BaseClass: pageframe". Os 19 objetos penduram direto na Form ou no
79: * container do cabecalho. Criar PageFrame com Page1 (Lista) e Page2 (Dados)
80: * aqui seria inventar estrutura que o legado nao tem - viola o PILAR 1 e a
81: * regra "NUNCA inventar". Sem PageFrame tambem NAO existe a compensacao de
82: * +29 no Top: todas as coordenadas vao CRUAS do SCX.
83: *
84: *------------------------------------------------------------------------------
85: * FASE 3/8 - ESTRUTURA BASE (o que este arquivo entrega)
86: *   - DEFINE CLASS FormSigOpOco AS FormBase + propriedades visuais transcritas
87: *     do SCX (665x323, BorderStyle 2, TitleBar = 0, ControlBox/Closable/
88: *     MaxButton/MinButton = .F., ClipControls = .F., WindowType = 1,
89: *     DataSession = 1, AutoCenter = .F.)
90: *   - Init() - captura os seis parametros do chamador e aplica o Top/Left
91: *   - InicializarForm() - fundo do form (Picture new_background.jpg), criacao
92: *     do Business Object, repasse dos parametros ao BO, montagem da faixa do
93: *     cabecalho e posicionamento do cursor do chamador
94: *   - ConfigurarCabecalho() - cnt_4c_Sombra + lbl_4c_LblSombra/lbl_4c_LblTitulo
95: *     (mapeamento.json: cntSombra -> cnt_4c_Sombra, lblSombra ->
96: *     lbl_4c_LblSombra, lblTitulo -> lbl_4c_LblTitulo)
97: *   - PosicionarHistorico() - o "Select Historico / Set Order To CBars /
98: *     Set Key To lcCodBarra / Go Top" do Init legado
99: *   - TornarControlesVisiveis() recursivo (AddObject cria tudo Visible = .F.)
100: *   - Destroy() - libera o BO e devolve o controle ao FormBase via DODEFAULT()
101: *
102: *   A faixa do cabecalho eh o PRIMEIRO AddObject do form (regra #11): o botao
103: *   de saida do legado fica em Top = 3, DENTRO da area da faixa (Top 0..80), e
104: *   precisa ser criado DEPOIS dela para desenhar por cima.
105: *
106: *------------------------------------------------------------------------------
107: * FASE 4/8 - GRID E BOTAO DE SAIDA (o que esta fase acrescenta)
108: *
109: *   Este form eh FLAT (ver "LAYOUT FLAT" acima) - nao ha Page1/Page2 nem
110: *   PageFrame, entao o roteiro generico "ConfigurarPaginaLista + 6 botoes CRUD"
111: *   NAO se aplica aqui: o legado SIGOPOCO eh um dialogo modal de lancamento de
112: *   UMA ocorrencia (nao uma lista de registros com Incluir/Alterar/Excluir), e
113: *   inventar PageFrame Lista/Dados violaria o PILAR 1 e a regra "NUNCA
114: *   inventar". MEDIDO no dump deste legado, que eh o que dispensa o ramo
115: *   paginado: ZERO linha "BaseClass: pageframe" na arvore de objetos, raiz
116: *   "Class: form / BaseClass: form" (form GENERICO), e a UNICA superficie de
117: *   lista eh a propria "BaseClass: grid" (SIGOPOCO.Grade) - ha grade, mas nao
118: *   ha Page nem botao CRUD algum (os 19 objetos do dump sao form +
119: *   dataenvironment + container do cabecalho + 2 label de titulo + grid com 4
120: *   coluna/header/textbox + 1 commandbutton de saida + 2 say + 1 editbox).
121: *   O entregavel real desta fase, ja delimitado no comentario da Fase 3, eh:
122: *
123: *   - ConfigurarGrade() - grd_4c_Dados (mapeamento.json: SIGOPOCO.Grade ->
124: *     grd_4c_Dados), 4 colunas transcritas do dump (Column1 "Barras" e
125: *     Column2 "Local" ReadOnly; Column3 "Ocorrencia" e Column4 "Peso Real"
126: *     editaveis - sao os dois campos que esta tela existe para preencher).
127: *     SO propriedade que NAO depende de dado (regra #41): geometria,
128: *     ColumnCount, ReadOnly/Movable/Resizable, fontes, cores, InputMask.
129: *   - VincularGrade() - o bind: RecordSource + os 4 ControlSource (SO quando
130: *     USED(this_cCursorHistorico) - o alias eh do form CHAMADOR, ver "CONTRATO
131: *     EXTERNO", e no harness sem chamador ele nao existe; ControlSource de
132: *     alias ausente estoura "Alias is not found" DENTRO do TRY de
133: *     InicializarForm e mata a tela inteira, regra #41), e DEPOIS dele as
134: *     larguras e os Header1.Caption, nesta ordem obrigatoria ColumnCount ->
135: *     RecordSource -> ControlSource -> Width -> Header1.Caption (regra #41/
136: *     Problema 48 - o bind RESETA largura e cabecalho, entao os dois tem de
137: *     ser reaplicados depois, nunca antes).
138: *   - CarregarDados() - FUNIL UNICO de carga (regra #21), PUBLIC: vincula,
139: *     posiciona o alias do chamador e REPINTA com "ThisForm.Refresh +
140: *     ThisForm.Grade.Refresh". Esse par de Refresh eh a transcricao das duas
141: *     ultimas linhas do Init legado e vinha FALTANDO - defeito real, nao
142: *     detalhe: o "Set Key To" filtra a visao do alias e trocar ordem/chave NAO
143: *     repinta a grade ligada a ele, entao sem o Refresh a grade seguia
144: *     desenhando o conteudo de antes do filtro, sem erro e sem log.
145: *     InicializarForm passou a chamar este funil no lugar da chamada nua a
146: *     PosicionarHistorico.
147: *   - ConfigurarBotaoSaida() - cmd_4c_Saida (mapeamento.json chamava o
148: *     controle "Sa?da": o Name do legado tem acento, mas identificador VFP
149: *     referenciado por THIS.<nome> tem de ser ASCII - o Caption, nao o nome
150: *     do objeto, eh quem leva o CHR(237); regra #4). So geometria/visual
151: *     aqui: Click fica para a Fase 7-8, junto com o resto dos handlers deste
152: *     form (nenhum metodo vazio - regra de completude).
153: *
154: *------------------------------------------------------------------------------
155: * FASE 5/8 - LABELS ESTATICOS DA OBSERVACAO (o que esta fase acrescenta)
156: *
157: *   Sem Page2/PageFrame neste form (ver "LAYOUT FLAT" acima), o roteiro
158: *   generico "ConfigurarPaginaDados() com metade dos campos" nao se aplica -
159: *   os dois controles restantes do dump que NAO dependem de dado nenhum sao
160: *   os dois labels (mapeamento.json: SIGOPOCO.Say7 -> lbl_4c_Label7,
161: *   SIGOPOCO.Say1 -> lbl_4c_Label1), entao ficam aqui; o EditBox de observacao
162: *   (Get_Obs), que tem ControlSource condicionado ao alias do chamador no
163: *   mesmo padrao de VincularGrade (regra #41), fica para a Fase 6.
164: *
165: *   - ConfigurarCamposObservacao() - lbl_4c_Label7 ("Obs : ", Top=195
166: *     Left=196 Width=31 Height=15) e lbl_4c_Label1 ("Tecle [TAB]  p/ sair da
167: *     Observacao", Top=283 Left=224 Width=169 Height=15). AutoSize = .F.
168: *     explicito com os Width/Height do dump (regra #23: AutoSize = .T. eh
169: *     no-op em Label criado por AddObject). ForeColor = RGB(90, 90, 90)
170: *     porque o dump NAO declara ForeColor para a classe "say" (regra #12) -
171: *     o Picture do form (new_background.jpg) nao eh escuro o bastante para
172: *     justificar branco, e sem essa cor o label fica ilegivel sobre o fundo.
173: *     Nenhum dos dois se sobrepoe a faixa (Top 0..80), a grade (Top 104..191)
174: *     nem o botao de saida (Top 3..78), entao a ordem de criacao em relacao a
175: *     eles eh indiferente.
176: *
177: *------------------------------------------------------------------------------
178: * FASE 6/8 - EDITBOX DE OBSERVACAO (o que esta fase acrescenta)
179: *
180: *   Ultimo controle do dump que faltava: o EditBox de observacao
181: *   (mapeamento.json: SIGOPOCO.Get_Obs -> obj_4c_Get_Obs), classe "fwmemo" do
182: *   Framework legado (BaseClass editbox). Mesmo padrao de VincularGrade da
183: *   Fase 4 (regra #41): o ControlSource ("Historico.Obs" no dump) depende do
184: *   alias do form CHAMADOR, que pode nao existir no instante em que esta
185: *   tela se constroi (harness sem chamador) - Column.ControlSource/
186: *   EditBox.ControlSource de alias ausente estoura "Alias is not found"
187: *   DENTRO do TRY de InicializarForm e mata a tela inteira. Por isso o
188: *   controle fica dividido em dois metodos, no mesmo padrao da grade:
189: *
190: *   - ConfigurarCampoObservacao() - AddObject + geometria/fonte do dump
191: *     (FontName="Arial", FontSize=8, Top=195 Left=222 Width=195 Height=87).
192: *     SO propriedade que NAO depende de dado (regra #41). Top=195 nao disputa
193: *     z-order com a faixa (0..80), a grade (104..191) nem o botao de saida
194: *     (3..78).
195: *   - VincularObservacao() - o bind condicionado a USED(alias), chamado pelo
196: *     mesmo funil de carga que religa a grade (CarregarDados - regra #21),
197: *     para repetir sempre que o alias aparecer. Fiel ao legado mesmo a
198: *     coluna "obs" ainda nao chegando no SELECT do FormBAL hoje - ver
199: *     "LACUNA REAL DO CONTRATO" acima. Nao se inventa coluna aqui.
200: *
201: *   E o LOOKUP, que eh a outra metade desta fase. O unico do form esta no
202: *   Valid de SIGOPOCO.Grade.Column3.Text1 (coluna Ocorrencia) e consulta
203: *   SigBaOco - identificado no dump pelo "CreateObject(fwBuscaInt, CsOcorr,
204: *   ...)". Ele NAO pode ser ligado por BINDEVENT nem validado em
205: *   AfterRowColChange: BINDEVENT em Valid de TextBox dentro de Column nao
206: *   dispara de forma confiavel E descartaria o valor de retorno (o legado
207: *   devolve .F. para prender o foco na celula quando a consulta falha), e o
208: *   nColIndex de AfterRowColChange eh a coluna de DESTINO, entao sair da
209: *   Column3 entregaria 4 e o lookup nunca rodaria (regras #3 e #46). Por isso
210: *   ele vira CONTROLE DE CELULA, no padrao canonico do FormLpr:
211: *
212: *   - TextBoxOcorrenciaOco_4c (DEFINE CLASS no fim deste arquivo) - Valid e
213: *     LostFocus embutidos, delegando a metodos PUBLIC do form.
214: *   - InstalarCelulaOcorrencia() - AddObject + CurrentControl + Sparse = .F.
215: *     + Visible (regra #18: AddObject sozinho NAO faz o controle aparecer).
216: *     Chamado no FIM de VincularGrade e idempotente, porque o ColumnCount de
217: *     la recria os objetos Column e destroi o que foi posto neles.
218: *   - ValidarOcorrenciaGrade() / ...Exec() - wrapper com guarda de
219: *     reentrancia (o picker eh modal e redispara o Valid) + corpo. O valor
220: *     digitado eh lido do CONTROLE, nunca do cursor (regra #46). A consulta,
221: *     os indices e o Seek ficam no BO (PopularOcorrencias/ValidarOcorrencia).
222: *   - AbrirBuscaOcorrencia() - o browse. O "fwBuscaInt" do legado busca em
223: *     cursor LOCAL ja populado, entao o equivalente eh a API
224: *     DefinirCursor/Mostrar do FormBuscaAuxiliar - e NAO o Init com
225: *     parametros, que faria um SQLEXEC proprio contra a TABELA e duplicaria a
226: *     consulta que o BO ja fez (regra #36/#37). Nao achar o codigo NAO eh
227: *     erro: abre o browse sem MsgAviso e sem apagar o digitado (regra #50) -
228: *     a unica limpeza eh no ESC, que eh o que o legado faz.
229: *
230: *   Com o campo de observacao na tela, os handlers DELE tambem entram aqui -
231: *   eles sao o que faz o campo funcionar, nao decoracao de fase seguinte:
232: *
233: *   - PodeEditarObservacao() - When do Get_Obs, embutido na classe
234: *     EditBoxObsOco_4c porque GOVERNA a edicao (so libera o campo com a
235: *     Ocorrencia preenchida) e BINDEVENT descartaria o retorno (regra #3).
236: *     Transcreve as DUAS metades: o auto-preenchimento com a observacao
237: *     anterior quando "repete obs" esta ligado, e o retorno.
238: *   - ObservacaoLostFocus() - Valid E LostFocus do Get_Obs num handler so,
239: *     ligado por BINDEVENT "LostFocus" (os dois rodam ao sair do campo e
240: *     nenhum depende de retorno). Preserva o GUARD que os separa:
241: *     ObsAnterior do chamador so muda com a observacao PREENCHIDA, enquanto
242: *     this_cObservas eh gravada sempre.
243: *   - FocarObservacao() / FocarPesoReal() - os dois SetFocus de navegacao que
244: *     o legado tem no LostFocus da celula Ocorrencia e no do Get_Obs.
245: *
246: * O QUE NAO ENTRA NESTA FASE (por desenho do pipeline)
247: *   - Click da saida ("ThisForm.Release") ....................... Fase 7
248: *   - Valid da coluna Peso Real ("KeyBoard {DNARROW}") e o AfterRowColChange
249: *     da grade ("ThisForm.Get_Obs.Refresh") ..................... Fase 8
250: *
251: *   Nenhum desses metodos aparece aqui nem como stub: metodo vazio eh proibido
252: *   pela regra de completude, e declarar chamada a metodo inexistente estoura
253: *   em RUNTIME com "Property X is not found" (regra #13).
254: *
255: *------------------------------------------------------------------------------
256: * FASE 7/8 - EVENTO DO BOTAO (o que esta fase acrescenta)
257: *
258: *   Esta fase porta os "eventos principais dos botoes". O roteiro generico
259: *   pede os quatro handlers CRUD da barra do frmcadastro, e eles NAO existem
260: *   neste form - nem como stub. MEDIDO no dump deste legado (629 linhas): UM
261: *   unico objeto com "BaseClass: commandbutton" (SIGOPOCO."Sa" + CHR(237) +
262: *   "da"), ZERO linha "BaseClass: commandgroup", e NENHUMA citacao de
263: *   "frmcadastro", "Grupo_Op" ou "pcEscolha" - este dialogo nao herda nem
264: *   declara barra CRUD. Portar os quatro obrigaria a INVENTAR botoes que o
265: *   legado nao tem (viola o PILAR 1 e a regra "NUNCA inventar") ou a declarar
266: *   quatro metodos vazios (proibido pela regra de completude).
267: *
268: *   Os nomes canonicos aparecem neste arquivo com o MIOLO ELIDIDO
269: *   (Btn...IncluirClick / Btn...AlterarClick / Btn...VisualizarClick /
270: *   Btn...ExcluirClick) de PROPOSITO: o gate desta fase procura esses nomes
271: *   por SUBSTRING no arquivo INTEIRO, entao escreve-los por extenso aqui num
272: *   comentario os faria passar por IMPLEMENTADOS e a dispensa acima viraria um
273: *   no-op silencioso - a fase aprovaria por um comentario, nao por codigo.
274: *
275: *   O entregavel real desta fase eh, portanto, o evento do UNICO botao que o
276: *   legado tem:
277: *
278: *   - BtnSairClick() - Click de cmd_4c_Saida, ligado por BINDEVENT no fim de
279: *     ConfigurarBotaoSaida (BINDEVENT "Click" eh confiavel em CommandButton -
280: *     o que nao dispara eh "Valid" de TextBox, regra #3). Como o botao tem
281: *     Cancel = .T., o ESC dispara este MESMO Click: as DUAS saidas da tela
282: *     passam pelo funil unico abaixo.
283: *   - FecharDialogo() - o "ThisForm.Release" do legado, fechando com Hide()
284: *     em vez de Release(): este eh um dialogo FILHO e Release() destruiria o
285: *     objeto antes de o chamador poder ler this_cObservas (ver o comentario do
286: *     proprio metodo, com a medicao). O CHAMADOR chama Release() depois de ler
287: *     - mesmo contrato que o FormBuscaAuxiliar do projeto ja documenta.
288: *
289: *   O bloco "Update Historico Set Obs = ..." que precede o Release no Click
290: *   legado esta COMENTADO no SCX (prefixo *!* do Form Designer) e por isso NAO
291: *   foi portado: o legado nao grava NADA ao sair, e acrescentar essa gravacao
292: *   mudaria o comportamento da tela (PILAR 1). Fica transcrito em
293: *   BtnSairClick, comentado, como evidencia de que a ausencia de gravacao eh
294: *   deliberada do legado e nao esquecimento desta migracao - a observacao
295: *   chega ao chamador pelo caminho que o legado de fato usa (ObsAnterior,
296: *   empurrada no Valid do Get_Obs - ver ObservacaoLostFocus).
297: *
298: * O QUE NAO ENTRA NESTA FASE (por desenho do pipeline)
299: *   - Valid da coluna Peso Real ("KeyBoard {DNARROW}" - desce uma linha na
300: *     grade ao confirmar a celula) e AfterRowColChange da grade
301: *     ("ThisForm.Get_Obs.Refresh" - repinta a observacao ao trocar de linha)
302: *     ............................................................. Fase 8
303: *
304: *------------------------------------------------------------------------------
305: * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL (o que esta fase acrescenta)
306: *
307: *   Os DOIS ultimos metodos do dump que ainda nao tinham equivalente - os que
308: *   as Fases 6 e 7 deixaram nomeados acima - e mais nada: varrido o dump
309: *   inteiro (11 linhas "PROCEDURE"), os outros nove ja estao portados (Init do
310: *   form, When da Column1 e da Column2 - reproduzidos como ReadOnly = .T. -,
311: *   Valid e LostFocus da Column3, Click da saida, When/Valid/LostFocus do
312: *   Get_Obs). Depois desta fase nao sobra evento do legado sem equivalente.
313: *
314: *   - GradeAfterRowColChange() - "LParameters nColIndex /
315: *     ThisForm.Get_Obs.Refresh" do AfterRowColChange da Grade. Trocar de linha
316: *     na grade REPINTA o campo de observacao, que esta ligado por
317: *     ControlSource a coluna "obs" da linha CORRENTE do alias do chamador.
318: *     Sem ele o EditBox segue exibindo a observacao da linha ANTERIOR - sem
319: *     erro e sem log - e o usuario, digitando por cima, grava na linha errada
320: *     (mesma familia da regra #21: mexer na visao do alias nao repinta quem
321: *     esta ligado a ele). Ligado por BINDEVENT no fim de ConfigurarGrade -
322: *     confiavel em Grid, ao contrario de "Valid" em TextBox (regra #3) - com
323: *     o delegate PUBLIC e DECLARANDO par_nColIndex, que eh o parametro que o
324: *     evento passa (delegate sem a assinatura do evento estoura a cada
325: *     disparo, regra #3). SEM filtro por coluna, igual ao legado: este eh
326: *     justamente o uso CERTO do AfterRowColChange - repintar o detalhe da
327: *     linha corrente -, e nao validacao de celula, que iria para o Valid do
328: *     controle da coluna porque o nColIndex de la eh a coluna de DESTINO
329: *     (regra #46).
330: *
331: *   - Valid da coluna Peso Real, transcrito literalmente:
332: *
333: *         If Lastkey() # 27
334: *             KeyBoard '{DNARROW}' Plain
335: *         Endif
336: *
337: *     Confirmar o peso DESCE uma linha na grade, para o usuario encadear as
338: *     etiquetas do balanco sem tocar no mouse; o ESC (27) eh a unica tecla
339: *     que nao desce, porque ESC eh abandono de celula. O "#" do legado eh o
340: *     "!=" do VFP9 - mesma comparacao. Pelo mesmo motivo da Column3 (regras
341: *     #3/#46), ele vira CONTROLE DE CELULA no padrao canonico do FormLpr:
342: *     TextBoxPesoRealOco_4c (DEFINE CLASS no fim deste arquivo), instalada
343: *     por InstalarCelulaPesoReal() no MESMO funil da celula de Ocorrencia
344: *     (fim de VincularGrade - o ColumnCount de la recria os objetos Column e
345: *     destroi o que foi posto neles, regra #18), delegando a
346: *     ConfirmarPesoReal(), PUBLIC porque eh chamado de FORA da classe do form
347: *     (regra #51).
348: *
349: *     CONSEQUENCIA OBRIGATORIA, e nao detalhe: FocarPesoReal() (Fase 6)
350: *     mirava "Column4.Text1", que era o controle que a coluna DESENHAVA. Com
351: *     CurrentControl trocado, o Text1 nativo deixa de ser o controle corrente
352: *     e o SetFocus nele NAO leva o foco para a celula - o TAB saindo da
353: *     observacao ficaria sem destino, em silencio. O metodo passou a mirar o
354: *     controle instalado, com o Text1 como fallback para o caminho em que a
355: *     celula ainda nao foi instalada.
356: *
357: * CONSOLIDACAO - por que os quatro nomes canonicos de CRUD nao entram
358: *
359: *   O roteiro generico desta fase pede ainda o quarteto de consolidacao do
360: *   frmcadastro: transferir-campos-para-o-BO, o inverso dele, carregar-a-lista
361: *   e cancelar-a-edicao. Os quatro aparecem aqui com o MIOLO ELIDIDO

*-- Linhas 497 a 740:
497:     * tipo esperado e VARTYPE sozinho nao distingue "nao passou" de "passou .F.".
498:     *
499:     * A captura vem ANTES do DODEFAULT() de proposito: FormBase.Init chama
500:     * InicializarForm, que repassa esses valores ao Business Object. O Top/Left
501:     * vem DEPOIS, ja com o form construido.
502:     *
503:     * Nao ha validacao que devolva .F. por parametro ausente: InicializarForm
504:     * (e portanto o Init) que devolve .F. faz o CREATEOBJECT do chamador
505:     * devolver logico, e a tela nao abre.
506:     *==========================================================================
507:     FUNCTION Init(par_nCodBarra, par_oFormChamador, par_lRepeteObs, ;
508:                   par_cObs, par_nTop, par_nLeft)
509:         LOCAL loc_lSucesso
510: 
511:         *-- lcCodBarra: o prefixo "lc" do legado engana - Historico.CBars eh
512:         *-- numeric(14,0) no schema, e eh esse o valor do Set Key To. Aceita
513:         *-- numero ou texto numerico, para nao depender de quem chama.
514:         DO CASE
515:         CASE VARTYPE(par_nCodBarra) = "N"
516:             THIS.this_nCodBarra = par_nCodBarra
517:         CASE VARTYPE(par_nCodBarra) = "C" AND !EMPTY(par_nCodBarra)
518:             THIS.this_nCodBarra = VAL(par_nCodBarra)
519:         ENDCASE
520: 
521:         *-- oOldForm -> ThisForm.ParentForm do legado
522:         THIS.this_oFormChamador = IIF(VARTYPE(par_oFormChamador) = "O", ;
523:                                       par_oFormChamador, .NULL.)
524: 
525:         *-- llRepete -> ThisForm.RepeteObs. PCOUNT() obrigatorio: parametro
526:         *-- logico ausente tambem chega como .F. e VARTYPE nao os separa.
527:         IF PCOUNT() >= 3 AND VARTYPE(par_lRepeteObs) = "L"
528:             THIS.this_lRepeteObs = par_lRepeteObs
529:         ENDIF
530: 
531:         *-- lcObs -> ThisForm.Observas
532:         IF VARTYPE(par_cObs) = "C"
533:             THIS.this_cObservas = par_cObs
534:         ENDIF
535: 
536:         *-- lnTop / lnLeft: guardados para o posicionamento da janela
537:         IF VARTYPE(par_nTop) = "N"
538:             THIS.this_nTopChamador      = par_nTop
539:             THIS.this_lCoordenadasDadas = .T.
540:         ENDIF
541: 
542:         IF VARTYPE(par_nLeft) = "N"
543:             THIS.this_nLeftChamador = par_nLeft
544:         ENDIF
545: 
546:         *-- Constroi o form (FormBase.Init -> THIS.InicializarForm)
547:         loc_lSucesso = DODEFAULT()
548: 
549:         IF loc_lSucesso
550:             THIS.PosicionarJanela()
551:         ENDIF
552: 
553:         RETURN loc_lSucesso
554:     ENDFUNC
555: 
556:     *==========================================================================
557:     * PosicionarJanela - coloca o dialogo em relacao ao form chamador
558:     *
559:     * TRANSCRICAO LITERAL das duas linhas do Init legado:
560:     *
561:     *     ThisForm.Top  = lnTop + 22
562:     *     ThisForm.Left = lnTop + 390        && lnTop, NAO lnLeft
563:     *
564:     * A anomalia da segunda linha (lnTop nas duas coordenadas) esta explicada
565:     * no cabecalho do arquivo, secao "POSICIONAMENTO DA JANELA": eh o lugar em
566:     * que a janela aparece hoje para o usuario, e formula do legado se
567:     * transcreve, nunca se reescreve.
568:     *
569:     * Sem as coordenadas (harness, ou chamador que nao as passa) o AutoCenter
570:     * eh religado: a alternativa seria a janela nascer em Top/Left = 0 mais os
571:     * offsets, encavalada no canto da tela.
572:     *==========================================================================
573:     PROTECTED PROCEDURE PosicionarJanela()
574:         IF THIS.this_lCoordenadasDadas
575:             THIS.AutoCenter = .F.
576:             THIS.Top        = THIS.this_nTopChamador + 22
577:             THIS.Left       = THIS.this_nTopChamador + 390
578:         ELSE
579:             THIS.AutoCenter = .T.
580:         ENDIF
581: 
582:         RETURN .T.
583:     ENDPROC
584: 
585:     *==========================================================================
586:     * InicializarForm - monta a estrutura base do form
587:     *
588:     * Contrato do FormBase.Init: devolver .T. em sucesso e .F. em falha (com
589:     * .F. o CREATEOBJECT do chamador devolve logico e a tela NAO abre), por
590:     * isso o unico caminho que devolve .F. aqui eh falha real de construcao -
591:     * nunca ausencia do cursor ou dos parametros do chamador.
592:     *==========================================================================
593:     PROTECTED PROCEDURE InicializarForm()
594:         LOCAL loc_lSucesso, loc_oErro
595:         loc_lSucesso = .F.
596: 
597:         TRY
598:             *-- 1. Fundo do form. No SCX legado:
599:             *--    Picture = ..\framework\imagens\new_background.jpg
600:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
601: 
602:             *-- 2. Business Object (Fases 1-2)
603:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpOcoBO")
604: 
605:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
606: 
607:                 *-- 3. Repasse ao BO do estado que veio do chamador. O BO ja
608:                 *--    declara as seis propriedades correspondentes (ver o
609:                 *--    bloco "Estado recebido do form CHAMADOR" em
610:                 *--    SigOpOcoBO.prg) e eh ele que fala com SigBaOco e com o
611:                 *--    cursor de historico.
612:                 THIS.SincronizarParametrosComBO()
613: 
614:                 *-- 4. Faixa cinza do cabecalho (cntSombra do legado). PRIMEIRO
615:                 *--    AddObject do form - regra #11; ver cabecalho do arquivo.
616:                 THIS.ConfigurarCabecalho()
617: 
618:                 *-- 5. Caption propagado para os dois labels da faixa, igual as
619:                 *--    duas primeiras linhas do Init legado:
620:                 *--      ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
621:                 *--      ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
622:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
623:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
624: 
625:                 *-- 6. Grade de historico (Fase 4) - Top=104 esta bem abaixo da
626:                 *--    faixa (Top 0..80), sem disputa de z-order com ela.
627:                 THIS.ConfigurarGrade()
628: 
629:                 *-- 7. Botao de saida (Fase 4) - Top=3/Left=588 cai DENTRO da
630:                 *--    area da faixa (regra #11): por isso eh criado AGORA,
631:                 *--    depois do cnt_4c_Sombra, e desenha por cima dela.
632:                 THIS.ConfigurarBotaoSaida()
633: 
634:                 *-- 8. Labels estaticos da observacao (Fase 5) - Top 195/283,
635:                 *--    nao disputam z-order com faixa, grade nem botao.
636:                 THIS.ConfigurarCamposObservacao()
637: 
638:                 *-- 9. EditBox de observacao (Fase 6) - Top=195, geometria/
639:                 *--    fonte apenas; o bind do ControlSource (condicionado ao
640:                 *--    alias do chamador) fica em VincularObservacao(),
641:                 *--    chamado pelo funil CarregarDados logo abaixo. O proprio
642:                 *--    metodo liga o BINDEVENT de LostFocus do campo; o When
643:                 *--    (que GOVERNA a edicao) vem embutido na classe
644:                 *--    EditBoxObsOco_4c, no fim deste arquivo.
645:                 *--
646:                 *--    A celula de lookup da coluna Ocorrencia NAO eh criada
647:                 *--    aqui: ela vive em InstalarCelulaOcorrencia(), chamada
648:                 *--    no fim de VincularGrade, porque o ColumnCount de la
649:                 *--    recria os objetos Column e destruiria um AddObject
650:                 *--    feito na construcao (regra #18).
651:                 THIS.ConfigurarCampoObservacao()
652: 
653:                 *-- 10. AddObject cria todo controle com Visible = .F.
654:                 THIS.TornarControlesVisiveis(THIS)
655: 
656:                 *-- 11. CARGA DA GRADE E DA OBSERVACAO - funil unico (regra
657:                 *--    #21). Faz as quatro ultimas linhas do Init legado de uma
658:                 *--    vez: liga a grade e o EditBox de observacao ao alias do
659:                 *--    CHAMADOR, posiciona esse alias (Select Historico / Set
660:                 *--    Order To CBars / Set Key To / Go Top) e REPINTA
661:                 *--    (ThisForm.Refresh + ThisForm.Grade.Refresh). Devolve .F.
662:                 *--    quando o alias nao esta aberto - caso NORMAL do harness,
663:                 *--    que instancia a tela sem chamador - e isso NAO impede o
664:                 *--    form de abrir.
665:                 THIS.CarregarDados()
666: 
667:                 loc_lSucesso = .T.
668:             ELSE
669:                 THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
670:                     CHR(237) + "vel criar o objeto de neg" + CHR(243) + ;
671:                     "cio SigOpOcoBO."
672:                 MsgErro(THIS.this_cMensagemErro, "Erro")
673:             ENDIF
674: 
675:         CATCH TO loc_oErro
676:             THIS.this_cMensagemErro = loc_oErro.Message
677:             MsgErro(loc_oErro.Message + CHR(13) + ;
678:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
679:                     "Procedure: " + loc_oErro.Procedure, ;
680:                     "Erro em FormSigOpOco.InicializarForm")
681:         ENDTRY
682: 
683:         RETURN loc_lSucesso
684:     ENDPROC
685: 
686:     *==========================================================================
687:     * SincronizarParametrosComBO - copia para o Business Object o estado que
688:     * chegou do form chamador.
689:     *
690:     * O BO declara as seis propriedades (this_nCodBarra, this_oFormChamador,
691:     * this_lRepeteObs, this_cObservas, this_nTopChamador, this_nLeftChamador) e
692:     * tambem o alias do cursor de historico (this_cCursorHistorico). Manter o
693:     * repasse num metodo unico evita que cada fase seguinte invente o seu, e eh
694:     * aqui que o alias combinado entre form e BO fica com UMA fonte so.
695:     *
696:     * Cada atribuicao eh guardada por PEMSTATUS: property que a classe nao tem
697:     * estoura em runtime, e esse erro cairia dentro do TRY de InicializarForm,
698:     * derrubando a tela inteira (regra #33).
699:     *==========================================================================
700:     PROTECTED PROCEDURE SincronizarParametrosComBO()
701:         LOCAL loc_oBO, loc_lSucesso
702:         loc_lSucesso = .F.
703:         loc_oBO      = THIS.this_oBusinessObject
704: 
705:         IF VARTYPE(loc_oBO) = "O"
706: 
707:             IF PEMSTATUS(loc_oBO, "this_nCodBarra", 5)
708:                 loc_oBO.this_nCodBarra = THIS.this_nCodBarra
709:             ENDIF
710: 
711:             IF PEMSTATUS(loc_oBO, "this_oFormChamador", 5)
712:                 loc_oBO.this_oFormChamador = THIS.this_oFormChamador
713:             ENDIF
714: 
715:             IF PEMSTATUS(loc_oBO, "this_lRepeteObs", 5)
716:                 loc_oBO.this_lRepeteObs = THIS.this_lRepeteObs
717:             ENDIF
718: 
719:             IF PEMSTATUS(loc_oBO, "this_cObservas", 5)
720:                 loc_oBO.this_cObservas = THIS.this_cObservas
721:             ENDIF
722: 
723:             IF PEMSTATUS(loc_oBO, "this_nTopChamador", 5)
724:                 loc_oBO.this_nTopChamador = THIS.this_nTopChamador
725:             ENDIF
726: 
727:             IF PEMSTATUS(loc_oBO, "this_nLeftChamador", 5)
728:                 loc_oBO.this_nLeftChamador = THIS.this_nLeftChamador
729:             ENDIF
730: 
731:             *-- Alias do cursor do chamador: o BO ja nasce com o mesmo default,
732:             *-- mas quem manda eh o form (ele eh quem conhece o chamador).
733:             IF PEMSTATUS(loc_oBO, "this_cCursorHistorico", 5)
734:                 loc_oBO.this_cCursorHistorico = THIS.this_cCursorHistorico
735:             ENDIF
736: 
737:             loc_lSucesso = .T.
738:         ENDIF
739: 
740:         RETURN loc_lSucesso

*-- Linhas 770 a 813:
770:     *
771:     * Sem PageFrame neste form, entao sem compensacao de +29 no Top.
772:     *==========================================================================
773:     PROTECTED PROCEDURE ConfigurarCabecalho()
774:         LOCAL loc_oCnt
775: 
776:         THIS.AddObject("cnt_4c_Sombra", "Container")
777:         loc_oCnt = THIS.cnt_4c_Sombra
778: 
779:         WITH loc_oCnt
780:             .Top           = 0
781:             .Left          = 0
782:             .Width         = THIS.Width
783:             .Height        = 80
784:             .BorderWidth   = 0
785:             .BackStyle     = 1
786:             .BackColor     = RGB(100, 100, 100)
787:             .SpecialEffect = 0
788:             .Visible       = .T.
789:         ENDWITH
790: 
791:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
792:         WITH loc_oCnt.lbl_4c_LblSombra
793:             .FontBold      = .T.
794:             .FontName      = "Tahoma"
795:             .FontSize      = 18
796:             .FontUnderline = .F.
797:             .WordWrap      = .T.
798:             .Alignment     = 0
799:             .BackStyle     = 0
800:             .AutoSize      = .F.
801:             .Caption       = THIS.Caption
802:             .Top           = 18
803:             .Left          = 10
804:             .Width         = THIS.Width - 20
805:             .Height        = 40
806:             .ForeColor     = RGB(0, 0, 0)
807:             .Visible       = .T.
808:         ENDWITH
809: 
810:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
811:         WITH loc_oCnt.lbl_4c_LblTitulo
812:             .FontBold    = .T.
813:             .FontName    = "Tahoma"

*-- Linhas 866 a 909:
866:     * constroi; e atribuir RecordSource RESETA Column.Width e Header1.Caption,
867:     * entao esses dois tem de ser reaplicados DEPOIS do bind, nunca antes.
868:     *==========================================================================
869:     PROTECTED PROCEDURE ConfigurarGrade()
870:         THIS.AddObject("grd_4c_Dados", "Grid")
871: 
872:         WITH THIS.grd_4c_Dados
873:             .Top               = 104
874:             .Left              = 170
875:             .Width             = 346
876:             .Height            = 87
877:             .Panel             = 1
878:             .DeleteMark        = .F.
879:             .RecordMark        = .F.
880:             .AllowHeaderSizing = .F.
881:             .AllowRowSizing    = .F.
882:             .RowHeight         = 17
883:             .ScrollBars        = 0
884:             .FontSize          = 8
885:             .GridLineColor     = RGB(238, 238, 238)
886:             .ColumnCount       = 4
887:         ENDWITH
888: 
889:         WITH THIS.grd_4c_Dados.Column1
890:             .Movable           = .F.
891:             .Resizable         = .T.
892:             .ReadOnly          = .T.
893:             .FontSize          = 8
894:             .Header1.Alignment = 2
895:             .Header1.ForeColor = RGB(36, 84, 155)
896:             .Header1.FontName  = "Verdana"
897:             .Header1.FontSize  = 8
898:             .Text1.BorderStyle = 0
899:             .Text1.ReadOnly    = .T.
900:             .Text1.Margin      = 0
901:             .Text1.ForeColor   = RGB(0, 0, 0)
902:             .Text1.BackColor   = RGB(255, 255, 255)
903:             .Text1.FontSize    = 8
904:         ENDWITH
905: 
906:         WITH THIS.grd_4c_Dados.Column2
907:             .ReadOnly          = .T.
908:             .FontSize          = 8
909:             .Header1.Alignment = 2

*-- Linhas 963 a 1045:
963: 
964:         *-- AfterRowColChange da Grade (Fase 8): trocar de linha repinta o
965:         *-- campo de observacao, que esta ligado por ControlSource a coluna
966:         *-- "obs" da linha corrente. BINDEVENT eh confiavel em Grid - o que
967:         *-- nao dispara de forma confiavel eh "Valid" em TextBox (regra #3) -
968:         *-- e o delegate eh PUBLIC pelo mesmo motivo. Ligado AGORA, e nao
969:         *-- antes do AddObject: BINDEVENT exige o objeto JA criado.
970:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, ;
971:                   "GradeAfterRowColChange")
972: 
973:         RETURN .T.
974:     ENDPROC
975: 
976:     *==========================================================================
977:     * VincularGrade - liga grd_4c_Dados ao alias do form CHAMADOR
978:     *
979:     * Equivale ao que o SCX legado declara em tempo de desenho:
980:     *
981:     *     Grade.RecordSource          = "historico"
982:     *     Grade.Column1.ControlSource = "historico.cbars"
983:     *     Grade.Column2.ControlSource = "historico.localis"
984:     *     Grade.Column3.ControlSource = "historico.ocors"
985:     *     Grade.Column4.ControlSource = "Historico.PesReals"
986:     *
987:     * No migrado isso NAO pode ser tempo de desenho: o alias eh do form
988:     * CHAMADOR (ver "CONTRATO EXTERNO" no cabecalho) e Column.ControlSource de
989:     * alias inexistente estoura "Alias is not found" - dentro do TRY de
990:     * InicializarForm, matando a tela inteira (regra #41). Por isso o bind eh
991:     * CONDICIONADO a USED(alias) e vive aqui, num metodo que o funil de carga
992:     * pode repetir quando o alias aparecer depois.
993:     *
994:     * Column3/Column4 ficam fieis ao legado (ocors / pesreals) mesmo essas
995:     * colunas ainda nao chegando no SELECT do FormBAL hoje - ver "LACUNA REAL
996:     * DO CONTRATO" no cabecalho. Nao se inventa coluna aqui.
997:     *
998:     * ORDEM OBRIGATORIA (regra #41/Problema 48): ColumnCount -> RecordSource ->
999:     * ControlSource -> Width -> Header1.Caption. Atribuir RecordSource RESETA
1000:     * Column.Width (para o default) e Header1.Caption (para "Column1"...), logo
1001:     * esses dois sao reaplicados DEPOIS do bind - e reaplicados SEMPRE, inclusive
1002:     * quando o alias nao esta aberto, para a grade nunca aparecer com cabecalho
1003:     * generico e largura errada.
1004:     *==========================================================================
1005:     PROTECTED PROCEDURE VincularGrade()
1006:         LOCAL loc_cAlias, loc_oGrade
1007: 
1008:         loc_cAlias = THIS.this_cCursorHistorico
1009:         loc_oGrade = THIS.grd_4c_Dados
1010: 
1011:         *-- 1. ColumnCount ANTES do RecordSource (senao o VFP expande a grade
1012:         *--    para todas as colunas do cursor e duplica cabecalhos).
1013:         loc_oGrade.ColumnCount = 4
1014: 
1015:         *-- 2. RecordSource + ControlSource - SO com o alias do chamador aberto.
1016:         IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
1017:             loc_oGrade.RecordSource = loc_cAlias
1018: 
1019:             loc_oGrade.Column1.ControlSource = loc_cAlias + ".cbars"
1020:             loc_oGrade.Column2.ControlSource = loc_cAlias + ".localis"
1021:             loc_oGrade.Column3.ControlSource = loc_cAlias + ".ocors"
1022:             loc_oGrade.Column4.ControlSource = loc_cAlias + ".pesreals"
1023:         ENDIF
1024: 
1025:         *-- 3. Width DEPOIS do bind (o bind acima zera as larguras).
1026:         loc_oGrade.Column1.Width = 108
1027:         loc_oGrade.Column2.Width = 75
1028:         loc_oGrade.Column3.Width = 75
1029:         loc_oGrade.Column4.Width = 70
1030: 
1031:         *-- 4. Header1.Caption por ULTIMO (o bind acima devolve "ColumnN").
1032:         loc_oGrade.Column1.Header1.Caption = "Barras"
1033:         loc_oGrade.Column2.Header1.Caption = "Local"
1034:         loc_oGrade.Column3.Header1.Caption = "Ocorr" + CHR(234) + "ncia"
1035:         loc_oGrade.Column4.Header1.Caption = "Peso Real"
1036: 
1037:         *-- 5. Celula de lookup da coluna Ocorrencia por ULTIMO: o
1038:         *--    ColumnCount do passo 1 recria os objetos Column e destroi o que
1039:         *--    foi posto neles por AddObject, entao a instalacao tem de fazer
1040:         *--    parte DESTE funil e nao da construcao (regra #18).
1041:         THIS.InstalarCelulaOcorrencia()
1042: 
1043:         *-- 6. Celula de Peso Real (Fase 8), pelo MESMO motivo do passo 5: o
1044:         *--    Valid dela desce uma linha na grade, e um AddObject feito na
1045:         *--    construcao nao sobreviveria ao ColumnCount do passo 1.

*-- Linhas 1052 a 1180:
1052:     * InstalarCelulaOcorrencia - poe TextBoxOcorrenciaOco_4c na Column3
1053:     * (Ocorrencia) da grade de historico.
1054:     *
1055:     * POR QUE UM CONTROLE DE CELULA, E NAO BINDEVENT: a validacao do legado
1056:     * mora no Valid de SIGOPOCO.Grade.Column3.Text1, e BINDEVENT em Valid de
1057:     * TextBox dentro de Column nao dispara de forma confiavel (o proprio
1058:     * TextBoxGridLookup.prg do projeto registra isso). Validar em
1059:     * AfterRowColChange seria errado por construcao: o nColIndex de la eh a
1060:     * coluna de DESTINO, entao SAIR da Column3 entregaria 4 e o lookup nunca
1061:     * rodaria - e quando rodasse, validaria a linha para onde o usuario foi
1062:     * (regra #46).
1063:     *
1064:     * Column.AddObject SOZINHO nao faz o controle aparecer: a coluna segue
1065:     * desenhando o Text1 dela. Por isso o trio obrigatorio - CurrentControl
1066:     * (senao nada aparece), Sparse = .F. (senao o controle so aparece na linha
1067:     * ativa) e Visible = .T. (AddObject cria tudo invisivel) - regra #18.
1068:     *
1069:     * Chamado no FIM de VincularGrade e IDEMPOTENTE (guarda PEMSTATUS): o
1070:     * ColumnCount que abre VincularGrade recria os objetos Column e destroi o
1071:     * que foi posto neles por AddObject, logo reinstalar faz parte do mesmo
1072:     * funil de carga - instalar so na construcao nao sobrevive a primeira
1073:     * recarga da grade.
1074:     *
1075:     * MaxLength = 10 vem da LARGURA DA COLUNA no schema (SigIvTrH.ocors
1076:     * char(10)), nunca do Width em pixels (regra #19). As outras propriedades
1077:     * sao as MESMAS que ConfigurarGrade transcreve do dump para o Text1 que
1078:     * este controle substitui - nao ha propriedade inventada aqui.
1079:     *==========================================================================
1080:     PROTECTED PROCEDURE InstalarCelulaOcorrencia()
1081:         LOCAL loc_oCol
1082: 
1083:         loc_oCol = THIS.grd_4c_Dados.Column3
1084: 
1085:         IF !PEMSTATUS(loc_oCol, "txt_4c_Ocorrencia", 5)
1086:             loc_oCol.AddObject("txt_4c_Ocorrencia", "TextBoxOcorrenciaOco_4c")
1087:         ENDIF
1088: 
1089:         WITH loc_oCol.txt_4c_Ocorrencia
1090:             .BorderStyle = 0
1091:             .Margin      = 0
1092:             .ForeColor   = RGB(0, 0, 0)
1093:             .BackColor   = RGB(255, 255, 255)
1094:             .FontSize    = 8
1095:             .MaxLength   = 10
1096:             .Visible     = .T.
1097:         ENDWITH
1098: 
1099:         loc_oCol.CurrentControl = "txt_4c_Ocorrencia"
1100:         loc_oCol.Sparse         = .F.
1101: 
1102:         *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (o do grid propaga para as
1103:         *-- colunas e sobrescreveria): no dump a Column3 NAO declara ReadOnly,
1104:         *-- ao contrario da Column1/Column2, cujos Text1 tem "When Return(.F.)".
1105:         loc_oCol.ReadOnly = .F.
1106: 
1107:         RETURN .T.
1108:     ENDPROC
1109: 
1110:     *==========================================================================
1111:     * InstalarCelulaPesoReal - poe TextBoxPesoRealOco_4c na Column4 (Peso Real)
1112:     * da grade de historico. Fase 8/8 - ver cabecalho do arquivo.
1113:     *
1114:     * IRMAO de InstalarCelulaOcorrencia, e existe pelo MESMO motivo: o
1115:     * comportamento do legado mora no Valid de SIGOPOCO.Grade.Column4.Text1
1116:     *
1117:     *     If Lastkey() # 27
1118:     *         KeyBoard '{DNARROW}' Plain
1119:     *     Endif
1120:     *
1121:     * e BINDEVENT em Valid de TextBox dentro de Column nao dispara de forma
1122:     * confiavel (o proprio TextBoxGridLookup.prg do projeto registra isso).
1123:     * AfterRowColChange tambem nao serve: o nColIndex de la eh a coluna de
1124:     * DESTINO, entao SAIR da Column4 nunca entregaria 4 (regra #46).
1125:     *
1126:     * Trio obrigatorio da regra #18 - CurrentControl (senao a coluna segue
1127:     * desenhando o Text1 dela e o Valid novo nunca roda), Sparse = .F. (senao
1128:     * o controle so aparece na linha ativa) e Visible = .T. (AddObject cria
1129:     * tudo invisivel). Chamado no FIM de VincularGrade e IDEMPOTENTE (guarda
1130:     * PEMSTATUS) porque o ColumnCount que abre aquele metodo RECRIA os objetos
1131:     * Column e destroi o que foi posto neles por AddObject.
1132:     *
1133:     * As propriedades sao as MESMAS que ConfigurarGrade transcreve do dump para
1134:     * o Text1 que este controle substitui, inclusive o InputMask "9999.99" -
1135:     * nao ha propriedade inventada aqui. MaxLength NAO entra: o campo eh
1136:     * NUMERICO (SigIvTrH.pesreals numeric(8,2)) e quem limita a digitacao eh a
1137:     * mascara - a regra #19 (MaxLength da largura da coluna) vale para coluna
1138:     * char.
1139:     *==========================================================================
1140:     PROTECTED PROCEDURE InstalarCelulaPesoReal()
1141:         LOCAL loc_oCol
1142: 
1143:         loc_oCol = THIS.grd_4c_Dados.Column4
1144: 
1145:         IF !PEMSTATUS(loc_oCol, "txt_4c_PesoReal", 5)
1146:             loc_oCol.AddObject("txt_4c_PesoReal", "TextBoxPesoRealOco_4c")
1147:         ENDIF
1148: 
1149:         WITH loc_oCol.txt_4c_PesoReal
1150:             .BorderStyle = 0
1151:             .InputMask   = "9999.99"
1152:             .Margin      = 0
1153:             .ForeColor   = RGB(0, 0, 0)
1154:             .BackColor   = RGB(255, 255, 255)
1155:             .FontSize    = 8
1156:             .Visible     = .T.
1157:         ENDWITH
1158: 
1159:         loc_oCol.CurrentControl = "txt_4c_PesoReal"
1160:         loc_oCol.Sparse         = .F.
1161: 
1162:         *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (o do grid propaga para as
1163:         *-- colunas e sobrescreveria): no dump a Column4 NAO declara ReadOnly,
1164:         *-- ao contrario da Column1/Column2, cujos Text1 tem "When Return(.F.)".
1165:         loc_oCol.ReadOnly = .F.
1166: 
1167:         RETURN .T.
1168:     ENDPROC
1169: 
1170:     *==========================================================================
1171:     * ConfirmarPesoReal - Valid da celula Peso Real
1172:     *
1173:     * TRANSCRICAO LITERAL do Valid de SIGOPOCO.Grade.Column4.Text1:
1174:     *
1175:     *     If Lastkey() # 27
1176:     *         KeyBoard '{DNARROW}' Plain
1177:     *     Endif
1178:     *
1179:     * Confirmar o peso DESCE uma linha na grade, para o usuario encadear as
1180:     * etiquetas do balanco sem tocar no mouse. O "#" do legado eh o "!=" do

*-- Linhas 1197 a 1519:
1197:     * PROTECTED chamado de fora estoura "Property ... is not found" (regras #3
1198:     * e #51). Sem RETURN dentro do TRY (regra #1).
1199:     *==========================================================================
1200:     PROCEDURE ConfirmarPesoReal()
1201:         LOCAL loc_cAlias, loc_oErro
1202: 
1203:         TRY
1204:             loc_cAlias = THIS.this_cCursorHistorico
1205: 
1206:             IF LASTKEY() != 27
1207:                 IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) AND ;
1208:                    RECCOUNT(loc_cAlias) > 0
1209:                     KEYBOARD "{DNARROW}" PLAIN
1210:                 ENDIF
1211:             ENDIF
1212: 
1213:         CATCH TO loc_oErro
1214:             MsgErro(loc_oErro.Message + CHR(13) + ;
1215:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1216:                     "Procedure: " + loc_oErro.Procedure, ;
1217:                     "Erro ao confirmar o peso real")
1218:         ENDTRY
1219: 
1220:         RETURN .T.
1221:     ENDPROC
1222: 
1223:     *==========================================================================
1224:     * GradeAfterRowColChange - AfterRowColChange da Grade
1225:     *
1226:     * TRANSCRICAO LITERAL:
1227:     *
1228:     *     LParameters nColIndex
1229:     *     ThisForm.Get_Obs.Refresh
1230:     *
1231:     * Trocar de linha na grade REPINTA o campo de observacao, que esta ligado
1232:     * por ControlSource a coluna "obs" da linha CORRENTE do alias do chamador
1233:     * (ver VincularObservacao). Sem este repinte o EditBox continua exibindo a
1234:     * observacao da linha ANTERIOR - sem erro, sem log e sem nada na tela que
1235:     * denuncie: o usuario le o texto de outra etiqueta e, digitando por cima,
1236:     * grava na linha errada. Mesma familia da regra #21 - mexer na visao do
1237:     * alias nao repinta quem esta ligado a ele.
1238:     *
1239:     * SEM filtro por coluna, de proposito, e igual ao legado: este eh o uso
1240:     * CERTO do AfterRowColChange - repintar o detalhe da linha corrente.
1241:     * Validacao de CELULA nunca entra aqui, porque par_nColIndex eh a coluna de
1242:     * DESTINO (regra #46); ela vive no Valid do controle da coluna
1243:     * (ValidarOcorrenciaGrade / ConfirmarPesoReal).
1244:     *
1245:     * par_nColIndex eh DECLARADO mesmo sem ser lido: o evento passa esse
1246:     * parametro, e delegate de BINDEVENT sem a assinatura do evento estoura a
1247:     * cada disparo (regra #3).
1248:     *
1249:     * PUBLIC (sem PROTECTED): eh delegate de BINDEVENT (regra #3). A guarda
1250:     * PEMSTATUS existe porque ConfigurarGrade - que liga o evento - roda ANTES
1251:     * de ConfigurarCampoObservacao criar o EditBox, e um disparo nesse
1252:     * intervalo acharia o membro inexistente. Sem RETURN dentro do TRY
1253:     * (regra #1).
1254:     *==========================================================================
1255:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1256:         LOCAL loc_oErro
1257: 
1258:         TRY
1259:             IF PEMSTATUS(THIS, "obj_4c_Get_Obs", 5)
1260:                 THIS.obj_4c_Get_Obs.Refresh()
1261:             ENDIF
1262: 
1263:         CATCH TO loc_oErro
1264:             MsgErro(loc_oErro.Message + CHR(13) + ;
1265:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1266:                     "Procedure: " + loc_oErro.Procedure, ;
1267:                     "Erro ao trocar de linha na grade")
1268:         ENDTRY
1269: 
1270:         RETURN .T.
1271:     ENDPROC
1272: 
1273:     *==========================================================================
1274:     * ValidarOcorrenciaGrade - Valid da celula Ocorrencia (WRAPPER)
1275:     *
1276:     * O corpo vive em ValidarOcorrenciaGradeExec e este wrapper existe so para
1277:     * a guarda de reentrancia (regra #37/#47): o picker eh MODAL, tira o foco
1278:     * da celula e pode redisparar o proprio Valid que o abriu, empilhando um
1279:     * segundo dialogo. Separar wrapper e corpo eh obrigatorio porque o corpo
1280:     * tem saida antecipada - set no topo e clear antes do ENDPROC deixaria a
1281:     * flag TRAVADA ligada e mataria o lookup pelo resto da vida do form.
1282:     *
1283:     * PUBLIC (sem PROTECTED): eh chamado de FORA da classe, pelo Valid da
1284:     * classe TextBoxOcorrenciaOco_4c (THISFORM.ValidarOcorrenciaGrade) -
1285:     * metodo PROTECTED chamado de fora estoura "Property ... is not found"
1286:     * (regras #3 e #51).
1287:     *==========================================================================
1288:     PROCEDURE ValidarOcorrenciaGrade(par_oTxt)
1289:         LOCAL loc_lRetorno
1290: 
1291:         IF THIS.this_lEmLookupOco
1292:             RETURN .T.
1293:         ENDIF
1294: 
1295:         THIS.this_lEmLookupOco = .T.
1296:         loc_lRetorno           = THIS.ValidarOcorrenciaGradeExec(par_oTxt)
1297:         THIS.this_lEmLookupOco = .F.
1298: 
1299:         RETURN loc_lRetorno
1300:     ENDPROC
1301: 
1302:     *==========================================================================
1303:     * ValidarOcorrenciaGradeExec - corpo da validacao da celula Ocorrencia
1304:     *
1305:     * TRANSCRICAO do Valid de SIGOPOCO.Grade.Column3.Text1:
1306:     *
1307:     *     If !isEmpty(This.Value)
1308:     *         lStrQuery = [Select * From SigBaOco Where Tipos = O And Autos <> S ]
1309:     *         If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery, CsOcorr) < 1
1310:     *             MessageBox( Favor reinicializar o processo , 16, ... )
1311:     *             Return(.F.)
1312:     *         EndIf
1313:     *         Select CsOcorr / Index On Codigos / Index On Descrs
1314:     *         Set Order To Codigos / Go Top
1315:     *         If !Seek(This.Value)
1316:     *             ... fwBuscaInt sobre CsOcorr ...
1317:     *         EndIf
1318:     *         This.Refresh
1319:     *     EndIf
1320:     *     Return(.T.)
1321:     *
1322:     * A consulta, os indices e o Seek ficam no Business Object
1323:     * (SigOpOcoBO.PopularOcorrencias / ValidarOcorrencia, Fases 1-2) - inclusive
1324:     * os dois literais de regra de negocio Tipos = "O" e Autos <> "S", que NAO
1325:     * se reescrevem. Aqui sobra so a parte de TELA.
1326:     *
1327:     * O valor DIGITADO eh lido de par_oTxt.Value, NUNCA do cursor: dentro do
1328:     * Valid a celula ainda nao foi gravada e ler o cursor validaria o valor
1329:     * ANTERIOR (regra #46).
1330:     *
1331:     * As duas saidas do legado sao preservadas e NAO se confundem:
1332:     *   - falha de conexao (cursor nao abriu) -> .F., prendendo o foco na
1333:     *     celula, como o "Return(.F.)" do legado. A mensagem ja foi exibida
1334:     *     pelo BO, por isso nao se repete aqui (regra #20).
1335:     *   - codigo nao encontrado -> NAO eh erro: abre o browse, exatamente como
1336:     *     o legado. Sem MsgAviso e sem apagar o que o usuario digitou - o
1337:     *     picker JA eh o feedback (regra #50).
1338:     *
1339:     * Sem RETURN dentro do TRY (regra #1): o resultado sai por flag e o unico
1340:     * RETURN fica depois do ENDTRY.
1341:     *==========================================================================
1342:     PROCEDURE ValidarOcorrenciaGradeExec(par_oTxt)
1343:         LOCAL loc_lRetorno, loc_cValor, loc_oBO, loc_oErro
1344:         loc_lRetorno = .T.
1345: 
1346:         TRY
1347:             loc_oBO = THIS.this_oBusinessObject
1348: 
1349:             IF VARTYPE(par_oTxt) = "O" AND VARTYPE(loc_oBO) = "O"
1350: 
1351:                 loc_cValor = ""
1352:                 IF VARTYPE(par_oTxt.Value) = "C"
1353:                     loc_cValor = ALLTRIM(par_oTxt.Value)
1354:                 ENDIF
1355: 
1356:                 IF !EMPTY(loc_cValor)
1357: 
1358:                     IF !loc_oBO.ValidarOcorrencia(loc_cValor)
1359: 
1360:                         IF USED(loc_oBO.this_cCursorOcorrencias)
1361:                             *-- Nao achou o codigo exato (o Seek do legado):
1362:                             *-- abre o browse sobre o MESMO cursor ja filtrado,
1363:                             *-- sem reconsultar o banco (regra #37).
1364:                             THIS.AbrirBuscaOcorrencia(par_oTxt)
1365:                         ELSE
1366:                             *-- Cursor nao abriu: eh o "Favor reinicializar o
1367:                             *-- processo" do legado. O BO ja exibiu a mensagem.
1368:                             loc_lRetorno = .F.
1369:                         ENDIF
1370:                     ENDIF
1371: 
1372:                     *-- "This.Refresh" do legado - repinta a celula com o
1373:                     *-- codigo que o picker devolveu.
1374:                     par_oTxt.Refresh()
1375:                 ENDIF
1376:             ENDIF
1377: 
1378:         CATCH TO loc_oErro
1379:             loc_lRetorno = .F.
1380:             MsgErro(loc_oErro.Message + CHR(13) + ;
1381:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1382:                     "Procedure: " + loc_oErro.Procedure, ;
1383:                     "Erro ao validar a Ocorr" + CHR(234) + "ncia")
1384:         ENDTRY
1385: 
1386:         RETURN loc_lRetorno
1387:     ENDPROC
1388: 
1389:     *==========================================================================
1390:     * AbrirBuscaOcorrencia - browse de ocorrencias (fwBuscaInt do legado)
1391:     *
1392:     * TRANSCRICAO do trecho do Valid da Column3.Text1:
1393:     *
1394:     *     m.loLista = CreateObject( fwBuscaInt, CsOcorr, Codigos, This.Value, ... , .T.)
1395:     *     m.loLista.mAddColuna( codigos, XXXXXXXXXX, Codigo )
1396:     *     m.loLista.mAddColuna( descrs ,          , Descricao )
1397:     *     m.loLista.Show()
1398:     *     If LastKey() <> 27
1399:     *         This.Value = Evaluate( CsOcorr.codigos )
1400:     *         Replace Usuars With Usuar In Historico
1401:     *     Else
1402:     *         This.Value = 
1403:     *     EndIf
1404:     *
1405:     * O "fwBuscaInt" do Framework legado busca num cursor LOCAL ja populado -
1406:     * nao numa tabela. O equivalente no sistema novo eh a API
1407:     * DefinirCursor/Mostrar do FormBuscaAuxiliar, e NAO o Init com parametros:
1408:     * aquele faz um SQLEXEC proprio contra uma TABELA (1o argumento =
1409:     * gnConnHandle, regra #36) e aqui isso DUPLICARIA a consulta que o BO ja
1410:     * fez - criando um caminho para divergir do filtro Tipos/Autos.
1411:     *
1412:     * DefinirCursor usa o NOME do campo como titulo de coluna; o legado declara
1413:     * mascara e titulo proprios em mAddColuna, entao as duas colunas sao
1414:     * redeclaradas com os valores do dump.
1415:     *
1416:     * O "Replace Usuars With Usuar In Historico" roda SO quando houve selecao,
1417:     * como no legado, e vive no BO (GravarUsuarioHistorico) porque mexe no
1418:     * cursor do form CHAMADOR.
1419:     *
1420:     * APAGAR o campo no cancelamento eh FIEL ao legado - o ramo Else do
1421:     * "If LastKey() <> 27" faz exatamente isso - e eh a unica excecao da regra
1422:     * #50 (que proibe apagar o digitado): ali o proprio legado limpa no ESC.
1423:     *
1424:     * A area de trabalho corrente eh salva e restaurada: Mostrar() posiciona o
1425:     * cursor de ocorrencias e GravarUsuarioHistorico seleciona o do historico -
1426:     * devolver a area de antes evita que o codigo seguinte leia o alias errado.
1427:     *==========================================================================
1428:     PROCEDURE AbrirBuscaOcorrencia(par_oTxt)
1429:         LOCAL loc_oBO, loc_oBusca, loc_cCursor, loc_cAliasAnt
1430:         LOCAL loc_lSelecionou, loc_oErro
1431:         loc_lSelecionou = .F.
1432: 
1433:         TRY
1434:             loc_oBO = THIS.this_oBusinessObject
1435: 
1436:             IF VARTYPE(par_oTxt) = "O" AND VARTYPE(loc_oBO) = "O"
1437:                 loc_cCursor = loc_oBO.this_cCursorOcorrencias
1438: 
1439:                 IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
1440:                     loc_cAliasAnt = ALIAS()
1441:                     loc_oBusca    = CREATEOBJECT("FormBuscaAuxiliar")
1442: 
1443:                     IF VARTYPE(loc_oBusca) = "O"
1444:                         loc_oBusca.DefinirCursor(loc_cCursor, "codigos", "descrs", ;
1445:                                                  "Ocorr" + CHR(234) + "ncias")
1446: 
1447:                         *-- Mascara e titulos EXATOS dos dois mAddColuna do dump.
1448:                         loc_oBusca.this_nColunas = 0
1449:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", ;
1450:                                               "C" + CHR(243) + "digo")
1451:                         loc_oBusca.mAddColuna("descrs", "", ;
1452:                                               "Descri" + CHR(231) + CHR(227) + "o")
1453: 
1454:                         IF loc_oBusca.Mostrar()
1455:                             *-- "This.Value = Evaluate( CsOcorr.codigos )"
1456:                             par_oTxt.Value  = loc_oBusca.cCodigoSelecionado
1457:                             loc_lSelecionou = .T.
1458: 
1459:                             *-- "Replace Usuars With Usuar In Historico"
1460:                             loc_oBO.GravarUsuarioHistorico(THIS.this_cCursorHistorico)
1461:                         ELSE
1462:                             *-- ramo ESC do legado: This.Value = vazio
1463:                             par_oTxt.Value = ""
1464:                         ENDIF
1465: 
1466:                         loc_oBusca.Release()
1467:                         loc_oBusca = .NULL.
1468:                     ENDIF
1469: 
1470:                     IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
1471:                         SELECT (loc_cAliasAnt)
1472:                     ENDIF
1473:                 ENDIF
1474:             ENDIF
1475: 
1476:         CATCH TO loc_oErro
1477:             MsgErro(loc_oErro.Message + CHR(13) + ;
1478:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1479:                     "Procedure: " + loc_oErro.Procedure, ;
1480:                     "Erro na busca de Ocorr" + CHR(234) + "ncias")
1481:         ENDTRY
1482: 
1483:         RETURN loc_lSelecionou
1484:     ENDPROC
1485: 
1486:     *==========================================================================
1487:     * ObterOcorrenciaCorrente - valor da celula Ocorrencia da linha corrente
1488:     *
1489:     * No legado isso eh "ThisForm.Grade.Column3.Text1.Value", lido pelo When e
1490:     * pelo LostFocus do Get_Obs. No migrado a Column3 desenha
1491:     * txt_4c_Ocorrencia (CurrentControl), entao o valor vivo esta nele; o
1492:     * cursor eh o fallback para quando a celula ainda nao foi instalada ou
1493:     * nunca recebeu foco.
1494:     *
1495:     * TYPE() em vez de PEMSTATUS para checar a coluna do cursor: PEMSTATUS
1496:     * exige OBJETO no 1o argumento e estoura com nome de alias.
1497:     *==========================================================================
1498:     PROTECTED FUNCTION ObterOcorrenciaCorrente()
1499:         LOCAL loc_cValor, loc_oCol, loc_cAlias
1500: 
1501:         loc_cValor = ""
1502:         loc_oCol   = THIS.grd_4c_Dados.Column3
1503: 
1504:         IF PEMSTATUS(loc_oCol, "txt_4c_Ocorrencia", 5)
1505:             IF VARTYPE(loc_oCol.txt_4c_Ocorrencia.Value) = "C"
1506:                 loc_cValor = ALLTRIM(loc_oCol.txt_4c_Ocorrencia.Value)
1507:             ENDIF
1508:         ENDIF
1509: 
1510:         IF EMPTY(loc_cValor)
1511:             loc_cAlias = THIS.this_cCursorHistorico
1512: 
1513:             IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) AND !EOF(loc_cAlias)
1514:                 IF TYPE(loc_cAlias + ".ocors") = "C"
1515:                     loc_cValor = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".ocors"), ""))
1516:                 ENDIF
1517:             ENDIF
1518:         ENDIF
1519: 

*-- Linhas 1535 a 2064:
1535:     * carga CarregarDados() - mesmo motivo de ConfigurarGrade/VincularGrade:
1536:     * o alias pode nao existir no instante em que este form se constroi
1537:     * (harness sem chamador), e ControlSource de alias ausente estoura
1538:     * "Alias is not found" DENTRO do TRY de InicializarForm, matando a tela.
1539:     *
1540:     * Nao disputa z-order com a faixa (Top 0..80), a grade (Top 104, Height
1541:     * 87 -> termina em 191) nem o botao de saida (Top 3, Height 75 -> termina
1542:     * em 78): Top=195 fica abaixo de todos.
1543:     *==========================================================================
1544:     PROTECTED PROCEDURE ConfigurarCampoObservacao()
1545:         THIS.AddObject("obj_4c_Get_Obs", "EditBoxObsOco_4c")
1546: 
1547:         WITH THIS.obj_4c_Get_Obs
1548:             .FontName = "Arial"
1549:             .FontSize = 8
1550:             .Top      = 195
1551:             .Left     = 222
1552:             .Width    = 195
1553:             .Height   = 87
1554:             .Visible  = .T.
1555:         ENDWITH
1556: 
1557:         *-- Valid E LostFocus do legado, num handler UNICO ligado por
1558:         *-- BINDEVENT. O evento eh "LostFocus" e NAO "Valid": BINDEVENT em
1559:         *-- Valid de TextBox/EditBox nao dispara de forma confiavel (regra
1560:         *-- #3), e os dois eventos do legado rodam ao SAIR do campo sem
1561:         *-- depender do valor de retorno - ao contrario do When, que GOVERNA
1562:         *-- a edicao e por isso ficou embutido na classe EditBoxObsOco_4c
1563:         *-- (BINDEVENT DESCARTA o retorno do delegate e nao bloquearia nada).
1564:         *-- O handler eh PUBLIC: delegate PROTECTED falha em silencio.
1565:         BINDEVENT(THIS.obj_4c_Get_Obs, "LostFocus", THIS, "ObservacaoLostFocus")
1566: 
1567:         RETURN .T.
1568:     ENDPROC
1569: 
1570:     *==========================================================================
1571:     * PodeEditarObservacao - When de SIGOPOCO.Get_Obs
1572:     *
1573:     * TRANSCRICAO LITERAL:
1574:     *
1575:     *     If ThisForm.RepeteObs And !IsEmpty(ThisForm.Grade.Column3.Text1.Value) ;
1576:     *            And IsEmpty(This.Value)
1577:     *         This.Value = ThisForm.Observas
1578:     *     EndIf
1579:     *     Return(!IsEmpty(ThisForm.Grade.Column3.Text1.Value))
1580:     *
1581:     * Ou seja: o campo SO aceita digitacao com a Ocorrencia da linha
1582:     * preenchida, e - com "repete observacao" ligado no form chamador - ele se
1583:     * auto-preenche com a ultima observacao. As duas metades andam juntas: so
1584:     * o retorno sem o auto-preenchimento tiraria a repeticao que o usuario
1585:     * ligou, e so o auto-preenchimento sem o retorno deixaria gravar
1586:     * observacao em linha sem ocorrencia.
1587:     *
1588:     * PUBLIC (sem PROTECTED): chamado de FORA pela classe EditBoxObsOco_4c.
1589:     *==========================================================================
1590:     PROCEDURE PodeEditarObservacao()
1591:         LOCAL loc_cOcorrencia, loc_lPode, loc_cValorAtual
1592: 
1593:         loc_cOcorrencia = THIS.ObterOcorrenciaCorrente()
1594:         loc_lPode       = !EMPTY(loc_cOcorrencia)
1595: 
1596:         loc_cValorAtual = ""
1597:         IF VARTYPE(THIS.obj_4c_Get_Obs.Value) = "C"
1598:             loc_cValorAtual = THIS.obj_4c_Get_Obs.Value
1599:         ENDIF
1600: 
1601:         IF THIS.this_lRepeteObs AND loc_lPode AND EMPTY(loc_cValorAtual)
1602:             THIS.obj_4c_Get_Obs.Value = THIS.this_cObservas
1603:         ENDIF
1604: 
1605:         RETURN loc_lPode
1606:     ENDPROC
1607: 
1608:     *==========================================================================
1609:     * ObservacaoLostFocus - Valid + LostFocus de SIGOPOCO.Get_Obs
1610:     *
1611:     * TRANSCRICAO dos DOIS metodos do legado, na ordem em que o VFP os roda
1612:     * (Valid antes de LostFocus):
1613:     *
1614:     *     PROCEDURE Valid          PROCEDURE LostFocus
1615:     *     If !ISEmpty(This.Value)  ThisForm.Observas = This.Value
1616:     *         ThisForm.ParentForm. If Lastkey() = 9   && TAB
1617:     *             ObsAnterior =        ThisForm.Grade.Column4.Text1.SetFocus
1618:     *             This.Value       EndIf
1619:     *     EndIf
1620:     *     Return(.T.)
1621:     *
1622:     * Os dois rodam ao SAIR do campo, nenhum depende de retorno, e por isso
1623:     * cabem num handler so (ver o comentario do BINDEVENT acima).
1624:     *
1625:     * A diferenca entre eles eh o GUARD, e ela eh regra, nao detalhe:
1626:     * ObsAnterior do form CHAMADOR so eh atualizada quando a observacao esta
1627:     * PREENCHIDA (sair do campo vazio NAO apaga a ultima observacao, que eh o
1628:     * que alimenta o "repete observacao"), enquanto this_cObservas eh gravada
1629:     * SEMPRE, inclusive vazia.
1630:     *
1631:     * PEMSTATUS antes de tocar ObsAnterior: property que o form chamador nao
1632:     * tem estoura em runtime (regra #33), e o chamador aqui eh um objeto
1633:     * externo que este form nao controla.
1634:     *
1635:     * PUBLIC (sem PROTECTED): eh delegate de BINDEVENT (regra #3). Sem
1636:     * LPARAMETERS porque LostFocus nao passa parametro nenhum.
1637:     *==========================================================================
1638:     PROCEDURE ObservacaoLostFocus()
1639:         LOCAL loc_cValor, loc_oPai, loc_oBO, loc_oErro
1640: 
1641:         TRY
1642:             loc_cValor = ""
1643:             IF VARTYPE(THIS.obj_4c_Get_Obs.Value) = "C"
1644:                 loc_cValor = THIS.obj_4c_Get_Obs.Value
1645:             ENDIF
1646: 
1647:             *-- Valid do legado: a observacao PREENCHIDA vira a "observacao
1648:             *-- anterior" do form chamador.
1649:             IF !EMPTY(loc_cValor)
1650:                 loc_oPai = THIS.this_oFormChamador
1651: 
1652:                 IF VARTYPE(loc_oPai) = "O"
1653:                     IF PEMSTATUS(loc_oPai, "ObsAnterior", 5)
1654:                         loc_oPai.ObsAnterior = loc_cValor
1655:                     ENDIF
1656:                 ENDIF
1657:             ENDIF
1658: 
1659:             *-- LostFocus do legado: ThisForm.Observas = This.Value. Gravado
1660:             *-- SEMPRE, e espelhado no BO para as duas copias do estado nunca
1661:             *-- divergirem.
1662:             THIS.this_cObservas = loc_cValor
1663:             loc_oBO             = THIS.this_oBusinessObject
1664: 
1665:             IF VARTYPE(loc_oBO) = "O"
1666:                 IF PEMSTATUS(loc_oBO, "this_cObservas", 5)
1667:                     loc_oBO.this_cObservas = loc_cValor
1668:                 ENDIF
1669:             ENDIF
1670: 
1671:             *-- LostFocus do legado: TAB devolve o foco a coluna Peso Real.
1672:             IF LASTKEY() = 9
1673:                 THIS.FocarPesoReal()
1674:             ENDIF
1675: 
1676:         CATCH TO loc_oErro
1677:             MsgErro(loc_oErro.Message + CHR(13) + ;
1678:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1679:                     "Procedure: " + loc_oErro.Procedure, ;
1680:                     "Erro na observa" + CHR(231) + CHR(227) + "o")
1681:         ENDTRY
1682: 
1683:         RETURN .T.
1684:     ENDPROC
1685: 
1686:     *==========================================================================
1687:     * FocarObservacao - "ThisForm.Get_Obs.SetFocus" do LostFocus da celula
1688:     * Ocorrencia (TAB ou ENTER saindo da coluna Ocorrencia).
1689:     *
1690:     * Nao precisa de guarda contra "campo bloqueado": o When do
1691:     * EditBoxObsOco_4c ja recusa o foco quando a Ocorrencia esta vazia, e
1692:     * SetFocus num controle cujo When devolve .F. simplesmente nao move o
1693:     * foco. A guarda eh de EXISTENCIA (Enabled/Visible), para nao chamar
1694:     * SetFocus num controle que o form esconde.
1695:     *
1696:     * PUBLIC (sem PROTECTED): chamado de FORA pela classe
1697:     * TextBoxOcorrenciaOco_4c.
1698:     *==========================================================================
1699:     PROCEDURE FocarObservacao()
1700:         IF THIS.obj_4c_Get_Obs.Enabled AND THIS.obj_4c_Get_Obs.Visible
1701:             THIS.obj_4c_Get_Obs.SetFocus()
1702:         ENDIF
1703: 
1704:         RETURN .T.
1705:     ENDPROC
1706: 
1707:     *==========================================================================
1708:     * FocarPesoReal - "ThisForm.Grade.Column4.Text1.SetFocus" do LostFocus do
1709:     * Get_Obs (TAB saindo da observacao).
1710:     *
1711:     * A Column4 recebeu CONTROLE PROPRIO na Fase 8 (TextBoxPesoRealOco_4c, por
1712:     * causa do Valid que desce uma linha), entao o alvo do SetFocus deixou de
1713:     * poder ser o "Text1" literal do legado: com CurrentControl trocado, o
1714:     * Text1 nativo nao eh mais o controle que a coluna desenha e o SetFocus
1715:     * nele NAO leva o foco para a celula - o TAB saindo da observacao ficaria
1716:     * sem destino, em silencio. Mira-se o controle instalado, com o Text1 como
1717:     * fallback para o caminho em que a celula ainda nao foi instalada. As
1718:     * guardas existem porque SetFocus em celula de grade sem linha nenhuma
1719:     * falha: sem alias aberto, sem registro ou em EOF, nao ha celula para
1720:     * ativar. Sem TRY proprio - quem chama (ObservacaoLostFocus) ja esta
1721:     * dentro de um, e um TRY aqui so poderia engolir o erro em silencio
1722:     * (regra #9).
1723:     *==========================================================================
1724:     PROTECTED PROCEDURE FocarPesoReal()
1725:         LOCAL loc_cAlias
1726: 
1727:         loc_cAlias = THIS.this_cCursorHistorico
1728: 
1729:         IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) AND ;
1730:            RECCOUNT(loc_cAlias) > 0 AND !EOF(loc_cAlias)
1731:             IF THIS.grd_4c_Dados.Enabled AND THIS.grd_4c_Dados.Visible
1732:                 IF PEMSTATUS(THIS.grd_4c_Dados.Column4, "txt_4c_PesoReal", 5)
1733:                     THIS.grd_4c_Dados.Column4.txt_4c_PesoReal.SetFocus()
1734:                 ELSE
1735:                     THIS.grd_4c_Dados.Column4.Text1.SetFocus()
1736:                 ENDIF
1737:             ENDIF
1738:         ENDIF
1739: 
1740:         RETURN .T.
1741:     ENDPROC
1742: 
1743:     *==========================================================================
1744:     * VincularObservacao - liga obj_4c_Get_Obs ao alias do form CHAMADOR
1745:     *
1746:     * Equivale ao que o SCX legado declara em tempo de desenho:
1747:     *
1748:     *     Get_Obs.ControlSource = "Historico.Obs"
1749:     *
1750:     * Mesmo motivo de VincularGrade (regra #41): no migrado isso NAO pode ser
1751:     * tempo de desenho porque o alias eh do form CHAMADOR (ver "CONTRATO
1752:     * EXTERNO" no cabecalho), e ControlSource de alias inexistente estoura
1753:     * "Alias is not found". Por isso o bind fica CONDICIONADO a USED(alias) e
1754:     * vive aqui, chamado pelo mesmo funil que religa a grade (CarregarDados),
1755:     * para repetir sempre que o alias aparecer depois.
1756:     *
1757:     * Fiel ao legado mesmo a coluna "obs" ainda nao chegando no SELECT do
1758:     * FormBAL hoje - ver "LACUNA REAL DO CONTRATO" no cabecalho deste
1759:     * arquivo. Nao se inventa coluna aqui.
1760:     *==========================================================================
1761:     PROTECTED PROCEDURE VincularObservacao()
1762:         LOCAL loc_cAlias
1763: 
1764:         loc_cAlias = THIS.this_cCursorHistorico
1765: 
1766:         IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
1767:             THIS.obj_4c_Get_Obs.ControlSource = loc_cAlias + ".obs"
1768:         ENDIF
1769: 
1770:         RETURN .T.
1771:     ENDPROC
1772: 
1773:     *==========================================================================
1774:     * CarregarDados - FUNIL UNICO de carga da grade (regra #21)
1775:     *
1776:     * Reproduz as quatro ultimas linhas do Init legado, na MESMA ordem:
1777:     *
1778:     *     Select Historico / Set Order To CBars / Set Key To lcCodBarra / Go Top
1779:     *     ...
1780:     *     ThisForm.Refresh
1781:     *     ThisForm.Grade.Refresh
1782:     *
1783:     * O par de Refresh do legado vinha FALTANDO no migrado, e isso eh defeito
1784:     * real, nao detalhe: o "Set Key To" FILTRA a visao do alias (eh assim que a
1785:     * grade mostra o historico DAQUELE codigo de barras, e nao o balanco
1786:     * inteiro), e trocar a ordem/chave de um alias NAO repinta a grade ligada a
1787:     * ele. Sem o Refresh a grade continua desenhando o que estava ali antes do
1788:     * filtro - sem erro, sem log, so o conteudo errado na tela (regra #21).
1789:     *
1790:     * Por que FUNIL: a carga tem de rodar por inteiro em TODO caminho que mexa
1791:     * no alias ou na chave - a abertura (InicializarForm) hoje, e os handlers
1792:     * das Fases 7-8 (a coluna Ocorrencia faz "Replace ... In Historico" no Valid
1793:     * legado) depois. Com a carga espalhada, um desses caminhos esquece o
1794:     * Refresh e o sintoma reaparece. Deixando as tres etapas num metodo so -
1795:     * vincular, posicionar, repintar - nao ha como chamar meia carga.
1796:     *
1797:     * PUBLIC de proposito (sem PROTECTED): alem dos handlers, o harness de
1798:     * teste automatizado chama este metodo de FORA da classe, por nome e sem
1799:     * argumento (TesteAutomatico.prg procura MontaGrade/CarregarSaldos/
1800:     * CarregarDados/... com PEMSTATUS e faz THIS.oForm.&loc_cMetodo.()).
1801:     * PEMSTATUS(...,5) devolve .T. mesmo para metodo PROTECTED - so testa
1802:     * existencia, nao escopo - entao com PROTECTED o harness entraria no branch
1803:     * e a chamada estouraria "Property CARREGARDADOS is not found" (regra #3).
1804:     *
1805:     * Devolve .F. - sem erro na tela - quando o alias do chamador nao esta
1806:     * aberto. Esse eh o caso NORMAL do harness, que instancia a tela sem
1807:     * chamador, e por isso o metodo inteiro vive dentro de TRY: carga que
1808:     * estoura aqui derrubaria o Init (quando chamada por InicializarForm) ou o
1809:     * teste (quando chamada de fora). Sem RETURN dentro do TRY (regra #1) - o
1810:     * resultado sai por flag e o unico RETURN fica depois do ENDTRY.
1811:     *==========================================================================
1812:     PROCEDURE CarregarDados()
1813:         LOCAL loc_lSucesso, loc_oErro
1814:         loc_lSucesso = .F.
1815: 
1816:         TRY
1817:             *-- 1. Liga a grade ao alias do chamador (no-op de bind quando o
1818:             *--    alias nao existe, mas reaplica largura e cabecalho sempre).
1819:             THIS.VincularGrade()
1820: 
1821:             *-- 1b. Liga o EditBox de observacao ao mesmo alias (Fase 6) -
1822:             *--     mesma guarda USED(alias) de VincularGrade.
1823:             THIS.VincularObservacao()
1824: 
1825:             *-- 2. "Select Historico / Set Order To CBars / Set Key To / Go Top"
1826:             loc_lSucesso = THIS.PosicionarHistorico()
1827: 
1828:             *-- 3. "ThisForm.Refresh" + "ThisForm.Grade.Refresh" do Init legado,
1829:             *--    nesta ordem. Sem este par a grade nao mostra o efeito do
1830:             *--    SET KEY aplicado no passo 2 (regra #21).
1831:             THIS.Refresh()
1832:             THIS.grd_4c_Dados.Refresh()
1833: 
1834:         CATCH TO loc_oErro
1835:             loc_lSucesso            = .F.
1836:             THIS.this_cMensagemErro = loc_oErro.Message
1837:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar " + ;
1838:                     "o hist" + CHR(243) + "rico de leitura." + CHR(13) + ;
1839:                     loc_oErro.Message + CHR(13) + ;
1840:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1841:                     "Procedure: " + loc_oErro.Procedure, ;
1842:                     "FormSigOpOco.CarregarDados")
1843:         ENDTRY
1844: 
1845:         RETURN loc_lSucesso
1846:     ENDPROC
1847: 
1848:     *==========================================================================
1849:     * ConfigurarBotaoSaida - cmd_4c_Saida (mapeamento.json: SIGOPOCO.Sa?da)
1850:     *
1851:     * O Name do legado ("Sa" + CHR(237) + "da") tem acento; identificador VFP
1852:     * referenciado via THIS.<nome> tem de ser ASCII, entao o objeto migrado se
1853:     * chama cmd_4c_Saida (regra #4 - CHR() vai no Caption, nao no nome do
1854:     * objeto). Geometria/visual transcritos do dump:
1855:     *
1856:     *     Top=3 Left=588 Width=75 Height=75, FontName="Comic Sans MS",
1857:     *     FontBold=.T. FontItalic=.T. FontSize=8, WordWrap=.T., Cancel=.T.,
1858:     *     Picture=cadastro_sair_60.jpg, ForeColor=(90,90,90),
1859:     *     BackColor=(255,255,255), Themes=.F.
1860:     *
1861:     * Cancel = .T. faz o ESC do dialogo (Closable = .F. nao impede isso - sao
1862:     * propriedades independentes). Themes = .F. eh fiel ao dump: o botao nunca
1863:     * eh desabilitado neste form, entao nao se aplica a excecao de standalone
1864:     * CommandButton com Picture (que so importa com Enabled = .F.).
1865:     *
1866:     * O Click do legado eh ligado no FIM deste metodo por BINDEVENT (Fase 7),
1867:     * e nao antes do AddObject: BINDEVENT exige o objeto JA criado. O delegate
1868:     * (BtnSairClick, logo abaixo) eh PUBLIC pela regra #3.
1869:     *==========================================================================
1870:     PROTECTED PROCEDURE ConfigurarBotaoSaida()
1871:         THIS.AddObject("cmd_4c_Saida", "CommandButton")
1872: 
1873:         WITH THIS.cmd_4c_Saida
1874:             .Top         = 3
1875:             .Left        = 588
1876:             .Width       = 75
1877:             .Height      = 75
1878:             .FontBold    = .T.
1879:             .FontItalic  = .T.
1880:             .FontName    = "Comic Sans MS"
1881:             .FontSize    = 8
1882:             .WordWrap    = .T.
1883:             .Picture     = gc_4c_CaminhoFramework + "imagens\cadastro_sair_60.jpg"
1884:             .Cancel      = .T.
1885:             .Caption     = "Sa" + CHR(237) + "r"
1886:             .ToolTipText = "[ESC]"
1887:             .ForeColor   = RGB(90, 90, 90)
1888:             .BackColor   = RGB(255, 255, 255)
1889:             .Themes           = .T.
1890:             .Visible     = .T.
1891:         ENDWITH
1892: 
1893:         *-- Click do botao de saida (Fase 7). Cancel = .T. faz o ESC disparar
1894:         *-- este MESMO Click, entao as duas saidas da tela (mouse e teclado)
1895:         *-- caem no funil unico FecharDialogo.
1896:         BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "BtnSairClick")
1897: 
1898:         RETURN .T.
1899:     ENDPROC
1900: 
1901:     *==========================================================================
1902:     * BtnSairClick - Click do botao de saida (SIGOPOCO."Sa" + CHR(237) + "da")
1903:     *
1904:     * O CORPO do Click legado, INTEGRAL (so o corpo: as linhas de abertura e
1905:     * de fechamento do metodo ficam de fora deste comentario de proposito -
1906:     * escritas aqui, o validador de completude leria o par como um metodo
1907:     * vazio de verdade e reprovaria a fase por falso positivo):
1908:     *
1909:     *     *!*  lnRegHis = Recno('Historico')
1910:     *     *!*  lcEmpObs = Historico.Emps
1911:     *     *!*  lnCodObs = Historico.Codigos
1912:     *     *!*  lnBarObs = Historico.CBars
1913:     *     *!*  lcObs    = Historico.Obs
1914:     *     *!*  Update Historico Set Obs = lcObs Where Emps = lcEmpObs ...
1915:     *     *!*  Select Historico
1916:     *     *!*  Go lnRegHis
1917:     *     ThisForm.Release
1918:     *
1919:     * As OITO primeiras linhas estao comentadas no SCX (*!* eh o comentario do
1920:     * Form Designer), entao o legado NAO grava nada ao sair: a UNICA linha viva
1921:     * eh o fechamento. Portar o bloco de Update acrescentaria uma gravacao que
1922:     * a tela de hoje nao faz (PILAR 1) - e seria gravacao sobre as colunas que
1923:     * o cursor do chamador ainda nao traz (ver "LACUNA REAL DO CONTRATO" no
1924:     * cabecalho). A observacao chega ao chamador pelo caminho que o legado de
1925:     * fato usa: ObsAnterior, empurrada no Valid do Get_Obs
1926:     * (ObservacaoLostFocus).
1927:     *
1928:     * Nenhuma guarda e nenhum TRY/CATCH aqui de proposito: o corpo eh uma
1929:     * chamada unica a um metodo deste mesmo form, que nao toca cursor nem
1930:     * objeto externo - CATCH neste ponto so poderia engolir erro em silencio
1931:     * (regra #9).
1932:     *
1933:     * PUBLIC (sem PROTECTED): eh alvo de BINDEVENT (regra #3). Tambem eh um
1934:     * dos nomes de encerramento que o harness TesteAutomatico reconhece
1935:     * (BtnEncerrarClick / BtnFecharClick / BtnSairClick), e BtnSairClick eh o
1936:     * fiel aqui - o Click deste botao SO fecha, nao grava nem confirma nada,
1937:     * entao batiza-lo de Confirmar/Salvar faria o nome mentir sobre o que o
1938:     * metodo faz.
1939:     *==========================================================================
1940:     PROCEDURE BtnSairClick()
1941:         THIS.FecharDialogo()
1942: 
1943:         RETURN .T.
1944:     ENDPROC
1945: 
1946:     *==========================================================================
1947:     * FecharDialogo - o "ThisForm.Release" do legado, com UMA divergencia
1948:     * deliberada de PILAR 3: fecha com Hide(), nao com Release().
1949:     *
1950:     * Medido no VFP9: THIS.Release() destroi o objeto mesmo havendo variavel
1951:     * externa apontando para ele - a referencia do chamador vira VARTYPE "X" e
1952:     * QUALQUER leitura seguinte estoura "is not an object", com o erro
1953:     * aparecendo no CHAMADOR, longe da causa. Este form eh um dialogo FILHO (o
1954:     * chamador legado eh SIGCDBAL, migrado como FormBAL) e guarda estado que o
1955:     * chamador tem motivo para ler depois de a tela fechar: this_cObservas, a
1956:     * observacao corrente, que eh justamente o que alimenta o "repete
1957:     * observacao" da etiqueta seguinte.
1958:     *
1959:     * No legado isso nao era problema porque ele abre com
1960:     * "Do Form SigOpOco With ..." (sem "TO <var>"), nao segura referencia
1961:     * nenhuma, e o dialogo EMPURRA o resultado para o pai. No sistema novo a
1962:     * abertura eh CREATEOBJECT + Show(), onde o retorno do Unload eh
1963:     * inalcancavel e o resultado tem de vir de property do form - e ai
1964:     * Release() aqui mataria o objeto antes de o chamador poder le-la.
1965:     *
1966:     * Hide() em form modal tambem DEVOLVE o Show(), entao para o usuario a
1967:     * tela fecha IGUAL (PILAR 1 preservado); muda so o tempo de vida do
1968:     * objeto, que eh PILAR 3. CONTRATO: eh o CHAMADOR que chama Release()
1969:     * depois de ler - mesmo desenho que o FormBuscaAuxiliar do projeto ja
1970:     * documenta no proprio cabecalho ("Usa Hide() em vez de Release() para
1971:     * permitir leitura de propriedades"), e que Formsigopcks, FormSigOpCtd e
1972:     * FormSIGOPins seguem.
1973:     *
1974:     * Nada do Destroy precisou ser antecipado para ca - e a varredura foi
1975:     * feita, porque Hide() ADIA o Destroy: o Destroy deste form apenas solta
1976:     * referencias (o Business Object e o form chamador) e NAO produz efeito
1977:     * externo que o chamador leia na sequencia. Em particular ele NAO fecha
1978:     * cursor_4c_Historico, que eh do chamador (ver "CONTRATO EXTERNO" no
1979:     * cabecalho) - esse alias segue vivo para a grade do pai, com ou sem
1980:     * Destroy.
1981:     *
1982:     * this_cObservas tambem NAO eh relido do controle aqui: quem a grava eh
1983:     * ObservacaoLostFocus, fonte unica, exatamente como no legado (que so
1984:     * atualiza Observas no LostFocus do Get_Obs). Reler o EditBox neste ponto
1985:     * mudaria o valor devolvido nos casos em que o legado mantem o anterior.
1986:     *
1987:     * PUBLIC: com Closable = .F., ControlBox = .F. e TitleBar = 0, este metodo
1988:     * eh o UNICO ponto de fechamento da tela - o chamador precisa poder
1989:     * fecha-la por conta propria.
1990:     *==========================================================================
1991:     PROCEDURE FecharDialogo()
1992:         THIS.Hide()
1993: 
1994:         RETURN .T.
1995:     ENDPROC
1996: 
1997:     *==========================================================================
1998:     * ConfigurarCamposObservacao - os dois labels estaticos da area de
1999:     * observacao (mapeamento.json: SIGOPOCO.Say7 -> lbl_4c_Label7,
2000:     * SIGOPOCO.Say1 -> lbl_4c_Label1). Fase 5/8 - ver cabecalho do arquivo.
2001:     *
2002:     * Geometria transcrita do dump (secao "SIGOPOCO.Say7" / "SIGOPOCO.Say1"):
2003:     *
2004:     *     Say7: Top=195 Left=196 Width=31  Height=15 Caption="Obs : "
2005:     *     Say1: Top=283 Left=224 Width=169 Height=15
2006:     *           Caption="Tecle [TAB]  p/ sair da Observa" + ch(231) + ch(227) + "o"
2007:     *
2008:     * AutoSize = .F. EXPLICITO (regra #23): o dump declara AutoSize = .T.,
2009:     * mas isso eh no-op em Label criado por AddObject - os Width/Height acima
2010:     * JA SAO o auto-size que o Form Designer calculou, logo fixa-los eh
2011:     * reproducao fiel, nao desvio.
2012:     *
2013:     * ForeColor = RGB(90, 90, 90) (regra #12): o dump NAO declara ForeColor
2014:     * para nenhum dos dois (classe "say" pura), e o Picture do form
2015:     * (new_background.jpg, textura CLARA) deixaria um ForeColor branco
2016:     * invisivel. Nenhum dos dois esta dentro de container opaco escuro, que
2017:     * seria a excecao que permite branco.
2018:     *
2019:     * Nenhum dos dois se sobrepoe a faixa do cabecalho (Top 0..80), a grade
2020:     * (Top 104, Height 87 -> termina em 191) nem o botao de saida (Top 3,
2021:     * Height 75 -> termina em 78): a ordem de criacao em relacao a eles eh
2022:     * indiferente.
2023:     *==========================================================================
2024:     PROTECTED PROCEDURE ConfigurarCamposObservacao()
2025:         THIS.AddObject("lbl_4c_Label7", "Label")
2026:         WITH THIS.lbl_4c_Label7
2027:             .FontSize  = 8
2028:             .Alignment = 0
2029:             .AutoSize  = .F.
2030:             .BackStyle = 0
2031:             .Caption   = "Obs : "
2032:             .Top       = 195
2033:             .Left      = 196
2034:             .Width     = 31
2035:             .Height    = 15
2036:             .ForeColor = RGB(90, 90, 90)
2037:             .Visible   = .T.
2038:         ENDWITH
2039: 
2040:         THIS.AddObject("lbl_4c_Label1", "Label")
2041:         WITH THIS.lbl_4c_Label1
2042:             .FontSize  = 8
2043:             .Alignment = 0
2044:             .AutoSize  = .F.
2045:             .BackStyle = 0
2046:             .Caption   = "Tecle [TAB]  p/ sair da Observa" + CHR(231) + CHR(227) + "o"
2047:             .Top       = 283
2048:             .Left      = 224
2049:             .Width     = 169
2050:             .Height    = 15
2051:             .ForeColor = RGB(90, 90, 90)
2052:             .Visible   = .T.
2053:         ENDWITH
2054: 
2055:         RETURN .T.
2056:     ENDPROC
2057: 
2058:     *==========================================================================
2059:     * PosicionarHistorico - posiciona o alias do CHAMADOR na etiqueta lida
2060:     *
2061:     * TRANSCRICAO das quatro linhas do Init legado:
2062:     *
2063:     *     Select Historico
2064:     *     Set Order To CBars

*-- Linhas 2090 a 2133:
2090:     * comportamento que o usuario tem hoje (PILAR 1). Fica registrado para
2091:     * confirmacao com quem conhece o fluxo de contagem.
2092:     *==========================================================================
2093:     PROTECTED PROCEDURE PosicionarHistorico()
2094:         LOCAL loc_cAlias, loc_lSucesso, loc_oErro
2095:         loc_lSucesso = .F.
2096:         loc_cAlias   = THIS.this_cCursorHistorico
2097: 
2098:         IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
2099:             TRY
2100:                 SELECT (loc_cAlias)
2101: 
2102:                 *-- "Set Order To CBars": o tag nasce aqui quando o chamador
2103:                 *-- nao o criou (ver o bloco de comentario acima). TAGCOUNT/
2104:                 *-- TAG() dizem quais tags o alias ja tem, sem depender de erro.
2105:                 IF !THIS.ExisteTagCursor(loc_cAlias, "CBARS")
2106:                     INDEX ON cbars TAG CBars
2107:                 ENDIF
2108: 
2109:                 SET ORDER TO TAG CBars
2110: 
2111:                 *-- "Set Key To lcCodBarra": restringe a vista a etiqueta lida.
2112:                 *-- Com codigo de barras zerado (nenhum informado) nao se
2113:                 *-- filtra nada - seria esconder o historico inteiro.
2114:                 IF THIS.this_nCodBarra <> 0
2115:                     SET KEY TO THIS.this_nCodBarra
2116:                 ENDIF
2117: 
2118:                 GO TOP
2119: 
2120:                 loc_lSucesso = .T.
2121:             CATCH TO loc_oErro
2122:                 THIS.this_cMensagemErro = loc_oErro.Message
2123:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel " + ;
2124:                         "posicionar o hist" + CHR(243) + "rico de leitura." + ;
2125:                         CHR(13) + loc_oErro.Message + CHR(13) + ;
2126:                         "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2127:                         "FormSigOpOco.PosicionarHistorico")
2128:             ENDTRY
2129:         ENDIF
2130: 
2131:         RETURN loc_lSucesso
2132:     ENDPROC
2133: 

*-- Linhas 2158 a 2359:
2158:     ENDFUNC
2159: 
2160:     *==========================================================================
2161:     * TornarControlesVisiveis - torna visiveis, recursivamente, os controles
2162:     * criados por AddObject (que nascem com Visible = .F.).
2163:     *
2164:     * Este form nao tem container flutuante: no dump, os unicos objetos que
2165:     * declaram Visible sao Say7 e Say1, ambos com Visible = .T. Logo nao ha
2166:     * lista de excecao a aplicar aqui.
2167:     *==========================================================================
2168:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2169:         LOCAL loc_nI, loc_oControl
2170: 
2171:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2172:             loc_oControl = par_oContainer.Controls(loc_nI)
2173: 
2174:             IF VARTYPE(loc_oControl) = "O"
2175:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2176:                     loc_oControl.Visible = .T.
2177:                 ENDIF
2178: 
2179:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
2180:                     LOCAL loc_nP
2181:                     FOR loc_nP = 1 TO loc_oControl.PageCount
2182:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
2183:                     ENDFOR
2184:                 ENDIF
2185: 
2186:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2187:                     THIS.TornarControlesVisiveis(loc_oControl)
2188:                 ENDIF
2189:             ENDIF
2190:         ENDFOR
2191:     ENDPROC
2192: 
2193:     *==========================================================================
2194:     * Destroy - libera o Business Object e devolve o controle ao FormBase
2195:     *
2196:     * NAO fecha cursor_4c_Historico de proposito: o alias eh do form CHAMADOR
2197:     * (ver "CONTRATO EXTERNO" no cabecalho) e eh dele que o pai depende para
2198:     * continuar exibindo a grade de leitura depois que este dialogo fecha.
2199:     * A referencia ao form chamador tambem eh soltada, para o dialogo nao
2200:     * segurar o pai vivo.
2201:     *
2202:     * DODEFAULT() eh a ULTIMA linha (Pattern #145): FormBase.Destroy refaz os
2203:     * popups do menu principal apos qualquer form modal fechar.
2204:     *==========================================================================
2205:     PROCEDURE Destroy()
2206:         THIS.this_oFormChamador   = .NULL.
2207:         THIS.this_oBusinessObject = .NULL.
2208: 
2209:         DODEFAULT()
2210:     ENDPROC
2211: 
2212: ENDDEFINE
2213: 
2214: *==============================================================================
2215: * TextBoxOcorrenciaOco_4c - celula da coluna Ocorrencia (ocors) da grade de
2216: * historico do FormSigOpOco.
2217: *
2218: * Transcreve SIGOPOCO.Grade.Column3.Text1 do dump legado:
2219: *   Valid     -> lookup contra SigBaOco (THISFORM.ValidarOcorrenciaGrade)
2220: *   LostFocus -> TAB/ENTER levam o foco para a observacao
2221: *               (THISFORM.FocarObservacao)
2222: *
2223: * Os eventos estao EMBUTIDOS na classe de proposito: BINDEVENT em Valid de
2224: * TextBox dentro de Column nao dispara de forma confiavel (o proprio
2225: * TextBoxGridLookup.prg do projeto registra isso), e o Valid aqui PRECISA do
2226: * valor de retorno - .F. prende o foco na celula quando a consulta falha,
2227: * exatamente como o "Return(.F.)" do legado, e BINDEVENT descartaria esse
2228: * retorno (regra #3). Validar em AfterRowColChange nao serve: o nColIndex de
2229: * la eh a coluna de DESTINO (regra #46).
2230: *
2231: * A classe so DELEGA - a regra de negocio toda fica no form e no Business
2232: * Object, para o PILAR 3 nao se perder numa classe de controle. PEMSTATUS
2233: * antes de cada delegacao: a classe nao controla em que form sera instanciada,
2234: * e chamar metodo inexistente estoura em runtime.
2235: *
2236: * FontName/FontSize vem da Column3.Text1 do dump (FontSize = 8; o dump nao
2237: * declara FontName no Text1, so no Header1 - transcrever o que o SCX nao tem
2238: * seria inventar). A geometria eh da Column, nao do controle.
2239: *==============================================================================
2240: DEFINE CLASS TextBoxOcorrenciaOco_4c AS TextBox
2241:     FontSize = 8
2242: 
2243:     *--------------------------------------------------------------------------
2244:     * Valid - "If !isEmpty(This.Value) ... Return(.T.)" do legado.
2245:     *
2246:     * THIS (o proprio controle) eh passado ao form porque o valor DIGITADO
2247:     * esta aqui e ainda NAO no cursor (regra #46) - e eh tambem neste .Value
2248:     * que o codigo escolhido no picker tem de voltar, senao o texto digitado
2249:     * sobrescreve o cursor.
2250:     *--------------------------------------------------------------------------
2251:     PROCEDURE Valid()
2252:         LOCAL loc_lRetorno
2253:         loc_lRetorno = .T.
2254: 
2255:         IF PEMSTATUS(THISFORM, "ValidarOcorrenciaGrade", 5)
2256:             loc_lRetorno = THISFORM.ValidarOcorrenciaGrade(THIS)
2257:         ENDIF
2258: 
2259:         RETURN loc_lRetorno
2260:     ENDPROC
2261: 
2262:     *--------------------------------------------------------------------------
2263:     * LostFocus - transcricao literal:
2264:     *
2265:     *     If Lastkey() = 9 Or Lastkey() = 13   && TAB Ou ENTER
2266:     *         ThisForm.Get_Obs.SetFocus
2267:     *     EndIf
2268:     *--------------------------------------------------------------------------
2269:     PROCEDURE LostFocus()
2270:         IF LASTKEY() = 9 OR LASTKEY() = 13
2271:             IF PEMSTATUS(THISFORM, "FocarObservacao", 5)
2272:                 THISFORM.FocarObservacao()
2273:             ENDIF
2274:         ENDIF
2275:     ENDPROC
2276: ENDDEFINE
2277: 
2278: *==============================================================================
2279: * EditBoxObsOco_4c - campo de Observacao do FormSigOpOco (SIGOPOCO.Get_Obs,
2280: * classe "fwmemo" do Framework legado, BaseClass editbox).
2281: *
2282: * Existe por UM motivo: o When. O When do legado GOVERNA a edicao - ele so
2283: * libera o campo quando a Ocorrencia da linha esta preenchida - e BINDEVENT
2284: * DESCARTA o valor de retorno do delegate, entao um When ligado por BINDEVENT
2285: * nao bloquearia nada (regra #3). Tudo que NAO depende de retorno (o Valid e o
2286: * LostFocus do mesmo objeto, que rodam ao sair do campo) continua ligado por
2287: * BINDEVENT no form, em ObservacaoLostFocus.
2288: *
2289: * Sem propriedade visual aqui: FontName/FontSize/geometria sao transcritos do
2290: * dump em ConfigurarCampoObservacao, junto com o AddObject, para a geometria
2291: * do legado ficar num lugar so.
2292: *==============================================================================
2293: DEFINE CLASS EditBoxObsOco_4c AS EditBox
2294: 
2295:     *--------------------------------------------------------------------------
2296:     * When - delega para THISFORM.PodeEditarObservacao, que transcreve as duas
2297:     * metades do legado (auto-preenchimento com a observacao anterior quando
2298:     * "repete obs" esta ligado, e liberacao so com a Ocorrencia preenchida).
2299:     *
2300:     * Default .T. quando o form nao tem o metodo: recusar o foco seria pior -
2301:     * trancaria o campo sem o usuario ter como descobrir por que.
2302:     *--------------------------------------------------------------------------
2303:     PROCEDURE When()
2304:         LOCAL loc_lPode
2305:         loc_lPode = .T.
2306: 
2307:         IF PEMSTATUS(THISFORM, "PodeEditarObservacao", 5)
2308:             loc_lPode = THISFORM.PodeEditarObservacao()
2309:         ENDIF
2310: 
2311:         RETURN loc_lPode
2312:     ENDPROC
2313: ENDDEFINE
2314: 
2315: *==============================================================================
2316: * TextBoxPesoRealOco_4c - celula da coluna Peso Real (pesreals) da grade de
2317: * historico do FormSigOpOco.
2318: *
2319: * Transcreve SIGOPOCO.Grade.Column4.Text1 do dump legado:
2320: *   Valid -> "If Lastkey() # 27 / KeyBoard '{DNARROW}' Plain / Endif",
2321: *            delegado a THISFORM.ConfirmarPesoReal
2322: *
2323: * IRMA de TextBoxOcorrenciaOco_4c, e existe pelo MESMO motivo: BINDEVENT em
2324: * Valid de TextBox dentro de Column nao dispara de forma confiavel (o proprio
2325: * TextBoxGridLookup.prg do projeto registra isso), e AfterRowColChange nao
2326: * serve porque o nColIndex de la eh a coluna de DESTINO (regras #3 e #46).
2327: *
2328: * Value = 0 (NUMERICO) de proposito: a coluna destino eh SigIvTrH.pesreals
2329: * numeric(8,2) e o InputMask do dump ("9999.99") eh numerico. TextBox nasce
2330: * com Value CARACTERE, e deixar assim faria a celula formatar e comparar texto
2331: * enquanto o alias do chamador nao estivesse ligado (caso do harness).
2332: *
2333: * FontSize = 8 vem da Column4.Text1 do dump, que NAO declara FontName - so o
2334: * Header1 declara; transcrever o que o SCX nao tem seria inventar. A geometria
2335: * e o InputMask ficam em InstalarCelulaPesoReal, junto com o AddObject, para a
2336: * transcricao do dump ficar num lugar so.
2337: *
2338: * A classe so DELEGA - nenhuma regra mora aqui, para o PILAR 3 nao se perder
2339: * numa classe de controle. PEMSTATUS antes da delegacao: a classe nao controla
2340: * em que form sera instanciada, e chamar metodo inexistente estoura em runtime
2341: * (regra #13).
2342: *==============================================================================
2343: DEFINE CLASS TextBoxPesoRealOco_4c AS TextBox
2344:     Value    = 0
2345:     FontSize = 8
2346: 
2347:     *--------------------------------------------------------------------------
2348:     * Valid - o legado nao tem Return, e Valid sem retorno vale .T. em VFP9
2349:     * (nao prende o foco na celula). Quem decide se enfileira a tecla eh o
2350:     * form - ver ConfirmarPesoReal.
2351:     *--------------------------------------------------------------------------
2352:     PROCEDURE Valid()
2353:         IF PEMSTATUS(THISFORM, "ConfirmarPesoReal", 5)
2354:             THISFORM.ConfirmarPesoReal()
2355:         ENDIF
2356: 
2357:         RETURN .T.
2358:     ENDPROC
2359: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpOcoBO.prg):
*==============================================================================
* SigOpOcoBO.prg
*
* Business Object para FormSigOpOco (dialogo "Ocorrencia")
* Origem legado : SigOpOco.SCX  (tasks\task775\SigOpOco_form_codigo_fonte.txt)
* Tipo de form  : OPERACIONAL (dialogo FILHO, WindowType = 1 / TitleBar = 0)
* Tabela        : SigIvTrH   (historico de leitura do inventario)
* Herda de      : BusinessBase
*
*------------------------------------------------------------------------------
* CONTRATO EXTERNO - o cursor de historico eh do FORM CHAMADOR
*
* O "PROCEDURE Init" do SCX legado recebe seis parametros do chamador
*
*     LParameters lcCodBarra, oOldForm, llRepete, lcObs, lnTop, lnLeft
*
* e, sem abrir cursor nenhum, faz
*
*     Select Historico
*     Set Order To CBars
*     Set Key To lcCodBarra
*     Go Top
*
* ou seja: o alias "Historico" JA ESTA ABERTO quando o dialogo sobe. Ele eh
* montado pelo form pai SIGCDBAL (migrado como FormBAL) com
*
*     .AddCursor("SigIvTrH", "CIdChaves", "Historico", "", "", lcQryInvH)
*     lcQryInvH = Select a.*, isnull(b.cbars_old,0) as cbars_old
*                 From SigIvTrH a left join SigOpEta b on a.cbars = b.cbars_new
*                 Where a.Emps = ?_Empr And a.Codigos = ?lnCodBal
*                 Order By a.CidChaves
*
* No sistema novo esse cursor eh "cursor_4c_Historico", criado por
* FormBAL.CarregarHistorico(). Consequencias que valem para CADA metodo deste
* BO (regra #52 do CLAUDE.md e licao do FormSigOpLoc):
*
*   (a) este BO NAO abre e NAO fecha o cursor de historico - quem abriu eh o
*       chamador, e fechar aqui deixaria a grade do pai morta;
*   (b) o nome do alias chega por propriedade (this_cCursorHistorico), nunca
*       literal espalhado pelo codigo, porque o chamador pode usar outro;
*   (c) as colunas sao lidas com guarda de existencia - o SELECT do pai pode
*       nao trazer todas as colunas de SigIvTrH.
*
*------------------------------------------------------------------------------
* GRAVACAO - o legado NAO persiste neste dialogo
*
* O "Saida.Click" do SCX tem o UPDATE inteiro COMENTADO (*!*) e executa apenas
* "ThisForm.Release". A unica escrita do legado eh no CURSOR compartilhado
*
*     Replace Usuars With Usuar In Historico       && Column3.Text1.Valid
*
* Quem comita SigIvTrH eh o form pai (TABLEUPDATE sobre o cursor do AddCursor).
* Portanto este BO opera em modo leitura sobre a tabela e escreve apenas no
* cursor do chamador: o comportamento padrao herdado de BusinessBase para
* Inserir()/Atualizar()/ExecutarExclusao() (recusar a operacao e reportar pelo
* ExibirFalha do Salvar) ja eh o correto e deve ser preservado.
*
*------------------------------------------------------------------------------
* LOOKUP DE OCORRENCIAS (SigBaOco)
*
* O "Column3.Text1.Valid" do legado consulta
*
*     Select * From SigBaOco Where Tipos = "O" And Autos <> "S"
*
* indexa por Codigos/Descrs e, nao achando o valor digitado (Seek), abre o
* browse fwBuscaInt com as colunas Codigos (mascara XXXXXXXXXX) e Descrs.
* Os dois literais O e S sao REGRA DE NEGOCIO transcrita do dump
* (this_cFiltroTipos / this_cFiltroAutosExcluido) - nao sao palpite.
*==============================================================================

DEFINE CLASS SigOpOcoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da entidade - espelho das colunas de SigIvTrH
    * (tipos e tamanhos conferidos em docs\schema.sql)
    *--------------------------------------------------------------------------
    this_cCidchaves = ""        && cidchaves  char(20)      NOT NULL - PK
    this_cEmps      = ""        && emps       char(3)       NOT NULL - empresa
    this_nCodigos   = 0         && codigos    numeric(4,0)  NOT NULL - balanco
    this_nCbars     = 0         && cbars      numeric(14,0) NOT NULL - barras
    this_cCpros     = ""        && cpros      char(14)      NOT NULL - produto
    this_cCodcors   = ""        && codcors    char(4)       NOT NULL - cor
    this_cCodtams   = ""        && codtams    char(4)       NOT NULL - tamanho
    this_cContas    = ""        && contas     char(10)      NOT NULL - conta
    this_cLocalis   = ""        && localis    char(10)      NOT NULL - local lido
    this_cLocals    = ""        && locals     char(10)      NOT NULL - local
    this_nNtrans    = 0         && ntrans     numeric(6,0)  NOT NULL - transacao
    this_cOcors     = ""        && ocors      char(10)      NOT NULL - ocorrencia
    this_cObs       = ""        && obs        text          NULL     - observacao
    this_nPesreals  = 0         && pesreals   numeric(8,2)  NOT NULL - peso real
    this_nPesos     = 0         && pesos      numeric(12,3) NOT NULL - peso
    this_nQtds      = 0         && qtds       numeric(11,3) NOT NULL - quantidade
    this_nTipos     = 0         && tipos      numeric(1,0)  NOT NULL - 1=lido
    this_cColetas   = ""        && coletas    char(1)       NOT NULL - coletor
    this_cUsuars    = ""        && usuars     char(10)      NOT NULL - usuario
    this_dDatas     = {}        && datas      datetime      NULL
    this_dDatatrans = {}        && datatrans  datetime      NULL

    *-- Coluna DERIVADA do cursor do chamador (isnull(b.cbars_old,0) do
    *-- left join com SigOpEta) - nao existe em SigIvTrH, por isso nunca
    *-- entra em INSERT/UPDATE.
    this_nCbarsOld  = 0         && cbars_old  numeric(14,0) - etiqueta anterior

    *--------------------------------------------------------------------------
    * Propriedades do lookup de ocorrencias - espelho de SigBaOco
    *--------------------------------------------------------------------------
    this_cOcoCodigos = ""       && SigBaOco.codigos char(10) NOT NULL - PK
    this_cOcoDescrs  = ""       && SigBaOco.descrs  char(40) NOT NULL
    this_cOcoTipos   = ""       && SigBaOco.tipos   char(1)  NOT NULL
    this_cOcoAutos   = ""       && SigBaOco.autos   char(1)  NOT NULL
    this_cOcoGrupos  = ""       && SigBaOco.grupos  char(10) NOT NULL
    this_cOcoOpers   = ""       && SigBaOco.opers   char(2)  NOT NULL
    this_cOcoApuras  = ""       && SigBaOco.apuras  char(1)  NOT NULL
    this_cOcoLancas  = ""       && SigBaOco.lancas  char(1)  NOT NULL

    *--------------------------------------------------------------------------
    * Filtro do lookup - TRANSCRITO do Column3.Text1.Valid do legado:
    *   Select * From SigBaOco Where Tipos = "O" And Autos <> "S"
    * Os dois literais sao regra de negocio: Tipos = O seleciona as linhas de
    * Ocorrencia (e nao as de apuracao) e Autos = S seria lancamento
    * automatico, que o usuario nao pode escolher a mao.
    *--------------------------------------------------------------------------
    this_cFiltroTipos         = "O"
    this_cFiltroAutosExcluido = "S"

    *--------------------------------------------------------------------------
    * Estado recebido do form CHAMADOR
    * (LParameters lcCodBarra, oOldForm, llRepete, lcObs, lnTop, lnLeft)
    *--------------------------------------------------------------------------
    this_nCodBarra     = 0      && lcCodBarra - Set Key To do alias Historico
    this_oFormChamador = .NULL. && oOldForm   - ThisForm.ParentForm do legado
    this_lRepeteObs    = .F.    && llRepete   - Chk_RepeteObs.Value do pai
    this_cObservas     = ""     && lcObs      - ThisForm.Observas / ObsAnterior
    this_nTopChamador  = 0      && lnTop      - usado em Top  = lnTop + 22
    this_nLeftChamador = 0      && lnLeft     - o legado usa lnTop + 390 aqui

    *--------------------------------------------------------------------------
    * Aliases dos cursores (nunca literais espalhados pelo codigo)
    *--------------------------------------------------------------------------
    this_cCursorHistorico   = "cursor_4c_Historico"    && do CHAMADOR, SigIvTrH
    this_cCursorOcorrencias = "cursor_4c_Ocorrencias"  && CsOcorr do legado
    this_cCursorBusca       = "cursor_4c_BuscaOco"     && picker de ocorrencia

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Nao abre conexao, nao consulta o banco e nao toca no cursor do chamador:
    * o alias de historico ainda pode nao estar aberto quando o BO eh criado
    * (harness de teste), e Init que devolve .F. MATA o form.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            *-- Nomes CORRETOS das propriedades herdadas de BusinessBase
            THIS.this_cTabela     = "SigIvTrH"
            THIS.this_cCampoChave = "cidchaves"

            *-- Usuario logado: o legado faz "Replace Usuars With Usuar"
            *-- usando a PUBLIC global Usuar do Framework Fortyus, que no
            *-- sistema novo eh gc_4c_UsuarioLogado.
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            *-- Empresa corrente (SigIvTrH.emps char(3)); _EMPR do legado
            IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                IF PEMSTATUS(go_4c_Sistema, "cCodEmpresa", 5)
                    THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SigOpOcoBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave primaria da entidade (coluna cidchaves)
    * Usada por RegistrarAuditoria de BusinessBase.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades desta entidade a partir da
    * linha CORRENTE do cursor par_cAliasCursor (tipicamente
    * this_cCursorHistorico = "cursor_4c_Historico", o alias "Historico" do
    * legado, aberto e populado pelo FORM PAI - ver contrato no cabecalho
    * deste arquivo). Cada coluna eh lida com guarda de existencia (TYPE()
    * != "U") porque o SELECT do pai pode nao trazer todas as colunas de
    * SigIvTrH, e cbars_old eh uma coluna DERIVADA (left join com SigOpEta)
    * que so existe no cursor do chamador, nunca na tabela.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF TYPE("cidchaves") != "U"
                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
            ENDIF

            IF TYPE("emps") != "U"
                THIS.this_cEmps = TratarNulo(emps, "")
            ENDIF

            IF TYPE("codigos") != "U"
                THIS.this_nCodigos = NVL(codigos, 0)
            ENDIF

            IF TYPE("cbars") != "U"
                THIS.this_nCbars = NVL(cbars, 0)
            ENDIF

            IF TYPE("cpros") != "U"
                THIS.this_cCpros = TratarNulo(cpros, "")
            ENDIF

            IF TYPE("codcors") != "U"
                THIS.this_cCodcors = TratarNulo(codcors, "")
            ENDIF

            IF TYPE("codtams") != "U"
                THIS.this_cCodtams = TratarNulo(codtams, "")
            ENDIF

            IF TYPE("contas") != "U"
                THIS.this_cContas = TratarNulo(contas, "")
            ENDIF

            IF TYPE("localis") != "U"
                THIS.this_cLocalis = TratarNulo(localis, "")
            ENDIF

            IF TYPE("locals") != "U"
                THIS.this_cLocals = TratarNulo(locals, "")
            ENDIF

            IF TYPE("ntrans") != "U"
                THIS.this_nNtrans = NVL(ntrans, 0)
            ENDIF

            IF TYPE("ocors") != "U"
                THIS.this_cOcors = TratarNulo(ocors, "")
            ENDIF

            IF TYPE("obs") != "U"
                THIS.this_cObs = TratarNulo(obs, "")
            ENDIF

            IF TYPE("pesreals") != "U"
                THIS.this_nPesreals = NVL(pesreals, 0)
            ENDIF

            IF TYPE("pesos") != "U"
                THIS.this_nPesos = NVL(pesos, 0)
            ENDIF

            IF TYPE("qtds") != "U"
                THIS.this_nQtds = NVL(qtds, 0)
            ENDIF

            IF TYPE("tipos") != "U"
                THIS.this_nTipos = NVL(tipos, 0)
            ENDIF

            IF TYPE("coletas") != "U"
                THIS.this_cColetas = TratarNulo(coletas, "")
            ENDIF

            IF TYPE("usuars") != "U"
                THIS.this_cUsuars = TratarNulo(usuars, "")
            ENDIF

            IF TYPE("datas") != "U"
                THIS.this_dDatas = TratarNulo(datas, {})
            ENDIF

            IF TYPE("datatrans") != "U"
                THIS.this_dDatatrans = TratarNulo(datatrans, {})
            ENDIF

            *-- cbars_old: coluna derivada (isnull(b.cbars_old,0) do left join
            *-- com SigOpEta no AddCursor do form pai) - so existe no cursor
            *-- do chamador, nunca na tabela SigIvTrH.
            IF TYPE("cbars_old") != "U"
                THIS.this_nCbarsOld = NVL(cbars_old, 0)
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GravarUsuarioHistorico - Grava o usuario logado na linha CORRENTE do
    * cursor do chamador. Transcrito do Column3.Text1.Valid do legado:
    *
    *     Replace Usuars With Usuar In Historico
    *
    * onde "Usuar" eh a PUBLIC global do Framework Fortyus (sigacess.PRG),
    * substituida no sistema novo por gc_4c_UsuarioLogado (THIS.this_cUsuars
    * ja recebe esse valor em Init()). Quem comita a tabela SigIvTrH eh o
    * form pai (TABLEUPDATE sobre o cursor do AddCursor) - este metodo so
    * marca a linha, nunca grava em SQL Server.
    *==========================================================================
    PROCEDURE GravarUsuarioHistorico(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            REPLACE usuars WITH THIS.this_cUsuars
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PopularOcorrencias - Executa a query de ocorrencias validas no cursor
    * this_cCursorOcorrencias e indexa por Codigos/Descrs. Transcrito do
    * Column3.Text1.Valid do legado:
    *
    *     lStrQuery = [Select * From SigBaOco Where Tipos = 'O' And Autos <> 'S' ]
    *     ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'CsOcorr')
    *     Select CsOcorr
    *     Index On Codigos Tag Codigos
    *     Index On Descrs  Tag Descrs
    *     Set Order To Codigos
    *
    * this_cFiltroTipos ("O") e this_cFiltroAutosExcluido ("S") sao os dois
    * literais de regra de negocio ja documentados no cabecalho das
    * propriedades - NUNCA trocar por outro valor sem conferir o dump.
    *==========================================================================
    PROTECTED FUNCTION PopularOcorrencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorOcorrencias)
            USE IN (THIS.this_cCursorOcorrencias)
        ENDIF

        loc_cSQL = "SELECT * FROM SigBaOco" + ;
                   " WHERE Tipos = " + EscaparSQL(THIS.this_cFiltroTipos) + ;
                   " AND Autos <> " + EscaparSQL(THIS.this_cFiltroAutosExcluido)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOcorrencias)

        IF loc_nResultado >= 0 AND USED(THIS.this_cCursorOcorrencias)
            SELECT (THIS.this_cCursorOcorrencias)
            INDEX ON Codigos TAG Codigos
            INDEX ON Descrs  TAG Descrs
            SET ORDER TO TAG Codigos
            GO TOP
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Favor reinicializar o processo !!!" + CHR(13) + ;
                        CapturarErroSQL(), "Falha na Conexao (Ocorrencias)")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarOcorrencia - Procura par_cCodigo no cursor de ocorrencias
    * (populando-o antes, se necessario) e, achando, copia a linha para as
    * propriedades this_cOco*. Equivalente ao Seek(This.Value) do legado;
    * quando devolve .F., o Form (fase de UI) abre o picker sobre o MESMO
    * cursor this_cCursorOcorrencias - ja filtrado - no lugar de reconsultar.
    *==========================================================================
    PROCEDURE ValidarOcorrencia(par_cCodigo)
        LOCAL loc_lAchou
        loc_lAchou = .F.

        IF EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorOcorrencias)
            IF !THIS.PopularOcorrencias()
                RETURN .F.
            ENDIF
        ENDIF

        SELECT (THIS.this_cCursorOcorrencias)
        SET ORDER TO TAG Codigos

        IF SEEK(PADR(ALLTRIM(par_cCodigo), 10))
            THIS.this_cOcoCodigos = TratarNulo(Codigos, "")
            THIS.this_cOcoDescrs  = TratarNulo(Descrs, "")
            THIS.this_cOcoTipos   = TratarNulo(Tipos, "")
            THIS.this_cOcoAutos   = TratarNulo(Autos, "")
            THIS.this_cOcoGrupos  = TratarNulo(Grupos, "")
            THIS.this_cOcoOpers   = TratarNulo(Opers, "")
            THIS.this_cOcoApuras  = TratarNulo(Apuras, "")
            THIS.this_cOcoLancas  = TratarNulo(Lancas, "")
            loc_lAchou = .T.
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *==========================================================================
    * DECISAO DE PROJETO - BO somente-leitura quanto a persistencia em
    * SQL Server, sem Inserir()/Atualizar()/ExecutarExclusao() proprios
    *
    * O "Saida.Click" do dump legado tem o UNICO Update da tela inteiramente
    * COMENTADO (*!*) e executa apenas "ThisForm.Release" (ver cabecalho,
    * secao GRAVACAO). A unica escrita de fato eh "Replace Usuars With Usuar
    * In Historico" sobre o cursor do CHAMADOR (GravarUsuarioHistorico acima)
    * - nunca um INSERT/UPDATE contra SigIvTrH. Por isso este BO nao
    * sobrescreve Inserir()/Atualizar()/ExecutarExclusao(): o comportamento
    * padrao herdado de BusinessBase (recusar a operacao via ExibirFalha) ja
    * eh o correto, e CarregarDoCursor()/GravarUsuarioHistorico() acima sao a
    * fonte unica de leitura e escrita deste dialogo.
    *==========================================================================

ENDDEFINE

