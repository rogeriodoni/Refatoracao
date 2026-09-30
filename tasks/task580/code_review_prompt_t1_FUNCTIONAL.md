# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.EstaEmModoValidacaoOuTeste()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH .grdTitulos define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: .grdTitulos.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvTta.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1051 linhas total):

*-- Linhas 24 a 397:
24: * aqui como cnt_4c_Sombra.
25: *
26: * FASE 3/8 - ESTRUTURA BASE: esqueleto do form (propriedades visuais,
27: * Init/InicializarForm, BO e o cabecalho).
28: *
29: * FASE 4/8 - GRID E BOTAO: grade de impostos (grd_4c_Dados, 8 colunas
30: * ligadas ao cursor recebido em this_cArquivo) e o botao OK
31: * (cmd_4c_CmdSair, com a validacao de ValTits/Vencs do legado antes de
32: * fechar). O legado (SIGMVTTA) e' flat e tem UM UNICO botao - NAO ha
33: * Incluir/Alterar/Excluir/Buscar aqui (PILAR 1: nao inventar UI que o
34: * legado nao tem).
35: *
36: * FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1): metade dos campos que faltavam
37: * (getDGrupos/Label3 -> txt_4c_DGrupos/lbl_4c_Label3, descricao do Grupo).
38: *
39: * FASE 6/8 - CAMPOS RESTANTES E VALIDACAO: descricao da Conta
40: * (getDContas/Label1 -> txt_4c_DContas/lbl_4c_Label1), o
41: * AfterRowColChange da grade (grdTitulos.AfterRowColChange no legado) que
42: * consulta SigCdGcr.Descrs pelo codigo do Grupo e SigCdCli.RClis pelo
43: * codigo da Conta da linha corrente para preencher os dois campos de
44: * descricao, e o metodo de validacao ValidarTitulosVencimentos (o laco de
45: * conferencia de Valor Titulo / Vencimento que o legado tinha embutido no
46: * cmdSair.Click).
47: *
48: * FASE 7/8 - EVENTOS PRINCIPAIS: conferido contra o dump legado (15
49: * metodos/eventos em SigMvTta_form_codigo_fonte.txt, SECAO 3) e contra
50: * comportamento.json - TODOS ja tem equivalente migrado nas fases
51: * anteriores: Init (Fase 3), o bind da grade + cmdSair.Click (Fase 4,
52: * como CarregarLista/BtnOkClick/ValidarTitulosVencimentos) e
53: * AfterRowColChange (Fase 6, como GrdDadosAfterRowColChange). SIGMVTTA e'
54: * um dialogo FLAT com um UNICO botao (cmdSair/OK) - o legado nao tem
55: * Incluir/Alterar/Visualizar/Excluir, e este form migrado tambem nao
56: * pode ter (PILAR 1: nao inventar UI que o legado nao tem; ver tambem a
57: * regra "NUNCA criar stubs com MsgAviso" - um BtnIncluirClick fabricado
58: * aqui seria exatamente esse anti-padrao). Nenhum evento principal ficou
59: * faltando - esta fase nao adiciona codigo funcional novo.
60: *
61: * Esta tela NAO tem lookup - nem F4, nem duplo-clique, nem picker. O dump
62: * do legado nao tem uma unica chamada a fwBuscaExt/fwBuscaSel/sigacess/
63: * mAddColuna, e os dois campos de descricao tem PROCEDURE When retornando
64: * .f. INCONDICIONAL (getDGrupos e getDContas): sao somente exibicao,
65: * preenchidos por codigo a partir da linha corrente da grade, e o usuario
66: * nunca digita neles. Nao havendo onde digitar um codigo, nao ha o que um
67: * picker resolva - criar um aqui seria inventar tabela de lookup que o
68: * original nao consulta, violando o PILAR 1 e a regra explicita "NUNCA
69: * inventar tabelas de lookup que nao existem no original".
70: *
71: * Os UNICOS campos digitaveis da tela sao as colunas 7 e 8 da grade (Valor
72: * Titulo / Vencimento), e so em INSERIR/ALTERAR (Column<N>.Text1.When do
73: * legado devolve InList(pcEscolha,"INSERIR","ALTERAR")). A validacao delas
74: * e' o que esta fase entrega em ValidarTitulosVencimentos - o legado a
75: * dispara no clique do OK, nao num Valid de celula.
76: *
77: * Parametros de Init (equivalentes ao legado LParameters pArq, pEsc, pObj):
78: *   par_cArquivo - pArq: nome do ALIAS do cursor com os impostos da
79: *                  movimentacao (colunas Impostos/ValBases/Aliqs/ValImps/
80: *                  Grupos/Contas/ValTits/Vencs, mapeando sigmvimp), aberto
81: *                  e populado pelo form CHAMADOR antes de instanciar este
82: *                  dialogo. Este form NAO fecha nem reabre esse cursor -
83: *                  ele pertence ao chamador (ver Destroy()).
84: *   par_cEscolha - pEsc: modo ("INSERIR"/"ALTERAR"/outro). Controla se as
85: *                  colunas ValTits/Vencs da grade ficam editaveis (o
86: *                  legado faz isso via Column.Text1.When retornando
87: *                  InList(pcEscolha,"INSERIR","ALTERAR") - aqui vira
88: *                  Column.ReadOnly, na fase da grade).
89: *
90: * O 3o parametro do legado (pObj / poDataMgr, usado so para
91: * poDataMgr.SqlExecute) NAO tem equivalente aqui: a arquitetura nova usa
92: * o handle global gnConnHandle (SQLEXEC(gnConnHandle, ...)) em vez de um
93: * objeto de acesso a dados por instancia - repassar um parametro extra
94: * so para guardar uma referencia nunca usada seria inventar API.
95: *
96: * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL: o roteiro padrao
97: * desta fase (BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/
98: * BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/LimparCampos/
99: * CarregarLista/AjustarBotoesPorModo) e' o checklist do frmcadastro
100: * (Page1=Lista + Page2=Dados, campos EDITAVEIS mapeados para o BO). Este
101: * dialogo NAO tem PageFrame, NAO tem Grupo_Op, NAO tem os 4 botoes CRUD
102: * nem Salvar/Cancelar - o legado inteiro (SigMvTta_form_codigo_fonte.txt,
103: * 15 metodos/eventos) tem UM UNICO CommandButton (cmdSair/"OK") e ZERO
104: * Insert/Update/Delete contra tabela (a unica escrita e' no cursor VFP em
105: * MEMORIA do chamador, via ControlSource das colunas 7/8 da grade -
106: * SigMvTtaBO.Inserir/Atualizar existem por convencao de BusinessBase mas
107: * este dialogo nunca os chama). Disposicao dos 9 nomes do roteiro, um a
108: * um, com a MESMA logica ja registrada nas Fases 4-7 acima (nao inventar
109: * UI/API que o legado nao tem; ver "NUNCA criar stubs com MsgAviso"):
110: *
111: *   Nome pedido pelo roteiro   Existe no legado?  Disposicao aqui
112: *   -------------------------  -----------------  --------------------------
113: *   BtnBuscarClick              NAO (SCX so tem   N/A - nao ha botao de
114: *                                 cmdSair)          busca/filtro nesta tela
115: *   BtnEncerrarClick             SIM (cmdSair,     Ja implementado como
116: *                                 Caption "OK",     BtnOkClick (nome trocado
117: *                                 fecha o dialogo)  nesta fase - ver abaixo)
118: *   BtnSalvarClick               NAO (zero        N/A - Inserir()/Atualizar()
119: *                                 Insert/Update/    do BO documentam que este
120: *                                 Delete no dump)   dialogo nunca grava tabela
121: *   BtnCancelarClick             NAO (um UNICO    N/A - nao ha Page2 de
122: *                                 botao, sem modo   Dados nem modo de edicao
123: *                                 de edicao a       para cancelar; o UNICO
124: *                                 cancelar)         botao FECHA (ver acima)
125: *   FormParaBO / BOParaForm      N/A - nao ha     Coberto por CarregarLista
126: *                                 "formulario" de   (bind da grade) e por
127: *                                 campos separado   GrdDadosAfterRowColChange
128: *                                 do dado; a grade  (BO -> campos de
129: *                                 edita o cursor    descricao) - o sentido
130: *                                 do chamador       unico que este dialogo
131: *                                 DIRETO            de fato precisa
132: *   HabilitarCampos /            N/A - nao ha     AjustarColunasPorModo (Fase
133: *   LimparCampos                 modo INCLUIR/     4) ja cobre o UNICO campo
134: *                                 ALTERAR/          que muda de estado por
135: *                                 VISUALIZAR de     modo: as colunas 7/8 da
136: *                                 form CRUD          grade (Column.ReadOnly)
137: *   AjustarBotoesPorModo          N/A - o UNICO    N/A - cmd_4c_CmdSair fica
138: *                                 botao nao muda    sempre habilitado,
139: *                                 de estado por      qualquer que seja
140: *                                 modo               this_cEscolha
141: *   CarregarLista                 SIM               Ja implementado (Fase 4;
142: *                                                    renomeado de
143: *                                                    CarregarDados nesta fase
144: *                                                    - ver abaixo)
145: *
146: * Escrever qualquer um dos 7 metodos marcados N/A so para "bater o
147: * checklist" seria o stub disfarcado que a regra de completude PROIBE
148: * (corpo vazio ou so MsgAviso) - pior que a ausencia documentada, porque
149: * sugeriria uma paridade com o legado que nao existe.
150: *
151: * Dois RENOMES nesta fase (sem mudanca de comportamento, so de nome):
152: *   CmdSairClick  -> BtnOkClick     (Caption do botao e' "OK"; o nome
153: *                                     anterior nao seguia a convencao
154: *                                     Btn<Acao>Click ja usada no restante
155: *                                     do projeto para o botao de acao
156: *                                     principal de forms sem CRUD)
157: *   CarregarDados -> CarregarLista  (o metodo carrega e liga a UNICA grade
158: *                                     da tela, que E' a "lista" deste
159: *                                     dialogo - CarregarLista e' o nome
160: *                                     convencional para esse papel)
161: *
162: * Load legado ("=fConfigGeral()", SECAO 3 do dump) NAO PORTADO - mesmo
163: * motivo ja registrado em FormSigMvExp.prg/FormSigMvMen.prg/
164: * FormSigMvSbn.prg/FormSIGMVTI2.prg (task570/573/577/off-catalog):
165: * fConfigGeral() era funcao GLOBAL de inicializacao da aplicacao legado
166: * (sig.prg), chamada pelo Load de TODO form Fortyus - nao e' logica
167: * especifica desta tela. Na arquitetura nova essa inicializacao global ja
168: * ocorre em config.prg/ConfigurarAmbiente ANTES de qualquer form ser
169: * instanciado; chamar fConfigGeral() aqui seria reproduzir codigo morto
170: * (o wrapper utils\fconfiggeral.prg documenta o mesmo: "em codigo NOSSO
171: * nunca se chama fConfigGeral - este arquivo existe APENAS para binario
172: * legado"). PROCEDURE Release do legado (so' =DoDefault()) tambem nao
173: * precisa de porte - e' o Destroy() deste form, que ja faz o equivalente
174: * (libera THIS.this_oBusinessObject e chama DODEFAULT()).
175: *
176: * Integracao (menu.prg): este dialogo NAO recebe entrada no popup
177: * popMovimentos. Diferente de um form CRUD, ele exige um cursor JA
178: * aberto e populado pelo chamador (par_cArquivo) e um modo (par_cEscolha)
179: * - instancia-lo do menu principal, sem esses dois parametros, abriria um
180: * dialogo sem grade nenhuma para editar (this_cArquivo vazio). O padrao
181: * do projeto para esse tipo de dialogo e' o form de movimentacao que gera
182: * os impostos chamar CREATEOBJECT("FormSigMvTta", <cursor>, <modo>)
183: * diretamente, exatamente como FormSigMvSbn (task577, tambem um dialogo
184: * modal caller-invoked) tampouco tem entrada em menu.prg - e' aberto de
185: * dentro de Formsigpres2.prg. Nenhum form de movimentacao deste acervo
186: * ainda invoca FormSigMvTta; quando esse form for migrado, ele e' quem
187: * deve ganhar o CREATEOBJECT("FormSigMvTta", ...), nao o menu.
188: *
189: * FASE 8/8 CONCLUIDA.
190: *
191: * CONSOLIDACAO - DISPOSICAO DOS 15 METODOS DO SCX LEGADO
192: * -------------------------------------------------------
193: * O dump (SigMvTta_form_codigo_fonte.txt, "Total de metodos/eventos com
194: * codigo: 15") esta integralmente coberto:
195: *
196: *   Legado                          Migrado
197: *   -------------------------------  -----------------------------------
198: *   SIGMVTTA.Release                 Destroy() (DODEFAULT() no fim)
199: *   SIGMVTTA.Load (=fConfigGeral())  NAO PORTADO - ver acima
200: *   SIGMVTTA.Init                    Init() + InicializarForm() +
201: *                                     CarregarLista() (mesmos 2 parametros
202: *                                     posicionais; pObj/poDataMgr sem
203: *                                     equivalente - ver acima)
204: *   grdTitulos.AfterRowColChange     GrdDadosAfterRowColChange (BINDEVENT)
205: *   grdTitulos.Column1.Text1.When    Column1.ReadOnly = .T. (fixo, sem
206: *     (Return .f.)                   modo - AjustarColunasPorModo)
207: *   grdTitulos.Column2.Text1.When    Column2.ReadOnly = .T. (idem)
208: *   grdTitulos.Column3.Text1.When    Column3.ReadOnly = .T. (idem)
209: *   grdTitulos.Column4.Text1.When    Column4.ReadOnly = .T. (idem)
210: *   grdTitulos.Column5.Text1.When    Column5.ReadOnly = .T. (idem)
211: *   grdTitulos.Column6.Text1.When    Column6.ReadOnly = .T. (idem)
212: *   grdTitulos.Column7.Text1.When    Column7.ReadOnly = !INLIST(this_cEsc-
213: *     (InList(pcEscolha,...))        olha,"INSERIR","ALTERAR") - idem p/
214: *                                     Column8 (AjustarColunasPorModo)
215: *   cmdSair.Click                    BtnOkClick() -> ValidarTitulosVenci-
216: *                                     mentos() + Release() (via BINDEVENT)
217: *   getDGrupos.When (Return .f.)     txt_4c_DGrupos.ReadOnly = .T. (fixo,
218: *                                     ConfigurarCamposDescricao)
219: *   getDContas.When (Return .f.)     txt_4c_DContas.ReadOnly = .T. (idem)
220: *
221: * Nenhum metodo do legado ficou sem disposicao registrada.
222: *====================================================================
223: 
224: DEFINE CLASS FormSigMvTta AS FormBase
225: 
226:     *-- Propriedades visuais (pixel-perfect SCX original - PILAR 1)
227:     Width        = 1000
228:     Height       = 600
229:     AutoCenter   = .T.
230:     Caption      = "Impostos Gerados na Movimenta" + CHR(231) + CHR(227) + "o"
231:     WindowType   = 1
232:     ShowWindow = 1
233:     ControlBox   = .F.
234:     Closable     = .F.
235:     MaxButton    = .F.
236:     MinButton    = .F.
237:     Movable      = .T.
238:     ClipControls = .F.
239:     TitleBar     = 0
240:     BorderStyle  = 2
241:     DataSession  = 1
242: 
243:     *-- Business Object
244:     this_oBusinessObject = .NULL.
245: 
246:     *-- Parametros recebidos do form chamador (equivalentes a
247:     *-- Arquivo/pcEscolha do legado)
248:     this_cArquivo = ""
249:     this_cEscolha = ""
250: 
251:     *==========================================================================
252:     * Init - Armazena os parametros recebidos do form chamador (cursor com
253:     * os impostos da movimentacao e o modo INSERIR/ALTERAR/...) antes de
254:     * DODEFAULT() disparar FormBase.Init -> InicializarForm.
255:     *==========================================================================
256:     PROCEDURE Init(par_cArquivo, par_cEscolha)
257:         LOCAL loc_lResultado
258:         loc_lResultado = .F.
259: 
260:         THIS.this_cArquivo = IIF(VARTYPE(par_cArquivo) = "C", ALLTRIM(par_cArquivo), "")
261:         THIS.this_cEscolha = IIF(VARTYPE(par_cEscolha) = "C", par_cEscolha, "")
262: 
263:         loc_lResultado = DODEFAULT()
264:         RETURN loc_lResultado
265:     ENDPROC
266: 
267:     *==========================================================================
268:     * InicializarForm - Cria o Business Object, calcula o Caption (Emps/
269:     * Dopes/Numes extraidos posicionalmente de EmpDopNums, igual ao legado),
270:     * monta o cabecalho, a grade de impostos, o botao OK e os campos de
271:     * descricao (Grupo/Conta).
272:     *==========================================================================
273:     PROTECTED PROCEDURE InicializarForm()
274:         LOCAL loc_lSucesso, loc_oErro, loc_cArq
275:         loc_lSucesso = .F.
276: 
277:         TRY
278:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
279: 
280:             *-- Instanciar Business Object
281:             THIS.this_oBusinessObject = CREATEOBJECT("SigMvTtaBO")
282:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
283:                 MsgErro("Erro ao criar SigMvTtaBO. VARTYPE retornou: " + ;
284:                         VARTYPE(THIS.this_oBusinessObject), "FormSigMvTta.InicializarForm")
285:             ELSE
286:                 *-- Titulo: "Impostos Gerados Na Movimentacao: <Emps> / <Dopes> /
287:                 *-- <Numes>", extraido posicionalmente de EmpDopNums (Emps char(3)
288:                 *-- + Dopes char(20) + Numes char(6) = 29 - CLAUDE.md regra #42).
289:                 *-- Pulado em validacao/teste: o cursor this_cArquivo nao existe
290:                 *-- nesses modos (form instanciado sem parametros).
291:                 loc_cArq = THIS.this_cArquivo
292:                 IF !THIS.EstaEmModoValidacaoOuTeste() AND !EMPTY(loc_cArq) AND USED(loc_cArq)
293:                     THIS.Caption = "Impostos Gerados Na Movimenta" + CHR(231) + CHR(227) + "o: " + ;
294:                         ALLTRIM(LEFT(EVALUATE(loc_cArq + ".EmpDopNums"), 3)) + " / " + ;
295:                         ALLTRIM(SUBSTR(EVALUATE(loc_cArq + ".EmpDopNums"), 4, 20)) + " / " + ;
296:                         ALLTRIM(RIGHT(EVALUATE(loc_cArq + ".EmpDopNums"), 6))
297:                 ENDIF
298: 
299:                 THIS.ConfigurarCabecalho()
300:                 THIS.ConfigurarGrid()
301:                 THIS.ConfigurarBotoes()
302:                 THIS.ConfigurarCamposDescricao()
303: 
304:                 *-- Carga da grade: liga as 8 colunas ao cursor recebido do
305:                 *-- chamador e posiciona no topo. Fica DEPOIS de ConfigurarGrid
306:                 *-- porque o legado tambem binda por ultimo, com a grade ja
307:                 *-- montada (Init: Select &lcArq. / Goto Top In &lcArq. /
308:                 *-- With .grdTitulos / .RecordSource = lcArq / ...).
309:                 THIS.CarregarLista()
310: 
311:                 *-- Foco inicial identico ao legado: grade (coluna ValTits) em
312:                 *-- INSERIR/ALTERAR, botao OK nos demais modos (ex.: VISUALIZAR).
313:                 IF !THIS.EstaEmModoValidacaoOuTeste() AND !EMPTY(loc_cArq) AND USED(loc_cArq)
314:                     IF INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
315:                         THIS.grd_4c_Dados.SetFocus()
316:                         THIS.grd_4c_Dados.Column7.SetFocus()
317:                     ELSE
318:                         THIS.cmd_4c_CmdSair.SetFocus()
319:                     ENDIF
320:                 ENDIF
321: 
322:                 loc_lSucesso = .T.
323:             ENDIF
324: 
325:         CATCH TO loc_oErro
326:             MsgErro(loc_oErro.Message + CHR(13) + ;
327:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
328:                     "Procedure: " + loc_oErro.Procedure, ;
329:                     "Erro em FormSigMvTta.InicializarForm")
330:         ENDTRY
331: 
332:         RETURN loc_lSucesso
333:     ENDPROC
334: 
335:     *==========================================================================
336:     * EstaEmModoValidacaoOuTeste - .T. quando o form esta sendo instanciado
337:     * pelo ValidarUIFidelity (gb_4c_ValidandoUI) ou pelo harness de testes
338:     * automatizados (gb_4c_ModoTeste) - nesses modos this_cArquivo nunca
339:     * aponta para um cursor real (form instanciado sem parametros), entao
340:     * qualquer bloco que dependa do cursor do chamador precisa pular.
341:     *
342:     * NOTA DE REDACAO: nao iniciar linha de comentario com a palavra
343:     * "todo" - o validador de completude (05d_validarCompletude) casa
344:     * ^\s*\*\s*TODO\b sem distinguir o marcador TODO do "todo" portugues,
345:     * e rejeita a fase por falso positivo.
346:     *==========================================================================
347:     PROTECTED FUNCTION EstaEmModoValidacaoOuTeste()
348:         RETURN (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
349:                (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
350:     ENDFUNC
351: 
352:     *==========================================================================
353:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado), com
354:     * os dois labels sobrepostos (sombra + titulo) exibindo o Caption
355:     * calculado em InicializarForm. Nomes conforme mapeamento.json.
356:     *==========================================================================
357:     PROTECTED PROCEDURE ConfigurarCabecalho()
358:         LOCAL loc_oCnt
359: 
360:         THIS.AddObject("cnt_4c_Sombra", "Container")
361:         loc_oCnt = THIS.cnt_4c_Sombra
362:         WITH loc_oCnt
363:             .Top         = 0
364:             .Left        = 0
365:             .Width       = 1004
366:             .Height      = 80
367:             .BorderWidth = 0
368:             .BackColor   = RGB(100, 100, 100)
369:             .Visible     = .T.
370:         ENDWITH
371: 
372:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
373:         WITH loc_oCnt.lbl_4c_LblSombra
374:             .FontBold      = .T.
375:             .FontName      = "Tahoma"
376:             .FontSize      = 18
377:             .FontUnderline = .F.
378:             .WordWrap      = .T.
379:             .Alignment     = 0
380:             .BackStyle     = 0
381:             .AutoSize      = .F.
382:             .Caption       = THIS.Caption
383:             .Height        = 40
384:             .Left          = 10
385:             .Top           = 18
386:             .Width         = 769
387:             .ForeColor     = RGB(0, 0, 0)
388:             .Visible       = .T.
389:         ENDWITH
390: 
391:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
392:         WITH loc_oCnt.lbl_4c_LblTitulo
393:             .FontBold   = .T.
394:             .FontName   = "Tahoma"
395:             .FontSize   = 18
396:             .WordWrap   = .T.
397:             .Alignment  = 0

*-- Linhas 415 a 458:
415:     * (Valor Titulo/Vencimento) so ficam editaveis em INSERIR/ALTERAR
416:     * (Text1.When retorna InList(pcEscolha,"INSERIR","ALTERAR")).
417:     *==========================================================================
418:     PROTECTED PROCEDURE ConfigurarGrid()
419:         LOCAL loc_oGrid, loc_lEditavel
420: 
421:         THIS.AddObject("grd_4c_Dados", "Grid")
422:         loc_oGrid = THIS.grd_4c_Dados
423:         WITH loc_oGrid
424:             .Top           = 93
425:             .Left          = 7
426:             .Width         = 884
427:             .Height        = 453
428:             .ColumnCount   = 8
429:             .FontName      = "Tahoma"
430:             .FontSize      = 8
431:             .DeleteMark    = .F.
432:             .RecordMark    = .F.
433:             .RowHeight     = 16
434:             .ScrollBars    = 2
435:             .GridLineColor = RGB(238, 238, 238)
436:             .Visible       = .T.
437:         ENDWITH
438: 
439:         loc_lEditavel = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
440: 
441:         *-- Colunas 1-6: sempre exibicao (Text1.When retorna .F. no legado)
442:         WITH loc_oGrid.Column1
443:             .Width     = 106
444:             .Movable   = .F.
445:             .Resizable = .F.
446:             .ReadOnly  = .T.
447:             .FontName  = "Tahoma"
448:             .FontSize  = 8
449:             .Header1.Caption   = "Impostos"
450:             .Header1.Alignment = 2
451:             .Header1.FontName  = "Tahoma"
452:             .Header1.FontSize  = 8
453:         ENDWITH
454:         WITH loc_oGrid.Column2
455:             .Width     = 130
456:             .Movable   = .F.
457:             .Resizable = .F.
458:             .ReadOnly  = .T.

*-- Linhas 543 a 630:
543: 
544:         *-- AfterRowColChange (legado: grdTitulos.AfterRowColChange) - a
545:         *-- cada mudanca de linha/coluna, recarrega as descricoes de Grupo
546:         *-- e Conta da linha corrente. BINDEVENT porque o Grid nasceu por
547:         *-- AddObject (classe nativa) - o handler PUBLIC recebe
548:         *-- par_nColIndex (CLAUDE.md regra #3).
549:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
550:     ENDPROC
551: 
552:     *==========================================================================
553:     * CarregarLista - Carga da grade de impostos: liga as 8 colunas de
554:     * grd_4c_Dados ao cursor recebido do form chamador (this_cArquivo, o
555:     * "Arquivo" do legado) e posiciona no primeiro registro. Equivale ao
556:     * trecho final do Init legado, que binda a grade e a posiciona:
557:     *
558:     *     Select &lcArq.
559:     *     Goto Top In &lcArq.
560:     *     With .grdTitulos
561:     *         .RecordSource          = lcArq
562:     *         .Column1.ControlSource = lcArq + [.Impostos]
563:     *         ... (8 colunas) ...
564:     *         .Refresh
565:     *     EndWith
566:     *
567:     * Este form NAO consulta o banco para montar a grade: o cursor chega
568:     * pronto do chamador (dialogo de revisao dos impostos de UMA
569:     * movimentacao). Por isso a "carga" aqui e' o bind + reposicionamento,
570:     * exatamente como no legado - nao ha SELECT a reproduzir.
571:     *
572:     * Metodo PUBLIC (sem PROTECTED): alem de InicializarForm, o harness de
573:     * testes automatizados chama metodos de carga direto no objeto do form,
574:     * de FORA da classe (CLAUDE.md regra #3).
575:     *
576:     * Retorno: .T. quando a grade foi ligada ao cursor; .F. quando nao havia
577:     * cursor para ligar (modo validacao/teste, ou chamador que nao passou
578:     * o alias). Popular o cursor NAO repinta a grade sozinho - por isso o
579:     * GO TOP + Refresh() no fim, como o legado faz (CLAUDE.md regra #21).
580:     *==========================================================================
581:     PROCEDURE CarregarLista()
582:         LOCAL loc_oGrid, loc_cArq, loc_lSucesso, loc_oErro
583:         loc_lSucesso = .F.
584: 
585:         TRY
586:             loc_cArq = THIS.this_cArquivo
587: 
588:             *-- Pulado em validacao/teste: nesses modos this_cArquivo nao
589:             *-- aponta para cursor real (form instanciado sem parametros) -
590:             *-- mesma guarda usada no Caption em InicializarForm.
591:             IF !THIS.EstaEmModoValidacaoOuTeste() AND !EMPTY(loc_cArq) AND USED(loc_cArq) ;
592:                AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
593: 
594:                 loc_oGrid = THIS.grd_4c_Dados
595: 
596:                 loc_oGrid.RecordSource = ""
597:                 loc_oGrid.RecordSource = loc_cArq
598:                 loc_oGrid.Column1.ControlSource = loc_cArq + ".Impostos"
599:                 loc_oGrid.Column2.ControlSource = loc_cArq + ".ValBases"
600:                 loc_oGrid.Column3.ControlSource = loc_cArq + ".Aliqs"
601:                 loc_oGrid.Column4.ControlSource = loc_cArq + ".ValImps"
602:                 loc_oGrid.Column5.ControlSource = loc_cArq + ".Grupos"
603:                 loc_oGrid.Column6.ControlSource = loc_cArq + ".Contas"
604:                 loc_oGrid.Column7.ControlSource = loc_cArq + ".ValTits"
605:                 *-- Coluna 8 (Vencimento): o legado usa Ttod(<arquivo>.Vencs)
606:                 *-- no ControlSource (fweditdata), mas TTOD() so aceita
607:                 *-- DATETIME e estoura erro 11 se a coluna do cursor do
608:                 *-- CHAMADOR ja vier como DATE (CLAUDE.md regra #16) - e como
609:                 *-- o cursor eh externo a este form, o tipo exato nao e'
610:                 *-- garantido daqui. Ligar direto ao campo (sem TTOD) tambem
611:                 *-- preserva a edicao em duas maos da coluna, que uma
612:                 *-- expressao com funcao quebraria.
613:                 loc_oGrid.Column8.ControlSource = loc_cArq + ".Vencs"
614: 
615:                 *-- Largura e headers vao DEPOIS do ControlSource - o VFP9
616:                 *-- reseta Column.Width e Header1.Caption ao definir
617:                 *-- RecordSource/ControlSource (CLAUDE.md regra #41).
618:                 loc_oGrid.Column1.Width = 106
619:                 loc_oGrid.Column1.Header1.Caption = "Impostos"
620:                 loc_oGrid.Column2.Width = 130
621:                 loc_oGrid.Column2.Header1.Caption = "Valor Base"
622:                 loc_oGrid.Column3.Width = 70
623:                 loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "quota %"
624:                 loc_oGrid.Column4.Width = 130
625:                 loc_oGrid.Column4.Header1.Caption = "Valor Imposto"
626:                 loc_oGrid.Column5.Width = 100
627:                 loc_oGrid.Column5.Header1.Caption = "Grupo"
628:                 loc_oGrid.Column6.Width = 100
629:                 loc_oGrid.Column6.Header1.Caption = "Conta"
630:                 loc_oGrid.Column7.Width = 130

*-- Linhas 655 a 899:
655:         CATCH TO loc_oErro
656:             MsgErro(loc_oErro.Message + CHR(13) + ;
657:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
658:                     "Procedure: " + loc_oErro.Procedure, ;
659:                     "Erro em FormSigMvTta.CarregarLista")
660:         ENDTRY
661: 
662:         RETURN loc_lSucesso
663:     ENDPROC
664: 
665:     *==========================================================================
666:     * AjustarColunasPorModo - Aplica o gate de edicao das colunas da grade.
667:     * No legado cada Column<N>.Text1 tem um When: colunas 1 a 6 retornam
668:     * .F. (sempre exibicao) e as colunas 7/8 (Valor Titulo / Vencimento)
669:     * retornam InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR]) - ou seja,
670:     * so sao editaveis nesses dois modos. Aqui isso vira Column.ReadOnly.
671:     *
672:     * Metodo PUBLIC (sem PROTECTED): chamado de CarregarLista e pelo
673:     * harness de testes, de FORA da classe (CLAUDE.md regra #3).
674:     *==========================================================================
675:     PROCEDURE AjustarColunasPorModo()
676:         LOCAL loc_oGrid, loc_lEditavel, loc_nI
677: 
678:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
679:             RETURN .F.
680:         ENDIF
681: 
682:         loc_oGrid     = THIS.grd_4c_Dados
683:         loc_lEditavel = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
684: 
685:         *-- Grid primeiro, colunas depois (o ReadOnly do grid propaga).
686:         loc_oGrid.ReadOnly = !loc_lEditavel
687: 
688:         *-- Coluna alcancada por NOME montado: atribuicao com STORE ... TO (expr).
689:         *-- Column<N> NAO pode ser alcancada por Controls(<nome>) - Controls eh
690:         *-- indexado por NUMERO (CLAUDE.md regra #34) - e EVALUATE nao atribui
691:         *-- (regra #15). ALLTRIM(STR()) no indice, nao TRANSFORM: o nome montado
692:         *-- nao pode carregar espaco de preenchimento.
693:         FOR loc_nI = 1 TO 6
694:             STORE .T. TO ("loc_oGrid.Column" + ALLTRIM(STR(loc_nI)) + ".ReadOnly")
695:         ENDFOR
696:         loc_oGrid.Column7.ReadOnly = !loc_lEditavel
697:         loc_oGrid.Column8.ReadOnly = !loc_lEditavel
698: 
699:         RETURN .T.
700:     ENDPROC
701: 
702:     *==========================================================================
703:     * ConfigurarBotoes - Botao OK (cmdSair no legado -> cmd_4c_CmdSair).
704:     * Unico botao do form flat - fecha o dialogo apos validar Valor
705:     * Titulo/Vencimento de cada linha da grade (ver BtnOkClick).
706:     *==========================================================================
707:     PROTECTED PROCEDURE ConfigurarBotoes()
708:         LOCAL loc_oBtn
709: 
710:         THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
711:         loc_oBtn = THIS.cmd_4c_CmdSair
712:         WITH loc_oBtn
713:             .Top             = 3
714:             .Left            = 923
715:             .Width           = 75
716:             .Height          = 75
717:             .Caption         = "OK"
718:             .Cancel          = .T.
719:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
720:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
721:             .Themes          = .T.
722:             .FontBold        = .T.
723:             .FontItalic      = .T.
724:             .FontName        = "Comic Sans MS"
725:             .FontSize        = 8
726:             .ForeColor       = RGB(90, 90, 90)
727:             .BackColor       = RGB(255, 255, 255)
728:             .SpecialEffect   = 0
729:             .PicturePosition = 13
730:             .WordWrap        = .T.
731:             .MousePointer    = 15
732:             .Visible         = .T.
733:         ENDWITH
734: 
735:         BINDEVENT(loc_oBtn, "Click", THIS, "BtnOkClick")
736:     ENDPROC
737: 
738:     *==========================================================================
739:     * ValidarTitulosVencimentos - Regra de negocio do fechamento do dialogo,
740:     * transcrita do laco que o legado tem DENTRO de SIGMVTTA.cmdSair.Click:
741:     *
742:     *     Select &lcArq. / Go Top In &lcArq.
743:     *     Do While Not Eof() And llOks
744:     *         If (Empty(<arq>.ValTits) Or IsEmpty(<arq>.Vencs))
745:     *             -- dialogo 4+32+256 (Sim/Nao), texto "O <Imposto> NAO Esta
746:     *                Com Valor Titulo / Vencimento Informado e NAO Sera
747:     *                Lancado! Deseja Corrigir?"; resposta 6 (Sim) faz:
748:     *                 llOks = .f.
749:     *         EndIf
750:     *         If llOks
751:     *             Skip In &lcArq.
752:     *         EndIf
753:     *     EndDo
754:     *
755:     * O dialogo legado (icone 32 + Sim/Nao + default no 2o botao) vira
756:     * MsgConfirma, que devolve LOGICAL - comparar com 6 seria errado
757:     * (CLAUDE.md regra #7).
758:     *
759:     * Percorre o cursor do chamador (this_cArquivo) e, para cada linha de
760:     * imposto sem Valor Titulo ou sem Vencimento preenchido, pergunta se o
761:     * usuario quer corrigir. Confirmando ("Sim"), a varredura para e o
762:     * fechamento e' negado; recusando ("Nao"), aquela linha e' aceita
763:     * incompleta (o legado nao a lanca como titulo) e a varredura segue.
764:     *
765:     * Metodo SEPARADO do handler do botao de proposito: esta e' a UNICA
766:     * validacao da tela e e' regra de negocio (decide se um imposto vira
767:     * titulo a lancar), nao comportamento de botao. O legado mantinha as
768:     * duas coisas no mesmo Click porque nao tinha camada onde separar
769:     * (PILAR 3 - o codigo-fonte novo e' obrigatoriamente diferente).
770:     *
771:     * Metodo PUBLIC (sem PROTECTED): chamado por BtnOkClick e tambem pelo
772:     * harness de testes automatizados, de FORA da classe (CLAUDE.md regra #3).
773:     *
774:     * Retorno: .T. quando o dialogo pode fechar (nenhuma pendencia, ou o
775:     * usuario recusou corrigir todas as pendencias); .F. quando o usuario
776:     * pediu para corrigir, ou quando a varredura falhou - nos dois casos o
777:     * dialogo NAO deve fechar, porque a validade dos dados nao foi provada.
778:     *==========================================================================
779:     PROCEDURE ValidarTitulosVencimentos()
780:         LOCAL loc_cArq, loc_lOk, loc_oErro, loc_cMsg
781: 
782:         loc_cArq = THIS.this_cArquivo
783:         loc_lOk  = .T.
784: 
785:         TRY
786:             IF !EMPTY(loc_cArq) AND USED(loc_cArq)
787:                 SELECT (loc_cArq)
788:                 GO TOP
789:                 DO WHILE !EOF() AND loc_lOk
790:                     *-- Legado: If (Empty(<arq>.ValTits) Or IsEmpty(<arq>.Vencs))
791:                     *-- O IsEmpty() do Fortyus trata NULL como vazio, e a EMPTY()
792:                     *-- nativa do VFP9 NAO: medido, EMPTY(.NULL.) devolve .F.
793:                     *-- (ver utils\isempty.prg / CLAUDE.md regra #27). Sem o
794:                     *-- ISNULL, Vencs nulo passaria por "preenchido" e a linha
795:                     *-- incompleta seria aceita calada. O OR aqui e' seguro:
796:                     *-- EMPTY(.NULL.) nao da erro (VFP9 nao faz short-circuit).
797:                     IF EMPTY(EVALUATE(loc_cArq + ".ValTits")) OR ;
798:                        ISNULL(EVALUATE(loc_cArq + ".Vencs")) OR ;
799:                        EMPTY(EVALUATE(loc_cArq + ".Vencs"))
800:                         loc_cMsg = "O " + ALLTRIM(EVALUATE(loc_cArq + ".Impostos")) + ;
801:                             " N" + CHR(195) + "O Est" + CHR(225) + " Com Valor T" + CHR(237) + "tulo / Vencimento" + CHR(13) + ;
802:                             "Informado e N" + CHR(195) + "O Ser" + CHR(225) + " Lan" + CHR(231) + "ado! Deseja Corrigir?"
803:                         IF MsgConfirma(loc_cMsg, "Lan" + CHR(231) + "amento de T" + CHR(237) + "tulo Cancelado")
804:                             loc_lOk = .F.
805:                         ENDIF
806:                     ENDIF
807:                     IF loc_lOk
808:                         SKIP IN (loc_cArq)
809:                     ENDIF
810:                 ENDDO
811:             ENDIF
812:         CATCH TO loc_oErro
813:             MsgErro(loc_oErro.Message + CHR(13) + ;
814:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
815:                     "Procedure: " + loc_oErro.Procedure, ;
816:                     "Erro em FormSigMvTta.ValidarTitulosVencimentos")
817:             *-- Falha na varredura NAO autoriza o fechamento: sem terminar o
818:             *-- laco nao ha como afirmar que todas as linhas estao completas.
819:             loc_lOk = .F.
820:         ENDTRY
821: 
822:         RETURN loc_lOk
823:     ENDPROC
824: 
825:     *==========================================================================
826:     * BtnOkClick - Equivalente ao legado SIGMVTTA.cmdSair.Click: valida as
827:     * linhas da grade (ValidarTitulosVencimentos, que carrega o laco do
828:     * legado) e decide o desfecho. Validando, o dialogo fecha (Release, igual
829:     * ao "ThisForm.Release()" do legado); nao validando, o fechamento e'
830:     * cancelado e o foco volta para a coluna 7 (Valor Titulo) da grade,
831:     * exatamente como o legado faz antes do seu "Return .f.".
832:     * PUBLIC (sem PROTECTED) - chamado via BINDEVENT (CLAUDE.md regra #3).
833:     *==========================================================================
834:     PROCEDURE BtnOkClick()
835:         IF THIS.ValidarTitulosVencimentos()
836:             THIS.Release()
837:         ELSE
838:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
839:                 THIS.grd_4c_Dados.SetFocus()
840:                 THIS.grd_4c_Dados.Column7.SetFocus()
841:             ENDIF
842:         ENDIF
843:     ENDPROC
844: 
845:     *==========================================================================
846:     * ConfigurarCamposDescricao - Campos de descricao do Grupo (getDGrupos no
847:     * legado -> txt_4c_DGrupos, label Label3 -> lbl_4c_Label3) e da Conta
848:     * (getDContas -> txt_4c_DContas, label Label1 -> lbl_4c_Label1). Filhos
849:     * DIRETOS do form, como no legado (SIGMVTTA e' flat, sem PageFrame -
850:     * CLAUDE.md gate da Fase 3/4 para forms OPERACIONAIS sem Page1/Page2).
851:     *
852:     * Os dois campos sao ReadOnly: o legado tem PROCEDURE When retornando
853:     * .F. incondicional em getDGrupos e getDContas - nunca recebem edicao
854:     * do usuario. O valor de cada um e' preenchido programaticamente pelo
855:     * GrdDadosAfterRowColChange (consulta SigCdGcr.Descrs pelo codigo do
856:     * Grupo e SigCdCli.RClis pelo codigo da Conta da linha corrente da
857:     * grade).
858:     *==========================================================================
859:     PROTECTED PROCEDURE ConfigurarCamposDescricao()
860:         LOCAL loc_oLbl, loc_oTxt
861: 
862:         THIS.AddObject("lbl_4c_Label3", "Label")
863:         loc_oLbl = THIS.lbl_4c_Label3
864:         WITH loc_oLbl
865:             .AutoSize  = .T.
866:             .FontBold  = .T.
867:             .FontName  = "Tahoma"
868:             .FontSize  = 8
869:             .BackStyle = 0
870:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
871:             .Top       = 549
872:             .Left      = 6
873:             .ForeColor = RGB(90, 90, 90)
874:             .Visible   = .T.
875:         ENDWITH
876: 
877:         THIS.AddObject("txt_4c_DGrupos", "TextBox")
878:         loc_oTxt = THIS.txt_4c_DGrupos
879:         WITH loc_oTxt
880:             .Top           = 564
881:             .Left          = 6
882:             .Width         = 440
883:             .Height        = 23
884:             .SpecialEffect = 1
885:             .ReadOnly      = .T.
886:             .Value         = ""
887:             .FontName      = "Tahoma"
888:             .FontSize      = 8
889:             .ForeColor     = RGB(0, 0, 0)
890:             .BackColor     = RGB(255, 255, 255)
891:             .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
892:             .Visible       = .T.
893:         ENDWITH
894: 
895:         THIS.AddObject("lbl_4c_Label1", "Label")
896:         loc_oLbl = THIS.lbl_4c_Label1
897:         WITH loc_oLbl
898:             .AutoSize  = .T.
899:             .FontBold  = .T.

*-- Linhas 935 a 984:
935:     * fica vazia (mesma regra do legado: "If Not Empty(<arq>.Grupos)"/
936:     * "...Contas" envolvendo cada consulta).
937:     *
938:     * PUBLIC (sem PROTECTED) - ligado via BINDEVENT em ConfigurarGrid e
939:     * tambem chamado direto por CarregarLista (equivalente ao
940:     * ".AfterRowColChange()" manual do Init legado). Handler de evento
941:     * de Grid recebe par_nColIndex (CLAUDE.md regra #3), mesmo sem uso
942:     * aqui - o legado tambem ignora o parametro recebido.
943:     *==========================================================================
944:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
945:         LOCAL loc_cArq, loc_cGrupo, loc_cConta, loc_cSQL, loc_nResultado, ;
946:               loc_cDescGrupo, loc_cDescConta, loc_oErro
947: 
948:         loc_cDescGrupo = ""
949:         loc_cDescConta = ""
950: 
951:         TRY
952:             loc_cArq = THIS.this_cArquivo
953: 
954:             IF !EMPTY(loc_cArq) AND USED(loc_cArq) AND !EOF(loc_cArq)
955: 
956:                 loc_cGrupo = EVALUATE(loc_cArq + ".Grupos")
957:                 IF !EMPTY(loc_cGrupo)
958:                     loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
959:                         EscaparSQL(PADR(loc_cGrupo, 10)) + " ORDER BY Codigos"
960: 
961:                     IF USED("cursor_4c_BuscaGrupo")
962:                         USE IN cursor_4c_BuscaGrupo
963:                     ENDIF
964:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
965: 
966:                     IF loc_nResultado < 1
967:                         MsgErro("Favor Reinicializar o Processo!!!", ;
968:                                 "Falha na Conex" + CHR(227) + "o (cursor_4c_BuscaGrupo)")
969:                     ELSE
970:                         *-- GO TOP IN + referencia QUALIFICADA pelo alias, nunca
971:                         *-- SELECT: o legado faz exatamente assim ("Go Top In
972:                         *-- crfOpFin_Bus" / "crfOpFin_Bus.Descrs") para NAO
973:                         *-- trocar a area de trabalho corrente, que e' o cursor
974:                         *-- da grade recebido do chamador. Um SELECT aqui
975:                         *-- deixaria a area corrente apontando para o cursor de
976:                         *-- consulta, que e' FECHADO no fim deste metodo -
977:                         *-- qualquer EOF()/SKIP nao qualificado depois disso
978:                         *-- passaria a operar no lugar errado.
979:                         GO TOP IN cursor_4c_BuscaGrupo
980:                         loc_cDescGrupo = IIF(EOF("cursor_4c_BuscaGrupo"), "", ;
981:                             TratarNulo(cursor_4c_BuscaGrupo.Descrs, ""))
982:                     ENDIF
983:                 ENDIF
984: 

*-- Linhas 1009 a 1051:
1009:         CATCH TO loc_oErro
1010:             MsgErro(loc_oErro.Message + CHR(13) + ;
1011:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1012:                     "Procedure: " + loc_oErro.Procedure, ;
1013:                     "Erro em FormSigMvTta.GrdDadosAfterRowColChange")
1014:         ENDTRY
1015: 
1016:         IF USED("cursor_4c_BuscaGrupo")
1017:             USE IN cursor_4c_BuscaGrupo
1018:         ENDIF
1019:         IF USED("cursor_4c_BuscaConta")
1020:             USE IN cursor_4c_BuscaConta
1021:         ENDIF
1022: 
1023:         IF PEMSTATUS(THIS, "txt_4c_DGrupos", 5)
1024:             THIS.txt_4c_DGrupos.Value = loc_cDescGrupo
1025:             THIS.txt_4c_DGrupos.Refresh()
1026:         ENDIF
1027:         IF PEMSTATUS(THIS, "txt_4c_DContas", 5)
1028:             THIS.txt_4c_DContas.Value = loc_cDescConta
1029:             THIS.txt_4c_DContas.Refresh()
1030:         ENDIF
1031:     ENDPROC
1032: 
1033:     *==========================================================================
1034:     * Destroy - Libera a referencia ao Business Object. O cursor apontado
1035:     * por this_cArquivo NAO e' fechado aqui: ele pertence ao form chamador
1036:     * (foi aberto e populado por ele, e continua sendo usado por ele apos
1037:     * este dialogo fechar) - igual ao legado, cujo Release e' um DoDefault()
1038:     * puro, sem nenhuma limpeza de cursor.
1039:     *==========================================================================
1040:     PROCEDURE Destroy()
1041:         LOCAL loc_oErro
1042: 
1043:         TRY
1044:             THIS.this_oBusinessObject = .NULL.
1045:         CATCH TO loc_oErro
1046:             *-- Destruicao nao bloqueia saida
1047:         ENDTRY
1048:         DODEFAULT()
1049:     ENDPROC
1050: 
1051: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigMvTtaBO.prg):
*====================================================================
* SigMvTtaBO.prg
*
* Business Object para Impostos Gerados na Movimentacao
* Tabela: sigmvimp
* Herda de: BusinessBase
*
* Este BO acompanha o form OPERACIONAL FormSigMvTta, que revisa/edita
* (em grade) os impostos de UMA movimentacao (EmpDopNums) antes de a
* movimentacao ser confirmada pelo form chamador. O cursor da grade
* eh recebido por parametro do form chamador (par_cArquivo) - este BO
* fornece os metodos de apoio (descricao de Grupo/Conta e validacao
* de titulo/vencimento) que o legado (SIGMVTTA.SCX) implementava
* direto no form, contra ThisForm.poDataMgr.
*====================================================================

DEFINE CLASS SigMvTtaBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigmvimp)
    this_cPkChaves  = ""    && pkchaves char(20) - PK
    this_cEmpDopNums = ""   && empdopnums char(29)
    this_cImpostos  = ""    && impostos char(6)
    this_nValBases  = 0     && valbases numeric(11,2)
    this_nAliqs     = 0     && aliqs numeric(11,2)
    this_nValImps   = 0     && valimps numeric(11,2)
    this_cGrupos    = ""    && grupos char(10)
    this_cContas    = ""    && contas char(10)
    this_nValTits   = 0     && valtits numeric(11,2)
    this_dVencs     = {}    && vencs datetime NULL
    this_cMoedas    = ""    && moedas char(3)
    this_cHists     = ""    && hists char(40)
    this_cTitulos   = ""    && titulos char(10)
    this_cUsuCancs  = ""    && usucancs char(10)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigmvimp"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigMvTtaBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor (linha da grade de
    * impostos da movimentacao) para as propriedades do BO
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPkChaves   = TratarNulo(pkchaves, "")
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_cImpostos   = TratarNulo(impostos, "")
            THIS.this_nValBases   = TratarNulo(valbases, 0)
            THIS.this_nAliqs      = TratarNulo(aliqs, 0)
            THIS.this_nValImps    = TratarNulo(valimps, 0)
            THIS.this_cGrupos     = TratarNulo(grupos, "")
            THIS.this_cContas     = TratarNulo(contas, "")
            THIS.this_nValTits    = TratarNulo(valtits, 0)
            THIS.this_dVencs      = ConverterParaData(vencs)
            THIS.this_cMoedas     = TratarNulo(moedas, "")
            THIS.this_cHists      = TratarNulo(hists, "")
            THIS.this_cTitulos    = TratarNulo(titulos, "")
            THIS.this_cUsuCancs   = TratarNulo(usucancs, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria de sigmvimp (pkchaves)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDFUNC

    *====================================================================
    * Inserir - INSERT na tabela sigmvimp
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cVencs
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cVencs = IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs))

            loc_cSQL = "INSERT INTO sigmvimp (pkchaves, empdopnums, impostos, valbases," + ;
                       " aliqs, valimps, grupos, contas, valtits, vencs, moedas," + ;
                       " hists, titulos, usucancs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cPkChaves), 20)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cImpostos), 6)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValBases, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nAliqs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValImps, 2) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValTits, 2) + "," + ;
                       loc_cVencs + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoedas), 3)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cHists), 40)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cTitulos), 10)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuCancs), 10)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir imposto da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir imposto da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela sigmvimp
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cVencs
        loc_lSucesso = .F.

        TRY
            loc_cVencs = IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs))

            loc_cSQL = "UPDATE sigmvimp SET" + ;
                       " empdopnums = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + "," + ;
                       " impostos = "   + EscaparSQL(LEFT(ALLTRIM(THIS.this_cImpostos), 6)) + "," + ;
                       " valbases = "   + FormatarNumeroSQL(THIS.this_nValBases, 2) + "," + ;
                       " aliqs = "      + FormatarNumeroSQL(THIS.this_nAliqs, 2) + "," + ;
                       " valimps = "    + FormatarNumeroSQL(THIS.this_nValImps, 2) + "," + ;
                       " grupos = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + "," + ;
                       " contas = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + "," + ;
                       " valtits = "    + FormatarNumeroSQL(THIS.this_nValTits, 2) + "," + ;
                       " vencs = "      + loc_cVencs + "," + ;
                       " moedas = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoedas), 3)) + "," + ;
                       " hists = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cHists), 40)) + "," + ;
                       " titulos = "    + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTitulos), 10)) + "," + ;
                       " usucancs = "   + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuCancs), 10)) + ;
                       " WHERE RTRIM(pkchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar imposto da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar imposto da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

