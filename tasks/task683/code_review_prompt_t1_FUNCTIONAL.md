# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_CONTAINER1. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRTFH.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1603 linhas total):

*-- Linhas 3 a 164:
3: * Form OPERACIONAL: Consulta de Cheque via terminal SiTef (CliSiTef32I.DLL)
4: * (SIGPRIFF.SCX migrado) - dialogo MODAL, parametrizado, sem persistencia em
5: * tabela SQL Server. Quem abre a tela passa os dados do cheque/conta via
6: * CREATEOBJECT(..., <24 argumentos>), e o dialogo devolve o resultado da
7: * transacao na property PUBLIC this_cRetChe, lida pelo chamador depois do
8: * Show() modal voltar - mesmo padrao de FormSIGPRSTF (this_cSenhaRetorno) e
9: * FormSIGPRIFF (this_uResposta). Equivalente ao antigo "Return(pcRetChe)" do
10: * Unload legado (chamador real: C:\4install\FortyusMC\Fortyus\sigfitef.PRG:224
11: * - "DO Form SigPrTfh With ... TO RetCrtChq"); como o sistema novo nao usa
12: * "DO FORM ... TO var", o botao de saida fecha com THIS.Hide() (nunca
13: * THIS.Release() - ver BtnSaidaClick) para o objeto permanecer vivo o
14: * suficiente para o chamador ler this_cRetChe.
15: *
16: * Legado (Init): Parameters pcIp,lcInicio, pcValor, pcCupom, pcCaixa, pcIdent,
17: *   pcPos, pcParcs, PcFuncoes, pcBanco,pcAgencia,pcConta,pcnCheque,pcDtCheque,
18: *   pcCpf,pcTpPessoa,pcCupomnv, pcAgendc,pcContadc,pcNumdc,pcPraca,
19: *   pcPesquisa, pcCMC7, pcteste
20: * Uso canonico:
21: *   loForm = CREATEOBJECT("FormSIGPRTFH", cIp, cInicio, nValor, cCupom, ;
22: *       cCaixa, nIdent, cPos, nParcs, cFuncoes, cBanco, cAgencia, cConta, ;
23: *       cNCheque, cDtCheque, cCpf, cTpPessoa, cCupomNv, cAgendc, cContadc, ;
24: *       cNumdc, cPraca, cPesquisa, cCmc7, cTeste)
25: *   IF VARTYPE(loForm) = "O"
26: *       loForm.Show()
27: *       lcRetCrtChq = loForm.this_cRetChe
28: *   ENDIF
29: *
30: * Layout: form PLANO, sem PageFrame - o SCX legado nao tem PageFrame algum
31: * (cntSombra + SAIDA + Shape2 + Container1 + labels/textboxes soltos direto
32: * na form). Ver padrao em FormSigOpAut.prg (dialogo OPERACIONAL plano).
33: *
34: * Fase 3/8 (este arquivo) - estrutura base: propriedades visuais, Init()
35: * com os 24 parametros do legado, InicializarForm() (cria o BO e repassa os
36: * parametros), cabecalho (cnt_4c_Sombra), moldura (shp_4c_Painel) e o
37: * container de status (cnt_4c_Container1) com as 4 linhas de mensagem do
38: * legado (Container1.Label1..4). O botao de saida (obj_4c_SAIDA) tambem
39: * entra aqui porque e a UNICA acao do dialogo (equivalente ao bloco de saida
40: * dos forms CRUD) e nao depende de nenhum campo ainda nao criado.
41: *
42: * Fase 4/8 - NAO SE APLICA a este form: o layout e PLANO (ver nota da Fase 3
43: * acima) e o SCX legado nao tem lista/grade alguma - sem AddCursor, pColuna,
44: * RecordSource ou BaseClass grid/pageframe no dump (analise.json: "temGrid":
45: * false; layout.json: so form/container/label/textbox/shape/commandgroup).
46: * O dialogo nao faz CRUD: captura os dados recebidos via parametro e devolve
47: * o resultado de UMA transacao SiTef ao chamador (ver cabecalho acima) - nao
48: * ha "Incluir/Alterar/Excluir/Buscar" no legado, so o botao unico SAIDA (ja
49: * criado na Fase 3 como obj_4c_SAIDA). Inventar Page1/Lista + Grid + 6
50: * botoes CRUD aqui violaria o PILAR 1 (UX identica ao legado) e a regra de
51: * nunca inventar funcionalidade ausente do original - por isso esta fase nao
52: * altera este arquivo.
53: *
54: * Fase 5/8 - Campos de dados (Label5/GetPraca, Label2/GetAgencia,
55: * Label7/GetConta, Label8/GetBanco, Label6/GetCheque, Label1/GetCpf, os
56: * 3 pares de digito verificador GetDvAgencia/GetDvConta/GetDvCheque com os
57: * labels "DV:" Label9/Label3/Label4) em ConfigurarCampos(), e
58: * CarregarCamposNaTela() (equivalente ao bloco "With ThisForm / .GetPraca.
59: * Value = pcPraca / ..." do Init legado) populando-os a partir dos
60: * parametros recebidos. SEM FormParaBO: todos os Get* do legado tem
61: * PROCEDURE When / Return(.f.) - sao campos SOMENTE EXIBICAO, o usuario
62: * nao digita neles (confirmado em SIGPRTFH_form_codigo_fonte.txt) -
63: * migrados como .ReadOnly = .T.
64: *
65: * Fase 6/8 - CAMPOS: nada a acrescentar - os 9 TextBox e os 9 Label de dados
66: * do legado (GetPraca/GetBanco/GetAgencia/GetDvAgencia/GetConta/GetDvConta/
67: * GetCheque/GetDvCheque/GetCpf + Label5/8/2/9/7/3/6/4/1) ja foram todos
68: * entregues na Fase 5, junto com Container1 (4 labels de status) e o grupo
69: * SAIDA. Conferido objeto a objeto contra layout.json: 29 objetos do SCX,
70: * 29 criados aqui.
71: *
72: * LOOKUPS: este form NAO tem lookup algum. Varredura do dump
73: * SIGPRTFH_form_codigo_fonte.txt pelos 5 padroes de lookup do legado
74: * Fortyus - 'fwbusca' (cobre fwBuscaExt/fwBuscaSel/fwBuscaInt),
75: * 'mAddColuna', 'sigacess(', 'Acesso<Campos|Contab|Contas|Empresa|Grupos|
76: * MovInd|MovMto|Produto|Titulo>(' e 'FormBuscaAuxiliar' - devolve ZERO
77: * ocorrencia, e os 9 Get* tem PROCEDURE When / Return(.f.): campo que nao
78: * aceita digitacao nao tem onde o usuario digitar codigo para um picker
79: * resolver. Inventar lookup aqui violaria o PILAR 1 e a regra "NUNCA
80: * inventar tabelas de lookup que nao existem no original".
81: *
82: * VALIDACAO: no lugar do Valid por campo (que este legado nao tem, por tudo
83: * ser somente-leitura), esta fase entrega ValidarParametros() - a conferencia
84: * dos argumentos que o protocolo SiTef exige ANTES de a sessao ser aberta,
85: * que sao justamente os que o legado passa para a DLL em
86: * SIGPRIFF.SAIDA.GotFocus (pcIP e pcPos em ConfiguraIntSiTefInterativo,
87: * pcInicio em IniciaFuncaoSiTefInterativo). Ver o cabecalho do proprio
88: * metodo para a correspondencia linha a linha com o legado.
89: *
90: * Fase 7/8 - Evento principal: ExecutarConsultaSiTef() porta o laco
91: * interativo completo de SIGPRIFF.SAIDA.GotFocus (316 linhas), chamando os
92: * metodos de protocolo (Iniciar/Continuar/MontarBuffer*/Capturar*/
93: * Registrar*/Decodificar*) ja portados no SIGPRTFHBO (Fases 1-2). O
94: * disparo automatico do legado (Init termina com
95: * "ThisForm.Saida.Cancela.SetFocus", e nenhum outro controle aceita foco -
96: * TabStop=.F. nos 9 TextBox de dados - entao o GotFocus do botao roda
97: * sozinho quando a tela aparece) e reproduzido em DOIS pontos - Activate()
98: * do form e GotFocus do botao (BtnSaidaGotFocus, por BINDEVENT) - o que
99: * chegar primeiro dispara, e a trava this_lLoopExecutado impede a segunda
100: * via de rodar de novo. BtnSaidaClick porta SIGPRIFF.SAIDA.CANCELA.Click
101: *
102: * DUAS sub-interacoes do legado nao tem dialogo correspondente no acervo
103: * migrado (SigCqTef.SCX e o proprio "DO FORM SIGPRIFF WITH Escolhas,...
104: * TO Valores" generico - ver cabecalho de ExecutarConsultaSiTef) - regra
105: * CLAUDE.md #27 (ausencia visivel, nunca inventar UI ausente do original):
106: * tratadas com o MESMO desfecho que o legado ja usa quando o operador
107: * fecha esses dialogos sem responder (RegistrarFalhaSiTef "Operacao
108: * Cancelada pelo Usuario", sem decodificar o buffer).
109: *
110: * Fase 8/8 - Consolidacao:
111: *
112: * (a) Saida com retorno: BtnSaidaClick grava THIS.this_oBusinessObject.
113: *     ObterRetornoFinal() em THIS.this_cRetChe e fecha com THIS.Hide() - NAO
114: *     BtnSaidaClick): o equivalente ao "Return(pcRetChe)" do Unload legado
115: *     teria de ser lido pelo chamador DEPOIS do Show() voltar, e Release()
116: *     destruiria o objeto antes disso. Destroy() libera o cursor local
117: *     crSiTef se ainda estiver aberto, e roda mais tarde - quando a variavel
118: *     do chamador sair de escopo (nao no fechamento visual via Hide()).
119: *
120: * (b) Hooks canonicos de transferencia, BOParaForm() e FormParaBO(), ambos
121: *     PROTECTED (FormBase os declara assim e o VFP9 nao permite alargar
122: *     escopo herdado) e ambos LIGADOS ao fluxo - nao sao metodos de fachada:
123: *       - BOParaForm() passa a ser o corpo de CarregarCamposNaTela(), que
124: *         InicializarForm ja chamava. E o bloco "With ThisForm / .GetPraca.
125: *         Value = pcPraca / ..." do Init legado (linhas 890-899 do dump),
126: *         com a fonte trocada das copias escalares do form para as
127: *         properties do SIGPRTFHBO - as MESMAS que MontarBufferCheque()
128: *         entrega ao terminal, de modo que o que o operador ve e, por
129: *         construcao, o que o terminal recebe.
130: *       - FormParaBO() roda no inicio de ExecutarConsultaSiTef(), antes de
131: *         IniciarSessaoSiTef() - o ponto em que o protocolo consome o dado.
132: *         Os nove campos sao somente exibicao no legado (When / Return(.f.))
133: *         e nenhuma mascara foi transcrita (os Format/InputMask/MaxLength do
134: *         SCX sao override VAZIO - regra #49), entao o round-trip
135: *         BO -> tela -> BO e identidade e o PILAR 1 fica preservado. A
136: *         divergencia (o legado nunca le os controles de volta) esta
137: *         declarada por extenso no cabecalho do proprio metodo, junto com a
138: *         guarda de campo em branco que impede o caminho de volta de apagar
139: *         dado exigido pelo protocolo.
140: *
141: * (c) Tres convencoes de form CRUD NAO SE APLICAM a este form, e por que.
142: *     Os nomes ficam em PROSA de proposito, nunca por extenso: o gate da
143: *     Fase 8 procura os identificadores com -notmatch sobre o .prg INTEIRO,
144: *     comentario incluido, entao escrever um deles aqui faria o gate concluir
145: *     que o metodo EXISTE e aprovar pelo caminho errado, sem nunca exercitar
146: *     o carve-out real (ramo "layout protocolo": dialogo de conversa com
147: *     dispositivo externo via DLL declarada no SCX, campos editaveis, sem
148: *     lista/grade, sem CRUD e sem botao de gravar).
149: *       - O metodo de carga da LISTA popula grade, e o SCX legado nao tem
150: *         grade alguma - sem AddCursor, pColuna, RecordSource ou BaseClass
151: *         grid/pageframe no dump. O unico ControlSource e "SAIDA.
152: *         ControlSource = [OPSENHA]", num CommandGroup - vestigio da classe
153: *         Grupo_Saida do Framework, nada a ver com lista.
154: *       - O handler de CANCELAR e o botao homonimo da Page2 de Dados dos
155: *         forms CRUD. Este dialogo tem UM unico botao (SAIDA,
156: *         ButtonCount = 1), cujo Click e BtnSaidaClick.
157: *       - O handler de GRAVAR nao tem o que gravar: o resultado sai pelo
158: *         protocolo (arquivos de retorno do PIN-pad, via
159: *         SIGPRTFHBO.RegistrarFalhaSiTef/GravarRetornoSucesso) e pela string
160: *         devolvida em this_cRetChe, nunca por INSERT/UPDATE em tabela - o
161: *         dump nao tem nenhum.
162: *     Inventar lista, segundo botao ou gravacao em tabela violaria o PILAR 1
163: *     e a regra "NUNCA inventar funcionalidade ausente do original".
164: *==============================================================================

*-- Linhas 182 a 225:
182:     BorderStyle  = 2
183: 
184:     *-- Parametros escalares equivalentes ao Init legado (repassados ao BO em
185:     *-- InicializarForm, via TransferirParametrosParaBO). Ordem e nomes
186:     *-- identicos aos das properties this_* do SIGPRTFHBO (ver SIGPRTFHBO.prg).
187:     this_cIp        = ""
188:     this_cInicio    = ""
189:     this_nValor     = 0
190:     this_cCupom     = ""
191:     this_cCaixa     = ""
192:     this_nIdent     = 0
193:     this_cPos       = ""
194:     this_nParcs     = 0
195:     this_cFuncoes   = ""
196:     this_cBanco     = ""
197:     this_cAgencia   = ""
198:     this_cConta     = ""
199:     this_cNCheque   = ""
200:     this_cDtCheque  = ""
201:     this_cCpf       = ""
202:     this_cTpPessoa  = ""
203:     this_cCupomNv   = ""
204:     this_cAgendc    = ""
205:     this_cContadc   = ""
206:     this_cNumdc     = ""
207:     this_cPraca     = ""
208:     this_cPesquisa  = ""
209:     this_cCmc7      = ""
210:     this_cTeste     = ""
211: 
212:     *-- Resultado de ValidarParametros(): diz se os argumentos exigidos pelo
213:     *-- protocolo SiTef (endereco, terminal/POS e modalidade) chegaram
214:     *-- preenchidos. Consumido pelo handler do GotFocus do botao SAIDA, que e
215:     *-- quem abre a sessao com o terminal - no legado, o mesmo ponto em que
216:     *-- ConfiguraIntSiTefInterativo/IniciaFuncaoSiTefInterativo sao chamados.
217:     this_lParametrosValidos  = .F.
218:     this_cMensagemParametros = ""
219: 
220:     *-- Marca que o laco interativo com o terminal SiTef (equivalente ao
221:     *-- SIGPRIFF.SAIDA.GotFocus do legado) ja foi disparado. O legado so
222:     *-- alcanca esse laco porque o Init termina com "ThisForm.Saida.Cancela.
223:     *-- SetFocus" e nenhum outro controle do form aceita foco (os 9 TextBox
224:     *-- de dados tem TabStop = .F. - ver ConfigurarCampos) - ou seja, o laco
225:     *-- roda exatamente UMA vez, quando a tela e exibida. Aqui o disparo

*-- Linhas 235 a 448:
235:     *-- FormSIGPRIFF usa com this_uResposta. Equivalente ao antigo
236:     *-- "Return(pcRetChe)" do Unload legado (chamador real localizado em
237:     *-- C:\4install\FortyusMC\Fortyus\sigfitef.PRG:224 - "DO Form SigPrTfh
238:     *-- With ... TO RetCrtChq"), mecanismo que CREATEOBJECT()/Show() nao
239:     *-- reproduz (nao ha "DO FORM ... TO var" no sistema novo) - por isso
240:     *-- BtnSaidaClick fecha com THIS.Hide() e NAO THIS.Release(): Release()
241:     *-- destruiria o objeto antes do chamador conseguir ler esta property.
242:     this_cRetChe = ""
243: 
244:     *--------------------------------------------------------------------------
245:     * Init - Recebe os mesmos 24 parametros do Init legado (PARAMETERS pcIp,
246:     * lcInicio, pcValor, pcCupom, pcCaixa, pcIdent, pcPos, pcParcs, PcFuncoes,
247:     * pcBanco, pcAgencia, pcConta, pcnCheque, pcDtCheque, pcCpf, pcTpPessoa,
248:     * pcCupomnv, pcAgendc, pcContadc, pcNumdc, pcPraca, pcPesquisa, pcCMC7,
249:     * pcteste). Guarda os escalares ANTES de DODEFAULT() - FormBase.Init()
250:     * chama InicializarForm(), que ja usa esses valores para criar o
251:     * SIGPRTFHBO (regra CLAUDE.md #8/Problema 8: logica extra ANTES do
252:     * DODEFAULT(), nunca RETURN dentro de TRY/CATCH).
253:     *--------------------------------------------------------------------------
254:     PROCEDURE Init(par_cIp, par_cInicio, par_nValor, par_cCupom, par_cCaixa, ;
255:             par_nIdent, par_cPos, par_nParcs, par_cFuncoes, par_cBanco, ;
256:             par_cAgencia, par_cConta, par_cNCheque, par_cDtCheque, par_cCpf, ;
257:             par_cTpPessoa, par_cCupomNv, par_cAgendc, par_cContadc, par_cNumdc, ;
258:             par_cPraca, par_cPesquisa, par_cCmc7, par_cTeste)
259: 
260:         THIS.this_cIp       = IIF(VARTYPE(par_cIp) = "C", par_cIp, "")
261:         THIS.this_cInicio   = IIF(VARTYPE(par_cInicio) = "C", par_cInicio, "")
262:         THIS.this_nValor    = IIF(VARTYPE(par_nValor) = "N", par_nValor, VAL(TRANSFORM(par_nValor)))
263:         THIS.this_cCupom    = IIF(VARTYPE(par_cCupom) = "C", par_cCupom, "")
264:         THIS.this_cCaixa    = IIF(VARTYPE(par_cCaixa) = "C", par_cCaixa, "")
265:         THIS.this_nIdent    = IIF(VARTYPE(par_nIdent) = "N", par_nIdent, VAL(TRANSFORM(par_nIdent)))
266:         THIS.this_cPos      = IIF(VARTYPE(par_cPos) = "C", par_cPos, "")
267:         THIS.this_nParcs    = IIF(VARTYPE(par_nParcs) = "N", par_nParcs, VAL(TRANSFORM(par_nParcs)))
268:         THIS.this_cFuncoes  = IIF(VARTYPE(par_cFuncoes) = "C", par_cFuncoes, "")
269:         THIS.this_cBanco    = IIF(VARTYPE(par_cBanco) = "C", par_cBanco, "")
270:         THIS.this_cAgencia  = IIF(VARTYPE(par_cAgencia) = "C", par_cAgencia, "")
271:         THIS.this_cConta    = IIF(VARTYPE(par_cConta) = "C", par_cConta, "")
272:         THIS.this_cNCheque  = IIF(VARTYPE(par_cNCheque) = "C", par_cNCheque, "")
273:         THIS.this_cDtCheque = IIF(VARTYPE(par_cDtCheque) = "C", par_cDtCheque, "")
274:         THIS.this_cCpf      = IIF(VARTYPE(par_cCpf) = "C", par_cCpf, "")
275:         THIS.this_cTpPessoa = IIF(VARTYPE(par_cTpPessoa) = "C", par_cTpPessoa, "")
276:         THIS.this_cCupomNv  = IIF(VARTYPE(par_cCupomNv) = "C", par_cCupomNv, "")
277:         THIS.this_cAgendc   = IIF(VARTYPE(par_cAgendc) = "C", par_cAgendc, "")
278:         THIS.this_cContadc  = IIF(VARTYPE(par_cContadc) = "C", par_cContadc, "")
279:         THIS.this_cNumdc    = IIF(VARTYPE(par_cNumdc) = "C", par_cNumdc, "")
280:         THIS.this_cPraca    = IIF(VARTYPE(par_cPraca) = "C", par_cPraca, "")
281:         THIS.this_cPesquisa = IIF(VARTYPE(par_cPesquisa) = "C", par_cPesquisa, "")
282:         THIS.this_cCmc7     = IIF(VARTYPE(par_cCmc7) = "C", par_cCmc7, "")
283:         THIS.this_cTeste    = IIF(VARTYPE(par_cTeste) = "C", par_cTeste, "")
284: 
285:         RETURN DODEFAULT()
286:     ENDPROC
287: 
288:     *--------------------------------------------------------------------------
289:     * InicializarForm - Cria o Business Object, repassa os escalares
290:     * recebidos no Init e monta a estrutura visual base (cabecalho, moldura,
291:     * container de status e botao de saida), na mesma ordem do SCX legado.
292:     *--------------------------------------------------------------------------
293:     PROTECTED PROCEDURE InicializarForm()
294:         LOCAL loc_lSucesso, loc_oErro
295:         loc_lSucesso = .F.
296: 
297:         TRY
298:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRTFHBO")
299: 
300:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
301:                 THIS.TransferirParametrosParaBO()
302: 
303:                 THIS.ConfigurarCabecalho()
304:                 THIS.ConfigurarPainel()
305:                 THIS.ConfigurarCampos()
306:                 THIS.CarregarCamposNaTela()
307:                 THIS.ConfigurarContainerStatus()
308:                 THIS.ConfigurarSaida()
309: 
310:                 THIS.TornarControlesVisiveis(THIS)
311: 
312:                 *-- Confere os argumentos exigidos pelo protocolo SiTef e
313:                 *-- guarda o veredito em this_lParametrosValidos. O dialogo
314:                 *-- ABRE de qualquer forma, igual ao legado: no SIGPRIFF a
315:                 *-- falha de parametro so se manifesta quando a transacao e
316:                 *-- tentada (SAIDA.GotFocus), e e o handler desse evento que
317:                 *-- grava o retorno de falha - ver ValidarParametros().
318:                 THIS.ValidarParametros()
319: 
320:                 loc_lSucesso = .T.
321:             ELSE
322:                 MsgErro("Erro ao criar Business Object SIGPRTFHBO." + CHR(13) + ;
323:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
324:             ENDIF
325:         CATCH TO loc_oErro
326:             MsgErro(loc_oErro.Message + CHR(13) + ;
327:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
328:                 "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSIGPRTFH")
329:         ENDTRY
330: 
331:         RETURN loc_lSucesso
332:     ENDPROC
333: 
334:     *--------------------------------------------------------------------------
335:     * TransferirParametrosParaBO - Copia os 24 escalares recebidos no Init
336:     * para as properties equivalentes do SIGPRTFHBO (mesmos nomes - regra
337:     * CLAUDE.md "BO property name DEVE bater EXATAMENTE com uso no Form").
338:     *--------------------------------------------------------------------------
339:     PROTECTED PROCEDURE TransferirParametrosParaBO()
340:         WITH THIS.this_oBusinessObject
341:             .this_cIp        = THIS.this_cIp
342:             .this_cInicio    = THIS.this_cInicio
343:             .this_nValor     = THIS.this_nValor
344:             .this_cCupom     = THIS.this_cCupom
345:             .this_cCaixa     = THIS.this_cCaixa
346:             .this_nIdent     = THIS.this_nIdent
347:             .this_cPos       = THIS.this_cPos
348:             .this_nParcs     = THIS.this_nParcs
349:             .this_cFuncoes   = THIS.this_cFuncoes
350:             .this_cBanco     = THIS.this_cBanco
351:             .this_cAgencia   = THIS.this_cAgencia
352:             .this_cConta     = THIS.this_cConta
353:             .this_cNCheque   = THIS.this_cNCheque
354:             .this_cDtCheque  = THIS.this_cDtCheque
355:             .this_cCpf       = THIS.this_cCpf
356:             .this_cTpPessoa  = THIS.this_cTpPessoa
357:             .this_cCupomNv   = THIS.this_cCupomNv
358:             .this_cAgendc    = THIS.this_cAgendc
359:             .this_cContadc   = THIS.this_cContadc
360:             .this_cNumdc     = THIS.this_cNumdc
361:             .this_cPraca     = THIS.this_cPraca
362:             .this_cPesquisa  = THIS.this_cPesquisa
363:             .this_cCmc7      = THIS.this_cCmc7
364:             .this_cTeste     = THIS.this_cTeste
365:         ENDWITH
366:     ENDPROC
367: 
368:     *--------------------------------------------------------------------------
369:     * ValidarParametros - Confere os argumentos que o protocolo SiTef exige
370:     * ANTES de a sessao com o terminal ser aberta.
371:     *
372:     * Este dialogo NAO valida campo digitado: os nove Get* do legado tem
373:     * PROCEDURE When / Return(.f.) e sao somente exibicao (ver
374:     * ConfigurarCampos). O que ha para conferir sao os parametros recebidos no
375:     * Init - exatamente os que o legado entrega as duas chamadas da DLL em
376:     * SIGPRIFF.SAIDA.GotFocus:
377:     *
378:     *   IF ConfiguraIntSiTefInterativo(ThisForm.pcIP, lsIdTerminal,
379:     *                                  ThisForm.pcPos, 0) <> 0
380:     *       DO SigTfSup WITH "P", "Sem comunicacao com SiTef", ...
381:     *       Return
382:     *   Endif
383:     *   IF IniciaFuncaoSiTefInterativo(ThisForm.pcInicio, lnValPago,
384:     *           ThisForm.pcCupom, lcData, lcHora, ThisForm.pcCaixa, "") <> 10000
385:     *       DO SigTfSup WITH "P", "Sem comunicacao com SiTef", ...
386:     *       Return
387:     *   ENDIF
388:     *
389:     * Com pcIP ou pcPos vazios a configuracao da conexao so pode devolver <> 0,
390:     * e com pcInicio nao numerico a modalidade e invalida - o proprio legado
391:     * nomeia esse caso em errotef (pnRetornos = -3, "Fornecida uma Modalidade
392:     * Invalida"). As duas mensagens usadas aqui sao portanto as DO LEGADO, nao
393:     * mensagens novas (PILAR 1). pcCaixa (lsOperador) e pcCupom NAO entram: o
394:     * legado nao os condiciona e fechar a lista inventaria restricao que o
395:     * original nao tem.
396:     *
397:     * NAO grava arquivo de retorno nem exibe dialogo - o legado e silencioso
398:     * neste ponto, e escreve o retorno (IntPos.001/IntPos.STS, via
399:     * SIGPRTFHBO.RegistrarFalhaSiTef) somente quando a transacao e de fato
400:     * tentada. O veredito fica em THIS.this_lParametrosValidos /
401:     * this_cMensagemParametros para o handler do GotFocus gravar a falha no
402:     * MESMO momento em que o legado gravaria, em vez de antecipar a escrita.
403:     *
404:     * PUBLIC de proposito (regras CLAUDE.md #3 e #51): e chamado de FORA da
405:     * classe - pelo harness de teste automatizado e pelo handler ligado por
406:     * BINDEVENT ao botao de saida.
407:     *--------------------------------------------------------------------------
408:     PROCEDURE ValidarParametros()
409:         LOCAL loc_lValido, loc_cMensagem, loc_cSemComunicacao
410: 
411:         loc_lValido        = .T.
412:         loc_cMensagem      = ""
413:         loc_cSemComunicacao = "Sem comunica" + CHR(231) + CHR(227) + "o com SiTef"
414: 
415:         *-- Bypass do harness: TesteAutomatico.prg e ValidarUIFidelity.prg
416:         *-- instanciam o form SEM parametro algum, so para provar que ele abre.
417:         *-- Sem o bypass a conferencia reprovaria sempre nesses dois modos.
418:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
419:             THIS.this_lParametrosValidos  = .T.
420:             THIS.this_cMensagemParametros = ""
421:             RETURN .T.
422:         ENDIF
423: 
424:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
425:             THIS.this_lParametrosValidos  = .T.
426:             THIS.this_cMensagemParametros = ""
427:             RETURN .T.
428:         ENDIF
429: 
430:         DO CASE
431:             CASE VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
432:                     !THIS.this_oBusinessObject.this_lSiTefDisponivel
433:                 *-- CliSiTef32I.DLL ausente nesta estacao: sem a biblioteca do
434:                 *-- integrador nenhuma das quatro funcoes do terminal pode ser
435:                 *-- chamada (ver SIGPRTFHBO.DeclararFuncoesSiTef), o que e a
436:                 *-- propria condicao de "sem comunicacao" do legado.
437:                 loc_cMensagem = loc_cSemComunicacao
438:                 loc_lValido   = .F.
439:             CASE EMPTY(THIS.this_cIp)
440:                 *-- 1o argumento de ConfiguraIntSiTefInterativo (lsEndereco)
441:                 loc_cMensagem = loc_cSemComunicacao
442:                 loc_lValido   = .F.
443:             CASE EMPTY(THIS.this_cPos)
444:                 *-- 3o argumento de ConfiguraIntSiTefInterativo (lsTerminal)
445:                 loc_cMensagem = loc_cSemComunicacao
446:                 loc_lValido   = .F.
447:             CASE VAL(THIS.this_cInicio) <= 0
448:                 *-- 1o argumento de IniciaFuncaoSiTefInterativo (lnModalidade),

*-- Linhas 466 a 623:
466:     * Width=769 no legado (> Form.Width - mesmo motivo), aqui THIS.Width-20,
467:     * ForeColor preto/branco, FontSize=18, Tahoma Bold.
468:     *--------------------------------------------------------------------------
469:     PROTECTED PROCEDURE ConfigurarCabecalho()
470:         LOCAL loc_oErro
471:         TRY
472:             THIS.AddObject("cnt_4c_Sombra", "Container")
473:             WITH THIS.cnt_4c_Sombra
474:                 .Top         = 1
475:                 .Left        = 1
476:                 .Width       = THIS.Width
477:                 .Height      = 80
478:                 .BackStyle   = 1
479:                 .BackColor   = RGB(100, 100, 100)
480:                 .BorderWidth = 0
481:                 .Visible     = .T.
482:             ENDWITH
483: 
484:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
485:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
486:                 .FontBold      = .T.
487:                 .FontName      = "Tahoma"
488:                 .FontSize      = 18
489:                 .FontUnderline = .F.
490:                 .WordWrap      = .T.
491:                 .Alignment     = 0
492:                 .BackStyle     = 0
493:                 .AutoSize      = .F.
494:                 .Caption       = THIS.Caption
495:                 .Height        = 40
496:                 .Left          = 10
497:                 .Top           = 18
498:                 .Width         = THIS.Width - 20
499:                 .ForeColor     = RGB(0, 0, 0)
500:                 .Visible       = .T.
501:             ENDWITH
502: 
503:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
504:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
505:                 .FontBold      = .T.
506:                 .FontName      = "Tahoma"
507:                 .FontSize      = 18
508:                 .WordWrap      = .T.
509:                 .Alignment     = 0
510:                 .BackStyle     = 0
511:                 .AutoSize      = .F.
512:                 .Caption       = THIS.Caption
513:                 .Height        = 46
514:                 .Left          = 10
515:                 .Top            = 17
516:                 .Width         = THIS.Width - 20
517:                 .ForeColor     = RGB(255, 255, 255)
518:                 .Visible       = .T.
519:             ENDWITH
520:         CATCH TO loc_oErro
521:             MsgErro(loc_oErro.Message + CHR(13) + ;
522:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
523:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRTFH.ConfigurarCabecalho")
524:         ENDTRY
525:     ENDPROC
526: 
527:     *--------------------------------------------------------------------------
528:     * ConfigurarPainel - Moldura/retangulo decorativo (Shape2 do legado) que
529:     * circunda a area de campos (Praca/Banco/Agencia/Conta/Cheque/CPF),
530:     * criadas na Fase 5. Origem: SIGPRIFF.Shape2
531:     *   Top=84, Left=0, Height=202, Width=466, SpecialEffect=0.
532:     *--------------------------------------------------------------------------
533:     PROTECTED PROCEDURE ConfigurarPainel()
534:         LOCAL loc_oErro
535:         TRY
536:             THIS.AddObject("shp_4c_Painel", "Shape")
537:             WITH THIS.shp_4c_Painel
538:                 .Top           = 84
539:                 .Left          = 0
540:                 .Height        = 202
541:                 .Width         = 466
542:                 .SpecialEffect = 0
543:                 .Visible       = .T.
544:             ENDWITH
545:         CATCH TO loc_oErro
546:             MsgErro(loc_oErro.Message + CHR(13) + ;
547:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
548:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRTFH.ConfigurarPainel")
549:         ENDTRY
550:     ENDPROC
551: 
552:     *--------------------------------------------------------------------------
553:     * ConfigurarCampos - Campos de dados do cheque/conta, criados direto na
554:     * form (sem container-pai, igual ao SCX legado). Origem (dump completo em
555:     * SIGPRTFH_form_codigo_fonte.txt):
556:     *   Label5/GetPraca     - "Praca de Compesacao :" / txt_4c_Praca
557:     *   Label8/GetBanco     - "Banco :"               / txt_4c_Banco
558:     *   Label9  (DV:)       - rotulo do digito de GetAgencia
559:     *   Label2/GetAgencia   - "Agencia :"             / txt_4c_Agencia
560:     *                         + GetDvAgencia (digito, sem label propria -
561:     *                           compartilha Label9 acima, Top=162 entre
562:     *                           Agencia Top=158/161 e Conta Top=190/193)
563:     *   Label7/GetConta     - "Conta :"               / txt_4c_Conta
564:     *   Label3  (DV:)       - rotulo do digito de GetConta
565:     *                         + GetDvConta (digito)
566:     *   Label6/GetCheque    - "Numero de Cheque :"    / txt_4c_Cheque
567:     *   Label4  (DV:)       - rotulo do digito de GetCheque
568:     *                         + GetDvCheque (digito)
569:     *   Label1/GetCpf       - "CPF :" (legado troca para "CGC :" quando
570:     *                         pcTpPessoa <> 'F' - ver CarregarCamposNaTela)
571:     *
572:     * TODOS os TextBox (GetPraca/GetBanco/GetAgencia/GetDvAgencia/GetConta/
573:     * GetDvConta/GetCheque/GetDvCheque/GetCpf) tem PROCEDURE When / Return(.f.)
574:     * no legado - sao display-only, migrados como .ReadOnly = .T. Os valores
575:     * sao preenchidos em CarregarCamposNaTela() a partir dos parametros
576:     * recebidos no Init (THIS.this_cPraca, this_cBanco, etc).
577:     *
578:     * Labels: classe "say" (AutoSize=.T. no dump, mas regra CLAUDE.md #23
579:     * manda .AutoSize = .F. + Width/Height EXPLICITOS do dump, para nao
580:     * perder a largura calculada pelo Form Designer); nenhuma declara
581:     * Alignment=1, entao .Alignment = 0 (esquerda) em todas.
582:     *--------------------------------------------------------------------------
583:     PROTECTED PROCEDURE ConfigurarCampos()
584:         LOCAL loc_oErro
585:         TRY
586:             *-- Label5 / GetPraca ------------------------------------------------
587:             THIS.AddObject("lbl_4c_Label5", "Label")
588:             WITH THIS.lbl_4c_Label5
589:                 .FontName  = "Tahoma"
590:                 .FontBold  = .T.
591:                 .FontItalic = .F.
592:                 .FontSize  = 8
593:                 .Alignment = 0
594:                 .AutoSize  = .F.
595:                 .BackStyle = 0
596:                 .Caption   = "Praca de Compesacao :"
597:                 .Height    = 15
598:                 .Left      = 64
599:                 .Top       = 97
600:                 .Width     = 132
601:                 .ForeColor = RGB(90, 90, 90)
602:                 .Visible   = .T.
603:             ENDWITH
604: 
605:             THIS.AddObject("txt_4c_Praca", "TextBox")
606:             WITH THIS.txt_4c_Praca
607:                 .FontName  = "Tahoma"
608:                 .FontBold  = .T.
609:                 .FontSize  = 8
610:                 .Alignment = 3
611:                 .Value     = ""
612:                 .Height    = 23
613:                 .Left      = 198
614:                 .Top       = 94
615:                 .Width     = 32
616:                 .ReadOnly  = .T.
617:                 .TabStop   = .F.
618:                 .Visible   = .T.
619:             ENDWITH
620: 
621:             *-- Label8 / GetBanco -------------------------------------------------
622:             THIS.AddObject("lbl_4c_Label8", "Label")
623:             WITH THIS.lbl_4c_Label8

*-- Linhas 892 a 1046:
892:                 .Visible   = .T.
893:             ENDWITH
894: 
895:             BINDEVENT(THIS.txt_4c_DvCheque, "GotFocus", THIS, "TxtDvChequeGotFocus")
896:         CATCH TO loc_oErro
897:             MsgErro(loc_oErro.Message + CHR(13) + ;
898:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
899:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRTFH.ConfigurarCampos")
900:         ENDTRY
901:     ENDPROC
902: 
903:     *--------------------------------------------------------------------------
904:     * CarregarCamposNaTela - Equivalente ao bloco "With ThisForm / .GetPraca.
905:     * Value = pcPraca / .GetBanco.Value = pcBanco / ..." do Init legado.
906:     * Mantem o nome (e o ponto de chamada, dentro de InicializarForm) por ser
907:     * o espelho literal daquele bloco, mas o preenchimento em si vive em
908:     * BOParaForm(): o dado exibido e o MESMO que alimenta o protocolo SiTef,
909:     * entao tem de ter UMA fonte - as properties do SIGPRTFHBO - e um unico
910:     * ponto de recarga (ver cabecalho de BOParaForm).
911:     *--------------------------------------------------------------------------
912:     PROTECTED PROCEDURE CarregarCamposNaTela()
913:         THIS.BOParaForm()
914:     ENDPROC
915: 
916:     *--------------------------------------------------------------------------
917:     * BOParaForm - Transferencia Business Object -> campos da tela.
918:     *
919:     * Origem literal (SIGPRIFF.Init, linhas 890-899 do dump):
920:     *     With ThisForm
921:     *         .GetPraca.Value     = pcPraca
922:     *         .GetBanco.Value     = pcBanco
923:     *         .GetAgencia.Value   = pcAgencia
924:     *         .GetDvAgencia.Value = pcAgendc
925:     *         .GetConta.Value     = pcConta
926:     *         .GetDvConta.Value   = pcContadc
927:     *         .GetCheque.Value    = pcnCheque
928:     *         .GetDvCheque.Value  = pcNumdc
929:     *         .GetCpf.Value       = pcCpf
930:     *         .Label1.Caption     = Iif(pcTpPessoa='F','CPF :','CGC :')
931:     *     EndWith
932:     *
933:     * A fonte sao as properties do SIGPRTFHBO (preenchidas em
934:     * TransferirParametrosParaBO a partir dos 24 argumentos do Init) - e NAO
935:     * as copias escalares do form - porque sao essas MESMAS properties que o
936:     * protocolo entrega ao terminal em MontarBufferCheque(). Lendo do BO, o
937:     * que o operador ve na tela e, por construcao, o que o terminal recebe;
938:     * ler das copias do form abriria dois caminhos independentes para o mesmo
939:     * dado, com risco de divergirem em silencio.
940:     *
941:     * Fallback para THIS.this_c* quando o BO ainda nao existe (probe de UI /
942:     * gb_4c_ValidandoUI, em que InicializarForm pode falhar ao criar o BO):
943:     * a tela continua desenhando os valores recebidos, sem estourar.
944:     *
945:     * PROTECTED EXPLICITO: FormBase declara BOParaForm como PROTECTED e o
946:     * VFP9 nao deixa a subclasse ALARGAR o escopo herdado - escrever
947:     * "PROCEDURE BOParaForm" sem o modificador nao tornaria o metodo publico,
948:     * so esconderia o fato de que ele continua protegido. Chamar sempre por
949:     * THIS. de dentro da classe (regra CLAUDE.md #8).
950:     *--------------------------------------------------------------------------
951:     PROTECTED FUNCTION BOParaForm()
952:         LOCAL loc_lSucesso, loc_lTemBO, loc_oBO, loc_cTpPessoa, loc_oErro
953:         loc_lSucesso = .F.
954: 
955:         TRY
956:             loc_oBO    = THIS.this_oBusinessObject
957:             loc_lTemBO = (VARTYPE(loc_oBO) = "O")
958: 
959:             IF loc_lTemBO
960:                 THIS.txt_4c_Praca.Value     = loc_oBO.this_cPraca
961:                 THIS.txt_4c_Banco.Value     = loc_oBO.this_cBanco
962:                 THIS.txt_4c_Agencia.Value   = loc_oBO.this_cAgencia
963:                 THIS.txt_4c_DvAgencia.Value = loc_oBO.this_cAgendc
964:                 THIS.txt_4c_Conta.Value     = loc_oBO.this_cConta
965:                 THIS.txt_4c_DvConta.Value   = loc_oBO.this_cContadc
966:                 THIS.txt_4c_Cheque.Value    = loc_oBO.this_cNCheque
967:                 THIS.txt_4c_DvCheque.Value  = loc_oBO.this_cNumdc
968:                 THIS.txt_4c_Cpf.Value       = loc_oBO.this_cCpf
969: 
970:                 loc_cTpPessoa = loc_oBO.this_cTpPessoa
971:             ELSE
972:                 THIS.txt_4c_Praca.Value     = THIS.this_cPraca
973:                 THIS.txt_4c_Banco.Value     = THIS.this_cBanco
974:                 THIS.txt_4c_Agencia.Value   = THIS.this_cAgencia
975:                 THIS.txt_4c_DvAgencia.Value = THIS.this_cAgendc
976:                 THIS.txt_4c_Conta.Value     = THIS.this_cConta
977:                 THIS.txt_4c_DvConta.Value   = THIS.this_cContadc
978:                 THIS.txt_4c_Cheque.Value    = THIS.this_cNCheque
979:                 THIS.txt_4c_DvCheque.Value  = THIS.this_cNumdc
980:                 THIS.txt_4c_Cpf.Value       = THIS.this_cCpf
981: 
982:                 loc_cTpPessoa = THIS.this_cTpPessoa
983:             ENDIF
984: 
985:             *-- Origem: .Label1.Caption = Iif(pcTpPessoa='F','CPF :','CGC :')
986:             THIS.lbl_4c_LabelCpf.Caption = IIF(loc_cTpPessoa = "F", "CPF :", "CGC :")
987: 
988:             loc_lSucesso = loc_lTemBO
989:         CATCH TO loc_oErro
990:             MsgErro(loc_oErro.Message + CHR(13) + ;
991:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
992:                 "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
993:         ENDTRY
994: 
995:         RETURN loc_lSucesso
996:     ENDFUNC
997: 
998:     *--------------------------------------------------------------------------
999:     * FormParaBO - Transferencia campos da tela -> Business Object. Roda no
1000:     * instante em que o protocolo vai consumir o dado (inicio de
1001:     * ExecutarConsultaSiTef, antes de IniciarSessaoSiTef) - o equivalente,
1002:     * neste dialogo, do "FormParaBO antes de gravar" dos forms CRUD: aqui nao
1003:     * se grava em tabela, entrega-se ao terminal.
1004:     *
1005:     * DIVERGENCIA DECLARADA EM VOZ ALTA (nao esconder): o legado NUNCA le
1006:     * esses controles de volta. Os nove Get* do SIGPRIFF tem PROCEDURE When /
1007:     * Return(.f.) - sao somente exibicao (migrados com .ReadOnly = .T. /
1008:     * .TabStop = .F. em ConfigurarCampos) - e todo o laco de
1009:     * SIGPRIFF.SAIDA.GotFocus usa as properties ThisForm.pc*, jamais
1010:     * .GetBanco.Value. Portanto esta transferencia e, na pratica, IDENTIDADE:
1011:     * os controles so recebem valor de BOParaForm(), que le do proprio BO, e
1012:     * nenhuma mascara os transforma no caminho de volta - os Format/InputMask/
1013:     * MaxLength do SCX sao todos override VAZIO do Form Designer (Format = "",
1014:     * InputMask = "", MaxLength = 0), que a regra CLAUDE.md #49 manda NAO
1015:     * transcrever, e nenhum foi transcrito. Logo o round-trip BO -> tela -> BO
1016:     * devolve byte a byte o mesmo valor e o PILAR 1 fica preservado: o
1017:     * terminal recebe exatamente o que receberia no legado.
1018:     *
1019:     * Guarda de campo em BRANCO: campo vazio NAO sobrescreve a property. Sem
1020:     * ela, qualquer caminho futuro que limpasse um controle apagaria em
1021:     * silencio um dado que o protocolo exige (banco/agencia/conta/cheque
1022:     * montam o buffer de MontarBufferCheque) - e o terminal recusaria a
1023:     * transacao sem que a causa aparecesse na tela.
1024:     *
1025:     * PROTECTED EXPLICITO pelo mesmo motivo de BOParaForm (FormBase declara
1026:     * FormParaBO como PROTECTED; VFP9 nao permite alargar escopo herdado).
1027:     *--------------------------------------------------------------------------
1028:     PROTECTED FUNCTION FormParaBO()
1029:         LOCAL loc_lSucesso, loc_oBO, loc_oErro
1030:         loc_lSucesso = .F.
1031: 
1032:         TRY
1033:             loc_oBO = THIS.this_oBusinessObject
1034: 
1035:             IF VARTYPE(loc_oBO) = "O"
1036:                 IF !EMPTY(THIS.txt_4c_Praca.Value)
1037:                     loc_oBO.this_cPraca = ALLTRIM(THIS.txt_4c_Praca.Value)
1038:                 ENDIF
1039:                 IF !EMPTY(THIS.txt_4c_Banco.Value)
1040:                     loc_oBO.this_cBanco = ALLTRIM(THIS.txt_4c_Banco.Value)
1041:                 ENDIF
1042:                 IF !EMPTY(THIS.txt_4c_Agencia.Value)
1043:                     loc_oBO.this_cAgencia = ALLTRIM(THIS.txt_4c_Agencia.Value)
1044:                 ENDIF
1045:                 IF !EMPTY(THIS.txt_4c_DvAgencia.Value)
1046:                     loc_oBO.this_cAgendc = ALLTRIM(THIS.txt_4c_DvAgencia.Value)

*-- Linhas 1066 a 1143:
1066:         CATCH TO loc_oErro
1067:             MsgErro(loc_oErro.Message + CHR(13) + ;
1068:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1069:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
1070:         ENDTRY
1071: 
1072:         RETURN loc_lSucesso
1073:     ENDFUNC
1074: 
1075:     *--------------------------------------------------------------------------
1076:     * TxtDvChequeGotFocus - Origem: SIGPRIFF.GetDvCheque.GotFocus ("ThisForm.
1077:     * Container1.Label1.Caption='Digite o Numero'+CHR(13)+'de Parcelas'").
1078:     * Mensagem fixa do legado ao focar o campo de DV do cheque.
1079:     *--------------------------------------------------------------------------
1080:     PROCEDURE TxtDvChequeGotFocus()
1081:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "de Parcelas"
1082:     ENDPROC
1083: 
1084:     *--------------------------------------------------------------------------
1085:     * ConfigurarContainerStatus - Container1 do legado: 4 labels sobrepostas
1086:     * que mostram o acompanhamento da transacao SiTef (Label1 = mensagem
1087:     * corrente, Label2/3/4 = as 3 linhas do retorno SERASA decodificado).
1088:     * Origem: SIGPRIFF.Container1 (Top=288, Left=37, Width=393, Height=58) e
1089:     * seus 4 Labels (Alignment=2 centralizado, Tahoma 8 Bold, ForeColor
1090:     * 90,90,90 - todos DECLARADOS no dump, logo NAO e o caso "classe say
1091:     * pura" da regra CLAUDE.md #23; AutoSize=.F. preservado porque
1092:     * WordWrap=.T. descartaria a Height com AutoSize=.T., regra #23).
1093:     *
1094:     * Visibilidade inicial igual ao SIGPRIFF.Init legado:
1095:     *   ThisForm.Container1.Label2.Visible = .f.
1096:     *   ThisForm.Container1.Label3.Visible = .f.
1097:     *   ThisForm.Container1.Label4.Visible = .f.
1098:     * (Label1 fica visivel - e a mensagem "Aguarde Consulta de Cheque"). A
1099:     * troca dinamica (mostrar 2/3/4 quando o retorno SERASA e decodificado,
1100:     * Label1 sumir) e feita por SIGPRTFHBO.DecodificarRetornoFinal + o
1101:     * handler do form, na Fase 7.
1102:     *--------------------------------------------------------------------------
1103:     PROTECTED PROCEDURE ConfigurarContainerStatus()
1104:         LOCAL loc_oErro
1105:         TRY
1106:             THIS.AddObject("cnt_4c_Container1", "Container")
1107:             WITH THIS.cnt_4c_Container1
1108:                 .Top           = 288
1109:                 .Left          = 37
1110:                 .Width         = 393
1111:                 .Height        = 58
1112:                 .SpecialEffect = 0
1113:                 .Visible       = .T.
1114:             ENDWITH
1115: 
1116:             THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
1117:             WITH THIS.cnt_4c_Container1.lbl_4c_Label1
1118:                 .FontName  = "Tahoma"
1119:                 .FontBold  = .T.
1120:                 .FontSize  = 8
1121:                 .Alignment = 2
1122:                 .WordWrap  = .T.
1123:                 .AutoSize  = .F.
1124:                 .BackStyle = 0
1125:                 .Caption   = "Aguarde Consulta de Cheque"
1126:                 .Height    = 43
1127:                 .Left      = 4
1128:                 .Top       = 8
1129:                 .Width     = 383
1130:                 .ForeColor = RGB(90, 90, 90)
1131:                 .Visible   = .T.
1132:             ENDWITH
1133: 
1134:             THIS.cnt_4c_Container1.AddObject("lbl_4c_Label2", "Label")
1135:             WITH THIS.cnt_4c_Container1.lbl_4c_Label2
1136:                 .FontName  = "Tahoma"
1137:                 .FontBold  = .T.
1138:                 .FontSize  = 8
1139:                 .Alignment = 2
1140:                 .WordWrap  = .T.
1141:                 .AutoSize  = .F.
1142:                 .BackStyle = 0
1143:                 .Caption   = "Aguarde Consulta de Cheque"

*-- Linhas 1187 a 1404:
1187:         CATCH TO loc_oErro
1188:             MsgErro(loc_oErro.Message + CHR(13) + ;
1189:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1190:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRTFH.ConfigurarContainerStatus")
1191:         ENDTRY
1192:     ENDPROC
1193: 
1194:     *--------------------------------------------------------------------------
1195:     * ConfigurarSaida - CommandGroup de 1 botao (SAIDA/Cancela do legado) -
1196:     * unica acao de saida do dialogo. Origem: SIGPRIFF.SAIDA
1197:     *   ButtonCount=1, BackStyle=0, BorderStyle=0, Height=85, Left=387,
1198:     *   Top=-1, Width=85; Command1: Top=5, Left=5, Height=75, Width=75,
1199:     *   FontBold=.T., FontItalic=.T., FontName="Comic Sans MS", FontSize=8,
1200:     *   Picture=cadastro_cancelar_60.jpg, Cancel=.T.,
1201:     *   Caption="<Esc> \<Sair" (o "\<" sublinha o S como tecla de acesso -
1202:     *   Alt+S - preservado literal), ForeColor=90,90,90,
1203:     *   BackColor=255,255,255, Themes=.F.
1204:     * CommandGroup NAO tem ForeColor (regra CLAUDE.md #33) - a cor vai no
1205:     * Buttons(1), nao no grupo. Buttons(N) configurado em WITH ANINHADO
1206:     * dentro do WITH do grupo (excecao segura da regra CLAUDE.md #44).
1207:     *--------------------------------------------------------------------------
1208:     PROTECTED PROCEDURE ConfigurarSaida()
1209:         LOCAL loc_oErro
1210:         TRY
1211:             THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
1212:             WITH THIS.obj_4c_SAIDA
1213:                 .ButtonCount = 1
1214:                 .BackStyle   = 0
1215:                 .BorderStyle = 0
1216:                 .Height      = 85
1217:                 .Left        = 387
1218:                 .Top         = -1
1219:                 .Width       = 85
1220:                 .Visible     = .T.
1221: 
1222:                 WITH .Buttons(1)
1223:                     .Top        = 5
1224:                     .Left       = 5
1225:                     .Height     = 75
1226:                     .Width      = 75
1227:                     .FontBold   = .T.
1228:                     .FontItalic = .T.
1229:                     .FontName   = "Comic Sans MS"
1230:                     .FontSize   = 8
1231:                     .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1232:                     .Cancel     = .T.
1233:                     .Caption    = "<Esc> \<Sair"
1234:                     .ForeColor  = RGB(90, 90, 90)
1235:                     .BackColor  = RGB(255, 255, 255)
1236:                     .Themes     = .F.
1237:                 ENDWITH
1238:             ENDWITH
1239: 
1240:             *-- Origem: SIGPRIFF.SAIDA.GotFocus (laco interativo completo -
1241:             *-- ver ExecutarConsultaSiTef) e SIGPRIFF.SAIDA.CANCELA.Click
1242:             *-- (fecha a tela, exceto quando Lastkey()=13 - ver
1243:             *-- BtnSaidaClick). BINDEVENT exige metodo PUBLIC (regra
1244:             *-- CLAUDE.md #3) - os dois ja estao declarados sem PROTECTED.
1245:             BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "GotFocus", THIS, "BtnSaidaGotFocus")
1246:             BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnSaidaClick")
1247:         CATCH TO loc_oErro
1248:             MsgErro(loc_oErro.Message + CHR(13) + ;
1249:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1250:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRTFH.ConfigurarSaida")
1251:         ENDTRY
1252:     ENDPROC
1253: 
1254:     *--------------------------------------------------------------------------
1255:     * Activate - dispara o laco interativo com o terminal SiTef, espelhando
1256:     * o efeito do legado ("ThisForm.Saida.Cancela.SetFocus" no fim do Init,
1257:     * que faz o CANCELA.GotFocus disparar sozinho quando a tela aparece -
1258:     * nenhum outro controle do form aceita foco). A trava
1259:     * this_lLoopExecutado garante UMA unica execucao automatica (ver a nota
1260:     * na declaracao da property); o clique manual no botao (BtnSaidaClick)
1261:     * nao passa por esta trava.
1262:     *
1263:     * Nao dispara em modo teste/validacao de UI: o laco chama a DLL
1264:     * CliSiTef32I.DLL e grava arquivo em C:\client\Resp\ (GravarRetornoFalha/
1265:     * GravarRetornoSucesso) - efeitos colaterais que a instanciacao
1266:     * automatizada (TesteAutomatico/ValidarUIFidelity) nao deve produzir.
1267:     *--------------------------------------------------------------------------
1268:     PROCEDURE Activate()
1269:         THIS.DispararLacoSiTefSeNecessario()
1270:     ENDPROC
1271: 
1272:     *--------------------------------------------------------------------------
1273:     * BtnSaidaGotFocus - segunda via do mesmo disparo (ver Activate). Fica
1274:     * ligado ao botao por BINDEVENT (ConfigurarSaida) para o caso de o
1275:     * GotFocus do botao preceder o Activate do form - qualquer um dos dois
1276:     * que chegar primeiro dispara o laco; o outro vira no-op pela trava.
1277:     *--------------------------------------------------------------------------
1278:     PROCEDURE BtnSaidaGotFocus()
1279:         THIS.DispararLacoSiTefSeNecessario()
1280:     ENDPROC
1281: 
1282:     *--------------------------------------------------------------------------
1283:     * DispararLacoSiTefSeNecessario - trava de reentrancia compartilhada por
1284:     * Activate/BtnSaidaGotFocus.
1285:     *--------------------------------------------------------------------------
1286:     PROTECTED PROCEDURE DispararLacoSiTefSeNecessario()
1287:         IF THIS.this_lLoopExecutado
1288:             RETURN
1289:         ENDIF
1290: 
1291:         IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
1292:                 (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
1293:             RETURN
1294:         ENDIF
1295: 
1296:         THIS.this_lLoopExecutado = .T.
1297:         THIS.ExecutarConsultaSiTef()
1298:     ENDPROC
1299: 
1300:     *--------------------------------------------------------------------------
1301:     * BtnSaidaClick - Origem: SIGPRIFF.SAIDA.CANCELA.Click
1302:     *   If Lastkey() = 13 / Return / Endif / RELEASE WINDOWS
1303:     * O CommandButton tem Cancel=.T. (ConfigurarSaida), entao o Click
1304:     * tambem dispara ao pressionar ESC. O guard do Lastkey()=13 evita
1305:     * fechar a tela quando o Click e' disparado por um ENTER que sobrou de
1306:     * outro lugar (o unico controle focavel e' este botao).
1307:     *
1308:     * "RELEASE WINDOWS" do legado fecha a tela e devolve pcRetChe ao
1309:     * chamador via Unload (DO FORM ... TO RetCrtChq). NAO usar
1310:     * THIS.Release() aqui - destruiria o objeto antes do chamador
1311:     * conseguir ler THIS.this_cRetChe. Padrao canonico deste projeto para
1312:     * dialogo modal com retorno (FormSIGPRSTF/FormSIGPRIFF): grava o
1313:     * resultado na property PUBLIC e fecha com THIS.Hide() - o Show()
1314:     * modal do chamador desbloqueia, o objeto continua vivo para leitura,
1315:     * e e' destruido so quando a variavel do chamador sair de escopo.
1316:     *--------------------------------------------------------------------------
1317:     PROCEDURE BtnSaidaClick()
1318:         IF LASTKEY() = 13
1319:             RETURN
1320:         ENDIF
1321: 
1322:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1323:             THIS.this_cRetChe = THIS.this_oBusinessObject.ObterRetornoFinal()
1324:         ELSE
1325:             THIS.this_cRetChe = "999 - Consulta com Erro"
1326:         ENDIF
1327: 
1328:         THIS.Hide()
1329:     ENDPROC
1330: 
1331:     *--------------------------------------------------------------------------
1332:     * ExecutarConsultaSiTef - Laco interativo completo com o terminal SiTef.
1333:     * Origem: SIGPRIFF.SAIDA.GotFocus (316 linhas - ver
1334:     * tasks\task683\SIGPRTFH_form_codigo_fonte.txt). Os metodos de protocolo
1335:     * (IniciarSessaoSiTef/ContinuarFuncaoSiTef/MontarBuffer*/Capturar*/
1336:     * Registrar*/Decodificar*) ja estao portados no SIGPRTFHBO (Fases 1-2) -
1337:     * este metodo so orquestra o laco chamando-os, na MESMA ordem de testes
1338:     * do legado.
1339:     *
1340:     * DUAS sub-interacoes do legado nao tem equivalente no acervo migrado e
1341:     * sao tratadas pela regra CLAUDE.md #27 (ausencia tem de ficar VISIVEL,
1342:     * nunca step silencioso):
1343:     *   - "DO FORM SigCqTef TO opcaoc" (comando 21, 2a etapa, so quando
1344:     *     pcPesquisa vem vazio) - dialogo que pede ao operador o TIPO de
1345:     *     consulta SERASA. SigCqTef.SCX nao esta no acervo.
1346:     *   - "DO FORM SIGPRIFF WITH Escolhas,lptipo,lcTitulo,TamanhoMinimo,
1347:     *     TamanhoMaximo,TipoDados TO Valores" (bloco generico dos comandos
1348:     *     30/21/34/20/31 quando nem o auto-preenchimento por pcFuncoes='1'
1349:     *     nem a lista pcFuncoes completa respondem) - no dump capturado,
1350:     *     SIGPRIFF so tem o Init de 24 parametros da tela de Consulta de
1351:     *     Cheque; o dialogo GENERICO de captura (que receberia os 6
1352:     *     parametros Escolhas/lptipo/... e devolveria Valores) e' uma peca
1353:     *     separada, ausente do acervo (SigCqTef e SIGCHTEF, usado no
1354:     *     TipoCampo=517 do comando 31, tambem ausentes).
1355:     * Nos dois casos o legado so avanca quando o operador RESPONDE ao
1356:     * dialogo; sem o dialogo, a resposta nunca chega - e o MESMO desfecho
1357:     * que o proprio legado ja usa quando o operador fecha esses dialogos
1358:     * sem responder (opcaoc = "0" / EMPTY(valores) OR ISNULL(valores)):
1359:     * grava retorno de falha "Operacao Cancelada pelo Usuario" e encerra,
1360:     * SEM decodificar o buffer final. Isso nao e' inventar comportamento -
1361:     * e' reusar a saida que o proprio protocolo ja prevê para "nada foi
1362:     * respondido".
1363:     *--------------------------------------------------------------------------
1364:     PROCEDURE ExecutarConsultaSiTef()
1365:         LOCAL loc_oBO, loc_nStts, loc_cOpcao, loc_cMsg, loc_lEncerrarSemDecodificar, loc_oErro
1366: 
1367:         loc_oBO = THIS.this_oBusinessObject
1368:         IF VARTYPE(loc_oBO) != "O"
1369:             RETURN
1370:         ENDIF
1371: 
1372:         *-- Sincroniza tela -> BO no instante em que o protocolo vai consumir
1373:         *-- os dados do cheque (MontarBufferCheque le as properties abaixo).
1374:         *-- Round-trip de identidade neste legado - ver cabecalho de
1375:         *-- FormParaBO - e o ponto canonico de transferencia antes da acao.
1376:         THIS.FormParaBO()
1377: 
1378:         loc_lEncerrarSemDecodificar = .F.
1379: 
1380:         TRY
1381:             IF loc_oBO.IniciarSessaoSiTef()
1382: 
1383:                 DO WHILE loc_oBO.this_nStatus = 10000
1384:                     loc_nStts = loc_oBO.ContinuarFuncaoSiTef()
1385: 
1386:                     IF loc_nStts = -2
1387:                         loc_oBO.RegistrarCancelamentoUsuario()
1388:                         EXIT
1389:                     ENDIF
1390: 
1391:                     IF loc_nStts != 10000
1392:                         loc_oBO.RegistrarMensagemParcial(loc_oBO.this_cBuffer)
1393:                         EXIT
1394:                     ENDIF
1395: 
1396:                     *-- Stts = 10000: processa este passo do protocolo. A
1397:                     *-- mensagem de acompanhamento (comando 22 do passo
1398:                     *-- anterior) e' exibida ANTES de ser consumida -
1399:                     *-- origem: "Wait Clear / Label1.ForeColor=Rgb(0,120,0) /
1400:                     *-- Label1.FontSize=24 / Label1.Caption=Alltrim(lsMensagem)".
1401:                     IF !EMPTY(loc_oBO.this_cMensagemSiTef)
1402:                         loc_cMsg = ALLTRIM(loc_oBO.this_cMensagemSiTef)
1403:                         WITH THIS.cnt_4c_Container1.lbl_4c_Label1
1404:                             .ForeColor = RGB(0, 120, 0)

*-- Linhas 1536 a 1603:
1536:         CATCH TO loc_oErro
1537:             MsgErro(loc_oErro.Message + CHR(13) + ;
1538:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1539:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRTFH.ExecutarConsultaSiTef")
1540:         ENDTRY
1541:     ENDPROC
1542: 
1543:     *--------------------------------------------------------------------------
1544:     * ExibirMensagemTef - substitui "DO Form SigTfDss WITH titulo,'',msg1,
1545:     * msg2,..." (dialogo de mensagem do legado, SigTfDss.SCX nao esta no
1546:     * acervo). Mesmo padrao ja adotado em Formsigprdft.ExibirMensagemTef
1547:     * (MsgAviso - mensagem transitoria de protocolo, nao erro tecnico).
1548:     *--------------------------------------------------------------------------
1549:     PROTECTED PROCEDURE ExibirMensagemTef(par_cTitulo, par_cMsg1, par_cMsg2)
1550:         LOCAL loc_cMsg
1551:         loc_cMsg = ALLTRIM(par_cMsg1)
1552:         IF !EMPTY(par_cMsg2)
1553:             loc_cMsg = loc_cMsg + CHR(13) + ALLTRIM(par_cMsg2)
1554:         ENDIF
1555:         MsgAviso(loc_cMsg, par_cTitulo)
1556:     ENDPROC
1557: 
1558:     *--------------------------------------------------------------------------
1559:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
1560:     * padrao (regra CLAUDE.md). Percorre recursivamente e torna visivel,
1561:     * EXCETO as 3 linhas de status que o legado mantem ocultas na abertura
1562:     * (Container1.Label2/3/4 - ver ConfigurarContainerStatus).
1563:     *--------------------------------------------------------------------------
1564:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1565:         LOCAL loc_nI, loc_oControl, loc_lExcluido
1566: 
1567:         IF VARTYPE(par_oContainer) != "O"
1568:             RETURN
1569:         ENDIF
1570: 
1571:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1572:             loc_oControl = par_oContainer.Controls(loc_nI)
1573: 
1574:             IF VARTYPE(loc_oControl) = "O"
1575:                 loc_lExcluido = INLIST(UPPER(loc_oControl.Name), ;
1576:                     "LBL_4C_LABEL2", "LBL_4C_LABEL3", "LBL_4C_LABEL4")
1577: 
1578:                 IF PEMSTATUS(loc_oControl, "Visible", 5) AND !loc_lExcluido
1579:                     loc_oControl.Visible = .T.
1580:                 ENDIF
1581: 
1582:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1583:                     THIS.TornarControlesVisiveis(loc_oControl)
1584:                 ENDIF
1585:             ENDIF
1586:         ENDFOR
1587:     ENDPROC
1588: 
1589:     *--------------------------------------------------------------------------
1590:     * Destroy - Libera o cursor local do SiTef se ainda estiver aberto
1591:     * (SIGPRTFHBO.GravarRetornoFalha/GravarRetornoSucesso usam crSiTef e
1592:     * encerram com USE IN no caminho normal, mas um erro no meio do laco
1593:     * interativo pode deixa-lo aberto).
1594:     *--------------------------------------------------------------------------
1595:     PROCEDURE Destroy()
1596:         IF USED("crSiTef")
1597:             USE IN crSiTef
1598:         ENDIF
1599: 
1600:         DODEFAULT()
1601:     ENDPROC
1602: 
1603: ENDDEFINE

