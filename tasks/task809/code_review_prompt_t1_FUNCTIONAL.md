# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [METODO-INEXISTENTE] Metodo 'THIS.this_cIdent()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Caption()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.LerCampoDaTela()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.this_lPermiteEsc()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarParcela()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarCartao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarRetornoTef()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_RespostaSiTef' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPTEF.Container1): Top original=13 vs migrado 'lbl_4c_Label10' Top=225 (diff=212px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPTEF.Container1): Left original=4 vs migrado 'lbl_4c_Label10' Left=194 (diff=190px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPTEF): Top original=176 vs migrado 'lbl_4c_Label10' Top=225 (diff=49px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPTEF): Left original=355 vs migrado 'lbl_4c_Label10' Left=194 (diff=161px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoptef.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3704 linhas total):

*-- Linhas 25 a 276:
25: *
26: * FASE 3/8 - Estrutura Base
27: *   Este arquivo PARCIAL cobre DEFINE CLASS + propriedades + Init +
28: *   ValidarParametros + InicializarForm + wiring do BO + os DOIS containers
29: *   que o SCX legado declara (cntSombra -> cnt_4c_Sombra, com os dois labels
30: *   do titulo; Container1 -> cnt_4c_Container1, com o label da mensagem de
31: *   instrucao ao operador). Os controles que penduram DIRETO na Form (SAIDA,
32: *   Shape2, labels soltos, GetValor/GetDigitos/GetParcela/GetCartao/GetCodSeg,
33: *   Text1, Timer1) e os handlers de interacao com o SiTef sao escopo das
34: *   fases 4 a 8 - inclusive a DECLARE DLL, que por "DECLARE DLL carrega na
35: *   hora e mata o form" (CLAUDE.md) so pode entrar dentro de um Load
36: *   protegido.
37: *
38: * Ordem de criacao dos containers (CLAUDE.md regra #11)
39: *   cnt_4c_Sombra eh o PRIMEIRO AddObject da tela: a faixa cinza ocupa
40: *   Top = 0..80 e o CommandGroup SAIDA do legado fica em Top = -2, Left = 420,
41: *   isto eh DENTRO da area da faixa. Criado depois dela (fase 4), o botao
42: *   Cancelar desenha POR CIMA da faixa; invertida a ordem, o cabecalho cobre
43: *   o botao - unica saida do dialogo.
44: *
45: * Correspondencia legado -> migrado (parametros do Init; ver sigoptefBO.prg)
46: *   Legado: Parameters EndSiTef, ValPago, Cupom, Caixa, DebCred, TipPagto,
47: *            NumParcs, lcIdent, pcOpers
48: *   .poDatamgr = CreateObject("fSqlConector",...) + pnIdconn > 0
49: *                                       -> THIS.ValidarParametros()
50: *   .poDatamgr.SqlExecute(SigOpFp...) + SqlExecute(SigCdEmp...)
51: *                                       -> sigoptefBO.BuscarParametrosPagamento()
52: *                                          (chamado por THIS.CarregarParametrosPagamento())
53: *   If crSigOpFp.lCartao = "N" / Container1.Label1.Caption = ...
54: *                                       -> THIS.AtualizarTextosDaTela()
55: *                                          (hook BOParaForm delega para ela)
56: *
57: *   O retorno da tela (equivalente ao Unload legado, usado via "DO FORM ...
58: *   TO var") acompanha os handlers de interacao com o SiTef, nas fases 7 e 8.
59: *
60: * FASE 4/8 - Campos de Captura e Botao de Saida
61: *   Este form OPERACIONAL nao tem lista nem PageFrame (ver layout.json: raiz
62: *   "Class: form"/"BaseClass: form", ZERO objeto BaseClass grid/pageframe) -
63: *   o template generico "Grid + 6 botoes CRUD" desta fase NAO SE APLICA aqui
64: *   (inventar essa superficie violaria o PILAR 1), mesmo criterio ja usado
65: *   nos irmaos desta familia (Formsigopdtf.prg/task725 - "Sitef - Cartao de
66: *   Debito" - e Formsigopsen.prg/task799).
67: *
68: *   Em vez disso, esta fase entrega a camada VISUAL que resta criar direto
69: *   na Form (todos os controles exceto cnt_4c_Sombra/cnt_4c_Container1, ja
70: *   entregues na Fase 3): ConfigurarCampos() (Shape2 + labels + TextBoxes +
71: *   Timer1, SEM nenhum evento ligado), ConfigurarBotaoSaida() (CommandGroup
72: *   cmg_4c_Saida com o botao Cancelar, SEM o Click) e
73: *   ConfigurarOrdemTabulacao(). O BINDEVENT do Click e os eventos de
74: *   protocolo com a DLL (When/Valid/GotFocus/LostFocus dos campos,
75: *   Timer1.Procedure) ficam para as fases 6-8, junto com a DECLARE DLL -
76: *   amarrar agora um Click que chama ContinuaFuncaoSiTefInterativo (exige o
77: *   estado do protocolo, inexistente ainda) e ThisForm.RetornoFalha (metodo
78: *   que tambem ainda nao existe) produziria um handler incompleto.
79: *
80: * FASE 5/8 - Metodos de Retorno ao PDV (sem dependencia da DLL)
81: *   O template generico desta fase ("Page2 - campos principais, parte 1")
82: *   nao se aplica aqui pelo mesmo motivo das fases 3 e 4: este form nao tem
83: *   PageFrame/Page2 (ver layout.json) e ConfigurarCampos() da Fase 4 ja
84: *   criou TODOS os controles (nao ha "metade" para dividir).
85: *
86: *   O que falta e so o protocolo de interacao com a DLL (When/Valid/
87: *   GotFocus/LostFocus + Timer1.Procedure + DECLARE DLL), que a Fase 3/4 ja
88: *   explicitamente deferiu para as fases 6-8 - exigem o estado do protocolo
89: *   (ProximoComando/TipoCampo/Buffer/etc, so existe apos o Load com DECLARE
90: *   DLL). Esta fase entrega a proxima peca que NAO depende desse estado e
91: *   que os handlers das fases 6-8 vao chamar: os tres metodos de
92: *   finalizacao da transacao, equivalentes aos PROCEDURE retornofalha/
93: *   montaretorno/errotef do legado (sigoptef_form_codigo_fonte.txt:756-831) -
94: *   escrevem os arquivos de resposta ao PDV (C:\client\Resp\IntPos.001/.STS,
95: *   formato SDF fixo consumido pela integracao TEF) e registram auditoria
96: *   via sigoptefBO.RegistrarTransacaoTef(). Nenhum dos tres le
97: *   ProximoComando/TipoCampo/Buffer - so recebem valores ja decodificados
98: *   como parametro, por isso podem ser implementados e testados antes do
99: *   DECLARE DLL (fases 6-8 so vao CHAMA-los).
100: *
101: *   GravarRetornoFalha      <- retornofalha (PARAMETERS lcMensagem, lnValPago)
102: *   GravarRetornoAprovado   <- montaretorno (PARAMETERS lsTipTran, lsDataHora,
103: *                              lsCupom, pcCartao, lsNsu, lsAutoriza, lsFinaliza,
104: *                              lnValPago, MenRet)
105: *   ProcessarErroTef        <- errotef (PARAMETERS pnRetornos)
106: *
107: *   ltIdent do legado (Public, atribuido no Init a partir de lcIdent) ja
108: *   corresponde a THIS.this_cIdent (Fase 3). O legado grava STR(ltIdent,10)
109: *   no campo "001-000" - exige NUMERICO; aqui usa-se
110: *   STR(VAL(THIS.this_cIdent), 10), sem mudar a declaracao Character de
111: *   this_cIdent (regra PILAR 3 - menor alteracao possivel na property ja
112: *   publicada pela Fase 3).
113: *
114: *   Guarda "IF Type('lnRetorno')<>'N' and (lnRetorno>-1 Or lnRetorno<-5)" no
115: *   inicio do errotef legado: lnRetorno e a MESMA variavel que o parametro
116: *   pnRetornos recebe em todo call site (sempre "ThisForm.ErroTef(lnRetorno)",
117: *   guardado por "IF lnRetorno < 0"); nesta arquitetura nao ha a mesma
118: *   variavel implicitamente visivel entre metodos (VFP so deixa isso
119: *   acontecer por escopo dinamico de memvar, que este projeto nao usa). O
120: *   efeito pratico desse bloco e um FALLBACK para codigo de retorno fora de
121: *   -1..-5 (os unicos branches especificos) - reproduzido como OTHERWISE do
122: *   DO CASE abaixo, usando o PARAMETRO real (ja garantidamente igual ao que
123: *   a guarda do legado lia): comportamento identico, sem depender de
124: *   variavel de escopo implicito que a nova arquitetura nao usa.
125: *
126: * FASE 6/8 - Eventos dos Campos (os que NAO dependem do laco da DLL)
127: *   CAMPOS RESTANTES: zero. A Fase 4 criou os 6 TextBox, os 11 Labels, o
128: *   Shape, o CommandGroup e o Timer por INTEIRO (a Fase 5 registrou isso no
129: *   bloco acima) - nao ha "ultima metade" a acrescentar nesta tela.
130: *
131: *   LOOKUPS: zero, e isso foi MEDIDO no dump, nao presumido - nenhuma
132: *   ocorrencia de fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/mAddColuna/
133: *   Acesso<X>() em metodo algum de SIGOPTEF (o unico CreateObject do dump e
134: *   o 'fSqlConector' do Init). Este dialogo conversa com o terminal SiTef
135: *   pela CliSiTef32I.DLL, nunca com tabela de lookup. Gerar AbrirLookup*/
136: *   AbrirBusca* aqui exigiria INVENTAR uma tabela de lookup que o legado
137: *   nunca consulta, violando o PILAR 1 e a regra explicita "NUNCA inventar
138: *   tabelas de lookup que nao existem no original" - ou criar metodo vazio,
139: *   proibido pela regra de completude. Mesma leitura, pelos mesmos motivos,
140: *   dos tres irmaos desta familia ja migrados (Formsigopdtf/task725,
141: *   Formsigprdft e FormSigOpCtf).
142: *
143: *   O que ENTRA nesta fase - a superficie de evento que de fato resta e que
144: *   NAO depende do laco de protocolo:
145: *     Form.KeyPress ................. ESC fecha pelo botao Cancelar
146: *     GetValor.When ................. gate de foco (campo so de exibicao)
147: *     GetDigitos.When / LostFocus ... SET CONFIRM OFF/ON
148: *     GetParcela.When / Valid ....... gate de foco + lista "1"/"2"/" "
149: *     GetCartao.Valid ............... limite de 19 digitos
150: *     GetCodSeg.When / GotFocus ..... SET CONFIRM OFF + rotulo do painel
151: *     GetCodSeg.Valid ............... dump INTEIRO comentado (ver nota)
152: *     Text1.When / LostFocus / GotFocus
153: *     Timer1.Timer .................. rearma o ESC e se desliga
154: *   mais ExibirMensagemTef() (substituto do dialogo SigTfDss, consumido ja
155: *   nesta fase por ValidarCartao), RegistrarEventosCampos() com os
156: *   BINDEVENT e AplicarGatesDeFoco(). No BO (sigoptefBO.prg) entrou a
157: *   camada de acesso a DLL: o DECLARE das quatro funcoes - equivalente ao
158: *   PROCEDURE Load do SCX - mais ConectarSiTef/IniciarSiTef/ContinuarSiTef/
159: *   FinalizarTransacaoSiTef/MontarBufferSiTef/ValidarBinCartao/
160: *   CarregarIdentificacaoTerminal e o estado compartilhado do protocolo.
161: *
162: *   ESCOPO DAS FASES 7-8: o Click do botao Cancelar, o Unload (valor
163: *   devolvido ao PDV) e o LACO DE PROTOCOLO propriamente dito -
164: *   GetDigitos.Valid, GetDigitos.GotFocus, GetParcela.LostFocus,
165: *   GetCartao.GotFocus, GetCodSeg.LostFocus e Text1.Valid. Esses seis sao
166: *   SEIS VARIANTES do mesmo dialogo com a DLL: todos leem e escrevem o
167: *   MESMO estado (ProximoComando/TipoCampo/TamanhoMinimo/TamanhoMaximo/
168: *   Buffer/lnContinua, variaveis PUBLIC no legado e properties do BO aqui),
169: *   e todos terminam chamando MontaRetorno/RetornoFalha/ErroTef. Fragmentar
170: *   esse laco produziria pedaco de maquina de estado que nao faz nada
171: *   sozinho - o "stub disfarcado" que a regra de completude proibe. Por
172: *   isso cada metodo entregue ABAIXO eh um metodo COMPLETO do legado, e os
173: *   seis acima ficam inteiros para as fases 7-8.
174: *
175: *   DOIS DETALHES DE SEMANTICA, medidos no dump e nao adivinhados:
176: *
177: *   (a) "When" por BINDEVENT nao BLOQUEIA foco - o retorno do delegate eh
178: *       descartado (CLAUDE.md regra #3/#47). Entao cada When do legado foi
179: *       separado em duas partes: o EFEITO COLATERAL (SET CONFIRM OFF,
180: *       INKEY/CLEAR TYPEAHEAD/KEYBOARD) vai num handler ligado ao proprio
181: *       evento "When", que dispara normalmente; o VALOR DE RETORNO (gate de
182: *       foco) vira estado de controle em AplicarGatesDeFoco(). Nos tres
183: *       campos cujo When devolve EMPTY(This.Value) - GetDigitos, GetCodSeg -
184: *       o proprio legado JA fecha o campo por Enabled depois de usa-lo
185: *       ("ThisForm.GetDigitos.Enabled=.f." no fim do GetDigitos.Valid), ou
186: *       seja o gate do When eh redundante com o Enabled e nao se perde nada;
187: *       no GetValor, cujo When devolve .F. SEMPRE, o gate eh reproduzido com
188: *       ReadOnly + TabStop (ver AplicarGatesDeFoco).
189: *
190: *   (b) "Valid" por BINDEVENT nao dispara em TextBox (CLAUDE.md regra #3).
191: *       Os dois Valid independentes do laco (GetParcela e GetCartao) foram
192: *       implementados como FUNCTION ValidarParcela()/ValidarCartao() e
193: *       acionados pelo KeyPress testando ENTER(13)/TAB(9) no TOPO do
194: *       handler, que eh o recorte dos irmaos desta familia. Isto NAO
195: *       contraria a regra #47 ("lookup NUNCA em KeyPress"): la o defeito eh
196: *       abrir um PICKER a cada tecla; aqui nao ha picker, o handler testa a
197: *       tecla antes de qualquer coisa e nenhuma janela eh aberta.
198: *
199: * FASE 7/8 - Eventos Principais (o Click do UNICO botao da tela)
200: *   Os quatro handlers que o template desta fase pede - um Btn<verbo>Click
201: *   para cada verbo da barra CRUD (incluir, alterar, visualizar e excluir) -
202: *   sao convencao de form CRUD (a barra de acao da Page1 de Lista do
203: *   frmcadastro). Este form NAO tem CRUD algum e isso foi MEDIDO no dump, nao
204: *   presumido: a raiz do SCX eh "Class: form"/"BaseClass: form" (nao
205: *   frmcadastro), nao ha Page nem Grid, e a UNICA superficie de botao da tela
206: *   eh o CommandGroup SAIDA com ButtonCount = 1 (SAIDA.CANCELA, Caption
207: *   "\<Cancelar"). Nao existe botao de gravar, de incluir nem de excluir -
208: *   esta tela nao mantem registro proprio, ela conversa com o PIN-pad.
209: *   Gerar os quatro nomes aqui obrigaria a INVENTAR quatro botoes que o
210: *   legado nao tem (viola o PILAR 1 e a regra "NUNCA inventar") ou a criar
211: *   quatro metodos vazios (proibido pela regra de completude). Mesmo recorte
212: *   das Fases 3, 4, 5 e 6 deste arquivo e do irmao Formsigopdtf.prg
213: *   (task725), cujo SCX tambem tem um unico botao Cancelar.
214: *
215: *   O que ENTRA nesta fase eh o evento de botao que o legado DE FATO tem,
216: *   transcrito integral, mais o funil de fechamento que ele exige:
217: *     BtnCancelarClick ... SIGOPTEF.SAIDA.CANCELA.Click (3 linhas do dump,
218: *                          linhas 937-943: aborta o protocolo com -1, grava o
219: *                          arquivo de resposta de falha e fecha a tela)
220: *     EncerrarDialogo .... ponto UNICO de saida, no lugar do "RELEASE
221: *                          WINDOWS" do legado (23 ocorrencias no dump)
222: *     QueryUnload ........ a segunda metade do contrato de Hide() (ver nota
223: *                          no proprio metodo): sem ela o Alt+F4 DESTROI o
224: *                          form e o Release() do chamador estoura
225: *   mais o BINDEVENT do Click em RegistrarEventosCampos() e a troca, no
226: *   KeyPress do form, da chamada indireta por THIS.BtnCancelarClick().
227: *
228: *   POR QUE Hide() E NAO Release(): o legado fecha com "RELEASE WINDOWS" e
229: *   devolve o resultado da transacao pelo RETURN do evento Unload, que so
230: *   chega a quem abre com "DO FORM <form> TO <var>". No sistema novo o
231: *   chamador abre por CREATEOBJECT + Show() e le PROPERTY do form - e em VFP9
232: *   o Release() destroi o objeto mesmo havendo referencia externa viva, o que
233: *   deixaria esta tela SEM COMO devolver a autorizacao ao PDV (o sintoma
234: *   apareceria no CHAMADOR, como "is not an object", longe da causa). Entao o
235: *   fechamento eh Hide() e quem abriu chama Release() depois de ler - mesmo
236: *   contrato que o classes\formbuscaauxiliar.prg ja adota. Para o operador a
237: *   tela fecha igual (Hide() em form modal tambem devolve o Show()): muda so
238: *   o tempo de vida do objeto, que eh PILAR 3.
239: *
240: *   ESCOPO QUE RESTA PARA A FASE 8: o LACO DE PROTOCOLO (GetDigitos.Valid,
241: *   GetDigitos.GotFocus, GetParcela.LostFocus, GetCartao.GotFocus,
242: *   GetCodSeg.LostFocus e Text1.Valid - as seis variantes do mesmo dialogo
243: *   com a DLL, que compartilham o estado do BO) e o Unload, isto eh o valor
244: *   devolvido ao PDV ("0,00/" + lnParcs + "/" + data + bandeira + cartao).
245: *   Quando o Unload entrar, o calculo desse retorno tem de ser CACHEADO
246: *   DENTRO de EncerrarDialogo(), ANTES do Hide() - o Destroy roda tarde
247: *   demais para quem le a property logo depois do Show() (ver a nota no
248: *   proprio EncerrarDialogo).
249: *==============================================================================
250: 
251: DEFINE CLASS Formsigoptef AS FormBase
252: 
253:     *==========================================================================
254:     * Propriedades visuais - PILAR 1, transcritas do dump do SCX legado
255:     *   Height=370 Width=500 AutoCenter=.T. BorderStyle=2 Caption=""
256:     *   ControlBox=.F. Closable=.T. MaxButton=.F. MinButton=.F.
257:     *   ClipControls=.T. KeyPreview=.T. TitleBar=0 WindowType=1
258:     *   WindowState=0 AlwaysOnTop=.T.
259:     *
260:     * DataSession = 1 (sessao default/compartilhada): os cursores abertos
261:     * pelo BO (cursor_4c_SigOpFp/cursor_4c_SigCdEmp) e, nas proximas fases,
262:     * os cursores lidos pelos handlers de interacao com o SiTef, precisam
263:     * estar visiveis para o form inteiro - o legado tambem nunca declara
264:     * DataSession = 2 para este form.
265:     *
266:     * ShowWindow = 1 ("as top-level form"): o dialogo e exibido POR CIMA da
267:     * tela de venda que o chama, mesma convencao do Formsigopsen.prg.
268:     *==========================================================================
269:     this_cMensagemErro = ""
270:     DataSession  = 1
271:     ShowWindow   = 1
272:     Height       = 370
273:     Width        = 500
274:     AutoCenter   = .T.
275:     BorderStyle  = 2
276:     Caption      = ""

*-- Linhas 289 a 332:
289:     *-- " - Nao Magnetico" ao Caption e, na linha seguinte, SOBRESCREVE com
290:     *-- este literal - a concatenacao nunca fica visivel (dead code do
291:     *-- legado). FormBase.Init() aplica este valor a THIS.Caption antes de
292:     *-- chamar InicializarForm(), por isso os labels do cabecalho podem ler
293:     *-- THIS.Caption com seguranca.
294:     this_cTituloForm = "SiTef - Cart" + CHR(227) + "o de Cr" + CHR(233) + "dito"
295: 
296:     *==========================================================================
297:     * Entrada recebida do chamador (equivalente ao PARAMETERS do Init legado:
298:     * EndSiTef, ValPago, Cupom, Caixa, DebCred, TipPagto, NumParcs, lcIdent,
299:     * pcOpers). Espelham, por nome, as properties de sigoptefBO.prg, para onde
300:     * sao repassadas em ConfigurarParametrosBO().
301:     *==========================================================================
302:     this_cEndSiTef = ""        && Endereco/IP do servidor SiTef
303:     this_nValPago  = 0         && Valor a ser pago na transacao
304:     this_cCupom    = ""        && Numero do cupom fiscal
305:     this_cCaixa    = ""        && Identificacao do caixa (PDV)
306:     this_cDebCred  = ""        && "D"/"C"/"O" - Debito/Credito/Outro
307:     this_cTipPagto = ""        && Tipo de pagamento (ex.: "E" = especie)
308:     this_nNumParcs = 0         && Numero de parcelas
309:     this_cIdent    = ""        && Identificador unico da transacao (ltIdent)
310:     this_cOpers    = ""        && Codigo da forma de pagamento (SigOpFp.fpags)
311: 
312:     *==========================================================================
313:     * Estado manipulado pelos handlers de interacao com o SiTef (fases 7-8).
314:     * Declarados agora porque sao propriedades do FORM referenciadas direto
315:     * como ThisForm.<x> por varios metodos do legado.
316:     *
317:     * this_cBandeira       - pcBandeira do legado (TipoCampo=132 no buffer da
318:     *                        DLL): bandeira do cartao retornada pelo SiTef.
319:     * this_cCodCartaoSiTef - lsCartao do legado (TipoCampo=131): codigo lido
320:     *                        do buffer da DLL, comparado mais adiante com o
321:     *                        literal "00125" para decidir a logica de parcelas.
322:     * this_lPermiteEsc     - pcKeyEsc do legado: habilita o ESC do KeyPress do
323:     *                        form a disparar o Click do botao Cancelar.
324:     *==========================================================================
325:     this_cBandeira       = ""
326:     this_cCodCartaoSiTef = ""
327:     this_lPermiteEsc     = .T.
328: 
329:     *-- pcRede do legado: terceira property customizada que o SCX declara
330:     *-- (SECAO 2 do dump: pcbandeira / pcopers / pcrede), ao lado das duas ja
331:     *-- espelhadas acima. Declarada por FIDELIDADE: nenhum dos 27 metodos do
332:     *-- dump a le ou escreve - era a rede adquirente da transacao, abandonada

*-- Linhas 366 a 417:
366: 
367:     *--------------------------------------------------------------------------
368:     * Init - Recebe os parametros da transacao TEF e guarda em properties
369:     * ANTES de chamar DODEFAULT() - FormBase.Init() chama THIS.InicializarForm()
370:     * internamente, e e la que o BO precisa desses valores para resolver a
371:     * forma de pagamento (SigOpFp) e a empresa (SigCdEmp).
372:     *
373:     * NENHUM parametro eh obrigatorio: parametro ausente mantem o default
374:     * declarado acima - Init que recusa instanciacao por falta de parametro
375:     * reprova o harness de teste (que instancia sem argumento).
376:     *--------------------------------------------------------------------------
377:     PROCEDURE Init(par_cEndSiTef, par_nValPago, par_cCupom, par_cCaixa, ;
378:                     par_cDebCred, par_cTipPagto, par_nNumParcs, ;
379:                     par_cIdent, par_cOpers)
380:         LOCAL loc_lSucesso
381: 
382:         IF PCOUNT() >= 1 AND VARTYPE(par_cEndSiTef) = "C"
383:             THIS.this_cEndSiTef = ALLTRIM(par_cEndSiTef)
384:         ENDIF
385: 
386:         IF PCOUNT() >= 2 AND VARTYPE(par_nValPago) = "N"
387:             THIS.this_nValPago = par_nValPago
388:         ENDIF
389: 
390:         IF PCOUNT() >= 3 AND VARTYPE(par_cCupom) = "C"
391:             THIS.this_cCupom = par_cCupom
392:         ENDIF
393: 
394:         IF PCOUNT() >= 4 AND VARTYPE(par_cCaixa) = "C"
395:             THIS.this_cCaixa = par_cCaixa
396:         ENDIF
397: 
398:         IF PCOUNT() >= 5 AND VARTYPE(par_cDebCred) = "C"
399:             THIS.this_cDebCred = par_cDebCred
400:         ENDIF
401: 
402:         IF PCOUNT() >= 6 AND VARTYPE(par_cTipPagto) = "C"
403:             THIS.this_cTipPagto = par_cTipPagto
404:         ENDIF
405: 
406:         IF PCOUNT() >= 7 AND VARTYPE(par_nNumParcs) = "N"
407:             THIS.this_nNumParcs = par_nNumParcs
408:         ENDIF
409: 
410:         IF PCOUNT() >= 8 AND VARTYPE(par_cIdent) = "C"
411:             THIS.this_cIdent = par_cIdent
412:         ENDIF
413: 
414:         *-- Legado: ThisForm.pcOpers = pcOpers
415:         IF PCOUNT() >= 9 AND VARTYPE(par_cOpers) = "C"
416:             THIS.this_cOpers = ALLTRIM(par_cOpers)
417:         ENDIF

*-- Linhas 431 a 615:
431: 
432:     *--------------------------------------------------------------------------
433:     * ValidarParametros - Guarda de conexao do Init legado:
434:     *     .poDatamgr = CreateObject("fSqlConector",ThisForm.Name)
435:     *     If Not .poDatamgr.pnIdconn>0
436:     *         DO Form SigTfDss With "Erro de Conexao", ... "Impossivel
437:     *             Efetuar Conexao com Servidor de Banco de Dados.", ...
438:     *         Return(.f.)
439:     *     Endif
440:     *
441:     * No sistema novo o equivalente de pnIdconn eh o handle global
442:     * gnConnHandle. Bypass para gb_4c_ModoTeste/gb_4c_ValidandoUI, que
443:     * definem gnConnHandle de proposito sem servidor acessivel - sem o
444:     * bypass a tela reprovaria sempre no teste de instanciacao.
445:     *
446:     * PUBLIC (sem PROTECTED): alcancavel pelo harness de teste.
447:     *--------------------------------------------------------------------------
448:     PROCEDURE ValidarParametros()
449:         LOCAL loc_lValido
450: 
451:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
452:             RETURN .T.
453:         ENDIF
454: 
455:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
456:             RETURN .T.
457:         ENDIF
458: 
459:         loc_lValido = .T.
460: 
461:         DO CASE
462:             CASE TYPE("gnConnHandle") != "N"
463:                 loc_lValido = .F.
464:             CASE gnConnHandle <= 0
465:                 loc_lValido = .F.
466:         ENDCASE
467: 
468:         IF !loc_lValido
469:             THIS.this_cMensagemErro = "Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
470:                 "o com Servidor de Banco de Dados."
471:             MsgErro(THIS.this_cMensagemErro, "Erro de Conex" + CHR(227) + "o")
472:         ENDIF
473: 
474:         RETURN loc_lValido
475:     ENDPROC
476: 
477:     *--------------------------------------------------------------------------
478:     * InicializarForm - Hook chamado por FormBase.Init(). Monta a estrutura
479:     * base: conexao, objeto de negocio, carga dos parametros da forma de
480:     * pagamento e os containers do layout legado.
481:     *
482:     * ConfigurarCabecalho() vem ANTES de qualquer outro AddObject (CLAUDE.md
483:     * regra #11 - ver nota de ordem no cabecalho deste arquivo).
484:     *
485:     * O RETURN da guarda fica FORA do TRY (nunca RETURN dentro de TRY/CATCH).
486:     *--------------------------------------------------------------------------
487:     PROTECTED PROCEDURE InicializarForm()
488:         LOCAL loc_lSucesso, loc_oErro
489: 
490:         IF !THIS.ValidarParametros()
491:             RETURN .F.
492:         ENDIF
493: 
494:         loc_lSucesso = .F.
495: 
496:         TRY
497:             THIS.this_oBusinessObject = CREATEOBJECT("sigoptefBO")
498: 
499:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
500:                 THIS.ConfigurarParametrosBO()
501: 
502:                 IF THIS.CarregarParametrosPagamento()
503:                     *-- Faixa cinza do titulo: PRIMEIRO AddObject da tela
504:                     THIS.ConfigurarCabecalho()
505: 
506:                     *-- Container da mensagem de instrucao ao operador
507:                     THIS.ConfigurarContainerMensagem()
508: 
509:                     *-- FASE 4/8: campos de captura, botao de saida e ordem
510:                     *-- de tabulacao (ver nota "FASE 4/8" no cabecalho)
511:                     THIS.ConfigurarCampos()
512:                     THIS.ConfigurarBotaoSaida()
513:                     THIS.ConfigurarOrdemTabulacao()
514: 
515:                     THIS.TornarControlesVisiveis(THIS)
516: 
517:                     *-- FASE 6/8: gates de foco que o legado expressa no
518:                     *-- retorno dos eventos When, e os BINDEVENT dos eventos
519:                     *-- de campo. Depois de TornarControlesVisiveis porque
520:                     *-- BINDEVENT em objeto inexistente estoura no proprio
521:                     *-- bind - aqui os controles ja existem.
522:                     THIS.AplicarGatesDeFoco()
523:                     THIS.RegistrarEventosCampos()
524: 
525:                     *-- Captions que o Init legado resolve a partir de
526:                     *-- crSigOpFp.lCartao
527:                     THIS.AtualizarTextosDaTela()
528: 
529:                     loc_lSucesso = .T.
530:                 ENDIF
531:             ELSE
532:                 THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
533:                     "vel criar o objeto de neg" + CHR(243) + "cio sigoptefBO"
534:                 MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
535:             ENDIF
536:         CATCH TO loc_oErro
537:             THIS.this_cMensagemErro = loc_oErro.Message
538:             MsgErro(loc_oErro.Message + CHR(13) + ;
539:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
540:                 "Procedure: " + loc_oErro.Procedure, ;
541:                 "Erro ao inicializar Formsigoptef")
542:         ENDTRY
543: 
544:         RETURN loc_lSucesso
545:     ENDPROC
546: 
547:     *--------------------------------------------------------------------------
548:     * ConfigurarCabecalho - Cria a faixa cinza do titulo.
549:     *
550:     * Legado: SIGOPTEF.cntSombra (Top=0 Left=0 Width=800 Height=80
551:     * BorderWidth=0 BackColor=100,100,100) com dois labels sobrepostos
552:     * (lblSombra preto em Top=18, lblTitulo branco em Top=17, ambos Tahoma 18
553:     * bold, BackStyle=0, Left=10, Width=769).
554:     *
555:     * Width do container e dos labels: THIS.Width / THIS.Width - 20 em vez dos
556:     * literais 800 / 769 do dump. O SCX declara o container 300px MAIS LARGO
557:     * que a propria janela (form Width=500) - artefato do Form Designer ja
558:     * catalogado (licao "cabecalho_label_width_dump_maior_que_form"): aplicar
559:     * o literal 769 jogaria o label quase 300px alem da borda direita, e o
560:     * titulo seria RECORTADO no meio (regra #30). Left=10 + (THIS.Width - 20)
561:     * mantem o texto inteiro dentro da faixa.
562:     *
563:     * Caption: THIS.Caption (ja resolvido por FormBase.Init a partir de
564:     * this_cTituloForm, "SiTef - Cartao de Credito"). O dump traz "Cadastro de
565:     * Testes" nos dois labels - literal remanescente do template de onde o SCX
566:     * foi copiado, enquanto o Init legado atribui o titulo real ao Caption do
567:     * form. Como o form tem TitleBar = 0, esta faixa eh o UNICO lugar onde o
568:     * operador le o titulo da tela; usar THIS.Caption eh tambem o padrao
569:     * canonico do sistema novo (CLAUDE.md regra #11).
570:     *
571:     * AutoSize = .F. explicito nos dois labels: em Label criado por AddObject
572:     * o AutoSize eh no-op e, com WordWrap = .T., ele DESCARTA a Height
573:     * (regra #23) - a Height do dump (40 / 46) so eh respeitada com .F.
574:     *--------------------------------------------------------------------------
575:     PROTECTED PROCEDURE ConfigurarCabecalho()
576:         *-- Container cinza do cabecalho (cntSombra do legado)
577:         THIS.AddObject("cnt_4c_Sombra", "Container")
578:         WITH THIS.cnt_4c_Sombra
579:             .Top         = 0
580:             .Left        = 0
581:             .Width       = THIS.Width
582:             .Height      = 80
583:             .BorderWidth = 0
584:             .BackStyle   = 1
585:             .BackColor   = RGB(100, 100, 100)
586:             .Visible     = .T.
587:         ENDWITH
588: 
589:         *-- Label de sombra, preto, 1px abaixo do titulo (lblSombra do legado)
590:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
591:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
592:             .AutoSize      = .F.
593:             .FontBold      = .T.
594:             .FontName      = "Tahoma"
595:             .FontSize      = 18
596:             .FontUnderline = .F.
597:             .WordWrap      = .T.
598:             .Alignment     = 0
599:             .BackStyle     = 0
600:             .Caption       = THIS.Caption
601:             .Height        = 40
602:             .Left          = 10
603:             .Top           = 18
604:             .Width         = THIS.Width - 20
605:             .ForeColor     = RGB(0, 0, 0)
606:             .Visible       = .T.
607:         ENDWITH
608: 
609:         *-- Label do titulo, branco sobre o cinza (lblTitulo do legado)
610:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
611:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
612:             .AutoSize    = .F.
613:             .FontBold    = .T.
614:             .FontName    = "Tahoma"
615:             .FontSize    = 18

*-- Linhas 639 a 752:
639:     *
640:     * Container VISIVEL desde o inicio - nao eh painel flutuante: o legado
641:     * declara Visible = .T. e nenhum metodo o esconde. Por isso ele NAO entra
642:     * em lista de excecao do TornarControlesVisiveis.
643:     *
644:     * O Caption em runtime vem do BO (ver BOParaForm): o Init legado o troca
645:     * por "Insira ou Passe"+CHR(13)+"o Cartao" ou "Digite o Numero"+CHR(13)+
646:     * "do Cartao" conforme crSigOpFp.lCartao.
647:     *
648:     * Geometria transcrita literal do SCX (regra #23: Width E Height do dump,
649:     * com AutoSize = .F. explicito). O legado nao declara WordWrap neste label
650:     * (default .F.), nem AutoSize - a Height 31 eh a que o Form Designer
651:     * calculou para o Caption de design, de uma linha.
652:     *--------------------------------------------------------------------------
653:     PROTECTED PROCEDURE ConfigurarContainerMensagem()
654:         *-- Container da mensagem (Container1 do legado)
655:         THIS.AddObject("cnt_4c_Container1", "Container")
656:         WITH THIS.cnt_4c_Container1
657:             .Top           = 300
658:             .Left          = 47
659:             .Width         = 392
660:             .Height        = 58
661:             .SpecialEffect = 0
662:             .Visible       = .T.
663:         ENDWITH
664: 
665:         *-- Label da mensagem (Container1.Label1 do legado)
666:         THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
667:         WITH THIS.cnt_4c_Container1.lbl_4c_Label1
668:             .AutoSize  = .F.
669:             .FontBold  = .T.
670:             .FontName  = "Tahoma"
671:             .FontSize  = 18
672:             .Alignment = 2
673:             .BackStyle = 0
674:             .Caption   = "Insira ou Passe o Cartao"
675:             .Height    = 31
676:             .Left      = 4
677:             .Top       = 13
678:             .Width     = 384
679:             .ForeColor = RGB(90, 90, 90)
680:             .Visible   = .T.
681:         ENDWITH
682: 
683:         RETURN
684:     ENDPROC
685: 
686:     *--------------------------------------------------------------------------
687:     * ConfigurarCampos - FASE 4/8. Cria os campos de captura e os elementos
688:     * decorativos que pendem DIRETO na Form (sem PageFrame - Top/Left
689:     * transcritos EXATOS do dump sigoptef_form_codigo_fonte.txt, sem
690:     * compensacao +29 porque este form nao tem PageFrame.Top=-29).
691:     *
692:     * Migrado de: SIGOPTEF.Shape2/Label5/GetValor/Label2/GetDigitos/Label7/
693:     * GetParcela/Label8/Label9/Label10/GetCartao/GetCodSeg/Label12/Label1
694:     * ("0 - Inexistente")/Label3("1 - Ilegivel")/Label6/Text1/Timer1.
695:     *
696:     * So PROPRIEDADES VISUAIS nesta fase - nenhum BINDEVENT de evento de
697:     * campo aqui. Os eventos de protocolo com a DLL SiTef (When/Valid/
698:     * GotFocus/LostFocus de GetValor/GetDigitos/GetParcela/GetCartao/
699:     * GetCodSeg/Text1 e o Timer1.Procedure) ficam para as fases seguintes
700:     * (6-8), junto com a DECLARE DLL (regra CLAUDE.md "DECLARE DLL carrega
701:     * na hora e mata o form" - so pode entrar num Load protegido).
702:     *
703:     * Shape2 eh criado PRIMEIRO neste metodo: eh o pano de fundo decorativo
704:     * sob os labels/campos (Top=93..295) - regra #28/#30, filho criado
705:     * depois desenha por cima.
706:     *
707:     * Regra #23 aplicada em TODOS os labels: o dump declara AutoSize = .T.
708:     * (classe say pura), mas AutoSize eh no-op em Label criado por AddObject
709:     * - transcrito como .AutoSize = .F. com o Width/Height que o Form
710:     * Designer ja calculou.
711:     *--------------------------------------------------------------------------
712:     PROTECTED PROCEDURE ConfigurarCampos()
713:         *-- Shape2 - moldura decorativa ao redor dos campos de captura
714:         THIS.AddObject("shp_4c_Shape2", "Shape")
715:         WITH THIS.shp_4c_Shape2
716:             .Top           = 93
717:             .Left          = 17
718:             .Width         = 466
719:             .Height        = 202
720:             .SpecialEffect = 0
721:         ENDWITH
722: 
723:         *-- Label5 "VALOR :" + txt_4c_Valor (GetValor)
724:         THIS.AddObject("lbl_4c_Label5", "Label")
725:         WITH THIS.lbl_4c_Label5
726:             .AutoSize   = .F.
727:             .Alignment  = 0
728:             .Top        = 114
729:             .Left       = 116
730:             .Width      = 45
731:             .Height     = 15
732:             .FontName   = "Tahoma"
733:             .FontSize   = 8
734:             .FontBold   = .T.
735:             .FontItalic = .F.
736:             .ForeColor  = RGB(90, 90, 90)
737:             .BackStyle  = 0
738:             .Caption    = "VALOR :"
739:         ENDWITH
740: 
741:         *-- GetValor.When = "Return .f." no legado (bloqueia foco - campo so
742:         *-- de exibicao). ReadOnly/TabStop ficam para a fase que porta os
743:         *-- valores iniciais (equivalente ao final do Init legado).
744:         THIS.AddObject("txt_4c_Valor", "TextBox")
745:         WITH THIS.txt_4c_Valor
746:             .Top               = 111
747:             .Left              = 163
748:             .Width             = 100
749:             .Height            = 23
750:             .Alignment         = 3
751:             .Value             = 0
752:             .InputMask         = "99,999,999.99"

*-- Linhas 1030 a 1079:
1030:     * template do Form Designer (o grupo tem 1 unico botao, nao ha o que
1031:     * refletir).
1032:     *
1033:     * O Click (BINDEVENT) fica para a fase que entrega os eventos de botao
1034:     * (6-8): o CANCELA.Click do legado chama ContinuaFuncaoSiTefInterativo
1035:     * (precisa da DECLARE DLL + do estado do protocolo, nenhum dos dois
1036:     * existe ainda) e ThisForm.RetornoFalha (metodo que tambem ainda nao
1037:     * existe) - amarrar o Click agora criaria um handler incompleto.
1038:     *--------------------------------------------------------------------------
1039:     PROTECTED PROCEDURE ConfigurarBotaoSaida()
1040:         THIS.AddObject("cmg_4c_Saida", "CommandGroup")
1041:         WITH THIS.cmg_4c_Saida
1042:             .AutoSize    = .T.
1043:             .ButtonCount = 1
1044:             .Top         = -2
1045:             .Left        = 420
1046:             .Width       = 85
1047:             .Height      = 85
1048:             .BorderStyle = 0
1049:             *-- SCX legado: SAIDA.BackStyle = 0 (transparente). CommandGroup
1050:             *-- TEM BackStyle - sem esta linha o grupo nasce opaco e pinta
1051:             *-- retangulo branco sobre a faixa cinza do cabecalho.
1052:             .BackStyle   = 0
1053:             .Value       = 0
1054: 
1055:             WITH .Buttons(1)
1056:                 .Top        = 5
1057:                 .Left       = 5
1058:                 .Width      = 75
1059:                 .Height     = 75
1060:                 .FontName   = "Comic Sans MS"
1061:                 .FontSize   = 8
1062:                 .FontBold   = .T.
1063:                 .FontItalic = .T.
1064:                 .Cancel     = .F.
1065:                 .Caption    = "\<Cancelar"
1066:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1067:                 .ForeColor  = RGB(90, 90, 90)
1068:                 .BackColor  = RGB(255, 255, 255)
1069:                 .Themes     = .F.
1070:             ENDWITH
1071:         ENDWITH
1072: 
1073:         RETURN
1074:     ENDPROC
1075: 
1076:     *--------------------------------------------------------------------------
1077:     * ConfigurarOrdemTabulacao - FASE 4/8. Reproduz a ordem relativa de
1078:     * tabulacao do SCX legado entre os controles tab-stoppable (TextBox/
1079:     * CommandGroup - Label nao tem TabStop e por isso nao entra aqui).

*-- Linhas 1085 a 1230:
1085:     * resolve o empate: valor exibido primeiro, cartao digitado/passado em
1086:     * seguida).
1087:     *--------------------------------------------------------------------------
1088:     PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
1089:         THIS.txt_4c_Valor.TabIndex   = 1    && SCX: GetValor    TabIndex=1
1090:         THIS.txt_4c_Cartao.TabIndex  = 2    && SCX: GetCartao   TabIndex=1
1091:         THIS.txt_4c_Digitos.TabIndex = 3    && SCX: GetDigitos  TabIndex=2
1092:         THIS.txt_4c_Codigo.TabIndex  = 4    && SCX: GetCodSeg   TabIndex=3
1093:         THIS.txt_4c_Parcela.TabIndex = 5    && SCX: GetParcela  TabIndex=7
1094:         THIS.txt_4c_Text1.TabIndex   = 6    && SCX: Text1       TabIndex=8
1095:         THIS.cmg_4c_Saida.TabIndex   = 7    && SCX: SAIDA       TabIndex=9
1096: 
1097:         RETURN
1098:     ENDPROC
1099: 
1100:     *--------------------------------------------------------------------------
1101:     * ConfigurarParametrosBO - Repassa ao BO o que o chamador informou no
1102:     * Init. Nomes das properties sao os declarados em sigoptefBO.prg.
1103:     *--------------------------------------------------------------------------
1104:     PROTECTED PROCEDURE ConfigurarParametrosBO()
1105:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1106:             RETURN
1107:         ENDIF
1108: 
1109:         WITH THIS.this_oBusinessObject
1110:             .this_cEndSiTef = THIS.this_cEndSiTef
1111:             .this_nValPago  = THIS.this_nValPago
1112:             .this_cCupom    = THIS.this_cCupom
1113:             .this_cCaixa    = THIS.this_cCaixa
1114:             .this_cDebCred  = THIS.this_cDebCred
1115:             .this_cTipPagto = THIS.this_cTipPagto
1116:             .this_nNumParcs = THIS.this_nNumParcs
1117:             .this_cIdent    = THIS.this_cIdent
1118:             .this_cOpers    = THIS.this_cOpers
1119:         ENDWITH
1120: 
1121:         RETURN
1122:     ENDPROC
1123: 
1124:     *--------------------------------------------------------------------------
1125:     * CarregarParametrosPagamento - Replica o bloco WITH ThisForm do Init
1126:     * legado (sigoptef_form_codigo_fonte.txt:866-892): busca a forma de
1127:     * pagamento (SigOpFp) e a empresa logada (SigCdEmp) atraves do BO.
1128:     *
1129:     * Em modo de teste / validacao de UI nao ha conexao (gnConnHandle = 0 de
1130:     * proposito) - a carga eh pulada, devolvendo .T. para a estrutura visual
1131:     * continuar sendo montada nesses modos.
1132:     *
1133:     * PUBLIC: ponto de recarga explicito, alcancavel pelo harness.
1134:     *--------------------------------------------------------------------------
1135:     PROCEDURE CarregarParametrosPagamento()
1136:         LOCAL loc_lSucesso
1137: 
1138:         IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
1139:                 (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
1140:             RETURN .T.
1141:         ENDIF
1142: 
1143:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1144:             RETURN .F.
1145:         ENDIF
1146: 
1147:         loc_lSucesso = THIS.this_oBusinessObject.BuscarParametrosPagamento()
1148: 
1149:         IF !loc_lSucesso
1150:             THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
1151:             MsgErro(THIS.this_cMensagemErro, "Forma de Pagamento")
1152:         ENDIF
1153: 
1154:         RETURN loc_lSucesso
1155:     ENDPROC
1156: 
1157:     *--------------------------------------------------------------------------
1158:     * AtualizarTextosDaTela - Transfere para a tela o que o BO resolveu. Nesta
1159:     * fase eh a mensagem de instrucao ao operador, que o Init legado decide a
1160:     * partir da forma de pagamento:
1161:     *
1162:     *     IF crSigOpFp.lCartao = "N"
1163:     *         ThisForm.Container1.Label1.Caption="Insira ou Passe"+CHR(13)+"o Cartao"
1164:     *     ELSE
1165:     *         ThisForm.Container1.Label1.Caption="Digite o Numero"+CHR(13)+"do Cartao"
1166:     *     ENDIF
1167:     *
1168:     * lCartao = "N" eh cartao MAGNETICO (o operador passa o cartao no leitor);
1169:     * qualquer outro valor eh digitacao manual do numero.
1170:     *
1171:     * Sem forma de pagamento carregada (modo de teste / validacao de UI, onde
1172:     * CarregarParametrosPagamento nao consulta o banco) a tela mantem o Caption
1173:     * de design do SCX, de uma linha - nao ha dado para escolher entre os dois
1174:     * textos, e escolher um deles mentiria sobre o meio de captura.
1175:     *
1176:     * Os labels do cabecalho sao reafirmados aqui para que uma troca de
1177:     * THIS.Caption pelo chamador tambem se reflita na faixa cinza - este eh o
1178:     * ponto de recarga unico da tela.
1179:     *
1180:     * O metodo se chama AtualizarTextosDaTela, e NAO BOParaForm, porque precisa
1181:     * ser alcancavel de FORA da classe (harness de teste, recarga pelo form
1182:     * chamador): FormBase declara PROTECTED PROCEDURE BOParaForm e o VFP9 NAO
1183:     * deixa a subclasse ALARGAR esse escopo - redeclarar sem PROTECTED nao
1184:     * publica nada, so esconde o fato. Medido neste form em 2026-11-18:
1185:     * loForm.BOParaForm() de um script solto estoura "Property BOPARAFORM is
1186:     * not found" (e, em vfp9.exe -T, pendura o processo num Program Error mudo).
1187:     * O hook BOParaForm fica logo abaixo, delegando - assim o caminho interno
1188:     * do FormBase continua funcionando.
1189:     *--------------------------------------------------------------------------
1190:     PROCEDURE AtualizarTextosDaTela()
1191:         LOCAL loc_cLCartao, loc_cMensagem
1192: 
1193:         *-- Faixa do titulo (os dois labels sobrepostos)
1194:         IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
1195:             IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_LblSombra", 5)
1196:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
1197:             ENDIF
1198: 
1199:             IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_LblTitulo", 5)
1200:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
1201:             ENDIF
1202:         ENDIF
1203: 
1204:         *-- Mensagem de instrucao ao operador
1205:         IF !PEMSTATUS(THIS, "cnt_4c_Container1", 5)
1206:             RETURN
1207:         ENDIF
1208: 
1209:         IF !PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Label1", 5)
1210:             RETURN
1211:         ENDIF
1212: 
1213:         loc_cLCartao = ""
1214: 
1215:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1216:             IF VARTYPE(THIS.this_oBusinessObject.this_cLCartao) = "C"
1217:                 loc_cLCartao = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cLCartao))
1218:             ENDIF
1219:         ENDIF
1220: 
1221:         DO CASE
1222:             CASE EMPTY(loc_cLCartao)
1223:                 *-- Caption de design do SCX, uma linha
1224:                 loc_cMensagem = "Insira ou Passe o Cartao"
1225:             CASE loc_cLCartao == "N"
1226:                 loc_cMensagem = "Insira ou Passe" + CHR(13) + "o Cartao"
1227:             OTHERWISE
1228:                 loc_cMensagem = "Digite o Numero" + CHR(13) + "do Cartao"
1229:         ENDCASE
1230: 

*-- Linhas 1252 a 1302:
1252:     * campo ja alterado pelo proprio laco.
1253:     *
1254:     * PROTECTED EXPLICITO: o escopo vem da HERANCA (FormBase declara PROTECTED
1255:     * PROCEDURE FormParaBO) e o VFP9 nao deixa a subclasse ALARGAR - omitir o
1256:     * modificador aqui mentiria para quem le. Todos os chamadores sao internos.
1257:     *
1258:     * Defensivo em TODO acesso: o hook tambem roda em modo de teste e de
1259:     * validacao de UI, onde o BO pode nao existir e os controles podem ainda
1260:     * nao ter sido criados por ConfigurarCampos().
1261:     *--------------------------------------------------------------------------
1262:     PROTECTED PROCEDURE FormParaBO()
1263:         LOCAL loc_oBO
1264: 
1265:         loc_oBO = THIS.this_oBusinessObject
1266: 
1267:         IF VARTYPE(loc_oBO) != "O"
1268:             RETURN
1269:         ENDIF
1270: 
1271:         loc_oBO.AplicarCamposDigitados( ;
1272:             THIS.LerCampoDaTela("txt_4c_Valor"), ;
1273:             THIS.LerCampoDaTela("txt_4c_Digitos"), ;
1274:             THIS.LerCampoDaTela("txt_4c_Parcela"), ;
1275:             THIS.LerCampoDaTela("txt_4c_Cartao"), ;
1276:             THIS.LerCampoDaTela("txt_4c_Codigo"), ;
1277:             THIS.LerCampoDaTela("txt_4c_Text1"))
1278: 
1279:         RETURN
1280:     ENDPROC
1281: 
1282:     *--------------------------------------------------------------------------
1283:     * LerCampoDaTela - devolve o .Value do TextBox pedido, ou "" quando o
1284:     * controle ainda nao existe (ConfigurarCampos nao rodou).
1285:     *
1286:     * O membro eh alcancado por EVALUATE, nunca por THIS.Controls(<nome>):
1287:     * Controls eh indexado por NUMERO e passar o NOME compila limpo mas
1288:     * estoura em runtime (regra #34). Leitura por nome montado eh justamente
1289:     * o que EVALUATE faz (regra #15 - STORE seria para ATRIBUIR).
1290:     *
1291:     * PROTECTED: so o FormParaBO acima consome.
1292:     *--------------------------------------------------------------------------
1293:     PROTECTED FUNCTION LerCampoDaTela(par_cControle)
1294:         IF VARTYPE(par_cControle) != "C" OR EMPTY(par_cControle)
1295:             RETURN ""
1296:         ENDIF
1297: 
1298:         IF !PEMSTATUS(THIS, par_cControle, 5)
1299:             RETURN ""
1300:         ENDIF
1301: 
1302:         IF EVALUATE("VARTYPE(THIS." + par_cControle + ")") != "O"

*-- Linhas 1309 a 2081:
1309:     *--------------------------------------------------------------------------
1310:     * BOParaForm - Hook que FormBase chama por THIS. nos fluxos de carga de
1311:     * registro. PROTECTED EXPLICITO: o escopo vem da HERANCA (FormBase declara
1312:     * PROTECTED PROCEDURE BOParaForm) e omitir o modificador aqui mentiria para
1313:     * quem le - o metodo continua protegido de qualquer jeito.
1314:     *
1315:     * Toda a logica mora em AtualizarTextosDaTela(), que eh publica e serve
1316:     * tanto a este hook quanto a uma recarga vinda de fora.
1317:     *--------------------------------------------------------------------------
1318:     PROTECTED PROCEDURE BOParaForm()
1319:         THIS.AtualizarTextosDaTela()
1320:     ENDPROC
1321: 
1322:     *--------------------------------------------------------------------------
1323:     * GravarRetornoFalha - FASE 5/8. Equivalente a PROCEDURE retornofalha do
1324:     * legado (sigoptef_form_codigo_fonte.txt:756-791). Escreve o arquivo de
1325:     * resposta ao PDV indicando falha/cancelamento da transacao TEF, no
1326:     * formato fixo SDF (linha "CAMPO-SEQ = VALOR") que a integracao espera.
1327:     *
1328:     * par_nValPago: numerico (legado as vezes passa a string literal "0,00"
1329:     * neste ponto - aqui o chamador passa 0 e o proprio metodo formata).
1330:     *
1331:     * PUBLIC: chamado pelos handlers de evento das fases 6-8 e pelo Click do
1332:     * botao Cancelar.
1333:     *--------------------------------------------------------------------------
1334:     PROCEDURE GravarRetornoFalha(par_cMensagem, par_nValPago)
1335:         LOCAL loc_cMensagem, loc_nValPago, loc_cValPago, loc_oErro, loc_lSucesso
1336: 
1337:         loc_lSucesso = .F.
1338: 
1339:         loc_cMensagem = IIF(VARTYPE(par_cMensagem) = "C" AND !EMPTY(par_cMensagem), ;
1340:             par_cMensagem, "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usu" + CHR(225) + "rio")
1341: 
1342:         loc_nValPago = IIF(VARTYPE(par_nValPago) = "N", par_nValPago, THIS.this_nValPago)
1343:         loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(loc_nValPago, "99999999999.99")), ".", ",")
1344: 
1345:         TRY
1346:             IF USED("cursor_4c_RespostaSiTef")
1347:                 USE IN cursor_4c_RespostaSiTef
1348:             ENDIF
1349: 
1350:             CREATE CURSOR cursor_4c_RespostaSiTef (Tef C(100))
1351: 
1352:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("000-000 = CRT")
1353:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
1354:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("002-000 = ")
1355:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
1356:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("004-000 = 0")
1357:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("009-000 = FF")
1358:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("010-000 = 05")
1359:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("028-000 = 0")
1360:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("030-000 = " + loc_cMensagem)
1361:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("150-000 = 00000000")
1362:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("999-999 = 0")
1363: 
1364:             SELECT cursor_4c_RespostaSiTef
1365:             COPY TO C:\client\Resp\IntPos.001 SDF
1366:             ZAP
1367: 
1368:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("000-000 = CRT")
1369:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
1370:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("999-999 = 0")
1371: 
1372:             COPY TO C:\client\Resp\IntPos.STS SDF
1373: 
1374:             USE IN cursor_4c_RespostaSiTef
1375: 
1376:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1377:                 THIS.this_oBusinessObject.RegistrarTransacaoTef("TEF_FALHA")
1378:             ENDIF
1379: 
1380:             loc_lSucesso = .T.
1381:         CATCH TO loc_oErro
1382:             IF USED("cursor_4c_RespostaSiTef")
1383:                 USE IN cursor_4c_RespostaSiTef
1384:             ENDIF
1385:             MsgErro(loc_oErro.Message + CHR(13) + ;
1386:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1387:                 "Procedure: " + loc_oErro.Procedure, ;
1388:                 "Erro ao gravar retorno SiTef")
1389:         ENDTRY
1390: 
1391:         RETURN loc_lSucesso
1392:     ENDPROC
1393: 
1394:     *--------------------------------------------------------------------------
1395:     * GravarRetornoAprovado - FASE 5/8. Equivalente a PROCEDURE montaretorno
1396:     * do legado (sigoptef_form_codigo_fonte.txt:674-751). Escreve o arquivo
1397:     * de resposta ao PDV com os dados da transacao TEF APROVADA.
1398:     *
1399:     * par_cCartaoCod: codigo numerico da bandeira (0..10) retornado pelo
1400:     * SiTef (TipoCampo=132, ThisForm.pcBandeira do legado / THIS.this_cBandeira
1401:     * nesta migracao) - indice de laCartao, 0-based no protocolo e 1-based no
1402:     * array local (por isso VAL(par_cCartaoCod) + 1 abaixo).
1403:     *
1404:     * par_cMenRet: equivalente a MenRet do legado (ultimo parametro de
1405:     * montaretorno, sempre recebido como lsMRet pelos call sites) - guarda de
1406:     * tipo preservada (legado tambem usa Type() antes de usar o valor).
1407:     *
1408:     * Campo "023-000" duplicado: o legado grava a mesma chave duas vezes
1409:     * (linhas 718 e 719 do dump) - a segunda sobrescreve a primeira no
1410:     * protocolo de resposta. Mantido literal (nao e bug a corrigir, regra
1411:     * "transcrever formula do legado, nunca reescrever").
1412:     *--------------------------------------------------------------------------
1413:     PROCEDURE GravarRetornoAprovado(par_cTipTran, par_cDataHora, par_cCupom, ;
1414:             par_cCartaoCod, par_cNsu, par_cAutoriza, par_cFinaliza, par_nValPago, par_cMenRet)
1415:         LOCAL loc_cValPago, loc_nValPago, loc_aCartao, loc_cCartaoCod, loc_cCupomRestante, ;
1416:             loc_nPos, loc_nLinha, loc_cLinhaCupom, loc_oErro, loc_lSucesso
1417: 
1418:         loc_lSucesso = .F.
1419: 
1420:         loc_nValPago = IIF(VARTYPE(par_nValPago) = "N", par_nValPago, THIS.this_nValPago)
1421:         loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(loc_nValPago, "99999999999.99")), ".", ",")
1422: 
1423:         *-- DECLARE laCartao[11] / laCartao[1]="Outro, nao definido" ... [11]="Fininvest"
1424:         DIMENSION loc_aCartao[11]
1425:         loc_aCartao[1]  = "Outro, n" + CHR(227) + "o definido"
1426:         loc_aCartao[2]  = "Visa"
1427:         loc_aCartao[3]  = "Mastercard"
1428:         loc_aCartao[4]  = "Diners"
1429:         loc_aCartao[5]  = "American Express"
1430:         loc_aCartao[6]  = "Sollo"
1431:         loc_aCartao[7]  = "Sidecard (Redecard)"
1432:         loc_aCartao[8]  = "Private Label (Redecard)"
1433:         loc_aCartao[9]  = "Redeshop"
1434:         loc_aCartao[10] = ""
1435:         loc_aCartao[11] = "Fininvest"
1436: 
1437:         loc_cCartaoCod = IIF(VARTYPE(par_cCartaoCod) = "C", par_cCartaoCod, "0")
1438:         IF VAL(loc_cCartaoCod) > 10 OR VAL(loc_cCartaoCod) < 0
1439:             loc_cCartaoCod = "0"
1440:         ENDIF
1441: 
1442:         TRY
1443:             IF USED("cursor_4c_RespostaSiTef")
1444:                 USE IN cursor_4c_RespostaSiTef
1445:             ENDIF
1446: 
1447:             CREATE CURSOR cursor_4c_RespostaSiTef (Tef C(100))
1448: 
1449:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("000-000 = CRT")
1450:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
1451:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("002-000 = ")
1452:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
1453:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("004-000 = 0")
1454:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("009-000 = 0")
1455:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(loc_cCartaoCod) + 1])
1456:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("011-000 = " + TratarNulo(par_cTipTran, ""))
1457:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("012-000 = " + TratarNulo(par_cNsu, ""))
1458:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("013-000 = " + TratarNulo(par_cAutoriza, ""))
1459:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("015-000 = " + SUBSTR(par_cDataHora, 7, 2) + ;
1460:                 SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 9, 6))
1461:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("017-000 = 0")
1462:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("018-000 = " + TratarNulo(THIS.txt_4c_Text1.Value, ""))
1463:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("017-000 = ")
1464:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("019-000 = ")
1465:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("020-000 = ")
1466:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("021-000 = 0")
1467:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("022-000 = " + SUBSTR(par_cDataHora, 7, 2) + ;
1468:                 SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 1, 4))
1469:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_cDataHora, 9, 6))
1470:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("023-000 = " + ;
1471:                 IIF(VARTYPE(par_cFinaliza) = "C", par_cFinaliza, ""))
1472:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_cDataHora, 9, 6))
1473: 
1474:             *-- DO WHILE lsPos<>0 / lsPos=AT(CHR(10),lsCupom) / ... quebra o
1475:             *-- cupom em linhas numeradas "029-NNN"
1476:             loc_cCupomRestante = TratarNulo(par_cCupom, "")
1477:             loc_nPos   = 1
1478:             loc_nLinha = 1
1479:             DO WHILE loc_nPos != 0
1480:                 loc_nPos = AT(CHR(10), loc_cCupomRestante)
1481:                 loc_cLinhaCupom = IIF(loc_nPos != 0, SUBSTR(loc_cCupomRestante, 1, loc_nPos - 1), loc_cCupomRestante)
1482:                 INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ( ;
1483:                     STRTRAN("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + loc_cLinhaCupom, CHR(0), " "))
1484:                 loc_cCupomRestante = SUBSTR(loc_cCupomRestante, loc_nPos + 1)
1485:                 loc_nLinha = loc_nLinha + 1
1486:             ENDDO
1487: 
1488:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
1489:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("030-000 = " + ;
1490:                 IIF(VARTYPE(par_cMenRet) = "C", par_cMenRet, ""))
1491:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("150-000 = 00000000")
1492:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("999-999 = 0")
1493: 
1494:             SELECT cursor_4c_RespostaSiTef
1495:             COPY TO C:\client\Resp\IntPos.001 SDF
1496:             ZAP
1497: 
1498:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("000-000 = CRT")
1499:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
1500:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("999-999 = 0")
1501: 
1502:             COPY TO C:\client\Resp\IntPos.STS SDF
1503: 
1504:             USE IN cursor_4c_RespostaSiTef
1505: 
1506:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1507:                 THIS.this_oBusinessObject.RegistrarTransacaoTef("TEF_APROVADO")
1508:             ENDIF
1509: 
1510:             loc_lSucesso = .T.
1511:         CATCH TO loc_oErro
1512:             IF USED("cursor_4c_RespostaSiTef")
1513:                 USE IN cursor_4c_RespostaSiTef
1514:             ENDIF
1515:             MsgErro(loc_oErro.Message + CHR(13) + ;
1516:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1517:                 "Procedure: " + loc_oErro.Procedure, ;
1518:                 "Erro ao gravar retorno SiTef")
1519:         ENDTRY
1520: 
1521:         RETURN loc_lSucesso
1522:     ENDPROC
1523: 
1524:     *--------------------------------------------------------------------------
1525:     * ProcessarErroTef - FASE 5/8. Equivalente a PROCEDURE errotef do legado
1526:     * (sigoptef_form_codigo_fonte.txt:646-671). Traduz o codigo de retorno
1527:     * negativo da DLL do SiTef para a mensagem de falha correspondente e
1528:     * delega a GravarRetornoFalha() (ver nota "Guarda ... FALLBACK" no
1529:     * cabecalho do arquivo sobre o branch OTHERWISE).
1530:     *--------------------------------------------------------------------------
1531:     PROCEDURE ProcessarErroTef(par_nRetornos)
1532:         LOCAL loc_cMensagem
1533: 
1534:         DO CASE
1535:             CASE par_nRetornos = -1
1536:                 loc_cMensagem = "M" + CHR(243) + "dulo N" + CHR(227) + "o Iniciado"
1537:             CASE par_nRetornos = -2
1538:                 loc_cMensagem = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio"
1539:             CASE par_nRetornos = -3
1540:                 loc_cMensagem = "Fornecida uma Modalidade Inv" + CHR(225) + "lida"
1541:             CASE par_nRetornos = -4
1542:                 loc_cMensagem = "Falta Mem" + CHR(243) + "ria para Rodar a Fun" + CHR(231) + CHR(227) + "o"
1543:             CASE par_nRetornos = -5
1544:                 loc_cMensagem = "Sem Comunica" + CHR(231) + CHR(227) + "o com o SiTef"
1545:             OTHERWISE
1546:                 loc_cMensagem = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio"
1547:         ENDCASE
1548: 
1549:         RETURN THIS.GravarRetornoFalha(loc_cMensagem, 0)
1550:     ENDPROC
1551: 
1552:     *==========================================================================
1553:     * EVENTOS DOS CAMPOS (FASE 6/8)
1554:     *
1555:     * Ver a nota "FASE 6/8" no cabecalho do arquivo para o recorte completo:
1556:     * aqui ficam os eventos do legado que NAO dependem do laco de protocolo
1557:     * com a CliSiTef32I.DLL, cada um transcrito INTEIRO do metodo legado
1558:     * correspondente. Os seis lacos de protocolo (GetDigitos.Valid/GotFocus,
1559:     * GetParcela.LostFocus, GetCartao.GotFocus, GetCodSeg.LostFocus e
1560:     * Text1.Valid) sao escopo das fases 7-8.
1561:     *==========================================================================
1562: 
1563:     *--------------------------------------------------------------------------
1564:     * AplicarGatesDeFoco - reproduz o VALOR DE RETORNO dos eventos When do
1565:     * legado, que BINDEVENT nao consegue reproduzir (o retorno do delegate eh
1566:     * descartado - CLAUDE.md regra #3/#47).
1567:     *
1568:     * Os quatro When do dump, e o que cada um devolve:
1569:     *
1570:     *   GetValor   "Return .f."                     -> NUNCA recebe foco
1571:     *   GetDigitos "Return(EMPTY(This.Value))"      -> so enquanto vazio
1572:     *   GetCodSeg  "Return(EMPTY(This.Value))"      -> so enquanto vazio
1573:     *   GetParcela "*Return(!INLIST(...))"          -> COMENTADO no dump
1574:     *
1575:     * GetParcela nao tem gate nenhum: a unica linha de retorno do When dele
1576:     * esta comentada com "*" no SCX (codigo desligado de proposito pelo
1577:     * legado), e When sem RETURN vale .T. em VFP9 - o campo recebe foco
1578:     * normalmente. Transcrito assim; "consertar" para a versao comentada
1579:     * mudaria comportamento.
1580:     *
1581:     * GetDigitos e GetCodSeg: o gate "so enquanto vazio" eh REDUNDANTE com o
1582:     * que o proprio legado faz por Enabled - o fim do GetDigitos.Valid tem
1583:     * "ThisForm.GetDigitos.Enabled=.f." e o laco liga/desliga GetCodSeg pelo
1584:     * Enabled tambem (ambos nas fases 7-8). Nao ha nada a aplicar aqui para
1585:     * esses dois, e por isso eles nao aparecem abaixo.
1586:     *
1587:     * GetValor eh o unico que precisa de gate permanente: o campo exibe o
1588:     * valor da transacao e o operador jamais o digita. ReadOnly + TabStop
1589:     * reproduz o efeito observavel do When = .F. (nao entra na tabulacao e
1590:     * nao aceita digitacao) SEM usar Enabled = .F., que pintaria o texto de
1591:     * cinza - o SCX declara DisabledForeColor = 0,0,0 justamente para o
1592:     * valor continuar legivel, e o legado nunca desabilita este campo.
1593:     *--------------------------------------------------------------------------
1594:     PROTECTED PROCEDURE AplicarGatesDeFoco()
1595:         *-- SIGOPTEF.GetValor.When: "Return .f."
1596:         THIS.txt_4c_Valor.ReadOnly = .T.
1597:         THIS.txt_4c_Valor.TabStop  = .F.
1598: 
1599:         RETURN
1600:     ENDPROC
1601: 
1602:     *--------------------------------------------------------------------------
1603:     * RegistrarEventosCampos - liga por BINDEVENT os eventos de campo desta
1604:     * fase. Chamado por InicializarForm DEPOIS de TornarControlesVisiveis,
1605:     * quando todos os controles ja existem (BINDEVENT para objeto inexistente
1606:     * estoura no proprio bind).
1607:     *
1608:     * Todos os metodos-alvo sao PUBLIC (sem PROTECTED): BINDEVENT so alcanca
1609:     * metodo publico, e com PROTECTED a falha eh SILENCIOSA - o handler
1610:     * simplesmente nunca roda (CLAUDE.md regra #3).
1611:     *
1612:     * "When" eh ligado de verdade aqui: o delegate DISPARA normalmente, so o
1613:     * retorno dele eh descartado - por isso os efeitos colaterais dos When do
1614:     * legado (SET CONFIRM OFF, INKEY/CLEAR TYPEAHEAD/KEYBOARD) ficam nestes
1615:     * handlers, e so o gate de foco foi para AplicarGatesDeFoco().
1616:     *
1617:     * Que o delegate de "When" DISPARA foi MEDIDO no VFP9, nao presumido
1618:     * (2026-11-18, automation\Probe809F6c.prg): com SET CONFIRM ON, acionar
1619:     * txt_4c_Digitos.When() com o campo vazio deixa SET("CONFIRM") = OFF, e
1620:     * o LostFocus devolve a ON. Medidos tambem os dois ramos do ParcelaWhen
1621:     * (valor "1" -> CONFIRM continua ON, ramo que enfileira TAB; vazio ->
1622:     * CONFIRM vai a OFF) e o caso em que o IF do legado NAO entra
1623:     * (txt_4c_Digitos com "1234" -> CONFIRM continua ON). Os binds em si
1624:     * foram medidos por AEVENTS com DOIS argumentos, evento na coluna 3
1625:     * (automation\Probe809F6.prg).
1626:     *
1627:     * "Valid" NAO eh ligado: BINDEVENT em Valid nao dispara em TextBox
1628:     * (regra #3). Os dois Valid independentes do laco viraram
1629:     * ValidarParcela()/ValidarCartao(), acionados pelo KeyPress com teste de
1630:     * ENTER(13)/TAB(9) no topo - as duas teclas que fazem o foco deixar o
1631:     * campo e que, no legado, disparariam o Valid.
1632:     *
1633:     * GetValor nao aparece: o When dele nao tem efeito colateral nenhum (so
1634:     * "Return .f."), ja coberto por AplicarGatesDeFoco().
1635:     *
1636:     * FASE 7/8: o Click do botao Cancelar passou a ser ligado aqui (primeiro
1637:     * bind do metodo, abaixo). Os eventos dos seis lacos de protocolo ficam
1638:     * para a Fase 8, junto com os handlers correspondentes.
1639:     *--------------------------------------------------------------------------
1640:     PROTECTED PROCEDURE RegistrarEventosCampos()
1641:         *-- SIGOPTEF.SAIDA.CANCELA.Click - o bind eh no BOTAO (Buttons(1)) e
1642:         *-- nao no CommandGroup: eh o Click do botao que o legado implementa,
1643:         *-- e o grupo tem ButtonCount = 1.
1644:         BINDEVENT(THIS.cmg_4c_Saida.Buttons(1), "Click", THIS, "BtnCancelarClick")
1645: 
1646:         *-- SIGOPTEF.GetDigitos.When / Valid (via KeyPress) / LostFocus / GotFocus
1647:         BINDEVENT(THIS.txt_4c_Digitos, "When",      THIS, "DigitosWhen")
1648:         BINDEVENT(THIS.txt_4c_Digitos, "KeyPress",  THIS, "DigitosKeyPress")
1649:         BINDEVENT(THIS.txt_4c_Digitos, "LostFocus", THIS, "DigitosLostFocus")
1650:         BINDEVENT(THIS.txt_4c_Digitos, "GotFocus",  THIS, "DigitosGotFocus")
1651: 
1652:         *-- SIGOPTEF.GetParcela.When / Valid (Valid via KeyPress) / LostFocus
1653:         BINDEVENT(THIS.txt_4c_Parcela, "When",      THIS, "ParcelaWhen")
1654:         BINDEVENT(THIS.txt_4c_Parcela, "KeyPress",  THIS, "ParcelaKeyPress")
1655:         BINDEVENT(THIS.txt_4c_Parcela, "LostFocus", THIS, "ParcelaLostFocus")
1656: 
1657:         *-- SIGOPTEF.GetCartao.Valid (via KeyPress) / GotFocus
1658:         BINDEVENT(THIS.txt_4c_Cartao, "KeyPress", THIS, "CartaoKeyPress")
1659:         BINDEVENT(THIS.txt_4c_Cartao, "GotFocus", THIS, "CartaoGotFocus")
1660: 
1661:         *-- SIGOPTEF.GetCodSeg.When / GotFocus / LostFocus
1662:         BINDEVENT(THIS.txt_4c_Codigo, "When",      THIS, "CodSegWhen")
1663:         BINDEVENT(THIS.txt_4c_Codigo, "GotFocus",  THIS, "CodSegGotFocus")
1664:         BINDEVENT(THIS.txt_4c_Codigo, "LostFocus", THIS, "CodSegLostFocus")
1665: 
1666:         *-- SIGOPTEF.Text1.When / Valid (via KeyPress) / LostFocus / GotFocus
1667:         BINDEVENT(THIS.txt_4c_Text1, "When",      THIS, "Text1When")
1668:         BINDEVENT(THIS.txt_4c_Text1, "KeyPress",  THIS, "Text1KeyPress")
1669:         BINDEVENT(THIS.txt_4c_Text1, "LostFocus", THIS, "Text1LostFocus")
1670:         BINDEVENT(THIS.txt_4c_Text1, "GotFocus",  THIS, "Text1GotFocus")
1671: 
1672:         *-- SIGOPTEF.Timer1.Timer
1673:         BINDEVENT(THIS.obj_4c_Timer1, "Timer", THIS, "TimerLiberarEsc")
1674: 
1675:         RETURN
1676:     ENDPROC
1677: 
1678:     *--------------------------------------------------------------------------
1679:     * KeyPress - PROCEDURE KeyPress do form legado
1680:     * (sigoptef_form_codigo_fonte.txt:824-830):
1681:     *
1682:     *     LPARAMETERS nKeyCode, nShiftAltCtrl
1683:     *     If nKeyCode = 27 And nShiftAltCtrl = 0 And ThisForm.pcKeyEsc
1684:     *         NoDefault
1685:     *         ThisForm.SAIDA.CANCELA.Click
1686:     *     Endif
1687:     *
1688:     * Transcricao direta: pcKeyEsc -> THIS.this_lPermiteEsc (ligado pelo Init
1689:     * e rearmado pelo Timer1). O form tem KeyPreview = .T. (propriedade do
1690:     * SCX, ja transcrita na Fase 3), por isso este evento ve a tecla antes do
1691:     * controle com foco - sem ela o ESC nunca chegaria aqui.
1692:     *
1693:     * Metodo NATIVO do form, nao delegate: sobrescrever KeyPress funciona sem
1694:     * BINDEVENT, e assim o NODEFAULT tem efeito de verdade (num delegate ele
1695:     * nao suprimiria o comportamento padrao do evento).
1696:     *
1697:     * Delega ao handler do botao Cancelar, exatamente como o legado - e nao a
1698:     * uma copia da logica de cancelamento - para haver UM so caminho de saida.
1699:     *
1700:     * FASE 7/8: a chamada passou de THIS.cmg_4c_Saida.Buttons(1).Click() para
1701:     * THIS.BtnCancelarClick() DIRETO, agora que o handler existe. O caminho
1702:     * indireto dependia de o delegate de BINDEVENT disparar tambem quando o
1703:     * Click eh acionado por CODIGO; chamar o metodo eh equivalente para o
1704:     * legado (o Click dele nao faz nada alem do corpo que foi migrado), nao
1705:     * depende dessa suposicao e eh o recorte do irmao Formsigopdtf.prg.
1706:     *--------------------------------------------------------------------------
1707:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1708:         IF par_nKeyCode = 27 AND par_nShiftAltCtrl = 0 AND THIS.this_lPermiteEsc
1709:             NODEFAULT
1710:             THIS.BtnCancelarClick()
1711:         ENDIF
1712: 
1713:         RETURN
1714:     ENDPROC
1715: 
1716:     *--------------------------------------------------------------------------
1717:     * DigitosWhen - SIGOPTEF.GetDigitos.When:
1718:     *
1719:     *     If Empty(This.Value)
1720:     *         Set Confirm Off
1721:     *     Endif
1722:     *     Return(EMPTY(This.Value))
1723:     *
1724:     * O RETURN eh o gate de foco - ver AplicarGatesDeFoco(), que explica por
1725:     * que ele nao se reproduz num delegate e por que aqui ele eh redundante
1726:     * com o Enabled que o legado mesmo manipula.
1727:     *
1728:     * SET CONFIRM OFF faz o foco avancar sozinho quando o campo se enche: com
1729:     * InputMask "9999" (4 digitos), o operador digita os quatro ultimos
1730:     * digitos do cartao e a tela segue sem precisar de ENTER. O legado liga
1731:     * isso ao ENTRAR no campo e desliga ao SAIR (LostFocus, abaixo) - eh um
1732:     * SET global, por isso vem em par.
1733:     *
1734:     * PUBLIC: alvo de BINDEVENT (regra #3).
1735:     *--------------------------------------------------------------------------
1736:     PROCEDURE DigitosWhen()
1737:         IF EMPTY(THIS.txt_4c_Digitos.Value)
1738:             SET CONFIRM OFF
1739:         ENDIF
1740: 
1741:         RETURN
1742:     ENDPROC
1743: 
1744:     *--------------------------------------------------------------------------
1745:     * DigitosLostFocus - SIGOPTEF.GetDigitos.LostFocus: "Set Confirm On".
1746:     * Metade de volta do par aberto por DigitosWhen - restaura o SET global
1747:     * ao sair do campo. PUBLIC: alvo de BINDEVENT.
1748:     *--------------------------------------------------------------------------
1749:     PROCEDURE DigitosLostFocus()
1750:         SET CONFIRM ON
1751: 
1752:         RETURN
1753:     ENDPROC
1754: 
1755:     *--------------------------------------------------------------------------
1756:     * ParcelaWhen - SIGOPTEF.GetParcela.When:
1757:     *
1758:     *     If Not InList(This.Value,"1","2")
1759:     *         Set Confirm Off
1760:     *     ELSE
1761:     *         INKEY(0.1)
1762:     *         CLEAR TYPEAHEAD
1763:     *         KEYBOARD CHR(9)
1764:     *     Endif
1765:     *     *Return(!INLIST(This.Value,"1","2"))
1766:     *
1767:     * Duas metades com proposito oposto, as duas transcritas:
1768:     *   - campo AINDA sem resposta valida: SET CONFIRM OFF, para a resposta
1769:     *     de 1 caractere avancar o foco sozinha;
1770:     *   - campo JA respondido ("1" ou "2"): o legado nao deixa o operador
1771:     *     parar ali de novo - espera 0,1s, limpa o buffer de teclado e
1772:     *     enfileira CHR(9) (TAB), empurrando o foco para o campo seguinte.
1773:     *
1774:     * A ultima linha do When esta COMENTADA no dump: nao ha gate de foco
1775:     * neste campo (ver AplicarGatesDeFoco). O INKEY/KEYBOARD acima eh que faz
1776:     * o papel de "sair do campo", e eh o que o legado de fato executa.
1777:     *
1778:     * This.Value transcrito SEM ALLTRIM, como no legado: o InputMask "!" tem
1779:     * um caractere, logo o valor eh "" ou um char - nao ha espaco a aparar, e
1780:     * aparar mudaria o resultado do INLIST quando o operador responde " ".
1781:     *
1782:     * PUBLIC: alvo de BINDEVENT.
1783:     *--------------------------------------------------------------------------
1784:     PROCEDURE ParcelaWhen()
1785:         IF !INLIST(THIS.txt_4c_Parcela.Value, "1", "2")
1786:             SET CONFIRM OFF
1787:         ELSE
1788:             INKEY(0.1)
1789:             CLEAR TYPEAHEAD
1790:             KEYBOARD CHR(9)
1791:         ENDIF
1792: 
1793:         RETURN
1794:     ENDPROC
1795: 
1796:     *--------------------------------------------------------------------------
1797:     * ValidarParcela - SIGOPTEF.GetParcela.Valid, integral:
1798:     *
1799:     *     Return(INLIST(This.Value,"1","2"," "))
1800:     *
1801:     * Responde quem assume o parcelamento - os labels ao lado do campo
1802:     * ("1 - Lojista" / "2 - Administradora") sao a legenda desta lista.
1803:     *
1804:     * A entrada " " da lista eh o que deixa o campo em BRANCO passar, e isso
1805:     * foi MEDIDO no VFP9 (2026-11-18, automation\Probe809F6b.prg) em vez de
1806:     * deduzido - o resultado depende de SET EXACT, que o config.prg deste
1807:     * sistema deixa em ON:
1808:     *
1809:     *     SET EXACT ON    "" = " " -> .T.    INLIST("","1","2"," ") -> .T.
1810:     *     SET EXACT OFF   "" = " " -> .F.    INLIST("","1","2"," ") -> .F.
1811:     *
1812:     * Com EXACT ON os brancos a direita sao ignorados na comparacao, entao a
1813:     * string vazia casa com o " " da lista e o Valid LIBERA o foco - a
1814:     * resposta "nao informada" eh aceita, e eh justamente para isso que o
1815:     * legado pos o espaco na lista. "1" e "2" continuam aceitos e qualquer
1816:     * outro caractere ("3" medido) continua recusado.
1817:     *
1818:     * Transcrito literalmente, sem ALLTRIM e sem tratar "" em separado:
1819:     * mexer na expressao mudaria o resultado conforme o SET EXACT vigente,
1820:     * que eh exatamente o que o legado nao faz.
1821:     *
1822:     * PUBLIC: consumido por ParcelaKeyPress, que eh alvo de BINDEVENT.
1823:     *--------------------------------------------------------------------------
1824:     FUNCTION ValidarParcela()
1825:         RETURN INLIST(THIS.txt_4c_Parcela.Value, "1", "2", " ")
1826:     ENDFUNC
1827: 
1828:     *--------------------------------------------------------------------------
1829:     * ParcelaKeyPress - dispara ValidarParcela() nas teclas que fariam o foco
1830:     * deixar o campo (ENTER/TAB), porque BINDEVENT em "Valid" nao dispara em
1831:     * TextBox (regra #3). O teste da tecla eh a PRIMEIRA coisa do handler.
1832:     *
1833:     * Quando a resposta eh invalida, o efeito observavel do "Return(.f.)" do
1834:     * legado eh o foco NAO sair do campo - reproduzido com SetFocus() de
1835:     * volta. NODEFAULT nao serviria aqui: num delegate de BINDEVENT ele nao
1836:     * suprime o comportamento padrao do evento.
1837:     *
1838:     * Sem mensagem de erro: o legado tambem nao exibe nenhuma neste Valid -
1839:     * o campo simplesmente nao libera o foco, e as duas legendas ao lado ja
1840:     * dizem quais respostas existem.
1841:     *
1842:     * PUBLIC + parametros do evento declarados: handler de KeyPress sem
1843:     * LPARAMETERS/parametros estoura a cada tecla (regra #3).
1844:     *--------------------------------------------------------------------------
1845:     PROCEDURE ParcelaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1846:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1847:             RETURN
1848:         ENDIF
1849: 
1850:         IF !THIS.ValidarParcela()
1851:             THIS.txt_4c_Parcela.SetFocus()
1852:         ENDIF
1853: 
1854:         RETURN
1855:     ENDPROC
1856: 
1857:     *--------------------------------------------------------------------------
1858:     * ValidarCartao - SIGOPTEF.GetCartao.Valid, integral:
1859:     *
1860:     *     IF LEN(ALLTRIM(THIS.Value)) > 19
1861:     *         DO Form SigTfDss With "Erro na Transacao","","Cartao com mais de 19 digito",...
1862:     *         Return(.f.)
1863:     *     Endif
1864:     *
1865:     * 19 eh o limite de digitos do PAN aceito pelo protocolo, e coincide com
1866:     * o MaxLength = 19 que o SCX declara no campo (Fase 4) - a checagem aqui
1867:     * eh a segunda linha de defesa, para o caso de o valor ter sido posto por
1868:     * codigo em vez de digitado.
1869:     *
1870:     * O texto da mensagem vai SEM acento, como no legado: eh a string que o
1871:     * dialogo do protocolo exibe, e nao um rotulo da tela nova.
1872:     *
1873:     * PUBLIC: consumido por CartaoKeyPress, que eh alvo de BINDEVENT.
1874:     *--------------------------------------------------------------------------
1875:     FUNCTION ValidarCartao()
1876:         LOCAL loc_lValido
1877: 
1878:         loc_lValido = .T.
1879: 
1880:         IF LEN(ALLTRIM(THIS.txt_4c_Cartao.Value)) > 19
1881:             THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
1882:                 "Cartao com mais de 19 digito", "")
1883:             loc_lValido = .F.
1884:         ENDIF
1885: 
1886:         RETURN loc_lValido
1887:     ENDFUNC
1888: 
1889:     *--------------------------------------------------------------------------
1890:     * CartaoKeyPress - mesmo recorte de ParcelaKeyPress: o Valid do legado
1891:     * acionado pelas teclas que tiram o foco do campo (ENTER/TAB), com o
1892:     * foco devolvido ao campo quando a validacao recusa o valor.
1893:     *
1894:     * PUBLIC + parametros do evento declarados (regra #3).
1895:     *--------------------------------------------------------------------------
1896:     PROCEDURE CartaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1897:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1898:             RETURN
1899:         ENDIF
1900: 
1901:         IF !THIS.ValidarCartao()
1902:             THIS.txt_4c_Cartao.SetFocus()
1903:         ENDIF
1904: 
1905:         RETURN
1906:     ENDPROC
1907: 
1908:     *--------------------------------------------------------------------------
1909:     * CodSegWhen - SIGOPTEF.GetCodSeg.When:
1910:     *
1911:     *     If Empty(This.Value)
1912:     *         Set Confirm Off
1913:     *     Endif
1914:     *     Return(EMPTY(This.Value))
1915:     *
1916:     * Mesmo par SET CONFIRM dos outros campos de resposta curta (aqui o
1917:     * InputMask eh "99999"). O RETURN eh gate de foco - ver
1918:     * AplicarGatesDeFoco().
1919:     *
1920:     * A metade de volta (SET CONFIRM ON) mora no SIGOPTEF.GetCodSeg.LostFocus,
1921:     * que eh um dos seis lacos de protocolo e por isso fica para as fases
1922:     * 7-8: no legado o "Set Confirm on" eh a PRIMEIRA linha desse LostFocus,
1923:     * antes de qualquer conversa com o terminal, e separa-lo agora duplicaria
1924:     * um metodo que vai ser escrito inteiro la.
1925:     *
1926:     * PUBLIC: alvo de BINDEVENT.
1927:     *--------------------------------------------------------------------------
1928:     PROCEDURE CodSegWhen()
1929:         IF EMPTY(THIS.txt_4c_Codigo.Value)
1930:             SET CONFIRM OFF
1931:         ENDIF
1932: 
1933:         RETURN
1934:     ENDPROC
1935: 
1936:     *--------------------------------------------------------------------------
1937:     * CodSegGotFocus - SIGOPTEF.GetCodSeg.GotFocus:
1938:     *
1939:     *     ThisForm.Container1.Label1.Caption="Digite o Codigo"+CHR(13)+"de Seguranca"
1940:     *
1941:     * O painel de instrucao ao operador (cnt_4c_Container1) eh reescrito a
1942:     * cada etapa do dialogo - este eh o texto da etapa do codigo de
1943:     * seguranca. Transcrito SEM acento, como no legado: eh instrucao exibida
1944:     * no mesmo painel que o Init ja escreve com "Insira ou Passe o Cartao" /
1945:     * "Digite o Numero do Cartao" (ver AtualizarTextosDaTela), tambem sem
1946:     * acento - acentuar so este quebraria a uniformidade do painel.
1947:     *
1948:     * PUBLIC: alvo de BINDEVENT.
1949:     *--------------------------------------------------------------------------
1950:     PROCEDURE CodSegGotFocus()
1951:         IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
1952:             IF PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Label1", 5)
1953:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = ;
1954:                     "Digite o Codigo" + CHR(13) + "de Seguranca"
1955:             ENDIF
1956:         ENDIF
1957: 
1958:         RETURN
1959:     ENDPROC
1960: 
1961:     *--------------------------------------------------------------------------
1962:     * GetCodSeg.Valid do legado NAO EH TRANSCRITO, e isso nao eh omissao: o
1963:     * corpo INTEIRO do metodo esta comentado no dump, com o prefixo "*!*" do
1964:     * Form Designer (sigoptef_form_codigo_fonte.txt:1745-1755):
1965:     *
1966:     *     *!*  IF VAL(This.Value)>1 .and. VAL(This.Value)<100
1967:     *     *!*      DO Form SigTfDss With "Erro na Transacao","","CSEG Invalido",...
1968:     *     *!*      Return(.f.)
1969:     *     *!*  ELSE
1970:     *     *!*      Return(.t.)
1971:     *     *!*  Endif
1972:     *
1973:     * Ou seja: o legado DESLIGOU essa checagem de proposito - o metodo existe
1974:     * mas nao executa nada, e o campo aceita qualquer codigo de 5 digitos.
1975:     * Transcrever o conteudo comentado criaria uma validacao que o sistema
1976:     * legado nao faz (e que, pela propria expressao, recusaria todo CSEG
1977:     * entre 2 e 99 - exatamente o que deve ter motivado o desligamento).
1978:     *--------------------------------------------------------------------------
1979: 
1980:     *--------------------------------------------------------------------------
1981:     * Text1When - SIGOPTEF.Text1.When: "Set Confirm Off", linha unica.
1982:     * Text1 eh o campo "N PARCELAS"; com InputMask "99" o SET CONFIRM OFF faz
1983:     * o foco avancar quando os dois digitos sao preenchidos. Sem RETURN no
1984:     * legado, logo sem gate de foco. PUBLIC: alvo de BINDEVENT.
1985:     *--------------------------------------------------------------------------
1986:     PROCEDURE Text1When()
1987:         SET CONFIRM OFF
1988: 
1989:         RETURN
1990:     ENDPROC
1991: 
1992:     *--------------------------------------------------------------------------
1993:     * Text1LostFocus - SIGOPTEF.Text1.LostFocus: "Set Confirm On". Metade de
1994:     * volta do par aberto por Text1When. PUBLIC: alvo de BINDEVENT.
1995:     *--------------------------------------------------------------------------
1996:     PROCEDURE Text1LostFocus()
1997:         SET CONFIRM ON
1998: 
1999:         RETURN
2000:     ENDPROC
2001: 
2002:     *--------------------------------------------------------------------------
2003:     * Text1GotFocus - SIGOPTEF.Text1.GotFocus:
2004:     *
2005:     *     ThisForm.Container1.Label1.Caption="Digite o Numero"+CHR(13)+"de Parcelas"
2006:     *
2007:     * Mesmo painel de instrucao do CodSegGotFocus, texto da etapa do numero
2008:     * de parcelas. Tambem sem acento, pelo mesmo motivo.
2009:     * PUBLIC: alvo de BINDEVENT.
2010:     *--------------------------------------------------------------------------
2011:     PROCEDURE Text1GotFocus()
2012:         IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
2013:             IF PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Label1", 5)
2014:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = ;
2015:                     "Digite o Numero" + CHR(13) + "de Parcelas"
2016:             ENDIF
2017:         ENDIF
2018: 
2019:         RETURN
2020:     ENDPROC
2021: 
2022:     *--------------------------------------------------------------------------
2023:     * TimerLiberarEsc - SIGOPTEF.Timer1.Timer:
2024:     *
2025:     *     THisForm.pcKeyEsc = .t.
2026:     *     This.Enabled = .f.
2027:     *
2028:     * Timer de tiro UNICO (Interval = 100ms, nasce desligado): quem o liga
2029:     * quer REARMAR o ESC um instante depois de uma etapa que o havia
2030:     * bloqueado, e o proprio evento se desliga para nao repetir. Por isso
2031:     * "Enabled = .f." eh parte da logica, nao limpeza.
2032:     *
2033:     * "This.Enabled" do legado eh o TIMER (This dentro do evento do timer),
2034:     * nao o form - por isso o alvo aqui eh THIS.obj_4c_Timer1.Enabled.
2035:     *
2036:     * O nome do metodo descreve a ACAO (rearmar o ESC) em vez de repetir o
2037:     * nome do objeto legado, convencao do projeto para handlers.
2038:     *
2039:     * PUBLIC: alvo de BINDEVENT.
2040:     *--------------------------------------------------------------------------
2041:     PROCEDURE TimerLiberarEsc()
2042:         THIS.this_lPermiteEsc = .T.
2043:         THIS.obj_4c_Timer1.Enabled = .F.
2044: 
2045:         RETURN
2046:     ENDPROC
2047: 
2048:     *==========================================================================
2049:     * EVENTOS PRINCIPAIS (FASE 7/8)
2050:     *
2051:     * O evento de botao que este form tem: o Click do unico CommandGroup da
2052:     * tela (SAIDA, ButtonCount = 1). Ver a nota "FASE 7/8" no cabecalho do
2053:     * arquivo para o porque de nao existirem aqui os quatro BtnXxxClick de
2054:     * CRUD, e para o que resta na Fase 8.
2055:     *==========================================================================
2056: 
2057:     *--------------------------------------------------------------------------
2058:     * BtnCancelarClick - SIGOPTEF.SAIDA.CANCELA.Click, integral
2059:     * (sigoptef_form_codigo_fonte.txt:939-943):
2060:     *
2061:     *     lnRetorno=ContinuaFuncaoSiTefInterativo(@ProximoComando, @TipoCampo,
2062:     *               @TamanhoMinimo, @TamanhoMaximo, @Buffer, Len(Buffer), -1)
2063:     *     ThisForm.RetornoFalha("Oper. Cancelada pelo Usuario(1)",lnValPago)
2064:     *     RELEASE WINDOWS
2065:     *
2066:     * As tres linhas, na ordem, e cada uma importa:
2067:     *
2068:     *   1. Continua... com o ULTIMO argumento -1 eh o "aborta" do protocolo:
2069:     *      avisa o terminal que o operador desistiu, para o PIN-pad nao ficar
2070:     *      preso esperando resposta de uma transacao que ninguem vai concluir.
2071:     *      Vai por THIS.this_oBusinessObject.ContinuarSiTef(-1), que eh o
2072:     *      ponto unico de chamada a DLL (as cinco variaveis do estado sao
2073:     *      passadas por referencia e copiadas de volta la - fazer a chamada
2074:     *      solta aqui deixaria copias do estado fora de sincronia).
2075:     *      O retorno eh DESCARTADO de proposito: o legado o guarda em
2076:     *      lnRetorno e nao o le em linha nenhuma depois - o cancelamento
2077:     *      segue adiante mesmo que o terminal recuse o aborto.
2078:     *
2079:     *   2. RetornoFalha grava C:\client\Resp\IntPos.001/.STS com a mensagem de
2080:     *      cancelamento, que eh como o PDV descobre que nao houve autorizacao.
2081:     *      Aqui chama-se GravarRetornoFalha (nome do metodo migrado na Fase 5).

*-- Linhas 2093 a 2381:
2093:     * eh o que diz aos lacos da Fase 8 que a transacao foi abortada.
2094:     *
2095:     * Guarda de BO inexistente: nao tem equivalente no legado, mas em modo de
2096:     * validacao de UI / teste automatizado o InicializarForm sai antes de
2097:     * criar o BO (this_oBusinessObject fica .NULL.) e a chamada estouraria. Em
2098:     * producao o BO sempre existe, entao o caminho do legado fica integral -
2099:     * e o arquivo de resposta eh gravado nos DOIS ramos, porque avisar o PDV
2100:     * do cancelamento nao depende de haver terminal.
2101:     *
2102:     * PUBLIC: alvo de BINDEVENT (regra #3), chamado tambem pelo KeyPress do
2103:     * form (ESC) e pelo harness de teste, que invoca Btn*Click de fora da
2104:     * classe.
2105:     *--------------------------------------------------------------------------
2106:     PROCEDURE BtnCancelarClick()
2107:         LOCAL loc_oBO
2108: 
2109:         loc_oBO = THIS.this_oBusinessObject
2110: 
2111:         IF VARTYPE(loc_oBO) = "O"
2112:             loc_oBO.ContinuarSiTef(-1)
2113:             loc_oBO.this_lCancelado = .T.
2114: 
2115:             THIS.GravarRetornoFalha("Oper. Cancelada pelo Usuario(1)", loc_oBO.this_nValPago)
2116:         ELSE
2117:             THIS.GravarRetornoFalha("Oper. Cancelada pelo Usuario(1)", THIS.this_nValPago)
2118:         ENDIF
2119: 
2120:         THIS.EncerrarDialogo()
2121: 
2122:         RETURN
2123:     ENDPROC
2124: 
2125:     *--------------------------------------------------------------------------
2126:     * EncerrarDialogo - ponto UNICO de saida da tela, no lugar dos 23
2127:     * "RELEASE WINDOWS" / "ThisForm.Release" espalhados pelo dump do legado.
2128:     *
2129:     * Fecha com Hide() e NAO com Release(). O motivo esta por extenso na nota
2130:     * "FASE 7/8" do cabecalho; em uma linha: em VFP9 o Release() destroi o
2131:     * objeto mesmo havendo referencia externa viva, e esta tela existe para
2132:     * DEVOLVER ao PDV o resultado da transacao - que no sistema novo o
2133:     * chamador le de uma property depois do Show(), nao do RETURN do Unload.
2134:     * Quem abriu chama Release() depois de ler, mesmo contrato do
2135:     * classes\formbuscaauxiliar.prg.
2136:     *
2137:     * Idempotente de proposito: varios ramos do legado disparam release em
2138:     * sequencia (ErroTef seguido de RELEASE WINDOWS, por exemplo) e a execucao
2139:     * CONTINUA nas linhas seguintes depois disso - Hide() repetido em form ja
2140:     * oculto eh no-op, entao chamar varias vezes eh seguro.
2141:     *
2142:     * CONTRATO PARA A FASE 8: quando o Unload entrar (o retorno "0,00/" +
2143:     * lnParcs + "/" + data + bandeira + cartao), esse valor tem de ser
2144:     * CALCULADO E CACHEADO AQUI, ANTES do Hide(). Deixar o calculo so no
2145:     * Destroy nao serve: com Hide() o Destroy roda quando o CHAMADOR liberar o
2146:     * objeto, isto eh DEPOIS de ele tentar ler o resultado. Mesmo recorte do
2147:     * EncerrarDialogo do irmao Formsigopdtf.prg, que faz
2148:     * "IF EMPTY(this_cRetornoTef) / this_cRetornoTef = MontarRetornoTef()"
2149:     * antes do Hide - e a condicao de vazio existe justamente por causa da
2150:     * idempotencia descrita acima: recalcular a cada chamada sobrescreveria,
2151:     * com estado mais pobre, o valor montado no primeiro encerramento.
2152:     *
2153:     * PUBLIC: unico ponto de fechamento da tela - o chamador pode precisar
2154:     * fecha-la por conta propria.
2155:     *--------------------------------------------------------------------------
2156:     PROCEDURE EncerrarDialogo()
2157:         IF EMPTY(THIS.this_cRetornoTef)
2158:             THIS.this_cRetornoTef = THIS.MontarRetornoTef()
2159:         ENDIF
2160: 
2161:         THIS.Hide()
2162: 
2163:         RETURN
2164:     ENDPROC
2165: 
2166:     *--------------------------------------------------------------------------
2167:     * QueryUnload - a SEGUNDA METADE do contrato de Hide() do EncerrarDialogo,
2168:     * e a que se esquece: sem ela, Alt+F4 DESTROI o form e o Release() do
2169:     * chamador estoura "<var> is not an object" - erro que aparece dentro do
2170:     * form que ABRIU este dialogo, longe da causa.
2171:     *
2172:     * O Closable continua .T. mesmo com TitleBar = 0 e ControlBox = .F. (as
2173:     * tres propriedades vem do SCX legado, Fase 3): nao ha X para clicar, mas
2174:     * o Alt+F4 fecha - e o VFP levanta o QueryUnload nesse caminho.
2175:     *
2176:     * NODEFAULT nao tranca o objeto: Form.Release() NAO levanta QueryUnload,
2177:     * vai direto ao Destroy. Quem destroi segue sendo quem criou.
2178:     *
2179:     * Nao chama DODEFAULT(): o QueryUnload de FormBase decide o fechamento por
2180:     * this_lEmEdicao (semantica de form CRUD, que esta tela nao tem) e devolve
2181:     * .T., isto eh AUTORIZA a destruicao - exatamente o que este override
2182:     * existe para impedir. Mesmo par ja adotado em
2183:     * classes\formbuscaauxiliar.prg.
2184:     *
2185:     * Fecha pelo MESMO funil do botao Cancelar e do ESC, para os tres caminhos
2186:     * de saida nao divergirem.
2187:     *
2188:     * Forma transcrita do par canonico do projeto (funil + NODEFAULT, sem
2189:     * valor de retorno) e NAO "RETURN .F.": o QueryUnload de FormBase usa o
2190:     * retorno com semantica propria (RETURN !THIS.Cancelar()), e NODEFAULT eh
2191:     * o mecanismo que de fato cancela o fechamento.
2192:     *--------------------------------------------------------------------------
2193:     PROCEDURE QueryUnload()
2194:         THIS.EncerrarDialogo()
2195: 
2196:         NODEFAULT
2197:     ENDPROC
2198: 
2199:     *--------------------------------------------------------------------------
2200:     * ExibirMensagemTef - substitui as 11 chamadas
2201:     *
2202:     *     DO Form SigTfDss With <titulo>,"",<msg1>,<msg2>,"","VM",Left,Top
2203:     *
2204:     * espalhadas pelo dump. O SIGTFDSS.scx NAO faz parte do acervo migrado;
2205:     * pelos call sites ele era um dialogo que apenas EXIBIA as duas linhas de
2206:     * texto (o "VM" eh o esquema de cor, e os dois ultimos argumentos sao a
2207:     * posicao), entao uma caixa de mensagem eh substituicao fiel.
2208:     *
2209:     * MsgAviso e NAO MsgErro, de proposito: sao mensagens de PROTOCOLO
2210:     * devolvidas pelo terminal ("Cartao Vencido", "Cartao Invalido para esta
2211:     * Condicao de Pagamento"), nao falhas tecnicas do sistema - e MsgErro
2212:     * exibe o botao "Fechar Aplicacao", que seria desastroso no meio de uma
2213:     * transacao com o PIN-pad. Mesmo critrio do irmao Formsigopdtf.
2214:     *
2215:     * PROTECTED: consumido so por metodos desta classe (ValidarCartao nesta
2216:     * fase; os lacos de protocolo nas fases 7-8). Delegate de BINDEVENT roda
2217:     * como metodo de THIS, portanto alcanca metodo protegido sem problema -
2218:     * a regra #3 vale para o ALVO do bind, nao para o que ele chama.
2219:     *--------------------------------------------------------------------------
2220:     PROTECTED PROCEDURE ExibirMensagemTef(par_cTitulo, par_cMsg1, par_cMsg2)
2221:         LOCAL loc_cMensagem, loc_cTitulo
2222: 
2223:         loc_cMensagem = ALLTRIM(IIF(VARTYPE(par_cMsg1) = "C", par_cMsg1, ""))
2224: 
2225:         IF VARTYPE(par_cMsg2) = "C" AND !EMPTY(par_cMsg2)
2226:             loc_cMensagem = loc_cMensagem + CHR(13) + ALLTRIM(par_cMsg2)
2227:         ENDIF
2228: 
2229:         IF EMPTY(loc_cMensagem)
2230:             loc_cMensagem = "Falha na comunica" + CHR(231) + CHR(227) + ;
2231:                 "o com o terminal."
2232:         ENDIF
2233: 
2234:         IF VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo)
2235:             loc_cTitulo = par_cTitulo
2236:         ELSE
2237:             loc_cTitulo = "Transa" + CHR(231) + CHR(227) + "o"
2238:         ENDIF
2239: 
2240:         MsgAviso(loc_cMensagem, loc_cTitulo)
2241: 
2242:         RETURN
2243:     ENDPROC
2244: 
2245:     *==========================================================================
2246:     * LACO DE PROTOCOLO COM A DLL (FASE 8/8)
2247:     *
2248:     * Os SEIS metodos abaixo sao as variantes do mesmo dialogo com o
2249:     * terminal que a nota "FASE 6/8" no cabecalho do arquivo deferiu: cada
2250:     * um eh uma transcricao INTEGRAL do metodo legado correspondente
2251:     * (GetDigitos.Valid, GetDigitos.GotFocus, GetParcela.LostFocus,
2252:     * GetCartao.GotFocus, GetCodSeg.LostFocus, Text1.Valid), todos
2253:     * compartilhando o estado do protocolo que vive no BO
2254:     * (this_nProximoComando/this_nTipoCampo/this_cBuffer/this_nContinua,
2255:     * manipulados por THIS.this_oBusinessObject.ContinuarSiTef()) e os
2256:     * acumuladores desta passagem (this_cTipTran/this_cDataHoraTef/
2257:     * this_cCupomRetorno/this_cNsu/this_cAutoriza/this_cFinaliza/
2258:     * this_cMensagemRetorno/this_cMRet, tambem no BO - equivalentes aos
2259:     * "PRIVATE lsTipTran, lsDataHora, ..." que o legado declara de novo no
2260:     * topo de cada um destes metodos, e por isso ZERADOS por
2261:     * ZerarAcumuladoresProtocolo() no INICIO de cada um dos seis, nunca no
2262:     * meio.
2263:     *
2264:     * GUARDA DE REENTRANCIA (this_lEmProtocolo): sem equivalente no legado,
2265:     * obrigatoria aqui. O laco abre dialogo MODAL (ExibirMensagemTef) e
2266:     * mexe em .Enabled/.SetFocus de outros campos - as duas coisas tiram e
2267:     * devolvem o foco, o que pode redisparar o MESMO evento (regras
2268:     * #37/#47). Cada metodo-evento eh um WRAPPER fino (seta a flag, chama o
2269:     * <Nome>Exec() correspondente, desliga a flag) porque o corpo real tem
2270:     * RETURN antecipado em varios pontos - padrao imune a RETURN da regra
2271:     * #47 (set/clear simples deixaria a flag presa ligada para sempre se o
2272:     * corpo saisse pelo meio, matando o campo pelo resto da vida do form).
2273:     *
2274:     * DUAS SUBSTITUICOES DE DIALOGO FILHO, por AUSENCIA no acervo (os .SCX
2275:     * nao vieram) - ambas FALAM EM VOZ ALTA em vez de silenciar, porque no
2276:     * caminho de dinheiro ausencia muda eh pior que ausencia visivel (mesmo
2277:     * criterio da regra #27 sobre wrapper de funcao legada ausente):
2278:     *   - SigCsTef (valor do saque) -> MsgAviso e assume "0,00".
2279:     *   - SigCoCDC (consulta CDC)   -> MsgAviso; o RetornoFalha que o legado
2280:     *     grava em seguida eh preservado.
2281:     * SigTfDss (mensagem de erro do protocolo) ja foi substituido na Fase
2282:     * 6/8 por ExibirMensagemTef, que eh substituicao FIEL (o dialogo legado
2283:     * so exibia texto).
2284:     *
2285:     * "ThisForm.Release"/"RELEASE WINDOWS" do legado viram
2286:     * THIS.EncerrarDialogo() - ponto unico de saida, ja em uso desde a Fase
2287:     * 7 (BtnCancelarClick). Onde o legado continua executando linhas DEPOIS
2288:     * do release (varios ramos disparam release em sequencia), o Hide() por
2289:     * baixo de EncerrarDialogo eh idempotente e nao-destrutivo, entao as
2290:     * linhas seguintes continuam seguras - exceto no "ESC/Lastkey()=27" de
2291:     * cada laco, onde a divergencia e DELIBERADA: em vez de so chamar
2292:     * RetornoFalha+release e deixar o laco teoricamente continuar
2293:     * conversando com um terminal que acabou de ser mandado abortar, aqui
2294:     * SEMPRE se devolve (RETURN) logo depois - mesmo criterio que o irmao
2295:     * Formsigopdtf.prg ja adota nos pontos equivalentes.
2296:     *
2297:     * "Buffer = 'X'" literal (nao ALLTRIM) com SET EXACT ON (config.prg)
2298:     * NUNCA caso neste sistema - precisaria do mesmo tamanho apos
2299:     * desconsiderar so ESPACOS, e o Buffer vem preenchido com CHR(0), nao
2300:     * espaco. Onde o legado compara o Buffer CRU contra um literal de 1
2301:     * caractere (ex.: "Buffer <> '1'"), a comparacao migrada eh sobre
2302:     * LEFT(Buffer,1), reproduzindo o resultado que o legado tinha sob o seu
2303:     * proprio SET EXACT OFF (default) - mesma tecnica do irmao
2304:     * Formsigopdtf.prg.
2305:     *==========================================================================
2306: 
2307:     *--------------------------------------------------------------------------
2308:     * DigitosKeyPress - wrapper de SIGOPTEF.GetDigitos.Valid. BINDEVENT em
2309:     * "Valid" nao dispara em TextBox (regra #3); o Valid legado roda aqui
2310:     * testando ENTER(13)/TAB(9), as duas teclas que tiram o foco do campo.
2311:     * PUBLIC: alvo de BINDEVENT.
2312:     *--------------------------------------------------------------------------
2313:     PROCEDURE DigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2314:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2315:             RETURN
2316:         ENDIF
2317:         IF THIS.this_lEmProtocolo
2318:             RETURN
2319:         ENDIF
2320: 
2321:         THIS.this_lEmProtocolo = .T.
2322:         THIS.DigitosKeyPressExec()
2323:         THIS.this_lEmProtocolo = .F.
2324:     ENDPROC
2325: 
2326:     *--------------------------------------------------------------------------
2327:     * DigitosKeyPressExec - corpo de SIGOPTEF.GetDigitos.Valid
2328:     * (sigoptef_form_codigo_fonte.txt:980-1244), os DOIS lacos do metodo:
2329:     * o 1o ("DO While ProximoComando <> 30") so consome o protocolo ate o
2330:     * terminal liberar o proximo campo; o 2o ("DO WHILE lnRetorno = 10000")
2331:     * envia os 4 digitos e conduz tipo de venda/parcelamento/garantia/
2332:     * saque/codigo de seguranca.
2333:     *
2334:     * "IF ProximoComando = 22" repetido logo depois do 1o Enddo no legado
2335:     * NAO foi transcrito: o 1o laco so sai quando ProximoComando = 30 (a
2336:     * condicao do DO WHILE fica falsa) ou pelo RETURN explicito deste
2337:     * mesmo IF DENTRO do laco - chegar depois do Enddo com
2338:     * ProximoComando = 22 eh logicamente inalcancavel.
2339:     * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
2340:     *--------------------------------------------------------------------------
2341:     PROCEDURE DigitosKeyPressExec()
2342:         LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_cValor
2343: 
2344:         loc_cValor = ALLTRIM(THIS.txt_4c_Digitos.Value)
2345: 
2346:         IF LEN(loc_cValor) != 4 AND !EMPTY(loc_cValor)
2347:             THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
2348:                 "Quantidade de Digitos Invalida", "")
2349:             THIS.txt_4c_Digitos.Value = ""
2350:             RETURN
2351:         ENDIF
2352: 
2353:         IF EMPTY(loc_cValor)
2354:             RETURN
2355:         ENDIF
2356: 
2357:         loc_oBO = THIS.this_oBusinessObject
2358:         IF VARTYPE(loc_oBO) != "O"
2359:             RETURN
2360:         ENDIF
2361: 
2362:         *-- Transfere a tela para o BO ANTES do laco: dali em diante o valor
2363:         *-- enviado a DLL vem da property, nao do controle (ver FormParaBO).
2364:         THIS.FormParaBO()
2365:         loc_cValor = loc_oBO.this_cDigitosCartao
2366: 
2367:         loc_oBO.ZerarAcumuladoresProtocolo()
2368: 
2369:         *-- 1o laco: "DO While ProximoComando <> 30".
2370:         DO WHILE loc_oBO.this_nProximoComando != 30
2371:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
2372:             loc_cBuf     = loc_oBO.this_cBuffer
2373: 
2374:             IF loc_nRetorno < 0
2375:                 THIS.ProcessarErroTef(loc_nRetorno)
2376:                 THIS.EncerrarDialogo()
2377:                 RETURN
2378:             ENDIF
2379: 
2380:             IF loc_oBO.this_nProximoComando = 22
2381:                 loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)

*-- Linhas 2526 a 2569:
2526:                 *-- DO FORM SigCsTef WITH Top,Left TO lcSaque - dialogo de
2527:                 *-- valor de saque nao portado (SIGCSTEF.scx fora do
2528:                 *-- acervo). Avisa e assume "0,00" (sem saque).
2529:                 MsgAviso("Entrada do valor de saque (SigCsTef) n" + CHR(227) + "o foi portada" + ;
2530:                     " nesta migra" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
2531:                     "Assumindo saque de R$ 0,00.", "Saque")
2532:                 loc_oBO.this_cBuffer   = "0,00" + REPLICATE(CHR(0), 1996)
2533:                 loc_oBO.this_nContinua = 1000
2534:                 LOOP
2535:             ENDIF
2536: 
2537:             IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
2538:                 THIS.txt_4c_Codigo.Enabled = .T.
2539:                 EXIT
2540:             ENDIF
2541: 
2542:             IF "DIGITE A SENHA" $ UPPER(ALLTRIM(loc_cBuf))
2543:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
2544:             ENDIF
2545: 
2546:             IF loc_oBO.this_nProximoComando = 3
2547:                 loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
2548:             ENDIF
2549:             IF loc_oBO.this_nTipoCampo = 100
2550:                 loc_oBO.this_cTipTran = loc_cBuf
2551:             ENDIF
2552:             IF loc_oBO.this_nTipoCampo = 105
2553:                 loc_oBO.this_cDataHoraTef = loc_cBuf
2554:             ENDIF
2555:             IF loc_oBO.this_nTipoCampo = 121
2556:                 loc_oBO.this_cCupomRetorno = loc_cBuf
2557:             ENDIF
2558:             IF loc_oBO.this_nTipoCampo = 122
2559:                 loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + loc_cBuf
2560:             ENDIF
2561:             IF loc_oBO.this_nTipoCampo = 131
2562:                 THIS.this_cCodCartaoSiTef = LEFT(loc_cBuf, 5)
2563:             ENDIF
2564:             IF loc_oBO.this_nTipoCampo = 132
2565:                 THIS.this_cBandeira = LEFT(loc_cBuf, 5)
2566:             ENDIF
2567:             IF loc_oBO.this_nTipoCampo = 134
2568:                 loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
2569:             ENDIF

*-- Linhas 2604 a 2706:
2604:                 *-- DO FORM SigCoCDC WITH lsCupom - consulta CDC nao portada
2605:                 *-- (SIGCOCDC.scx fora do acervo). O RetornoFalha que o
2606:                 *-- legado grava em seguida eh preservado.
2607:                 MsgAviso("Consulta CDC (SigCoCDC) n" + CHR(227) + "o portada nesta migra" + ;
2608:                     CHR(231) + CHR(227) + "o." + CHR(13) + ;
2609:                     "Cupom retornado pelo terminal: " + ALLTRIM(loc_oBO.this_cCupomRetorno), "Consulta CDC")
2610:                 THIS.GravarRetornoFalha("Consulta CDC Realizada", THIS.this_nValPago)
2611:             ELSE
2612:                 IF loc_nRetorno = 0
2613:                     THIS.GravarRetornoAprovado(loc_oBO.this_cTipTran, loc_oBO.this_cDataHoraTef, ;
2614:                         loc_oBO.this_cCupomRetorno, THIS.this_cBandeira, loc_oBO.this_cNsu, ;
2615:                         loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, THIS.this_nValPago, loc_oBO.this_cMRet)
2616:                 ENDIF
2617:             ENDIF
2618:             THIS.EncerrarDialogo()
2619:             RETURN
2620:         ENDIF
2621: 
2622:         IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
2623:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
2624:         ELSE
2625:             IF LEFT(loc_oBO.this_cBuffer, 1) != "1"
2626:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Resp." + CHR(13) + "Parcelamento"
2627:             ELSE
2628:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
2629:             ENDIF
2630:         ENDIF
2631: 
2632:         THIS.txt_4c_Digitos.Enabled = .F.
2633:         IF !THIS.txt_4c_Codigo.Enabled
2634:             THIS.txt_4c_Parcela.Enabled = .T.
2635:         ENDIF
2636:     ENDPROC
2637: 
2638:     *--------------------------------------------------------------------------
2639:     * DigitosGotFocus - wrapper de SIGOPTEF.GetDigitos.GotFocus.
2640:     * PUBLIC: alvo de BINDEVENT.
2641:     *--------------------------------------------------------------------------
2642:     PROCEDURE DigitosGotFocus()
2643:         IF THIS.this_lEmProtocolo
2644:             RETURN
2645:         ENDIF
2646: 
2647:         THIS.this_lEmProtocolo = .T.
2648:         THIS.DigitosGotFocusExec()
2649:         THIS.this_lEmProtocolo = .F.
2650:     ENDPROC
2651: 
2652:     *--------------------------------------------------------------------------
2653:     * DigitosGotFocusExec - corpo de SIGOPTEF.GetDigitos.GotFocus
2654:     * (sigoptef_form_codigo_fonte.txt:1256-1456): conecta ao SiTef e inicia
2655:     * a transacao (so quando a forma de pagamento aceita cartao MAGNETICO -
2656:     * crSigOpFp.lCartao = "N"; para cartao digitado, so envia o numero ja
2657:     * capturado), depois conduz tipo de venda/debito-credito.
2658:     *
2659:     * O identificador de terminal NAO eh recalculado aqui (o legado remonta
2660:     * lcIdTerminal a cada GotFocus): no sistema novo isso ja foi resolvido
2661:     * por CarregarIdentificacaoTerminal() no InicializarForm, e as duas
2662:     * entradas (empresa corrente e caixa recebido no Init) nao mudam
2663:     * durante a vida do dialogo.
2664:     * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
2665:     *--------------------------------------------------------------------------
2666:     PROCEDURE DigitosGotFocusExec()
2667:         LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_lCartaoMagnetico, loc_lContinuaLaco, loc_nTipo
2668: 
2669:         loc_oBO = THIS.this_oBusinessObject
2670:         IF VARTYPE(loc_oBO) != "O"
2671:             RETURN
2672:         ENDIF
2673: 
2674:         *-- Transfere a tela para o BO ANTES de conversar com a DLL: no ramo
2675:         *-- de cartao DIGITADO (lCartao <> "N") eh o numero ja na tela que
2676:         *-- vira o primeiro Buffer da passagem - ver FormParaBO.
2677:         THIS.FormParaBO()
2678: 
2679:         loc_lCartaoMagnetico = (loc_oBO.this_cLCartao = "N")
2680: 
2681:         IF loc_lCartaoMagnetico
2682:             IF !loc_oBO.ConectarSiTef()
2683:                 THIS.GravarRetornoFalha("Sem comunicacao com SiTef", THIS.this_nValPago)
2684:                 THIS.EncerrarDialogo()
2685:                 RETURN
2686:             ENDIF
2687: 
2688:             IF !loc_oBO.IniciarSiTef(loc_oBO.ObterDataSiTef(), loc_oBO.ObterHoraSiTef())
2689:                 THIS.GravarRetornoFalha("Sem comunicacao com SiTef", THIS.this_nValPago)
2690:                 THIS.EncerrarDialogo()
2691:                 RETURN
2692:             ENDIF
2693: 
2694:             loc_oBO.this_nProximoComando = 0
2695:             loc_oBO.this_nTipoCampo      = 0
2696:             loc_oBO.this_nTamanhoMinimo  = 0
2697:             loc_oBO.this_nTamanhoMaximo  = 0
2698:             loc_oBO.this_cBuffer         = SPACE(2000)
2699:             loc_oBO.this_nContinua       = 0
2700:         ELSE
2701:             THIS.txt_4c_Cartao.Enabled = .F.
2702:             loc_oBO.MontarBufferSiTef(loc_oBO.this_cNumeroCartao)
2703:             loc_oBO.this_nContinua = 1000
2704: 
2705:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
2706: 

*-- Linhas 2869 a 2940:
2869: 
2870:     *--------------------------------------------------------------------------
2871:     * ParcelaLostFocus - wrapper de SIGOPTEF.GetParcela.LostFocus.
2872:     * PUBLIC: alvo de BINDEVENT.
2873:     *--------------------------------------------------------------------------
2874:     PROCEDURE ParcelaLostFocus()
2875:         SET CONFIRM ON
2876: 
2877:         IF THIS.this_lEmProtocolo
2878:             RETURN
2879:         ENDIF
2880: 
2881:         THIS.this_lEmProtocolo = .T.
2882:         THIS.ParcelaLostFocusExec()
2883:         THIS.this_lEmProtocolo = .F.
2884:     ENDPROC
2885: 
2886:     *--------------------------------------------------------------------------
2887:     * ParcelaLostFocusExec - corpo de SIGOPTEF.GetParcela.LostFocus
2888:     * (sigoptef_form_codigo_fonte.txt:1489-1621): envia a resposta de quem
2889:     * assume o parcelamento ("1"=Lojista/"2"=Administradora) e conduz o
2890:     * terminal ate liberar Text1 (numero de parcelas).
2891:     *
2892:     * ProximoComando=22 tem DUAS saidas (ambas com EXIT, que quebra o DO
2893:     * WHILE independente da profundidade do IF, igual VFP9): a de SENHA/
2894:     * CANC. CLIENTE aborta e marca loc_nRetorno=-8 (nem 0 nem 10000, so
2895:     * ENCERRA sem gravar aprovacao nem falha); a outra aborta, encerra o
2896:     * dialogo e ainda troca o foco para Text1 ANTES do EXIT - preservado
2897:     * mesmo com o form ja oculto (Hide() eh idempotente).
2898:     * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
2899:     *--------------------------------------------------------------------------
2900:     PROCEDURE ParcelaLostFocusExec()
2901:         LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_cValor
2902: 
2903:         loc_cValor = THIS.txt_4c_Parcela.Value
2904:         IF EMPTY(loc_cValor)
2905:             RETURN
2906:         ENDIF
2907: 
2908:         loc_oBO = THIS.this_oBusinessObject
2909:         IF VARTYPE(loc_oBO) != "O"
2910:             RETURN
2911:         ENDIF
2912: 
2913:         *-- Transfere a tela para o BO ANTES do laco (ver FormParaBO).
2914:         THIS.FormParaBO()
2915:         loc_cValor = loc_oBO.this_cRespParcelamento
2916: 
2917:         loc_oBO.ZerarAcumuladoresProtocolo()
2918: 
2919:         IF THIS.this_cCodCartaoSiTef = "00125"
2920:             loc_oBO.this_cBuffer = IIF(THIS.this_nNumParcs = 1, "1", ;
2921:                 IIF(loc_cValor = "1", "3", "2")) + REPLICATE(CHR(0), 1999)
2922:         ELSE
2923:             loc_oBO.this_cBuffer = IIF(THIS.this_nNumParcs = 1, "1", ;
2924:                 IIF(loc_cValor = "1", "2", "3")) + REPLICATE(CHR(0), 1999)
2925:         ENDIF
2926:         loc_oBO.this_nContinua = 1000
2927:         loc_nRetorno           = 10000
2928: 
2929:         DO WHILE loc_nRetorno = 10000
2930:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
2931:             loc_cBuf     = loc_oBO.this_cBuffer
2932: 
2933:             IF LASTKEY() = 27
2934:                 loc_oBO.ContinuarSiTef(-1)
2935:                 THIS.GravarRetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", THIS.this_nValPago)
2936:                 THIS.EncerrarDialogo()
2937:                 RETURN
2938:             ENDIF
2939: 
2940:             IF loc_oBO.this_nProximoComando = 20 AND ;

*-- Linhas 3049 a 3112:
3049: 
3050:     *--------------------------------------------------------------------------
3051:     * CartaoGotFocus - wrapper de SIGOPTEF.GetCartao.GotFocus.
3052:     * PUBLIC: alvo de BINDEVENT.
3053:     *--------------------------------------------------------------------------
3054:     PROCEDURE CartaoGotFocus()
3055:         IF THIS.this_lEmProtocolo
3056:             RETURN
3057:         ENDIF
3058: 
3059:         THIS.this_lEmProtocolo = .T.
3060:         THIS.CartaoGotFocusExec()
3061:         THIS.this_lEmProtocolo = .F.
3062:     ENDPROC
3063: 
3064:     *--------------------------------------------------------------------------
3065:     * CartaoGotFocusExec - corpo de SIGOPTEF.GetCartao.GotFocus
3066:     * (sigoptef_form_codigo_fonte.txt:1643-1723): conecta e inicia a
3067:     * transacao (cartao digitado manualmente, lCartao <> "N" - o caminho
3068:     * magnetico ja foi tratado em DigitosGotFocusExec) e conduz o
3069:     * debito/credito ate o terminal liberar o proximo campo.
3070:     * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
3071:     *--------------------------------------------------------------------------
3072:     PROCEDURE CartaoGotFocusExec()
3073:         LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_nTipo
3074: 
3075:         loc_oBO = THIS.this_oBusinessObject
3076:         IF VARTYPE(loc_oBO) != "O"
3077:             RETURN
3078:         ENDIF
3079: 
3080:         *-- Transfere a tela para o BO ANTES de conversar com a DLL (ver
3081:         *-- FormParaBO). Este handler nao monta Buffer a partir de campo
3082:         *-- digitado - ele CONFIGURA e INICIA a transacao -, mas a partir
3083:         *-- daqui o protocolo decide pelo estado da tela, e o estado tem de
3084:         *-- estar no BO antes da primeira chamada, nao sendo relido depois
3085:         *-- que o laco mexe em .Enabled/.SetFocus.
3086:         THIS.FormParaBO()
3087: 
3088:         IF !loc_oBO.ConectarSiTef()
3089:             THIS.GravarRetornoFalha("Sem comunicacao com SiTef", THIS.this_nValPago)
3090:             THIS.EncerrarDialogo()
3091:             RETURN
3092:         ENDIF
3093: 
3094:         IF !loc_oBO.IniciarSiTef(loc_oBO.ObterDataSiTef(), loc_oBO.ObterHoraSiTef())
3095:             THIS.GravarRetornoFalha("Sem comunicacao com SiTef", THIS.this_nValPago)
3096:             THIS.EncerrarDialogo()
3097:             RETURN
3098:         ENDIF
3099: 
3100:         loc_oBO.this_nProximoComando = 0
3101:         loc_oBO.this_nTipoCampo      = 0
3102:         loc_oBO.this_nTamanhoMinimo  = 0
3103:         loc_oBO.this_nTamanhoMaximo  = 0
3104:         loc_oBO.this_cBuffer         = SPACE(2000)
3105:         loc_oBO.this_nContinua       = 0
3106:         loc_oBO.ZerarAcumuladoresProtocolo()
3107:         loc_nTipo = 1
3108: 
3109:         DO WHILE loc_oBO.this_nProximoComando != 30
3110:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
3111:             loc_cBuf     = loc_oBO.this_cBuffer
3112: 

*-- Linhas 3162 a 3223:
3162: 
3163:     *--------------------------------------------------------------------------
3164:     * CodSegLostFocus - wrapper de SIGOPTEF.GetCodSeg.LostFocus.
3165:     * PUBLIC: alvo de BINDEVENT.
3166:     *--------------------------------------------------------------------------
3167:     PROCEDURE CodSegLostFocus()
3168:         IF THIS.this_lEmProtocolo
3169:             RETURN
3170:         ENDIF
3171: 
3172:         THIS.this_lEmProtocolo = .T.
3173:         THIS.CodSegLostFocusExec()
3174:         THIS.this_lEmProtocolo = .F.
3175:     ENDPROC
3176: 
3177:     *--------------------------------------------------------------------------
3178:     * CodSegLostFocusExec - corpo de SIGOPTEF.GetCodSeg.LostFocus
3179:     * (sigoptef_form_codigo_fonte.txt:1757-1911): envia o codigo de
3180:     * seguranca e conduz o terminal ate liberar GetParcela.
3181:     * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
3182:     *--------------------------------------------------------------------------
3183:     PROCEDURE CodSegLostFocusExec()
3184:         LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_cValor
3185: 
3186:         SET CONFIRM ON
3187: 
3188:         loc_cValor = ALLTRIM(THIS.txt_4c_Codigo.Value)
3189:         IF EMPTY(loc_cValor)
3190:             RETURN
3191:         ENDIF
3192: 
3193:         loc_oBO = THIS.this_oBusinessObject
3194:         IF VARTYPE(loc_oBO) != "O"
3195:             RETURN
3196:         ENDIF
3197: 
3198:         *-- Transfere a tela para o BO ANTES do laco (ver FormParaBO).
3199:         THIS.FormParaBO()
3200:         loc_cValor = loc_oBO.this_cCodSeguranca
3201: 
3202:         loc_oBO.ZerarAcumuladoresProtocolo()
3203:         loc_oBO.MontarBufferSiTef(loc_cValor)
3204:         loc_oBO.this_nContinua = 1000
3205:         loc_nRetorno           = 10000
3206: 
3207:         DO WHILE loc_nRetorno = 10000
3208:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
3209:             loc_cBuf     = loc_oBO.this_cBuffer
3210: 
3211:             IF LASTKEY() = 27
3212:                 loc_oBO.ContinuarSiTef(-1)
3213:                 THIS.GravarRetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", THIS.this_nValPago)
3214:                 THIS.EncerrarDialogo()
3215:                 RETURN
3216:             ENDIF
3217: 
3218:             THIS.cmg_4c_Saida.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
3219: 
3220:             IF loc_oBO.this_nProximoComando = 20 AND ;
3221:                     UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
3222:                 loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
3223:                 LOOP

*-- Linhas 3277 a 3320:
3277:             ENDIF
3278: 
3279:             IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
3280:                 MsgAviso("Entrada do valor de saque (SigCsTef) n" + CHR(227) + "o foi portada" + ;
3281:                     " nesta migra" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
3282:                     "Assumindo saque de R$ 0,00.", "Saque")
3283:                 loc_oBO.this_cBuffer   = "0,00" + REPLICATE(CHR(0), 1996)
3284:                 loc_oBO.this_nContinua = 1000
3285:                 LOOP
3286:             ENDIF
3287: 
3288:             IF "DIGITE A SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
3289:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
3290:             ENDIF
3291: 
3292:             IF loc_oBO.this_nProximoComando = 3
3293:                 loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
3294:             ENDIF
3295:             IF loc_oBO.this_nTipoCampo = 100
3296:                 loc_oBO.this_cTipTran = loc_cBuf
3297:             ENDIF
3298:             IF loc_oBO.this_nTipoCampo = 105
3299:                 loc_oBO.this_cDataHoraTef = loc_cBuf
3300:             ENDIF
3301:             IF loc_oBO.this_nTipoCampo = 121
3302:                 loc_oBO.this_cCupomRetorno = loc_cBuf
3303:             ENDIF
3304:             IF loc_oBO.this_nTipoCampo = 122
3305:                 loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + loc_cBuf
3306:             ENDIF
3307:             IF loc_oBO.this_nTipoCampo = 131
3308:                 THIS.this_cCodCartaoSiTef = LEFT(loc_cBuf, 5)
3309:             ENDIF
3310:             IF loc_oBO.this_nTipoCampo = 132
3311:                 THIS.this_cBandeira = LEFT(loc_cBuf, 5)
3312:             ENDIF
3313:             IF loc_oBO.this_nTipoCampo = 134
3314:                 loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
3315:             ENDIF
3316:             IF loc_oBO.this_nTipoCampo = 135
3317:                 loc_oBO.this_cAutoriza = loc_cBuf
3318:             ENDIF
3319:             IF loc_oBO.this_nTipoCampo = 136
3320:                 IF !loc_oBO.ValidarBinCartao(loc_cBuf)

*-- Linhas 3355 a 3429:
3355:     ENDPROC
3356: 
3357:     *--------------------------------------------------------------------------
3358:     * Text1KeyPress - wrapper de SIGOPTEF.Text1.Valid. BINDEVENT em "Valid"
3359:     * nao dispara em TextBox (regra #3); o Valid legado roda aqui testando
3360:     * ENTER(13)/TAB(9).
3361:     * PUBLIC: alvo de BINDEVENT.
3362:     *--------------------------------------------------------------------------
3363:     PROCEDURE Text1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
3364:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3365:             RETURN
3366:         ENDIF
3367:         IF THIS.this_lEmProtocolo
3368:             RETURN
3369:         ENDIF
3370: 
3371:         THIS.this_lEmProtocolo = .T.
3372:         THIS.Text1KeyPressExec()
3373:         THIS.this_lEmProtocolo = .F.
3374:     ENDPROC
3375: 
3376:     *--------------------------------------------------------------------------
3377:     * Text1KeyPressExec - corpo de SIGOPTEF.Text1.Valid
3378:     * (sigoptef_form_codigo_fonte.txt:1938-2118): envia o numero de
3379:     * parcelas e conduz o terminal ate aprovar/negar ou liberar o codigo
3380:     * de seguranca. Atualiza this_cParcelasTef ("lnParcs=This.Value" do
3381:     * legado), fonte que MontarRetornoTef usa no retorno ao PDV.
3382:     *
3383:     * No ProximoComando=22 desta variante o legado NAO chama RELEASE
3384:     * WINDOWS (unica das seis cuja mensagem de erro fica na tela com o
3385:     * dialogo aberto) - RETURN sem THIS.EncerrarDialogo(), reproduzindo essa
3386:     * assimetria deliberadamente.
3387:     * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
3388:     *--------------------------------------------------------------------------
3389:     PROCEDURE Text1KeyPressExec()
3390:         LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_cValor
3391: 
3392:         loc_cValor = ALLTRIM(THIS.txt_4c_Text1.Value)
3393:         IF EMPTY(loc_cValor)
3394:             RETURN
3395:         ENDIF
3396: 
3397:         THIS.txt_4c_Text1.Value = TRANSFORM(VAL(loc_cValor), "@L 99")
3398: 
3399:         loc_oBO = THIS.this_oBusinessObject
3400:         IF VARTYPE(loc_oBO) != "O"
3401:             RETURN
3402:         ENDIF
3403: 
3404:         *-- Transfere a tela para o BO DEPOIS do TRANSFORM acima (eh o valor
3405:         *-- JA formatado "@L 99" que o legado le em "lnParcs = This.Value" e
3406:         *-- no Buffer) e ANTES do laco - ver FormParaBO.
3407:         THIS.FormParaBO()
3408:         loc_cValor = loc_oBO.this_cQtdParcelas
3409: 
3410:         *-- 1o laco: "DO WHILE ProximoComando <> 30" - literal do legado,
3411:         *-- sem decodificar nada (so interrompe por erro).
3412:         DO WHILE loc_oBO.this_nProximoComando != 30
3413:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
3414: 
3415:             IF loc_nRetorno < 0
3416:                 THIS.ProcessarErroTef(loc_nRetorno)
3417:                 THIS.EncerrarDialogo()
3418:                 RETURN
3419:             ENDIF
3420:         ENDDO
3421: 
3422:         *-- "lnParcs = This.Value" do legado.
3423:         THIS.this_cParcelasTef = TRANSFORM(VAL(loc_cValor), "@L 99")
3424: 
3425:         loc_oBO.ZerarAcumuladoresProtocolo()
3426:         loc_oBO.MontarBufferSiTef(loc_cValor)
3427:         loc_oBO.this_nContinua = 1000
3428:         loc_nRetorno           = 10000
3429: 

*-- Linhas 3496 a 3539:
3496:             ENDIF
3497: 
3498:             IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
3499:                 MsgAviso("Entrada do valor de saque (SigCsTef) n" + CHR(227) + "o foi portada" + ;
3500:                     " nesta migra" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
3501:                     "Assumindo saque de R$ 0,00.", "Saque")
3502:                 loc_oBO.this_cBuffer   = "0,00" + REPLICATE(CHR(0), 1996)
3503:                 loc_oBO.this_nContinua = 1000
3504:                 LOOP
3505:             ENDIF
3506: 
3507:             IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
3508:                 THIS.txt_4c_Codigo.Enabled = .T.
3509:                 EXIT
3510:             ENDIF
3511: 
3512:             IF "DIGITE A SENHA" $ UPPER(ALLTRIM(loc_cBuf))
3513:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
3514:             ENDIF
3515: 
3516:             IF loc_oBO.this_nProximoComando = 3
3517:                 loc_oBO.this_cMRet = ALLTRIM(loc_cBuf)
3518:             ENDIF
3519:             IF loc_oBO.this_nTipoCampo = 100
3520:                 loc_oBO.this_cTipTran = loc_cBuf
3521:             ENDIF
3522:             IF loc_oBO.this_nTipoCampo = 105
3523:                 loc_oBO.this_cDataHoraTef = loc_cBuf
3524:             ENDIF
3525:             IF loc_oBO.this_nTipoCampo = 121
3526:                 loc_oBO.this_cCupomRetorno = loc_cBuf
3527:             ENDIF
3528:             IF loc_oBO.this_nTipoCampo = 122
3529:                 loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + loc_cBuf
3530:             ENDIF
3531:             IF loc_oBO.this_nTipoCampo = 131
3532:                 THIS.this_cCodCartaoSiTef = LEFT(loc_cBuf, 5)
3533:             ENDIF
3534:             IF loc_oBO.this_nTipoCampo = 132
3535:                 THIS.this_cBandeira = LEFT(loc_cBuf, 5)
3536:             ENDIF
3537:             IF loc_oBO.this_nTipoCampo = 134
3538:                 loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
3539:             ENDIF

*-- Linhas 3571 a 3614:
3571: 
3572:         IF loc_nRetorno != 10000
3573:             IF THIS.this_cDebCred = "O"
3574:                 MsgAviso("Consulta CDC (SigCoCDC) n" + CHR(227) + "o portada nesta migra" + ;
3575:                     CHR(231) + CHR(227) + "o." + CHR(13) + ;
3576:                     "Cupom retornado pelo terminal: " + ALLTRIM(loc_oBO.this_cCupomRetorno), "Consulta CDC")
3577:                 THIS.GravarRetornoFalha("Consulta CDC Realizada", THIS.this_nValPago)
3578:             ELSE
3579:                 IF loc_nRetorno = 0
3580:                     THIS.GravarRetornoAprovado(loc_oBO.this_cTipTran, loc_oBO.this_cDataHoraTef, ;
3581:                         loc_oBO.this_cCupomRetorno, THIS.this_cBandeira, loc_oBO.this_cNsu, ;
3582:                         loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, THIS.this_nValPago, loc_oBO.this_cMRet)
3583:                 ENDIF
3584:             ENDIF
3585:             THIS.EncerrarDialogo()
3586:             RETURN
3587:         ENDIF
3588: 
3589:         IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
3590:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
3591:         ELSE
3592:             IF LEFT(loc_oBO.this_cBuffer, 1) != "1"
3593:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Resp." + CHR(13) + "Parcelamento"
3594:             ELSE
3595:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
3596:             ENDIF
3597:         ENDIF
3598: 
3599:         THIS.txt_4c_Digitos.Enabled = .F.
3600:         IF THIS.this_cDebCred != "D"
3601:             THIS.txt_4c_Parcela.Enabled = .T.
3602:         ENDIF
3603:     ENDPROC
3604: 
3605:     *--------------------------------------------------------------------------
3606:     * MontarRetornoTef - transcricao literal do RETURN de SIGOPTEF.Unload
3607:     * (sigoptef_form_codigo_fonte.txt:796-808):
3608:     *
3609:     *     If ! Type('ThisForm.pcBandeira') = [C] or Empty(ThisForm.pcBandeira)
3610:     *         ThisForm.pcBandeira = [00000]
3611:     *     Endif
3612:     *     If ! Type('ThisForm.lsCartao') = [C] or Empty(ThisForm.lsCartao)
3613:     *         ThisForm.lsCartao = [00000]
3614:     *     Endif

*-- Linhas 3640 a 3704:
3640:     * devolve o valor que EncerrarDialogo ja cacheou em this_cRetornoTef, e
3641:     * so recalcula se por algum caminho ele nao tiver sido preenchido.
3642:     * Atende os dois modos de abertura: "DO FORM ... TO lcRetorno" (le este
3643:     * RETURN) e CREATEOBJECT + Show() (le a property this_cRetornoTef, que
3644:     * sobrevive ao fechamento porque o chamador ainda tem a referencia).
3645:     * Os tres CLEAR DLLS/CHRSAW(2) do Unload legado estao COMENTADOS no SCX
3646:     * (desligados de proposito), portanto nao sao migrados.
3647:     * PUBLIC: evento de form.
3648:     *--------------------------------------------------------------------------
3649:     PROCEDURE Unload()
3650:         IF EMPTY(THIS.this_cRetornoTef)
3651:             THIS.this_cRetornoTef = THIS.MontarRetornoTef()
3652:         ENDIF
3653: 
3654:         RETURN THIS.this_cRetornoTef
3655:     ENDPROC
3656: 
3657:     *--------------------------------------------------------------------------
3658:     * TornarControlesVisiveis - Torna visiveis os controles criados via
3659:     * AddObject (nascem com Visible = .F.), recursivo em containers
3660:     * aninhados.
3661:     *
3662:     * Sem lista de excecao: o SCX legado nao tem nenhum container flutuante
3663:     * (cntSombra nao declara Visible, Container1 declara Visible = .T. e
3664:     * nenhum metodo do legado os esconde). Controles que o legado cria
3665:     * DESABILITADOS (GetCartao, GetCodSeg, Text1, Timer1) nao sao afetados -
3666:     * este metodo so mexe em Visible.
3667:     *--------------------------------------------------------------------------
3668:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3669:         LOCAL loc_nI, loc_oControl
3670: 
3671:         IF VARTYPE(par_oContainer) != "O"
3672:             RETURN
3673:         ENDIF
3674: 
3675:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3676:             loc_oControl = par_oContainer.Controls(loc_nI)
3677: 
3678:             IF PEMSTATUS(loc_oControl, "Visible", 5)
3679:                 loc_oControl.Visible = .T.
3680:             ENDIF
3681: 
3682:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
3683:                 THIS.TornarControlesVisiveis(loc_oControl)
3684:             ENDIF
3685:         ENDFOR
3686: 
3687:         RETURN
3688:     ENDPROC
3689: 
3690:     *--------------------------------------------------------------------------
3691:     * Destroy - Libera o objeto de negocio (que mantem os cursores de
3692:     * SigOpFp/SigCdEmp) e delega a FormBase, que reconstroi os popups do menu
3693:     * principal apos o fechamento de um form modal (regra "Destroy DEVE chamar
3694:     * DODEFAULT()": sem isso o menu do sistema encolhe visualmente).
3695:     *--------------------------------------------------------------------------
3696:     PROCEDURE Destroy()
3697:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3698:             THIS.this_oBusinessObject = .NULL.
3699:         ENDIF
3700: 
3701:         DODEFAULT()
3702:     ENDPROC
3703: 
3704: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigoptefBO.prg):
*====================================================================
* sigoptefBO.prg
*
* Business Object para Formsigoptef (Cartao de Credito / TEF - SiTef)
* Form OPERACIONAL sem tabela principal propria: a transacao e feita
* via DLL do SiTef (CliSiTef32I.DLL); o BO so resolve os parametros
* vindos da forma de pagamento (SigOpFp) e da empresa (SigCdEmp) que
* alimentam a integracao TEF.
*
* Tabela: (nenhuma - form nao persiste registro proprio)
*====================================================================

DEFINE CLASS sigoptefBO AS BusinessBase

	*-- Parametros recebidos no Init do form legado (PARAMETERS EndSiTef,
	*-- ValPago, Cupom, Caixa, DebCred, TipPagto, NumParcs, lcIdent, pcOpers)
	this_cEndSiTef = ""        && Endereco/IP do servidor SiTef
	this_nValPago = 0          && Valor a ser pago na transacao
	this_cCupom = ""           && Numero do cupom fiscal (formatado @L 999999)
	this_cCaixa = ""           && Identificacao do caixa (PDV)
	this_cDebCred = ""         && "D"/"C"/"O" - Debito/Credito/Outro
	this_cTipPagto = ""        && Tipo de pagamento (ex.: "E" = especie)
	this_nNumParcs = 0         && Numero de parcelas
	this_cIdent = ""           && Identificador unico da transacao (ltIdent)
	this_cOpers = ""           && Codigo da forma de pagamento (SigOpFp.fpags)

	*-- Derivados a partir dos parametros/lookup (preenchidos no Init)
	this_cIdTerminal = ""      && Identificacao do terminal (CodEstabs ou "00000"+empresa)
	this_cCemps = ""           && Codigo da empresa (SigCdEmp.cemps)

	*-- Espelho de colunas de SigOpFp usadas pela integracao TEF
	this_cFpags = ""           && SigOpFp.fpags (mesmo valor de this_cOpers, apos lookup)
	this_cLCartao = ""         && SigOpFp.lcartao ("S"=cartao digitado manual, "N"=cartao magnetico)
	this_cCodEstabs = ""       && SigOpFp.codestabs
	this_cGarantias = ""       && SigOpFp.garantias
	this_cLSaque = ""          && SigOpFp.lsaque
	this_cTcdc = ""            && SigOpFp.tcdc
	this_nChkBins = 0          && SigOpFp.chkbins

	*====================================================================
	* ESTADO DO PROTOCOLO INTERATIVO DO SiTef (FASE 6/8)
	*
	* No legado estas sao variaveis PUBLIC declaradas no Init do form
	* (sigoptef_form_codigo_fonte.txt:838-839):
	*     Public ProximoComando, TipoCampo, TamanhoMinimo, TamanhoMaximo,
	*            Buffer, lnContinua, ltIdent, lnParcs, lnciclos
	* e lidas/escritas por TODOS os metodos que conversam com a DLL
	* (GetDigitos.Valid/GotFocus, GetParcela.LostFocus, GetCartao.GotFocus,
	* GetCodSeg.LostFocus, Text1.Valid e SAIDA.CANCELA.Click). Como sao UM
	* estado compartilhado, ficam aqui - no BO - e nao espalhadas pelo Form:
	* assim cada chamada a ContinuaFuncaoSiTefInterativo passa pelo mesmo
	* ponto (ContinuarSiTef) e o estado nunca sai de sincronia. Mesmo
	* recorte dos irmaos desta familia (sigopdtfBO, sigprdftBO, SigOpCtfBO).
	*====================================================================
	this_nProximoComando = 0   && ProximoComando  (@lnComando  da DLL)
	this_nTipoCampo      = 0   && TipoCampo       (@lnTipo)
	this_nTamanhoMinimo  = 0   && TamanhoMinimo   (@lnMinimo)
	this_nTamanhoMaximo  = 0   && TamanhoMaximo   (@lnMaximo)
	this_cBuffer         = ""  && Buffer          (@lsBuffer, 2000 bytes)
	this_nContinua       = 0   && lnContinua (ultimo argumento de Continua...)
	this_nCiclos         = 0   && lnCiclos (contador de voltas do laco)

	*-- Acumuladores de UMA passagem pelo laco (FASE 8/8). No legado sao
	*-- PRIVATE declaradas de novo a cada Valid/GotFocus/LostFocus
	*-- (lsTipTran, lsDataHora, lsCupom, lsNsu, lsAutoriza, lsFinaliza,
	*-- mensagem, lsMRet); aqui moram no BO (mesmo estado compartilhado do
	*-- protocolo) e sao zeradas no INICIO de cada handler por
	*-- ZerarAcumuladoresProtocolo(), nunca entre uma chamada a
	*-- ContinuarSiTef e a proxima dentro do MESMO handler.
	this_cTipTran         = "" && lsTipTran  (TipoCampo=100)
	this_cDataHoraTef     = "" && lsDataHora (TipoCampo=105)
	this_cCupomRetorno    = "" && lsCupom    (TipoCampo=121/122, acumulado)
	this_cNsu             = "" && lsNsu      (TipoCampo=134)
	this_cAutoriza        = "" && lsAutoriza (TipoCampo=135)
	this_cFinaliza        = "" && lsFinaliza (ultimo Buffer quando lnRetorno<>0)
	this_cMensagemRetorno = "" && mensagem/lsMensagem (ultimo Buffer "generico")
	this_cMRet            = "" && lsMRet (ProximoComando=3)

	*-- Resultado do DECLARE das funcoes da CliSiTef32I.DLL. A estacao de
	*-- desenvolvimento e a do pipeline nao tem a DLL do SiTef; sem esta
	*-- flag o DECLARE que falha derrubaria o Init do BO e, por tabela, a
	*-- tela inteira (licao "DECLARE DLL carrega na hora e mata o form").
	this_lSiTefDisponivel = .F.

	*-- Transacao abandonada pelo operador (ESC / botao Cancelar). Lida
	*-- pelos lacos do protocolo para nao insistir com o terminal.
	this_lCancelado = .F.

	*-- lcIdTerminal do legado (3o argumento "lsTerminal" do
	*-- ConfiguraIntSiTefInterativo), montado em GetDigitos.GotFocus e
	*-- GetCartao.GotFocus como
	*--     fConverteStr(CrSigCdEmp.nEmps) + TRANSFORM(VAL(crSigFiMpF.Cncaixas), "@L 999999")
	*-- Resolvido por CarregarIdentificacaoTerminal().
	this_nEmps          = 0        && SigCdEmp.nemps  (numeric(3,0))
	this_cIdCaixa       = "000000" && SIGFIMPF.cncaixas formatado "@L 999999"
	this_cTerminalSiTef = ""       && nEmps + cncaixas - identificacao do PDV

	*--------------------------------------------------------------------
	* Campos DIGITADOS NA TELA, transferidos por Formsigoptef.FormParaBO()
	* no inicio de cada passagem pelo laco de protocolo. No legado cada
	* handler lia "This.Value" na hora de montar o Buffer
	* (GetDigitos.Valid, GetParcela.LostFocus, GetCartao.GotFocus,
	* GetCodSeg.LostFocus, Text1.Valid); aqui o valor chega pelo hook, e
	* eh DESTAS properties que MontarBufferSiTef monta o que vai para a
	* CliSiTef32I.DLL - a tela nao eh lida de dentro dos lacos.
	*
	* this_cValorPago eh o conteudo EXIBIDO em GetValor (When -> .f. no
	* legado, portanto nao digitavel): entra aqui pelo mesmo hook por ser
	* o valor que o operador confere antes de autorizar, e eh o texto
	* usado nas linhas "003-000" do arquivo de resposta ao PDV.
	*--------------------------------------------------------------------
	this_cValorPago        = ""  && GetValor.Value    (exibicao, "99999999999,99")
	this_cDigitosCartao    = ""  && GetDigitos.Value  (4 ultimos digitos)
	this_cRespParcelamento = ""  && GetParcela.Value  ("1"=Lojista, "2"=Administradora)
	this_cNumeroCartao     = ""  && GetCartao.Value   (ate 19 digitos)
	this_cCodSeguranca     = ""  && GetCodSeg.Value   (CVV / "0"=inexistente, "1"=ilegivel)
	this_cQtdParcelas      = ""  && Text1.Value       (numero de parcelas digitado)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		*-- Nao ha tabela principal: a transacao TEF nao persiste registro proprio
		THIS.this_cTabela = ""
		THIS.this_cCampoChave = ""

		*-- FASE 6/8: DECLARE-DLL das quatro funcoes do protocolo
		*-- interativo (equivalente ao PROCEDURE Load do SCX legado).
		THIS.DeclararFuncoesSiTef()

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia para as propriedades this_* os dados da
	* forma de pagamento (SigOpFp) carregados em cursor por SQLEXEC.
	* Espelha o bloco do Init legado que le crSigOpFp apos o
	* SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers]).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado

		loc_lResultado = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cFpags     = TratarNulo(fpags, "")
			THIS.this_cLCartao   = TratarNulo(lcartao, "")
			THIS.this_cCodEstabs = TratarNulo(codestabs, "")
			THIS.this_cGarantias = TratarNulo(garantias, "")
			THIS.this_cLSaque    = TratarNulo(lsaque, "")
			THIS.this_cTcdc      = TratarNulo(tcdc, "")
			THIS.this_nChkBins   = TratarNulo(chkbins, 0)

			*-- this_cOpers eh o codigo recebido como parametro no Init do form
			*-- (equivalente a pcOpers do legado); this_cFpags eh a PK lida de
			*-- volta de SigOpFp - mantemos this_cOpers como a fonte unica
			*-- quando ainda nao foi atribuido
			IF EMPTY(THIS.this_cOpers)
				THIS.this_cOpers = THIS.this_cFpags
			ENDIF

			loc_lResultado = .T.
		ENDIF

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BuscarParametrosPagamento - Replica o bloco WITH ThisForm do Init
	* legado (sigoptef_form_codigo_fonte.txt:866-892): busca a forma de
	* pagamento informada (SigOpFp) e os dados da empresa logada
	* (SigCdEmp), para alimentar a integracao com a DLL do SiTef.
	* Usado pelo Form antes de abrir a sessao com o terminal TEF.
	*====================================================================
	PROCEDURE BuscarParametrosPagamento()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado

		loc_lResultado = .F.

		IF USED("cursor_4c_SigOpFp")
			USE IN cursor_4c_SigOpFp
		ENDIF
		IF USED("cursor_4c_SigCdEmp")
			USE IN cursor_4c_SigCdEmp
		ENDIF

		*-- .poDatamgr.SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers],'crSigOpFp')
		loc_cSQL = "SELECT * FROM SigOpFp WHERE fpags = " + EscaparSQL(THIS.this_cOpers)
		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFp")

		IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_SigOpFp") > 0
			THIS.CarregarDoCursor("cursor_4c_SigOpFp")

			*-- .poDatamgr.SqlExecute([Select * From SigCdEmp Where cEmps = ?_Empr],'crSigCdEmp')
			loc_cSQL = "SELECT * FROM SigCdEmp WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdEmp")

			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_SigCdEmp") > 0
				SELECT cursor_4c_SigCdEmp
				THIS.this_cCemps = TratarNulo(cemps, "")

				*-- If Empty(crSigOpFp.CodEstabs) / lsIdTerminal="00000"+_Empr / Else / crSigOpFp.CodEstabs / Endif
				IF EMPTY(THIS.this_cCodEstabs)
					THIS.this_cIdTerminal = "00000" + THIS.this_cCemps
				ELSE
					THIS.this_cIdTerminal = THIS.this_cCodEstabs
				ENDIF

				loc_lResultado = .T.
			ELSE
				THIS.this_cMensagemErro = "Empresa " + ALLTRIM(go_4c_Sistema.cCodEmpresa) + " n" + CHR(227) + "o cadastrada em SigCdEmp."
			ENDIF
		ELSE
			THIS.this_cMensagemErro = "Forma de pagamento " + ALLTRIM(THIS.this_cOpers) + " n" + CHR(227) + "o cadastrada em SigOpFp."
		ENDIF

		IF USED("cursor_4c_SigOpFp")
			USE IN cursor_4c_SigOpFp
		ENDIF
		IF USED("cursor_4c_SigCdEmp")
			USE IN cursor_4c_SigCdEmp
		ENDIF

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Este BO nao persiste registro proprio: a
	* transacao e feita pela DLL do SiTef (CliSiTef32I.DLL), fora do
	* SQL Server (regra PILAR 2 - nao ha tabela para criar so para dar
	* uma PK a este BO). A chave usada em RegistrarAuditoria() eh o
	* identificador unico da transacao (equivalente ao ltIdent recebido
	* no Init legado), com a forma de pagamento como fallback enquanto
	* a transacao ainda nao tem identificador atribuido.
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		IF !EMPTY(THIS.this_cIdent)
			RETURN ALLTRIM(THIS.this_cIdent)
		ENDIF
		RETURN ALLTRIM(THIS.this_cOpers)
	ENDPROC

	*====================================================================
	* RegistrarTransacaoTef - Registra em auditoria o resultado da
	* transacao TEF (aprovada/negada/cancelada pelo usuario). Chamado
	* pelo Form apos o retorno da DLL do SiTef - no legado esse ponto
	* correspondia so a escrita dos arquivos de resposta do PDV
	* (MontaRetorno/RetornoFalha, montaretorno/retornofalha do
	* sigoptef_form_codigo_fonte.txt); aqui tambem fica o registro de
	* auditoria do evento, usando o par_cOperacao como descricao
	* (ex.: "TEF_APROVADO", "TEF_NEGADO", "TEF_CANCELADO").
	*====================================================================
	PROCEDURE RegistrarTransacaoTef(par_cOperacao)
		RETURN THIS.RegistrarAuditoria(par_cOperacao)
	ENDPROC

	*====================================================================
	* CAMADA DE ACESSO A CliSiTef32I.DLL (FASE 6/8)
	*
	* Equivale ao PROCEDURE Load do SCX legado (DECLARE das quatro funcoes)
	* mais a CENTRALIZACAO das chamadas que o legado espalha por sete
	* metodos diferentes. Os lacos de protocolo que CONSOMEM esta camada
	* (GetDigitos.Valid/GotFocus, GetParcela.LostFocus, GetCartao.GotFocus,
	* GetCodSeg.LostFocus e Text1.Valid) sao escopo das fases 7-8: sao
	* cinco variantes do MESMO dialogo com o terminal, compartilhando o
	* estado declarado no topo desta classe, e dividi-los produziria
	* pedaco de maquina de estado que nao faz nada sozinho. Mesmo recorte
	* dos irmaos desta familia (sigopdtfBO, sigprdftBO, SigOpCtfBO), onde
	* esta camada tambem mora no BO e nasce antes do laco.
	*====================================================================

	*====================================================================
	* DeclararFuncoesSiTef - PROCEDURE Load do legado
	* (sigoptef_form_codigo_fonte.txt:813-819), as QUATRO declaracoes, na
	* mesma ordem e com as mesmas assinaturas.
	*
	* TRY/CATCH obrigatorio: DECLARE ... IN "<arquivo>.DLL" NAO eh
	* declaracao preguicosa - o VFP9 tenta CARREGAR a biblioteca na hora
	* e, na estacao sem o PIN-pad (desenvolvimento/pipeline), estoura
	* "Cannot load 32-bit DLL CliSiTef32I.DLL." ali mesmo. Sem o TRY o
	* erro sobe pelo Init do BO, CREATEOBJECT("sigoptefBO") devolve .F., o
	* Form ve VARTYPE != "O" e A TELA NAO ABRE, exibindo so "VARTYPE
	* retornou: L" (licao "DECLARE DLL carrega na hora e mata o form").
	*
	* CATCH sem MsgErro de proposito: biblioteca ausente nao eh erro a
	* reportar na abertura da tela. Quem avisa eh o proprio caminho do
	* legado - this_lSiTefDisponivel = .F. faz ConectarSiTef() devolver
	* .F. e o laco cai no ramo "Sem comunicacao com SiTef" que o legado ja
	* tem para ConfiguraIntSiTefInterativo <> 0. Chamar a funcao sem o
	* DECLARE seria pior: o VFP passaria a procurar
	* "continuafuncaositefinterativo.prg" no PATH (regra #13) e a mensagem
	* nao citaria nem DLL nem SiTef.
	*
	* PROTECTED: chamado so pelo Init desta classe (regra #51).
	*====================================================================
	PROTECTED PROCEDURE DeclararFuncoesSiTef()
		LOCAL loc_oErro

		THIS.this_lSiTefDisponivel = .F.

		TRY
			DECLARE INTEGER ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
				STRING lsEndereco, STRING lsLoja, STRING lsTerminal, INTEGER lnReservado

			DECLARE INTEGER IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
				INTEGER lnModalidade, STRING lsValor, STRING lsCupom, STRING lsData, ;
				STRING lsHorario, STRING lsOperador, STRING lsRestricao

			DECLARE INTEGER ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
				INTEGER @lnComando, INTEGER @lnTipo, INTEGER @lnMinimo, INTEGER @lnMaximo, ;
				STRING @lsBuffer, INTEGER lnTamanho, INTEGER lnResultado

			DECLARE INTEGER FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
				INTEGER lnConfirma, STRING lsCupom, STRING lsData, STRING lsHorario

			THIS.this_lSiTefDisponivel = .T.
		CATCH TO loc_oErro
			*-- Estacao sem a CliSiTef32I.DLL. Ver o cabecalho acima: a
			*-- flag fica .F. e cada wrapper devolve o valor de FALHA que
			*-- o proprio legado ja trata.
			THIS.this_cMensagemErro = loc_oErro.Message
		ENDTRY
	ENDPROC

	*====================================================================
	* ZerarAcumuladoresProtocolo - FASE 8/8. Reproduz o "PRIVATE lsNsu,
	* lsAutoriza, lsDataHora, lsTipTran, lsCupom, lsFinaliza" que o legado
	* declara de novo no TOPO de cada Valid/GotFocus/LostFocus que inicia
	* uma passagem pelo laco - chamado por esses handlers (Form) antes de
	* montar o primeiro Buffer da passagem, nunca no meio dela.
	*====================================================================
	PROCEDURE ZerarAcumuladoresProtocolo()
		THIS.this_cTipTran         = ""
		THIS.this_cDataHoraTef     = ""
		THIS.this_cCupomRetorno    = ""
		THIS.this_cNsu             = ""
		THIS.this_cAutoriza        = ""
		THIS.this_cFinaliza        = ""
		THIS.this_cMensagemRetorno = ""
		THIS.this_cMRet            = ""
	ENDPROC

	*====================================================================
	* AplicarCamposDigitados - recebe de Formsigoptef.FormParaBO() o que
	* esta NA TELA e guarda nas properties que os lacos do protocolo leem.
	*
	* Cada argumento eh OPCIONAL e o teste eh por PCOUNT(), nao por tipo:
	* parametro OMITIDO chega ao VFP9 como Logico .F., entao um
	* "VARTYPE() = 'L'" tomaria a omissao por um valor e sobrescreveria a
	* property com o texto de um .F. - exatamente o que a tela nao pediu.
	* Argumento PRESENTE mas de tipo inesperado vira "" por NormalizarTexto.
	*
	* A normalizacao para Caractere acontece aqui porque o TextBox de
	* parcelas nasce NUMERICO quando o chamador ja informa NumParcs, e
	* concatenar numero com string estoura "Operator/operand type
	* mismatch" dentro do laco - longe daqui, dificil de atribuir.
	*====================================================================
	PROCEDURE AplicarCamposDigitados(par_cValorPago, par_cDigitos, ;
			par_cRespParcelamento, par_cNumeroCartao, ;
			par_cCodSeguranca, par_cQtdParcelas)

		IF PCOUNT() >= 1
			THIS.this_cValorPago = THIS.NormalizarTexto(par_cValorPago)
		ENDIF
		IF PCOUNT() >= 2
			THIS.this_cDigitosCartao = THIS.NormalizarTexto(par_cDigitos)
		ENDIF
		IF PCOUNT() >= 3
			THIS.this_cRespParcelamento = THIS.NormalizarTexto(par_cRespParcelamento)
		ENDIF
		IF PCOUNT() >= 4
			THIS.this_cNumeroCartao = THIS.NormalizarTexto(par_cNumeroCartao)
		ENDIF
		IF PCOUNT() >= 5
			THIS.this_cCodSeguranca = THIS.NormalizarTexto(par_cCodSeguranca)
		ENDIF
		IF PCOUNT() >= 6
			THIS.this_cQtdParcelas = THIS.NormalizarTexto(par_cQtdParcelas)
		ENDIF

		RETURN .T.
	ENDPROC

	*====================================================================
	* NormalizarTexto - devolve SEMPRE Caractere, sem espaco nas pontas.
	* Character passa direto; Numeric vai por TRANSFORM (nunca ALLTRIM
	* direto num numerico, que estoura erro 11); Logico vira "S"/"N";
	* qualquer outro tipo (inclusive NULL) vira "".
	*====================================================================
	PROTECTED FUNCTION NormalizarTexto(par_uValor)
		LOCAL loc_cTexto

		IF ISNULL(par_uValor)
			RETURN ""
		ENDIF

		DO CASE
			CASE VARTYPE(par_uValor) = "C"
				loc_cTexto = ALLTRIM(par_uValor)
			CASE VARTYPE(par_uValor) = "N"
				loc_cTexto = ALLTRIM(TRANSFORM(par_uValor))
			CASE VARTYPE(par_uValor) = "L"
				loc_cTexto = IIF(par_uValor, "S", "N")
			OTHERWISE
				loc_cTexto = ""
		ENDCASE

		RETURN loc_cTexto
	ENDFUNC

	*====================================================================
	* CarregarIdentificacaoTerminal - resolve o lcIdTerminal que o legado
	* monta em GetDigitos.GotFocus / GetCartao.GotFocus:
	*     lcIdTerminal = fConverteStr(CrSigCdEmp.nEmps) + ;
	*                    TRANSFORM(VAL(crSigFiMpF.Cncaixas), "@L 999999")
	*
	* crSigFiMpF eh cursor GLOBAL do Framework legado (impressora fiscal
	* do caixa) e NAO eh populado em ponto algum deste dump - o SCX
	* contava com a tela de venda te-lo aberto. Em vez de depender de
	* cursor global nao documentado, consulta SIGFIMPF pela empresa
	* corrente e, quando o parametro "Caixa" recebido no Init bate com
	* algum SIGFIMPF.cncaixas dessa empresa, usa esse registro; senao cai
	* no 1o registro da empresa e, na falta de qualquer um, em "000000".
	* Mesmo criterio (e mesmos fallbacks) de
	* sigopdtfBO.CarregarIdentificacaoTerminal.
	*
	* Colunas conferidas em docs/schema.sql (lido com Get-Content -Raw,
	* regra #14): SigCdEmp.nemps numeric(3,0), SIGFIMPF.cncaixas char(3),
	* SIGFIMPF.emps char(3) - "emps" SEM o C inicial nesta tabela
	* (regra #48: o prefixo da tabela nao decide o nome da coluna).
	*
	* NAO derruba o form quando a consulta falha: os fallbacks acima sao o
	* mesmo desfecho pratico do legado com os cursores globais vazios.
	*====================================================================
	FUNCTION CarregarIdentificacaoTerminal()
		LOCAL loc_oErro, loc_cSQL

		THIS.this_nEmps    = 0
		THIS.this_cIdCaixa = "000000"

		TRY
			IF USED("cursor_4c_EmpTef")
				USE IN cursor_4c_EmpTef
			ENDIF

			loc_cSQL = "SELECT nemps FROM SigCdEmp WHERE cemps = " + ;
				EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
			SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTef")

			IF USED("cursor_4c_EmpTef") AND !EOF("cursor_4c_EmpTef")
				THIS.this_nEmps = TratarNulo(cursor_4c_EmpTef.nemps, 0)
			ENDIF

			IF USED("cursor_4c_EmpTef")
				USE IN cursor_4c_EmpTef
			ENDIF

			IF USED("cursor_4c_MpfTef")
				USE IN cursor_4c_MpfTef
			ENDIF

			loc_cSQL = "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + ;
				EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))

			IF !EMPTY(ALLTRIM(THIS.this_cCaixa))
				loc_cSQL = loc_cSQL + " AND cncaixas = " + ;
					EscaparSQL(ALLTRIM(THIS.this_cCaixa))
			ENDIF

			SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MpfTef")

			IF USED("cursor_4c_MpfTef") AND !EOF("cursor_4c_MpfTef")
				THIS.this_cIdCaixa = TRANSFORM(VAL(TratarNulo(cursor_4c_MpfTef.cncaixas, "0")), "@L 999999")
			ENDIF

			IF USED("cursor_4c_MpfTef")
				USE IN cursor_4c_MpfTef
			ENDIF
		CATCH TO loc_oErro
			*-- Sem tabela/registro/conexao: seguem os fallbacks acima.
			THIS.this_cMensagemErro = loc_oErro.Message
		ENDTRY

		THIS.this_cTerminalSiTef = fConverteStr(THIS.this_nEmps) + THIS.this_cIdCaixa

		RETURN .T.
	ENDFUNC

	*====================================================================
	* ConectarSiTef - encapsula a chamada que o legado faz em
	* GetDigitos.GotFocus e GetCartao.GotFocus:
	*     IF ConfiguraIntSiTefInterativo(lsEndSitef,lsIdTerminal,lcIdTerminal,0) <> 0
	*         Thisform.RetornoFalha("Sem comunicacao com SiTef")
	*
	* Argumentos, na ordem da DLL:
	*   lsEndereco  = lsEndSiTef   -> this_cEndSiTef (parametro EndSiTef)
	*   lsLoja      = lsIdTerminal -> this_cIdTerminal (SigOpFp.codestabs,
	*                 ou "00000" + empresa quando vazio - ja resolvido em
	*                 BuscarParametrosPagamento). NAO confundir com o
	*                 numero do caixa: este argumento identifica a LOJA no
	*                 servidor SiTef, e enviar o caixa aqui faz o servidor
	*                 recusar a conexao ou credenciar na loja errada.
	*   lsTerminal  = lcIdTerminal -> this_cTerminalSiTef (empresa+caixa)
	*   lnReservado = 0 (literal no legado)
	*
	* Devolve .T. quando a conexao foi aceita (retorno 0 da DLL), para o
	* chamador escrever "IF !ConectarSiTef()" no lugar do "<> 0" do
	* legado. Sem a DLL carregada devolve .F. sem chamar nada - o laco cai
	* no mesmo ramo "Sem comunicacao com SiTef".
	*====================================================================
	FUNCTION ConectarSiTef()
		LOCAL loc_nRetorno

		IF !THIS.this_lSiTefDisponivel
			RETURN .F.
		ENDIF

		IF EMPTY(THIS.this_cTerminalSiTef)
			THIS.CarregarIdentificacaoTerminal()
		ENDIF

		loc_nRetorno = ConfiguraIntSiTefInterativo(ALLTRIM(THIS.this_cEndSiTef), ;
			ALLTRIM(THIS.this_cIdTerminal), THIS.this_cTerminalSiTef, 0)

		RETURN (loc_nRetorno = 0)
	ENDFUNC

	*====================================================================
	* IniciarSiTef - encapsula a chamada que o legado faz logo apos
	* conectar (GetDigitos.GotFocus / GetCartao.GotFocus):
	*     lcValpago = ALLTRIM(TRANSFORM(lnValPago,"99999999.99"))
	*     lcValPago = STRTRAN(lcValPago,".",",")
	*     IF IniciaFuncaoSiTefInterativo(0,lcValPago,lsCupom,lcData,lchora,lsCaixa,"") <> 10000
	*
	* A modalidade (1o argumento) eh 0 LITERAL no legado e a restricao
	* (ultimo) eh string vazia. O valor vai com VIRGULA decimal - eh o
	* formato que o protocolo exige, nao um descuido de localizacao.
	* par_cData/par_cHora chegam ja formatados pelo chamador (o legado
	* repete o mesmo calculo em cada ponto que inicia a transacao; os dois
	* helpers estao em ObterDataSiTef/ObterHoraSiTef, abaixo).
	*
	* Devolve .T. quando a DLL responde 10000 (= transacao iniciada, siga
	* para o laco de Continua...), espelhando o teste "<> 10000" do legado.
	*====================================================================
	FUNCTION IniciarSiTef(par_cData, par_cHora)
		LOCAL loc_cValPago, loc_cData, loc_cHora, loc_nRetorno

		IF !THIS.this_lSiTefDisponivel
			RETURN .F.
		ENDIF

		loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValPago, "99999999.99")), ".", ",")
		loc_cData    = IIF(VARTYPE(par_cData) = "C" AND !EMPTY(par_cData), par_cData, THIS.ObterDataSiTef())
		loc_cHora    = IIF(VARTYPE(par_cHora) = "C" AND !EMPTY(par_cHora), par_cHora, THIS.ObterHoraSiTef())

		loc_nRetorno = IniciaFuncaoSiTefInterativo(0, loc_cValPago, THIS.this_cCupom, ;
			loc_cData, loc_cHora, ALLTRIM(THIS.this_cCaixa), "")

		RETURN (loc_nRetorno = 10000)
	ENDFUNC

	*====================================================================
	* ContinuarSiTef - encapsula TODAS as chamadas a
	* ContinuaFuncaoSiTefInterativo do legado (GetDigitos.Valid,
	* GetParcela.LostFocus, GetCodSeg.LostFocus, GetCartao.GotFocus,
	* Text1.Valid e SAIDA.CANCELA.Click).
	*
	* Os cinco primeiros argumentos sao POR REFERENCIA (@) e a DLL escreve
	* neles o proximo passo do protocolo. VFP9 nao passa property por
	* referencia, entao o estado eh copiado para LOCAL, passado com @ e
	* copiado de volta - por isso toda chamada tem de vir por aqui: fazer
	* a chamada direta em cada handler deixaria copias do estado fora de
	* sincronia.
	*
	* Buffer nunca pode ir vazio: o 6o argumento eh LEN(buffer) e a DLL
	* escreve nele ate esse tamanho - o legado sempre mantem 2000 bytes.
	*
	* par_nContinua ausente reusa o this_nContinua corrente, que eh como o
	* legado se comporta (lnContinua eh variavel PUBLIC, preservada entre
	* as voltas do laco).
	*====================================================================
	FUNCTION ContinuarSiTef(par_nContinua)
		LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
			loc_nTamanhoMaximo, loc_cBuffer, loc_nContinua, loc_nRetorno

		IF !THIS.this_lSiTefDisponivel
			*-- -1 eh "Modulo Nao Iniciado" na tabela de erros do proprio
			*-- legado (ver ProcessarErroTef no Form) - o codigo certo para
			*-- "nao ha como conversar com o equipamento".
			RETURN -1
		ENDIF

		loc_nContinua = IIF(VARTYPE(par_nContinua) = "N", par_nContinua, THIS.this_nContinua)

		loc_nProximoComando = THIS.this_nProximoComando
		loc_nTipoCampo      = THIS.this_nTipoCampo
		loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
		loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
		loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), REPLICATE(CHR(0), 2000), THIS.this_cBuffer)

		loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
			@loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)

		THIS.this_nProximoComando = loc_nProximoComando
		THIS.this_nTipoCampo      = loc_nTipoCampo
		THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
		THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
		THIS.this_cBuffer         = loc_cBuffer
		THIS.this_nContinua       = loc_nContinua

		RETURN loc_nRetorno
	ENDFUNC

	*====================================================================
	* FinalizarTransacaoSiTef - 4a funcao declarada pelo Load legado.
	* Assinatura: (lnConfirma, lsCupom, lsData, lsHorario). lnConfirma = 0
	* DESFAZ a transacao em aberto no terminal; 1 confirma.
	*
	* Nenhum metodo do dump deste form a CHAMA - o SCX a declara junto das
	* outras tres (mesmo Load do irmao SIGOPDTF, onde ela eh usada). O
	* wrapper existe porque a DECLARACAO existe: sem ele, quem precisar
	* desfazer a transacao chamaria a funcao solta e, faltando o DECLARE,
	* o VFP procuraria "finalizatransacaositefinterativo.prg" no PATH
	* (regra #13). Nao ha caminho novo inventado aqui - so o acesso a uma
	* funcao que o proprio legado ja declara.
	*====================================================================
	FUNCTION FinalizarTransacaoSiTef(par_nConfirma, par_cCupom, par_cData, par_cHora)
		LOCAL loc_nRetorno

		IF !THIS.this_lSiTefDisponivel
			RETURN -1
		ENDIF

		loc_nRetorno = FinalizaTransacaoSiTefInterativo( ;
			IIF(VARTYPE(par_nConfirma) = "N", par_nConfirma, 0), ;
			IIF(VARTYPE(par_cCupom) = "C" AND !EMPTY(par_cCupom), par_cCupom, "1"), ;
			IIF(VARTYPE(par_cData) = "C" AND !EMPTY(par_cData), par_cData, THIS.ObterDataSiTef()), ;
			IIF(VARTYPE(par_cHora) = "C" AND !EMPTY(par_cHora), par_cHora, THIS.ObterHoraSiTef()))

		RETURN loc_nRetorno
	ENDFUNC

	*====================================================================
	* MontarBufferSiTef - carrega this_cBuffer com o valor que o operador
	* digitou, completado com CHR(0) ate os 2000 bytes que
	* ContinuaFuncaoSiTefInterativo espera. Migrado do padrao repetido em
	* cada Valid/LostFocus do legado:
	*     Buffer=Alltrim(This.Value)+REPLICATE(CHR(0),2000-LEN(Alltrim(This.Value)))
	*
	* par_nComplemento permite reproduzir as variantes LITERAIS do legado
	* (ex.: Buffer = '0' + Replicate(Chr(0),1999) na resposta ao comando
	* 20, onde o complemento eh 1999 e nao 2000 - LEN(Buffer)).
	*====================================================================
	FUNCTION MontarBufferSiTef(par_cValor, par_nComplemento)
		LOCAL loc_cValor, loc_nComplemento

		IF VARTYPE(par_cValor) = "C"
			loc_cValor = ALLTRIM(par_cValor)
		ELSE
			loc_cValor = ALLTRIM(TRANSFORM(par_cValor))
		ENDIF

		IF VARTYPE(par_nComplemento) = "N" AND par_nComplemento > 0
			loc_nComplemento = par_nComplemento
		ELSE
			loc_nComplemento = 2000 - LEN(loc_cValor)
		ENDIF

		IF loc_nComplemento < 0
			loc_nComplemento = 0
		ENDIF

		THIS.this_cBuffer = loc_cValor + REPLICATE(CHR(0), loc_nComplemento)

		RETURN THIS.this_cBuffer
	ENDFUNC

	*====================================================================
	* ObterDataSiTef / ObterHoraSiTef - os dois formatos que o legado
	* monta a mao em cada ponto que inicia a transacao:
	*     lcData = STR(YEAR(DATE()),4)+SUBSTR(DTOC(DATE()),4,2)+SUBSTR(DTOC(DATE()),1,2)
	*     lchora = STRTRAN(TIME(),":","")
	* ou seja AAAAMMDD e HHMMSS, sem separador.
	*
	* A transcricao NAO usa SUBSTR(DTOC(...)): DTOC depende de SET DATE, e
	* um SET DATE diferente no processo trocaria mes por dia EM SILENCIO.
	* DTOS(DATE()) devolve AAAAMMDD por definicao, independente de SET
	* DATE - exatamente o que o legado pretendia montar. Na hora, TIME()
	* devolve HH:MM:SS fixo; o LEFT(...,8) descarta os centesimos que
	* TIME(1) traria e que o legado nao usa.
	*====================================================================
	FUNCTION ObterDataSiTef()
		RETURN DTOS(DATE())
	ENDFUNC

	FUNCTION ObterHoraSiTef()
		RETURN STRTRAN(LEFT(TIME(), 8), ":", "")
	ENDFUNC

	*====================================================================
	* ValidarBinCartao - migrado do bloco "IF TipoCampo = 136" que aparece
	* DUAS vezes no GetDigitos.Valid legado:
	*     lcQuery = [Select ChkBins From SigOpFp Where FPags = ']+ThisForm.pcOpers+[']
	*     If csTmpFPag.ChkBins = 1
	*         lcQuery = [Select CodBins,DataIs,DataFs From SigOpFpb Where FPags = '...'
	*                    And CodBins = ']+Alltrim(Strtran(Buffer,Chr(0),''))+[']
	*         If Eof() Or Not Between(Dtos(Date()),Dtos(Nvl(DataIs,Ctod('01/01/1900'))), ;
	*                                               Dtos(Nvl(DataFs,Ctod('31/12/9999'))))
	*             ... "Cartao Invalido para esta Condicao de Pagamento" e aborta
	*
	* ChkBins ja foi lido para this_nChkBins em CarregarDoCursor - nao se
	* reconsulta SigOpFp a cada volta do laco. Com a checagem DESLIGADA
	* (ChkBins <> 1) o legado nao consulta nada e segue a transacao, por
	* isso o retorno eh .T. nesse caso.
	*
	* O BIN chega do buffer da DLL com CHR(0) de enchimento - o STRTRAN
	* abaixo eh o mesmo do legado, e sem ele o WHERE nunca casaria.
	*
	* datais/datafs sao datetime (docs/schema.sql): ConverterParaData
	* normaliza os dois lados antes do DTOS, porque comparar DATE com
	* DATETIME dispara erro 11 (regra #16).
	*====================================================================
	FUNCTION ValidarBinCartao(par_cBin)
		LOCAL loc_oErro, loc_cSQL, loc_cBin, loc_lValido, loc_dIni, loc_dFim

		IF THIS.this_nChkBins != 1
			RETURN .T.
		ENDIF

		loc_cBin    = ALLTRIM(STRTRAN(IIF(VARTYPE(par_cBin) = "C", par_cBin, ""), CHR(0), ""))
		loc_lValido = .F.

		TRY
			IF USED("cursor_4c_SigOpFpb")
				USE IN cursor_4c_SigOpFpb
			ENDIF

			loc_cSQL = "SELECT codbins, datais, datafs FROM SigOpFpb" + ;
				" WHERE fpags = " + EscaparSQL(ALLTRIM(THIS.this_cOpers)) + ;
				" AND codbins = " + EscaparSQL(loc_cBin)

			SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFpb")

			IF USED("cursor_4c_SigOpFpb") AND !EOF("cursor_4c_SigOpFpb")
				loc_dIni = ConverterParaData(TratarNulo(cursor_4c_SigOpFpb.datais, CTOD("01/01/1900")))
				loc_dFim = ConverterParaData(TratarNulo(cursor_4c_SigOpFpb.datafs, CTOD("31/12/9999")))

				IF EMPTY(loc_dIni)
					loc_dIni = CTOD("01/01/1900")
				ENDIF
				IF EMPTY(loc_dFim)
					loc_dFim = CTOD("31/12/9999")
				ENDIF

				loc_lValido = BETWEEN(DTOS(DATE()), DTOS(loc_dIni), DTOS(loc_dFim))
			ENDIF

			IF USED("cursor_4c_SigOpFpb")
				USE IN cursor_4c_SigOpFpb
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro ao validar o BIN do cart" + CHR(227) + "o")
		ENDTRY

		RETURN loc_lValido
	ENDFUNC

	*====================================================================
	* Inserir() / Atualizar() / ExecutarExclusao() - este formulario nao
	* grava registro proprio no banco (a transacao e feita pela DLL do
	* SiTef, fora do SQL Server - ver cabecalho deste arquivo); o
	* comportamento padrao herdado de BusinessBase ja eh o correto para
	* este BO, entao esses tres metodos nao sao sobrescritos aqui.
	*====================================================================

ENDDEFINE

