# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (15)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_CCRED, CNT_4C_CCREDFP, CNT_4C_CARNEFP, CNT_4C_OUTROSFP, CNT_4C_CHEQUEFP. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.ExisteFormaPagamentoValida()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AplicarFormaPagamento()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltroFormasValidas()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.MoedaPermiteCotacao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CargoTemAltCots()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarCambio()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.PodeAlterarCotacao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarInfoFormaPagamento()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AtualizarTotalFormaPagamento()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterTrocosDaForma()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Value()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AvancarAlemDosFeriados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpFpg.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4750 linhas total):

*-- Linhas 24 a 457:
24: * FASE 3/8: estrutura base - DEFINE CLASS, propriedades que espelham o
25: * contexto recebido do form pai e o estado do painel (Leitor/Digpar/CotUsu),
26: * Init(par_oFormPai, par_nDataSessionPai, par_lAltDireta) equivalente a
27: * Lparameters pForm, DatSes, llAltDireta, InicializarForm() (cria o BO,
28: * espelha Op_Escolha/AltDireta nele, desabilita o form pai) e os elementos
29: * puramente decorativos do layout (faixa do cabecalho cnt_4c_Sombra e os dois
30: * elementos graficos soltos do form - shp_4c_Shape1/lin_4c_Line1).
31: *
32: * FASE 4/8: Grade de formas de pagamento (grd_4c_Dados, equivalente
33: * a Grade/xPar do legado - cursor local cursor_4c_Dados com as 5 colunas
34: * usadas pelo grid: FPags/Valos/Vencs/MoeFpgs/CotFpgs) e os botoes Apaga/Ok/
35: * Cancela (cmd_4c_Apaga/cmd_4c_Ok/cmd_4c_Cancela), adicionados ao form DEPOIS
36: * da faixa do cabecalho para desenhar por cima dela (regra #11 - os botoes
37: * ficam em Top=3, dentro da faixa de Top=0..80). Os demais campos de xPar
38: * (bancos/agencias/contas/numeros/cartaos/nocreditos/ncarnes/outros/obs), que
39: * so os paineis flutuantes da Fase 6 usam, entram quando essa fase ampliar a
40: * mesma CREATE CURSOR (nao criar um segundo cursor_4c_Dados em outro lugar -
41: * regra de forms OPERACIONAIS: mesmo cursor, mesma ordem de campos sempre).
42: *
43: * Junto com a grade vem o FUNIL de carga/repintura - CarregarDados() - que
44: * transcreve o que o Init legado faz com a grade:
45: *
46: *   With ThisForm.Grade                     -> VincularGrade()
47: *       .RecordSource='xPar'
48: *       .fpagto.controlsource='xPar.FPags'
49: *       ... (5 colunas)
50: *       .refresh
51: *   EndWith
52: *   Select xPar / Go Top                    -> SELECT (cursor) + GO TOP
53: *
54: * O vinculo fica num metodo PROPRIO (VincularGrade) porque CarregarDados tem
55: * de poder REFAZE-LO: re-atribuir RecordSource reseta Column.Width,
56: * Column.Header1.Caption e a fonte das colunas (Problema 48 / regra #41), e
57: * cada caminho que popula o cursor precisa fechar com GO TOP + Refresh, senao
58: * a grade fica visualmente vazia com o cursor cheio (regra #21). Os pontos que
59: * alteram xPar no legado (Apaga.Click com Zap, Valor.Valid, fweditdata_Venc.
60: * Valid que gera as parcelas) chamam este mesmo funil nas fases de eventos.
61: *
62: * AjustarBotoesPorModo() reproduz a ULTIMA linha de botao do Init legado -
63: * `ThisForm.Apaga.Visible = Inlist(Op_Escolha,'INSERIR','ALTERAR')` - e roda
64: * DEPOIS de TornarControlesVisiveis, que forca Visible=.T. em tudo e apagaria
65: * a regra. O bloco que mexia em Ok.Left/Ok.Cancel/Cancela por llAltDireta esta
66: * COMENTADO (`*!*`) no SCX legado e por isso nao eh transcrito.
67: *
68: * FASE 5/8: Campos do cabecalho do dialogo (txt_4c_Fpg/MoeOper/
69: * Npar/Vpar/Fweditdata_venc/PEncargo/VEncargo/COTACAO/Porc/MoeOcr/
70: * ValTotChqs/TotForma, obj_4c_GetObs, os avisos de leitora serial
71: * img_4c_AvisoPorta* e os respectivos labels), em ConfigurarCampos().
72: * So geometria/aparencia (Visible/Value/InputMask iniciais): lookup de
73: * Get_fpg, calculo de parcelas/encargo/cotacao e a alternancia Get_npar x
74: * Get_MoeOcr ficam para as fases de eventos (7 e 8).
75: * FASE 6/8 (ESTA FASE): Paineis flutuantes por forma de pagamento
76: * (cnt_4c_CCred/cnt_4c_CCredFP - cartao de credito, cnt_4c_CarneFP - carne,
77: * cnt_4c_OutrosFP - observacao livre, cnt_4c_ChequeFP - dados do cheque),
78: * em ConfigurarPaineisFlutuantes(). Todos nascem Visible=.F. (igual ao dump)
79: * e TornarControlesVisiveis() ganhou a excecao que preserva esse Visible=.F.
80: * nos 5 containers (lista de nomes CNT_4C_*), descendo a recursao so para os
81: * filhos. cursor_4c_Dados (GarantirCursorDados) ganhou os campos que esses
82: * paineis usam de xPar (Bancos/Agencias/Contas/Numeros/Cartaos/Nocreditos/
83: * Ncarnes/Outros). A alternancia real de Visible (MostraObs/mCartaoCred) e
84: * o trafego com o cursor saem nas fases de eventos (7 e 8).
85: *
86: * Ainda na Fase 6, o LOOKUP do unico campo do dialogo que tem busca -
87: * Get_fpg ("Cond. Pagto"), que no legado abre o browse fwBuscaSel sobre
88: * csSigOpFp - fica COMPLETO: ConfigurarEventosLookup() liga "LostFocus"
89: * (equivalente ao Valid, que roda ao SAIR do campo) e "KeyPress" (ENTER
90: * confirma, F4/F5 abrem a busca direta), e o lookup se resolve em
91: * AbrirLookupFpg / ObterFiltroFormasValidas / ExisteFormaPagamentoValida /
92: * AplicarFormaPagamento / LimparFormaPagamento. Ver o bloco de comentario
93: * desses metodos para a transcricao linha a linha do Valid legado e para a
94: * razao de haver DOIS universos (csSigOpFp filtrado para o browse, crSigOpFp
95: * sem filtro para ler o registro escolhido).
96: *
97: * FASE 7/8 (ESTA FASE): Eventos principais - o Click dos CINCO botoes que o
98: * SCX legado tem, ligados em ConfigurarEventosBotoes (BINDEVENT "Click", que
99: * exige metodo PUBLIC - regra #3):
100: *
101: *   SIGOPFPG.Apaga.Click             -> CmdApagaClick
102: *   SIGOPFPG.Ok.Click                -> CmdOkClick
103: *   SIGOPFPG.Cancela.Click           -> CmdCancelaClick
104: *   SIGOPFPG.alteracotacao.Click     -> CmdAlteraCotacaoClick (+ o When do
105: *                                       botao, em PodeAlterarCotacao)
106: *   SIGOPFPG.CntCCred.Confirma.Click -> CmdConfirmaCartaoClick
107: *
108: * Esta tela NAO tem botao CRUD (Incluir/Alterar/Visualizar/Excluir): o SCX
109: * legado herda de `form` puro, nao de `frmcadastro` - nao ha barra CRUD, nem
110: * `pcEscolha` propria (o modo eh LIDO do form pai: `Thisform.Op_Escolha =
111: * pForm.pcEscolha`). Logo nao existe aqui o quarteto de handlers Btn<verbo>
112: * Click da convencao de cadastro: criar esses botoes seria INVENTAR superficie
113: * que o legado nao tem (viola o PILAR 1), e criar os metodos vazios violaria a
114: * regra de completude. O dump confirma: zero ocorrencia de `frmcadastro`,
115: * `Grupo_Op` e `pcEscolha` propria.
116: *
117: * Junto com os handlers vem as tres rotinas do legado que eles acionam, cada
118: * uma transcrita do dump:
119: *
120: *   PROCEDURE mostraobs    -> MostrarObservacao (+ CarregarInfoFormaPagamento,
121: *                             que substitui o `Seek` em CrSigOpFp por SELECT
122: *                             em SigOpFp - este dialogo tem DataSession = 2 e
123: *                             nao alcanca os cursores da sessao do pai)
124: *   PROCEDURE mcartaocred  -> CartaoCredito
125: *   PROCEDURE return       -> FecharDialogo (fonte unica dos dois caminhos de
126: *                             saida, com this_lConfirmado dizendo ao form pai
127: *                             se o usuario confirmou ou cancelou)
128: *
129: * FASE 8/8 (ESTA FASE): eventos dos CAMPOS e a transferencia com o form pai -
130: * calculo de parcelas/encargo e o bloco de cotacao/cambio do Valid de
131: * Get_vpar/GetPorc/fweditdata_venc (CarregarCambio/MoedaPermiteCotacao/
132: * CargoTemAltCots substituem crSigCdMoe/crUsuario/crSigCdCrg - cursores
133: * globais do login legado, inexistentes aqui, por SQLEXEC direto), o leitor
134: * serial de cheques (InChequeSerial/VerificaCheque/LimpaChe - ReadComm OLE
135: * nao existe nesta arquitetura, degrada para digitacao manual, mesmo padrao
136: * de Formsigopcim.PrepararLeitoraParaFoco), DefinirDadosTitulo (API publica
137: * para o form pai informar data de entrada/valor total/empresa do titulo -
138: * substitui a leitura direta de crSigChLcq, que este dialogo com DataSession
139: * propria nao alcanca) e as validacoes de venc < data de entrada, digitos do
140: * cheque e numero do cartao de credito. As celulas de Valor/Vencimento da
141: * grade (Column2/Column3) ganharam classes TextBox proprias (regra #46 -
142: * TextBoxCelulaValorFpg/TextBoxCelulaVencFpg, declaradas antes desta
143: * DEFINE CLASS) porque a validacao delas mora no Valid da CELULA, nao em
144: * AfterRowColChange nem em BINDEVENT de Valid.
145: *
146: * Herda de: FormBase
147: *==============================================================================
148: 
149: *==============================================================================
150: * TextBoxCelulaValorFpg / TextBoxCelulaVencFpg - celulas editaveis das colunas
151: * Valor/Vencimento da grade de formas de pagamento (SIGOPFPG.Grade.valor.
152: * Text1 / SIGOPFPG.Grade.venc.Text1 do legado). Regra #46: celula de grade
153: * valida no PROPRIO Valid do TextBox da coluna, nunca em AfterRowColChange
154: * (nColIndex ali eh a coluna de DESTINO) - e BINDEVENT em Valid de TextBox de
155: * Column nao eh confiavel, por isso o Valid eh metodo DA CLASSE.
156: *
157: * this_oForm guarda a referencia ao FormSigOpFpg (setada apos o AddObject, em
158: * VincularGrade) porque o TextBox criado dentro de uma Column nao alcanca
159: * ThisForm pelo caminho usual em todos os contextos de disparo do Valid.
160: *==============================================================================
161: DEFINE CLASS TextBoxCelulaValorFpg AS TextBox
162:     this_oForm = .NULL.
163: 
164:     PROCEDURE Valid()
165:         IF VARTYPE(THIS.this_oForm) = "O"
166:             RETURN THIS.this_oForm.ValidarValorLinhaGrade()
167:         ENDIF
168:         RETURN .T.
169:     ENDPROC
170: ENDDEFINE
171: 
172: DEFINE CLASS TextBoxCelulaVencFpg AS TextBox
173:     this_oForm = .NULL.
174: 
175:     PROCEDURE Valid()
176:         IF VARTYPE(THIS.this_oForm) = "O"
177:             RETURN THIS.this_oForm.ValidarVencimentoLinhaGrade()
178:         ENDIF
179:         RETURN .T.
180:     ENDPROC
181: ENDDEFINE
182: 
183: DEFINE CLASS FormSigOpFpg AS FormBase
184: 
185:     *-- Mensagem de erro capturada no InicializarForm (padrao FormBase)
186:     this_cMensagemErro = ""
187: 
188:     *-- Contexto recebido do formulario pai (Init legado: Lparameters pForm,
189:     *-- DatSes, llAltDireta)
190:     this_oFormPai          = .NULL.  && pForm - form de movimento que abriu o dialogo
191:     this_nDataSessionPai   = 0       && DatSes - DataSessionID do form pai (cursores compartilhados)
192:     this_cOpEscolha        = ""      && pForm.pcEscolha (INSERIR/ALTERAR/CONSULTAR/EXCLUIR)
193:     this_lAltDireta        = .F.     && llAltDireta - fluxo de alteracao direta de forma de pagamento
194: 
195:     *-- Estado do painel (flags/variaveis soltas do form legado)
196:     this_lLeitor           = .F.     && Thisform.Leitor - leitora serial de cheques ativa
197:     this_cLeituraSerial    = ""      && Thisform.LeituraSerial - buffer da porta serial
198:     this_cTipoLeitora      = ""      && Thisform.TipoLeitora - "S" = leitora serial configurada
199:     this_lDigpar           = .F.     && Thisform.Digpar - habilita digitacao manual do numero de parcelas
200:     this_cCotUsu           = ""      && Thisform.CotUsu - indicador de cotacao alterada via SigOpAlC
201: 
202:     *-- Resultado do dialogo para o formulario pai (FASE 7/8): .T. quando o
203:     *-- usuario saiu por Confirmar (Ok) e .F. quando saiu por Cancelar. O
204:     *-- legado nao precisava disso - pai e dialogo compartilhavam a
205:     *-- datasession e o resultado era o proprio cursor xPar; aqui o dialogo
206:     *-- tem DataSession = 2 e o pai le esta property depois do Show().
207:     this_lConfirmado       = .F.
208: 
209:     *-- Valor anterior do campo Cotacao (peantvalue da classe fwget legado,
210:     *-- usado pelo alteracotacao.Click para desfazer a alteracao quando a
211:     *-- autorizacao eh cancelada). TextBox do VFP9 nao tem peantvalue.
212:     this_nCotacaoAnterior  = 0
213: 
214:     *-- Estado da forma de pagamento da LINHA CORRENTE da grade, resolvido em
215:     *-- CarregarInfoFormaPagamento e consumido por MostrarObservacao
216:     *-- (equivalente a CrSigOpFp.Infos e CrSigOpFp.Obs do mostraobs legado)
217:     this_cInfoForma        = ""      && SigOpFp.infos - C=cheque, N=carne, O=outros, T=cartao
218:     this_lObsForma         = .F.     && SigOpFp.obs = 1 - a forma pede observacao
219: 
220:     *-- Guarda de reentrancia do lookup (regra #37/#47): FormBuscaAuxiliar eh
221:     *-- MODAL - o Show() tira o foco do campo e faz o proprio LostFocus
222:     *-- disparar de novo, empilhando um segundo picker. Ligada no FUNIL
223:     *-- (TxtFpgLostFocus), que cobre as duas entradas (F4 e saida do campo).
224:     this_lEmLookup         = .F.
225: 
226:     *-- Alias do cursor das linhas da grade (equivalente a xPar do legado).
227:     *-- FONTE UNICA do nome: GarantirCursorDados/VincularGrade/CarregarDados e
228:     *-- as fases seguintes leem daqui, para o alias nao divergir entre fases.
229:     this_cCursorGrade      = "cursor_4c_Dados"
230: 
231:     *-- Cache de feriados (SigCdFer), usado pelo gerador de parcelas
232:     *-- (fweditdata_venc.Valid, Fase 8) para empurrar o vencimento alem de
233:     *-- um feriado - mesmo padrao de SigPrCfnBO.CarregarFeriados/
234:     *-- this_cFeriados.
235:     this_cFeriadosCache      = "|"
236:     this_lFeriadosCarregados = .F.
237: 
238:     *-- Configuracoes visuais do form (fieis ao SCX legado - SIGOPFPG)
239:     DataSession  = 2
240:     WindowType = 1
241:     ShowWindow   = 1
242:     Width        = 800
243:     Height       = 600
244:     Caption      = "Forma de Pagamento"
245:     ControlBox   = .F.
246:     Closable     = .F.
247:     Movable      = .F.
248:     TitleBar     = 0
249:     WindowState  = 0
250:     AutoCenter   = .T.
251:     BorderStyle  = 2
252:     AlwaysOnTop  = .F.
253: 
254:     *--------------------------------------------------------------------------
255:     * Init - equivalente a Lparameters pForm, DatSes, llAltDireta. Guarda os
256:     * parametros ANTES de DODEFAULT() (que aciona FormBase.Init() ->
257:     *--------------------------------------------------------------------------
258:     PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_lAltDireta)
259:         THIS.this_oFormPai        = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
260:         THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)
261:         THIS.this_lAltDireta      = IIF(VARTYPE(par_lAltDireta) = "L", par_lAltDireta, .F.)
262: 
263:         RETURN DODEFAULT()
264:     ENDPROC
265: 
266:     *--------------------------------------------------------------------------
267:     * InicializarForm - Hook chamado por FormBase.Init(). Cria o Business
268:     * Object, espelha o contexto do form pai nele (equivalente a
269:     * Thisform.Op_Escolha = pForm.pcEscolha / pForm.Enabled = .F.) e monta a
270:     * estrutura visual basica (faixa do cabecalho + decoracao).
271:     *--------------------------------------------------------------------------
272:     PROTECTED PROCEDURE InicializarForm()
273:         LOCAL loc_lSucesso, loc_oErro
274:         loc_lSucesso = .F.
275: 
276:         TRY
277:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpFpgBO")
278: 
279:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
280:                 *-- Legado: Thisform.Op_Escolha = pForm.pcEscolha + pForm.Enabled = .F.
281:                 IF VARTYPE(THIS.this_oFormPai) = "O"
282:                     IF PEMSTATUS(THIS.this_oFormPai, "pcEscolha", 5)
283:                         THIS.this_cOpEscolha = THIS.this_oFormPai.pcEscolha
284:                     ENDIF
285: 
286:                     IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
287:                         THIS.this_oFormPai.Enabled = .F.
288:                     ENDIF
289:                 ENDIF
290: 
291:                 THIS.this_oBusinessObject.this_cOpEscolha = THIS.this_cOpEscolha
292:                 THIS.this_oBusinessObject.this_lAltDireta = THIS.this_lAltDireta
293: 
294:                 THIS.ConfigurarEstruturaBase()
295: 
296:                 loc_lSucesso = .T.
297:             ENDIF
298:         CATCH TO loc_oErro
299:             THIS.this_cMensagemErro = loc_oErro.Message
300:             MsgErro(loc_oErro.Message + CHR(13) + ;
301:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
302:                 "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar Forma de Pagamento")
303:             loc_lSucesso = .F.
304:         ENDTRY
305: 
306:         RETURN loc_lSucesso
307:     ENDPROC
308: 
309:     *--------------------------------------------------------------------------
310:     * ConfigurarEstruturaBase - Faixa do cabecalho + elementos decorativos.
311:     * Grade, campos e paineis flutuantes entram nas fases seguintes.
312:     *--------------------------------------------------------------------------
313:     PROTECTED PROCEDURE ConfigurarEstruturaBase()
314:         THIS.ConfigurarCabecalho()
315:         THIS.ConfigurarDecoracao()
316:         THIS.ConfigurarCampos()
317:         THIS.ConfigurarGrade()
318:         THIS.ConfigurarBotoes()
319:         THIS.ConfigurarPaineisFlutuantes()
320:         THIS.ConfigurarEventosLookup()
321: 
322:         *-- BINDEVENT dos botoes DEPOIS de todos os AddObject que os criam
323:         *-- (ConfigurarBotoes, ConfigurarCampos e ConfigurarPaineisFlutuantes):
324:         *-- BINDEVENT exige o objeto ja existente
325:         THIS.ConfigurarEventosBotoes()
326: 
327:         THIS.TornarControlesVisiveis(THIS)
328: 
329:         *-- DEPOIS do TornarControlesVisiveis, que forca Visible=.T. em tudo:
330:         *-- a visibilidade do Apaga depende do modo (Init legado) e seria
331:         *-- apagada se fosse aplicada antes.
332:         THIS.AjustarBotoesPorModo()
333: 
334:         *-- Idem para os controles que o dump do SCX ja nasce com
335:         *-- Visible = .F. (Get_COTACAO/alteracotacao/GetObs/SayObs) - sem
336:         *-- reaplicar DEPOIS do TornarControlesVisiveis, ele reverte os
337:         *-- quatro para .T. e o bloco de alterar cotacao / observacao
338:         *-- aparece sempre, fora do fluxo que os liga (MostrarObservacao e
339:         *-- CmdAlteraCotacaoClick, Fase 7).
340:         *-- Medido no VFP9 (probe da Fase 5): sem esta chamada os 4 saiam
341:         *-- Visible=.T. na instanciacao.
342:         THIS.OcultarCamposCondicionais()
343: 
344:         *-- FASE 8/8: leitora de cheques (SigSyCom) + campos dependentes do
345:         *-- estado "sem forma de pagamento escolhida" (comeca assim) +
346:         *-- Credito espelho (this_lCarAuts comeca .F.) - tudo ANTES do
347:         *-- `Select xPar / Go Top` final, igual ao Init legado.
348:         THIS.ResolverTipoLeitora()
349:         THIS.ResolverMoedaOperacao()
350:         THIS.AtualizarCamposPorFormaPagamento()
351:         THIS.AtualizarEnabledCreditoFp()
352: 
353:         *-- `Select xPar / Go Top` do fim do Init legado + o `.refresh` da
354:         *-- grade. Depois do TornarControlesVisiveis de proposito: Refresh em
355:         *-- controle ainda invisivel nao pinta (regra #21).
356:         THIS.CarregarDados()
357:     ENDPROC
358: 
359:     *--------------------------------------------------------------------------
360:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra no legado)
361:     *--------------------------------------------------------------------------
362:     PROTECTED PROCEDURE ConfigurarCabecalho()
363:         THIS.AddObject("cnt_4c_Sombra", "Container")
364:         WITH THIS.cnt_4c_Sombra
365:             .Top         = 0
366:             .Left        = 0
367:             .Width       = THIS.Width
368:             .Height      = 80
369:             .BorderWidth = 0
370:             .BackStyle   = 1
371:             .BackColor   = RGB(100, 100, 100)
372:             .Visible     = .T.
373:         ENDWITH
374: 
375:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
376:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
377:             .FontBold  = .T.
378:             .FontName  = "Tahoma"
379:             .FontSize  = 18
380:             .WordWrap  = .T.
381:             .Alignment = 0
382:             .BackStyle = 0
383:             .AutoSize  = .F.
384:             .Top       = 18
385:             .Left      = 10
386:             .Width     = 769
387:             .Height    = 40
388:             .ForeColor = RGB(0, 0, 0)
389:             .Caption   = THIS.Caption
390:             .Visible   = .T.
391:         ENDWITH
392: 
393:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
394:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
395:             .FontBold  = .T.
396:             .FontName  = "Tahoma"
397:             .FontSize  = 18
398:             .WordWrap  = .T.
399:             .Alignment = 0
400:             .BackStyle = 0
401:             .AutoSize  = .F.
402:             .Top       = 17
403:             .Left      = 10
404:             .Width     = 769
405:             .Height    = 46
406:             .ForeColor = RGB(255, 255, 255)
407:             .Caption   = THIS.Caption
408:             .Visible   = .T.
409:         ENDWITH
410:     ENDPROC
411: 
412:     *--------------------------------------------------------------------------
413:     * ConfigurarDecoracao - Elementos graficos soltos do form legado, sem
414:     * dado nem comportamento (Shape1 em torno do bloco de moeda/cotacao,
415:     * Line1 separando o bloco de totais).
416:     *--------------------------------------------------------------------------
417:     PROTECTED PROCEDURE ConfigurarDecoracao()
418:         THIS.AddObject("shp_4c_Shape1", "Shape")
419:         WITH THIS.shp_4c_Shape1
420:             .Top         = 7
421:             .Left        = 622
422:             .Width       = 173
423:             .Height      = 110
424:             .BackStyle   = 0
425:             .BorderStyle = 0
426:             .BorderColor = RGB(136, 189, 188)
427:             .Visible     = .T.
428:         ENDWITH
429: 
430:         THIS.AddObject("lin_4c_Line1", "Line")
431:         WITH THIS.lin_4c_Line1
432:             .Top         = 173
433:             .Left        = 429
434:             .Width       = 108
435:             .Height      = 0
436:             .BorderWidth = 2
437:             .Visible     = .T.
438:         ENDWITH
439:     ENDPROC
440: 
441:     *--------------------------------------------------------------------------
442:     * ConfigurarCampos - Campos do cabecalho do dialogo (FASE 5/8), filhos
443:     * DIRETOS do form (layout FLAT, sem PageFrame - nenhuma compensacao de
444:     * Top eh necessaria, os valores sao os mesmos do dump SIGOPFPG).
445:     *
446:     * Cada rotulo eh criado ANTES do seu campo (label tem BackStyle = 0 e nao
447:     * pinta, mas a caixa continua recebendo clique - criado depois, o label
448:     * ficaria por cima e bloquearia o campo).
449:     *
450:     * LABELS - "Say*" do legado sao classe `say` pura (dump NAO declara Width
451:     * nem Alignment): Tahoma 8, AutoSize = .F. EXPLICITO (eh no-op em Label
452:     * criado por AddObject - regra #23), Alignment = 0 (esquerda),
453:     * ForeColor = RGB(90,90,90) (nunca branco: a Page nao existe aqui, mas o
454:     * form tambem nao tem fundo escuro nesta area). Width calculada para caber
455:     * o texto sem invadir o campo vizinho da mesma linha (gap entre o Left do
456:     * label e o Left do campo).
457:     *

*-- Linhas 472 a 519:
472:     * sao criados nas coordenadas exatas do SCX.
473:     *
474:     * Get_COTACAO/cmd_4c_Alteracotacao e GetObs/lbl_4c_Obs nascem Visible=.F.
475:     * (dump) - permanecem assim: TornarControlesVisiveis so forca Visible=.T.
476:     * em controles que ja estao .T., preservando os .F. explicitos aplicados
477:     * DEPOIS dele (igual ao padrao de AjustarBotoesPorModo/cmd_4c_Apaga).
478:     *--------------------------------------------------------------------------
479:     PROTECTED PROCEDURE ConfigurarCampos()
480: 
481:         *-- Say12 "Cond. Pagto : " + Get_fpg -------------------------------
482:         THIS.AddObject("lbl_4c_Label12", "Label")
483:         WITH THIS.lbl_4c_Label12
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .AutoSize  = .F.
487:             .Alignment = 0
488:             .BackStyle = 0
489:             .WordWrap  = .F.
490:             .Caption   = "Cond. Pagto : "
491:             .Left      = 108
492:             .Top       = 127
493:             .Width     = 70
494:             .Height    = 15
495:             .ForeColor = RGB(90, 90, 90)
496:             .Visible   = .T.
497:         ENDWITH
498: 
499:         THIS.AddObject("txt_4c_Fpg", "TextBox")
500:         WITH THIS.txt_4c_Fpg
501:             .FontName    = "Tahoma"
502:             .FontSize    = 8
503:             .Value       = ""
504:             .MaxLength   = 12
505:             .Left        = 181
506:             .Top         = 123
507:             .Width       = 94
508:             .Height      = 23
509:             .ToolTipText = "Digite a forma de pagamento"
510:             .TabIndex    = 1
511:             .Visible     = .T.
512:         ENDWITH
513: 
514:         *-- Say13 "Qtde. Parcelas : " + Get_npar ----------------------------
515:         THIS.AddObject("lbl_4c_Label13", "Label")
516:         WITH THIS.lbl_4c_Label13
517:             .FontName  = "Tahoma"
518:             .FontSize  = 8
519:             .AutoSize  = .F.

*-- Linhas 974 a 1065:
974:     * do grid propaga para as colunas e sobrescreveria o Column1.ReadOnly = .T.
975:     * do legado se viesse depois (regra #18).
976:     *--------------------------------------------------------------------------
977:     PROTECTED PROCEDURE ConfigurarGrade()
978:         THIS.GarantirCursorDados()
979: 
980:         THIS.AddObject("grd_4c_Dados", "Grid")
981:         WITH THIS.grd_4c_Dados
982:             .Top        = 304
983:             .Left       = 89
984:             .Width      = 425
985:             .Height     = 149
986:             *-- TabIndex do dump (SIGOPFPG.Grade.TabIndex = 10). O VFP limita o
987:             *-- valor ao numero de controles ja existentes no container, entao
988:             *-- enquanto os campos do cabecalho e os paineis flutuantes nao
989:             *-- estiverem criados ele fica menor; a ordem final de tabulacao se
990:             *-- estabelece quando todos os controles do form existirem.
991:             .TabIndex   = 10
992:             .ReadOnly   = .F.
993:             .DeleteMark = .F.
994:             .RecordMark = .F.
995:             .ScrollBars = 2
996:         ENDWITH
997: 
998:         THIS.VincularGrade()
999: 
1000:         *-- SIGOPFPG.Grade.AfterRowColChange do legado: `Thisform.mostraobs` +
1001:         *-- `ThisForm.GetObs.Refresh` a cada troca de linha/coluna - alterna os
1002:         *-- paineis flutuantes para a forma de pagamento da linha corrente
1003:         *-- (regra #46: AfterRowColChange SEM filtro de coluna, carregando o
1004:         *-- detalhe da linha, eh o uso CORRETO deste evento).
1005:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1006: 
1007:         THIS.grd_4c_Dados.Visible = .T.
1008:     ENDPROC
1009: 
1010:     *--------------------------------------------------------------------------
1011:     * GarantirCursorDados - Cria o cursor das linhas da grade (equivalente a
1012:     * xPar do legado) se ele ainda nao existir. UNICO ponto do form com a
1013:     * CREATE CURSOR, para que a lista e a ORDEM dos campos sejam sempre as
1014:     * mesmas (regra de forms OPERACIONAIS). Cursor PRIVADO desta datasession
1015:     * (THIS.DataSession = 2), populado pelos proprios eventos do dialogo - nao
1016:     * vem de SQLEXEC, por isso nao precisa de SET NULL ON.
1017:     *
1018:     * Os 5 campos sao exatamente os que o SCX legado liga as colunas
1019:     * (.fpagto='xPar.FPags' / .Valor='xPar.Valos' / .venc='xPar.vencs' /
1020:     * .moeda='xPar.moefpgs' / .cotfpg='xPar.cotfpgs'). Os campos de xPar que
1021:     * so os paineis flutuantes usam (bancos/agencias/contas/numeros/cartaos/
1022:     * nocreditos/ncarnes/outros/obs) sao acrescentados NESTA MESMA CREATE
1023:     * CURSOR quando esses paineis entrarem.
1024:     *--------------------------------------------------------------------------
1025:     PROTECTED PROCEDURE GarantirCursorDados()
1026:         LOCAL loc_cCursor
1027:         loc_cCursor = THIS.this_cCursorGrade
1028: 
1029:         IF !USED(loc_cCursor)
1030:             *-- Os 5 primeiros campos sao os que a grade usa (Fase 4). Os
1031:             *-- demais (Fase 6) sao de xPar usados so pelos paineis
1032:             *-- flutuantes: Bancos/Agencias/Contas/Numeros (CntChequeFP -
1033:             *-- larguras do parse por posicao do Get_bco.Valid legado:
1034:             *-- Substr(Leitura,2,3)/Substr(Leitura,5,4)/Substr(Leitura,23,10)/
1035:             *-- Substr(Leitura,14,6)), Cartaos/Nocreditos (CntCCred/CntCCredFP
1036:             *-- - InputMask do dump "99999999999999999999"=C(20) /
1037:             *-- "XXXXXXXXXX"=C(10)), Ncarnes (CntCarneFP - formatado no legado
1038:             *-- como "@L 999999/N") e Outros (CntOutrosFP - observacao livre,
1039:             *-- TextBox sem InputMask/MaxLength no dump).
1040:             *-- Parcs/Emps/Datas/Dcarts/Cotusus (Fase 8): colunas que o
1041:             *-- `Replace` do gerador de parcelas (fweditdata_venc.Valid)
1042:             *-- grava em CADA linha, alem das 5 que a grade exibe - sao o
1043:             *-- contrato que este dialogo devolve ao form pai (Dcarts
1044:             *-- char(30) espelha SigOpFp.dcarts).
1045:             CREATE CURSOR (loc_cCursor) ;
1046:                 (FPags C(12), Valos N(14,2), Vencs D, MoeFpgs C(3), CotFpgs N(11,6), ;
1047:                  Bancos C(3), Agencias C(4), Contas C(10), Numeros C(6), ;
1048:                  Cartaos C(20), Nocreditos C(10), Ncarnes C(12), Outros C(60), ;
1049:                  Parcs N(3,0), Emps C(3), Datas D, Dcarts C(30), Cotusus C(20))
1050:         ENDIF
1051:     ENDPROC
1052: 
1053:     *--------------------------------------------------------------------------
1054:     * VincularGrade - Transcricao do bloco `With ThisForm.Grade ... EndWith` do
1055:     * Init legado: liga a grade ao cursor e configura as 5 colunas.
1056:     *
1057:     * Ordem obrigatoria (regra #41): ColumnCount -> RecordSource ->
1058:     * ControlSource -> fonte/InputMask/Width/ColumnOrder -> Header1.Caption.
1059:     * Largura e caption depois do RecordSource porque ele as reseta para o
1060:     * default; por isso este metodo eh reexecutavel e eh chamado tambem por
1061:     * CarregarDados.
1062:     *
1063:     * ColumnCount so eh reatribuido se estiver diferente de 5: qualquer
1064:     * atribuicao recria os objetos Column e destruiria controles postos por
1065:     * Column.AddObject (o TextBox de celula com lookup entra numa fase

*-- Linhas 1072 a 1115:
1072:     * nas colunas 3/4/5, igual ao legado. Text1 de cada coluna recebe
1073:     * BorderStyle/Margin/ForeColor/BackColor do dump.
1074:     *--------------------------------------------------------------------------
1075:     PROCEDURE VincularGrade()
1076:         LOCAL loc_cCursor
1077:         loc_cCursor = THIS.this_cCursorGrade
1078: 
1079:         THIS.GarantirCursorDados()
1080: 
1081:         WITH THIS.grd_4c_Dados
1082:             IF .ColumnCount != 5
1083:                 .ColumnCount = 5
1084:             ENDIF
1085: 
1086:             .RecordSource = loc_cCursor
1087: 
1088:             *-- ControlSource das 5 colunas (bloco With ThisForm.Grade legado)
1089:             .Column1.ControlSource = loc_cCursor + ".FPags"
1090:             .Column2.ControlSource = loc_cCursor + ".Valos"
1091:             .Column3.ControlSource = loc_cCursor + ".Vencs"
1092:             .Column4.ControlSource = loc_cCursor + ".MoeFpgs"
1093:             .Column5.ControlSource = loc_cCursor + ".CotFpgs"
1094: 
1095:             *-- Fonte das colunas e do Text1 de cada celula
1096:             .Column1.FontName = "Courier New"
1097:             .Column2.FontName = "Courier New"
1098:             .Column3.FontName = "Courier New"
1099:             .Column4.FontName = "Courier New"
1100:             .Column5.FontName = "Courier New"
1101: 
1102:             *-- Mascaras de digitacao (Column2/Column5 no dump)
1103:             .Column2.InputMask = "999,999,999.99"
1104:             .Column5.InputMask = "999.9999"
1105: 
1106:             *-- Larguras DEPOIS do RecordSource (ele as reseta para o default)
1107:             .Column1.Width = 94
1108:             .Column2.Width = 108
1109:             .Column3.Width = 80
1110:             .Column4.Width = 33
1111:             .Column5.Width = 74
1112: 
1113:             *-- Ordem VISUAL das colunas: Cond.Pagto / Valor / Moe / Cotacao /
1114:             *-- Vencimento (Column3 por ultimo), igual ao SCX
1115:             .Column3.ColumnOrder = 5

*-- Linhas 1212 a 1379:
1212: 
1213:         *-- Celulas de Valor/Vencimento validam no PROPRIO Valid - regra #46:
1214:         *-- NUNCA em AfterRowColChange (nColIndex ali eh a coluna de DESTINO).
1215:         *-- BINDEVENT em Valid de TextBox de Column nao eh confiavel - por
1216:         *-- isso o Valid mora na CLASSE (TextBoxCelulaValorFpg/
1217:         *-- TextBoxCelulaVencFpg, declaradas no topo deste arquivo), nao em
1218:         *-- BINDEVENT. Guard PEMSTATUS: VincularGrade eh reexecutavel
1219:         *-- (CarregarDados chama de novo) e AddObject sobre objeto existente
1220:         *-- estoura "already exists".
1221:         WITH THIS.grd_4c_Dados
1222:             IF !PEMSTATUS(.Column2, "txt_4c_CelulaValor", 5)
1223:                 .Column2.AddObject("txt_4c_CelulaValor", "TextBoxCelulaValorFpg")
1224:             ENDIF
1225:             .Column2.txt_4c_CelulaValor.this_oForm = THIS
1226:             .Column2.CurrentControl                = "txt_4c_CelulaValor"
1227:             .Column2.Sparse                        = .F.
1228: 
1229:             IF !PEMSTATUS(.Column3, "txt_4c_CelulaVenc", 5)
1230:                 .Column3.AddObject("txt_4c_CelulaVenc", "TextBoxCelulaVencFpg")
1231:             ENDIF
1232:             .Column3.txt_4c_CelulaVenc.this_oForm = THIS
1233:             .Column3.CurrentControl                = "txt_4c_CelulaVenc"
1234:             .Column3.Sparse                        = .F.
1235: 
1236:             *-- Column.ReadOnly DEPOIS do CurrentControl, que tambem propaga
1237:             *-- (regra #18) - reaplica o estado de modo calculado acima.
1238:             .Column2.ReadOnly = !loc_lEditavel
1239:             .Column3.ReadOnly = !loc_lEditavel
1240:         ENDWITH
1241:     ENDPROC
1242: 
1243:     *--------------------------------------------------------------------------
1244:     * CarregarDados - FUNIL de carga/repintura da grade de formas de pagamento.
1245:     * Transcreve o `.refresh` do bloco With ThisForm.Grade e o `Select xPar /
1246:     * Go Top` com que o Init legado termina.
1247:     *
1248:     * Metodo UNICO chamado por TODO caminho que mexe nas linhas da grade: a
1249:     * montagem inicial (ConfigurarEstruturaBase), e nas fases de eventos o
1250:     * Apaga (Select xPar / Zap), o Valor.Valid e o fweditdata_Venc.Valid que
1251:     * gera as parcelas. Sem o GO TOP + Refresh a grade fica visualmente vazia
1252:     * com o cursor cheio e o sintoma parece falha de consulta (regra #21).
1253:     *
1254:     * Metodo PUBLIC: eh chamado de fora da classe pelo harness de teste
1255:     * automatico (regra #3) e pelos handlers das fases seguintes.
1256:     *
1257:     * RETURN unico, FORA do TRY/CATCH, com flag (regra #1).
1258:     *--------------------------------------------------------------------------
1259:     PROCEDURE CarregarDados()
1260:         LOCAL loc_lSucesso, loc_cCursor, loc_oErro
1261:         loc_lSucesso = .F.
1262:         loc_cCursor  = THIS.this_cCursorGrade
1263: 
1264:         TRY
1265:             *-- Garante cursor + vinculo: o rebind reaplica largura, fonte e
1266:             *-- caption, que o RecordSource reseta
1267:             THIS.VincularGrade()
1268: 
1269:             *-- `Select xPar / Go Top` do fim do Init legado
1270:             SELECT (loc_cCursor)
1271:             GO TOP
1272: 
1273:             *-- `.refresh` do bloco With ThisForm.Grade legado
1274:             THIS.grd_4c_Dados.Refresh()
1275: 
1276:             loc_lSucesso = .T.
1277:         CATCH TO loc_oErro
1278:             MsgErro(loc_oErro.Message + CHR(13) + ;
1279:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1280:                 "Procedure: " + loc_oErro.Procedure, ;
1281:                 "Erro ao carregar formas de pagamento")
1282:             loc_lSucesso = .F.
1283:         ENDTRY
1284: 
1285:         RETURN loc_lSucesso
1286:     ENDPROC
1287: 
1288:     *--------------------------------------------------------------------------
1289:     * AjustarBotoesPorModo - Ultima linha de botao do Init legado:
1290:     *   ThisForm.Apaga.Visible = Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' )
1291:     *
1292:     * Em CONSULTAR/EXCLUIR o legado ESCONDE o Apagar - so os modos de edicao
1293:     * podem zerar a distribuicao de formas de pagamento (o Apaga.Click legado
1294:     * repete a mesma guarda `If Inlist(...)`). Ok e Cancela nao tem regra de
1295:     * modo: o unico bloco que mexia neles por llAltDireta esta comentado
1296:     * (`*!*`) no SCX.
1297:     *
1298:     * Roda DEPOIS de TornarControlesVisiveis, que forca Visible=.T. em todos os
1299:     * controles criados por AddObject e apagaria esta regra.
1300:     *
1301:     * Metodo PUBLIC: chamado de fora da classe pelo harness de teste
1302:     * automatico (regra #3).
1303:     *--------------------------------------------------------------------------
1304:     PROCEDURE AjustarBotoesPorModo()
1305:         THIS.cmd_4c_Apaga.Visible = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), ;
1306:                                            "INSERIR", "ALTERAR")
1307:     ENDPROC
1308: 
1309:     *--------------------------------------------------------------------------
1310:     * OcultarCamposCondicionais - Reaplica o Visible = .F. dos controles que
1311:     * o dump do SCX ja nasce ocultos (Say_Cotacao/Get_COTACAO/alteracotacao -
1312:     * bloco de alteracao manual de cotacao; SayObs/GetObs - observacao livre,
1313:     * so aparece quando CrSigOpFp.Obs = 1). TornarControlesVisiveis forca
1314:     * Visible = .T. em TODO controle criado por AddObject, entao esses quatro
1315:     * tem de ser reescondidos DEPOIS dele - mesmo padrao de
1316:     * AjustarBotoesPorModo()/cmd_4c_Apaga.
1317:     *
1318:     * A alternancia real (mostrar quando o usuario clica "C$" ou quando o
1319:     * registro tem Obs = 1) esta em MostrarObservacao (Fase 7); aqui o estado
1320:     * INICIAL, igual ao SCX, eh preservado.
1321:     *--------------------------------------------------------------------------
1322:     PROTECTED PROCEDURE OcultarCamposCondicionais()
1323:         THIS.lbl_4c__Cotacao.Visible       = .F.
1324:         THIS.txt_4c_COTACAO.Visible        = .F.
1325:         THIS.cmd_4c_Alteracotacao.Visible  = .F.
1326:         THIS.lbl_4c_Obs.Visible            = .F.
1327:         THIS.obj_4c_GetObs.Visible         = .F.
1328:     ENDPROC
1329: 
1330:     *--------------------------------------------------------------------------
1331:     * ConfigurarBotoes - Botoes Apaga/Ok/Cancela (SIGOPFPG.Apaga/Ok/Cancela
1332:     * no legado). Adicionados DIRETO no form (sem container, igual ao dump),
1333:     * DEPOIS de ConfigurarCabecalho/ConfigurarDecoracao para desenhar por
1334:     * cima de cnt_4c_Sombra - Top=3 cai DENTRO da faixa (Top=0..80, regra
1335:     * #11 do CLAUDE.md). Picture/Caption/ToolTipText/Cancel transcritos do
1336:     * dump; Width/Height=75 com Lefts em incrementos de 75 (575/650/725),
1337:     * igual ao padrao canonico dos botoes CRUD do framework.
1338:     *--------------------------------------------------------------------------
1339:     PROTECTED PROCEDURE ConfigurarBotoes()
1340:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
1341:         WITH THIS.cmd_4c_Apaga
1342:             .Top             = 3
1343:             .Left            = 575
1344:             .Width           = 75
1345:             .Height          = 75
1346:             .Caption         = "Apagar"
1347:             .ToolTipText     = "Apagar"
1348:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1349:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1350:             .Themes          = .T.
1351:             .FontName        = "Comic Sans MS"
1352:             .FontBold        = .T.
1353:             .FontItalic      = .T.
1354:             .FontSize        = 8
1355:             .ForeColor       = RGB(90, 90, 90)
1356:             .BackColor       = RGB(255, 255, 255)
1357:             .SpecialEffect   = 0
1358:             .PicturePosition = 13
1359:             .MousePointer    = 15
1360:             .WordWrap        = .T.
1361:             .Visible         = .T.
1362:         ENDWITH
1363: 
1364:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
1365:         WITH THIS.cmd_4c_Ok
1366:             .Top             = 3
1367:             .Left            = 650
1368:             .Width           = 75
1369:             .Height          = 75
1370:             .Caption         = "\<Confirmar"
1371:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1372:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1373:             .Themes          = .T.
1374:             .FontName        = "Comic Sans MS"
1375:             .FontBold        = .T.
1376:             .FontItalic      = .T.
1377:             .FontSize        = 8
1378:             .ForeColor       = RGB(90, 90, 90)
1379:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 1416 a 1476:
1416:     * CntCarneFP (carne), CntOutrosFP (observacao livre) e CntChequeFP
1417:     * (dados do cheque). Todos nascem Visible=.F. - igual ao dump - e a
1418:     * alternancia real esta em MostrarObservacao/CartaoCredito. A que preserva
1419:     * esse Visible=.F. depois de TornarControlesVisiveis esta em
1420:     * TornarControlesVisiveis() (lista de nomes CNT_4C_*).
1421:     *
1422:     * Propriedades e posicoes (Top/Left/Width/Height, fontes, InputMask,
1423:     * ControlSource de xPar) transcritas do dump do SCX (SIGOPFPG.CntCCred /
1424:     * CntCCredFP / CntCarneFP / CntOutrosFP / CntChequeFP). ControlSource
1425:     * fica VAZIO aqui (igual as demais fases de puro layout) - o trafego com
1426:     * cursor_4c_Dados (equivalente a xPar) eh assunto da Fase 8.
1427:     *
1428:     * CntCCred e CntCCredFP tem os MESMOS dois campos (cartao/credito) -
1429:     * CntCCred eh o painel visivel ao usuario (mCartaoCred alterna Visible +
1430:     * desabilita o resto do form) e CntCCredFP eh o espelho que o legado
1431:     * mantem sempre presente para o SQL/replace de xPar (mLeDados/Ok.Click
1432:     * leem de CntCCredFP, nao de CntCCred - ver comportamento.json). Nomes
1433:     * de objeto distintos por painel (nunca reusar o mesmo AddObject em dois
1434:     * containers - regra de colisao de nomes).
1435:     *--------------------------------------------------------------------------
1436:     PROTECTED PROCEDURE ConfigurarPaineisFlutuantes()
1437: 
1438:         *-- CntCCred - cartao de credito (painel que o usuario VE) ----------
1439:         THIS.AddObject("cnt_4c_CCred", "Container")
1440:         WITH THIS.cnt_4c_CCred
1441:             .Top           = 216
1442:             .Left          = 304
1443:             .Width         = 400
1444:             .Height        = 74
1445:             .SpecialEffect = 0
1446:             .BackColor     = RGB(255, 255, 255)
1447:             .BorderColor   = RGB(36, 84, 155)
1448:             .TabIndex      = 12
1449:             .Visible       = .F.
1450:         ENDWITH
1451: 
1452:         THIS.cnt_4c_CCred.AddObject("lbl_4c_TituloCartao", "Label")
1453:         WITH THIS.cnt_4c_CCred.lbl_4c_TituloCartao
1454:             .FontName  = "Tahoma"
1455:             .FontSize  = 8
1456:             .FontBold  = .T.
1457:             .AutoSize  = .F.
1458:             .Alignment = 0
1459:             .BackStyle = 0
1460:             .Caption   = "Cart" + CHR(227) + "o Cr" + CHR(233) + "dito"
1461:             .Left      = 4
1462:             .Top       = 5
1463:             .Width     = 84
1464:             .Height    = 15
1465:             .ForeColor = RGB(90, 90, 90)
1466:             .Visible   = .T.
1467:         ENDWITH
1468: 
1469:         THIS.cnt_4c_CCred.AddObject("lbl_4c_LabelCartao", "Label")
1470:         WITH THIS.cnt_4c_CCred.lbl_4c_LabelCartao
1471:             .FontName  = "Tahoma"
1472:             .FontSize  = 8
1473:             .AutoSize  = .F.
1474:             .Alignment = 0
1475:             .BackStyle = 0
1476:             .Caption   = "Cart" + CHR(227) + "o : "

*-- Linhas 1886 a 1929:
1886:     *      else
1887:     *          If !IsEmpty( This.Value )
1888:     *              If !Seek( This.Value, 'csSigOpFp', 'FPagsGru' )
1889:     *                  loBrowse = CreateObject( 'fwBuscaSel', 'csSigOpFp', ...)
1890:     *                  loBrowse.AddColuna( 'FPags',  '',   'Codigo', .t., ... )
1891:     *                  loBrowse.AddColuna( 'FParcs', '99', 'Parc' )
1892:     *                  loBrowse.Show
1893:     *                  This.Value = Iif( Lastkey() == 27, '', csSigOpFp.FPags )
1894:     *              Endif
1895:     *              If !IsEmpty(This.Value)
1896:     *                  =Seek( This.Value, 'crSigOpFp', 'FPags' )
1897:     *                  ThisForm.Get_Fpg.Value      = CrSigOpFp.FPags
1898:     *                  ThisForm.Get_NPar.Value     = CrSigOpFp.FParcs
1899:     *                  ThisForm.Digpar             = IsEmpty( CrSigOpFp.FParcs )
1900:     *                  ThisForm.Get_PEncargo.Value = CrSigOpFp.Encargos
1901:     *                  ... (bloco de cotacao/cambio - Fase 8)
1902:     *              Else
1903:     *                  Thisform.get_npar.Value = 0
1904:     *              EndiF
1905:     *          Else
1906:     *              Thisform.get_npar.Value = 0
1907:     *          Endif
1908:     *      Endif
1909:     *
1910:     *  Dois universos DIFERENTES, transcritos como dois metodos:
1911:     *
1912:     *    csSigOpFp (existencia + browse) - `Select * From crSigOpFp Where
1913:     *      Inlist(crSigOpFp.Situas,"A"," ","R")` + indice FILTRADO
1914:     *      `Index On Fpags Tag FPagsGru For !IsEmpty(grupods) .and.
1915:     *      !IsEmpty(contads)` -> ObterFiltroFormasValidas() /
1916:     *      ExisteFormaPagamentoValida().
1917:     *    crSigOpFp (leitura do registro escolhido) - cursor SEM filtro
1918:     *      nenhum -> AplicarFormaPagamento(), que por isso NAO repete o
1919:     *      filtro do browse.
1920:     *
1921:     *  crSigOpFp eh um cursor GLOBAL do Fortyus que nao existe na arquitetura
1922:     *  nova (o startup legado o pre-carregava no login), por isso os dois
1923:     *  metodos consultam a tabela SigOpFp direto no SQL Server. O filtro
1924:     *  transcrito eh EXATAMENTE o do dump - SigOpFp tem coluna `emps`, mas o
1925:     *  legado NAO filtra por empresa aqui e inventar esse filtro esconderia
1926:     *  formas de pagamento validas.
1927:     *==========================================================================
1928: 
1929:     *--------------------------------------------------------------------------

*-- Linhas 1936 a 2210:
1936:     * "KeyPress" tambem eh ligado, mas o handler TESTA a tecla - ENTER confirma
1937:     * (equivale a sair do campo) e F4/F5 sao o atalho de busca direta.
1938:     *
1939:     * Os dois handlers sao PUBLIC: BINDEVENT ignora metodo PROTECTED em
1940:     * silencio (regra #3).
1941:     *--------------------------------------------------------------------------
1942:     PROTECTED PROCEDURE ConfigurarEventosLookup()
1943:         BINDEVENT(THIS.txt_4c_Fpg, "LostFocus", THIS, "TxtFpgLostFocus")
1944:         BINDEVENT(THIS.txt_4c_Fpg, "KeyPress",  THIS, "TxtFpgKeyPress")
1945: 
1946:         *-- FASE 8/8 - demais campos do cabecalho e dos paineis flutuantes.
1947:         *-- Todos em LostFocus (regra #47 - nunca BINDEVENT em Valid de
1948:         *-- TextBox); fweditdata_venc tambem em GotFocus (pre-preenchimento
1949:         *-- do When legado) e Get_bco idem (aviso da leitora serial).
1950:         BINDEVENT(THIS.txt_4c_Npar,             "LostFocus", THIS, "TxtNparLostFocus")
1951:         BINDEVENT(THIS.txt_4c_Vpar,             "LostFocus", THIS, "TxtVparLostFocus")
1952:         BINDEVENT(THIS.txt_4c_PEncargo,         "LostFocus", THIS, "TxtPEncargoLostFocus")
1953:         BINDEVENT(THIS.txt_4c_Porc,             "LostFocus", THIS, "TxtPorcLostFocus")
1954:         BINDEVENT(THIS.txt_4c_Fweditdata_venc,  "GotFocus",  THIS, "TxtFweditdataVencGotFocus")
1955:         BINDEVENT(THIS.txt_4c_Fweditdata_venc,  "LostFocus", THIS, "TxtFweditdataVencLostFocus")
1956: 
1957:         BINDEVENT(THIS.cnt_4c_CCred.txt_4c_Cartao,     "LostFocus", THIS, "TxtCartaoLostFocus")
1958:         BINDEVENT(THIS.cnt_4c_CCredFP.txt_4c_CartaoFp, "LostFocus", THIS, "TxtCartaoFpLostFocus")
1959:         BINDEVENT(THIS.cnt_4c_CCredFP.txt_4c_CredFp,   "LostFocus", THIS, "TxtCredFpLostFocus")
1960: 
1961:         BINDEVENT(THIS.cnt_4c_ChequeFP.txt_4c_Bco,   "GotFocus",  THIS, "TxtBcoGotFocus")
1962:         BINDEVENT(THIS.cnt_4c_ChequeFP.txt_4c_Bco,   "LostFocus", THIS, "TxtBcoLostFocus")
1963:         BINDEVENT(THIS.cnt_4c_ChequeFP.txt_4c_Age,   "LostFocus", THIS, "TxtAgeLostFocus")
1964:         BINDEVENT(THIS.cnt_4c_ChequeFP.txt_4c_Conta, "LostFocus", THIS, "TxtContaLostFocus")
1965:         BINDEVENT(THIS.cnt_4c_ChequeFP.txt_4c_Num,   "LostFocus", THIS, "TxtNumLostFocus")
1966:     ENDPROC
1967: 
1968:     *--------------------------------------------------------------------------
1969:     * TxtFpgKeyPress - Handler de KeyPress de txt_4c_Fpg. SEMPRE testa a tecla
1970:     * antes de agir (regra #47). ENTER delega ao FUNIL (que ja tem a guarda de
1971:     * reentrancia); F4/F5 chamam o picker direto, e por isso ligam/desligam a
1972:     * guarda em volta do proprio corpo no padrao save/restore - o funil pode
1973:     * estar em curso quando o usuario teclar F4 de dentro do dialogo.
1974:     *--------------------------------------------------------------------------
1975:     PROCEDURE TxtFpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1976:         LOCAL loc_lEmLookupAnt
1977: 
1978:         DO CASE
1979:         CASE par_nKeyCode = 115 OR par_nKeyCode = 116
1980:             *-- F4 / F5: atalho de busca direta do sistema novo
1981:             IF !THIS.this_lEmLookup
1982:                 loc_lEmLookupAnt    = THIS.this_lEmLookup
1983:                 THIS.this_lEmLookup = .T.
1984:                 THIS.AbrirLookupFpg()
1985:                 THIS.this_lEmLookup = loc_lEmLookupAnt
1986:             ENDIF
1987: 
1988:         CASE par_nKeyCode = 13
1989:             *-- ENTER: equivale a sair do campo (Valid do legado)
1990:             THIS.TxtFpgLostFocus()
1991:         ENDCASE
1992:     ENDPROC
1993: 
1994:     *--------------------------------------------------------------------------
1995:     * TxtFpgLostFocus - FUNIL do lookup. Wrapper FINO com a guarda de
1996:     * reentrancia: FormBuscaAuxiliar eh MODAL, o Show() tira o foco do campo e
1997:     * faz este mesmo LostFocus disparar de novo, empilhando um segundo picker.
1998:     *
1999:     * O corpo fica em TxtFpgLostFocusExec() justamente porque ele tem RETURN
2000:     * antecipado: liberar a flag "no fim do corpo" a deixaria TRAVADA ligada no
2001:     * primeiro RETURN e o lookup morreria pelo resto da vida do form (regra
2002:     * #47). O RETURN de guarda fica FORA do TRY (regra #1) e a flag eh liberada
2003:     * DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara.
2004:     *--------------------------------------------------------------------------
2005:     PROCEDURE TxtFpgLostFocus()
2006:         LOCAL loc_oErro
2007: 
2008:         IF THIS.this_lEmLookup
2009:             RETURN
2010:         ENDIF
2011: 
2012:         THIS.this_lEmLookup = .T.
2013: 
2014:         TRY
2015:             THIS.TxtFpgLostFocusExec()
2016:         CATCH TO loc_oErro
2017:             MsgErro(loc_oErro.Message + CHR(13) + ;
2018:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2019:                 "Procedure: " + loc_oErro.Procedure, ;
2020:                 "Erro na Forma de Pagamento")
2021:         ENDTRY
2022: 
2023:         THIS.this_lEmLookup = .F.
2024:     ENDPROC
2025: 
2026:     *--------------------------------------------------------------------------
2027:     * TxtFpgLostFocusExec - Corpo do Valid legado de Get_fpg.
2028:     *--------------------------------------------------------------------------
2029:     PROTECTED PROCEDURE TxtFpgLostFocusExec()
2030:         LOCAL loc_cValor
2031: 
2032:         *-- Legado: `if lastkey()=9 / keyboard "{CTRL+TAB}" / else ...`. TAB
2033:         *-- NAO dispara o lookup no legado - desvia para a navegacao entre
2034:         *-- containers. O `keyboard "{CTRL+TAB}"` era troca de pagina de
2035:         *-- PageFrame e este dialogo nao tem PageFrame, por isso so o DESVIO
2036:         *-- (nao abrir o lookup) eh transcrito.
2037:         IF LASTKEY() = 9
2038:             RETURN
2039:         ENDIF
2040: 
2041:         loc_cValor = ALLTRIM(THIS.txt_4c_Fpg.Value)
2042: 
2043:         IF EMPTY(loc_cValor)
2044:             *-- Legado (ramo Else de `If !IsEmpty(This.Value)`):
2045:             *-- Thisform.get_npar.Value = 0
2046:             THIS.LimparFormaPagamento()
2047:             RETURN
2048:         ENDIF
2049: 
2050:         *-- Legado: `If !Seek(This.Value,'csSigOpFp','FPagsGru')` -> browse
2051:         THIS.this_cMensagemErro = ""
2052: 
2053:         IF THIS.ExisteFormaPagamentoValida(loc_cValor)
2054:             THIS.AplicarFormaPagamento(loc_cValor)
2055:         ELSE
2056:             *-- Codigo digitado nao esta no universo do browse. O legado NAO
2057:             *-- avisa e NAO apaga o que foi digitado: ele abre o picker, que
2058:             *-- JA eh o feedback e usa o digitado como prefixo (regra #50).
2059:             *-- Com erro de consulta ja reportado, nao abre o picker para nao
2060:             *-- exibir a mesma falha duas vezes.
2061:             IF EMPTY(THIS.this_cMensagemErro)
2062:                 THIS.AbrirLookupFpg()
2063:             ENDIF
2064:         ENDIF
2065:     ENDPROC
2066: 
2067:     *--------------------------------------------------------------------------
2068:     * AbrirLookupFpg - Browse de formas de pagamento (fwBuscaSel do legado
2069:     * sobre csSigOpFp). Metodo PUBLIC: eh o atalho de F4/F5 e o ponto de
2070:     * entrada do funil.
2071:     *
2072:     * Contrato do FormBuscaAuxiliar (regra #37): o Init JA tenta o match exato
2073:     * e, achando 1 registro, marca this_lAchouRegistro - nesse caso o dialogo
2074:     * NAO eh mostrado (abrir por cima do campo ja resolvido obrigaria o
2075:     * usuario a dispensar um picker de uma linha).
2076:     *
2077:     * A selecao eh lida por Mostrar()/cCodigoSelecionado e NAO pelo cursor:
2078:     * este form tem DataSession = 2 (privada) e o FormBuscaAuxiliar roda na
2079:     * datasession DEFAULT, entao o cursor que ele popula nao eh visivel daqui.
2080:     * Mostrar() faz a leitura DENTRO da datasession do picker, por isso
2081:     * this_cCampoCodigo/this_cCampoDescricao sao preenchidos antes do Show.
2082:     *--------------------------------------------------------------------------
2083:     PROCEDURE AbrirLookupFpg()
2084:         LOCAL loc_cValor, loc_oBusca, loc_cCodigo, loc_lPickerMostrado, loc_oErro
2085: 
2086:         loc_cValor          = ALLTRIM(THIS.txt_4c_Fpg.Value)
2087:         loc_cCodigo         = ""
2088:         loc_lPickerMostrado = .F.
2089: 
2090:         TRY
2091:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2092:                 "SigOpFp", ;
2093:                 "cursor_4c_BuscaFpg", ;
2094:                 "fpags", ;
2095:                 loc_cValor, ;
2096:                 "Cadastro de Forma de Pagamento", ;
2097:                 .F., ;
2098:                 .T., ;
2099:                 THIS.ObterFiltroFormasValidas())
2100: 
2101:             IF VARTYPE(loc_oBusca) = "O"
2102:                 loc_oBusca.this_cCampoCodigo    = "fpags"
2103:                 loc_oBusca.this_cCampoDescricao = "descrs"
2104: 
2105:                 IF loc_oBusca.this_lAchouRegistro
2106:                     *-- Match exato resolvido pelo proprio Init (regra #37):
2107:                     *-- nao mostra o dialogo. O codigo real (com o case e o
2108:                     *-- padding gravados na tabela) vem do
2109:                     *-- AplicarFormaPagamento, que releia o registro.
2110:                     loc_cCodigo = loc_cValor
2111:                 ELSE
2112:                     *-- Colunas do browse legado: AddColuna('FPags','','Codigo')
2113:                     *-- + AddColuna('FParcs','99','Parc'). A descricao entra
2114:                     *-- porque o Mostrar() do FormBuscaAuxiliar precisa do
2115:                     *-- campo de descricao vinculado a uma coluna do grid.
2116:                     loc_oBusca.this_nColunas = 0
2117:                     loc_oBusca.mAddColuna("fpags",  "",   "C" + CHR(243) + "digo")
2118:                     loc_oBusca.mAddColuna("fparcs", "99", "Parc")
2119:                     loc_oBusca.mAddColuna("descrs", "",   "Descri" + CHR(231) + CHR(227) + "o")
2120: 
2121:                     loc_lPickerMostrado = .T.
2122: 
2123:                     IF loc_oBusca.Mostrar()
2124:                         loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2125:                     ENDIF
2126:                 ENDIF
2127: 
2128:                 loc_oBusca.Release()
2129:             ENDIF
2130:         CATCH TO loc_oErro
2131:             MsgErro(loc_oErro.Message + CHR(13) + ;
2132:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2133:                 "Procedure: " + loc_oErro.Procedure, ;
2134:                 "Erro ao abrir a busca de Forma de Pagamento")
2135:         ENDTRY
2136: 
2137:         *-- Cursor do picker: fica na datasession dele e morre com o Release.
2138:         *-- O fechamento aqui so age se, por configuracao de datasession, o
2139:         *-- alias estiver visivel nesta sessao - e eh inofensivo se nao.
2140:         IF USED("cursor_4c_BuscaFpg")
2141:             IF CURSORGETPROP("Buffering", "cursor_4c_BuscaFpg") > 1
2142:                 TABLEREVERT(.T., "cursor_4c_BuscaFpg")
2143:             ENDIF
2144:             USE IN SELECT("cursor_4c_BuscaFpg")
2145:         ENDIF
2146: 
2147:         IF !EMPTY(loc_cCodigo)
2148:             THIS.AplicarFormaPagamento(loc_cCodigo)
2149:         ELSE
2150:             IF loc_lPickerMostrado
2151:                 *-- Legado: This.Value = Iif( Lastkey() == 27, '', ... ) - o
2152:                 *-- CANCELAMENTO EXPLICITO do browse limpa o campo (unico caso
2153:                 *-- em que o legado apaga o digitado - regra #50). Quando o
2154:                 *-- picker nem chegou a ser mostrado (erro de consulta), o que
2155:                 *-- o usuario digitou eh PRESERVADO.
2156:                 THIS.LimparFormaPagamento()
2157:             ENDIF
2158:         ENDIF
2159:     ENDPROC
2160: 
2161:     *--------------------------------------------------------------------------
2162:     * ObterFiltroFormasValidas - Fragmento WHERE que reproduz o universo do
2163:     * browse legado (csSigOpFp): `Inlist(crSigOpFp.Situas,"A"," ","R")` do
2164:     * SELECT mais o indice FILTRADO `For !IsEmpty(grupods) .and.
2165:     * !IsEmpty(contads)`, que no legado restringe o que o Seek/browse alcanca.
2166:     *
2167:     * FONTE UNICA do filtro: ExisteFormaPagamentoValida e AbrirLookupFpg leem
2168:     * daqui para o universo do teste de existencia e o do browse nunca
2169:     * divergirem (digitar um codigo que o browse nao lista, ou vice-versa).
2170:     * Sem prefixo de alias - o FormBuscaAuxiliar concatena este fragmento num
2171:     * SELECT sobre SigOpFp sem alias.
2172:     *--------------------------------------------------------------------------
2173:     FUNCTION ObterFiltroFormasValidas()
2174:         RETURN "situas IN ('A', ' ', 'R')" + ;
2175:                " AND RTRIM(grupods) <> ''" + ;
2176:                " AND RTRIM(contads) <> ''"
2177:     ENDFUNC
2178: 
2179:     *--------------------------------------------------------------------------
2180:     * ExisteFormaPagamentoValida - Equivalente a
2181:     * `Seek( This.Value, 'csSigOpFp', 'FPagsGru' )`: diz se o codigo digitado
2182:     * esta no universo do browse. NAO aplica nada - quem le o registro eh
2183:     * AplicarFormaPagamento, sobre o cursor SEM filtro (crSigOpFp).
2184:     *
2185:     * Falha de consulta deixa a mensagem em this_cMensagemErro para o chamador
2186:     * nao abrir o picker em seguida e repetir o mesmo erro.
2187:     *--------------------------------------------------------------------------
2188:     FUNCTION ExisteFormaPagamentoValida(par_cCodigo)
2189:         LOCAL loc_cSQL, loc_nResultado, loc_lExiste, loc_oErro
2190: 
2191:         loc_lExiste = .F.
2192: 
2193:         IF VARTYPE(par_cCodigo) != "C"
2194:             RETURN .F.
2195:         ENDIF
2196: 
2197:         IF EMPTY(ALLTRIM(par_cCodigo))
2198:             RETURN .F.
2199:         ENDIF
2200: 
2201:         TRY
2202:             IF USED("cursor_4c_ChkFpg")
2203:                 IF CURSORGETPROP("Buffering", "cursor_4c_ChkFpg") > 1
2204:                     TABLEREVERT(.T., "cursor_4c_ChkFpg")
2205:                 ENDIF
2206:                 USE IN SELECT("cursor_4c_ChkFpg")
2207:             ENDIF
2208: 
2209:             loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigOpFp" + ;
2210:                        " WHERE RTRIM(fpags) = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;

*-- Linhas 2228 a 2271:
2228:             THIS.this_cMensagemErro = loc_oErro.Message
2229:             MsgErro(loc_oErro.Message + CHR(13) + ;
2230:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2231:                 "Procedure: " + loc_oErro.Procedure, ;
2232:                 "Erro ao consultar Forma de Pagamento")
2233:         ENDTRY
2234: 
2235:         IF USED("cursor_4c_ChkFpg")
2236:             USE IN SELECT("cursor_4c_ChkFpg")
2237:         ENDIF
2238: 
2239:         RETURN loc_lExiste
2240:     ENDFUNC
2241: 
2242:     *--------------------------------------------------------------------------
2243:     * AplicarFormaPagamento - Transcricao do bloco que o Valid legado executa
2244:     * depois de resolver o codigo:
2245:     *
2246:     *     =Seek( This.Value, 'crSigOpFp', 'FPags' )
2247:     *     ThisForm.Get_Fpg.Value      = CrSigOpFp.FPags
2248:     *     ThisForm.Get_NPar.Value     = CrSigOpFp.FParcs
2249:     *     ThisForm.Digpar             = IsEmpty( CrSigOpFp.FParcs )
2250:     *     ThisForm.Get_PEncargo.Value = CrSigOpFp.Encargos
2251:     *
2252:     * crSigOpFp eh o cursor SEM filtro, por isso a consulta aqui NAO repete o
2253:     * filtro do browse: uma forma de pagamento alcancada por outro caminho
2254:     * continua sendo lida, igual ao legado.
2255:     *
2256:     * O bloco de cotacao/cambio que vem a seguir no Valid legado
2257:     * (Get_Cotacao/Say_Cotacao/AlteraCotacao + fCarregarCambio) depende de
2258:     * crSigCdMoe/crUsuario/crSigCdCrg e do calculo de cambio, e eh entregue na
2259:     * Fase 8 junto com o calculo de parcelas - esta fase entrega o
2260:     * lookup e os campos que ele resolve diretamente.
2261:     *
2262:     * Retorna .T. quando o registro foi encontrado e aplicado.
2263:     *--------------------------------------------------------------------------
2264:     FUNCTION AplicarFormaPagamento(par_cCodigo)
2265:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nParcelas, loc_oErro, ;
2266:             loc_lMoedaCotas, loc_lCargoAltCots, loc_lCota, loc_nCotOper, loc_nCotacao
2267: 
2268:         loc_lSucesso = .F.
2269: 
2270:         IF VARTYPE(par_cCodigo) != "C"
2271:             RETURN .F.

*-- Linhas 2376 a 2517:
2376:             THIS.this_cMensagemErro = loc_oErro.Message
2377:             MsgErro(loc_oErro.Message + CHR(13) + ;
2378:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2379:                 "Procedure: " + loc_oErro.Procedure, ;
2380:                 "Erro ao carregar Forma de Pagamento")
2381:         ENDTRY
2382: 
2383:         IF USED("cursor_4c_FpgSel")
2384:             USE IN SELECT("cursor_4c_FpgSel")
2385:         ENDIF
2386: 
2387:         RETURN loc_lSucesso
2388:     ENDFUNC
2389: 
2390:     *--------------------------------------------------------------------------
2391:     * LimparFormaPagamento - Estado "sem forma de pagamento escolhida".
2392:     * Legado: `Thisform.get_npar.Value = 0` nos dois ramos Else do Valid, e
2393:     * `This.Value = ''` quando o browse eh cancelado com ESC. Metodo UNICO
2394:     * para os tres caminhos nao divergirem.
2395:     *--------------------------------------------------------------------------
2396:     PROTECTED PROCEDURE LimparFormaPagamento()
2397:         THIS.txt_4c_Fpg.Value  = ""
2398:         THIS.txt_4c_Npar.Value = 0
2399:         THIS.this_lDigpar      = .F.
2400: 
2401:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2402:             THIS.this_oBusinessObject.this_cFPags  = ""
2403:             THIS.this_oBusinessObject.this_nNPar   = 0
2404:             THIS.this_oBusinessObject.this_lDigpar = .F.
2405:         ENDIF
2406: 
2407:         THIS.AtualizarCamposPorFormaPagamento()
2408:         THIS.Refresh()
2409:     ENDPROC
2410: 
2411:     *--------------------------------------------------------------------------
2412:     * ConfigurarEventosBotoes (FASE 7/8) - Liga o Click dos cinco botoes do
2413:     * dialogo aos handlers desta fase. Chamado no fim de
2414:     * ConfigurarEstruturaBase, DEPOIS de ConfigurarBotoes (que cria Apaga/Ok/
2415:     * Cancela), de ConfigurarCampos (cmd_4c_Alteracotacao) e de
2416:     * ConfigurarPaineisFlutuantes (cmd_4c_Confirma, filho de cnt_4c_CCred):
2417:     * BINDEVENT exige o objeto JA criado.
2418:     *
2419:     * Equivalencia com o legado, um para um:
2420:     *   SIGOPFPG.Apaga.Click             -> CmdApagaClick
2421:     *   SIGOPFPG.Ok.Click                -> CmdOkClick
2422:     *   SIGOPFPG.Cancela.Click           -> CmdCancelaClick
2423:     *   SIGOPFPG.alteracotacao.Click     -> CmdAlteraCotacaoClick
2424:     *   SIGOPFPG.CntCCred.Confirma.Click -> CmdConfirmaCartaoClick
2425:     *
2426:     * Os cinco handlers sao PUBLIC (sem PROTECTED): BINDEVENT so funciona com
2427:     * metodo PUBLIC - em metodo PROTECTED o bind falha em SILENCIO e o botao
2428:     * nao faz nada (regra #3).
2429:     *--------------------------------------------------------------------------
2430:     PROTECTED PROCEDURE ConfigurarEventosBotoes()
2431:         BINDEVENT(THIS.cmd_4c_Apaga,         "Click", THIS, "CmdApagaClick")
2432:         BINDEVENT(THIS.cmd_4c_Ok,            "Click", THIS, "CmdOkClick")
2433:         BINDEVENT(THIS.cmd_4c_Cancela,       "Click", THIS, "CmdCancelaClick")
2434:         BINDEVENT(THIS.cmd_4c_Alteracotacao, "Click", THIS, "CmdAlteraCotacaoClick")
2435: 
2436:         BINDEVENT(THIS.cnt_4c_CCred.cmd_4c_Confirma, "Click", THIS, ;
2437:                   "CmdConfirmaCartaoClick")
2438:     ENDPROC
2439: 
2440:     *--------------------------------------------------------------------------
2441:     * CmdApagaClick - SIGOPFPG.Apaga.Click do legado:
2442:     *
2443:     *     If Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' )
2444:     *         Select xPar
2445:     *         Zap
2446:     *         With Thisform
2447:     *             .Get_TotForma.Value = 0
2448:     *             .Get_Fpg.Value = ''
2449:     *             .Get_NPar.Value = 0
2450:     *             .Get_VPar.Value = 0
2451:     *             .fweditdata_Venc.Value = {}
2452:     *             .Get_PEncargo.Value = 0
2453:     *             .Get_VEncargo.Value = 0
2454:     *             .Get_Cotacao.Value = 0
2455:     *         Endwith
2456:     *         ThisForm.MostraObs
2457:     *         ThisForm.Refresh
2458:     *         ThisForm.Grade.Refresh
2459:     *         ThisForm.Get_Fpg.SetFocus
2460:     *     Endif
2461:     *
2462:     * A guarda de modo eh a MESMA que AjustarBotoesPorModo usa para esconder o
2463:     * botao, e eh repetida aqui de proposito - o legado tambem a repete, porque
2464:     * ela vale para a ACAO e nao so para o visual (o modo do form pai pode ter
2465:     * mudado entre a abertura do dialogo e o clique).
2466:     *
2467:     * ZAP, nao USE IN + CREATE CURSOR: o ZAP apaga as linhas PRESERVANDO a
2468:     * estrutura e, com ela, o RecordSource/ControlSource da grade - fechar e
2469:     * recriar o alias deixaria a grade permanentemente vazia, sem erro e sem
2470:     * log. E SET SAFETY eh ESCOPADO POR DATA SESSION: dentro da sessao privada
2471:     * deste form (DataSession = 2) ele vale ON mesmo com o SET SAFETY OFF do
2472:     * main.prg, e sem desligar aqui o ZAP abre o dialogo "Zap ... Are you
2473:     * sure?" e CONGELA a tela (medido no VFP9).
2474:     *
2475:     * RETURN de guarda FORA do TRY (regra #1) e flag unica para o retorno.
2476:     *--------------------------------------------------------------------------
2477:     PROCEDURE CmdApagaClick()
2478:         LOCAL loc_cCursor, loc_cSafety, loc_lSucesso, loc_oErro
2479: 
2480:         *-- Guarda de modo do proprio Click legado
2481:         IF !INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
2482:             RETURN .F.
2483:         ENDIF
2484: 
2485:         loc_cCursor  = THIS.this_cCursorGrade
2486:         loc_lSucesso = .F.
2487: 
2488:         TRY
2489:             THIS.GarantirCursorDados()
2490: 
2491:             *-- `Select xPar / Zap`
2492:             SELECT (loc_cCursor)
2493:             loc_cSafety = SET("SAFETY")
2494:             SET SAFETY OFF
2495:             ZAP
2496:             IF loc_cSafety = "ON"
2497:                 SET SAFETY ON
2498:             ENDIF
2499: 
2500:             *-- Bloco `With Thisform ... EndWith`
2501:             THIS.txt_4c_TotForma.Value        = 0
2502:             THIS.txt_4c_Vpar.Value            = 0
2503:             THIS.txt_4c_Fweditdata_venc.Value = {}
2504:             THIS.txt_4c_PEncargo.Value        = 0
2505:             THIS.txt_4c_VEncargo.Value        = 0
2506:             THIS.txt_4c_COTACAO.Value         = 0
2507: 
2508:             *-- `.Get_Fpg.Value = '' / .Get_NPar.Value = 0` pelo metodo que ja
2509:             *-- eh fonte unica desse estado (ele tambem zera this_lDigpar, que
2510:             *-- sem forma escolhida nao tem efeito nenhum: o When de Get_npar
2511:             *-- exige !IsEmpty(Get_fpg.Value) antes de olhar o Digpar)
2512:             THIS.LimparFormaPagamento()
2513: 
2514:             *-- Espelho no BO dos campos que o bloco acima zerou, para Form e
2515:             *-- BO nao divergirem depois do Apagar
2516:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2517:                 THIS.this_oBusinessObject.this_nTotForma = 0

*-- Linhas 2547 a 2865:
2547:             THIS.this_cMensagemErro = loc_oErro.Message
2548:             MsgErro(loc_oErro.Message + CHR(13) + ;
2549:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2550:                 "Procedure: " + loc_oErro.Procedure, ;
2551:                 "Erro ao apagar as formas de pagamento")
2552:             loc_lSucesso = .F.
2553:         ENDTRY
2554: 
2555:         RETURN loc_lSucesso
2556:     ENDPROC
2557: 
2558:     *--------------------------------------------------------------------------
2559:     * CmdOkClick - SIGOPFPG.Ok.Click do legado:
2560:     *
2561:     *     If Inlist( Thisform.op_escolha, 'INSERIR', 'ALTERAR' )
2562:     *         ** verifica se existe valor ou vencs em branco
2563:     *         Select xPar
2564:     *         Scan
2565:     *             If !IsEmpty(xPar.FPags) And IsEmpty(xPar.vencs)
2566:     *                 Messagebox( 'Vencimento Invalido !', 48, '' )
2567:     *                 Thisform.Grade.Venc.Setfocus
2568:     *                 Return 0
2569:     *             Endif
2570:     *         Endscan
2571:     *     Endif
2572:     *     ThisForm.Return
2573:     *
2574:     * A validacao SO roda em INSERIR/ALTERAR - em CONSULTAR/EXCLUIR o legado
2575:     * fecha direto, porque nada foi digitado.
2576:     *
2577:     * O `Return 0` do legado aborta o clique: o dialogo NAO fecha e o foco vai
2578:     * para a coluna Vencimento, que aqui eh a Column3 da grade (ControlSource
2579:     * <cursor>.Vencs - a ordem VISUAL dela eh a 5a, mas o objeto eh Column3).
2580:     * Por isso o registro corrente NAO eh restaurado quando a validacao recusa:
2581:     * o SCAN para na linha ofensora e eh exatamente essa linha que o usuario
2582:     * tem de corrigir. Passando a validacao, o registro de antes eh devolvido
2583:     * (o SCAN termina em EOF).
2584:     *
2585:     * O fechamento (`ThisForm.Return`) fica FORA do TRY: ele esconde o form, e
2586:     * dentro do bloco um erro posterior saltaria para o CATCH com o dialogo ja
2587:     * fechado (regra #29).
2588:     *--------------------------------------------------------------------------
2589:     PROCEDURE CmdOkClick()
2590:         LOCAL loc_cCursor, loc_nRecno, loc_lVencOk, loc_lFechar, loc_oErro
2591: 
2592:         loc_cCursor = THIS.this_cCursorGrade
2593:         loc_lVencOk = .T.
2594:         loc_lFechar = .F.
2595: 
2596:         TRY
2597:             IF INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
2598:                 IF USED(loc_cCursor)
2599:                     loc_nRecno = 0
2600:                     IF RECCOUNT(loc_cCursor) > 0
2601:                         loc_nRecno = RECNO(loc_cCursor)
2602:                     ENDIF
2603: 
2604:                     SELECT (loc_cCursor)
2605:                     SCAN
2606:                         IF !EMPTY(EVALUATE(loc_cCursor + ".FPags")) AND ;
2607:                                 EMPTY(EVALUATE(loc_cCursor + ".Vencs"))
2608:                             loc_lVencOk = .F.
2609:                             EXIT
2610:                         ENDIF
2611:                     ENDSCAN
2612: 
2613:                     IF loc_lVencOk AND loc_nRecno > 0 AND ;
2614:                             loc_nRecno <= RECCOUNT(loc_cCursor)
2615:                         GO (loc_nRecno) IN (loc_cCursor)
2616:                     ENDIF
2617:                 ENDIF
2618:             ENDIF
2619: 
2620:             IF loc_lVencOk
2621:                 loc_lFechar = .T.
2622:             ELSE
2623:                 *-- `Messagebox( 'Vencimento Invalido !', 48, '' )` - icone 48
2624:                 *-- eh aviso de validacao, logo MsgAviso (nao MsgErro)
2625:                 MsgAviso("Vencimento Inv" + CHR(225) + "lido !")
2626: 
2627:                 *-- `Thisform.Grade.Venc.Setfocus`
2628:                 THIS.grd_4c_Dados.Refresh()
2629: 
2630:                 IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled ;
2631:                         AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
2632:                     THIS.grd_4c_Dados.Column3.SetFocus()
2633:                 ENDIF
2634:             ENDIF
2635:         CATCH TO loc_oErro
2636:             THIS.this_cMensagemErro = loc_oErro.Message
2637:             MsgErro(loc_oErro.Message + CHR(13) + ;
2638:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2639:                 "Procedure: " + loc_oErro.Procedure, ;
2640:                 "Erro ao confirmar as formas de pagamento")
2641:             loc_lFechar = .F.
2642:         ENDTRY
2643: 
2644:         *-- `ThisForm.Return`, fora do TRY
2645:         IF loc_lFechar
2646:             THIS.this_lConfirmado = .T.
2647:             THIS.FecharDialogo()
2648:         ENDIF
2649: 
2650:         RETURN loc_lFechar
2651:     ENDPROC
2652: 
2653:     *--------------------------------------------------------------------------
2654:     * CmdCancelaClick - SIGOPFPG.Cancela.Click do legado:
2655:     *
2656:     *     Thisform.parentform.enabled = .T.
2657:     *     Thisform.release
2658:     *
2659:     * Que eh exatamente o corpo do `PROCEDURE return` do legado - os dois
2660:     * caminhos de saida (Confirmar e Cancelar) passam pelo MESMO FecharDialogo,
2661:     * para a decisao de COMO fechar ficar num lugar so. A diferenca entre eles
2662:     * eh this_lConfirmado, que diz ao form pai se o usuario confirmou a
2663:     * distribuicao das formas de pagamento ou desistiu dela.
2664:     *--------------------------------------------------------------------------
2665:     PROCEDURE CmdCancelaClick()
2666:         THIS.this_lConfirmado = .F.
2667:         THIS.FecharDialogo()
2668: 
2669:         RETURN .T.
2670:     ENDPROC
2671: 
2672:     *--------------------------------------------------------------------------
2673:     * CmdConfirmaCartaoClick - SIGOPFPG.CntCCred.Confirma.Click do legado:
2674:     *
2675:     *     ThisForm.mCartaoCred( .F. )
2676:     *     ThisForm.Grade.Valor.Text1.SetFocus
2677:     *
2678:     * Fecha o painel de cartao de credito - que roda "modal sobre o form":
2679:     * enquanto esta aberto, todo o resto do dialogo fica Enabled = .F. - e
2680:     * devolve o foco a celula Valor da grade, que aqui eh a Column2
2681:     * (ControlSource <cursor>.Valos).
2682:     *--------------------------------------------------------------------------
2683:     PROCEDURE CmdConfirmaCartaoClick()
2684:         LOCAL loc_cCursor, loc_lSucesso, loc_oErro
2685: 
2686:         loc_cCursor  = THIS.this_cCursorGrade
2687:         loc_lSucesso = .F.
2688: 
2689:         TRY
2690:             *-- O painel CntCCredFP (sempre oculto ao usuario) eh o espelho que
2691:             *-- fweditdata_venc.Valid le para gravar Cartaos/Nocreditos na
2692:             *-- parcela (regra: CntCCred eh o que o usuario digita, CntCCredFP
2693:             *-- eh a copia que o gerador de parcelas consome - mesmo padrao do
2694:             *-- par Get_PVenda/Get_PVen do FormProduto, memoria
2695:             *-- "ParCtrlSrccompa"). Copiar ANTES de ocultar o painel - SO com
2696:             *-- linha corrente no cursor, pois os dois campos sao
2697:             *-- ControlSource da linha (sem registro, a atribuicao estoura).
2698:             IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0 AND !EOF(loc_cCursor)
2699:                 THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Value = THIS.cnt_4c_CCred.txt_4c_Cartao.Value
2700:                 THIS.cnt_4c_CCredFP.txt_4c_CredFp.Value   = THIS.cnt_4c_CCred.txt_4c_Cred.Value
2701:             ENDIF
2702: 
2703:             *-- `ThisForm.mCartaoCred( .F. )`
2704:             THIS.CartaoCredito(.F.)
2705: 
2706:             *-- `ThisForm.Grade.Valor.Text1.SetFocus`. Sem linha na grade nao
2707:             *-- ha celula para receber o foco, e SetFocus ali dispara erro
2708:             IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled ;
2709:                     AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
2710:                 THIS.grd_4c_Dados.Column2.SetFocus()
2711:             ENDIF
2712: 
2713:             loc_lSucesso = .T.
2714:         CATCH TO loc_oErro
2715:             THIS.this_cMensagemErro = loc_oErro.Message
2716:             MsgErro(loc_oErro.Message + CHR(13) + ;
2717:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2718:                 "Procedure: " + loc_oErro.Procedure, ;
2719:                 "Erro ao confirmar o cart" + CHR(227) + "o de cr" + CHR(233) + "dito")
2720:             loc_lSucesso = .F.
2721:         ENDTRY
2722: 
2723:         RETURN loc_lSucesso
2724:     ENDPROC
2725: 
2726:     *--------------------------------------------------------------------------
2727:     * CmdAlteraCotacaoClick - SIGOPFPG.alteracotacao.Click do legado:
2728:     *
2729:     *     With ThisForm
2730:     *         .Get_VPar.Value = 0
2731:     *         .Get_Cotacao.peantvalue = .Get_Cotacao.Value
2732:     *         Do Form SigOpAlC With CrSigOpFp.Moefpgs, .Get_Cotacao.Value, ;
2733:     *             crSigChLcq.DtEnts to lcRetorno
2734:     *         If MLine( lcRetorno, 1 ) = 'OK'
2735:     *             .Get_Cotacao.Value = Val( MLine( lcRetorno, 2 ) )
2736:     *             .CotUsu = MLine( lcRetorno, 3 )
2737:     *         Else
2738:     *             .Get_Cotacao.Value = .Get_Cotacao.peantvalue
2739:     *             .CotUsu = ''
2740:     *         Endif
2741:     *         .Get_VPar.SetFocus
2742:     *     Endwith
2743:     *
2744:     * `peantvalue` eh property da classe fwget do Framework legado (valor
2745:     * anterior do campo); aqui ela vira this_nCotacaoAnterior - TextBox do VFP9
2746:     * nao tem peantvalue, e atribuir estouraria "Property PEANTVALUE is not
2747:     * found" (regra #33).
2748:     *
2749:     * `Do Form ... to lcRetorno` nao abre dialogo no sistema novo: a abertura
2750:     * canonica eh CREATEOBJECT + Show(), e o retorno eh lido da property
2751:     * this_cRetorno do FormSigOpAlC ("OK" + CHR(13) + cotacao + CHR(13) +
2752:     * usuario, ou "CANCELADO"). A referencia ao BO do dialogo eh guardada ANTES
2753:     * do Show porque o FormSigOpAlC fecha com Release(), que destroi o objeto
2754:     * mesmo havendo variavel externa apontando para ele: sem esse segundo
2755:     * canal, o resultado da autorizacao ficaria inalcancavel e a cotacao nao
2756:     * mudaria, sem erro nenhum. Show() FORA do TRY (regra #29) - o dialogo eh
2757:     * modal, entao o uso inteiro dele viveria dentro do bloco.
2758:     *
2759:     * A moeda e a data vem de onde o legado as le: `CrSigOpFp.Moefpgs` eh a
2760:     * moeda da forma de pagamento escolhida (guardada em this_cMoedas por
2761:     * AplicarFormaPagamento) e `crSigChLcq.DtEnts` eh a data de entrada do
2762:     * titulo, informada pelo form pai (this_dDtEnts).
2763:     *
2764:     * O guard eh o When do proprio botao (PodeAlterarCotacao): ele vale para a
2765:     * ACAO, nao so para o visual.
2766:     *--------------------------------------------------------------------------
2767:     PROCEDURE CmdAlteraCotacaoClick()
2768:         LOCAL loc_cMoeda, loc_nCotacao, loc_dData, loc_cRetorno
2769:         LOCAL loc_oDialogo, loc_oDialogoBO, loc_lAbrir, loc_oErro
2770: 
2771:         *-- When do botao, FORA do TRY (regra #1)
2772:         IF !THIS.PodeAlterarCotacao()
2773:             RETURN .F.
2774:         ENDIF
2775: 
2776:         loc_cRetorno   = ""
2777:         loc_oDialogo   = .NULL.
2778:         loc_oDialogoBO = .NULL.
2779:         loc_lAbrir     = .F.
2780:         loc_cMoeda     = ""
2781:         loc_dData      = {}
2782: 
2783:         *-- `.Get_VPar.Value = 0` e
2784:         *-- `.Get_Cotacao.peantvalue = .Get_Cotacao.Value`
2785:         THIS.txt_4c_Vpar.Value     = 0
2786:         THIS.this_nCotacaoAnterior = THIS.txt_4c_COTACAO.Value
2787: 
2788:         loc_nCotacao = THIS.txt_4c_COTACAO.Value
2789: 
2790:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2791:             THIS.this_oBusinessObject.this_nVPar = 0
2792: 
2793:             loc_cMoeda = ALLTRIM(THIS.this_oBusinessObject.this_cMoedas)
2794: 
2795:             *-- ConverterParaData normaliza DATE/DATETIME/CHAR: a data de
2796:             *-- entrada chega do form pai e pode vir datetime (coluna
2797:             *-- SigChLcq.DtEnts); TTOD com DATE dispara erro 11 (regra #16)
2798:             loc_dData  = ConverterParaData(THIS.this_oBusinessObject.this_dDtEnts)
2799:         ENDIF
2800: 
2801:         *-- TRY cobre SO a CRIACAO do dialogo
2802:         TRY
2803:             loc_oDialogo = CREATEOBJECT("FormSigOpAlC", loc_cMoeda, loc_nCotacao, ;
2804:                                         loc_dData)
2805: 
2806:             IF VARTYPE(loc_oDialogo) = "O"
2807:                 *-- Canal de retorno que sobrevive ao Release do dialogo
2808:                 IF PEMSTATUS(loc_oDialogo, "this_oBusinessObject", 5)
2809:                     IF VARTYPE(loc_oDialogo.this_oBusinessObject) = "O"
2810:                         loc_oDialogoBO = loc_oDialogo.this_oBusinessObject
2811:                     ENDIF
2812:                 ENDIF
2813: 
2814:                 loc_lAbrir = .T.
2815:             ELSE
2816:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a " + ;
2817:                     "altera" + CHR(231) + CHR(227) + "o de cota" + CHR(231) + ;
2818:                     CHR(227) + "o (FormSigOpAlC).", ;
2819:                     "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o")
2820:             ENDIF
2821:         CATCH TO loc_oErro
2822:             THIS.this_cMensagemErro = loc_oErro.Message
2823:             MsgErro(loc_oErro.Message + CHR(13) + ;
2824:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2825:                 "Procedure: " + loc_oErro.Procedure, ;
2826:                 "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o")
2827:             loc_oDialogo   = .NULL.
2828:             loc_oDialogoBO = .NULL.
2829:             loc_lAbrir     = .F.
2830:         ENDTRY
2831: 
2832:         *-- Show() FORA do TRY: modal, so retorna quando o usuario confirma ou
2833:         *-- cancela a autorizacao
2834:         IF loc_lAbrir
2835:             loc_oDialogo.Show()
2836:         ENDIF
2837: 
2838:         IF loc_lAbrir
2839:             TRY
2840:                 *-- 1) property do form, enquanto ele existir
2841:                 IF VARTYPE(loc_oDialogo) = "O"
2842:                     IF PEMSTATUS(loc_oDialogo, "this_cRetorno", 5)
2843:                         loc_cRetorno = NVL(loc_oDialogo.this_cRetorno, "")
2844:                     ENDIF
2845:                 ENDIF
2846: 
2847:                 *-- 2) BO do dialogo - canal que sobrevive ao Release dele
2848:                 IF EMPTY(loc_cRetorno) AND VARTYPE(loc_oDialogoBO) = "O"
2849:                     loc_cRetorno = NVL(loc_oDialogoBO.this_cRetorno, "")
2850:                 ENDIF
2851: 
2852:                 *-- `If MLine( lcRetorno, 1 ) = 'OK'`
2853:                 IF UPPER(ALLTRIM(MLINE(loc_cRetorno, 1))) = "OK"
2854:                     THIS.txt_4c_COTACAO.Value = VAL(MLINE(loc_cRetorno, 2))
2855:                     THIS.this_cCotUsu         = ALLTRIM(MLINE(loc_cRetorno, 3))
2856:                 ELSE
2857:                     *-- Cancelado: volta o valor anterior (peantvalue) e apaga o
2858:                     *-- indicador de cotacao autorizada
2859:                     THIS.txt_4c_COTACAO.Value = THIS.this_nCotacaoAnterior
2860:                     THIS.this_cCotUsu         = ""
2861:                 ENDIF
2862: 
2863:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
2864:                     THIS.this_oBusinessObject.this_nCotacao = THIS.txt_4c_COTACAO.Value
2865:                     THIS.this_oBusinessObject.this_cCotUsu  = THIS.this_cCotUsu

*-- Linhas 2884 a 2985:
2884:                 THIS.this_cMensagemErro = loc_oErro.Message
2885:                 MsgErro(loc_oErro.Message + CHR(13) + ;
2886:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2887:                     "Procedure: " + loc_oErro.Procedure, ;
2888:                     "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o")
2889:             ENDTRY
2890:         ENDIF
2891: 
2892:         RETURN loc_lAbrir
2893:     ENDPROC
2894: 
2895:     *--------------------------------------------------------------------------
2896:     * PodeAlterarCotacao - When do SIGOPFPG.alteracotacao do legado:
2897:     *
2898:     *     Return Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' ) ;
2899:     *            And !IsEmpty( Thisform.Get_fpg.Value)
2900:     *
2901:     * (o `And Thisform.Digpar` que vem depois esta COMENTADO no dump do SCX e
2902:     * por isso nao entra).
2903:     *
2904:     * Metodo PUBLIC: o Click o consulta e o harness de teste automatico o
2905:     * alcanca de fora (regra #3).
2906:     *--------------------------------------------------------------------------
2907:     FUNCTION PodeAlterarCotacao()
2908:         RETURN INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR") ;
2909:                AND !EMPTY(ALLTRIM(THIS.txt_4c_Fpg.Value))
2910:     ENDFUNC
2911: 
2912:     *--------------------------------------------------------------------------
2913:     * MostrarObservacao - `PROCEDURE mostraobs` do legado, que eh o metodo que
2914:     * ALTERNA os paineis flutuantes conforme a forma de pagamento da LINHA
2915:     * CORRENTE da grade:
2916:     *
2917:     *     lcFPag = xPar.FPags
2918:     *     Select CrSigOpFp / Set Order To FPags / Seek lcFpag
2919:     *     lcInfo = CrSigOpFp.Infos
2920:     *     ThisForm.GetObs.Visible = ( CrSigOpFp.Obs = 1 )
2921:     *     ThisForm.SayObs.Visible = ( CrSigOpFp.Obs = 1 )
2922:     *     With Thisform.CntChequeFP
2923:     *         .Visible = (lcInfo == 'C')
2924:     *         If .Visible / .Get_Bco.Refresh / ... / EndIf
2925:     *     EndWith
2926:     *     Thisform.CntCarneFP.Visible  = (lcInfo == 'N')
2927:     *     Thisform.CntOutrosFP.Visible = (lcInfo == 'O')
2928:     *     With ThisForm.CntCCredFP
2929:     *         .Visible  = (lcInfo == 'T')
2930:     *         If .Visible / .Get_Cartao.Refresh / .Get_Cred.Refresh / EndIf
2931:     *     EndWith
2932:     *
2933:     * O codigo lido eh o da LINHA CORRENTE do cursor da grade (xPar.FPags), NAO
2934:     * o do campo Cond. Pagto do cabecalho: o usuario pode distribuir o titulo
2935:     * em varias formas e cada linha tem a sua, entao o painel que aparece eh o
2936:     * da linha onde ele esta.
2937:     *
2938:     * `Seek lcFpag` em CrSigOpFp vira CarregarInfoFormaPagamento (SELECT em
2939:     * SigOpFp): este dialogo tem DataSession = 2 e nao alcanca os cursores da
2940:     * sessao do form pai.
2941:     *
2942:     * Metodo PUBLIC: chamado pelos handlers de botao desta fase e alcancado de
2943:     * fora pelo harness de teste automatico (regra #3).
2944:     *--------------------------------------------------------------------------
2945:     PROCEDURE MostrarObservacao()
2946:         LOCAL loc_cCursor, loc_cFPag, loc_cInfo, loc_lObs
2947: 
2948:         loc_cCursor = THIS.this_cCursorGrade
2949:         loc_cFPag   = ""
2950: 
2951:         *-- `lcFPag = xPar.FPags` (linha corrente). Cursor vazio ou em EOF nao
2952:         *-- tem campo para ler - no legado isso equivale ao Seek que nao casa, e
2953:         *-- o efeito eh o mesmo: nenhum painel aparece
2954:         IF USED(loc_cCursor)
2955:             IF RECCOUNT(loc_cCursor) > 0 AND !EOF(loc_cCursor)
2956:                 loc_cFPag = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".FPags"), ""))
2957:             ENDIF
2958:         ENDIF
2959: 
2960:         *-- `Select CrSigOpFp / Seek lcFpag / lcInfo = CrSigOpFp.Infos`
2961:         THIS.CarregarInfoFormaPagamento(loc_cFPag)
2962: 
2963:         loc_cInfo = ALLTRIM(UPPER(THIS.this_cInfoForma))
2964:         loc_lObs  = THIS.this_lObsForma
2965: 
2966:         *-- `ThisForm.GetObs.Visible = ( CrSigOpFp.Obs = 1 )` e o SayObs
2967:         THIS.obj_4c_GetObs.Visible = loc_lObs
2968:         THIS.lbl_4c_Obs.Visible    = loc_lObs
2969: 
2970:         *-- Cheque
2971:         THIS.cnt_4c_ChequeFP.Visible = (loc_cInfo == "C")
2972:         IF THIS.cnt_4c_ChequeFP.Visible
2973:             THIS.cnt_4c_ChequeFP.txt_4c_Bco.Refresh()
2974:             THIS.cnt_4c_ChequeFP.txt_4c_Age.Refresh()
2975:             THIS.cnt_4c_ChequeFP.txt_4c_Conta.Refresh()
2976:             THIS.cnt_4c_ChequeFP.txt_4c_Num.Refresh()
2977:         ENDIF
2978: 
2979:         *-- Carne e Outros (observacao livre)
2980:         THIS.cnt_4c_CarneFP.Visible  = (loc_cInfo == "N")
2981:         THIS.cnt_4c_OutrosFP.Visible = (loc_cInfo == "O")
2982: 
2983:         *-- Cartao de credito (o espelho que o legado mantem sempre presente -
2984:         *-- CntCCredFP, nao o painel CntCCred do mCartaoCred)
2985:         THIS.cnt_4c_CCredFP.Visible = (loc_cInfo == "T")

*-- Linhas 3078 a 3230:
3078:             THIS.this_cMensagemErro = loc_oErro.Message
3079:             MsgErro(loc_oErro.Message + CHR(13) + ;
3080:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3081:                 "Procedure: " + loc_oErro.Procedure, ;
3082:                 "Erro ao consultar Forma de Pagamento")
3083:             loc_lSucesso = .F.
3084:         ENDTRY
3085: 
3086:         IF USED("cursor_4c_InfoFpg")
3087:             USE IN SELECT("cursor_4c_InfoFpg")
3088:         ENDIF
3089: 
3090:         RETURN loc_lSucesso
3091:     ENDFUNC
3092: 
3093:     *--------------------------------------------------------------------------
3094:     * CartaoCredito - `PROCEDURE mcartaocred` do legado:
3095:     *
3096:     *     LParameters plVisible
3097:     *     With ThisForm
3098:     *         For lnI = 1 to .ControlCount
3099:     *             .Controls(lnI).Enabled = Iif(.Controls(lnI).Name=='CntCCred', ;
3100:     *                                          plVisible, Not plVisible)
3101:     *         EndFor
3102:     *         .CntCCred.Visible = plVisible
3103:     *     EndWith
3104:     *
3105:     * O painel de cartao de credito eh "modal sobre o form": enquanto aberto,
3106:     * TODOS os outros controles ficam Enabled = .F. e so ele responde;
3107:     * fechando, a regra se inverte e o resto volta a responder. Transcricao
3108:     * literal, inclusive essa inversao.
3109:     *
3110:     * O nome comparado eh o do objeto no sistema novo (cnt_4c_CCred), em UPPER
3111:     * porque .Name devolve o nome como foi declarado. PEMSTATUS antes de
3112:     * atribuir Enabled porque nem toda classe base tem a propriedade e
3113:     * atribuir onde ela nao existe derruba a tela (regra #33).
3114:     *
3115:     * Metodo PUBLIC: chamado pelo botao Confirmar do painel, pelo evento que
3116:     * abre o painel e pelo harness de teste automatico (regra #3).
3117:     *--------------------------------------------------------------------------
3118:     PROCEDURE CartaoCredito(par_lVisivel)
3119:         LOCAL loc_lVisivel, loc_nI, loc_oObjeto
3120: 
3121:         loc_lVisivel = IIF(VARTYPE(par_lVisivel) = "L", par_lVisivel, .F.)
3122: 
3123:         FOR loc_nI = 1 TO THIS.ControlCount
3124:             loc_oObjeto = THIS.Controls(loc_nI)
3125: 
3126:             IF VARTYPE(loc_oObjeto) = "O"
3127:                 IF PEMSTATUS(loc_oObjeto, "Enabled", 5)
3128:                     loc_oObjeto.Enabled = IIF(UPPER(loc_oObjeto.Name) == "CNT_4C_CCRED", ;
3129:                                               loc_lVisivel, !loc_lVisivel)
3130:                 ENDIF
3131:             ENDIF
3132:         ENDFOR
3133: 
3134:         THIS.cnt_4c_CCred.Visible = loc_lVisivel
3135: 
3136:         RETURN .T.
3137:     ENDPROC
3138: 
3139:     *--------------------------------------------------------------------------
3140:     * FecharDialogo - `PROCEDURE return` do legado:
3141:     *
3142:     *     Thisform.parentform.enabled = .T.
3143:     *     Thisform.release
3144:     *
3145:     * Fonte UNICA dos dois caminhos de saida (Confirmar e Cancelar), com UMA
3146:     * divergencia deliberada de PILAR 3: fecha com Hide(), nao com Release().
3147:     *
3148:     * Medido no VFP9 e documentado no FormSigOpCot/FormBuscaAuxiliar, que fazem
3149:     * o mesmo: Release() destroi o objeto ainda que exista variavel externa
3150:     * apontando para ele - a referencia do chamador vira VARTYPE "X" e a
3151:     * leitura seguinte estoura "is not an object". No legado o form pai e este
3152:     * dialogo compartilhavam a datasession, entao o resultado era o proprio
3153:     * cursor xPar; aqui o dialogo tem DataSession = 2 e precisa sobreviver ao
3154:     * fechamento para o pai ler this_lConfirmado e as linhas da grade. Para o
3155:     * usuario a tela fecha igual (PILAR 1 preservado); muda so o tempo de vida
3156:     * do objeto, e eh o CHAMADOR quem chama Release() depois de ler.
3157:     *
3158:     * A reabilitacao do pai (`parentform.enabled = .T.`) acontece aqui E no
3159:     * Destroy: aqui porque eh o que o legado faz no caminho normal, e no
3160:     * Destroy como rede de seguranca para o fechamento por outra via.
3161:     *
3162:     * Metodo PUBLIC: o form pai pode fechar o dialogo por codigo e o harness de
3163:     * teste automatico o alcanca de fora.
3164:     *--------------------------------------------------------------------------
3165:     PROCEDURE FecharDialogo()
3166:         IF VARTYPE(THIS.this_oFormPai) = "O"
3167:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
3168:                 THIS.this_oFormPai.Enabled = .T.
3169:             ENDIF
3170:         ENDIF
3171: 
3172:         THIS.Hide()
3173: 
3174:         RETURN .T.
3175:     ENDPROC
3176: 
3177:     *==========================================================================
3178:     *  FASE 8/8 - EVENTOS DOS CAMPOS E TRANSFERENCIA COM O FORM PAI
3179:     *==========================================================================
3180: 
3181:     *--------------------------------------------------------------------------
3182:     * DefinirDadosTitulo - API publica para o form PAI informar os dados do
3183:     * titulo/movimento sendo pago, equivalente ao que o Init legado lia
3184:     * DIRETO do cursor compartilhado `crSigChLcq` (DtEnts/ValTots/Emps): o
3185:     * dialogo migrado tem DataSession = 2 (privada) e por isso NAO alcanca o
3186:     * cursor do form pai (comentario de ConfigurarEstruturaBase/MostrarObservacao).
3187:     *
3188:     * Chamar DEPOIS de CREATEOBJECT("FormSigOpFpg", ...) e ANTES de Show():
3189:     *
3190:     *     loc_oDlg = CREATEOBJECT("FormSigOpFpg", THIS, SET("DataSession"), .F.)
3191:     *     loc_oDlg.DefinirDadosTitulo(crSigChLcq.DtEnts, crSigChLcq.ValTots, crSigChLcq.Emps)
3192:     *     loc_oDlg.Show()
3193:     *
3194:     * Sem esta chamada, this_dDtEnts/this_nValTots/this_cEmps ficam nos
3195:     * defaults ({}/0/"") - CarregarCambio trata data vazia como DATE().
3196:     *
3197:     * Metodo PUBLIC: eh a API de integracao com o form pai (regra #3).
3198:     *--------------------------------------------------------------------------
3199:     FUNCTION DefinirDadosTitulo(par_dDtEnts, par_nValTots, par_cEmps)
3200:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3201:             RETURN .F.
3202:         ENDIF
3203: 
3204:         IF INLIST(VARTYPE(par_dDtEnts), "D", "T")
3205:             THIS.this_oBusinessObject.this_dDtEnts = par_dDtEnts
3206:         ENDIF
3207: 
3208:         IF VARTYPE(par_nValTots) = "N"
3209:             THIS.this_oBusinessObject.this_nValTots = par_nValTots
3210:         ENDIF
3211: 
3212:         IF VARTYPE(par_cEmps) = "C"
3213:             THIS.this_oBusinessObject.this_cEmps = ALLTRIM(par_cEmps)
3214:         ENDIF
3215: 
3216:         THIS.AtualizarTotalFormaPagamento()
3217: 
3218:         RETURN .T.
3219:     ENDFUNC
3220: 
3221:     *--------------------------------------------------------------------------
3222:     * ResolverTipoLeitora - Transcricao do bloco do Init legado que le a
3223:     * configuracao de leitora de cheques:
3224:     *
3225:     *     Select * From crSigSyCom Where Tipos = 'Leitora Cheques' Into Cursor CrCfcom
3226:     *     TpLeChq = TpLeChqs / If IsEmpty(TpLeChq) / TpLeChq='T' / Endif
3227:     *     Thisform.TipoLeitora = TpLeChq
3228:     *     Thisform.AvisoPortaM/S/T.Visible conforme TpLeChq
3229:     *     If TpLeChq='S' / Thisform.ReadComm.Configura(...) / ... / Endif
3230:     *

*-- Linhas 3242 a 3285:
3242:     * o que SEMPRE acontece aqui, ate que um form pai concreto injete um
3243:     * leitor serial real.
3244:     *--------------------------------------------------------------------------
3245:     PROTECTED PROCEDURE ResolverTipoLeitora()
3246:         LOCAL loc_cSQL, loc_nResultado, loc_cTipo, loc_oErro
3247: 
3248:         loc_cTipo = "T"
3249: 
3250:         TRY
3251:             IF USED("cursor_4c_SyCom")
3252:                 USE IN SELECT("cursor_4c_SyCom")
3253:             ENDIF
3254: 
3255:             loc_cSQL = "SELECT TOP 1 tplechqs FROM SigSyCom WHERE RTRIM(tipos) = " + ;
3256:                 EscaparSQL("Leitora Cheques")
3257: 
3258:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SyCom")
3259: 
3260:             IF loc_nResultado > 0 AND USED("cursor_4c_SyCom")
3261:                 SELECT cursor_4c_SyCom
3262:                 IF !EOF("cursor_4c_SyCom")
3263:                     loc_cTipo = ALLTRIM(NVL(cursor_4c_SyCom.tplechqs, ""))
3264:                     IF EMPTY(loc_cTipo)
3265:                         loc_cTipo = "T"
3266:                     ENDIF
3267:                 ENDIF
3268:             ENDIF
3269:         CATCH TO loc_oErro
3270:             loc_cTipo = "T"
3271:         ENDTRY
3272: 
3273:         IF USED("cursor_4c_SyCom")
3274:             USE IN SELECT("cursor_4c_SyCom")
3275:         ENDIF
3276: 
3277:         THIS.this_cTipoLeitora   = loc_cTipo
3278:         THIS.this_cLeituraSerial = ""
3279: 
3280:         THIS.img_4c_AvisoPortaM.Visible = .F.
3281:         THIS.img_4c_AvisoPortaS.Visible = .F.
3282:         THIS.img_4c_AvisoPortaT.Visible = .F.
3283: 
3284:         IF loc_cTipo == "S"
3285:             *-- `If ReadComm.PortaError` do legado - sem ReadComm nesta

*-- Linhas 3305 a 3348:
3305:     * Sem registro, fica vazia e CarregarCambio devolve 1 (equivalencia
3306:     * direta) - nao bloqueia o dialogo.
3307:     *--------------------------------------------------------------------------
3308:     PROTECTED PROCEDURE ResolverMoedaOperacao()
3309:         LOCAL loc_cSQL, loc_nResultado, loc_cMoeda, loc_oErro
3310: 
3311:         loc_cMoeda = ""
3312: 
3313:         TRY
3314:             IF USED("cursor_4c_PamMoe")
3315:                 USE IN SELECT("cursor_4c_PamMoe")
3316:             ENDIF
3317: 
3318:             loc_cSQL = "SELECT TOP 1 moedacheqs FROM SigCdPam"
3319: 
3320:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamMoe")
3321: 
3322:             IF loc_nResultado > 0 AND USED("cursor_4c_PamMoe")
3323:                 SELECT cursor_4c_PamMoe
3324:                 IF !EOF("cursor_4c_PamMoe")
3325:                     loc_cMoeda = ALLTRIM(NVL(cursor_4c_PamMoe.moedacheqs, ""))
3326:                 ENDIF
3327:             ENDIF
3328:         CATCH TO loc_oErro
3329:             loc_cMoeda = ""
3330:         ENDTRY
3331: 
3332:         IF USED("cursor_4c_PamMoe")
3333:             USE IN SELECT("cursor_4c_PamMoe")
3334:         ENDIF
3335: 
3336:         THIS.txt_4c_MoeOper.Value = loc_cMoeda
3337:     ENDPROC
3338: 
3339:     *--------------------------------------------------------------------------
3340:     * CarregarCambio - fCarregarCambio() do legado (SIGFUNCS.PRG, nao
3341:     * portado - regra #27/CLAUDE.md). Devolve a cotacao da moeda na data
3342:     * informada: a mais recente registrada em SigCdCot com data <= a
3343:     * informada. Sem cotacao encontrada, devolve 1 (equivalencia direta) -
3344:     * mesmo default dos BOs que ja implementam este padrao (SigReAtmBO/
3345:     * sigopcgcBO), adaptado para SQLEXEC porque este dialogo nao tem
3346:     * crSigCdMoe/crSigCdCot pre-carregados (DataSession propria).
3347:     *
3348:     * Metodo PUBLIC: usado pelas celulas de grade e pelo harness de teste.

*-- Linhas 3649 a 3819:
3649:     *
3650:     * This.Value (o valor JA digitado na celula, antes do REPLACE no
3651:     * cursor - regra #46) comparado contra a data de entrada do titulo,
3652:     * informada pelo form pai (DefinirDadosTitulo). MsgAviso no lugar de
3653:     * Messagebox (MESSAGEBOX PROIBIDO). Retornar .F. mantem o foco na
3654:     * celula (padrao VFP9 de Valid).
3655:     *
3656:     * Metodo PUBLIC: alcancado pela celula da grade (regra #46/#3).
3657:     *--------------------------------------------------------------------------
3658:     FUNCTION ValidarVencimentoLinhaGrade()
3659:         LOCAL loc_oCelula, loc_dDtEnts
3660: 
3661:         loc_oCelula = THIS.grd_4c_Dados.Column3.txt_4c_CelulaVenc
3662:         loc_dDtEnts = ConverterParaData(THIS.this_oBusinessObject.this_dDtEnts)
3663: 
3664:         IF !EMPTY(loc_dDtEnts) AND !EMPTY(loc_oCelula.Value) AND loc_oCelula.Value < loc_dDtEnts
3665:             MsgAviso("Vencimento n" + CHR(227) + "o pode ser menor que a Data da Movimenta" + ;
3666:                 CHR(231) + CHR(227) + "o...")
3667:             RETURN .F.
3668:         ENDIF
3669: 
3670:         RETURN .T.
3671:     ENDFUNC
3672: 
3673:     *--------------------------------------------------------------------------
3674:     * GradeAfterRowColChange - SIGOPFPG.Grade.AfterRowColChange do legado:
3675:     *
3676:     *     LPARAMETERS nColIndex
3677:     *     Thisform.mostraobs
3678:     *     ThisForm.GetObs.Refresh
3679:     *
3680:     * Uso CORRETO de AfterRowColChange por regra #46 - sem filtro de
3681:     * coluna, so recarrega o detalhe (paineis flutuantes) da linha
3682:     * CORRENTE.
3683:     *
3684:     * Metodo PUBLIC: BINDEVENT exige (regra #3).
3685:     *--------------------------------------------------------------------------
3686:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
3687:         THIS.MostrarObservacao()
3688:         THIS.obj_4c_GetObs.Refresh()
3689:     ENDPROC
3690: 
3691:     *--------------------------------------------------------------------------
3692:     * AtualizarCamposPorFormaPagamento - Resolve dinamicamente o Enabled
3693:     * dos campos cujo When legado depende do ESTADO (nao so do modo fixo
3694:     * do dialogo): Get_npar/Get_vpar/fweditdata_venc/Get_PEncargo/GetPorc,
3695:     * todos condicionados a `!IsEmpty(Thisform.Get_fpg.Value)` - e
3696:     * Get_npar tambem a `Thisform.Digpar`. Chamado sempre que esse estado
3697:     * muda: ao escolher uma forma de pagamento (AplicarFormaPagamento) e ao
3698:     * limpa-la (LimparFormaPagamento).
3699:     *--------------------------------------------------------------------------
3700:     PROTECTED PROCEDURE AtualizarCamposPorFormaPagamento()
3701:         LOCAL loc_lModoEditavel, loc_lTemForma
3702: 
3703:         loc_lModoEditavel = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
3704:         loc_lTemForma     = !EMPTY(ALLTRIM(THIS.txt_4c_Fpg.Value))
3705: 
3706:         THIS.txt_4c_Npar.Enabled            = loc_lModoEditavel AND loc_lTemForma AND THIS.this_lDigpar
3707:         THIS.txt_4c_Vpar.Enabled            = loc_lModoEditavel AND loc_lTemForma
3708:         THIS.txt_4c_Fweditdata_venc.Enabled = loc_lModoEditavel AND loc_lTemForma
3709:         THIS.txt_4c_PEncargo.Enabled        = loc_lModoEditavel AND loc_lTemForma
3710:         THIS.txt_4c_Porc.Enabled            = loc_lModoEditavel AND loc_lTemForma
3711:     ENDPROC
3712: 
3713:     *--------------------------------------------------------------------------
3714:     * TxtFweditdataVencGotFocus - pre-preenchimento do When legado de
3715:     * fweditdata_venc (a condicao de habilitacao ja esta em
3716:     * AtualizarCamposPorFormaPagamento):
3717:     *
3718:     *     If IsEmpty(This.Value) And Inlist(op_escolha,'INSERIR','ALTERAR')
3719:     *         This.Value = CrSigChLcq.DtEnts + CrSigOpFp.Entradas
3720:     *     Endif
3721:     *--------------------------------------------------------------------------
3722:     PROCEDURE TxtFweditdataVencGotFocus()
3723:         LOCAL loc_dDtEnts
3724: 
3725:         IF EMPTY(THIS.txt_4c_Fweditdata_venc.Value) AND ;
3726:                 INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
3727:             loc_dDtEnts = ConverterParaData(THIS.this_oBusinessObject.this_dDtEnts)
3728:             IF !EMPTY(loc_dDtEnts)
3729:                 THIS.txt_4c_Fweditdata_venc.Value = loc_dDtEnts + THIS.this_oBusinessObject.this_nEntradas
3730:             ENDIF
3731:         ENDIF
3732:     ENDPROC
3733: 
3734:     *--------------------------------------------------------------------------
3735:     * TxtNparLostFocus - Valid de SIGOPFPG.Get_npar:
3736:     *
3737:     *     if IsEmpty(this.value) / Return(.F.) / endif
3738:     *
3739:     * Retornar .F. no legado mantem o foco no campo - via LostFocus
3740:     * (regra #47) o equivalente eh devolver o foco explicitamente.
3741:     *--------------------------------------------------------------------------
3742:     PROCEDURE TxtNparLostFocus()
3743:         IF EMPTY(THIS.txt_4c_Npar.Value) AND THIS.txt_4c_Npar.Enabled AND THIS.txt_4c_Npar.Visible
3744:             THIS.txt_4c_Npar.SetFocus()
3745:             RETURN .F.
3746:         ENDIF
3747: 
3748:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3749:             THIS.this_oBusinessObject.this_nNPar = THIS.txt_4c_Npar.Value
3750:         ENDIF
3751: 
3752:         RETURN .T.
3753:     ENDPROC
3754: 
3755:     *--------------------------------------------------------------------------
3756:     * TxtVparLostFocus - Valid de SIGOPFPG.Get_vpar (calculo do troco
3757:     * restante quando o usuario deixa o campo vazio/zero; so valida valor
3758:     * negativo quando ja digitado):
3759:     *
3760:     *     If IsEmpty( This.Value )
3761:     *         lnCotOper = fCarregarCambio( MoeOper, DtEnts )
3762:     *         lnCotacao = Get_Cotacao.value
3763:     *         If CrSigOpFp.Trocos = 1
3764:     *             lnTroco = Round((ValTots-Get_TotForma.Value)*lnCotOper/lnCotacao,2)*(-1)
3765:     *             If lnTroco<0 / Value=0 / Return 0 / Else / Value=lnTroco / Endif
3766:     *         Else
3767:     *             Value = Round( (ValTots-Get_TotForma.Value)*lnCotOper/lnCotacao, 2 )
3768:     *         Endif
3769:     *         If !IsEmpty(PEncargo) And !IsEmpty(Value)
3770:     *             VEncargo = Round( Value*PEncargo/100, 2 )
3771:     *         Else
3772:     *             VEncargo = 0
3773:     *         Endif
3774:     *         VEncargo.Refresh
3775:     *     Else
3776:     *         If Value < 0 / Value=0 / Return 0 / Endif
3777:     *     Endif
3778:     *--------------------------------------------------------------------------
3779:     PROCEDURE TxtVparLostFocus()
3780:         LOCAL loc_nCotOper, loc_nCotacao, loc_nTroco, loc_nTrocos, loc_nValTots
3781: 
3782:         IF EMPTY(THIS.txt_4c_Vpar.Value)
3783:             loc_nTrocos  = THIS.ObterTrocosDaForma(THIS.txt_4c_Fpg.Value)
3784:             loc_nCotOper = THIS.CarregarCambio(THIS.txt_4c_MoeOper.Value, THIS.this_oBusinessObject.this_dDtEnts)
3785:             loc_nCotacao = THIS.txt_4c_COTACAO.Value
3786:             loc_nValTots = NVL(THIS.this_oBusinessObject.this_nValTots, 0)
3787: 
3788:             IF loc_nCotacao = 0
3789:                 loc_nCotacao = 1
3790:             ENDIF
3791: 
3792:             IF loc_nTrocos = 1
3793:                 loc_nTroco = ROUND((loc_nValTots - THIS.txt_4c_TotForma.Value) * loc_nCotOper / loc_nCotacao, 2) * (-1)
3794:                 IF loc_nTroco < 0
3795:                     THIS.txt_4c_Vpar.Value = 0
3796:                     RETURN .F.
3797:                 ELSE
3798:                     THIS.txt_4c_Vpar.Value = loc_nTroco
3799:                 ENDIF
3800:             ELSE
3801:                 THIS.txt_4c_Vpar.Value = ROUND((loc_nValTots - THIS.txt_4c_TotForma.Value) * loc_nCotOper / loc_nCotacao, 2)
3802:             ENDIF
3803: 
3804:             IF !EMPTY(THIS.txt_4c_PEncargo.Value) AND !EMPTY(THIS.txt_4c_Vpar.Value)
3805:                 THIS.txt_4c_VEncargo.Value = ROUND(THIS.txt_4c_Vpar.Value * THIS.txt_4c_PEncargo.Value / 100, 2)
3806:             ELSE
3807:                 THIS.txt_4c_VEncargo.Value = 0
3808:             ENDIF
3809:             THIS.txt_4c_VEncargo.Refresh()
3810:         ELSE
3811:             IF THIS.txt_4c_Vpar.Value < 0
3812:                 THIS.txt_4c_Vpar.Value = 0
3813:                 RETURN .F.
3814:             ENDIF
3815:         ENDIF
3816: 
3817:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3818:             THIS.this_oBusinessObject.this_nVPar     = THIS.txt_4c_Vpar.Value
3819:             THIS.this_oBusinessObject.this_nVEncargo = THIS.txt_4c_VEncargo.Value

*-- Linhas 3832 a 3901:
3832:     *     Endif
3833:     *     VEncargo.Refresh
3834:     *--------------------------------------------------------------------------
3835:     PROCEDURE TxtPEncargoLostFocus()
3836:         IF !EMPTY(THIS.txt_4c_Vpar.Value) AND !EMPTY(THIS.txt_4c_PEncargo.Value)
3837:             THIS.txt_4c_VEncargo.Value = ROUND(THIS.txt_4c_Vpar.Value * THIS.txt_4c_PEncargo.Value / 100, 2)
3838:         ELSE
3839:             THIS.txt_4c_VEncargo.Value = 0
3840:         ENDIF
3841:         THIS.txt_4c_VEncargo.Refresh()
3842: 
3843:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3844:             THIS.this_oBusinessObject.this_nPEncargo = THIS.txt_4c_PEncargo.Value
3845:             THIS.this_oBusinessObject.this_nVEncargo = THIS.txt_4c_VEncargo.Value
3846:         ENDIF
3847: 
3848:         RETURN .T.
3849:     ENDPROC
3850: 
3851:     *--------------------------------------------------------------------------
3852:     * TxtPorcLostFocus - Valid de SIGOPFPG.GetPorc (idem Get_vpar, mas a
3853:     * partir de um PERCENTUAL do valor total do titulo):
3854:     *
3855:     *     If !IsEmpty( This.Value )
3856:     *         ... (mesmo calculo de troco/valor de Get_vpar, usando
3857:     *              ValTots * This.Value / 100 no ramo sem troco) ...
3858:     *         Get_VPar.Value = lnValor / Get_VPar.Refresh / VEncargo.Refresh
3859:     *     Endif
3860:     *--------------------------------------------------------------------------
3861:     PROCEDURE TxtPorcLostFocus()
3862:         LOCAL loc_nCotOper, loc_nCotacao, loc_nTrocos, loc_nValor, loc_nTroco, loc_nValTots
3863: 
3864:         IF !EMPTY(THIS.txt_4c_Porc.Value)
3865:             loc_nTrocos  = THIS.ObterTrocosDaForma(THIS.txt_4c_Fpg.Value)
3866:             loc_nCotOper = THIS.CarregarCambio(THIS.txt_4c_MoeOper.Value, THIS.this_oBusinessObject.this_dDtEnts)
3867:             loc_nCotacao = THIS.txt_4c_COTACAO.Value
3868:             loc_nValTots = NVL(THIS.this_oBusinessObject.this_nValTots, 0)
3869: 
3870:             IF loc_nCotacao = 0
3871:                 loc_nCotacao = 1
3872:             ENDIF
3873: 
3874:             IF loc_nTrocos = 1
3875:                 loc_nTroco = ROUND((loc_nValTots - THIS.txt_4c_TotForma.Value) * loc_nCotOper / loc_nCotacao, 2) * (-1)
3876:                 IF loc_nTroco < 0
3877:                     loc_nValor = 0
3878:                     RETURN .F.
3879:                 ELSE
3880:                     loc_nValor = loc_nTroco
3881:                 ENDIF
3882:             ELSE
3883:                 loc_nValor = ROUND(loc_nValTots * THIS.txt_4c_Porc.Value / 100 * loc_nCotOper / loc_nCotacao, 2)
3884:             ENDIF
3885: 
3886:             IF !EMPTY(THIS.txt_4c_PEncargo.Value) AND !EMPTY(loc_nValor)
3887:                 THIS.txt_4c_VEncargo.Value = ROUND(loc_nValor * THIS.txt_4c_PEncargo.Value / 100, 2)
3888:             ELSE
3889:                 THIS.txt_4c_VEncargo.Value = 0
3890:             ENDIF
3891: 
3892:             THIS.txt_4c_Vpar.Value = loc_nValor
3893:             THIS.txt_4c_Vpar.Refresh()
3894:             THIS.txt_4c_VEncargo.Refresh()
3895: 
3896:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3897:                 THIS.this_oBusinessObject.this_nVPar     = loc_nValor
3898:                 THIS.this_oBusinessObject.this_nVEncargo = THIS.txt_4c_VEncargo.Value
3899:             ENDIF
3900:         ENDIF
3901: 

*-- Linhas 3907 a 3950:
3907:     * ("|AAAAMMDD|..."), mesmo padrao de SigPrCfnBO.CarregarFeriados -
3908:     * evita um SELECT por dia dentro do laco do gerador de parcelas.
3909:     *--------------------------------------------------------------------------
3910:     PROTECTED PROCEDURE CarregarFeriados()
3911:         LOCAL loc_cSQL, loc_nResultado, loc_cLista, loc_oErro
3912: 
3913:         IF THIS.this_lFeriadosCarregados
3914:             RETURN .T.
3915:         ENDIF
3916: 
3917:         loc_cLista = "|"
3918: 
3919:         TRY
3920:             IF USED("cursor_4c_FerLoad")
3921:                 USE IN SELECT("cursor_4c_FerLoad")
3922:             ENDIF
3923: 
3924:             loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer WHERE datas IS NOT NULL"
3925: 
3926:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")
3927: 
3928:             IF loc_nResultado > 0 AND USED("cursor_4c_FerLoad")
3929:                 SELECT cursor_4c_FerLoad
3930:                 SCAN
3931:                     IF !ISNULL(datas) AND !EMPTY(datas)
3932:                         loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
3933:                     ENDIF
3934:                 ENDSCAN
3935:                 USE IN SELECT("cursor_4c_FerLoad")
3936:             ENDIF
3937: 
3938:             THIS.this_cFeriadosCache      = loc_cLista
3939:             THIS.this_lFeriadosCarregados = .T.
3940:         CATCH TO loc_oErro
3941:             THIS.this_cFeriadosCache = "|"
3942:         ENDTRY
3943: 
3944:         RETURN .T.
3945:     ENDPROC
3946: 
3947:     *--------------------------------------------------------------------------
3948:     * AvancarAlemDosFeriados - Transcricao do laco de feriados do
3949:     * fweditdata_venc.Valid legado:
3950:     *

*-- Linhas 4021 a 4082:
4021:     * LostFocus legado (`wait window 'TAB para alterar valor' nowait` +
4022:     * `Thisform.get_fpg.SetFocus`) roda SEMPRE depois do Valid no legado -
4023:     * concatenado ao final deste MESMO handler (regra do projeto: LostFocus
4024:     * no lugar de Valid, nunca BINDEVENT em Valid de TextBox - regra #47).
4025:     *
4026:     * fGerUniqueKey (CARNE) e CartaoCredito/CmdConfirmaCartaoClick (Fase 7/
4027:     * Fase 8) ja existem. "CARNE" eh o codigo literal da forma de pagamento
4028:     * no legado - transcrito tal qual (regra #17, nao inventar).
4029:     *--------------------------------------------------------------------------
4030:     PROCEDURE TxtFweditdataVencLostFocus()
4031:         LOCAL loc_dDtEnts, loc_dVenc, loc_dVenci, loc_nParcelas, loc_nTotPar, ;
4032:             loc_nValPar, loc_nParcs, loc_nIndiceParcela, loc_nCotOper, loc_nCotacao, ;
4033:             loc_nTotal, loc_nTrocos, loc_nCarne, loc_cCartao, loc_cNoCredito, ;
4034:             loc_lPrimeiroCartao, loc_cCursor, loc_oErro
4035: 
4036:         loc_cCursor = THIS.this_cCursorGrade
4037:         loc_dDtEnts = ConverterParaData(THIS.this_oBusinessObject.this_dDtEnts)
4038: 
4039:         *-- `If This.Value < CrSigChLcq.DtEnts And !IsEmpty(This.Value)`
4040:         IF !EMPTY(loc_dDtEnts) AND !EMPTY(THIS.txt_4c_Fweditdata_venc.Value) AND ;
4041:                 THIS.txt_4c_Fweditdata_venc.Value < loc_dDtEnts
4042:             MsgAviso("Vencimento n" + CHR(227) + "o pode ser menor que a Data da Movimenta" + ;
4043:                 CHR(231) + CHR(227) + "o...")
4044:             THIS.txt_4c_Fweditdata_venc.SetFocus()
4045:             RETURN .F.
4046:         ENDIF
4047: 
4048:         *-- Sem forma de pagamento escolhida nao ha o que gerar - o campo so
4049:         *-- fica habilitado quando ha (AtualizarCamposPorFormaPagamento),
4050:         *-- mas o guard fica aqui tambem por seguranca (regra de nao confiar
4051:         *-- so no Enabled para decidir execucao de regra de negocio).
4052:         IF EMPTY(ALLTRIM(THIS.txt_4c_Fpg.Value))
4053:             RETURN .T.
4054:         ENDIF
4055: 
4056:         TRY
4057:             THIS.GarantirCursorDados()
4058: 
4059:             loc_nCotacao  = THIS.txt_4c_COTACAO.Value
4060:             loc_nCotOper  = THIS.CarregarCambio(THIS.txt_4c_MoeOper.Value, loc_dDtEnts)
4061:             IF loc_nCotacao = 0
4062:                 loc_nCotacao = 1
4063:             ENDIF
4064:             IF loc_nCotOper = 0
4065:                 loc_nCotOper = 1
4066:             ENDIF
4067: 
4068:             loc_nParcelas = THIS.txt_4c_Npar.Value
4069:             loc_nTotal    = THIS.txt_4c_TotForma.Value
4070:             loc_nValPar   = ROUND((THIS.txt_4c_Vpar.Value + THIS.txt_4c_VEncargo.Value) / MAX(loc_nParcelas, 1), 2)
4071:             loc_nTotPar   = 0
4072:             loc_nCarne    = 0
4073:             loc_cCartao   = ""
4074:             loc_cNoCredito = ""
4075: 
4076:             loc_dVenc  = THIS.txt_4c_Fweditdata_venc.Value
4077:             loc_dVenci = THIS.txt_4c_Fweditdata_venc.Value
4078:             loc_nIndiceParcela = 1
4079:             loc_nParcs          = 1
4080:             loc_lPrimeiroCartao = .T.
4081: 
4082:             DO WHILE loc_nParcelas > 0

*-- Linhas 4202 a 4750:
4202:             THIS.this_cMensagemErro = loc_oErro.Message
4203:             MsgErro(loc_oErro.Message + CHR(13) + ;
4204:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4205:                 "Procedure: " + loc_oErro.Procedure, ;
4206:                 "Erro ao gerar parcelas")
4207:         ENDTRY
4208: 
4209:         *-- `PROCEDURE LostFocus` do legado (sempre roda depois do Valid)
4210:         WAIT WINDOW "TAB para alterar valor" NOWAIT
4211:         IF THIS.txt_4c_Fpg.Visible AND THIS.txt_4c_Fpg.Enabled
4212:             THIS.txt_4c_Fpg.SetFocus()
4213:         ENDIF
4214: 
4215:         RETURN .T.
4216:     ENDPROC
4217: 
4218:     *--------------------------------------------------------------------------
4219:     * TxtCartaoLostFocus - Valid de SIGOPFPG.CntCCred.Get_cartao:
4220:     *
4221:     *     If Not IsEmpty(This.Value) And Not fValidaCards(This.Value)
4222:     *         messagebox('Numero Cartao Invalido !!',0+48,'')
4223:     *         Return 0
4224:     *     Endif
4225:     *
4226:     * Depois da validacao, reflete o When de Get_cred (so habilita quando
4227:     * Cartao esta preenchido).
4228:     *--------------------------------------------------------------------------
4229:     PROCEDURE TxtCartaoLostFocus()
4230:         IF !EMPTY(THIS.cnt_4c_CCred.txt_4c_Cartao.Value) AND ;
4231:                 !fValidaCards(THIS.cnt_4c_CCred.txt_4c_Cartao.Value)
4232:             MsgAviso("N" + CHR(250) + "mero Cart" + CHR(227) + "o Inv" + CHR(225) + "lido !!")
4233:             THIS.cnt_4c_CCred.txt_4c_Cartao.SetFocus()
4234:             RETURN .F.
4235:         ENDIF
4236: 
4237:         THIS.cnt_4c_CCred.txt_4c_Cred.Enabled = !EMPTY(THIS.cnt_4c_CCred.txt_4c_Cartao.Value) AND ;
4238:             INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
4239: 
4240:         RETURN .T.
4241:     ENDPROC
4242: 
4243:     *--------------------------------------------------------------------------
4244:     * AtualizarEnabledCreditoFp - When de CntCCredFP.Get_cartao/Get_cred:
4245:     *
4246:     *     Get_cartao.When: InList(op_escolha,...) And CrSigOpFp.CarAuts#'S'
4247:     *     Get_cred.When:   IsEmpty(Get_Cartao.value) ? .F. :
4248:     *                      InList(op_escolha,...) And CarAuts#'S'
4249:     *
4250:     * Chamado quando this_lCarAuts muda (AplicarFormaPagamento) e apos
4251:     * editar o Cartao espelho.
4252:     *--------------------------------------------------------------------------
4253:     PROTECTED PROCEDURE AtualizarEnabledCreditoFp()
4254:         LOCAL loc_lModoEditavel, loc_lSemAutorizacao
4255: 
4256:         loc_lModoEditavel   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
4257:         loc_lSemAutorizacao = .T.
4258:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
4259:             loc_lSemAutorizacao = !THIS.this_oBusinessObject.this_lCarAuts
4260:         ENDIF
4261: 
4262:         THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Enabled = loc_lModoEditavel AND loc_lSemAutorizacao
4263:         THIS.cnt_4c_CCredFP.txt_4c_CredFp.Enabled   = loc_lModoEditavel AND loc_lSemAutorizacao ;
4264:             AND !EMPTY(THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Value)
4265:     ENDPROC
4266: 
4267:     *--------------------------------------------------------------------------
4268:     * TxtCartaoFpLostFocus - Valid de SIGOPFPG.CntCCredFP.Get_cartao (mesma
4269:     * regra de fValidaCards de TxtCartaoLostFocus, aplicada ao espelho).
4270:     *--------------------------------------------------------------------------
4271:     PROCEDURE TxtCartaoFpLostFocus()
4272:         IF !EMPTY(THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Value) AND ;
4273:                 !fValidaCards(THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Value)
4274:             MsgAviso("N" + CHR(250) + "mero Cart" + CHR(227) + "o Inv" + CHR(225) + "lido !!")
4275:             THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.SetFocus()
4276:             RETURN .F.
4277:         ENDIF
4278: 
4279:         THIS.AtualizarEnabledCreditoFp()
4280: 
4281:         RETURN .T.
4282:     ENDPROC
4283: 
4284:     *--------------------------------------------------------------------------
4285:     * TxtCredFpLostFocus - SIGOPFPG.CntCCredFP.Get_cred nao tem Valid
4286:     * proprio no dump; LostFocus devolve o foco a Valor da grade, mesmo
4287:     * destino do Confirma do painel visivel (CmdConfirmaCartaoClick).
4288:     *--------------------------------------------------------------------------
4289:     PROCEDURE TxtCredFpLostFocus()
4290:         LOCAL loc_cCursor
4291:         loc_cCursor = THIS.this_cCursorGrade
4292: 
4293:         IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled AND ;
4294:                 USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
4295:             THIS.grd_4c_Dados.Column2.SetFocus()
4296:         ENDIF
4297:     ENDPROC
4298: 
4299:     *--------------------------------------------------------------------------
4300:     * TxtNumLostFocus - Valid de SIGOPFPG.CntChequeFP.Get_num:
4301:     *
4302:     *     if not IsEmpty(this.value)
4303:     *         if not fChkDigitos(xPar.numeros)
4304:     *             messagebox('Numero Invalido !',0+48,'')
4305:     *             Return 0
4306:     *         endif
4307:     *     endif
4308:     *
4309:     * + LostFocus (19 linhas) - dispara VerificaCheque com os 4 campos da
4310:     * LINHA CORRENTE (ControlSource, regra do topo deste arquivo).
4311:     *--------------------------------------------------------------------------
4312:     PROCEDURE TxtNumLostFocus()
4313:         LOCAL loc_cCursor
4314:         loc_cCursor = THIS.this_cCursorGrade
4315: 
4316:         IF !EMPTY(THIS.cnt_4c_ChequeFP.txt_4c_Num.Value)
4317:             IF !fChkDigitos(THIS.cnt_4c_ChequeFP.txt_4c_Num.Value)
4318:                 MsgAviso("N" + CHR(250) + "mero Inv" + CHR(225) + "lido !")
4319:                 THIS.cnt_4c_ChequeFP.txt_4c_Num.SetFocus()
4320:                 RETURN .F.
4321:             ENDIF
4322:         ENDIF
4323: 
4324:         THIS.ValidarChequeLinhaCorrente()
4325: 
4326:         RETURN .T.
4327:     ENDPROC
4328: 
4329:     *--------------------------------------------------------------------------
4330:     * TxtContaLostFocus - Valid de SIGOPFPG.CntChequeFP.Get_conta:
4331:     *
4332:     *     if not IsEmpty(this.value)
4333:     *         if not fChkDigitos(xPar.contas)
4334:     *             messagebox('Conta Invalida !',0+48,'')
4335:     *             Return 0
4336:     *         endif
4337:     *     endif
4338:     *--------------------------------------------------------------------------
4339:     PROCEDURE TxtContaLostFocus()
4340:         IF !EMPTY(THIS.cnt_4c_ChequeFP.txt_4c_Conta.Value)
4341:             IF !fChkDigitos(THIS.cnt_4c_ChequeFP.txt_4c_Conta.Value)
4342:                 MsgAviso("Conta Inv" + CHR(225) + "lida !")
4343:                 THIS.cnt_4c_ChequeFP.txt_4c_Conta.SetFocus()
4344:                 RETURN .F.
4345:             ENDIF
4346:         ENDIF
4347: 
4348:         RETURN .T.
4349:     ENDPROC
4350: 
4351:     *--------------------------------------------------------------------------
4352:     * TxtAgeLostFocus - Valid de SIGOPFPG.CntChequeFP.Get_age:
4353:     *
4354:     *     if not IsEmpty(this.value)
4355:     *         if not fChkDigitos(xPar.agencias)
4356:     *             messagebox('Agencia Invalida !',0+48,'')
4357:     *             Return 0
4358:     *         endif
4359:     *     endif
4360:     *--------------------------------------------------------------------------
4361:     PROCEDURE TxtAgeLostFocus()
4362:         IF !EMPTY(THIS.cnt_4c_ChequeFP.txt_4c_Age.Value)
4363:             IF !fChkDigitos(THIS.cnt_4c_ChequeFP.txt_4c_Age.Value)
4364:                 MsgAviso("Agencia Inv" + CHR(225) + "lida !")
4365:                 THIS.cnt_4c_ChequeFP.txt_4c_Age.SetFocus()
4366:                 RETURN .F.
4367:             ENDIF
4368:         ENDIF
4369: 
4370:         RETURN .T.
4371:     ENDPROC
4372: 
4373:     *--------------------------------------------------------------------------
4374:     * TxtBcoGotFocus - efeito colateral do When de SIGOPFPG.CntChequeFP.
4375:     * Get_bco quando a leitora e serial (TipoLeitora='S'):
4376:     *
4377:     *     If Thisform.TipoLeitora = 'S'
4378:     *         IF !ReadComm.Ole_Comm.PortOpen and !ReadComm.PortaError
4379:     *             ReadComm.Ole_Comm.PortOpen = .t.
4380:     *         ENDIF
4381:     *         Wait Window 'Passe o cheque pela leitora !' nowait
4382:     *     Endif
4383:     *
4384:     * ReadComm nao existe nesta arquitetura (ResolverTipoLeitora) - o aviso
4385:     * "passe o cheque" so faz sentido com leitora de fato conectada.
4386:     *--------------------------------------------------------------------------
4387:     PROCEDURE TxtBcoGotFocus()
4388:         IF THIS.this_cTipoLeitora == "S"
4389:             WAIT WINDOW "Passe o cheque pela leitora !" NOWAIT
4390:         ENDIF
4391:     ENDPROC
4392: 
4393:     *--------------------------------------------------------------------------
4394:     * TxtBcoLostFocus - Valid + LostFocus de SIGOPFPG.CntChequeFP.Get_bco.
4395:     *
4396:     * O Valid legado (64 linhas) trata DOIS modos de captura: leitora
4397:     * serial (bloco de leitura caractere-a-caractere do buffer RS232, que
4398:     * exige o ReadComm OLE inexistente nesta arquitetura - regra de
4399:     * ResolverTipoLeitora) e digitacao manual. So o caminho manual se
4400:     * aplica aqui: valida que o banco digitado eh todo-numerico
4401:     * (fChkDigitos) e, no LostFocus, dispara VerificaCheque com os 4
4402:     * campos da linha corrente.
4403:     *--------------------------------------------------------------------------
4404:     PROCEDURE TxtBcoLostFocus()
4405:         IF !EMPTY(THIS.cnt_4c_ChequeFP.txt_4c_Bco.Value)
4406:             IF !fChkDigitos(THIS.cnt_4c_ChequeFP.txt_4c_Bco.Value)
4407:                 MsgAviso("Banco Inv" + CHR(225) + "lido !")
4408:                 THIS.cnt_4c_ChequeFP.txt_4c_Bco.SetFocus()
4409:                 RETURN .F.
4410:             ENDIF
4411:         ENDIF
4412: 
4413:         THIS.ValidarChequeLinhaCorrente()
4414: 
4415:         RETURN .T.
4416:     ENDPROC
4417: 
4418:     *--------------------------------------------------------------------------
4419:     * ValidarChequeLinhaCorrente - fonte unica para o LostFocus de
4420:     * Get_bco/Get_num (ambos disparam a MESMA checagem no legado):
4421:     *
4422:     *     if not IsEmpty(bancos+agencias+contas+numeros)
4423:     *         if !Thisform.VerificaCheque( bancos,agencias,contas,numeros )
4424:     *             Replace bancos,agencias,contas,numeros With ''
4425:     *             .get_bco.SetFocus
4426:     *         else
4427:     *             Thisform.Grade.Valor.Text1.SetFocus
4428:     *         endif
4429:     *     else
4430:     *         Thisform.Grade.Valor.Text1.SetFocus
4431:     *     endif
4432:     *
4433:     * Metodo PUBLIC: alcancado pelos dois LostFocus (regra #3).
4434:     *--------------------------------------------------------------------------
4435:     PROCEDURE ValidarChequeLinhaCorrente()
4436:         LOCAL loc_cCursor, loc_cBanco, loc_cAgencia, loc_cConta, loc_cNumero
4437: 
4438:         loc_cCursor = THIS.this_cCursorGrade
4439: 
4440:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
4441:             RETURN .T.
4442:         ENDIF
4443: 
4444:         loc_cBanco   = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".Bancos"), ""))
4445:         loc_cAgencia = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".Agencias"), ""))
4446:         loc_cConta   = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".Contas"), ""))
4447:         loc_cNumero  = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".Numeros"), ""))
4448: 
4449:         IF EMPTY(loc_cBanco + loc_cAgencia + loc_cConta + loc_cNumero)
4450:             THIS.FocarValorDaGrade()
4451:             RETURN .T.
4452:         ENDIF
4453: 
4454:         IF !THIS.VerificaCheque(loc_cBanco, loc_cAgencia, loc_cConta, loc_cNumero)
4455:             SELECT (loc_cCursor)
4456:             REPLACE Bancos WITH "", Agencias WITH "", Contas WITH "", Numeros WITH ""
4457:             THIS.cnt_4c_ChequeFP.txt_4c_Bco.Refresh()
4458:             THIS.cnt_4c_ChequeFP.txt_4c_Age.Refresh()
4459:             THIS.cnt_4c_ChequeFP.txt_4c_Conta.Refresh()
4460:             THIS.cnt_4c_ChequeFP.txt_4c_Num.Refresh()
4461:             THIS.cnt_4c_ChequeFP.txt_4c_Bco.SetFocus()
4462:         ELSE
4463:             THIS.FocarValorDaGrade()
4464:         ENDIF
4465: 
4466:         RETURN .T.
4467:     ENDPROC
4468: 
4469:     *--------------------------------------------------------------------------
4470:     * FocarValorDaGrade - `Thisform.Grade.Valor.Text1.SetFocus`, repetido
4471:     * em varios pontos do legado (CntCCred.Confirma, CntCCredFP.Get_cred.
4472:     * LostFocus, ValidarChequeLinhaCorrente).
4473:     *--------------------------------------------------------------------------
4474:     PROTECTED PROCEDURE FocarValorDaGrade()
4475:         LOCAL loc_cCursor
4476:         loc_cCursor = THIS.this_cCursorGrade
4477: 
4478:         IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled AND ;
4479:                 USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
4480:             THIS.grd_4c_Dados.Column2.SetFocus()
4481:         ENDIF
4482:     ENDPROC
4483: 
4484:     *--------------------------------------------------------------------------
4485:     * LimpaChe - `PROCEDURE limpa_che` do legado:
4486:     *
4487:     *     With ThisForm.CntChequeFP
4488:     *         .Get_Bco.Value = Space(3)   / .Get_Bco.Refresh
4489:     *         .Get_Age.Value = Space(4)   / .Get_Age.Refresh
4490:     *         .Get_Conta.Value = Space(10) / .Get_Conta.Refresh
4491:     *         .Get_Num.Value = Space(6)   / .Get_Num.Refresh
4492:     *     EndWith
4493:     *
4494:     * Os campos sao ControlSource da linha corrente (regra do topo deste
4495:     * arquivo) - REPLACE no cursor, nao atribuicao direta ao .Value.
4496:     *
4497:     * Metodo PUBLIC: harness de teste automatico e handlers de outras fases
4498:     * podem chamar (regra #3).
4499:     *--------------------------------------------------------------------------
4500:     PROCEDURE LimpaChe()
4501:         LOCAL loc_cCursor
4502:         loc_cCursor = THIS.this_cCursorGrade
4503: 
4504:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
4505:             SELECT (loc_cCursor)
4506:             REPLACE Bancos WITH SPACE(3), Agencias WITH SPACE(4), ;
4507:                     Contas WITH SPACE(10), Numeros WITH SPACE(6)
4508:         ENDIF
4509: 
4510:         THIS.cnt_4c_ChequeFP.txt_4c_Bco.Refresh()
4511:         THIS.cnt_4c_ChequeFP.txt_4c_Age.Refresh()
4512:         THIS.cnt_4c_ChequeFP.txt_4c_Conta.Refresh()
4513:         THIS.cnt_4c_ChequeFP.txt_4c_Num.Refresh()
4514:     ENDPROC
4515: 
4516:     *--------------------------------------------------------------------------
4517:     * InChequeSerial - `PROCEDURE inchequeserial` do legado: completa a
4518:     * leitura da leitora serial (ReadComm.leitura/campo) e dispara a mesma
4519:     * cadeia Get_Bco.Valid + VerificaCheque do fluxo manual. Disparado no
4520:     * legado pelo evento OnComm do controle OLE ReadComm.
4521:     *
4522:     * ReadComm NAO existe nesta arquitetura (ResolverTipoLeitora) - sem o
4523:     * objeto, nao ha buffer serial para ler, e o metodo fica inerte por
4524:     * construcao (nunca disparado, porque nao ha evento OnComm). Mantido
4525:     * PUBLIC e com o guard explicito para o dia em que um form pai concreto
4526:     * injete um leitor serial real (mesmo padrao defensivo de
4527:     * Formsigopcim.PrepararLeitoraParaFoco) - regra #27 (wrapper documenta
4528:     * ausencia, nao apaga o ponto de integracao).
4529:     *--------------------------------------------------------------------------
4530:     PROCEDURE InChequeSerial()
4531:         LOCAL loc_cCursor
4532: 
4533:         THIS.this_lLeitor = .F.
4534: 
4535:         IF VARTYPE(THIS.this_oFormPai) != "O" OR ;
4536:                 !PEMSTATUS(THIS.this_oFormPai, "ReadComm", 5) OR ;
4537:                 VARTYPE(THIS.this_oFormPai.ReadComm) != "O"
4538:             RETURN .F.
4539:         ENDIF
4540: 
4541:         THIS.this_cLeituraSerial = THIS.this_oFormPai.ReadComm.Campo
4542: 
4543:         THIS.TxtBcoLostFocus()
4544: 
4545:         IF THIS.this_lLeitor
4546:             loc_cCursor = THIS.this_cCursorGrade
4547:             IF USED(loc_cCursor) AND !EOF(loc_cCursor) AND ;
4548:                     !EMPTY(ALLTRIM(NVL(EVALUATE(loc_cCursor + ".Bancos"), "")))
4549:                 IF !THIS.VerificaCheque(EVALUATE(loc_cCursor + ".Bancos"), ;
4550:                         EVALUATE(loc_cCursor + ".Agencias"), ;
4551:                         EVALUATE(loc_cCursor + ".Contas"), ;
4552:                         EVALUATE(loc_cCursor + ".Numeros"))
4553:                     THIS.LimpaChe()
4554:                     THIS.this_cLeituraSerial = ""
4555:                     THIS.cnt_4c_ChequeFP.txt_4c_Bco.SetFocus()
4556:                 ELSE
4557:                     THIS.cnt_4c_ChequeFP.txt_4c_Num.SetFocus()
4558:                 ENDIF
4559:             ENDIF
4560:         ELSE
4561:             THIS.cnt_4c_ChequeFP.txt_4c_Age.SetFocus()
4562:         ENDIF
4563: 
4564:         THIS.this_lLeitor = .F.
4565: 
4566:         RETURN .T.
4567:     ENDPROC
4568: 
4569:     *--------------------------------------------------------------------------
4570:     * VerificaCheque - `PROCEDURE verificacheque` do legado (134 linhas):
4571:     * confere se o cheque (banco+agencia+conta+numero) digitado eh valido
4572:     * (digitos), nao foi lancado DUAS VEZES nesta MESMA distribuicao (xPar/
4573:     * cursor_4c_Dados) e nao esta cadastrado em outro titulo (SigChe) com
4574:     * valor diferente.
4575:     *
4576:     *     if !fChkDigitos(banco/agencia/numero/conta) / 'Leitura incorreta' / sd=.f.
4577:     *     if sd / Seek banco+agencia+conta+numero em xPar (outra linha) /
4578:     *             se achou -> 'Cheque ja lancado' / sd=.f.
4579:     *     if sd / Select * From SigChe Where Bancos=... And Agencias=...
4580:     *             And nContas=... And Ncheques=... Into Cursor CrCheque /
4581:     *             se achou -> confere TempChq (mesmo titulo) -> se nao
4582:     *             achou la, 'Cheque ja cadastrado'; se achou, confere Valor
4583:     *     Return sd
4584:     *
4585:     * `TempChq` (cursor das PARCELAS JA GRAVADAS do MESMO titulo, que
4586:     * distingue "este cheque e de uma OUTRA nota" de "este cheque e desta
4587:     * MESMA nota, so que ja fechada antes") nao existe nesta arquitetura:
4588:     * nenhum form pai fornece esse cursor (SigOpFpg ainda nao esta
4589:     * encadeado a Fluxo de Caixa/Baixa de Titulos - grep confirmado,
4590:     * 2026-11-04). Sem ele, a distincao "mesmo titulo" x "outro titulo" eh
4591:     * IMPOSSIVEL de fazer; o SEEK sobre alias inexistente estouraria em
4592:     * runtime. Degrada para o lado CONSERVADOR: cheque ja registrado em
4593:     * SigChe (qualquer titulo) bloqueia como "ja cadastrado" - impede
4594:     * duplicar lancamento de cheque, ao preco de poder bloquear o caso
4595:     * raro de reconfirmar o MESMO titulo (que o usuario resolve veio pelo
4596:     * Cancelar/reabrir). `ThisForm.Parentform.PoDataMgr.SqlExecute` (data
4597:     * manager legado) vira SQLEXEC(gnConnHandle,...) direto.
4598:     *
4599:     * Metodo PUBLIC: chamado pelos LostFocus de Get_bco/Get_num e por
4600:     * InChequeSerial.
4601:     *--------------------------------------------------------------------------
4602:     FUNCTION VerificaCheque(par_cBanco, par_cAgencia, par_cConta, par_cNumero)
4603:         LOCAL loc_cCursor, loc_lDigitosOk, loc_lDuplicadoLocal, loc_lOk, ;
4604:             loc_cSQL, loc_nResultado, loc_cAliasAnt, loc_nRecnoAnt, loc_oErro
4605: 
4606:         loc_cCursor = THIS.this_cCursorGrade
4607:         loc_lOk     = .T.
4608: 
4609:         *-- `if !fChkDigitos(banco/agencia/numero/conta)`
4610:         loc_lDigitosOk = fChkDigitos(par_cBanco) AND fChkDigitos(par_cAgencia) AND ;
4611:             fChkDigitos(par_cNumero) AND fChkDigitos(par_cConta)
4612: 
4613:         IF !loc_lDigitosOk
4614:             MsgAviso("Leitura de cheque incorreta!")
4615:             RETURN .F.
4616:         ENDIF
4617: 
4618:         *-- `Seek banco+agencia+conta+numero em xPar` (outra linha da MESMA
4619:         *-- distribuicao ja usa este cheque)
4620:         IF USED(loc_cCursor)
4621:             loc_cAliasAnt = ALIAS()
4622:             SELECT (loc_cCursor)
4623:             loc_nRecnoAnt = IIF(EOF() OR BOF(), 0, RECNO())
4624: 
4625:             loc_lDuplicadoLocal = .F.
4626:             SCAN FOR ALLTRIM(NVL(Bancos, "")) == ALLTRIM(par_cBanco) AND ;
4627:                      ALLTRIM(NVL(Agencias, "")) == ALLTRIM(par_cAgencia) AND ;
4628:                      ALLTRIM(NVL(Contas, "")) == ALLTRIM(par_cConta) AND ;
4629:                      ALLTRIM(NVL(Numeros, "")) == ALLTRIM(par_cNumero) AND ;
4630:                      RECNO() != loc_nRecnoAnt
4631:                 loc_lDuplicadoLocal = .T.
4632:                 EXIT
4633:             ENDSCAN
4634: 
4635:             IF loc_nRecnoAnt > 0 AND loc_nRecnoAnt <= RECCOUNT(loc_cCursor)
4636:                 SELECT (loc_cCursor)
4637:                 GOTO loc_nRecnoAnt
4638:             ENDIF
4639:             IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
4640:                 SELECT (loc_cAliasAnt)
4641:             ENDIF
4642: 
4643:             IF loc_lDuplicadoLocal
4644:                 MsgAviso("Cheque j" + CHR(225) + " lan" + CHR(231) + "ado!!")
4645:                 RETURN .F.
4646:             ENDIF
4647:         ENDIF
4648: 
4649:         *-- `Select * From SigChe Where Bancos=... And Agencias=... And
4650:         *--  nContas=... And Ncheques=... Into Cursor CrCheque`
4651:         TRY
4652:             IF USED("cursor_4c_CheCk")
4653:                 USE IN SELECT("cursor_4c_CheCk")
4654:             ENDIF
4655: 
4656:             loc_cSQL = "SELECT valors FROM SigChe" + ;
4657:                 " WHERE RTRIM(bancos) = " + EscaparSQL(ALLTRIM(par_cBanco)) + ;
4658:                 " AND RTRIM(agencias) = " + EscaparSQL(ALLTRIM(par_cAgencia)) + ;
4659:                 " AND RTRIM(ncontas) = " + EscaparSQL(ALLTRIM(par_cConta)) + ;
4660:                 " AND RTRIM(ncheques) = " + EscaparSQL(ALLTRIM(par_cNumero))
4661: 
4662:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheCk")
4663: 
4664:             IF loc_nResultado < 0
4665:                 MsgErro("Favor reinicializar o processo." + CHR(13) + CapturarErroSQL(), ;
4666:                     "Falha na Conex" + CHR(227) + "o")
4667:                 loc_lOk = .F.
4668:             ELSE
4669:                 IF USED("cursor_4c_CheCk") AND RECCOUNT("cursor_4c_CheCk") > 0
4670:                     *-- Sem TempChq (ver cabecalho do metodo), qualquer match
4671:                     *-- em SigChe bloqueia como "ja cadastrado" - lado
4672:                     *-- conservador da degradacao.
4673:                     MsgAviso("Cheque j" + CHR(225) + " cadastrado !!")
4674:                     loc_lOk = .F.
4675:                 ENDIF
4676:             ENDIF
4677:         CATCH TO loc_oErro
4678:             MsgErro(loc_oErro.Message, "Erro ao verificar cheque")
4679:             loc_lOk = .F.
4680:         ENDTRY
4681: 
4682:         IF USED("cursor_4c_CheCk")
4683:             USE IN SELECT("cursor_4c_CheCk")
4684:         ENDIF
4685: 
4686:         RETURN loc_lOk
4687:     ENDFUNC
4688: 
4689:     *--------------------------------------------------------------------------
4690:     * TornarControlesVisiveis - Torna visiveis recursivamente os controles
4691:     * criados via AddObject (que nascem Visible=.F.).
4692:     *
4693:     * EXCECAO (FASE 6/8): os 5 paineis flutuantes de forma de pagamento
4694:     * (CntCCred/CntCCredFP/CntCarneFP/CntOutrosFP/CntChequeFP) tem de
4695:     * permanecer Visible=.F. - sao alternados pelo equivalente a MostraObs/
4696:     * mCartaoCred do legado (MostrarObservacao/CartaoCredito, Fase 7).
4697:     * A excecao preserva o Visible=.F. do CONTAINER mas ainda desce a
4698:     * recursao para os filhos (labels/textboxes), que precisam estar
4699:     * Visible=.T. assim que o painel for exibido - regra de forms
4700:     * OPERACIONAIS com containers flutuantes.
4701:     *--------------------------------------------------------------------------
4702:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4703:         LOCAL loc_nI, loc_oObjeto, loc_nP, loc_lPainelFlutuante
4704: 
4705:         FOR loc_nI = 1 TO par_oContainer.ControlCount
4706:             loc_oObjeto = par_oContainer.Controls(loc_nI)
4707: 
4708:             IF VARTYPE(loc_oObjeto) = "O"
4709:                 loc_lPainelFlutuante = INLIST(UPPER(loc_oObjeto.Name), ;
4710:                     "CNT_4C_CCRED", "CNT_4C_CCREDFP", "CNT_4C_CARNEFP", ;
4711:                     "CNT_4C_OUTROSFP", "CNT_4C_CHEQUEFP")
4712: 
4713:                 IF !loc_lPainelFlutuante AND PEMSTATUS(loc_oObjeto, "Visible", 5)
4714:                     loc_oObjeto.Visible = .T.
4715:                 ENDIF
4716: 
4717:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
4718:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
4719:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
4720:                     ENDFOR
4721:                 ENDIF
4722: 
4723:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
4724:                     THIS.TornarControlesVisiveis(loc_oObjeto)
4725:                 ENDIF
4726:             ENDIF
4727:         ENDFOR
4728:     ENDPROC
4729: 
4730:     *--------------------------------------------------------------------------
4731:     * Destroy - Legado: `Return` reabilita o form pai antes de liberar o
4732:     * dialogo (Thisform.parentform.enabled = .T. / Thisform.release). O
4733:     * caminho canonico de fechamento (equivalente ao Return) eh FecharDialogo,
4734:     * acionado por CmdOkClick/CmdCancelaClick; aqui, Destroy garante a
4735:     * reabilitacao do pai mesmo se o dialogo for fechado por outra via
4736:     * (ESC/erro).
4737:     * DODEFAULT() por ULTIMO - sem ele FormBase.Destroy nao roda e os popups
4738:     * do menu principal ficam com cache visual obsoleto (regra #29/CLAUDE.md).
4739:     *--------------------------------------------------------------------------
4740:     PROCEDURE Destroy()
4741:         IF VARTYPE(THIS.this_oFormPai) = "O"
4742:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
4743:                 THIS.this_oFormPai.Enabled = .T.
4744:             ENDIF
4745:         ENDIF
4746: 
4747:         DODEFAULT()
4748:     ENDPROC
4749: 
4750: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpFpgBO.prg):
*==============================================================================
* SigOpFpgBO.prg
*
* Business Object para SigOpFpg (Forma de Pagamento)
* Dialogo filho chamado por formularios de movimento (ex.: Fluxo de Caixa /
* Baixa de Titulos) para distribuir o valor de um titulo/cheque em uma ou
* mais formas de pagamento (dinheiro, cartao, carne, cheque, outros).
*
* Nao possui tabela principal propria: a grade de formas de pagamento
* trabalha sobre o cursor local xPar (populado/consumido pelo form) e os
* dados sao devolvidos ao formulario pai, que grava no titulo/movimento
* de origem (SigChLcq e afins).
*
* FASE 1/8: Propriedades e Init. FASE 8/8: propriedades adicionais lidas
* pelo gerador de parcelas (this_cEmps/this_nEntradas/this_nDias/
* this_cTvens/this_cDcarts), populadas pelo FormSigOpFpg em
* AplicarFormaPagamento/DefinirDadosTitulo.
*==============================================================================

DEFINE CLASS SigOpFpgBO AS BusinessBase

    *-- Contexto recebido do formulario pai (Init do form legado:
    *-- Lparameters pForm, DatSes, llAltDireta)
    this_cOpEscolha     = ""    && op_escolha herdado do form pai (INSERIR/ALTERAR/CONSULTAR/EXCLUIR)
    this_lAltDireta     = .F.   && llAltDireta - fluxo de alteracao direta de forma de pagamento

    *-- Dados do titulo/movimento sendo pago (resolvidos a partir do cursor
    *-- do form pai - equivalente a CrSigChLcq no legado)
    this_dDtEnts        = {}    && datetime - data de entrada/movimentacao do titulo
    this_nValTots       = 0     && numeric  - valor total do titulo/cheque a pagar
    this_cEmps          = ""    && char     - empresa do titulo (SigChLcq.Emps), gravada em cada parcela

    *-- Linha corrente da grade de formas de pagamento (xPar), espelhando as
    *-- colunas usadas pelo legado: FPags, Valos, Vencs, Moedas, CotFpgs
    this_cFPags         = ""    && char     - codigo da forma de pagamento (SigCdOpFp.FPags)
    this_nValos         = 0     && numeric  - valor da parcela/linha
    this_dVencs         = {}    && date     - data de vencimento da parcela
    this_cMoedas        = ""    && char     - moeda da parcela
    this_nCotFpgs       = 0     && numeric  - cotacao aplicada na parcela

    *-- Totais e campos de cabecalho do dialogo
    this_cMoeOper       = ""    && char     - moeda de operacao (Get_MoeOper)
    this_nTotForma      = 0     && numeric  - total ja distribuido nas formas de pagamento
    this_nNPar          = 0     && numeric  - numero de parcelas
    this_nVPar          = 0     && numeric  - valor da parcela calculada
    this_nPEncargo      = 0     && numeric  - percentual de encargo financeiro
    this_nVEncargo      = 0     && numeric  - valor de encargo financeiro
    this_nCotacao       = 0     && numeric  - cotacao atual da moeda de operacao
    this_cCotUsu        = ""    && char     - indicador de cotacao alterada manualmente (SigOpAlC)
    this_nValTotChqs    = 0     && numeric  - valor total ja distribuido em cheques
    this_cObs           = ""    && memo     - observacao (forma "Outros")

    *-- Regras de vencimento/parcelamento da forma de pagamento escolhida
    *-- (SigOpFp.entradas/dias/tvens/dcarts), lidas em AplicarFormaPagamento e
    *-- consumidas pelo gerador de parcelas (fweditdata_venc.Valid do legado)
    this_nEntradas      = 0     && numeric - dias da data do titulo at? o 1o vencimento
    this_nDias          = 0     && numeric - intervalo entre parcelas (dias)
    this_cTvens         = ""    && char    - "F"=dias Fixos (GoMonth) / "C"=dias Corridos
    this_cDcarts        = ""    && char    - descricao do cartao, gravada em cada parcela

    *-- Painel Cartao de Credito (CntCCred / CntCCredFP)
    this_cCartao        = ""    && char     - numero do cartao de credito
    this_nCred          = 0     && numeric  - numero de parcelas do credito

    *-- Painel Carne (CntCarneFP)
    this_cCarne         = ""    && char     - codigo do carne

    *-- Painel Cheque (CntChequeFP)
    this_cBco           = ""    && char     - codigo do banco
    this_cAge           = ""    && char     - codigo da agencia
    this_cConta         = ""    && char     - numero da conta
    this_cNum           = ""    && char     - numero do cheque

    *-- Estado de controle (leitora serial de cheques / flags do legado)
    this_lLeitor        = .F.   && leitora serial de cheques habilitada
    this_cLeituraSerial = ""    && buffer com a leitura recebida da porta serial
    this_cTipoLeitora   = ""    && "S" = leitora serial configurada
    this_lDigpar        = .F.   && habilita digitacao manual de numero de parcelas
    this_lCarAuts       = .F.   && SigCdOpFp.CarAuts - cartao de credito sem validacao de digitos

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object. Sem tabela principal (dialogo
    * trabalha sobre cursor local do form pai).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel. Este dialogo nao tem tabela principal
    * (ver cabecalho da classe): a linha corrente da grade de formas de
    * pagamento chega por propriedade (this_cFPags/this_nValos/this_dVencs/
    * this_cMoedas/this_nCotFpgs), preenchida pelo proprio form a partir do
    * cursor local xPar - nao por SELECT (par_cAliasCursor).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel. Este dialogo nao grava em tabela do SQL
    * Server: a gravacao efetiva do titulo/movimento ocorre no formulario
    * pai (SigChLcq e afins), a partir do cursor xPar devolvido no Return.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel, pelo mesmo motivo de Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel: sem tabela nem chave primaria
    * propria neste dialogo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel: sem gravacao em tabela do SQL
    * Server neste dialogo, nao ha operacao para auditar aqui. O registro
    * de auditoria do titulo/movimento fica a cargo do formulario pai.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN
    ENDPROC

ENDDEFINE

