# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.GarantirCelulaStatus()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.PossuiAcessoOperacao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH Thisform.GradeSubN define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: Thisform.GradeSubN.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSts.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2198 linhas total):

*-- Linhas 42 a 227:
42: * CHAMADA (equivale ao "Do Form SigOpSts With ThisForm, ThisForm.
43: * DataSessionId, ThisForm.PcEscolha" do legado, onde o proprio form pai eh
44: * "poForm"):
45: *   loForm = CREATEOBJECT("FormSigOpSts", THISFORM, loc_cOperacaoAtual, ;
46: *       THISFORM.this_cModoAtual, THISFORM.DataSessionId)
47: *   IF VARTYPE(loForm) = "O"
48: *       loForm.Show()          && modal: so volta quando o dialogo fecha
49: *   ENDIF
50: *
51: *   Como no legado, o Release eh do PROPRIO dialogo (botao Encerrar, fase
52: *   futura), nao do chamador.
53: *
54: * PARAMETROS DO INIT (legado: LParameters poForm, pnDataSes, pcEscolha)
55: *   par_oFormPai         - legado: poForm/ThisForm.ParentForm. O form pai
56: *                          SigCdOpe (CRUD), que precisa expor:
57: *                            .Enabled              - desabilitado enquanto
58: *                                                     este dialogo esta aberto
59: *                            .Top / .Left           - para o posicionamento
60: *                            .pgf_4c_Paginas.Page1.grd_4c_Dados
61: *                                                   - para o posicionamento
62: *                                                     (legado: Pagina.Lista.Grade)
63: *   par_cOperacaoPai     - legado: crSigCdOpe.Dopes, lido direto do cursor
64: *                          do pai (ja na DataSession dele). Como o migrado
65: *                          nao troca de DataSession, o codigo da operacao eh
66: *                          passado explicitamente pelo chamador.
67: *   par_cEscolha         - legado: Thisform.PcEscolha do pai (INSERIR/
68: *                          ALTERAR/PROCURAR) - decide a visibilidade de
69: *                          cmd_4c_Inserir/cmd_4c_Excluir (ver
70: *                          AplicarVisibilidadeBotoes).
71: *   par_nDataSessionPai  - legado: pnDataSes. Informativo - DataSession = 1
72: *                          ja unifica a sessao com o pai; mantido so para
73: *                          auditoria/paridade com o legado.
74: *
75: * METODOS DE DADOS (ja implementados no BO - fases 1-2)
76: *   CarregarDoCursor/Inserir/Atualizar/ObterChavePrimaria - ver cabecalho
77: *   de SigOpStsBO.prg para o detalhamento completo (inclusive a regra de
78: *   gravacao REPLACE-ALL do legado, transcrita em futuras fases para
79: *   ExisteStatusDuplicado/GravarStatus).
80: *
81: *   IMPORTANTE (decisao ja registrada no cabecalho de SigOpStsBO.prg): o
82: *   estado da sessao do dialogo (lhouveins/lhouveexcl do legado) mora
83: *   EXCLUSIVAMENTE no BO (this_oBusinessObject.this_lHouveInclusao/
84: *   this_lHouveExclusao) - este form NAO declara copias proprias dessas
85: *   duas flags. O form apenas ESCREVE nelas (via this_oBusinessObject) nos
86: *   mesmos pontos do legado (CmdInserirClick/CmdExcluirClick).
87: *
88: * FASE 3: estrutura base do form -
89: *   - Propriedades que espelham o contexto recebido do form pai
90: *     (this_oFormPai/this_cOperacaoPai/this_cEscolha/this_nDataSessionPai).
91: *   - Init (LParameters do legado) + ValidarParametros (precondicao: sem
92: *     form pai e sem operacao nao ha o que gerenciar).
93: *   - InicializarForm (cria o BO, migra o contexto do pai para ele,
94: *     posiciona o dialogo ao lado da grade do pai, aplica o fundo e cria o
95: *     cabecalho cinza).
96: *   - CarregarContextoFormPai (legado: .ParentForm.Enabled = .f. + repasse
97: *     de Dopes/PcEscolha/DataSession para o BO).
98: *   - ConfigurarPosicionamento (legado: .Top/.Left calculados a partir do
99: *     Top/Left/Grade do pai).
100: *   - ConfigurarDecoracao (Picture do form - new_background.jpg).
101: *   - ConfigurarPageFrame (cntSombra do legado -> cnt_4c_Cabecalho; mantido
102: *     esse nome de metodo por paridade com os demais dialogos filhos desta
103: *     familia - FormSigOpSqn/FormSigOpSlc/FormSigOpSpr - mesmo sem
104: *     PageFrame real: este form eh FLAT, igual ao legado).
105: *   - TornarControlesVisiveis / Destroy (reabilita o form pai ao fechar -
106: *     rede de seguranca, igual ao cmdSair.Click do legado).
107: *
108: * FASE 4 (esta fase): a GRADE e os BOTOES da tela -
109: *   - ConfigurarGrade (GradeSubN do legado -> grd_4c_Dados): 2 colunas
110: *     transcritas do dump (Column1 "Status" W=40, Column2 "Descricao"
111: *     W=235). Column2 fica ReadOnly = .T. (legado: When = .F., somente
112: *     leitura permanente); Column1 fica ReadOnly = .F. no nivel do Grid -
113: *     a condicao por linha (When = Empty(status)) e o lookup vem da classe
114: *     da celula instalada na Fase 6 (regra #18/#46).
115: *   - ConfigurarBotoes (shp_4c_Separador + cmd_4c_Inserir/cmd_4c_Excluir/
116: *     cmd_4c_Sair, todos da classe legado fwbtng - transcritos do dump:
117: *     Top=3, Left=375/450/525). O Shape eh criado ANTES dos botoes porque
118: *     a area dele fica EM CIMA deles (ver comentario do metodo).
119: *   - AplicarVisibilidadeBotoes (as 4 linhas de .cmdInserir/.cmdExcluir
120: *     .Visible/.Enabled do Init legado + o recalculo de shape1.Left/Width).
121: *     Roda DEPOIS do TornarControlesVisiveis, que forca Visible = .T. em
122: *     tudo e apagaria justamente o Visible = .F. do controle de acesso.
123: *   - PossuiAcessoOperacao (fChecaAcesso('SIGOPSTS', <acao>) do legado, com
124: *     bypass em modo teste/validacao de UI, onde ele consulta SQL e nao ha
125: *     conexao).
126: *   - CarregarDados (funil UNICO de carga, PUBLIC) + VincularGrade: chamam
127: *     SigOpStsBO.ListarStatusOperacao (equivalente ao Sqlexecute('...',
128: *     'LocalStats') do legado), religam a grade ao cursor e repintam com
129: *     GO TOP + Refresh (regra #21 - popular cursor NAO repinta a grade).
130: *
131: * FASE 6 (esta fase): o LOOKUP da celula de status -
132: *   A tela nao tem campo nenhum fora da grade (o dump tem apenas os dois
133: *   labels do cabecalho, a GradeSubN, o Shape e os 3 botoes), entao esta
134: *   fase eh inteiramente a celula editavel da Column1 e o lookup dela.
135: *
136: *   - ConfigurarGrade passa a instalar TextBoxStatusSts_4c na Column1 com
137: *     Column.AddObject + CurrentControl + Sparse = .F. (regra #18 - sem o
138: *     CurrentControl a coluna continua desenhando o Text1 dela e o
139: *     controle novo nunca aparece; sem Sparse = .F. ele apareceria so na
140: *     linha ativa). A classe mora em classes\textboxgridlookup.PRG porque
141: *     BINDEVENT em When/Valid de celula de Grid NAO eh confiavel
142: *     (regra #46), e delega para os metodos PUBLIC abaixo.
143: *   - VincularGrade REAPLICA CurrentControl/Sparse: atribuir RecordSource/
144: *     ControlSource reseta as duas propriedades junto com Width/Caption
145: *     (Problema 48 / regra #41).
146: *   - CelulaStatusEditavel  - When  do Column1.Text1 legado
147: *                             (Return( Empty( LocalStats.status ) ): so a
148: *                             linha ainda sem status aceita digitacao).
149: *   - ValidarStatusGradeExec - Valid do Column1.Text1 legado (com valor
150: *                             digitado, resolve contra SigStats e grava a
151: *                             descricao na linha corrente).
152: *   - AbrirLookupStatusSts / AbrirLookupStatusStsExec - o
153: *                             CreateObject('fwbuscaext', ..., 'SigStats',
154: *                             'CrListaRemota', 'Cods', ...) do legado,
155: *                             migrado para FormBuscaAuxiliar seguindo o
156: *                             contrato this_lAchouRegistro/
157: *                             this_lSelecionou (regra #37). Funil UNICO
158: *                             das tres entradas (Valid, F4/F5 e duplo
159: *                             clique), com guarda de reentrancia.
160: *   - StatusGradeLostFocus  - LostFocus do Column1.Text1 legado
161: *                             (campo vazio -> foco para o Encerrar).
162: *
163: * FASE 7 (esta fase): os EVENTOS dos tres botoes do legado -
164: *   O legado desta tela NAO tem barra CRUD: o form herda de "form" puro (nao
165: *   de frmcadastro) e os botoes do SCX sao cmdInserir, cmdExcluir e cmdSair.
166: *   O unico "Grupo_Op" citado no dump eh o do form PAI, desabilitado por
167: *   mCtrlBotoes enquanto este dialogo esta aberto. Por isso esta fase entrega
168: *   os eventos dos botoes que EXISTEM - nao ha Incluir/Alterar/Visualizar/
169: *   Excluir de registro a portar, e inventa-los violaria o PILAR 1.
170: *
171: *   - ConfigurarBINDEVENTs - liga o Click dos tres botoes aos handlers
172: *                            abaixo (AddObject cria botao SEM codigo de
173: *                            evento: sem BINDEVENT o Click nao dispara).
174: *   - CmdInserirClick      - cmdInserir.Click legado: acrescenta UMA linha
175: *                            em branco ao cursor da grade (reaproveitando a
176: *                            que ja estiver vazia) e foca a Column1.
177: *   - CmdExcluirClick      - cmdExcluir.Click legado: DELETE da linha
178: *                            corrente do cursor + reposicionamento.
179: *   - BtnSairClick         - cmdSair.Click legado ("Encerrar"): valida
180: *                            duplicidade, grava (REPLACE-ALL) e fecha. Eh o
181: *                            UNICO ponto de gravacao da tela, igual ao
182: *                            legado. A validacao e o REPLACE-ALL moram no
183: *                            BO (SigOpStsBO.ExisteStatusDuplicado /
184: *                            GravarStatus) - sao regra de negocio e acesso
185: *                            a dados, nao UI.
186: *
187: *   Os tres handlers sao PUBLIC (regra #3/#51): BINDEVENT falha em SILENCIO
188: *   com metodo PROTECTED, e o harness de teste os chama de fora da classe.
189: *
190: * FASE 8 (esta fase): o TRANSPORTE da linha da grade e a CONSOLIDACAO -
191: *   Esta tela nao tem campo nenhum fora da grade, entao a FICHA dela eh UMA
192: *   LINHA de cursor_4c_Status. Os dois hooks de transferencia transportam
193: *   essa linha, e nao um bloco de TextBox de Page2 (que esta tela nao tem).
194: *
195: *   - ModoEdicaoAtivo    - a condicao que abre o cmdSair.Click legado
196: *                          (cmdInserir.Visible Or cmdExcluir.Visible), em UM
197: *                          lugar so em vez de repetida em cada leitor.
198: *   - FormParaBO         - linha corrente -> properties do BO. Dentro do
199: *                          Valid da celula o valor digitado esta em
200: *                          par_oTxt.Value e o cursor so o recebe depois
201: *                          (regra #46), por isso a CELULA vence o cursor no
202: *                          campo status.
203: *   - BOParaForm         - properties do BO -> linha corrente + celula +
204: *                          Refresh. Eh a transcricao do "This.Value = ... /
205: *                          Replace Descs With ... / This.Refresh / Select
206: *                          LocalStats" do Valid legado. O metodo
207: *                          AbrirLookupStatusStsExec passou a usar estes dois
208: *                          hooks em vez de repetir o REPLACE.
209: *   - LimparCampos       - zera a ficha da linha no funil de carga, para a
210: *                          linha de uma sessao nunca vazar para a seguinte.
211: *
212: *   - HabilitarCampos    - ponto UNICO que aplica a editabilidade aos
213: *                          controles. Existe porque o rebind da grade reseta
214: *                          Column.ReadOnly (Problema 48 / regra #41) e quem
215: *                          desabilita tem de reabilitar no FUNIL (regra #40):
216: *                          VincularGrade e AplicarVisibilidadeBotoes o chamam.
217: *   - AjustarBotoesPorModo / CarregarLista - os nomes canonicos do projeto
218: *                          apontando para a logica real desta tela
219: *                          (AplicarVisibilidadeBotoes / CarregarDados), para
220: *                          o caminho canonico alcancar UM unico fluxo em vez
221: *                          de uma segunda copia que pode divergir.
222: *
223: *   FormParaBO/BOParaForm/LimparCampos sao PROTECTED EXPLICITOS: FormBase
224: *   declara os mesmos nomes como PROTECTED (formbase.prg:276/280/285) e em
225: *   VFP9 a subclasse nao ALARGA escopo herdado - omitir o modificador nao os
226: *   tornaria publicos, so esconderia o fato. Sao chamados por THIS. de dentro
227: *   da classe (regra #8). Os outros quatro NAO existem em FormBase, logo sao

*-- Linhas 278 a 341:
278:     *--------------------------------------------------------------------------
279: 
280:     *-- Guarda de reentrancia do picker da Column1 (regra #37/#47): o
281:     *-- FormBuscaAuxiliar eh MODAL, entao o Show() tira o foco da celula e
282:     *-- pode redisparar o proprio Valid/LostFocus que o abriu - sem esta
283:     *-- flag subiriam DOIS dialogos empilhados. Nao existe no legado, que
284:     *-- nao sofre disso porque o fwbuscaext roda dentro do Valid do
285:     *-- TextBox do Grid do proprio form modal.
286:     this_lEmLookupStatus = .F.
287: 
288:     *--------------------------------------------------------------------------
289:     * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
290:     *--------------------------------------------------------------------------
291: 
292:     *-- SIGOPSTS: BorderStyle = 2 / Top = 0 / Left = 0 / Height = 350 /
293:     *-- Width = 600 / DoCreate = .T. (default do Form, nao precisa declarar)
294:     BorderStyle = 2
295:     Top         = 0
296:     Left        = 0
297:     Height      = 350
298:     Width       = 600
299: 
300:     *-- Caption do SCX ("Status por Operacoes") - sobrescrito em
301:     *-- InicializarForm com o codigo da operacao-pai, igual ao legado
302:     *-- (.Caption = 'Status das Operacoes ' + AllTrim(Proper(crSigCdOpe.Dopes)))
303:     Caption = "Status por Opera" + CHR(231) + CHR(245) + "es"
304: 
305:     *-- ControlBox = .F. (legado) -> Closable/MaxButton/MinButton = .F.
306:     *-- (padrao do projeto para dialogo sem chrome, mesmo padrao dos
307:     *-- dialogos irmaos). Movable = .T. (literal do dump - diferente do
308:     *-- irmao FormSigOpSqn, que declara .F.: transcrever o que o SCX desta
309:     *-- tela realmente tem, nao copiar do irmao). ClipControls = .F. /
310:     *-- TitleBar = 0 - literais do SCX. Sem barra de titulo e sem
311:     *-- ControlBox, a unica saida eh pelo botao Encerrar
312:     *-- (cmd_4c_Sair -> BtnSairClick)
313:     TitleBar     = 0
314:     Closable     = .F.
315:     MaxButton    = .F.
316:     MinButton    = .F.
317:     Movable      = .T.
318:     ClipControls = .F.
319: 
320:     *-- O legado posiciona o form manualmente a partir do form pai
321:     *-- (ConfigurarPosicionamento, abaixo) - AutoCenter desligado para nao
322:     *-- competir com esse calculo
323:     AutoCenter = .F.
324: 
325:     *-- WindowType = 1 (modal): o pai abre este dialogo e precisa que o
326:     *-- Show() bloqueie ate o usuario Encerrar (legado: .ParentForm.Enabled
327:     *-- = .f. enquanto este form esta aberto, emulando modalidade)
328:     WindowType  = 1
329:     WindowState = 0
330: 
331:     *-- ShowWindow = 1 ("In Top-Level Form"): canonico do projeto
332:     ShowWindow = 1
333: 
334:     *-- Fonte base do Framework legado (os controles do corpo declaram a
335:     *-- propria fonte - Tahoma 18 no cabecalho - transcrita em
336:     *-- ConfigurarPageFrame)
337:     FontName = "Tahoma"
338:     FontSize = 8
339: 
340:     *-- DataSession = 1 (sessao CORRENTE, NAO privada). O legado declara
341:     *-- DataSession = 2 no SCX mas o proprio Init sobrescreve com "Set

*-- Linhas 351 a 611:
351:     * troca de DataSession para ler crSigCdOpe.Dopes direto do cursor do
352:     * pai; mesma convencao dos dialogos irmaos desta familia).
353:     *==========================================================================
354:     PROCEDURE Init
355:         LPARAMETERS par_oFormPai, par_cOperacaoPai, par_cEscolha, par_nDataSessionPai
356: 
357:         IF VARTYPE(par_oFormPai) = "O"
358:             THIS.this_oFormPai = par_oFormPai
359:         ENDIF
360: 
361:         THIS.this_cOperacaoPai    = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")
362:         THIS.this_cEscolha        = IIF(VARTYPE(par_cEscolha) = "C", par_cEscolha, "")
363:         THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)
364: 
365:         *-- DODEFAULT chama FormBase.Init (fix SET DATE/CENTURY) e em
366:         *-- seguida THIS.InicializarForm()
367:         RETURN DODEFAULT()
368:     ENDPROC
369: 
370:     *==========================================================================
371:     * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
372:     * quem reabilitar/posicionar em relacao, e sem operacao-pai nao ha
373:     * lista de status nenhuma para gerenciar (o legado tambem depende
374:     * dessas referencias em praticamente todo metodo - crSigCdOpe.Dopes/
375:     * ThisForm.ParentForm.*).
376:     *
377:     * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
378:     * de fora, e PROTECTED faria a chamada externa estourar em runtime.
379:     *
380:     * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
381:     * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
382:     * bypass a instanciacao reprovaria sempre.
383:     *
384:     * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
385:     * bloco algum.
386:     *==========================================================================
387:     PROCEDURE ValidarParametros
388:         LOCAL loc_lValido
389:         loc_lValido = .T.
390: 
391:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
392:             RETURN .T.
393:         ENDIF
394: 
395:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
396:             RETURN .T.
397:         ENDIF
398: 
399:         IF VARTYPE(THIS.this_oFormPai) != "O"
400:             MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir do " + ;
401:                     "Cadastro de Opera" + CHR(231) + CHR(245) + "es do Caixa.", ;
402:                     "Status das Opera" + CHR(231) + CHR(245) + "es")
403:             loc_lValido = .F.
404:         ENDIF
405: 
406:         IF EMPTY(THIS.this_cOperacaoPai)
407:             MsgErro("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
408:                     "Status das Opera" + CHR(231) + CHR(245) + "es")
409:             loc_lValido = .F.
410:         ENDIF
411: 
412:         RETURN loc_lValido
413:     ENDPROC
414: 
415:     *==========================================================================
416:     * InicializarForm - estrutura base do dialogo
417:     *
418:     * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
419:     * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
420:     *==========================================================================
421:     PROTECTED PROCEDURE InicializarForm
422:         LOCAL loc_lSucesso, loc_oErro
423:         loc_lSucesso = .F.
424: 
425:         *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
426:         *-- dentro de TRY/CATCH (regra #1)
427:         IF !THIS.ValidarParametros()
428:             RETURN .F.
429:         ENDIF
430: 
431:         TRY
432:             *-- Business Object das Fases 1-2
433:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpStsBO")
434: 
435:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
436:                 MsgErro("Falha ao criar SigOpStsBO.", "Status das Opera" + CHR(231) + CHR(245) + "es")
437:             ELSE
438:                 *-- Legado: .ParentForm.Enabled = .f. + repasse de
439:                 *-- Dopes/PcEscolha/DataSession para o BO
440:                 THIS.CarregarContextoFormPai()
441: 
442:                 *-- Legado: .Caption = 'Status das Operacoes ' +
443:                 *-- AllTrim(Proper(crSigCdOpe.Dopes))
444:                 THIS.Caption = "Status das Opera" + CHR(231) + CHR(245) + "es " + ;
445:                     ALLTRIM(PROPER(THIS.this_cOperacaoPai))
446: 
447:                 *-- Fundo do form (Picture do SCX)
448:                 THIS.ConfigurarDecoracao()
449: 
450:                 *-- Legado: .Top/.Left calculados a partir da grade do pai
451:                 THIS.ConfigurarPosicionamento()
452: 
453:                 *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
454:                 *-- AddObject do form: os botoes ficam dentro da faixa do
455:                 *-- topo (Top = 3..103 cai dentro de Top = 0..80 do
456:                 *-- cabecalho) e precisam ser criados depois para desenhar
457:                 *-- por cima (regra #11)
458:                 THIS.ConfigurarPageFrame()
459: 
460:                 *-- Fase 4: grade (GradeSubN) e os botoes Inserir/Excluir/
461:                 *-- Encerrar + o Shape separador
462:                 THIS.ConfigurarGrade()
463:                 THIS.ConfigurarBotoes()
464: 
465:                 *-- AddObject cria controle com Visible = .F.
466:                 THIS.TornarControlesVisiveis(THIS)
467: 
468:                 *-- Legado (Init): .cmdInserir/.cmdExcluir .Visible/.Enabled
469:                 *-- por fChecaAcesso + pcEscolha, e o shape1 redimensionado
470:                 *-- em volta dos botoes que sobraram visiveis.
471:                 *-- OBRIGATORIAMENTE depois do TornarControlesVisiveis, que
472:                 *-- forca Visible = .T. em TODO controle e apagaria o
473:                 *-- Visible = .F. decidido aqui
474:                 THIS.AplicarVisibilidadeBotoes()
475: 
476:                 *-- Fase 7: Click dos tres botoes do legado (AddObject cria
477:                 *-- botao SEM codigo de evento - sem BINDEVENT o Click nunca
478:                 *-- dispara e o usuario clica sem nada acontecer)
479:                 THIS.ConfigurarBINDEVENTs()
480: 
481:                 *-- Legado (fim do Init): Sqlexecute(...,'LocalStats') +
482:                 *-- Goto Top + bind da GradeSubN + .Refresh. Pulado em
483:                 *-- validacao de UI (sem gnConnHandle nao ha o que
484:                 *-- consultar) - a ausencia de dados nao impede a tela de
485:                 *-- abrir
486:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
487:                     IF !THIS.CarregarDados()
488:                         *-- Falha ja reportada por CarregarDados/BO
489:                     ENDIF
490:                 ENDIF
491: 
492:                 loc_lSucesso = .T.
493:             ENDIF
494: 
495:         CATCH TO loc_oErro
496:             THIS.this_cMensagemErro = loc_oErro.Message
497:             MsgErro("Erro ao inicializar FormSigOpSts: " + loc_oErro.Message + ;
498:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
499:                     " | Procedure: " + loc_oErro.Procedure, "Erro")
500:             loc_lSucesso = .F.
501:         ENDTRY
502: 
503:         RETURN loc_lSucesso
504:     ENDPROC
505: 
506:     *==========================================================================
507:     * CarregarContextoFormPai - migra para o BO o que o Init legado le/grava
508:     * no form pai:
509:     *
510:     *     ThisForm.ParentForm = poForm
511:     *     ThisForm.ParentForm.Enabled = .f.
512:     *     <crSigCdOpe.Dopes, Thisform.PcEscolha>   (ja recebidos via
513:     *                                                parametro no Init
514:     *                                                deste form - ver
515:     *                                                cabecalho do arquivo)
516:     *
517:     * Cada leitura/escrita eh protegida por PEMSTATUS/VARTYPE: em modo
518:     * teste (gb_4c_ModoTeste/gb_4c_ValidandoUI) o form pai pode ser .NULL.
519:     * ou um stub sem essas properties, e a ausencia aqui NAO eh falha de
520:     * inicializacao (ValidarParametros ja fez o bypass acima).
521:     *==========================================================================
522:     PROTECTED PROCEDURE CarregarContextoFormPai
523:         IF VARTYPE(THIS.this_oFormPai) = "O"
524:             *-- Legado: .ParentForm.Enabled = .f. (reabilitado no Destroy -
525:             *-- rede de seguranca; no legado isso esta no cmdSair.Click)
526:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
527:                 THIS.this_oFormPai.Enabled = .F.
528:             ENDIF
529:         ENDIF
530: 
531:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
532:             WITH THIS.this_oBusinessObject
533:                 .this_cOperacaoPai    = THIS.this_cOperacaoPai
534:                 .this_cEscolha        = THIS.this_cEscolha
535:                 .this_nDataSessionPai = THIS.this_nDataSessionPai
536:             ENDWITH
537:         ENDIF
538:     ENDPROC
539: 
540:     *==========================================================================
541:     * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
542:     *==========================================================================
543:     PROTECTED PROCEDURE ConfigurarDecoracao
544:         LOCAL loc_cImagemFundo
545:         loc_cImagemFundo = ""
546: 
547:         IF TYPE("gc_4c_CaminhoIcones") = "C"
548:             loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
549:         ENDIF
550: 
551:         IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
552:             THIS.Picture = loc_cImagemFundo
553:         ENDIF
554:     ENDPROC
555: 
556:     *==========================================================================
557:     * ConfigurarPosicionamento - reproduz o calculo de .Top/.Left do Init
558:     * legado, que ancora este dialogo ao lado da grade do form pai:
559:     *
560:     *   .Top  = ParentForm.Top + ParentForm.Pagina.Lista.Grade.Top + 50
561:     *   .Left = ParentForm.Left + ParentForm.Pagina.Lista.Grade.Left +
562:     *           ParentForm.Pagina.Lista.Grade.Columns(1).Width +
563:     *           ParentForm.Pagina.Lista.Grade.Columns(3).Width + 16
564:     *
565:     * No migrado, o form pai (FormSigCdOpe, CRUD) usa pgf_4c_Paginas.Page1.
566:     * grd_4c_Dados no lugar de Pagina.Lista.Grade. Guardas PEMSTATUS/
567:     * VARTYPE cobrem gb_4c_ModoTeste/gb_4c_ValidandoUI e o fato do form pai
568:     * ainda nao existir/nao ter essa estrutura - sem elas, nao haveria como
569:     * instanciar este dialogo isoladamente para teste.
570:     *==========================================================================
571:     PROTECTED PROCEDURE ConfigurarPosicionamento
572:         LOCAL loc_oGrade
573: 
574:         IF VARTYPE(THIS.this_oFormPai) != "O"
575:             RETURN
576:         ENDIF
577: 
578:         IF !PEMSTATUS(THIS.this_oFormPai, "pgf_4c_Paginas", 5)
579:             RETURN
580:         ENDIF
581: 
582:         IF VARTYPE(THIS.this_oFormPai.pgf_4c_Paginas) != "O" OR ;
583:            !PEMSTATUS(THIS.this_oFormPai.pgf_4c_Paginas, "Page1", 5)
584:             RETURN
585:         ENDIF
586: 
587:         IF VARTYPE(THIS.this_oFormPai.pgf_4c_Paginas.Page1) != "O" OR ;
588:            !PEMSTATUS(THIS.this_oFormPai.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
589:             RETURN
590:         ENDIF
591: 
592:         loc_oGrade = THIS.this_oFormPai.pgf_4c_Paginas.Page1.grd_4c_Dados
593: 
594:         IF VARTYPE(loc_oGrade) != "O"
595:             RETURN
596:         ENDIF
597: 
598:         THIS.Top = THIS.this_oFormPai.Top + loc_oGrade.Top + 50
599: 
600:         IF loc_oGrade.ColumnCount >= 3
601:             THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + ;
602:                         loc_oGrade.Columns(1).Width + loc_oGrade.Columns(3).Width + 16
603:         ELSE
604:             *-- Grade com menos de 3 colunas (layout divergente do esperado)
605:             *-- - aproximacao segura, so para o dialogo nao abrir fora da
606:             *-- area visivel
607:             THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + 50
608:         ENDIF
609:     ENDPROC
610: 
611:     *==========================================================================

*-- Linhas 641 a 684:
641:     * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
642:     * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form Designer.
643:     *==========================================================================
644:     PROTECTED PROCEDURE ConfigurarPageFrame
645:         *-- Container da faixa (cntSombra)
646:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
647:         WITH THIS.cnt_4c_Cabecalho
648:             .Top           = 0
649:             .Left          = 0
650:             .Width         = THIS.Width
651:             .Height        = 80
652:             .BorderWidth   = 0
653:             .BackStyle     = 1
654:             .BackColor     = RGB(100, 100, 100)
655:             .SpecialEffect = 0
656:             .Visible       = .T.
657:         ENDWITH
658: 
659:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
660:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
661:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
662:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
663:             .AutoSize      = .F.
664:             .FontBold      = .T.
665:             .FontName      = "Tahoma"
666:             .FontSize      = 18
667:             .FontUnderline = .F.
668:             .WordWrap      = .T.
669:             .Alignment     = 0
670:             .BackStyle     = 0
671:             .Caption       = THIS.Caption
672:             .Top           = 18
673:             .Left          = 10
674:             .Width         = THIS.Width - 20
675:             .Height        = 40
676:             .ForeColor     = RGB(0, 0, 0)
677:             .Rotation      = 0
678:             .Visible       = .T.
679:         ENDWITH
680: 
681:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
682:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
683:         *-- regra #12)
684:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")

*-- Linhas 734 a 815:
734:     * (legado: When = Empty(LocalStats.status), textbox da Column1) - essa
735:     * condicao por LINHA e o lookup contra SigStats entram na Fase 6, via
736:     * TextBox subclasse instalada com Column.AddObject + CurrentControl +
737:     * Sparse = .F. (regra #18), porque BINDEVENT em evento de celula de
738:     * Grid nao eh confiavel (regra #46). Por ora, no nivel do Grid, a
739:     * coluna fica destravada (ReadOnly = .F.) - a restricao por linha vem
740:     * depois, da classe da Fase 6.
741:     *
742:     * Column2 (descs) eh SEMPRE somente leitura (legado: When = .F. no
743:     * Text1 da Column2 - a descricao vem do lookup da Column1 e nunca eh
744:     * digitada direto) - ReadOnly = .T. permanente, sem excecao por linha.
745:     *
746:     * MaxLength pela largura da COLUNA no schema (SIGOPSTS.status char(1) /
747:     * SigStats.descs char(20)), NUNCA pelo Width em pixels (regra #19).
748:     *
749:     * ReadOnly das colunas sempre DEPOIS do Grid, porque o ReadOnly do Grid
750:     * propaga para elas e sobrescreveria o valor daqui (regra #46).
751:     *==========================================================================
752:     PROTECTED PROCEDURE ConfigurarGrade
753:         THIS.AddObject("grd_4c_Dados", "Grid")
754: 
755:         WITH THIS.grd_4c_Dados
756:             .Top           = 94
757:             .Left          = 146
758:             .Width         = 307
759:             .Height        = 238
760:             .FontName      = "Tahoma"
761:             .FontSize      = 8
762:             .DeleteMark    = .F.
763:             .RecordMark    = .F.
764:             .RowHeight     = 16
765:             .ScrollBars    = 2
766:             .TabIndex      = 1
767:             .GridLineColor = RGB(238, 238, 238)
768:             .ColumnCount   = 2
769:             .Visible       = .T.
770:         ENDWITH
771: 
772:         *-- Column1 - status (codigo, FK SigStats.cods). Celula com When/
773:         *-- Valid/LostFocus do legado e lookup contra SigStats: os eventos
774:         *-- moram na classe TextBoxStatusSts_4c (classes\
775:         *-- textboxgridlookup.PRG) porque BINDEVENT em evento de celula de
776:         *-- Grid nao eh confiavel (regra #18/#46)
777:         WITH THIS.grd_4c_Dados.Column1
778:             .FontName          = "Tahoma"
779:             .FontSize          = 8
780:             .Width             = 40
781:             .Movable           = .F.
782:             .Resizable         = .F.
783:             .Header1.FontName  = "Tahoma"
784:             .Header1.FontSize  = 8
785:             .Header1.Alignment = 2
786:             .Header1.Caption   = "Status"
787:         ENDWITH
788: 
789:         *-- A celula (AddObject + CurrentControl + Sparse) eh instalada num
790:         *-- LUGAR SO - GarantirCelulaStatus - porque ela precisa ser
791:         *-- REINSTALADA toda vez que as Columns sao recriadas (ver o
792:         *-- comentario do metodo, com a medicao)
793:         THIS.GarantirCelulaStatus()
794: 
795:         *-- Column2 - descs (descricao do status, somente leitura)
796:         WITH THIS.grd_4c_Dados.Column2
797:             .FontName          = "Tahoma"
798:             .FontSize          = 8
799:             .Width             = 235
800:             .Movable           = .F.
801:             .Resizable         = .F.
802:             .Header1.FontName  = "Tahoma"
803:             .Header1.FontSize  = 8
804:             .Header1.Alignment = 2
805:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
806:             .Text1.FontName    = "Tahoma"
807:             .Text1.FontSize    = 8
808:             .Text1.BorderStyle = 0
809:             .Text1.Margin      = 0
810:             .Text1.MaxLength   = 20
811:             .Text1.ForeColor   = RGB(0, 0, 0)
812:             .Text1.BackColor   = RGB(255, 255, 255)
813:         ENDWITH
814: 
815:         *-- ReadOnly das colunas DEPOIS do Grid (regra #46)

*-- Linhas 857 a 900:
857:     * ausente ja falha em silencio) e so esconde o erro (regra #25). Os tres
858:     * arquivos estao conferidos em vbmp\.
859:     *==========================================================================
860:     PROTECTED PROCEDURE ConfigurarBotoes
861:         LOCAL loc_cIcones
862: 
863:         *-- gc_4c_CaminhoIcones pode nao existir em probe/harness sem
864:         *-- config.prg - referenciar a variavel ausente mataria o Init
865:         loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")
866: 
867:         *-- Shape1 do legado - moldura em volta do bloco de botoes
868:         THIS.AddObject("shp_4c_Separador", "Shape")
869:         WITH THIS.shp_4c_Separador
870:             .Top         = 12
871:             .Left        = 92
872:             .Height      = 110
873:             .Width       = 257
874:             .BackStyle   = 0
875:             .BorderStyle = 0
876:             .BorderColor = RGB(136, 189, 188)
877:             .Visible     = .T.
878:         ENDWITH
879: 
880:         *-- cmdInserir
881:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
882:         WITH THIS.cmd_4c_Inserir
883:             .Top             = 3
884:             .Left            = 375
885:             .Width           = 80
886:             .Height          = 100
887:             .FontBold        = .T.
888:             .FontItalic      = .T.
889:             .FontName        = "Comic Sans MS"
890:             .FontSize        = 8
891:             .WordWrap        = .T.
892:             .MousePointer    = 15
893:             .ForeColor       = RGB(90, 90, 90)
894:             .BackColor       = RGB(255, 255, 255)
895:             .Themes          = .T.
896:             .TabIndex        = 4
897:             .Caption         = "Inserir"
898:             .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
899:             .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
900:             .Visible         = .T.

*-- Linhas 973 a 1110:
973:     *
974:     * cmd_4c_Sair NUNCA eh escondido: ele eh a unica saida da tela.
975:     *==========================================================================
976:     PROTECTED PROCEDURE AplicarVisibilidadeBotoes
977:         LOCAL loc_lModoEdicao, loc_lInserir, loc_lExcluir
978: 
979:         loc_lModoEdicao = EMPTY(THIS.this_cEscolha) OR ;
980:             INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
981: 
982:         loc_lInserir = THIS.PossuiAcessoOperacao("INSERIR") AND loc_lModoEdicao
983:         loc_lExcluir = THIS.PossuiAcessoOperacao("EXCLUIR") AND loc_lModoEdicao
984: 
985:         THIS.cmd_4c_Inserir.Visible = loc_lInserir
986:         THIS.cmd_4c_Inserir.Enabled = loc_lInserir
987:         THIS.cmd_4c_Excluir.Visible = loc_lExcluir
988:         THIS.cmd_4c_Excluir.Enabled = loc_lExcluir
989: 
990:         DO CASE
991:         CASE THIS.cmd_4c_Inserir.Visible
992:             THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Inserir.Left - 5
993:             THIS.shp_4c_Separador.Width = 3 * THIS.cmd_4c_Sair.Width + 16
994:         CASE THIS.cmd_4c_Excluir.Visible
995:             THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Excluir.Left - 5
996:             THIS.shp_4c_Separador.Width = 2 * THIS.cmd_4c_Sair.Width + 16
997:         OTHERWISE
998:             THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Sair.Left - 5
999:             THIS.shp_4c_Separador.Width = 1 * THIS.cmd_4c_Sair.Width + 16
1000:         ENDCASE
1001: 
1002:         *-- A trava da celula de status acompanha os botoes: sem isto, o modo
1003:         *-- so-leitura do pai (PROCURAR, ou usuario sem acesso) esconderia os
1004:         *-- botoes de linha e deixaria a Column1 editavel. Deriva de
1005:         *-- ModoEdicaoAtivo(), que le o Visible que acabou de ser definido
1006:         *-- aqui - e nao de loc_lModoEdicao, que ignora o controle de acesso
1007:         THIS.HabilitarCampos()
1008:     ENDPROC
1009: 
1010:     *==========================================================================
1011:     * PossuiAcessoOperacao - fChecaAcesso('SIGOPSTS', <acao>) do legado
1012:     *
1013:     * fChecaAcesso eh a funcao ORIGINAL do Framework Fortyus (Framework\
1014:     * sigacess.PRG, carregada pelo config.prg) - NAO reimplementar a consulta
1015:     * aqui: o modelo de acesso (SigCdAcu/SigCdAcg) concede permissao por
1016:     * usuario E por grupo, e trata o usuario interno com acesso total. A
1017:     * chamada com 2 argumentos eh FIEL ao legado: os parametros restantes
1018:     * (pMsg/pUsu/pTot) tem fallback proprio dentro da funcao.
1019:     *
1020:     * Bypass em modo teste / validacao de UI no TOPO: fChecaAcesso abre
1021:     * conexao e consulta o banco, e sem SQL Server ela trava o harness
1022:     * DENTRO do CREATEOBJECT do form.
1023:     *
1024:     * Os RETURN ficam fora de TRY/CATCH (regra #1).
1025:     *==========================================================================
1026:     PROTECTED FUNCTION PossuiAcessoOperacao(par_cOperacao)
1027:         LOCAL loc_lAcesso, loc_oErro
1028:         loc_lAcesso = .F.
1029: 
1030:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
1031:             RETURN .T.
1032:         ENDIF
1033: 
1034:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1035:             RETURN .T.
1036:         ENDIF
1037: 
1038:         TRY
1039:             loc_lAcesso = fChecaAcesso("SIGOPSTS", par_cOperacao)
1040:         CATCH TO loc_oErro
1041:             MsgErro("Erro ao verificar o acesso " + CHR(224) + " opera" + ;
1042:                 CHR(231) + CHR(227) + "o " + ALLTRIM(par_cOperacao) + ":" + CHR(13) + ;
1043:                 loc_oErro.Message, "Status das Opera" + CHR(231) + CHR(245) + "es")
1044:         ENDTRY
1045: 
1046:         RETURN loc_lAcesso
1047:     ENDFUNC
1048: 
1049:     *==========================================================================
1050:     * VincularGrade - liga grd_4c_Dados ao cursor de status, transcrevendo o
1051:     * bloco final do Init legado:
1052:     *
1053:     *   With Thisform.GradeSubN
1054:     *       .RecordSource          = 'LocalStats'
1055:     *       .Column1.ControlSource = 'LocalStats.status'
1056:     *       .Column2.ControlSource = 'LocalStats.Descs'
1057:     *       .Refresh
1058:     *   EndWith
1059:     *
1060:     * O alias eh o literal cursor_4c_Status (valor de SigOpStsBO.
1061:     * this_cCursorStatus) - INTO CURSOR do BO e RecordSource daqui precisam
1062:     * casar, e um nome fixo nos dois lados nao tem como divergir.
1063:     *
1064:     * Width / Header1.Caption / Header1.Alignment / ReadOnly sao
1065:     * REAPLICADOS depois do bind: atribuir RecordSource/ControlSource
1066:     * reseta a largura das colunas para o default 90 e o cabecalho para
1067:     * "Column1"/"Column2" (Problema 48 / regra #41). Por isso este bloco
1068:     * repete os valores de ConfigurarGrade em vez de so configura-los la.
1069:     *==========================================================================
1070:     PROTECTED PROCEDURE VincularGrade
1071:         IF !USED("cursor_4c_Status")
1072:             RETURN .F.
1073:         ENDIF
1074: 
1075:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1076:             RETURN .F.
1077:         ENDIF
1078: 
1079:         *-- RecordSource FORA do WITH: colunas nao sao recriadas de
1080:         *-- imediato dentro de um WITH, e acessar .Column1/.Column2 no
1081:         *-- mesmo bloco pode estourar "Unknown member COLUMN1"
1082:         THIS.grd_4c_Dados.RecordSource = ""
1083:         THIS.grd_4c_Dados.ColumnCount = 2
1084:         THIS.grd_4c_Dados.RecordSource = "cursor_4c_Status"
1085: 
1086:         WITH THIS.grd_4c_Dados
1087:             .Column1.ControlSource = "cursor_4c_Status.status"
1088:             .Column2.ControlSource = "cursor_4c_Status.descs"
1089: 
1090:             *-- Reaplicar o que o rebind acabou de resetar
1091:             .Column1.Width = 40
1092:             .Column2.Width = 235
1093: 
1094:             .Column1.Header1.Alignment = 2
1095:             .Column2.Header1.Alignment = 2
1096:             .Column1.Header1.Caption   = "Status"
1097:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1098: 
1099:         ENDWITH
1100: 
1101:         *-- O rebind reseta CurrentControl/Sparse e, quando o ColumnCount
1102:         *-- acima RECRIOU as Columns, o proprio controle da celula deixou de
1103:         *-- existir: reinstalar num lugar so (regra #18/#41) - ver a medicao
1104:         *-- no comentario de GarantirCelulaStatus
1105:         THIS.GarantirCelulaStatus()
1106: 
1107:         *-- ReadOnly das colunas DEPOIS do Grid (regra #46). A Column2 eh
1108:         *-- somente leitura em qualquer modo (legado: When = .f.); quem decide
1109:         *-- a Column1 eh HabilitarCampos, porque o rebind acima acabou de
1110:         *-- RESETAR o ReadOnly dela junto com Width/Caption/CurrentControl

*-- Linhas 1122 a 1165:
1122:     * editavel de status: o TextBox da classe TextBoxStatusSts_4c
1123:     * (classes\textboxgridlookup.PRG), que carrega o When/Valid/LostFocus do
1124:     * Column1.Text1 legado e o lookup contra SigStats. Os eventos moram naquela
1125:     * classe porque BINDEVENT em evento de celula de Grid nao eh confiavel
1126:     * (regra #46).
1127:     *
1128:     * Sem CurrentControl a coluna continua desenhando o Text1 dela e o controle
1129:     * novo NUNCA aparece; sem Sparse = .F. ele apareceria so na linha ativa
1130:     * (regra #18).
1131:     *
1132:     * POR QUE ISTO EH UM METODO, chamado de DOIS lugares (ConfigurarGrade e
1133:     * VincularGrade), em vez de um AddObject inline na criacao - medido no
1134:     * VFP9 em 2026-11-18:
1135:     *
1136:     *   1 form c/cursor aberto  ColumnCount=2 Column1=.T. txt_4c_Status=.T.
1137:     *   2 apos USE IN (carga)   ColumnCount=0 Column1=.F.
1138:     *   3 cursor recriado       ColumnCount=0 Column1=.F.
1139:     *   4 apos ColumnCount=2    ColumnCount=2 Column1=.T. txt_4c_Status=.F.
1140:     *                                              CurrentControl=[Text1]
1141:     *   5 CurrentModeControl    ERRO "Error with Column1 - CurrentControl :
1142:     *                                 Expression evaluated to an illegal value."
1143:     *
1144:     * A cadeia: Grid com RecordSource VAZIO auto-binda na area de trabalho
1145:     * CORRENTE (medido: o RecordSource passa de [] para [Cursor_4c_status] sem
1146:     * ninguem atribuir), e basta o cursor estar selecionado quando o form
1147:     * nasce - o que acontece ao REABRIR este dialogo, porque o cursor da vez
1148:     * anterior ficou aberto. Dai o "USE IN cursor_4c_Status" que
1149:     * SigOpStsBO.ListarStatusOperacao faz a CADA carga zera o ColumnCount, e o
1150:     * "ColumnCount = 2" do rebind recria as Columns - com isso o controle
1151:     * instalado por AddObject DESAPARECE e atribuir CurrentControl estoura.
1152:     *
1153:     * Esse erro cai no CATCH de CarregarDados: a tela ABRE, e a celula de
1154:     * lookup simplesmente nao esta mais la - a Column1 volta a desenhar o Text1
1155:     * cru, sem o When que trava a linha ja resolvida e sem o lookup contra
1156:     * SigStats, de modo que o usuario digita qualquer caractere no status. Por
1157:     * isso a instalacao tem de ser idempotente e refeita no funil de rebind, e
1158:     * nao uma vez na criacao.
1159:     *
1160:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1161:     *==========================================================================
1162:     PROTECTED FUNCTION GarantirCelulaStatus
1163:         LOCAL loc_oColuna
1164: 
1165:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)

*-- Linhas 1221 a 1477:
1221:     * falha; a tela continua abrindo (grade vazia), e a falha de SQL ja foi
1222:     * reportada por ListarStatusOperacao.
1223:     *==========================================================================
1224:     PROCEDURE CarregarDados
1225:         LOCAL loc_lSucesso, loc_oErro
1226:         loc_lSucesso = .F.
1227: 
1228:         *-- Carga eh o ponto de partida da sessao de edicao: o estado de
1229:         *-- inclusao/exclusao (lhouveins/lhouveexcl do legado, dono UNICO
1230:         *-- no BO - ver cabecalho de SigOpStsBO.prg) volta ao zero junto
1231:         *-- com os dados
1232:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1233:             THIS.this_oBusinessObject.this_lHouveInclusao = .F.
1234:             THIS.this_oBusinessObject.this_lHouveExclusao = .F.
1235:         ENDIF
1236: 
1237:         *-- A ficha da linha (as properties de entidade do BO) tambem volta ao
1238:         *-- zero aqui: a linha lida na sessao anterior nao pode vazar para esta
1239:         THIS.LimparCampos()
1240: 
1241:         TRY
1242:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1243:                 IF THIS.this_oBusinessObject.ListarStatusOperacao(THIS.this_cOperacaoPai)
1244:                     THIS.VincularGrade()
1245: 
1246:                     *-- Legado: Select LocalStats / Goto Top
1247:                     IF USED("cursor_4c_Status")
1248:                         SELECT cursor_4c_Status
1249:                         GO TOP
1250:                     ENDIF
1251: 
1252:                     *-- Legado: Thisform.GradeSubN.Refresh
1253:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1254:                         THIS.grd_4c_Dados.Refresh()
1255:                     ENDIF
1256: 
1257:                     loc_lSucesso = .T.
1258:                 ENDIF
1259:             ENDIF
1260:         CATCH TO loc_oErro
1261:             MsgErro("Erro ao carregar os status da opera" + CHR(231) + CHR(227) + ;
1262:                 "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1263:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1264:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
1265:         ENDTRY
1266: 
1267:         RETURN loc_lSucesso
1268:     ENDPROC
1269: 
1270:     *==========================================================================
1271:     * CelulaStatusEditavel - When do Column1.Text1 legado:
1272:     *
1273:     *   Return( Empty( LocalStats.status ) )
1274:     *
1275:     * So a linha AINDA SEM status aceita digitacao: a linha ja resolvida
1276:     * fica travada, e para trocar o status o usuario exclui a linha
1277:     * (cmd_4c_Excluir) e insere outra (cmd_4c_Inserir) - esse eh o desenho
1278:     * do legado, nao uma limitacao da migracao.
1279:     *
1280:     * Chamado pela celula (TextBoxStatusSts_4c.When, em
1281:     * classes\textboxgridlookup.PRG) ANTES de o usuario entrar na celula.
1282:     *
1283:     * Sem cursor ou em EOF nao ha linha nenhuma para editar - devolve .F.
1284:     * (ler .status com o ponteiro em EOF estouraria).
1285:     *
1286:     * Metodo PUBLIC (regra #3/#46): a celula o alcanca via THISFORM a
1287:     * partir de outra classe - PROTECTED faria a chamada estourar em
1288:     * runtime.
1289:     *==========================================================================
1290:     PROCEDURE CelulaStatusEditavel(par_oTxt)
1291:         IF !USED("cursor_4c_Status")
1292:             RETURN .F.
1293:         ENDIF
1294: 
1295:         IF EOF("cursor_4c_Status")
1296:             RETURN .F.
1297:         ENDIF
1298: 
1299:         RETURN EMPTY(NVL(cursor_4c_Status.status, ""))
1300:     ENDPROC
1301: 
1302:     *==========================================================================
1303:     * ValidarStatusGradeExec - Valid do Column1.Text1 legado:
1304:     *
1305:     *   Local lcOperacao, lnRecNo, loBrowse
1306:     *   lcDopes = crSigCdOpe.Dopes
1307:     *   If Not IsEmpty(This.Value)
1308:     *       xBrox = CreateObject('fwbuscaext', <conn>, 'SigStats',
1309:     *           'CrListaRemota', 'Cods', This.Value, 'Selecao', .t., 'Cods')
1310:     *       If Not xBrox.plAchouRegistro
1311:     *           xBrox.mAddColuna('Cods',  '', 'Codigo',    .t.)
1312:     *           xBrox.mAddColuna('Descs', '', 'Descricao', .t.)
1313:     *           xBrox.Show()
1314:     *       EndIf
1315:     *       This.Value = CrListaRemota.Cods
1316:     *       Replace Descs With CrListaRemota.Descs in LocalStats
1317:     *       This.Refresh
1318:     *   EndIf
1319:     *   Select LocalStats
1320:     *   Return .t.
1321:     *
1322:     * O "lcDopes = crSigCdOpe.Dopes" do legado eh leitura morta (a variavel
1323:     * nunca eh usada depois) - nao ha o que transcrever dela.
1324:     *
1325:     * Celula VAZIA nao dispara nada, igual ao legado: o usuario pode
1326:     * atravessar a linha em branco com Tab sem levar dialogo nenhum.
1327:     *
1328:     * Dentro do Valid o valor digitado esta em par_oTxt.Value - o cursor da
1329:     * grade so o recebe DEPOIS que este metodo devolve .T. (regra #46), e
1330:     * por isso ler cursor_4c_Status.status aqui validaria o valor ANTIGO.
1331:     *
1332:     * RETURN .T. sempre, igual ao legado (o "Return .t." final) - o codigo
1333:     * invalido nao prende o foco na celula; quem resolve/limpa eh o picker.
1334:     *
1335:     * Metodo PUBLIC (regra #3/#46).
1336:     *==========================================================================
1337:     PROCEDURE ValidarStatusGradeExec(par_oTxt)
1338:         IF !EMPTY(NVL(par_oTxt.Value, ""))
1339:             THIS.AbrirLookupStatusSts(par_oTxt)
1340:         ENDIF
1341: 
1342:         RETURN .T.
1343:     ENDPROC
1344: 
1345:     *==========================================================================
1346:     * AbrirLookupStatusSts - funil UNICO do lookup de status, com guarda de
1347:     * reentrancia (regra #37/#47).
1348:     *
1349:     * Tres entradas chegam aqui: o Valid da celula
1350:     * (ValidarStatusGradeExec), o F4/F5 e o duplo clique (os dois ultimos
1351:     * sao afordancia do sistema novo, como os demais lookups de grade). O
1352:     * picker eh MODAL: o Show() tira o foco da celula e pode redisparar o
1353:     * proprio evento que o abriu, empilhando um segundo dialogo - a flag
1354:     * this_lEmLookupStatus corta isso.
1355:     *
1356:     * Wrapper fino + <Nome>Exec (regra #47): a flag eh liberada AQUI, depois
1357:     * do ENDTRY, para nao travar ligada quando o corpo aborta - flag presa
1358:     * mataria o lookup pelo resto da vida do form.
1359:     *
1360:     * Metodo PUBLIC (regra #3/#46).
1361:     *==========================================================================
1362:     PROCEDURE AbrirLookupStatusSts(par_oTxt)
1363:         LOCAL loc_oErro
1364: 
1365:         *-- Guarda ANTES do TRY, para o RETURN nao ficar dentro de
1366:         *-- TRY/CATCH (regra #1)
1367:         IF THIS.this_lEmLookupStatus
1368:             RETURN
1369:         ENDIF
1370: 
1371:         THIS.this_lEmLookupStatus = .T.
1372: 
1373:         TRY
1374:             THIS.AbrirLookupStatusStsExec(par_oTxt)
1375:         CATCH TO loc_oErro
1376:             MsgErro("Erro ao buscar o status:" + CHR(13) + loc_oErro.Message + ;
1377:                 CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1378:                 "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupStatusSts")
1379:         ENDTRY
1380: 
1381:         THIS.this_lEmLookupStatus = .F.
1382:     ENDPROC
1383: 
1384:     *==========================================================================
1385:     * AbrirLookupStatusStsExec - corpo do lookup (ver o funil acima).
1386:     *
1387:     * fwbuscaext legado -> FormBuscaAuxiliar canonico do projeto, mesma
1388:     * tabela (SigStats), mesmo campo de busca (cods) e as MESMAS duas
1389:     * colunas no picker, na mesma ordem do legado (Cods/Descs). O 9o
1390:     * argumento do fwbuscaext ('Cods') eh o campo de ORDENACAO, nao filtro:
1391:     * o FormBuscaAuxiliar ja ordena pelo campo de busca, entao nao ha
1392:     * par_cFiltro a passar. par_lBuscaExata = .T. transcreve o .t. do
1393:     * legado.
1394:     *
1395:     * O alias do picker eh o literal cursor_4c_Busca (valor de
1396:     * SigOpStsBO.this_cCursorBusca, documentado la como o CrListaRemota do
1397:     * legado) - nome fixo nos dois lados nao tem como divergir.
1398:     *
1399:     * Contrato this_lAchouRegistro/this_lSelecionou (regra #37): o Init do
1400:     * FormBuscaAuxiliar ja tenta o match EXATO e, achando 1 registro,
1401:     * resolve o valor sozinho sem abrir o Show() - exatamente o
1402:     * "If Not xBrox.plAchouRegistro" do legado. O valor eh atribuido SO
1403:     * dentro da guarda this_lSelecionou.
1404:     *
1405:     * Nada selecionado -> a celula E a descricao da linha voltam a vazio.
1406:     * O legado atribui This.Value = CrListaRemota.Cods sem guarda nenhuma
1407:     * (lendo o registro em que o browse por acaso parou); aqui, deixar o
1408:     * codigo invalido na celula seria pior do que limpar, porque o When
1409:     * passaria a .F. (status nao-vazio) e a linha ficaria TRAVADA com um
1410:     * status que nao existe em SigStats - e o funil de gravacao (Fase 7)
1411:     * tentaria inserir esse codigo. Limpando, a linha continua editavel e o
1412:     * usuario digita de novo. Nao eh o caso da regra #50 (la o defeito eh
1413:     * apagar o digitado SEM abrir picker, o que impede preencher): aqui o
1414:     * picker JA foi exibido com o prefixo digitado.
1415:     *
1416:     * Legado: "Replace Descs With CrListaRemota.Descs in LocalStats" - o
1417:     * REPLACE age no registro CORRENTE do alias, que eh a linha ativa da
1418:     * grade. Aqui ele mora em BOParaForm (Fase 8), que grava descs E status
1419:     * na mesma linha: no legado o status chega ao cursor pelo bind da Column1
1420:     * quando o Valid devolve .T., e gravar os dois juntos impede a janela em
1421:     * que a linha fica com a descricao de um status e o codigo de outro.
1422:     *
1423:     * Fecha repintando (regra #21): o legado faz "This.Refresh" e a grade
1424:     * precisa redesenhar para a Column2 mostrar a descricao nova - tambem
1425:     * dentro de BOParaForm, que eh o ponto UNICO do write-back.
1426:     *
1427:     * Metodo PUBLIC (regra #3/#46).
1428:     *==========================================================================
1429:     PROCEDURE AbrirLookupStatusStsExec(par_oTxt)
1430:         LOCAL loc_cValor, loc_oBusca, loc_cCodigo, loc_cDescricao, loc_lResolveu
1431: 
1432:         loc_cValor     = ALLTRIM(NVL(par_oTxt.Value, ""))
1433:         loc_cCodigo    = ""
1434:         loc_cDescricao = ""
1435:         loc_lResolveu  = .F.
1436: 
1437:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1438:             "SigStats", "cursor_4c_Busca", "cods", loc_cValor, ;
1439:             "Sele" + CHR(231) + CHR(227) + "o", .T., .T.)
1440: 
1441:         IF VARTYPE(loc_oBusca) = "O"
1442:             *-- Legado: If Not xBrox.plAchouRegistro -> mAddColuna + Show
1443:             IF !loc_oBusca.this_lAchouRegistro
1444:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
1445:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1446:                 loc_oBusca.Show()
1447:             ENDIF
1448: 
1449:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
1450:                 SELECT cursor_4c_Busca
1451:                 loc_cCodigo    = ALLTRIM(NVL(cursor_4c_Busca.cods,  ""))
1452:                 loc_cDescricao = ALLTRIM(NVL(cursor_4c_Busca.descs, ""))
1453:                 loc_lResolveu  = !EMPTY(loc_cCodigo)
1454:             ENDIF
1455: 
1456:             loc_oBusca.Release()
1457:         ENDIF
1458: 
1459:         IF USED("cursor_4c_Busca")
1460:             USE IN cursor_4c_Busca
1461:         ENDIF
1462: 
1463:         *-- O resultado do picker volta para a linha PELA FICHA (o BO), que eh
1464:         *-- o transporte desta tela (Fase 8): FormParaBO carrega a identidade
1465:         *-- da linha corrente, o resultado do lookup sobrescreve status/descs e
1466:         *-- BOParaForm devolve os dois ao cursor, a celula e a grade. Assim o
1467:         *-- REPLACE existe em UM lugar so - duas copias do mesmo write-back
1468:         *-- poderiam divergir (uma gravando o status, a outra nao)
1469:         THIS.FormParaBO(par_oTxt)
1470: 
1471:         *-- Legado: This.Value = CrListaRemota.Cods
1472:         *--         Replace Descs With CrListaRemota.Descs in LocalStats
1473:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1474:             THIS.this_oBusinessObject.this_cStatus = IIF(loc_lResolveu, loc_cCodigo, "")
1475:             THIS.this_oBusinessObject.this_cDescs  = IIF(loc_lResolveu, loc_cDescricao, "")
1476:         ENDIF
1477: 

*-- Linhas 1500 a 1919:
1500:     *
1501:     * Metodo PUBLIC (regra #3/#46).
1502:     *==========================================================================
1503:     PROCEDURE StatusGradeLostFocus(par_oTxt)
1504:         IF EMPTY(NVL(par_oTxt.Value, "")) AND PEMSTATUS(THIS, "cmd_4c_Sair", 5)
1505:             IF THIS.cmd_4c_Sair.Visible AND THIS.cmd_4c_Sair.Enabled
1506:                 THIS.cmd_4c_Sair.SetFocus()
1507:             ENDIF
1508:         ENDIF
1509:     ENDPROC
1510: 
1511:     *==========================================================================
1512:     * ConfigurarBINDEVENTs - Fase 7: liga o Click dos tres botoes do legado
1513:     * (cmdInserir/cmdExcluir/cmdSair) aos handlers desta fase.
1514:     *
1515:     * Botao criado por AddObject nasce SEM codigo de evento: sem BINDEVENT o
1516:     * Click nunca dispara e o usuario clica sem nada acontecer.
1517:     *
1518:     * Os handlers destino sao PUBLIC (sem PROTECTED) - BINDEVENT falha em
1519:     * SILENCIO com metodo PROTECTED (regra #3).
1520:     *
1521:     * A celula da Column1 NAO entra aqui: os eventos When/Valid/LostFocus dela
1522:     * moram na classe do TextBox instalado em ConfigurarGrade
1523:     * (TextBoxStatusSts_4c), porque BINDEVENT em evento de celula de Grid nao
1524:     * eh confiavel (regra #46).
1525:     *==========================================================================
1526:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1527:         BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")
1528:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
1529:         BINDEVENT(THIS.cmd_4c_Sair,    "Click", THIS, "BtnSairClick")
1530:     ENDPROC
1531: 
1532:     *==========================================================================
1533:     * CmdInserirClick - cmdInserir.Click do legado, transcrito:
1534:     *
1535:     *   Thisform.lHouveIns = .T.
1536:     *   Select LocalStats
1537:     *   Locate for Dopes = crSigCdOpe.Dopes And status = ' '
1538:     *   If Eof()
1539:     *       Insert Into LocalStats (Dopes, CidChaves) ;
1540:     *           Values (crSigCdOpe.Dopes, fUniqueIds())
1541:     *   EndIf
1542:     *   Select LocalStats
1543:     *   Thisform.GradeSubN.Column1.SetFocus
1544:     *
1545:     * O LOCATE eh um GUARD contra linha em branco repetida: se a linha vazia
1546:     * criada na vez anterior ainda nao foi preenchida, o legado REAPROVEITA ela
1547:     * em vez de criar outra (e o LOCATE deixa o ponteiro nela, que eh onde o
1548:     * foco vai parar). Sem esse guard o usuario acumularia linhas em branco e
1549:     * seria barrado na gravacao pela validacao de duplicidade, que conta o
1550:     * status vazio junto com os demais (ver SigOpStsBO.ExisteStatusDuplicado).
1551:     *
1552:     * Grava SO no cursor LOCAL - igual ao legado, que trabalha sobre o cursor
1553:     * do pai e so persiste no Encerrar (Zap + Insert + UpDate + Commit ->
1554:     * BtnSairClick / SigOpStsBO.GravarStatus). A PK vai ja preenchida com
1555:     * fUniqueIds() (regra #22: cidchaves NUNCA em branco).
1556:     *
1557:     * O status fica vazio de proposito: eh justamente isso que faz o When da
1558:     * celula (CelulaStatusEditavel) liberar a digitacao NESTA linha e manter as
1559:     * demais travadas.
1560:     *
1561:     * O "Select LocalStats" final do legado nao precisa ser reproduzido como
1562:     * efeito colateral: a grade exibe pelo RecordSource, e este form roda na
1563:     * DataSession do PAI (DataSession = 1), onde deixar outro alias selecionado
1564:     * atrapalharia quem chamou - por isso o alias anterior eh restaurado.
1565:     *
1566:     * Column1.SetFocus() eh o que o legado chama, e Column TEM esse metodo
1567:     * (medido no VFP9 em 2026-11-17: PEMSTATUS(Column1, "SetFocus", 5) = .T.).
1568:     * NAO usar Grid.ActiveColumn = 1 no lugar: medido na mesma sessao,
1569:     * ActiveColumn eh READ-ONLY em runtime ("Property ACTIVECOLUMN is
1570:     * read-only") e derrubaria o handler.
1571:     *
1572:     * Repinta a grade antes de focar: inserir no cursor NAO repinta sozinho
1573:     * (regra #21a) e a linha nova so aparece depois do Refresh.
1574:     *
1575:     * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
1576:     *==========================================================================
1577:     PROCEDURE CmdInserirClick
1578:         LOCAL loc_cAliasAnterior, loc_cCidChaves, loc_oErro
1579: 
1580:         TRY
1581:             IF USED("cursor_4c_Status")
1582:                 *-- Legado: Thisform.lHouveIns = .T. (dono unico da flag eh o
1583:                 *-- BO - ver cabecalho de SigOpStsBO.prg)
1584:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1585:                     THIS.this_oBusinessObject.this_lHouveInclusao = .T.
1586:                 ENDIF
1587: 
1588:                 loc_cAliasAnterior = ALIAS()
1589:                 SELECT cursor_4c_Status
1590: 
1591:                 LOCATE FOR ALLTRIM(NVL(dopes, "")) == ALLTRIM(THIS.this_cOperacaoPai) ;
1592:                     AND EMPTY(NVL(status, ""))
1593: 
1594:                 IF !FOUND()
1595:                     loc_cCidChaves = LEFT(ALLTRIM(fUniqueIds()), 20)
1596: 
1597:                     INSERT INTO cursor_4c_Status (dopes, cidchaves) ;
1598:                         VALUES (THIS.this_cOperacaoPai, loc_cCidChaves)
1599:                 ENDIF
1600: 
1601:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1602:                     SELECT (loc_cAliasAnterior)
1603:                 ENDIF
1604: 
1605:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1606:                     THIS.grd_4c_Dados.Refresh()
1607: 
1608:                     *-- Column1 so existe com a grade VINCULADA: medido no
1609:                     *-- VFP9 (ver GarantirCelulaStatus), grade que perdeu o
1610:                     *-- alias fica com ColumnCount = 0 e o SetFocus estoura
1611:                     *-- "Unknown member COLUMN1" - erro cru na cara do
1612:                     *-- usuario DEPOIS de a linha ja ter sido inserida
1613:                     IF PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5)
1614:                         THIS.grd_4c_Dados.Column1.SetFocus()
1615:                     ENDIF
1616:                 ENDIF
1617:             ENDIF
1618:         CATCH TO loc_oErro
1619:             MsgErro(loc_oErro.Message + CHR(13) + ;
1620:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1621:                     "Procedure: " + loc_oErro.Procedure, ;
1622:                     "Erro em CmdInserirClick")
1623:         ENDTRY
1624:     ENDPROC
1625: 
1626:     *==========================================================================
1627:     * CmdExcluirClick - cmdExcluir.Click do legado, transcrito:
1628:     *
1629:     *   Select LocalStats
1630:     *   If Not Eof()
1631:     *       Thisform.lHouveExcl = .T.
1632:     *       Delete
1633:     *       Skip
1634:     *       Skip - 1
1635:     *   Endif
1636:     *   Thisform.GradeSubN.Refresh
1637:     *
1638:     * O legado NAO confere a operacao-pai da linha aqui (diferente do dialogo
1639:     * irmao SIGOPSQN, que testa cDopes antes de apagar) - e nao precisa: o
1640:     * cursor desta tela ja vem filtrado pela operacao-pai
1641:     * (SigOpStsBO.ListarStatusOperacao) e as linhas novas nascem com a mesma
1642:     * operacao (CmdInserirClick). Transcrito como esta: acrescentar a condicao
1643:     * aqui seria inventar regra que o legado nao tem (regra #21b).
1644:     *
1645:     * O par "Skip / Skip -1" do legado eh o que reposiciona o ponteiro numa
1646:     * linha VIVA depois da marcacao (com SET DELETED ON - fixado pelo
1647:     * config.prg - a linha marcada desaparece da grade de imediato).
1648:     *
1649:     * So MARCA a linha no cursor LOCAL: o DELETE no SQL Server acontece no
1650:     * Encerrar, e la ele eh um DELETE do conjunto INTEIRO da operacao seguido
1651:     * da reinsercao do que sobrou na grade (REPLACE-ALL - ver
1652:     * SigOpStsBO.GravarStatus), e nao um DELETE por linha.
1653:     *
1654:     * O Refresh fica FORA do IF, como no dump.
1655:     *
1656:     * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
1657:     *==========================================================================
1658:     PROCEDURE CmdExcluirClick
1659:         LOCAL loc_cAliasAnterior, loc_oErro
1660: 
1661:         TRY
1662:             IF USED("cursor_4c_Status")
1663:                 loc_cAliasAnterior = ALIAS()
1664:                 SELECT cursor_4c_Status
1665: 
1666:                 IF !EOF()
1667:                     *-- Legado: Thisform.lHouveExcl = .T. (dono unico da flag
1668:                     *-- eh o BO - ver cabecalho de SigOpStsBO.prg)
1669:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"
1670:                         THIS.this_oBusinessObject.this_lHouveExclusao = .T.
1671:                     ENDIF
1672: 
1673:                     DELETE
1674:                     SKIP
1675:                     SKIP -1
1676:                 ENDIF
1677: 
1678:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1679:                     SELECT (loc_cAliasAnterior)
1680:                 ENDIF
1681:             ENDIF
1682: 
1683:             *-- Legado: Thisform.GradeSubN.Refresh (fora do IF, como no dump)
1684:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1685:                 THIS.grd_4c_Dados.Refresh()
1686:             ENDIF
1687:         CATCH TO loc_oErro
1688:             MsgErro(loc_oErro.Message + CHR(13) + ;
1689:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1690:                     "Procedure: " + loc_oErro.Procedure, ;
1691:                     "Erro em CmdExcluirClick")
1692:         ENDTRY
1693:     ENDPROC
1694: 
1695:     *==========================================================================
1696:     * BtnSairClick - cmdSair.Click do legado ("Encerrar", Cancel = .T., logo
1697:     * tambem dispara no ESC). Transcrito:
1698:     *
1699:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
1700:     *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
1701:     *           Select LocalStats / Go Bottom / Go Top
1702:     *           <validacao: status duplicado> -> MessageBox + Return .f.
1703:     *           <Zap + Insert + Delete + UpDate + Commit, com RollBack e
1704:     *            MessageBox 'Erro na Gravacao dos Dados do Cadastro de
1705:     *            Status.'>
1706:     *       EndIf
1707:     *   ENDIF
1708:     *   Thisform.ParentForm.Enabled = .T.
1709:     *   Thisform.mCtrlBotoes(.T.)
1710:     *   ThisForm.Release
1711:     *
1712:     * FLUXO DE SAIDA - transcrito, nao "melhorado": SO a validacao de
1713:     * duplicidade aborta o fechamento (o "Return .f." do legado, que esta
1714:     * dentro do Scan dos totais); a FALHA DE GRAVACAO exibe a mensagem e FECHA
1715:     * do mesmo jeito, porque no legado o RollBack ja desfez tudo. Manter o
1716:     * dialogo aberto nesse caso convidaria a um segundo Encerrar, que repetiria
1717:     * o Delete + Insert do conjunto inteiro.
1718:     *
1719:     * Modo so-leitura (Inserir e Excluir ambos invisiveis - pai em PROCURAR ou
1720:     * usuario sem acesso): o legado NAO valida e NAO grava nada, so fecha.
1721:     * Sessao sem inclusao nem exclusao: idem - este eh o guard que faz a tela
1722:     * nao reescrever o conjunto so por ter sido aberta.
1723:     *
1724:     * "Go Bottom / Go Top" do legado forcava o cursor remoto bufferizado a
1725:     * buscar TODAS as linhas antes do TableUpdate; no cursor local nao muda
1726:     * nada, mas fica transcrito (so reposiciona o ponteiro).
1727:     *
1728:     * MsgAviso (nao MsgErro) na duplicidade: eh validacao de entrada do
1729:     * usuario, nao falha tecnica - o dialogo vermelho com "Fechar Aplicacao" do
1730:     * MsgErro/MostrarErro eh reservado a exception. A mensagem eh a do legado,
1731:     * ao pe da letra, inclusive os quatro pontos de exclamacao e o codigo do
1732:     * PRIMEIRO status repetido (this_cStatusDuplicado).
1733:     *
1734:     * A falha de gravacao NAO eh reanunciada aqui quando o BO ja a exibiu
1735:     * (this_lErroExibido - regra #20): o GravarStatus mostra o texto do legado
1736:     * junto com a mensagem real do SQL Server, que eh mais util.
1737:     *
1738:     * "ParentForm.Enabled = .T." roda no Destroy() deste form (chamado pelo
1739:     * Release()). "mCtrlBotoes(.T.)" do legado reabilita BOTOES especificos do
1740:     * pai porque la o pai ficava com os controles desabilitados um a um - aqui
1741:     * o CarregarContextoFormPai desabilita o FORM PAI INTEIRO, entao reabilitar
1742:     * o form basta e nao ha metodo equivalente a chamar (mesma decisao dos
1743:     * dialogos irmaos FormSigOpSqn/FormSigOpSlc/FormSigOpSpr).
1744:     *
1745:     * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
1746:     *==========================================================================
1747:     PROCEDURE BtnSairClick
1748:         LOCAL loc_lPodeFechar, loc_oErro
1749: 
1750:         loc_lPodeFechar = .T.
1751: 
1752:         TRY
1753:             *-- Legado: If Thisform.cmdInserir.Visible Or
1754:             *--            Thisform.cmdExcluir.Visible
1755:             *-- (a mesma leitura usada por HabilitarCampos - ver ModoEdicaoAtivo)
1756:             IF THIS.ModoEdicaoAtivo()
1757:                 IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1758:                    (THIS.this_oBusinessObject.this_lHouveExclusao OR ;
1759:                     THIS.this_oBusinessObject.this_lHouveInclusao)
1760: 
1761:                     *-- Legado: Select LocalStats / Go Bottom / Go Top
1762:                     IF USED("cursor_4c_Status")
1763:                         SELECT cursor_4c_Status
1764:                         GO BOTTOM
1765:                         GO TOP
1766:                     ENDIF
1767: 
1768:                     IF THIS.this_oBusinessObject.ExisteStatusDuplicado()
1769:                         *-- Legado: 'Status '+Alltrim(Totais.status)+
1770:                         *-- ' Digitado em Duplicidade!!!!'
1771:                         MsgAviso("Status " + ;
1772:                             ALLTRIM(THIS.this_oBusinessObject.this_cStatusDuplicado) + ;
1773:                             " Digitado em Duplicidade!!!!", ;
1774:                             "Aten" + CHR(231) + CHR(227) + "o")
1775:                         loc_lPodeFechar = .F.
1776:                     ELSE
1777:                         IF !THIS.this_oBusinessObject.GravarStatus(THIS.this_cOperacaoPai)
1778:                             *-- A base/o BO ja exibiram a falha com o texto do
1779:                             *-- SQL Server (regra #20) - so reanuncia se nao
1780:                             IF !THIS.this_oBusinessObject.this_lErroExibido
1781:                                 MsgErro("Erro na Grava" + CHR(231) + CHR(227) + ;
1782:                                     "o dos Dados do Cadastro de Status.", ;
1783:                                     "Status das Opera" + CHR(231) + CHR(245) + "es")
1784:                             ENDIF
1785:                         ENDIF
1786:                     ENDIF
1787:                 ENDIF
1788:             ENDIF
1789:         CATCH TO loc_oErro
1790:             loc_lPodeFechar = .F.
1791:             MsgErro(loc_oErro.Message + CHR(13) + ;
1792:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1793:                     "Procedure: " + loc_oErro.Procedure, ;
1794:                     "Erro em BtnSairClick")
1795:         ENDTRY
1796: 
1797:         IF loc_lPodeFechar
1798:             THIS.Release()
1799:         ENDIF
1800:     ENDPROC
1801: 
1802:     *==========================================================================
1803:     * FASE 8 - TRANSPORTE DA LINHA DA GRADE <-> BO E CONSOLIDACAO
1804:     *
1805:     * Esta tela nao tem campo nenhum fora da grade: a FICHA dela eh UMA LINHA
1806:     * de cursor_4c_Status (cidchaves/dopes/status + descs do join com
1807:     * SigStats). Por isso FormParaBO/BOParaForm transportam a LINHA CORRENTE,
1808:     * e nao um bloco de TextBox de Page2 - que esta tela nao possui.
1809:     *==========================================================================
1810: 
1811:     *==========================================================================
1812:     * ModoEdicaoAtivo - a condicao que abre o cmdSair.Click legado:
1813:     *
1814:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
1815:     *
1816:     * Eh o teste de "esta tela esta editavel nesta sessao": o Init legado
1817:     * esconde os dois botoes de linha quando o usuario nao tem acesso
1818:     * (fChecaAcesso) ou quando o pai esta em PROCURAR, e nesse caso o
1819:     * cmdSair.Click nao valida nem grava NADA - so fecha.
1820:     *
1821:     * Fonte UNICA dessa leitura (BtnSairClick e HabilitarCampos): a condicao
1822:     * do legado fica escrita em UM lugar so, em vez de repetida nos dois.
1823:     *
1824:     * Nao reconsulta fChecaAcesso: o acesso ja foi resolvido uma vez em
1825:     * AplicarVisibilidadeBotoes e esta refletido no Visible dos botoes -
1826:     * chamar a funcao do Framework de novo custaria uma ida ao banco a cada
1827:     * recarga da grade.
1828:     *
1829:     * Metodo PUBLIC (regra #3/#51): o harness de teste o alcanca de fora.
1830:     *
1831:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1832:     *==========================================================================
1833:     PROCEDURE ModoEdicaoAtivo
1834:         IF !PEMSTATUS(THIS, "cmd_4c_Inserir", 5) OR !PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
1835:             RETURN .F.
1836:         ENDIF
1837: 
1838:         RETURN (THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible)
1839:     ENDPROC
1840: 
1841:     *==========================================================================
1842:     * FormParaBO - leva a LINHA CORRENTE da grade para as properties do BO
1843:     *
1844:     * Equivale, nesta tela, ao que num form CRUD seria "ler os TextBox da
1845:     * Page2": a linha da grade EH a ficha. Preenche, na ordem do schema de
1846:     * SIGOPSTS (cidchaves char(20) / dopes char(20) / status char(1)) mais a
1847:     * descricao vinda do join (SigStats.descs char(20)):
1848:     *
1849:     *   this_cCidChaves  <- cursor_4c_Status.cidchaves   (PK gerada no Inserir)
1850:     *   this_cDopes      <- cursor_4c_Status.dopes       (operacao-pai)
1851:     *   this_cStatus     <- a CELULA, quando ela esta em edicao; senao o cursor
1852:     *   this_cDescs      <- cursor_4c_Status.descs       (exibicao, Column2)
1853:     *
1854:     * POR QUE A CELULA VENCE O CURSOR no status: dentro do Valid da celula o
1855:     * valor digitado esta em par_oTxt.Value e o cursor da grade so o recebe
1856:     * DEPOIS que o Valid devolve .T. (regra #46) - ler o cursor ali carregaria
1857:     * o valor ANTIGO. Chamado sem par_oTxt (fora de edicao), le o cursor.
1858:     *
1859:     * this_lNovoRegistro espelha a regra do When legado
1860:     * (Return( Empty( LocalStats.status ) )): linha ainda sem status eh a
1861:     * linha NOVA, criada pelo botao Inserir e nunca resolvida no lookup.
1862:     *
1863:     * Nao muda a area de trabalho corrente: le tudo qualificado pelo alias
1864:     * (cursor_4c_Status.<campo>), sem SELECT. Este form roda na DataSession do
1865:     * PAI (DataSession = 1), onde trocar o alias corrente sem necessidade
1866:     * atrapalha quem chamou.
1867:     *
1868:     * PROTECTED EXPLICITO, e nao por escolha de estilo: FormBase declara
1869:     * PROTECTED PROCEDURE FormParaBO (formbase.prg:285), e em VFP9 a subclasse
1870:     * NAO pode ALARGAR o escopo herdado - escrever o metodo sem o modificador
1871:     * nao o torna publico, so MENTE para quem le. Medido neste form em
1872:     * 2026-11-18: PEMSTATUS(oForm, "FormParaBO", 2) devolve .T. (Protected) e a
1873:     * chamada de FORA estoura "Property FORMPARABO is not found." - por isso
1874:     * so eh chamado por THIS. de dentro da classe (regra #8), a partir de
1875:     * AbrirLookupStatusStsExec.
1876:     *
1877:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1878:     *==========================================================================
1879:     PROTECTED PROCEDURE FormParaBO(par_oTxt)
1880:         LOCAL loc_cStatus
1881: 
1882:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1883:             RETURN .F.
1884:         ENDIF
1885: 
1886:         IF !USED("cursor_4c_Status")
1887:             RETURN .F.
1888:         ENDIF
1889: 
1890:         IF EOF("cursor_4c_Status")
1891:             RETURN .F.
1892:         ENDIF
1893: 
1894:         *-- Identidade e vinculo da linha: SEMPRE do cursor (a celula editavel
1895:         *-- desta grade eh so a do status)
1896:         THIS.this_oBusinessObject.this_cCidChaves = ALLTRIM(NVL(cursor_4c_Status.cidchaves, ""))
1897:         THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(NVL(cursor_4c_Status.dopes, ""))
1898: 
1899:         *-- descs so existe quando o cursor veio do join com SigStats; um
1900:         *-- cursor so com as colunas de SIGOPSTS nao tem esse campo (mesma
1901:         *-- guarda de SigOpStsBO.CarregarDoCursor)
1902:         IF TYPE("cursor_4c_Status.descs") != "U"
1903:             THIS.this_oBusinessObject.this_cDescs = ALLTRIM(NVL(cursor_4c_Status.descs, ""))
1904:         ELSE
1905:             THIS.this_oBusinessObject.this_cDescs = ""
1906:         ENDIF
1907: 
1908:         loc_cStatus = ALLTRIM(NVL(cursor_4c_Status.status, ""))
1909: 
1910:         IF VARTYPE(par_oTxt) = "O"
1911:             IF PEMSTATUS(par_oTxt, "Value", 5)
1912:                 loc_cStatus = ALLTRIM(NVL(par_oTxt.Value, ""))
1913:             ENDIF
1914:         ENDIF
1915: 
1916:         THIS.this_oBusinessObject.this_cStatus       = loc_cStatus
1917:         THIS.this_oBusinessObject.this_lNovoRegistro = EMPTY(loc_cStatus)
1918: 
1919:         RETURN .T.

*-- Linhas 1949 a 1998:
1949:     * com que o Valid legado termina.
1950:     *
1951:     * PROTECTED EXPLICITO pela MESMA razao do FormParaBO acima (FormBase
1952:     * declara PROTECTED PROCEDURE BOParaForm em formbase.prg:280): a subclasse
1953:     * nao alarga o escopo herdado, entao o metodo eh chamado por THIS. de
1954:     * dentro da classe - aqui, por AbrirLookupStatusStsExec.
1955:     *
1956:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1957:     *==========================================================================
1958:     PROTECTED PROCEDURE BOParaForm(par_oTxt)
1959:         LOCAL loc_lSucesso, loc_cStatus, loc_cDescs
1960: 
1961:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1962:             RETURN .F.
1963:         ENDIF
1964: 
1965:         loc_lSucesso = .F.
1966:         loc_cStatus  = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cStatus, "")), 1)
1967:         loc_cDescs   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDescs, "")), 20)
1968: 
1969:         IF USED("cursor_4c_Status")
1970:             *-- Legado: Select LocalStats (fica corrente no fim, como no dump)
1971:             SELECT cursor_4c_Status
1972: 
1973:             IF !EOF()
1974:                 *-- Legado: Replace Descs With CrListaRemota.Descs in LocalStats
1975:                 *-- (o status tambem entra aqui: no legado quem o grava eh o
1976:                 *-- bind da Column1 quando o Valid devolve .T., e gravar os
1977:                 *-- dois juntos impede que a linha fique com codigo de um
1978:                 *-- status e descricao de outro)
1979:                 REPLACE status WITH loc_cStatus, ;
1980:                         descs  WITH loc_cDescs
1981:                 loc_lSucesso = .T.
1982:             ENDIF
1983:         ENDIF
1984: 
1985:         *-- Legado: This.Value = CrListaRemota.Cods / This.Refresh
1986:         IF VARTYPE(par_oTxt) = "O"
1987:             IF PEMSTATUS(par_oTxt, "Value", 5)
1988:                 par_oTxt.Value = loc_cStatus
1989:                 par_oTxt.Refresh()
1990:             ENDIF
1991:         ENDIF
1992: 
1993:         *-- Regra #21: gravar no cursor nao repinta a grade
1994:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1995:             THIS.grd_4c_Dados.Refresh()
1996:         ENDIF
1997: 
1998:         RETURN loc_lSucesso

*-- Linhas 2018 a 2111:
2018:     * zeradas aqui, uma a uma, com o valor-tipo de cada coluna.
2019:     *
2020:     * PROTECTED EXPLICITO pela MESMA razao do FormParaBO/BOParaForm (FormBase
2021:     * declara PROTECTED PROCEDURE LimparCampos em formbase.prg:276): a
2022:     * subclasse nao alarga o escopo herdado, entao eh chamado por THIS. de
2023:     * dentro da classe - aqui, por CarregarDados.
2024:     *==========================================================================
2025:     PROTECTED PROCEDURE LimparCampos
2026:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2027:             THIS.this_oBusinessObject.LimparDados()
2028: 
2029:             THIS.this_oBusinessObject.this_cCidChaves    = ""
2030:             THIS.this_oBusinessObject.this_cDopes        = ""
2031:             THIS.this_oBusinessObject.this_cStatus       = ""
2032:             THIS.this_oBusinessObject.this_cDescs        = ""
2033:             THIS.this_oBusinessObject.this_lNovoRegistro = .F.
2034: 
2035:             *-- Resultado da ultima checagem de duplicidade: sem isto, o
2036:             *-- codigo repetido de uma tentativa de Encerrar reapareceria na
2037:             *-- mensagem da tentativa seguinte
2038:             THIS.this_oBusinessObject.this_cStatusDuplicado = ""
2039:         ENDIF
2040:     ENDPROC
2041: 
2042:     *==========================================================================
2043:     * HabilitarCampos - abre ou fecha a edicao da tela
2044:     *
2045:     * O legado nao tem um metodo com este nome: ele decide a editabilidade em
2046:     * dois lugares - a visibilidade de cmdInserir/cmdExcluir no Init
2047:     * (fChecaAcesso + pcEscolha, ver AplicarVisibilidadeBotoes) e o
2048:     * When = Empty(LocalStats.status) da celula. Este metodo eh o ponto UNICO
2049:     * onde esse resultado eh aplicado aos controles, e existe por um motivo
2050:     * concreto: o rebind da grade (VincularGrade) RESETA Column.ReadOnly junto
2051:     * com Width/Caption/CurrentControl (Problema 48 / regra #41), entao a cada
2052:     * recarga a trava da Column1 tem de ser reaplicada. Reatribuir .F. ali
2053:     * destravaria a celula tambem no modo so-leitura do pai - e quem desabilita
2054:     * tem de reabilitar no FUNIL, nunca so no caminho de ida (regra #40).
2055:     *
2056:     * Sem argumento, deriva o estado de ModoEdicaoAtivo() - a mesma condicao
2057:     * que abre o cmdSair.Click legado.
2058:     *
2059:     * Botao INVISIVEL nao eh reabilitado: Inserir/Excluir escondidos por
2060:     * fChecaAcesso continuam Enabled = .F., senao esta reabilitacao
2061:     * atropelaria o controle de acesso que o Init do legado aplicou.
2062:     *
2063:     * cmd_4c_Sair fica SEMPRE habilitado: com TitleBar = 0 e ControlBox = .F.
2064:     * ele eh a unica saida da tela, e desabilita-lo prenderia o usuario.
2065:     *
2066:     * A Column2 nao aparece aqui: ela eh somente leitura em qualquer modo
2067:     * (legado: When = .f.) e quem a trava eh VincularGrade.
2068:     *
2069:     * Metodo PUBLIC (regra #3/#51): o harness de teste o alcanca de fora.
2070:     *==========================================================================
2071:     PROCEDURE HabilitarCampos(par_lHabilitar)
2072:         LOCAL loc_lHabilitar
2073: 
2074:         *-- PCOUNT() eh OBRIGATORIO aqui: em VFP9 parametro declarado e NAO
2075:         *-- passado chega como .F. LOGICO, entao VARTYPE(par_lHabilitar) = "L"
2076:         *-- eh verdade tanto para "nao passou" quanto para "passou .F." - o
2077:         *-- guard so por VARTYPE fazia HabilitarCampos() SEM argumento travar a
2078:         *-- celula em vez de derivar o modo. Medido neste form em 2026-11-18:
2079:         *-- com o guard por VARTYPE, Column1.ReadOnly ficava .T. ao abrir a
2080:         *-- tela em modo editavel (compila limpo, nao estoura, nao entra em log)
2081:         loc_lHabilitar = THIS.ModoEdicaoAtivo()
2082: 
2083:         IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
2084:             loc_lHabilitar = par_lHabilitar
2085:         ENDIF
2086: 
2087:         *-- Column1 (status): ReadOnly da COLUNA depois do Grid (regra #46).
2088:         *-- Column1 so existe com a grade VINCULADA - grade que perdeu o alias
2089:         *-- fica com ColumnCount = 0 (ver a medicao em GarantirCelulaStatus) e
2090:         *-- tocar .Column1 ali estouraria "Unknown member COLUMN1"
2091:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2092:             IF PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5)
2093:                 THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lHabilitar
2094:             ENDIF
2095:         ENDIF
2096: 
2097:         *-- Botoes de linha: so o que o controle de acesso deixou VISIVEL
2098:         IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
2099:             THIS.cmd_4c_Inserir.Enabled = loc_lHabilitar AND THIS.cmd_4c_Inserir.Visible
2100:         ENDIF
2101: 
2102:         IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
2103:             THIS.cmd_4c_Excluir.Enabled = loc_lHabilitar AND THIS.cmd_4c_Excluir.Visible
2104:         ENDIF
2105: 
2106:         *-- Unica saida da tela - nunca desabilitada
2107:         IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
2108:             THIS.cmd_4c_Sair.Enabled = .T.
2109:         ENDIF
2110:     ENDPROC
2111: 

*-- Linhas 2126 a 2198:
2126:     * HabilitarCampos nao eh chamado aqui de novo: AplicarVisibilidadeBotoes
2127:     * ja o chama no fim, para que a trava da celula acompanhe os botoes.
2128:     *==========================================================================
2129:     PROCEDURE AjustarBotoesPorModo
2130:         THIS.AplicarVisibilidadeBotoes()
2131:     ENDPROC
2132: 
2133:     *==========================================================================
2134:     * CarregarLista - nome canonico do projeto para a carga da grade de lista,
2135:     * apontando para o funil real desta tela: CarregarDados, que transcreve o
2136:     * bloco de consulta/bind/Refresh do Init legado.
2137:     *
2138:     * A grade desta tela (GradeSubN -> grd_4c_Dados) eh a unica lista que
2139:     * existe aqui, e carrega-la eh exatamente o que CarregarDados faz - um
2140:     * segundo caminho de carga duplicaria a consulta e as duas poderiam
2141:     * divergir. Mesma razao do AjustarBotoesPorModo acima: o caminho canonico
2142:     * precisa alcancar a logica real, e ela eh unica.
2143:     *
2144:     * Devolve o mesmo .T./.F. de CarregarDados (.F. quando o BO ainda nao
2145:     * existe ou a consulta falha - a tela continua aberta com a grade vazia).
2146:     *
2147:     * Metodo PUBLIC (regra #3/#51): o harness de teste o alcanca de fora.
2148:     *==========================================================================
2149:     PROCEDURE CarregarLista
2150:         RETURN THIS.CarregarDados()
2151:     ENDPROC
2152: 
2153:     *==========================================================================
2154:     * TornarControlesVisiveis - AddObject cria controle com Visible = .F.;
2155:     * percorre recursivamente o container e torna tudo visivel. Cada form
2156:     * tem a propria copia deste metodo (nao esta no FormBase).
2157:     *==========================================================================
2158:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2159:         LOCAL loc_nI, loc_oControl
2160: 
2161:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2162:             loc_oControl = par_oContainer.Controls(loc_nI)
2163:             IF VARTYPE(loc_oControl) = "O"
2164:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2165:                     loc_oControl.Visible = .T.
2166:                 ENDIF
2167:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
2168:                    loc_oControl.ControlCount > 0
2169:                     THIS.TornarControlesVisiveis(loc_oControl)
2170:                 ENDIF
2171:             ENDIF
2172:         ENDFOR
2173:     ENDPROC
2174: 
2175:     *==========================================================================
2176:     * Destroy - Reabilita o form pai ao fechar este dialogo (legado:
2177:     * cmdSair.Click faz .ParentForm.Enabled = .t. + mCtrlBotoes(.T.) antes
2178:     * do ThisForm.Release; aqui tambem fica como rede de seguranca para
2179:     * qualquer caminho de fechamento que nao passe pelo botao Encerrar -
2180:     * ESC/fechamento externo).
2181:     *
2182:     * mCtrlBotoes nao eh reproduzido: esta tela desabilita o FORM PAI
2183:     * INTEIRO (CarregarContextoFormPai), o que ja produz o efeito
2184:     * pretendido e eh MAIS correto - o legado forcava Enabled = .T. em
2185:     * todos os botoes no retorno, atropelando o estado que o modo do pai
2186:     * tinha definido (mesma decisao dos dialogos irmaos FormSigOpSqn/
2187:     * FormSigOpSlc/FormSigOpSpr).
2188:     *==========================================================================
2189:     PROCEDURE Destroy
2190:         IF VARTYPE(THIS.this_oFormPai) = "O"
2191:             THIS.this_oFormPai.Enabled = .T.
2192:             THIS.this_oFormPai         = .NULL.
2193:         ENDIF
2194: 
2195:         DODEFAULT()
2196:     ENDPROC
2197: 
2198: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpStsBO.prg):
*==============================================================================
* SigOpStsBO.prg - Business Object para "Status por Operacoes" (SIGOPSTS)
*
* Origem legado : SigOpSts.SCX  (tasks\task808)
* Tipo de form  : OPERACIONAL (dialogo FILHO, chamado pela Lista do form pai
*                 SigCdOpe - Cadastro de Operacoes)
* Tabela base   : SIGOPSTS | PK: cidchaves
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo filho que mantem a lista de STATUS permitidos para UMA operacao-pai
* (crSigCdOpe.Dopes). O legado recebe no Init "poForm" (o form pai),
* "pnDataSes" (DataSession do pai) e "pcEscolha" (INSERIR/ALTERAR/PROCURAR),
* troca para a DataSession do pai, DESABILITA os botoes do pai
* (mCtrlBotoes(.F.)) e popula um cursor local com:
*
*   Select a.*, b.Descs From SIGOPSTS a, SigStats b
*    Where a.Dopes = '<operacao-pai>' And a.Status = b.cods
*
* A grade (GradeSubN) tem 2 colunas:
*   Column1 -> status (TextBox EDITAVEL com lookup em SigStats.Cods;
*              When = Empty(LocalStats.status), ou seja so a linha NOVA,
*              ainda sem status, aceita digitacao)
*   Column2 -> Descs  (TextBox com When = .F. - somente leitura, a descricao
*              vem do lookup e nao eh digitada)
* Botoes: Inserir (acrescenta UMA linha em branco e foca a Column1),
* Excluir (Delete da linha corrente do cursor) e Encerrar (valida duplicidade,
* grava, reabilita os botoes do pai e fecha).
*
* GRAVACAO - eh REPLACE-ALL, nao linha-a-linha (regra do legado, transcrita)
* ---------------------------------------------------------------------------
* O cmdSair.Click do legado so grava quando (a) Inserir OU Excluir estao
* visiveis (ou seja, o pai esta em INSERIR/ALTERAR) E (b) houve inclusao ou
* exclusao na sessao do dialogo (lHouveIns Or lHouveExcl). Nessa condicao ele:
*   1) valida duplicidade - "Select status, sum(1) as TT From LocalStats
*      Group By 1" e, achando TT > 1, avisa
*      "Status <X> Digitado em Duplicidade!!!!" e ABORTA a gravacao
*      (Return .f. - o dialogo NAO fecha);
*   2) reconstroi o conjunto inteiro: Zap no cursor remoto + um Insert por
*      linha do cursor local, PULANDO (Loop) as linhas com status em branco,
*      sempre com Dopes = <operacao-pai> e CidChaves = fUniqueIds();
*   3) persiste dentro de transacao: Delete From SIGOPSTS Where Dopes =
*      '<operacao-pai>' -> UpDate do cursor -> Commit, com RollBack em
*      qualquer falha e a mensagem
*      "Erro na Gravacao dos Dados do Cadastro de Status.".
* Quem faz os passos 1 a 3 eh ESTE BO (ExisteStatusDuplicado / GravarStatus):
* sao regra de negocio e acesso a dados, nao UI. O form so decide QUANDO
* chamar (clique do Encerrar) e exibe o que o BO devolver.
*
* ESTADO DA SESSAO - DONO UNICO EH ESTE BO
* ----------------------------------------
* lHouveIns / lHouveExcl do legado viram this_lHouveInclusao /
* this_lHouveExclusao AQUI, e nao no form. Motivo: quem decide se grava eh a
* regra de gravacao acima, que mora neste BO; duas copias (uma no form, uma
* no BO) divergem em silencio e o Encerrar passa a ler a copia errada - ou
* grava sem alteracao nenhuma, ou nao grava o que o usuario mexeu, sem erro
* na tela. O form ESCREVE nessas duas properties nos mesmos pontos do legado
* (BtnInserirClick / BtnExcluirClick) e NAO declara copias proprias.
*
* CONTROLE DE ACESSO FICA NO FORM
* -------------------------------
* fChecaAcesso('SIGOPSTS','INSERIR') / fChecaAcesso('SIGOPSTS','EXCLUIR') do
* Init legado decidem Visible/Enabled de cmdInserir/cmdExcluir - isso eh UI e
* fica no form (que tambem combina com this_cEscolha e redimensiona o Shape1,
* igual ao legado). O BO guarda apenas o CONTEXTO recebido do pai
* (this_cOperacaoPai / this_cEscolha / this_nDataSessionPai).
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas no MaxLength dos controles,
* no LEFT() dos comandos SQL e no dimensionamento do cursor da grade
* ---------------------------------------------------------------------------
*   SIGOPSTS.cidchaves  char(20)      NOT NULL  (PK - fUniqueIds())
*   SIGOPSTS.dopes      char(20)      NOT NULL  (FK SigCdOpe.dopes)
*   SIGOPSTS.status     char(1)       NOT NULL  (FK SigStats.cods)
*   SigStats.cods       char(1)       NOT NULL  (codigo do status - lookup)
*   SigStats.descs      char(20)      NOT NULL  (descricao do status)
*   SigStats.chkvisivel numeric(1,0)  NOT NULL
*   SigCdOpe.dopes      char(20)      NOT NULL  (PK e descricao ao mesmo
*                        tempo - SigCdOpe eh single-column, NUNCA usar
*                        descrs/Descs nessa tabela)
*
* As TRES colunas de SIGOPSTS sao NOT NULL e a tabela nao tem outras colunas,
* portanto o INSERT desta entidade cobre a tabela inteira (regra #22).
*==============================================================================

DEFINE CLASS SigOpStsBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - uma linha de status da operacao (SIGOPSTS)
    *--------------------------------------------------------------------------
    this_cCidChaves        = ""   && cidchaves char(20) NOT NULL - PK (gerada com fUniqueIds())
    this_cDopes            = ""   && dopes     char(20) NOT NULL - operacao-pai (FK SigCdOpe.dopes)
    this_cStatus           = ""   && status    char(1)  NOT NULL - codigo do status (FK SigStats.cods)

    *--------------------------------------------------------------------------
    * DESCRICAO DO STATUS - SigStats.descs char(20)
    *
    * NAO pertence a SIGOPSTS: vem do join com SigStats (b.Descs do SELECT do
    * Init legado) e alimenta a Column2 da grade, que eh somente leitura
    * (When = .F.). Entra no cursor da grade e nas properties para a tela
    * poder exibir, mas NUNCA no INSERT/UPDATE de SIGOPSTS.
    *--------------------------------------------------------------------------
    this_cDescs            = ""   && descs     char(20) NOT NULL em SigStats (exibicao)

    *--------------------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI
    * Legado: Init(poForm, pnDataSes, pcEscolha) + crSigCdOpe.Dopes
    *--------------------------------------------------------------------------
    this_cOperacaoPai      = ""   && crSigCdOpe.Dopes - operacao corrente na Lista do pai (char(20))
    this_cEscolha          = ""   && pcEscolha do pai: INSERIR / ALTERAR / PROCURAR
    this_nDataSessionPai   = 0    && pnDataSes do legado (DataSessionId do form pai)

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO (dono unico - ver cabecalho)
    * Legado: propriedades customizadas lhouveins / lhouveexcl do SIGOPSTS
    *--------------------------------------------------------------------------
    this_lHouveInclusao    = .F.  && lhouveins  - o usuario acrescentou linha nesta sessao
    this_lHouveExclusao    = .F.  && lhouveexcl - o usuario excluiu linha nesta sessao

    *--------------------------------------------------------------------------
    * RESULTADO DA VALIDACAO DE DUPLICIDADE
    *
    * Guarda o codigo de status repetido encontrado no cursor da grade, para o
    * form montar a mensagem do legado "Status <X> Digitado em Duplicidade!!!!"
    * com o MESMO codigo que o legado mostraria (Alltrim(Totais.status)).
    *--------------------------------------------------------------------------
    this_cStatusDuplicado  = ""   && codigo do status repetido (vazio = sem duplicidade)

    *--------------------------------------------------------------------------
    * QUANTAS LINHAS O ULTIMO LOTE DE GRAVACAO INSERE
    *
    * MontarLoteGravacao a preenche; GravarStatus a le para saber quantas
    * chaves de loc_aChaves sao validas (VFP nao devolve dois valores, e o
    * array ja eh o parametro por referencia). Zero eh resultado LEGITIMO: o
    * usuario apagou todas as linhas e o lote fica so com o DELETE.
    *--------------------------------------------------------------------------
    this_nLinhasLote       = 0

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR
    * (nomes do legado entre parenteses - o PILAR 3 manda renomear)
    *--------------------------------------------------------------------------
    this_cCursorStatus     = "cursor_4c_Status"   && LocalStats    - linhas de SIGOPSTS da operacao-pai + Descs (grade, READWRITE)
    this_cCursorBusca      = "cursor_4c_Busca"    && CrListaRemota - universo do lookup da Column1 (SigStats: Cods/Descs)
    this_cCursorTotais     = "cursor_4c_Totais"   && Totais        - agrupamento por status usado na checagem de duplicidade

    *--------------------------------------------------------------------------
    * ListarStatusOperacao (Fase 4) - popula this_cCursorStatus
    * (cursor_4c_Status) com o join de SIGOPSTS x SigStats da operacao-pai,
    * equivalente ao Sqlexecute(lcSql, 'LocalStats') do Init legado. Eh o
    * que alimenta a grade do form (FormSigOpSts.CarregarDados). Ver o
    * metodo abaixo para o detalhamento completo.
    *
    * ExisteStatusDuplicado / GravarStatus (Fase 7) - os passos 1 a 3 do
    * cmdSair.Click legado descritos no cabecalho do arquivo: a validacao de
    * duplicidade sobre o cursor da grade e o REPLACE-ALL transacional em
    * SIGOPSTS. Chamados por FormSigOpSts.BtnSairClick ("Encerrar"), que eh o
    * unico ponto de gravacao desta tela. Ver os metodos abaixo.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de persistencia (SIGOPSTS.cidchaves) e repoe o
    * estado inicial da sessao do dialogo, que no legado eh o estado do form
    * recem-criado: nenhuma inclusao e nenhuma exclusao ainda ocorridas, e
    * nenhuma duplicidade detectada.
    *
    * NAO chama fChecaAcesso aqui: a permissao eh decidida no form (ver
    * cabecalho) e a funcao real do Framework legado abre conexao SQL, o que
    * tornaria a simples criacao do BO dependente de banco.
    *
    * NAO passa a tabela para o DODEFAULT(): BusinessBase.Init(pcTabela) so
    * usa o parametro para instanciar um DataAccess, e esta entidade eh
    * gravada por comandos SQL proprios (replace-all em transacao), igual ao
    * legado.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SIGOPSTS"
        THIS.this_cCampoChave = "cidchaves"

        THIS.this_nDataSessionPai  = 0
        THIS.this_lHouveInclusao   = .F.
        THIS.this_lHouveExclusao   = .F.
        THIS.this_cStatusDuplicado = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades de uma linha de status
    * (SIGOPSTS) a partir de um cursor posicionado nessa linha (cursor
    * cursor_4c_Status, populado pelo join com SigStats, ou qualquer outro
    * cursor/SELECT que inclua as mesmas colunas).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDopes     = TratarNulo(dopes,     "C")
                THIS.this_cStatus    = TratarNulo(status,    "C")

                *-- Descs vem do JOIN com SigStats (b.Descs do Init legado),
                *-- nao de SIGOPSTS - so existe quando o cursor foi montado
                *-- com o join (cursor_4c_Status); um cursor so com as
                *-- colunas de SIGOPSTS nao tem esse campo.
                IF TYPE(par_cAliasCursor + ".descs") != "U"
                    THIS.this_cDescs = TratarNulo(descs, "C")
                ELSE
                    THIS.this_cDescs = ""
                ENDIF

                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ListarStatusOperacao - Popula cursor_4c_Status com as linhas de
    * SIGOPSTS da operacao-pai, equivalente ao legado:
    *
    *   lcSql = [Select a.*,b.Descs From SIGOPSTS a, SigStats b Where
    *            a.Dopes = '<operacao-pai>' And a.Status = b.cods]
    *   ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalStats')
    *
    * O join com SigStats (igualdade a.Status = b.cods) so traz linhas com
    * status JA preenchido e valido - igual ao legado, cujas linhas em
    * branco inseridas pelo botao Inserir NAO vem desta consulta: elas sao
    * criadas DIRETO no cursor local (CmdInserirClick), nunca
    * reconsultadas aqui.
    *
    * Cursor READWRITE (NAO o cursor cru do SQLEXEC, que nasce somente-
    * leitura): a Column1 da grade (status) eh editavel nas linhas sem
    * status ainda (regra do legado When = Empty(status)) e os botoes
    * Inserir/Excluir inserem e apagam linha direto no cursor
    * local, igual ao legado (Insert Into LocalStats / Delete). Sem
    * READWRITE a celula nem entra em edicao e o REPLACE/INSERT estoura.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ListarStatusOperacao(par_cOperacaoPai)
        LOCAL loc_cOperacaoPai, loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")

        *-- Sem conexao nao ha o que consultar (probe/harness sem config.prg):
        *-- SQLEXEC com handle invalido dispara excecao em vez de devolver -1
        IF TYPE("gnConnHandle") != "N"
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.dopes, a.status, b.descs" + ;
                       " FROM SIGOPSTS a" + ;
                       " INNER JOIN SigStats b ON a.status = b.cods" + ;
                       " WHERE a.dopes = " + EscaparSQL(loc_cOperacaoPai)

            IF USED("cursor_4c_StatusTmp")
                USE IN cursor_4c_StatusTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_StatusTmp")

            IF loc_nResultado >= 0
                *-- USE IN fecha o alias mesmo com buffer sujo - sem
                *-- TABLEREVERT, que exige buffering e ERRA no cursor de
                *-- Buffering = 1 (regra #52)
                IF USED("cursor_4c_Status")
                    USE IN cursor_4c_Status
                ENDIF

                SELECT * FROM cursor_4c_StatusTmp INTO CURSOR cursor_4c_Status READWRITE
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar os status da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_StatusTmp")
                USE IN cursor_4c_StatusTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpStsBO.ListarStatusOperacao:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteStatusDuplicado - 1a validacao do cmdSair.Click legado:
    *
    *   Select status,sum(1) as TT From LocalStats GROUP by 1 Into cursor Totais
    *   Select Totais
    *   Scan
    *       If TT > 1
    *           MessageBox('Status '+Alltrim(Totais.status)+ ;
    *                      ' Digitado em Duplicidade!!!!',0+16,'Atencao')
    *           Return .f.
    *       EndIf
    *   EndScan
    *
    * Guarda em this_cStatusDuplicado o codigo do PRIMEIRO status repetido: o
    * "Return .f." do legado esta DENTRO do Scan, portanto ele para no primeiro
    * grupo com TT > 1 e eh esse codigo que aparece na mensagem. Guardar a
    * lista inteira mudaria a mensagem da tela.
    *
    * TRANSCRICAO LITERAL (regra #17): o "GROUP by 1" agrupa pela coluna 1
    * (status) SEM excluir o status em branco, logo DUAS linhas novas ainda sem
    * status tambem contam como duplicidade - e a mensagem sai com o codigo
    * vazio ("Status  Digitado em Duplicidade!!!!"). Esse eh o comportamento da
    * tela e NAO se "conserta" aqui: eh ele que impede o usuario de acumular
    * varias linhas em branco na grade.
    *
    * Linha marcada para exclusao NAO entra: SET DELETED ON (config.prg) a
    * esconde do SELECT, igual ao legado.
    *
    * O alias corrente eh salvo e restaurado: este dialogo roda na DataSession
    * do form pai (DataSession = 1), onde deixar outro alias selecionado
    * atrapalharia quem chamou.
    *
    * Metodo PUBLIC (regra #51): quem o chama eh o Encerrar do form, de fora
    * desta classe - PROTECTED faria a chamada estourar em runtime.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ExisteStatusDuplicado()
        LOCAL loc_cAliasAnterior, loc_lDuplicado

        THIS.this_cStatusDuplicado = ""

        IF !USED(THIS.this_cCursorStatus)
            RETURN .F.
        ENDIF

        loc_lDuplicado     = .F.
        loc_cAliasAnterior = ALIAS()

        IF USED(THIS.this_cCursorTotais)
            USE IN (THIS.this_cCursorTotais)
        ENDIF

        SELECT status, SUM(1) AS tt ;
            FROM (THIS.this_cCursorStatus) ;
            GROUP BY 1 ;
            INTO CURSOR (THIS.this_cCursorTotais) READWRITE

        *-- Legado: Scan / If TT > 1 -> mensagem com ESTE status e para
        SELECT (THIS.this_cCursorTotais)
        SCAN
            IF tt > 1
                THIS.this_cStatusDuplicado = ALLTRIM(NVL(status, ""))
                loc_lDuplicado = .T.
                EXIT
            ENDIF
        ENDSCAN

        IF USED(THIS.this_cCursorTotais)
            USE IN (THIS.this_cCursorTotais)
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarLoteGravacao - monta o LOTE SQL unico do REPLACE-ALL de
    * GravarStatus (ver o comentario daquele metodo para o legado completo) e
    * devolve, em par_aChaves, as PKs que o lote insere; this_nLinhasLote diz
    * quantas posicoes do array sao validas.
    *
    * Transcreve duas coisas do legado, nesta ordem:
    *   1. "Delete From SIGOPSTS Where Dopes = '<op>'" - INCONDICIONAL, e
    *      ANTES dos inserts, para nao apagar o que acabou de entrar. Lote so
    *      com o DELETE eh resultado LEGITIMO: eh o usuario que apagou todas as
    *      linhas da grade.
    *   2. "Scan / Scatter Memvar / If Empty(m.status) -> Loop / Insert Into
    *      CrSIGOPSTS (Dopes,status,CidChaves)" - uma linha por status
    *      PREENCHIDO, descartando a linha em branco que o botao Inserir criou
    *      e o usuario nao completou (status eh char(1) NOT NULL - regra #22).
    *      Linha marcada para exclusao nao entra: SET DELETED ON a esconde do
    *      SCAN, igual ao legado.
    *
    * Envelope transacional em T-SQL, num SQLEXEC unico (nao em SQLEXEC
    * separados): a conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1,
    * entao BEGIN/COMMIT avulsos so ANINHAM e o COMMIT nao efetiva. SAVE
    * TRANSACTION cobre o caso (normal) de ja haver transacao aberta, e o THROW
    * faz o erro chegar ao SQLEXEC, que devolve -1 e deixa CapturarErroSQL()
    * com a mensagem real.
    *
    * EXTRAIDO de GravarStatus de proposito: assim o TEXTO do lote pode ser
    * conferido sem banco (o SQL Server deste projeto eh inalcancavel da
    * maquina do pipeline), e a montagem - que eh a regra do legado - fica
    * separada da execucao/transacao, que eh infraestrutura.
    *
    * PROTECTED: eh peca interna de GravarStatus, nao se chama de fora (regra
    * #51); o harness de teste a alcanca por SUBCLASSE.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarLoteGravacao(par_cOperacaoPai, par_aChaves)
        LOCAL loc_cStmts, loc_cStatus, loc_cCidChaves, loc_cOperacaoPai, ;
              loc_cAliasAnterior

        THIS.this_nLinhasLote = 0
        loc_cStmts            = ""
        loc_cOperacaoPai      = LEFT(IIF(VARTYPE(par_cOperacaoPai) = "C", ;
                                         par_cOperacaoPai, ""), 20)

        IF USED(THIS.this_cCursorStatus)
            loc_cAliasAnterior = ALIAS()
            SELECT (THIS.this_cCursorStatus)

            SCAN
                loc_cStatus = LEFT(ALLTRIM(NVL(status, "")), 1)

                IF !EMPTY(loc_cStatus)
                    *-- cidchaves eh a PK Fortyus (regra #22): SEMPRE gerada
                    *-- com fUniqueIds(), nunca em branco - o legado tambem a
                    *-- regera a cada linha do Zap/Insert
                    loc_cCidChaves = LEFT(ALLTRIM(fUniqueIds()), 20)

                    THIS.this_nLinhasLote = THIS.this_nLinhasLote + 1
                    DIMENSION par_aChaves[THIS.this_nLinhasLote]
                    par_aChaves[THIS.this_nLinhasLote] = loc_cCidChaves

                    loc_cStmts = loc_cStmts + ;
                        "INSERT INTO SIGOPSTS (cidchaves, dopes, status) VALUES (" + ;
                        EscaparSQL(loc_cCidChaves) + ", " + ;
                        EscaparSQL(loc_cOperacaoPai) + ", " + ;
                        EscaparSQL(loc_cStatus) + "); "
                ENDIF
            ENDSCAN

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDIF

        RETURN "SET NOCOUNT ON; " + ;
            "DECLARE @nivel int = @@TRANCOUNT; " + ;
            "IF @nivel = 0 BEGIN TRANSACTION " + ;
            "ELSE SAVE TRANSACTION Sts4c; " + ;
            "BEGIN TRY " + ;
            "DELETE FROM SIGOPSTS WHERE dopes = " + ;
            EscaparSQL(loc_cOperacaoPai) + "; " + ;
            loc_cStmts + ;
            "IF @nivel = 0 COMMIT TRANSACTION; " + ;
            "END TRY " + ;
            "BEGIN CATCH " + ;
            "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END " + ;
            "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Sts4c; END; " + ;
            "THROW; " + ;
            "END CATCH"
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarStatus - persiste a lista de status da operacao-pai. Equivale ao
    * bloco de gravacao do cmdSair.Click legado, que eh um REPLACE-ALL:
    *
    *   Select CrSIGOPSTS
    *   Zap
    *   Select LocalStats
    *   Scan
    *       Scatter Memvar
    *       If Empty(m.status)
    *           Loop
    *       Endif
    *       Insert Into CrSIGOPSTS (Dopes,status,CidChaves) Values ;
    *           (CrSigCdOpe.Dopes,m.status,fUniqueIds())
    *   EndScan
    *   m.lnErro1 = ThisForm.ParentForm.poDatamgr.pnIdConn
    *   If m.lnErro1>0 : lcDelete = [Delete From SIGOPSTS Where Dopes = '<op>']
    *                    m.lnErro1 = Iif(.poDataMgr.SqlExecute(lcDelete,'')>0,1,-1)
    *   If m.lnErro1>0 : m.lnErro1 = Iif(.poDataMgr.UpDate('crSIGOPSTS'),1,-1)
    *   If m.lnErro1>0 : m.lnErro1 = .poDataMgr.Commit()
    *   If Not m.lnErro1>0 : .poDataMgr.RollBack()
    *   If Not m.lnErro1>0 : MessageBox('Erro na Gravacao dos Dados do
    *                                   Cadastro de Status.',48)
    *
    * O "Zap + Scan + Insert" enche a view remota com o conjunto NOVO INTEIRO
    * (toda linha fica nova, logo o UpDate manda INSERT) e o Delete apaga o
    * conjunto ANTIGO: o efeito liquido eh SUBSTITUIR todos os status da
    * operacao. Por isso o DELETE eh INCONDICIONAL e roda mesmo quando nao
    * sobrou nenhuma linha com status preenchido - o usuario que apagou todas
    * as linhas da grade quer a operacao sem status nenhum, e um "nada a
    * gravar" ali engoliria essa intencao em silencio.
    *
    * "If Empty(m.status) / Loop" eh o descarte da linha em branco: a linha que
    * o botao Inserir criou e o usuario nao preencheu NAO vai para o banco
    * (status eh char(1) NOT NULL - regra #22).
    *
    * ATOMICIDADE: o legado faz Delete + N Inserts numa UNICA transacao. Mandar
    * BEGIN/COMMIT TRANSACTION em SQLEXEC separados NAO protege nada - a
    * conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1, entao o par
    * so ANINHA e o COMMIT nao efetiva. Por isso o lote INTEIRO vai num SQLEXEC
    * unico, com o controle de transacao em T-SQL e SAVE TRANSACTION para o
    * caso (normal) de ja haver transacao aberta. O THROW faz o erro chegar ao
    * SQLEXEC, que devolve -1 e deixa CapturarErroSQL() com a mensagem real.
    * Mesmo lote canonico de SigOpNchBO.GravarNumeracao.
    *
    * O Commit() do legado eh um PASSO COM CAMINHO DE FALHA PROPRIO, nao
    * detalhe de infra (o legado o testa separadamente do UpDate): reproduzido
    * com SQLCOMMIT/SQLROLLBACK, inertes quando a conexao esta em auto-commit.
    * IF ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)" - VFP9 nao faz
    * curto-circuito e chamaria o commit do mesmo jeito.
    *
    * As duas flags de sessao sao ZERADAS no sucesso: elas sao o guard que faz
    * o Encerrar gravar UMA vez ("If (lHouveExcl Or lHouveIns)" do legado). No
    * legado o dialogo fecha logo apos gravar e nao existe um segundo Encerrar;
    * zerar aqui garante o mesmo efeito - um segundo Encerrar com a grade
    * intacta nao repetiria Delete + Insert (que regravaria o MESMO conjunto
    * com cidchaves novas e poluiria a auditoria).
    *
    * A auditoria (LogAuditoria, exigencia do sistema novo - o legado nao a
    * tem) roda DEPOIS do commit, uma linha por status efetivamente gravado, e
    * nunca dentro do lote: o lote eh montado para ser atomico sobre SIGOPSTS e
    * a auditoria nao pode poder derruba-lo.
    *
    * Metodo PUBLIC (regra #51): chamado pelo Encerrar do form.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION GravarStatus(par_cOperacaoPai)
        LOCAL loc_cOperacaoPai, loc_cAliasAnterior, loc_nLinhas, loc_cLote, ;
              loc_nResultado, loc_lManual, loc_cErro, loc_lSucesso, loc_oErro
        LOCAL ARRAY loc_aChaves[1]

        loc_lSucesso = .F.
        loc_lManual  = .F.
        loc_nLinhas  = 0
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C" AND ;
                               !EMPTY(par_cOperacaoPai), par_cOperacaoPai, ;
                               THIS.this_cOperacaoPai)

        *-- Sem operacao-pai o DELETE apagaria o conjunto de OUTRA operacao (a
        *-- de codigo em branco): recusar eh o unico caminho seguro
        IF EMPTY(loc_cOperacaoPai)
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o informada."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        *-- SQLEXEC com handle invalido dispara excecao em vez de devolver -1
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        TRY
            loc_lManual        = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            loc_cAliasAnterior = ALIAS()

            *-- Monta o lote e devolve em loc_aChaves as PKs que ele insere
            loc_cLote   = THIS.MontarLoteGravacao(loc_cOperacaoPai, @loc_aChaves)
            loc_nLinhas = THIS.this_nLinhasLote

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cLote)

            IF loc_nResultado < 0
                loc_cErro = CapturarErroSQL()

                IF loc_lManual
                    = SQLROLLBACK(gnConnHandle)
                ENDIF

                THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                    "o dos Dados do Cadastro de Status." + CHR(13) + loc_cErro
                MsgErro(THIS.this_cMensagemErro, "Erro")
                THIS.this_lErroExibido = .T.
            ELSE
                *-- Commit do legado (.poDataMgr.Commit())
                loc_lSucesso = .T.

                IF loc_lManual
                    IF SQLCOMMIT(gnConnHandle) < 1
                        = SQLROLLBACK(gnConnHandle)
                        THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + ;
                            CHR(227) + "o dos Dados do Cadastro de Status." + ;
                            CHR(13) + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        THIS.this_lErroExibido = .T.
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.RegistrarAuditoriaLote(@loc_aChaves, loc_nLinhas)

                    *-- O guard do Encerrar volta ao zero: o conjunto no banco
                    *-- passou a ser exatamente o da grade
                    THIS.this_lHouveInclusao = .F.
                    THIS.this_lHouveExclusao = .F.
                ENDIF
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF

        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF

            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro em SigOpStsBO.GravarStatus:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoriaLote - grava em LogAuditoria uma linha por status
    * efetivamente gravado pelo lote de GravarStatus.
    *
    * RegistrarAuditoria do BusinessBase le a chave por ObterChavePrimaria(),
    * que devolve this_cCidChaves - por isso a property eh posicionada em cada
    * volta do laco e restaurada no fim (o chamador nao pode perceber que ela
    * foi usada como variavel de laco).
    *
    * Roda DEPOIS do commit, nunca dentro do lote: o lote eh montado para ser
    * atomico sobre SIGOPSTS e a auditoria nao pode poder derruba-lo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoriaLote(par_aChaves, par_nLinhas)
        LOCAL loc_nI, loc_cCidChavesAnterior, loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_nLinhas) = "N" AND par_nLinhas > 0
            loc_cCidChavesAnterior = THIS.this_cCidChaves

            FOR loc_nI = 1 TO par_nLinhas
                THIS.this_cCidChaves = par_aChaves[loc_nI]
                THIS.RegistrarAuditoria("INSERT")
            ENDFOR

            THIS.this_cCidChaves = loc_cCidChavesAnterior
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inclui uma nova linha de status (SIGOPSTS) no banco.
    * Equivalente ao trecho do legado cmdSair.Click que, dentro da transacao
    * de GravarStatus, faz "Insert Into SIGOPSTS (Dopes, Status, CidChaves)
    * Values (<operacao-pai>, <status>, fUniqueIds())" para cada linha do
    * cursor local com status preenchido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- cidchaves eh a PK Fortyus (regra #22): gerar com fUniqueIds(),
            *-- NUNCA deixar vazia - senao o proximo registro colide no indice unico
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SIGOPSTS (cidchaves, dopes, status)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       EscaparSQL(THIS.this_cStatus) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsSts")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir status da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsSts")
                USE IN cursor_4c_InsSts
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpStsBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de status (SIGOPSTS) ja existente.
    * As tres colunas da entidade sao NOT NULL (regra #22) - o UPDATE regrava
    * dopes e status pela chave cidchaves.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SIGOPSTS SET" + ;
                       " dopes  = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " status = " + EscaparSQL(THIS.this_cStatus) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdSts")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar status da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdSts")
                USE IN cursor_4c_UpdSts
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpStsBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

