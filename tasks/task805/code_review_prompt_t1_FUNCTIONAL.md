# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 1 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [METODO-INEXISTENTE] Metodo 'THIS.Value()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Caption()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ResolverCelulaSpr()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH .grdProdutos define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: .grdProdutos.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).
- [LAYOUT-POSITION] Controle 'cnpProcessando' (parent: SIGOPSPR): Top original=300 vs migrado 'cnt_4c_CnpProcessando' Top=500 (diff=200px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSpr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2756 linhas total):

*-- Linhas 36 a 151:
36: *
37: * CHAMADA (equivale ao "Do Form SigOpSpr With ThisForm" do legado, onde
38: * o proprio form pai eh "poForm"):
39: *   loForm = CREATEOBJECT("FormSigOpSpr", THISFORM)
40: *   IF VARTYPE(loForm) = "O"
41: *       loForm.Show()          && modal: so volta quando o dialogo fecha
42: *   ENDIF
43: *
44: *   Como no legado, o Release eh do PROPRIO dialogo (btnSair.Click -
45: *   fase 7), nao do chamador. O resultado fica inteiramente no cursor
46: *   local do pai (cursor_4c_Produtos) - nao ha propriedade de retorno
47: *   como MoedaMaior/CanceladoExterno em FormSigOpSlc.prg.
48: *
49: * PARAMETRO (legado: LParameters poForm)
50: *   par_oFormPai - legado: poForm/ThisForm.ParentForm (RESERVED3/ClassInfo
51: *                  do SCX cita "parentform" e "podatamgr" como properties
52: *                  customizadas do form). O form pai precisa expor:
53: *                    .pcEscolha      - INSERIR/ALTERAR/PROCURAR (visibilidade)
54: *                    .Name           - usado em UPPER(.Name) = "SIGCDBAL"
55: *                    .DataSessionId  - legado: Set DataSession To
56: *                    .loFil.<Faixa>I/F - filtros herdados (fase 4+)
57: *                    .poDataMgr      - conexao/SqlExecute do pai (fase 6+)
58: *
59: * FASE 3: estrutura base do form - DEFINE CLASS com as
60: * propriedades visuais transcritas do SCX, a propriedade de estado
61: * this_oFormPai (espelho do poForm/ParentForm do Init legado), Init com o
62: * parametro, ValidarParametros, InicializarForm, CarregarContextoFormPai
63: * (migra o contexto do pai para o BO, equivalente a "Set DataSession To
64: * poForm.DataSessionId" + leitura de pcEscolha/Name/loFil), ConfigurarDecoracao
65: * (Picture), ConfigurarCabecalho (cntSombra), TornarControlesVisiveis e
66: * Destroy (reabilita o form pai - legado: .ParentForm.Enabled = .f. no
67: * Init / = .t. no btnSair.Click; aqui a reabilitacao tambem fica como
68: * rede de seguranca no Destroy).
69: *
70: * FASE 4 (esta fase): grdProdutos -> grd_4c_Dados (ConfigurarGrade +
71: * AplicarFormatoGrade), os CommandGroup cmg_4c_CmdEscolha (Inserir/
72: * Excluir) e cmg_4c_CmdSalva (Encerrar) com as barrinhas img_4c_ImgBarra1/
73: * img_4c_ImgBarra2 (ConfigurarBotoesAcao), a visibilidade condicional de
74: * cmdEscolha (AplicarVisibilidadePorContexto) e o FUNIL de carga da grade
75: * (CarregarDados + GarantirLinhaEmBranco), que transcreve o bloco do Init
76: * legado: Go Top + RecordSource/ControlSource + linha em branco no fim +
77: * Refresh. Os botoes sao criados DEPOIS do cabecalho (regra #11 do
78: * CLAUDE.md: cmdEscolha/cmdSalva/cmdProcessar ficam em Top = -1..84,
79: * dentro da faixa Top 0..80, e tem de ser criados depois dela para
80: * desenhar por cima). Os Click dos botoes sao da fase 7.
81: *
82: * FASE 5 (esta fase): cmg_4c_CmdProcessar (3 botoes de lote - btnEstI/
83: * btnEst/btnGeral), txt_4c_Dias/lbl_4c_LblDias (getDias/lblDias) e
84: * cnt_4c_CnpProcessando ("Selecionando Produtos..." - legado posiciona em
85: * Top = 500 ao final do Init, nao no Top = 300 do dump; NAO eh um toggle
86: * de Visible (fica sempre Visible = .T.) e por isso nao entra no filtro de
87: * TornarControlesVisiveis - so sobe para Top = 120 durante o processamento,
88: * fase 8). Tambem a visibilidade condicional do Init legado que faltava
89: * (cmdProcessar/lblDias/getDias.Visible = InList(pcEscolha,INSERIR,ALTERAR)
90: * And Upper(ParentForm.Name) = "SIGCDBAL"), calculada a partir do contexto
91: * ja carregado em CarregarContextoFormPai (fase 3).
92: *
93: * FASE 6: lookup de produto nas duas colunas da grade (Column1/
94: * Column2.Text1.Valid do legado - fwBuscaExt por CPros/DPros), nas celulas
95: * TextBoxCelulaSpr_4c instaladas por InstalarCelulasLookup. O bind do grid
96: * ao cursor_4c_Produtos ja havia sido entregue na fase 4 (CarregarDados).
97: *
98: * FASE 7 (esta fase): Click dos CommandGroup criados na fase 4 -
99: * btnInserir/btnExcluir (cmg_4c_CmdEscolha) e btnSair (cmg_4c_CmdSalva).
100: * Os Buttons(N) mantem o nome default do VFP, entao o Click deles so
101: * dispara por BINDEVENT (ConfigurarEventosBotoes). Entregues:
102: * BtnInserirClick (reusa PosicionarProximaLinha, da fase 6 - o bloco
103: * "Select LocalBrancos -> Locate / Append Blank" do legado),
104: * BtnExcluirClick (Delete + Skip/Skip -1 na linha corrente),
105: * RemoverLinhasEmBranco (o "Delete From crProdutos Where Empty(CPros)",
106: * que o Click de cmdProcessar tambem usa) e BtnEncerrarClick (limpa as
107: * linhas em branco, reabilita o form pai e fecha o dialogo), mais a cauda
108: * comum FocarGradeProdutos (Column1.SetFocus + Refresh).
109: *
110: * FASE 8 (esta fase): Click de cmg_4c_CmdProcessar (os 3 botoes de lote -
111: * BtnProcessarLoteClick), unico "PROCEDURE Click" do CommandGroup no
112: * legado, despachado por This.Value (1/2/3), diferente do par
113: * btnInserir/btnExcluir de cmg_4c_CmdEscolha (fase 7), que tem um Click por
114: * botao. Usa THIS.this_oBusinessObject.ObterProdutosEmLote (ja
115: * implementado no BO) e faz o SCAN + Insert no cursor_4c_Produtos do pai
116: * aqui no Form, que eh manipulacao de cursor VFP (ver cabecalho de
117: * SigOpSprBO.prg). Esta eh a FASE FINAL do form - nao ha metodos
118: * "BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
119: * CarregarLista" porque este dialogo nao eh CRUD (nao tem entidade propria
120: * para persistir nem modos Incluir/Alterar/Visualizar): toda a gravacao
121: * final eh do form PAI, no cursor local que ele mesmo abriu antes do
122: * "Do Form SigOpSpr With ThisForm". Os equivalentes deste dialogo sao:
123: * BtnEncerrarClick (saida/"confirmar", fase 7), BtnInserirClick/
124: * BtnExcluirClick (edicao de linha, fase 7) e CarregarDados (funil de
125: * carga da grade, fase 4).
126: *==============================================================================
127: 
128: DEFINE CLASS FormSigOpSpr AS FormBase
129: 
130:     *==========================================================================
131:     * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
132:     *==========================================================================
133: 
134:     *-- SIGOPSPR: Height = 600 / Width = 800
135:     this_cMensagemErro = ""
136:     Height       = 600
137:     Width        = 800
138: 
139:     *-- BorderStyle = 2 (Sizable) / AutoCenter = .T. / ShowTips = .T.
140:     BorderStyle  = 2
141:     AutoCenter   = .T.
142:     ShowTips     = .T.
143: 
144:     *-- Caption = "Selecionar Produtos" no SCX legado. O Init legado copia
145:     *-- ThisForm.Caption para os dois labels do cabecalho (transcrito em
146:     *-- ConfigurarCabecalho, abaixo)
147:     Caption      = "Selecionar Produtos"
148: 
149:     *-- TitleBar = 0 / ControlBox = .F. (legado) -> Closable/MaxButton/
150:     *-- MinButton = .F. (padrao do projeto para dialogo sem chrome, ja
151:     *-- usado em FormSigOpSlc.prg) / Movable = .F. / ClipControls = .F. -

*-- Linhas 198 a 409:
198:     *-- reentrancia da regra #47 existe para lookup ligado a LostFocus, que
199:     *-- o Show() MODAL do picker redispara. Estas celulas usam Valid (regra
200:     *-- #46), que o VFP9 nao re-entra enquanto ja esta executando, e o
201:     *-- contrato do FormBuscaAuxiliar (regra #37) fecha o unico caminho de
202:     *-- picker duplo: resolvido o codigo, a passagem seguinte pelo Valid
203:     *-- acha 1 registro no match exato, marca this_lAchouRegistro e NAO
204:     *-- mostra o dialogo. Uma flag aqui seria pior que a ausencia dela: sem
205:     *-- TRY em volta do Show() (regra #29 - TRY em volta de Show modal
206:     *-- derruba a tela a cada erro de runtime) nao ha como garantir o clear,
207:     *-- e flag travada MATA o lookup pelo resto da vida do form. Mesma
208:     *-- escolha das duas implementacoes de referencia do projeto
209:     *-- (TextBoxCelulaSno_4c/FormSigOpSno e FormLpr).
210: 
211:     *==========================================================================
212:     * Init - LParameters poForm do legado
213:     *==========================================================================
214:     PROCEDURE Init
215:         LPARAMETERS par_oFormPai
216: 
217:         *-- Legado: ThisForm.ParentForm = _Parent (poForm)
218:         IF VARTYPE(par_oFormPai) = "O"
219:             THIS.this_oFormPai = par_oFormPai
220:         ENDIF
221: 
222:         RETURN DODEFAULT()
223:     ENDPROC
224: 
225:     *==========================================================================
226:     * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
227:     * cursor_4c_Produtos para editar, nem contexto (pcEscolha/Name/loFil)
228:     * para decidir o que fica visivel - o legado tambem depende dessa
229:     * referencia (ThisForm.ParentForm.* em praticamente todo metodo).
230:     *
231:     * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
232:     * de fora, e PROTECTED faria a chamada externa estourar em runtime.
233:     *
234:     * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
235:     * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
236:     * bypass a instanciacao reprovaria sempre.
237:     *
238:     * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
239:     * bloco algum.
240:     *==========================================================================
241:     PROCEDURE ValidarParametros
242:         LOCAL loc_lValido
243:         loc_lValido = .T.
244: 
245:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
246:             RETURN .T.
247:         ENDIF
248: 
249:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
250:             RETURN .T.
251:         ENDIF
252: 
253:         IF VARTYPE(THIS.this_oFormPai) != "O"
254:             MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir de " + ;
255:                     "outro formul" + CHR(225) + "rio.", ;
256:                     "Selecionar Produtos")
257:             loc_lValido = .F.
258:         ENDIF
259: 
260:         RETURN loc_lValido
261:     ENDPROC
262: 
263:     *==========================================================================
264:     * InicializarForm - estrutura base do dialogo
265:     *
266:     * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
267:     * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
268:     *==========================================================================
269:     PROTECTED PROCEDURE InicializarForm
270:         LOCAL loc_lSucesso, loc_oErro
271:         loc_lSucesso = .F.
272: 
273:         *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
274:         *-- dentro de TRY/CATCH (regra #1)
275:         IF !THIS.ValidarParametros()
276:             RETURN .F.
277:         ENDIF
278: 
279:         TRY
280:             *-- Business Object das Fases 1-2
281:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpSprBO")
282: 
283:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
284:                 MsgErro("Falha ao criar SigOpSprBO.", "Selecionar Produtos")
285:             ELSE
286:                 *-- Legado: .ParentForm.Enabled = .f. (Init) - migra o
287:                 *-- contexto do pai (pcEscolha/Name/loFil) para o BO
288:                 THIS.CarregarContextoFormPai()
289: 
290:                 *-- Fundo do form (Picture do SCX)
291:                 THIS.ConfigurarDecoracao()
292: 
293:                 *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
294:                 *-- AddObject do form: os CommandGroup (fase 4+) ficam em
295:                 *-- Top = -1..84, DENTRO da faixa (Top 0..80), e precisam
296:                 *-- ser criados depois para desenhar por cima (regra #11)
297:                 THIS.ConfigurarCabecalho()
298: 
299:                 *-- Grade de produtos (grdProdutos do legado)
300:                 THIS.ConfigurarGrade()
301: 
302:                 *-- Inserir/Excluir (cmdEscolha) e Encerrar (cmdSalva). Vem
303:                 *-- DEPOIS do cabecalho porque ficam em Top = -1..84, dentro
304:                 *-- da faixa (Top 0..80), e precisam desenhar por cima dela
305:                 THIS.ConfigurarBotoesAcao()
306: 
307:                 *-- cmdProcessar (os 3 botoes de lote) - mesma razao do
308:                 *-- ConfigurarBotoesAcao: Top = -1, dentro da faixa
309:                 THIS.ConfigurarBotoesLote()
310: 
311:                 *-- getDias/lblDias (parametro "Dias a Considerar")
312:                 THIS.ConfigurarDias()
313: 
314:                 *-- Container "Selecionando Produtos..." (cnpProcessando)
315:                 THIS.ConfigurarProcessando()
316: 
317:                 *-- Click dos botoes dos CommandGroup. Depois de todos os
318:                 *-- AddObject, para os Buttons(N) existirem no momento do
319:                 *-- BINDEVENT
320:                 THIS.ConfigurarEventosBotoes()
321: 
322:                 *-- AddObject cria controle com Visible = .F.
323:                 THIS.TornarControlesVisiveis()
324: 
325:                 *-- Visibilidade condicional do Init legado - DEPOIS do
326:                 *-- TornarControlesVisiveis, que forca Visible = .T. em tudo
327:                 THIS.AplicarVisibilidadePorContexto()
328: 
329:                 *-- Funil de carga: liga a grade ao cursor de produtos do
330:                 *-- form pai e a repinta. Devolve .F. sem o cursor aberto
331:                 *-- (caminho normal do harness), o que nao impede a abertura
332:                 THIS.CarregarDados()
333: 
334:                 *-- Legado: This.Refresh (equivalente ao fim do Init)
335:                 THIS.Refresh()
336: 
337:                 loc_lSucesso = .T.
338:             ENDIF
339: 
340:         CATCH TO loc_oErro
341:             THIS.this_cMensagemErro = loc_oErro.Message
342:             MsgErro("Erro ao inicializar FormSigOpSpr: " + loc_oErro.Message + ;
343:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
344:                     " | Proc: " + loc_oErro.Procedure, "Erro")
345:             loc_lSucesso = .F.
346:         ENDTRY
347: 
348:         RETURN loc_lSucesso
349:     ENDPROC
350: 
351:     *==========================================================================
352:     * CarregarContextoFormPai - migra para o BO o que o Init legado le do
353:     * form pai:
354:     *
355:     *     Set DataSession To poForm.DataSessionId   (ver nota de
356:     *                                                 DataSession = 1, acima)
357:     *     .ParentForm = poForm
358:     *     .ParentForm.Enabled = .f.
359:     *     <pcEscolha, Upper(Name), loFil.*>          (usados na fase 5 para
360:     *                                                 decidir visibilidade,
361:     *                                                 e na fase 8 para o
362:     *                                                 processamento em lote)
363:     *
364:     * Cada leitura eh protegida por PEMSTATUS/VARTYPE: em modo teste
365:     * (gb_4c_ModoTeste/gb_4c_ValidandoUI) o form pai pode ser .NULL. ou um
366:     * stub sem essas properties, e a ausencia aqui NAO eh falha de
367:     * inicializacao (ValidarParametros ja fez o bypass acima).
368:     *==========================================================================
369:     PROTECTED PROCEDURE CarregarContextoFormPai
370:         LOCAL loc_oFil
371: 
372:         IF VARTYPE(THIS.this_oFormPai) != "O"
373:             RETURN
374:         ENDIF
375: 
376:         *-- Legado: .ParentForm.Enabled = .f. (reabilitado no Destroy -
377:         *-- rede de seguranca - e no btnSair.Click, fase 7)
378:         IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
379:             THIS.this_oFormPai.Enabled = .F.
380:         ENDIF
381: 
382:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
383:             RETURN
384:         ENDIF
385: 
386:         WITH THIS.this_oBusinessObject
387:             *-- Legado: InList(.ParentForm.pcEscolha, [INSERIR], [ALTERAR])
388:             IF PEMSTATUS(THIS.this_oFormPai, "pcEscolha", 5) AND ;
389:                VARTYPE(THIS.this_oFormPai.pcEscolha) = "C"
390:                 .this_cEscolha = UPPER(ALLTRIM(THIS.this_oFormPai.pcEscolha))
391:             ENDIF
392: 
393:             *-- Legado: Upper(ParentForm.Name) = [SIGCDBAL]
394:             .this_cNomeFormPai = UPPER(ALLTRIM(THIS.this_oFormPai.Name))
395: 
396:             IF PEMSTATUS(THIS.this_oFormPai, "DataSessionId", 5) AND ;
397:                VARTYPE(THIS.this_oFormPai.DataSessionId) = "N"
398:                 .this_nDataSessionPai = THIS.this_oFormPai.DataSessionId
399:             ENDIF
400: 
401:             *-- Legado: ThisForm.ParentForm.loFil.<Faixa>I/F (cmdProcessar.Click)
402:             IF PEMSTATUS(THIS.this_oFormPai, "loFil", 5) AND ;
403:                VARTYPE(THIS.this_oFormPai.loFil) = "O"
404:                 loc_oFil = THIS.this_oFormPai.loFil
405: 
406:                 IF VARTYPE(loc_oFil.MercsI) = "C"
407:                     .this_cMercsI = ALLTRIM(loc_oFil.MercsI)
408:                 ENDIF
409:                 IF VARTYPE(loc_oFil.MercsF) = "C"

*-- Linhas 446 a 610:
446:     *==========================================================================
447:     * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
448:     *==========================================================================
449:     PROTECTED PROCEDURE ConfigurarDecoracao
450:         LOCAL loc_cImagemFundo
451:         loc_cImagemFundo = ""
452: 
453:         IF TYPE("gc_4c_CaminhoIcones") = "C"
454:             loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
455:         ENDIF
456: 
457:         IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
458:             THIS.Picture = loc_cImagemFundo
459:         ENDIF
460:     ENDPROC
461: 
462:     *==========================================================================
463:     * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
464:     *
465:     * Legado:
466:     *   cntSombra  Top=0  Left=0  Width=800  Height=80  BorderWidth=0
467:     *              BackColor=100,100,100
468:     *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
469:     *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
470:     *              Alignment=0, BackStyle=0
471:     *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
472:     *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
473:     *
474:     * O Init legado sobrescreve os dois Caption com ThisForm.Caption
475:     * ("Selecionar Produtos"), por isso .Caption = THIS.Caption (dinamico),
476:     * nao o literal "Cadastro de Testes" que aparece no dump (esse literal
477:     * eh so o default do Form Designer, nunca chega a ser exibido).
478:     *
479:     * Width do container usa THIS.Width (canonico da faixa, regra #11) em
480:     * vez do literal 800 - sao o mesmo valor aqui, mas THIS.Width acompanha
481:     * o form se o layout mudar numa fase futura.
482:     *
483:     * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
484:     * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
485:     * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form Designer.
486:     *==========================================================================
487:     PROTECTED PROCEDURE ConfigurarCabecalho
488:         *-- Container da faixa (cntSombra)
489:         THIS.AddObject("cnt_4c_Sombra", "Container")
490:         WITH THIS.cnt_4c_Sombra
491:             .Top           = 0
492:             .Left          = 0
493:             .Width         = THIS.Width
494:             .Height        = 80
495:             .BorderWidth   = 0
496:             .BackStyle     = 1
497:             .BackColor     = RGB(100, 100, 100)
498:             .SpecialEffect = 0
499:             .Visible       = .T.
500:         ENDWITH
501: 
502:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
503:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
504:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
505:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
506:             .AutoSize      = .F.
507:             .FontBold      = .T.
508:             .FontName      = "Tahoma"
509:             .FontSize      = 18
510:             .FontUnderline = .F.
511:             .WordWrap      = .T.
512:             .Alignment     = 0
513:             .BackStyle     = 0
514:             .Caption       = THIS.Caption
515:             .Top           = 18
516:             .Left          = 10
517:             .Width         = 769
518:             .Height        = 40
519:             .ForeColor     = RGB(0, 0, 0)
520:             .Rotation      = 0
521:             .Visible       = .T.
522:         ENDWITH
523: 
524:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
525:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
526:         *-- regra #12)
527:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
528:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
529:             .AutoSize    = .F.
530:             .FontBold    = .T.
531:             .FontName    = "Tahoma"
532:             .FontSize    = 18
533:             .WordWrap    = .T.
534:             .Alignment   = 0
535:             .BackStyle   = 0
536:             .Caption     = THIS.Caption
537:             .Top         = 17
538:             .Left        = 10
539:             .Width       = 769
540:             .Height      = 46
541:             .ForeColor   = RGB(255, 255, 255)
542:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
543:             .Rotation    = 0
544:             .Visible     = .T.
545:         ENDWITH
546: 
547:         THIS.cnt_4c_Sombra.Visible = .T.
548:     ENDPROC
549: 
550:     *==========================================================================
551:     * ConfigurarGrade - grdProdutos do legado -> grd_4c_Dados
552:     *
553:     * Transcricao do dump (SIGOPSPR.grdProdutos):
554:     *   ColumnCount=2  FontName="Tahoma"  DeleteMark=.F.  RecordMark=.F.
555:     *   HeaderHeight=17  RowHeight=17  ScrollBars=2  TabIndex=1
556:     *   Top=192  Left=190  Width=420  Height=309
557:     *   GridLineColor=238,238,238
558:     *
559:     * O grid NAO eh somente-leitura: o dump nao declara ReadOnly no Grid e
560:     * declara Column2.Text1.ReadOnly = .F. - esta eh a grade em que o
561:     * usuario DIGITA o produto (o lookup das duas colunas entra na fase 6).
562:     *
563:     * Aqui ficam SO as propriedades que NAO dependem de dado (regra #41):
564:     * geometria, ColumnCount, fontes e cores. Largura de coluna e caption de
565:     * cabecalho moram em AplicarFormatoGrade, que eh a FONTE UNICA desses
566:     * numeros e eh reusada pelo CarregarDados depois do RecordSource
567:     * (atribuir RecordSource zera Column.Width e Header1.Caption - Problema
568:     * 48 / regra #41).
569:     *==========================================================================
570:     PROTECTED PROCEDURE ConfigurarGrade
571:         THIS.AddObject("grd_4c_Dados", "Grid")
572:         WITH THIS.grd_4c_Dados
573:             .ColumnCount   = 2
574:             .FontName      = "Tahoma"
575:             .FontSize      = 8
576:             .DeleteMark    = .F.
577:             .RecordMark    = .F.
578:             .HeaderHeight  = 17
579:             .RowHeight     = 17
580:             .ScrollBars    = 2
581:             .GridLineColor = RGB(238, 238, 238)
582:             .Top           = 192
583:             .Left          = 190
584:             .Width         = 420
585:             .Height        = 309
586:             .TabIndex      = 1
587:             .ReadOnly      = .F.
588:             .Visible       = .T.
589:         ENDWITH
590: 
591:         *-- Column.ReadOnly vai DEPOIS do Grid.ReadOnly (o do grid propaga
592:         *-- para as colunas e sobrescreveria o que viesse antes - regra #18)
593:         THIS.AplicarFormatoGrade()
594:     ENDPROC
595: 
596:     *==========================================================================
597:     * AplicarFormatoGrade - FONTE UNICA da geometria/decoracao das colunas
598:     *
599:     * Transcrito do dump:
600:     *   Column1  Width=108  Movable=.F.  Resizable=.F.  FontName="Tahoma"
601:     *            Header1: Tahoma 8, Alignment=2, Caption="Codigo",
602:     *                     ForeColor=36,84,155
603:     *            Text1:   Tahoma, BorderStyle=0, Margin=0,
604:     *                     ForeColor=0,0,0, BackColor=255,255,255
605:     *   Column2  Width=290  FontName="Tahoma"   (o dump NAO declara
606:     *            Movable/Resizable nesta coluna - ficam no default .T.)
607:     *            Header1: Tahoma 8, Alignment=2, Caption="Descricao",
608:     *                     ForeColor=36,84,155
609:     *            Text1:   Tahoma, BorderStyle=0, Margin=0, ReadOnly=.F.,
610:     *                     ForeColor=0,0,0, BackColor=255,255,255

*-- Linhas 618 a 661:
618:     * Metodo PUBLIC: o form pai pode reaplicar o formato depois de repopular
619:     * o proprio cursor de produtos.
620:     *==========================================================================
621:     PROCEDURE AplicarFormatoGrade
622:         LOCAL loc_lAplicou
623:         loc_lAplicou = .F.
624: 
625:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
626:             WITH THIS.grd_4c_Dados
627:                 .Column1.Width             = 108
628:                 .Column1.Movable           = .F.
629:                 .Column1.Resizable         = .F.
630:                 .Column1.FontName          = "Tahoma"
631:                 .Column1.FontSize          = 8
632:                 .Column1.ReadOnly          = .F.
633:                 .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
634:                 .Column1.Header1.FontName  = "Tahoma"
635:                 .Column1.Header1.FontSize  = 8
636:                 .Column1.Header1.Alignment = 2
637:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
638:                 .Column1.Text1.FontName    = "Tahoma"
639:                 .Column1.Text1.FontSize    = 8
640:                 .Column1.Text1.BorderStyle = 0
641:                 .Column1.Text1.Margin      = 0
642:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
643:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
644: 
645:                 .Column2.Width             = 290
646:                 .Column2.FontName          = "Tahoma"
647:                 .Column2.FontSize          = 8
648:                 .Column2.ReadOnly          = .F.
649:                 .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
650:                 .Column2.Header1.FontName  = "Tahoma"
651:                 .Column2.Header1.FontSize  = 8
652:                 .Column2.Header1.Alignment = 2
653:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
654:                 .Column2.Text1.FontName    = "Tahoma"
655:                 .Column2.Text1.FontSize    = 8
656:                 .Column2.Text1.BorderStyle = 0
657:                 .Column2.Text1.Margin      = 0
658:                 .Column2.Text1.ReadOnly    = .F.
659:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
660:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
661:             ENDWITH

*-- Linhas 679 a 750:
679:     *
680:     * Legado: o lookup mora no Valid de grdProdutos.Column1.Text1 (busca por
681:     * CPros) e de grdProdutos.Column2.Text1 (busca por DPros), com o When de
682:     * cada um controlando se a celula aceita edicao. BINDEVENT em When/Valid
683:     * de Column.Text1 NAO eh confiavel (regra #46), por isso os eventos moram
684:     * na classe da celula, que delega para os metodos PUBLIC deste form.
685:     *
686:     * As TRES linhas sao obrigatorias para o controle APARECER e aceitar
687:     * clique (regra #18):
688:     *   AddObject      - cria o controle (que a Column NAO desenha sozinha:
689:     *                    ela segue pintando o Text1 dela)
690:     *   CurrentControl - diz a Column qual controle desenhar
691:     *   Sparse = .F.   - senao o controle so aparece na linha ATIVA
692:     * E o Column.ReadOnly vai DEPOIS do Grid.ReadOnly (o do grid propaga para
693:     * as colunas e sobrescreveria o que viesse antes) - este metodo eh
694:     * chamado no fim de AplicarFormatoGrade, que por sua vez roda depois do
695:     * bloco que define Grid.ReadOnly em ConfigurarGrade.
696:     *
697:     * IDEMPOTENTE: o AddObject so acontece quando o controle ainda nao
698:     * existe (um segundo AddObject com o mesmo nome estoura "Object is
699:     * already defined"), mas CurrentControl/Sparse/ReadOnly sao reaplicados
700:     * sempre - eh exatamente isso que o rebind do RecordSource derruba. O
701:     * re-AddObject protegido tambem cobre o caso de a Column perder os
702:     * controles quando o alias ligado a ela eh fechado e reaberto.
703:     *
704:     * MaxLength vem da largura da COLUNA no schema (regra #19), nunca do
705:     * Width em pixels: SigCdPro.CPros char(14) e SigCdPro.DPros char(65).
706:     *
707:     * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
708:     * de fora para reinstalar as celulas depois de repopular o cursor.
709:     *==========================================================================
710:     PROCEDURE InstalarCelulasLookup
711:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
712:             RETURN .F.
713:         ENDIF
714: 
715:         *-- Column1 - CPros (codigo do produto)
716:         *-- O PEMSTATUS repete a expressao do WITH de proposito: .Self NAO
717:         *-- existe em VFP9 (regra #38) - compila limpo e estoura "Property
718:         *-- SELF is not found" em runtime, derrubando o Init
719:         WITH THIS.grd_4c_Dados.Column1
720:             IF !PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_Codigo", 5)
721:                 .AddObject("txt_4c_Codigo", "TextBoxCelulaSpr_4c")
722:             ENDIF
723:             .txt_4c_Codigo.this_cCelula = "CODIGO"
724:             .txt_4c_Codigo.MaxLength    = 14
725:             .CurrentControl = "txt_4c_Codigo"
726:             .Sparse         = .F.
727:             .ReadOnly       = .F.
728:         ENDWITH
729: 
730:         *-- Column2 - DPros (descricao do produto)
731:         WITH THIS.grd_4c_Dados.Column2
732:             IF !PEMSTATUS(THIS.grd_4c_Dados.Column2, "txt_4c_Descricao", 5)
733:                 .AddObject("txt_4c_Descricao", "TextBoxCelulaSpr_4c")
734:             ENDIF
735:             .txt_4c_Descricao.this_cCelula = "DESCRICAO"
736:             .txt_4c_Descricao.MaxLength    = 65
737:             .CurrentControl = "txt_4c_Descricao"
738:             .Sparse         = .F.
739:             .ReadOnly       = .F.
740:         ENDWITH
741: 
742:         RETURN .T.
743:     ENDPROC
744: 
745:     *==========================================================================
746:     * ConfigurarBotoesAcao - cmdEscolha (Inserir/Excluir) e cmdSalva
747:     * (Encerrar) do legado, mais as duas barrinhas decorativas ImgBarra1 e
748:     * ImgBarra2, que ficam entre eles na ordem de objetos do SCX.
749:     *
750:     * Criados DEPOIS de ConfigurarCabecalho: os dois CommandGroup ficam em

*-- Linhas 776 a 819:
776:     * moram em cada Buttons(N). Themes = .F. nos botoes, como no dump: o
777:     * Themes = .T. do padrao standalone NAO vale para membro de CommandGroup.
778:     *==========================================================================
779:     PROTECTED PROCEDURE ConfigurarBotoesAcao
780:         LOCAL loc_cIconeInserir, loc_cIconeExcluir, loc_cIconeSair, loc_cBarrinha
781: 
782:         loc_cIconeInserir = ""
783:         loc_cIconeExcluir = ""
784:         loc_cIconeSair    = ""
785:         loc_cBarrinha     = ""
786: 
787:         IF TYPE("gc_4c_CaminhoIcones") = "C"
788:             loc_cIconeInserir = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
789:             loc_cIconeExcluir = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
790:             loc_cIconeSair    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
791:             loc_cBarrinha     = gc_4c_CaminhoIcones + "barrinha.bmp"
792:         ENDIF
793: 
794:         *-- cmdEscolha -> cmg_4c_CmdEscolha (Inserir / Excluir)
795:         THIS.AddObject("cmg_4c_CmdEscolha", "CommandGroup")
796:         WITH THIS.cmg_4c_CmdEscolha
797:             .ButtonCount = 2
798: 
799:             *-- btnInserir ("\<Inserir": o \< marca o atalho Alt+I,
800:             *-- transcrito literal do Caption do SCX)
801:             WITH .Buttons(1)
802:                 .Caption       = "\<Inserir"
803:                 .Top           = 5
804:                 .Left          = 5
805:                 .Width         = 75
806:                 .Height        = 75
807:                 .FontName      = "Comic Sans MS"
808:                 .FontSize      = 8
809:                 .FontBold      = .T.
810:                 .FontItalic    = .T.
811:                 .WordWrap      = .T.
812:                 .AutoSize      = .F.
813:                 .SpecialEffect = 0
814:                 .ForeColor     = RGB(90, 90, 90)
815:                 .BackColor     = RGB(255, 255, 255)
816:                 .Themes        = .F.
817:                 .MousePointer  = 15
818:                 .TabIndex      = 1
819:                 .ToolTipText   = "Inserir Um Novo Produto"

*-- Linhas 873 a 916:
873: 
874:         *-- ImgBarra1: barrinha decorativa. Nasce Visible = .F. no SCX, de
875:         *-- proposito - por isso esta na lista de excecao de
876:         *-- TornarControlesVisiveis
877:         THIS.AddObject("img_4c_ImgBarra1", "Image")
878:         WITH THIS.img_4c_ImgBarra1
879:             .Top     = 109
880:             .Left    = 627
881:             .Width   = 9
882:             .Height  = 33
883:             .Stretch = 0
884: 
885:             IF !EMPTY(loc_cBarrinha) AND FILE(loc_cBarrinha)
886:                 .Picture = loc_cBarrinha
887:             ENDIF
888: 
889:             .Visible = .F.
890:         ENDWITH
891: 
892:         *-- cmdSalva -> cmg_4c_CmdSalva (Encerrar). Sem TitleBar e sem
893:         *-- ControlBox (ver propriedades do form), este botao eh a UNICA
894:         *-- saida do dialogo - o Click entra na fase 7
895:         THIS.AddObject("cmg_4c_CmdSalva", "CommandGroup")
896:         WITH THIS.cmg_4c_CmdSalva
897:             .ButtonCount = 1
898: 
899:             *-- btnSair (Cancel = .T.: eh o botao do ESC no legado)
900:             WITH .Buttons(1)
901:                 .Caption      = "Encerrar"
902:                 .Cancel       = .T.
903:                 .Top          = 5
904:                 .Left         = 5
905:                 .Width        = 75
906:                 .Height       = 75
907:                 .FontName     = "Comic Sans MS"
908:                 .FontSize     = 8
909:                 .FontBold     = .T.
910:                 .FontItalic   = .T.
911:                 .WordWrap     = .T.
912:                 .AutoSize     = .F.
913:                 .ForeColor    = RGB(90, 90, 90)
914:                 .BackColor    = RGB(255, 255, 255)
915:                 .Themes       = .F.
916:                 .MousePointer = 15

*-- Linhas 982 a 1027:
982:     *
983:     * A visibilidade real (cmdProcessar.Visible = InList(pcEscolha,
984:     * INSERIR,ALTERAR) And Upper(ParentForm.Name) = "SIGCDBAL") eh aplicada
985:     * depois de TornarControlesVisiveis, em AplicarVisibilidadePorContexto.
986:     *==========================================================================
987:     PROTECTED PROCEDURE ConfigurarBotoesLote
988:         LOCAL loc_cIconeEstI, loc_cIconeEst, loc_cIconeGeral, loc_cBarrinha
989: 
990:         loc_cIconeEstI  = ""
991:         loc_cIconeEst   = ""
992:         loc_cIconeGeral = ""
993:         loc_cBarrinha   = ""
994: 
995:         IF TYPE("gc_4c_CaminhoIcones") = "C"
996:             loc_cIconeEstI  = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
997:             loc_cIconeEst   = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
998:             loc_cIconeGeral = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
999:             loc_cBarrinha   = gc_4c_CaminhoIcones + "barrinha.bmp"
1000:         ENDIF
1001: 
1002:         THIS.AddObject("cmg_4c_CmdProcessar", "CommandGroup")
1003:         WITH THIS.cmg_4c_CmdProcessar
1004:             .ButtonCount = 3
1005: 
1006:             *-- btnEstI - "Produtos com Mov." (SigMvItn, opcao 1)
1007:             WITH .Buttons(1)
1008:                 .Caption       = "Produtos com Mov."
1009:                 .Top           = 5
1010:                 .Left          = 5
1011:                 .Width         = 75
1012:                 .Height        = 75
1013:                 .FontName      = "Comic Sans MS"
1014:                 .FontSize      = 8
1015:                 .FontBold      = .T.
1016:                 .FontItalic    = .T.
1017:                 .WordWrap      = .T.
1018:                 .AutoSize      = .F.
1019:                 .ForeColor     = RGB(90, 90, 90)
1020:                 .BackColor     = RGB(255, 255, 255)
1021:                 .Themes        = .F.
1022:                 .MousePointer  = 15
1023:                 .TabIndex      = 1
1024:                 .ToolTipText   = "Apanha Produtos Com Movimenta" + CHR(231) + ;
1025:                                  CHR(227) + "o e N" + CHR(227) + "o Inventariados"
1026: 
1027:                 IF !EMPTY(loc_cIconeEstI) AND FILE(loc_cIconeEstI)

*-- Linhas 1107 a 1270:
1107:         ENDWITH
1108: 
1109:         *-- ImgBarra3: barrinha decorativa, Visible = .F. no SCX (mesma
1110:         *-- excecao de ImgBarra1/ImgBarra2 em TornarControlesVisiveis)
1111:         THIS.AddObject("img_4c_ImgBarra3", "Image")
1112:         WITH THIS.img_4c_ImgBarra3
1113:             .Top     = 109
1114:             .Left    = 612
1115:             .Width   = 9
1116:             .Height  = 33
1117:             .Stretch = 0
1118: 
1119:             IF !EMPTY(loc_cBarrinha) AND FILE(loc_cBarrinha)
1120:                 .Picture = loc_cBarrinha
1121:             ENDIF
1122: 
1123:             .Visible = .F.
1124:         ENDWITH
1125:     ENDPROC
1126: 
1127:     *==========================================================================
1128:     * ConfigurarDias - getDias/lblDias do legado -> txt_4c_Dias/lbl_4c_LblDias
1129:     * ("Dias a Considerar" para o processamento em lote).
1130:     *
1131:     * Transcricao do dump:
1132:     *   getDias  Alignment=3 Value=0 InputMask="9999" MaxLength=4
1133:     *            Top=506 Left=236 Width=38 Height=23 TabIndex=3
1134:     *   lblDias  AutoSize=.T. FontBold=.T. FontSize=8 Alignment=0
1135:     *            Caption="Dias :" Top=511 Left=197 Width=32 Height=15
1136:     *            TabIndex=2 ForeColor=90,90,90
1137:     *
1138:     * getDias NAO tem ControlSource no dump: eh um valor de trabalho lido
1139:     * direto pelo Click de cmdProcessar (ThisForm.getDias.Value), nao uma
1140:     * coluna de tabela - por isso nao ha bind a SigOpSprBO.this_nDias aqui;
1141:     * a fase 8 (Click dos botoes de lote) le THIS.txt_4c_Dias.Value e grava
1142:     * em THIS.this_oBusinessObject.this_nDias antes de chamar
1143:     * ObterProdutosEmLote().
1144:     *
1145:     * AutoSize = .F. explicito no label (regra #23 - AutoSize eh NO-OP em
1146:     * Label criado por AddObject): Width/Height vem do dump, ja calculados
1147:     * pelo Form Designer para a legenda "Dias :".
1148:     *
1149:     * A visibilidade real (Visible = InList(pcEscolha,INSERIR,ALTERAR) And
1150:     * Upper(ParentForm.Name) = "SIGCDBAL") eh aplicada depois de
1151:     * TornarControlesVisiveis, em AplicarVisibilidadePorContexto.
1152:     *==========================================================================
1153:     PROTECTED PROCEDURE ConfigurarDias
1154:         THIS.AddObject("txt_4c_Dias", "TextBox")
1155:         WITH THIS.txt_4c_Dias
1156:             .Value        = 0
1157:             .Alignment    = 3
1158:             .InputMask    = "9999"
1159:             .MaxLength    = 4
1160:             .Top          = 506
1161:             .Left         = 236
1162:             .Width        = 38
1163:             .Height       = 23
1164:             .FontName     = "Tahoma"
1165:             .FontSize     = 8
1166:             .TabIndex     = 3
1167:             .ToolTipText  = "N" + CHR(250) + "mero de Dias a Considerar Nos " + ;
1168:                             "Produtos N" + CHR(227) + "o Inventariados"
1169:             .Visible      = .T.
1170:         ENDWITH
1171: 
1172:         THIS.AddObject("lbl_4c_LblDias", "Label")
1173:         WITH THIS.lbl_4c_LblDias
1174:             .AutoSize   = .F.
1175:             .FontBold   = .T.
1176:             .FontName   = "Tahoma"
1177:             .FontSize   = 8
1178:             .Alignment  = 0
1179:             .BackStyle  = 0
1180:             .Caption    = "Dias :"
1181:             .Top        = 511
1182:             .Left       = 197
1183:             .Width      = 32
1184:             .Height     = 15
1185:             .TabIndex   = 2
1186:             .ForeColor  = RGB(90, 90, 90)
1187:             .Visible    = .T.
1188:         ENDWITH
1189:     ENDPROC
1190: 
1191:     *==========================================================================
1192:     * ConfigurarProcessando - cnpProcessando do legado -> cnt_4c_CnpProcessando
1193:     * ("Selecionando Produtos..." - overlay exibido durante o processamento
1194:     * em lote, fase 8).
1195:     *
1196:     * Transcricao do dump:
1197:     *   cnpProcessando Top=300 Left=231 Width=345 Height=60 BorderWidth=2
1198:     *                  SpecialEffect=2 BackColor=255,255,255
1199:     *                  BorderColor=167,167,167
1200:     *     Image4 (processando.gif) Top=15 Left=13 Width=30 Height=30
1201:     *     Say1   "Selecionando Produtos..." Top=18 Left=60 Width=239
1202:     *            Height=25 Tahoma bold 14, Alignment=2 (direita),
1203:     *            ForeColor=90,90,90
1204:     *
1205:     * O Top=300 do dump e' o valor de DESENHO do Form Designer - o Init
1206:     * legado SOBRESCREVE com Top=500 ao final (depois do bloco With
1207:     * .grdProdutos), e e' esse Top=500 que fica ativo quando a tela abre.
1208:     * Nessa posicao o container cobre exatamente a faixa de getDias/lblDias
1209:     * (Top 506..529 / 511..526): o overlay troca o campo "Dias" pela
1210:     * mensagem de progresso. O Click de cmdProcessar (fase 8) sobe para
1211:     * Top=120 (sobre a grade) durante o processamento e devolve a Top=500
1212:     * ao terminar - exatamente como no legado.
1213:     *
1214:     * NAO entra no filtro de TornarControlesVisiveis: ao contrario de
1215:     * ImgBarra1/2/3, este container fica SEMPRE Visible = .T.; e' a
1216:     * POSICAO (Top), nao o Visible, que o esconde/mostra.
1217:     *==========================================================================
1218:     PROTECTED PROCEDURE ConfigurarProcessando
1219:         LOCAL loc_cImagemProcessando
1220: 
1221:         loc_cImagemProcessando = ""
1222:         IF TYPE("gc_4c_CaminhoIcones") = "C"
1223:             loc_cImagemProcessando = gc_4c_CaminhoIcones + "processando.gif"
1224:         ENDIF
1225: 
1226:         THIS.AddObject("cnt_4c_CnpProcessando", "Container")
1227:         WITH THIS.cnt_4c_CnpProcessando
1228:             .Top           = 500
1229:             .Left          = 231
1230:             .Width         = 345
1231:             .Height        = 60
1232:             .BorderWidth   = 2
1233:             .SpecialEffect = 2
1234:             .BackColor     = RGB(255, 255, 255)
1235:             .BorderColor   = RGB(167, 167, 167)
1236:             .Visible       = .T.
1237:         ENDWITH
1238: 
1239:         THIS.cnt_4c_CnpProcessando.AddObject("img_4c_Image4", "Image")
1240:         WITH THIS.cnt_4c_CnpProcessando.img_4c_Image4
1241:             .Top     = 15
1242:             .Left    = 13
1243:             .Width   = 30
1244:             .Height  = 30
1245:             .Stretch = 0
1246: 
1247:             IF !EMPTY(loc_cImagemProcessando) AND FILE(loc_cImagemProcessando)
1248:                 .Picture = loc_cImagemProcessando
1249:             ENDIF
1250: 
1251:             .Visible = .T.
1252:         ENDWITH
1253: 
1254:         THIS.cnt_4c_CnpProcessando.AddObject("lbl_4c_Label1", "Label")
1255:         WITH THIS.cnt_4c_CnpProcessando.lbl_4c_Label1
1256:             .AutoSize  = .F.
1257:             .FontBold  = .T.
1258:             .FontName  = "Tahoma"
1259:             .FontSize  = 14
1260:             .WordWrap  = .F.
1261:             .Alignment = 2
1262:             .BackStyle = 0
1263:             .Caption   = "Selecionando Produtos..."
1264:             .Top       = 18
1265:             .Left      = 60
1266:             .Width     = 239
1267:             .Height    = 25
1268:             .TabIndex  = 2
1269:             .ForeColor = RGB(90, 90, 90)
1270:             .Visible   = .T.

*-- Linhas 1286 a 1405:
1286:     * Metodo PUBLIC (regra #3): a classe da celula o alcanca indiretamente
1287:     * via CelulaSprEditavel, e o harness o chama de fora.
1288:     *==========================================================================
1289:     PROCEDURE EmModoEdicao
1290:         LOCAL loc_cEscolha
1291: 
1292:         IF VARTYPE(THIS.this_oFormPai) != "O"
1293:             RETURN .T.
1294:         ENDIF
1295: 
1296:         loc_cEscolha = ""
1297: 
1298:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1299:             loc_cEscolha = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cEscolha))
1300:         ENDIF
1301: 
1302:         RETURN INLIST(loc_cEscolha, "INSERIR", "ALTERAR")
1303:     ENDPROC
1304: 
1305:     *==========================================================================
1306:     * ObterCursorProdutos - alias do cursor LOCAL do form pai que a grade
1307:     * edita (crProdutos do legado). FONTE UNICA: o nome mora no BO
1308:     * (this_cCursorProdutos) e o default repete o canonico para o caso de o
1309:     * BO nao ter sido criado (caminho de falha de InicializarForm).
1310:     *
1311:     * Metodo PUBLIC: o form pai pode consultar qual alias este dialogo edita.
1312:     *==========================================================================
1313:     PROCEDURE ObterCursorProdutos
1314:         LOCAL loc_cCursor
1315:         loc_cCursor = "cursor_4c_Produtos"
1316: 
1317:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1318:             loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorProdutos)
1319:         ENDIF
1320: 
1321:         RETURN loc_cCursor
1322:     ENDPROC
1323: 
1324:     *==========================================================================
1325:     * ObterCursorBusca - alias do cursor de lookup de SigCdPro
1326:     * (crListaRemota do legado). Mesma razao de ObterCursorProdutos: o nome
1327:     * mora no BO (this_cCursorBusca) e o default repete o canonico.
1328:     *==========================================================================
1329:     PROCEDURE ObterCursorBusca
1330:         LOCAL loc_cCursor
1331:         loc_cCursor = "cursor_4c_BuscaProduto"
1332: 
1333:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1334:             loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorBusca)
1335:         ENDIF
1336: 
1337:         RETURN loc_cCursor
1338:     ENDPROC
1339: 
1340:     *==========================================================================
1341:     * AplicarVisibilidadePorContexto - visibilidade condicional que o Init
1342:     * legado calcula a partir do form pai:
1343:     *
1344:     *     .cmdEscolha.Visible   = InList(.ParentForm.pcEscolha, [INSERIR], [ALTERAR])
1345:     *     .cmdProcessar.Visible = InList(.ParentForm.pcEscolha, [INSERIR], [ALTERAR]) ;
1346:     *                             And (Upper(.ParentForm.Name) = [SIGCDBAL])
1347:     *     .lblDias.Visible      = <mesma expressao de cmdProcessar>
1348:     *     .getDias.Visible      = <mesma expressao de cmdProcessar>
1349:     *
1350:     * Com o pai em PROCURAR (consulta) o usuario nao pode mexer na lista: os
1351:     * botoes Inserir/Excluir somem e a tela fica so de leitura. O
1352:     * processamento em lote (cmdProcessar/lblDias/getDias) soma a essa
1353:     * mesma condicao o requisito de o form pai ser o SIGCDBAL (Balanco) -
1354:     * nos demais chamadores do dialogo esses tres controles ficam ocultos.
1355:     *
1356:     * Roda DEPOIS de TornarControlesVisiveis, que forca Visible = .T. em
1357:     * tudo que foi criado por AddObject e apagaria esta decisao.
1358:     *
1359:     * Sem form pai (harness de teste / ValidarUIFidelity, onde pcEscolha e
1360:     * Name ficam vazios) todos os controles continuam visiveis, para que a
1361:     * validacao enxergue os controles recem-criados.
1362:     *
1363:     * Metodo PUBLIC: o form pai pode reaplicar depois de trocar de modo.
1364:     *==========================================================================
1365:     PROCEDURE AplicarVisibilidadePorContexto
1366:         LOCAL loc_lEditando, loc_lLote, loc_cNomeFormPai
1367: 
1368:         loc_cNomeFormPai = ""
1369: 
1370:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1371:             loc_cNomeFormPai = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cNomeFormPai))
1372:         ENDIF
1373: 
1374:         *-- FONTE UNICA da condicao InList(pcEscolha, INSERIR, ALTERAR) - o
1375:         *-- When das duas celulas de lookup le exatamente a mesma coisa
1376:         loc_lEditando = THIS.EmModoEdicao()
1377: 
1378:         IF VARTYPE(THIS.this_oFormPai) != "O"
1379:             loc_lLote = .T.
1380:         ELSE
1381:             loc_lLote = loc_lEditando AND (loc_cNomeFormPai == "SIGCDBAL")
1382:         ENDIF
1383: 
1384:         IF PEMSTATUS(THIS, "cmg_4c_CmdEscolha", 5)
1385:             THIS.cmg_4c_CmdEscolha.Visible = loc_lEditando
1386:         ENDIF
1387: 
1388:         IF PEMSTATUS(THIS, "cmg_4c_CmdProcessar", 5)
1389:             THIS.cmg_4c_CmdProcessar.Visible = loc_lLote
1390:         ENDIF
1391: 
1392:         IF PEMSTATUS(THIS, "lbl_4c_LblDias", 5)
1393:             THIS.lbl_4c_LblDias.Visible = loc_lLote
1394:         ENDIF
1395: 
1396:         IF PEMSTATUS(THIS, "txt_4c_Dias", 5)
1397:             THIS.txt_4c_Dias.Visible = loc_lLote
1398:         ENDIF
1399: 
1400:         RETURN loc_lEditando
1401:     ENDPROC
1402: 
1403:     *==========================================================================
1404:     * CarregarDados - FUNIL de carga da grade. Transcreve o bloco do Init
1405:     * legado que liga a grade ao cursor do form PAI e a repinta:

*-- Linhas 1441 a 1645:
1441:     * Nao ha RETURN dentro de TRY/CATCH (regra #1): o resultado sai por flag
1442:     * e o unico RETURN do bloco fica depois do ENDTRY.
1443:     *==========================================================================
1444:     PROCEDURE CarregarDados
1445:         LOCAL loc_lCarregou, loc_cCursor, loc_oErro
1446:         loc_lCarregou = .F.
1447:         loc_cCursor   = THIS.ObterCursorProdutos()
1448: 
1449:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1450:             RETURN .F.
1451:         ENDIF
1452: 
1453:         IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
1454:             RETURN .F.
1455:         ENDIF
1456: 
1457:         TRY
1458:             *-- Legado: Go Top In crProdutos (antes do binding)
1459:             SELECT (loc_cCursor)
1460:             GO TOP
1461: 
1462:             WITH THIS.grd_4c_Dados
1463:                 *-- ColumnCount antes do RecordSource. Reatribuir o MESMO
1464:                 *-- valor nao recria as Column (nao ha controle posto por
1465:                 *-- Column.AddObject nesta grade a perder)
1466:                 .ColumnCount = 2
1467: 
1468:                 .RecordSource = loc_cCursor
1469: 
1470:                 *-- Column1 = CPros (codigo), Column2 = DPros (descricao)
1471:                 .Column1.ControlSource = loc_cCursor + ".CPros"
1472:                 .Column2.ControlSource = loc_cCursor + ".DPros"
1473:             ENDWITH
1474: 
1475:             *-- Rede de seguranca do Problema 48: RecordSource/ControlSource
1476:             *-- zeram Column.Width e Header1.Caption. Mesma fonte usada na
1477:             *-- montagem, entao nao ha numero duplicado aqui
1478:             THIS.AplicarFormatoGrade()
1479: 
1480:             *-- Legado: a linha em branco no fim da lista eh o que permite
1481:             *-- comecar a digitar assim que a tela abre
1482:             THIS.GarantirLinhaEmBranco()
1483: 
1484:             *-- Legado: .Refresh (o Init chama duas vezes, antes e depois do
1485:             *-- bloco da linha em branco - o efeito util eh o ultimo)
1486:             THIS.grd_4c_Dados.Refresh()
1487: 
1488:             loc_lCarregou = .T.
1489: 
1490:         CATCH TO loc_oErro
1491:             THIS.this_cMensagemErro = loc_oErro.Message
1492:             MsgErro("Erro ao carregar a grade de produtos: " + loc_oErro.Message + ;
1493:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1494:                     " | Proc: " + loc_oErro.Procedure, ;
1495:                     "Selecionar Produtos")
1496:             loc_lCarregou = .F.
1497:         ENDTRY
1498: 
1499:         RETURN loc_lCarregou
1500:     ENDPROC
1501: 
1502:     *==========================================================================
1503:     * GarantirLinhaEmBranco - transcricao do bloco do Init legado:
1504:     *
1505:     *     Select * From crProdutos Where Empty(CPros) Into Cursor LocalBrancos
1506:     *     Go Top In LocalBrancos
1507:     *     If Eof([LocalBrancos])
1508:     *         Append Blank In crProdutos
1509:     *         Go Bottom In crProdutos
1510:     *     EndIf
1511:     *
1512:     * Ou seja: se NAO existe nenhuma linha com codigo vazio, acrescenta uma,
1513:     * para o usuario ter sempre onde digitar o proximo produto. Se ja existe,
1514:     * nao mexe.
1515:     *
1516:     * O APPEND BLANK age no cursor LOCAL do form pai, nao no SQL Server:
1517:     * esta tela nao persiste nada - quem grava eh o pai, depois que o
1518:     * dialogo fecha.
1519:     *
1520:     * O mesmo bloco reaparece no btnInserir.Click do legado, com um ELSE a
1521:     * mais (Locate For Empty(CPros) quando o branco ja existe); esse handler
1522:     * eh da fase 7 e vai reusar este metodo.
1523:     *
1524:     * Metodo PUBLIC: eh chamado pelo funil de carga e, na fase 7, pelo Click
1525:     * do botao Inserir.
1526:     *==========================================================================
1527:     PROCEDURE GarantirLinhaEmBranco
1528:         LOCAL loc_lIncluiu, loc_cCursor, loc_cBrancos, loc_oErro
1529:         loc_lIncluiu = .F.
1530:         loc_cCursor  = THIS.ObterCursorProdutos()
1531:         loc_cBrancos = "cursor_4c_LinhasBrancas"
1532: 
1533:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1534:             loc_cBrancos = ALLTRIM(THIS.this_oBusinessObject.this_cCursorBrancos)
1535:         ENDIF
1536: 
1537:         IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
1538:             RETURN .F.
1539:         ENDIF
1540: 
1541:         TRY
1542:             IF USED(loc_cBrancos)
1543:                 USE IN (loc_cBrancos)
1544:             ENDIF
1545: 
1546:             SELECT * ;
1547:               FROM (loc_cCursor) ;
1548:              WHERE EMPTY(CPros) ;
1549:               INTO CURSOR (loc_cBrancos)
1550: 
1551:             GO TOP IN (loc_cBrancos)
1552: 
1553:             IF EOF(loc_cBrancos)
1554:                 SELECT (loc_cCursor)
1555:                 APPEND BLANK
1556:                 GO BOTTOM
1557:                 loc_lIncluiu = .T.
1558:             ENDIF
1559: 
1560:             IF USED(loc_cBrancos)
1561:                 USE IN (loc_cBrancos)
1562:             ENDIF
1563: 
1564:             *-- Deixa o cursor do pai como area corrente, igual ao legado
1565:             SELECT (loc_cCursor)
1566: 
1567:         CATCH TO loc_oErro
1568:             THIS.this_cMensagemErro = loc_oErro.Message
1569:             MsgErro("Erro ao preparar a linha em branco da grade: " + ;
1570:                     loc_oErro.Message + ;
1571:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1572:                     " | Proc: " + loc_oErro.Procedure, ;
1573:                     "Selecionar Produtos")
1574:             loc_lIncluiu = .F.
1575:         ENDTRY
1576: 
1577:         RETURN loc_lIncluiu
1578:     ENDPROC
1579: 
1580:     *==========================================================================
1581:     * CelulaSprEditavel - When das celulas de lookup instaladas em
1582:     * txt_4c_Codigo (Column1) e txt_4c_Descricao (Column2), chamado por
1583:     * TextBoxCelulaSpr_4c.When() (textboxgridlookup.PRG).
1584:     *
1585:     * Legado:
1586:     *   Column1.Text1.When -> Return InList(ParentForm.pcEscolha,
1587:     *                                       [INSERIR], [ALTERAR])
1588:     *   Column2.Text1.When -> Return Empty(Column1.Text1.Value) And
1589:     *                                InList(ParentForm.pcEscolha,
1590:     *                                       [INSERIR], [ALTERAR])
1591:     *
1592:     * Ou seja: a descricao SO eh digitavel enquanto o codigo da linha esta
1593:     * vazio - digitar o codigo eh o caminho principal, e a busca por
1594:     * descricao eh a alternativa para quem nao sabe o codigo.
1595:     *
1596:     * A condicao do codigo eh lida do CURSOR da grade, nao do .Value do
1597:     * controle vizinho: com Sparse = .F. os dois controles existem em todas
1598:     * as linhas, mas o valor confiavel da linha CORRENTE eh o que ja foi
1599:     * confirmado no cursor (o digitado ainda nao commitado esta no .Value da
1600:     * celula em edicao, que nunca eh esta - regra #46).
1601:     *
1602:     * Metodo PUBLIC (regra #3): a classe da celula delega via THISFORM, de
1603:     * FORA da classe do form.
1604:     *==========================================================================
1605:     PROCEDURE CelulaSprEditavel(par_cCelula, par_oTxt)
1606:         LOCAL loc_cCursor
1607: 
1608:         *-- Comum as duas celulas: com o pai em PROCURAR a tela eh so leitura
1609:         IF !THIS.EmModoEdicao()
1610:             RETURN .F.
1611:         ENDIF
1612: 
1613:         IF par_cCelula == "DESCRICAO"
1614:             loc_cCursor = THIS.ObterCursorProdutos()
1615: 
1616:             *-- Sem o cursor do pai (harness) nao ha codigo preenchido para
1617:             *-- bloquear a celula - mesmo efeito do Value vazio no legado
1618:             IF !USED(loc_cCursor)
1619:                 RETURN .T.
1620:             ENDIF
1621: 
1622:             IF EOF(loc_cCursor)
1623:                 RETURN .T.
1624:             ENDIF
1625: 
1626:             RETURN EMPTY(ALLTRIM(NVL(EVALUATE(loc_cCursor + ".CPros"), "")))
1627:         ENDIF
1628: 
1629:         RETURN .T.
1630:     ENDPROC
1631: 
1632:     *==========================================================================
1633:     * ValidarCelulaSprExec - Valid das celulas de lookup (regra #46: valida
1634:     * na saida da CELULA, nunca em AfterRowColChange, cujo nColIndex eh a
1635:     * coluna de DESTINO). Recebe o proprio TextBox porque dentro do Valid o
1636:     * valor digitado esta em par_oTxt.Value e AINDA NAO chegou ao cursor da
1637:     * grade.
1638:     *
1639:     * Legado (os dois Valid tem a mesma moldura):
1640:     *   If Not Empty(This.Value)
1641:     *       <lookup em SigCdPro + duplicidade + proxima linha>
1642:     *   Else
1643:     *       <zera a celula irma>
1644:     *   EndIf
1645:     *

*-- Linhas 1652 a 1762:
1652:     *
1653:     * Metodo PUBLIC (regra #3): a classe da celula delega via THISFORM.
1654:     *==========================================================================
1655:     PROCEDURE ValidarCelulaSprExec(par_cCelula, par_oTxt)
1656:         LOCAL loc_cValor
1657: 
1658:         IF VARTYPE(par_oTxt) != "O"
1659:             RETURN .T.
1660:         ENDIF
1661: 
1662:         loc_cValor = ALLTRIM(TRANSFORM(NVL(par_oTxt.Value, "")))
1663: 
1664:         *-- Legado (ramo Else): limpar o codigo zera a descricao, e limpar a
1665:         *-- descricao zera o codigo
1666:         IF EMPTY(loc_cValor)
1667:             THIS.LimparCelulaIrma(par_cCelula)
1668:             RETURN .T.
1669:         ENDIF
1670: 
1671:         RETURN THIS.ResolverCelulaSpr(par_cCelula, par_oTxt)
1672:     ENDPROC
1673: 
1674:     *==========================================================================
1675:     * AbrirLookupCelulaSpr - F4/F5/duplo clique (afordancia do sistema novo,
1676:     * padrao dos demais lookups de grade do projeto). O legado so tinha o
1677:     * Valid; aqui o picker tambem abre sob demanda, inclusive com a celula
1678:     * vazia, mostrando o universo inteiro de SigCdPro.
1679:     *
1680:     * Respeita o mesmo gate de edicao do When: em PROCURAR nao ha o que
1681:     * escolher, e na celula de descricao o codigo da linha tem de estar
1682:     * vazio - sem isso o F4 driblaria a regra que o When impoe.
1683:     *
1684:     * Metodo PUBLIC (regra #3): a classe da celula delega via THISFORM.
1685:     *==========================================================================
1686:     PROCEDURE AbrirLookupCelulaSpr(par_cCelula, par_oTxt)
1687:         IF VARTYPE(par_oTxt) != "O"
1688:             RETURN .F.
1689:         ENDIF
1690: 
1691:         IF !THIS.CelulaSprEditavel(par_cCelula, par_oTxt)
1692:             RETURN .F.
1693:         ENDIF
1694: 
1695:         THIS.ResolverCelulaSpr(par_cCelula, par_oTxt)
1696:         par_oTxt.Refresh()
1697: 
1698:         RETURN .T.
1699:     ENDPROC
1700: 
1701:     *==========================================================================
1702:     * ResolverCelulaSpr - corpo COMUM do Valid e do F4/F5/duplo clique.
1703:     *
1704:     * Transcricao do bloco central dos dois Valid do legado:
1705:     *
1706:     *     loLista = CreateObject('fwBuscaExt', <conn>, 'SigCdPro',
1707:     *                            'crListaRemota', 'CPros'|'DPros',
1708:     *                            Padr(This.Value, 14|40), 'Selecao', 1000)
1709:     *     If Not loLista.plAchouRegistro
1710:     *         loLista.mAddColuna(<na ordem da celula>)
1711:     *         loLista.Show()
1712:     *     EndIf
1713:     *     Column1.Text1.Value = crListaRemota.CPros
1714:     *     Column2.Text1.Value = crListaRemota.DPros
1715:     *     Use In crListaRemota
1716:     *     <duplicidade: Produto Ja Selecionado!!!>
1717:     *     <posiciona na proxima linha em branco>
1718:     *     If (Lastkey() = 13) / Keyboard '{DNARROW}' / EndIf
1719:     *
1720:     * Equivalencias e divergencias conscientes:
1721:     *
1722:     *  a) fwBuscaExt -> FormBuscaAuxiliar, cujo Init JA tenta o match EXATO e
1723:     *     resolve sozinho quando acha 1 registro (this_lAchouRegistro) - por
1724:     *     isso o Show() fica sob a guarda, exatamente como o
1725:     *     "If Not loLista.plAchouRegistro" do legado (regra #37). O valor de
1726:     *     busca vai em ALLTRIM: o Padr do legado era exigencia do fwBuscaExt,
1727:     *     e aqui o padding atrapalharia o LIKE de prefixo do Init.
1728:     *
1729:     *  b) o legado atribui as duas celulas SEM guarda de selecao, lendo
1730:     *     crListaRemota mesmo quando o usuario CANCELA o picker. Aqui a
1731:     *     atribuicao fica sob this_lSelecionou (regra #37/#50): fora dela o
1732:     *     cancelamento ZERARIA o codigo que o usuario acabou de digitar, e
1733:     *     nao haveria sequencia de teclas capaz de preencher o campo. O
1734:     *     digitado FICA e nenhuma mensagem eh exibida - universo vazio de
1735:     *     lookup nao eh erro (regra #50).
1736:     *
1737:     *  c) a checagem de duplicidade usa o CODIGO resolvido nas DUAS celulas.
1738:     *     No legado, o Valid da descricao faz "Where CPros = This.Value"
1739:     *     onde This.Value acabou de receber a DESCRICAO - compara codigo com
1740:     *     descricao e por isso nunca casa, deixando a checagem morta nesse
1741:     *     caminho (defeito HERDADO, no estilo da regra #28: transcrever ao
1742:     *     pe da letra o reproduziria). Como as duas celulas resolvem para o
1743:     *     MESMO par codigo+descricao, usar o codigo resolvido eh a leitura
1744:     *     coerente do mesmo bloco, e impede incluir o produto duas vezes
1745:     *     entrando pela descricao - que eh justamente o que esta tela existe
1746:     *     para evitar.
1747:     *
1748:     *  d) o legado grava nos .Value dos dois Text1; aqui o par resolvido vai
1749:     *     ao CURSOR por REPLACE (e so depois aos .Value - regra #46), que eh
1750:     *     o unico caminho confiavel de levar valor a coluna que NAO esta em
1751:     *     edicao. LEFT() nas larguras do schema (CPros char(14), DPros
1752:     *     char(65) - regra #19).
1753:     *
1754:     * PROTECTED: so o Valid e o F4 deste form entram aqui, sempre pelos dois
1755:     * metodos PUBLIC acima. Chamado SEMPRE com THIS. (regra #8).
1756:     *==========================================================================
1757:     PROTECTED FUNCTION ResolverCelulaSpr(par_cCelula, par_oTxt)
1758:         LOCAL loc_cCursor, loc_cCursorBusca, loc_cValor, loc_cCampoBusca
1759:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_lResolveu
1760: 
1761:         loc_cCursor      = THIS.ObterCursorProdutos()
1762:         loc_cCursorBusca = THIS.ObterCursorBusca()

*-- Linhas 1773 a 1816:
1773:             USE IN (loc_cCursorBusca)
1774:         ENDIF
1775: 
1776:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
1777:             loc_cCursorBusca, loc_cCampoBusca, loc_cValor, ;
1778:             "Sele" + CHR(231) + CHR(227) + "o")
1779: 
1780:         IF VARTYPE(loc_oBusca) = "O"
1781:             *-- Show SO quando o match exato do Init nao resolveu (regra #37)
1782:             IF !loc_oBusca.this_lAchouRegistro
1783:                 *-- Ordem das colunas do picker igual a do mAddColuna do
1784:                 *-- legado: o campo pelo qual se buscou vem PRIMEIRO
1785:                 IF par_cCelula == "DESCRICAO"
1786:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1787:                     loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1788:                 ELSE
1789:                     loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1790:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1791:                 ENDIF
1792: 
1793:                 loc_oBusca.Show()
1794:             ENDIF
1795: 
1796:             IF loc_oBusca.this_lSelecionou AND USED(loc_cCursorBusca)
1797:                 *-- Alias em variavel: SELECT (alias) e depois campo NU -
1798:                 *-- campo eh sintaxe INVALIDA em VFP9
1799:                 SELECT (loc_cCursorBusca)
1800:                 loc_cCodigo    = ALLTRIM(NVL(CPros, ""))
1801:                 loc_cDescricao = ALLTRIM(NVL(DPros, ""))
1802: 
1803:                 *-- Codigo vazio nao conta como resolvido: CPros eh a chave de
1804:                 *-- SigCdPro (NOT NULL) e so viria em branco se o cursor
1805:                 *-- estivesse fora de linha. Sem este teste, o REPLACE adiante
1806:                 *-- LIMPARIA a linha que o usuario acabou de preencher - em
1807:                 *-- silencio, porque nenhuma validacao recusa branco aqui
1808:                 loc_lResolveu = !EMPTY(loc_cCodigo)
1809:             ENDIF
1810: 
1811:             loc_oBusca.Release()
1812:         ENDIF
1813: 
1814:         IF USED(loc_cCursorBusca)
1815:             USE IN (loc_cCursorBusca)
1816:         ENDIF

*-- Linhas 1834 a 1885:
1834:         ENDIF
1835: 
1836:         *-- Legado: MessageBox([Produto Ja Selecionado!!!], 0+16,
1837:         *-- [Atencao!!!]) - validacao de uso, portanto MsgAviso
1838:         IF THIS.ProdutoJaSelecionado(loc_cCodigo)
1839:             MsgAviso("Produto J" + CHR(225) + " Selecionado!!!", ;
1840:                      "Aten" + CHR(231) + CHR(227) + "o!!!")
1841: 
1842:             *-- Assimetria do legado, reproduzida: so o Valid do CODIGO
1843:             *-- limpa o campo antes do Return .f. (This.Value = []); o da
1844:             *-- descricao devolve .f. deixando o texto como esta
1845:             IF par_cCelula == "CODIGO"
1846:                 par_oTxt.Value = ""
1847:             ENDIF
1848: 
1849:             RETURN .F.
1850:         ENDIF
1851: 
1852:         *-- Legado: as DUAS celulas recebem o par resolvido. Vai primeiro ao
1853:         *-- cursor (unico caminho confiavel para a coluna que nao esta em
1854:         *-- edicao) e so depois aos controles
1855:         IF !EOF(loc_cCursor)
1856:             SELECT (loc_cCursor)
1857:             REPLACE CPros WITH LEFT(loc_cCodigo, 14), ;
1858:                     DPros WITH LEFT(loc_cDescricao, 65)
1859:         ENDIF
1860: 
1861:         par_oTxt.Value = IIF(par_cCelula == "DESCRICAO", loc_cDescricao, loc_cCodigo)
1862:         THIS.EspelharCelulasProduto(loc_cCodigo, loc_cDescricao)
1863: 
1864:         *-- Legado: posiciona na proxima linha em branco (criando uma se
1865:         *-- preciso), repinta a grade e, no ENTER, desce uma linha
1866:         THIS.PosicionarProximaLinha()
1867: 
1868:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1869:             THIS.grd_4c_Dados.Refresh()
1870:             THIS.grd_4c_Dados.Column1.Refresh()
1871:         ENDIF
1872: 
1873:         IF LASTKEY() = 13
1874:             KEYBOARD "{DNARROW}"
1875:         ENDIF
1876: 
1877:         RETURN .T.
1878:     ENDFUNC
1879: 
1880:     *==========================================================================
1881:     * ProdutoJaSelecionado - checagem de duplicidade do legado:
1882:     *
1883:     *     lnRec = Recno([crProdutos])
1884:     *     Select * From crProdutos
1885:     *      Where CPros = This.Value And Recno() <> lnRec

*-- Linhas 1902 a 1945:
1902:     *
1903:     * Metodo PUBLIC: o form pai pode reusar a checagem antes de persistir.
1904:     *==========================================================================
1905:     PROCEDURE ProdutoJaSelecionado(par_cCodigo)
1906:         LOCAL loc_lDuplicado, loc_cCursor, loc_cCodigo, loc_nRec, loc_nTotal
1907:         loc_lDuplicado = .F.
1908:         loc_cCursor    = THIS.ObterCursorProdutos()
1909:         loc_cCodigo    = ALLTRIM(TRANSFORM(NVL(par_cCodigo, "")))
1910: 
1911:         IF EMPTY(loc_cCodigo) OR !USED(loc_cCursor)
1912:             RETURN .F.
1913:         ENDIF
1914: 
1915:         SELECT (loc_cCursor)
1916:         loc_nRec   = RECNO()
1917:         loc_nTotal = RECCOUNT()
1918: 
1919:         SCAN
1920:             IF RECNO() != loc_nRec AND ALLTRIM(NVL(CPros, "")) == loc_cCodigo
1921:                 loc_lDuplicado = .T.
1922:                 EXIT
1923:             ENDIF
1924:         ENDSCAN
1925: 
1926:         *-- Repoe o ponteiro. Em EOF o RECNO() vale RECCOUNT()+1, que GO nao
1927:         *-- aceita: nesse caso volta ao fim e sai do ultimo registro, que eh
1928:         *-- o mesmo estado de antes
1929:         DO CASE
1930:         CASE loc_nRec >= 1 AND loc_nRec <= loc_nTotal
1931:             GO loc_nRec
1932:         CASE loc_nTotal > 0
1933:             GO BOTTOM
1934:             SKIP
1935:         ENDCASE
1936: 
1937:         RETURN loc_lDuplicado
1938:     ENDPROC
1939: 
1940:     *==========================================================================
1941:     * EspelharCelulasProduto - leva o par codigo+descricao resolvido aos
1942:     * DOIS controles da grade, como os dois Valid do legado fazem:
1943:     *
1944:     *     ThisForm.grdProdutos.Column1.Text1.Value = crListaRemota.CPros
1945:     *     ThisForm.grdProdutos.Column2.Text1.Value = crListaRemota.DPros

*-- Linhas 1955 a 2041:
1955:     *
1956:     * Metodo PUBLIC: usado pelo funil de lookup e disponivel ao form pai.
1957:     *==========================================================================
1958:     PROCEDURE EspelharCelulasProduto(par_cCodigo, par_cDescricao)
1959:         LOCAL loc_cCodigo, loc_cDescricao
1960: 
1961:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1962:             RETURN .F.
1963:         ENDIF
1964: 
1965:         loc_cCodigo    = ALLTRIM(TRANSFORM(NVL(par_cCodigo, "")))
1966:         loc_cDescricao = ALLTRIM(TRANSFORM(NVL(par_cDescricao, "")))
1967: 
1968:         IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_Codigo", 5)
1969:             THIS.grd_4c_Dados.Column1.txt_4c_Codigo.Value = loc_cCodigo
1970:             THIS.grd_4c_Dados.Column1.txt_4c_Codigo.Refresh()
1971:         ENDIF
1972: 
1973:         IF PEMSTATUS(THIS.grd_4c_Dados.Column2, "txt_4c_Descricao", 5)
1974:             THIS.grd_4c_Dados.Column2.txt_4c_Descricao.Value = loc_cDescricao
1975:             THIS.grd_4c_Dados.Column2.txt_4c_Descricao.Refresh()
1976:         ENDIF
1977: 
1978:         RETURN .T.
1979:     ENDPROC
1980: 
1981:     *==========================================================================
1982:     * LimparCelulaIrma - ramo Else dos dois Valid do legado:
1983:     *
1984:     *     Column1.Text1.Valid, Else -> Column2.Text1.Value = []
1985:     *     Column2.Text1.Valid, Else -> Column1.Text1.Value = []
1986:     *
1987:     * Esvaziar o codigo esvazia a descricao, e vice-versa: as duas colunas
1988:     * sao duas vistas do MESMO produto, e deixar uma preenchida com a outra
1989:     * em branco gravaria meia linha.
1990:     *
1991:     * Zera tambem no CURSOR, nao so no controle: a coluna que nao esta em
1992:     * edicao nao commita pelo .Value (regra #46), e eh o cursor que vai para
1993:     * o form pai.
1994:     *
1995:     * Metodo PUBLIC: chamado pelo Valid das celulas, via ValidarCelulaSprExec.
1996:     *==========================================================================
1997:     PROCEDURE LimparCelulaIrma(par_cCelula)
1998:         LOCAL loc_cCursor
1999: 
2000:         loc_cCursor = THIS.ObterCursorProdutos()
2001: 
2002:         IF USED(loc_cCursor)
2003:             IF !EOF(loc_cCursor)
2004:                 SELECT (loc_cCursor)
2005: 
2006:                 IF par_cCelula == "DESCRICAO"
2007:                     REPLACE CPros WITH ""
2008:                 ELSE
2009:                     REPLACE DPros WITH ""
2010:                 ENDIF
2011:             ENDIF
2012:         ENDIF
2013: 
2014:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
2015:             RETURN .F.
2016:         ENDIF
2017: 
2018:         IF par_cCelula == "DESCRICAO"
2019:             IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_Codigo", 5)
2020:                 THIS.grd_4c_Dados.Column1.txt_4c_Codigo.Value = ""
2021:                 THIS.grd_4c_Dados.Column1.txt_4c_Codigo.Refresh()
2022:             ENDIF
2023:         ELSE
2024:             IF PEMSTATUS(THIS.grd_4c_Dados.Column2, "txt_4c_Descricao", 5)
2025:                 THIS.grd_4c_Dados.Column2.txt_4c_Descricao.Value = ""
2026:                 THIS.grd_4c_Dados.Column2.txt_4c_Descricao.Refresh()
2027:             ENDIF
2028:         ENDIF
2029: 
2030:         RETURN .T.
2031:     ENDPROC
2032: 
2033:     *==========================================================================
2034:     * PosicionarProximaLinha - bloco que fecha os dois Valid do legado (e
2035:     * tambem o btnInserir.Click, da fase 7):
2036:     *
2037:     *     Select * From crProdutos Where Empty(CPros) Into Cursor LocalBrancos
2038:     *     Go Top In LocalBrancos
2039:     *     If Not Eof([LocalBrancos])
2040:     *         Select crProdutos
2041:     *         Locate For Empty(CPros)      && ja existe linha livre: vai nela

*-- Linhas 2054 a 2183:
2054:     *
2055:     * Metodo PUBLIC: o Click do botao Inserir (fase 7) entra por aqui.
2056:     *==========================================================================
2057:     PROCEDURE PosicionarProximaLinha
2058:         LOCAL loc_cCursor
2059: 
2060:         loc_cCursor = THIS.ObterCursorProdutos()
2061: 
2062:         IF !USED(loc_cCursor)
2063:             RETURN .F.
2064:         ENDIF
2065: 
2066:         *-- .T. = nao havia linha vazia, GarantirLinhaEmBranco criou uma e
2067:         *-- ja deixou o ponteiro nela (Go Bottom). .F. = ja existia: basta
2068:         *-- ir ate ela, como o Locate do legado
2069:         IF !THIS.GarantirLinhaEmBranco()
2070:             SELECT (loc_cCursor)
2071:             LOCATE FOR EMPTY(NVL(CPros, ""))
2072:         ENDIF
2073: 
2074:         RETURN .T.
2075:     ENDPROC
2076: 
2077:     *==========================================================================
2078:     * ConfigurarEventosBotoes - liga o Click de cada botao dos CommandGroup ao
2079:     * handler correspondente deste form.
2080:     *
2081:     * Os Buttons(N) sao criados por AddObject e ficam com o nome default do
2082:     * VFP (Command1/Command2/...): nao existe metodo de classe onde escrever o
2083:     * codigo, como havia no SCX (btnInserir.Click, btnExcluir.Click,
2084:     * btnSair.Click), por isso o Click desses botoes SO dispara via BINDEVENT.
2085:     *
2086:     * O BINDEVENT eh feito em Buttons(N), nao no CommandGroup: no legado cada
2087:     * um destes tres botoes tem o SEU proprio PROCEDURE <nome>.Click. Ligar o
2088:     * GRUPO e despachar por .Value eh o padrao do caso oposto - cmdProcessar,
2089:     * onde o legado escreve UM "PROCEDURE Click" para o grupo inteiro, com
2090:     * "Do Case (This.Value = 1/2/3)" dentro (fase 8).
2091:     *
2092:     * Alvo de BINDEVENT tem de ser PUBLIC (regra #3): os handlers abaixo nao
2093:     * levam PROTECTED - com PROTECTED o bind falha em SILENCIO e o botao fica
2094:     * inerte. Os PEMSTATUS cobrem o caminho em que ConfigurarBotoesAcao nao
2095:     * chegou a criar o grupo (falha anterior no InicializarForm).
2096:     *==========================================================================
2097:     PROTECTED PROCEDURE ConfigurarEventosBotoes
2098:         *-- cmdEscolha: btnInserir = Buttons(1), btnExcluir = Buttons(2)
2099:         IF PEMSTATUS(THIS, "cmg_4c_CmdEscolha", 5)
2100:             BINDEVENT(THIS.cmg_4c_CmdEscolha.Buttons(1), "Click", THIS, "BtnInserirClick")
2101:             BINDEVENT(THIS.cmg_4c_CmdEscolha.Buttons(2), "Click", THIS, "BtnExcluirClick")
2102:         ENDIF
2103: 
2104:         *-- cmdSalva: btnSair = Buttons(1) (Caption "Encerrar", Cancel = .T.,
2105:         *-- ou seja tambem acionado pelo ESC)
2106:         IF PEMSTATUS(THIS, "cmg_4c_CmdSalva", 5)
2107:             BINDEVENT(THIS.cmg_4c_CmdSalva.Buttons(1), "Click", THIS, "BtnEncerrarClick")
2108:         ENDIF
2109: 
2110:         *-- cmdProcessar: legado escreve UM "PROCEDURE Click" para o GRUPO
2111:         *-- inteiro (Do Case This.Value = 1/2/3) - por isso o BINDEVENT vai
2112:         *-- no CommandGroup, nao em cada Buttons(N), ao contrario de
2113:         *-- cmg_4c_CmdEscolha acima
2114:         IF PEMSTATUS(THIS, "cmg_4c_CmdProcessar", 5)
2115:             BINDEVENT(THIS.cmg_4c_CmdProcessar, "Click", THIS, "BtnProcessarLoteClick")
2116:         ENDIF
2117: 
2118:         RETURN .T.
2119:     ENDPROC
2120: 
2121:     *==========================================================================
2122:     * FocarGradeProdutos - cauda COMUM de btnInserir.Click e btnExcluir.Click
2123:     * no legado, que terminam identicos:
2124:     *
2125:     *     ThisForm.grdProdutos.Column1.SetFocus
2126:     *     ThisForm.grdProdutos.Refresh
2127:     *
2128:     * Depois de inserir ou apagar uma linha o usuario tem de voltar ao campo
2129:     * Codigo da linha corrente, para seguir digitando sem usar o mouse.
2130:     *
2131:     * Column1.SetFocus do legado vira Grid.SetFocus + ActiveColumn = 1 (mesmo
2132:     * efeito, e eh o canonico do projeto - FormSigOpSno.CmdInserirClick).
2133:     *
2134:     * O SetFocus eh GUARDADO por Visible/Enabled: SetFocus em controle que nao
2135:     * esta na tela estoura "Cannot access a visible or enabled control", e o
2136:     * harness de teste chama estes handlers com o form ainda nao exibido. O
2137:     * Refresh roda de qualquer jeito - alterar o cursor NAO repinta a grade
2138:     * sozinho (regra #21a).
2139:     *
2140:     * PROTECTED: cauda interna dos dois handlers, sempre chamada com THIS.
2141:     * (regra #8).
2142:     *==========================================================================
2143:     PROTECTED PROCEDURE FocarGradeProdutos
2144:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
2145:             RETURN .F.
2146:         ENDIF
2147: 
2148:         IF THIS.Visible AND THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
2149:             THIS.grd_4c_Dados.SetFocus()
2150:             THIS.grd_4c_Dados.ActiveColumn = 1
2151:         ENDIF
2152: 
2153:         THIS.grd_4c_Dados.Refresh()
2154: 
2155:         RETURN .T.
2156:     ENDPROC
2157: 
2158:     *==========================================================================
2159:     * BtnInserirClick - btnInserir.Click do legado (Buttons(1) de cmdEscolha,
2160:     * Caption "\<Inserir"):
2161:     *
2162:     *     Select crProdutos
2163:     *     Go Top In crProdutos
2164:     *     Select * From crProdutos Where Empty(CPros) Into Cursor LocalBrancos
2165:     *     Go Top In LocalBrancos
2166:     *     If Not Eof([LocalBrancos])
2167:     *         Select crProdutos
2168:     *         Locate For Empty(CPros)
2169:     *     Else
2170:     *         Append Blank In crProdutos
2171:     *         Go Bottom In crProdutos
2172:     *     EndIf
2173:     *     ThisForm.grdProdutos.Column1.SetFocus
2174:     *     ThisForm.grdProdutos.Refresh
2175:     *
2176:     * O bloco do meio eh EXATAMENTE PosicionarProximaLinha (entregue na fase
2177:     * 6, que o reusa no fim do Valid das celulas): se ja existe linha com
2178:     * codigo vazio, vai nela; se nao existe, acrescenta uma e vai para o fim.
2179:     * Chamar o metodo em vez de repetir o bloco mantem o APPEND BLANK num
2180:     * lugar unico - os dois caminhos nunca divergem.
2181:     *
2182:     * O APPEND BLANK age no cursor LOCAL do form pai (cursor_4c_Produtos), nao
2183:     * no SQL Server: esta tela nao persiste nada - quem grava eh o pai, depois

*-- Linhas 2193 a 2458:
2193:     * Os RETURN de guarda ficam ANTES do TRY (regra #1 - nenhum RETURN dentro
2194:     * de TRY/CATCH, nem o bare); o resultado do bloco sai por flag.
2195:     *
2196:     * Metodo PUBLIC (regra #3): alvo de BINDEVENT, e o harness o chama de fora.
2197:     *==========================================================================
2198:     PROCEDURE BtnInserirClick
2199:         LOCAL loc_lSucesso, loc_cCursor, loc_oErro
2200: 
2201:         loc_lSucesso = .F.
2202:         loc_cCursor  = THIS.ObterCursorProdutos()
2203: 
2204:         *-- Legado: cmdEscolha.Visible = InList(pcEscolha, INSERIR, ALTERAR)
2205:         IF !THIS.EmModoEdicao()
2206:             RETURN .F.
2207:         ENDIF
2208: 
2209:         *-- Sem o cursor do pai nao ha linha a inserir (caminho do harness,
2210:         *-- que instancia o dialogo sem chamador)
2211:         IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
2212:             RETURN .F.
2213:         ENDIF
2214: 
2215:         TRY
2216:             *-- Legado: Select crProdutos / Go Top In crProdutos
2217:             SELECT (loc_cCursor)
2218:             GO TOP
2219: 
2220:             *-- Legado: bloco Select LocalBrancos -> Locate / Append Blank
2221:             THIS.PosicionarProximaLinha()
2222: 
2223:             *-- Legado: Column1.SetFocus + grdProdutos.Refresh
2224:             THIS.FocarGradeProdutos()
2225: 
2226:             loc_lSucesso = .T.
2227: 
2228:         CATCH TO loc_oErro
2229:             THIS.this_cMensagemErro = loc_oErro.Message
2230:             MsgErro("Erro ao inserir a linha de produto: " + loc_oErro.Message + ;
2231:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2232:                     " | Proc: " + loc_oErro.Procedure, ;
2233:                     "Selecionar Produtos")
2234:             loc_lSucesso = .F.
2235:         ENDTRY
2236: 
2237:         RETURN loc_lSucesso
2238:     ENDPROC
2239: 
2240:     *==========================================================================
2241:     * BtnExcluirClick - btnExcluir.Click do legado (Buttons(2) de cmdEscolha,
2242:     * Caption "\<Excluir"):
2243:     *
2244:     *     Select crProdutos
2245:     *     If Not Eof([crProdutos])
2246:     *         Delete In crProdutos
2247:     *         Skip
2248:     *         Skip - 1
2249:     *     EndIf
2250:     *     ThisForm.grdProdutos.Column1.SetFocus
2251:     *     ThisForm.grdProdutos.Refresh
2252:     *
2253:     * Apaga a linha CORRENTE da grade - um item da lista de produtos do pai,
2254:     * nao um registro de tabela: nao ha DELETE em SQL Server neste caminho (e
2255:     * por isso tambem nao ha MsgConfirma, que o legado nao tem - a lista eh de
2256:     * trabalho e a linha se reinsere em um clique).
2257:     *
2258:     * O par SKIP / SKIP -1 eh o idioma do legado para sair de cima do registro
2259:     * recem-apagado: com SET DELETED ON (config.prg) o SKIP pula o que foi
2260:     * marcado e o SKIP -1 volta uma linha VISIVEL, deixando o ponteiro numa
2261:     * linha valida. Transcrito literal - no ultimo registro o SKIP chega a
2262:     * EOF() e o SKIP -1 devolve a ultima linha visivel, que eh o resultado
2263:     * pretendido.
2264:     *
2265:     * Mesma guarda de modo de BtnInserirClick, pela mesma razao (o legado
2266:     * conta com cmdEscolha oculto em PROCURAR, e o atalho Alt+E segue
2267:     * alcancavel).
2268:     *
2269:     * Metodo PUBLIC (regra #3): alvo de BINDEVENT, e o harness o chama de fora.
2270:     *==========================================================================
2271:     PROCEDURE BtnExcluirClick
2272:         LOCAL loc_lSucesso, loc_cCursor, loc_oErro
2273: 
2274:         loc_lSucesso = .F.
2275:         loc_cCursor  = THIS.ObterCursorProdutos()
2276: 
2277:         *-- Legado: cmdEscolha.Visible = InList(pcEscolha, INSERIR, ALTERAR)
2278:         IF !THIS.EmModoEdicao()
2279:             RETURN .F.
2280:         ENDIF
2281: 
2282:         IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
2283:             RETURN .F.
2284:         ENDIF
2285: 
2286:         TRY
2287:             *-- Legado: Select crProdutos / If Not Eof([crProdutos])
2288:             SELECT (loc_cCursor)
2289: 
2290:             IF !EOF()
2291:                 *-- Legado: Delete In crProdutos / Skip / Skip - 1
2292:                 DELETE
2293:                 SKIP
2294:                 SKIP -1
2295:             ENDIF
2296: 
2297:             *-- Legado: Column1.SetFocus + grdProdutos.Refresh
2298:             THIS.FocarGradeProdutos()
2299: 
2300:             loc_lSucesso = .T.
2301: 
2302:         CATCH TO loc_oErro
2303:             THIS.this_cMensagemErro = loc_oErro.Message
2304:             MsgErro("Erro ao excluir a linha de produto: " + loc_oErro.Message + ;
2305:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2306:                     " | Proc: " + loc_oErro.Procedure, ;
2307:                     "Selecionar Produtos")
2308:             loc_lSucesso = .F.
2309:         ENDTRY
2310: 
2311:         RETURN loc_lSucesso
2312:     ENDPROC
2313: 
2314:     *==========================================================================
2315:     * RemoverLinhasEmBranco - primeira linha de btnSair.Click do legado:
2316:     *
2317:     *     Delete From crProdutos Where Empty(CPros)
2318:     *
2319:     * Descarta as linhas que nasceram em branco (a que o Init cria para o
2320:     * usuario digitar, e as que ele inseriu e abandonou) ANTES de devolver o
2321:     * cursor ao form pai - sem isso o pai gravaria itens de produto vazios (o
2322:     * SIGCDBAL percorre crProdutos com Scan e faz um Insert por linha).
2323:     *
2324:     * Escrito com SELECT (alias) + DELETE FOR, nao com DELETE FROM <alias>
2325:     * WHERE: o alias mora numa variavel (ObterCursorProdutos) e comando SQL do
2326:     * VFP9 nao aceita name expression no lugar do nome da tabela. A forma
2327:     * xBase age sobre a area corrente e eh equivalente - mesmo padrao de
2328:     * FormSigOpSno.BtnSairClick.
2329:     *
2330:     * NVL em volta de CPros porque o cursor do pai vem de consulta remota e a
2331:     * coluna pode chegar NULL (EMPTY(.NULL.) eh .F. no VFP, logo sem o NVL a
2332:     * linha nula NAO seria apagada).
2333:     *
2334:     * O ponteiro fica onde o DELETE FOR o deixar, como no legado: o pai
2335:     * percorre o cursor com Scan, cujo escopo ALL reposiciona sozinho.
2336:     *
2337:     * Metodo PUBLIC: o Click de cmdProcessar (fase 8) repete esta MESMA linha
2338:     * no legado e entra por aqui, e o form pai pode reusar a limpeza.
2339:     *==========================================================================
2340:     PROCEDURE RemoverLinhasEmBranco
2341:         LOCAL loc_lRemoveu, loc_cCursor, loc_oErro
2342: 
2343:         loc_lRemoveu = .F.
2344:         loc_cCursor  = THIS.ObterCursorProdutos()
2345: 
2346:         IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
2347:             RETURN .F.
2348:         ENDIF
2349: 
2350:         TRY
2351:             SELECT (loc_cCursor)
2352:             DELETE FOR EMPTY(NVL(CPros, ""))
2353:             loc_lRemoveu = .T.
2354: 
2355:         CATCH TO loc_oErro
2356:             THIS.this_cMensagemErro = loc_oErro.Message
2357:             MsgErro("Erro ao descartar as linhas em branco: " + loc_oErro.Message + ;
2358:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2359:                     " | Proc: " + loc_oErro.Procedure, ;
2360:                     "Selecionar Produtos")
2361:             loc_lRemoveu = .F.
2362:         ENDTRY
2363: 
2364:         RETURN loc_lRemoveu
2365:     ENDPROC
2366: 
2367:     *==========================================================================
2368:     * BtnEncerrarClick - btnSair.Click do legado (Buttons(1) de cmdSalva,
2369:     * Caption "Encerrar", Cancel = .T.):
2370:     *
2371:     *     Delete From crProdutos Where Empty(CPros)
2372:     *     ThisForm.ParentForm.Enabled = .t.
2373:     *     ThisForm.Release
2374:     *
2375:     * Sem TitleBar e sem ControlBox (propriedades do form, transcritas do
2376:     * SCX), este botao - e o ESC, por Cancel = .T. - eh a UNICA saida da tela.
2377:     *
2378:     * NAO ha par Confirmar/Cancelar aqui, e isso eh do legado: a lista JA foi
2379:     * editada no cursor do pai a cada linha, entao encerrar eh aceitar. Pela
2380:     * mesma razao nao ha propriedade de retorno - o resultado inteiro esta no
2381:     * cursor_4c_Produtos, que eh do pai.
2382:     *
2383:     * O THIS.Release() fica FORA do TRY de proposito: se a limpeza das linhas
2384:     * em branco falhar, o dialogo ainda tem de fechar - do contrario o usuario
2385:     * ficaria preso numa tela sem outra saida, com o form pai desabilitado.
2386:     *
2387:     * O Enabled = .T. do pai eh repetido no Destroy como rede de seguranca
2388:     * (caminho em que o dialogo eh destruido sem passar por aqui); atribuir
2389:     * .T. duas vezes eh inocuo.
2390:     *
2391:     * As properties lhouveexcl/lhouveins que o RESERVED3/ClassInfo do SCX
2392:     * lista NAO sao atribuidas nem lidas por metodo algum do dump, e o
2393:     * chamador ("Do Form SigOpSpr With ThisForm", no SIGCDBAL) nao consulta
2394:     * nada do dialogo depois que ele fecha - logo nao ha comportamento delas a
2395:     * portar, e inventar um violaria o PILAR 1.
2396:     *
2397:     * Metodo PUBLIC (regra #3): alvo de BINDEVENT, e o harness o chama de fora.
2398:     *==========================================================================
2399:     PROCEDURE BtnEncerrarClick
2400:         LOCAL loc_oErro
2401: 
2402:         TRY
2403:             *-- Legado: Delete From crProdutos Where Empty(CPros)
2404:             THIS.RemoverLinhasEmBranco()
2405: 
2406:             *-- Legado: ThisForm.ParentForm.Enabled = .t.
2407:             IF VARTYPE(THIS.this_oFormPai) = "O"
2408:                 IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
2409:                     THIS.this_oFormPai.Enabled = .T.
2410:                 ENDIF
2411:             ENDIF
2412: 
2413:         CATCH TO loc_oErro
2414:             THIS.this_cMensagemErro = loc_oErro.Message
2415:             MsgErro("Erro ao encerrar a sele" + CHR(231) + CHR(227) + "o de produtos: " + ;
2416:                     loc_oErro.Message + ;
2417:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2418:                     " | Proc: " + loc_oErro.Procedure, ;
2419:                     "Selecionar Produtos")
2420:         ENDTRY
2421: 
2422:         *-- Legado: ThisForm.Release
2423:         THIS.Release()
2424: 
2425:         RETURN .T.
2426:     ENDPROC
2427: 
2428:     *==========================================================================
2429:     * BtnProcessarLoteClick - cmdProcessar.Click do legado (CommandGroup
2430:     * inteiro, Do Case This.Value = 1/2/3 - diferente de cmg_4c_CmdEscolha,
2431:     * que tem um Click por botao). Equivale aos tres botoes "Produtos com
2432:     * Mov." / "Produtos nao Inv." / "Todos nao Inv." (fase 5).
2433:     *
2434:     * Transcricao do legado (SIGOPSPR.cmdProcessar.Click):
2435:     *
2436:     *     If (ThisForm.getDias.Value < 1)
2437:     *         =MessageBox([Preencha os Dias...], 0+16, [Atencao!!!])
2438:     *         Return .f.
2439:     *     EndIf
2440:     *     pDat = fDtoSQL(Date() - ThisForm.getDias.Value)
2441:     *     ThisForm.cnpProcessando.Top = 120
2442:     *     <monta lcWhe a partir de ParentForm.loFil.*>
2443:     *     Do Case (This.Value = 1/2/3) -> lcQuery -> SqlExecute(lcQuery,'LocalCPros')
2444:     *     If (...SqlExecute(...) < 1)
2445:     *         =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
2446:     *         Return .f.
2447:     *     EndIf
2448:     *     Delete From crProdutos Where Empty(CPros)
2449:     *     lnCnt = 0
2450:     *     Select LocalCPros
2451:     *     Scan
2452:     *         If Not Empty(LocalCPros.CPros)
2453:     *             Scatter Memvar Memo
2454:     *             Select crProdutos
2455:     *             Go Top In crProdutos
2456:     *             Locate For CPros = LocalCPros.CPros
2457:     *             If Eof([crProdutos])
2458:     *                 lnCnt = lnCnt + 1

*-- Linhas 2511 a 2586:
2511:     * Os RETURN de guarda ficam ANTES do TRY (regra #1); o resultado interno
2512:     * do bloco sai por variavel, nunca por RETURN dentro de TRY/CATCH.
2513:     *
2514:     * Metodo PUBLIC (regra #3): alvo de BINDEVENT, e o harness o chama de
2515:     * fora.
2516:     *==========================================================================
2517:     PROCEDURE BtnProcessarLoteClick
2518:         LOCAL loc_nOpcao, loc_nDias, loc_cNomeFormPai, loc_cCursorProdutos
2519:         LOCAL loc_cCursorProcessa, loc_nResultado, loc_nInseridos
2520:         LOCAL loc_cCodigo, loc_cDescricao, loc_oErro
2521: 
2522:         loc_nOpcao = 0
2523:         IF PEMSTATUS(THIS, "cmg_4c_CmdProcessar", 5)
2524:             loc_nOpcao = THIS.cmg_4c_CmdProcessar.Value
2525:         ENDIF
2526: 
2527:         *-- Legado: cmdProcessar.Visible = InList(pcEscolha,INSERIR,ALTERAR)
2528:         *-- And Upper(ParentForm.Name) = "SIGCDBAL"
2529:         loc_cNomeFormPai = ""
2530:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2531:             loc_cNomeFormPai = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cNomeFormPai))
2532:         ENDIF
2533: 
2534:         IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
2535:            !(THIS.EmModoEdicao() AND loc_cNomeFormPai == "SIGCDBAL")
2536:             RETURN .F.
2537:         ENDIF
2538: 
2539:         *-- Legado: If (ThisForm.getDias.Value < 1) -> MessageBox + Return .f.
2540:         loc_nDias = 0
2541:         IF PEMSTATUS(THIS, "txt_4c_Dias", 5)
2542:             loc_nDias = THIS.txt_4c_Dias.Value
2543:         ENDIF
2544: 
2545:         IF loc_nDias < 1
2546:             MsgAviso("Preencha os Dias a Considerar Para os Produtos!!!", ;
2547:                      "Aten" + CHR(231) + CHR(227) + "o!!!")
2548:             RETURN .F.
2549:         ENDIF
2550: 
2551:         loc_cCursorProdutos = THIS.ObterCursorProdutos()
2552: 
2553:         IF EMPTY(loc_cCursorProdutos) OR !USED(loc_cCursorProdutos)
2554:             RETURN .F.
2555:         ENDIF
2556: 
2557:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2558:             RETURN .F.
2559:         ENDIF
2560: 
2561:         loc_nInseridos = 0
2562: 
2563:         TRY
2564:             *-- Legado: ThisForm.cnpProcessando.Top = 120
2565:             IF PEMSTATUS(THIS, "cnt_4c_CnpProcessando", 5)
2566:                 THIS.cnt_4c_CnpProcessando.Top = 120
2567:                 THIS.cnt_4c_CnpProcessando.Refresh()
2568:             ENDIF
2569: 
2570:             THIS.this_oBusinessObject.this_nDias = loc_nDias
2571: 
2572:             *-- Legado: pDat = fDtoSQL(...) + Do Case(This.Value) -> lcQuery
2573:             *-- -> SqlExecute(lcQuery,'LocalCPros') - tudo isso no BO
2574:             loc_nResultado = THIS.this_oBusinessObject.ObterProdutosEmLote(loc_nOpcao)
2575: 
2576:             IF loc_nResultado < 0
2577:                 *-- Legado: MessageBox([Favor Reinicializar o Processo!!!],16,...)
2578:                 MsgErro("Favor Reinicializar o Processo!!!", ;
2579:                         "Falha na Conex" + CHR(227) + "o (LocalCPros)")
2580:             ELSE
2581:                 loc_cCursorProcessa = ALLTRIM(THIS.this_oBusinessObject.this_cCursorProcessa)
2582: 
2583:                 *-- Legado: Delete From crProdutos Where Empty(CPros), ANTES
2584:                 *-- do Scan (mesma linha de RemoverLinhasEmBranco, fase 7)
2585:                 THIS.RemoverLinhasEmBranco()
2586: 

*-- Linhas 2620 a 2756:
2620:                 ENDIF
2621: 
2622:                 THIS.this_oBusinessObject.this_nQtdSelecionados = loc_nInseridos
2623: 
2624:                 *-- Legado: ThisForm.cnpProcessando.Top = 500
2625:                 IF PEMSTATUS(THIS, "cnt_4c_CnpProcessando", 5)
2626:                     THIS.cnt_4c_CnpProcessando.Top = 500
2627:                 ENDIF
2628: 
2629:                 *-- Legado nao repete este bloco aqui (ja rodou no Init), mas
2630:                 *-- sem ele uma selecao que preencheu TODAS as linhas em
2631:                 *-- branco deixaria a grade sem onde digitar o proximo
2632:                 *-- produto (item f do cabecalho)
2633:                 THIS.GarantirLinhaEmBranco()
2634: 
2635:                 *-- Legado: Select crProdutos / Go Top In crProdutos /
2636:                 *-- grdProdutos.Refresh / Go Bottom In crProdutos /
2637:                 *-- grdProdutos.Refresh
2638:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2639:                     SELECT (loc_cCursorProdutos)
2640:                     GO TOP
2641:                     THIS.grd_4c_Dados.Refresh()
2642:                     GO BOTTOM
2643:                     THIS.grd_4c_Dados.Refresh()
2644:                 ENDIF
2645: 
2646:                 *-- Legado: MessageBox([Foram Selecionados ]+Alltrim(Str(lnCnt,10))+
2647:                 *-- [ Produtos!!!], 0+64, [Selecao Concluida!!!])
2648:                 MsgInfo("Foram Selecionados " + ALLTRIM(STR(loc_nInseridos, 10)) + ;
2649:                         " Produtos!!!", ;
2650:                         "Sele" + CHR(231) + CHR(227) + "o Conclu" + CHR(237) + "da!!!")
2651:             ENDIF
2652: 
2653:         CATCH TO loc_oErro
2654:             THIS.this_cMensagemErro = loc_oErro.Message
2655: 
2656:             *-- Rede de seguranca: erro no meio do processamento nao pode
2657:             *-- deixar o aviso "Selecionando Produtos..." cobrindo a tela
2658:             IF PEMSTATUS(THIS, "cnt_4c_CnpProcessando", 5)
2659:                 THIS.cnt_4c_CnpProcessando.Top = 500
2660:             ENDIF
2661: 
2662:             MsgErro("Erro ao processar produtos em lote: " + loc_oErro.Message + ;
2663:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2664:                     " | Proc: " + loc_oErro.Procedure, ;
2665:                     "Selecionar Produtos")
2666:         ENDTRY
2667: 
2668:         RETURN .T.
2669:     ENDPROC
2670: 
2671:     *==========================================================================
2672:     * TornarControlesVisiveis - AddObject cria todo controle com
2673:     * Visible = .F.; este metodo percorre o form e os containers tornando
2674:     * visivel o que foi criado.
2675:     *
2676:     * Metodo PUBLIC (regra #3): o harness de teste o chama de fora.
2677:     *
2678:     * Esta tela NAO tem container flutuante do tipo Visible=.F./.T.
2679:     * alternado por botao: o unico elemento "escondido" do legado
2680:     * (cnpProcessando - fase 5) fica sempre Visible = .T. e eh deslocado
2681:     * para Top = 500 (fora da area visivel do dialogo, Height = 600) - um
2682:     * truque de POSICAO, nao de Visible - por isso nao precisa de filtro
2683:     * aqui.
2684:     *
2685:     * Ha, porem, controles que NASCEM invisiveis no SCX e tem de continuar
2686:     * assim: as barrinhas decorativas ImgBarra1/ImgBarra2 (e ImgBarra3, na
2687:     * fase 5), todas com Visible = .F. no dump. Sem a lista de excecao este
2688:     * metodo as exporia na tela, que eh o oposto do legado.
2689:     *
2690:     * A visibilidade que depende do CONTEXTO do form pai (cmdEscolha e, na
2691:     * fase 5, cmdProcessar/lblDias/getDias) nao entra aqui: ela eh decidida
2692:     * em AplicarVisibilidadePorContexto, chamado logo DEPOIS deste metodo.
2693:     *==========================================================================
2694:     PROCEDURE TornarControlesVisiveis
2695:         LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho
2696: 
2697:         FOR loc_nI = 1 TO THIS.ControlCount
2698:             loc_oControle = THIS.Controls(loc_nI)
2699: 
2700:             IF VARTYPE(loc_oControle) != "O"
2701:                 LOOP
2702:             ENDIF
2703: 
2704:             *-- Nascem Visible = .F. no SCX e assim devem ficar
2705:             IF INLIST(UPPER(loc_oControle.Name), "IMG_4C_IMGBARRA1", ;
2706:                       "IMG_4C_IMGBARRA2", "IMG_4C_IMGBARRA3")
2707:                 *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
2708:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2709:                     THIS.TornarControlesVisiveis(loc_oControl)
2710:                 ENDIF
2711:                 LOOP
2712:             ENDIF
2713: 
2714:             IF PEMSTATUS(loc_oControle, "Visible", 5)
2715:                 loc_oControle.Visible = .T.
2716:             ENDIF
2717: 
2718:             IF PEMSTATUS(loc_oControle, "ControlCount", 5)
2719:                 IF loc_oControle.ControlCount > 0
2720:                     FOR loc_nJ = 1 TO loc_oControle.ControlCount
2721:                         loc_oFilho = loc_oControle.Controls(loc_nJ)
2722: 
2723:                         IF VARTYPE(loc_oFilho) = "O"
2724:                             IF PEMSTATUS(loc_oFilho, "Visible", 5)
2725:                                 loc_oFilho.Visible = .T.
2726:                             ENDIF
2727:                         ENDIF
2728:                     ENDFOR
2729:                 ENDIF
2730:             ENDIF
2731:         ENDFOR
2732: 
2733:         RETURN .T.
2734:     ENDPROC
2735: 
2736:     *==========================================================================
2737:     * Destroy - devolve o controle ao FormBase (que libera o BO e restaura o
2738:     * menu - regra #52 do CLAUDE.md).
2739:     *
2740:     * Reabilita o form pai (legado: .ParentForm.Enabled = .f. no Init / .t.
2741:     * no btnSair.Click) como REDE DE SEGURANCA - se o dialogo for destruido
2742:     * por qualquer caminho alem do botao Encerrar (fase 7), o pai nao fica
2743:     * travado. Guardado por PEMSTATUS/VARTYPE: em modo teste o form pai
2744:     * pode ser .NULL. ou nao ter a property Enabled.
2745:     *==========================================================================
2746:     PROCEDURE Destroy
2747:         IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
2748:             THIS.this_oFormPai.Enabled = .T.
2749:         ENDIF
2750: 
2751:         THIS.this_oFormPai = .NULL.
2752: 
2753:         DODEFAULT()
2754:     ENDPROC
2755: 
2756: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpSprBO.prg):
*==============================================================================
* SigOpSprBO.prg - Business Object para "Selecionar Produtos" (SIGOPSPR)
*
* Origem legado : SigOpSpr.SCX  (tasks\task805)
* Tipo de form  : OPERACIONAL (dialogo FILHO, chamado pelo form pai)
* Tabela base   : SigCdPro | PK: CPros
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo filho que monta a lista de produtos do form pai (o legado recebe
* "poForm" no Init, troca para a DataSession do pai e manipula o cursor
* LOCAL "crProdutos", que pertence ao pai - no migrado esse alias fica em
* THIS.this_cCursorProdutos). O usuario pode:
*   1) Inserir/Excluir linhas na grade e digitar o produto (lookup em
*      SigCdPro por CPros ou por DPros - fwBuscaExt do legado);
*   2) Processar em LOTE (tres botoes, so quando o pai eh o SIGCDBAL e
*      pcEscolha esta em INSERIR/ALTERAR):
*        Value = 1 "Produtos com Mov."  -> SigMvItn
*        Value = 2 "Produtos nao Inv."  -> SigMvEst com SQtds <> 0
*        Value = 3 "Todos nao Inv."     -> SigCdPro
*      Os tres excluem o que ja foi inventariado em SigPrIvl desde a data de
*      corte (Date() - Dias) e aplicam as faixas de filtro herdadas do pai
*      (loFil: Mercs / CGrus / SGrus / Colecoes / Linhas / IFors).
*
* GRAVACAO
* --------
* Toda escrita do legado tem por destino o CURSOR LOCAL do form pai
* (Append Blank / Insert Into crProdutos From Memvar / Delete In crProdutos);
* o acesso ao SQL Server eh 100% de leitura (Select). Por isso este BO NAO
* sobrescreve Inserir() / Atualizar() / ExecutarExclusao(): o comportamento
* padrao herdado de BusinessBase ja eh o correto, e inventar INSERT/UPDATE
* aqui violaria a regra #22 (a lista de colunas vem do schema, nunca de
* adivinhacao).
*
* METODOS DE DADOS (equivalentes a CRUD para este form de leitura)
* ------------------------------------------------------------------
*   CarregarDoCursor(par_cAliasCursor) - mapeia CPros/DPros de uma linha de
*       lookup para this_cCPros/this_cDPros.
*   MontarFiltroFaixas()               - helper PROTECTED: monta o lcWhe do
*       legado a partir das faixas herdadas do pai.
*   ObterProdutosEmLote(par_nOpcao)    - equivalente ao cmdProcessar.Click
*       (as 3 consultas SigMvItn/SigMvEst/SigCdPro). O Form faz o SCAN e o
*       Insert Into no cursor local do pai (manipulacao de cursor VFP, fora
*       deste BO).
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas em MaxLength e LEFT()
* -------------------------------------------------------------------
*   SigCdPro.CPros    char(14)   SigCdPro.Mercs    char(3)
*   SigCdPro.DPros    char(65)   SigCdPro.CGrus    char(3)
*   SigMvItn.Emps     char(3)    SigCdPro.SGrus    char(6)
*   SigMvEst.Emps     char(3)    SigCdPro.Colecoes char(10)
*   SigPrIvl.Emps     char(3)    SigCdPro.Linhas   char(10)
*   SigPrIvl.DtHrs    datetime   SigCdPro.IFors    char(10)
*   SigMvEst.SQtds    numeric(11,3)
*==============================================================================

DEFINE CLASS SigOpSprBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - linha de produto selecionado
    * (colunas do cursor de produtos do form pai, espelhando SigCdPro)
    *--------------------------------------------------------------------------
    this_cCPros              = ""      && CPros char(14) - codigo do produto
    this_cDPros              = ""      && DPros char(65) - descricao do produto

    *--------------------------------------------------------------------------
    * CONTEXTO HERDADO DO FORM PAI
    * Legado: ThisForm.ParentForm.<x> / Set DataSession To poForm.DataSessionId
    *--------------------------------------------------------------------------
    this_cEscolha            = ""      && pcEscolha do pai: INSERIR / ALTERAR / PROCURAR
    this_cNomeFormPai        = ""      && Upper(ParentForm.Name) - lote so quando "SIGCDBAL"
    this_nDataSessionPai     = 0       && DataSessionId do pai (poForm.DataSessionId)
    this_cEmps               = ""      && Emps char(3) - empresa corrente (go_4c_Sistema.cCodEmpresa do legado)

    *--------------------------------------------------------------------------
    * PARAMETROS DO PROCESSAMENTO EM LOTE (cmdProcessar)
    *--------------------------------------------------------------------------
    this_nOpcaoProcessamento = 0       && 1=SigMvItn  2=SigMvEst  3=SigCdPro
    this_nDias               = 0       && getDias.Value - numeric(4), InputMask "9999"
    this_dDataCorte          = {}      && Date() - Dias  (pDat do legado, via fDtoSQL)
    this_nQtdSelecionados    = 0       && lnCnt - produtos efetivamente incluidos
    this_nMaxRegistrosBusca  = 1000    && limite do fwBuscaExt legado (ultimo argumento)

    *--------------------------------------------------------------------------
    * FAIXAS DE FILTRO HERDADAS DO PAI (ParentForm.loFil)
    * Cada par monta "And p.<col> >= 'I'" / "And p.<col> <= 'F'" somente quando
    * nao esta vazio - exatamente como o legado monta lcWhe.
    *--------------------------------------------------------------------------
    this_cMercsI             = ""      && Mercs    char(3)  - inicial
    this_cMercsF             = ""      && Mercs    char(3)  - final
    this_cCGrusI             = ""      && CGrus    char(3)  - inicial
    this_cCGrusF             = ""      && CGrus    char(3)  - final
    this_cSGrusI             = ""      && SGrus    char(6)  - inicial
    this_cSGrusF             = ""      && SGrus    char(6)  - final
    this_cColecoesI          = ""      && Colecoes char(10) - inicial
    this_cColecoesF          = ""      && Colecoes char(10) - final
    this_cLinhasI            = ""      && Linhas   char(10) - inicial
    this_cLinhasF            = ""      && Linhas   char(10) - final
    this_cIForsI             = ""      && IFors    char(10) - inicial
    this_cIForsF             = ""      && IFors    char(10) - final

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR
    * (nomes do legado entre parenteses - PILAR 3 manda renomear)
    *--------------------------------------------------------------------------
    this_cCursorProdutos     = "cursor_4c_Produtos"       && crProdutos    - cursor do PAI, editado pela grade
    this_cCursorProcessa     = "cursor_4c_ProdProcessa"   && LocalCPros    - resultado do SELECT em lote
    this_cCursorBrancos      = "cursor_4c_LinhasBrancas"  && LocalBrancos  - linhas com CPros vazio
    this_cCursorBusca        = "cursor_4c_BuscaProduto"   && crListaRemota - lookup de SigCdPro

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO
    * Legado: propriedades customizadas lhouveins / lhouveexcl do SIGOPSPR
    *--------------------------------------------------------------------------
    this_lHouveInclusao      = .F.     && lhouveins  - houve inclusao de linha
    this_lHouveExclusao      = .F.     && lhouveexcl - houve exclusao de linha

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de leitura (SigCdPro.CPros), herda a empresa
    * corrente (o _Empr do legado) e repoe os valores iniciais que o legado
    * tem no proprio SCX: getDias.Value = 0 e cmdProcessar.Value = 0.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"

        *-- Empresa corrente: o legado usa a PUBLIC _Empr; no sistema novo o
        *-- equivalente eh go_4c_Sistema.cCodEmpresa (ver CLAUDE.md).
        IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
            THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ELSE
            THIS.this_cEmps = ""
        ENDIF

        *-- Valores iniciais identicos aos do SCX legado
        THIS.this_nDias               = 0
        THIS.this_nOpcaoProcessamento = 0
        THIS.this_nQtdSelecionados    = 0
        THIS.this_dDataCorte          = DATE()
        THIS.this_lHouveInclusao      = .F.
        THIS.this_lHouveExclusao      = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCPros
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia as colunas de uma linha de SigCdPro (CPros,
    * DPros) para as propriedades do BO. Usado depois de um SELECT de
    * verificacao/lookup (ex.: cursor_4c_BuscaProduto) para o Form ler o
    * produto corrente sem acessar o cursor diretamente.
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCPros = TratarNulo(CPros, "C")
            THIS.this_cDPros = TratarNulo(DPros, "C")
            RETURN .T.
        ENDIF

        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarFiltroFaixas - Monta o trecho "AND p.<col> >= '..' AND p.<col>
    * <= '..'" a partir das faixas herdadas do pai (loFil do legado),
    * exatamente como o cmdProcessar.Click monta lcWhe: cada faixa so entra
    * quando NAO esta vazia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarFiltroFaixas()
        LOCAL loc_cWhe
        loc_cWhe = ""

        IF !EMPTY(THIS.this_cMercsI)
            loc_cWhe = loc_cWhe + " AND p.Mercs >= " + EscaparSQL(ALLTRIM(THIS.this_cMercsI))
        ENDIF
        IF !EMPTY(THIS.this_cMercsF)
            loc_cWhe = loc_cWhe + " AND p.Mercs <= " + EscaparSQL(ALLTRIM(THIS.this_cMercsF))
        ENDIF
        IF !EMPTY(THIS.this_cCGrusI)
            loc_cWhe = loc_cWhe + " AND p.CGrus >= " + EscaparSQL(ALLTRIM(THIS.this_cCGrusI))
        ENDIF
        IF !EMPTY(THIS.this_cCGrusF)
            loc_cWhe = loc_cWhe + " AND p.CGrus <= " + EscaparSQL(ALLTRIM(THIS.this_cCGrusF))
        ENDIF
        IF !EMPTY(THIS.this_cSGrusI)
            loc_cWhe = loc_cWhe + " AND p.SGrus >= " + EscaparSQL(ALLTRIM(THIS.this_cSGrusI))
        ENDIF
        IF !EMPTY(THIS.this_cSGrusF)
            loc_cWhe = loc_cWhe + " AND p.SGrus <= " + EscaparSQL(ALLTRIM(THIS.this_cSGrusF))
        ENDIF
        IF !EMPTY(THIS.this_cColecoesI)
            loc_cWhe = loc_cWhe + " AND p.Colecoes >= " + EscaparSQL(ALLTRIM(THIS.this_cColecoesI))
        ENDIF
        IF !EMPTY(THIS.this_cColecoesF)
            loc_cWhe = loc_cWhe + " AND p.Colecoes <= " + EscaparSQL(ALLTRIM(THIS.this_cColecoesF))
        ENDIF
        IF !EMPTY(THIS.this_cLinhasI)
            loc_cWhe = loc_cWhe + " AND p.Linhas >= " + EscaparSQL(ALLTRIM(THIS.this_cLinhasI))
        ENDIF
        IF !EMPTY(THIS.this_cLinhasF)
            loc_cWhe = loc_cWhe + " AND p.Linhas <= " + EscaparSQL(ALLTRIM(THIS.this_cLinhasF))
        ENDIF
        IF !EMPTY(THIS.this_cIForsI)
            loc_cWhe = loc_cWhe + " AND p.IFors >= " + EscaparSQL(ALLTRIM(THIS.this_cIForsI))
        ENDIF
        IF !EMPTY(THIS.this_cIForsF)
            loc_cWhe = loc_cWhe + " AND p.IFors <= " + EscaparSQL(ALLTRIM(THIS.this_cIForsF))
        ENDIF

        RETURN loc_cWhe
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterProdutosEmLote - Equivalente ao cmdProcessar.Click do legado.
    * par_nOpcao: 1 = "Produtos com Mov." (SigMvItn)
    *             2 = "Produtos nao Inv." (SigMvEst com SQtds <> 0)
    *             3 = "Todos nao Inv."    (SigCdPro)
    * Os tres excluem o que ja foi inventariado em SigPrIvl desde a data de
    * corte (Date() - Dias) e aplicam as faixas herdadas do pai. Resultado
    * fica em THIS.this_cCursorProcessa (equivalente a LocalCPros); quem
    * chama (o Form) faz o SCAN e o Insert Into no cursor local do pai -
    * esse ultimo passo eh manipulacao de cursor VFP, nao SQL, e por isso
    * fica fora deste BO (ver cabecalho: toda escrita vai para o cursor do
    * form pai).
    *
    * Retorna o numero de linhas (>= 0) ou -1 em falha de conexao/opcao
    * invalida - igual ao "< 1" do SqlExecute legado.
    *--------------------------------------------------------------------------
    FUNCTION ObterProdutosEmLote(par_nOpcao)
        LOCAL loc_cSQL, loc_cWhe, loc_cDataCorte, loc_nResultado

        IF THIS.this_nDias < 1
            RETURN -1
        ENDIF

        THIS.this_nOpcaoProcessamento = par_nOpcao
        THIS.this_dDataCorte          = DATE() - THIS.this_nDias
        loc_cDataCorte                = FormatarDataSQL(THIS.this_dDataCorte)
        loc_cWhe                      = THIS.MontarFiltroFaixas()

        DO CASE
            CASE par_nOpcao = 1
                loc_cSQL = "SELECT DISTINCT a.CPros, p.DPros" +;
                           " FROM SigMvItn a" +;
                           " INNER JOIN SigCdPro p ON a.CPros = p.CPros" +;
                           " WHERE a.Emps = " + EscaparSQL(THIS.this_cEmps) + loc_cWhe +;
                           " AND a.CPros NOT IN (SELECT l.CPros FROM SigPrIvl l" +;
                           " WHERE l.Emps = " + EscaparSQL(THIS.this_cEmps) +;
                           " AND l.DtHrs >= " + loc_cDataCorte + ")" +;
                           " ORDER BY a.CPros"

            CASE par_nOpcao = 2
                loc_cSQL = "SELECT DISTINCT a.CPros, p.DPros" +;
                           " FROM SigMvEst a" +;
                           " INNER JOIN SigCdPro p ON a.CPros = p.CPros" +;
                           " WHERE a.Emps = " + EscaparSQL(THIS.this_cEmps) + loc_cWhe +;
                           " AND NOT a.SQtds = 0" +;
                           " AND a.CPros NOT IN (SELECT l.CPros FROM SigPrIvl l" +;
                           " WHERE l.Emps = " + EscaparSQL(THIS.this_cEmps) +;
                           " AND l.DtHrs >= " + loc_cDataCorte + ")" +;
                           " ORDER BY a.CPros"

            CASE par_nOpcao = 3
                loc_cSQL = "SELECT DISTINCT p.CPros, p.DPros" +;
                           " FROM SigCdPro p" +;
                           " WHERE p.CPros NOT IN (SELECT l.CPros FROM SigPrIvl l" +;
                           " WHERE l.Emps = " + EscaparSQL(THIS.this_cEmps) +;
                           " AND l.DtHrs >= " + loc_cDataCorte + ")" + loc_cWhe +;
                           " ORDER BY p.CPros"

            OTHERWISE
                RETURN -1
        ENDCASE

        IF USED(THIS.this_cCursorProcessa)
            USE IN (THIS.this_cCursorProcessa)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProcessa)

        RETURN loc_nResultado
    ENDFUNC

ENDDEFINE

