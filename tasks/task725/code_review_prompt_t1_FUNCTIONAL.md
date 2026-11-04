# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (11)
- [METODO-INEXISTENTE] Metodo 'THIS.Caption()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarRetornoTef()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarDigitos()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarBufferData()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarParcelas()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarDataVencimento()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterSenhaSupervisor()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPDTF.Container1): Top original=13 vs migrado 'lbl_4c_Label1' Top=162 (diff=149px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPDTF.Container1): Left original=21 vs migrado 'lbl_4c_Label1' Left=357 (diff=336px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGOPDTF): Top original=199 vs migrado 'obj_4c_Optiongroup1' Top=4 (diff=195px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGOPDTF): Left original=185 vs migrado 'obj_4c_Optiongroup1' Left=5 (diff=180px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopdtf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3699 linhas total):

*-- Linhas 15 a 432:
15: * nesta fase; campos e botao de saida foram acrescentados aqui pela Fase 4).
16: *
17: * FASE 3/8 (Estrutura Base): DEFINE CLASS + propriedades, Init(),
18: * InicializarForm(), ConfigurarPageFrame() (so cabecalho por enquanto),
19: * Destroy(). Campos de captura (GetValor/GetDigitos/GetCartao/GetCodSeg/
20: * Optiongroup1/Text1/GetDatas), botao de saida (SAIDA/CANCELA) e os eventos
21: * de protocolo SiTef entram nas fases seguintes (4-8).
22: *
23: * FASE 5/8 (Campos Principais - Parte 1): NADA A ACRESCENTAR, e esta CERTO.
24: * Esta fase pede "metade dos campos da Page2" - e este legado nao tem Page2
25: * nenhuma: SIGOPDTF eh um dialogo MODAL de CAPTURA (perfil CAPTURA do gate),
26: * que so coleta valores digitados e os devolve ao chamador, sem tabela nem
27: * cursor por tras. Os campos nao moram numa pagina de Dados; moram direto no
28: * Form, e ja foram entregues por INTEIRO (100%, nao 50%) pela Fase 4 em
29: * ConfigurarCampos()/ConfigurarBotaoSaida()/ConfigurarOrdemTabulacao().
30: *
31: * Paridade conferida objeto a objeto contra o dump (SECAO 1 = 26 objetos) e
32: * contra layout.json/mapeamento.json - cobertura TOTAL, sem nada a fazer:
33: *   6 TextBox  : GetValor->txt_4c_Valor, GetDigitos->txt_4c_Digitos,
34: *                GetCartao->txt_4c_Cartao, Text1->txt_4c_Text1,
35: *                GetDatas->txt_4c_Datas, GetCodSeg->txt_4c_Codigo
36: *   1 OptionGroup: Optiongroup1->obj_4c_Optiongroup1 (2 Buttons transcritos)
37: *   1 CommandGroup: SAIDA->obj_4c_SAIDA (Command1/CANCELA)
38: *   2 Container : cntSombra->cnt_4c_Cabecalho, Container1->cnt_4c_Container1
39: *   1 Shape     : Shape2->shp_4c_Shape2
40: *   12 Label    : lblSombra, lblTitulo, Label5, Label2, Label8,
41: *                 Container1.Label1, Label11, Label4, Label6, Label12,
42: *                 Label1 ("0 - Inexistente"), Label3 ("1 - Ilegivel")
43: *
44: * Format/InputMask transcritos conforme a regra #49 (override VAZIO do Form
45: * Designer NAO se transcreve): InputMask entrou em GetValor/GetDigitos/
46: * GetCartao/Text1/GetCodSeg; GetDatas tem InputMask = "" no dump e por isso
47: * NAO recebe InputMask aqui; os cinco Format = "" do dump tambem ficam fora.
48: * Os 7 Label que declaram AutoSize = .T. no dump saem com .AutoSize = .F. +
49: * Width/Height EXPLICITOS do SCX (regra #23 - AutoSize eh no-op em Label
50: * criado por AddObject e, com WordWrap, DESCARTA a Height).
51: * Optiongroup1.Option1.Value = 1 do dump NAO eh transcrito nos Buttons: em
52: * OptionGroup quem guarda a selecao eh o Value do GRUPO (ja .Value = 1) e
53: * ButtonsValue != 0 marcaria todos de uma vez (regra do pattern #108).
54: *
55: * MEDIDO em 2026-10-31 (helpers reais do OrquestradorMigracao.ps1 carregados
56: * por AST, nunca por dot-source): o gate de conteudo da Fase 5 PASSA pelo
57: * ramo CAPTURA - temListaEstritaF5 = False (zero BaseClass grid|pageframe,
58: * e os helpers estritos ListBoxLigaLista/TokenGradeProprioForm/
59: * AddCursorLigaGrade/ControlSourceLigaLista todos False; a UNICA ocorrencia
60: * de ControlSource no dump eh o "OPSENHA" do CommandGroup SAIDA, vestigio da
61: * classe Grupo_Saida que NAO eh prova de lista), temCampoCaptura = True,
62: * apiNos = False, dialogoExibicao = False, legadoCapturaF5 = True, e do lado
63: * migrado 6 TextBox contra um piso de 3 (metade dos 6 do legado).
64: *
65: * O que FORCOU o retry desta fase nao foi o gate, foi o guard de NO-OP, que
66: * roda ANTES dele e usa o predicado do perfil DESPACHANTE
67: * (Test-LegadoSemCampoNemLista = False aqui, porque este legado TEM campos).
68: * Divergencia guard-x-gate ja registrada na memoria do projeto para a Fase 6
69: * (task699/SIGOPCHP) e para a Fase 4 (task699, task715, task717); esta eh a
70: * primeira ocorrencia medida na Fase 5. Nao se conserta no .prg: as duas
71: * unicas formas de "satisfazer" o guard escrevendo codigo seriam inventar
72: * campos que o legado nao tem (viola o PILAR 1) ou criar um
73: * ConfigurarPaginaDados vazio (stub disfarcado, proibido pela regra de
74: * completude). O fix cabe no guard do orquestrador - e nao foi feito agora
75: * porque ha RunLoop VIVO (PID 20544) e 1062 insercoes nao commitadas no
76: * OrquestradorMigracao.ps1, e editar o .ps1 nao valeria para a execucao em
77: * curso (& script.ps1 parseia o arquivo na invocacao).
78: *
79: * FASE 6/8 (Campos Restantes e Lookups) - medido contra o dump completo
80: * (34 metodos/eventos, SECAO 3 inteira lida): ZERO campo restante (Fase 5
81: * ja entregou os 6 TextBox/1 OptionGroup/1 CommandGroup por INTEIRO) e ZERO
82: * lookup (nenhuma ocorrencia de fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/
83: * mAddColuna/CreateObject('fwBusca...) em metodo algum - este dialogo
84: * conversa com o terminal SiTef via DLL, nunca com tabela de lookup.
85: *
86: * Diferente do irmao FormSigOpCtf (cuja Fase 6 transcreveu DOIS Valid
87: * simples e isolados - ValidarDigitos/ValidarCodSeg), aqui NAO HA Valid
88: * isolado para transcrever:
89: *   - GetCodSeg.Valid esta INTEIRO comentado no dump (prefixo "*!*") -
90: *     codigo morto, desligado de proposito pelo legado; nada a transcrever.
91: *   - GetDigitos.Valid, GetDigitos.GotFocus, Text1.Valid, GetDatas.Valid,
92: *     GetDatas.GotFocus e GetCodSeg.LostFocus sao cada um uma VARIANTE do
93: *     MESMO laco interativo com a DLL (PUBLIC ProximoComando/TipoCampo/
94: *     TamanhoMinimo/TamanhoMaximo/Buffer/lnContinua/lnRetorno, declaradas
95: *     no Init legado e lidas/escritas por TODOS esses metodos em conjunto)
96: *     - indivisiveis do SAIDA.CANCELA.Click/ErroTef/RetornoFalha/
97: *     MontaRetorno. Fragmentar esse laco agora geraria ou BINDEVENT para
98: *     metodo inexistente, ou um pedaco de maquina de estado que nao faz
99: *     nada sozinho - o "stub disfarcado" que a regra de completude proibe.
100: *     Confirmado tambem em sigopdtfBO.prg (Fases 1-2): ConectarSiTef/
101: *     IniciarSiTef/ContinuarSiTef/MontarBufferSiTef ja existem no BO,
102: *     prontos para serem CONSUMIDOS pelo laco - mas o laco em si (que
103: *     decide QUANDO chamar cada um) e' o corpo das Fases 7-8, mesmo
104: *     recorte ja usado nos 3 irmaos desta familia (FormSigOpCtf,
105: *     Formsigprdft, FormSIGPRTFH).
106: *
107: * O que SOBRA de genuinamente independente do laco - e por isso ENTRA
108: * nesta fase - e' a familia Optiongroup1/Option1 (InteractiveChange/
109: * Option1.KeyPress/Option1.GotFocus): nenhum dos tres chama a DLL, so
110: * alternam txt_4c_Datas.Enabled/Value. Implementados abaixo
111: * (OptTipoVendaChange/OptTipoVendaBtn1KeyPress/OptTipoVendaBtn1GotFocus),
112: * registrados via BINDEVENT em RegistrarEventosCampos() (chamado por
113: * InicializarForm). Gate reproduzido fielmente: Optiongroup1.When
114: * ("Return(ThisForm.pctvenda)") bloqueia a ENTRADA de foco no grupo
115: * enquanto o protocolo nao libera - BINDEVENT em "When" nao bloqueia nada
116: * (regra CLAUDE.md #3/#47, retorno do delegate descartado), entao o gate
117: * vira guarda no TOPO dos tres handlers, testando THIS.this_lTipoVendaLiberado
118: * (property ja declarada na Fase 3, default .T. - so a Fase 7, ao
119: * implementar GetDatas.GotFocus/"ThisForm.pcTvenda = .f.", vai fecha-la no
120: * momento certo). Nomes e logica identicos ao irmao Formsigprdft
121: * (OptTipoVendaChange/Btn1KeyPress/Btn1GotFocus), que tem o MESMO
122: * Optiongroup1/txt_4c_Datas e ja passou por este mesmo recorte de fases.
123: *
124: * O QUE AINDA NAO ENTRA ATE A FASE 6 (escopo legitimo das Fases 7-8): os
125: * BINDEVENT restantes (GotFocus/LostFocus/Valid de GetValor/GetDigitos/
126: * GetCartao/GetCodSeg/Text1/GetDatas), o Click do CANCELA, o KeyPress de
127: * ESC do Form e o protocolo SiTef propriamente dito
128: * (ContinuaFuncaoSiTefInterativo / ErroTef / RetornoFalha / MontaRetorno).
129: *
130: * FASE 7/8 (Eventos Principais dos Botoes) - entregue: o Click do UNICO
131: * botao do form e o que ele consome.
132: *
133: * Este legado NAO TEM barra CRUD, e isso foi medido no dump, nao presumido:
134: * zero "frmcadastro", zero "frmrelatorio", zero "Grupo_Op", zero
135: * "pcEscolha", zero nome de botao em (btn|cmd|Command)(Incluir|Alterar|
136: * Visualizar|Excluir) e zero "<X>.Click" com verbo CRUD. A superficie de
137: * botao que o dump PROVA existir eh UMA: nenhum objeto com
138: * "BaseClass: commandbutton" e um unico "BaseClass: commandgroup" (SAIDA,
139: * ButtonCount = 1, botao CANCELA). O ButtonCount = 2 que tambem aparece no
140: * dump eh do Optiongroup1 - radio nao eh botao de acao.
141: * Portanto os quatro BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
142: * BtnExcluirClick NAO existem aqui: gera-los exigiria inventar botoes
143: * (viola o PILAR 1) ou criar metodos vazios (proibido pela regra de
144: * completude).
145: *
146: * Entregue nesta fase:
147: *   - BtnCancelarClick()  <- SIGOPDTF.SAIDA.CANCELA.Click (o botao)
148: *   - KeyPress()          <- SIGOPDTF.KeyPress (ESC aciona o mesmo Click)
149: *   - RetornoFalha()      <- SIGOPDTF.retornofalha (consumido pelo Click)
150: *   - ErroTef()           <- SIGOPDTF.errotef (alimenta o RetornoFalha)
151: *   - BINDEVENT do Click em RegistrarEventosCampos()
152: *
153: * O handler leva o prefixo canonico Btn*Click e eh nomeado pela ACAO
154: * (cancelar), nunca pelo objeto legado ("CancelaClick") - ver nota completa
155: * no proprio metodo, junto com a divergencia deliberada Release() -> Hide().
156: *
157: * AINDA FORA (Fase 8): os eventos dos campos de captura e o laco interativo
158: * com a DLL, mais MontaRetorno/Unload/MontarRetornoTef/Move. MontaRetorno
159: * depende de estado que so o laco produz (pcBandeira/lsCartao vem de
160: * Left(Buffer,5), lcSaque do dialogo SigCsTef, lnParcs do Text1.Valid e
161: * ldData do GetDatas.Valid), por isso nao antecipa aqui.
162: *------------------------------------------------------------------------------
163: 
164: DEFINE CLASS Formsigopdtf AS FormBase
165: 
166:     Height      = 370
167:     Width       = 467
168:     AutoCenter  = .T.
169:     BorderStyle = 2
170:     *-- ShowWindow/WindowType nascem 0 DE PROPOSITO e sao restaurados para o
171:     *-- modal top-level do SCX legado no Init, fora de modo de teste (ver nota
172:     *-- la). Havia aqui uma segunda atribuicao "ShowWindow = 1" logo abaixo,
173:     *-- remanescente de fase anterior: como a ULTIMA vence, a classe nascia
174:     *-- top-level e o form travava o VFP9 headless (-T) no probe desta fase,
175:     *-- exatamente o que o Init diz estar evitando.
176:     ShowWindow  = 0
177:     ShowWindow = 1
178:     ControlBox  = .F.
179:     Closable    = .F.
180:     FontName    = "Tahoma"
181:     FontSize    = 8
182:     MaxButton   = .F.
183:     MinButton   = .F.
184:     TitleBar    = 0
185:     WindowType  = 0
186:     KeyPreview  = .T.
187:     Themes      = .F.
188:     AlwaysOnTop = .T.
189: 
190:     this_oBusinessObject = .NULL.
191: 
192:     *-- Parametros recebidos na criacao (migrado de SIGOPDTF.Init PARAMETERS) -
193:     *-- guardados no Form ate InicializarForm() transferir para o BO.
194:     this_cEndSiTef = ""
195:     this_nValPago  = 0
196:     this_cCupom    = ""
197:     this_cCaixa    = ""
198:     this_cTipPagto = ""
199:     this_nNumParcs = 1
200:     this_cIdent    = ""
201:     this_cOpers    = ""
202:     this_lKeyEsc   = .T.        && ThisForm.pckeyesc (legado) - habilita ESC para cancelar
203: 
204:     *-- DebCred (parametro legado) eh CHARACTER ("P"=Prazo / "D"=Debito /
205:     *-- "C"=Credito - ver SIGOPDTF.GetDigitos.Valid/GotFocus, que comparam
206:     *-- lsDebCred com esses literais), NUNCA logico. O BO (sigopdtfBO, Fase 1)
207:     *-- declara this_lDebCred como LOGICAL mas nunca o le em metodo algum -
208:     *-- property morta por enquanto. Guardado aqui como character, fiel ao
209:     *-- parametro original, para as fases de evento (7-8) que implementam o
210:     *-- protocolo leem o valor real sem depender daquela property.
211:     this_cDebCred = ""
212: 
213:     *-- ThisForm.abandona (legado - declarada em RESERVED3/ClassInfo do SCX).
214:     *-- O dump NUNCA a atribui: nasce .F. e so eh LIDA, em GetDigitos.Valid
215:     *-- ("IF tHISfORM.abandona / Thisform.release"). Quem liga a flag eh o
216:     *-- chamador externo que abriu o dialogo, para derrubar a transacao em
217:     *-- curso.
218:     this_lAbandona = .F.
219: 
220:     *-- pctvenda (property do SCX legado, default .T.). Unico consumidor:
221:     *-- Optiongroup1.When ("Return(ThisForm.pctvenda)"), que BLOQUEIA a
222:     *-- entrada de foco no grupo Tipo de Venda ate o protocolo liberar.
223:     this_lTipoVendaLiberado = .T.
224: 
225:     *-- lnParcs / ldData do legado: variaveis PUBLIC declaradas no
226:     *-- SIGOPDTF.Init e lidas so no Unload (retorno da tela). Nao podem ser
227:     *-- lidas dos controles no lugar delas (mesmo criterio do irmao
228:     *-- Formsigprdft) - moram aqui e sao alimentadas nos mesmos pontos do
229:     *-- legado quando os campos de captura forem ligados (fases seguintes).
230:     this_cParcelasTef = ""
231:     this_dDataTef     = {}
232: 
233:     *-- Guarda de reentrancia dos lacos do protocolo (FASE 8/8). Os lacos
234:     *-- exibem dialogo MODAL (ExibirMensagemTef) e desabilitam campos, o que
235:     *-- tira e devolve o foco - e isso REDISPARA o LostFocus/GotFocus que
236:     *-- chamou o laco, empilhando uma segunda conversa com o terminal sobre a
237:     *-- primeira (regras #37/#47). Com um unico PIN-pad do outro lado, a
238:     *-- segunda conversa consome a resposta da primeira e a transacao sai
239:     *-- embaralhada - sem erro na tela.
240:     this_lEmProtocolo = .F.
241: 
242:     *-- Espelho do RETURN do SIGOPDTF.Unload para o chamador que abre esta
243:     *-- tela por CREATEOBJECT + Show() (padrao do projeto). Preenchida no
244:     *-- Destroy quando o calculo do retorno (MontarRetornoTef) existir.
245:     this_cRetornoTef = ""
246: 
247:     *--------------------------------------------------------------------------
248:     * Init - recebe os parametros da transacao (migrado de SIGOPDTF.Init
249:     * PARAMETERS EndSiTef, ValPago, Cupom, Caixa, DebCred, TipPagto, NumParcs,
250:     * lcIdent, pcOpers) e define Caption com CHR() antes de delegar ao FormBase
251:     *--------------------------------------------------------------------------
252:     PROCEDURE Init()
253:         LPARAMETERS par_cEndSiTef, par_nValPago, par_cCupom, par_cCaixa, ;
254:                     par_cDebCred, par_cTipPagto, par_nNumParcs, par_cIdent, par_cOpers
255: 
256:         THIS.Caption = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
257: 
258:         THIS.this_cEndSiTef = IIF(VARTYPE(par_cEndSiTef) = "C", par_cEndSiTef, "")
259:         THIS.this_nValPago  = IIF(VARTYPE(par_nValPago) = "N", par_nValPago, 0)
260:         THIS.this_cCupom    = IIF(VARTYPE(par_cCupom) $ "NC", TRANSFORM(par_cCupom, "@L 999999"), "000000")
261:         THIS.this_cCaixa    = IIF(VARTYPE(par_cCaixa) = "C", par_cCaixa, "")
262:         THIS.this_cDebCred  = IIF(VARTYPE(par_cDebCred) = "C", par_cDebCred, "")
263:         THIS.this_cTipPagto = IIF(VARTYPE(par_cTipPagto) = "C", par_cTipPagto, "")
264:         THIS.this_nNumParcs = IIF(VARTYPE(par_nNumParcs) = "N", par_nNumParcs, 1)
265:         THIS.this_cIdent    = IIF(VARTYPE(par_cIdent) $ "NC", TRANSFORM(par_cIdent), "")
266:         THIS.this_cOpers    = IIF(VARTYPE(par_cOpers) = "C", par_cOpers, "")
267: 
268:         *-- ShowWindow=1/WindowType=1 na classe causaria TIMEOUT em VFP9 -T
269:         *-- (top-level window bloqueante) em modo de teste automatizado.
270:         *-- Classe definida com ShowWindow=0/WindowType=0; producao restaura
271:         *-- o modal top-level aqui (SCX legado: WindowType = 1).
272:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
273:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
274:             THIS.WindowType = 1
275:             THIS.ShowWindow = 1
276:         ENDIF
277:         RETURN DODEFAULT()
278:     ENDPROC
279: 
280:     *--------------------------------------------------------------------------
281:     * KeyPress - ESC cancela a transacao. Migrado de SIGOPDTF.KeyPress, INTEIRO:
282:     *     LPARAMETERS nKeyCode, nShiftAltCtrl
283:     *     If nKeyCode = 27 And  nShiftAltCtrl = 0 And ThisForm.pcKeyEsc
284:     *         NoDefault
285:     *         ThisForm.SAIDA.CANCELA.Click
286:     *     Endif
287:     *
288:     * KeyPreview = .T. na classe (transcrito do SCX) garante que este evento do
289:     * FORM dispara ANTES dos controles filhos processarem a tecla - sem ele o
290:     * ESC seria consumido pelo TextBox em foco e o cancelamento nunca chegaria.
291:     * "ThisForm.SAIDA.CANCELA.Click" vira a chamada direta a THIS.BtnCancelarClick()
292:     * (o handler do Click daquele botao - ver nota de nomenclatura la).
293:     * Sem DODEFAULT: FormBase nao define KeyPress, e nao marcar NODEFAULT fora
294:     * do ramo do ESC eh exatamente o que deixa as outras teclas seguirem o
295:     * caminho normal, como no legado.
296:     *--------------------------------------------------------------------------
297:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
298:         IF par_nKeyCode = 27 AND par_nShiftAltCtrl = 0 AND THIS.this_lKeyEsc
299:             NODEFAULT
300:             THIS.BtnCancelarClick()
301:         ENDIF
302:     ENDPROC
303: 
304:     *--------------------------------------------------------------------------
305:     * InicializarForm - cria o Business Object e monta a estrutura visual base
306:     *--------------------------------------------------------------------------
307:     PROTECTED PROCEDURE InicializarForm()
308:         LOCAL loc_lSucesso, loc_oErro
309:         loc_lSucesso = .F.
310: 
311:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
312:             RETURN .T.
313:         ENDIF
314: 
315:         TRY
316:             THIS.this_oBusinessObject = CREATEOBJECT("sigopdtfBO")
317:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
318:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigopdtfBO.", ;
319:                         "Erro em InicializarForm")
320:                 loc_lSucesso = .F.
321:             ELSE
322:                 THIS.ConfigurarPageFrame()
323:                 THIS.RegistrarEventosCampos()
324:                 THIS.TornarControlesVisiveis(THIS)
325: 
326:                 *-- Transfere os parametros recebidos no Init para o BO e monta
327:                 *-- o identificador de terminal (migrado de SIGOPDTF.Init WITH
328:                 *-- Thisform / .poDatamgr.SqlExecute ...). Pulado em modo de
329:                 *-- teste headless (sem gnConnHandle real).
330:                 IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
331:                     THIS.this_oBusinessObject.this_cEndSiTef = THIS.this_cEndSiTef
332:                     THIS.this_oBusinessObject.this_nValPago  = THIS.this_nValPago
333:                     THIS.this_oBusinessObject.this_cCupom    = THIS.this_cCupom
334:                     THIS.this_oBusinessObject.this_cCaixa    = THIS.this_cCaixa
335:                     THIS.this_oBusinessObject.this_cTipPagto = THIS.this_cTipPagto
336:                     THIS.this_oBusinessObject.this_nNumParcs = THIS.this_nNumParcs
337:                     THIS.this_oBusinessObject.this_cIdent    = THIS.this_cIdent
338:                     THIS.this_oBusinessObject.this_cOpers    = THIS.this_cOpers
339: 
340:                     THIS.this_oBusinessObject.CarregarIdentificacaoTerminal()
341: 
342:                     *-- FASE 8/8: le a forma de pagamento (crSigOpFp do Init
343:                     *-- legado). TEM de vir ANTES de ConfigurarValoresIniciais,
344:                     *-- que decide a legenda e o estado inicial dos campos a
345:                     *-- partir de lCartao, e antes de qualquer laco do
346:                     *-- protocolo, que consulta Garantias/lSaque/Tcdc/Dias/
347:                     *-- MesFec em cada pergunta do terminal.
348:                     THIS.this_oBusinessObject.CarregarConfiguracaoPagamento()
349:                 ENDIF
350: 
351:                 *-- FASE 8/8: WITH Thisform do final do SIGOPDTF.Init (valores
352:                 *-- iniciais dos campos). Fora do IF de modo de teste de
353:                 *-- proposito: nao toca no banco, so na tela, e eh o que faz o
354:                 *-- dialogo abrir com valor/data/parcelas preenchidos.
355:                 THIS.ConfigurarValoresIniciais()
356: 
357:                 loc_lSucesso = .T.
358:             ENDIF
359:         CATCH TO loc_oErro
360:             MsgErro(loc_oErro.Message + CHR(13) + ;
361:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
362:                     "Procedure: " + loc_oErro.Procedure, ;
363:                     "Erro em InicializarForm")
364:         ENDTRY
365: 
366:         RETURN loc_lSucesso
367:     ENDPROC
368: 
369:     *--------------------------------------------------------------------------
370:     * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
371:     * Nao ha PageFrame real (form legado nao tem Lista/Dados como CRUD - ver
372:     * analise.json temGrid=false e layout.json sem BaseClass pageframe/grid):
373:     * SIGOPDTF eh um dialogo modal de captura de pagamento. Por enquanto so
374:     * o cabecalho eh montado; ConfigurarCampos()/ConfigurarBotaoSaida() serao
375:     * acrescentados aqui pelas fases seguintes (4-8), que tambem ligam os
376:     * eventos de protocolo SiTef.
377:     *--------------------------------------------------------------------------
378:     PROTECTED PROCEDURE ConfigurarPageFrame()
379:         THIS.ConfigurarCabecalho()
380:         THIS.ConfigurarCampos()
381:         THIS.ConfigurarBotaoSaida()
382:         THIS.ConfigurarOrdemTabulacao()
383:     ENDPROC
384: 
385:     *--------------------------------------------------------------------------
386:     * ConfigurarCabecalho - cria container escuro superior com labels de
387:     * titulo (migrado de SIGOPDTF.cntSombra/lblSombra/lblTitulo). Caption dos
388:     * labels espelha THIS.Caption (definido dinamicamente no Init), nao o
389:     * texto estatico "Cadastro de Testes" gravado no SCX (placeholder de
390:     * template de framework, sobrescrito em runtime pelo legado).
391:     *--------------------------------------------------------------------------
392:     PROTECTED PROCEDURE ConfigurarCabecalho()
393:         LOCAL loc_oCab
394: 
395:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
396:         loc_oCab = THIS.cnt_4c_Cabecalho
397:         WITH loc_oCab
398:             .Top         = 0
399:             .Left        = 0
400:             .Width       = THIS.Width
401:             .Height      = 80
402:             .BackColor   = RGB(100,100,100)
403:             .BackStyle   = 1
404:             .BorderWidth = 0
405:         ENDWITH
406: 
407:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
408:         WITH loc_oCab.lbl_4c_Sombra
409:             .AutoSize      = .F.
410:             .Width         = loc_oCab.Width - 10
411:             .Height        = 40
412:             .Top           = 18
413:             .Left          = 10
414:             .FontName      = "Tahoma"
415:             .FontSize      = 18
416:             .FontBold      = .T.
417:             .FontUnderline = .F.
418:             .Alignment     = 0
419:             .BackStyle     = 0
420:             .WordWrap      = .T.
421:             .ForeColor     = RGB(0,0,0)
422:             .Caption       = THIS.Caption
423:         ENDWITH
424: 
425:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
426:         WITH loc_oCab.lbl_4c_Titulo
427:             .AutoSize      = .F.
428:             .Width         = loc_oCab.Width - 10
429:             .Height        = 46
430:             .Top           = 17
431:             .Left          = 10
432:             .FontName      = "Tahoma"

*-- Linhas 447 a 494:
447:     * PageFrame - controles filhos de THIS, Top/Left transcritos EXATOS do
448:     * dump SIGOPDTF, sem compensacao +29 porque nao ha PageFrame.Top=-29
449:     * aqui). Migrado de: SIGOPDTF.Shape2/Label5/GetValor/Label2/GetDigitos/
450:     * Label8/Container1(.Label1)/GetCartao/Label11/Label4/Optiongroup1/
451:     * Label6/Text1/GetDatas/GetCodSeg/Label12/Label1("0 - Inexistente")/
452:     * Label3("1 - Ilegivel").
453:     *--------------------------------------------------------------------------
454:     PROTECTED PROCEDURE ConfigurarCampos()
455:         LOCAL loc_oCnt
456: 
457:         *-- Shape2 - moldura decorativa ao redor dos campos
458:         THIS.AddObject("shp_4c_Shape2", "Shape")
459:         WITH THIS.shp_4c_Shape2
460:             .Top           = 92
461:             .Left          = 0
462:             .Width         = 466
463:             .Height        = 202
464:             .BackStyle     = 1
465:             .BorderStyle   = 1
466:             .SpecialEffect = 0
467:         ENDWITH
468: 
469:         *-- Label5 "VALOR :" + txt_4c_Valor (GetValor)
470:         THIS.AddObject("lbl_4c_Label5", "Label")
471:         WITH THIS.lbl_4c_Label5
472:             .AutoSize  = .F.
473:             .Alignment = 0
474:             .Top       = 101
475:             .Left      = 138
476:             .Width     = 45
477:             .Height    = 15
478:             .FontName  = "Tahoma"
479:             .FontSize  = 8
480:             .FontBold  = .T.
481:             .ForeColor = RGB(90,90,90)
482:             .BackStyle = 0
483:             .Caption   = "VALOR :"
484:         ENDWITH
485: 
486:         *-- SCX nao sobrescreve Enabled aqui (nasce .T.) - o campo e protegido
487:         *-- de digitacao pelo GetValor.When = "Return .f." (bloqueia foco),
488:         *-- nao por Enabled=.F. (fases de evento, 6-8).
489:         THIS.AddObject("txt_4c_Valor", "TextBox")
490:         WITH THIS.txt_4c_Valor
491:             .Top               = 98
492:             .Left              = 185
493:             .Width             = 100
494:             .Height            = 23

*-- Linhas 627 a 688:
627:             .DisabledForeColor = RGB(0,0,0)
628:         ENDWITH
629: 
630:         *-- Label4 "TIPO DE VENDA :" + obj_4c_Optiongroup1
631:         THIS.AddObject("lbl_4c_Label4", "Label")
632:         WITH THIS.lbl_4c_Label4
633:             .AutoSize  = .F.
634:             .Alignment = 0
635:             .Top       = 203
636:             .Left      = 92
637:             .Width     = 91
638:             .Height    = 15
639:             .FontName  = "Tahoma"
640:             .FontSize  = 8
641:             .FontBold  = .T.
642:             .ForeColor = RGB(90,90,90)
643:             .BackStyle = 0
644:             .Caption   = "TIPO DE VENDA :"
645:         ENDWITH
646: 
647:         THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
648:         WITH THIS.obj_4c_Optiongroup1
649:             .ButtonCount = 2
650:             .Top         = 199
651:             .Left        = 185
652:             .Width       = 161
653:             .Height      = 26
654:             .Enabled     = .T.
655:             .Value       = 1
656: 
657:             WITH .Buttons(1)
658:                 .Caption  = " A vista"
659:                 .Top      = 4
660:                 .Left     = 5
661:                 .Width    = 61
662:                 .Height   = 17
663:                 .FontName = "Tahoma"
664:                 .FontSize = 8
665:                 .FontBold = .T.
666:             ENDWITH
667: 
668:             WITH .Buttons(2)
669:                 .Caption  = " Predatado"
670:                 .Top      = 5
671:                 .Left     = 73
672:                 .Width    = 80
673:                 .Height   = 17
674:                 .FontName = "Tahoma"
675:                 .FontSize = 8
676:                 .FontBold = .T.
677:             ENDWITH
678:         ENDWITH
679: 
680:         *-- Label6 "No PARCELAS :" + txt_4c_Text1 (Text1)
681:         THIS.AddObject("lbl_4c_Label6", "Label")
682:         WITH THIS.lbl_4c_Label6
683:             .AutoSize  = .F.
684:             .Alignment = 0
685:             .Top       = 237
686:             .Left      = 102
687:             .Width     = 81
688:             .Height    = 15

*-- Linhas 788 a 940:
788:     * do dump NAO transcrito - artefato de template do Form Designer sem
789:     * campo correspondente (grupo tem 1 unico botao, nao ha o que refletir).
790:     *--------------------------------------------------------------------------
791:     PROTECTED PROCEDURE ConfigurarBotaoSaida()
792:         THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
793:         WITH THIS.obj_4c_SAIDA
794:             .ButtonCount = 1
795:             .Top         = -2
796:             .Left        = 387
797:             .Width       = 85
798:             .Height      = 85
799:             .BorderStyle = 0
800:             *-- SCX legado: SAIDA.BackStyle = 0 (transparente). CommandGroup TEM
801:             *-- BackStyle - sem esta linha o grupo nasce opaco (default 1) e
802:             *-- pinta um retangulo branco sobre a faixa cinza do cabecalho.
803:             .BackStyle   = 0
804:             .Value       = 0
805: 
806:             WITH .Buttons(1)
807:                 .Top        = 5
808:                 .Left       = 5
809:                 .Width      = 75
810:                 .Height     = 75
811:                 .FontName   = "Comic Sans MS"
812:                 .FontSize   = 8
813:                 .FontBold   = .T.
814:                 .FontItalic = .T.
815:                 .Cancel     = .F.
816:                 .Caption    = "\<Cancelar"
817:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
818:                 .ForeColor  = RGB(90,90,90)
819:                 .BackColor  = RGB(255,255,255)
820:                 .Themes     = .F.
821:             ENDWITH
822:         ENDWITH
823:     ENDPROC
824: 
825:     *--------------------------------------------------------------------------
826:     * ConfigurarOrdemTabulacao - reproduz a ordem de tabulacao do SCX legado
827:     * (TabIndex: GetValor=1, GetCartao=2, GetDigitos=3, GetCodSeg=4,
828:     * Optiongroup1=7, Text1=11, GetDatas=13, SAIDA=17 - demais TabIndex sao
829:     * de Labels, que nao tem TabStop e por isso nao entram aqui, mesmo
830:     * criterio da regra ja aplicada em Formsigprdft.ConfigurarOrdemTabulacao).
831:     *--------------------------------------------------------------------------
832:     PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
833:         THIS.txt_4c_Valor.TabIndex        = 1    && SCX: GetValor      TabIndex=1
834:         THIS.txt_4c_Cartao.TabIndex       = 2    && SCX: GetCartao     TabIndex=2
835:         THIS.txt_4c_Digitos.TabIndex      = 3    && SCX: GetDigitos    TabIndex=3
836:         THIS.txt_4c_Codigo.TabIndex       = 4    && SCX: GetCodSeg     TabIndex=4
837:         THIS.obj_4c_Optiongroup1.TabIndex = 5    && SCX: Optiongroup1  TabIndex=7
838:         THIS.txt_4c_Text1.TabIndex        = 6    && SCX: Text1         TabIndex=11
839:         THIS.txt_4c_Datas.TabIndex        = 7    && SCX: GetDatas      TabIndex=13
840:         THIS.obj_4c_SAIDA.TabIndex        = 8    && SCX: SAIDA         TabIndex=17
841:     ENDPROC
842: 
843:     *--------------------------------------------------------------------------
844:     * ConfigurarValoresIniciais - FASE 8/8. Migrado do trecho final do
845:     * SIGOPDTF.Init que nenhuma fase anterior tinha coberto (as Fases 3-7
846:     * trataram parametros, layout e eventos; estes sao os VALORES):
847:     *
848:     *     ThisForm.GetDigitos.BackColor = 12632256
849:     *     WITH Thisform
850:     *         .GetDatas.Value = DATE()
851:     *         .GetValor.Value = lnValPago
852:     *         IF crSigOpFp.lCartao = "S"
853:     *             .GetCartao.Enabled = .t.
854:     *             .Label2.Caption    = "Validade Cartao :"
855:     *         EndIf
856:     *     Endwith
857:     *     ThisForm.Container1.Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
858:     *     IF !Thisform.getDatas.Enabled
859:     *         IF crSigOpFp.lCartao = "N"
860:     *             ...Caption = "Insira ou Passe"  + CHR(13) + "o Cartao"
861:     *         ELSE
862:     *             ...Caption = "Digite o Numero"  + CHR(13) + "do Cartao"
863:     *         EndIf
864:     *     EndIf
865:     *     ThisForm.Text1.Value = TRANSFORM(lnNumParcs, "@L 99")
866:     *     ThisForm.GetValor.SetFocus
867:     *
868:     * O BackColor cinza do GetDigitos eh SINALIZACAO de "campo aguardando o
869:     * terminal": o legado o pinta de 12632256 = RGB(192,192,192) na abertura e
870:     * o devolve para 16777215 = RGB(255,255,255) no fim do DigitosGotFocus,
871:     * quando o campo passa a aceitar digitacao. Note que isso SOBREPOE o
872:     * BackColor 212,208,200 que o SCX declara no controle (e que a Fase 4
873:     * transcreveu certo) - os dois existem, em momentos diferentes.
874:     *
875:     * lnParcs/ldData/lcSaque/DCD do Init legado tambem sao semeados aqui -
876:     * sao as variaveis PUBLIC que alimentam o retorno da tela (Unload).
877:     *
878:     * DUAS DIVERGENCIAS DELIBERADAS, as duas por causa do GetValor.When
879:     * ("Return .f.", transcrito no dump), que torna o campo INALCANCAVEL pelo
880:     * foco - o valor eh so exibicao, o usuario nunca digita nele:
881:     *
882:     *   1. ".ReadOnly = .T. / .TabStop = .F." no lugar do When. BINDEVENT em
883:     *      "When" nao bloqueia nada (o retorno do delegate eh descartado -
884:     *      regra #3/#47), entao sem estas duas linhas o campo migrado ficaria
885:     *      EDITAVEL e o operador poderia alterar o valor da transacao na tela
886:     *      antes de o protocolo comecar. Reproduz o efeito observavel do
887:     *      legado, nao a mecanica dele.
888:     *   2. O "GetValor.SetFocus" NAO eh transcrito. Medido no VFP9: SetFocus
889:     *      em TextBox com TabStop = .F. nao move o foco, e em campo cujo When
890:     *      devolve .F. o legado tambem nao movia - a linha sempre foi inocua.
891:     *      Chamar SetFocus aqui, com o form ainda invisivel (InicializarForm
892:     *      roda dentro do Init, antes do Show), estouraria
893:     *      "Cannot SetFocus to an invisible or disabled object".
894:     *
895:     * O "ThisForm.Caption" e o "Thisform.ZOrder(0)" do mesmo trecho legado
896:     * tambem ficam fora: o Caption ja eh definido no Init (Fase 3, com CHR()),
897:     * e o ZOrder(0) servia para trazer a janela a frente no desktop MDI do
898:     * legado - aqui a classe ja tem AlwaysOnTop = .T. (transcrito do SCX).
899:     *--------------------------------------------------------------------------
900:     PROTECTED PROCEDURE ConfigurarValoresIniciais()
901:         LOCAL loc_oBO, loc_lCartao
902: 
903:         loc_oBO = THIS.this_oBusinessObject
904: 
905:         *-- lCartao = "S" na forma de pagamento. Sem BO (modo de validacao de
906:         *-- UI) assume o default .F. da property, que eh o ramo "N" do legado.
907:         loc_lCartao = .F.
908:         IF VARTYPE(loc_oBO) = "O"
909:             loc_lCartao = loc_oBO.this_lOpFpCartao
910:         ENDIF
911: 
912:         *-- Cinza de "aguardando o terminal" (12632256 = RGB(192,192,192)).
913:         THIS.txt_4c_Digitos.BackColor = RGB(192,192,192)
914: 
915:         THIS.txt_4c_Datas.Value = DATE()
916:         THIS.txt_4c_Valor.Value = THIS.this_nValPago
917: 
918:         *-- GetValor.When = "Return .f." no legado (ver nota acima).
919:         THIS.txt_4c_Valor.ReadOnly = .T.
920:         THIS.txt_4c_Valor.TabStop  = .F.
921: 
922:         IF loc_lCartao
923:             THIS.txt_4c_Cartao.Enabled = .T.
924:             THIS.lbl_4c_Label2.Caption = "Validade Cartao :"
925:         ENDIF
926: 
927:         *-- O legado atribui a legenda, depois a REATRIBUI dentro do
928:         *-- "IF !getDatas.Enabled". Como o SCX declara GetDatas.Enabled = .F.
929:         *-- (e a Fase 4 transcreveu), esse IF eh SEMPRE verdadeiro na abertura
930:         *-- e quem decide eh o ramo interno - transcrito nessa ordem.
931:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
932:         IF !THIS.txt_4c_Datas.Enabled
933:             IF !loc_lCartao
934:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
935:             ELSE
936:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "do Cartao"
937:             ENDIF
938:         ENDIF
939: 
940:         *-- lnParcs do legado (mascara "@L 99"), espelhado no campo e na

*-- Linhas 952 a 1107:
952:     ENDPROC
953: 
954:     *--------------------------------------------------------------------------
955:     * RegistrarEventosCampos - BINDEVENT dos eventos de campo que NAO
956:     * dependem do laco interativo com a DLL (ver nota da FASE 6/8 no
957:     * cabecalho). Migrado de SIGOPDTF.Optiongroup1 (InteractiveChange) e
958:     * SIGOPDTF.Optiongroup1.Option1 (KeyPress/GotFocus), mais o Click do
959:     * UNICO botao do form (SIGOPDTF.SAIDA.CANCELA.Click), acrescentado pela
960:     * Fase 7. Os campos restantes (GetValor/GetDigitos/GetCartao/GetCodSeg/
961:     * Text1/GetDatas) entram na Fase 8, junto com o laco interativo que os
962:     * governa.
963:     *
964:     * O Click vai no Buttons(1), nao no CommandGroup: o grupo SAIDA tem
965:     * ButtonCount = 1 e eh o BOTAO que o legado nomeia (CANCELA) e cujo
966:     * Click o dump declara.
967:     *--------------------------------------------------------------------------
968:     PROTECTED PROCEDURE RegistrarEventosCampos()
969:         BINDEVENT(THIS.obj_4c_Optiongroup1, "InteractiveChange", THIS, "OptTipoVendaChange")
970:         BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "KeyPress", THIS, "OptTipoVendaBtn1KeyPress")
971:         BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "GotFocus", THIS, "OptTipoVendaBtn1GotFocus")
972: 
973:         BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnCancelarClick")
974: 
975:         *-- FASE 8/8: os campos de captura e o laco interativo com a DLL.
976:         *
977:         * POR QUE O "Valid" DO LEGADO VIRA "KeyPress" AQUI: BINDEVENT em
978:         * "Valid" NAO dispara em TextBox (regra do CLAUDE.md), entao o Valid
979:         * eh simulado no KeyPress testando ENTER (13) / TAB (9) - o mesmo
980:         * recorte dos irmaos Formsigprdft/FormSigOpCtf. Nao confundir com a
981:         * regra #47 (lookup NUNCA em KeyPress): ali o defeito eh abrir um
982:         * PICKER a cada tecla; aqui o handler testa a tecla no topo e so
983:         * entao conversa com o terminal, que eh exatamente o que a regra
984:         * manda fazer quando se usa KeyPress.
985:         *
986:         * GetCodSeg eh a EXCECAO e fica em "LostFocus" de verdade: no legado o
987:         * protocolo dele mora no PROPRIO LostFocus (nao no Valid, que esta
988:         * inteiro comentado no dump), e LostFocus dispara por BINDEVENT sem
989:         * problema. Como esse laco abre dialogo modal, ele leva guarda de
990:         * reentrancia (this_lEmProtocolo) - ver o metodo.
991:         *
992:         * GotFocus de GetDigitos/GetDatas carrega os dois lacos MAIORES
993:         * (conexao+inicio da transacao e confirmacao da data), fiel ao legado,
994:         * que de proposito dispara a conversa com o terminal ao campo receber
995:         * o foco, nao ao perde-lo.
996:         BINDEVENT(THIS.txt_4c_Digitos, "GotFocus",  THIS, "DigitosGotFocus")
997:         BINDEVENT(THIS.txt_4c_Digitos, "KeyPress",  THIS, "DigitosKeyPress")
998:         BINDEVENT(THIS.txt_4c_Digitos, "LostFocus", THIS, "DigitosLostFocus")
999: 
1000:         BINDEVENT(THIS.txt_4c_Text1, "GotFocus",  THIS, "Text1GotFocus")
1001:         BINDEVENT(THIS.txt_4c_Text1, "KeyPress",  THIS, "Text1KeyPress")
1002:         BINDEVENT(THIS.txt_4c_Text1, "LostFocus", THIS, "Text1LostFocus")
1003: 
1004:         BINDEVENT(THIS.txt_4c_Datas, "GotFocus",  THIS, "DatasGotFocus")
1005:         BINDEVENT(THIS.txt_4c_Datas, "KeyPress",  THIS, "DatasKeyPress")
1006:         BINDEVENT(THIS.txt_4c_Datas, "LostFocus", THIS, "DatasLostFocus")
1007: 
1008:         BINDEVENT(THIS.txt_4c_Codigo, "GotFocus",  THIS, "CodSegGotFocus")
1009:         BINDEVENT(THIS.txt_4c_Codigo, "LostFocus", THIS, "CodSegLostFocus")
1010:     ENDPROC
1011: 
1012:     *--------------------------------------------------------------------------
1013:     * OptTipoVendaChange - migrado de SIGOPDTF.Optiongroup1.InteractiveChange:
1014:     *     ThisForm.getDatas.Enabled=.t.
1015:     *     IF This.Value = 1
1016:     *         ThisForm.getdatas.Value=DATE()
1017:     *     ELSE
1018:     *         ThisForm.getdatas.Value=ctod("")
1019:     *     Endif
1020:     *
1021:     * Gate no topo = SIGOPDTF.Optiongroup1.When ("Return(ThisForm.pctvenda)"):
1022:     * BINDEVENT em "When" nao bloqueia nada (regra CLAUDE.md #3/#47 - o
1023:     * retorno do delegate e descartado), entao o bloqueio de foco do legado
1024:     * vira guarda de saida antecipada aqui. THIS.this_lTipoVendaLiberado
1025:     * (declarada na Fase 3, default .T.) so sera fechada pela Fase 7 ao
1026:     * migrar GetDatas.GotFocus ("ThisForm.pcTvenda = .f.") - mesmo recorte
1027:     * do irmao Formsigprdft.OptTipoVendaChange. PUBLIC: exigido por
1028:     * BINDEVENT (regra CLAUDE.md #3).
1029:     *--------------------------------------------------------------------------
1030:     PROCEDURE OptTipoVendaChange()
1031:         IF !THIS.this_lTipoVendaLiberado
1032:             RETURN
1033:         ENDIF
1034: 
1035:         THIS.txt_4c_Datas.Enabled = .T.
1036:         IF THIS.obj_4c_Optiongroup1.Value = 1
1037:             THIS.txt_4c_Datas.Value = DATE()
1038:         ELSE
1039:             THIS.txt_4c_Datas.Value = {}
1040:         ENDIF
1041:     ENDPROC
1042: 
1043:     *--------------------------------------------------------------------------
1044:     * OptTipoVendaBtn1KeyPress - migrado de
1045:     * SIGOPDTF.Optiongroup1.Option1.KeyPress:
1046:     *     LPARAMETERS nKeyCode, nShiftAltCtrl
1047:     *     IF nKeyCode = 13
1048:     *         KEYBOARD '{TAB}'
1049:     *     Endif
1050:     * PUBLIC: exigido por BINDEVENT.
1051:     *--------------------------------------------------------------------------
1052:     PROCEDURE OptTipoVendaBtn1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1053:         IF !THIS.this_lTipoVendaLiberado
1054:             RETURN
1055:         ENDIF
1056: 
1057:         IF par_nKeyCode = 13
1058:             KEYBOARD "{TAB}"
1059:         ENDIF
1060:     ENDPROC
1061: 
1062:     *--------------------------------------------------------------------------
1063:     * OptTipoVendaBtn1GotFocus - migrado de
1064:     * SIGOPDTF.Optiongroup1.Option1.GotFocus: "ThisForm.getDatas.Enabled=.t.".
1065:     * PUBLIC: exigido por BINDEVENT.
1066:     *--------------------------------------------------------------------------
1067:     PROCEDURE OptTipoVendaBtn1GotFocus()
1068:         IF !THIS.this_lTipoVendaLiberado
1069:             RETURN
1070:         ENDIF
1071: 
1072:         THIS.txt_4c_Datas.Enabled = .T.
1073:     ENDPROC
1074: 
1075:     *==========================================================================
1076:     * EVENTOS PRINCIPAIS DOS BOTOES (FASE 7/8)
1077:     *
1078:     * Este form tem UM BOTAO SO: o SCX legado declara apenas o CommandGroup
1079:     * SAIDA (ButtonCount = 1, botao CANCELA, Caption "\<Cancelar"). Nao ha
1080:     * barra CRUD a migrar - o legado herda de `form` (nao de `frmcadastro`),
1081:     * nao tem Grupo_Op, nao tem pcEscolha e nao declara botao Incluir/Alterar/
1082:     * Visualizar/Excluir em lugar nenhum do dump (conferido por grep: zero
1083:     * ocorrencia das quatro grafias e zero "<X>.Click"). Gerar os quatro
1084:     * BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
1085:     * exigiria INVENTAR botoes que o legado nao tem, violando o PILAR 1.
1086:     *
1087:     * Junto com o Click vem os dois metodos que ele CONSOME: RetornoFalha
1088:     * (grava o arquivo de resposta que o PDV le) e ErroTef (traduz o codigo
1089:     * de erro do protocolo para a mensagem que RetornoFalha gravara).
1090:     *==========================================================================
1091: 
1092:     *--------------------------------------------------------------------------
1093:     * ErroTef - migrado de SIGOPDTF.errotef (PARAMETERS pnRetornos). Traduz os
1094:     * codigos fixos de falha do protocolo interativo na mensagem gravada no
1095:     * arquivo de resposta. Os cinco IF abaixo sao transcricao literal, na
1096:     * mesma ordem e com os MESMOS textos (sem acento no legado - sao gravados
1097:     * no IntPos.001 lido pelo software do PDV, nao exibidos na tela, entao
1098:     * "corrigir" a grafia mudaria o conteudo do arquivo).
1099:     *
1100:     * O legado passa "0,00" como valor nos cinco casos, e NAO o valor da
1101:     * transacao: em caminho de ERRO o campo 003-000 sai zerado de proposito.
1102:     * Quem passa o valor real eh so o Click do Cancelar. Transcrito assim.
1103:     *
1104:     * O PRIMEIRO bloco do errotef legado NAO eh transcrito, e o motivo foi
1105:     * MEDIDO no VFP9 em 2026-10-31 (probe descartavel, resultado abaixo):
1106:     *
1107:     *     If Type("lnRetorno") <> "N" and (lnRetorno > -1 Or lnRetorno < -5)

*-- Linhas 1124 a 1550:
1124:     * de fidelidade. Preservado o desfecho real: nao dispara.
1125:     *
1126:     * PUBLIC: consumido pelo laco interativo (Fase 8), que roda fora desta
1127:     * classe quando delegado por BINDEVENT.
1128:     *--------------------------------------------------------------------------
1129:     PROCEDURE ErroTef(par_nRetornos)
1130:         IF par_nRetornos = -1
1131:             THIS.RetornoFalha("Modulo Nao Iniciado", "0,00")
1132:         ENDIF
1133:         IF par_nRetornos = -2
1134:             THIS.RetornoFalha("Operacao Cancelada pelo Usuario", "0,00")
1135:         ENDIF
1136:         IF par_nRetornos = -3
1137:             THIS.RetornoFalha("Fornecida uma Modalidade Invalida", "0,00")
1138:         ENDIF
1139:         IF par_nRetornos = -4
1140:             THIS.RetornoFalha("Falta Memoria para Rodar a Funcao", "0,00")
1141:         ENDIF
1142:         IF par_nRetornos = -5
1143:             THIS.RetornoFalha("Sem Comunicacao com o SiTef", "0,00")
1144:         ENDIF
1145:     ENDPROC
1146: 
1147:     *--------------------------------------------------------------------------
1148:     * RetornoFalha - migrado de SIGOPDTF.retornofalha (PARAMETERS lcMensagem,
1149:     * lnValPago). Monta o cursor local crSiTef (buffer de protocolo) e grava
1150:     * os dois arquivos SDF que o software de retaguarda / PDV le
1151:     * (C:\client\Resp\IntPos.001 e IntPos.STS). Nenhuma tabela do SQL Server
1152:     * eh tocada aqui - o INSERT eh todo em cursor de memoria.
1153:     *
1154:     * A assinatura mantem os DOIS parametros do legado porque os dois call
1155:     * sites passam valores DIFERENTES e isso muda o arquivo gravado:
1156:     * ErroTef passa "0,00" (CARACTERE) e o Click do Cancelar passa o valor
1157:     * numerico da transacao. Medido no VFP9 em 2026-10-31
1158:     * (probe descartavel) que a formula do legado atende os dois tipos
1159:     * sem ramificar, e por isso ela eh transcrita LITERALMENTE:
1160:     *     TRANSFORM("0,00",  "99999999999.99") -> "0,00"    (passa direto)
1161:     *     TRANSFORM(1234.56, "99999999999.99") -> "1234,56" (apos o STRTRAN)
1162:     * O IIF de VARTYPE abaixo NAO eh ramo de formato: eh guarda para o
1163:     * parametro AUSENTE, que chegaria como .F. logico e faria o TRANSFORM
1164:     * estourar. Os dois call sites reais nunca caem nela.
1165:     *
1166:     * "001-000" usa STR(VAL(this_cIdent), 10) porque o legado faz
1167:     * STR(ltIdent, 10) sobre o identificador recebido no Init, que aqui eh
1168:     * guardado como CARACTERE (this_cIdent).
1169:     *
1170:     * Pasta C:\client\Resp ausente (maquina de desenvolvimento/teste sem a
1171:     * integracao fiscal instalada) -> a grava eh pulada antes do TRY, sem
1172:     * quebrar o cancelamento. O RETURN fica FORA de TRY/CATCH (regra #1).
1173:     *
1174:     * PUBLIC: chamado por ErroTef, pelo Click do Cancelar e pelo laco
1175:     * interativo (Fase 8).
1176:     *--------------------------------------------------------------------------
1177:     PROCEDURE RetornoFalha(par_cMensagem, par_uValPago)
1178:         LOCAL loc_cMensagem, loc_uValPago, loc_cValPago, loc_oErro
1179: 
1180:         loc_cMensagem = IIF(EMPTY(par_cMensagem), ;
1181:             "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usuario", par_cMensagem)
1182: 
1183:         loc_uValPago = IIF(VARTYPE(par_uValPago) $ "CN", par_uValPago, 0)
1184:         loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(loc_uValPago, "99999999999.99")), ".", ",")
1185: 
1186:         IF !DIRECTORY("C:\client\Resp", 1)
1187:             RETURN
1188:         ENDIF
1189: 
1190:         TRY
1191:             IF USED("crSiTef")
1192:                 USE IN crSiTef
1193:             ENDIF
1194:             CREATE CURSOR crSiTef (tef c(100))
1195: 
1196:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1197:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
1198:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
1199:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
1200:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
1201:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
1202:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
1203:             INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
1204:             INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + ;
1205:                 IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
1206:             INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
1207:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1208: 
1209:             SELECT crSiTef
1210:             COPY TO C:\client\Resp\IntPos.001 SDF
1211:             ZAP
1212: 
1213:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1214:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
1215:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1216: 
1217:             COPY TO C:\client\Resp\IntPos.STS SDF
1218: 
1219:             USE IN crSiTef
1220:         CATCH TO loc_oErro
1221:             MsgErro(loc_oErro.Message + CHR(13) + ;
1222:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1223:                     "Procedure: " + loc_oErro.Procedure, ;
1224:                     "Erro ao gravar retorno SiTef")
1225:         ENDTRY
1226:     ENDPROC
1227: 
1228:     *--------------------------------------------------------------------------
1229:     * BtnCancelarClick - migrado de SIGOPDTF.SAIDA.CANCELA.Click, INTEIRO:
1230:     *     lnRetorno=ContinuaFuncaoSiTefInterativo(@ProximoComando, @TipoCampo,
1231:     *               @TamanhoMinimo, @TamanhoMaximo, @Buffer, Len(Buffer), -1)
1232:     *     ThisForm.RetornoFalha("Oper. Cancelada pelo Usuario(1)",lnValPago)
1233:     *     Thisform.release
1234:     *
1235:     * O -1 na ultima posicao eh o codigo de ABORTO do protocolo: avisa o
1236:     * terminal SiTef de que a operacao em curso foi cancelada pelo operador,
1237:     * ANTES de gravar o arquivo de resposta. A chamada por referencia esta
1238:     * encapsulada em sigopdtfBO.ContinuarSiTef (Fase 2), que preserva os
1239:     * quatro parametros @ de estado do protocolo.
1240:     *
1241:     * NOME: prefixo canonico Btn*Click, nomeado pela ACAO (cancelar a
1242:     * transacao e fechar a tela), nao pelo objeto legado - "CancelaClick"
1243:     * herdaria o nome do SCX, o que viola o PILAR 3 e deixa o handler
1244:     * invisivel para as convencoes do projeto.
1245:     *
1246:     * FECHA COM Hide(), NAO COM Release(), apesar do "Thisform.release" do
1247:     * legado - e esta eh uma divergencia DELIBERADA de PILAR 3 (tempo de vida
1248:     * do objeto), nao de PILAR 1 (para o usuario a tela fecha igual, porque
1249:     * Hide() em form modal tambem devolve o Show()). Motivo: no VFP9 o
1250:     * Release() de um form DESTROI o objeto mesmo havendo variavel externa
1251:     * apontando para ele, e este dialogo existe para DEVOLVER o resultado da
1252:     * transacao TEF. O legado entrega esse resultado pelo RETURN do evento
1253:     * Unload, que so chega a quem abre com "DO FORM ... TO <var>"; o sistema
1254:     * novo abre por CREATEOBJECT + Show(), onde aquele RETURN eh inalcancavel
1255:     * e o resultado tem de ser lido da property this_cRetornoTef (declarada
1256:     * na Fase 3 exatamente para isso). Com Release() aqui, o objeto morreria
1257:     * neste Click e a leitura seguinte do chamador estouraria "is not an
1258:     * object" - erro que apareceria LONGE da causa. O chamador libera o
1259:     * dialogo depois de ler, que eh o contrato que o projeto ja adota em
1260:     * FormBuscaAuxiliar.
1261:     *
1262:     * ATENCAO para a Fase 8: ao implementar Unload/MontarRetornoTef, o calculo
1263:     * de this_cRetornoTef tem de ser gravado ANTES deste Hide() (o Destroy
1264:     * passa a rodar apenas quando o chamador liberar, tarde demais para quem
1265:     * le o valor logo apos o Show()).
1266:     *
1267:     * PUBLIC: alvo de BINDEVENT (regra #3) e chamado tambem pelo KeyPress do
1268:     * ESC, reproduzindo o "ThisForm.SAIDA.CANCELA.Click" do legado.
1269:     *--------------------------------------------------------------------------
1270:     PROCEDURE BtnCancelarClick()
1271:         LOCAL loc_oBO
1272: 
1273:         loc_oBO = THIS.this_oBusinessObject
1274: 
1275:         *-- Guarda sem equivalente no legado: em modo de validacao de UI o
1276:         *-- InicializarForm sai antes de criar o BO (this_oBusinessObject
1277:         *-- fica .NULL.) e a chamada a DLL estouraria. Em producao o BO
1278:         *-- sempre existe, entao o caminho do legado eh preservado integral.
1279:         IF VARTYPE(loc_oBO) = "O"
1280:             loc_oBO.ContinuarSiTef(-1)
1281:             loc_oBO.this_lCancelado = .T.
1282:             THIS.RetornoFalha("Oper. Cancelada pelo Usuario(1)", loc_oBO.this_nValPago)
1283:         ELSE
1284:             THIS.RetornoFalha("Oper. Cancelada pelo Usuario(1)", THIS.this_nValPago)
1285:         ENDIF
1286: 
1287:         *-- FASE 8/8: cumprindo a exigencia que esta nota deixou escrita - o
1288:         *-- this_cRetornoTef eh calculado ANTES de a tela fechar. EncerrarDialogo
1289:         *-- faz as duas coisas (calcula e esconde) e eh o ponto unico de saida
1290:         *-- usado tambem pelos cinco lacos do protocolo.
1291:         THIS.EncerrarDialogo()
1292:     ENDPROC
1293: 
1294:     *==========================================================================
1295:     * EVENTOS AUXILIARES E CONSOLIDACAO FINAL (FASE 8/8)
1296:     *
1297:     * O que entra aqui eh o LACO INTERATIVO com o terminal SiTef - a razao de
1298:     * existir desta tela - mais os hooks de transferencia e o retorno ao
1299:     * chamador. As Fases 3-7 entregaram parametros, layout, os eventos do
1300:     * Optiongroup e o Click do unico botao; o protocolo ficou para esta fase
1301:     * de proposito, porque eh indivisivel: GetDigitos.Valid/GotFocus,
1302:     * Text1.Valid, GetDatas.Valid/GotFocus e GetCodSeg.LostFocus sao cinco
1303:     * VARIANTES do mesmo dialogo com a DLL, compartilhando o MESMO estado
1304:     * (ProximoComando/TipoCampo/Buffer/lnContinua, que o legado mantinha em
1305:     * variaveis PUBLIC e que aqui vivem no BO).
1306:     *
1307:     * TRES SUBSTITUICOES DE DIALOGO FILHO, todas por ausencia no acervo (os
1308:     * .SCX nao vieram) e todas FALANDO EM VOZ ALTA em vez de silenciar - no
1309:     * caminho de dinheiro, ausencia muda eh pior que ausencia visivel
1310:     * (mesmo critrio da regra #27 sobre wrapper de funcao legada):
1311:     *   - SigTfDss (mensagem de erro do protocolo) -> ExibirMensagemTef, que
1312:     *     eh substituicao FIEL: o dialogo legado so exibia texto.
1313:     *   - SigCsTef (valor do saque)        -> avisa e assume "0,00".
1314:     *   - SigPrStf (senha do supervisor)   -> avisa e CANCELA a transacao,
1315:     *     que eh o proprio ramo do legado para senha em branco.
1316:     *   - SigCoCDC (consulta CDC)          -> avisa; o RetornoFalha que o
1317:     *     legado grava em seguida eh preservado.
1318:     *
1319:     * "Thisform.release" e "RELEASE WINDOWS" do legado viram
1320:     * THIS.EncerrarDialogo() - ver a nota de tempo de vida no proprio metodo
1321:     * e no BtnCancelarClick da Fase 7.
1322:     *==========================================================================
1323: 
1324:     *--------------------------------------------------------------------------
1325:     * ExibirMensagemTef - substitui
1326:     *     DO Form SigTfDss With <titulo>,"",<msg1>,<msg2>,"","VM",Left,Top
1327:     * O SIGTFDSS.scx nao faz parte do acervo migrado; era um dialogo que so
1328:     * EXIBIA as duas linhas de texto (o "VM" eh o esquema de cor), entao
1329:     * MsgAviso eh substituicao fiel. MsgAviso e nao MsgErro de proposito: sao
1330:     * mensagens de PROTOCOLO devolvidas pelo terminal ("Cartao Invalido",
1331:     * "Senha Incorreta"), nao falhas tecnicas do sistema - e MsgErro exibe o
1332:     * botao "Fechar Aplicacao", que aqui seria desastroso no meio de uma
1333:     * transacao com o PIN-pad.
1334:     *--------------------------------------------------------------------------
1335:     PROTECTED PROCEDURE ExibirMensagemTef(par_cTitulo, par_cMsg1, par_cMsg2)
1336:         LOCAL loc_cMsg
1337: 
1338:         loc_cMsg = ALLTRIM(IIF(VARTYPE(par_cMsg1) = "C", par_cMsg1, ""))
1339:         IF VARTYPE(par_cMsg2) = "C" AND !EMPTY(par_cMsg2)
1340:             loc_cMsg = loc_cMsg + CHR(13) + ALLTRIM(par_cMsg2)
1341:         ENDIF
1342:         IF EMPTY(loc_cMsg)
1343:             loc_cMsg = "Falha na comunica" + CHR(231) + CHR(227) + "o com o terminal."
1344:         ENDIF
1345: 
1346:         MsgAviso(loc_cMsg, IIF(VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo), ;
1347:             par_cTitulo, "Transa" + CHR(231) + CHR(227) + "o"))
1348:     ENDPROC
1349: 
1350:     *--------------------------------------------------------------------------
1351:     * EncerrarDialogo - ponto UNICO de saida da tela, substituindo os
1352:     * "Thisform.release" e "RELEASE WINDOWS" espalhados pelos lacos do legado
1353:     * (23 ocorrencias no dump).
1354:     *
1355:     * Cumpre a exigencia que a Fase 7 deixou escrita no BtnCancelarClick:
1356:     * this_cRetornoTef eh calculado ANTES de a tela fechar. O motivo esta la
1357:     * por extenso - em VFP9 o Release() destroi o objeto mesmo havendo
1358:     * referencia externa viva, e esta tela existe para DEVOLVER o resultado da
1359:     * transacao ao chamador, que no sistema novo abre por CREATEOBJECT + Show()
1360:     * e le a property (o RETURN do Unload legado so chega a quem usa
1361:     * "DO FORM ... TO <var>"). Fechar com Hide() mantem o objeto vivo e a
1362:     * property legivel; quem abriu libera depois de ler, mesmo contrato do
1363:     * FormBuscaAuxiliar.
1364:     *
1365:     * Idempotente de proposito: varios ramos do legado chamam release em
1366:     * sequencia (ErroTef seguido de release, por exemplo), e o laco continua
1367:     * executando as linhas seguintes depois disso. Recalcular o retorno a cada
1368:     * chamada sobrescreveria com estado mais pobre o valor montado no primeiro
1369:     * encerramento - por isso so calcula quando ainda esta vazio.
1370:     *--------------------------------------------------------------------------
1371:     PROCEDURE EncerrarDialogo()
1372:         IF EMPTY(THIS.this_cRetornoTef)
1373:             THIS.this_cRetornoTef = THIS.MontarRetornoTef()
1374:         ENDIF
1375:         THIS.Hide()
1376:     ENDPROC
1377: 
1378:     *--------------------------------------------------------------------------
1379:     * ValidarDigitos - cabeca do SIGOPDTF.GetDigitos.Valid, antes do laco:
1380:     *     IF tHISfORM.abandona
1381:     *         Thisform.release
1382:     *     eNDIF
1383:     *     IF LEN(Alltrim(This.Value)) <> 4 .and. ! EMPTY(This.Value)
1384:     *         DO Form SigTfDss With "Erro na Transacao","","Quantidade de Digitos Invalida",...
1385:     *         This.Value = ""
1386:     *         Return(.f.)
1387:     *     ENDIF
1388:     *     IF EMPTY(This.Value)
1389:     *         RETURN
1390:     *     Endif
1391:     *
1392:     * Devolve .T. somente quando o laco deve rodar. Os dois ramos de saida do
1393:     * legado devolvem .F. por motivos DIFERENTES e os dois tem de parar o
1394:     * laco: "abandona" (o chamador derrubou a transacao) encerra a tela;
1395:     * quantidade de digitos errada avisa e limpa o campo; campo VAZIO apenas
1396:     * nao faz nada - este ultimo eh o caminho normal quando o foco passa pelo
1397:     * campo sem o usuario digitar, e por isso NAO avisa nada.
1398:     * PUBLIC: consumido pelo handler de KeyPress, que eh alvo de BINDEVENT.
1399:     *--------------------------------------------------------------------------
1400:     FUNCTION ValidarDigitos()
1401:         LOCAL loc_lProsseguir, loc_cValor
1402: 
1403:         loc_lProsseguir = .F.
1404: 
1405:         DO CASE
1406:         CASE THIS.this_lAbandona
1407:             THIS.EncerrarDialogo()
1408:         OTHERWISE
1409:             loc_cValor = ALLTRIM(THIS.txt_4c_Digitos.Value)
1410:             DO CASE
1411:             CASE LEN(loc_cValor) != 4 AND !EMPTY(loc_cValor)
1412:                 THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
1413:                     "Quantidade de Digitos Invalida", "")
1414:                 THIS.txt_4c_Digitos.Value = ""
1415:             CASE EMPTY(loc_cValor)
1416:                 *-- Caminho normal: o foco passou pelo campo sem digitacao.
1417:             OTHERWISE
1418:                 loc_lProsseguir = .T.
1419:             ENDCASE
1420:         ENDCASE
1421: 
1422:         RETURN loc_lProsseguir
1423:     ENDFUNC
1424: 
1425:     *--------------------------------------------------------------------------
1426:     * DigitosGotFocus - migrado de SIGOPDTF.GetDigitos.GotFocus, o PRIMEIRO e
1427:     * maior laco do protocolo: eh ele que CONFIGURA a conexao com o servidor
1428:     * SiTef, INICIA a transacao e conduz a leitura do cartao.
1429:     *
1430:     * O laco do legado eh "DO WHILE llContinua", e llContinua nasce de
1431:     *     llContinua = IIF(crSigOpFp.lCartao = "N", .t., .f.)
1432:     * e NUNCA eh alterado dentro do laco - todas as saidas sao EXIT. Ou seja:
1433:     * quando a forma de pagamento NAO aceita cartao digitado (lCartao = "N"),
1434:     * a conversa com o terminal acontece aqui; quando aceita, o laco nao roda
1435:     * nenhuma vez e a conversa fica para os outros campos. Transcrito como
1436:     * esta - trocar por um laco que sempre roda inverteria o fluxo da tela.
1437:     *
1438:     * O identificador de terminal NAO eh recalculado aqui, embora o legado o
1439:     * remonte a cada GotFocus (lcIdTerminal = fConverteStr(CrSigCdEmp.nEmps) +
1440:     * TRANSFORM(VAL(crSigFiMpF.Cncaixas), "@L 999999")): no sistema novo isso
1441:     * eh CarregarIdentificacaoTerminal(), ja executado pelo InicializarForm, e
1442:     * suas duas entradas (empresa corrente e caixa recebido no Init) nao mudam
1443:     * durante a vida do dialogo. Repetir faria duas consultas SQL a cada
1444:     * passagem de foco, sem alterar o resultado.
1445:     *
1446:     * GUARDA DE REENTRANCIA (this_lEmProtocolo): sem equivalente no legado,
1447:     * obrigatoria aqui. O laco exibe dialogo MODAL e mexe em .Enabled dos
1448:     * campos; as duas coisas tiram e devolvem o foco, e isso REDISPARA este
1449:     * mesmo GotFocus (regras #37/#47). Com um unico PIN-pad do outro lado, a
1450:     * segunda conversa consumiria as respostas da primeira. A flag eh liberada
1451:     * no fim de um corpo sem RETURN antecipado: o corpo real esta em
1452:     * DigitosGotFocusExec(), e este wrapper garante a liberacao mesmo quando
1453:     * aquele sai no meio (padrao imune a RETURN da regra #47).
1454:     * PUBLIC: alvo de BINDEVENT.
1455:     *--------------------------------------------------------------------------
1456:     PROCEDURE DigitosGotFocus()
1457:         IF THIS.this_lEmProtocolo
1458:             RETURN
1459:         ENDIF
1460: 
1461:         *-- SIGOPDTF.GetDigitos.When: "If Empty(This.Value) / Set Confirm Off /
1462:         *-- Endif / Return(EMPTY(This.Value))". BINDEVENT nao alcanca "When"
1463:         *-- (regra #3), entao o SET CONFIRM OFF vem para ca, com a mesma
1464:         *-- condicao. O RETURN do When - que impedia ENTRAR no campo depois de
1465:         *-- preenchido - eh reproduzido pelas transicoes de .Enabled que o
1466:         *-- proprio protocolo faz (DigitosKeyPress termina com
1467:         *-- txt_4c_Digitos.Enabled = .F.), nao por uma guarda inventada aqui.
1468:         IF EMPTY(ALLTRIM(THIS.txt_4c_Digitos.Value))
1469:             SET CONFIRM OFF
1470:         ENDIF
1471: 
1472:         THIS.this_lEmProtocolo = .T.
1473:         THIS.DigitosGotFocusExec()
1474:         THIS.this_lEmProtocolo = .F.
1475:     ENDPROC
1476: 
1477:     *--------------------------------------------------------------------------
1478:     * DigitosKeyPress - migrado de SIGOPDTF.GetDigitos.Valid (o SEGUNDO laco:
1479:     * envia os 4 ultimos digitos do cartao e conduz senha/parcelamento ate o
1480:     * terminal liberar a data de vencimento ou o codigo de seguranca).
1481:     *
1482:     * Ligado a "KeyPress" porque BINDEVENT em "Valid" nao dispara em TextBox
1483:     * (ver nota em RegistrarEventosCampos): o Valid eh simulado testando
1484:     * ENTER (13) / TAB (9) no topo - as duas teclas com que o usuario sai do
1485:     * campo. A cabeca do Valid legado esta em ValidarDigitos().
1486:     *
1487:     * Guarda de reentrancia pelo mesmo motivo do GotFocus; corpo separado em
1488:     * DigitosKeyPressExec() porque ele tem RETURN antecipado (padrao imune a
1489:     * RETURN da regra #47 - set/clear simples deixaria a flag presa ligada e
1490:     * MATARIA o campo pelo resto da vida do form).
1491:     * PUBLIC: alvo de BINDEVENT.
1492:     *--------------------------------------------------------------------------
1493:     PROCEDURE DigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1494:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1495:             RETURN
1496:         ENDIF
1497:         IF THIS.this_lEmProtocolo
1498:             RETURN
1499:         ENDIF
1500: 
1501:         THIS.this_lEmProtocolo = .T.
1502:         THIS.DigitosKeyPressExec()
1503:         THIS.this_lEmProtocolo = .F.
1504:     ENDPROC
1505: 
1506:     *--------------------------------------------------------------------------
1507:     * DigitosKeyPressExec - corpo do laco acima (ver nota de reentrancia).
1508:     * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
1509:     *--------------------------------------------------------------------------
1510:     PROCEDURE DigitosKeyPressExec()
1511:         LOCAL loc_oBO, loc_nRetorno, loc_lParcelas, loc_nCampo, loc_cBuf, loc_cValor
1512: 
1513:         IF !THIS.ValidarDigitos()
1514:             RETURN
1515:         ENDIF
1516: 
1517:         loc_oBO = THIS.this_oBusinessObject
1518:         IF VARTYPE(loc_oBO) != "O"
1519:             RETURN
1520:         ENDIF
1521: 
1522:         loc_cValor    = ALLTRIM(THIS.txt_4c_Digitos.Value)
1523:         loc_lParcelas = .F.
1524:         loc_nCampo    = 1
1525:         loc_nRetorno  = 10000
1526: 
1527:         loc_oBO.this_cMensagemRetorno = ""
1528:         loc_oBO.MontarBufferSiTef(loc_cValor)
1529:         loc_oBO.this_nContinua = 1000
1530: 
1531:         DO WHILE loc_nRetorno = 10000
1532:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1533:             loc_cBuf     = loc_oBO.this_cBuffer
1534: 
1535:             IF LASTKEY() = 27
1536:                 loc_oBO.ContinuarSiTef(-1)
1537:                 THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
1538:                     loc_oBO.this_nValPago)
1539:                 THIS.EncerrarDialogo()
1540:                 RETURN
1541:             ENDIF
1542: 
1543:             IF loc_oBO.this_nProximoComando = 20 AND ;
1544:                UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
1545:                 loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
1546:                 LOOP
1547:             ENDIF
1548: 
1549:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1550: 

*-- Linhas 1574 a 1617:
1574:                     *-- libera o campo de parcelas. Transcrito assim.
1575:                     IF loc_lParcelas
1576:                         THIS.txt_4c_Text1.Enabled        = .T.
1577:                         THIS.obj_4c_Optiongroup1.Enabled = .F.
1578:                         *-- Legado: "This.Value=.f." - atribuir LOGICO a um
1579:                         *-- TextBox cujo Value eh CARACTERE (.Value = "" na
1580:                         *-- criacao) troca o tipo do controle e faz o
1581:                         *-- ALLTRIM seguinte estourar. Limpa com "" , que eh o
1582:                         *-- efeito pretendido (apagar os digitos digitados).
1583:                         THIS.txt_4c_Digitos.Value = ""
1584:                     ENDIF
1585:                     RETURN
1586:                 ENDIF
1587:             ENDIF
1588: 
1589:             IF loc_oBO.this_nProximoComando = 21
1590:                 loc_oBO.this_cBuffer = IIF(loc_oBO.this_nNumParcs = 1, ;
1591:                     IIF(ConverterParaData(THIS.txt_4c_Datas.Value) = DATE(), "1", "2"), ;
1592:                     IIF(THIS.this_cDebCred = "P", "3", "4")) + REPLICATE(CHR(0), 1999)
1593:                 *-- Legado: "IF Buffer = '1'". Com SET EXACT OFF (default) a
1594:                 *-- comparacao eh por PREFIXO, e o Buffer sempre comeca pelo
1595:                 *-- digito escolhido - ou seja o teste eh "o digito eh 1?".
1596:                 *-- Escrito aqui sobre o 1o caractere para nao depender do
1597:                 *-- estado de SET EXACT, que o config.prg deixa em ON
1598:                 *-- (ON faria o IF nunca casar e o EXIT nunca acontecer).
1599:                 IF LEFT(loc_oBO.this_cBuffer, 1) = "1"
1600:                     EXIT
1601:                 ENDIF
1602:                 loc_oBO.this_nContinua = 1000
1603:                 LOOP
1604:             ENDIF
1605: 
1606:             IF loc_oBO.this_nProximoComando = 23
1607:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1608:             ENDIF
1609: 
1610:             IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 510
1611:                 IF loc_oBO.this_lOpFpGarantias
1612:                     loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
1613:                 ELSE
1614:                     loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
1615:                 ENDIF
1616:                 loc_oBO.this_nContinua = 1000
1617:             ENDIF

*-- Linhas 1716 a 1800:
1716:                 *-- nao portado (SIGCOCDC.scx fora do acervo). O RetornoFalha
1717:                 *-- que o legado grava em seguida eh preservado, entao o PDV
1718:                 *-- recebe o mesmo arquivo de resposta de antes.
1719:                 MsgAviso("Consulta CDC (SigCoCDC) n" + CHR(227) + "o portada nesta migra" + ;
1720:                     CHR(231) + CHR(227) + "o." + CHR(13) + ;
1721:                     "Cupom retornado pelo terminal: " + ALLTRIM(loc_oBO.this_cCupomRetorno), ;
1722:                     "Consulta CDC")
1723:                 THIS.RetornoFalha("Consulta CDC Realizada", loc_oBO.this_nValPago)
1724:             ELSE
1725:                 IF loc_nRetorno = 0
1726:                     THIS.MontaRetorno(loc_oBO.this_cTipTran, loc_oBO.this_cDataHora, ;
1727:                         loc_oBO.this_cCupomRetorno, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
1728:                         loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, loc_oBO.this_nValPago, ;
1729:                         loc_oBO.this_cMensagemRetorno)
1730:                 ENDIF
1731:             ENDIF
1732:             THIS.EncerrarDialogo()
1733:             RETURN
1734:         ENDIF
1735: 
1736:         IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
1737:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
1738:         ELSE
1739:             IF THIS.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada
1740:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
1741:                 THIS.obj_4c_Optiongroup1.Enabled = .T.
1742:                 THIS.txt_4c_Datas.Enabled        = .T.
1743:             ELSE
1744:                 THIS.obj_4c_Optiongroup1.Enabled = .F.
1745:             ENDIF
1746:         ENDIF
1747: 
1748:         *-- As duas ultimas linhas do Valid legado, nesta ordem: o campo de
1749:         *-- digitos sai de cena e o grupo Tipo de Venda eh reaberto. A segunda
1750:         *-- SOBREPOE o "Optiongroup1.Enabled = .F." do ELSE acima - esta no
1751:         *-- legado assim e eh o que o usuario ve.
1752:         THIS.txt_4c_Digitos.Enabled      = .F.
1753:         THIS.obj_4c_Optiongroup1.Enabled = .T.
1754:     ENDPROC
1755: 
1756:     *--------------------------------------------------------------------------
1757:     * DigitosGotFocusExec - corpo do laco acima (ver nota de reentrancia).
1758:     * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
1759:     *--------------------------------------------------------------------------
1760:     PROCEDURE DigitosGotFocusExec()
1761:         LOCAL loc_oBO, loc_nRetorno, loc_cData, loc_cHora, loc_lContinua, ;
1762:               loc_nTipo, loc_lTipoVenda, loc_nTipoVenda, loc_cBandeira, loc_cBuf
1763: 
1764:         loc_oBO = THIS.this_oBusinessObject
1765:         IF VARTYPE(loc_oBO) != "O"
1766:             RETURN
1767:         ENDIF
1768: 
1769:         *-- ConfiguraIntSiTefInterativo(lsEndSitef, lsIdTerminal, lcIdTerminal, 0) <> 0
1770:         IF !loc_oBO.ConectarSiTef()
1771:             THIS.RetornoFalha("Sem comunicacao com SiTef", loc_oBO.this_nValPago)
1772:             THIS.EncerrarDialogo()
1773:             RETURN
1774:         ENDIF
1775: 
1776:         *-- lcData = Str(Year(Date()),4) + Substr(Dtoc(Date()),4,2) + Substr(Dtoc(Date()),1,2)
1777:         *-- lchora = Strtran(Time(),":","")
1778:         loc_cData = STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
1779:         loc_cHora = STRTRAN(TIME(), ":", "")
1780: 
1781:         *-- IniciaFuncaoSiTefInterativo(0, lcValPago, lsCupom, lcData, lcHora, lsCaixa, "") <> 10000
1782:         IF !loc_oBO.IniciarSiTef(loc_cData, loc_cHora)
1783:             THIS.RetornoFalha("Sem comunicacao com SiTef", loc_oBO.this_nValPago)
1784:             THIS.EncerrarDialogo()
1785:             RETURN
1786:         ENDIF
1787: 
1788:         *-- Reset do estado do protocolo (as 6 PUBLIC do legado).
1789:         loc_oBO.this_nProximoComando = 0
1790:         loc_oBO.this_nTipoCampo      = 0
1791:         loc_oBO.this_nTamanhoMinimo  = 0
1792:         loc_oBO.this_nTamanhoMaximo  = 0
1793:         loc_oBO.this_cBuffer         = SPACE(2000)
1794:         loc_oBO.this_nContinua       = 0
1795: 
1796:         loc_oBO.this_cFinaliza        = ""
1797:         loc_oBO.this_cMensagemRetorno = ""
1798:         loc_oBO.this_cNsu             = ""
1799: 
1800:         loc_nTipo      = 1

*-- Linhas 1806 a 1849:
1806:         *-- llContinua = IIF(crSigOpFp.lCartao = "N", .t., .f.) - ver nota.
1807:         loc_lContinua = !loc_oBO.this_lOpFpCartao
1808: 
1809:         THIS.obj_4c_Optiongroup1.Enabled = .F.
1810: 
1811:         DO WHILE loc_lContinua
1812:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1813:             loc_cBuf     = loc_oBO.this_cBuffer
1814: 
1815:             IF LASTKEY() = 27
1816:                 loc_oBO.ContinuarSiTef(-1)
1817:                 THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
1818:                     loc_oBO.this_nValPago)
1819:                 THIS.EncerrarDialogo()
1820:                 RETURN
1821:             ENDIF
1822: 
1823:             IF "SELECIONE A FORMA DE PAGAMENTO PAGAMENTO" $ UPPER(loc_cBuf)
1824:                 IF loc_nTipoVenda = 2
1825:                     loc_lTipoVenda = .T.
1826:                 ELSE
1827:                     loc_nTipoVenda = 2
1828:                 ENDIF
1829:             ENDIF
1830: 
1831:             IF loc_oBO.this_nProximoComando = 20 AND ;
1832:                UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
1833:                 loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
1834:                 LOOP
1835:             ENDIF
1836: 
1837:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1838: 
1839:             IF loc_oBO.this_nProximoComando = 22
1840:                 IF LEN(ALLTRIM(loc_cBuf)) != 0
1841:                     THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
1842:                         ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))
1843:                     loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1844:                     loc_nRetorno = -1
1845:                     EXIT
1846:                 ENDIF
1847:             ENDIF
1848: 
1849:             IF UPPER(ALLTRIM(loc_cBuf)) = "DIGITE A SENHA"

*-- Linhas 2048 a 2262:
2048:             IF !THIS.txt_4c_Text1.Enabled
2049:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Informe o Tipo" + CHR(13) + "da Venda"
2050:                 THIS.txt_4c_Digitos.Enabled      = .F.
2051:                 THIS.obj_4c_Optiongroup1.Enabled = .T.
2052:                 THIS.txt_4c_Datas.Enabled        = .T.
2053:                 *-- O legado faz "Optiongroup1.Option1.SetFocus". Em VFP9 o
2054:                 *-- foco de OptionGroup vai no grupo (ele mesmo roteia para o
2055:                 *-- botao marcado) e SetFocus num Buttons(N) de grupo recem
2056:                 *-- habilitado falha quando o form ainda nao esta visivel.
2057:                 IF THIS.obj_4c_Optiongroup1.Visible AND THIS.obj_4c_Optiongroup1.Enabled
2058:                     THIS.obj_4c_Optiongroup1.SetFocus()
2059:                 ENDIF
2060:             ENDIF
2061:         ELSE
2062:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4 Ultimos" + CHR(13) + "Digitos do Cartao"
2063:             THIS.obj_4c_Optiongroup1.Enabled = .T.
2064:         ENDIF
2065: 
2066:         THIS.obj_4c_SAIDA.Enabled = .T.
2067:     ENDPROC
2068: 
2069:     *--------------------------------------------------------------------------
2070:     * MontarBufferData - o legado repete SEIS vezes, em quatro metodos, a
2071:     * mesma conversao da data de vencimento para o formato DDMMAAAA que o
2072:     * terminal espera:
2073:     *     lcData = DTOC(ThisForm.GetDatas.Value)
2074:     *     Buffer = ALLTRIM(SUBSTR(lcData,1,2)) + ALLTRIM(SUBSTR(lcData,4,2)) +
2075:     *              ALLTRIM(SUBSTR(lcData,7,4)) + REPLICATE(CHR(0), 1992)
2076:     * Centralizado num metodo so (FONTE UNICA - seis copias divergiriam em
2077:     * silencio na primeira mudanca). Devolve SO os 8 digitos; o complemento de
2078:     * CHR(0) fica em cada call site, porque o legado usa tamanhos diferentes.
2079:     *
2080:     * DTOC depende de SET DATE/CENTURY. A classe roda sob o SET DATE BRITISH +
2081:     * SET CENTURY ON que o FormBase.Init estabelece (regra #9.4), onde DTOC
2082:     * devolve DD/MM/AAAA - os offsets 1,2 / 4,2 / 7,4 do legado pressupoem
2083:     * exatamente isso. Por isso o recorte eh feito sobre DTOC e nao sobre uma
2084:     * reconstrucao com DAY/MONTH/YEAR: manter o mesmo pressuposto, visivel.
2085:     *--------------------------------------------------------------------------
2086:     PROTECTED FUNCTION MontarBufferData()
2087:         LOCAL loc_cData
2088: 
2089:         loc_cData = DTOC(ConverterParaData(THIS.txt_4c_Datas.Value))
2090: 
2091:         RETURN ALLTRIM(SUBSTR(loc_cData, 1, 2)) + ALLTRIM(SUBSTR(loc_cData, 4, 2)) + ;
2092:                ALLTRIM(SUBSTR(loc_cData, 7, 4))
2093:     ENDFUNC
2094: 
2095:     *--------------------------------------------------------------------------
2096:     * DigitosLostFocus - migrado de SIGOPDTF.GetDigitos.LostFocus
2097:     * ("Set Confirm On"). O par SET CONFIRM OFF/ON do legado existe para o
2098:     * campo com InputMask cheio avancar sozinho ao completar os 4 digitos
2099:     * (OFF) e voltar a exigir ENTER nos demais (ON). O OFF correspondente
2100:     * estava no When do campo, que BINDEVENT nao alcanca - fica no GotFocus.
2101:     * PUBLIC: alvo de BINDEVENT.
2102:     *--------------------------------------------------------------------------
2103:     PROCEDURE DigitosLostFocus()
2104:         SET CONFIRM ON
2105:     ENDPROC
2106: 
2107:     *--------------------------------------------------------------------------
2108:     * ObterValorSaque - substitui o bloco que o legado repete em quatro lacos:
2109:     *     IF crSigOpFp.lSaque = "S"
2110:     *         lcSaque = "0,00"
2111:     *         DO FORM SigCsTef WITH ThisForm.Top, ThisForm.Left TO lcSaque
2112:     *         Buffer = lcSaque
2113:     *     Else
2114:     *         Buffer = "0,00"
2115:     *     Endif
2116:     *
2117:     * O SIGCSTEF.scx (caixa de dialogo que pergunta o valor do saque) NAO faz
2118:     * parte do acervo migrado. AVISA em vez de silenciar: o valor fica em
2119:     * "0,00", que eh o mesmo default que o legado usa quando a forma de
2120:     * pagamento nao permite saque - e tambem o valor com que ele INICIA a
2121:     * variavel antes de abrir o dialogo. Assumir zero calado faria o terminal
2122:     * autorizar uma transacao SEM o saque que o cliente pediu, divergencia de
2123:     * dinheiro invisivel (regra #17); com o aviso, o operador ve na hora.
2124:     *
2125:     * Deixa o valor em this_cValorSaque (BO), que eh de onde os call sites
2126:     * montam o buffer e de onde MontarRetornoTef le o "lcSaque" do retorno.
2127:     *--------------------------------------------------------------------------
2128:     PROTECTED PROCEDURE ObterValorSaque()
2129:         LOCAL loc_oBO
2130: 
2131:         loc_oBO = THIS.this_oBusinessObject
2132:         IF VARTYPE(loc_oBO) != "O"
2133:             RETURN
2134:         ENDIF
2135: 
2136:         loc_oBO.this_cValorSaque = "0,00"
2137: 
2138:         IF loc_oBO.this_lOpFpSaque
2139:             MsgAviso("A forma de pagamento permite SAQUE, mas o di" + CHR(225) + "logo de " + ;
2140:                 "entrada do valor (SigCsTef) n" + CHR(227) + "o foi portado nesta migra" + ;
2141:                 CHR(231) + CHR(227) + "o." + CHR(13) + ;
2142:                 "Valor de saque assumido: 0,00.", "Saque")
2143:         ENDIF
2144:     ENDPROC
2145: 
2146:     *--------------------------------------------------------------------------
2147:     * ValidarParcelas - cabeca do SIGOPDTF.Text1.Valid:
2148:     *     IF EMPTY(THIS.Value)
2149:     *         RETURN .t.
2150:     *     Endif
2151:     * Campo vazio encerra o Valid SEM conversar com o terminal (o legado
2152:     * devolve .t., isto eh "sai do campo, esta tudo bem"). Devolve .T. quando
2153:     * o laco deve rodar - note que isso INVERTE o sentido do retorno legado
2154:     * neste ramo, de proposito: aqui o booleano significa "ha trabalho a
2155:     * fazer", nao "o campo eh valido".
2156:     * PUBLIC: consumido pelo handler de KeyPress.
2157:     *--------------------------------------------------------------------------
2158:     FUNCTION ValidarParcelas()
2159:         RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Text1.Value))
2160:     ENDFUNC
2161: 
2162:     *--------------------------------------------------------------------------
2163:     * Text1GotFocus - migrado de SIGOPDTF.Text1.GotFocus
2164:     * ("ThisForm.pcTvenda = .f.") mais o SET CONFIRM OFF do Text1.When
2165:     * ("Set Confirm off"), que BINDEVENT nao alcanca.
2166:     *
2167:     * pcTvenda = .F. FECHA o grupo Tipo de Venda: a partir daqui o
2168:     * Optiongroup1.When do legado devolve .F. e o grupo nao aceita mais foco -
2169:     * quem esta digitando parcelas nao pode voltar a trocar o tipo da venda.
2170:     * Esta eh a property this_lTipoVendaLiberado, que a Fase 6 declarou e
2171:     * deixou explicitamente para esta fase fechar no momento certo.
2172:     * PUBLIC: alvo de BINDEVENT.
2173:     *--------------------------------------------------------------------------
2174:     PROCEDURE Text1GotFocus()
2175:         SET CONFIRM OFF
2176:         THIS.this_lTipoVendaLiberado = .F.
2177:     ENDPROC
2178: 
2179:     *--------------------------------------------------------------------------
2180:     * Text1LostFocus - migrado de SIGOPDTF.Text1.LostFocus:
2181:     *     Set Confirm on
2182:     *     This.Value = TRANSFORM(VAL(This.Value),"@L 99")
2183:     *     This.Enabled = .f.
2184:     *     ThisForm.getDatas.Enabled = .t.
2185:     * Normaliza o numero de parcelas para 2 digitos com zero a esquerda,
2186:     * tranca o campo e passa a vez para a data de vencimento.
2187:     * PUBLIC: alvo de BINDEVENT.
2188:     *--------------------------------------------------------------------------
2189:     PROCEDURE Text1LostFocus()
2190:         SET CONFIRM ON
2191: 
2192:         THIS.txt_4c_Text1.Value = TRANSFORM(VAL(THIS.txt_4c_Text1.Value), "@L 99")
2193:         *-- lnParcs do legado - entra no retorno da tela (Unload).
2194:         THIS.this_cParcelasTef = THIS.txt_4c_Text1.Value
2195: 
2196:         THIS.txt_4c_Text1.Enabled = .F.
2197:         THIS.txt_4c_Datas.Enabled = .T.
2198:     ENDPROC
2199: 
2200:     *--------------------------------------------------------------------------
2201:     * Text1KeyPress - migrado de SIGOPDTF.Text1.Valid. Diferente dos outros
2202:     * quatro, este NAO tem laco: faz UMA chamada ao terminal com o numero de
2203:     * parcelas digitado e trata a resposta.
2204:     *
2205:     * DOIS BLOCOS DO LEGADO NAO SAO TRANSCRITOS, e o motivo eh o mesmo do
2206:     * primeiro bloco do errotef (ver nota la): sao codigo morto-ou-quebrado.
2207:     * O Valid legado tem, DUAS vezes seguidas e identicas:
2208:     *     If ProximoComando = 20 And Upper(Alltrim(Buffer)) = '13 - OPERACAO CANCELADA?'
2209:     *         Buffer = '0'+Replicate(Chr(0),1999)
2210:     *         Loop
2211:     *     Endif
2212:     * Esse "Loop" esta FORA de qualquer DO WHILE/FOR/SCAN - o Valid nao tem
2213:     * laco nenhum. Em VFP um LOOP sem laco que o contenha nao tem para onde
2214:     * saltar; o bloco eh copia-e-cola das versoes com laco (GetDigitos.Valid,
2215:     * GetCodSeg.LostFocus) e nunca pode ter funcionado como pretendido.
2216:     * Transcrever o "Loop" aqui seria propagar o defeito; transcreve-lo como
2217:     * retry (inventando o laco que o legado nao tem) mudaria o comportamento.
2218:     * Preservado o desfecho real: o bloco nao faz nada. A duplicacao literal
2219:     * tambem nao eh reproduzida, pelo mesmo motivo.
2220:     * PUBLIC: alvo de BINDEVENT.
2221:     *--------------------------------------------------------------------------
2222:     PROCEDURE Text1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2223:         LOCAL loc_oBO, loc_nRetorno, loc_cBuf
2224: 
2225:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2226:             RETURN
2227:         ENDIF
2228:         IF THIS.this_lEmProtocolo
2229:             RETURN
2230:         ENDIF
2231:         IF !THIS.ValidarParcelas()
2232:             RETURN
2233:         ENDIF
2234: 
2235:         loc_oBO = THIS.this_oBusinessObject
2236:         IF VARTYPE(loc_oBO) != "O"
2237:             RETURN
2238:         ENDIF
2239: 
2240:         THIS.this_lEmProtocolo = .T.
2241: 
2242:         *-- lnParcs = This.Value / Buffer = This.Value + REPLICATE(CHR(0),1990)
2243:         *-- O complemento 1990 eh o do legado (e nao 2000 - LEN), transcrito.
2244:         THIS.this_cParcelasTef = ALLTRIM(THIS.txt_4c_Text1.Value)
2245:         loc_oBO.this_nParcelas = THIS.txt_4c_Text1.Value
2246:         loc_oBO.MontarBufferSiTef(ALLTRIM(THIS.txt_4c_Text1.Value), 1990)
2247:         loc_oBO.this_nContinua = 1000
2248: 
2249:         loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
2250:         loc_cBuf     = loc_oBO.this_cBuffer
2251: 
2252:         THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
2253: 
2254:         IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
2255:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
2256:         ENDIF
2257: 
2258:         IF loc_oBO.this_nProximoComando = 22
2259:             THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
2260:                 ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))
2261:             loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
2262:         ELSE

*-- Linhas 2276 a 2469:
2276:     *     ldData = IIF(EMPTY(This.Value), DATE()+30, This.Value)
2277:     *     This.Value = ldData
2278:     *     This.Refresh
2279:     *     IF ThisForm.Optiongroup1.Value = 2 .and. This.Value <= DATE() .and. ! EMPTY(This.Value)
2280:     *         DO Form SigTfDss With "Erro na Transacao","","Data Invalida",...
2281:     *         RETURN .f.
2282:     *     ENDIF
2283:     *
2284:     * Tres coisas que NAO se "arrumam" aqui:
2285:     *   - ESC (LASTKEY 27) sai sem validar e sem conversar com o terminal;
2286:     *   - data VAZIA assume HOJE + 30 DIAS, e ja GRAVA isso no campo - nao eh
2287:     *     so default de leitura;
2288:     *   - a recusa de data passada vale SO para venda a prazo
2289:     *     (Optiongroup1.Value = 2). A vista, data de hoje eh legitima.
2290:     * O terceiro teste do legado ("! EMPTY(This.Value)") eh inalcancavel na
2291:     * pratica, porque a linha anterior acabou de preencher o campo; mantido
2292:     * para nao mudar a expressao.
2293:     *
2294:     * ConverterParaData nos dois lados da comparacao: o TextBox nasce com
2295:     * .Value = {} (DATE) mas pode receber DATETIME em algum caminho, e
2296:     * comparar DATE com DATETIME estoura erro 11 (regra #16).
2297:     * PUBLIC: consumido pelo handler de KeyPress.
2298:     *--------------------------------------------------------------------------
2299:     FUNCTION ValidarDataVencimento()
2300:         LOCAL loc_lProsseguir, loc_dData
2301: 
2302:         loc_lProsseguir = .F.
2303: 
2304:         DO CASE
2305:         CASE LASTKEY() = 27
2306:             *-- ESC: sai do campo sem acionar o protocolo.
2307:         OTHERWISE
2308:             loc_dData = ConverterParaData(THIS.txt_4c_Datas.Value)
2309:             IF EMPTY(loc_dData)
2310:                 loc_dData = DATE() + 30
2311:             ENDIF
2312:             THIS.txt_4c_Datas.Value = loc_dData
2313:             THIS.this_dDataTef      = loc_dData
2314:             THIS.txt_4c_Datas.Refresh()
2315: 
2316:             IF THIS.obj_4c_Optiongroup1.Value = 2 AND loc_dData <= DATE() AND !EMPTY(loc_dData)
2317:                 THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
2318:                     "Data Invalida", "")
2319:             ELSE
2320:                 loc_lProsseguir = .T.
2321:             ENDIF
2322:         ENDCASE
2323: 
2324:         RETURN loc_lProsseguir
2325:     ENDFUNC
2326: 
2327:     *--------------------------------------------------------------------------
2328:     * DatasLostFocus - migrado de SIGOPDTF.GetDatas.LostFocus
2329:     * ("Set Confirm On"); o OFF correspondente esta no GetDatas.When e vem
2330:     * para o GotFocus. PUBLIC: alvo de BINDEVENT.
2331:     *--------------------------------------------------------------------------
2332:     PROCEDURE DatasLostFocus()
2333:         SET CONFIRM ON
2334:     ENDPROC
2335: 
2336:     *--------------------------------------------------------------------------
2337:     * ObterSenhaSupervisor - substitui "DO FORM SigPrStf TO Senha" do
2338:     * SIGOPDTF.GetDatas.Valid (ProximoComando = 30 / TipoCampo = 500: o
2339:     * terminal esta pedindo autorizacao de supervisor).
2340:     *
2341:     * O SIGPRSTF.scx nao faz parte do acervo migrado. Devolve STRING VAZIA,
2342:     * que no legado eh o ramo "o supervisor nao autorizou" - e esse ramo
2343:     * CANCELA a transacao. Escolha deliberada e conservadora: devolver uma
2344:     * senha qualquer para "deixar passar" autorizaria no terminal uma operacao
2345:     * que ninguem aprovou. Com o aviso, o operador sabe por que a tela
2346:     * cancelou e pode acionar a autorizacao pelo caminho do legado.
2347:     *--------------------------------------------------------------------------
2348:     PROTECTED FUNCTION ObterSenhaSupervisor()
2349:         MsgAviso("O terminal pediu SENHA DE SUPERVISOR, e o di" + CHR(225) + "logo de " + ;
2350:             "autoriza" + CHR(231) + CHR(227) + "o (SigPrStf) n" + CHR(227) + "o foi " + ;
2351:             "portado nesta migra" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
2352:             "A transa" + CHR(231) + CHR(227) + "o ser" + CHR(225) + " CANCELADA.", ;
2353:             "Autoriza" + CHR(231) + CHR(227) + "o")
2354: 
2355:         RETURN ""
2356:     ENDFUNC
2357: 
2358:     *--------------------------------------------------------------------------
2359:     * DatasGotFocus - migrado de SIGOPDTF.GetDatas.GotFocus. Zera o estado da
2360:     * transacao, troca a legenda e - SO quando a venda nao eh a prazo, a data
2361:     * ainda nao foi confirmada e a forma de pagamento nao usa CDC - conduz
2362:     * DOIS lacos encadeados com o terminal.
2363:     *
2364:     * A condicao de entrada eh do legado e nao se simplifica:
2365:     *     IF lsDebCred <> "P" .and. ! DCD .and. crSigOpFp.Tcdc <> "S"
2366:     * Fora dela o metodo SO reposiciona a legenda - e esse "else implicito" eh
2367:     * o caminho normal quando a data chega aqui pela segunda vez.
2368:     *
2369:     * O 1o laco ("DO WHILE ProximoComando <> 30") so existe quando o grupo
2370:     * Tipo de Venda esta DESABILITADO: com ele habilitado o legado monta o
2371:     * buffer direto da escolha do usuario (1 = a vista, 3 = a prazo) e nao
2372:     * conversa. Transcrito com essa bifurcacao.
2373:     *
2374:     * Guarda de reentrancia e corpo separado pelo mesmo motivo do
2375:     * DigitosGotFocus (dialogo modal + mexe em .Enabled = foco volta = evento
2376:     * redispara).
2377:     * PUBLIC: alvo de BINDEVENT.
2378:     *--------------------------------------------------------------------------
2379:     PROCEDURE DatasGotFocus()
2380:         *-- SIGOPDTF.GetDatas.When ("Set Confirm Off") - BINDEVENT nao alcanca
2381:         *-- "When", e aqui o legado nao condiciona a nada.
2382:         SET CONFIRM OFF
2383: 
2384:         IF THIS.this_lEmProtocolo
2385:             RETURN
2386:         ENDIF
2387: 
2388:         THIS.this_lEmProtocolo = .T.
2389:         THIS.DatasGotFocusExec()
2390:         THIS.this_lEmProtocolo = .F.
2391:     ENDPROC
2392: 
2393:     *--------------------------------------------------------------------------
2394:     * DatasGotFocusExec - corpo do metodo acima (ver nota de reentrancia).
2395:     * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
2396:     *--------------------------------------------------------------------------
2397:     PROCEDURE DatasGotFocusExec()
2398:         LOCAL loc_oBO, loc_nRetorno, loc_cBuf
2399: 
2400:         loc_oBO = THIS.this_oBusinessObject
2401:         IF VARTYPE(loc_oBO) != "O"
2402:             RETURN
2403:         ENDIF
2404: 
2405:         *-- pcTvenda = .f. - fecha o grupo Tipo de Venda (ver Text1GotFocus).
2406:         THIS.this_lTipoVendaLiberado = .F.
2407: 
2408:         *-- Zera o estado da transacao (as 7 PRIVATE do legado).
2409:         loc_oBO.this_cTipTran         = ""
2410:         loc_oBO.this_cDataHora        = ""
2411:         loc_oBO.this_cCupomRetorno    = ""
2412:         loc_oBO.this_cCartaoAux       = ""
2413:         loc_oBO.this_cNsu             = ""
2414:         loc_oBO.this_cAutoriza        = ""
2415:         loc_oBO.this_cFinaliza        = ""
2416:         loc_oBO.this_cMensagemRetorno = ""
2417: 
2418:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
2419: 
2420:         *-- Condicao de entrada do legado - fora dela, so a legenda acima.
2421:         IF !(THIS.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada AND ;
2422:              loc_oBO.this_cOpFpTcdc != "S")
2423:             RETURN
2424:         ENDIF
2425: 
2426:         loc_nRetorno = 10000
2427: 
2428:         IF THIS.obj_4c_Optiongroup1.Enabled
2429:             loc_oBO.this_cBuffer = IIF(THIS.obj_4c_Optiongroup1.Value = 1, "1", "3") + ;
2430:                 REPLICATE(CHR(0), 1999)
2431:         ELSE
2432:             *-- 1o laco: drena o protocolo ate ProximoComando = 30.
2433:             DO WHILE loc_oBO.this_nProximoComando != 30
2434:                 loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
2435:                 loc_cBuf     = loc_oBO.this_cBuffer
2436: 
2437:                 IF loc_oBO.this_nProximoComando = 20 AND ;
2438:                    UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
2439:                     loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
2440:                     LOOP
2441:                 ENDIF
2442: 
2443:                 IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
2444:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
2445:                 ENDIF
2446: 
2447:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
2448: 
2449:                 IF loc_nRetorno < 0
2450:                     THIS.ErroTef(loc_nRetorno)
2451:                     THIS.EncerrarDialogo()
2452:                     RETURN
2453:                 ENDIF
2454:             ENDDO
2455:             loc_oBO.this_cBuffer = THIS.txt_4c_Text1.Value + REPLICATE(CHR(0), 1998)
2456:         ENDIF
2457: 
2458:         loc_oBO.this_nContinua = 1000
2459:         loc_oBO.this_cAutoriza = ""
2460:         loc_nRetorno           = 10000
2461: 
2462:         *-- 2o laco: conduz a autorizacao da venda a prazo.
2463:         DO WHILE loc_nRetorno = 10000
2464:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
2465:             loc_cBuf     = loc_oBO.this_cBuffer
2466: 
2467:             IF LASTKEY() = 27
2468:                 loc_oBO.ContinuarSiTef(-1)
2469:                 THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;

*-- Linhas 2514 a 2557:
2514:                 EXIT
2515:             ENDIF
2516: 
2517:             IF loc_oBO.this_nProximoComando = 30 AND THIS.obj_4c_Optiongroup1.Value = 2
2518:                 IF loc_oBO.this_nTipoCampo = 510
2519:                     IF loc_oBO.this_lOpFpGarantias
2520:                         loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
2521:                     ELSE
2522:                         loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
2523:                     ENDIF
2524:                     loc_oBO.this_nContinua = 1000
2525:                     LOOP
2526:                 ENDIF
2527:                 EXIT
2528:             ENDIF
2529: 
2530:             IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 506
2531:                 loc_oBO.this_cBuffer   = THIS.MontarBufferData() + REPLICATE(CHR(0), 1992)
2532:                 loc_oBO.this_nContinua = 1000
2533:                 LOOP
2534:             ENDIF
2535: 
2536:             IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 505
2537:                 loc_oBO.this_cBuffer   = ALLTRIM(TRANSFORM(loc_oBO.this_nNumParcs, "@L 99")) + ;
2538:                     REPLICATE(CHR(0), 1998)
2539:                 loc_oBO.this_nContinua = 1000
2540:                 LOOP
2541:             ENDIF
2542: 
2543:             IF loc_oBO.this_nProximoComando = 20 AND loc_oBO.this_nTipoCampo = 507
2544:                 IF MsgConfirma("Primeira Parcela A Vista", "Parcelamento")
2545:                     loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
2546:                 ELSE
2547:                     loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
2548:                 ENDIF
2549:                 loc_oBO.this_nContinua = 1000
2550:                 LOOP
2551:             ENDIF
2552: 
2553:             IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 508
2554:                 loc_oBO.this_cBuffer   = ALLTRIM(STR(loc_oBO.this_nOpFpDias)) + REPLICATE(CHR(0), 1998)
2555:                 loc_oBO.this_nContinua = 1000
2556:                 LOOP
2557:             ENDIF

*-- Linhas 2657 a 2727:
2657:     * transacao: envia a data de vencimento e, aprovada a venda, grava o
2658:     * arquivo de retorno e encerra a tela.
2659:     *
2660:     * Ligado a "KeyPress" (ENTER/TAB) porque BINDEVENT em "Valid" nao dispara
2661:     * em TextBox - ver nota em RegistrarEventosCampos. A cabeca do Valid
2662:     * legado esta em ValidarDataVencimento().
2663:     *
2664:     * O legado encerra a tela INCONDICIONALMENTE no fim deste Valid (o
2665:     * "Thisform.release" esta FORA do IF que escolhe entre MontaRetorno e
2666:     * ErroTef) - transcrito assim: todo caminho que chega ao fim fecha o
2667:     * dialogo, porque a transacao ja foi decidida pelo terminal.
2668:     * PUBLIC: alvo de BINDEVENT.
2669:     *--------------------------------------------------------------------------
2670:     PROCEDURE DatasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2671:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2672:             RETURN
2673:         ENDIF
2674:         IF THIS.this_lEmProtocolo
2675:             RETURN
2676:         ENDIF
2677: 
2678:         THIS.this_lEmProtocolo = .T.
2679:         THIS.DatasKeyPressExec()
2680:         THIS.this_lEmProtocolo = .F.
2681:     ENDPROC
2682: 
2683:     *--------------------------------------------------------------------------
2684:     * DatasKeyPressExec - corpo do laco acima (ver nota de reentrancia).
2685:     * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
2686:     *--------------------------------------------------------------------------
2687:     PROCEDURE DatasKeyPressExec()
2688:         LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_nPrimo, loc_cSenha, ;
2689:               loc_cData, loc_cHora
2690: 
2691:         IF !THIS.ValidarDataVencimento()
2692:             RETURN
2693:         ENDIF
2694: 
2695:         loc_oBO = THIS.this_oBusinessObject
2696:         IF VARTYPE(loc_oBO) != "O"
2697:             RETURN
2698:         ENDIF
2699: 
2700:         *-- 1o laco: drena o protocolo ate ProximoComando = 30.
2701:         DO WHILE loc_oBO.this_nProximoComando != 30
2702:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
2703:             loc_cBuf     = loc_oBO.this_cBuffer
2704: 
2705:             IF loc_oBO.this_nProximoComando = 20 AND ;
2706:                UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
2707:                 loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
2708:                 LOOP
2709:             ENDIF
2710: 
2711:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
2712: 
2713:             IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
2714:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
2715:             ENDIF
2716: 
2717:             IF loc_nRetorno < 0
2718:                 THIS.ErroTef(loc_nRetorno)
2719:                 THIS.EncerrarDialogo()
2720:                 RETURN
2721:             ENDIF
2722:         ENDDO
2723: 
2724:         loc_oBO.this_cMensagemRetorno = ""
2725:         loc_oBO.this_cAutoriza        = ""
2726:         loc_nPrimo                    = 1
2727:         loc_nRetorno                  = 10000

*-- Linhas 2897 a 3019:
2897: 
2898:         IF loc_nRetorno != 10000
2899:             IF THIS.this_cDebCred = "P"
2900:                 MsgAviso("Consulta CDC (SigCoCDC) n" + CHR(227) + "o portada nesta migra" + ;
2901:                     CHR(231) + CHR(227) + "o." + CHR(13) + ;
2902:                     "Cupom retornado pelo terminal: " + ALLTRIM(loc_oBO.this_cCupomRetorno), ;
2903:                     "Consulta CDC")
2904:                 THIS.RetornoFalha("Consulta CDC Realizada", loc_oBO.this_nValPago)
2905:             ELSE
2906:                 IF loc_nRetorno = 0
2907:                     THIS.MontaRetorno(loc_oBO.this_cTipTran, loc_oBO.this_cDataHora, ;
2908:                         loc_oBO.this_cCupomRetorno, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
2909:                         loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, loc_oBO.this_nValPago, ;
2910:                         loc_oBO.this_cMensagemRetorno)
2911:                 ELSE
2912:                     *-- Legado: "If lnRetorno >= -5". Os codigos -1..-5 tem
2913:                     *-- mensagem propria no ErroTef; abaixo de -5 (o -8 de
2914:                     *-- "CANC. CLIENTE", por exemplo) o legado nao grava nada
2915:                     *-- aqui, porque a mensagem ja foi exibida no ramo 22.
2916:                     IF loc_nRetorno >= -5
2917:                         THIS.ErroTef(loc_nRetorno)
2918:                     ENDIF
2919:                 ENDIF
2920:             ENDIF
2921:         ENDIF
2922: 
2923:         *-- "Thisform.release" FORA do IF no legado - ver nota no cabecalho.
2924:         THIS.EncerrarDialogo()
2925:     ENDPROC
2926: 
2927:     *--------------------------------------------------------------------------
2928:     * CodSegGotFocus - migrado de SIGOPDTF.GetCodSeg.GotFocus
2929:     * ("Container1.Label1.Caption = 'Digite o Codigo' + CHR(13) + 'de Seguranca'")
2930:     * mais o SET CONFIRM OFF do GetCodSeg.When, que BINDEVENT nao alcanca e que
2931:     * no legado eh condicionado a campo vazio.
2932:     * PUBLIC: alvo de BINDEVENT.
2933:     *--------------------------------------------------------------------------
2934:     PROCEDURE CodSegGotFocus()
2935:         IF EMPTY(ALLTRIM(THIS.txt_4c_Codigo.Value))
2936:             SET CONFIRM OFF
2937:         ENDIF
2938: 
2939:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Codigo" + CHR(13) + "de Seguranca"
2940:     ENDPROC
2941: 
2942:     *--------------------------------------------------------------------------
2943:     * CodSegLostFocus - migrado de SIGOPDTF.GetCodSeg.LostFocus: envia o
2944:     * codigo de seguranca (CSEG) ao terminal e conduz o parcelamento.
2945:     *
2946:     * ESTE eh o unico laco que fica no evento LostFocus de verdade, e nao em
2947:     * KeyPress: no legado o protocolo do CSEG mora no PROPRIO LostFocus. O
2948:     * GetCodSeg.Valid existe no dump mas esta INTEIRO comentado (prefixo
2949:     * "*!*") - codigo desligado de proposito, que nao se migra. E LostFocus
2950:     * dispara por BINDEVENT sem problema (diferente de "Valid"), entao nao ha
2951:     * razao para desviar do legado aqui.
2952:     *
2953:     * A guarda de reentrancia eh especialmente necessaria neste: o laco abre
2954:     * dialogo MODAL (ExibirMensagemTef/MsgConfirma) e no fim mexe no .Enabled
2955:     * de quatro controles - cada uma dessas coisas devolve o foco e
2956:     * REDISPARARIA este mesmo LostFocus (regras #37/#47).
2957:     * PUBLIC: alvo de BINDEVENT.
2958:     *--------------------------------------------------------------------------
2959:     PROCEDURE CodSegLostFocus()
2960:         SET CONFIRM ON
2961: 
2962:         IF THIS.this_lEmProtocolo
2963:             RETURN
2964:         ENDIF
2965:         *-- "IF EMPTY(This.Value) / RETURN" do legado.
2966:         IF EMPTY(ALLTRIM(THIS.txt_4c_Codigo.Value))
2967:             RETURN
2968:         ENDIF
2969: 
2970:         THIS.this_lEmProtocolo = .T.
2971:         THIS.CodSegLostFocusExec()
2972:         THIS.this_lEmProtocolo = .F.
2973:     ENDPROC
2974: 
2975:     *--------------------------------------------------------------------------
2976:     * CodSegLostFocusExec - corpo do laco acima (ver nota de reentrancia).
2977:     * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
2978:     *--------------------------------------------------------------------------
2979:     PROCEDURE CodSegLostFocusExec()
2980:         LOCAL loc_oBO, loc_nRetorno, loc_cBuf
2981: 
2982:         loc_oBO = THIS.this_oBusinessObject
2983:         IF VARTYPE(loc_oBO) != "O"
2984:             RETURN
2985:         ENDIF
2986: 
2987:         loc_oBO.this_cCodSeg          = ALLTRIM(THIS.txt_4c_Codigo.Value)
2988:         loc_oBO.this_cMensagemRetorno = ""
2989:         loc_oBO.MontarBufferSiTef(ALLTRIM(THIS.txt_4c_Codigo.Value))
2990:         loc_oBO.this_nContinua = 1000
2991:         loc_nRetorno           = 10000
2992: 
2993:         DO WHILE loc_nRetorno = 10000
2994:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
2995:             loc_cBuf     = loc_oBO.this_cBuffer
2996: 
2997:             IF LASTKEY() = 27
2998:                 loc_oBO.ContinuarSiTef(-1)
2999:                 THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
3000:                     loc_oBO.this_nValPago)
3001:                 THIS.EncerrarDialogo()
3002:                 RETURN
3003:             ENDIF
3004: 
3005:             IF loc_oBO.this_nProximoComando = 20 AND ;
3006:                UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
3007:                 loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
3008:                 LOOP
3009:             ENDIF
3010: 
3011:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
3012: 
3013:             IF loc_nRetorno = 0
3014:                 EXIT
3015:             ENDIF
3016: 
3017:             IF loc_nRetorno < 0
3018:                 THIS.ErroTef(loc_nRetorno)
3019:                 THIS.EncerrarDialogo()

*-- Linhas 3145 a 3230:
3145: 
3146:         IF THIS.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada
3147:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
3148:             THIS.obj_4c_Optiongroup1.Enabled = .T.
3149:             THIS.txt_4c_Datas.Enabled        = .T.
3150:             THIS.txt_4c_Text1.Enabled        = .F.
3151:         ELSE
3152:             THIS.obj_4c_Optiongroup1.Enabled = .F.
3153:             THIS.txt_4c_Datas.Enabled        = .F.
3154:             THIS.txt_4c_Text1.Enabled        = .F.
3155:         ENDIF
3156:     ENDPROC
3157: 
3158:     *--------------------------------------------------------------------------
3159:     * MontaRetorno - migrado de SIGOPDTF.montaretorno (PARAMETERS lsTipTran,
3160:     * lsDataHora, lsCupom, lsCartao, lsNsu, lsAutoriza, lsFinaliza, lnValPago,
3161:     * MenRet). Grava os mesmos dois arquivos SDF do RetornoFalha, agora com os
3162:     * dados COMPLETOS da transacao APROVADA - eh este arquivo que o software
3163:     * do PDV le para imprimir o comprovante.
3164:     *
3165:     * Nada aqui eh "arrumado": os numeros de campo (000-000, 010-000, ...), a
3166:     * ordem, os recortes de lsDataHora e inclusive as DUAS ANOMALIAS do
3167:     * original sao transcritos literalmente, porque o leitor do outro lado eh
3168:     * o PDV e qualquer divergencia aparece como comprovante errado:
3169:     *
3170:     *   1. O campo "017-000" eh gravado DUAS vezes (primeiro "0", depois
3171:     *      vazio), e "023-000" tambem (primeiro a hora, depois lsFinaliza).
3172:     *      Como o arquivo eh lido em sequencia, a segunda ocorrencia vence.
3173:     *      Esta assim no legado desde sempre.
3174:     *   2. laCartao tem 11 posicoes e eh indexado por VAL(lsCartao)+1, mas o
3175:     *      guard anterior aceita VAL(pcBandeira) de 0 a 10 - ou seja o indice
3176:     *      vai de 1 a 11 e nunca estoura. O guard do legado eh
3177:     *      "> 10 .or. < 0 -> lsCartao = '0'", transcrito igual.
3178:     *
3179:     * O par_cCartao recebido eh a BANDEIRA (os call sites passam
3180:     * Thisform.pcBandeira nessa posicao, apesar do nome do parametro) - por
3181:     * isso eh ele que alimenta o indice de laCartao.
3182:     *
3183:     * O laco do cupom quebra o texto em linhas de 029-NNN por CHR(10). A
3184:     * condicao do legado eh "DO WHILE lsPos <> 0" com lsPos calculado DENTRO
3185:     * do laco, o que faz a ultima linha (sem CHR(10)) entrar e so depois a
3186:     * condicao falhar - por isso o contador final eh "lnLinha - 2".
3187:     *
3188:     * PUBLIC: chamado pelos cinco lacos do protocolo.
3189:     *--------------------------------------------------------------------------
3190:     PROCEDURE MontaRetorno(par_cTipTran, par_cDataHora, par_cCupom, par_cCartao, ;
3191:             par_cNsu, par_cAutoriza, par_cFinaliza, par_nValPago, par_cMenRet)
3192:         LOCAL loc_cValPago, loc_cLsCartao, loc_cCupom, loc_nPos, loc_nLinha, ;
3193:               loc_cDataHora, loc_oErro
3194:         LOCAL ARRAY loc_aCartao[11]
3195: 
3196:         loc_cValPago  = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")
3197:         loc_cDataHora = IIF(VARTYPE(par_cDataHora) = "C", par_cDataHora, "")
3198:         loc_cCupom    = IIF(VARTYPE(par_cCupom) = "C", par_cCupom, "")
3199: 
3200:         loc_aCartao[1]  = "Outro, nao definido"
3201:         loc_aCartao[2]  = "Visa"
3202:         loc_aCartao[3]  = "Mastercard"
3203:         loc_aCartao[4]  = "Diners"
3204:         loc_aCartao[5]  = "American Express"
3205:         loc_aCartao[6]  = "Sollo"
3206:         loc_aCartao[7]  = "Sidecard (Redecard)"
3207:         loc_aCartao[8]  = "Private Label (Redecard)"
3208:         loc_aCartao[9]  = "Redeshop"
3209:         loc_aCartao[10] = ""
3210:         loc_aCartao[11] = "Fininvest"
3211: 
3212:         *-- IF VAL(Thisform.pcBandeira) > 10 .or. VAL(Thisform.pcBandeira) < 0
3213:         loc_cLsCartao = IIF(VARTYPE(par_cCartao) = "C", par_cCartao, "0")
3214:         IF VAL(loc_cLsCartao) > 10 OR VAL(loc_cLsCartao) < 0
3215:             loc_cLsCartao = "0"
3216:         ENDIF
3217: 
3218:         IF !DIRECTORY("C:\client\Resp", 1)
3219:             RETURN
3220:         ENDIF
3221: 
3222:         TRY
3223:             IF USED("crSiTef")
3224:                 USE IN crSiTef
3225:             ENDIF
3226:             CREATE CURSOR crSiTef (tef c(100))
3227: 
3228:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
3229:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
3230:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")

*-- Linhas 3280 a 3505:
3280:         CATCH TO loc_oErro
3281:             MsgErro(loc_oErro.Message + CHR(13) + ;
3282:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3283:                     "Procedure: " + loc_oErro.Procedure, ;
3284:                     "Erro ao gravar retorno SiTef")
3285:         ENDTRY
3286:     ENDPROC
3287: 
3288:     *--------------------------------------------------------------------------
3289:     * FormParaBO - transfere os campos da tela para as properties do BO.
3290:     *
3291:     * O legado nao tem um metodo equivalente: ele le os controles direto
3292:     * (ThisForm.Text1.Value, ThisForm.GetDatas.Value) dentro dos lacos do
3293:     * protocolo, e esses lacos continuam fazendo isso, fielmente. Este hook
3294:     * existe para o CONTRATO da arquitetura em camadas (PILAR 3) e eh de fato
3295:     * usado: consolida num ponto so a conversao de tipo que os campos pedem,
3296:     * e eh chamado por LimparCampos e pelos pontos em que o BO precisa do
3297:     * estado completo da tela.
3298:     *
3299:     * As tres conversoes NAO sao cosmeticas:
3300:     *   - txt_4c_Text1 e txt_4c_Digitos sao CARACTERE na tela (.Value = "" na
3301:     *     criacao, InputMask "99"/"9999") e a property de parcelas eh
3302:     *     NUMERICA: VAL() eh obrigatorio, senao a property troca de tipo e a
3303:     *     primeira comparacao aritmetica estoura.
3304:     *   - txt_4c_Valor eh numerico, mas pode chegar como CARACTERE quando o
3305:     *     InputMask e' aplicado em alguns caminhos - TratarNulo com padrao
3306:     *     numerico normaliza.
3307:     *   - txt_4c_Datas nasce DATE ({}) e pode receber DATETIME: ConverterParaData
3308:     *     evita o erro 11 da regra #16.
3309:     *
3310:     * Optiongroup1.Value eh NUMERICO e 1-based (1 = A Vista, 2 = A Prazo) -
3311:     * copiado DIRETO, sem +1/-1 (regra #45).
3312:     *
3313:     * PROTECTED: FormBase declara o hook como PROTECTED e subclasse nao alarga
3314:     * escopo em VFP9 (regra #51).
3315:     *--------------------------------------------------------------------------
3316:     PROTECTED PROCEDURE FormParaBO()
3317:         LOCAL loc_oBO, loc_lSucesso
3318: 
3319:         loc_lSucesso = .F.
3320: 
3321:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3322:             loc_oBO = THIS.this_oBusinessObject
3323: 
3324:             loc_oBO.this_nValPago   = TratarNulo(THIS.txt_4c_Valor.Value, 0)
3325:             loc_oBO.this_cDigitos   = ALLTRIM(THIS.txt_4c_Digitos.Value)
3326:             loc_oBO.this_cCartao    = ALLTRIM(THIS.txt_4c_Cartao.Value)
3327:             loc_oBO.this_cCodSeg    = ALLTRIM(THIS.txt_4c_Codigo.Value)
3328:             loc_oBO.this_nTipoVenda = THIS.obj_4c_Optiongroup1.Value
3329:             loc_oBO.this_nParcelas  = THIS.txt_4c_Text1.Value
3330:             loc_oBO.this_dDataVencto = ConverterParaData(THIS.txt_4c_Datas.Value)
3331: 
3332:             *-- Parametros que o Form guarda desde o Init (o BO declara
3333:             *-- this_lDebCred como LOGICO e nunca o le - ver nota na Fase 3;
3334:             *-- o valor CARACTERE real vive em THIS.this_cDebCred).
3335:             loc_oBO.this_cTipPagto = THIS.this_cTipPagto
3336:             loc_oBO.this_nNumParcs = THIS.this_nNumParcs
3337:             loc_oBO.this_cIdent    = THIS.this_cIdent
3338:             loc_oBO.this_cOpers    = THIS.this_cOpers
3339: 
3340:             loc_lSucesso = .T.
3341:         ENDIF
3342: 
3343:         RETURN loc_lSucesso
3344:     ENDPROC
3345: 
3346:     *--------------------------------------------------------------------------
3347:     * BOParaForm - caminho inverso. Existe para o chamador que pre-carrega a
3348:     * transacao no BO (valor, parcelas, vencimento vindos do pedido) antes de
3349:     * exibir o dialogo, e para repintar a tela depois de o protocolo alterar
3350:     * esses campos.
3351:     *
3352:     * txt_4c_Text1 volta com a MESMA mascara do legado (TRANSFORM "@L 99"),
3353:     * porque o controle eh CARACTERE e a property eh numerica - sem a mascara
3354:     * "3" viraria "3" em vez de "03" e o campo 018-000 do arquivo de retorno
3355:     * sairia com um digito.
3356:     *
3357:     * Optiongroup1.Value so eh atribuido DENTRO da faixa dos 2 botoes: valor
3358:     * fora dela (o 0 default do BO, por exemplo) marcaria todos os radios de
3359:     * uma vez (regra do pattern #108).
3360:     * PROTECTED: mesmo motivo do FormParaBO.
3361:     *--------------------------------------------------------------------------
3362:     PROTECTED PROCEDURE BOParaForm()
3363:         LOCAL loc_oBO, loc_lSucesso
3364: 
3365:         loc_lSucesso = .F.
3366: 
3367:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3368:             loc_oBO = THIS.this_oBusinessObject
3369: 
3370:             THIS.txt_4c_Valor.Value   = TratarNulo(loc_oBO.this_nValPago, 0)
3371:             THIS.txt_4c_Digitos.Value = loc_oBO.this_cDigitos
3372:             THIS.txt_4c_Cartao.Value  = loc_oBO.this_cCartao
3373:             THIS.txt_4c_Codigo.Value  = loc_oBO.this_cCodSeg
3374:             THIS.txt_4c_Text1.Value   = TRANSFORM(loc_oBO.this_nParcelas, "@L 99")
3375:             THIS.txt_4c_Datas.Value   = ConverterParaData(loc_oBO.this_dDataVencto)
3376: 
3377:             IF BETWEEN(loc_oBO.this_nTipoVenda, 1, THIS.obj_4c_Optiongroup1.ButtonCount)
3378:                 THIS.obj_4c_Optiongroup1.Value = loc_oBO.this_nTipoVenda
3379:             ENDIF
3380: 
3381:             loc_lSucesso = .T.
3382:         ENDIF
3383: 
3384:         RETURN loc_lSucesso
3385:     ENDPROC
3386: 
3387:     *--------------------------------------------------------------------------
3388:     * HabilitarCampos - estado dos campos por etapa do protocolo. NAO eh o
3389:     * HabilitarCampos de form CRUD (que liga/desliga a Page2 de Dados por
3390:     * modo INCLUIR/ALTERAR/VISUALIZAR): aqui nao ha modo de edicao nenhum,
3391:     * ha ETAPAS de conversa com o terminal, e o legado comanda cada campo na
3392:     * linha exata em que o terminal pede o dado.
3393:     *
3394:     * Reune num lugar so os dois estados que o legado monta repetidas vezes:
3395:     *   par_lHabilitar = .F. -> estado de ABERTURA, identico ao que o SCX
3396:     *       declara (GetDigitos editavel, o resto travado) e que
3397:     *       DigitosGotFocus reforca;
3398:     *   par_lHabilitar = .T. -> estado de PARCELAMENTO LIBERADO, o mesmo que
3399:     *       o fim do CodSegLostFocus/DigitosKeyPress monta quando a venda nao
3400:     *       eh a prazo.
3401:     * As transicoes INTERMEDIARIAS continuam onde o legado as poe (dentro dos
3402:     * lacos), de proposito: centralizar todas aqui obrigaria a inventar uma
3403:     * maquina de estados que o legado nao tem, e e' justamente onde esse tipo
3404:     * de reescrita costuma trocar o ramo errado.
3405:     * PROTECTED: so o proprio form chama.
3406:     *--------------------------------------------------------------------------
3407:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3408:         LOCAL loc_lHabilitar
3409: 
3410:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)
3411: 
3412:         *-- GetValor nunca entra em edicao (When = .F. no legado - ver
3413:         *-- ConfigurarValoresIniciais).
3414:         THIS.txt_4c_Valor.ReadOnly = .T.
3415:         THIS.txt_4c_Valor.TabStop  = .F.
3416: 
3417:         IF loc_lHabilitar
3418:             THIS.txt_4c_Digitos.Enabled      = .F.
3419:             THIS.txt_4c_Text1.Enabled        = .T.
3420:             THIS.txt_4c_Datas.Enabled        = .T.
3421:             THIS.obj_4c_Optiongroup1.Enabled = .T.
3422:         ELSE
3423:             THIS.txt_4c_Digitos.Enabled      = .T.
3424:             THIS.txt_4c_Text1.Enabled        = .F.
3425:             THIS.txt_4c_Datas.Enabled        = .F.
3426:             THIS.txt_4c_Codigo.Enabled       = .F.
3427:             THIS.obj_4c_Optiongroup1.Enabled = .F.
3428: 
3429:             *-- GetCartao depende da forma de pagamento (lCartao = "S"), nao
3430:             *-- da etapa - mesmo criterio do Init legado.
3431:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3432:                 THIS.txt_4c_Cartao.Enabled = THIS.this_oBusinessObject.this_lOpFpCartao
3433:             ENDIF
3434:         ENDIF
3435:     ENDPROC
3436: 
3437:     *--------------------------------------------------------------------------
3438:     * LimparCampos - devolve a tela ao estado de abertura, para o caso de o
3439:     * chamador reaproveitar a MESMA instancia do dialogo em uma segunda
3440:     * transacao.
3441:     *
3442:     * No legado isso nunca acontece: SIGOPDTF eh modal, vive UMA transacao e
3443:     * morre no Thisform.release. No sistema novo a tela fecha com Hide() (para
3444:     * o chamador conseguir ler o resultado - ver EncerrarDialogo), entao a
3445:     * instancia SOBREVIVE e pode ser exibida de novo. Sem zerar o estado, a
3446:     * segunda transacao herdaria NSU, bandeira, cupom e this_cRetornoTef da
3447:     * primeira e gravaria um comprovante com dados da anterior - exatamente a
3448:     * classe de defeito que a regra #32 descreve ("declarar NAO basta quando o
3449:     * ciclo de vida difere").
3450:     *
3451:     * Zera TAMBEM this_cRetornoTef e o estado do protocolo no BO, nao apenas
3452:     * os controles: eh o retorno que o chamador le.
3453:     * PROTECTED: FormBase declara o hook como PROTECTED (regra #51).
3454:     *--------------------------------------------------------------------------
3455:     PROTECTED PROCEDURE LimparCampos()
3456:         LOCAL loc_oBO
3457: 
3458:         THIS.txt_4c_Digitos.Value = ""
3459:         THIS.txt_4c_Cartao.Value  = ""
3460:         THIS.txt_4c_Codigo.Value  = ""
3461:         THIS.txt_4c_Text1.Value   = TRANSFORM(THIS.this_nNumParcs, "@L 99")
3462:         THIS.txt_4c_Datas.Value   = DATE()
3463:         THIS.txt_4c_Valor.Value   = THIS.this_nValPago
3464: 
3465:         THIS.obj_4c_Optiongroup1.Value = 1
3466: 
3467:         THIS.this_cRetornoTef        = ""
3468:         THIS.this_cParcelasTef       = TRANSFORM(THIS.this_nNumParcs, "@L 99")
3469:         THIS.this_dDataTef           = DATE()
3470:         THIS.this_lTipoVendaLiberado = .T.
3471:         THIS.this_lEmProtocolo       = .F.
3472: 
3473:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3474:             loc_oBO = THIS.this_oBusinessObject
3475: 
3476:             loc_oBO.this_cTipTran         = ""
3477:             loc_oBO.this_cDataHora        = ""
3478:             loc_oBO.this_cCupomRetorno    = ""
3479:             loc_oBO.this_cCartao          = ""
3480:             loc_oBO.this_cCartaoAux       = ""
3481:             loc_oBO.this_cBandeira        = ""
3482:             loc_oBO.this_cNsu             = ""
3483:             loc_oBO.this_cAutoriza        = ""
3484:             loc_oBO.this_cFinaliza        = ""
3485:             loc_oBO.this_cCodSeg          = ""
3486:             loc_oBO.this_cDigitos         = ""
3487:             loc_oBO.this_cMensagemRetorno = ""
3488:             loc_oBO.this_cValorSaque      = "0,00"
3489:             loc_oBO.this_lDataConfirmada  = .F.
3490:             loc_oBO.this_lCancelado       = .F.
3491: 
3492:             loc_oBO.this_nProximoComando = 0
3493:             loc_oBO.this_nTipoCampo      = 0
3494:             loc_oBO.this_nTamanhoMinimo  = 0
3495:             loc_oBO.this_nTamanhoMaximo  = 0
3496:             loc_oBO.this_cBuffer         = SPACE(2000)
3497:             loc_oBO.this_nContinua       = 0
3498:         ENDIF
3499: 
3500:         THIS.ConfigurarValoresIniciais()
3501:         THIS.HabilitarCampos(.F.)
3502:         THIS.FormParaBO()
3503:     ENDPROC
3504: 
3505:     *--------------------------------------------------------------------------

*-- Linhas 3568 a 3639:
3568:     * recalcula se por algum caminho ele nao tiver sido preenchido.
3569:     *
3570:     * Atende os DOIS modos de abertura: "DO FORM ... TO lcRetorno" (le este
3571:     * RETURN) e CREATEOBJECT + Show() (le a property this_cRetornoTef, que
3572:     * sobrevive ao fechamento porque o chamador ainda tem a referencia).
3573:     * PUBLIC: evento de form.
3574:     *--------------------------------------------------------------------------
3575:     PROCEDURE Unload()
3576:         IF EMPTY(THIS.this_cRetornoTef)
3577:             THIS.this_cRetornoTef = THIS.MontarRetornoTef()
3578:         ENDIF
3579: 
3580:         RETURN THIS.this_cRetornoTef
3581:     ENDPROC
3582: 
3583:     *--------------------------------------------------------------------------
3584:     * Move - migrado de SIGOPDTF.Move ("llCancela = .f."). llCancela eh a flag
3585:     * de cancelamento do FORM CHAMADOR no padrao Fortyus (nao eh lida em ponto
3586:     * nenhum deste SCX); no novo desenho ela vive no BO, como this_lCancelado.
3587:     *
3588:     * DESVIO DELIBERADO, registrado: o Move legado NAO chama DoDefault, isto eh
3589:     * ENGOLE o reposicionamento. Aqui o DODEFAULT eh mantido, porque a classe
3590:     * migrada usa AutoCenter = .T. e engolir o Move deixaria o dialogo
3591:     * ancorado no canto. O legado nao sofria disso por posicionar a tela na mao
3592:     * (TitleBar = 0 / ControlBox = .F. - o usuario nunca conseguiu arrasta-la).
3593:     *
3594:     * O DO CASE por PCOUNT() existe porque Move aceita 1, 2, 3 ou 4
3595:     * argumentos: repassar parametro AUSENTE ao DODEFAULT o converteria em .F.
3596:     * e o reposicionamento falharia com erro de tipo.
3597:     * PUBLIC: evento de form.
3598:     *--------------------------------------------------------------------------
3599:     PROCEDURE Move(par_nLeft, par_nTop, par_nWidth, par_nHeight)
3600:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3601:             THIS.this_oBusinessObject.this_lCancelado = .F.
3602:         ENDIF
3603: 
3604:         DO CASE
3605:         CASE PCOUNT() >= 4
3606:             DODEFAULT(par_nLeft, par_nTop, par_nWidth, par_nHeight)
3607:         CASE PCOUNT() = 3
3608:             DODEFAULT(par_nLeft, par_nTop, par_nWidth)
3609:         CASE PCOUNT() = 2
3610:             DODEFAULT(par_nLeft, par_nTop)
3611:         CASE PCOUNT() = 1
3612:             DODEFAULT(par_nLeft)
3613:         OTHERWISE
3614:             DODEFAULT()
3615:         ENDCASE
3616:     ENDPROC
3617: 
3618:     *==========================================================================
3619:     * O QUE NAO SE APLICA A ESTE FORM - e por que nao virou metodo vazio
3620:     *
3621:     * A Fase 8 pede, no texto generico do pipeline, "BtnBuscarClick,
3622:     * BtnEncerrarClick, BtnSalvarClick, BtnCancelarClick, CarregarLista,
3623:     * AjustarBotoesPorModo". Desses, so BtnCancelarClick existe aqui (entregue
3624:     * na Fase 7), e os outros cinco NAO tem contrapartida no legado:
3625:     *
3626:     *   - Buscar/Encerrar/Salvar: o SCX declara UM botao (CommandGroup SAIDA,
3627:     *     ButtonCount = 1, botao CANCELA) - medido no dump: zero objeto com
3628:     *     "BaseClass: commandbutton" e zero "<Verbo>.Click". Criar os tres
3629:     *     exigiria INVENTAR botoes (viola o PILAR 1).
3630:     *   - CarregarLista: nao ha lista. Zero "BaseClass: grid" e zero
3631:     *     "BaseClass: pageframe" na arvore do SCX, e os quatro testes estritos
3632:     *     de lista do pipeline (ListBoxLigaLista, TokenGradeProprioForm,
3633:     *     AddCursorLigaGrade, ControlSourceLigaLista) dao False neste dump. O
3634:     *     unico "ControlSource" que ele tem eh "SAIDA.ControlSource = [OPSENHA]"
3635:     *     num CommandGroup - vestigio da classe Grupo_Saida do Framework, nao
3636:     *     prova de grade.
3637:     *   - AjustarBotoesPorModo: nao ha modo CRUD. Zero "frmcadastro", zero
3638:     *     "Grupo_Op", zero "pcEscolha" no dump; o estado da tela eh a ETAPA do
3639:     *     protocolo, e quem o comanda eh HabilitarCampos + as transicoes

*-- Linhas 3649 a 3699:
3649:     *==========================================================================
3650: 
3651:     *--------------------------------------------------------------------------
3652:     * TornarControlesVisiveis - torna todos os controles visiveis
3653:     * recursivamente (AddObject cria com Visible=.F. por padrao).
3654:     * FILTRO: nenhum container flutuante neste form.
3655:     *--------------------------------------------------------------------------
3656:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3657:         LOCAL loc_i, loc_oControl
3658: 
3659:         FOR loc_i = 1 TO par_oContainer.ControlCount
3660:             loc_oControl = par_oContainer.Controls(loc_i)
3661:             IF VARTYPE(loc_oControl) = "O"
3662:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
3663:                     loc_oControl.Visible = .T.
3664:                 ENDIF
3665:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
3666:                     THIS.TornarControlesVisiveis(loc_oControl)
3667:                 ENDIF
3668:             ENDIF
3669:         ENDFOR
3670:     ENDPROC
3671: 
3672:     *--------------------------------------------------------------------------
3673:     * Destroy - libera recursos ao fechar o form (migrado de SIGOPDTF.Release:
3674:     * "ThisForm.poDataMgr.Release / dodefault()", que eh onde o legado solta o
3675:     * gerenciador de dados). O calculo do retorno equivalente a SIGOPDTF.Unload
3676:     * (this_cRetornoTef) entra quando os campos de captura (lcSaque/Cartao/
3677:     * Bandeira) existirem nas fases seguintes.
3678:     *--------------------------------------------------------------------------
3679:     PROCEDURE Destroy()
3680:         *-- FASE 8/8: o retorno da tela (SIGOPDTF.Unload) eh calculado AQUI,
3681:         *-- ANTES de soltar o BO - ele le this_cBandeira/this_cCartaoAux/
3682:         *-- this_cValorSaque de dentro dele. Depois do .NULL. abaixo,
3683:         *-- MontarRetornoTef so conseguiria devolver os defaults.
3684:         *-- Em VFP9 o Unload dispara DEPOIS do Destroy, por isso o valor eh
3685:         *-- cacheado na property em vez de recalculado la.
3686:         IF EMPTY(THIS.this_cRetornoTef)
3687:             THIS.this_cRetornoTef = THIS.MontarRetornoTef()
3688:         ENDIF
3689: 
3690:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3691:             THIS.this_oBusinessObject = .NULL.
3692:         ENDIF
3693:         IF USED("crSiTef")
3694:             USE IN crSiTef
3695:         ENDIF
3696:         DODEFAULT()
3697:     ENDPROC
3698: 
3699: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopdtfBO.prg):
*============================================================================
* sigopdtfBO.prg - Business Object para Transacao TEF (Terminal de Pagamento)
*
* Nao possui tabela principal propria - encapsula a interacao com a DLL
* CliSiTef32I.DLL (SiTef Interativo) e as consultas de apoio a
* SigCdEmp (empresa) e SigFiMpF (configuracao do caixa/terminal).
* O unico dado persistido pelo fluxo original e um cursor local
* temporario (crSiTef), usado como buffer de protocolo - nao uma
* tabela de negocio.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigopdtfBO AS BusinessBase

    *==========================================================================
    * Propriedades de entrada - recebidas do form/chamador (parametros da
    * transacao original: EndSiTef, ValPago, Cupom, Caixa, DebCred,
    * TipPagto, NumParcs, lcIdent, pcOpers)
    *==========================================================================
    this_cEndSiTef = ""    && Endereco do servidor SiTef
    this_nValPago  = 0     && Valor a ser pago na transacao
    this_cCupom    = ""    && Numero do cupom fiscal associado
    this_cCaixa    = ""    && Codigo do caixa (PDV) que originou a venda
    this_lDebCred  = .F.   && .T. = Debito / .F. = Credito
    this_cTipPagto = ""    && Tipo de pagamento informado pelo caixa
    this_nNumParcs = 0     && Numero de parcelas solicitado pelo caixa
    this_cIdent    = ""    && Identificador da transacao (lcIdent)
    this_cOpers    = ""    && Operador responsavel pelo caixa

    *==========================================================================
    * Propriedades de identificacao do terminal - lidas via SQL em
    * SigCdEmp.nEmps e SigFiMpF.Cncaixas (usadas para montar o
    * identificador do terminal exigido pela DLL do SiTef)
    *==========================================================================
    this_nEmpresa     = 0   && SigCdEmp.nEmps da empresa corrente
    this_cCaixaConfig = ""  && SigFiMpF.Cncaixas (numero do caixa configurado)
    this_cIdTerminal  = ""  && Identificador do terminal montado (empresa+caixa)

    *==========================================================================
    * Propriedades de estado/retorno da transacao TEF - preenchidas ao
    * longo do dialogo com a DLL e devolvidas ao chamador ao final
    *==========================================================================
    this_cTipTran        = ""   && Tipo da transacao retornado pelo SiTef
    this_cDataHora       = ""   && Data/hora da transacao retornada pelo SiTef
    this_cCupomRetorno    = ""   && Cupom confirmado pela transacao
    this_cCartao          = ""   && Numero do cartao (mascarado) utilizado
    this_cBandeira        = ""   && Bandeira do cartao identificada
    this_cNsu             = ""   && NSU (Numero Sequencial Unico) da transacao
    this_cAutoriza        = ""   && Codigo de autorizacao retornado
    this_cFinaliza        = ""   && Codigo de finalizacao da transacao
    this_cCodSeg          = ""   && Codigo de seguranca (CSEG) informado
    this_cDigitos         = ""   && Ultimos digitos do cartao informados
    this_cMensagemRetorno = ""   && Mensagem de retorno/erro da DLL SiTef

    *==========================================================================
    * Propriedades de parcelamento/data - espelham Optiongroup1/GetDatas
    * do formulario original (tipo de venda e 1a parcela/vencimento)
    *==========================================================================
    this_nTipoVenda   = 0    && 1 = A Vista / 2 = A Prazo (Optiongroup1.Value)
    this_dDataVencto  = {}   && Data da 1a parcela/vencimento
    this_lParcelado   = .F.  && .T. quando a venda foi parcelada
    this_nParcelas    = 0    && Numero de parcelas efetivamente confirmado

    *==========================================================================
    * Propriedade de controle de cancelamento (pcKeyEsc/Abandona do legado)
    *==========================================================================
    this_lCancelado = .F.   && .T. quando o usuario cancelou a operacao

    *==========================================================================
    * Configuracao da FORMA DE PAGAMENTO (FASE 8/8) - migrado do cursor global
    * crSigOpFp que o SIGOPDTF.Init popula com
    *     .poDatamgr.SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers], 'crSigOpFp')
    * e que TODOS os lacos do protocolo consultam (GetDigitos.Valid/GotFocus,
    * GetDatas.Valid/GotFocus, GetCodSeg.LostFocus). Sem estes valores o
    * protocolo responde ao terminal com o ramo ERRADO em cada pergunta -
    * sem erro na tela, gravando transacao divergente.
    *
    * Tipos conferidos em docs/schema.sql (UTF-16, lido com Get-Content -Raw -
    * regra #14): lcartao/lsaque/tcdc/garantias sao char(1) ("S"/"N"),
    * dias eh numeric(3,0), mesfec eh numeric(1,0), chkbins eh numeric(1,0)
    * e codestabs eh char(8). chkbins eh NUMERIC (nao bit), por isso eh
    * comparado com 1 e nao com .T. (regra #13).
    *==========================================================================
    this_lOpFpCartao     = .F.     && SigOpFp.lcartao   = "S" - forma aceita cartao
    this_lOpFpSaque      = .F.     && SigOpFp.lsaque    = "S" - permite saque
    this_cOpFpTcdc       = "N"     && SigOpFp.tcdc      - indica consulta CDC
    this_lOpFpGarantias  = .F.     && SigOpFp.garantias = "S"
    this_nOpFpDias       = 0       && SigOpFp.dias
    this_nOpFpMesFec     = 0       && SigOpFp.mesfec
    this_nOpFpChkBins    = 0       && SigOpFp.chkbins   - 1 = validar BIN do cartao
    this_cOpFpCodEstabs  = ""      && SigOpFp.codestabs - "lsLoja" do ConfiguraIntSiTefInterativo

    *==========================================================================
    * Estado intermediario do protocolo que o legado guardava em variaveis
    * PUBLIC / properties soltas do Form (FASE 8/8)
    *==========================================================================
    this_lDataConfirmada = .F.      && DCD do legado - .T. apos o terminal confirmar a data
    this_cCartaoAux      = ""       && ThisForm.lsCartao - Left(Buffer, 5) em TipoCampo = 131
    this_cValorSaque     = "0,00"   && lcSaque - valor de saque (sub-dialogo SigCsTef nao portado)

    *==========================================================================
    * Estado do protocolo interativo (migrado das variaveis PUBLIC do legado:
    * ProximoComando, TipoCampo, TamanhoMinimo, TamanhoMaximo, Buffer,
    * lnContinua). Centralizado aqui porque ContinuarSiTef() precisa passar
    * os quatro primeiros POR REFERENCIA para a DLL, e VFP9 nao garante
    * passagem por referencia de property de objeto direto para DLL externa
    * (mesmo criterio de SigOpCtfBO.ContinuarSiTef/sigprdftBO.ContinuarSiTef).
    *==========================================================================
    this_nProximoComando = 0
    this_nTipoCampo      = 0
    this_nTamanhoMinimo  = 0
    this_nTamanhoMaximo  = 0
    this_cBuffer         = SPACE(2000)
    this_nContinua       = 0

    *==========================================================================
    * Init - Inicializa o Business Object
    * sigopdtf nao possui tabela de negocio propria (dialogo de integracao
    * com a DLL do SiTef) - this_cTabela/this_cCampoChave permanecem vazios
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            THIS.DeclararFuncoesSiTef()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DeclararFuncoesSiTef - DECLARE-DLL das funcoes do protocolo interativo,
    * migrado de SIGOPDTF.Load.
    *
    * CORRIGIDO NA FASE 8/8: eram 3 declaracoes e sao QUATRO. O comentario
    * original afirmava que "este form, ao contrario de SIGPRDFT, NAO declara
    * FinalizaTransacaoSiTefInterativo" - e isso esta errado: a 4a linha do
    * SIGOPDTF.Load eh
    *     DECLARE integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL"
    *         Integer lnConfirma, String lsCupom, String lsData, String lsHorario
    * (com "integer" minusculo, o que provavelmente escondeu a linha de quem
    * conferiu). A funcao eh CHAMADA pelo GetDatas.Valid, no ramo em que a
    * senha do supervisor vem em branco - sem este DECLARE aquele caminho
    * estouraria em runtime com "FinalizaTransacaoSiTefInterativo is not
    * found", e o terminal ficaria com a transacao EM ABERTO em vez de
    * finalizada.
    * Redeclarar a mesma assinatura eh inofensivo em VFP9; a falha real (DLL
    * ausente) so aparece quando a funcao eh CHAMADA, nao na declaracao - por
    * isso o TRY aqui eh so para nao derrubar InicializarForm em maquina sem
    * o CliSiTef32I.DLL (mesmo criterio de SigOpCtfBO.DeclararFuncoesSiTef).
    *==========================================================================
    PROTECTED PROCEDURE DeclararFuncoesSiTef()
        LOCAL loc_oErro

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
        CATCH TO loc_oErro
            *-- DLL nao presente nesta maquina (dev/pipeline sem PIN-pad
            *-- SiTef). CATCH sem MsgErro de proposito: o DECLARE falhando
            *-- aqui nao impede a tela de abrir, e em producao a DLL existe.
            *--
            *-- CORRIGIDO NA FASE 8/8 o que este comentario afirmava antes
            *-- ("a chamada real avisa o usuario via ConectarSiTef"): isso eh
            *-- FALSO e foi medido. Sem o DECLARE, o nome da funcao vira nome
            *-- de .prg para o VFP (regra #13) e a primeira chamada estoura
            *-- "File 'continuafuncaositefinterativo.prg' does not exist" -
            *-- mensagem que nao cita DLL nem SiTef e manda o diagnostico
            *-- para o lado errado. Nao foi acrescentada guarda nova aqui
            *-- porque o legado tambem nao tem (em producao a DLL sempre
            *-- existe) e inventa-la divergiria do PILAR 1; o que se conserta
            *-- eh a afirmacao errada, para o proximo leitor nao confiar nela.
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarIdentificacaoTerminal - Migrado do trecho de SIGOPDTF.GetDigitos.
    * GotFocus que monta o identificador de terminal antes de chamar
    * ConfiguraIntSiTefInterativo:
    *     lcIdTerminal = fConverteStr(CrSigCdEmp.nEmps) + ;
    *         TRANSFORM(VAL(crSigFiMpF.Cncaixas), "@L 999999")
    *
    * crSigCdEmp/crSigFiMpF sao cursores globais do Framework legado, nunca
    * populados em nenhum ponto do dump deste form (mesma categoria de
    * dependencia ausente tratada em SigOpCtfBO.CarregarCaixaSiTef). Em vez
    * de depender de cursor global nao documentado, consulta SigCdEmp/
    * SIGFIMPF diretamente pela empresa corrente (go_4c_Sistema.cCodEmpresa)
    * e, quando este_cCaixa (parametro "Caixa" recebido no Init) bate com
    * algum SIGFIMPF.cncaixas da empresa, usa esse registro; caso contrario,
    * cai no mesmo fallback "melhor esforco" do sibling (1o registro da
    * empresa, ou "000000" se nao achar nenhum).
    *==========================================================================
    FUNCTION CarregarIdentificacaoTerminal()
        LOCAL loc_oErro, loc_cSQLEmpresa, loc_cSQLCaixa

        THIS.this_nEmpresa     = 0
        THIS.this_cCaixaConfig = "000000"

        TRY
            IF USED("cursor_4c_SigCdEmpTef")
                USE IN cursor_4c_SigCdEmpTef
            ENDIF
            loc_cSQLEmpresa = "SELECT nemps FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa)
            SQLEXEC(gnConnHandle, loc_cSQLEmpresa, "cursor_4c_SigCdEmpTef")

            IF USED("cursor_4c_SigCdEmpTef") AND !EOF("cursor_4c_SigCdEmpTef")
                THIS.this_nEmpresa = TratarNulo(cursor_4c_SigCdEmpTef.nemps, 0)
            ENDIF
            IF USED("cursor_4c_SigCdEmpTef")
                USE IN cursor_4c_SigCdEmpTef
            ENDIF

            IF USED("cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCaixa))
                loc_cSQLCaixa = "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa) + " AND cncaixas = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cCaixa))
            ELSE
                loc_cSQLCaixa = "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa)
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQLCaixa, "cursor_4c_SigFiMpF")

            IF USED("cursor_4c_SigFiMpF") AND !EOF("cursor_4c_SigFiMpF")
                THIS.this_cCaixaConfig = TRANSFORM(VAL(TratarNulo(cursor_4c_SigFiMpF.cncaixas, "0")), "@L 999999")
            ENDIF
            IF USED("cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF
        CATCH TO loc_oErro
            *-- Sem a tabela/registro, segue com os fallbacks acima - mesmo
            *-- desfecho pratico do legado quando os cursores globais estao vazios.
        ENDTRY

        THIS.this_cIdTerminal = fConvertestr(THIS.this_nEmpresa) + THIS.this_cCaixaConfig

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * CarregarConfiguracaoPagamento - FASE 8/8. Migrado de SIGOPDTF.Init:
    *     .poDatamgr.SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers], 'crSigOpFp')
    *     If Empty(crSigOpFp.CodEstabs)
    *         lsIdTerminal = "00000" + _Empr
    *     Else
    *         lsIdTerminal = crSigOpFp.CodEstabs
    *     Endif
    *
    * lcOpers eh o parametro "pcOpers" recebido no Init (this_cOpers) - o
    * codigo da FORMA DE PAGAMENTO escolhida no caixa, nao um operador de
    * usuario, apesar do nome. Seis das colunas lidas aqui decidem o ramo que
    * o protocolo toma em cada pergunta do terminal; a setima (codestabs) eh
    * o argumento "lsLoja" do ConfiguraIntSiTefInterativo.
    *
    * SELECT com a lista EXPLICITA de colunas em vez do "Select *" do legado:
    * sao as unicas 7 que o dump consulta, de uma tabela com 121 colunas.
    *
    * NAO derruba o form quando a consulta falha: os defaults declarados na
    * classe ("N"/0/.F.) sao o mesmo desfecho pratico que o legado tem quando
    * o cursor global vem vazio - mesmo criterio de
    * CarregarIdentificacaoTerminal.
    *==========================================================================
    FUNCTION CarregarConfiguracaoPagamento()
        LOCAL loc_oErro, loc_cSQL, loc_lAchou

        loc_lAchou = .F.

        TRY
            IF USED("cursor_4c_SigOpFp")
                IF CURSORGETPROP("Buffering", "cursor_4c_SigOpFp") > 1
                    TABLEREVERT(.T., "cursor_4c_SigOpFp")
                ENDIF
                USE IN cursor_4c_SigOpFp
            ENDIF

            loc_cSQL = "SELECT lcartao, lsaque, tcdc, garantias, dias, mesfec, " + ;
                       "chkbins, codestabs FROM SigOpFp WHERE fpags = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cOpers))

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFp")

            IF USED("cursor_4c_SigOpFp") AND !EOF("cursor_4c_SigOpFp")
                THIS.this_lOpFpCartao    = (UPPER(TratarNulo(cursor_4c_SigOpFp.lcartao, "N")) = "S")
                THIS.this_lOpFpSaque     = (UPPER(TratarNulo(cursor_4c_SigOpFp.lsaque, "N")) = "S")
                THIS.this_cOpFpTcdc      = UPPER(TratarNulo(cursor_4c_SigOpFp.tcdc, "N"))
                THIS.this_lOpFpGarantias = (UPPER(TratarNulo(cursor_4c_SigOpFp.garantias, "N")) = "S")
                THIS.this_nOpFpDias      = TratarNulo(cursor_4c_SigOpFp.dias, 0)
                THIS.this_nOpFpMesFec    = TratarNulo(cursor_4c_SigOpFp.mesfec, 0)
                THIS.this_nOpFpChkBins   = TratarNulo(cursor_4c_SigOpFp.chkbins, 0)
                THIS.this_cOpFpCodEstabs = ALLTRIM(TratarNulo(cursor_4c_SigOpFp.codestabs, ""))
                loc_lAchou = .T.
            ENDIF

            IF USED("cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao ler a forma de pagamento")
        ENDTRY

        RETURN loc_lAchou
    ENDFUNC

    *==========================================================================
    * ValidarBinCartao - FASE 8/8. Migrado do bloco "IF TipoCampo = 136" que o
    * legado REPETE LITERALMENTE em quatro lacos (GetDigitos.Valid,
    * GetDigitos.GotFocus, GetDatas.Valid, GetDatas.GotFocus):
    *     lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
    *     If csTmpFPag.ChkBins = 1
    *         lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '...'
    *                    And CodBins = '] + Alltrim(Strtran(Buffer, Chr(0), '')) + [']
    *         If Eof() Or Not Between(Dtos(Date()), Dtos(Nvl(csTmpFPagb.Datais, Ctod('01/01/1900'))),
    *                                               Dtos(Nvl(csTmpFPagb.DataFs, Ctod('31/12/9999'))))
    *             -> aborta a transacao ("Cartao Invalido para esta Condicao de Pagamento")
    *         EndIf
    *     Endif
    *
    * Devolve .T. quando o BIN eh ACEITO (inclusive quando a checagem esta
    * desligada, que eh o caminho em que o legado nao faz nada) e .F. quando o
    * cartao nao vale para esta condicao de pagamento. Os quatro call sites
    * consomem a MESMA funcao de proposito: quatro copias divergiriam em
    * silencio na primeira mudanca de regra (CLAUDE.md #44, item 6).
    *
    * O ChkBins NAO eh reconsultado aqui: a coluna ja vem de
    * CarregarConfiguracaoPagamento (mesma tabela, mesma chave fpags) - o
    * legado refazia o SELECT a cada passagem do laco porque nao guardava o
    * valor em lugar nenhum.
    *
    * Janela de validade: datais/datafs sao datetime (schema.sql). Nulo cai nos
    * mesmos sentinelas do legado (01/01/1900 e 31/12/9999), e a comparacao eh
    * por DTOS, como no original - comparar DATE com DATETIME daria erro 11
    * (regra #16), por isso ConverterParaData normaliza os dois lados.
    *==========================================================================
    FUNCTION ValidarBinCartao(par_cBin)
        LOCAL loc_oErro, loc_cSQL, loc_cBin, loc_lValido, loc_dIni, loc_dFim, loc_cHoje

        *-- Checagem desligada na forma de pagamento: o legado nao consulta
        *-- nada e segue a transacao.
        IF THIS.this_nOpFpChkBins != 1
            RETURN .T.
        ENDIF

        loc_cBin    = ALLTRIM(STRTRAN(IIF(VARTYPE(par_cBin) = "C", par_cBin, ""), CHR(0), ""))
        loc_lValido = .F.

        TRY
            IF USED("cursor_4c_SigOpFpb")
                IF CURSORGETPROP("Buffering", "cursor_4c_SigOpFpb") > 1
                    TABLEREVERT(.T., "cursor_4c_SigOpFpb")
                ENDIF
                USE IN cursor_4c_SigOpFpb
            ENDIF

            loc_cSQL = "SELECT codbins, datais, datafs FROM SigOpFpb WHERE fpags = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cOpers)) + " AND codbins = " + ;
                       EscaparSQL(loc_cBin)

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFpb")

            IF USED("cursor_4c_SigOpFpb") AND !EOF("cursor_4c_SigOpFpb")
                loc_dIni  = ConverterParaData(TratarNulo(cursor_4c_SigOpFpb.datais, CTOD("01/01/1900")))
                loc_dFim  = ConverterParaData(TratarNulo(cursor_4c_SigOpFpb.datafs, CTOD("31/12/9999")))
                IF EMPTY(loc_dIni)
                    loc_dIni = CTOD("01/01/1900")
                ENDIF
                IF EMPTY(loc_dFim)
                    loc_dFim = CTOD("31/12/9999")
                ENDIF
                loc_cHoje   = DTOS(DATE())
                loc_lValido = BETWEEN(loc_cHoje, DTOS(loc_dIni), DTOS(loc_dFim))
            ENDIF

            IF USED("cursor_4c_SigOpFpb")
                USE IN cursor_4c_SigOpFpb
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao validar o BIN do cart" + CHR(227) + "o")
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * ConectarSiTef - Migrado de SIGOPDTF.GetDigitos.GotFocus:
    *     IF ConfiguraIntSiTefInterativo(lsEndSitef, lsIdTerminal, lcIdTerminal, 0) <> 0
    *
    * CORRIGIDO NA FASE 8/8. A Fase 1 escreveu, com razao para o que tinha em
    * maos, que "lsIdTerminal (2o argumento, lsLoja) nao tem fonte explicita
    * visivel no dump disponivel para esta fase" e usou o parametro "Caixa"
    * como fallback. O dump COMPLETO, lido nesta fase, tem a fonte - esta no
    * SIGOPDTF.Init, longe do GotFocus que faz a chamada:
    *     If Empty(crSigOpFp.CodEstabs)
    *         lsIdTerminal = "00000" + _Empr
    *     Else
    *         lsIdTerminal = crSigOpFp.CodEstabs
    *     Endif
    * Ou seja "lsLoja" eh o CODIGO DE ESTABELECIMENTO da forma de pagamento
    * (SigOpFp.codestabs, char(8)), nao o numero do caixa. Mantido o fallback
    * "00000" + empresa, que eh o do proprio legado.
    *
    * Nao eh detalhe cosmetico: este argumento identifica a LOJA no servidor
    * SiTef. Enviar o numero do caixa no lugar do estabelecimento faz o
    * servidor recusar a conexao (ou credenciar a transacao na loja errada),
    * e o usuario veria so "Sem comunicacao com SiTef".
    *
    * lcIdTerminal (3o argumento, "lsTerminal") eh THIS.this_cIdTerminal,
    * calculado em CarregarIdentificacaoTerminal.
    *==========================================================================
    FUNCTION ConectarSiTef()
        LOCAL loc_cLoja, loc_nRetorno

        IF !EMPTY(ALLTRIM(THIS.this_cOpFpCodEstabs))
            loc_cLoja = ALLTRIM(THIS.this_cOpFpCodEstabs)
        ELSE
            loc_cLoja = "00000" + ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ENDIF

        loc_nRetorno = ConfiguraIntSiTefInterativo(ALLTRIM(THIS.this_cEndSiTef), ;
            loc_cLoja, THIS.this_cIdTerminal, 0)

        RETURN (loc_nRetorno = 0)
    ENDFUNC

    *==========================================================================
    * IniciarSiTef - Migrado de SIGOPDTF.GetDigitos.GotFocus:
    *     lcValpago = Alltrim(Transform(lnValPago,"99999999.99"))
    *     lcValPago = Strtran(lcValPago,".",",")
    *     lcData    = Str(Year(Date()),4) + Substr(Dtoc(Date()),4,2) + Substr(Dtoc(Date()),1,2)
    *     lchora    = Strtran(Time(),":","")
    *     IF IniciaFuncaoSiTefInterativo(0, lcValPago, lsCupom, lcData, lchora, ...) <> 10000
    *
    * Modalidade (0) eh LITERAL no legado. par_cData/par_cHora chegam ja
    * formatados pelo Form (mesmo calculo acima, repetido em todo ponto do
    * dump que inicia a transacao). 6o argumento (lsOperador) segue o mesmo
    * criterio de sigprdftBO.IniciarSiTef - usa THIS.this_cCaixa, unico dado
    * de identificacao do caixa recebido no Init.
    *==========================================================================
    FUNCTION IniciarSiTef(par_cData, par_cHora)
        LOCAL loc_cValPago, loc_nRetorno

        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValPago, "99999999.99")), ".", ",")

        loc_nRetorno = IniciaFuncaoSiTefInterativo(0, loc_cValPago, THIS.this_cCupom, ;
            par_cData, par_cHora, ALLTRIM(THIS.this_cCaixa), "")

        RETURN (loc_nRetorno = 10000)
    ENDFUNC

    *==========================================================================
    * ContinuarSiTef - Migrado das chamadas ContinuaFuncaoSiTefInterativo
    * espalhadas pelo legado (GetDigitos.Valid, GetCodSeg.LostFocus,
    * GetDatas.Valid/GotFocus, Text1.Valid, SAIDA.Click). Centraliza a
    * chamada por referencia (LOCAL -> DLL -> THIS.this_n*/this_cBuffer) -
    * mesmo criterio de SigOpCtfBO.ContinuarSiTef/sigprdftBO.ContinuarSiTef.
    *==========================================================================
    FUNCTION ContinuarSiTef(par_nContinua)
        LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
              loc_nTamanhoMaximo, loc_cBuffer, loc_nRetorno

        loc_nProximoComando = THIS.this_nProximoComando
        loc_nTipoCampo      = THIS.this_nTipoCampo
        loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
        loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), SPACE(2000), THIS.this_cBuffer)

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
            @loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), par_nContinua)

        THIS.this_nProximoComando = loc_nProximoComando
        THIS.this_nTipoCampo      = loc_nTipoCampo
        THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
        THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
        THIS.this_cBuffer         = loc_cBuffer

        RETURN loc_nRetorno
    ENDFUNC

    *==========================================================================
    * FinalizarTransacaoSiTef - FASE 8/8. Encapsula a 4a funcao da DLL,
    * chamada pelo SIGOPDTF.GetDatas.Valid quando a senha do supervisor vem em
    * branco (o operador desistiu):
    *     FinalizaTransacaoSiTefInterativo(0, IIF(EMPTY(SigTef.nCupom),"1",SigTef.nCupom),
    *                                      lcData, lcHora)
    * O 1o argumento (lnConfirma) eh 0 = NAO confirmar, isto eh desfazer a
    * transacao em aberto no terminal. Literal no legado, e o unico call site.
    *
    * par_cCupom chega do Form: o legado o le do DBF SigTef
    * (goSistema.DirTefEcfs + "\SigTef"), arquivo do modulo fiscal que nao faz
    * parte do acervo migrado, caindo em "1" quando vazio - que eh o valor que
    * o Form passa.
    *==========================================================================
    FUNCTION FinalizarTransacaoSiTef(par_nConfirma, par_cCupom, par_cData, par_cHora)
        LOCAL loc_nRetorno

        loc_nRetorno = FinalizaTransacaoSiTefInterativo( ;
            IIF(VARTYPE(par_nConfirma) = "N", par_nConfirma, 0), ;
            IIF(VARTYPE(par_cCupom) = "C" AND !EMPTY(par_cCupom), par_cCupom, "1"), ;
            IIF(VARTYPE(par_cData) = "C", par_cData, ""), ;
            IIF(VARTYPE(par_cHora) = "C", par_cHora, ""))

        RETURN loc_nRetorno
    ENDFUNC

    *==========================================================================
    * MontarBufferSiTef - carrega this_cBuffer com o valor digitado pelo
    * usuario, completado com CHR(0) ate o tamanho que
    * ContinuaFuncaoSiTefInterativo espera. Migrado do padrao repetido em
    * cada LostFocus/Valid do legado (SENHA/GetDigitos/GetCartao/GetCodSeg):
    *     Buffer = Alltrim(This.Value) + Replicate(Chr(0), 2000 - Len(Alltrim(This.Value)))
    *==========================================================================
    FUNCTION MontarBufferSiTef(par_cValor, par_nComplemento)
        LOCAL loc_cValor, loc_nComplemento

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), ;
            ALLTRIM(TRANSFORM(par_cValor)))

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

    *==========================================================================
    * NOTA DE ARQUITETURA - SOMENTE INTEGRACAO COM DLL (sem tabela propria)
    *
    * O dump disponivel para esta fase (comportamento.json) nao mostra
    * nenhum INSERT/UPDATE/DELETE/TABLEUPDATE contra o SQL Server em metodo
    * algum de SIGOPDTF - as 5 queries capturadas sao todas
    * "INSERT INTO crSiTef (...)", um CURSOR LOCAL de memoria (CREATE CURSOR
    * crSiTef) usado so como buffer de protocolo para montar a mensagem de
    * falha exibida ao usuario (RetornoFalha), nunca persistido no banco.
    * A tela processa um pagamento em cartao via DLL (CliSiTef32I.DLL) -
    * mesma natureza de SigOpCtfBO (cancelamento) e sigprdftBO (pagamento a
    * debito), ambos ja migrados com este mesmo criterio.
    *
    * Por isso:
    *   - Inserir(), Atualizar() e ExecutarExclusao() NAO sao sobrescritos
    *     aqui - o comportamento herdado de BusinessBase (recusar a operacao
    *     e deixar o motivo em this_cMensagemErro, reportado pelo
    *     ExibirFalha de Salvar()/Excluir()) ja eh o correto. Sobrescrever
    *     exigiria inventar uma tabela/lista de colunas que o legado nunca
    *     grava, o que a regra #22 do CLAUDE.md proibe;
    *   - RegistrarAuditoria() tambem fica herdado e nunca eh chamado por
    *     este BO: sem Inserir()/Atualizar() proprios nao ha operacao de
    *     escrita para auditar;
    *   - CarregarDoCursor() nao se aplica: os dados digitados na tela
    *     (Valor, Digitos, Cartao, TipoVenda, Parcelas, Data) sao atribuidos
    *     diretamente as properties this_n*/this_c*/this_d* pelo proprio Form
    *     (FormParaBO/BOParaForm), e o retorno da transacao TEF vem do
    *     protocolo ContinuaFuncaoSiTefInterativo via DLL, nao de um SELECT -
    *     nao ha cursor de banco a percorrer aqui.
    *==========================================================================

    *==========================================================================
    * ObterChavePrimaria - SIGOPDTF nao grava registro nenhum (integracao com
    * o terminal SiTef via CliSiTef32I.DLL). Nao existe chave primaria porque
    * nao existe tabela; retornar vazio mantem RegistrarAuditoria() inofensivo
    * (ela ja aborta quando a chave vem vazia - ver BusinessBase.RegistrarAuditoria).
    * PROTECTED: nunca chamado de fora (regra #51 do CLAUDE.md).
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

ENDDEFINE

